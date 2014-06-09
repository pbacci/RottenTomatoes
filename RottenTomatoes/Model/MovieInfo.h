//
//  MovieInfo.h
//  RottenTomatoes
//
//  Created by Pierpaolo Baccichet on 6/7/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInfo : NSObject

- (MovieInfo *)initWithMovieData:(NSDictionary *)movieData;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *posterURL;
@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *poster;

@end
