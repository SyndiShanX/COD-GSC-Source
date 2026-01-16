/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_medals.gsc
***********************************************/

#include script_1d29de500c266470;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\contracts_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\loot_tracking;
#include scripts\core_common\match_record;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\player\player_record;
#include scripts\wz_common\gametypes\warzone;

#namespace wz_medals;

autoexec __init__system__() {
  system::register(#"wz_medals", &__init__, &__main__, undefined);
}

__init__() {
  callback::on_revived(&function_843da215);
  callback::on_player_killed_with_params(&function_f4837321);
}

__main__() {}

function_843da215(params) {
  if(!gamestate::is_state("playing") || !isplayer(params.reviver) || !isDefined(params.attacker)) {
    return;
  }

  if(params.attacker.team === params.reviver.team) {
    return;
  }

  weapon = getweapon(#"bare_hands");
  scoreevents::processscoreevent(#"revives", params.reviver, undefined, weapon);
}

function_f4837321(params) {
  if(!isDefined(self.laststandparams) || !isDefined(self.var_a1d415ee)) {
    return;
  }

  original_attacker = self.laststandparams.attacker;
  var_8efbdcbb = self.var_a1d415ee.attacker;
  weapon = self.laststandparams.sweapon;

  if(!isDefined(original_attacker) || !isplayer(var_8efbdcbb) || !isDefined(weapon)) {
    return;
  }

  if(var_8efbdcbb.team === self.team) {
    return;
  }

  if(original_attacker != var_8efbdcbb) {
    scoreevents::processscoreevent(#"assists", var_8efbdcbb, undefined, weapon);
  }
}