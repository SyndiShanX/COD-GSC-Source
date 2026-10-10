/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_412aa76130fc9a7b.gsc
*************************************************/

#using script_1031976741eb6674;
#using script_1cc61c7403dfc55f;
#using script_60add030ce1a42b6;
#using script_f8531dcf975a7a7;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\player;
#using scripts\sp\player\ally_equipment;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\trigger;
#using scripts\sp\utility;
#using scripts\sp\vehicle;
#namespace scene;

function function_751affbffa2f9f61() {}

function function_e60c3ad55fae83fd() {
  function_4c28f0141619d61a(1, 1);
  set_start_location("s_start_finale_holdout", [level.player]);
  set_start_location("s_start_finale_holdout", level.tundra_allies);
  function_6c601d0b1308d851();
  level thread function_d86b8533c4e10a61();
  level thread function_26bce73ccc72da96();
  level thread function_d93d73c8ce6287ad();
  level thread function_bd187230688895aa();
  level thread namespace_191bb1c1589b3acb::function_84746c3250d67674();
  level.player setmovespeedscale(1);
}

function function_8a49fc8e888ef2b6() {
  autosave_by_name();

  level thread function_9a2b6bf96312f577("<dev string:x1c>", "<dev string:x2b>");

  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_finale_holdout_stop_nags", "finale_holdout_player_progress");
  level thread namespace_f247b8d258f67b0b::function_3ec4cb695ece5957();
  utility::disable_trigger_with_targetname("trig_finale_player_near_heli");
  array_thread(level.tundra_allies, &function_4dbfebcf97450072);
  level thread function_54c23d497c5105ce();
  level thread function_557c19418ae6de25();
  flag_set("flag_finale_obj_rendezvous");
  level thread function_d13fc097dd50dbba();
  level thread function_c888cc5f1a23fb91();
  level.var_d3a6cfca302d130c = [];
  level.var_7a10e3caa5d4f0a7 = [];
  flag_wait_any("flag_finale_holdout_04", "flag_finale_holdout_intro_enemies_all_dead");
  level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("finale_holdout_player_progress");
  flag_wait("flag_finale_holdout_intro_enemies_all_dead");
  level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("finale_holdout_player_progress");
  flag_wait_or_timeout("flag_finale_player_near_boat", 60);
  flag_set("flag_finale_obj_rendezvous_complete");
  level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_finale_holdout_stop_nags");

  if(!function_7ed882d913504342()) {
    autosave_by_name_silent();
  }

  flag_wait("flag_finale_holdout_intro_dialogue_complete");
  flag_set("flag_finale_holdout_wave_1_incoming");
  flag_set("flag_finale_obj_holdout");
  add_global_spawn_function("axis", &function_1655b3f150ca205c);
  add_global_spawn_function("axis", &function_a466275ca8a6dfcd);
  add_global_spawn_function("axis", &function_2cafb0261265bb10);
  add_extra_autosave_check("autosave_finale_holdout", &function_3290c0dcfe13447d, "Autosave fail - exfil check failed!");

  if(!function_7ed882d913504342()) {
    autosave_by_name_silent();
  }

  array_spawn_function_noteworthy("finale_holdout_enemy_docks_low", &function_c3405ff9bdeeeb7d);
  array_spawn_function_noteworthy("finale_holdout_enemy_docks_high", &function_c3405ff9bdeeeb7d);
  level thread function_2416da5a3acb594c();
  var_6bc2a0261e7850dc = function_9804c98f600b9ce4("veh_finale_enemy_jltv_docks_01", 0);
  level.var_7a10e3caa5d4f0a7 = array_add(level.var_7a10e3caa5d4f0a7, var_6bc2a0261e7850dc);
  var_6bc2a0261e7850dc thread function_4435d4f166a9bf31();
  var_6bc2a0261e7850dc thread function_a0954ea965227e12();
  var_6bc2a0261e7850dc thread function_c899c2d562c0ceca();
  var_6bc2a0261e7850dc thread function_8d18d6cd0c7787bd();
  waitframe();
  var_6bc2a3261e785775 = function_9804c98f600b9ce4("veh_finale_enemy_jltv_docks_02", 0);
  level.var_7a10e3caa5d4f0a7 = array_add(level.var_7a10e3caa5d4f0a7, var_6bc2a3261e785775);
  var_6bc2a3261e785775 thread function_4435d4f166a9bf31();
  var_6bc2a3261e785775 thread function_a0954ea965227e12();
  var_6bc2a3261e785775 thread function_c899c2d562c0ceca();
  var_6bc2a3261e785775 thread function_8d18d6cd0c7787bd();
  waitframe();
  level.var_d3a6cfca302d130c = array_removedead_or_dying(level.var_d3a6cfca302d130c);
  level.var_d3a6cfca302d130c = array_combine(level.var_d3a6cfca302d130c, var_6bc2a0261e7850dc.riders);
  level.var_d3a6cfca302d130c = array_combine(level.var_d3a6cfca302d130c, var_6bc2a3261e785775.riders);
  var_b140234a7c46b181 = level.var_d3a6cfca302d130c;
  var_6bc2a0261e7850dc thread function_32df82f8ae6c2212();
  var_6bc2a0261e7850dc thread namespace_f74ba02cf5fc717a::function_733b42fe33959ee();
  wait 1;
  var_6bc2a3261e785775 thread function_32df82f8ae6c2212();
  var_6bc2a3261e785775 thread namespace_f74ba02cf5fc717a::function_733b42fe33959ee();
  level thread function_57dd478bb085268f(var_6bc2a0261e7850dc, "finale_holdout_enemy_docks_high", "vol_finale_holdout_enemy_docks_low", ["vol_finale_holdout_enemy_right_far", "vol_finale_holdout_enemy_right_center"], "flag_finale_holdout_wave_1_enemies_most_dead");
  level thread function_57dd478bb085268f(var_6bc2a3261e785775, "finale_holdout_enemy_docks_low", "vol_finale_holdout_enemy_right_front", "vol_finale_holdout_enemy_right_back", "flag_finale_holdout_wave_1_enemies_most_dead");
  waitframe();
  level thread function_7cf3b8f1b807889a(var_b140234a7c46b181, "flag_finale_holdout_wave_1_enemies_half_dead", int(var_b140234a7c46b181.size * 0.5));
  level thread function_7cf3b8f1b807889a(var_b140234a7c46b181, "flag_finale_holdout_wave_1_enemies_most_dead", int(var_b140234a7c46b181.size * 0.85));
  level thread function_7cf3b8f1b807889a(var_b140234a7c46b181, "flag_finale_holdout_wave_1_enemies_all_dead");
  level thread function_39e6ace42be79eaa([var_6bc2a0261e7850dc, var_6bc2a3261e785775], "flag_finale_holdout_wave_1_vehicles_all_dead");
  msg = flag_wait_any_return("flag_finale_holdout_wave_1_enemies_most_dead", "flag_finale_holdout_wave_1_enemies_half_dead");

  if(msg != "flag_finale_holdout_wave_1_enemies_most_dead" && !level utility::flag("flag_finale_holdout_wave_1_vehicles_all_dead")) {
    flag_wait_or_timeout("flag_finale_holdout_wave_1_enemies_most_dead", 10);
  }

  flag_set("flag_finale_holdout_wave_2_incoming");

  if(!function_7ed882d913504342()) {
    autosave_by_name_silent();
  }

  array_spawn_function_noteworthy("ai_enemy_jltv_finale_right_01", &function_e85978dfabc2f195);
  var_9fd0809f9d5c3a52 = function_9804c98f600b9ce4("veh_finale_enemy_jltv_right_01", 1);
  level.var_7a10e3caa5d4f0a7 = array_add(level.var_7a10e3caa5d4f0a7, var_9fd0809f9d5c3a52);
  var_6085d9e7bdecbe1 = var_9fd0809f9d5c3a52 function_c365d01fbb73c2d7("flag_finale_holdout_wave_3_incoming");
  level.var_d3a6cfca302d130c = array_add(level.var_d3a6cfca302d130c, var_6085d9e7bdecbe1);
  var_9fd0809f9d5c3a52 thread function_4435d4f166a9bf31();
  var_9fd0809f9d5c3a52 thread function_a0954ea965227e12();
  var_9fd0809f9d5c3a52 thread function_c899c2d562c0ceca();
  var_9fd0809f9d5c3a52 thread function_8d18d6cd0c7787bd();
  waitframe();
  array_spawn_function_noteworthy("ai_enemy_jltv_finale_center_01", &function_e85978dfabc2f195);
  var_a73128f92bc6aeab = function_9804c98f600b9ce4("veh_finale_enemy_jltv_center_01", 1);
  level.var_7a10e3caa5d4f0a7 = array_add(level.var_7a10e3caa5d4f0a7, var_a73128f92bc6aeab);
  var_eb894b97323853dc = var_a73128f92bc6aeab function_c365d01fbb73c2d7("flag_finale_holdout_wave_3_incoming");
  level.var_d3a6cfca302d130c = array_add(level.var_d3a6cfca302d130c, var_eb894b97323853dc);
  var_a73128f92bc6aeab thread function_4435d4f166a9bf31();
  var_a73128f92bc6aeab thread function_a0954ea965227e12();
  var_a73128f92bc6aeab thread function_c899c2d562c0ceca();
  var_a73128f92bc6aeab thread function_8d18d6cd0c7787bd();
  waitframe();
  level.var_d3a6cfca302d130c = array_removedead_or_dying(level.var_d3a6cfca302d130c);
  level.var_d3a6cfca302d130c = array_combine(level.var_d3a6cfca302d130c, var_9fd0809f9d5c3a52.riders);
  level.var_d3a6cfca302d130c = array_combine(level.var_d3a6cfca302d130c, var_a73128f92bc6aeab.riders);
  var_b140204a7c46aae8 = level.var_d3a6cfca302d130c;
  var_9fd0809f9d5c3a52 thread function_32df82f8ae6c2212();
  var_9fd0809f9d5c3a52 thread namespace_f74ba02cf5fc717a::function_733b42fe33959ee();
  wait 1;
  var_a73128f92bc6aeab thread function_32df82f8ae6c2212();
  var_a73128f92bc6aeab thread namespace_f74ba02cf5fc717a::function_733b42fe33959ee();
  level thread function_57dd478bb085268f(var_9fd0809f9d5c3a52, "ai_enemy_jltv_finale_right_01", "vol_finale_holdout_enemy_right_front", "vol_finale_holdout_enemy_right_center", "flag_finale_holdout_wave_2_enemies_most_dead", "ai_enemy_backup_finale_right");
  level thread function_57dd478bb085268f(var_a73128f92bc6aeab, "ai_enemy_jltv_finale_center_01", "vol_finale_holdout_enemy_center_front", "vol_finale_holdout_enemy_right_front", "flag_finale_holdout_wave_2_enemies_most_dead", "ai_enemy_backup_finale_center");
  waitframe();
  level thread function_7cf3b8f1b807889a(var_b140204a7c46aae8, "flag_finale_holdout_wave_2_enemies_half_dead", int(var_b140204a7c46aae8.size * 0.5));
  level thread function_7cf3b8f1b807889a(var_b140204a7c46aae8, "flag_finale_holdout_wave_2_enemies_most_dead", int(var_b140204a7c46aae8.size * 0.85));
  level thread function_7cf3b8f1b807889a(var_b140204a7c46aae8, "flag_finale_holdout_wave_2_enemies_all_dead");
  level thread function_39e6ace42be79eaa([var_9fd0809f9d5c3a52, var_a73128f92bc6aeab], "flag_finale_holdout_wave_2_vehicles_all_dead");
  msg = flag_wait_any_return("flag_finale_holdout_wave_2_enemies_most_dead", "flag_finale_holdout_wave_2_enemies_half_dead");

  if(msg != "flag_finale_holdout_wave_2_enemies_most_dead" && !level utility::flag("flag_finale_holdout_wave_2_vehicles_all_dead")) {
    flag_wait_or_timeout("flag_finale_holdout_wave_2_enemies_most_dead", 10);
  }

  flag_set("flag_finale_holdout_wave_3_incoming");
  level thread function_c68a50555ca28c1a(var_b140204a7c46aae8);

  if(!function_7ed882d913504342()) {
    autosave_by_name_silent();
  }

  gameskill = level.player utility::get_player_gameskill();

  switch (gameskill) {
    case 3:
    case 4:
      var_93f007bb7bfa0207 = 1;
      var_93f006bb7bf9ffd4 = cointoss();
      break;
    case 1:
    case 2:
      var_93f007bb7bfa0207 = cointoss();
      var_93f006bb7bf9ffd4 = !var_93f007bb7bfa0207;
      break;
    case 0:
    default:
      var_93f007bb7bfa0207 = cointoss();
      var_93f006bb7bf9ffd4 = 0;
      break;
  }

  array_spawn_function_noteworthy("ai_enemy_jltv_finale_left_01", &function_e85978dfabc2f195);
  array_spawn_function_noteworthy("ai_enemy_jltv_finale_left_02", &function_e85978dfabc2f195);
  array_spawn_function_noteworthy("ai_enemy_jltv_finale_left_03", &function_e85978dfabc2f195);
  var_6e642148e7c93953 = function_9804c98f600b9ce4("veh_finale_enemy_jltv_left_01", 1);
  level.var_7a10e3caa5d4f0a7 = array_add(level.var_7a10e3caa5d4f0a7, var_6e642148e7c93953);
  var_1c4ece350478510 = var_6e642148e7c93953 function_c365d01fbb73c2d7("flag_finale_holdout_final_enemies_most_dead");
  level.var_d3a6cfca302d130c = array_add(level.var_d3a6cfca302d130c, var_1c4ece350478510);
  var_6e642148e7c93953 thread function_4435d4f166a9bf31();
  var_6e642148e7c93953 thread function_a0954ea965227e12();
  var_6e642148e7c93953 thread function_c899c2d562c0ceca();
  var_6e642148e7c93953 thread function_8d18d6cd0c7787bd();
  waitframe();
  var_6e642248e7c93b86 = function_9804c98f600b9ce4("veh_finale_enemy_jltv_left_02", 1);
  level.var_7a10e3caa5d4f0a7 = array_add(level.var_7a10e3caa5d4f0a7, var_6e642248e7c93b86);
  var_4ecd2124fb8a876f = var_6e642248e7c93b86 function_c365d01fbb73c2d7("flag_finale_holdout_final_enemies_half_dead", var_93f007bb7bfa0207);
  level.var_d3a6cfca302d130c = array_add(level.var_d3a6cfca302d130c, var_4ecd2124fb8a876f);
  var_6e642248e7c93b86 thread function_4435d4f166a9bf31();
  var_6e642248e7c93b86 thread function_a0954ea965227e12();
  var_6e642248e7c93b86 thread function_c899c2d562c0ceca();
  var_6e642248e7c93b86 thread function_8d18d6cd0c7787bd();
  waitframe();
  var_6e642348e7c93db9 = function_9804c98f600b9ce4("veh_finale_enemy_jltv_left_03", 1);
  level.var_7a10e3caa5d4f0a7 = array_add(level.var_7a10e3caa5d4f0a7, var_6e642348e7c93db9);
  var_e3064f262c68f3a = var_6e642348e7c93db9 function_c365d01fbb73c2d7("flag_finale_holdout_final_enemies_half_dead", var_93f006bb7bf9ffd4);
  level.var_d3a6cfca302d130c = array_add(level.var_d3a6cfca302d130c, var_e3064f262c68f3a);
  var_6e642348e7c93db9 thread function_4435d4f166a9bf31();
  var_6e642348e7c93db9 thread function_a0954ea965227e12();
  var_6e642348e7c93db9 thread function_c899c2d562c0ceca();
  var_6e642348e7c93db9 thread function_8d18d6cd0c7787bd();
  waitframe();
  level.var_d3a6cfca302d130c = array_combine(level.var_d3a6cfca302d130c, var_6e642148e7c93953.riders);
  level.var_d3a6cfca302d130c = array_combine(level.var_d3a6cfca302d130c, var_6e642248e7c93b86.riders);
  level.var_d3a6cfca302d130c = array_combine(level.var_d3a6cfca302d130c, var_6e642348e7c93db9.riders);
  var_6e642148e7c93953 thread function_32df82f8ae6c2212();
  var_6e642148e7c93953 thread namespace_f74ba02cf5fc717a::function_733b42fe33959ee();
  wait 1;
  var_6e642248e7c93b86 thread function_32df82f8ae6c2212();
  var_6e642248e7c93b86 thread namespace_f74ba02cf5fc717a::function_733b42fe33959ee();
  level flag_wait_any("flag_veh_finale_enemy_jltv_left_01_clear", "flag_veh_finale_enemy_jltv_left_02_clear");
  wait 1;
  var_6e642348e7c93db9 thread function_32df82f8ae6c2212();
  var_6e642348e7c93db9 thread namespace_f74ba02cf5fc717a::function_733b42fe33959ee();
  level thread function_57dd478bb085268f(var_6e642148e7c93953, "ai_enemy_jltv_finale_left_01", "vol_finale_holdout_enemy_left_front", "vol_finale_holdout_enemy_left_far", "flag_finale_holdout_final_enemies_half_dead", "ai_enemy_backup_finale_left_01");
  level thread function_57dd478bb085268f(var_6e642248e7c93b86, "ai_enemy_jltv_finale_left_02", "vol_finale_holdout_enemy_left_front", "vol_finale_holdout_enemy_left_front", "flag_finale_holdout_final_enemies_half_dead", "ai_enemy_backup_finale_left_01");
  level thread function_57dd478bb085268f(var_6e642348e7c93db9, "ai_enemy_jltv_finale_left_03", "vol_finale_holdout_enemy_left_front", ["vol_finale_holdout_enemy_left_center", "vol_finale_holdout_enemy_left_far"], "flag_finale_holdout_final_enemies_half_dead", "ai_enemy_backup_finale_left_02");
  level.var_d3a6cfca302d130c = array_removedead_or_dying(level.var_d3a6cfca302d130c);
  level thread function_7cf3b8f1b807889a(level.var_d3a6cfca302d130c, "flag_finale_holdout_final_enemies_most_dead", int(level.var_d3a6cfca302d130c.size * 0.75));
  level thread function_7cf3b8f1b807889a(level.var_d3a6cfca302d130c, "flag_finale_holdout_final_enemies_half_dead", int(level.var_d3a6cfca302d130c.size * 0.5));
  level thread function_7cf3b8f1b807889a(level.var_d3a6cfca302d130c, "flag_finale_holdout_final_enemies_all_dead");
  level thread function_39e6ace42be79eaa([var_6e642148e7c93953, var_6e642248e7c93b86, var_6e642348e7c93db9], "flag_finale_holdout_wave_3_vehicles_most_dead", 2);
  level thread function_39e6ace42be79eaa([var_6e642148e7c93953, var_6e642248e7c93b86, var_6e642348e7c93db9], "flag_finale_holdout_wave_3_vehicles_all_dead");
  utility::flag_wait_any_timeout(45, "flag_finale_holdout_final_enemies_all_dead", "flag_finale_holdout_final_enemies_most_dead");

  if(!utility::flag("flag_finale_holdout_final_enemies_all_dead") && !level utility::flag("flag_finale_holdout_wave_3_vehicles_most_dead")) {
    level thread function_12c91b42fbb66d17(level.var_d3a6cfca302d130c);
    utility::flag_wait_or_timeout("flag_finale_holdout_final_enemies_all_dead", 15);
  }

  if(level utility::flag("flag_finale_holdout_final_enemies_all_dead")) {
    level utility::flag_wait("flag_finale_holdout_clear_dialogue_played");
  }

  level flag_set("flag_finale_holdout_complete");
  level flag_set("flag_finale_obj_holdout_complete");
  level.player set_attackeraccuracy(1);
  scripts\engine\sp\utility::remove_extra_autosave_check("autosave_finale_holdout");
}

function function_83cf07e21d98eebf() {
  level flag_set("flag_finale_holdout_final_enemies_all_dead");
  level flag_set("flag_finale_holdout_complete");
  level flag_set("flag_finale_obj_rendezvous");
  level flag_set("flag_finale_obj_rendezvous_complete");
  level flag_set("flag_finale_obj_holdout");
  level flag_set("flag_finale_obj_holdout_complete");
}

function function_7108c081e996b9a9() {}

function function_15ff29f3be957a62() {
  function_4c28f0141619d61a(1, 1);
  set_start_location("s_start_finale_exfil", [level.player]);
  set_start_location("s_start_finale_exfil", level.tundra_allies);
  function_6c601d0b1308d851();
  level thread function_d13fc097dd50dbba();
  level thread function_d86b8533c4e10a61();
  level thread function_557c19418ae6de25();
  level thread function_26bce73ccc72da96();
  level thread function_d93d73c8ce6287ad();
  level thread function_54c23d497c5105ce();
  level.player setmovespeedscale(1);
}

function function_2ce2e5069f5e9b73() {
  autosave_by_name();
  level.player set_attackeraccuracy(0.5);
  level.soap thread scripts\sp\player\ally_equipment::ally_equipment_remove();

  level thread function_9a2b6bf96312f577("<dev string:x48>", "<dev string:x55>");

  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_finale_exfil_stop_nags", "finale_exfil_player_progress");
  level thread namespace_f247b8d258f67b0b::function_b8d9607e1e2b1692();
  array_thread(level.tundra_allies, &function_8f6b18d7ae327223);
  level thread scene_1000();
  level thread function_ad0ba46db9f0e798();
  trig_finale_player_near_heli = getEnt("trig_finale_player_near_heli", "targetname");
  trig_finale_player_near_heli utility::trigger_on();

  if(!level.player istouching(trig_finale_player_near_heli)) {
    level flag_wait("flag_finale_player_near_heli");
  }

  level thread namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_finale_exfil_stop_nags");
  level flag_wait("flag_finale_exfil_outro_begin");
  level.player scripts\sp\player::focusdisable();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  registered = "igc_finale";
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "show_hud", 0);
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "damage", 0);
  level.player val::set(registered, "death", 0);
  level.player val::set(registered, "freezecontrols", 1);
  level.player val::set(registered, "ignoreme", 1);
  level flag_wait("flag_finale_exfil_complete");
  level.player enabledeathshield(0);
  function_424a17e2d52610fb();
  utility::nextmission();
}

function function_424a17e2d52610fb() {
  level thread play_skippable_cinematic("sp_jup_tundra_cine_outro", undefined, undefined, 0, 1);
  cinematic_waittill_skip_or_time(105);
  blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 1);
  wait 0.1;
}

function function_c9033c8590b6d7e8() {
  level flag_set("flag_finale_exfil_complete");
  level flag_set("flag_finale_obj_exfil");
  level flag_set("flag_finale_obj_exfil_complete");
}

function function_8f6b18d7ae327223() {
  self endon("death");
  level flag_wait("flag_finale_exfil_heli_land_end");
  wait randomfloatrange(0.5, 1.5);
  nd_heli = function_bdc421f433af10c7("nd_finale_exfil_ally_heli");
  set_fixednode_true();
  set_goal_radius(32);
  set_goal_node(nd_heli);
}

function function_ad0ba46db9f0e798() {
  level flag_wait("flag_finale_exfil_heli_land_begin");
  exploder("vfx_finale_heli_landing_wash");
  vol = getEnt("vol_finale_exfil_under_heli", "targetname");
  level.player waittill("heli_near_landing");

  while(!flag("flag_finale_exfil_heli_land_end")) {
    if(level.player istouching(vol)) {
      scripts\sp\player_death::set_custom_death_quote(520, 0);
      level.player kill();
      return;
    }

    waitframe();
  }

  var_a9cb4319e84832d7 = getEntArray("e_finale_exfil_helo_clip", "targetname");

  foreach(clip in var_a9cb4319e84832d7) {
    clip disconnectPaths();
    clip solid();
  }

  exfil_hint = getStruct("s_obj_finale_exfil", "targetname");
  var_54b88986396a5b38 = 30;
  var_d9d0ca00e7cf9fb5 = 40;
  exfil_hint scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_TUNDRA/FINALE_EXFIL_HINT", undefined, 500, var_d9d0ca00e7cf9fb5, 1, undefined, undefined, undefined, undefined, undefined, undefined, var_54b88986396a5b38);
  exfil_hint waittill("trigger");
  level.player enabledeathshield(1);
  thread function_8615a6b7cd263577();
  level.player scripts\sp\player::focusdisable();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  level flag_set("flag_finale_exfil_outro_begin");
}

function function_8615a6b7cd263577() {
  setmusicstate("mx_tundra_exfil");
}

function function_9a6ce6b46c9fea1() {}

function function_d13fc097dd50dbba() {
  var_a6e0cbec78d07c8d = utility::getStructArray("s_finale_veh_fire", "targetname");

  foreach(struct in var_a6e0cbec78d07c8d) {
    trigger = spawn("trigger_radius_fire", struct.origin, 0, 40, 96);
    level thread scripts\sp\trigger::trigger_fire(trigger);
  }
}

function function_32df82f8ae6c2212(var_f95e1cad859cbd7a) {
  self endon("death");
  thread scripts\common\vehicle::vehicle_lights_on("headlights");
  self vehicle_turnengineon();
  vol_badplace = getEnt("vol_" + self.targetname + "_badplace", "targetname");

  if(isDefined(vol_badplace)) {
    thread function_b8055651d256a10a(vol_badplace);
  }

  thread function_6b4c0678eb3a553a(self.targetname + "_start", "script_noteworthy", var_f95e1cad859cbd7a);
  ent_flag_wait("flag_finale_veh_path_end");
  thread namespace_8339f6377b6ba60e::function_5717b4e7fcce1693(0, 0, "vfx_veh_tread_kickups");
}

function function_b8055651d256a10a(vol_badplace) {
  str_clear = "flag_" + self.targetname + "_clear";
  navobstacleid = function_5fe0e6caaa579d06(vol_badplace, str_clear);

  if(isDefined(navobstacleid)) {
    level flag_wait(str_clear);
    destroynavobstacle(navobstacleid);
  }
}

function function_5fe0e6caaa579d06(vol_badplace, str_clear) {
  level endon(str_clear);

  if(flag(str_clear)) {
    return;
  }

  if(!ent_flag_exist("flag_finale_veh_jltv_approaching")) {
    ent_flag_init("flag_finale_veh_jltv_approaching");
  }

  ent_flag_wait("flag_finale_veh_jltv_approaching");
  navobstacleid = createnavbadplacebyent(vol_badplace);
  return navobstacleid;
}

function function_19d8ef210f5769cd() {
  driver = undefined;

  if(isDefined(self.driver)) {
    driver = self.driver;
  } else if(isDefined(self.riders) && self.riders.size > 0) {
    foreach(rider in self.riders) {
      if(isDefined(rider.vehicle_position) && rider.vehicle_position == 0) {
        driver = rider;
        break;
      }
    }
  }

  return driver;
}

function function_2499f3dd15248b32(b_godon) {
  self.script_ai_invulnerable = 1;
  vehicle::function_36dbb623c325c79(!b_godon);
}

function function_6e7c8bbe80393aa6(guy) {
  guy endon("entitydeleted");
  self waittill("death");

  if(isDefined(guy)) {
    guy delete();
  }
}

function function_3fb60673f2408025() {}

function function_9804c98f600b9ce4(str_targetname, var_f90bfee2d96cb111) {
  var_f90bfee2d96cb111 = default_to(var_f90bfee2d96cb111, 0);
  vehicle = spawn_vehicle_from_targetname(str_targetname);
  vehicle.trail_vfx = getfx("vfx_veh_tread_kickups");
  playFXOnTag(vehicle.trail_vfx, vehicle, "tag_origin");
  vehicle.animname = "finale_jltv";
  vehicle thread function_3f8aff4b8975850e();
  vehicle thread namespace_8339f6377b6ba60e::function_a766c8499d8da8c0(var_f90bfee2d96cb111);
  vehicle thread namespace_8339f6377b6ba60e::function_57887b971037db5();

  if(istrue(var_f90bfee2d96cb111)) {
    vehicle function_cdbb9f5511d53838();
  }

  return vehicle;
}

function function_3f8aff4b8975850e() {
  str_name = self.script_noteworthy;
  self waittill("death", attacker);

  if(isDefined(attacker)) {
    if(attacker == level.player) {
      level notify("player_killed_jltv");

      iprintln("<dev string:x70>" + str_name);
    }
  }
}

function function_8d18d6cd0c7787bd() {
  str_clear = "flag_" + self.targetname + "_clear";
  str_dead = "flag_" + self.targetname + "_dead";
  msg = waittill_any_return("death", "reached_path_end", "driver dead", "tire_blown", "flag_finale_veh_path_end");
  ent_flag_set("flag_finale_jltv_stopped");
  level flag_set(str_clear);

  if(msg == "death") {
    level flag_set(str_dead);
  }

  waitframe();

  if(isDefined(self)) {
    thread namespace_8339f6377b6ba60e::function_5717b4e7fcce1693(0, 0, "vfx_veh_tread_kickups");

    if(msg != "death") {
      self waittill("death");
      level flag_set(str_dead);
    }
  }
}

function function_4435d4f166a9bf31() {
  self endon("death");
  self endon("entitydeleted");

  if(!ent_flag_exist("flag_finale_jltv_godoff")) {
    ent_flag_init("flag_finale_jltv_godoff");
  }

  if(!ent_flag_exist("flag_finale_veh_path_end")) {
    ent_flag_init("flag_finale_veh_path_end");
  }

  function_2499f3dd15248b32(1);

  while(true) {
    if(ent_flag("flag_finale_jltv_godoff") || ent_flag("flag_finale_veh_path_end")) {
      break;
    }

    wait 0.5;
  }

  function_2499f3dd15248b32(0);
  thread namespace_8339f6377b6ba60e::function_965963a12a43eeeb();
  thread function_948bb2eb851fcb33();
}

function function_948bb2eb851fcb33() {
  self endon("death");

  while(!ent_flag("flag_finale_veh_path_end")) {
    var_c3db265fefdb8d4 = function_9fb6b2244163f2a1();

    if(var_c3db265fefdb8d4.size > 0) {
      self notify("tire_blown");
      self.tire_blown = 1;
      thread namespace_8339f6377b6ba60e::function_5717b4e7fcce1693(randomfloatrange(1, 3), 1, "vfx_veh_tread_kickups", 1);
      return;
    }

    waitframe();
  }
}

function function_a0954ea965227e12() {
  self endon("death");
  driver = function_19d8ef210f5769cd();

  if(!isDefined(driver)) {
    return;
  }

  self.script_allow_rider_deaths = 1;
  self.script_allow_driver_death = 0;
  self.script_keepdriver = undefined;
  self.vehicle_keeps_going_after_driver_dies = 1;
  self.donotunloadondriverdeath = 1;
  driver set_ignoreme(1);
  driver thread utility::deletable_magic_bullet_shield();
  ent_flag_wait_either("flag_finale_jltv_godoff", "flag_finale_veh_path_end");
  self.script_allow_driver_death = 1;

  if(isDefined(driver.magic_bullet_shield) && istrue(driver.magic_bullet_shield)) {
    driver stop_magic_bullet_shield();
  }

  msg = driver waittill_any_return("death", "unload");

  if(msg == "unload") {
    driver set_ignoreme(0);
    return;
  }

  self notify("driver dead");
  self.driver_dead = 1;
  thread namespace_8339f6377b6ba60e::function_5717b4e7fcce1693(randomfloatrange(0.5, 1.5), 1, "vfx_veh_tread_kickups", 1);
}

function function_4b658b8cd9820a04() {}

function function_c365d01fbb73c2d7(var_fc85769059551ba8, var_e6838d192024f561) {
  self endon("death");

  if(!isDefined(self.passenger_ai)) {
    self.passenger_ai = [];
  }

  var_e6838d192024f561 = default_to(var_e6838d192024f561, 0);
  wait 1;
  str_spawner = "ai_enemy_finale_jltv_lmg";

  if(istrue(var_e6838d192024f561)) {
    str_spawner = "ai_enemy_finale_jltv_rpg";
  }

  spawner = getspawner(str_spawner, "targetname");
  guy = spawner spawn_ai(1);
  spawner.count++;

  if(!ent_flag_exist("flag_finale_veh_gunner_stand")) {
    ent_flag_init("flag_finale_veh_gunner_stand");
  }

  self.passenger_ai[self.passenger_ai.size] = guy;
  guy.ignoreme = 1;
  guy.ignoreall = 1;
  guy.dontevershoot = 1;
  self.turret_guy = guy;
  guy.turret_guy = 1;
  guy.var_cbd87a0bc497b778 = 1;
  guy.grenadeammo = 0;
  guy.cannotmelee = 1;
  guy.dropweapon = 0;
  guy function_9215ce6fc83759b9(5000);
  guy set_maxfaceenemydist(5000);
  guy set_maxvisibledist(5000);
  guy set_maxsightdistsquared(25000000);
  guy set_ignoresuppression(1);
  guy.var_55a29022cf7abdad = 100;
  guy.var_39887ba979a993ab = 1500;
  guy.disablepistol = 1;
  thread function_6e7c8bbe80393aa6(guy);
  guy.noragdoll = 1;
  guy allowedstances("crouch");
  z_offset = 0;

  if(istrue(var_e6838d192024f561)) {
    z_offset = 4;
  }

  var_1b3bdabcb782eb2a = 20;
  tag_name = "tag_seat_wm_4";
  point = self gettagorigin(tag_name) + anglestoright(self.angles) * var_1b3bdabcb782eb2a + (0, 0, z_offset);
  guy dontinterpolate();
  teleport_angles = self.angles;
  guy forceteleport(point, teleport_angles);
  guy linkTo(self, tag_name);
  thread function_3a16332940ba7c62(guy, var_e6838d192024f561);

  if(isDefined(var_fc85769059551ba8)) {
    thread function_c458adefdbcac6af(guy, var_fc85769059551ba8);
  }

  return guy;
}

function function_c458adefdbcac6af(guy, var_fc85769059551ba8) {
  guy endon("death");
  str_clear = "flag_" + self.targetname + "_clear";
  msg = flag_wait_any_return(var_fc85769059551ba8, str_clear);

  if(msg == str_clear) {
    if(isDefined(guy.magic_bullet_shield) && istrue(guy.magic_bullet_shield)) {
      guy stop_magic_bullet_shield();
    }

    guy allowedstances("stand");
    utility::flag_wait(var_fc85769059551ba8);
  }

  guy.ignoreme = 0;
  wait randomfloatrange(1, 3);
  guy set_attackeraccuracy(3);
  guy set_baseaccuracy(0.75);
  guy ai::function_dd21d67ede8ba22(int(guy.health * 0.25) + 1);
  msg = flag_wait_any_return("flag_finale_holdout_complete", "flag_finale_holdout_final_enemies_half_dead");

  if(msg == "flag_finale_holdout_final_enemies_half_dead") {
    flag_wait_or_timeout("flag_finale_holdout_complete", randomfloatrange(5, 15));
  }

  wait randomfloatrange(1, 3);
  guy set_attackeraccuracy(5);
  guy set_baseaccuracy(0.5);
  guy ai::function_dd21d67ede8ba22(int(self.health * 0.1) + 1);
}

function function_3a16332940ba7c62(guy, var_e6838d192024f561) {
  self endon("death");
  guy endon("death");
  level.player endon("death");
  ent_flag_wait_either("flag_finale_veh_gunner_stand", "flag_finale_jltv_godoff");

  if(isDefined(guy.magic_bullet_shield) && istrue(guy.magic_bullet_shield)) {
    guy stop_magic_bullet_shield();
  }

  ent_flag_wait("flag_finale_veh_gunner_stand");
  guy allowedstances("stand");
  wait randomfloatrange(0.5, 1.5);
  guy.dontevershoot = 0;
  guy.ignoreall = 0;

  if(istrue(var_e6838d192024f561)) {
    guy set_baseaccuracy(0.3);
    guy getenemyinfo(level.player);
  } else {
    guy set_baseaccuracy(0.8);
    guy getenemyinfo(level.player);
    guy.lastenemysightpos = level.player.origin;
    guy set_favoriteenemy(level.player);
  }

  ent_flag_wait_either("flag_finale_veh_path_end", "flag_finale_jltv_stopped");
  wait randomfloatrange(1, 3);
  guy set_attackeraccuracy(0.25);
  guy set_ignoreme(0);

  if(istrue(var_e6838d192024f561)) {
    guy set_baseaccuracy(0.6);
    return;
  }

  guy set_baseaccuracy(1);
}

function function_a847637332075f0d() {}

function function_bd187230688895aa() {
  array_spawn_function_targetname("ai_finale_holdout_intro", &function_b180bde08049b3b3);
  var_d568604f4b5867da = array_spawn_targetname("ai_finale_holdout_intro", 1);
  level thread function_7cf3b8f1b807889a(var_d568604f4b5867da, "flag_finale_holdout_intro_enemies_half_dead", int(var_d568604f4b5867da.size * 0.5));
  level thread function_7cf3b8f1b807889a(var_d568604f4b5867da, "flag_finale_holdout_intro_enemies_all_dead");
  flag_wait_all("flag_finale_holdout_intro_enemies_half_dead", "flag_finale_holdout_05");
  flag_set("flag_finale_holdout_intro_nerf");
  level utility::flag_wait("flag_finale_player_near_boat");
  var_d568604f4b5867da = array_removedead_or_dying(var_d568604f4b5867da);

  if(var_d568604f4b5867da.size > 0) {
    namespace_8339f6377b6ba60e::function_b1b9d62a34ca27a0(var_d568604f4b5867da, 1);
  }
}

function function_b180bde08049b3b3() {
  self endon("death");
  set_grenadeammo(0);
  set_attackeraccuracy(0.25);
  set_baseaccuracy(0.5);
  disable_long_death();
  self.dropweapon = 0;
  thread function_9282b11cff0b229c();

  while(true) {
    if(isDefined(level.ghost) && isai(level.ghost)) {
      break;
    }

    waitframe();
  }

  set_favoriteenemy(level.ghost);
  level flag_wait_any("flag_finale_holdout_intro_player_kill", "flag_finale_holdout_05");
  wait randomfloatrange(1, 3);
  set_attackeraccuracy(2);
  set_baseaccuracy(0.9);
  self.favoriteenemy = undefined;
  self getenemyinfo(level.player);
  level flag_wait_any("flag_finale_player_near_boat", "flag_finale_holdout_intro_nerf");
  set_attackeraccuracy(5);
  set_baseaccuracy(0.75);
  ai::function_dd21d67ede8ba22(int(self.health * 0.1) + 1);
  self.balwayscoverexposed = 1;
}

function function_9282b11cff0b229c() {
  level.player endon("death");
  level endon("flag_finale_holdout_intro_player_kill");
  self waittill("death", attacker);

  if(isDefined(attacker) && isPlayer(attacker)) {
    flag_set("flag_finale_holdout_intro_player_kill");
  }
}

function function_57dd478bb085268f(var_3469f286a5a240f9, ai_noteworthy, var_6c42bffef6c0a5df, var_8160b6a55ba981df, var_a114aa815e9dac0a, ai_backup) {
  if(isDefined(var_3469f286a5a240f9)) {
    str_clear = "flag_" + var_3469f286a5a240f9.targetname + "_clear";
    level flag_wait(str_clear);
  }

  var_a2d5178999799316 = 1;
  var_387c1bcfb4cd98b4 = 2;
  var_f702381a60199c14 = 3;
  var_994feef463f139c = 4.5;
  var_450c547dd2183cca = 6;
  var_2f4b3471f66b28f1 = 75;

  if(isarray(var_6c42bffef6c0a5df)) {
    a_vols = [];

    foreach(str_vol in var_6c42bffef6c0a5df) {
      a_vols[a_vols.size] = getEnt(str_vol, "targetname");
    }

    var_cb5c10eb3a3a7443 = a_vols;
  } else {
    var_cb5c10eb3a3a7443 = getEnt(var_6c42bffef6c0a5df, "targetname");
  }

  if(isarray(var_8160b6a55ba981df)) {
    a_vols = [];

    foreach(str_vol in var_8160b6a55ba981df) {
      a_vols[a_vols.size] = getEnt(str_vol, "targetname");
    }

    vol_flank = a_vols;
  } else {
    vol_flank = getEnt(var_8160b6a55ba981df, "targetname");
  }

  var_94d08343de33ee25 = utility::get_living_ai_array(ai_noteworthy, "script_noteworthy");
  var_94d08343de33ee25 = utility::array_removedead_or_dying(var_94d08343de33ee25);

  if(var_94d08343de33ee25.size == 0) {
    if(isDefined(ai_backup) && !utility::flag("flag_finale_holdout_wave_2_enemies_half_dead")) {
      spawners = getspawnerarray(ai_backup);

      if(spawners.size == 0) {
        return;
      }

      iprintln("<dev string:x88>" + ai_backup);

      array_spawn_function_targetname(ai_backup, &function_1b957e2b7af09073);
      var_94d08343de33ee25 = utility::array_spawn_targetname(ai_backup, 1);
      level.var_d3a6cfca302d130c = array_combine(level.var_d3a6cfca302d130c, var_94d08343de33ee25);
    } else {
      return;
    }
  }

  while(!flag("flag_finale_holdout_complete")) {
    var_27e73083a9aec95a = randomfloatrange(var_f702381a60199c14, var_450c547dd2183cca);

    if(flag(var_a114aa815e9dac0a)) {
      var_27e73083a9aec95a = randomfloatrange(var_a2d5178999799316, var_387c1bcfb4cd98b4);
      var_2f4b3471f66b28f1 = 25;
    }

    wait var_27e73083a9aec95a;
    var_94d08343de33ee25 = utility::array_removedead_or_dying(var_94d08343de33ee25);

    if(var_94d08343de33ee25.size == 0) {
      return;
    }

    ai_shift = random(var_94d08343de33ee25);
    var_94d08343de33ee25 = utility::array_remove(var_94d08343de33ee25, ai_shift);
    ai_shift setgoalpos(ai_shift.origin);
    var_ba7ece8e5eb7d12b = randomfloatrange(var_994feef463f139c, var_450c547dd2183cca);

    if(flag(var_a114aa815e9dac0a)) {
      var_ba7ece8e5eb7d12b = randomfloatrange(var_387c1bcfb4cd98b4, var_f702381a60199c14);
    }

    if(utility::percent_chance(var_2f4b3471f66b28f1)) {
      if(isarray(vol_flank)) {
        ai_shift setgoalvolumeauto(random(vol_flank));
      } else {
        ai_shift setgoalvolumeauto(vol_flank);
      }

      var_2f4b3471f66b28f1 = 75;
    } else {
      if(isarray(var_cb5c10eb3a3a7443)) {
        ai_shift setgoalvolumeauto(random(var_cb5c10eb3a3a7443));
      } else {
        ai_shift setgoalvolumeauto(var_cb5c10eb3a3a7443);
      }

      ai_shift utility::delaythread(var_ba7ece8e5eb7d12b, &set_attackeraccuracy, 3);
      var_2f4b3471f66b28f1 = 25;
    }

    if(flag(var_a114aa815e9dac0a)) {
      ai_shift ai::function_dd21d67ede8ba22(int(ai_shift.health * 0.5) + 1);
    }

    ai_shift utility::waittill_notify_or_timeout_return("death", var_ba7ece8e5eb7d12b);
  }
}

function function_c68a50555ca28c1a(a_ai_enemies) {
  a_ai_enemies = array_removedead(a_ai_enemies);

  if(a_ai_enemies.size == 0) {
    return;
  }

  a_vols = [];
  a_vols[a_vols.size] = getEnt("vol_finale_holdout_enemy_left_back", "targetname");
  a_vols[a_vols.size] = getEnt("vol_finale_holdout_enemy_left_center", "targetname");
  a_vols[a_vols.size] = getEnt("vol_finale_holdout_enemy_left_far", "targetname");
  a_ai_enemies = array_randomize(a_ai_enemies);

  foreach(ai in a_ai_enemies) {
    if(isDefined(ai) && isalive(ai)) {
      ai set_goal_pos(ai.origin);
      ai setgoalvolumeauto(random(a_vols));
      wait randomfloatrange(1, 3);
    }
  }
}

function function_12c91b42fbb66d17(a_ai_enemies) {
  level endon("flag_finale_holdout_complete");
  a_ai_enemies = array_removedead(a_ai_enemies);

  if(a_ai_enemies.size == 0) {
    return;
  }

  vol = getEnt("vol_finale_holdout_enemy_left_front", "targetname");
  a_ai_enemies = sortbydistance(a_ai_enemies, level.player.origin);
  a_ai_enemies = array_reverse(a_ai_enemies);

  foreach(ai in a_ai_enemies) {
    if(isDefined(ai) && isalive(ai)) {
      if(istrue(ai.turret_guy)) {
        waitframe();
        continue;
      }

      ai set_favoriteenemy(undefined);
      ai set_goal_pos(ai.origin);
      ai setgoalvolumeauto(vol);
      wait randomfloatrange(1, 3);
    }
  }
}

function function_c3405ff9bdeeeb7d() {
  self endon("death");
  set_attackeraccuracy(0.5);
  disable_long_death();
  self.vehiclerunexit = 1;
  msg = flag_wait_any_return("flag_finale_holdout_wave_2_incoming", "flag_finale_holdout_wave_1_enemies_half_dead");

  if(msg == "flag_finale_holdout_wave_1_enemies_half_dead") {
    flag_wait_or_timeout("flag_finale_holdout_wave_2_incoming", randomfloatrange(4, 6));
  }

  wait randomfloatrange(1, 3);
  set_attackeraccuracy(3);
  set_baseaccuracy(0.75);
  ai::function_dd21d67ede8ba22(int(self.health * 0.5) + 1);
  self.balwayscoverexposed = 1;
}

function function_e85978dfabc2f195() {
  self endon("death");
  set_baseaccuracy(0.75);
  set_attackeraccuracy(0.25);
  disable_long_death();
  self.vehiclerunexit = 1;

  if(isDefined(self.script_startingposition) && (self.script_startingposition == 4 || self.script_startingposition == 5)) {
    set_ignoreme(1);
    set_ignoreall(1);
  }

  self waittill("unload");
  set_ignoreme(0);
  set_ignoreall(0);
  set_attackeraccuracy(0.5);
  set_baseaccuracy(1);
  msg = flag_wait_any_return("flag_finale_holdout_complete", "flag_finale_holdout_final_enemies_half_dead");

  if(msg == "flag_finale_holdout_final_enemies_half_dead") {
    flag_wait_or_timeout("flag_finale_holdout_complete", randomfloatrange(5, 15));
  }

  wait randomfloatrange(1, 3);
  set_attackeraccuracy(3);
  set_baseaccuracy(0.75);
  ai::function_dd21d67ede8ba22(int(self.health * 0.5) + 1);
  self.balwayscoverexposed = 1;
  level utility::flag_wait("flag_finale_holdout_complete");
  wait randomfloatrange(1, 3);
  vol_retreat = getEnt("vol_finale_holdout_enemy_retreat", "targetname");
  set_goal_pos(self.origin);
  self setgoalvolumeauto(vol_retreat);
}

function function_1b957e2b7af09073() {
  self endon("death");
  disable_long_death();
  set_attackeraccuracy(0.5);
  set_baseaccuracy(0.9);
  msg = flag_wait_any_return("flag_finale_holdout_complete", "flag_finale_holdout_final_enemies_half_dead");

  if(msg == "flag_finale_holdout_final_enemies_half_dead") {
    flag_wait_or_timeout("flag_finale_holdout_complete", randomfloatrange(5, 15));
  }

  wait randomfloatrange(1, 3);
  set_attackeraccuracy(3);
  set_baseaccuracy(0.75);
  ai::function_dd21d67ede8ba22(int(self.health * 0.5) + 1);
  self.balwayscoverexposed = 1;
  level utility::flag_wait("flag_finale_holdout_complete");
  wait randomfloatrange(1, 3);
  vol_retreat = getEnt("vol_finale_holdout_enemy_retreat", "targetname");
  set_goal_pos(self.origin);
  self setgoalvolumeauto(vol_retreat);
}

function function_a466275ca8a6dfcd() {
  self endon("entitydeleted");
  level.player endon("death");
  self endon("death");
  level endon("flag_finale_exfil_complete");

  if(flag("flag_finale_holdout_player_shot_something")) {
    return;
  }

  level endon("flag_finale_holdout_player_shot_something");

  while(true) {
    self waittill("damage", attacker);

    if(isDefined(attacker) && isPlayer(attacker)) {
      level flag_set("flag_finale_holdout_player_shot_something");
    }
  }
}

function function_2cafb0261265bb10() {
  self endon("entitydeleted");
  level.player endon("death");
  level endon("flag_finale_exfil_complete");

  if(flag("flag_finale_holdout_player_shot_something")) {
    return;
  }

  level endon("flag_finale_holdout_player_shot_something");
  self waittill("death", attacker);

  if(isDefined(attacker) && isPlayer(attacker)) {
    level flag_set("flag_finale_holdout_player_shot_something");
  }
}

function function_1655b3f150ca205c() {
  self endon("death");
  self endon("entitydeleted");
  level.player endon("death");
  level endon("flag_finale_exfil_complete");
  var_1e4c41a5dcdf5b1e = squared(192);
  excluded_grenades = ["smoke", "throwingknife", "flash"];

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, damageloc, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time);

    if(isDefined(meansofdeath) && !isexplosivedamagemod(meansofdeath)) {
      waitframe();
      continue;
    }

    if(isDefined(objweapon) && array_contains(excluded_grenades, getweaponbasename(objweapon))) {
      waitframe();
      continue;
    }

    if(isDefined(origin) && distance2dsquared(self.origin, origin) > var_1e4c41a5dcdf5b1e) {
      waitframe();
      continue;
    }

    self stopanimScripted();
    self notify("stop_loop");
    scripts\anim\shared::dropaiweapon();
    ai::disable_long_death();
    scripts\common\ai::gun_remove();

    if(!isdismembermentenabled() || !isDefined(self.ridingvehicle) && cointoss()) {
      do_damage(self.health + 9999, damageloc, self, undefined, meansofdeath, "iw9_la_rpapa7_sp");
      return;
    }

    playFX(getfx("vfx_gib_explode"), damageloc, anglestoup(self.angles));
    thread play_sound_in_space("gib_fullbody", self.origin + (0, 0, 40));
    waitframe();
    self delete();
  }
}

function function_260fde4fef31f45a() {}

function function_4dbfebcf97450072() {
  self endon("death");
  clear_demeanor_override();
  self.pushable = 1;
  self pushplayer(0);
  self.disableplayeradsloscheck = 0;
  set_ignoresuppression(1);
  var_8c6ee47f65d9024e = function_bdc421f433af10c7("s_start_finale_holdout");
  var_499423e8cd43a8db = getnode(var_8c6ee47f65d9024e.target, "targetname");
  set_goal_radius(32);
  set_goal_node(var_499423e8cd43a8db);

  if(self.animname == "ghost") {
    ai_enemy = utility::get_closest_ai(self.origin, "axis");

    if(isDefined(ai_enemy)) {
      self getenemyinfo(ai_enemy);
    }
  }
}

function function_c888cc5f1a23fb91() {
  level.player endon("death");
  level endon("flag_finale_holdout_complete");
  level utility::flag_wait_or_timeout("flag_finale_holdout_02", 5);
  level utility::flag_set("flag_finale_holdout_allies_start_moving");

  foreach(ai_ally in level.tundra_allies) {
    ai_ally.script_fixednode = 0;
    ai_ally set_fixednode_false();
  }

  namespace_8339f6377b6ba60e::function_26ec77b7dfe68c94();
  waitframe();
  namespace_8339f6377b6ba60e::function_733e78a23a1aafb9(randomfloatrange(3, 4), 0, randomfloatrange(1, 2), 0, randomfloatrange(0.5, 1.5));
  utility::activate_trigger_with_targetname("trig_finale_allies_advance_01");
  level.shepherd namespace_8339f6377b6ba60e::function_4cf134efffb1de77("y");
  level.gaz namespace_8339f6377b6ba60e::function_4cf134efffb1de77("g");
  level.farah namespace_8339f6377b6ba60e::function_4cf134efffb1de77("p");
  level.soap namespace_8339f6377b6ba60e::function_4cf134efffb1de77("b");
  level.ghost namespace_8339f6377b6ba60e::function_4cf134efffb1de77("r");
  flag_wait("flag_finale_holdout_intro_enemies_all_dead");
  namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
  utility::activate_trigger_with_targetname("trig_finale_allies_advance_02");
  flag_wait("flag_finale_holdout_wave_2_incoming");
  namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
  utility::activate_trigger_with_targetname("trig_finale_allies_advance_03");
  msg = flag_wait_any_return("flag_finale_holdout_wave_3_flank", "flag_finale_holdout_wave_3_incoming");

  if(msg == "flag_finale_holdout_wave_3_incoming") {
    flag_wait_or_timeout("flag_finale_holdout_wave_3_flank", 5);
  }

  namespace_8339f6377b6ba60e::function_733e78a23a1aafb9();
  utility::activate_trigger_with_targetname("trig_finale_allies_advance_04");
}

function function_654385b3a8a1d349() {}

function function_3290c0dcfe13447d() {
  a_ai_enemies = getaiarray("axis");
  a_ai_enemies = array_removedead_or_dying(a_ai_enemies);

  if(a_ai_enemies.size == 0) {
    return true;
  }

  ai_enemy = utility::getclosest(level.player.origin, a_ai_enemies, 384);

  if(isDefined(ai_enemy)) {
    return false;
  }

  n_dist_sq = squared(128);

  foreach(ai_enemy in a_ai_enemies) {
    if(isDefined(ai_enemy) && isalive(ai_enemy) && isDefined(ai_enemy.enemy)) {
      if(isDefined(ai_enemy.scriptedweaponclassprimary) && ai_enemy.scriptedweaponclassprimary == "lmg" || ai_enemy.scriptedweaponclassprimary == "rpg") {
        if(isPlayer(ai_enemy.enemy)) {
          return false;
        }

        if(distance2dsquared(ai_enemy.enemy.origin, level.player.origin) < n_dist_sq) {
          return false;
        }
      }
    }
  }

  return true;
}

function function_2416da5a3acb594c() {
  level.player endon("death");
  level endon("flag_finale_holdout_complete");
  gameskill = level.player utility::get_player_gameskill();

  switch (gameskill) {
    case 3:
    case 4:
      n_attackeraccuracy = 0.8;
      break;
    case 1:
    case 2:
      n_attackeraccuracy = 0.6;
      break;
    case 0:
    default:
      n_attackeraccuracy = 0.4;
      break;
  }

  while(true) {
    utility::flag_wait("flag_finale_player_at_boat");
    level.player set_attackeraccuracy(n_attackeraccuracy);
    wait 1;
    utility::flag_waitopen("flag_finale_player_at_boat");
    level.player set_attackeraccuracy(1);
    wait 1;
  }
}

function function_c2d873372754136f() {
  level.player endon("death");
  level endon("flag_finale_exfil_outro_begin");

  while(!isDefined(level.var_7a10e3caa5d4f0a7)) {
    waitframe();
  }

  while(true) {
    level.player waittill("missile_fire", missile, objweapon);

    if(isDefined(missile)) {
      missile waittill("explode", origin);
      vehicles_near = utility::getvehiclearray_in_radius(origin, 64);

      if(vehicles_near.size > 0) {
        foreach(vehicle in vehicles_near) {
          if(istrue(vehicle.candamage)) {
            vehicle dodamage(vehicle.health + 1000, origin, level.player, undefined, "MOD_EXPLOSIVE");
          }
        }
      }
    }

    waitframe();
  }
}

function function_557c19418ae6de25() {
  var_7c760871476912f0 = utility::getStructArray("s_finale_frag_pickup", "targetname");

  foreach(struct in var_7c760871476912f0) {
    frag_pickup = struct namespace_8339f6377b6ba60e::function_527133d02bd11634();
  }

  var_7e4eacd4b564b40c = utility::getStructArray("s_finale_semtex_pickup", "targetname");

  foreach(struct in var_7e4eacd4b564b40c) {
    semtex_pickup = struct namespace_8339f6377b6ba60e::function_527133d02bd11634("semtex");
  }

  var_73cbc61960108ebd = utility::getStructArray("s_finale_smoke_pickup", "targetname");

  foreach(struct in var_73cbc61960108ebd) {
    smoke_pickup = struct namespace_8339f6377b6ba60e::function_527133d02bd11634("smoke");
  }
}

function function_d86b8533c4e10a61() {
  exploder("vfx_finale_env");
  exploder("vfx_finale_veh_fire_1");
  exploder("vfx_finale_smoke_flare_init");
  exploder("vfx_finale_smoke_flare_wind");
}

function function_54c23d497c5105ce() {
  lerp_saveddvar(@ "hash_402173c7dbee15d9", 2, 3);

  foreach(ally in level.tundra_allies) {
    ally thread namespace_8339f6377b6ba60e::function_590b3a1b2bdf1c57(1, "5");
  }

  level utility::flag_wait("flag_finale_exfil_heli_land_begin");

  foreach(ally in level.tundra_allies) {
    ally thread namespace_8339f6377b6ba60e::function_590b3a1b2bdf1c57(1, "15");
  }

  level utility::flag_wait("flag_finale_exfil_heli_land_end");

  foreach(ally in level.tundra_allies) {
    ally thread namespace_8339f6377b6ba60e::function_590b3a1b2bdf1c57(1, "30");
  }
}

function function_26bce73ccc72da96() {
  wait 1;
  var_58ef0e8943e6ce4f = getEnt("jup_machinery_crane_shipyard_top_01_dyn_02", "targetname");
  var_58ef0e8943e6ce4f setscriptablepartstate("main", "medium");
  var_db8f907280815b2e = getEnt("jup_machinery_crane_shipyard_top_01_dyn_03", "targetname");
  var_db8f907280815b2e setscriptablepartstate("main", "weak");
}

function function_d93d73c8ce6287ad() {
  array_spawn_function_targetname("ai_finale_corpse", &function_a05bb3a974bf2561);
  var_1c8e103d26456534 = array_spawn_targetname("ai_finale_corpse", 1);
}

function function_efddd276c907acfb() {
  level notify("stop_tundra_pre_exfil_nags");
  registered = "igc_finale";
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "show_hud", 0);
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "damage", 0);
  level.player val::set(registered, "death", 0);
  level.player val::set(registered, "freezecontrols", 1);
  level.player val::set(registered, "ignoreme", 1);
  bg_hud = newhudelem();
  bg_hud.alignx = "center";
  bg_hud.aligny = "bottom";
  bg_hud.x = 320;
  bg_hud.y = 500;
  bg_hud.alpha = 1;
  bg_hud setshader("black", 9999, 999);
  var_5c59fc44a8dd3434 = 3;
  a_lines = ["- END MISSION -", "141 boards Nikolai's helo with their cargo, General Shepherd,", "then they head out to rendezvous with Laswell..."];
  function_79a528c78c285c0(var_5c59fc44a8dd3434, a_lines);
  wait 5;
}

function function_79a528c78c285c0(var_5c59fc44a8dd3434, a_lines) {
  var_61a2500bbaf63219 = [];

  foreach(l in a_lines) {
    hud = newhudelem();
    hud.alignx = "center";
    hud.aligny = "middle";
    hud.fontscale = 2;
    hud.x = 320;
    hud.y = 100 + i * 50;
    hud.alpha = 0;
    hud settext(l);
    hud fadeovertime(var_5c59fc44a8dd3434);
    hud.alpha = 1;
    wait var_5c59fc44a8dd3434;
    var_61a2500bbaf63219[var_61a2500bbaf63219.size] = hud;
  }

  wait var_5c59fc44a8dd3434;

  foreach(hud in var_61a2500bbaf63219) {
    hud fadeovertime(var_5c59fc44a8dd3434);
    hud.alpha = 0;
    hud delaycall(var_5c59fc44a8dd3434, &destroy);
  }
}