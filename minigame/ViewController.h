//
//  ViewController.h
//  minigame
//
//  Created by Christoph Jerolimov on 09.01.2013.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Block.h"
#import "Ball.h"
#import "Handler.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet Block *blocks;
@property (weak, nonatomic) IBOutlet Ball *ball;
@property (weak, nonatomic) IBOutlet Handler *handler;
@property (weak, nonatomic) IBOutlet UILabel *points;

- (IBAction)ballTapped:(UITapGestureRecognizer *)sender;
- (IBAction)handlerMoved:(UIPanGestureRecognizer *)sender;
- (IBAction)stopGame:(UITapGestureRecognizer *)sender;

@end
