//
//  SetCard.h
//  Machismo
//
//  Created by 天桥雨 on 16/2/5.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "Card.h"
#import <UIKit/UIKit.h>

@interface SetCard : Card

@property (strong, nonatomic) NSMutableAttributedString *suit;

@property (strong, nonatomic) UIColor *color;

+(NSArray *)validSuits;

+(NSArray *)validAttributeValues;

+(NSUInteger)maxValue;

@end
