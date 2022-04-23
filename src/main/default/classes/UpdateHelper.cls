public class UpdateHelper {
  public Scope scope { get; private set; }
  public final Boolean isFuture { get; private set; }

  public static UpdateHelper of (Id recordId) {
    if (recordId == null) {
      throw new NullRecordIdException('Record ID is null');
    }

    SObject record = recordId.getSObjectType().newSObject();
    record.Id = recordId;
    return of(record);
  }

  public static UpdateHelper of (SObject record) {
    return new UpdateHelper(record);
  }

  public static UpdateHelper futureOf (SObjectType sobjectType) {
    return new UpdateHelper(sobjectType);
  }

  private UpdateHelper (SObject record) {
    this.isFuture = false;
    initScopes(record);
  }

  private UpdateHelper (SObjectType sobjectType) {
    SObject record = sobjectType.newSObject();
    this.isFuture = true;
    initScopes(record);
  }

  private void initScopes (SObject record) {
    CoreHelper.TriggerScope triggerScope = CoreHelper.getTriggerScope();
    this.scope = new Scope();
    this.scope.externalInit(triggerScope, record);
  }

  public FieldExtensions field (SObjectField field) {
    if (isFuture) {
      throw new IllegalFieldCallException('Cannot call "field" on future-enabled UpdateHelper instances');
    }

    validateField(field);
    FieldExtensions extensions = new FieldExtensions();
    extensions.externalInit(scope, field);
    return extensions;
  }

  public FutureFieldExtensions futureField (SObjectField field) {
    if (!isFuture) {
      throw new IllegalFieldCallException('Cannot call "futureField" on future-disabled UpdateHelper instances');
    }

    validateField(field);
    FutureFieldExtensions extensions = new FutureFieldExtensions();
    extensions.externalInit(scope, field);
    return extensions;
  }

  private void validateField (SObjectField field) {
    Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
    String fieldName = fieldDescribe.getName().toLowerCase();

    if (scope.describe.fields.getMap().get(fieldName) != field) {
      String errorMessage = String.format(
        'Field "{0}" does not belong to SObject "{1}"',
        new String[] {
          fieldDescribe.getName(),
          scope.describe.getName()
        }
      );

      throw new InvalidFieldException(errorMessage);
    }
  }

  public class Scope extends UHExt_Scope {}
  public class FieldExtensions extends UHExt_FieldExtensions {}
  public class FutureFieldExtensions extends UHExt_FutureFieldExtensions {}
  public class FutureFieldExtensionsExecutor extends UHExt_FutureFieldExtensionsExecutor {}

  public class NullRecordIdException extends Exception {}
  public class IllegalFieldCallException extends Exception {}
  public class InvalidFieldException extends Exception {}
}
