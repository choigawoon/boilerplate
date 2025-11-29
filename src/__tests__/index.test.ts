import { describe, it, expect } from 'vitest';
import { hello } from '../index';

describe('hello', () => {
  it('should return "Hello, World!" when called without arguments', () => {
    const result = hello();
    expect(result).toBe('Hello, World!');
  });

  it('should return personalized greeting when name is provided', () => {
    const result = hello('Alice');
    expect(result).toBe('Hello, Alice!');
  });

  it('should handle empty string', () => {
    const result = hello('');
    expect(result).toBe('Hello, World!');
  });

  it('should handle special characters in name', () => {
    const result = hello('世界');
    expect(result).toBe('Hello, 世界!');
  });
});
