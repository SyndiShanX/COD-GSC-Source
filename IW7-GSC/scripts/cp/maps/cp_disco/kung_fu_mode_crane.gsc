/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\kung_fu_mode_crane.gsc
***********************************************************/

setup_kung_fu_crane_powers() {
  crane_kill_fx();
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\powers\coop_powers::powersetupfunctions("power_shuriken_crane", scripts\cp\maps\cp_disco\kung_fu_mode_dragon::set_dragon_shuriken_power, scripts\cp\maps\cp_disco\kung_fu_mode_dragon::unset_dragon_shuriken_power, scripts\cp\maps\cp_disco\kung_fu_mode_dragon::use_dragon_shuriken, undefined, undefined, undefined);
}

crane_kill_fx() {
  level._effect["screen_blood"] = loadfx("vfx/iw7/levels/cp_disco/abilities/vfx_kf_crane_screen_blood.vfx");
}

crane_super_use(var_0) {
  self.crane_super = 1;
  self notify("super_fired");
  self notify("put_shuriken_away");
  self.kung_fu_shield = 1;
  scripts\engine\utility::allow_jump(0);
  scripts\engine\utility::allow_melee(0);
  self disableoffhandweapons();
  var_1 = 500;

  if(self.chi_meter_amount - var_1 <= 0) {
    self.kung_fu_exit_delay = 1;
  }

  self playgestureviewmodel("ges_crane_super_air_short", undefined, 1);
  self playanimscriptevent("power_active_cp", "gesture023");
  thread play_crane_feet_fx();
  create_move_path();
  wait 0.25;
  self playanimscriptevent("power_active_cp", "gesture026");
  self playanimscriptevent("power_active_cp", "gesture027");
  var_2 = 2000;
  self.kung_fu_exit_delay = 0;
  self enableoffhandweapons();
  self.kung_fu_shield = undefined;
  scripts\engine\utility::allow_melee(1);
  scripts\engine\utility::allow_jump(1);
  wait 0.25;
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
  wait 2;
  self setscriptablepartstate("kung_fu_super_fx", "off");
}

crane_super_pose() {
  self endon("disconnect");
  self.is_slide_sfx_playing = 0;
  self.is_slide_land_sfx_playing = 0;

  while(self isjumping()) {
    wait 0.05;
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
  wait 1.5;
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

  while(scripts\engine\utility::is_true(self.onslide)) {
    if(self isgestureplaying()) {
      wait 0.1;
      continue;
    }

    if(!var_0) {
      self playanimscriptevent("power_active_cp", "gesture012");
      wait 0.1;
      var_0 = 1;
    }

    self playanimscriptevent("power_active_cp", "gesture020");
    wait 0.1;
  }
}

move_in_line() {
  var_0 = 0.140541;
  var_1 = 1300;
  var_2 = getclosestpointonnavmesh(self.origin);
  var_3 = anglesToForward(self getplayerangles());
  var_4 = getclosestpointonnavmesh(var_2 + var_3);
  var_5 = vectorNormalize(var_4 - var_2);
  var_5 = vectorNormalize(var_5 + (0, 0, var_0));
  self setvelocity(var_5 * var_1);
  thread kill_near_me();
  wait 2.5;
  self notify("crane_power_done");
  self.crane_super = undefined;
  thread check_invalid_landing_place_and_teleport(self);
}

create_move_path() {
  var_0 = self getEye();
  var_1 = self.origin + (0, 0, 60);
  var_2 = self getplayerangles();
  var_3 = anglesToForward(var_2);
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = vectorNormalize(var_3) * 1000 + var_0;
  var_4 = level.players;
  var_5 = drop_points_on_path(var_1, var_3, 10);
  var_6 = spawn("script_origin", self.origin + (0, 0, 30));
  var_6.angles = self.angles;
  self playerlinkTo(var_6, undefined, 0, 10, 10, 10, 10, 1);
  thread kill_near_me();
  var_6 move_along_point_path(var_5, 0.5);
  self unlink();
  wait 0.25;
}

drop_points_on_path(var_0, var_1, var_2) {
  var_3 = distance(var_0, var_1);
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = var_3 / var_2;
  var_6 = level.players;
  var_7 = [];

  for(var_8 = 0; var_8 < var_2; var_8++) {
    if(var_8 > 0) {
      var_0 = var_7[var_8 - 1];
    }

    var_9 = var_0 + var_5 * var_4;
    var_10 = scripts\common\trace::sphere_trace(var_9 + (0, 0, 30), var_9 + (0, 0, -5000), 15, var_6);
    var_9 = var_10["position"];
    var_9 = var_9 + (0, 0, 10);

    if(var_8 > 0) {
      var_11 = var_9[2];
      var_12 = var_7[var_8 - 1][2];

      if(var_11 > var_12 + 100) {
        break;
      }

      var_13 = var_12 - var_11;

      if(var_13 > 1000) {
        break;
      } else if(var_13 > 100)
        var_9 = (var_9[0], var_9[1], (var_11 + var_12) / 2);
    }

    var_7[var_8] = var_9;
    scripts\engine\utility::waitframe();
  }

  return var_7;
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
    var_0 setOrigin(var_1.teleport_spot);
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