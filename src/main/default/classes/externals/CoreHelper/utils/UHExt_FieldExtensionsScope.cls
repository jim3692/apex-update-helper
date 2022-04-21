public abstract class UHExt_FieldExtensionsScope {
  /* bundler-make-final */ public UpdateHelper helper { get; private set; }
  /* bundler-make-final */ public SObjectField field { get; private set; }

  /* bundler-make-final */ private Schema.DescribeFieldResult fieldDescribe;
  /* bundler-make-final */ private Schema.DescribeSObjectResult sobjectDescribe;
  /* bundler-make-final */ private String fieldName;

  /* bundler-make-final */ public CoreHelper.TriggerScope helperScope { get; private set; }

  /* bundler-make-final */ public SObject oldRecord { get; private set; }
  /* bundler-make-final */ public SObject newRecord { get; private set; }
  /* bundler-make-final */ public Object oldValue { get; private set; }
  /* bundler-make-final */ public Object newValue { get; private set; }

  /* bundler-make-final */ public Object[] values { get; private set; }

  public void externalInit (UpdateHelper helper, SObjectField field) {
    this.helper = helper;
    this.field = field;
    this.helperScope = this.helper.scope;

    this.fieldDescribe = this.field.getDescribe();
    this.sobjectDescribe = this.helper.describe;
    this.fieldName = this.fieldDescribe.getName().toLowerCase();

    this.oldRecord = this.helper.oldRecord;
    this.newRecord = this.helper.newRecord;
    this.oldValue = this.oldRecord?.get(this.fieldName);
    this.newValue = this.newRecord?.get(this.fieldName);
  }

  public void externalInit (UpdateHelper helper, SObjectField field, Object[] values) {
    externalInit(helper, field);
    this.values = values;
  }

  public CoreHelper.FieldExtensionsScope copyWithValues (Object[] values) {
    CoreHelper.FieldExtensionsScope newScope = new CoreHelper.FieldExtensionsScope();
    newScope.externalInit(this.helper, this.field, values);
    return newScope;
  }
}
