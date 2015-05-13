#define ENTER 0xD
#define BACKSPACE 0x8

void printString(char* string);
void readString(char* input);
void printEndOfLine();

main()
{
	//char input[80];
	//printString("Enter a line: ");
	//readString(input);

	char buffer[512];
	readSector(buffer,30);
	printString("hola");
	
}

void printString(char* string)
{
	int index=0;
	while(string[index]!= '\0')
	{
		putChar(string[index]);
		index++;
	}
	
	printEndOfLine();
}

void readString(char* input)
{
	int index=0;
	char c = readChar();

	while(c != ENTER && index < 80)
	{
		putChar(c);
		if(c!=BACKSPACE)
		{
			input[index]=c;
			index++;
		}else if(index>0)
		{
			index--;
		}
		
		c = readChar();
	}

	input[index] = 0;
	printEndOfLine();	
}

void printEndOfLine()
{
	putChar('\r');
	putChar('\n');
}


