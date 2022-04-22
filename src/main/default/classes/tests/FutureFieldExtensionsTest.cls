@IsTest
class FutureFieldExtensionsTest {

  @IsTest
  static void wasUpdated () {
    CoreHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.UpdateHelperScope scope = TestingHelper.getUpdateHelperScope();

    System.assert(!extensions.wasUpdated().run(scope));

    scope.triggerScope.isUpdate = true;

    System.assert(extensions.wasUpdated().run(scope));
  }

  @IsTest
  static void updatedFromAnyOf () {
    CoreHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.UpdateHelperScope scope = TestingHelper.getUpdateHelperScope();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_OLD_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(!extensions.updatedFromAnyOf(correctValues).run(scope));
    System.assert(!extensions.updatedFromAnyOf(wrongValues).run(scope));

    scope.triggerScope.isUpdate = true;

    System.assert(extensions.updatedFromAnyOf(correctValues).run(scope));
    System.assert(!extensions.updatedFromAnyOf(wrongValues).run(scope));
  }

  @IsTest
  static void updatedFrom () {
    CoreHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.UpdateHelperScope scope = TestingHelper.getUpdateHelperScope();

    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_OLD_NAME).run(scope));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));

    scope.triggerScope.isUpdate = true;

    System.assert(extensions.updatedFrom(TestingHelper.ACCOUNT_OLD_NAME).run(scope));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));
  }

  @IsTest
  static void updatedToAnyOf () {
    CoreHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.UpdateHelperScope scope = TestingHelper.getUpdateHelperScope();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_NEW_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(!extensions.updatedToAnyOf(correctValues).run(scope));
    System.assert(!extensions.updatedToAnyOf(wrongValues).run(scope));

    scope.triggerScope.isUpdate = true;

    System.assert(extensions.updatedToAnyOf(correctValues).run(scope));
    System.assert(!extensions.updatedToAnyOf(wrongValues).run(scope));
  }

  @IsTest
  static void updatedTo () {
    CoreHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.UpdateHelperScope scope = TestingHelper.getUpdateHelperScope();

    System.assert(!extensions.updatedTo(TestingHelper.ACCOUNT_NEW_NAME).run(scope));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));

    scope.triggerScope.isUpdate = true;

    System.assert(extensions.updatedTo(TestingHelper.ACCOUNT_NEW_NAME).run(scope));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));
  }

  @IsTest
  static void wasAnyOf () {
    CoreHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.UpdateHelperScope scope = TestingHelper.getUpdateHelperScope();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_OLD_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.wasAnyOf(correctValues).run(scope));
    System.assert(!extensions.wasAnyOf(wrongValues).run(scope));
  }

  @IsTest
  static void was () {
    CoreHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.UpdateHelperScope scope = TestingHelper.getUpdateHelperScope();
    System.assert(extensions.was(TestingHelper.ACCOUNT_OLD_NAME).run(scope));
    System.assert(!extensions.was(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));
  }

  @IsTest
  static void isAnyOf () {
    CoreHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.UpdateHelperScope scope = TestingHelper.getUpdateHelperScope();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_NEW_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.isAnyOf(correctValues).run(scope));
    System.assert(!extensions.isAnyOf(wrongValues).run(scope));
  }

  @IsTest
  static void is () {
    CoreHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.UpdateHelperScope scope = TestingHelper.getUpdateHelperScope();
    System.assert(extensions.is(TestingHelper.ACCOUNT_NEW_NAME).run(scope));
    System.assert(!extensions.is(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));
  }

}
