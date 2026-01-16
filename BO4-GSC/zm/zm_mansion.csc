/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion.csc
***********************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm\ai\zm_ai_bat;
#include scripts\zm\weapons\zm_weap_random_ray_gun;
#include scripts\zm\weapons\zm_weap_riotshield;
#include scripts\zm\zm_mansion_a_skeet_fink;
#include scripts\zm\zm_mansion_boss_ww;
#include scripts\zm\zm_mansion_impaler;
#include scripts\zm\zm_mansion_jordans;
#include scripts\zm\zm_mansion_ley_line;
#include scripts\zm\zm_mansion_pap_quest;
#include scripts\zm\zm_mansion_silver_bullet;
#include scripts\zm\zm_mansion_sound;
#include scripts\zm\zm_mansion_stick_man;
#include scripts\zm\zm_mansion_storage;
#include scripts\zm\zm_mansion_traps_firegates;
#include scripts\zm\zm_mansion_triad;
#include scripts\zm\zm_mansion_ww_lvl3_quest;
#include scripts\zm\zm_trap_electric;
#include scripts\zm_common\load;
#include scripts\zm_common\util\ai_dog_util;
#include scripts\zm_common\zm_audio_sq;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_fasttravel;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_mansion;

autoexec opt_in() {
  level.aat_in_use = 1;
  level.bgb_in_use = 1;
}

event_handler[level_init] main(eventstruct) {
  clientfield::register("clientuimodel", "player_lives", 8000, 2, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmhud.ammoModifierActive", 8000, 1, "int", undefined, 0, 0);
  clientfield::register("world", "" + #"hash_42e03f9ae74a1070", 8000, 1, "int", &function_64968a3c, 0, 0);
  clientfield::register("vehicle", "" + #"hash_602ae5683c010563", 8000, 1, "int", &function_94cf8d37, 0, 0);
  clientfield::register("vehicle", "" + #"hash_4bd91c5285da0899", 8000, 1, "counter", &function_cb417790, 0, 0);
  clientfield::register("scriptmover", "" + #"soul_fx", 8000, 1, "int", &mansion_pap::soul_release, 0, 0);
  clientfield::register("scriptmover", "" + #"stone_pickup", 8000, 1, "int", &function_39b69f3f, 0, 0);
  clientfield::register("actor", "" + #"clock_zombie", 8000, 1, "int", &clock_zombie_fx, 0, 0);
  clientfield::register("actor", "" + #"wisp_kill", 8000, 1, "int", &function_8048af7e, 0, 0);
  clientfield::register("scriptmover", "" + #"blocker_fx", 8000, 1, "int", &function_328d64bd, 0, 0);
  clientfield::register("item", "" + #"ww_pickup_part", 8000, 1, "int", &function_d86e0cb2, 0, 0);
  clientfield::register("item", "" + #"hash_35ce4034ca7e543c", 8000, 3, "int", &function_46bf4199, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_487e544e29aa8e45", 8000, 1, "int", &function_97aef6ef, 0, 0);
  clientfield::register("scriptmover", "" + #"activate_mansion_artifact", 8000, getminbitcountfornum(3), "int", &function_be42dd6a, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_44ee99a6591fe600", 8000, 1, "int", &function_9e061782, 0, 0);
  clientfield::register("toplayer", "" + #"hash_6a4f537da00ae3f9", 8000, 1, "int", &function_dba1f701, 0, 0);
  clientfield::register("world", "" + #"hash_7fcdc47572bdbafa", 8000, 1, "int", &function_ce859d3a, 0, 0);
  clientfield::register("scriptmover", "" + #"force_stream_model", 8000, 1, "int", &force_stream_model, 0, 0);
  clientfield::register("world", "" + #"hash_458d10e70473adfd", 8000, 1, "int", &function_8f06f775, 0, 0);
  level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
  level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
  level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
  level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
  level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
  level._effect[#"power_on_projectile"] = #"hash_6009053e911b946a";
  level._effect[#"hash_50da8a1de7ce18da"] = #"hash_6c0eb029adb5f6c6";
  level._effect[#"clock_zombie"] = #"hash_52239162cbb1d01f";
  level._effect[#"clock_zombie_le"] = #"hash_5a3bedd0f4e1fb20";
  level._effect[#"clock_zombie_ri"] = #"hash_5a7915d0f515ed36";
  level._effect[#"clock_zombie_eye"] = #"hash_482a9c9681f3db75";
  level._effect[#"wisp_impact"] = #"zm_weapons/fx8_equip_mltv_fire_human_torso_loop_zm";
  level._effect[#"stone_pickup"] = #"zombie/fx8_wallbuy_reveal";
  level._effect[#"zone_lockdown"] = #"hash_425c28d5fded81f2";
  level._effect[#"hash_1a4566b6595544b4"] = #"hash_5b773dbbac0012ff";
  level._effect[#"hash_1a46c58a5032bb15"] = #"zombie/fx_ritual_barrier_defend_door_wide_zod_zmb";
  level._effect[#"ww_pickup"] = #"hash_4b275679ef930b50";
  level._effect[#"hash_3e78192d5d719b68"] = #"hash_13ca5cb4f81f0469";
  level._effect[#"hash_6f8a5a3faaac0b2d"] = #"hash_531e5c5efe735df0";
  level._effect[#"hash_6e809770685a03ce"] = #"hash_57e793068bee3c8e";
  level._effect[#"hash_5b93caeacd0dbde4"] = #"hash_37a3c4156a246da4";
  level._effect[#"power_on_projectile"] = #"hash_6009053e911b946a";
  level._effect[#"hash_50da8a1de7ce18da"] = #"hash_6c0eb029adb5f6c6";
  level._effect[#"hash_55cc40c5ca8b259d"] = #"zombie/fx_ritual_sacrafice_glow_head_zod_zmb";
  level._effect[#"hash_679e221c06d83988"] = #"hash_3c61e7e3069ee8a7";
  level._effect[#"hash_85d57de38b76cc7"] = #"hash_10efddc69fbb6a0e";
  level._effect[#"hash_2568ad8792cec77f"] = #"hash_6596b5a56f027114";
  level._effect[#"hash_23cfdebb55c60d4f"] = #"hash_451dfa68b22333f2";
  level._effect[#"hash_5843ac84cb4761c0"] = #"hash_18ce7dc1f160283f";
  level._effect[#"hash_4f8200ee1c323836"] = #"hash_7f1680c009106243";
  level._effect[#"hash_5845fe8edb36108b"] = #"hash_674095d927cfe7cc";
  level._effect[#"hash_8f58d28b0b40b2d"] = #"hash_18d057b947ae0c00";
  level._effect[#"hash_36f6dd55e72db9a6"] = #"hash_59dbd1f9476a0415";
  level._effect[#"hash_487e544e29aa8e45"] = #"hash_7ad8856e251bee77";
  level._effect[#"artifact_aura"] = #"hash_3def678deb7f4078";
  level._effect[#"artifact_activate"] = #"hash_464f27bfbf0ce7bf";
  level._effect[#"artifact_glow"] = #"hash_41b2c270f26faabc";
  level._effect[#"hash_6b03597da0a3c2ae"] = #"hash_43b3118edb88df8c";
  level._uses_default_wallbuy_fx = 1;
  level._uses_sticky_grenades = 1;
  level._uses_taser_knuckles = 1;
  level.var_d0ab70a2 = #"gamedata/weapons/zm/zm_mansion_weapons.csv";
  namespace_a8113e97::init_clientfields();
  namespace_b6ca3ccc::init_clientfields();
  mansion_triad::init_clientfields();
  mansion_impaler::init_clientfields();
  mansion_storage::init();
  mansion_pap::init_fx();
  mansion_pap::init_clientfields();
  mansion_ww_lvl3_quest::init();
  mansion_silver_bullet::init();
  mansion_a_skeet_fink::init();
  mansion_jordans::init();
  zm_audio_sq::init();
  ai::add_archetype_spawn_function(#"zombie_dog", &zombie_dog_spawned);
  load::main();
  util::waitforclient(0);
  zm_mansion_sound::main();
  setdvar(#"hash_6d05981efd5d8d74", 400);
}

force_stream_model(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    forcestreamxmodel(self.model);
    return;
  }

  stopforcestreamingxmodel(self.model);
}

function_8f06f775(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    forcestreammaterial("t8_dirt_rocky_03_dark_rvl");
    return;
  }

  stopforcestreamingmaterial("t8_dirt_rocky_03_dark_rvl");
}

function_ce859d3a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_a5777754(localclientnum, "visgroup_mov");
}

zombie_dog_spawned(localclientnum) {
  self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_red", #"zm_ai/fx8_zombie_eye_glow_red");
  self callback::on_shutdown(&on_entity_shutdown);
}

on_entity_shutdown(localclientnum) {
  if(isDefined(self)) {
    self zm_utility::good_barricade_damaged(localclientnum);
  }
}

function_64968a3c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newval == 1) {
    e_player = getlocalplayers()[localclientnum];
    e_player postfx::playpostfxbundle(#"hash_1d8a81ef0f5306db");
    e_player thread function_33593a44(localclientnum, 1, 2);
    return;
  }

  e_player = getlocalplayers()[localclientnum];
  e_player postfx::stoppostfxbundle(#"hash_1d8a81ef0f5306db");
  e_player thread function_33593a44(localclientnum, 2, 1);
}

private function_33593a44(localclientnum, var_312d65d1, var_68f7ce2e, n_time = 3) {
  self notify("6e700fd90329871b");
  self endon("6e700fd90329871b");
  n_blend = 0;
  n_increment = 1 / n_time / 0.016;

  if(var_312d65d1 == 1 && var_68f7ce2e == 2) {
    while(n_blend < 1) {
      function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, 1 - n_blend, n_blend, 0, 0);
      n_blend += n_increment;
      waitframe(1);
    }

    return;
  }

  if(var_312d65d1 == 2 && var_68f7ce2e == 1) {
    while(n_blend < 1) {
      function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, n_blend, 1 - n_blend, 0, 0);
      n_blend += n_increment;
      waitframe(1);
    }
  }
}

function_8f945669(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"zone_lockdown"], self, "tag_origin");
}

function_94cf8d37(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(!isDefined(self.var_4b7a5b1b)) {
      self.var_4b7a5b1b = util::playFXOnTag(localclientnum, level._effect[#"power_on_projectile"], self, "tag_origin");
    }

    if(!isDefined(self.var_353ff2a)) {
      self.var_353ff2a = self playLoopSound(#"hash_2ac2bbbfef2face4");
    }

    return;
  }

  if(newval == 0) {
    if(isDefined(self.var_4b7a5b1b)) {
      stopfx(localclientnum, self.var_4b7a5b1b);
    }

    if(isDefined(self.var_353ff2a)) {
      self stoploopsound(self.var_353ff2a);
    }
  }
}

function_cb417790(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_50da8a1de7ce18da"], self, "tag_origin");
    playSound(localclientnum, #"hash_6da145d367ec64b2", self.origin);
  }
}

function_39b69f3f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"stone_pickup"], self, "tag_origin");
  }
}

clock_zombie_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self zm_utility::good_barricade_damaged(localclientnum);
  self.var_36d3ad0b = [];
  self.var_36d3ad0b[#"clock_zombie_le"] = util::playFXOnTag(localclientnum, level._effect[#"clock_zombie_le"], self, "j_ball_le");
  self.var_36d3ad0b[#"clock_zombie_ri"] = util::playFXOnTag(localclientnum, level._effect[#"clock_zombie_ri"], self, "j_ball_ri");
  self.var_36d3ad0b[#"clock_zombie_eye"] = util::playFXOnTag(localclientnum, level._effect[#"clock_zombie_eye"], self, "tag_eye");
  gibclientutils::addgibcallback(localclientnum, self, 8, &function_739703b0);
  gibclientutils::addgibcallback(localclientnum, self, 128, &function_739703b0);
  gibclientutils::addgibcallback(localclientnum, self, 256, &function_739703b0);
  self waittill(#"death");

  if(!isDefined(self)) {
    return;
  }

  foreach(i, fx_clock in self.var_36d3ad0b) {
    stopfx(localclientnum, fx_clock);
    self.var_36d3ad0b[i] = undefined;
  }
}

function_739703b0(localclientnum, entity, gibflag) {
  switch (gibflag) {
    case 8:
      str_fx = "clock_zombie_eye";
      break;
    case 128:
      str_fx = "clock_zombie_ri";
      break;
    case 256:
      str_fx = "clock_zombie_le";
      break;
    default:
      return;
  }

  if(isint(self.var_36d3ad0b[str_fx])) {
    stopfx(localclientnum, self.var_36d3ad0b[str_fx]);
    self.var_36d3ad0b[str_fx] = undefined;
  }
}

function_8048af7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!isarray(self.var_d2ec7fbb)) {
      self.var_d2ec7fbb = [];

      if(!isDefined(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = [];
      } else if(!isarray(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = array(self.var_d2ec7fbb);
      }

      self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playFXOnTag(localclientnum, level._effect[#"hash_679e221c06d83988"], self, "j_spine4");

      if(!isDefined(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = [];
      } else if(!isarray(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = array(self.var_d2ec7fbb);
      }

      self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playFXOnTag(localclientnum, level._effect[#"hash_85d57de38b76cc7"], self, "j_head");

      if(!isDefined(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = [];
      } else if(!isarray(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = array(self.var_d2ec7fbb);
      }

      self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playFXOnTag(localclientnum, level._effect[#"hash_2568ad8792cec77f"], self, "j_spinelower");

      if(!isDefined(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = [];
      } else if(!isarray(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = array(self.var_d2ec7fbb);
      }

      self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playFXOnTag(localclientnum, level._effect[#"hash_23cfdebb55c60d4f"], self, "j_shoulder_le");

      if(!isDefined(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = [];
      } else if(!isarray(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = array(self.var_d2ec7fbb);
      }

      self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playFXOnTag(localclientnum, level._effect[#"hash_5843ac84cb4761c0"], self, "j_shoulder_ri");

      if(!isDefined(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = [];
      } else if(!isarray(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = array(self.var_d2ec7fbb);
      }

      self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playFXOnTag(localclientnum, level._effect[#"hash_4f8200ee1c323836"], self, "j_hip_le");

      if(!isDefined(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = [];
      } else if(!isarray(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = array(self.var_d2ec7fbb);
      }

      self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playFXOnTag(localclientnum, level._effect[#"hash_5845fe8edb36108b"], self, "j_hip_ri");

      if(!isDefined(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = [];
      } else if(!isarray(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = array(self.var_d2ec7fbb);
      }

      self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playFXOnTag(localclientnum, level._effect[#"hash_8f58d28b0b40b2d"], self, "j_knee_le");

      if(!isDefined(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = [];
      } else if(!isarray(self.var_d2ec7fbb)) {
        self.var_d2ec7fbb = array(self.var_d2ec7fbb);
      }

      self.var_d2ec7fbb[self.var_d2ec7fbb.size] = util::playFXOnTag(localclientnum, level._effect[#"hash_36f6dd55e72db9a6"], self, "j_knee_ri");
    }

    return;
  }

  if(isarray(self.var_d2ec7fbb)) {
    foreach(fx in self.var_d2ec7fbb) {
      stopfx(localclientnum, fx);
    }

    self.var_d2ec7fbb = undefined;
  }
}

function_328d64bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    v_forward = anglesToForward(self.angles);
    self.blocker_fx = playFX(localclientnum, level._effect[#"hash_1a4566b6595544b4"], self.origin, v_forward);
    a_trace = bulletTrace(self.origin, self.origin - (0, 0, 512), 0, self);
    self.var_3fc27ef3 = playFX(localclientnum, level._effect[#"hash_1a46c58a5032bb15"], a_trace[#"position"], v_forward);

    if(!isDefined(self.var_99a9007b)) {
      self playSound(localclientnum, #"hash_2c71df73b17cd28a");
      self.var_99a9007b = self playLoopSound(#"hash_7e4a7312ab58161e");
    }

    return;
  }

  if(isDefined(self.blocker_fx)) {
    stopfx(localclientnum, self.blocker_fx);
  }

  if(isDefined(self.var_3fc27ef3)) {
    stopfx(localclientnum, self.var_3fc27ef3);
  }

  if(isDefined(self.var_99a9007b)) {
    self playSound(localclientnum, #"hash_3366b1b903dc96bf");
    self stoploopsound(self.var_99a9007b);
    self.var_99a9007b = undefined;
  }
}

function_d86e0cb2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!isDefined(self.fx_ww_pickup)) {
      self.fx_ww_pickup = util::playFXOnTag(localclientnum, level._effect[#"ww_pickup"], self, "tag_origin");
    }

    return;
  }

  if(isDefined(self.fx_ww_pickup)) {
    stopfx(localclientnum, self.fx_ww_pickup);
    self.fx_ww_pickup = undefined;
  }
}

function_46bf4199(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_4dccfdf6)) {
    stopfx(localclientnum, self.var_4dccfdf6);
    self.var_4dccfdf6 = undefined;
  }

  if(newval) {
    switch (newval) {
      case 1:
        str_fx = level._effect[#"hash_3e78192d5d719b68"];
        break;
      case 2:
        str_fx = level._effect[#"hash_6f8a5a3faaac0b2d"];
        break;
      case 3:
        str_fx = level._effect[#"hash_6e809770685a03ce"];
        break;
      case 4:
        str_fx = level._effect[#"hash_5b93caeacd0dbde4"];
        break;
    }

    if(isDefined(str_fx)) {
      self.var_4dccfdf6 = util::playFXOnTag(localclientnum, str_fx, self, "tag_origin");
    }
  }
}

function_97aef6ef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_30b1857a)) {
    stopfx(localclientnum, self.var_30b1857a);
    self.var_30b1857a = undefined;
  }

  if(newval) {
    self.var_30b1857a = util::playFXOnTag(localclientnum, level._effect[#"hash_487e544e29aa8e45"], self, "tag_origin");
  }
}

function_be42dd6a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_2ea06178 = util::playFXOnTag(localclientnum, level._effect[#"artifact_aura"], self, "tag_fx_x_pos");
    self playrenderoverridebundle(#"hash_8cb3b94ffea62fe");
    self.var_b3673abf = self playLoopSound(#"hash_66df9cab2c64f968");
    return;
  }

  if(newval == 2) {
    if(isDefined(self.var_b3673abf)) {
      self stoploopsound(self.var_b3673abf);
    }

    if(isDefined(self.var_2ea06178)) {
      stopfx(localclientnum, self.var_2ea06178);
      self.var_2ea06178 = undefined;
    }

    util::playFXOnTag(localclientnum, level._effect[#"artifact_activate"], self, "tag_fx_x_pos");
    self stoprenderoverridebundle(#"hash_8cb3b94ffea62fe");
    return;
  }

  if(newval == 3) {
    self.var_f7a393 = util::playFXOnTag(localclientnum, level._effect[#"artifact_glow"], self, "tag_fx_x_pos");
    self playrenderoverridebundle(#"hash_4192ceb1c828492f");
    self playSound(localclientnum, #"zmb_sq_souls_release");
    return;
  }

  if(isDefined(self.var_b3673abf)) {
    self stoploopsound(self.var_b3673abf);
    self.var_b3673abf = undefined;
  }

  if(isDefined(self.var_2ea06178)) {
    stopfx(localclientnum, self.var_2ea06178);
    self.var_2ea06178 = undefined;
  }

  if(isDefined(self.var_f7a393)) {
    stopfx(localclientnum, self.var_f7a393);
    self.var_f7a393 = undefined;
  }

  self stoprenderoverridebundle(#"hash_4192ceb1c828492f");
  self playSound(localclientnum, #"hash_5de064f33e9e49b8");
}

function_9e061782(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self playrenderoverridebundle(#"hash_798166dc35b7e58");
    return;
  }

  self stoprenderoverridebundle(#"hash_798166dc35b7e58");
}

function_dba1f701(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"hash_5ca1805634bbfe66");

  if(isDefined(self.var_f89c3040)) {
    killfx(localclientnum, self.var_f89c3040);
    self.var_f89c3040 = undefined;
  }

  if(isDefined(self.var_97c36aa4)) {
    killfx(localclientnum, self.var_97c36aa4);
    self.var_97c36aa4 = undefined;
  }

  if(newval) {
    self thread function_6381f252(localclientnum);
  }
}

function_6381f252(localclientnum) {
  self endoncallback(&function_900bdca4, #"death", #"respawn", #"hash_5ca1805634bbfe66");
  self util::waittill_dobj(localclientnum);

  while(true) {
    if(zm_utility::function_f8796df3(localclientnum) && !isthirdperson(localclientnum)) {
      if(viewmodelhastag(localclientnum, "tag_flash")) {
        if(!isDefined(self.var_f89c3040)) {
          self.var_f89c3040 = playviewmodelfx(localclientnum, level._effect[#"hash_6b03597da0a3c2ae"], "tag_flash");
        }
      } else if(isDefined(self.var_f89c3040)) {
        killfx(localclientnum, self.var_f89c3040);
        self.var_f89c3040 = undefined;
      }

      if(viewmodelhastag(localclientnum, "tag_flash_le")) {
        if(!isDefined(self.var_97c36aa4)) {
          self.var_97c36aa4 = playviewmodelfx(localclientnum, level._effect[#"hash_6b03597da0a3c2ae"], "tag_flash_le");
        }
      } else if(isDefined(self.var_97c36aa4)) {
        killfx(localclientnum, self.var_97c36aa4);
        self.var_97c36aa4 = undefined;
      }
    } else {
      if(isDefined(self.var_f89c3040)) {
        killfx(localclientnum, self.var_f89c3040);
        self.var_f89c3040 = undefined;
      }

      if(isDefined(self.var_97c36aa4)) {
        killfx(localclientnum, self.var_97c36aa4);
        self.var_97c36aa4 = undefined;
      }
    }

    waitframe(1);
  }
}

function_900bdca4(var_c34665fc) {
  if(isDefined(self.var_f89c3040)) {
    killfx(self.localclientnum, self.var_f89c3040);
    self.var_f89c3040 = undefined;
  }

  if(isDefined(self.var_97c36aa4)) {
    killfx(self.localclientnum, self.var_97c36aa4);
    self.var_97c36aa4 = undefined;
  }
}