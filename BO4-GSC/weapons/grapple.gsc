/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\grapple.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;
#include scripts\weapons\weaponobjects;

#namespace grapple;

autoexec __init__system__() {
  system::register(#"grapple", &__init__, undefined, undefined);
}

__init__() {
  callback::on_spawned(&function_8fa5ff65);
  ability_player::register_gadget_activation_callbacks(20, undefined, &gadget_grapple_off);
  globallogic_score::register_kill_callback(getweapon(#"eq_grapple"), &function_d79e9bb5);
  weaponobjects::function_e6400478(#"eq_grapple", &function_422f24cc, 1);
}

function_422f24cc(watcher) {
  watcher.ondamage = &function_1987d583;
}

function_d79e9bb5(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(!isDefined(attacker) || isDefined(attackerweapon) && attackerweapon == weapon) {
    return false;
  }

  return attacker isgrappling() || isDefined(attacker.var_700a5910) && attacker.var_700a5910 + 2000 > gettime();
}

gadget_grapple_off(slot, weapon) {
  if(!function_d79e9bb5(self) && isDefined(level.var_228e8cd6)) {
    self[[level.var_228e8cd6]](weapon);
  }
}

function_8fa5ff65() {
  self thread function_9dd08ccf();
}

function_9dd08ccf() {
  self endon(#"death", #"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist");

  while(isDefined(self)) {
    self waittill(#"grapple_cancel");
    self.var_700a5910 = gettime();
  }
}

function_1987d583(watcher) {
  self setCanDamage(0);
}