/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_platinum.csc
***********************************************/

#using script_14b99732aeac3ca6;
#using script_179ba564f65e92c5;
#using script_1f60f29863707208;
#using script_24f8d3e335c86c5a;
#using script_2792a9e9aa00fe6e;
#using script_2c5f2d4e7aa698c4;
#using script_2fbd61c3675dc7ca;
#using script_3a266261121385ee;
#using script_3dcf1dc8f679581e;
#using script_42fe6daed87beaf5;
#using script_433016448b3d07bc;
#using script_581877678e31274c;
#using script_5cd3f24eb1709844;
#using script_68732f44626820ed;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\archetype\archetype_zod_companion;
#using scripts\zm\zm_platinum_ww_quest;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_intel;
#using scripts\zm_common\zm_ping;
#using scripts\zm_common\zm_utility;
#namespace zm_platinum;

function autoexec opt_in() {
  level.aat_in_use = 1;
}

function event_handler[level_init] main(eventstruct) {
  zm_ping::function_5ae4a10c(undefined, "platinum_rappel_obj", #"hash_337db80f69d05548", #"hash_5b20033c44a4321f", #"ui_icon_general_feedback_zipline");
  zm_ping::function_5ae4a10c(undefined, "platinum_zipline_obj", #"hash_6d0057fa066d6733", #"hash_5b20033c44a4321f", #"ui_icon_general_feedback_zipline");
  zm_ping::function_5ae4a10c("p9_zm_platinum_radio_call_boxes_on", "platinum_klaus_radio_obj", #"hash_5c2213d2d79e1e90", #"hash_5b20033c44a4321f", #"hash_5f505b6863b30787");
  zm_ping::function_5ae4a10c("p9_zm_platinum_radio_call_boxes_off", "platinum_klaus_radio_obj", #"hash_5c2213d2d79e1e90", #"hash_5b20033c44a4321f", #"hash_5f505b6863b30787");
  zm_ping::function_5ae4a10c("p9_fxanim_zm_platinum_zipline_cable_mod", "platinum_rappel_cable_obj", #"hash_337db80f69d05548", undefined, #"ui_icon_general_feedback_zipline", undefined, -800);
  zm_ping::function_5ae4a10c("p9_fxanim_zm_platinum_zipline_mod", "platinum_zipline_door_obj", #"hash_50ac7af2c5bc8257", #"hash_5f3108a8ed351288", #"ui_icon_minimap_doorbuys");
  zm_ping::function_5ae4a10c("p9_fxanim_zm_platinum_rappel_mod", "platinum_rappel_door_obj", #"hash_59bd96ed40a5975e", undefined, #"ui_icon_minimap_powerdoors");
  zm_ping::function_5ae4a10c("p9_zm_platinum_collider_device_skeleton", "platinum_ur_device_obj", #"hash_73929fe92df91172", #"hash_5b20033c44a4321f", #"hash_e7905885b49ce78", 0, 0);
  clientfield::register_clientuimodel("player_lives", #"zm_hud", #"player_lives", 1, 2, "int", undefined, 0, 0);
  clientfield::register("toplayer", "" + # "pstfx_sprite_rain_loop", 24000, 1, "int", &pstfx_sprite_rain_loop, 0, 0);
  clientfield::register("toplayer", "" + # "hash_3c8a07f3b4eaf129", 1, 1, "int", &function_184a5cfd, 0, 0);
  clientfield::register("toplayer", "" + # "music_underscore", 1, 2, "int", &namespace_99d0d95e::function_2f3017ad, 0, 0);
  clientfield::register("world", "" + # "hash_7d7dcebcb0511b14", 1, 1, "int", &function_84e68eed, 0, 0);
  clientfield::register("toplayer", "" + # "hash_6e5cc4162abd613f", 24000, 1, "int", &function_7c8f93fb, 0, 0);
  clientfield::register("actor", "" + # "hash_15e37ba2a31217b8", 24000, 1, "int", &function_fb022f13, 0, 0);
  clientfield::register("world", "" + # "hash_228f0acdd4255cb", 24000, 1, "int", &function_42400110, 0, 0);
  clientfield::register("world", "" + # "hash_3a84ac42abd608d2", 24000, 1, "int", &function_37097923, 0, 0);
  clientfield::register("actor", "" + # "hash_3e4641a9ea00d061", 24000, 1, "int", &function_eff937db, 0, 0);
  clientfield::register("world", "" + # "hash_600dd9c10bd3447b", 24000, 2, "int", &function_24c94faf, 0, 0);
  clientfield::register("actor", "" + # "hash_703543ca871a0f75", 24000, 2, "int", &function_da37c6e9, 0, 0);
  clientfield::register("world", "" + # "hash_2a93d12c263f2d68", 24000, getminbitcountfornum(7), "int", &namespace_99d0d95e::function_ec54a907, 0, 0);
  clientfield::register("scriptmover", "" + # "klaus_radio_obj", 1, 1, "int", &klaus_radio_obj, 0, 0);
  clientfield::register("toplayer", "" + # "hash_46bbaae5eb8a7080", 24000, 1, "int", &function_1b724bbd, 0, 0);
  clientfield::register("world", "" + # "hash_2971ea22ea5a646a", 1, 3, "int", &function_36b5330c, 0, 0);
  clientfield::register("world", "" + # "hash_6eb96d2ad043aa56", 1, 1, "int", &function_927a773e, 0, 0);
  clientfield::register("world", "" + # "hash_7b3ada6e5b1cf81e", 1, 1, "int", &function_167fc35, 0, 0);
  clientfield::register("world", "" + # "hash_56c7e620d1de163a", 1, 1, "counter", &function_33082eb4, 0, 0);
  clientfield::register("toplayer", "fogofwareffects", 1, getminbitcountfornum(2), "int", undefined, 0, 1);
  clientfield::register("vehicle", "" + # "hash_315d8062badb2345", 24000, getminbitcountfornum(2), "int", &function_d563caa1, 0, 0);
  clientfield::register("allplayers", "" + # "hash_1fb207d10fbe27ce", 24000, 1, "int", &function_51ee271b, 0, 0);
  clientfield::register("allplayers", "" + # "hash_73227fdae7d9bc0e", 28000, 2, "int", &function_1a91c8d3, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
  util::register_system(#"platmusunlock", &function_20daf01);
  level.setupcustomcharacterexerts = &setup_personality_character_exerts;
  level.var_d0ab70a2 = # "hash_499ec58230cbe8b6";
  level.var_59815895 = 1600;
  level.var_49ba13b2 = 3100;
  level.var_40753b66 = 0;
  level.var_674a073f = 0.85;
  level.var_6663d08b = 1;
  setDvar(#"hash_64d8f355a9e6daa5", 1);
  setDvar(#"hash_b3395a8d3abf84a", 1);
  setDvar(#"hash_75a2e23bc66a08a7", 0);
  setDvar(#"hash_2d56e13848a82d14", 0);
  setDvar(#"hash_384191a42356d34", 1);
  setDvar(#"hash_5e3c0f05d2935beb", 1);
  zm_intel::function_88645994(#"hash_4eeb1c7447479151", #"hash_5efbc7b901eeb16c", undefined, undefined, #"hash_62c9a6dffc5a51c2");
  load::main();
  namespace_958b287a::init();
  namespace_b574e135::init();
  namespace_178eb32b::init();
  zm_platinum_ww_quest::init();
  zm_platinum_main_quest::init();
  namespace_4e8d47b1::init();
  namespace_7a518726::init();
  namespace_54685ebd::init();
  namespace_99d0d95e::init();
  zm_platinum_pap_quest::init();
  util::waitforclient(0);
  setsoundcontext("dark_aether", "inactive");
  namespace_b574e135::function_dcf22669();
  animation::add_notetrack_func("klausLeaveAudio", &function_8ba39ad0);
  level.var_bb1f7e1e.var_19f55f0 = # "hash_1501143ad2865b6e";
}

function setup_personality_character_exerts() {
  level.exert_sounds[1][# "playerbreathinsound"] = "vox_plr_1_exert_sniper_hold";
  level.exert_sounds[2][# "playerbreathinsound"] = "vox_plr_2_exert_sniper_hold";
  level.exert_sounds[3][# "playerbreathinsound"] = "vox_plr_3_exert_sniper_hold";
  level.exert_sounds[4][# "playerbreathinsound"] = "vox_plr_4_exert_sniper_hold";
  level.exert_sounds[1][# "playerbreathoutsound"] = "vox_plr_1_exert_sniper_exhale";
  level.exert_sounds[2][# "playerbreathoutsound"] = "vox_plr_2_exert_sniper_exhale";
  level.exert_sounds[3][# "playerbreathoutsound"] = "vox_plr_3_exert_sniper_exhale";
  level.exert_sounds[4][# "playerbreathoutsound"] = "vox_plr_4_exert_sniper_exhale";
  level.exert_sounds[1][# "playerbreathgaspsound"] = "vox_plr_1_exert_sniper_gasp";
  level.exert_sounds[2][# "playerbreathgaspsound"] = "vox_plr_2_exert_sniper_gasp";
  level.exert_sounds[3][# "playerbreathgaspsound"] = "vox_plr_3_exert_sniper_gasp";
  level.exert_sounds[4][# "playerbreathgaspsound"] = "vox_plr_4_exert_sniper_gasp";
  level.exert_sounds[1][# "meleeswipesoundplayer"] = "vox_plr_1_exert_punch_give";
  level.exert_sounds[2][# "meleeswipesoundplayer"] = "vox_plr_2_exert_punch_give";
  level.exert_sounds[3][# "meleeswipesoundplayer"] = "vox_plr_3_exert_punch_give";
  level.exert_sounds[4][# "meleeswipesoundplayer"] = "vox_plr_4_exert_punch_give";
}

function function_51ee271b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(self == function_5c10bd79(fieldname)) {
    if(bwasdemojump) {
      util::function_8eb5d4b0(1600, 0);
      return;
    }

    util::function_8eb5d4b0(3100, 0.85);
  }
}

function pstfx_sprite_rain_loop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwasdemojump) {
    if(self postfx::function_556665f2(#"pstfx_sprite_rain_loop")) {
      self postfx::stoppostfxbundle(#"pstfx_sprite_rain_loop");
      self notify(#"hash_31ca7d9fa1b055e0");
    }

    self postfx::playpostfxbundle(#"pstfx_sprite_rain_loop");
    var_3f79908d = playtagfxset(fieldname, "fx9_stakeout_screen_drop_distort", self);
    self thread function_f524c7a5(fieldname, var_3f79908d);
    return;
  }

  self postfx::exitpostfxbundle(#"pstfx_sprite_rain_loop");
  self notify(#"hash_31ca7d9fa1b055e0");
}

function function_f524c7a5(localclientnum, var_3f79908d) {
  self notify("5060c58526bc721c");
  self endon("5060c58526bc721c");
  self waittill(#"death", #"hash_31ca7d9fa1b055e0");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function function_184a5cfd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_f58e42ae(fieldname, 1);
    return;
  }

  function_f58e42ae(fieldname, 0);
}

function function_84e68eed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_30b095e = getent(fieldname, "phase_wall_01", "targetname");
  var_de143f71 = getent(fieldname, "phase_wall_02", "targetname");
  var_2b25faad = getEntArray(fieldname, "phase_wall_03", "targetname");

  if(bwastimejump) {
    var_30b095e playrenderoverridebundle(#"hash_2dfe51d749f2c11f");
    var_30b095e function_78233d29(#"hash_2dfe51d749f2c11f", "", "Scale", 1);
    var_de143f71 playrenderoverridebundle(#"hash_3457ea7a9eeaa055");
    var_de143f71 function_78233d29(#"hash_3457ea7a9eeaa055", "", "Scale", 1);

    foreach(phase_wall in var_2b25faad) {
      phase_wall playrenderoverridebundle(#"hash_2dfe51d749f2c11f");
      phase_wall function_78233d29(#"hash_2dfe51d749f2c11f", "", "Scale", 1);
    }

    return;
  }

  var_30b095e stoprenderoverridebundle(#"hash_2dfe51d749f2c11f");
  var_de143f71 stoprenderoverridebundle(#"hash_3457ea7a9eeaa055");

  foreach(phase_wall in var_2b25faad) {
    phase_wall stoprenderoverridebundle(#"hash_2dfe51d749f2c11f");
  }
}

function function_36b5330c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_8cbaf960 = struct::get_array("pl_zipline_arm");

  switch (bwasdemojump) {
    case 1:
      foreach(var_bb21be70 in var_8cbaf960) {
        var_bb21be70.var_cc1c5020 = util::spawn_model(fieldname, var_bb21be70.model, var_bb21be70.origin, var_bb21be70.angles);
      }

      break;
    case 2:
      foreach(var_bb21be70 in var_8cbaf960) {
        if(var_bb21be70.script_noteworthy === "rooftop") {
          if(!isDefined(var_bb21be70.var_cc1c5020)) {
            var_bb21be70.var_cc1c5020 = util::spawn_model(fieldname, var_bb21be70.model, var_bb21be70.origin, var_bb21be70.angles);
          }

          var_bb21be70.var_cc1c5020.var_fc558e74 = "platinum_zipline_obj";
          var_bb21be70.var_cc1c5020 function_619a5c20();
        }
      }

      break;
    case 3:
      foreach(var_bb21be70 in var_8cbaf960) {
        if(var_bb21be70.script_noteworthy === "hotel") {
          if(!isDefined(var_bb21be70.var_cc1c5020)) {
            var_bb21be70.var_cc1c5020 = util::spawn_model(fieldname, var_bb21be70.model, var_bb21be70.origin, var_bb21be70.angles);
          }

          var_bb21be70.var_cc1c5020.var_fc558e74 = "platinum_zipline_obj";
          var_bb21be70.var_cc1c5020 function_619a5c20();
        }
      }

      break;
    case 4:
      foreach(var_bb21be70 in var_8cbaf960) {
        if(var_bb21be70.script_noteworthy === "korber") {
          if(!isDefined(var_bb21be70.var_cc1c5020)) {
            var_bb21be70.var_cc1c5020 = util::spawn_model(fieldname, var_bb21be70.model, var_bb21be70.origin, var_bb21be70.angles);
          }

          var_bb21be70.var_cc1c5020.var_fc558e74 = "platinum_zipline_obj";
          var_bb21be70.var_cc1c5020 function_619a5c20();
        }
      }

      break;
    case 0:
      foreach(var_bb21be70 in var_8cbaf960) {
        if(var_bb21be70.script_noteworthy === "westberlin") {
          if(!isDefined(var_bb21be70.var_cc1c5020)) {
            var_bb21be70.var_cc1c5020 = util::spawn_model(fieldname, var_bb21be70.model, var_bb21be70.origin, var_bb21be70.angles);
          }

          var_bb21be70.var_cc1c5020.var_fc558e74 = "platinum_zipline_obj";
          var_bb21be70.var_cc1c5020 function_619a5c20();
          continue;
        }

        if(!isDefined(var_bb21be70.script_noteworthy)) {
          if(!isDefined(var_bb21be70.var_cc1c5020)) {
            var_bb21be70.var_cc1c5020 = util::spawn_model(fieldname, var_bb21be70.model, var_bb21be70.origin, var_bb21be70.angles);
          }

          var_bb21be70.var_cc1c5020.var_fc558e74 = "platinum_rappel_obj";
          var_bb21be70.var_cc1c5020 function_619a5c20();
        }
      }

      break;
  }
}

function klaus_radio_obj(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    self zm_utility::set_compass_icon(fieldname, 0, 1, 0, 0, undefined, 0);
    return;
  }

  self zm_utility::set_compass_icon(fieldname, 1, 0, 0, 0, undefined, 0);
}

function function_7c8f93fb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self postfx::playpostfxbundle(#"hash_1369517be3984a32");
    return;
  }

  self postfx::stoppostfxbundle(#"hash_1369517be3984a32");
}

function function_fb022f13(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("18ccbe7546f38741");
  self endon("18ccbe7546f38741");

  if(!isalive(self)) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(bwastimejump);
  self.is_on_fire = 1;
  fire_tag = "j_spinelower";

  if(!isDefined(self gettagorigin(fire_tag))) {
    fire_tag = "tag_origin";
  }

  util::playFXOnTag(bwastimejump, #"hash_1b72309df6d1e6a0", self, fire_tag);
  wait 1;
  tagarray = [];
  tagarray[0] = "J_Elbow_LE";
  tagarray[1] = "J_Elbow_RI";
  tagarray[2] = "J_Knee_RI";
  tagarray[3] = "J_Knee_LE";
  tagarray = array::randomize(tagarray);
  util::playFXOnTag(bwastimejump, #"hash_17be30621c722c85", self, tagarray[0]);
  wait 1;
  tagarray[0] = "J_Wrist_RI";
  tagarray[1] = "J_Wrist_LE";

  if(!is_true(self.missinglegs)) {
    tagarray[2] = "J_Ankle_RI";
    tagarray[3] = "J_Ankle_LE";
  }

  tagarray = array::randomize(tagarray);
  util::playFXOnTag(bwastimejump, #"hash_17be30621c722c85", self, tagarray[0]);
  util::playFXOnTag(bwastimejump, #"hash_17be30621c722c85", self, tagarray[1]);
}

function function_42400110(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    e_player = function_5c10bd79(fieldname);
    e_player thread function_33593a44(fieldname, 1, 2);
    return;
  }

  e_player = function_5c10bd79(fieldname);
  e_player thread function_33593a44(fieldname, 2, 1);
}

function function_37097923(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(level.var_9b14fb5c)) {
    level.var_9b14fb5c = [];
  } else if(!isarray(level.var_9b14fb5c)) {
    level.var_9b14fb5c = array(level.var_9b14fb5c);
  }

  if(bwasdemojump == 1) {
    var_194f1b3f = struct::get_array("falling_dust_loc", "targetname");

    foreach(loc in var_194f1b3f) {
      fx = playFX(fieldname, #"hash_180b445d83add766", loc.origin);

      if(!isDefined(level.var_9b14fb5c)) {
        level.var_9b14fb5c = [];
      } else if(!isarray(level.var_9b14fb5c)) {
        level.var_9b14fb5c = array(level.var_9b14fb5c);
      }

      level.var_9b14fb5c[level.var_9b14fb5c.size] = fx;
    }

    return;
  }

  foreach(fx in level.var_9b14fb5c) {
    if(isDefined(fx)) {
      stopfx(fieldname, fx);
      arrayremovevalue(level.var_9b14fb5c, fx);
    }
  }

  level.var_9b14fb5c = [];
}

function function_24c94faf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    var_27fa6f1c = struct::get("ghost_train_trash_fx_pos_south", "targetname");
    level.var_f7cc40a3 = playFX(fieldname, #"hash_6168181302e095c5", var_27fa6f1c.origin);
    return;
  }

  if(bwasdemojump == 2) {
    var_447ca555 = struct::get("ghost_train_trash_fx_pos_north", "targetname");
    level.var_45f6f59b = playFX(fieldname, #"hash_53943959c5d3bbbd", var_447ca555.origin);
    return;
  }

  if(isDefined(level.var_f7cc40a3)) {
    stopfx(fieldname, level.var_f7cc40a3);
  }

  if(isDefined(level.var_45f6f59b)) {
    stopfx(fieldname, level.var_45f6f59b);
  }
}

function private function_33593a44(localclientnum, var_312d65d1, var_68f7ce2e, n_time = 3) {
  self notify("5111286a5e237a6c");
  self endon("5111286a5e237a6c");
  n_blend = 0;
  n_increment = 1 / n_time / 0.05;

  if(var_312d65d1 == 1 && var_68f7ce2e == 2) {
    while(n_blend < 1) {
      function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, 1 - n_blend, n_blend, 0, 0);
      n_blend += n_increment;
      wait 0.05;
    }

    return;
  }

  if(var_312d65d1 == 2 && var_68f7ce2e == 1) {
    while(n_blend < 1) {
      function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, n_blend, 1 - n_blend, 0, 0);
      n_blend += n_increment;
      wait 0.05;
    }
  }
}

function function_eff937db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self function_c2e69953(1);
    return;
  }

  self function_c2e69953(0);
}

function function_da37c6e9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    if(bwastimejump == 1) {
      if(!isDefined(self.var_491e4e07)) {
        self.var_491e4e07 = util::playFXOnTag(fieldname, #"hash_46180986e919ffce", self, "eye_fire_le_fx");
      }

      if(!isDefined(self.var_2efd19f9)) {
        self.var_2efd19f9 = util::playFXOnTag(fieldname, #"hash_46180986e919ffce", self, "eye_fire_ri_fx");
      }

      if(self.aitype == "spawner_zm_mannequin_ally_upgraded_03") {
        self stoprenderoverridebundle("rob_klaus_quiet");
        self stoprenderoverridebundle("rob_klaus_talking_punk");
      } else {
        self playrenderoverridebundle("rob_zmb_klaus_eyes_red");
        self playrenderoverridebundle("rob_klaus_quiet");
        self stoprenderoverridebundle("rob_klaus_talking");
      }

      return;
    }

    if(bwastimejump == 2) {
      self stoprenderoverridebundle("rob_klaus_quiet");

      if(self.aitype == "spawner_zm_mannequin_ally_upgraded_03") {
        self playrenderoverridebundle("rob_klaus_talking_punk");
      } else {
        self playrenderoverridebundle("rob_klaus_talking");
      }

      return;
    }

    self stoprenderoverridebundle("rob_zmb_klaus_eyes_red");
    self stoprenderoverridebundle("rob_klaus_quiet");
    self stoprenderoverridebundle("rob_klaus_talking");
    self stoprenderoverridebundle("rob_klaus_talking_punk");

    if(isDefined(self.var_491e4e07)) {
      killfx(fieldname, self.var_491e4e07);
      self.var_491e4e07 = undefined;
    }

    if(isDefined(self.var_2efd19f9)) {
      killfx(fieldname, self.var_2efd19f9);
      self.var_2efd19f9 = undefined;
    }
  }
}

function function_927a773e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    function_3385d776(#"hash_6e2a5061e8edcae4");
    return;
  }

  function_c22a1ca2(#"hash_6e2a5061e8edcae4");
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
    if(e_player postfx::function_556665f2(#"hash_7fbc9bc489aea188")) {
      e_player postfx::stoppostfxbundle(#"hash_7fbc9bc489aea188");
    }

    e_player postfx::playpostfxbundle(#"hash_7fbc9bc489aea188");
    e_player playSound(bwastimejump, #"hash_56a9d9da20064c3f");
    function_5ea2c6e3("zm_silver_darkaether_leadin", 7);
  }
}

function on_localclient_connect(localclientnum) {
  level thread function_347f52dd(localclientnum);
}

function private function_347f52dd(localclientnum) {
  self notify("75f7b2f29a47cb00");
  self endon("75f7b2f29a47cb00");
  var_ef2f4cec = spawnStruct();
  var_ef2f4cec.var_e450444f = 0;

  while(true) {
    currentplayer = function_5c10bd79(localclientnum);

    if(!isDefined(currentplayer)) {
      waitframe(1);
      continue;
    }

    b_state = currentplayer clientfield::get_to_player("fogofwareffects");

    if(var_ef2f4cec.var_e450444f !== b_state) {
      var_ef2f4cec function_d45dd62(localclientnum, b_state, currentplayer);
      var_ef2f4cec.var_e450444f = b_state;
    }

    waitframe(1);
  }
}

function private function_d45dd62(localclientnum, b_state, currentplayer) {
  if(b_state == 1) {
    if(!isDefined(currentplayer.var_103fdf58)) {
      playSound(localclientnum, #"hash_7b5289d48cc02d77", (0, 0, 0));
      currentplayer.var_103fdf58 = currentplayer playLoopSound("evt_sr_phase_player_lp");
    }

    if(function_148ccc79(localclientnum, #"pstfx_electrified")) {
      codestoppostfxbundlelocal(localclientnum, #"pstfx_electrified");
    }

    if(!function_148ccc79(localclientnum, #"hash_2964f82e2c05c8b8")) {
      function_a837926b(localclientnum, #"hash_2964f82e2c05c8b8");
      self.var_7bd7bdc8 = # "hash_2964f82e2c05c8b8";
    }

    return;
  }

  if(b_state == 2) {
    if(isDefined(currentplayer.var_103fdf58)) {
      playSound(localclientnum, #"hash_37b1613c2cb4c8f3", (0, 0, 0));
      currentplayer stoploopsound(currentplayer.var_103fdf58);
      currentplayer.var_103fdf58 = undefined;
    }

    if(function_148ccc79(localclientnum, #"hash_2964f82e2c05c8b8")) {
      codestoppostfxbundlelocal(localclientnum, #"hash_2964f82e2c05c8b8");
    }

    if(!function_148ccc79(localclientnum, #"pstfx_electrified")) {
      function_a837926b(localclientnum, #"pstfx_electrified");
      self.var_7bd7bdc8 = # "pstfx_electrified";
    }

    return;
  }

  if(isDefined(currentplayer.var_103fdf58)) {
    playSound(localclientnum, #"hash_37b1613c2cb4c8f3", (0, 0, 0));
    currentplayer stoploopsound(currentplayer.var_103fdf58);
    currentplayer.var_103fdf58 = undefined;
  }

  if(isDefined(self.var_7bd7bdc8)) {
    if(function_148ccc79(localclientnum, self.var_7bd7bdc8)) {
      function_24cd4cfb(localclientnum, self.var_7bd7bdc8);
    }

    self.var_7bd7bdc8 = undefined;
  }
}

function function_8ba39ad0(params) {
  if(isDefined(self)) {
    playSound(0, #"hash_33e836ad83f1c0af", self.origin);
  }
}

function function_d563caa1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    playtagfxset(fieldname, #"hash_731f457f0cf968ab", self);
    return;
  }

  if(bwastimejump == 2) {
    self setanim("v_cin_t9_zm_berlin_exfil_heli");
  }
}

function function_20daf01(localclientnum, state, oldstate) {
  if(!isDefined(oldstate)) {
    return;
  }

  var_8c7054cc = undefined;

  switch (oldstate) {
    case # "unlockdia1":
      var_8c7054cc = # "musictrack_zm_platinum_berlin";
      break;
    case # "unlocksqueak":
      var_8c7054cc = # "musictrack_zm_platinum_acidbunny";
      break;
    case # "unlockdia2":
      var_8c7054cc = # "musictrack_zm_platinum_whatawaits";
      break;
    case # "unlockshatter":
      var_8c7054cc = # "musictrack_zm_platinum_wrath";
      break;
  }

  if(isDefined(var_8c7054cc)) {
    function_2cca7b47(state, var_8c7054cc);
  }
}

function function_1b724bbd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self)) {
    if(bwasdemojump) {
      forcestreamxmodel(#"p7_zm_der_pswitch_handle");
      return;
    }

    stopforcestreamingxmodel(#"p7_zm_der_pswitch_handle");
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