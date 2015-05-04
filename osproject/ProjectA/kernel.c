main()
{
	int getInitialLine;
	int getPrintToMemory;
	int getIndex;
	int getLineCount;
	int i;	
	int e;
	int getCurrentLine;
	int getLineIndex;

	getInitialLine = 32768;

	for(i=0 ; i<25; i++)
	{
		for(e = 0; e<80; e++)
		{
			getLineCount = i*80;
			getLineIndex = getLineCount * 2;

			getCurrentLine= getInitialLine + getLineIndex;		
			getPrintToMemory = getCurrentLine;

			getIndex = getPrintToMemory + e * 2;
			putInMemory(0xB000, getIndex, ' ');
			putInMemory(0xB000, getIndex + 1, 0x7);
		}
	}

	for(i=0 ; i<16; i++)
	{
		getIndex = i*2;
		getLineCount = i*80;
		getLineIndex = getLineCount * 2;

		getCurrentLine= getInitialLine + getLineIndex;		
		getPrintToMemory = getCurrentLine;	

		putInMemory(0xB000, getPrintToMemory, 'H');
		putInMemory(0xB000, getPrintToMemory+1, i);
		putInMemory(0xB000, getPrintToMemory+2, 'o');
		putInMemory(0xB000, getPrintToMemory+3, i);
		putInMemory(0xB000, getPrintToMemory+4, 'l');
		putInMemory(0xB000, getPrintToMemory+5, i);
		putInMemory(0xB000, getPrintToMemory+6, 'a');
		putInMemory(0xB000, getPrintToMemory+7, i);
		putInMemory(0xB000, getPrintToMemory+8, ' ');
		putInMemory(0xB000, getPrintToMemory+9, i);
		putInMemory(0xB000, getPrintToMemory+10, 'M');
		putInMemory(0xB000, getPrintToMemory+11, i);
		putInMemory(0xB000, getPrintToMemory+12, 'u');
		putInMemory(0xB000, getPrintToMemory+13, i);
		putInMemory(0xB000, getPrintToMemory+14, 'n');
		putInMemory(0xB000, getPrintToMemory+15, i);
		putInMemory(0xB000, getPrintToMemory+16, 'd');
		putInMemory(0xB000, getPrintToMemory+17, i);
		putInMemory(0xB000, getPrintToMemory+18, 'o');
		putInMemory(0xB000, getPrintToMemory+19, i);
	}		

	return 0;
}
