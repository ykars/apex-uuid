/**
 * UUID（Universally Unique Identifier）
 */
public class Uuid {
    /**
     * 16進数の基数
     */
    private static final Integer HEX_RADIX = 16;

    /**
     * 16進数で使用される文字
     */
    private static final List<String> HEX_CHARS = new List<String>{
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
        'a', 'b', 'c', 'd', 'e', 'f'
    };

    /**
     * UUIDの文字列表現
     */
    private final String uuidString;

    /**
     * コンストラクタ
     * 文字列表現を使用して新しいUUIDを構築する
     *
     * @param uuidString UUIDの文字列表現
     */
    private Uuid(String uuidString) {
        this.uuidString = uuidString;
    }

    /**
     * 文字列表現からUUIDを生成する
     *
     * @param uuidString UUIDの文字列表現
     * @return UUID
     * @exception IllegalArgumentException uuidStringが無効な形式の場合
     */
    public static Uuid fromString(String uuidString) {
        if (uuidString.length() > 36) {
            throw new IllegalArgumentException('UUID文字列が長すぎます。上限は36文字です。: ' + uuidString);
        }

        Integer dash1 = uuidString.indexOf('-', 0);
        Integer dash2 = uuidString.indexOf('-', dash1 + 1);
        Integer dash3 = uuidString.indexOf('-', dash2 + 1);
        Integer dash4 = uuidString.indexOf('-', dash3 + 1);
        Integer dash5 = uuidString.indexOf('-', dash4 + 1);

        // 有効な入力の場合、dash1 ～ dump4 は正、dash5 は負になるが、dash4 と dump5 を確認すればよい
        // - dash1 が -1 の場合、dash4 は -1 になる
        // - dash1 が正で dash2 が -1 の場合、dash4 は -1 になる
        // - dash1 と dash2 が正の場合、dash3 は -1 になり、dash4 は正になるが、dash5 も正になる
        if (dash4 < 0 || dash5 >= 0) {
            throw new IllegalArgumentException('UUID文字列が無効な形式です。: ' + uuidString);
        }

        return new Uuid(uuidString);
    }

    /**
     * 乱数に基づくUUID（UUIDバージョン4）を生成する
     *
     * @return UUID
     */
    public static Uuid randomUuid() {
        // ランダムな16進数を用意
        Blob randomBits = Crypto.generateAesKey(128);
        String randomHex = EncodingUtil.convertToHex(randomBits);

        // バリアントを用意
        String variantHex = randomHex.substring(16, 17); // 16進数の17桁目（バリアントを表す桁）を取得
        Integer variantInt = hexToInt(variantHex); // 10進数に変換
        variantInt = variantInt | 8; // 1ビット目を1にする
        variantInt = variantInt & 11; // 2ビット目を0にする
        variantHex = intToHex(variantInt); // 16進数に変換

        // バージョンを用意
        String versionHex = intToHex(4);

        // UUIDを生成
        String uuidString = String.format('{0}-{1}-{2}-{3}-{4}', new List<String>{
            randomHex.substring(0, 8),
            randomHex.substring(8, 12),
            versionHex + randomHex.substring(13, 16),
            variantHex + randomHex.substring(17, 20),
            randomHex.substring(20, 32)
        });

        return new Uuid(uuidString);
    }

    /**
     * 16進数を10進数に変換する
     *
     * @param hex 16進数の文字列表現
     * @return 10進数の整数
     * @exception IllegalArgumentException hex が null または無効な形式の場合
     */
    @TestVisible
    private static Integer hexToInt(String hex) {
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
                Integer intOfHex1Digit = HEX_CHARS.indexOf(hex1Digit);

                if (intOfHex1Digit == -1) {
                    throw new IllegalArgumentException('hex (' + hex + ') が無効な形式です。');
                }

                intValue *= HEX_RADIX;
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
    @TestVisible
    private static String intToHex(Integer i) {
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
            Integer intOf1Digit = Math.mod(i, HEX_RADIX);
            String hexOf1Digit = HEX_CHARS[intOf1Digit];
            hex = hexOf1Digit + hex;
            i = i / HEX_RADIX;
        }

        return hex;
    }

    /**
     * このUUIDの文字列表現を返す
     *
     * @return UUIDの文字列表現
     */
    public override String toString() {
        return this.uuidString;
    }
}