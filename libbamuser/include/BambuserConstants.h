/*
 * libbambuser - Bambuser iOS library
 * Copyright 2014 Bambuser AB
 */

#import <Foundation/Foundation.h>

/** @file */

/**
 * \anchor bambuserError
 * Enumeration of possible errorcodes.
 */
enum BambuserError {
	/// Server rejected client because the server is full
	kBambuserErrorServerFull = -1,
	/// Server rejected client because of incorrect credentials
	kBambuserErrorIncorrectCredentials = -2,
	/// Server disconnected
	kBambuserErrorServerDisconnected = -3,
	/// No camera available
	kBambuserErrorNoCamera = -4,
	/// Location disabled by user
	kBambuserErrorLocationDisabled = -5,
	/// Connection to server lost
	kBambuserErrorConnectionLost = -6,
	/// Connection could not be established
	kBambuserErrorUnableToConnect = -7,
	/// Unable to start broadcasting because a broadcast is already ongoing.
	kBambuserErrorAlreadyBroadcasting = -8,
	/// User privacy settings prohibit video or audio capture
	kBambuserErrorPrivacy = -9,
	/// Not enough free space to continue local recording
	kBambuserErrorNoFreeSpace = -10,
	/// Specified filename for local recording is not writable
	kBambuserErrorWriteError = -11,
	/// Failed to retrieve ingest server or credentials.
	kBambuserErrorBroadcastTicketFailed = -12,
	/// Encoder failed
	kBambuserErrorEncoderFailed = -13,
	/// Server rejected client for another, unclassified reason - the accompanying error message should be shown to the user.
	kBambuserErrorServerRejected = -14,
};

/** \addtogroup videopresets Video presets
 * \anchor videoPresets
 * Presets for setting video quality using the setVideoQuality: or initWithPreset:-methods.
 * Deprecation: All presets except for kSessionPresetAuto have been removed.
 * @{
 */
/**
 * Preset for automatic video quality
 */
#define kSessionPresetAuto @"auto"
/** @} */

/**
 * \anchor audioPresets
 * Possible audio presets to be set by calling setAudioQualityPreset:
 */
enum AudioQuality {
	/// Audio off
	kAudioOff = -1,
	/// Low quality audio, 11kHz mono AAC.
	kAudioLow = 0,
	/// High quality audio, 22kHz mono AAC.
	kAudioHigh = 1
};

/**
 * \anchor talkbackStates
 * The different states of talkback
 */
enum TalkbackState {
	/// This is the default state. It signals that no request is pending and no talkback session is ongoing.
	kTalkbackIdle = 0,
	/// At least one talkback request is pending, but has not yet been accepted.
	kTalkbackNeedsAccept = 1,
	/// A talkback request has been accepted, but playback has not yet started.
	kTalkbackAccepted = 2,
	/// A talkback request has been accepted and playback is ongoing.
	kTalkbackPlaying = 3
};
