/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_debris_buys.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace zm_white_debris_buys;

autoexec __init__system__() {
  system::register(#"zm_white_debris_buys", &init, undefined, undefined);
}

init() {
  clientfield::register("zbarrier", "" + #"hash_7e15d8abc4d6c79a", 1, 1, "int");
  level thread function_ffef72a();
}

function_ffef72a() {
  var_98415589 = getEntArray("zombie_debris", "targetname");

  foreach(trigger in var_98415589) {
    trigger thread function_31a1d10f();
  }
}

function_31a1d10f() {
  self endon(#"death");
  var_6a20a57a = struct::get_array(self.target + "_struct", "targetname");

  if(isDefined(var_6a20a57a[0])) {
    if(!isDefined(self.a_e_zbarriers)) {
      self.a_e_zbarriers = [];
    } else if(!isarray(self.a_e_zbarriers)) {
      self.a_e_zbarriers = array(self.a_e_zbarriers);
    }

    var_1151d2f8 = getEntArray(var_6a20a57a[0].target, "targetname");

    foreach(e_debris in var_1151d2f8) {
      if(e_debris iszbarrier()) {
        if(!isDefined(self.a_e_zbarriers)) {
          self.a_e_zbarriers = [];
        } else if(!isarray(self.a_e_zbarriers)) {
          self.a_e_zbarriers = array(self.a_e_zbarriers);
        }

        self.a_e_zbarriers[self.a_e_zbarriers.size] = e_debris;
      }
    }

    self waittill(#"kill_debris_prompt_thread");

    foreach(e_zbarrier in self.a_e_zbarriers) {
      e_zbarrier playSound(#"hash_717ab767ebc92682");
      e_zbarrier clientfield::set("" + #"hash_7e15d8abc4d6c79a", 1);
    }
  }
}