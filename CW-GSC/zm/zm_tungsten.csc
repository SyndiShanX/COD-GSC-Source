/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_tungsten.csc
***********************************************/

#using script_179ba564f65e92c5;
#using script_2c5f2d4e7aa698c4;
#using script_3dc7e0c7f9c90bdb;
#using script_478fc2f0b6421a32;
#using script_581877678e31274c;
#using script_5ef14bd74fdef7c6;
#using script_6243781aa5394e62;
#using script_68732f44626820ed;
#using script_77597bfbc6274baf;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_tungsten_audio;
#using scripts\zm\zm_tungsten_end_fight;
#using scripts\zm\zm_tungsten_fasttravel;
#using scripts\zm\zm_tungsten_main_quest;
#using scripts\zm\zm_tungsten_pap_quest;
#using scripts\zm\zm_tungsten_side_quest;
#using scripts\zm\zm_tungsten_side_quest_arcade_token;
#using scripts\zm\zm_tungsten_side_quest_shooting_gallery;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_intel;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_ping;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#namespace zm_tungsten;

function autoexec opt_in() {
  level.aat_in_use = 1;
  level.var_1d1a6e08 = 1;
}

function event_handler[level_init] main(eventstruct) {
  zm_ping::function_5ae4a10c("p9_zm_gold_teleporter_b", "tungsten_portal_obj", #"hash_7df7e1092633642e", #"hash_5b20033c44a4321f", #"hash_651bd0a238dd47d5");
  zm_ping::function_5ae4a10c("p9_zm_gold_teleporter_dmg", "tungsten_portal_obj", #"hash_7df7e1092633642e", #"hash_5b20033c44a4321f", #"hash_651bd0a238dd47d5");
  zm_ping::function_5ae4a10c("p9_fxp_zm_portal_aether_modular_dest_amerika_to_observation_from_under", "tungsten_portal_obj", #"hash_7df7e1092633642e", #"hash_5b20033c44a4321f", #"hash_651bd0a238dd47d5");
  zm_ping::function_5ae4a10c(undefined, "platinum_rappel_obj", #"hash_337db80f69d05548", #"hash_5b20033c44a4321f", #"ui_icon_general_feedback_zipline");
  zm_ping::function_5ae4a10c(undefined, "platinum_zipline_obj", #"hash_6d0057fa066d6733", #"hash_5b20033c44a4321f", #"ui_icon_general_feedback_zipline");
  zm_ping::function_5ae4a10c("p9_fxanim_zm_platinum_rappel_mod", "platinum_rappel_door_obj", #"hash_50ac7af2c5bc8257", #"hash_5f3108a8ed351288", #"ui_icon_minimap_doorbuys");
  zm_ping::function_5ae4a10c("p9_fxanim_zm_platinum_zipline_mod", "platinum_zipline_door_obj", #"hash_59bd96ed40a5975e", undefined, #"ui_icon_minimap_powerdoors");
  zm_ping::function_5ae4a10c("p8_zm_off_trap_switch_box", "tungsten_hind_trap_switch_obj", #"hash_3fe2d338feb5f7b4", #"hash_5b20033c44a4321f", #"hash_2eabbc031eb54dc2");
  clientfield::register_clientuimodel("player_lives", #"zm_hud", #"player_lives", 1, 2, "int", undefined, 0, 0);
  clientfield::register("toplayer", "" + # "minimap_underground", 1, 1, "int", &minimap_underground, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_16e5e4d2ea0716b7", 1, 2, "int", &function_2879e60b, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_575d68a64ff032b2", 1, 1, "counter", &function_1fa52d9a, 0, 0);
  clientfield::register("toplayer", "" + # "hash_69dc133e22a2769f", 28000, 1, "int", &function_6b66a9a3, 0, 0);
  clientfield::register("toplayer", "" + # "hash_4cb4c776a64a6cca", 28000, getminbitcountfornum(5), "int", &function_fd7a1df2, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_27556b053ce9a6a2", 1, 1, "counter", &function_53c1bf22, 0, 0);
  clientfield::register("toplayer", "" + # "hash_d4826b65faa9efb", 28000, 1, "int", &function_996f5d0f, 0, 0);
  clientfield::register("toplayer", "" + # "hash_4c2c37e44f9d6cf4", 28000, 2, "int", &function_10537d85, 0, 0);
  clientfield::register("toplayer", "" + # "music_underscore", 1, getminbitcountfornum(4), "int", &zm_tungsten_audio::function_2f3017ad, 0, 0);
  clientfield::register("toplayer", "" + # "pstfx_sprite_rain_loop", 28000, getminbitcountfornum(2), "int", &pstfx_sprite_rain_loop, 0, 0);
  clientfield::register("world", "" + # "hash_763dd8035e80f7c", 28000, 1, "int", &function_44dc8dc9, 0, 0);
  clientfield::register("world", "" + # "hash_7b3ada6e5b1cf81e", 1, 1, "int", &function_167fc35, 0, 0);
  clientfield::register("toplayer", "" + # "hash_56c7e620d1de163a", 1, 1, "counter", &function_33082eb4, 0, 0);
  clientfield::register("toplayer", "" + # "hash_4f232c4c4c5f7816", 1, 1, "int", &function_182ea9e4, 0, 0);
  clientfield::register("world", "" + # "hash_14197af7df70a497", 28000, 1, "int", &function_a146ac0f, 0, 0);
  clientfield::register("world", "" + # "hash_6ecd61d493349ec0", 28000, getminbitcountfornum(2), "int", &function_1d123acd, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_431b27e4b133e650", 28000, 1, "int", &function_5bc9772e, 0, 0);
  clientfield::register("world", "" + # "hash_1fb207d10fbe27ce", 28000, 1, "int", &function_51ee271b, 0, 0);
  clientfield::register("world", "" + # "hash_5a36f05cbdf2580", 28000, getminbitcountfornum(12), "int", &zm_tungsten_audio::function_933f292d, 0, 0);
  clientfield::register("allplayers", "" + # "hash_3198b85c253e79d4", 28000, 1, "int", &function_5414ee31, 0, 0);
  clientfield::register("actor", "" + # "hash_3e4641a9ea00d061", 28000, 1, "int", &function_eff937db, 0, 0);
  clientfield::register("world", "" + # "SetPBGExposureBank", 28000, 1, "int", &SetPBGExposureBank, 0, 0);
  clientfield::register("world", "" + # "hash_7fd166b952515da7", 28000, 1, "int", &function_72c3294, 0, 0);
  clientfield::register("world", "" + # "hash_3e71bd47ea1a6144", 28000, 1, "int", &function_43b0a4e2, 0, 0);
  clientfield::register("allplayers", "" + # "hash_73227fdae7d9bc0e", 28000, 2, "int", &function_1a91c8d3, 0, 0);
  clientfield::register("vehicle", "" + # "hash_66006a74a4ab8b8e", 28000, 1, "int", &function_9163efd4, 0, 0);
  clientfield::register("allplayers", "" + # "hash_1a529bb0de6717d5", 1, 1, "int", &function_61d33efe, 0, 0);
  clientfield::register("world", "" + # "hash_2a35f1483d5f5467", 1, 1, "int", &function_f2b7289d, 0, 0);
  clientfield::register("world", "" + # "hash_deec7a5e441c482", 1, 1, "int", &function_61297264, 0, 0);
  setDvar(#"hash_384191a42356d34", 1);
  setDvar(#"hash_64d8f355a9e6daa5", 1);
  setDvar(#"hash_2d56e13848a82d14", 0);
  setDvar(#"hash_b3395a8d3abf84a", 1);
  level.setupcustomcharacterexerts = &setup_personality_character_exerts;
  level.var_d0ab70a2 = # "hash_415d2f1314ea548a";
  level.var_c2964bec = 400;
  zm_intel::function_88645994(#"hash_2315f92412308649");
  load::main();
  namespace_297ae820::init();
  zm_tungsten_fasttravel::init();
  zm_tungsten_pap_quest::init();
  zm_tungsten_main_quest::init();
  zm_tungsten_end_fight::init();
  namespace_8a08914c::init();
  zm_tungsten_audio::init();
  zm_tungsten_side_quest::init();
  namespace_60bf0cf2::init();
  zm_tungsten_side_quest_arcade_token::init();
  zm_tungsten_side_quest_shooting_gallery::init();
  setsoundcontext("dark_aether", "inactive");
  util::waitforclient(0);
  namespace_297ae820::function_dcf22669();
}

function setup_personality_character_exerts() {
  level.exert_sounds[1][#"playerbreathinsound"] = "vox_plr_1_exert_sniper_hold";
  level.exert_sounds[2][#"playerbreathinsound"] = "vox_plr_2_exert_sniper_hold";
  level.exert_sounds[3][#"playerbreathinsound"] = "vox_plr_3_exert_sniper_hold";
  level.exert_sounds[4][#"playerbreathinsound"] = "vox_plr_4_exert_sniper_hold";
  level.exert_sounds[1][#"playerbreathoutsound"] = "vox_plr_1_exert_sniper_exhale";
  level.exert_sounds[2][#"playerbreathoutsound"] = "vox_plr_2_exert_sniper_exhale";
  level.exert_sounds[3][#"playerbreathoutsound"] = "vox_plr_3_exert_sniper_exhale";
  level.exert_sounds[4][#"playerbreathoutsound"] = "vox_plr_4_exert_sniper_exhale";
  level.exert_sounds[1][#"playerbreathgaspsound"] = "vox_plr_1_exert_sniper_gasp";
  level.exert_sounds[2][#"playerbreathgaspsound"] = "vox_plr_2_exert_sniper_gasp";
  level.exert_sounds[3][#"playerbreathgaspsound"] = "vox_plr_3_exert_sniper_gasp";
  level.exert_sounds[4][#"playerbreathgaspsound"] = "vox_plr_4_exert_sniper_gasp";
  level.exert_sounds[1][#"meleeswipesoundplayer"] = "vox_plr_1_exert_punch_give";
  level.exert_sounds[2][#"meleeswipesoundplayer"] = "vox_plr_2_exert_punch_give";
  level.exert_sounds[3][#"meleeswipesoundplayer"] = "vox_plr_3_exert_punch_give";
  level.exert_sounds[4][#"meleeswipesoundplayer"] = "vox_plr_4_exert_punch_give";
}

function minimap_underground(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_f58e42ae(fieldname, 1);
    return;
  }

  function_f58e42ae(fieldname, 0);
}

function function_2879e60b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    if(isDefined(self.var_dd37157)) {
      stopfx(fieldname, self.var_dd37157);
      self.var_dd37157 = undefined;
    }

    self.var_dd37157 = playFX(fieldname, #"hash_7534672c207c08ed", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }

  if(bwasdemojump == 2) {
    if(isDefined(self.var_dd37157)) {
      stopfx(fieldname, self.var_dd37157);
      self.var_dd37157 = undefined;
    }

    self.var_dd37157 = playFX(fieldname, #"hash_3b61ca07c83b7171", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }
}

function function_1fa52d9a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    playFX(fieldname, #"hash_179a76b8d709e8bb", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }
}

function function_f2b7289d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    var_92c5226e = struct::get_array("ts_zipline_frame");

    foreach(var_4b07d80a in var_92c5226e) {
      var_4b07d80a.var_cc1c5020 = util::spawn_model(fieldname, var_4b07d80a.model, var_4b07d80a.origin, var_4b07d80a.angles);
      var_4b07d80a.var_cc1c5020.var_fc558e74 = "platinum_zipline_obj";
      var_4b07d80a.var_cc1c5020 function_619a5c20();
    }
  }
}

function function_61297264(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    var_e303ba30 = struct::get_array("ts_rappel_frame");

    foreach(var_4b07d80a in var_e303ba30) {
      var_4b07d80a.var_cc1c5020 = util::spawn_model(fieldname, var_4b07d80a.model, var_4b07d80a.origin, var_4b07d80a.angles);
      var_4b07d80a.var_cc1c5020.var_fc558e74 = "platinum_rappel_obj";
      var_4b07d80a.var_cc1c5020 function_619a5c20();
    }
  }
}

function function_6b66a9a3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    forcestreamxmodel(#"p9_fxp_zm_teleport_tunnel");
    forcestreamxmodel(#"p9_fxp_zm_teleport_tunnel_edge");
    function_3385d776(#"zombie/fx9_aether_tear_portal_tunnel_1p");
    return;
  }

  stopforcestreamingxmodel(#"p9_fxp_zm_teleport_tunnel");
  stopforcestreamingxmodel(#"p9_fxp_zm_teleport_tunnel_edge");
  function_c22a1ca2(#"zombie/fx9_aether_tear_portal_tunnel_1p");
}

function function_fd7a1df2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 0:
      stopforcestreamingxmodel(#"hash_76dd4f827daef371");
      stopforcestreamingxmodel(#"hash_72d2ae42e9973cad");
      stopforcestreamingxmodel(#"hash_5c35207bb157a661");
      stopforcestreamingxmodel(#"hash_2f9ea46c29003241");
      stopforcestreamingxmodel(#"hash_5d6f46eb355ec1cb");
      stopforcestreamingxmodel(#"hash_62e92c3479ce24e2");
      stopforcestreamingxmodel(#"hash_7689d161576092c2");
      stopforcestreamingxmodel(#"p9_fxp_zm_portal_aether_modular_dest_amerika_to_observation_from_under");
      stopforcestreamingxmodel(#"hash_1d67a5d0f60e1ea");
      stopforcestreamingxmodel(#"hash_697445b9607e9d53");
      break;
    case 1:
      forcestreamxmodel(#"hash_76dd4f827daef371");
      forcestreamxmodel(#"hash_72d2ae42e9973cad");
      stopforcestreamingxmodel(#"hash_5c35207bb157a661");
      stopforcestreamingxmodel(#"hash_2f9ea46c29003241");
      stopforcestreamingxmodel(#"hash_1d67a5d0f60e1ea");
      stopforcestreamingxmodel(#"hash_697445b9607e9d53");
      break;
    case 2:
      forcestreamxmodel(#"hash_5c35207bb157a661");
      forcestreamxmodel(#"hash_2f9ea46c29003241");
      stopforcestreamingxmodel(#"hash_76dd4f827daef371");
      stopforcestreamingxmodel(#"hash_72d2ae42e9973cad");
      stopforcestreamingxmodel(#"hash_5d6f46eb355ec1cb");
      stopforcestreamingxmodel(#"hash_62e92c3479ce24e2");
      break;
    case 3:
      forcestreamxmodel(#"hash_5d6f46eb355ec1cb");
      forcestreamxmodel(#"hash_62e92c3479ce24e2");
      stopforcestreamingxmodel(#"hash_5c35207bb157a661");
      stopforcestreamingxmodel(#"hash_2f9ea46c29003241");
      stopforcestreamingxmodel(#"hash_7689d161576092c2");
      stopforcestreamingxmodel(#"p9_fxp_zm_portal_aether_modular_dest_amerika_to_observation_from_under");
      break;
    case 4:
      forcestreamxmodel(#"hash_7689d161576092c2");
      forcestreamxmodel(#"p9_fxp_zm_portal_aether_modular_dest_amerika_to_observation_from_under");
      stopforcestreamingxmodel(#"hash_5d6f46eb355ec1cb");
      stopforcestreamingxmodel(#"hash_62e92c3479ce24e2");
      stopforcestreamingxmodel(#"hash_1d67a5d0f60e1ea");
      stopforcestreamingxmodel(#"hash_697445b9607e9d53");
      break;
    case 5:
      forcestreamxmodel(#"hash_1d67a5d0f60e1ea");
      forcestreamxmodel(#"hash_697445b9607e9d53");
      stopforcestreamingxmodel(#"hash_7689d161576092c2");
      stopforcestreamingxmodel(#"p9_fxp_zm_portal_aether_modular_dest_amerika_to_observation_from_under");
      stopforcestreamingxmodel(#"hash_76dd4f827daef371");
      stopforcestreamingxmodel(#"hash_72d2ae42e9973cad");
      break;
  }
}

function function_53c1bf22(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    if(bwastimejump) {
      playFX(fieldname, #"hash_7f2cfd191b43c6fa", self.origin);
    }
  }
}

function pstfx_sprite_rain_loop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwasdemojump == 1) {
    if(self postfx::function_556665f2(#"pstfx_sprite_rain_loop")) {
      self postfx::stoppostfxbundle(#"pstfx_sprite_rain_loop");
      self notify(#"hash_31ca7d9fa1b055e0");
    }

    self postfx::playpostfxbundle(#"pstfx_sprite_rain_loop");
    var_3f79908d = playtagfxset(fieldname, "fx9_stakeout_screen_drop_distort", self);
    self thread function_f524c7a5(fieldname, var_3f79908d);
    return;
  }

  if(bwasdemojump == 2) {
    self postfx::stoppostfxbundle(#"pstfx_sprite_rain_loop");
    self notify(#"hash_31ca7d9fa1b055e0");
    return;
  }

  self postfx::exitpostfxbundle(#"pstfx_sprite_rain_loop");
  self notify(#"hash_31ca7d9fa1b055e0");
}

function function_f524c7a5(localclientnum, var_3f79908d) {
  self notify("e0bab89e397c787");
  self endon("e0bab89e397c787");
  self waittill(#"death", #"hash_31ca7d9fa1b055e0");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function function_996f5d0f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(!self util::function_50ed1561(fieldname)) {
    return;
  }

  if(bwasdemojump) {
    if(!isDefined(self.var_ca8b5a42)) {
      self.var_ca8b5a42 = playtagfxset(fieldname, #"hash_3fecf62fe603c35e", self);
    }

    if(!isDefined(self.var_79abcb8a)) {
      self.var_79abcb8a = playfxoncamera(fieldname, #"hash_4c2a73ebbc177abd");
    }

    return;
  }

  if(isDefined(self.var_ca8b5a42)) {
    foreach(n_fx in self.var_ca8b5a42) {
      stopfx(fieldname, n_fx);
    }

    self.var_ca8b5a42 = undefined;
  }

  if(isDefined(self.var_79abcb8a)) {
    stopfx(fieldname, self.var_79abcb8a);
    self.var_79abcb8a = undefined;
  }
}

function function_10537d85(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");

  if(!self util::function_50ed1561(fieldname)) {
    return;
  }

  self notify(#"hash_7d19f6000c542b75");

  if(isDefined(self.var_d70173d8)) {
    self stoploopsound(self.var_d70173d8);
    self.var_d70173d8 = undefined;
  }

  if(bwasdemojump == 1) {
    self thread function_40ef083a();
    return;
  }

  if(bwasdemojump == 2) {
    if(!isDefined(self.var_38a54dff)) {
      self playSound(fieldname, #"hash_41c806945939eed6");
      self.var_38a54dff = self playLoopSound(#"hash_518f551268d347fa");
    }

    return;
  }

  if(isDefined(self.var_38a54dff)) {
    self playSound(fieldname, #"hash_2f82db47fea25953");
    self stoploopsound(self.var_38a54dff);
    self.var_38a54dff = undefined;
  }
}

function function_40ef083a() {
  self notify("68eef3a9acab795c");
  self endon("68eef3a9acab795c");
  self endon(#"death");
  self endon(#"hash_7d19f6000c542b75");

  if(!isDefined(level.var_d58a6548)) {
    level.var_d58a6548 = 30;
  }

  self.var_d70173d8 = self playLoopSound(#"hash_35d7cc9a4eb405f");
  wait level.var_d58a6548 / 3;
  self stoploopsound(self.var_d70173d8);
  self.var_d70173d8 = self playLoopSound(#"hash_35d7dc9a4eb4212");
  wait level.var_d58a6548 / 3;
  self stoploopsound(self.var_d70173d8);
  self.var_d70173d8 = self playLoopSound(#"hash_35d7ec9a4eb43c5");
}

function function_44dc8dc9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!function_148ccc79(fieldname, #"hash_5e358762e4678906")) {
      function_a837926b(fieldname, #"hash_5e358762e4678906");
    }

    return;
  }

  if(function_148ccc79(fieldname, #"hash_5e358762e4678906")) {
    codestoppostfxbundlelocal(fieldname, #"hash_5e358762e4678906");
  }
}

function function_167fc35(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    forcestreamxmodel(#"p9_fxp_zm_teleport_tunnel");
    forcestreamxmodel(#"p9_fxp_zm_teleport_tunnel_edge");
    function_3385d776(#"zombie/fx9_aether_tear_portal_tunnel_1p");
    return;
  }

  stopforcestreamingxmodel(#"p9_fxp_zm_teleport_tunnel");
  stopforcestreamingxmodel(#"p9_fxp_zm_teleport_tunnel_edge");
  function_c22a1ca2(#"zombie/fx9_aether_tear_portal_tunnel_1p");
}

function function_182ea9e4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    forcestreamxmodel(#"hash_69c0563efeddad47");
    forcestreamxmodel(#"c_zom_dragonhead_e");
    forcestreamxmodel(#"p9_fxanim_sv_dragon_console_mod");
    return;
  }

  stopforcestreamingxmodel(#"hash_69c0563efeddad47");
  stopforcestreamingxmodel(#"c_zom_dragonhead_e");
  stopforcestreamingxmodel(#"p9_fxanim_sv_dragon_console_mod");
}

function function_33082eb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = function_5c10bd79(bwastimejump);

  if(isDefined(e_player)) {
    if(e_player postfx::function_556665f2(#"hash_413b0a0d47ce8d45")) {
      e_player postfx::stoppostfxbundle(#"hash_413b0a0d47ce8d45");
    }

    e_player postfx::playpostfxbundle(#"hash_413b0a0d47ce8d45");
    e_player playSound(bwastimejump, #"hash_56a9d9da20064c3f");
    function_5ea2c6e3("zm_silver_darkaether_leadin", 2);
  }
}

function function_a146ac0f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_328baab5 = struct::get_array("s_dragon_rocket_portals", "targetname");

  if(bwasdemojump) {
    foreach(s_portal in var_328baab5) {
      if(!isDefined(s_portal.var_82f9314e)) {
        s_portal.var_82f9314e = [];
      }

      if(!isDefined(s_portal.var_82f9314e[fieldname])) {
        var_c39b3c14 = util::spawn_model(fieldname, "tag_origin", s_portal.origin, s_portal.angles);
        var_c39b3c14 playSound(fieldname, #"hash_61bdec1c1b35a33a");
        var_c39b3c14.var_68cf83c = var_c39b3c14 playLoopSound(#"hash_e94363edb1efe");
        var_c39b3c14.var_fa63b371 = playFX(fieldname, #"hash_57ae7e6f9140093f", var_c39b3c14.origin, anglesToForward(var_c39b3c14.angles), anglestoup(var_c39b3c14.angles));
        s_portal.var_82f9314e[fieldname] = var_c39b3c14;
      }
    }

    return;
  }

  foreach(s_portal in var_328baab5) {
    if(!isDefined(s_portal.var_82f9314e)) {
      s_portal.var_82f9314e = [];
    }

    var_c39b3c14 = s_portal.var_82f9314e[fieldname];

    if(isDefined(var_c39b3c14.var_68cf83c)) {
      var_c39b3c14 playSound(fieldname, #"hash_10ab48d5915334e");
      var_c39b3c14 stoploopsound(var_c39b3c14.var_68cf83c);
      var_c39b3c14.var_68cf83c = undefined;
    }

    if(isDefined(var_c39b3c14.var_fa63b371)) {
      var_c39b3c14 playSound(fieldname, #"hash_10ab48d5915334e");
      playFX(fieldname, #"hash_2786498a222adb04", var_c39b3c14.origin, anglesToForward(var_c39b3c14.angles), anglestoup(var_c39b3c14.angles));
      killfx(fieldname, var_c39b3c14.var_fa63b371);
      var_c39b3c14.var_fa63b371 = undefined;
    }

    if(isDefined(var_c39b3c14)) {
      var_c39b3c14 delete();
    }

    s_portal.var_82f9314e[fieldname] = undefined;
  }
}

function function_1d123acd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    level.var_d58a6548 = 45;
    return;
  }

  if(bwasdemojump == 2) {
    level.var_d58a6548 = 30;
  }
}

function function_5bc9772e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self.ambient_fx = playFX(fieldname, #"hash_240b951190d035ec", self.origin);
    return;
  }

  self playSound(fieldname, #"zmb_powerup_resource_small_pickup");

  if(isDefined(self.ambient_fx)) {
    killfx(fieldname, self.ambient_fx);
  }

  playFX(fieldname, #"hash_ea17935f6555b31", self.origin);
}

function function_51ee271b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    util::function_8eb5d4b0(3500, 0);
    return;
  }

  util::function_8eb5d4b0(3500, 2.5);
}

function function_5414ee31(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_3385d776(#"hash_122a51c7a09dab6b");
    return;
  }

  function_c22a1ca2(#"hash_122a51c7a09dab6b");
}

function function_eff937db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self function_c2e69953(1);
    return;
  }

  self function_c2e69953(0);
}

function SetPBGExposureBank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setexposureactivebank(fieldname, bwastimejump);
  setpbgactivebank(fieldname, bwastimejump);
}

function function_72c3294(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    function_be93487f(fieldname, 2, 1, 1, 0, 0);
  }
}

function function_43b0a4e2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    var_b5eeda48 = getent(fieldname, "pizza_parlor_sign", "targetname");
    var_b5eeda48 setModel(#"p9_usa_neon_open_sign_on");
  }
}

function function_1a91c8d3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isalive(self) || self !== function_5c10bd79(binitialsnap)) {
    return;
  }

  if(bwastimejump) {
    gender = "male";

    if(bwastimejump == 2) {
      gender = "fem";
      function_12f0cc0d("xanim_mm_brawler_" + gender + "_standjump_fall_loop");
    }

    function_12f0cc0d("xanim_mm_brawler_" + gender + "_stand_idle");
    function_12f0cc0d("xanim_mm_brawler_" + gender + "_standjump_fall_loop_idle");
    function_12f0cc0d("xanim_mm_brawler_" + gender + "_standjump_land_2f_up");
    return;
  }

  gender = "male";

  if(fieldname == 2) {
    gender = "fem";
    function_4b51b406("xanim_mm_brawler_" + gender + "_standjump_fall_loop");
  }

  function_4b51b406("xanim_mm_brawler_" + gender + "_stand_idle");
  function_4b51b406("xanim_mm_brawler_" + gender + "_standjump_fall_loop_idle");
  function_4b51b406("xanim_mm_brawler_" + gender + "_standjump_land_2f_up");
}

function function_9163efd4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!isDefined(self.var_ba396b8a)) {
      self.var_ba396b8a = function_239993de(fieldname, #"hash_7931d47b70c1a3de", self, "tag_searchlight_glass_d0");
    }

    if(!isDefined(self.var_522dfce9)) {
      self.var_522dfce9 = function_239993de(fieldname, #"hash_33a301617d6aee02", self, "tag_deathfx");
    }

    if(!isDefined(self.var_ddbb1a2b)) {
      self.var_ddbb1a2b = function_239993de(fieldname, #"hash_38a99091a299bb1", self, "tag_fx_engine_exhaust_right");
    }

    if(!isDefined(self.var_d78780c8)) {
      self.var_d78780c8 = function_239993de(fieldname, #"hash_64928348a5830b81", self, "tag_ground");
    }

    return;
  }

  if(isDefined(self.var_ba396b8a)) {
    deletefx(fieldname, self.var_ba396b8a);
    self.var_ba396b8a = undefined;
  }

  if(isDefined(self.var_522dfce9)) {
    deletefx(fieldname, self.var_522dfce9);
    self.var_522dfce9 = undefined;
  }

  if(isDefined(self.var_ddbb1a2b)) {
    deletefx(fieldname, self.var_ddbb1a2b);
    self.var_ddbb1a2b = undefined;
  }

  if(isDefined(self.var_d78780c8)) {
    deletefx(fieldname, self.var_d78780c8);
    self.var_d78780c8 = undefined;
  }
}

function function_61d33efe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isalive(self) || self !== function_5c10bd79(fieldname)) {
    return;
  }

  if(bwastimejump) {
    forcestreamxmodel("veh_t9_zm_arc_xd");
    return;
  }

  stopforcestreamingxmodel("veh_t9_zm_arc_xd");
}