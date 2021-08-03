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

public class Backup.Plug : Switchboard.Plug {
    private Gtk.Grid main_grid;

    public Plug () {
        Object (category: Category.SYSTEM,
                code_name: "Backup-plug",
                display_name: _("Backup"),
                description: _("Backup utility, makes copy of important files"),
                icon: "drive-harddisk");
    }

    public override Gtk.Widget get_widget () {
        if (main_grid == null) {
            setup_ui ();
        }

        return main_grid;
    }

    public override void shown () {
        main_grid.show_all ();
    }

    public override void hidden () {
        main_grid.hide ();

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

    private void setup_ui () {
        main_grid = new Gtk.Grid ();
        main_grid.set_row_spacing (12);
        main_grid.margin_top = 128;
        main_grid.halign = Gtk.Align.CENTER;

        /* BACKUP BUTTON */
        Gtk.Button backup_button = new Gtk.Button.with_label (_("Start backup"));
        backup_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        main_grid.attach (backup_button, 5, 5, 1, 1);

    }
}

public Switchboard.Plug get_plug (Module module) {
    debug ("Activating Backup plug");
    var plug = new Backup.Plug ();
    return plug;
}
