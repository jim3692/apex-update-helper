public abstract class UHExt_FieldExtensions {
  /* bundler-make-final */ private CoreHelper.FieldExtensionsScope scope;

  public void externalInit(UpdateHelper.Scope helperScope, SObjectField field) {
    this.scope = new CoreHelper.FieldExtensionsScope();
    this.scope.externalInit(helperScope, field);
  }

  public Boolean wasUpdated() {
    CoreHelper.FieldExtensionsScope actionScope = this.scope.copyWithValues(
      null
    );
    return CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_UPDATED.run(actionScope);
  }

  public Boolean updatedFromAnyOf(Object[] values) {
    CoreHelper.FieldExtensionsScope actionScope = this.scope.copyWithValues(
      values
    );
    return CoreHelper.FIELD_EXTENSIONS_ACTION_UPDATED_FROM_ANY_OF.run(
      actionScope
    );
  }

  public Boolean updatedFrom(Object value) {
    return updatedFromAnyOf(new List<Object>{ value });
  }

  public Boolean updatedToAnyOf(Object[] values) {
    CoreHelper.FieldExtensionsScope actionScope = this.scope.copyWithValues(
      values
    );
    return CoreHelper.FIELD_EXTENSIONS_ACTION_UPDATED_TO_ANY_OF.run(
      actionScope
    );
  }

  public Boolean updatedTo(Object value) {
    return updatedToAnyOf(new List<Object>{ value });
  }

  public Boolean wasAnyOf(Object[] values) {
    CoreHelper.FieldExtensionsScope actionScope = this.scope.copyWithValues(
      values
    );
    return CoreHelper.FIELD_EXTENSIONS_ACTION_WAS_ANY_OF.run(actionScope);
  }

  public Boolean was(Object value) {
    return wasAnyOf(new List<Object>{ value });
  }

  public Boolean isAnyOf(Object[] values) {
    CoreHelper.FieldExtensionsScope actionScope = this.scope.copyWithValues(
      values
    );
    return CoreHelper.FIELD_EXTENSIONS_ACTION_IS_ANY_OF.run(actionScope);
  }

  public Boolean is(Object value) {
    return isAnyOf(new List<Object>{ value });
  }
}
