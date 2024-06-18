//
//  ViewController.m
//  MatchPokerPatti
//
//  Created by adin on 2024/4/14.
//

#import "ViewController.h"
#import "GACViewController.h"
#import "ShareViewController.h"
#import "RuleViewController.h"
#import "SIPViewController.h"
#import "HellViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)gasuiclick:(UIButton *)sender {
    
    GACViewController * gacvc=[[GACViewController alloc]init];
    [self presentViewController:gacvc animated:YES completion:nil];
}

- (IBAction)sendciilcik:(id)sender {
   
       NSURL *urlToShare = [NSURL URLWithString:@"https://apps.apple.com/app/Te-Patti-Kill-poker/id6504505318"];
       
    
       NSMutableArray * mutableArrayab = [NSMutableArray array];
       
       
       [mutableArrayab addObject:urlToShare];
   
     
       // 创建分享vc
       UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:mutableArrayab applicationActivities:nil];
      
       
       [self presentViewController:activityVC animated:YES completion:nil];
        // 分享之后的回调
       activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
          
       };
}


- (IBAction)yhfkuiclick:(id)sender {
   
    ShareViewController * gacvc=[[ShareViewController alloc]init];
    [self presentViewController:gacvc animated:YES completion:nil];
}
- (IBAction)ruleclkx:(id)sender {
    RuleViewController * gacvc=[[RuleViewController alloc]init];
    [self presentViewController:gacvc animated:YES completion:nil];
}

- (IBAction)sipclikc:(id)sender {
    SIPViewController * gacvc=[[SIPViewController alloc]init];
    [self presentViewController:gacvc animated:YES completion:nil];
    
}

- (IBAction)hellclcik:(id)sender {
    HellViewController * gacvc=[[HellViewController alloc]init];
    [self presentViewController:gacvc animated:YES completion:nil];
    
} 

@end
