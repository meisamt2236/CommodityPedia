String priceConvertor(int num){
  String numStr = num.toString();
  
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  
  if (num < 1000){
    for (int i = 0; i < english.length; i++) {
    numStr = numStr.replaceAll(english[i], farsi[i]);
    }
    return numStr;
  }else {
     String reversedNum = numStr.split('').reversed.join();
     String newNum = reversedNum[0];
     for(int i=1; i< reversedNum.length;i++){
       if (i%3==0) {
         newNum += ',';
         newNum += reversedNum[i];
       } else {
         newNum += reversedNum[i];
       }
     }
     String reversedNewNum = newNum.split('').reversed.join();
    for (int i = 0; i < english.length; i++) {
    reversedNewNum = reversedNewNum.replaceAll(english[i], farsi[i]);
    }
     return reversedNewNum;
  }
}

String dateConvertor(String date){
  var now = DateTime.now();
  var parsedDate = DateTime.parse(date);
  var diffTimeToMinute = now.difference(parsedDate).inMinutes;
  if (diffTimeToMinute < 1) {
        return ('همین الان!');
    } else if (diffTimeToMinute < 5) {
        return ('دقایقی قبل!');
    } else if (diffTimeToMinute < 10) {
        return ('حدود ۵ دقیقه قبل!');
    } else if (diffTimeToMinute < 30) {
        return ('حدود ۱۰ دقیقه قبل!');
    } else if (diffTimeToMinute < 60) {
        return ('حدود نیم ساعت قبل!');
    } else if (diffTimeToMinute < 120) {
        return ('حدود یک ساعت قبل!');
    } else if (diffTimeToMinute < 180) {
        return ('حدود دو ساعت قبل!');
    } else if (diffTimeToMinute < 360) {
        return ('حدود سه ساعت قبل!');
    } else if (diffTimeToMinute < 720) {
        return ('حدود شش ساعت قبل!');
    } else if (diffTimeToMinute < 1440) {
        return ('حدود دوازده ساعت قبل!');
    } else if (diffTimeToMinute < 2880) {
        return ('دیروز!');
    } else if (diffTimeToMinute < 4320) {
        return ('پریروز!');
    } else if (diffTimeToMinute < 10080) {
        return ('چند روز قبل!');
    } else if (diffTimeToMinute < 43200) {
        return ('چند هفته قبل!');
    } else if (diffTimeToMinute < 525600) {
        return ('چند ماه قبل!');
    } else if (diffTimeToMinute < 1051200) {
        return ('یکسال قبل!');
    } else {
        return ('چند سال قبل!');
    }
}

