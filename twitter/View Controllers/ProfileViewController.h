//
//  ProfileViewController.h
//  twitter
//
//  Created by Rucha Patki on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TweetCell.h"

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) User *user;
//@property (nonatomic, weak) id<TweetCellDelegate> delegate;

@end
