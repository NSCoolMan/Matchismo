//
//  SetCard.m
//  Machismo
//
//  Created by 天桥雨 on 16/2/5.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    if (otherCards.count == 1) {
        SetCard *otherCard = [otherCards firstObject];
        if ([[otherCard.suit string] isEqualToString: [self.suit string]]) {
            score += 4;
        }else if (otherCard.color == self.color){
            score += 1;
        }
    }else if (otherCards.count == 2) {
        SetCard *firstOtherCard = [otherCards firstObject];
        SetCard *secondOtherCard = [otherCards lastObject];
        if ([[firstOtherCard.suit string] isEqualToString:[secondOtherCard.suit string]] && [[secondOtherCard.suit string] isEqualToString:[self.suit string]]) {
            score += 3;
        }else if((firstOtherCard.color == secondOtherCard.color) && (secondOtherCard.color == self.color)) {
            score += 4;
        }
    }
    
    return score;
}

-(NSUInteger)gameMode
{
    return 1;
}

- (NSMutableAttributedString *)contents
{
    return self.suit;
}

+(NSArray *)validSuits
{
    return @[@"▲", @"●", @"■"];
}

+(NSArray *)validAttributeValues
{
    return @[[UIColor greenColor], [UIColor redColor], [UIColor blackColor], [UIColor blueColor], [UIColor darkGrayColor], [UIColor lightGrayColor], [UIColor yellowColor], [UIColor purpleColor], [UIColor orangeColor], [UIColor magentaColor], [UIColor cyanColor], [UIColor brownColor]];
}

+(NSUInteger)maxValue
{
    NSLog(@"maxValue = %lu",[[SetCard validAttributeValues] count]);
    return [[SetCard validAttributeValues] count];
}

@end
