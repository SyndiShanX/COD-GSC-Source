/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red_ww_quests.csc
***********************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_utility;

#namespace zm_red_ww_quests;

init() {
  if(!zm_custom::function_901b751c(#"zmwonderweaponisenabled") || zm_utility::is_standard()) {
    return;
  }

  var_5f0c1df8 = getminbitcountfornum(4);
  clientfield::register("scriptmover", "" + #"hash_4195d99bef577e46", 16000, 1, "int", &function_944d867a, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_7fb27e0252c756b", 16000, 1, "int", &function_2879e2a2, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_1cdf2252d9f82767", 16000, 1, "int", &function_dcfcbf53, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_1d886dddf28e80bc", 16000, 1, "int", &function_9d8dd7, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_1bf7e7b03fec9e45", 16000, 1, "int", &function_3d5367c, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_776a3c21050eaa0", 16000, 1, "int", &function_66bf3a98, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_4e65af2ec1b830f7", 16000, 1, "int", &function_d152d13c, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_7f97409952dd051b", 16000, 1, "int", &function_58806d4f, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_4ff047c7bc266fd7", 16000, 1, "int", &function_b2beae83, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_5e8e9f6599d57c0a", 16000, 1, "int", &function_283ae654, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_23ba81a7c071845d", 16000, 1, "int", &function_91aa103, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_5faf31a2c4d4f4c6", 16000, 1, "int", &function_4854ae4f, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_54b4fbe8e74caf21", 16000, 1, "int", &function_f8b29e52, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_4b6213be97ba0c98", 16000, 1, "counter", &function_587efcf8, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_66d67792eeae46ac", 16000, 1, "counter", &function_251c7b6d, 0, 0);
  clientfield::register("allplayers", "" + #"hash_1b4d6dabd35ebdf2", 16000, 1, "int", &function_84874233, 0, 0);
  clientfield::register("allplayers", "" + #"hash_11e36d278c735869", 16000, 1, "int", &function_b50a9153, 0, 0);
  clientfield::register("allplayers", "" + #"hash_e683dccc6a8e152", 16000, 1, "int", &function_f2536be, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_5208f90a0114c9e", 16000, var_5f0c1df8, "int", &function_32753a57, 0, 0);
  clientfield::register("scriptmover", "" + #"charon_portal_fx", 16000, 1, "int", &charon_portal_fx, 0, 0);
  clientfield::register("toplayer", "" + #"hash_e2692f239454272", 16000, 1, "int", &charon_curse_fx, 0, 0);
  clientfield::register("allplayers", "" + #"charon_teleport_postfx", 16000, 1, "int", &charon_teleport_postfx, 0, 0);
  clientfield::register("allplayers", "" + #"ouranos_teleport_postfx", 16000, 1, "int", &ouranos_teleport_postfx, 0, 0);
  clientfield::register("allplayers", "" + #"gaia_teleport_postfx", 16000, 1, "int", &gaia_teleport_postfx, 0, 0);
  clientfield::register("allplayers", "" + #"hemera_teleport_postfx", 16000, 1, "int", &hemera_teleport_postfx, 0, 0);
  clientfield::register("scriptmover", "" + #"gaia_portal_fx", 16000, 1, "int", &gaia_portal_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"gaia_sprout_fx", 16000, getminbitcountfornum(3), "int", &gaia_sprout_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_3c85334429a971b4", 16000, 1, "int", &function_162c09a8, 0, 0);
  clientfield::register("scriptmover", "" + #"gaia_chaos_glow", 16000, 1, "int", &function_251065bc, 0, 0);
  clientfield::register("scriptmover", "" + #"gaia_chaos_destroy", 16000, 1, "int", &gaia_chaos_destroy, 0, 0);
  clientfield::register("scriptmover", "" + #"ouranos_feather_hit_fx", 16000, 1, "counter", &ouranos_feather_hit_fx, 0, 0);
  clientfield::register("actor", "" + #"ww_combat_fx", 16000, getminbitcountfornum(4), "int", &ww_combat_fx, 0, 0);
  level._effect[#"charon_hand_available"] = #"hash_13a5a3395df9015f";
  level._effect[#"hemera_hand_available"] = #"hash_45df7abd6ad1c06";
  level._effect[#"gaia_hand_available"] = #"hash_105b525291a60488";
  level._effect[#"ouranos_hand_available"] = #"hash_7c755acc6547a0fd";
  level._effect[#"hemera_source_glow"] = #"hash_7e62aa95417546aa";
  level._effect[#"hemera_shrine_glow"] = #"hash_3a7504611a8ee7ef";
  level._effect[#"hash_7ba74dab3ce4c1a9"] = #"hash_65d0dff5c51ac70d";
  level._effect[#"hash_223052fa57a81234"] = #"hash_4bd8c2963780c080";
  level._effect[#"hash_4982dd14ad4cfd2d"] = #"hash_7da081bd4cf99d11";
  level._effect[#"hash_7bae59ab3ceaf4bb"] = #"hash_65d7cbf5c520c3bf";
  level._effect[#"hash_22363efa57ac5be6"] = #"hash_4bdfce963786f392";
  level._effect[#"hash_4989c914ad52f9df"] = #"hash_7da76dbd4cff99c3";
  level._effect[#"hemera_bounce_glow"] = #"hash_281a29752dd70fec";
  level._effect[#"hash_1ba95bf40a5e2422"] = #"hash_1a423b45182c5613";
  level._effect[#"hash_3f63da724d02ddbd"] = #"hash_410c47b601f1eb2a";
  level._effect[#"charon_portal_active"] = #"hash_a522275afc959a7";
  level._effect[#"gaia_portal_active"] = #"hash_307731202349b92a";
  level._effect[#"hash_1df737ccb8838bac"] = #"hash_2b910e77f63948fb";
  level._effect[#"hash_4e4c7f6982d8ed31"] = #"hash_2fa2ffba30119b62";
  level._effect[#"hash_19da57144416b720"] = #"hash_17e7186ea20ae80c";
  level._effect[#"gaia_chaos_glow"] = #"hash_d0cf56779f6c4e1";
  level._effect[#"gaia_chaos_destroy"] = #"hash_2c52af4b97cdbc0a";
  level._effect[#"gaia_combat_fx"] = #"hash_569b6effe4db6f54";
  level._effect[#"charon_combat_fx"] = #"hash_7b7ba0ac0755a064";
  level._effect[#"hemera_combat_fx"] = #"hash_7e9736ee8b5ec443";
  level._effect[#"ouranos_combat_fx"] = #"hash_194fead3457d21f5";
  level._effect[#"hash_4024dfc409879380"] = #"hash_570e356dcecf7c0f";
  level._effect[#"hash_18794d000c118e97"] = #"hash_131f7254a32ca20e";
  level._effect[#"hash_799b84ee296b448d"] = #"hash_690957421115776c";
  level._effect[#"hash_25540559b2b0c1b4"] = #"hash_3f2f5721b1727993";
  level._effect[#"hash_3c9246be63bb58bd"] = #"hash_5199aa40f704fb10";
  level._effect[#"hash_23f796cb2dcb35c3"] = #"hash_1dfbcfd9b38812ed";
  level._effect[#"hash_3c9241be63bb503e"] = #"hash_56c34b9c914d89a7";
  level._effect[#"hash_32278e3b7ad26e0"] = #"hash_1185a069551613dc";
  level._effect[#"hash_3c9256be63bb73ed"] = #"maps/zm_red/fx8_soul_red";
  level._effect[#"hash_70ef864effe35b13"] = #"maps/zm_red/fx8_soul_charge_red";
  level._effect[#"hash_3c924bbe63bb613c"] = #"hash_36d2617efc112fc";
  level._effect[#"hash_2c33b0af2f93389e"] = #"hash_7425021c14828449";
  level._effect[#"gaia_sprout_fx"] = #"hash_4ee71079fa3bd589";
  level._effect[#"hash_28b5e7d929f598ee"] = #"hash_7d10580c812fce51";
  level._effect[#"hash_3f03e0537e170fc4"] = #"hash_647338beb2cb34ec";
  zm_sq_modules::function_d8383812(#"ww_sc_earth", 16000, #"ww_sc_g", 100, level._effect[#"hash_3c9241be63bb503e"], level._effect[#"hash_32278e3b7ad26e0"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"ww_sc_death", 16000, #"ww_sc_c", 100, level._effect[#"hash_3c9256be63bb73ed"], level._effect[#"hash_70ef864effe35b13"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"ww_sc_light", 16000, #"ww_sc_h", 100, level._effect[#"hash_3c924bbe63bb613c"], level._effect[#"hash_2c33b0af2f93389e"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"ww_sc_air", 16000, #"ww_sc_o", 100, level._effect[#"hash_3c9246be63bb58bd"], level._effect[#"hash_23f796cb2dcb35c3"], undefined, undefined, 1);
}

function_91aa103(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_a7be4b54)) {
    stopfx(localclientnum, self.var_a7be4b54);
    self.var_a7be4b54 = undefined;
  }

  if(newval == 1) {
    if(self.model !== #"p8_zm_red_gauntlet_handle") {
      util::lock_model(#"p8_zm_red_gauntlet_handle");
    }

    if(self.model === #"p8_fxanim_zm_red_ww_vase_mod") {
      v_location = (self.origin[0], self.origin[1], self.origin[2] + 18);
      self.var_a7be4b54 = playFX(localclientnum, level._effect[#"hash_19da57144416b720"], v_location);
    } else {
      self.var_a7be4b54 = util::playFXOnTag(localclientnum, level._effect[#"hash_19da57144416b720"], self, "tag_origin");
    }

    return;
  }

  if(self.model === #"p8_zm_red_gauntlet_handle") {
    util::unlock_model(#"p8_zm_red_gauntlet_handle");
  }
}

ww_combat_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_59140340)) {
    stopfx(localclientnum, self.var_59140340);
    self.var_59140340 = undefined;
  }

  if(newval > 0) {
    switch (newval) {
      case 1:
        str_fx = level._effect[#"charon_combat_fx"];
        break;
      case 2:
        str_fx = level._effect[#"ouranos_combat_fx"];
        break;
      case 3:
        str_fx = level._effect[#"hemera_combat_fx"];
        break;
      case 4:
        str_fx = level._effect[#"gaia_combat_fx"];
        break;
    }

    if(isDefined(str_fx)) {
      self.var_59140340 = util::playFXOnTag(localclientnum, str_fx, self, "j_spine4");
    }
  }
}

function_944d867a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self.var_ce41d506 = util::playFXOnTag(localclientnum, level._effect[#"gaia_hand_available"], self, "tag_shrine_glow");
}

function_9d8dd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self.var_ce41d506 = util::playFXOnTag(localclientnum, level._effect[#"hemera_hand_available"], self, "tag_shrine_glow");
}

function_2879e2a2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self.var_ce41d506 = util::playFXOnTag(localclientnum, level._effect[#"charon_hand_available"], self, "tag_shrine_glow");
}

function_dcfcbf53(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self.var_ce41d506 = util::playFXOnTag(localclientnum, level._effect[#"ouranos_hand_available"], self, "tag_shrine_glow");
}

function_58806d4f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self playrenderoverridebundle(#"hash_48aca9d341c98dca");
    return;
  }

  self function_f6e99a8d(#"hash_48aca9d341c98dca");
}

function_b2beae83(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self playrenderoverridebundle(#"hash_3b5fcab59be4e41c");
    return;
  }

  self function_f6e99a8d(#"hash_3b5fcab59be4e41c");
}

function_283ae654(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self playrenderoverridebundle(#"hash_51fa5973d5832e75");
    return;
  }

  self function_f6e99a8d(#"hash_51fa5973d5832e75");
}

function_4854ae4f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.var_4e35f286 = util::playFXOnTag(localclientnum, level._effect[#"hemera_shrine_glow"], self, "tag_origin");
    return;
  }

  if(isDefined(self.var_4e35f286)) {
    stopfx(localclientnum, self.var_4e35f286);
  }
}

function_f8b29e52(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.var_abef553 = util::playFXOnTag(localclientnum, level._effect[#"hemera_shoot"], self, "tag_origin");
    return;
  }

  if(isDefined(self.var_abef553)) {
    stopfx(localclientnum, self.var_abef553);
  }
}

function_251c7b6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self.var_4e35f286 = util::playFXOnTag(localclientnum, level._effect[#"hemera_bounce_glow"], self, "tag_origin");
}

function_587efcf8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self.var_4e35f286 = util::playFXOnTag(localclientnum, level._effect[#"hemera_shrine_glow"], self, "tag_origin");
}

function_84874233(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_2c3ee59a)) {
    killfx(localclientnum, self.var_2c3ee59a);
    self.var_2c3ee59a = undefined;
  }

  if(newval) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      self.var_2c3ee59a = playviewmodelfx(localclientnum, level._effect[#"hash_7ba74dab3ce4c1a9"], "tag_crystal_main");
      return;
    }

    self.var_2c3ee59a = util::playFXOnTag(localclientnum, level._effect[#"hash_7bae59ab3ceaf4bb"], self, "tag_crystal_main");
  }
}

function_f2536be(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_2c3ee59a)) {
    killfx(localclientnum, self.var_2c3ee59a);
    self.var_2c3ee59a = undefined;
  }

  if(newval) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      self.var_2c3ee59a = playviewmodelfx(localclientnum, level._effect[#"hash_4982dd14ad4cfd2d"], "tag_crystal_main");
      return;
    }

    self.var_2c3ee59a = util::playFXOnTag(localclientnum, level._effect[#"hash_4989c914ad52f9df"], self, "tag_crystal_main");
  }
}

function_b50a9153(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_2c3ee59a)) {
    killfx(localclientnum, self.var_2c3ee59a);
    self.var_2c3ee59a = undefined;
  }

  if(newval) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      self.var_2c3ee59a = playviewmodelfx(localclientnum, level._effect[#"hash_223052fa57a81234"], "tag_crystal_main");
      return;
    }

    self.var_2c3ee59a = util::playFXOnTag(localclientnum, level._effect[#"hash_22363efa57ac5be6"], self, "tag_crystal_main");
  }
}

function_d152d13c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    if(self.model === #"hash_31a411dafa5678e2") {
      self.var_97486d35 = playFX(localclientnum, level._effect[#"hash_1ba95bf40a5e2422"], self.origin);
    } else if(self.model === #"p8_zm_red_rune_circle_ouranos") {
      self.var_97486d35 = playFX(localclientnum, level._effect[#"hash_4e4c7f6982d8ed31"], self.origin);
    } else if(self.model === #"p8_zm_red_rune_circle_gaia") {
      self.var_97486d35 = playFX(localclientnum, level._effect[#"hash_1df737ccb8838bac"], self.origin);
    } else if(self.model === #"p8_zm_red_rune_circle_charron") {
      self.var_97486d35 = playFX(localclientnum, level._effect[#"hash_3f63da724d02ddbd"], self.origin);
    }

    if(!isDefined(self.var_ee19f039)) {
      self playSound(localclientnum, #"hash_2a2e94df88aba776");
      self.var_ee19f039 = self playLoopSound(#"hash_65dbfa8df991491a");
    }

    return;
  }

  if(isDefined(self.var_97486d35)) {
    stopfx(localclientnum, self.var_97486d35);
  }

  if(isDefined(self.var_ee19f039)) {
    self playSound(localclientnum, #"hash_685aec3eee9aacf3");
    self stoploopsound(self.var_ee19f039);
  }
}

function_32753a57(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    self stoprenderoverridebundle(#"hash_37b4f35b06388e8c");
    return;
  }

  e_player = getentbynum(localclientnum, newval - 1);
  e_player_local = function_5c10bd79(localclientnum);

  if(!isDefined(e_player) || !isDefined(e_player_local)) {
    return;
  }

  if(e_player != e_player_local) {
    return;
  }

  self playrenderoverridebundle(#"hash_37b4f35b06388e8c");
}

ouranos_feather_hit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self.var_de4f1b63 = playFX(localclientnum, level._effect[#"ouranos_impact"], self.origin);
}

charon_portal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.var_8eb4e749 = util::playFXOnTag(localclientnum, level._effect[#"charon_portal_active"], self, "tag_origin");
    playSound(localclientnum, #"hash_2545ab11d0e8966a", self.origin);
    return;
  }

  if(isDefined(self.var_8eb4e749)) {
    stopfx(localclientnum, self.var_8eb4e749);
  }

  playSound(localclientnum, #"hash_15e7e9734cce421e", self.origin);
}

charon_curse_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval && self util::function_50ed1561(localclientnum)) {
    self thread function_e887425a(localclientnum);
    return;
  }

  self thread function_761eecad(localclientnum);
}

function_e887425a(localclientnum) {
  self notify(#"charon_curse_fx");
  self endon(#"death", #"disconnect", #"charon_curse_fx");

  if(!self postfx::function_556665f2(#"pstfx_zm_man_curse")) {
    self postfx::playpostfxbundle(#"pstfx_zm_man_curse");
  }

  if(!isDefined(self.var_222e996f)) {
    self playSound(localclientnum, #"hash_373ab869c634b58b");
    self.var_222e996f = self playLoopSound(#"hash_5b12d6dc3fd13c3d");
  }
}

function_761eecad(localclientnum) {
  if(self postfx::function_556665f2(#"pstfx_zm_man_curse")) {
    self postfx::exitpostfxbundle(#"pstfx_zm_man_curse");
  }

  if(isDefined(self.var_222e996f)) {
    self playSound(localclientnum, #"hash_4f2c92409321076e");
    self stoploopsound(self.var_222e996f);
    self.var_222e996f = undefined;
  }
}

charon_teleport_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.var_f252bba1)) {
    self.var_f252bba1 = [];
  }

  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(!e_player util::function_50ed1561(localclientnum)) {
      return;
    }
  }

  if(newval) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(!self postfx::function_556665f2(#"hash_33f79c189a73adf9")) {
        self postfx::playpostfxbundle(#"hash_33f79c189a73adf9");
      }
    } else {
      self.var_f252bba1[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"hash_4024dfc409879380"], self, "j_spine4");
    }

    return;
  }

  if(isDefined(self.var_f252bba1[localclientnum])) {
    deletefx(localclientnum, self.var_f252bba1[localclientnum], 1);
    self.var_f252bba1[localclientnum] = undefined;
  }

  if(self postfx::function_556665f2(#"hash_33f79c189a73adf9")) {
    self postfx::exitpostfxbundle(#"hash_33f79c189a73adf9");
  }
}

gaia_sprout_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (newval) {
    case 0:
      if(isDefined(self.var_1685ad34)) {
        stopfx(localclientnum, self.var_1685ad34);
        self.var_1685ad34 = undefined;
      }

      if(isDefined(self.var_6a7be41c)) {
        stopfx(localclientnum, self.var_6a7be41c);
        self.var_6a7be41c = undefined;
      }

      if(isDefined(self.var_11f91edd)) {
        stopfx(localclientnum, self.var_11f91edd);
        self.var_11f91edd = undefined;
      }

      break;
    case 1:
      if(!isDefined(self.var_1685ad34)) {
        self.var_1685ad34 = util::playFXOnTag(localclientnum, level._effect[#"gaia_sprout_fx"], self, "tag_fx_lt");
      }

      break;
    case 2:
      if(!isDefined(self.var_6a7be41c)) {
        self.var_6a7be41c = util::playFXOnTag(localclientnum, level._effect[#"gaia_sprout_fx"], self, "tag_fx_rt");
      }

      break;
    case 3:
      if(!isDefined(self.var_11f91edd)) {
        self.var_11f91edd = util::playFXOnTag(localclientnum, level._effect[#"gaia_sprout_fx"], self, "tag_fx_mid");
      }

      break;
  }
}

function_edc6704a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self playrenderoverridebundle("rob_zm_gaia_portal_dissolve");
    return;
  }

  self stoprenderoverridebundle("rob_zm_gaia_portal_dissolve");
}

function_162c09a8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self playrenderoverridebundle("rob_gaia_bush_transform_start");
    util::lock_model(#"hash_3cb03679991cf4ad");
    return;
  }

  self stoprenderoverridebundle("rob_gaia_bush_transform_start");
  wait 2;

  if(isDefined(self)) {
    self playrenderoverridebundle("rob_gaia_bush_transform_finish");
  }

  util::unlock_model(#"hash_3cb03679991cf4ad");
}

gaia_portal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    playSound(localclientnum, #"hash_2545ab11d0e8966a", self.origin);
    wait 0.5;

    if(isDefined(self)) {
      self.var_8eb4e749 = playFX(localclientnum, level._effect[#"gaia_portal_active"], self.origin + (0, 0, 45) + anglesToForward(self.angles) * -6, anglesToForward(self.angles), anglestoup(self.angles));
      self playrenderoverridebundle("rob_zm_gaia_portal_dissolve");
    }

    return;
  }

  if(isDefined(self.var_8eb4e749)) {
    stopfx(localclientnum, self.var_8eb4e749);
  }

  self stoprenderoverridebundle("rob_zm_gaia_portal_dissolve");
  playSound(localclientnum, #"hash_15e7e9734cce421e", self.origin);
}

hemera_teleport_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.var_f252bba1)) {
    self.var_f252bba1 = [];
  }

  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(!e_player util::function_50ed1561(localclientnum)) {
      return;
    }
  }

  if(newval) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(!self postfx::function_556665f2(#"hash_867b31debc40b0a")) {
        self postfx::playpostfxbundle(#"hash_867b31debc40b0a");
      }
    } else {
      self.var_f252bba1[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"hash_799b84ee296b448d"], self, "j_spine4");
    }

    return;
  }

  if(isDefined(self.var_f252bba1[localclientnum])) {
    deletefx(localclientnum, self.var_f252bba1[localclientnum], 1);
    self.var_f252bba1[localclientnum] = undefined;
  }

  if(self postfx::function_556665f2(#"hash_867b31debc40b0a")) {
    self postfx::exitpostfxbundle(#"hash_867b31debc40b0a");
  }
}

gaia_teleport_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.var_f252bba1)) {
    self.var_f252bba1 = [];
  }

  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(!e_player util::function_50ed1561(localclientnum)) {
      return;
    }
  }

  if(newval) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(!self postfx::function_556665f2(#"hash_2ea4efbdd5fc3dfd")) {
        self postfx::playpostfxbundle(#"hash_2ea4efbdd5fc3dfd");
      }
    } else {
      self.var_f252bba1[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"hash_18794d000c118e97"], self, "j_spine4");
    }

    return;
  }

  if(isDefined(self.var_f252bba1[localclientnum])) {
    deletefx(localclientnum, self.var_f252bba1[localclientnum], 1);
    self.var_f252bba1[localclientnum] = undefined;
  }

  if(self postfx::function_556665f2(#"hash_2ea4efbdd5fc3dfd")) {
    self postfx::exitpostfxbundle(#"hash_2ea4efbdd5fc3dfd");
  }
}

ouranos_teleport_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.var_f252bba1)) {
    self.var_f252bba1 = [];
  }

  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(!e_player util::function_50ed1561(localclientnum)) {
      return;
    }
  }

  if(newval) {
    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(!self postfx::function_556665f2(#"hash_49cc4d561f671b1a")) {
        self postfx::playpostfxbundle(#"hash_49cc4d561f671b1a");
      }
    } else {
      self.var_f252bba1[localclientnum] = util::playFXOnTag(localclientnum, level._effect[#"hash_25540559b2b0c1b4"], self, "j_spine4");
    }

    return;
  }

  if(isDefined(self.var_f252bba1[localclientnum])) {
    deletefx(localclientnum, self.var_f252bba1[localclientnum], 1);
    self.var_f252bba1[localclientnum] = undefined;
  }

  if(self postfx::function_556665f2(#"hash_49cc4d561f671b1a")) {
    self postfx::exitpostfxbundle(#"hash_49cc4d561f671b1a");
  }
}

function_3d5367c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.var_2ad5fe32 = util::playFXOnTag(localclientnum, level._effect[#"hash_28b5e7d929f598ee"], self, "tag_origin");

    if(!isDefined(self.var_eb6ae592)) {
      self.var_eb6ae592 = self playLoopSound(#"hash_627c599558a48326");
    }

    return;
  }

  if(isDefined(self.var_2ad5fe32)) {
    stopfx(localclientnum, self.var_2ad5fe32);
  }

  if(isDefined(self.var_eb6ae592)) {
    self stoploopsound(self.var_eb6ae592);
  }
}

function_66bf3a98(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.var_5d1596c4 = util::playFXOnTag(localclientnum, level._effect[#"hash_3f03e0537e170fc4"], self, "tag_origin");

    if(!isDefined(self.var_3988e6c5)) {
      self playSound(localclientnum, #"hash_31642472e12e91b6");
      self.var_3988e6c5 = self playLoopSound(#"hash_2d40a75eafe60af");
    }

    return;
  }

  if(isDefined(self.var_5d1596c4)) {
    stopfx(localclientnum, self.var_5d1596c4);
  }

  if(isDefined(self.var_3988e6c5)) {
    self stoploopsound(self.var_3988e6c5);
  }
}

function_251065bc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    switch (self.model) {
      case #"hash_17ff8b184015c0d0":
        str_tag = "tag_center_01";
        break;
      case #"hash_17ff8e184015c5e9":
        str_tag = "tag_center_02";
        break;
      case #"hash_17ff8d184015c436":
        str_tag = "tag_center_03";
        break;
    }

    if(isDefined(str_tag)) {
      v_pos = self gettagorigin(str_tag);
    }

    if(isDefined(self) && isDefined(v_pos)) {
      self.var_f9359f98 = util::playFXOnTag(localclientnum, level._effect[#"gaia_chaos_glow"], self, str_tag);
    }

    return;
  }

  if(isDefined(self.var_f9359f98)) {
    stopfx(localclientnum, self.var_f9359f98);
  }
}

gaia_chaos_destroy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    switch (self.model) {
      case #"hash_17ff8b184015c0d0":
        str_tag = "tag_center_01";
        break;
      case #"hash_17ff8e184015c5e9":
        str_tag = "tag_center_02";
        break;
      case #"hash_17ff8d184015c436":
        str_tag = "tag_center_03";
        break;
    }

    self.var_11fa0a4a = util::playFXOnTag(localclientnum, level._effect[#"gaia_chaos_destroy"], self, "tag_origin");
  }
}