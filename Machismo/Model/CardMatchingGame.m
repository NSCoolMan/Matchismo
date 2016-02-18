//
//  CardMatchingGame.m
//  Machismo
//
//  Created by 天桥雨 on 16/1/22.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "SetCard.h"

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
    NSLog(@"3");
    self = [super init];//super's designated initializer
    
    if (self) {
        for (int i = 0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            NSLog(@"suit = %@",((SetCard *)card).suit);
            
            if (card) {
                [self.cards addObject:card];
            }else
            {
                self = nil;
                break;
            }
        }
    }
    NSLog(@"4");
    return  self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    NSLog(@"test");
    return index < [self.cards count] ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (card.gameMode == 0) {
        NSLog(@"18");
#if 1
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
#if 0
                self.result = [NSString stringWithFormat:@"%@ is dropped.", card.contents];
#endif
                self.result = [[NSMutableAttributedString alloc] initWithString:[card.contents stringByAppendingString:@" is dropped."]];
            }else{
#if 0
                self.result = [NSString stringWithFormat:@"%@ is chosen.", card.contents];
#endif
                self.result = [[NSMutableAttributedString alloc] initWithString:[card.contents stringByAppendingString:@" is chosen."]];
                //match against other chosen cards
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
#if 0
                            self.result = [NSString stringWithFormat:@"Matched %@ %@ for %d points.", otherCard.contents, card.contents, matchScore * MATCH_BONUS];
#endif
                            self.result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Matched %@ %@ for %d points.", otherCard.contents, card.contents, matchScore * MATCH_BONUS]];
                        }else{
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
#if 0
                            self.result = [NSString stringWithFormat:@"%@%@ don’t match!%d point penalty!", otherCard.contents,card.contents,MISMATCH_PENALTY];
#endif
                            self.result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@ don’t match!%d point penalty!", otherCard.contents,card.contents,MISMATCH_PENALTY]];
                        }
                        break; // can only choose 2 cards for now
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
                NSLog(@"card is chosen.");
#if 0
                self.result = [self.result stringByAppendingString:[NSString stringWithFormat:@"And %d is costed to choose!", COST_TO_CHOOSE]];
#endif
                [self.result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"And %d is costed to choose!", COST_TO_CHOOSE]]];
            }
        }
#endif
    }else{
        
        NSLog(@"11");
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
                self.result = (NSMutableAttributedString *)card.contents;
                [self.result appendAttributedString:[[NSAttributedString alloc] initWithString:@"is dropped."]];
#if 0
                [[(NSAttributedString *)card.contents string] stringByAppendingString:@"is dropped."];
#endif
                [NSString stringWithFormat:@"%@ is dropped.", [(NSAttributedString *)card.contents string]];
            }else{
                NSLog(@"contents = %@", [(NSMutableAttributedString *)card.contents string]);
                self.result = [(NSMutableAttributedString *)card.contents mutableCopy];
                [self.result appendAttributedString:[[NSAttributedString alloc] initWithString:@"is chosen."]];
#if 0
                [NSString stringWithFormat:@"%@ is chosen.", [(NSAttributedString *)card.contents string]];
#endif
                NSLog(@"result = %@", [(NSMutableAttributedString *)self.result string]);
                NSLog(@"contents = %@", [(NSMutableAttributedString *)card.contents string]);
                
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
                                NSMutableAttributedString *tempCard = [(NSMutableAttributedString *)firstOtherCard.contents mutableCopy];
                                [tempCard appendAttributedString:[[NSAttributedString alloc] initWithString:@" is chosen."]];
                                [tempCard appendAttributedString:self.result];
                                self.result = tempCard;
#if 0
                                [[NSString stringWithFormat:@"%@ is chosen.", [(NSAttributedString *)firstOtherCard.contents string]] stringByAppendingString:self.result];
#endif
                            }
                            if (i == 2) {
                                matchScore = [card match:@[firstOtherCard,otherCard]];
                                self.score += matchScore * MATCH_BONUS;
                                firstOtherCard.matched = YES;
                                otherCard.matched = YES;
                                card.matched = YES;
                                self.result = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
                                [self.result appendAttributedString:(NSMutableAttributedString *)firstOtherCard.contents];
                                [self.result appendAttributedString:(NSMutableAttributedString *)otherCard.contents];
                                [self.result appendAttributedString:(NSMutableAttributedString *)card.contents];
                                [self.result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %d points.", matchScore * MATCH_BONUS]]];
#if 0
                                [NSString stringWithFormat:@"Matched %@ %@ %@ for %d points.", [(NSAttributedString *)firstOtherCard.contents string],[(NSAttributedString *)otherCard.contents string], [(NSAttributedString *)card.contents string], matchScore * MATCH_BONUS];
#endif
                            }
                        }else{
                            self.score -= MISMATCH_PENALTY;
                            for (Card *tempCard in self.cards) {
                                if (tempCard.isChosen == YES) {
                                    j += 1;
                                    if (j == 1) {
                                        firstOtherCard = tempCard;
                                    }
                                    if ([(NSAttributedString *)firstOtherCard.contents isEqualToAttributedString:(NSAttributedString *)otherCard.contents] && j ==2) {
                                        firstOtherCard = tempCard;
                                    }
                                }
                                tempCard.chosen = NO;
                            }
                            if (j == 1) {
                                self.result = [(NSMutableAttributedString *)otherCard.contents mutableCopy];
                                [self.result appendAttributedString:(NSMutableAttributedString *)card.contents];
                                [self.result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" dont't match!%d point penalty!", MISMATCH_PENALTY]]];
#if 0
                                [NSString stringWithFormat:@"%@ %@ don’t match!%d point penalty!", [(NSAttributedString *)otherCard.contents string],[(NSAttributedString *)card.contents string],MISMATCH_PENALTY];
#endif
                            }else if(j == 2){
                                self.result = [(NSMutableAttributedString *)firstOtherCard.contents mutableCopy];
                                [self.result appendAttributedString:(NSMutableAttributedString *)otherCard.contents];
                                [self.result appendAttributedString:(NSMutableAttributedString *)card.contents];
                                [self.result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match!%d point penalty!", MISMATCH_PENALTY]]];
#if 0
                                [NSString stringWithFormat:@"%@ %@ %@ don’t match!%d point penalty!", [(NSAttributedString *)firstOtherCard.contents string],[(NSAttributedString *)otherCard.contents string],[(NSAttributedString *)card.contents string],MISMATCH_PENALTY];
#endif
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
