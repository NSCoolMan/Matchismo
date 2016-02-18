//
//  ViewController.h
//  Machismo
//
//  Created by 天桥雨 on 16/1/20.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//
//Abstract class. Must implement methods as descriped below.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController

//protected
//for subclasses
- (Deck *)creatDeck; // abstract

@property (strong, nonatomic) NSMutableAttributedString *historyNotes;

@end

