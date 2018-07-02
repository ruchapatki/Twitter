//
//  TweetCell.m
//  twitter
//
//  Created by Rucha Patki on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

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
    
//    NSString *fullImageURLString = self.tweet.imageURL;
//
//    NSURL *url = [NSURL URLWithString:fullImageURLString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    [self.userImage setImageWithURLRequest: request placeholderImage:nil success:^(NSURLRequest * imageRequest, NSHTTPURLResponse *  imageResponse, UIImage * image) {
//        //success
//        self.userImage.image = image;
//    } failure:^(NSURLRequest * request, NSHTTPURLResponse * response, NSError * error) {
//        //error
//    }];
}

@end
