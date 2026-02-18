/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\grapple.gsc
***********************************************/

#using scripts\abilities\ability_player;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\weapons\weaponobjects;
#namespace grapple;

function private autoexec __init__system__() {
  system::register(#"grapple", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  ability_player::register_gadget_activation_callbacks(20, undefined, &gadget_grapple_off);
  globallogic_score::register_kill_callback(getweapon(#"eq_grapple"), &function_d79e9bb5);
  weaponobjects::function_e6400478(#"eq_grapple", &function_422f24cc, 1);
}

function function_422f24cc(watcher) {
  watcher.ondamage = &function_1987d583;
}

function function_d79e9bb5(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(!isDefined(weapon) || isDefined(meansofdeath) && meansofdeath == attackerweapon) {
    return false;
  }

  return weapon isgrappling() || isDefined(weapon.var_700a5910) && weapon.var_700a5910 + 2000 > gettime();
}

function gadget_grapple_off(slot, weapon) {
  if(!function_d79e9bb5(self)) {
    self battlechatter::function_916b4c72(weapon);
  }
}

function event_handler[grapple_cancel] function_cb368201(eventstruct) {
  self.var_700a5910 = gettime();
}

function function_1987d583(watcher) {
  self setCanDamage(0);
}