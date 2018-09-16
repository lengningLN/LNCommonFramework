# LNCommonFramework
把常用的一些设置封装成小工具，简化开发的过程。

## 体用简化的UI类
### LNImagePositionButton
- 此类提供设置button的image的位置和title与image之间的间隔
```
/**
 设置image的位置,0 :右边， 1：左边， 2：上边， 3：下边
 */
@property (nonatomic, assign)IBInspectable NSInteger ln_imagePosition;

/**
 设置标题和图片之间的间隔
 */
@property (nonatomic, assign)IBInspectable CGFloat ln_titleImageMargin;
```
## 提供简化的工具类
### 加载等待分类：LNProgressHUD
- 给UIView、UIViewController、MBProgressHUD 添加分类，定制加载中的各种状态和UI显示，详情参见实现类

### 网络请求工具类： LNNetworkManager
- 简化网络请求中关于等待视图、下拉刷新、上来加载、参数处理、回调处理的归总处理，详情参见实现类

