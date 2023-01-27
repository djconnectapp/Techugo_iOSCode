//
//  Constant.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 22/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Foundation

let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

class Constant {
    static var google_API_KEY = "AIzaSyDL45-qHL6ES4_8eShug-1vUc4Y0IJu3aI"
    static var google_client_id = "1066360845647-igiten6rrsaitjvni6uvqar6rvr3dvf8.apps.googleusercontent.com"
    static var web_url = "http://ec2-54-158-29-222.compute-1.amazonaws.com/webservices/app/"
}

class webservice{
    //static var url = "http://dev.djconnectapp.com/DJJSON/api/"                // for development
   static var url = "https://djconnectapp.com/DJJSON/api/"                     // use this base url for live "
    
     //static var stripePaymentAPI = "http://54.167.191.25/DJJSON/public/uploads/Stripe_IOS/stripe_payment.php" // for development
     static var stripePaymentAPI = "https://djconnectapp.com/DJJSON/public/uploads/Stripe_IOS/stripe_payment.php" // for live url
    
    
    
    static var privacyPolicy = "getStaticPage?userid=1&token=123321&pageId=3"
    static var termsOfUse = "getStaticPage?userid=1&token=123321&pageId=2"
    static var songEmailAPI = "songMail"
    static var addTimezoneAPI = "addTimezone"//"add-timezone.php"
    static var addDjRemixAPI = "addDjRemix"
    static var addDjRemixReplayAPI = "djremixaudio"//"add-djremix-audio.php"
    static var getDjRemixStepsAPI = "getDjRemixSteps"
    static var match_pinAPI = "matchPin"//""match_pin.php"
    static var logoutAPI = "signout"
    static var userAccountDeleteAPI = "userAccountDelete"
    static var setAppliedAudioOrderAPI = "setappliedAudioorder"//"set-applied_audio_order.php"
    static var apply_promocodeAPI = "applyPromocode"//""apply_promocode.php"
    static var report_userAPI = "reportUser"//"report-user.php"
    static var get_promocodeAPI = "getpromocode"//""get-promocode.php"
    static var payment_historyDJAPI = "getApplyProjectDjPayment"
    static var payment_historyARAPI = "getApplyProjectPayment"
    //static var androidRegistrationAPI = "http://keshavinfotechdemo.com/KESHAV/KG2/JSON/webservices/Pushnotification_Android/register1.php"
    static var addAccountAPI = "addaccount"//""add-account.php"
    static var addProjectRating = "addProjectRating"//""add-project-rating.php"
    static var getAccountAPI = "getaccount"//"get-accounts.php"
    //static var deleteAccountAPI = "deleteaccount"//"delete-account.php"
    static var registerAPI = "register"//"register.php"
    static var forgotVerifyOtpAPI = "forgotVerifyOtp"//"register.php"
    static var loginAPI = "login"
    static var checkGoogleFbAccountAPI = "checkFacebookGoogle"//check-facebook-google.php"
    static var updatePasswordAPI = "updatePassword"
    static var forgotPwdAPI = "forgotPassword"//"forgot-password.php"
    static var facebookAPI = "facebookLogin"//"facebook-login.php"
    static var googleAPI = "googleLogin"//"google-login.php"
    static var appleLoginAPI = "appleLogin"//"appleLoginAPI.php"
    static var getProfileAPI = "getProfile"//"get-profile.php"
    static var getupdateStripeStatus = "updateStripeStatus"
    static var getAddStripeAccountAPI = "addStripeAccount"
    static var getWithdrawAmountAPI = "withdrawAmount"
    static var saveProfileAPI = "updateProfile"//"edit-profile.php"
    static var getGenreAPI = "getGenre"//"get-genre.php"
    static var getCurrentCreditsAPI = "getCurrentcredit"//"get-current-credits.php"
    static var getArtistCreditsListAPI = "getartistcreditdata"//""get-artist-credit-data.php"
    static var getDjRequestListAPI = "getdjrequestdata"//""get-dj-request-data.php"
    //static var getCurencyAPI ="getcurrencylist"// "get-currency-list.php"
    static var sendOtpAPI = "sendotp"//"send_otp.php"
    static var searchUserAPI = "searchUser"//"search-user.php"
    static var getNotificationAPI = "getnotification_on_off"//""get_notification_on_off.php"
    static var setNotificationAPI = "setnotification_on_off"//"set_notification_on_off.php"
    static var accountDeactiveAPI = "accountDeactive"
    static var addDjProjectAPI = "adddjproject"//""add-dj-project.php"
    static var addDjLiveAPI = "addDjLive"//"add-dj-live.php"
    static var getProjectDetailsAPI = "getProjectDetail"//"get-project-detail.php"
    static var EditpostDjProjectAPI = "editdjproject"//""Edit-dj-project.php"
    static var getFavouriteDjListAPI = "favoriteuser"//"favorite-user.php"
    static var getFavedMeListAPI = "favedMe"//faved-me.php"
    static var getHelpAPI = "gethelp"//""get-help.php"
    static var editProfileServiceAPI = "editDjService"//edit-dj-service.php"
    static var sendFeedbackAPI = "addFeedback"//"add_feedback.php"
    static var blockUserAPI = "blockuser"//"block_user.php"
    static var getblockedUserAPI = "blockList"//block_list.php"
    static var changeBroadcastStatusAPI = "changebroadcaststatus"//"change-broadcast-status.php"
    static var unblockUserAPI = "unblockuser"//"unblock_user.php"
    static var getProjectTypeAPI = "getprojecttypelist"//""get-project-type-list.php"
    static var addFavoriteAPI = "addFavoriteuser"//"add-favorite-user.php"
    static var removeFavoriteAPI = "removeFavoriteuser"//"remove-favorite-user.php"
    static var removeDjLiveAPI = "removeDjLive"//remove-dj-live.php"
    static var deleteProjectAPI = "deleteproject"//""delete-project.php"
    static var deleteProjectArSideAPI = "deleteArtistProject"//delete-artist-project.php"
    static var updateUserPassAPI = "updateUsernamePassword"//update_username_password.php"
    static var verifyEmailAPI = "verifyEmail"//verifyEmail.php"
    
    // static var getRatingAPI = "add_rating.php"
    static var getDjGraphPinAPI = "getDjGraphPins"//"get-dj-graph-pin.php"
    static var getArtistGraphPinAPI = "getArtistGraphPins"//get-artist-graph-pin.php"
    static var getSongReviewGraphPinAPI = "getSongreviewGraphPins"//get-songreview-graph-pins-list.php"
    static var addMediaAudioAPI = "addMediaAudio"//"add-media-audio.php"
    static var addSongAPI = "addSong"//add-song.php"
    static var addReviewSongAPI = "addvideo"//"add-video.php"
    static var getWeeklyProjectsAPI = "getWeeklyProject"//"get-weekly-projects.php"
    static var statusChangeProjectAPI = "statusChangeProject"//status-change-project.php"
    static var getAppliedartistAudioAPI = "getAppliedArtistAudio"//get-applied-artist-audio.php"
    static var acceptRejectArtistAudioAPI = "acceptRejectArtistAudio"//"accept-reject-artist-audio.php"
    static var addAudioProjectBuyAPI = "addAudioProjectBuy"// "add-audio-project-buy.php"
    static var addAudioDjDropAPI = "addDjDropAudio"//add-djdrop_audio.php"
    static var applyProjectPaymentAPI = "projectPayment"//project-payment.php"
    static var getSocialMediaAPI = "getsocialmedia"//"get-social-media.php"
    static var getFeedbackEmailAPI = "getFeedbackEmail"//"get-feedback-email.php"
    static var addDjdropAPI = "addDjDrop"// "add-djdrop.php"
    static var checkEmailAPI = "checkEmail"//"check-email.php"
    static var getSettingAPI = "getsettings"//"get-settings.php"
    static var changeSettingAPI = "changeprojectsetting"//"change-project-setting.php"
    static var getDjDropStepsAPI = "getDjDropSteps"//get-djdrop-steps.php"
    //static var getAlertCounterAPI = "getalertcounter"//"get-alert-counter.php"
    static var getAlertListAPI = "getalert"//"get-alert.php"
    static var setReadAlertAPI = "setreadalert"//"set-read-alert.php"
    static var getTutorialAPI = "gettutorial"//"get-tutorial.php"
    static var setTutorialAPI = "settutorial"//"set-tutorial.php"
    static var purchaseCreditslAPI = "purchaseCredit"//""purchase_credit.php"
    static var djWithdrawReqlAPI = "djwithdrawrequest"//""djwithdraw-request.php"
    static var paymentDataAPI = "getPaymentData"//"payment-data.php"
    
    static var getDjStatsAPI = "getDjStats"//"get-dj-stats.php"
    static var getArtistStatsAPI = "getArtistStats"//"get-artist-stats.php"
    static var addTimeAPI = "addTime"//"add-time.php"
    static var getStepsProjectAPI = "getSteps"//get-steps.php"
    static var getArtistProjectDetailAPI = "artistProjectDetail"//artist-project-detail.php"
    static var getSongReviewStepsAPI = "getSongReviewSteps"//get-song-review-steps.php"
    static var deleteAlertAPI = "deletealert"//"delete-alert.php"
    static var getAllProjectsAPI = "getAllProject"//"get-all-projects.php"
    static var videoVerifyAPI = "videoVerify"//video-verify.php"
    static var addRecordAPI = "iosDeviceRegister"//add_record.php"
    static var verifyEmailCode = "verify-email-code.php"
    static var verifyOTP = "verifyotp"//verify-otp.php"
    static var getBuyProjectStatus = "getBuyProjectStatus"//get-buy-project-status.php"
    static var addCommercialAd = "add-commercial-ad.php"
    static var commercialData = "commercialData"
    static var addVideo = "addVideo"
    static var djSendMailAPI = "djSendMail"
    
    static var checkUserVerifyAPI = "checkUserVerify"
    
    static var rejectProjectVerificationAPI = "rejectProjectVerification"
    static var artistSubscriptionAPI = "artistSubscription"
    static var subscriptionDetailsAPI = "subscriptionDetails"
    
    static var rejectReviewVerificationAPI = "rejectReviewVerification"
    //static var stripePaymentAPI = "http://keshavinfotechdemo.com/KESHAV/KG2/JSON/webservices/Stripe_IOS/stripe_payment.php"
    
}

let isIntroChecked: String = "isIntroChecked"
let isArtistIntroChecked: String = "isArtistIntroChecked"

func setPopUp(isSeen: Bool){
        UserDefaults.standard.set(isSeen, forKey: isIntroChecked)
        UserDefaults.standard.synchronize()
}

func setArtistPopUp(isSeen: Bool){
    UserDefaults.standard.set(isSeen, forKey: isArtistIntroChecked)
    UserDefaults.standard.synchronize()
}

class Identity: NSObject{
    static let defaults = UserDefaults.standard
    static var isIntroSeen = { return defaults.bool(forKey: isIntroChecked) }
    static var isArtistIntroSeen = { return defaults.bool(forKey: isArtistIntroChecked) }
    
}
struct Keys {
    
    //static var stripeKey = "pk_test_51J7DFrIWyJFFO2dYlvl6aDAVF17ajBQLHCiimifuVEjo9ilhPWr51KglkxPb1oqY7W8w0Lttrrj9IYti0ol1RaKP00Wwya2QRY" // for test url
    
   // static var stripeKey = "pk_test_WQBTIEi74MXos7xITb9OBdpI00GnoBrHFC" //for test url --  ye wala run ho ra h dev k case me - test url
     
    static var stripeKey = "pk_live_uQLiysML1h2O2VeRFXFyN4YY00mAqDJc0l" // for live
    //static var stripeKey = "pk_test_51J7DFrIWyJFFO2dYlvl6aDAVF17ajBQLHCiimifuVEjo9ilhPWr51KglkxPb1oqY7W8w0Lttrrj9IYti0ol1RaKP00Wwya2QRY" // new test url
    static var Encryption = "#9r*2ytX9@1we7@q"
    static var Encyption_Initial_Vector = "$%gf!39s*2yRdVg0"
    static var BearerToken = "Bearer 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"
    
    static var BearerTokenKey = "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"
}

var googleMapstyle = """
    [
      {
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#1d2c4d"
          }
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#8ec3b9"
          }
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#1a3646"
          }
        ]
      },
      {
        "featureType": "administrative.country",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#4b6878"
          }
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#64779e"
          }
        ]
      },
      {
        "featureType": "administrative.province",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#4b6878"
          }
        ]
      },
      {
        "featureType": "landscape.man_made",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#334e87"
          }
        ]
      },
      {
        "featureType": "landscape.natural",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#023e58"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#283d6a"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#6f9ba5"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#1d2c4d"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry.fill",
        "stylers": [
          {
            "color": "#023e58"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#3C7680"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#304a7d"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#98a5be"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#1d2c4d"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#2c6675"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#255763"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#b0d5ce"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#023e58"
          }
        ]
      },
      {
        "featureType": "transit",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#98a5be"
          }
        ]
      },
      {
        "featureType": "transit",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#1d2c4d"
          }
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "geometry.fill",
        "stylers": [
          {
            "color": "#283d6a"
          }
        ]
      },
      {
        "featureType": "transit.station",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#3a4762"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#0e1626"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#4e6d70"
          }
        ]
      }
    ]
    """
