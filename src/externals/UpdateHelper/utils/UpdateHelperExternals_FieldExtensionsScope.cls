public class UpdateHelperExternals_FieldExtensionsScope {
  /* bundler-make-final */ private UpdateHelper helper;
  /* bundler-make-final */ private SObjectField field;
  /* bundler-make-final */ private UpdateHelper.Scope helperScope;

  /* bundler-make-final */ private Schema.DescribeSObjectResult fieldDescribe;
  /* bundler-make-final */ private Schema.DescribeSObjectResult sobjectDescribe;
  /* bundler-make-final */ private String fieldName;

  /* bundler-make-final */ public SObject oldRecord { get; private set; }
  /* bundler-make-final */ public SObject newRecord { get; private set; }
  /* bundler-make-final */ public Object oldValue { get; private set; }
  /* bundler-make-final */ public Object newValue { get; private set; }

  /* bundler-make-final */ public Object[] values { get; private set; }

  @SuppressWarnings('PMD.EmptyStatementBlock')
  public UpdateHelperExternals_FieldExtensionsScope () {}

  private UpdateHelperExternals_FieldExtensionsScope (UpdateHelper helper, SObjectField field, Object[] values) {
    externalInit(helper, field);
    this.values = values;
  }

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

  public UpdateHelperExternals_FieldExtensionsScope copyWithValues (Object[] values) {
    return new UpdateHelperExternals_FieldExtensionsScope(this.helper, this.field, values);
  }
}
