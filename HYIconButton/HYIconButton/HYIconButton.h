//
//  HYIconButton.h
//  HYGoodsDetailDemo
//
//  Created by zhuxuhong on 2017/7/19.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYIconButton;

typedef enum : NSUInteger {
	HYIconButtonIconTop,
	HYIconButtonIconLeft,
	HYIconButtonIconBottom,
	HYIconButtonIconRight
} HYIconButtonStyle;

typedef enum: NSUInteger {
	HYIconButtonStateNormal,
	HYIconButtonStateSelected,
	HYIconButtonStateHighlighted,
	HYIconButtonStateDisabled
} HYIconButtonState;

typedef void(^HYIconButtonCallback)(HYIconButton*);

@interface HYIconButton : UIView

@property(nonatomic)CGFloat space;
@property(nonatomic)HYIconButtonStyle style;

@property(nonatomic)BOOL selected;
@property(nonatomic)BOOL enabled;
@property(nonatomic)BOOL highlighted;

@property(nonatomic,copy)HYIconButtonCallback clickedCallback;

- (void)setTitleFont: (UIFont*)font;
- (void)setTitle:(NSString *)title forState:(HYIconButtonState)state;
- (void)setTitleColor:(UIColor *)color forState:(HYIconButtonState)state;
- (void)setImage:(UIImage *)image forState:(HYIconButtonState)state; 


@end
