//
//  ViewController.m
//  minigame
//
//  Created by Christoph Jerolimov on 09.01.2013.
//  Copyright (c) 2013 buenocode. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController {
	CADisplayLink *_displayLink;
	CGFloat windowWidth;
	CGFloat marginTop;
	CGFloat marginLeft;
	CGFloat marginRight;
	CGFloat padding;
	CGFloat boxWidth;
	CGFloat boxHeight;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(runGameLoop:)];
	_displayLink.paused = YES;
	//_displayLink.frameInterval = 0;
	[_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
	

	[UIApplication sharedApplication].statusBarHidden = YES;
	
	// TODO bessere variante ?
	int rowCount = 5;
	int boxCount = 10;
	
	windowWidth = self.view.frame.size.height;
	marginTop = 10;
	marginLeft = 10;
	marginRight = 10;
	padding = 10;
	boxWidth = (windowWidth - marginLeft - marginRight - padding * (boxCount - 1)) / boxCount;
	boxHeight = 20;
	
	
	for (int row = 0; row < rowCount; row++) {
		for (int column = 0; column < boxCount; column++) {
			Block* block = [[Block alloc] init];
			block.frame = CGRectMake(
									 marginLeft + boxWidth * column + padding * column,
									 marginTop + boxHeight * row + padding * row,
									 boxWidth,
									 boxHeight);
			[self.blocks addSubview:block];
		}
	}
	
	
}

- (void)viewWillDisappear:(BOOL)animated {

}

- (IBAction)ballTapped:(UITapGestureRecognizer *)sender {
	_displayLink.paused = NO;
	[self.ball start];
}

- (IBAction)handlerMoved:(UIPanGestureRecognizer *)sender {
	static CGPoint initialCenter;
	
    if (sender.state == UIGestureRecognizerStateBegan) {
        initialCenter = sender.view.center;
    }
	
	if (sender.state == UIGestureRecognizerStateEnded) {
		CGPoint p = [sender velocityInView:sender.view];
		[UIView animateWithDuration:1 animations:^{
			// TODO
		}];
		return;
	}
	
	CGPoint moved = [sender translationInView:sender.view];
	CGFloat x = initialCenter.x + moved.x;
	CGFloat y = initialCenter.y;
	if (x < sender.view.frame.size.width / 2) {
		x = sender.view.frame.size.width / 2;
	} else if (x > windowWidth - sender.view.frame.size.width / 2) {
		x = windowWidth - sender.view.frame.size.width / 2;
	}
    sender.view.center = CGPointMake(x, y);
}

- (IBAction)stopGame:(UITapGestureRecognizer *)sender {
	[self.ball stop];
}

- (void)runGameLoop:(CADisplayLink *)displayLink {
	[self.ball ballMoving:displayLink];
	if ([self.handler checkCollision:self.ball]) {
		[self.ball inverseY];
	}
}


@end
