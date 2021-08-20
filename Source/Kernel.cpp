extern "C" void _start()
{
	__asm__("hlt");

	int* pointer = (int*)0xb8000;

	*pointer = 0x50505050;

	return;
}
