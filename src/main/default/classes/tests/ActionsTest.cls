@IsTest
class ActionsTest {
  @IsTest
  static void fieldExtensionsActionIs () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_IS_ANY_OF;

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_NEW_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    CoreHelper.FieldExtensionsScope fesCorrect = TestingHelper.getFieldExtensionsScope(correctValues);
    fesCorrect.helperScope.triggerScope.isUpdate = false;
    System.assert(action.run(fesCorrect));

    CoreHelper.FieldExtensionsScope fesWrong = TestingHelper.getFieldExtensionsScope(wrongValues);
    fesCorrect.helperScope.triggerScope.isUpdate = false;
    System.assert(!action.run(fesWrong));

    CoreHelper.FieldExtensionsScope fesCorrectIsUpdate = TestingHelper.getFieldExtensionsScope(correctValues);
    fesCorrectIsUpdate.helperScope.triggerScope.isUpdate = true;
    System.assert(action.run(fesCorrectIsUpdate));

    CoreHelper.FieldExtensionsScope fesWrongIsUpdate = TestingHelper.getFieldExtensionsScope(wrongValues);
    fesWrongIsUpdate.helperScope.triggerScope.isUpdate = true;
    System.assert(!action.run(fesWrongIsUpdate));
  }

  @IsTest
  static void fieldExtensionsActionUpdatedFrom () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_UPDATED_FROM_ANY_OF;

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_OLD_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    CoreHelper.FieldExtensionsScope fesCorrect = TestingHelper.getFieldExtensionsScope(correctValues);
    fesCorrect.helperScope.triggerScope.isUpdate = false;
    System.assert(!action.run(fesCorrect));

    CoreHelper.FieldExtensionsScope fesWrong = TestingHelper.getFieldExtensionsScope(wrongValues);
    fesWrong.helperScope.triggerScope.isUpdate = false;
    System.assert(!action.run(fesWrong));

    CoreHelper.FieldExtensionsScope fesCorrectIsUpdate = TestingHelper.getFieldExtensionsScope(correctValues);
    fesCorrectIsUpdate.helperScope.triggerScope.isUpdate = true;
    System.assert(action.run(fesCorrectIsUpdate));

    CoreHelper.FieldExtensionsScope fesWrongIsUpdate = TestingHelper.getFieldExtensionsScope(wrongValues);
    fesWrongIsUpdate.helperScope.triggerScope.isUpdate = true;
    System.assert(!action.run(fesWrongIsUpdate));
  }

  @IsTest
  static void fieldExtensionsActionUpdatedTo () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_UPDATED_TO_ANY_OF;

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_NEW_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    CoreHelper.FieldExtensionsScope fesCorrect = TestingHelper.getFieldExtensionsScope(correctValues);
    fesCorrect.helperScope.triggerScope.isUpdate = false;
    System.assert(!action.run(fesCorrect));

    CoreHelper.FieldExtensionsScope fesWrong = TestingHelper.getFieldExtensionsScope(wrongValues);
    fesWrong.helperScope.triggerScope.isUpdate = false;
    System.assert(!action.run(fesWrong));

    CoreHelper.FieldExtensionsScope fesCorrectIsUpdate = TestingHelper.getFieldExtensionsScope(correctValues);
    fesCorrectIsUpdate.helperScope.triggerScope.isUpdate = true;
    System.assert(action.run(fesCorrectIsUpdate));

    CoreHelper.FieldExtensionsScope fesWrongIsUpdate = TestingHelper.getFieldExtensionsScope(wrongValues);
    fesWrongIsUpdate.helperScope.triggerScope.isUpdate = true;
    System.assert(!action.run(fesWrongIsUpdate));
  }

  @IsTest
  static void fieldExtensionsActionWas () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_ANY_OF;

    List<String> correctValues = TestingHelper.getCorrectValues(TestingHelper.ACCOUNT_OLD_NAME);
    List<String> wrongValues = TestingHelper.getAccountWrongNames();

    CoreHelper.FieldExtensionsScope fesCorrect = TestingHelper.getFieldExtensionsScope(correctValues);
    fesCorrect.helperScope.triggerScope.isUpdate = false;
    System.assert(action.run(fesCorrect));

    CoreHelper.FieldExtensionsScope fesWrong = TestingHelper.getFieldExtensionsScope(wrongValues);
    fesWrong.helperScope.triggerScope.isUpdate = false;
    System.assert(!action.run(fesWrong));

    CoreHelper.FieldExtensionsScope fesCorrectIsUpdate = TestingHelper.getFieldExtensionsScope(correctValues);
    fesCorrectIsUpdate.helperScope.triggerScope.isUpdate = true;
    System.assert(action.run(fesCorrectIsUpdate));

    CoreHelper.FieldExtensionsScope fesWrongIsUpdate = TestingHelper.getFieldExtensionsScope(wrongValues);
    fesWrongIsUpdate.helperScope.triggerScope.isUpdate = true;
    System.assert(!action.run(fesWrongIsUpdate));
  }

  @IsTest
  static void fieldExtensionsActionWasUpdated () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_UPDATED;

    CoreHelper.FieldExtensionsScope fes = TestingHelper.getFieldExtensionsScope(null);
    fes.helperScope.triggerScope.isUpdate = false;
    System.assert(!action.run(fes));

    CoreHelper.FieldExtensionsScope fesIsUpdate = TestingHelper.getFieldExtensionsScope(null);
    fesIsUpdate.helperScope.triggerScope.isUpdate = true;
    System.assert(action.run(fesIsUpdate));
  }

  @IsTest
  static void fieldExtensionsActionWasUpdatedSameName () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_UPDATED;

    CoreHelper.TriggerScope ts = TestingHelper.getTriggerScope();
    ((Account)ts.oldMap.values().get(0)).Name = TestingHelper.ACCOUNT_NEW_NAME;
    ((Account)ts.newMap.values().get(0)).Name = TestingHelper.ACCOUNT_NEW_NAME;
    ts.isUpdate = false;

    CoreHelper.FieldExtensionsScope fes = TestingHelper.getFieldExtensionsScope(ts, null);
    System.assert(!action.run(fes));

    CoreHelper.TriggerScope tsIsUpdate = TestingHelper.getTriggerScope();
    ((Account)tsIsUpdate.oldMap.values().get(0)).Name = TestingHelper.ACCOUNT_NEW_NAME;
    ((Account)tsIsUpdate.newMap.values().get(0)).Name = TestingHelper.ACCOUNT_NEW_NAME;
    tsIsUpdate.isUpdate = true;

    CoreHelper.FieldExtensionsScope fesIsUpdate = TestingHelper.getFieldExtensionsScope(tsIsUpdate, null);
    System.assert(!action.run(fesIsUpdate));
  }
}
