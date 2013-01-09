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
	CGFloat x = self.center.x - 2;
	CGFloat y = self.center.y + 2;
	

	CGRect rect1 = self.frame;
	CGRect rect2 = self.superview.bounds;

	if ( [self checkTopCollisionOf:rect1 in:rect2] ) {
		NSLog(@"Top Collision");
		[self stop];
	};

	if ( [self checkBottomCollisionOf:rect1 in:rect2] ) {
		NSLog(@"Bottom Collision");
		[self stop];
	};

	if ( [self checkLeftCollisionOf:rect1 in:rect2] ) {
		NSLog(@"Left Collision");
		[self stop];
	};

	if ( [self checkRightCollisionOf:rect1 in:rect2] ) {
		NSLog(@"Right Collision");
		[self stop];
	};

	/*if ( ! CGRectIntersectsRect( self.superview.bounds, self.frame ) ) {
		NSLog(@"Intersection: %@", NSStringFromCGRect( CGRectIntersection( self.superview.bounds, self.frame ) ));
		[self stop];
	}*/

	self.center = CGPointMake(x, y);
}

- (BOOL) checkTopCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMinY(rect1);
	CGFloat point2 = CGRectGetMinY(rect2);
	NSLog(@"%f - %f", point1, point2);

	return point2 >= point1;
}

- (BOOL) checkBottomCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMaxY(rect1);
	CGFloat point2 = CGRectGetMaxY(rect2);
	NSLog(@"%f - %f", point1, point2);

	return point2 <= point1;
}

- (BOOL) checkRightCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMaxX(rect1);
	CGFloat point2 = CGRectGetMaxX(rect2);

	NSLog(@"%f - %f", point1, point2);

	return point2 <= point1;
}

- (BOOL) checkLeftCollisionOf:(CGRect)rect1 in:(CGRect)rect2 {
	CGFloat point1 = CGRectGetMinX(rect1);
	CGFloat point2 = CGRectGetMinX(rect2);

	NSLog(@"%f - %f", point1, point2);

	return point2 >= point1;
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
