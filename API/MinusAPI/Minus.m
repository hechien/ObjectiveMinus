//
//  Minus.m
//  API
//
//  Created by hechien on 民國100/1/13.
//

#import "Minus.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"

@implementation Minus
@synthesize delegate;
@synthesize editor_id, reader_id, key;

-(Minus*)init{
  if((self = [super init])){
    NSString *baseURL = @"http://min.us/api";
    createURL = [[NSURL URLWithString:
                 [NSString stringWithFormat:@"%@/CreateGallery", baseURL]] retain];
    uploadURL = [[NSURL URLWithString:
                 [NSString stringWithFormat:@"%@/UploadItem", baseURL]] retain];
    saveURL   = [[NSURL URLWithString:
                 [NSString stringWithFormat:@"%@/SaveGallery", baseURL]] retain];
    getItemsURL = [[NSURL URLWithString:
                 [NSString stringWithFormat:@"%@/GetItems", baseURL]] retain];
    
    editor_id = @"";
    reader_id = @"";
    key = @"";
    delegate = nil;
  }
  return self;
}

#pragma mark -
#pragma mark API messages

-(void)CreateGallery{
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL: createURL];
  [request startSynchronous];
  NSError *error = [request error];
  if(!error){
    NSString *response = [request responseString];
    
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *result = [json objectWithString:response];
    
    if(delegate){
      [delegate createGalleryFinishedWithResult:result];
    }
  }else{
    if(delegate){
      [delegate createGalleryFailedWithError:error];
    }
  }
}

-(void)UploadItem:(NSString*)filePath
       toEditorID:(NSString*)_editor_id{
  NSString *appendPath = [NSString stringWithFormat: \
                          @"?editor_id=%@&key=%@&filename=%@", \
                          _editor_id, key, [filePath lastPathComponent]];
  NSURL *_uploadTo = [NSURL URLWithString:
                      [NSString stringWithFormat:@"%@%@", \
                       [uploadURL absoluteString], appendPath]];
  ASIFormDataRequest *form = [ASIFormDataRequest requestWithURL:_uploadTo];
  NSData *fileContent = [[[NSData alloc] initWithContentsOfFile:filePath] autorelease];
  
  [form setPostBody:(NSMutableData*)fileContent];
  [form setDelegate:self];
  [form setDidFailSelector:@selector(uploadFailed:)];
  [form setDidFinishSelector:@selector(uploadFinished:)];
  [form startAsynchronous];
}

-(void)SaveGallery:(NSString*)name
       forEditorID:(NSString*)_editor_id
            andKey:(NSString*)_key
        withOrder:(NSString*)items{
  // Not yet finished.
  // Parameters
  // - name
  // - id
  // - key
  // - items
  
  if([_editor_id length] < 1) _editor_id = editor_id;
  if([_key length] < 1) _key = key;
  
//  _editor_id = [NSString stringWithFormat:@"m%@", _editor_id];
  
  NSLog(@"Parameters:\n");
  NSLog(@"name=%@", name);
  NSLog(@"id=%@", _editor_id);
  NSLog(@"key=%@", _key);
  NSLog(@"items=%@", items);
  
  ASIFormDataRequest *form = [ASIFormDataRequest requestWithURL:saveURL];
  [form addPostValue:name forKey:@"name"];
  [form addPostValue:_editor_id forKey:@"id"];
  [form addPostValue:_key forKey:@"key"];
  [form addPostValue:items forKey:@"items"];
  
  
  [form setDelegate:self];
  [form setDidFailSelector:@selector(saveGalleryFailed:)];
  [form setDidFinishSelector:@selector(saveGalleryFinished:)];
  [form startAsynchronous];
}

-(void)GetItemsByID:(NSString*)_id{
  NSURL *getURL = [NSURL URLWithString:
                   [[getItemsURL absoluteString] 
                    stringByAppendingFormat:@"/m%@", _id]];
  
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL: getURL];
  [request startSynchronous];
  NSError *error = [request error];
  if(!error){
    NSString *response = [request responseString];
    
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *result = [json objectWithString:response];
    
    if(delegate){
      [delegate galleryItemsResult:result];
    }
  }else{
    if(delegate){
      [delegate galleryItemsFailedWithError:error];
    }
  }
}

#pragma mark -
#pragma mark ASIHTTPRequest Delegates

#pragma mark -
#pragma mark ASIFormDataRequest Delegates

-(void)uploadFailed:(ASIHTTPRequest*)theRequest{  
  if(delegate){
    [delegate uploadFileFailedWithError:[theRequest error]];
  }
}

-(void)uploadFinished:(ASIHTTPRequest*)theRequest{
  SBJSON *json = [[SBJSON new] autorelease];
  NSString *response = [theRequest responseString];
  NSDictionary *result = [json objectWithString:response];
  
  if(delegate){
    [delegate uploadFileFinishedWithResult:result];
  }
}

-(void)saveGalleryFailed:(ASIHTTPRequest*)theRequest{  
  if(delegate){
    [delegate saveGalleryFailedWithError:[theRequest error]];
  }
}

-(void)saveGalleryFinished:(ASIHTTPRequest*)theRequest{
  SBJSON *json = [[SBJSON new] autorelease];
  NSString *response = [theRequest responseString];
  NSDictionary *result = [json objectWithString:response];
  
  if(delegate){
    [delegate saveGalleryFinished];
  }
}

#pragma mark -

-(void)dealloc{
  [super dealloc];
  [createURL release];
  [uploadURL release];
  [saveURL release];
  [getItemsURL release];
}


@end
