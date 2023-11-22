/**
 * Uuidクラステスト
 */
@IsTest(IsParallel=true)
private class UuidTest {
    private static final String UUID_V4_FORMAT_REGEX = '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89ab]{1}[0-9a-fA-F]{3}-[0-9a-fA-F]{12}';

    @IsTest
    static void fromString_When_ArgumentIsValid_Expect_ReturnUuid() {
        // 準備
        String uuidString = '564f6370-b9ea-404a-8c04-b9bc508e8d7d';

        // 実行
        Uuid uuid = Uuid.fromString(uuidString);

        // 検証
        Assert.areEqual(uuidString, uuid.toString());
    }

    @IsTest
    static void fromString_When_ArgumentIsTooLong_Expect_ThrowException() {
        // 準備
        String uuidString = '564f6370-b9ea-404a-8c04-b9bc508e8d7daaaaaaaaaaaaa';

        // 実行 & 検証
        try {
            Uuid uuid = Uuid.fromString(uuidString);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('UUID文字列が長すぎます。上限は36文字です。: ' + uuidString, e.getMessage());
        }
    }

    @IsTest
    static void fromString_When_ArgumentIsInvalid_Expect_ThrowException() {
        // 準備
        String uuidString = 'This is invalid';

        // 実行 & 検証
        try {
            Uuid uuid = Uuid.fromString(uuidString);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('UUID文字列が無効な形式です。: ' + uuidString, e.getMessage());
        }
    }

    @IsTest
    static void randomUuid_When_Call_Expect_ReturnUuid() {
        // 準備
        // なし

        // 実行
        Uuid uuid = Uuid.randomUuid();

        // 検証
        Pattern uuidV4Pattern = Pattern.compile(UUID_V4_FORMAT_REGEX);
        Matcher uuidV4Matcher = uuidV4Pattern.matcher(uuid.toString());
        Assert.isTrue(uuidV4Matcher.matches());
    }
}