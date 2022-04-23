@IsTest
class FieldExtensionsTest {

  @IsTest
  static void wasUpdated () {
    UpdateHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();
    System.assert(extensions.wasUpdated());
  }

  @IsTest
  static void updatedFromAnyOf () {
    UpdateHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_OLD_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.updatedFromAnyOf(correctValues));
    System.assert(!extensions.updatedFromAnyOf(wrongValues));
  }

  @IsTest
  static void updatedFrom () {
    UpdateHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();
    System.assert(extensions.updatedFrom(TestingHelper.ACCOUNT_OLD_NAME));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME));
  }

  @IsTest
  static void updatedToAnyOf () {
    UpdateHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_NEW_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.updatedToAnyOf(correctValues));
    System.assert(!extensions.updatedToAnyOf(wrongValues));
  }

  @IsTest
  static void updatedTo () {
    UpdateHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();
    System.assert(extensions.updatedTo(TestingHelper.ACCOUNT_NEW_NAME));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME));
  }

  @IsTest
  static void wasAnyOf () {
    UpdateHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_OLD_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.wasAnyOf(correctValues));
    System.assert(!extensions.wasAnyOf(wrongValues));
  }

  @IsTest
  static void was () {
    UpdateHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();
    System.assert(extensions.was(TestingHelper.ACCOUNT_OLD_NAME));
    System.assert(!extensions.was(TestingHelper.ACCOUNT_WRONG_NAME));
  }

  @IsTest
  static void isAnyOf () {
    UpdateHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_NEW_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.isAnyOf(correctValues));
    System.assert(!extensions.isAnyOf(wrongValues));
  }

  @IsTest
  static void is () {
    UpdateHelper.FieldExtensions extensions = TestingHelper.getFieldExtensions();
    System.assert(extensions.is(TestingHelper.ACCOUNT_NEW_NAME));
    System.assert(!extensions.is(TestingHelper.ACCOUNT_WRONG_NAME));
  }

  @IsTest
  static void callFromUpdateHelper () {
    CoreHelper.TriggerScope ts = TestingHelper.getTriggerScope();
    ts.isUpdate = true;
    TestingHelper.stubCoreHelper(ts);

    Id recordId = ts.oldMap.values().get(0).Id;
    UpdateHelper.FieldExtensions extensions = UpdateHelper.of(recordId).field(Account.Name);

    List<String> oldValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_OLD_NAME);
    List<String> newValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_NEW_NAME);

    System.assert(extensions.wasUpdated());
    System.assert(extensions.updatedFromAnyOf(oldValues));
    System.assert(extensions.updatedFrom(TestingHelper.ACCOUNT_OLD_NAME));
    System.assert(extensions.updatedToAnyOf(newValues));
    System.assert(extensions.updatedTo(TestingHelper.ACCOUNT_NEW_NAME));
    System.assert(extensions.wasAnyOf(oldValues));
    System.assert(extensions.was(TestingHelper.ACCOUNT_OLD_NAME));
    System.assert(extensions.isAnyOf(newValues));
    System.assert(extensions.is(TestingHelper.ACCOUNT_NEW_NAME));
  }

}
