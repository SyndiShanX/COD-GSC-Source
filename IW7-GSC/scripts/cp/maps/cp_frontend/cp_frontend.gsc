/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_frontend\cp_frontend.gsc
*******************************************************/

func_CDA4(var_0) {
  wait(var_0);
  frontendscenecameracinematic("zombies_lobby_candy_comp");
}

func_1067E(var_0, var_1, var_2) {
  var_3 = randomint(100) > 50;
  if(isDefined(var_2) && var_2 == "male") {
    var_3 = 1;
  } else if(isDefined(var_2) && var_2 == "female") {
    var_3 = 0;
  }

  if(var_3) {
    var_4 = scripts\engine\utility::random(level.var_3FA3);
    var_5 = scripts\engine\utility::random(level.var_3FA4);
  } else {
    var_4 = scripts\engine\utility::random(level.var_3F9A);
    var_5 = scripts\engine\utility::random(level.var_3F9B);
  }

  var_6 = spawn("script_model", (0, 0, 0));
  var_6.angles = var_0.angles;
  var_6 setModel(var_4);
  var_6.head = spawn("script_model", var_6 gettagorigin("j_spine4"));
  var_6.head.angles = var_6 gettagangles("j_spine4");
  var_6.head setModel(var_5);
  var_6.head linkto(var_6, "j_spine4");
  if(isDefined(var_1)) {
    var_6.gun = spawn("script_model", var_6 gettagorigin("tag_weapon_left"));
    var_6.gun.angles = var_6 gettagangles("tag_weapon_left");
    var_6.gun setModel("weapon_revolver_wm");
    var_6.gun linkto(var_6, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  }

  return var_6;
}

func_10823(var_0, var_1) {
  var_2 = randomint(100) > 50;
  if(isDefined(var_1) && var_1 == "male") {
    var_2 = 1;
  } else if(isDefined(var_1) && var_1 == "female") {
    var_2 = 0;
  }

  if(var_2) {
    var_3 = scripts\engine\utility::random(level.var_13F3B);
    var_4 = scripts\engine\utility::random(level.var_13F3D);
    if(randomint(100) > 70) {
      var_5 = undefined;
    } else {
      var_5 = scripts\engine\utility::random(level.var_13F3C);
    }
  } else {
    var_3 = scripts\engine\utility::random(level.var_13F21);
    var_4 = scripts\engine\utility::random(level.var_13F23);
    if(randomint(100) > 70) {
      var_5 = undefined;
    } else {
      var_5 = scripts\engine\utility::random(level.var_13F22);
    }
  }

  var_6 = spawn("script_model", (0, 0, 0));
  var_6.angles = var_0.angles;
  var_6 setModel(var_3);
  var_6.head = spawn("script_model", var_6 gettagorigin("j_spine4"));
  var_6.head.angles = var_6 gettagangles("j_spine4");
  var_6.head setModel(var_4);
  if(isDefined(var_5)) {
    if(var_2) {
      var_7 = "j_spine4";
    } else {
      var_7 = "j_neck";
    }

    var_6.var_8861 = spawn("script_model", var_6.head gettagorigin(var_7));
    var_6.var_8861.angles = var_6.head gettagangles(var_7);
    var_6.var_8861 setModel(var_5);
    var_6.var_8861 linkto(var_6.head, var_7);
  }

  var_6.head linkto(var_6, "j_spine4");
  wait(1);
  playFXOnTag(level._effect["yellow_eye_glow"], var_6.head, "j_eyeball_ri");
  playFXOnTag(level._effect["yellow_eye_glow"], var_6.head, "j_eyeball_le");
  return var_6;
}

setup_interact() {
  level.var_13F40 = getent("mugging_01", "targetname");
  level.var_13F41 = getent("mugging_02", "targetname");
  level.var_13F42 = getent("mugging_03", "targetname");
  func_F9DC();
  level thread func_107F1();
  wait(0.05);
  level thread func_CDA4(2);
  wait(0.05);
  level thread func_10672();
  wait(0.05);
  level thread func_1067F();
  wait(1);
  var_0 = getent("pap_machine", "targetname");
  var_0 setscriptablepartstate("machine", "upgraded");
  var_0 setscriptablepartstate("reels", "on_frontend");
  wait(1);
  var_0 setscriptablepartstate("door", "close");
  wait(1);
  var_0 setscriptablepartstate("door", "open_idle");
  playFX(level._effect["vfx_zb_sj_smk"], (-26, -330, 225), anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
}

func_F9DC() {
  level.var_3FA3 = ["c_civ_zur_male_body1_3", "c_civ_zur_male_body2_4"];
  level.var_3F9A = ["c_civ_zur_female_body5_3", "c_civ_zur_female_body4_1"];
  level.var_3F9B = ["head_female_bc_01", "head_female_bc_02"];
  level.var_3FA4 = ["head_bg_var_head_male_bc_02_head_male_bc_05", "head_bg_var_head_male_bc_02_head_male_bc_07"];
  level.var_13F3B = ["zmb_male_fullbody_outfit_03_3", "zmb_male_fullbody_outfit_01", "zmb_male_fullbody_outfit_02_2"];
  level.var_13F21 = ["zmb_female_fullbody_outfit_05", "zmb_female_fullbody_outfit_03_3", "zmb_female_fullbody_outfit_04"];
  level.var_13F3D = ["zmb_male_head_01"];
  level.var_13F23 = ["zmb_female_head_01", "zmb_female_head_02"];
  level.var_13F3C = [];
  level.var_13F22 = ["zmb_female_head_01_hair_boatswaine_blonde", "zmb_female_head_01_hair_boatswaine"];
}

func_4EA7() {
  for(;;) {
    if(getdvar("scr_zombie_scene") != "") {
      switch (getdvar("scr_zombie_scene")) {
        case "mug_1":
          level thread func_BDA9(1);
          setdvar("scr_zombie_scene", "");
          break;

        case "mug_2":
          level thread func_BDA9(2);
          setdvar("scr_zombie_scene", "");
          break;

        case "mug_3":
          level thread func_BDA9(3);
          setdvar("scr_zombie_scene", "");
          break;

        case "shoot_1":
          level thread func_FEC4();
          setdvar("scr_zombie_scene", "");
          break;

        case "drag_1":
          level thread func_5B17();
          setdvar("scr_zombie_scene", "");
          break;

        case "drag_2":
          level thread func_5B18();
          setdvar("scr_zombie_scene", "");
          break;
      }
    }

    wait(1);
  }
}

func_71A4() {
  level endon("stop_fnf_machine");
  if(!isDefined(level.var_71A3)) {
    level.var_71A3 = spawnfx(level._effect["fnfeyes"], (1881, 176, -942), anglesToForward((0, -90, 0)), anglestoup((0, -90, 0)));
  }

  wait(0.1);
  triggerfx(level.var_71A3);
  var_0 = getent("fnf_jaw", "targetname");
  var_0.origin = (1881, 173.5, -882.2);
  for(;;) {
    wait(randomintrange(1, 3));
    var_0 movez(-1, 0.2);
    var_0 waittill("movedone");
    var_0 movez(1, 0.2);
    var_0 waittill("movedone");
  }
}

should_use_alt_machine() {
  if(getdvarint("loc_language") != 15 && getdvarint("loc_language") != 1) {
    return 1;
  }

  return 0;
}

func_F47A(var_0) {
  if(!isDefined(var_0)) {
    var_1 = "map_select_0";
  } else {
    var_1 = "map_select_" + var_1;
  }

  var_2 = getent(var_1, "targetname").origin;
  var_3 = getent(var_1, "targetname").angles;
  var_4 = scripts\engine\utility::istrue(level.var_B329);
  if(var_4) {
    frontendscenecamerafade(0, 0.2);
    wait(0.25);
  }

  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_2;
  level.camera_anchor.angles = var_3;
  frontendscenecamerafov(65, 0.05);
  if(var_4) {
    wait(0.1);
    frontendscenecamerafade(1, 0.2);
  }
}

func_F2D6() {
  level endon("camera_position_requested");
  frontendscenecamerafade(0, 0.2);
  wait(0.25);
  self setdepthoffield(0.1, 0.2, 30, 5000, 4, 1.8);
  func_F522("barracks_cam");
  wait(0.1);
  frontendscenecamerafade(1, 0.2);
}

func_F46B() {
  level endon("camera_position_requested");
  if(isDefined(level.var_394)) {
    level.var_394 delete();
  }

  frontendscenecamerafade(0, 0.2);
  self setdepthoffield(0.1, 0.2, 30, 5000, 4, 1.8);
  wait(0.25);
  func_F522("player_loadout_cam");
  frontendscenecamerafov(85);
  wait(0.1);
  frontendscenecamerafade(1, 0.2);
}

func_F46C() {
  self setdepthoffield(0.1, 0.2, 30, 5000, 4, 1.8);
  func_F522("player_loadout_cam");
  frontendscenecamerafov(85);
}

func_F61A() {
  if(!scripts\engine\utility::istrue(self.opened_weapon_select)) {
    level.var_3CAD = spawn("script_character", (0, 0, 0), 0, 0, 0);
  }

  level.var_394 = spawn("script_weapon", getent("weapon_loc", "targetname").origin, 0, 0, 0);
  self.opened_weapon_select = 1;
  level.var_394.angles = getent("weapon_loc", "targetname").angles;
  level.var_394 setotherent(level.var_3CAD);
  frontendscenecamerafov(65);
  func_F522("player_weapon_cam");
}

func_F619() {
  var_0 = getent("gun_light", "targetname");
  var_0 setlightintensity(10);
  frontendscenecamerafov(65);
  self setdepthoffield(0, 15, 50, 80, 10, 8);
}

func_F46A() {
  self setdepthoffield(0.1, 0.2, 30, 5000, 4, 1.8);
  frontendscenecamerafov(85);
}

func_BC0F() {
  level endon("camera_position_requested");
  frontendscenecameracinematic("");
  frontendscenecamerafade(0, 0.2);
  wait(0.25);
  thread func_13EFF("back_to_main_view", undefined, ::func_F41D);
  self setdepthoffield(0.1, 0.2, 30, 5000, 4, 1.8);
  wait(0.1);
  frontendscenecamerafade(1, 0.2);
}

func_BC8F() {
  frontendscenecamerafade(0, 0.2);
  wait(0.25);
  thread func_13EFF("lobby");
  wait(0.1);
  frontendscenecamerafade(1, 0.2);
}

func_C573() {
  if(isDefined(level.var_D372)) {
    return;
  }

  level.var_D372 = 1;
}

func_375B() {
  func_C573();
  level.playerviewowner = self;
  func_F41D();
  level.shuffle_songs = [];
  thread scripts\cp_mp\frontendutils::frontend_camera_watcher(::func_37BA);
  thread zm_map_select_watcher();
  thread init_soul_key();
  thread play_lobby_music();
  thread shuffle_watcher();
  thread watch_boss_battle();
  thread watch_reset_boss_battle();
}

play_lobby_music() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "music_changed") {
      var_2 = get_zombies_music(var_1);
      if(var_2 != "shuffle") {
        level notify("shuffle_changed");
        level.shuffle_playing = 0;
        setmusicstate(var_2);
      } else {
        thread run_shuffle_music();
      }
    }
  }
}

shuffle_watcher() {
  thread watch_shuffle_check_1();
  thread watch_shuffle_check_2();
  thread watch_shuffle_check_3();
  thread watch_shuffle_check_4();
  thread watch_shuffle_check_5();
  thread watch_shuffle_check_6();
  thread watch_shuffle_check_7();
  thread watch_shuffle_check_8();
  thread watch_shuffle_check_9();
  thread watch_shuffle_check_10();
  thread watch_shuffle_check_11();
}

watch_shuffle_check_1() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_1" && var_1 > 0) {
      level.shuffle_songs[1] = 1;
    }
  }
}

watch_shuffle_check_2() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_2" && var_1 > 0) {
      level.shuffle_songs[2] = 1;
    }
  }
}

watch_shuffle_check_3() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_3" && var_1 > 0) {
      level.shuffle_songs[3] = 1;
    }
  }
}

watch_shuffle_check_4() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_4" && var_1 > 0) {
      level.shuffle_songs[4] = 1;
    }
  }
}

watch_shuffle_check_5() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_5" && var_1 > 0) {
      level.shuffle_songs[5] = 1;
    }
  }
}

watch_shuffle_check_6() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_6" && var_1 > 0) {
      level.shuffle_songs[6] = 1;
    }
  }
}

watch_shuffle_check_7() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_7" && var_1 > 0) {
      level.shuffle_songs[7] = 1;
    }
  }
}

watch_shuffle_check_8() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_8" && var_1 > 0) {
      level.shuffle_songs[8] = 1;
    }
  }
}

watch_shuffle_check_9() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_9" && var_1 > 0) {
      level.shuffle_songs[9] = 1;
    }
  }
}

watch_shuffle_check_10() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_10" && var_1 > 0) {
      level.shuffle_songs[10] = 1;
    }
  }
}

watch_shuffle_check_11() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "songcheck_11" && var_1 > 0) {
      level.shuffle_songs[11] = 1;
    }
  }
}

run_shuffle_music() {
  if(scripts\engine\utility::istrue(level.shuffle_playing)) {
    return;
  }

  level.shuffle_playing = 1;
  level endon("game_ended");
  self endon("disconnect");
  level endon("shuffle_changed");
  wait(1);
  var_0 = 22;
  var_1 = -1;
  for(;;) {
    var_2 = randomintrange(1, var_0 + 1);
    if(var_2 != var_1) {
      var_1 = var_2;
      var_3 = int(tablelookup("cp\zombies\lobby_music_shuffle.csv", 0, var_2, 2));
      if(var_3 != 0) {
        var_4 = scripts\engine\utility::istrue(level.shuffle_songs[var_3]);
      } else {
        var_4 = 1;
      }

      if(var_4) {
        var_5 = tablelookup("cp\zombies\lobby_music_shuffle.csv", 0, var_2, 1);
        var_6 = int(tablelookup("cp\zombies\lobby_music_shuffle.csv", 0, var_2, 3));
        var_6 = var_6 / 1000;
        setmusicstate(var_5);
        wait(var_6);
        setmusicstate("");
      }
    }
  }
}

get_zombies_music(var_0) {
  switch (var_0) {
    case 0:
      var_1 = "music_mainmenu_cp_main";
      break;

    case 1:
      var_1 = "music_mainmenu_cp_mw2";
      break;

    case 2:
      var_1 = "music_mainmenu_cp_mw1";
      break;

    case 3:
      var_1 = "music_mainmenu_cp_rave_hidden";
      break;

    case 4:
      var_1 = "music_mainmenu_cp_disco_hidden";
      break;

    case 5:
      var_1 = "music_mainmenu_cp_town_hidden";
      break;

    case 6:
      var_1 = "music_mainmenu_cp_final_hidden";
      break;

    case 7:
      var_1 = "music_mainmenu_cp_perk_01_upnatoms";
      break;

    case 8:
      var_1 = "music_mainmenu_cp_perk_02_racinstripes";
      break;

    case 9:
      var_1 = "music_mainmenu_cp_perk_03_slappytaffy";
      break;

    case 10:
      var_1 = "music_mainmenu_cp_perk_04_bombstoppers";
      break;

    case 11:
      var_1 = "music_mainmenu_cp_perk_05_tuffnuff";
      break;

    case 12:
      var_1 = "music_mainmenu_cp_perk_06_bangbangs";
      break;

    case 13:
      var_1 = "music_mainmenu_cp_perk_11_deadeyedewdrops";
      break;

    case 14:
      var_1 = "music_mainmenu_cp_perk_08_quickies";
      break;

    case 15:
      var_1 = "music_mainmenu_cp_perk_09_mulemunchies";
      break;

    case 16:
      var_1 = "music_mainmenu_cp_perk_10_trailblazers";
      break;

    case 17:
      var_1 = "music_mainmenu_cp_perk_07_bluebolts";
      break;

    case 18:
      var_1 = "music_mainmenu_cp_perk_12_changechews";
      break;

    case 19:
      var_1 = "music_mainmenu_cp_dlc4_boss_battle";
      break;

    case 20:
      var_1 = "music_mainmenu_cp_afterlifearcade";
      break;

    case 21:
      var_1 = "music_mainmenu_cp_ext_lobby";
      break;

    case 22:
      var_1 = "shuffle";
      break;

    default:
      var_1 = "music_mainmenu_cp_main";
      break;
  }

  return var_1;
}

watch_boss_battle() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "boss_set") {
      reset_all_boss_dvars();
      switch (var_1) {
        case 0:
          setdvar("scr_direct_to_grey", 1);
          break;

        case 1:
          setdvar("scr_direct_to_super_slasher", 1);
          break;

        case 2:
          setdvar("scr_direct_to_rat_king", 1);
          break;

        case 3:
          setdvar("scr_direct_to_crab_boss", 1);
          break;

        case 4:
          setdvar("scr_direct_to_rhino_fight", 1);
          break;

        case 5:
          setdvar("scr_direct_to_meph_fight", 1);
          break;
      }
    }
  }
}

reset_all_boss_dvars() {
  setdvar("scr_direct_to_grey", 0);
  setdvar("scr_direct_to_super_slasher", 0);
  setdvar("scr_direct_to_rat_king", 0);
  setdvar("scr_direct_to_crab_boss", 0);
  setdvar("scr_direct_to_rhino_fight", 0);
  setdvar("scr_direct_to_meph_fight", 0);
}

watch_reset_boss_battle() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0);
    if(var_0 == "boss_reset") {
      setdvar("scr_direct_to_grey", 0);
      setdvar("scr_direct_to_super_slasher", 0);
      setdvar("scr_direct_to_rat_king", 0);
      setdvar("scr_direct_to_crab_boss", 0);
      setdvar("scr_direct_to_rhino_fight", 0);
      setdvar("scr_direct_to_meph_fight", 0);
    }
  }
}

func_F41D() {
  func_F522("main_to_online");
  frontendscenecamerafov(85, 0.5);
}

func_6F0C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getent(var_0, "targetname");
  if(var_7 != undefined) {
    for(;;) {
      var_7 setlightintensity(var_1);
      wait(randomfloatrange(var_5, var_6));
      var_7 setlightintensity(var_2);
      wait(randomfloatrange(var_3, var_4));
    }
  }
}

func_10672() {
  var_0 = getent("cashier_zombie_spawn", "targetname");
  var_1 = func_10823(var_0);
  var_1.angles = var_0.angles;
  var_1.origin = var_0.origin;
  var_1.head scriptmodelplayanim("shipcrib_standing_console_idle_17");
  var_1 scriptmodelplayanim("shipcrib_standing_console_idle_17");
}

func_107F1() {
  var_0 = ["body_un_crew_flight_deck_b_director", "body_un_crew_flight_deck_b"];
  var_1 = ["shipcrib_bridge_sitting_officer_idle_01", "shipcrib_bridge_sitting_officer_idle_01"];
  var_2 = getEntArray("sitting_guys", "targetname");
  foreach(var_6, var_4 in var_2) {
    var_5 = func_1067E(var_4);
    var_5.angles = var_4.angles;
    var_5.origin = var_4.origin;
    var_5 thread func_11771(var_6, scripts\engine\utility::random(var_1));
  }
}

func_11771(var_0, var_1) {
  self.head scriptmodelplayanim(var_1);
  self scriptmodelplayanim(var_1);
}

func_51A3(var_0) {
  var_0.head delete();
  if(isDefined(var_0.var_8861)) {
    var_0.var_8861 delete();
  }

  var_0 delete();
}

func_5143(var_0) {
  var_0.head delete();
  if(isDefined(var_0.gun)) {
    var_0.gun delete();
  }

  var_0 delete();
}

func_BDA9(var_0) {
  var_1 = undefined;
  switch (var_0) {
    case 1:
      var_1 = level.var_13F40;
      break;

    case 2:
      var_1 = level.var_13F41;
      break;

    case 3:
      var_1 = level.var_13F42;
      break;
  }

  var_1.origin = (-550, -2010, -5);
  var_1.angles = (0, 0, 0);
  var_2 = func_10823(var_1);
  var_2 scriptmodelclearanim();
  var_2.head scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_" + var_1.var_336, var_1.origin, var_1.angles, 1);
  if(isDefined(var_2.var_8861)) {
    var_2.var_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_" + var_1.var_336, var_1.origin, var_1.angles, 1);
  }

  var_2 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_" + var_1.var_336, var_1.origin, var_1.angles, 1);
  wait(30);
  func_51A3(var_2);
}

func_FEC4() {
  var_0 = "zmb_male_fullbody_outfit_01";
  var_1 = "zmb_male_fullbody_outfit_01";
  var_2 = getent("shooting_01", "targetname");
  var_2.origin = (-550, -2010, -5);
  var_2.angles = (0, 0, 0);
  var_3 = func_10823(var_2);
  var_4 = func_1067E(var_2, 1, "male");
  var_3 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_zom_01", var_2.origin, var_2.angles);
  var_4 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_civ_01", var_2.origin, var_2.angles);
  var_3.head scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_zom_01", var_2.origin, var_2.angles);
  if(isDefined(var_3.var_8861)) {
    var_3.var_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_zom_01", var_2.origin, var_2.angles);
  }

  var_4.head scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_civ_01", var_2.origin, var_2.angles);
  wait(3.5);
  playFXOnTag(level._effect["muzzleflash"], var_4.gun, "tag_flash");
  playFXOnTag(level._effect["shot_impact"], var_3, "j_chest");
  wait(2.5);
  playFXOnTag(level._effect["muzzleflash"], var_4.gun, "tag_flash");
  playFXOnTag(level._effect["shot_impact"], var_3, "j_chest");
  wait(10);
  level thread func_5133(var_3, var_4, 10);
}

func_5133(var_0, var_1, var_2) {
  wait(var_2);
  func_51A3(var_0);
  func_5143(var_1);
}

func_5B17() {
  var_0 = getent("dragging_02", "targetname");
  var_0.origin = (-550, -2010, -5);
  var_0.angles = (0, 0, 0);
  var_1 = func_10823(var_0, "male");
  var_2 = func_1067E(var_0, undefined, "male");
  var_1 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_01", var_0.origin, var_0.angles, 1);
  var_2 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_civ_01", var_0.origin, var_0.angles, 1);
  var_1.head scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_01", var_0.origin, var_0.angles, 1);
  if(isDefined(var_1.var_8861)) {
    var_1.var_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_01", var_0.origin, var_0.angles);
  }

  var_2.head scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_civ_01", var_0.origin, var_0.angles, 1);
  wait(10);
  level thread func_5133(var_1, var_2, 10);
}

func_5B18() {
  var_0 = getent("dragging_01", "targetname");
  var_0.origin = (-550, -2010, -5);
  var_0.angles = (0, 0, 0);
  var_1 = func_10823(var_0, "male");
  var_2 = func_1067E(var_0, undefined, "male");
  var_1 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_02", var_0.origin, var_0.angles, 1);
  if(isDefined(var_1.var_8861)) {
    var_1.var_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_02", var_0.origin, var_0.angles);
  }

  var_2 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_civ_02", var_0.origin, var_0.angles, 1);
  wait(10.5);
  playFX(level._effect["zombie_attack"], var_2 gettagorigin("j_chest"));
  wait(2);
  playFX(level._effect["zombie_attack"], var_2 gettagorigin("j_chest"));
  wait(5);
  level thread func_5133(var_1, var_2, 12);
}

func_1067F() {
  level endon("nuke_runners");
  var_0 = ["shooting", "mugging1", "mugging2", "mugging3", "dragging1", "dragging2"];
  var_1 = ["IW7_cp_frontend_feeding_walk_off_civ", "IW7_cp_frontend_feeding_walk_off_zom", "IW7_cp_frontend_mugging_high_cam_z1_01", "IW7_cp_frontend_mugging_high_cam_z1_02", "IW7_cp_frontend_mugging_high_cam_z2_01"];
  var_2 = randomint(4);
  var_3 = getEntArray("zombie_street_spawners", "targetname");
  for(;;) {
    var_3 = scripts\engine\utility::array_randomize(var_3);
    foreach(var_5 in var_3) {
      var_6 = func_10823(var_5);
      var_6.angles = var_5.angles;
      var_6.origin = var_5.origin;
      var_7 = scripts\engine\utility::random(var_1);
      var_6 thread func_13F52(var_7);
      var_6.var_336 = "zombie";
      wait(randomfloatrange(0.2, 2));
    }

    var_9 = scripts\engine\utility::random(var_0);
    var_0 = scripts\engine\utility::array_remove(var_0, var_9);
    if(var_0.size < 1) {
      var_0 = ["shooting", "mugging1", "mugging2", "mugging3", "dragging1", "dragging2"];
    }

    switch (var_9) {
      case "shooting":
        wait(30);
        func_FEC4();
        break;

      case "mugging1":
        wait(15);
        func_BDA9(1);
        break;

      case "mugging2":
        wait(15);
        func_BDA9(2);
        break;

      case "mugging3":
        wait(15);
        func_BDA9(3);
        break;

      case "dragging1":
        wait(15);
        func_5B17();
        break;

      case "dragging2":
        wait(20);
        func_5B18();
        break;
    }
  }
}

func_13F52(var_0) {
  wait(randomfloatrange(1, 2));
  self.head scriptmodelplayanimdeltamotion(var_0, 1);
  if(isDefined(self.var_8861)) {
    self.var_8861 scriptmodelplayanimdeltamotion(var_0, 1);
  }

  self scriptmodelplayanimdeltamotion(var_0, 1);
  wait(45);
  func_51A3(self);
}

func_37BA(var_0) {
  level notify("camera_position_requested");
  if(var_0.name != "zm_consumable_selection") {
    level notify("stop_fnf_machine");
    if(isDefined(level.var_71A3)) {
      level.var_71A3 delete();
    }
  }

  switch (var_0.name) {
    case "zm_buildkit_selection":
      if(func_A8E7("weapon_select")) {
        thread func_13EFF("weapon_to_buildkit", 250, ::func_F46C);
      } else {
        thread func_13EFF("loadout_to_buildkit", 250, ::func_F46C);
      }
      break;

    case "zm_main":
      if(!isDefined(self.var_A8E6) || func_A8E7("zm_main")) {
        func_F41D();
      } else {
        thread func_BC0F();
      }
      break;

    case "zm_play_online":
      if(func_A8E7("zm_main") || func_A8E7("barracks_menu") || func_A8E7("loadout_menu")) {
        thread func_13EFF("main_to_online", undefined, ::func_BC8F);
      }
      break;

    case "zm_map_selection":
      if(func_A8E7("zm_main")) {
        level.var_B329 = 1;
        frontendscenecamerafov(65, 0.05);
        thread func_13EFF("main_to_online", undefined, ::func_F47A);
      } else {
        level.var_B329 = 1;
        func_F47A();
      }
      break;

    case "map_select_0":
      if(func_A8E7("zm_main")) {
        level.var_B329 = 1;
        frontendscenecamerafov(65, 0.3);
        thread func_13EFF("main_to_online", undefined, ::func_F47A);
      } else {
        frontendscenecamerafov(65, 0.3);
        level.var_B329 = 1;
        func_F47A(0);
      }
      break;

    case "map_select_1":
      level.var_B329 = 0;
      func_F47A(1);
      break;

    case "map_select_2":
      level.var_B329 = 0;
      func_F47A(2);
      break;

    case "map_select_3":
      level.var_B329 = 0;
      func_F47A(3);
      break;

    case "map_select_4":
      level.var_B329 = 0;
      func_F47A(4);
      break;

    case "zm_consumable_selection":
      level thread func_71A4();
      if(func_A8E7("loadout_menu") && !isDefined(self.var_AE3A)) {
        self.var_AE3A = 1;
        thread func_13EFF("player_card_cam", 250);
      } else if(func_A8E7("zm_consumable_selection")) {
        func_F522("player_card_cam_static");
      } else {
        thread func_13EFF("player_card_cam", 250);
        thread fadeinfrontendcamera();
      }
      break;

    case "zm_lobby":
      level thread func_CDA4(0.1);
      if(func_A8E7("zm_main")) {
        frontendscenecamerafov(85, 1);
        thread func_13EFF("main_to_online", undefined, ::func_BC8F);
      } else if(func_A8E7("zm_map_selection")) {
        frontendscenecamerafade(0, 0.2);
        wait(0.25);
        frontendscenecamerafov(85, 0.05);
        func_F522("zm_lobby_cam");
      } else {
        frontendscenecamerafade(0, 0.2);
        wait(0.25);
        frontendscenecamerafov(85, 1);
        func_F522("zm_lobby_cam");
      }

      fadeinfrontendcameraendontransition();
      break;

    case "weapon_select":
      if(isDefined(self.var_A8E6) && self.var_A8E6 == "zm_buildkit_selection") {
        thread func_13EFF("buildkit_to_weaponselect", 250, ::func_F619);
      } else {
        thread func_F61A();
        thread fadeinfrontendcamera();
      }
      break;

    case "loadout_menu":
      if(func_A8E7("zm_main")) {
        thread func_13EFF("main_to_online", undefined, ::func_F46B);
      } else if(func_A8E7("loadout_menu")) {
        func_F522("player_loadout_cam");
      } else if(func_A8E7("zm_consumable_selection")) {
        thread func_13EFF("consumable_to_loadout", 250);
      } else if(func_A8E7("zm_buildkit_selection")) {
        func_F46C();
      } else {
        thread func_F46B();
      }
      break;

    case "weapon_painter_select":
      break;

    case "zm_survival_depot":
    case "barracks_menu":
      if(func_A8E7("zm_main")) {
        frontendscenecamerafov(65, 2);
        thread func_13EFF("main_to_online", undefined, ::func_F2D6);
      } else {
        func_F2D6();
      }

      thread fadeinfrontendcamera();
      break;

    default:
      func_F41D();
      break;
  }

  self.var_A8E6 = var_0.name;
}

fadeinfrontendcameraendontransition() {
  level endon("camera_position_requested");
  wait(0.2);
  frontendscenecamerafade(1, 0.25);
}

fadeinfrontendcamera() {
  level endon("camera_position_requested");
  wait(0.2);
  frontendscenecamerafade(1, 0.25);
}

fadeoutfrontendcamera() {
  frontendscenecamerafade(0, 0.2);
  wait(0.25);
}

zm_map_select_watcher() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = getent("map_select_poster", "targetname");
  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);
    if(var_1 == "soulKey" && var_2 > 0) {
      level thread show_soul_key(var_2);
      continue;
    }

    if(var_1 == "cp_zmb" || var_1 == "cp_rave" || var_1 == "cp_disco" || var_1 == "cp_town" || var_1 == "cp_final") {
      switch (var_1) {
        case "cp_zmb":
          var_0 setModel("zmb_poster_spaceland");
          break;

        case "cp_rave":
          var_0 setModel("zmb_poster_dlc1");
          break;

        case "cp_disco":
          var_0 setModel("zmb_poster_dlc2");
          break;

        case "cp_town":
          var_0 setModel("zmb_poster_dlc3");
          break;

        case "cp_final":
          var_0 setModel("zmb_poster_dlc4");
          break;
      }
    }

    if(var_1 == "map_select") {
      switch (var_2) {
        case 0:
          var_0 setModel("zmb_poster_spaceland");
          break;

        case 1:
          var_0 setModel("zmb_poster_dlc1");
          break;

        case 2:
          var_0 setModel("zmb_poster_dlc2");
          break;

        case 3:
          var_0 setModel("zmb_poster_dlc3");
          break;

        case 4:
          var_0 setModel("zmb_poster_dlc4");
          break;

        case 5:
          var_0 setModel("zmb_poster_spaceland");
          break;

        case 6:
          var_0 setModel("zmb_poster_dlc1");
          break;

        case 7:
          var_0 setModel("zmb_poster_dlc2");
          break;

        case 8:
          var_0 setModel("zmb_poster_dlc3");
          break;

        case 10:
        case 9:
          var_0 setModel("zmb_poster_dlc4");
          break;
      }
    }
  }
}

show_soul_key(var_0) {
  var_1 = int(var_0 / 16);
  var_2 = var_0 - var_1 * 16;
  var_3 = int(var_2 / 8);
  var_2 = var_2 - var_3 * 8;
  var_4 = int(var_2 / 4);
  var_2 = var_2 - var_4 * 4;
  var_5 = int(var_2 / 2);
  var_2 = var_2 - var_5 * 2;
  var_6 = int(var_2 / 1);
  var_2 = var_2 - var_6 * 1;
  if(var_6 == 1 && !level.has_soul_key_1) {
    level.has_soul_key_1 = 1;
    triggerfx(level.soul_key_1_fx);
  }

  if(var_5 == 1 && !level.has_soul_key_2) {
    level.has_soul_key_2 = 1;
    triggerfx(level.soul_key_2_fx);
  }

  if(var_4 == 1 && !level.has_soul_key_3) {
    level.has_soul_key_3 = 1;
    triggerfx(level.soul_key_3_fx);
  }

  if(var_3 == 1 && !level.has_soul_key_4) {
    level.has_soul_key_4 = 1;
    triggerfx(level.soul_key_4_fx);
  }

  if(var_1 == 1 && !level.has_soul_key_5) {
    level.has_soul_key_5 = 1;
    triggerfx(level.soul_key_5_fx);
  }
}

func_13EFE() {
  level endon("game_ended");
  self endon("disconnect");
  self cameralinkto(level.camera_anchor, "tag_origin");
  func_F41D();
  level.active_section = frontendscenegetactivesection();
  func_37BA(level.active_section);
  scripts\engine\utility::waitframe();
  for(;;) {
    var_0 = frontendscenegetactivesection();
    if(var_0.name == level.active_section.name && var_0.index == level.active_section.index) {
      scripts\engine\utility::waitframe();
      continue;
    }

    level.active_section = var_0;
    func_37BA(var_0);
  }
}

func_13EFF(var_0, var_1, var_2, var_3) {
  level endon("camera_position_requested");
  var_4 = getent(var_0, "targetname");
  scripts\cp_mp\frontendutils::frontend_camera_move(var_4, var_1, 1, 0, var_2);
}

main() {
  setdvar("r_umbraMinObjectContribution", 10);
  scripts\mp\maps\mp_frontend\mp_frontend_precache_cp::main();
  scripts\cp\maps\cp_frontend\cp_frontend_precache::main();
  scripts\cp\maps\cp_frontend\gen\cp_frontend_art::main();
  scripts\cp\maps\cp_frontend\cp_frontend_fx::main();
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  level.callbackplayerconnect = ::func_375B;
  update_theater_signs();
  scripts\cp_mp\frontendutils::frontend_camera_setup((0, 0, 0), (0, 0, 0));
  level setup_interact();
  level.power_setup_init = ::blank;
  setup_fnf_machine();
  sysprint("MatchStarted: Completed");
}

update_theater_signs() {
  var_0 = getent("front_marquee_sign", "targetname");
  var_0 setModel("cp_final_fe_theater_beast_from_beyond");
  var_1 = getEntArray("frontend_poster", "targetname");
  foreach(var_3 in var_1) {
    var_3 setModel("zmb_poster_dlc4");
  }
}

setup_fnf_machine() {
  var_0 = getent("fnf_jaw", "targetname");
  var_1 = getent("fnf_machine", "targetname");
  if(should_use_alt_machine()) {
    var_1 setscriptablepartstate("teller", "default_on");
    var_0 setModel("zmb_fortune_teller_machine_jaw_02");
    return;
  }

  var_0 setModel("zmb_fortune_teller_machine_jaw_01");
  var_1 setscriptablepartstate("teller", "safe_on");
}

func_F522(var_0) {
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = getent(var_0, "targetname").origin;
  level.camera_anchor.angles = getent(var_0, "targetname").angles;
}

func_A8E7(var_0) {
  return !isDefined(self.var_A8E6) || self.var_A8E6 == "" || self.var_A8E6 == var_0;
}

blank() {}

init_soul_key() {
  self endon("disconnect");
  level.soul_key_1_fx = spawnfx(level._effect["vfx_zb_pack_grd_a"], (-43, -313, 218), anglesToForward((180, 180, -90)), anglestoup((180, 180, -90)));
  level.soul_key_2_fx = spawnfx(level._effect["vfx_zb_pack_grd_e"], (-40, -313, 232), anglesToForward((180, 180, -90)), anglestoup((180, 180, -90)));
  level.soul_key_3_fx = spawnfx(level._effect["vfx_zb_pack_grd_d"], (-25, -313, 238), anglesToForward((180, 180, -90)), anglestoup((180, 180, -90)));
  level.soul_key_4_fx = spawnfx(level._effect["vfx_zb_pack_grd_b"], (-11, -313, 232), anglesToForward((180, 180, -90)), anglestoup((180, 180, -90)));
  level.soul_key_5_fx = spawnfx(level._effect["vfx_zb_pack_grd_c"], (-8, -313, 218), anglesToForward((180, 180, -90)), anglestoup((180, 180, -90)));
  level.has_soul_key_1 = 0;
  level.has_soul_key_2 = 0;
  level.has_soul_key_3 = 0;
  level.has_soul_key_4 = 0;
  level.has_soul_key_5 = 0;
}