# Segway

Segway is an open source implementation of iOS' segues.

Segway is a library that lets you perform and unwind segues programmatically (like with UIKit), but it also allows you to *define* the segues programmatically. 
Moreover, it allows you to perform segues without *any* storyboard, by loading view controllers directly from a class and/or a Nib. Finally, Segway let you attach _user info_ to your segues, for when the sender isn't enough.

Whether you simply like the perform/prepare segue pattern; or you want to slowly get rid of that storyboard in a project you inherited, Segway gives you more flexibility in using segues programmatically.
 
[![Build Status](https://api.travis-ci.org/acoomans/Segway.png)](https://api.travis-ci.org/acoomans/PSegway.png)
[![Cocoapods](https://cocoapod-badges.herokuapp.com/v/Segway/badge.png)](http://beta.cocoapods.org/?q=on%3Aios%20name%3ASegway%2A)
[![Cocoapods](https://cocoapod-badges.herokuapp.com/p/Segway/badge.png)](http://beta.cocoapods.org/?q=on%3Aios%20name%3ASegway%2A)


## Install 

### Install with [CocoaPods](http://cocoapods.org)

Add a pod entry to your Podfile:

    pod 'Segway', '~> 0.0.1'

Install the pod(s) by running:

    pod install
    
### Install with static libary

Copy the Segway project file in your project and link your target with the static library.

### Install manually

1. clone this repository
2. import files under the _Segway_ directory in your project
3. disable arc with `-fno-objc-arc` for _UIPopoverController+SelfRetained.m_
4. set `OTHER_LINKER_FLAGS="-ObjC"` for your target

    

## Usage

First import segway:

	#import "Segway.h"

### Defining a segue programmatically

To define a segue is a two steps process:

1. Define a template, that will be responsible of creating the segue when `performSegueWithIdentifier:sender:` is called
2. Register the template with a view controller 


Templates can either point to a view controller in a storyboard, by specifying its storyboard ID:

	ACStoryboardSegueTemplate *template = [[ACStoryboardPushSegueTemplate alloc] initWithIdentifier:@"push" destinationViewControllerIdentifier:@"myViewControllerIdentifier"];

or to a view controller class and Nib:
	
    ACStoryboardSegueTemplate *template = [[ACStoryboardPushSegueTemplate alloc] initWithIdentifier:@"push" destinationViewControllerClassName:@"MyViewController" withNibName:@"MyViewController" bundle:nil];
    
Available segues are:

- ACStoryboardPushSegueTemplate
- ACStoryboardModalSegueTemplate
- ACStoryboardPopoverSegueTemplate
- ACStoryboardEmbedSegueTemplate
- ACStoryboardUnwindSegueTemplate
    
Some templates take additional parameters (e.g. presentation options for modal segue), check the documentation for details.
 
Note that it is recommended to initialize the templates in the `viewDidLoad` method (or `loadView`) as they may depend on some of the controller's views.

Then attach it to the view controller:

    [self registerSegueTemplate:template];

### Performing a segue

This is the same as UIKit's segues:

	[self performSegueWithIdentifier:@"push" sender:self];
    
If you want to pass extra information, you can use the user info:

    [self performSegueWithIdentifier:@"push" sender:self userInfo:@{@"indexPath": indexPath}];
    
You can then implement `prepareForSegue:sender:userInfo:` to access the user info:

	- (void)prepareForSegue:(ACStoryboardSegue*)segue sender:(id)sender userInfo:(NSDictionary *)userInfo {
	    ...
	}
	
Or, because `prepareForSegue:sender:` still works, you can use it as well, and access userInfo from the segue:

	- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
		NSDictionary *userInfo = segue.userInfo;
		...
	}

Note: userInfo only works for ACStoryboardSegues and unwinding UIStoryboardSegue.


### Unwinding

Like for regular segues, register a template first. The _action_ argument is a string with the name of the selector to unwind to:

	[self registerSegueTemplate:[[ACStoryboardUnwindSegueTemplate alloc] initWithIdentifier:@"unwind" action:@"unwindAction:"]];

You can then unwind with perform:

	[self performSegueWithIdentifier:@"unwind" sender:self];

Like UIkit, it will try to unwind to the first view controller that implements a method named like the one you passed as the _action_ argument:

	- (IBAction)unwindAction:(id)sender {
		...
	}

Note that, like UIKit, `prepareForSegue:identifier:` is *not* called before unwinding.


### Mixing UIkit and Segway segues

When using Segway, UIkit's segues are still working. Segway will not impact the segues defined in a storyboard:

- segues defined in a storyboard can still be performed by the storyboard
- segues defined in a storyboard can still be performed programmatically

### Subclassing

Like in UIKit, you can subclass `ACStoryboardSegue` to make your own segues.

If you segue subclass does not take any argument besides the usual _identifier_, _source_ and _destination_, you can simply use the generic `ACStoryboardSegueTemplate` and set its `segueClassName` property:

	ACStoryboardSegueTemplate *segueTemplate = [[ACStoryboardSegueTemplate alloc] initWithIdentifier:@"segueIdentifier" destinationViewControllerIdentifier:@"viewControllerB"];
    segueTemplate.segueClassName = @"MyStoryboardSegueSubclass";

If you need to give more parameters to the segue, you may need to subclass a `ACStoryboardSegueTemplate`.


## Documentation

If you have [appledoc](http://gentlebytes.com/appledoc/) installed, you can generate the documentation by running the corresponding target.

## Demo

Two demo apps are available:

- SegwayDemo let you try every Segway's segues
- SegwayDemoWithoutStoryboard let you push a simple view controller and works without any storyboard at all

## Bugs and limitations

Given the complexity of reverse-engineering UIKit and its numerous of (subtle) private functions, there are some aspects that weren't implemented or aren't working correctly:

- unwinding from popover does not work.
- no support for the iPad's split view controller, more specifically:
	- the _replace_ segue is not implemented.
	- performing *any* other segue in a split view controller is not implemented.
- storyboards cannot perform segues defined programmatically with Segway. You need to call them programmatically.
- user info is only for programmatically-defined ACStoryboardSegues.
