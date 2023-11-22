# Apex UUID

このリポジトリには、UUID を生成する Apex クラスが含まれています。UUID については [Wikipedia](https://ja.wikipedia.org/wiki/UUID) を参照してください。

## 使用方法

- 乱数に基づく UUID（UUID バージョン4）を生成する

    ```java
    Uuid uuid = Uuid.randomUuid();
    ```

- UUID の文字列表現を取得する

    ```java
    Uuid uuid = Uuid.randomUuid();
    String uuidString = uuid.toString();
    ```

- 文字列表現から UUID を生成する

    ```java
    Uuid uuid = Uuid.fromString('564f6370-b9ea-404a-8c04-b9bc508e8d7d');
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
