/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\bromeo.gsc
***********************************************/

function main(var0, var1, var2) {
  scripts\common\vehicle_build::build_template("iveco_lynx", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_life(999, 500, 1500);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_lnd_bromeo", "veh8_mil_lnd_bromeo_static_dst");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8_mp/killstreak/vfx_tank_bromeo_death.vfx", "tag_origin", "veh_bradley_expl_destr");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8_mp/killstreak/vfx_tank_death_linger.vfx", "tag_origin");
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_grenadeshield(1);
  var3 = (0, 0, 0);
  scripts\common\vehicle_build::build_mainturret("tur_bradley", "tag_turret", "veh8_mil_lnd_bromeo_turret", "auto_nonai", 0, 0, var3);
  level._effect["lighttank_cannon_dust"] = loadfx("vfx/iw8/core/bradley/vfx_wk_tank_cannon_dust_light_w.vfx");
  level._effect["bradley_sp_headlight_l"] = loadfx("vfx/iw8/core/bradley/vfx_tank_headlight_l.vfx");
  level._effect["bradley_sp_headlight_r"] = loadfx("vfx/iw8/core/bradley/vfx_tank_headlight_r.vfx");
  level._effect["bradley_sp_gunlight"] = loadfx("vfx/iw8/core/bradley/vfx_tank_headlight_green.vfx");
  level._effect["bradley_sp_brakelight"] = loadfx("vfx/iw8/core/bradley/vfx_tank_brakelight.vfx");
  scripts\common\vehicle_build::build_light(var2, "headlight_L", "tag_headlights_left", "vfx/iw8/core/bradley/vfx_tank_headlight_l", "running", 0);
  scripts\common\vehicle_build::build_light(var2, "headlight_R", "tag_headlights_right", "vfx/iw8/core/bradley/vfx_tank_headlight_r", "running", 0);
  scripts\common\vehicle_build::build_light(var2, "brakelight_L", "tag_brakelight_left", "vfx/iw8/core/bradley/vfx_tank_brakelight", "running", 0);
  scripts\common\vehicle_build::build_light(var2, "brakelight_R", "tag_brakelight_right", "vfx/iw8/core/bradley/vfx_tank_brakelight", "running", 0);
  scripts\common\vehicle_build::build_light(var2, "gunlight", "tag_gunner_turret", "vfx/iw8/core/bradley/vfx_tank_headlight_green", "running", 0);
  scripts\common\vehicle_build::build_light(var2, "headlight_L", "tag_headlights_left", "vfx/iw8/core/bradley/vfx_tank_headlight_l", "headlights", 0);
  scripts\common\vehicle_build::build_light(var2, "headlight_R", "tag_headlights_right", "vfx/iw8/core/bradley/vfx_tank_headlight_r", "headlights", 0);
  scripts\common\vehicle_build::build_light(var2, "brakelight_L", "tag_brakelight_left", "vfx/iw8/core/bradley/vfx_tank_brakelight", "headlights", 0);
  scripts\common\vehicle_build::build_light(var2, "brakelight_R", "tag_brakelight_right", "vfx/iw8/core/bradley/vfx_tank_brakelight", "headlights", 0);
  scripts\common\vehicle_build::build_light(var2, "gunlight", "tag_gunner_turret", "vfx/iw8/core/bradley/vfx_tank_headlight_green", "headlights", 0);
}

function init_local() {
  thread onfire_fx();
  thread setup_turret();
  self.vehicle_skipdeathphysics = 1;
}

function setup_turret() {
  self.script_turretmain = 0;
  self.script_turretmg = 0;

  while(!isDefined(self.mainturret)) {
    waitframe();
  }

  self.mainturret makeunusable();

  if(!isDefined(self.mainturret.script_delay_min)) {
    self.mainturret.script_delay_min = 1;
  }

  if(!isDefined(self.mainturret.script_delay_max)) {
    self.mainturret.script_delay_max = 3;
  }

  if(!isDefined(self.mainturret.script_burst_min)) {
    self.mainturret.script_burst_min = 0.75;
  }

  if(!isDefined(self.mainturret.script_burst_max)) {
    self.mainturret.script_burst_max = 2;
  }

  if(!isDefined(self.mainturret.script_burst_fire_rate)) {
    self.mainturret.script_burst_fire_rate = 0.3;
    return;
  }
}

function unload_groups() {
  var0 = [];
  var1 = "passengers";
  var0 = [];
  var0[var0[var1].size] = 1;
  var0[var0[var1].size] = 2;
  var0[var0[var1].size] = 3;
  var1 = "all_but_gunner";
  var0 = [];
  var0[var0[var1].size] = 0;
  var0[var0[var1].size] = 1;
  var0[var0[var1].size] = 2;
  var1 = "rear_driver_side";
  var0 = [];
  var0[var0[var1].size] = 2;
  var1 = "all";
  var0 = [];
  var0[var0[var1].size] = 0;
  var0[var0[var1].size] = 1;
  var0[var0[var1].size] = 2;
  var0[var0[var1].size] = 3;
  var0 = var0["all"];
  return var0;
}

function onfire_fx() {
  self endon("death");

  while(!isDefined(get_main_turret())) {
    wait 0.05;
  }

  var0 = get_main_turret();

  for(;;) {
    var0 waittill("turret_fire");
    bradley_turretdustkickup(var0);
    var1 = self gettagorigin("tag_turret");

    if(player_isdriving()) {
      continue;
    }

    bradley_onfireshocknearplayers(var1);
  }
}

function bradley_onfirecamera() {
  self notify("bradley_onFireCamera");
  self endon("bradley_onFireCamera");
  self endon("bradley_exit");
  visionsetnaked("bradley_sp_fire");
  level.player setblurforplayer(1, 0);
  wait 0.2;
  visionsetnaked("bradley_sp", 1);
  level.player setblurforplayer(0, 0);
}

function bradley_turretdustkickup(var0) {
  var1 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_item"]);
  var2 = self getlinkedchildren();

  if(!isDefined(var2)) {
    var2 = [];
  }

  GscBinSkip0(0x2e, var2.size, self);
}

function bradley_onfireshocknearplayers(var0) {
  foreach(var2 in level.players) {
    if(player_drivingtank(var2)) {
      continue;
    }

    if(distancesquared(var2.origin, var0) > 16384) {}
  }
}

function mainturret_attack() {
  scripts\common\vehicle_code::_mainturreton();
  self.mainturret thread scripts\engine\utility::script_func("burst_fire_unmanned");
}

function mainturret_idle() {
  scripts\common\vehicle_code::_mainturretoff();
  self.mainturret notify("stop_burst_fire_unmanned");
}

function get_main_turret() {
  if(isDefined(self.mainturret)) {
    return self.mainturret;
  }
}

function player_isdriving() {
  if(isDefined(self.driver) && self.driver == level.player) {
    return true;
  }

  return false;
}

function player_drivingtank() {
  if(isDefined(self.drivingtank) && self.drivingtank) {
    return true;
  }

  return false;
}