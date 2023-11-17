/**
 * IntegerUtils クラステスト
 */
@IsTest
private class IntegerUtilsTest {
    @IsTest
    static void fromHexString_When_ArgumentIsPositive_Expect_ReturnInteger() {
        // 準備
        String hex = 'ff';

        // 実行
        Integer intValue = IntegerUtils.fromHexString(hex);

        // 検証
        Assert.areEqual(255, intValue);
    }

    @IsTest
    static void fromHexString_When_ArgumentIsNegative_Expect_ReturnInteger() {
        // 準備
        String hex = '-ff';

        // 実行
        Integer intValue = IntegerUtils.fromHexString(hex);

        // 検証
        Assert.areEqual(-255, intValue);
    }

    @IsTest
    static void fromHexString_When_ArgumentIsZero_Expect_ReturnInteger() {
        // 準備
        String hex = '0';

        // 実行
        Integer intValue = IntegerUtils.fromHexString(hex);

        // 検証
        Assert.areEqual(0, intValue);
    }

    @IsTest
    static void fromHexString_When_ArgumentIsNull_Expect_ThrowException() {
        // 準備
        String hex = null;

        // 実行 & 検証
        try {
            IntegerUtils.fromHexString(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex が null です。', e.getMessage());
        }
    }

    @IsTest
    static void fromHexString_When_ArgumentIsEmptyString_Expect_ThrowException() {
        // 準備
        String hex = '';

        // 実行 & 検証
        try {
            IntegerUtils.fromHexString(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex (' + hex + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void fromHexString_When_ArgumentIsPlusOnly_Expect_ThrowException() {
        // 準備
        String hex = '+';

        // 実行 & 検証
        try {
            IntegerUtils.fromHexString(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex (' + hex + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void fromHexString_When_ArgumentIsMinusOnly_Expect_ThrowException() {
        // 準備
        String hex = '-';

        // 実行 & 検証
        try {
            IntegerUtils.fromHexString(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex (' + hex + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void fromHexString_When_ArgumentIsInvalidFormat_Expect_ThrowException() {
        // 準備
        String hex = ' ';

        // 実行 & 検証
        try {
            IntegerUtils.fromHexString(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex (' + hex + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void fromHexString_When_ArgumentIsInvalidFormat2_Expect_ThrowException() {
        // 準備
        String hex = 'zzz';

        // 実行 & 検証
        try {
            IntegerUtils.fromHexString(hex);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('hex (' + hex + ') が無効な形式です。', e.getMessage());
        }
    }

    @IsTest
    static void toHexString_When_ArgumentIsPositive_Expect_ReturnHexString() {
        // 準備
        Integer intValue = 255;

        // 実行
        String hex = IntegerUtils.toHexString(intValue);

        // 検証
        Assert.areEqual('ff', hex);
    }

    @IsTest
    static void toHexString_When_ArgumentIsZero_Expect_ReturnHexString() {
        // 準備
        Integer intValue = 0;

        // 実行
        String hex = IntegerUtils.toHexString(intValue);

        // 検証
        Assert.areEqual('0', hex);
    }

    @IsTest
    static void toHexString_When_ArgumentIsNegetive_Expect_ThrowException() {
        // 準備
        Integer intValue = -255;

        // 実行 & 検証
        try {
            IntegerUtils.toHexString(intValue);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('i (' + intValue + ') が負の値です。負の値はサポートされていません。', e.getMessage());
        }
    }

    @IsTest
    static void toHexString_When_ArgumentIsNull_Expect_ThrowException() {
        // 準備
        Integer intValue = null;

        // 実行 & 検証
        try {
            IntegerUtils.toHexString(intValue);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('i が null です。', e.getMessage());
        }
    }
}