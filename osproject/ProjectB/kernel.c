#define ENTER 0xD
#define BACKSPACE 0x8

void printString(char* string);
void readString(char* input);
void printEndOfLine();
void handleInterrupt21(int ax, int bx, int cx, int dx);

int main()
{
	//char buffer[512];
	//char input[80];
	//makeInterrupt21();
	
	//printString("Enter4");
	//readString(input);

	//interrupt21(1,buffer,0,0);
	//interrupt21(0,buffer,0,0);
	//interrupt21(2,buffer,30,0);
	//readSector(buffer,30);
	//printString(buffer);
	
	makeInterrupt21();
	loadProgram();

	return 0;
	
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

void handleInterrupt21(int ax, int bx, int cx, int dx) {
        switch(ax){
    		case 0  :
       			printString(bx);
       		break;
    		
		case 1  :
       			readString(bx);
       		break;
		
		case 2  :
       			readSector(bx,cx);
       		break;
  
    		default : 
       		printString("Error command not found");
		break;
		}   
}


