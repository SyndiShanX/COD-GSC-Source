/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_idgun.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_vortex;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_weapons;
#namespace idgun;

function autoexec __init__sytem__() {
  system::register("idgun", & init, undefined, undefined);
}

function init() {
  level.weaponnone = getweapon("none");
  level.var_29323b70 = getweapon("robotech_launcher");
  level.var_672ab258 = getweapon("robotech_launcher_upgraded");
  construct_idgun_weapon_array();
  callback::on_spawned( & function_50ee0a95);
}

function function_50ee0a95(localclientnum) {}

function function_e1efbc50(var_9727e47e) {
  if(var_9727e47e != level.weaponnone) {
    if(!isDefined(level.idgun_weapons)) {
      level.idgun_weapons = [];
    } else if(!isarray(level.idgun_weapons)) {
      level.idgun_weapons = array(level.idgun_weapons);
    }
    level.idgun_weapons[level.idgun_weapons.size] = var_9727e47e;
  }
}

function construct_idgun_weapon_array() {
  level.idgun_weapons = [];
  function_e1efbc50(getweapon("idgun_0"));
  function_e1efbc50(getweapon("idgun_1"));
  function_e1efbc50(getweapon("idgun_2"));
  function_e1efbc50(getweapon("idgun_3"));
  function_e1efbc50(getweapon("idgun_upgraded_0"));
  function_e1efbc50(getweapon("idgun_upgraded_1"));
  function_e1efbc50(getweapon("idgun_upgraded_2"));
  function_e1efbc50(getweapon("idgun_upgraded_3"));
}

function function_9b7ac6a9(weapon) {
  if(weapon === getweapon("idgun_upgraded_0") || weapon === getweapon("idgun_upgraded_1") || weapon === getweapon("idgun_upgraded_2") || weapon === getweapon("idgun_upgraded_3")) {
    return true;
  }
  return false;
}

function is_idgun_damage(weapon) {
  if(isDefined(level.idgun_weapons)) {
    if(isinarray(level.idgun_weapons, weapon)) {
      return true;
    }
  }
  return false;
}