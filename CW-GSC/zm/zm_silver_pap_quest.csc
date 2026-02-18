/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_silver_pap_quest.csc
***********************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_ping;
#using scripts\zm_common\zm_utility;
#namespace zm_silver_pap_quest;

function init_clientfield() {
  clientfield::register("world", "" + # "hash_27895772c4825a7a", 1, 1, "int", &function_619cd4e5, 0, 0);
  clientfield::register("toplayer", "" + # "hash_14ba797c22b75dda", 1, 1, "counter", &function_483f3ae0, 0, 0);

  if(getgametypesetting(#"zmpapenabled") !== 1) {
    return;
  }

  clientfield::register("world", "" + # "hash_5cf186464ce9cdd6", 1, 1, "counter", &function_33082eb4, 0, 0);
  clientfield::register("world", "" + # "hash_7b3ada6e5b1cf81e", 1, 1, "int", &function_167fc35, 0, 0);
  clientfield::register("world", "" + # "hash_53c6d001e2faecab", 1, 1, "counter", &function_c4603212, 0, 0);
  clientfield::register("world", "" + # "hash_266f6fe481bab1bc", 1, 1, "int", &function_4dff5056, 0, 0);
  clientfield::register("toplayer", "" + # "hash_1fa45e1c3652d753", 1, 1, "int", &function_6902ffa4, 0, 0);
  clientfield::register("toplayer", "" + # "hash_c34d1c4bd1aa84a", 1, 1, "counter", &function_b56e6c7e, 0, 0);
  clientfield::register("toplayer", "" + # "hash_385053c55d081e0d", 1, 1, "counter", &function_ceb6041f, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7ec80a02e9bb051a", 1, 1, "int", &function_760c94c, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_5a293ad1c677dc7e", 1, 1, "int", &function_2424f2ac, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7919b736a767a0f5", 1, 2, "int", &function_e5ffabef, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_54d221181b1a11f", 1, 2, "int", &function_840cc260, 0, 0);
  clientfield::register("world", "" + # "hash_51ed1d1064cfb0e", 1, 1, "int", &function_32b2a189, 0, 0);
}

function function_ceb6041f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrumbleonentity(fieldname, #"hash_44eeee909d5a03fd");
  }
}

function function_b56e6c7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrumbleonentity(fieldname, #"hash_6f2efd46e3afdbda");
  }
}

function function_483f3ae0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrumbleonentity(fieldname, #"hash_26108e3d29c29f8a");
  }
}

function function_840cc260(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    util::playFXOnTag(fieldname, #"hash_1342d11d976068f7", self, "tag_top");
    util::playFXOnTag(fieldname, #"hash_1342d11d976068f7", self, "tag_mid");
    util::playFXOnTag(fieldname, #"hash_1342d11d976068f7", self, "tag_btm");
    return;
  }

  if(bwastimejump == 2) {
    self.var_5bc43247 = util::playFXOnTag(fieldname, #"hash_1342d11d976068f7", self, "tag_machine_fx");
    return;
  }

  if(isDefined(self.var_5bc43247)) {
    stopfx(fieldname, self.var_5bc43247);
  }
}

function function_6902ffa4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    earthquake(fieldname, 0.2, 2, self.origin, 100);
    self playrumbleonentity(fieldname, "damage_light");
  }
}

function function_e5ffabef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_46658967)) {
    stopfx(fieldname, self.var_46658967);
  }

  if(bwastimejump == 1) {
    self.var_46658967 = util::playFXOnTag(fieldname, #"hash_6583defa5c93e609", self, "tag_origin");
    return;
  }

  if(bwastimejump == 2) {
    self.var_46658967 = util::playFXOnTag(fieldname, #"hash_65063e9505bafd58", self, "tag_origin");
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

function function_33082eb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = function_5c10bd79(bwastimejump);

  if(isDefined(e_player)) {
    e_player postfx::playpostfxbundle(#"hash_7fbc9bc489aea188");
    e_player playSound(bwastimejump, #"hash_56a9d9da20064c3f");
    function_5ea2c6e3("zm_silver_darkaether_leadin", 7);
  }
}

function function_4dff5056(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = function_5c10bd79(fieldname);

  if(bwastimejump) {
    if(isDefined(e_player)) {
      e_player postfx::playpostfxbundle(#"hash_7f1cd473dc07762");
    }
  } else if(isDefined(e_player)) {
    e_player postfx::stoppostfxbundle(#"hash_7f1cd473dc07762");
  }

  foreach(player in getplayers(fieldname)) {
    player thread function_b28348c(fieldname);
  }
}

function function_b28348c(localclientnum) {
  self endon(#"death");
  wait 3.5;

  if(self zm_utility::function_f8796df3(localclientnum)) {
    playviewmodelfx(localclientnum, #"hash_255cc054085bf4c4", "tag_torso");
    return;
  }

  util::playFXOnTag(localclientnum, #"hash_2563ac540861f176", self, "j_spine4");
}

function function_c4603212(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = function_5c10bd79(bwastimejump);

  if(isDefined(e_player)) {
    e_player postfx::playpostfxbundle(#"hash_5260e981ac8cbbe7");
  }
}

function function_760c94c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.portal_fx = util::playFXOnTag(fieldname, #"hash_6b812867a0d2dde5", self, "tag_origin");

    if(!isDefined(self.var_abc21e11)) {
      self playSound(fieldname, #"hash_4a04fd9edb696634");
      self.var_abc21e11 = self playLoopSound(#"hash_61bfd6cc3f47194");
    }

    return;
  }

  if(isDefined(self.var_abc21e11)) {
    killfx(fieldname, self.portal_fx);
    self playSound(fieldname, #"hash_257a16d125ce57ed");
    self stoploopsound(self.var_abc21e11);
    self.var_abc21e11 = undefined;
  }
}

function function_2424f2ac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    util::playFXOnTag(fieldname, #"maps/zm_escape/fx8_pap_lightning_near", self, "tag_origin");
  }
}

function function_32b2a189(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    setsoundcontext("dark_aether", "active");
    function_ed62c9c2("zm_silver_darkaether_leadin", 1.5);
    function_5ea2c6e3("lpf_pacc_opening_lp", 1);
    function_5ea2c6e3("lpf_pacc_lp", 1);
    audio::playloopat("zmb_darkaether_bg_loop", (0, 0, 0));
    return;
  }

  setsoundcontext("dark_aether", "inactive");
  function_ed62c9c2("zm_silver_darkaether_leadin", 1.5);
  function_ed62c9c2("lpf_pacc_opening_lp", 1);
  function_ed62c9c2("lpf_pacc_lp", 1);
  audio::stoploopat("zmb_darkaether_bg_loop", (0, 0, 0));
}

function function_619cd4e5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_73aae81b)) {
    level.var_73aae81b = getdynentarray("dark_aehter_loot_crystal", 1);
  }

  if(bwastimejump == 1) {
    foreach(crystal in level.var_73aae81b) {
      setdynentstate(fieldname, crystal, 2);
      function_75d53026(crystal);

      if(isarray(level.var_5d9a0215)) {
        arrayremovevalue(level.var_5d9a0215, crystal);
      }
    }

    player = function_27673a7(fieldname);

    if(isDefined(player) && isDefined(level.var_d5d697f5) && player hastalent(fieldname, #"talent_deathperception_5")) {
      player[[level.var_d5d697f5]](fieldname, 0, 1);
    }

    return;
  }

  foreach(crystal in level.var_73aae81b) {
    setdynentstate(fieldname, crystal, 0);

    if(isarray(level.var_5d9a0215)) {
      if(!isDefined(level.var_5d9a0215)) {
        level.var_5d9a0215 = [];
      } else if(!isarray(level.var_5d9a0215)) {
        level.var_5d9a0215 = array(level.var_5d9a0215);
      }

      if(!isinarray(level.var_5d9a0215, crystal)) {
        level.var_5d9a0215[level.var_5d9a0215.size] = crystal;
      }
    }
  }

  player = function_27673a7(fieldname);

  if(isDefined(player) && isDefined(level.var_d5d697f5) && player hastalent(fieldname, #"talent_deathperception_5")) {
    player[[level.var_d5d697f5]](fieldname, 0, 1);
  }
}