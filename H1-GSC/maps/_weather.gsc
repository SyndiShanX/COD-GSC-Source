/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_weather.gsc
********************************/

rainhard(var_0) {
  level notify("rain_change", "hard", var_0);
  level thread raineffectchange(10, var_0);
  wait(var_0 * 0.5);
  level.ambient_modifier["rain"] = "";
  wait(var_0 * 0.5);
}

rainmedium(var_0) {
  level notify("rain_change", "hard", var_0);
  level thread raineffectchange(8, var_0);
  wait(var_0 * 0.5);
  level.ambient_modifier["rain"] = "";
  wait(var_0 * 0.5);
}

rainlight(var_0) {
  level notify("rain_change", "light", var_0);
  level thread raineffectchange(5, var_0);
  wait(var_0 * 0.5);
  level.ambient_modifier["rain"] = "light";
  wait(var_0 * 0.5);
}

rainnone(var_0) {
  level notify("rain_change", "none", var_0);
  level thread raineffectchange(0, var_0);
  wait(var_0 * 0.5);
  level.ambient_modifier["rain"] = "norain";
  wait(var_0 * 0.5);
}

raininit(var_0) {
  common_scripts\utility::flag_init("_weather_lightning_enabled");
  common_scripts\utility::flag_set("_weather_lightning_enabled");
  common_scripts\utility::flag_init("player_weather_enabled");
  common_scripts\utility::flag_set("player_weather_enabled");

  if(var_0 == "none") {
    level.rainlevel = 0;
    level._effect["rain_drops"] = level._effect["rain_" + level.rainlevel];
    rainnone(0.1);
  } else if(var_0 == "light") {
    level.rainlevel = 5;
    level._effect["rain_drops"] = level._effect["rain_" + level.rainlevel];
    rainlight(0.1);
  } else {
    level.rainlevel = 10;
    level._effect["rain_drops"] = level._effect["rain_" + level.rainlevel];
    rainhard(0.1);
  }
}

lightning(var_0, var_1) {
  [[var_0]]();
  waittillframeend;

  for (;;)
    lightningthink(var_0, var_1);
}

raineffectchange(var_0, var_1) {
  level notify("rain_level_change");
  level endon("rain_level_change");

  if(level.rainlevel > var_0) {
    var_2 = level.rainlevel - var_0;
    var_1 = var_1 / var_2;

    for (var_3 = 0; var_3 < var_2; var_3++) {
      wait(var_1);
      level.rainlevel--;
      level._effect["rain_drops"] = level._effect["rain_" + level.rainlevel];
    }
  }

  if(level.rainlevel < var_0) {
    var_2 = var_0 - level.rainlevel;
    var_1 = var_1 / var_2;

    for (var_3 = 0; var_3 < var_2; var_3++) {
      wait(var_1);
      level.rainlevel++;
      level._effect["rain_drops"] = level._effect["rain_" + level.rainlevel];
    }
  }
}

addlightningexploder(var_0) {
  if(!isdefined(level.lightningexploder)) {
    level.lightningexploder = [];
    level.lightningexploderindex = 0;
  }

  level.lightningexploder[level.lightningexploder.size] = var_0;
}

playerweather() {
  var_0 = getentarray("player", "classname")[0];
  var_1 = common_scripts\utility::spawn_tag_origin();

  for (;;) {
    while (common_scripts\utility::flag("player_weather_enabled")) {
      var_2 = var_0.angles;
      var_1 moveto(var_0.origin + (0, 0, 650), 0.1);
      var_1 rotateto((-90, var_2[1], 180), 0.1);
      playfxontag(level._effect["rain_drops"], var_1, "tag_origin");
      wait 0.3;
    }

    common_scripts\utility::flag_wait("player_weather_enabled");
  }
}

rainlevelrandomwait() {
  if(level.rainlevel == 0)
    return randomfloat(30);
  else if(level.rainlevel == 1)
    return randomfloat(24);
  else if(level.rainlevel == 2)
    return randomfloat(20);
  else if(level.rainlevel == 3)
    return randomfloat(15);
  else if(level.rainlevel == 4)
    return randomfloat(12);
  else if(level.rainlevel == 5)
    return randomfloat(9);
  else if(level.rainlevel == 6)
    return randomfloat(8);
  else if(level.rainlevel == 7)
    return randomfloat(8);
  else if(level.rainlevel == 8)
    return randomfloat(7);
  else if(level.rainlevel == 9)
    return randomfloat(6);
  else if(level.rainlevel == 10)
    return randomfloat(5);
}

rainlevelwait() {
  if(level.rainlevel == 0)
    return 20;
  else if(level.rainlevel == 1)
    return 18;
  else if(level.rainlevel == 2)
    return 16;
  else if(level.rainlevel == 3)
    return 14;
  else if(level.rainlevel == 4)
    return 12;
  else if(level.rainlevel == 5)
    return 10;
  else if(level.rainlevel == 6)
    return 9;
  else if(level.rainlevel == 7)
    return 8;
  else if(level.rainlevel == 8)
    return 7;
  else if(level.rainlevel == 9)
    return 6;
  else if(level.rainlevel == 10)
    return 5;
}

lightningthink(var_0, var_1) {
  level endon("rain_change");
  var_2 = gettime() + (rainlevelwait() + rainlevelrandomwait()) * 1000;

  if(var_2 < level.nextlightning)
    level.nextlightning = var_2;

  for (;;) {
    common_scripts\utility::flag_wait("_weather_lightning_enabled");
    var_3 = (level.nextlightning - gettime()) * 0.001;

    if(var_3 > 0)
      wait(var_3);

    if(!common_scripts\utility::flag("_weather_lightning_enabled")) {
      continue;
    }
    lightningflash(var_0, var_1);
    level.nextlightning = gettime() + (rainlevelwait() + rainlevelrandomwait()) * 1000;
  }
}

fogflash(var_0) {
  if(isdefined(level.lightningexploderindex))
    common_scripts\_exploder::exploder(level.lightningexploder[level.lightningexploderindex]);

  [[var_0]]();
}

lightningflash(var_0, var_1, var_2) {
  var_3[0] = "quick";
  var_3[1] = "double";
  var_3[2] = "triple";
  thread thunder();

  if(!isdefined(var_2))
    var_2 = randomint(var_3.size);

  var_4 = 0;

  if(isdefined(level.lightningexploderindex)) {
    while (var_4 == level.lightningexploderindex)
      var_4 = randomint(level.lightningexploder.size);

    level.lightningexploderindex = var_4;
  }

  switch (var_3[var_2]) {
    case "quick":
      fogflash(var_1);
      break;
    case "double":
      fogflash(var_1);
      wait 0.05;
      fogflash(var_1);
      break;
    case "triple":
      fogflash(var_1);
      wait 0.05;
      fogflash(var_1);
      wait 0.5;
      fogflash(var_1);
      break;
  }
}

thunder() {
  if(level.rainlevel == 0)
    wait(6 + randomfloat(2));
  else if(level.rainlevel == 1)
    wait(5 + randomfloat(1.8));
  else if(level.rainlevel == 2)
    wait(4.5 + randomfloat(1.6));
  else if(level.rainlevel == 3)
    wait(4 + randomfloat(1.6));
  else if(level.rainlevel == 4)
    wait(3.5 + randomfloat(1.5));
  else if(level.rainlevel == 5)
    wait(3 + randomfloat(1.5));
  else if(level.rainlevel == 6)
    wait(2.5 + randomfloat(1.2));
  else if(level.rainlevel == 7)
    wait(2 + randomfloat(1));
  else if(level.rainlevel == 8)
    wait(1.9 + randomfloat(0.5));
  else if(level.rainlevel == 9)
    wait 1.5;
  else if(level.rainlevel == 10)
    wait 1;

  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.origin = level.player.origin + (0, 0, 80);
  var_0 linkto(level.player);

  if(level.rainlevel <= 8)
    var_0 playsound("elm_thunder_distant", "sounddone");
  else {
    var_0 playsound("elm_thunder_distant", "sounddone");
    var_0 thread maps\_utility::play_sound_on_entity("elm_thunder_strike");
  }

  var_0 waittill("sounddone");
  var_0 delete();
}