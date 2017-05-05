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
    private Gtk.ProgressBar bar;
    private Settings settings;

    public Plug () {
        Object (category: Category.SYSTEM,
                code_name: "Backup-plug",
                display_name: _("Backup"),
                description: _("Backup utility, makes copy of important files"),
                icon: "drive-harddisk");
        settings = new Settings ("org.pantheon.switchboard.plug.backup");
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

        /* DOCUMENTS UI SWITCH */
        Gtk.Switch document_switch = new Gtk.Switch ();
        document_switch.state = settings.get_boolean ("document");
        Gtk.Label  document_label = new Gtk.Label (_("Documents:"));
        document_label.margin_right = 24;

        main_grid.attach (document_label, 1, 1, 1, 1);
        main_grid.attach_next_to (document_switch, document_label, Gtk.PositionType.RIGHT, 2, 1);

        /* PICTURE UI SWITCH */
        Gtk.Switch picture_switch = new Gtk.Switch ();
        picture_switch.state = settings.get_boolean ("picture");
        Gtk.Label  picture_label = new Gtk.Label (_("Pictures:"));
        picture_label.margin_right = 24;

        main_grid.attach (picture_label, 1, 2, 1, 1);
        main_grid.attach_next_to (picture_switch, picture_label, Gtk.PositionType.RIGHT, 2, 1);

        /* VIDEO UI SWITCH */
        Gtk.Switch video_switch = new Gtk.Switch ();
        video_switch.state = settings.get_boolean ("video");
        Gtk.Label  video_label = new Gtk.Label (_("Video:"));
        video_label.margin_right = 24;

        main_grid.attach (video_label, 1, 3, 1, 1);
        main_grid.attach_next_to (video_switch, video_label, Gtk.PositionType.RIGHT, 2, 1);

        /* AUDIO UI SWITCH */
        Gtk.Switch audio_switch = new Gtk.Switch ();
        audio_switch.state = settings.get_boolean ("audio");
        Gtk.Label  audio_label = new Gtk.Label (_("Audio:"));
        audio_label.margin_right = 24;

        main_grid.attach (audio_label, 1, 4, 1, 1);
        main_grid.attach_next_to (audio_switch, audio_label, Gtk.PositionType.RIGHT, 2, 1);

        /* BACKUP BUTTON */
        Gtk.Button backup_button = new Gtk.Button.with_label (_("Start"));
        backup_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        main_grid.attach (backup_button, 5, 5, 1, 1);

        /* progressbar */
        bar = new Gtk.ProgressBar ();
        bar.margin_right = 12;
        main_grid.attach (bar, 0, 5, 4, 1);


        /* SWITCH CONNECTIONS */
        document_switch.notify["active"].connect (() => {
			if (document_switch.active) {
				settings.set_boolean ("document", true);
			} else {
				settings.set_boolean ("document", false);
			}
		});

        picture_switch.notify["active"].connect (() => {
			if (picture_switch.active) {
				settings.set_boolean ("picture", true);
			} else {
				settings.set_boolean ("picture", false);
			}
		});

        video_switch.notify["active"].connect (() => {
			if (video_switch.active) {
				settings.set_boolean ("video", true);
			} else {
				settings.set_boolean ("video", false);
			}
		});

        audio_switch.notify["active"].connect (() => {
			if (audio_switch.active) {
				settings.set_boolean ("audio", true);
			} else {
				settings.set_boolean ("audio", false);
			}
		});
    }
}

public Switchboard.Plug get_plug (Module module) {
    debug ("Activating Backup plug");
    var plug = new Backup.Plug ();
    return plug;
}
