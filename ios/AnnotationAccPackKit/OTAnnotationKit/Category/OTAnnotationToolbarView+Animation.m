//
//  OTAnnotationToolbarView+Animation.m
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

#import "OTAnnotationToolbarView+Animation.h"
#import "OTAnnotationToolbarView_UserInterfaces.h"
#import "Constants.h"

@implementation OTAnnotationToolbarView (Animation)

- (void)moveSelectionShadowViewTo:(UIButton *)sender {

    if (![sender isKindOfClass:[UIButton class]]) {
        [self.selectionShadowView removeFromSuperview];
        return;
    }
    
    [self setUserInteractionEnabled:NO];
    CGRect holderViewFrame = sender.superview.frame;
    CGRect hodlerViewBounds = sender.superview.bounds;
    self.selectionShadowView.frame = CGRectMake(holderViewFrame.origin.x, holderViewFrame.origin.y, CGRectGetWidth(hodlerViewBounds), CGRectGetHeight(hodlerViewBounds));
    [self insertSubview:self.selectionShadowView atIndex:0];
    [self setUserInteractionEnabled:YES];
}

- (void)showColorPickerView {
    
    if (!self.colorPickerView.superview) {
        CGRect selfFrame = self.frame;
        self.colorPickerView.frame = selfFrame;
        [self.superview insertSubview:self.colorPickerView belowSubview:self];
        
        MAKE_WEAK(self);
        [UIView animateWithDuration:1.0 animations:^(){
            MAKE_STRONG(self);
            
            if (strongself.toolbarViewOrientation == OTAnnotationToolbarViewOrientationPortraitlBottom) {
                CGFloat newY = selfFrame.origin.y - HeightOfColorPicker;
                strongself.colorPickerView.frame = CGRectMake(selfFrame.origin.x, newY, CGRectGetWidth(strongself.bounds), HeightOfColorPicker);
            }
            else if (strongself.toolbarViewOrientation == OTAnnotationToolbarViewOrientationLandscapeLeft) {
                CGFloat newX = selfFrame.origin.x + HeightOfColorPicker;
                strongself.colorPickerView.frame = CGRectMake(newX, selfFrame.origin.y, WidthOfColorPicker, CGRectGetHeight(strongself.bounds));
            }
            else if (strongself.toolbarViewOrientation == OTAnnotationToolbarViewOrientationLandscapeRight) {
                CGFloat newX = selfFrame.origin.x - HeightOfColorPicker;
                strongself.colorPickerView.frame = CGRectMake(newX, selfFrame.origin.y, WidthOfColorPicker, CGRectGetHeight(strongself.bounds));
            }
        }];
    }
    else {
        [self dismissColorPickerViewWithAnimation:NO];
    }
}

- (void)dismissColorPickerViewWithAnimation:(BOOL)animated {

    if (!animated) {
        [self.colorPickerView removeFromSuperview];
        return;
    }
    
    CGRect colorPickerViewFrame = self.colorPickerView.frame;
    MAKE_WEAK(self);
    [UIView animateWithDuration:1.0 animations:^(){
        MAKE_STRONG(self);
       
        if (strongself.toolbarViewOrientation == OTAnnotationToolbarViewOrientationPortraitlBottom) {
            CGFloat newY = colorPickerViewFrame.origin.y + HeightOfColorPicker;
            strongself.colorPickerView.frame = CGRectMake(0, newY, CGRectGetWidth(colorPickerViewFrame), HeightOfColorPicker);
        }
        else if (strongself.toolbarViewOrientation == OTAnnotationToolbarViewOrientationLandscapeLeft) {
            CGFloat newX = colorPickerViewFrame.origin.x - WidthOfColorPicker;
            strongself.colorPickerView.frame = CGRectMake(newX, 0, WidthOfColorPicker, CGRectGetHeight(colorPickerViewFrame));
        }
        else if (self.toolbarViewOrientation == OTAnnotationToolbarViewOrientationLandscapeRight) {
            CGFloat newX = colorPickerViewFrame.origin.x + WidthOfColorPicker;
            strongself.colorPickerView.frame = CGRectMake(newX, 0, WidthOfColorPicker, CGRectGetHeight(colorPickerViewFrame));
        }
    } completion:^(BOOL finished){
        MAKE_STRONG(self);
  
        [strongself.colorPickerView removeFromSuperview];
    }];
}

@end
