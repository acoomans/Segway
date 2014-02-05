//
//  UIViewController+SegueUserInfo.h
//  Segway
//
//  Created by Arnaud Coomans on 05/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import <UIKit/UIKit.h>


// informal protocol (ie no implementation)

@interface UIViewController (SegueUserInfo)

/** Notifies the view controller that a segue is about to be performed and pass it a user information dictionary.
 * @param segue The segue object containing information about the view controllers involved in the segue.
 * @param sender The object that initiated the segue. You might use this parameter to perform different actions based on which control (or other object) initiated the segue.
 * @param userInfo The user information dictionary stores any additional objects that source view controller may use during prepareForSegue:sender:.
 * @discussion There is no default implementation. Your view controller implements this method when it needs to pass relevant data to the new view controller. The segue object describes the transition and includes references to both view controllers involved in the segue.
 *
 * Because segues can be triggered from multiple sources, you can use the information in the segue and sender parameters to disambiguate between different logical paths in your app. For example, if the segue originated from a table view, the sender parameter would identify the table view cell that the user tapped. You can also use the user information dictionary to supply additional information. You could use that information to set the data on the destination view controller.
 *
 * **Note**: This method is only called when performSegueWithIdentifier:sender:userInfo: is called to initiate a ACStoryboardSegue (i.e. a segue defined programmatically), but not for a UIStoryboardSegue (i.e., it will not be called for segues defined in a storyboard).
 */
- (void)prepareForSegue:(ACStoryboardSegue *)segue sender:(id)sender userInfo:(NSDictionary*)userInfo;

@end
