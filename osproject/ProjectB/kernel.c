#define ENTER 0xD
#define BACKSPACE 0x8

void printString(char* string);
void readString(char* input);
void printEndOfLine();

main()
{
	
	//char input[80];
	//makeInterrupt21();
	
	//printString("Enter4");
	//readString(input);

	char buffer[512];
	//interrupt21(2,buffer,30);
	readSector(buffer,30);
	printString(buffer);
	
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


