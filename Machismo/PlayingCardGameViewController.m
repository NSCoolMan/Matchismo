//
//  PlayingCardGameViewController.m
//  Machismo
//
//  Created by 天桥雨 on 16/2/3.
//  Copyright (c) 2016年 Coolman. All rights reserved.

//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)creatDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
