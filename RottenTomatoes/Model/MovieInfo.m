//
//  MovieInfo.m
//  RottenTomatoes
//
//  Created by Pierpaolo Baccichet on 6/7/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import "MovieInfo.h"

@implementation MovieInfo

- (MovieInfo *)initWithTitle:(NSString *)title synopsis:(NSString *)synopsis posterURL:(NSString *)posterURL thumbnailURL:(NSString *)thumbnailURL
{
    MovieInfo *movieInfo = [[MovieInfo alloc] init];
    movieInfo.title = title;
    movieInfo.synopsis = synopsis;
    movieInfo.posterURL = posterURL;
    movieInfo.thumbnailURL = thumbnailURL;
    return movieInfo;
}

@end
