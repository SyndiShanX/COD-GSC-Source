/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_686d874f22ef4fba.gsc
*************************************************/

#using script_1031976741eb6674;
#using script_2c5456a9a7133a7c;
#using script_412aa76130fc9a7b;
#using script_60add030ce1a42b6;
#using script_f8531dcf975a7a7;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\colors;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#namespace namespace_6ece65983a2489fa;

function function_1048e76437c649b4() {}

function shipyard_start() {
  function_4c28f0141619d61a();
  set_start_location("s_start_shipyard", [level.player]);
  set_start_location("s_start_shipyard", level.tundra_allies);
  function_12af163adcd1c7e6("s_start_shipyard_farah");
  level.farah set_goal_node_targetname("shipyard_cover_02_farah");
  level thread namespace_191bb1c1589b3acb::function_84746c3250d67674();
  level thread namespace_628677441ac10022::function_b41383e8587fa198(0);
  level.player setmovespeedscale(1);
}

function function_c1351e9f0bc9e601() {
  setDvar(@ "hash_2a4f08bc79265550", 0);
  setDvar(@ "hash_42deeb1fb385c72", 1);
  autosave_by_name();

  level thread function_9a2b6bf96312f577("<dev string:x1c>", "<dev string:x25>");

  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(180, undefined, "flag_shipyard_stop_nags", "shipyard_player_progress", "trig_shipyard");
  level.var_b7e441e308b3f836 = [];
  level.var_b86de4bbf4b51669 = [];
  add_global_spawn_function("axis", &function_661745c9ece26101);
  add_global_spawn_function("axis", &function_39f0dc8501b481f1);
  scripts\engine\sp\utility::add_extra_autosave_check("autosave_shipyard_underwater", &shipyard_autosave_underwater_check, "Player is underwater.");
  level thread function_51372fb7b9c06e01();
  level thread function_aea665601bae6ad4();
  level thread function_bc9111f7b4b1add6();
  flag_set("flag_shipyard_idle_heli_start_path");
  level notify("stop_tundra_pre_exfil_nags");
  level thread namespace_f247b8d258f67b0b::function_598e0fa2479604b0();
  a_ai_allies = [level.soap, level.gaz, level.farah, level.shepherd];
  utility::array_thread(a_ai_allies, &function_1b83cb14236d6d5c);
  level thread function_faa19969ec3584c9();
  level thread function_cf755d62402f5da();
  level thread function_3d7e8208f2308e5b();
  var_38a642c6e7011dd6 = spawnStruct();
  level thread function_e8174f3628bbae4d(var_38a642c6e7011dd6);
  level thread function_2f02d46f009e77d1(var_38a642c6e7011dd6);
  level thread namespace_8339f6377b6ba60e::function_4fb957efd679cf35("flag_shipyard_complete", "shipyard_player_progress");
  waitframe();
  var_9390e6001b013309 = [];

  if(cointoss()) {
    utility::array_spawn_function_targetname("ai_shipyard_quiet_left_spawners", &function_7a17bb5a62860427, "flag_shipyard_player_left");
    utility::array_spawn_function_targetname("ai_shipyard_quiet_left_spawners", &function_2f250d3bc4b4a574, var_38a642c6e7011dd6, "v_shipyard_front_right_enemies_goal");
    utility::array_spawn_function_targetname("ai_shipyard_quiet_left_spawners", &function_5c1a68dcf290d147, "flag_shipyard_front_right_fallback", "v_front_right_fallback_goal", "flag_shipyard_mid_right_fallback");
    var_83cbce2857630d4f = utility::array_spawn_targetname("ai_shipyard_quiet_left_spawners", 1, 1);
    var_9390e6001b013309 = array_combine(var_9390e6001b013309, var_83cbce2857630d4f);
  } else {
    utility::array_spawn_function_targetname("ai_shipyard_quiet_right_spawners", &function_7a17bb5a62860427, "flag_shipyard_player_right");
    utility::array_spawn_function_targetname("ai_shipyard_quiet_right_spawners", &function_2f250d3bc4b4a574, var_38a642c6e7011dd6, "v_shipyard_front_left_enemies_goal");
    utility::array_spawn_function_targetname("ai_shipyard_quiet_right_spawners", &function_5c1a68dcf290d147, "flag_shipyard_front_left_fallback", "v_front_left_fallback_goal", "flag_shipyard_mid_left_fallback");
    var_26b5d66658c130c0 = utility::array_spawn_targetname("ai_shipyard_quiet_right_spawners", 1, 1);
    var_9390e6001b013309 = array_combine(var_9390e6001b013309, var_26b5d66658c130c0);
  }

  level thread function_e9c9b94e330fbb04(var_38a642c6e7011dd6);
  level.var_b7e441e308b3f836 = array_combine(level.var_b7e441e308b3f836, var_9390e6001b013309);
  level utility::flag_wait_any("flag_shipyard_start_first_encounter", "flag_shipyard_go_loud");
  level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("shipyard_player_progress");
  var_69ed133d3dfded2a = [];
  utility::array_spawn_function_targetname("ai_shipyard_front_left_spawners", &function_7a17bb5a62860427, "flag_shipyard_player_left");
  utility::array_spawn_function_targetname("ai_shipyard_front_left_spawners", &function_2f250d3bc4b4a574, var_38a642c6e7011dd6, "v_shipyard_front_left_enemies_goal");
  utility::array_spawn_function_targetname("ai_shipyard_front_left_spawners", &function_5c1a68dcf290d147, "flag_shipyard_front_left_fallback", "v_front_left_fallback_goal", "flag_shipyard_advance_06");
  var_d1c961a15705e3a6 = utility::array_spawn_targetname("ai_shipyard_front_left_spawners", 1, 1);
  var_69ed133d3dfded2a = array_combine(var_69ed133d3dfded2a, var_d1c961a15705e3a6);
  waitframe();
  utility::array_spawn_function_targetname("ai_shipyard_front_right_spawners", &function_7a17bb5a62860427, "flag_shipyard_player_right");
  utility::array_spawn_function_targetname("ai_shipyard_front_right_spawners", &function_2f250d3bc4b4a574, var_38a642c6e7011dd6, "v_shipyard_front_right_enemies_goal");
  utility::array_spawn_function_targetname("ai_shipyard_front_right_spawners", &function_5c1a68dcf290d147, "flag_shipyard_front_right_fallback", "v_front_right_fallback_goal", "flag_shipyard_advance_06");
  var_ff582e737e91787b = utility::array_spawn_targetname("ai_shipyard_front_right_spawners", 1, 1);
  var_69ed133d3dfded2a = array_combine(var_69ed133d3dfded2a, var_ff582e737e91787b);
  level.var_b7e441e308b3f836 = array_combine(level.var_b7e441e308b3f836, var_69ed133d3dfded2a);
  var_9390e6001b013309 = array_combine(var_9390e6001b013309, var_69ed133d3dfded2a);
  level thread function_7cf3b8f1b807889a(var_69ed133d3dfded2a, "flag_shipyard_front_enemies_dead", int(var_69ed133d3dfded2a.size * 0.75), "flag_shipyard_complete");
  level thread function_ae9ea47348c63c4b();
  level utility::flag_wait_any("flag_shipyard_advance_force_loud", "flag_shipyard_front_enemies_dead", "flag_shipyard_go_loud");
  var_9390e6001b013309 = array_removedead_or_dying(var_9390e6001b013309);
  array_thread(var_9390e6001b013309, &ent_flag_set, "force_loud");
  level utility::flag_set("flag_shipyard_go_loud");
  level utility::flag_set("flag_shipyard_mid_enemies_spawn");
  battlechatter_on("axis");
  level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_shipyard_stop_nags");
  level thread function_9a08aa01bbdcc097();
  level thread function_a5550ae7db8550de();
  level thread function_3ae2c764d6ae0dc9();
  var_b852b8bf1204b43f = [];

  if(level utility::flag("flag_shipyard_player_left")) {
    utility::array_spawn_function_targetname("ai_shipyard_mid_left_spawners", &function_7a17bb5a62860427, "flag_shipyard_player_left", 1);
    utility::array_spawn_function_targetname("ai_shipyard_mid_left_spawners", &function_5c1a68dcf290d147, "flag_shipyard_mid_left_fallback", "v_shipyard_back_left_enemies_goal", "flag_shipyard_advance_08");
    var_a109cf5cfa24f0a1 = utility::array_spawn_targetname("ai_shipyard_mid_left_spawners", 1, 1);
    var_b852b8bf1204b43f = array_combine(var_b852b8bf1204b43f, var_a109cf5cfa24f0a1);
  } else {
    utility::array_spawn_function_targetname("ai_shipyard_mid_right_spawners", &function_7a17bb5a62860427, "flag_shipyard_player_right", 1);
    utility::array_spawn_function_targetname("ai_shipyard_mid_right_spawners", &function_5c1a68dcf290d147, "flag_shipyard_mid_right_fallback", "v_shipyard_back_right_enemies_goal", "flag_shipyard_advance_08");
    var_abe0bd6cd3b16b82 = utility::array_spawn_targetname("ai_shipyard_mid_right_spawners", 1, 1);
    var_b852b8bf1204b43f = array_combine(var_b852b8bf1204b43f, var_abe0bd6cd3b16b82);
  }

  level.var_b7e441e308b3f836 = array_combine(level.var_b7e441e308b3f836, var_b852b8bf1204b43f);
  level thread function_7cf3b8f1b807889a(var_b852b8bf1204b43f, "flag_shipyard_mid_enemies_dead", int(var_b852b8bf1204b43f.size * 0.75), "flag_shipyard_complete");
  waitframe();
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(240, undefined, "flag_shipyard_stop_nags", "shipyard_player_progress", "trig_shipyard");
  level utility::flag_wait_any("flag_shipyard_advance_04", "flag_shipyard_mid_enemies_dead");
  level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("shipyard_player_progress");
  var_d38ba877b93fd224 = [];
  utility::array_spawn_function_targetname("ai_shipyard_back_right_spawners", &function_7a17bb5a62860427, "flag_shipyard_player_right", 1);
  var_2d887cc4f0903259 = utility::array_spawn_targetname("ai_shipyard_back_right_spawners", 1, 1);
  var_d38ba877b93fd224 = array_combine(var_d38ba877b93fd224, var_2d887cc4f0903259);
  waitframe();
  utility::array_spawn_function_targetname("ai_shipyard_back_left_spawners", &function_7a17bb5a62860427, "flag_shipyard_player_left", 1);
  var_b43c6c25cdc55b6c = utility::array_spawn_targetname("ai_shipyard_back_left_spawners", 1, 1);
  var_d38ba877b93fd224 = array_combine(var_d38ba877b93fd224, var_b43c6c25cdc55b6c);
  level.var_b7e441e308b3f836 = array_combine(level.var_b7e441e308b3f836, var_d38ba877b93fd224);
  level thread function_7cf3b8f1b807889a(var_d38ba877b93fd224, "flag_shipyard_back_enemies_dead", int(var_d38ba877b93fd224.size * 0.5), "flag_shipyard_complete");
  level utility::flag_wait_any("flag_shipyard_advance_06", "flag_shipyard_back_enemies_dead");
  level utility::flag_set("flag_shipyard_rpgs_spawn");
  level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("shipyard_player_progress");
  var_5a8c353997d5e719 = spawnStruct();
  level thread function_fd6f6b9e6f29bc49(var_5a8c353997d5e719);
  utility::array_spawn_function_targetname("ai_shipyard_final_spawners", &function_a9f7d0ad9a804150, var_5a8c353997d5e719);
  var_98fdd6866ee2e5b1 = utility::array_spawn_targetname("ai_shipyard_final_spawners", 1, 1);
  level.var_b7e441e308b3f836 = array_combine(level.var_b7e441e308b3f836, var_98fdd6866ee2e5b1);
  level thread function_7cf3b8f1b807889a(var_98fdd6866ee2e5b1, "flag_shipyard_rpgs_dead", undefined, "flag_shipyard_complete");
  level thread function_7cf3b8f1b807889a(level.var_b7e441e308b3f836, "flag_shipyard_all_enemies_dead", undefined, "flag_shipyard_complete");
  level thread namespace_8339f6377b6ba60e::function_82af1f637fed6a38("flag_shipyard_advance_09", "flag_shipyard_complete", level.var_b7e441e308b3f836, ["flag_shipyard_rpgs_dead", "flag_finale_holdout_03"]);
  level thread function_2f9635ce7230c422();
  level thread function_11c6452d89c4cd9f();
  level utility::flag_wait("flag_shipyard_advance_06");
  level thread function_6c601d0b1308d851();
  level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29("shipyard_player_progress");
  level flag_wait("flag_shipyard_complete");
  level utility::flag_set("flag_shipyard_obj_clear_complete");
  level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_shipyard_stop_nags");
  level.player notify("stop_snowdrift_transition_finale");
  remove_global_spawn_function("axis", &function_661745c9ece26101);
  remove_global_spawn_function("axis", &function_39f0dc8501b481f1);
  scripts\engine\sp\utility::remove_extra_autosave_check("autosave_shipyard_underwater");
  level.var_b86de4bbf4b51669 = undefined;
}

function function_b97fcea70c9dd1ae() {
  level utility::flag_set("flag_shipyard_complete");
}

function function_e6499d8bd977e17a() {}

function function_1b83cb14236d6d5c() {
  level.player endon("death");
  set_pacifist(1);
  self.var_43ae9f4734246fb0 = 1;
  level flag_wait("flag_shipyard_go_loud");
  wait randomfloatrange(0.5, 1.5);
  set_pacifist(0);
  self.var_43ae9f4734246fb0 = 0;
  a_ai_enemies = array_removedead_or_dying(level.var_b7e441e308b3f836);
  ai_enemy = getclosest(self.origin, a_ai_enemies, 768);

  if(isDefined(ai_enemy) && isalive(ai_enemy)) {
    self getenemyinfo(ai_enemy);
  }
}

function function_3d7e8208f2308e5b() {
  level flag_wait("flag_shipyard_advance_08");
  level thread namespace_3bfdb34b3dc5924b::function_26bce73ccc72da96();
  level thread namespace_3bfdb34b3dc5924b::function_d93d73c8ce6287ad();
  level thread namespace_3bfdb34b3dc5924b::function_bd187230688895aa();
  level thread namespace_3bfdb34b3dc5924b::function_d86b8533c4e10a61();
  function_6f14de8eb839f0f9("s_start_finale_exfil");
  s_ghost = level.ghost function_bdc421f433af10c7("s_start_finale_holdout");
  nd_ghost = getnode(s_ghost.target, "targetname");
  level.ghost set_fixednode_true();
  level.ghost set_goal_node(nd_ghost);
  level.ghost set_ignoreall(1);
  level flag_wait("flag_shipyard_complete");
  level.ghost set_ignoreall(0);
}

function function_cf755d62402f5da() {
  level flag_wait_any("flag_shipyard_advance_01", "flag_shipyard_intro_allies_move");
  activate_trigger_with_targetname("trig_shipyard_allies_advance_right_01");
  waitframe();
  level.shepherd namespace_8339f6377b6ba60e::function_4cf134efffb1de77("y");
  level.gaz namespace_8339f6377b6ba60e::function_4cf134efffb1de77("g");
  level flag_wait("flag_shipyard_advance_02");
  activate_trigger_with_targetname("trig_shipyard_allies_advance_right_02");
  level flag_wait("flag_shipyard_advance_03");
  activate_trigger_with_targetname("trig_shipyard_allies_advance_right_03");

  if(!level utility::flag("flag_shipyard_go_loud")) {
    level utility::flag_set("flag_shipyard_front_right_fallback");
  }

  level flag_wait("flag_shipyard_advance_04");
  level utility::flag_set("flag_shipyard_front_right_fallback");
  activate_trigger_with_targetname("trig_shipyard_allies_advance_right_04");
  level flag_wait_any("flag_shipyard_advance_05", "flag_shipyard_all_enemies_dead");

  if(utility::flag("flag_shipyard_all_enemies_dead")) {
    activate_trigger_with_targetname("trig_shipyard_allies_advance_right_06");
    level utility::flag_wait("flag_shipyard_advance_06");
  } else {
    if(flag("flag_shipyard_right_jltv_1_spawn")) {
      level utility::flag_wait_any("flag_shipyard_jltv_1_enemies_dead", "flag_shipyard_advance_06");
    }

    activate_trigger_with_targetname("trig_shipyard_allies_advance_right_05");
  }

  level flag_wait_any("flag_shipyard_advance_06", "flag_shipyard_all_enemies_dead");

  if(utility::flag("flag_shipyard_all_enemies_dead")) {
    activate_trigger_with_targetname("trig_shipyard_allies_advance_right_07");
    level utility::flag_wait("flag_shipyard_advance_07");
  } else {
    if(flag("flag_shipyard_right_jltv_1_spawn")) {
      level utility::flag_wait_any("flag_shipyard_jltv_1_enemies_dead", "flag_shipyard_advance_07");
    }

    level utility::flag_set("flag_shipyard_mid_right_fallback");
    activate_trigger_with_targetname("trig_shipyard_allies_advance_right_06");
  }

  level flag_wait_any("flag_shipyard_advance_07", "flag_shipyard_all_enemies_dead");

  if(utility::flag("flag_shipyard_all_enemies_dead")) {
    activate_trigger_with_targetname("trig_shipyard_allies_advance_right_08");
    level utility::flag_wait("flag_shipyard_advance_08");
  } else {
    if(flag("flag_shipyard_right_jltv_1_spawn")) {
      level utility::flag_wait_any("flag_shipyard_jltv_1_enemies_dead", "flag_shipyard_advance_08");
    }

    activate_trigger_with_targetname("trig_shipyard_allies_advance_right_07");
  }

  msg = flag_wait_any_return("flag_shipyard_advance_08", "flag_shipyard_all_enemies_dead");

  if(msg == "flag_shipyard_advance_08") {
    activate_trigger_with_targetname("trig_shipyard_allies_advance_right_08");
  }

  msg = flag_wait_any_return("flag_shipyard_advance_09", "flag_shipyard_complete", "flag_shipyard_all_enemies_dead");

  if(msg == "flag_shipyard_advance_09") {
    activate_trigger_with_targetname("trig_shipyard_allies_advance_right_09");
  }

  level flag_wait_any("flag_shipyard_complete", "flag_shipyard_all_enemies_dead");
  activate_trigger_with_targetname("trig_shipyard_allies_advance_right_10");
}

function function_faa19969ec3584c9() {
  level flag_wait_any("flag_shipyard_advance_01", "flag_shipyard_intro_allies_move");
  activate_trigger_with_targetname("trig_shipyard_allies_advance_left_01");
  waitframe();
  level.farah namespace_8339f6377b6ba60e::function_4cf134efffb1de77("p");
  level.soap namespace_8339f6377b6ba60e::function_4cf134efffb1de77("b");
  level flag_wait("flag_shipyard_advance_02");
  activate_trigger_with_targetname("trig_shipyard_allies_advance_left_02");
  level flag_wait("flag_shipyard_advance_03");
  activate_trigger_with_targetname("trig_shipyard_allies_advance_left_03");

  if(!level utility::flag("flag_shipyard_go_loud")) {
    level utility::flag_set("flag_shipyard_front_left_fallback");
  }

  level flag_wait("flag_shipyard_advance_04");
  level utility::flag_set("flag_shipyard_front_left_fallback");
  activate_trigger_with_targetname("trig_shipyard_allies_advance_left_04");
  level flag_wait_any("flag_shipyard_advance_05", "flag_shipyard_all_enemies_dead");

  if(utility::flag("flag_shipyard_all_enemies_dead")) {
    activate_trigger_with_targetname("trig_shipyard_allies_advance_left_06");
    level utility::flag_wait("flag_shipyard_advance_06");
  } else {
    if(flag("flag_shipyard_left_cargo_ship_spawn")) {
      level utility::flag_wait_any("flag_shipyard_cargo_ship_enemies_dead", "flag_shipyard_advance_06");
    }

    activate_trigger_with_targetname("trig_shipyard_allies_advance_left_05");
  }

  level flag_wait_any("flag_shipyard_advance_06", "flag_shipyard_all_enemies_dead");

  if(utility::flag("flag_shipyard_all_enemies_dead")) {
    activate_trigger_with_targetname("trig_shipyard_allies_advance_left_07");
    level utility::flag_wait("flag_shipyard_advance_07");
  } else {
    if(flag("flag_shipyard_left_cargo_ship_spawn")) {
      level utility::flag_wait_any("flag_shipyard_cargo_ship_enemies_dead", "flag_shipyard_advance_07");
    }

    level utility::flag_set("flag_shipyard_mid_left_fallback");
    activate_trigger_with_targetname("trig_shipyard_allies_advance_left_06");
  }

  level flag_wait_any("flag_shipyard_advance_07", "flag_shipyard_all_enemies_dead");

  if(utility::flag("flag_shipyard_all_enemies_dead")) {
    activate_trigger_with_targetname("trig_shipyard_allies_advance_left_08");
    level utility::flag_wait("flag_shipyard_advance_08");
  } else {
    if(flag("flag_shipyard_left_cargo_ship_spawn")) {
      level utility::flag_wait_any("flag_shipyard_cargo_ship_enemies_dead", "flag_shipyard_advance_08");
    }

    activate_trigger_with_targetname("trig_shipyard_allies_advance_left_07");
  }

  msg = flag_wait_any_return("flag_shipyard_advance_08", "flag_shipyard_all_enemies_dead");

  if(msg == "flag_shipyard_advance_08") {
    activate_trigger_with_targetname("trig_shipyard_allies_advance_left_08");
  }

  msg = flag_wait_any_return("flag_shipyard_advance_09", "flag_shipyard_complete", "flag_shipyard_all_enemies_dead");

  if(msg == "flag_shipyard_advance_09") {
    activate_trigger_with_targetname("trig_shipyard_allies_advance_left_09");
  }

  level flag_wait_any("flag_shipyard_complete", "flag_shipyard_all_enemies_dead");
  activate_trigger_with_targetname("trig_shipyard_allies_advance_left_10");
}

function function_5d2a50a4b4c4455a() {}

function shipyard_autosave_underwater_check() {
  return !level utility::flag("shipyard_autosave_underwater_check");
}

function function_2f9635ce7230c422() {
  level.player endon("death");
  level endon("flag_shipyard_complete");

  if(level utility::flag("flag_shipyard_complete")) {
    return;
  }

  level utility::flag_wait("flag_shipyard_all_enemies_dead");
  level waittill("objectives_updated");
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_shipyard_stop_nags", "shipyard_player_progress", "trig_shipyard");
}

function function_9a08aa01bbdcc097() {
  level.player endon("death");
  level endon("flag_shipyard_complete");
  level endon("flag_shipyard_rpgs_dead");
  level endon("flag_shipyard_all_enemies_dead");

  if(!isDefined(level.player_progress_monitor)) {
    level.player_progress_monitor = spawnStruct();
  }

  var_778a8b9d5a71d073 = 5;
  var_10179c88cd5a2db9 = 15;
  var_303b83e0394a3220 = 0;

  while(true) {
    waitframe();

    if(level utility::flag("flag_shipyard_player_underwater")) {
      wait 1;
      continue;
    }

    var_b7467f7fbcf9b4dc = randomfloatrange(var_778a8b9d5a71d073, var_10179c88cd5a2db9) + var_303b83e0394a3220 * 10;
    msg = level.player_progress_monitor waittill_notify_or_timeout_return("shipyard_player_progress", var_b7467f7fbcf9b4dc);

    if(msg == "shipyard_player_progress") {
      var_303b83e0394a3220 = int(max(0, var_303b83e0394a3220 - 1));
      wait 1;
      continue;
    }

    while(true) {
      a_ai_enemies = getaiarray("axis");
      a_ai_enemies = array_removedead_or_dying(a_ai_enemies);

      if(a_ai_enemies.size == 0) {
        return;
      }

      a_ai_enemies = sortbydistance(a_ai_enemies, level.player.origin);
      a_ai_enemies = array_reverse(a_ai_enemies);
      ai_enemy = a_ai_enemies[0];
      dist = randomfloatrange(32, 48);
      dir = flatten_vector(randomvector(1));
      var_376eb5d9559cdb16 = level.player getEye() + dir * dist + (0, 0, 32);
      grenade_source = ai_enemy getEye();
      n_dist = distance2d(ai_enemy.origin, level.player.origin);
      var_f44cd2ccd2d6328e = anglesToForward(vectortoangles(grenade_source - var_376eb5d9559cdb16)) * n_dist * 0.25;
      var_ece098d419ba8e83 = var_376eb5d9559cdb16 + (0, 0, n_dist * 0.5);
      launchvelocity = var_376eb5d9559cdb16 - var_ece098d419ba8e83;
      n_fuse_time = 2 + n_dist / 500;

      if(!sighttracepassed(var_ece098d419ba8e83, var_376eb5d9559cdb16, 1, undefined)) {
        var_376eb5d9559cdb16 = level.player.origin + dir * dist;
        var_f44cd2ccd2d6328e = anglesToForward(vectortoangles(grenade_source - var_376eb5d9559cdb16)) * n_dist * 0.5;
        var_ece098d419ba8e83 = var_376eb5d9559cdb16 + var_f44cd2ccd2d6328e + (0, 0, n_dist * 0.25);
        launchvelocity = var_376eb5d9559cdb16 - var_ece098d419ba8e83;
      }

      grenade = magicgrenade("frag", var_ece098d419ba8e83, var_376eb5d9559cdb16, n_fuse_time);

      if(isDefined(grenade)) {
        iprintln("<dev string:x3c>");

        var_303b83e0394a3220++;
        break;
      }

      wait 1;
    }
  }
}

function function_3870a75c090b48a5() {
  self endon("death");

  while(true) {
    sphere(self.origin, 16, (1, 1, 1), 0, 1);

    waitframe();
  }
}

function function_92e33ad36d79bbc1() {
  self waittill("explode", origin);

  sphere(origin, 64, (1, 0, 0), 0, 180);
}

function function_3ae2c764d6ae0dc9() {
  level.player endon("death");
  level utility::flag_wait("flag_shipyard_go_loud");
  level utility::flag_wait_any("flag_shipyard_advance_04", "flag_shipyard_rpgs_spawn");

  if(level utility::flag("flag_shipyard_player_underwater")) {
    level utility::flag_waitopen("flag_shipyard_player_underwater");
  }

  if(level utility::flag("flag_shipyard_player_left")) {
    level thread function_74b4a048aee6e17e();
    level thread function_82e3cbac9e4fd488();
    return;
  }

  level thread function_70aa7c0de6b236e();
}

function function_46c6355c8a16161a() {}

function function_27e2439cdf88e8d7() {
  self endon("death");
  self waittill("weapon_fired");

  if(istrue(self.pacifist)) {
    iprintlnbold(self.targetname + "<dev string:x62>");
  }
}

function function_e9c9b94e330fbb04(var_38a642c6e7011dd6) {
  utility::array_spawn_function_targetname("ai_shipyard_crane_sniper", &function_5c1a68dcf290d147, ["flag_shipyard_go_loud", "flag_shipyard_player_spotted_crane_sniper"], "v_shipyard_all_top_fallback_goal", undefined, 1);
  ai_shipyard_crane_sniper = spawn_targetname("ai_shipyard_crane_sniper", 1);
  ai_shipyard_crane_sniper thermaldrawdisable();
  ai_shipyard_crane_sniper ai::set_pacifist(1);
  ai_shipyard_crane_sniper ai::set_favoriteenemy(level.player);
  ai_shipyard_crane_sniper.maxsightdistsqrd = 64000000;
  ai_shipyard_crane_sniper.maxvisibledist = 8192;
  ai_shipyard_crane_sniper ai::gun_remove();
  gun = utility::make_weapon("iw9_sn_alpha50_notherm_sp");
  ai_shipyard_crane_sniper scripts\anim\shared::forceuseweapon(gun, "primary");
  ai_shipyard_crane_sniper.dropweapon = 0;
  level.var_b7e441e308b3f836 = array_add(level.var_b7e441e308b3f836, ai_shipyard_crane_sniper);
  ai_shipyard_crane_sniper thread function_999802cc239b6bc3();
  ai_shipyard_crane_sniper waittill("death", attacker);

  if(isDefined(attacker) && isPlayer(attacker)) {
    utility::flag_set("flag_shipyard_player_killed_crane_sniper");
  }
}

function function_999802cc239b6bc3() {
  level.player endon("death");
  self endon("death");
  level endon("flag_shipyard_all_enemies_dead");
  level endon("flag_shipyard_complete");

  while(!level utility::flag("flag_shipyard_player_spotted_crane_sniper")) {
    var_902c737cb7f72faa = function_19e43f151dcdfb16(self, 1, 0.05);
    var_865048328835e385 = utility::within_fov_of_players(self getEye(), cos(10));

    if(istrue(var_902c737cb7f72faa) && istrue(var_865048328835e385)) {
      level notify("shipyard_player_spotted_crane_sniper");
    }

    wait 1;
  }
}

function function_82e3cbac9e4fd488() {
  utility::array_spawn_function_targetname("ai_shipyard_grenade_right_spawner", &function_7a17bb5a62860427, "flag_shipyard_player_right");
  utility::array_spawn_function_targetname("ai_shipyard_grenade_right_spawner", &function_5c1a68dcf290d147, "flag_shipyard_jltv_fallback", "v_shipyard_all_top_fallback_goal", "flag_shipyard_jltv_fallback", 1);
  var_ec523e24000d677a = spawn_targetname("ai_shipyard_grenade_right_spawner", 1);
  level.var_b7e441e308b3f836 = array_add(level.var_b7e441e308b3f836, var_ec523e24000d677a);
  level thread function_7cf3b8f1b807889a([var_ec523e24000d677a], "flag_shipyard_grenade_right_enemy_dead", undefined, "flag_shipyard_complete");
}

function function_6fddbeea8afb2ce3() {
  self endon("death");
  level.player endon("death");
  level endon("flag_shipyard_jltv_fallback");
  goal_vol = getEnt("v_shipyard_top_shed_roof", "targetname");
  set_grenadeweapon("frag");
  self.grenadeammo = 9;
  self.bignoregrenadecooldown = 1;
  self.script_forcegrenade = 1;
  self.var_feba70fe0d4000f = 1;
  self.var_b938a79ed8856e2f = 1500;
  self.var_b915959ed85efee1 = 3000;

  while(!self istouching(goal_vol)) {
    wait 1;
  }

  while(self.grenadeammo > 0) {
    msg = function_3ba8ecdb1cb24d36();

    if(isDefined(msg) && msg == "shipyard_right_grenade_throw") {
      wait randomfloatrange(1, 9);
    } else {
      wait 1;
    }

    waitframe();
  }
}

function function_a2b72ea53c7a311c(goal_vol) {
  self endon("death");

  if(isstring(goal_vol)) {
    goal_vol = getEnt(goal_vol, "targetname");
  }

  while(true) {
    if(self istouching(goal_vol)) {
      break;
    }

    wait 1;
  }

  self notify("stop_quiet_enemy_monitor");
  waitframe();
  self delete();
}

function function_ae9ea47348c63c4b() {
  level.player endon("death");
  level flag_wait("flag_shipyard_go_loud");
  utility::array_spawn_function_targetname("ai_shipyard_lmg_right_spawner", &function_7a17bb5a62860427, "flag_shipyard_player_right");
  utility::array_spawn_function_targetname("ai_shipyard_lmg_right_spawner", &function_5c1a68dcf290d147, "flag_shipyard_mid_right_fallback", "v_shipyard_back_right_enemies_goal", "flag_shipyard_advance_07");
  var_e06b5675d81e24c0 = spawn_targetname("ai_shipyard_lmg_right_spawner", 1);
  level.var_b7e441e308b3f836 = array_add(level.var_b7e441e308b3f836, var_e06b5675d81e24c0);
  level thread function_7cf3b8f1b807889a([var_e06b5675d81e24c0], "flag_shipyard_lmg_right_enemy_dead", undefined, "flag_shipyard_complete");
  level utility::flag_wait_any("flag_shipyard_lmg_right_enemy_dead", "flag_shipyard_advance_04");
  level utility::flag_wait("flag_shipyard_player_right");

  if(level utility::flag("flag_shipyard_advance_06")) {
    return;
  }

  utility::array_spawn_function_targetname("ai_shipyard_ar_right_spawner", &function_7a17bb5a62860427, "flag_shipyard_player_right");
  utility::array_spawn_function_targetname("ai_shipyard_ar_right_spawner", &function_5c1a68dcf290d147, "flag_shipyard_jltv_fallback", "v_shipyard_all_top_fallback_goal", "flag_shipyard_jltv_fallback", 1);
  var_23c784a497d9b53d = spawn_targetname("ai_shipyard_ar_right_spawner", 1);
  level.var_b7e441e308b3f836 = array_add(level.var_b7e441e308b3f836, var_23c784a497d9b53d);
}

function function_7a17bb5a62860427(var_4842c13a69b82413, var_ab2c6c556bfb9fd2) {
  self endon("death");
  level.player endon("death");
  var_d42ff08247c70422 = 0;
  b_underwater = 0;
  var_ab2c6c556bfb9fd2 = default_to(var_ab2c6c556bfb9fd2, 0);
  level utility::flag_wait("flag_shipyard_go_loud");

  while(true) {
    if(level utility::flag("flag_shipyard_player_underwater") && !istrue(b_underwater)) {
      utility::set_attackeraccuracy(0.5);
      utility::set_favoriteenemy(undefined);
      b_underwater = 1;
    } else if(!level utility::flag("flag_shipyard_player_underwater") && istrue(b_underwater)) {
      if(level utility::flag(var_4842c13a69b82413) && !istrue(var_d42ff08247c70422)) {
        utility::set_attackeraccuracy(0.75);

        if(istrue(var_ab2c6c556bfb9fd2) || cointoss()) {
          utility::set_favoriteenemy(level.player);
        } else {
          self getenemyinfo(level.player);
        }

        var_d42ff08247c70422 = 1;
      } else if(!level utility::flag(var_4842c13a69b82413) && istrue(var_d42ff08247c70422)) {
        utility::set_attackeraccuracy(1);
        utility::set_favoriteenemy(undefined);
        ai_ally = getclosest(self.origin, level.tundra_allies);

        if(isDefined(ai_ally)) {
          self getenemyinfo(ai_ally);
        }

        var_d42ff08247c70422 = 0;
      }

      b_underwater = 0;
    }

    wait 1;
  }
}

function function_a5550ae7db8550de() {
  level.player endon("death");
  level utility::flag_wait("flag_shipyard_advance_04");

  if(level utility::flag("flag_shipyard_player_right")) {
    str_targetname = "ai_shipyard_shotgun_seeker_right";
  } else {
    str_targetname = "ai_shipyard_shotgun_seeker_left";
  }

  ai_shotgun = spawn_targetname(str_targetname, 1);
  level.var_b7e441e308b3f836 = array_add(level.var_b7e441e308b3f836, ai_shotgun);
  ai_shotgun set_attackeraccuracy(0.5);
  ai_shotgun set_favoriteenemy(level.player);
  ai_shotgun utility::player_seek_enable();
}

function function_70aa7c0de6b236e() {
  utility::array_spawn_function_targetname("ai_shipyard_cargo_ship_spawners", &function_c437fafa892bc69d, "flag_shipyard_cargo_ship_enemies_one_dead");
  utility::array_spawn_function_noteworthy("ai_shipyard_cargo_ship_high", &function_5c1a68dcf290d147, "flag_shipyard_cargo_ship_fallback", "v_shipyard_cargo_ship_high_fallback", "flag_shipyard_cargo_ship_fallback", 1);
  utility::array_spawn_function_noteworthy("ai_shipyard_cargo_ship_low", &function_5c1a68dcf290d147, "flag_shipyard_cargo_ship_fallback", "v_shipyard_cargo_ship_low_fallback", "flag_shipyard_cargo_ship_fallback", 1);
  var_4096aab7d2bfe630 = utility::array_spawn_targetname("ai_shipyard_cargo_ship_spawners", 1, 1);
  level.var_b7e441e308b3f836 = array_combine(level.var_b7e441e308b3f836, var_4096aab7d2bfe630);
  level utility::flag_set("flag_shipyard_left_cargo_ship_spawn");
  level thread function_7cf3b8f1b807889a(var_4096aab7d2bfe630, "flag_shipyard_cargo_ship_enemies_one_dead", 1, "flag_shipyard_complete");
  level thread function_7cf3b8f1b807889a(var_4096aab7d2bfe630, "flag_shipyard_cargo_ship_enemies_dead", var_4096aab7d2bfe630.size - 1, "flag_shipyard_complete");
  level thread function_50f3b30f4b06ffcf(var_4096aab7d2bfe630, "flag_shipyard_cargo_ship_enemies_player_killed", 1);
  level utility::flag_wait_any("flag_shipyard_advance_07", "flag_shipyard_cargo_ship_enemies_dead");
  level utility::flag_set("flag_shipyard_cargo_ship_fallback");
}

function function_c437fafa892bc69d(str_flag_wait) {
  self endon("death");
  a_ai_allies = [level.farah, level.soap];
  set_attackeraccuracy(0.25);
  self.maxsightdistsqrd = 64000000;
  self.maxvisibledist = 8192;

  if(cointoss()) {
    set_favoriteenemy(random(a_ai_allies));
  } else {
    set_favoriteenemy(undefined);
    self getenemyinfo(level.player);
  }

  level flag_wait(str_flag_wait);

  if(cointoss()) {
    set_attackeraccuracy(0.75);
    set_favoriteenemy(undefined);
    self getenemyinfo(level.player);
    return;
  }

  set_attackeraccuracy(0.5);
  set_favoriteenemy(level.player);
}

function function_5c1a68dcf290d147(str_flag_wait, var_679425c26ece9909, var_9aa63fd1d476501d, b_delete_on_goal) {
  self endon("death");
  b_delete_on_goal = default_to(b_delete_on_goal, 0);
  vol_fallback = getEnt(var_679425c26ece9909, "targetname");

  if(isarray(str_flag_wait)) {
    level utility::flag_wait_any_array(str_flag_wait);
  } else {
    level utility::flag_wait(str_flag_wait);
  }

  if(level utility::flag("flag_shipyard_go_loud")) {
    wait randomfloatrange(1, 3);
  } else {
    wait randomfloatrange(1, 9);
  }

  self getenemyinfo(level.player);
  set_fixednode_false();
  self setgoalpos(self.origin);

  if(isDefined(self.enemy)) {
    self setgoalvolumeauto(vol_fallback, self.enemy.origin - vol_fallback.origin);
  } else {
    self setgoalvolumeauto(vol_fallback, level.player.origin - vol_fallback.origin);
  }

  if(istrue(b_delete_on_goal)) {
    thread function_a2b72ea53c7a311c(vol_fallback);
  }

  set_favoriteenemy(undefined);
  self getenemyinfo(level.player);

  if(isDefined(var_9aa63fd1d476501d)) {
    level utility::flag_wait(var_9aa63fd1d476501d);
    self.balwayscoverexposed = 1;
    set_attackeraccuracy(3);
    set_baseaccuracy(0.75);
    self.health = int(self.health * 0.5) + 1;
  }
}

function function_fd6f6b9e6f29bc49(s_manager) {
  level endon("flag_shipyard_rpgs_target_player");
  level.player endon("death");
  s_manager.n_events = 0;
  s_manager.var_8334109781af758d = 5;

  while(s_manager.var_8334109781af758d > s_manager.n_events && !level utility::flag("flag_shipyard_advance_09")) {
    s_manager waittill("loud_event", num, attacker);
    s_manager.n_events += num;

    iprintln("<dev string:x92>" + s_manager.n_events + "<dev string:xb7>" + s_manager.var_8334109781af758d + "<dev string:xbb>");

    waitframe();
  }

  level flag_set("flag_shipyard_rpgs_target_player");
}

function function_a9f7d0ad9a804150(s_manager) {
  self endon("death");
  thread function_993b68a1314f7cda(s_manager, 1, "flag_shipyard_rpgs_target_player");
  thread function_87cf8740a2dc3c14(s_manager, 1, "flag_shipyard_rpgs_target_player");
  thread function_236c9ffe175446af(s_manager, 0, "flag_shipyard_rpgs_target_player");
  set_attackeraccuracy(0.5);
  set_baseaccuracy(3);
  function_dd21d67ede8ba22(int(self.health * 1.5));
  self.var_669866694e190a3d = 1;
  self function_95d5375059c2a022("default_longrange", 1);
  self.maxsightdistsqrd = 64000000;
  self.maxvisibledist = 8192;
  self.turnthreshold = 50;
  self.providecoveringfire = 1;
  thread function_2137b9a71d7180c4();

  if(level utility::flag("flag_shipyard_player_left")) {
    a_ai_allies = [level.gaz, level.shepherd];
  } else {
    a_ai_allies = [level.farah, level.soap];
  }

  set_favoriteenemy(random(a_ai_allies));
  level utility::flag_wait_or_timeout("flag_shipyard_rpgs_target_player", randomfloatrange(5, 15));
  level flag_set("flag_shipyard_rpgs_target_player");
  set_favoriteenemy(undefined);
  wait randomfloatrange(0.5, 1.5);
  self getenemyinfo(level.player);
  level utility::flag_wait_or_timeout("flag_shipyard_advance_08", randomfloatrange(10, 20));
  set_attackeraccuracy(1);
  level utility::flag_wait_or_timeout("flag_shipyard_advance_09", randomfloatrange(10, 20));

  if(level utility::flag("flag_shipyard_advance_08")) {
    wait randomfloatrange(1, 9);
  } else {
    wait randomfloatrange(10, 20);
  }

  set_attackeraccuracy(2);
  function_dd21d67ede8ba22(int(self.health * 0.5) + 1);
}

function function_2137b9a71d7180c4() {
  self endon("death");
  self.dontshootwhilemoving = 1;
  vol = getEnt("v_shipyard_final_enemies_goal", "targetname");

  while(!self istouching(vol)) {
    wait 1;
  }

  self.suppress_uselastenemysightpos = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;

  while(true) {
    if(isDefined(self.enemy)) {
      self.lastenemysightpos = self.enemy.origin;
    }

    wait 1;
  }
}

function function_661745c9ece26101() {
  level.player endon("death");
  self endon("death");
  level endon("flag_shipyard_complete");
  var_fcf02850d54cd3e = 0;
  n_count = 0;
  var_a1ae564a8bc802c = 3;

  while(true) {
    var_fcf02850d54cd3e = function_19e43f151dcdfb16(self);

    if(istrue(var_fcf02850d54cd3e)) {
      level.player notify("player_ads_on_enemy");

      if(n_count >= var_a1ae564a8bc802c) {
        level.player notify("player_ads_on_enemy_long");
        n_count = var_a1ae564a8bc802c;
      } else {
        n_count++;
      }
    } else {
      n_count = 0;
    }

    wait 0.5;
  }
}

function function_39f0dc8501b481f1() {
  level.player endon("death");
  level endon("flag_shipyard_complete");
  self waittill("death", attacker, meansofdeath, objweapon, damagelocation);

  if(isDefined(attacker) && isPlayer(attacker)) {
    level.player notify("player_killed_shipyard_enemy");
  }
}

function function_11c6452d89c4cd9f() {
  level.player endon("death");
  level flag_wait("flag_shipyard_complete");
  level.var_b7e441e308b3f836 = utility::array_removedead_or_dying(level.var_b7e441e308b3f836);

  if(level.var_b7e441e308b3f836.size == 0) {
    return;
  }

  var_84518695a83195bc = [];

  foreach(ai_enemy in level.var_b7e441e308b3f836) {
    if(isDefined(ai_enemy) && isalive(ai_enemy)) {
      if(isDefined(ai_enemy.scriptedweaponclassprimary) && (ai_enemy.scriptedweaponclassprimary == "rpg" || ai_enemy.scriptedweaponclassprimary == "lmg")) {
        var_84518695a83195bc = array_add(var_84518695a83195bc, ai_enemy);
        continue;
      }

      ai_enemy thread namespace_8339f6377b6ba60e::function_33ca9e74d13d95be(1);
    }
  }

  level utility::flag_wait("flag_finale_holdout_03");
  level thread function_b1b9d62a34ca27a0(var_84518695a83195bc);
}

function function_eb7939bfbf4bfcd4() {}

function function_74b4a048aee6e17e() {
  array_spawn_function_noteworthy("veh_shipyard_jltv_dropoff_1_ai", &function_d9756000789dbf32, "flag_shipyard_jltv_1_enemies_some_dead");
  array_spawn_function_noteworthy("veh_shipyard_jltv_dropoff_2_ai", &function_d9756000789dbf32, "flag_shipyard_jltv_2_enemies_some_dead");
  var_d06461bfc7c92917 = [];
  utility::array_spawn_function_noteworthy("veh_shipyard_jltv_dropoff_1_ai", &function_5c1a68dcf290d147, "flag_shipyard_jltv_fallback", "v_shipyard_all_top_fallback_goal", "flag_shipyard_jltv_fallback", 1);
  utility::array_spawn_function_noteworthy("veh_shipyard_jltv_dropoff_2_ai", &function_5c1a68dcf290d147, "flag_shipyard_jltv_fallback", "v_shipyard_all_top_fallback_goal", "flag_shipyard_jltv_fallback", 1);
  veh_shipyard_jltv_dropoff_1 = vehicle::spawn_vehicle_from_targetname("veh_shipyard_jltv_dropoff_1");
  wait 1;
  veh_shipyard_jltv_dropoff_1 thread function_6b4c0678eb3a553a(veh_shipyard_jltv_dropoff_1.targetname + "_start", "script_noteworthy");
  veh_shipyard_jltv_dropoff_1 thread function_c899c2d562c0ceca();
  veh_shipyard_jltv_dropoff_1 thread function_9ae761b5d5aeba92();
  level utility::flag_set("flag_shipyard_right_jltv_1_spawn");
  var_9c5bd8ddccd9f1eb = get_living_ai_array("veh_shipyard_jltv_dropoff_1_ai", "script_noteworthy");
  level thread function_7cf3b8f1b807889a(var_9c5bd8ddccd9f1eb, "flag_shipyard_jltv_1_enemies_some_dead", int(var_9c5bd8ddccd9f1eb.size * 0.25), "flag_shipyard_complete");
  level thread function_50f3b30f4b06ffcf(var_9c5bd8ddccd9f1eb, "flag_shipyard_jltv_1_enemies_player_killed", 1);
  level.var_b7e441e308b3f836 = array_combine(level.var_b7e441e308b3f836, var_9c5bd8ddccd9f1eb);
  var_d06461bfc7c92917 = array_combine(var_d06461bfc7c92917, var_9c5bd8ddccd9f1eb);
  level utility::flag_wait_any_timeout(10, "flag_shipyard_advance_05", "flag_shipyard_jltv_1_enemies_some_dead");
  level utility::flag_set("flag_shipyard_jltv_1_enemies_dead");
  veh_shipyard_jltv_dropoff_2 = vehicle::spawn_vehicle_from_targetname("veh_shipyard_jltv_dropoff_2");
  wait 1;
  veh_shipyard_jltv_dropoff_2 thread function_6b4c0678eb3a553a(veh_shipyard_jltv_dropoff_2.targetname + "_start", "script_noteworthy");
  veh_shipyard_jltv_dropoff_2 thread function_c899c2d562c0ceca();
  veh_shipyard_jltv_dropoff_2 thread function_9ae761b5d5aeba92();
  level utility::flag_set("flag_shipyard_right_jltv_2_spawn");
  var_9c5bd9ddccd9f41e = get_living_ai_array("veh_shipyard_jltv_dropoff_2_ai", "script_noteworthy");
  level thread function_7cf3b8f1b807889a(var_9c5bd9ddccd9f41e, "flag_shipyard_jltv_2_enemies_some_dead", int(var_9c5bd9ddccd9f41e.size * 0.25), "flag_shipyard_complete");
  level thread function_50f3b30f4b06ffcf(var_9c5bd9ddccd9f41e, "flag_shipyard_jltv_2_enemies_player_killed", 1);
  level.var_b7e441e308b3f836 = array_combine(level.var_b7e441e308b3f836, var_9c5bd9ddccd9f41e);
  var_d06461bfc7c92917 = array_combine(var_d06461bfc7c92917, var_9c5bd9ddccd9f41e);
  var_d06461bfc7c92917 = utility::array_removedead_or_dying(var_d06461bfc7c92917);
  level thread function_7cf3b8f1b807889a(var_d06461bfc7c92917, "flag_shipyard_jltv_enemies_half_dead", int(var_d06461bfc7c92917.size * 0.5) + 1, "flag_shipyard_complete");
  level thread function_7cf3b8f1b807889a(var_d06461bfc7c92917, "flag_shipyard_jltv_enemies_most_dead", var_d06461bfc7c92917.size - 1, "flag_shipyard_complete");
  var_9c5bd8ddccd9f1eb = utility::array_removedead_or_dying(var_9c5bd8ddccd9f1eb);
  goal_vol = getEnt("v_shipyard_far_right_top", "targetname");

  foreach(ai in var_9c5bd8ddccd9f1eb) {
    ai setgoalpos(ai.origin);
    ai setgoalvolumeauto(goal_vol);
  }

  level utility::flag_wait_any("flag_shipyard_advance_08", "flag_shipyard_jltv_enemies_half_dead");
  level utility::flag_set("flag_shipyard_jltv_fallback");
}

function function_50f3b30f4b06ffcf(a_ai_enemies, var_ef2ce443bff9166c, var_5f85309ddd6014cc) {
  level.player endon("death");
  level endon("flag_shipyard_complete");
  level endon(var_ef2ce443bff9166c);

  if(level utility::flag(var_ef2ce443bff9166c)) {
    return;
  }

  if(!isDefined(var_5f85309ddd6014cc)) {
    var_5f85309ddd6014cc = 1;
  }

  s_manager = spawnStruct();
  s_manager.count = 0;

  foreach(ai in a_ai_enemies) {
    ai thread function_1b4022377216f4bd(s_manager, var_ef2ce443bff9166c);
  }

  while(s_manager.count < var_5f85309ddd6014cc) {
    s_manager waittill("shipyard_ai_player_killed");
    s_manager.count++;
    waitframe();
  }

  level utility::flag_set(var_ef2ce443bff9166c);
}

function function_1b4022377216f4bd(s_manager, str_endon_flag) {
  level.player endon("death");
  level endon("flag_shipyard_complete");
  level endon(str_endon_flag);
  self waittill("death", attacker);

  if(isDefined(attacker) && isPlayer(attacker)) {
    s_manager notify("shipyard_ai_player_killed", attacker);
  }
}

function function_9ae761b5d5aeba92() {
  self endon("death");
  ent_flag_wait("veh_end_path");
  thread namespace_8339f6377b6ba60e::function_5717b4e7fcce1693(0, 0);
}

function function_d9756000789dbf32(str_flag_wait) {
  self endon("death");
  level.player endon("death");
  self.vehiclerunexit = 1;
  self.maxsightdistsqrd = 64000000;
  self.maxvisibledist = 8192;
  a_ai_allies = [level.gaz, level.shepherd];
  set_attackeraccuracy(0.25);

  if(cointoss()) {
    set_favoriteenemy(random(a_ai_allies));
  } else {
    set_favoriteenemy(undefined);
    self getenemyinfo(level.player);
  }

  level flag_wait(str_flag_wait);

  if(cointoss()) {
    set_attackeraccuracy(0.75);
    set_favoriteenemy(undefined);
    self getenemyinfo(level.player);
    return;
  }

  set_attackeraccuracy(0.5);
  set_favoriteenemy(level.player);
}

function function_4442dd131c5baf87(a_ai_array) {
  level.player endon("death");
  var_e6f83d3227873a25 = undefined;
  var_b0d21722f3c720c0 = undefined;

  while(!level utility::flag("flag_shipyard_jltv_fallback")) {
    a_ai_array = array_removedead_or_dying(a_ai_array);

    if(a_ai_array.size == 0) {
      return;
    }

    foreach(ai in a_ai_array) {
      if(ai.grenadeammo == 0) {
        a_ai_array = array_remove(a_ai_array, ai);
      }
    }

    if(a_ai_array.size == 0) {
      return;
    }

    var_3cbabdb9ec5e00ae = a_ai_array;

    foreach(ai in var_3cbabdb9ec5e00ae) {
      if(isDefined(var_b0d21722f3c720c0) && ai == var_b0d21722f3c720c0) {
        var_3cbabdb9ec5e00ae = array_remove(var_3cbabdb9ec5e00ae, ai);
      }
    }

    var_e6f83d3227873a25 = random(var_3cbabdb9ec5e00ae);
    msg = var_e6f83d3227873a25 function_3ba8ecdb1cb24d36();

    if(isDefined(msg) && msg == "shipyard_right_grenade_throw") {
      var_b0d21722f3c720c0 = var_e6f83d3227873a25;
      wait randomfloatrange(1, 9);
    } else {
      var_b0d21722f3c720c0 = undefined;
      wait 1;
    }

    waitframe();
  }
}

function function_3ba8ecdb1cb24d36(s_manager) {
  self endon("death");
  thread function_d1d749cce18789eb();
  msg = waittill_notify_or_timeout_return("shipyard_right_grenade_throw", 10);
  self notify("stop_grenade_monitor");
  return msg;
}

function function_d1d749cce18789eb() {
  self endon("death");
  self endon("stop_grenade_monitor");

  if(isDefined(self.favoriteenemy)) {
    pos = self.favoriteenemy.origin + (0, 0, 96);
  } else {
    if(level utility::flag("flag_shipyard_player_right")) {
      my_target = level.player;
    } else {
      my_target = random([level.gaz, level.shepherd]);
    }

    pos = my_target.origin + (0, 0, 96);
  }

  grenade = self magicgrenade(self.origin + (0, 0, 96), pos, 4, 1);
  self waittill("grenade_fire", grenade, weapon);

  if(isDefined(grenade)) {
    self notify("shipyard_right_grenade_throw");
    grenade waittill("death");
  }
}

function function_eb284d8d60987c09() {}

function function_51372fb7b9c06e01() {
  level.player endon("death");
  var_7b557f184ad06d46 = spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var_e9b9ab185c22f9fc = getStructArray("s_shipyard_snowdrift", "targetname");
  trig_underwater = getEnt("shipyard_player_underwater", "targetname");
  msg = level.player waittill_notify_or_timeout_return("player_ads_on_enemy_short", 12);

  if(msg == "player_ads_on_enemy_short") {
    var_6c47449c5cc9e6c2 = 25;
    var_650e75a81da8e5a8 = 1;
  } else {
    var_6c47449c5cc9e6c2 = 50;
    var_650e75a81da8e5a8 = 0;
  }

  screen_origin = undefined;

  while(!flag("flag_shipyard_advance_08")) {
    if(!level.player istouching(trig_underwater)) {
      var_a69f0cad17062b6b = utility::getclosest(level.player.origin, var_e9b9ab185c22f9fc);
      var_7b557f184ad06d46 dontinterpolate();
      var_7b557f184ad06d46.origin = var_a69f0cad17062b6b.origin + (0, 0, 20);

      if(isDefined(var_a69f0cad17062b6b.angles)) {
        var_7b557f184ad06d46.angles = var_a69f0cad17062b6b.angles;
      } else {
        var_7b557f184ad06d46.angles = (0, 0, 0);
      }

      flag_clear("flag_shipyard_snowdrift_off");
      flag_set("flag_shipyard_snowdrift_on");
      var_9c63f33c07671893 = 0;

      if(utility::percent_chance(var_6c47449c5cc9e6c2)) {
        var_9c63f33c07671893 = 1;

        if(level utility::flag("flag_shipyard_advance_04")) {
          var_6c47449c5cc9e6c2 = int(min(0, var_6c47449c5cc9e6c2 - 25));
        } else {
          var_6c47449c5cc9e6c2 = int(min(0, var_6c47449c5cc9e6c2 - 10));
        }
      } else {
        var_9c63f33c07671893 = 0;

        if(level utility::flag("flag_shipyard_advance_04")) {
          var_6c47449c5cc9e6c2 = 25;
        } else {
          var_6c47449c5cc9e6c2 = 50;
        }
      }

      visionset = utility::ter_op(var_9c63f33c07671893, "sp_jup_tundra_shipyard_whiteout_less", "sp_jup_tundra_shipyard_whiteout");
      blendin = utility::ter_op(var_9c63f33c07671893, 1.5, 3);
      blendout = utility::ter_op(var_9c63f33c07671893, 2.5, 4.5);
      enemy_accuracy = utility::ter_op(var_9c63f33c07671893, 0.75, 0.33);
      duration_min = utility::ter_op(var_9c63f33c07671893, 8, 5);
      duration_max = utility::ter_op(var_9c63f33c07671893, 12, 10);
      cooldown_min = utility::ter_op(var_9c63f33c07671893, 4, 8);
      cooldown_max = utility::ter_op(var_9c63f33c07671893, 6, 12);

      foreach(guy in level.var_b7e441e308b3f836) {
        if(isalive(guy) && isDefined(guy)) {
          guy.var_ebab6e86391badae = guy.baseaccuracy;
          guy.baseaccuracy = default_to(enemy_accuracy, 0.75);
        }
      }

      var_3fc9573f89ae1058 = playFXOnTag(getfx("vfx_snowdrift"), var_7b557f184ad06d46, "tag_origin");

      if(!istrue(var_9c63f33c07671893)) {
        if(!isDefined(screen_origin)) {
          screen_origin = spawn_tag_origin(level.player getEye(), level.player.angles);
          screen_origin.origin = level.player getEye();
          screen_origin linkTo(level.player);
        }

        screen_fx = playFXOnTag(getfx("vfx_snowdrift_screen"), screen_origin, "tag_origin");
        level utility::flag_set("flag_shipyard_snowdrift_vo");
      }

      level thread namespace_f74ba02cf5fc717a::function_89261962aa444c35();
      visionsetnaked(visionset, blendin);
      level thread function_3ed0f9973be6594b("strong");
      n_duration = randomfloatrange(duration_min, duration_max);
      msg = level.player waittill_notify_or_timeout_return("shipyard_player_underwater", n_duration);
      stopFXOnTag(getfx("vfx_snowdrift"), var_7b557f184ad06d46, "tag_origin");

      if(!istrue(var_9c63f33c07671893)) {
        stopFXOnTag(getfx("vfx_snowdrift_screen"), screen_origin, "tag_origin");
      }

      if(msg == "shipyard_player_underwater") {
        blendout = 0.5;
      }

      visionsetnaked("", blendout);
      flag_clear("flag_shipyard_snowdrift_on");
      flag_set("flag_shipyard_snowdrift_off");
      level.var_b7e441e308b3f836 = array_removedead_or_dying(level.var_b7e441e308b3f836);

      foreach(guy in level.var_b7e441e308b3f836) {
        if(isalive(guy) && isDefined(guy)) {
          guy.baseaccuracy = default_to(guy.var_ebab6e86391badae, 1);
        }
      }

      level thread function_3ed0f9973be6594b("medium");
      n_cooldown = randomfloatrange(cooldown_min, cooldown_max);
      n_cooldown -= 3;
      wait 3;

      if(istrue(var_650e75a81da8e5a8) && !flag("flag_shipyard_advance_06")) {
        wait n_cooldown;
        var_650e75a81da8e5a8 = 0;
      } else {
        msg = level.player waittill_notify_or_timeout_return("player_ads_on_enemy", n_cooldown);

        if(msg == "player_ads_on_enemy") {
          var_650e75a81da8e5a8 = 1;
        } else {
          var_650e75a81da8e5a8 = 0;
        }
      }

      continue;
    }

    wait 3;
  }

  stopFXOnTag(getfx("vfx_snowdrift"), var_7b557f184ad06d46, "tag_origin");
  visionsetnaked("", 3);
  level thread function_3ed0f9973be6594b("weak");
  level utility::flag_wait("flag_shipyard_snowdrift_transition_finale");
  var_a69f0cad17062b6b = getStruct("snowdrift_transition_finale", "targetname");
  var_7b557f184ad06d46 dontinterpolate();
  var_7b557f184ad06d46.origin = var_a69f0cad17062b6b.origin + (0, 0, 20);

  if(isDefined(var_a69f0cad17062b6b.angles)) {
    var_7b557f184ad06d46.angles = var_a69f0cad17062b6b.angles;
  } else {
    var_7b557f184ad06d46.angles = (0, 0, 0);
  }

  flag_clear("flag_shipyard_snowdrift_off");
  flag_set("flag_shipyard_snowdrift_on");

  if(isDefined(level.var_b7e441e308b3f836)) {
    level.var_b7e441e308b3f836 = array_removedead_or_dying(level.var_b7e441e308b3f836);

    foreach(guy in level.var_b7e441e308b3f836) {
      guy.var_ebab6e86391badae = guy.baseaccuracy;
      guy.baseaccuracy = default_to(0.75, 0.75);
    }
  }

  var_3fc9573f89ae1058 = playFXOnTag(getfx("vfx_snowdrift"), var_7b557f184ad06d46, "tag_origin");

  if(!isDefined(screen_origin)) {
    screen_origin = spawn_tag_origin(level.player getEye(), level.player.angles);
    screen_origin.origin = level.player getEye();
    screen_origin linkTo(level.player);
  }

  screen_fx = playFXOnTag(getfx("vfx_snowdrift_screen"), screen_origin, "tag_origin");
  level thread namespace_f74ba02cf5fc717a::function_89261962aa444c35();
  visionsetnaked("sp_jup_tundra_shipyard_whiteout_less", 1.5);
  level thread function_3ed0f9973be6594b("strong");
  msg = level.player waittill_any_timeout(20, "shipyard_player_underwater", "stop_snowdrift_transition_finale");
  stopFXOnTag(getfx("vfx_snowdrift"), var_7b557f184ad06d46, "tag_origin");
  stopFXOnTag(getfx("vfx_snowdrift_screen"), screen_origin, "tag_origin");
  blendout = 4.5;

  if(msg == "shipyard_player_underwater") {
    blendout = 0.5;
  }

  visionsetnaked("", blendout);
  flag_clear("flag_shipyard_snowdrift_on");
  flag_set("flag_shipyard_snowdrift_off");
  level thread function_3ed0f9973be6594b("weak");
  screen_origin thread utility::delete_after_delay(3);
  var_7b557f184ad06d46 thread utility::delete_after_delay(3);
}

function function_3ed0f9973be6594b(intensity) {
  var_a32a5ea61cee536e = getEntArray("jup_machinery_crane_shipyard_top_01_dyn_01", "targetname");

  foreach(crane in var_a32a5ea61cee536e) {
    crane setscriptablepartstate("main", intensity);
  }

  shipyard_port_tarps = getEntArray("shipyard_port_tarps", "targetname");

  foreach(tarp in shipyard_port_tarps) {
    tarp setscriptablepartstate("main", intensity);
  }

  shipyard_wires = getEntArray("jup_shipyard_wires", "targetname");

  foreach(wire in shipyard_wires) {
    wire setscriptablepartstate("main", intensity);
  }

  shipyard_final_ship_tarps = getEntArray("shipyard_final_ship_tarps", "targetname");

  foreach(tarp in shipyard_final_ship_tarps) {
    tarp setscriptablepartstate("main", intensity);
  }

  switch (intensity) {
    case #"hash_5750d6ce52be2eda":
      lerp_saveddvar(@ "hash_402173c7dbee15d9", 15, 2);
      str_intensity = "30";
      break;
    case #"hash_c71b112fe04823d6":
      lerp_saveddvar(@ "hash_402173c7dbee15d9", 3, 3);
      str_intensity = "15";
      break;
    case #"hash_a1b0ba7432c84029":
    default:
      lerp_saveddvar(@ "hash_402173c7dbee15d9", 1, 5);
      str_intensity = "5";
      break;
  }

  foreach(ally in level.tundra_allies) {
    ally thread namespace_8339f6377b6ba60e::function_590b3a1b2bdf1c57(1, str_intensity);
  }
}

function function_32dadbb3058f50b2() {}

function function_aea665601bae6ad4() {
  level.player endon("death");
  var_24891079dd9b383 = 0;

  while(!flag("flag_shipyard_complete")) {
    if(var_24891079dd9b383 && !level.player isswimming()) {
      iprintln("<dev string:xc3>");

      level.player notify("shipyard_player_abovewater");
      level utility::flag_clear("flag_shipyard_player_underwater");
      flag_clear("disable_autosaves");
      var_24891079dd9b383 = 0;
    } else if(!var_24891079dd9b383 && level.player isswimming()) {
      iprintln("<dev string:xd7>");

      level.player notify("shipyard_player_underwater");
      level utility::flag_set("flag_shipyard_player_underwater");
      flag_set("disable_autosaves");
      var_24891079dd9b383 = 1;
    }

    waitframe();
  }

  iprintln("<dev string:xc3>");

  level.player notify("shipyard_player_abovewater");
  level utility::flag_clear("flag_shipyard_player_underwater");
  flag_clear("disable_autosaves");
}

function function_bc9111f7b4b1add6() {
  level.player endon("death");
  var_bead9ed951e1c1e5 = 0;
  b_exposed = 1;

  while(!flag("flag_shipyard_complete")) {
    if(var_bead9ed951e1c1e5 > 40) {
      b_exposed = function_82bbd2ae7ef1ab44(b_exposed);
      var_bead9ed951e1c1e5 = 0;
    }

    if(b_exposed) {
      if(level.player isswimunderwater()) {
        var_bead9ed951e1c1e5 += 1;
      } else {
        var_bead9ed951e1c1e5 = 0;
      }
    } else if(!level.player isswimming()) {
      var_bead9ed951e1c1e5 += 3;
    } else if(!level.player isswimunderwater()) {
      var_bead9ed951e1c1e5 += 1;
    } else {
      var_bead9ed951e1c1e5 = 0;
    }

    wait 0.01;
  }

  function_82bbd2ae7ef1ab44(0);
}

function function_82bbd2ae7ef1ab44(b_exposed) {
  if(b_exposed) {
    iprintln("<dev string:xe7>");

    level.player.ignoreme = 1;
  } else {
    iprintln("<dev string:xf5>");

    level.player.ignoreme = 0;
  }

  return !b_exposed;
}

function function_c2dfb33166335517() {
  level.player endon("death");
  level endon("flag_shipyard_complete");
  level endon("flag_shipyard_advance_05");
  a_trig = getEntArray("trig_shipyard_underwater_near_edge", "targetname");
  trig_current = undefined;
  trig_last = undefined;
  array_spawn_targetname("ai_shipyard_underwater_takedown");
  a_events = ["grenade", "bullets"];
  var_629c2bd7d6fea957 = a_events;
  event_current = undefined;

  while(true) {
    utility::flag_wait("flag_shipyard_player_underwater");
    trig_current = level function_58d67ad6c6c85c93(a_trig);

    if(!isDefined(trig_current)) {
      wait 1;
      continue;
    }

    event_current = random(var_629c2bd7d6fea957);
    noteworthy_current = trig_current.script_noteworthy;

    switch (event_current) {
      case #"hash_2ad4531076c78728":
        level thread function_f74f7125045fbccf(noteworthy_current);
        break;
      case #"hash_e224d0b635d0dadd":
        level thread function_7be95c0f60a6d6da(noteworthy_current);
        break;
      case #"hash_a91b9fef6637b19e":
      default:
        level thread function_21f567e8ed316079(noteworthy_current);
        break;
    }

    if(var_629c2bd7d6fea957.size <= 1) {
      var_629c2bd7d6fea957 = a_events;
    }

    if(cointoss()) {
      var_629c2bd7d6fea957 = array_remove(var_629c2bd7d6fea957, event_current);
    }

    wait randomfloatrange(4, 6);
  }
}

function function_58d67ad6c6c85c93(a_trig) {
  level.player endon("death");
  level endon("flag_shipyard_complete");
  level.player endon("shipyard_player_abovewater");
  trig = utility::array_any_wait_return(a_trig, "trigger");
  return trig;
}

function function_f74f7125045fbccf(str_noteworthy) {
  level.player endon("death");
  str_name = "ai_" + str_noteworthy;
  spawner = getspawner(str_name, "script_noteworthy");

  if(!isDefined(spawner)) {
    return;
  }

  var_d97d9015455cd441 = spawner spawn_ai(1);

  if(!isDefined(var_d97d9015455cd441)) {
    return;
  }

  iprintln("<dev string:x104>" + str_noteworthy);

  level.var_b7e441e308b3f836 = array_add(level.var_b7e441e308b3f836, var_d97d9015455cd441);
  var_d97d9015455cd441 endon("death");
  var_d97d9015455cd441 set_goal_radius(16);
  var_d97d9015455cd441.var_c4c0a1cd7c882bb9 = 0;
  var_d97d9015455cd441 utility::set_baseaccuracy(0.5);
  var_d97d9015455cd441 utility::set_attackeraccuracy(0.2);
  ai_ally = utility::getclosest(var_d97d9015455cd441.origin, level.tundra_allies);
  var_d97d9015455cd441 utility::set_favoriteenemy(ai_ally);
  var_d97d9015455cd441 ai::function_dd21d67ede8ba22(10);
  var_d97d9015455cd441 waittill("reached_path_end");
  wait randomfloatrange(0.1, 0.9);
  v_offset = anglesToForward(vectortoangles(level.player.origin - var_d97d9015455cd441.origin)) * 64;
  var_afe3d34631c52035 = utility::flatten_vector(v_offset);
  var_321a85f64de0ddd5 = var_d97d9015455cd441.origin + var_afe3d34631c52035 + (0, 0, 16);
  magicgrenademanual("frag", var_321a85f64de0ddd5, (0, 0, 0), 0.1);
}

function function_7be95c0f60a6d6da(str_noteworthy) {
  level.player endon("death");
  str_name = "s_" + str_noteworthy;
  var_7b763244e5e6a01c = getStruct(str_name, "script_noteworthy");

  if(!isDefined(var_7b763244e5e6a01c)) {
    return;
  }

  iprintln("<dev string:x119>" + str_noteworthy);

  var_719e293b878de4e5 = getStruct(var_7b763244e5e6a01c.target, "targetname");
  var_321a85f64de0ddd5 = var_7b763244e5e6a01c.origin;
  n_z_offset = randomfloat(64);
  var_2b413447b7020d2c = var_719e293b878de4e5.origin + (0, 0, n_z_offset);
  n_fuse_time = randomfloatrange(2, 4);
  magicgrenade("frag", var_321a85f64de0ddd5, var_2b413447b7020d2c, n_fuse_time);
}

function function_21f567e8ed316079(str_noteworthy) {
  level.player endon("death");
  level.player endon("shipyard_player_abovewater");
  str_name = "s_" + str_noteworthy;
  s_mb_start = getStruct(str_name, "script_noteworthy");

  if(!isDefined(s_mb_start)) {
    return;
  }

  iprintln("<dev string:x12e>" + str_noteworthy);

  var_c255f25e3abd7952 = getStruct(s_mb_start.target, "targetname");
  var_10a647d9b5f6c82 = s_mb_start.origin + (0, 0, 128);
  var_78d61d8414b8e127 = var_c255f25e3abd7952.origin;
  n_shots = randomintrange(3, 12);
  n_fire_delay = 0.15;
  n_offset_x = ter_op(cointoss(), -24, 24);

  for(i = 0; i < n_shots; i++) {
    n_offset_y = randomfloatrange(-12, 12);
    magicbullet("iw9_ar_mike4_sp", var_10a647d9b5f6c82, var_78d61d8414b8e127 + (n_offset_x, n_offset_y, 0));
    wait n_fire_delay;
  }
}

function function_4524d183ca2fbc2e() {}

function function_2f02d46f009e77d1(s_manager) {
  level.player endon("death");
  level endon("flag_shipyard_go_loud");
  level utility::flag_wait("flag_shipyard_advance_02");
  n_counter = 1;
  n_wait = 3;
  var_2e41744a58d7e738 = 0;

  while(true) {
    if(!istrue(var_2e41744a58d7e738) && utility::flag("flag_shipyard_advance_03")) {
      n_counter = 2;
      n_wait = 2;
      var_2e41744a58d7e738 = 1;
    }

    s_manager notify("loud_event", n_counter, level.player);
    wait n_wait;
  }
}

function function_e8174f3628bbae4d(s_manager) {
  level.player endon("death");
  level endon("flag_shipyard_go_loud");
  s_manager.var_aca8f49b9f536556 = 0;
  s_manager.var_a5a03b7d87d14fc9 = 15;
  battlechatter_off("axis");
  attacker = undefined;

  iprintln("<dev string:x143>");

  while(s_manager.var_a5a03b7d87d14fc9 > s_manager.var_aca8f49b9f536556) {
    s_manager waittill("loud_event", num, attacker);
    s_manager.var_aca8f49b9f536556 += num;

    iprintln("<dev string:x164>" + s_manager.var_aca8f49b9f536556 + "<dev string:xb7>" + s_manager.var_a5a03b7d87d14fc9 + "<dev string:xbb>");

    waitframe();
  }

  iprintln("<dev string:x17d>");

  level flag_set("flag_shipyard_go_loud", attacker);
}

function function_2f250d3bc4b4a574(s_manager, var_111a1ac1afaefc7c) {
  level.player endon("death");
  self endon("death");

  if(level utility::flag("flag_shipyard_go_loud")) {
    return;
  }

  ent_flag_init("enemy_stay_quiet");
  ent_flag_set("enemy_stay_quiet");
  demeanor = "sprint";

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "random") {
      demeanor = ter_op(cointoss(), "sprint", "cqb");
    } else {
      demeanor = self.script_parameters;
    }
  }

  utility::demeanor_override(demeanor);
  self.dontshootwhilemoving = 1;
  self.dontevershoot = 1;
  self.og_grenadeammo = self.grenadeammo;
  self.var_43ae9f4734246fb0 = 1;
  allies = array_add(level.tundra_allies, level.player);

  if(isDefined(var_111a1ac1afaefc7c)) {
    vol_goal = getEnt(var_111a1ac1afaefc7c, "targetname");
    ally = getclosest(vol_goal.origin, allies);
    self getenemyinfo(ally);
  } else {
    ally = getclosest(self.origin, allies);
    self getenemyinfo(ally);
  }

  thread function_993b68a1314f7cda(s_manager);
  thread function_87cf8740a2dc3c14(s_manager);
  thread function_236c9ffe175446af(s_manager);
  attacker = level utility::flag_wait("flag_shipyard_go_loud");

  if(isDefined(attacker)) {
    n_dist_sq = distance2dsquared(self.origin, attacker.origin);
    n_delay = n_dist_sq * 2e-06;
    wait randomfloatrange(n_delay, n_delay * 2);
  } else {
    wait randomfloatrange(0.5, 1.5);
  }

  ent_flag_clear("enemy_stay_quiet");
  utility::clear_demeanor_override();
  self.dontevershoot = 0;
  self.grenadeammo = self.og_grenadeammo;
  self.dontshootwhilemoving = 0;
  self.var_43ae9f4734246fb0 = 0;
  ally = getclosest(self.origin, allies);
  self getenemyinfo(ally);

  if(isDefined(var_111a1ac1afaefc7c) && !isDefined(self getgoalvolume())) {
    set_fixednode_false();
    self setgoalpos(self.origin);
    self setgoalvolumeauto(vol_goal);
  }
}

function function_993b68a1314f7cda(s_manager, var_231fa8c79b0b9aa3, flg_endon) {
  level.player endon("death");
  flg_endon = default_to(flg_endon, "flag_shipyard_go_loud");
  level endon(flg_endon);
  self endon("death");
  var_231fa8c79b0b9aa3 = default_to(var_231fa8c79b0b9aa3, 0);
  var_8fbb1e13df110370 = squared(384);
  var_c9cc659b34dadad = squared(512);

  if(istrue(var_231fa8c79b0b9aa3)) {
    a_allies = [level.player];
  } else {
    a_allies = array_add(level.tundra_allies, level.player);
  }

  while(true) {
    if(ent_flag_exist("force_loud") && ent_flag("force_loud")) {
      s_manager notify("loud_event", 20, level.player);
    }

    ally = getclosest(self.origin, a_allies);
    dist_sq = distance2dsquared(self.origin, ally.origin);

    if(isPlayer(ally) && dist_sq < var_c9cc659b34dadad) {
      if(ally getstance() == "stand") {
        s_manager notify("loud_event", 3, ally);
      } else {
        s_manager notify("loud_event", 1, ally);
      }
    } else if(dist_sq < var_8fbb1e13df110370) {
      s_manager notify("loud_event", 1, ally);
    }

    wait 1;
  }
}

function function_87cf8740a2dc3c14(s_manager, var_231fa8c79b0b9aa3, flg_endon) {
  level.player endon("death");
  flg_endon = default_to(flg_endon, "flag_shipyard_go_loud");
  level endon(flg_endon);
  self endon("death");
  var_231fa8c79b0b9aa3 = default_to(var_231fa8c79b0b9aa3, 0);

  while(true) {
    self waittill("damage", amount, attacker);

    if(!isDefined(self) || !isalive(self)) {
      return;
    }

    if(isDefined(attacker)) {
      if(isPlayer(attacker)) {
        s_manager notify("loud_event", 20, attacker);
      } else if(!istrue(var_231fa8c79b0b9aa3) && utility::array_contains(level.tundra_allies, attacker)) {
        s_manager notify("loud_event", 10, attacker);
      }
    }

    waitframe();
  }
}

function function_236c9ffe175446af(s_manager, var_231fa8c79b0b9aa3, flg_endon) {
  level.player endon("death");
  self endon("stop_quiet_enemy_monitor");
  flg_endon = default_to(flg_endon, "flag_shipyard_go_loud");
  level endon(flg_endon);
  var_231fa8c79b0b9aa3 = default_to(var_231fa8c79b0b9aa3, 0);
  self waittill("death", attacker, meansofdeath, objweapon, damagelocation);
  assertex(isDefined(attacker), "Shipyard quiet guy died mysteriously at " + self.origin);

  if(isDefined(attacker)) {
    if(isPlayer(attacker)) {
      s_manager notify("loud_event", 20, attacker);
      return;
    }

    if(!istrue(var_231fa8c79b0b9aa3) && utility::array_contains(level.tundra_allies, attacker)) {
      s_manager notify("loud_event", 10, attacker);
    }
  }
}