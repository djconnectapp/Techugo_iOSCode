/*
 * libbambuser - Bambuser iOS library
 * Copyright 2013 Bambuser AB
 */

#import <Foundation/Foundation.h>

#import "BambuserConstants.h"

/**
 * \anchor BambuserViewDelegate
 * Protocol for a delegate to handle updates and exceptions when using BambuserView.
 *
 * The delegate of a BambuserView must adopt the BambuserViewDelegate
 * protocol. Optional methods of the protocol allow the delegate to receive
 * signals about the state of broadcasts.
 */
@protocol BambuserViewDelegate <NSObject>
@required
@optional

/**
 * \anchor bambuserErrorCallback
 * This method will be called to relay any error to the delegate.
 *
 * @param errorCode Defined in BambuserConstants.h
 * @param errorMessage User readable error message, where available
 */
-(void) bambuserError: (enum BambuserError)errorCode message:(NSString*)errorMessage;
/**
 * \anchor chatMessageReceived
 * This method is called every time a chat message is received from the server.
 *
 * @param message Contains the message
 */
-(void) chatMessageReceived: (NSString*) message;
/**
 * \anchor broadcastStarted
 * This method will be called when the BambuserView has successfully connected to a Bambuser video server and a broadcast has been started.
 */
-(void) broadcastStarted;
/**
 * \anchor captureInterrupted
 * This method will be called when the video capture has been interrupted by an external event.
 * This could e.g. be an incoming phone call, Siri or audio playback from an application allowing background audio.
 * While interrupted the BambuserView has no access to camera nor microphone.
 *
 * This callback can be used to show a dialog informing that video capture has been interrupted.
 *
 * @param reason Reason for interrupt. Returns 0 on versions prior to iOS9.
*/
-(void) captureInterrupted: (AVCaptureSessionInterruptionReason) reason;
/**
 * \anchor captureInterruptionEnded
 * This method will be called when the video capture is running again after an interruption.
 *
 * BambuserView will try to continue an interrupted broadcast, if the connection to the Bambuser backend is still available, when an interruption ends.
 * Note! If BambuserView:saveLocally is set to YES a broadcast will always be stopped at an interrupt.
*/
-(void) captureInterruptionEnded;
/**
 * \anchor broadcastStopped
 * This method will be called when the BambuserView has been disconnected from a Bambuser video server and broadcasting has stopped.
 */
-(void) broadcastStopped;
/**
 * \anchor broadcastDisconnected
 * This method will be called when the broadcasting process has been disconnected from the remote server, but while still trying to reconnect.
 */
-(void) broadcastDisconnected;
/**
 * \anchor broadcastResumed
 * This method will be called after broadcastDisconnected, if the BambuserView managed to reconnect and resume broadcasting.
 */
-(void) broadcastResumed;
/**
 * \anchor recordingComplete
 * This method will be called when broadcasting has been stopped and a local copy has been saved.
 *
 * By default the file is located in the sandbox's NSTemporaryDirectory() and may be removed by the system when your
 * application is not running. It is your responsibility to copy, move, remove or export this file to camera roll.
 *
 * @param filename Contains the filename of the recorded file
 *
 * @see #BambuserView::saveLocally
 * @see #BambuserView::localFilename
 */
-(void) recordingComplete: (NSString*) filename;
/**
 * \anchor healthUpdated
 * During an ongoing broadcast, this method is called whenever the BambuserView's health property is updated.
 *
 * @param health Contains the stream health value in percents
 */
-(void) healthUpdated: (int) health;
/**
 * \anchor currentViewerCountUpdated
 * Called when the number of current viewers is updated.
 *
 * @param viewers Number of current viewers of the broadcast. This is generally the most interesting number during a live broadcast.
 */
-(void) currentViewerCountUpdated: (int) viewers;
/**
 * \anchor totalViewerCountUpdated
 * Called when the total number of viewers is updated.
 *
 * @param viewers Total number of viewers of the broadcast. This accumulates over time.
 * The counted viewers are not guaranteed to be unique, but there are measures in place to exclude obvious duplicates, eg. replays from a viewer.
 */
-(void) totalViewerCountUpdated: (int) viewers;
/**
 * \anchor talkbackRequest
 * This method is called when an incoming talkback request is received.
 *
 * The strings caller and request are set by the caller. The integer talkbackID is unique for this broadcast and request,
 * and is used when accepting a talkback request.
 *
 * @param request A free form string set by the caller
 * @param caller A string containing the callers name
 * @param talkbackID A unique number associated with this talkback request
 */
-(void) talkbackRequest: (NSString*) request caller: (NSString*) caller talkbackID: (int) talkbackID;
/**
 * \anchor talkbackStateChanged
 * This method is called when talkback status changes.
 *
 * @param state Defined in BambuserConstants.h
 */
-(void) talkbackStateChanged: (enum TalkbackState) state;
/**
 * \anchor broadcastIdReceived
 * This method is called when the server has returned the unique id given to the broadcast.
 */
-(void) broadcastIdReceived: (NSString*) broadcastId;
/**
 * \anchor snapshotTaken
 * When calling the takeSnapshot method, this method will return the result if successful.
 * The actual dimensions of the snapshot are limited by the active camera resolution,
 * and can vary depending on device.
 * If cropping has been requested using the #BambuserView::setOrientation:previewOrientation:withAspect:by:
 * method, the snapshot will be cropped to the desired aspect ratio.
 */
-(void) snapshotTaken:(UIImage*)image;
/**
 * \anchor uplinkTestComplete
 * This method is called when an uplink test has been completed. Uplink speed will be tested
 * automatically when applicationId has been set and a valid broadcast ticket has been retrieved.
 * The supplied speed is bytes per second, -1 if test fails, and shouldBroadcast is YES if attempting
 * to broadcast is advisable.
 * BambuserView will allow broadcasting regardless of the speed test results. The speed test results
 * are only offered as guidance.
 */
-(void) uplinkTestComplete: (float) speed recommendation: (BOOL) shouldBroadcast;
@end

