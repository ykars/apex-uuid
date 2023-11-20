/**
 * Uuidクラステスト
 */
@IsTest(IsParallel=true)
private class UuidTest {
    @IsTest
    static void constructor_When_CallDefaultConstructor_Expect_GenerateUuid() {
        // 準備
        UuidMock.generatedUuid = 'This is UUID';

        // 実行
        Uuid uuid = new UuidMock();

        // 検証
        Assert.areEqual(UuidMock.generatedUuid, uuid.stringValue());
    }

    @IsTest
    static void constructor_When_UuidStringIsValid_Expect_ConstructByUuidString() {
        // 準備
        UuidMock.isValid = true;
        String uuidString = 'This is valid UUID';

        // 実行
        Uuid uuid = new UuidMock(uuidString);

        // 検証
        Assert.areEqual(uuidString, uuid.stringValue());
    }

    @IsTest
    static void constructor_When_UuidStringIsInvalid_Expect_ThrowException() {
        // 準備
        UuidMock.isValid = false;

        // 実行 & 検証
        try {
            Uuid uuid = new UuidMock('This is invalid UUID');
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('uuidString (This is invalid UUID) が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void newInstance_When_TypeIsSupported_Expect_ReturnUuid() {
        // 準備
        Uuid.CONSTRUCTOR_CLASS_BY_VARIANT.clear();
        Uuid.CONSTRUCTOR_CLASS_BY_VARIANT.put(null, UuidMock.Constructor.class);
        Uuid.Type uuidType = null;

        // 実行
        Uuid uuid = Uuid.newInstance(uuidType);

        // 検証
        Assert.isInstanceOfType(uuid, UuidMock.class);
    }

    @IsTest
    static void newInstance_When_TypeIsUnsupported_Expect_ThrowException() {
        // 準備
        Uuid.CONSTRUCTOR_CLASS_BY_VARIANT.clear();
        Uuid.Type uuidType = null;

        // 実行 & 検証
        try {
            Uuid uuid = Uuid.newInstance(uuidType);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('uuidType (' + uuidType?.name() + ') がサポートされていません。', e.getMessage());
        }
    }

    @IsTest
    static void newInstance_When_CallWithUuidString_Expect_ReturnUuidHasUuidString() {
        // 準備
        Uuid.CONSTRUCTOR_CLASS_BY_VARIANT.clear();
        Uuid.CONSTRUCTOR_CLASS_BY_VARIANT.put(null, UuidMock.Constructor.class);
        Uuid.Type uuidType = null;
        String uuidString = 'test';

        // 実行
        Uuid uuid = Uuid.newInstance(uuidType, uuidString);

        // 検証
        Assert.areEqual(uuidString, uuid.stringValue());
    }
}