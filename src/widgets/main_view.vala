

 public class Backup.MainView : Gtk.Grid {

    construct {
        orientation = Gtk.Orientation.VERTICAL;
        margin_bottom = 12;

        this.set_row_spacing (12);
        this.margin_top = 128;
        this.halign = Gtk.Align.CENTER;

        /* BACKUP BUTTON */
        Gtk.Button backup_button = new Gtk.Button.with_label (_("Start backup"));
        backup_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        this.attach (backup_button, 5, 5, 1, 1);

        show_all ();
    }


}
