public class UpdateHelper {
  public CoreHelper.TriggerScope triggerScope { get; private set; }
  public UpdateHelperScope scope { get; private set; }

  public final Boolean isFuture { get; private set; }

  public static UpdateHelper of (Id recordId) {
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
    this.triggerScope = CoreHelper.getTriggerScope();
    this.scope = new UpdateHelperScope();
    this.scope.externalInit(this.triggerScope, record);
  }

  public CoreHelper.FieldExtensions field (SObjectField field) {
    System.assert(!isFuture);
    validateField(field);
    CoreHelper.FieldExtensions extensions = new CoreHelper.FieldExtensions();
    extensions.externalInit(scope, field);
    return extensions;
  }

  public CoreHelper.FutureFieldExtensions futureField (SObjectField field) {
    System.assert(isFuture);
    validateField(field);
    CoreHelper.FutureFieldExtensions extensions = new CoreHelper.FutureFieldExtensions();
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

      throw new CoreHelper.UpdateHelperInvalidFieldException(errorMessage);
    }
  }

  public class UpdateHelperScope extends UHExt_UpdateHelperScope {}
}
