//
//  LungHistory.h
//  Hexoplex
//
//  Created by Paul Skorski on 11/27/15.
//  Copyright © 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

#ifndef LungHistory_h
#define LungHistory_h


#endif /* LungHistory_h */

#import "BEMSimpleLineGraphView.h"

@interface LungHistory : UIViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;


@property (strong, nonatomic) NSMutableArray *arrayOfValues;
@property (strong, nonatomic) NSMutableArray *arrayOfDates;

@property (strong, nonatomic) IBOutlet UILabel *labelValues;
@property (strong, nonatomic) IBOutlet UILabel *labelDates;

@property (weak, nonatomic) IBOutlet UISegmentedControl *graphColorChoice;
@property (strong, nonatomic) IBOutlet UISegmentedControl *curveChoice;
@property (weak, nonatomic) IBOutlet UIStepper *graphObjectIncrement;


@end