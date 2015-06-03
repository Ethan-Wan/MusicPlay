//
//  EWUserInfoViewController.m
//  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWUserInfoViewController.h"
#import "EWAccount.h"
#import "EWAccountTool.h"
#import "EWNickNameViewController.h"
#import "MBProgressHUD+MJ.h"
#import "EWUserIconView.h"
#import "EWMiniPlayingTool.h"
#import "EWLocationView.h"
#import "EWProvinces.h"
#import "MJExtension.h"
#import "EWCities.h"

#define sectionCount 8

@interface EWUserInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) EWAccount *account;

@property (nonatomic,weak) UIButton *backgroundButton;

@property (weak, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *provinces;
@property (strong, nonatomic) NSArray *cities;
@end

@implementation EWUserInfoViewController

-(EWAccount *)account{
    if (!_account) {
        self.account = [EWAccountTool account];
    }
    return _account;

}

-(NSArray *)provinces{
    if (!_provinces) {
        self.provinces = [EWProvinces objectArrayWithFilename:@"Provinces.plist"];
    }
    return _provinces;
}

#pragma mark - 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置setupNavigationItem
    [self setupNavigationItem];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;
    
    //打开相册的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openPicture) name:EWUserIconNotification object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //修改了nickName的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNickName) name:EWNickNameDidChangeNotification object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark - 私有方法

/**
 *  重新加载nickName的cell
 */
-(void)reloadNickName{
    //重置数据
    self.account = [EWAccountTool account];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    //更新导航条
    [self setupNavigationItem];
}

/**
 *  设置setupNavigationItem
 */
-(void)setupNavigationItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStylePlain target:self action:@selector(exit)];
    self.navigationItem.title = [NSString stringWithFormat:@"%@的个人信息",[EWAccountTool account].nickName];
}
/**
 *   设置用户头像设置的view
 */
-(void)setupUserIconView{
    //1.设置背景按钮
    UIButton *backgroundButton = [[UIButton alloc] init];
    backgroundButton.frame = self.view.bounds;
    backgroundButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    backgroundButton.alpha = 0;
    
    //2.初始化用户头像设置界面
    EWUserIconView *userInfoView = [EWUserIconView userIcon];
    userInfoView.center = backgroundButton.center;
    
    [backgroundButton addTarget:self action:@selector(removeButton:) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundButton = backgroundButton;
    
    //3.将用户头像设置界添加到背景按钮
    [backgroundButton addSubview:userInfoView];
    
    [self.view addSubview:backgroundButton];
    
    //4.添加显示动画
    [UIView animateWithDuration:animateDuration animations:^{
        backgroundButton.alpha = 1.0;
    }];

}
/**
 *  选择所在地
 */
-(void)chooseLocation{
    //1.设置背景按钮
    UIButton *backgroundButton = [[UIButton alloc] init];
    backgroundButton.frame = self.view.bounds;
    backgroundButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    backgroundButton.alpha = 0;
    
    //2.初始化用户头像设置界面
    EWLocationView *locationView = [EWLocationView location];
    locationView.center = backgroundButton.center;
    locationView.y +=50;
    
    //3.添加UIPickerView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.frame = (CGRect){{0,0},locationView.privinceView.size};
    [locationView.privinceView addSubview:pickerView];
    self.pickerView = pickerView;
    
    //4.初始化cities的数据
    NSInteger provinceIndex = [self.pickerView selectedRowInComponent:0];
    EWProvinces *province = self.provinces[provinceIndex];
    self.cities = province.cities;
    
    [backgroundButton addTarget:self action:@selector(removeButton:) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundButton = backgroundButton;
    
    //5.将用户头像设置界添加到背景按钮
    [backgroundButton addSubview:locationView];
    
    [self.view addSubview:backgroundButton];
    
    //6.添加显示动画
    [UIView animateWithDuration:animateDuration animations:^{
        backgroundButton.alpha = 1.0;
    }];
}
/**
 *  打开相册
 */
- (void)openPicture{
    //
    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
    pic.delegate = self;
    pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pic.allowsEditing = YES;
    [self presentViewController:pic animated:YES completion:nil];
    
}

/**
 *  退出设置照片界面
 *
 *  @param button 按钮
 */
-(void)removeButton:(UIButton *)button{
    [button removeFromSuperview];
}
/**
 *  退出
 */
-(void)exit{
    [self dismissViewControllerAnimated:YES completion:nil];
    [EWMiniPlayingTool showMiniPlaying];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"userInfo";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //1.cell右边的label
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 200, 30);
    //2.给每个cell数据
    
#warning 垃圾代码，可用plist文件－>NSArray完善
    
    switch (indexPath.section) {
        case 0:{
//            cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
            if(self.account.userIcon.length<1){
                cell.imageView.image = [UIImage imageNamed:@"userDefaultIcon.png"];
            }else{
                cell.imageView.image = [UIImage imageWithContentsOfFile:[documentPath stringByAppendingPathComponent:self.account.userIcon]];
            }
            label.textAlignment = NSTextAlignmentRight;
            label.text = @"更改头像";
            cell.accessoryView = label;
        }
            break;
        case 1:{
            cell.detailTextLabel.text = @"昵称:";
            label.textAlignment = NSTextAlignmentRight;
            label.text = self.account.nickName;
            cell.accessoryView = label;
        }
            break;
        case 2:
        {
            cell.detailTextLabel.text = @"性别:";
            label.textAlignment = NSTextAlignmentRight;
            label.text = @"男";
            cell.accessoryView = label;
        }
            break;
        case 3:{
            cell.detailTextLabel.text = @"所在地:";
            label.text = @"";
            cell.accessoryView = label;
        }
            break;
        case 4:{
            cell.detailTextLabel.text = @"标签:";
            label.text = @"";
            cell.accessoryView = label;
        }
            break;
        case 5:{
            cell.detailTextLabel.text = @"个性签名:";
            label.text = @"";
            cell.accessoryView = label;
        }
            break;
        case 6:{
            cell.detailTextLabel.text = @"允许访问我的空间:";
            UISwitch *ewSwitch = [[UISwitch alloc] init];
            cell.accessoryView = ewSwitch;
        }
            break;
        case 7:
        {
            cell.backgroundColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = cell.bounds;
            label.text = @"   退出";
            
            cell.accessoryView = label;
        }
            break;
    }
    
    return cell;

}

/**
 *  点击cell
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            //设置用户头像设置的view
            [self setupUserIconView];
            break;
        case 1:{
            //修改用户昵称
            EWNickNameViewController *nickNameVc = [storyBoard instantiateViewControllerWithIdentifier:@"EWNickNameViewController"];
            [self.navigationController pushViewController:nickNameVc animated:YES];
            }
            break;
        case 3:
            //修改用户昵称
            [self chooseLocation];
            break;
        case 7:{
            //注销账号
            [EWAccountTool delectAccount];
            [[NSNotificationCenter defaultCenter] postNotificationName:EWUserInfoDidChangeNotification object:nil];
            [MBProgressHUD showSuccess:@"已退出当前用户"];
            [self dismissViewControllerAnimated:YES completion:nil];
            [EWMiniPlayingTool showMiniPlaying];
            }
            break;
    }

    

}
/**
 *  设置Header的高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70;
    }
    return 40;
}

#pragma mark - UIImagePickerControllerDelegate

/**
 *  UIImagePickerController代理方法，当选中相册图片的时候返回图片信息
 *  @param 图片信息info
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //1.得到照片
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    //2.判断照片类型
    NSData *data;
    NSString *type = nil;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
        type = @"jpg";
    } else {
        
        data = UIImagePNGRepresentation(image);
        type = @"png";
    }
    
    //3.存到指定路径中
    NSFileManager* fileManager=[NSFileManager defaultManager];
    [fileManager createFileAtPath:[documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@.%@",self.account.userName,type]] contents:data attributes:nil];
    
    //4.修改用户信息
    self.account.userIcon = [NSString stringWithFormat:@"%@.%@",self.account.userName,type];
    [EWAccountTool modifyAccount:self.account];
    
    //5.刷行tableView
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
    
    //关闭控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EWUserInfoDidChangeNotification object:nil];
    [self removeButton:self.backgroundButton];
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //返回各自component的数量
    if (component == 0) {
        return self.provinces.count;
      
    }else{
        return self.cities.count;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        EWProvinces *seletedProvince = self.provinces[row];
        self.cities = seletedProvince.cities;

        //更新第二个轮子的数据
        [self.pickerView reloadComponent:1];
    }
}
-(UIView*) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //1/拿到当前列的省份信息
    EWProvinces *privoce = self.provinces[row];
    
    //2.创建载体
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 30)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font=[UIFont boldSystemFontOfSize:15];
    
    //3.给各自的compoent赋值
    if (component==0) {
        //返回省份名
        lable.text = privoce.ProvinceName;
        return lable;
    }
    else{
        EWCities *city = self.cities[row];
        //返回城市名
        lable.text = city.CityName;
        return lable;
    }
    
}

@end
