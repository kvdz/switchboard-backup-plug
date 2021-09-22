/*
 *   Copyright (C) 2021 Kay van der Zander
 */

 public class Backup.BasicFileCopy {
 
    public int Number_of_files_to_copy = 0;   // number of files to be copied to destination
    public int Number_of_files_copied = 0;    // number of copied files to destination
    public bool recursive_search = true;

    BasicFileCopy() {
        Number_of_files_to_copy = 0;
        Number_of_files_copied = 0;
        recursive_search = true;
    }


	private void list_files_recursive (string dir, List<string> files ) {
		try {
			Dir dir = Dir.open(dir, 0);
			string? name = null;

			while ((name = dir.read_name ()) != null) {
				string path = Path.build_filename (dir, name);

				if (FileUtils.test (path, FileTest.IS_DIR)) {
					print ("%s\t%s\n", name, "| DIR ");
					list_files_recursive(path, files);
				} else {
					print ("%s\t%s\n", name, "| REGULAR ");
					files.append(path);
				}
			}
		} catch (FileError err) {
			stderr.printf (err.message);
		}
	}
	
    public void Execute (string source, string destination) {
        MainLoop loop = new MainLoop ();

		List<string> files_to_copy;
		list_files_recursive(source, files_to_copy);
		Number_of_files_to_copy = files_to_copy.length();

		
		foreach (var file in files_to_copy){

	    	file.copy_async.begin (file2, 0, Priority.DEFAULT, null, null, (obj, res) => {
		    	try {
			    	bool tmp = file1.copy_async.end (res);
			    	print ("Result: %s\n", tmp.to_string ());
					Number_of_files_copied += 1;
		    	} catch (Error e) {
			    	print ("Error: %s\n", e.message);
		    	}

		    	loop.quit ();
	    	});
		
			loop.run ();
		}
    }


 }
