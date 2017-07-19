//
//  HYIconButton.m
//  HYGoodsDetailDemo
//
//  Created by zhuxuhong on 2017/7/19.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

#import "HYIconButton.h"

@interface HYIconButton()

@property(nonatomic,copy)UIImageView *imageView;
@property(nonatomic,copy)UILabel *titleLabel;
@property(nonatomic,copy)UIView *wrapperView;

@property(nonatomic,copy)NSString *normalTitle;
@property(nonatomic,copy)NSString *disabledTitle;
@property(nonatomic,copy)NSString *highlightedTitle;
@property(nonatomic,copy)NSString *selectedTitle;

@property(nonatomic,copy)UIColor *normalTitleColor;
@property(nonatomic,copy)UIColor *disabledTitleColor;
@property(nonatomic,copy)UIColor *highlightedTitleColor;
@property(nonatomic,copy)UIColor *selectedTitleColor;

@property(nonatomic,copy)UIImage *normalIcon;
@property(nonatomic,copy)UIImage *disabledIcon;
@property(nonatomic,copy)UIImage *highlightedIcon;
@property(nonatomic,copy)UIImage *selectedIcon;

@property(nonatomic,copy)NSMutableArray<NSLayoutConstraint*> *installedConstraints;

@end

@implementation HYIconButton
-(instancetype)init{
	if (self = [super init]) {
		[self initial];
	}
	return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super initWithCoder:aDecoder]) {
		[self initial];
	}
	return self;
}

-(void)initial{
	[self setupUI];
	
	_installedConstraints = [NSMutableArray new];
	_space = 5;
	self.style = HYIconButtonIconLeft;
	self.normalTitleColor = [UIColor blackColor];
}

-(void)setupUI{
	self.translatesAutoresizingMaskIntoConstraints = false;
	[self addSubview:self.wrapperView];
	
	NSLayoutConstraint *wrapperCenterX = [NSLayoutConstraint constraintWithItem:_wrapperView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
	NSLayoutConstraint *wrapperCenterY = [NSLayoutConstraint constraintWithItem:_wrapperView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
	[self addConstraints:@[wrapperCenterX, wrapperCenterY]];
}

#pragma mark - setters
-(void)setSpace:(CGFloat)space{
	_space = space;
	
	[self layout];
}

-(void)setStyle:(HYIconButtonStyle)style{
	_style = style;
	
	[self layout];
}

-(void)setSelected:(BOOL)selected{
	_selected = selected;
	
	_titleLabel.text = !selected ? _normalTitle : _selectedTitle;
	_titleLabel.textColor = !selected ? _normalTitleColor : _selectedTitleColor;
	_imageView.image = !selected ? _normalIcon : _selectedIcon;
}

-(void)setHighlighted:(BOOL)highlighted{
	_highlighted = highlighted;
	
	_titleLabel.text = highlighted ? _highlightedTitle : _normalTitle;
	_titleLabel.textColor = highlighted ? _highlightedTitleColor : _normalTitleColor;
	_imageView.image = highlighted ? _highlightedIcon : _normalIcon;
	
	self.backgroundColor = highlighted ? [self.backgroundColor colorWithAlphaComponent:0.8] : [self.backgroundColor colorWithAlphaComponent:1];
}

-(void)setEnabled:(BOOL)enabled{
	_enabled = enabled;
	
	_titleLabel.text = enabled ? _normalTitle : _disabledTitle;
	_titleLabel.textColor = enabled ? _normalTitleColor : _disabledTitleColor;
	_imageView.image = enabled ? _normalIcon : _disabledIcon;
	
	self.backgroundColor = enabled ? [self.backgroundColor colorWithAlphaComponent:0.3] : [self.backgroundColor colorWithAlphaComponent:1];
}

-(void)setNormalIcon:(UIImage *)normalIcon{
	_normalIcon = normalIcon;
	_disabledIcon = normalIcon;
	_selectedIcon = normalIcon;
	_highlightedIcon = normalIcon;
	
	_imageView.image = _normalIcon;
}

-(void)setNormalTitle:(NSString *)normalTitle{
	_normalTitle = normalTitle;
	_disabledTitle = normalTitle;
	_selectedTitle = normalTitle;
	_highlightedTitle = normalTitle;
	
	_titleLabel.text = _normalTitle;
}

-(void)setNormalTitleColor:(UIColor *)normalTitleColor{
	_normalTitleColor = normalTitleColor;
	_selectedTitleColor = [normalTitleColor colorWithAlphaComponent:1];
	_highlightedTitleColor = [normalTitleColor colorWithAlphaComponent:0.3];
	_disabledTitleColor = [normalTitleColor colorWithAlphaComponent:0.3];

	_titleLabel.textColor = _normalTitleColor;
}

#pragma mark - public method
-(void)setTitleFont:(UIFont *)font{
	_titleLabel.font = font;
}

-(void)setTitleColor:(UIColor *)color forState:(HYIconButtonState)state{
	switch (state) 
	{
		case HYIconButtonStateDisabled:
			self.disabledTitleColor = color;
			break;
		case HYIconButtonStateSelected:
			self.selectedTitleColor = color;
			break;
		case HYIconButtonStateHighlighted:
			self.highlightedTitleColor = color;
			break;	
		default:
			self.normalTitleColor = color;
			break;
	}
}

-(void)setTitle:(NSString *)title forState:(HYIconButtonState)state{
	switch (state) 
	{
		case HYIconButtonStateDisabled:
			self.disabledTitle = title;
			break;
		case HYIconButtonStateSelected:
			self.selectedTitle = title;
			break;
		case HYIconButtonStateHighlighted:
			self.highlightedTitle = title;
			break;	
		default:
			self.normalTitle = title;
			break;
	}
}

-(void)setImage:(UIImage *)image forState:(HYIconButtonState)state{
	switch (state) 
	{
		case HYIconButtonStateDisabled:
			self.disabledIcon = image;
			break;
		case HYIconButtonStateSelected:
			self.selectedIcon = image;
			break;
		case HYIconButtonStateHighlighted:
			self.highlightedIcon = image;
			break;	
		default:
			self.normalIcon = image;
			break;
	}
}

#pragma mark - private method
-(void)layout{
	if (_installedConstraints) {
		[self removeConstraints:_installedConstraints];
		[_installedConstraints removeAllObjects];
	}
	
	NSArray *formats = nil;
	NSDictionary *views = NSDictionaryOfVariableBindings(_imageView, _titleLabel);
	switch (_style) 
	{
		case HYIconButtonIconTop:
			formats = @[@"H:|[_imageView]|", 
						@"H:|[_titleLabel]|",
						@"V:|[_imageView]", 
						[NSString stringWithFormat:@"V:[_imageView]-%f-[_titleLabel]|",_space]];
			break;
			
		case HYIconButtonIconRight:
			formats = @[@"V:|[_imageView]|", 
						@"V:|[_titleLabel]|", 
						@"H:|[_titleLabel]", 
						[NSString stringWithFormat:@"H:[_titleLabel]-%f-[_imageView]|",_space]];
			break;
			
		case HYIconButtonIconBottom:
			formats = @[@"H:|[_imageView]|", 
						@"H:|[_titleLabel]|", 
						@"V:|[_titleLabel]", 
						[NSString stringWithFormat:@"V:[_titleLabel]-%f-[_imageView]|",_space]];
			break;
			
		default:
			formats = @[@"V:|[_imageView]|", 
						@"V:|[_titleLabel]|", 
						@"H:|[_imageView]", 
						[NSString stringWithFormat:@"H:[_imageView]-%f-[_titleLabel]|",_space]];
			break;
	}
	
	for (NSString *format in formats) {
		NSArray *cons = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
		[_installedConstraints addObjectsFromArray:cons];
	}
	[self addConstraints:_installedConstraints];
}

#pragma mark - events
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	self.highlighted = true;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	self.highlighted = false;
	
	_clickedCallback ? _clickedCallback(self) : nil;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	self.highlighted = false;
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	self.highlighted = false;
}

#pragma mark - getters

-(UIView *)wrapperView{
	if (!_wrapperView) {
		UIView *v = [UIView new];
		v.translatesAutoresizingMaskIntoConstraints = false;
//		v.backgroundColor = [UIColor greenColor];

		[v addSubview:self.imageView];
		[v addSubview:self.titleLabel];
		
		_wrapperView = v;
	}
	return _wrapperView;
}

-(UILabel *)titleLabel{
	if (!_titleLabel) {
		UILabel *lb = [UILabel new];
		lb.translatesAutoresizingMaskIntoConstraints = false;
		lb.font = [UIFont systemFontOfSize:14];
		
		_titleLabel = lb;
	}
	return _titleLabel;
}

-(UIImageView *)imageView{
	if (!_imageView) {
		UIImageView *iv = [UIImageView new];
		iv.translatesAutoresizingMaskIntoConstraints = false;
		iv.contentMode = UIViewContentModeScaleAspectFit;
		
		_imageView = iv;
	}
	return _imageView;
}

@end
