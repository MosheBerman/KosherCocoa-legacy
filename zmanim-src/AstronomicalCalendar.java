 /*
 * Zmanim Java API
 * Copyright (C) 2004-2010 Eliyahu Hershfeld
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
package net.sourceforge.zmanim;

import java.util.Calendar;
import java.util.Date;

import net.sourceforge.zmanim.util.AstronomicalCalculator;
import net.sourceforge.zmanim.util.GeoLocation;
import net.sourceforge.zmanim.util.ZmanimFormatter;

/**
 * A Java calendar that calculates astronomical time calculations such as
 * {@link #getSunrise() sunrise} and {@link #getSunset() sunset} times. This
 * class contains a {@link #getCalendar() Calendar} and can therefore use the
 * standard Calendar functionality to change dates etc. The calculation engine
 * used to calculate the astronomical times can be changed to a different
 * implementation by implementing the {@link AstronomicalCalculator} and setting
 * it with the {@link #setAstronomicalCalculator(AstronomicalCalculator)}. A
 * number of different implementations are included in the util package <br />
 * <b>Note:</b> There are times when the algorithms can't calculate proper
 * values for sunrise, sunset and twilight. This is usually caused by trying to
 * calculate times for areas either very far North or South, where sunrise /
 * sunset never happen on that date. This is common when calculating twilight
 * with a deep dip below the horizon for locations as far south of the North
 * Pole as London, in the northern hemisphere. The sun never reaches this dip at
 * certain times of the year. When the calculations encounter this condition a
 * null will be returned when a <code>{@link java.util.Date}</code> is expected
 * and {@link Long#MIN_VALUE} when a long is expected. The reason that
 * <code>Exception</code>s are not thrown in these cases is because the lack of
 * a rise/set or twilight is not an exception, but expected in many parts of the
 * world.
 * 
 * Here is a simple example of how to use the API to calculate sunrise: <br />
 * First create the Calendar for the location you would like to calculate:
 * 
 * <pre>
 * String locationName = &quot;Lakewood, NJ&quot;;
 * double latitude = 40.0828; // Lakewood, NJ
 * double longitude = -74.2094; // Lakewood, NJ
 * double elevation = 20; // optional elevation correction in Meters
 * // the String parameter in getTimeZone() has to be a valid timezone listed in
 * // {@link java.util.TimeZone#getAvailableIDs()}
 * TimeZone timeZone = TimeZone.getTimeZone(&quot;America/New_York&quot;);
 * GeoLocation location = new GeoLocation(locationName, latitude, longitude,
 * 		elevation, timeZone);
 * AstronomicalCalendar ac = new AstronomicalCalendar(location);
 * </pre>
 * 
 * To get the time of sunrise, first set the date (if not set, the date will
 * default to today):
 * 
 * <pre>
 * ac.getCalendar().set(Calendar.MONTH, Calendar.FEBRUARY);
 * ac.getCalendar().set(Calendar.DAY_OF_MONTH, 8);
 * Date sunrise = ac.getSunrise();
 * </pre>
 * 
 * 
 * @author &copy; Eliyahu Hershfeld 2004 - 2010
 * @version 1.2.1
 */
public class AstronomicalCalendar implements Cloneable {
	private static final long serialVersionUID = 1;

	/**
	 * 90&deg; below the vertical. Used for certain calculations.<br />
	 * <b>Note </b>: it is important to note the distinction between this zenith
	 * and the {@link AstronomicalCalculator#adjustZenith adjusted zenith} used
	 * for some solar calculations. This 90 zenith is only used because some
	 * calculations in some subclasses are historically calculated as an offset
	 * in reference to 90.
	 */
	public static final double GEOMETRIC_ZENITH = 90;

	/**
	 * Default value for Sun's zenith and true rise/set Zenith (used in this
	 * class and subclasses) is the angle that the center of the Sun makes to a
	 * line perpendicular to the Earth's surface. If the Sun were a point and
	 * the Earth were without an atmosphere, true sunset and sunrise would
	 * correspond to a 90&deg; zenith. Because the Sun is not a point, and
	 * because the atmosphere refracts light, this 90&deg; zenith does not, in
	 * fact, correspond to true sunset or sunrise, instead the center of the
	 * Sun's disk must lie just below the horizon for the upper edge to be
	 * obscured. This means that a zenith of just above 90&deg; must be used.
	 * The Sun subtends an angle of 16 minutes of arc (this can be changed via
	 * the {@link #setSunRadius(double)} method , and atmospheric refraction
	 * accounts for 34 minutes or so (this can be changed via the
	 * {@link #setRefraction(double)} method), giving a total of 50 arcminutes.
	 * The total value for ZENITH is 90+(5/6) or 90.8333333&deg; for true
	 * sunrise/sunset.
	 */
	// public static double ZENITH = GEOMETRIC_ZENITH + 5.0 / 6.0;
	/** Sun's zenith at civil twilight (96&deg;). */
	public static final double CIVIL_ZENITH = 96;

	/** Sun's zenith at nautical twilight (102&deg;). */
	public static final double NAUTICAL_ZENITH = 102;

	/** Sun's zenith at astronomical twilight (108&deg;). */
	public static final double ASTRONOMICAL_ZENITH = 108;

	/** constant for milliseconds in a minute (60,000) */
	static final long MINUTE_MILLIS = 60 * 1000;

	/** constant for milliseconds in an hour (3,600,000) */
	static final long HOUR_MILLIS = MINUTE_MILLIS * 60;

	/**
	 * The Java Calendar encapsulated by this class to track the current date
	 * used by the class
	 */
	private Calendar calendar;

	private GeoLocation geoLocation;

	private AstronomicalCalculator astronomicalCalculator;

	/**
	 * The getSunrise method Returns a <code>Date</code> representing the
	 * sunrise time. The zenith used for the calculation uses
	 * {@link #GEOMETRIC_ZENITH geometric zenith} of 90&deg;. This is adjusted
	 * by the {@link AstronomicalCalculator} that adds approximately 50/60 of a
	 * degree to account for 34 archminutes of refraction and 16 archminutes for
	 * the sun's radius for a total of
	 * {@link AstronomicalCalculator#adjustZenith 90.83333&deg;}. See
	 * documentation for the specific implementation of the
	 * {@link AstronomicalCalculator} that you are using.
	 * 
	 * @return the <code>Date</code> representing the exact sunrise time. If the
	 *         calculation can't be computed such as in the Arctic Circle where
	 *         there is at least one day a year where the sun does not rise, and
	 *         one where it does not set, a null will be returned. See detailed
	 *         explanation on top of the page.
	 * @see AstronomicalCalculator#adjustZenith
	 */
	public Date getSunrise() {
		double sunrise = getUTCSunrise(GEOMETRIC_ZENITH);
		if (Double.isNaN(sunrise)) {
			return null;
		} else {
			return getDateFromTime(sunrise);
		}
	}

	/**
	 * Method that returns the sunrise without correction for elevation.
	 * Non-sunrise and sunset calculations such as dawn and dusk, depend on the
	 * amount of visible light, something that is not affected by elevation.
	 * This method returns sunrise calculated at sea level. This forms the base
	 * for dawn calculations that are calculated as a dip below the horizon
	 * before sunrise.
	 * 
	 * @return the <code>Date</code> representing the exact sea-level sunrise
	 *         time. If the calculation can't be computed such as in the Arctic
	 *         Circle where there is at least one day a year where the sun does
	 *         not rise, and one where it does not set, a null will be returned.
	 *         See detailed explanation on top of the page.
	 * @see AstronomicalCalendar#getSunrise
	 * @see AstronomicalCalendar#getUTCSeaLevelSunrise
	 */
	public Date getSeaLevelSunrise() {
		double sunrise = getUTCSeaLevelSunrise(GEOMETRIC_ZENITH);
		if (Double.isNaN(sunrise)) {
			return null;
		} else {
			return getDateFromTime(sunrise);
		}
	}

	/**
	 * A method to return the the beginning of civil twilight (dawn) using a
	 * zenith of {@link #CIVIL_ZENITH 96&deg;}.
	 * 
	 * @return The <code>Date</code> of the beginning of civil twilight using a
	 *         zenith of 96&deg;. If the calculation can't be computed (see
	 *         explanation on top of the page), null will be returned.
	 * @see #CIVIL_ZENITH
	 */
	public Date getBeginCivilTwilight() {
		return getSunriseOffsetByDegrees(CIVIL_ZENITH);
	}

	/**
	 * A method to return the the beginning of nautical twilight using a zenith
	 * of {@link #NAUTICAL_ZENITH 102&deg;}.
	 * 
	 * @return The <code>Date</code> of the beginning of nautical twilight using
	 *         a zenith of 102&deg;. If the calculation can't be computed (see
	 *         explanation on top of the page) null will be returned.
	 * @see #NAUTICAL_ZENITH
	 */
	public Date getBeginNauticalTwilight() {
		return getSunriseOffsetByDegrees(NAUTICAL_ZENITH);
	}

	/**
	 * A method that returns the the beginning of astronomical twilight using a
	 * zenith of {@link #ASTRONOMICAL_ZENITH 108&deg;}.
	 * 
	 * @return The <code>Date</code> of the beginning of astronomical twilight
	 *         using a zenith of 108&deg;. If the calculation can't be computed
	 *         (see explanation on top of the page), null will be returned.
	 * @see #ASTRONOMICAL_ZENITH
	 */
	public Date getBeginAstronomicalTwilight() {
		return getSunriseOffsetByDegrees(ASTRONOMICAL_ZENITH);
	}

	/**
	 * The getSunset method Returns a <code>Date</code> representing the sunset
	 * time. The zenith used for the calculation uses {@link #GEOMETRIC_ZENITH
	 * geometric zenith} of 90&deg;. This is adjusted by the
	 * {@link AstronomicalCalculator} that adds approximately 50/60 of a degree
	 * to account for 34 archminutes of refraction and 16 archminutes for the
	 * sun's radius for a total of {@link AstronomicalCalculator#adjustZenith
	 * 90.83333&deg;}. See documentation for the specific implementation of the
	 * {@link AstronomicalCalculator} that you are using. Note: In certain cases
	 * the calculates sunset will occur before sunrise. This will typically
	 * happen when a timezone other than the local timezone is used (calculating
	 * Los Angeles sunset using a GMT timezone for example). In this case the
	 * sunset date will be incremented to the following date.
	 * 
	 * @return the <code>Date</code> representing the exact sunset time. If the
	 *         calculation can't be computed such as in the Arctic Circle where
	 *         there is at least one day a year where the sun does not rise, and
	 *         one where it does not set, a null will be returned. See detailed
	 *         explanation on top of the page.
	 * @see AstronomicalCalculator#adjustZenith
	 */
	public Date getSunset() {
		double sunset = getUTCSunset(GEOMETRIC_ZENITH);
		if (Double.isNaN(sunset)) {
			return null;
		} else {
			return getAdjustedSunsetDate(getDateFromTime(sunset), getSunrise());
		}
	}

	/**
	 * A method that will roll the sunset time forward a day if sunset occurs
	 * before sunrise. This will typically happen when a timezone other than the
	 * local timezone is used (calculating Los Angeles sunset using a GMT
	 * timezone for example). In this case the sunset date will be incremented
	 * to the following date.
	 * 
	 * @param sunset
	 *            the sunset date to adjust if needed
	 * @param sunrise
	 *            the sunrise to compare to the sunset
	 * @return the adjusted sunset date. If the calculation can't be computed
	 *         such as in the Arctic Circle where there is at least one day a
	 *         year where the sun does not rise, and one where it does not set,
	 *         a null will be returned. See detailed explanation on top of the
	 *         page.
	 */
	private Date getAdjustedSunsetDate(Date sunset, Date sunrise) {
		if (sunset != null && sunrise != null && sunrise.compareTo(sunset) >= 0) {
			Calendar clonedCalendar = (Calendar) getCalendar().clone();
			clonedCalendar.setTime(sunset);
			clonedCalendar.add(Calendar.DAY_OF_MONTH, 1);
			return clonedCalendar.getTime();
		} else {
			return sunset;
		}
	}

	/**
	 * Method that returns the sunset without correction for elevation.
	 * Non-sunrise and sunset calculations such as dawn and dusk, depend on the
	 * amount of visible light, something that is not affected by elevation.
	 * This method returns sunset calculated at sea level. This forms the base
	 * for dusk calculations that are calculated as a dip below the horizon
	 * after sunset.
	 * 
	 * @return the <code>Date</code> representing the exact sea-level sunset
	 *         time. If the calculation can't be computed such as in the Arctic
	 *         Circle where there is at least one day a year where the sun does
	 *         not rise, and one where it does not set, a null will be returned.
	 *         See detailed explanation on top of the page.
	 * @see AstronomicalCalendar#getSunset
	 * @see AstronomicalCalendar#getUTCSeaLevelSunset
	 */
	public Date getSeaLevelSunset() {
		double sunset = getUTCSeaLevelSunset(GEOMETRIC_ZENITH);
		if (Double.isNaN(sunset)) {
			return null;
		} else {
			return getAdjustedSunsetDate(getDateFromTime(sunset),
					getSeaLevelSunrise());
		}
	}

	/**
	 * A method to return the the end of civil twilight using a zenith of
	 * {@link #CIVIL_ZENITH 96&deg;}.
	 * 
	 * @return The <code>Date</code> of the end of civil twilight using a zenith
	 *         of {@link #CIVIL_ZENITH 96&deg;}. If the calculation can't be
	 *         computed (see explanation on top of the page), null will be
	 *         returned.
	 * @see #CIVIL_ZENITH
	 */
	public Date getEndCivilTwilight() {
		return getSunsetOffsetByDegrees(CIVIL_ZENITH);
	}

	/**
	 * A method to return the the end of nautical twilight using a zenith of
	 * {@link #NAUTICAL_ZENITH 102&deg;}.
	 * 
	 * @return The <code>Date</code> of the end of nautical twilight using a
	 *         zenith of {@link #NAUTICAL_ZENITH 102&deg;}. If the calculation
	 *         can't be computed (see explanation on top of the page), null will
	 *         be returned.
	 * @see #NAUTICAL_ZENITH
	 */
	public Date getEndNauticalTwilight() {
		return getSunsetOffsetByDegrees(NAUTICAL_ZENITH);
	}

	/**
	 * A method to return the the end of astronomical twilight using a zenith of
	 * {@link #ASTRONOMICAL_ZENITH 108&deg;}.
	 * 
	 * @return The The <code>Date</code> of the end of astronomical twilight
	 *         using a zenith of {@link #ASTRONOMICAL_ZENITH 108&deg;}. If the
	 *         calculation can't be computed (see explanation on top of the
	 *         page), null will be returned.
	 * @see #ASTRONOMICAL_ZENITH
	 */
	public Date getEndAstronomicalTwilight() {
		return getSunsetOffsetByDegrees(ASTRONOMICAL_ZENITH);
	}

	/**
	 * Utility method that returns a date offset by the offset time passed in.
	 * This method casts the offset as a <code>long</code> and calls
	 * {@link #getTimeOffset(Date, long)}.
	 * 
	 * @param time
	 *            the start time
	 * @param offset
	 *            the offset in milliseconds to add to the time
	 * @return the {@link java.util.Date}with the offset added to it
	 */
	public Date getTimeOffset(Date time, double offset) {
		return getTimeOffset(time, (long) offset);
	}

	/**
	 * A utility method to return a date offset by the offset time passed in.
	 * 
	 * @param time
	 *            the start time
	 * @param offset
	 *            the offset in milliseconds to add to the time.
	 * @return the {@link java.util.Date} with the offset in milliseconds added
	 *         to it
	 */
	public Date getTimeOffset(Date time, long offset) {
		if (time == null || offset == Long.MIN_VALUE) {
			return null;
		}
		return new Date(time.getTime() + offset);
	}

	/**
	 * A utility method to return the time of an offset by degrees below or
	 * above the horizon of {@link #getSunrise() sunrise}.
	 * 
	 * @param offsetZenith
	 *            the degrees before {@link #getSunrise()} to use in the
	 *            calculation. For time after sunrise use negative numbers.
	 * @return The {@link java.util.Date} of the offset after (or before)
	 *         {@link #getSunrise()}. If the calculation can't be computed such
	 *         as in the Arctic Circle where there is at least one day a year
	 *         where the sun does not rise, and one where it does not set, a
	 *         null will be returned. See detailed explanation on top of the
	 *         page.
	 */
	public Date getSunriseOffsetByDegrees(double offsetZenith) {
		double alos = getUTCSunrise(offsetZenith);
		if (Double.isNaN(alos)) {
			return null;
		} else {
			return getDateFromTime(alos);
		}
	}

	/**
	 * A utility method to return the time of an offset by degrees below or
	 * above the horizon of {@link #getSunset() sunset}.
	 * 
	 * @param offsetZenith
	 *            the degrees after {@link #getSunset()} to use in the
	 *            calculation. For time before sunset use negative numbers.
	 * @return The {@link java.util.Date}of the offset after (or before)
	 *         {@link #getSunset()}. If the calculation can't be computed such
	 *         as in the Arctic Circle where there is at least one day a year
	 *         where the sun does not rise, and one where it does not set, a
	 *         null will be returned. See detailed explanation on top of the
	 *         page.
	 */
	public Date getSunsetOffsetByDegrees(double offsetZenith) {
		double sunset = getUTCSunset(offsetZenith);
		if (Double.isNaN(sunset)) {
			return null;
		} else {
			return getAdjustedSunsetDate(getDateFromTime(sunset),
					getSunriseOffsetByDegrees(offsetZenith));
		}
	}

	/**
	 * Default constructor will set a default {@link GeoLocation#GeoLocation()},
	 * a default {@link AstronomicalCalculator#getDefault()
	 * AstronomicalCalculator} and default the calendar to the current date.
	 */
	public AstronomicalCalendar() {
		this(new GeoLocation());
	}

	/**
	 * A constructor that takes in as a parameter geolocation information
	 * 
	 * @param geoLocation
	 *            The location information used for astronomical calculating sun
	 *            times.
	 */
	public AstronomicalCalendar(GeoLocation geoLocation) {
		setCalendar(Calendar.getInstance(geoLocation.getTimeZone()));
		setGeoLocation(geoLocation);// duplicate call
		setAstronomicalCalculator(AstronomicalCalculator.getDefault());
	}

	/**
	 * Method that returns the sunrise in UTC time without correction for time
	 * zone offset from GMT and without using daylight savings time.
	 * 
	 * @param zenith
	 *            the degrees below the horizon. For time after sunrise use
	 *            negative numbers.
	 * @return The time in the format: 18.75 for 18:45:00 UTC/GMT. If the
	 *         calculation can't be computed such as in the Arctic Circle where
	 *         there is at least one day a year where the sun does not rise, and
	 *         one where it does not set, {@link Double#NaN} will be returned.
	 */
	public double getUTCSunrise(double zenith) {
		return getAstronomicalCalculator().getUTCSunrise(this, zenith, true);
	}

	/**
	 * Method that returns the sunrise in UTC time without correction for time
	 * zone offset from GMT and without using daylight savings time. Non-sunrise
	 * and sunset calculations such as dawn and dusk, depend on the amount of
	 * visible light, something that is not affected by elevation. This method
	 * returns UTC sunrise calculated at sea level. This forms the base for dawn
	 * calculations that are calculated as a dip below the horizon before
	 * sunrise.
	 * 
	 * @param zenith
	 *            the degrees below the horizon. For time after sunrise use
	 *            negative numbers.
	 * @return The time in the format: 18.75 for 18:45:00 UTC/GMT. If the
	 *         calculation can't be computed such as in the Arctic Circle where
	 *         there is at least one day a year where the sun does not rise, and
	 *         one where it does not set, {@link Double#NaN} will be returned.
	 *         See detailed explanation on top of the page.
	 * @see AstronomicalCalendar#getUTCSunrise
	 * @see AstronomicalCalendar#getUTCSeaLevelSunset
	 */
	public double getUTCSeaLevelSunrise(double zenith) {
		return getAstronomicalCalculator().getUTCSunrise(this, zenith, false);
	}

	/**
	 * Method that returns the sunset in UTC time without correction for time
	 * zone offset from GMT and without using daylight savings time.
	 * 
	 * @param zenith
	 *            the degrees below the horizon. For time after before sunset
	 *            use negative numbers.
	 * @return The time in the format: 18.75 for 18:45:00 UTC/GMT. If the
	 *         calculation can't be computed such as in the Arctic Circle where
	 *         there is at least one day a year where the sun does not rise, and
	 *         one where it does not set, {@link Double#NaN} will be returned.
	 *         See detailed explanation on top of the page.
	 * @see AstronomicalCalendar#getUTCSeaLevelSunset
	 */
	public double getUTCSunset(double zenith) {
		return getAstronomicalCalculator().getUTCSunset(this, zenith, true);
	}

	/**
	 * Method that returns the sunset in UTC time without correction for
	 * elevation, time zone offset from GMT and without using daylight savings
	 * time. Non-sunrise and sunset calculations such as dawn and dusk, depend
	 * on the amount of visible light, something that is not affected by
	 * elevation. This method returns UTC sunset calculated at sea level. This
	 * forms the base for dusk calculations that are calculated as a dip below
	 * the horizon after sunset.
	 * 
	 * @param zenith
	 *            the degrees below the horizon. For time before sunset use
	 *            negative numbers.
	 * @return The time in the format: 18.75 for 18:45:00 UTC/GMT. If the
	 *         calculation can't be computed such as in the Arctic Circle where
	 *         there is at least one day a year where the sun does not rise, and
	 *         one where it does not set, {@link Double#NaN} will be returned.
	 *         See detailed explanation on top of the page.
	 * @see AstronomicalCalendar#getUTCSunset
	 * @see AstronomicalCalendar#getUTCSeaLevelSunrise
	 */
	public double getUTCSeaLevelSunset(double zenith) {
		return getAstronomicalCalculator().getUTCSunset(this, zenith, false);
	}

	/**
	 * A method that adds time zone offset and daylight savings time to the raw
	 * UTC time.
	 * 
	 * @param time
	 *            The UTC time to be adjusted.
	 * @return The time adjusted for the time zone offset and daylight savings
	 *         time.
	 */
	private double getOffsetTime(double time) {
		boolean dst = getCalendar().getTimeZone().inDaylightTime(
				getCalendar().getTime());
		double dstOffset = 0;
		// be nice to Newfies and use a double
		double gmtOffset = getCalendar().getTimeZone().getRawOffset()
				/ (60 * MINUTE_MILLIS);
		if (dst) {
			dstOffset = getCalendar().getTimeZone().getDSTSavings()
					/ (60 * MINUTE_MILLIS);
		}
		return time + gmtOffset + dstOffset;
	}

	/**
	 * Method to return a temporal (solar) hour. The day from sunrise to sunset
	 * is split into 12 equal parts with each one being a temporal hour.
	 * 
	 * @return the <code>long</code> millisecond length of a temporal hour. If
	 *         the calculation can't be computed (see explanation on top of the
	 *         page), {@link Long#MIN_VALUE} will be returned.
	 */
	public long getTemporalHour() {
		return getTemporalHour(getSunrise(), getSunset());
	}

	/**
	 * Utility method that will allow the calculation of a temporal (solar) hour
	 * based on the sunrise and sunset passed to this method.
	 * 
	 * @param sunrise
	 *            The start of the day.
	 * @param sunset
	 *            The end of the day.
	 * @see #getTemporalHour()
	 * @return the <code>long</code> millisecond length of the temporal hour. If
	 *         the calculation can't be computed (see explanation on top of the
	 *         page) {@link Long#MIN_VALUE} will be returned.
	 */
	public long getTemporalHour(Date sunrise, Date sunset) {
		if (sunrise == null || sunset == null) {
			return Long.MIN_VALUE;
		}
		return (sunset.getTime() - sunrise.getTime()) / 12;
	}

	/**
	 * A method that returns sundial or solar noon. It occurs when the Sun is <a
	 * href
	 * ="http://en.wikipedia.org/wiki/Transit_%28astronomy%29">transitting</a>
	 * the <a
	 * href="http://en.wikipedia.org/wiki/Meridian_%28astronomy%29">celestial
	 * meridian</a>. In this class it is calculated as halfway between sunrise
	 * and sunset, which can be slightly off the real transit time due to the
	 * lengthening or shortening day.
	 * 
	 * @return the <code>Date</code> representing Sun's transit. If the
	 *         calculation can't be computed such as in the Arctic Circle where
	 *         there is at least one day a year where the sun does not rise, and
	 *         one where it does not set, null will be returned.
	 */
	public Date getSunTransit() {
		return getTimeOffset(getSunrise(), getTemporalHour() * 6);
	}

	/**
	 * A method that returns a <code>Date</code> from the time passed in
	 * 
	 * @param time
	 *            The time to be set as the time for the <code>Date</code>. The
	 *            time expected is in the format: 18.75 for 6:45:00 PM
	 * @return The Date.
	 */
	protected Date getDateFromTime(double time) {
		if (Double.isNaN(time)) {
			return null;
		}
		time = getOffsetTime(time);
		time = (time + 240) % 24; // the calculators sometimes return a double
		// that is negative or slightly greater than 24
		Calendar cal = Calendar.getInstance();
		cal.clear();
		cal.set(Calendar.YEAR, getCalendar().get(Calendar.YEAR));
		cal.set(Calendar.MONTH, getCalendar().get(Calendar.MONTH));
		cal.set(Calendar.DAY_OF_MONTH, getCalendar().get(Calendar.DAY_OF_MONTH));

		int hours = (int) time; // cut off minutes

		time -= hours;
		int minutes = (int) (time *= 60);
		time -= minutes;
		int seconds = (int) (time *= 60);
		time -= seconds; // milliseconds

		cal.set(Calendar.HOUR_OF_DAY, hours);
		cal.set(Calendar.MINUTE, minutes);
		cal.set(Calendar.SECOND, seconds);
		cal.set(Calendar.MILLISECOND, (int) (time * 1000));
		return cal.getTime();
	}

	/**
	 * Will return the dip below the horizon before sunrise that matches the
	 * offset minutes on passed in. For example passing in 72 minutes for a
	 * calendar set to the equinox in Jerusalem returns a value close to
	 * 16.1&deg; Please note that this method is very slow and inefficient and
	 * should NEVER be used in a loop. <em><b>TODO:</b></em> Improve efficiency.
	 * 
	 * @param minutes
	 *            offset
	 * @return the degrees below the horizon that match the offset on the
	 *         equinox in Jerusalem at sea level.
	 * @see #getSunsetSolarDipFromOffset(double)
	 */
	public double getSunriseSolarDipFromOffset(double minutes) {
		Date offsetByDegrees = getSeaLevelSunrise();
		Date offsetByTime = getTimeOffset(getSeaLevelSunrise(),
				-(minutes * MINUTE_MILLIS));

		java.math.BigDecimal degrees = new java.math.BigDecimal(0);
		java.math.BigDecimal incrementor = new java.math.BigDecimal("0.0001");
		while (offsetByDegrees == null
				|| offsetByDegrees.getTime() > offsetByTime.getTime()) {
			degrees = degrees.add(incrementor);
			offsetByDegrees = getSunriseOffsetByDegrees(GEOMETRIC_ZENITH
					+ degrees.doubleValue());
		}
		return degrees.doubleValue();
	}

	/**
	 * Will return the dip below the horizon after sunset that matches the
	 * offset minutes on passed in. For example passing in 72 minutes for a
	 * calendar set to the equinox in Jerusalem returns a value close to
	 * 16.1&deg; Please note that this method is very slow and inefficient and
	 * should NEVER be used in a loop. <em><b>TODO:</b></em> Improve efficiency.
	 * 
	 * @param minutes
	 *            offset
	 * @return the degrees below the horizon that match the offset on the
	 *         equinox in Jerusalem at sea level.
	 * @see #getSunriseSolarDipFromOffset(double)
	 */
	public double getSunsetSolarDipFromOffset(double minutes) {
		Date offsetByDegrees = getSeaLevelSunset();
		Date offsetByTime = getTimeOffset(getSeaLevelSunset(), minutes
				* MINUTE_MILLIS);

		java.math.BigDecimal degrees = new java.math.BigDecimal(0);
		java.math.BigDecimal incrementor = new java.math.BigDecimal("0.0001");
		while (offsetByDegrees == null
				|| offsetByDegrees.getTime() < offsetByTime.getTime()) {
			degrees = degrees.add(incrementor);
			offsetByDegrees = getSunsetOffsetByDegrees(GEOMETRIC_ZENITH
					+ degrees.doubleValue());
		}
		return degrees.doubleValue();
	}

	/**
	 * @return an XML formatted representation of the class. It returns the
	 *         default output of the
	 *         {@link net.sourceforge.zmanim.util.ZmanimFormatter#toXML(AstronomicalCalendar)
	 *         toXML} method.
	 * @see net.sourceforge.zmanim.util.ZmanimFormatter#toXML(AstronomicalCalendar)
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return ZmanimFormatter.toXML(this);
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (this == object)
			return true;
		if (!(object instanceof AstronomicalCalendar))
			return false;
		AstronomicalCalendar aCal = (AstronomicalCalendar) object;
		return getCalendar().equals(aCal.getCalendar())
				&& getGeoLocation().equals(aCal.getGeoLocation())
				&& getAstronomicalCalculator().equals(
						aCal.getAstronomicalCalculator());
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		int result = 17;
		result = 37 * result + getClass().hashCode(); // needed or this and
														// subclasses will
														// return identical hash
		result += 37 * result + getCalendar().hashCode();
		result += 37 * result + getGeoLocation().hashCode();
		result += 37 * result + getAstronomicalCalculator().hashCode();
		return result;
	}

	/**
	 * A method that returns the currently set {@link GeoLocation} that contains
	 * location information used for the astronomical calculations.
	 * 
	 * @return Returns the geoLocation.
	 */
	public GeoLocation getGeoLocation() {
		return geoLocation;
	}

	/**
	 * Set the {@link GeoLocation} to be used for astronomical calculations.
	 * 
	 * @param geoLocation
	 *            The geoLocation to set.
	 */
	public void setGeoLocation(GeoLocation geoLocation) {
		this.geoLocation = geoLocation;
		// if not set the output will be in the original timezone. The call
		// below is also in the constructor
		getCalendar().setTimeZone(geoLocation.getTimeZone());
	}

	/**
	 * A method to return the current AstronomicalCalculator set.
	 * 
	 * @return Returns the astronimicalCalculator.
	 * @see #setAstronomicalCalculator(AstronomicalCalculator)
	 */
	public AstronomicalCalculator getAstronomicalCalculator() {
		return astronomicalCalculator;
	}

	/**
	 * A method to set the {@link AstronomicalCalculator} used for astronomical
	 * calculations. The Zmanim package ships with a number of different
	 * implementations of the <code>abstract</code>
	 * {@link AstronomicalCalculator} based on different algorithms, including
	 * {@link net.sourceforge.zmanim.util.SunTimesCalculator one implementation}
	 * based on the <a href = "http://aa.usno.navy.mil/">US Naval
	 * Observatory's</a> algorithm, and
	 * {@link net.sourceforge.zmanim.util.JSuntimeCalculator another} based on
	 * <a href=""http://noaa.gov">NOAA's</a> algorithm. This allows easy runtime
	 * switching and comparison of different algorithms.
	 * 
	 * @param astronomicalCalculator
	 *            The astronimicalCalculator to set.
	 */
	public void setAstronomicalCalculator(
			AstronomicalCalculator astronomicalCalculator) {
		this.astronomicalCalculator = astronomicalCalculator;
	}

	/**
	 * returns the Calendar object encapsulated in this class.
	 * 
	 * @return Returns the calendar.
	 */
	public Calendar getCalendar() {
		return calendar;
	}

	/**
	 * @param calendar
	 *            The calendar to set.
	 */
	public void setCalendar(Calendar calendar) {
		this.calendar = calendar;
		if (getGeoLocation() != null) {// set the timezone if possible
			// Always set the Calendar's timezone to match the GeoLocation
			// TimeZone
			getCalendar().setTimeZone(getGeoLocation().getTimeZone());
		}
	}

	/**
	 * A method that creates a <a
	 * href="http://en.wikipedia.org/wiki/Object_copy#Deep_copy">deep copy</a>
	 * of the object. <br />
	 * <b>Note:</b> If the {@link java.util.TimeZone} in the cloned
	 * {@link net.sourceforge.zmanim.util.GeoLocation} will be changed from the
	 * original, it is critical that
	 * {@link net.sourceforge.zmanim.AstronomicalCalendar#getCalendar()}.
	 * {@link java.util.Calendar#setTimeZone(TimeZone) setTimeZone(TimeZone)} be
	 * called in order for the AstronomicalCalendar to output times in the
	 * expected offset after being cloned.
	 * 
	 * @see java.lang.Object#clone()
	 * @since 1.1
	 */
	public Object clone() {
		AstronomicalCalendar clone = null;
		try {
			clone = (AstronomicalCalendar) super.clone();
		} catch (CloneNotSupportedException cnse) {
			System.out
					.print("Required by the compiler. Should never be reached since we implement clone()");
		}
		clone.setGeoLocation((GeoLocation) getGeoLocation().clone());
		clone.setCalendar((Calendar) getCalendar().clone());
		clone.setAstronomicalCalculator((AstronomicalCalculator) getAstronomicalCalculator()
				.clone());
		return clone;
	}
}