ObjectiveMinus
====================

A new way to manage your files on http://min.us by iOS Devices or Mac.
---------------------

You can use this to create/upload/get items on http://min.us, the official API page: http://min.us/pages/api

Use it feel free and if you could, please help me make it better and better.

### How to use

#### Installation

Drag API/API/MinusAPI to your project, and copy sources to your project.

It required JSON-framework and ASIHTTPRequest, so you must copy them or download them by yourself.

#### Coding

> Minus *minus = [Minus new];
>
> [minus CreateGallery];
>
>
> -(void)createGalleryFinishedWithResult:(NSDictionary*)result{
>
>   NSLog(@"Create, result: %@", result);
>
>   editorID = [[result objectForKey:@"editor_id"] retain];
>
>   NSString *path = @"/Documents/123.jpg";
>
>   
>
>   [minus UploadItem:[NSString stringWithFormat:@"%@%@", NSHomeDirectory(), path] toEditorID:editorID];
>
> }

More sample please read the APIAppDeleage.m


#### Contact

Twitter: @hechian
Plurk: @hechian
Github: @hechien
Facebook: http://fb.com/hechien
