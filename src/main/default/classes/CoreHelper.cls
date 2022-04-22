public class CoreHelper {
  @TestVisible
  private static CoreHelper mockableInstance = new CoreHelper();

  /* bundler-make-private */ public static Boolean anyOf (Object recordValue, Object[] values) {
    for (Object value : values) {
      if (recordValue == null && value == null) {
        return true;
      }

      if (recordValue instanceof String) {
        Integer diff = ((String)recordValue).compareTo((String)value);
        if (diff == 0) {
          return true;
        }
      } else if (recordValue.equals(value)) {
        return true;
      }
    }

    return false;
  }

  /* bundler-make-private */ public static Boolean falseIfNull (SObject record) {
    return record != null;
  }

  public static TriggerScope getTriggerScope () {
    return mockableInstance.mockableTriggerScope();
  }

  public TriggerScope mockableTriggerScope () {
    return new TriggerScope();
  }

  public interface IFieldExtensionsAction { Boolean run(FieldExtensionsScope scope); }

  private class FieldExtensionsActionWasUpdated extends UHExt_FieldExtensionsActionWasUpdated {}
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_WAS_UPDATED = new FieldExtensionsActionWasUpdated();
  private class FieldExtensionsActionUpdatedFrom extends UHExt_FieldExtensionsActionUpdatedFrom {}
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_UPDATED_FROM_ANY_OF = new FieldExtensionsActionUpdatedFrom();
  private class FieldExtensionsActionUpdatedTo extends UHExt_FieldExtensionsActionUpdatedTo {}
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_UPDATED_TO_ANY_OF = new FieldExtensionsActionUpdatedTo();
  private class FieldExtensionsActionWas extends UHExt_FieldExtensionsActionWas {}
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_WAS_ANY_OF = new FieldExtensionsActionWas();
  private class FieldExtensionsActionIs extends UHExt_FieldExtensionsActionIs {}
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_IS_ANY_OF = new FieldExtensionsActionIs();

  public class TriggerScope extends UHExt_TriggerScope {}
  public class FieldExtensionsScope extends UHExt_FieldExtensionsScope {}
  public class FieldExtensions extends UHExt_FieldExtensions {}
  public class FutureFieldExtensions extends UHExt_FutureFieldExtensions {}
  public class FutureFieldExtensionsExecutor extends UHExt_FutureFieldExtensionsExecutor {}

  public class WhenTheExtensions extends CHExt_WhenTheExtensions {}

  public class UpdateHelperInvalidFieldException extends Exception {}
  public class UpdateHelperNullRecordIdException extends Exception {}
}
