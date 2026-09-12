/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_armsdealer.gsc
**************************************************************************/

function registersafehouse() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("armsdealer_safehouse_return");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\cp_objectives::registerobjective("safehouse_armsdealer_mnu", &init_safehouse, &start_safehouse, undefined, &debugbeatobjective, &debug_safehouse_start);
  scripts\cp\cp_objectives::registerobjective("safehouse_armsdealer", &init_safehouse, &start_safehouse, undefined, &debugbeatobjective, &debug_safehouse_start);
  scripts\cp\cp_objectives::registerobjective("safehouse_armsdealer_return", undefined, &ref_137FB, undefined, &debugbeatobjective, &debug_safehouse_return_start);
  scripts\cp\cp_objectives::registerobjective("safehouse_armsdealer_restart", undefined, &ref_137FA, undefined, &debugbeatobjective, &debug_safehouse_return_start);
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("armsdealer_safehouse_start", "targetname");
  level thread scripts\mp\vehicles\vehicle_damage_mp::ref_12E57();
}

function debugbeatobjective(var_0) {}

function debug_safehouse_return_start(var_0) {
  if(!scripts\engine\utility::flag_exist("cp_donetsk_safehouse_armsdealer_cs")) {
    scripts\engine\utility::flag_init("cp_donetsk_safehouse_armsdealer_cs");
  }

  scripts\engine\utility::flag_set("cp_donetsk_safehouse_armsdealer_cs");
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_armsdealer_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "armsdealer_safehouse_return_start");
}

function debug_safehouse_start(var_0) {
  if(!scripts\engine\utility::flag_exist("cp_donetsk_safehouse_armsdealer_cs")) {
    scripts\engine\utility::flag_init("cp_donetsk_safehouse_armsdealer_cs");
  }

  scripts\engine\utility::flag_set("cp_donetsk_safehouse_armsdealer_cs");
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_armsdealer_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "armsdealer_safehouse_start");
}

function spawn_atvs() {
  scripts\engine\utility::flag_wait("objectives_registered");
  wait 3;

  if(!isDefined(level.atvs)) {
    level.atvs = [];
  }

  var_0 = scripts\engine\utility::getStructArray("armsdealer_spawn_atv", "script_noteworthy");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_0, 1);
}

function init_safehouse(var_0) {}

function start_safehouse(var_0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_armsdealer_cs_completed");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(1);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  var_1 = scripts\engine\utility::getStruct("armsdealer_safehouse_loadout", "targetname").origin;
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(1, var_1, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(1, var_1, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(1, var_1, 4096, "scriptable_door_wood_ornate_01_orange_double_l", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(1, var_1, 4096, "scriptable_door_wood_ornate_01_orange_double_r", "classname");
  thread managejumpmasterinfodisplay();
  thread spawn_atvs();
  thread safehouse_loadout_interaction("armsdealer_safehouse_loadout");
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("paladin", "safehouse_door_opened", 10, 1);
  wait 10;
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(0, var_1, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(0, var_1, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(0, var_1, 4096, "scriptable_door_wood_ornate_01_orange_double_l", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(0, var_1, 4096, "scriptable_door_wood_ornate_01_orange_double_r", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var_1, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var_1, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var_1, 4096, "scriptable_door_wood_ornate_01_orange_double_l", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var_1, 4096, "scriptable_door_wood_ornate_01_orange_double_r", "classname");
  level scripts\engine\utility::ref_143BA(40, "safehouse_door_opened", "armsdealer_safehouse_VO_ended");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(0);
  makesafehouseclipsolid(0);
  scripts\cp\cp_objectives::overridenextstep(var_0, "morales_1");
  level.ref_121B1 = getEnt("Phase4OutOfBounds", "targetname");

  if(isDefined(level.ref_121B1)) {
    thread scripts\cp\cp_outofbounds::watchoobtrigger(level.ref_121B1);
    return;
  }
}

function managejumpmasterinfodisplay() {
  level endon("game_ended");
  level endon("stop_safehouse_vo");

  if(getdvarint("intro_vo") < 1) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_convo_start_10", "allies");
    var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));
    wait level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "conv_generic_reply");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_rescue_hvi_intro_10", "allies");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_intro_20", "allies");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_rescue_hvi_intro_30", "allies");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_intro_40", "allies");
    setDvar("intro_vo", 1);
  } else {
    wait 3;
  }

  level notify("armsdealer_safehouse_VO_ended");
}

function ref_137FA(var_0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_armsdealer_cs_completed");
  thread safehouse_loadout_interaction(level);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("crosswind", "toggle_safehouse_settings", 10, 1);
  var_1 = level.camera_loadout_showcase_preview_sticker.origin;
  thread init_laser_traps(level);
  var_1 = level.camera_loadout_showcase_preview_sticker.origin;

  if(isDefined(level.ref_121B1)) {
    level.ref_121B1 delete();
  }

  scripts\mp\vehicles\vehicle_damage_mp::vehomn_updateomnvarsperframe();
  var_2 = scripts\engine\utility::getStructArray("armsdealer_safehouse_return_start", "targetname");
  level.initlocs_bunkertest = var_2;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12E5A(var_2);
  scripts\engine\utility::flag_set("armsdealer_safehouse_return");
  setDvar("restart_checkpoint", "");
  setDvar("cp_arms_dealer_start_obj", "safehouse_armsdealer_restart");
  setDvar("cp_armsdealer_2_start_obj", "safehouse_armsdealer_restart");
  scripts\cp\cp_objectives::overridenextstep(var_0, "plant_jammers");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(1, var_1, 2048, "scriptable_dyn_door_metal_single_b_01_grey", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(1);
  thread ref_1437D("safehouse_demeanor_off", var_1);
}

function ref_137FB(var_0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_armsdealer_cs_completed");
  thread safehouse_loadout_interaction(level);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("crosswind", "toggle_safehouse_settings", 10, 1);
  var_1 = level.camera_loadout_showcase_preview_sticker.origin;
  thread init_laser_traps(level);

  if(!scripts\engine\utility::flag("armsdealer_safehouse_return")) {
    thread maxplunderextractions();
    var_1 = level.camera_loadout_showcase_preview_sticker.origin;

    if(isDefined(level.ref_121B1)) {
      level.ref_121B1 delete();
    }

    scripts\mp\vehicles\vehicle_damage_mp::vehomn_updateomnvarsperframe();
    var_2 = scripts\engine\utility::getStructArray("armsdealer_safehouse_return_start", "targetname");
    level.initlocs_bunkertest = var_2;
    scripts\mp\vehicles\vehicle_damage_mp::ref_12E5A(var_2);
    scripts\engine\utility::flag_set("armsdealer_safehouse_return");
    setDvar("restart_checkpoint", "");
    setDvar("cp_arms_dealer_start_obj", "safehouse_armsdealer_restart");
    setDvar("cp_armsdealer_2_start_obj", "safehouse_armsdealer_restart");
    scripts\cp\cp_objectives::overridenextstep(var_0, "plant_jammers");
  } else {
    scripts\cp\cp_objectives::overridenextstep(var_0, "plant_jammers");
  }

  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(1, var_1, 2048, "scriptable_dyn_door_metal_single_b_01_grey", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(1);
  level waittill("dialogue_brief_done");
  thread ref_1437D("safehouse_demeanor_off", var_1);
}

function maxplunderextractions() {
  level endon("game_ended");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_plane_brief_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_plane_brief_20", "allies");
  level notify("dialogue_brief_done");
}

function maxplunderdropondeath() {
  level endon("game_ended");
  scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_plane_brief_20", "allies");
  level notify("dialogue_brief_done");
}

function ref_1437D(var_0, var_1) {
  level endon("game_ended");
  level waittill(var_0);
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13BC1(0, var_1, 2048, "scriptable_dyn_door_metal_single_b_01_grey", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13BC2(0);
}

function maxweaponxpcap(var_0) {
  var_1 = scripts\engine\utility::getStructArray("armsdealer_safehouse_return_start", "targetname");

  foreach(var_3 in scripts\cp\utility::getplayersinteam(var_0)) {
    var_4 = 0;

    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      var_4 = 1;
    }

    thread player_regroup(var_3, var_1, var_5);
  }

  wait 0.5;
}

function player_regroup(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  thread regroup_blackscreen(self, var_3, var_4);
  wait 0.5;
  var_0[var_1].angles = scripts\engine\utility::ter_op(isDefined(var_0[var_1].angles), var_0[var_1].angles, (0, 0, 0));

  if(istrue(var_2)) {
    self.respawn_forcespawnorigin = var_0[var_1].origin;
    self.respawn_forcespawnangles = var_0[var_1].angles;
    self.forcespawnorigin = self.respawn_forcespawnorigin;
    self.forcespawnangles = self.respawn_forcespawnangles;
    scripts\cp\cp_laststand::instant_revive(self);
    self notify("forced_revive_to_regroup");
  }

  if(isDefined(self.currentturret)) {
    self.currentturret notify("kill_turret", 0, 0);
  }

  if(isDefined(level.choppergunners)) {
    foreach(var_6 in level.choppergunners) {
      var_6 scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
    }
  }

  if(isDefined(self.helperdrone)) {
    self.helperdrone scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);
  }

  if(istrue(self isonladder())) {
    self setOrigin(getgroundposition(self.origin + anglesToForward(self.angles) * -50, 16));
    wait 0.1;
  }

  var_8 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_8)) {
    var_9 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_8, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var_8, var_9, self, undefined, 1);
  }

  self setOrigin(var_0[var_1].origin);
  self setplayerangles(var_0[var_1].angles);
  self dontinterpolate();
}

function regroup_blackscreen(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  show_safehouse_regroup_text(var_0, var_2);
  var_0 disableweapons();
  var_0 scripts\cp\utility::freezecontrolswrapper(1);
  var_0.fullscreen_overlay = newclienthudelem(self);
  var_0.fullscreen_overlay.x = 0;
  var_0.fullscreen_overlay.y = 0;
  var_0.fullscreen_overlay setshader("black", 640, 480);
  var_0.fullscreen_overlay.alignx = "left";
  var_0.fullscreen_overlay.aligny = "top";
  var_0.fullscreen_overlay.sort = 1;
  var_0.fullscreen_overlay.horzalign = "fullscreen";
  var_0.fullscreen_overlay.vertalign = "fullscreen";
  var_0.fullscreen_overlay.alpha = 1;
  var_0.fullscreen_overlay.foreground = 1;
  var_0 setclientomnvar("ui_hide_hud", 1);
  var_0 setclientomnvar("ui_chyron_on", 0);
  var_0 setclientomnvar("ui_chyron_mission_index", 0);

  if(isDefined(var_1) && isstring(var_1)) {
    level waittill(var_1);
  } else {
    wait 3;
  }

  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_0 enableweapons();
  var_0.fullscreen_overlay fadeovertime(2);
  var_0.fullscreen_overlay.alpha = 0.5;
  wait 2;
  var_0.fullscreen_overlay destroy();
  var_0 setclientomnvar("ui_hide_hud", 0);
}

function show_safehouse_regroup_text(var_0) {
  var_1 = "safehouse_armsdealer_return";

  if(isDefined(var_0) && isstring(var_0)) {
    var_1 = var_0;
  }

  var_2 = getDvar("ui_mapname");
  var_3 = "cp/" + var_2 + "_objectives.csv";
  var_4 = int(tablelookup(var_3, 1, var_1, 0));
  self setclientomnvar("ui_chyron_mission_index", var_4);
  self setclientomnvar("ui_chyron_on", 1);
  self setclientomnvar("ui_hide_hud", 0);
}

function makesafehouseclipsolid(var_0) {
  var_1 = getEntArray("gunshop_safehouse_clip_1", "targetname");
  var_2 = getEntArray("armsdealer_safehouse_clip_2", "targetname");
  var_3 = scripts\engine\utility::array_combine(var_1, var_2);
  jumpiffalse(istrue(var_0)) LOC_0000005d;

  foreach(var_5 in var_3) {
    var_5 disconnectPaths();
    var_5 solid();
  }

  return;
}

function safehouse_loadout_interaction(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_2.headicon = deleteheadicon(var_2);
  setheadiconfriendlyimage(var_2.headicon, "hud_icon_survival_weapon");
  setheadicondrawthroughgeo(var_2.headicon, 0);
  setheadiconsnaptoedges(var_2.headicon, 1024);
  setheadiconmaxdistance(var_2.headicon, 30);
  addclienttoheadiconmask(var_2.headicon, 10);
  var_2 makeusable();
  var_2 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_ARMSDEALER/EDIT_LOADOUT", 25, "duration_short", "hide", 256, 65, 64, 65);
  level.camera_loadout_showcase_preview_sticker = var_2;

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(!var_3 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var_3 thread scripts\mp\vehicles\vehicle_damage_mp::edit_loadout(var_2);
  }

  return var_2;
}

function init_laser_traps(var_0) {
  var_1 = scripts\engine\utility::getStruct("armsdealer_return_silencer_interaction", "targetname");
  thread init_laser_trap(var_1, var_0);
}

function init_laser_trap(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("attachment_wm_sn_alpha50_silencer01");
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  thread ref_13397(var_2, var_2);
}

function ref_13397(var_0, var_1) {
  var_0 endon("death");
  var_0 setHintString(&"COOP_STEALTH/PICK_UP_SILENCER");
  var_0 setCursorHint("HINT_BUTTON");
  var_0 sethintdisplayrange(128);
  var_0 sethintdisplayfov(120);
  var_0 setusefov(120);
  var_0 setuserange(128);
  var_0 sethintonobstruction("show");
  objective_setlocation(var_1.objectiveindex, 0, var_0.origin);
  objective_setzoffset(var_1.objectiveindex, 15);
  var_0 makeusable();

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      var_3 = 1;
      var_4 = var_2 getcurrentweapon();

      if(weaponclass(var_4) == "rocketlauncher" || weaponclass(var_4) == "grenade") {
        var_2 thread scripts\cp\utility::hint_prompt("invalid_attachment", 1, 2);
        continue;
      }

      if(var_4.basename == "iw8_me_riotshield_mp") {
        var_2 thread scripts\cp\utility::hint_prompt("invalid_attachment", 1, 2);
        continue;
      }

      if(var_4.basename == "iw8_pi_cpapa_mp" || issubstr(var_4.basename, "cpapa")) {
        var_2 thread scripts\cp\utility::hint_prompt("invalid_attachment", 1, 2);
        continue;
      }

      if(var_4.basename == "iw8_sn_crossbow_mp") {
        var_2 thread scripts\cp\utility::hint_prompt("invalid_attachment", 1, 2);
        continue;
      }

      var_5 = var_2.currentweapon;
      var_6 = var_5;
      var_7 = undefined;
      var_8 = scripts\cp\utility::attachmentmap_tounique("silencer", var_6);

      for(var_9 = 0; var_9 < var_5.attachments.size; var_9++) {
        if(var_6 canuseattachment(var_8) && scripts\cp\cp_weapon::attachmentsconflict(var_5.attachments[var_9], var_8, var_6) == "") {
          var_3 = 1;
          continue;
        }

        var_3 = 0;
        break;
      }

      if(var_3) {
        var_7 = var_6 withattachment(var_8);
      }

      if(!isDefined(var_7)) {
        if(!isbot(var_2)) {
          var_2 thread scripts\cp\utility::hint_prompt("invalid_attachment", 1, 2);
        }

        continue;
      }

      var_2 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_5);
      var_2 giveweapon(var_7);
      var_2 setweaponammoclip(var_7, weaponclipsize(var_7));
      var_2 setweaponammostock(var_7, weaponmaxammo(var_7));
      var_2 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_7);
      scripts\cp\cp_weapon::fixupplayerweapons(var_2, var_7);
    }
  }
}