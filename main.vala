/* main.vala
 *
 * Copyright (C) 2018 Oliver Lok Trevor
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Cairo;

public class Application : Gtk.Window {
	private GPIOMap gpio_map = new GPIOMap("./gpiomap.csv");
	public Application() {
		this.title = "GPIO Controller";
		this.destroy.connect(Gtk.main_quit);
		set_default_size(500, 500);
		create_widgets();
	}
	private void create_widgets() {
		var drawing_area = new DrawingArea();
		drawing_area.draw.connect(on_draw);
		add(drawing_area);
	}
	private bool on_draw(Widget w, Context ctx) {
		gpio_map.render(500, 500, ctx);
		return true;
	}
	static int main(string[] args) {
		Gtk.init(ref args);

		var application = new Application();
		application.show_all();

		Gtk.main();

		return 0;
	}
}
