/**
 * UuidRfc4122V4クラステスト
 */
@IsTest(IsParallel=true)
private class UuidRfc4122V4Test {
    @IsTest
    static void constructor_When_CallDefaultConstructor_Expect_GenerateUuid() {
        // 準備
        // なし

        // 実行
        UuidRfc4122V4 uuid = new UuidRfc4122V4();

        // 検証
        Pattern uuidPattern = Pattern.compile(UuidRfc4122V4.UUID_FORMAT_REGEX);
        Matcher uuidMatcher = uuidPattern.matcher(uuid.stringValue());
        Assert.isTrue(uuidMatcher.matches());
    }

    @IsTest
    static void constructor_When_UuidStringIsValid_Expect_ConstructByUuidString() {
        // 準備
        String uuidString = '00000000-0000-4000-8000-000000000000';

        // 実行
        UuidRfc4122V4 uuid = new UuidRfc4122V4(uuidString);

        // 検証
        Assert.areEqual(uuidString, uuid.stringValue());
    }

    @IsTest
    static void constructor_When_UuidStringIsEmptyString_Expect_ThrowException() {
        // 準備
        String uuidString = '';

        // 実行 & 検証
        try {
            UuidRfc4122V4 uuid = new UuidRfc4122V4(uuidString);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('uuidString (' + uuidString + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void constructor_When_UuidStringIsInvalid_Expect_ThrowException() {
        // 準備
        String uuidString = '00000000-0000-0000-0000-000000000000';

        // 実行 & 検証
        try {
            UuidRfc4122V4 uuid = new UuidRfc4122V4(uuidString);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('uuidString (' + uuidString + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void Constructor_construct_When_Call_Expect_ReturnUuid() {
        // 準備
        // なし

        // 実行
        UuidRfc4122V4.Constructor constructor = new UuidRfc4122V4.Constructor();
        Uuid uuid = constructor.construct();

        // 検証
        Pattern uuidPattern = Pattern.compile(UuidRfc4122V4.UUID_FORMAT_REGEX);
        Matcher uuidMatcher = uuidPattern.matcher(uuid.stringValue());
        Assert.isTrue(uuidMatcher.matches());
    }

    @IsTest
    static void Constructor_construct_When_CallWithUuidString_Expect_ReturnUuid() {
        // 準備
        String uuidString = '00000000-0000-4000-8000-000000000000';

        // 実行
        UuidRfc4122V4.Constructor constructor = new UuidRfc4122V4.Constructor();
        Uuid uuid = constructor.construct(uuidString);

        // 検証
        Pattern uuidPattern = Pattern.compile(UuidRfc4122V4.UUID_FORMAT_REGEX);
        Matcher uuidMatcher = uuidPattern.matcher(uuid.stringValue());
        Assert.isTrue(uuidMatcher.matches());
    }
}