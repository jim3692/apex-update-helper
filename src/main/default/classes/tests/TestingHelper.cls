public class TestingHelper {

  private static Integer fakeIdCounter = 1;

  // Source: https://salesforce.stackexchange.com/a/21297
  @TestVisible
  private static String getFakeId(SObjectType sot) {
    String result = String.valueOf(fakeIdCounter++);
    return sot.getDescribe().getKeyPrefix() +
      '0'.repeat(12-result.length()) + result;
  }

}
