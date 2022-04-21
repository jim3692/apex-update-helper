@IsTest
class ScopeTest {

  @IsTest
  static void triggerScope () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    System.assertEquals(null, ts.oldMap);
    System.assertEquals(null, ts.newMap);
    System.assert(!ts.isUpdate);

    ts.oldMap = new Map<Id,SObject>();
    ts.newMap = new Map<Id,SObject>();
    System.assertNotEquals(null, ts.oldMap);
    System.assertNotEquals(null, ts.newMap);
    System.assert(!ts.isUpdate);

    ts.isUpdate = true;
    System.assertNotEquals(null, ts.oldMap);
    System.assertNotEquals(null, ts.newMap);
    System.assert(ts.isUpdate);
  }

  @IsTest
  static void updateHelperScopeWithoutId () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Account record = new Account();

    UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
    uhs.externalInit(ts, record);

    System.assertNotEquals(null, uhs.triggerScope);
    System.assertEquals(null, uhs.oldRecord);
    System.assertEquals(record, uhs.newRecord);
    System.assertEquals(Account.getSObjectType().getDescribe(), uhs.describe);
    System.assertEquals(null, uhs.recordId);
  }

  @IsTest
  static void updateHelperScopeWithId () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account record = new Account(Id = fakeId);

    UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
    uhs.externalInit(ts, record);

    System.assertNotEquals(null, uhs.triggerScope);
    System.assertEquals(null, uhs.oldRecord);
    System.assertEquals(record, uhs.newRecord);
    System.assertEquals(Account.getSObjectType().getDescribe(), uhs.describe);
    System.assertEquals(fakeId, uhs.recordId);
  }

  @IsTest
  static void updateHelperScopeWithIdAndTriggerScope () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account oldRecord = new Account(Id = fakeId, Name = 'old');
    Account newRecord = new Account(Id = fakeId, Name = 'new');
    ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
    ts.newMap = new Map<Id,Account>{fakeId => newRecord};

    { // Prevent reuse of variables
      UpdateHelper.UpdateHelperScope uhsFromOld = new UpdateHelper.UpdateHelperScope();
      uhsFromOld.externalInit(ts, oldRecord);

      System.assertNotEquals(null, uhsFromOld.triggerScope);
      System.assertEquals(oldRecord, uhsFromOld.oldRecord);
      System.assertEquals(newRecord, uhsFromOld.newRecord);
      System.assertEquals(Account.getSObjectType().getDescribe(), uhsFromOld.describe);
      System.assertEquals(fakeId, uhsFromOld.recordId);
    }

    { // Prevent reuse of variables
      UpdateHelper.UpdateHelperScope uhsFromNew = new UpdateHelper.UpdateHelperScope();
      uhsFromNew.externalInit(ts, newRecord);

      System.assertNotEquals(null, uhsFromNew.triggerScope);
      System.assertEquals(oldRecord, uhsFromNew.oldRecord);
      System.assertEquals(newRecord, uhsFromNew.newRecord);
      System.assertEquals(Account.getSObjectType().getDescribe(), uhsFromNew.describe);
      System.assertEquals(fakeId, uhsFromNew.recordId);
    }
  }

  @IsTest
  static void fieldExtensionsScopeWithoutId () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Account record = new Account();

    UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
    uhs.externalInit(ts, record);

    CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
    fes.externalInit(uhs, Account.Name);

    System.assertEquals(uhs, fes.helperScope);
    System.assertEquals(Account.Name, fes.field);
    System.assertEquals(Account.Name.getDescribe(), fes.fieldDescribe);
    System.assertEquals(Account.getSObjectType().getDescribe(), fes.sobjectDescribe);
    System.assertEquals('name', fes.fieldName);
    System.assertEquals(null, fes.oldRecord);
    System.assertEquals(record, fes.newRecord);
    System.assertEquals(null, fes.oldValue);
    System.assertEquals(null, fes.newValue);
  }

  @IsTest
  static void fieldExtensionsScopeWithId () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account record = new Account(Id = fakeId);

    UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
    uhs.externalInit(ts, record);

    CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
    fes.externalInit(uhs, Account.Name);

    System.assertEquals(uhs, fes.helperScope);
    System.assertEquals(Account.Name, fes.field);
    System.assertEquals(Account.Name.getDescribe(), fes.fieldDescribe);
    System.assertEquals(Account.getSObjectType().getDescribe(), fes.sobjectDescribe);
    System.assertEquals('name', fes.fieldName);
    System.assertEquals(null, fes.oldRecord);
    System.assertEquals(record, fes.newRecord);
    System.assertEquals(null, fes.oldValue);
    System.assertEquals(null, fes.newValue);
  }

  @IsTest
  static void fieldExtensionsScopeWithIdAndTriggerScope () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account oldRecord = new Account(Id = fakeId, Name = 'old');
    Account newRecord = new Account(Id = fakeId, Name = 'new');
    ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
    ts.newMap = new Map<Id,Account>{fakeId => newRecord};

    { // Prevent reuse of variables
      UpdateHelper.UpdateHelperScope uhsOld = new UpdateHelper.UpdateHelperScope();
      uhsOld.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fesOld = new CoreHelper.FieldExtensionsScope();
      fesOld.externalInit(uhsOld, Account.Name);

      System.assertEquals(uhsOld, fesOld.helperScope);
      System.assertEquals(Account.Name, fesOld.field);
      System.assertEquals(Account.Name.getDescribe(), fesOld.fieldDescribe);
      System.assertEquals(Account.getSObjectType().getDescribe(), fesOld.sobjectDescribe);
      System.assertEquals('name', fesOld.fieldName);
      System.assertEquals(oldRecord, fesOld.oldRecord);
      System.assertEquals(newRecord, fesOld.newRecord);
      System.assertEquals('old', fesOld.oldValue);
      System.assertNotEquals('OLD', fesOld.oldValue);
      System.assertEquals('new', fesOld.newValue);
      System.assertNotEquals('NEW', fesOld.newValue);
    }

    { // Prevent reuse of variables
      UpdateHelper.UpdateHelperScope uhsNew = new UpdateHelper.UpdateHelperScope();
      uhsNew.externalInit(ts, newRecord);

      CoreHelper.FieldExtensionsScope fesNew = new CoreHelper.FieldExtensionsScope();
      fesNew.externalInit(uhsNew, Account.Name);

      System.assertEquals(uhsNew, fesNew.helperScope);
      System.assertEquals(Account.Name, fesNew.field);
      System.assertEquals(Account.Name.getDescribe(), fesNew.fieldDescribe);
      System.assertEquals(Account.getSObjectType().getDescribe(), fesNew.sobjectDescribe);
      System.assertEquals('name', fesNew.fieldName);
      System.assertEquals(oldRecord, fesNew.oldRecord);
      System.assertEquals(newRecord, fesNew.newRecord);
      System.assertEquals('old', fesNew.oldValue);
      System.assertNotEquals('OLD', fesNew.oldValue);
      System.assertEquals('new', fesNew.newValue);
      System.assertNotEquals('NEW', fesNew.newValue);
    }
  }

}
