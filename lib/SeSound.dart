import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'dart:io';

enum SeSoundIds {
  Button1,
  Button2,
  Button3,
  Button4,
  Button5,
}

class SeSound {
  String os = Platform.operatingSystem;
  bool isIOS = Platform.isIOS;
  late Soundpool _soundPool;

  final Map<SeSoundIds, int> _seContainer = Map<SeSoundIds, int>();
  final Map<int, int> _streamContainer = Map<int, int>();

  SeSound() {
    // インスタンス生成
    this._soundPool = Soundpool.fromOptions(options: SoundpoolOptions(
        streamType: StreamType.music,
        maxStreams: 5 // 5音同時発音に対応させる
    ));
    // 以降、非同期で実施
        () async {
      // 読み込んだ効果音をバッファに保持
      var button1Id = await rootBundle.load("assets/se/button1.mp3").then((value) => this._soundPool.load(value));
      var button2Id = await rootBundle.load("assets/se/button2.mp3").then((value) => this._soundPool.load(value));
      var button3Id = await rootBundle.load("assets/se/button3.mp3").then((value) => this._soundPool.load(value));
      var button4Id = await rootBundle.load("assets/se/button4.mp3").then((value) => this._soundPool.load(value));
      var button5Id = await rootBundle.load("assets/se/button5.mp3").then((value) => this._soundPool.load(value));
      // バッファに保持した効果音のIDを以下のコンテナに入れておく
      this._seContainer[SeSoundIds.Button1] = button1Id;
      this._seContainer[SeSoundIds.Button2] = button2Id;
      this._seContainer[SeSoundIds.Button3] = button3Id;
      this._seContainer[SeSoundIds.Button4] = button4Id;
      this._seContainer[SeSoundIds.Button5] = button5Id;
      // 効果音を鳴らしたときに保持するためのstreamIdのコンテナを初期化
      // 対象の効果音を強制的に停止する際に使用する
      this._streamContainer[button1Id] = 0;
      this._streamContainer[button2Id] = 0;
      this._streamContainer[button3Id] = 0;
      this._streamContainer[button4Id] = 0;
      this._streamContainer[button5Id] = 0;
    }();
  }

  // 効果音を鳴らすときに本メソッドをEnum属性のSeSoundIdsを引数として実行する
  void playSe(SeSoundIds ids) async {
    // 効果音のIDを取得
    var seId = this._seContainer[ids];
    if (seId != null) {
      // 効果音として存在していたら、以降を実施
      // streamIdを取得
      var streamId = this._streamContainer[seId] ?? 0;
      if (streamId > 0 && isIOS) {
        // streamIdが存在し、かつOSがiOSだった場合、再生中の効果音を強制的に停止させる
        // iOSの場合、再生中は再度の効果音再生に対応していないため、ボタン連打しても再生されないため
        await _soundPool.stop(streamId);
      }
      // 効果音のIDをplayメソッドに渡して再生処理を実施
      // 再生処理の戻り値をstreamIdのコンテナに設定する
      this._streamContainer[seId] = await _soundPool.play(seId);
    } else {
      print("se resource not found! ids: $ids");
    }
  }

  Future<void> dispose() async {
    // 終了時の後始末処理
    await _soundPool.release();
    _soundPool.dispose();
    return Future.value(0);
  }

}