/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moon_port\moon_port_concourse.gsc
*************************************************************/

_id_44E8() {}

_id_44D4() {
  scripts\engine\utility::flag_init("openingIGC_aborted");
  scripts\engine\utility::flag_init("coastguard_obj");
  scripts\engine\utility::flag_init("spawnedAndReady_Concorse");
  scripts\engine\utility::flag_init("spawnedAndReady_HallwayTransition");
  scripts\engine\utility::flag_init("moonConcorseCombatStarted");
  scripts\engine\utility::flag_init("moonConcorseCombat_playerFirstWallrun");
  scripts\engine\utility::flag_init("moonConcorseCombat_playerSecondWallrun");
  scripts\engine\utility::flag_init("ethan_sheild_line_done");
  scripts\engine\utility::flag_init("salter_sheild_line_done");
  level._id_F048 = [];
  level._id_F061 = [];
  scripts\engine\utility::flag_init("moonConcorse_encounter02Start");
  scripts\engine\utility::flag_init("moonConcorse_encounter02Mid");
  scripts\engine\utility::flag_init("moonConcorse_encounter02Mid_lowerGate");
  scripts\engine\utility::flag_init("moonConcorse_encounter02End");
  scripts\engine\utility::flag_init("moonConcorse_encounter02End_resetEnemies");
  scripts\engine\utility::flag_init("concourse_tigris_dialogue_finished");
  scripts\engine\utility::flag_init("coastguard_c8_spawned");
  scripts\engine\utility::flag_init("concourse_c8_intro_start");
  scripts\engine\utility::flag_init("concourse_c8_intro_complete");
  scripts\engine\utility::flag_init("concourse_c8_intro_marine_ready");
  scripts\engine\utility::flag_init("concourse_c8_start_marine1");
  scripts\engine\utility::flag_init("concourse_c8_start_marine2");
  scripts\engine\utility::flag_init("concourse_c8_entering_sides");
  scripts\engine\utility::flag_init("concourse_c8_coloroff");
  scripts\engine\utility::flag_init("concourse_c8_path_end");
  scripts\engine\utility::flag_init("concourse_c8_spawned");
  scripts\engine\utility::flag_init("shield_pick_reminder_dialogue");
  scripts\engine\utility::flag_init("player_shield_intro_done");
  scripts\engine\utility::flag_init("shield_end_dialogue");
  scripts\engine\utility::flag_init("shield_door_open");
  scripts\engine\utility::flag_init("player_grabbed_shield");
  scripts\engine\utility::flag_init("salter_shield_intro_done");
  scripts\engine\utility::flag_init("player_at_shield_hall_door");
  scripts\engine\utility::flag_init("salter_at_shield_hall_door");
  scripts\engine\utility::flag_init("player_opening_shield_hall_door");
  scripts\engine\utility::flag_init("player_opened_shield_hall_door");
  scripts\engine\utility::flag_init("coastguard_c8_door_close");
  scripts\sp\utility::_id_16EB("retractable_shield_hint", &"SCRIPT_SHIELD_HINT", ::_id_E334);
  scripts\sp\utility::_id_16EB("shield_bash_hint", &"MOON_PORT_SHIELD_BASH", ::_id_28B3);
  level._id_3475 = (0, 0, 0);
  getspawner("concourse_c8_intro_marine", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_44AF);
  getspawner("coastguard_c8", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_42FD);
  scripts\sp\utility::_id_22CA("coastguard_hallway_enemies", ::_id_4300);
  scripts\sp\utility::_id_22CA("coastguard_c8_fight_mdf", ::_id_42FE);
  scripts\sp\utility::_id_22C9("concourse_c8_vista_capships", ::_id_44B5);
  createthreatbiasgroup("player");
  level.player setthreatbiasgroup("player");
  createthreatbiasgroup("coastguard_c8");
  setthreatbias("coastguard_c8", "player", 500);
  level._id_B81B = 60;
  _id_0B0F::_id_10282("concourse_c8_skyambient", "right_to_left_close", 4);
  _id_0B0F::_id_10282("concourse_c8_skyambient", "right_to_left_mid", 4);
  _id_0B0F::_id_10282("concourse_c8_skyambient", "left_to_right_mid", 4);
  _id_0B0F::_id_10282("concourse_c8_skyambient", "front_left_to_back_right", 6);
  thread _id_FC6D();
}

_id_44E5() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_concourse_humans");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_concourse_humans");
  scripts\sp\maps\moon_port\moon_port_util::_id_15F6("post_curve_wall_run_color_trig_2");
  wait 1.0;
  scripts\sp\maps\moon_port\moon_port_util::_id_15F6("sqd_hallwayApproach01");
  _id_0E4B::_id_8E06();
  setsaveddvar("bg_cinematicFullScreen", "0");
  scripts\engine\utility::delaythread(2, scripts\engine\utility::flag_set, "play_ambient_bink_mp");
}

_id_44E1() {
  scripts\engine\utility::flag_set("player_indoor_p1_noblur");
  scripts\sp\utility::_id_2669("concourse_opening_igc_start");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("r");
  level.allies["marineCO"] scripts\sp\utility::_id_F3B5("r");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("r");
  level.allies["marine2"] scripts\sp\utility::_id_F3B5("g");
  level.allies["marine1"] scripts\sp\utility::_id_F3B5("g");
  thread opening_bypass_watcher();
  thread _id_449E();
  thread _id_44D8();
  thread _id_44DF();
  thread _id_44EB();
  scripts\engine\utility::flag_wait("openingIGC_start");
  scripts\engine\utility::exploder("outside_explo_01");
  thread _id_1526();

  foreach(var_1 in level.allies) {
    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
  }

  scripts\engine\utility::flag_wait("openingIGC_playerArrived");
  thread _id_4498();
  thread _id_1525();
  thread _id_44DC();
  thread _id_44DD();
  thread _id_44E4();
  thread _id_44DE();
  thread _id_44D1();
  scripts\engine\utility::flag_wait_or_timeout("openingIGC_aborted", 20);
  scripts\sp\utility::_id_2669("concourse_combat_start");

  if(!scripts\engine\utility::flag("openingIGC_aborted"))
    scripts\engine\utility::flag_set("openingIGC_aborted");

  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("g");
  level.player scripts\sp\utility::_id_F526("normal");

  foreach(var_4 in level.allies) {
    if(isalive(var_4)) {
      var_4.ignoreall = 0;
      wait(randomfloatrange(0.1, 0.5));
      var_4.ignoreme = 0;
    }
  }

  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_CF8D();
  thread _id_4499();
  scripts\engine\utility::flag_wait("start_concourse_main");
  scripts\sp\utility::_id_1264E("moon_port_tutorials_tr");
  thread _id_44DA();
}

opening_bypass_watcher() {
  scripts\engine\utility::flag_wait("openingIGC_playerArrived");
  scripts\engine\utility::flag_set("openingIGC_start");
}

_id_4499() {
  level._id_7752 = 1;
  var_0 = getEnt("igc_fallback_center", "targetname");
  var_1 = getEnt("igc_fallback_right", "targetname");
  var_2 = getEnt("concourse_fallback_corner", "targetname");
  var_3 = scripts\engine\utility::getStruct("window_shooter_distance_check", "targetname");
  wait 1.5;
  scripts\sp\maps\moon_port\moon_port_util::_id_15F6("igc_scene_friendlies_1");

  if(isDefined(var_0))
    var_0 scripts\sp\utility::_id_135F1("trigger", 15);

  scripts\sp\maps\moon_port\moon_port_util::_id_F293("sdf_igc_scene_guys", "sdf_igc_retreat_vol");

  if(level._id_7752 == 1)
    thread _id_7752();

  if(isDefined(var_1))
    var_1 scripts\sp\utility::_id_135F1("trigger", 25);

  scripts\sp\maps\moon_port\moon_port_util::_id_15F6("igc_scene_friendlies_2");
  scripts\sp\maps\moon_port\moon_port_util::_id_F293("sdf_igc_scene_guys", "sdf_igc_retreat_right_vol");
  scripts\sp\maps\moon_port\moon_port_util::_id_F293("sdf_igc_reinforcements", "sdf_igc_retreat_right_vol");

  if(level._id_7752 == 1)
    thread _id_7752();

  if(isDefined(var_2))
    var_2 scripts\sp\utility::_id_135F1("trigger", 25);

  scripts\sp\maps\moon_port\moon_port_util::_id_F293("sdf_igc_scene_guys", "corner_lower_vol");
  scripts\sp\maps\moon_port\moon_port_util::_id_F293("sdf_igc_reinforcements", "corner_lower_vol");
  scripts\sp\maps\moon_port\moon_port_util::_id_15F6("concourse_fallback_corner_friendlies");

  if(level._id_7752 == 1)
    thread _id_7752();

  _id_44D2();

  if(level._id_10199 == 1) {
    level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_watchouttheyreshooting");
    var_4 = getaiarray("axis");
    var_4 = scripts\sp\utility::array_removedeadvehicles(var_4);
    var_4 = sortbydistance(var_4, var_3.origin);

    if(isDefined(var_4[2]))
      var_4[2] thread _id_26ED();

    if(isDefined(var_4[1]))
      var_4[1] thread _id_26ED();

    if(isDefined(var_4[0]))
      var_4[0] _id_26ED();

    wait 4;
  } else {
    while(scripts\sp\utility::_id_77DB("sdf_igc_sniper") > 0)
      wait 0.2;

    wait 1;
  }

  scripts\sp\maps\moon_port\moon_port_util::_id_15F6("concourse_combat_start_colors");
  scripts\sp\maps\moon_port\moon_port_util::_id_F293("sdf_igc_scene_guys", "concourse_main_goalvol_01", 0.1, 0.2, "frantic", 1);
  scripts\sp\maps\moon_port\moon_port_util::_id_F293("sdf_igc_reinforcements", "concourse_main_goalvol_01", 0.1, 0.2, "frantic", 1);
  scripts\sp\maps\moon_port\moon_port_util::_id_F293("sdf_igc_fallback_guys", "concourse_main_goalvol_01", 0.1, 0.2, "frantic", 1);
  _id_449A();
}

_id_7752() {
  level._id_7752 = 0;
  var_0 = [];
  var_0[0] = level.allies["salter"];
  var_0[1] = level.allies["marineCO"];
  var_0[2] = level.allies["eth3n"];
  var_1 = [];
  var_1[var_1.size] = "UN_omr_exposed_breaking";
  var_1[var_1.size] = "UN_omr_exposed_movement";
  var_1[var_1.size] = "UN_omr_exposed_open";
  var_1[var_1.size] = "UN_omr_order_move_noncombat";
  var_2 = [];
  var_2[var_2.size] = "UN_slt_exposed_breaking";
  var_2[var_2.size] = "UN_slt_exposed_movement";
  var_2[var_2.size] = "UN_slt_exposed_open";
  var_2[var_2.size] = "UN_slt_order_move_noncombat";
  var_3 = [];
  var_3[var_3.size] = "UN_eth_exposed_breaking";
  var_3[var_3.size] = "UN_eth_exposed_movement";
  var_3[var_3.size] = "UN_eth_exposed_open";
  var_3[var_3.size] = "UN_eth_contact_movement_group";
  var_4 = [];
  var_4[var_4.size] = "UN_plr_exposed_breaking";
  var_4[var_4.size] = "UN_plr_exposed_movement";
  var_4[var_4.size] = "UN_plr_exposed_open";
  var_4[var_4.size] = "UN_plr_order_move_noncombat";
  wait 1.5;
  var_0 = sortbydistance(var_0, level.player.origin);

  if(distance2d(var_0[0].origin, level.player.origin) < 256) {
    if(var_0[0] == level.allies["salter"]) {
      var_5 = scripts\engine\utility::random(var_2);
      level.allies["salter"] scripts\sp\utility::_id_10346(var_5);
    } else if(var_0[0] == level.allies["marineCO"]) {
      var_5 = scripts\engine\utility::random(var_1);
      level.allies["marineCO"] scripts\sp\utility::_id_10346(var_5);
    } else if(var_0[0] == level.allies["eth3n"]) {
      var_5 = scripts\engine\utility::random(var_3);
      level.allies["eth3n"] scripts\sp\utility::_id_10346(var_5);
    }
  } else {
    var_5 = scripts\engine\utility::random(var_4);
    scripts\sp\utility::_id_1034D(var_5);
  }

  wait 5;
  level._id_7752 = 1;
}

_id_449E() {
  var_0 = scripts\engine\utility::getStruct("igc_middle_window_explode", "targetname");
  scripts\sp\utility::_id_127B3("igc_trigger_shutter");
  radiusdamage(var_0.origin, 32, 500, 500);
}

_id_44D2() {
  level endon("igc_final_fallback");
  scripts\sp\utility::_id_127B3("concourse_c8_aiambient_trig");
  wait 1;
  setmusicstate("mx_196_moonport_concourse");
}

_id_78AE() {
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
  var_0 = sortbydistance(var_0, level.player.origin);
  return var_0[0];
}

_id_449A() {
  var_0 = getEnt("concourse_main_spawn_robots", "script_noteworthy");

  if(level._id_7752 == 1)
    thread _id_7752();

  wait 4;
  var_1 = _id_78AE();

  if(isDefined(var_1))
    var_1 scripts\sp\utility::_id_10347("moon_sdf4_fallback");

  wait 0.5;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_wereclearingthem");
  scripts\engine\utility::flag_wait("start_concourse_main");
  wait 0.5;
  var_1 = _id_78AE();

  if(isDefined(var_1))
    var_1 scripts\sp\utility::_id_10347("moon_sdf4_getthosec6sup");

  if(isDefined(var_0))
    var_0 waittill("trigger");

  var_1 = _id_78AE();

  if(isDefined(var_1))
    var_1 scripts\sp\utility::_id_10347("moon_sdf3_upthere");

  wait 3;
  scripts\engine\utility::flag_set("coastguard_obj");
  wait 0.25;
  wait 8;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_keepclearingtheconcourse");
}

_id_4498() {
  wait(randomfloatrange(1.0, 3.0));
  scripts\engine\utility::exploder("outside_explo_02");
}

_id_44D8() {
  var_0 = getEnt("concourse_1_friendly_destroyer", "targetname");
  thread _id_0B0F::_id_10D23("concourse_1_ambient_battle");
  var_1 = _id_44D0("concourse_1_enemy_destroyer_1");
  var_2 = _id_44D0("concourse_1_enemy_destroyer_2");
  var_3 = _id_44D0("concourse_1_enemy_destroyer_3");
  var_4 = var_0 scripts\sp\vehicle::_id_1080B();
  var_4 _id_0BB8::_id_39D0("heavy");
  var_4 _id_0BB8::_id_39CD("idle");
  var_1 thread _id_0BB6::_id_3966(1, 1, var_4);
  var_2 thread _id_0BB6::_id_3966(1, 1, var_4);
  var_3 thread _id_0BB6::_id_3966(1, 1, var_4);
  var_4 thread _id_0BB6::_id_3966(1, 1, var_1, var_2, var_3);
  scripts\engine\utility::flag_wait("player_opening_shield_hall_door");
  thread _id_0B0F::_id_1103F("concourse_1_ambient_battle");
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 _id_0BA9::_id_397B();
}

_id_44D0(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_2 = var_1 scripts\sp\vehicle::_id_1080B();
  var_2 _id_0BB8::_id_39D0("heavy");
  var_2 _id_0BB8::_id_39CD("idle");
  var_2 notify("kill_rumble_forever");
  return var_2;
}

_id_44D1() {
  scripts\sp\utility::_id_127AE("sdf_igc_allies_forward", "targetname");
  wait 6;
  scripts\sp\maps\moon_port\moon_port_util::_id_15F6("sdf_igc_allies_forward_rear");
}

_id_4184() {
  self endon("death");
  level scripts\engine\utility::waittill_any("window_broken", "igc_final_fallback");
  self clearentitytarget();
}

_id_26ED() {
  self endon("death");
  level endon("window_broken");
  level endon("igc_final_fallback");
  thread _id_4184();
  var_0 = self gettagorigin("tag_flash");
  var_1 = scripts\engine\utility::getStructArray("window_shooter_shoot_at", "targetname");
  var_2 = var_1[0];
  var_3 = vectortoyaw(self.origin - var_2.origin);

  for(var_4 = 0; var_4 < 4; var_4 = var_4 + 1) {
    var_2 = scripts\engine\utility::random(var_1);
    var_5 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
    var_6 = randomintrange(1, 4);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      self _meth_82DE(var_5);
      self waittill("shooting");
      scripts\engine\utility::waitframe();
    }

    var_5 delete();
    scripts\engine\utility::waitframe();
  }

  radiusdamage(var_2.origin, 128, 300, 300);
}

_id_44DF() {
  level endon("openingIGC_aborted");
  thread _id_44C7();
  scripts\engine\utility::flag_wait("pre_concourse_vo_start");
  thread _id_9A8F();
  scripts\sp\utility::_id_10350("moon_mdf1_marineblackhorseone");
  wait 0.25;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_mco_solidcopywhatsyour");
  wait 0.25;
  scripts\sp\utility::_id_10350("moon_mdf1_wearepinneddown");
  wait 0.25;
  scripts\sp\utility::_id_1034D("moon_plr_letsgettoem");
  scripts\engine\utility::flag_wait("openingIGC_playerArrived");
  wait 2;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_downbelow");
  wait 2;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_theyreshootingcivilians");
}

_id_44C7() {
  scripts\engine\utility::flag_wait("openingIGC_aborted");
  wait 1.5;
  scripts\sp\utility::_id_1034D("moon_plr_contactgroundfloor");
  wait 1;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moonport_omr_weclearthrought");
  wait 12;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_dontletup");
}

_id_9A8F() {
  wait 6;
  var_0 = scripts\engine\utility::getStruct("tut_vo_gunshot_node", "targetname");

  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < 4; var_1++) {
      playworldsound("weap_ar57_fire_npc", var_0.origin);
      wait 0.05;
    }

    wait 0.25;

    for(var_1 = 0; var_1 < 3; var_1++) {
      playworldsound("weap_ar57_fire_npc", var_0.origin);
      wait 0.05;
    }

    wait 0.5;

    for(var_1 = 0; var_1 < 5; var_1++) {
      playworldsound("weap_ar57_fire_npc", var_0.origin);
      wait 0.05;
    }
  } else {
    for(var_1 = 0; var_1 < 4; var_1++) {
      playworldsound("weap_ar57_fire_npc", level.player.origin);
      wait 0.05;
    }

    wait 0.25;

    for(var_1 = 0; var_1 < 3; var_1++) {
      playworldsound("weap_ar57_fire_npc", level.player.origin);
      wait 0.05;
    }

    wait 0.5;

    for(var_1 = 0; var_1 < 5; var_1++) {
      playworldsound("weap_ar57_fire_npc", level.player.origin);
      wait 0.05;
    }
  }
}

_id_44EB() {
  var_0 = getEnt("concourse_combat_start_colors", "targetname");
  var_0 waittill("trigger");
}

_id_44DC() {
  var_0 = getEntArray("sdf_igc_intro", "targetname");
  var_1 = scripts\sp\utility::_id_22C6(var_0, 1, 1);
  var_2 = getEnt("execution_anim_node", "targetname");
  var_1[0]._id_1FBB = "shooter1";
  var_1[1]._id_1FBB = "shooter2";
  var_1[2]._id_1FBB = "shooter3";
  var_1[0].ignoreme = 1;
  var_1[1].ignoreme = 1;
  var_1[2].ignoreme = 1;
  var_1[0] thread _id_44DB();
  var_1[1] thread _id_44DB();
  var_1[2] thread _id_44DB();
  level.player thread _id_44E3();
  level.player thread _id_44E0();
  var_3 = getEnt("execution_civ1", "targetname");
  var_4 = getEnt("execution_civ2", "targetname");
  var_5 = getEnt("execution_civ3", "targetname");
  var_6 = getEnt("execution_civ4", "targetname");
  var_7 = getEnt("execution_civ5", "targetname");
  var_8 = getEnt("execution_civ6", "targetname");
  var_9 = var_3 scripts\sp\utility::_id_10619();
  var_10 = var_4 scripts\sp\utility::_id_10619();
  var_11 = var_5 scripts\sp\utility::_id_10619();
  var_12 = var_6 scripts\sp\utility::_id_10619();
  var_13 = var_7 scripts\sp\utility::_id_10619();
  var_14 = var_8 scripts\sp\utility::_id_10619();
  var_9._id_1FBB = "civ1";
  var_10._id_1FBB = "civ2";
  var_11._id_1FBB = "civ3";
  var_12._id_1FBB = "civ4";
  var_13._id_1FBB = "civ5";
  var_14._id_1FBB = "civ6";
  var_9.ignoreme = 1;
  var_10.ignoreme = 1;
  var_11.ignoreme = 1;
  var_12.ignoreme = 1;
  var_13.ignoreme = 1;
  var_14.ignoreme = 1;
  var_1[3] = var_9;
  var_1[4] = var_10;
  var_1[5] = var_11;
  var_1[6] = var_12;
  var_1[7] = var_13;
  var_1[8] = var_14;
  var_2 thread scripts\sp\anim::_id_1F35(var_1[0], "execution_scene");
  var_2 thread scripts\sp\anim::_id_1F35(var_1[1], "execution_scene");
  var_2 scripts\engine\utility::delaythread(1, scripts\sp\anim::_id_1F35, var_1[2], "execution_scene");
  var_2 thread _id_3FA8(var_9);
  var_2 thread _id_3FA8(var_10);
  var_2 thread _id_3FA8(var_11);
  var_2 thread _id_3FA8(var_12);
  var_2 thread _id_3FA8(var_13);
  var_2 thread _id_3FA8(var_14);
  level notify("concourse_opening_anims_started");
  thread _id_D7C6(var_1[8]);
  scripts\engine\utility::flag_wait("openingIGC_aborted");

  foreach(var_17, var_16 in var_1) {
    if(var_16.team == "axis")
      var_16 _id_EBEC();
  }

  var_18 = getnode("sdf_igc_end_node_1", "targetname");
  var_19 = getnode("sdf_igc_end_node_2", "targetname");

  if(isDefined(var_1[0]))
    var_1[0] _meth_82EE(var_18);

  if(isDefined(var_1[1]))
    var_1[1] _meth_82EE(var_19);
}

_id_D7C6(var_0) {
  level endon("openingIGC_aborted");
  var_1 = _id_78AE();
  var_1 scripts\sp\utility::_id_10347("moon_sdf2_pathetic");
  var_0 thread scripts\sp\utility::_id_10347("moon_civ1_nonoplease");
  wait 1;
  var_1 = _id_78AE();
  var_1 scripts\sp\utility::_id_10347("moon_sdfun1_makesuretheyreall");
  var_0 thread scripts\sp\utility::_id_10347("moon_civ_nooooo");
}

_id_EBEC() {
  self _meth_83A1();
  self.ignoreall = 0;
  self.ignoreme = 0;
  scripts\sp\utility::_id_4145();
  self setgoalpos(self.origin);
}

_id_44DB() {
  level endon("openingIGC_aborted");
  self endon("death");
  self.health = 10;
  self.ignoreall = 1;
  scripts\sp\utility::_id_51E1("casual_gun");
  self waittill("damage", var_0, var_1);
  self.ignoreall = 0;
  scripts\engine\utility::flag_set("openingIGC_aborted");
}

_id_44E3() {
  level endon("openingIGC_aborted");
  level.player endon("death");
  level.player waittill("weapon_fired");
  scripts\engine\utility::flag_set("openingIGC_aborted");
}

_id_44E0() {
  level endon("openingIGC_aborted");
  level.player endon("death");
  level.player scripts\engine\utility::waittill_any("grenade_fire", "offhand_end");
  wait 1.0;
  scripts\engine\utility::flag_set("openingIGC_aborted");
}

_id_3FA8(var_0) {
  self.ignoreall = 1;
  level endon("openingIGC_aborted");
  var_0 notsolid();
  scripts\sp\anim::_id_1F35(var_0, "execution_scene");
  scripts\sp\anim::_id_1EE0(var_0, "execution_scene");
}

_id_44DD() {
  var_0 = [];
  var_1 = getEnt("execution_anim_node", "targetname");
  var_2 = getEntArray("execution_bodies", "targetname");

  foreach(var_6, var_4 in var_2) {
    var_5 = var_4 scripts\sp\utility::_id_10619(1);

    if(isDefined(var_5)) {
      var_5.ignoreall = 1;
      var_5._id_1FBB = "generic";
      var_5 scripts\sp\utility::_id_F333("dead_civ_0" + (var_6 + 1));
      var_1 thread scripts\sp\anim::_id_1EC3(var_5, "dead_civ_0" + (var_6 + 1));
      var_5 thread scripts\sp\maps\moon_port\moon_port_util::_id_A5E4();
    }

    scripts\engine\utility::waitframe();
  }
}

_id_44E4() {
  level waittill("concourse_opening_anims_started");
  var_0 = getEnt("exec_room_spawn", "script_noteworthy");
  scripts\sp\utility::_id_22CA(var_0.target, ::_id_68CF);
  scripts\engine\utility::waitframe();
  var_0 notify("trigger");
}

_id_68CF() {
  self endon("death");
  scripts\sp\utility::_id_51E1("casual_gun");
  self.ignoreall = 1;
  self.fixednode = 1;
  scripts\engine\utility::flag_wait("openingIGC_aborted");
  scripts\sp\utility::_id_4145();
  self.ignoreall = 0;
  wait 2.0;
  self.goalradius = 32;
  self waittill("goal");
  self.fixednode = 0;
  self.goalradius = 512;
}

_id_44DE() {
  var_0 = getEnt("corner_spawn_view_org", "targetname");
  var_0 scripts\sp\utility::_id_137DF();
  wait 0.3;
  var_1 = [];
  var_2 = getEntArray("sdf_igc_corner_runners", "targetname");

  foreach(var_4 in var_2) {
    if(getaicount() < 32)
      var_1[var_1.size] = var_4 scripts\sp\utility::_id_10619();
  }
}

_id_1526() {
  level endon("openingIGC_aborted");
  level.player waittill("player_fire");
  scripts\engine\utility::flag_set("openingIGC_aborted");
}

_id_1525() {
  level endon("openingIGC_aborted");
  var_0 = getEnt("introIGC_playerDroppedDown", "targetname");
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("openingIGC_aborted");
}

_id_44D9() {
  scripts\engine\utility::flag_set("openingIGC_playerArrived");
  thread _id_44DA();
}

_id_44DA() {
  thread scripts\sp\maps\moon_port\moon_port_util::_id_EA00("sdf_igc_scene_guys");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_EA00("sdf_igc_reinforcements");
}

_id_44C9() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_concourse_combat");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_concourse_combat");
  scripts\sp\utility::_id_15F5("concourse_combat_start_colors");
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  _id_0E4B::_id_8E06();
  setsaveddvar("bg_cinematicFullScreen", "0");
  scripts\engine\utility::delaythread(2, scripts\engine\utility::flag_set, "play_ambient_bink_mp");
}

_id_44C8() {
  scripts\engine\utility::flag_set("player_indoor_p1_noblur");
  scripts\sp\utility::_id_2669("concourse_main_first_wave");
  var_0 = getaiarray("axis");
  var_1 = getEnt("concourse_main_goalvol_01", "targetname");

  foreach(var_3 in var_0) {
    var_3 _meth_82F1(var_1);
    var_3.ignoreall = 1;
    var_3.ignoreme = 1;
  }

  scripts\engine\utility::flag_wait("start_concourse_main");
  var_0 = getaiarray("axis");

  if(var_0.size < 12)
    scripts\sp\utility::_id_22CD("concouse_2_xtra_1");

  foreach(var_3 in var_0) {
    var_3.ignoreall = 0;
    var_3.ignoreme = 0;
  }

  scripts\sp\utility::_id_127AE("concourse_main_spawn_robots", "script_noteworthy");
  wait 1;
  var_0 = getaiarray("axis");

  if(var_0.size < 12)
    scripts\sp\utility::_id_22CD("concouse_2_xtra_2");

  while(getaiunittypearray("axis", "soldier").size > 3 && !scripts\engine\utility::flag("concourse_main_rush_01"))
    wait 0.2;

  scripts\sp\utility::_id_2669("concourse_main_second_wave");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("concourse_sdf_01", "concourse_main_goalvol_02", 0.1, 0.2, "frantic", 0.5);
  scripts\engine\utility::flag_wait_or_timeout("concourse_main_rush_01", 2.5);
  var_7 = getEnt("cc_moveup_1", "targetname");

  if(isDefined(var_7))
    var_7 delete();

  scripts\sp\utility::_id_15F5("concourse_main_ally_push_01");
  scripts\engine\utility::flag_wait_or_timeout("concourse_main_rush_01", 3.0);
  scripts\sp\utility::_id_15F3("concourse_main_spawn_02");
  scripts\engine\utility::flag_wait_or_timeout("concourse_main_rush_01", 5.0);
  thread scripts\sp\utility::_id_12641("moon_port_harass_tr");

  while(getaicount("axis") > 4 && !scripts\engine\utility::flag("concourse_main_rush_02"))
    wait 0.2;

  scripts\sp\utility::_id_2669("concourse_main_third_wave");
  scripts\sp\utility::_id_15F5("concourse_main_ally_push_02");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("concourse_sdf_01", "concourse_main_goalvol_02p5", 0.1, 0.2, "frantic", 0.5);
  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("concourse_sdf_02", "concourse_main_goalvol_02p5", 0.1, 0.2, "frantic", 0.5);
  scripts\engine\utility::flag_wait_or_timeout("playerRushing_encounter01_bots", 10.0);
  scripts\sp\maps\moon_port\moon_port_util::_id_15F4("concourse_main_spawn_03");
  scripts\engine\utility::flag_wait("playerRushing_encounter01_bots");
  scripts\sp\utility::_id_15F5("c8_fallback2");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_keeppushingthemback");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("concourse_sdf_01", "concourse_main_goalvol_03", 0.1, 0.2, "frantic", 0.5);
  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("concourse_sdf_02", "concourse_main_goalvol_03", 0.1, 0.2, "frantic", 0.5);
  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("concourse_sdf_03", "concourse_main_goalvol_03", 0.1, 0.2, "frantic", 0.5);
  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("right_shop_guys", "concourse_main_goalvol_03", 0.1, 0.2, "frantic", 0.5);
  thread scripts\sp\maps\moon_port\moon_port_util::_id_F293("left_shop_guys", "concourse_main_goalvol_03", 0.1, 0.2, "frantic", 0.5);
  scripts\engine\utility::flag_wait_or_timeout("playerRushing_encounter01_bots2", 15);
  thread slow_load_blocker_harass();
  thread scripts\sp\utility::_id_2669("concourse_first_fight_bots");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_F2D4("concourse_main_goalvol_end");
  thread _id_44C6();
}

slow_load_blocker_harass() {
  if(!level.console) {
    scripts\engine\utility::flag_wait("concourse_c8_spawn");
    waitforalltransients();
  }
}

_id_44E9() {
  scripts\sp\utility::_id_13624("right_shop_guys");
  wait 0.05;
  var_0 = scripts\sp\utility::_id_77DA("right_shop_guys");

  foreach(var_2 in var_0) {
    var_2.ignoreall = 1;
    var_2 scripts\sp\utility::_id_51E1("frantic");
  }

  wait 4;
  var_0 = scripts\sp\utility::_id_77DA("right_shop_guys");

  foreach(var_2 in var_0) {
    var_2.ignoreall = 0;
    var_2 scripts\sp\utility::_id_51E1("combat");
  }

  var_6 = scripts\sp\utility::_id_77DA("right_shop_robot");

  foreach(var_8 in var_6) {
    var_8 scripts\sp\utility::_id_F3DD(128);
    var_8 setgoalentity(level.player);
  }
}

_id_44B5() {
  self castdistantshadows();
  self notsolid();
  self._id_12FB8 = 1;
  self._id_12FBA = 1;
  self notify("kill_rumble_forever");
  thread _id_0B0F::_id_39BC();
  scripts\engine\utility::waitframe();
  _id_0BB6::_id_398A(1);
  _id_0BB8::_id_39CD("idle");
  _id_0BB8::_id_39D0("heavy");
  _id_0BB8::_id_39CE("med");
}

_id_44C5() {
  thread _id_44C6();
  getEnt("concourse_main_spawn_01", "script_noteworthy") delete();
  getEnt("concourse_main_spawn_02", "script_noteworthy") delete();
  getEnt("concourse_main_spawn_03", "script_noteworthy") delete();
  scripts\sp\utility::_id_228A(getEntArray("concourse_combat_trigger", "script_noteworthy"));
  _id_0B77::_id_A67F(104);
}

_id_44C6() {
  _id_0B77::_id_A67F(100);
  _id_0B77::_id_A67F(102);
  thread scripts\sp\maps\moon_port\moon_port_util::_id_EA00("concourse_sdf_01");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_EA00("concourse_sdf_02");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_EA00("concourse_sdf_03");
}

_id_3459() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_c8_fight");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_c8_fight");
  scripts\sp\utility::_id_15F3("concourse_c8_skyambient_trig");
  scripts\sp\utility::_id_15F5("concourse_c8_vista_capships_trig");
  scripts\sp\utility::_id_107CD("concourse_c8_intro_marine", 1);
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  _id_0E4B::_id_8E06();
  scripts\engine\utility::flag_set("playerRushing_encounter01_bots2");
}

_id_3458() {
  scripts\engine\utility::flag_set("player_indoor_p1");
  scripts\engine\utility::flag_wait("concourse_c8_spawn");
  getspawner("concourse_c8_intro_marine", "script_noteworthy") scripts\sp\utility::_id_10619(1);
  thread _id_44A8();
  thread _id_44AB();
  thread _id_44C4();
  scripts\engine\utility::flag_wait("concourse_c8_dead");
  scripts\sp\utility::_id_2669("concourse_c8_dead");
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_CF8B();
}

_id_44A8() {
  scripts\engine\utility::flag_wait("concourse_c8_intro_marine_ready");
  thread scripts\engine\utility::play_sound_in_space("scn_moon_c8_intro_pod_incoming", (7462, 8697, -53846));
  wait 0.5;
  setmusicstate("");
  thread scripts\engine\utility::play_sound_in_space("scn_moon_c8_intro_pod_roof_crash_lr", (7462, 8697, -53846));
  thread scripts\engine\utility::play_sound_in_space("scn_moon_c8_intro_pod_roof_debris_lr", (7371, 8680, -54229));
  scripts\engine\utility::exploder("c8pod_glass");
  var_0 = scripts\engine\utility::getStruct("c8_intro_struct", "targetname");
  var_1 = scripts\sp\utility::_id_10639("c8_intro_droppod");
  var_2 = scripts\sp\utility::_id_107CD("c8_intro_spawn", 1);
  var_2 thread _id_34C7();
  var_2 scripts\sp\utility::_id_B14F();
  var_2._id_1FBB = "c8";
  var_2 scripts\sp\utility::_id_F2D8(0.9);
  var_2._id_5580 = 1;
  var_2._id_3507 = 300;
  var_2 _id_0A04::_id_3454(0);
  _id_0A04::_id_3486(var_2);
  _id_0A04::_id_3487(var_2);
  var_2 _id_0A04::_id_3449();
  var_2 _id_0A04::_id_3455();
  level._id_44A8 = var_2;
  level._id_3474._id_6BAE = var_2;
  scripts\engine\utility::exploder("c6pod_kickup");
  var_1 scripts\engine\utility::delaycall(0.5, ::playsound, "scn_moon_c8_intro_pod_thru_roof_thruster");
  scripts\engine\utility::delaythread(2, scripts\engine\utility::play_sound_in_space, "scn_moon_c8_intro_rocket_bys", var_2.origin);
  thread _id_3472();
  scripts\engine\utility::flag_set("concourse_c8_intro_start");
  var_3 = [var_2, var_1];
  _id_0E29::_id_877F(var_2);
  var_0 scripts\sp\anim::_id_1F2C(var_3, "c8_intro");
  _id_0E29::_id_87D0(var_2);
  var_2 scripts\sp\utility::_id_1101B();
  var_1 hide();
  var_2 thread _id_3446();
  scripts\engine\utility::flag_set("concourse_c8_intro_complete");
  var_2 thread _id_3466();
  level notify("concourse_c8_playerSide_stop");
  var_2 waittill("reached_path_end");
  var_4 = getEnt("concourse_c8_windowroom", "targetname");

  if(!level.player istouching(var_4)) {
    var_5 = scripts\engine\utility::getStructArray("concourse_c8_path_sides", "targetname");

    foreach(var_7 in var_5) {
      if(var_7.script_noteworthy == level._id_44B1) {
        var_2 thread scripts\sp\utility::_id_7226(var_7);
        break;
      }
    }

    scripts\engine\utility::flag_wait("concourse_c8_entering_sides");
  }

  scripts\engine\utility::flag_set("concourse_c8_coloroff");
  var_2 notify("stop_going_to_node");
  var_2 _id_0A04::_id_3454(1);
  var_2 waittill("death");
}

_id_3472() {
  var_0 = getaiunittypearray("axis", "soldier");
  var_1 = getaiunittypearray("axis", "C6");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  var_3 = getEntArray("concourse_3_final_room_spawners", "targetname");

  foreach(var_5 in var_3) {
    if(isDefined(var_5))
      var_5 scripts\engine\utility::trigger_off();
  }

  foreach(var_8 in var_2)
  var_8 thread _id_3473();
}

_id_3473() {
  self endon("death");
  self.health = 10;
  var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin);

  if(var_0 >= 0.3)
    wait 2.5;

  for(;;) {
    var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin);

    if(var_0 >= 0.3)
      wait(randomintrange(1, 3));
    else {
      if(isDefined(self._id_B14F) && self._id_B14F)
        scripts\sp\utility::_id_1101B();

      self _meth_81D0();
    }

    scripts\engine\utility::waitframe();
  }
}

_id_3446() {
  self waittill("death");
  level._id_A892 = self.origin;
}

_id_3466() {
  self endon("death");
  var_0 = 0;

  while(var_0 < 3) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(var_5 == "MOD_GRENADE_SPLASH") {
      if(var_0 == 0)
        level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_grenadestunnedit");

      if(var_0 == 1)
        level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_grenadeout");

      if(var_0 == 2)
        level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_goodeffect");

      var_0 = var_0 + 1;
      wait 5;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_3425() {
  var_0 = scripts\engine\utility::getStruct("c8_entrance_window_explode", "targetname");
  wait 0.5;
  radiusdamage(var_0.origin, 64, 500, 500);
}

_id_3421() {
  var_0 = self getentitynumber();
  createnavrepulsor("c8_badplace_" + var_0, 0, self, 128, 1, "allies", "bad_guys");
  self waittill("death");
  destroynavrepulsor("c8_badplace_" + var_0);
}

_id_44B0() {
  self endon("stop_playerSeek");
  self endon("death");
  var_0 = getEnt("c8_friendly_goalvolume", "targetname");

  for(;;) {
    wait 0.5;
    var_1 = self.enemy;
    var_2 = 64;
    var_3 = 256;
    var_4 = var_1 getEye();
    var_5 = scripts\common\trace::ray_trace(self gettagorigin("j_head"), var_4, [self]);

    if(distance(var_1.origin, self.origin) <= var_3 && (isDefined(var_5["entity"]) && var_5["entity"] == var_1)) {
      self setgoalpos(self.origin);
      continue;
    }

    self.goalradius = var_2;
    var_6 = getclosestpointonnavmesh(var_1.origin, self);
    self setgoalpos(var_6);
  }
}

_id_44AD(var_0) {
  scripts\engine\utility::array_thread(getEntArray("c8_ceiling_glass_damage", "targetname"), scripts\sp\utility::_id_100D7);
  scripts\sp\utility::_id_228A(getEntArray("c8_ceiling_glass_prestine", "targetname"));
  thread _id_44A9();
  level waittill("c8_intro_second_land");
  scripts\engine\utility::array_thread(getEntArray("c8_intro_land_damage", "targetname"), scripts\sp\utility::_id_100D7);
  scripts\sp\utility::_id_228A(getEntArray("c8_intro_land_prestine", "targetname"));
}

_id_44A9() {
  var_0 = scripts\engine\utility::getStruct("c8_shutter_close_start", "targetname");
  var_1 = [];

  for(var_2 = var_0; isDefined(var_2); var_2 = var_3) {
    if(isDefined(var_2.target))
      var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    else
      break;

    var_4 = var_2 scripts\sp\utility::_id_10639("c8_shutter");
    var_4.origin = var_2.origin;
    var_4.angles = var_2.angles;
    var_1[var_1.size] = var_4;
    var_4 moveTo(var_3.origin, 0.5, 0.5);
    var_4 rotateTo(var_3.angles, 0.5, 0.5);
    wait 0.5;
  }
}

_id_44AF() {
  self._id_1FBB = "c8_intro_marine";
  scripts\sp\utility::_id_B14F();
  level._id_3474 = self;
  scripts\sp\utility::_id_5564();
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  var_0 = scripts\engine\utility::getStruct("c8_intro_struct", "targetname");
  var_1 = getnode("concourse_c8_intro_node", "script_noteworthy");
  var_0 scripts\sp\anim::_id_1F17(self, "c8_intro");
  self.goalradius = 24;
  self.fixednode = 1;
  self _meth_82EE(var_1);
  scripts\engine\utility::flag_set("concourse_c8_intro_marine_ready");
  level waittill("c8_intro_marine_start");
  var_0 scripts\sp\anim::_id_1F35(self, "c8_intro");
}

_id_44AB() {
  thread _id_44AE();
  level.allies["marine1"] thread _id_44B2();
  level.allies["marine2"] thread _id_44B2();
  _id_1C19();
  scripts\engine\utility::array_thread(getEntArray("concourse_c8_colortrig", "targetname"), ::_id_44AA);

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_5564();
    var_1 scripts\sp\utility::_id_F417(1);
  }

  scripts\engine\utility::flag_wait("concourse_c8_coloroff");
  scripts\sp\utility::_id_228A(getEntArray("concourse_c8_colortrig", "targetname"));
  var_3 = getEnt("c8_friendly_goalvolume", "targetname");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_54F7();
    var_1 scripts\sp\utility::_id_6224();
    var_1.fixednode = 0;
    var_1 _meth_82DC(300, 250);
    var_1 _meth_82F1(var_3);
  }

  scripts\engine\utility::flag_wait("concourse_c8_dead");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_61C7();
    var_1 scripts\sp\utility::_id_F417(0);
    var_1.fixednode = 1;
    var_1 cleargoalvolume();
  }
}

_id_44AE() {
  level endon("concourse_c8_playerSide_stop");
  level._id_44B1 = undefined;
  var_0 = getEntArray("c8_fight_player_sides", "targetname");

  for(;;) {
    foreach(var_2 in var_0) {
      if(level.player istouching(var_2)) {
        level._id_44B1 = var_2.script_noteworthy;
        break;
      }
    }

    wait 0.15;
  }
}

_id_44B2() {
  self endon("death");
  scripts\sp\utility::_id_54F7();
  self.fixednode = 0;
  var_0 = getnode("concourse_c8_node_" + self._id_1FBB, "script_noteworthy");
  thread scripts\sp\utility::_id_7226(var_0);
  scripts\engine\utility::flag_wait("concourse_c8_intro_start");
  self.favoriteenemy = level._id_44A8;

  if(self._id_1FBB == "marine2")
    wait 6;
  else
    wait 12;

  scripts\engine\utility::flag_set("concourse_c8_start_" + self._id_1FBB);

  if(isDefined(level._id_44A8))
    level._id_44A8.favoriteenemy = self;

  scripts\sp\utility::_id_F417(1);
  scripts\sp\utility::_id_1101B();
}

_id_44AA(var_0) {
  var_1 = self;
  var_1 endon("entitydeleted");
  _id_34F4(var_1);
  var_2 = getEntArray(var_1.target, "targetname");

  foreach(var_4 in var_2) {
    if(var_4.script_noteworthy == level._id_44B1)
      var_4 scripts\sp\utility::_id_15F1();
  }
}

_id_34F4(var_0) {
  for(;;) {
    wait 0.25;
    var_0 waittill("trigger", var_1);

    if(var_1.classname == "actor_enemy_c8") {
      return;
    }
    break;
  }
}

_id_44C4() {
  level endon("concourse_c8_dead");
  thread _id_44C2();
  wait 4.0;
  wait 8.0;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_huntersintheao");
  wait 0.25;
  scripts\sp\utility::_id_1034D("moon_plr_getcover");
  wait 9.5;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_frontalattackhasno");
  wait 3;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_wegottagetbehindit");
  wait 3;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_flanktheirshiel");
  wait 12;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_gettotherear");
  wait 3;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_itsmovingupget");
  wait 3;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_thiswayyoumetal");
  wait 9;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_mechswinekeepem");
  wait 6;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_welldrawitsfire");
  wait 6;
  level.allies["salter"] scripts\sp\utility::_id_10346("moonport_slt_seriousmanpower");
  wait 9;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_flanktheirshiel");
  wait 9;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_gettotherear");
  wait 6;
  scripts\sp\utility::_id_1034D("moonport_plr_letsgeterdone");
  wait 12;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_gettotherear");
  wait 12.5;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_flanktheirshiel");
}

_id_44C2() {
  scripts\engine\utility::flag_wait("concourse_c8_dead");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_itsgoingdown");
  wait 2.5;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_itsdown");
  wait 0.5;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_slt_secure");
}

_id_34C7() {
  level._id_3451 = [];

  for(;;) {
    level waittill("c8_shield_dropped", var_0);
    level._id_3451 = scripts\engine\utility::array_add(level._id_3451, var_0);
  }
}

_id_1C19(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(level.allies["marine1"])) {
      level.allies["marine1"] scripts\sp\utility::_id_1101B();
      level.allies["marine1"] delete();
    }

    if(isDefined(level.allies["marine2"])) {
      level.allies["marine2"] scripts\sp\utility::_id_1101B();
      level.allies["marine2"] delete();
    }
  }

  var_1 = level.allies["salter"];
  var_2 = level.allies["eth3n"];
  var_3 = level.allies["marineCO"];
  var_4 = undefined;

  if(isDefined(level.allies["mdf1"]))
    var_4 = level.allies["mdf1"];

  var_5 = undefined;

  if(isDefined(level.allies["brooks"]))
    var_5 = level.allies["brooks"];

  var_6 = undefined;

  if(isDefined(level.allies["kashima"]))
    var_6 = level.allies["kashima"];

  level.allies = [];
  level.allies["salter"] = var_1;
  level.allies["eth3n"] = var_2;
  level.allies["marineCO"] = var_3;

  if(isDefined(var_4))
    level.allies["mdf1"] = var_4;

  if(isDefined(var_5))
    level.allies["brooks"] = var_5;

  if(isDefined(var_6))
    level.allies["kashima"] = var_6;
}

_id_3457() {
  _id_1C19(1);
}

_id_FC88() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_shield_intro");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_shield_intro");
  scripts\sp\utility::_id_15F3("concourse_c8_skyambient_trig");
  scripts\sp\utility::_id_15F5("concourse_c8_vista_capships_trig");
  var_0 = scripts\sp\utility::_id_107CD("c8_intro_spawn", 1);
  var_0 thread _id_34C7();
  var_1 = scripts\engine\utility::getStruct("start_shield_intro_c8", "targetname");
  var_0 _meth_83B9(var_1.origin, var_1.angles);
  var_0 _meth_81D0();
  level._id_A892 = var_0.origin;
  _id_0E4B::_id_8E06();
  level.allies["salter"] thread scripts\anim\notetracks::notetrackvisorraise();
}

_id_FC82() {
  scripts\engine\utility::flag_set("player_indoor_p1");
  thread _id_FC80();
  level.allies["salter"] scripts\sp\utility::_id_F3B5("y");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("b");
  level.allies["marineCO"] scripts\sp\utility::_id_F3B5("r");
  scripts\sp\utility::_id_15F5("concourse_c8_shields");
  thread _id_FC87();
  _id_137CD();
  _id_FC86();
  scripts\engine\utility::flag_wait("salter_sheild_line_done");
}

_id_FC80() {
  thread _id_FC83();
  scripts\engine\utility::flag_wait("player_grabbed_shield");

  if(scripts\engine\utility::flag("shield_pick_reminder_dialogue"))
    scripts\engine\utility::flag_waitopen("shield_pick_reminder_dialogue");

  scripts\sp\utility::_id_1034D("moon_plr_howdothesespece");
  scripts\engine\utility::flag_set("ethan_sheild_line_done");
  wait 0.5;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_highvelocitycen");
  scripts\engine\utility::flag_wait("salter_sheild_line_done");
  wait 0.25;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_marinesmakeduew");
  scripts\engine\utility::flag_set("shield_end_dialogue");
  wait 1;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_letsgettheguard");
  wait 0.25;
  level.allies["salter"] scripts\sp\utility::_id_10346("moonport_slt_doorisourwayfor");
}

_id_FC83() {
  wait 6;

  if(scripts\engine\utility::flag("player_grabbed_shield")) {
    return;
  }
  scripts\engine\utility::flag_set("shield_pick_reminder_dialogue");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_ltreyesthehunte");
  scripts\engine\utility::flag_clear("shield_pick_reminder_dialogue");
}

_id_FC87() {
  while(!isDefined(level._id_A892))
    scripts\engine\utility::waitframe();

  level.allies["salter"] scripts\sp\utility::_id_54F7();
  level.allies["salter"].goalradius = 56;
  level.allies["salter"] setgoalpos(getclosestpointonnavmesh(level._id_A892));
  level.allies["salter"] waittill("goal");
  level.allies["salter"] orientmode("face point", level._id_A892);
  level.allies["salter"] scripts\sp\utility::_id_51E1("casual_gun");
  scripts\engine\utility::flag_wait("player_grabbed_shield");
  level.allies["salter"] thread scripts\sp\utility::_id_4125(1, 1, "iw7_m4");
  scripts\engine\utility::flag_wait("ethan_sheild_line_done");
  level.allies["eth3n"] scripts\sp\utility::_id_7799(level.player);
  level.allies["marineCO"] scripts\sp\utility::_id_7799(level.player);
  level.allies["salter"] orientmode("face point", level.player.origin);

  foreach(var_1 in level._id_3451) {
    if(isDefined(var_1))
      var_1 delete();
  }

  var_1 = scripts\sp\utility::_id_10639("retract_shield");
  var_3 = [level.allies["salter"], var_1];
  level.allies["salter"] scripts\sp\anim::_id_1F2C(var_3, "shield_intro");
  level.allies["salter"] scripts\sp\utility::_id_4145();
  var_1 delete();
  scripts\engine\utility::flag_set("salter_sheild_line_done");
  wait 1;
  level.allies["salter"] scripts\sp\utility::_id_51E1("cqb");
  scripts\engine\utility::flag_wait("player_shield_intro_done");

  foreach(var_5 in level.allies)
  var_5 scripts\sp\utility::_id_77B9(1);

  level.allies["salter"] scripts\sp\utility::_id_4145();
}

_id_FC86() {
  var_0 = scripts\sp\utility::_id_10639("player_rig");
  var_0.origin = level.player.origin;
  var_0.angles = level.player.angles;
  var_0 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_0, "shield_intro");
  var_1 = scripts\sp\utility::_id_10639("retract_shield_vm");
  var_2 = scripts\sp\utility::_id_10639("retract_shield_folded_vm");
  var_1 hide();
  var_2 hide();
  var_3 = [var_0, var_1, var_2];
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  wait 0.6;
  var_0 scripts\engine\utility::delaycall(0.05, ::show);
  var_1 scripts\engine\utility::delaycall(0.05, ::show);
  var_2 scripts\engine\utility::delaycall(0.05, ::show);
  thread _id_AD3B(var_0);
  level.player freezecontrols(0);
  thread _id_FC85();
  var_0 scripts\sp\anim::_id_1F2C(var_3, "shield_intro");
  _id_0A2F::_id_66A4("offhandshield");
  level.player enableweapons();
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player unlink();
  scripts\sp\utility::_id_228A(var_3);
  scripts\engine\utility::flag_set("player_shield_intro_done");
}

_id_AD3B(var_0) {
  var_1 = 0.3;
  level.player _meth_823C(var_0, "tag_player", var_1, var_1 * 0.5, var_1 * 0.5);
  level.player scripts\engine\utility::delaycall(var_1, ::playerlinktodelta, var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(var_1 + 0.1, ::lerpviewangleclamp, 0.5, 0.25, 0.25, 10, 10, 10, 10);
}

_id_FC85() {
  wait 2;
  thread _id_0B0A::_id_583F(0, 0, 6, 120, 220, 3, 0.5);
  wait 1.5;
  thread _id_0B0A::_id_583D(1);
}

_id_137CD() {
  while(!level._id_3451.size)
    wait 0.05;

  var_0 = scripts\engine\utility::getclosest(level.player.origin, level._id_3451);

  if(!scripts\sp\utility::_id_D0BD("offhandshield", 1) && !scripts\sp\utility::_id_D0BD("offhandshield_up1", 1))
    var_0 scripts\sp\utility::_id_918B("ar_callouts_huntershield", 0, (0, 0, 0));

  while(!scripts\sp\utility::_id_D0BD("offhandshield", 1) && !scripts\sp\utility::_id_D0BD("offhandshield_up1", 1))
    wait 0.05;

  while(!level.player isonground())
    wait 0.05;

  if(isDefined(level.player._id_20F8))
    level.player._id_20F8 scripts\sp\utility::_id_918C();

  scripts\engine\utility::flag_set("player_grabbed_shield");
}

_id_FC7E() {
  scripts\engine\utility::flag_set("player_grabbed_shield");
  level.player giveweapon("offhandshield");
}

_id_FC7C() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_shield_hallway");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_shield_hallway");
  _id_0E4B::_id_8E06(1);
  level.allies["salter"] scripts\sp\utility::_id_F3B5("y");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("b");
  level.allies["marineCO"] scripts\sp\utility::_id_F3B5("r");
  level.allies["salter"] scripts\sp\utility::_id_61E7();
}

_id_FC7B() {
  level notify("concourse_1_ammo_cleanup");
  level notify("concourse_2_ammo_cleanup");
  scripts\engine\utility::flag_set("player_indoor_p1");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("y");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("b");
  level.allies["marineCO"] scripts\sp\utility::_id_F3B5("r");
  level.allies["eth3n"] scripts\sp\utility::_id_61E7();
  level.allies["marineCO"] scripts\sp\utility::_id_61E7();
  scripts\sp\utility::_id_15F5("shiled_intro_door_colortrig");
  getEnt("shield_hallway_exit_door", "targetname") delete();
  thread _id_FC7A();
  thread _id_FC6E();
  scripts\engine\utility::flag_wait("player_opening_shield_hall_door");
  scripts\engine\utility::delaythread(7, scripts\sp\utility::_id_15F5, "shield_buddy_door_colortrig");
  var_0 = scripts\sp\utility::_id_22CD("coastguard_hallway_enemies", 1);
  thread _id_42FF(var_0);
  scripts\engine\utility::flag_wait("player_opened_shield_hall_door");

  if(scripts\sp\utility::_id_D0BD("offhandshield", 1) || scripts\sp\utility::_id_D0BD("offhandshield_up1", 1))
    thread scripts\sp\utility::_id_56BE("retractable_shield_hint", 5);

  thread _id_28B4();
  scripts\engine\utility::flag_set("shield_hall_ambush");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_CF8D();
  scripts\engine\utility::flag_wait_either("coastguard_hallway_enemies_dead", "player_moving_up_shield_hallway");
  scripts\sp\utility::_id_15F5("spawn_coastguard_c8");
  scripts\sp\utility::_id_15F5("shield_hallway_colortrig");
  scripts\engine\utility::flag_wait_either("coastguard_c8_spawned", "coastguard_hallway_enemies_dead");

  foreach(var_2 in level.allies)
  var_2 scripts\sp\utility::_id_5514();
}

_id_42FF(var_0) {
  while(var_0.size > 2) {
    var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("coastguard_hallway_enemies_dead");
}

_id_FC7A() {
  level endon("moonConcorse_encounter02Start");
  scripts\engine\utility::flag_wait("shield_hall_ambush");
  wait 1;
  scripts\sp\utility::_id_1034D("moon_plr_holdyourline");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_neutralizeandad");
  scripts\engine\utility::flag_wait("player_moving_up_shield_hallway");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_allcallsignsalp");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_nextdeck");
}

_id_FC6E() {
  var_0 = scripts\engine\utility::getStruct("buddy_door_animnode", "targetname");
  level.allies["salter"] thread _id_FC72(var_0);
  var_1 = scripts\engine\utility::getStruct("buddy_door_trigger", "targetname");
  var_1 _id_0E46::_id_48C4(undefined, (0, 0, 5));
  var_1 waittill("trigger");
  scripts\sp\utility::_id_2669("shield_buddy_door");
  var_2 = scripts\sp\utility::_id_10639("player_rig");
  var_2 hide();
  level.player _meth_80D1();
  level.player disableweapons();
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player playSound("scn_moon_door_lerp");
  var_0 scripts\sp\anim::_id_1EC3(var_2, "buddy_door_open");
  level.player _meth_823C(var_2, "tag_player", 1, 0.5, 0);
  wait 1;
  level.player playerlinktodelta(var_2, "tag_player", 1, 0, 0, 0, 0, 1);
  var_2 show();
  scripts\engine\utility::flag_set("player_at_shield_hall_door");
  scripts\engine\utility::flag_wait("salter_at_shield_hall_door");
  scripts\engine\utility::flag_set("player_opening_shield_hall_door");
  thread _id_FC6F();
  level.allies["eth3n"] thread _id_FC70();
  level.player scripts\engine\utility::delaycall(5.4, ::playsound, "scn_moon_buddy_door");
  var_0 scripts\sp\anim::_id_1F35(var_2, "buddy_door_open");
  scripts\engine\utility::flag_set("player_opened_shield_hall_door");
  level.player unlink();
  var_2 delete();
  level.player enableweapons();
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player _meth_80A1();
  level.allies["marineCO"] scripts\sp\utility::_id_61C8();
  level.allies["salter"] scripts\sp\utility::_id_61C8();
  level.allies["eth3n"] scripts\sp\utility::_id_61C8();
}

_id_FC6F() {
  level waittill("c8_buddy_door_dof_salter");
  thread _id_0B0A::_id_583F(0, 0, 6, 175, 200, 3, 1);
  level waittill("c8_buddy_door_dof_mco");
  thread _id_0B0A::_id_583F(0, 75, 5, 75, 150, 3, 1);
  level waittill("c8_buddy_door_dof_off");
  thread _id_0B0A::_id_583D(1);
}

_id_FC72(var_0) {
  var_0 scripts\sp\utility::_id_178D(scripts\sp\anim::_id_1F17, self, "buddy_door_enter");
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "player_at_shield_hall_door");
  scripts\sp\utility::_id_57D6();
  level.allies["salter"] scripts\sp\utility::_id_4125(1, 1, "iw7_m4");
  var_0 scripts\sp\anim::_id_1F35(self, "buddy_door_enter");
  scripts\engine\utility::flag_set("salter_at_shield_hall_door");
  var_0 thread _id_EA56(self);
  var_0 thread scripts\sp\anim::_id_1EEA(self, "buddy_door_idle", "stop_salter_idle");
  scripts\engine\utility::flag_wait("player_opening_shield_hall_door");
  var_1 = [self];
  var_2 = scripts\sp\utility::_id_22CD("concourse_bddy_door_enemies", 1);

  foreach(var_4 in var_2) {
    var_4._id_1FBB = var_4.script_noteworthy;
    var_4 scripts\sp\utility::_id_B14F();
    var_4.ignoreall = 1;
    var_4.ignoreme = 1;
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  var_0 notify("stop_salter_idle");
  level._id_449F.clip connectpaths();
  var_1 = scripts\engine\utility::array_add(var_1, level._id_449F);
  var_6 = scripts\sp\utility::_id_10639("retract_shield");
  var_6 thread _id_FC73();
  var_1 = scripts\engine\utility::array_add(var_1, var_6);
  var_1 = scripts\engine\utility::array_add(var_1, level.allies["marineCO"]);
  var_0 scripts\sp\anim::_id_1F2C(var_1, "buddy_door_open");

  foreach(var_4 in var_2) {
    var_4 scripts\sp\utility::_id_1101B();
    var_4 _meth_81D0();
  }

  level.allies["salter"] scripts\sp\utility::_id_61C7();
  level.allies["salter"] thread scripts\sp\utility::_id_19FA("iw7_m4", "iw7_m8+m8scope_sp", 1024, 0);
  level._id_449F.clip disconnectPaths();
}

_id_FC70() {
  wait 7;
  var_0 = scripts\engine\utility::getStruct("shield_buddy_door_tele_eth3n", "targetname");
  self _meth_80F1(var_0.origin, var_0.angles, 10000000);
}

_id_FC73() {
  self hide();
  level waittill("salter_show_shield");
  self show();
  level waittill("salter_hide_shield");
  self delete();
}

_id_FC6D() {
  scripts\engine\utility::flag_wait("openingIGC_playerArrived");

  if(scripts\engine\utility::flag("player_opened_shield_hall_door")) {
    return;
  }
  var_0 = scripts\engine\utility::getStruct("buddy_door_animnode", "targetname");
  var_1 = scripts\sp\utility::_id_10639("buddy_door_door");
  var_1.clip = getEnt("concourse_buddy_door_clip", "targetname");
  var_0 scripts\sp\anim::_id_1EC3(var_1, "buddy_door_open");
  var_1.clip linkTo(var_1, "door");
  level._id_449F = var_1;
  level waittill("start_decompression");
  var_1.clip delete();
  var_1 delete();
}

_id_EA56(var_0) {
  level endon("player_opening_shield_hall_door");
  var_1 = 5.0;

  for(;;) {
    wait(var_1);
    self notify("stop_salter_idle");
    scripts\sp\anim::_id_1F35(var_0, "buddy_door_nag");
    thread scripts\sp\anim::_id_1EEA(var_0, "buddy_door_idle", "stop_salter_idle");

    if(var_1 < 20)
      var_1 = var_1 + 12;
  }
}

_id_4300() {
  var_0 = self.spawner;
  self endon("death");
  scripts\sp\utility::_id_F417(1);
  scripts\sp\utility::_id_5550();

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "selfdestruct_c6")
    thread _id_4301();

  var_1 = var_0 scripts\sp\utility::_id_7A96();

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = spawn("script_origin", var_1.origin);
  self _meth_82DE(var_2);
  scripts\engine\utility::flag_wait("player_opened_shield_hall_door");
  self clearentitytarget();
  var_2 delete();
}

_id_4301() {
  self endon("death");
  self waittill("reached_path_end");
  scripts\sp\utility::_id_D282();
}

_id_449D() {
  self endon("death");
  self.favoriteenemy = level.player;
  self waittill("reached_path_end");
  scripts\sp\utility::_id_54C6();
}

_id_E334() {
  if(level.player scripts\sp\utility::_id_65DB("player_retract_shield_active"))
    return 1;

  return 0;
}

_id_28B3() {
  if(!level.player scripts\sp\utility::_id_65DB("player_retract_shield_active"))
    return 1;

  return 0;
}

_id_28B4() {
  level.player scripts\sp\utility::_id_65E3("player_retract_shield_active");
  scripts\sp\utility::_id_56BE("shield_bash_hint", 5);
}

_id_FC79() {
  scripts\engine\utility::flag_set("player_opened_shield_hall_door");
}

_id_3440() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_c8_coastguard");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_c8_coastguard");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("y");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("b");
  level.allies["marineCO"] scripts\sp\utility::_id_F3B5("r");
  var_0 = getEnt("shield_hallway_exit_door", "targetname");
  var_0 movez(108, 0.5, 0.25, 0);
  _id_0E4B::_id_8E06(1);
  scripts\engine\utility::delaythread(2, scripts\engine\utility::flag_set, "play_news_bink_mp");
}

_id_343F() {
  scripts\engine\utility::flag_set("player_indoor_p1");
  scripts\engine\utility::flag_wait("coastguard_c8_spawned");
  scripts\engine\utility::delaythread(2, scripts\engine\utility::flag_set, "play_news_bink_mp");
  scripts\sp\utility::_id_266A("c8_coastguard");
  thread _id_343D();
  var_0 = getEnt("coastguard_c8_goalvolume", "targetname");

  foreach(var_2 in level.allies) {
    var_2 scripts\sp\utility::_id_54F7();
    var_2.fixednode = 0;
    var_2 _meth_82DC(300, 250);
    var_2 _meth_82F1(var_0);
  }

  scripts\sp\utility::_id_22CD("coastguard_c8_fight_mdf");
  scripts\engine\utility::flag_wait("coastguard_c8_dead");

  foreach(var_2 in level.allies) {
    var_2 scripts\sp\utility::_id_61C7();
    var_2.fixednode = 1;
    var_2 cleargoalvolume();
  }
}

_id_42FD() {
  scripts\engine\utility::flag_set("coastguard_c8_spawned");
  level._id_42FD = self;
  self._id_1FBB = "c8";
  scripts\sp\utility::_id_F2D8(1);
  self._id_5580 = 1;
  self.goalheight = 5000;
  var_0 = scripts\engine\utility::getStruct("coastguard_c8_animstruct", "targetname");
  var_1 = [];
  var_2 = getspawnerarray("coastguard_c8_intro_mdf");

  foreach(var_6, var_4 in var_2) {
    if(var_6 == 1) {
      continue;
    }
    var_5 = var_4 scripts\sp\utility::_id_10619(1, 1);
    var_5.ignoreme = 1;
    var_5.ignoreall = 1;
    var_5._id_1FBB = "mdf" + var_6;
    var_1[var_6] = var_5;
  }

  var_1[3] scripts\sp\utility::_id_1101B();
  var_1[3] delete();
  var_7 = scripts\engine\utility::getStruct("shield_hallway_ambushers_targetStruct", "targetname");
  var_8 = var_7 scripts\engine\utility::spawn_tag_origin();
  var_8.health = 999999;
  self _meth_82DE(var_8);
  var_9 = [var_1[0], var_1[2]];
  var_0 thread scripts\sp\anim::_id_1F2C(var_9, "coastguard_c8_intro");
  thread _id_3471();
  var_10 = gettime();
  var_11 = 3000;

  while(!scripts\sp\utility::_id_CFAC(self)) {
    if(gettime() - var_10 >= var_11) {
      break;
    }

    wait 0.05;
  }

  _id_0A04::_id_34AC();
  thread _id_343E();
  wait 7;
  self clearentitytarget();
  var_8 delete();
}

_id_3471() {
  var_0 = scripts\engine\utility::getStruct("coastguard_c8_break_glass", "targetname");
  wait 1.7;
  radiusdamage(var_0.origin, 100, 200, 25);
}

_id_343E() {
  self endon("death");
  thread scripts\sp\utility::_id_10346("moon_un1_dontletitin");
  wait 1;
  thread scripts\sp\utility::_id_10346("moon_un2_overhere");
  wait 0.5;
  thread scripts\sp\utility::_id_10346("moon_un1_thishunteristrying");
  wait 0.5;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_friendliesat9oc");
  wait 5.2;
  thread scripts\sp\utility::_id_10346("moon_un2_takeitdown");
}

_id_343D() {
  var_0 = scripts\sp\utility::_id_22CD("coastguard_c8_mdf_retreaters", 1);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_B14F, 1);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_5564);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F416, 1);
  var_1 = getEnt("cg_right_door", "targetname");
  var_2 = getEnt("cg_left_door", "targetname");
  var_3 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_4 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_5 = getEnt(var_3.target, "targetname");
  var_6 = getEnt(var_4.target, "targetname");
  var_5 linkTo(var_1);
  var_6 linkTo(var_2);
  var_7 = var_1.origin;
  var_8 = var_2.origin;
  var_1.origin = var_3.origin;
  var_2.origin = var_4.origin;
  var_5 connectpaths();
  var_6 connectpaths();
  scripts\engine\utility::flag_wait_or_timeout("coastguard_c8_door_close", 4.5);
  var_1 moveTo(var_7, 1, 0.25, 0.5);
  var_2 moveTo(var_8, 1, 0.25, 0.5);
  var_1 waittill("movedone");
  var_5 disconnectPaths();
  var_6 disconnectPaths();
}

_id_42FE() {
  self endon("death");
  var_0 = self.spawner;

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "door_opener") {
    level._id_3BEC = self;
    level._id_3BEC.name = "AN. Herrold";
  } else if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "c8_charger")
    scripts\sp\utility::_id_1101B();

  scripts\engine\utility::flag_wait("start_decompression");

  if(isDefined(self._id_B14F) && self._id_B14F)
    scripts\sp\utility::_id_1101B();

  self delete();
}

_id_343C() {}