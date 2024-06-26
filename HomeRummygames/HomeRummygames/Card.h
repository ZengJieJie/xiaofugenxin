//
//  Card.h
//  HomeRummygames
//
//  Created by adin on 2024/6/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject
@property (nonatomic, strong) NSString *suit;
@property (nonatomic, strong) NSString *rank;

- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank;
+ (NSArray *)ranks;
+ (NSArray *)suits;
@end

NS_ASSUME_NONNULL_END
