/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_nic_revolucion.gsc
***********************************************/

#using script_169397edb865e2fe;
#using script_1a8e3ed87416246f;
#using script_1e11da73f221dacf;
#using script_237e957844a8197c;
#using script_2dc23e8cdc04641;
#using script_449db013f96e63ee;
#using script_4a1a0f734d8d0e04;
#using script_4e3db13f6a3f0e22;
#using script_5991d6501121591f;
#using script_5ab2e91e565f1fae;
#using script_6b2490222adab2af;
#using script_6b6aa5011b898d9a;
#using script_72e5a112d0707eeb;
#using script_7c5d86c25e7584a4;
#using script_7e534d425ebbc173;
#using script_e4d4b4e82f6b90e;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_nic_revolucion_fx;
#using scripts\cp_common\flashback_tv;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace cp_nic_revolucion;

function event_handler[level_init] main(eventstruct) {
  setclearanceceiling(16);
  function_bf4b4b7e();
  cp_nic_revolucion_fx::preload();
  load::main();
  init_fx();
  hms_util::function_2f3616f8();
  level.disablestattracking = 1;
  level.var_cd2635a5 = 1;

  while(!isDefined(level.player)) {
    if(getplayers().size > 0) {
      level.player = getplayers()[0];
    }

    waitframe(1);
  }

  level.var_f4ed1999 = &function_d1c278ab;
  setDvar(#"compassmaxrange", "2100");
  level flag::set("no_corpse_pickup ");
  level.var_3ff1b984[getweapon(#"ac130")] = 1;
  callback::on_spawned(&function_47b8b88);
  function_303d4f();

  level thread hms_util::function_32397759();
  level thread hms_util::function_5056f90d();
}

function init_fx() {
  level._effect[#"hash_b63f0232a3d5f82"] = # "hash_3b2dcab0e76aeb7c";
  level._effect[#"hash_6137c6e5c6df6502"] = # "hash_65be3ccb65aba68f";
  level._effect[#"hash_70902b0842168222"] = # "hash_72c752412f511f36";
  level._effect[#"hash_5b324a25a646d3be"] = # "hash_48ba62945045cb4e";
  level._effect[#"hash_5334c84fbd555272"] = # "hash_7e60569db9c36606";
  level._effect[#"hash_2da85b06a03a2ba"] = # "hash_26689c1b99e901a";
  level._effect[#"hash_7527861319d5e820"] = # "hash_48ce1b00618cebdd";
  level._effect[#"hash_711a6d544750ccfb"] = # "hash_735d87613c054cac";
}

function function_47b8b88() {
  self setactionslot(4, "");
  self util::function_a5318821();
  self thread namespace_78e9b80::function_15eaa2db(undefined, undefined, "flg_player_approach_flashback_tv", "flg_player_not_near_flashback_tv", "flashback_tv_lookat", "flashback_tv_screen", "flashback_tv_light", #"hash_1dbc4e0cabb8c63f");

  switch (level.var_b28c2c3a) {
    case # "ride":
    case # "church":
    case # "no_game":
    case # "plaza":
      self hms_util::function_2e7c81f6(#"sniper_standard_t9", #"pistol_semiauto_t9", #"frag_grenade", #"eq_flash_grenade");
      break;
    default:
      var_f0935a68 = getweapon(#"ar_damage_t9", "reddot");
      self hms_util::function_2e7c81f6(var_f0935a68, #"pistol_semiauto_t9", #"frag_grenade", #"eq_flash_grenade");
      break;
  }
}

function function_bf4b4b7e() {
  skipto::function_eb91535d("ride", &namespace_7617b2b9::main, &namespace_7617b2b9::start, "Ride", &namespace_7617b2b9::cleanup);
  skipto::function_eb91535d("church", &namespace_69b8cbbe::main, &namespace_69b8cbbe::start, "Church", &namespace_69b8cbbe::cleanup);
  skipto::function_eb91535d("plaza", &namespace_f7efe8a3::main, &namespace_f7efe8a3::start, "Plaza", &namespace_f7efe8a3::cleanup);
  skipto::function_eb91535d("1st_floor", &namespace_63e55f9b::main, &namespace_63e55f9b::start, "1st Floor", &namespace_63e55f9b::cleanup);
  skipto::function_eb91535d("1st_floor_cctv", &namespace_b16b5bf9::main, &namespace_b16b5bf9::start, "1st Floor CCTV", &namespace_b16b5bf9::cleanup);
  skipto::function_eb91535d("2nd_floor", &namespace_9162cd57::main, &namespace_9162cd57::start, "2nd Floor", &namespace_9162cd57::cleanup);
  skipto::function_eb91535d("vip_room", &namespace_dca66e72::main, &namespace_dca66e72::start, "VIP Room", &namespace_dca66e72::cleanup);
  skipto::function_eb91535d("escape", &namespace_9c5e6b7c::main, &namespace_9c5e6b7c::start, "Escape", &namespace_9c5e6b7c::cleanup);
  skipto::function_eb91535d("nic_rooftop", &namespace_69a17177::main, &namespace_69a17177::start, "Rooftop", &namespace_69a17177::cleanup);
  skipto::function_eb91535d("rooftop_defend_1", &namespace_302d34db::main, &namespace_302d34db::start, "Rooftop Defend 1", &namespace_302d34db::cleanup);
  skipto::function_eb91535d("exfil", &namespace_379d0dc2::main, &namespace_379d0dc2::start, "Exfil", &namespace_379d0dc2::cleanup);
}

function function_303d4f() {
  level.var_c50254e8 = 0;
  var_1dbaa44b = getEntArray("intel_pickup", "targetname");
  level.var_91240eb2 = var_1dbaa44b.size;
  array::thread_all(var_1dbaa44b, &hms_util::function_40e4ae8e, #"hash_a212d3829fdfd6f", &intel_collected);
}

function intel_collected() {
  level.player endon(#"death");
  objectives::function_45951a55("obj_intel");
  level.player util::function_1478233c(#"hash_407ea626576da92c");
  wait 0.7;
  level.player objectives_ui::show_objectives();
  level.var_c50254e8++;

  if(level.var_c50254e8 >= level.var_91240eb2) {
    hms_util::print("<dev string:x38>");

    objectives::complete("obj_intel");
  }

  objectives::function_1de88d60("obj_intel", undefined, level.var_c50254e8, level.var_91240eb2);
  level.player objectives_ui::show_objectives();
  level flag::set("obj_photo_done");
  level flag::set("flg_nuke_room_obj_done");

  if(self.var_864ed5f2 === 1) {
    level.player thread function_1cf01cbf();
  }
}

function function_1cf01cbf() {
  self endon(#"death");
  level endon(#"hash_6c6472ced18e7153");

  while(self isgestureplaying()) {
    waitframe(1);
  }

  self playgestureviewmodel(#"dem_lowready");
}

function function_d1c278ab(civilian, params) {
  wait 1;
  level util::missionfailedwrapper(#"hash_d0937a52204cd4e", #"hash_b4302157d22e1af");
}