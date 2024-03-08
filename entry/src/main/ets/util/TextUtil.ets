export class TextUtil {
  static isEmpty(str?: string): boolean {
    return str == null || str.length === 0
  }
}