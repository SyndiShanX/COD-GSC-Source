/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ix_scarlett.gsc
******************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ix_scarlett;

autoexec __init__system__() {
  system::register(#"character_unlock_ix_scarlett", &__init__, undefined, #"character_unlock_ix_scarlett_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"ix_scarlett_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::on_stash_open(&function_fcd28111);
  }
}

function_fcd28111(params) {
  if(!isDefined(params.activator)) {
    return;
  }

  activator = params.activator;

  if(!isplayer(activator)) {
    return;
  }

  if(!activator character_unlock::function_f0406288(#"ix_scarlett_unlock")) {
    return;
  }

  if(self.stash_type === 1) {
    activator character_unlock::function_c8beca5e(#"ix_scarlett_unlock", #"hash_74fceff1a255277d", 1);
  }
}