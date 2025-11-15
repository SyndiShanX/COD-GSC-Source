/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_seraph.csc
*************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world;
#include scripts\wz_common\character_unlock_fixup;
#include scripts\wz_common\wz_firing_range;

#namespace character_unlock_seraph;

autoexec __init__system__() {
  system::register(#"character_unlock_seraph", &__init__, undefined, #"character_unlock_seraph_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"seraph_unlock", &function_2613aeec);
  callback::on_finalize_initialization(&on_finalize_initialization);
}

on_finalize_initialization(localclientnum) {
  waitframe(1);
  level function_75097bb5();
}

function_2613aeec(enabled) {
  if(enabled) {
    wz_firing_range::init_targets(#"hash_3af83a27a707345a");
    level thread function_211772b5();
    return;
  }

  level thread function_1e3aca52();
}

function_211772b5() {
  item_world::function_4de3ca98();
  var_b2425612 = getdynentarray(#"hash_81ef4f75cff4919");

  if(isDefined(var_b2425612) && var_b2425612.size > 1) {
    var_65688262 = array::random(var_b2425612);
    arrayremovevalue(var_b2425612, var_65688262);

    foreach(box in var_b2425612) {
      if(isDefined(box)) {
        setdynentenabled(box, 0);
      }
    }
  }
}

function_1e3aca52() {
  item_world::function_4de3ca98();
  level function_75097bb5();
}

function_75097bb5() {
  var_1c9468df = getdynent(#"hash_3af83a27a707345a");

  if(isDefined(var_1c9468df)) {
    setdynentenabled(var_1c9468df, 0);
  }

  var_b2425612 = getdynentarray(#"hash_81ef4f75cff4919");

  if(isDefined(var_b2425612)) {
    foreach(box in var_b2425612) {
      if(isDefined(box)) {
        setdynentenabled(box, 0);
      }
    }
  }
}