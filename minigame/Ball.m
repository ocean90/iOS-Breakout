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
	CGPoint _startPoint;
	CADisplayLink *_displayLink;
	CGFloat _velocityX;
	CGFloat _velocityY;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.layer.cornerRadius = 10;
		
		_startPoint = self.center;
		
		_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(ballMoving:)];
		_displayLink.paused = YES;
		[_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
		_displayLink.frameInterval = 5;
		
		// We want only a 45 grad left and right
		double startDirection = (arc4random() % 90) + 45;
		startDirection = startDirection * 3.14 / 180;
		
		NSLog(@"start = %f", startDirection);
		NSLog(@"x = sin %lf", cos(startDirection));
		NSLog(@"y = cos %lf", sin(startDirection));
		
		_velocityX = cos(startDirection) * 40.0;
		_velocityY = sin(startDirection) * 40.0;
		
		NSLog(@"init velocity: %f %f", _velocityX, _velocityY);
	}
	
	return self;
}

-(void)ballMoving:(CADisplayLink *)displayLink {
	CGFloat x = self.center.x + _velocityX * displayLink.duration * displayLink.frameInterval;
	CGFloat y = self.center.y - _velocityY * displayLink.duration * displayLink.frameInterval;
	
	CGRect ballRect = self.frame;
	CGRect boxRect = self.superview.bounds;
	
	if (CGRectGetMinX(ballRect) < CGRectGetMinX(boxRect)) {
		_velocityX = -_velocityX;
	}
	if (CGRectGetMaxX(ballRect) > CGRectGetMaxX(boxRect)) {
		_velocityX = -_velocityX;
	}
	if (CGRectGetMinY(ballRect) < CGRectGetMinY(boxRect)) {
		_velocityY = -_velocityY;
	}
	if (CGRectGetMaxY(ballRect) < CGRectGetMaxY(boxRect)) {
		_velocityY = -_velocityY;
	}
	
	self.center = CGPointMake(x, y);
}
		
		

- (void) start {
	NSLog(@"Start game");
	_displayLink.paused = NO;
}

- (void) pause {
	NSLog(@"Pause game");
	_displayLink.paused = YES;
//	[_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void) stop {
	[self pause];
	NSLog(@"Stop game");
	self.center = _startPoint;
}

@end
