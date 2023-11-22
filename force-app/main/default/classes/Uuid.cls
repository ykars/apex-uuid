/**
 * UUID（Universally Unique Identifier）
 */
public class Uuid {
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
        Integer variantInt = IntegerUtils.fromHexString(variantHex); // 10進数に変換
        variantInt = variantInt | 8; // 1ビット目を1にする
        variantInt = variantInt & 11; // 2ビット目を0にする
        variantHex = IntegerUtils.toHexString(variantInt); // 16進数に変換

        // バージョンを用意
        String versionHex = IntegerUtils.toHexString(4);

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
     * このUUIDの文字列表現を返す
     *
     * @return UUIDの文字列表現
     */
    public override String toString() {
        return this.uuidString;
    }
}