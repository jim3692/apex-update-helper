public abstract class CHExt_FieldExtensionsScope {
  /* bundler-make-final */ public UpdateHelper.Scope helperScope { get; private set; }
  /* bundler-make-final */ public SObjectField field { get; private set; }

  /* bundler-make-final */ public Schema.DescribeFieldResult fieldDescribe { get; private set; }
  /* bundler-make-final */ public Schema.DescribeSObjectResult sobjectDescribe { get; private set; }
  /* bundler-make-final */ public String fieldName { get; private set; }

  /* bundler-make-final */ public SObject oldRecord { get; private set; }
  /* bundler-make-final */ public SObject newRecord { get; private set; }
  /* bundler-make-final */ public Object oldValue { get; private set; }
  /* bundler-make-final */ public Object newValue { get; private set; }

  /* bundler-make-final */ public Object[] values { get; private set; }

  public void externalInit (UpdateHelper.Scope helperScope, SObjectField field) {
    this.helperScope = helperScope;
    this.field = field;

    this.fieldDescribe = this.field.getDescribe();
    this.sobjectDescribe = this.helperScope.describe;
    this.fieldName = this.fieldDescribe.getName().toLowerCase();

    this.oldRecord = this.helperScope.oldRecord;
    this.newRecord = this.helperScope.newRecord;
    this.oldValue = this.oldRecord?.get(this.fieldName);
    this.newValue = this.newRecord?.get(this.fieldName);
  }

  public void externalInit (UpdateHelper.Scope helperScope, SObjectField field, Object[] values) {
    externalInit(helperScope, field);
    this.values = values;
  }

  public CoreHelper.FieldExtensionsScope copyWithValues (Object[] values) {
    CoreHelper.FieldExtensionsScope newScope = new CoreHelper.FieldExtensionsScope();
    newScope.externalInit(this.helperScope, this.field, values);
    return newScope;
  }
}
