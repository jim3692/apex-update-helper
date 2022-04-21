@IsTest
class ActionsTest {
  @IsTest
  static void fieldExtensionsActionIs () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_IS_ANY_OF;

    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account oldRecord = new Account(Id = fakeId, Name = 'old');
    Account newRecord = new Account(Id = fakeId, Name = 'new');
    ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
    ts.newMap = new Map<Id,Account>{fakeId => newRecord};

    List<String> correctValues = new List<String>{ 'a', 'b', 'new' };
    List<String> wrongValues = new List<String>{ 'a', 'b', 'NEW' };

    UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
    uhs.externalInit(ts, oldRecord);

    CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
    fes.externalInit(uhs, Account.Name);

    CoreHelper.FieldExtensionsScope fesCorrect = fes.copyWithValues(correctValues);
    System.assert(action.run(fesCorrect));

    CoreHelper.FieldExtensionsScope fesWrong = fes.copyWithValues(wrongValues);
    System.assert(!action.run(fesWrong));
  }

  @IsTest
  static void fieldExtensionsActionUpdatedFrom () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_UPDATED_FROM_ANY_OF;

    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account oldRecord = new Account(Id = fakeId, Name = 'old');
    Account newRecord = new Account(Id = fakeId, Name = 'new');

    List<String> correctValues = new List<String>{ 'a', 'b', 'old' };
    List<String> wrongValues = new List<String>{ 'a', 'b', 'OLD' };

    {
      CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
      ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
      ts.newMap = new Map<Id,Account>{fakeId => newRecord};

      UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
      uhs.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
      fes.externalInit(uhs, Account.Name);

      CoreHelper.FieldExtensionsScope fesCorrect = fes.copyWithValues(correctValues);
      System.assert(!action.run(fesCorrect));

      CoreHelper.FieldExtensionsScope fesWrong = fes.copyWithValues(wrongValues);
      System.assert(!action.run(fesWrong));
    }

    {
      CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
      ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
      ts.newMap = new Map<Id,Account>{fakeId => newRecord};
      ts.isUpdate = true;

      UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
      uhs.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
      fes.externalInit(uhs, Account.Name);

      CoreHelper.FieldExtensionsScope fesCorrect = fes.copyWithValues(correctValues);
      System.assert(action.run(fesCorrect));

      CoreHelper.FieldExtensionsScope fesWrong = fes.copyWithValues(wrongValues);
      System.assert(!action.run(fesWrong));
    }

    {
      oldRecord.Name = 'new';

      CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
      ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
      ts.newMap = new Map<Id,Account>{fakeId => newRecord};
      ts.isUpdate = true;

      UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
      uhs.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
      fes.externalInit(uhs, Account.Name);

      CoreHelper.FieldExtensionsScope fesCorrect = fes.copyWithValues(correctValues);
      System.assert(!action.run(fesCorrect));

      CoreHelper.FieldExtensionsScope fesWrong = fes.copyWithValues(wrongValues);
      System.assert(!action.run(fesWrong));

      oldRecord.Name = 'old';
    }
  }

  @IsTest
  static void fieldExtensionsActionUpdatedTo () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_UPDATED_TO_ANY_OF;

    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account oldRecord = new Account(Id = fakeId, Name = 'old');
    Account newRecord = new Account(Id = fakeId, Name = 'new');

    List<String> correctValues = new List<String>{ 'a', 'b', 'new' };
    List<String> wrongValues = new List<String>{ 'a', 'b', 'NEW' };

    {
      CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
      ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
      ts.newMap = new Map<Id,Account>{fakeId => newRecord};

      UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
      uhs.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
      fes.externalInit(uhs, Account.Name);

      CoreHelper.FieldExtensionsScope fesCorrect = fes.copyWithValues(correctValues);
      System.assert(!action.run(fesCorrect));

      CoreHelper.FieldExtensionsScope fesWrong = fes.copyWithValues(wrongValues);
      System.assert(!action.run(fesWrong));
    }

    {
      CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
      ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
      ts.newMap = new Map<Id,Account>{fakeId => newRecord};
      ts.isUpdate = true;

      UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
      uhs.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
      fes.externalInit(uhs, Account.Name);

      CoreHelper.FieldExtensionsScope fesCorrect = fes.copyWithValues(correctValues);
      System.assert(action.run(fesCorrect));

      CoreHelper.FieldExtensionsScope fesWrong = fes.copyWithValues(wrongValues);
      System.assert(!action.run(fesWrong));
    }

    {
      oldRecord.Name = 'new';

      CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
      ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
      ts.newMap = new Map<Id,Account>{fakeId => newRecord};
      ts.isUpdate = true;

      UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
      uhs.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
      fes.externalInit(uhs, Account.Name);

      CoreHelper.FieldExtensionsScope fesCorrect = fes.copyWithValues(correctValues);
      System.assert(!action.run(fesCorrect));

      CoreHelper.FieldExtensionsScope fesWrong = fes.copyWithValues(wrongValues);
      System.assert(!action.run(fesWrong));

      oldRecord.Name = 'old';
    }
  }

  @IsTest
  static void fieldExtensionsActionWas () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_ANY_OF;

    CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account oldRecord = new Account(Id = fakeId, Name = 'old');
    Account newRecord = new Account(Id = fakeId, Name = 'new');
    ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
    ts.newMap = new Map<Id,Account>{fakeId => newRecord};

    List<String> correctValues = new List<String>{ 'a', 'b', 'old' };
    List<String> wrongValues = new List<String>{ 'a', 'b', 'OLD' };

    UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
    uhs.externalInit(ts, oldRecord);

    CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
    fes.externalInit(uhs, Account.Name);

    CoreHelper.FieldExtensionsScope fesCorrect = fes.copyWithValues(correctValues);
    System.assert(action.run(fesCorrect));

    CoreHelper.FieldExtensionsScope fesWrong = fes.copyWithValues(wrongValues);
    System.assert(!action.run(fesWrong));
  }

  @IsTest
  static void fieldExtensionsActionWasUpdated () {
    CoreHelper.IFieldExtensionsAction action = CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_UPDATED;

    Id fakeId = TestingHelper.getFakeId(Account.SObjectType);
    Account oldRecord = new Account(Id = fakeId, Name = 'old');
    Account newRecord = new Account(Id = fakeId, Name = 'new');

    {
      CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
      ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
      ts.newMap = new Map<Id,Account>{fakeId => newRecord};

      UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
      uhs.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
      fes.externalInit(uhs, Account.Name, null);
      System.assert(!action.run(fes));
    }

    {
      CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
      ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
      ts.newMap = new Map<Id,Account>{fakeId => newRecord};
      ts.isUpdate = true;

      UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
      uhs.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
      fes.externalInit(uhs, Account.Name, null);
      System.assert(action.run(fes));
    }

    {
      oldRecord.Name = 'new';

      CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
      ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
      ts.newMap = new Map<Id,Account>{fakeId => newRecord};
      ts.isUpdate = true;

      UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
      uhs.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
      fes.externalInit(uhs, Account.Name, null);
      System.assert(!action.run(fes));

      oldRecord.Name = 'old';
    }

    {
      oldRecord.Name = 'NEW';

      CoreHelper.TriggerScope ts = new CoreHelper.TriggerScope();
      ts.oldMap = new Map<Id,Account>{fakeId => oldRecord};
      ts.newMap = new Map<Id,Account>{fakeId => newRecord};
      ts.isUpdate = true;

      UpdateHelper.UpdateHelperScope uhs = new UpdateHelper.UpdateHelperScope();
      uhs.externalInit(ts, oldRecord);

      CoreHelper.FieldExtensionsScope fes = new CoreHelper.FieldExtensionsScope();
      fes.externalInit(uhs, Account.Name, null);
      System.assert(action.run(fes));

      oldRecord.Name = 'old';
    }
  }
}
