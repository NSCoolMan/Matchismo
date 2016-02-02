//
//  CardMatchingGame.h
//  Machismo
//
//  Created by 天桥雨 on 16/1/22.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSInteger score;
@property (nonatomic) int mode;
@property (strong, nonatomic) NSString * result;

@end
