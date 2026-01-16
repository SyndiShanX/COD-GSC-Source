/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_escape.csc
***********************************************/

#include script_11c9779550732489;
#include script_3c345dd878d144b7;
#include script_43de70169069c6ab;
#include script_4f8f41168a7c3ea8;
#include script_5db30ea2f37108d;
#include script_675455e5e6c0c5ad;
#include script_711bbbba637da80;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\weapons\zm_weap_blundergat;
#include scripts\zm\weapons\zm_weap_cymbal_monkey;
#include scripts\zm\weapons\zm_weap_flamethrower;
#include scripts\zm\weapons\zm_weap_gravityspikes;
#include scripts\zm\weapons\zm_weap_katana;
#include scripts\zm\weapons\zm_weap_minigun;
#include scripts\zm\weapons\zm_weap_riotshield;
#include scripts\zm\weapons\zm_weap_spectral_shield;
#include scripts\zm\zm_escape_catwalk_event;
#include scripts\zm\zm_escape_fx;
#include scripts\zm\zm_escape_pap_quest;
#include scripts\zm\zm_escape_paschal;
#include scripts\zm\zm_escape_traps;
#include scripts\zm\zm_escape_util;
#include scripts\zm\zm_escape_weap_quest;
#include scripts\zm_common\load;
#include scripts\zm_common\trials\zm_trial_door_lockdown;
#include scripts\zm_common\util\ai_brutus_util;
#include scripts\zm_common\util\ai_dog_util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_fasttravel;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_wallbuy;
#include scripts\zm_common\zm_weapons;

#namespace zm_escape;

autoexec opt_in() {
  level.aat_in_use = 1;
  level.bgb_in_use = 1;
  system::ignore(#"zm_weap_chakram");
  system::ignore(#"zm_weap_hammer");
  system::ignore(#"zm_weap_scepter");
  system::ignore(#"zm_weap_sword_pistol");
  system::ignore(#"zm_weap_homunculus");
}

event_handler[level_init] main(eventstruct) {
  clientfield::register("clientuimodel", "" + #"player_lives", 1, 2, "int", undefined, 0, 0);
  clientfield::register("toplayer", "" + #"rumble_gondola", 1, 1, "int", &rumble_gondola, 0, 0);
  clientfield::register("toplayer", "" + #"hash_51b0de5e2b184c28", 1, 1, "int", &function_1bccf046, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_4be2ce4248d80d22", 1, 1, "int", &function_e6537e9f, 0, 0);
  clientfield::register("world", "" + #"hash_24deaa9795e06d41", 1, 1, "int", &function_eef4ae09, 0, 0);
  clientfield::register("world", "" + #"hash_4a8a7b58bf6cd5d8", 1, 1, "int", &function_516663f8, 0, 0);
  clientfield::register("world", "" + #"hash_29fea4571b8649a0", 1, 1, "int", &function_d8b90aba, 0, 0);
  clientfield::register("world", "" + #"hash_cd028842e18845e", 1, 1, "counter", &function_a104a4cb, 0, 0);
  clientfield::register("allplayers", "" + #"hash_500a87b29014ef02", 1, 1, "int", &function_5e901c8c, 0, 1);
  clientfield::register("toplayer", "" + #"player_pbg_bank", 1, 1, "int", &set_player_pbg_bank, 0, 1);
  clientfield::register("vehicle", "" + #"gondola_light", 1, 1, "int", &gondola_light, 0, 1);
  zm_escape_catwalk_event::init_clientfields();
  namespace_9d58c1cd::init_clientfields();
  zm_escape_util::init_clientfields();
  paschal::init();
  namespace_1063645::init_clientfields();
  namespace_b99141ed::init_clientfields();
  zm_utility::function_beed5764("rob_zm_eyes_red", #"zm_ai/fx8_zombie_eye_glow_red");
  level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
  level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
  level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
  level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
  level._effect[#"hash_4d2e5c87bde94856"] = #"hash_4948d849a833ddd5";
  level._effect[#"hash_6dcb1f6ae15079d5"] = #"hash_52f9d9bb5648c0f3";
  level._effect[#"gondola_light"] = #"hash_45dbe6888cf8a19c";
  zm_escape_catwalk_event::init_fx();
  level._uses_default_wallbuy_fx = 1;
  level._uses_sticky_grenades = 1;
  level._uses_taser_knuckles = 1;
  level.var_d0ab70a2 = #"gamedata/weapons/zm/zm_escape_weapons.csv";
  level._effect[#"hash_2bba72fdcc5508b5"] = #"hash_2ac7ec38d265c496";
  level._effect[#"chest_light_closed"] = #"hash_5b118cefec864e37";
  level._effect[#"hash_9d26763cbe16490"] = #"hash_5a9159bef624d260";
  level._effect[#"magic_box_leave"] = #"hash_2b008afec3e70add";
  level._effect[#"switch_sparks"] = #"hash_26f37488feec03c3";
  level.var_5603a802 = "pstfx_zm_hellhole";
  namespace_9d58c1cd::init();
  pap_quest::init();
  load::main();
  level thread setup_personality_character_exerts();
  exploder::exploder("lgt_vending_mulekick_on");
  util::waitforclient(0);
  level thread startzmbspawnersoundloops();
}

rumble_gondola(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self endon(#"disconnect");

  if(newval == 1) {
    self endon(#"hash_6d7afe7c92e095d8");

    while(true) {
      if(isinarray(getlocalplayers(), self)) {
        self playrumbleonentity(localclientnum, "reload_small");
      }

      wait 0.25;
    }

    return;
  }

  self notify(#"hash_6d7afe7c92e095d8");

  if(isinarray(getlocalplayers(), self)) {
    self playrumbleonentity(localclientnum, "damage_heavy");
  }
}

function_1bccf046(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self endon(#"disconnect");

  if(newval == 1) {
    self endon(#"hash_2e4f137d472e68e9");

    while(true) {
      self playrumbleonentity(localclientnum, "reload_small");
      wait 0.25;
    }

    return;
  }

  self notify(#"hash_2e4f137d472e68e9");
}

function_eef4ae09(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  s_catwalk_lava_exp = struct::get("s_catwalk_lava_exp");
  playrumbleonposition(localclientnum, "zm_escape_warden_catwalk_rumble", s_catwalk_lava_exp.origin);
}

function_a104a4cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_83771283 = struct::get("s_break_large_metal");
  playrumbleonposition(localclientnum, "zm_escape_metal_rumble1", var_83771283.origin);
  wait 3;
  playrumbleonposition(localclientnum, "zm_escape_metal_rumble2", var_83771283.origin);
  wait 5;
  playrumbleonposition(localclientnum, "zm_escape_metal_rumble3", var_83771283.origin);
}

function_516663f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    return;
  }

  level notify(#"hash_46a6202f04dd1722");
}

private function_37c86e6e(localclientnum) {
  level endon(#"hash_46a6202f04dd1722");
  s_sound_origin = struct::get("s_b_64_sound");

  while(true) {
    wait randomfloatrange(3, 5);
  }
}

function_d8b90aba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    level thread function_b2b92c61(localclientnum);
    return;
  }

  level notify(#"hash_63732bb5f380f042");
}

private function_b2b92c61(localclientnum) {
  level endon(#"hash_63732bb5f380f042");

  while(true) {
    exploder::exploder("fxexp_building64_lightning");
    wait randomfloatrange(1.5, 3);
  }
}

function_e6537e9f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.n_fx_id)) {
    stopfx(localclientnum, self.n_fx_id);
    self.n_fx_id = undefined;
  }

  if(isDefined(self.var_b3673abf)) {
    self stoploopsound(self.var_b3673abf);
    self.var_b3673abf = undefined;
  }

  if(newval) {
    self.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"switch_sparks"], self, "tag_origin");
    playSound(localclientnum, #"hash_3281ee130e7c69e", self.origin);
    self.var_b3673abf = self playLoopSound(#"hash_27ae537b191e913d");
  }
}

function_5e901c8c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_7a27c968) && self zm_utility::function_f8796df3(localclientnum)) {
    deletefx(localclientnum, self.var_7a27c968);
    self.var_7a27c968 = undefined;
  }

  if(newval) {
    if(function_65b9eb0f(localclientnum)) {
      return;
    }

    if(self zm_utility::function_f8796df3(localclientnum)) {
      return;
    }

    self.var_7a27c968 = util::playFXOnTag(localclientnum, level._effect[#"hash_6dcb1f6ae15079d5"], self, "j_head");
  }
}

set_player_pbg_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    setpbgactivebank(localclientnum, 4);
    return;
  }

  setpbgactivebank(localclientnum, 1);
}

startzmbspawnersoundloops() {
  wait 2;
  loopers = struct::get_array("spawn_location", "script_noteworthy");

  if(isDefined(loopers) && loopers.size > 0) {
    delay = 0;

    if(getdvarint(#"debug_audio", 0) > 0) {
      println("<dev string:x38>" + loopers.size + "<dev string:x72>");
    }

      for(i = 0; i < loopers.size; i++) {
        loopers[i] thread soundloopthink();
        delay += 1;

        if(delay % 20 == 0) {
          waitframe(1);
        }
      }

    return;
  }

  if(getdvarint(#"debug_audio", 0) > 0) {
    println("<dev string:x7f>");
  }

}

soundloopthink() {
  if(!isDefined(self.origin)) {
    return;
  }

  if(!isDefined(self.script_sound)) {
    self.script_sound = "zmb_spawn_walla";
  }

  notifyname = "";
  assert(isDefined(notifyname));

  if(isDefined(self.script_string)) {
    notifyname = self.script_string;
  }

  assert(isDefined(notifyname));
  started = 1;

  if(isDefined(self.script_int)) {
    started = self.script_int != 0;
  }

  if(started) {
    soundloopemitter(self.script_sound, self.origin + (0, 0, 60));
  }

  if(notifyname != "") {
    for(;;) {
      level waittill(notifyname);

      if(started) {
        soundstoploopemitter(self.script_sound, self.origin + (0, 0, 60));
      } else {
        soundloopemitter(self.script_sound, self.origin + (0, 0, 60));
      }

      started = !started;
    }
  }
}

setup_personality_character_exerts() {
  level.exert_sounds[5][#"playerbreathinsound"] = "vox_plr_5_exert_sniper_hold";
  level.exert_sounds[6][#"playerbreathinsound"] = "vox_plr_6_exert_sniper_hold";
  level.exert_sounds[7][#"playerbreathinsound"] = "vox_plr_7_exert_sniper_hold";
  level.exert_sounds[8][#"playerbreathinsound"] = "vox_plr_8_exert_sniper_hold";
  level.exert_sounds[5][#"playerbreathoutsound"] = "vox_plr_5_exert_sniper_exhale";
  level.exert_sounds[6][#"playerbreathoutsound"] = "vox_plr_6_exert_sniper_exhale";
  level.exert_sounds[7][#"playerbreathoutsound"] = "vox_plr_7_exert_sniper_exhale";
  level.exert_sounds[8][#"playerbreathoutsound"] = "vox_plr_8_exert_sniper_exhale";
  level.exert_sounds[5][#"playerbreathgaspsound"] = "vox_plr_5_exert_sniper_gasp";
  level.exert_sounds[6][#"playerbreathgaspsound"] = "vox_plr_6_exert_sniper_gasp";
  level.exert_sounds[7][#"playerbreathgaspsound"] = "vox_plr_7_exert_sniper_gasp";
  level.exert_sounds[8][#"playerbreathgaspsound"] = "vox_plr_8_exert_sniper_gasp";
  level.exert_sounds[5][#"meleeswipesoundplayer"] = "vox_plr_5_exert_punch_give";
  level.exert_sounds[6][#"meleeswipesoundplayer"] = "vox_plr_6_exert_punch_give";
  level.exert_sounds[7][#"meleeswipesoundplayer"] = "vox_plr_7_exert_punch_give";
  level.exert_sounds[8][#"meleeswipesoundplayer"] = "vox_plr_8_exert_punch_give";
}

gondola_light(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self.var_c4c53839 = util::playFXOnTag(localclientnum, level._effect[#"gondola_light"], self, "tag_origin");
}