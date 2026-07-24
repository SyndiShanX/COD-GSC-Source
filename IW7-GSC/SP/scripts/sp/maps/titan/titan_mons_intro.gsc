/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_mons_intro.gsc
******************************************************/

_id_B6D4() {
  _id_B6E2();
  _id_B6CB();
  _id_D7EF();
  thread _id_BAB1();
}

_id_B6E2() {
  precachemodel("veh_mil_air_ca_jackal_01");
  precachemodel("veh_mil_air_un_jackal_02");
  precachemodel("p7_cai_rock_rubble_pile_b_titan");
  precachemodel("rock_large_titan_06");
  precachemodel("rock_large_titan_01");
  precachemodel("p7_cai_rock_rubble_pile_a_titan");
  precachemodel("rock_pile_titan_long");
  precacheshellshock("titan_mons_intro");
  precacheshellshock("titan_mons_intro_nosound");
  precachestring(&"TITAN_DOOR_BASH");
}

_id_B6CB() {
  scripts\engine\utility::flag_init("mi_gate_dialogue_done");
  scripts\engine\utility::flag_init("mi_c12_gate_opened");
  scripts\engine\utility::flag_init("mi_mons_intro_startpath");
  scripts\engine\utility::flag_init("mi_allow_friendly_fire");
  scripts\engine\utility::flag_init("mi_mons_lower_jackals");
  scripts\engine\utility::flag_init("mi_mons_pickup_scenes");
  scripts\engine\utility::flag_init("mi_captainsbeenhit_line");
  scripts\engine\utility::flag_init("mi_ethan_pickup_done");
  scripts\engine\utility::flag_init("mi_leg_scene_start");
  scripts\engine\utility::flag_init("mi_c12_path_start");
  scripts\engine\utility::flag_init("mi_c12_reached_pickup");
  scripts\engine\utility::flag_init("mi_flatbed_blowup_1");
  scripts\engine\utility::flag_init("mi_flatbed_blowup_2");
  scripts\engine\utility::flag_init("start_mons_close_jackals");
  scripts\engine\utility::flag_init("mi_c12_path_continue_1");
  scripts\engine\utility::flag_init("mi_c12_path_continue_2");
  scripts\engine\utility::flag_init("mi_jackal_crash_start");
  scripts\engine\utility::flag_init("mi_atom_reached_crash_start");
  scripts\engine\utility::flag_init("jackal_crash_stumbler_path");
  scripts\engine\utility::flag_init("mi_bunker_end_runners_RUN");
  scripts\engine\utility::flag_init("mi_bunker_runners_delete");
  scripts\engine\utility::flag_init("mi_mons_thrusters");
  scripts\engine\utility::flag_init("mi_mons_thrusters_delete");
  scripts\engine\utility::flag_init("stop_mons_winds");
  scripts\engine\utility::flag_init("stop_mons_winds_rumble");
  scripts\engine\utility::flag_init("mons_intro_wave_hit_player");
  scripts\engine\utility::flag_init("mi_ethan_goto_door");
  scripts\engine\utility::flag_init("mi_player_on_door");
  scripts\engine\utility::flag_init("mi_ethan_on_door");
  scripts\engine\utility::flag_init("mons_bunker_door_opened");
  scripts\engine\utility::flag_init("bunker_door_unlink_player");
  scripts\engine\utility::flag_init("door_jackal_hit");
}

_id_10DED() {
  var_0 = ["titan_base_tr", "titan_canyon_b_tr", "titan_refinery_tr", "titan_c12arena_tr"];
  var_1 = ["titan_base_tr", "titan_refinery_tr", "titan_c12arena_tr", "titan_refinery_interior_tr"];
  scripts\sp\utility::_id_1749("mons_knockdown", ::_id_BAAB, "Knockdown", ::_id_BAA9, var_0);
  scripts\sp\utility::_id_1749("mons_pickup", ::_id_BAB5, "Pickup", ::_id_BAB4, var_0);
  scripts\sp\utility::_id_1749("mons_door", ::_id_BAA4, "Door", ::_id_326D, var_1);
}

_id_BAB1() {
  level waittill("load_finished");
  var_0 = getEnt("gate_player_clip", "script_noteworthy");
  var_0 disconnectPaths();
  scripts\sp\utility::_id_22CA("mi_pickup_strafers", ::_id_B6E1);
  scripts\sp\utility::_id_22CA("mi_pickup_strafer_guys", ::_id_B6E0);
  scripts\sp\utility::_id_22CA("mi_trench_fire_friendlies", ::_id_B6CC);
  scripts\sp\utility::_id_22CA("mi_blowup_flatbeds", ::_id_B6C5);
  scripts\sp\utility::_id_22C9("mi_intro_friendlies", ::_id_B6D0);
  scripts\sp\utility::_id_22C9("mi_pickup_runners", ::_id_B6DC);
  scripts\sp\utility::_id_22C9("mi_crash_jackals", _id_0C1C::_id_4E6C);
  getEnt("crash_flip_atv", "targetname") scripts\sp\utility::_id_1747(::_id_4808);
  getEnt("mi_jackal_diver", "script_noteworthy") scripts\sp\utility::_id_1747(scripts\sp\utility::_id_5131);
  getEnt("mi_jackal_diver", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_B6D2);
  getEnt("mi_pickup_early_strafer", "targetname") scripts\sp\utility::_id_1747(::_id_B6CD, "mi_jackal_strafe_1", 3.4);
  getEnt("jackal_strafe_truck_1", "targetname") scripts\sp\utility::_id_1747(::_id_B6CE, "mi_jackal_strafe_2", 0.7);
  getEnt("jackal_strafe_truck_2", "targetname") scripts\sp\utility::_id_1747(::_id_B6CF, "mi_jackal_strafe_truck_2");
  getEnt("mi_pickup_c12_target", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_B6D9, 0.75);
  getEnt("mi_pickup_c12_target_2", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_B6D9, 2.5);
  level._id_B6D7 = [];
  var_1 = getEntArray("post_knockdown_trigger", "script_noteworthy");
  scripts\engine\utility::array_thread(var_1, scripts\engine\utility::trigger_off);
  level.scr_sound["mortar"]["incomming"] = "scn_titan_jackal_missile_incoming";
  level.scr_sound["mortar"]["jackal_missile_imp"] = "scn_titan_jackal_missile_exp";
  thread scripts\sp\mortar::_id_2C1A();
  scripts\sp\utility::_id_10FEC("fx_background_mist_1");
}

_id_BAA9() {
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_22CB("mi_vehicles");
  var_0 = getEnt("mi_jackal_crash_trench_clip", "targetname");
  var_0 notsolid();
  var_0 disconnectPaths();
  thread _id_BA5C();
  thread _id_3269();
  thread _id_BAAA();
  setaudiotriggerstate("titan_ext", "heavy", 5);

  if(isDefined(level._id_2056)) {
    foreach(var_2 in level._id_2056) {
      if(isDefined(var_2)) {
        if(isDefined(var_2._id_129D4))
          var_2._id_129D4 delete();
      }
    }

    scripts\sp\utility::_id_228A(level._id_2056);

    if(isDefined(level._id_2052))
      level._id_2052 delete();

    if(isDefined(level._id_2050))
      level._id_2050 delete();
  }

  scripts\engine\utility::exploder("mons_clouds");
  scripts\engine\utility::exploder("fx_background_mist_1_opt");
  scripts\sp\utility::_id_10FEC("refinery_reveal_clouds");
  thread scripts\sp\maps\titan\titan_code::_id_D250(3);
  var_4 = [level._id_2429, level._id_C47F, level._id_B33B, level._id_B33E];
  scripts\engine\utility::array_thread(var_4, ::_id_D7CB);
  thread _id_BA84();
  thread _id_119C4();
  thread _id_119C5();
  scripts\engine\utility::flag_wait("mi_gate_dialogue_done");
  thread _id_6A68();
  scripts\engine\utility::delaythread(1.5, scripts\engine\utility::flag_set, "mi_c12_gate_opened");
  scripts\engine\utility::flag_wait("mi_mons_attack_start");
  level.player playSound("scn_monsintro_wind");
  level.player scripts\engine\utility::delaycall(4.0, ::playsound, "scn_monsintro_ship_flyover_lr");
  scripts\engine\utility::flag_set("mons_event_started");
  level._id_739C scripts\sp\utility::_id_51E1("combat");

  if(isDefined(level._id_2050))
    level._id_2050 delete();

  if(isDefined(level._id_2052))
    level._id_2052 delete();

  scripts\sp\utility::_id_22CD("mi_pre_knockdown_friendlies_2");
  thread _id_B6D8();
  thread _id_BABC();
  thread _id_BC01();
  scripts\engine\utility::flag_set("mi_mons_intro_startpath");
  var_5 = scripts\sp\vehicle::_id_1080F("intro_cloud_jackals");
  level notify("cleanup_c12fight_apc");
  thread _id_BAA5();
  wait 2;
  level.player scripts\engine\utility::allow_sprint(0);
  level.player scripts\sp\utility::_id_F526("relaxed");
  level.player scripts\sp\utility::_id_1102B();
  wait 5.5;
  scripts\engine\utility::exploder("mons_clouds_3");
  thread _id_BAB6();
  scripts\engine\utility::flag_set("mi_mons_thrusters");
  wait 1.5;
  level.player thread scripts\sp\utility::_id_D091("ges_sandblock", level._id_B6D6);
  thread _id_BAA6();
  _id_13790(level.player);
  scripts\engine\utility::flag_set("mons_intro_wave_hit_player");
  level.player scripts\sp\utility::_id_1102B();
  level.player scripts\engine\utility::allow_sprint(1);
  playFX(scripts\engine\utility::getfx("vfx_mons_knocback_camera_dust"), level.player.origin);
  scripts\sp\utility::_id_10FEC("mons_wind_dust");
  level.player shellshock("titan_mons_intro_nosound", 60);
  level.player _meth_82C0("titan_mons_intro_shocked", 0.8);
  var_6 = scripts\engine\utility::getStruct("ethan_pickup_struct", "targetname");
  var_7 = scripts\sp\utility::_id_10639("player_rig");
  var_7 hide();
  var_7.origin = var_6.origin;
  var_7.angles = var_6.angles;
  level.player _meth_823B(var_7, "tag_player");
  var_7 show();
  level.player scripts\sp\utility::_id_F526("normal");
  level.player _id_0B1F::_id_598D();
  var_7 scripts\sp\anim::_id_1F35(var_7, "mons_knockdown");
  scripts\engine\utility::flag_set("mi_mons_thrusters_delete");
  scripts\engine\utility::flag_set("stop_mons_winds_rumble");
  level._id_739C scripts\sp\utility::_id_51E1("combat");
  scripts\sp\utility::_id_228A(var_5);
  level._id_BAE3 = var_7;
}

#using_animtree("script_model");

_id_BAAA() {
  var_0 = getEnt("mi_entrance_door", "targetname");
  var_0 _meth_83D0(#animtree);
  var_0._id_1FBB = "gate";
  var_1 = getEnt("gate_player_clip", "script_noteworthy");
  var_1 linkTo(var_0, "titan_gate_anim_jnt_right_door");
  var_2 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  level._id_739C scripts\sp\utility::_id_51E1("casual");
  level._id_739C _meth_84B0(0);
  var_3 = [var_0, level._id_739C];
  var_2 scripts\sp\anim::_id_1F17(level._id_739C, "mi_gate_approach");
  var_2 scripts\sp\anim::_id_1F2C(var_3, "mi_gate_approach");
  var_2 thread scripts\sp\anim::_id_1EE7(var_3, "mi_gate_approach_idle");
  var_4 = scripts\sp\utility::_id_7DC2("mi_gate_approach_idle", "c12_ally");
  var_5 = getanimlength(var_4[0]);
  scripts\engine\utility::flag_wait("mi_gate_dialogue_done");
  var_2 notify("stop_loop");
  var_1 connectpaths();
  var_2 scripts\sp\anim::_id_1F2C(var_3, "mi_gate_open");
  var_2 thread scripts\sp\anim::_id_1EE7(var_3, "mi_gate_idle");
  scripts\engine\utility::flag_wait("mi_mons_attack_start");
  wait 2;
  var_2 notify("stop_loop");
  var_2 scripts\sp\anim::_id_1F2C(var_3, "mi_gate_exit");
  var_1 disconnectPaths();
  var_1 solid();
  var_0 _meth_83A1();
  level._id_739C _meth_83A1();
  level._id_739C _meth_84B0(1);
  var_6 = getnode("mi_c12_path_start", "targetname");
  level._id_739C _meth_82EE(var_6);
}

_id_6A68() {
  var_0 = scripts\engine\utility::getStruct("mons_ship", "targetname");
  var_1 = scripts\engine\utility::getStruct("mons_event_2", "targetname");
  scripts\engine\utility::flag_wait("mi_mons_attack_start");

  while(!level.player isonground())
    scripts\engine\utility::waitframe();

  level.player setmovespeedscale(0.7);
  level.player._id_843F = 1;
  var_2 = scripts\engine\utility::spawn_tag_origin(level.player.origin + (0, 0, 6), var_1.angles);
  level.player _meth_823C(var_2, "tag_origin", 0.5, 0.1, 0.1);
  wait 0.5;
  level.player playerlinktodelta(var_2, "tag_origin", 50, 30, 30, 30, 30, 0);
  wait 2;
  level.player._id_843F = 0;
  level.player unlink();
  var_2 delete();
  scripts\engine\utility::flag_wait("mons_intro_wave_hit_player");
  level.player setmovespeedscale(1);
}

_id_BC01() {
  var_0 = getnode("attackstart_omar", "targetname");
  var_1 = getnode("attackstart_atom", "targetname");
  var_2 = getnode("attackstart_marine1", "targetname");
  var_3 = getnode("attackstart_marine2", "targetname");
  wait 0.6;

  foreach(var_5 in level._id_10AC8) {
    if(!scripts\sp\utility::_id_13D92(var_5 getEye(), cos(45))) {
      if(var_5.name == "Omar") {
        var_5 scripts\sp\utility::_id_1160F(var_0);
        continue;
      }

      if(var_5.name == "Ethan") {
        var_5 scripts\sp\utility::_id_1160F(var_1);
        continue;
      }

      if(var_5.name == "Brooks") {
        var_5 scripts\sp\utility::_id_1160F(var_2);
        continue;
      }

      if(var_5.name == "Kashima")
        var_5 scripts\sp\utility::_id_1160F(var_3);
    }
  }
}

_id_119C4() {
  level endon("mons_intro_wave_hit_player");
  var_0 = getEnt("disable_jump", "targetname");
  var_0 waittill("trigger", var_1);
  level.player scripts\engine\utility::allow_jump(0);
  thread _id_D1A6(var_0);
}

_id_D1A6(var_0) {
  level endon("mons_intro_wave_hit_player");

  while(level.player istouching(var_0) && !scripts\engine\utility::flag("mons_intro_wave_hit_player"))
    scripts\engine\utility::waitframe();

  if(!scripts\engine\utility::flag("mons_intro_wave_hit_player")) {
    level.player scripts\engine\utility::allow_jump(1);
    thread _id_119C4();
  }
}

_id_119C5() {
  scripts\engine\utility::flag_wait("mons_intro_wave_hit_player");
  level.player scripts\engine\utility::allow_jump(1);
  level notify("mons_intro_wave_hit_player");
  scripts\sp\utility::_id_5599("disable_jump");
}

_id_D7CB() {
  var_0 = getnode("mi_knockdown_path_" + self._id_1FBB, "targetname");
  thread _id_B6E3(var_0);
  var_1 = scripts\sp\utility::_id_7DC3("mons_wind_walk_" + randomint(3));
  scripts\engine\utility::flag_wait("mi_mons_intro_startpath");
  wait(randomfloatrange(0.5, 2));
  scripts\asm\asm::asm_setdemeanoranimoverride("combat", "move", var_1);
  scripts\engine\utility::flag_wait("mi_mons_thrusters");
  _id_13790(self);
  scripts\asm\asm::asm_cleardemeanoranimoverride("combat", "move");
  self._id_C3CD = self.noragdoll;
  self.noragdoll = 1;
  var_2 = "run_death_fallonback";
  scripts\sp\anim::_id_1EC7(self, var_2);
  self.noragdoll = self._id_C3CD;
}

_id_BA84() {
  wait 1;
  level._id_B33B scripts\sp\utility::_id_10346("titan_brk_gridslockeddownsarge");
  level._id_C47F scripts\sp\utility::_id_10346("titan_omr_rogerthatallsato");
  level.player thread scripts\sp\utility::_id_D091("ges_radio");
  level.player scripts\engine\utility::delaythread(5.5, scripts\sp\utility::_id_1102B);
  wait 0.25;
  scripts\sp\utility::_id_10350("titan_plr_feverraideronewe");
  scripts\sp\utility::_id_10350("titan_slt_negativecopyactualrepeat");
  scripts\engine\utility::flag_set("mi_gate_dialogue_done");
  level.player thread scripts\sp\utility::_id_D091("ges_radio");
  level.player scripts\engine\utility::delaythread(4, scripts\sp\utility::_id_1102B);
  wait 0.25;
  scripts\sp\utility::_id_10350("titan_plr_feversalterrespondover");
  level._id_B33E thread scripts\sp\utility::_id_10346("titan_ksh_channelisdownno");
}

_id_BABC() {
  scripts\engine\utility::flag_wait("mi_mons_attack_start");
  setmusicstate("");
  level._id_B33B scripts\sp\utility::_id_10346("titan_brk_headsupwevegot");
  wait 0.2;
  scripts\sp\utility::_id_10350("titan_plr_couldbeourair");
  wait 1.4;
  level._id_2429 scripts\sp\utility::_id_10346("titan_eth_thatsnotours");
  level._id_B33B scripts\sp\utility::_id_10346("titan_eth_olympusmons");
  scripts\sp\utility::_id_10350("titan_plr_EveryonemoveNOW");
}

_id_BAB6() {
  var_0 = scripts\engine\utility::getStruct("mi_mons_wave_start", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = var_0 scripts\sp\utility::_id_7A97()[0];
  thread scripts\sp\maps\titan\titan_audio::_id_BAF1();
  var_3 = distance(var_0.origin, var_1.origin);
  var_4 = anglesToForward(var_0.angles);
  var_5 = anglestoup(var_0.angles);
  var_6 = 200;
  var_7 = var_3 / var_6;
  var_8 = var_0.origin;
  var_8 = var_8 + var_5 * 25;
  var_9 = scripts\engine\utility::spawn_tag_origin();
  var_9.origin = var_8;
  var_10 = [var_9];
  level._id_9AEC = var_9;
  var_11 = var_9;

  for(var_12 = 0; var_12 < var_7; var_12++) {
    var_8 = var_8 + var_4 * var_6;
    var_8 = var_8 + var_5 * 25;
    var_11 = scripts\engine\utility::spawn_tag_origin();
    var_11.origin = var_8;
    var_11 linkTo(var_9);
    var_10[var_10.size] = var_11;
  }

  scripts\engine\utility::exploder("mons_wind_wave");
  var_13 = vectorNormalize(var_2.origin - var_0.origin);

  while(!scripts\engine\utility::flag("mons_intro_wave_hit_player")) {
    var_9.origin = var_9.origin + var_13 * 100;
    wait 0.05;
  }

  scripts\sp\utility::_id_228A(var_10);
}

_id_13790(var_0) {
  var_0 endon("death");
  level endon("mons_intro_wave_hit_player");
  var_1 = anglesToForward((0, 210, 0));

  for(;;) {
    var_2 = level._id_9AEC.origin + var_1 * 50;
    var_3 = vectorNormalize(var_0.origin - var_2);

    if(vectordot(var_1, var_3) < 0) {
      break;
    }

    wait 0.05;
  }
}

_id_BAA5() {
  level._id_BAA7 = 1.5;
  var_0 = scripts\engine\utility::getStructArray("mi_mons_wind", "targetname");
  scripts\engine\utility::exploder("mons_wind_dust");
}

_id_BAA6() {
  level.player scripts\sp\utility::_id_D2CD(50, 0.4);
  wait 0.4;

  while(!scripts\engine\utility::flag("stop_mons_winds_rumble")) {
    level.player playRumbleOnEntity("damage_heavy");
    wait 0.1;
  }

  level.player scripts\sp\utility::_id_D2CD(100, 0.05);
}

_id_B6D0() {
  var_0 = self.spawner;
  var_1 = getnode(self.script_linkto, "script_linkname");
  thread _id_B6E3(var_1);
  self._id_4E2A = scripts\sp\utility::_id_7DC3("explode_b_01");
  var_2 = scripts\sp\utility::_id_7DC3("mons_wind_walk_" + randomint(3));
  scripts\engine\utility::flag_wait("mi_mons_intro_startpath");
  wait(randomfloatrange(0.5, 2));
  scripts\asm\asm::asm_setdemeanoranimoverride("combat", "move", var_2);
  scripts\engine\utility::flag_wait("mi_mons_thrusters");
  _id_13790(self);
}

_id_BAB4() {
  scripts\sp\utility::_id_22CD("mi_trench_fire_friendlies", 1);
  scripts\sp\utility::_id_107EA("mi_jackal_crash_stumbler");
  thread _id_B6C8();
  var_0 = getEntArray("post_knockdown_trigger", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, scripts\engine\utility::trigger_on);
  level._id_BB5A = 1000;
  level._id_C06F = 1;
  level notify("start_mortars_mi_trenchrun_mortars");
  level._id_BB69 = [level._id_739C, level._id_C47F, level._id_2429];
  thread _id_6786();
  thread _id_126FE();
  level._id_2429 thread _id_B6CA();
  level._id_739C thread _id_B6C6();
  thread _id_A12F();
  thread _id_A133();
}

_id_6786() {
  var_0 = level._id_BAE3;
  thread _id_B6D5();
  var_1 = scripts\engine\utility::getStruct("ethan_pickup_struct", "targetname");
  var_2 = [var_0, level._id_2429];
  var_0 dontinterpolate();
  var_1 thread scripts\sp\anim::_id_1F2C(var_2, "atm_pick_up");
  level.player _meth_823B(var_0, "tag_player");
  scripts\engine\utility::delaythread(0, scripts\sp\vehicle::_id_1080D, "mi_pickup_early_strafer");
  wait 2;
  thread _id_81D2();
  scripts\sp\utility::_id_22CD("mi_pickup_strafer_guys");
  scripts\sp\utility::_id_22CD("mi_pickup_runners_1");
  scripts\engine\utility::flag_set("mi_allow_friendly_fire");
  scripts\engine\utility::flag_set("stop_mons_winds");
  scripts\engine\utility::flag_set("start_mons_close_jackals");
  wait 7;
  level.player scripts\engine\utility::delaycall(6, ::_meth_80E1);
  level.player scripts\engine\utility::delaycall(7, ::clearclienttriggeraudiozone, 1.1);
  level._id_2429 show();
  scripts\engine\utility::delaythread(6.8, scripts\sp\vehicle::_id_1080D, "jackal_strafe_truck_1");
  var_1 waittill("atm_pick_up");
  scripts\engine\utility::flag_set("mi_ethan_pickup_done");
  level._id_2429 scripts\sp\utility::_id_5564();
  scripts\engine\utility::delaythread(2.75, ::_id_BAA8);
  scripts\engine\utility::delaythread(1, scripts\engine\utility::flag_set, "mi_leg_scene_start");
  level._id_2429 _meth_83A1();
  level._id_2429 scripts\sp\utility::_id_86E2();
  scripts\engine\utility::flag_set("mi_c12_path_continue_2");
  level.player unlink();
  level.player _id_0B1F::_id_5990();
  setsaveddvar("player_sprintUnlimited", 1);
  var_0 delete();
  scripts\sp\utility::_id_10FEC("mons_clouds_3");
}

_id_BAA8() {
  var_0 = level.doors["mons_bunker_buddy_door"];
  var_1 = level.player.health * 0.25;

  while(!scripts\engine\utility::flag("mons_bunker_door_opened")) {
    var_2 = scripts\engine\utility::spawn_tag_origin();
    var_3 = randomintrange(2, 4);

    for(var_4 = 0; var_4 < var_3; var_4++) {
      wait(randomfloatrange(0.15, 0.5));
      var_5 = anglesToForward(level.player.angles) * 512;
      var_2.origin = getclosestpointonnavmesh(level.player.origin + var_5 + (randomintrange(-386, 386), randomintrange(-386, 386), 64));
      playFX(scripts\engine\utility::getfx("vfx_hms_c12_rocket_explosion_burst"), var_2.origin);
      earthquake(0.45, 0.75, var_2.origin, 1024);
      radiusdamage(var_2.origin, 512, 5, 0, level._id_B6D6, "MOD_EXPLOSIVE");
      level.player dodamage(var_1, var_2.origin);
      var_2 playSound("rocket_explode");
      level.player playRumbleOnEntity("damage_heavy");
    }

    var_2 delete();
    wait(randomfloatrange(2.1, 3.72));
  }
}

_id_81D2() {
  wait 4;
  setmusicstate("mx_012_gettobunker");
}

_id_B6CD(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  thread _id_A34E(var_0);
  wait 2.5;
  self playSound("jackal_un_flyby_fast_close");
}

_id_B6CE(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  thread _id_A34E(var_0);
  wait 1;
  self playSound("jackal_un_flyby_fast_close");
}

_id_B6CF(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  thread _id_A34E(var_0);
  self playSound("jackal_un_flyby_fast_close");
}

_id_B6D5() {
  scripts\engine\utility::flag_wait("mi_captainsbeenhit_line");
  level._id_B33E thread _id_0C4C::_id_195D(level.player);
}

_id_B6D9(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  self._id_C045 = 1;
  level._id_739C _id_0A05::_id_360D("left", [self], undefined, 0);
  self waittill("death");
  var_1 = self.origin;

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "mi_pickup_c12_target") {
      self playSound("jackal_explode");
      self playSound("scn_monsintro_first_jackal_crash");
    } else {
      self playSound("jackal_explode");
      self playLoopSound("jackal_dying_loop");
      scripts\engine\utility::delaycall(2, ::stoploopsound);
    }
  }

  level._id_739C _id_0A05::_id_352D("left");
}

_id_126FE() {
  thread _id_B6DD("mco_pickup_struct", undefined, level._id_C47F, 1, "mco_pick_up", "mco_pick_up_idle");
  thread _id_B6DD("mr1_pickup_struct", undefined, level._id_B33B, 0, "mr1_pick_up");
  level._id_B33B scripts\sp\utility::_id_51E1("frantic");
  thread _id_B6DF();
  var_0 = scripts\sp\utility::_id_107EA("mi_pickup_redshirt_pickerupper", 1);
  var_0 scripts\sp\utility::_id_B14F(1);
  var_0._id_1FBB = "redshirt_helper";
  level._id_B6D7 = scripts\engine\utility::array_add(level._id_B6D7, var_0);
  thread _id_B6DD("redshirts_1_pickup_struct", "mi_mons_pickup_scenes", var_0, 1, "redshirt_pick_up", "redshirt_pick_up_idle", 1);
}

_id_B6DE() {
  var_0 = getEnt("mco_pickup_ally", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_7A97()[0];
  var_2 = scripts\engine\utility::getStruct("mco_pickup_struct", "targetname");
  var_3 = var_0 scripts\sp\utility::_id_10619(1, 1);
  var_3._id_1FBB = "ally";
  level._id_B6D7 = scripts\engine\utility::array_add(level._id_B6D7, var_3);
  var_2 scripts\sp\anim::_id_1EC3(level._id_C47F, "mco_pick_up");
  var_1 scripts\sp\anim::_id_1EC7(var_3, "hm_grnd_red_run_twitch_stumble02_ar");
  var_2 scripts\sp\anim::_id_1F35(var_3, "mco_pick_up_shot");
  var_2 thread scripts\sp\anim::_id_1EEA(var_3, "mco_pick_up_idle");
  scripts\engine\utility::flag_wait("mi_mons_pickup_scenes");
  var_2 notify("stop_loop");
  var_4 = [level._id_C47F, var_3];
  var_2 scripts\sp\anim::_id_1F2C(var_4, "mco_pick_up");
}

_id_B6DD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_8 = getEnt(var_7.target, "targetname");

  if(var_3)
    var_9 = var_8 scripts\sp\utility::_id_10619(1, 1);
  else
    var_9 = scripts\sp\utility::_id_2C17(var_8);

  var_9._id_1FBB = "redshirt";
  level._id_B6D7 = scripts\engine\utility::array_add(level._id_B6D7, var_9);
  var_9 endon("death");
  var_9 endon("entitydeleted");
  var_10 = [var_2, var_9];

  if(isDefined(var_6))
    var_7 scripts\sp\anim::_id_1EC3(var_9, var_4);
  else
    var_7 scripts\sp\anim::_id_1EC1(var_10, var_4);

  if(isDefined(var_5))
    var_7 thread scripts\sp\anim::_id_1EEA(var_9, var_5);

  if(isDefined(var_1))
    scripts\engine\utility::flag_wait(var_1);

  if(isDefined(var_6))
    var_7 scripts\sp\anim::_id_1F17(var_2, var_4);

  var_7 notify("stop_loop");
  var_7 thread scripts\sp\anim::_id_1F2C(var_10, var_4);

  foreach(var_12 in var_10) {
    if(!isai(var_12)) {
      continue;
    }
    var_13 = var_7 scripts\sp\utility::_id_7A97();

    foreach(var_15 in var_13) {
      if(var_15.script_noteworthy == var_12._id_1FBB)
        var_12 thread _id_B6E3(var_15);
    }
  }
}

_id_B6DF() {
  level._id_B33E scripts\sp\utility::_id_51E1("frantic");
  var_0 = scripts\engine\utility::getStruct("mr2_pickup_struct", "targetname");
  var_1 = getnode(var_0.target, "targetname");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_B33E, "mr2_get_up");
  scripts\engine\utility::waitframe();
  var_0 scripts\sp\anim::_id_1F29(level._id_B33E, "mr2_get_up", 0);
  level._id_B33E _meth_82B0(level._id_B33E scripts\sp\utility::_id_7DC1("mr2_get_up"), 0.2);
  var_0 scripts\sp\anim::_id_1F29(level._id_B33E, "mr2_get_up", 1);
  wait 3.4;
  level._id_B33E _meth_83A1();
  var_1 = getnode(var_0.target, "targetname");
  level._id_B33E thread _id_B6E3(var_1);
}

_id_B6CA() {
  scripts\sp\utility::_id_51E1("sprint");
  self._id_C08B = 1;
  var_0 = _id_7E98("ethan_path_start", "targetname");
  _id_B6E3(var_0);
  self._id_C08B = undefined;
}

_id_B6D1() {
  var_0 = self.spawner;
  scripts\sp\utility::_id_51E1("frantic");
  level._id_B6D7 = scripts\engine\utility::array_add(level._id_B6D7, self);
  var_1 = getnode(var_0.script_linkto, "script_linkname");
  _id_B6E3(var_1);
  var_2 = scripts\engine\utility::getStruct("mi_jackal_crash_stumbler_struct", "script_noteworthy");
  var_2 scripts\sp\anim::_id_1ECE(self, "hm_grnd_red_run_wizby02_ar_noloop");
  var_2 thread scripts\sp\anim::_id_1ECB(self, "hm_grnd_red_run_wizby02_ar_noloop");
  wait 0.1;
  self _meth_83A1();
  var_3 = getnode(var_2.target, "targetname");
  _id_B6E3(var_3);
}

_id_326D() {
  var_0 = level.doors["mons_bunker_buddy_door"];
  var_0 _id_0B1F::_id_5982(scripts\sp\maps\titan\titan_anim::_id_3264, scripts\sp\maps\titan\titan_anim::_id_3265, scripts\sp\maps\titan\titan_anim::_id_3263);
  var_0 _id_0B1F::_id_59EB("scn_titan_bnkr_door_open_grab", "scn_titan_bnkr_door_open_start", "scn_titan_bnkr_door_open_lp", "scn_titan_bnkr_door_shut", "scn_titan_bnkr_door_open_finish");
  var_0._id_28B6 = "right_door_01";
  var_0._id_C633 = 0.5;
  var_0._id_8483 = 0.5;
  scripts\engine\utility::flag_wait("mi_ethan_goto_door");
  level._id_2429 notify("cancel_path");
  level.player _meth_82C0("titan_ext", 1.0);
  var_1 = [level._id_C47F, level._id_B33B, level._id_B33E, level._id_C24B, level._id_2429];
  level._id_DE2F = [];
  var_2 = getEntArray("bunker_door_redshirts", "targetname");

  foreach(var_4 in var_2) {
    var_5 = var_4 scripts\sp\utility::_id_10619(1);
    var_5._id_1FBB = var_4.script_noteworthy;
    var_5 hide();
    var_5 scripts\sp\utility::_id_F2DA(0);
    level._id_DE2F[level._id_DE2F.size] = var_5;
  }

  var_0 scripts\sp\anim::_id_1EC1(level._id_DE2F, var_0 _id_0B1F::_id_5997("outro"));
  level._id_3277 = scripts\engine\utility::array_combine(level._id_DE2F, var_1);
  var_0 thread _id_0B1F::_id_168A(level._id_3277);
  wait 0.5;
  thread _id_326A(var_0);
  var_0 scripts\sp\utility::_id_65E3("door_opened");
  scripts\engine\utility::flag_set("mons_bunker_door_opened");
  wait 0.05;

  if(!level.console)
    waitforalltransients();

  level notify("bunker_run_start");
  scripts\engine\utility::exploder("fx_mons_door");
  visionsetnaked("", 3);

  foreach(var_8 in level._id_3277)
  var_8 show();

  foreach(var_11 in var_1) {
    if(isDefined(var_11))
      var_11 notify("cancel_path");
  }

  thread _id_B6C7();
  thread _id_3283();
  thread _id_326B();
  thread _id_3267();
  var_0 scripts\sp\utility::_id_65E3("door_sequence_complete");
  level.player clearclienttriggeraudiozone(1.0);
}

_id_326A(var_0) {
  var_0 endon("player_used_door");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_helpmegetthis");

  for(;;) {
    wait(randomfloatrange(6, 9));
    scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_helpmegetthis");
  }
}

_id_3283() {
  wait 5;
  setmusicstate("");
}

_id_326B() {
  var_0 = scripts\sp\utility::_id_22CD("mi_bunker_end_runners");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_B14F(1);
    var_3 = getnode(var_2.script_linkto, "script_linkname");
    var_2 thread _id_B6E3(var_3);
    var_2 scripts\sp\utility::_id_51E1("frantic");
    var_2._id_C08B = 1;
  }

  thread scripts\engine\utility::flag_set_delayed("mi_bunker_end_runners_RUN", 5.5);
  scripts\engine\utility::flag_wait("mi_bunker_runners_delete");
  scripts\sp\utility::_id_228A(var_0);
}

_id_3267() {
  var_0 = scripts\engine\utility::getStruct("mi_c12_jackal_crash_struct", "targetname");
  var_1 = scripts\sp\vehicle::_id_1080C("mi_bunker_crash_jackal");
  var_1._id_1FBB = "jackal";
  var_2 = level._id_739C;
  var_2.name = "";
  level._id_3266 = var_1;
  var_3 = [var_1, var_2];
  thread sfx_door_jackal_c12_crash();
  var_0 scripts\sp\anim::_id_1F2C(var_3, "mons_door_crash");
  var_0 thread scripts\sp\anim::_id_1EE0(var_2, "mons_door_crash");
  var_1 delete();
}

sfx_door_jackal_c12_crash() {
  wait 4.4;
  thread scripts\engine\utility::play_sound_in_space("scn_monsintro_jackal_flyin_b4_c12_hit", (-28473, -38848, -64725));
}

_id_3269() {
  var_0 = getEntArray("bunker_doorway_des", "targetname");
  var_1 = getEntArray("bunker_doorway", "targetname");

  foreach(var_3 in var_0) {
    if(var_3.classname == "script_brushmodel")
      var_3 notsolid();

    var_3 hide();
  }

  scripts\engine\utility::flag_wait("mi_bunker_runners_delete");

  foreach(var_3 in var_0) {
    if(var_3.classname == "script_brushmodel")
      var_3 solid();

    var_3 show();
  }

  foreach(var_3 in var_1) {
    if(var_3.classname == "script_brushmodel")
      var_3 hide();

    var_3 hide();
  }

  var_9 = getEnt("c12_friendly_omni_a", "targetname");
  var_10 = getEnt("c12_friendly_omni_b", "targetname");
  var_11 = getEnt("c12_friendly_spot_a", "targetname");

  if(isDefined(var_9)) {
    var_9 setlightintensity(0.0);
    var_9 delete();
  }

  if(isDefined(var_10))
    var_10 delete();

  if(isDefined(var_11))
    var_11 delete();

  if(isDefined(level._id_739C.bt._id_71C9))
    level._id_739C[[level._id_739C.bt._id_71C9]]();
}

_id_3268(var_0) {
  playFX(scripts\engine\utility::getfx("jackal_aerial_expl"), var_0 gettagorigin("tag_turret"));
  var_0 _id_0C1C::_id_4E6C();
  scripts\engine\utility::exploder("fx_jackal_c12_crash_door");
}

_id_B6C6() {
  var_0 = getnode("mi_c12_path_start", "targetname");
  level._id_739C scripts\sp\utility::_id_1160F(var_0);
  level._id_739C _meth_82EE(var_0);
  level._id_739C thread _id_B6E3(var_0);
  level._id_739C.ignoreall = 1;
  level._id_739C scripts\sp\utility::_id_5564();
  level._id_739C scripts\sp\utility::_id_51E1("casual");
  scripts\engine\utility::flag_wait("mi_c12_path_start");
  scripts\engine\utility::delaythread(1.8, ::_id_CB3C);
  scripts\engine\utility::flag_wait("mi_c12_path_continue_1");
  level._id_739C.ignoreall = 0;
  scripts\engine\utility::flag_wait("mi_c12_path_continue_2");
  level._id_739C scripts\sp\utility::_id_51E1("combat");
}

_id_CB3C() {
  var_0 = getEntArray("mi_pickup_strafers", "targetname");

  foreach(var_2 in var_0) {
    var_3 = 0;

    if(isDefined(var_2._id_EF15))
      var_3 = var_2._id_EF15;

    var_2 scripts\engine\utility::delaythread(var_3, scripts\sp\vehicle::_id_1080B);
  }
}

_id_B6E1() {
  self endon("entitydeleted");

  if(isDefined(self.script_parameters) && self.script_parameters == "exploder")
    self._id_9930 = 1;

  if(isDefined(self.script_animation)) {
    self._id_72B1 = scripts\sp\utility::_id_7DC3(self.script_animation);
    scripts\sp\utility::_id_65E3("is_dying");

    if(isDefined(self)) {
      var_0 = self gettagangles("tag_turret");
      var_1 = self gettagorigin("tag_turret");
      var_2 = scripts\engine\utility::getfx("jackal_aerial_expl");
      playFXOnTag(var_2, self, "tag_turret");
    }
  }
}

_id_B6E0() {
  var_0 = self.spawner;
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  self.nocorpsedelete = 1;
  var_2 = 2.2;
  var_3 = var_1.animation;

  if(var_3 == "run_pain_fall") {
    var_1 thread scripts\sp\anim::_id_1EC7(self, var_3);
    scripts\engine\utility::waitframe();
    self _meth_82B0(scripts\sp\utility::_id_7DC3(var_3), 0.16);
    var_2 = 3;
    self._id_4E2A = scripts\sp\utility::_id_7DC3("run_death_fallonback");
    var_4 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    thread _id_B6E3(var_4);
  } else {
    var_1 thread scripts\sp\anim::_id_1EC7(self, var_3);
    self._id_4E2A = scripts\sp\utility::_id_7DC3("run_death_roll");
  }

  wait(var_2);
  self _meth_83A1();
  scripts\sp\utility::_id_54C6();
}

_id_B6DC() {
  scripts\sp\utility::_id_51E1("frantic");
  var_0 = scripts\sp\utility::_id_7A97()[0];
  thread _id_B6E3(var_0);

  if(isDefined(self._id_ED46))
    self._id_4E2A = _id_7DC4(self._id_ED46);

  level._id_B6D7 = scripts\engine\utility::array_add(level._id_B6D7, self);
}

_id_7DC4(var_0) {
  if(isDefined(self._id_1FBB)) {
    var_1 = level._id_EC85[self._id_1FBB][var_0];

    if(isDefined(var_1))
      return var_1;
  }

  var_1 = level._id_EC85["generic"][var_0];
  return var_1;
}

_id_B6CC() {
  var_0 = self.spawner;
  var_1 = getnode(var_0.script_linkto, "script_linkname");
  thread _id_B6E3(var_1);

  if(isDefined(self.script_animation))
    self._id_4E2A = _id_7DC4(self.script_animation);

  level._id_B6D7 = scripts\engine\utility::array_add(level._id_B6D7, self);
  scripts\sp\utility::_id_51E1("frantic");
}

_id_B6C8() {
  var_0 = getEnt("mi_dragtocover_dragger", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1._id_1FBB = "dragger";
  var_2 = getnode(var_0.target, "targetname");
  var_3 = getnode("draggerNodeEnd", "targetname");
  var_1 thread _id_B6E3(var_2);
  level._id_B6D7 = scripts\engine\utility::array_add(level._id_B6D7, var_1);
  var_4 = getnode("mi_dragtocover_nunez_node", "targetname");

  if(!isDefined(level._id_C24B)) {
    level._id_C24B = scripts\sp\utility::_id_107EA("backup_nunez");
    level._id_C24B._id_1FBB = "nunez";
    level._id_C24B.name = "Nunez";
  }

  level._id_C24B scripts\sp\utility::_id_1160F(var_4);
  level._id_C24B thread _id_B6E3(var_4);
  level._id_C24B _meth_82EE(var_4);
  var_5 = [var_1, level._id_C24B];
  var_6 = scripts\engine\utility::getStruct("mi_friendly_drag_struct", "targetname");
  var_7 = scripts\engine\utility::getStruct("dragtocover_idle", "targetname");
  thread _id_B6C9(var_1);
  scripts\engine\utility::flag_wait("mi_leg_scene_start");
  level._id_C24B clearentitytarget();
  var_6 scripts\sp\anim::_id_1F17(var_1, "dragtocover_01");
  var_6 scripts\sp\anim::_id_1F2C(var_5, "dragtocover_01");
  var_1 _meth_83A1();
  var_1.goalradius = 4;
  var_1 _meth_82EE(var_3);
  var_7 thread scripts\sp\anim::_id_1EEA(level._id_C24B, "dragtocover_idle", "stop_dragtocover_loop");
  level waittill("bunker_run_start");
  var_6 notify("stop_dragtocover_loop");
}

_id_B6C9(var_0) {
  scripts\engine\utility::flag_wait("mi_leg_scene_start");
  level._id_C24B scripts\sp\utility::play_sound_on_entity("titan_un3_icantfeelmyleg");
  level._id_C24B scripts\sp\utility::play_sound_on_entity("titan_ksh_takemyhandnunez");
}

_id_B6D2() {
  var_0 = self.spawner;
  self._id_1FBB = "generic";
  var_1 = getnode(var_0.script_linkto, "script_linkname");
  var_2 = getvehiclenode("jackal_crash_earthquake_start", "script_noteworthy");
  var_2 waittill("trigger");
  var_3 = spawnStruct();
  var_3.angles = var_1.angles;
  var_3.origin = scripts\sp\utility::_id_864C(var_1.origin, anglestoup(var_1.angles));
  var_3 thread scripts\sp\anim::_id_1EC7(self, "mi_jackal_dive");
}

_id_B6E3(var_0) {
  self notify("new_run_path");
  self endon("new_run_path");
  self endon("cancel_path");
  self endon("death");
  var_1 = var_0;

  for(;;) {
    if(isDefined(var_1.animation))
      var_1 scripts\sp\anim::_id_1ECE(self, var_1.animation);
    else {
      self.goalradius = 64;

      if(isDefined(var_1.radius))
        self.goalradius = var_1.radius;

      if(isnode(var_1))
        self _meth_82EE(var_1);
      else
        self setgoalpos(var_1.origin);

      self waittill("goal");
    }

    var_1 thread _id_8428();

    if(isDefined(var_1.script_linkto))
      thread _id_19EF(var_1);

    if(isDefined(var_1._id_ED22)) {
      if(var_1._id_ED22)
        scripts\sp\utility::_id_B14F();
      else
        scripts\sp\utility::_id_1101B();
    }

    if(isDefined(var_1._id_ED9E))
      scripts\engine\utility::flag_set(var_1._id_ED9E);

    if(isDefined(var_1._id_EDA0))
      scripts\engine\utility::flag_wait(var_1._id_EDA0);

    var_1 scripts\sp\utility::script_delay();

    if(isDefined(var_1.animation))
      var_1 scripts\sp\anim::_id_1ECB(self, var_1.animation);

    if(!isDefined(var_1.target)) {
      break;
    }

    var_1 = _id_7E98(var_1.target, "targetname");
    self notify("new_path_goal");
  }

  self notify("completed_run_path");

  if(isDefined(var_1._id_ED43)) {
    if(isDefined(self._id_B14F))
      scripts\sp\utility::_id_1101B();

    scripts\sp\utility::_id_54C6();
  }

  if(isDefined(var_1._id_ED54)) {
    if(isDefined(self._id_B14F))
      scripts\sp\utility::_id_1101B();

    self delete();
  }
}

_id_19EF(var_0) {
  var_1 = undefined;
  var_2 = var_0 scripts\sp\utility::_id_7A97();

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_parameters) && var_4.script_parameters == "target") {
      var_1 = var_4;
      break;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(!scripts\engine\utility::flag("mi_allow_friendly_fire")) {
    scripts\engine\utility::flag_wait("mi_allow_friendly_fire");
    wait(randomfloatrange(2, 4));
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  var_6 = var_1 scripts\engine\utility::spawn_tag_origin();

  if(_id_9D77(self)) {
    level._id_739C _id_0A05::_id_360D("left", [var_6], undefined, 0);
    level._id_739C _id_0A05::_id_360D("right", [var_6], undefined, 0);
  } else
    self _meth_82DE(var_6);

  scripts\engine\utility::waittill_any("clear_targeting", "cancel_path", "new_path_goal", "death");

  if(isDefined(self) && isalive(self)) {
    if(_id_9D77(self)) {
      level._id_739C _id_0A05::_id_352D("left");
      level._id_739C _id_0A05::_id_352D("right");
    } else
      self clearentitytarget();
  }

  var_6 delete();
}

_id_8428() {
  var_0 = scripts\sp\utility::_id_7A97();
  var_0 = scripts\engine\utility::array_add(var_0, self);

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_fxid)) {
      continue;
    }
    var_3 = 0;

    if(isDefined(var_2._id_ED96))
      var_3 = var_2._id_ED96;

    scripts\engine\utility::noself_delaycall(var_3, ::playfx, scripts\engine\utility::getfx(var_2.script_fxid), var_2.origin);
  }
}

_id_7E98(var_0, var_1) {
  var_2 = getEnt(var_0, var_1);

  if(isDefined(var_2))
    return var_2;

  var_3 = getnode(var_0, var_1);

  if(isDefined(var_3))
    return var_3;

  return scripts\engine\utility::getStruct(var_0, var_1);
}

_id_B6C5() {
  var_0 = self.spawner;
  scripts\engine\utility::flag_wait(self._id_ED9A);
  self notify("death");
  scripts\engine\utility::waitframe();
  self._id_5960 = 1;
  scripts\sp\anim::_id_1EC7(self, var_0._id_ED46);
  self._id_5960 = 0;
}

_id_4808() {}

#using_animtree("jackal");

_id_A12F() {
  var_0 = getEnt("mi_jackal_crash_trench_clip", "targetname");
  var_0 solid();
  var_0 connectpaths();
  scripts\engine\utility::flag_wait_all("mi_atom_reached_crash_start", "mi_jackal_crash_start");
  var_1 = scripts\sp\vehicle::_id_1080D("jackal_crash_slide");
  var_1 _meth_83D0(#animtree);
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2 linkTo(var_1, "j_cockpit", (0, 0, 0), (0, 0, 0));
  level._id_B6D7 = scripts\engine\utility::array_add(level._id_B6D7, var_2);
  scripts\engine\utility::noself_delaycall(1, ::playfxontag, scripts\engine\utility::getfx("vfx_pmd_cockpit_fire"), var_2, "tag_origin");
  scripts\engine\utility::exploder("pjc_dirt_kickup");
  level._id_2429 scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_10346, "titan_eth_jump");
  thread sfx_jackal_crash(var_2);
  scripts\engine\utility::delaythread(2, scripts\engine\utility::exploder, "pjc fire");
  thread _id_A134(var_1);
  var_3 = scripts\engine\utility::getStruct("mi_jackal_crash_hit_explosion", "targetname");
  playFX(scripts\engine\utility::getfx("jackal_contrete_collide"), var_3.origin);
  playFXOnTag(scripts\engine\utility::getfx("jackal_crash_nose_drag"), var_1, "tag_turret");
  var_1 thread _id_A131();
  var_1 waittill("reached_end_node");
  level notify("swap_jackals");
  var_1 delete();
  scripts\engine\utility::noself_delaycall(1, ::stopfxontag, scripts\engine\utility::getfx("vfx_pmd_cockpit_fire"), var_2, "tag_origin");
}

sfx_jackal_crash(var_0) {
  wait 1.5;
  var_1 = spawn("script_origin", var_0.origin);
  var_1 playSound("scn_monsintro_jackal_crash_impact");
  var_1 playSound("scn_monsintro_jackal_crash_rock_debris");
  var_1 moveTo((-28583, -39882, -64849), 0.9, 0, 0.3);
  wait 6;
  var_1 delete();
}

_id_A133() {
  var_0 = getEnt("jackal_crash_coll", "targetname");
  var_1 = getEnt("jackal_cockpit_goal_0", "targetname");
  var_2 = getEnt("jackal_cockpit_goal_1", "targetname");
  var_3 = getEnt("jackal_cockpit_goal_2", "targetname");
  var_4 = getEnt("jackal_rear_goal_0", "targetname");
  var_5 = getEnt("jackal_rear_goal_1", "targetname");
  var_6 = getEnt("jackal_rear_goal_2", "targetname");
  var_7 = getEnt("jackal_cockpit", "targetname");
  var_8 = getEnt("jackal_rear", "targetname");
  var_9 = getEnt("jackal_crash_pit_trigger", "targetname");
  var_10 = [var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8];

  foreach(var_12 in var_10)
  var_12 hide();

  var_0 notsolid();
  level waittill("swap_jackals");
  var_7 thread _id_A358(var_1, var_2, var_3, 0.25, 0.5, 0.4);
  var_8 thread _id_A358(var_4, var_5, var_6, 0.3, 0.6, 0.5);
  var_7 thread _id_A130();
  var_8 thread _id_A130();
  wait 1;
  var_0 solid();
  level notify("toggle_crash_dmg");

  for(;;) {
    if(level.player istouching(var_9))
      level.player dodamage(35, level.player.origin);

    scripts\engine\utility::waitframe();
  }
}

_id_A358(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  self show();
  var_6 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles + (0, 0, -90));
  var_6 linkTo(self);
  playFXOnTag(scripts\engine\utility::getfx("vfx_pmd_cockpit_fire"), var_6, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("jackal_crash_nose_drag"), var_6, "tag_origin");
  self moveTo(var_1.origin, var_3);
  self rotateTo(var_1.angles, var_3);
  wait(var_3);
  self moveTo(var_2.origin, var_4, 0, var_5);
  self rotateTo(var_2.angles, var_4, 0, var_5);
}

_id_A130() {
  level endon("toggle_crash_dmg");

  for(;;) {
    if(level.player istouching(self))
      level.player dodamage(1000, self.origin);

    scripts\engine\utility::waitframe();
  }
}

_id_A134(var_0) {
  getEnt("mi_jackal_crash_trench_lid", "targetname") scripts\engine\utility::delaycall(2.5, ::hide);
  var_1 = scripts\engine\utility::getStructArray("mi_jackal_crash_trench", "targetname");
  scripts\engine\utility::array_thread(var_1, ::_id_A135, var_0);
}

_id_A135(var_0) {
  wait 0.6;
  scripts\sp\utility::script_delay();
  var_1 = anglestoup(self.angles) * -1;
  var_2 = self.origin + var_1 * 30;
  var_3 = 15;
  var_4 = var_3 * -1;
  var_5 = spawn("script_model", var_2);
  var_5.angles = self.angles + (randomintrange(var_4, var_3), randomintrange(var_4, var_3), randomintrange(var_4, var_3));
  var_5 setModel(self.script_modelname);

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  var_5 moveTo(self.origin, 0.2, 0, 0.1);
  var_5 rotateTo(self.angles, 0.2, 0, 0.1);
}

_id_A131() {
  self endon("reached_end_node");
  var_0 = getvehiclenode("jackal_crash_earthquake_start", "script_noteworthy");
  var_0 waittill("trigger");

  for(;;) {
    earthquake(0.17, 0.1, self.origin, 50000);
    wait 0.05;
  }
}

_id_A34E(var_0) {
  level endon("stop_strafe_" + var_0);
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_3 = distance(var_1.origin, var_2.origin);
  var_4 = 25;

  if(isDefined(var_1.script_speed))
    var_4 = var_1.script_speed;

  var_5 = var_3 / var_4;
  var_6 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_7 = var_1.origin;
  var_8 = vectorNormalize(var_2.origin - var_1.origin);
  var_9 = var_1.radius;
  thread scripts\sp\utility::play_loop_sound_on_tag("jackal_gatling_fire", "tag_spotlight", 1, 1, "jackal_gatling_release");

  for(var_10 = 0; var_10 < var_5; var_10++) {
    var_11 = randomintrange(1, 3);

    for(var_12 = 0; var_12 < var_11; var_12++) {
      var_13 = _id_E45E(var_7, var_9);
      var_6.origin = var_13;
      playFX(scripts\engine\utility::getfx("jackal_bullet_imp"), var_13, (0, 0, 1));
      _id_0C1B::_id_6D30(var_6);
      earthquake(randomfloatrange(0.2, 0.25), 0.1, var_13, 1000);
      playrumbleonposition("artillery_rumble", level.player.origin);
      wait 0.05;
    }

    var_7 = var_7 + var_8 * var_4;
  }

  self notify("stop soundjackal_gatling_fire");
  var_6 delete();
}

_id_B6D8() {
  var_0 = getEnt("mi_mons", "targetname");
  var_0._id_ED7C = "heavy idle";
  level._id_B6D6 = scripts\sp\vehicle::_id_1080C("mi_mons");
  thread _id_BAF2();
  thread _id_BA70();
  var_1 = getvehiclenode("mi_mons_start", "targetname");
  level._id_B6D6 vehicle_teleport(var_1.origin, var_1.angles);
  level._id_B6D6 attachpath(var_1);
  level._id_B6D6 _id_0BB8::_id_397F(1, 0);
  scripts\engine\utility::flag_wait("mi_mons_intro_startpath");
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2 linkTo(level._id_B6D6, "tag_origin", (0, 0, 0), (80, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_titan_mons_intro_wisps"), var_2, "tag_origin");
  scripts\engine\utility::flag_set("mi_mons_lower_jackals");
  level._id_B6D6 thread scripts\sp\vehicle::_id_1321A(var_1);
  scripts\sp\vehicle_paths::_id_845A(level._id_B6D6);
  level._id_B6D6 vehicle_setspeed(120, 100, 100);
  scripts\engine\utility::flag_wait("mons_intro_wave_hit_player");
  level._id_B6D6 vehicle_setspeed(70, 100, 50);
  level._id_B6D6 waittill("reached_end_node");
  scripts\engine\utility::flag_clear("mi_mons_lower_jackals");
}

_id_BA4B() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("mi_mons_intro_jackal_structs", "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_0[var_3.script_noteworthy]))
      var_0[var_3.script_noteworthy] = [];

    var_4 = var_3 scripts\engine\utility::spawn_tag_origin();
    var_4 linkTo(level._id_B6D6);
    var_0[var_3.script_noteworthy] = scripts\engine\utility::array_add(var_0[var_3.script_noteworthy], var_4);
  }

  scripts\engine\utility::flag_wait("mi_mons_lower_jackals");
  var_6 = 20000;

  while(scripts\engine\utility::flag("mi_mons_lower_jackals")) {
    foreach(var_8 in var_0) {
      var_4 = scripts\engine\utility::random(var_8);
      var_9 = var_4 scripts\engine\utility::spawn_tag_origin();
      playFXOnTag(scripts\engine\utility::getfx("jackal_vista"), var_9, "tag_origin");
      var_10 = anglesToForward(var_4.angles);
      var_11 = var_9.origin + var_10 * var_6;
      var_9 moveTo(var_11, 3, 0.2, 0);
      var_9 thread _id_BA4C();
    }

    wait(randomfloatrange(0.1, 0.3));
  }

  foreach(var_8 in var_0)
  scripts\sp\utility::_id_228A(var_8);
}

_id_BA4C() {
  self waittill("movedone");
  self delete();
}

_id_BA70() {
  level endon("mi_stop_mons_strafes");
  scripts\engine\utility::flag_wait("start_mons_close_jackals");
  var_0 = getEntArray("mons_close_jackals", "targetname");
  var_1 = scripts\sp\utility::_id_2299(var_0);

  for(;;) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3.script_index) && var_3.script_index == 3 && !scripts\engine\utility::flag("mi_c12_path_continue_1")) {
        continue;
      }
      wait(randomfloatrange(0.5, 1.5));
      var_4 = var_3 scripts\sp\vehicle::_id_1080B();
      var_4 _id_0BDC::_id_6B4C("none");
      var_4 hide();
      playFXOnTag(scripts\engine\utility::getfx("jackal_midground"), var_4, "tag_origin");
    }
  }
}

_id_BAFB() {
  level endon("mi_stop_mons_strafes");
  var_0 = getEntArray("mons_vista_jackals", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_1[var_3.script_noteworthy]))
      var_1[var_3.script_noteworthy] = [];

    var_1[var_3.script_noteworthy] = scripts\engine\utility::array_add(var_1[var_3.script_noteworthy], var_3);
  }

  foreach(var_6 in var_1) {
    var_7 = scripts\sp\utility::_id_2299(var_6);
    thread _id_BAFA(var_7);
  }
}

_id_BAFA(var_0) {
  level endon("mi_stop_mons_strafes");
  var_1 = [];

  for(;;) {
    foreach(var_5, var_3 in var_0) {
      if(!isDefined(var_3._id_6B51)) {
        var_4 = var_3 scripts\sp\vehicle::_id_1080B();
        var_1[var_5] = var_4;
        playFXOnTag(scripts\engine\utility::getfx("jackal_vista"), var_4, "tag_origin");
        var_4 thread _id_BAFC(var_3);
      } else
        var_3 thread _id_BAF9();

      wait(randomfloatrange(0.5, 1.5));
    }
  }
}

_id_BAF9() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = self._id_6B51["origins"][0];
  var_0.angles = self._id_6B51["angles"][0];
  playFXOnTag(scripts\engine\utility::getfx("jackal_vista"), var_0, "tag_origin");
  var_1 = 0;

  for(;;) {
    var_2 = self._id_6B51["origins"][var_1];
    var_3 = self._id_6B51["angles"][var_1];
    var_0 moveTo(var_2, 0.1);
    var_0 rotateTo(var_3, 0.1);
    wait 0.1;
    var_1++;

    if(!isDefined(self._id_6B51["origins"][var_1])) {
      break;
    }
  }

  var_0 delete();
}

_id_BAFC(var_0) {
  var_0._id_6B51 = [];
  var_0._id_6B51["origins"] = [];
  var_0._id_6B51["angles"] = [];
  var_1 = 0;

  while(isDefined(self)) {
    var_0._id_6B51["origins"][var_1] = self.origin;
    var_0._id_6B51["angles"][var_1] = self.angles;
    var_1++;
    wait 0.1;
  }
}

_id_BAF2() {
  level._id_B6D6 _id_0BB8::_id_397F(1, 0);
  level._id_B6D6 thread scripts\engine\utility::play_loop_sound_on_entity("scn_monsintro_mons_idle_loop_med");
  level._id_B6D6 _id_0BB8::_id_39CD("idle");
  level._id_B6D6 _id_0BB8::_id_39D0("idle");
  scripts\engine\utility::flag_wait("mi_mons_thrusters");
  level._id_B6D6 scripts\engine\utility::delaythread(0.1, scripts\sp\utility::play_sound_on_entity, "scn_monsintro_ship_decel_thruster_blast");
  level._id_B6D6 _id_0BB8::_id_39D0("hburst");
  wait 1.2;
  level._id_B6D6 _id_0BB8::_id_39D0("heavy");
  scripts\engine\utility::flag_wait("mi_mons_thrusters_delete");
  level._id_B6D6 scripts\engine\utility::stop_loop_sound_on_entity("scn_monsintro_mons_idle_loop_med");
  level._id_B6D6 thread scripts\engine\utility::play_loop_sound_on_entity("scn_monsintro_mons_idle_loop_high");
  level._id_B6D6 _id_0BB8::_id_39CD("off");
  scripts\engine\utility::waitframe();
  level._id_B6D6 _id_0BB8::_id_39D0("idle");
  level waittill("bunker_door_scene_done");
  level._id_B6D6 scripts\engine\utility::stop_loop_sound_on_entity("scn_monsintro_mons_idle_loop_high");
}

_id_BA5C() {
  var_0 = getEnt("mons_bunker_light", "script_noteworthy");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 notify("stop_flicker");
  var_0 scripts\sp\lights::_id_ACA3();
  scripts\engine\utility::flag_wait_all("mi_atom_reached_crash_start", "mi_jackal_crash_start");
  var_0 thread scripts\sp\lights::_id_AC8A(1);
  level waittill("bunker_door_scene_done");
  var_0 notify("stop_flicker");
  var_0 scripts\sp\lights::_id_ACA3();
}

_id_B6C7() {
  level._id_B6D7 = scripts\engine\utility::array_removeundefined(level._id_B6D7);

  foreach(var_1 in level._id_B6D7) {
    if(isDefined(var_1._id_B14F))
      var_1 scripts\sp\utility::_id_1101B();

    var_1 delete();
  }

  level waittill("bunker_door_scene_done");
  level._id_2429 scripts\sp\utility::_id_51E1("combat");
  level notify("mi_stop_mons_strafes");
  level notify("stop_mortars_mi_trenchrun_mortars");
  setsaveddvar("player_sprintUnlimited", 0);
}

_id_BAAB() {
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  scripts\sp\utility::_id_CF8B();
  [[level.func["titan_spawn_heroes"]]]();
  _id_F987();
  level._id_C24B = scripts\sp\utility::_id_107EA("nunez");
  level._id_C24B._id_1FBB = "nunez";
  level._id_C24B.name = "Nunez";
  level._id_C24B scripts\sp\utility::_id_B14F(1);
  level._id_2429.script_noteworthy = "atom";
  level._id_C47F.script_noteworthy = "omar";
  level._id_B33B.script_noteworthy = "marine1";
  level._id_B33E.script_noteworthy = "marine2";
  var_0 = [level.player, level._id_739C, level._id_2429, level._id_C47F, level._id_B33B, level._id_B33E];

  foreach(var_2 in var_0)
  var_2.goalradius = 32;

  scripts\sp\utility::_id_F5AF("mons_intro_knockback_start", var_0);
}

_id_BAB5() {
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  scripts\sp\utility::_id_CF8B();
  scripts\engine\utility::flag_set("mi_mons_intro_startpath");
  [[level.func["titan_spawn_heroes"]]]();
  _id_F987();
  level._id_C24B = scripts\sp\utility::_id_107EA("nunez");
  level._id_C24B._id_1FBB = "nunez";
  level._id_C24B.name = "Nunez";
  level._id_C24B scripts\sp\utility::_id_B14F(1);
  playFX(scripts\engine\utility::getfx("vfx_mons_knocback_camera_dust"), level.player.origin);
  level._id_BAE3 = scripts\sp\utility::_id_10639("player_rig");
  thread _id_B6D8();
  thread scripts\sp\maps\titan\titan_code::_id_D250(3);
  thread _id_3269();
}

_id_BAA4() {
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  scripts\sp\utility::_id_CF8B();
  scripts\engine\utility::flag_set("mi_ethan_goto_door");
  scripts\engine\utility::flag_set("mi_allow_friendly_fire");
  [[level.func["titan_spawn_heroes"]]]();
  _id_F987();
  level._id_C24B = scripts\sp\utility::_id_107EA("nunez");
  level._id_C24B._id_1FBB = "nunez";
  level._id_C24B.name = "Nunez";
  level._id_C24B scripts\sp\utility::_id_B14F(1);
  thread _id_B6D8();
  thread _id_BAA8();
  var_0 = getEnt("mi_jackal_crash_trench_clip", "targetname");
  var_0 connectpaths();
  var_1 = [level.player, level._id_2429];
  scripts\sp\utility::_id_F5AF("mons_intro_door_start", var_1);
  scripts\engine\utility::exploder("pjc fire");
  thread scripts\sp\maps\titan\titan_code::_id_D250(3);
  thread _id_3269();
}

_id_F987() {
  var_0 = getEnt("friendly_c12_spawner", "targetname");
  var_0.count = 1;
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1 scripts\sp\utility::_id_65E0("enable_auto_move");
  var_1 thread scripts\sp\utility::_id_5131();
  var_1._id_1FBB = "c12_ally";
  var_1.script_noteworthy = "c12_ally";
  level._id_739C = var_1;
}

_id_E45E(var_0, var_1, var_2) {
  var_3 = var_1 * randomfloat(1.0);
  var_4 = randomfloat(360.0);
  var_5 = sin(var_4);
  var_6 = cos(var_4);
  var_7 = var_3 * var_6;
  var_8 = var_3 * var_5;
  var_9 = 0;

  if(isDefined(var_2))
    var_9 = randomfloatrange(var_2 * -1, var_2);

  var_7 = var_7 + var_0[0];
  var_8 = var_8 + var_0[1];
  var_9 = var_9 + var_0[2];
  return (var_7, var_8, var_9);
}

_id_9D77(var_0) {
  if(isDefined(var_0.unittype) && var_0.unittype == "c12")
    return 1;

  return 0;
}

_id_D7EF() {
  _id_D7F2();
  _id_D7F5();
  _id_D7F4();
  _id_D7F3();
  _id_D7F1();
  _id_D7F6();
}

#using_animtree("generic_human");

_id_D7F2() {
  level._id_EC85["atom"]["atm_pick_up"] = % titan_mons_intro_eth3n_pickup;
  scripts\sp\anim::_id_17F6("atom", "unhide_eth3n", ::_id_100D8, "atm_pick_up");
  level._id_EC85["generic"]["payback_escape_forward_wave_right_price"] = % payback_escape_forward_wave_right_price;
  level._id_EC85["redshirt"]["mco_pick_up_shot"] = % titan_mons_intro_b_ally01_shotdown;
  level._id_EC85["redshirt"]["mco_pick_up_idle"][0] = % titan_mons_intro_b_ally01_down_idle;
  level._id_EC85["omar"]["mco_pick_up"] = % titan_mons_intro_b_mco_help_up;
  level._id_EC85["redshirt"]["mco_pick_up"] = % titan_mons_intro_b_ally01_help_up;
  level._id_EC85["marine1"]["mr1_pick_up"] = % titan_mons_intro_b_mr1_help_up;
  level._id_EC85["redshirt"]["mr1_pick_up"] = % titan_mons_intro_b_ally02_help_up;
  level._id_EC85["marine2"]["mr2_get_up"] = % hm_grnd_red_exposed_extend_pain02_ar;
  level._id_EC85["marine2"]["mr2_get_up_2_run"] = % hm_grnd_red_exposed_exit_ar_8;
  level._id_EC85["redshirt"]["redshirt_pick_up_idle"][0] = % hc_wounded_pickup_guy1_idle_b;
  level._id_EC85["redshirt"]["redshirt_pick_up"] = % hc_wounded_pickup_guy1_b;
  level._id_EC85["redshirt_helper"]["redshirt_pick_up"] = % hc_wounded_pickup_guy_b;
  level._id_EC85["generic"]["hm_grnd_red_exposed_extend_pain01_ar"] = % hm_grnd_red_exposed_extend_pain01_ar;
  level._id_EC85["generic"]["run_pain_fall"] = % run_pain_fall;
  level._id_EC85["atom"]["mons_door_intro"] = % titan_bunker_c6i_buddy_door_intro;
  level._id_EC85["atom"]["mons_door_idle"][0] = % titan_bunker_c6i_buddy_door_idle;
  level._id_EC85["atom"]["mons_door_pull"] = % titan_bunker_c6i_buddy_door_pull;
  level._id_EC85["atom"]["mons_door_open"] = % titan_bunker_c6i_buddy_door_enter_pcap;
  level._id_EC85["marine1"]["mons_door_open"] = % titan_bunker_mr1_buddy_door_enter_pcap;
  level._id_EC85["marine2"]["mons_door_open"] = % titan_bunker_mr2_buddy_door_enter_pcap;
  level._id_EC85["omar"]["mons_door_open"] = % titan_bunker_mco_buddy_door_enter_pcap;
  level._id_EC85["nunez"]["mons_door_open"] = % titan_bunker_ally01_buddy_door_enter_pcap;
  level._id_EC85["redshirt1"]["mons_door_open"] = % titan_bunker_ally02_buddy_door_enter_pcap;
  level._id_EC85["redshirt2"]["mons_door_open"] = % titan_bunker_ally03_buddy_door_enter_pcap;
  level._id_EC85["redshirt3"]["mons_door_open"] = % titan_bunker_ally04_buddy_door_enter_pcap;
  level._id_EC85["generic"]["hm_grnd_red_run_twitch_point_ar"] = % hm_grnd_red_run_twitch_point_ar;
  level._id_EC85["generic"]["hm_grnd_red_run_twitch_stumble01_ar"] = % hm_grnd_red_run_twitch_stumble01_ar;
  level._id_EC85["generic"]["hm_grnd_red_run_twitch_stumble02_ar"] = % hm_grnd_red_run_twitch_stumble02_ar;
  level._id_EC85["generic"]["hm_grnd_red_run_twitch_look_behind01_ar"] = % hm_grnd_red_run_twitch_look_behind01_ar;
  level._id_EC85["generic"]["hm_grnd_red_run_wizby02_ar_noloop"] = % hm_grnd_red_run_wizby02_ar_noloop;
  level._id_EC85["generic"]["run_react_stumble_non_loop"] = % run_react_stumble_non_loop;
  level._id_EC85["generic"]["run_lowready_f_noloop"] = % run_lowready_f_noloop;
  level._id_EC85["generic"]["mi_jackal_dive"] = % stand_exposed_dive;
  level._id_EC85["generic"]["mons_wind_walk_0"] = % payback_pmc_sandstorm_stumble_1;
  level._id_EC85["generic"]["mons_wind_walk_1"] = % payback_pmc_sandstorm_stumble_2;
  level._id_EC85["generic"]["mons_wind_walk_2"] = % payback_pmc_sandstorm_stumble_3;
  level._id_EC85["dragger"]["dragtocover_01"] = % iw7_hm_grnd_dragtocover01a;
  level._id_EC85["nunez"]["dragtocover_01"] = % iw7_hm_grnd_dragtocover01b;
  level._id_EC85["nunez"]["dragtocover_idle"][0] = % ph_hill400_allied_injured_ambient_loop_02;
  level._id_EC85["generic"]["explode_f_01"] = % death_explosion_stand_f_v1;
  level._id_EC85["generic"]["explode_b_01"] = % death_explosion_stand_b_v1;
  level._id_EC85["generic"]["explode_r_01"] = % death_explosion_stand_r_v1;
  level._id_EC85["generic"]["run_death_fallonback"] = % run_death_fallonback_no_ntrk;
  level._id_EC85["generic"]["run_death_roll"] = % run_death_roll;
  level._id_EC85["generic"]["run_death_flop"] = % run_death_roll;
  level._id_EC85["corpse"]["exposed_death_neckgrab"] = % exposed_death_neckgrab;
  level._id_EC85["corpse"]["exposed_death_firing"] = % exposed_death_firing;
  level._id_EC85["corpse"]["exposed_death_nerve"] = % exposed_death_nerve;
  level._id_EC85["corpse"]["exposed_death_twist"] = % exposed_death_twist;
}

#using_animtree("player");

_id_D7F5() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["mons_knockdown"] = % titan_mons_intro_player_knockback;
  level._id_EC85["player_rig"]["atm_pick_up"] = % titan_mons_intro_player_pickup;
  scripts\sp\anim::_id_17F6("player_rig", "lock_camera", ::_id_B6DB, "atm_pick_up");
  scripts\sp\anim::_id_17F6("player_rig", "free_camera", ::_id_B6DA, "atm_pick_up");
  scripts\sp\anim::_id_17FA("player_rig", "injured_pickup", "mi_mons_pickup_scenes", "atm_pick_up");
  scripts\sp\anim::_id_17FA("player_rig", "c12_enter", "mi_c12_path_start", "atm_pick_up");
  scripts\sp\anim::_id_17FA("player_rig", "line_captainsbeenhit", "mi_captainsbeenhit_line", "atm_pick_up");
  level._id_EC85["player_rig"]["mons_door_intro"] = % titan_bunker_plr_buddy_door_intro;
  level._id_EC85["player_rig"]["mons_door_idle"][0] = % titan_bunker_plr_buddy_door_idle;
  level._id_EC85["player_rig"]["mons_door_pull"] = % titan_bunker_plr_buddy_door_pull;
  level._id_EC85["player_rig"]["mons_door_open"] = % titan_bunker_plr_buddy_door_enter_pcap;
  scripts\sp\anim::_id_17FA("player_rig", "player_give_control", "bunker_door_unlink_player", "mons_door_open");
}

#using_animtree("script_model");

_id_D7F4() {
  level._id_EC87["fake_jackal"] = #animtree;
  level._id_EC8C["fake_jackal"] = "veh_mil_air_ca_jackal_01";
  level._id_EC85["gate"]["mi_gate_approach"] = % titan_third_gate_breakthrough_gate_enter;
  level._id_EC85["gate"]["mi_gate_approach_idle"][0] = % titan_third_gate_breakthrough_gate_closed_idle;
  level._id_EC85["gate"]["mi_gate_open"] = % titan_third_gate_breakthrough_gate_push;
  level._id_EC85["gate"]["mi_gate_idle"][0] = % titan_third_gate_breakthrough_gate_idle;
  level._id_EC85["gate"]["mi_gate_exit"] = % titan_third_gate_breakthrough_gate_exit;
  level._id_EC85["mons_door"]["mons_door_pull"] = % titan_bunker_door_buddy_door_pull;
  level._id_EC85["mons_door"]["mons_door_idle"][0] = % titan_bunker_door_buddy_door_idle;
  level._id_EC85["mons_door"]["mons_door_open"] = % titan_bunker_door_buddy_door_enter_pcap;
}

#using_animtree("jackal");

_id_D7F3() {
  level._id_EC85["generic"]["death_roll_right"] = % jackal_death_01;
  level._id_EC85["generic"]["death_roll_left"] = % jackal_death_02;
  level._id_EC85["generic"]["death_roll_center"] = % jackal_death_04;
  level._id_EC85["jackal"]["mons_door_crash"] = % titan_bunker_crash_jackal;
  scripts\sp\anim::_id_17F6("jackal", "jackal_gun_fire", ::_id_A1C4, "mons_door_crash");
  scripts\sp\anim::_id_17F6("jackal", "jackal_hit", ::_id_A1C5, "mons_door_crash");
  scripts\sp\anim::_id_17F6("jackal", "jackal_hit", ::_id_3268, "mons_door_crash");
  scripts\sp\anim::_id_17FC("jackal", "scn_monsintro_jackal_hits_c12_impact", "bunker_door_swap", "mons_door_crash");
  scripts\sp\anim::_id_17FA("jackal", "scn_monsintro_jackal_hits_c12_impact", "mi_bunker_runners_delete", "mons_door_crash");
}

#using_animtree("c12");

_id_D7F1() {
  level._id_EC85["c12_ally"]["mi_gate_approach"] = % titan_third_gate_breakthrough_c12_enter;
  level._id_EC85["c12_ally"]["mi_gate_approach_idle"][0] = % titan_third_gate_breakthrough_c12_closed_idle;
  level._id_EC89["c12_ally"]["mi_gate_approach_idle"] = 0;
  level._id_EC85["c12_ally"]["mi_gate_open"] = % titan_third_gate_breakthrough_c12_push;
  level._id_EC85["c12_ally"]["mi_gate_idle"][0] = % titan_third_gate_breakthrough_c12_idle;
  level._id_EC85["c12_ally"]["mi_gate_exit"] = % titan_third_gate_breakthrough_c12_exit;
  level._id_EC85["generic"]["c12_grnd_org_exposed_melee_punch"] = % c12_grnd_org_exposed_melee_punch;
  level._id_EC85["c12_ally"]["mons_door_crash"] = % titan_bunker_crash_c12;
  scripts\sp\anim::_id_17F6("c12_ally", "c12_fire_start", ::_id_356E, "mons_door_crash");
  scripts\sp\anim::_id_17F6("c12_ally", "c12_fire_end", ::_id_352B, "mons_door_crash");
  scripts\sp\anim::_id_17F6("c12_ally", "missile_fire", ::_id_356F, "mons_door_crash");
}

#using_animtree("vehicles");

_id_D7F6() {
  level._id_EC85["generic"]["titan_mons_intro_truck1_blowup"] = % titan_mons_intro_truck1_blowup;
  level._id_EC85["generic"]["titan_mons_intro_truck2_blowup"] = % titan_mons_intro_truck2_blowup;
}

_id_B6DB(var_0) {
  level.player _meth_823B(var_0, "tag_player");
}

_id_B6DA(var_0) {
  var_1 = 10;
  level.player playerlinktodelta(var_0, "tag_player", 0, var_1, var_1, var_1, 0, 1);
}

_id_100D8(var_0) {
  var_0 show();
}

_id_356E(var_0) {
  var_0._id_EE18 = 1;
  var_0 playSound("weap_c12_minigun_spinup");
  var_0 playLoopSound("weap_c12_minigun_fire");

  while(isDefined(var_0._id_EE18)) {
    var_1 = "left";
    var_2 = "tag_weapon_rotate_le";
    var_3 = var_0.secondaryweapon;
    var_4 = var_0 _id_0C41::_id_3587(var_1);
    var_5 = var_0 _id_0C41::_id_3585(var_1);
    var_6 = 1;
    var_7 = 0;
    var_8 = level._id_3266.origin;
    var_9 = bulletspread(var_4, var_8, 4);
    var_0 _meth_8494(var_3, var_4, var_5, var_6, var_9, var_7, 0, var_2);
    wait 0.1;
  }

  var_0 stoploopsound();
}

_id_352B(var_0) {
  var_0._id_EE18 = undefined;
}

_id_356F(var_0) {
  var_1 = ["top", "bottom"];
  var_2 = 1;
  var_3 = var_0 _id_0C41::_id_3593("right", var_1[var_2]);
  var_4 = var_0 _id_0C41::_id_3592("right", var_1[var_2]);
  var_5 = anglesToForward(var_4);
  var_6 = var_0.primaryweapon;
  var_7 = magicbullet(var_6, var_3, var_3 + var_5 * 256);
  var_8 = level._id_3266 scripts\engine\utility::spawn_tag_origin();
  var_7 missile_settargetEnt(var_8);
  level waittill("bunker_door_scene_done");

  if(isDefined(var_7))
    var_7 delete();

  var_8 delete();
}

_id_A1C4(var_0) {
  var_0 endon("stop_firing_turrets_scripted");

  for(;;) {
    var_0 _id_0C1B::_id_6D30(level._id_739C);
    wait 0.1;
  }
}

_id_A1C5(var_0) {
  var_0 notify("stop_firing_turrets_scripted");
}