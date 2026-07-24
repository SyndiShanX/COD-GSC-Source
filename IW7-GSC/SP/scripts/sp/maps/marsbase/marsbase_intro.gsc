/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_intro.gsc
*******************************************************/

_id_10BB9() {
  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F3FF(1);
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  level.player _meth_82C0("marscrib_dropship_launch_to_marsbase", 0.0);
  var_0 = ["commo", "dropoff", "salter", "gator", "griff", "ethan", "sahora"];
  var_1 = scripts\sp\maps\marsbase\marsbase_code::_id_77E6("group_ally_dropship1", 7);
  var_2 = scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_1);
  var_3 = scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0);
  var_4 = scripts\engine\utility::array_combine(var_2, var_3);
  thread scripts\sp\maps\marsbase\marsbase_util::_id_1C37(var_4, 0);

  foreach(var_6 in var_2)
  var_6.name = "";

  level._id_1495 = ["player_dropship_dropoff", 0, 2, 10, 12, 20, 22, 30, 32, 40, 42, 52];
  var_8 = spawnStruct();
  var_8._id_10871 = "_player_dropship_dday";
  var_8._id_1325F = "dropship_player_parts_dday";
  var_8._id_1325C = "col_dropship_dday";
  level._id_5D6C = _id_0BBF::_id_106B8("player_dropship_dday", undefined, "continue_dropoff_flight", var_4, level._id_1495, var_8);
  level._id_5D6C _id_0BBF::_id_F4B4("straps", "heavy");
  level._id_5DE4 = getEnt("marsebase_intro_dropship_fake_col", "targetname");
  level._id_5DE4 notsolid();
  level._id_5D6C._id_B510 = getEnt("fxanim_sp_mars_dropship_damage_parts_wires", "targetname");
  level._id_5D6C._id_B50F = getEnt("fxanim_sp_mars_dropship_damage_parts", "targetname");
  level._id_5D6C._id_B510 linkTo(level._id_5D6C, "tag_origin");
  level._id_5D6C._id_B50F linkTo(level._id_5D6C, "tag_origin");

  foreach(var_10 in var_4)
  var_10 linkTo(level._id_5D6C);

  thread scripts\sp\maps\marsbase\marsbase_util::_id_1C37(var_4, 1);
  thread _id_10BBA();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_CE53("fxanim_tarp_wall_lrg_01");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_CE53("fxanim_tarp_wall_lrg_02");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_CE53("fxanim_tarp_wall_lrg_03");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_CE53("fxanim_tarp_billow_lrg_01");
  level._id_5D6C thread _id_5E1D();
  thread _id_5DDB(var_2);
  level._id_5D6C thread _id_5EAA();
  thread _id_5DEA("trig_opening_dropship_exit_fx");
  level thread _id_5DDE();
  level thread _id_516A();
  level thread _id_518A();
  level thread _id_514B();
  thread _id_B191();
}

_id_10BBA() {
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A8("dropship3_destroyed");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A8("fxanim_sp_mars_crane");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A9("aa2_destruction");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A9("aa2_rubble");
}

_id_5EAA() {
  self endon("death");
  level waittill("dropship_first_shake");
  thread set_sun_sample_size();
  thread _id_10C26("int", "cabin", 0.05, 0.3, 6, 1);
  level.player playRumbleOnEntity("damage_bullet");
  level._id_5D6C _id_0BBF::_id_10C25(1);
  _id_0BBF::_id_F328("low", 1);
  level waittill("dropship_second_shake");
  thread _id_10C26("int", "cabin", 0.05, 0.2, 8, 1);
  level.player playRumbleOnEntity("damage_bullet");
  _id_4D22();
  level waittill("dropship_third_shake");
  scripts\sp\utility::_id_2669("intro_dropship_pre_landing");
  level.player clearclienttriggeraudiozone(0.3);
  thread _id_10C26("int", "cabin", 0.05, 0.1, 10, 1);
  level.player playRumbleOnEntity("mars_dropship_hard_landing");
  level waittill("dropship_big_explosion");
  thread _id_10C26("int", "cabin", 0.05, 0.075, 30, 1);
  var_0 = getEnt("fxanim_sp_mars_platform_debris_01", "targetname");
  var_0 scripts\sp\utility::_id_23B7("fxanim_platform_debris");
  var_0 thread scripts\sp\anim::_id_1F35(var_0, "dropship_exit_platform_debris");
  scripts\sp\utility::_id_16AE(var_0, "aa1_gate_close");
  level.player playRumbleOnEntity("mars_dropship_hard_landing");
  level.player playSound("mars_base_intro_exp");
  scripts\engine\utility::exploder("vfx_exp_dropship_exit_explosion");
  thread _id_4D21();
}

set_sun_sample_size() {
  setsaveddvar("sm_sunsamplesizenear", 1.15);
}

_id_5E1D() {
  self endon("death");
  level._id_5D6C._id_B510 scripts\sp\utility::_id_23B7("dropship_intro_wires");
  level._id_5D6C._id_B50F scripts\sp\utility::_id_23B7("dropship_intro_damage_parts");
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_5D6C._id_B510, "fxanim_dropship_intro_wires_slow", "stop_wires");
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5D6C._id_B50F, "fxanim_dropship_intro_damage");
  level waittill("dropship_open_door");
  thread _id_0BBC::_id_C5F1("back");
  playFXOnTag(level._effect["vfx_marsbase_intro_dropship_open_dust"], self, "tag_origin");
  _id_0BBF::_id_F454(1, "int", "sunfake");
  level._id_5D6C notify("stop_wires");
  scripts\engine\utility::waitframe();
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_5D6C._id_B510, "fxanim_dropship_intro_wires_fast", "stop_wires");
  level waittill("dropship_landed");
  wait 1;
  thread scripts\sp\maps\marsbase\marsbase_code::_id_B3A0();
  level._id_5D6C notify("stop_wires");
  scripts\engine\utility::waitframe();
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(level._id_5D6C._id_B510, "fxanim_dropship_intro_wires_slow", "stop_wires");
}

_id_4D22() {
  _id_0BBF::_id_10FDA();
  _id_0BBF::_id_CCE8("damage", "ceiling", "vfx_mars_dropship_steamvent");
  scripts\engine\utility::waitframe();
  _id_0BBF::_id_CCE8("damage", "floor_temp", "vfx_mars_dropship_dmg_smoke_cabin");
  scripts\engine\utility::waitframe();
  _id_0BBF::_id_CCEA("damage", "corner", ["vfx_mars_dropship_dmg_smoke_burst"], 5, 30, "dropship_spark_small");
  scripts\engine\utility::waitframe();
  _id_0BBF::_id_CCEA("damage", "wall", ["vfx_mars_dropship_dmg_smoke_burst"], 5, 30, "dropship_player_glass_crack");
  scripts\engine\utility::waitframe();
  _id_0BBF::_id_CCE4("dropship_alarm_damage_1");
}

_id_4D21() {
  self endon("death");
  self endon("stop_dropship_intro_damage");
  _id_0BBF::_id_10FDA();
  _id_0BBF::_id_CCE8("damage", "ceiling", "vfx_mars_dropship_steamvent");
  _id_0BBF::_id_CCE8("damage", "floor_temp", "vfx_mars_dropship_dmg_smoke_cabin");
  scripts\engine\utility::waitframe();
  _id_0BBF::_id_CCEA("damage", "corner", ["vfx_mars_dropship_dmg_smoke_burst"], 1, 3, "dropship_player_glass_crack");
  scripts\engine\utility::waitframe();
  _id_0BBF::_id_CCEA("damage", "wall", ["vfx_mars_dropship_dmg_smoke_burst"], 1, 3, "dropship_spark_small");
  scripts\engine\utility::waitframe();
  _id_0BBF::_id_CCE4(["dropship_player_damaged_95_percent_alarm", "dropship_player_tube_hiss"]);
  level.player._id_2716 = 1;

  for(;;) {
    if(distance(level.player.origin, self.origin) > 400 && level.player._id_2716) {
      _id_0BBF::_id_10FDA();
      level.player._id_2716 = 0;
    } else if(distance(level.player.origin, self.origin) < 400 && !level.player._id_2716) {
      _id_0BBF::_id_CCE4(["dropship_player_damaged_95_percent_alarm", "dropship_player_tube_hiss"]);
      level.player._id_2716 = 1;
    }

    wait 2.5;
  }
}

_id_10C26(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("end_dropship_light_flicker_" + var_0 + "_" + var_1);
  self endon("end_dropship_light_flicker_" + var_0 + "_" + var_1);
  self endon("death");

  for(var_6 = 0; var_6 < var_4; var_6++) {
    _id_0BBF::_id_F454(0, var_0, var_1);

    if(var_1 == "cabin")
      _id_0BBF::_id_F451(0);

    wait(randomfloatrange(var_2, var_3));
    _id_0BBF::_id_F454(1, var_0, var_1);

    if(var_1 == "cabin")
      _id_0BBF::_id_F451(1);

    wait(randomfloatrange(var_2, var_3));

    if(scripts\engine\utility::cointoss())
      wait(var_3);
  }

  _id_62C9(var_0, var_1, var_5);
}

_id_62C9(var_0, var_1, var_2) {
  if(scripts\engine\utility::is_true(var_2)) {
    thread _id_0BBF::_id_F454(1, var_0, var_1);

    if(var_1 == "cabin")
      _id_0BBF::_id_F451(1);
  } else {
    thread _id_0BBF::_id_F454(0, var_0, var_1);

    if(var_1 == "cabin")
      _id_0BBF::_id_F451(0);
  }

  self notify("end_dropship_light_flicker_" + var_0 + "_" + var_1);
}

_id_5DA9(var_0) {
  self notify("end_cycle_floor_lights");
  self endon("end_cycle_floor_lights");
  self endon("death");

  for(;;) {
    _id_0BBF::_id_F454(0, "int", "floor04");
    _id_0BBF::_id_F454(1, "int", "floor01");
    wait(var_0);
    _id_0BBF::_id_F454(0, "int", "floor01");
    _id_0BBF::_id_F454(1, "int", "floor02");
    wait(var_0);
    _id_0BBF::_id_F454(0, "int", "floor02");
    _id_0BBF::_id_F454(1, "int", "floor03");
    wait(var_0);
    _id_0BBF::_id_F454(0, "int", "floor03");
    _id_0BBF::_id_F454(1, "int", "floor04");
    wait(var_0);
  }
}

_id_5DAD() {
  self endon("death");
  var_0 = undefined;
  var_1 = [];
  var_2 = getEntArray("dropship_player_parts_dday", "script_noteworthy");

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_EE52)) {
      if(var_4._id_EE52 == "decompression_claxon_rr")
        var_0 = var_4;

      if(var_4._id_EE52 == "klaxon_light_rr")
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  scripts\sp\maps\marsbase\marsbase_util::_id_A6E3(var_0, var_1, 1);
  level waittill("stop_dropship_intro_klaxon");
  scripts\sp\maps\marsbase\marsbase_util::_id_A6E3(var_0, var_1, 0);
  level waittill("stop_dropship_intro_klaxon_remove");

  foreach(var_7 in var_1)
  var_7 setlightintensity(0);

  var_0 delete();
}

_id_5DEA(var_0) {
  scripts\sp\utility::_id_127AE(var_0, "targetname");
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1._id_EDEC))
    var_2 = var_1._id_EDEC;
  else
    var_2 = 0.5;

  var_3 = scripts\engine\utility::getStructArray(var_1.target, "targetname");

  foreach(var_5 in var_3) {
    playFX(scripts\engine\utility::getfx("vfx_mars_dropship_exterior_explosion"), var_5.origin);
    thread _id_0BDC::_id_D527("mars_base_dropship_exp", var_5.origin);
    earthquake(0.3, var_2, var_5.origin, 10000);
    wait(var_2);
  }
}

_id_518A() {
  var_0 = getEntArray("dev_pip_ents", "script_noteworthy");
  scripts\sp\utility::_id_228A(var_0);
}

_id_514B() {
  wait 0.1;
  var_0 = getEntArray("dropship2_parts", "script_noteworthy");
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("dropship3_parts", "script_noteworthy"));
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.classname == "light_spot" || var_3.classname == "light_omni" || var_3.classname == "light_static") {
      if(!issubstr(var_3._id_EDFF, "emergency") && !issubstr(var_3._id_EDFF, "running"))
        var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  foreach(var_6 in var_1)
  var_6 setlightintensity(0);
}

_id_5160() {
  wait 0.1;
  var_0 = getEntArray("dropship_player_parts_dday", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.classname == "locator_volume" || isDefined(var_3._id_EDFF) && (issubstr(var_3._id_EDFF, "int") || issubstr(var_3._id_EDFF, "ext")))
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  foreach(var_6 in var_1)
  var_6 setlightintensity(0);

  level notify("stop_dropship_intro_klaxon_remove");
}

_id_516A() {
  wait 0.5;
  _id_0BBF::_id_5D92("player_dropship", "dropship_player_parts");
}

_id_515F(var_0) {
  if(scripts\engine\utility::is_true(var_0)) {
    _id_0BBF::_id_5D92("player_dropship_dday", "dropship_player_parts_dday");
    return;
  }

  if(isDefined(level._id_5D6C)) {
    var_1 = [];

    if(isDefined(level._id_5D6C._id_B510))
      var_1 = scripts\engine\utility::array_add(var_1, level._id_5D6C._id_B510);

    if(isDefined(level._id_5D6C._id_B50F))
      var_1 = scripts\engine\utility::array_add(var_1, level._id_5D6C._id_B50F);

    wait 0.5;

    if(isDefined(level._id_5D6C))
      level._id_5D6C delete();

    wait 0.5;
    var_1 = scripts\engine\utility::array_removeundefined(var_1);
    scripts\sp\utility::_id_228A(var_1);
  }
}

_id_5ED5() {
  if(isDefined(level._id_1495))
    level._id_1495 = undefined;

  if(isDefined(level._id_5DE4))
    level._id_5DE4 = undefined;

  if(isDefined(level._id_5D6C._id_B510))
    level._id_5D6C._id_B510 = undefined;

  if(isDefined(level._id_5D6C._id_B50F))
    level._id_5D6C._id_B50F = undefined;
}

_id_B191() {
  setsuncolorandintensity(0);
  settransientvisibility("marsbase_combat_intro_tr", 0);
  settransientvisibility("marsbase_combat_to_grinder_tr", 0);
  settransientvisibility("marsbase_elevator_lowres_tr", 0);
  level._id_5D6C _id_0BBF::_id_F455();
  level._id_5D6C _id_0BBF::_id_F454(0, "int", "cabin");
  level._id_5D6C _id_0BBF::_id_F454(0, "int", "hero");
  level._id_5D6C _id_0BBF::_id_F454(0, "int", "cabinfill");
  level._id_5D6C _id_0BBF::_id_F454(0, "int", "floor01");
  level._id_5D6C _id_0BBF::_id_F454(0, "int", "floor02");
  level._id_5D6C _id_0BBF::_id_F454(0, "int", "floor03");
  level._id_5D6C _id_0BBF::_id_F454(0, "int", "floor04");
  level._id_5D6C _id_0BBF::_id_F451(0);
  level._id_5D6C _id_0BBF::_id_F454(0, "int", "marsbaserear");
  level._id_5D6C _id_0BBF::_id_F454(0, "int", "marsbasecenter");
  level._id_5D6C _id_0BBF::_id_F454(0, "int", "marsbasefront");
  level._id_5D6C thread _id_5DAD();
  wait 0.55;
  level.player _meth_82C0("marsbase_dropship_no_amb", 5.0);
  level._id_5D6C _id_0BBF::_id_F451(1);
  level._id_5D6C thread _id_10C26("int", "cabin", 0.05, 0.2, 8, 1);
  level._id_5D6C thread _id_0BBF::_id_F454(1, "int", "hero");
  level._id_5D6C thread _id_0BBF::_id_F454(1, "int", "cabinfill");
  wait 5.0;
  settransientvisibility("marsbase_combat_intro_tr", 1);
  settransientvisibility("marsbase_combat_to_grinder_tr", 1);
  settransientvisibility("marsbase_elevator_lowres_tr", 1);
  resetsunlight();
  level waittill("dropship_open_door");
  wait 5.0;
  level notify("stop_dropship_intro_klaxon");
  level._id_5D6C thread _id_0BBF::_id_F454(1, "ext", "running");
  level._id_5D6C thread _id_0BBF::_id_F454(1, "ext", "tailgate");
}

_id_B190() {
  scripts\sp\utility::_id_13705();
  thread scripts\sp\utility::_id_12641("marsbase_prime_tr");
  thread scripts\sp\utility::_id_12641("marsbase_dropship_hero_tr");
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_level_transition", 3);
  var_0 = getEnt("fxanim_rockslide", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  var_1 = getEnt("fxanim_sp_mars_jackal_crash_debris", "targetname");

  if(isDefined(var_1)) {
    var_1 hide();
    scripts\sp\utility::_id_16AE(var_1, "aa1");
  }

  var_2 = getEntArray("enemy_base_intro_spawners", "targetname");
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_1747, ::_id_2882);
  var_3 = getnodearray("base_intro_mg_nodes", "targetname");
  var_3 = scripts\engine\utility::array_combine(var_3, getnodearray("base_intro_sdf_mg_turret_node", "targetname"));
  scripts\engine\utility::array_call(var_3, ::_meth_80AC);
  thread _id_5D59();
  setmusicstate("marsbase_intro");
  scripts\engine\utility::delaythread(1.5, scripts\sp\maps\marsbase\marsbase_code::_id_C2AC, "lead_assault");
  level waittill("dropship_open_door");
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_1_1");
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_1_2");
  thread scripts\sp\utility::_id_266F();
  thread _id_2880();
  level waittill("dropship_big_explosion");
  level.player scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_10350, "marsbase_mac_thisisecho1were");
  scripts\engine\utility::delaythread(2.5, scripts\sp\utility::_id_15F5, "trig_base_intro_spawn_enemies_1");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10683("control_tower_airlock_spawn");
  scripts\engine\utility::array_call(var_3, ::_meth_808B);
  thread _id_2886();
  scripts\engine\utility::flag_clear("flag_retreat_base_intro_1");
  scripts\engine\utility::flag_wait("flag_retreat_base_intro_1");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_10681("control_tower_airlock_spawn", undefined, undefined, 1);
  thread _id_5D5A();
  level.player scripts\engine\utility::delaythread(3, scripts\sp\maps\marsbase\marsbase_util::_id_A605, "trig_kill_player_magic_bullet_start", "s_kill_player_magic_bullet_start", "flag_retreat_base_intro_1");
  thread _id_A060();
  thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_542E();
  thread _id_2881();
  scripts\engine\utility::flag_clear("flag_retreat_base_intro_2");
  level thread _id_2885("enemy_base_intro_jetpack_spawners");
  scripts\engine\utility::delaythread(2, ::_id_2885, "enemy_base_intro_jetpack_spawners_2");
  scripts\engine\utility::flag_wait("flag_retreat_base_intro_2");
  scripts\engine\utility::flag_set("flag_retreat_base_intro_2");
  scripts\engine\utility::flag_wait("flag_salter_scene_done");
  level._id_8E42 = scripts\sp\utility::_id_22B9(level._id_8E42);
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\maps\marsbase\marsbase_util::_id_61C9, 1);
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\utility::_id_61C7);
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\utility::_id_F3B5, "r");
  scripts\sp\utility::_id_15F5("trig_base_intro_allies_2");
  var_4 = scripts\sp\utility::_id_77DA("group_enemy_base_intro");
  scripts\engine\utility::array_thread(var_4, ::_id_2883);
  scripts\engine\utility::flag_set("flag_retreat_base_intro_3");
  scripts\engine\utility::flag_wait_or_timeout("flag_retreat_base_intro_4", 30);
  scripts\engine\utility::flag_set("flag_retreat_base_intro_4");
}

_id_2881() {
  scripts\engine\utility::flag_wait_any("flag_retreat_base_intro_2", "flag_retreat_base_intro_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_106B2("droppod_base_intro_2", undefined, "aa1_gate_close");
}

_id_2884() {
  level endon("flag_retreat_base_intro_2");
  thread _id_14DD();

  for(;;) {
    var_0 = scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_10207("ambient_crash_start_landing", randomfloatrange(0.5, 1.5), "allies", randomintrange(250, 400), 0, randomintrange(2, 4), 1);
    var_0 = scripts\sp\utility::_id_22B9(var_0);

    foreach(var_2 in var_0)
    var_2._id_2713 = 1;

    scripts\sp\utility::_id_13753(var_0, undefined, 5);
  }
}

_id_2880() {
  if(isDefined(level.gun["aa_gun_1_1"])) {
    var_0 = scripts\engine\utility::getStructArray("aa_gun_1_1_targets", "targetname");
    level.gun["aa_gun_1_1"] thread scripts\sp\maps\marsbase\marsbase_code::_id_14E2(undefined, 3);
  }

  if(isDefined(level.gun["aa_gun_1_2"])) {
    var_0 = scripts\engine\utility::getStructArray("aa_gun_1_2_targets", "targetname");
    level.gun["aa_gun_1_2"] scripts\engine\utility::delaythread(10, scripts\sp\maps\marsbase\marsbase_code::_id_14E2, undefined, 3);
  }

  if(isDefined(level.gun["aa_gun_2"])) {
    var_0 = scripts\engine\utility::getStructArray("s_aa2_gun_target", "targetname");
    level.gun["aa_gun_2"] thread scripts\sp\maps\marsbase\marsbase_code::_id_14E2(undefined, 3);
  }

  if(isDefined(level.gun["aa_gun_3"])) {
    var_0 = scripts\engine\utility::getStructArray("aa_gun_1_1_targets", "targetname");
    level.gun["aa_gun_3"] thread scripts\sp\maps\marsbase\marsbase_code::_id_14E2(undefined, 3);
  }

  if(isDefined(level.gun["aa_gun_4"])) {
    var_0 = scripts\engine\utility::getStructArray("aa_gun_1_1_targets", "targetname");
    level.gun["aa_gun_4"] scripts\engine\utility::delaythread(4, scripts\sp\maps\marsbase\marsbase_code::_id_14E2, undefined, 3);
  }
}

_id_2883() {
  self endon("death");
  wait(randomfloatrange(0.05, 0.25));
  scripts\sp\utility::_id_F3BC();
  self _meth_82F1(level._id_8438["vol_base_intro_final_retreat"]);
  scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_12BFA);
}

_id_2882() {
  self endon("death");
  scripts\sp\utility::_id_F415(1);
  level scripts\engine\utility::waittill_notify_or_timeout("intro_enemies_fire", 10);
  scripts\sp\utility::_id_F415(0);
}

_id_2885(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!isDefined(var_3.count))
      var_3.count = 1;

    var_4 = var_3.count;

    for(var_5 = 0; var_5 < var_4; var_5++) {
      if(isDefined(var_3))
        var_3 scripts\sp\utility::_id_10619(1);

      wait 1;
    }
  }
}

_id_2886() {
  var_0 = scripts\sp\utility::_id_107EA("enemy_base_intro_turret_guy", 1);
  var_0 waittill("goal");
  var_0 thread _id_129F8();
  var_0.health = 15;
  var_0 scripts\sp\utility::_id_135F1("death", 45);
  level notify("base_intro_turret_death");
  scripts\engine\utility::flag_set("flag_retreat_base_intro_3");
}

_id_129F8() {
  self endon("death");
  scripts\engine\utility::flag_wait("flag_retreat_base_intro_1");
  wait 5;
  var_0["rest_time_min"] = 1;
  var_0["rest_time_max"] = 2;
  var_0["num_bursts_min"] = 10;
  var_0["num_bursts_max"] = 20;
  var_0["time_between_shots"] = 0.3;

  while(isalive(self) && isalive(level.player)) {
    var_1 = randomintrange(var_0["num_bursts_min"], var_0["num_bursts_max"]);

    for(var_2 = 0; var_2 < var_1; var_2++) {
      if(isalive(level.player)) {
        if(!scripts\engine\utility::is_true(self._id_2717)) {}

        self shoot(0.4, level.player gettagorigin("j_head"), 1, 0, 1);
      }

      wait(var_0["time_between_shots"]);
    }

    self notify("turret_guy_resting");
    wait(randomfloatrange(var_0["rest_time_min"], var_0["rest_time_max"]));
  }
}

_id_129F9(var_0) {
  self playLoopSound("mars_base_turret_override");
  self._id_2717 = 1;
  scripts\engine\utility::waittill_any_ents(self, "death", self, "turret_guy_resting");
  self._id_2717 = 0;
  self stoploopsound();
}

_id_3B43() {
  thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_1DF1();
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  thread _id_2880();
  var_0 = getEnt("fxanim_rockslide", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  var_1 = getEnt("fxanim_sp_mars_jackal_crash_debris", "targetname");

  if(isDefined(var_1)) {
    var_1 hide();
    scripts\sp\utility::_id_16AE(var_1, "aa1");
  }

  level thread _id_516A();
  level thread _id_518A();
  level thread _id_514B();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_CE53("fxanim_tarp_wall_lrg_01");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_CE53("fxanim_tarp_wall_lrg_02");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_CE53("fxanim_tarp_wall_lrg_03");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_CE53("fxanim_tarp_billow_lrg_01");
  thread scripts\sp\maps\marsbase\marsbase_code::_id_B3A0();
}

_id_5E1C() {
  var_0 = spawnStruct();
  var_0._id_10871 = "_player_dropship_dday";
  var_0._id_1325F = "dropship_player_parts_dday";
  var_0._id_1325C = "col_dropship_dday";
  level._id_5D6C = _id_0BBF::_id_106B8("player_dropship_dday", undefined, undefined, undefined, undefined, var_0);
  level._id_5DE4 = getEnt("marsebase_intro_dropship_fake_col", "targetname");
  level._id_5D6C scripts\sp\utility::_id_23B7("dropship_intro");
  var_1 = scripts\engine\utility::getStruct("drop_ship_land", "targetname");
  var_1 thread scripts\sp\anim::_id_1F35(level._id_5D6C, "dropship_exit");
  scripts\engine\utility::delaythread(0.1, scripts\sp\anim::_id_1F2A, [level._id_5D6C], "dropship_exit", 0.95);
  level._id_5D6C _id_0BBF::_id_10C25(1);
  level._id_5D6C thread _id_0BBF::_id_F454(1, "int", "marsbaserear");
  level._id_5D6C thread _id_0BBF::_id_F454(1, "int", "marsbasecenter");
  level._id_5D6C thread _id_0BBF::_id_F454(1, "int", "marsbasefront");
  level._id_5D6C thread _id_0BBC::_id_4265("back");
  level._id_5D6C thread _id_0BBF::_id_F455();
  level._id_5D6C _meth_83E8();
  level._id_5D6C notify("stop_kicking_up_dust");
  level._id_5D6C thread _id_4D22();
  level._id_5D6C scripts\engine\utility::delaythread(0.5, ::_id_4D21);
  level._id_5D6C scripts\sp\utility::_id_65DD("dynamicThrusters");
  level._id_5D6C scripts\sp\utility::_id_65DD("thrusterEffects");
  level._id_5D6C notify("turnengineoff");
}

_id_4058() {
  var_0 = getEntArray("droppod_base_intro_3", "script_noteworthy");
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("kill_player_magic_bullet_aa_gun_1", "targetname"));
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("cleanup_base_intro_volumes", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("start_area_explosive_barrels", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("trig_kill_player_magic_bullet_start", "targetname"));
  scripts\sp\utility::_id_228A(var_0);
  var_1 = undefined;
  var_2 = getEntArray("control_tower_airlock_spawn", "script_noteworthy");

  foreach(var_4 in var_2) {
    if(var_4.classname == "script_model" || var_4.classname == "script_brushmodel")
      scripts\sp\utility::_id_16AE(var_4, "aa1_gate_close");
  }

  if(isDefined(level._id_4074) && isDefined(level._id_4074["aa1_gate_close"]))
    scripts\sp\utility::_id_4074("aa1_gate_close");
}

_id_5D59() {
  while(!isDefined(level._id_5D6C))
    scripts\engine\utility::waitframe();

  level.player _meth_8244("light_steady");
  var_0 = scripts\engine\utility::array_combine(scripts\sp\utility::_id_77DA("group_ally_dropship1"), [level._id_444D, level._id_5D2E, level._id_EA29]);
  var_1 = scripts\engine\utility::array_removeundefined(scripts\engine\utility::array_combine(scripts\sp\utility::_id_77DA("group_ally_dropship1"), level._id_1684));
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F3B5, "o");
  level._id_5D6C scripts\sp\utility::_id_65E0("flag_open_door");
  level._id_5D6C._id_5971 = 1;
  level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "dropship_exits_finished");
  scripts\sp\utility::_id_57D5();
  level.player stoprumble("light_steady");
  level._id_5D6C _id_0BBF::_id_F455();
  level._id_5D6C _meth_83E8();
  level._id_5D6C notify("stop_kicking_up_dust");
  level._id_5D6C._id_4D94._id_4348 _meth_80AF(undefined);
  level._id_5D6C._id_4D94._id_5A01._id_4348 notsolid();

  foreach(var_3 in var_1)
  var_3 unlink();

  level notify("intro_enemies_fire");
  wait 3;
  level notify("allies_unignore");
  var_0 = scripts\engine\utility::array_removeundefined(var_0);

  foreach(var_6 in var_0)
  var_6.health = 5;

  var_8 = scripts\engine\utility::getStruct("struct_murder_ci", "targetname");

  foreach(var_6 in sortbydistance(var_0, var_8.origin)) {
    if(isDefined(var_6)) {
      var_6 scripts\sp\maps\marsbase\marsbase_util::_id_4046(1, var_8.origin);
      wait(randomfloatrange(0.25, 0.75));
    }
  }
}

_id_5DDB(var_0) {
  var_1 = [level._id_444D, level._id_5D2E, level._id_8604, level._id_EA2C, level._id_6754, level._id_EA29, level._id_76FB];

  if(var_0.size == 7) {
    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_3 = var_2 + 1;
      var_0[var_2]._id_1FBB = "dropship_redshirt" + var_3;
    }

    level._id_5D6C thread scripts\sp\anim::_id_1F33(var_0, "dropship_exit");
  }

  thread hide_allies_dropship_exit_scene();
  thread _id_CDC9();
  level._id_5D6C scripts\sp\utility::_id_23B7("dropship_intro");
  level thread _id_5DEB();
  level._id_5D6C scripts\sp\anim::_id_1F33(var_1, "dropship_exit");
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  thread _id_5DDF(var_0);
  level._id_5D6C scripts\sp\utility::_id_65DD("dynamicThrusters");
  level._id_5D6C scripts\sp\utility::_id_65DD("thrusterEffects");
  level._id_5D6C notify("turnengineoff");
  level notify("dropship_exits_finished");
}

hide_allies_dropship_exit_scene() {
  wait 4;
  level._id_5D2E hide();
  level._id_444D hide();
  wait 3;
  level._id_5D2E show();
  level._id_444D show();
}

_id_5DEB() {
  var_0 = scripts\engine\utility::getStruct("drop_ship_land", "targetname");
  var_0.angles = (0, 0, 0);
  var_0 scripts\sp\anim::_id_1F35(level._id_5D6C, "dropship_exit");
  level._id_5D6C playSound("mars_base_dropship_exit");
  level notify("dropship_landed");
}

_id_CDC9() {
  level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig");
  level.player._id_E505 linkTo(level._id_5D6C);
  level.player._id_E505 hide();
  level._id_5D6C scripts\sp\anim::_id_1EC3(level.player._id_E505, "dropship_exit");
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player _meth_823C(level.player._id_E505, "tag_player", 0);
  level.player._id_E505 show();
  var_0 = scripts\engine\utility::getStruct("drop_ship_land", "targetname");
  var_0.angles = (0, 0, 0);
  level._id_5D6C scripts\sp\anim::_id_1F35(level.player._id_E505, "dropship_exit");
  level.player unlink();
  level.player._id_E505 delete();
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level thread _id_5E6A();
  level notify("dropship_exits_finished_player");
}

_id_5DDF(var_0) {
  level._id_8E42 = [level._id_6754, level._id_EA2C, level._id_76FB, level._id_EA29, level._id_8604];
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\maps\marsbase\marsbase_util::_id_12BA0);
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\utility::_id_54F7);
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\utility::_id_5564);
  level._id_EA2C scripts\sp\utility::_id_F3BC();
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\maps\marsbase\marsbase_util::_id_61C9, 0);

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_3 = 0;

      switch (var_2._id_1FBB) {
        case "dropship_redshirt1":
          var_4 = getnode("node_dropship_exit_ally01", "targetname");
          break;
        case "dropship_redshirt2":
          var_4 = getnode("node_dropship_exit_ally02", "targetname");
          break;
        case "dropship_redshirt4":
          var_4 = getnode("node_dropship_exit_ally04", "targetname");
          break;
        case "dropship_redshirt5":
          var_4 = getnode("node_dropship_exit_ally05", "targetname");
          break;
        case "dropship_redshirt6":
          var_4 = getnode("node_dropship_exit_ally06", "targetname");
          break;
        case "dropship_redshirt7":
          var_4 = getnode("node_dropship_exit_ally07", "targetname");
          var_3 = 3;
          var_2 scripts\sp\utility::_id_5564();
          break;
        default:
          var_4 = undefined;
          continue;
      }

      if(isDefined(var_4))
        var_2 scripts\sp\utility::_id_F3D9(var_4);

      var_2 thread _id_A60C(var_3);
    }
  }

  var_6 = getnode("node_dropship_exit_gator", "targetname");
  level._id_76FB scripts\sp\utility::_id_F3D9(var_6);
  thread _id_EAE6();
  var_6 = getnode("node_dropship_exit_ethan", "targetname");
  level._id_6754 scripts\sp\utility::_id_F3D9(var_6);
  var_6 = getnode("node_dropship_exit_sahora", "targetname");
  level._id_EA29 scripts\sp\utility::_id_F3D9(var_6);
  var_6 = getnode("node_dropship_exit_griff", "targetname");
  level._id_8604 scripts\sp\utility::_id_F3D9(var_6);
  level._id_444D setgoalpos(level._id_444D.origin);
  level._id_5D2E setgoalpos(level._id_5D2E.origin);
  level._id_EA29 thread _id_A60C(3);
  level._id_444D thread _id_A60C(3);
  level._id_5D2E thread _id_A60C(3);
  wait 3;
  level._id_8E42 = scripts\sp\utility::array_removedeadvehicles(level._id_8E42);
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\utility::_id_F415, 0);
  wait 3;
  level._id_8E42 = scripts\sp\utility::array_removedeadvehicles(level._id_8E42);
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\utility::_id_6224);
  var_7 = getnodearray("nodes_dropship_exit_redshirts", "script_noteworthy");
  scripts\engine\utility::array_call(var_7, ::_meth_80AC);
}

_id_A60C(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::getStruct("struct_murder_ci", "targetname");

  if(isDefined(var_0))
    wait(var_0);

  var_2 = var_1.origin;
  scripts\sp\utility::_id_6224();
  self._id_5952 = 1;
  scripts\engine\utility::delaycall(2.9, ::_meth_83A1);
  scripts\engine\utility::delaythread(2.9, scripts\sp\maps\marsbase\marsbase_util::_id_1101C);
  scripts\engine\utility::delaycall(3, ::_meth_81D0, var_2);

  while(isalive(self)) {
    var_3 = self gettagorigin("j_spineupper");
    magicbullet("iw7_ar57", var_2, var_3);
    bullettracer(var_2, var_3, "iw7_ar57", 1);
    playFXOnTag(scripts\engine\utility::getfx("vfx_mars_bul_imp_blood_redshirt"), self, "j_spineupper");
    wait(randomfloatrange(0.25, 0.75));
  }
}

_id_5DDE() {
  level waittill("dropship_open_door");
  wait 1;
  level._id_5D6C playSound("mars_base_intro_gunfire_oneshot");
  playFXOnTag(scripts\engine\utility::getfx("vfx_mars_dropship_gunfire_up_runner"), level._id_5D6C, "tag_origin");
  level waittill("dropship_third_shake");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_dropship_gunfire_up_runner"), level._id_5D6C, "tag_origin");
  var_0 = spawn("script_origin", (26772, 15104, -11564));
  wait 1;
  var_0 playLoopSound("mars_base_intro_gunfire_loop");
  playFXOnTag(scripts\engine\utility::getfx("vfx_mars_dropship_gunfire_runner"), level._id_5D6C, "tag_origin");
  scripts\engine\utility::flag_wait_or_timeout("flag_retreat_base_intro_1", 7);
  level notify("stop_dropship_gunfire");
  var_0 playSound("mars_base_intro_gunfire_loop_out");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_dropship_gunfire_runner"), level._id_5D6C, "tag_origin");
  var_0 stoploopsound();
  wait 3;
  var_0 delete();
}

_id_5E6A() {
  level endon("flag_retreat_base_intro_1");
  var_0 = scripts\engine\utility::getStruct("struct_murder_ci", "targetname");
  var_1 = var_0.origin;
  level.player _meth_80D1();
  level.player scripts\engine\utility::delaycall(3, ::_meth_80A1);
  var_2 = 0;

  while(isalive(level.player) && var_2 < 15) {
    var_3 = randomfloatrange(0.75, 1.25);
    wait(var_3);
    var_2 = var_2 + var_3;
    var_4 = level.player gettagorigin("j_spineupper");
    bullettracer(var_1, var_4, "iw7_ar57", 1);
    magicbullet("iw7_ar57", var_1, var_4);
  }

  if(isalive(level.player) && !level.player _meth_8525())
    level.player _meth_81D0();
}

_id_EAE6() {
  var_0 = scripts\engine\utility::getStruct("xo_awesome", "targetname");
  var_1 = scripts\sp\utility::_id_107EA("sp_salter_victim");
  var_1._id_1FBB = "salter_victim";
  var_1 scripts\sp\utility::_id_B14F(1);
  var_1 scripts\sp\utility::_id_F3DD(32);
  var_2["salter_takedown_actors"] = [level._id_EA2C, var_1];
  var_3 = getnode("node_dropship_exit_salter", "targetname");
  var_3 _meth_80AC();
  scripts\engine\utility::array_thread(var_2["salter_takedown_actors"], scripts\sp\utility::_id_F415, 1);
  scripts\engine\utility::array_thread(var_2["salter_takedown_actors"], scripts\sp\utility::_id_F416, 1);
  scripts\engine\utility::array_thread(var_2["salter_takedown_actors"], scripts\sp\utility::_id_623B);
  var_0 scripts\sp\anim::_id_1F0A(var_2["salter_takedown_actors"], "salter_takedown");
  scripts\engine\utility::flag_wait("flag_retreat_base_intro_1");
  var_1 scripts\sp\utility::_id_1101B();
  var_0 scripts\sp\anim::_id_1F2C(var_2["salter_takedown_actors"], "salter_takedown");
  scripts\engine\utility::flag_set("flag_salter_scene_done");

  if(isalive(var_1))
    var_1 _meth_81D0();

  level._id_EA2C scripts\sp\utility::_id_F415(0);
  level._id_EA2C scripts\sp\utility::_id_F416(0);
  level._id_EA2C scripts\sp\utility::_id_5588();
  var_3 _meth_808B();
  level._id_EA2C scripts\sp\utility::_id_F3BC();
  level._id_EA2C scripts\sp\utility::_id_F3D9(var_3);
  wait 3;
  level._id_8E42 = scripts\sp\utility::array_removedeadvehicles(level._id_8E42);
  scripts\engine\utility::array_thread(level._id_8E42, scripts\sp\utility::_id_12BFA);
}

_id_5D5A() {
  level._id_5D6C endon("death");
  var_0 = getEnt("dropship_dock_area", "targetname");

  for(;;) {
    var_1 = 0;

    if(level.player istouching(var_0) || _id_0E29::_id_87A7() != "none")
      var_1 = 1;

    var_2 = getaiarray("allies");

    foreach(var_4 in var_2) {
      if(var_4 istouching(var_0))
        var_1 = 1;
    }

    if(!var_1 && (level.player scripts\sp\utility::_id_D1DF(level._id_5D6C.origin, 0.5, 1) || scripts\engine\utility::flag("flag_retreat_base_intro_3"))) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level._id_5D6C _id_0BBC::_id_4265("back");
  _id_5160();
  level._id_5D6C _id_0BBF::_id_10FE1();
  level._id_5D6C notify("stop_dps_fx_loop");
  level._id_5D6C notify("stop_dropship_intro_damage");
  level._id_5D6C _id_0BBF::_id_10FDD("damage");
  level._id_5D6C _id_0BBF::_id_10FDD("cabin_lights");
  level._id_5D6C _id_0BBF::_id_10FDA();
  level._id_5D6C _id_5DF8();
  level._id_5DE4 solid();
  level._id_5D6C._id_4D94._id_4348 notsolid();
  level notify("end_start_magic_bullet_kill");
}

_id_5DF8() {
  if(isDefined(self._id_4D94.fx["damage"]["ceiling"])) {
    foreach(var_1 in self._id_4D94.fx["damage"]["ceiling"]) {
      if(isDefined(var_1._id_C264))
        var_1._id_C264 delete();
    }
  }

  if(isDefined(self._id_4D94.fx["damage"]["floor_temp"])) {
    foreach(var_1 in self._id_4D94.fx["damage"]["floor_temp"]) {
      if(isDefined(var_1._id_C264))
        var_1._id_C264 delete();
    }
  }

  if(isDefined(self._id_4D94.fx["damage"]["corner"])) {
    foreach(var_1 in self._id_4D94.fx["damage"]["corner"]) {
      if(isDefined(var_1._id_C264))
        var_1._id_C264 delete();
    }
  }

  if(isDefined(self._id_4D94.fx["damage"]["wall"])) {
    foreach(var_1 in self._id_4D94.fx["damage"]["wall"]) {
      if(isDefined(var_1._id_C264))
        var_1._id_C264 delete();
    }
  }
}

_id_10B91() {
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(["salter", "gator", "griff", "ethan"], "ally_start_aa1");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_aa1", "targetname"));
  thread _id_A060();
  scripts\engine\utility::flag_set("flag_jackal_aa1_crash");

  if(isDefined(level.gun["aa_gun_1_2"]))
    level.gun["aa_gun_1_2"] scripts\engine\utility::delaythread(4, scripts\sp\maps\marsbase\marsbase_code::_id_14E2, undefined, 3);

  level scripts\engine\utility::delaythread(0.05, ::_id_5E1C);
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_1_1");
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_1_2");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("lead_assault");
}

_id_B174() {
  scripts\sp\utility::_id_2669("AA1");
  scripts\engine\utility::flag_init("mars_killstreak_activate");
  var_0 = getEntArray("trig_greenhouse_spawn_enemies", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 scripts\engine\utility::trigger_off();

  thread _id_14E0();
  level.player thread scripts\sp\maps\marsbase\marsbase_util::_id_A605("kill_player_magic_bullet_aa_gun_1", "aa_gun_1_lookat", "end_aa_gun_1_magic_bullet_kill");
  scripts\sp\maps\marsbase\marsbase_code::_id_106B2("droppod_base_intro_1", undefined, "aa1_gate_close");
  level waittill("droppod_base_intro_1_landed");
  scripts\engine\utility::flag_set("flag_base_intro_combat_end");
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_542F();
  scripts\engine\utility::delaythread(3.0, scripts\sp\maps\marsbase\marsbase_code::_id_C2AC, "aa1");
  thread _id_14DF();
  scripts\sp\utility::_id_15F5("trig_base_intro_spawn_enemies_2");
  scripts\sp\maps\marsbase\marsbase_code::_id_C600("gate_base_intro_left", "gate_base_intro_right", undefined, undefined, undefined, "aa1");
  level thread scripts\sp\maps\marsbase\marsbase_code::_id_426B("gate_base_intro_left", "gate_base_intro_right", undefined, undefined, undefined, "aa1");
  var_4 = getEnt("gate_1_backup_blocker", "targetname");
  var_4 scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_F1DE);
  level thread scripts\sp\utility::_id_C12D("end_aa_gun_1_magic_bullet_kill", 6);
  scripts\engine\utility::flag_wait("mars_killstreak_activate");
  scripts\sp\utility::_id_2669("AA1");
  thread _id_14DE();
  thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5406();
  scripts\sp\maps\marsbase\marsbase_killstreak::_id_82E7(1);
  scripts\engine\utility::flag_set("flag_obj_aa1_start");
  thread scripts\sp\maps\marsbase\marsbase_code::_id_14E8("aa_gun_1_1", 1);
  thread scripts\sp\maps\marsbase\marsbase_code::_id_14E8("aa_gun_1_2", 1);
  thread _id_73DA();
  thread _id_54F2();
  thread _id_54F3();
  thread _id_14E9("aa_gun_1_1_targeted", "sp_aa_gun_1_1_ragdoll_flair");
  thread _id_14E9("aa_gun_1_2_targeted", "sp_aa_gun_1_2_ragdoll_flair");
  level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "aa_gun_1_1_targeted");
  level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "aa_gun_1_2_targeted");
  scripts\sp\utility::_id_57D5();
  level notify("aa_gun_1_targeted");
  level notify("end_aa_gun_1_jackal_victims");
  _id_62A4();

  foreach(var_2 in var_0)
  var_2 scripts\engine\utility::trigger_on();
}

_id_14DF() {
  level endon("flag_aa1_end");
  var_0 = scripts\sp\utility::_id_77DA("group_enemy_base_intro");

  while(var_0.size > 2) {
    var_1 = scripts\engine\utility::random(var_0);

    if(isDefined(var_1) && isalive(var_1)) {
      if(!isDefined(var_1._id_B14F))
        var_1 _meth_81D0();
    }

    wait(randomfloatrange(0.4, 0.7));
  }
}

_id_14E9(var_0, var_1) {
  level waittill(var_0);
  var_2 = scripts\sp\utility::_id_22CD(var_1, 1, 1);
}

_id_14DD() {
  level endon("end_aa_gun_1_jackal_victims");

  for(;;) {
    var_0 = scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_10207("ambient_crash_start_aa_gun_1_1", 0.25, "allies", randomintrange(150, 300), 0, undefined, 1);
    var_1 = scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_10207("ambient_crash_start_aa_gun_1_2", 0.25, "allies", randomintrange(150, 300), 0, undefined, 1);
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
    var_2 = scripts\sp\utility::_id_22B9(var_2);
    scripts\sp\utility::_id_13753(var_2);
  }
}

_id_14E7(var_0, var_1) {}

_id_54F2() {
  scripts\engine\utility::flag_wait("aa_gun_1_1_destroyed");
  var_0 = getEntArray("spawners_aa_gun_1_1", "script_noteworthy");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isspawner(var_2))
        var_2 delete();
    }
  }
}

_id_54F3() {
  scripts\engine\utility::flag_wait("aa_gun_1_2_destroyed");
  var_0 = getEntArray("spawners_aa_gun_1_2", "script_noteworthy");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isspawner(var_2))
        var_2 delete();
    }
  }

  var_4 = getEnt("aa_gun_1_2_sight_blocker", "targetname");

  if(isDefined(var_4))
    var_4 delete();
}

_id_62A4() {
  scripts\engine\utility::flag_wait_all("aa_gun_1_1_destroyed", "aa_gun_1_2_destroyed");
  scripts\engine\utility::flag_set("flag_aa1_end");
  var_0 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\marsbase\marsbase_killstreak::_id_6F2A, (0, 0, 0), 0.5);
  scripts\sp\maps\marsbase\marsbase_killstreak::_id_B391();
}

_id_14DE() {
  level endon("flag_aa1_end");

  for(;;) {
    level.player waittill("mars_killstreak_missiles_done");
    scripts\sp\maps\marsbase\marsbase_killstreak::_id_B391(15);
  }
}

_id_73DA() {
  scripts\engine\utility::flag_wait_any("aa_gun_1_1_destroyed", "aa_gun_1_2_destroyed");
  wait 2;

  if(scripts\engine\utility::flag("aa_gun_1_1_destroyed") && !scripts\engine\utility::flag("aa_gun_1_2_destroyed") || !scripts\engine\utility::flag("aa_gun_1_1_destroyed") && scripts\engine\utility::flag("aa_gun_1_2_destroyed"))
    scripts\sp\utility::_id_15F5("trig_aa_gun_1_friendly");
}

_id_14E0() {
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("sm_aa_gun_1_snipers", "targetname", ::_id_6510);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("sm_aa_gun_1_reinforcements", "targetname");
  scripts\engine\utility::flag_wait("flag_aa1_end");
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("sm_aa_gun_1_snipers", "targetname", 1);
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57("sm_aa_gun_1_reinforcements", "targetname", 1);
}

_id_6510() {
  self.health = 5;
}

_id_A060() {
  scripts\engine\utility::flag_wait("flag_jackal_aa1_crash");
  scripts\engine\utility::delaythread(1, scripts\sp\maps\marsbase\marsbase_dialogue::_id_545E);
  var_0 = scripts\sp\vehicle::_id_1080C("jackal_aa1_crash");
  var_0 endon("death");
  var_0 _id_0BDC::_id_19A9();
  var_0 _meth_8555(0);
  var_1 = getcsplineid("jackal_aa1_crash_spline");
  var_2 = getcsplinepointposition(var_1, 0);
  var_0 vehicle_teleport(var_2, var_0.angles);
  var_3 = spawn("script_origin", var_0.origin);
  var_3 linkTo(var_0);
  var_4 = var_0.model;
  var_0._id_110CD = "vfx_mars_jackal_crash_mountain_impact";
  var_5 = 125;
  var_0 thread _id_0BDC::_id_A1EF(var_1, var_5, 160);
  var_0._id_2713 = 1;
  var_0 scripts\engine\utility::waittill_any("aa1_jackal_crash_fx", "death");
  var_3 playSound("mars_base_jackal_aa1_inc");
  var_0 scripts\engine\utility::waittill_any("aa1_jackal_crash", "death");
  var_3 playSound("mars_base_jackal_aa1_crash");
  var_6 = scripts\engine\utility::getStruct("jackal_crash_explosion", "targetname") scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_explode"), var_6, "tag_origin");
  wait 0.5;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mars_tunnel_wallexplosion_lrg"), var_6, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pcr_lingering_smoke_rise"), var_6, "tag_origin");
  wait 2;
  var_3 delete();
  var_6 delete();
  var_0 delete();
}

_id_A061(var_0) {
  var_1 = scripts\engine\utility::getStruct("jackal_crash_dest", "targetname");
  var_2 = var_1.origin;
  var_3 = var_1.angles;
  var_4 = spawn("script_model", var_2);
  var_4 setModel(var_0);
  var_4.angles = var_3;
  return var_4;
}

_id_761E(var_0) {
  var_1 = getEnt("fxanim_sp_mars_jackal_crash_debris", "targetname");
  var_1 show();
  var_1 scripts\sp\utility::_id_23B7("aa1_jackal_debris");

  if(!scripts\engine\utility::is_true(var_0)) {
    earthquake(0.4, 2, level.player.origin, 500);
    var_1 scripts\sp\anim::_id_1F35(var_1, "fxanim_aa1_jackal_debris");
  } else {
    var_1 thread scripts\sp\anim::_id_1F35(var_1, "fxanim_aa1_jackal_debris");
    scripts\engine\utility::waitframe();
    var_1 thread scripts\sp\anim::_id_1F2A([var_1], "fxanim_aa1_jackal_debris", 1.0);
  }
}

_id_A1BE(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1; var_2++) {
    thread _id_0B76::_id_1992("tag_origin", var_0, scripts\engine\utility::cointoss());
    wait 0.25;
  }
}

_id_9015() {
  if(scripts\engine\utility::flag("player_in_mars_killstreak") || _id_0E29::_id_87A7() != "none") {
    level._id_A68E = 0;
    return 1;
  } else
    return 0;
}

_id_3B27() {
  if(level._id_10CDA != "hill_gate" && level._id_10CDA != "hill_gate_open" && level._id_10CDA != "elevator_retreat" && level._id_10CDA != "elevator_igc" && level._id_10CDA != "elevator_enter" && level._id_10CDA != "elevator_load" && level._id_10CDA != "elevator_move" && level._id_10CDA != "dev_mccallum_pip" && level._id_10CDA != "dev_jackal_pilot_sacrifice_pip")
    scripts\engine\utility::delaythread(0.1, scripts\sp\maps\marsbase\marsbase_killstreak::_id_82E7);

  scripts\engine\utility::flag_set("flag_aa1_end");
  thread _id_761E(1);
  var_0 = getEnt("gate_1_backup_blocker", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  var_1 = getEnt("aa_gun_1_2_sight_blocker", "targetname");

  if(isDefined(var_1))
    var_1 delete();

  _id_0B77::_id_A67F(1);
}

_id_10C5D() {
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(["salter", "gator", "griff", "ethan"], "ally_start_aa1");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_aa1", "targetname"));
  scripts\engine\utility::flag_set("flag_aa1_end");
  level scripts\engine\utility::delaythread(0.05, ::_id_5E1C);
  thread scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_1_1", 1);
  thread scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_1_2", 1);
}

_id_B1E8() {
  scripts\sp\utility::_id_2669("Gate Support 1");

  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  scripts\engine\utility::waitframe();
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa1_complete");
  thread _id_5D5B();
  scripts\engine\utility::flag_wait("flag_aa1_end");
  scripts\sp\utility::_id_15F5("trig_base_intro_allies_3");
  scripts\sp\maps\marsbase\marsbase_dialogue::_id_5431();
  _id_0B77::_id_A67F(1);
  _id_0B77::_id_A67F(2);
}

_id_3B6A() {
  thread scripts\sp\maps\marsbase\marsbase_code::_id_C600("gate_base_intro_left", "gate_base_intro_right", 1, undefined, undefined, "aa1");
  _id_0B77::_id_A67F(2);
  thread scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_1_1", 0);
  thread scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_1_2", 0);
}

_id_5D5B() {
  var_0 = scripts\sp\maps\marsbase\marsbase_util::_id_10626(scripts\sp\maps\marsbase\marsbase_code::_id_77E6("group_ally_dropship2_engineers"));
  var_0[0]._id_1FBB = "engineer1";
  var_0[1]._id_1FBB = "engineer2";
  var_0[2]._id_1FBB = "engineer3";
  _id_1C43(var_0, 0);
  scripts\sp\maps\marsbase\marsbase_util::_id_1C37(var_0, 0);
  var_1 = _id_0BBF::_id_5DFE();
  var_1._id_10871 = "veh_base_dropship2";
  var_1._id_1325F = "dropship2_parts";
  var_1._id_1325C = "col_dropship2";
  level._id_5D5B = _id_0BBF::_id_106B8(undefined, undefined, undefined, var_0, undefined, var_1);
  level._id_5D5B _id_0BBF::_id_F457();
  level._id_5D5B._id_5971 = 0;
  level._id_5D5B scripts\sp\utility::_id_23B7("dropship_gate");
  var_2 = spawnStruct();
  var_2.origin = scripts\engine\utility::getStruct("engineers_gate", "targetname").origin;
  var_2.angles = (0, 0, 0);
  level._id_5D5B thread _id_5D60();
  level._id_5D5B scripts\engine\utility::delaythread(3, _id_0BBC::_id_C5F1, "back");
  var_2 scripts\sp\anim::_id_1F35(level._id_5D5B, "gate_support_flyin");
  scripts\engine\utility::waitframe();
  var_2 thread _id_5D5F();
  wait 0.1;
  var_3 = [["node_dropship2_jump1_begin", "node_dropship2_jump1_end"], ["node_dropship2_jump2_begin", "node_dropship2_jump2_end"], ["node_dropship2_jump3_begin", "node_dropship2_jump3_end"]];
  level._id_5D5B scripts\sp\maps\marsbase\marsbase_code::_id_2879(var_3);
  thread _id_65C9(var_0);
  scripts\sp\utility::_id_15F5("trig_base_intro_dropship2");
  level._id_5D5B thread _id_B967(var_0);
}

_id_5D60() {
  level._id_5D5B playLoopSound("mars_base_dropship_2_main");
}

_id_B967(var_0) {
  scripts\engine\utility::flag_clear("flag_engineers_cleared_dropship2");

  for(;;) {
    var_1 = 0;
    scripts\sp\utility::_id_E006(0, 1, 1, 1, 0, 0, 0);

    foreach(var_3 in var_0) {
      if(isDefined(var_3) && isalive(var_3)) {
        var_4 = var_3.origin[2];
        var_5 = self.origin[2];
        var_6 = abs(var_4 - var_5);

        if(var_6 < 100) {
          var_1 = 1;
          break;
        }
      }
    }

    if(!var_1) {
      break;
    }

    wait 0.25;
  }

  scripts\engine\utility::flag_set("flag_engineers_cleared_dropship2");
}

_id_5D5F() {
  scripts\sp\anim::_id_1F35(level._id_5D5B, "gate_support_idle");
  scripts\engine\utility::flag_wait_or_timeout("flag_engineers_cleared_dropship2", 20);
  thread _id_6AE7();
  scripts\engine\utility::waitframe();
  level._id_5D5B playSound("mars_base_dropship_door_close");
  level._id_5D5B playSound("mars_base_dropship_flyout");
  level._id_5D5B thread scripts\sp\maps\marsbase\marsbase_code::_id_2878("flag_dropship2_leave", "gate_support_flyout", self);
  thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5432();
}

_id_6AE7() {
  level._id_5D5B endon("death");
  level endon("stop_fake_dropship_attack");
  var_0 = scripts\engine\utility::getStructArray("fake_dropship_gate_attack", "targetname");
  level thread scripts\sp\utility::_id_C12D("stop_fake_dropship_attack", 4);

  for(;;) {
    magicbullet("mars_aa_projectile", scripts\engine\utility::random(var_0).origin, level._id_5D5B.origin + (0, 0, randomintrange(75, 100)));
    wait(randomfloatrange(0.5, 1.5));
  }
}

_id_65C9(var_0) {
  if(var_0.size < 3) {
    return;
  }
  var_1 = scripts\engine\utility::getStruct("engineers_gate", "targetname");
  thread _id_65CC(var_1);
  scripts\sp\maps\marsbase\marsbase_util::_id_1C37(var_0, 1);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_623B);
  var_1 scripts\sp\utility::_id_178D(::_id_65CA, var_0[0], 0.5);
  var_1 scripts\sp\utility::_id_178D(::_id_65CA, var_0[1], 1);
  var_1 scripts\sp\utility::_id_178D(::_id_65CA, var_0[2], 1.5);
  scripts\sp\utility::_id_57D5();
  scripts\engine\utility::flag_wait_or_timeout("flag_start_engineer_gate_open", 10);
  thread _id_65CC(var_1);
  var_1 thread _id_65CB(var_0);
}

_id_65CC(var_0) {
  setsaveddvar("ai_corpsesynch", 1);
  wait 0.25;
  var_1 = getcorpsearray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.origin)) {
      var_4 = distance2d(var_3.origin, var_0.origin);

      if(var_4 < 300)
        var_3 delete();
    }
  }

  setsaveddvar("ai_corpsesynch", 0);
}

_id_65CA(var_0, var_1) {
  wait(var_1);
  var_0 unlink();
  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = level._id_EC85[var_0._id_1FBB]["engineer_gate_arrive_idle"][0];
  var_5 = getstartorigin(var_2, var_3, var_4);
  var_6 = getstartorigin(var_2, var_3, var_4);
  var_7 = spawn("script_origin", var_5);
  var_7.angles = var_6;
  var_7.type = "Exposed";

  if(var_0._id_1FBB == "engineer1")
    var_7._id_22EF = "stand";
  else
    var_7._id_22EF = "crouch";

  var_0.scriptedarrivalent = var_7;
  scripts\sp\anim::_id_1F0F(var_0, "engineer_gate_arrive_idle", "engineer_gate_arrive_idle");

  if(isDefined(var_7))
    var_7 delete();
}

_id_65CB(var_0) {
  var_1 = getnodearray("nd_greenhouse_gate", "script_noteworthy");
  thread _id_1F2D(var_0[0], "engineer_gate_open");
  thread _id_1F2D(var_0[2], "engineer_gate_open");
  level thread _id_76ED();
  thread _id_1F2D(var_0[1], "engineer_gate_open");
  wait 15.0;
  _id_1C43(var_0, 1);
}

_id_76ED() {}

_id_1C43(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isalive(var_3)) {
      if(scripts\engine\utility::is_true(var_1)) {
        var_3.grenadeawareness = 0.9;
        var_3.allowdeath = 1;
        var_3._id_B14F = undefined;
        var_3.damageshield = 0;
        var_3 notify("internal_stop_magic_bullet_shield");
        continue;
      }

      var_3.grenadeawareness = 0;
      var_3.allowdeath = 0;
      var_3._id_B14F = 1;
      var_3.damageshield = 1;
      var_3 notify("magic_bullet_shield");
    }
  }
}

_id_1F2D(var_0, var_1) {
  var_0 endon("death");

  if(var_0._id_1FBB == "engineer1")
    level waittill("start_ally01_anim");

  var_2 = undefined;

  if(var_0._id_1FBB == "engineer3") {
    var_2 = scripts\sp\utility::_id_10639("engineer_gate_open_torch", var_0 gettagorigin("tag_inhand"), var_0 gettagangles("tag_inhand"));
    var_2 linkTo(var_0, "tag_inhand");
    var_2 thread _id_11A0B();
  }

  var_0 notify("stop_loop");
  scripts\sp\anim::_id_1F35(var_0, var_1);
  var_0 scripts\sp\utility::_id_F3DD(64);
  var_0 scripts\sp\utility::_id_5588();
  self notify("stop_loop");

  if(isDefined(var_2))
    var_2 delete();

  var_3 = undefined;

  switch (var_0._id_1FBB) {
    case "engineer1":
      var_3 = getnode("nd_greenhouse_gate_panel", "targetname");
      break;
    case "engineer2":
      var_3 = getnode("nd_greenhouse_gate_left", "targetname");
      break;
    case "engineer3":
      var_3 = getnode("nd_greenhouse_gate_right", "targetname");
      break;
    default:
      var_3 = getnode("nd_greenhouse_gate_right", "targetname");
  }

  var_0 scripts\sp\utility::_id_F3D9(var_3);
  scripts\engine\utility::flag_wait_any("player_entered_gate1", "gate_c8_destroyed");
  var_0 scripts\sp\utility::_id_F3B5("o");
  var_0 scripts\sp\utility::_id_F3DD(256);
}

_id_11A0B() {
  self endon("death");
  level waittill("start_blowtorch");
  playFXOnTag(scripts\engine\utility::getfx("vfx_blowtorch_active"), self, "tag_flame");
  level waittill("stop_blowtorch");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_blowtorch_active"), self, "tag_flame");
}