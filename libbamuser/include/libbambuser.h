/*
 * libbambuser - Bambuser iOS library
 * Copyright 2013 Bambuser AB
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "BambuserViewDelegate.h"

/**
 * @mainpage Bambuser library for iOS 8.0+
 *
 * @section libbambuser Bambuser broadcasting library, libbambuser
 * The Bambuser library has the following dependencies:
 *
 * libz.tbd
 *
 * AudioToolbox, AVFoundation, CoreGraphics, CoreLocation, CoreMedia,
 * CoreVideo, Foundation, QuartzCore, SystemConfiguration, UIKit, VideoToolbox, CoreTelephony
 *
 * The Bambuser library also requires the C++ runtime library. If your
 * application already uses C++ directly, a C++ runtime library will
 * already be linked in, and you don't need to do anything extra. If
 * your application doesn't use C++, you need to add it manually. Add
 * libc++.tbd to the list of linked frameworks and libraries.
 *
 * @section libbambuserplayer Bambuser player library, libbambuserplayer
 *
 * The Bambuser player library has the following dependencies:
 *
 * AudioToolbox, AVFoundation, CoreMedia, Foundation, UIKit, AVKit
 *
 * The Bambuser player library also requires the C++ runtime library. If your
 * application already uses C++ directly, a C++ runtime library will
 * already be linked in, and you don't need to do anything extra. If
 * your application doesn't use C++, you need to add it manually. Add
 * libc++.tbd to the list of linked frameworks and libraries.
 *
 */

/**
 * \anchor BambuserView
 * This is the main class for using the broadcasting library.
 */
@interface BambuserView : UIViewController {
}

/**
 * Property for setting delegate to receive BambuserViewDelegate callbacks
 */
@property (weak) id delegate;
/**
 * \anchor applicationId
 * This property should hold your application ID. Depending on serverside setup this ID can redirect you to a suitable
 * ingest server, and automatically set your broadcasting credentials.
 *
 * This property shall be set before calling #startBroadcasting and can not be altered during a broadcast.
 */
@property (nonatomic, retain, setter = setApplicationId:, getter = applicationId) NSString* applicationId;
/**
 * \anchor chatView
 * This property presents a scrollable view for displaying chat messages.
 * See documentation for UIView for styling the view with background
 * color, alpha and frame.
 */
@property (nonatomic, retain) UIView *chatView;
/**
 * \anchor canStart
 * This property is YES if the startBroadcasting method can be called.
 * If the library is connecting or already is connected this method will
 * return NO.
 */
@property (nonatomic, readonly, getter = canStart) BOOL canStart;
/**
 * \anchor audioQualityPreset
 * This property sets the audio quality preset for the upcoming bambuser broadcast. This setting is locked while local recording is in progress.
 * Constants are defined in BambuserConstants.h for the possible values of this property.
 * The default value is #kAudioHigh.
 */
@property (nonatomic, setter = setAudioQualityPreset:, getter = audioQualityPreset) enum AudioQuality audioQualityPreset;
/**
 * \anchor saveOnServer
 * When this property is YES, the next broadcast will signal the Bambuser video server that the broadcast
 * should be available on demand when the live broadcast is over.
 * This property can not be altered during an ongoing broadcast.
 */
@property (nonatomic, setter = setSaveOnServer:, getter = saveOnServer) BOOL saveOnServer;
/**
 * \anchor saveLocally
 * When this property is YES, the next broadcast will also be saved to a local file. If a path is set in #localFilename, the file gets written in that path,
 * otherwise the file gets a unique filename assigned and is stored within the sandbox's NSTemporaryDirectory().
 * This property can not be altered during an ongoing broadcast.
 *
 * @see #localFilename
 * @see #BambuserViewDelegate::recordingComplete:
 */
@property (nonatomic, setter = setSaveLocally:, getter = saveLocally) BOOL saveLocally;
/**
 * \anchor setTalkback
 * When this property is YES, the next broadcast will signal the Bambuser video server that the client is willing to accept requests for talkback.
 * This property can not be altered during an ongoing broadcast.
 */
@property (nonatomic, setter = setTalkback:, getter = talkback) BOOL talkback;
/**
 * \anchor setTalkbackMix
 * This property indicates whether the talkback audio should be mixed into the signal that gets recorded into the local copy and broadcasted.
 * This property can not be altered during an ongoing broadcast.
 */
@property (nonatomic, setter = setTalkbackMix:, getter = talkbackMix) BOOL talkbackMix;
/**
 * \anchor setLocalFilename
 * This property can be set if you want to set a specific file path when saving a local copy of your broadcast.
 * If this value is nil the local copy will be saved with a unique filename in the sandbox's NSTemporaryDirectory().
 * This property can not be altered during an ongoing broadcast.
 *
 * @see #saveLocally
 * @see #BambuserViewDelegate::recordingComplete:
 */
@property (nonatomic, retain, setter = setLocalFilename:, getter = localFilename) NSString *localFilename;
/**
 * \anchor sendPosition
 * When this property is YES, the location of the device will be sent continuously during the next broadcast.
 * This property can not be altered during an ongoing broadcast.
 */
@property (nonatomic, setter = setSendPosition:, getter = sendPosition) BOOL sendPosition;
/**
 * \anchor author
 * Contains the author field which will be associated with the broadcast.
 *
 * This can be any arbitrary string that should be associated with the
 * broadcast.
 * This property should be set before calling #startBroadcasting.
 */
@property (nonatomic, retain, setter = setAuthor:, getter = author) NSString *author;
/**
 * \anchor broadcastTitle
 * Sets the title for an upcoming broadcast, or updates the title for
 * an ongoing broadcast. This property can be altered at any time.
 */
@property (nonatomic, retain, setter = setBroadcastTitle:, getter = broadcastTitle) NSString *broadcastTitle;
/**
 * \anchor customData
 * Can be set to an arbitrary string that will be associated with the broadcast.
 *
 * This property can be set before broadcasting and updated during the broadcast.
 *
 * Note: This field is currently limited to 10000 bytes serverside.
 */
@property (nonatomic, retain, setter = setCustomData:, getter = customData) NSString *customData;
/**
 * \anchor orientation
 * This property determines the orientation the video will be recorded in.
 *
 * This property can be set to the UIInterfaceOrientation* constants from UIKit/UIApplication.h.
 * The default value is UIInterfaceOrientationLandscapeRight.
 *
 * During a broadcast, it can only be set to flipped versions of the same orientation (i.e. switching from
 * UIInterfaceOrientationLandscapeRight to UIInterfaceOrientationLandscapeLeft).
 */
@property (nonatomic, setter = setOrientation:, getter = orientation) UIInterfaceOrientation orientation;
/**
 * \anchor previewOrientation
 * This property determines the orientation of the application UI, making sure that the camera picture on the screen is rotated correctly.
 *
 * This property is read-only - setting the orientation property sets this to the same value.
 * See #setOrientation:previewOrientation: in order to change it.
 */
@property (nonatomic, readonly, getter = previewOrientation) UIInterfaceOrientation previewOrientation;
/**
 * \anchor torch
 * This property turns the LED torch on and off, if the device has one. This property can be altered at any time.
 */
@property (nonatomic, setter = setTorch:, getter = torch) BOOL torch;
/**
 * \anchor hasLedTorch
 * This readonly property will be YES if the device has an LED torch.
 */
@property (nonatomic, readonly, getter = hasLedTorch) BOOL hasLedTorch;
/**
 * \anchor hasFrontCamera
 * This readonly property will be YES if the device has a front-facing camera.
 */
@property (nonatomic, readonly, getter = hasFrontCamera) BOOL hasFrontCamera;
/**
 * \anchor health
 * This readonly property returns a value between 0 and 100, indicating the current stream health.
 *
 * A value of 0 indicates that the connection is unable to keep up with transferring all data currently being generated.
 * A value of 100 indicates that the connection is able to send all the data currently being generated.
 *
 * This method will return 0 when not broadcasting.
 */
@property (nonatomic, readonly, getter = health) int health;
/**
 * \anchor talkbackState
 * This readonly property contains the current state of talkback.
 *
 * See BambuserConstants.h for possible values.
 */
@property (nonatomic, readonly, getter = talkbackState) enum TalkbackState talkbackState;
/**
 * \anchor zoom
 * This property controls the current zoom level. Accepted values are in the range [1.0, #maxZoom].
 */
@property (nonatomic, setter = setZoom:, getter = zoom) float zoom;
/**
 * \anchor maxZoom
 * This readonly property returns the highest value accepted for the zoom property.
 *
 * A negative value indicates that the device does not support zooming.
 */
@property (nonatomic, readonly, getter = maxZoom) float maxZoom;
/**
 * \anchor framerate
 * This property allows setting the maximum capture framerate, within a range from 24 to 30 fps.
 * Default framerate is 30.
 */
@property (nonatomic, setter = setFramerate:, getter = framerate) float framerate;
/**
 * \anchor minFramerate
 * This property indicates the minimum framerate.
 *
 * This property is read-only, it can be set via #setFramerate:minFramerate:.
 */
@property (nonatomic, readonly, getter = minFramerate) float minFramerate;
/**
 * \anchor uplinkSpeed
 * This property returns the current speed in bytes per second of an ongoing or previously
 * performed uplink test.
 *
 * If an uplink test has not yet been started, 0 will be returned.
 */
@property (nonatomic, readonly, getter = uplinkSpeed) float uplinkSpeed;
/**
 * \anchor uplinkRecommendation
 * This property returns the current recommendation whether to broadcast or not, during an
 * ongoing or previously performed uplink test.
 *
 * If an uplink test has not yet been started, NO will be returned.
 */
@property (nonatomic, readonly, getter = uplinkRecommendation) BOOL uplinkRecommendation;
/**
 * \anchor maxBroadcastDimension
 * Sets the max size for any dimension (width, height) when using the auto quality preset (#kSessionPresetAuto).
 *
 * This can be used to conserve bandwidth while using a higher camera video resolution, for example when a
 * high resolution local copy is desired.
 *
 * Accepted values range from 200 to 1280. Default value is 0, which will give the maximum camera resolution.
 * Currently it is 1280x720 in landscape mode and 720x1280 in portrait mode.
 *
 * The live broadcast resolution will not be higher than the set limit, not higher
 * than the actual camera video resolution and will still be automatically adjusted depending
 * on current network conditions. This method only sets an upper bound.
 *
 * For instance, if maxBroadcastDimension is set to 640, the broadcast is limited to 640x360
 * in landscape mode, and to 360x640 in portrait mode at the default aspect ratio.
 *
 * This property can not be altered during a broadcast.
 */
@property (nonatomic, setter=setMaxBroadcastDimension:, getter=maxBroadcastDimension) int maxBroadcastDimension;
/**
 * \anchor previewFrame
 * Property to set a custom rectangle with the desired location and dimensions for the preview view.
 */
@property (nonatomic, setter=setPreviewFrame:, getter=previewFrame) CGRect previewFrame;
/**
 * \anchor cameraPosition
 * Property to set camera used, AVCaptureDevicePositionBack or AVCaptureDevicePositionFront. AVCaptureDevicePositionBack is default. If AVCaptureDevicePositionUnspecified is set it has no effect.
 *
 * @see #swapCamera
 */
@property (nonatomic) AVCaptureDevicePosition cameraPosition;
/**
 * \anchor initWithPreset
 * Used to initialise the bambuserView.
 * This method should be called with one of the kSessionPreset* video preset constants declared in BambuserConstants.h.
 *
 * @param preset Preferred kSessionPreset-value from BambuserConstants.h. Default is kSessionPresetAuto.
 * @return Returns the BambuserView object
 * @deprecated Use #initWithPreparePreset: instead.
 */
- (id) initWithPreset: (NSString *) preset DEPRECATED_MSG_ATTRIBUTE("Use initWithPreparePreset instead");
/**
 * \anchor initWithPreparePreset
 * Used to initialise the bambuserView.
 * This method should be called with one of the kSessionPreset* video preset constants declared in BambuserConstants.h.
 * This method does not start capture immediately, but allows you to set other capture related parameters directly, before
 * starting the capture. If initializing with this method, you must call #startCapture immediately afterwards, after setting
 * all the capture related properties.
 *
 * @param preset Preferred kSessionPreset-value from BambuserConstants.h. Default is kSessionPresetAuto.
 * @return Returns the BambuserView object
 */
- (id) initWithPreparePreset: (NSString *) preset;
/**
 * \anchor startCapture
 * Start capturing with the properties set.
 *
 * If the #initWithPreparePreset: method was called, this method should be called immediately after all properties
 * that are going to be set upfront have been set. This must have been called before calling #startBroadcasting.
 *
 * This method should only be called once.
 */
- (void) startCapture;
/**
 * \anchor startBroadcasting
 * Connects to the Bambuser video server and starts a new broadcast.
 * This method should not be called if the library is trying to connect or is already connected.
 * It is advisable to check the canStart property before calling this method.
 */
- (void) startBroadcasting;
/**
 * \anchor stopBroadcasting
 * Stops the broadcast and disconnects from the Bambuser video server.
 * This method can be called at any time.
 */
- (void) stopBroadcasting;
/**
 * \anchor displayMessage
 * Display the supplied string message in chatView.
 * @param message A string containing the message to be displayed in chatView.
 */
- (void) displayMessage: (NSString*) message;
/**
 * \anchor setVideoQualityPreset
 * Sets a video quality preset for the upcoming Bambuser session. This
 * method should not be called during a broadcast.
 *
 * The only valid value for this parameter is kSessionPresetAuto.
 *
 * The preset kSessionPresetAuto will allow the video quality to dynamically be adjusted depending on the connection quality.
 *
 * The default value is kSessionPresetAuto.
 *
 * Deprecation: Some constants from AVCaptureSession.h were previously used. These are still valid for backwards compatibility.
 * @param preset A video input preset as declared in BambuserConstants.h.
 * @return YES if the session could apply the preset, otherwise NO.
 */
- (BOOL) setVideoQualityPreset: (NSString*) preset;
/**
 * \anchor setOrientation
 * Sets the preview orientation independently from the capture orientation.
 *
 * The previewOrientation parameter should be the orientation mode used for the application UI where the preview is shown.
 * This allows e.g. keeping the UI locked in one orientation while capturing in an orientation depending on how the device is held.
 */
- (void) setOrientation: (UIInterfaceOrientation) orientation previewOrientation: (UIInterfaceOrientation) previewOrientation;
/**
 * \anchor setOrientationWithAspect
 * Sets the preview orientation independently from the capture orientation.
 *
 * The previewOrientation parameter should be the orientation mode used for the application UI where the preview is shown.
 * This allows e.g. keeping the UI locked in one orientation while capturing in an orientation depending on how the device is held.
 * This method additionally takes integers for width and height, to set aspect ratio for the captured video. Note that the captured
 * video is cropped to fit this ratio, so edges of your preview might not be in the broadcast video. Vice versa, parts not visible
 * in the preview might appear in the broadcast video. To avoid this, make sure to set the preview frame to the same aspect ratio using
 * the #previewFrame property.
 */
- (void) setOrientation: (UIInterfaceOrientation) orientation previewOrientation: (UIInterfaceOrientation) previewOrientation withAspect: (int) w by: (int) h;
/**
 * \anchor setFramerate
 * This method allows setting the minimum framerate of the capture, in addition to the maximum framerate.
 *
 * The minimum framerate only affects the capture from the camera itself; the actual streamed framerate may be lower.
 * This restricts the camera, not allowing it to lower the framerate even if it would be needed to get better exposure (e.g. in low light conditions).
 * Default framerate is 30 and minFramerate is 15.
 */
- (void) setFramerate:(float)framerate minFramerate:(float)minFramerate;
/**
 * \anchor swapCamera
 * For devices with more than one camera this method can be used to toggle
 * between these cameras. This method can be called at any time.
 *
 * @see #cameraPosition
 */
- (void) swapCamera;
/**
 * \anchor takeSnapshot
 * Request a snapshot be returned from the camera.
 * The resulting UIImage will be returned through the #BambuserViewDelegate::snapshotTaken: method.
 */
- (void) takeSnapshot;
/**
 * \anchor acceptTalkbackRequest
 * This method is used to accept a pending talkback request.
 * The talkbackID should previously have been supplied by the delegate protocol method #BambuserViewDelegate::talkbackRequest:caller:talkbackID:.
 * @param talkbackID The talkbackID supplied in a previous talkback request during ongoing broadcast
 */
- (void) acceptTalkbackRequest: (int) talkbackID;
/**
 * \anchor declineTalkbackRequest
 * This method is used to reject a pending talkback request.
 * The talkbackID should previously have been supplied by the delegate protocol method #BambuserViewDelegate::talkbackRequest:caller:talkbackID:.
 * @param talkbackID The talkbackID supplied in a previous talkback request during ongoing broadcast
 */
- (void) declineTalkbackRequest: (int) talkbackID;
/**
 * \anchor endTalkback
 * This method is used to end an ongoing talkback session.
 */
- (void) endTalkback;
/**
 * \anchor startLinktest
 * This method is used to manually start a linktest.
 * The result will be returned through the #BambuserViewDelegate::uplinkTestComplete:recommendation: method.
 * A valid applicationId must be set before linktests can be performed.
 */
- (void) startLinktest;
@end
