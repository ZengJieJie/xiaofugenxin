//
//  Deck.h
//  HomeRummygames
//
//  Created by adin on 2024/6/20.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property (nonatomic, strong) NSMutableArray *cards;

- (instancetype)init;
- (void)shuffle;
- (Card *)drawCard;

@end
