//
//  MovieListViewController.m
//  RottenTomatoes
//
//  Created by Pierpaolo Baccichet on 6/7/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import "AFNetworking.h"
#import "MBProgressHUD.h"

#import "MovieListViewController.h"
#import "MovieDetailsViewController.h"
#import "MovieListCell.h"
#import "MovieInfo.h"

@interface MovieListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movieList;
@property (strong, nonatomic) UIView *networkWarningView;

- (void)refreshMovieList:(id)sender;

// RottenTomatoes API has been rotten all saturday so creating a helper function to get unstuck
- (void)fallbackReadingDataFromBundle;

@end

@implementation MovieListViewController

static NSString *API_KEY = @"thxbu6vp3bhw3pt7gznpuy7y";
static NSString *BASE_URL = @"http://api.rottentomatoes.com/api/public/v1.0";
static NSString *MOVIES_LIST_ENDPOINT = @"/lists/dvds/top_rentals.json";

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
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 120;
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieListCell" bundle:nil] forCellReuseIdentifier:@"MovieListCell"];

    self.navigationItem.title = @"Movies";

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshMovieList:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.tableView.delegate = self;

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self refreshMovieList:nil];

    int warningOffset = 60;
    self.networkWarningView = [[UIView alloc] initWithFrame:CGRectMake(0, warningOffset, 320, 40)];
    self.networkWarningView.backgroundColor = [UIColor redColor];
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    warningLabel.text = @"Network issue!";
    [warningLabel setTextAlignment:NSTextAlignmentCenter];
    warningLabel.font = [UIFont systemFontOfSize:20];
    [self.networkWarningView addSubview:warningLabel];
    [self.view addSubview:self.networkWarningView];
    self.networkWarningView.hidden = true;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailsViewController *mdvc = [[MovieDetailsViewController alloc] init];
    mdvc.movieInfo = self.movieList[indexPath.row];
    MovieListCell *vc = (MovieListCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    mdvc.thumbnail = vc.posterView.image;
    [self.navigationController pushViewController:mdvc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieListCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieListCell"];
    [movieCell setMovieInfo:self.movieList[indexPath.row]];
    return movieCell;
}

- (void)refreshMovieList:(id)sender
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@?apikey=%@", BASE_URL, MOVIES_LIST_ENDPOINT, API_KEY];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    // helper to cleanup the refresh state
    void (^cleanup_refresh_state)(void) = ^{
        [(UIRefreshControl *)sender endRefreshing];
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    };

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.networkWarningView.hidden = true;
        // Convert the information received in an array of MovieInfo
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        for (NSDictionary *movieDict in responseObject[@"movies"])
        {
            MovieInfo *movieInfo = [[MovieInfo alloc] initWithMovieData:movieDict];
            [tmpArray addObject:movieInfo];
        }
        self.movieList = tmpArray;
        cleanup_refresh_state();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.networkWarningView.hidden = false;
        // this sucks but has been happening frequently so read some data from a file
        [self fallbackReadingDataFromBundle];
        cleanup_refresh_state();
    }];

    [operation start];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fallbackReadingDataFromBundle
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dummy_data" ofType:@"json"];
    NSString *myJSONstring = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];

    NSData *data = [myJSONstring dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    // Convert the information received in an array of MovieInfo
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for (NSDictionary *movieDict in [json objectForKey:@"movies"])
    {
        MovieInfo *movieInfo = [[MovieInfo alloc] initWithMovieData:movieDict];
        [tmpArray addObject:movieInfo];
    }
    self.movieList = tmpArray;
}

@end
