A class that can turn an empty view into an iBooks like page turning view. Each page is a full UIViewController, and the curl follows your finger (rotation included).

This is a pretty simple project; the code was written for a client, so I've obviously stripped all of their data out and put in some Mark Twain. They wanted a page turning effect, but iBooks uses a private API and the other options didn't rotate or look good enough.

Add the "book/" directory to your project.

The "ExampleView" is a subclass of SMBookController and where the pages appear (any back image has to be in a separate view or the controller will delete it).

"PageView" is an example of a page. This project only uses on page view and modifies the data for each page. You can easily add different pages nibs.

Check out the screenshots.