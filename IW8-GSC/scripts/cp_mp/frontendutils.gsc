/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\frontendutils.gsc
***********************************************/

function ref_131e2() {
  level.ref_13370 = getdvarint("MONKPPPQR", 0);
  level.playerwaitilllongholdmelee = &juggernaut_kills_tracker;
  level.playerwaittillspectatecycle = &juggernaut_shouldexecute;
  level.playerwaittillcinematiccomplete = &juggernaut_logic;
}

function juggernaut_kills_tracker() {
  wait 0.1;
  waittillframeend();
  level.player_setsunshadowsforzoom = getEnt("mp_lobby_floor_01", "targetname");
  level.player_setsunshadowsforzoom.helidrivableenablesiteondeath = getEntArray("floor_01_clutter", "targetname");
  level.player_setsunshadowsforzoom.lights = getEntArray("floor_01_lights", "script_noteworthy");
  level.player_standing_in_doorway = getEnt("mp_lobby_floor_02", "targetname");
  level.player_standing_in_doorway.helidrivableenablesiteondeath = getEntArray("floor_02_clutter", "targetname");
  level.player_standing_in_doorway.lights = getEntArray("floor_02_lights", "script_noteworthy");

  if(level.player_setsunshadowsforzoom.helidrivableenablesiteondeath.size) {
    scripts\engine\utility::array_call(level.player_setsunshadowsforzoom.helidrivableenablesiteondeath, &linkto, level.player_setsunshadowsforzoom);
  }

  if(level.player_standing_in_doorway.helidrivableenablesiteondeath.size) {
    scripts\engine\utility::array_call(level.player_standing_in_doorway.helidrivableenablesiteondeath, &linkto, level.player_standing_in_doorway);
  }

  var0 = scripts\engine\utility::array_combine(level.player_setsunshadowsforzoom.lights, level.player_standing_in_doorway.lights);

  foreach(var2 in var0) {
    var2.originalpos = var2.origin;
  }

  var4 = level.player_setsunshadowsforzoom.origin;
  var5 = level.player_standing_in_doorway.origin;
  var6 = distance(var4, var5);
  var7 = 36.96;
  var8 = var6 / var7;
  var9 = var4 + vectorNormalize(var4 - var5) * var6;
  var10 = vectorNormalize(var4 - var5) * var6;
  var11 = 1;

  for(;;) {
    if(var11) {
      var12 = level.player_standing_in_doorway;
      var13 = level.player_setsunshadowsforzoom;
    } else {
      var12 = level.player_setsunshadowsforzoom;
      var13 = level.player_standing_in_doorway;
    }

    var14 = (0, 0, -1000);
    var12 hide();
    var12.origin += var14;
    waitframe();

    if(var11) {
      foreach(var2 in var12.lights) {
        var2.origin = var2.originalpos;
      }
    } else {
      foreach(var2 in var12.lights) {
        var2.origin += var10 * -2;
      }
    }

    var12.origin = var5 + var14;
    waitframe();
    var12.origin = var5;
    var12 show();
    var12 moveTo(var4, var8);

    foreach(var2 in var12.lights) {
      var2 moveTo(var2.origin + var10, var8);
    }

    var13 moveTo(var9, var8);

    foreach(var2 in var13.lights) {
      var2 moveTo(var2.origin + var10, var8);
    }

    var11 = !var11;
    wait var8;
  }
}

function juggernaut_shouldexecute() {
  if(level.ref_13370) {
    var0 = getscriptablearray("frontend_vfx_scriptable", "script_noteworthy");

    if(!var0.size) {
      var0 = getentitylessscriptablearrayinradius("frontend_vfx_scriptable", "script_noteworthy");
    }

    var1 = "mplobby";
    var2 = "seasonal";

    if(var0.size) {
      foreach(var4 in var0) {
        if(var4 getscriptablehaspart(var1)) {
          if(var4 getscriptableparthasstate(var1, var2)) {
            var4 setscriptablepartstate(var1, var2);
          }
        }
      }
    }

    var6 = getEntArray("nonseasonal", "script_noteworthy");

    if(var6.size) {
      foreach(var8 in var6) {
        var8 hide();
      }

      return;
    }

    return;
  }

  var10 = getEntArray("seasonal", "script_noteworthy");

  if(var10.size) {
    foreach(var12 in var10) {
      var12 hide();
    }

    return;
  }
}

function juggernaut_logic() {
  var0 = "tag_origin";
  var1 = " ";
  var2 = "seasonal";
  var3 = "nonseasonal";
  var4 = [];
  GscBinSkip0(0x2e, var4.size, getEnt("mp_lobby_floor_01", "targetname"));
}

function playersetisbecomingzombie() {
  level thread[[level.playerwaitilllongholdmelee]]();
}

function playersetiszombie() {
  level thread[[level.playerwaittillspectatecycle]]();
}

function playersetispropgameextrainfo() {
  level thread[[level.playerwaittillcinematiccomplete]]();
}

function frontend_camera_setup(var0, var1) {
  level.camera_anchor = spawn("script_model", var0);
  level.camera_anchor setModel("tag_origin");
  level.camera_anchor.angles = var1;
}

function frontend_camera_watcher(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self cameralinkTo(level.camera_anchor, "tag_origin");
  level.active_section = frontendscenegetactivesection();
  [[var0]](level.active_section);
  waitframe();

  for(;;) {
    var1 = frontendscenegetactivesection();

    if(var1.name == level.active_section.name && var1.index == level.active_section.index) {
      if(level.active_section.name == getDvar("NRLKQRRMKK")) {
        stopclientexploder();
      }

      waitframe();
      continue;
    }

    level.active_section = var1;
    [[var0]](var1);
  }
}

function camera_section_change(var0) {
  if(var0.name == "") {
    return;
  }

  var1 = get_section_state(var0);

  if(!isDefined(var1["scene"]) || !isDefined(var1["camera"])) {
    return;
  }

  set_active_camera(var1["scene"], var1["camera"]);
  execute_transition(var0, level.currentsectionname);
  level.currentsectionname = var0.name;
}

function set_active_camera(var0, var1) {
  level.active_scene_data = var0;
  level.active_camera = var1;
}

function execute_transition(var0, var1) {
  var2 = !isDefined(level.active_scene_data) || level.transition_interrupted;

  if(var2) {
    thread frontend_camera_teleport(level.active_camera, level.active_scene_data.myfov, level.active_scene_data.cinematic, 0, 0.2, &update_entities_and_camera);
  }

  var3 = level.transitionarray;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;
  var10 = undefined;
  var11 = undefined;
  var12 = undefined;
  var13 = undefined;
  var14 = undefined;

  if(isDefined(var3[var0.name])) {
    var15 = var3[var0.name];
    var16 = var15["default"];

    if(isDefined(var1) && isDefined(var15[var1])) {
      var6 = var15[var1]["callback"];
      var5 = var15[var1]["fov"];
      var4 = var15[var1]["speed"];
      var8 = var15[var1]["fadeOutTime"];
      var9 = var15[var1]["fadeInTime"];
      var10 = var15[var1]["cinematicName"];
      var11 = var15[var1]["accelScalar"];
      var12 = var15[var1]["decelScalar"];
      var13 = var15[var1]["moveTime"];
      var14 = var15[var1]["use_bounce"];

      if(isDefined(var15[var1]["transition"])) {
        var7 = var15[var1]["transition"];
      }
    }

    var6 = scripts\engine\utility::ter_op(isDefined(var6), var6, var16["callback"]);

    if(!isDefined(var7)) {
      var7 = scripts\engine\utility::ter_op(isDefined(var5), var5, var16["transition"]);
      var5 = scripts\engine\utility::ter_op(isDefined(var5), var5, var16["fov"]);
      var4 = scripts\engine\utility::ter_op(isDefined(var4), var4, var16["speed"]);
      var8 = scripts\engine\utility::ter_op(isDefined(var8), var6, var16["fadeOutTime"]);
      var9 = scripts\engine\utility::ter_op(isDefined(var9), var5, var16["fadeInTime"]);
      var10 = scripts\engine\utility::ter_op(isDefined(var10), var10, var16["cinematicName"]);
      var11 = scripts\engine\utility::ter_op(isDefined(var11), var11, var16["accelScalar"]);
      var12 = scripts\engine\utility::ter_op(isDefined(var12), var12, var16["decelScalar"]);
      var13 = scripts\engine\utility::ter_op(isDefined(var13), var13, var16["moveTime"]);
      var14 = scripts\engine\utility::ter_op(isDefined(var14), var14, var16["use_bounce"]);
    }
  } else {
    var7 = &frontend_camera_teleport;
    var6 = &update_camera_depth_of_field;
  }

  if(var7 == &frontend_camera_teleport) {
    var5 = scripts\engine\utility::ter_op(isDefined(var5), var5, level.active_scene_data.myfov);
    var8 = scripts\engine\utility::ter_op(isDefined(var8), var8, 0.2);
    var9 = scripts\engine\utility::ter_op(isDefined(var9), var9, 0.2);
    var10 = scripts\engine\utility::ter_op(isDefined(var10), var10, level.active_scene_data.cinematic);
    [[var7]](level.active_camera, var5, var10, var8, var9, var6);
    return;
  }

  if(var7 == &frontend_camera_move) {
    var11 = scripts\engine\utility::ter_op(isDefined(var11), var11, 0.1);
    var12 = scripts\engine\utility::ter_op(isDefined(var12), var12, 0.1);
    var4 = scripts\engine\utility::ter_op(isDefined(var4), var4, 5000);
    var14 = scripts\engine\utility::ter_op(isDefined(var14), var14, 0);
    var13 = scripts\engine\utility::ter_op(isDefined(var13), var13, 0);
    update_camera_depth_of_field();

    if(var6 == &update_camera_depth_of_field && !level.playerviewowner usinggamepad()) {
      var6 = &update_camera_depth_of_field_slowly;
    }

    [[var7]](level.active_camera, var4, 0, 1, var6, var11, var12, var14, var13);
    return;
  }
}

function camera_move_helper(var0, var1, var2, var3, var4, var5) {
  level.playerviewowner predictstreampos(var0.origin);

  if(var1 < 0.05) {
    var1 = 0.05;
  }

  var6 = 0;
  var7 = 0;

  if(var2) {
    var6 = var1 * var3;
    var7 = var1 * var4;
  }

  if(var5) {
    var8 = 1.3;
    var9 = vectorNormalize(var0.origin - level.camera_anchor.origin);
    var10 = var0.origin + var9 * var8;
    var11 = var1 / 2;
    var12 = var11 * 0;
    var13 = var11 * 0.5;
    var14 = var11 * 0.5;
    var15 = var11 * 0;
    level.camera_anchor moveTo(var10, var11, var12, var13);
    level.camera_anchor rotateTo(var0.angles, var11, var12, var13);
    wait var11;
    level.camera_anchor moveTo(var0.origin, var11, var14, var15);
    wait var11;
    return;
  }

  level.camera_anchor.move_target = var0;
  level.camera_anchor moveTo(var0.origin, var1, var6, var7);
  level.camera_anchor rotateTo(var0.angles, var1, var6, var7);

  if(level.playerviewowner usinggamepad()) {
    wait var1;
    return;
  }
}

function frontend_camera_move(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.camera_anchor.move_target)) {
    level.camera_anchor.origin = level.camera_anchor.move_target.origin;
    level.camera_anchor.angles = level.camera_anchor.move_target.angles;
  }

  level notify("camera_move");
  level endon("camera_move");

  if(!isDefined(var1)) {
    var1 = 900;
  }

  var9 = var0;

  if(var8 == 0 || level.playerviewowner usinggamepad()) {
    var10 = distance(level.camera_anchor.origin, var9.origin);
    var8 = var10 / var1;
  }

  if(var2) {
    level.camera_anchor.origin = var9.origin;
    level.camera_anchor.angles = var9.angles;
  } else {
    camera_move_helper(var9, var8, var3, var5, var6, var7);
  }

  var11 = var5 + var6;

  if(var11 > 1) {
    var5 /= var11;
    var6 /= var11;
  }

  while(isDefined(var9.target)) {
    if(!isDefined(var9.target)) {
      return;
    }

    var9 = getEnt(var9.target, "targetname");
    camera_move_helper(var9, var8, var3, var5, var6, var7);
  }

  level.camera_anchor.move_target = undefined;

  if(isDefined(var4)) {
    self thread[[var4]]();
  }

  stopclientexploder();
}

function frontend_camera_teleport(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("camera_teleport");
  level endon("camera_teleport");
  level.playerviewowner predictstreampos(var0.origin);
  level.transition_interrupted = 1;
  frontendscenecamerafade(0, var3);
  wait var3 + 0.05;
  frontendscenecamerafov(var1, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var0.origin;
  level.camera_anchor.angles = var0.angles;
  level.camera_anchor.move_target = undefined;

  if(isDefined(var2)) {
    frontendscenecameracinematic(var2);
  }

  wait 0.1;

  if(isDefined(var5)) {
    [[var5]]();
  }

  frontendscenecamerafade(1, var4);
  level.transition_interrupted = 0;
  stopclientexploder();
}

function update_character_pos() {
  if(isDefined(level.active_scene_data.update_char_loc)) {
    [[level.active_scene_data.update_char_loc]]();
    return;
  }

  if(isDefined(level.active_scene_data.char_loc)) {
    var0 = 0;

    if(isDefined(level.active_scene_data.char_index)) {
      var0 = level.active_scene_data.char_index;
    }

    level.characters[var0].origin = level.active_scene_data.char_loc.origin;
    level.characters[var0].angles = level.active_scene_data.char_loc.angles;
    return;
  }
}

function update_player_character_showcase() {
  update_character_pos();
  update_weapon_loc();
  update_camera_depth_of_field();
  ref_13fb2();
}

function update_camera_depth_of_field() {
  var0 = level.active_camera.depthoffieldvalues;
  self setphysicaldepthoffield(var0[0], var0[1], 20, 20);
}

function update_camera_depth_of_field_slowly() {
  var0 = level.active_camera.depthoffieldvalues;
  self setphysicaldepthoffield(var0[0], var0[1], 3, 3);
}

function update_entities_and_camera() {
  update_character_pos();
  update_weapon_loc();
  update_camera_depth_of_field();
  ref_13fb2();
  ref_13fb3();
}

function ref_13fb2() {
  if(isDefined(level.active_scene_data.ref_1370f)) {
    setDvar("LTQMSPKRKO", level.active_scene_data.ref_1370f);
    return;
  }

  setDvar("LTQMSPKRKO", 8);
}

function ref_13fb3() {
  if(isDefined(level.active_scene_data.ref_13710)) {
    setDvar("LLNMKLQQP", level.active_scene_data.ref_13710);
    return;
  }

  setDvar("LLNMKLQQP", 6);
}

function move_weapon_to_loc(var0) {
  level.weapons[var0].origin = level.active_scene_data.weapon_locs[var0].origin;
  level.weapons[var0].angles = level.active_scene_data.weapon_locs[var0].angles;
}

function update_weapon_loc() {
  if(isDefined(level.active_scene_data.weapon_locs)) {
    if(isarray(level.active_scene_data.weapon_locs)) {
      for(var0 = 0; var0 <= 3; var0++) {
        if(isDefined(level.active_scene_data.weapon_locs[var0])) {
          move_weapon_to_loc(var0);
        }
      }

      return;
    }

    return;
  }
}

function update_arena_char_loc() {
  for(var0 = 0; var0 < 8; var0++) {
    if(var0 < 4) {
      var1 = getEnt("tourroom_charslot_left_0" + var0 + 1, "targetname");
    } else {
      var2 = var0 - 4;
      var1 = getEnt("tourroom_charslot_right_0" + var2 + 1, "targetname");
    }

    level.characters[var0].origin = var1.origin;
    level.characters[var0].angles = var1.angles;
  }

  for(var3 = 0; var3 < 4; var3++) {
    var4 = var3 + 1;
    var0 = 8 + var3;

    if(var4 <= 2) {
      var1 = getEnt("tourroom_charslot_left_0" + var4 + "_dog", "targetname");
    } else {
      var5 = var4 - 2;
      var1 = getEnt("tourroom_charslot_right_0" + var5 + "_dog", "targetname");
    }

    level.characters[var0].origin = var1.origin;
    level.characters[var0].angles = var1.angles;
  }
}

function ref_13f87() {
  for(var0 = 0; var0 < 12; var0++) {
    if(var0 < 6) {
      var1 = getEnt("tourroom_charslot_left_0" + var0 + 1, "targetname");
    } else {
      var2 = var0 - 6;
      var1 = getEnt("tourroom_charslot_right_0" + var2 + 1, "targetname");
    }

    level.characters[var0].origin = var1.origin;
    level.characters[var0].angles = var1.angles;
  }
}

function update_lobby_char_loc() {
  var0 = getEnt("lobby_charslot_01", "targetname");
  level.characters[0].origin = var0.origin;
  level.characters[0].angles = var0.angles;

  for(var1 = 1; var1 < 8; var1++) {
    var2 = var1 + 1;

    if(var2 < 10) {
      var0 = getEnt("lobby_charslot_0" + var2, "targetname");
    } else {
      var0 = getEnt("lobby_charslot_" + var2, "targetname");
    }

    if(isDefined(var0)) {
      level.characters[var1].origin = var0.origin;
      level.characters[var1].angles = var0.angles;
    }
  }

  for(var3 = 0; var3 < 4; var3++) {
    var2 = var3 + 1;
    var1 = 8 + var3;
    var0 = getEnt("lobby_charslot_0" + var2 + "_dog", "targetname");
    level.characters[var1].origin = var0.origin;
    level.characters[var1].angles = var0.angles;
  }
}

function update_main_menu_char_loc() {
  var0 = getEnt("charroom_char_tango_east", "targetname");
  level.characters[12].origin = var0.origin;
  level.characters[12].angles = var0.angles;
  var0 = getEnt("charroom_char_tango_west", "targetname");
  level.characters[13].origin = var0.origin;
  level.characters[13].angles = var0.angles;
}

function ref_13fa5() {
  var0 = getEnt("charroom_char_west_b", "targetname");
  level.characters[0].origin = var0.origin;
  level.characters[0].angles = var0.angles;
  level.characters[8].origin = var0.origin;
  level.characters[8].angles = var0.angles;
}

function ref_13fa4() {
  var0 = getEnt("charroom_char_east_a", "targetname");
  level.characters[1].origin = var0.origin;
  level.characters[1].angles = var0.angles;
  level.characters[9].origin = var0.origin;
  level.characters[9].angles = var0.angles;
}

function ref_12a0d(var0) {
  switch (var0) {
    case "small":
      foreach(var2 in level.ui_bg_images_2d) {
        var2.origin = level.ref_12a10.origin;
      }

      break;
    case "medium":
      foreach(var2 in level.ui_bg_images_2d) {
        var2.origin = level.ref_12a0f.origin;
      }

      break;
    case "large":
      foreach(var2 in level.ui_bg_images_2d) {
        var2.origin = level.ref_12a0e.origin;
      }

      break;
    case "watch":
      foreach(var2 in level.ui_bg_images_2d) {
        var2.origin = level.ref_12a11.origin;
      }

      break;
  }
}

function initialize_transition_array() {
  var0 = [];
  GscBinSkip0(0x2e, "loadout_showcase", []);
}

function get_section_state(var0) {
  var1 = [];
  var2 = !isDefined(level.active_scene_data) || level.transition_interrupted;
  level.playerviewowner visionsetnakedforplayer("", 0);
  level.ref_13b60 = 0;

  switch (var0.name) {
    case "mlg.tv":
      break;
    case "squad_lobby":
      var1 = level.camera_lobby;
      var1 = level.camera_lobby.basecam;

      if(level.ref_13370 && isDefined(level.playersetomnvarattraction)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_lobby_s4_mid", 0);
      }

      if(level.ref_13370 && isDefined(level.playershooting)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_lobby_s8b", 0);
      }

      if(level.ref_13370 && isDefined(level.playershowskippromptcinematic)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_lobby_s9_fog", 0);
      }

      if(level.ref_13370 && isDefined(level.playersetkeypadstateindex)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend12_halloween", 0);
      }

      if(level.ref_13370 && isDefined(level.playersleftloop)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontendc3s1_lobby_holiday", 0);
      }

      if(isDefined(level.playersetomnvarkeypad)) {
        level.ref_13b60 = 1;
      }

      break;
    case "squad_lobby_detail":
      var1 = level.camera_lobby_detail;
      var1 = level.camera_lobby_detail.basecam;

      if(level.ref_13370 && isDefined(level.playersetomnvarattraction)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_lobby_s4_mid", 0);
      }

      if(level.ref_13370 && isDefined(level.playershooting)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_lobby_s8b", 0);
      }

      if(level.ref_13370 && isDefined(level.playershowskippromptcinematic)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_lobby_s9_fog", 0);
      }

      if(level.ref_13370 && isDefined(level.playersetkeypadstateindex)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend12_halloween", 0);
      }

      if(level.ref_13370 && isDefined(level.playersleftloop)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontendc3s1_lobby_holiday", 0);
      }

      if(isDefined(level.playersetomnvarkeypad)) {
        level.ref_13b60 = 1;
      }

      break;
    case "character_tango":
      var1 = level.camera_character_tango;
      var1 = level.camera_character_tango.basecam;
      break;
    case "quartermaster":
      var1 = level.camera_quartermaster;
      var1 = level.camera_quartermaster.basecam;
      break;
    case "quartermaster_detail":
      var1 = level.camera_quartermaster_detail;
      var1 = level.camera_quartermaster_detail.basecam;
      break;
    case "character_faction_select_l":
      var1 = level.camera_character_faction_select_l;
      var1 = level.camera_character_faction_select_l.basecam;
      break;
    case "character_faction_select_l_detail":
      var1 = level.camera_character_faction_select_l_detail;
      var1 = level.camera_character_faction_select_l_detail.basecam;
      break;
    case "character_preview_select":
      var1 = level.gamemodemolotovfunc;
      var1 = level.gamemodemolotovfunc.basecam;
      break;
    case "character_preview_select_detail":
      var1 = level.gamemodeoverridemeleeviewkickscale;
      var1 = level.gamemodeoverridemeleeviewkickscale.basecam;
      break;
    case "character_faction_select_r":
      var1 = level.camera_character_faction_select_r;
      var1 = level.camera_character_faction_select_r.basecam;
      break;
    case "character_faction_select_r_detail":
      var1 = level.camera_character_faction_select_r_detail;
      var1 = level.camera_character_faction_select_r_detail.basecam;
      break;
    case "character_tournaments":
      var1 = level.camera_character_tournaments;
      var1 = level.camera_character_tournaments.basecam;

      if(level.ref_13370 && isDefined(level.playersetomnvarattraction)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_lobby_s4_mid", 0);
      }

      if(isDefined(level.playersetomnvarkeypad)) {
        level.ref_13b60 = 1;
      }

      break;
    case "character_gamebattles":
      var1 = level.gameisending;
      var1 = level.gameisending.basecam;

      if(level.ref_13370 && isDefined(level.playersetomnvarattraction)) {
        level.playerviewowner visionsetnakedforplayer("mp_frontend_lobby_s4_mid", 0);
      }

      if(isDefined(level.playersetomnvarkeypad)) {
        level.ref_13b60 = 1;
      }

      break;
    case "loadout_showcase_overview":
      var1 = level.camera_loadout_showcase_overview;
      var1 = level.camera_loadout_showcase_overview.basecam;
      break;
    case "loadout_showcase_preview":
      var1 = level.camera_loadout_showcase_preview;
      var1 = level.camera_loadout_showcase_preview.basecam;
      ref_12a0d("medium");
      break;
    case "loadout_showcase_preview_large":
      var1 = level.camera_loadout_showcase_preview_large;
      var1 = level.camera_loadout_showcase_preview_large.basecam;
      ref_12a0d("large");
      break;
    case "loadout_showcase_preview_small":
      var1 = level.camera_loadout_showcase_preview_small;
      var1 = level.camera_loadout_showcase_preview_small.basecam;
      ref_12a0d("small");
      break;
    case "loadout_showcase_preview_riot":
      var1 = level.camera_loadout_showcase_preview_riot;
      var1 = level.camera_loadout_showcase_preview_riot.basecam;
      break;
    case "loadout_showcase_preview_watch":
      var1 = level.camera_loadout_showcase_preview_watch;
      var1 = level.camera_loadout_showcase_preview_watch.basecam;
      ref_12a0d("watch");
      break;
    case "loadout_showcase_preview_barrel":
      var1 = level.camera_loadout_showcase_preview_barrel;
      var1 = level.camera_loadout_showcase_preview_barrel.basecam;
      break;
    case "loadout_showcase_preview_barrel_alt1":
      var1 = level.camera_loadout_showcase_preview_barrel_alt1;
      var1 = level.camera_loadout_showcase_preview_barrel_alt1.basecam;
      break;
    case "loadout_showcase_preview_barrel_alt2":
      var1 = level.gameplay_main;
      var1 = level.gameplay_main.basecam;
      break;
    case "loadout_showcase_preview_charm":
      var1 = level.camera_loadout_showcase_preview_charm;
      var1 = level.camera_loadout_showcase_preview_charm.basecam;
      break;
    case "loadout_showcase_preview_charm_alt1":
      var1 = level.camera_loadout_showcase_preview_charm_alt1;
      var1 = level.camera_loadout_showcase_preview_charm_alt1.basecam;
      break;
    case "loadout_showcase_preview_charm_alt2":
      var1 = level.camera_loadout_showcase_preview_charm_alt2;
      var1 = level.camera_loadout_showcase_preview_charm_alt2.basecam;
      break;
    case "loadout_showcase_preview_charm_alt3":
      var1 = level.camera_loadout_showcase_preview_charm_alt3;
      var1 = level.camera_loadout_showcase_preview_charm_alt3.basecam;
      break;
    case "loadout_showcase_preview_charm_alt4":
      var1 = level.gameskill_init;
      var1 = level.gameskill_init.basecam;
      break;
    case "loadout_showcase_preview_charm_alt5":
      var1 = level.gameskill_set_player;
      var1 = level.gameskill_set_player.basecam;
      break;
    case "loadout_showcase_preview_charm_alt6":
      var1 = level.gamestatedisplaymonitor;
      var1 = level.gamestatedisplaymonitor.basecam;
      break;
    case "loadout_showcase_preview_small_charm_alt1":
      var1 = level.gas_badplace;
      var1 = level.gas_badplace.basecam;
      break;
    case "loadout_showcase_preview_laser":
      var1 = level.camera_loadout_showcase_preview_laser;
      var1 = level.camera_loadout_showcase_preview_laser.basecam;
      break;
    case "loadout_showcase_preview_laser_alt1":
      var1 = level.camera_loadout_showcase_preview_laser_alt1;
      var1 = level.camera_loadout_showcase_preview_laser_alt1.basecam;
      break;
    case "loadout_showcase_preview_laser_alt2":
      var1 = level.camera_loadout_showcase_preview_laser_alt2;
      var1 = level.camera_loadout_showcase_preview_laser_alt2.basecam;
      break;
    case "loadout_showcase_preview_magazine":
      var1 = level.camera_loadout_showcase_preview_magazine;
      var1 = level.camera_loadout_showcase_preview_magazine.basecam;
      break;
    case "loadout_showcase_preview_magazine_alt1":
      var1 = level.camera_loadout_showcase_preview_magazine_alt1;
      var1 = level.camera_loadout_showcase_preview_magazine_alt1.basecam;
      break;
    case "loadout_showcase_preview_magazine_alt2":
      var1 = level.camera_loadout_showcase_preview_magazine_alt2;
      var1 = level.camera_loadout_showcase_preview_magazine_alt2.basecam;
      break;
    case "loadout_showcase_preview_muzzle":
      var1 = level.camera_loadout_showcase_preview_muzzle;
      var1 = level.camera_loadout_showcase_preview_muzzle.basecam;
      break;
    case "loadout_showcase_preview_muzzle_alt1":
      var1 = level.camera_loadout_showcase_preview_muzzle_alt1;
      var1 = level.camera_loadout_showcase_preview_muzzle_alt1.basecam;
      break;
    case "loadout_showcase_preview_optic":
      var1 = level.camera_loadout_showcase_preview_optic;
      var1 = level.camera_loadout_showcase_preview_optic.basecam;
      break;
    case "loadout_showcase_preview_optic_alt1":
      var1 = level.camera_loadout_showcase_preview_optic_alt1;
      var1 = level.camera_loadout_showcase_preview_optic_alt1.basecam;
      break;
    case "loadout_showcase_preview_reargrip":
      var1 = level.camera_loadout_showcase_preview_reargrip;
      var1 = level.camera_loadout_showcase_preview_reargrip.basecam;
      break;
    case "loadout_showcase_preview_reargrip_alt1":
      var1 = level.camera_loadout_showcase_preview_reargrip_alt1;
      var1 = level.camera_loadout_showcase_preview_reargrip_alt1.basecam;
      break;
    case "loadout_showcase_preview_reargrip_alt2":
      var1 = level.camera_loadout_showcase_preview_reargrip_alt2;
      var1 = level.camera_loadout_showcase_preview_reargrip_alt2.basecam;
      break;
    case "loadout_showcase_preview_sticker":
      var1 = level.gas_fx;
      var1 = level.gas_fx.basecam;
      break;
    case "loadout_showcase_preview_sticker_alt1":
      var1 = level.gas_linger_large_vfx;
      var1 = level.gas_linger_large_vfx.basecam;
      break;
    case "loadout_showcase_preview_sticker_alt2":
      var1 = level.gas_linger_vfx;
      var1 = level.gas_linger_vfx.basecam;
      break;
    case "loadout_showcase_preview_sticker_alt3":
      var1 = level.gas_payloads;
      var1 = level.gas_payloads.basecam;
      break;
    case "loadout_showcase_preview_sticker_alt4":
      var1 = level.gas_sequence_activated;
      var1 = level.gas_sequence_activated.basecam;
      break;
    case "loadout_showcase_preview_stock":
      var1 = level.camera_loadout_showcase_preview_stock;
      var1 = level.camera_loadout_showcase_preview_stock.basecam;
      break;
    case "loadout_showcase_preview_stock_alt1":
      var1 = level.camera_loadout_showcase_preview_stock_alt1;
      var1 = level.camera_loadout_showcase_preview_stock_alt1.basecam;
      break;
    case "loadout_showcase_preview_stock_alt2":
      var1 = level.camera_loadout_showcase_preview_stock_alt2;
      var1 = level.camera_loadout_showcase_preview_stock_alt2.basecam;
      break;
    case "loadout_showcase_preview_underbarrel":
      var1 = level.camera_loadout_showcase_preview_underbarrel;
      var1 = level.camera_loadout_showcase_preview_underbarrel.basecam;
      break;
    case "loadout_showcase_preview_large_barrel":
      var1 = level.camera_loadout_showcase_preview_large_barrel;
      var1 = level.camera_loadout_showcase_preview_large_barrel.basecam;
      break;
    case "loadout_showcase_preview_large_barrel_alt1":
      var1 = level.camera_loadout_showcase_preview_large_barrel_alt1;
      var1 = level.camera_loadout_showcase_preview_large_barrel_alt1.basecam;
      break;
    case "loadout_showcase_preview_large_charm":
      var1 = level.camera_loadout_showcase_preview_large_charm;
      var1 = level.camera_loadout_showcase_preview_large_charm.basecam;
      break;
    case "loadout_showcase_preview_large_charm_alt1":
      var1 = level.camera_loadout_showcase_preview_large_charm_alt1;
      var1 = level.camera_loadout_showcase_preview_large_charm_alt1.basecam;
      break;
    case "loadout_showcase_preview_large_charm_alt2":
      var1 = level.camera_loadout_showcase_preview_large_charm_alt2;
      var1 = level.camera_loadout_showcase_preview_large_charm_alt2.basecam;
      break;
    case "loadout_showcase_preview_large_charm_alt3":
      var1 = level.gametypefilter;
      var1 = level.gametypefilter.basecam;
      break;
    case "loadout_showcase_preview_large_charm_alt4":
      var1 = level.gametypekillsperhouravg;
      var1 = level.gametypekillsperhouravg.basecam;
      break;
    case "loadout_showcase_preview_large_charm_alt5":
      var1 = level.gametypekillspermatchmax;
      var1 = level.gametypekillspermatchmax.basecam;
      break;
    case "loadout_showcase_preview_large_charm_alt6":
      var1 = level.gametypeoverrideassassinsearchparams;
      var1 = level.gametypeoverrideassassinsearchparams.basecam;
      break;
    case "loadout_showcase_preview_large_laser":
      var1 = level.camera_loadout_showcase_preview_large_laser;
      var1 = level.camera_loadout_showcase_preview_large_laser.basecam;
      break;
    case "loadout_showcase_preview_large_laser_alt1":
      var1 = level.gametypeoverridedomsearchparams;
      var1 = level.gametypeoverridedomsearchparams.basecam;
      break;
    case "loadout_showcase_preview_large_magazine":
      var1 = level.camera_loadout_showcase_preview_large_magazine;
      var1 = level.camera_loadout_showcase_preview_large_magazine.basecam;
      break;
    case "loadout_showcase_preview_large_magazine_alt1":
      var1 = level.camera_loadout_showcase_preview_large_magazine_alt1;
      var1 = level.camera_loadout_showcase_preview_large_magazine_alt1.basecam;
      break;
    case "loadout_showcase_preview_large_magazine_alt2":
      var1 = level.camera_loadout_showcase_preview_large_magazine_alt2;
      var1 = level.camera_loadout_showcase_preview_large_magazine_alt2.basecam;
      break;
    case "loadout_showcase_preview_large_muzzle":
      var1 = level.camera_loadout_showcase_preview_large_muzzle;
      var1 = level.camera_loadout_showcase_preview_large_muzzle.basecam;
      break;
    case "loadout_showcase_preview_large_muzzle_alt1":
      var1 = level.camera_loadout_showcase_preview_large_muzzle_alt1;
      var1 = level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam;
      break;
    case "loadout_showcase_preview_large_optic":
      var1 = level.camera_loadout_showcase_preview_large_optic;
      var1 = level.camera_loadout_showcase_preview_large_optic.basecam;
      break;
    case "loadout_showcase_preview_large_optic_alt1":
      var1 = level.gametypeoverridescavsearchparams;
      var1 = level.gametypeoverridescavsearchparams.basecam;
      break;
    case "loadout_showcase_preview_large_optic_alt2":
      var1 = level.gametyperoundendscoresetomnvar;
      var1 = level.gametyperoundendscoresetomnvar.basecam;
      break;
    case "loadout_showcase_preview_large_reargrip":
      var1 = level.camera_loadout_showcase_preview_large_reargrip;
      var1 = level.camera_loadout_showcase_preview_large_reargrip.basecam;
      break;
    case "loadout_showcase_preview_large_reargrip_alt1":
      var1 = level.camera_loadout_showcase_preview_large_reargrip_alt1;
      var1 = level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam;
      break;
    case "loadout_showcase_preview_large_sticker":
      var1 = level.gametypeweaponxpmodifier;
      var1 = level.gametypeweaponxpmodifier.basecam;
      break;
    case "loadout_showcase_preview_large_sticker_alt1":
      var1 = level.garbage_bin_clip;
      var1 = level.garbage_bin_clip.basecam;
      break;
    case "loadout_showcase_preview_large_sticker_alt2":
      var1 = level.gas_at_computer;
      var1 = level.gas_at_computer.basecam;
      break;
    case "loadout_showcase_preview_large_sticker_alt3":
      var1 = level.gas_attack;
      var1 = level.gas_attack.basecam;
      break;
    case "loadout_showcase_preview_large_stock":
      var1 = level.camera_loadout_showcase_preview_large_stock;
      var1 = level.camera_loadout_showcase_preview_large_stock.basecam;
      break;
    case "loadout_showcase_preview_large_stock_alt1":
      var1 = level.gas_attack_deploy;
      var1 = level.gas_attack_deploy.basecam;
      break;
    case "loadout_showcase_preview_large_underbarrel":
      var1 = level.camera_loadout_showcase_preview_large_underbarrel;
      var1 = level.camera_loadout_showcase_preview_large_underbarrel.basecam;
      break;
    case "loadout_showcase_preview_large_underbarrel_alt1":
      var1 = level.camera_loadout_showcase_preview_large_underbarrel_alt1;
      var1 = level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam;
      break;
    case "loadout_showcase_preview_small_barrel":
      var1 = level.camera_loadout_showcase_preview_small_barrel;
      var1 = level.camera_loadout_showcase_preview_small_barrel.basecam;
      break;
    case "loadout_showcase_preview_small_charm":
      var1 = level.camera_loadout_showcase_preview_small_charm;
      var1 = level.camera_loadout_showcase_preview_small_charm.basecam;
      break;
    case "loadout_showcase_preview_small_laser":
      var1 = level.camera_loadout_showcase_preview_small_laser;
      var1 = level.camera_loadout_showcase_preview_small_laser.basecam;
      break;
    case "loadout_showcase_preview_small_laser_alt1":
      var1 = level.gas_cloud_vfx;
      var1 = level.gas_cloud_vfx.basecam;
      break;
    case "loadout_showcase_preview_small_magazine":
      var1 = level.camera_loadout_showcase_preview_small_magazine;
      var1 = level.camera_loadout_showcase_preview_small_magazine.basecam;
      break;
    case "loadout_showcase_preview_small_magazine_alt1":
      var1 = level.camera_loadout_showcase_preview_small_magazine_alt1;
      var1 = level.camera_loadout_showcase_preview_small_magazine_alt1.basecam;
      break;
    case "loadout_showcase_preview_small_muzzle":
      var1 = level.camera_loadout_showcase_preview_small_muzzle;
      var1 = level.camera_loadout_showcase_preview_small_muzzle.basecam;
      break;
    case "loadout_showcase_preview_small_optic":
      var1 = level.camera_loadout_showcase_preview_small_optic;
      var1 = level.camera_loadout_showcase_preview_small_optic.basecam;
      break;
    case "loadout_showcase_preview_small_reargrip":
      var1 = level.camera_loadout_showcase_preview_small_reargrip;
      var1 = level.camera_loadout_showcase_preview_small_reargrip.basecam;
      break;
    case "loadout_showcase_preview_small_reargrip_alt1":
      var1 = level.gas_emit_vfx;
      var1 = level.gas_emit_vfx.basecam;
      break;
    case "loadout_showcase_preview_small_sticker":
      var1 = level.gas_flyby_plane;
      var1 = level.gas_flyby_plane.basecam;
      break;
    case "loadout_showcase_preview_small_stock":
      var1 = level.camera_loadout_showcase_preview_small_stock;
      var1 = level.camera_loadout_showcase_preview_small_stock.basecam;
      break;
    case "loadout_showcase_preview_small_trigger":
      var1 = level.camera_loadout_showcase_preview_small_trigger;
      var1 = level.camera_loadout_showcase_preview_small_trigger.basecam;
      break;
    case "loadout_showcase":
      var1 = level.camera_loadout_showcase;
      var1 = level.camera_loadout_showcase.basecam;
      break;
    case "loadout_showcase_armory":
      var1 = level.gamemodespawnprotectedcallback;
      var1 = level.gamemodespawnprotectedcallback.basecam;
      break;
    case "loadout_showcase_p":
      var1 = level.camera_loadout_showcase_p;
      var1 = level.camera_loadout_showcase_p.basecam;
      break;
    case "loadout_showcase_p_large":
      var1 = level.camera_loadout_showcase_p_large;
      var1 = level.camera_loadout_showcase_p_large.basecam;
      break;
    case "loadout_showcase_s":
      var1 = level.camera_loadout_showcase_s;
      var1 = level.camera_loadout_showcase_s.basecam;
      break;
    case "loadout_showcase_o":
      var1 = level.camera_loadout_showcase_o;
      var1 = level.camera_loadout_showcase_o.basecam;
      break;
    case "loadout_showcase_o_large":
      var1 = level.camera_loadout_showcase_o_large;
      var1 = level.camera_loadout_showcase_o_large.basecam;
      break;
    case "loadout_showcase_l":
      var1 = level.camera_loadout_showcase_l;
      var1 = level.camera_loadout_showcase_l.basecam;
      break;
    case "loadout_showcase_t":
      var1 = level.camera_loadout_showcase_t;
      var1 = level.camera_loadout_showcase_t.basecam;
      break;
    case "loadout_showcase_perks":
      var1 = level.camera_loadout_showcase_perks;
      var1 = level.camera_loadout_showcase_perks.basecam;
      break;
    case "loadout_showcase_x":
      var1 = level.camera_loadout_showcase_x;
      var1 = level.camera_loadout_showcase_x.basecam;
      break;
    case "loadout_showcase_y":
      var1 = level.camera_loadout_showcase_y;
      var1 = level.camera_loadout_showcase_y.basecam;
      break;
    case "loadout_showcase_z":
      var1 = level.camera_loadout_showcase_z;
      var1 = level.camera_loadout_showcase_z.basecam;
      break;
    case "loadout_showcase_specialist":
      var1 = level.camera_loadout_showcase_specialist;
      var1 = level.camera_loadout_showcase_specialist.basecam;
      break;
    case "loadout_showcase_watch":
      var1 = level.camera_loadout_showcase_watch;
      var1 = level.camera_loadout_showcase_watch.basecam;
      break;
    case "weapon_showcase":
      var1 = level.camera_ui_bg_01;
      var1 = level.camera_ui_bg_01.basecam;
      break;
    case "barracks":
      var3 = scripts\engine\utility::ter_op(var2, level.camera_ui_bg_01, level.active_scene_data);
      var1 = level.camera_ui_bg_01;
      var1 = level.camera_ui_bg_01.basecam;
      break;
    case "player_character_showcase":
      var1 = level.camera_ui_bg_01;
      var1 = level.camera_ui_bg_01.basecam;
      break;
    default:
      break;
  }

  return var1;
}

function create_camera_position_list() {
  level.camera_loadout_showcase = spawnStruct();
  level.camera_loadout_showcase.basecam = getEnt("camera_mp_gunsmith", "targetname");
  level.camera_loadout_showcase.basecam.depthoffieldvalues = [2, 100];
  level.camera_loadout_showcase.myfov = 36;
  level.camera_loadout_showcase.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase.ref_1370f = 6;
  level.camera_loadout_showcase_overview = spawnStruct();
  level.camera_loadout_showcase_overview.basecam = getEnt("camera_mp_gunsmith_overview", "targetname");
  level.camera_loadout_showcase_overview.basecam.depthoffieldvalues = [3, 85];
  level.camera_loadout_showcase_overview.myfov = 28;
  level.camera_loadout_showcase_overview.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_overview.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_overview.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_overview.ref_1370f = 6;
  level.camera_loadout_showcase_preview = spawnStruct();
  level.camera_loadout_showcase_preview.basecam = getEnt("camera_mp_gunsmith_preview", "targetname");
  level.camera_loadout_showcase_preview.basecam.depthoffieldvalues = [22, 56];
  level.camera_loadout_showcase_preview.myfov = 36;
  level.camera_loadout_showcase_preview.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large = spawnStruct();
  level.camera_loadout_showcase_preview_large.basecam = getEnt("camera_mp_gunsmith_preview_large", "targetname");
  level.camera_loadout_showcase_preview_large.basecam.depthoffieldvalues = [22, 64];
  level.camera_loadout_showcase_preview_large.myfov = 36;
  level.camera_loadout_showcase_preview_large.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small = spawnStruct();
  level.camera_loadout_showcase_preview_small.basecam = getEnt("camera_mp_gunsmith_preview_secondary", "targetname");
  level.camera_loadout_showcase_preview_small.basecam.depthoffieldvalues = [22, 36];
  level.camera_loadout_showcase_preview_small.myfov = 36;
  level.camera_loadout_showcase_preview_small.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small.ref_1370f = 6;
  level.camera_loadout_showcase_preview_watch = spawnStruct();
  level.camera_loadout_showcase_preview_watch.basecam = getEnt("camera_mp_gunsmith_preview_watch", "targetname");
  level.camera_loadout_showcase_preview_watch.basecam.depthoffieldvalues = [20, 16];
  level.camera_loadout_showcase_preview_watch.myfov = 36;
  level.camera_loadout_showcase_preview_watch.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_watch.ref_1370f = 6;
  level.gamemodespawnprotectedcallback = spawnStruct();
  level.gamemodespawnprotectedcallback.basecam = getEnt("camera_mp_gunsmith_armory", "targetname");
  level.gamemodespawnprotectedcallback.basecam.depthoffieldvalues = [7, 67];
  level.gamemodespawnprotectedcallback.myfov = 44;
  level.gamemodespawnprotectedcallback.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.gamemodespawnprotectedcallback.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.gamemodespawnprotectedcallback.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.gamemodespawnprotectedcallback.ref_1370f = 6;
  level.camera_loadout_showcase_p = spawnStruct();
  level.camera_loadout_showcase_p.basecam = getEnt("camera_mp_gunsmith_alt_p_large", "targetname");
  level.camera_loadout_showcase_p.basecam.depthoffieldvalues = [7, 38];
  level.camera_loadout_showcase_p.myfov = 55;
  level.camera_loadout_showcase_p.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_p.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_p.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_p.ref_1370f = 6;
  level.camera_loadout_showcase_p_large = spawnStruct();
  level.camera_loadout_showcase_p_large.basecam = getEnt("camera_mp_gunsmith_alt_p_large", "targetname");
  level.camera_loadout_showcase_p_large.basecam.depthoffieldvalues = [7, 64];
  level.camera_loadout_showcase_p_large.myfov = 55;
  level.camera_loadout_showcase_p_large.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_p_large.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_p_large.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_p_large.ref_1370f = 6;
  level.camera_loadout_showcase_s = spawnStruct();
  level.camera_loadout_showcase_s.basecam = getEnt("camera_mp_gunsmith_alt_s", "targetname");
  level.camera_loadout_showcase_s.basecam.depthoffieldvalues = [12, 22];
  level.camera_loadout_showcase_s.myfov = 55;
  level.camera_loadout_showcase_s.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_s.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_s.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_s.ref_1370f = 6;
  level.camera_loadout_showcase_o = spawnStruct();
  level.camera_loadout_showcase_o.basecam = getEnt("camera_mp_gunsmith_alt_o_large", "targetname");
  level.camera_loadout_showcase_o.basecam.depthoffieldvalues = [14, 38];
  level.camera_loadout_showcase_o.myfov = 55;
  level.camera_loadout_showcase_o.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_o.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_o.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_o.ref_1370f = 6;
  level.camera_loadout_showcase_o_large = spawnStruct();
  level.camera_loadout_showcase_o_large.basecam = getEnt("camera_mp_gunsmith_alt_o_large", "targetname");
  level.camera_loadout_showcase_o_large.basecam.depthoffieldvalues = [14, 65];
  level.camera_loadout_showcase_o_large.myfov = 55;
  level.camera_loadout_showcase_o_large.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_o_large.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_o_large.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_o_large.ref_1370f = 6;
  level.camera_loadout_showcase_l = spawnStruct();
  level.camera_loadout_showcase_l.basecam = getEnt("camera_mp_gunsmith_alt_l", "targetname");
  level.camera_loadout_showcase_l.basecam.depthoffieldvalues = [9, 23];
  level.camera_loadout_showcase_l.myfov = 55;
  level.camera_loadout_showcase_l.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_l.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_l.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_l.ref_1370f = 6;
  level.camera_loadout_showcase_t = spawnStruct();
  level.camera_loadout_showcase_t.basecam = getEnt("camera_mp_gunsmith_alt_t", "targetname");
  level.camera_loadout_showcase_t.basecam.depthoffieldvalues = [13, 18];
  level.camera_loadout_showcase_t.myfov = 55;
  level.camera_loadout_showcase_t.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_t.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_t.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_t.ref_1370f = 6;
  level.camera_loadout_showcase_perks = spawnStruct();
  level.camera_loadout_showcase_perks.basecam = getEnt("camera_mp_gunsmith_alt_perks", "targetname");
  level.camera_loadout_showcase_perks.basecam.depthoffieldvalues = [14, 25];
  level.camera_loadout_showcase_perks.myfov = 55;
  level.camera_loadout_showcase_perks.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_perks.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_perks.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_perks.ref_1370f = 6;
  level.camera_loadout_showcase_x = spawnStruct();
  level.camera_loadout_showcase_x.basecam = getEnt("camera_mp_gunsmith_alt_x", "targetname");
  level.camera_loadout_showcase_x.basecam.depthoffieldvalues = [16, 16];
  level.camera_loadout_showcase_x.myfov = 55;
  level.camera_loadout_showcase_x.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_x.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_x.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_x.ref_1370f = 6;
  level.camera_loadout_showcase_y = spawnStruct();
  level.camera_loadout_showcase_y.basecam = getEnt("camera_mp_gunsmith_alt_y", "targetname");
  level.camera_loadout_showcase_y.basecam.depthoffieldvalues = [16, 16];
  level.camera_loadout_showcase_y.myfov = 55;
  level.camera_loadout_showcase_y.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_y.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_y.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_y.ref_1370f = 6;
  level.camera_loadout_showcase_z = spawnStruct();
  level.camera_loadout_showcase_z.basecam = getEnt("camera_mp_gunsmith_alt_z", "targetname");
  level.camera_loadout_showcase_z.basecam.depthoffieldvalues = [16, 16];
  level.camera_loadout_showcase_z.myfov = 55;
  level.camera_loadout_showcase_z.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_z.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_z.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_z.ref_1370f = 6;
  level.camera_loadout_showcase_specialist = spawnStruct();
  level.camera_loadout_showcase_specialist.basecam = getEnt("camera_mp_gunsmith_alt_specialist", "targetname");
  level.camera_loadout_showcase_specialist.basecam.depthoffieldvalues = [22, 16];
  level.camera_loadout_showcase_specialist.myfov = 55;
  level.camera_loadout_showcase_specialist.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_specialist.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_specialist.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_specialist.ref_1370f = 6;
  level.camera_loadout_showcase_watch = spawnStruct();
  level.camera_loadout_showcase_watch.basecam = getEnt("camera_mp_gunsmith_alt_watch", "targetname");
  level.camera_loadout_showcase_watch.basecam.depthoffieldvalues = [22, 8];
  level.camera_loadout_showcase_watch.myfov = 55;
  level.camera_loadout_showcase_watch.weapon_locs[0] = getEnt("weapon_loc_hq1", "targetname");
  level.camera_loadout_showcase_watch.weapon_locs[1] = getEnt("weapon_loc_hq2", "targetname");
  level.camera_loadout_showcase_watch.weapon_locs[3] = getEnt("weapon_loc_watch", "targetname");
  level.camera_loadout_showcase_watch.ref_1370f = 6;
  level.camera_loadout_showcase_preview_riot = spawnStruct();
  level.camera_loadout_showcase_preview_riot.basecam = getEnt("camera_mp_gunsmith_preview_riot", "targetname");
  level.camera_loadout_showcase_preview_riot.basecam.depthoffieldvalues = [16, 152];
  level.camera_loadout_showcase_preview_riot.myfov = 36;
  level.camera_loadout_showcase_preview_riot.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_riot.ref_1370f = 6;
  level.camera_loadout_showcase_preview_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_barrel.basecam = getEnt("camera_mp_gunsmith_preview_barrel", "targetname");
  level.camera_loadout_showcase_preview_barrel.basecam.depthoffieldvalues = [8, 34];
  level.camera_loadout_showcase_preview_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_barrel.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_barrel.ref_1370f = 6;
  level.camera_loadout_showcase_preview_barrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_barrel_alt1.basecam = getEnt("camera_mp_gunsmith_preview_barrel_alt1", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt1.basecam.depthoffieldvalues = [8, 48];
  level.camera_loadout_showcase_preview_barrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_barrel_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_barrel_alt1.ref_1370f = 6;
  level.gameplay_main = spawnStruct();
  level.gameplay_main.basecam = getEnt("camera_mp_gunsmith_preview_barrel_alt2", "targetname");
  level.gameplay_main.basecam.depthoffieldvalues = [8, 54];
  level.gameplay_main.myfov = 36;
  level.gameplay_main.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gameplay_main.ref_1370f = 6;
  level.camera_loadout_showcase_preview_charm = spawnStruct();
  level.camera_loadout_showcase_preview_charm.basecam = getEnt("camera_mp_gunsmith_preview_charm", "targetname");
  level.camera_loadout_showcase_preview_charm.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm.myfov = 36;
  level.camera_loadout_showcase_preview_charm.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_charm.ref_1370f = 6;
  level.camera_loadout_showcase_preview_charm_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt1.basecam = getEnt("camera_mp_gunsmith_preview_charm_alt1", "targetname");
  level.camera_loadout_showcase_preview_charm_alt1.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_charm_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_charm_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt2.basecam = getEnt("camera_mp_gunsmith_preview_charm_alt2", "targetname");
  level.camera_loadout_showcase_preview_charm_alt2.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_charm_alt2.ref_1370f = 6;
  level.camera_loadout_showcase_preview_charm_alt3 = spawnStruct();
  level.camera_loadout_showcase_preview_charm_alt3.basecam = getEnt("camera_mp_gunsmith_preview_charm_alt3", "targetname");
  level.camera_loadout_showcase_preview_charm_alt3.basecam.depthoffieldvalues = [21, 16];
  level.camera_loadout_showcase_preview_charm_alt3.myfov = 36;
  level.camera_loadout_showcase_preview_charm_alt3.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_charm_alt3.ref_1370f = 6;
  level.gameskill_init = spawnStruct();
  level.gameskill_init.basecam = getEnt("camera_mp_gunsmith_preview_charm_alt4", "targetname");
  level.gameskill_init.basecam.depthoffieldvalues = [21, 18];
  level.gameskill_init.myfov = 36;
  level.gameskill_init.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gameskill_init.ref_1370f = 6;
  level.gameskill_set_player = spawnStruct();
  level.gameskill_set_player.basecam = getEnt("camera_mp_gunsmith_preview_charm_alt5", "targetname");
  level.gameskill_set_player.basecam.depthoffieldvalues = [22, 18];
  level.gameskill_set_player.myfov = 36;
  level.gameskill_set_player.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gameskill_set_player.ref_1370f = 6;
  level.gamestatedisplaymonitor = spawnStruct();
  level.gamestatedisplaymonitor.basecam = getEnt("camera_mp_gunsmith_preview_charm_alt6", "targetname");
  level.gamestatedisplaymonitor.basecam.depthoffieldvalues = [21, 16];
  level.gamestatedisplaymonitor.myfov = 36;
  level.gamestatedisplaymonitor.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gamestatedisplaymonitor.ref_1370f = 6;
  level.camera_loadout_showcase_preview_laser = spawnStruct();
  level.camera_loadout_showcase_preview_laser.basecam = getEnt("camera_mp_gunsmith_preview_laser", "targetname");
  level.camera_loadout_showcase_preview_laser.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser.myfov = 36;
  level.camera_loadout_showcase_preview_laser.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_laser.ref_1370f = 6;
  level.camera_loadout_showcase_preview_laser_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_laser_alt1.basecam = getEnt("camera_mp_gunsmith_preview_laser_alt1", "targetname");
  level.camera_loadout_showcase_preview_laser_alt1.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_laser_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_laser_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_laser_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_laser_alt2.basecam = getEnt("camera_mp_gunsmith_preview_laser_alt2", "targetname");
  level.camera_loadout_showcase_preview_laser_alt2.basecam.depthoffieldvalues = [8, 25];
  level.camera_loadout_showcase_preview_laser_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_laser_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_laser_alt2.ref_1370f = 6;
  level.camera_loadout_showcase_preview_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_magazine.basecam = getEnt("camera_mp_gunsmith_preview_magazine", "targetname");
  level.camera_loadout_showcase_preview_magazine.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_magazine.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine.ref_1370f = 6;
  level.camera_loadout_showcase_preview_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt1.basecam = getEnt("camera_mp_gunsmith_preview_magazine_alt1", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt1.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_magazine_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_magazine_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_magazine_alt2.basecam = getEnt("camera_mp_gunsmith_preview_magazine_alt2", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt2.basecam.depthoffieldvalues = [8, 24];
  level.camera_loadout_showcase_preview_magazine_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_magazine_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_magazine_alt2.ref_1370f = 6;
  level.camera_loadout_showcase_preview_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_muzzle.basecam = getEnt("camera_mp_gunsmith_preview_muzzle", "targetname");
  level.camera_loadout_showcase_preview_muzzle.basecam.depthoffieldvalues = [12, 30];
  level.camera_loadout_showcase_preview_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_muzzle.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_muzzle.ref_1370f = 6;
  level.camera_loadout_showcase_preview_muzzle_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_muzzle_alt1.basecam = getEnt("camera_mp_gunsmith_preview_muzzle_alt1", "targetname");
  level.camera_loadout_showcase_preview_muzzle_alt1.basecam.depthoffieldvalues = [18, 32];
  level.camera_loadout_showcase_preview_muzzle_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_muzzle_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_muzzle_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_optic = spawnStruct();
  level.camera_loadout_showcase_preview_optic.basecam = getEnt("camera_mp_gunsmith_preview_optic", "targetname");
  level.camera_loadout_showcase_preview_optic.basecam.depthoffieldvalues = [21.5, 17];
  level.camera_loadout_showcase_preview_optic.myfov = 36;
  level.camera_loadout_showcase_preview_optic.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_optic.ref_1370f = 6;
  level.camera_loadout_showcase_preview_optic_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_optic_alt1.basecam = getEnt("camera_mp_gunsmith_preview_optic_alt1", "targetname");
  level.camera_loadout_showcase_preview_optic_alt1.basecam.depthoffieldvalues = [21.5, 17];
  level.camera_loadout_showcase_preview_optic_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_optic_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_optic_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip.basecam = getEnt("camera_mp_gunsmith_preview_reargrip", "targetname");
  level.camera_loadout_showcase_preview_reargrip.basecam.depthoffieldvalues = [8, 20];
  level.camera_loadout_showcase_preview_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_reargrip.ref_1370f = 6;
  level.camera_loadout_showcase_preview_reargrip_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip_alt1.basecam = getEnt("camera_mp_gunsmith_preview_reargrip_alt1", "targetname");
  level.camera_loadout_showcase_preview_reargrip_alt1.basecam.depthoffieldvalues = [8, 20];
  level.camera_loadout_showcase_preview_reargrip_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_reargrip_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_reargrip_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_reargrip_alt2.basecam = getEnt("camera_mp_gunsmith_preview_reargrip_alt2", "targetname");
  level.camera_loadout_showcase_preview_reargrip_alt2.basecam.depthoffieldvalues = [12, 22];
  level.camera_loadout_showcase_preview_reargrip_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_reargrip_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_reargrip_alt2.ref_1370f = 6;
  level.gas_fx = spawnStruct();
  level.gas_fx.basecam = getEnt("camera_mp_gunsmith_preview_sticker", "targetname");
  level.gas_fx.basecam.depthoffieldvalues = [20, 32];
  level.gas_fx.myfov = 36;
  level.gas_fx.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_fx.ref_1370f = 6;
  level.gas_linger_large_vfx = spawnStruct();
  level.gas_linger_large_vfx.basecam = getEnt("camera_mp_gunsmith_preview_sticker_alt1", "targetname");
  level.gas_linger_large_vfx.basecam.depthoffieldvalues = [20, 32];
  level.gas_linger_large_vfx.myfov = 36;
  level.gas_linger_large_vfx.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_linger_large_vfx.ref_1370f = 6;
  level.gas_linger_vfx = spawnStruct();
  level.gas_linger_vfx.basecam = getEnt("camera_mp_gunsmith_preview_sticker_alt2", "targetname");
  level.gas_linger_vfx.basecam.depthoffieldvalues = [20, 34];
  level.gas_linger_vfx.myfov = 36;
  level.gas_linger_vfx.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_linger_vfx.ref_1370f = 6;
  level.gas_payloads = spawnStruct();
  level.gas_payloads.basecam = getEnt("camera_mp_gunsmith_preview_sticker_alt3", "targetname");
  level.gas_payloads.basecam.depthoffieldvalues = [20, 34];
  level.gas_payloads.myfov = 36;
  level.gas_payloads.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_payloads.ref_1370f = 6;
  level.gas_sequence_activated = spawnStruct();
  level.gas_sequence_activated.basecam = getEnt("camera_mp_gunsmith_preview_sticker_alt4", "targetname");
  level.gas_sequence_activated.basecam.depthoffieldvalues = [20, 34];
  level.gas_sequence_activated.myfov = 36;
  level.gas_sequence_activated.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_sequence_activated.ref_1370f = 6;
  level.camera_loadout_showcase_preview_stock = spawnStruct();
  level.camera_loadout_showcase_preview_stock.basecam = getEnt("camera_mp_gunsmith_preview_stock", "targetname");
  level.camera_loadout_showcase_preview_stock.basecam.depthoffieldvalues = [12, 40];
  level.camera_loadout_showcase_preview_stock.myfov = 36;
  level.camera_loadout_showcase_preview_stock.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_stock.ref_1370f = 6;
  level.camera_loadout_showcase_preview_stock_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_stock_alt1.basecam = getEnt("camera_mp_gunsmith_preview_stock_alt1", "targetname");
  level.camera_loadout_showcase_preview_stock_alt1.basecam.depthoffieldvalues = [12, 40];
  level.camera_loadout_showcase_preview_stock_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_stock_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_stock_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_stock_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_stock_alt2.basecam = getEnt("camera_mp_gunsmith_preview_stock_alt2", "targetname");
  level.camera_loadout_showcase_preview_stock_alt2.basecam.depthoffieldvalues = [16, 43];
  level.camera_loadout_showcase_preview_stock_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_stock_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_stock_alt2.ref_1370f = 6;
  level.camera_loadout_showcase_preview_underbarrel = spawnStruct();
  level.camera_loadout_showcase_preview_underbarrel.basecam = getEnt("camera_mp_gunsmith_preview_underbarrel", "targetname");
  level.camera_loadout_showcase_preview_underbarrel.basecam.depthoffieldvalues = [10, 34];
  level.camera_loadout_showcase_preview_underbarrel.myfov = 36;
  level.camera_loadout_showcase_preview_underbarrel.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_underbarrel.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_small_barrel.basecam = getEnt("camera_mp_gunsmith_preview_small_barrel", "targetname");
  level.camera_loadout_showcase_preview_small_barrel.basecam.depthoffieldvalues = [12, 22.5];
  level.camera_loadout_showcase_preview_small_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_small_barrel.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_barrel.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small_charm = spawnStruct();
  level.camera_loadout_showcase_preview_small_charm.basecam = getEnt("camera_mp_gunsmith_preview_small_charm", "targetname");
  level.camera_loadout_showcase_preview_small_charm.basecam.depthoffieldvalues = [21, 15];
  level.camera_loadout_showcase_preview_small_charm.myfov = 36;
  level.camera_loadout_showcase_preview_small_charm.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_charm.ref_1370f = 6;
  level.gas_badplace = spawnStruct();
  level.gas_badplace.basecam = getEnt("camera_mp_gunsmith_preview_small_charm_alt1", "targetname");
  level.gas_badplace.basecam.depthoffieldvalues = [25, 19];
  level.gas_badplace.myfov = 36;
  level.gas_badplace.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_badplace.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small_laser = spawnStruct();
  level.camera_loadout_showcase_preview_small_laser.basecam = getEnt("camera_mp_gunsmith_preview_small_laser", "targetname");
  level.camera_loadout_showcase_preview_small_laser.basecam.depthoffieldvalues = [12, 19];
  level.camera_loadout_showcase_preview_small_laser.myfov = 36;
  level.camera_loadout_showcase_preview_small_laser.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_laser.ref_1370f = 6;
  level.gas_cloud_vfx = spawnStruct();
  level.gas_cloud_vfx.basecam = getEnt("camera_mp_gunsmith_preview_small_laser_alt1", "targetname");
  level.gas_cloud_vfx.basecam.depthoffieldvalues = [8, 25];
  level.gas_cloud_vfx.myfov = 36;
  level.gas_cloud_vfx.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_cloud_vfx.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine.basecam = getEnt("camera_mp_gunsmith_preview_small_magazine", "targetname");
  level.camera_loadout_showcase_preview_small_magazine.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_small_magazine.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_magazine.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_small_magazine_alt1.basecam = getEnt("camera_mp_gunsmith_preview_small_magazine_alt1", "targetname");
  level.camera_loadout_showcase_preview_small_magazine_alt1.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_small_magazine_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_magazine_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_small_muzzle.basecam = getEnt("camera_mp_gunsmith_preview_small_muzzle", "targetname");
  level.camera_loadout_showcase_preview_small_muzzle.basecam.depthoffieldvalues = [16, 25];
  level.camera_loadout_showcase_preview_small_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_small_muzzle.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_muzzle.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small_optic = spawnStruct();
  level.camera_loadout_showcase_preview_small_optic.basecam = getEnt("camera_mp_gunsmith_preview_small_optic", "targetname");
  level.camera_loadout_showcase_preview_small_optic.basecam.depthoffieldvalues = [20, 15];
  level.camera_loadout_showcase_preview_small_optic.myfov = 36;
  level.camera_loadout_showcase_preview_small_optic.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_optic.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_small_reargrip.basecam = getEnt("camera_mp_gunsmith_preview_small_reargrip", "targetname");
  level.camera_loadout_showcase_preview_small_reargrip.basecam.depthoffieldvalues = [12, 20];
  level.camera_loadout_showcase_preview_small_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_small_reargrip.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_reargrip.ref_1370f = 6;
  level.gas_emit_vfx = spawnStruct();
  level.gas_emit_vfx.basecam = getEnt("camera_mp_gunsmith_preview_small_reargrip_alt1", "targetname");
  level.gas_emit_vfx.basecam.depthoffieldvalues = [12, 20];
  level.gas_emit_vfx.myfov = 36;
  level.gas_emit_vfx.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_emit_vfx.ref_1370f = 6;
  level.gas_flyby_plane = spawnStruct();
  level.gas_flyby_plane.basecam = getEnt("camera_mp_gunsmith_preview_small_sticker", "targetname");
  level.gas_flyby_plane.basecam.depthoffieldvalues = [16, 22];
  level.gas_flyby_plane.myfov = 36;
  level.gas_flyby_plane.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_flyby_plane.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small_stock = spawnStruct();
  level.camera_loadout_showcase_preview_small_stock.basecam = getEnt("camera_mp_gunsmith_preview_small_stock", "targetname");
  level.camera_loadout_showcase_preview_small_stock.basecam.depthoffieldvalues = [16, 36];
  level.camera_loadout_showcase_preview_small_stock.myfov = 36;
  level.camera_loadout_showcase_preview_small_stock.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_stock.ref_1370f = 6;
  level.camera_loadout_showcase_preview_small_trigger = spawnStruct();
  level.camera_loadout_showcase_preview_small_trigger.basecam = getEnt("camera_mp_gunsmith_preview_small_trigger", "targetname");
  level.camera_loadout_showcase_preview_small_trigger.basecam.depthoffieldvalues = [21, 12];
  level.camera_loadout_showcase_preview_small_trigger.myfov = 36;
  level.camera_loadout_showcase_preview_small_trigger.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_small_trigger.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_barrel = spawnStruct();
  level.camera_loadout_showcase_preview_large_barrel.basecam = getEnt("camera_mp_gunsmith_preview_large_barrel", "targetname");
  level.camera_loadout_showcase_preview_large_barrel.basecam.depthoffieldvalues = [12, 46];
  level.camera_loadout_showcase_preview_large_barrel.myfov = 36;
  level.camera_loadout_showcase_preview_large_barrel.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_barrel.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_charm = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm.basecam = getEnt("camera_mp_gunsmith_preview_large_charm", "targetname");
  level.camera_loadout_showcase_preview_large_charm.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_charm.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_charm_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_charm_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_charm_alt1.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_charm_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_charm_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_charm_alt2.basecam = getEnt("camera_mp_gunsmith_preview_large_charm_alt2", "targetname");
  level.camera_loadout_showcase_preview_large_charm_alt2.basecam.depthoffieldvalues = [21, 17];
  level.camera_loadout_showcase_preview_large_charm_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_large_charm_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_charm_alt2.ref_1370f = 6;
  level.gametypefilter = spawnStruct();
  level.gametypefilter.basecam = getEnt("camera_mp_gunsmith_preview_large_charm_alt3", "targetname");
  level.gametypefilter.basecam.depthoffieldvalues = [25, 19];
  level.gametypefilter.myfov = 36;
  level.gametypefilter.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gametypefilter.ref_1370f = 6;
  level.gametypekillsperhouravg = spawnStruct();
  level.gametypekillsperhouravg.basecam = getEnt("camera_mp_gunsmith_preview_large_charm_alt4", "targetname");
  level.gametypekillsperhouravg.basecam.depthoffieldvalues = [21, 16];
  level.gametypekillsperhouravg.myfov = 36;
  level.gametypekillsperhouravg.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gametypekillsperhouravg.ref_1370f = 6;
  level.gametypekillspermatchmax = spawnStruct();
  level.gametypekillspermatchmax.basecam = getEnt("camera_mp_gunsmith_preview_large_charm_alt5", "targetname");
  level.gametypekillspermatchmax.basecam.depthoffieldvalues = [21, 17];
  level.gametypekillspermatchmax.myfov = 36;
  level.gametypekillspermatchmax.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gametypekillspermatchmax.ref_1370f = 6;
  level.gametypeoverrideassassinsearchparams = spawnStruct();
  level.gametypeoverrideassassinsearchparams.basecam = getEnt("camera_mp_gunsmith_preview_large_charm_alt6", "targetname");
  level.gametypeoverrideassassinsearchparams.basecam.depthoffieldvalues = [21, 17];
  level.gametypeoverrideassassinsearchparams.myfov = 36;
  level.gametypeoverrideassassinsearchparams.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gametypeoverrideassassinsearchparams.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_barrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_barrel_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_barrel_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_barrel_alt1.basecam.depthoffieldvalues = [16, 52];
  level.camera_loadout_showcase_preview_large_barrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_barrel_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_barrel_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_laser = spawnStruct();
  level.camera_loadout_showcase_preview_large_laser.basecam = getEnt("camera_mp_gunsmith_preview_large_laser", "targetname");
  level.camera_loadout_showcase_preview_large_laser.basecam.depthoffieldvalues = [12, 26];
  level.camera_loadout_showcase_preview_large_laser.myfov = 36;
  level.camera_loadout_showcase_preview_large_laser.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_laser.ref_1370f = 6;
  level.gametypeoverridedomsearchparams = spawnStruct();
  level.gametypeoverridedomsearchparams.basecam = getEnt("camera_mp_gunsmith_preview_large_laser_alt1", "targetname");
  level.gametypeoverridedomsearchparams.basecam.depthoffieldvalues = [12, 26];
  level.gametypeoverridedomsearchparams.myfov = 36;
  level.gametypeoverridedomsearchparams.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gametypeoverridedomsearchparams.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_magazine = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine.basecam = getEnt("camera_mp_gunsmith_preview_large_magazine", "targetname");
  level.camera_loadout_showcase_preview_large_magazine.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_magazine.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_magazine_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_magazine_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt1.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_magazine_alt2 = spawnStruct();
  level.camera_loadout_showcase_preview_large_magazine_alt2.basecam = getEnt("camera_mp_gunsmith_preview_large_magazine_alt2", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt2.basecam.depthoffieldvalues = [14, 32];
  level.camera_loadout_showcase_preview_large_magazine_alt2.myfov = 36;
  level.camera_loadout_showcase_preview_large_magazine_alt2.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_magazine_alt2.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_muzzle = spawnStruct();
  level.camera_loadout_showcase_preview_large_muzzle.basecam = getEnt("camera_mp_gunsmith_preview_large_muzzle", "targetname");
  level.camera_loadout_showcase_preview_large_muzzle.basecam.depthoffieldvalues = [21, 34];
  level.camera_loadout_showcase_preview_large_muzzle.myfov = 36;
  level.camera_loadout_showcase_preview_large_muzzle.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_muzzle.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_muzzle_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_muzzle_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_muzzle_alt1.basecam.depthoffieldvalues = [21, 32];
  level.camera_loadout_showcase_preview_large_muzzle_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_muzzle_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_muzzle_alt1.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_optic = spawnStruct();
  level.camera_loadout_showcase_preview_large_optic.basecam = getEnt("camera_mp_gunsmith_preview_large_optic", "targetname");
  level.camera_loadout_showcase_preview_large_optic.basecam.depthoffieldvalues = [21.5, 25];
  level.camera_loadout_showcase_preview_large_optic.myfov = 36;
  level.camera_loadout_showcase_preview_large_optic.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_optic.ref_1370f = 6;
  level.gametypeoverridescavsearchparams = spawnStruct();
  level.gametypeoverridescavsearchparams.basecam = getEnt("camera_mp_gunsmith_preview_large_optic_alt1", "targetname");
  level.gametypeoverridescavsearchparams.basecam.depthoffieldvalues = [21.5, 25];
  level.gametypeoverridescavsearchparams.myfov = 36;
  level.gametypeoverridescavsearchparams.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gametypeoverridescavsearchparams.ref_1370f = 6;
  level.gametyperoundendscoresetomnvar = spawnStruct();
  level.gametyperoundendscoresetomnvar.basecam = getEnt("camera_mp_gunsmith_preview_large_optic_alt2", "targetname");
  level.gametyperoundendscoresetomnvar.basecam.depthoffieldvalues = [21.5, 25];
  level.gametyperoundendscoresetomnvar.myfov = 36;
  level.gametyperoundendscoresetomnvar.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gametyperoundendscoresetomnvar.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_reargrip = spawnStruct();
  level.camera_loadout_showcase_preview_large_reargrip.basecam = getEnt("camera_mp_gunsmith_preview_large_reargrip", "targetname");
  level.camera_loadout_showcase_preview_large_reargrip.basecam.depthoffieldvalues = [12, 23];
  level.camera_loadout_showcase_preview_large_reargrip.myfov = 36;
  level.camera_loadout_showcase_preview_large_reargrip.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_reargrip.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_reargrip_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_reargrip_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_reargrip_alt1.basecam.depthoffieldvalues = [12, 21];
  level.camera_loadout_showcase_preview_large_reargrip_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_reargrip_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_reargrip_alt1.ref_1370f = 6;
  level.gametypeweaponxpmodifier = spawnStruct();
  level.gametypeweaponxpmodifier.basecam = getEnt("camera_mp_gunsmith_preview_large_sticker", "targetname");
  level.gametypeweaponxpmodifier.basecam.depthoffieldvalues = [20, 32];
  level.gametypeweaponxpmodifier.myfov = 36;
  level.gametypeweaponxpmodifier.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gametypeweaponxpmodifier.ref_1370f = 6;
  level.garbage_bin_clip = spawnStruct();
  level.garbage_bin_clip.basecam = getEnt("camera_mp_gunsmith_preview_large_sticker_alt1", "targetname");
  level.garbage_bin_clip.basecam.depthoffieldvalues = [20, 35];
  level.garbage_bin_clip.myfov = 36;
  level.garbage_bin_clip.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.garbage_bin_clip.ref_1370f = 6;
  level.gas_at_computer = spawnStruct();
  level.gas_at_computer.basecam = getEnt("camera_mp_gunsmith_preview_large_sticker_alt2", "targetname");
  level.gas_at_computer.basecam.depthoffieldvalues = [20, 32];
  level.gas_at_computer.myfov = 36;
  level.gas_at_computer.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_at_computer.ref_1370f = 6;
  level.gas_attack = spawnStruct();
  level.gas_attack.basecam = getEnt("camera_mp_gunsmith_preview_large_sticker_alt3", "targetname");
  level.gas_attack.basecam.depthoffieldvalues = [20, 35];
  level.gas_attack.myfov = 36;
  level.gas_attack.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_attack.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_stock = spawnStruct();
  level.camera_loadout_showcase_preview_large_stock.basecam = getEnt("camera_mp_gunsmith_preview_large_stock", "targetname");
  level.camera_loadout_showcase_preview_large_stock.basecam.depthoffieldvalues = [16, 43];
  level.camera_loadout_showcase_preview_large_stock.myfov = 36;
  level.camera_loadout_showcase_preview_large_stock.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_stock.ref_1370f = 6;
  level.gas_attack_deploy = spawnStruct();
  level.gas_attack_deploy.basecam = getEnt("camera_mp_gunsmith_preview_large_stock_alt1", "targetname");
  level.gas_attack_deploy.basecam.depthoffieldvalues = [16, 43];
  level.gas_attack_deploy.myfov = 36;
  level.gas_attack_deploy.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.gas_attack_deploy.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_underbarrel = spawnStruct();
  level.camera_loadout_showcase_preview_large_underbarrel.basecam = getEnt("camera_mp_gunsmith_preview_large_underbarrel", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel.basecam.depthoffieldvalues = [20, 35];
  level.camera_loadout_showcase_preview_large_underbarrel.myfov = 36;
  level.camera_loadout_showcase_preview_large_underbarrel.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel.ref_1370f = 6;
  level.camera_loadout_showcase_preview_large_underbarrel_alt1 = spawnStruct();
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam = getEnt("camera_mp_gunsmith_preview_large_underbarrel_alt1", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.basecam.depthoffieldvalues = [20, 36];
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.myfov = 36;
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.weapon_locs[2] = getEnt("weapon_loc_preview", "targetname");
  level.camera_loadout_showcase_preview_large_underbarrel_alt1.ref_1370f = 6;
  level.camera_character_tango = spawnStruct();
  level.camera_character_tango.basecam = getEnt("char_tango", "targetname");
  level.camera_character_tango.basecam.depthoffieldvalues = [4.5, 125];
  level.camera_character_tango.myfov = 30;
  level.camera_character_tango.update_char_loc = &update_main_menu_char_loc;
  level.camera_character_tango.ref_1370f = 6;
  level.camera_character_faction_select_l = spawnStruct();
  level.camera_character_faction_select_l.basecam = getEnt("char_west_b_detail", "targetname");
  level.camera_character_faction_select_l.basecam.depthoffieldvalues = [22, 98];
  level.camera_character_faction_select_l.myfov = 37;
  level.camera_character_faction_select_l.update_char_loc = &ref_13fa5;
  level.camera_character_faction_select_l.ref_1370f = 6;
  level.camera_character_faction_select_l_detail = spawnStruct();
  level.camera_character_faction_select_l_detail.basecam = getEnt("char_west_b", "targetname");
  level.camera_character_faction_select_l_detail.basecam.depthoffieldvalues = [22, 181];
  level.camera_character_faction_select_l_detail.myfov = 37;
  level.camera_character_faction_select_l_detail.update_char_loc = &ref_13fa5;
  level.camera_character_faction_select_l_detail.ref_1370f = 6;
  level.camera_character_faction_select_r = spawnStruct();
  level.camera_character_faction_select_r.basecam = getEnt("char_east_a_detail", "targetname");
  level.camera_character_faction_select_r.basecam.depthoffieldvalues = [22, 98];
  level.camera_character_faction_select_r.myfov = 37;
  level.camera_character_faction_select_r.update_char_loc = &ref_13fa4;
  level.camera_character_faction_select_r.char_index = 1;
  level.camera_character_faction_select_r.ref_1370f = 6;
  level.camera_character_faction_select_r_detail = spawnStruct();
  level.camera_character_faction_select_r_detail.basecam = getEnt("char_east_a", "targetname");
  level.camera_character_faction_select_r_detail.basecam.depthoffieldvalues = [22, 181];
  level.camera_character_faction_select_r_detail.myfov = 37;
  level.camera_character_faction_select_r_detail.update_char_loc = &ref_13fa4;
  level.camera_character_faction_select_r_detail.char_index = 1;
  level.camera_character_faction_select_r_detail.ref_1370f = 6;
  level.gamemodemolotovfunc = spawnStruct();
  level.gamemodemolotovfunc.basecam = getEnt("char_preview_detail", "targetname");
  level.gamemodemolotovfunc.basecam.depthoffieldvalues = [22, 60];
  level.gamemodemolotovfunc.myfov = 37;
  level.gamemodemolotovfunc.char_loc = getEnt("charroom_char_preview", "targetname");
  level.gamemodemolotovfunc.ref_1370f = 6;
  level.gamemodeoverridemeleeviewkickscale = spawnStruct();
  level.gamemodeoverridemeleeviewkickscale.basecam = getEnt("char_preview", "targetname");
  level.gamemodeoverridemeleeviewkickscale.basecam.depthoffieldvalues = [22, 181];
  level.gamemodeoverridemeleeviewkickscale.myfov = 37;
  level.gamemodeoverridemeleeviewkickscale.char_loc = getEnt("charroom_char_preview", "targetname");
  level.gamemodeoverridemeleeviewkickscale.ref_1370f = 6;
  level.camera_quartermaster = spawnStruct();
  level.camera_quartermaster.basecam = getEnt("char_quartermaster", "targetname");
  level.camera_quartermaster.basecam.depthoffieldvalues = [16, 264];
  level.camera_quartermaster.myfov = 28;
  level.camera_quartermaster_detail = spawnStruct();
  level.camera_quartermaster_detail.basecam = getEnt("char_quartermaster_detail", "targetname");
  level.camera_quartermaster_detail.basecam.depthoffieldvalues = [22, 264];
  level.camera_quartermaster_detail.myfov = 28;
  level.camera_lobby = spawnStruct();
  level.camera_lobby.basecam = getEnt("char_lobby", "targetname");
  level.camera_lobby.basecam.depthoffieldvalues = [3.5, 225];
  level.camera_lobby.myfov = 36;
  level.camera_lobby.update_char_loc = &update_lobby_char_loc;

  if(isDefined(level.playersetomnvargulag) && level.playersetomnvargulag == 1) {
    level.camera_lobby.ref_1370f = 5;
  }

  if(isDefined(level.playersetwasingulag) && level.playersetwasingulag == 1 || isDefined(level.playersetplunderomnvar) && level.playersetplunderomnvar == 1) {
    level.camera_lobby.ref_1370f = 8;
  }

  if(isDefined(level.playersetwasingulag) && level.playersetwasingulag == 1 || isDefined(level.playersetplunderomnvar) && level.playersetplunderomnvar == 1) {
    level.camera_lobby.ref_13710 = 6;
  }

  if(isDefined(level.playershooting) && level.playershooting == 1) {
    level.camera_lobby.ref_1370f = 8;
  }

  if(isDefined(level.playershooting) && level.playershooting == 1) {
    level.camera_lobby.ref_13710 = 6;
  }

  if(isDefined(level.playershowarenastartobjectivetext) && level.playershowarenastartobjectivetext == 1) {
    level.camera_lobby.ref_1370f = 8;
  }

  if(isDefined(level.playershowarenastartobjectivetext) && level.playershowarenastartobjectivetext == 1) {
    level.camera_lobby.ref_13710 = 6;
    level.camera_lobby.basecam.depthoffieldvalues = [3.1, 200];
  }

  if(isDefined(level.playerspawn) && level.playerspawn == 1) {
    level.camera_lobby.ref_1370f = 8;
  }

  if(isDefined(level.playerspawn) && level.playerspawn == 1) {
    level.camera_lobby.ref_13710 = 6;
  }

  level.camera_lobby_detail = spawnStruct();
  level.camera_lobby_detail.basecam = getEnt("char_lobby_detail", "targetname");
  level.camera_lobby_detail.basecam.depthoffieldvalues = [3, 100];
  level.camera_lobby_detail.myfov = 36;
  level.camera_lobby_detail.update_char_loc = &update_lobby_char_loc;

  if(isDefined(level.playersetomnvargulag) && level.playersetomnvargulag == 1) {
    level.camera_lobby_detail.ref_1370f = 5;
  }

  if(isDefined(level.playersetwasingulag) && level.playersetwasingulag == 1 || isDefined(level.playersetplunderomnvar) && level.playersetplunderomnvar == 1) {
    level.camera_lobby_detail.ref_1370f = 8;
  }

  if(isDefined(level.playersetwasingulag) && level.playersetwasingulag == 1 || isDefined(level.playersetplunderomnvar) && level.playersetplunderomnvar == 1) {
    level.camera_lobby_detail.ref_13710 = 6;
  }

  if(isDefined(level.playershooting) && level.playershooting == 1) {
    level.camera_lobby_detail.ref_1370f = 8;
  }

  if(isDefined(level.playershooting) && level.playershooting == 1) {
    level.camera_lobby_detail.ref_13710 = 6;
  }

  if(isDefined(level.playershowarenastartobjectivetext) && level.playershowarenastartobjectivetext == 1) {
    level.camera_lobby_detail.ref_1370f = 8;
  }

  if(isDefined(level.playershowarenastartobjectivetext) && level.playershowarenastartobjectivetext == 1) {
    level.camera_lobby_detail.ref_13710 = 6;
  }

  if(isDefined(level.playerspawn) && level.playerspawn == 1) {
    level.camera_lobby_detail.ref_1370f = 8;
  }

  if(isDefined(level.playerspawn) && level.playerspawn == 1) {
    level.camera_lobby_detail.ref_13710 = 6;
  }

  level.camera_character_tournaments = spawnStruct();
  level.camera_character_tournaments.basecam = getEnt("char_tournament_overcam", "targetname");
  level.camera_character_tournaments.basecam.depthoffieldvalues = [22, 256];
  level.camera_character_tournaments.myfov = 36;
  level.camera_character_tournaments.update_char_loc = &update_arena_char_loc;
  level.gameisending = spawnStruct();
  level.gameisending.basecam = getEnt("char_tournament_overcam", "targetname");
  level.gameisending.basecam.depthoffieldvalues = [22, 256];
  level.gameisending.myfov = 36;
  level.gameisending.update_char_loc = &ref_13f87;
}

function setup_initial_entities() {
  level.characters = [];

  for(var0 = 0; var0 < 8; var0++) {
    var1 = undefined;
    var2 = var0 + 1;

    if(var2 < 10) {
      var1 = getEnt("lobby_charslot_0" + var2, "targetname");
    } else {
      var1 = getEnt("lobby_charslot_" + var2, "targetname");
    }

    level.characters[var0] = spawn("script_character", var1.origin, 0, 0, var0, "MPClientCharacter");
  }

  level.characters[14] = spawn("script_character", level.characters[0].origin, 0, 0, 14, "MPClientCharacter");
  level.characters[14].angles = (0, 270, 0);

  for(var3 = 0; var3 < 4; var3++) {
    var2 = var3 + 1;
    var0 = 8 + var3;
    var1 = getEnt("lobby_charslot_0" + var2 + "_dog", "targetname");
    level.characters[var0] = spawn("script_character", var1.origin, 0, 0, var0, "MPClientCharacter");
    level.characters[var0].update_focus_fire_heahicon = 1;
  }

  var1 = getEnt("charroom_char_tango_east", "targetname");
  level.characters[12] = spawn("script_character", var1.origin, 0, 0, 12, "MPClientCharacter");
  var1 = getEnt("charroom_char_tango_west", "targetname");
  level.characters[13] = spawn("script_character", var1.origin, 0, 0, 13, "MPClientCharacter");
  var4 = getEnt("weapon_loc_hq1", "targetname");
  level.weapons = [];
  level.weapons[0] = spawn("script_weapon", var4.origin, 0, 0, 0);
  level.weapons[0].angles = var4.angles;
  var5 = getEnt("weapon_loc_hq2", "targetname");
  level.weapons[1] = spawn("script_weapon", var5.origin, 0, 0, 1);
  level.weapons[1].angles = var5.angles;
  var6 = getEnt("weapon_loc_preview", "targetname");
  level.weapons[2] = spawn("script_weapon", var6.origin, 0, 0, 2);
  level.weapons[2].angles = var6.angles;
  var7 = getEnt("weapon_loc_watch", "targetname");
  level.weapons[3] = spawn("script_weapon", var7.origin, 0, 0, 3);
  level.weapons[3].angles = var7.angles;
  frontend_camera_setup(level.camera_lobby_detail.basecam.origin, level.camera_lobby_detail.basecam.angles);
}

function getgunbenchents() {
  level.gunbenchbulletent = getEnt("gunbench_bullets", "targetname");
}

function epictauntlistener() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "taunt_started") {
      scripts\mp\broshot_utilities::respawnclientcharacter();
      var2 = tablelookup("mp/cac/taunts.csv", 0, var1, 9);
      scripts\mp\broshot_utilities::processepictaunt(var2, -1, 0);
      continue;
    }

    if(var0 == "taunt_reset") {
      scripts\mp\broshot_utilities::respawnclientcharacter();
    }
  }
}

function devui_bg_swap(var0) {
  foreach(var2 in level.ui_bg_images_2d) {
    var2 hide();
  }

  if(var0 > 0 && var0 <= level.ui_bg_images_2d.size) {
    level.ui_bg_images_2d[var0] show();
    return;
  }
}

function luinotifylistener() {
  self endon("disconnect");
  getgunbenchents();
  level.currentdropcount = 0;

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "loadout_showcase_entered") {
      level.bulletsinitialstate = 1;
      level.currentdropcount = 0;
      continue;
    }

    if(var0 == "primary_weapon_changed") {
      var2 = int(var1);

      if(istrue(level.bulletsinitialstate)) {
        level.bulletsinitialstate = 0;
        continue;
      }

      if(level.currentdropcount == 0) {}

      level.currentdropcount++;

      if(level.currentdropcount > 3) {
        level.currentdropcount = 1;
      }

      continue;
    }

    if(var0 == "set_ui_rarity_image") {
      var3 = int(var1);
      devui_bg_swap(var3);
    }
  }
}

function zombiepowerscooldown() {
  if(!isDefined(level.spawn_maint_wave_1)) {
    level.spawn_maint_wave_1 = loadfx("vfx/iw8_mp/watches/vfx_mp_holo_watch");
    wait 1;
  }

  level.ref_144db = spawnfx(level.spawn_maint_wave_1, level.weapons[3].origin);
  level.ref_144db.angles = (221, -34.753, 181.997);
  level.ref_144db.origin += (1, -0.66, 0.98);
  waitframe();
  triggerfx(level.ref_144db);
}

function ref_14014() {
  for(;;) {
    if(getdvarint("scr_accessory_test_vfx_rot", -1) != -1) {
      var0 = getdvarint("scr_accessory_test_vfx_rot");
      ref_11d9f(var0);
    }

    waitframe();
  }
}

function ref_11d9f(var0) {
  var1 = 0;
  var2 = 0;
  var3 = 0;

  if(var0 == 1) {
    var1 = 0.1;
  }

  if(var0 == 2) {
    var1 = -0.1;
  }

  if(var0 == 3) {
    var2 = 0.1;
  }

  if(var0 == 4) {
    var2 = -0.1;
  }

  if(var0 == 5) {
    var3 = 0.1;
  }

  if(var0 == 6) {
    var3 = -0.1;
  }

  var4 = level.ref_144db.angles;
  var5 = level.ref_144db.origin + (var1, var2, var3);
  level.ref_144db delete();
  level.ref_144db = spawnfx(level.spawn_maint_wave_1, var5);
  level.ref_144db.angles = var4;
  triggerfx(level.ref_144db);
}

function ref_12d9a(var0) {
  var1 = 0;
  var2 = 0;
  var3 = 0;

  if(var0 == 1) {
    var1 = 10;
  }

  if(var0 == 2) {
    var1 = -10;
  }

  if(var0 == 3) {
    var2 = 10;
  }

  if(var0 == 4) {
    var2 = -10;
  }

  if(var0 == 5) {
    var3 = 10;
  }

  if(var0 == 6) {
    var3 = -10;
  }

  var4 = level.ref_144db.angles + (var1, var2, var3);
  level.ref_144db delete();
  level.ref_144db = spawnfx(level.spawn_maint_wave_1, level.weapons[3].origin + (1, -0.66, 1.1));
  level.ref_144db.angles = var4;
  triggerfx(level.ref_144db);
}

function ref_13205() {
  level.ui_bg_images_2d = [];
  level.ui_bg_images_2d[1] = getEnt("weapRarity01", "targetname");
  level.ui_bg_images_2d[2] = getEnt("weapRarity02", "targetname");
  level.ui_bg_images_2d[3] = getEnt("weapRarity03", "targetname");
  level.ui_bg_images_2d[4] = getEnt("weapRarity04", "targetname");
  level.ui_bg_images_2d[5] = getEnt("weapRarity05", "targetname");
  level.ref_12a10 = scripts\engine\utility::getStruct("weapRaritySmall", "targetname");
  level.ref_12a0f = scripts\engine\utility::getStruct("weapRarityMedium", "targetname");
  level.ref_12a0e = scripts\engine\utility::getStruct("weapRarityLarge", "targetname");
  level.ref_12a11 = scripts\engine\utility::getStruct("weapRarityWatch", "targetname");
  devui_bg_swap(0);
}