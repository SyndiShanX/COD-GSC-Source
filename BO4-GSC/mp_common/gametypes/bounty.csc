/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\bounty.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\killstreaks\mp\killstreak_vehicle;
#include scripts\mp_common\dynamic_loadout;
#include scripts\mp_common\laststand;

#namespace bounty;

event_handler[gametype_init] main(eventstruct) {
  level.var_ea696257 = 1;
  level.var_fd6018ca = 1;
  clientfield::register("allplayers", "bountymoneytrail", 1, 1, "int", &function_44cacd61, 0, 1);
  clientfield::register("toplayer", "realtime_multiplay", 1, 1, "int", &function_a1b40aa4, 0, 1);
  bundle = struct::get_script_bundle("killstreak", "killstreak_cold");
  level.var_c80088b7 = bundle;
  killstreak_vehicle::init_killstreak(bundle);
  vehicle::add_vehicletype_callback(#"vehicle_t8_mil_helicopter_swat_transport", &spawned);
}

private function_44cacd61(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self function_cf7d552d(localclientnum);
    return;
  }

  self function_3a4e5f28();
}

function_cf7d552d(localclientnum) {
  if(!self function_21c0fa55() || isthirdperson(localclientnum)) {
    self thread function_f7842f51(localclientnum);
  }
}

function_3a4e5f28() {
  self notify(#"hash_eca936d9bc271de");
}

private function_f7842f51(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");
  self endon(#"hash_eca936d9bc271de");
  self util::waittill_dobj(localclientnum);
  activefx = playtagfxset(localclientnum, "gametype_heist_money_trail", self);
  self thread function_bd48b229(localclientnum, activefx);
}

private function_bd48b229(localclientnum, fxarray) {
  self waittill(#"hash_eca936d9bc271de", #"death");

  if(isDefined(fxarray)) {
    foreach(fx in fxarray) {
      stopfx(localclientnum, fx);
    }
  }
}

function_a1b40aa4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    function_9e9a0604(localclientnum);
    return;
  }

  function_3f258626(localclientnum);
}

spawned(localclientnum, killstreak_duration) {
  if(localclientnum === 0) {
    if(self.team === #"neutral") {
      self.var_22a05c26 = level.var_c80088b7;
    }
  }
}