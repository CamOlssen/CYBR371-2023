#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

int main()
{
    uid_t uid = getuid();
    if (setuid(uid) < 0) {
        perror("setuid");
        return 1;
    }

    char buf[1024];
    if (getcwd(buf, sizeof(buf)) == NULL) {
        perror("getcwd");
        return 1;
    }

    char script_path[1044];
    snprintf(script_path, sizeof(script_path), "%s/check-medication.sh", buf);

    system(script_path);
    return 0;
}

