#include <stdio.h>

int main (int argc, char *argv[])
{
	//char * cmd;
	//strc
	if(argc == 2)
	{
		setuid(0);
		setgid(0);
		system(argv[1]);
	}
  return 0;
}




//printf ("This program was called with \"%s\".\n",argv[0]);

	//printf ("This \"%s\".\n",argv[1]);  
  
  /*if (argc > 1)
   {
      for (count = 1; count < argc; count++)
	{
	  
	  printf("argv[%d] = %s\n", count, argv[count]);
	}
    }
  else
    {
      printf("The command had no other arguments.\n");
    }*/
