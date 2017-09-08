/*-
 * Copyright (c) 2017-2017 Artem Anufrij <artem.anufrij@live.de>
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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
        Gtk.TextView input;
        Gtk.ToggleButton active_translit;

        TranslitService service;

        public MainWindow () {
            settings = Settings.get_default ();
            service = new TranslitService ();
            service.load_dictionary (settings.lang);

            build_ui ();

            present ();
        }

        private void build_ui () {
            this.width_request = 600;
            this.height_request = 400;
            var content = new Gtk.Grid ();

            var headerbar = new Gtk.HeaderBar ();
            headerbar.title = _("Translit");
            headerbar.show_close_button = true;
            this.set_titlebar (headerbar);

            active_translit = new Gtk.ToggleButton ();
            active_translit.valign = Gtk.Align.CENTER;
            active_translit.active = true;
            active_translit.image = new Gtk.Image.from_icon_name ("config-language-symbolic", Gtk.IconSize.MENU);
            active_translit.tooltip_text = _("Disable char transliting");
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
            lang_chooser.append ("ru", "Русский");
            lang_chooser.append ("ua", "Український");
            lang_chooser.active_id = settings.lang;
            lang_chooser.tooltip_text = _("Translit language");
            lang_chooser.changed.connect (() => {
                settings.lang = lang_chooser.active_id;
                service.load_dictionary (settings.lang);
                this.input.grab_focus ();
            });
            headerbar.pack_end (lang_chooser);

            input = new Gtk.TextView ();
            input.expand = true;
            input.wrap_mode = Gtk.WrapMode.WORD;
            input.top_margin = input.left_margin = input.bottom_margin = input.right_margin = 12;
            input.key_press_event.connect ((event) => {
                if (active_translit.active) {
                    var input_char = event.str[0].to_string ();
                    debug (input_char);
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

            content.attach (input_scroll, 0, 0);

            this.add (content);
            this.show_all ();
            this.input.grab_focus ();
        }
        
        public void toggle_translit () {
            active_translit.active = !active_translit.active;
        }
    }
}
