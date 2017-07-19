# HYIconButton
A customized `button` component with any-position icon in OC.

![最终效果](http://upload-images.jianshu.io/upload_images/1334681-100340e6a2315687.gif?imageMogr2/auto-orient/strip)

##### 要求：
- Platform: iOS7.0+ 
- Language: Objective-C
- Editor: Xcode6.0+

##### 实现

- 思路
**UIView + UIImageView + UILabel + NSLayoutConstraint**
- 核心代码: 自动布局

```
// 基于设置的枚举类型style，进行不同的布局设置
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
```
- 核心代码: 状态设计

```
// 模仿UIButton的几种常用状态，进行title和icon的不同设置
typedef enum: NSUInteger {
	HYIconButtonStateNormal,
	HYIconButtonStateSelected,
	HYIconButtonStateHighlighted,
	HYIconButtonStateDisabled
} HYIconButtonState;

// 属性存储
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
```
- 核心代码: Touch事件处理

```
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
```
- 用法: 

```
- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self setButton:_btn1 style:HYIconButtonIconTop];
	[self setButton:_btn2 style:HYIconButtonIconRight];
	[self setButton:_btn3 style:HYIconButtonIconBottom];
	[self setButton:_btn4 style:HYIconButtonIconLeft];
}

-(void)setButton: (HYIconButton*)btn 
		   style: (HYIconButtonStyle)style{
	
	btn.style = style;
	[btn setTitle:@"收藏" forState:HYIconButtonStateNormal];
	[btn setImage:[UIImage imageNamed:@"icon_collect"] forState:HYIconButtonStateNormal];
	[btn setImage:[UIImage imageNamed:@"icon_collect_selected"] forState:HYIconButtonStateSelected];
	
	btn.clickedCallback = ^(HYIconButton *btn) {
		[self actionForButtonClicked: btn];
	};
	[btn setTitleFont:[UIFont systemFontOfSize:14]];
	[btn setTitleColor:[UIColor darkGrayColor] forState:HYIconButtonStateNormal];
}

-(void)actionForButtonClicked: (HYIconButton*)sender{
	sender.selected = !sender.selected;
	
	NSLog(@"Button: %ld",sender.tag);
}
```

### 简书
http://www.jianshu.com/p/e86ae67e66c0
> 如果对你有帮助，别忘了点个❤️哦。
