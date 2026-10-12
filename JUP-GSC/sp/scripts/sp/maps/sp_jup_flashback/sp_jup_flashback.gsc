/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\sp_jup_flashback\sp_jup_flashback.gsc
*****************************************************************/



#using script_32876a523f324870;
#using script_445e326aa3526cc2;
#using script_4ab4bd3ef85fb34c;
#using script_5d0aad069db3eeb8;
#using script_5d5ed488e7b712ab;
#using script_691cea1edc5b7e41;
#using script_6d2f8d162f859350;
#using script_71b48ffe76b07d2;
#using script_a6f526f54ee52f7;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\ai_armor;
#using scripts\sp\anim;
#using scripts\sp\audio;
#using scripts\sp\fakeactor;
#using scripts\sp\load;
#using scripts\sp\loot;
#using scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_fx;
#using scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_lighting;
#using scripts\sp\player;
#using scripts\sp\player\ally_equipment;
#using scripts\sp\starts;
#using scripts\sp\utility;
#namespace sp_jup_flashback;

function main() {
  setdvarifuninitialized(@ "hash_89c443a4a13df521", 1);
  namespace_455cd637c4d3cb72::main();
  sp_jup_flashback_fx::main();
  fb_lighting::main();
  namespace_813e4ba6b29c9ad8::main();
  namespace_ccad715273481961::main();
  setsaveddvar(@ "hash_1527e5f9da22220c", 30);
  setsaveddvar(@ "hash_bac4e85db9c2439f", 60);
  precache();
  preload();
  startpoints();
  thread function_ed42b1f10b7c5c0c();
  audio::set_audio_level_fade_time(0);
  scripts\sp\load::main();
  function_d6545f0dac240e32();
  thread hints();
  initplayer();
  level.civ_only_flash = 0;
  level.var_a1682f725fe525cc = 1;
  add_global_spawn_function("axis", &function_2af739d19d5426cd);
  flag_init("introscreen_start_wait");
  level thread function_b1e3c22d0bf5b7b6();
  level.debug_badpath = 1;
  waitframe();
  thread objectives();
}

function startpoints() {
  initialize_transients();
  level.var_4291dad1008f93e6 = ["sp_jup_flashback_upper_westside_tr", "sp_jup_flashback_lower_westside_tr", "sp_jup_flashback_suburbs_tr", "sp_jup_flashback_ext_plaza_tr", "sp_jup_flashback_vista_tr"];
  level.var_a67ce3c274f5544e = ["sp_jup_flashback_lower_westside_tr", "sp_jup_flashback_suburbs_tr", "sp_jup_flashback_ext_plaza_tr", "sp_jup_flashback_vista_tr"];
  level.var_1cdebbdf0e614d2d = ["sp_jup_flashback_upper_westside_tr", "sp_jup_flashback_lower_westside_tr", "sp_jup_flashback_ext_plaza_tr"];
  level.var_cac0d6c867a55103 = ["sp_jup_flashback_ext_plaza_tr"];

  add_start("<dev string:x1c>", &function_ecf7a9662560a458, &function_4e660927b19f12a6, level.var_4291dad1008f93e6, undefined);
  add_start("<dev string:x31>", &function_a8a66b06c79dba9d, &function_5e10cf399d75048d, level.var_4291dad1008f93e6, &function_68a6dd38cd7f8f1d);
  add_start("<dev string:x45>", &function_976f2f5d255b2170, &function_7fea2bfdbc2b2d5e, level.var_4291dad1008f93e6, undefined);

  add_start("infil_intro", &function_b174136af07c1f9a, &function_45448beba0e951ac, level.var_4291dad1008f93e6, &function_68a6dd38cd7f8f1d);
  add_start("infil_exterior", &function_c35921bba378f25f, &function_3892ff81017d2d5b, level.var_4291dad1008f93e6, &function_99018d84375f7aa0);
  add_start("infil_garage", &function_de0444fdec5e5731, &function_b736dc843d9b00a1, level.var_4291dad1008f93e6, &function_8e91eb0fdf90a2ce);
  add_start("infil_stairs", &function_2eb23a246bdb786a, &function_1af348af75d2331c, level.var_4291dad1008f93e6, &function_d2a51882734ebb4d);
  add_start("shield_moment", &function_94c94ea48630e5ca, &function_d265cd707bc770fc, level.var_4291dad1008f93e6, &function_6b61f237a053c9ad);
  add_start("stadium_combat_enter", &function_489fd3094f4eb769, &function_f8489d92e5a8e479, level.var_4291dad1008f93e6, &function_e85c076ff6aa136);
  add_start("concourse_a", &function_d5667fa5953a9f50, &concourse_a_main, level.var_4291dad1008f93e6, &function_87d743691911c137);
  add_start("concourse_b", &function_854b7eb5a78ab6c5, &function_3b39efb880edc635, level.var_4291dad1008f93e6, &function_8fdffe00597d78a);
  add_start("concourse_c", &function_c223032eb5b41192, &concourse_c_main, level.var_4291dad1008f93e6, &function_6cbbdc09986c4aa5);
  add_start("concourse_d", &function_cd5719323cafb7e7, &function_e3cb183f20faf443, level.var_4291dad1008f93e6, &function_7014938de02d0f8);
  add_start("concourse_e", &function_f16596bfb23ae5f4, &function_79621f1fa4ebafa2, level.var_4291dad1008f93e6, &function_4fdd61a8778cf7f3);
  add_start("stadium_combat_stairs", &function_67451b211141e5ab, &function_6f9af4650b4c7647, level.var_4291dad1008f93e6, &function_decfda1efe2cb284);
  add_start("concourse_stairs_top", &namespace_3345ab597fd83308::function_81253f168d083e9f, &namespace_3345ab597fd83308::function_2f1b8471b511229b, level.var_4291dad1008f93e6, &namespace_3345ab597fd83308::function_abb9cfecff7e47e0);
  add_start("penthouse_floor", &namespace_3345ab597fd83308::function_7634214c5a6e0757, &namespace_3345ab597fd83308::function_f31c22483c77b393, level.var_4291dad1008f93e6, &namespace_3345ab597fd83308::function_64b178abc1f05288);
  add_start("penthouse_arrive", &namespace_3345ab597fd83308::function_fa1cebd2b668aa80, &namespace_3345ab597fd83308::function_4d32f716029af98e, level.var_4291dad1008f93e6, &namespace_3345ab597fd83308::function_46f0a3fe07c4cfc7);
  add_start("penthouse_bomb", &namespace_3345ab597fd83308::function_b09ce984fb9372d3, &namespace_3345ab597fd83308::function_fdabe0101feb30cf, level.var_4291dad1008f93e6, &namespace_3345ab597fd83308::function_cdd66098f777287c);
  add_start("penthouse_elevator", &namespace_3345ab597fd83308::function_262264ed43bd28f1, &namespace_3345ab597fd83308::function_9102ea8393f24961, level.var_4291dad1008f93e6, &namespace_3345ab597fd83308::function_e5430163f1ff288e);
  add_start("ambulance_crash", &function_af0a8347f91f668b, &function_9835a9c3e3bb25a7, level.var_4291dad1008f93e6, &function_da896f70a474264);
  add_start("ambulance_cinematic", &function_19dcebfa87749ed5, &function_12396386fb4393e5, level.var_4291dad1008f93e6, &function_9ab8eb99a319d0fa);
  add_start("makarov_escort_1", &function_6dc233293495d867, &function_c854aaef8a00d1c3, level.var_4291dad1008f93e6, &function_daabc49973090578);
  add_start("squeeze_through", &function_d89962c8032a1a89, &function_777f153f1d741519, level.var_4291dad1008f93e6, &function_71bd9fb25d978256);
  add_start("makarov_escort_2", &function_dde4441415c2c7d6, &function_b287a28ff875c4c8, level.var_4291dad1008f93e6, &function_76fee1bbca1cbd31);
  add_start("escort_stadium_exit", &function_2baa4207f261ebd4, &function_8dd8339057b31e02, level.var_4291dad1008f93e6, &function_5e1d3677756c3fd3);
  add_start("makarov_escort_3", &function_87efde534fc49cd9, &function_7ef72faa51a3bc49, level.var_4291dad1008f93e6, &function_530c0fcf8f478a46);
  add_start("exfil", &exfil_setup, &exfil_main, level.var_4291dad1008f93e6, &exfil_catchup);
  set_default_start("infil_intro");
}

function function_ed42b1f10b7c5c0c() {
  flag_wait("scriptables_ready");
  wait 1;
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  cinematicingameloop("sp_jup_flashback_screens_01", 1);
}

function function_d6545f0dac240e32() {
  while(!threatbiasgroupexists("allies")) {
    waitframe();
  }

  createthreatbiasgroup("fake_enemy");
  createthreatbiasgroup("ignore_fake_enemy");
  createthreatbiasgroup("attack_fake_enemy");
  createthreatbiasgroup("infil_allies");
  createthreatbiasgroup("attack_infil_allies");
  setignoremegroup("ignore_fake_enemy", "fake_enemy");
  setignoremegroup("fake_enemy", "ignore_fake_enemy");
  setignoremegroup("attack_fake_enemy", "allies");
  setignoremegroup("allies", "attack_fake_enemy");
  setignoremegroup("allies", "attack_infil_allies");
  setignoremegroup("axis", "fake_enemy");
  setignoremegroup("fake_enemy", "axis");
}

function function_2af739d19d5426cd() {
  if(!flag("player_at_vip_floor")) {
    self.goalheight = 90;
  }

  thread record_flashed();
  thread namespace_47819225b08b445d::navrepulsorremoveondeath(70, "neutral");
}

function record_flashed() {
  self endon("death");

  while(true) {
    self waittill("doFlashBanged");
    level.var_7d2f398b2e524791 = gettime();
  }
}

function function_9e32cd140c7521d0() {
  if(isendstr(self.classname, "rov")) {
    return;
  }

  self endon("death");

  while(!isDefined(self.battlechatter)) {
    waitframe();
  }

  while(!isDefined(self.battlechatter.npcid)) {
    waitframe();
  }

  set_ai_bcvoice(#"konni");
}

function hints() {
  add_hint_string("mak_direct_ADS", "Press [{+actionslot1}] to direct Makarov");
  add_hint_string("mak_direct_grab", "Press [{+speed_throw}] to hold Makarov still");
  add_hint_string("mak_melee_forward", "Press [{+melee}] to direct Makarov forward.");
  add_hint_string("control", "Make him listen!");
  add_hint_string("mak_move", &"SP_JUP_FLASHBACK/MAK_MOVE", &namespace_83c86e626c8ec2af::function_935e703667d646a8);
  add_hint_string("mak_move_dance", &"SP_JUP_FLASHBACK/MAKAROV_SHOOT_CLOSE_HINT", &namespace_83c86e626c8ec2af::function_935e703667d646a8);
  add_hint_string("mak_move_button", &"SP_JUP_FLASHBACK/MAK_MOVE_BUTTON", &namespace_83c86e626c8ec2af::function_935e703667d646a8);
  add_hint_string("flashlight_on", &"SP_JUP_FLASHBACK/FLASHLIGHT_ON", &namespace_47819225b08b445d::function_edba0687176c53c1);
  add_hint_string("select_fire_mode", &"SP_JUP_FLASHBACK/SELECT_FIRE_MODE");
  add_hint_string("tutorial_weapon_mount", &"SP_JUP_FLASHBACK/TUT_WEAPON_MOUNT");
  add_hint_string("show_objectives", &"SP_JUP_FLASHBACK/HINT_SHOW_OBJECTIVES");
}

function preload() {
  setdvarifuninitialized(@ "hash_a262744b5ef47a55", 0);
  thread namespace_b8a89d525f3c95ba::escort_cover(0);
  ally_equipment::ally_equipment_init();
  var_ac9a315436d61250 = getEnt("ambulance_interior", "targetname");
  var_ac9a315436d61250 hide();
  prop = getEnt("ambulance_dangle", "targetname");

  if(isDefined(prop)) {
    prop hide();
  }
}

function setplayerviewmodel(viewmodel, legmodel, shadowmodel) {
  if(isDefined(viewmodel)) {
    level.player setviewmodel(viewmodel);
    level.player utility::function_c4ec7d985422ce24(viewmodel);
  }

  if(isDefined(legmodel)) {
    level.player setlegsmodel(legmodel);
  }

  if(isDefined(shadowmodel)) {
    level.player setshadowmodel(shadowmodel);
  }
}

function precache() {
  precachemodel("head_sc_m_ahmadzai_civ_nofacial");
  precachemodel("head_sc_m_androsov_civ_nofacial");
  precachemodel("head_sc_m_sharipov_civ_nofacial");
  precachemodel("head_sc_m_vozhyuk_civ_nofacial");
  precachemodel("head_sc_m_arakelyan_civ_w_hair_nofacial");
  precachemodel("head_sc_m_mrehin_civ_nofacial");
  precachemodel("head_sc_m_alameer_civ_nofacial");
  precachemodel("body_c_jup_sp_civ_soccerfan_f_01_uk");
  precachemodel("body_c_jup_sp_civ_soccerfan_f_01_russia");
  precachemodel("head_c_jup_sc_m_sharipov_flashback");
  precachemodel("head_sc_f_mostafavi_civ_flashback");
  precachemodel("head_sc_f_stokes_civ_flashback");
  precachemodel("c_jup_body_civ_london_female_4_1");
  precachemodel("head_sc_m_colvin_civ_nofacial");
  precachemodel("head_sp_opforce_grunt_var_03_var_1_civ_nofacial");
  precachemodel("head_sc_f_alicea_civ_nofacial");
  precachemodel("head_sc_f_wetherbee_civ_nofacial");
  precachemodel("head_sc_f_stokes_civ_nofacial");
  precachemodel("head_sc_f_daly_civ_nofacial");
  precachemodel("head_sc_f_dizon_var_1_nofacial");
  precachemodel("head_sc_f_anisimova_civ_nofacial");
  precachemodel("head_sc_f_babayeva_civ_nofacial");
  precachemodel("head_sc_f_chivikina_civ_nofacial");
  precachemodel("head_sc_f_mostafavi_civ_nofacial");
  precachemodel("tag_laser");
  precachemodel("tag_origin_only_collision");
  precachemodel("civ_doctor_male_body");
  precachemodel("head_sc_m_ahmadzai_civ");
  precachemodel("body_civ_russian_police_officer");
  precachemodel("hat_civ_russian_police_officer_1");
  precachemodel("hat_civ_russian_police_officer_2");
  precachemodel("c_jup_head_hero_makarov");
  precachemodel("body_c_jup_sp_villain_makarov_paramedic");
  precachemodel("head_sc_m_alameer_civ");
  precachemodel("head_sc_m_mrehin_civ");
  precachemodel("head_sc_m_yurteri_civ");
  precachemodel("veh8_civ_lnd_palfa_static_ambulance_ukraine");
  precacheshader("hud_icon_equipment_flashlight");
  precacheshader("hud_icon_equipment_flashlight_on");
  precacheshader("hud_icon_equipment_flashlight_off");
  precachemodel("body_c_jup_sp_hero_soap_bravo");
  precachemodel("head_hero_soap_lod");
  precachemodel("vm_c_jup_sp_hero_soap_bravo");
  precachemodel("electronics_smartphone_01");
  precachemodel("body_civ_embassy_ambassador");
  precachemodel("body_civ_embassy_office_worker_female_2_2");
  precachemodel("body_c_jup_sp_civ_soccerfan_f_02_russia");
  precachemodel("veh9_civ_lnd_suv_overland_2016_tech_mirror_r");
  precachemodel("misc_wm_smartphone_civilian_canal");
  precachemodel("misc_vm_halligan_tool_cp");

  if(isDefined(level._effect) && !isDefined(level._effect["vfx_helmet_tier3"])) {
    ai_armor::precache();
  }
}

function initialize_transients() {
  transient_init("sp_jup_flashback_upper_westside_tr");
  transient_init("sp_jup_flashback_lower_westside_tr");
  transient_init("sp_jup_flashback_suburbs_tr");
  transient_init("sp_jup_flashback_ext_plaza_tr");
  transient_init("sp_jup_flashback_vista_tr");
}

function objectives() {
  switch (level.start_point) {
    case #"hash_195336db21f3f3cc":
    case #"hash_7038dec66d8275be":
    case #"hash_bf8c4a83bd20e910":
    case #"hash_d4721293604cd3bf":
      objective_add("stadium_infil", "current", undefined, &"SP_JUP_FLASHBACK/OBJ_STADIUM_INFIL");
      flag_wait("player_exited_infil_vehicle");
      function_e203246cabf905f7("stadium_infil");
    case #"hash_7b25c0e690394dc8":
      if(!objective_exists("stadium_infil")) {
        objective_add("stadium_infil", "current", undefined, &"SP_JUP_FLASHBACK/OBJ_STADIUM_INFIL");
        flag_wait("player_exited_infil_vehicle");
        function_e203246cabf905f7("stadium_infil");
      }

      objective_add("stadium_stairs", "current", undefined, &"SP_JUP_FLASHBACK/OBJ_STADIUM_STAIRS");
      flag_wait_all("slaughter_police_dead", "infil_stairs_police_kill_scene_done");
      function_e203246cabf905f7("stadium_stairs");
    case #"hash_c8afe1751edbd795":
      while(!isDefined(level.price)) {
        waitframe();
      }

      if(objective_exists("stadium_concourse_enter")) {
        objective_update("stadium_concourse_enter", "current", level.price, &"SP_JUP_FLASHBACK/OBJ_CONCOURSE_ENTER");
      } else {
        objective_add("stadium_concourse_enter", "current", level.price, &"SP_JUP_FLASHBACK/OBJ_CONCOURSE_ENTER");
      }

      objective_set_z_offset("stadium_concourse_enter", 76);
      flag_wait("radflag_player_stairs_top");
      objectivestruct = getStruct("obj_concourse_enter", "targetname");
      objective_update("stadium_concourse_enter", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_CONCOURSE_ENTER");
      objective_set_z_offset("stadium_concourse_enter", 0);
      trigger_wait_targetname("trigger_concourse_start");
      function_e203246cabf905f7("stadium_concourse_enter");
    case #"hash_982c42f762457914":
    case #"hash_fd8e238c0726d166":
      objectivestruct = getStruct("struct_objective_concourse_a", "targetname");
      objective_add("stadium_combat", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STADIUM_COMBAT");
      flag_wait("trigger_concourse_a");
    case #"hash_fd8e228c0726cfd3":
      objectivestruct = getStruct("struct_objective_concourse_b", "targetname");

      if(objective_exists("stadium_combat")) {
        objective_update("stadium_combat", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STADIUM_COMBAT");
      } else {
        objective_add("stadium_combat", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STADIUM_COMBAT");
      }

      flag_wait("trigger_concourse_b");
    case #"hash_fd8e218c0726ce40":
      objectivestruct = getStruct("struct_objective_concourse_c", "targetname");

      if(objective_exists("stadium_combat")) {
        objective_update("stadium_combat", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STADIUM_COMBAT");
      } else {
        objective_add("stadium_combat", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STADIUM_COMBAT");
      }

      flag_wait("trigger_concourse_c");
    case #"hash_fd8e288c0726d945":
      objectivestruct = getStruct("struct_objective_concourse_d", "targetname");

      if(objective_exists("stadium_combat")) {
        objective_update("stadium_combat", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STADIUM_COMBAT");
      } else {
        objective_add("stadium_combat", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STADIUM_COMBAT");
      }

      flag_wait("trigger_concourse_e");
    case #"hash_fd8e278c0726d7b2":
      objectivestruct = getStruct("struct_objective_concourse_e", "targetname");

      if(objective_exists("stadium_combat")) {
        objective_update("stadium_combat", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STADIUM_COMBAT");
      } else {
        objective_add("stadium_combat", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STADIUM_COMBAT");
      }

      flag_wait("concourse_e_boss_dead");
      function_e203246cabf905f7("stadium_combat");
    case #"hash_ff4c5ea8a67ff0d":
    case #"hash_212f1614ad3dcb9c":
      objectivestruct = getStruct("struct_objective_concourse_stairs", "targetname");
      objective_add("stadium_concourse_stairs", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STAIRWELL_SECURE_ENTRANCE");
      flag_wait("concourse_stairs_scene_enemies_dead");
      objectivestruct = getStruct("struct_objective_concourse_stairs_end", "targetname");
      objective_update("stadium_concourse_stairs", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_STAIRWELL_REACH_TOP_FLOOR");
      flag_wait_all("fourth_floor_hostage_scene_done", "fourth_floor_civ_kick_done");
      flag_wait("player_at_vip_floor");
      function_e203246cabf905f7("stadium_concourse_stairs");
    case #"hash_9241d955b8ccc075":
    case #"hash_9469a8394eaab386":
      objectivestruct = getStruct("struct_objective_penthouse", "targetname");
      objective_add("penthouse_floor", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_REACH_PENTHOUSE");
      flag_wait("player_in_penthouse");
      objectivestruct = getStruct("struct_objective_penthouse_interior", "targetname");
      objective_update("penthouse_floor", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_PENTHOUSE_SECURE_VIPS");
      flag_wait("penthouse_combat");
      objective_update("penthouse_floor", "current", objectivestruct.origin, &"SP_JUP_FLASHBACK/OBJ_PENTHOUSE_ELIMINATE_ENEMIES");
      flag_wait("penthouse_secure");
      function_e203246cabf905f7("penthouse_floor");
    case #"hash_cbc7930e380ac409":
      flag_wait("penthouse_bomb_scene_done");
    case #"hash_32f718a350e59b2f":
      elevator = {
        #origin: (25351, 4383, 30)
      };

      if(!objective_exists("penthouse_floor")) {
        objective_add("penthouse_floor", "current", elevator.origin, &"SP_JUP_FLASHBACK/OBJ_REACH_GARAGE");
      } else {
        objective_update("penthouse_floor", "current", elevator.origin, &"SP_JUP_FLASHBACK/OBJ_REACH_GARAGE");
      }

      flag_wait("player_entered_elevator");
      function_e203246cabf905f7("penthouse_floor");
    case #"hash_a095097f67493cf1":
      flag_wait("price_spawned");
      objective_add("makarov", "current", level.price, &"SP_JUP_FLASHBACK/OBJ_AMBULANCE_SEARCH");
      objective_set_z_offset("makarov", 76);

      while(!isDefined(level.ambulance_interact)) {
        wait 0.3;
      }

      objective_remove_all_locations("makarov");
      objective_update("makarov", undefined, level.ambulance_interact.origin + (0, 0, 10));
      flag_wait("ambulance_player_interact");
      objective_remove_all_locations("makarov");
    case #"hash_71d70f70fb8f37a3":
      flag_wait("ambulance_cinematic_done");
    case #"hash_c01fc52a93ca234f":
      if(!objective_exists("makarov")) {
        objective_add("makarov", "current", undefined, "");
      }

      flag_wait("makarov_escort1_begin");
      objective_remove_all_locations("makarov");
      objective_update("makarov", "current", level.makarov, &"SP_JUP_FLASHBACK/OBJ_MAKAROV_ESCORT");
      objective_set_z_offset("makarov", 76);
    case #"hash_677d0a6457d9a9f1":
    case #"hash_c01fc62a93ca24e2":
      flag_wait("mak_escort2_begin");

      if(!objective_exists("makarov")) {
        objective_add("makarov", "current", level.makarov, &"SP_JUP_FLASHBACK/OBJ_MAKAROV_ESCORT");
        objective_set_z_offset("makarov", 76);
      }

      flag_wait("escort2_done");
    case #"hash_199c85364a8785a2":
      if(!objective_exists("makarov")) {
        objective_add("makarov", "current", level.makarov, &"SP_JUP_FLASHBACK/OBJ_MAKAROV_ESCORT");
        objective_set_z_offset("makarov", 76);
      }

      while(!isDefined(level.gate_interact)) {
        waitframe();
      }

      objective_remove_all_locations("makarov");
      objective_update("makarov", "current", level.gate_interact.origin, &"SP_JUP_FLASHBACK/OBJ_GATE_OPEN");
      objective_set_z_offset("makarov", 15);
      flag_wait("escort_gate_complete");
    case #"hash_c01fc72a93ca2675":
      if(!objective_exists("makarov")) {
        objective_add("makarov", "current", level.makarov, &"SP_JUP_FLASHBACK/OBJ_MAKAROV_ESCORT");
      }

      objective_remove_all_locations("makarov");
      objective_update("makarov", "current", undefined, &"SP_JUP_FLASHBACK/OBJ_SECURE_PARKING_LOT");
      objective_set_z_offset("makarov", 76);
      flag_wait("lz_clear");
    case #"hash_7c31479cf04292f":
      if(!objective_exists("makarov")) {
        objective_add("makarov", "current", level.makarov, &"SP_JUP_FLASHBACK/OBJ_MAKAROV_ESCORT");
      }

      objective_update("makarov", "current", (28634.5, -3447.5, -864), &"SP_JUP_FLASHBACK/OBJ_MEET_PRICE_HELI");
      flag_wait("exfil_heli_interact");
      wait 1;
      spot = level.exfil_heli_interact.origin + (0, 0, 65);
      objective_update("makarov", "current", spot, &"SP_JUP_FLASHBACK/OBJ_BOARD_CHOPPER");
      flag_wait("exfil_scene_started");
      objective_complete("makarov");
      break;
  }
}

function function_e203246cabf905f7(name) {
  objective_complete(name);
  objective_remove(name);
}

function initplayer() {
  function_953abaf49e83f2e4();
  setplayerviewmodel("vm_c_jup_sp_hero_soap_bravo");
  level.player scripts\sp\player::set_player_max_health(80);
  level.player scripts\sp\player::scale_player_death_shield_duration(0.5);
  level.player utility::function_c4ec7d985422ce24("vb_c_jup_sp_hero_soap_bravo");
}

function function_953abaf49e83f2e4() {
  var_2f7136cf6c5b1b14 = ["frag", "flash", "smoke", "concussion_grenade_sp", "thermite_sp", "molotov"];
  offhandprecache(var_2f7136cf6c5b1b14);
  level.player setperk("specialty_pistoldraw", 1);
  level.player setperk("specialty_fastreload", 1);

  if(scripts\sp\starts::is_after_start("infil_stairs") || level.start_point == "concourse_civilian_debug" || level.start_point == "branching_anim_test" || level.start_point == "civ_ballistics_debug") {
    level.player namespace_47819225b08b445d::function_5407d3d400318b45();
  }

  thread loot::createnotification("armorplate");
  level.player delaythread(0.5, &function_e42c9c6745236d99);
  utility::add_extra_autosave_check("Player Grenades", &function_45a8c0a949b2fcd1, "Player has thrown a grenade!");
}

function function_e42c9c6745236d99() {
  level.player endon("death");
  level endon("doing_firemode_hint");

  while(isnullweapon(level.player getcurrentprimaryweapon())) {
    waitframe();
  }

  var_7c9b3b1614663ec9 = level.player getcurrentprimaryweapon();
  var_d93f43fabf2d7499 = namespace_47819225b08b445d::function_5c40243f3153be01(var_7c9b3b1614663ec9);
  var_a9bf99cbff9b5384 = level.player isalternatemode(var_7c9b3b1614663ec9, 1);

  while(true) {
    self waittill("weapon_change");

    while(self isswitchingweapon() && isnullweapon(level.player getcurrentprimaryweapon())) {
      waitframe();
    }

    var_95c5e5bce5b50920 = var_7c9b3b1614663ec9;
    var_382ad0656bf75b71 = var_a9bf99cbff9b5384;
    var_7c9b3b1614663ec9 = self getcurrentprimaryweapon();
    var_a9bf99cbff9b5384 = level.player isalternatemode(var_7c9b3b1614663ec9, 1);
    var_253fe2df40deea84 = 0;

    if(var_7c9b3b1614663ec9 == var_95c5e5bce5b50920) {
      if(var_d93f43fabf2d7499) {
        if(var_382ad0656bf75b71 && !var_a9bf99cbff9b5384) {
          var_253fe2df40deea84 = 1;
        } else if(!var_382ad0656bf75b71 && var_a9bf99cbff9b5384) {
          var_253fe2df40deea84 = 1;
        }
      }
    }

    if(var_253fe2df40deea84) {
      flag_set("player_switched_fire_mode");
      return;
    }

    var_d93f43fabf2d7499 = namespace_47819225b08b445d::function_5c40243f3153be01(var_7c9b3b1614663ec9);
  }
}

function function_45a8c0a949b2fcd1() {
  nades = getEntArray("grenade", "classname");

  if(nades.size == 0) {
    return true;
  }

  foreach(nade in nades) {
    if(isvalidmissile(nade) && isPlayer(getmissileowner(nade))) {
      return false;
    }
  }

  return true;
}