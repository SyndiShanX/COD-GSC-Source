/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_takeo.csc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_takeo;

autoexec __init__system__() {
  system::register(#"character_unlock_takeo", &__init__, undefined, #"character_unlock_takeo_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"takeo_unlock", &function_2613aeec);
  callback::on_finalize_initialization(&on_finalize_initialization);
}

on_finalize_initialization(localclientnum) {
  waitframe(1);
  level function_552910e9();
}

function_2613aeec(enabled) {
  if(!enabled) {
    level thread function_279880b1();
  }
}

function_279880b1() {
  item_world::function_4de3ca98();
  level function_552910e9();
}

function_552910e9() {
  dynent = getdynent(#"hash_7b220e1de3a2000d");

  if(isDefined(dynent)) {
    setdynentenabled(dynent, 0);
  }
}