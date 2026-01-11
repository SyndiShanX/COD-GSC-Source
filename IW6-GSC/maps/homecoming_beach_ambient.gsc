/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_beach_ambient.gsc
*********************************************/

init_beach_ambient() {
  thread maps\homecoming_util::set_mortar_on(1);
  thread beach_wave1_hind_flybys();
}

beach_wave1_hind_flybys() {
  level endon("FLAG_stop_wave1_loops");
  var_0 = getEntArray("beach_wave1_hind_flybys", "targetname");
  var_1 = var_0;
  var_2 = cos(55);

  for(;;) {
    wait(randomfloatrange(5, 10));

    for(;;) {
      var_3 = var_1[randomint(var_1.size)];

      if(!maps\_utility::player_looking_at(var_3.origin, cos(45))) {
        break;
      }

      wait 0.1;
    }

    var_4 = var_3 maps\_vehicle::spawn_vehicle_and_gopath();
    var_4 vehicle_turnengineoff();
    var_4 waittill("death");
    var_1 = common_scripts\utility::array_remove(var_0, var_3);
  }
}

beach_nh90_flybys(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    level endon(var_2);
  }

  if(isstring(var_0)) {
    var_0 = getEntArray(var_0, "targetname");
  }

  var_3 = [];

  foreach(var_5 in var_0) {
    var_6 = var_5.script_noteworthy;

    if(!isDefined(var_3[var_6])) {
      var_3[var_6] = [];
    }

    var_3[var_6] = common_scripts\utility::array_add(var_3[var_6], var_5);
  }

  var_8 = var_3;

  for(;;) {
    wait(randomfloatrange(5, 10));
    var_9 = common_scripts\utility::random(var_8);
    var_9 = common_scripts\utility::array_randomize(var_9);
    var_10 = undefined;

    foreach(var_12 in var_9) {
      if(isDefined(var_1)) {
        if(level.player maps\_utility::player_looking_at(var_12.origin)) {
          continue;
        }
      }

      var_10 = var_12 maps\_vehicle::spawn_vehicle_and_gopath();
      wait(randomfloatrange(0.1, 0.5));
    }

    if(isDefined(var_10)) {
      var_10 waittill("deleted");
    }
  }
}

beach_ambient_helicopters() {
  var_0 = getEntArray("ambient_ship_flyers", "targetname");
  common_scripts\utility::array_thread(var_0, ::ambient_nh90_landers, 10, 16);
}

strafe_vehicles_add() {
  level.strafevehicles = common_scripts\utility::array_add(level.strafevehicles, self);
}

ambient_nh90_landers(var_0, var_1) {
  var_2 = self;
  var_3 = 10;

  if(isDefined(var_2.script_index)) {
    var_3 = var_2.script_index;
  }

  var_4 = [];

  for(;;) {
    var_4 = common_scripts\utility::array_removeundefined(var_4);

    while(var_4.size >= var_3) {
      var_4 = common_scripts\utility::array_removeundefined(var_4);
      wait 0.2;
    }

    var_5 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
    var_4 = common_scripts\utility::array_add(var_4, var_5);
    var_5 vehicle_turnengineoff();
    wait(randomintrange(var_0, var_1));
  }
}

ambient_hinds(var_0) {
  for(;;) {
    maps\_utility::script_delay();
    var_0 maps\_vehicle::spawn_vehicle_and_gopath();
  }
}

beach_ship_ambient_artillery() {
  level endon("stop_beach_ambient_artillery");
  var_0 = common_scripts\utility::getstructarray("beach_ship_ambient_artillery_spots", "targetname");

  for(;;) {
    var_0 = common_scripts\utility::array_randomize(var_0);

    foreach(var_2 in var_0) {
      var_3 = [];
      var_4 = strtok(var_2.script_parameters, " ");

      foreach(var_6 in var_4) {
      var_3 = common_scripts\utility::array_add(var_3, int(var_6));
      }

      var_8 = var_3[randomint(var_3.size)];
      var_9 = level.shipartilleryspots[var_8];
      maps\homecoming_util::fire_artillery_shell(var_9, var_2);
      wait(randomfloatrange(1.5, 3.5));
    }
  }
}

beach_ship_phalanx_start(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_4 maps\_utility::delaythread(var_2, ::beach_ship_phalanx_system);
    var_2 = var_2 + randomintrange(1, 3);
  }
}

beach_ship_phalanx_system() {
  var_0 = common_scripts\utility::getstructarray(self.target, "targetname");

  for(;;) {
    var_0 = common_scripts\utility::array_randomize(var_0);

    foreach(var_2 in var_0) {
      var_2 thread beach_ship_phalanx_think();
      wait(randomfloatrange(1.5, 2));
    }
  }
}

beach_ship_phalanx_think() {
  var_0 = spawn("script_origin", self.origin);
  var_1 = (270, 0, 90);
  var_2 = (270 + randomintrange(30, 50), 0, 90);
  var_0.angles = var_2;
  var_0 thread phalanx_fire();
  var_3 = randomfloatrange(0.4, 0.8);
  var_0 thread phalanx_incoming_hit(var_3);
  var_0 rotateto(var_1, var_3);
  var_0 waittill("rotatedone");
  var_0 notify("stop_fire");
  var_0 common_scripts\utility::delaycall(2, ::delete);
}

phalanx_fire() {
  self endon("stop_fire");
  self endon("death");

  for(;;) {
    var_0 = anglesToForward(self.angles);
    playFX(common_scripts\utility::getfx("phalanx_tracer"), self.origin, var_0);
    wait 0.05;
  }
}

phalanx_incoming_hit(var_0) {
  wait(var_0 - randomfloatrange(0.2, 0.3));
  var_1 = anglesToForward(self.angles);
  var_2 = self.origin + var_1 * randomintrange(2000, 8000);
  playFX(common_scripts\utility::getfx("phalanx_missile_explosion"), var_2);
}

beach_ship_phalanx_system_complex() {
  var_0 = common_scripts\utility::getstructarray("ship_phalanx_system", "targetname");

  foreach(var_2 in var_0) {
  var_2.used = 0;
  }

  var_4 = getent("anti_battleship_missiles", "targetname");
  var_5 = getvehiclenodearray("anti_battleship_missile_starts", "targetname");
  var_6 = undefined;

  for(;;) {
    var_7 = var_4 maps\_utility::spawn_vehicle();
    var_8 = undefined;

    for(;;) {
      var_8 = var_5[randomint(var_5.size)];

      if(!isDefined(var_6)) {
        break;
      }

      if(var_8 != var_6) {
        break;
      }
    }

    var_6 = var_8;
    var_7 maps\homecoming_util::attach_path_and_drive(var_8);
    var_7 thread phalanx_missile_think(var_0);
    wait(randomfloatrange(1.1, 1.3));
  }
}

phalanx_missile_think(var_0) {
  var_1 = self;
  var_2 = randomintrange(-9000, -8000);

  while(var_1.origin[0] > var_2) {
    wait 0.1;
  }

  var_3 = var_0;

  for(;;) {
    var_4 = sortbydistance(var_3, var_1.origin);
    var_4 = var_4[0];

    if(var_4.used) {
      var_3 = common_scripts\utility::array_remove(var_3, var_4);
    }
    else {
      break;
    }

    wait 0.05;
  }

  var_4.used = 1;
  var_5 = 0;
  var_6 = undefined;
  var_7 = randomintrange(-13500, -10500);

  while(var_1.origin[0] > var_7) {
    var_6 = vectornormalize(var_1.origin - var_4.origin + (-500, 0, 0));
    var_1 thread phalanx_fire(var_5, var_4.origin, var_6);
    var_5 = var_5 + randomfloatrange(0, 0.05);
    wait 0.05;
  }

  playFX(common_scripts\utility::getfx("phalanx_tracer"), var_4.origin, vectornormalize(var_1.origin - var_4.origin));
  playFX(common_scripts\utility::getfx("phalanx_missile_explosion"), var_1.origin);
  var_1 delete();
  var_4.used = 0;
}

phalanx_fire_complex(var_0, var_1, var_2) {
  self endon("death");
  wait(var_0);
  playFX(common_scripts\utility::getfx("phalanx_tracer"), var_1, var_2);
}