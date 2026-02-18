/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\wz_medals.gsc
***********************************************/

#using script_1d29de500c266470;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\loot_tracking;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\player\player_record;
#namespace wz_medals;

function private autoexec __init__system__() {
  system::register(#"wz_medals", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_revived(&function_843da215);
  callback::on_player_killed(&function_f4837321);
}

function function_843da215(params) {
  if(!gamestate::is_state(#"playing") || !isPlayer(params.reviver) || !isDefined(params.attacker)) {
    return;
  }

  if(params.attacker.team === params.reviver.team) {
    return;
  }

  weapon = getweapon(#"bare_hands");
  scoreevents::processscoreevent(#"revives", params.reviver, undefined, weapon);
}

function function_f4837321(params) {
  if(!isDefined(self.laststandparams) || !isDefined(self.var_a1d415ee)) {
    return;
  }

  original_attacker = self.laststandparams.attacker;
  var_8efbdcbb = self.var_a1d415ee.attacker;
  weapon = self.laststandparams.weapon;

  if(!isDefined(original_attacker) || !isPlayer(var_8efbdcbb) || !isDefined(weapon)) {
    return;
  }

  if(var_8efbdcbb.team === self.team) {
    return;
  }

  if(original_attacker != var_8efbdcbb) {
    scoreevents::processscoreevent(#"assists", var_8efbdcbb, undefined, weapon);
  }
}