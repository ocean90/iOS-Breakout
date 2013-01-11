//
//  Blocks.h
//  minigame
//
//  Created by Dominik Schilling on 11.01.13.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"
#import "Block.h"

@interface Blocks : UIView

- (void) checkBlockCollisionWith:(Ball *)ball;

@end
