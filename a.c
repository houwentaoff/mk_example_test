/*
 * =====================================================================================
 *       Copyright (c), 2013-2020, xxx.
 *       Filename:  a.c
 *
 *    Description:  
 *         Others:
 *
 *        Version:  1.0
 *        Created:  08/11/2019 10:01:22 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Joy. Hou (hwt), 544088192@qq.com
 *   Organization:  xxx
 *
 * =====================================================================================
 */
#include <pthread.h>

void * start_routine(void *argv)
{
    return NULL;
}
void aa()
{
    pthread_t tid;
    int ret = 0;

    ret = pthread_create(&tid, NULL, start_routine, NULL);

    return;
}
