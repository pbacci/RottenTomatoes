//
//  MovieListCell.h
//  RottenTomatoes
//
//  Created by Pierpaolo Baccichet on 6/7/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieInfo.h"

@interface MovieListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterView;

- (void)setMovieInfo:(MovieInfo *)movieInfo;

@end
