/********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_bumpercars.gsc
********************************************************/

init_bumper_cars() {
  var_0 = getEntArray("bumper_car", "targetname");
  if(!var_0.size) {
    return;
  }

  foreach(var_2 in var_0) {
    if(var_2.origin == (4113.9, 184.9, 112)) {
      var_2.fast_mover = 1;
    } else {
      var_2.fast_mover = 0;
    }

    var_2.dmgtrigger = getent(var_2.target, "targetname");
    var_2.dmgtrigger enablelinkto();
    var_2.dmgtrigger linkto(var_2);
    var_2.fwd_spot = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_2.rear_spot = scripts\engine\utility::getstruct(var_2.fwd_spot.target, "targetname");
    var_2.can_damage = 0;
    var_2.fwd_spot.origin = (var_2.fwd_spot.origin[0], var_2.fwd_spot.origin[1], var_2.origin[2]);
    var_2.rear_spot.origin = (var_2.rear_spot.origin[0], var_2.rear_spot.origin[1], var_2.origin[2]);
    scripts\engine\utility::waitframe();
  }

  level waittill("moon_bumpercars power_on");
  var_4 = getent("bumpercar_clip", "targetname");
  var_4 connectpaths();
  var_4 notsolid();
  foreach(var_6, var_2 in var_0) {
    var_2.name = "car_" + var_6;
    var_2 thread kill_zombies();
    scripts\engine\utility::waitframe();
  }

  level.bumper_car_impact_spots = scripts\engine\utility::getStructArray("bumpercar_impact", "targetname");
  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    foreach(var_6, var_2 in var_0) {
      var_2 activate_bumper_car(var_6);
    }
  }
}

activate_bumper_car(var_0) {
  var_1 = scripts\common\trace::create_character_contents();
  var_2 = [self];
  if(!isDefined(self.state)) {
    self.state = "rear";
    self.can_damage = 0;
  }

  var_3 = 1.75;
  if(self.fast_mover) {
    var_3 = 1.2;
  }

  wait(randomfloatrange(1, 3));
  if(self.state == "fwd") {
    for(;;) {
      var_4 = physics_spherecast(self.origin + (0, 0, 60), self.fwd_spot.origin + (0, 0, 60), 32, var_1, var_2, "physicsquery_all");
      if(var_4.size == 0) {
        break;
      }

      var_5 = 0;
      for(var_6 = 0; var_6 < var_4.size; var_6++) {
        if(!isDefined(var_4[var_6]["entity"])) {
          continue;
        }

        if(isPlayer(var_4[var_6]["entity"]) && scripts\cp\cp_laststand::player_in_laststand(var_4[var_6]["entity"]) || scripts\engine\utility::istrue(var_4[var_6]["entity"].isreviving)) {
          var_5 = 1;
        }
      }

      if(var_5) {
        return;
      } else {
        break;
      }

      wait(0.1);
    }

    if(self.fast_mover) {
      self playsoundonmovingent("trap_bumper_car_mvmt_short");
    } else {
      self playsoundonmovingent("trap_bumper_car_mvmt_long");
    }

    self setscriptablepartstate("bumpercar", "moving");
    wait(0.3);
    self playSound("trap_bumper_car_lights");
    self setscriptablepartstate("lights", "lights_on");
    wait(0.35);
    self setscriptablepartstate("lights", "lights_off");
    wait(0.35);
    self playSound("trap_bumper_car_lights");
    self setscriptablepartstate("lights", "lights_on");
    wait(0.35);
    self setscriptablepartstate("lights", "lights_off");
    wait(0.4);
    self setscriptablepartstate("lights", "lights_on");
    self playSound("trap_bumper_car_lights");
    wait(0.4);
    self setscriptablepartstate("lights", "lights_off");
    wait(0.5);
    self setscriptablepartstate("lights", "lights_on");
    self.can_damage = 1;
    self moveto(self.fwd_spot.origin, var_3);
    self.state = "rear";
  } else {
    for(;;) {
      var_4 = physics_spherecast(self.origin + (0, 0, 60), self.rear_spot.origin + (0, 0, 60), 32, var_1, var_2, "physicsquery_all");
      if(var_4.size == 0) {
        break;
      }

      var_5 = 0;
      for(var_6 = 0; var_6 < var_4.size; var_6++) {
        if(!isDefined(var_4[var_6]["entity"])) {
          continue;
        }

        if(isPlayer(var_4[var_6]["entity"]) && scripts\cp\cp_laststand::player_in_laststand(var_4[var_6]["entity"]) || scripts\engine\utility::istrue(var_4[var_6]["entity"].isreviving)) {
          var_5 = 1;
        }
      }

      if(var_5) {
        return;
      } else {
        break;
      }

      wait(0.1);
    }

    if(self.fast_mover) {
      self playsoundonmovingent("trap_bumper_car_mvmt_short");
    } else {
      self playsoundonmovingent("trap_bumper_car_mvmt_long");
    }

    self setscriptablepartstate("bumpercar", "moving");
    wait(0.05);
    self playSound("trap_bumper_car_lights");
    self setscriptablepartstate("lights", "lights_on");
    wait(0.35);
    self setscriptablepartstate("lights", "lights_off");
    wait(0.35);
    self playSound("trap_bumper_car_lights");
    self setscriptablepartstate("lights", "lights_on");
    wait(0.35);
    self setscriptablepartstate("lights", "lights_off");
    wait(0.4);
    self playSound("trap_bumper_car_lights");
    self setscriptablepartstate("lights", "lights_on");
    wait(0.4);
    self setscriptablepartstate("lights", "lights_off");
    wait(0.5);
    self setscriptablepartstate("lights", "lights_on");
    self.can_damage = 1;
    self moveto(self.rear_spot.origin, var_3);
    self.state = "fwd";
  }

  if(isDefined(self.nav_obs)) {
    destroynavobstacle(self.nav_obs);
  }

  self waittill("movedone");
  wait(0.1);
  self.can_damage = 0;
  self.nav_obs = createnavobstaclebybounds(self.origin, (56, 32, 32), self.angles);
  var_7 = scripts\engine\utility::getclosest(self.origin, level.bumper_car_impact_spots, 128);
  if(isDefined(var_7)) {
    playFX(level._effect["bumpercar_impact"], var_7.origin, anglesToForward((0, 270, 0)), anglestoup((0, 270, 0)));
  }

  self setscriptablepartstate("bumpercar", "impact");
  wait(0.15);
  self setscriptablepartstate("bumpercar", "normal");
  self setscriptablepartstate("lights", "lights_off");
}

kill_zombies() {
  for(;;) {
    self.dmgtrigger waittill("trigger", var_0);
    var_1 = getEntArray("placed_transponder", "script_noteworthy");
    foreach(var_3 in var_1) {
      if(var_0 == var_3) {
        if(isDefined(var_3.owner) && var_3.owner scripts\cp\utility::is_valid_player(1)) {
          var_3.owner scripts\cp\cp_weapon::placeequipmentfailed(var_0.weapon_name, 1, var_0.origin);
        }

        var_3 notify("detonateExplosive");
      }
    }

    if(!self.can_damage || isDefined(var_0.flung)) {
      continue;
    }

    if(!isPlayer(var_0) && !scripts\cp\utility::should_be_affected_by_trap(var_0)) {
      continue;
    }

    if((isPlayer(var_0) && !scripts\cp\cp_laststand::player_in_laststand(var_0)) || var_0.team == "allies") {
      var_0 thread push_and_damage_player(self);
      continue;
    }

    var_0 thread fling_zombie(self);
  }
}

fling_zombie(var_0) {
  self endon("death");
  var_1 = 250;
  self playSound("bumpercars_fling_zombie");
  self.flung = 1;
  self.customdeath = 1;
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  wait(0.05);
  wait(0.1);
  self playSound("trap_bumper_car_zombie_hit");
  self.disable_armor = 1;
  self.nocorpse = 1;
  var_2 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 4, var_1);
  foreach(var_4 in var_2) {
    var_4 thread scripts\cp\cp_vo::try_to_play_vo("trap_kill_rover", "zmb_comment_vo", "medium", 5, 0, 0, 1, 25);
  }

  self dodamage(self.health + 1000, var_0.origin);
}

push_and_damage_player(var_0) {
  self endon("death");
  self playSound("bumpercars_push_damage_plr");
  self.flung = 1;
  var_1 = sortbydistance(scripts\engine\utility::getStructArray("bumper_car_throw_spots", "targetname"), self.origin);
  self setorigin(var_1[0].origin, 0);
  self setvelocity(vectornormalize(self.origin - var_0.origin) * 300 + (0, 0, 100));
  wait(0.1);
  if(isPlayer(self) && !scripts\engine\utility::istrue(self.isrewinding)) {
    self dodamage(self.health + 100, var_0.origin);
  }

  wait(0.1);
  self.flung = undefined;
}