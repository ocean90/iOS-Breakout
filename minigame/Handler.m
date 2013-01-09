//
//  Handler.m
//  minigame
//
//  Created by Christoph Jerolimov on 09.01.2013.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import "Handler.h"

@implementation Handler

- (BOOL)checkCollision:(Ball *)ball {
	CGRect ballRect = ball.frame;
	CGRect handlerRect = self.frame;
	
	
	if ( CGRectGetMinX(ballRect) < CGRectGetMinX(handlerRect))
		return NO;
	
	if ( CGRectGetMaxX(ballRect) > CGRectGetMaxX(handlerRect))
		return NO;
	
	return CGRectGetMaxY(ballRect) > CGRectGetMinY(handlerRect);
}


@end
