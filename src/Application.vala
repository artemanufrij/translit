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

    public class TranslitApp : Gtk.Application {

        static TranslitApp _instance = null;

        public static TranslitApp instance {
            get {
                if (_instance == null)
                    _instance = new TranslitApp ();
                return _instance;
            }
        }

        construct {
            var toggle_translit = new SimpleAction ("toggle-translit", null);
            add_action (toggle_translit);
            add_accelerator ("Escape", "app.toggle-translit", null);
            toggle_translit.activate.connect (() => {
                if (mainwindow != null) {
                    mainwindow.toggle_translit ();
                }
            });
            var add_into_clipboard = new SimpleAction ("add-into-clipboard", null);
            add_action (add_into_clipboard);
            add_accelerator ("<Control><Shift>c", "app.add-into-clipboard", null);
            add_into_clipboard.activate.connect (() => {
                if (mainwindow != null) {
                    mainwindow.add_into_clipboard ();
                }
            });
        }

        MainWindow mainwindow;

        protected override void activate () {
            if (mainwindow != null) {
                mainwindow.present ();
                return;
            }

            mainwindow = new MainWindow ();
            mainwindow.set_application(this);
        }
    }
}

public static int main (string [] args) {
    Gtk.init (ref args);
    var app = Translit.TranslitApp.instance;
    return app.run (args);
}
