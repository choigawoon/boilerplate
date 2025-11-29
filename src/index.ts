/**
 * A simple hello function for demonstration
 * @param name - Optional name to greet
 * @returns A greeting message
 */
export function hello(name?: string): string {
  if (name) {
    return `Hello, ${name}!`;
  }
  return 'Hello, World!';
}
