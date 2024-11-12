using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FengShuiKoi_Services
{
	public class LunarCalendarConverter
	{
		public static int[] ConvertSolarToLunar(string DOB, int timeZone)
		{
			DateTime date = DateTime.ParseExact(DOB, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
			int dd = date.Day;
			int mm = date.Month;
			int yy = date.Year;
			double dayNumber = JdFromDate(dd, mm, yy);
			int k = (int)Math.Floor((dayNumber - 2415021.076998695) / 29.530588853);
			int monthStart = GetNewMoonDay(k + 1, timeZone);

			if (monthStart > dayNumber)
			{
				monthStart = GetNewMoonDay(k, timeZone);
			}

			int a11 = GetLunarMonth11(yy, timeZone);
			int b11 = a11;

			if (a11 >= monthStart)
			{
				b11 = GetLunarMonth11(yy - 1, timeZone);
			}

			int lunarYear = a11 >= monthStart ? yy : yy - 1;
			int lunarDay = (int)(dayNumber - monthStart + 1);

			if (lunarDay <= 0 || lunarDay > 30)
			{
				return null;
			}

			int diff = (int)Math.Floor((dayNumber - b11) / 29.530588853);
			int lunarMonth = diff - 2;

			if (lunarMonth > 12)
			{
				lunarMonth -= 12;
			}

			if (lunarMonth <= 0)
			{
				lunarMonth += 12;
			}

			if (lunarMonth >= 11 && diff < 4)
			{
				lunarYear--;
			}

			return new int[] { lunarDay, lunarMonth, lunarYear };
		}

		private static int JdFromDate(int dd, int mm, int yy)
		{
			int a = (int)Math.Floor((14 - mm) / 12.0);
			int y = yy + 4800 - a;
			int m = mm + 12 * a - 3;
			int jd = dd + (int)Math.Floor((153 * m + 2) / 5.0) + 365 * y + (int)Math.Floor(y / 4.0) - (int)Math.Floor(y / 100.0) + (int)Math.Floor(y / 400.0) - 32045;
			if (jd < 2299161)
			{
				jd = dd + (int)Math.Floor((153 * m + 2) / 5.0) + 365 * y + (int)Math.Floor(y / 4.0) - 32083;
			}
			return jd;
		}

		private static int GetNewMoonDay(int k, int timeZone)
		{
			double T = k / 1236.85;
			double T2 = T * T;
			double dr = Math.PI / 180;
			double Jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * T2 - 0.000000155 * T * T * T;
			Jd1 += 0.00033 * Math.Sin((166.56 + 132.87 * T - 0.009173 * T2) * dr);
			double M = 359.2242 + 29.10535608 * k - 0.0000333 * T2 - 0.00000347 * T * T * T;
			double Mpr = 306.0253 + 385.81691806 * k + 0.0107306 * T2 + 0.00001236 * T * T * T;
			double F = 21.2964 + 390.67050646 * k - 0.0016528 * T2 - 0.00000239 * T * T * T;
			double C1 = (0.1734 - 0.000393 * T) * Math.Sin(M * dr) + 0.0021 * Math.Sin(2 * dr * M);
			C1 -= 0.4068 * Math.Sin(Mpr * dr) + 0.0161 * Math.Sin(dr * 2 * Mpr);
			C1 -= 0.0004 * Math.Sin(dr * 3 * Mpr);
			C1 += 0.0104 * Math.Sin(dr * 2 * F) - 0.0051 * Math.Sin(dr * (M + Mpr));
			C1 -= 0.0074 * Math.Sin(dr * (M - Mpr)) + 0.0004 * Math.Sin(dr * (2 * F + M));
			C1 -= 0.0004 * Math.Sin(dr * (2 * F - M)) - 0.0006 * Math.Sin(dr * (2 * F + Mpr));
			C1 += 0.0010 * Math.Sin(dr * (2 * F - Mpr)) + 0.0005 * Math.Sin(dr * (2 * Mpr + M));
			double deltat = 0.5 + (timeZone == 7 ? -0.5 : 0);
			double JdNew = Jd1 + C1 - deltat;
			return (int)Math.Floor(JdNew + 0.5 + timeZone / 24.0);
		}

		private static double GetSunLongitude(double jdn, int timeZone)
		{
			double T = (jdn - 2451545.5 - timeZone / 24) / 36525;
			double dr = Math.PI / 180;
			double M = 357.52910 + 35999.05030 * T;
			double DL = (1.914600 - 0.004817 * T) * Math.Sin(dr * M);
			DL += (0.019993 - 0.000101 * T) * Math.Sin(2 * dr * M);
			DL += 0.000290 * Math.Sin(3 * dr * M);
			double L0 = 280.46645 + 36000.76983 * T;
			double L = L0 + DL;
			double omega = 125.04 - 1934.136 * T;
			double lambda = L - 0.00569 - 0.00478 * Math.Sin(omega * dr);
			return lambda - 360 * Math.Floor(lambda / 360);
		}

		private static int GetLunarMonth11(int yy, int timeZone)
		{
			double off = JdFromDate(31, 12, yy) - 2415021;
			int k = (int)Math.Floor(off / 29.530588853);
			int nm = GetNewMoonDay(k, timeZone);
			double sunLong = GetSunLongitude(nm, timeZone);
			if (sunLong >= 9)
			{
				nm = GetNewMoonDay(k - 1, timeZone);
			}
			return nm;
		}
	}
}
