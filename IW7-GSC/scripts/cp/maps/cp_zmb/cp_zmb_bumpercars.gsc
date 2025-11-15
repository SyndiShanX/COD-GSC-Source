/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_bumpercars.gsc
********************************************************/

init_bumper_cars() {
  var_00 = getEntArray("bumper_car", "targetname");
  if(!var_00.size) {
    return;
  }

  foreach(var_02 in var_00) {
    if(var_02.origin == (4113.9, 184.9, 112)) {
      var_02.fast_mover = 1;
    } else {
      var_02.fast_mover = 0;
    }

    var_02.dmgtrigger = getent(var_02.target, "targetname");
    var_02.dmgtrigger enablelinkto();
    var_02.dmgtrigger linkto(var_02);
    var_02.fwd_spot = scripts\engine\utility::getstruct(var_02.target, "targetname");
    var_02.rear_spot = scripts\engine\utility::getstruct(var_02.fwd_spot.target, "targetname");
    var_02.can_damage = 0;
    var_02.fwd_spot.origin = (var_02.fwd_spot.origin[0], var_02.fwd_spot.origin[1], var_02.origin[2]);
    var_02.rear_spot.origin = (var_02.rear_spot.origin[0], var_02.rear_spot.origin[1], var_02.origin[2]);
    scripts\engine\utility::waitframe();
  }

  level waittill("moon_bumpercars power_on");
  var_04 = getent("bumpercar_clip", "targetname");
  var_04 connectpaths();
  var_04 notsolid();
  foreach(var_06, var_02 in var_00) {
    var_02.name = "car_" + var_06;
    var_02 thread kill_zombies();
    scripts\engine\utility::waitframe();
  }

  level.bumper_car_impact_spots = scripts\engine\utility::getstructarray("bumpercar_impact", "targetname");
  for(;;) {
    var_00 = scripts\engine\utility::array_randomize(var_00);
    foreach(var_06, var_02 in var_00) {
      var_02 activate_bumper_car(var_06);
    }
  }
}

activate_bumper_car(param_00) {
  var_01 = scripts\common\trace::create_character_contents();
  var_02 = [self];
  if(!isDefined(self.state)) {
    self.state = "rear";
    self.can_damage = 0;
  }

  var_03 = 1.75;
  if(self.fast_mover) {
    var_03 = 1.2;
  }

  wait(randomfloatrange(1, 3));
  if(self.state == "fwd") {
    for(;;) {
      var_04 = physics_spherecast(self.origin + (0, 0, 60), self.fwd_spot.origin + (0, 0, 60), 32, var_01, var_02, "physicsquery_all");
      if(var_04.size == 0) {
        break;
      }

      var_05 = 0;
      for(var_06 = 0; var_06 < var_04.size; var_06++) {
        if(!isDefined(var_04[var_06]["entity"])) {
          continue;
        }

        if(isplayer(var_04[var_06]["entity"]) && scripts\cp\cp_laststand::player_in_laststand(var_04[var_06]["entity"]) || scripts\engine\utility::istrue(var_04[var_06]["entity"].isreviving)) {
          var_05 = 1;
        }
      }

      if(var_05) {
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
    self moveto(self.fwd_spot.origin, var_03);
    self.state = "rear";
  } else {
    for(;;) {
      var_04 = physics_spherecast(self.origin + (0, 0, 60), self.rear_spot.origin + (0, 0, 60), 32, var_01, var_02, "physicsquery_all");
      if(var_04.size == 0) {
        break;
      }

      var_05 = 0;
      for(var_06 = 0; var_06 < var_04.size; var_06++) {
        if(!isDefined(var_04[var_06]["entity"])) {
          continue;
        }

        if(isplayer(var_04[var_06]["entity"]) && scripts\cp\cp_laststand::player_in_laststand(var_04[var_06]["entity"]) || scripts\engine\utility::istrue(var_04[var_06]["entity"].isreviving)) {
          var_05 = 1;
        }
      }

      if(var_05) {
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
    self moveto(self.rear_spot.origin, var_03);
    self.state = "fwd";
  }

  if(isDefined(self.nav_obs)) {
    destroynavobstacle(self.nav_obs);
  }

  self waittill("movedone");
  wait(0.1);
  self.can_damage = 0;
  self.nav_obs = createnavobstaclebybounds(self.origin, (56, 32, 32), self.angles);
  var_07 = scripts\engine\utility::getclosest(self.origin, level.bumper_car_impact_spots, 128);
  if(isDefined(var_07)) {
    playFX(level._effect["bumpercar_impact"], var_07.origin, anglesToForward((0, 270, 0)), anglestoup((0, 270, 0)));
  }

  self setscriptablepartstate("bumpercar", "impact");
  wait(0.15);
  self setscriptablepartstate("bumpercar", "normal");
  self setscriptablepartstate("lights", "lights_off");
}

kill_zombies() {
  for(;;) {
    self.dmgtrigger waittill("trigger", var_00);
    var_01 = getEntArray("placed_transponder", "script_noteworthy");
    foreach(var_03 in var_01) {
      if(var_00 == var_03) {
        if(isDefined(var_03.triggerportableradarping) && var_03.triggerportableradarping scripts\cp\utility::is_valid_player(1)) {
          var_03.triggerportableradarping scripts\cp\cp_weapon::placeequipmentfailed(var_00.weapon_name, 1, var_00.origin);
        }

        var_03 notify("detonateExplosive");
      }
    }

    if(!self.can_damage || isDefined(var_00.flung)) {
      continue;
    }

    if(!isplayer(var_00) && !scripts\cp\utility::should_be_affected_by_trap(var_00)) {
      continue;
    }

    if((isplayer(var_00) && !scripts\cp\cp_laststand::player_in_laststand(var_00)) || var_00.team == "allies") {
      var_00 thread push_and_damage_player(self);
      continue;
    }

    var_00 thread fling_zombie(self);
  }
}

fling_zombie(param_00) {
  self endon("death");
  var_01 = 250;
  self playSound("bumpercars_fling_zombie");
  self.flung = 1;
  self.customdeath = 1;
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  wait(0.05);
  wait(0.1);
  self playSound("trap_bumper_car_zombie_hit");
  self.disable_armor = 1;
  self.nocorpse = 1;
  var_02 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 4, var_01);
  foreach(var_04 in var_02) {
    var_04 thread scripts\cp\cp_vo::try_to_play_vo("trap_kill_rover", "zmb_comment_vo", "medium", 5, 0, 0, 1, 25);
  }

  self dodamage(self.health + 1000, param_00.origin);
}

push_and_damage_player(param_00) {
  self endon("death");
  self playSound("bumpercars_push_damage_plr");
  self.flung = 1;
  var_01 = sortbydistance(scripts\engine\utility::getstructarray("bumper_car_throw_spots", "targetname"), self.origin);
  self setorigin(var_01[0].origin, 0);
  self setvelocity(vectornormalize(self.origin - param_00.origin) * 300 + (0, 0, 100));
  wait(0.1);
  if(isplayer(self) && !scripts\engine\utility::istrue(self.isrewinding)) {
    self dodamage(self.health + 100, param_00.origin);
  }

  wait(0.1);
  self.flung = undefined;
}