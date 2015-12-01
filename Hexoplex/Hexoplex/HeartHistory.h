//
//  HeartHistory.h
//  Hexoplex
//
//  Created by Paul Skorski on 11/17/15.
//  Copyright © 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

#ifndef HeartHistory_h
#define HeartHistory_h


#endif /* HeartHistory_h */

#import "BEMSimpleLineGraphView.h"

@interface HeartHistory : UIViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;


@property (strong, nonatomic) NSMutableArray *arrayOfValues;
@property (strong, nonatomic) NSMutableArray *arrayOfDates;

@property (strong, nonatomic) IBOutlet UILabel *labelValues;
@property (strong, nonatomic) IBOutlet UILabel *labelDates;

@property (weak, nonatomic) IBOutlet UISegmentedControl *graphColorChoice;
@property (strong, nonatomic) IBOutlet UISegmentedControl *curveChoice;
@property (weak, nonatomic) IBOutlet UIStepper *graphObjectIncrement;


@end