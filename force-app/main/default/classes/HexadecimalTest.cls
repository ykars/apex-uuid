/**
 * Hexadecimalクラステスト
 */
@IsTest(IsParallel=true)
private class HexadecimalTest {
    @IsTest
    static void constructor_When_ArgumentIsHexadecimal_Expect_Success() {
        // 準備
        String validHexString = '01';

        // 実行 & 検証
        try {
            Hexadecimal hex = new Hexadecimal(validHexString);
        } catch (Exception e) {
            Assert.fail();
        }
    }

    @IsTest
    static void constructor_When_ArgumentIsNotHexadecimal_Expect_ThrowException() {
        // 準備
        String invalidHexString = 'invalid';

        // 実行 & 検証
        try {
            Hexadecimal hex = new Hexadecimal(invalidHexString);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual(Hexadecimal.MSG_INVALID_FORMAT, e.getMessage());
        }
    }

    @IsTest
    static void valueOf_When_CallStringValue_Expect_ReturnHexadecimal() {
        // 準備
        Integer intValue = 255;

        // 実行
        Hexadecimal hex = Hexadecimal.valueOf(intValue);

        // 検証
        Assert.areEqual('ff', hex.stringValue());
    }

    @IsTest
    static void valueOf_When_ArgumentIsNull_Expect_ThrowException() {
        // 準備
        Integer intValue = null;

        // 実行 & 検証
        try {
            Hexadecimal hex = Hexadecimal.valueOf(intValue);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual(Hexadecimal.MSG_INTEGER_IS_NULL, e.getMessage());
        }
    }

    @IsTest
    static void isHexadecimal_When_ArgumentIsHexadecimal_Expect_ReturnTrue() {
        // 準備
        String hexString = '0123456789abcdef';

        // 実行
        Boolean isHexadecimal = Hexadecimal.isHexadecimal(hexString);

        // 検証
        Assert.isTrue(isHexadecimal);
    }

    @IsTest
    static void isHexadecimal_When_ArgumentIsHexadecimalWithPrefix_Expect_ReturnTrue() {
        // 準備
        String hexString = Hexadecimal.PREFIX + '0123456789abcdef';

        // 実行
        Boolean isHexadecimal = Hexadecimal.isHexadecimal(hexString);

        // 検証
        Assert.isTrue(isHexadecimal);
    }

    @IsTest
    static void isHexadecimal_When_ArgumentIsNotHexadecimal_Expect_ReturnFalse() {
        // 準備
        String hexString = 'This is not Hexadecimal';

        // 実行
        Boolean isHexadecimal = Hexadecimal.isHexadecimal(hexString);

        // 検証
        Assert.isFalse(isHexadecimal);
    }

    @IsTest
    static void isHexadecimal_When_ArgumentIsNull_Expect_ReturnFalse() {
        // 準備
        String hexString = null;

        // 実行
        Boolean isHexadecimal = Hexadecimal.isHexadecimal(hexString);

        // 検証
        Assert.isFalse(isHexadecimal);
    }

    @IsTest
    static void isHexadecimal_When_ArgumentIsEmptyString_Expect_ReturnFalse() {
        // 準備
        String hexString = '';

        // 実行
        Boolean isHexadecimal = Hexadecimal.isHexadecimal(hexString);

        // 検証
        Assert.isFalse(isHexadecimal);
    }

    @IsTest
    static void stringValue_When_ConstructByHexadecimal_Expect_ReturnHexadecimal() {
        // 準備
        String hexString = 'ff';

        // 実行
        Hexadecimal hex = new Hexadecimal(hexString);

        // 検証
        Assert.areEqual(hexString, hex.stringValue());
    }

    @IsTest
    static void setValue_When_ArgumentIsHexadecimal_Expect_StringValueReturnHexadecimal() {
        // 準備
        String hexString = '01';
        String hexString2 = 'ff';

        // 実行
        Hexadecimal hex = new Hexadecimal(hexString);
        hex.setValue(hexString2);

        // 検証
        Assert.areEqual(hexString2, hex.stringValue());
    }

    @IsTest
    static void setValue_When_ArgumentIsHexadecimalWithPrefix_Expect_StringValueReturnHexadecimalWithoutPrefix() {
        // 準備
        String hexString = Hexadecimal.PREFIX + '01';
        String hexString2 = Hexadecimal.PREFIX + 'ff';

        // 実行
        Hexadecimal hex = new Hexadecimal(hexString);
        hex.setValue(hexString2);

        // 検証
        Assert.areEqual('ff', hex.stringValue());
    }

    @IsTest
    static void setValue_When_ArgumentIsNotHexadecimal_Expect_ThrowException() {
        // 準備
        String hexString = '01';
        String invalidHexString = 'invalid';

        // 実行 & 検証
        Hexadecimal hex = new Hexadecimal(hexString);
        try {
            hex.setValue(invalidHexString);
            Assert.fail();
        } catch (IllegalArgumentException e) {
            Assert.areEqual(Hexadecimal.MSG_INVALID_FORMAT, e.getMessage());
        }
    }

    @IsTest
    static void toInteger_When_Call_Expect_ReturnInteger() {
        // 準備
        String hexString = 'ff';

        // 実行
        Hexadecimal hex = new Hexadecimal(hexString);
        Integer intValue = hex.toInteger();

        // 検証
        Assert.areEqual(255, intValue);
    }
}