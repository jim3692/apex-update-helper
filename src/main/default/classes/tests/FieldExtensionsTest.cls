@IsTest
class FieldExtensionsTest {

  @IsTest
  static void wasUpdated () {
    CoreHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();
    System.assert(extensions.wasUpdated());
  }

  @IsTest
  static void updatedFromAnyOf () {
    CoreHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_OLD_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.updatedFromAnyOf(correctValues));
    System.assert(!extensions.updatedFromAnyOf(wrongValues));
  }

  @IsTest
  static void updatedFrom () {
    CoreHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();
    System.assert(extensions.updatedFrom(TestingHelper.ACCOUNT_OLD_NAME));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME));
  }

  @IsTest
  static void updatedToAnyOf () {
    CoreHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_NEW_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.updatedToAnyOf(correctValues));
    System.assert(!extensions.updatedToAnyOf(wrongValues));
  }

  @IsTest
  static void updatedTo () {
    CoreHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();
    System.assert(extensions.updatedTo(TestingHelper.ACCOUNT_NEW_NAME));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME));
  }

  @IsTest
  static void wasAnyOf () {
    CoreHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_OLD_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.wasAnyOf(correctValues));
    System.assert(!extensions.wasAnyOf(wrongValues));
  }

  @IsTest
  static void was () {
    CoreHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();
    System.assert(extensions.was(TestingHelper.ACCOUNT_OLD_NAME));
    System.assert(!extensions.was(TestingHelper.ACCOUNT_WRONG_NAME));
  }

  @IsTest
  static void isAnyOf () {
    CoreHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_NEW_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.isAnyOf(correctValues));
    System.assert(!extensions.isAnyOf(wrongValues));
  }

  @IsTest
  static void is () {
    CoreHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();
    System.assert(extensions.is(TestingHelper.ACCOUNT_NEW_NAME));
    System.assert(!extensions.is(TestingHelper.ACCOUNT_WRONG_NAME));
  }

}
