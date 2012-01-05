/**
 * 
 */
package module.siadap.domain.util;

import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.joda.time.ReadableInstant;

/**
 * @author João Antunes (joao.antunes@tagus.ist.utl.pt) - 26 de Dez de 2011
 * 
 *         Class with Misc. utility methods
 * 
 */
public class SiadapMiscUtilClass {
    /**
     * 
     * @param date
     *            the {@link LocalDate} that will be converted to represent the
     *            date at the beginning of the day
     * @return an {@link ReadableInstant} with the same day/month/year but the
     *         last instant of it, that is the last hour, last minute, last
     *         second etc...
     */
    public static ReadableInstant convertDateToEndOfDay(LocalDate date) {
	ReadableInstant newLocalDate = null;
	if (date != null) {
	    return new DateTime(date.getYear(), date.getMonthOfYear(), date.getDayOfMonth(), 23, 59, 59, 59);

	}
	return newLocalDate;

    }

    /**
     * 
     * @param date
     *            the {@link LocalDate} that will be converted to represent the
     *            date at the beginning of the day
     * @return an {@link ReadableInstant} with the same day/month/year but the
     *         first instant of it, that is the first hour, first minute, first
     *         second etc...
     */
    public static ReadableInstant convertDateToBeginOfDay(LocalDate date) {
	ReadableInstant newLocalDate = null;
	if (date != null) {
	    return date.toDateTimeAtStartOfDay();
	}
	return newLocalDate;

    }

    public static LocalDate lastDayOfYear(int year) {
	return new LocalDate(year, 12, 31);
    }

}