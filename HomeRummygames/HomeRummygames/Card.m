//
//  Card.m
//  HomeRummygames
//
//  Created by adin on 2024/6/20.
//

#import "Card.h"

@implementation Card
- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank {
    self = [super init];
    if (self) {
        _suit = suit;
        _rank = rank;
    }
    return self;
}

+ (NSArray *)ranks {
    return @[@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14"];
}

+ (NSArray *)suits {
    return @[@"♠︎", @"♥︎", @"♣︎", @"♦︎"];
}

@end
