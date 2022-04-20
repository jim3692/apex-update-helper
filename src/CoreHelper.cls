public class CoreHelper {
  public interface IFieldExtensionsAction { Boolean run(FieldExtensionsScope extensions); }
  public interface IFutureFieldExtensionsExecutor { Boolean run(); }

  private class FieldExtensionsActionWasUpdated extends UpdateHelperExternals_FieldExtensionsActionWasUpdated {}
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_WAS_UPDATED = new FieldExtensionsActionWasUpdated();
  private class FieldExtensionsActionUpdatedFromAnyOf extends UpdateHelperExternals_FieldExtensionsActionUpdatedFromAnyOf {}
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_UPDATED_FROM_ANY_OF = new FieldExtensionsActionUpdatedFromAnyOf();
  private class FieldExtensionsActionUpdatedToAnyOf extends UpdateHelperExternals_FieldExtensionsActionUpdatedToAnyOf {}
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_UPDATED_TO_ANY_OF = new FieldExtensionsActionUpdatedToAnyOf();
  private class FieldExtensionsActionWasAnyOf extends UpdateHelperExternals_FieldExtensionsActionWasAnyOf {}
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_WAS_ANY_OF = new FieldExtensionsActionWasAnyOf();
  private class FieldExtensionsActionIsAnyOf extends UpdateHelperExternals_FieldExtensionsActionIsAnyOf {}
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_IS_ANY_OF = new FieldExtensionsActionIsAnyOf();

  public class Scope extends UpdateHelperExternals_Scope {}
  public class FieldExtensionsScope extends UpdateHelperExternals_FieldExtensionsScope {}
  public class FieldExtensions extends UpdateHelperExternals_FieldExtensions {}
  public class FutureFieldExtensions extends UpdateHelperExternals_FutureFieldExtensions {}

  public class UpdateHelperInvalidFieldException extends Exception {}
}
