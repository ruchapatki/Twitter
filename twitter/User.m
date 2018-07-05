//
//  User.m
//  twitter
//
//  Created by Rucha Patki on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageURL = dictionary[@"profile_image_url"];
        self.backgroundImageURL = dictionary[@"profile_banner_url"];
        self.numberFollowers = dictionary[@"followers_count"];
        self.numberFollowing = dictionary[@"friends_count"];
        self.numberTweets = dictionary[@"statuses_count"];
        
        // Initialize any other properties
    }
    return self;
}

@end
