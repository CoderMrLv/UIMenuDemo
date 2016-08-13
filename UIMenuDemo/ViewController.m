//
//  ViewController.m
//  UIMenuDemo
//
//  Created by apple on 16/8/13.
//  Copyright © 2016年 qingxunLv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) UILabel * textLab;
@end

@implementation ViewController

/*
 ·UIPasteboard：提供黏贴板分享数据，从黏贴板读-写数据

·UIMenuController：展示编辑菜单，用来执行拷贝-黏贴操作

·UIResponder类的canPerformAction:withSender:方法，决定是否显示菜单某些命令，例如剪切

·UIResponderStandardEditActions非正式协议中声明了copy、cut、paste等方法*/
- (void)viewDidLoad {
    [super viewDidLoad];
    self.textLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 400, 40)];
    [self.view addSubview:self.textLab];
    self.textLab.text = @"hello baby , ni shi wo de xiao ping guo";
    self.textLab.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.textLab addGestureRecognizer:tap];
    
    
    
    
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (void)tap{
   NSLog(@"%d", [self.textLab becomeFirstResponder]);
    
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"Change Color" action:@selector(changeColor:)];        //3.创建编辑菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.textLab.bounds inView:self.textLab];
    menu.menuItems = @[item,[[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)],
                       [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)],
                       [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warn:)]
                       ];
    [menu setMenuVisible:YES animated:YES];
    
}
/**
 * 通过第一响应者的这个方法告诉UIMenuController可以显示什么内容
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ( (action == @selector(copy:) ) // 需要有文字才能支持复制
        || (action == @selector(cut:) ) // 需要有文字才能支持剪切
        || action == @selector(paste:)
        || action == @selector(ding:)
        || action == @selector(reply:)
        || action == @selector(warn:)
        || action == @selector(changeColor:)) return YES;
    
    return NO;
}

#pragma mark - 监听MenuItem的点击事件
- (void)cut:(UIMenuController *)menu
{
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.textLab.text;
    // 清空文字
    self.textLab.text = nil;
}

- (void)copy:(UIMenuController *)menu
{
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.textLab.text;
}

- (void)paste:(UIMenuController *)menu
{
    // 将粘贴板的文字赋值给label
    NSLog(@"%@",[UIPasteboard generalPasteboard].string);
    
    self.textLab.text = @"hahah";
}

- (void)ding:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}

- (void)reply:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}

- (void)warn:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}

-(void)changeColor:(id) sender{
    self.textLab.backgroundColor = [UIColor redColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
