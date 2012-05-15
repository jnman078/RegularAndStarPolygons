//
//  C4WorkSpace.m
//  RegularAndStarPolygons
//
//  Created by Jordan Peterson on 12-05-08.
//  Copyright (c) 2012 ACAD. All rights reserved.
//

#import "C4WorkSpace.h"

@implementation C4WorkSpace {
    int canvasWidth, canvasHeight;
    CGPoint centerPos, ourPolyPos;
    C4Shape *ourPoly;
    int points;
    float cRad, iRad, rad;
    float sagitta;
}

-(void)setup {
    canvasWidth = self.canvas.bounds.size.width;
    canvasHeight = self.canvas.bounds.size.height;
    centerPos = CGPointMake(canvasWidth/2, canvasHeight/2);
    
    points = 5;
    cRad = 150.0f;
    ourPolyPos = CGPointMake(centerPos.x, centerPos.y - 20.0f);
    iRad = cRad - cRad/(2 * [C4Math cos:PI/5.0f]);
    sagitta = 2 * cRad * [C4Math square:[C4Math sin:PI/(2*points)]];
    
    //For Regular Polygons
    CGPoint ourPolyPoints[points+1];
    if (points >= 3) {
        for (int i = 0; i <= points; i++) {
            float theta = TWO_PI * i/points;
            ourPolyPoints[i].x = cRad * [C4Math cos:theta] + ourPolyPos.x;
            ourPolyPoints[i].y = cRad * [C4Math sin:theta] + ourPolyPos.y;
        }
    }
    ourPoly = [C4Shape polygon:ourPolyPoints pointCount:points+1];
    [self.canvas addShape:ourPoly];
    
    //For Star Polygons
//    CGPoint ourPolyPoints[2*points];
//    if (points >= 3) {
//        for (int i = 0; i <= 2*points; i++) {
//            float theta = TWO_PI * i/(2*points);
//            rad = (i % 2 == 1) ? iRad : cRad;
//            ourPolyPoints[i].x = rad * [C4Math cos:theta] + ourPolyPos.x;
//            ourPolyPoints[i].y = rad * [C4Math sin:theta] + ourPolyPos.y;
//        }
//    }
//    ourPoly = [C4Shape polygon:ourPolyPoints pointCount:2*points+1];
//    [self.canvas addShape:ourPoly];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // These line of code will work regardless of whether your shape is a regular polygon or a star polygon.
    ourPoly.animationDuration = 0.50f;
    ourPoly.animationOptions = LINEAR | REPEAT;
    if (points % 2 == 1) {
        ourPoly.layer.anchorPoint = CGPointMake([C4Math map:(ourPoly.bounds.size.width - sagitta)/2.0f 
                                                    fromMin:0.0f max:ourPoly.bounds.size.width 
                                                      toMin:0.0f max:1.0f], 0.5f);
    }
    ourPoly.transform = CGAffineTransformMakeRotation(TWO_PI/points);
}

@end
