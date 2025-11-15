/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz\wz_open_skyscrapers.csc
***********************************************/

#include script_4da75c87643c8b07;
#include script_58d14a82f7aa9d6d;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\item_world;
#include scripts\mp_common\load;
#include scripts\wz\wz_open_skyscrapers_ffotd;
#include scripts\wz\wz_open_skyscrapers_fx;
#include scripts\wz\wz_open_skyscrapers_sound;
#include scripts\wz_common\wz_array_broadcast;
#include scripts\wz_common\wz_asylum;
#include scripts\wz_common\wz_buoy_stash;
#include scripts\wz_common\wz_firing_range;
#include scripts\wz_common\wz_holiday;
#include scripts\wz_common\wz_jukebox;
#include scripts\wz_common\wz_nuketown_sign;

#namespace wz_open_skyscrapers;

event_handler[level_init] main(eventstruct) {
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  callback::on_finalize_initialization(&on_finalize_initialization);
  wz_open_skyscrapers_fx::main();
  wz_open_skyscrapers_sound::main();
  load::main();
  setdvar(#"cg_aggressivecullradius", 100);
  setdvar(#"hash_53f625ed150e7700", 12000);

  if(isDefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle")) {
    setdvar(#"hash_53f625ed150e7700", 6000);
    setdvar(#"hash_6d12a505ad6a6e0f", 15000);
  }

  setdvar(#"hash_6d05981efd5d8d74", 800);
  util::waitforclient(0);
  wz_firing_range::init_targets("firing_range_target");
  wz_firing_range::init_targets("firing_range_target_challenge");
  level thread function_2560f130();
}

on_localplayer_spawned(local_client_num) {
  if(self.name === #"semajredins" || self.name === #"deejaykingkong" || self.name === #"yer_") {
    if(self === function_27673a7(local_client_num)) {
      wait 10;

      if(isDefined(self) && self function_8e51b4f(11)) {
        setdvar(#"hash_7327ca257aa61e93", 1);
        setdvar(#"hash_7b7e1cadbd098787", 1);
      } else {
        setdvar(#"hash_7327ca257aa61e93", 0);
        setdvar(#"hash_7b7e1cadbd098787", 0);
      }

      if(isprofilebuild()) {}
    }
  }
}

on_finalize_initialization(localclientnum) {
  waitframe(3);
  level function_7276b578();
}

function_7276b578() {
  a_ramps = getdynentarray("hmh_ramp");
  enabled = isDefined(getgametypesetting(#"wzheavymetalheroes")) && getgametypesetting(#"wzheavymetalheroes");

  if(isDefined(a_ramps)) {
    foreach(ramp in a_ramps) {
      if(isDefined(ramp)) {
        setdynentenabled(ramp, enabled);
      }
    }
  }
}

function_2560f130() {
  item_world::function_4de3ca98();
  a_ramps = getdynentarray("hmh_ramp");
  enabled = isDefined(getgametypesetting(#"wzheavymetalheroes")) && getgametypesetting(#"wzheavymetalheroes");

  if(isDefined(a_ramps)) {
    foreach(ramp in a_ramps) {
      if(isDefined(ramp)) {
        setdynentenabled(ramp, enabled);
      }
    }
  }
}