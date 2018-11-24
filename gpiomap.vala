using Cairo;

class GPIOMap {
	private Pin[] pins;
	public GPIOMap(string filename) {
		/* A GPIO Map file is a CSV with this format:
		 * pin,x,y,label,rgba,width,height
		 * The pin column is the pin number.
		 * The x column is the x coordinate of a pin.
		 * The y column is the y coordinate of a pin.
		 * The label column is the label of the pin.
		 * The rgba columns are where R, G, B, and A are between 0 and 255.
		 * The width column is the width of the entire GPIO bank.
		 * The height column is the height of the entire GPIO bank.
		 */
		var f = File.new_for_path(filename);
		try {
			var dis = new DataInputStream(f.read());
			if (dis.read_line() != "pin,x,y,label,r,g,b,a,width,height") {
				stderr.printf("Malformed GPIO Map file. First line should be:");
				stderr.printf("pin,x,y,label,r,g,b,a,width,height");
			}
			string? line = "";
			string[] columns;
			while (true) {
				line = dis.read_line();
				if (line == null) {
					break;
				}
				columns = line.split(",");
				if (columns.length != 10) {
					break;
				}
				pins += new Pin(int.parse(columns[0]), int.parse(columns[1]), int.parse(columns[2]), columns[3], int.parse(columns[4]), int.parse(columns[5]), int.parse(columns[6]), int.parse(columns[7]), int.parse(columns[8]), int.parse(columns[9]));
			}
		}
		catch (Error e) {
			stderr.printf("Error: %s\n", e.message);
		}
	}
	public void render(int pixel_width, int pixel_height, Context ctx) {
		// Clear the drawing area.
		ctx.set_source_rgb(1, 1, 1);
		ctx.rectangle(0, 0, pixel_width, pixel_height);
		ctx.fill();

		// Draw a light grey grid.
		int gpio_width = pins[0].width;
		int gpio_height = pins[0].height;
		ctx.set_source_rgb(0.83, 0.83, 0.83);
		ctx.set_line_width(0.5);
		for (int x = 0; x < pixel_width; x += pixel_width / gpio_width) {
			ctx.move_to(x, 0);
			ctx.line_to(x, pixel_height - 1);
		}
		ctx.stroke();
	}
}
