//
//  ExampleViewController.m
//  Pages
//
//  Created by Stuart Moore on 5/2/11.
//  Copyright 2011 Intentionally Blank. All rights reserved.
//

#import "ExampleViewController.h"

@implementation ExampleViewController

- (void)viewDidLoad
{
	page = 0;
    pageFrame = CGRectMake(0, 8, 746, 987);
    touchFrame = self.view.frame;
}

- (UIViewController*)pageAtIndex:(NSUInteger)index
{
    PageViewController *pageTemplate = [[PageViewController alloc] init];
    [[pageTemplate view] setFrame:pageFrame];
    [pageTemplate setParentController:self];	
    pageTemplate.pageNumLabel.text = [NSString stringWithFormat:@"%d", index+1];
    if(index == 0)
        pageTemplate.textLabel.text = @"CHAPTER I.\n\
        \n\
        YOU don\'t know about me without you have read a book by the name of The Adventures of Tom Sawyer; but that ain\'t no matter.  That book was made by Mr. Mark Twain, and he told the truth, mainly.  There was things which he stretched, but mainly he told the truth.  That is nothing.  I never seen anybody but lied one time or another, without it was Aunt Polly, or the widow, or maybe Mary.  Aunt Polly—Tom's Aunt Polly, she is—and Mary, and the Widow Douglas is all told about in that book, which is mostly a true book, with some stretchers, as I said before.\n\
        \n\
        Now the way that the book winds up is this:  Tom and me found the money that the robbers hid in the cave, and it made us rich.  We got six thousand dollars apiece—all gold.  It was an awful sight of money when it was piled up.  Well, Judge Thatcher he took it and put it out at interest, and it fetched us a dollar a day apiece all the year round—more than a body could tell what to do with.  The Widow Douglas she took me for her son, and allowed she would sivilize me; but it was rough living in the house all the time, considering how dismal regular and decent the widow was in all her ways; and so when I couldn't stand it no longer I lit out.  I got into my old rags and my sugar-hogshead again, and was free and satisfied.  But Tom Sawyer he hunted me up and said he was going to start a band of robbers, and I might join if I would go back to the widow and be respectable.  So I went back.";	
    if(index == 1)
        pageTemplate.textLabel.text = @"The widow she cried over me, and called me a poor lost lamb, and she called me a lot of other names, too, but she never meant no harm by it. She put me in them new clothes again, and I couldn't do nothing but sweat and sweat, and feel all cramped up.  Well, then, the old thing commenced again.  The widow rung a bell for supper, and you had to come to time. When you got to the table you couldn't go right to eating, but you had to wait for the widow to tuck down her head and grumble a little over the victuals, though there warn't really anything the matter with them,—that is, nothing only everything was cooked by itself.  In a barrel of odds and ends it is different; things get mixed up, and the juice kind of swaps around, and the things go better.\n\
        \n\
        After supper she got out her book and learned me about Moses and the Bulrushers, and I was in a sweat to find out all about him; but by and by she let it out that Moses had been dead a considerable long time; so then I didn't care no more about him, because I don't take no stock in dead people.\n\
        \n\
        Pretty soon I wanted to smoke, and asked the widow to let me.  But she wouldn't.  She said it was a mean practice and wasn't clean, and I must try to not do it any more.  That is just the way with some people.  They get down on a thing when they don't know nothing about it.  Here she was a-bothering about Moses, which was no kin to her, and no use to anybody, being gone, you see, yet finding a power of fault with me for doing a thing that had some good in it.  And she took snuff, too; of course that was all right, because she done it herself.";
    if(index == 2)
        pageTemplate.textLabel.text = @"Her sister, Miss Watson, a tolerable slim old maid, with goggles on, had just come to live with her, and took a set at me now with a spelling-book. She worked me middling hard for about an hour, and then the widow made her ease up.  I couldn't stood it much longer.  Then for an hour it was deadly dull, and I was fidgety.  Miss Watson would say, \"Don't put your feet up there, Huckleberry;\" and \"Don't scrunch up like that, Huckleberry—set up straight;\" and pretty soon she would say, \"Don't gap and stretch like that, Huckleberry—why don't you try to behave?\"  Then she told me all about the bad place, and I said I wished I was there. She got mad then, but I didn't mean no harm.  All I wanted was to go somewheres; all I wanted was a change, I warn't particular.  She said it was wicked to say what I said; said she wouldn't say it for the whole world; she was going to live so as to go to the good place.  Well, I couldn't see no advantage in going where she was going, so I made up my mind I wouldn't try for it.  But I never said so, because it would only make trouble, and wouldn't do no good.\n\
        \n\
        Now she had got a start, and she went on and told me all about the good place.  She said all a body would have to do there was to go around all day long with a harp and sing, forever and ever.  So I didn't think much of it. But I never said so.  I asked her if she reckoned Tom Sawyer would go there, and she said not by a considerable sight.  I was glad about that, because I wanted him and me to be together.\n\
        \n\
        Miss Watson she kept pecking at me, and it got tiresome and lonesome.";
    if(index == 3)
        pageTemplate.textLabel.text = @"The stars were shining, and the leaves rustled in the woods ever so mournful; and I heard an owl, away off, who-whooing about somebody that was dead, and a whippowill and a dog crying about somebody that was going to die; and the wind was trying to whisper something to me, and I couldn't make out what it was, and so it made the cold shivers run over me. Then away out in the woods I heard that kind of a sound that a ghost makes when it wants to tell about something that's on its mind and can't make itself understood, and so can't rest easy in its grave, and has to go about that way every night grieving.  I got so down-hearted and scared I did wish I had some company.  Pretty soon a spider went crawling up my shoulder, and I flipped it off and it lit in the candle; and before I could budge it was all shriveled up.  I didn't need anybody to tell me that that was an awful bad sign and would fetch me some bad luck, so I was scared and most shook the clothes off of me. I got up and turned around in my tracks three times and crossed my breast every time; and then I tied up a little lock of my hair with a thread to keep witches away.  But I hadn't no confidence.  You do that when you've lost a horseshoe that you've found, instead of nailing it up over the door, but I hadn't ever heard anybody say it was any way to keep off bad luck when you'd killed a spider.\n\
        \n\
        I set down again, a-shaking all over, and got out my pipe for a smoke; for the house was all as still as death now, and so the widow wouldn't know. Well, after a long time I heard the clock away off in the town go boom—boom—boom—twelve licks; and all still again—stiller than ever. Pretty soon I heard a twig snap down in the dark.";
    return pageTemplate;
}

- (NSUInteger)numberOfPages
{
    return 4;
}

@end
