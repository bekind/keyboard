//
//  ViewController.m
//  KeyBoard
//
//  Created by dblab on 15-11-5.
//  Copyright (c) 2015年 dblab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) UIView* keyboard;
@property(nonatomic,strong) NSMutableArray* selectArr;
@property (strong, nonatomic) IBOutlet UITextField *result;
@end

@implementation ViewController

bool visible=NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectArr = [[NSMutableArray alloc] init];
    [self createKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createKeyboard{
    CGFloat height=self.view.frame.size.height;
    CGFloat width=self.view.frame.size.width;
    CGFloat keyboardWidth=width;
    CGFloat keyboardHeight=height/3;
    CGFloat buttonWidth=(keyboardWidth-5*10)/9;
    CGFloat buttonHeight=(keyboardHeight-5*10)/4;
    
    _keyboard=[[UIView alloc] initWithFrame:CGRectMake(0,height, keyboardWidth, keyboardHeight)];
    _keyboard.backgroundColor=[UIColor blackColor];
    
    NSArray* keyNames=@[@"京",@"沪",@"浙",@"苏",@"粤",@"鲁",@"晋",@"冀",@"豫",@"川",@"渝",@"辽",@"吉",@"黑",@"皖",@"鄂",@"湘",@"赣",@"闽",@"陕",@"甘",@"宁",@"蒙",@"津",@"贵",@"云",@"桂",@"琼",@"青",@"新",@"藏"];
    int i=1,j=1;bool over=NO;
    for (; j<=4 && !over; j++) {
        for (i=1; i<10; i++) {
            if (j==4 && i==5) {
                over=YES;
                break;
            }
            UIButton* btn=[[UIButton alloc] initWithFrame:CGRectMake((i-1)*buttonWidth+i*5, 10*j+(j-1)*buttonHeight, buttonWidth, buttonHeight)];
            [btn setBackgroundColor:[UIColor grayColor]];
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            NSString* title=keyNames[(j-1)*9+(i-1)];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchDown];
            [_keyboard addSubview:btn];
        }
    }
    
    UIButton* btnDone=[[UIButton alloc] initWithFrame:CGRectMake(7*buttonWidth+40, 3*buttonHeight+40, buttonWidth*2+5, buttonHeight)];
    [btnDone setBackgroundColor:[UIColor whiteColor]];
    btnDone.layer.cornerRadius = 5;
    btnDone.layer.masksToBounds = YES;
    btnDone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btnDone setTitle:@"完成" forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchDown];
    [_keyboard addSubview:btnDone];
    [self.view addSubview:_keyboard];
}

-(void)selectBtn:(id) sender{
    UIButton* btn = (UIButton*)sender;
    if (btn.selected) {
        btn.selected=NO;
        [_selectArr removeObject:btn];
        [btn setBackgroundColor:[UIColor grayColor]];
    }
    else{
        btn.selected=YES;
        [_selectArr addObject:btn];
        [btn setBackgroundColor:[UIColor brownColor]];
    }
}

-(void)done:(id)sender{
    [self dismiss];
    NSMutableString* selectStr=[[NSMutableString alloc] initWithString:@""];
    for (int i=0; i<_selectArr.count; i++) {
        UIButton* btn=_selectArr[i];
        [selectStr appendFormat:@"%@  ",btn.titleLabel.text];
        btn.selected=NO;
        [btn setBackgroundColor:[UIColor grayColor]];
    }
    [_selectArr removeAllObjects];
    _result.text = selectStr;
    visible=NO;
}

-(void)show{
    CGFloat width=_keyboard.frame.size.width;
    CGFloat height=_keyboard.frame.size.height;
    _keyboard.center = CGPointMake(width/2, self.view.frame.size.height+height/2);
    [UIView animateWithDuration:0.5 animations:^{
        _keyboard.center = CGPointMake(width/2, self.view.frame.size.height-height/2);
    }];
}

-(void)dismiss{
    CGFloat width=_keyboard.frame.size.width;
    CGFloat height=_keyboard.frame.size.height;
    _keyboard.center = CGPointMake(width/2, self.view.frame.size.height-height/2);
    [UIView animateWithDuration:0.5 animations:^{
        _keyboard.center = CGPointMake(width/2, self.view.frame.size.height+height/2);
    }];
}

- (IBAction)showPop:(id)sender {
    if (visible) {
        [self dismiss];
        visible=NO;
    }
    else{
        [self show];
        visible=YES;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
