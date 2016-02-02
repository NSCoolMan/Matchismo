//
//  CardMatchingGame.m
//  Machismo
//
//  Created by 天桥雨 on 16/1/22.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];//super's designated initializer
    
    if (self) {
        for (int i = 0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else
            {
                self = nil;
                break;
            }
        }
    }
    
    return  self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return index < [self.cards count] ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (self.mode == 0) {
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
                self.result = [NSString stringWithFormat:@"%@ is dropped.", card.contents];
            }else{
                self.result = [NSString stringWithFormat:@"%@ is chosen.", card.contents];
                //match against other chosen cards
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                            self.result = [NSString stringWithFormat:@"Matched %@ %@ for %d points.", otherCard.contents, card.contents, matchScore * MATCH_BONUS];
                        }else{
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            self.result = [NSString stringWithFormat:@"%@%@ don’t match!%d point penalty!", otherCard.contents,card.contents,MISMATCH_PENALTY];
                        }
                        break; // can only choose 2 cards for now
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
                self.result = [self.result stringByAppendingString:[NSString stringWithFormat:@"And %d is costed to choose!", COST_TO_CHOOSE]];
            }
        }
    }else{
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
                self.result = [NSString stringWithFormat:@"%@ is dropped.", card.contents];
            }else{
                self.result = [NSString stringWithFormat:@"%@ is chosen.", card.contents];
                
                int i = 0;
                int j = 0;
                Card *firstOtherCard = [[Card alloc] init];
                //match against other chosen cards
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            i += 1;
                            if (i == 1) {
                                firstOtherCard = otherCard;
                                self.result = [[NSString stringWithFormat:@"%@ is chosen.", firstOtherCard.contents] stringByAppendingString:self.result];
                            }
                            if (i == 2) {
                                matchScore = [card match:@[firstOtherCard,otherCard]];
                                self.score += matchScore * MATCH_BONUS;
                                firstOtherCard.matched = YES;
                                otherCard.matched = YES;
                                card.matched = YES;
                                self.result = [NSString stringWithFormat:@"Matched %@ %@ %@ for %d points.", firstOtherCard.contents,otherCard.contents, card.contents, matchScore * MATCH_BONUS];
                            }
                        }else{
                            self.score -= MISMATCH_PENALTY;
                            for (Card *tempCard in self.cards) {
                                if (tempCard.isChosen == YES) {
                                    j += 1;
                                    if (j == 1) {
                                        firstOtherCard = tempCard;
                                    }
                                    if ([firstOtherCard.contents isEqualToString:otherCard.contents]&& j ==2) {
                                        firstOtherCard = tempCard;
                                    }
                                }
                                tempCard.chosen = NO;
                            }
                            if (j == 1) {
                                self.result = [NSString stringWithFormat:@"%@ %@ don’t match!%d point penalty!", otherCard.contents,card.contents,MISMATCH_PENALTY];
                            }else if(j == 2){
                                self.result = [NSString stringWithFormat:@"%@ %@ %@ don’t match!%d point penalty!", firstOtherCard.contents,otherCard.contents,card.contents,MISMATCH_PENALTY];
                            }
                            
                            break;//choose card failed
                        }
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }
}


@end
