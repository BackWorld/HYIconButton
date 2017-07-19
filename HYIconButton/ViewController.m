//
//  ViewController.m
//  HYGoodsDetailDemo
//
//  Created by zhuxuhong on 2017/7/18.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

#import "ViewController.h"
#import "HYIconButton.h"

@interface ViewController ()

@property(nonatomic,weak)IBOutlet HYIconButton *btn1;
@property(nonatomic,weak)IBOutlet HYIconButton *btn2;
@property(nonatomic,weak)IBOutlet HYIconButton *btn3;
@property(nonatomic,weak)IBOutlet HYIconButton *btn4;

@end

@implementation ViewController

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

@end
