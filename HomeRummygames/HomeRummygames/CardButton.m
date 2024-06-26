//
//  CardButton.m
//  HomeRummygames
//
//  Created by adin on 2024/6/19.
//

#import "CardButton.h"

@implementation CardButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank {
    self = [super init];
    if (self) {
        _suit = suit;
        _rank = rank;
        if ([rank isEqual:@"11"]) {
            
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"J-%@",suit]] forState:UIControlStateNormal];
        }else if ([rank isEqual:@"12"]){
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Q-%@",suit]] forState:UIControlStateNormal];
        }else if ([rank isEqual:@"13"]){
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"K-%@",suit]] forState:UIControlStateNormal];
        }else if ([rank isEqual:@"14"]){
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"A-%@",suit]] forState:UIControlStateNormal];
        }else{
            [self setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-%@",rank,suit]] forState:UIControlStateNormal];
        }
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
