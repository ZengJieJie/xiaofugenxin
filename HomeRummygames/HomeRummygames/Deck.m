//
//  Deck.m
//  HomeRummygames
//
//  Created by adin on 2024/6/20.
//

#import "Deck.h"

@implementation Deck
- (instancetype)init {
    self = [super init];
    if (self) {
        _cards = [NSMutableArray array];
        for (NSString *suit in [Card suits]) {
            for (NSString *rank in [Card ranks]) {
                Card *card = [[Card alloc] initWithSuit:suit rank:rank];
                [_cards addObject:card];
            }
        }
    }
    return self;
}

- (void)shuffle {
    NSUInteger count = [self.cards count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSUInteger n = arc4random_uniform((uint32_t)count);
        [self.cards exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (Card *)drawCard {
    if ([self.cards count] == 0) return nil;
    Card *card = [self.cards lastObject];
    [self.cards removeLastObject];
    return card;
}
@end
