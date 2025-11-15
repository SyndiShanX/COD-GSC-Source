/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_scarlett.gsc
***************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_scarlett;

autoexec __init__system__() {
  system::register(#"character_unlock_scarlett", &__init__, undefined, #"character_unlock_scarlett_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"scarlett_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_player_killed(&on_player_killed);
  }
}

on_player_killed() {
  if(!isDefined(self.laststandparams)) {
    return;
  }

  attacker = self.laststandparams.attacker;
  inflictor = self.laststandparams.einflictor;
  mod = self.laststandparams.smeansofdeath;

  if(!isplayer(attacker) || !isvehicle(inflictor) || mod !== "MOD_CRUSH") {
    return;
  }

  if(!attacker util::isenemyteam(self.team)) {
    return;
  }

  if(!attacker character_unlock::function_f0406288(#"scarlett_unlock")) {
    return;
  }

  attacker character_unlock::function_c8beca5e(#"scarlett_unlock", #"hash_698918780b4406f1", 1);
}