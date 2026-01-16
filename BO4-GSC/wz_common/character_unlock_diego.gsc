/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_diego.gsc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_diego;

autoexec __init__system__() {
  system::register(#"character_unlock_diego", &__init__, undefined, #"character_unlock_diego_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"diego_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_downed(&on_player_downed);
  }
}

on_player_downed() {
  if(isDefined(self.laststandparams)) {
    attacker = self.laststandparams.attacker;

    if(!isplayer(attacker)) {
      return;
    }

    if(self.laststandparams.smeansofdeath != "MOD_HEAD_SHOT") {
      return;
    }

    if(!attacker util::isenemyteam(self.team)) {
      return;
    }

    if(!attacker character_unlock::function_f0406288(#"diego_unlock")) {
      return;
    }

    if(!isDefined(attacker.var_7128013a)) {
      attacker.var_7128013a = 0;
    }

    attacker.var_7128013a++;

    if(attacker.var_7128013a == 1) {
      attacker character_unlock::function_c8beca5e(#"diego_unlock", #"hash_7d0b41a17f2e9a9", 1);
    }
  }
}