//
//  Card.h
//  Machismo
//
//  Created by 天桥雨 on 16/1/21.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;

@end
