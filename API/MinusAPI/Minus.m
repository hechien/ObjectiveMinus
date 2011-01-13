//
//  Minus.m
//  API
//
//  Created by hechien on 民國100/1/13.
//  Copyright 100 凱鈿行動科技. All rights reserved.
//

#import "Minus.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"

@implementation Minus

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
    NSLog(@"Response: %@", response);
    
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *result = [json objectWithString:response];
    editor_id = [[result objectForKey:@"editor_id"] retain];
    reader_id = [[result objectForKey:@"reader_id"] retain];
    key = [[result objectForKey:@"key"] retain];
    
    NSLog(@"JSON: %@", result);
  }
  [error release];
//  [request release];
}

-(void)UploadItem:(NSString*)filePath{
  NSString *appendPath = [NSString stringWithFormat: \
                          @"?editor_id=%@&key=%@&filename=%@", \
                          editor_id, key, [filePath lastPathComponent]];
  NSURL *_uploadTo = [NSURL URLWithString:
                      [NSString stringWithFormat:@"%@%@", \
                       [uploadURL absoluteString], appendPath]];
  NSLog(@"File will be uploaded to: %@", [_uploadTo absoluteString]);
  ASIFormDataRequest *form = [ASIFormDataRequest requestWithURL:_uploadTo];
  NSData *fileContent = [[NSData alloc] initWithContentsOfFile:filePath];
  
  [form setPostBody:(NSMutableData*)fileContent];
  [form setDelegate:self];
  [form setDidFailSelector:@selector(uploadFailed:)];
  [form setDidFinishSelector:@selector(uploadFinished:)];
  [form startAsynchronous];
}

-(void)SaveGallery{
  
}

-(void)GetItems{
  
}

#pragma mark -
#pragma mark ASIHTTPRequest Delegates

#pragma mark -
#pragma mark ASIFormDataRequest Delegates

-(void)uploadFailed:(ASIHTTPRequest*)theRequest{
  NSLog(@"Failed: %@", [theRequest error]);
}

-(void)uploadFinished:(ASIHTTPRequest*)theRequest{
  NSLog(@"Upload finished.");
  SBJSON *json = [[SBJSON new] autorelease];
  NSString *response = [theRequest responseString];
  NSDictionary *result = [json objectWithString:response];
  NSLog(@"Response: %@", response);
  NSLog(@"Result: %@", result);
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
