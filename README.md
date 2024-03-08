鸿蒙Preferences封装（支持存储读取对象！）

前言

看过鸿蒙的官方技术文档都知道，鸿蒙的Preferences只支持存储以下几种类型

```
type ValueType = number | string | boolean | Array<number> | Array<string> | Array<boolean>;
```



我举个例子，登录的时候我们习惯把用户信息存储在本地，这时候Preferences是不支持把整个登录信息的对象存储起来的，这时候小伙伴就着急啦，那我如果要存储一个对象咋存储啊，不是要每个字段都要去存储一遍吗？

别着急，小编这时候就帮你分析如何利用现用的资源实现Preferences的封装，并支持存储读取对象，满足你的要求！

首先我们构建一个PreferenceUtil的工具类，并提供一个初始化Preferences的方法

```
export class PreferenceUtil {
  private static readonly TAG: string = 'PreferenceUtil';

  private static async getPreferences() {
    try {
      preference = await dataPreferences.getPreferences(context, Constant.PREFERENCE_NAME)
    } catch (e) {
      Logger.error(this.TAG, 'Failed to get preferences, cause:' + e)
    }
  }

}
```

下一步我们就是先封装官方提供的几种数据结构的封装（number、string、boolean、Array<number>、Array<string>、Array<boolean>）

```
static async writeString(key: string, value?: string) {
  if (preference == null) {
    await this.getPreferences()
  }
  try {
    await preference.put(key, value)
  } catch (e) {
    Logger.error(this.TAG, 'Failed to write value, cause:' + e)
  }
  await preference.flush()
}

static async readString(key: string, defaultValue?: string) {
  if (preference == null) {
    await this.getPreferences()
  }
  let value: string
  try {
    value = await preference.get(key, defaultValue).then()
  } catch (e) {
    Logger.error(this.TAG, 'Failed to read value, cause:' + e)
  }
  return value
}

static async writeArrayString(key: string, value?: Array<string>) {
  if (preference == null) {
    await this.getPreferences()
  }
  try {
    await preference.put(key, value)
  } catch (e) {
    Logger.error(this.TAG, 'Failed to write value, cause:' + e)
  }
  await preference.flush()
}

static async readArrayString(key: string, defaultValue?: Array<string>) {
  if (preference == null) {
    await this.getPreferences()
  }
  let value: Array<string>
  try {
    value = await preference.get(key, defaultValue).then()
  } catch (e) {
    Logger.error(this.TAG, 'Failed to read value, cause:' + e)
  }
  return value
}

static async writeNumber(key: string, value?: number) {
  if (preference == null) {
    await this.getPreferences()
  }
  try {
    await preference.put(key, value)
  } catch (e) {
    Logger.error(this.TAG, 'Failed to write value, cause:' + e)
  }
  await preference.flush()
}

static async readNumber(key: string, defaultValue?: number) {
  if (preference == null) {
    await this.getPreferences()
  }
  let value: number
  try {
    value = await preference.get(key, defaultValue).then()
  } catch (e) {
    Logger.error(this.TAG, 'Failed to read value, cause:' + e)
  }
  return value
}

static async writeArrayNumber(key: string, value?: Array<number>) {
  if (preference == null) {
    await this.getPreferences()
  }
  try {
    await preference.put(key, value)
  } catch (e) {
    Logger.error(this.TAG, 'Failed to write value, cause:' + e)
  }
  await preference.flush()
}

static async readArrayNumber(key: string, defaultValue?: Array<number>) {
  if (preference == null) {
    await this.getPreferences()
  }
  let value: Array<number>
  try {
    value = await preference.get(key, defaultValue).then()
  } catch (e) {
    Logger.error(this.TAG, 'Failed to read value, cause:' + e)
  }
  return value
}

static async writeBoolean(key: string, value?: boolean) {
  if (preference == null) {
    await this.getPreferences()
  }
  try {
    await preference.put(key, value)
  } catch (e) {
    Logger.error(this.TAG, 'Failed to write value, cause:' + e)
  }
  await preference.flush()
}

static async readBoolean(key: string, defaultValue?: boolean) {
  if (preference == null) {
    await this.getPreferences()
  }
  let value: boolean
  try {
    value = await preference.get(key, defaultValue).then()
  } catch (e) {
    Logger.error(this.TAG, 'Failed to read value, cause:' + e)
  }
  return value
}

static async writeArrayBoolean(key: string, value?: Array<boolean>) {
  if (preference == null) {
    await this.getPreferences()
  }
  try {
    await preference.put(key, value)
  } catch (e) {
    Logger.error(this.TAG, 'Failed to write value, cause:' + e)
  }
  await preference.flush()
}

static async readArrayBoolean(key: string, defaultValue?: Array<boolean>) {
  if (preference == null) {
    await this.getPreferences()
  }
  let value: Array<boolean>
  try {
    value = await preference.get(key, defaultValue).then()
  } catch (e) {
    Logger.error(this.TAG, 'Failed to read value, cause:' + e)
  }
  return value
}
```

小伙伴们是不是着急啦，我要的存储对象的能力呢！好啦，小编已经快马加鞭在实现了，具体请看下面实现方式

第一步：我们先将要存储的对象转成Json转为string存储到string里面

```
static async writeModel<T>(key: string, value?: T) {
  if (preference == null) {
    await this.getPreferences()
  }
  try {
    await preference.put(key, JSON.stringify(value))
  } catch (e) {
    Logger.error(this.TAG, 'Failed to write value, cause:' + e)
  }
  await preference.flush()
}
```

第二步：我们直接将存储在缓存的对象string读取出来转为我们需要的对象就好了

```
static async readModel<T>(key: string) {
  if (preference == null) {
    await this.getPreferences()
  }
  let value: string
  try {
    value = await preference.get(key, '').then()
  } catch (e) {
    Logger.error(this.TAG, 'Failed to read value, cause:' + e)
  }
  if (TextUtil.isEmpty(value)) {
    return null
  } else {
    return JSON.parse(value) as T
  }
}
```

大功告成，是不是换个思路就可以实现官方没有提供存储对象的效果呢

好像还少了点什么，我们这边再提供几个常用的preferences操作方法

```
static async delete(key: string) {
  if (preference == null) {
    await this.getPreferences()
  }
  try {
    await preference.delete(key).then()
  } catch (e) {
    Logger.error(this.TAG, 'Failed to delete, cause:' + e)
  }
}

static async clear() {
  if (preference == null) {
    await this.getPreferences()
  }
  try {
    await preference.clear().then()
  } catch (e) {
    Logger.error(this.TAG, 'Failed to clear, cause:' + e)
  }
}

static async flush() {
  if (preference == null) {
    await this.getPreferences()
  }
  try {
    await preference.flush().then()
  } catch (e) {
    Logger.error(this.TAG, 'Failed to flush, cause:' + e)
  }
}

private static async deletePreferences() {
  try {
    await dataPreferences.deletePreferences(context, Constant.PREFERENCE_NAME)
  } catch (e) {
    Logger.error(this.TAG, 'Failed to delete preferences, cause:' + e)
  }
  preference = null
}
```

这样整个Preferences的封装就到此为止啦

有的小伙伴问小编，这个工具类怎么使用呀，稍等马上呈现

使用方式一（异步写法）：

```
PreferenceUtil.readModel<UserModel>(PreferenceKey.USER_INFO).then((userInfo: UserModel) => {
           Logger.d('userId:'+userInfo.userId)
})
```

使用方式二（同步写法）：

```
private async startPage() {
    let userInfo = await PreferenceUtil.readModel<UserModel>(PreferenceKey.USER_INFO)
    if (userInfo != null) {
      showToast(userInfo.userName)
    }
  }
```

小编今天刚入驻公众号，觉得不错的小伙伴给个关注吧，您的关注是我持续更新的动力，感谢支持。
