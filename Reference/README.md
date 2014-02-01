# UIKit Storyboard segue reference

## Description

These files are the headers and an incomplete reimplementations of segues from UIKit. 
They were obtained by reverse-engineering UIKit from the iOS SDK 7.0.
They are here for reference only.

## Architecture

Segues are implemented with a factory pattern:

1. segue templates are created (by storyboard) and attached to UIViewControllers
2. segues are created by shouldPerformSegueWithIdentifier:sender: (programmatically or with storyboard)


### Segue templates

- UIStoryboardSegueTemplate
- UIStoryboardPushSegueTemplate
- UIStoryboardReplaceSegueTemplate
- UIStoryboardModalSegueTemplate
- UIStoryboardPopoverSegueTemplate
- UIStoryboardEmbedSegueTemplate
- UIStoryboardUnwindSegueTemplate

### Segues

- UIStoryboardSegue
- UIStoryboardPushSegue
- UIStoryboardReplaceSegue
- UIStoryboardModalSegue
- UIStoryboardPopoverSegue
- UIStoryboardEmbedSegue
- // missing: UIStoryboardUnwindSegue (is not a real segue)