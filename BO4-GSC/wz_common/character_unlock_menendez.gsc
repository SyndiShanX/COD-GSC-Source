/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_menendez.gsc
***************************************************/

#include script_71e26f08f03b7a7a;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_menendez;

autoexec __init__system__() {
  system::register(#"character_unlock_menendez", &__init__, undefined, #"character_unlock_menendez_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"menendez_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_player_killed(&on_player_killed);
    character_unlock::function_d2294476(#"supply_drop_stash_cu20", 2, 3);
  }
}

on_player_killed() {
  function_b00fd65d();
  params = self.var_a1d415ee;

  if(!isDefined(params)) {
    if(!isDefined(self.laststandparams) || isDefined(self.laststandparams.bledout) && self.laststandparams.bledout) {
      return;
    }

    params = self.laststandparams;
  }

  attacker = params.attacker;
  weapon = params.sweapon;
  means = params.smeansofdeath;

  if(!isplayer(attacker) || !isDefined(weapon)) {
    return;
  }

  if(!attacker util::isenemyteam(self.team)) {
    return;
  }

  if(!attacker character_unlock::function_f0406288(#"menendez_unlock")) {
    return;
  }

  if(weapon.weapclass === "spread") {
    if(!isDefined(attacker.var_a028bb76)) {
      attacker.var_a028bb76 = 0;
    }

    attacker.var_a028bb76++;
    attacker function_15d026c0();

    if(attacker.var_a028bb76 >= 2) {
      attacker character_unlock::function_c8beca5e(#"menendez_unlock", #"hash_4bc3134998048aa7", 1);
    }
  }
}

private function_15d026c0() {
  self playsoundtoplayer(#"hash_3e5c00ae62aa9c91", self);
}

private function_b00fd65d() {
  maxteamplayers = isDefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 4;
  var_49170438 = globallogic::totalalivecount();

  if(var_49170438 < maxteamplayers + 2) {
    namespace_3d2704b3::function_d0178153(#"supply_drop_stash_cu20");
  }
}