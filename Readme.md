### App間Keychain資料共享

為了方便示範實作，範例程式直接複制了原本的Target並將Bundle Identifier設為不同於原本的Target，這樣就會產生兩支不同的App，並實作Keychain資料共享。

Bundler Identifier分別為
```
com.8085studio.iak1
com.8085studio.iak2
```

開啟Keychain功能並將Keychain Group都設為
```
com.8085studio.iak1
```

所以在兩個Target的entitlementst檔裡都會有相同的Access Group
```
$(AppIdentifierPrefix)com.8085studio.iak1
```

接著再使用 `KeychainUtility.swift` 就可以在兩個App之間共享相同的Keychain資料了

> **Note: **範例程式中在Info.plist裡新增了一組key-value
> Key: AppIdentifierPrefix
> Value: $(AppIdentifierPrefix)
> 方便在runtime時取得App Identifier Prefix
