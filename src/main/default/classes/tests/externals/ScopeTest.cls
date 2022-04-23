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

    UpdateHelper.Scope uhs = new UpdateHelper.Scope();
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

    UpdateHelper.Scope uhs = new UpdateHelper.Scope();
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

    {
      UpdateHelper.Scope uhsFromOld = new UpdateHelper.Scope();
      uhsFromOld.externalInit(ts, oldRecord);

      System.assertNotEquals(null, uhsFromOld.triggerScope);
      System.assertEquals(oldRecord, uhsFromOld.oldRecord);
      System.assertEquals(newRecord, uhsFromOld.newRecord);
      System.assertEquals(Account.getSObjectType().getDescribe(), uhsFromOld.describe);
      System.assertEquals(fakeId, uhsFromOld.recordId);
    }

    {
      UpdateHelper.Scope uhsFromNew = new UpdateHelper.Scope();
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

    UpdateHelper.Scope uhs = new UpdateHelper.Scope();
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
    System.assertEquals(null, fes.values);
  }

  @IsTest
  static void fieldExtensionsScopeValues () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Account record = new Account();
    List<String> values = new List<String>{ 'a', 'b', 'c' };

    UpdateHelper.Scope uhs = new UpdateHelper.Scope();
    uhs.externalInit(ts, record);

    {
      CoreHelper.FieldExtensionsScope fesValuesFromConstructor = new CoreHelper.FieldExtensionsScope();
      fesValuesFromConstructor.externalInit(uhs, Account.Name, values);

      System.assertEquals(uhs, fesValuesFromConstructor.helperScope);
      System.assertEquals(Account.Name, fesValuesFromConstructor.field);
      System.assertEquals(Account.Name.getDescribe(), fesValuesFromConstructor.fieldDescribe);
      System.assertEquals(Account.getSObjectType().getDescribe(), fesValuesFromConstructor.sobjectDescribe);
      System.assertEquals('name', fesValuesFromConstructor.fieldName);
      System.assertEquals(null, fesValuesFromConstructor.oldRecord);
      System.assertEquals(record, fesValuesFromConstructor.newRecord);
      System.assertEquals(null, fesValuesFromConstructor.oldValue);
      System.assertEquals(null, fesValuesFromConstructor.newValue);
      System.assertEquals(values, fesValuesFromConstructor.values);
    }

    {
      CoreHelper.FieldExtensionsScope fesValuesFromCopy = new CoreHelper.FieldExtensionsScope();
      fesValuesFromCopy.externalInit(uhs, Account.Name);
      fesValuesFromCopy = fesValuesFromCopy.copyWithValues(values);

      System.assertEquals(uhs, fesValuesFromCopy.helperScope);
      System.assertEquals(Account.Name, fesValuesFromCopy.field);
      System.assertEquals(Account.Name.getDescribe(), fesValuesFromCopy.fieldDescribe);
      System.assertEquals(Account.getSObjectType().getDescribe(), fesValuesFromCopy.sobjectDescribe);
      System.assertEquals('name', fesValuesFromCopy.fieldName);
      System.assertEquals(null, fesValuesFromCopy.oldRecord);
      System.assertEquals(record, fesValuesFromCopy.newRecord);
      System.assertEquals(null, fesValuesFromCopy.oldValue);
      System.assertEquals(null, fesValuesFromCopy.newValue);
      System.assertEquals(values, fesValuesFromCopy.values);
    }
  }

  @IsTest
  static void fieldExtensionsScopeWithId () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account record = new Account(Id = fakeId);

    UpdateHelper.Scope uhs = new UpdateHelper.Scope();
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
    System.assertEquals(null, fes.values);
  }

  @IsTest
  static void fieldExtensionsScopeWithIdAndTriggerScope () {
    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account oldRecord = new Account(Id = fakeId, Name = 'old');
    Account newRecord = new Account(Id = fakeId, Name = 'new');
    ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
    ts.newMap = new Map<Id,Account>{fakeId => newRecord};

    {
      UpdateHelper.Scope uhsOld = new UpdateHelper.Scope();
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
      System.assertEquals(null, fesOld.values);
    }

    {
      UpdateHelper.Scope uhsNew = new UpdateHelper.Scope();
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
      System.assertEquals(null, fesNew.values);
    }
  }

}
