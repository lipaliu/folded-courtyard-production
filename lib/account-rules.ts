// Required values only: account length and password complexity are user choices.
export function validateUsername(value: string) {
  return typeof value === 'string' && value.trim().length > 0;
}

export function validatePassword(value: string) {
  return typeof value === 'string' && value.length > 0;
}
