//
//  ViewController.m
//  HomeRummygames
//
//  Created by adin on 2024/6/13.
//

#import "ViewController.h"
#import "RumViewController.h"
#import "GameGuiViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)gamesstartclick:(id)sender {
    
    RumViewController *vc= [[RumViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)gameguizeview:(id)sender {
    
    GameGuiViewController *vc= [[GameGuiViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}


- (IBAction)sharclick:(id)sender {
    
    NSURL *urlToShare = [NSURL URLWithString:@"https://apps.apple.com/app/Teen-Patti-Suit-Card/id6504858884"];
    
 
    NSMutableArray * mutableArrayab = [NSMutableArray array];
    
    
    [mutableArrayab addObject:urlToShare];

  
    // 创建分享vc
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:mutableArrayab applicationActivities:nil];
   
    
    [self presentViewController:activityVC animated:YES completion:nil];
     // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
       
    };
    
    
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
