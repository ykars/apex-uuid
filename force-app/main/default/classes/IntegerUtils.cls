/**
 * Integer ユーティリティ
 */
public class IntegerUtils {
    /**
     * 16進数を10進数に変換する
     *
     * @param hex 16進数の文字列表現
     * @return 10進数の整数
     * @exception IllegalArgumentException hex が null または無効な形式の場合
     */
    public static Integer fromHexString(String hex) {
        if (hex == null) {
            throw new IllegalArgumentException('hex が null です。');
        }

        Boolean isNegative = false;
        Integer i = 0;
        Integer len = hex.length();

        if (len > 0) {
            String firstChar = hex.substring(0, 1);
            if (firstChar < '0') { // 先頭に「+」または「-」を付けることができる
                if (firstChar == '-') {
                    isNegative = true;
                } else if (firstChar != '+') {
                    throw new IllegalArgumentException('hex (' + hex + ') が無効な形式です。');
                }

                if (len == 1) { // 単独の「+」または「-」のみは使用できない
                    throw new IllegalArgumentException('hex (' + hex + ') が無効な形式です。');
                }
                i++;
            }

            Integer intValue = 0;
            while (i < len) {
                String hex1Digit = hex.substring(i, i + 1);
                Integer intOfHex1Digit = HexConstants.CHARS.indexOf(hex1Digit);

                if (intOfHex1Digit == -1) {
                    throw new IllegalArgumentException('hex (' + hex + ') が無効な形式です。');
                }

                intValue *= HexConstants.RADIX;
                intValue += intOfHex1Digit;
                i++;
            }
            return isNegative ? -intValue : intValue;
        } else {
            throw new IllegalArgumentException('hex (' + hex + ') が無効な形式です。');
        }
    }

    /**
     * 10進数を16進数に変換する
     *
     * @param i 16進数に変換する10進数の整数
     * @return 16進数の文字列表現
     * @exception IllegalArgumentException i が null または負の値である場合
     */
    public static String toHexString(Integer i) {
        if (i == null) {
            throw new IllegalArgumentException('i が null です。');
        }

        if (i == 0) {
            return '0';
        } else if (i < 0) {
            // TODO: 負の値の場合、2の補数で表す（全ビット反転 + 1）
            // 現在はサポートされていないためエラーとする
            throw new IllegalArgumentException('i (' + i + ') が負の値です。負の値はサポートされていません。');
        }

        // 10進数の右側から1桁ずつ16進数に変換する
        String hex = '';
        while (i > 0) {
            Integer intOf1Digit = Math.mod(i, HexConstants.RADIX);
            String hexOf1Digit = HexConstants.CHARS[intOf1Digit];
            hex = hexOf1Digit + hex;
            i = i / HexConstants.RADIX;
        }

        return hex;
    }
}