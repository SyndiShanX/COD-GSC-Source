/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1439.gsc
**************************************/

_id_43E6(var_0) {
  level notify("rain_change", "hard", var_0);
  level thread _id_43EE(10, var_0);
  wait(var_0 * 0.5);
  level._id_43E7["rain"] = "";
  wait(var_0 * 0.5);
}

_id_43E8(var_0) {
  level notify("rain_change", "hard", var_0);
  level thread _id_43EE(8, var_0);
  wait(var_0 * 0.5);
  level._id_43E7["rain"] = "";
  wait(var_0 * 0.5);
}

_id_43E9(var_0) {
  level notify("rain_change", "light", var_0);
  level thread _id_43EE(5, var_0);
  wait(var_0 * 0.5);
  level._id_43E7["rain"] = "light";
  wait(var_0 * 0.5);
}

_id_43EA(var_0) {
  level notify("rain_change", "none", var_0);
  level thread _id_43EE(0, var_0);
  wait(var_0 * 0.5);
  level._id_43E7["rain"] = "norain";
  wait(var_0 * 0.5);
}

_id_43EB(var_0) {
  common_scripts\utility::flag_init("_weather_lightning_enabled");
  common_scripts\utility::flag_set("_weather_lightning_enabled");

  if(var_0 == "none") {
    level._id_43EC = 0;
    level._effect["rain_drops"] = level._effect["rain_" + level._id_43EC];
    _id_43EA(0.1);
  } else if(var_0 == "light") {
    level._id_43EC = 5;
    level._effect["rain_drops"] = level._effect["rain_" + level._id_43EC];
    _id_43E9(0.1);
  } else {
    level._id_43EC = 10;
    level._effect["rain_drops"] = level._effect["rain_" + level._id_43EC];
    _id_43E6(0.1);
  }
}

_id_43ED(var_0, var_1) {
  [[var_0]]();
  waittillframeend;

  for(;;) {
    _id_43F5(var_0, var_1);
  }
}

_id_43EE(var_0, var_1) {
  level notify("rain_level_change");
  level endon("rain_level_change");

  if(level._id_43EC > var_0) {
    var_2 = level._id_43EC - var_0;
    var_1 = var_1 / var_2;

    for(var_3 = 0; var_3 < var_2; var_3++) {
      wait(var_1);
      level._id_43EC--;
      level._effect["rain_drops"] = level._effect["rain_" + level._id_43EC];
    }
  }

  if(level._id_43EC < var_0) {
    var_2 = var_0 - level._id_43EC;
    var_1 = var_1 / var_2;

    for(var_3 = 0; var_3 < var_2; var_3++) {
      wait(var_1);
      level._id_43EC++;
      level._effect["rain_drops"] = level._effect["rain_" + level._id_43EC];
    }
  }
}

_id_43EF(var_0) {
  if(!isDefined(level._id_43F0)) {
    level._id_43F0 = [];
    level._id_43F1 = 0;
  }

  level._id_43F0[level._id_43F0.size] = var_0;
}

_id_43F2() {
  var_0 = getEntArray("player", "classname")[0];

  for(;;) {
    playFX(level._effect["rain_drops"], var_0.origin + (0, 0, 650), var_0.origin + (0, 0, 680));
    wait 0.3;
  }
}

_id_43F3() {
  if(level._id_43EC == 0) {
    return randomfloat(30);
  } else if(level._id_43EC == 1) {
    return randomfloat(24);
  } else if(level._id_43EC == 2) {
    return randomfloat(20);
  } else if(level._id_43EC == 3) {
    return randomfloat(15);
  } else if(level._id_43EC == 4) {
    return randomfloat(12);
  } else if(level._id_43EC == 5) {
    return randomfloat(9);
  } else if(level._id_43EC == 6) {
    return randomfloat(8);
  } else if(level._id_43EC == 7) {
    return randomfloat(8);
  } else if(level._id_43EC == 8) {
    return randomfloat(7);
  } else if(level._id_43EC == 9) {
    return randomfloat(6);
  } else if(level._id_43EC == 10) {
    return randomfloat(5);
  }
}

_id_43F4() {
  if(level._id_43EC == 0) {
    return 20;
  } else if(level._id_43EC == 1) {
    return 18;
  } else if(level._id_43EC == 2) {
    return 16;
  } else if(level._id_43EC == 3) {
    return 14;
  } else if(level._id_43EC == 4) {
    return 12;
  } else if(level._id_43EC == 5) {
    return 10;
  } else if(level._id_43EC == 6) {
    return 9;
  } else if(level._id_43EC == 7) {
    return 8;
  } else if(level._id_43EC == 8) {
    return 7;
  } else if(level._id_43EC == 9) {
    return 6;
  } else if(level._id_43EC == 10) {
    return 5;
  }
}

_id_43F5(var_0, var_1) {
  level endon("rain_change");
  var_2 = gettime() + (_id_43F4() + _id_43F3()) * 1000;

  if(var_2 < level._id_43F6) {
    level._id_43F6 = var_2;

  }
  for(;;) {
    common_scripts\utility::flag_wait("_weather_lightning_enabled");
    var_3 = (level._id_43F6 - gettime()) * 0.001;

    if(var_3 > 0) {
      wait(var_3);

    }
    if(!common_scripts\utility::flag("_weather_lightning_enabled")) {
      continue;
    }
    _id_43F8(var_0, var_1);
    level._id_43F6 = gettime() + (_id_43F4() + _id_43F3()) * 1000;
  }
}

_id_43F7(var_0) {
  if(isDefined(level._id_43F1)) {
    common_scripts\utility::exploder(level._id_43F0[level._id_43F1]);

  }
  [[var_0]]();
}

_id_43F8(var_0, var_1, var_2) {
  var_3[0] = "quick";
  var_3[1] = "double";
  var_3[2] = "triple";
  thread _id_43F9();

  if(!isDefined(var_2)) {
    var_2 = randomint(var_3.size);

  }
  var_4 = 0;

  if(isDefined(level._id_43F1)) {
    while(var_4 == level._id_43F1) {
      var_4 = randomint(level._id_43F0.size);

    }
    level._id_43F1 = var_4;
  }

  switch (var_3[var_2]) {
    case "quick":
      _id_43F7(var_1);
      break;
    case "double":
      _id_43F7(var_1);
      wait 0.05;
      _id_43F7(var_1);
      break;
    case "triple":
      _id_43F7(var_1);
      wait 0.05;
      _id_43F7(var_1);
      wait 0.5;
      _id_43F7(var_1);
      break;
  }
}

_id_43F9() {
  if(level._id_43EC == 0) {
    wait(6 + randomfloat(2));
  } else if(level._id_43EC == 1) {
    wait(5 + randomfloat(1.8));
  } else if(level._id_43EC == 2) {
    wait(4.5 + randomfloat(1.6));
  } else if(level._id_43EC == 3) {
    wait(4 + randomfloat(1.6));
  } else if(level._id_43EC == 4) {
    wait(3.5 + randomfloat(1.5));
  } else if(level._id_43EC == 5) {
    wait(3 + randomfloat(1.5));
  } else if(level._id_43EC == 6) {
    wait(2.5 + randomfloat(1.2));
  } else if(level._id_43EC == 7) {
    wait(2 + randomfloat(1));
  } else if(level._id_43EC == 8) {
    wait(1.9 + randomfloat(0.5));
  } else if(level._id_43EC == 9) {
    wait 1.5;
  } else if(level._id_43EC == 10) {
    wait 1;

  }
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.origin = level.player.origin + (0, 0, 60);
  var_0 linkto(level.player);

  if(level._id_43EC <= 8) {
    var_0 playSound("elm_thunder_distant", "sounddone");
  } else {
    var_0 playSound("elm_thunder_distant", "sounddone");
    var_0 thread maps\_utility::play_sound_on_entity("elm_thunder_strike");
  }

  var_0 waittill("sounddone");
  var_0 delete();
}