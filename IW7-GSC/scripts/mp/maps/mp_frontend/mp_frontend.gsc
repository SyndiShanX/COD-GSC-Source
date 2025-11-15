/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_frontend\mp_frontend.gsc
*******************************************************/

func_C573() {
  level endon("game_ended");
  self endon("disconnect");
  if(!isDefined(level.console)) {
    level.console = getdvar("consoleGame") == "true";
  }

  level.playerviewowner = self;
  if(isDefined(level.var_D372)) {
    return;
  }

  level.var_D372 = 1;
  wait(0.5);
}

callback_frontendplayerconnect() {
  thread func_C573();
  thread scripts\cp_mp\frontendutils::frontend_camera_watcher(::func_37BA);
  thread epictauntlistener();
  level thread camolistener();
}

coming_from_rig_select() {
  if(!isDefined(level.var_4C01)) {
    return 0;
  }

  return level.var_4C01 == "rig_select" || level.var_4C01 == "rig_pick" || level.var_4C01 == "rig_trait_select" || level.var_4C01 == "rig_head_select" || level.var_4C01 == "rig_taunt_select";
}

ishost(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case 0:
      var_01 = level.var_37AA;
      break;

    case 1:
      var_01 = level.var_37AC;
      break;

    case 2:
      var_01 = level.var_37AE;
      break;

    case 3:
      var_01 = level.var_37AD;
      break;

    case 4:
      var_01 = level.var_37AF;
      break;

    default:
      var_01 = level.var_37B5;
      break;
  }

  return var_01;
}

get_camera_data_by_rig_scene(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "rig_select":
      var_01 = level.var_37B7;
      break;

    case "rig_pick":
      var_01 = level.var_37B8;
      break;

    case "rig_trait_select":
      var_01 = level.var_37B9;
      break;

    case "rig_head_select":
      var_01 = level.camera_rig_head;
      break;

    case "rig_taunt_select":
      var_01 = level.camera_rig_taunt;
      break;

    default:
      var_01 = level.var_37B7;
      break;
  }

  return var_01;
}

func_788A(param_00, param_01) {
  switch (param_01) {
    case "create_a_class":
      return param_00.var_369A;

    case "weapon_select":
      return param_00.var_13C7B;

    case "loadout_select":
      return param_00.var_AE63;

    case "rig_select":
      return param_00.var_E510;

    case "barracks":
      return param_00.var_282B;

    default:
      return param_00.basecam;
  }
}

func_BD64(param_00, param_01, param_02) {
  scripts\cp_mp\frontendutils::frontend_camera_move(param_00, param_01, 0, 1, param_02);
}

func_12DA1() {
  if(level.var_1641.shows_my_character) {
    level.var_3CAD.origin = level.var_1641.char_loc.origin;
    level.var_3CAD.angles = level.var_1641.char_loc.angles;
  }
}

func_12DEB(param_00) {
  func_12DA1();
  func_12E4A();
  func_12D9B();
}

func_12D9B() {
  var_00 = level.active_camera.var_525D;
  self setdepthoffield(var_00[0], var_00[1], var_00[2], var_00[3], var_00[4], var_00[5]);
}

func_12DBB() {
  func_12DA1();
  func_12E4A();
  func_12D9B();
}

func_12E4A() {
  var_00 = undefined;
  if(isDefined(level.var_1641.var_13C27)) {
    var_00 = level.var_1641.var_13C27;
  } else {
    var_01 = ishost(level.var_4BF6);
    var_00 = var_01.var_13C27;
  }

  level.var_394.origin = var_00.origin;
  level.var_394.angles = var_00.angles;
  level.var_13BF9.origin = var_00.origin;
  level.var_13BF9.angles = var_00.angles;
  level.var_13BFA.origin = var_00.origin;
  level.var_13BFA.angles = var_00.angles;
}

func_37BB(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  if(param_00.name == "mlg.tv") {
    return;
  }

  if(param_00.name == "mp_main") {
    frontendscenecameracharacters(3);
    var_01 = level.var_37B0;
    var_02 = level.var_37B0.basecam;
  } else if(param_00.name == "rig_select" || param_00.name == "rig_pick" || param_00.name == "rig_trait_select" || param_00.name == "rig_taunt_select" || param_00.name == "rig_head_select") {
    frontendscenecameracharacters(0);
    var_01 = get_camera_data_by_rig_scene(param_00.name);
    var_02 = var_01.basecam;
  } else if(param_00.name == "armory") {
    frontendscenecameracharacters(0);
    var_01 = level.var_37A7;
    var_02 = level.var_37A7.basecam;
  } else if(param_00.name == "lobby_members") {
    frontendscenecameracharacters(2);
    var_01 = level.camera_lobby_members;
    var_02 = level.camera_lobby_members.basecam;
  } else {
    frontendscenecameracharacters(0);
    var_01 = ishost(param_00.index);
    var_02 = func_788A(var_01, param_00.name);
  }

  func_F289(var_01, var_02);
  level.var_4BF6 = param_00.index;
  level.var_4C01 = param_00.name;
  thread scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, var_01.myfov, var_01.var_3F70, 0, 0.2, ::func_12DBB);
}

func_37BA(param_00) {
  if(param_00.name == "") {
    return;
  }

  if(!isDefined(level.var_1641) || level.transition_interrupted) {
    func_37BB(param_00);
    return;
  }

  switch (param_00.name) {
    case "mp_main":
      frontendscenecameracharacters(3);
      if(level.var_4C01 != "mlg.tv") {
        func_F289(level.var_37B0, level.var_37B0.basecam);
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, 20, level.var_37B0.var_3F70, 0.2, 0.2, ::func_12D9B);
      }

      level.var_4BF6 = undefined;
      break;

    case "private_lobby":
      frontendscenecameracharacters(0);
      func_F289(level.var_37B5, level.var_37B5.basecam);
      if(level.var_4C01 == "private_lobby_menu" || level.var_4C01 == "create_a_class") {
        thread func_BD64(level.active_camera, 5000, ::func_12D9B);
      } else {
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, 40, level.var_37B5.var_3F70, 0.2, 0.2, ::func_12DBB);
      }

      level.var_4BF6 = undefined;
      break;

    case "private_lobby_menu":
      frontendscenecameracharacters(0);
      func_F289(level.var_37B5, level.var_37B5.var_AEB5);
      if(level.var_4C01 == "create_a_class" || level.var_4C01 == "private_lobby") {
        thread func_BD64(level.active_camera, 5000, ::func_12D9B);
      } else {
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, 40, level.var_37B5.var_3F70, 0.2, 0.2, ::func_12DBB);
      }

      level.var_4BF6 = undefined;
      break;

    case "create_a_class":
      if(coming_from_rig_select() || level.var_4C01 == "armory") {
        var_01 = ishost(param_00.index);
        func_F289(var_01, var_01.var_369A);
        level.var_4BF6 = param_00.index;
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12DEB);
      } else {
        var_02 = 5000;
        if(level.var_4C01 == "mission_team_lobby") {
          var_02 = 600;
        }

        func_F289(level.var_1641, level.var_1641.var_369A);
        thread func_BD64(level.var_1641.var_369A, var_02, ::func_12DBB);
      }
      break;

    case "weapon_select":
      if(level.var_4C01 == "armory") {
        var_01 = ishost(param_00.index);
        func_F289(var_01, var_01.var_13C7B);
        level.var_4BF6 = param_00.index;
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12DEB);
      } else {
        func_F289(level.var_1641, level.var_1641.var_13C7B);
        thread func_BD64(level.var_1641.var_13C7B, 5000, ::func_12D9B);
      }
      break;

    case "loadout_select":
      if(level.var_4C01 == "armory") {
        var_01 = ishost(param_00.index);
        func_F289(var_01, var_01.var_AE63);
        level.var_4BF6 = param_00.index;
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12DEB);
      } else {
        func_F289(level.var_1641, level.var_1641.var_AE63);
        thread func_BD64(level.var_1641.var_AE63, 5000, ::func_12D9B);
      }
      break;

    case "lobby_members":
      level.var_4BF6 = undefined;
      func_F289(level.var_37B7, level.camera_lobby_members.basecam);
      scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12D9B);
      break;

    case "rig_select":
      func_F289(level.var_37B7, level.var_37B7.basecam);
      if(level.var_4C01 == "rig_pick" || level.var_4C01 == "rig_trait_select" || level.var_4C01 == "rig_head_select" || level.var_4C01 == "rig_taunt_select") {
        thread func_BD64(level.active_camera, 5000, ::func_12D9B);
        frontendscenecamerafov(level.var_37B7.myfov, 0.1);
      } else {
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12D9B);
      }

      level.var_4BF6 = undefined;
      break;

    case "rig_pick":
      func_F289(level.var_37B8, level.var_37B8.basecam);
      if(level.var_4C01 == "rig_select" || level.var_4C01 == "rig_head_select") {
        thread func_BD64(level.var_37B8.basecam, 5000, ::func_12D9B);
        frontendscenecamerafov(level.var_37B8.myfov, 0.1);
      } else {
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12D9B);
      }
      break;

    case "rig_trait_select":
      func_F289(level.var_37B9, level.var_37B9.basecam);
      thread func_BD64(level.var_37B9.basecam, 5000, ::func_12D9B);
      break;

    case "rig_head_select":
      func_F289(level.camera_rig_head, level.camera_rig_head.basecam);
      if(level.var_4C01 == "rig_select" || level.var_4C01 == "rig_pick") {
        thread func_BD64(level.camera_rig_head.basecam, 5000, ::func_12D9B);
        frontendscenecamerafov(level.camera_rig_head.myfov, 0.1);
      } else {
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12D9B);
      }
      break;

    case "rig_taunt_select":
      func_F289(level.camera_rig_taunt, level.camera_rig_taunt.basecam);
      if(level.var_4C01 == "rig_select" || level.var_4C01 == "rig_pick") {
        thread func_BD64(level.camera_rig_taunt.basecam, 5000, ::func_12D9B);
        frontendscenecamerafov(level.camera_rig_taunt.myfov, 0.15);
      } else {
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12D9B);
      }
      break;

    case "barracks":
      var_01 = ishost(param_00.index);
      func_F289(var_01, var_01.var_282B);
      level.var_4BF6 = param_00.index;
      if(level.var_4C01 == "armory") {
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12D9B);
      } else {
        if(level.var_4C01 == "loadout_select" || level.var_4C01 == "weapon_select") {
          var_02 = 5000;
        } else {
          var_02 = 100;
        }

        thread func_BD64(level.var_1641.var_282B, var_02, ::func_12D9B);
      }
      break;

    case "mission_team_lobby":
      frontendscenecameracharacters(0);
      if(isDefined(level.var_4BF6) && level.var_4BF6 == param_00.index) {
        func_F289(level.var_1641, level.var_1641.basecam);
        if(level.var_4C01 == "barracks") {
          thread func_BD64(level.var_1641.basecam, 100, ::func_12D9B);
        } else {
          thread func_BD64(level.var_1641.basecam, 600, ::func_12D9B);
        }
      } else {
        var_01 = ishost(param_00.index);
        func_F289(var_01, var_01.basecam);
        level.var_4BF6 = param_00.index;
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12DEB);
      }
      break;

    case "armory":
      func_F289(level.var_37A7, level.var_37A7.basecam);
      scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12D9B);
      level.var_4BF6 = undefined;
      break;

    case "bro_shot":
      func_F289(level.camera_bro_shot, level.camera_bro_shot.basecam);
      scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12D9B);
      level.var_4BF6 = undefined;
      break;

    case "weapon_painter_select":
      func_F289(level.camera_weapon_painter, level.camera_weapon_painter.basecam);
      scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, level.var_1641.myfov, level.var_1641.var_3F70, 0.2, 0.2, ::func_12E4A);
      break;

    case "mlg.tv":
      frontendscenecameracharacters();
      break;

    case "gamebattles_lobby":
      frontendscenecameracharacters(0);
      func_F289(level.camera_gamebattles_lobby, level.camera_gamebattles_lobby.basecam);
      if(level.var_4C01 == "create_a_class") {
        thread func_BD64(level.active_camera, 5000, ::func_12D9B);
      } else {
        scripts\cp_mp\frontendutils::frontend_camera_teleport(level.active_camera, 40, level.camera_gamebattles_lobby.var_3F70, 0.2, 0.2, ::func_12DBB);
      }

      level.var_4BF6 = undefined;
      break;

    default:
      scripts\cp_mp\frontendutils::frontend_camera_teleport(level.var_37B0.basecam, 65, undefined, 0.2, 0.2, ::func_12D9B);
      break;
  }

  level.var_4C01 = param_00.name;
}

func_48AE() {
  level.var_37B0 = spawnStruct();
  level.var_37B0.basecam = getent("camera_mp_main", "targetname");
  level.var_37B0.basecam.var_525D = [55, 79, 90, 300, 4, 1.8];
  level.var_37B0.var_369A = level.var_37B0.basecam;
  level.var_37B0.var_13C7B = level.var_37B0.basecam;
  level.var_37B0.var_E510 = level.var_37B0.basecam;
  level.var_37B0.myfov = 20;
  level.var_37B0.char_loc = getent("character_loc_mp_main", "targetname");
  level.var_37B0.var_13C27 = getent("weapon_loc_hq2", "targetname");
  level.var_37B0.var_3F70 = "MP_FRONTEND_VX";
  level.var_37B0.shows_my_character = 0;
  level.var_37B5 = spawnStruct();
  level.var_37B5.basecam = getent("camera_mp_hq2", "targetname");
  level.var_37B5.basecam.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.var_37B5.var_369A = getent("camera_mp_hq2_cac", "targetname");
  level.var_37B5.var_369A.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37B5.var_AE63 = getent("camera_mp_hq2_weapon_02", "targetname");
  level.var_37B5.var_AE63.var_525D = [0, 0, 10000, 10000, 8, 6];
  level.var_37B5.var_13C7B = getent("camera_mp_hq2_weapon", "targetname");
  level.var_37B5.var_13C7B.var_525D = [0, 0, 10000, 10000, 10, 8];
  level.var_37B5.var_E510 = getent("camera_mp_hq2_rig", "targetname");
  level.var_37B5.var_E510.var_525D = [10, 15, 250, 300, 4, 1.8];
  level.var_37B5.var_282B = level.var_37B5.var_369A;
  level.var_37B5.var_AEB5 = getent("camera_mp_lan_default", "targetname");
  level.var_37B5.var_AEB5.var_525D = [0, 0, 10000, 10000, 10, 8];
  level.var_37B5.myfov = 40;
  level.var_37B5.char_loc = getent("character_loc_hq2", "targetname");
  level.var_37B5.var_13C27 = getent("weapon_loc_hq2", "targetname");
  level.var_37B5.var_3F70 = "MP_COD_XP_Bink";
  level.var_37B5.shows_my_character = 1;
  level.camera_gamebattles_lobby = spawnStruct();
  level.camera_gamebattles_lobby.basecam = getent("camera_mp_hq2", "targetname");
  level.camera_gamebattles_lobby.basecam.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.camera_gamebattles_lobby.var_369A = getent("camera_mp_hq2_cac", "targetname");
  level.camera_gamebattles_lobby.var_369A.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.camera_gamebattles_lobby.var_AE63 = getent("camera_mp_hq2_weapon_02", "targetname");
  level.camera_gamebattles_lobby.var_AE63.var_525D = [0, 0, 10000, 10000, 8, 6];
  level.camera_gamebattles_lobby.var_13C7B = getent("camera_mp_hq2_weapon", "targetname");
  level.camera_gamebattles_lobby.var_13C7B.var_525D = [0, 0, 10000, 10000, 10, 8];
  level.camera_gamebattles_lobby.var_E510 = getent("camera_mp_hq2_rig", "targetname");
  level.camera_gamebattles_lobby.var_E510.var_525D = [10, 15, 250, 300, 4, 1.8];
  level.camera_gamebattles_lobby.myfov = 40;
  level.camera_gamebattles_lobby.char_loc = getent("character_loc_hq2", "targetname");
  level.camera_gamebattles_lobby.var_13C27 = getent("weapon_loc_hq2", "targetname");
  level.camera_gamebattles_lobby.var_3F70 = "MP_COD_XP_Bink";
  level.camera_gamebattles_lobby.shows_my_character = 1;
  level.var_37AA = spawnStruct();
  level.var_37AA.basecam = getent("camera_mp_hq1", "targetname");
  level.var_37AA.basecam.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.var_37AA.var_369A = getent("camera_mp_hq1_cac", "targetname");
  level.var_37AA.var_369A.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AA.var_AE63 = getent("camera_mp_hq1_weapon_02", "targetname");
  level.var_37AA.var_AE63.var_525D = [0, 0, 10000, 10000, 8, 6];
  level.var_37AA.var_13C7B = getent("camera_mp_hq1_weapon", "targetname");
  level.var_37AA.var_13C7B.var_525D = [0, 0, 10000, 10000, 10, 8];
  level.var_37AA.var_E510 = getent("camera_mp_hq1_rig", "targetname");
  level.var_37AA.var_E510.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AA.var_282B = level.var_37AA.var_369A;
  level.var_37AA.myfov = 40;
  level.var_37AA.char_loc = getent("character_loc_hq1", "targetname");
  level.var_37AA.var_13C27 = getent("weapon_loc_hq1", "targetname");
  level.var_37AA.var_3F70 = "MP_screen_WOLVERINE";
  level.var_37AA.shows_my_character = 1;
  level.var_37AB = spawnStruct();
  level.var_37AB.basecam = getent("camera_mp_hq2", "targetname");
  level.var_37AB.basecam.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.var_37AB.var_369A = getent("camera_mp_hq2_cac", "targetname");
  level.var_37AB.var_369A.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AB.var_AE63 = getent("camera_mp_hq2_weapon_02", "targetname");
  level.var_37AB.var_AE63.var_525D = [0, 0, 10000, 10000, 8, 6];
  level.var_37AB.var_13C7B = getent("camera_mp_hq2_weapon", "targetname");
  level.var_37AB.var_13C7B.var_525D = [0, 0, 10000, 10000, 10, 8];
  level.var_37AB.var_E510 = getent("camera_mp_hq2_rig", "targetname");
  level.var_37AB.var_E510.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AB.var_282B = level.var_37AB.var_369A;
  level.var_37AB.myfov = 40;
  level.var_37AB.char_loc = getent("character_loc_hq2", "targetname");
  level.var_37AB.var_13C27 = getent("weapon_loc_hq2", "targetname");
  level.var_37AB.var_3F70 = "MP_COD_XP_Bink";
  level.var_37AB.shows_my_character = 1;
  level.var_37AC = spawnStruct();
  level.var_37AC.basecam = getent("camera_mp_hq3", "targetname");
  level.var_37AC.basecam.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.var_37AC.var_369A = getent("camera_mp_hq3_cac", "targetname");
  level.var_37AC.var_369A.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.var_37AC.var_AE63 = getent("camera_mp_hq3_weapon_02", "targetname");
  level.var_37AC.var_AE63.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.var_37AC.var_13C7B = getent("camera_mp_hq3_weapon", "targetname");
  level.var_37AC.var_13C7B.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.var_37AC.var_E510 = getent("camera_mp_hq3_rig", "targetname");
  level.var_37AC.var_E510.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AC.var_282B = level.var_37AC.var_369A;
  level.var_37AC.myfov = 40;
  level.var_37AC.char_loc = getent("character_loc_hq3", "targetname");
  level.var_37AC.var_13C27 = getent("weapon_loc_hq3", "targetname");
  level.var_37AC.var_3F70 = "MP_screen_ORION";
  level.var_37AC.shows_my_character = 1;
  level.var_37AD = spawnStruct();
  level.var_37AD.basecam = getent("camera_mp_hq4", "targetname");
  level.var_37AD.basecam.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.var_37AD.var_369A = getent("camera_mp_hq4_cac", "targetname");
  level.var_37AD.var_369A.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AD.var_AE63 = getent("camera_mp_hq4_weapon_02", "targetname");
  level.var_37AD.var_AE63.var_525D = [0, 0, 10000, 10000, 8, 6];
  level.var_37AD.var_13C7B = getent("camera_mp_hq4_weapon", "targetname");
  level.var_37AD.var_13C7B.var_525D = [0, 0, 10000, 10000, 10, 8];
  level.var_37AD.var_E510 = getent("camera_mp_hq4_rig", "targetname");
  level.var_37AD.var_E510.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AD.var_282B = level.var_37AD.var_369A;
  level.var_37AD.myfov = 40;
  level.var_37AD.char_loc = getent("character_loc_hq4", "targetname");
  level.var_37AD.var_13C27 = getent("weapon_loc_hq4", "targetname");
  level.var_37AD.var_3F70 = "MP_screen_WRAITH";
  level.var_37AD.shows_my_character = 1;
  level.var_37AE = spawnStruct();
  level.var_37AE.basecam = getent("camera_mp_hq5", "targetname");
  level.var_37AE.basecam.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.var_37AE.var_369A = getent("camera_mp_hq5_cac", "targetname");
  level.var_37AE.var_369A.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AE.var_AE63 = getent("camera_mp_hq5_weapon_02", "targetname");
  level.var_37AE.var_AE63.var_525D = [0, 0, 10000, 10000, 8, 6];
  level.var_37AE.var_13C7B = getent("camera_mp_hq5_weapon", "targetname");
  level.var_37AE.var_13C7B.var_525D = [0, 0, 10000, 10000, 10, 8];
  level.var_37AE.var_E510 = getent("camera_mp_hq5_rig", "targetname");
  level.var_37AE.var_E510.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AE.var_282B = level.var_37AE.var_369A;
  level.var_37AE.myfov = 40;
  level.var_37AE.char_loc = getent("character_loc_hq5", "targetname");
  level.var_37AE.var_13C27 = getent("weapon_loc_hq5", "targetname");
  level.var_37AE.var_3F70 = "MP_screen_SABER";
  level.var_37AE.shows_my_character = 1;
  level.var_37AF = spawnStruct();
  level.var_37AF.basecam = getent("camera_mp_hq6", "targetname");
  level.var_37AF.basecam.var_525D = [0, 0, 10000, 10000, 6, 1];
  level.var_37AF.var_369A = getent("camera_mp_hq6_cac", "targetname");
  level.var_37AF.var_369A.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AF.var_AE63 = getent("camera_mp_hq6_weapon_02", "targetname");
  level.var_37AF.var_AE63.var_525D = [0, 0, 10000, 10000, 8, 6];
  level.var_37AF.var_13C7B = getent("camera_mp_hq6_weapon", "targetname");
  level.var_37AF.var_13C7B.var_525D = [0, 0, 10000, 10000, 10, 8];
  level.var_37AF.var_E510 = getent("camera_mp_hq6_rig", "targetname");
  level.var_37AF.var_E510.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37AF.var_282B = level.var_37AF.var_369A;
  level.var_37AF.myfov = 40;
  level.var_37AF.char_loc = getent("character_loc_hq6", "targetname");
  level.var_37AF.var_13C27 = getent("weapon_loc_hq6", "targetname");
  level.var_37AF.var_3F70 = "MP_screen_BLOODFORGE";
  level.var_37AF.shows_my_character = 1;
  level.camera_bro_shot = spawnStruct();
  level.camera_bro_shot.basecam = getent("camera_mp_broshot", "targetname");
  level.camera_bro_shot.basecam.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.camera_bro_shot.myfov = 40;
  level.camera_bro_shot.char_loc = getent("character_loc_broshot", "targetname");
  level.camera_bro_shot.var_3CAB = getent("character_loc_broshot_a", "targetname");
  level.camera_bro_shot.var_3CAC = getent("character_loc_broshot_b", "targetname");
  level.camera_bro_shot.shows_my_character = 0;
  level.var_37A7 = spawnStruct();
  level.var_37A7.basecam = getent("camera_mp_armory", "targetname");
  level.var_37A7.basecam.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37A7.myfov = 40;
  level.var_37A7.char_loc = getent("character_loc_armory", "targetname");
  level.var_37A7.shows_my_character = 0;
  level.var_37A7.box_loc = getent("loot_box", "targetname");
  level.var_37B7 = spawnStruct();
  level.var_37B7.basecam = getent("camera_mp_rig_select", "targetname");
  level.var_37B7.basecam.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37B7.var_369A = getent("camera_mp_hq7_cac", "targetname");
  level.var_37B7.var_369A.var_525D = [10, 15, 250, 300, 4, 1.8];
  level.var_37B7.var_AE63 = getent("camera_mp_hq7_weapon_02", "targetname");
  level.var_37B7.var_AE63.var_525D = [0, 15, 80, 300, 8, 6];
  level.var_37B7.var_13C7B = getent("camera_mp_hq7_weapon", "targetname");
  level.var_37B7.var_13C7B.var_525D = [0, 15, 80, 300, 10, 8];
  level.var_37B7.var_E510 = getent("camera_mp_hq7_rig", "targetname");
  level.var_37B7.var_E510.var_525D = [10, 15, 250, 300, 4, 1.8];
  level.var_37B7.var_282B = level.var_37AF.var_369A;
  level.var_37B7.myfov = 40;
  level.var_37B7.char_loc = getent("character_loc_hq7", "targetname");
  level.var_37B7.var_13C27 = getent("weapon_loc_hq7", "targetname");
  level.var_37B7.var_3F70 = "MP_COD_XP_Bink";
  level.var_37B7.shows_my_character = 0;
  level.var_37B8 = spawnStruct();
  level.var_37B8.basecam = getent("camera_mp_rig_select", "targetname");
  level.var_37B8.basecam.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.var_37B8.myfov = 40;
  level.var_37B8.char_loc = getent("character_loc_hq7", "targetname");
  level.var_37B8.var_3F70 = "MP_COD_XP_Bink";
  level.var_37B8.shows_my_character = 0;
  level.camera_rig_taunt = spawnStruct();
  level.camera_rig_taunt.basecam = getent("camera_mp_taunt", "targetname");
  level.camera_rig_taunt.basecam.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.camera_rig_taunt.basecam.origin = (-30, 6.66, 0) + level.camera_rig_taunt.basecam.origin;
  level.camera_rig_taunt.myfov = 63;
  level.camera_rig_taunt.char_loc = getent("character_loc_taunt", "targetname");
  level.camera_rig_taunt.var_3F70 = "MP_COD_XP_Bink";
  level.camera_rig_taunt.shows_my_character = 0;
  level.var_37B9 = spawnStruct();
  level.var_37B9.basecam = getent("camera_mp_rig_traits", "targetname");
  level.var_37B9.basecam.var_525D = [0, 15, 80, 300, 8, 6];
  level.var_37B9.myfov = 40;
  level.var_37B9.char_loc = getent("character_loc_hq7", "targetname");
  level.var_37B9.shows_my_character = 0;
  level.camera_rig_head = spawnStruct();
  level.camera_rig_head.basecam = getent("camera_mp_rig_head", "targetname");
  level.camera_rig_head.basecam.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.camera_rig_head.myfov = 36;
  level.camera_rig_head.char_loc = getent("character_loc_hq7", "targetname");
  level.camera_rig_head.shows_my_character = 0;
  level.camera_lobby_members = spawnStruct();
  level.camera_lobby_members.basecam = getent("camera_mp_lobby_members", "targetname");
  level.camera_lobby_members.basecam.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.camera_lobby_members.myfov = 40;
  level.camera_lobby_members.char_loc = getent("character_loc_lobby_members", "targetname");
  level.camera_lobby_members.shows_my_character = 0;
  level.var_37BF = getent("camera_weapon_select", "targetname");
  level.camera_weapon_painter = spawnStruct();
  level.camera_weapon_painter.basecam = getent("camera_mp_gun_painter_01", "targetname");
  level.camera_weapon_painter.basecam.var_525D = [0, 0, 10000, 10000, 4, 1.8];
  level.camera_weapon_painter.myfov = 40;
  level.camera_weapon_painter.var_13C27 = getent("weapon_loc_painter", "targetname");
  level.camera_weapon_painter.shows_my_character = 0;
}

func_F289(param_00, param_01) {
  level.var_1641 = param_00;
  level.active_camera = param_01;
}

setup_initial_entities() {
  var_00 = getent("character_loc_hq2", "targetname");
  level.var_3CAD = spawn("script_character", var_00.origin, 0, 0, 0);
  level.var_3CAD.angles = var_00.angles;
  var_01 = level.var_37B7.char_loc;
  level.charactercac = spawn("script_character", var_01.origin, 0, 0, 1);
  level.charactercac.angles = var_01.angles;
  var_02 = level.camera_lobby_members.char_loc;
  level.characterlobbymember = spawn("script_character", var_02.origin, 0, 0, 2);
  level.characterlobbymember.angles = var_02.angles;
  level.var_3CB4 = spawn("script_character", level.var_37B0.char_loc.origin, 0, 0, 3);
  level.var_3CB4.angles = level.var_37B0.char_loc.angles;
  level.quartermaster = spawn("script_character", level.var_37A7.char_loc.origin, 0, 0, 4);
  level.quartermaster.angles = level.var_37A7.char_loc.angles;
  level.loot_box = spawn("script_character", level.var_37A7.box_loc.origin, 0, 0, 5);
  level.loot_box.angles = level.var_37A7.box_loc.angles;
  var_03 = getent("weapon_loc_hq1", "targetname");
  level.var_394 = spawn("script_weapon", var_03.origin, 0, 0, 0);
  level.var_394.angles = var_03.angles;
  level.var_394 setotherent(level.var_3CAD);
  level.var_13BF9 = spawn("script_weapon", var_03.origin, 0, 0, 1);
  level.var_13BF9.angles = var_03.angles;
  level.var_13BF9 setotherent(level.var_3CAD);
  level.var_13BFA = spawn("script_weapon", var_03.origin, 0, 0, 2);
  level.var_13BFA.angles = var_03.angles;
  level.var_13BFA setotherent(level.var_3CAD);
  scripts\cp_mp\frontendutils::frontend_camera_setup(level.var_37B0.basecam.origin, level.var_37B0.basecam.angles);
}

epictauntlistener() {
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "taunt_started") {
      scripts\mp\broshot_utilities::respawnclientcharacter();
      var_02 = tablelookup("mp\cac\taunts.csv", 0, var_01, 9);
      scripts\mp\broshot_utilities::processepictaunt(var_02, -1, 0);
      continue;
    }

    if(var_00 == "taunt_reset") {
      scripts\mp\broshot_utilities::respawnclientcharacter();
    }
  }
}

camolistener() {}

main() {
  setdvar("match_running", 0);
  scripts\mp\maps\mp_frontend\mp_frontend_precache::main();
  scripts\mp\maps\mp_frontend\gen\mp_frontend_art::main();
  scripts\mp\maps\mp_frontend\mp_frontend_fx::main();
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  func_48AE();
  setup_initial_entities();
  level.transition_interrupted = 0;
  level.callbackplayerconnect = ::callback_frontendplayerconnect;
  frontendscenecameracharacters(0, 3);
  precachemodel("veh_mil_air_ca_oblivion_drone_mp");
  precachempanim("IW7_mp_taunt_killstreak_apex01_apex");
  precachemodel("veh_mil_air_thor_wm");
  precachemodel("sdf_mp_cruise_missile_01");
  precachemodel("un_mp_jackal_exterior_missile");
  precachempanim("iw7_mp_taunt_killstreak_thor_prop");
  precachempanim("iw7_mp_taunt_killstreak_thor_missile_sdf");
  precachempanim("iw7_mp_taunt_killstreak_thor_missile01");
  precachempanim("iw7_mp_taunt_killstreak_thor_missile02");
  precachempanim("iw7_mp_taunt_killstreak_thor_missile03");
  precachempanim("iw7_mp_taunt_killstreak_thor_missile04");
  precachempanim("iw7_mp_taunt_killstreak_thor_missile05");
  precachemodel("veh_mil_air_un_uav");
  precachempanim("iw7_mp_taunt_super_shootdown_uav");
  precachemodel("weapon_retract_shield_wm_mp");
  precachempanim("iw7_mp_taunt_super_shield_prop");
  precachempanim("iw7_mp_taunt_super_shield_prop_no_gun");
  precachemodel("mp_robot_c8");
  precachemodel("weapon_c8_shield_top_mp");
  precachemodel("weapon_c8_shield_bottom_mp");
  precachempanim("iw7_mp_taunt_killstreak_c8_robot");
  precachemodel("care_package_iw7_ca_wm");
  precachemodel("equipment_mp_nanoshot_wm");
  precachempanim("IW7_mp_taunt_adrenaline_nano");
  precachemodel("veh_mil_air_ca_jackal_drone_atmos_periph_mp");
  precachempanim("iw7_mp_taunt_killstreak_scorcher_scorcher01");
  precachempanim("iw7_mp_taunt_killstreak_scorcher_scorcher02");
  precachempanim("iw7_mp_taunt_killstreak_scorcher_scorcher03");
  precachempanim("iw7_mp_taunt_synaptic_reaper");
  precachempanim("iw7_mp_taunt_super_merc_steeldragon_frontend");
  precachempanim("iw7_mp_taunt_killstreak_laser_strike");
  precachempanim("iw7_mp_taunt_killstreak_laser_strike_synaptic");
  precachempanim("IW7_mp_taunt_ftl_pistol_spin");
  precachempanim("iw7_mp_taunt_bio_spike");
  precachempanim("iw7_mp_taunt_bio_spike_synaptic");
  precachempanim("iw7_mp_taunt_ftl_1st_kills_456");
  precachempanim("iw7_mp_taunt_ftl_2nd_kills_456");
  precachempanim("iw7_mp_taunt_ftl_3rd_kills_456");
  precachemodel("ctf_game_flag_unsa_close_wm");
  precachemodel("ctf_game_flag_sdf_close_wm");
  precachemodel("ctf_game_flag_noStand_red_mp");
  precachemodel("ctf_game_flag_noStand_blue_mp");
  precachempanim("iw7_mp_taunt_flag_plant_flag");
  precachemodel("care_package_iw7_ca_wm");
  precachempanim("IW7_mp_taunt_drone_crush_07_carepackage");
}