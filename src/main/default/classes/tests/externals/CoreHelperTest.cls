@IsTest
class CoreHelperTest {

  @IsTest
  static void caseSensitiveEqualityCheck () {
    System.assert(CoreHelper.caseSensitiveEqualityCheck(null, null));
    System.assert(CoreHelper.caseSensitiveEqualityCheck(1, 1));
    System.assert(CoreHelper.caseSensitiveEqualityCheck('a', 'a'));
    System.assert(!CoreHelper.caseSensitiveEqualityCheck('a', 'A'));
    System.assert(!CoreHelper.caseSensitiveEqualityCheck(null, 1));
  }

  @IsTest
  static void anyOf () {
    System.assert(CoreHelper.anyOf(null, new Object[] { null, false }));
    System.assert(CoreHelper.anyOf(1, new Object[] { 1, false }));
    System.assert(CoreHelper.anyOf('a', new Object[] { 'a', false }));
    System.assert(!CoreHelper.anyOf('a', new Object[] { 'A', false }));
    System.assert(!CoreHelper.anyOf(null, new Object[] { 1, false }));
  }

  @IsTest
  static void falseIfNull () {
    System.assert(!CoreHelper.falseIfNull(null));
    System.assert(CoreHelper.falseIfNull(new Account()));
  }

}
