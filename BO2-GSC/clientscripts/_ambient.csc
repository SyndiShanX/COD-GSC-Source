/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_ambient.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_utility_code;

init(local_client_num) {
  clocks_init(local_client_num);
}

clocks_init(clientnum) {
  curr_time = getsystemtime();
  hours = curr_time[0];

  if(hours > 12)
    hours = hours - 12;

  if(hours == 0)
    hours = 12;

  minutes = curr_time[1];
  seconds = curr_time[2];
  hour_hand = getentarray(clientnum, "hour_hand", "targetname");
  hour_values = [];
  hour_values["hand_time"] = hours;
  hour_values["rotate"] = 30;
  hour_values["rotate_bit"] = 0.00833333;
  hour_values["first_rotate"] = (minutes * 60 + seconds) * hour_values["rotate_bit"];
  minute_hand = getentarray(clientnum, "minute_hand", "targetname");
  minute_values = [];
  minute_values["hand_time"] = minutes;
  minute_values["rotate"] = 6;
  minute_values["rotate_bit"] = 0.1;
  minute_values["first_rotate"] = seconds * minute_values["rotate_bit"];
  second_hand = getentarray(clientnum, "second_hand", "targetname");
  second_values = [];
  second_values["hand_time"] = seconds;
  second_values["rotate"] = 6;
  second_values["rotate_bit"] = 6;
  hour_hand_array = getentarray(clientnum, "hour_hand", "targetname");

  if(isDefined(hour_hand_array)) {
    println("**********hour_hand_array is defined, size: " + hour_hand_array.size);

    array_thread(hour_hand_array, ::clock_run, hour_values);
  }

  minute_hand_array = getentarray(clientnum, "minute_hand", "targetname");

  if(isDefined(minute_hand_array)) {
    println("**********minute_hand_array is defined, size: " + minute_hand_array.size);

    array_thread(minute_hand_array, ::clock_run, minute_values);
  }

  second_hand_array = getentarray(clientnum, "second_hand", "targetname");

  if(isDefined(second_hand_array)) {
    println("**********second_hand_array is defined, size: " + second_hand_array.size);

    array_thread(second_hand_array, ::clock_run, second_values);
  }
}

clock_run(time_values) {
  self endon("entityshutdown");

  if(isDefined(self.script_noteworthy)) {
    hour = time_values["hand_time"];
    curr_time = getsystemtime(1);

    switch (tolower(self.script_noteworthy)) {
      case "honolulu":
        hour = curr_time[0] - 10;
        break;
      case "alaska":
        hour = curr_time[0] - 9;
        break;
      case "los angeles":
        hour = curr_time[0] - 8;
        break;
      case "denver":
        hour = curr_time[0] - 7;
        break;
      case "chicago":
        hour = curr_time[0] - 6;
        break;
      case "new york":
        hour = curr_time[0] - 5;
        break;
      case "halifax":
        hour = curr_time[0] - 4;
        break;
      case "greenland":
        hour = curr_time[0] - 3;
        break;
      case "london":
        hour = curr_time[0];
        break;
      case "paris":
        hour = curr_time[0] + 1;
        break;
      case "helsinki":
        hour = curr_time[0] + 2;
        break;
      case "moscow":
        hour = curr_time[0] + 3;
        break;
      case "china":
        hour = curr_time[0] + 8;
        break;
    }

    if(hour < 1)
      hour = hour + 12;

    if(hour > 12)
      hour = hour - 12;

    time_values["hand_time"] = hour;
  }

  while(!clienthassnapshot(0))
    wait 0.1;

  self rotatepitch(time_values["hand_time"] * time_values["rotate"], 0.05);
  self waittill("rotatedone");

  while(!clienthassnapshot(0))
    wait 0.1;

  if(isDefined(time_values["first_rotate"])) {
    self rotatepitch(time_values["first_rotate"], 0.05);
    self waittill("rotatedone");
  }

  prev_time = getsystemtime();

  while(true) {
    curr_time = getsystemtime();

    if(prev_time != curr_time) {
      while(!clienthassnapshot(0))
        wait 0.1;

      self rotatepitch(time_values["rotate_bit"], 0.05);
      prev_time = curr_time;
    }

    wait 1.0;
  }
}