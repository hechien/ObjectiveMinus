//
//  Minus.h
//  API
//
//  Created by hechien on 民國100/1/13.
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

@property (nonatomic, readonly) NSString *editor_id;
@property (nonatomic, readonly) NSString *reader_id;
@property (nonatomic, readonly) NSString *key;

-(void)CreateGallery;
-(void)UploadItem:(NSString*)filePath;
-(void)SaveGallery:(NSString*)name
       forEditorID:(NSString*)_editor_id
            andKey:(NSString*)key
         withOrder:(NSString*)items;
-(void)GetItems;

@end
