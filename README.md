ffengine-simple-demo
====================

Demo project for FFEngine from www.ffsdk.com


1) What's FFEngine
FFEngine SDK is a video player framework for iOS developers with support for the http, rtsp, rtmp and mms protocols. 
Behind the scenes FFEngine relies on the iOS AudioToolbox/CoreAudio/CoreGraphics/OpenGLES frameworks and the open source LGPL licensed FFmpeg library.


2) FFEngine Features:
- Support for the http and mms protocols.
- Supports rmvb/mkv/avi/ogg/mp4 file formats.
- Supports mp3, aac, aac+ and wma audio streams.
- PLS, M3U, XSPF and direct URL support.
- Parsing of Shoutcast/Icecast metadata.
- Automatic handling of interruptions like incoming phone calls.
- Background play on iOS 4.
- Robust error handling.
- Auto reconnect feature.
- Works on Edge/3G/WiFi.


3) FFEngine Issues:
- Play m3u8/mp4 files with system default player to enhance performance.
- Could not play certain rtsp streams, updating.

4) Compile your own FFmpeg.framework
- 4.1) Compile raw ffmpeg libs with scripts at: https://github.com/xiewei-wayne/ffmpeg-ios-compile
- 4.2) Download ffmpeg wrapper source code at: https://github.com/xiewei-wayne/libffmpeg
- 4.3) Copy libs/headers generated at step 4.1 to related directories in libffmpeg
- 4.4) Release framework: Xcode -> Product -> Build For -> Profiling;
- 4.5) Debug framework: Xcode -> Product -> Build For -> Testing;

5) How to use
- 5.1) Add FFmpeg.framework and FFEngine.framework to your project.
- 5.2) Call ReginsterFFEngine() in your app delegate method.
- 5.3) Add play methods to your project, please read the ffengine-simple-demo project.
- 5.4) Add -ObjC to 'Other link flags' of your project, build & have fun!


99) Commercial Support
If you need any commercial support, please mail to: xiewei.max@gmail.com

Thanks.


