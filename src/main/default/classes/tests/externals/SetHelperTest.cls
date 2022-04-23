@IsTest
class SetHelperTest {

  @IsTest
  static void constructor () {
    CoreHelper.TriggerScope ts = TestingHelper.getTriggerScopeWithMultipleRecords();
    TestingHelper.stubCoreHelper(ts);
    SetHelper helper = SetHelper.of(ts.oldMap.values());
    System.assertEquals(ts, helper.triggerScope);
  }

  @IsTest
  static void whenThe () {
    CoreHelper.TriggerScope ts = TestingHelper.getTriggerScopeWithMultipleRecords();
    TestingHelper.stubCoreHelper(ts);

    UpdateHelper.FutureFieldExtensions name = UpdateHelper.futureOf(Account.SObjectType).futureField(Account.Name);

    Set<Id> allIds = new Set<Id>();
    Set<Id> name0Id = new Set<Id>();
    Set<Id> name1Id = new Set<Id>();
    Set<Id> name2Id = new Set<Id>();
    Set<Id> empty = new Set<Id>();

    SetHelper.NullExtensionsException nullExtensionsException;
    try {
      SetHelper.WhenTheExtensions extensions = SetHelper.of(ts.oldMap.values()).whenThe(null);
    } catch (SetHelper.NullExtensionsException ex) {
      nullExtensionsException = ex;
    }
    System.assertEquals('Executor cannot be null', nullExtensionsException.getMessage());

    SetHelper.NullSetException nullSetException;
    try {
      SetHelper helper = SetHelper.of(ts.oldMap.values())
        .whenThe(name.is(null)).addIdTo(null);
    } catch (SetHelper.NullSetException ex) {
      nullSetException = ex;
    }
    System.assertEquals('Set cannot be null', nullSetException.getMessage());

    SetHelper.of(ts.oldMap.values())
      .whenThe(name.wasUpdated()).addIdTo(allIds)
      .whenThe(name.is(TestingHelper.ACCOUNT_NEW_NAME + 0)).addIdTo(name0Id)
      .whenThe(name.is(TestingHelper.ACCOUNT_NEW_NAME + 1)).addIdTo(name1Id)
      .whenThe(name.was(TestingHelper.ACCOUNT_OLD_NAME + 2)).addIdTo(name2Id)
      .whenThe(name.was(TestingHelper.ACCOUNT_WRONG_NAME)).addIdTo(empty)
      .whenThe(name.was(TestingHelper.ACCOUNT_WRONG_NAME + 0)).addIdTo(empty)
      .run();

    System.assertEquals(10, allIds.size());
    System.assertEquals(1, name0Id.size());
    System.assertEquals(1, name1Id.size());
    System.assertEquals(1, name2Id.size());
    System.assertEquals(0, empty.size());
  }

}
