//
//  ViewController.m
//  Machismo
//
//  Created by 天桥雨 on 16/1/20.
//  Copyright (c) 2016年 Coolman. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeControl;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation ViewController

-(CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:self.deck];
    }
    return _game;
}

- (Deck *) deck{
    if (!_deck) {
        _deck = [self creatDeck];
    }
    return _deck;
}

- (Deck *)creatDeck{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)TouchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
#if 1
    self.resultLabel.text = [NSString stringWithFormat:@"%@",[self.game cardAtIndex:chosenButtonIndex].contents] ;
#endif
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
    self.modeControl.enabled = NO;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        if (cardButton.enabled == YES) {
            [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.resultLabel.text = self.game.result;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)RestartGameButton:(UIButton *)sender
{
    self.game = nil;
    self.deck = nil;
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.resultLabel.text = @"Game restarts.";
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
