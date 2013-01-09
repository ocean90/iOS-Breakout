//
//  Ball.m
//  minigame
//
//  Created by Christoph Jerolimov on 09.01.2013.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import "Ball.h"
#import <QuartzCore/QuartzCore.h>


@implementation Ball {
	CADisplayLink *_displayLink;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.layer.cornerRadius = 10;
		_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(ballMoving:)];
		
	}
	
	return self;
}

-(void)ballMoving:(CADisplayLink *)displayLink {
	CGFloat x = self.center.x + 1;
	CGFloat y = self.center.y - 1;
	
	NSLog(@"Superview: %@, Self: %@", NSStringFromCGRect(self.superview.bounds), NSStringFromCGRect(self.frame));
	
	
	if ( ! CGRectIntersectsRect( self.superview.bounds, self.frame ) ) {
		NSLog(@"Intersection: %@", NSStringFromCGRect( CGRectIntersection( self.superview.bounds, self.frame ) ));
		[self stop];
	}

	self.center = CGPointMake(x, y);
}

- (void) start {
	[_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void) pause {
	[_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void) stop {
	[self pause];
	// TODO reset position
}

@end
