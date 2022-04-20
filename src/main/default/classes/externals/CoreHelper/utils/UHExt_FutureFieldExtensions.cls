public abstract class UHExt_FutureFieldExtensions implements UpdateHelper.IFutureFieldExtensionsExecutor {
  /* bundler-make-final */ private UpdateHelper helper;
  /* bundler-make-final */ private SObjectField field;
  /* bundler-make-final */ private CoreHelper.Scope scope;

  /* bundler-make-final */ private Schema.DescribeSObjectResult fieldDescribe;
  /* bundler-make-final */ private Schema.DescribeSObjectResult sobjectDescribe;
  /* bundler-make-final */ private String fieldName;

  private SObject oldRecord;
  private SObject newRecord;
  private Object oldValue;
  private Object newValue;

  public void externalInit (UpdateHelper helper, SObjectField field) {
    this.helper = helper;
    this.field = field;
    this.scope = this.helper.scope;

    this.fieldDescribe = this.field.getDescribe();
    this.sobjectDescribe = this.helper.describe;
    this.fieldName = this.fieldDescribe.getName().toLowerCase();

    this.oldRecord = this.helper.oldRecord;
    this.newRecord = this.helper.newRecord;
    this.oldValue = this.oldRecord?.get(this.fieldName);
    this.newValue = this.newRecord?.get(this.fieldName);
  }

  public CoreHelper.IFutureFieldExtensionsExecutor wasUpdated () {
    return scope.isUpdate
      && oldValue != newValue;
  }

  public CoreHelper.IFutureFieldExtensionsExecutor updatedFromAnyOf (Object[] values) {
    return wasUpdated()
      && anyOf(oldValue, values);
  }

  public CoreHelper.IFutureFieldExtensionsExecutor updatedFrom (Object value) {
    return updatedFromAnyOf(new Object[] { value });
  }

  public CoreHelper.IFutureFieldExtensionsExecutor updatedToAnyOf (Object[] values) {
    return wasUpdated()
      && anyOf(newValue, values);
  }

  public CoreHelper.IFutureFieldExtensionsExecutor updatedTo (Object value) {
    return updatedToAnyOf(new Object[] { value });
  }

  public CoreHelper.IFutureFieldExtensionsExecutor wasAnyOf (Object[] values) {
    return falseIfNull(oldRecord)
      && anyOf(oldValue, values);
  }

  public CoreHelper.IFutureFieldExtensionsExecutor was (Object value) {
    return wasAnyOf(new Object[] { value });
  }

  public CoreHelper.IFutureFieldExtensionsExecutor isAnyOf (Object[] values) {
    return falseIfNull(newRecord)
      && anyOf(newValue, values);
  }

  public CoreHelper.IFutureFieldExtensionsExecutor is (Object value) {
    return isAnyOf(new Object[] { value });
  }

  private Boolean anyOf (Object recordValue, Object[] values) {
    for (Object value : values) {
      if (recordValue == value) {
        return true;
      }
    }

    return false;
  }

  private Boolean falseIfNull (SObject record) {
    return record != null;
  }
}
