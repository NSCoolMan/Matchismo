//
//  Deck.h
//  Machismo
//
//  Created by 天桥雨 on 16/1/21.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
