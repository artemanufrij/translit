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
    public class TranslitService : GLib.Object {

        public signal void key_map_loaded (GLib.List<KeyMapItem> list);
        GLib.KeyFile file;
        
        public bool load_dictionary (string lang) {
            string dictionary = "/" + Constants.PKGDATADIR + "/dictionary/" + lang;
            file = new GLib.KeyFile ();

            var return_value = false;
            try {
                return_value = file.load_from_file (dictionary, GLib.KeyFileFlags.NONE);
            } catch (Error e) {
                warning (e.message);
            }

            GLib.List<KeyMapItem> keymap = new GLib.List<KeyMapItem> ();
            try {
                foreach (var item in file.get_keys ("Keymap")) {
                    keymap.append (new KeyMapItem (item, file.get_string ("Keymap", item)));
                }
            } catch (Error e) {
                warning (e.message);
            }
            key_map_loaded (keymap);

            return return_value;
        }

        public string translit (string input_char, string pre_char, out bool mod) {
            mod = false;
            var return_value = input_char;
            try {
                if (file.has_key ("Translit", pre_char + return_value)) {
                    return_value = file.get_string ("Translit", pre_char + return_value);
                    mod = true;
                } else if (file.has_key ("Translit", return_value)) {
                    return_value = file.get_string ("Translit", return_value);
                }
            } catch (Error e) {
                warning (e.message);
            }
            return return_value;
        }
    }
}
