//
//  InputVideoUrlViewController.m
//  ELPlayer
//
//  Created by Steven Jobs on 12-2-25.
//  Copyright (c) 2012年 xiewei.max@gmail.com. All rights reserved.
//

#import "InputVideoUrlViewController.h"
#import "ELPlayerViewController.h"
#import "MBProgressHUD.h"

@implementation InputVideoUrlViewController
@synthesize searchBar = _searchBar;
@synthesize urlHistory = _urlHistory;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"self.searchBar = %@", self.searchBar);
    
    self.tableView.tableHeaderView = self.searchBar;

    self.urlHistory = [NSMutableArray arrayWithCapacity: 20];

    [_urlHistory addObject: @"http://www.auby.no/files/video_tests/h264_720p_hp_5.1_6mbps_ac3_unstyled_subs_planet.mkv"];

    [_urlHistory addObject: @"rtmp://rtmp.sctv.com/SRT_Live/KBTV_800"];
    [_urlHistory addObject: @"rtmp://media.csjmpd.com/live/live1"];

    [_urlHistory addObject: @"http://192.168.1.100/mt.avi"];

    [_urlHistory addObject: @"http://v1.cztv.com/channels/101/500.flv"];    // 可以播放
    [_urlHistory addObject: @"http://61.55.169.19:8080/live/38"];
    
    [_urlHistory addObject: @"rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=372"];
    [_urlHistory addObject: @"rtsp://202.85.219.140:554/live/1/9E439E5AC836FB1D/ZaF56zkhgyeiuS02.sdp?id=13588888888&t=1342602325&en=ffa1bd635472c3a24248a27824a77007"];
    
    
    /*
     频道   RTSP
     HBO   rtsp://115.182.51.139/tv/HBO.sdp
     星空卫视   rtsp://115.182.51.139/tv/XingKongWeiShi.sdp
     探索发现   rtsp://115.182.51.139/tv/TanSuoFaXian.sdp
     高尔夫网球   rtsp://115.182.51.139/tv/golf.sdp
     凤凰卫视   rtsp://115.182.51.139/tv/FengHuangZhongWen.sdp
     法国时装   rtsp://115.182.51.139/tv/FaGuoShiZhuang.sdp
     */
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.urlHistory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [self.urlHistory objectAtIndex: indexPath.row];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.searchBar.text = [self.urlHistory objectAtIndex: indexPath.row];
    
    [self.searchBar becomeFirstResponder];
}

#pragma mark - detecting thread, just for demo use

-(void) detectUrlSupportFinished: (NSDictionary *) mediaInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    // can not get media info
    if (nil == mediaInfo)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: nil message: @"file not supported, maybe it contains dolby technologies."
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
        ELPlayerViewController *playerViewController = [[[ELPlayerViewController alloc] initWithNibName: @"ELPlayerViewController" bundle: nil] autorelease];
        playerViewController.videoUrl = self.searchBar.text;
        [self.navigationController pushViewController:playerViewController animated:NO];
    }
}

-(void) detectUrlSupported: (NSString *) url
{
    // sync method, should call in thread
    // get media info
    NSDictionary *mediaInfo = [ELMediaUtil getMediaDescription: url];
    NSLog(@"mediaInfo = %@", mediaInfo);
    
    [self performSelectorOnMainThread: @selector(detectUrlSupportFinished:) withObject: mediaInfo waitUntilDone: YES];
}

#pragma mark - searchbar delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    if (0 >= [searchBar.text length]) 
    {
        return;
    }

    // add to table item list
    if (![self.urlHistory containsObject: searchBar.text]) 
    {
        [self.urlHistory addObject: searchBar.text];
    }

    // refresh table
    [self.tableView reloadData];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: self.view animated: YES];
    hud.labelText = @"Detecting...";
    
    // you should add a hud to your window here.
    // MBProgressHUD: https://github.com/jdg/MBProgressHUD/network
    [self performSelectorInBackground: @selector(detectUrlSupported:) withObject: searchBar.text];
}

@end
