@IsTest
public class TestingHelper {

  public static final String ACCOUNT_OLD_NAME = 'Name';
  public static final String ACCOUNT_NEW_NAME = 'NAME';
  public static final String ACCOUNT_WRONG_NAME = 'name';

  private static Integer fakeIdCounter = 1;

  // Source: https://salesforce.stackexchange.com/a/21297
  @TestVisible
  private static String getFakeId(SObjectType sot) {
    String result = String.valueOf(fakeIdCounter++);
    return sot.getDescribe().getKeyPrefix() +
      '0'.repeat(12-result.length()) + result;
  }

  @TestVisible
  private static CoreHelper.TriggerScope getTriggerScope () {
    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account oldRecord = new Account(Id = fakeId, Name = ACCOUNT_OLD_NAME);
    Account newRecord = new Account(Id = fakeId, Name = ACCOUNT_NEW_NAME);

    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
    ts.newMap = new Map<Id,Account>{fakeId => newRecord};
    ts.isUpdate = false;

    return ts;
  }

  @TestVisible
  private static CoreHelper.TriggerScope getTriggerScopeWithMultipleRecords () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    ts.oldMap = new Map<Id,Account>();
    ts.newMap = new Map<Id,Account>();
    ts.isUpdate = true;

    for (Integer i = 0; i < 10; i++) {
      Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
      Account oldRecord = new Account(Id = fakeId, Name = ACCOUNT_OLD_NAME + i);
      Account newRecord = new Account(Id = fakeId, Name = ACCOUNT_NEW_NAME + i);
      ts.oldMap.put(fakeId, oldRecord);
      ts.newMap.put(fakeId, newRecord);
    }

    return ts;
  }

  @TestVisible
  private static String[] getAccountWrongNames () {
    return new String[] { 'a', 'b', TestingHelper.ACCOUNT_WRONG_NAME };
  }

  @TestVisible
  private static String[] getCorrectValues (String correct) {
    return new String[] { 'a', 'b', correct };
  }

  @TestVisible
  private static UpdateHelper.Scope getUpdateHelperScope (CoreHelper.TriggerScope ts, SObject record) {
    UpdateHelper.Scope uhs = new UpdateHelper.Scope();
    uhs.externalInit(ts, record);

    return uhs;
  }

  @TestVisible
  private static UpdateHelper.Scope getUpdateHelperScope () {
    CoreHelper.TriggerScope ts = getTriggerScope();
    Account record = (Account)ts.oldMap.values().get(0);

    return getUpdateHelperScope(ts, record);
  }

  @TestVisible
  private static UpdateHelper.FieldExtensions getFieldExtensions () {
    UpdateHelper.Scope scope = getUpdateHelperScope();
    scope.triggerScope.isUpdate = true;

    UpdateHelper.FieldExtensions extensions = new UpdateHelper.FieldExtensions();
    extensions.externalInit(scope, Account.Name);

    return extensions;
  }

  @TestVisible
  private static UpdateHelper.FutureFieldExtensions getFutureFieldExtensions () {
    UpdateHelper.Scope scope = getUpdateHelperScope();
    scope.triggerScope.isUpdate = true;

    UpdateHelper.FutureFieldExtensions extensions = new UpdateHelper.FutureFieldExtensions();
    extensions.externalInit(scope, Account.Name);

    return extensions;
  }

  @TestVisible
  private static CoreHelper.FieldExtensionsScope getFieldExtensionsScope (CoreHelper.TriggerScope ts, Object[] values) {
    Account record = (Account)ts.oldMap.values().get(0);

    UpdateHelper.Scope uhs = new UpdateHelper.Scope();
    uhs.externalInit(ts, record);

    CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
    fes.externalInit(uhs, Account.Name, values);

    return fes;
  }

  @TestVisible
  private static CoreHelper.FieldExtensionsScope getFieldExtensionsScope (Object[] values) {
    CoreHelper.TriggerScope ts = getTriggerScope();
    return getFieldExtensionsScope(ts, values);
  }

  @TestVisible
  private static void stubCoreHelper (CoreHelper.TriggerScope scope) {
    CoreHelperMock mock = new CoreHelperMock(scope);
    CoreHelper.mockableInstance = (CoreHelper)Test.createStub(CoreHelper.class, mock);
  }

  private class CoreHelperMock implements System.StubProvider {
    private final CoreHelper.TriggerScope triggerScope;

    public CoreHelperMock (CoreHelper.TriggerScope triggerScope) {
      this.triggerScope = triggerScope;
    }

    public Object handleMethodCall (
      Object stubbedObject,
      String stubbedMethodName,
      Type returnType,
      List<Type> listOfParamTypes,
      List<String> listOfParamNames,
      List<Object> listOfArgs
    ) {
      if (stubbedMethodName == 'mockableTriggerScope') {
        return triggerScope;
      }

      return null;
    }
  }

  /* bundler-inject ActionsTest */
  /* bundler-inject CoreHelperTest */
  /* bundler-inject FieldExtensionsTest */
  /* bundler-inject FutureFieldExtensionsTest */
  /* bundler-inject ScopeTest */
  /* bundler-inject SetHelperTest */
  /* bundler-inject UpdateHelperTest */

}
