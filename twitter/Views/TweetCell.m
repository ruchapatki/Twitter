//
//  TweetCell.m
//  twitter
//
//  Created by Rucha Patki on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void) setTweet:(Tweet *)tweet{
    _tweet = tweet;
    
    self.tweetLabel.text = self.tweet.text;
    self.authorLabel.text = self.tweet.user.name;
    NSString *atSign = @"@";
    self.screenName.text = [atSign stringByAppendingString:self.tweet.screenName];
    self.timestamp.text = self.tweet.createdAtString;
    self.retweetCount.text = [NSString stringWithFormat:@"%i",self.tweet.retweetCount];
    self.favCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    
    if(self.tweet.retweeted == YES){
        self.retweetButton.imageView.image = [UIImage imageNamed: @"retweet-icon-green"];
    }
    else{
        self.retweetButton.imageView.image = [UIImage imageNamed: @"retween-icon"];
    }
    
    if(self.tweet.favorited == YES){
        self.favButton.imageView.image = [UIImage imageNamed: @"favor-icon-red"];
    }
    else{
        self.favButton.imageView.image = [UIImage imageNamed:@"favor-icon"];
    }
    
    NSString *fullImageURLString = self.tweet.imageURL;

    NSURL *url = [NSURL URLWithString:fullImageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [self.userImage setImageWithURLRequest: request placeholderImage:nil success:^(NSURLRequest * imageRequest, NSHTTPURLResponse *  imageResponse, UIImage * image) {
        //success
        self.userImage.image = image;
    } failure:^(NSURLRequest * request, NSHTTPURLResponse * response, NSError * error) {
        NSLog(@"Error: %@", error);
    }];
}


- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    //update UI --> TODO: make a refreshData() method!!!!!!!
    [self setTweet:self.tweet];
    
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    
    [self setTweet:self.tweet];
    
    
}

@end
