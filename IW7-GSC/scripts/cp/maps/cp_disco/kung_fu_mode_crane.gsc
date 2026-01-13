/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\kung_fu_mode_crane.gsc
***********************************************************/

setup_kung_fu_crane_powers() {
  crane_kill_fx();
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\powers\coop_powers::powersetupfunctions("power_shuriken_crane", scripts\cp\maps\cp_disco\kung_fu_mode_dragon::set_dragon_shuriken_power, ::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::unset_dragon_shuriken_power, ::scripts\cp\maps\cp_disco\kung_fu_mode_dragon::use_dragon_shuriken, undefined, undefined, undefined);
  init_valid_patch_nodes();
  level.is_in_crane_box_func = ::is_in_basic_box;
  setupinvalidcranevolumes();
  init_crane_teleport_spots();
}

crane_kill_fx() {
  level._effect["screen_blood"] = loadfx("vfx\iw7\levels\cp_disco\abilities\vfx_kf_crane_screen_blood.vfx");
}

crane_super_use(var_0) {
  self.crane_super = 1;
  self notify("super_fired");
  self notify("put_shuriken_away");
  self.kung_fu_shield = 1;
  scripts\engine\utility::allow_jump(0);
  scripts\engine\utility::allow_melee(0);
  self getquadrant();
  var_1 = 500;
  if(self.chi_meter_amount - var_1 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  self playgestureviewmodel("ges_crane_super_air_short", undefined, 1);
  self playanimscriptevent("power_active_cp", "gesture023");
  thread play_crane_feet_fx();
  var_2 = 500;
  var_3 = self getplayerangles();
  var_4 = anglesToForward(var_3);
  var_5 = vectornormalize(var_4) * var_2;
  var_5 = (var_5[0], var_5[1], 0);
  var_6 = create_move_path(var_5);
  if(var_6) {
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

stay_in_kung_fu_till_gesture_done(var_0) {
  self endon("disconnect");
  var_1 = 500;
  if(self.chi_meter_amount - var_1 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  var_2 = self getgestureanimlength(var_0);
  wait(var_2);
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
  var_0 = 0;
  while(scripts\engine\utility::istrue(self.onslide)) {
    if(self isgestureplaying()) {
      wait(0.1);
      continue;
    }

    if(!var_0) {
      self playanimscriptevent("power_active_cp", "gesture012");
      wait(0.1);
      var_0 = 1;
    }

    self playanimscriptevent("power_active_cp", "gesture020");
    wait(0.1);
  }
}

move_in_line() {
  var_0 = 0.1405408;
  var_1 = 1300;
  var_2 = getclosestpointonnavmesh(self.origin);
  var_3 = anglesToForward(self getplayerangles());
  var_4 = getclosestpointonnavmesh(var_2 + var_3);
  var_5 = vectornormalize(var_4 - var_2);
  var_5 = vectornormalize(var_5 + (0, 0, var_0));
  self setvelocity(var_5 * var_1);
  thread kill_near_me();
  wait(2.5);
  self notify("crane_power_done");
  self.crane_super = undefined;
  thread check_invalid_landing_place_and_teleport(self);
}

create_move_path(var_0) {
  var_1 = self getEye();
  var_2 = self.origin + (0, 0, 60);
  var_3 = self getplayerangles();
  var_4 = anglesToForward(var_3);
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = vectornormalize(var_4) * 1000 + var_1;
  var_5 = level.players;
  var_6 = drop_points_on_path(var_2, var_4, 10);
  if(var_6.size < 1) {
    return 0;
  }

  var_7 = spawn("script_origin", self.origin + (0, 0, 30));
  var_7.angles = self.angles;
  self playerlinkto(var_7, undefined, 0, 10, 10, 10, 10, 1);
  thread kill_near_me();
  var_7 move_along_point_path(var_6, 0.5);
  self unlink();
  scripts\engine\utility::waitframe();
  thread final_location_check_loop();
  self setvelocity(var_0);
  wait(0.25);
  return 1;
}

drop_points_on_path(var_0, var_1, var_2) {
  var_3 = distance(var_0, var_1);
  var_4 = vectornormalize(var_1 - var_0);
  var_5 = var_3 / var_2;
  var_6 = level.players;
  var_7 = [];
  for(var_8 = 0; var_8 < var_2; var_8++) {
    var_9 = 0;
    if(var_7.size > 0) {
      var_0 = var_7[var_7.size - 1] + (0, 0, 30);
    }

    var_0A = var_0 + var_5 * var_4;
    var_0A = scripts\engine\utility::drop_to_ground(var_0A, 30, -5000);
    if(!navisstraightlinereachable(var_0, var_0A)) {
      var_0B = getclosestpointonnavmesh(var_0A);
      if(distancesquared(var_0B, var_0A) < 10000) {
        var_0A = var_0B;
      }
    }

    var_0A = var_0A + (0, 0, 10);
    if(!is_point_in_valid_place(var_0A, self)) {
      var_9 = 1;
    }

    if(var_7.size > 0) {
      var_0C = var_0A[2];
      var_0D = var_7[var_7.size - 1][2];
      if(var_0C > var_0D + 100) {
        var_9 = 1;
      }

      var_0E = var_0D - var_0C;
      if(var_0E > 1000) {
        var_9 = 1;
      } else if(var_0E > 100) {
        var_0A = (var_0A[0], var_0A[1], var_0C + var_0D / 2);
      }
    }

    if(!var_9) {
      var_7[var_7.size] = var_0A;
    }

    scripts\engine\utility::waitframe();
  }

  return var_7;
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

is_point_in_valid_place(var_0, var_1) {
  if(isDefined(level.active_volume_check)) {
    if(!self[[level.active_volume_check]](var_0)) {
      if(!is_in_valid_patch_zone(var_0)) {
        return 0;
      }
    }
  }

  if(!scripts\cp\cp_weapon::isinvalidzone(var_0, level.invalid_spawn_volume_array, var_1)) {
    return 0;
  }

  if(isDefined(level.invalidcranevolumes)) {
    if(isDefined(level.is_in_crane_box_func)) {
      foreach(var_3 in level.invalidcranevolumes) {
        if([
            [level.is_in_crane_box_func]
          ](var_3[0], var_3[1], var_0)) {
          return 0;
        }
      }
    }
  }

  if(isDefined(level.invalidtranspondervolumes)) {
    if(isDefined(level.is_in_box_func)) {
      foreach(var_3 in level.invalidtranspondervolumes) {
        if([
            [level.is_in_box_func]
          ](var_3[0], var_3[1], var_3[2], var_3[3], var_0)) {
          return 0;
        }
      }
    }
  }

  if(positionwouldtelefrag(var_0)) {
    return 0;
  }

  return 1;
}

final_location_check_loop() {
  self endon("death");
  var_0 = 20;
  for(var_1 = 0; var_1 < var_0; var_1++) {
    final_location_check();
    scripts\engine\utility::waitframe();
  }
}

final_location_check() {
  var_0 = self.origin;
  if(isDefined(level.invalidcranevolumes)) {
    if(isDefined(level.is_in_crane_box_func)) {
      foreach(var_2 in level.invalidcranevolumes) {
        if([
            [level.is_in_crane_box_func]
          ](var_2[0], var_2[1], var_0)) {
          var_3 = find_closest_crane_teleport(var_0);
          self dontinterpolate();
          self setorigin(var_3);
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

find_closest_crane_teleport(var_0) {
  if(isDefined(level.crane_teleport_spots)) {
    var_1 = get_closest_vector(var_0, level.crane_teleport_spots);
    return var_1;
  }
}

get_closest_vector(var_0, var_1) {
  var_2 = undefined;
  var_3 = 100000;
  foreach(var_5 in var_1) {
    var_6 = distance(var_5, var_0);
    if(var_6 >= var_3) {
      continue;
    }

    var_3 = var_6;
    var_2 = var_5;
  }

  return var_2;
}

init_valid_patch_nodes() {
  level.valid_patch_nodes = [];
  create_valid_patch_node((913.9, 2246.6, 532.5), 150);
  create_valid_patch_node((225.9, 2246.6, 532.5), 150);
  create_valid_patch_node((1105.9, 1814.6, 612.5), 150);
  create_valid_patch_node((544, 320, 952), 100);
}

create_valid_patch_node(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.var_56E8 = var_1 * var_1;
  level.valid_patch_nodes[level.valid_patch_nodes.size] = var_2;
}

is_in_basic_box(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    if(isplayer(self) || isagent(self)) {
      var_2 = self.origin;
    } else {
      return 0;
    }
  }

  for(var_3 = 0; var_3 < 3; var_3++) {
    if(!(var_2[var_3] > var_0[var_3] && var_2[var_3] < var_1[var_3]) || var_2[var_3] > var_1[var_3] && var_2[var_3] < var_0[var_3]) {
      return 0;
    }
  }

  return 1;
}

is_in_valid_patch_zone(var_0) {
  var_1 = 0;
  foreach(var_3 in level.valid_patch_nodes) {
    if(distancesquared(var_0, var_3.origin) < var_3.var_56E8) {
      var_1 = 1;
    }
  }

  return var_1;
}

move_along_point_path(var_0, var_1) {
  var_2 = var_1 / var_0.size;
  for(var_3 = 0; var_3 < var_0.size - 1; var_3++) {
    var_4 = var_0[var_3];
    var_5 = var_0[var_3 + 1];
    move_to_spot(var_4, var_5, var_2);
  }
}

move_to_spot(var_0, var_1, var_2) {
  var_3 = var_2 / 0.05;
  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_4 / var_3;
    var_6 = vectorlerp(var_0, var_1, var_5);
    self.origin = var_6;
    scripts\engine\utility::waitframe();
  }
}

check_invalid_landing_place_and_teleport(var_0) {
  var_0 notify("crane_invalid_landing_check");
  var_0 endon("crane_invalid_landing_check");
  var_0 endon("disconnect");
  var_1 = get_teleport_spot_n_landing_z_coordinate(var_0);
  if(isDefined(var_1.landing_z_coordinate)) {
    while(var_0.origin[2] > var_1.landing_z_coordinate) {
      scripts\engine\utility::waitframe();
    }
  }

  if(isDefined(var_1.teleport_spot)) {
    kill_nearby_zombies(var_1.teleport_spot, var_0);
    var_0 setorigin(var_1.teleport_spot);
  }
}

kill_nearby_zombies(var_0, var_1) {
  var_2 = 625;
  foreach(var_4 in level.spawned_enemies) {
    if(distancesquared(var_4.origin, var_0) < var_2) {
      var_4.nocorpse = 1;
      var_4.full_gib = 1;
      var_4 dodamage(var_4.maxhealth, var_0, var_1, undefined, "MOD_EXPLOSIVE");
    }
  }
}

get_teleport_spot_n_landing_z_coordinate(var_0) {
  var_1 = spawnStruct();
  var_1.teleport_spot = undefined;
  var_1.landing_z_coordinate = undefined;
  if(!scripts\engine\utility::flag("rooftop_walkway_open")) {
    var_1.landing_z_coordinate = 990;
    if(var_0.origin[0] > -567) {
      var_1.teleport_spot = getclosestpointonnavmesh((-597, var_0.origin[1], var_0.origin[2]));
    }
  }

  return var_1;
}

kill_near_me() {
  self endon("crane_power_done");
  var_0 = 150;
  var_1 = var_0 * var_0;
  for(;;) {
    foreach(var_3 in level.spawned_enemies) {
      if(distancesquared(var_3.origin, self.origin) < var_1) {
        playFX(level._effect["nunchuck_pap1"], var_3.origin + (0, 0, 30));
        var_3 dodamage(var_3.maxhealth, self.origin, self, undefined, "MOD_EXPLOSIVE");
      }
    }

    scripts\engine\utility::waitframe();
  }
}