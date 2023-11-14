/**
 * UUID
 */
public abstract class Uuid {
    /**
     * UUIDのバリアント
     * - RFC4122_V4: RFC4122規格のバージョン4
     */
    public enum Variant {
        RFC4122_V4
    }

    static final String MSG_VARIANT_IS_NULL = 'バリアントがnullです。';
    @TestVisible
    static final String MSG_VARIANT_IS_UNSUPPORTED = 'このバリアント ({0}) のインスタンス生成はサポートされていません。';
    @TestVisible
    static final String MSG_UUID_IS_INVALID = 'UUIDの値が無効な形式です。';
    // バリアント及びバージョンとコンストラクタクラスの対応付け
    @TestVisible
    static final Map<Variant, Type> CONSTRUCTOR_CLASS_BY_VARIANT = new Map<Variant, Type>{
        Variant.RFC4122_V4 => UuidRfc4122V4.Constructor.class
    };

    String value;

    /**
     * コンストラクタ
     */
    protected Uuid() {
        this.value = generateUuid();
    }

    /**
     * コンストラクタ
     *
     * @param uuidString UUID
     * @exception IllegalArgumentException UUIDが無効な形式の場合
     */
    protected Uuid(String uuidString) {
        if (!isValid(uuidString))
            throw new IllegalArgumentException(MSG_UUID_IS_INVALID);

        this.value = uuidString;
    }

    /**
     * インスタンスを生成する
     *
     * @param variant UUIDのバリアント
     * @return インスタンス
     */
    public static Uuid newInstance(Variant variant) {
        IConstructor constructor = getConstructor(variant);
        return constructor.construct();
    }

    /**
     * インスタンスを生成する
     *
     * @param variant UUIDのバリアント
     * @param uuidString UUIDの文字列
     * @return インスタンス
     */
    public static Uuid newInstance(Variant variant, String uuidString) {
        IConstructor constructor = getConstructor(variant);
        return constructor.construct(uuidString);
    }

    /**
     * UUIDのコンストラクタを取得する
     *
     * @param variant UUIDのバリアント
     * @return UUIDのコンストラクタ。モックが設定されている場合、モックを返却
     * @exception IllegalArgumentException バリアントに対応するインスタンス生成がサポートされていない場合
     */
    private static IConstructor getConstructor(Variant variant) {
        Type constructorClass = CONSTRUCTOR_CLASS_BY_VARIANT.get(variant);
        if (constructorClass == null)
            throw new IllegalArgumentException(String.format(MSG_VARIANT_IS_UNSUPPORTED, new List<String>{ variant?.name() }));

        return (IConstructor) constructorClass.newInstance();
    }

    /**
     * UUIDの文字列を取得する
     *
     * @return UUIDの文字列
     */
    public String stringValue() {
        return this.value;
    }

    /**
     * UUIDを生成する
     *
     * @return 生成されたUUID
     */
    private abstract String generateUuid();

    /**
     * UUIDが有効な形式であることを検証する
     *
     * @param uuidString UUID
     * @return 有効である場合はtrue、それ以外の場合はfalse
     */
    private abstract Boolean isValid(String uuidString);

    /**
     * UUIDコンストラクタ
     */
    public interface IConstructor {
        /**
         * UUIDをインスタンス化する
         *
         * @return UUIDのインスタンス
         */
        Uuid construct();

        /**
         * UUIDをインスタンス化する
         *
         * @param uuidString UUIDの文字列
         * @return UUIDのインスタンス
         */
        Uuid construct(String uuidString);
    }
}