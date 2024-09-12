/// Returns true if [value] is a power of two.
bool isPowerOfTwo(int value) {
  return value > 0 && (value & (value - 1)) == 0;
}
