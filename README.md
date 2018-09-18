# LNCommonFramework
把常用的一些设置封装成小工具，简化开发的过程。本工程使用cocoadpods加载，所以下载后需要执行pod install，才能正确执行

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

### 输入框视图功能拓展
- LNTextField : UITextField
- 添加删除的监听回调
```
/**
 监听删除的回调
 */
@property (nonatomic, copy) void (^deleteAction)(void);
```
- UITextField (LNExtension)
```
/**
 选中的文本范围
 */
@property (nonatomic, readonly) NSRange selectedRange;

/**
 占位文字的颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
```

- LNTextView : UITextField
```
/**
 占位文字 默认 : 请输入...
 */
@property (nonatomic, copy) IBInspectable NSString *placeHolder;

/**
 占位文字的颜色 默认 : lightGrayColor
 */
@property (nonatomic, copy) IBInspectable UIColor *placeHolderColor;

/**
 占位文字的起始位置(x, y) 默认 : (4,4)
 */
@property (nonatomic, assign) IBInspectable CGPoint placeHolderStart;

```

### 字符串类
- NSString+LNExtension
```
/**
 @return 纯字符长度
 */
- (NSUInteger)unicodeLength;

/**
 和匹配的字符串不相同
 
 @param str 需要比较的字符串
 @return 结果
 */
- (BOOL)isDiffToString:(NSString *)str;

/**
 根据字号计算文字大小(一行)
 
 @param font 字号
 @return 大小
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/**
 根据字号计算文字大小(一行)
 
 @param font 字号
 @return 大小
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 去除空格
 
 @return 去除空格后的字符串
 */
- (NSString *)trim;

/**
 去除空格之后的长度
 */
- (NSUInteger)trimLength;

/**
 判断是否包含某个字符串
 */
- (BOOL)contains:(NSString *)string;

/**
 判断是否包含某个字符串,忽略大小写
 
 @param string 忽略大小写
 @return 查找结果
 */
- (BOOL)containsStringIgnoreCase:(NSString *)string;

/**
 判断字符串的范围,忽略大小写
 
 @param searchString 要查找的字符串
 @return 范围
 */
- (NSRange)rangeOfStringIgnoreCase:(NSString *)searchString;

```

- NSMutableString (LNExtension)
```
/**
 拼接字符串
 */
- (NSMutableString * (^)(NSString *str))appStr;


```

- NSAttributedString+LNExtension
```
/**
 快速创建属性字符串
 
 @param color 颜色
 @param fontsize 字号
 @return 属性字符串
 */
+ (instancetype)attributedString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment;
```

- NSMutableAttributedString (LNExtension)
```

/**
 行间距
 */
@property(nonatomic, assign) CGFloat lineSpacing;

/**
 段间距
 */
@property(nonatomic, assign) CGFloat paragraphSpacing;

/**
 拼接字符串
 
 @param string 字符串
 @param color 颜色
 @param fontsize 字号
 @return 新的字符串
 */
- (NSMutableAttributedString *)appendString:(NSString *)string color:(UIColor *)color fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment;
```

### 常用方法类
- LNMethod

```
typedef void(^block)(void);

/**
 获取storyboard的控制器

 @param sbvcName sbname
 @return sbvc
 */
id LNSBViewController(NSString *sbvcName);



/**
 获取xibview

 @param xibViewName xibname
 @return xibview
 */
UIView *LNXibView(NSString *xibViewName);


/**
 获取分辨率倍数

 @return 当前分辨率倍数
 */
CGFloat LNScreenScale(void);


CGRect LNScreenBounds(void);

CGSize LNScreenSize(void);

/**
 延迟执行喊出

 @param time 延迟时间
 @param block code
 */
void LNAfer(NSTimeInterval time, block);


/**
 开启异步执行block

 @param block 异步code
 */
void LNAsyncThread(block);

/**
 回到主线程

 @param block mainCode
 */
void LNMainThread(block);
```
