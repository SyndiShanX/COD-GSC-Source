/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_bruno.gsc
************************************************/

#include script_71e26f08f03b7a7a;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_bruno;

autoexec __init__system__() {
  system::register(#"character_unlock_bruno", &__init__, undefined, #"character_unlock_bruno_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"bruno_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_downed(&on_player_downed);
    character_unlock::function_d2294476(#"supply_drop_stash_cu11", 3, 4);
  }
}

on_player_downed() {
  if(isDefined(self.laststandparams)) {
    attacker = self.laststandparams.attacker;

    if(!isplayer(attacker)) {
      return;
    }

    if(self.laststandparams.smeansofdeath != "MOD_MELEE" && self.laststandparams.smeansofdeath != "MOD_MELEE_WEAPON_BUTT") {
      return;
    }

    if(!attacker util::isenemyteam(self.team)) {
      return;
    }

    if(!attacker character_unlock::function_f0406288(#"bruno_unlock")) {
      return;
    }

    attacker character_unlock::function_c8beca5e(#"bruno_unlock", #"hash_21c5510d64c20b71", 1);
  }
}