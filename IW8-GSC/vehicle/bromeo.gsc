/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\bromeo.gsc
***********************************************/

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("iveco_lynx", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_life(999, 500, 1500);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_lnd_bromeo", "veh8_mil_lnd_bromeo_static_dst");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8_mp/killstreak/vfx_tank_bromeo_death.vfx", "tag_origin", "veh_bradley_expl_destr");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8_mp/killstreak/vfx_tank_death_linger.vfx", "tag_origin");
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_grenadeshield(1);
  var_3 = (0, 0, 0);
  scripts\common\vehicle_build::build_mainturret("tur_bradley", "tag_turret", "veh8_mil_lnd_bromeo_turret", "auto_nonai", 0, 0, var_3);
  level._effect["lighttank_cannon_dust"] = loadfx("vfx/iw8/core/bradley/vfx_wk_tank_cannon_dust_light_w.vfx");
  level._effect["bradley_sp_headlight_l"] = loadfx("vfx/iw8/core/bradley/vfx_tank_headlight_l.vfx");
  level._effect["bradley_sp_headlight_r"] = loadfx("vfx/iw8/core/bradley/vfx_tank_headlight_r.vfx");
  level._effect["bradley_sp_gunlight"] = loadfx("vfx/iw8/core/bradley/vfx_tank_headlight_green.vfx");
  level._effect["bradley_sp_brakelight"] = loadfx("vfx/iw8/core/bradley/vfx_tank_brakelight.vfx");
  scripts\common\vehicle_build::build_light(var_2, "headlight_L", "tag_headlights_left", "vfx/iw8/core/bradley/vfx_tank_headlight_l", "running", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "headlight_R", "tag_headlights_right", "vfx/iw8/core/bradley/vfx_tank_headlight_r", "running", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "brakelight_L", "tag_brakelight_left", "vfx/iw8/core/bradley/vfx_tank_brakelight", "running", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "brakelight_R", "tag_brakelight_right", "vfx/iw8/core/bradley/vfx_tank_brakelight", "running", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "gunlight", "tag_gunner_turret", "vfx/iw8/core/bradley/vfx_tank_headlight_green", "running", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "headlight_L", "tag_headlights_left", "vfx/iw8/core/bradley/vfx_tank_headlight_l", "headlights", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "headlight_R", "tag_headlights_right", "vfx/iw8/core/bradley/vfx_tank_headlight_r", "headlights", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "brakelight_L", "tag_brakelight_left", "vfx/iw8/core/bradley/vfx_tank_brakelight", "headlights", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "brakelight_R", "tag_brakelight_right", "vfx/iw8/core/bradley/vfx_tank_brakelight", "headlights", 0.0);
  scripts\common\vehicle_build::build_light(var_2, "gunlight", "tag_gunner_turret", "vfx/iw8/core/bradley/vfx_tank_headlight_green", "headlights", 0.0);
}

init_local() {
  thread onfire_fx();
  thread setup_turret();
  self.vehicle_skipdeathphysics = 1;
}

setup_turret() {
  self.script_turretmain = 0;
  self.script_turretmg = 0;

  while(!isDefined(self.mainturret))
    waitframe();

  self.mainturret makeunusable();

  if(!isDefined(self.mainturret.script_delay_min))
    self.mainturret.script_delay_min = 1.0;

  if(!isDefined(self.mainturret.script_delay_max))
    self.mainturret.script_delay_max = 3;

  if(!isDefined(self.mainturret.script_burst_min))
    self.mainturret.script_burst_min = 0.75;

  if(!isDefined(self.mainturret.script_burst_max))
    self.mainturret.script_burst_max = 2;

  if(!isDefined(self.mainturret.script_burst_fire_rate))
    self.mainturret.script_burst_fire_rate = 0.3;
}

unload_groups() {
  var_0 = [];
  var_1 = "passengers";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_1 = "all_but_gunner";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_1 = "rear_driver_side";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 2;
  var_1 = "all";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0["default"] = var_0["all"];
  return var_0;
}

onfire_fx() {
  self endon("death");

  while(!isDefined(get_main_turret()))
    wait 0.05;

  var_0 = get_main_turret();

  for(;;) {
    var_0 waittill("turret_fire");
    bradley_turretdustkickup(var_0);
    var_1 = self gettagorigin("tag_turret");

    if(player_isdriving()) {
      continue;
    }
    bradley_onfireshocknearplayers(var_1);
  }
}

bradley_onfirecamera() {
  self notify("bradley_onFireCamera");
  self endon("bradley_onFireCamera");
  self endon("bradley_exit");
  visionsetnaked("bradley_sp_fire");
  level.player setblurforplayer(1.0, 0.0);
  wait 0.2;
  visionsetnaked("bradley_sp", 1.0);
  level.player setblurforplayer(0.0, 0.0);
}

bradley_turretdustkickup(var_0) {
  var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_item"]);
  var_2 = self getlinkedchildren();

  if(!isDefined(var_2))
    var_2 = [];

  var_2[var_2.size] = self;
  var_3 = var_0 gettagorigin("tag_flash");
  var_4 = var_3 + (-0, -0, -200);
  var_5 = physics_raycast(var_3, var_4, var_1, var_2, 0, "physicsquery_closest", 1);

  if(!isDefined(var_5) || !var_5.size) {
    return;
  }
  var_6 = anglesToForward(var_0 gettagangles("tag_flash") * (0, 1, 0));
  var_7 = var_5[0]["normal"];
  var_8 = vectorcross(var_6, var_7);
  var_7 = vectorcross(var_8, var_6);
  var_9 = axistoangles(var_6, var_8, var_7);
  playFX(scripts\engine\utility::getfx("lighttank_cannon_dust"), var_5[0]["position"], anglesToForward(var_9), anglestoup(var_9));
}

bradley_onfireshocknearplayers(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 player_drivingtank()) {
      continue;
    }
    if(distancesquared(var_2.origin, var_0) > 16384)
      continue;
  }
}

mainturret_attack() {
  scripts\common\vehicle_code::_mainturreton();
  self.mainturret thread scripts\engine\utility::script_func("burst_fire_unmanned");
}

mainturret_idle() {
  scripts\common\vehicle_code::_mainturretoff();
  self.mainturret notify("stop_burst_fire_unmanned");
}

get_main_turret() {
  if(isDefined(self.mainturret))
    return self.mainturret;
}

player_isdriving() {
  if(isDefined(self.driver) && self.driver == level.player)
    return 1;

  return 0;
}

player_drivingtank() {
  if(isDefined(self.drivingtank) && self.drivingtank)
    return 1;

  return 0;
}