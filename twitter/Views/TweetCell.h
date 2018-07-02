//
//  TweetCell.h
//  twitter
//
//  Created by Rucha Patki on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;


@property(strong, nonatomic) Tweet* tweet;
- (void)setTweet:(Tweet *)tweet;

@end
