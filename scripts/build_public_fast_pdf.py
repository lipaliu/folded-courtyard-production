#!/usr/bin/env python3
"""Build a lightweight landscape art-review PDF from the public review API."""

from __future__ import annotations

import argparse
import io
import json
import re
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont, ImageOps


PAGE = (1400, 990)
BG = (8, 15, 23)
PANEL = (17, 27, 38)
WHITE = (242, 244, 246)
MUTED = (155, 165, 177)
CYAN = (84, 214, 239)
ORANGE = (255, 116, 88)


def font(size: int, bold: bool = False):
    candidates = [
        "/System/Library/Fonts/PingFang.ttc",
        "/System/Library/Fonts/STHeiti Medium.ttc" if bold else "/System/Library/Fonts/STHeiti Light.ttc",
        "/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc",
    ]
    for candidate in candidates:
        if Path(candidate).exists():
            return ImageFont.truetype(candidate, size=size, index=0)
    return ImageFont.load_default()


FONTS = {size: font(size, size >= 32) for size in (18, 20, 22, 26, 32, 38, 48, 68)}


def wrap(draw: ImageDraw.ImageDraw, text: str, max_width: int, selected_font) -> list[str]:
    lines, current = [], ""
    for char in text.strip():
        candidate = current + char
        if current and draw.textbbox((0, 0), candidate, font=selected_font)[2] > max_width:
            lines.append(current)
            current = char
        else:
            current = candidate
    if current:
        lines.append(current)
    return lines


def text_block(draw, xy, text, selected_font, fill, max_width, max_lines=4, gap=6):
    x, y = xy
    lines = wrap(draw, text, max_width, selected_font)[:max_lines]
    line_height = selected_font.size + gap
    for index, line in enumerate(lines):
        if index == max_lines - 1 and len(wrap(draw, text, max_width, selected_font)) > max_lines:
            line = line[:-1] + "…"
        draw.text((x, y + index * line_height), line, font=selected_font, fill=fill)
    return y + len(lines) * line_height


def fetch_json(url: str):
    request = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0 FoldedCourtyardPDF/1.0"})
    with urllib.request.urlopen(request, timeout=45) as response:
        return json.load(response)


def fetch_thumb(url: str):
    try:
        request = urllib.request.Request(url, headers={"User-Agent": "FoldedCourtyardPDF/1.0"})
        with urllib.request.urlopen(request, timeout=45) as response:
            raw = response.read()
        image = Image.open(io.BytesIO(raw)).convert("RGB")
        image.thumbnail((1100, 720), Image.Resampling.LANCZOS)
        return image.copy()
    except Exception:
        return None


def embedded(name: str) -> bool:
    return bool(re.match(r"^(闪回|回忆|蒙太奇|一组镜头|一组画面)\s*\d*\s*[｜|]", name.strip()))


def character(name: str) -> str:
    for person in ("顾丽乔", "陆文川", "沈糯", "前夫", "群演", "助理", "导演"):
        if person in name:
            return person
    return re.split(r"[｜|（(:：]", name)[0].strip()


def item_rank(item):
    if embedded(item["name"]):
        return (1, item.get("sortOrder", 0), "")
    if item["category"] == "场景":
        rank = 0
    elif item["category"] == "道具":
        rank = 900
    elif "历史服装" in item["name"]:
        rank = 850
    elif character(item["name"]) == "顾丽乔":
        rank = 10
    elif character(item["name"]) == "陆文川":
        rank = 20
    elif re.search(r"群演|整体参考", item["name"]):
        rank = 800
    else:
        rank = 100
    return (0, rank, character(item["name"]))


def reuse_key(item):
    if re.match(r"^(本场|其他|新增|临时|全部|配角与群演|历史)", item["name"]):
        return ""
    return f'{item["category"]}:{character(item["name"]) if item["category"] == "人物" else re.sub(r"｜(?:服装|场景图)$", "", item["name"]).strip()}'


def base_page(background_path: Path | None = None):
    page = Image.new("RGB", PAGE, BG)
    if background_path and background_path.exists():
        background = Image.open(background_path).convert("RGB")
        background = ImageOps.fit(background, PAGE, Image.Resampling.LANCZOS)
        overlay = Image.new("RGB", PAGE, BG)
        page = Image.blend(background, overlay, 0.82)
    return page


def footer(draw, episode, number):
    draw.line((60, 930, 1340, 930), fill=(58, 71, 83), width=1)
    draw.text((60, 946), f"《折叠庭院的她》 · {episode} · 美术提报", font=FONTS[18], fill=MUTED)
    draw.text((1270, 946), str(number), font=FONTS[18], fill=MUTED)


def cover(data, background_path):
    page = base_page(background_path)
    draw = ImageDraw.Draw(page)
    draw.text((700, 255), "VISUAL REVIEW", font=FONTS[22], fill=ORANGE, anchor="mm")
    draw.text((700, 360), "折叠庭院的她", font=FONTS[68], fill=WHITE, anchor="mm")
    draw.text((700, 445), f'{data["episode"]} · 美术提报', font=FONTS[38], fill=WHITE, anchor="mm")
    draw.rounded_rectangle((340, 540, 1060, 665), radius=24, fill=(4, 10, 16), outline=(58, 71, 83), width=2)
    draw.text((430, 585), f'{len(data.get("analyses", []))} 场', font=FONTS[32], fill=CYAN)
    draw.text((635, 585), f'{len(data.get("items", []))} 项', font=FONTS[32], fill=CYAN)
    draw.text((835, 585), f'{len(data.get("files", []))} 张图', font=FONTS[32], fill=CYAN)
    footer(draw, data["episode"], 1)
    return page


def reuse_page(data, analysis, item, source_scene, page_number, background_path):
    page = base_page(background_path)
    draw = ImageDraw.Draw(page)
    header(draw, data, analysis, item)
    draw.rounded_rectangle((175, 260, 1225, 780), radius=32, fill=(10, 43, 54), outline=(34, 113, 132), width=2)
    draw.text((700, 390), "CONTINUITY REUSE", font=FONTS[22], fill=CYAN, anchor="mm")
    draw.text((700, 520), f"与第{source_scene}场一样", font=FONTS[68], fill=WHITE, anchor="mm")
    draw.text((700, 620), "沿用来源场次整组参考，本场不重复铺图。", font=FONTS[26], fill=MUTED, anchor="mm")
    footer(draw, data["episode"], page_number)
    return page


def header(draw, data, analysis, item, continuation=""):
    draw.text((60, 48), f'{data["episode"]} · 第{analysis["sceneNo"]}场 · {item["category"]}', font=FONTS[20], fill=ORANGE)
    title = analysis.get("location") or analysis.get("sceneTitle") if item["category"] == "场景" else item["name"]
    draw.text((60, 86), title, font=FONTS[38], fill=WHITE)
    if continuation:
        draw.text((1260, 96), continuation, font=FONTS[20], fill=MUTED, anchor="ra")
    draw.line((60, 145, 1340, 145), fill=(58, 71, 83), width=2)


def item_page(data, analysis, item, files, thumbs, page_number, part, total_parts, background_path):
    page = base_page(background_path)
    draw = ImageDraw.Draw(page)
    header(draw, data, analysis, item, f"{part}/{total_parts}" if total_parts > 1 else "")
    draw.rounded_rectangle((60, 170, 1340, 900), radius=20, fill=PANEL, outline=(52, 64, 76), width=1)
    text_block(draw, (88, 192), item.get("detail", ""), FONTS[20], MUTED, 1220, 2)
    count = max(1, len(files))
    columns = 1 if count == 1 else 2
    rows = (count + columns - 1) // columns
    cell_w = 1240 if columns == 1 else 610
    cell_h = 570 if rows == 1 else 285
    start_x, start_y = 80, 285
    for index, file in enumerate(files):
        col, row = index % columns, index // columns
        x, y = start_x + col * 630, start_y + row * cell_h
        draw.rounded_rectangle((x, y, x + cell_w, y + cell_h - 12), radius=16, fill=(4, 10, 16), outline=(58, 71, 83), width=1)
        image = thumbs.get(file["id"])
        if image:
            image_height = cell_h - 76
            fitted = ImageOps.contain(image, (cell_w - 24, image_height), Image.Resampling.LANCZOS)
            page.paste(fitted, (x + (cell_w - fitted.width) // 2, y + 8 + (image_height - fitted.height) // 2))
        else:
            draw.text((x + cell_w // 2, y + (cell_h - 70) // 2), "图片读取失败", font=FONTS[20], fill=MUTED, anchor="mm")
        draw.text((x + 14, y + cell_h - 60), f"Option {(part - 1) * 4 + index + 1}", font=FONTS[18], fill=WHITE)
        draw.text((x + 150, y + cell_h - 60), f'上传人：{file.get("uploadedBy") or "历史资料"}', font=FONTS[18], fill=CYAN)
    footer(draw, data["episode"], page_number)
    return page


def build(api_base: str, episode: str, output: Path, background_path: Path | None, max_per_page: int, quality: int):
    api = f"{api_base.rstrip('/')}/api/public/art-review?episode={urllib.parse.quote(episode)}"
    data = fetch_json(api)
    if data.get("error"):
        raise RuntimeError(data["error"])
    analyses = sorted(data.get("analyses", []), key=lambda row: row["sceneNo"])
    analysis_by_id = {row["id"]: row for row in analyses}
    files_by_item = {}
    for file in data.get("files", []):
        file["url"] = urllib.parse.urljoin(api_base, file["url"])
        files_by_item.setdefault(file["itemId"], []).append(file)
    ordered_items = sorted(data.get("items", []), key=lambda item: (analysis_by_id[item["analysisId"]]["sceneNo"], item.get("sortOrder", 0)))
    reuse = {}
    previous = []
    for item in ordered_items:
        if not files_by_item.get(item["id"]) and reuse_key(item):
            for source in reversed(previous):
                source_scene = analysis_by_id[source["analysisId"]]
                target_scene = analysis_by_id[item["analysisId"]]
                if source_scene["sceneNo"] < target_scene["sceneNo"] and reuse_key(source) == reuse_key(item):
                    source_files = files_by_item.get(source["id"]) or (reuse.get(source["id"], {}) or {}).get("files", [])
                    if source_files:
                        origin = reuse.get(source["id"])
                        reuse[item["id"]] = {"scene": origin["scene"] if origin else source_scene["sceneNo"], "files": source_files}
                        break
        previous.append(item)
    direct_files = [file for item in ordered_items if item["id"] not in reuse for file in files_by_item.get(item["id"], [])]
    thumbs = {}
    with ThreadPoolExecutor(max_workers=12) as pool:
        futures = {pool.submit(fetch_thumb, file["url"]): file["id"] for file in direct_files}
        for future in as_completed(futures):
            thumbs[futures[future]] = future.result()
    pages = [cover(data, background_path)]
    page_number = 2
    for analysis in analyses:
        scene_items = sorted([item for item in data.get("items", []) if item["analysisId"] == analysis["id"]], key=item_rank)
        for item in scene_items:
            if item["id"] in reuse:
                pages.append(reuse_page(data, analysis, item, reuse[item["id"]]["scene"], page_number, background_path))
                page_number += 1
                continue
            item_files = files_by_item.get(item["id"], [])
            if not item_files:
                continue
            groups = [item_files[index:index + max_per_page] for index in range(0, len(item_files), max_per_page)]
            for part, group in enumerate(groups, 1):
                pages.append(item_page(data, analysis, item, group, thumbs, page_number, part, len(groups), background_path))
                page_number += 1
    output.parent.mkdir(parents=True, exist_ok=True)
    pages[0].save(output, "PDF", save_all=True, append_images=pages[1:], resolution=120, quality=quality, optimize=True)
    print(json.dumps({"output": str(output), "pages": len(pages), "bytes": output.stat().st_size, "images": len(direct_files)}, ensure_ascii=False))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--base", default="https://folded-courtyard-production-web.pages.dev")
    parser.add_argument("--episode", default="第1集")
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--background", type=Path)
    parser.add_argument("--max-per-page", type=int, default=4)
    parser.add_argument("--quality", type=int, default=88)
    args = parser.parse_args()
    build(args.base, args.episode, args.output, args.background, max(1, min(args.max_per_page, 4)), max(60, min(args.quality, 95)))
