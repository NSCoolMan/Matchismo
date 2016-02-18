//
//  Card.m
//  Machismo
//
//  Created by 天桥雨 on 16/1/21.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards{
    int score = 0;
    
    for (Card * card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

-(NSUInteger) gameMode
{
    return 0;
}

@end
