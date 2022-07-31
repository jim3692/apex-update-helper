@IsTest
class UpdateHelperTest {
  @IsTest
  static void constructors() {
    CoreHelper.TriggerScope ts = TestingHelper.getTriggerScope();
    TestingHelper.stubCoreHelper(ts);
    Account oldRecord = (Account) ts.oldMap.values().get(0);
    Account newRecord = (Account) ts.newMap.values().get(0);

    UpdateHelper helperOfOldRecord = UpdateHelper.of(oldRecord);
    System.assert(!helperOfOldRecord.isFuture);
    System.assertEquals(oldRecord, helperOfOldRecord.scope.oldRecord);
    System.assertEquals(newRecord, helperOfOldRecord.scope.newRecord);

    UpdateHelper helperOfNewRecord = UpdateHelper.of(newRecord);
    System.assert(!helperOfNewRecord.isFuture);
    System.assertEquals(oldRecord, helperOfNewRecord.scope.oldRecord);
    System.assertEquals(newRecord, helperOfNewRecord.scope.newRecord);

    UpdateHelper helperOfId = UpdateHelper.of(oldRecord.Id);
    System.assert(!helperOfId.isFuture);
    System.assertEquals(oldRecord, helperOfId.scope.oldRecord);
    System.assertEquals(newRecord, helperOfId.scope.newRecord);
  }

  @IsTest
  static void constructorsWithNullId() {
    Account record = new Account();

    UpdateHelper helper = UpdateHelper.of(record);
    System.assert(!helper.isFuture);
    System.assertEquals(null, helper.scope.oldRecord);
    System.assertEquals(record, helper.scope.newRecord);

    Exception nullRecordIdException;
    try {
      UpdateHelper invalidHelper = UpdateHelper.of(record.Id);
    } catch (UpdateHelper.NullRecordIdException ex) {
      nullRecordIdException = ex;
    }
    System.assertEquals(
      'Record ID is null',
      nullRecordIdException.getMessage()
    );
  }

  @IsTest
  static void futureConstructor() {
    UpdateHelper helper = UpdateHelper.futureOf(Account.SObjectType);
    System.assert(helper.isFuture);
    System.assertEquals(null, helper.scope.oldRecord);
    System.assertEquals(null, helper.scope.newRecord.Id);
    System.assertEquals(
      Account.SObjectType,
      helper.scope.newRecord.getSObjectType()
    );
  }

  @IsTest
  static void field() {
    CoreHelper.TriggerScope ts = TestingHelper.getTriggerScope();
    TestingHelper.stubCoreHelper(ts);
    Account oldRecord = (Account) ts.oldMap.values().get(0);
    Account newRecord = (Account) ts.newMap.values().get(0);

    UpdateHelper.FieldExtensions extensionsOfOldRecord = UpdateHelper.of(
        oldRecord
      )
      .field(Account.Name);
    UpdateHelper.FieldExtensions extensionsOfNewRecord = UpdateHelper.of(
        newRecord
      )
      .field(Account.Name);

    UpdateHelper.InvalidFieldException invalidFieldException;
    try {
      UpdateHelper.FieldExtensions invalidExtensions = UpdateHelper.of(
          oldRecord
        )
        .field(Opportunity.Name);
    } catch (UpdateHelper.InvalidFieldException ex) {
      invalidFieldException = ex;
    }
    System.assertEquals(
      'Field "Name" does not belong to SObject "Account"',
      invalidFieldException.getMessage()
    );

    UpdateHelper.IllegalFieldCallException illegalFieldCallException;
    try {
      UpdateHelper.FieldExtensions invalidExtensions = UpdateHelper.futureOf(
          Account.SObjectType
        )
        .field(Account.Name);
    } catch (UpdateHelper.IllegalFieldCallException ex) {
      illegalFieldCallException = ex;
    }
    System.assertEquals(
      'Cannot call "field" on future-enabled UpdateHelper instances',
      illegalFieldCallException.getMessage()
    );
  }

  @IsTest
  static void futureField() {
    UpdateHelper.FutureFieldExtensions extensions = UpdateHelper.futureOf(
        Account.SObjectType
      )
      .futureField(Account.Name);

    UpdateHelper.InvalidFieldException invalidFieldException;
    try {
      UpdateHelper.FutureFieldExtensions invalidExtensions = UpdateHelper.futureOf(
          Account.SObjectType
        )
        .futureField(Opportunity.Name);
    } catch (UpdateHelper.InvalidFieldException ex) {
      invalidFieldException = ex;
    }
    System.assertEquals(
      'Field "Name" does not belong to SObject "Account"',
      invalidFieldException.getMessage()
    );

    UpdateHelper.IllegalFieldCallException illegalFieldCallException;
    try {
      UpdateHelper.FutureFieldExtensions invalidExtensions = UpdateHelper.of(
          new Account()
        )
        .futureField(Account.Name);
    } catch (UpdateHelper.IllegalFieldCallException ex) {
      illegalFieldCallException = ex;
    }
    System.assertEquals(
      'Cannot call "futureField" on future-disabled UpdateHelper instances',
      illegalFieldCallException.getMessage()
    );
  }
}
