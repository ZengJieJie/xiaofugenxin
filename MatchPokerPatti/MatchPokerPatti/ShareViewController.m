//
//  ShareViewController.m
//  MatchPokerPatti
//
//  Created by adin on 2024/6/13.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)subclick:(id)sender {
    
    // 创建 UIAlertController
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips Title"
                                                                                message:@"This is an alert message."
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
- (IBAction)backlcik:(id)sender {
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
