//
//  SetGameViewController.m
//  Machismo
//
//  Created by 天桥雨 on 16/2/5.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Deck *)creatDeck
{
    NSLog(@"8");
    return [[SetCardDeck alloc] init];
}

@end
