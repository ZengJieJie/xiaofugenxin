//
//  SIPViewController.m
//  MatchPokerPatti
//
//  Created by adin on 2024/6/14.
//

#import "SIPViewController.h"

@interface SIPViewController ()
@property (nonatomic, strong) NSArray<UIImage *> *imagesArray;
@property (weak, nonatomic) IBOutlet UIView *backview;
@property (strong,nonatomic) NSMutableArray * muarrymuag;
@property (strong,nonatomic) NSString * lastint;
@property (strong,nonatomic)  UIButton * lastbut;
@property(assign,nonatomic) NSInteger gamestat;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger secondsLeft;

@property (weak, nonatomic) IBOutlet UILabel *tilab;
@end

@implementation SIPViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
          //  self.muarrymuag = [[NSMutableArray alloc]init];
    self.gamestat=0;
    [self loaggames];
  
    [self setupGridView];
    
    self.secondsLeft=30;
    // 创建定时器
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                   target:self
                                                 selector:@selector(timerTickout)
                                                 userInfo:nil
                                                  repeats:YES];
            
}
- (void)updatetilab {
    self.tilab.text = [NSString stringWithFormat:@"%ld", (long)self.secondsLeft];
}
- (void)timerTickout {
    self.secondsLeft--;
    [self updatetilab];
    
    if (self.secondsLeft <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self gameovertime];
    }
}

-(void)gameovertime{
    // 创建 UIAlertController
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                message:@"Hello game failure"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
       
       // 创建确定按钮，并添加事件处理方法
       UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self dismissViewControllerAnimated:YES completion:nil];
       }];
       // 将确定按钮添加到弹框
       [alertController addAction:confirmAction];
       // 显示弹框
       [self presentViewController:alertController animated:YES completion:nil];
}


-(void)loaggames{
    self.muarrymuag = [[NSMutableArray alloc]init];
           
           // 生成1到8的随机排列
           NSMutableArray *randomNumbers = [NSMutableArray arrayWithCapacity:12];
           for (int i = 1; i <= 6; i++) {
               [randomNumbers addObject:@(i)];
           }
           // 对数组进行洗牌以随机排序
           NSUInteger count = [randomNumbers count];
           for (NSUInteger i = 0; i < count; ++i) {
               NSInteger remainingCount = count - i;
               NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
               [randomNumbers exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
           }
           
           // 复制排列的前8个数字，形成8对数字d
           for (int i = 0; i < 6; i++) {
               [self.muarrymuag addObject:randomNumbers[i]];
               [self.muarrymuag addObject:randomNumbers[i]];
           }
           // 对数组进行洗牌以随机排序
           count = [self.muarrymuag count];
           for (NSUInteger i = 0; i < count; ++i) {
               NSInteger remainingCount = count - i;
               NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
               [self.muarrymuag exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
           }
      
}



- (void)setupGridView {
    _lastint=@"";
    CGFloat gridSize = (self.backview.bounds.size.width-50)/4;
    CGFloat padding = (self.backview.bounds.size.height-50)/3;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 4; j++) {
            CGFloat x =   10+(j * (padding+10));
            CGFloat y =  10+(i * (padding+10));
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i * 4 + j;
            button.frame = CGRectMake(x, y, gridSize, padding);
            [button setImage:[UIImage imageNamed:@"backimage1"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self.backview addSubview:button];
        }
    }
}

- (void)buttonTapped:(UIButton *)sender {
   
    sender.userInteractionEnabled = NO;
    
    UIImage *newImage =[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.muarrymuag[sender.tag]]];
    
    [UIView transitionWithView:sender
                      duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
       
       
      
            [sender setImage:newImage forState:UIControlStateNormal];
            
        
        
    } completion:^(BOOL finished) {
        if (self.lastbut!=NULL&&[self.lastint isEqual:self.muarrymuag[sender.tag]]&&self.lastbut!=sender) {
            self.lastbut.hidden=YES;
            sender.hidden=YES;
            self.lastbut=NULL;
            self.lastint=@"";
            self.gamestat+=1;
            if (self.gamestat==6) {
                [self gameover];
            }
        }else{
            self.lastint=self.muarrymuag[sender.tag];
            self.lastbut=sender;
            [self performSelector:@selector(flipBackButton:) withObject:sender afterDelay:0.8];
        }
       
    }];
    
}

-(void)gameover{
    // 创建 UIAlertController
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                message:@"Congratulations on finishing the game"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
       
       // 创建确定按钮，并添加事件处理方法
       UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           for (UIView *subview in [self.backview subviews]) {
                  [subview removeFromSuperview];
              }
           self.secondsLeft=30;
           self.lastbut=NULL;
           self.lastint=@"";
           self.gamestat=0;
           [self loaggames];
           [self setupGridView];
       }];
       // 将确定按钮添加到弹框
       [alertController addAction:confirmAction];
       // 显示弹框
       [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)resetclick:(id)sender {
    
    // 创建 UIAlertController
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                 message:@"Whether you need to start over"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        // 创建确定按钮，并添加事件处理方法
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            for (UIView *subview in [self.backview subviews]) {
                   [subview removeFromSuperview];
               }
            self.secondsLeft=60;
            self.lastbut=NULL;
            self.lastint=@"";
            self.gamestat=0;
            [self loaggames];
            [self setupGridView];
        }];
        
        // 创建取消按钮
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          
        }];
        
        // 将确定按钮和取消按钮添加到弹框
        [alertController addAction:confirmAction];
        [alertController addAction:cancelAction];
        
        // 显示弹框
        [self presentViewController:alertController animated:YES completion:nil];
    
  
}


- (void)flipBackButton:(UIButton *)button {
    [UIView transitionWithView:button
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
        [button setImage:[UIImage imageNamed:@"backimage1"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        button.userInteractionEnabled = YES;
    }];
}

- (UIImage *)getRandomImageExceptIndex:(NSInteger)index {
    NSMutableArray *mutableImagesArray = [self.imagesArray mutableCopy];
    [mutableImagesArray removeObjectAtIndex:index % self.imagesArray.count];
    return mutableImagesArray[arc4random_uniform((int)mutableImagesArray.count)];
}
- (IBAction)backbutton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
