/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\gravity_spikes.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scoreevents_shared;

#namespace gravity_spikes;

init_shared() {
  ability_player::register_gadget_should_notify(7, 1);
  callback::on_connect(&function_aaef50a);
}

function_aaef50a() {
  thread function_263a039();
}

function_263a039() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"projectile_impact");
    self clientfield::increment("sndRattle", 1);
    scoreevents::processscoreevent(#"hash_5814e5b2ee30cc5a", self, undefined, waitresult.weapon);
    self notify(#"hash_5814e5b2ee30cc5a");
    waitframe(1);
  }
}