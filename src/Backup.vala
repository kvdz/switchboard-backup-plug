using Gtk;
public class Strongroom : Pantheon.Switchboard.Plug {


    private CheckButton docs;
    private CheckButton pics;
    private Label selectedfolder;
    string destination;

    public Strongroom () {
	// set up boxes
	var vbox = new Box (Orientation.VERTICAL, 10);
	var hbox = new Box (Orientation.HORIZONTAL, 10);

	// Create some chechboxes, more are added later
        this.docs = new CheckButton.with_label ("Documents");
	this.pics = new CheckButton.with_label ("Pictures");

	//add buttons
	var folder = new Button.with_label ("Choose Folder");
	folder.clicked.connect (location);
	
	var backup = new Button.with_label ("Backup!");
	backup.clicked.connect (run);

	// Add everything to the window

	hbox.add(folder);
	hbox.add(backup);
  	vbox.add(pics);
	vbox.add(docs);
	vbox.add(selectedfolder);
	vbox.add(hbox);
	
	this.add(vbox);
	
	

	 }
	 
    private void location () {
	var folder_chooser = new FileChooserDialog ("Select Folder", this,FileChooserAction.SELECT_FOLDER,Stock.CANCEL, 
	ResponseType.CANCEL,Stock.OPEN, ResponseType.ACCEPT);
        if (folder_chooser.run () == ResponseType.ACCEPT) {
            destination = (folder_chooser.get_filename ());
	    this.selectedfolder = new Label (destination);
        }
        folder_chooser.destroy ();
    }
    
    private void run () {
	    bool pic = pics.active;
	    if (pic = true)  {
	        var file = File.new_for_path (GLib.Environment.get_home_dir());
	        var folder = file.get_child ("Pictures");
	        var path = File.new_for_path (destination);
	        try {
	            folder.copy (path, FileCopyFlags.NONE);
	        } catch (Error e) {
            stderr.printf ("Error: %s\n", e.message);
	        }
        }
    }
}


public static int main (string[] args) {

    Gtk.init (ref args);
    var plug = new Strongroom ();
    plug.register ("Backup");
    plug.show_all ();
    Gtk.main ();
    return 0;
}
