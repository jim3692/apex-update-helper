public class CoreHelper {
  @TestVisible
  private static CoreHelper mockableInstance = new CoreHelper();

  public static Boolean caseSensitiveEqualityCheck(Object a, Object b) {
    if (a == null && b == null) {
      return true;
    }

    if (a == null || b == null) {
      return false;
    }

    if (a instanceof String && b instanceof String) {
      return ((String) a).equals((String) b);
    }

    return a.equals(b);
  }

  public static Boolean anyOf(Object recordValue, Object[] values) {
    for (Object value : values) {
      if (caseSensitiveEqualityCheck(recordValue, value)) {
        return true;
      }
    }

    return false;
  }

  public static Boolean falseIfNull(SObject record) {
    return record != null;
  }

  public static TriggerScope getTriggerScope() {
    return mockableInstance.mockableTriggerScope();
  }

  public TriggerScope mockableTriggerScope() {
    return new TriggerScope();
  }

  public interface IFieldExtensionsAction {
    Boolean run(FieldExtensionsScope scope);
  }

  private class FieldExtensionsActionWasUpdated extends CHExt_FieldExtensionsActionWasUpdated {
  }
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_WAS_UPDATED = new FieldExtensionsActionWasUpdated();
  private class FieldExtensionsActionUpdatedFrom extends CHExt_FieldExtensionsActionUpdatedFrom {
  }
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_UPDATED_FROM_ANY_OF = new FieldExtensionsActionUpdatedFrom();
  private class FieldExtensionsActionUpdatedTo extends CHExt_FieldExtensionsActionUpdatedTo {
  }
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_UPDATED_TO_ANY_OF = new FieldExtensionsActionUpdatedTo();
  private class FieldExtensionsActionWas extends CHExt_FieldExtensionsActionWas {
  }
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_WAS_ANY_OF = new FieldExtensionsActionWas();
  private class FieldExtensionsActionIs extends CHExt_FieldExtensionsActionIs {
  }
  public static final IFieldExtensionsAction FIELD_EXTENSIONS_ACTION_IS_ANY_OF = new FieldExtensionsActionIs();

  public class TriggerScope extends CHExt_TriggerScope {
  }
  public class FieldExtensionsScope extends CHExt_FieldExtensionsScope {
  }
}
