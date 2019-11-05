//
//  QKScanViewController.h
//  Quikkly
//
//  Created by Julian Gruber on 15/03/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class QKScanView;
@class QKScannable;

NS_SWIFT_UNAVAILABLE("Use ScanViewController instead")
@interface QKScanViewController : UIViewController

//@property (nonatomic, strong, readonly) QKScanView *scanView;
@property (nonatomic, strong, readonly) UILabel *statusLabel;

- (IBAction)showActivityIndicator;
- (IBAction)hideActivityIndicator;
- (IBAction)dismissVC;

#pragma mark - QKScanViewDelegate

- (void)scanView:(QKScanView *)scanView didDetectScannables:(NSArray<QKScannable *> *)scannables;
- (BOOL)scanViewDidRequestCameraWithStatus:(AVAuthorizationStatus)status;

@end
