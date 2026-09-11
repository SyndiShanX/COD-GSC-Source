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
  scripts\cp\cp_objectives::registerobjective("safehouse_armsdealer_return", undefined, &ref_137fb, undefined, &debugbeatobjective, &debug_safehouse_return_start);
  scripts\cp\cp_objectives::registerobjective("safehouse_armsdealer_restart", undefined, &ref_137fa, undefined, &debugbeatobjective, &debug_safehouse_return_start);
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("armsdealer_safehouse_start", "targetname");
  level thread scripts\mp\vehicles\vehicle_damage_mp::ref_12e57();
}

function debugbeatobjective(var0) {}

function debug_safehouse_return_start(var0) {
  if(!scripts\engine\utility::flag_exist("cp_donetsk_safehouse_armsdealer_cs")) {
    scripts\engine\utility::flag_init("cp_donetsk_safehouse_armsdealer_cs");
  }

  scripts\engine\utility::flag_set("cp_donetsk_safehouse_armsdealer_cs");
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_armsdealer_cs_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "armsdealer_safehouse_return_start");
}

function debug_safehouse_start(var0) {
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

  var0 = scripts\engine\utility::getStructArray("armsdealer_spawn_atv", "script_noteworthy");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var0, 1);
}

function init_safehouse(var0) {}

function start_safehouse(var0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_armsdealer_cs_completed");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(1);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  var1 = scripts\engine\utility::getStruct("armsdealer_safehouse_loadout", "targetname").origin;
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var1, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var1, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var1, 4096, "scriptable_door_wood_ornate_01_orange_double_l", "classname");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var1, 4096, "scriptable_door_wood_ornate_01_orange_double_r", "classname");
  thread managejumpmasterinfodisplay();
  thread spawn_atvs();
  thread safehouse_loadout_interaction("armsdealer_safehouse_loadout");
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("paladin", "safehouse_door_opened", 10, 1);
  wait 10;
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var1, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var1, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var1, 4096, "scriptable_door_wood_ornate_01_orange_double_l", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var1, 4096, "scriptable_door_wood_ornate_01_orange_double_r", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var1, 2048, "scriptable_door_wooden_panel_mp_01", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var1, 2048, "scriptable_door_wooden_hollow_mp_01", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var1, 4096, "scriptable_door_wood_ornate_01_orange_double_l", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_14325(var1, 4096, "scriptable_door_wood_ornate_01_orange_double_r", "classname");
  level scripts\engine\utility::ref_143ba(40, "safehouse_door_opened", "armsdealer_safehouse_VO_ended");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(0);
  makesafehouseclipsolid(0);
  scripts\cp\cp_objectives::overridenextstep(var0, "morales_1");
  level.ref_121b1 = getEnt("Phase4OutOfBounds", "targetname");

  if(isDefined(level.ref_121b1)) {
    thread scripts\cp\cp_outofbounds::watchoobtrigger(level.ref_121b1);
    return;
  }
}

function managejumpmasterinfodisplay() {
  level endon("game_ended");
  level endon("stop_safehouse_vo");

  if(getdvarint("intro_vo") < 1) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_convo_start_10", "allies");
    var0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));
    wait level scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "conv_generic_reply");
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

function ref_137fa(var0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_armsdealer_cs_completed");
  thread safehouse_loadout_interaction(level);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("crosswind", "toggle_safehouse_settings", 10, 1);
  var1 = level.camera_loadout_showcase_preview_sticker.origin;
  thread init_laser_traps(level);
  var1 = level.camera_loadout_showcase_preview_sticker.origin;

  if(isDefined(level.ref_121b1)) {
    level.ref_121b1 delete();
  }

  scripts\mp\vehicles\vehicle_damage_mp::vehomn_updateomnvarsperframe();
  var2 = scripts\engine\utility::getStructArray("armsdealer_safehouse_return_start", "targetname");
  level.initlocs_bunkertest = var2;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12e5a(var2);
  scripts\engine\utility::flag_set("armsdealer_safehouse_return");
  setDvar("restart_checkpoint", "");
  setDvar("cp_arms_dealer_start_obj", "safehouse_armsdealer_restart");
  setDvar("cp_armsdealer_2_start_obj", "safehouse_armsdealer_restart");
  scripts\cp\cp_objectives::overridenextstep(var0, "plant_jammers");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var1, 2048, "scriptable_dyn_door_metal_single_b_01_grey", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(1);
  thread ref_1437d("safehouse_demeanor_off", var1);
}

function ref_137fb(var0) {
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_armsdealer_cs_completed");
  thread safehouse_loadout_interaction(level);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("crosswind", "toggle_safehouse_settings", 10, 1);
  var1 = level.camera_loadout_showcase_preview_sticker.origin;
  thread init_laser_traps(level);

  if(!scripts\engine\utility::flag("armsdealer_safehouse_return")) {
    thread maxplunderextractions();
    var1 = level.camera_loadout_showcase_preview_sticker.origin;

    if(isDefined(level.ref_121b1)) {
      level.ref_121b1 delete();
    }

    scripts\mp\vehicles\vehicle_damage_mp::vehomn_updateomnvarsperframe();
    var2 = scripts\engine\utility::getStructArray("armsdealer_safehouse_return_start", "targetname");
    level.initlocs_bunkertest = var2;
    scripts\mp\vehicles\vehicle_damage_mp::ref_12e5a(var2);
    scripts\engine\utility::flag_set("armsdealer_safehouse_return");
    setDvar("restart_checkpoint", "");
    setDvar("cp_arms_dealer_start_obj", "safehouse_armsdealer_restart");
    setDvar("cp_armsdealer_2_start_obj", "safehouse_armsdealer_restart");
    scripts\cp\cp_objectives::overridenextstep(var0, "plant_jammers");
  } else {
    scripts\cp\cp_objectives::overridenextstep(var0, "plant_jammers");
  }

  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var1, 2048, "scriptable_dyn_door_metal_single_b_01_grey", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(1);
  level waittill("dialogue_brief_done");
  thread ref_1437d("safehouse_demeanor_off", var1);
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

function ref_1437d(var0, var1) {
  level endon("game_ended");
  level waittill(var0);
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var1, 2048, "scriptable_dyn_door_metal_single_b_01_grey", "classname");
  scripts\mp\vehicles\vehicle_damage_mp::ref_13bc2(0);
}

function maxweaponxpcap(var0) {
  var1 = scripts\engine\utility::getStructArray("armsdealer_safehouse_return_start", "targetname");

  foreach(var3 in scripts\cp\utility::getplayersinteam(var0)) {
    var4 = 0;

    if(scripts\cp\cp_laststand::player_in_laststand(var3)) {
      var4 = 1;
    }

    thread player_regroup(var3, var1, var5);
  }

  wait 0.5;
}

function player_regroup(var0, var1, var2, var3, var4) {
  self endon("disconnect");
  thread regroup_blackscreen(self, var3, var4);
  wait 0.5;
  var0[var1].angles = scripts\engine\utility::ter_op(isDefined(var0[var1].angles), var0[var1].angles, (0, 0, 0));

  if(istrue(var2)) {
    self.respawn_forcespawnorigin = var0[var1].origin;
    self.respawn_forcespawnangles = var0[var1].angles;
    self.forcespawnorigin = self.respawn_forcespawnorigin;
    self.forcespawnangles = self.respawn_forcespawnangles;
    scripts\cp\cp_laststand::instant_revive(self);
    self notify("forced_revive_to_regroup");
  }

  if(isDefined(self.currentturret)) {
    self.currentturret notify("kill_turret", 0, 0);
  }

  if(isDefined(level.choppergunners)) {
    foreach(var6 in level.choppergunners) {
      var6 scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
    }
  }

  if(isDefined(self.helperdrone)) {
    self.helperdrone scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);
  }

  if(istrue(self isonladder())) {
    self setOrigin(getgroundposition(self.origin + anglesToForward(self.angles) * -50, 16));
    wait 0.1;
  }

  var8 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var8)) {
    var9 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var8, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var8, var9, self, undefined, 1);
  }

  self setOrigin(var0[var1].origin);
  self setplayerangles(var0[var1].angles);
  self dontinterpolate();
}

function regroup_blackscreen(var0, var1, var2) {
  var0 endon("disconnect");
  show_safehouse_regroup_text(var0, var2);
  var0 disableweapons();
  var0 scripts\cp\utility::freezecontrolswrapper(1);
  var0.fullscreen_overlay = newclienthudelem(self);
  var0.fullscreen_overlay.x = 0;
  var0.fullscreen_overlay.y = 0;
  var0.fullscreen_overlay setshader("black", 640, 480);
  var0.fullscreen_overlay.alignx = "left";
  var0.fullscreen_overlay.aligny = "top";
  var0.fullscreen_overlay.sort = 1;
  var0.fullscreen_overlay.horzalign = "fullscreen";
  var0.fullscreen_overlay.vertalign = "fullscreen";
  var0.fullscreen_overlay.alpha = 1;
  var0.fullscreen_overlay.foreground = 1;
  var0 setclientomnvar("ui_hide_hud", 1);
  var0 setclientomnvar("ui_chyron_on", 0);
  var0 setclientomnvar("ui_chyron_mission_index", 0);

  if(isDefined(var1) && isstring(var1)) {
    level waittill(var1);
  } else {
    wait 3;
  }

  var0 scripts\cp\utility::freezecontrolswrapper(0);
  var0 enableweapons();
  var0.fullscreen_overlay fadeovertime(2);
  var0.fullscreen_overlay.alpha = 0.5;
  wait 2;
  var0.fullscreen_overlay destroy();
  var0 setclientomnvar("ui_hide_hud", 0);
}

function show_safehouse_regroup_text(var0) {
  var1 = "safehouse_armsdealer_return";

  if(isDefined(var0) && isstring(var0)) {
    var1 = var0;
  }

  var2 = getDvar("NSQLTTMRMP");
  var3 = "cp/" + var2 + "_objectives.csv";
  var4 = int(tablelookup(var3, 1, var1, 0));
  self setclientomnvar("ui_chyron_mission_index", var4);
  self setclientomnvar("ui_chyron_on", 1);
  self setclientomnvar("ui_hide_hud", 0);
}

function makesafehouseclipsolid(var0) {
  var1 = getEntArray("gunshop_safehouse_clip_1", "targetname");
  var2 = getEntArray("armsdealer_safehouse_clip_2", "targetname");
  var3 = scripts\engine\utility::array_combine(var1, var2);
  jumpiffalse(istrue(var0)) LOC_0000005d;

  foreach(var5 in var3) {
    var5 disconnectPaths();
    var5 solid();
  }

  return;
}

function safehouse_loadout_interaction(var0) {
  var1 = scripts\engine\utility::getStruct(var0, "targetname");
  var2 = spawn("script_model", var1.origin);
  var2 setModel("tag_origin");
  var2.headicon = deleteheadicon(var2);
  setheadiconfriendlyimage(var2.headicon, "hud_icon_survival_weapon");
  setheadicondrawthroughgeo(var2.headicon, 0);
  setheadiconsnaptoedges(var2.headicon, 1024);
  setheadiconmaxdistance(var2.headicon, 30);
  addclienttoheadiconmask(var2.headicon, 10);
  var2 makeusable();
  var2 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_ARMSDEALER/EDIT_LOADOUT", 25, "duration_short", "hide", 256, 65, 64, 65);
  level.camera_loadout_showcase_preview_sticker = var2;

  for(;;) {
    var2 waittill("trigger", var3);

    if(!var3 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var3 thread scripts\mp\vehicles\vehicle_damage_mp::edit_loadout(var2);
  }

  return var2;
}

function init_laser_traps(var0) {
  var1 = scripts\engine\utility::getStruct("armsdealer_return_silencer_interaction", "targetname");
  thread init_laser_trap(var1, var0);
}

function init_laser_trap(var0, var1) {
  var2 = spawn("script_model", var0.origin);
  var2 setModel("attachment_wm_sn_alpha50_silencer01");
  var2.angles = scripts\engine\utility::ter_op(isDefined(var0.angles), var0.angles, (0, 0, 0));
  thread ref_13397(var2, var2);
}

function ref_13397(var0, var1) {
  var0 endon("death");
  var0 setHintString(&"COOP_STEALTH/PICK_UP_SILENCER");
  var0 setCursorHint("HINT_BUTTON");
  var0 sethintdisplayrange(128);
  var0 sethintdisplayfov(120);
  var0 setusefov(120);
  var0 setuserange(128);
  var0 sethintonobstruction("show");
  objective_setlocation(var1.objectiveindex, 0, var0.origin);
  objective_setzoffset(var1.objectiveindex, 15);
  var0 makeusable();

  for(;;) {
    var0 waittill("trigger", var2);

    if(isPlayer(var2)) {
      var3 = 1;
      var4 = var2 getcurrentweapon();

      if(weaponclass(var4) == "rocketlauncher" || weaponclass(var4) == "grenade") {
        var2 thread scripts\cp\utility::hint_prompt("invalid_attachment", 1, 2);
        continue;
      }

      if(var4.basename == "iw8_me_riotshield_mp") {
        var2 thread scripts\cp\utility::hint_prompt("invalid_attachment", 1, 2);
        continue;
      }

      if(var4.basename == "iw8_pi_cpapa_mp" || issubstr(var4.basename, "cpapa")) {
        var2 thread scripts\cp\utility::hint_prompt("invalid_attachment", 1, 2);
        continue;
      }

      if(var4.basename == "iw8_sn_crossbow_mp") {
        var2 thread scripts\cp\utility::hint_prompt("invalid_attachment", 1, 2);
        continue;
      }

      var5 = var2.currentweapon;
      var6 = var5;
      var7 = undefined;
      var8 = scripts\cp\utility::attachmentmap_tounique("silencer", var6);

      for(var9 = 0; var9 < var5.attachments.size; var9++) {
        if(var6 canuseattachment(var8) && scripts\cp\cp_weapon::attachmentsconflict(var5.attachments[var9], var8, var6) == "") {
          var3 = 1;
          continue;
        }

        var3 = 0;
        break;
      }

      if(var3) {
        var7 = var6 withattachment(var8);
      }

      if(!isDefined(var7)) {
        if(!isbot(var2)) {
          var2 thread scripts\cp\utility::hint_prompt("invalid_attachment", 1, 2);
        }

        continue;
      }

      var2 scripts\cp_mp\utility\inventory_utility::_takeweapon(var5);
      var2 giveweapon(var7);
      var2 setweaponammoclip(var7, weaponclipsize(var7));
      var2 setweaponammostock(var7, weaponmaxammo(var7));
      var2 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var7);
      scripts\cp\cp_weapon::fixupplayerweapons(var2, var7);
    }
  }
}