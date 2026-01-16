/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_nixie_tubes.gsc
***********************************************/

#include script_cb32d07c95e5628;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\item_world;

#namespace wz_nixie_tubes;

autoexec __init__system__() {
  system::register(#"wz_nixie_tubes", &__init__, undefined, undefined);
}

__init__() {
  level.var_f64d56a1 = (isDefined(getgametypesetting(#"hash_11b79ec2ffb886c8")) ? getgametypesetting(#"hash_11b79ec2ffb886c8") : 0) || (isDefined(getgametypesetting(#"hash_697d65a68cc6c6f1")) ? getgametypesetting(#"hash_697d65a68cc6c6f1") : 0);
  nixie_tube_cage = getdynent("nixie_tube_cage");

  if(!(isDefined(level.var_f64d56a1) && level.var_f64d56a1)) {
    if(isDefined(nixie_tube_cage)) {
      setdynentstate(nixie_tube_cage, 3);
    }
  }

  level thread function_5f309cfb();
}

function_5f309cfb() {
  level flagsys::wait_till(#"hash_507a4486c4a79f1d");
  waitframe(1);
  nixie_tube_cage = getdynent("nixie_tube_cage");

  if(!(isDefined(level.var_f64d56a1) && level.var_f64d56a1)) {
    if(isDefined(nixie_tube_cage)) {
      setdynentstate(nixie_tube_cage, 3);
    }
  }
}