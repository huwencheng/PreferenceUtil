import { PreferenceKey } from '../constants/Constants'
import { UserModel } from '../model/data'
import { PreferenceUtil } from '../util/PreferenceUtil'
import { showToast } from '../util/ToastUtil'
@Entry
@Component
struct Index {
  build() {
    Row() {
      Column() {
        Button('存储用户信息')
          .width('100%')
          .height('45vp')
          .margin({ top: '45vp' })
          .onClick(() => {
            let model = new UserModel()
            model.userName = '公众号：Harmony技术先锋派'
            model.password = '点个免费关注不迷路'
            PreferenceUtil.writeModel<UserModel>(PreferenceKey.USER_INFO, model)
            showToast('已存储')
          })

        Button('读取用户信息')
          .width('100%')
          .height('45vp')
          .margin({ top: '45vp'})
          .onClick(() => {
            PreferenceUtil.readModel<UserModel>(PreferenceKey.USER_INFO).then((userInfo: UserModel) => {
              showToast(userInfo.userName + '==》' + userInfo.password)
            })
          })
      }
      .margin({left:'30vp',right:'30vp'})
    }
    .height('100%')
  }
}