//
//  Minus.h
//  API
//
//  Created by hechien on 民國100/1/13.
//  Copyright 100 凱鈿行動科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"


@interface Minus : NSObject <ASIHTTPRequestDelegate> {
  NSString *version;
  NSURL *createURL;
  NSURL *uploadURL;
  NSURL *saveURL;
  NSURL *getItemsURL;
  
  NSString *editor_id;
  NSString *reader_id;
  NSString *key;
  
@private
    
}

-(void)CreateGallery;
-(void)UploadItem:(NSString*)filePath;
-(void)SaveGallery;
-(void)GetItems;

@end
