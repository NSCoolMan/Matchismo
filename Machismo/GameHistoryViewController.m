//
//  GameHistoryViewController.m
//  Machismo
//
//  Created by 天桥雨 on 16/2/4.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "GameHistoryViewController.h"

@interface GameHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *gameHistoryTextView;

@end

@implementation GameHistoryViewController
#if 0
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.receivedHistory = [[NSAttributedString ] @"test";
}
#endif
- (void)setReceivedHistory:(NSAttributedString *)receivedHistory
{
    _receivedHistory = receivedHistory;
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (![self.receivedHistory length]) {
        self.receivedHistory = [[NSAttributedString alloc] initWithString:@"No operation is done!"];
    }
    [self updateUI];
}

- (void)updateUI
{
#if 0
    self.gameHistoryTextView.text = self.receivedHistory;
    self.gameHistoryTextView.textStorage = self.receivedHistory;
#endif    
    [self.gameHistoryTextView setAttributedText:self.receivedHistory];

}
@end
