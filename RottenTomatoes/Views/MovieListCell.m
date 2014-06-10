//
//  MovieListCell.m
//  RottenTomatoes
//
//  Created by Pierpaolo Baccichet on 6/7/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import "MovieListCell.h"
#import "UIImageView+AFNetworking.h"

@interface MovieListCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation MovieListCell

- (void)setMovieInfo:(MovieInfo *)movieInfo
{
    self.titleLabel.text = movieInfo.title;
    self.synopsisLabel.text = movieInfo.synopsis;

    NSURL *url = [NSURL URLWithString:movieInfo.thumbnailURL];
    [self.posterView setImageWithURL:url];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
