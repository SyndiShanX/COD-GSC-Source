/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_battery.gsc
**************************************************/

#include script_71e26f08f03b7a7a;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_battery;

autoexec __init__system__() {
  system::register(#"character_unlock_battery", &__init__, undefined, #"character_unlock_battery_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"battery_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_player_killed(&on_player_killed);
    character_unlock::function_d2294476(#"supply_drop_stash_battery", 2, 3);
  }
}

on_player_killed() {
  function_b00fd65d();

  if(!isDefined(self.laststandparams)) {
    return;
  }

  attacker = self.laststandparams.attacker;
  weapon = self.laststandparams.sweapon;

  if(!isplayer(attacker) || !isDefined(weapon)) {
    return;
  }

  if(weapon.name != #"hero_pineapple_grenade" && weapon.name != #"hero_pineapplegun") {
    return;
  }

  if(!attacker util::isenemyteam(self.team)) {
    return;
  }

  if(!attacker character_unlock::function_f0406288(#"battery_unlock")) {
    return;
  }

  if(!isDefined(attacker.var_28411f6f)) {
    attacker.var_28411f6f = 0;
  }

  attacker.var_28411f6f++;

  if(attacker.var_28411f6f == 2) {
    attacker character_unlock::function_c8beca5e(#"battery_unlock", #"hash_c5713430b8fb888", 1);
  }
}

private function_b00fd65d() {
  maxteamplayers = isDefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 4;
  var_49170438 = globallogic::totalalivecount();

  if(var_49170438 < maxteamplayers + 2) {
    namespace_3d2704b3::function_d0178153(#"supply_drop_stash_battery");
  }
}