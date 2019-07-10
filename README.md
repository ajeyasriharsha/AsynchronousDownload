# AsynchronousDownload

func setImage(views:[UIView]?,downloadingImage:String, downloadingImageView: UIImageView)

This Function accepts an array of views along with the downloadable URL String whin in turn inititates the download from the URL and updates the imageview with the downloaded Image and the UI is updated on the main thread and the download operations have been performed on the Background not to freeze the UI.

UIViewControllerExtension This has been created to add a loading indicator on the passing parent and the same can be removed using the created helper methods.

AsyncImageView This class represents the asynchronous download with an including completion handler which passes the downloaded image data and a boolean representing success or a failure of the download operation

The downloaded images are saved to the cache so that the same would be return if it is in the cache or new download would be initiated.
