import dataPreferences from '@ohos.data.preferences'
import Constant from '../constants/Constants'
import Logger from './Logger'
import common from '@ohos.app.ability.common'
import { TextUtil } from './TextUtil'

let preference: dataPreferences.Preferences
const context = getContext(this) as common.UIAbilityContext

/**
 * 使用方式1：PreferenceUtil.readModel<UserLoginDTO>(PreferenceKey.USER_INFO).then((userInfo: UserLoginDTO) => {
            Logger.d('userId:'+userInfo.userId)
 })
 *使用方式2：let userInfo = await PreferenceUtil.readModel<UserLoginDTO>(PreferenceKey.USER_INFO)
 *         Logger.d('userId:'+userInfo.userId)
 */
export class PreferenceUtil {
  private static readonly TAG: string = 'PreferenceUtil';

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

  private static async getPreferences() {
    try {
      preference = await dataPreferences.getPreferences(context, Constant.PREFERENCE_NAME)
    } catch (e) {
      Logger.error(this.TAG, 'Failed to get preferences, cause:' + e)
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
}