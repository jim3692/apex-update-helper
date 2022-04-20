public class UpdateHelper {
  @TestVisible
  public CoreHelper.UpdateHelperScope scope { get; private set; }

  /* bundler-make-final */ public SObject oldRecord { get; private set; }
  /* bundler-make-final */ public SObject newRecord { get; private set; }
  /* bundler-make-final */ public Schema.DescribeSObjectResult describe { get; private set; }

  public final FutureRecord futureRecord { get; private set; }

  public static UpdateHelper of (Id recordId) {
    SObject record = recordId.getSObjectType().newSObject();
    record.Id = recordId;
    return of(record);
  }

  public static UpdateHelper of (SObject record) {
    return new UpdateHelper(record);
  }

  public static UpdateHelper of (FutureRecord futureRecord) {
    return new UpdateHelper(futureRecord);
  }

  public static UpdateHelper futureOf (SObjectType sobjectType) {
    return of(new FutureRecord(sobjectType));
  }

  private UpdateHelper (SObject record) {
    this.scope = new CoreHelper.UpdateHelperScope();
    this.init(record);
  }

  private UpdateHelper (FutureRecord futureRecord) {
    this.scope = new CoreHelper.UpdateHelperScope();
  }

  private void init (SObject record) {
    this.describe = record.getSObjectType().getDescribe();

    this.oldRecord = scope.oldMap?.get(record.Id);
    this.newRecord = record.Id == null
      ? record
      : scope.newMap?.get(record.Id);
  }

  public CoreHelper.FieldExtensions field (SObjectField field) {
    validateField(field);
    System.assert(futureRecord == null);
    CoreHelper.FieldExtensions extensions = new CoreHelper.FieldExtensions();
    extensions.externalInit(this, field);
    return extensions;
  }

  // public CoreHelper.FutureFieldExtensions futureField (SObjectField field) {
  //   System.assert(futureRecord != null);
  // }

  // public Boolean futureRun (SObject record) {
  //   System.assert(futureRecord != null);
  // }

  private void validateField (SObjectField field) {
    Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
    String fieldName = fieldDescribe.getName().toLowerCase();

    if (describe.fields.getMap().get(fieldName) != field) {
      String errorMessage = String.format(
        'Field "{0}" does not belong to SObject "{1}"',
        new String[] {
          fieldDescribe.getName(),
          describe.getName()
        }
      );

      throw new CoreHelper.UpdateHelperInvalidFieldException(errorMessage);
    }
  }
}
