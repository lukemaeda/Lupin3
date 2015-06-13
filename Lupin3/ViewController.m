//
//  ViewController.m
//  Lupin3
//
//  Created by MAEDA HAJIME on 2014/03/31.
//  Copyright (c) 2014年 MAEDA HAJIME. All rights reserved.
//
// status barを非表示設定
// Status Bar Style
// Hide during application launch にチェック
// info Plist : View controller-based status bar appearance:NO この項目を追加

#import <AudioToolbox/AudioToolbox.h>
#import "ViewController.h"

// タイトル 定数:const
NSString *const LUPIN_TITLE = @"ルパン三世";

@interface ViewController () {
    
    // システムサウンド
    SystemSoundID _ssId01;
    SystemSoundID _ssId02;
}

// iPhoneラベル
@property (weak, nonatomic) IBOutlet UILabel *lbTitole;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 音準備処理
    [self doReady];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)time:(NSTimer*)timer{
    
    //static:数値が破棄されずに残る 加算される
    static int idx = 0;
    
    // LUPIN_TITLEの文字数
    if (idx  < LUPIN_TITLE.length) {
        
        // １文字処理抜き取り
        // NSMakeRangeと同じ　構造体
        NSRange rng;
        rng.location = idx; // 文字ロケーション
        rng.length = 1;     // １文字
        
        NSString *str = [LUPIN_TITLE substringWithRange:rng]; // 定数：LUPIN_TITLE = @"ルパン三世";
        
        //NSLog(@"%@文字：%d", str, idx);
        
        // １文字処理抜き取り
        self.lbTitole.text = str;
        
        // フォントサイズ変更
        self.lbTitole.font= [UIFont fontWithName:@"Arial Rounded MT Bold" size:200.0f];
        
        // 効果音１再生　カシャ
        AudioServicesPlaySystemSound(_ssId01);
        
        // 文字インデックス
        idx++;
    
        
    } else {
        // 最後の処理
        
        // 全文字ラベル表示
        self.lbTitole.text = @"ルパン三世";
        
        // フォントサイズ変更
        self.lbTitole.font= [UIFont fontWithName:@"Arial Rounded MT Bold" size:100.0f];
        
        // 効果音2再生
        AudioServicesPlaySystemSound(_ssId02);
        
        // タイマー停止
        [timer invalidate];
        
        // 文字インデックス　クリア
        idx = 0;
    }
    
}

// 画面タップ時
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
               
    // タイマー起動
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2
            target:self
            selector:@selector(time:)
            userInfo:nil
            repeats:YES];
               
            [timer fire];
}


// 音準備処理
- (void)doReady {
    
    NSBundle *bnd = [NSBundle mainBundle];
    
    // 設定#01 効果音
    NSURL *url01 = [bnd URLForResource:@"Sound01"
                         withExtension:@"wav"];
    
    CFURLRef urr01 = (CFURLRef) CFBridgingRetain(url01);
    AudioServicesCreateSystemSoundID(urr01, &_ssId01);
    CFRelease(urr01);
    
    // 設定#02 音楽
    NSURL *url02 = [bnd URLForResource:@"Sound02"
                         withExtension:@"wav"];
    
    CFURLRef urr02 = (CFURLRef) CFBridgingRetain(url02);
    AudioServicesCreateSystemSoundID(urr02, &_ssId02);
    CFRelease(urr02);
    
    //NSLog(@"サウンド2");
}

@end