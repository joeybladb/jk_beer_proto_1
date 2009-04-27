#ifndef NGI_UTM_H
#define NGI_UTM_H 1

#ifdef __cplusplus
extern "C" {
#endif

/* returns 0 on success */
int ngi_convert_geodetic_to_utm (double  latitude,		/* Degrees */
                                 double  longitude,		/* Degrees */
                                 char   *northing_zone, /* [out] */
                                 long   *easting_zone,  /* [out] */
                                 double *northing,      /* [out] */
                                 double *easting);      /* [out] */


/* returns 0 on success */
int ngi_convert_utm_to_geodetic (char    northing_zone,
                                 long    easting_zone,
                                 double  northing,
                                 double  easting,
                                 double *latitude,   /* [out] */
                                 double *longitude); /* [out] */

#ifdef __cplusplus
}
#endif
								

#endif /* NGI_UTM_H */

