//
//  APIAppDelegate.m
//  API
//
//  Created by hechien on 民國100/1/13.
//

#import "APIAppDelegate.h"

@implementation APIAppDelegate


@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // Override point for customization after application launch.
  
  minus = [Minus new];
  [minus setDelegate: self];
  [minus CreateGallery];
  
  
  
  [self.window makeKeyAndVisible];
  return YES;
}

#pragma mark -
#pragma mark Minus Delegate

-(void)createGalleryFinishedWithResult:(NSDictionary*)result{
  NSLog(@"Create, result: %@", result);
  editorID = [[result objectForKey:@"editor_id"] retain];
  NSString *path = @"/Documents/123.jpg";
  
  [minus UploadItem:[NSString stringWithFormat:@"%@%@", NSHomeDirectory(), path]
         toEditorID:editorID];
}

-(void)createGalleryFailedWithError:(NSError*)error{
  NSLog(@"Well... something going wrong.");
}

-(void)uploadFileFinishedWithResult:(NSDictionary*)result{
  NSLog(@"Images uploaded with result: %@", result);
  [minus getItemsByID:editorID];
}

-(void)uploadFileFailedWithError:(NSError *)error{
  NSLog(@"Oops... Upload failed with error: %@", error);
}

-(void)saveGalleryFinished{
  
}

-(void)saveGalleryFailedWithError:(NSError*)error{
  
}

-(void)galleryItemsResult:(NSDictionary*)result{
  NSLog(@"Gallery Items: %@", result);
}

-(void)galleryItemsFailedWithError:(NSError*)error{
  NSLog(@"Failed to get gallery items");
}

#pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Save data if appropriate.
}

- (void)dealloc {

  [window release];
    [super dealloc];
}

@end
