//
//  MovieDetailsViewController.m
//  RottenTomatoes
//
//  Created by Pierpaolo Baccichet on 6/8/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Step 1 load the poster
    self.navigationItem.title = self.movieInfo.title;

    // First load the low res then download the full res image
    self.posterView.image = self.thumbnail;
    NSURL *url = [NSURL URLWithString:self.movieInfo.posterURL];
    [self.posterView setImageWithURL:url];

    self.titleLabel.text = self.movieInfo.title;
    [self.titleLabel sizeToFit];

    self.synopsisLabel.text = self.movieInfo.synopsis;
    // Move the synopsis label down a bit to accomodate for potential line wraps in the title
    self.synopsisLabel.frame = CGRectMake(5, 5 + self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, 310, 10);
    [self.synopsisLabel sizeToFit];

    CGRect newBackgroundViewFrame = self.innerView.frame;
    newBackgroundViewFrame.size.height = self.synopsisLabel.frame.origin.y + self.synopsisLabel.frame.size.height + 220;
    self.innerView.frame = newBackgroundViewFrame;

    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.innerView.frame.origin.y + self.innerView.frame.size.height - 180)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
