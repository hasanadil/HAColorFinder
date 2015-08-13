# HAColorFinder
This is a delightful library which takes as input an NSImage and return the NSColor instance which represents the color which is most dominant acorss all the pixels of the image.

### Installation
1. Clone this repository.
2. Add the following files into your project. 
  * HAColorFinder.h/.m
  * HATrie.h/.m
  * HATrieNode.h/.m
  * HAColorComponents.h/.m
  * HAColorComponentsCount.h/.m
3. Please do not delete the attribution with the files above :)

Once added, in the source where you wish you determine an image's dominant color. Simply import the HAColorFinder.h file and invoke the following method:
-(void) fetchDominantColorFromImage:(NSImage*)image withCompletion:(void(^)(NSColor *color, NSTimeInterval processingTime))completion;

Note. The method above runs completely in the background and you can continue to work on the main thread while the color is being determined. The completion block is called on the main thread.

# Example app
A mac app which uses HAColorFinder library to determine the dominant color within an image. Simply drag an image onto the app and a color well shows the color within a few milliseconds.

# Made by
Hasan Adil
@dispatch_hasan

### MIT License
