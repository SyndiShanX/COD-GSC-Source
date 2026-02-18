/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_yamantau.gsc
***********************************************/

#using script_17b26b2e6b98a995;
#using script_2cd384a0f7be5baf;
#using script_2e03cad685678246;
#using script_3d81630134db409c;
#using script_4d984e2ed26bb2d9;
#using script_55d0a106fd8aa60a;
#using script_5a85dd71c99e76a2;
#using script_6f32a5eb9cd9dc68;
#using script_6fad88ff3ed4ff7d;
#using script_78fce3c67fb63796;
#using script_79f085c1bc211f9b;
#using script_8b6f2185feb33ac;
#using script_c36b776c6718540;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp\cp_rus_yamantau_flashlight;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace cp_rus_yamantau;

function event_handler[level_init] main(eventstruct) {
  setclearanceceiling(16);
  preload();
  load::main();
  postload();
  level flag::wait_till("game_start");
  setDvar(#"compassmaxrange", "2100");
  setDvar(#"hash_7fb1be9520b9a725", 100);
  setDvar(#"hash_6b57212fd4fcdd3a", 350);
  setDvar(#"hash_4ad75035d6026ea2", 0.819);

  level thread hms_util::function_5056f90d();
  level thread function_37fa595();
}

function preload() {
  level.disablestattracking = 1;
  level flag::set("no_corpse_pickup ");
  level.overrideactordamage = &namespace_8af9269b::function_a8b4a98e;
  level.var_8b7cb19c = &hms_util::function_8b7cb19c;
  callback::on_ai_spawned(&ai_cold_breath);
  callback::on_spawned(&function_2675a176);
  callback::on_ai_killed(&namespace_b73b9191::function_91e76e2e);
  level util::function_d96391ba();
  level cp_rus_yamantau_flashlight::preload();
  level namespace_c8bf7287::preload();
  init_clientfields();
  function_37dfd679();
  level thread namespace_ecdab0f4::function_b68e2d37();
}

function function_37dfd679() {
  skipto::function_eb91535d("intro_heli", &namespace_cbf28e01::function_37c8a043, &namespace_cbf28e01::function_38910b5f, undefined, &namespace_cbf28e01::function_a0b88490);
  skipto::function_eb91535d("mountain_summit", &namespace_cbf28e01::function_3d1df8a6, &namespace_cbf28e01::function_d3655e70, undefined, &namespace_cbf28e01::function_fdbb9f1e);
  skipto::function_eb91535d("ice_slide", &namespace_cbf28e01::function_ae06da18, &namespace_cbf28e01::function_bb34c64, undefined, &namespace_cbf28e01::function_33fd8fa3);
  skipto::function_eb91535d("zipline_intro", &namespace_cbf28e01::function_11648e12, &namespace_cbf28e01::function_b205e5be, undefined, &namespace_cbf28e01::function_71f05605);
  skipto::function_eb91535d("satcom_approach", &namespace_94dc1844::function_56b991c1, &namespace_94dc1844::function_c73772c6, undefined, &namespace_94dc1844::function_844967aa);
  skipto::function_eb91535d("satcom", &namespace_94dc1844::function_8cc2cc25, &namespace_94dc1844::function_f6f8cdca, undefined, &namespace_94dc1844::function_a46dc345);
  skipto::function_eb91535d("catwalks", &namespace_a2d2e744::function_32d297d8, &namespace_a2d2e744::function_2445d847, undefined, &namespace_a2d2e744::function_dfe7cd78);
  skipto::add_dev("dev_catwalks_stealth", &namespace_a2d2e744::function_965213e6, &namespace_a2d2e744::function_2445d847, undefined, &namespace_a2d2e744::function_dfe7cd78);
  skipto::function_eb91535d("zipline_fall", &namespace_a2d2e744::function_198e08b8, &namespace_a2d2e744::function_9539fa90, undefined, &namespace_a2d2e744::function_b366b7a9);
  skipto::function_eb91535d("bunker_explore", &namespace_73841f48::function_599d30fb, &namespace_73841f48::function_c3ccbcc8, undefined, &namespace_73841f48::function_f46b6ef);
  skipto::function_eb91535d("bunker_encounter", &namespace_73841f48::function_eea0086d, &namespace_73841f48::function_b47dd82e, undefined, &namespace_73841f48::function_511f3559);
  skipto::function_eb91535d("woods_regroup", &namespace_73841f48::function_4e75b98e, &namespace_73841f48::function_4d07bf4e, undefined, &namespace_73841f48::function_53b51eb0);
  skipto::function_eb91535d("excavation", &namespace_9e8d4ac3::function_6d9e84ea, &namespace_9e8d4ac3::function_ab15a34c, undefined, &namespace_9e8d4ac3::function_1e5a768a);
  skipto::function_eb91535d("excavation_finale", &namespace_9e8d4ac3::function_e30ea9da, &namespace_9e8d4ac3::function_4a1a74fe, undefined, &namespace_9e8d4ac3::function_888e9b6b);
  skipto::function_eb91535d("server_reveal", &namespace_7ef9d872::function_87560e1a, &namespace_7ef9d872::function_dba43792, undefined, &namespace_7ef9d872::function_bb405879);
  skipto::function_eb91535d("server_ascent", &namespace_7ef9d872::function_e936fbf4, &namespace_7ef9d872::function_f59af500, undefined, &namespace_7ef9d872::function_b80cf494);
  skipto::add_dev("dev_satcom_shot", &namespace_94dc1844::function_22e1ef3a, &namespace_94dc1844::function_cc91ce1f, undefined, &namespace_94dc1844::function_a46dc345);
  skipto::function_46d8992a("intro_heli");
}

function init_clientfields() {
  clientfield::register("toplayer", "optional_objective_camera_fx", 1, 1, "int");
  clientfield::register("toplayer", "zipline_player_free_fall_fx", 1, 1, "int");
  clientfield::register("toplayer", "set_sun_color_black", 1, 1, "int");
  clientfield::register("world", "cull_inside_satcom", 1, 2, "int");
  clientfield::register("world", "cull_inside_finale", 1, 2, "int");
  clientfield::register("world", "cull_inside_bunkerext", 1, 2, "int");
  clientfield::register("world", "cull_outside_bunkerint", 1, 2, "int");
  clientfield::register("world", "cull_inside_excavation", 1, 2, "int");
  clientfield::register("world", "init_visgroup_triggers", 1, 1, "int");
}

function ai_cold_breath() {
  self endon(#"death");
  wait 0.2;

  if(level.var_28c22d88[0] != "intro_heli" && !isvehicle(self)) {
    self clientfield::increment("ai_cold_breath");
  }
}

function function_2675a176() {
  if(!isDefined(level.player)) {
    level.player = self;
  }

  if(!isDefined(level.var_28c22d88[0])) {
    return;
  }

  self setcharacterbodytype(1);
  self setcharacteroutfit(6);
  self.var_9d386cb9 = "Mason";

  switch (level.var_28c22d88[0]) {
    case # "mountain_summit":
    case # "intro_heli":
    case # "zipline_intro":
    case # "ice_slide":
    case # "satcom_approach":
    case # "satcom":
    case # "catwalks":
    case # "zipline_fall":
      w_primary = getweapon(#"sniper_standard_t9", "suppressed2");
      w_secondary = getweapon(#"pistol_burst_t9", "suppressed2");
      var_deeb6741 = getweapon(#"frag_grenade");
      var_2586eb45 = getweapon(#"eq_flash_grenade");
      hms_util::function_2e7c81f6(w_primary, w_secondary, var_deeb6741, var_2586eb45);
      break;
    case # "bunker_explore":
    case # "bunker_encounter":
      w_primary = getweapon(#"knife_loadout");
      var_deeb6741 = getweapon(#"frag_grenade");
      var_2586eb45 = getweapon(#"eq_flash_grenade");
      hms_util::function_2e7c81f6(w_primary, undefined, var_deeb6741, var_2586eb45);
      break;
    case # "woods_regroup":
    case # "excavation":
      var_6bacd91d = # "smg_standard_t9";
      w_secondary = getweapon(#"pistol_semiauto_t9");

      if(namespace_b73b9191::function_34163738()) {
        if(isinarray(level.var_7334dc42, #"hash_165cf52ce418f5a1")) {
          var_6bacd91d = # "hash_165cf52ce418f5a1";
        }

        if(isinarray(level.var_7334dc42, #"hash_3ed4419427e0d85a")) {
          w_secondary = getweapon(#"hash_3ed4419427e0d85a", "fastreload2", "quickdraw2", "heavy2", "compensator", "handle2");
        }
      }

      w_primary = getweapon(var_6bacd91d);
      var_deeb6741 = getweapon(#"frag_grenade");
      var_2586eb45 = getweapon(#"eq_flash_grenade");
      hms_util::function_2e7c81f6(w_primary, w_secondary, var_deeb6741, var_2586eb45);
      break;
    case # "excavation_finale":
    case # "server_reveal":
    case # "server_ascent":
      w_primary = getweapon(#"smg_heavy_t9", "extclip2", "grip");
      w_secondary = getweapon(#"pistol_semiauto_t9");

      if(namespace_b73b9191::function_34163738()) {
        if(isinarray(level.var_7334dc42, #"hash_165cf52ce418f5a1")) {
          w_primary = getweapon(#"hash_165cf52ce418f5a1");
        }

        if(isinarray(level.var_7334dc42, #"hash_3ed4419427e0d85a")) {
          w_secondary = getweapon(#"hash_3ed4419427e0d85a", "fastreload2", "quickdraw2", "heavy2", "compensator", "handle2");
        }
      }

      var_deeb6741 = getweapon(#"frag_grenade");
      var_2586eb45 = getweapon(#"eq_flash_grenade");
      hms_util::function_2e7c81f6(w_primary, w_secondary, var_deeb6741, var_2586eb45);
      break;
    default:
      w_primary = getweapon(#"sniper_standard_t9", "suppressed2");
      w_secondary = getweapon(#"pistol_burst_t9", "suppressed2");
      var_deeb6741 = getweapon(#"frag_grenade");
      var_2586eb45 = getweapon(#"eq_flash_grenade");
      hms_util::function_2e7c81f6(w_primary, w_secondary, var_deeb6741, var_2586eb45);
      break;
  }
}

function function_dce9f3d4() {
  callback::on_ai_killed(&on_ai_killed);
  level.e_server_hook = getent("e_server_hook", "targetname");
  level.e_server_cable = getent("e_server_cable", "targetname");
  level.e_server_cable_simmed = getent("e_server_cable_simmed", "targetname");
  level.e_server_cable_simmed hide();
  s_situation_room_glass = struct::get_array("s_situation_room_glass", "targetname");

  foreach(struct in s_situation_room_glass) {
    glassradiusdamage(struct.origin, 20, 10, 10);
  }
}

function on_ai_killed(s_params) {
  self dialogue::function_47b06180();
}

function postload() {
  level.var_99a24a99 = 1;
  level thread function_bdb2b948();
  level thread namespace_ecdab0f4::function_f84e1e7();
  level thread cp_rus_yamantau_flashlight::postload();
  level thread namespace_8a404420::postload();
  level thread namespace_517e3310::postload();
  level thread namespace_1d6bb8b4::postload();
  level thread function_dce9f3d4();
  level clientfield::set("init_visgroup_triggers", 1);
}

function function_bdb2b948() {
  level thread namespace_8af9269b::function_1acebbc0("zipline_mountain_tutorial", undefined, 0.8, undefined, 1, undefined, 1, "snow");
  level thread namespace_8af9269b::function_1acebbc0("zipline_mountain_tutorial_jump", undefined, undefined, undefined, undefined, undefined, 1, "snow");
  level thread namespace_8af9269b::function_1acebbc0("zipline_satcom", 0.5, 0.7, undefined, undefined, undefined, 1, "snow");
  level thread namespace_8af9269b::function_1acebbc0("zipline_catwalks", 0.7, undefined, undefined, undefined, 1, 1, "snow");
  level thread namespace_8af9269b::function_1acebbc0("zipline_excavation_1", undefined, undefined, undefined, undefined, undefined, 1, "snow");
  level thread namespace_8af9269b::function_1acebbc0("zipline_excavation_4", undefined, undefined, undefined, undefined, undefined, 1, "snow");
  level thread namespace_8af9269b::function_1acebbc0("zipline_excavation_5", undefined, undefined, undefined, undefined, undefined, 1, "snow");
  level thread namespace_8af9269b::function_1acebbc0("zipline_excavation_6", undefined, undefined, undefined, undefined, undefined, 1, "snow");
  level thread namespace_8af9269b::function_1acebbc0("zipline_excavation_7", undefined, undefined, undefined, undefined, undefined, 1, "snow");
  level thread namespace_8af9269b::function_1acebbc0("zipline_server_1", undefined, undefined, undefined, undefined, undefined, 1, "snow");
}

function private function_37fa595() {
  var_2c251c2e = util::get_map_name();
  adddebugcommand("<dev string:x38>");
  adddebugcommand("<dev string:x91>");
  adddebugcommand("<dev string:xed>");

  while(true) {
    var_25d5206e = getdvarint(#"hash_6bcb191f82f445a0", 0);

    switch (var_25d5206e) {
      case 1:
        level thread namespace_73841f48::function_99854e6c();
        break;
      case 2:
        level thread namespace_73841f48::function_c54b46bc();
        break;
      case 3:
        level thread function_23d342b7();
        break;
      default:
        break;
    }

    setDvar(#"hash_6bcb191f82f445a0", 0);
    wait 0.5;
  }
}

function function_23d342b7() {
  transient = savegame::function_6440b06b(#"transient");
  transient.var_296ec611 = 1;
  savegame::function_7790f03(1);
  wait 0.5;
  skipto::function_8722a51a("<dev string:x14a>");
  map_restart();
}