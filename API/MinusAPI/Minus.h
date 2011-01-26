//
//  Minus.h
//  API
//
//  Created by hechien on 民國100/1/13.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"


@interface Minus : NSObject <ASIHTTPRequestDelegate> {
  
  id delegate;
  
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

@property (nonatomic, retain) id delegate;
@property (nonatomic, readonly) NSString *editor_id;
@property (nonatomic, readonly) NSString *reader_id;
@property (nonatomic, readonly) NSString *key;

-(void)CreateGallery;
-(void)UploadItem:(NSString*)filePath 
       toEditorID:(NSString*)_editor_id;

-(void)SaveGallery:(NSString*)name
       forEditorID:(NSString*)_editor_id
            andKey:(NSString*)key
         withOrder:(NSString*)items;
-(void)getItemsByID:(NSString*)_id;

@end

@protocol MinusDelegate <NSObject>

@required

-(void)createGalleryFinishedWithResult:(NSDictionary*)result;
-(void)createGalleryFailedWithError:(NSError*)error;

-(void)uploadFileFinishedWithResult:(NSDictionary*)result;
-(void)uploadFileFailedWithError:(NSError*)error;

-(void)saveGalleryFinished;
-(void)saveGalleryFailedWithError:(NSError*)error;

-(void)galleryItemsResult:(NSDictionary*)result;
-(void)galleryItemsFailedWithError:(NSError*)error;

@end