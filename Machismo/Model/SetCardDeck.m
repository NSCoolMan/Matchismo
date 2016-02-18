//
//  SetCardDeck.m
//  Machismo
//
//  Created by 天桥雨 on 16/2/5.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    NSLog(@"9");
    self = [super init];
    
    if (self) {
        NSLog(@"10");
        for (NSString* validsuit in [SetCard validSuits]) {
            for (NSUInteger i = 0; i < [SetCard maxValue]; i++) {
                
                SetCard *card = [[SetCard alloc] init];
                card.color = (UIColor *)[SetCard validAttributeValues][i];
                CGFloat r, g, b, a;
                [card.color getRed:&r green:&g blue:&b alpha:&a];
                NSLog(@"r, g, b = %f,%f,%f", r,g,b);
                
                card.suit = [[NSMutableAttributedString alloc] initWithString:validsuit attributes:@{NSForegroundColorAttributeName: card.color}];
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
