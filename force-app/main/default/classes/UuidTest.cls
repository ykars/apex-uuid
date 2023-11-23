/**
 * Uuidクラステスト
 */
@IsTest(IsParallel=true)
private class UuidTest {
    private static final String UUID_V4_FORMAT_REGEX = '[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab]{1}[0-9a-f]{3}-[0-9a-f]{12}';

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

    @IsTest
    static void hexToInt_When_ArgumentIsPositive_Expect_ReturnInteger() {
        // 準備
        String hex = 'ff';

        // 実行
        Integer intValue = Uuid.hexToInt(hex);

        // 検証
        Assert.areEqual(255, intValue);
    }

    @IsTest
    static void hexToInt_When_ArgumentIsNegative_Expect_ReturnInteger() {
        // 準備
        String hex = '-ff';

        // 実行
        Integer intValue = Uuid.hexToInt(hex);

        // 検証
        Assert.areEqual(-255, intValue);
    }

    @IsTest
    static void hexToInt_When_ArgumentIsZero_Expect_ReturnInteger() {
        // 準備
        String hex = '0';

        // 実行
        Integer intValue = Uuid.hexToInt(hex);

        // 検証
        Assert.areEqual(0, intValue);
    }

    @IsTest
    static void hexToInt_When_ArgumentIsNull_Expect_ThrowException() {
        // 準備
        String hex = null;

        // 実行 & 検証
        try {
            Uuid.hexToInt(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex が null です。', e.getMessage());
        }
    }

    @IsTest
    static void hexToInt_When_ArgumentIsEmptyString_Expect_ThrowException() {
        // 準備
        String hex = '';

        // 実行 & 検証
        try {
            Uuid.hexToInt(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex (' + hex + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void hexToInt_When_ArgumentIsPlusOnly_Expect_ThrowException() {
        // 準備
        String hex = '+';

        // 実行 & 検証
        try {
            Uuid.hexToInt(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex (' + hex + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void hexToInt_When_ArgumentIsMinusOnly_Expect_ThrowException() {
        // 準備
        String hex = '-';

        // 実行 & 検証
        try {
            Uuid.hexToInt(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex (' + hex + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void hexToInt_When_ArgumentIsInvalidFormat_Expect_ThrowException() {
        // 準備
        String hex = ' ';

        // 実行 & 検証
        try {
            Uuid.hexToInt(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex (' + hex + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void hexToInt_When_ArgumentIsInvalidFormat2_Expect_ThrowException() {
        // 準備
        String hex = 'zzz';

        // 実行 & 検証
        try {
            Uuid.hexToInt(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex (' + hex + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void intToHex_When_ArgumentIsPositive_Expect_ReturnHexString() {
        // 準備
        Integer intValue = 255;

        // 実行
        String hex = Uuid.intToHex(intValue);

        // 検証
        Assert.areEqual('ff', hex);
    }

    @IsTest
    static void intToHex_When_ArgumentIsZero_Expect_ReturnHexString() {
        // 準備
        Integer intValue = 0;

        // 実行
        String hex = Uuid.intToHex(intValue);

        // 検証
        Assert.areEqual('0', hex);
    }

    @IsTest
    static void intToHex_When_ArgumentIsNegetive_Expect_ThrowException() {
        // 準備
        Integer intValue = -255;

        // 実行 & 検証
        try {
            Uuid.intToHex(intValue);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('i (' + intValue + ') が負の値です。負の値はサポートされていません。', e.getMessage());
        }
    }

    @IsTest
    static void intToHex_When_ArgumentIsNull_Expect_ThrowException() {
        // 準備
        Integer intValue = null;

        // 実行 & 検証
        try {
            Uuid.intToHex(intValue);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('i が null です。', e.getMessage());
        }
    }
}