/*
 *   Copyright (C) 2021 Kay van der Zander
 */

public class Backup.Plug : Switchboard.Plug {
    private MainView main_view;

    public Plug () {
        Object (category: Category.SYSTEM,
                code_name: "Backup-plug",
                display_name: _("Backup"),
                description: _("Backup utility, makes copy of important files"),
                icon: "drive-harddisk");
    }

    public override Gtk.Widget get_widget () {
        if (main_view == null) {
            main_view = new MainView();
        }

        return main_view;
    }

    public override void shown () {
        main_view.show_all ();
    }

    public override void hidden () {
        main_view.hide ();
    }

    public override void search_callback (string location) {

    }

    // 'search' returns results like ("Keyboard → Behavior → Duration", "keyboard<sep>behavior")
    public override async Gee.TreeMap<string, string> search (string search) {
        var search_results = new Gee.TreeMap<string, string> ((GLib.CompareDataFunc<string>)strcmp, (Gee.EqualDataFunc<string>)str_equal);
        search_results.set ("%s → %s".printf (display_name, _("copy")), "");
        search_results.set ("%s → %s".printf (display_name, _("Backup")), "");
        return search_results;
    }
}

public Switchboard.Plug get_plug (Module module) {
    debug ("Activating Backup plug");
    var plug = new Backup.Plug ();
    return plug;
}
