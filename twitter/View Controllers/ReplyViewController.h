//
//  ReplyViewController.h
//  twitter
//
//  Created by Rucha Patki on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@protocol ReplyViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end


@interface ReplyViewController : UIViewController

@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, weak) id<ReplyViewControllerDelegate> delegate;

@end
