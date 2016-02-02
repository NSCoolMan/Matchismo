//
//  PlayingCard.h
//  Machismo
//
//  Created by 天桥雨 on 16/1/21.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;

@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;

+(NSUInteger)maxRank;

@end
