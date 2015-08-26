//
//  UIView+EmptyDataSet.m
//  BFEmptyDataSet
//
//  Created by qtone_yzt on 15/8/26.
//  Copyright (c) 2015年 luph. All rights reserved.
//

#import "UIView+EmptyDataSet.h"
#import <objc/runtime.h>


#pragma mark - EmptyDataSetView

@interface EmptyDataSetView : UIView
{
    CGFloat imageViewHeight;
    CGFloat labelHeight;
    
    UIView *infoView;
}

@property (nonatomic, readonly) UIButton *contentView;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *detailLabel;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, strong) UIView *customView;

@property (nonatomic, assign) CGFloat verticalSpace;

@end


@implementation EmptyDataSetView
@synthesize contentView,titleLabel,detailLabel,imageView,customView,verticalSpace;

#pragma mark - Initialization Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        imageViewHeight=88;
        labelHeight=24;
        [self addContentView];
    }
    return self;
}

//添加默认视图
- (void)addContentView{
    
    contentView=[[UIButton alloc] initWithFrame:self.bounds];
    [self addSubview:contentView];
    
    infoView=[UIView new];
    infoView.backgroundColor=[UIColor clearColor];
    infoView.userInteractionEnabled=NO;
    [contentView addSubview:infoView];
    
    
    imageView=[UIImageView new];
//    imageView.backgroundColor=[UIColor redColor];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [infoView addSubview:imageView];
    
    
    titleLabel=[UILabel new];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [infoView addSubview:titleLabel];
    
    
    detailLabel=[UILabel new];
    detailLabel.backgroundColor=[UIColor clearColor];
    detailLabel.textAlignment=NSTextAlignmentCenter;
    [infoView addSubview:detailLabel];
}

- (void)reloadEmptyView{
    
    if (customView) { //自定义视图
//        customView.frame=self.bounds;
        [self addSubview:customView];
        
        if (contentView) {
            for (UIView *view in contentView.subviews) {
                [view removeFromSuperview];
            }
        }
        contentView.backgroundColor=[UIColor clearColor];
        [self bringSubviewToFront:contentView];
        
    }else{
        
        
        
        if (imageView.image) {
            imageView.frame=CGRectMake((contentView.frame.size.width-imageViewHeight)*0.5, 0, imageViewHeight, imageViewHeight);
        }else{
             imageView.frame=CGRectMake((contentView.frame.size.width-imageViewHeight)*0.5, 0, 0, 0);
        }
        
        if (titleLabel.attributedText) {
            titleLabel.frame=CGRectMake(0, CGRectGetMaxY(imageView.frame)+verticalSpace, contentView.frame.size.width, labelHeight);
        }else{
             titleLabel.frame=CGRectMake(0, CGRectGetMaxY(imageView.frame), contentView.frame.size.width, 0);
        }
        
        if (detailLabel.attributedText) {
            detailLabel.frame=CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+verticalSpace, contentView.frame.size.width, labelHeight);
        }else{
            detailLabel.frame=CGRectMake(0, CGRectGetMaxY(titleLabel.frame), contentView.frame.size.width, 0);
        }
        
        infoView.frame=CGRectMake(0, (contentView.frame.size.height-CGRectGetMaxY(detailLabel.frame))*0.5, contentView.frame.size.width,CGRectGetMaxY(detailLabel.frame));
        
    }
    
}

@end



#pragma mark - UIScrollView+EmptyDataSet

static char const * const kEmptyDataSetSource =     "emptyDataSetSource";
static char const * const kEmptyDataSetDelegate =   "emptyDataSetDelegate";
static char const * const kEmptyDataSetView =       "emptyDataSetView";

@implementation UIView (EmptyDataSet)


#pragma mark - Reload APIs (Public)

- (void)reloadEmptyDataSet
{
    [self removeEmptyDataSet];
    
    EmptyDataSetView *view = [[EmptyDataSetView alloc] initWithFrame:self.bounds];
    self.emptyDataSetView=view;
//    [self setEmptyDataSetView:view];
    
    view.contentView.backgroundColor=[self bf_dataSetBackgroundColor];
    view.titleLabel.attributedText=[self bf_titleLabelString];
    view.detailLabel.attributedText=[self bf_detailLabelString];
    view.imageView.image=[self bf_image];
    view.verticalSpace=[self bf_verticalSpace];
    view.customView=[self bf_customView];
    [view.contentView addTarget:self action:@selector(bf_didTapView) forControlEvents:UIControlEventTouchUpInside];
    
    [view reloadEmptyView];
    
    [self addSubview:view];

}

- (void)removeEmptyDataSet{
    if (self.emptyDataSetView) {
        [self.emptyDataSetView removeFromSuperview];
        self.emptyDataSetView=nil;
    }
    
}


#pragma mark - Data Source Getters

- (NSAttributedString *)bf_titleLabelString
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(titleForEmptyDataSet:)]) {
        NSAttributedString *string = [self.emptyDataSetSource titleForEmptyDataSet:self];
        if (string) NSAssert([string isKindOfClass:[NSAttributedString class]], @"You must return a valid NSAttributedString object -titleForEmptyDataSet:");
        return string;
    }
    return nil;
}

- (NSAttributedString *)bf_detailLabelString
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(descriptionForEmptyDataSet:)]) {
        NSAttributedString *string = [self.emptyDataSetSource descriptionForEmptyDataSet:self];
        if (string) NSAssert([string isKindOfClass:[NSAttributedString class]], @"You must return a valid NSAttributedString object -descriptionForEmptyDataSet:");
        return string;
    }
    return nil;
}

- (UIImage *)bf_image
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(imageForEmptyDataSet:)]) {
        UIImage *image = [self.emptyDataSetSource imageForEmptyDataSet:self];
        if (image) NSAssert([image isKindOfClass:[UIImage class]], @"You must return a valid UIImage object for -imageForEmptyDataSet:");
        return image;
    }
    return nil;
}

- (UIColor *)bf_dataSetBackgroundColor
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(backgroundColorForEmptyDataSet:)]) {
        UIColor *color = [self.emptyDataSetSource backgroundColorForEmptyDataSet:self];
        if (color) NSAssert([color isKindOfClass:[UIColor class]], @"You must return a valid UIColor object -backgroundColorForEmptyDataSet:");
        return color;
    }
    return [UIColor clearColor];
}

- (UIView *)bf_customView
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(customViewForEmptyDataSet:)]) {
        UIView *view = [self.emptyDataSetSource customViewForEmptyDataSet:self];
        if (view) NSAssert([view isKindOfClass:[UIView class]], @"You must return a valid UIView object for -customViewForEmptyDataSet:");
        return view;
    }
    return nil;
}

- (CGFloat)bf_verticalSpace
{
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(spaceHeightForEmptyDataSet:)]) {
        return [self.emptyDataSetSource spaceHeightForEmptyDataSet:self];
    }
    return 0;
}

#pragma mark - Delegate Getters & Events (Private)
- (void)bf_didTapView
{
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetDidTapView:)]) {
        [self.emptyDataSetDelegate emptyDataSetDidTapView:self];
    }
}


#pragma mark - Getter & Setter
#pragma mark Getters (Public)

- (id<BFEmptyDataSetSource>)emptyDataSetSource
{
    return objc_getAssociatedObject(self, kEmptyDataSetSource);
}

- (id<BFEmptyDataSetDelegate>)emptyDataSetDelegate
{
    return objc_getAssociatedObject(self, kEmptyDataSetDelegate);
}


#pragma mark  Getters (Private)

- (EmptyDataSetView *)emptyDataSetView
{
    EmptyDataSetView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    
//    if (!view)
//    {
//        view = [[EmptyDataSetView alloc] initWithFrame:self.bounds];
//        [self setEmptyDataSetView:view];
//    }
    return view;
}


#pragma mark  Setters (Public)

- (void)setEmptyDataSetSource:(id<BFEmptyDataSetSource>)datasource
{
    
    objc_setAssociatedObject(self, kEmptyDataSetSource, datasource, OBJC_ASSOCIATION_ASSIGN);
    
}

- (void)setEmptyDataSetDelegate:(id<BFEmptyDataSetDelegate>)delegate
{
    objc_setAssociatedObject(self, kEmptyDataSetDelegate, delegate, OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark  Setters (Private)

- (void)setEmptyDataSetView:(EmptyDataSetView *)view
{
    objc_setAssociatedObject(self, kEmptyDataSetView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

