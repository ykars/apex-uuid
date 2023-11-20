# Apex UUID

このリポジトリには、UUID を生成する Apex クラスが含まれています。UUID については [Wikipedia](https://ja.wikipedia.org/wiki/UUID) を参照してください。

## 使用方法

- UUID を生成する

    - RFC4122 規格バージョン4

        ```java
        Uuid uuid = Uuid.newInstance(Uuid.Type.RFC4122_V4);
        ```

- 文字列を取得する

    ```java
    Uuid uuid = Uuid.newInstance(Uuid.Type.RFC4122_V4);
    String uuidString = uuid.stringValue();
    ```

- 既存の UUID 文字列を使用してインスタンス化する

    ```java
    String uuidString = '564f6370-b9ea-404a-8c04-b9bc508e8d7d';
    Uuid uuid = Uuid.newInstance(Uuid.Type.RFC4122_V4, uuidString);
    Assert.areEqual(uuidString, uuid.stringValue());
    ```

## インストール方法

1. リポジトリをクローンする

    ```
    git clone https://github.com/ykars/apex-uuid.git
    ```

2. クローンしたリポジトリに移動

    ```
    cd apex-uuid
    ```

3. 組織に接続し、インストールする

    - 通常の組織の場合

        1. インストール組織にログイン

            ```
            sf org login web --alias MyOrg --set-default
            ```

        2. ソースをデプロイ

            ```
            sf project deploy start
            ```

    - スクラッチ組織の場合

        1. Dev Hub 組織にログイン

            ```
            sf org login web --alias DevHubOrg --set-default-dev-hub
            ```

        2. スクラッチ組織を作成

            ```
            sf org create scratch --alias ScratchOrg --set-default --definition-file config\project-scratch-def.json
            ```

        3. ソースをデプロイ

            ```
            sf project deploy start
            ```
