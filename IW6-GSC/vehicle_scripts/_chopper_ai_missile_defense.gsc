/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_chopper_ai_missile_defense.gsc
***********************************************************/

_precache() {
  precachemodel("angel_flare_rig");
  _fx();
  flare_rig_anims();
}

_fx() {
  common_scripts\utility::add_fx("FX_chopper_flare_ai", "fx/_requests/apache/apache_flare_ai");
  common_scripts\utility::add_fx("FX_chopper_flare_explosion_ai", "fx/_requests/apache/apache_trophy_explosion_ai");
  common_scripts\utility::add_fx("FX_hind_damaged_smoke_heavy", "fx/smoke/smoke_trail_black_heli");
}

#using_animtree("script_model");

flare_rig_anims() {
  level.scr_animtree["ai_flare_rig"] = #animtree;
  level.scr_model["ai_flare_rig"] = "angel_flare_rig";
  level.scr_anim["ai_flare_rig"]["flare"][0] = % ac130_angel_flares01;
  level.scr_anim["ai_flare_rig"]["flare"][1] = % ac130_angel_flares02;
  level.scr_anim["ai_flare_rig"]["flare"][2] = % ac130_angel_flares03;
}

_init(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.owner = var_0;
  var_2.vehicle = var_0;
  var_2.vehicle.missile_defense = var_2;
  var_2.type = "missile_defense";
  var_2.lockedontome = [];
  var_2.firedonme = [];
  var_2.flareindex = 0;
  var_2.flares = [];
  var_2.flarenumpairs = 2;
  var_2.flarecooldown = common_scripts\utility::ter_op(isDefined(var_1), var_1, 6);
  var_2.flarereloadtime = 0;
  var_2.flareactiveradius = 4000;
  var_2.flarefx = common_scripts\utility::getfx("FX_chopper_flare_ai");
  var_2.flarefxexplode = common_scripts\utility::getfx("FX_chopper_flare_explosion_ai");
  var_2.missiletargetflareradius = 1500;
  var_2.flaredestroymissileradius = 192;
  var_2.flarespawnmaxpitchoffset = 20;
  var_2.flarespawnminpitchoffset = 10;
  var_2.flarespawnmaxyawoffset = 80;
  var_2.flarespawnminyawoffset = 55;
  var_2.flarespawnoffsetright = 104;
  var_2.flarerig_name = "ai_flare_rig";
  var_2.flarerig_animrate = 2;
  var_2.flarerig_link = 0;
  var_2.flarerig_tagorigin = "tag_flare";
  var_2.flarerig_tagangles = "tag_origin";
  var_2.flaresound = "chopper_flare_fire_ai";
  return var_2;
}

_start() {
  var_0 = self.owner;
  var_0 endon("LISTEN_end_missile_defense");
  childthread vehicle_scripts\_chopper_missile_defense_utility::monitorenemymissilelockon();
  childthread vehicle_scripts\_chopper_missile_defense_utility::monitorenemymissilefire();
  childthread vehicle_scripts\_chopper_missile_defense_utility::monitorflarerelease_auto();
  childthread vehicle_scripts\_chopper_missile_defense_utility::monitorflares();
  childthread monitordeath();
}

_end() {
  var_0 = self.owner;
  var_0 notify("LISTEN_end_missile_defense");
}

monitordeath() {
  var_0 = self.owner;
  var_0 waittill("death");
  _destroy();
}

_destroy() {
  _end();
  self.vehicle.missile_defense = undefined;
}