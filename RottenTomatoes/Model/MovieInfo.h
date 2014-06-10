//
//  MovieInfo.h
//  RottenTomatoes
//
//  Created by Pierpaolo Baccichet on 6/7/14.
//  Copyright (c) 2014 Pierpaolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInfo : NSObject

- (MovieInfo *)initWithTitle:(NSString *)title synopsis:(NSString *)synopsis posterURL:(NSString *)posterURL thumbnailURL:(NSString *)thumbnailURL;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *posterURL;
@property (nonatomic, strong) NSString *thumbnailURL;

@end
