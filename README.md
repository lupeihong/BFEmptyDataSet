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

### Import
```objc
#import "UIView+EmptyDataSet.h"
```
### Protocol Conformance
Conform to datasource and/or delegate.
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






