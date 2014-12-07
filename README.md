![ModalityLogo](/../github-media/media/logo.png?raw=true)

Modality is a transitions library to present modal views and includes some cool transition effects.

##Example

![Modality](/../github-media/media/modality.gif?raw=true)

The ModalityExample project contains the source code for the example.

##Getting started

Modality is available on [CocoaPods](http://cocoapods.org).

```ruby
pod 'Modality', '~> 0.0.1'
```

##Usage

To start a transition, first import a transition animator. Modality currently has the following:

* `MODTransitionAnimatorSlideModal`
* `MODTransitionAnimatorFlipModal`
* `MODTransitionAnimatorFade`
* `MODTransitionAnimatorMask`
* `MODTransitionAnimatorCarryOver`

Then, for example, import:

```obj-c
#import <Modality/MODTransitionAnimatorSlideModal.h>
```

Each animator will import the required headers to configure the transition.

###Creating the transition animator

Create the transition animator using its factory method:

```obj-c
MODTransitionAnimatorSlideModal *animator = [MODTransitionAnimatorSlideModal transitionAnimatorWithDirection:MODDirectionBottom destinationViewLength:200];
```

###Setting up the transition

If you are presenting the view controller manually, do the following (this is a category method for UIViewController):

```obj-c
[self MOD_presentViewController:modalController withTransitionAnimator:animator duration:MODDefaulTransitionDuration completion:nil];
```

Else, if you are presenting through the Storyboard, do the following:

```obj-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
...
UIViewController *destinationController = segue.destinationViewController;
[destinationController MOD_animateWithTransitionAnimator:animator duration:MODDefaulTransitionDuration];
```

##Author

Comments and suggestions much welcome

Kevin Wong, [@kevinwl02](https://twitter.com/kevinwl02)

##License

Code distributed under the [MIT license](LICENSE)