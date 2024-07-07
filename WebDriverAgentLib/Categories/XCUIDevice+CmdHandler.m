//
//  XCUIDevice+CmdHandler.m
//  WebDriverAgentLib
//
//  Created by Anil Solanki on 07/07/24.
//  Copyright © 2024 Facebook. All rights reserved.
//

#import "XCUIDevice+CmdHandler.h"

#import "XCUIDevice.h"
#import "XCPointerEventPath.h"
#import "XCSynthesizedEventRecord.h"
#import "FBXCTestDaemonsProxy.h"
#import "XCTRunnerDaemonSession.h"

@implementation XCUIDevice (CmdHandler)

- (void)runEventPath:(XCPointerEventPath*)path
{
  XCSynthesizedEventRecord *event = [[XCSynthesizedEventRecord alloc]
                                     initWithName:nil
                                     interfaceOrientation:0];
  [event addPointerEventPath:path];

  [[self eventSynthesizer]
    synthesizeEvent:event
    completion:(id)^(BOOL result, NSError *invokeError) {} ];
}

- (void)cmd_tap:(CGFloat)x y:(CGFloat) y
{
  CGPoint point = CGPointMake(x,y);
  XCPointerEventPath *path = [[XCPointerEventPath alloc] initForTouchAtPoint:point offset:0];
  [path liftUpAtOffset:0.05];
  [self runEventPath:path];
}

- (void)cmd_holdHomeButtonForDuration:(CGFloat)dur
{
  [self holdHomeButtonForDuration:dur];
}

- (void)cmd_swipe:(CGFloat)x1 y1:(CGFloat) y1 x2:(CGFloat) x2 y2:(CGFloat) y2 delay:(CGFloat) delay
{
  XCPointerEventPath *path = [[XCPointerEventPath alloc]
                              initForTouchAtPoint:CGPointMake(x1,y1)
                              offset:0];
  [path moveToPoint:CGPointMake(x2,y2) atOffset:delay];
  [path liftUpAtOffset:delay];
  [self runEventPath:path];
}


@end
