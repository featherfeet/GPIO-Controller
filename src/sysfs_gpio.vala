class SysFsGPIO : Object, GPIO {
	private DataOutputStream exporter;
	public SysFsGPIO() {
		var f = File.new_for_path("/sys/class/gpio/export");
		try {
			exporter = new DataOutputStream(f.append_to(FileCreateFlags.NONE));
		}
		catch (Error e) {
			stderr.printf("Error: %s\n", e.message);
		}
	}
	public void setup(int pin, PinDirection direction) {
		try {
			exporter.put_string(pin.to_string());
		}
		catch (Error e) {
			stderr.printf("Error: %s\n", e.message);
		}
		var f = File.new_for_path("/sys/class/gpio/gpio%d/direction".printf(pin));
		try {
			var direction_dos = new DataOutputStream(f.append_to(FileCreateFlags.NONE));
			if (direction == PinDirection.IN) {
				direction_dos.put_string("in");
			}
			else if (direction == PinDirection.OUT) {
				direction_dos.put_string("out");
			}
		}
		catch (Error e) {
			stderr.printf("Error: %s\n", e.message);
		}
	}
	public void write(int pin, PinState state) {
		var f = File.new_for_path("/sys/class/gpio/gpio%d/value".printf(pin));
		try {
			var value_dos = new DataOutputStream(f.append_to(FileCreateFlags.NONE));
			if (state == PinState.LOW) {
				value_dos.put_string("0");
			}
			else if (state == PinState.HIGH) {
				value_dos.put_string("1");
			}
		}
		catch (Error e) {
			stderr.printf("Error: %s\n", e.message);
		}
	}
	public PinState read(int pin) {
		var f = File.new_for_path("/sys/class/gpio/gpio%d/value".printf(pin));
		try {
			var value_dos = new DataInputStream(f.read());
			uint8[] data = new uint8[1];
			value_dos.read(data);
			if (data[0] == '1') {
				return PinState.HIGH;
			}
		}
		catch (Error e) {
			stderr.printf("Error: %s\n", e.message);
		}
		return PinState.LOW;
	}
}
