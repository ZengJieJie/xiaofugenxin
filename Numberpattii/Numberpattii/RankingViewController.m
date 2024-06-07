//
//  RankingViewController.m
//  Numberpattii
//
//  Created by adin on 2024/6/7.
//

#import "RankingViewController.h"

@interface RankingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labo;

@property (weak, nonatomic) IBOutlet UILabel *labw;
@property (weak, nonatomic) IBOutlet UILabel *labt;


@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 从 NSUserDefaults 读取数组
      NSArray *savedDatesArray = [[NSUserDefaults standardUserDefaults] arrayForKey:@"datesArray"];
    if (savedDatesArray.count>=1) {
        self.labo.text=savedDatesArray[0];
    }
    
    if (savedDatesArray.count>=2) {
        self.labw.text=savedDatesArray[1];
    }
    
    if (savedDatesArray.count>=3) {
        self.labt.text=savedDatesArray[2];
    }
    
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
