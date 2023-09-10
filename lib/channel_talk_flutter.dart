import 'dart:async';

import 'package:flutter/services.dart';

class ChannelTalk {
  static const MethodChannel _channel = MethodChannel('channel_talk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Boot is a preparation step that loads necessary information to run SDK,
  /// such as user and channel data. Also, you can make detailed settings by setting the boot configuration.
  /// Real-time chats, marketing, and event tracking features can be used after boot.
  ///
  /// iOS: https://developers.channel.io/docs/ios-channelio#boot
  /// Android: https://developers.channel.io/docs/android-channelio#boot
  static Future<bool?> boot({
    required String pluginKey,
    String? memberHash,
    String? memberId,
    String? email,
    String? name,
    String? mobileNumber,
    bool? trackDefaultEvent,
    bool? hidePopup,
    String? language,
  }) {
    Map<String, dynamic> config = {
      'pluginKey': pluginKey,
    };

    if (memberHash != null) {
      config['memberHash'] = memberHash;
    }
    if (memberId != null) {
      config['memberId'] = memberId;
    }
    if (email != null) {
      config['email'] = email;
    }
    if (name != null) {
      config['name'] = name;
    }
    if (mobileNumber != null) {
      config['mobileNumber'] = mobileNumber;
    }
    if (trackDefaultEvent != null) {
      config['trackDefaultEvent'] = trackDefaultEvent;
    }
    if (hidePopup != null) {
      config['hidePopup'] = hidePopup;
    }
    if (language != null) {
      config['language'] = language;
    }

    return _channel.invokeMethod('boot', config);
  }

  /// Only the system push notification and event tracking via [track] will be available after sleep.
  /// Real-time chat and marketing popups will not be shown.
  ///
  /// iOS: https://developers.channel.io/docs/ios-channelio#sleep
  /// Android: https://developers.channel.io/docs/android-channelio#sleep
  static Future<bool?> sleep() {
    return _channel.invokeMethod('sleep');
  }

  /// Terminate connection between SDK and Channel.
  ///
  /// > iOS
  ///
  /// shutdown will discontinue features of the SDK will be discontinued.
  /// See About [life cycle](https://developers.channel.io/docs/mobile-about-life-cycle) for more information.
  /// https://developers.channel.io/docs/ios-channelio#shutdown
  ///
  /// > Android
  ///
  /// Removes the connection with the channel established by [boot].
  /// [shutdown] disables all features including the system push notification and event tracking.
  /// To use only system push notification and event tracking, see [sleep].
  /// For example, if a user signs out from your service it is safe to [shutdown] to stop receiving a system push notification.
  /// https://developers.channel.io/docs/android-channelio#shutdown
  ///
  static Future<bool?> shutdown() {
    return _channel.invokeMethod('shutdown');
  }

  /// Displays Channel button on the global screen.
  ///
  /// iOS: https://developers.channel.io/docs/ios-channelio#showchannelbutton
  /// Android: https://developers.channel.io/docs/android-channelio#showchannelbutton
  static Future<bool?> showChannelButton() {
    return _channel.invokeMethod('showChannelButton');
  }

  /// Hide Channel button on the global screen.
  ///
  /// iOS: https://developers.channel.io/docs/ios-channelio#hidechannelbutton
  /// Android: https://developers.channel.io/docs/android-channelio#hidechannelbutton
  static Future<bool?> hideChannelButton() {
    return _channel.invokeMethod('hideChannelButton');
  }

  /// Shows the messenger.
  ///
  /// If you have customized a channel button,
  /// you may use this function to show the messenger when the button is clicked.
  ///
  /// iOS: https://developers.channel.io/docs/ios-channelio#showmessenger
  /// Android: https://developers.channel.io/docs/android-channelio#showmessenger
  static Future<bool?> showMessenger() {
    return _channel.invokeMethod('showMessenger');
  }

  /// Hides the messenger.
  ///
  /// iOS: https://developers.channel.io/docs/ios-channelio#hidemessenger
  /// Android: https://developers.channel.io/docs/android-channelio#hidemessenger
  static Future<bool?> hideMessenger() {
    return _channel.invokeMethod('hideMessenger');
  }

  /// > iOS
  ///
  /// Opens a Chat.
  /// You can open a new one or open an existing chat.
  ///
  /// https://developers.channel.io/docs/ios-channelio#openchat
  ///
  /// > Android
  ///
  /// Opens a chat.
  /// Note that the [openChat] opens a specific chat whereas [showMessenger] shows the messenger.
  /// You can not only open an existing chat but also create a new chat.
  ///
  /// https://developers.channel.io/docs/android-channelio#openchat
  static Future<bool?> openChat({
    String? chatId,
    String? message,
  }) {
    return _channel.invokeMethod(
      'openChat',
      {
        'chatId': chatId,
        'message': message,
      },
    );
  }

  /// Track the user’s event.
  /// See [event tracking](https://developers.channel.io/docs/event) for more details.
  ///
  /// iOS: https://developers.channel.io/docs/ios-channelio#track
  /// Android: https://developers.channel.io/docs/android-channelio#track
  static Future<bool?> track({
    required String eventName,
    Map<String, dynamic>? properties,
  }) {
    Map<String, dynamic> data = {
      'eventName': eventName,
    };

    if (properties != null) {
      data['properties'] = properties;
    }

    return _channel.invokeMethod(
      'track',
      data,
    );
  }

  /// > iOS
  ///
  /// Sets the name of the screen when track is calling.
  /// If you call track before setPage, it will not be reflected in the event.
  ///
  /// https://developers.channel.io/docs/ios-channelio#setpage
  ///
  /// > Android
  ///
  /// Sets a page to show when an event is [track]ed.
  /// The default page name is an Activity name.
  /// However in some cases where the default page does not fit your use case,
  /// for example if you are using Single Activity Architecture with Navigation Component,
  /// you might want to set the page to provide helpful information.
  ///
  /// Note that the page takes effect for events sent after the setPage call.
  /// All events before the setPage call will remain intact.
  ///
  /// [!] The behavior of the [setPage] (null) and [resetPage] () is different.
  /// [setPage] (null) literally sets page as null.
  ///
  /// https://developers.channel.io/docs/android-channelio#setpage
  static Future<bool?> setPage({required page}) {
    return _channel.invokeMethod('setPage', {
      'page': page,
    });
  }

  /// > iOS
  ///
  /// Resets the name of the screen when track is called.
  /// The default value is the name of the ViewController calling the track.
  ///
  /// https://developers.channel.io/docs/ios-channelio#resetpage
  ///
  /// > Android
  ///
  /// Unset a page name set by [setPage].
  /// All page in events sent onwards will be recorded as an Activity name,
  /// which is a default page value.
  ///
  /// https://developers.channel.io/docs/android-channelio#resetpage
  static Future<bool?> resetPage() {
    return _channel.invokeMethod('resetPage');
  }

  /// Updates user information.
  ///
  /// iOS: https://developers.channel.io/docs/ios-channelio#updateuser
  /// Android: https://developers.channel.io/docs/android-channelio#updateuser
  static Future<bool?> updateUser({
    String? name,
    String? mobileNumber,
    String? email,
    String? avatarUrl,
    Map<String, dynamic>? customAttributes,
    String? language,
    List<String>? tags,
  }) {
    return _channel.invokeMethod('updateUser', {
      'name': name,
      'mobileNumber': mobileNumber,
      'email': email,
      'avatarUrl': avatarUrl,
      'customAttributes': customAttributes,
      'language': language,
      'tags': tags,
    });
  }

  /// TODO: Implement "addTags" method
  /// https://developers.channel.io/docs/ios-channelio#addtags
  /// https://developers.channel.io/docs/android-channelio#addtags
  ///
  /// static Future<bool?> addTags({}) {}

  ///　TODO: Implement "removeTags" method
  /// https://developers.channel.io/docs/ios-channelio#removetags
  /// https://developers.channel.io/docs/android-channelio#removetags
  ///
  /// static Future<bool?> removeTags({}) {}

  /// > iOS
  ///
  /// Notifies the change of the device token to Channel.
  ///
  /// https://developers.channel.io/docs/ios-channelio#initpushtoken
  ///
  /// > Android
  ///
  /// Notifies the Channel.io SDK that the Firebase Cloud Messaging(FCM) token has changed.
  ///
  /// https://developers.channel.io/docs/android-channelio#initpushtoken
  static Future<bool?> initPushToken({
    required String deviceToken,
  }) {
    return _channel.invokeMethod('initPushToken', {
      'deviceToken': deviceToken,
    });
  }

  /// > iOS
  ///
  /// Checks the received remote notification was from Channel.
  ///
  /// https://developers.channel.io/docs/ios-channelio#ischannelpushnotification
  ///
  /// > Android
  ///
  /// Checks if the Channel SDK is responsible for processing the push data.
  ///
  /// https://developers.channel.io/docs/android-channelio#ischannelpushnotification
  static Future<bool?> isChannelPushNotification({
    required Map<String, dynamic> content,
  }) {
    return _channel.invokeMethod('isChannelPushNotification', {
      'content': content,
    });
  }

  /// > iOS
  ///
  /// Notifies to Channel that the user received a push notification.
  ///
  /// https://developers.channel.io/docs/ios-channelio#receivepushnotification
  ///
  /// > Android
  ///
  /// Shows a system push notification and notifies Channel that a user received a push notification.
  ///
  /// https://developers.channel.io/docs/android-channelio#receivepushnotification
  static Future<bool?> receivePushNotification({
    required Map<String, dynamic> content,
  }) {
    return _channel.invokeMethod('receivePushNotification', {
      'content': content,
    });
  }

  /// (iOS only)
  ///
  /// Store remote notification information on the device.
  ///
  /// https://developers.channel.io/docs/ios-channelio#storepushnotification
  static Future<bool?> storePushNotification({
    required Map<String, dynamic> content,
  }) {
    return _channel.invokeMethod('storePushNotification', {
      'content': content,
    });
  }

  /// > iOS
  ///
  /// Check if there is a stored push notification from Channel.
  ///
  /// https://developers.channel.io/docs/ios-channelio#hasstoredpushnotification
  ///
  /// > Android
  ///
  /// Checks if there exists a push data passed to [receivePushNotification].
  ///
  /// https://developers.channel.io/docs/android-channelio#hasstoredpushnotification
  static Future<bool?> hasStoredPushNotification() {
    return _channel.invokeMethod('hasStoredPushNotification');
  }

  /// > iOS
  ///
  /// Open chat according to the push data stored by [receivePushNotification].
  ///
  /// https://developers.channel.io/docs/ios-channelio#openstoredpushnotification
  ///
  /// > Android
  ///
  /// Opens a chat according to the push data received by [receivePushNotification].
  /// Call this method at the Activity which is launched when the push notification is clicked.
  ///
  /// https://developers.channel.io/docs/android-channelio#openstoredpushnotification
  static Future<bool?> openStoredPushNotification() {
    return _channel.invokeMethod('openStoredPushNotification');
  }

  /// > iOS
  ///
  /// Checks that the SDK is in the boot status.
  ///
  /// https://developers.channel.io/docs/ios-channelio#isbooted
  ///
  /// > Android
  ///
  /// Checks if the latest [boot] succeeded and [shutdown] is not yet called.
  ///
  /// https://developers.channel.io/docs/android-channelio#isbooted
  static Future<bool?> isBooted() {
    return _channel.invokeMethod('isBooted');
  }

  /// > iOS
  ///
  /// Sets SDK’s debug mode.
  /// If it sets true, SDK prints log messages in the console.
  ///
  /// https://developers.channel.io/docs/ios-channelio#setdebugmode
  ///
  /// > Android
  ///
  /// Toggles the debug mode.
  /// If true, log messages will be shown.
  ///
  /// https://developers.channel.io/docs/android-channelio#setdebugmode
  static Future<bool?> setDebugMode({
    required bool flag,
  }) {
    return _channel.invokeMethod('setDebugMode', {
      'flag': flag,
    });
  }
}
