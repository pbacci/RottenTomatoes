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
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    __weak MovieListCell *weakSelf = self;
    __weak MovieInfo *weakMovieInfo = movieInfo;
    [self.posterView setImageWithURLRequest:request placeholderImage:nil
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
        {
            weakSelf.posterView.image = image;
            // cache the thumb in the movieInfo so we can use it in other views
            weakMovieInfo.thumbnail = image;
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:[NSString stringWithFormat:@"Error fetching thumb for %@", movieInfo.title]
                                      message:[error localizedDescription]
                                      delegate:nil
                                      cancelButtonTitle:@"Ok"
                                      otherButtonTitles:nil];
            [alertView show];
        }];
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
