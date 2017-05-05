//
//  Copyright (C) 2017 Kay van der Zander
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

public class BackupManager {
    private Settings settings;
    private GLib.List<File> paths;
    private Cancellable cancellable_backup;

    public uint amount_of_files;
    public uint files_left_to_move;
    public uint size_of_all_files;

    public BackupManager (Settings settings) {
        this.settings = settings;
        paths = new GLib.List<File> ();
    }

    public void start_backup (Cancellable cancellable) {
        cancellable_backup = cancellable;
        search_for_all_files.begin ();
        amount_of_files = paths.length ();
        files_left_to_move = amount_of_files;
        size_of_all_files = calculate_size_of (paths);

    }

    private async void search_for_all_files () {
        //Environment.get_home_dir ();
        var dir = File.new_for_path (settings.get_string ("search-path"));
        try {
            // asynchronous call, to get directory entries
            var e = yield dir.enumerate_children_async (FileAttribute.STANDARD_NAME, FileQueryInfoFlags.NOFOLLOW_SYMLINKS, Priority.DEFAULT, cancellable_backup);

            while (true) {
                // asynchronous call, to get entries so far
                var files = yield e.next_files_async (10, Priority.DEFAULT, cancellable_backup);
                if (files == null) {
                    break;
                }
                // append the files found so far to the list
                files.foreach ((entry) => {
                    
	            });
            }
        } catch (Error err) {
            stderr.printf ("Error: search for files to backup failed: %s\n", err.message);
        }
    }

    private bool check_file_extention (FileInfo file) {
        string file-types = settings.get_string ("file-types");

        return true;
    }

    private uint calculate_size_of (GLib.List<File> list) {
        uint size = 0;
        list.foreach ((file) => {
            var file_info = file.query_info ("*", FileQueryInfoFlags.NONE);
            size += (uint)file_info.get_size ();
	    });
        return size;
    }

}


