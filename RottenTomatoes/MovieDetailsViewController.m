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

    if (self.movieInfo.poster != nil)
    {
        // using the cached version of the poster
        self.posterView.image = self.movieInfo.poster;
    }
    else
    {
        // First load the low res then download the full res image
        self.posterView.image = self.movieInfo.thumbnail;
        NSURL *url = [NSURL URLWithString:self.movieInfo.posterURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        __weak MovieDetailsViewController *weakSelf = self;
        [self.posterView setImageWithURLRequest:request
                               placeholderImage:nil
            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
            {
                weakSelf.posterView.image = image;
                // cache the poster so we can reuse it later
                weakSelf.movieInfo.poster = image;
            }
            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
            {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:[NSString stringWithFormat:@"Error fetching poster for %@", self.movieInfo.title]
                                          message:[error localizedDescription]
                                          delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
                [alertView show];
            }];
    }

    int labelMargin = 5;
    int innerViewOffset = 240;
    float currYPosition = 0;
    int labelWidth = self.scrollView.frame.size.width - 2 * labelMargin;
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(0, innerViewOffset, self.scrollView.frame.size.width, self.scrollView.frame.size.height - innerViewOffset)];
    innerView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7f];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelMargin, labelMargin, labelWidth, 10)];
    titleLabel.text = self.movieInfo.title;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [titleLabel sizeToFit];
    [innerView addSubview:titleLabel];
    currYPosition += labelMargin + titleLabel.frame.size.height;

    UILabel *synopsisLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelMargin, currYPosition + labelMargin, labelWidth, 10)];
    synopsisLabel.text = self.movieInfo.synopsis;
    synopsisLabel.numberOfLines = 0;
    synopsisLabel.textColor = [UIColor whiteColor];
    synopsisLabel.font = [UIFont systemFontOfSize:14];
    [synopsisLabel sizeToFit];
    [innerView addSubview:synopsisLabel];
    currYPosition += labelMargin + synopsisLabel.frame.size.height;

    [self.scrollView addSubview:innerView];

    float viewportHeight = self.view.frame.size.height - self.navigationController.toolbar.frame.size.height - self.navigationController.navigationBar.frame.size.height;
    [self.scrollView setContentSize: CGSizeMake(self.view.frame.size.width, viewportHeight)];

    NSLog(@"scrollview size %f total label size %f", viewportHeight, currYPosition);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
