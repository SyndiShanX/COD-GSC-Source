/***********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\kung_fu_mode_crane.gsc
***********************************************************/

setup_kung_fu_crane_powers() {
  crane_kill_fx();
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\powers\coop_powers::powersetupfunctions("power_shuriken_crane", ::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::set_dragon_shuriken_power, ::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::unset_dragon_shuriken_power, ::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::use_dragon_shuriken, undefined, undefined, undefined);
  init_valid_patch_nodes();
  level.is_in_crane_box_func = ::is_in_basic_box;
  setupinvalidcranevolumes();
  init_crane_teleport_spots();
}

crane_kill_fx() {
  level._effect["screen_blood"] = loadfx("vfx\iw7\levels\cp_disco\abilities\vfx_kf_crane_screen_blood.vfx");
}

crane_super_use(param_00) {
  self.crane_super = 1;
  self notify("super_fired");
  self notify("put_shuriken_away");
  self.kung_fu_shield = 1;
  scripts\engine\utility::allow_jump(0);
  scripts\engine\utility::allow_melee(0);
  self getquadrant();
  var_01 = 500;
  if(self.chi_meter_amount - var_01 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  self playgestureviewmodel("ges_crane_super_air_short", undefined, 1);
  self playanimscriptevent("power_active_cp", "gesture023");
  thread play_crane_feet_fx();
  var_02 = 500;
  var_03 = self getplayerangles();
  var_04 = anglesToForward(var_03);
  var_05 = vectornormalize(var_04) * var_02;
  var_05 = (var_05[0], var_05[1], 0);
  var_06 = create_move_path(var_05);
  if(var_06) {
    wait(0.25);
    self playanimscriptevent("power_active_cp", "gesture026");
  }

  self playanimscriptevent("power_active_cp", "gesture027");
  self.kung_fu_exit_delay = 0;
  self enableoffhandweapons();
  self.kung_fu_shield = undefined;
  scripts\engine\utility::allow_melee(1);
  scripts\engine\utility::allow_jump(1);
  wait(0.25);
  self notify("crane_power_done");
  self.crane_super = undefined;
  scripts\cp\powers\coop_powers::power_enablepower();
}

stay_in_kung_fu_till_gesture_done(param_00) {
  self endon("disconnect");
  var_01 = 500;
  if(self.chi_meter_amount - var_01 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  var_02 = self getgestureanimlength(param_00);
  wait(var_02);
  self.kung_fu_exit_delay = 0;
}

play_crane_feet_fx() {
  self setscriptablepartstate("kung_fu_super_fx", "crane");
  wait(2);
  self setscriptablepartstate("kung_fu_super_fx", "off");
}

crane_super_pose() {
  self endon("disconnect");
  self.is_slide_sfx_playing = 0;
  self.is_slide_land_sfx_playing = 0;
  while(self isjumping()) {
    wait(0.05);
  }

  scripts\engine\utility::allow_weapon(0);
  scripts\engine\utility::allow_jump(0);
  self limitedmovement(1);
  self allowprone(0);
  self allowcrouch(0);
  scripts\cp\utility::allow_player_teleport(0, "slide");
  self.ability_invulnerable = 1;
  self.disable_consumables = 1;
  self.ability_invulnerable = undefined;
  wait(1.5);
  self notify("offslide");
  self.is_slide_sfx_playing = 0;
  if(self.is_slide_land_sfx_playing == 0) {
    self.is_slide_land_sfx_playing = 1;
  }

  self unlink();
  self limitedmovement(0);
  self.disable_consumables = undefined;
  scripts\engine\utility::allow_jump(1);
  scripts\engine\utility::allow_weapon(1);
  self allowprone(1);
  self allowcrouch(1);
  self allowstand(1);
  self setstance("stand");
  if(!scripts\cp\utility::isteleportenabled()) {
    scripts\cp\utility::allow_player_teleport(1, "slide");
  }

  self.onslide = undefined;
  self notify("can_teleport");
}

slide_anim() {
  self endon("last_stand");
  self endon("death");
  self endon("disconnect");
  self endon("offslide");
  self endon("stopslideanim");
  var_00 = 0;
  while(scripts\engine\utility::istrue(self.onslide)) {
    if(self isgestureplaying()) {
      wait(0.1);
      continue;
    }

    if(!var_00) {
      self playanimscriptevent("power_active_cp", "gesture012");
      wait(0.1);
      var_00 = 1;
    }

    self playanimscriptevent("power_active_cp", "gesture020");
    wait(0.1);
  }
}

move_in_line() {
  var_00 = 0.1405408;
  var_01 = 1300;
  var_02 = getclosestpointonnavmesh(self.origin);
  var_03 = anglesToForward(self getplayerangles());
  var_04 = getclosestpointonnavmesh(var_02 + var_03);
  var_05 = vectornormalize(var_04 - var_02);
  var_05 = vectornormalize(var_05 + (0, 0, var_00));
  self setvelocity(var_05 * var_01);
  thread kill_near_me();
  wait(2.5);
  self notify("crane_power_done");
  self.crane_super = undefined;
  thread check_invalid_landing_place_and_teleport(self);
}

create_move_path(param_00) {
  var_01 = self getEye();
  var_02 = self.origin + (0, 0, 60);
  var_03 = self getplayerangles();
  var_04 = anglesToForward(var_03);
  var_04 = (var_04[0], var_04[1], 0);
  var_04 = vectornormalize(var_04) * 1000 + var_01;
  var_05 = level.players;
  var_06 = drop_points_on_path(var_02, var_04, 10);
  if(var_06.size < 1) {
    return 0;
  }

  var_07 = spawn("script_origin", self.origin + (0, 0, 30));
  var_07.angles = self.angles;
  self playerlinkto(var_07, undefined, 0, 10, 10, 10, 10, 1);
  thread kill_near_me();
  var_07 move_along_point_path(var_06, 0.5);
  self unlink();
  scripts\engine\utility::waitframe();
  thread final_location_check_loop();
  self setvelocity(param_00);
  wait(0.25);
  return 1;
}

drop_points_on_path(param_00, param_01, param_02) {
  var_03 = distance(param_00, param_01);
  var_04 = vectornormalize(param_01 - param_00);
  var_05 = var_03 / param_02;
  var_06 = level.players;
  var_07 = [];
  for(var_08 = 0; var_08 < param_02; var_08++) {
    var_09 = 0;
    if(var_07.size > 0) {
      param_00 = var_07[var_07.size - 1] + (0, 0, 30);
    }

    var_0A = param_00 + var_05 * var_04;
    var_0A = scripts\engine\utility::drop_to_ground(var_0A, 30, -5000);
    if(!navisstraightlinereachable(param_00, var_0A)) {
      var_0B = getclosestpointonnavmesh(var_0A);
      if(distancesquared(var_0B, var_0A) < 10000) {
        var_0A = var_0B;
      }
    }

    var_0A = var_0A + (0, 0, 10);
    if(!is_point_in_valid_place(var_0A, self)) {
      var_09 = 1;
    }

    if(var_07.size > 0) {
      var_0C = var_0A[2];
      var_0D = var_07[var_07.size - 1][2];
      if(var_0C > var_0D + 100) {
        var_09 = 1;
      }

      var_0E = var_0D - var_0C;
      if(var_0E > 1000) {
        var_09 = 1;
      } else if(var_0E > 100) {
        var_0A = (var_0A[0], var_0A[1], var_0C + var_0D / 2);
      }
    }

    if(!var_09) {
      var_07[var_07.size] = var_0A;
    }

    scripts\engine\utility::waitframe();
  }

  return var_07;
}

setupinvalidcranevolumes() {
  level.invalidcranevolumes = [];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(488, 704, 950), (560, 1240, 1206)];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(-1512, 3664, 1100), (-768, 3832, 1288)];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(-2048, 880, 1100), (-1920, 912, 1170)];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(-1328, 2592, 872), (-1408, 2480, 950)];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(-1472, 2592, 872), (-1536, 2480, 950)];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(60, 1236, 800), (138, 1266, 950)];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(488, 460, 942), (520, 730, 1020)];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(-278, 1265, 300), (-1510, 1819, 420)];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(-1468, 1749, 300), (-250, 2423, 420)];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(271, 2341, 450), (207, 2304, 350)];
  level.invalidcranevolumes[level.invalidcranevolumes.size] = [(-1440, 3968, 1032), (-1040, 4272, 1112)];
}

is_point_in_valid_place(param_00, param_01) {
  if(isDefined(level.active_volume_check)) {
    if(!self[[level.active_volume_check]](param_00)) {
      if(!is_in_valid_patch_zone(param_00)) {
        return 0;
      }
    }
  }

  if(!scripts\cp\cp_weapon::isinvalidzone(param_00, level.invalid_spawn_volume_array, param_01)) {
    return 0;
  }

  if(isDefined(level.invalidcranevolumes)) {
    if(isDefined(level.is_in_crane_box_func)) {
      foreach(var_03 in level.invalidcranevolumes) {
        if([
            [level.is_in_crane_box_func]
          ](var_03[0], var_03[1], param_00)) {
          return 0;
        }
      }
    }
  }

  if(isDefined(level.invalidtranspondervolumes)) {
    if(isDefined(level.is_in_box_func)) {
      foreach(var_03 in level.invalidtranspondervolumes) {
        if([
            [level.is_in_box_func]
          ](var_03[0], var_03[1], var_03[2], var_03[3], param_00)) {
          return 0;
        }
      }
    }
  }

  if(positionwouldtelefrag(param_00)) {
    return 0;
  }

  return 1;
}

final_location_check_loop() {
  self endon("death");
  var_00 = 20;
  for(var_01 = 0; var_01 < var_00; var_01++) {
    final_location_check();
    scripts\engine\utility::waitframe();
  }
}

final_location_check() {
  var_00 = self.origin;
  if(isDefined(level.invalidcranevolumes)) {
    if(isDefined(level.is_in_crane_box_func)) {
      foreach(var_02 in level.invalidcranevolumes) {
        if([
            [level.is_in_crane_box_func]
          ](var_02[0], var_02[1], var_00)) {
          var_03 = find_closest_crane_teleport(var_00);
          self dontinterpolate();
          self setorigin(var_03);
          scripts\engine\utility::waitframe();
        }
      }
    }
  }
}

init_crane_teleport_spots() {
  level.crane_teleport_spots = [];
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (-1232, 3773, 953);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (605, 796, 918);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (-2000, 944, 1110);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (-1408, 2544, 872);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (-1456, 2544, 872);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (100, 1282, 850);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (526, 684, 942);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (-599, 2263, 356);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (-1318, 2077, 356);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (-845, 1348, 356);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (-359, 1758, 356);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (236, 2373, 400);
  level.crane_teleport_spots[level.crane_teleport_spots.size] = (-1274, 3933, 1061);
}

find_closest_crane_teleport(param_00) {
  if(isDefined(level.crane_teleport_spots)) {
    var_01 = get_closest_vector(param_00, level.crane_teleport_spots);
    return var_01;
  }
}

get_closest_vector(param_00, param_01) {
  var_02 = undefined;
  var_03 = 100000;
  foreach(var_05 in param_01) {
    var_06 = distance(var_05, param_00);
    if(var_06 >= var_03) {
      continue;
    }

    var_03 = var_06;
    var_02 = var_05;
  }

  return var_02;
}

init_valid_patch_nodes() {
  level.valid_patch_nodes = [];
  create_valid_patch_node((913.9, 2246.6, 532.5), 150);
  create_valid_patch_node((225.9, 2246.6, 532.5), 150);
  create_valid_patch_node((1105.9, 1814.6, 612.5), 150);
  create_valid_patch_node((544, 320, 952), 100);
}

create_valid_patch_node(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.origin = param_00;
  var_02.var_56E8 = param_01 * param_01;
  level.valid_patch_nodes[level.valid_patch_nodes.size] = var_02;
}

is_in_basic_box(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    if(isplayer(self) || isagent(self)) {
      param_02 = self.origin;
    } else {
      return 0;
    }
  }

  for(var_03 = 0; var_03 < 3; var_03++) {
    if(!(param_02[var_03] > param_00[var_03] && param_02[var_03] < param_01[var_03]) || param_02[var_03] > param_01[var_03] && param_02[var_03] < param_00[var_03]) {
      return 0;
    }
  }

  return 1;
}

is_in_valid_patch_zone(param_00) {
  var_01 = 0;
  foreach(var_03 in level.valid_patch_nodes) {
    if(distancesquared(param_00, var_03.origin) < var_03.var_56E8) {
      var_01 = 1;
    }
  }

  return var_01;
}

move_along_point_path(param_00, param_01) {
  var_02 = param_01 / param_00.size;
  for(var_03 = 0; var_03 < param_00.size - 1; var_03++) {
    var_04 = param_00[var_03];
    var_05 = param_00[var_03 + 1];
    move_to_spot(var_04, var_05, var_02);
  }
}

move_to_spot(param_00, param_01, param_02) {
  var_03 = param_02 / 0.05;
  for(var_04 = 0; var_04 < var_03; var_04++) {
    var_05 = var_04 / var_03;
    var_06 = vectorlerp(param_00, param_01, var_05);
    self.origin = var_06;
    scripts\engine\utility::waitframe();
  }
}

check_invalid_landing_place_and_teleport(param_00) {
  param_00 notify("crane_invalid_landing_check");
  param_00 endon("crane_invalid_landing_check");
  param_00 endon("disconnect");
  var_01 = get_teleport_spot_n_landing_z_coordinate(param_00);
  if(isDefined(var_01.landing_z_coordinate)) {
    while(param_00.origin[2] > var_01.landing_z_coordinate) {
      scripts\engine\utility::waitframe();
    }
  }

  if(isDefined(var_01.teleport_spot)) {
    kill_nearby_zombies(var_01.teleport_spot, param_00);
    param_00 setorigin(var_01.teleport_spot);
  }
}

kill_nearby_zombies(param_00, param_01) {
  var_02 = 625;
  foreach(var_04 in level.spawned_enemies) {
    if(distancesquared(var_04.origin, param_00) < var_02) {
      var_04.nocorpse = 1;
      var_04.full_gib = 1;
      var_04 dodamage(var_04.maxhealth, param_00, param_01, undefined, "MOD_EXPLOSIVE");
    }
  }
}

get_teleport_spot_n_landing_z_coordinate(param_00) {
  var_01 = spawnStruct();
  var_01.teleport_spot = undefined;
  var_01.landing_z_coordinate = undefined;
  if(!scripts\engine\utility::flag("rooftop_walkway_open")) {
    var_01.landing_z_coordinate = 990;
    if(param_00.origin[0] > -567) {
      var_01.teleport_spot = getclosestpointonnavmesh((-597, param_00.origin[1], param_00.origin[2]));
    }
  }

  return var_01;
}

kill_near_me() {
  self endon("crane_power_done");
  var_00 = 150;
  var_01 = var_00 * var_00;
  for(;;) {
    foreach(var_03 in level.spawned_enemies) {
      if(distancesquared(var_03.origin, self.origin) < var_01) {
        playFX(level._effect["nunchuck_pap1"], var_03.origin + (0, 0, 30));
        var_03 dodamage(var_03.maxhealth, self.origin, self, undefined, "MOD_EXPLOSIVE");
      }
    }

    scripts\engine\utility::waitframe();
  }
}