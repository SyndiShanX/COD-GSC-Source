/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\weaponobjects.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#namespace weaponobjects;

function private autoexec __init__system__() {
  system::register(#"weaponobjects", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared(sessionmodeiscampaigngame() ? # "rob_sonar_set_friendlyequip_cp" : # "rob_sonar_set_friendlyequip_mp", #"rob_sonar_set_enemyequip");
  level setupscriptmovercompassicons();
  level setupmissilecompassicons();
}

function setupscriptmovercompassicons() {
  if(!isDefined(level.scriptmovercompassicons)) {
    level.scriptmovercompassicons = [];
  }

  level.scriptmovercompassicons[# "wpn_t7_turret_emp_core"] = "compass_empcore_white";
  level.scriptmovercompassicons[# "t6_wpn_turret_ads_world"] = "compass_guardian_white";
  level.scriptmovercompassicons[# "veh_t7_drone_uav_enemy_vista"] = "compass_uav";
  level.scriptmovercompassicons[# "veh_t7_mil_vtol_fighter_mp"] = "compass_lightningstrike";
  level.scriptmovercompassicons[# "veh_t7_drone_rolling_thunder"] = "compass_lodestar";
  level.scriptmovercompassicons[# "veh_t7_drone_srv_blimp"] = "t7_hud_minimap_hatr";
}

function setupmissilecompassicons() {
  if(!isDefined(level.missilecompassicons)) {
    level.missilecompassicons = [];
  }

  if(isDefined(getweapon(#"drone_strike"))) {
    level.missilecompassicons[getweapon(#"drone_strike")] = "compass_lodestar";
  }
}