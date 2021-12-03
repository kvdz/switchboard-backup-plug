/*
 *   Copyright (C) 2021 Kay van der Zander
 */

 public class Backup.Backup_manager {

    public List<string> Paths = new List<string>("~/Video/", 
                                                "~/Documents",
                                                "~/Pictures");
    public BasicFileCopy basicCopy;
    
    construct {
        basicCopy = new BasicFileCopy();
    }

    public bool start_backup (void) {
        basicCopy.Execute(Paths[0], "/tmp/backup/");
        basicCopy.Execute(Paths[1], "/tmp/backup/");
        basicCopy.Execute(Paths[2], "/tmp/backup/");
    }
 }