/*
 * libbambuser - Bambuser iOS library
 * Copyright 2016 Bambuser AB
 */

#import <UIKit/UIKit.h>
#import "libbambuserplayer-constants.h"

/**
 * \anchor BambuserPlayerDelegate
 * The delegate of a BambuserPlayer must adopt the BambuserPlayerDelegate
 * protocol. Optional methods of the protocol allow the delegate to receive
 * signals about the state of playback.
 */
@protocol BambuserPlayerDelegate <NSObject>
@optional
/**
 * \anchor videoLoadFail
 * This method will be called when loading of broadcast metadata fails.
 * @note Deprecated use #playbackStatusChanged: method instead.
 */
- (void) videoLoadFail DEPRECATED_MSG_ATTRIBUTE("Use playbackStatusChanged: method instead");
/**
 * \anchor playbackStarted
 * This method will be called when playback of a broadcast starts.
 * @note Deprecated use #playbackStatusChanged: method instead.
 */
- (void) playbackStarted DEPRECATED_MSG_ATTRIBUTE("Use playbackStatusChanged: method instead");
/**
 * \anchor playbackPaused
 * This method will be called when playback of a broadcast is paused.
 *
 * An archived broadcast or a live broadcast in timeshift mode can be paused by a call to BambuserPlayer.pauseVideo.
 * An archived broadcast where playback has finished is also considered paused, the same if the parent application is sent to background.
 * Live broadcasts can not be paused.
 * @note Deprecated use #playbackStatusChanged: method instead.
 */
- (void) playbackPaused DEPRECATED_MSG_ATTRIBUTE("Use playbackStatusChanged: method instead");
/**
 * \anchor playbackStopped
 * This method will be called when playback of a broadcast is stopped.
 *
 * A broadcast is stopped either by a call to BambuserPlayer.stopVideo, a live broadcast has finished or due to an error.
 * A live broadcast is also stopped if the parent application is sent to background.
 * After this method has been called the BambuserPlayer is in a state where it no longer can be used. To start playback again create a new instance of BambuserPlayer.
 * @note Deprecated use #playbackStatusChanged: method instead.
 */
- (void) playbackStopped DEPRECATED_MSG_ATTRIBUTE("Use playbackStatusChanged: method instead");
/**
 * \anchor playbackStatusChanged
 * This method will be called when BambuserPlayer.status changes
 *
 * #kBambuserPlayerStateIdle
 *
 * The initial state before #BambuserPlayer.playVideo: has been called.
 *
 * #kBambuserPlayerStateLoading
 *
 * Metadata for the broadcast is loading. Playback has not started yet.
 *
 * #kBambuserPlayerStatePlaying
 *
 * Playback has started or continued after #kBambuserPlayerStatePaused or #kBambuserPlayerStateBuffering
 *
 * #kBambuserPlayerStatePaused
 *
 * Playback has been paused. This can be done for archived broadcasts or live broadcasts in timeshift mode by a call to BambuserPlayer.pauseVideo.
 * An archived broadcast where playback has finished is also considered paused, the same if the parent application is sent to background. Live broadcasts can not be paused.
 *
 * #kBambuserPlayerStateStopped
 *
 * Playback has been stopped. A broadcast is stopped either by a call to BambuserPlayer.stopVideo, a live broadcast has finished or due to an error.
 * A live broadcast is also stopped if the parent application is sent to background.
 * After this status has been entered the BambuserPlayer is in a state where it no longer can be used. To start playback again create a new instance of BambuserPlayer.
 *
 * #kBambuserPlayerStateBuffering
 *
 * BambuserPlayer needs to buffer more data to start or continue playback. When enough data has been buffered and playback continues status changes to #kBambuserPlayerStatePlaying.
 *
 * #kBambuserPlayerStateError
 *
 * Playback has failed, check #BambuserPlayer.error for reason.
 * After this status has been entered the BambuserPlayer is in a state where it no longer can be used. To start playback again create a new instance of BambuserPlayer.
 */
- (void) playbackStatusChanged: (enum BambuserPlayerState) status;
/**
 * \anchor playbackCompleted
 * This method will be called when a broadcast, archived or live, has reached the end.
 */
- (void) playbackCompleted;
/**
 * \anchor durationKnown
 * This method will be called when the duration of an archived broadcast is known.
 *
 * @param duration the duration of the broadcast(archived).
 */
- (void) durationKnown: (double) duration;
/**
 * \anchor playerCurrentViewerCountUpdated
 * Called when the number of current viewers is updated.
 *
 * @param viewers Number of current viewers of the broadcast. This is generally an interesting number during a live broadcast.
 */
-(void) currentViewerCountUpdated: (int) viewers;
/**
 * \anchor playerTotalViewerCountUpdated
 * Called when the total number of viewers is updated.
 *
 * @param viewers Total number of viewers of the broadcast. This accumulates over time and is generally a nice number to show for an old broadcast.
 * The counted viewers are not guaranteed to be unique, but there are measures in place to exclude obvious duplicates, eg. replays from a viewer.
 */
-(void) totalViewerCountUpdated: (int) viewers;
@end

/**
 * \anchor LatecyMeasurement
 * A latency measurement consists of the measured #latency and the #uncertainty of
 * the measurement. Use #BambuserPlayer.endToEndLatency to get a measurement.
 *
 * The measured #latency is at most +/- #uncertainty seconds from the
 * actual latency.
 *
 * <p>For example if the measured #latency is 0.5 s and the #uncertainty is
 * 0.100 s, the actual latency is between 0.4 and 0.6 ms.
 *
 * <p>To avoid confusion, avoid showing the latency to end users if the uncertainty is relatively
 * large. In extreme cases on unreliable mobile networks, the #uncertainty may be very
 * large. For example if the #uncertainty is 2.0 s and we know the actual latency is
 * 1.5 s, the #latency can in theory show as -0.5 to 3.5 s. In practice, the measured
 * value is likely close to the actual latency.
 */
struct LatencyMeasurement {
	/**
	 * The measured latency, in seconds.
	 */
	float latency;
	/**
	 * The total clock synchronization uncertainty, in seconds. If latency information
	 * is unavailable, this is negative.
	 */
	float uncertainty;
};
typedef struct LatencyMeasurement LatencyMeasurement;

/**
 * \anchor BambuserPlayer
 * This is the main class for using the player library. Implement the #BambuserPlayerDelegate to receive callbacks from a BambuserPlayer instance.
 * By handing BambuserPlayer a broadcast's resourceUri, it plays that broadcast. A resourceUri is a signed Uri that can be requested through the Bambuser Metadata API.
 * <p>A broadcast is in a defined #BambuserPlayerState.
 * Archived broadcasts (or live broadcasts in timeshift mode) can be paused or stopped. Live broadcasts can only be stopped.
 * If the parent application is sent to background an archived broadcast (or live broadcasts in timeshift mode) is paused and a live broadcast is stopped.
 * <p>After #kBambuserPlayerStateStopped or #kBambuserPlayerStateError has been entered the BambuserPlayer instance is no longer usable. To start playback again create a new instance of BambuserPlayer.
 * #### Configuring AVAudioSession #
 * <p>BambuserPlayer does not configure the app's AVAudioSession. It is up to the implementer to set appropriate category and mode for its use case. Read more about configuring an AVAudioSession in [Apple's documentation](https://developer.apple.com/library/archive/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/AudioSessionBasics/AudioSessionBasics.html#//apple_ref/doc/uid/TP40007875-CH3-SW1).
 */
@interface BambuserPlayer : UIView {
}

/**
 * Set this to the object that conforms to the BambuserPlayerDelegate protocol, to receive updates about playback.
 */
@property (nonatomic, weak) id <BambuserPlayerDelegate> delegate;
/**
 * \anchor resourceUri
 * Returns the resourceUri for the currently loaded broadcast, nil if #playVideo: has not been called.
 *
 * This value is set in #playVideo: when starting playback of a broadcast.
 */
@property (nonatomic, readonly) NSString *resourceUri;
/**
 * \anchor broadcastId
 * Returns the broadcastId for the currently loaded broadcast. Available after #status has changed from #kBambuserPlayerStateLoading to
 * #kBambuserPlayerStateBuffering or #kBambuserPlayerStatePlaying.
 */
@property (nonatomic, readonly) NSString *broadcastId;
/**
 * \anchor playerApplicationId
 * Contains the Bambuser Application ID necessary to make authorized requests.
 *
 * This property can only be set before calling #playVideo:. If set after it has no effect.
 */
@property (nonatomic, retain, setter = setApplicationId:, getter = applicationId) NSString *applicationId;
/**
 * \anchor requiredBroadcastState
 * Set the broadcast state accepted when loading the broadcast for playback. For example, this can be used to ensure that
 * the player will only play the provided broadcast while its status is still live, prohibiting playback of an archived file, or vice versa.
 * Default value is #kBambuserBroadcastStateAny.
 *
 * This property can only be set before calling #playVideo:. If set after it has no effect.
 */
@property (nonatomic) enum BroadcastState requiredBroadcastState;
/**
 * \anchor status
 * This property reflects the current state of playback.
 */
@property (nonatomic, readonly) enum BambuserPlayerState status;
/**
 * \anchor error
 * Is set when #BambuserPlayerState is #kBambuserPlayerStateError. Is nil in any other #BambuserPlayerState.
 */
@property (nonatomic, readonly) NSError *error;
/**
 * \anchor canPause
 * Returns YES if the BambuserPlayer has loaded an archived broadcast (or a live broadcast in timeshift mode)
 * and is in a state that supports pause/play/seeking, NO otherwise.
 */
@property (nonatomic, readonly) BOOL canPause;
/**
 * \anchor playbackPosition
 * Returns the current playback position (in seconds) of the current broadcast.
 * The current position is always available for archived broadcasts and for
 * live broadcasts in timeshift mode. It may also be available for live
 * broadcasts, depending on video format.
 * Returns 0 if current position is unknown.
 */
@property (nonatomic, readonly, getter = playbackPosition) double playbackPosition;
/**
 * \anchor live
 * This boolean property indicates whether the broadcast loaded for playback is currently live or not.
 * Available after #status has changed from #kBambuserPlayerStateLoading to
 * #kBambuserPlayerStateBuffering or #kBambuserPlayerStatePlaying. The value is not updated later.
 * Live broadcasts, unless #timeShiftModeEnabled is set to YES, cannot be paused nor seeked in.
 */
@property (nonatomic, readonly) BOOL live;
/**
 * \anchor resolution
 * Returns the original resolution of the broadcast
 * Available after #status has changed from #kBambuserPlayerStateLoading to
 * #kBambuserPlayerStateBuffering or #kBambuserPlayerStatePlaying. Value is not updated later. Returns (0,0) until it is known.
 */
@property (nonatomic, readonly) CGSize resolution;
/**
 * \anchor VODControlsEnabled
 * This boolean property indicates whether or not system controls should be displayed when doing playback of archived broadcasts.
 */
@property (nonatomic, setter = setVODControlsEnabled:) BOOL VODControlsEnabled;
/**
 * \anchor videoGravity
 * An enum that specifies how the video is displayed within the bounds of the BambuserPlayer's view.
 * The default value is #VideoScaleAspectFill.
 */
@property (nonatomic) enum VideoScaleMode videoScaleMode;
/**
 * \anchor timeShiftModeEnabled
 * This boolean property is used to enable seeking during a live broadcast.
 * The default value is NO, as the timeshift mode has trade-offs: it adds additional latency, and
 * is mainly suited for broadcasts with reasonable duration. This should only be enabled if
 * seeking in live content is actually required.
 *
 * This property can only be set before calling #playVideo:. If set after it has no effect.
 */
@property (nonatomic, setter = setTimeShiftModeEnabled:) BOOL timeShiftModeEnabled;
/**
 * \anchor seekableStart
 * This property holds the earliest possible position to seek to in timeshift mode.
 * This property will return a negative value if not available.
 */
@property (nonatomic, readonly) double seekableStart;
/**
 * \anchor seekableEnd
 * This property holds the latest possible position to seek to in timeshift mode.
 * This property will return a negative value if not available.
 */
@property (nonatomic, readonly) double seekableEnd;
/**
 * The audio playback volume for the BambuserPlayer, ranging from 0.0 through 1.0 on a linear scale.
 * A value of 0.0 indicates silence; a value of 1.0 (the default) indicates full audio volume for the BambuserPlayer.
 *
 * Setting this property outside the valid range of 0.0 - 1.0 will cap the volume to 0.0 or 1.0.
 */
@property (nonatomic, setter = setVolume:) float volume;

/**
 * Get the current measured end-to-end latency when playing a live broadcast.
 *
 * During a live broadcast, the broadcaster and BambuserPlayer can synchronize their clocks
 * with the servers and the player can determine the current end-to-end latency.
 *
 * End-to-end latency measurements may take a while before appearing and may not be available
 * for all broadcasts, as it requires successful clock synchronization and needs to be supported
 * by the broadcast source too.
 *
 * @return A LatencyMeasurement struct containing the current end-to-end latency and the
 * total uncertainty of the broadcaster and player. The LatencyMeasurement.uncertainty field
 * is negative if end-to-end latency information currently is unavailable.
 */
@property (nonatomic, readonly) LatencyMeasurement endToEndLatency;

/**
 * Set whether the player should prioritize low latency or playback with less interruptions.
 * In #BambuserPlayerLatencyModeLow latency mode, the player prioritizes low latency and is quick
 * to start initial playback.
 * In #BambuserPlayerLatencyModeHigh latency mode, the player uses larger buffers and will buffer
 * slightly more initially, to minimize the risk of playback interruptions due to network
 * fluctuations.
 *
 * This property currently only affects live broadcasts. The default value is #BambuserPlayerLatencyModeLow.
 * This property can only be set before calling #playVideo:. If set after it has no effect.
 */
@property (nonatomic) enum BambuserLatencyMode latencyMode;

/**
 * Used to initialise the BambuserPlayer view.
 */
- (id) init;
/**
 * \anchor playVideoWithResourceUri
 * Request the BambuserPlayer to start playing a broadcast with the supplied resource uri,
 * which is a signed URI received from the Bambuser Metadata API.
 *
 * This method can only be called once. Subsequent calls to this method have no effect.
 *
 * @param resourceUri The resource uri associated with the broadcast to be loaded.
 */
- (void) playVideo: (NSString*) resourceUri;
/**
 * \anchor stopVideo
 * Stops and terminates playback of a broadcast. To start playback again create a new instance of BambuserPlayer.
 */
- (void) stopVideo;
/**
 * \anchor pauseVideo
 * Pauses playback of archived broadcasts or live broadcasts in timeshift mode.
 *
 * For live broadcasts not in timeshift mode, a call to this method has no effect.
 */
- (void) pauseVideo;
/**
 * \anchor playVideo
 * Resume playback of a broadcast that has been paused. This is only available for archived or live broadcasts in timeshift mode.
 * For live broadcasts, playback must be requested via the #playVideo: method.
 */
- (void) playVideo;
/**
 * \anchor seekTo
 * Seek archived broadcast to supplied time (in seconds).
 */
- (void) seekTo: (double) time;
@end
