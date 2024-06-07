//
//  HardViewController.m
//  Numberpattii
//
//  Created by adin on 2024/6/3.
//

#import "HardViewController.h"
#import "Masonry.h"
@interface HardViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray; // 假设这里是存放图片数据的数组
@property (nonatomic,assign) int onwint;//1
@property (nonatomic,assign) int twoint;//2
@property (nonatomic,assign) int threeint;//3
@property (nonatomic,assign) int fourint;//4
@property (nonatomic,assign) int fiveint;//5
@property (nonatomic, strong) NSTimer *timer;
@property (strong,nonatomic) NSString * fuhaostringone;//+-*/
@property (strong,nonatomic) NSString * fuhaostringtwo;
@property (weak, nonatomic) IBOutlet UIButton *timerbut;

@property (nonatomic, assign) NSInteger remainingTime;

@property (weak, nonatomic) IBOutlet UIImageView *imageowe;

@property (weak, nonatomic) IBOutlet UIImageView *imagetwo;

@property (weak, nonatomic) IBOutlet UIImageView *imagethree;

@property (weak, nonatomic) IBOutlet UIImageView *imagefour;

@property (weak, nonatomic) IBOutlet UIImageView *imagefive;

@property (weak, nonatomic) IBOutlet UIImageView *imagefuhaoone;

@property (weak, nonatomic) IBOutlet UIImageView *imagefuhaotwo;

@property (weak, nonatomic) IBOutlet UILabel *huihelab;

@property (nonatomic,assign) int huiheiint;//回合数

@property (nonatomic,assign) int moshiint;//模式

@end

@implementation HardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.fourint=-1;
    self.twoint=-1;
    self.threeint=-1;
    self.onwint=-1;
    self.fiveint=-1;
    self.huiheiint=1;
    [self generateValidNumbers];
    [self updateimageview];
       // 假设dataArray已经有了数据
       self.dataArray = @[@"0", @"1", @"2", @"3", @"4",@"5", @"6", @"7", @"8", @"9"];
       [self.view addSubview:self.collectionView];
    // 创建一个 UIView
       UIView *customView = [[UIView alloc] init];
       customView.backgroundColor = [UIColor clearColor];
       [self.view addSubview:customView];
       [customView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.equalTo(self.view);
           make.width.equalTo(self.view).multipliedBy(2.0/3.0);
           make.height.equalTo(self.view).multipliedBy(3.0/10.0);
           make.bottom.equalTo(self.view).offset(-10);
       }];
    UIImageView * backimage=[[UIImageView alloc]init];
    [backimage setImage:[UIImage imageNamed:@"图层 3"]];
    [customView addSubview:backimage];
    
    [backimage mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(customView);
       }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
       
       // 创建 UICollectionView
       self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];

    [customView addSubview:self.collectionView];
    // 使用 Masonry 设置约束
       [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(customView).insets(UIEdgeInsetsMake(30, 30, 5, 30)); // 距离父视图四周10个像素
       }];
    [self startTimer];
}

-(void)nsuserdatte{
    NSDate *currentDate = [NSDate date];
       
      
       NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
       [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
       
       
       NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSString * paimstr=[NSString stringWithFormat:@"%@  %d Round Hard",dateString,self.huiheiint];
       
      
       NSMutableArray *datesArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"datesArray"] mutableCopy];
       if (!datesArray) {
           datesArray = [NSMutableArray array];
       }
       
    // 添加当前时间到数组的前面
       [datesArray insertObject:paimstr atIndex:0];
       
       // 保存数组到 NSUserDefaults
       [[NSUserDefaults standardUserDefaults] setObject:datesArray forKey:@"datesArray"];
       [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)startTimer {
    // 如果已有定时器，先取消它
       [self.timer invalidate];
       self.timer = nil;
       
       // 初始化剩余时间
       self.remainingTime = 15;
       
       // 更新按钮标题
       [self updateButtonTitle];
       
       // 创建新的定时器
       self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(updateTimer)
                                                   userInfo:nil
                                                    repeats:YES];
}
- (void)updateTimer {
    if (self.remainingTime > 0) {
        self.remainingTime--;
        [self updateButtonTitle];
    } else {
        [self.timer invalidate];
        self.timer = nil;
        [self timerFired];
    }
}
//更新按钮
- (void)updateButtonTitle {
    NSString *title = [NSString stringWithFormat:@"%ld",(long)self.remainingTime];
    [UIView performWithoutAnimation:^{
        [self.timerbut setTitle:title forState:UIControlStateNormal];
     }];
}
- (void)timerFired {
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                message:@"Game over"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self nsuserdatte];
           [self dismissViewControllerAnimated:YES completion:nil];
         
       }];
       
       [alertController addAction:confirmAction];
       
       [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)backbut:(UIButton *)sender {
    if (self.moshiint) {
        self.twoint=-1;
        self.imagetwo.image=[UIImage imageNamed:@""];
    }else{
        self.onwint=-1;
        self.imageowe.image=[UIImage imageNamed:@""];
    }
      
}
   #pragma mark - UICollectionViewDataSource

   - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
       return self.dataArray.count;
   }
   - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
       UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
       
       // 清空cell的内容视图
       for (UIView *subview in cell.contentView.subviews) {
           [subview removeFromSuperview];
       }
       
       UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       button.frame = CGRectMake(0, 0, cell.bounds.size.width,cell.bounds.size.height);
       // 设置按钮的位置和大小
      
       // 设置按钮的背景图片
       UIImage *buttonImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]]];
       [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
       button.tag=indexPath.row+1;
       // 添加按钮点击事件
       [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

       [cell.contentView addSubview:button];
       return cell;
   }

   //点击数字按钮
- (void)buttonClicked:(UIButton *)btn{
   
    long btnint=btn.tag;
    if (self.moshiint) {
        NSLog(@"%d",self.twoint);
        self.imagetwo.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld",btnint-1]];
        if (self.twoint==btnint-1) {
            [self showAlert];
        }
        
        
        
    }else if(self.moshiint==0){
        NSLog(@"%d",self.onwint);
        self.imageowe.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld",btnint-1]];
        if (self.onwint==btnint-1) {
            [self showAlert];
        }
        
        
    }else{
        NSLog(@"%d",self.fiveint);
        self.imagefive.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld",btnint-1]];
        if (self.fiveint==btnint-1) {
            [self showAlert];
        }
        
    }
    
   
    
    
    
    
   
    
   
    
   
}
- (void)showAlert {
    // 创建 UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                             message:@"Choose correctly to enter the next level"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建确定按钮
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self updatgmae];
        [self startTimer];
    }];
    
    // 将确定按钮添加到弹窗
    [alertController addAction:confirmAction];
    
    // 显示弹窗
    [self presentViewController:alertController animated:YES completion:nil];
}
    

-(void)updatgmae{
    
    // Do any additional setup after loading the view from its nib.
    // Do any additional setup after loading the view.
    self.huiheiint++;
    [self.huihelab setText:[NSString stringWithFormat:@"%d Round",self.huiheiint]];
    self.onwint=-1;
    self.imageowe.image=[UIImage imageNamed:@""];
    self.fourint=-1;
    self.imagefour.image=[UIImage imageNamed:@""];
    self.threeint=-1;
    self.imagethree.image=[UIImage imageNamed:@""];
    self.twoint=-1;
    self.imagetwo.image=[UIImage imageNamed:@""];
    
    self.fiveint=-1;
    self.imagefive.image=[UIImage imageNamed:@""];
    
    [self generateValidNumbers];
    [self updateimageview];
    
}
//更新游戏界面

-(void)updateimageview{
   
    if(self.moshiint){
        self.imageowe.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.onwint]];
        
        self.imagefive.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.fiveint]];
     
        
        if ([self.fuhaostringone isEqualToString:@"/"]) {
            self.imagefuhaoone.image=[UIImage imageNamed:@"123456"];
        }else{
            self.imagefuhaoone.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.fuhaostringone]];
        }
        
        
        if ([self.fuhaostringtwo isEqualToString:@"/"]) {
            self.imagefuhaotwo.image=[UIImage imageNamed:@"123456"];
        }else{
            self.imagefuhaotwo.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.fuhaostringtwo]];
        }
        
        
        if (self.fourint>=0) {
            self.imagethree.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.threeint]];
            self.imagefour.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.fourint]];
        }else{
            self.imagethree.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.threeint]];
        }
        
      
    }else if(self.moshiint==0){
        self.imagetwo.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.twoint]];
        
        self.imagefive.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.fiveint]];
     
        
        if ([self.fuhaostringone isEqualToString:@"/"]) {
            self.imagefuhaoone.image=[UIImage imageNamed:@"123456"];
        }else{
            self.imagefuhaoone.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.fuhaostringone]];
        }
        
        
        if ([self.fuhaostringtwo isEqualToString:@"/"]) {
            self.imagefuhaotwo.image=[UIImage imageNamed:@"123456"];
        }else{
            self.imagefuhaotwo.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.fuhaostringtwo]];
        }
        
        
        if (self.fourint>=0) {
            self.imagethree.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.threeint]];
            self.imagefour.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.fourint]];
        }else{
            self.imagethree.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.threeint]];
        }
      
        
        
        
    }else{
        self.imagetwo.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.twoint]];
        
        self.imageowe.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.onwint]];
     
        
        if ([self.fuhaostringone isEqualToString:@"/"]) {
            self.imagefuhaoone.image=[UIImage imageNamed:@"123456"];
        }else{
            self.imagefuhaoone.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.fuhaostringone]];
        }
        
        if ([self.fuhaostringtwo isEqualToString:@"/"]) {
            self.imagefuhaotwo.image=[UIImage imageNamed:@"123456"];
        }else{
            self.imagefuhaotwo.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.fuhaostringtwo]];
        }
        
        
        if (self.fourint>=0) {
            self.imagethree.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.threeint]];
            self.imagefour.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.fourint]];
        }else{
            self.imagethree.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",self.threeint]];
        }
        
      
        
        
    }
    
    
}
//随机生成一组数学数字
- (void)generateValidNumbers {
    int num1, num2, num3;
    int result = 0;
       NSString *op1, *op2;
    self.moshiint=arc4random_uniform(3);
       NSArray *operators = @[@"+", @"-", @"*", @"/"];
       
       while (1) {
           // 随机生成三个数字（范围1到9）
           num1 = arc4random_uniform(9) + 1;
           num2 = arc4random_uniform(9) + 1;
           num3 = arc4random_uniform(9) + 1;
           // 随机选择两个运算符
           op1 = operators[arc4random_uniform((uint32_t)operators.count)];
           op2 = operators[arc4random_uniform((uint32_t)operators.count)];
           // 计算第一个运算符的结果
           int intermediateResult;
           
           if (([op2 isEqual:@"+"]||[op2 isEqual:@"-"])&&![op1 isEqual:@"+"]&&![op1 isEqual:@"-"]) {
               // 计算最终结果
               if ([op2 isEqualToString:@"+"]) {
                   intermediateResult = num2 + num3;
               } else if ([op2 isEqualToString:@"-"]) {
                   intermediateResult = num2 - num3;
               } else if ([op2 isEqualToString:@"*"]) {
                   intermediateResult = num2 * num3;
               } else {
                   if (num3 == 0) continue; // 防止除以零
                   intermediateResult = num2 / num3;
                   if (intermediateResult*num3!=num2) continue;
               }

               if ([op1 isEqualToString:@"+"]) {
                   result = num1 + intermediateResult;
               } else if ([op1 isEqualToString:@"-"]) {
                   result = num1 - intermediateResult;
               } else if ([op1 isEqualToString:@"*"]) {
                   result = num1 * intermediateResult;
               } else {
                   if (num2 == 0) continue; // 防止除以零
                   result = num1 / intermediateResult;
                   
                   if (intermediateResult*result!=num1) continue;
               }
           }else{
               if ([op1 isEqualToString:@"+"]) {
                   intermediateResult = num1 + num2;
               } else if ([op1 isEqualToString:@"-"]) {
                   intermediateResult = num1 - num2;
               } else if ([op1 isEqualToString:@"*"]) {
                   intermediateResult = num1 * num2;
               } else {
                   if (num2 == 0) continue; // 防止除以零
                   intermediateResult = num1 / num2;
                   
                   if (intermediateResult*num2!=num1) continue;
               }

               // 计算最终结果
               if ([op2 isEqualToString:@"+"]) {
                   result = intermediateResult + num3;
               } else if ([op2 isEqualToString:@"-"]) {
                   result = intermediateResult - num3;
               } else if ([op2 isEqualToString:@"*"]) {
                   result = intermediateResult * num3;
               } else {
                   if (num3 == 0) continue; // 防止除以零
                   result = intermediateResult / num3;
                   if (result*num3!=intermediateResult) continue;
               }
               
           }
           
           // 确保结果是个位数且小于100
           if (result < 100 && result >= 10) {
               break;
           }
       }
       
 
       
      
    
    self.onwint=num1;
    self.twoint=num2;
    self.fiveint=num3;
    self.fuhaostringone=op1;
    self.fuhaostringtwo=op2;
    
    if (result<10) {
        self.threeint=result;
        
    }else{
        self.threeint=result/10;
     
        self.fourint = result % 10;
    }
    NSLog(@"%d%@%d%@%d=%d%d",self.onwint,self.fuhaostringone,self.twoint,self.fuhaostringtwo,self.fiveint,self.threeint,self.fourint);
    
    
    
   
   
}
- (IBAction)backclick:(id)sender {
    [self nsuserdatte];
    [self dismissViewControllerAnimated:YES completion:nil];
}

   #pragma mark - UICollectionViewDelegateFlowLayout
   - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
       return CGSizeMake(collectionView.frame.size.width * 0.13, collectionView.frame.size.height);
   }

   - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
       return 10; // 无间距
   }







@end

