
class KidsAge {
  int years;
  int months;
  int days;
  KidsAge({ this.years = 0, this.months = 0, this.days = 0 });
}

KidsAge getTheKidsAge(String birthday) {
  if (birthday != '') {
    var birthDate = DateTime.tryParse(birthday);
    if (birthDate != null) {
      final now = new DateTime.now();

      int years = now.year - birthDate.year;
      int months = now.month - birthDate.month;
      int days = now.day - birthDate.day;

      if (months < 0 || (months == 0 && days < 0)) {
        years--;
        months += (days < 0 ? 11 : 12);
      }

      if (days < 0) {
        final monthAgo = new DateTime(now.year, now.month - 1, birthDate.day);
        days = now.difference(monthAgo).inDays + 1;
      }

      return KidsAge(years: years, months: months, days: days);
    } else {
      print('getTheKidsAge: not a valid date');
    }
  } else {
    print('getTheKidsAge: date is empty');
  }
  return KidsAge();
}


bool isCouponValid(String date) {
  final now = DateTime.parse(DateTime.now().toString().substring(0,10));
  final expirationDate = DateTime.parse(date);
  return !expirationDate.isBefore(now);
}
