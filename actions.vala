enum GPIOMode {
	IMMEDIATE,
	DEFERRED
}

GPIOMode currentGPIOMode = GPIOMode.IMMEDIATE;

void setMode(GPIOMode mode) {
	currentGPIOMode = mode;
}

void pinMode(ref GPIO gpio, int pin, PinDirection direction) {
	gpio.setup(pin, direction);
}

void digitalWrite(ref GPIO gpio, int pin, PinState state) {
	gpio.write(pin, state);
}

PinState digitalRead(ref GPIO gpio, int pin) {
	return gpio.read(pin);
}
