#include <stdio.h>

int main()
{

    char line[40];
    int lineno=0;
    while((fgets(line,40, stdin)) != NULL)
    {
	//lineno=atoi(line);
	sscanf(line, "%d", &lineno);

        //lineno++;
        printf("%d\n",++lineno);
        //fputs(line, stdout);
    }
}

