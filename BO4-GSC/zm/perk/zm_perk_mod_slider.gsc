/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_slider.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_slider;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_slider", &__init__, &__main__, undefined);
}

__init__() {
  function_bf3cfde4();
}

__main__() {}

function_bf3cfde4() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_phdflopper", "mod_slider", #"perk_slider", #"specialty_phdflopper", 4500);
  zm_perks::register_perk_threads(#"specialty_mod_phdflopper", &function_6a308c34, &function_ea0dd5e6);
}

function_6a308c34() {
  self thread function_815172d1();
}

function_ea0dd5e6(b_pause, str_perk, str_result, n_slot) {
  self notify(#"hash_19d583212e9b3200");
  self.var_af850774 = undefined;
}

function_815172d1() {
  self endon(#"disconnect", #"hash_19d583212e9b3200");
  var_be3643e6 = 0;

  while(true) {
    self.var_e9571d8b = undefined;

    while(!self isonground()) {
      if(!var_be3643e6) {
        var_be3643e6 = 1;
        self.var_af850774 = 0;
        var_62a70da1 = self.origin[2];
      } else if(var_62a70da1 < self.origin[2]) {
        var_62a70da1 = self.origin[2];
      }

      waitframe(1);
    }

    if(var_be3643e6) {
      self.var_e9571d8b = max(0, var_62a70da1 - self.origin[2]);
      var_be3643e6 = 0;
      waitframe(1);
    }

    waitframe(1);
  }
}