//
//  ViewController.m
//  Machismo
//
//  Created by 天桥雨 on 16/1/20.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "GameHistoryViewController.h"

@interface ViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardssButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeControl;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"PlayingCardGameHistory"] || [segue.identifier isEqual:@"SetCardGameHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]) {
            GameHistoryViewController *vcsd = (GameHistoryViewController *)segue.destinationViewController;
            vcsd.receivedHistory = self.historyNotes;
        }
    }
}

-(CardMatchingGame *)game
{
    NSLog(@"1");
    if (!_game) {
        NSLog(@"5");
        NSLog(@"count = %d", (int)[self.cardssButtons count]);
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardssButtons count] usingDeck:self.deck];
    }
    NSLog(@"2");
    return _game;
}

- (Deck *) deck{
    NSLog(@"6");
    if (!_deck) {
        NSLog(@"7");
        _deck = [self creatDeck];
    }
    return _deck;
}

- (Deck *)creatDeck // abstract
{
    return nil;
}

- (NSMutableAttributedString *)historyNotes
{
    if (!_historyNotes) {
        _historyNotes = [[NSMutableAttributedString alloc] init];
    }
    return _historyNotes;
}
- (IBAction)TouchCardsButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardssButtons indexOfObject:sender];
    NSLog(@"index = %d", (int)chosenButtonIndex);
    
#if 0
    self.resultLabel.text = [NSString stringWithFormat:@"%@",[self.game cardAtIndex:chosenButtonIndex].contents] ;
    NSLog(@"label.txt = %@", self.resultLabel.text);
#endif
    
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    NSLog(@"14");
    if ([[self.historyNotes string] isEqualToString:@"No operation is done!"]) {
        NSLog(@"15");
        self.historyNotes = [[NSMutableAttributedString alloc] initWithString:@""];
    }
    NSLog(@"16");
    NSLog(@"historynotes = %@", self.historyNotes);
    
#if 0
    self.historyNotes = [self.historyNotes stringByAppendingFormat:@"%@\n",self.resultLabel.text];
#endif
    
    [self.historyNotes appendAttributedString:[self.resultLabel attributedText]];
    [self.historyNotes appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    self.modeControl.enabled = NO;

    
}

- (IBAction)TouchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardssButtons indexOfObject:sender];
    NSLog(@"index = %d", (int)chosenButtonIndex);
#if 1
    self.resultLabel.text = [NSString stringWithFormat:@"%@",[self.game cardAtIndex:chosenButtonIndex].contents] ;
    NSLog(@"label.txt = %@", self.resultLabel.text);
#endif
#if 0
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    if ([self.historyNotes isEqualToString:@"No operation is done!"]) {
        self.historyNotes = @"";
    }
    self.historyNotes = [self.historyNotes stringByAppendingFormat:@"%@\n",self.resultLabel.text];
    self.modeControl.enabled = NO;
#endif
}

- (void)updateUI
{
    NSLog(@"12");
    for (UIButton *cardButton in self.cardssButtons) {
        NSUInteger cardButtonIndex = [self.cardssButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        NSLog(@"13");
        if (cardButton.enabled == YES) {
            NSLog(@"19");
            [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
            NSLog(@"btntitle = %@", [[self titleForCard:card] string]);
            [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
#if 0
    self.resultLabel.text = self.game.result;
#endif
    [self.resultLabel setAttributedText: self.game.result];
    [self.resultLabel.text stringByAppendingString:@"dsfdsfdsftest"];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    if(card.gameMode == 0)
    {
        return card.isChosen ? ([[NSAttributedString alloc]initWithString:card.contents attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} ]) : ([[NSAttributedString alloc] initWithString:@""]);
    }else{
        return card.isChosen ? (NSAttributedString *)card.contents : ([[NSAttributedString alloc] initWithString:@""]);
    }
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)RestartGameButton:(UIButton *)sender
{
    self.game = nil;
    self.deck = nil;
    for (UIButton *cardButton in self.cardssButtons) {
        [cardButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@""] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.resultLabel.text = @"Game restarts.";
    self.historyNotes = [[NSMutableAttributedString alloc] initWithString:@"No operation is done!"];
    self.modeControl.enabled = YES;
}

- (IBAction)MatchModeControl:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0) {
        self.game.mode = 0;
    }else {
        self.game.mode = 1;
    }
}


@end
