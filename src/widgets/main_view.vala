/*
 *   Copyright (C) 2021 Kay van der Zander
 */

 public class Backup.MainView : Gtk.Grid {

    construct {
        orientation = Gtk.Orientation.VERTICAL;
        margin_bottom = 12;

        var label_size = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);

        var main_grid = new Gtk.Grid ();
        main_grid.set_row_spacing (12);
        main_grid.margin_top = 128;
        main_grid.halign = Gtk.Align.CENTER;

        /* BACKUP BUTTON */
        Gtk.Button backup_button = new Gtk.Button.with_label (_("Start backup"));
        backup_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        main_grid.attach (backup_button, 5, 5, 1, 1);

        add (main_grid);
        show_all ();
    }

    
}