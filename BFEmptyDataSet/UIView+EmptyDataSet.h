//
//  UIView+EmptyDataSet.h
//  BFEmptyDataSet
//
//  Created by qtone_yzt on 15/8/26.
//  Copyright (c) 2015年 luph. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol BFEmptyDataSetSource;
@protocol BFEmptyDataSetDelegate;

@interface UIView (EmptyDataSet)

/** The empty datasets data source. */
@property (nonatomic, weak) id <BFEmptyDataSetSource> emptyDataSetSource;
/** The empty datasets delegate. */
@property (nonatomic, weak) id <BFEmptyDataSetDelegate> emptyDataSetDelegate;


- (void)reloadEmptyDataSet;//显示空状态视图
- (void)removeEmptyDataSet;//移除空状态视图

@end



@protocol BFEmptyDataSetSource <NSObject>
@optional
//标题
- (NSAttributedString *)titleForEmptyDataSet:(UIView *)view;

//描述
- (NSAttributedString *)descriptionForEmptyDataSet:(UIView *)view;

//图片
- (UIImage *)imageForEmptyDataSet:(UIView *)view;

//背景颜色
- (UIColor *)backgroundColorForEmptyDataSet:(UIView *)view;

//自定义内容
- (UIView *)customViewForEmptyDataSet:(UIView *)view;

//各元素垂直间距
- (CGFloat)spaceHeightForEmptyDataSet:(UIView *)view;
@end

@protocol BFEmptyDataSetDelegate <NSObject>
@optional
//点击视图事件
- (void)emptyDataSetDidTapView:(UIView *)view;
@end

