public class UpdateHelper {
  @TestVisible
  public Scope scope { get; private set; }

  public final SObject oldRecord { get; private set; }
  public final SObject newRecord { get; private set; }
  public final Schema.DescribeSObjectResult describe { get; private set; }

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
    this.futureRecord = futureRecord;
  }

  public static UpdateHelper futureOf (SObjectType sobjectType) {
    return of(new FutureRecord(sobjectType));
  }

  private UpdateHelper (SObject record) {
    this.scope = new Scope();
    this.init(record);
  }

  private UpdateHelper (FutureRecord futureRecord) {
    this.scope = new Scope();
  }

  private void init (SObject record) {
    this.describe = record.getSObjectType().getDescribe();

    this.oldRecord = scope.oldMap?.get(recordId);
    this.newRecord = record.Id == null
      ? record
      : scope.newMap?.get(record.Id);
  }

  public FieldExtensions field (SObjectField field) {
    validateField(field);
    System.assert(futureRecord == null);
    FieldExtensions extensions = new FieldExtensions();
    extensions.externalInit(this, field);
    return extensions;
  }

  public FutureFieldExtensions futureField (SObjectField field) {
    System.assert(futureRecord != null);
  }

  public Boolean futureRun (SObject record) {
    System.assert(futureRecord != null);
  }

  private void validateField (SObjectField field) {
    Schema.DescribeSObjectResult fieldDescribe = field.getDescribe();
    String fieldName = fieldDescribe.getName().toLowerCase();

    if (describe.fields.getMap().get(fieldName) != field) {
      String errorMessage = String.format(
        'Field "{0}" does not belong to SObject "{1}"',
        new String[] {
          fieldDescribe.getName(),
          describe.getName()
        }
      );

      throw new UpdateHelperInvalidFieldException(errorMessage);
    }
  }

  /* bundler-make-private */ public static Boolean anyOf (Object recordValue, Object[] values) {
    for (Object value : values) {
      if (recordValue == value) {
        return true;
      }
    }

    return false;
  }

  /* bundler-make-private */ public static Boolean falseIfNull (SObject record) {
    return record != null;
  }
}
