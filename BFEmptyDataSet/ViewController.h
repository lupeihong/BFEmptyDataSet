//
//  ViewController.h
//  BFEmptyDataSet
//
//  Created by qtone_yzt on 15/8/26.
//  Copyright (c) 2015年 qtone_yzt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+EmptyDataSet.h"

@interface ViewController : UIViewController<BFEmptyDataSetDelegate,BFEmptyDataSetSource,UIWebViewDelegate>
{
    UIWebView *bodyWebView;
}

@end

