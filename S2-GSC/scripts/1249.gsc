/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1249.gsc
**************************************/

_id_772B(var_0, var_1) {}

init() {
  level._id_4F51 = [];
  _id_8A3C();
  _id_8A23();
  _id_8A07();
  _id_8A2D();
  _id_8A54();
  _id_8A1F();
  _id_8A02();
  _id_8A49();
  _id_8A20("scorestreak_training_npc", "scorestreak_officer_menu", undefined, "score_streak_visit", undefined);
  _id_8A20("commander_npc", "company_commander_menu", undefined, "commander_visit", (-4, -1, -8));
  _id_8A20("tdm_playlist_obj", "tdm_playlist_menu", undefined, "mp_npc_visit");
  _id_8A20("dom_playlist_obj", "dom_playlist_menu", undefined, "dom_visit");
  _id_8A20("war_playlist_obj", "war_playlist_menu", undefined, "war_npc_visit");
  _id_8A20("r_and_r_obj", "r_and_r_menu", undefined, "r_and_r_visit", undefined);
  _id_8A20("ranked_playlist_obj", "ranked_playlist_menu", undefined, "ranked_visit");
  _id_8A20("overlook_guard_npc", "overlook_menu", undefined, undefined, (0, 0, -2));
  _id_8A20("division_prestige_npc", "division_prestige_menu", undefined, undefined, undefined);
  _id_A937();
  waitframe();
  level._id_A409 = _func_18E("quartermaster_camera", "targetname");
  level._id_A40F = common_scripts\utility::_id_46B5("quartermaster_spawn", "targetname");
  level._id_A408 = common_scripts\utility::_id_46B5("quartermaster_bg_spawn", "targetname");
  level._id_4F4A = getdvarint("cg_fov");

  if(!isDefined(level._id_A40F))
    level._id_A40F = _func_18E("quartermaster_spawn", "targetname");

  if(!isDefined(level._id_A408))
    level._id_A408 = _func_18E("quartermaster_bg_spawn", "targetname");

  if(!isDefined(level._id_A409) || !isDefined(level._id_A40F) || !isDefined(level._id_A408)) {
    return;
  }
  var_0 = common_scripts\utility::_id_44BD("mail_spawn_03", "targetname");
  var_1 = common_scripts\utility::_id_44BD("mail_bg_spawn_03", "targetname");
  var_2 = common_scripts\utility::_id_44BD("mail_camera_03", "targetname");
  var_3 = common_scripts\utility::_id_44BD("operations_spawn_02", "targetname");
  var_4 = common_scripts\utility::_id_44BD("operations_bg_spawn_02", "targetname");
  var_5 = common_scripts\utility::_id_44BD("operations_camera_02", "targetname");
  _id_772B(level._id_A409, "quartermasterCamera");
  _id_772B(level._id_A40F, "quartermasterSpawn");
  _id_772B(level._id_A408, "quartermasterBgSpawn");
  _id_772B(var_2, "mailCamera");
  _id_772B(var_0, "mailSpawn");
  _id_772B(var_1, "mailBgSpawn");
  _id_772B(var_5, "operationsCamera");
  _id_772B(var_3, "operationsSpawn");
  _id_772B(var_4, "operationsBgSpawn");
}

_id_7BE9() {
  if(getdvarint("spv_hub_vendors_kswitch", 1) == 0) {
    foreach(var_1 in level._id_4F51) {
      if(isDefined(var_1) && isDefined(var_1._id_6113)) {
        if(!isDefined(var_1._id_5A7E) || getdvarint(var_1._id_5A7E, 1) == 0)
          self _meth_84EA(var_1, var_1._id_6113);
      }
    }
  }
}

_id_A90E() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("player_migrated");
    _id_7BE9();
  }
}

_id_A937() {
  level endon("game_ended");

  if(isDefined(level.players)) {
    foreach(var_1 in level.players)
    var_1 _id_7BE9();
  }

  for(;;) {
    level waittill("connected", var_1);
    var_1 thread _id_A90E();
    var_1 _id_7BE9();
  }
}

_id_8A3C() {
  level._id_781C = _func_18E("quartermaster_npc", "targetname");
  level._id_781C._id_831A = common_scripts\utility::_id_44BD("quartermaster_scripted_node", "targetname");
  _id_772B(level._id_781C._id_831A, "quartermaster_scripted_node");

  if(!isDefined(level._id_781C)) {
    return;
  }
  level._id_781C._id_5A7E = "spv_hub_quartermasterVendor_kswitch";
  level._id_4F51[level._id_4F51.size] = level._id_781C;
  var_0 = level._id_781C.origin + (0, 0, 40);
  level._id_781C setModel("tag_origin");
  level._id_781C.origin = var_0;
  level._id_781C._id_50DA = 0;
  level._id_781C._id_56A9 = 1;
  level._id_781C._id_9FEB = "ui_show_quartermaster_hud";
  level._id_781C._id_6113 = "quartermaster_menu";
  level._id_781C._id_1739 = "hub_allies_bg_quartermaster";
}

_id_8A23() {
  level._id_4BF3 = _func_18E("headquarters_npc", "targetname");
  level._id_4BF3._id_831A = common_scripts\utility::_id_44BD("headquarters_scripted_node", "targetname");
  _id_772B(level._id_4BF3._id_831A, "headquarters_scripted_node");

  if(!isDefined(level._id_4BF3)) {
    return;
  }
  level._id_4BF3._id_5A7E = "spv_hub_requisitionsVendor_kswitch";
  level._id_4F51[level._id_4F51.size] = level._id_4BF3;

  if(!1) {
    level._id_4BF3._id_6DFB = [];
    var_0 = spawn("script_model", (0, 0, 0));
    var_0 setModel("mp_hub_revolving_chair_01");
    var_0.name = "ro_chair";
    level._id_4BF3._id_6DFB["ro_chair"] = var_0;
    var_1 = spawn("script_model", (0, 0, 0));
    var_1 setModel("usa_huba_org1");
    var_1 _id_04E0::_id_8627();
    var_1.name = "aide_1";
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel("dun_usa_pencil_01");
    var_2.name = "aide_1_pencil";
    var_3 = spawn("script_model", (0, 0, 0));
    var_3 setModel("hub_us_ruler_01");
    var_3.name = "aide_1_ruler";
    var_4 = spawn("script_model", (0, 0, 0));
    var_4 setModel("hub_map_marker_01");
    var_4.name = "aide_1_marker";
    var_5 = spawn("script_model", (0, 0, 0));
    var_5 setModel("usa_hubc_org1");
    var_5 _id_04E0::_id_8627();
    var_5.name = "aide_2";
    var_6 = spawn("script_model", (0, 0, 0));
    var_6 setModel("usa_phone_ee8");
    var_6.name = "aide_2_phone";
    level._id_4BF3._id_0ED2 = [];
    level._id_4BF3._id_0ED2["vendor"] = [];
    level._id_4BF3._id_0ED2["vendor"][0] = [];
    level._id_4BF3._id_0ED2["ro_chair"] = [];
    level._id_4BF3._id_0ED2["ro_chair"][0] = [];
    level._id_4BF3._id_0ED2["aide_1"] = [];
    level._id_4BF3._id_0ED2["aide_1_pencil"] = [];
    level._id_4BF3._id_0ED2["aide_1_ruler"] = [];
    level._id_4BF3._id_0ED2["aide_2"] = [];
    level._id_4BF3._id_0ED2["aide_2_phone"] = [];
    level._id_4BF3._id_0EAC = [];
    level._id_4BF3._id_0ED2["vendor"][0][0] = "mp_hub_ro_idle";
    level._id_4BF3._id_0ED2["vendor"][0][1] = "mp_hub_ro_ask_map_ro";
    level._id_4BF3._id_0ED2["vendor"][0][2] = "mp_hub_ro_talking_ro";
    level._id_4BF3._id_0ED2["vendor"][0][3] = "mp_hub_ro_twitch_b";
    level._id_4BF3._id_0ED2["vendor"][0][4] = "mp_hub_ro_stretch_standing";
    level._id_4BF3._id_0ED2["vendor"][0][5] = "mp_hub_ro_twitch_c";
    level._id_4BF3._id_0ED2["vendor"][0][6] = "mp_hub_ro_ask_cordinate_ro";
    level._id_4BF3._id_0ED2["vendor"][0][7] = "mp_hub_ro_twitch_a";
    level._id_4BF3._id_0ED2["vendor"][0][8] = "mp_hub_ro_phone_call_ro";
    level._id_4BF3._id_0ED2["ro_chair"][0][0] = "mp_hub_ro_idle_chair";
    level._id_4BF3._id_0ED2["ro_chair"][0][1] = "mp_hub_ro_ask_map_chair";
    level._id_4BF3._id_0ED2["ro_chair"][0][2] = "mp_hub_ro_talking_ro_chair";
    level._id_4BF3._id_0ED2["ro_chair"][0][3] = "mp_hub_ro_twitch_b_chair";
    level._id_4BF3._id_0ED2["ro_chair"][0][4] = "mp_hub_ro_stretch_standing_chair";
    level._id_4BF3._id_0ED2["ro_chair"][0][5] = "mp_hub_ro_twitch_c_chair";
    level._id_4BF3._id_0ED2["ro_chair"][0][6] = "mp_hub_ro_ask_cordinate_chair";
    level._id_4BF3._id_0ED2["ro_chair"][0][7] = "mp_hub_ro_twitch_a_chair";
    level._id_4BF3._id_0ED2["ro_chair"][0][8] = "mp_hub_ro_phone_call_chair";
    level._id_4BF3._id_0B42["idle"] = "mp_hub_ro_aide_01_idle";
    level._id_4BF3._id_0B42["twitch_a"] = "mp_hub_ro_aide_01_twitch_a";
    level._id_4BF3._id_0B42["twitch_b"] = "mp_hub_ro_aide_01_twitch_b";
    level._id_4BF3._id_0B42["coordinate"] = "mp_hub_ro_ask_cordinate_aide_01";
    level._id_4BF3._id_0B42["map"] = "mp_hub_ro_ask_map_aide_01";
    level._id_4BF3._id_0B44["idle"] = "mp_hub_ro_aide_01_twitch_a_pencil_idle";
    level._id_4BF3._id_0B44["twitch_a"] = "mp_hub_ro_aide_01_twitch_a_pencil";
    level._id_4BF3._id_0B44["twitch_b"] = "mp_hub_ro_aide_01_twitch_b_pencil";
    level._id_4BF3._id_0B45["idle"] = "mp_hub_ro_aide_01_twitch_b_ruler_idle";
    level._id_4BF3._id_0B45["twitch_b"] = "mp_hub_ro_aide_01_twitch_b_ruler";
    level._id_4BF3._id_0B43["idle"] = "mp_hub_ro_ask_map_marker_01_idle";
    level._id_4BF3._id_0B43["map"] = "mp_hub_ro_ask_map_marker_01";
    level._id_4BF3._id_0B46["idle"] = "mp_hub_ro_aide_02_idle";
    level._id_4BF3._id_0B46["call"] = "mp_hub_ro_phone_call_aide_02";
    level._id_4BF3._id_0B46["talking"] = "mp_hub_ro_talking_aide_02";
    level._id_4BF3._id_0B46["twitch_a"] = "mp_hub_ro_aide_02_twitch_a";
    level._id_4BF3._id_0B46["twitch_b"] = "mp_hub_ro_aide_02_twitch_b";
    level._id_4BF3._id_0B47["idle"] = "mp_hub_ro_aide_02_idle_phone";
    level._id_4BF3._id_0B47["call"] = "mp_hub_ro_phone_call_02_phone";
    level._id_4BF3._id_0B47["talking"] = "mp_hub_ro_talking_aide_02_phone";
    level._id_4BF3._id_0B47["twitch_a"] = "mp_hub_ro_aide_02_twitch_a_phone";
    level._id_4BF3._id_0B47["twitch_b"] = "mp_hub_ro_aide_02_twitch_b_phone";
    level._id_4BF3._id_0ED2["confirm"] = "mp_hub_requisition_officer_reaction_positive";
    level._id_4BF3._id_0ED2["deny"] = "mp_hub_requisition_officer_reaction_negative";
    level._id_4BF3._id_0ED2["enterMenu"] = "mp_hub_requisition_officer_transition";
    level._id_4BF3._id_A40D = "usa_requisition_org1";
    var_7 = spawn("script_model", (0, 0, 0));
    var_7 setModel("hub_us_candlestick_microphone_01");
    var_7 _meth_8055(level._id_4BF3, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
    level._id_4BF3._id_267E = [507, 504, 0, 0, 0, 0];
    level._id_4BF3 _meth_84C7(level._id_4BF3._id_267E);
    level._id_4BF3._id_0EAC["mp_hub_ro_ask_cordinate_ro"] = spawnStruct();
    level._id_4BF3._id_0EAC["mp_hub_ro_ask_cordinate_ro"]._id_3F02 = _id_04E0::_id_83DE;
    level._id_4BF3._id_0EAC["mp_hub_ro_ask_cordinate_ro"]._id_0F5D = [var_1, "coordinate"];
    level._id_4BF3._id_0EAC["mp_hub_ro_phone_call_ro"] = spawnStruct();
    level._id_4BF3._id_0EAC["mp_hub_ro_phone_call_ro"]._id_3F02 = _id_04E0::_id_83DE;
    level._id_4BF3._id_0EAC["mp_hub_ro_phone_call_ro"]._id_0F5D = [var_5, "call", var_6, "call"];
    level._id_4BF3._id_0EAC["mp_hub_ro_ask_map_ro"] = spawnStruct();
    level._id_4BF3._id_0EAC["mp_hub_ro_ask_map_ro"]._id_3F02 = _id_04E0::_id_83DE;
    level._id_4BF3._id_0EAC["mp_hub_ro_ask_map_ro"]._id_0F5D = [var_1, "map", var_4, "map"];
    level._id_4BF3._id_0EAC["mp_hub_ro_talking_ro"] = spawnStruct();
    level._id_4BF3._id_0EAC["mp_hub_ro_talking_ro"]._id_3F02 = _id_04E0::_id_83DE;
    level._id_4BF3._id_0EAC["mp_hub_ro_talking_ro"]._id_0F5D = [var_5, "talking", var_6, "talking"];
    level._id_4BF3._id_0EAC["mp_hub_ro_twitch_b"] = spawnStruct();
    level._id_4BF3._id_0EAC["mp_hub_ro_twitch_b"]._id_3F02 = _id_04E0::_id_83DE;
    level._id_4BF3._id_0EAC["mp_hub_ro_twitch_b"]._id_0F5D = [var_5, "twitch_a", var_6, "twitch_a"];
    level._id_4BF3._id_0EAC["mp_hub_ro_twitch_a"] = spawnStruct();
    level._id_4BF3._id_0EAC["mp_hub_ro_twitch_a"]._id_3F02 = _id_04E0::_id_83DE;
    level._id_4BF3._id_0EAC["mp_hub_ro_twitch_a"]._id_0F5D = [var_5, "twitch_b", var_6, "twitch_b"];
    level._id_4BF3 thread _id_71F3();
    thread _id_04E0::_id_74AB(var_1, level._id_4BF3._id_0B42, level._id_4BF3._id_831A, ["idle", "coordinate", "map", "twitch_b"]);
    thread _id_04E0::_id_74AB(var_2, level._id_4BF3._id_0B44, level._id_4BF3._id_831A, ["idle", "twitch_b"]);
    thread _id_04E0::_id_74AB(var_4, level._id_4BF3._id_0B43, level._id_4BF3._id_831A, ["idle", "map"]);
    thread _id_04E0::_id_74AB(var_3, level._id_4BF3._id_0B45, level._id_4BF3._id_831A, ["idle", "twitch_b"]);
    thread _id_04E0::_id_74AB(var_5, level._id_4BF3._id_0B46, level._id_4BF3._id_831A, ["idle", "call", "talking", "twitch_a", "twitch_b"]);
    thread _id_04E0::_id_74AB(var_6, level._id_4BF3._id_0B47, level._id_4BF3._id_831A, ["idle", "call", "talking", "twitch_a", "twitch_b"]);
  } else {
    var_8 = level._id_4BF3.origin + (0, 0, 40);
    level._id_4BF3 setModel("tag_origin");
    level._id_4BF3.origin = var_8;
  }

  level._id_4BF3._id_9FEB = "ui_show_headquarters_hud";
  level._id_4BF3._id_6113 = "headquarters_menu";
  level._id_4BF3._id_1739 = "hub_allies_bg_requisition";
  level._id_4BF3._id_A5CE = [];
  level._id_4BF3._id_A5CE["world"] = [];
  level._id_4BF3._id_A5CE["world"][0] = "hub_requisition_world_ambient1";
  level._id_4BF3._id_A5CE["world"][1] = "hub_requisition_world_ambient2";
  level._id_4BF3._id_A5CE["world"][2] = "hub_requisition_world_ambient3";
  level._id_4BF3._id_A5CE["interact"] = [];
  level._id_4BF3._id_A5CE["interact"][0] = "hub_requisition_interact1";
  level._id_4BF3._id_A5CE["interact"][1] = "hub_requisition_interact2";
  level._id_4BF3._id_A5CE["interact"][2] = "hub_requisition_interact3";
  level._id_4BF3._id_A5CE["stage"] = [];
  level._id_4BF3._id_A5CE["stage"][0] = "hub_requisition_stage_ambient1";
  level._id_4BF3._id_A5CE["stage"][1] = "hub_requisition_stage_ambient2";
  level._id_4BF3._id_A5CE["action1"] = [];
  level._id_4BF3._id_A5CE["action1"][0] = "hub_requisition_selection1";
  level._id_4BF3._id_A5CE["action1"][1] = "hub_requisition_selection2";
  level._id_4BF3._id_A5CE["fail"] = [];
  level._id_4BF3._id_A5CE["fail"][0] = "hub_requisition_selection_fail1";
  level._id_4BF3._id_A5CE["fail"][1] = "hub_requisition_selection_fail2";
  level._id_4BF3._id_A5CE["reinteract"] = [];
  level._id_4BF3._id_A5CE["reinteract"][0] = "hub_requisition_reinteract1";
  level._id_4BF3._id_A5CE["reinteract"][1] = "hub_requisition_reinteract2";
  level._id_4BF3._id_A5CE["leave"] = "hub_requisition_leave";
  thread _id_71F4(level._id_4BF3, "world");
  level._id_4BF3._id_50DA = 0;
  level._id_4BF3._id_56A9 = 1;
}

_id_8A07() {
  level._id_1783 = _func_18E("blacksmith_npc", "targetname");
  level._id_1783._id_831A = common_scripts\utility::_id_44BD("blacksmith_scripted_node", "targetname");

  if(!isDefined(level._id_1783)) {
    return;
  }
  _id_772B(level._id_1783._id_831A, "blacksmith_scripted_node");
  level._id_1783._id_5A7E = "spv_hub_gunsmithVendor_kswitch";
  level._id_4F51[level._id_4F51.size] = level._id_1783;

  if(1)
    level._id_1783 setModel("tag_origin");
  else {
    level._id_1783._id_6DFB = [];
    var_0 = spawn("script_model", (0, 0, 0));
    var_0._id_00B9 = "hubc";
    var_0._id_18A8 = "hubc";
    var_0 _id_04E0::_id_8627();
    var_0.name = "aide1";
    var_0._id_5717 = 0;
    var_1 = spawn("script_model", (0, 0, 0));
    var_1 setModel("npc_usa_m1garand_base");
    var_1 _meth_8055(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
    level._id_1783._id_6DFB["aide1"] = var_0;
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel("mp_hub_allies_bench_grinder_01");
    var_2.name = "grinder";
    level._id_1783._id_6DFB["grinder"] = var_2;
    var_3 = spawn("script_model", (0, 0, 0));
    var_3 setModel("npc_usa_bayonet_long_base");
    var_3.name = "knife";
    var_3 _meth_8055(level._id_1783, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    level._id_1783._id_0EAC = [];
    level._id_1783._id_0ED2["vendor"] = [];
    level._id_1783._id_0ED2["vendor"][0] = [];
    level._id_1783._id_0ED2["aide1"] = [];
    level._id_1783._id_0ED2["aide1"][0] = [];
    level._id_1783._id_0ED2["vendor"][0][0] = "mp_hub_gs_sharpening_knife_loop";
    level._id_1783._id_0ED2["vendor"][0][1] = "mp_hub_gs_sharpening_knife_loop";
    level._id_1783._id_0ED2["aide1"][0][0] = "mp_hub_gs_aide_idle";
    level._id_1783._id_0ED2["grinder"][0][0] = "mp_hub_gs_sharpening_knife_loop_grinder";
    level._id_1783._id_267E = [508, 505, 0, 0, 0, 0];
    level._id_1783 _meth_84C7(level._id_1783._id_267E);
  }

  level._id_1783._id_A40D = "usa_f_blacksmith_org1";
  level._id_1783._id_9FEB = "ui_show_blacksmith_hud";
  level._id_1783._id_6113 = "blacksmith_menu";
  level._id_1783._id_1739 = "hub_allies_bg_blacksmith";
  level._id_1783._id_A5CE = [];
  level._id_1783._id_A5CE["world"] = [];
  level._id_1783._id_A5CE["world"][0] = "hub_blacksmith_world_ambient1";
  level._id_1783._id_A5CE["world"][1] = "hub_blacksmith_world_ambient2";
  level._id_1783._id_A5CE["world"][2] = "hub_blacksmith_world_ambient3";
  level._id_1783._id_A5CE["interact"] = [];
  level._id_1783._id_A5CE["interact"][0] = "hub_blacksmith_interact1";
  level._id_1783._id_A5CE["interact"][1] = "hub_blacksmith_interact2";
  level._id_1783._id_A5CE["interact"][2] = "hub_blacksmith_interact3";
  level._id_1783._id_A5CE["stage"] = "hub_blacksmith_stage_ambient";
  level._id_1783._id_A5CE["action1"] = [];
  level._id_1783._id_A5CE["action1"][0] = "hub_blacksmith_prestige1";
  level._id_1783._id_A5CE["action1"][1] = "hub_blacksmith_prestige2";
  level._id_1783._id_A5CE["action2"] = "hub_blacksmith_craft1";
  level._id_1783._id_A5CE["fail1"] = "hub_blacksmith_prestige_fail";
  level._id_1783._id_A5CE["fail2"] = "hub_blacksmith_craft_fail";
  level._id_1783._id_A5CE["reinteract"] = [];
  level._id_1783._id_A5CE["reinteract"][0] = "hub_blacksmith_reinteract1";
  level._id_1783._id_A5CE["reinteract"][1] = "hub_blacksmith_reinteract2";
  level._id_1783._id_A5CE["leave"] = "hub_blacksmith_leave";
  thread _id_71F4(level._id_1783, "world");
  level._id_1783._id_50DA = 0;
  level._id_1783._id_56A9 = 1;

  if(!1)
    level._id_1783 thread _id_71F3();
}

_id_8A2D() {
  level._id_5F83 = _func_18E("mail_npc", "targetname");

  if(!isDefined(level._id_5F83)) {
    return;
  }
  level._id_5F83._id_5A7E = "spv_hub_payrollVendor_kswitch";
  level._id_4F51[level._id_4F51.size] = level._id_5F83;
  level._id_5F83._id_9FEB = "ui_show_mail_hud";
  level._id_5F83._id_6113 = "mail_officer_menu";
  level._id_5F83._id_1739 = "hub_allies_bg_quartermaster";
  level._id_5F83._id_50DA = 1;
  level._id_5F83._id_56A9 = 1;
}

_id_8A54() {
  level._id_AC32 = _func_18E("zombie_npc", "targetname");

  if(!isDefined(level._id_AC32)) {
    return;
  }
  _id_772B(level._id_AC32, "zombie_placement");
  level._id_AC32 setModel("tag_origin");
  level._id_AC32.origin = level._id_AC32.origin + (0, 2.5, 52);
  level._id_AC32._id_5A7E = "spv_hub_zombiesVendor_kswitch";
  level._id_4F51[level._id_4F51.size] = level._id_AC32;
  level._id_AC32._id_0EAC = [];
  level._id_AC32._id_0ED2["idleTwitch"] = [];
  level._id_AC32._id_0ED2["idle"] = "mp_hub_zombie_officer_idle";
  level._id_AC32._id_0ED2["idleTwitch"]["A"] = "mp_hub_zombie_officer_twitch_a";
  level._id_AC32._id_A40D = "usa_zombie_org1";
  level._id_AC32._id_9FEB = "ui_show_zombie_playlist_hud";
  level._id_AC32._id_6113 = "zombie_officer_menu";
  level._id_AC32._id_1739 = "hub_allies_bg_zombie";
  level._id_AC32._id_50DA = 0;
  level._id_AC32._id_56A9 = 1;
}

_id_8A1F() {
  level._id_4012 = _func_18E("general_npc", "targetname");
  level._id_4012._id_831A = common_scripts\utility::_id_44BD("general_scripted_node", "targetname");
  _id_772B(level._id_4012._id_831A, "general_scripted_node");

  if(!isDefined(level._id_4012)) {
    return;
  }
  level._id_4012._id_5A7E = "spv_hub_prestigeVendor_kswitch";
  level._id_4012._id_6DFB = [];
  level._id_4012._id_0EAC = [];
  level._id_4012._id_0ED2["vendor"][0][0] = "mp_hub_general_idle";
  level._id_4012._id_0ED2["vendor"][0][1] = "mp_hub_general_twitch_a";
  level._id_4012._id_0ED2["vendor"][0][2] = "mp_hub_general_twitch_b";
  level._id_4012._id_0ED2["vendor"][0][3] = "mp_hub_general_twitch_c";
  level._id_4012._id_0ED2["vendor"][0][4] = "mp_hub_general_twitch_d";
  level._id_4012._id_0ED2["vendor"][0][5] = "mp_hub_general_idle2overlook";
  level._id_4012._id_0ED2["vendor"][1][0] = "mp_hub_general_overlook_idle";
  level._id_4012._id_0ED2["vendor"][1][1] = "mp_hub_general_overlook_twitch_a";
  level._id_4012._id_0ED2["vendor"][1][2] = "mp_hub_general_overlook_twitch_b";
  level._id_4012._id_0ED2["vendor"][1][3] = "mp_hub_general_overlook_twitch_c";
  level._id_4012._id_0ED2["vendor"][1][4] = "mp_hub_general_overlook2idle";
  level._id_4012._id_0ED2["vendorStage"]["react_pos"] = "mp_hub_general_salute";
  level._id_4012._id_0ED2["aide1"][0][0] = "mp_hub_general_aide_01_idle";
  level._id_4012._id_0ED2["aide1"][1][0] = "mp_hub_general_aide_01_idle";
  level._id_4012._id_0ED2["aide2"][0][0] = "mp_hub_general_aide_02_idle";
  level._id_4012._id_0ED2["aide2"][1][0] = "mp_hub_general_aide_02_idle";
  level._id_4012._id_A40D = "usa_prestige_org1";
  level._id_4012._id_9FEB = "ui_show_general_hud";
  level._id_4012._id_6113 = "general_menu";
  level._id_4012._id_1739 = "hub_allies_bg_general";

  if(1)
    level._id_4012 setModel("tag_origin");
  else {
    level._id_4012._id_267E = [510, 507, 0, 0, 0, 0];
    level._id_4012 _meth_84C7(level._id_4012._id_267E);
    var_0 = spawn("script_model", (0, 0, 0));
    var_0 setModel("eng_raidstick_org1");
    var_0 _meth_8055(level._id_4012, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
    level._id_4012 thread _id_71F3();
  }

  level._id_4012._id_50DA = 0;
  level._id_4012._id_56A9 = 1;
  level._id_4F51[level._id_4F51.size] = level._id_4012;
}

_id_8A20(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _func_18E(var_0, "targetname");

  if(!isDefined(var_5)) {
    return;
  }
  if(isDefined(var_4))
    var_5.origin = var_5.origin + var_4;

  var_5._id_5A7E = "spv_hub_" + var_0 + "_kswitch";
  setdvarifuninitialized(var_5._id_5A7E, 1);
  var_5._id_6113 = var_1;

  if(isDefined(var_2))
    var_5._id_3F02 = var_2;
  else
    var_5._id_3F02 = ::_id_4AC7;

  if(isDefined(var_3))
    var_5._id_308D = var_3;

  var_5._id_50DA = 1;
  var_5._id_56A9 = 1;
  level._id_4F51[level._id_4F51.size] = var_5;
}

_id_8A02() {
  level._id_6B22 = _func_18E("1v1_npc", "targetname");

  if(!isDefined(level._id_6B22)) {
    return;
  }
  level._id_6B22._id_5A7E = "spv_hub_1v1_kswitch";
  level._id_4F51[level._id_4F51.size] = level._id_6B22;
  level._id_6B22._id_9FEB = "ui_show_onevone_officer_hud";
  level._id_6B22._id_6113 = "onevone_officer_menu";
  level._id_6B22._id_1739 = "hub_allies_bg_1v1";
  level._id_6B22._id_50DA = 1;
  level._id_6B22._id_56A9 = 1;
}

_id_8A49() {
  level._id_9957 = _func_18E("theater_icon", "targetname");
  level._id_9957._id_6113 = "theater_menu";
  level._id_9957._id_5A7E = "spv_hub_theater_kswitch";
  level._id_9957._id_50DA = 1;
  level._id_4F51[level._id_4F51.size] = level._id_9957;
}

_id_6B88(var_0, var_1, var_2) {
  level endon("game_ended");

  if(!isDefined(var_2))
    var_2 = 1;

  if(common_scripts\utility::_id_562E(level._id_A259)) {
    var_1 _id_04E0::_id_50F0(["hubFeatureStats", "hubVendors", "quartermasterVisits"], 1, undefined, undefined);
    var_1 _id_04E0::_id_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Quartermaster"], _func_03E());
    var_1 _meth_82FF("ui_vendor_set_up_ready", 1);
    return;
  }

  if(!isDefined(level._id_781C) || var_2 && (self != level._id_781C && self != level.maleqmnpc)) {
    return;
  }
  if(level._id_4F50 && isDefined(var_1._id_9FB4) && var_1._id_9FB4 < 4) {
    return;
  }
  var_3 = var_1 _id_7478(level._id_781C, -6);
  var_1 _meth_8626("mp_hub_vendor_mix");

  if(isDefined(var_3) && var_3) {
    var_1 thread _id_4AE6(level._id_781C);
    var_1 _id_04E0::_id_7DF8(0, 0, 0, !var_2, 0);
    var_1 _id_04E0::_id_50F0(["hubFeatureStats", "hubVendors", "quartermasterVisits"], 1, undefined, undefined);
    var_1 _id_04E0::_id_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Quartermaster"], _func_03E());
  }
}

_id_6B43(var_0, var_1, var_2) {
  level endon("game_ended");

  if(!isDefined(var_2))
    var_2 = 1;

  if(common_scripts\utility::_id_562E(level._id_A259)) {
    var_1 _id_04E0::_id_50F0(["hubFeatureStats", "hubVendors", "requisitionsVisits"], 1, undefined, undefined);
    var_1 _id_04E0::_id_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Requisitions"], _func_03E());
    var_1 _meth_82FF("ui_vendor_set_up_ready", 1);
    return;
  }

  if(!isDefined(level._id_4BF3) || var_2 && self != level._id_4BF3) {
    return;
  }
  var_3 = var_1 _id_7478(level._id_4BF3);
  var_1 _meth_8626("mp_hub_vendor_mix");

  if(isDefined(var_3) && var_3) {
    var_1 _id_04E0::_id_7DF8(0, 0, 0, 0, 0);

    if(isDefined(level._id_7B46)) {
      thread _id_04DF::_id_2D4A();
      var_1 _meth_866C(&"remove_persistent_indicator", 1, 1);
      var_1 _meth_866C(&"remove_persistent_indicator", 1, 2);
      var_1 _meth_866C(&"add_persistent_indicator", 2, 2, "HUB_ONB_ORDERS");
    }

    var_1 thread _id_4AC9(level._id_4BF3);
    var_1 _id_04E0::_id_50F0(["hubFeatureStats", "hubVendors", "requisitionsVisits"], 1, undefined, undefined);
    var_1 _id_04E0::_id_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Requisitions"], _func_03E());
  }
}

_id_6AC1(var_0, var_1, var_2) {
  level endon("game_ended");

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(level._id_1783) || var_2 && self != level._id_1783) {
    return;
  }
  var_3 = var_1 _id_7478(level._id_1783, -7);
  var_1 _meth_8626("mp_hub_vendor_mix");

  if(isDefined(var_3) && var_3) {
    var_1 thread _id_4AA9(level._id_1783);
    var_1 _id_04E0::_id_7DF8(0, 0, 0, 0, 0);
    var_1 _id_04E0::_id_50F0(["hubFeatureStats", "hubVendors", "gunsmithVisits"], 1, undefined, undefined);
    var_1 _id_04E0::_id_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Gunsmith"], _func_03E());
  }
}

_id_6B55(var_0, var_1) {
  level endon("game_ended");

  if(common_scripts\utility::_id_562E(level._id_A259)) {
    var_1 _id_04E0::_id_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Mail"], _func_03E());

    if(!maps\mp\gametypes\_hud_util::_id_5527())
      var_1 _meth_82FF("ui_vendor_set_up_ready", 1);

    return;
  }

  if(!isDefined(level._id_5F83) || self != level._id_5F83) {
    return;
  }
  if(level._id_4F50 && isDefined(var_1._id_9FB4) && var_1._id_9FB4 < 4) {
    return;
  }
  var_2 = var_1 _id_7478(level._id_5F83);
  var_1 _id_04E0::_id_7DF8(0, 0, 0, 0, 0);
  var_1 _meth_8626("mp_hub_vendor_mix");

  if(isDefined(var_2) && var_2) {
    var_1 thread _id_4AD3(level._id_5F83);
    var_1 _id_04E0::_id_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Mail"], _func_03E());
  }
}

_id_6BB5(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(level._id_9957) || self != level._id_9957) {
    return;
  }
  var_1 _meth_8626("hub_theater");
  var_1._id_5733 = 1;
  var_1 _id_04E0::_id_870B(1);
  var_1 _meth_82FF("ui_vendor_set_up_ready", 1);
  var_1 _id_04E0::_id_7DF8(0, 0, 0, 0, 0);
  var_1 _id_0468::_id_0A2A("theater");
  var_1 thread _id_4AFD(level._id_9957);
}

ontheateropenvlonly(var_0, var_1) {
  level endon("game_ended");
  var_1 _meth_8626("hub_theater");
  var_1 _id_0468::_id_0A2A("theater");
  var_1 thread handletheatervlonly(level._id_9957);
}

_id_6B8F(var_0, var_1) {
  level endon("game_ended");
  var_1._id_5733 = 1;
  var_1 _id_04E0::_id_870B(1);
  var_1 _meth_82FF("ui_vendor_set_up_ready", 1);
  var_1 _id_04E0::_id_7DF8(0, 0, 0, 0, 0);
  var_1 _meth_8626("duck_background_sfx");
  var_1 thread _id_4AE9(var_1);
}

onleaderboardinteract(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return;
  }
  if(var_0 == "ranked_playlist_menu" && var_1 == 99) {
    var_2 iprintln(&"HUB_WARNING_SPLITSCREEN");
    return;
  }

  if(!isDefined(var_2.timeoflastlfglitemsg) || gettime() - var_2.timeoflastlfglitemsg > 30000)
    var_2.timeoflastlfglitemsg = gettime();
  else {
    var_2 iprintln(&"HUB_LFG_LITE_WAIT");
    return;
  }

  var_3 = undefined;

  switch (var_0) {
    case "tdm_playlist_menu":
      var_3 = &"HUB_LFG_TDM";
      break;
    case "dom_playlist_menu":
      var_3 = &"HUB_LFG_DOM";
      break;
    case "war_playlist_menu":
      var_3 = &"HUB_LFG_WAR";
      break;
    case "ranked_playlist_menu":
      var_3 = &"HUB_LFG_RANKED";
      break;
    default:
      break;
  }

  if(isDefined(var_3))
    _func_18B(var_3, var_2.name);
}

_id_6BCC(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = undefined;

  foreach(var_5 in level._id_4F51) {
    if(isDefined(var_5._id_6113) && var_5._id_6113 == var_2)
      var_3 = var_5;
  }

  if(!isDefined(var_3)) {
    return;
  }
  var_7 = var_1 _id_7478(var_3);
  var_1 _meth_8626("mp_hub_vendor_mix");

  if(isDefined(var_7) && var_7) {
    if(isDefined(var_3._id_3F02))
      var_1 thread[[var_3._id_3F02]](var_3);
    else
      var_1 thread _id_4AC7(var_3);
  }
}

_id_6BD6(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(level._id_AC32) || self != level._id_AC32) {
    return;
  }
  var_2 = var_1 _id_7478(level._id_AC32);
  var_1 _meth_8626("mp_hub_vendor_mix");

  if(isDefined(var_2) && var_2) {
    var_1 thread _id_4B09(level._id_AC32);
    var_1 _id_04E0::_id_50F0(["hubFeatureStats", "hubVendors", "zombiesVisits"], 1, undefined, undefined);
    var_1 _id_04E0::_id_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Zombies"], _func_03E());
  }
}

_id_6B40(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(level._id_4012) || self != level._id_4012) {
    return;
  }
  var_2 = var_1 _id_7478(level._id_4012);
  var_1 _meth_8626("mp_hub_vendor_mix");

  if(isDefined(var_2) && var_2) {
    var_1 _id_04E0::_id_7DF8(0, 0, 0, 0, 0);
    var_1 thread _id_4AC6(level._id_4012);
    var_1 _id_04E0::_id_50F0(["hubFeatureStats", "hubVendors", "prestigeVisits"], 1, undefined, undefined);
  }
}

_id_6B5F(var_0, var_1) {
  level endon("game_ended");
  var_1 _meth_82FF(level._id_6B22._id_9FEB, level._id_4F38._id_787F.size);
  var_2 = var_1 _id_7478(level._id_6B22);

  if(isDefined(var_2) && var_2)
    var_1 thread _id_4AA7(level._id_6B22);
}

_id_639F() {
  level endon("game_ended");
  self endon("disconnect");
  _id_27CC();

  if(!isDefined(self._id_A40B) || self._id_A40B.size == 0) {
    return;
  }
  if(!isDefined(self._id_5721))
    self._id_5721 = 0;

  _id_8C01(self._id_A40B);
  self._id_4D4E = 0;
}

_id_639B() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("highlight");

    if(_id_04E0::_id_5790()) {
      continue;
    }
    while(self _meth_8343()) {
      level._id_781C _meth_8427(self, 5, 0);
      level._id_4BF3 _meth_8427(self, 5, 0);
      level._id_1783 _meth_8427(self, 5, 0);
      level._id_79AC _meth_8427(self, 5, 0);
      level._id_5F83 _meth_8427(self, 5, 0);
      level._id_AC32 _meth_8427(self, 5, 0);
      level._id_4012 _meth_8427(self, 5, 0);
      level._id_2540 _meth_8427(self, 5, 0);
      level._id_6B22 _meth_8427(self, 5, 0);
      level._id_80BA _meth_8427(self, 5, 0);
      self._id_4D4E = 1;
      _id_3E26(self._id_A40B);
      wait 1;
    }

    level._id_781C _meth_8428(self);
    level._id_4BF3 _meth_8428(self);
    level._id_1783 _meth_8428(self);
    level._id_79AC _meth_8428(self);
    level._id_5F83 _meth_8428(self);
    level._id_AC32 _meth_8428(self);
    level._id_4012 _meth_8428(self);
    level._id_2540 _meth_8428(self);
    level._id_6B22 _meth_8428(self);
    level._id_80BA _meth_8428(self);
    _id_7DF6(self._id_A40B);
    self._id_4D4E = 0;
  }
}

_id_4AE6(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      _id_04E0::_id_5E88("quartermaster_visit", "hq_npc_visit_ended", self._id_99EA, []);
      self notify("playerLeftQuartermaster");

      if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
        return;
      }
      _id_741D(var_0);
      self _meth_8627("mp_hub_vendor_mix");
      waitframe();
      _id_04E0::_id_A04C();
      break;
    }

    switch (var_2) {
      case 0:
        thread _id_04E0::_id_3010("cantAfford", &"HUB_CANT_AFFORD", undefined, -100, 2, 3);

        if(isDefined(self._id_A405))
          self._id_A405 notify("react_neg");

        break;
      case 1:
        if(isDefined(self._id_A405)) {
          self._id_A405 notify("react_pos");
          waitframe();
        }

        break;
      case 2:
        if(isDefined(self._id_A405)) {
          break;
        }
      case 3:
        break;
      default:
        break;
    }
  }
}

_id_4AC9(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      self notify("playerLeftRequisitions");
      _id_04E0::_id_5E88("operations_visit", "hq_npc_visit_ended", self._id_99EA, []);

      if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
        return;
      }
      _id_741D(var_0);
      self _meth_8627("mp_hub_vendor_mix");
      waitframe();
      _id_04E0::_id_A04C();
      break;
    }
  }
}

_id_4AA9(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection" && var_1 != "hub_weapon_prestiged" && var_1 != "hub_weapon_crafted") {
      continue;
    }
    if(var_1 == "hub_character_selection") {
      if(var_2 == -1) {
        _id_04E0::_id_5E88("gunsmith_visit", "hq_npc_visit_ended", self._id_99EA, []);

        if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
          return;
        }
        _id_741D(var_0);
        self _meth_8627("mp_hub_vendor_mix");
        waitframe();
        _id_04E0::_id_A04C();
        return;
      }

      switch (var_2) {
        case 1:
          if(isDefined(self._id_A405))
            thread _id_7200(self._id_A405, "deny", "idle");

          break;
        case 0:
          if(isDefined(self._id_A405))
            thread _id_7200(self._id_A405, "deny", "idle");

          break;
        case 2:
          if(isDefined(self._id_A405))
            thread _id_7200(self._id_A405, "confirm", "idle");

          break;
        case 3:
          if(isDefined(self._id_A405))
            thread _id_7200(self._id_A405, "deny", "idle");

          self iprintln("Can't afford armory drop. 100 armory credits required");
          break;
        case 10:
          if(isDefined(self._id_A405))
            self._id_A405 _meth_805C();

          break;
        case 11:
          if(isDefined(self._id_A405))
            self._id_A405 _meth_8005(self);

          break;
      }

      continue;
    }

    if(var_1 == "hub_weapon_prestiged") {
      var_3 = var_2;
      var_4 = common_scripts\utility::_id_9462(var_3, "_mp");
      var_5 = getsubstr(var_3, 0, var_4);
      self._id_5791 = 1;
      var_6 = self getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", _func_05F(var_3), "prestigeLevel") + 1;
      var_7 = _func_1B1("mp/statstable.csv", 2, var_3);
      thread maps\mp\gametypes\_hud_message::_id_A9DD("weapon_prestige", var_7, var_6);

      foreach(var_9 in level.players) {
        switch (var_6) {
          case 1:
            var_10 = var_6 + "st";
            break;
          case 2:
            var_10 = var_6 + "nd";
            break;
          case 3:
            var_10 = var_6 + "rd";
            break;
          default:
            var_10 = var_6 + "th";
            break;
        }

        var_9 iprintln(&"HUB_WEAPON_PRESTIGE_CHAT", self.name, var_5, var_10);
      }

      self._id_5791 = 0;
      continue;
    }

    if(var_1 == "hub_weapon_crafted") {
      var_3 = var_2;
      var_4 = common_scripts\utility::_id_9462(var_3, "_mp");
      var_5 = getsubstr(var_3, 0, var_4);
      self._id_5791 = 1;
      var_7 = _func_1B1("mp/statstable.csv", 2, var_3);
      thread maps\mp\gametypes\_hud_message::_id_A9DD("weapon_forge", var_7);
      self._id_5791 = 0;
    }
  }
}

_id_4AD3(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      self notify("playerLeftPayroll");
      _id_04E0::_id_5E88("mail_visit", "hq_npc_visit_ended", self._id_99EA, []);

      if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
        return;
      }
      _id_741D(var_0);
      self _meth_8627("mp_hub_vendor_mix");
      _id_04E0::_id_A04C();
      break;
    }

    switch (var_2) {
      case 1:
        break;
      case 2:
        break;
      default:
        break;
    }
  }
}

_id_4AFD(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      self notify("playerLeftTheater");

      if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
        return;
      }
      self _meth_8627("hub_theater");
      self _meth_82FF("ui_vendor_set_up_ready", 0);
      self._id_5733 = 0;
      _id_04E0::_id_870B(0);
      _id_04E0::_id_A04C();
      break;
    }

    switch (var_2) {
      default:
        break;
    }
  }
}

handletheatervlonly(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      self _meth_8627("hub_theater");
      break;
    }

    switch (var_2) {
      default:
        break;
    }
  }
}

_id_4AE9(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      self notify("playerLeftRandR");

      if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
        return;
      }
      self _meth_8627("duck_background_sfx");
      self _meth_82FF("ui_vendor_set_up_ready", 0);
      self._id_5733 = 0;
      _id_04E0::_id_870B(0);
      _id_04E0::_id_A04C();
      break;
    }

    switch (var_2) {
      case 1:
        break;
      default:
        break;
    }
  }
}

_id_4AC7(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      if(isDefined(var_0._id_308D))
        _id_04E0::_id_5E88(var_0._id_308D, "hq_npc_visit_ended", self._id_99EA, []);

      if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
        return;
      }
      _id_741D(var_0);
      self _meth_8627("mp_hub_vendor_mix");
      break;
    }

    switch (var_2) {
      case 1:
        break;
      default:
        break;
    }
  }
}

_id_4B09(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      _id_741D(var_0);

      if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
        return;
      }
      self _meth_8627("mp_hub_vendor_mix");
      _id_04E0::_id_5E88("zm_npc_visit", "hq_npc_visit_ended", self._id_99EA, []);
      break;
    }

    switch (var_2) {
      case 1:
        break;
      default:
        break;
    }

    if(isDefined(self._id_A405))
      self._id_A405 _meth_8276(level._id_AC32._id_0ED2["interact"]);
  }
}

_id_4AC6(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("clear_any_prestige_threads");
  thread monitorprestigestatsreset();

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      if(self._id_5733) {
        _id_04E0::_id_5E88("prestige_visit", "hq_npc_visit_ended", self._id_99EA, []);

        if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
          return;
        }
        _id_741D(var_0);
        _id_04E0::_id_A04C();
      }

      break;
    }

    switch (var_2) {
      case 77:
        var_3 = self.pers["prestige"];

        foreach(var_5 in level.players) {
          if(var_5 == self) {
            var_5 iprintln(&"HUB_PRESTIGE_CHAT_YOU", &"HUB_YOU", var_3);
            continue;
          }

          if(isDefined(var_5))
            var_5 iprintln(&"HUB_PRESTIGE_CHAT", self.name, var_3);
        }

        thread _id_76B1(var_3);
        _id_0468::_id_0A2A("general", var_3);
        _id_741D(var_0);
        _id_04E0::_id_5E88("prestige_visit", "hq_npc_visit_ended", self._id_99EA, []);
        break;
      default:
        break;
    }
  }
}

monitorprestigestatsreset() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("clear_any_prestige_threads");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "prestige_stats_reset") {
      continue;
    }
    if(var_1 == 1) {
      var_2 = self.pers["prestige"] + 1;
      self setplayerdata(common_scripts\utility::_id_46AE(), "experience", 0);
      self setplayerdata(common_scripts\utility::_id_46AE(), "prestige", var_2);
      self.pers["rankxp"] = 0;
      self.pers["rank"] = 0;
      self.pers["prestige"] = var_2;
      self setrank(0, var_2);
      self notify("clear_any_prestige_threads");
      return;
    }
  }
}

_id_4AF4(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "hub_character_selection") {
      if(var_2 == -1) {
        if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
          return;
        }
        _id_741D(var_0);
        self _meth_82FF(level._id_8ED7._id_9FEB, 0);
        break;
      }

      switch (var_2) {
        case 1:
          break;
        default:
          break;
      }
    }
  }
}

_id_4AB0(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
        return;
      }
      _id_741D(var_0);
      self _meth_8627("mp_hub_vendor_mix");
      _id_04E0::_id_A04C();
      break;
    }

    switch (var_2) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      default:
        break;
    }

    if(isDefined(self._id_A405))
      self._id_A405 _meth_8276(level._id_4012._id_0ED2["interact"]);
  }
}

_id_4AF2(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "hub_character_selection") {
      if(var_2 == -1) {
        if(isDefined(self._id_56AD) && self._id_56AD || isDefined(self._id_572A) && self._id_572A) {
          return;
        }
        _id_741D(var_0);
        self _meth_82FF(level._id_80BA._id_9FEB, 0);
        break;
      }

      switch (var_2) {
        case 1:
          break;
        default:
          break;
      }

      if(isDefined(self._id_A405))
        self._id_A405 _meth_8276(level._id_80BA._id_0ED2["interact"]);

      continue;
    }

    if(var_1 == "hub_force_vlobby_execute") {
      switch (var_2) {
        case 0:
          _id_741D(var_0);
          self _meth_82FF(level._id_80BA._id_9FEB, 0);
          return;
        default:
          break;
      }
    }
  }
}

_id_4AA7(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      _id_741D(var_0);
      break;
    }

    switch (var_2) {
      case 3:
        _id_741D(var_0);
        thread _id_0482::_id_7CE0(self);
        return;
      case 1:
        _id_741D(var_0);
        thread _id_0482::_id_09FB(self);
        return;
      case 2:
        _id_741D(var_0);
        thread _id_0482::_id_7475();
        return;
      default:
        break;
    }

    if(isDefined(self._id_A405))
      self._id_A405 _meth_8276(level._id_6B22._id_0ED2["interact"]);
  }
}

_id_4AE3() {
  level endon("game_ended");
  self _meth_82A1(1);
}

_id_7473(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("disconnect");

  if(!self._id_53DB) {
    self _meth_81E2(level._id_A409, "tag_player");
    self freezecontrols(1);
    var_1 = spawn("script_model", level._id_A40F.origin + (30, 0, 0));
    var_1 setModel("usa_raid_org1");

    if(!isDefined(var_0._id_267E))
      var_1 _meth_84C7([1, 1, 1, 1, 1, 1]);
    else
      var_1 _meth_84C7(var_0._id_267E);

    var_1.angles = level._id_A409.angles + (0, 180, 0);
    var_1 _meth_8276("mp_hub_foldarms_idle_p");
    var_1 _meth_805C();
    var_1 _meth_8005(self);
    self._id_53DA = var_1;
    self._id_53DB = 1;
  }
}

_id_741C() {
  if(!isDefined(self)) {
    return;
  }
  if(self._id_53DB) {
    self _meth_81E3();
    self freezecontrols(0);
    self._id_53DA delete();
    self._id_53DB = 0;
  }
}

_id_7478(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 = 0;
  var_3 = undefined;

  if(!isDefined(var_0._id_56A9)) {
    if(!isDefined(self._id_A410))
      self._id_A410 = [];

    if(!isDefined(common_scripts\utility::_id_0F7E(self._id_A410, var_0))) {
      self._id_A410[self._id_A410.size] = var_0;
      var_2 = 1;
    }
  }

  if(!isDefined(var_0._id_56A9)) {
    if(!isDefined(var_1))
      var_3 = spawn("script_model", level._id_A40F.origin);
    else
      var_3 = spawn("script_model", level._id_A40F.origin + (var_1, 5, 0));

    self _meth_81E2(level._id_A409, "tag_player");
    self setclientdvar("cg_fov", 47);
  }

  if(!isDefined(var_0._id_56A9)) {
    if(isDefined(var_0._id_267E))
      var_3 _meth_84C7(var_0._id_267E, "allies");

    var_3.angles = level._id_A40F.angles - (0, 5, 0);

    if(isDefined(var_0._id_0ED2) && !var_0._id_50DA) {
      var_3._id_0ED2 = var_0._id_0ED2;

      if(isDefined(var_3._id_0ED2["enterMenu"]) && var_0 != level._id_781C)
        thread _id_7200(var_3, "enterMenu", "idle");
      else if(var_0 == level._id_781C) {
        var_3._id_914E = var_0._id_914E;
        var_4 = var_3 thread _id_8A47(self);
        var_3 thread _id_4B03(var_2, var_4, self);
      }
    }
  }

  if(isDefined(var_0._id_1739) && !isDefined(var_0._id_56A9)) {
    self._id_A407 = spawn("script_model", level._id_A408.origin);
    self._id_A407 setModel(var_0._id_1739);
    self._id_A407.angles = level._id_A408.angles;
    self._id_A407 _meth_805C();
    self._id_A407 _meth_8005(self);
  }

  if(!isDefined(var_0._id_56A9)) {
    if(isDefined(var_0._id_A5CE))
      var_3._id_A5CE = var_0._id_A5CE;

    var_3._id_9FEB = var_0._id_9FEB;
    var_3 _meth_805C();
    var_3 _meth_8005(self);
    self._id_A405 = var_3;
  } else
    self._id_5CC4 = var_0;

  self _meth_82FF("ui_vendor_set_up_ready", 1);
  self._id_A40C = gettime();
  self._id_5733 = 1;
  _id_04E0::_id_870B(1);
  return 1;
}

_id_741D(var_0) {
  self _meth_8627("mp_hub_vendor_mix");

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_56A9)) {
    if(isDefined(level._id_4F4A))
      self setclientdvar("cg_fov", level._id_4F4A);

    if(isDefined(self._id_A407)) {
      self._id_A407 delete();
      self._id_A407 = undefined;
    }

    if(isDefined(self._id_A405)) {
      self._id_A405 notify("vendorChangeAnimState");
      self._id_A405 notify("vendorDeleted");
      self._id_A405 delete();
      self._id_A405 = undefined;
    }

    self _meth_81E3();
  }

  if(isDefined(self._id_A40C))
    self._id_99EA = int((gettime() - self._id_A40C) / 1000);

  self._id_A40C = undefined;
  self _meth_82FF("ui_vendor_set_up_ready", 0);
  self._id_5733 = 0;
  self._id_5CC4 = undefined;

  if(!isDefined(self._id_56AD) || self._id_56AD == 0)
    _id_04E0::_id_870B(0);
}

_id_09A5(var_0) {
  if(!isDefined(self)) {
    return;
  }
  maps\mp\gametypes\_hud_util::_id_209E(var_0, 0);
  maps\mp\gametypes\_hud_util::_id_209F(var_0, 2);
}

_id_9EBF(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(var_0 == "ch_daily_0")
    thread _id_04E0::_id_3010("10K", &"HUB_10K_CHALLENGE", undefined, -100, 1, 3);

  if(var_0 == "ch_daily_1")
    thread _id_04E0::_id_3010("3HS", &"HUB_3HS_CHALLENGE", undefined, -70, 1, 3);
}

_id_7D56(var_0) {
  if(!isDefined(self)) {
    return;
  }
  maps\mp\gametypes\_hud_util::_id_209E(var_0, 0);
  maps\mp\gametypes\_hud_util::_id_209F(var_0, 1);
}

_id_71F4(var_0, var_1, var_2) {}

_id_74E8(var_0) {}

_id_74AC(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("vendorChangeAnimState");

  if(var_1) {
    for(;;) {
      if(_func_279(var_0)) {
        break;
      }

      var_0 _meth_8276(var_0._id_0ED2["idle"], "animEnded");
      var_0 waittillmatch("animEnded");

      if(_func_279(var_0)) {
        break;
      }

      var_2 = common_scripts\utility::random(var_0._id_0ED2["allTwitch"]);
      var_0 _meth_8276(var_2, "animEnded");
      var_0 waittillmatch("animEnded");
    }
  } else {
    for(;;) {
      if(_func_279(var_0)) {
        break;
      }

      var_0 _meth_8276(var_0._id_0ED2["idle"], "animEnded");
      var_0 waittillmatch("animEnded");
    }
  }
}

_id_7200(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(!isDefined(var_0._id_931A) || var_0._id_931A != var_1) {
    if(!isDefined(var_0._id_0ED2[var_1])) {
      return;
    }
    var_0 notify("vendorChangeAnimState");

    if(var_1 == "idle" && isDefined(var_0._id_0ED2["idleTwitch"])) {
      if(!isDefined(var_3))
        var_3 = 0;

      thread _id_74AC(var_0, var_3);
    } else
      var_0 _meth_8276(var_0._id_0ED2[var_1], "animEnded");

    var_0._id_931A = var_1;

    if(isDefined(var_2)) {
      var_0 waittillmatch("animEnded");

      if(!_func_279(var_0))
        _id_7200(var_0, var_2);
    }
  }

  return;
}

_id_71F3() {
  level endon("game_ended");
  self endon("fake_prestige");

  if(!isDefined(self._id_831A)) {
    return;
  }
  for(;;) {
    for(var_0 = 0; var_0 < self._id_0ED2["vendor"].size; var_0++) {
      for(var_1 = 1; var_1 < self._id_0ED2["vendor"][var_0].size; var_1++) {
        for(var_2 = 0; var_2 < 2; var_2++) {
          self _meth_8495(self._id_0ED2["vendor"][var_0][0], self._id_831A.origin, self._id_831A.angles, "animEnded");

          foreach(var_4 in self._id_6DFB) {
            if(!isDefined(var_4) || !isDefined(self._id_0ED2[var_4.name])) {
              continue;
            }
            if(!isDefined(self._id_0ED2[var_4.name][var_0]) || !isDefined(self._id_0ED2[var_4.name][var_0][0])) {
              continue;
            }
            if(isDefined(var_4._id_5717) && !var_4._id_5717) {
              var_4._id_5717 = 1;
              var_4 _meth_8495(self._id_0ED2[var_4.name][var_0][0], self._id_831A.origin, self._id_831A.angles);
              continue;
            }

            var_4 _meth_8495(self._id_0ED2[var_4.name][var_0][0], self._id_831A.origin, self._id_831A.angles);
          }

          self waittillmatch("animEnded", "end");
        }

        self _meth_8495(self._id_0ED2["vendor"][var_0][var_1], self._id_831A.origin, self._id_831A.angles, "animEnded");

        foreach(var_4 in self._id_6DFB) {
          if(!isDefined(var_4)) {
            continue;
          }
          if(!isDefined(self._id_0ED2[var_4.name][var_0]) || !isDefined(self._id_0ED2[var_4.name][var_0][var_1])) {
            continue;
          }
          if(isDefined(var_4._id_5717))
            var_4._id_5717 = 0;

          var_4 _meth_8495(self._id_0ED2[var_4.name][var_0][var_1], self._id_831A.origin, self._id_831A.angles);
        }

        if(isDefined(self._id_0EAC[self._id_0ED2["vendor"][var_0][var_1]]))
          [[self._id_0EAC[self._id_0ED2["vendor"][var_0][var_1]]._id_3F02]](self._id_0EAC[self._id_0ED2["vendor"][var_0][var_1]]._id_0F5D);

        self waittillmatch("animEnded", "end");
      }
    }
  }
}

_id_4AE5() {
  level endon("game_ended");

  if(!isDefined(self._id_831A)) {
    return;
  }
  for(;;) {
    self waittill("startCrateUnloadEvent");
    var_0 = spawn("script_model", (0, 0, 0));
    var_0 setModel("hub_lootcrate_b");
    var_0 _meth_8495(self._id_2760[1][0], self._id_831A.origin, self._id_831A.angles);

    for(var_1 = 2; var_1 < self._id_2761.size; var_1++) {
      var_2 = spawn("script_model", (0, 0, 0));

      if(self._id_2761[var_1] == "ambient_costume")
        var_2 _id_04E0::_id_8627();
      else
        var_2 setModel(self._id_2761[var_1]);

      var_2 _meth_8495(self._id_2760[var_1], self._id_831A.origin, self._id_831A.angles, "animEnded");
      var_2 thread _id_04E0::_id_2DD4("animEnded");

      if(self._id_2761[var_1] == "vehicle_usa_trans_cckw_base_hub")
        var_2 _id_0378::_id_8D74("truck_unload");
    }

    self waittill("startCrateLoadEvent");
    var_0 _meth_8495(self._id_2749[4], self._id_831A.origin, self._id_831A.angles);

    for(var_1 = 1; var_1 < self._id_274A.size; var_1++) {
      var_2 = spawn("script_model", (0, 0, 0));

      if(self._id_274A[var_1] == "ambient_costume")
        var_2 _id_04E0::_id_8627();
      else
        var_2 setModel(self._id_274A[var_1]);

      var_2 _meth_8495(self._id_2749[var_1], self._id_831A.origin, self._id_831A.angles, "animEnded");
      var_2 thread _id_04E0::_id_2DD4("animEnded");

      if(self._id_274A[var_1] == "vehicle_usa_trans_cckw_base_hub")
        var_2 _id_0378::_id_8D74("truck_load");
    }
  }
}

_id_4AB4(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(self._id_831A)) {
    return;
  }
  for(;;) {
    var_0 _meth_8495(self._id_0ED2["crateStealer"][0][0], self._id_831A.origin, self._id_831A.angles);
    var_1 _meth_8495(self._id_0ED2["crateToSteal"][0][0], self._id_831A.origin, self._id_831A.angles);
    var_0 waittill("startCrateStealEvent");
    var_0 _meth_8495(self._id_0ED2["crateStealer"][0][1], self._id_831A.origin, self._id_831A.angles);
    var_1 _meth_8495(self._id_0ED2["crateToSteal"][0][1], self._id_831A.origin, self._id_831A.angles);
    self waittillmatch("animEnded", "end");
  }
}

_id_771D(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(level.players) && isDefined(level.players[0]) && level.players[0].name == "SHG-ABurt")
    level.players[0] iprintln(var_0 + " playing: " + var_1);
}

_id_4B03(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death");

  if(var_0)
    var_3 = "first_greeting";
  else if(var_2._id_7A65 < 12)
    var_3 = "common_greeting";
  else
    var_3 = "prestige_greeting";

  thread _id_04E0::_id_8636(45, "react_afk", ["react_neg", "react_pos"]);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(self._id_0ED2["vendorStage"][var_3])) {
      break;
    }

    if(_func_0C0(self._id_0ED2["vendorStage"][var_3])) {
      var_4 = randomint(self._id_0ED2["vendorStage"][var_3].size);
      self _meth_8495(self._id_0ED2["vendorStage"][var_3][var_4], self.origin, (0, 210, 0), "idle");

      foreach(var_6 in var_1) {
        if(!isDefined(var_6) || !isDefined(self._id_0ED2[var_6.name + "Stage"][var_3][var_4])) {
          continue;
        }
        var_6 _meth_8276(self._id_0ED2[var_6.name + "Stage"][var_3][var_4]);
      }
    } else {
      self _meth_8495(self._id_0ED2["vendorStage"][var_3], self.origin, (0, 210, 0), "idle");

      foreach(var_6 in var_1) {
        if(!isDefined(var_6) || !isDefined(self._id_0ED2[var_6.name + "Stage"][var_3])) {
          continue;
        }
        var_6 _meth_8276(self._id_0ED2[var_6.name + "Stage"][var_3]);
      }
    }

    var_3 = common_scripts\utility::_id_A715("idle", "react_neg", "react_pos", "react_afk");

    if(var_3 != "idle")
      thread _id_04E0::_id_8636(45, "react_afk", ["react_neg", "react_pos"]);
  }
}

_id_8A47(var_0) {
  level endon("game_ended");
  var_1 = [];

  if(!isDefined(self._id_914E))
    return var_1;

  foreach(var_3 in self._id_914E) {
    var_4 = spawn("script_model", (0, 0, 0));
    var_4 setModel(var_3.model);

    if(!var_1.size)
      var_4 _meth_8055(self, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    else
      var_4 _meth_8055(self, "tag_weapon_left", (0, 0, 0), (0, 0, 0));

    var_4.name = var_3.name;
    var_4 _meth_805C();
    var_4 _meth_8005(var_0);
    var_1[var_1.size] = var_4;
  }

  thread _id_2D42(var_1);
  var_0 thread _id_2D41(var_1, self);
  return var_1;
}

_id_2D42(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");

  foreach(var_2 in var_0)
  var_2 delete();
}

_id_2D41(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  self waittill("disconnect");

  foreach(var_3 in var_0)
  var_3 delete();
}

_id_37C0(var_0) {
  if(isDefined(self._id_9FB4) && self._id_9FB4 < 4 && isDefined(var_0._id_A405) && var_0._id_A405 != level._id_4BF3 && var_0._id_A405 != level._id_781C)
    self._id_5734 = 0;
  else if(level._id_4F50 && var_0._id_A405 == level._id_781C)
    self._id_5734 = 0;
  else {
    self._id_5734 = 1;
    self._id_53FE = var_0._id_A405;
    self._id_53FF = var_0;
  }
}

_id_38F8(var_0) {
  self._id_5734 = 0;
  self._id_53FE = undefined;
  self._id_53FF = undefined;
}

_id_3E26(var_0) {
  foreach(var_2 in var_0) {
    var_2.alpha = 1;
    var_2 _meth_80CB(1, 1, 0, 0, 0, 0, 0, 0);
  }

  foreach(var_5 in self._id_A406) {
    var_5 _meth_80CB(1, 1, 0, 0, 0, 0, 0, 0);

    if(!isDefined(var_5._id_5798) || !var_5._id_5798) {
      var_5.alpha = 1;
      var_5 thread _id_04E0::_id_77B4(0.5, 0.5, 1, 0.5, undefined, self, 1, 0);
    }
  }
}

_id_7DF6(var_0) {
  foreach(var_2 in var_0) {
    if(_id_A40A(var_2._id_A40E))
      var_2.alpha = 1;
    else
      var_2.alpha = 0;

    var_2 _meth_80CB(1, 1, 0, 0, 0, 0, 0, 1);
  }

  foreach(var_5 in self._id_A406) {
    var_5 _meth_80CB(1, 1, 0, 0, 0, 0, 0, 1);

    if(!isDefined(var_5._id_5798) || !var_5._id_5798) {
      var_5.alpha = 1;
      var_5 thread _id_04E0::_id_77B4(0.5, 0.5, 1, 0.5, undefined, self, 1, 0);
    }
  }
}

_id_8C01(var_0) {
  if(!isDefined(var_0) || var_0.size < 1) {
    return;
  }
  foreach(var_2 in var_0)
  var_2.alpha = 1;

  foreach(var_5 in self._id_A406) {
    if(!isDefined(var_5._id_5798) || !var_5._id_5798) {
      var_5.alpha = 1;
      var_5 thread _id_04E0::_id_77B4(0.5, 0.5, 1, 0.5, undefined, self, 1, 0);
    }
  }
}

_id_4D0C(var_0) {
  if(!isDefined(var_0) || var_0.size < 1) {
    return;
  }
  foreach(var_2 in var_0) {
    if(var_2.alpha > 0)
      var_2.alpha = 0;
  }

  foreach(var_5 in self._id_A406) {
    if(isDefined(var_5._id_5798) && var_5._id_5798) {
      var_5 notify("pulseDurationEnded");
      var_5._id_5798 = 0;
      var_5.alpha = 0;
    }
  }
}

_id_A40A(var_0) {
  foreach(var_2 in self._id_A406) {
    if(isDefined(var_2) && var_2._id_A40E == var_0)
      return 1;
  }

  return 0;
}

_id_8A5E(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.alpha = 0;
  self _meth_80CB(0, 1, 0, 0, 0, 0, 0, var_0);
}

_id_2839(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0) || !isDefined(var_0.origin)) {
    return;
  }
  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = _func_19B(self);
  var_6 setshader(var_1);
  var_6 _id_8A5E(var_4);

  if(var_5) {
    var_6.x = 0;
    var_6.y = 0;
    var_6._id_01D9 = 0 + var_3;
    var_6 _meth_80C0(var_0, "tag_origin");
  } else {
    var_6.x = var_0.origin[0];
    var_6.y = var_0.origin[1];
    var_6._id_01D9 = var_0.origin[2] + 90 + var_3;
  }

  var_6._id_A40E = var_0._id_9FEB;
  var_6._id_35B2 = "icon";
  var_6._id_6E74 = level._id_A012;
  var_6._id_6E74 maps\mp\gametypes\_hud_util::_id_09A6(var_6);
  var_6.name = var_1;
  self._id_A40B = common_scripts\utility::_id_0F6F(self._id_A40B, var_6);
  var_6.alpha = 1;

  if(isDefined(var_2) && var_2) {
    var_7 = _func_19B(self);
    var_7 setshader("ui_vendor_alert_icon");
    var_7 _id_8A5E();

    if(var_5) {
      var_7.x = 0;
      var_7.y = 0;
      var_7._id_01D9 = 0 + var_3;
      var_7 _meth_80C0(var_0, "tag_origin");
    } else {
      var_7.x = var_0.origin[0];
      var_7.y = var_0.origin[1];
      var_7._id_01D9 = var_0.origin[2] + 90 + var_3;
    }

    var_7.alpha = 1;
    var_7 thread _id_04E0::_id_77B4(0.5, 0.5, 1, 0.5, undefined, self, 1, 0);
    var_7._id_A40E = var_0._id_9FEB;
    var_7._id_35B2 = "icon";
    var_7._id_6E74 = level._id_A012;
    var_7._id_6E74 maps\mp\gametypes\_hud_util::_id_09A6(var_7);
    var_7.name = var_1 + "Alert";
    self._id_A406[self._id_A406.size] = var_7;
  }

  return var_6;
}

_id_27CC() {
  self._id_A40B = [];
  self._id_A406 = [];
}

_id_4B55() {
  var_0 = self getplayerdata(common_scripts\utility::_id_46AE(), "challengeState", "ch_daily_0");

  if(var_0 == 0)
    return 1;

  if(var_0 == 1)
    return 1;

  var_1 = self getplayerdata(common_scripts\utility::_id_46AE(), "challengeState", "ch_daily_1");

  if(var_1 == 0)
    return 1;

  if(var_1 == 1)
    return 1;

  return 0;
}

_id_5358() {
  level endon("game_ended");

  for(;;) {
    self _meth_83E5((360, 0, 0), 1);
    wait 1;
  }
}

_id_5359() {
  level endon("game_ended");

  for(;;) {
    self _meth_83E5((-360, 0, 0), 1);
    wait 1;
  }
}

_id_76B1(var_0) {
  self endon("disconnect");
  _id_04E0::_id_7DF8(0, 0, 1, 0, 1);
  _id_04E0::_id_721A("mp_emote_salute", 1);
  self _meth_8627("mp_hub_vendor_mix");
  var_1 = spawnStruct();
  var_1.origin = (0, 2700, -40);
  var_1.angles = (0, 0, 0);
  var_2 = spawn("script_model", var_1.origin);
  var_3 = undefined;
  var_4 = undefined;

  if(var_0 >= 5)
    var_3 = spawn("script_model", var_1.origin);

  if(var_0 == 10)
    var_4 = spawn("script_model", var_1.origin);

  var_5 = "usa_fighter_thunderbolt";

  switch (var_0) {
    case 1:
      var_5 = "usa_fighter_thunderbolt";
      break;
    case 10:
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
    case 2:
      var_5 = "usa_fighter_thunderbolt_fly_camo";
      break;
    default:
      var_5 = "usa_fighter_thunderbolt";
      break;
  }

  var_2 setModel(var_5);
  var_2 _meth_8495("mp_hub_prestige_flyby_01_plane_01", var_1.origin, var_1.angles);
  var_2 _id_0378::_id_8D74("prestige_fanfare_aircraft_flying");

  if(isDefined(var_3)) {
    var_3 setModel(var_5);
    var_3 _meth_8495("mp_hub_prestige_flyby_01_plane_02", var_1.origin, var_1.angles);
    var_3 _id_0378::_id_8D74("prestige_fanfare_aircraft_flying");
  }

  if(isDefined(var_4)) {
    var_4 setModel(var_5);
    var_4 _meth_8495("mp_hub_prestige_flyby_01_plane_03", var_1.origin, var_1.angles);
    var_4 _id_0378::_id_8D74("prestige_fanfare_aircraft_flying");
  }

  _func_213(100 + 10 * (var_0 - 1));
  _id_0378::_id_8D74("prestige_fireworks_start", var_0);
  _func_147(level._effect["prestige_flag_" + var_0], self, "tag_origin");
  _id_0378::_id_8D74("prestige_level_up_flag_start");
  waitframe();

  while(self _meth_85E1(0) == "mp_emote_salute")
    wait 0.1;

  _func_147(level._effect["prestige_icon_" + var_0], self, "tag_origin");
  _id_04E0::_id_A04C();
}

_id_1157(var_0) {
  if(!isDefined(self._id_76B2)) {
    self._id_76B2 = spawn("script_model", self.origin);
    self._id_76B2 setModel("usa_ctf_flag_physics_attach");
    self._id_76B2 linktosynchronizedparent(self, "J_spine4", (0, 0, 0), (0, 0, 0));
    self._id_76B2 _meth_805B();
    thread _id_2E41(self._id_76B2);
  }
}

_id_2E41(var_0) {
  level endon("game_ended");
  self waittill("disconnect");
  var_0 delete();
}

_id_7D60(var_0) {
  maps\mp\gametypes\_hud_util::_id_209F(var_0, 1);
  maps\mp\gametypes\_hud_util::_id_209E(var_0, 0);
  self._id_20A9[var_0] = 1;
}