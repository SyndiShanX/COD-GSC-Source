/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hub_unk2.gsc
*********************************************/

func_772B(param_00, param_01) {}

func_00D5() {
  level.var_4F51 = [];
  func_8A3C();
  func_8A23();
  func_8A07();
  func_8A2D();
  func_8A54();
  func_8A1F();
  func_8A02();
  func_8A49();
  func_8A20("scorestreak_training_npc", "scorestreak_officer_menu", undefined, "score_streak_visit", undefined);
  func_8A20("commander_npc", "company_commander_menu", undefined, "commander_visit", (-4, -1, -8));
  func_8A20("tdm_playlist_obj", "tdm_playlist_menu", undefined, "mp_npc_visit");
  func_8A20("dom_playlist_obj", "dom_playlist_menu", undefined, "dom_visit");
  func_8A20("war_playlist_obj", "war_playlist_menu", undefined, "war_npc_visit");
  func_8A20("r_and_r_obj", "r_and_r_menu", undefined, "r_and_r_visit", undefined);
  func_8A20("ranked_playlist_obj", "ranked_playlist_menu", undefined, "ranked_visit");
  func_8A20("overlook_guard_npc", "overlook_menu", undefined, undefined, (0, 0, -2));
  func_8A20("division_prestige_npc", "division_prestige_menu", undefined, undefined, undefined);
  func_A937();
  wait 0.05;
  level.var_A409 = getent("quartermaster_camera", "targetname");
  level.var_A40F = common_scripts\utility::func_46B5("quartermaster_spawn", "targetname");
  level.var_A408 = common_scripts\utility::func_46B5("quartermaster_bg_spawn", "targetname");
  level.var_4F4A = getdvarint("cg_fov");
  if(!isDefined(level.var_A40F)) {
    level.var_A40F = getent("quartermaster_spawn", "targetname");
  }

  if(!isDefined(level.var_A408)) {
    level.var_A408 = getent("quartermaster_bg_spawn", "targetname");
  }

  if(!isDefined(level.var_A409) || !isDefined(level.var_A40F) || !isDefined(level.var_A408)) {
    return;
  }

  var_00 = common_scripts\utility::func_44BD("mail_spawn_03", "targetname");
  var_01 = common_scripts\utility::func_44BD("mail_bg_spawn_03", "targetname");
  var_02 = common_scripts\utility::func_44BD("mail_camera_03", "targetname");
  var_03 = common_scripts\utility::func_44BD("operations_spawn_02", "targetname");
  var_04 = common_scripts\utility::func_44BD("operations_bg_spawn_02", "targetname");
  var_05 = common_scripts\utility::func_44BD("operations_camera_02", "targetname");
  func_772B(level.var_A409, "quartermasterCamera");
  func_772B(level.var_A40F, "quartermasterSpawn");
  func_772B(level.var_A408, "quartermasterBgSpawn");
  func_772B(var_02, "mailCamera");
  func_772B(var_00, "mailSpawn");
  func_772B(var_01, "mailBgSpawn");
  func_772B(var_05, "operationsCamera");
  func_772B(var_03, "operationsSpawn");
  func_772B(var_04, "operationsBgSpawn");
}

func_7BE9() {
  if(getdvarint("spv_hub_vendors_kswitch", 1) == 0) {
    foreach(var_01 in level.var_4F51) {
      if(isDefined(var_01) && isDefined(var_01.var_6113)) {
        if(!isDefined(var_01.var_5A7E) || getdvarint(var_01.var_5A7E, 1) == 0) {
          self addhubkiosk(var_01, var_01.var_6113);
        }
      }
    }
  }
}

func_A90E() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  for(;;) {
    self waittill("player_migrated");
    func_7BE9();
  }
}

func_A937() {
  level endon("game_ended");
  if(isDefined(level.var_744A)) {
    foreach(var_01 in level.var_744A) {
      var_01 func_7BE9();
    }
  }

  for(;;) {
    level waittill("connected", var_01);
    var_01 thread func_A90E();
    var_01 func_7BE9();
  }
}

func_8A3C() {
  level.var_781C = getent("quartermaster_npc", "targetname");
  level.var_781C.var_831A = common_scripts\utility::func_44BD("quartermaster_scripted_node", "targetname");
  func_772B(level.var_781C.var_831A, "quartermaster_scripted_node");
  if(!isDefined(level.var_781C)) {
    return;
  }

  level.var_781C.var_5A7E = "spv_hub_quartermasterVendor_kswitch";
  level.var_4F51[level.var_4F51.size] = level.var_781C;
  var_00 = level.var_781C.var_0116 + (0, 0, 40);
  level.var_781C setModel("tag_origin");
  level.var_781C.var_0116 = var_00;
  level.var_781C.var_50DA = 0;
  level.var_781C.var_56A9 = 1;
  level.var_781C.var_9FEB = "ui_show_quartermaster_hud";
  level.var_781C.var_6113 = "quartermaster_menu";
  level.var_781C.var_1739 = "hub_allies_bg_quartermaster";
}

func_8A23() {
  level.var_4BF3 = getent("headquarters_npc", "targetname");
  level.var_4BF3.var_831A = common_scripts\utility::func_44BD("headquarters_scripted_node", "targetname");
  func_772B(level.var_4BF3.var_831A, "headquarters_scripted_node");
  if(!isDefined(level.var_4BF3)) {
    return;
  }

  level.var_4BF3.var_5A7E = "spv_hub_requisitionsVendor_kswitch";
  level.var_4F51[level.var_4F51.size] = level.var_4BF3;
  if(!1) {
    level.var_4BF3.var_6DFB = [];
    var_00 = spawn("script_model", (0, 0, 0));
    var_00 setModel("mp_hub_revolving_chair_01");
    var_00.var_0109 = "ro_chair";
    level.var_4BF3.var_6DFB["ro_chair"] = var_00;
    var_01 = spawn("script_model", (0, 0, 0));
    var_01 setModel("usa_huba_org1");
    var_01 maps\mp\gametypes\_hub_unk1::func_8627();
    var_01.var_0109 = "aide_1";
    var_02 = spawn("script_model", (0, 0, 0));
    var_02 setModel("dun_usa_pencil_01");
    var_02.var_0109 = "aide_1_pencil";
    var_03 = spawn("script_model", (0, 0, 0));
    var_03 setModel("hub_us_ruler_01");
    var_03.var_0109 = "aide_1_ruler";
    var_04 = spawn("script_model", (0, 0, 0));
    var_04 setModel("hub_map_marker_01");
    var_04.var_0109 = "aide_1_marker";
    var_05 = spawn("script_model", (0, 0, 0));
    var_05 setModel("usa_hubc_org1");
    var_05 maps\mp\gametypes\_hub_unk1::func_8627();
    var_05.var_0109 = "aide_2";
    var_06 = spawn("script_model", (0, 0, 0));
    var_06 setModel("usa_phone_ee8");
    var_06.var_0109 = "aide_2_phone";
    level.var_4BF3.var_0ED2 = [];
    level.var_4BF3.var_0ED2["vendor"] = [];
    level.var_4BF3.var_0ED2["vendor"][0] = [];
    level.var_4BF3.var_0ED2["ro_chair"] = [];
    level.var_4BF3.var_0ED2["ro_chair"][0] = [];
    level.var_4BF3.var_0ED2["aide_1"] = [];
    level.var_4BF3.var_0ED2["aide_1_pencil"] = [];
    level.var_4BF3.var_0ED2["aide_1_ruler"] = [];
    level.var_4BF3.var_0ED2["aide_2"] = [];
    level.var_4BF3.var_0ED2["aide_2_phone"] = [];
    level.var_4BF3.var_0EAC = [];
    level.var_4BF3.var_0ED2["vendor"][0][0] = "mp_hub_ro_idle";
    level.var_4BF3.var_0ED2["vendor"][0][1] = "mp_hub_ro_ask_map_ro";
    level.var_4BF3.var_0ED2["vendor"][0][2] = "mp_hub_ro_talking_ro";
    level.var_4BF3.var_0ED2["vendor"][0][3] = "mp_hub_ro_twitch_b";
    level.var_4BF3.var_0ED2["vendor"][0][4] = "mp_hub_ro_stretch_standing";
    level.var_4BF3.var_0ED2["vendor"][0][5] = "mp_hub_ro_twitch_c";
    level.var_4BF3.var_0ED2["vendor"][0][6] = "mp_hub_ro_ask_cordinate_ro";
    level.var_4BF3.var_0ED2["vendor"][0][7] = "mp_hub_ro_twitch_a";
    level.var_4BF3.var_0ED2["vendor"][0][8] = "mp_hub_ro_phone_call_ro";
    level.var_4BF3.var_0ED2["ro_chair"][0][0] = "mp_hub_ro_idle_chair";
    level.var_4BF3.var_0ED2["ro_chair"][0][1] = "mp_hub_ro_ask_map_chair";
    level.var_4BF3.var_0ED2["ro_chair"][0][2] = "mp_hub_ro_talking_ro_chair";
    level.var_4BF3.var_0ED2["ro_chair"][0][3] = "mp_hub_ro_twitch_b_chair";
    level.var_4BF3.var_0ED2["ro_chair"][0][4] = "mp_hub_ro_stretch_standing_chair";
    level.var_4BF3.var_0ED2["ro_chair"][0][5] = "mp_hub_ro_twitch_c_chair";
    level.var_4BF3.var_0ED2["ro_chair"][0][6] = "mp_hub_ro_ask_cordinate_chair";
    level.var_4BF3.var_0ED2["ro_chair"][0][7] = "mp_hub_ro_twitch_a_chair";
    level.var_4BF3.var_0ED2["ro_chair"][0][8] = "mp_hub_ro_phone_call_chair";
    level.var_4BF3.var_0B42["idle"] = "mp_hub_ro_aide_01_idle";
    level.var_4BF3.var_0B42["twitch_a"] = "mp_hub_ro_aide_01_twitch_a";
    level.var_4BF3.var_0B42["twitch_b"] = "mp_hub_ro_aide_01_twitch_b";
    level.var_4BF3.var_0B42["coordinate"] = "mp_hub_ro_ask_cordinate_aide_01";
    level.var_4BF3.var_0B42["map"] = "mp_hub_ro_ask_map_aide_01";
    level.var_4BF3.var_0B44["idle"] = "mp_hub_ro_aide_01_twitch_a_pencil_idle";
    level.var_4BF3.var_0B44["twitch_a"] = "mp_hub_ro_aide_01_twitch_a_pencil";
    level.var_4BF3.var_0B44["twitch_b"] = "mp_hub_ro_aide_01_twitch_b_pencil";
    level.var_4BF3.var_0B45["idle"] = "mp_hub_ro_aide_01_twitch_b_ruler_idle";
    level.var_4BF3.var_0B45["twitch_b"] = "mp_hub_ro_aide_01_twitch_b_ruler";
    level.var_4BF3.var_0B43["idle"] = "mp_hub_ro_ask_map_marker_01_idle";
    level.var_4BF3.var_0B43["map"] = "mp_hub_ro_ask_map_marker_01";
    level.var_4BF3.var_0B46["idle"] = "mp_hub_ro_aide_02_idle";
    level.var_4BF3.var_0B46["call"] = "mp_hub_ro_phone_call_aide_02";
    level.var_4BF3.var_0B46["talking"] = "mp_hub_ro_talking_aide_02";
    level.var_4BF3.var_0B46["twitch_a"] = "mp_hub_ro_aide_02_twitch_a";
    level.var_4BF3.var_0B46["twitch_b"] = "mp_hub_ro_aide_02_twitch_b";
    level.var_4BF3.var_0B47["idle"] = "mp_hub_ro_aide_02_idle_phone";
    level.var_4BF3.var_0B47["call"] = "mp_hub_ro_phone_call_02_phone";
    level.var_4BF3.var_0B47["talking"] = "mp_hub_ro_talking_aide_02_phone";
    level.var_4BF3.var_0B47["twitch_a"] = "mp_hub_ro_aide_02_twitch_a_phone";
    level.var_4BF3.var_0B47["twitch_b"] = "mp_hub_ro_aide_02_twitch_b_phone";
    level.var_4BF3.var_0ED2["confirm"] = "mp_hub_requisition_officer_reaction_positive";
    level.var_4BF3.var_0ED2["deny"] = "mp_hub_requisition_officer_reaction_negative";
    level.var_4BF3.var_0ED2["enterMenu"] = "mp_hub_requisition_officer_transition";
    level.var_4BF3.var_A40D = "usa_requisition_org1";
    var_07 = spawn("script_model", (0, 0, 0));
    var_07 setModel("hub_us_candlestick_microphone_01");
    var_07 linkto(level.var_4BF3, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
    level.var_4BF3.var_267E = [507, 504, 0, 0, 0, 0];
    level.var_4BF3 setcostumemodels(level.var_4BF3.var_267E);
    level.var_4BF3.var_0EAC["mp_hub_ro_ask_cordinate_ro"] = spawnStruct();
    level.var_4BF3.var_0EAC["mp_hub_ro_ask_cordinate_ro"].var_3F02 = ::maps\mp\gametypes\_hub_unk1::func_83DE;
    level.var_4BF3.var_0EAC["mp_hub_ro_ask_cordinate_ro"].var_0F5D = [var_01, "coordinate"];
    level.var_4BF3.var_0EAC["mp_hub_ro_phone_call_ro"] = spawnStruct();
    level.var_4BF3.var_0EAC["mp_hub_ro_phone_call_ro"].var_3F02 = ::maps\mp\gametypes\_hub_unk1::func_83DE;
    level.var_4BF3.var_0EAC["mp_hub_ro_phone_call_ro"].var_0F5D = [var_05, "call", var_06, "call"];
    level.var_4BF3.var_0EAC["mp_hub_ro_ask_map_ro"] = spawnStruct();
    level.var_4BF3.var_0EAC["mp_hub_ro_ask_map_ro"].var_3F02 = ::maps\mp\gametypes\_hub_unk1::func_83DE;
    level.var_4BF3.var_0EAC["mp_hub_ro_ask_map_ro"].var_0F5D = [var_01, "map", var_04, "map"];
    level.var_4BF3.var_0EAC["mp_hub_ro_talking_ro"] = spawnStruct();
    level.var_4BF3.var_0EAC["mp_hub_ro_talking_ro"].var_3F02 = ::maps\mp\gametypes\_hub_unk1::func_83DE;
    level.var_4BF3.var_0EAC["mp_hub_ro_talking_ro"].var_0F5D = [var_05, "talking", var_06, "talking"];
    level.var_4BF3.var_0EAC["mp_hub_ro_twitch_b"] = spawnStruct();
    level.var_4BF3.var_0EAC["mp_hub_ro_twitch_b"].var_3F02 = ::maps\mp\gametypes\_hub_unk1::func_83DE;
    level.var_4BF3.var_0EAC["mp_hub_ro_twitch_b"].var_0F5D = [var_05, "twitch_a", var_06, "twitch_a"];
    level.var_4BF3.var_0EAC["mp_hub_ro_twitch_a"] = spawnStruct();
    level.var_4BF3.var_0EAC["mp_hub_ro_twitch_a"].var_3F02 = ::maps\mp\gametypes\_hub_unk1::func_83DE;
    level.var_4BF3.var_0EAC["mp_hub_ro_twitch_a"].var_0F5D = [var_05, "twitch_b", var_06, "twitch_b"];
    level.var_4BF3 thread func_71F3();
    thread maps\mp\gametypes\_hub_unk1::func_74AB(var_01, level.var_4BF3.var_0B42, level.var_4BF3.var_831A, ["idle", "coordinate", "map", "twitch_b"]);
    thread maps\mp\gametypes\_hub_unk1::func_74AB(var_02, level.var_4BF3.var_0B44, level.var_4BF3.var_831A, ["idle", "twitch_b"]);
    thread maps\mp\gametypes\_hub_unk1::func_74AB(var_04, level.var_4BF3.var_0B43, level.var_4BF3.var_831A, ["idle", "map"]);
    thread maps\mp\gametypes\_hub_unk1::func_74AB(var_03, level.var_4BF3.var_0B45, level.var_4BF3.var_831A, ["idle", "twitch_b"]);
    thread maps\mp\gametypes\_hub_unk1::func_74AB(var_05, level.var_4BF3.var_0B46, level.var_4BF3.var_831A, ["idle", "call", "talking", "twitch_a", "twitch_b"]);
    thread maps\mp\gametypes\_hub_unk1::func_74AB(var_06, level.var_4BF3.var_0B47, level.var_4BF3.var_831A, ["idle", "call", "talking", "twitch_a", "twitch_b"]);
  } else {
    var_08 = level.var_4BF3.var_0116 + (0, 0, 40);
    level.var_4BF3 setModel("tag_origin");
    level.var_4BF3.var_0116 = var_08;
  }

  level.var_4BF3.var_9FEB = "ui_show_headquarters_hud";
  level.var_4BF3.var_6113 = "headquarters_menu";
  level.var_4BF3.var_1739 = "hub_allies_bg_requisition";
  level.var_4BF3.var_A5CE = [];
  level.var_4BF3.var_A5CE["world"] = [];
  level.var_4BF3.var_A5CE["world"][0] = "hub_requisition_world_ambient1";
  level.var_4BF3.var_A5CE["world"][1] = "hub_requisition_world_ambient2";
  level.var_4BF3.var_A5CE["world"][2] = "hub_requisition_world_ambient3";
  level.var_4BF3.var_A5CE["interact"] = [];
  level.var_4BF3.var_A5CE["interact"][0] = "hub_requisition_interact1";
  level.var_4BF3.var_A5CE["interact"][1] = "hub_requisition_interact2";
  level.var_4BF3.var_A5CE["interact"][2] = "hub_requisition_interact3";
  level.var_4BF3.var_A5CE["stage"] = [];
  level.var_4BF3.var_A5CE["stage"][0] = "hub_requisition_stage_ambient1";
  level.var_4BF3.var_A5CE["stage"][1] = "hub_requisition_stage_ambient2";
  level.var_4BF3.var_A5CE["action1"] = [];
  level.var_4BF3.var_A5CE["action1"][0] = "hub_requisition_selection1";
  level.var_4BF3.var_A5CE["action1"][1] = "hub_requisition_selection2";
  level.var_4BF3.var_A5CE["fail"] = [];
  level.var_4BF3.var_A5CE["fail"][0] = "hub_requisition_selection_fail1";
  level.var_4BF3.var_A5CE["fail"][1] = "hub_requisition_selection_fail2";
  level.var_4BF3.var_A5CE["reinteract"] = [];
  level.var_4BF3.var_A5CE["reinteract"][0] = "hub_requisition_reinteract1";
  level.var_4BF3.var_A5CE["reinteract"][1] = "hub_requisition_reinteract2";
  level.var_4BF3.var_A5CE["leave"] = "hub_requisition_leave";
  thread func_71F4(level.var_4BF3, "world");
  level.var_4BF3.var_50DA = 0;
  level.var_4BF3.var_56A9 = 1;
}

func_8A07() {
  level.var_1783 = getent("blacksmith_npc", "targetname");
  level.var_1783.var_831A = common_scripts\utility::func_44BD("blacksmith_scripted_node", "targetname");
  if(!isDefined(level.var_1783)) {
    return;
  }

  func_772B(level.var_1783.var_831A, "blacksmith_scripted_node");
  level.var_1783.var_5A7E = "spv_hub_gunsmithVendor_kswitch";
  level.var_4F51[level.var_4F51.size] = level.var_1783;
  if(1) {
    level.var_1783 setModel("tag_origin");
  } else {
    level.var_1783.var_6DFB = [];
    var_00 = spawn("script_model", (0, 0, 0));
    var_00.var_00B9 = "hubc";
    var_00.var_18A8 = "hubc";
    var_00 maps\mp\gametypes\_hub_unk1::func_8627();
    var_00.var_0109 = "aide1";
    var_00.var_5717 = 0;
    var_01 = spawn("script_model", (0, 0, 0));
    var_01 setModel("npc_usa_m1garand_base");
    var_01 linkto(var_00, "tag_inhand", (0, 0, 0), (0, 0, 0));
    level.var_1783.var_6DFB["aide1"] = var_00;
    var_02 = spawn("script_model", (0, 0, 0));
    var_02 setModel("mp_hub_allies_bench_grinder_01");
    var_02.var_0109 = "grinder";
    level.var_1783.var_6DFB["grinder"] = var_02;
    var_03 = spawn("script_model", (0, 0, 0));
    var_03 setModel("npc_usa_bayonet_long_base");
    var_03.var_0109 = "knife";
    var_03 linkto(level.var_1783, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    level.var_1783.var_0EAC = [];
    level.var_1783.var_0ED2["vendor"] = [];
    level.var_1783.var_0ED2["vendor"][0] = [];
    level.var_1783.var_0ED2["aide1"] = [];
    level.var_1783.var_0ED2["aide1"][0] = [];
    level.var_1783.var_0ED2["vendor"][0][0] = "mp_hub_gs_sharpening_knife_loop";
    level.var_1783.var_0ED2["vendor"][0][1] = "mp_hub_gs_sharpening_knife_loop";
    level.var_1783.var_0ED2["aide1"][0][0] = "mp_hub_gs_aide_idle";
    level.var_1783.var_0ED2["grinder"][0][0] = "mp_hub_gs_sharpening_knife_loop_grinder";
    level.var_1783.var_267E = [508, 505, 0, 0, 0, 0];
    level.var_1783 setcostumemodels(level.var_1783.var_267E);
  }

  level.var_1783.var_A40D = "usa_f_blacksmith_org1";
  level.var_1783.var_9FEB = "ui_show_blacksmith_hud";
  level.var_1783.var_6113 = "blacksmith_menu";
  level.var_1783.var_1739 = "hub_allies_bg_blacksmith";
  level.var_1783.var_A5CE = [];
  level.var_1783.var_A5CE["world"] = [];
  level.var_1783.var_A5CE["world"][0] = "hub_blacksmith_world_ambient1";
  level.var_1783.var_A5CE["world"][1] = "hub_blacksmith_world_ambient2";
  level.var_1783.var_A5CE["world"][2] = "hub_blacksmith_world_ambient3";
  level.var_1783.var_A5CE["interact"] = [];
  level.var_1783.var_A5CE["interact"][0] = "hub_blacksmith_interact1";
  level.var_1783.var_A5CE["interact"][1] = "hub_blacksmith_interact2";
  level.var_1783.var_A5CE["interact"][2] = "hub_blacksmith_interact3";
  level.var_1783.var_A5CE["stage"] = "hub_blacksmith_stage_ambient";
  level.var_1783.var_A5CE["action1"] = [];
  level.var_1783.var_A5CE["action1"][0] = "hub_blacksmith_prestige1";
  level.var_1783.var_A5CE["action1"][1] = "hub_blacksmith_prestige2";
  level.var_1783.var_A5CE["action2"] = "hub_blacksmith_craft1";
  level.var_1783.var_A5CE["fail1"] = "hub_blacksmith_prestige_fail";
  level.var_1783.var_A5CE["fail2"] = "hub_blacksmith_craft_fail";
  level.var_1783.var_A5CE["reinteract"] = [];
  level.var_1783.var_A5CE["reinteract"][0] = "hub_blacksmith_reinteract1";
  level.var_1783.var_A5CE["reinteract"][1] = "hub_blacksmith_reinteract2";
  level.var_1783.var_A5CE["leave"] = "hub_blacksmith_leave";
  thread func_71F4(level.var_1783, "world");
  level.var_1783.var_50DA = 0;
  level.var_1783.var_56A9 = 1;
  if(!1) {
    level.var_1783 thread func_71F3();
  }
}

func_8A2D() {
  level.var_5F83 = getent("mail_npc", "targetname");
  if(!isDefined(level.var_5F83)) {
    return;
  }

  level.var_5F83.var_5A7E = "spv_hub_payrollVendor_kswitch";
  level.var_4F51[level.var_4F51.size] = level.var_5F83;
  level.var_5F83.var_9FEB = "ui_show_mail_hud";
  level.var_5F83.var_6113 = "mail_officer_menu";
  level.var_5F83.var_1739 = "hub_allies_bg_quartermaster";
  level.var_5F83.var_50DA = 1;
  level.var_5F83.var_56A9 = 1;
}

func_8A54() {
  level.var_AC32 = getent("zombie_npc", "targetname");
  if(!isDefined(level.var_AC32)) {
    return;
  }

  func_772B(level.var_AC32, "zombie_placement");
  level.var_AC32 setModel("tag_origin");
  level.var_AC32.var_0116 = level.var_AC32.var_0116 + (0, 2.5, 52);
  level.var_AC32.var_5A7E = "spv_hub_zombiesVendor_kswitch";
  level.var_4F51[level.var_4F51.size] = level.var_AC32;
  level.var_AC32.var_0EAC = [];
  level.var_AC32.var_0ED2["idleTwitch"] = [];
  level.var_AC32.var_0ED2["idle"] = "mp_hub_zombie_officer_idle";
  level.var_AC32.var_0ED2["idleTwitch"]["A"] = "mp_hub_zombie_officer_twitch_a";
  level.var_AC32.var_A40D = "usa_zombie_org1";
  level.var_AC32.var_9FEB = "ui_show_zombie_playlist_hud";
  level.var_AC32.var_6113 = "zombie_officer_menu";
  level.var_AC32.var_1739 = "hub_allies_bg_zombie";
  level.var_AC32.var_50DA = 0;
  level.var_AC32.var_56A9 = 1;
}

func_8A1F() {
  level.var_4012 = getent("general_npc", "targetname");
  level.var_4012.var_831A = common_scripts\utility::func_44BD("general_scripted_node", "targetname");
  func_772B(level.var_4012.var_831A, "general_scripted_node");
  if(!isDefined(level.var_4012)) {
    return;
  }

  level.var_4012.var_5A7E = "spv_hub_prestigeVendor_kswitch";
  level.var_4012.var_6DFB = [];
  level.var_4012.var_0EAC = [];
  level.var_4012.var_0ED2["vendor"][0][0] = "mp_hub_general_idle";
  level.var_4012.var_0ED2["vendor"][0][1] = "mp_hub_general_twitch_a";
  level.var_4012.var_0ED2["vendor"][0][2] = "mp_hub_general_twitch_b";
  level.var_4012.var_0ED2["vendor"][0][3] = "mp_hub_general_twitch_c";
  level.var_4012.var_0ED2["vendor"][0][4] = "mp_hub_general_twitch_d";
  level.var_4012.var_0ED2["vendor"][0][5] = "mp_hub_general_idle2overlook";
  level.var_4012.var_0ED2["vendor"][1][0] = "mp_hub_general_overlook_idle";
  level.var_4012.var_0ED2["vendor"][1][1] = "mp_hub_general_overlook_twitch_a";
  level.var_4012.var_0ED2["vendor"][1][2] = "mp_hub_general_overlook_twitch_b";
  level.var_4012.var_0ED2["vendor"][1][3] = "mp_hub_general_overlook_twitch_c";
  level.var_4012.var_0ED2["vendor"][1][4] = "mp_hub_general_overlook2idle";
  level.var_4012.var_0ED2["vendorStage"]["react_pos"] = "mp_hub_general_salute";
  level.var_4012.var_0ED2["aide1"][0][0] = "mp_hub_general_aide_01_idle";
  level.var_4012.var_0ED2["aide1"][1][0] = "mp_hub_general_aide_01_idle";
  level.var_4012.var_0ED2["aide2"][0][0] = "mp_hub_general_aide_02_idle";
  level.var_4012.var_0ED2["aide2"][1][0] = "mp_hub_general_aide_02_idle";
  level.var_4012.var_A40D = "usa_prestige_org1";
  level.var_4012.var_9FEB = "ui_show_general_hud";
  level.var_4012.var_6113 = "general_menu";
  level.var_4012.var_1739 = "hub_allies_bg_general";
  if(1) {
    level.var_4012 setModel("tag_origin");
  } else {
    level.var_4012.var_267E = [510, 507, 0, 0, 0, 0];
    level.var_4012 setcostumemodels(level.var_4012.var_267E);
    var_00 = spawn("script_model", (0, 0, 0));
    var_00 setModel("eng_raidstick_org1");
    var_00 linkto(level.var_4012, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
    level.var_4012 thread func_71F3();
  }

  level.var_4012.var_50DA = 0;
  level.var_4012.var_56A9 = 1;
  level.var_4F51[level.var_4F51.size] = level.var_4012;
}

func_8A20(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getent(param_00, "targetname");
  if(!isDefined(var_05)) {
    return;
  }

  if(isDefined(param_04)) {
    var_05.var_0116 = var_05.var_0116 + param_04;
  }

  var_05.var_5A7E = "spv_hub_" + param_00 + "_kswitch";
  setdvarifuninitialized(var_05.var_5A7E, 1);
  var_05.var_6113 = param_01;
  if(isDefined(param_02)) {
    var_05.var_3F02 = param_02;
  } else {
    var_05.var_3F02 = ::func_4AC7;
  }

  if(isDefined(param_03)) {
    var_05.var_308D = param_03;
  }

  var_05.var_50DA = 1;
  var_05.var_56A9 = 1;
  level.var_4F51[level.var_4F51.size] = var_05;
}

func_8A02() {
  level.var_6B22 = getent("1v1_npc", "targetname");
  if(!isDefined(level.var_6B22)) {
    return;
  }

  level.var_6B22.var_5A7E = "spv_hub_1v1_kswitch";
  level.var_4F51[level.var_4F51.size] = level.var_6B22;
  level.var_6B22.var_9FEB = "ui_show_onevone_officer_hud";
  level.var_6B22.var_6113 = "onevone_officer_menu";
  level.var_6B22.var_1739 = "hub_allies_bg_1v1";
  level.var_6B22.var_50DA = 1;
  level.var_6B22.var_56A9 = 1;
}

func_8A49() {
  level.var_9957 = getent("theater_icon", "targetname");
  level.var_9957.var_6113 = "theater_menu";
  level.var_9957.var_5A7E = "spv_hub_theater_kswitch";
  level.var_9957.var_50DA = 1;
  level.var_4F51[level.var_4F51.size] = level.var_9957;
}

func_6B88(param_00, param_01, param_02) {
  level endon("game_ended");
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(common_scripts\utility::func_562E(level.var_A259)) {
    param_01 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubVendors", "quartermasterVisits"], 1, undefined, undefined);
    param_01 maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Quartermaster"], function_003E());
    param_01 setclientomnvar("ui_vendor_set_up_ready", 1);
    return;
  }

  if(!isDefined(level.var_781C) || param_02 && self != level.var_781C && self != level.maleqmnpc) {
    return;
  }

  if(level.var_4F50 && isDefined(param_01.var_9FB4) && param_01.var_9FB4 < 4) {
    return;
  }

  var_03 = param_01 func_7478(level.var_781C, -6);
  param_01 method_8626("mp_hub_vendor_mix");
  if(isDefined(var_03) && var_03) {
    param_01 thread func_4AE6(level.var_781C);
    param_01 maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0, !param_02, 0);
    param_01 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubVendors", "quartermasterVisits"], 1, undefined, undefined);
    param_01 maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Quartermaster"], function_003E());
  }
}

func_6B43(param_00, param_01, param_02) {
  level endon("game_ended");
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(common_scripts\utility::func_562E(level.var_A259)) {
    param_01 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubVendors", "requisitionsVisits"], 1, undefined, undefined);
    param_01 maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Requisitions"], function_003E());
    param_01 setclientomnvar("ui_vendor_set_up_ready", 1);
    return;
  }

  if(!isDefined(level.var_4BF3) || param_02 && self != level.var_4BF3) {
    return;
  }

  var_03 = param_01 func_7478(level.var_4BF3);
  param_01 method_8626("mp_hub_vendor_mix");
  if(isDefined(var_03) && var_03) {
    param_01 maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0, 0, 0);
    if(isDefined(level.var_7B46)) {
      thread maps\mp\gametypes\_hub_unk0::func_2D4A();
      param_01 luinotifyeventextraplayer(&"remove_persistent_indicator", 1, 1);
      param_01 luinotifyeventextraplayer(&"remove_persistent_indicator", 1, 2);
      param_01 luinotifyeventextraplayer(&"add_persistent_indicator", 2, 2, "HUB_ONB_ORDERS");
    }

    param_01 thread func_4AC9(level.var_4BF3);
    param_01 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubVendors", "requisitionsVisits"], 1, undefined, undefined);
    param_01 maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Requisitions"], function_003E());
  }
}

func_6AC1(param_00, param_01, param_02) {
  level endon("game_ended");
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(!isDefined(level.var_1783) || param_02 && self != level.var_1783) {
    return;
  }

  var_03 = param_01 func_7478(level.var_1783, -7);
  param_01 method_8626("mp_hub_vendor_mix");
  if(isDefined(var_03) && var_03) {
    param_01 thread func_4AA9(level.var_1783);
    param_01 maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0, 0, 0);
    param_01 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubVendors", "gunsmithVisits"], 1, undefined, undefined);
    param_01 maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Gunsmith"], function_003E());
  }
}

func_6B55(param_00, param_01) {
  level endon("game_ended");
  if(common_scripts\utility::func_562E(level.var_A259)) {
    param_01 maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Mail"], function_003E());
    if(!maps\mp\gametypes\_hud_util::func_5527()) {
      param_01 setclientomnvar("ui_vendor_set_up_ready", 1);
    }

    return;
  }

  if(!isDefined(level.var_5F83) || self != level.var_5F83) {
    return;
  }

  if(level.var_4F50 && isDefined(param_01.var_9FB4) && param_01.var_9FB4 < 4) {
    return;
  }

  var_02 = param_01 func_7478(level.var_5F83);
  param_01 maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0, 0, 0);
  param_01 method_8626("mp_hub_vendor_mix");
  if(isDefined(var_02) && var_02) {
    param_01 thread func_4AD3(level.var_5F83);
    param_01 maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Mail"], function_003E());
  }
}

func_6BB5(param_00, param_01) {
  level endon("game_ended");
  if(!isDefined(level.var_9957) || self != level.var_9957) {
    return;
  }

  param_01 method_8626("hub_theater");
  param_01.var_5733 = 1;
  param_01 maps\mp\gametypes\_hub_unk1::func_870B(1);
  param_01 setclientomnvar("ui_vendor_set_up_ready", 1);
  param_01 maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0, 0, 0);
  param_01 lib_0468::func_0A2A("theater");
  param_01 thread func_4AFD(level.var_9957);
}

ontheateropenvlonly(param_00, param_01) {
  level endon("game_ended");
  param_01 method_8626("hub_theater");
  param_01 lib_0468::func_0A2A("theater");
  param_01 thread handletheatervlonly(level.var_9957);
}

func_6B8F(param_00, param_01) {
  level endon("game_ended");
  param_01.var_5733 = 1;
  param_01 maps\mp\gametypes\_hub_unk1::func_870B(1);
  param_01 setclientomnvar("ui_vendor_set_up_ready", 1);
  param_01 maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0, 0, 0);
  param_01 method_8626("duck_background_sfx");
  param_01 thread func_4AE9(param_01);
}

onleaderboardinteract(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    return;
  }

  if(param_00 == "ranked_playlist_menu" && param_01 == 99) {
    param_02 iclientprintln(&"HUB_WARNING_SPLITSCREEN");
    return;
  }

  if(!isDefined(param_02.timeoflastlfglitemsg) || gettime() - param_02.timeoflastlfglitemsg > 30000) {
    param_02.timeoflastlfglitemsg = gettime();
  } else {
    param_02 iclientprintln(&"HUB_LFG_LITE_WAIT");
    return;
  }

  var_03 = undefined;
  switch (param_00) {
    case "tdm_playlist_menu":
      var_03 = &"HUB_LFG_TDM";
      break;

    case "dom_playlist_menu":
      var_03 = &"HUB_LFG_DOM";
      break;

    case "war_playlist_menu":
      var_03 = &"HUB_LFG_WAR";
      break;

    case "ranked_playlist_menu":
      var_03 = &"HUB_LFG_RANKED";
      break;

    default:
      break;
  }

  if(isDefined(var_03)) {
    iprintln(var_03, param_02.var_0109);
  }
}

func_6BCC(param_00, param_01, param_02) {
  level endon("game_ended");
  var_03 = undefined;
  foreach(var_05 in level.var_4F51) {
    if(isDefined(var_05.var_6113) && var_05.var_6113 == param_02) {
      var_03 = var_05;
    }
  }

  if(!isDefined(var_03)) {
    return;
  }

  var_07 = param_01 func_7478(var_03);
  param_01 method_8626("mp_hub_vendor_mix");
  if(isDefined(var_07) && var_07) {
    if(isDefined(var_03.var_3F02)) {
      param_01 thread[[var_03.var_3F02]](var_03);
      return;
    }

    param_01 thread func_4AC7(var_03);
  }
}

func_6BD6(param_00, param_01) {
  level endon("game_ended");
  if(!isDefined(level.var_AC32) || self != level.var_AC32) {
    return;
  }

  var_02 = param_01 func_7478(level.var_AC32);
  param_01 method_8626("mp_hub_vendor_mix");
  if(isDefined(var_02) && var_02) {
    param_01 thread func_4B09(level.var_AC32);
    param_01 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubVendors", "zombiesVisits"], 1, undefined, undefined);
    param_01 maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hubVendors", "vendorVisitTimestamps", "Zombies"], function_003E());
  }
}

func_6B40(param_00, param_01) {
  level endon("game_ended");
  if(!isDefined(level.var_4012) || self != level.var_4012) {
    return;
  }

  var_02 = param_01 func_7478(level.var_4012);
  param_01 method_8626("mp_hub_vendor_mix");
  if(isDefined(var_02) && var_02) {
    param_01 maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0, 0, 0);
    param_01 thread func_4AC6(level.var_4012);
    param_01 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubVendors", "prestigeVisits"], 1, undefined, undefined);
  }
}

func_6B5F(param_00, param_01) {
  level endon("game_ended");
  param_01 setclientomnvar(level.var_6B22.var_9FEB, level.var_4F38.var_787F.size);
  var_02 = param_01 func_7478(level.var_6B22);
  if(isDefined(var_02) && var_02) {
    param_01 thread func_4AA7(level.var_6B22);
  }
}

func_639F() {
  level endon("game_ended");
  self endon("disconnect");
  func_27CC();
  if(!isDefined(self.var_A40B) || self.var_A40B.size == 0) {
    return;
  }

  if(!isDefined(self.var_5721)) {
    self.var_5721 = 0;
  }

  func_8C01(self.var_A40B);
  self.var_4D4E = 0;
}

func_639B() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("highlight");
    if(maps\mp\gametypes\_hub_unk1::func_5790()) {
      continue;
    }

    while(self adsButtonPressed()) {
      level.var_781C hudoutlineenableforclient(self, 5, 0);
      level.var_4BF3 hudoutlineenableforclient(self, 5, 0);
      level.var_1783 hudoutlineenableforclient(self, 5, 0);
      level.var_79AC hudoutlineenableforclient(self, 5, 0);
      level.var_5F83 hudoutlineenableforclient(self, 5, 0);
      level.var_AC32 hudoutlineenableforclient(self, 5, 0);
      level.var_4012 hudoutlineenableforclient(self, 5, 0);
      level.var_2540 hudoutlineenableforclient(self, 5, 0);
      level.var_6B22 hudoutlineenableforclient(self, 5, 0);
      level.var_80BA hudoutlineenableforclient(self, 5, 0);
      self.var_4D4E = 1;
      func_3E26(self.var_A40B);
      wait(1);
    }

    level.var_781C hudoutlinedisableforclient(self);
    level.var_4BF3 hudoutlinedisableforclient(self);
    level.var_1783 hudoutlinedisableforclient(self);
    level.var_79AC hudoutlinedisableforclient(self);
    level.var_5F83 hudoutlinedisableforclient(self);
    level.var_AC32 hudoutlinedisableforclient(self);
    level.var_4012 hudoutlinedisableforclient(self);
    level.var_2540 hudoutlinedisableforclient(self);
    level.var_6B22 hudoutlinedisableforclient(self);
    level.var_80BA hudoutlinedisableforclient(self);
    func_7DF6(self.var_A40B);
    self.var_4D4E = 0;
  }
}

func_4AE6(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      maps\mp\gametypes\_hub_unk1::func_5E88("quartermaster_visit", "hq_npc_visit_ended", self.var_99EA, []);
      self notify("playerLeftQuartermaster");
      if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
        return;
      }

      func_741D(param_00);
      self method_8627("mp_hub_vendor_mix");
      wait 0.05;
      maps\mp\gametypes\_hub_unk1::func_A04C();
      break;
    }

    switch (var_02) {
      case 0:
        thread maps\mp\gametypes\_hub_unk1::func_3010("cantAfford", &"HUB_CANT_AFFORD", undefined, -100, 2, 3);
        if(isDefined(self.var_A405)) {
          self.var_A405 notify("react_neg");
        }
        break;

      case 1:
        if(isDefined(self.var_A405)) {
          self.var_A405 notify("react_pos");
          wait 0.05;
        }
        break;

      case 2:
        if(isDefined(self.var_A405)) {
          break;
        }

        break;

      case 3:
        break;

      default:
        break;
    }
  }
}

func_4AC9(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      self notify("playerLeftRequisitions");
      maps\mp\gametypes\_hub_unk1::func_5E88("operations_visit", "hq_npc_visit_ended", self.var_99EA, []);
      if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
        return;
      }

      func_741D(param_00);
      self method_8627("mp_hub_vendor_mix");
      wait 0.05;
      maps\mp\gametypes\_hub_unk1::func_A04C();
      break;
    }
  }
}

func_4AA9(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection" && var_01 != "hub_weapon_prestiged" && var_01 != "hub_weapon_crafted") {
      continue;
    }

    if(var_01 == "hub_character_selection") {
      if(var_02 == -1) {
        maps\mp\gametypes\_hub_unk1::func_5E88("gunsmith_visit", "hq_npc_visit_ended", self.var_99EA, []);
        if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
          return;
        }

        func_741D(param_00);
        self method_8627("mp_hub_vendor_mix");
        wait 0.05;
        maps\mp\gametypes\_hub_unk1::func_A04C();
        return;
      }

      switch (var_02) {
        case 1:
          if(isDefined(self.var_A405)) {
            thread func_7200(self.var_A405, "deny", "idle");
          }
          break;

        case 0:
          if(isDefined(self.var_A405)) {
            thread func_7200(self.var_A405, "deny", "idle");
          }
          break;

        case 2:
          if(isDefined(self.var_A405)) {
            thread func_7200(self.var_A405, "confirm", "idle");
          }
          break;

        case 3:
          if(isDefined(self.var_A405)) {
            thread func_7200(self.var_A405, "deny", "idle");
          }

          self iclientprintln("Can\'t afford armory drop. 100 armory credits required");
          break;

        case 10:
          if(isDefined(self.var_A405)) {
            self.var_A405 method_805C();
          }
          break;

        case 11:
          if(isDefined(self.var_A405)) {
            self.var_A405 showtoclient(self);
          }
          break;
      }

      continue;
    }

    if(var_01 == "hub_weapon_prestiged") {
      var_03 = var_02;
      var_04 = common_scripts\utility::func_9462(var_03, "_mp");
      var_05 = getsubstr(var_03, 0, var_04);
      self.var_5791 = 1;
      var_06 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", getweapondisplayname(var_03), "prestigeLevel") + 1;
      var_07 = tablelookuprownum("mp/statstable.csv", 2, var_03);
      thread maps\mp\gametypes\_hud_message::func_A9DD("weapon_prestige", var_07, var_06);
      foreach(var_09 in level.var_744A) {
        switch (var_06) {
          case 1:
            var_0A = var_06 + "st";
            break;

          case 2:
            var_0A = var_06 + "nd";
            break;

          case 3:
            var_0A = var_06 + "rd";
            break;

          default:
            var_0A = var_06 + "th";
            break;
        }

        var_09 iclientprintln(&"HUB_WEAPON_PRESTIGE_CHAT", self.var_0109, var_05, var_0A);
      }

      self.var_5791 = 0;
      continue;
    }

    if(var_01 == "hub_weapon_crafted") {
      var_03 = var_02;
      var_04 = common_scripts\utility::func_9462(var_03, "_mp");
      var_05 = getsubstr(var_03, 0, var_04);
      self.var_5791 = 1;
      var_07 = tablelookuprownum("mp/statstable.csv", 2, var_03);
      thread maps\mp\gametypes\_hud_message::func_A9DD("weapon_forge", var_07);
      self.var_5791 = 0;
    }
  }
}

func_4AD3(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      self notify("playerLeftPayroll");
      maps\mp\gametypes\_hub_unk1::func_5E88("mail_visit", "hq_npc_visit_ended", self.var_99EA, []);
      if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
        return;
      }

      func_741D(param_00);
      self method_8627("mp_hub_vendor_mix");
      maps\mp\gametypes\_hub_unk1::func_A04C();
      break;
    }

    switch (var_02) {
      case 1:
        break;

      case 2:
        break;

      default:
        break;
    }
  }
}

func_4AFD(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      self notify("playerLeftTheater");
      if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
        return;
      }

      self method_8627("hub_theater");
      self setclientomnvar("ui_vendor_set_up_ready", 0);
      self.var_5733 = 0;
      maps\mp\gametypes\_hub_unk1::func_870B(0);
      maps\mp\gametypes\_hub_unk1::func_A04C();
      break;
    }

    switch (var_02) {
      default:
        break;
    }
  }
}

handletheatervlonly(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      self method_8627("hub_theater");
      break;
    }

    switch (var_02) {
      default:
        break;
    }
  }
}

func_4AE9(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      self notify("playerLeftRandR");
      if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
        return;
      }

      self method_8627("duck_background_sfx");
      self setclientomnvar("ui_vendor_set_up_ready", 0);
      self.var_5733 = 0;
      maps\mp\gametypes\_hub_unk1::func_870B(0);
      maps\mp\gametypes\_hub_unk1::func_A04C();
      break;
    }

    switch (var_02) {
      case 1:
        break;

      default:
        break;
    }
  }
}

func_4AC7(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      if(isDefined(param_00.var_308D)) {
        maps\mp\gametypes\_hub_unk1::func_5E88(param_00.var_308D, "hq_npc_visit_ended", self.var_99EA, []);
      }

      if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
        return;
      }

      func_741D(param_00);
      self method_8627("mp_hub_vendor_mix");
      break;
    }

    switch (var_02) {
      case 1:
        break;

      default:
        break;
    }
  }
}

func_4B09(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      func_741D(param_00);
      if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
        return;
      }

      self method_8627("mp_hub_vendor_mix");
      maps\mp\gametypes\_hub_unk1::func_5E88("zm_npc_visit", "hq_npc_visit_ended", self.var_99EA, []);
      break;
    }

    switch (var_02) {
      case 1:
        break;

      default:
        break;
    }

    if(isDefined(self.var_A405)) {
      self.var_A405 scriptmodelplayanim(level.var_AC32.var_0ED2["interact"]);
    }
  }
}

func_4AC6(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("clear_any_prestige_threads");
  thread monitorprestigestatsreset();
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      if(self.var_5733) {
        maps\mp\gametypes\_hub_unk1::func_5E88("prestige_visit", "hq_npc_visit_ended", self.var_99EA, []);
        if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
          return;
        }

        func_741D(param_00);
        maps\mp\gametypes\_hub_unk1::func_A04C();
      }

      break;
    }

    switch (var_02) {
      case 77:
        var_03 = self.var_012C["prestige"];
        foreach(var_05 in level.var_744A) {
          if(var_05 == self) {
            var_05 iclientprintln(&"HUB_PRESTIGE_CHAT_YOU", &"HUB_YOU", var_03);
            continue;
          }

          if(isDefined(var_05)) {
            var_05 iclientprintln(&"HUB_PRESTIGE_CHAT", self.var_0109, var_03);
          }
        }

        thread func_76B1(var_03);
        lib_0468::func_0A2A("general", var_03);
        func_741D(param_00);
        maps\mp\gametypes\_hub_unk1::func_5E88("prestige_visit", "hq_npc_visit_ended", self.var_99EA, []);
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
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "prestige_stats_reset") {
      continue;
    }

    if(var_01 == 1) {
      var_02 = self.var_012C["prestige"] + 1;
      self setrankedplayerdata(common_scripts\utility::func_46AE(), "experience", 0);
      self setrankedplayerdata(common_scripts\utility::func_46AE(), "prestige", var_02);
      self.var_012C["rankxp"] = 0;
      self.var_012C["rank"] = 0;
      self.var_012C["prestige"] = var_02;
      self setrank(0, var_02);
      self notify("clear_any_prestige_threads");
      return;
    }
  }
}

func_4AF4(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 == "hub_character_selection") {
      if(var_02 == -1) {
        if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
          return;
        }

        func_741D(param_00);
        self setclientomnvar(level.var_8ED7.var_9FEB, 0);
        break;
      }

      switch (var_02) {
        case 1:
          break;

        default:
          break;
      }
    }
  }
}

func_4AB0(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
        return;
      }

      func_741D(param_00);
      self method_8627("mp_hub_vendor_mix");
      maps\mp\gametypes\_hub_unk1::func_A04C();
      break;
    }

    switch (var_02) {
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

    if(isDefined(self.var_A405)) {
      self.var_A405 scriptmodelplayanim(level.var_4012.var_0ED2["interact"]);
    }
  }
}

func_4AF2(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 == "hub_character_selection") {
      if(var_02 == -1) {
        if((isDefined(self.var_56AD) && self.var_56AD) || isDefined(self.var_572A) && self.var_572A) {
          return;
        }

        func_741D(param_00);
        self setclientomnvar(level.var_80BA.var_9FEB, 0);
        break;
      }

      switch (var_02) {
        case 1:
          break;

        default:
          break;
      }

      if(isDefined(self.var_A405)) {
        self.var_A405 scriptmodelplayanim(level.var_80BA.var_0ED2["interact"]);
      }

      continue;
    }

    if(var_01 == "hub_force_vlobby_execute") {
      switch (var_02) {
        case 0:
          func_741D(param_00);
          self setclientomnvar(level.var_80BA.var_9FEB, 0);
          break;

        default:
          break;
      }
    }
  }
}

func_4AA7(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      func_741D(param_00);
      break;
    }

    switch (var_02) {
      case 3:
        func_741D(param_00);
        thread maps\mp\_1v1::func_7CE0(self);
        break;

      case 1:
        func_741D(param_00);
        thread maps\mp\_1v1::func_09FB(self);
        break;

      case 2:
        func_741D(param_00);
        thread maps\mp\_1v1::func_7475();
        break;

      default:
        break;
    }

    if(isDefined(self.var_A405)) {
      self.var_A405 scriptmodelplayanim(level.var_6B22.var_0ED2["interact"]);
    }
  }
}

func_4AE3() {
  level endon("game_ended");
  self method_82A1(1);
}

func_7473(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  param_00 endon("disconnect");
  if(!self.var_53DB) {
    self method_81E2(level.var_A409, "tag_player");
    self freezecontrols(1);
    var_01 = spawn("script_model", level.var_A40F.var_0116 + (30, 0, 0));
    var_01 setModel("usa_raid_org1");
    if(!isDefined(param_00.var_267E)) {
      var_01 setcostumemodels([1, 1, 1, 1, 1, 1]);
    } else {
      var_01 setcostumemodels(param_00.var_267E);
    }

    var_01.var_001D = level.var_A409.var_001D + (0, 180, 0);
    var_01 scriptmodelplayanim("mp_hub_foldarms_idle_p");
    var_01 method_805C();
    var_01 showtoclient(self);
    self.var_53DA = var_01;
    self.var_53DB = 1;
  }
}

func_741C() {
  if(!isDefined(self)) {
    return;
  }

  if(self.var_53DB) {
    self method_81E3();
    self freezecontrols(0);
    self.var_53DA delete();
    self.var_53DB = 0;
  }
}

func_7478(param_00, param_01) {
  level endon("game_ended");
  self endon("disconnect");
  var_02 = 0;
  var_03 = undefined;
  if(!isDefined(param_00.var_56A9)) {
    if(!isDefined(self.var_A410)) {
      self.var_A410 = [];
    }

    if(!isDefined(common_scripts\utility::func_0F7E(self.var_A410, param_00))) {
      self.var_A410[self.var_A410.size] = param_00;
      var_02 = 1;
    }
  }

  if(!isDefined(param_00.var_56A9)) {
    if(!isDefined(param_01)) {
      var_03 = spawn("script_model", level.var_A40F.var_0116);
    } else {
      var_03 = spawn("script_model", level.var_A40F.var_0116 + (param_01, 5, 0));
    }

    self method_81E2(level.var_A409, "tag_player");
    self setclientdvar("cg_fov", 47);
  }

  if(!isDefined(param_00.var_56A9)) {
    if(isDefined(param_00.var_267E)) {
      var_03 setcostumemodels(param_00.var_267E, "allies");
    }

    var_03.var_001D = level.var_A40F.var_001D - (0, 5, 0);
    if(isDefined(param_00.var_0ED2) && !param_00.var_50DA) {
      var_03.var_0ED2 = param_00.var_0ED2;
      if(isDefined(var_03.var_0ED2["enterMenu"]) && param_00 != level.var_781C) {
        thread func_7200(var_03, "enterMenu", "idle");
      } else if(param_00 == level.var_781C) {
        var_03.var_914E = param_00.var_914E;
        var_04 = var_03 thread func_8A47(self);
        var_03 thread func_4B03(var_02, var_04, self);
      }
    }
  }

  if(isDefined(param_00.var_1739) && !isDefined(param_00.var_56A9)) {
    self.var_A407 = spawn("script_model", level.var_A408.var_0116);
    self.var_A407 setModel(param_00.var_1739);
    self.var_A407.var_001D = level.var_A408.var_001D;
    self.var_A407 method_805C();
    self.var_A407 showtoclient(self);
  }

  if(!isDefined(param_00.var_56A9)) {
    if(isDefined(param_00.var_A5CE)) {
      var_03.var_A5CE = param_00.var_A5CE;
    }

    var_03.var_9FEB = param_00.var_9FEB;
    var_03 method_805C();
    var_03 showtoclient(self);
    self.var_A405 = var_03;
  } else {
    self.var_5CC4 = param_00;
  }

  self setclientomnvar("ui_vendor_set_up_ready", 1);
  self.var_A40C = gettime();
  self.var_5733 = 1;
  maps\mp\gametypes\_hub_unk1::func_870B(1);
  return 1;
}

func_741D(param_00) {
  self method_8627("mp_hub_vendor_mix");
  if(!isDefined(self) || !isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_00.var_56A9)) {
    if(isDefined(level.var_4F4A)) {
      self setclientdvar("cg_fov", level.var_4F4A);
    }

    if(isDefined(self.var_A407)) {
      self.var_A407 delete();
      self.var_A407 = undefined;
    }

    if(isDefined(self.var_A405)) {
      self.var_A405 notify("vendorChangeAnimState");
      self.var_A405 notify("vendorDeleted");
      self.var_A405 delete();
      self.var_A405 = undefined;
    }

    self method_81E3();
  }

  if(isDefined(self.var_A40C)) {
    self.var_99EA = int(gettime() - self.var_A40C / 1000);
  }

  self.var_A40C = undefined;
  self setclientomnvar("ui_vendor_set_up_ready", 0);
  self.var_5733 = 0;
  self.var_5CC4 = undefined;
  if(!isDefined(self.var_56AD) || self.var_56AD == 0) {
    maps\mp\gametypes\_hub_unk1::func_870B(0);
  }
}

func_09A5(param_00) {
  if(!isDefined(self)) {
    return;
  }

  maps\mp\gametypes\_hud_util::func_209E(param_00, 0);
  maps\mp\gametypes\_hud_util::func_209F(param_00, 2);
}

func_9EBF(param_00) {
  if(!isDefined(self)) {
    return;
  }

  if(param_00 == "ch_daily_0") {
    thread maps\mp\gametypes\_hub_unk1::func_3010("10K", &"HUB_10K_CHALLENGE", undefined, -100, 1, 3);
  }

  if(param_00 == "ch_daily_1") {
    thread maps\mp\gametypes\_hub_unk1::func_3010("3HS", &"HUB_3HS_CHALLENGE", undefined, -70, 1, 3);
  }
}

func_7D56(param_00) {
  if(!isDefined(self)) {
    return;
  }

  maps\mp\gametypes\_hud_util::func_209E(param_00, 0);
  maps\mp\gametypes\_hud_util::func_209F(param_00, 1);
}

func_71F4(param_00, param_01, param_02) {}

func_74E8(param_00) {}

func_74AC(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("vendorChangeAnimState");
  if(param_01) {
    for(;;) {
      if(function_0279(param_00)) {
        break;
      }

      param_00 scriptmodelplayanim(param_00.var_0ED2["idle"], "animEnded");
      param_00 waittillmatch("animEnded");
      if(function_0279(param_00)) {
        break;
      }

      var_02 = common_scripts\utility::func_7A33(param_00.var_0ED2["allTwitch"]);
      param_00 scriptmodelplayanim(var_02, "animEnded");
      param_00 waittillmatch("animEnded");
    }

    return;
  }

  for(;;) {
    if(function_0279(param_00)) {
      break;
    }

    param_00 scriptmodelplayanim(param_00.var_0ED2["idle"], "animEnded");
    param_00 waittillmatch("animEnded");
  }
}

func_7200(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  if(!isDefined(param_00.var_931A) || param_00.var_931A != param_01) {
    if(!isDefined(param_00.var_0ED2[param_01])) {
      return;
    }

    param_00 notify("vendorChangeAnimState");
    if(param_01 == "idle" && isDefined(param_00.var_0ED2["idleTwitch"])) {
      if(!isDefined(param_03)) {
        param_03 = 0;
      }

      thread func_74AC(param_00, param_03);
    } else {
      param_00 scriptmodelplayanim(param_00.var_0ED2[param_01], "animEnded");
    }

    param_00.var_931A = param_01;
    if(isDefined(param_02)) {
      param_00 waittillmatch("animEnded");
      if(!function_0279(param_00)) {
        func_7200(param_00, param_02);
      }
    }
  }
}

func_71F3() {
  level endon("game_ended");
  self endon("fake_prestige");
  if(!isDefined(self.var_831A)) {
    return;
  }

  for(;;) {
    for(var_00 = 0; var_00 < self.var_0ED2["vendor"].size; var_00++) {
      for(var_01 = 1; var_01 < self.var_0ED2["vendor"][var_00].size; var_01++) {
        for(var_02 = 0; var_02 < 2; var_02++) {
          self method_8495(self.var_0ED2["vendor"][var_00][0], self.var_831A.var_0116, self.var_831A.var_001D, "animEnded");
          foreach(var_04 in self.var_6DFB) {
            if(!isDefined(var_04) || !isDefined(self.var_0ED2[var_04.var_0109])) {
              continue;
            }

            if(!isDefined(self.var_0ED2[var_04.var_0109][var_00]) || !isDefined(self.var_0ED2[var_04.var_0109][var_00][0])) {
              continue;
            }

            if(isDefined(var_04.var_5717) && !var_04.var_5717) {
              var_04.var_5717 = 1;
              var_04 method_8495(self.var_0ED2[var_04.var_0109][var_00][0], self.var_831A.var_0116, self.var_831A.var_001D);
              continue;
            }

            var_04 method_8495(self.var_0ED2[var_04.var_0109][var_00][0], self.var_831A.var_0116, self.var_831A.var_001D);
          }

          self waittillmatch("end", "animEnded");
        }

        self method_8495(self.var_0ED2["vendor"][var_00][var_01], self.var_831A.var_0116, self.var_831A.var_001D, "animEnded");
        foreach(var_04 in self.var_6DFB) {
          if(!isDefined(var_04)) {
            continue;
          }

          if(!isDefined(self.var_0ED2[var_04.var_0109][var_00]) || !isDefined(self.var_0ED2[var_04.var_0109][var_00][var_01])) {
            continue;
          }

          if(isDefined(var_04.var_5717)) {
            var_04.var_5717 = 0;
          }

          var_04 method_8495(self.var_0ED2[var_04.var_0109][var_00][var_01], self.var_831A.var_0116, self.var_831A.var_001D);
        }

        if(isDefined(self.var_0EAC[self.var_0ED2["vendor"][var_00][var_01]])) {
          [[self.var_0EAC[self.var_0ED2["vendor"][var_00][var_01]].var_3F02]](self.var_0EAC[self.var_0ED2["vendor"][var_00][var_01]].var_0F5D);
        }

        self waittillmatch("end", "animEnded");
      }
    }
  }
}

func_4AE5() {
  level endon("game_ended");
  if(!isDefined(self.var_831A)) {
    return;
  }

  for(;;) {
    self waittill("startCrateUnloadEvent");
    var_00 = spawn("script_model", (0, 0, 0));
    var_00 setModel("hub_lootcrate_b");
    var_00 method_8495(self.var_2760[1][0], self.var_831A.var_0116, self.var_831A.var_001D);
    for(var_01 = 2; var_01 < self.var_2761.size; var_01++) {
      var_02 = spawn("script_model", (0, 0, 0));
      if(self.var_2761[var_01] == "ambient_costume") {
        var_02 maps\mp\gametypes\_hub_unk1::func_8627();
      } else {
        var_02 setModel(self.var_2761[var_01]);
      }

      var_02 method_8495(self.var_2760[var_01], self.var_831A.var_0116, self.var_831A.var_001D, "animEnded");
      var_02 thread maps\mp\gametypes\_hub_unk1::func_2DD4("animEnded");
      if(self.var_2761[var_01] == "vehicle_usa_trans_cckw_base_hub") {
        var_02 lib_0378::func_8D74("truck_unload");
      }
    }

    self waittill("startCrateLoadEvent");
    var_00 method_8495(self.var_2749[4], self.var_831A.var_0116, self.var_831A.var_001D);
    for(var_01 = 1; var_01 < self.var_274A.size; var_01++) {
      var_02 = spawn("script_model", (0, 0, 0));
      if(self.var_274A[var_01] == "ambient_costume") {
        var_02 maps\mp\gametypes\_hub_unk1::func_8627();
      } else {
        var_02 setModel(self.var_274A[var_01]);
      }

      var_02 method_8495(self.var_2749[var_01], self.var_831A.var_0116, self.var_831A.var_001D, "animEnded");
      var_02 thread maps\mp\gametypes\_hub_unk1::func_2DD4("animEnded");
      if(self.var_274A[var_01] == "vehicle_usa_trans_cckw_base_hub") {
        var_02 lib_0378::func_8D74("truck_load");
      }
    }
  }
}

func_4AB4(param_00, param_01) {
  level endon("game_ended");
  if(!isDefined(self.var_831A)) {
    return;
  }

  for(;;) {
    param_00 method_8495(self.var_0ED2["crateStealer"][0][0], self.var_831A.var_0116, self.var_831A.var_001D);
    param_01 method_8495(self.var_0ED2["crateToSteal"][0][0], self.var_831A.var_0116, self.var_831A.var_001D);
    param_00 waittill("startCrateStealEvent");
    param_00 method_8495(self.var_0ED2["crateStealer"][0][1], self.var_831A.var_0116, self.var_831A.var_001D);
    param_01 method_8495(self.var_0ED2["crateToSteal"][0][1], self.var_831A.var_0116, self.var_831A.var_001D);
    self waittillmatch("end", "animEnded");
  }
}

func_771D(param_00, param_01) {
  level endon("game_ended");
  if(isDefined(level.var_744A) && isDefined(level.var_744A[0]) && level.var_744A[0].var_0109 == "SHG-ABurt") {
    level.var_744A[0] iclientprintln(param_00 + " playing: " + param_01);
  }
}

func_4B03(param_00, param_01, param_02) {
  level endon("game_ended");
  self endon("death");
  if(param_00) {
    var_03 = "first_greeting";
  } else if(var_03.var_7A65 < 12) {
    var_03 = "common_greeting";
  } else {
    var_03 = "prestige_greeting";
  }

  thread maps\mp\gametypes\_hub_unk1::func_8636(45, "react_afk", ["react_neg", "react_pos"]);
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(self.var_0ED2["vendorStage"][var_03])) {
      break;
    }

    if(isarray(self.var_0ED2["vendorStage"][var_03])) {
      var_04 = randomint(self.var_0ED2["vendorStage"][var_03].size);
      self method_8495(self.var_0ED2["vendorStage"][var_03][var_04], self.var_0116, (0, 210, 0), "idle");
      foreach(var_06 in param_01) {
        if(!isDefined(var_06) || !isDefined(self.var_0ED2[var_06.var_0109 + "Stage"][var_03][var_04])) {
          continue;
        }

        var_06 scriptmodelplayanim(self.var_0ED2[var_06.var_0109 + "Stage"][var_03][var_04]);
      }
    } else {
      self method_8495(self.var_0ED2["vendorStage"][var_03], self.var_0116, (0, 210, 0), "idle");
      foreach(var_06 in param_01) {
        if(!isDefined(var_06) || !isDefined(self.var_0ED2[var_06.var_0109 + "Stage"][var_03])) {
          continue;
        }

        var_06 scriptmodelplayanim(self.var_0ED2[var_06.var_0109 + "Stage"][var_03]);
      }
    }

    var_03 = common_scripts\utility::func_A715("idle", "react_neg", "react_pos", "react_afk");
    if(var_03 != "idle") {
      thread maps\mp\gametypes\_hub_unk1::func_8636(45, "react_afk", ["react_neg", "react_pos"]);
    }
  }
}

func_8A47(param_00) {
  level endon("game_ended");
  var_01 = [];
  if(!isDefined(self.var_914E)) {
    return var_01;
  }

  foreach(var_03 in self.var_914E) {
    var_04 = spawn("script_model", (0, 0, 0));
    var_04 setModel(var_03.var_0106);
    if(!var_01.size) {
      var_04 linkto(self, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    } else {
      var_04 linkto(self, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
    }

    var_04.var_0109 = var_03.var_0109;
    var_04 method_805C();
    var_04 showtoclient(param_00);
    var_01[var_01.size] = var_04;
  }

  thread func_2D42(var_01);
  param_00 thread func_2D41(var_01, self);
  return var_01;
}

func_2D42(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  foreach(var_02 in param_00) {
    var_02 delete();
  }
}

func_2D41(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("death");
  self waittill("disconnect");
  foreach(var_03 in param_00) {
    var_03 delete();
  }
}

func_37C0(param_00) {
  if(isDefined(self.var_9FB4) && self.var_9FB4 < 4 && isDefined(param_00.var_A405) && param_00.var_A405 != level.var_4BF3 && param_00.var_A405 != level.var_781C) {
    self.var_5734 = 0;
    return;
  }

  if(level.var_4F50 && param_00.var_A405 == level.var_781C) {
    self.var_5734 = 0;
    return;
  }

  self.var_5734 = 1;
  self.var_53FE = param_00.var_A405;
  self.var_53FF = param_00;
}

func_38F8(param_00) {
  self.var_5734 = 0;
  self.var_53FE = undefined;
  self.var_53FF = undefined;
}

func_3E26(param_00) {
  foreach(var_02 in param_00) {
    var_02.var_0018 = 1;
    var_02 setwaypoint(1, 1, 0, 0, 0, 0, 0, 0);
  }

  foreach(var_05 in self.var_A406) {
    var_05 setwaypoint(1, 1, 0, 0, 0, 0, 0, 0);
    if(!isDefined(var_05.var_5798) || !var_05.var_5798) {
      var_05.var_0018 = 1;
      var_05 thread maps\mp\gametypes\_hub_unk1::func_77B4(0.5, 0.5, 1, 0.5, undefined, self, 1, 0);
    }
  }
}

func_7DF6(param_00) {
  foreach(var_02 in param_00) {
    if(func_A40A(var_02.var_A40E)) {
      var_02.var_0018 = 1;
    } else {
      var_02.var_0018 = 0;
    }

    var_02 setwaypoint(1, 1, 0, 0, 0, 0, 0, 1);
  }

  foreach(var_05 in self.var_A406) {
    var_05 setwaypoint(1, 1, 0, 0, 0, 0, 0, 1);
    if(!isDefined(var_05.var_5798) || !var_05.var_5798) {
      var_05.var_0018 = 1;
      var_05 thread maps\mp\gametypes\_hub_unk1::func_77B4(0.5, 0.5, 1, 0.5, undefined, self, 1, 0);
    }
  }
}

func_8C01(param_00) {
  if(!isDefined(param_00) || param_00.size < 1) {
    return;
  }

  foreach(var_02 in param_00) {
    var_02.var_0018 = 1;
  }

  foreach(var_05 in self.var_A406) {
    if(!isDefined(var_05.var_5798) || !var_05.var_5798) {
      var_05.var_0018 = 1;
      var_05 thread maps\mp\gametypes\_hub_unk1::func_77B4(0.5, 0.5, 1, 0.5, undefined, self, 1, 0);
    }
  }
}

func_4D0C(param_00) {
  if(!isDefined(param_00) || param_00.size < 1) {
    return;
  }

  foreach(var_02 in param_00) {
    if(var_02.var_0018 > 0) {
      var_02.var_0018 = 0;
    }
  }

  foreach(var_05 in self.var_A406) {
    if(isDefined(var_05.var_5798) && var_05.var_5798) {
      var_05 notify("pulseDurationEnded");
      var_05.var_5798 = 0;
      var_05.var_0018 = 0;
    }
  }
}

func_A40A(param_00) {
  foreach(var_02 in self.var_A406) {
    if(isDefined(var_02) && var_02.var_A40E == param_00) {
      return 1;
    }
  }

  return 0;
}

func_8A5E(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  self.var_0018 = 0;
  self setwaypoint(0, 1, 0, 0, 0, 0, 0, param_00);
}

func_2839(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_00) || !isDefined(param_00.var_0116)) {
    return;
  }

  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(param_05)) {
    param_05 = 0;
  }

  var_06 = newclienthudelem(self);
  var_06 setshader(param_01);
  var_06 func_8A5E(param_04);
  if(param_05) {
    var_06.var_01D3 = 0;
    var_06.var_01D7 = 0;
    var_06.var_01D9 = 0 + param_03;
    var_06 settargetent(param_00, "tag_origin");
  } else {
    var_06.var_01D3 = param_00.var_0116[0];
    var_06.var_01D7 = param_00.var_0116[1];
    var_06.var_01D9 = param_00.var_0116[2] + 90 + param_03;
  }

  var_06.var_A40E = param_00.var_9FEB;
  var_06.var_35B2 = "icon";
  var_06.var_6E74 = level.var_A012;
  var_06.var_6E74 maps\mp\gametypes\_hud_util::func_09A6(var_06);
  var_06.var_0109 = param_01;
  self.var_A40B = common_scripts\utility::func_0F6F(self.var_A40B, var_06);
  var_06.var_0018 = 1;
  if(isDefined(param_02) && param_02) {
    var_07 = newclienthudelem(self);
    var_07 setshader("ui_vendor_alert_icon");
    var_07 func_8A5E();
    if(param_05) {
      var_07.var_01D3 = 0;
      var_07.var_01D7 = 0;
      var_07.var_01D9 = 0 + param_03;
      var_07 settargetent(param_00, "tag_origin");
    } else {
      var_07.var_01D3 = param_00.var_0116[0];
      var_07.var_01D7 = param_00.var_0116[1];
      var_07.var_01D9 = param_00.var_0116[2] + 90 + param_03;
    }

    var_07.var_0018 = 1;
    var_07 thread maps\mp\gametypes\_hub_unk1::func_77B4(0.5, 0.5, 1, 0.5, undefined, self, 1, 0);
    var_07.var_A40E = param_00.var_9FEB;
    var_07.var_35B2 = "icon";
    var_07.var_6E74 = level.var_A012;
    var_07.var_6E74 maps\mp\gametypes\_hud_util::func_09A6(var_07);
    var_07.var_0109 = param_01 + "Alert";
    self.var_A406[self.var_A406.size] = var_07;
  }

  return var_07;
}

func_27CC() {
  self.var_A40B = [];
  self.var_A406 = [];
}

func_4B55() {
  var_00 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "challengeState", "ch_daily_0");
  if(var_00 == 0) {
    return 1;
  }

  if(var_00 == 1) {
    return 1;
  }

  var_01 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "challengeState", "ch_daily_1");
  if(var_01 == 0) {
    return 1;
  }

  if(var_01 == 1) {
    return 1;
  }

  return 0;
}

func_5358() {
  level endon("game_ended");
  for(;;) {
    self rotateby((360, 0, 0), 1);
    wait(1);
  }
}

func_5359() {
  level endon("game_ended");
  for(;;) {
    self rotateby((-360, 0, 0), 1);
    wait(1);
  }
}

func_76B1(param_00) {
  self endon("disconnect");
  maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 1, 0, 1);
  maps\mp\gametypes\_hub_unk1::func_721A("mp_emote_salute", 1);
  self method_8627("mp_hub_vendor_mix");
  var_01 = spawnStruct();
  var_01.var_0116 = (0, 2700, -40);
  var_01.var_001D = (0, 0, 0);
  var_02 = spawn("script_model", var_01.var_0116);
  var_03 = undefined;
  var_04 = undefined;
  if(param_00 >= 5) {
    var_03 = spawn("script_model", var_01.var_0116);
  }

  if(param_00 == 10) {
    var_04 = spawn("script_model", var_01.var_0116);
  }

  var_05 = "usa_fighter_thunderbolt";
  switch (param_00) {
    case 1:
      var_05 = "usa_fighter_thunderbolt";
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
      var_05 = "usa_fighter_thunderbolt_fly_camo";
      break;

    default:
      var_05 = "usa_fighter_thunderbolt";
      break;
  }

  var_02 setModel(var_05);
  var_02 method_8495("mp_hub_prestige_flyby_01_plane_01", var_01.var_0116, var_01.var_001D);
  var_02 lib_0378::func_8D74("prestige_fanfare_aircraft_flying");
  if(isDefined(var_03)) {
    var_03 setModel(var_05);
    var_03 method_8495("mp_hub_prestige_flyby_01_plane_02", var_01.var_0116, var_01.var_001D);
    var_03 lib_0378::func_8D74("prestige_fanfare_aircraft_flying");
  }

  if(isDefined(var_04)) {
    var_04 setModel(var_05);
    var_04 method_8495("mp_hub_prestige_flyby_01_plane_03", var_01.var_0116, var_01.var_001D);
    var_04 lib_0378::func_8D74("prestige_fanfare_aircraft_flying");
  }

  activateclientexploder(100 + 10 * param_00 - 1);
  lib_0378::func_8D74("prestige_fireworks_start", param_00);
  playFXOnTag(level.var_0611["prestige_flag_" + param_00], self, "tag_origin");
  lib_0378::func_8D74("prestige_level_up_flag_start");
  wait 0.05;
  while(self getplayerscurrentanimname(0) == "mp_emote_salute") {
    wait(0.1);
  }

  playFXOnTag(level.var_0611["prestige_icon_" + param_00], self, "tag_origin");
  maps\mp\gametypes\_hub_unk1::func_A04C();
}

func_1157(param_00) {
  if(!isDefined(self.var_76B2)) {
    self.var_76B2 = spawn("script_model", self.var_0116);
    self.var_76B2 setModel("usa_ctf_flag_physics_attach");
    self.var_76B2 method_8449(self, "J_spine4", (0, 0, 0), (0, 0, 0));
    self.var_76B2 method_805B();
    thread func_2E41(self.var_76B2);
  }
}

func_2E41(param_00) {
  level endon("game_ended");
  self waittill("disconnect");
  param_00 delete();
}

func_7D60(param_00) {
  maps\mp\gametypes\_hud_util::func_209F(param_00, 1);
  maps\mp\gametypes\_hud_util::func_209E(param_00, 0);
  self.var_20A9[param_00] = 1;
}