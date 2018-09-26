// Generated by Apple Swift version 4.2 (swiftlang-1000.11.37.1 clang-1000.11.45.1)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import AVFoundation;
@import CoreGraphics;
@import Dispatch;
@import ObjectiveC;
@import UIKit;
@import WebKit;
#endif

#import <Quikkly/Quikkly.h>

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="Quikkly",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

@class QKUser;

SWIFT_CLASS_NAMED("Quikkly")
@interface QKQuikkly : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, copy) NSString * _Nullable apiKey;)
+ (NSString * _Nullable)apiKey SWIFT_WARN_UNUSED_RESULT;
+ (void)setApiKey:(NSString * _Nullable)newValue;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, copy) NSString * _Nullable blueprintFilename;)
+ (NSString * _Nullable)blueprintFilename SWIFT_WARN_UNUSED_RESULT;
+ (void)setBlueprintFilename:(NSString * _Nullable)value;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, strong) QKUser * _Nullable user;)
+ (QKUser * _Nullable)user SWIFT_WARN_UNUSED_RESULT;
+ (void)setUser:(QKUser * _Nullable)value;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS_NAMED("User")
@interface QKUser : NSObject
/// String must be of “yyyy-MM-dd” format
@property (nonatomic, copy) NSString * _Nullable dob;
@property (nonatomic, copy) NSString * _Nullable gender;
@property (nonatomic) NSInteger identifier;
- (nonnull instancetype)initWithId:(NSInteger)identifier gender:(NSString * _Nullable)gender dob:(NSString * _Nullable)dob OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end

@protocol QKScanViewDelegate;
@class NSCoder;

/// The ScanView class displays a camera feed and detects Scannable codes.
SWIFT_CLASS_NAMED("ScanView")
@interface QKScanView : UIView
@property (nonatomic, weak) id <QKScanViewDelegate> _Nullable delegate;
@property (nonatomic) CGRect frame;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)start;
- (void)stop;
- (IBAction)permissionsDeniedButtonPressed;
- (void)layoutSubviews;
@end

@class QKScannable;

/// ScanViewDelegate for handling detection events.
SWIFT_PROTOCOL_NAMED("ScanViewDelegate")
@protocol QKScanViewDelegate
@optional
- (void)scanView:(QKScanView * _Nonnull)scanView didDetectScannables:(NSArray<QKScannable *> * _Nonnull)scannables;
/// Notifies about the result of the requested camera permission.
/// \param status The image to scan for scannables
///
///
/// returns:
/// whether the scanview should display a default hint for the user.
- (BOOL)scanViewDidRequestCameraWithStatus:(AVAuthorizationStatus)status SWIFT_WARN_UNUSED_RESULT;
@end

@class NSBundle;

/// The ScanViewController class wraps a ScanView object and provides a default scanning experience.
SWIFT_CLASS("_TtC7Quikkly18ScanViewController")
@interface ScanViewController : UIViewController <QKScanViewDelegate>
@property (nonatomic, readonly) UIInterfaceOrientation preferredInterfaceOrientationForPresentation;
@property (nonatomic, readonly) UIInterfaceOrientationMask supportedInterfaceOrientations;
@property (nonatomic, readonly) UIStatusBarStyle preferredStatusBarStyle;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)viewDidLayoutSubviews;
- (IBAction)showActivityIndicator;
- (IBAction)hideActivityIndicator;
- (BOOL)scanViewDidRequestCameraWithStatus:(AVAuthorizationStatus)status SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil SWIFT_UNAVAILABLE;
@end


@class QKScannableSkin;

/// Scannable class representing a smart Quikkly scannable code.
SWIFT_CLASS_NAMED("Scannable")
@interface QKScannable : NSObject
@property (nonatomic, readonly) uint64_t value;
@property (nonatomic, copy, getter=template, setter=setTemplate:) NSString * _Nonnull template_;
@property (nonatomic, strong) QKScannableSkin * _Nonnull skin;
@property (nonatomic, readonly, copy) NSArray<NSValue *> * _Nonnull corners;
/// An SVG representation of the scannable object
@property (nonatomic, readonly, copy) NSString * _Nullable svgString;
/// Retrieves data linked to the scannable on the Quikkly back-end
/// \param completion contains a dictionary of the linked data or nil if not available
///
- (void)getMappedData:(void (^ _Nonnull)(NSDictionary<NSString *, id> * _Nullable))completion;
/// Asynchronous detection of scannables in an image.
/// \param image The image to scan for scannables
///
/// \param completion Block with an array of detected scannables; can be empty but not nil
///
+ (void)detectInImage:(CGImageRef _Nonnull)image completion:(void (^ _Nonnull)(NSArray<QKScannable *> * _Nonnull))completion;
/// Synchronous detection of scannables in an image
/// \param image The image to scan for scannables
///
///
/// returns:
/// An array of detected Scannable objects; can be empty but not nil; Scannables will only be a raw representation (i.e. no skin object)
+ (NSArray<QKScannable *> * _Nonnull)detectInImage:(CGImageRef _Nonnull)image SWIFT_WARN_UNUSED_RESULT;
/// Generates a scannable on the Quikkly back-end with the provided data.
/// The Scannable object won’t be populated instantly and will asynchronously send and fetch data from the Quikkly back-end.
/// \param mappedData dictionary with data that’ll be stored on the back-end and linked to the scannable
///
/// \param template the identifier of the template (visual style). If nil a default style will be used.
///
/// \param skin the skin attributes for the template. If nil a default skin will be applied.
///
/// \param completion this block will be invoked as soon as the scannable has been created and provides information about success or failure.
///
- (nonnull instancetype)initWithMappedData:(NSDictionary<NSString *, id> * _Nonnull)mappedData template:(NSString * _Nullable)template_ skin:(QKScannableSkin * _Nullable)skin completion:(void (^ _Nonnull)(BOOL, QKScannable * _Nonnull))completion;
/// Generates a scannable based on an identifier and a custom skin object
/// \param value A numeric integer representation of the new Scannable object. The range of valid numbers is depends on the tag design, but it’ll always be an unsigned integer and never higher than the uint64 limits
///
/// \param template the identifier of the template (visual style). If nil a default style will be used.
///
/// \param skin the skin attributes for the template. If nil a default skin will be applied.
///
///
/// returns:
/// A new Scannable object
- (nonnull instancetype)initWithValue:(uint64_t)value template:(NSString * _Nullable)template_ skin:(QKScannableSkin * _Nonnull)skin;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end

@protocol QKScannablePipelineDelegate;

/// ScannablePipeline class represents a customisable queue to detect smart Quikkly scannable codes.
SWIFT_CLASS_NAMED("ScannablePipeline")
@interface QKScannablePipeline : NSObject
@property (nonatomic, weak) id <QKScannablePipelineDelegate> _Nullable delegate;
- (nonnull instancetype)init;
/// Initialises and returns a newly allocated pipeline object.
/// \param workQueue The queue that will be used to process images
///
/// \param mainQueue The queue that will be used to call delegate methods
///
- (nonnull instancetype)initWithWorkQueue:(dispatch_queue_t _Nullable)workQueue mainQueue:(dispatch_queue_t _Nonnull)mainQueue OBJC_DESIGNATED_INITIALIZER;
/// Push an image to the background worker queue.
/// \param image The image to scan for scannables
///
- (void)pushWithImage:(CGImageRef _Nonnull)image;
/// Clears any images that are waiting in the queue.
- (void)clear;
@end

enum QKScannableResult : NSInteger;

/// ScannablePipelineDelegate allows you to receive processed results on the main thread.
SWIFT_PROTOCOL_NAMED("ScannablePipelineDelegate")
@protocol QKScannablePipelineDelegate
- (void)pipelineDidProcessImage:(CGImageRef _Nonnull)image result:(enum QKScannableResult)result scannables:(NSArray<QKScannable *> * _Nonnull)scannables;
@end

/// ScannablePipelineResult for more detailed results.
typedef SWIFT_ENUM_NAMED(NSInteger, QKScannableResult, "ScannablePipelineResult", closed) {
  QKScannableResultUnknown = 0,
  QKScannableResultNoFrameScanned = 10,
  QKScannableResultNoShapesFound = 100,
  QKScannableResultShapeFound = 200,
  QKScannableResultDotsFound = 300,
  QKScannableResultSuccess = 10000,
};

enum QKScannableSkinImageFit : int32_t;

/// The ScannableSkin class holds relevant data for the visual representation of a Scannable object.
SWIFT_CLASS_NAMED("ScannableSkin")
@interface QKScannableSkin : NSObject
@property (nonatomic, copy) NSString * _Nullable backgroundColor;
@property (nonatomic, copy) NSString * _Nullable borderColor;
@property (nonatomic, copy) NSArray<NSString *> * _Nullable dataColors;
@property (nonatomic, copy) NSString * _Nullable maskColor;
@property (nonatomic, copy) NSString * _Nullable overlayColor;
@property (nonatomic, copy) NSString * _Nullable imageUri;
@property (nonatomic) enum QKScannableSkinImageFit imageFit;
@property (nonatomic, copy) NSString * _Nullable logoUri;
@property (nonatomic) enum QKScannableSkinImageFit logoFit;
@property (nonatomic) QKScannableSkinJoinOption joinOptions;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

typedef SWIFT_ENUM_NAMED(int32_t, QKScannableSkinImageFit, "ImageFit", closed) {
  QKScannableSkinImageFitTemplateDefault = 0,
  QKScannableSkinImageFitStretch = 1,
  QKScannableSkinImageFitMeet = 2,
  QKScannableSkinImageFitSlice = 3,
};

@protocol QKScannableViewDelegate;
@class WKWebView;
@class WKNavigation;
@class UIWebView;

/// The ScannableView class displays Scannable objects based on their skin property.
SWIFT_CLASS_NAMED("ScannableView")
@interface QKScannableView : UIView <UIWebViewDelegate, WKNavigationDelegate>
@property (nonatomic, weak) id <QKScannableViewDelegate> _Nullable delegate;
@property (nonatomic, strong) QKScannable * _Nullable scannable;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithScannable:(QKScannable * _Nonnull)scannable;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)reload;
- (void)webView:(WKWebView * _Nonnull)webView didFinishNavigation:(WKNavigation * _Null_unspecified)navigation;
- (void)webView:(WKWebView * _Nonnull)webView didFailNavigation:(WKNavigation * _Null_unspecified)navigation withError:(NSError * _Nonnull)error;
- (void)webViewDidFinishLoad:(UIWebView * _Nonnull)webView;
- (void)webView:(UIWebView * _Nonnull)webView didFailLoadWithError:(NSError * _Nonnull)error;
- (void)layoutSubviews;
@end


/// The ScannableView class displays Scannable objects based on their skin property.
SWIFT_PROTOCOL_NAMED("ScannableViewDelegate")
@protocol QKScannableViewDelegate
@optional
- (void)scannableViewWillStartLoading:(QKScannableView * _Nonnull)scannableView;
- (void)scannableView:(QKScannableView * _Nonnull)scannableView didFinishLoading:(BOOL)success;
@end











#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
