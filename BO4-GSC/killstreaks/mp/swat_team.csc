/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\swat_team.csc
***********************************************/

#include script_324d329b31b9b4ec;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\renderoverridebundle;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreak_bundles;

#namespace swat_team;

autoexec __init__system__() {
  system::register(#"swat_team", &__init__, undefined, #"killstreaks");
}

__init__() {
  ir_strobe::init_shared();
  bundle = struct::get_script_bundle("killstreak", "killstreak_swat_team");
  ai::add_archetype_spawn_function("human", &spawned, bundle);
  clientfield::register("actor", "swat_light_strobe", 1, 1, "int", &function_3deaa7d0, 0, 0);
  clientfield::register("scriptmover", "swat_light_strobe", 1, 1, "int", &function_92ec578c, 0, 0);
  clientfield::register("actor", "swat_shocked", 1, 1, "int", &function_8fa6561f, 0, 0);
  clientfield::register("vehicle", "swat_helicopter_death_fx", 1, getminbitcountfornum(2), "int", &function_266f2abf, 0, 0);
  clientfield::register("actor", "swat_rob_state", 1, 1, "int", &function_d9dea06b, 0, 0);
}

spawned(local_client_num, bundle) {
  if(self.subarchetype === #"human_lmg") {
    if(self.team === #"free" && isDefined(level.var_fd6018ca) && level.var_fd6018ca) {
      self killstreak_bundles::spawned(local_client_num, level.var_c80088b7);
      return;
    }

    self killstreak_bundles::spawned(local_client_num, bundle);
  }
}

function_266f2abf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    forward = self.origin + (0, 0, 1) - self.origin;
    playFX(localclientnum, "killstreaks/fx_heli_exp_lg", self.origin, forward);
  }
}

function_3deaa7d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    util::playFXOnTag(localclientnum, "light/fx8_light_plyr_strobe", self, "tag_char_vis_light_strobe_01");
    util::playFXOnTag(localclientnum, "light/fx8_light_plyr_strobe", self, "tag_char_vis_light_strobe_02");
  }
}

function_92ec578c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    util::playFXOnTag(localclientnum, "light/fx8_light_plyr_strobe", self, "tag_flash");
  }
}

function_8fa6561f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.zmpowerupinstakill_introduction = util::playFXOnTag(localclientnum, "player/fx8_plyr_shocked_3p", self, "j_spineupper");
    return;
  }

  if(isDefined(self.zmpowerupinstakill_introduction)) {
    stopfx(localclientnum, self.zmpowerupinstakill_introduction);
  }
}

private function_d9dea06b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    if(self flag::exists(#"friendly")) {
      self renderoverridebundle::stop_bundle(#"friendly", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp", 0);
    }
  }
}