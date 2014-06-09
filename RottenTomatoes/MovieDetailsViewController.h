//
//  MovieDetailsViewController.h
//  RottenTomatoes
//
//  Created by Pierpaolo Baccichet on 6/8/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieInfo.h"

@interface MovieDetailsViewController : UIViewController

// expose the movieInfo as a property so the parent view controller can pass in the data
@property MovieInfo *movieInfo;

@end
