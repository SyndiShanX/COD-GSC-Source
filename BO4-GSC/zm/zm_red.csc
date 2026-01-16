/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red.csc
***********************************************/

#include script_41a75e0d79b62736;
#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm\ai\zm_ai_gegenees;
#include scripts\zm\weapons\zm_weap_hand_charon;
#include scripts\zm\weapons\zm_weap_hand_gaia;
#include scripts\zm\weapons\zm_weap_hand_hemera;
#include scripts\zm\weapons\zm_weap_hand_ouranos;
#include scripts\zm\weapons\zm_weap_riotshield;
#include scripts\zm\weapons\zm_weap_thunderstorm;
#include scripts\zm\zm_red_boss_battle;
#include scripts\zm\zm_red_challenges;
#include scripts\zm\zm_red_fasttravel;
#include scripts\zm\zm_red_main_quest;
#include scripts\zm\zm_red_oracle_boons;
#include scripts\zm\zm_red_pap_quest;
#include scripts\zm\zm_red_power_quest;
#include scripts\zm\zm_red_trap_boiling_bath;
#include scripts\zm\zm_red_util;
#include scripts\zm\zm_red_ww_quests;
#include scripts\zm_common\load;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio_sq;
#include scripts\zm_common\zm_fasttravel;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_wallbuy;
#include scripts\zm_common\zm_weapons;

#namespace zm_red;

autoexec opt_in() {
  level.aat_in_use = 1;
  level.bgb_in_use = 1;
}

event_handler[level_init] main(eventstruct) {
  clientfield::register("clientuimodel", "player_lives", 16000, 2, "int", undefined, 0, 0);
  clientfield::register("scriptmover", "" + #"register_pegasus", 16000, 1, "counter", &register_pegasus, 0, 0);
  clientfield::register("scriptmover", "" + #"medusa_eyes", 16000, 1, "int", &function_deaba617, 0, 0);
  clientfield::register("scriptmover", "" + #"special_target", 16000, 1, "int", &function_adad910c, 0, 0);
  clientfield::register("actor", "" + #"hash_2856f87ecdfaf62", 16000, 1, "counter", &function_f02d282d, 0, 0);
  clientfield::register("actor", "" + #"hash_1bdce857fd614cef", 16000, 1, "counter", &function_ef690ed4, 0, 0);
  clientfield::register("world", "" + #"postfx_play", 16000, 2, "int", &function_ea4a65c1, 0, 0);
  clientfield::register("world", "" + #"hash_71f9fcfb2cd84a9c", 16000, 1, "int", &function_b16ffc7a, 0, 0);
  clientfield::register("toplayer", "" + #"eye_vignette", 16000, 1, "int", &function_3b118f17, 0, 0);
  level._uses_default_wallbuy_fx = 1;
  level._uses_sticky_grenades = 1;
  level._uses_taser_knuckles = 1;
  level.var_d0ab70a2 = #"gamedata/weapons/zm/zm_red_weapons.csv";
  level.var_5603a802 = "pstfx_gaussian_blur";
  level._effect[#"fasttravel_rail_1p"] = #"hash_51fd09e47e0cd679";
  level._effect[#"fasttravel_rail_3p"] = #"hash_51fd09e47e0cd679";
  level._effect[#"fasttravel_rail_travel"] = #"hash_51fd09e47e0cd679";
  zm_red_trap_boiling_bath::init();
  namespace_f2050961::init();
  zm_red_ww_quests::init();
  zm_red_pap_quest::init_clientfield();
  zm_red_power_quest::init();
  zm_red_fasttravel::init();
  zm_red_main_quest::init();
  zm_red_challenges::init();
  zm_red_util::init();
  red_boss_battle::init();
  zm_audio_sq::init();
  load::main();
  zm_red_fasttravel::main();
  util::waitforclient(0);
}

function_deaba617(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(newval == 1) {
    n_val = 0;
    self playrenderoverridebundle(#"hash_589cf36f110e3f4a");

    for(i = 0; i < 20; i++) {
      if(isDefined(self)) {
        self function_78233d29(#"hash_589cf36f110e3f4a", "", "DNI Glow", n_val);
      }

      wait 0.05;
      n_val += 0.1;
    }

    if(isDefined(self)) {
      self function_78233d29(#"hash_589cf36f110e3f4a", "", "DNI Glow", 1);
    }

    return;
  }

  if(isDefined(self)) {
    self stoprenderoverridebundle(#"hash_589cf36f110e3f4a");
    self function_78233d29(#"hash_589cf36f110e3f4a", "", "DNI Glow", 0);
  }
}

function_3b118f17(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(newval == 1) {
    self thread postfx::playpostfxbundle(#"hash_5e6d2d91ca059a03");
    self thread postfx::playpostfxbundle(#"hash_6422033e84a54e2d");
    level waittill(#"pstfx_off");
    self thread postfx::exitpostfxbundle(#"hash_5e6d2d91ca059a03");
    self thread postfx::exitpostfxbundle(#"hash_6422033e84a54e2d");
  }
}

function_ea4a65c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    forcestreammaterial("mtl_postfx_dangerdog_01");
    forcestreammaterial("mtl_postfx_dangerdog_02");
    forcestreammaterial("mtl_postfx_dangerdog_03");
    forcestreammaterial("mtl_postfx_dangerdog_04");
    forcestreammaterial("mtl_postfx_dangerdog_05");
    return;
  }

  if(newval == 2) {
    forcestreammaterial("mtl_postfx_dangerdog_16");
    forcestreammaterial("mtl_postfx_dangerdog_17");
    forcestreammaterial("mtl_postfx_dangerdog_18");
    forcestreammaterial("mtl_postfx_dangerdog_19");
    forcestreammaterial("mtl_postfx_dangerdog_20");
    forcestreammaterial("mtl_postfx_dangerdog_21");
    forcestreammaterial("mtl_postfx_dangerdog_22");
    return;
  }

  if(newval == 3) {
    forcestreammaterial("mtl_postfx_dangerdog_06");
    forcestreammaterial("mtl_postfx_dangerdog_07");
    forcestreammaterial("mtl_postfx_dangerdog_08");
    forcestreammaterial("mtl_postfx_dangerdog_09");
    forcestreammaterial("mtl_postfx_dangerdog_10");
    forcestreammaterial("mtl_postfx_dangerdog_11");
    forcestreammaterial("mtl_postfx_dangerdog_12");
    forcestreammaterial("mtl_postfx_dangerdog_13");
    forcestreammaterial("mtl_postfx_dangerdog_14");
    forcestreammaterial("mtl_postfx_dangerdog_15");
    return;
  }

  stopforcestreamingmaterial("mtl_postfx_dangerdog_01");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_02");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_03");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_04");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_05");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_06");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_07");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_08");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_09");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_10");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_11");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_12");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_13");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_14");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_15");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_16");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_17");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_18");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_19");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_20");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_21");
  stopforcestreamingmaterial("mtl_postfx_dangerdog_22");
}

function_adad910c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self playrenderoverridebundle(#"hash_49e717c029b47c98");
    return;
  }

  self stoprenderoverridebundle(#"hash_49e717c029b47c98");
}

register_pegasus(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.var_1c8295a8 = self;
}

function_f02d282d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_ade26abd(#"left");
}

function_ef690ed4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_ade26abd(#"right");
}

function_ade26abd(str_dir) {
  self endon(#"death");
  var_10d4f67d = level.var_1c8295a8;

  if(!isDefined(var_10d4f67d)) {
    return;
  }

  var_10d4f67d endon(#"death");
  str_tag = "j_wingulna_le";

  if(str_dir == #"right") {
    str_tag = "j_wingulna_ri";
  }

  level beam::launch(var_10d4f67d, str_tag, self, "j_spine4", "beam8_zm_red_peg_lightning_strike", 1);
  waitframe(1);
  level beam::kill(var_10d4f67d, str_tag, self, "j_spine4", "beam8_zm_red_peg_lightning_strike");
}

function_b16ffc7a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    function_9362afb8(localclientnum, "vis_boss_arena");
  }
}