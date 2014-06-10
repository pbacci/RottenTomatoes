//
//  MovieInfo.m
//  RottenTomatoes
//
//  Created by Pierpaolo Baccichet on 6/7/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import "MovieInfo.h"

@implementation MovieInfo

- (MovieInfo *)initWithMovieData:(NSDictionary *)movieData
{
    MovieInfo *movieInfo = [[MovieInfo alloc] init];
    movieInfo.title = movieData[@"title"];
    movieInfo.synopsis = movieData[@"synopsis"];
    movieInfo.posterURL = movieData[@"posters"][@"original"];
    movieInfo.thumbnailURL = movieData[@"posters"][@"profile"];
    return movieInfo;
}

@end
