/*-
 * Copyright (c) 2017-2018 Artem Anufrij <artem.anufrij@live.de>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * The Noise authors hereby grant permission for non-GPL compatible
 * GStreamer plugins to be used and distributed together with GStreamer
 * and Noise. This permission is above and beyond the permissions granted
 * by the GPL license by which Noise is covered. If you modify this code
 * you may extend this exception to your version of the code, but you are not
 * obligated to do so. If you do not wish to do so, delete this exception
 * statement from your version.
 *
 * Authored by: Artem Anufrij <artem.anufrij@live.de>
 */

namespace Translit {
    public class MainWindow : Gtk.Window {
        Settings settings;
        TranslitService service;
        GtkSpell.Checker spell;

        Gtk.TextView input;
        Gtk.ToggleButton active_translit;
        Gtk.Box key_map;
        Gtk.Image spell_info;

        public MainWindow () {
            settings = Settings.get_default ();

            build_ui ();

            service = new TranslitService ();
            service.key_map_loaded.connect ((list, spell_lang) => {
                foreach (var item in key_map.get_children ()) {
                    key_map.remove (item);
                }

                foreach (var item in list) {
                    var lab = new Gtk.Label ("%s\n<b>%s</b>".printf(item.key, item.val));
                    lab.use_markup = true;
                    lab.justify = Gtk.Justification.CENTER;
                    key_map.add (lab);
                }
                key_map.show_all ();

                try {
                    spell_info.hide ();
                    spell.set_language (null);
                    spell.set_language (spell_lang);
                } catch (Error e) {
                    warning (e.message);
                    spell_info.show ();
                    spell_info.tooltip_text = _("Spell package couldn't be found.\nInstall [hunspell-%s] dictionary.").printf (spell_lang);
                }
            });

            spell = new GtkSpell.Checker();
            spell.attach (input);

            service.load_dictionary (settings.lang);
            present ();
        }

        private void build_ui () {
            this.width_request = 600;
            this.height_request = 480;
            var content = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            var headerbar = new Gtk.HeaderBar ();
            headerbar.title = _("Translit");
            headerbar.show_close_button = true;
            headerbar.get_style_context ().add_class ("default-decoration");
            this.set_titlebar (headerbar);

            active_translit = new Gtk.ToggleButton ();
            active_translit.valign = Gtk.Align.CENTER;
            active_translit.active = true;
            active_translit.image = new Gtk.Image.from_icon_name ("config-language-symbolic", Gtk.IconSize.MENU);
            active_translit.tooltip_text = _("Disable character transliting");
            active_translit.toggled.connect (() => {
                if (active_translit.active) {
                    active_translit.tooltip_text = _("Disable character transliting");
                } else {
                    active_translit.tooltip_text = _("Enable character transliting");
                }
                this.input.grab_focus ();
            });
            headerbar.pack_start (active_translit);

            var lang_chooser = new Gtk.ComboBoxText ();
            lang_chooser.append ("ru_RU", "Русский");
            lang_chooser.append ("be_BY", "Беларуская");
            lang_chooser.append ("ua_UA", "Українська");
            lang_chooser.active_id = settings.lang;
            lang_chooser.tooltip_text = _("Translit language");
            lang_chooser.changed.connect (() => {
                settings.lang = lang_chooser.active_id;
                service.load_dictionary (settings.lang);
                this.input.grab_focus ();
            });
            headerbar.pack_end (lang_chooser);

            spell_info = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.MENU);
            headerbar.pack_end (spell_info);

            key_map = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);
            key_map.margin = 8;
            key_map.halign = Gtk.Align.CENTER;

            input = new Gtk.TextView ();
            input.wrap_mode = Gtk.WrapMode.WORD;
            input.top_margin = input.left_margin = input.bottom_margin = input.right_margin = 12;
            input.key_press_event.connect ((event) => {
                var input_char = event.str[0].to_string ();
                if (input.buffer.has_selection && input_char[0].isprint ()) {
                    input.buffer.delete_selection (true, true);
                }
                if (active_translit.active) {
                    if (event.str.length == 1 && (input_char[0].isalpha () || event.str.has_prefix ("*") || event.str.has_prefix ("'"))) {
                        string pre_char = "";

                        var mark = input.buffer.get_insert ();
                        Gtk.TextIter current_iter;
                        input.buffer.get_iter_at_mark (out current_iter, mark);

                        var pre_pos_iter = current_iter;
                        if(pre_pos_iter.backward_char ()) {
                            pre_char = input.buffer.get_slice (pre_pos_iter, current_iter, false);
                        }

                        bool mod;
                        var new_char = service.translit (input_char, pre_char, out mod);
                        if (mod) {
                            input.buffer.delete_interactive (ref pre_pos_iter, ref current_iter, true);
                        }

                        input.insert_at_cursor (new_char);
                        return true;
                    }
                }
                return false;
            });

            var input_scroll = new Gtk.ScrolledWindow (null, null);
            input_scroll.expand = true;
            input_scroll.add (input);

            content.pack_start (key_map, false, false, 0);
            content.pack_start (input_scroll);

            this.add (content);
            this.show_all ();
            this.input.grab_focus ();
        }

        public void toggle_translit () {
            active_translit.active = !active_translit.active;
        }

        public void add_into_clipboard () {
            Gdk.Display display = this.get_display ();
            Gtk.Clipboard clipboard = Gtk.Clipboard.get_for_display (display, Gdk.SELECTION_CLIPBOARD);
            clipboard.set_text (input.buffer.text, -1);
        }
    }
}
