@IsTest
public class UuidMockConstructor implements Uuid.IConstructor {
    public Uuid construct() {
        return new UuidMock();
    }

    public Uuid construct(String uuidString) {
        return new UuidMock(uuidString);
    }
}