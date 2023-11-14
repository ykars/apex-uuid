@IsTest
public class UuidMock extends Uuid {
    public static String generatedUuid = 'uuid';
    public static Boolean isValid = true;

    public UuidMock() {
        super();
    }

    public UuidMock(String uuidString) {
        super(uuidString);
    }

    private String generateUuid() {
        return generatedUuid;
    }

    private Boolean isValid(String uuidString) {
        return isValid;
    }
}