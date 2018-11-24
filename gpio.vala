enum PinDirection {
	IN,
	OUT
}

enum PinState {
	LOW,
	HIGH
}

interface GPIO : Object {
	public abstract void setup(int pin, PinDirection direction);
	public abstract void write(int pin, PinState state);
	public abstract PinState read(int pin);
}
