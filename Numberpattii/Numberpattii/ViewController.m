//
//  ViewController.m
//  Numberpattii
//
//  Created by adin on 2024/4/20.
//

#import "ViewController.h"
#import "ADDViewController.h"
#import "NormalViewController.h"
#import "HardViewController.h"
#import "UserfeedbackViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnclick:(UIButton *)sender {
    
    ADDViewController * addview=[[ADDViewController alloc]init];
    [self presentViewController:addview animated:YES completion:nil];
}


  


- (IBAction)febclikc:(id)sender {
    UserfeedbackViewController *modalVC = [[UserfeedbackViewController alloc] initWithNibName:@"UserfeedbackViewController" bundle:nil];
    [self presentViewController:modalVC animated:YES completion:nil];
    
}
- (IBAction)clearclick:(id)sender {
    
         // 创建 UIAlertController
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                  message:@"Clearing cache succeeded"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
         
         // 创建确定按钮
         UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             
         }];
         
         // 将确定按钮添加到弹窗
         [alertController addAction:confirmAction];
         
         // 显示弹窗
         [self presentViewController:alertController animated:YES completion:nil];
     
}


- (IBAction)nobtn:(id)sender {
    
    NormalViewController *modalVC = [[NormalViewController alloc] initWithNibName:@"NormalViewController" bundle:nil];
    [self presentViewController:modalVC animated:YES completion:nil];
}

- (IBAction)hardbtn:(id)sender {
    
    HardViewController *modalVC = [[HardViewController alloc] initWithNibName:@"HardViewController" bundle:nil];
    [self presentViewController:modalVC animated:YES completion:nil];
    
}


@end
