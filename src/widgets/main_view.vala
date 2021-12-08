/*
 *   Copyright (C) 2021 Kay van der Zander
 */

 public class Backup.MainView : Gtk.Grid {

    public Backup_manager Backup_manager;

    construct {
        build_UI();
        Backup_manager = new Backup_manager()
    }

    public void build_UI(void) {
        orientation = Gtk.Orientation.VERTICAL;
        margin_bottom = 12;

        this.set_row_spacing (12);
        this.margin_top = 128;
        this.halign = Gtk.Align.CENTER;

        /* BACKUP BUTTON */
        Gtk.Button backup_button = new Gtk.Button.with_label (_("Start backup"));
        backup_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        this.attach (backup_button, 5, 5, 1, 1);

        backup_button.clicked.connect (() => {
			backup_button.set_sensitive(false);
            backup_button_clicked();
		});

        add (main_grid);
        show_all ();
    }

    public void backup_button_clicked() {
        Backup_manager.start_backup();
    }

}

