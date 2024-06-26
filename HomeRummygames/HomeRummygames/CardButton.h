//
//  CardButton.h
//  HomeRummygames
//
//  Created by adin on 2024/6/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardButton : UIButton
@property (nonatomic, strong) NSString *suit;
@property (nonatomic, strong) NSString *rank;

- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank;
@end

NS_ASSUME_NONNULL_END
