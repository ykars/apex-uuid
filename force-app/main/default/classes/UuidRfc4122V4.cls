/**
 * バージョン4バリアント2のUUID
 */
public class UuidRfc4122V4 extends Uuid {
    @TestVisible
    static final String UUID_FORMAT_REGEX = '[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}';

    /**
     * コンストラクタ
     */
    public UuidRfc4122V4() {
        super();
    }

    /**
     * コンストラクタ
     *
     * @param uuidString UUID
     */
    public UuidRfc4122V4(String uuidString) {
        super(uuidString);
    }

    private String generateUuid() {
        // ランダムな16進数を用意
        Blob randomBits = Crypto.generateAesKey(128);
        String randomHexString = EncodingUtil.convertToHex(randomBits);

        // バリアントを用意
        String variantHex = randomHexString.substring(16, 17); // 16進数の17桁目(バリアントを表す桁)を取得
        Integer variantInteger = IntegerUtils.fromHexString(variantHex); // 10進数に変換
        variantInteger = variantInteger | 8; // 1ビット目を1にする
        variantInteger = variantInteger & 11; // 2ビット目を0にする
        variantHex = IntegerUtils.toHexString(variantInteger); // 16進数に変換

        // バージョンを用意
        String versionHex = IntegerUtils.toHexString(4);

        // UUIDを生成
        String uuidString = String.format('{0}-{1}-{2}-{3}-{4}', new List<String>{
            randomHexString.substring(0, 8),
            randomHexString.substring(8, 12),
            versionHex + randomHexString.substring(13, 16),
            variantHex + randomHexString.substring(17, 20),
            randomHexString.substring(20, 32)
        });

        return uuidString;
    }

    private Boolean isValid(String uuidString) {
        if (String.isBlank(uuidString))
            return false;

        Pattern uuidPattern = Pattern.compile(UUID_FORMAT_REGEX.toLowerCase());
        Matcher uuidMatcher = uuidPattern.matcher(uuidString.toLowerCase());

        return uuidMatcher.matches();
    }

    public class Constructor implements Uuid.IConstructor {
        public Uuid construct() {
            return new UuidRfc4122V4();
        }

        public Uuid construct(String uuidString) {
            return new UuidRfc4122V4(uuidString);
        }
    }
}