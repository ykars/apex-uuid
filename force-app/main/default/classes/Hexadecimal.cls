/**
 * 16進数
 */
public class Hexadecimal {
    public static final String PREFIX = '0x';
    static final String HEX_CAHRACTERS = '0123456789abcdef';
    static final String HEX_FORMAT_REGEX = '(0x|)[0-9a-f]+';
    @TestVisible
    static final String MSG_INVALID_FORMAT = '有効な16進数の形式ではありません。';
    @TestVisible
    static final String MSG_INTEGER_IS_NULL = '10進数の整数値がnullです。';

    String value;

    /**
     * コンストラクタ
     *
     * @param hex 16進数の文字列表現
     * @exception IllegalArgumentException 有効な16進数の形式ではない場合
     */
    public Hexadecimal(String hex) {
        setValue(hex);
    }

    /**
     * 指定した10進数の整数値を使用してインスタンス化する
     *
     * @param intValue 10進数の整数値
     * @return インスタンス
     * @exception IllegalArgumentException 10進数の整数値がnullの場合
     */
    public static Hexadecimal valueOf(Integer intValue) {
        if (intValue == null)
            throw new IllegalArgumentException(MSG_INTEGER_IS_NULL);

        // 10進数の右側から1桁ずつ16進数に変換する
        String hex = '';
        while (intValue > 0) {
            Integer hexCharsIndex = Math.mod(intValue, 16);
            String hexChar = HEX_CAHRACTERS.substring(hexCharsIndex, hexCharsIndex + 1);
            hex = hexChar + hex;
            intValue = intValue / 16;
        }

        return new Hexadecimal(hex);
    }

    /**
     * 有効な16進数である場合、trueを返却する
     *
     * @param hex 16進数の文字列表現
     * @return 有効な16進数である場合はtrue、それ以外の場合、false
     */
    public static Boolean isHexadecimal(String hex) {
        if (String.isBlank(hex))
            return false;

        Pattern hexPattern = Pattern.compile(HEX_FORMAT_REGEX);
        Matcher hexMatcher = hexPattern.matcher(hex);

        return hexMatcher.matches();
    }

    /**
     * 16進数の文字列表現を取得する
     *
     * @return 16進数の文字列表現
     */
    public String stringValue() {
        return this.value;
    }

    /**
     * 値を設定する
     *
     * @param hex 16進数の文字列表現
     * @exception IllegalArgumentException 有効な16進数の形式ではない場合
     */
    public void setValue(String hex) {
        if (!isHexadecimal(hex))
            throw new IllegalArgumentException(MSG_INVALID_FORMAT);

        // プレフィックス付きの場合は取り除く
        if (hex.startsWith(PREFIX))
            hex = hex.substringAfter(PREFIX);

        this.value = hex;
    }

    /**
     * 10進数のInteger型に変換する
     *
     * @return 10進数の値
     */
    public Integer toInteger() {
        // 16進数の先頭から1桁ずつ10進数に変換する
        Integer intValue = 0;
        for (String hexChar : stringValue().split('')) {
            intValue = intValue * 16 + HEX_CAHRACTERS.indexOf(hexChar);
        }
        return intValue;
    }
}