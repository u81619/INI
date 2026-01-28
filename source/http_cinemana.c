/*
 * Cinemana Home Pro - HTTP Handler
 * Displays Cinemana website
 */

#include <stdio.h>
#include <string.h>
#include <orbis/Net.h>
#include <curl/curl.h>
#include "common.h"

#define CINEMANA_URL "http://cinemana.shabakaty.com/page/home/index/en"

static size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp)
{
    size_t realsize = size * nmemb;
    return realsize;
}

int load_cinemana_page(void)
{
    CURL *curl;
    CURLcode res;
    
    curl = curl_easy_init();
    if (!curl) {
        LOG("Failed to initialize CURL");
        return 0;
    }
    
    curl_easy_setopt(curl, CURLOPT_URL, CINEMANA_URL);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, 30L);
    curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
    
    res = curl_easy_perform(curl);
    
    if (res != CURLE_OK) {
        LOG("CURL error: %s", curl_easy_strerror(res));
        curl_easy_cleanup(curl);
        return 0;
    }
    
    curl_easy_cleanup(curl);
    return 1;
}
