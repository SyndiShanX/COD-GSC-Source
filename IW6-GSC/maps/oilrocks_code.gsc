/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_code.gsc
*****************************************************/

array_keep_values(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) || !isDefined(var_2)) {
    return var_0;
  }

  var_3 = tolower(common_scripts\utility::ter_op(isDefined(var_3), var_3, "and"));

  switch (var_3) {
    case "or":
    case "and":
      break;
    default:
      var_3 = "and";
  }

  var_4 = [];
  var_5 = 1;

  foreach(var_7 in var_0) {
    switch (var_3) {
      case "and":
        var_5 = 1;

        foreach(var_11, var_9 in var_1) {
          var_10 = var_7 get_key(var_9);

          if(!compare(var_10, var_2[var_11])) {
            var_5 = var_5 * 0;
            break;
          }
        }

        break;
      case "or":
        var_5 = 0;

        foreach(var_11, var_9 in var_1) {
          var_10 = var_7 get_key(var_9);

          if(compare(var_10, var_2[var_11])) {
            var_5 = 1;
            break;
          }
        }

        break;
    }

    if(var_5) {
      var_4[var_4.size] = var_7;
    }
  }

  return var_4;
}

array_keep_key_values(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    var_6 = 0;

    foreach(var_8 in var_2) {
      if(var_5 compare_value(var_1, var_8)) {
        var_6 = 1;
        break;
      }
    }

    if(var_6) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

compare_value(var_0, var_1) {
  if(!isDefined(self) || !isDefined(var_1)) {
    return 0;
  }

  return compare(get_key(var_0), var_1);
}

compare(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    return common_scripts\utility::ter_op(var_0 == var_1, 1, 0);
  }

  if(isDefined(var_0) && !isDefined(var_1)) {
    return 0;
  }

  if(!isDefined(var_0) && isDefined(var_1)) {
    return 0;
  }

  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 0;
  }
}

get_key(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(self) || !isDefined(var_0)) {
    return common_scripts\utility::ter_op(isDefined(var_1) && !isDefined(var_2), var_1, var_2);
  }

  switch (var_0) {
    case "alpha":
      var_2 = self.alpha;
      break;
    case "angles":
      var_2 = common_scripts\utility::ter_op(isDefined(self.angles), self.angles, (0, 0, 0));
      break;
    case "classname":
      var_2 = self.classname;
      break;
    case "health":
      var_2 = self.health;
      break;
    case "magic_bullet_shield":
      var_2 = self.magic_bullet_shield;
      break;
    case "maxhealth":
      var_2 = self.maxhealth;
      break;
    case "origin":
      var_2 = self.origin;
      break;
    case "script_drone":
      var_2 = self.script_drone;
      break;
    case "script_friendname":
      var_2 = self.script_friendname;
      break;
    case "script_group":
      var_2 = self.script_group;
      break;
    case "script_index":
      var_2 = self.script_index;
      break;
    case "script_linkName":
      var_2 = self.script_linkname;
      break;
    case "script_linkTo":
      var_2 = self.script_linkto;
      break;
    case "script_noteworthy":
      var_2 = self.script_noteworthy;
      break;
    case "script_parameters":
      var_2 = self.script_parameters;
      break;
    case "script_specialops":
      var_2 = self.script_specialops;
      break;
    case "script_team":
      var_2 = self.script_team;
      break;
    case "script_vehicleride":
      var_2 = self.script_vehicleride;
      break;
    case "spawnflags":
      var_2 = self.spawnflags;
      break;
    case "speed":
      var_2 = self.speed;
      break;
    case "target":
      var_2 = self.target;
      break;
    case "targetname":
      var_2 = self.targetname;
      break;
    case "team":
      var_2 = self.team;
      break;
  }

  return common_scripts\utility::ter_op(isDefined(var_1) && !isDefined(var_2), var_1, var_2);
}

getteam() {
  if(isturret(self) && isDefined(self.script_team)) {
    return self.script_team;
  }

  if(maps\_vehicle::isvehicle() && isDefined(self.script_team)) {
    return self.script_team;
  }

  if(isDefined(self.team)) {
    return self.team;
  }

  return "none";
}

isturret(var_0) {
  return isDefined(var_0) && isDefined(var_0.classname) && issubstr(var_0.classname, "turret");
}

array_remove_undefined_dead_or_dying(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    if(isai(var_3) && var_3 maps\_utility::doinglongdeath()) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

giveunlimitedrpgammo() {
  self endon("death");

  for(;;) {
    self.a.rockets = 5;
    wait 1.0;
  }
}

addasapachehudtarget(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  var_0 vehicle_scripts\_apache_player::hud_addandshowtargets([self]);
}

apache_sun_settings() {
  level.apache_sun_settings = [];
  var_0 = [["sm_sunenable", 1.0],
    ["sm_sunsamplesizenear", 2.8],
    ["sm_sunShadowScale", 1]];

  foreach(var_2 in var_0) {
    level.apache_sun_settings[var_2[0]] = getdvarfloat(var_2[0]);
    setsaveddvar(var_2[0], var_2[1]);
  }
}

apache_sun_settings_restore() {
  foreach(var_2, var_1 in level.apache_sun_settings) {
  setsaveddvar(var_2, var_1);
  }
}

spawn_apache_player(var_0, var_1, var_2) {
  var_3 = get_apache_spawn_struct(var_0);
  return spawn_apache_player_at_struct(var_3, var_1, var_2);
}

spawn_apache_player_at_struct(var_0, var_1, var_2) {
  apache_sun_settings();
  var_3 = undefined;
  var_4 = getent("vehicle_apache_player", "targetname");
  var_4.origin = var_0.origin + (0, 0, 128);
  var_4.angles = var_0.angles;
  var_3 = maps\_vehicle::vehicle_spawn(var_4);
  var_3.targetname = "apache_player";
  var_3 makeentitysentient("allies");
  var_5 = isDefined(var_1) && isDefined(var_2);
  var_6 = 1;

  if(isDefined(level.apache_difficulty) && isDefined(level.apache_difficulty.flares_auto)) {
    var_6 = level.apache_difficulty.flares_auto;
  }

  var_3 vehicle_scripts\_apache_player::_start(level.player, var_5, var_6);
  var_3 thread apache_mission_impact_water_think();
  var_3 thread maps\oilrocks_apache_code::destructible_quakes_on();
  var_3 maps\oilrocks_apache_code::update_targets();

  if(var_5) {
    if(isDefined(var_1)) {
      setsaveddvar("vehHelicopterMaxAltitude", var_1);
    }

    if(isDefined(var_2)) {
      setsaveddvar("vehHelicopterMinAltitude", var_2);
    }
  }

  var_3 childthread maps\oilrocks_apache_code::manage_active_hind_forced_targets();

  if(isDefined(level.apache_savecheck)) {
    level.autosave_check_override = level.apache_savecheck;
  }

  return var_3;
}

apache_mission_impact_water_think() {
  level.apache_missile_water_z = -320;
  level.apache_missile_water_z_actual = -352;
  thread apache_mission_impact_water_missiles();
  self waittill("LISTEN_heli_end");
  level.apache_missile_water_z = undefined;
  level.apache_missile_water_z_actual = undefined;
}

apache_mission_impact_water_missiles() {
  self endon("LISTEN_heli_end");

  for(;;) {
    level waittill("LISTEN_apache_player_missile_fire", var_0);
  }
}

apache_mission_impact_water_missile_think() {
  self endon("death");

  while(isvalidmissile(self) && self.origin[2] >= level.apache_missile_water_z) {
    wait 0.05;
  }

  if(isvalidmissile(self) && isDefined(self.origin)) {
    if(self.origin[2] < level.apache_missile_water_z) {
      playFX(common_scripts\utility::getfx("FX_vfx_apache_missile_water_impact"), (self.origin[0], self.origin[1], level.apache_missile_water_z_actual + 5), (0, 0, 1), anglesToForward((0, randomint(360), 0)));
    }

    self delete();
  }
}

get_apache_spawn_struct(var_0) {
  var_1 = common_scripts\utility::getstructarray("apache", "targetname");
  var_2 = ["script_noteworthy", "script_parameters"];
  var_3 = ["player", var_0];
  var_4 = array_keep_values(var_1, var_2, var_3)[0];
  return var_4;
}

friendly_setup() {
  if(isai(self)) {
    maps\_utility::deletable_magic_bullet_shield();
  }
}

get_obj_ent_hvt() {
  if(!isDefined(level.obj_ent_hvt)) {
    level.obj_ent_hvt = common_scripts\utility::spawn_tag_origin();
  }

  level.obj_ent_hvt unlink();
  return level.obj_ent_hvt;
}

camlanding_from_apache(var_0, var_1, var_2, var_3) {
  player_in_out_apache();
  maps\oilrocks_slamzoom::vehicle_spline_cam(var_0, var_1, var_2, var_3);
}

player_in_out_apache() {
  if(isDefined(level.player.riding_heli)) {
    var_0 = level.player.riding_heli.origin;
    var_1 = level.player.riding_heli.angles;

    foreach(var_3 in level.apache_target_manager) {
    level.player.riding_heli thread vehicle_scripts\_apache_player::hud_hidetargets([var_3]);
    }

    level notify("new_missile_nag_thread");
    level.player.riding_heli vehicle_scripts\_apache_player::_end();
    apache_sun_settings_restore();
    level.player.riding_heli = undefined;
    level.player_apache_standin = maps\oilrocks_apache_code::spawn_apache_ally_targetname("apache_player_standin", "apache_player_standin", var_0, var_1);
    level.player_apache_standin thread maps\oilrocks_apache_code::self_make_chopper_boss(undefined, 1);
  } else if(isDefined(level.player_apache_standin)) {
    level.player_apache_standin delete();
    level.player_apache_standin = undefined;
  }
}

chopper_boss_path_override(var_0, var_1) {
  self endon("death");
  maps\_chopperboss::chopper_boss_pause_path_finding();
  self clearlookatent();
  self cleartargetyaw();
  maps\_vehicle::vehicle_paths(var_0, 0, var_1);
  maps\_chopperboss::chopper_boss_resume_path_finding();
}

chopper_boss_goto_hangout() {
  maps\_chopperboss_utility::chopper_boss_wait_populate();
  var_0 = maps\_chopperboss_utility::chopper_boss_get_closest_available_path_struct_2d(self.origin);
  thread chopper_boss_path_override(var_0, 1500);
}

spawn_infantry_friends(var_0) {
  var_1 = [];
  var_2 = getEntArray("team_a", "targetname");
  var_2 = array_keep_key_values(var_2, "script_noteworthy", ["blackhawk_riders"]);

  foreach(var_6, var_4 in var_2) {
    if(var_0) {
      var_4.script_drone = 1;
    }

    var_4.count = 1;
    var_5 = var_4 maps\_utility::spawn_ai(1);

    if(!isDefined(var_4.script_friendname)) {
      var_4.script_friendname = var_5.name;
    }

    var_5 thermaldrawdisable();
    var_5.script_startingposition = 5;

    if(isDefined(var_5.script_friendname)) {
      switch (var_5.script_friendname) {
        case "Merrick":
          level.merrick = var_5;
          level.merrick.animname = "merrick";
          var_5.script_startingposition = 3;
          break;
        case "Hesh":
          level.hesh = var_5;
          level.hesh.animname = "hesh";
          var_5.script_startingposition = 6;
          break;
        case "Keegan":
          level.keegan = var_5;
          level.keegan.animname = "keegan";
          var_5.script_startingposition = 2;
          break;
        default:
          if(!var_0) {
            var_5 delete();
            continue;
          }

          break;
      }
    }

    var_5.spawner = var_4;
    var_1[var_1.size] = var_5;
  }

  return var_1;
}

assign_friendly_heros() {
  foreach(var_1 in getaiarray("allies")) {
    if(!isDefined(var_1.script_friendname)) {
      continue;
    }
    if(!isDefined(var_1.magic_bullet_shield)) {
      var_1 friendly_setup();
    }

    switch (var_1.script_friendname) {
      case "Merrick":
        level.merrick = var_1;
        level.merrick.animname = "merrick";
        var_1.script_startingposition = 3;
        break;
      case "Hesh":
        level.hesh = var_1;
        level.hesh.animname = "hesh";
        var_1.script_startingposition = 6;
        break;
      case "Keegan":
        level.keegan = var_1;
        level.keegan.animname = "keegan";
        var_1.script_startingposition = 2;
        break;
      default:
        break;
    }
  }

  maps\_utility::delaythread(0.05, maps\_utility::set_team_bcvoice, "allies", "delta");
}

draw_my_position() {
  self endon("death");

  for(;;) {
    if(isDefined(self.animname)) {} else {}

    wait 0.05;
  }
}