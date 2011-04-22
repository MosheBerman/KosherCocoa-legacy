/*
 * Zmanim Java API
 * Copyright (C) 2004-2008 Eliyahu Hershfeld
 *
 * This program is free software; you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
 * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program; if
 * not, write to the Free Software Foundation, Inc. 59 Temple Place - Suite 330, Boston, MA
 * 02111-1307, USA or connect to: http://www.fsf.org/copyleft/gpl.html
 */
package net.sourceforge.zmanim.util;

import java.util.Calendar;
import net.sourceforge.zmanim.AstronomicalCalendar;

/**
 * Implementation of sunrise and sunset methods to calculate astronomical times.
 * This calculator uses the Java algorithm written by <a
 * href="http://www.kevinboone.com/suntimes.html">Kevin Boone</a> that is based
 * on the <a href = "http://aa.usno.navy.mil/">US Naval Observatory's</a><a
 * href="http://aa.usno.navy.mil/publications/docs/asa.php">Almanac</a> for
 * Computer algorithm ( <a
 * href="http://www.amazon.com/exec/obidos/tg/detail/-/0160515106/">Amazon</a>,
 * <a
 * href="http://search.barnesandnoble.com/booksearch/isbnInquiry.asp?isbn=0160515106">Barnes
 * &amp; Noble</a>) and is used with his permission. Added to Kevin's code is
 * adjustment of the zenith to account for elevation.
 *
 * @author &copy; Eliyahu Hershfeld 2004 - 2008
 * @author &copy; Kevin Boone 2000
 * @version 1.1
 */

public class SunTimesCalculator extends AstronomicalCalculator {
	private String calculatorName = "US Naval Almanac Algorithm";
	public String getCalculatorName() {
		return calculatorName;
	}

	/**
	 * @see net.sourceforge.zmanim.util.AstronomicalCalculator#getUTCSunrise(AstronomicalCalendar,
	 *      double, boolean)
	 */
	public double getUTCSunrise(AstronomicalCalendar astronomicalCalendar,
			double zenith, boolean adjustForElevation) {
		double doubleTime = Double.NaN;

		if (adjustForElevation) {
			zenith = adjustZenith(zenith, astronomicalCalendar.getGeoLocation()
					.getElevation());
		} else {
			zenith = adjustZenith(zenith, 0);
		}
		doubleTime = getTimeUTC(astronomicalCalendar.getCalendar().get(
				Calendar.YEAR), astronomicalCalendar.getCalendar().get(
				Calendar.MONTH) + 1, astronomicalCalendar.getCalendar().get(
				Calendar.DAY_OF_MONTH), astronomicalCalendar.getGeoLocation()
				.getLongitude(), astronomicalCalendar.getGeoLocation()
				.getLatitude(), zenith, TYPE_SUNRISE);
		return doubleTime;
	}

	/**
	 * @see net.sourceforge.zmanim.util.AstronomicalCalculator#getUTCSunset(AstronomicalCalendar,
	 *      double, boolean)
	 */
	public double getUTCSunset(AstronomicalCalendar astronomicalCalendar,
			double zenith, boolean adjustForElevation) {
		double doubleTime = Double.NaN;

		if (adjustForElevation) {
			zenith = adjustZenith(zenith, astronomicalCalendar.getGeoLocation()
					.getElevation());
		} else {
			zenith = adjustZenith(zenith, 0);
		}
		doubleTime = getTimeUTC(astronomicalCalendar.getCalendar().get(
				Calendar.YEAR), astronomicalCalendar.getCalendar().get(
				Calendar.MONTH) + 1, astronomicalCalendar.getCalendar().get(
				Calendar.DAY_OF_MONTH), astronomicalCalendar.getGeoLocation()
				.getLongitude(), astronomicalCalendar.getGeoLocation()
				.getLatitude(), zenith, TYPE_SUNSET);
		return doubleTime;
	}

	/**
	 * Default value for Sun's zenith and true rise/set
	 */
	public static final double ZENITH = 90 + 50.0 / 60.0;

	private static final int TYPE_SUNRISE = 0;

	private static final int TYPE_SUNSET = 1;

	// DEG_PER_HOUR is the number of degrees of longitude
	// that corresponds to one hour time difference.
	private static final double DEG_PER_HOUR = 360.0 / 24.0;

	/**
	 * sin of an angle in degrees
	 */
	private static double sinDeg(double deg) {
		return Math.sin(deg * 2.0 * Math.PI / 360.0);
	}

	/**
	 * acos of an angle, result in degrees
	 */
	private static double acosDeg(double x) {
		return Math.acos(x) * 360.0 / (2 * Math.PI);
	}

	/**
	 * asin of an angle, result in degrees
	 */
	private static double asinDeg(double x) {
		return Math.asin(x) * 360.0 / (2 * Math.PI);
	}

	/**
	 * tan of an angle in degrees
	 */
	private static double tanDeg(double deg) {
		return Math.tan(deg * 2.0 * Math.PI / 360.0);
	}

	/**
	 * cos of an angle in degrees
	 */
	private static double cosDeg(double deg) {
		return Math.cos(deg * 2.0 * Math.PI / 360.0);
	}

	/**
	 * Calculate the day of the year, where Jan 1st is day 1. Note that this
	 * method needs to know the year, because leap years have an impact here
	 */
	private static int getDayOfYear(int year, int month, int day) {
		int n1 = 275 * month / 9;
		int n2 = (month + 9) / 12;
		int n3 = (1 + ((year - 4 * (year / 4) + 2) / 3));
		int n = n1 - (n2 * n3) + day - 30;
		return n;
	}

	/**
	 * Get time difference between location's longitude and the Meridian, in
	 * hours. West of Meridian has a negative time difference
	 */
	private static double getHoursFromMeridian(double longitude) {
		return longitude / DEG_PER_HOUR;
	}

	/**
	 * Gets the approximate time of sunset or sunrise In _days_ since midnight
	 * Jan 1st, assuming 6am and 6pm events. We need this figure to derive the
	 * Sun's mean anomaly
	 */
	private static double getApproxTimeDays(int dayOfYear,
			double hoursFromMeridian, int type) {
		if (type == TYPE_SUNRISE) {
			return dayOfYear + ((6.0 - hoursFromMeridian) / 24);
		} else /* if (type == TYPE_SUNSET) */{
			return dayOfYear + ((18.0 - hoursFromMeridian) / 24);
		}
	}

	/**
	 * Calculate the Sun's mean anomaly in degrees, at sunrise or sunset, given
	 * the longitude in degrees
	 */
	private static double getMeanAnomaly(int dayOfYear, double longitude,
			int type) {
		return (0.9856 * getApproxTimeDays(dayOfYear,
				getHoursFromMeridian(longitude), type)) - 3.289;
	}

	/**
	 * Calculates the Sun's true longitude in degrees. The result is an angle
	 * gte 0 and lt 360. Requires the Sun's mean anomaly, also in degrees
	 */
	private static double getSunTrueLongitude(double sunMeanAnomaly) {
		double l = sunMeanAnomaly + (1.916 * sinDeg(sunMeanAnomaly))
				+ (0.020 * sinDeg(2 * sunMeanAnomaly)) + 282.634;

		// get longitude into 0-360 degree range
		if (l >= 360.0) {
			l = l - 360.0;
		}
		if (l < 0) {
			l = l + 360.0;
		}
		return l;
	}

	/**
	 * Calculates the Sun's right ascension in hours, given the Sun's true
	 * longitude in degrees. Input and output are angles gte 0 and lt 360.
	 */
	private static double getSunRightAscensionHours(double sunTrueLongitude) {
		double a = 0.91764 * tanDeg(sunTrueLongitude);
		double ra = 360.0 / (2.0 * Math.PI) * Math.atan(a);
		// get result into 0-360 degree range
		// if (ra >= 360.0) ra = ra - 360.0;
		// if (ra < 0) ra = ra + 360.0;

		double lQuadrant = Math.floor(sunTrueLongitude / 90.0) * 90.0;
		double raQuadrant = Math.floor(ra / 90.0) * 90.0;
		ra = ra + (lQuadrant - raQuadrant);

		return ra / DEG_PER_HOUR; // convert to hours
	}

	/**
	 * Gets the cosine of the Sun's local hour angle
	 */
	private static double getCosLocalHourAngle(double sunTrueLongitude,
			double latitude, double zenith) {
		double sinDec = 0.39782 * sinDeg(sunTrueLongitude);
		double cosDec = cosDeg(asinDeg(sinDec));

		double cosH = (cosDeg(zenith) - (sinDec * sinDeg(latitude)))
				/ (cosDec * cosDeg(latitude));

		// Check bounds

		return cosH;
	}

	/**
	 * Gets the cosine of the Sun's local hour angle for default zenith
	 */
//	private static double getCosLocalHourAngle(double sunTrueLongitude,
//			double latitude) {
//		return getCosLocalHourAngle(sunTrueLongitude, latitude, ZENITH);
//	}

	/**
	 * Calculate local mean time of rising or setting. By `local' is meant the
	 * exact time at the location, assuming that there were no time zone. That
	 * is, the time difference between the location and the Meridian depended
	 * entirely on the longitude. We can't do anything with this time directly;
	 * we must convert it to UTC and then to a local time. The result is
	 * expressed as a fractional number of hours since midnight
	 */
	private static double getLocalMeanTime(double localHour,
			double sunRightAscensionHours, double approxTimeDays) {
		return localHour + sunRightAscensionHours - (0.06571 * approxTimeDays)
				- 6.622;
	}

	/**
	 * Get sunrise or sunset time in UTC, according to flag.
	 *
	 * @param year
	 *            4-digit year
	 * @param month
	 *            month, 1-12 (not the zero based Java month
	 * @param day
	 *            day of month, 1-31
	 * @param longitude
	 *            in degrees, longitudes west of Meridian are negative
	 * @param latitude
	 *            in degrees, latitudes south of equator are negative
	 * @param zenith
	 *            Sun's zenith, in degrees
	 * @param type
	 *            type of calculation to carry out {@link #TYPE_SUNRISE} or
	 *            {@link #TYPE_SUNRISE}.
	 *
	 * @return the time as a double. If an error was encountered in the
	 *         calculation (expected behavior for some locations such as near
	 *         the poles, {@link Double.NaN} will be returned.
	 */
	private static double getTimeUTC(int year, int month, int day,
			double longitude, double latitude, double zenith, int type) {
		int dayOfYear = getDayOfYear(year, month, day);
		double sunMeanAnomaly = getMeanAnomaly(dayOfYear, longitude, type);
		double sunTrueLong = getSunTrueLongitude(sunMeanAnomaly);
		double sunRightAscensionHours = getSunRightAscensionHours(sunTrueLong);
		double cosLocalHourAngle = getCosLocalHourAngle(sunTrueLong, latitude,
				zenith);

		double localHourAngle = 0;
		if (type == TYPE_SUNRISE) {
			if (cosLocalHourAngle > 1) { // no rise. No need for an Exception
				// since the calculation
				// will return Double.NaN
			}
			localHourAngle = 360.0 - acosDeg(cosLocalHourAngle);
		} else /* if (type == TYPE_SUNSET) */{
			if (cosLocalHourAngle < -1) {// no SET. No need for an Exception
				// since the calculation
				// will return Double.NaN
			}
			localHourAngle = acosDeg(cosLocalHourAngle);
		}
		double localHour = localHourAngle / DEG_PER_HOUR;

		double localMeanTime = getLocalMeanTime(localHour,
				sunRightAscensionHours, getApproxTimeDays(dayOfYear,
						getHoursFromMeridian(longitude), type));
		double pocessedTime = localMeanTime - getHoursFromMeridian(longitude);
		while (pocessedTime < 0.0) {
			pocessedTime += 24.0;
		}
		while (pocessedTime >= 24.0) {
			pocessedTime -= 24.0;
		}
		return pocessedTime;
	}

}