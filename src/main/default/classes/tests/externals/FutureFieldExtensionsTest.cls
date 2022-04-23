@IsTest
class FutureFieldExtensionsTest {

  @IsTest
  static void wasUpdated () {
    UpdateHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.Scope scope = TestingHelper.getUpdateHelperScope();

    System.assert(!extensions.wasUpdated().run(scope));

    scope.triggerScope.isUpdate = true;

    System.assert(extensions.wasUpdated().run(scope));
  }

  @IsTest
  static void updatedFromAnyOf () {
    UpdateHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.Scope scope = TestingHelper.getUpdateHelperScope();

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
    UpdateHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.Scope scope = TestingHelper.getUpdateHelperScope();

    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_OLD_NAME).run(scope));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));

    scope.triggerScope.isUpdate = true;

    System.assert(extensions.updatedFrom(TestingHelper.ACCOUNT_OLD_NAME).run(scope));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));
  }

  @IsTest
  static void updatedToAnyOf () {
    UpdateHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.Scope scope = TestingHelper.getUpdateHelperScope();

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
    UpdateHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.Scope scope = TestingHelper.getUpdateHelperScope();

    System.assert(!extensions.updatedTo(TestingHelper.ACCOUNT_NEW_NAME).run(scope));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));

    scope.triggerScope.isUpdate = true;

    System.assert(extensions.updatedTo(TestingHelper.ACCOUNT_NEW_NAME).run(scope));
    System.assert(!extensions.updatedFrom(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));
  }

  @IsTest
  static void wasAnyOf () {
    UpdateHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.Scope scope = TestingHelper.getUpdateHelperScope();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_OLD_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.wasAnyOf(correctValues).run(scope));
    System.assert(!extensions.wasAnyOf(wrongValues).run(scope));
  }

  @IsTest
  static void was () {
    UpdateHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.Scope scope = TestingHelper.getUpdateHelperScope();
    System.assert(extensions.was(TestingHelper.ACCOUNT_OLD_NAME).run(scope));
    System.assert(!extensions.was(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));
  }

  @IsTest
  static void isAnyOf () {
    UpdateHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.Scope scope = TestingHelper.getUpdateHelperScope();

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_NEW_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    System.assert(extensions.isAnyOf(correctValues).run(scope));
    System.assert(!extensions.isAnyOf(wrongValues).run(scope));
  }

  @IsTest
  static void is () {
    UpdateHelper.FutureFieldExtensions extensions = TestingHelper.getFutureFieldExtensions();
    UpdateHelper.Scope scope = TestingHelper.getUpdateHelperScope();
    System.assert(extensions.is(TestingHelper.ACCOUNT_NEW_NAME).run(scope));
    System.assert(!extensions.is(TestingHelper.ACCOUNT_WRONG_NAME).run(scope));
  }

}
