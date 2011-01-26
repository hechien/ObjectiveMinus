//
//  APIAppDelegate.h
//  API
//
//  Created by hechien on 民國100/1/13.
//

#import <UIKit/UIKit.h>
#import "Minus.h"

@interface APIAppDelegate : NSObject <UIApplicationDelegate, MinusDelegate> {
@private
  
  Minus *minus;
  NSString *editorID;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
