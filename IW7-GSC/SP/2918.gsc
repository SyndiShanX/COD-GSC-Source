/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2918.gsc
**************************************/

_id_DAC1(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_3 = var_0 * var_0;
  var_4 = pow(var_0 * 0.75, 2);
  var_5 = "in_range";
  var_6 = var_5;

  while(scripts\engine\utility::flag("proximity_hacking")) {
    var_7 = distance2dsquared(level.player.origin, var_1);

    if(var_5 == "in_range") {
      if(var_7 >= var_4) {
        thread _id_DABC();
        var_5 = "losing_signal";
      }
    } else if(var_5 == "losing_signal") {
      if(var_7 < var_4) {
        thread _id_DABA();
        var_5 = "in_range";
      } else if(var_7 >= var_3) {
        thread _id_DABD();
        var_5 = "out_of_range";
      }
    } else if(var_5 == "out_of_range") {
      if(var_7 < var_3) {
        thread _id_DABC();
        var_5 = "losing_signal";
      }
    }

    if(var_5 != var_6) {
      level.player notify("proximity_hack_state_change", var_5, var_6);

      if(isDefined(var_2))
        var_2 notify("proximity_hack_state_change", var_5, var_6);

      var_6 = var_5;
    }

    wait 0.05;
  }
}

_id_DAC2() {
  if(scripts\engine\utility::flag("proximity_hacking")) {
    level notify("proximity_hack_stopped");
    setomnvar("ui_hacking_time", 0);
    scripts\engine\utility::flag_clear("proximity_hacking");
  }
}

_id_DABC() {
  if(scripts\engine\utility::flag("proximity_hacking"))
    setomnvar("ui_hacking_time", -1);
}

_id_DABD(var_0) {
  if(scripts\engine\utility::flag("proximity_hacking")) {
    if(scripts\engine\utility::flag("proximity_hacking_nodegrade"))
      setomnvar("ui_hacking_time", -3);
    else
      setomnvar("ui_hacking_time", -2);
  }
}

_id_DABA() {
  if(scripts\engine\utility::flag("proximity_hacking"))
    setomnvar("ui_hacking_time", 1);
}

_id_DAC0(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::flag_exist("proximity_hacking_nodegrade"))
    scripts\engine\utility::flag_init("proximity_hacking_nodegrade");

  if(!scripts\engine\utility::flag_exist("proximity_hacking"))
    scripts\engine\utility::flag_init("proximity_hacking");

  var_4 = 1 / (var_0 * 20);
  var_5 = 0;
  var_6 = 0;
  setomnvar("ui_hacking_time", var_5);
  scripts\engine\utility::flag_set("proximity_hacking");

  for(;;) {
    wait 0.05;
    var_7 = get_proximity_state(var_1, var_2, var_3);

    if(var_7 != var_6) {
      var_6 = var_7;
      set_proximity_state(var_7);
    }

    var_8 = 1;

    if(var_7 == 2)
      var_8 = 0.5;

    if(var_7 == 3) {
      if(!scripts\engine\utility::flag("proximity_hacking_nodegrade"))
        var_5 = var_5 - var_4 * 0.5;
    } else
      var_5 = var_5 + var_4 * var_8;

    var_5 = clamp(var_5, 0, 1);

    if(var_5 == 1) {
      hack_complete(var_1);
      break;
    } else if(var_5 == 0) {
      hack_failure(var_1);
      break;
    }

    set_proximity_percent(var_5);
  }

  scripts\engine\utility::flag_clear("proximity_hacking");
  level notify("proximity_hack_end");
  var_1 notify("proximity_hack_end");
}

hack_complete(var_0) {
  set_proximity_state(4);
  set_proximity_percent(1);
  level notify("proximity_hack_completed");
  var_0 notify("hack_success");
  thread reset_hack_state();
}

hack_failure(var_0) {
  set_proximity_state(5);
  set_proximity_percent(0);
  level notify("proximity_hack_failed");
  var_0 notify("hack_fail");
}

set_proximity_state(var_0) {
  setomnvar("ui_hacking_state", var_0);
}

set_proximity_percent(var_0) {
  setomnvar("ui_hacking_time", var_0);
}

get_proximity_state(var_0, var_1, var_2) {
  var_3 = squared(var_1);
  var_4 = squared(var_1 * 0.75);
  var_5 = distance2dsquared(level.player.origin, var_2);

  if(var_5 > var_3)
    return 3;
  else if(var_5 > var_4 && var_5 < var_3)
    return 2;
  else if(var_5 < var_4)
    return 1;
}

reset_hack_state() {
  wait 2;
  setomnvar("ui_hacking_time", 0);
}