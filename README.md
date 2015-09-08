# BFEmptyDataSet
[![Pod Version](http://img.shields.io/cocoapods/v/BFEmptyDataSet.svg)](http://cocoadocs.org/docsets/BFEmptyDataSet/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](http://opensource.org/licenses/MIT)

参考 https://github.com/dzenbot/DZNEmptyDataSet 经过修改

### Features
* 无网络状态，无数据状态，空视图处理
* 支持所有UIView

![Screenshots_Row2](https://raw.githubusercontent.com/dzenbot/UITableView-DataSet/master/Examples/Applications/Screenshots/Screenshots_row2.png)

## Installation
* 可自定义背景颜色
* 定义标题、描述
* 图片
* 界面点击事件

## How to use

### user cocoapods
```objc
pod 'BFEmptyDataSet', '~> 1.0.0'
```
### Import
```objc
#import "UIView+EmptyDataSet.h"
```

### Protocol Conformance
Conform to datasource and/or delegate.
遵循协议委托
```objc
@interface ViewController : UIViewController<BFEmptyDataSetDelegate,BFEmptyDataSetSource>

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bodyWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    bodyWebView.delegate=self;
    [self.view addSubview:bodyWebView];
    
    bodyWebView.emptyDataSetDelegate=self;
    bodyWebView.emptyDataSetSource=self;
    
    [self loadWeb];
    
}
```



### Data Source Implementation
Return the content you want to show on the empty state, and take advantage of NSAttributedString features to customise the text appearance.
实现数据源委托

* The image for the empty state:
* 设置空视图图片
```objc
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"results_tips6"];
}
```

* The attributed string for the title/description of the empty state:
* 返回 attributed string 为标题和描述
```objc
- (NSAttributedString *)titleForEmptyDataSet:(UIView *)view{
    NSString *text = @"哎呀,加载失败了...";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName:Color(0, 174, 239, 1)};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIView *)view{
    NSString *text = @"请检查您的网络设置或点击重试";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13],
                                 NSForegroundColorAttributeName:Color(74, 74, 74, 1)};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
```

* The background color for the empty state:
* 设置背景颜色
```objc
- (UIColor *)backgroundColorForEmptyDataSet:(UIView *)view
{
    return Color(250, 250, 250, 1);
}
```

* Finally, you can separate components from each other (default separation is 0 pts):
* 设置各个元素之间的距离，默认0
```objc
- (CGFloat)spaceHeightForEmptyDataSet:(UIView *)view
{
    return 20.0f;
}
```

### Delegate Implementation
Return the behaviours you would expect from the empty states, and receive the user events.
实现委托

* Notifies when the dataset view was tapped:
* 当视图被点击时调用
```objc
- (void)emptyDataSetDidTapView:(UIView *)view{
    NSLog(@"doSomething");
}
```


* 显示空状态视图
```objc
    [bodyWebView reloadEmptyDataSet];
```
* 关闭空状态视图
```objc
    [bodyWebView removeEmptyDataSet];
```
