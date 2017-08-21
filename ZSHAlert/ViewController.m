//
//  ViewController.m
//  ZSHAlert
//
//  Created by 维奕 on 2017/8/21.
//  Copyright © 2017年 维奕. All rights reserved.
//

#import "ViewController.h"
#import "ZSHAlertV.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic, strong)NSMutableArray<NSArray<NSString *>*> *titles;
@property(strong,nonatomic)UITableView *TabV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSMutableArray new];
    [self.titles addObject:@[@"内容-左右按钮",@"内容-一个按钮",@"内容-无按钮"]];
    [self.titles addObject:@[@"图片-内容-左右按钮",@"图片-内容-一个按钮",@"图片-内容-无按钮"]];
    [self.titles addObject:@[@"自定义view-左右按钮",@"自定义view-一个按钮",@"自定义view-无按钮"]];
    
    [self.view addSubview:self.TabV];
    
}

#pragma mark 表格创建
-(UITableView *)TabV{
    if (_TabV==nil) {
        _TabV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
        _TabV.delegate=self;
        _TabV.dataSource=self;
        _TabV.scrollEnabled=NO;
    }
    return _TabV;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.titles[section].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [ZSHAlertV setAlertBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    
    if (indexPath.section==0) {
        [ZSHAlertV setConfirmBtBackgroundColor:[UIColor whiteColor]];
        [ZSHAlertV setConfirmBtTitleColor:[UIColor redColor]];
        [ZSHAlertV setCancleBtBackgroundColor:[UIColor whiteColor]];
        [ZSHAlertV setCancleBtTitleColor:[UIColor blueColor]];
        [ZSHAlertV setContentTextAlignment:NSTextAlignmentLeft];
        if (indexPath.row == 0) {
            
            [ZSHAlertV showContent:@"扈江离与辟芷兮，纫秋兰以为佩。汨余若将不及兮，恐年岁之不吾与。朝搴阰之木兰兮，夕揽洲之宿莽。日月忽其不淹兮，春与秋其代序。" confirmButton:[ZSHAlertButton initWithTitle:@"确定" clickAction:^{
                [ZSHAlertV hide];
            }] cancleButton:[ZSHAlertButton initWithTitle:@"取消" clickAction:nil]];
        }else if (indexPath.row == 1){
            [ZSHAlertV showContent:@"扈江离与辟芷兮，纫秋兰以为佩。汨余若将不及兮，恐年岁之不吾与。朝搴阰之木兰兮，夕揽洲之宿莽。日月忽其不淹兮，春与秋其代序。" confirmButton:[ZSHAlertButton initWithTitle:@"确定" clickAction:^{
                [ZSHAlertV hide];
            }]];
        }else if (indexPath.row == 2){
            [ZSHAlertV showContent:@"扈江离与辟芷兮，纫秋兰以为佩。汨余若将不及兮，恐年岁之不吾与。朝搴阰之木兰兮，夕揽洲之宿莽。日月忽其不淹兮，春与秋其代序。"];
            [ZSHAlertV hideCompletion:^{
                NSLog(@"===2");
            }];
        }
    }else if(indexPath.section==1){
        [ZSHAlertV setConfirmBtBackgroundColor:[UIColor colorWithRed:89/255.0 green:183/255.0 blue:255/255.0 alpha:1]];
        [ZSHAlertV setConfirmBtTitleColor:[UIColor whiteColor]];
        [ZSHAlertV setCancleBtBackgroundColor:[UIColor colorWithRed:131/255.0 green:146/255.0 blue:165/255.0 alpha:1]];
        [ZSHAlertV setCancleBtTitleColor:[UIColor whiteColor]];
        [ZSHAlertV setContentTextAlignment:NSTextAlignmentCenter];
        if (indexPath.row == 0){
            [ZSHAlertV showImage:[UIImage imageNamed:@"shangpin_img_ticket"] content:@"扈江离与辟芷兮，纫秋兰以为佩。汨余若将不及兮，恐年岁之不吾与。朝搴阰之木兰兮，夕揽洲之宿莽。日月忽其不淹兮，春与秋其代序。" confirmButton:[ZSHAlertButton initWithTitle:@"确定" clickAction:^{
                [ZSHAlertV hide];
            }] cancleButton:[ZSHAlertButton initWithTitle:@"取消" clickAction:nil]];
        }else if(indexPath.row==1){
            [ZSHAlertV showImage:[UIImage imageNamed:@"shangpin_img_ticket"] content:@"日月忽其不淹兮，春与秋其代序。" confirmButton:[ZSHAlertButton initWithTitle:@"确定" clickAction:^{
                [ZSHAlertV hide];
            }]];
        }else if(indexPath.row==2){
            [ZSHAlertV showImage:[UIImage imageNamed:@"function_img_remind"] content:@"日月忽其不淹兮，春与秋其代序。"];
        }
    }else{
        [ZSHAlertV setConfirmBtBackgroundColor:[UIColor whiteColor]];
        [ZSHAlertV setConfirmBtTitleColor:[UIColor redColor]];
        [ZSHAlertV setCancleBtBackgroundColor:[UIColor whiteColor]];
        [ZSHAlertV setCancleBtTitleColor:[UIColor blueColor]];
        
        UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 150)];
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 70, 250, 35)];
        textField.layer.borderWidth = 0.5;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [textField setReturnKeyType:UIReturnKeyDone];
        textField.delegate = self;
        [customView addSubview:textField];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 250, 15)];
        [title setFont:[UIFont systemFontOfSize:15]];
        [title setTextColor:[UIColor darkGrayColor]];
        title.text = @"请输入内容";
        [customView addSubview:title];
        
        if (indexPath.row == 0) {
            [ZSHAlertV showCustomView:customView confirmButton:[ZSHAlertButton initWithTitle:@"确定" clickAction:^{
                [ZSHAlertV hide];
            }] cancleButton:[ZSHAlertButton initWithTitle:@"取消" clickAction:nil]];
        }else if (indexPath.row == 1){
            [ZSHAlertV showCustomView:customView confirmButton:[ZSHAlertButton initWithTitle:@"确定" clickAction:^{
                [ZSHAlertV hide];
            }]];
        }else if (indexPath.row == 2){
            [ZSHAlertV showCustomView:customView];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
