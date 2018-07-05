//
//  User.h
//  twitter
//
//  Created by Rucha Patki on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

// MARK: Properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *profileImageURL;
@property (strong, nonatomic) NSString *backgroundImageURL;
@property (strong, nonatomic) NSNumber *numberFollowers;
@property (strong, nonatomic) NSNumber *numberFollowing;
@property (strong, nonatomic) NSNumber *numberTweets;

//initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
