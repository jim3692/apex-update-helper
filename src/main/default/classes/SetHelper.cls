public class SetHelper {
  private final List<SObject> records;

  public static SetHelper of (List<SObject> records) {
    return new SetHelper(records);
  }

  private SetHelper (List<SObject> records) {
    this.records = records;
  }

  public WhenExtensions whenThe (UpdateHelper helper) {
    System.assert(helper?.futureRecord != null);
  }
}
