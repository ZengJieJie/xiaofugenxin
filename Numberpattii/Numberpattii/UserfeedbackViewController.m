//
//  UserfeedbackViewController.m
//  Numberpattii
//
//  Created by adin on 2024/6/3.
//

#import "UserfeedbackViewController.h"

@interface UserfeedbackViewController ()

@end

@implementation UserfeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)btnclikc:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)sumbtn:(id)sender {
    
   
        // 创建 UIAlertController
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                 message:@"Feedback Success"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        // 创建确定按钮
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        // 将确定按钮添加到弹窗
        [alertController addAction:confirmAction];
        
        // 显示弹窗
        [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
