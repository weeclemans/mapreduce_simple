#include <stdio.h>

int main()
{

    char line[40];
    int num=0;
    while((fgets(line,40, stdin)) != NULL)
    {
	//num=atoi(line);
	/* convert char array to number */
	sscanf(line, "%d", &num);

        //num++;
        printf("%d\n",++num);
        //fputs(line, stdout);
    }
}

