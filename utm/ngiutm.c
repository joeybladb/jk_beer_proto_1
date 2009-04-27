#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include "utm.h"
#include "ngiutm.h"


#define DEG2RAD(_d_) ( (_d_) * (M_PI / 180.0) )
#define RAD2DEG(_r_) ( (_r_) * (180.0 / M_PI) )

static char
utm_northing_zone_to_hemisphere (char zone)
{
  char hemisphere = 'N';

  switch (zone)
  {
  case 'A':  case 'C':  case 'D':
  case 'E':  case 'F':  case 'G':
  case 'H':  case 'J':  case 'K':
  case 'L':  case 'M':
    hemisphere = 'S';
    break;

  case 'N':  case 'P':  case 'Q':
  case 'R':  case 'S':  case 'T':
  case 'U':  case 'V':  case 'W':
  case 'X':  case 'Z':
    hemisphere = 'N';
    break;
  }

  return hemisphere;
}

static char
utm_get_northing_zone (double latitude)
{
  char zone = '?';
  int lat = (int)abs(latitude);

  if (latitude < 0.0) /* southern hemisphere */
  {
    if      (lat >= 80) zone = 'A'; /* invalid, antarctic  */
    else if (lat >= 72) zone = 'C';
    else if (lat >= 64) zone = 'D';
    else if (lat >= 56) zone = 'E';
    else if (lat >= 48) zone = 'F';
    else if (lat >= 40) zone = 'G';
    else if (lat >= 32) zone = 'H';
    else if (lat >= 24) zone = 'J';
    else if (lat >= 16) zone = 'K';
    else if (lat >=  8) zone = 'L';
    else                zone = 'M';
  }
  else /* northern hemisphere */
  {
    if      (lat >=  84) zone = 'Z'; /* invalid, arctic */
    else if (lat >=  72) zone = 'X';
    else if (lat >=  64) zone = 'W';
    else if (lat >=  56) zone = 'V';
    else if (lat >=  48) zone = 'U';
    else if (lat >=  40) zone = 'T';
    else if (lat >=  32) zone = 'S';
    else if (lat >=  24) zone = 'R';
    else if (lat >=  16) zone = 'Q';
    else if (lat >=   8) zone = 'P';
    else                 zone = 'N';
  }
  
  return zone;
}

/* returns 0 on success */
int ngi_convert_geodetic_to_utm (double  latitude,
                                 double  longitude,
                                 char   *northing_zone, /* [out] */
                                 long   *easting_zone,  /* [out] */
                                 double *northing,      /* [out] */
                                 double *easting)       /* [out] */

{
  long err_code = UTM_NO_ERROR;
  char hemisphere;

  double latitude_radians  = DEG2RAD(latitude);
  double longitude_radians = DEG2RAD(longitude);

  /* convert decimal degrees in radians to UTM coordinates */
  err_code = Convert_Geodetic_To_UTM (latitude_radians,
                                      longitude_radians,
                                      easting_zone,
                                      &hemisphere,
                                      easting,
                                      northing);
  *northing_zone = utm_get_northing_zone (latitude);

  return (UTM_NO_ERROR == err_code) ? 0 : 1;
}




/* returns 0 on success */
int ngi_convert_utm_to_geodetic (char    northing_zone,
                                 long    easting_zone,
                                 double  northing,
                                 double  easting,
                                 double *latitude,   /* [out] */
                                 double *longitude)  /* [out] */
{
  long err_code   = UTM_NO_ERROR;
  char hemisphere = utm_northing_zone_to_hemisphere (northing_zone);

  err_code = Convert_UTM_To_Geodetic(easting_zone,
                                     hemisphere,
                                     easting,
                                     northing,
                                     latitude,
                                     longitude);
  if (UTM_NO_ERROR == err_code)
  {
    *latitude  = RAD2DEG(*latitude);
    *longitude = RAD2DEG(*longitude);
  }

  return (UTM_NO_ERROR == err_code) ? 0 : 1;
}
