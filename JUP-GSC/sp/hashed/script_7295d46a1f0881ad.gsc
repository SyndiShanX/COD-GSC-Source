/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7295d46a1f0881ad.gsc
*************************************************/

#using script_1031976741eb6674;
#using script_159c1d9ebef7e54c;
#using script_1cc61c7403dfc55f;
#using script_1e172edbfbe283b6;
#using script_21f09868d3739a15;
#using script_60add030ce1a42b6;
#using script_f8531dcf975a7a7;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_build;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\player;
#using scripts\sp\player\ally_equipment;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\spawner;
#using scripts\sp\stealth\manager;
#using scripts\sp\stealth\utility;
#using scripts\sp\trigger;
#using scripts\sp\utility;
#using scripts\stealth\enemy;
#using scripts\stealth\friendly;
#using scripts\stealth\init;
#using scripts\stealth\utility;
#namespace namespace_52568128d3d323dd;

function function_4f23ea13a3a0391() {}

function function_4a61ed6faa426e3() {
  utility::set_start_location("s_start_forest_walk", [level.player]);
}

function function_11ba903aeae3f374() {
  level thread function_ae5aac89cb5073ea();
  exploder("vfx_lake_surface_env");
  namespace_8339f6377b6ba60e::function_4c28f0141619d61a();
  utility::set_start_location("s_start_forest_walk", level.tundra_allies);
  level.player thread utility::dof_disable_autofocus();
  scuba_mask = level.scuba_mask;

  if(isDefined(scuba_mask)) {
    scuba_mask delete();
    level.scuba_mask = undefined;
  }

  function_1b6bf1bdf11e0d17();
  namespace_8339f6377b6ba60e::function_d0629cd40cf205c5();
  scripts\sp\player\ally_equipment::ally_equipment_backpack(level.soap, "ammo", -1, 0);
}

function function_783509975b12f6d5() {
  namespace_8339f6377b6ba60e::function_d0629cd40cf205c5();
  scripts\sp\player\ally_equipment::ally_equipment_backpack(level.soap, "ammo", -1, 0);
  exploder("vfx_lake_surface_env");
}

function function_ae5aac89cb5073ea() {
  level.player clearadditionalstreampos();
  hint_position = (7882, -18861, -1);
  level.player function_670863fc4008c3d8(hint_position);
  wait 10;
  level.player clearadditionalstreampos();
}

function function_1b6bf1bdf11e0d17() {
  level.player player::focusdisable();
  thread campfire_music();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  registered = "campfire_exposition";
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "show_hud", 0);
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "freezecontrols", 1);
  transient_unload("sp_jup_tundra_lake_tr");

  if(!isplatformpc()) {
    setsaveddvar(@ "hash_7cae3a58007c1b7d", "33.33");
  }

  namespace_5f9a73fb2d310d21::function_edd86bdc9ab6ce10();
  level utility::flag_wait("scene_0200_igc_done");
  level utility::flag_set("tundra_forest_reveal_complete");
  setomnvar("ui_is_bink_skippable", 0);

  if(!isplatformpc()) {
    setsaveddvar(@ "hash_7cae3a58007c1b7d", "16.66");
  }

  level.player val::set(registered, "show_weapon_hud", 1);
  level.player val::set(registered, "show_hud", 1);
  level.player val::set(registered, "weapon", 1);
  level.player val::set(registered, "freezecontrols", 0);
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 1);
  level.player player::focusenable();
}

function campfire_music() {
  setmusicstate("mx_tundra_campfire");
}

function function_bb445c419a7ba71c() {}

function function_5d7b40326f372043() {
  namespace_8339f6377b6ba60e::function_4c28f0141619d61a();
  utility::set_start_location("s_start_forest_walk", [level.player]);
  utility::set_start_location("s_start_forest_walk", level.tundra_allies);
  level thread function_e202fd10c4a3259e("s_start_forest_walk", 0);
}

function function_57c07a6813bb4b54() {
  utility::autosave_by_name();

  level thread namespace_8339f6377b6ba60e::function_9a2b6bf96312f577("<dev string:x1c>", "<dev string:x28>");

  level notify("audio_clear_vip_rescue_mute");
  level utility::flag_clear("stealth_spotted");
  level thread function_de1f6c55da055ca9(0);
  level thread function_d418f8be37159e7c();
  level thread function_f25a618ad98dda0d();
  level thread namespace_191bb1c1589b3acb::function_92796961c6647625();
  level thread namespace_93635c21ec57253a::forest_birds();
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_forest_stop_nags", "forest_player_progress", "trig_forest");
  utility::array_thread(level.tundra_allies, &function_734016f6a0a7acf8);
  level.shepherd enabletraversals(0);
  level utility::flag_wait("flag_forest_walk_03");
  level thread function_85944f527a37d31();
  level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_forest_stop_nags");
  utility::autosave_by_name();
  msg = level utility::flag_wait_any_return("flag_forest_walk_04", "flag_forest_walk_heli_passed");
  wait 0.1;
  level utility::flag_set("flag_forest_walk_heli_continue");
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_forest_stop_nags", "forest_player_progress", "trig_forest");
  level utility::flag_wait("flag_forest_walk_complete");

  foreach(ally in level.tundra_allies) {
    ally.dontevershoot = 0;
  }

  level.player namespace_8339f6377b6ba60e::function_7aa294337fd3a7c4();
}

function function_d79da6fbc9c93e35() {
  level thread namespace_93635c21ec57253a::forest_birds();
}

function function_85944f527a37d31() {
  var_dc971957a84e8915 = [];
  var_dc971957a84e8915 = vehicle::spawn_vehicles_from_targetname_and_drive("veh_enemy_heli_forest_walk");
  vehicle_build::build_treadfx(var_dc971957a84e8915[0].classname_mp, "default", "vfx/jup/level/sp_tundra/vfx_tun_env_helo_wash_snow_1.vfx", 1);

  foreach(heli in var_dc971957a84e8915) {
    heli thread namespace_8339f6377b6ba60e::function_9871d73aaf67c8f4("flag_forest_walk_heli_passed");
  }

  level thread function_d7f445e5aa6e47cf(var_dc971957a84e8915);
  level utility::flag_wait("flag_forest_walk_heli_approaching");
  s_heli_aim_at_start = getStruct("s_heli_aim_at_start", "targetname");
  s_heli_aim_at_end = getStruct("s_heli_aim_at_end", "targetname");
  var_5cd6b2c7ce5b397b = scripts\sp\utility::function_e24293736e639dcf("axis", s_heli_aim_at_start.origin, (0, 0, 0));
  var_5cd6b2c7ce5b397b notsolid();
  var_5cd6b2c7ce5b397b moveTo(s_heli_aim_at_end.origin, 5, 2, 2);
  level utility::flag_wait("flag_forest_walk_heli_passed");
  var_5cd6b2c7ce5b397b delete();
}

function function_7ed48e07e36146d3() {
  wait 3;
  lerp_saveddvar(@ "hash_402173c7dbee15d9", 15, 5);
  thread function_66f372fce211ef25();
  lerp_saveddvar(@ "hash_402173c7dbee15d9", 1, 12);
}

function function_66f372fce211ef25() {
  exploder("forest_walk_reactive_tree_snow_fall_01");
  exploder("forest_walk_reactive_tree_snow_fall_02");
  exploder("forest_walk_reactive_tree_snow_fall_03");
}

function function_d418f8be37159e7c() {
  level.player endon("death");
  level.player setmovespeedscale(0.7);
  level.player enableslowaim();
  level.player allowsprint(0);
  utility::waittill_any_ents_or_timeout_return(5, level.player, "stop_radio_gesture", level, "flag_forest_walk_02");
  waitframe();
  level.player allowsprint(1);
  level.player disableslowaim();
  level.player utility::blend_movespeedscale(0.85, 1);
}

function function_d7f445e5aa6e47cf(var_dc971957a84e8915) {
  utility::array_ent_flag_wait(var_dc971957a84e8915, "flag_forest_walk_heli_passed");
  level utility::flag_set("flag_forest_walk_heli_passed");
}

function function_f25a618ad98dda0d() {
  level.player endon("death");
  level endon("flag_forest_walk_complete");

  while(true) {
    if(istrue(namespace_8339f6377b6ba60e::function_73ca7ba04ae7e51e())) {
      level utility::flag_set("flag_forest_walk_player_thermal_used");
    } else {
      level utility::flag_clear("flag_forest_walk_player_thermal_used");
    }

    wait 0.2;
  }
}

function function_734016f6a0a7acf8() {
  self endon("death");
  utility::set_pacifist(1);
  self.dontevershoot = 1;
  level utility::flag_wait("flag_forest_walk_03");
  wait randomfloatrange(0.1, 0.9);
  namespace_8339f6377b6ba60e::function_83e7e4b9d5f7bdb(0, 1, 0);
  level utility::flag_wait("flag_forest_walk_heli_continue");
  wait randomfloatrange(0.1, 0.9);
  start_struct = namespace_8339f6377b6ba60e::function_bdc421f433af10c7("s_start_forest_patrol");
  thread namespace_8339f6377b6ba60e::function_11fc094b83527d81(start_struct);
  thread function_d7055444f315e75f();
  self.dontevershoot = 0;
}

function function_dc486885b0a4b310() {}

function forest_patrol_start() {
  namespace_8339f6377b6ba60e::function_4c28f0141619d61a();
  utility::set_start_location("s_start_forest_patrol", utility::array_add(level.tundra_allies, level.player));
  function_e202fd10c4a3259e("s_start_forest_patrol");
  level.shepherd enabletraversals(0);
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_forest_stop_nags", "forest_player_progress", "trig_forest");
  level thread function_de1f6c55da055ca9(1);
  level thread namespace_191bb1c1589b3acb::function_84746c3250d67674();
}

function forest_patrol_main() {
  utility::autosave_by_name();

  level thread namespace_8339f6377b6ba60e::function_9a2b6bf96312f577("<dev string:x42>", "<dev string:x50>");

  level utility::flag_clear("stealth_spotted");
  level utility::flag_set("flag_forest_stop_nags");
  level.player utility::blend_movespeedscale(0.9, 2);
  level thread namespace_191bb1c1589b3acb::function_14097a99fb04951c();
  utility::array_thread(level.tundra_allies, &function_aff81880ccead88c);
  waitframe();
  level thread function_53ea8ecca449d16a();
  level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_forest_stop_nags");
  var_3df81a9c99e1dca3 = utility::array_spawn_targetname("ai_forest_patrol_enemy");
  utility::array_thread(var_3df81a9c99e1dca3, &function_ffdb892637831b82, var_3df81a9c99e1dca3);
  utility::array_thread(var_3df81a9c99e1dca3, &function_5812af1fe9fc448f);
  var_c669baa85e21ef55 = utility::get_living_ai_array("ai_forest_patrol_enemy_left", "script_noteworthy");
  var_8254891264f3bb2e = utility::get_living_ai_array("ai_forest_patrol_enemy_right", "script_noteworthy");
  level thread function_78e3814fa6a8d154(var_c669baa85e21ef55, "flag_forest_patrol_enemy_passing_left", "flag_forest_patrol_enemies_passing_left");
  level thread function_78e3814fa6a8d154(var_8254891264f3bb2e, "flag_forest_patrol_enemy_passing_right", "flag_forest_patrol_enemies_passing_right");
  level thread function_78e3814fa6a8d154(var_3df81a9c99e1dca3, "flag_forest_patrol_enemy_passed", "flag_forest_patrol_enemies_passed");
  level thread function_86f1aa3ac6af75c();
  level thread function_92f66e5a5870cb53(var_3df81a9c99e1dca3);
  level thread function_fe1be40f59b61549(var_3df81a9c99e1dca3);
  level thread namespace_8339f6377b6ba60e::function_7cf3b8f1b807889a(var_3df81a9c99e1dca3, "flag_forest_patrol_enemies_one_dead", 1, "flag_forest_patrol_complete");
  level thread function_67a59c61fabe3f0f(var_3df81a9c99e1dca3);
  level thread namespace_8339f6377b6ba60e::function_7cf3b8f1b807889a(var_3df81a9c99e1dca3, "flag_forest_patrol_enemies_nerf", var_3df81a9c99e1dca3.size - 1, "flag_forest_patrol_complete");
  level thread namespace_8339f6377b6ba60e::function_7039df9b8f2744bb(var_3df81a9c99e1dca3, ["flag_forest_patrol_enemies_nerf", "flag_forest_patrol_complete"], 0, undefined, "flag_forest_patrol_complete");
  level thread namespace_8339f6377b6ba60e::function_2d474574a7fbf9d9(var_3df81a9c99e1dca3, "flag_forest_sniper_complete");
  level thread function_9196d2dd4bec3a3d();
  msg = level utility::flag_wait_any_return("flag_forest_patrol_complete", "flag_forest_patrol_allies_exit", "flag_forest_patrol_enemies_dead");
  level thread function_4bbc9987e0db4b48(msg);
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_forest_stop_nags", "forest_player_progress", "trig_forest");
  level utility::flag_wait("flag_forest_patrol_complete");
  level utility::flag_set("flag_forest_patrol_enemies_nerf");
  level.player utility::blend_movespeedscale(0.95, 2);
}

function forest_patrol_catchup() {
  level utility::flag_set("flag_forest_patrol_complete");
  level utility::flag_set("flag_forest_patrol_enemies_dead");
  level utility::flag_set("flag_forest_patrol_allies_exiting");
}

function function_aff81880ccead88c() {
  level.player endon("death");
  level endon("flag_forest_patrol_allies_exit");
  level endon("flag_forest_sniper_complete");
  vol_left = getEnt("vol_forest_patrol_ally_combat_left", "targetname");
  vol_right = getEnt("vol_forest_patrol_ally_combat_right", "targetname");
  namespace_8339f6377b6ba60e::function_83e7e4b9d5f7bdb(0, 1, 1);
  namespace_8339f6377b6ba60e::function_c9317b6d58796509(1, "cqb");
  level utility::flag_wait("flag_forest_patrol_combat");
  wait randomfloatrange(1, 3);
  namespace_8339f6377b6ba60e::function_83e7e4b9d5f7bdb(1, 1, 1);
  namespace_8339f6377b6ba60e::function_f149c0325eb376c4();
  namespace_8339f6377b6ba60e::function_c9317b6d58796509(0, "combat");
  utility::set_fixednode_false();
  self.var_43ae9f4734246fb0 = 1;
  function_f8eb8485e2980189();

  if(flag("flag_forest_patrol_left")) {
    self setgoalvolumeauto(vol_left);
    return;
  }

  a_vols = [vol_left, vol_right];
  a_vols = sortbydistance(a_vols, self.origin);
  self setgoalvolumeauto(a_vols[0]);
}

function function_47108e4212e83491() {
  foreach(ally in level.tundra_allies) {
    ally function_f8eb8485e2980189();
  }
}

function function_f8eb8485e2980189() {
  ai_enemy = utility::get_closest_ai(self.origin, "axis");

  if(isDefined(ai_enemy) && isalive(ai_enemy)) {
    utility::set_favoriteenemy(ai_enemy);
    self getenemyinfo(ai_enemy);
  }
}

function function_53ea8ecca449d16a() {
  level.player endon("death");
  level endon("flag_forest_patrol_allies_exit");
  level endon("flag_forest_patrol_combat");
  level utility::flag_wait_any("flag_forest_patrol_allies_use_colors", "flag_forest_patrol_01");

  foreach(ally in level.tundra_allies) {
    ally utility::ent_flag_init("flag_forest_patrol_ally_crossing_left");
    ally namespace_8339f6377b6ba60e::function_83e7e4b9d5f7bdb(1, 1, 1);
  }

  function_47108e4212e83491();
  namespace_8339f6377b6ba60e::function_c43c63bffb8327b2();
  waitframe();
  namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
  utility::activate_trigger_with_targetname("trig_forest_patrol_allies_01");
  msg = level utility::flag_wait_any_return("flag_forest_patrol_02", "flag_forest_patrol_enemies_passing_left");
  function_47108e4212e83491();
  namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();

  if(msg == "flag_forest_patrol_enemies_passing_left") {
    level utility::flag_wait("flag_forest_patrol_enemies_approaching_right");

    iprintln("<dev string:x6c>");

    utility::activate_trigger_with_targetname("trig_forest_patrol_allies_06");
    level utility::flag_set("flag_forest_patrol_allies_shift_left");
    level thread function_2844d43dc80235db();
    array_thread(level.tundra_allies, &function_887f68d01c7c8bcc);
    level utility::flag_wait("flag_forest_patrol_03");
  } else if(!utility::flag("flag_forest_patrol_enemies_approaching_right")) {
    iprintln("<dev string:x92>");

    utility::activate_trigger_with_targetname("trig_forest_patrol_allies_02");
  }

  msg = level utility::flag_wait_any_return("flag_forest_patrol_03", "flag_forest_patrol_enemies_passing_left");
  function_47108e4212e83491();
  namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();

  if(msg == "flag_forest_patrol_enemies_passing_left") {
    level utility::flag_wait_any("flag_forest_patrol_enemies_continue_right", "flag_forest_patrol_enemies_approaching_right");

    iprintln("<dev string:xb9>");

    utility::activate_trigger_with_targetname("trig_forest_patrol_allies_07");
    level utility::flag_set("flag_forest_patrol_allies_shift_left");
    level thread function_2844d43dc80235db();
    array_thread(level.tundra_allies, &function_887f68d01c7c8bcc);
    level utility::flag_wait("flag_forest_patrol_04");
  } else if(!utility::flag("flag_forest_patrol_enemies_approaching_right") && !flag("flag_forest_patrol_enemies_continue_right")) {
    iprintln("<dev string:xdf>");

    utility::activate_trigger_with_targetname("trig_forest_patrol_allies_03");
  }

  msg = level utility::flag_wait_any_return("flag_forest_patrol_04", "flag_forest_patrol_enemies_passing_left");
  function_47108e4212e83491();
  namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();

  if(msg == "flag_forest_patrol_enemies_passing_left") {
    iprintln("<dev string:x106>");

    utility::activate_trigger_with_targetname("trig_forest_patrol_allies_08");
    level utility::flag_set("flag_forest_patrol_allies_shift_left");
    level thread function_2844d43dc80235db();
    array_thread(level.tundra_allies, &function_887f68d01c7c8bcc);
    return;
  }

  if(!utility::flag("flag_forest_patrol_enemies_approaching_right") && !flag("flag_forest_patrol_enemies_continue_right")) {
    iprintln("<dev string:x12c>");

    utility::activate_trigger_with_targetname("trig_forest_patrol_allies_04");
  }
}

function function_2844d43dc80235db() {
  var_8254891264f3bb2e = utility::get_living_ai_array("ai_forest_patrol_enemy_right", "script_noteworthy");
  var_8254891264f3bb2e = sortbydistance(var_8254891264f3bb2e, level.shepherd.origin);
  var_c7937b10510af7a1 = var_8254891264f3bb2e[0];
  createnavrepulsor("forest_patrol_enemy_right", 6, var_c7937b10510af7a1.origin, 640, 1, "allies");
}

function function_887f68d01c7c8bcc() {
  self endon("death");
  namespace_8339f6377b6ba60e::function_c9317b6d58796509(1, "cqb");
  self allowedstances("crouch", "prone");
  utility::ent_flag_set("flag_forest_patrol_ally_crossing_left");

  if(self.animname == "shepherd") {
    self enabletraversals(1);
  }

  function_110dccf2417debe6();
  waitframe();
  self allowedstances("stand", "crouch", "prone");
  utility::ent_flag_clear("flag_forest_patrol_ally_crossing_left");

  if(self.animname == "shepherd") {
    self enabletraversals(0);
  }
}

function function_110dccf2417debe6() {
  level endon("flag_forest_patrol_complete");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_allies_exit");
  trig = getEnt("trig_forest_patrol_left", "targetname");

  while(!self istouching(trig)) {
    wait 1;
  }
}

function function_4bbc9987e0db4b48(msg) {
  level.player endon("death");

  if(isDefined(msg) && msg != "flag_forest_patrol_enemies_dead") {
    wait 1;
  }

  if(level utility::flag("flag_forest_patrol_combat")) {
    level utility::flag_wait("flag_forest_patrol_enemies_dead");
  }

  level utility::flag_set("flag_forest_patrol_allies_exit");
  namespace_8339f6377b6ba60e::function_718f6388e43588d7();
  waitframe();
  trig_left = getEnt("trig_forest_patrol_left", "targetname");
  vol_left = getEnt("vol_forest_patrol_ally_combat_left", "targetname");
  vol_right = getEnt("vol_forest_patrol_ally_combat_right", "targetname");
  a_ai_allies[0] = level.soap;
  a_ai_allies[1] = level.gaz;
  a_ai_allies[2] = level.shepherd;
  var_a37a3f8ea10c6f7d = 0;

  foreach(ally in a_ai_allies) {
    if(ally istouching(trig_left)) {
      if(level utility::flag("flag_forest_patrol_enemies_passed")) {
        s_start = "s_start_forest_sniper_left";
      } else {
        a_ai_enemies = vol_left utility::get_ai_touching_volume("axis");

        if(a_ai_enemies.size > 0) {
          if(!istrue(var_a37a3f8ea10c6f7d)) {
            var_c7937b10510af7a1 = utility::get_closest_ai(ally.origin, "axis");
            createnavrepulsor("forest_patrol_allies_exit", 12, var_c7937b10510af7a1.origin, 640, 1, "allies");
            var_a37a3f8ea10c6f7d = 1;
          }

          s_start = "s_start_forest_sniper";
        } else {
          s_start = "s_start_forest_sniper_left";
        }
      }
    } else if(level utility::flag("flag_forest_patrol_enemies_passed")) {
      s_start = "s_start_forest_sniper";
    } else {
      a_ai_enemies = vol_right utility::get_ai_touching_volume("axis");

      if(a_ai_enemies.size > 0) {
        if(!istrue(var_a37a3f8ea10c6f7d)) {
          var_c7937b10510af7a1 = utility::get_closest_ai(ally.origin, "axis");
          createnavrepulsor("forest_patrol_allies_exit", 12, var_c7937b10510af7a1.origin, 640, 1, "allies");
          var_a37a3f8ea10c6f7d = 1;
        }

        s_start = "s_start_forest_sniper_left";
      } else {
        s_start = "s_start_forest_sniper";
      }
    }

    level utility::flag_set("flag_forest_patrol_allies_exiting");

    if(!level utility::flag("flag_forest_sniper_allies_use_colors")) {
      start_struct = ally namespace_8339f6377b6ba60e::function_bdc421f433af10c7(s_start);
      ally thread namespace_8339f6377b6ba60e::function_11fc094b83527d81(start_struct);
      ally thread function_d7055444f315e75f();
      ally thread function_4df5c862180ac2c0(var_a37a3f8ea10c6f7d);
    }

    wait randomfloatrange(0.1, 0.9);
  }
}

function function_4df5c862180ac2c0(var_a37a3f8ea10c6f7d) {
  level.player endon("death");
  level endon("flag_forest_sniper_allies_use_colors");

  if(level utility::flag("flag_forest_sniper_allies_use_colors")) {
    return;
  }

  if(istrue(var_a37a3f8ea10c6f7d)) {
    ent_flag_wait_or_timeout("flag_forest_patrol_ally_exit", 10);
  }

  self.var_43ae9f4734246fb0 = 0;
  utility::clear_movement_speed();
  namespace_8339f6377b6ba60e::function_c9317b6d58796509(0, "cqb");
}

function function_ffdb892637831b82(var_3df81a9c99e1dca3) {
  self endon("death");
  utility::set_grenadeammo(0);
  ai::disable_long_death();
  self.ainame = "Konni";
  utility::set_patrol_style("alert");
  thread function_db036cedffb02429();
  thread function_978b9838e46a676a(var_3df81a9c99e1dca3);
  thread function_b7a030bd256eed85();
  ent_flag_init("flag_forest_patrol_enemy_passed");
  ent_flag_init("flag_forest_patrol_enemy_damaged_by_player");
  ent_flag_init("flag_forest_patrol_enemy_force_alert");
  thread function_eec7bc2ee7e5f66d();

  if(isDefined(self.script_parameters) && self.script_parameters == "ai_forest_patrol_radio_guy") {
    thread function_d9c20f605a802309();
  }

  ent_flag_wait("flag_forest_patrol_enemy_passed");
  set_ignoreall(1);
  set_ignoreme(1);
  var_79f274d73f73d612 = squared(384);
  var_cc4fd6ddbb4ab005 = squared(768);

  while(!ent_flag("flag_forest_patrol_enemy_damaged_by_player") && !ent_flag("flag_forest_patrol_enemy_force_alert")) {
    n_dist_sq = distance2dsquared(self.origin, level.player.origin);

    if(n_dist_sq < var_79f274d73f73d612) {
      break;
    } else if(n_dist_sq < var_cc4fd6ddbb4ab005 && (self cansee(level.player) || level.player issprinting())) {
      break;
    }

    wait 0.5;
  }

  set_ignoreall(0);
  set_ignoreme(0);
  self getenemyinfo(level.player);
  ent_flag_set("flag_forest_patrol_enemy_force_alert");
  wait 1;
  var_3df81a9c99e1dca3 = utility::array_removedead_or_dying(var_3df81a9c99e1dca3);
  var_ac8d8dd990be593 = utility::get_array_of_closest(self.origin, var_3df81a9c99e1dca3, undefined, undefined, 768);

  if(var_ac8d8dd990be593.size > 0) {
    foreach(ai in var_ac8d8dd990be593) {
      if(!ai ent_flag("flag_forest_patrol_enemy_force_alert")) {
        ai ent_flag_set("flag_forest_patrol_enemy_force_alert");
      }

      waitframe();
    }
  }
}

function function_67a59c61fabe3f0f(var_3df81a9c99e1dca3) {
  level.player endon("death");
  level endon("flag_forest_patrol_enemies_dead");
  level endon("flag_forest_sniper_complete");

  while(var_3df81a9c99e1dca3.size > 0) {
    var_3df81a9c99e1dca3 = array_removedead_or_dying(var_3df81a9c99e1dca3);

    if(var_3df81a9c99e1dca3.size == 0) {
      break;
    }

    foreach(ai in var_3df81a9c99e1dca3) {
      if(ai utility::ent_flag_exist("flag_forest_patrol_enemy_passed") && ai utility::ent_flag("flag_forest_patrol_enemy_passed")) {
        var_3df81a9c99e1dca3 = utility::array_remove(var_3df81a9c99e1dca3, ai);
      }
    }

    wait 0.5;
  }

  utility::flag_set("flag_forest_patrol_enemies_dead");
}

function function_d9c20f605a802309() {
  self endon("death");
  self endon("flag_forest_patrol_combat");

  while(flag("flag_forest_patrol_combat") == 0) {
    self waittill("subgoal", patharrayindex);

    if(patharrayindex == 8) {
      namespace_191bb1c1589b3acb::function_cbae8968087844c2();
      break;
    } else {
      waitframe();
    }

    wait 1;
  }

  level utility::flag_set("flag_forest_patrol_enemies_continue_right");
}

function function_9196d2dd4bec3a3d() {
  level.player endon("death");
  level endon("flag_forest_patrol_enemies_passed");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_sniper_complete");

  while(true) {
    anycansee = function_8ce5803b7d377d72(level.player);
    maxthreat = function_910a912f327b8d34(level.player);

    if(istrue(anycansee) && maxthreat > 0) {
      break;
    }

    wait 0.1;
  }

  level utility::flag_set("flag_forest_patrol_enemies_curious");
}

function function_eec7bc2ee7e5f66d() {
  self endon("death");
  level.player endon("death");
  level endon("flag_forest_sniper_complete");

  while(true) {
    self waittill("damage", amount, attacker);

    if(isDefined(attacker) && isPlayer(attacker)) {
      ent_flag_set("flag_forest_patrol_enemy_damaged_by_player");
      level utility::flag_set("flag_forest_patrol_enemies_one_damaged");
      break;
    }

    waitframe();
  }
}

function function_978b9838e46a676a(a_ai_enemies) {
  level.player endon("death");
  level endon("flag_forest_patrol_combat");
  self endon("flag_forest_patrol_enemy_passed");
  level endon("flag_forest_sniper_complete");
  var_1e4c41a5dcdf5b1e = squared(512);
  self waittill("death");
  event = spawnStruct();
  event.type = "investigate";
  event.typeorig = "found_corpse";
  event.origin = self.origin;
  event.investigate_pos = self.origin;
  a_ai_enemies = utility::array_removedead_or_dying(a_ai_enemies);

  if(a_ai_enemies.size == 0) {
    if(isDefined(self)) {
      ent_flag_set("flag_forest_patrol_enemy_passing_left");
      ent_flag_set("flag_forest_patrol_enemy_passing_right");
      ent_flag_set("flag_forest_patrol_enemy_passed");
    }

    return;
  }

  a_ai_enemies = sortbydistancecullbyradius(a_ai_enemies, event.origin, 768);

  if(a_ai_enemies.size == 0) {
    if(isDefined(self)) {
      ent_flag_set("flag_forest_patrol_enemy_passing_left");
      ent_flag_set("flag_forest_patrol_enemy_passing_right");
      ent_flag_set("flag_forest_patrol_enemy_passed");
    }

    return;
  }

  for(i = 0; i < a_ai_enemies.size; i++) {
    if(isDefined(a_ai_enemies[i]) && isalive(a_ai_enemies[i])) {
      n_dist_sq = distance2dsquared(a_ai_enemies[i].origin, event.origin);

      if(n_dist_sq < var_1e4c41a5dcdf5b1e) {
        if(a_ai_enemies[i] ent_flag("flag_forest_patrol_enemy_passed")) {
          a_ai_enemies[i] ent_flag_set("flag_forest_patrol_enemy_force_alert");
        } else {
          a_ai_enemies[i] enemy::bt_event_investigate(event);
        }
      } else {
        a_ai_enemies[i] enemy::bt_event_investigate(event);
      }

      wait randomfloatrange(1, 3);
    }
  }
}

function function_db036cedffb02429() {
  self endon("death");
  ent_flag_wait("flag_forest_patrol_reached_path_end");
  thread function_33ca9e74d13d95be();
}

function function_b7a030bd256eed85() {
  self endon("death");
  self endon("flag_forest_patrol_enemy_passed");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_sniper_complete");

  while(true) {
    b_fov = utility::within_fov(level.player getEye(), level.player getplayerangles(), self getEye(), cos(22.5));
    n_dist_sq = distance2dsquared(level.player.origin, self.origin);
    n_mult = 1;

    if(istrue(level.player.var_a06a453770252116)) {
      n_mult *= 1.25;
    }

    if(istrue(level.player utility::isads())) {
      n_mult *= 1.25;
    }

    var_d324ff51b63d4eb0 = 147456 * n_mult;
    var_2e93751c141c7a5 = 589824 * n_mult;

    if(n_dist_sq < var_d324ff51b63d4eb0 || b_fov && n_dist_sq < var_2e93751c141c7a5) {
      break;
    }

    wait 0.2;
  }

  level utility::flag_set("flag_forest_patrol_see_enemies");
}

function function_92f66e5a5870cb53(a_ai_enemies) {
  level.player endon("death");
  level endon("flag_forest_patrol_combat");

  if(utility::flag("flag_forest_patrol_combat")) {
    return;
  }

  b_warning = 0;
  level utility::flag_wait("flag_forest_patrol_03");

  if(level.player issprinting()) {
    namespace_8339f6377b6ba60e::function_2f27432f2f94a830(a_ai_enemies, level.player.origin);
    b_warning = 1;
  }

  level utility::flag_wait("flag_forest_patrol_04");

  if(level.player issprinting()) {
    if(istrue(b_warning)) {
      level utility::flag_set("flag_forest_patrol_combat");
    } else {
      namespace_8339f6377b6ba60e::function_2f27432f2f94a830(a_ai_enemies, level.player.origin);
      b_warning = 1;
    }
  }

  level utility::flag_wait("flag_forest_patrol_05");

  if(level.player issprinting()) {
    if(istrue(b_warning)) {
      level utility::flag_set("flag_forest_patrol_combat");
      return;
    }

    namespace_8339f6377b6ba60e::function_2f27432f2f94a830(a_ai_enemies, level.player.origin);
  }
}

function function_86f1aa3ac6af75c() {
  level.player endon("death");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_enemies_passed");
  level utility::flag_wait("flag_forest_patrol_enemies_passing_right");

  while(!level utility::flag("flag_forest_patrol_left")) {
    wait 0.1;
  }

  level utility::flag_set("flag_forest_patrol_enemies_passed");
}

function function_78e3814fa6a8d154(a_ai_enemies, var_7537a1c8763c74ab, var_ef2ce443bff9166c) {
  level endon(var_ef2ce443bff9166c);

  if(level flag(var_ef2ce443bff9166c)) {
    return;
  }

  level endon("flag_forest_sniper_complete");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_enemies_passed");
  function_ed997e7ce2ee5fa7(a_ai_enemies, var_7537a1c8763c74ab);
  level utility::flag_set(var_ef2ce443bff9166c);
}

function function_ed997e7ce2ee5fa7(var_94d08343de33ee25, str_flag) {
  level endon("flag_forest_sniper_complete");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_patrol_enemies_passed");
  var_94d08343de33ee25 = utility::array_removedead_or_dying(var_94d08343de33ee25);

  if(var_94d08343de33ee25.size == 0) {
    return;
  }

  foreach(ai in var_94d08343de33ee25) {
    if(ai ent_flag(str_flag)) {
      var_94d08343de33ee25 = utility::array_remove(var_94d08343de33ee25, ai);
    }
  }

  if(var_94d08343de33ee25.size == 0) {
    return;
  }

  countstruct = spawnStruct();
  countstruct.n_count = 0;
  var_c3c0a870325fe9dd = var_94d08343de33ee25.size;
  array_thread(var_94d08343de33ee25, &function_6ce5770876ed78f6, countstruct, str_flag);

  while(true) {
    if(countstruct.n_count >= var_c3c0a870325fe9dd) {
      break;
    }

    wait 0.5;
  }
}

function function_6ce5770876ed78f6(countstruct, str_flag) {
  while(isDefined(self) && isalive(self)) {
    if(ent_flag(str_flag)) {
      break;
    }

    wait 0.1;
  }

  countstruct.n_count++;
}

function function_5812af1fe9fc448f() {
  self endon("death");
  level endon("flag_forest_patrol_combat");
  level endon("flag_forest_sniper_complete");
  ai_ally = undefined;
  var_1e4c41a5dcdf5b1e = squared(192);

  while(true) {
    ai_ally = utility::getclosest(self.origin, level.tundra_allies, 320);

    if(isDefined(ai_ally)) {
      n_dist_sq = distance2dsquared(self.origin, ai_ally.origin);
      b_can_see = self cansee(ai_ally);
      var_409dd0e83c88da2b = ai_ally utility::ent_flag("flag_forest_patrol_ally_crossing_left");
      var_6a7f0e8ae27c7d67 = istrue(ent_flag_exist("flag_forest_patrol_enemy_passed") && ent_flag("flag_forest_patrol_enemy_passed"));

      if(n_dist_sq < var_1e4c41a5dcdf5b1e) {
        if(istrue(var_6a7f0e8ae27c7d67)) {
          namespace_8339f6377b6ba60e::function_2f27432f2f94a830([self], ai_ally.origin);
          wait randomfloatrange(4, 6);
        } else {
          level utility::flag_set("flag_forest_patrol_combat");
        }
      } else if(istrue(b_can_see)) {
        if(istrue(var_409dd0e83c88da2b) || istrue(var_6a7f0e8ae27c7d67)) {
          namespace_8339f6377b6ba60e::function_2f27432f2f94a830([self], ai_ally.origin);
          wait randomfloatrange(4, 6);
        } else {
          level utility::flag_set("flag_forest_patrol_combat");
        }
      } else if(!istrue(var_409dd0e83c88da2b) && !istrue(var_6a7f0e8ae27c7d67)) {
        namespace_8339f6377b6ba60e::function_2f27432f2f94a830([self], ai_ally.origin);
        wait randomfloatrange(4, 6);
      }
    }

    wait 1;
  }
}

function function_fe1be40f59b61549(a_ai_enemies) {
  level.player endon("death");
  level endon("flag_forest_sniper_complete");
  level endon("flag_forest_patrol_enemies_dead");
  msg = level utility::flag_wait_any_return("flag_forest_patrol_combat", "stealth_spotted", "flag_forest_sniper_warning_shot");
  level utility::flag_set("flag_forest_patrol_combat");
  level thread utility::flag_set_delayed("flag_forest_patrol_enemies_nerf", randomfloatrange(4, 6));
  a_ai_enemies = utility::array_removedead_or_dying(a_ai_enemies);

  if(a_ai_enemies.size == 0) {
    return;
  }

  foreach(ai in a_ai_enemies) {
    if(ai ent_flag_exist("flag_forest_patrol_enemy_passed") && ai ent_flag("flag_forest_patrol_enemy_passed")) {
      a_ai_enemies = utility::array_remove(a_ai_enemies, ai);
    }
  }

  if(a_ai_enemies.size == 0) {
    return;
  }

  a_ai_enemies = sortbydistance(a_ai_enemies, level.player.origin);

  for(i = 0; i < a_ai_enemies.size; i++) {
    wait randomfloatrange(0.1, 0.3);
    ai_enemy = a_ai_enemies[i];

    if(isDefined(ai_enemy) && isalive(ai_enemy)) {
      if(ai_enemy utility::ent_flag_exist("flag_forest_patrol_enemy_passed") && ai_enemy utility::ent_flag("flag_forest_patrol_enemy_passed")) {
        continue;
      }

      ai_enemy utility::enable_stealth_for_ai(0);
      ai_enemy.dontevershoot = 0;
      ai_enemy.dontattackme = 0;
      ai_enemy getenemyinfo(level.player);
    }
  }
}

function function_d8301d646b1bbbe8() {}

function function_49108ebe658c26d5() {
  namespace_8339f6377b6ba60e::function_4c28f0141619d61a();
  utility::set_start_location("s_start_forest_sniper", utility::array_add(level.tundra_allies, level.player));
  function_e202fd10c4a3259e("s_start_forest_sniper");
  level.shepherd enabletraversals(0);
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_forest_stop_nags", "forest_player_progress", "trig_forest");
  level thread function_de1f6c55da055ca9(1);
  level.player setmovespeedscale(0.95);
  level thread namespace_191bb1c1589b3acb::function_84746c3250d67674();
}

function function_ea79d7ed7869b0e() {
  utility::autosave_tactical();
  battlechatter_off("axis");

  level thread namespace_8339f6377b6ba60e::function_9a2b6bf96312f577("<dev string:x153>", "<dev string:x161>");

  level utility::flag_clear("stealth_spotted");
  level utility::flag_set("flag_forest_stop_nags");
  level.player utility::blend_movespeedscale(0.95, 2);
  level thread function_b77bc1517b130e75();
  namespace_8339f6377b6ba60e::function_6123dca297db2375("med", "decrease");
  level thread namespace_191bb1c1589b3acb::function_f19c04049620116f();
  level thread function_80e5e897d6704fa9();
  level.ai_forest_sniper_enemy = namespace_8339f6377b6ba60e::function_56341edc24e9bec6("ai_forest_sniper_enemy", level.player, 0, 1);
  waitframe();
  level.ai_forest_sniper_enemy utility::set_battlechatter(0);
  level thread function_546fc027061fcd01("flag_forest_sniper_08", "flag_forest_sniper_complete", [level.ai_forest_sniper_enemy], ["flag_forest_sniper_enemy_dead", "flag_forest_sniper_enemy_longdeath"], 519);
  waitframe();
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_5a2cf70848a11dfe("s_forest_sniper_teleport_front", 1, "flag_forest_sniper_warning_shot", 4, "flag_forest_sniper_enemy_longdeath", "flag_forest_sniper_complete");
  level.ai_forest_sniper_enemy function_5d4d0bd8429c2f3f();
  level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_forest_stop_nags");
  level.ai_forest_sniper_enemy namespace_8339f6377b6ba60e::function_30baf67535ddaef0(level.player);
  level.ai_forest_sniper_enemy namespace_8339f6377b6ba60e::function_47215dde740a0bc2(level.soap);
  level.ai_forest_sniper_enemy namespace_8339f6377b6ba60e::function_fadc9e448be9a11b(level.gaz);
  level.ai_forest_sniper_enemy namespace_8339f6377b6ba60e::function_fadc9e448be9a11b(level.shepherd);
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_b4009ab2b713e380("vol_forest_sniper_enemy_mid", "vol_forest_sniper_enemy_back", "vol_forest_sniper_enemy_back", "flag_forest_sniper_03", "flag_forest_sniper_04", "flag_forest_sniper_05");
  level thread function_974688c9fccf2ad(level.ai_forest_sniper_enemy);
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_bfefcf7f0f787590("flag_forest_sniper_player_hit_by_enemy");
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_e6f00fe079d3a907("flag_forest_sniper_player_sees_enemy", 0.5, 384, 2048, 0.15);
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_22a4d67da6989229();
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_fd943d3e52bfb3b5();
  level.ai_forest_sniper_enemy thread function_4b33e30d28a427eb();
  level.ai_forest_sniper_enemy function_b59f57d948b9c744(5000, 10000);
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_179379219983f831();
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_b003291882aac5c();
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_9588cd6285c622a7();
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_4fbb2fb25c0ad91("flag_forest_sniper_enemy_hit_by_player");
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_30c5a9670baa5108("flag_forest_sniper_enemy_dead", 1, 0, undefined, 1);
  level.ai_forest_sniper_enemy thread namespace_8339f6377b6ba60e::function_e8021510002c6190();
  level.ai_forest_sniper_enemy thread function_3ba528462f83147a("flag_forest_sniper_04");
  level thread namespace_8339f6377b6ba60e::function_fb70fda5f8b5e23(level.ai_forest_sniper_enemy, "flag_forest_field_01");
  level.ai_forest_sniper_enemy thread function_4fb4ca3abb9e5d65();
  msg = level utility::flag_wait_any_return("flag_forest_sniper_enemy_dead", "flag_forest_sniper_complete");

  if(msg == "flag_forest_sniper_complete") {
    if(level utility::flag("flag_forest_sniper_enemy_longdeath") && isDefined(level.ai_forest_sniper_enemy) && isalive(level.ai_forest_sniper_enemy)) {
      level.ai_forest_sniper_enemy kill();
    }
  }

  wait 1;
  level.ai_forest_sniper_enemy = undefined;
  level thread function_b7425eb6761956a1();
  level.var_2f9f697bc727f253 = [];
  level thread function_d30d567259a4e5cc();
  level utility::flag_clear("flag_forest_stop_nags");
  namespace_8339f6377b6ba60e::function_718f6388e43588d7();
  function_e202fd10c4a3259e("s_start_forest_field");
  namespace_8339f6377b6ba60e::function_cd1c0f72e3a0db9a(1);

  foreach(ally in level.tundra_allies) {
    ally namespace_8339f6377b6ba60e::function_c9317b6d58796509(1, "cqb");
    ally.var_51642e27c7e7d224 = 0;
  }

  level utility::flag_wait("flag_forest_sniper_complete");
  namespace_8339f6377b6ba60e::function_6123dca297db2375("easy", "reset");
  level.player utility::blend_movespeedscale_default(2);
}

function function_39983a9cf152f047() {
  level utility::flag_set("flag_forest_sniper_complete");
  level utility::flag_set("flag_forest_obj_sniper");
  level utility::flag_set("flag_forest_obj_sniper_complete");
}

function function_4fb4ca3abb9e5d65() {
  level.player endon("death");
  self endon("death");
  level endon("flag_forest_sniper_complete");

  if(utility::flag("flag_forest_sniper_complete")) {
    return;
  }

  gameskill = level.player utility::get_player_gameskill();

  switch (gameskill) {
    case 3:
    case 4:
      var_7328a039ebfe42ce = "flag_sniper_vol_mid";
      break;
    case 1:
    case 2:
      var_7328a039ebfe42ce = "flag_sniper_vol_back";
      break;
    case 0:
    default:
      var_7328a039ebfe42ce = "flag_sniper_no_retreat";
      break;
  }

  utility::ent_flag_wait_either("flag_sniper_damaged_by_primary", var_7328a039ebfe42ce);
  namespace_8339f6377b6ba60e::function_6123dca297db2375("hard", "decrease");
}

function function_80e5e897d6704fa9() {
  level.player endon("death");
  level endon("flag_forest_sniper_enemy_dead");
  level utility::flag_wait_any("flag_forest_sniper_allies_use_colors", "flag_forest_sniper_01");

  if(level utility::flag("flag_forest_patrol_combat") && !level utility::flag("flag_forest_patrol_enemies_dead")) {
    level utility::flag_wait_any("flag_forest_patrol_enemies_dead", "flag_forest_sniper_03");
  }

  level utility::flag_wait("flag_forest_patrol_allies_exiting");
  level utility::flag_set("flag_forest_sniper_allies_use_colors");

  foreach(ally in level.tundra_allies) {
    ally namespace_8339f6377b6ba60e::function_83e7e4b9d5f7bdb(1, 1, 1);

    switch (ally.animname) {
      case #"hash_df31f98a0b34e496":
        ally namespace_8339f6377b6ba60e::function_c9317b6d58796509(0, "sprint");
        ally thread function_d9f61f4473183685();
        break;
      default:
        ally namespace_8339f6377b6ba60e::function_c9317b6d58796509(1, "cqb");
        break;
    }

    ally.var_51642e27c7e7d224 = 1;
  }

  namespace_8339f6377b6ba60e::function_c43c63bffb8327b2();
  waitframe();
  namespace_8339f6377b6ba60e::function_26ec77b7dfe68c94();
  utility::activate_trigger_with_targetname("trig_forest_sniper_allies_01");
  level utility::flag_wait("flag_forest_sniper_02");
  namespace_8339f6377b6ba60e::function_733e78a23a1aafb9(5, 0, 2);
  utility::activate_trigger_with_targetname("trig_forest_sniper_allies_02");
  level utility::flag_wait("flag_forest_sniper_03");
  utility::activate_trigger_with_targetname("trig_forest_sniper_allies_03");
  level utility::flag_wait("flag_forest_sniper_04");
  utility::activate_trigger_with_targetname("trig_forest_sniper_allies_04");
  level utility::flag_wait("flag_forest_sniper_05");
  utility::activate_trigger_with_targetname("trig_forest_sniper_allies_05");
  level utility::flag_wait("flag_forest_sniper_06");
  utility::activate_trigger_with_targetname("trig_forest_sniper_allies_06");
  level utility::flag_wait("flag_forest_sniper_08");
  utility::activate_trigger_with_targetname("trig_forest_sniper_allies_07");
}

function function_d9f61f4473183685() {
  self endon("death");
  level.player endon("death");

  while(true) {
    if(flag("flag_forest_sniper_enemy_dead") || flag("flag_forest_sniper_complete")) {
      break;
    }

    if(isDefined(self.enemy)) {
      if(istrue(self.enemy.dontattackme) && !istrue(self.var_43ae9f4734246fb0)) {
        self.var_43ae9f4734246fb0 = 1;
      } else if(istrue(self.var_43ae9f4734246fb0)) {
        self.var_43ae9f4734246fb0 = 0;
      }
    } else if(!istrue(self.var_43ae9f4734246fb0)) {
      self.var_43ae9f4734246fb0 = 1;
    }

    wait 0.1;
  }

  self.var_43ae9f4734246fb0 = 0;
}

function function_5d4d0bd8429c2f3f() {
  self endon("death");
  self endon("long_death");
  level.player endon("death");
  level utility::flag_wait("flag_forest_sniper_01");
  namespace_191bb1c1589b3acb::function_1c647c1a523facb5();
  v_offset = (0, 0, 32);
  my_node = self getcovernode();

  if(isDefined(my_node)) {
    if(issubstr(my_node.type, "Left")) {
      v_offset = anglestoright(my_node.angles) * 32;
    } else if(issubstr(my_node.type, "Right")) {
      v_offset = anglestoleft(my_node.angles) * 32;
    }
  }

  var_6774ee709d347c7 = self getEye() + v_offset;
  var_233e915b5e3f9b42 = level.player getEye() + (randomintrange(-48, 48), randomintrange(-48, 48), randomintrange(16, 24));
  thread utility::play_sound_in_space("sniper_crack_far_far", var_6774ee709d347c7);
  utility::delaythread(0.1, &utility::play_sound_in_space, "sniperLrg_super_whiz_near", level.player getEye());
  magicbullet("iw9_sn_alpha50_sp", var_6774ee709d347c7, var_233e915b5e3f9b42, self);
  level utility::flag_set("flag_forest_sniper_warning_shot");
}

function private function_b77bc1517b130e75() {
  wait 1;
  namespace_8339f6377b6ba60e::function_cd1c0f72e3a0db9a(0);
}

function function_47e2ee9671a268d0() {}

function function_1a19c58671092238() {
  namespace_8339f6377b6ba60e::function_4c28f0141619d61a();
  utility::set_start_location("s_start_forest_field", utility::array_add(level.tundra_allies, level.player));
  function_e202fd10c4a3259e("s_start_forest_field");
  level.shepherd enabletraversals(0);
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_forest_stop_nags", "forest_player_progress", "trig_forest");
  level thread function_b7425eb6761956a1();
  level thread namespace_191bb1c1589b3acb::function_84746c3250d67674();
  level.var_2f9f697bc727f253 = [];
  level thread function_d30d567259a4e5cc();
  level.player setmovespeedscale(1);
}

function function_bd7e85ffb13a8811() {
  utility::autosave_by_name();
  utility::battlechatter_on("axis");
  exploder("vfx_car_steam");

  level thread namespace_8339f6377b6ba60e::function_9a2b6bf96312f577("<dev string:x17d>", "<dev string:x18a>");

  level utility::flag_clear("stealth_spotted");
  level utility::flag_set("flag_forest_stop_nags");
  level thread function_de1f6c55da055ca9(1);
  level thread function_de0d161007e32080();
  namespace_8339f6377b6ba60e::function_6123dca297db2375("easy", "reset");
  utility::flag_set("flag_forest_obj_sniper_trigger_end");
  level thread namespace_191bb1c1589b3acb::function_a3b894933a5fd560();
  utility::activate_trigger_with_targetname("trig_forest_field_allies_start");
  utility::array_thread(level.tundra_allies, &function_7b8e5c576d5a71c1);
  level thread function_a8797ac527a83c64();
  level thread function_85876e218f28af42();
  level thread function_ccdc726c877161d5();
  level thread function_4847a67a9868d55e();
  level utility::flag_wait("flag_forest_field_01");
  level thread function_b4ea22308072139b();
  level utility::flag_wait("flag_forest_field_shack_enemies_combat");
  level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_forest_stop_nags");
  level scripts\sp\stealth\utility::sixthsense_enable(0);
  msg = level utility::flag_wait_any_return("flag_forest_field_complete", "flag_forest_field_sniper_all_dead");
  level utility::flag_set("flag_forest_field_allies_buddy_follow_stop");

  if(msg == "flag_forest_field_complete") {
    level thread function_ebb1b4f9aec0f366();
  }

  wait 0.5;
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_forest_stop_nags", "forest_player_progress", "trig_forest");
  namespace_8339f6377b6ba60e::function_26ec77b7dfe68c94();
  utility::array_thread(level.tundra_allies, &function_ddae8aa32229ecd7);
  namespace_8339f6377b6ba60e::function_6123dca297db2375("easy", "reset");
  level thread function_7ae9bff3eaac1aa9();
  battlechatter_on("axis");
}

function function_7aebd8c76bfd6ebe() {
  level utility::flag_set("flag_forest_field_complete");
  level utility::flag_set("flag_forest_field_sniper_all_dead");
  level utility::flag_set("flag_forest_field_allies_moving_to_exit");
  level utility::flag_set("flag_forest_obj_secondary_route");
  level utility::flag_set("flag_forest_obj_field_snipers");
  level utility::flag_set("flag_forest_obj_field_snipers_complete");
}

function function_7ae9bff3eaac1aa9() {
  level.player endon("death");

  while(true) {
    if(level utility::flag("flag_forest_field_sniper_all_dead") || level utility::flag("flag_forest_field_beyond_complete")) {
      break;
    }

    wait 1;
  }

  scripts\engine\sp\utility::remove_extra_autosave_check("autosave_forest_field_snipers");
  wait 1;

  if(!level utility::flag("game_saving")) {
    utility::autosave_by_name();
  }
}

function function_ebb1b4f9aec0f366() {
  level.player endon("death");
  wait 1;
  level.var_2f9f697bc727f253 = utility::array_removedead_or_dying(level.var_2f9f697bc727f253);

  if(level.var_2f9f697bc727f253.size == 0) {
    return;
  }

  level.var_2f9f697bc727f253 = sortbydistance(level.var_2f9f697bc727f253, level.player.origin);

  foreach(sniper in level.var_2f9f697bc727f253) {
    if(isDefined(sniper) && isalive(sniper)) {
      sniper setthreatbiasgroup();
      sniper set_baseaccuracy(5);
      sniper set_attackeraccuracy(5);
      sniper set_ignoreme(0);
      sniper.dontattackme = 0;

      if(cointoss()) {
        sniper getenemyinfo(level.player);
      } else {
        sniper set_favoriteenemy(level.player);
      }

      ai_ally = utility::getclosest(sniper.origin, level.tundra_allies);

      if(isDefined(ai_ally)) {
        ai_ally getenemyinfo(sniper);
      }

      wait randomfloatrange(0.5, 1.5);
    }
  }
}

function function_4847a67a9868d55e() {
  level.player endon("death");
  level endon("flag_forest_field_allies_buddy_follow_stop");
  level utility::flag_wait("flag_forest_field_allies_spread_out");
  namespace_8339f6377b6ba60e::function_26ec77b7dfe68c94();
  waitframe();
  namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
  level thread function_7859d4bc99bbd134();
  level thread function_54d6d4bc4e15ef0c();
  str_flag = function_92c8030e11f076f2();

  switch (str_flag) {
    case #"hash_9eb54d72b768cae8":
      if(level flag("flag_forest_field_left")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_left_01");
      } else if(level flag("flag_forest_field_right")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_right_01");
      } else {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_01");
      }

      level utility::flag_wait("flag_forest_field_02");
      namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
      level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("forest_player_progress");
    case #"hash_9eb55072b768cfa1":
      if(level flag("flag_forest_field_left")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_left_02");
      } else if(level flag("flag_forest_field_right")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_right_02");
      } else {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_02");
      }

      level utility::flag_wait("flag_forest_field_03");
      namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
      level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("forest_player_progress");
    case #"hash_9eb54f72b768ce0e":
      if(level flag("flag_forest_field_left")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_left_03");
      } else if(level flag("flag_forest_field_right")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_right_03");
      } else {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_03");
      }

      level utility::flag_wait("flag_forest_field_04");
      namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
      level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("forest_player_progress");
    case #"hash_9eb55272b768d2c7":
      if(level flag("flag_forest_field_left")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_left_04");
      } else if(level flag("flag_forest_field_right")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_right_04");
      } else {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_04");
      }

      level utility::flag_wait("flag_forest_field_05");
      namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
      level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("forest_player_progress");
    case #"hash_9eb55172b768d134":
      if(level flag("flag_forest_field_left")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_left_05");
      } else if(level flag("flag_forest_field_right")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_right_05");
      } else {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_05");
      }

      level utility::flag_wait("flag_forest_field_06");
      namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
      level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("forest_player_progress");
    case #"hash_9eb55472b768d5ed":
      if(level flag("flag_forest_field_left")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_left_06");
      } else if(level flag("flag_forest_field_right")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_right_06");
      } else {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_06");
      }

      level utility::flag_wait("flag_forest_field_07");
      namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
      level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("forest_player_progress");
    case #"hash_9eb55372b768d45a":
      if(level flag("flag_forest_field_left")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_left_07");
      } else if(level flag("flag_forest_field_right")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_right_07");
      } else {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_07");
      }

      level utility::flag_wait("flag_forest_field_08");
      namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
      level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("forest_player_progress");
    case #"hash_9eb54672b768bfe3":
      if(level flag("flag_forest_field_left")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_left_08");
      } else if(level flag("flag_forest_field_right")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_right_08");
      } else {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_08");
      }

      level utility::flag_wait("flag_forest_field_09");
      namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
      level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("forest_player_progress");
    case #"hash_9eb54572b768be50":
      if(level flag("flag_forest_field_left")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_left_09");
      } else if(level flag("flag_forest_field_right")) {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_right_09");
      } else {
        utility::activate_trigger_with_targetname("trig_forest_field_allies_09");
      }

      level utility::flag_wait("flag_forest_field_10");
      namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
      level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("forest_player_progress");
    case #"hash_9eb1c872b765baf2":
      utility::activate_trigger_with_targetname("trig_forest_field_allies_10");
      break;
  }
}

function function_54d6d4bc4e15ef0c() {
  level.player endon("death");
  level endon("flag_forest_field_complete");
  level endon("flag_forest_field_sniper_one_remaining");
  var_a330743b2a4cb889 = 4096;
  var_b8967a4e53f38b20 = 3;
  last_ally = undefined;

  while(true) {
    if(level.player isads()) {
      wait 1;
      continue;
    }

    target_ally = undefined;
    a_ai_allies = sortbydistance(level.tundra_allies, level.player.origin);

    if(isDefined(last_ally)) {
      a_ai_allies = array_remove(a_ai_allies, last_ally);
      a_ai_allies[a_ai_allies.size] = last_ally;
    }

    for(i = 0; i < a_ai_allies.size; i++) {
      var_865048328835e385 = within_fov(level.player getEye(), level.player getplayerangles(), a_ai_allies[i] getEye(), cos(45));

      if(istrue(var_865048328835e385)) {
        target_ally = a_ai_allies[i];
        break;
      }
    }

    if(!isDefined(target_ally)) {
      wait 1;
      continue;
    }

    var_fb3cefb948f2d980 = array_removedead_or_dying(level.var_2f9f697bc727f253);
    var_fb3cefb948f2d980 = sortbydistance(var_fb3cefb948f2d980, level.player.origin);
    var_fb3cefb948f2d980 = array_reverse(var_fb3cefb948f2d980);
    targeting_sniper = undefined;

    for(i = 0; i < var_fb3cefb948f2d980.size; i++) {
      var_865048328835e385 = within_fov(level.player getEye(), level.player getplayerangles(), var_fb3cefb948f2d980[i] getEye(), cos(45));
      var_f19384f5166912ab = 0;

      if(isDefined(var_fb3cefb948f2d980[i].var_fa8c6ee684b9e0ff)) {
        var_f19384f5166912ab = function_c89ed1840c8d0f0f(gettime() - var_fb3cefb948f2d980[i].var_fa8c6ee684b9e0ff) < var_b8967a4e53f38b20;
      }

      if(!istrue(var_865048328835e385) && !istrue(var_f19384f5166912ab)) {
        targeting_sniper = var_fb3cefb948f2d980[i];
        break;
      }
    }

    if(!isDefined(targeting_sniper)) {
      wait 1;
      continue;
    }

    var_6774ee709d347c7 = targeting_sniper getEye() + (0, 0, 64);
    var_85b177c2727a7562 = target_ally getEye() + (randomintrange(-48, 48), randomintrange(-48, 48), randomintrange(-48, 48));
    trace = scripts\engine\trace::ray_trace(var_6774ee709d347c7, var_85b177c2727a7562, undefined);
    var_18803bfffd95e45d = distance2dsquared(trace["position"], target_ally getEye());

    if(isDefined(trace["entity"]) || var_18803bfffd95e45d > var_a330743b2a4cb889) {
      var_4d364c0036f0c82d = anglesToForward(vectortoangles(targeting_sniper.origin - target_ally.origin)) * 64;
      var_233e915b5e3f9b42 = target_ally.origin + var_4d364c0036f0c82d + (randomintrange(-48, 48), randomintrange(-48, 48), 0);
    } else {
      var_233e915b5e3f9b42 = trace["position"];
    }

    thread utility::play_sound_in_space("sniper_crack_far_far", var_6774ee709d347c7);
    magicbullet("iw9_sn_alpha50_sp", var_6774ee709d347c7, var_233e915b5e3f9b42, targeting_sniper);
    last_ally = target_ally;
    targeting_sniper.var_fa8c6ee684b9e0ff = gettime();
    wait randomfloatrange(3, 8);
  }
}

function function_92c8030e11f076f2() {
  str_flag = "flag_forest_field_01";

  if(level flag("flag_forest_field_10")) {
    str_flag = "flag_forest_field_10";
  } else if(level flag("flag_forest_field_09")) {
    str_flag = "flag_forest_field_09";
  } else if(level flag("flag_forest_field_08")) {
    str_flag = "flag_forest_field_08";
  } else if(level flag("flag_forest_field_07")) {
    str_flag = "flag_forest_field_07";
  } else if(level flag("flag_forest_field_06")) {
    str_flag = "flag_forest_field_06";
  } else if(level flag("flag_forest_field_05")) {
    str_flag = "flag_forest_field_05";
  } else if(level flag("flag_forest_field_04")) {
    str_flag = "flag_forest_field_04";
  } else if(level flag("flag_forest_field_03")) {
    str_flag = "flag_forest_field_03";
  } else if(level flag("flag_forest_field_02")) {
    str_flag = "flag_forest_field_02";
  }

  return str_flag;
}

function function_7859d4bc99bbd134() {
  level.player endon("death");
  level endon("flag_forest_field_complete");
  level endon("flag_forest_field_sniper_all_dead");
  level utility::flag_wait_or_timeout("flag_forest_field_sniper_one_dead", 60);

  if(level flag("flag_forest_field_sniper_one_dead")) {
    level utility::flag_wait_any_timeout(30, "flag_forest_field_shack_transport_destroyed", "flag_forest_field_05");
  }

  var_fb3cefb948f2d980 = level.var_2f9f697bc727f253;
  a_ai_allies = [level.soap, level.gaz];
  var_257420aff01d4700 = 2560;
  var_e8f248df0cdc6a4e = 45;
  var_387c1bcfb4cd98b4 = 5;
  var_f702381a60199c14 = 15;
  var_994feef463f139c = 30;
  var_731f86ed8b389da5 = squared(384);

  while(true) {
    var_fb3cefb948f2d980 = array_removedead_or_dying(var_fb3cefb948f2d980);

    if(var_fb3cefb948f2d980.size == 0) {
      return;
    }

    var_26d94b37e19113b9 = undefined;
    ai_target = undefined;

    foreach(ai_ally in a_ai_allies) {
      if(isDefined(ai_ally.var_b94ff5dee9271b60) && function_c89ed1840c8d0f0f(gettime() - ai_ally.var_b94ff5dee9271b60) < var_e8f248df0cdc6a4e) {
        continue;
      }

      if(utility::within_fov_of_players(ai_ally getEye(), cos(45))) {
        continue;
      }

      var_fb3cefb948f2d980 = sortbydistancecullbyradius(var_fb3cefb948f2d980, ai_ally.origin, var_257420aff01d4700);

      if(var_fb3cefb948f2d980.size == 0) {
        continue;
      } else if(var_fb3cefb948f2d980.size > 1) {
        var_fb3cefb948f2d980 = array_sort_with_func(var_fb3cefb948f2d980, &function_6f9550218f9e01b0);
      }

      if(distance2dsquared(level.player.origin, var_fb3cefb948f2d980[0].origin) < var_731f86ed8b389da5) {
        continue;
      }

      ai_target = var_fb3cefb948f2d980[0];
      var_26d94b37e19113b9 = ai_ally;
      break;
    }

    if(isDefined(var_26d94b37e19113b9) && isDefined(ai_target)) {
      dist = randomfloatrange(32, 64);
      dir = flatten_vector(randomvector(1));
      var_376eb5d9559cdb16 = ai_target.origin + dir * dist;
      var_376eb5d9559cdb16 = getclosestpointonnavmesh(var_376eb5d9559cdb16);
      grenade_source = var_26d94b37e19113b9 getEye();
      n_dist = distance2d(var_26d94b37e19113b9.origin, ai_target.origin) * 0.5;
      var_f44cd2ccd2d6328e = anglesToForward(vectortoangles(grenade_source - var_376eb5d9559cdb16)) * n_dist;
      var_ece098d419ba8e83 = var_376eb5d9559cdb16 + var_f44cd2ccd2d6328e + (0, 0, n_dist);
      launchvelocity = var_376eb5d9559cdb16 - var_ece098d419ba8e83;
      n_fuse_time = 1 + n_dist / 500;
      grenade = magicgrenademanual("flash", var_ece098d419ba8e83, launchvelocity, n_fuse_time);

      if(isDefined(grenade)) {
        iprintln(var_26d94b37e19113b9.name + "<dev string:x1a5>" + ai_target.targetname);

        var_26d94b37e19113b9.var_b94ff5dee9271b60 = gettime();
        level notify("forest_field_ally_threw_flashbang", var_26d94b37e19113b9);

        if(utility::flag("flag_forest_field_sniper_one_remaining")) {
          wait randomfloatrange(var_387c1bcfb4cd98b4, var_f702381a60199c14);
        } else {
          msg = level utility::waittill_notify_or_timeout_return("flag_forest_field_sniper_one_remaining", randomfloatrange(var_f702381a60199c14, var_994feef463f139c));

          if(msg == "flag_forest_field_sniper_one_remaining") {
            wait randomfloatrange(var_387c1bcfb4cd98b4, var_f702381a60199c14);
          }
        }
      }
    }

    wait 1;
  }
}

function function_b4ea22308072139b() {
  level.player endon("death");
  level endon("flag_forest_field_shack_enemies_combat");

  if(utility::flag("flag_forest_field_shack_enemies_combat")) {
    return;
  }

  msg = level utility::flag_wait_any_return("flag_forest_field_04", "flag_forest_field_05");

  if(msg == "flag_forest_field_04" && !level.player issprinting()) {
    level utility::flag_wait("flag_forest_field_05");
  }

  excluder = utility::get_living_ai("ai_forest_field_enemy_sniper_cliff", "targetname");
  ai_enemy = utility::get_closest_ai_exclude(level.player.origin, "axis", [excluder]);

  if(isDefined(ai_enemy) && isalive(ai_enemy) && ai_enemy utility::ent_flag_exist("stealth_enabled") && ai_enemy utility::ent_flag("stealth_enabled")) {
    namespace_8339f6377b6ba60e::function_2f27432f2f94a830([ai_enemy], level.player.origin);
  }

  level utility::flag_wait_or_timeout("flag_forest_field_06", 3);

  if(!level utility::flag("flag_forest_field_05") && !level.player issprinting()) {
    level utility::flag_wait("flag_forest_field_05");
  }

  level utility::flag_set("flag_forest_field_shack_enemies_combat");
}

function function_85876e218f28af42() {
  wait 3;
  vehicle = getscriptablearray("veh_forest_field_shack_transport", "targetname")[0];
  assertex(isDefined(vehicle), "Could not find scriptable vehicle w targetname 'veh_forest_field_shack_transport'");
  vehicle utility::function_3677f2be30fdd581("body", "heavy_smoke");
  vehicle thread function_e952252229c7c33b();
  vehicle thread function_751e4bae04ac9850();
  vehicle thread function_ad1a50444e713892();
  vehicle thread function_7763c60658c1cdd0();
}

function function_e952252229c7c33b() {
  self endon("destroyed");
  level.player endon("death");
  level endon("flag_forest_field_complete");
  level utility::flag_wait("flag_forest_field_shack_enemies_combat");
  n_count = 0;
  gameskill = level.player utility::get_player_gameskill();

  switch (gameskill) {
    case 3:
    case 4:
      var_ca167f57276249d6 = randomintrange(5, 10);
      break;
    case 1:
    case 2:
      var_ca167f57276249d6 = randomintrange(8, 12);
      break;
    case 0:
    default:
      var_ca167f57276249d6 = randomintrange(10, 20);
      break;
  }

  while(true) {
    if(level utility::flag("flag_forest_field_player_near_transport")) {
      n_count++;
    } else {
      n_count = 0;
    }

    if(n_count > var_ca167f57276249d6) {
      break;
    }

    wait 1;
  }

  var_fb3cefb948f2d980 = utility::array_removedead_or_dying(level.var_2f9f697bc727f253);

  if(var_fb3cefb948f2d980.size > 0) {
    var_fb3cefb948f2d980 = sortbydistance(var_fb3cefb948f2d980, level.player.origin);
    var_42370bdc56e6fef0 = var_fb3cefb948f2d980[0] getEye() + (0, 0, 256);
    level utility::flag_set("flag_forest_field_shack_enemies_grenade_transport", var_42370bdc56e6fef0);
  }
}

function function_7763c60658c1cdd0() {
  struct = utility::getStruct("s_forest_field_shack_transport_center", "targetname");
  badplace_cylinder("bp_forest_field_transport_allies", -1, struct.origin, 768, 64, "allies");
  utility::waittill_any_ents(self, "destroyed", level, "flag_forest_field_shack_enemies_combat", level, "flag_forest_vista_complete");
  badplace_delete("bp_forest_field_transport_allies");
}

function function_ad1a50444e713892() {
  self endon("destroyed");
  level.player endon("death");
  level endon("flag_forest_field_complete");
  var_1b4b2c1a9baf9ff5 = utility::getStructArray("s_forest_field_shack_transport_grenade_end", "targetname");
  var_1b4b2c1a9baf9ff5 = array_randomize(var_1b4b2c1a9baf9ff5);
  grenade = undefined;
  grenade_source = level utility::flag_wait("flag_forest_field_shack_enemies_grenade_transport");

  if(utility::flag("flag_forest_field_vo_approach_transport_playing")) {
    utility::flag_waitopen_or_timeout("flag_forest_field_vo_approach_transport_playing", 5);
  }

  if(isDefined(grenade_source)) {
    if(isai(grenade_source) && isalive(grenade_source)) {
      grenade_source endon("death");

      if(!utility::array_contains(level.var_2f9f697bc727f253, grenade_source)) {
        grenade_source ai::set_grenadeweapon("frag");
        grenade_source.grenadeammo = 1;
      }

      for(i = 0; i < var_1b4b2c1a9baf9ff5.size; i++) {
        var_376eb5d9559cdb16 = var_1b4b2c1a9baf9ff5[i].origin;
        grenade = grenade_source magicgrenade(grenade_source.origin, var_376eb5d9559cdb16, 1.5, 1);
        waitframe();

        if(isDefined(grenade)) {
          break;
        }

        waitframe();
      }
    } else if(isvector(grenade_source)) {
      for(i = 0; i < var_1b4b2c1a9baf9ff5.size; i++) {
        var_376eb5d9559cdb16 = var_1b4b2c1a9baf9ff5[i].origin;
        var_f44cd2ccd2d6328e = anglesToForward(vectortoangles(grenade_source - var_376eb5d9559cdb16)) * 128;
        var_ece098d419ba8e83 = var_376eb5d9559cdb16 + var_f44cd2ccd2d6328e + (0, 0, 256);
        launchvelocity = var_376eb5d9559cdb16 - var_ece098d419ba8e83;
        grenade = magicgrenademanual("semtex", var_ece098d419ba8e83, launchvelocity, 2.3);
        waitframe();

        if(isDefined(grenade)) {
          break;
        }

        waitframe();
      }
    }
  } else {
    s_exit = getStruct("s_forest_field_exit", "targetname");

    for(i = 0; i < var_1b4b2c1a9baf9ff5.size; i++) {
      var_376eb5d9559cdb16 = var_1b4b2c1a9baf9ff5[i].origin;
      var_f44cd2ccd2d6328e = anglesToForward(vectortoangles(s_exit.origin - var_376eb5d9559cdb16)) * 512;
      var_ece098d419ba8e83 = var_376eb5d9559cdb16 + var_f44cd2ccd2d6328e + (0, 0, 256);
      launchvelocity = var_376eb5d9559cdb16 - var_ece098d419ba8e83;
      grenade = magicgrenademanual("semtex", var_ece098d419ba8e83, launchvelocity, 2.3);
      waitframe();

      if(isDefined(grenade)) {
        break;
      }

      waitframe();
    }
  }

  if(isDefined(grenade)) {
    level utility::flag_set("flag_forest_field_shack_enemies_grenade_transport_warning");
    utility::function_3677f2be30fdd581("body", "no_process");
    grenade waittill("death");
    waitframe();

    if(utility::function_35c178c80fa19cbd("body", "flareup") == 0) {
      utility::function_3677f2be30fdd581("body", "flareup");
    }

    self.burningcarindicator = undefined;
    warning_time = 3;
    self.var_f5f610105c07a8b2 = magicgrenade("car_grenade", self.origin + (0, 0, 10), self.origin, warning_time, 0);
    self.var_f5f610105c07a8b2 makeunusable();
    wait warning_time;
    utility::function_3677f2be30fdd581("body", "on_fire");
    self.onfire = 1;

    iprintln("<dev string:x1bc>");
  }
}

function function_751e4bae04ac9850() {
  level.player endon("death");
  level endon("flag_forest_field_complete");
  var_a766a4b07ccb606e = utility::getStructArray("s_field_veh_fire", "targetname");
  self waittill("destroyed");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.8, 0.6, self.origin, 350);
  level utility::flag_set("flag_forest_field_shack_transport_destroyed");

  iprintln("<dev string:x1e1>");

  foreach(struct in var_a766a4b07ccb606e) {
    trigger = spawn("trigger_radius_fire", struct.origin, 0, 40, 96);
    level thread scripts\sp\trigger::trigger_fire(trigger);
    trigger thread namespace_8339f6377b6ba60e::function_3b7f2849eba01942("flag_forest_vista_complete");
  }

  level scripts\stealth\utility::set_stealth_func("event_should_ignore", undefined);
  wait 1;
  exploder("vfx_engine_fire");
  kill_exploder("vfx_car_steam");
  wait 1;
  badplace_delete("bp_forest_field_transport_all");
}

function function_ccdc726c877161d5() {
  var_7c760871476912f0 = utility::getStructArray("s_forest_field_shack_frag_pickup", "targetname");
  var_4c23139ab28e649a = [];

  foreach(s_frag in var_7c760871476912f0) {
    frag_pickup = s_frag namespace_8339f6377b6ba60e::function_527133d02bd11634();
    frag_pickup thread function_8fcc901d5b54f877(1);
    var_4c23139ab28e649a = utility::array_add(var_4c23139ab28e649a, frag_pickup);
  }

  var_dbd953db885febbc = utility::getStructArray("s_forest_field_shack_flash_pickup", "targetname");

  foreach(s_flash in var_dbd953db885febbc) {
    flash_pickup = s_flash namespace_8339f6377b6ba60e::function_527133d02bd11634("flash");
  }

  w_forest_field_lmg = getEnt("w_forest_field_lmg", "targetname");
  w_forest_field_lmg thread function_8fcc901d5b54f877(0);
  var_3a3165f400fb0735 = getEntArray("e_forest_field_shack_grenade_crate", "targetname");
  level utility::flag_wait_any("flag_forest_field_shack_transport_destroyed", "flag_forest_vista_complete");
  var_4c23139ab28e649a = utility::array_removeundefined(var_4c23139ab28e649a);

  foreach(frag_pickup in var_4c23139ab28e649a) {
    frag_pickup cursor_hint::remove_cursor_hint();
    frag_pickup delete();
  }

  if(isDefined(w_forest_field_lmg)) {
    w_forest_field_lmg delete();
  }

  foreach(ent in var_3a3165f400fb0735) {
    if(isDefined(ent)) {
      ent delete();
    }
  }
}

function function_8fcc901d5b54f877(b_grenade) {
  level.player endon("death");
  level endon("flag_forest_field_complete");
  self endon("death");
  b_grenade = default_to(b_grenade, 0);

  if(istrue(b_grenade)) {
    self waittill("offhand_pickup");
  } else {
    self waittill("trigger");
  }

  level utility::flag_set("flag_forest_field_player_pickup_transport");
}

function function_a8797ac527a83c64() {
  var_dc971957a84e8915 = vehicle::spawn_vehicles_from_targetname_and_drive("veh_enemy_heli_forest_field");
  vehicle_build::build_treadfx(var_dc971957a84e8915[0].classname_mp, "default", "vfx/jup/level/sp_tundra/vfx_tun_env_helo_wash_snow_1.vfx", 1);

  foreach(heli in var_dc971957a84e8915) {
    heli thread namespace_8339f6377b6ba60e::function_9871d73aaf67c8f4("flag_forest_field_heli_passed");
  }

  utility::array_ent_flag_wait(var_dc971957a84e8915, "flag_forest_field_heli_passed");
  wait 1;
  level utility::flag_set("flag_forest_field_heli_passed");
}

function function_9fa63a23c3ebf26c() {
  setsaveddvar(@ "hash_da8fd34f1f588a6b", 5000);
  lerp_saveddvar(@ "hash_402173c7dbee15d9", 40, 5);
  lerp_saveddvar(@ "hash_402173c7dbee15d9", 1, 15);
  wait 10;
  setsaveddvar(@ "hash_da8fd34f1f588a6b", 2048);
}

function function_7b8e5c576d5a71c1() {
  level.player endon("death");
  level endon("flag_forest_field_allies_buddy_follow_stop");
  namespace_8339f6377b6ba60e::function_f149c0325eb376c4(0);
  namespace_8339f6377b6ba60e::function_c9317b6d58796509(1, "cqb");
  msg = level utility::flag_wait_any_return("flag_forest_field_supplies_vo_complete", "flag_forest_field_02", "flag_forest_field_shack_enemies_combat");
  namespace_8339f6377b6ba60e::function_83e7e4b9d5f7bdb(1, 1, 1);

  if(msg != "flag_forest_field_shack_enemies_combat") {
    switch (self.animname) {
      case #"hash_df31f98a0b34e496":
        s_destination = utility::getStruct("s_forest_field_left", "targetname");
        break;
      case #"hash_fb36726c0708cd6d":
        s_destination = utility::getStruct("s_forest_field_right", "targetname");
        break;
      case #"hash_831c7a280af6bbca":
      default:
        s_destination = utility::getStruct("s_forest_field_entrance", "targetname");
        break;
    }

    origin_destination = s_destination.origin;
    var_cd8bc43698a828cc = 384;
    var_352a8978dcbaa34c = 512;
    var_a4365597f945dcfd = 256;
    var_7457e67b7a059a97 = "nd_forest_field_precombat";
    level thread namespace_df392a06b5c03994::setup(self, "flag_forest_field_01", origin_destination, var_cd8bc43698a828cc, var_352a8978dcbaa34c, var_a4365597f945dcfd, var_7457e67b7a059a97);
    level utility::flag_wait("flag_forest_field_shack_enemies_combat");
  }

  namespace_8339f6377b6ba60e::function_c9317b6d58796509(0, "combat");
  level utility::flag_wait("flag_forest_field_allies_spread_out");

  switch (self.animname) {
    case #"hash_df31f98a0b34e496":
      self notify("buddy_follow_stop");
      delaythread(0.5, &namespace_8339f6377b6ba60e::function_4cf134efffb1de77, "b", 512);
      my_enemy = utility::get_living_ai("ai_forest_field_enemy_sniper_left", "targetname");
      thread function_b3c64fd207e733ee();
      break;
    case #"hash_fb36726c0708cd6d":
      self notify("buddy_follow_stop");
      delaythread(0.5, &namespace_8339f6377b6ba60e::function_4cf134efffb1de77, "g", 512);
      my_enemy = utility::get_living_ai("ai_forest_field_enemy_sniper_right", "targetname");
      thread function_b3c64fd207e733ee();
      break;
    case #"hash_831c7a280af6bbca":
    default:
      s_destination = utility::getStruct("s_forest_field_entrance", "targetname");
      var_cd8bc43698a828cc = 384;
      var_352a8978dcbaa34c = 512;
      var_a4365597f945dcfd = 256;
      origin_destination = s_destination.origin;
      var_7457e67b7a059a97 = "nd_forest_field_no_ally";
      level thread namespace_df392a06b5c03994::setup(self, "flag_forest_field_shack_enemies_combat", origin_destination, var_cd8bc43698a828cc, var_352a8978dcbaa34c, var_a4365597f945dcfd, var_7457e67b7a059a97);
      my_enemy = utility::get_living_ai("ai_forest_field_enemy_sniper_center", "targetname");
      thread function_b3c64fd207e733ee(1);
      break;
  }

  if(!isDefined(my_enemy)) {
    var_d64eea81231281af = utility::array_removedead_or_dying(level.var_2f9f697bc727f253);
    my_enemy = utility::getclosest(self.origin, var_d64eea81231281af);
  }

  utility::set_favoriteenemy(my_enemy);
  self getenemyinfo(my_enemy);
  level utility::flag_wait("flag_forest_field_sniper_one_remaining");
  var_d64eea81231281af = utility::array_removedead_or_dying(level.var_2f9f697bc727f253);
  my_enemy = utility::getclosest(self.origin, var_d64eea81231281af);
  utility::set_favoriteenemy(my_enemy);
  self getenemyinfo(my_enemy);
}

function function_b3c64fd207e733ee(var_c68c409b3261e84b) {
  self endon("death");
  level.player endon("death");
  var_c68c409b3261e84b = default_to(var_c68c409b3261e84b, 0);

  while(true) {
    if(flag("flag_forest_field_sniper_one_remaining") || flag("flag_forest_field_complete")) {
      break;
    }

    if(isDefined(self.enemy)) {
      if(!utility::array_contains(level.var_2f9f697bc727f253, self.enemy) && istrue(self.var_43ae9f4734246fb0)) {
        self.var_43ae9f4734246fb0 = 0;
      } else if(istrue(var_c68c409b3261e84b) && !istrue(self.var_43ae9f4734246fb0)) {
        self.var_43ae9f4734246fb0 = 1;
      } else if(istrue(self.enemy.dontattackme) && !istrue(self.var_43ae9f4734246fb0)) {
        self.var_43ae9f4734246fb0 = 1;
      } else if(istrue(self.var_43ae9f4734246fb0)) {
        self.var_43ae9f4734246fb0 = 0;
      }
    } else if(!istrue(self.var_43ae9f4734246fb0)) {
      self.var_43ae9f4734246fb0 = 1;
    }

    wait 0.1;
  }

  self.var_43ae9f4734246fb0 = 0;
}

function function_ddae8aa32229ecd7() {
  self endon("death");
  level utility::flag_wait_any("flag_forest_field_sniper_all_dead", "flag_forest_vista_02");
  level utility::flag_set("flag_forest_field_allies_moving_to_exit");
  namespace_8339f6377b6ba60e::function_c9317b6d58796509(1, "cqb");
  self notify("buddy_follow_stop");
  function_718f6388e43588d7();
  waitframe();
  self setgoalpos(self.origin);

  switch (self.animname) {
    case #"hash_df31f98a0b34e496":
      wait randomfloatrange(0.5, 1.5);
      break;
    case #"hash_fb36726c0708cd6d":
      wait randomfloatrange(0.1, 0.5);
      break;
    case #"hash_831c7a280af6bbca":
    default:
      wait randomfloatrange(2, 3);
      break;
  }

  start_struct = namespace_8339f6377b6ba60e::function_bdc421f433af10c7("s_start_forest_vista");
  thread namespace_8339f6377b6ba60e::function_11fc094b83527d81(start_struct);
  thread function_d7055444f315e75f();
}

function function_7aebc2c4b761e1b9(event) {
  if(isDefined(event.entity) && event.entity == level.player) {
    return false;
  }

  if(event.typeorig == "grenade danger" || event.typeorig == "explosion" || event.typeorig == "damage") {
    return true;
  }

  return false;
}

function function_b7425eb6761956a1() {
  wait 1;
  array_spawn_function_targetname("ai_enemy_forest_field_shack", &function_7a191e710c595e4);
  var_b4bb34dd619e4bde = utility::array_spawn_targetname("ai_enemy_forest_field_shack", 1);
  level scripts\stealth\utility::set_stealth_func("event_should_ignore", &function_7aebc2c4b761e1b9);
  level thread namespace_8339f6377b6ba60e::function_7cf3b8f1b807889a(var_b4bb34dd619e4bde, "flag_forest_field_shack_enemies_one_dead", 1, "flag_forest_field_complete");
  level thread namespace_8339f6377b6ba60e::function_7cf3b8f1b807889a(var_b4bb34dd619e4bde, "flag_forest_field_shack_enemies_fallback", 2, "flag_forest_field_complete");
  level thread namespace_8339f6377b6ba60e::function_7cf3b8f1b807889a(var_b4bb34dd619e4bde, "flag_forest_field_shack_enemies_nerf", var_b4bb34dd619e4bde.size - 1, "flag_forest_field_complete");
  level thread namespace_8339f6377b6ba60e::function_7cf3b8f1b807889a(var_b4bb34dd619e4bde, "flag_forest_field_shack_enemies_dead", var_b4bb34dd619e4bde.size, "flag_forest_field_complete");
  level thread namespace_8339f6377b6ba60e::function_7039df9b8f2744bb(var_b4bb34dd619e4bde, "flag_forest_field_shack_enemies_nerf", 0, undefined, "flag_forest_field_complete");
  level thread namespace_8339f6377b6ba60e::function_2d474574a7fbf9d9(var_b4bb34dd619e4bde, "flag_forest_vista_06");
  level thread function_9a79387fc0cc4c07(var_b4bb34dd619e4bde);
  level thread function_2f57e8bce902b12d(var_b4bb34dd619e4bde);
  level utility::flag_wait("flag_forest_field_shack_enemies_dead");
  utility::autosave_tactical();
  scripts\engine\sp\utility::add_extra_autosave_check("autosave_forest_field_snipers", &function_d048cb3d1c89ce27, "Sniper can see/shoot player.");
  level thread namespace_8339f6377b6ba60e::function_4fb957efd679cf35("flag_forest_field_complete", "forest_player_progress");
}

function function_d048cb3d1c89ce27() {
  var_fb3cefb948f2d980 = array_removedead_or_dying(level.var_2f9f697bc727f253);

  if(var_fb3cefb948f2d980.size == 0) {
    return true;
  }

  ai_sniper = utility::getclosest(level.player.origin, var_fb3cefb948f2d980, 384);

  if(isDefined(ai_sniper)) {
    return false;
  }

  foreach(ai_sniper in var_fb3cefb948f2d980) {
    if(ai_sniper utility::ent_flag_exist("flag_sniper_grenade_fire") && ai_sniper utility::ent_flag("flag_sniper_grenade_fire")) {
      return false;
    }

    if(isDefined(ai_sniper) && isalive(ai_sniper)) {
      b_trace = utility::can_trace_to_player(ai_sniper gettagorigin("tag_flash"));

      if(ai_sniper cansee(level.player) || istrue(b_trace)) {
        return false;
      }
    }
  }

  return true;
}

function function_df82d24badfb5bb3(b_sniper) {
  self endon("death");
  level.player endon("death");
  level endon("flag_forest_field_complete");
  level endon("flag_forest_field_shack_enemies_combat");

  if(level utility::flag("flag_forest_field_shack_enemies_combat")) {
    return;
  }

  b_sniper = default_to(b_sniper, 0);
  level utility::flag_wait("flag_forest_field_shack_enemies_destroy_transport");
  id = self function_92435c7a6ae85c3c();

  if(isDefined(id)) {
    self leaveinteraction();
  }

  if(istrue(b_sniper)) {
    str_name = self.targetname;
  } else {
    str_name = self.script_noteworthy;
  }

  var_a5cb5bc5c04d2d10 = getStruct("s_" + str_name + "_B", "targetname");

  if(!isDefined(var_a5cb5bc5c04d2d10)) {
    iprintln("<dev string:x208>" + str_name);

    return;
  }

  thread spawner::go_to_node(var_a5cb5bc5c04d2d10);
}

function function_7a191e710c595e4() {
  self endon("death");
  utility::set_grenadeammo(0);
  utility::set_baseaccuracy(0.9);
  utility::set_attackeraccuracy(1.5);
  ai::disable_long_death();
  self.ainame = "Konni";
  utility::set_patrol_style("alert");
  thread function_3e2975cd27d9313();

  if(isDefined(self.script_noteworthy)) {
    thread function_df82d24badfb5bb3();
  }
}

function function_3e2975cd27d9313() {
  self endon("death");
  level endon("flag_forest_field_shack_enemies_combat");

  if(level utility::flag("flag_forest_field_shack_enemies_combat")) {
    return;
  }

  ai_ally = undefined;
  var_1e4c41a5dcdf5b1e = squared(256);

  while(true) {
    ai_ally = utility::getclosest(self.origin, level.tundra_allies, 512);

    if(isDefined(ai_ally)) {
      if(distance2dsquared(self.origin, ai_ally.origin) < var_1e4c41a5dcdf5b1e || self cansee(ai_ally)) {
        level utility::flag_set("flag_forest_field_shack_enemies_combat");
      }
    }

    wait 1;
  }
}

function function_2f57e8bce902b12d(a_ai_enemies) {
  level.player endon("death");
  level endon("flag_forest_field_complete");
  msg = level utility::flag_wait_any_return("flag_forest_field_shack_enemies_combat", "stealth_spotted");
  level utility::flag_set("flag_forest_field_shack_enemies_combat");
  level utility::flag_set("flag_forest_stop_nags");

  if(!isDefined(level.player.stealth)) {
    init::set_stealth_mode(0);
    level.var_b8b68f147d0eeb36 = 1;
  }

  a_ai_enemies = utility::array_removedead_or_dying(a_ai_enemies);

  if(a_ai_enemies.size == 0) {
    return;
  }

  a_ai_enemies = sortbydistance(a_ai_enemies, level.player.origin);

  for(i = 0; i < a_ai_enemies.size; i++) {
    wait randomfloatrange(0.1, 0.3);
    ai_enemy = a_ai_enemies[i];

    if(isDefined(ai_enemy) && isalive(ai_enemy)) {
      id = ai_enemy function_92435c7a6ae85c3c();

      if(isDefined(id)) {
        ai_enemy leaveinteraction();
      }

      ai_enemy utility::enable_stealth_for_ai(0);
      ai_enemy utility::clear_movement_speed();
      ai_enemy.dontevershoot = 0;
      ai_enemy.dontattackme = 0;
      ai_enemy getenemyinfo(level.player);
      ai_enemy utility::delaythread(randomfloatrange(1, 3), &utility::set_attackeraccuracy, 2);
    }
  }
}

function function_9a79387fc0cc4c07(a_ai_enemies) {
  level utility::flag_wait_any("flag_forest_field_shack_enemies_fallback", "flag_forest_field_04");
  level utility::flag_set("flag_forest_field_shack_enemies_fallback");
  a_ai_enemies = utility::array_removedead_or_dying(a_ai_enemies);

  if(a_ai_enemies.size == 0) {
    return;
  }

  vol = getEnt("vol_forest_field_enemy_shack_fallback", "targetname");
  a_ai_enemies = sortbydistance(a_ai_enemies, level.player.origin);

  for(i = 0; i < a_ai_enemies.size; i++) {
    wait randomfloatrange(1, 3);
    ai_enemy = a_ai_enemies[i];

    if(isDefined(ai_enemy) && isalive(ai_enemy)) {
      ai_enemy setgoalpos(ai_enemy.origin);
      ai_enemy setgoalvolumeauto(vol);
    }
  }

  level utility::flag_wait("flag_forest_field_07");
  a_ai_enemies = utility::array_removedead_or_dying(a_ai_enemies);

  if(a_ai_enemies.size == 0) {
    return;
  }

  a_ai_enemies = sortbydistance(a_ai_enemies, level.player.origin);

  for(i = 0; i < a_ai_enemies.size; i++) {
    wait randomfloatrange(1, 3);
    ai_enemy = a_ai_enemies[i];

    if(isDefined(ai_enemy) && isalive(ai_enemy)) {
      ai_enemy setgoalpos(ai_enemy.origin);
      ai_enemy thread utility::player_seek_enable();
      ai_enemy utility::set_attackeraccuracy(2);
      ai_enemy utility::set_baseaccuracy(0.75);
      ai_enemy.health = int(ai_enemy.health * 0.5) + 1;
    }
  }
}

function function_d30d567259a4e5cc() {
  sniper_left = namespace_8339f6377b6ba60e::function_56341edc24e9bec6("ai_forest_field_enemy_sniper_left", level.player);
  sniper_left thread function_3e2975cd27d9313();
  sniper_left thread namespace_8339f6377b6ba60e::function_4fbb2fb25c0ad91();
  sniper_left thread function_af4deb9464eb09cc();
  sniper_left thread namespace_8339f6377b6ba60e::function_30c5a9670baa5108("flag_forest_field_sniper_left_dead", 0, 1);
  sniper_left thread namespace_8339f6377b6ba60e::function_5a2cf70848a11dfe(undefined, 0, "flag_forest_field_shack_enemies_combat", 4, "flag_forest_field_sniper_left_dead", "flag_forest_field_complete");
  sniper_left.ainame = "Konni";
  level.var_2f9f697bc727f253 = utility::array_add(level.var_2f9f697bc727f253, sniper_left);
  waitframe();
  sniper_right = namespace_8339f6377b6ba60e::function_56341edc24e9bec6("ai_forest_field_enemy_sniper_right", level.player);
  sniper_right thread function_3e2975cd27d9313();
  sniper_right thread namespace_8339f6377b6ba60e::function_4fbb2fb25c0ad91();
  sniper_right thread function_af4deb9464eb09cc();
  sniper_right thread namespace_8339f6377b6ba60e::function_30c5a9670baa5108("flag_forest_field_sniper_right_dead", 0, 1);
  sniper_right thread namespace_8339f6377b6ba60e::function_5a2cf70848a11dfe(undefined, 0, "flag_forest_field_shack_enemies_combat", 4, "flag_forest_field_sniper_right_dead", "flag_forest_field_complete");
  sniper_right.ainame = "Konni";
  level.var_2f9f697bc727f253 = utility::array_add(level.var_2f9f697bc727f253, sniper_right);
  waitframe();
  sniper_center = namespace_8339f6377b6ba60e::function_56341edc24e9bec6("ai_forest_field_enemy_sniper_center", level.player);
  sniper_center thread function_3e2975cd27d9313();
  sniper_center thread namespace_8339f6377b6ba60e::function_4fbb2fb25c0ad91();
  sniper_center thread function_af4deb9464eb09cc();
  sniper_center thread function_df82d24badfb5bb3(1);
  sniper_center thread namespace_8339f6377b6ba60e::function_30c5a9670baa5108("flag_forest_field_sniper_center_dead", 0, 1);
  sniper_center thread namespace_8339f6377b6ba60e::function_5a2cf70848a11dfe(undefined, 0, "flag_forest_field_shack_enemies_combat", 4, "flag_forest_field_sniper_center_dead", "flag_forest_field_complete");
  sniper_center.ainame = "Konni";
  level.var_2f9f697bc727f253 = utility::array_add(level.var_2f9f697bc727f253, sniper_center);
  waitframe();
  sniper_cliff = namespace_8339f6377b6ba60e::function_56341edc24e9bec6("ai_forest_field_enemy_sniper_cliff", level.player);
  sniper_cliff thread function_3e2975cd27d9313();
  sniper_cliff thread namespace_8339f6377b6ba60e::function_4fbb2fb25c0ad91();
  sniper_cliff thread function_af4deb9464eb09cc();
  sniper_cliff thread namespace_8339f6377b6ba60e::function_30c5a9670baa5108("flag_forest_field_sniper_cliff_dead", 0, 1);
  sniper_cliff thread namespace_8339f6377b6ba60e::function_5a2cf70848a11dfe(undefined, 1, ["flag_forest_field_sniper_one_dead", "flag_forest_field_06"], 4, "flag_forest_field_sniper_cliff_dead", "flag_forest_field_complete");
  sniper_cliff.ainame = "Konni";
  level.var_2f9f697bc727f253 = utility::array_add(level.var_2f9f697bc727f253, sniper_cliff);
  level thread namespace_8339f6377b6ba60e::function_7cf3b8f1b807889a(level.var_2f9f697bc727f253, "flag_forest_field_sniper_one_dead", 1);
  level thread namespace_8339f6377b6ba60e::function_7cf3b8f1b807889a(level.var_2f9f697bc727f253, "flag_forest_field_sniper_two_remaining", level.var_2f9f697bc727f253.size - 2);
  level thread namespace_8339f6377b6ba60e::function_7cf3b8f1b807889a(level.var_2f9f697bc727f253, "flag_forest_field_sniper_one_remaining", level.var_2f9f697bc727f253.size - 1);
  level thread namespace_8339f6377b6ba60e::function_7cf3b8f1b807889a(level.var_2f9f697bc727f253, "flag_forest_field_sniper_all_dead", undefined, "flag_forest_vista_complete");
  level thread function_d163e1b575ba83c0(sniper_left, sniper_right, sniper_center, sniper_cliff);
  level thread function_546fc027061fcd01("flag_forest_field_complete", "flag_forest_field_beyond_complete", level.var_2f9f697bc727f253, "flag_forest_field_sniper_all_dead", 519);
  level utility::flag_wait_any("flag_forest_field_sniper_one_remaining", "flag_forest_field_09");

  if(utility::flag("flag_forest_field_shack_enemies_combat")) {
    level.var_2f9f697bc727f253 = utility::array_removedead_or_dying(level.var_2f9f697bc727f253);

    if(level.var_2f9f697bc727f253.size > 0) {
      s_forest_field_exit = utility::getStruct("s_forest_field_exit", "targetname");

      while(level.var_2f9f697bc727f253.size > 2) {
        var_c7763bd629f35780 = sortbydistance(level.var_2f9f697bc727f253, s_forest_field_exit.origin);
        var_c7763bd629f35780 = utility::array_reverse(var_c7763bd629f35780);
        closest_sniper = var_c7763bd629f35780[0];
        closest_sniper thread namespace_8339f6377b6ba60e::function_5bf334b09d55ec29("vol_forest_field_enemy_sniper_center_back");
        closest_sniper waittill("death");
        wait randomfloatrange(1, 3);
        level.var_2f9f697bc727f253 = utility::array_removedead_or_dying(level.var_2f9f697bc727f253);
      }

      foreach(sniper in level.var_2f9f697bc727f253) {
        sniper thread namespace_8339f6377b6ba60e::function_5bf334b09d55ec29("vol_forest_field_enemy_sniper_center_back");
      }
    }

    return;
  }

  struct = utility::getStruct("s_forest_field_exit", "targetname");
  namespace_8339f6377b6ba60e::function_2f27432f2f94a830(level.var_2f9f697bc727f253, struct.origin);
}

function function_974688c9fccf2ad(sniper) {
  level.player endon("death");
  sniper endon("death");
  level endon("flag_forest_field_complete");
  var_e0eda4eec7d663c4 = 0;

  while(true) {
    var_eff21d79de9e59d2 = isDefined(sniper.var_713a5e7f36770188);
    var_e0f3c8b80ee80283 = sniper getthreatsight(level.player);

    if(!var_eff21d79de9e59d2 && var_e0f3c8b80ee80283 > 0.9) {
      sniper.var_713a5e7f36770188 = gettime();
      continue;
    }

    if(var_e0eda4eec7d663c4 && (sniper lastknowntime(level.player) + 1500 < gettime() || var_e0f3c8b80ee80283 < 0.5)) {
      sniper function_83ba722eaa208978();
      sniper.var_713a5e7f36770188 = undefined;
      var_e0eda4eec7d663c4 = 0;
      var_eff21d79de9e59d2 = 0;
    }

    if(var_eff21d79de9e59d2 && !var_e0eda4eec7d663c4 && sniper canshoot(level.player.origin)) {
      var_35f7e652a5bb1b1 = sniper.var_713a5e7f36770188 + 2000 < gettime();

      if(var_35f7e652a5bb1b1) {
        sniper function_f91f339ff81fb904();
        var_e0eda4eec7d663c4 = 1;
      }
    }

    waitframe();
  }
}

function function_d163e1b575ba83c0(sniper_left, sniper_right, sniper_center, sniper_cliff) {
  level utility::flag_wait("flag_forest_field_shack_enemies_combat");

  if(isDefined(sniper_left) && isalive(sniper_left)) {
    sniper_left utility::enable_stealth_for_ai(0);
    waitframe();
    sniper_left thread function_5a6ddd6265d935cf("vol_forest_field_enemy_sniper_left_front");
    sniper_left thread namespace_8339f6377b6ba60e::function_b4009ab2b713e380("vol_forest_field_enemy_sniper_left_front", "vol_forest_field_enemy_sniper_left_mid", "vol_forest_field_enemy_sniper_left_back", "flag_forest_field_05", "flag_forest_field_07", "flag_forest_field_09");
    level thread function_974688c9fccf2ad(sniper_left);
  }

  if(isDefined(sniper_right) && isalive(sniper_right)) {
    sniper_right utility::enable_stealth_for_ai(0);
    waitframe();
    sniper_right thread function_5a6ddd6265d935cf("vol_forest_field_enemy_sniper_right_front");
    sniper_right thread namespace_8339f6377b6ba60e::function_b4009ab2b713e380("vol_forest_field_enemy_sniper_right_front", "vol_forest_field_enemy_sniper_right_mid", "vol_forest_field_enemy_sniper_right_back", "flag_forest_field_05", "flag_forest_field_07", "flag_forest_field_09");
    level thread function_974688c9fccf2ad(sniper_right);
  }

  if(isDefined(sniper_center) && isalive(sniper_center)) {
    sniper_center utility::enable_stealth_for_ai(0);
    waitframe();
    sniper_center thread function_5a6ddd6265d935cf("vol_forest_field_enemy_sniper_center_front");
    sniper_center thread namespace_8339f6377b6ba60e::function_b4009ab2b713e380("vol_forest_field_enemy_sniper_center_front", "vol_forest_field_enemy_sniper_center_mid", "vol_forest_field_enemy_sniper_center_back", "flag_forest_field_06", "flag_forest_field_08", "flag_forest_field_10");
    level thread function_974688c9fccf2ad(sniper_center);
  }

  if(isDefined(sniper_cliff) && isalive(sniper_cliff)) {
    sniper_cliff utility::enable_stealth_for_ai(0);
    waitframe();
    sniper_cliff thread namespace_8339f6377b6ba60e::function_b4009ab2b713e380("vol_forest_field_enemy_sniper_left_cliff", "vol_forest_field_enemy_sniper_left_cliff", "vol_forest_field_enemy_sniper_center_back", "flag_forest_field_08", "flag_forest_field_09", "flag_forest_field_10");
    level thread function_974688c9fccf2ad(sniper_cliff);
  }

  level.var_2f9f697bc727f253 = utility::array_removedead_or_dying(level.var_2f9f697bc727f253);

  foreach(sniper in level.var_2f9f697bc727f253) {
    sniper thread namespace_8339f6377b6ba60e::function_7aeee375fe0a0c3a();
    sniper thread namespace_8339f6377b6ba60e::function_caafd52a2477ee13("flag_forest_field_enemy_sniper_weapon_fired");
    sniper thread namespace_8339f6377b6ba60e::function_bfefcf7f0f787590();
    sniper thread namespace_8339f6377b6ba60e::function_e6f00fe079d3a907(undefined, 0.5, 512, 4096, 0.1);
    sniper thread namespace_8339f6377b6ba60e::function_22a4d67da6989229();
    sniper thread namespace_8339f6377b6ba60e::function_fd943d3e52bfb3b5();
    sniper thread namespace_8339f6377b6ba60e::function_179379219983f831();
    sniper thread namespace_8339f6377b6ba60e::function_b003291882aac5c();
    sniper thread namespace_8339f6377b6ba60e::function_70cbe058e1cd0d90();
    sniper thread namespace_8339f6377b6ba60e::function_9588cd6285c622a7();
    sniper thread function_3ba528462f83147a("flag_forest_field_sniper_one_dead");
    sniper thread namespace_8339f6377b6ba60e::function_e8021510002c6190();
    sniper namespace_8339f6377b6ba60e::function_dbfe26c9e6fd3276(0);
    sniper utility::ent_flag_set("flag_sniper_allow_secondary_damage");

    foreach(ally in level.tundra_allies) {
      sniper namespace_8339f6377b6ba60e::function_47215dde740a0bc2(ally, 1);
    }
  }

  level thread function_ce94f0b91016c999();
}

function function_ce94f0b91016c999() {
  level.player endon("death");
  level endon("flag_forest_field_complete");
  level endon("flag_forest_field_sniper_all_dead");

  if(utility::flag("flag_forest_field_complete")) {
    return;
  }

  gameskill = level.player utility::get_player_gameskill();

  switch (gameskill) {
    case 4:
      var_14f77b4a43805365 = ["flag_forest_field_sniper_one_dead", "flag_forest_field_04"];
      var_90d906bd78716998 = ["flag_forest_field_sniper_two_remaining", "flag_forest_field_05"];
      break;
    case 3:
      var_14f77b4a43805365 = ["flag_forest_field_sniper_two_remaining", "flag_forest_field_04"];
      var_90d906bd78716998 = ["flag_forest_field_sniper_one_remaining", "flag_forest_field_06"];
      break;
    case 1:
    case 2:
      var_14f77b4a43805365 = ["flag_forest_field_sniper_two_remaining", "flag_forest_field_05"];
      var_90d906bd78716998 = ["flag_forest_field_sniper_one_remaining", "flag_forest_field_07"];
      break;
    case 0:
    default:
      var_14f77b4a43805365 = ["flag_forest_field_sniper_two_remaining", "flag_forest_field_06"];
      var_90d906bd78716998 = ["flag_forest_field_sniper_one_remaining", "flag_forest_field_08"];
      break;
  }

  level utility::function_665d474ff040b446(var_14f77b4a43805365);
  namespace_8339f6377b6ba60e::function_6123dca297db2375("med", "decrease");
  level utility::function_665d474ff040b446(var_90d906bd78716998);
  namespace_8339f6377b6ba60e::function_6123dca297db2375("hard", "decrease");
}

function function_3ba528462f83147a(var_1b1102755d8835bb) {
  self endon("death");
  level.player endon("death");
  utility::ent_flag_wait("flag_sniper_activated");
  wait randomfloatrange(1, 9);

  while(true) {
    if(isDefined(self.var_ac62aeeaf6eb11e1)) {
      target_enemy = self.var_ac62aeeaf6eb11e1;

      if(!isPlayer(self.var_ac62aeeaf6eb11e1)) {
        iprintln("<dev string:x22e>" + self.targetname + "<dev string:x236>" + self.var_ac62aeeaf6eb11e1.targetname);
      }
    } else {
      target_enemy = level.player;
    }

    if(isDefined(self.enemy) && self.enemy != target_enemy) {
      if(!isDefined(self.favoriteenemy) || self.favoriteenemy != target_enemy) {
        utility::set_favoriteenemy(target_enemy);
      }

      self getenemyinfo(target_enemy);
      self.lastenemysightpos = target_enemy.origin;
    }

    if(isDefined(var_1b1102755d8835bb)) {
      if(level utility::flag(var_1b1102755d8835bb)) {
        n_wait_time = 5;
      } else {
        n_wait_time = 10;
      }
    } else {
      n_wait_time = 5;
    }

    msg = level utility::waittill_notify_or_timeout_return("tundra_sniper_dead", n_wait_time);
  }
}

function function_af4deb9464eb09cc() {
  self endon("death");
  self waittill("stealth_combat");
  wait 1;
  self.allowstrafe = 0;
}

function function_bfd8c2fa66c2e3fc() {
  level.player endon("death");
  level endon("flag_forest_field_complete");
  gameskill = level.player utility::get_player_gameskill();

  switch (gameskill) {
    case 3:
    case 4:
      var_9bf68a9a45965989 = 2;
      break;
    case 0:
    case 1:
    case 2:
    default:
      var_9bf68a9a45965989 = 1;
      break;
  }

  level utility::flag_wait("flag_forest_field_shack_enemies_combat");

  while(true) {
    var_fb3cefb948f2d980 = utility::array_removedead_or_dying(level.var_2f9f697bc727f253);
    var_1ad4e7ee7a7063bf = [];

    if(var_fb3cefb948f2d980.size == 0) {
      return;
    } else if(var_fb3cefb948f2d980.size == 1) {
      var_fb3cefb948f2d980[0] getenemyinfo(level.player);
      return;
    }

    var_d9045fe8464a2ce6 = 0;

    foreach(ai_sniper in var_fb3cefb948f2d980) {
      if(isDefined(ai_sniper) && isalive(ai_sniper)) {
        if(isDefined(ai_sniper.enemy) && isPlayer(ai_sniper.enemy)) {
          var_d9045fe8464a2ce6++;
        } else {
          var_1ad4e7ee7a7063bf = utility::array_add(var_1ad4e7ee7a7063bf, ai_sniper);
        }
      }

      waitframe();
    }

    if(var_d9045fe8464a2ce6 < var_9bf68a9a45965989) {
      var_1ad4e7ee7a7063bf = utility::array_removedead_or_dying(var_1ad4e7ee7a7063bf);

      if(var_1ad4e7ee7a7063bf.size > 0) {
        var_1ad4e7ee7a7063bf = utility::array_randomize(var_1ad4e7ee7a7063bf);
        n_diff = var_9bf68a9a45965989 - var_d9045fe8464a2ce6;
        n_count = int(min(var_1ad4e7ee7a7063bf.size, n_diff));

        for(i = 0; i < n_count; i++) {
          ai_sniper = var_1ad4e7ee7a7063bf[i];

          if(isDefined(ai_sniper) && isalive(ai_sniper)) {
            ai_sniper getenemyinfo(level.player);
          }

          waitframe();
        }
      }
    }

    if(level utility::flag("flag_forest_field_sniper_one_dead")) {
      n_wait_time = 1;
    } else {
      n_wait_time = 3;
    }

    level utility::waittill_notify_or_timeout("tundra_sniper_dead", n_wait_time);
  }
}

function function_32a4aea6d981aa6e(sniper_left, sniper_right) {
  level.player endon("death");
  utility::ent_flag_wait("flag_sniper_activated");
  sniper_shift = undefined;

  if(utility::flag("flag_forest_field_sniper_right_dead") && utility::flag("flag_forest_field_sniper_left_dead")) {
    return;
  } else if(utility::flag("flag_forest_field_sniper_right_dead")) {
    sniper_shift = sniper_left;
    ai_ally = level.soap;
  } else if(utility::flag("flag_forest_field_sniper_left_dead")) {
    sniper_shift = sniper_right;
    ai_ally = level.gaz;
  } else {
    if(!isDefined(sniper_left) || !isDefined(sniper_right)) {
      return;
    }

    dist_right = distance2dsquared(level.player.origin, sniper_right.origin);
    dist_left = distance2dsquared(level.player.origin, sniper_left.origin);

    if(dist_right > dist_left) {
      sniper_shift = sniper_right;
      ai_ally = level.gaz;
    } else {
      sniper_shift = sniper_left;
      ai_ally = level.soap;
    }
  }

  if(!isDefined(sniper_shift)) {
    return;
  }

  sniper_shift endon("death");
  sniper_shift namespace_8339f6377b6ba60e::function_30baf67535ddaef0(ai_ally);
  sniper_shift namespace_8339f6377b6ba60e::function_47215dde740a0bc2(level.player);
  utility::waittill_any_ents(level, "flag_forest_field_07", level, "flag_forest_field_sniper_two_remaining", sniper_shift, "flag_sniper_near_any_enemy", sniper_shift, "flag_sniper_no_retreat", self, "death");
  sniper_shift namespace_8339f6377b6ba60e::function_30baf67535ddaef0(level.player);
  sniper_shift namespace_8339f6377b6ba60e::function_47215dde740a0bc2(ai_ally);
}

function function_5a6ddd6265d935cf(var_7c572f708cdf5ef5) {
  self endon("death");
  id = self function_92435c7a6ae85c3c();

  if(isDefined(id)) {
    self leaveinteraction();
  }

  utility::demeanor_override("sprint");
  ai::set_forcegoal();
  vol = getEnt(var_7c572f708cdf5ef5, "targetname");

  while(!self istouching(vol)) {
    wait 1;
  }

  utility::clear_demeanor_override();
  ai::unset_forcegoal();
}

function function_de0d161007e32080() {
  var_ef6acfb71bf03324 = getnodesinradius((2454, -4918, 428) + (32, 32, 0), 256, 0);

  if(isDefined(var_ef6acfb71bf03324) && var_ef6acfb71bf03324.size > 0) {
    foreach(nd_node in var_ef6acfb71bf03324) {
      if(isDefined(nd_node.script_color_allies) && nd_node.script_color_allies == "g53 20") {
        nd_node.script_color_allies = "g53 g44";
        return;
      }
    }
  }
}

function function_1df2467b9beae282() {}

function function_3609e7a245dfc171() {
  namespace_8339f6377b6ba60e::function_4c28f0141619d61a();
  utility::set_start_location("s_start_forest_vista", utility::array_add(level.tundra_allies, level.player));
  function_e202fd10c4a3259e("s_start_forest_vista");
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_forest_stop_nags", "forest_player_progress", "trig_forest");
  level thread function_de1f6c55da055ca9(1);
  level thread namespace_191bb1c1589b3acb::function_84746c3250d67674();
  level.player setmovespeedscale(0.95);
}

function function_627041f6f1c79eb2() {
  utility::autosave_by_name();

  level thread namespace_8339f6377b6ba60e::function_9a2b6bf96312f577("<dev string:x24e>", "<dev string:x25b>");

  level utility::flag_clear("stealth_spotted");
  level utility::flag_set("flag_forest_stop_nags");
  level.player utility::blend_movespeedscale(0.95, 2);
  utility::flag_set("flag_forest_obj_field_snipers_trigger_end");
  level thread namespace_191bb1c1589b3acb::function_6cbbd1bad5361adb();
  level.shepherd enabletraversals(1);
  level thread namespace_8339f6377b6ba60e::function_428a5d30466b574f("trig_forest_vista_player_fall_death", "flag_forest_vista_complete");
  level thread function_90fda098ff7adca6("veh_enemy_heli_lumbermill_start", "flag_forest_vista_03");
  level thread namespace_f74ba02cf5fc717a::function_eaa7e0dde7061f58();
  namespace_8339f6377b6ba60e::function_cd1c0f72e3a0db9a(0);

  if(isDefined(level.player.stealth)) {
    init::set_stealth_mode(0);
    level.var_b8b68f147d0eeb36 = 1;
  }

  level namespace_edf401999ae22ce6::function_d08b184a0f5cca2d();
  level thread namespace_edf401999ae22ce6::function_987973f684e540d0();
  level thread namespace_edf401999ae22ce6::function_b2ee17a0796ff7e6();
  level utility::flag_wait_any("flag_forest_vista_intro_vo_done", "flag_forest_vista_04");
  level namespace_edf401999ae22ce6::function_b52473880235aa();
  level thread namespace_edf401999ae22ce6::function_953f62e8fcae5280();
  level utility::flag_wait("flag_forest_vista_04");
  var_22a77d8254496cce = [level.gaz, level.soap, level.shepherd];

  foreach(ally in var_22a77d8254496cce) {
    ally namespace_8339f6377b6ba60e::function_83e7e4b9d5f7bdb(0, 1, 0);
    ally namespace_8339f6377b6ba60e::function_c9317b6d58796509(1, "combat");
  }

  utility::exploder("vfx_far_smoke");
  level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_forest_stop_nags");
  utility::autosave_by_name();
  msg = level utility::flag_wait_any_return("flag_forest_vista_06", "flag_forest_vista_allies_continue", "flag_lumbermill_vista_explosions");
  level utility::flag_set("flag_forest_vista_allies_continue");
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_forest_stop_nags", "forest_player_progress", "trig_forest");
  ally_array[0] = level.soap;
  ally_array[1] = level.gaz;
  ally_array[2] = level.shepherd;

  for(i = 0; i < ally_array.size; i++) {
    ally_array[i] namespace_8339f6377b6ba60e::function_83e7e4b9d5f7bdb(1, 1, 1);
    start_struct = ally_array[i] namespace_8339f6377b6ba60e::function_bdc421f433af10c7("s_continue_forest_vista");
    ally_array[i] thread function_11fc094b83527d81(start_struct);
    level utility::flag_wait_or_timeout("flag_forest_vista_08", 10);
  }

  level utility::flag_wait("flag_forest_vista_09");
  level thread namespace_edf401999ae22ce6::function_a9ef4c11b383cd35();
  level thread namespace_edf401999ae22ce6::function_89b3f6cded94fd0();
  level thread namespace_edf401999ae22ce6::function_2380d3aa1c1eafdb();
  level thread namespace_edf401999ae22ce6::function_b5f3357d5500263e();
  kill_exploder("vfx_far_smoke");
  level utility::flag_wait("flag_forest_vista_complete");
  level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_forest_stop_nags");
  utility::array_thread(level.tundra_allies, &function_fc737e4dbe3cca47);
  level utility::flag_clear("stealth_spotted");
  level utility::flag_set("flag_forest_stop_nags");
  level.player utility::blend_movespeedscale_default(2);
}

function function_b19cf0d076d19243() {
  namespace_8339f6377b6ba60e::function_cd1c0f72e3a0db9a(0);
  level utility::flag_set("flag_forest_vista_04");
  level utility::flag_set("flag_forest_vista_complete");
}

function function_3acc541b8998aea1() {}

function function_fa434961cf16f730() {}

function function_e202fd10c4a3259e(val, var_4635c7e78c522982, var_564fd1c711cf9ded, n_delay) {
  level utility::flag_set("flag_tundra_allies_in_stealth");
  var_4635c7e78c522982 = utility::default_to(var_4635c7e78c522982, 1);
  var_564fd1c711cf9ded = utility::default_to(var_564fd1c711cf9ded, 0);

  if(istrue(var_564fd1c711cf9ded)) {
    ally_array[0] = level.soap;
    ally_array[1] = level.gaz;
    ally_array[2] = level.shepherd;
  } else {
    ally_array[0] = level.gaz;
    ally_array[1] = level.soap;
    ally_array[2] = level.shepherd;
  }

  for(i = 0; i < ally_array.size; i++) {
    ally = ally_array[i];
    ally.og_grenadeammo = ally.grenadeammo;
    ally utility::set_grenadeammo(0);
    ally namespace_8339f6377b6ba60e::function_c9317b6d58796509(1, "cqb");
    start_struct = ally namespace_8339f6377b6ba60e::function_bdc421f433af10c7(val);

    if(istrue(var_4635c7e78c522982)) {
      ally thread function_11fc094b83527d81(start_struct);
      ally thread function_d7055444f315e75f();
    } else {
      ally thread function_f47ac0cf45308c8b(start_struct);
    }

    if(isDefined(n_delay)) {
      wait n_delay;
      n_delay = undefined;
    }
  }
}

function function_f47ac0cf45308c8b(start_struct) {
  self endon("death");
  utility::set_goalRadius(32);
  goal_node = getnode(start_struct.target, "targetname");

  if(isDefined(goal_node)) {
    self setgoalnode(goal_node);
    level utility::flag_wait(goal_node.script_flag_wait);
    wait randomfloatrange(0.1, 0.9);
  } else {
    goal_node = getStruct(start_struct.target, "targetname");
  }

  assertex(isDefined(goal_node), "Could not find a node or struct with targetname " + start_struct.target);
  start_struct = utility::getStruct(goal_node.target, "targetname");
  thread function_11fc094b83527d81(start_struct);
  thread function_d7055444f315e75f();
}

function function_d7055444f315e75f() {
  self endon("death");
  self endon("stop_follow_the_leader");

  if(self.animname != "shepherd") {
    childthread function_e3b8e5fb74bf3a6();
  }

  minspeed = 0;
  midspeed = 65;
  maxspeed = 160;
  frontdist = -100;
  middist = -200;
  backdist = -300;

  switch (self.animname) {
    case #"hash_df31f98a0b34e496":
      followent = level.player;
      minspeed = 0;
      midspeed = 80;
      maxspeed = 175;
      frontdist = -100;
      middist = -250;
      backdist = -450;
      break;
    case #"hash_831c7a280af6bbca":
      followent = level.gaz;
      minspeed = 0;
      midspeed = 65;
      maxspeed = 180;
      frontdist = 300;
      middist = 175;
      backdist = 100;
      break;
    case #"hash_fb36726c0708cd6d":
    default:
      followent = level.player;
      minspeed = 0;
      midspeed = 95;
      maxspeed = 190;
      frontdist = -200;
      middist = -350;
      backdist = -600;
      break;
  }

  thread utility::enable_dynamic_run_speed(followent, minspeed, midspeed, maxspeed, frontdist, middist, backdist);
}

function function_e3b8e5fb74bf3a6() {
  if(!utility::ent_flag_exist("dynamicRunSpeedWait")) {
    utility::ent_flag_init("dynamicRunSpeedWait");
  }

  while(true) {
    if(!utility::ent_flag("dynamicRunSpeedWait") && istrue(self.dynamicrunspeedwait)) {
      utility::ent_flag_set("dynamicRunSpeedWait");

      if(utility::cointoss()) {
        self allowedstances("crouch");
      }
    } else if(utility::ent_flag("dynamicRunSpeedWait") && !istrue(self.dynamicrunspeedwait)) {
      utility::ent_flag_clear("dynamicRunSpeedWait");
      self allowedstances("stand", "crouch", "prone");
    }

    wait 0.1;
  }
}

function function_fc737e4dbe3cca47() {
  if(self.name == "Farah") {
    return;
  }

  utility::set_grenadeammo(self.og_grenadeammo);
  function_c9317b6d58796509(0, "combat");
  function_dd154acb3806d995();
  function_83e7e4b9d5f7bdb(0, 1, 1);
}

function function_3cf5ccde94b9bda4(a_ai_enemies) {
  self endon("death");
  self endon("stop_aiming");
  self.ai_target = undefined;
  self.last_target = undefined;

  while(true) {
    self.ai_target = function_e2089e43ec601b41(a_ai_enemies);

    if(isDefined(self.ai_target)) {
      if(!isDefined(self.last_target) || self.last_target != self.ai_target) {
        namespace_8339f6377b6ba60e::function_36f4f742e339eedc(self.ai_target);
        self.ai_target.ally_claimed = 1;

        if(isDefined(self.last_target)) {
          self.last_target.ally_claimed = undefined;
        }

        self.last_target = self.ai_target;
      }
    }

    wait randomfloatrange(1, 3);
  }
}

function function_e2089e43ec601b41(a_ai_enemies) {
  self endon("death");

  if(!isDefined(a_ai_enemies)) {
    a_ai_enemies = getaiarrayinradius(self.origin, 1024, "axis");
  }

  ai_target = undefined;
  a_ai_enemies = utility::array_removedead_or_dying(a_ai_enemies);

  if(a_ai_enemies.size == 0) {
    return;
  }

  a_ai_enemies = sortbydistance(a_ai_enemies, self.origin);

  for(i = 0; i < a_ai_enemies.size; i++) {
    if(!istrue(self canshoot(a_ai_enemies[i] getEye()))) {
      continue;
    }

    if(istrue(a_ai_enemies[i].ally_claimed)) {
      continue;
    }

    var_c29546545fcf72af = utility::within_fov(level.player getEye(), level.player getplayerangles(), self getEye(), cos(10));
    var_f190cc5483848b2e = level.player utility::isads();

    if(var_c29546545fcf72af && var_f190cc5483848b2e) {
      continue;
    }

    ai_target = a_ai_enemies[i];
  }

  return ai_target;
}

function function_e575afb10899dd68() {}

function function_de1f6c55da055ca9(b_wait) {
  level.player endon("death");
  level endon("flag_forest_vista_complete");
  level notify("stop_forest_stealth_range_handler");
  level endon("stop_forest_stealth_range_handler");

  if(!isDefined(level.stealth)) {
    manager::main();
  }

  level.stealth.stealth_spotted_delay = 2;
  level.stealth.bstayincombatoncealerted = 1;
  function_d5823c94e8131ea6(1);
  function_3875866b3a6d349(0);
  function_aa9fa9c5a97d0f6e(1);
  b_wait = utility::default_to(b_wait, 0);

  if(istrue(b_wait)) {
    wait 1;
  }

  if(utility::flag("flag_forest_sniper_complete")) {
    function_52f65c9f13a210b9();
  } else {
    function_7fc82b3e0ea45e70();
  }

  var_95e3ce63fd98c401 = 1;

  while(!flag("flag_forest_field_shack_enemies_combat")) {
    var_9c568ea7c192f687 = scripts\sp\utility::function_ebf6c163be94738a();

    if(istrue(var_9c568ea7c192f687) && istrue(var_95e3ce63fd98c401)) {
      if(utility::flag("flag_forest_sniper_complete")) {
        function_dc2f322778dae9cb();
      } else {
        function_9903869735754f2e();
      }

      var_95e3ce63fd98c401 = 0;
    } else if(!istrue(var_95e3ce63fd98c401)) {
      if(utility::flag("flag_forest_sniper_complete")) {
        function_52f65c9f13a210b9();
      } else {
        function_7fc82b3e0ea45e70();
      }

      var_95e3ce63fd98c401 = 1;
    }

    wait 1;
  }

  waitframe();
  level.player utility::set_maxvisibledist(8192);
}

function function_7fc82b3e0ea45e70() {
  hiddenranges["prone"] = 250;
  hiddenranges["crouch"] = 400;
  hiddenranges["stand"] = 800;
  var_b6b642cbeff52b88["prone"] = 150;
  var_b6b642cbeff52b88["crouch"] = 300;
  var_b6b642cbeff52b88["stand"] = 600;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  spottedranges["prone"] = 500;
  spottedranges["crouch"] = 800;
  spottedranges["stand"] = 1200;
  var_d0f35fc0a5c3df79["prone"] = 300;
  var_d0f35fc0a5c3df79["crouch"] = 600;
  var_d0f35fc0a5c3df79["stand"] = 800;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1;
  var_8f3f480583606401["crouch"] = 1.1;
  var_8f3f480583606401["stand"] = 1.2;
  var_fac370d058479827["prone"] = 0;
  var_fac370d058479827["crouch"] = 0;
  var_fac370d058479827["stand"] = 0;
  var_fb574b7959625bf0["prone"] = 0;
  var_fb574b7959625bf0["crouch"] = 0;
  var_fb574b7959625bf0["stand"] = 0;
  utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  utility::set_min_detect_range_darkness(var_b6b642cbeff52b88, var_d0f35fc0a5c3df79);
  utility::function_f3883fe06a11269(var_fac370d058479827, var_fb574b7959625bf0);
}

function function_9903869735754f2e() {
  hiddenranges["prone"] = 200;
  hiddenranges["crouch"] = 300;
  hiddenranges["stand"] = 600;
  var_b6b642cbeff52b88["prone"] = 100;
  var_b6b642cbeff52b88["crouch"] = 200;
  var_b6b642cbeff52b88["stand"] = 400;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  spottedranges["prone"] = 400;
  spottedranges["crouch"] = 750;
  spottedranges["stand"] = 1000;
  var_d0f35fc0a5c3df79["prone"] = 200;
  var_d0f35fc0a5c3df79["crouch"] = 400;
  var_d0f35fc0a5c3df79["stand"] = 750;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1;
  var_8f3f480583606401["crouch"] = 1.1;
  var_8f3f480583606401["stand"] = 1.2;
  var_fac370d058479827["prone"] = 0;
  var_fac370d058479827["crouch"] = 0;
  var_fac370d058479827["stand"] = 0;
  var_fb574b7959625bf0["prone"] = 0;
  var_fb574b7959625bf0["crouch"] = 0;
  var_fb574b7959625bf0["stand"] = 0;
  utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  utility::set_min_detect_range_darkness(var_b6b642cbeff52b88, var_d0f35fc0a5c3df79);
  utility::function_f3883fe06a11269(var_fac370d058479827, var_fb574b7959625bf0);
}

function function_52f65c9f13a210b9() {
  hiddenranges["prone"] = 800;
  hiddenranges["crouch"] = 1000;
  hiddenranges["stand"] = 1200;
  var_b6b642cbeff52b88["prone"] = 400;
  var_b6b642cbeff52b88["crouch"] = 600;
  var_b6b642cbeff52b88["stand"] = 800;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  spottedranges["prone"] = 1600;
  spottedranges["crouch"] = 3200;
  spottedranges["stand"] = 4800;
  var_d0f35fc0a5c3df79["prone"] = 800;
  var_d0f35fc0a5c3df79["crouch"] = 1600;
  var_d0f35fc0a5c3df79["stand"] = 2400;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1;
  var_8f3f480583606401["crouch"] = 1.1;
  var_8f3f480583606401["stand"] = 1.2;
  var_fac370d058479827["prone"] = 0;
  var_fac370d058479827["crouch"] = 0;
  var_fac370d058479827["stand"] = 0;
  var_fb574b7959625bf0["prone"] = 0;
  var_fb574b7959625bf0["crouch"] = 0;
  var_fb574b7959625bf0["stand"] = 0;
  utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  utility::set_min_detect_range_darkness(var_b6b642cbeff52b88, var_d0f35fc0a5c3df79);
  utility::function_f3883fe06a11269(var_fac370d058479827, var_fb574b7959625bf0);
}

function function_dc2f322778dae9cb() {
  hiddenranges["prone"] = 400;
  hiddenranges["crouch"] = 600;
  hiddenranges["stand"] = 800;
  var_b6b642cbeff52b88["prone"] = 100;
  var_b6b642cbeff52b88["crouch"] = 300;
  var_b6b642cbeff52b88["stand"] = 600;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  spottedranges["prone"] = 800;
  spottedranges["crouch"] = 1600;
  spottedranges["stand"] = 3200;
  var_d0f35fc0a5c3df79["prone"] = 600;
  var_d0f35fc0a5c3df79["crouch"] = 1200;
  var_d0f35fc0a5c3df79["stand"] = 2400;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1;
  var_8f3f480583606401["crouch"] = 1.1;
  var_8f3f480583606401["stand"] = 1.2;
  var_fac370d058479827["prone"] = 0;
  var_fac370d058479827["crouch"] = 0;
  var_fac370d058479827["stand"] = 0;
  var_fb574b7959625bf0["prone"] = 0;
  var_fb574b7959625bf0["crouch"] = 0;
  var_fb574b7959625bf0["stand"] = 0;
  utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  utility::set_min_detect_range_darkness(var_b6b642cbeff52b88, var_d0f35fc0a5c3df79);
  utility::function_f3883fe06a11269(var_fac370d058479827, var_fb574b7959625bf0);
}