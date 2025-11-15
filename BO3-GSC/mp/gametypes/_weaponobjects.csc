/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_weaponobjects.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#namespace weaponobjects;

function autoexec __init__sytem__() {
  system::register("weaponobjects", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
  level setupscriptmovercompassicons();
  level setupmissilecompassicons();
}

function setupscriptmovercompassicons() {
  if(!isDefined(level.scriptmovercompassicons)) {
    level.scriptmovercompassicons = [];
  }
  level.scriptmovercompassicons["wpn_t7_turret_emp_core"] = "compass_empcore_white";
  level.scriptmovercompassicons["t6_wpn_turret_ads_world"] = "compass_guardian_white";
  level.scriptmovercompassicons["veh_t7_drone_uav_enemy_vista"] = "compass_uav";
  level.scriptmovercompassicons["veh_t7_mil_vtol_fighter_mp"] = "compass_lightningstrike";
  level.scriptmovercompassicons["veh_t7_drone_rolling_thunder"] = "compass_lodestar";
  level.scriptmovercompassicons["veh_t7_drone_srv_blimp"] = "t7_hud_minimap_hatr";
}

function setupmissilecompassicons() {
  if(!isDefined(level.missilecompassicons)) {
    level.missilecompassicons = [];
  }
  if(isDefined(getweapon("drone_strike"))) {
    level.missilecompassicons[getweapon("drone_strike")] = "compass_lodestar";
  }
}