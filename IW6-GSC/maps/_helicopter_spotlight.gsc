/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_helicopter_spotlight.gsc
******************************************/

setup_spotlight_heli(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_1);
  level.spotlight_heli = var_3;
  var_3 thread heli_target_dialogue();

  if(!isDefined(var_3)) {
    return;
  }
  var_3 endon("death");
  var_3.state = "reveal";
  var_3.section = "market";
  var_3.spottarget_last_known_pos = (0, 0, 0);
  var_3.default_speed = 18;
  var_3.evade_health_threshold = 0.9;
  var_3.num_evasions = 2;
  var_3.reacquire_player_time = gettime() + 9000;
  var_3.focus_ally = 0;
  var_3.damage_fx = "none";
  var_3 thread spotlight_heli_on_death();
  var_3 thread spotlight_heli_trigger_death();
  var_3 maps\_vehicle::gopath();
  var_3 vehicle_setspeed(var_3.default_speed, 15, 15);
  var_3.etarget = level.player;
  var_3 vehicle_scripts\_attack_heli::heli_default_target_setup();
  var_3 thread vehicle_scripts\_attack_heli::heli_spotlight_on("tag_barrel", 0, 1);
  var_3 thread vehicle_scripts\_attack_heli::heli_spotlight_aim(::spotlight_heli_think);
  var_3 thread spotlight_heli_check_vision_set();
  var_3 spotlight_heli_update_spotlight_speed(0.33);

  if(var_2) {
    var_4 = anglesToForward(level.player.angles);
    var_5 = var_4 * 500;
    var_6 = var_5 + common_scripts\utility::randomvector(50);
    var_3.spottarget = spawn("script_origin", level.player.origin + var_5);
    var_3 vehicle_scripts\_attack_heli::heli_spotlight_destroy_default_targets();
    var_3 vehicle_scripts\_attack_heli::heli_spotlight_create_default_targets(var_3.spottarget);
  }

  return var_3;
}

heli_target_dialogue() {
  self endon("death");
  wait 0.5;
  var_0 = undefined;

  for(;;) {
    if(isDefined(self.spottarget)) {
      if(!isDefined(var_0) || var_0 != self.spottarget) {
        var_0 = self.spottarget;

        if(isDefined(var_0) && isplayer(var_0)) {
          return;
        }
      }
    }

    wait 1.0;
  }
}

spotlight_heli_on_death() {
  self waittill("death");
}

spotlight_heli_trigger_death() {
  self endon("death");

  if(isDefined(level.spotlight_heli)) {
    var_0 = anglesToForward(level.spotlight_heli.angles) * -1;
    var_1 = (level.spotlight_heli.origin + var_0 * 10000) * (1, 1, 0) + (0, 0, 600);
    level.spotlight_heli maps\_vehicle_code::vehicle_pathdetach();
    level.spotlight_heli vehicle_setspeed(100, 40, 40);
    level.spotlight_heli setvehgoalpos(var_1, 1);
    level.spotlight_heli waittill("near_goal");
    level.spotlight_heli delete();
  }
}

spotlight_heli_set_threatbias(var_0) {
  var_1 = level.allies["ally1"];

  if(isDefined(level.spotlight_heli) && level.spotlight_heli.focus_ally == 1) {
    var_0 = "none";
  }

  switch (var_0) {
    case "player":
      level.player.threatbias = 1000;

      if(isDefined(var_1)) {
        var_1.threatbias = 0;
      }

      break;
    case "ally":
      if(isDefined(var_1)) {
        var_1.threatbias = 1000;
      }

      level.player.threatbias = 0;
      break;
    case "none":
      level.player.threatbias = level.default_player_threatbias;

      if(isDefined(var_1)) {
        var_1.threatbias = 200;
      }

      break;
    default:
  }
}

spotlight_heli_check_vision_set() {
  self endon("death");
  var_0 = 0.25;

  for(;;) {
    if(vehicle_scripts\_attack_heli::can_see_player(level.player)) {
      var_1 = self gettagorigin("TAG_FLASH");
      var_2 = self gettagangles("TAG_FLASH");
      var_3 = anglesToForward(var_2);
      var_4 = level.player getEye() - var_1;
      var_4 = vectornormalize(var_4);
      var_5 = acos(vectordot(var_3, var_4));

      if(var_5 < 10) {} else {}
    } else {}

    wait(var_0);
  }
}

spotlight_heli_update_spotlight_speed(var_0) {}

spotlight_heli_think() {
  self endon("death");

  for(;;) {
    wait(randomfloatrange(1, 3));

    switch (self.state) {
      case "reveal":
        thread spotlight_heli_reveal_state();
        break;
      case "searching":
        thread spotlight_heli_searching_state();
        break;
      case "targeting":
        thread spotlight_heli_targeting_state();
        break;
      case "reacquire":
        thread spotlight_heli_reacquire_state();
        break;
      case "waiting":
        break;
      default:
        break;
    }
  }
}

spotlight_heli_reveal_state() {
  self endon("death");

  if(gettime() > self.reacquire_player_time) {
    vehicle_scripts\_attack_heli::heli_spotlight_destroy_default_targets();
    self.state = "searching";
  } else {
    vehicle_scripts\_attack_heli::heli_spotlight_destroy_default_targets();
    var_0 = anglesToForward(level.player.angles);
    var_1 = var_0 * 500;
    var_2 = var_1 + common_scripts\utility::randomvector(50);
    self.spottarget = spawn("script_origin", level.player.origin + var_1);
    vehicle_scripts\_attack_heli::heli_spotlight_create_default_targets(self.spottarget);
  }
}

spotlight_heli_searching_state() {
  self endon("death");
  var_0 = level.allies["ally1"];
  var_1 = self.focus_ally == 0 && vehicle_scripts\_attack_heli::can_see_player(level.player);
  var_2 = isDefined(var_0) && vehicle_scripts\_attack_heli::can_see_player(var_0);
  var_3 = 0;
  var_4 = 0;

  if(var_1 && var_2) {
    var_5 = randomint(3);

    if(var_5 == 2) {
      var_4 = 1;
    }
    else {
      var_3 = 1;
    }
  } else if(var_1)
    var_3 = 1;
  else if(var_2) {
    var_4 = 1;
  }
  else {
    spotlight_heli_default_targeting();
  }

  if(var_3) {
    self.spottarget = level.player;
    self.state = "targeting";
    maps\_utility::delaythread(1.0, ::spotlight_heli_update_spotlight_speed, 5.0);
  } else if(var_4) {
    self.spottarget = var_0;
    self.state = "targeting";
    maps\_utility::delaythread(1.0, ::spotlight_heli_update_spotlight_speed, 5.0);
  } else
    spotlight_heli_update_spotlight_speed(0.33);
}

spotlight_heli_targeting_state() {
  self endon("death");
  var_0 = level.allies["ally1"];

  if(isDefined(self.spottarget) && vehicle_scripts\_attack_heli::can_see_player(self.spottarget)) {
    self.spottarget_last_known_pos = self.spottarget.origin;

    if(self.focus_ally == 0) {
      if(self.spottarget != level.player) {
        var_1 = randomint(4);

        if(var_1 == 2) {
          if(vehicle_scripts\_attack_heli::can_see_player(level.player)) {
            self.spottarget = level.player;
            self.spottarget_last_known_pos = level.player.origin;
            spotlight_heli_update_spotlight_speed(0.75);
            maps\_utility::delaythread(0.75, ::spotlight_heli_update_spotlight_speed, 5.0);
            return;
          }

          return;
        }
      } else if(self.spottarget != var_0) {
        var_1 = randomint(7);

        if(var_1 == 3) {
          if(vehicle_scripts\_attack_heli::can_see_player(var_0)) {
            self.spottarget = var_0;
            self.spottarget_last_known_pos = var_0.origin;
            spotlight_heli_update_spotlight_speed(0.75);
            maps\_utility::delaythread(0.75, ::spotlight_heli_update_spotlight_speed, 5.0);
          }
        }
      }
    }
  } else {
    self.prevspottarget = self.spottarget;
    self.spottarget = spawn("script_origin", self.spottarget_last_known_pos);
    self.spottarget.angles = level.player.angles;
    self.reacquire_player_time = gettime() + 3000;

    if(self.focus_ally == 0) {
      self.reacquire_ally_time = gettime() + 10000;
    }
    else {
      self.reacquire_ally_time = gettime() + 2500;
    }

    vehicle_scripts\_attack_heli::heli_spotlight_destroy_default_targets();
    vehicle_scripts\_attack_heli::heli_spotlight_create_default_targets(self.spottarget);
    self.state = "reacquire";
    spotlight_heli_update_spotlight_speed(0.33);
  }
}

spotlight_heli_reacquire_state() {
  self endon("death");
  var_0 = level.allies["ally1"];

  if(isDefined(self.prevspottarget) && isDefined(self.spottarget_last_known_pos) && distance(self.prevspottarget.origin, self.spottarget_last_known_pos) > 500) {
    vehicle_scripts\_attack_heli::heli_spotlight_destroy_default_targets();
    spotlight_heli_default_targeting();
    self.state = "searching";
  } else if(gettime() > self.reacquire_player_time && vehicle_scripts\_attack_heli::can_see_player(level.player)) {
    vehicle_scripts\_attack_heli::heli_spotlight_destroy_default_targets();
    self.spottarget = level.player;
    self.state = "targeting";
    maps\_utility::delaythread(1.0, ::spotlight_heli_update_spotlight_speed, 5.0);
  } else if(gettime() > self.reacquire_ally_time && isDefined(var_0) && vehicle_scripts\_attack_heli::can_see_player(var_0)) {
    vehicle_scripts\_attack_heli::heli_spotlight_destroy_default_targets();
    self.spottarget = var_0;
    self.state = "targeting";
    maps\_utility::delaythread(1.0, ::spotlight_heli_update_spotlight_speed, 5.0);
  }
}

spotlight_heli_default_targeting() {
  self endon("death");
  var_0 = randomint(level.spotlight_aim_ents.size);
  self.targetdefault = level.spotlight_aim_ents[var_0];
  self.spottarget = self.targetdefault;
}