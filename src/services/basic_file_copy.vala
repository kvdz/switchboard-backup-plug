/*
 *   Copyright (C) 2021 Kay van der Zander
 */

 public class Backup.BasicFileCopy {
 
    public int Files_to_copy = 0;   // number of files to be copied to destination
    public int Files_copied = 0;    // number of copied files to destination
    public bool recursive_search = true;

    BasicFileCopy() {
        Files_to_copy = 0;
        Files_copied = 0;
        recursive_search = true;
    }

    public void Run (string source, string destination) {
        MainLoop loop = new MainLoop ();

	    File file1 = File.new_for_path (source);
	    File file2 = File.new_for_path (destination);
		
	    file1.copy_async.begin (file2, 0, Priority.DEFAULT, null, (current_num_bytes, total_num_bytes) => { }, (obj, res) => {
		    try {
			    bool tmp = file1.copy_async.end (res);
			    print ("Result: %s\n", tmp.to_string ());
		    } catch (Error e) {
			    print ("Error: %s\n", e.message);
		    }

		    loop.quit ();
	    });

	    loop.run ();
    }
     
 }
