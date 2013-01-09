//
//  Handler.h
//  minigame
//
//  Created by Christoph Jerolimov on 09.01.2013.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"

@interface Handler : UIView

- (BOOL)checkCollision:(Ball *)ball;

@end
