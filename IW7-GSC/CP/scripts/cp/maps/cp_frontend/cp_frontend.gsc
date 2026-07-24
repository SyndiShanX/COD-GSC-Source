/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_frontend\cp_frontend.gsc
*******************************************************/

_id_CDA4(var_0) {
  wait(var_0);
  frontendscenecameracinematic("zombies_lobby_candy");
}

_id_1067E(var_0, var_1, var_2) {
  var_3 = randomint(100) > 50;

  if(isDefined(var_2) && var_2 == "male")
    var_3 = 1;
  else if(isDefined(var_2) && var_2 == "female")
    var_3 = 0;

  if(var_3) {
    var_4 = scripts\engine\utility::random(level._id_3FA3);
    var_5 = scripts\engine\utility::random(level._id_3FA4);
  } else {
    var_4 = scripts\engine\utility::random(level._id_3F9A);
    var_5 = scripts\engine\utility::random(level._id_3F9B);
  }

  var_6 = spawn("script_model", (0, 0, 0));
  var_6.angles = var_0.angles;
  var_6 setModel(var_4);
  var_6.head = spawn("script_model", var_6 gettagorigin("j_spine4"));
  var_6.head.angles = var_6 gettagangles("j_spine4");
  var_6.head setModel(var_5);
  var_6.head linkTo(var_6, "j_spine4");

  if(isDefined(var_1)) {
    var_6.gun = spawn("script_model", var_6 gettagorigin("tag_weapon_left"));
    var_6.gun.angles = var_6 gettagangles("tag_weapon_left");
    var_6.gun setModel("weapon_revolver_wm");
    var_6.gun linkTo(var_6, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  }

  return var_6;
}

_id_10823(var_0, var_1) {
  var_2 = randomint(100) > 50;

  if(isDefined(var_1) && var_1 == "male")
    var_2 = 1;
  else if(isDefined(var_1) && var_1 == "female")
    var_2 = 0;

  if(var_2) {
    var_3 = scripts\engine\utility::random(level._id_13F3B);
    var_4 = scripts\engine\utility::random(level._id_13F3D);

    if(randomint(100) > 70)
      var_5 = undefined;
    else
      var_5 = scripts\engine\utility::random(level._id_13F3C);
  } else {
    var_3 = scripts\engine\utility::random(level._id_13F21);
    var_4 = scripts\engine\utility::random(level._id_13F23);

    if(randomint(100) > 70)
      var_5 = undefined;
    else
      var_5 = scripts\engine\utility::random(level._id_13F22);
  }

  var_6 = spawn("script_model", (0, 0, 0));
  var_6.angles = var_0.angles;
  var_6 setModel(var_3);
  var_6.head = spawn("script_model", var_6 gettagorigin("j_spine4"));
  var_6.head.angles = var_6 gettagangles("j_spine4");
  var_6.head setModel(var_4);

  if(isDefined(var_5)) {
    if(var_2)
      var_7 = "j_spine4";
    else
      var_7 = "j_neck";

    var_6._id_8861 = spawn("script_model", var_6.head gettagorigin(var_7));
    var_6._id_8861.angles = var_6.head gettagangles(var_7);
    var_6._id_8861 setModel(var_5);
    var_6._id_8861 linkTo(var_6.head, var_7);
  }

  var_6.head linkTo(var_6, "j_spine4");
  wait 1;
  playFXOnTag(level._effect["yellow_eye_glow"], var_6.head, "j_eyeball_ri");
  playFXOnTag(level._effect["yellow_eye_glow"], var_6.head, "j_eyeball_le");
  return var_6;
}

setup_interact() {
  level._id_13F40 = getEnt("mugging_01", "targetname");
  level._id_13F41 = getEnt("mugging_02", "targetname");
  level._id_13F42 = getEnt("mugging_03", "targetname");
  _id_F9DC();
  level thread _id_107F1();
  wait 0.05;
  level thread _id_CDA4(2);
  wait 0.05;
  level thread _id_10672();
  wait 0.05;
  level thread _id_1067F();
  wait 1;
  var_0 = getEnt("pap_machine", "targetname");
  var_0 setscriptablepartstate("machine", "upgraded");
  var_0 setscriptablepartstate("reels", "on_frontend");
  wait 1;
  var_0 setscriptablepartstate("door", "close");
  wait 1;
  var_0 setscriptablepartstate("door", "open_idle");
  playFX(level._effect["vfx_zb_sj_smk"], (-26, -330, 225), anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
}

_id_F9DC() {
  level._id_3FA3 = ["c_civ_zur_male_body1_3", "c_civ_zur_male_body2_4"];
  level._id_3F9A = ["c_civ_zur_female_body5_3", "c_civ_zur_female_body4_1"];
  level._id_3F9B = ["head_female_bc_01", "head_female_bc_02"];
  level._id_3FA4 = ["head_bg_var_head_male_bc_02_head_male_bc_05", "head_bg_var_head_male_bc_02_head_male_bc_07"];
  level._id_13F3B = ["zmb_male_fullbody_outfit_03_3", "zmb_male_fullbody_outfit_01", "zmb_male_fullbody_outfit_02_2"];
  level._id_13F21 = ["zmb_female_fullbody_outfit_05", "zmb_female_fullbody_outfit_03_3", "zmb_female_fullbody_outfit_04"];
  level._id_13F3D = ["zmb_male_head_01"];
  level._id_13F23 = ["zmb_female_head_01", "zmb_female_head_02"];
  level._id_13F3C = [];
  level._id_13F22 = ["zmb_female_head_01_hair_boatswaine_blonde", "zmb_female_head_01_hair_boatswaine"];
}

_id_4EA7() {
  for(;;) {
    if(getDvar("scr_zombie_scene") != "") {
      switch (getDvar("scr_zombie_scene")) {
        case "mug_1":
          level thread _id_BDA9(1);
          setDvar("scr_zombie_scene", "");
          break;
        case "mug_2":
          level thread _id_BDA9(2);
          setDvar("scr_zombie_scene", "");
          break;
        case "mug_3":
          level thread _id_BDA9(3);
          setDvar("scr_zombie_scene", "");
          break;
        case "shoot_1":
          level thread _id_FEC4();
          setDvar("scr_zombie_scene", "");
          break;
        case "drag_1":
          level thread _id_5B17();
          setDvar("scr_zombie_scene", "");
          break;
        case "drag_2":
          level thread _id_5B18();
          setDvar("scr_zombie_scene", "");
          break;
      }
    }

    wait 1;
  }
}

_id_71A4() {
  level endon("stop_fnf_machine");

  if(!isDefined(level._id_71A3))
    level._id_71A3 = spawnfx(level._effect["fnfeyes"], (1881, 176, -942), anglesToForward((0, -90, 0)), anglestoup((0, -90, 0)));

  wait 0.1;
  triggerfx(level._id_71A3);
  var_0 = getEnt("fnf_jaw", "targetname");

  for(;;) {
    wait(randomintrange(1, 3));
    var_0 movez(-1, 0.2);
    var_0 waittill("movedone");
    var_0 movez(1, 0.2);
    var_0 waittill("movedone");
  }
}

should_use_alt_machine() {
  if(getdvarint("loc_language") == 15 || getdvarint("loc_language") == 1)
    return 1;

  return 0;
}

_id_F47A(var_0) {
  if(!isDefined(var_0))
    var_1 = "map_select_0";
  else
    var_1 = "map_select_" + var_0;

  var_2 = getEnt(var_1, "targetname").origin;
  var_3 = getEnt(var_1, "targetname").angles;
  var_4 = scripts\engine\utility::is_true(level._id_B329);

  if(var_4) {
    frontendscenecamerafade(0, 0.2);
    wait 0.25;
  }

  level.camera_anchor.origin = var_2;
  level.camera_anchor.angles = var_3;

  if(var_4) {
    wait 0.1;
    frontendscenecamerafade(1, 0.2);
  }
}

_id_F2D6() {
  frontendscenecamerafade(0, 0.2);
  wait 0.25;
  self setdepthoffield(0.1, 0.2, 30, 5000, 4, 1.8);
  _id_F522("barracks_cam");
  wait 0.1;
  frontendscenecamerafade(1, 0.2);
}

_id_F46B() {
  if(isDefined(level.weapon))
    level.weapon delete();

  frontendscenecamerafade(0, 0.2);
  wait 0.25;
  self setdepthoffield(0.1, 0.2, 30, 5000, 4, 1.8);
  _id_F522("player_loadout_cam");
  frontendscenecamerafov(85);
  wait 0.1;
  frontendscenecamerafade(1, 0.2);
}

_id_F46C() {
  self setdepthoffield(0.1, 0.2, 30, 5000, 4, 1.8);
  _id_F522("player_loadout_cam");
  frontendscenecamerafov(85);
}

_id_F61A() {
  level.weapon = spawn("script_weapon", getEnt("weapon_loc", "targetname").origin, 0, 0, 0);
  level.weapon.angles = getEnt("weapon_loc", "targetname").angles;
  frontendscenecamerafov(65);
  _id_F522("player_weapon_cam");
  self setdepthoffield(0, 25, 50, 100, 10, 8);
}

_id_F619() {
  var_0 = getEnt("gun_light", "targetname");
  var_0 setlightintensity(10);
  frontendscenecamerafov(65);
  self setdepthoffield(0, 15, 50, 80, 10, 8);
}

_id_F46A() {
  self setdepthoffield(0.1, 0.2, 30, 5000, 4, 1.8);
  frontendscenecamerafov(85);
}

_id_BC0F() {
  frontendscenecameracinematic("");
  frontendscenecamerafade(0, 0.2);
  wait 0.25;
  thread _id_13EFF("back_to_main_view", undefined, ::_id_F41D);
  self setdepthoffield(0.1, 0.2, 30, 5000, 4, 1.8);
  wait 0.1;
  frontendscenecamerafade(1, 0.2);
}

_id_BC8F() {
  frontendscenecamerafade(0, 0.2);
  wait 0.25;
  thread _id_13EFF("lobby");
  wait 0.1;
  frontendscenecamerafade(1, 0.2);
}

_id_C573() {
  if(isDefined(level._id_D372)) {
    return;
  }
  level._id_D372 = 1;
}

_id_375B() {
  _id_C573();
  level.playerviewowner = self;
  _id_F41D();
  thread scripts\cp_mp\frontendutils::frontend_camera_watcher(::_id_37BA);
  thread zm_map_select_watcher();
}

_id_F41D() {
  _id_F522("main_to_online");
  frontendscenecamerafov(85, 0.5);
}

_id_6F0C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getEnt(var_0, "targetname");

  if(var_7 != undefined) {
    for(;;) {
      var_7 setlightintensity(var_1);
      wait(randomfloatrange(var_5, var_6));
      var_7 setlightintensity(var_2);
      wait(randomfloatrange(var_3, var_4));
    }
  }
}

_id_10672() {
  var_0 = getEnt("cashier_zombie_spawn", "targetname");
  var_1 = _id_10823(var_0);
  var_1.angles = var_0.angles;
  var_1.origin = var_0.origin;
  var_1.head scriptmodelplayanim("shipcrib_standing_console_idle_17");
  var_1 scriptmodelplayanim("shipcrib_standing_console_idle_17");
}

_id_107F1() {
  var_0 = ["body_un_crew_flight_deck_b_director", "body_un_crew_flight_deck_b"];
  var_1 = ["shipcrib_bridge_sitting_officer_idle_01", "shipcrib_bridge_sitting_officer_idle_01"];
  var_2 = getEntArray("sitting_guys", "targetname");

  foreach(var_6, var_4 in var_2) {
    var_5 = _id_1067E(var_4);
    var_5.angles = var_4.angles;
    var_5.origin = var_4.origin;
    var_5 thread _id_11771(var_6, scripts\engine\utility::random(var_1));
  }
}

_id_11771(var_0, var_1) {
  self.head scriptmodelplayanim(var_1);
  self scriptmodelplayanim(var_1);
}

_id_51A3(var_0) {
  var_0.head delete();

  if(isDefined(var_0._id_8861))
    var_0._id_8861 delete();

  var_0 delete();
}

_id_5143(var_0) {
  var_0.head delete();

  if(isDefined(var_0.gun))
    var_0.gun delete();

  var_0 delete();
}

_id_BDA9(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 1:
      var_1 = level._id_13F40;
      break;
    case 2:
      var_1 = level._id_13F41;
      break;
    case 3:
      var_1 = level._id_13F42;
      break;
  }

  var_1.origin = (-550, -2010, -5);
  var_1.angles = (0, 0, 0);
  var_2 = _id_10823(var_1);
  var_2 scriptmodelclearanim();
  var_2.head scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_" + var_1.targetname, var_1.origin, var_1.angles, 1);

  if(isDefined(var_2._id_8861))
    var_2._id_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_" + var_1.targetname, var_1.origin, var_1.angles, 1);

  var_2 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_" + var_1.targetname, var_1.origin, var_1.angles, 1);
  wait 30;
  _id_51A3(var_2);
}

_id_FEC4() {
  var_0 = "zmb_male_fullbody_outfit_01";
  var_1 = "zmb_male_fullbody_outfit_01";
  var_2 = getEnt("shooting_01", "targetname");
  var_2.origin = (-550, -2010, -5);
  var_2.angles = (0, 0, 0);
  var_3 = _id_10823(var_2);
  var_4 = _id_1067E(var_2, 1, "male");
  var_3 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_zom_01", var_2.origin, var_2.angles);
  var_4 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_civ_01", var_2.origin, var_2.angles);
  var_3.head scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_zom_01", var_2.origin, var_2.angles);

  if(isDefined(var_3._id_8861))
    var_3._id_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_zom_01", var_2.origin, var_2.angles);

  var_4.head scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_shoot_civ_01", var_2.origin, var_2.angles);
  wait 3.5;
  playFXOnTag(level._effect["muzzleflash"], var_4.gun, "tag_flash");
  playFXOnTag(level._effect["shot_impact"], var_3, "j_chest");
  wait 2.5;
  playFXOnTag(level._effect["muzzleflash"], var_4.gun, "tag_flash");
  playFXOnTag(level._effect["shot_impact"], var_3, "j_chest");
  wait 10;
  level thread _id_5133(var_3, var_4, 10);
}

_id_5133(var_0, var_1, var_2) {
  wait(var_2);
  _id_51A3(var_0);
  _id_5143(var_1);
}

_id_5B17() {
  var_0 = getEnt("dragging_02", "targetname");
  var_0.origin = (-550, -2010, -5);
  var_0.angles = (0, 0, 0);
  var_1 = _id_10823(var_0, "male");
  var_2 = _id_1067E(var_0, undefined, "male");
  var_1 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_01", var_0.origin, var_0.angles, 1);
  var_2 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_civ_01", var_0.origin, var_0.angles, 1);
  var_1.head scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_01", var_0.origin, var_0.angles, 1);

  if(isDefined(var_1._id_8861))
    var_1._id_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_01", var_0.origin, var_0.angles);

  var_2.head scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_civ_01", var_0.origin, var_0.angles, 1);
  wait 10;
  level thread _id_5133(var_1, var_2, 10);
}

_id_5B18() {
  var_0 = getEnt("dragging_01", "targetname");
  var_0.origin = (-550, -2010, -5);
  var_0.angles = (0, 0, 0);
  var_1 = _id_10823(var_0, "male");
  var_2 = _id_1067E(var_0, undefined, "male");
  var_1 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_02", var_0.origin, var_0.angles, 1);

  if(isDefined(var_1._id_8861))
    var_1._id_8861 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_zom_02", var_0.origin, var_0.angles);

  var_2 scriptmodelplayanimdeltamotionfrompos("IW7_cp_frontend_dragging_civ_02", var_0.origin, var_0.angles, 1);
  wait 10.5;
  playFX(level._effect["zombie_attack"], var_2 gettagorigin("j_chest"));
  wait 2;
  playFX(level._effect["zombie_attack"], var_2 gettagorigin("j_chest"));
  wait 5;
  level thread _id_5133(var_1, var_2, 12);
}

_id_1067F() {
  level endon("nuke_runners");
  var_0 = ["shooting", "mugging1", "mugging2", "mugging3", "dragging1", "dragging2"];
  var_1 = ["IW7_cp_frontend_feeding_walk_off_civ", "IW7_cp_frontend_feeding_walk_off_zom", "IW7_cp_frontend_mugging_high_cam_z1_01", "IW7_cp_frontend_mugging_high_cam_z1_02", "IW7_cp_frontend_mugging_high_cam_z2_01"];
  var_2 = randomint(4);
  var_3 = getEntArray("zombie_street_spawners", "targetname");

  for(;;) {
    var_3 = scripts\engine\utility::array_randomize(var_3);

    foreach(var_5 in var_3) {
      var_6 = _id_10823(var_5);
      var_6.angles = var_5.angles;
      var_6.origin = var_5.origin;
      var_7 = scripts\engine\utility::random(var_1);
      var_6 thread _id_13F52(var_7);
      var_6.targetname = "zombie";
      wait(randomfloatrange(0.2, 2));
    }

    var_9 = scripts\engine\utility::random(var_0);
    var_0 = scripts\engine\utility::array_remove(var_0, var_9);

    if(var_0.size < 1)
      var_0 = ["shooting", "mugging1", "mugging2", "mugging3", "dragging1", "dragging2"];

    switch (var_9) {
      case "shooting":
        wait 30;
        _id_FEC4();
        break;
      case "mugging1":
        wait 15;
        _id_BDA9(1);
        break;
      case "mugging2":
        wait 15;
        _id_BDA9(2);
        break;
      case "mugging3":
        wait 15;
        _id_BDA9(3);
        break;
      case "dragging1":
        wait 15;
        _id_5B17();
        break;
      case "dragging2":
        wait 20;
        _id_5B18();
        break;
    }
  }
}

_id_13F52(var_0) {
  wait(randomfloatrange(1, 2));
  self.head scriptmodelplayanimdeltamotion(var_0, 1);

  if(isDefined(self._id_8861))
    self._id_8861 scriptmodelplayanimdeltamotion(var_0, 1);

  self scriptmodelplayanimdeltamotion(var_0, 1);
  wait 45;
  _id_51A3(self);
}

_id_37BA(var_0) {
  if(var_0.name != "zm_consumable_selection") {
    level notify("stop_fnf_machine");

    if(isDefined(level._id_71A3))
      level._id_71A3 delete();
  }

  switch (var_0.name) {
    case "zm_buildkit_selection":
      if(_id_A8E7("weapon_select"))
        thread _id_13EFF("weapon_to_buildkit", 250, ::_id_F46C);
      else
        thread _id_13EFF("loadout_to_buildkit", 250, ::_id_F46C);

      break;
    case "zm_main":
      if(!isDefined(self._id_A8E6) || _id_A8E7("zm_main"))
        _id_F41D();
      else
        thread _id_BC0F();

      break;
    case "zm_play_online":
      if(_id_A8E7("zm_main") || _id_A8E7("barracks_menu") || _id_A8E7("loadout_menu"))
        thread _id_13EFF("main_to_online", undefined, ::_id_BC8F);

      break;
    case "zm_map_selection":
      if(_id_A8E7("zm_main")) {
        frontendscenecamerafov(65, 0.05);
        thread _id_13EFF("main_to_online", undefined, ::_id_F47A);
      } else {
        frontendscenecamerafov(65, 0.05);
        _id_F47A();
      }

      break;
    case "map_select_0":
      if(_id_A8E7("zm_main")) {
        level._id_B329 = 1;
        frontendscenecamerafov(65, 0.3);
        thread _id_13EFF("main_to_online", undefined, ::_id_F47A);
      } else {
        frontendscenecamerafov(65, 0.3);
        level._id_B329 = 1;
        _id_F47A(0);
      }

      break;
    case "map_select_1":
      level._id_B329 = 0;
      _id_F47A(1);
      break;
    case "map_select_2":
      level._id_B329 = 0;
      _id_F47A(2);
      break;
    case "map_select_3":
      level._id_B329 = 0;
      _id_F47A(3);
      break;
    case "map_select_4":
      level._id_B329 = 0;
      _id_F47A(4);
      break;
    case "zm_consumable_selection":
      level thread _id_71A4();

      if(_id_A8E7("loadout_menu") && !isDefined(self._id_AE3A)) {
        self._id_AE3A = 1;
        thread _id_13EFF("player_card_cam", 250);
      } else if(_id_A8E7("zm_consumable_selection"))
        _id_F522("player_card_cam_static");
      else
        thread _id_13EFF("player_card_cam", 250);

      break;
    case "zm_lobby":
      level thread _id_CDA4(0.1);
      frontendscenecamerafade(0, 0.2);
      wait 0.25;

      if(_id_A8E7("zm_main")) {
        frontendscenecamerafov(85, 1);
        thread _id_13EFF("main_to_online", undefined, ::_id_BC8F);
      } else if(_id_A8E7("zm_map_selection")) {
        frontendscenecamerafov(85, 0.05);
        _id_F522("zm_lobby_cam");
      } else {
        frontendscenecamerafov(85, 1);
        _id_F522("zm_lobby_cam");
      }

      wait 0.1;
      frontendscenecamerafade(1, 0.2);
      break;
    case "weapon_select":
      if(_id_A8E7("zm_buildkit_selection"))
        thread _id_13EFF("buildkit_to_weaponselect", 250, ::_id_F619);
      else
        thread _id_F61A();

      break;
    case "loadout_menu":
      if(_id_A8E7("zm_main"))
        thread _id_13EFF("main_to_online", undefined, ::_id_F46B);
      else if(_id_A8E7("loadout_menu"))
        _id_F522("player_loadout_cam");
      else if(_id_A8E7("zm_consumable_selection"))
        thread _id_13EFF("consumable_to_loadout", 250);
      else if(_id_A8E7("zm_buildkit_selection"))
        _id_F46C();
      else
        thread _id_F46B();

      break;
    case "barracks_menu":
      if(_id_A8E7("zm_main")) {
        frontendscenecamerafov(65, 2);
        thread _id_13EFF("main_to_online", undefined, ::_id_F2D6);
      } else
        _id_F522("barracks_cam");

      break;
    default:
      _id_F41D();
      break;
  }

  self._id_A8E6 = var_0.name;
}

zm_map_select_watcher() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = getEnt("map_select_poster", "targetname");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "map_select") {
      continue;
    }
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
    }
  }
}

_id_13EFE() {
  level endon("game_ended");
  self endon("disconnect");
  self cameralinkTo(level.camera_anchor, "tag_origin");
  _id_F41D();
  level.active_section = frontendscenegetactivesection();
  _id_37BA(level.active_section);
  scripts\engine\utility::waitframe();

  for(;;) {
    var_0 = frontendscenegetactivesection();

    if(var_0.name == level.active_section.name && var_0.index == level.active_section.index) {
      scripts\engine\utility::waitframe();
      continue;
    }

    level.active_section = var_0;
    _id_37BA(var_0);
  }
}

_id_13EFF(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");
  scripts\cp_mp\frontendutils::frontend_camera_move(var_4, var_1, 1, 0, var_2);
}

main() {
  setDvar("r_umbraMinObjectContribution", 10);
  scripts\mp\maps\mp_frontend\mp_frontend_precache_cp::main();
  scripts\cp\maps\cp_frontend\cp_frontend_precache::main();
  scripts\cp\maps\cp_frontend\gen\cp_frontend_art::main();
  scripts\cp\maps\cp_frontend\cp_frontend_fx::main();
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  level.callbackplayerconnect = ::_id_375B;
  scripts\cp_mp\frontendutils::frontend_camera_setup((0, 0, 0), (0, 0, 0));
  level setup_interact();
  level.power_setup_init = ::blank;
  setup_fnf_machine();
  sysprint("MatchStarted: Completed");
}

setup_fnf_machine() {
  var_0 = getEnt("fnf_jaw", "targetname");

  if(should_use_alt_machine()) {
    var_1 = getEnt("fnf_machine", "targetname");
    var_1 setscriptablepartstate("teller", "safe_on");
    var_0 setModel("zmb_fortune_teller_machine_jaw_01");
  }
}

_id_F522(var_0) {
  level.camera_anchor.origin = getEnt(var_0, "targetname").origin;
  level.camera_anchor.angles = getEnt(var_0, "targetname").angles;
}

_id_A8E7(var_0) {
  return !isDefined(self._id_A8E6) || self._id_A8E6 == "" || self._id_A8E6 == var_0;
}

blank() {}