/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3482.gsc
***************************************/

init() {
  level.var_C73F = [];
  level.var_C73F["escort_airdrop"] = spawnStruct();
  level.var_C73F["escort_airdrop"].vehicle = "osprey_mp";
  level.var_C73F["escort_airdrop"].modelbase = "vehicle_v22_osprey_body_mp";
  level.var_C73F["escort_airdrop"].var_B91B = "vehicle_v22_osprey_blades_mp";
  level.var_C73F["escort_airdrop"].var_11415 = "tag_le_door_attach";
  level.var_C73F["escort_airdrop"].var_11416 = "tag_ri_door_attach";
  level.var_C73F["escort_airdrop"].var_113F0 = "tag_turret_attach";
  level.var_C73F["escort_airdrop"].var_DA71 = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
  level.var_C73F["escort_airdrop"].name = &"KILLSTREAKS_ESCORT_AIRDROP";
  level.var_C73F["escort_airdrop"].weaponinfo = "osprey_minigun_mp";
  level.var_C73F["escort_airdrop"].helitype = "osprey";
  level.var_C73F["escort_airdrop"].droptype = "airdrop_escort";
  level.var_C73F["escort_airdrop"].maxhealth = level.var_8D73 * 2;
  level.var_C73F["escort_airdrop"].timeout = 60.0;
  level.var_C73F["osprey_gunner"] = spawnStruct();
  level.var_C73F["osprey_gunner"].vehicle = "osprey_player_mp";
  level.var_C73F["osprey_gunner"].modelbase = "vehicle_v22_osprey_body_mp";
  level.var_C73F["osprey_gunner"].var_B91B = "vehicle_v22_osprey_blades_mp";
  level.var_C73F["osprey_gunner"].var_11415 = "tag_le_door_attach";
  level.var_C73F["osprey_gunner"].var_11416 = "tag_ri_door_attach";
  level.var_C73F["osprey_gunner"].var_113F0 = "tag_turret_attach";
  level.var_C73F["osprey_gunner"].var_DA71 = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
  level.var_C73F["osprey_gunner"].name = &"KILLSTREAKS_OSPREY_GUNNER";
  level.var_C73F["osprey_gunner"].weaponinfo = "osprey_player_minigun_mp";
  level.var_C73F["osprey_gunner"].helitype = "osprey_gunner";
  level.var_C73F["osprey_gunner"].droptype = "airdrop_osprey_gunner";
  level.var_C73F["osprey_gunner"].maxhealth = level.var_8D73 * 2;
  level.var_C73F["osprey_gunner"].timeout = 75.0;

  foreach(var_1 in level.var_C73F) {
    level.chopper_fx["explode"]["death"][var_1.modelbase] = loadfx("vfx\core\expl\helicopter_explosion_osprey");
    level.chopper_fx["explode"]["air_death"][var_1.modelbase] = loadfx("vfx\core\expl\helicopter_explosion_osprey_air_mp");
    level.chopper_fx["anim"]["blades_anim_up"][var_1.modelbase] = loadfx("vfx\props\osprey_blades_anim_up");
    level.chopper_fx["anim"]["blades_anim_down"][var_1.modelbase] = loadfx("vfx\props\osprey_blades_anim_down");
    level.chopper_fx["anim"]["blades_static_up"][var_1.modelbase] = loadfx("vfx\props\osprey_blades_up");
    level.chopper_fx["anim"]["blades_static_down"][var_1.modelbase] = loadfx("vfx\props\osprey_blades_default");
    level.chopper_fx["anim"]["hatch_left_static_up"][var_1.modelbase] = loadfx("vfx\props\osprey_bottom_door_left_default");
    level.chopper_fx["anim"]["hatch_left_anim_down"][var_1.modelbase] = loadfx("vfx\props\osprey_bottom_door_left_anim_open");
    level.chopper_fx["anim"]["hatch_left_static_down"][var_1.modelbase] = loadfx("vfx\props\osprey_bottom_door_left_up");
    level.chopper_fx["anim"]["hatch_left_anim_up"][var_1.modelbase] = loadfx("vfx\props\osprey_bottom_door_left_anim_close");
    level.chopper_fx["anim"]["hatch_right_static_up"][var_1.modelbase] = loadfx("vfx\props\osprey_bottom_door_right_default");
    level.chopper_fx["anim"]["hatch_right_anim_down"][var_1.modelbase] = loadfx("vfx\props\osprey_bottom_door_right_anim_open");
    level.chopper_fx["anim"]["hatch_right_static_down"][var_1.modelbase] = loadfx("vfx\props\osprey_bottom_door_right_up");
    level.chopper_fx["anim"]["hatch_right_anim_up"][var_1.modelbase] = loadfx("vfx\props\osprey_bottom_door_right_anim_close");
  }

  level.var_1A6F = [];
  scripts\mp\killstreaks\killstreaks::registerkillstreak("escort_airdrop", ::tryuseescortairdrop);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("osprey_gunner", ::func_128F3);
}

tryuseescortairdrop(var_0, var_1) {
  var_2 = 1;

  if(isDefined(level.chopper)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  if(scripts\mp\utility\game::iskillstreakdenied()) {
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
  return 1;
}

func_128F3(var_0, var_1) {
  var_2 = 1;

  if(isDefined(level.chopper)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_4 = func_F1AD(var_0, "osprey_gunner", "compass_objpoint_osprey_friendly", "compass_objpoint_osprey_enemy", &"KILLSTREAKS_SELECT_MOBILE_MORTAR_LOCATION");

  if(!isDefined(var_4) || !var_4) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("osprey_gunner", self.origin);
  return 1;
}

func_6CE4(var_0, var_1, var_2, var_3) {
  self notify("used");
  var_4 = (0, var_2, 0);
  var_5 = 12000;
  var_6 = getent("airstrikeheight", "targetname");
  var_7 = var_6.origin[2];
  var_8 = level.var_8D96[randomint(level.var_8D96.size)];
  var_9 = var_8.origin;
  var_10 = (var_1[0], var_1[1], var_7);
  var_11 = var_1 + anglesToForward(var_4) * var_5;
  var_12 = vectortoangles(var_10 - var_9);
  var_13 = var_1;
  var_1 = (var_1[0], var_1[1], var_7);
  var_14 = func_4983(self, var_0, var_9, var_12, var_1, var_3);
  var_9 = var_8;
  func_130E3(var_0, var_14, var_9, var_10, var_11, var_7, var_13);
}

func_6CDF(var_0, var_1, var_2, var_3) {
  self notify("used");
  var_4 = (0, var_2, 0);
  var_5 = 12000;
  var_6 = getent("airstrikeheight", "targetname");
  var_7 = var_6.origin[2];
  var_8 = level.var_8D96[randomint(level.var_8D96.size)];
  var_9 = var_8.origin;
  var_10 = (var_1[0], var_1[1], var_7);
  var_11 = var_1 + anglesToForward(var_4) * var_5;
  var_12 = vectortoangles(var_10 - var_9);
  var_1 = (var_1[0], var_1[1], var_7);
  var_13 = func_4983(self, var_0, var_9, var_12, var_1, var_3);
  var_9 = var_8;
  func_130B6(var_0, var_13, var_9, var_10, var_11, var_7);
}

func_11089() {
  self waittill("stop_location_selection", var_0);

  switch (var_0) {
    case "emp":
    case "weapon_change":
    case "cancel_location":
    case "disconnect":
    case "death":
      self notify("customCancelLocation");
      break;
  }
}

func_F1AD(var_0, var_1, var_2, var_3, var_4) {
  self endon("customCancelLocation");
  var_5 = undefined;
  var_6 = level.mapsize / 6.46875;

  if(level.splitscreen) {
    var_6 = var_6 * 1.5;
  }

  scripts\mp\utility\game::_beginlocationselection(var_1, "map_artillery_selector", 0, 500);
  thread func_11089();
  self waittill("confirm_location", var_7, var_8);
  scripts\mp\utility\game::func_11079(0);
  scripts\mp\utility\game::setusingremote(var_1);
  var_9 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var_1);

  if(var_9 != "success") {
    if(var_9 != "disconnect") {
      scripts\mp\utility\game::clearusingremote();
    }

    return 0;
  }

  if(isDefined(level.chopper)) {
    scripts\mp\utility\game::clearusingremote();
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility\game::maxvehiclesallowed()) {
    scripts\mp\utility\game::clearusingremote();
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  thread func_6CDF(var_0, var_7, var_8, var_1);
  return 1;
}

func_1012E(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\hud_util::createfontstring("bigfixed", 0.5);
  var_4 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  var_4 give_zap_perk(var_2);
  self.locationobjectives = [];

  for(var_5 = 0; var_5 < var_3; var_5++) {
    self.locationobjectives[var_5] = ::scripts\mp\objidpoolmanager::requestminimapid(1);

    if(self.locationobjectives[var_5] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(self.locationobjectives[var_5], "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_position(self.locationobjectives[var_5], level.var_1A6F[level.script][var_5]["origin"]);
      scripts\mp\objidpoolmanager::minimap_objective_state(self.locationobjectives[var_5], "active");
      scripts\mp\objidpoolmanager::minimap_objective_player(self.locationobjectives[var_5], self getentitynumber());

      if(level.var_1A6F[level.script][var_5]["in_use"] == 1) {
        scripts\mp\objidpoolmanager::minimap_objective_icon(self.locationobjectives[var_5], var_1);
        continue;
      }

      scripts\mp\objidpoolmanager::minimap_objective_icon(self.locationobjectives[var_5], var_0);
    }
  }

  scripts\engine\utility::waittill_any("cancel_location", "picked_location", "stop_location_selection");
  var_4 scripts\mp\hud_util::destroyelem();

  for(var_5 = 0; var_5 < var_3; var_5++) {
    scripts\mp\objidpoolmanager::returnminimapid(self.locationobjectives[var_5]);
  }
}

func_4983(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnhelicopter(var_0, var_2, var_3, level.var_C73F[var_5].vehicle, level.var_C73F[var_5].modelbase);

  if(!isDefined(var_6)) {
    return undefined;
  }

  var_6.var_C740 = var_5;
  var_6.var_8DA0 = level.var_C73F[var_5].modelbase;
  var_6.helitype = level.var_C73F[var_5].helitype;
  var_6.attractor = missile_createattractorent(var_6, level.var_8D2E, level.var_8D2D);
  var_6.lifeid = var_1;
  var_6.team = var_0.pers["team"];
  var_6.pers["team"] = var_0.pers["team"];
  var_6.owner = var_0;
  var_6 setotherent(var_0);
  var_6.maxhealth = level.var_C73F[var_5].maxhealth;
  var_6.zoffset = (0, 0, 0);
  var_6.var_11568 = level.var_8D9A;
  var_6.primarytarget = undefined;
  var_6.secondarytarget = undefined;
  var_6.attacker = undefined;
  var_6.currentstate = "ok";
  var_6.droptype = level.var_C73F[var_5].droptype;
  var_6 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_0);
  level.chopper = var_6;
  var_6 scripts\mp\killstreaks\helicopter::func_184E();
  var_6 thread scripts\mp\killstreaks\flares::flares_monitor(2);
  var_6 thread scripts\mp\killstreaks\helicopter::heli_leave_on_disconnect(var_0);
  var_6 thread scripts\mp\killstreaks\helicopter::heli_leave_on_changeteams(var_0);
  var_6 thread scripts\mp\killstreaks\helicopter::heli_leave_on_gameended(var_0);
  var_7 = level.var_C73F[var_5].timeout;
  var_6 thread scripts\mp\killstreaks\helicopter::heli_leave_on_timeout(var_7);
  var_6 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor(var_5, 0);
  var_6 thread scripts\mp\killstreaks\helicopter::heli_health();
  var_6 thread scripts\mp\killstreaks\helicopter::func_8D49();
  var_6 thread func_1AE8();
  var_6 thread func_1AEA();

  if(var_5 == "escort_airdrop") {
    var_8 = var_6.origin + (anglesToForward(var_6.angles) * -200 + anglestoright(var_6.angles) * -200) + (0, 0, 200);
    var_6.killcament = spawn("script_model", var_8);
    var_6.killcament setscriptmoverkillcam("explosive");
    var_6.killcament linkto(var_6, "tag_origin");
  }

  return var_6;
}

func_1AE8() {
  self endon("death");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait 0.05;
  playFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH");
  wait 0.05;
  playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415);
  wait 0.05;
  playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416);
}

func_1AEA() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    thread func_1AE9(var_0);
  }
}

func_1AE9(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  wait 0.05;
  playfxontagforclients(level.chopper_fx["light"]["tail"], self, "tag_light_tail", var_0);
  wait 0.05;
  playfxontagforclients(level.chopper_fx["light"]["belly"], self, "tag_light_belly", var_0);

  if(isDefined(self.var_DA9F)) {
    if(self.var_DA9F == "up") {
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["blades_static_up"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH", var_0);
    } else {
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["blades_static_down"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH", var_0);
    }
  } else {
    wait 0.05;
    playfxontagforclients(level.chopper_fx["anim"]["blades_static_down"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH", var_0);
  }

  if(isDefined(self.var_8C42)) {
    if(self.var_8C42 == "down") {
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415, var_0);
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416, var_0);
    } else {
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415, var_0);
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416, var_0);
    }
  } else {
    wait 0.05;
    playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415, var_0);
    wait 0.05;
    playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416, var_0);
  }
}

func_130E3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 thread func_1AE6(self, var_2, var_3, var_4, var_5, var_6);
}

func_130B6(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread func_E4F8(var_0, var_1);
  var_1 thread func_1AE7(self, var_2, var_3, var_4, var_5);
}

func_E4F8(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("helicopter_done");
  thread scripts\mp\utility\game::teamplayercardsplash("used_osprey_gunner", self);
  scripts\mp\utility\game::_giveweapon("heli_remote_mp");
  scripts\mp\utility\game::_switchtoweapon("heli_remote_mp");

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\game::setthirdpersondof(0);
  }

  var_1 _meth_83ED(self);
  self getwholescenedurationmax(var_1, "tag_player", 1.0, 0, 0, 0, 0, 1);
  self setplayerangles(var_1 gettagangles("tag_player"));
  var_1 thread scripts\mp\killstreaks\helicopter::heli_targeting();
  var_1.gunner = self;
  self.var_8DD2 = var_0;
  thread func_6381(var_1);
  thread waitsetthermal(1.0, var_1);
  thread scripts\mp\utility\game::reinitializethermal(var_1);

  for(;;) {
    var_1 waittill("turret_fire");
    var_1 fireweapon();
    earthquake(0.2, 1, var_1.origin, 1000);
  }
}

waitsetthermal(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("death");
  var_1 endon("helicopter_done");
  var_1 endon("crashing");
  var_1 endon("leaving");
  wait(var_0);
  self visionsetthermalforplayer(level.ac130.enhanced_vision, 0);
  self.lastvisionsetthermal = level.ac130.enhanced_vision;
  self thermalvisionon();
  self thermalvisionfofoverlayon();
}

func_1011E(var_0) {
  self endon("disconnect");
  var_0 endon("helicopter_done");
  self.var_6741 = scripts\mp\hud_util::createfontstring("bigfixed", 1.5);
  self.var_6741 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  self.var_6741 give_zap_perk(level.var_C73F[var_0.var_C740].var_DA71);
  wait 6;

  if(isDefined(self.var_6741)) {
    self.var_6741 scripts\mp\hud_util::destroyelem();
  }
}

func_1AEE() {
  self endon("crashing");
  self endon("death");
  stopFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH");
  playFXOnTag(level.chopper_fx["anim"]["blades_anim_up"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH");
  wait 1.0;

  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["blades_static_up"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH");
    self.var_DA9F = "up";
  }
}

func_1AED() {
  self endon("crashing");
  self endon("death");
  stopFXOnTag(level.chopper_fx["anim"]["blades_static_up"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH");
  playFXOnTag(level.chopper_fx["anim"]["blades_anim_down"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH");
  wait 1.0;

  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH");
    self.var_DA9F = "down";
  }
}

func_1AEC() {
  self endon("crashing");
  self endon("death");
  stopFXOnTag(level.chopper_fx["anim"]["hatch_left_static_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415);
  playFXOnTag(level.chopper_fx["anim"]["hatch_left_anim_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415);
  stopFXOnTag(level.chopper_fx["anim"]["hatch_right_static_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416);
  playFXOnTag(level.chopper_fx["anim"]["hatch_right_anim_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416);
  wait 1.0;

  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415);
    playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416);
    self.var_8C42 = "up";
  }
}

func_1AEB() {
  self endon("crashing");
  self endon("death");
  stopFXOnTag(level.chopper_fx["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415);
  playFXOnTag(level.chopper_fx["anim"]["hatch_left_anim_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415);
  stopFXOnTag(level.chopper_fx["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416);
  playFXOnTag(level.chopper_fx["anim"]["hatch_right_anim_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416);
  wait 1.0;

  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415);
    playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416);
    self.var_8C42 = "down";
  }

  self notify("hatch_down");
}

func_7DFC(var_0) {
  self endon("helicopter_removed");
  self endon("heightReturned");
  var_1 = getent("airstrikeheight", "targetname");

  if(isDefined(var_1)) {
    var_2 = var_1.origin[2];
  } else if(isDefined(level.airstrikeheightscale)) {
    var_2 = 850 * level.airstrikeheightscale;
  } else {
    var_2 = 850;
  }

  self.var_2A95 = var_2;
  var_3 = 200;
  var_4 = 0;
  var_5 = 0;

  for(var_6 = 0; var_6 < 125; var_6++) {
    wait 0.05;
    var_7 = var_6 % 8;
    var_8 = var_6 * 3;

    switch (var_7) {
      case 0:
        var_4 = var_8;
        var_5 = var_8;
        break;
      case 1:
        var_4 = var_8 * -1;
        var_5 = var_8 * -1;
        break;
      case 2:
        var_4 = var_8 * -1;
        var_5 = var_8;
        break;
      case 3:
        var_4 = var_8;
        var_5 = var_8 * -1;
        break;
      case 4:
        var_4 = 0;
        var_5 = var_8 * -1;
        break;
      case 5:
        var_4 = var_8 * -1;
        var_5 = 0;
        break;
      case 6:
        var_4 = var_8;
        var_5 = 0;
        break;
      case 7:
        var_4 = 0;
        var_5 = var_8;
        break;
      default:
        break;
    }

    var_9 = bulletTrace(var_0 + (var_4, var_5, 1000), var_0 + (var_4, var_5, -10000), 1, self);

    if(var_9["position"][2] > var_3) {
      var_3 = var_9["position"][2];
    }
  }

  self.var_2A95 = var_3 + 300;

  switch (getdvar("mapname")) {
    case "mp_morningwood":
      self.var_2A95 = self.var_2A95 + 600;
      break;
    case "mp_overwatch":
      var_10 = level.spawnpoints;
      var_11 = var_10[0];
      var_12 = var_10[0];

      foreach(var_14 in var_10) {
        if(var_14.origin[2] < var_11.origin[2]) {
          var_11 = var_14;
        }

        if(var_14.origin[2] > var_12.origin[2]) {
          var_12 = var_14;
        }
      }

      if(var_3 < var_11.origin[2] - 100) {
        self.var_2A95 = var_12.origin[2] + 900;
      }

      break;
  }
}

func_1AE6(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("airshipFlyDefense");
  self endon("airshipFlyDefense");
  self endon("helicopter_removed");
  self endon("death");
  self endon("leaving");
  thread func_7DFC(var_2);
  scripts\mp\killstreaks\helicopter::heli_fly_simple_path(var_1);
  self.var_C96C = var_2;
  var_6 = self.angles;
  self setyawspeed(30, 30, 30, 0.3);
  var_7 = self.origin;
  var_8 = self.angles[1];
  var_9 = self.angles[0];
  self.timeout = level.var_C73F[self.var_C740].timeout;
  self setvehgoalpos(var_2, 1);
  var_10 = gettime();
  self waittill("goal");
  var_11 = (gettime() - var_10) * 0.001;
  self.timeout = self.timeout - var_11;
  thread func_1AEE();
  var_12 = var_2 * (1, 1, 0);
  var_12 = var_12 + (0, 0, self.var_2A95);
  self vehicle_setspeed(25, 10, 10);
  self setyawspeed(20, 10, 10, 0.3);
  self setvehgoalpos(var_12, 1);
  var_10 = gettime();
  self waittill("goal");
  var_11 = (gettime() - var_10) * 0.001;
  self.timeout = self.timeout - var_11;
  self sethoverparams(65, 50, 50);
  func_C73E(1, level.var_C73F[self.var_C740].var_113F0, var_12);
  thread func_A663(var_5);

  if(isDefined(var_0)) {
    var_0 scripts\engine\utility::waittill_any_timeout(self.timeout, "disconnect");
  }

  self waittill("leaving");
  self notify("osprey_leaving");
  thread func_1AED();
}

wait_and_delete(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self delete();
}

func_A663(var_0) {
  self endon("osprey_leaving");
  self endon("helicopter_removed");
  self endon("death");
  var_1 = var_0;

  for(;;) {
    foreach(var_3 in level.players) {
      wait 0.05;

      if(!isDefined(self)) {
        return;
      }
      if(!isDefined(var_3)) {
        continue;
      }
      if(!scripts\mp\utility\game::isreallyalive(var_3)) {
        continue;
      }
      if(!self.owner scripts\mp\utility\game::isenemy(var_3)) {
        continue;
      }
      if(var_3 scripts\mp\utility\game::_hasperk("specialty_blindeye")) {
        continue;
      }
      if(distancesquared(var_1, var_3.origin) > 500000) {
        continue;
      }
      thread func_1B01(var_3, var_1);
      func_136B2();
    }
  }
}

func_1B01(var_0, var_1) {
  self notify("aiShootPlayer");
  self endon("aiShootPlayer");
  self endon("helicopter_removed");
  self endon("leaving");
  var_0 endon("death");
  self setturrettargetent(var_0);
  self setlookatent(var_0);
  thread func_1155A(var_0);
  var_2 = 6;
  var_3 = 2;

  for(;;) {
    var_2--;
    self fireweapon("tag_flash", var_0);
    wait 0.15;

    if(var_2 <= 0) {
      var_3--;
      var_2 = 6;

      if(distancesquared(var_0.origin, var_1) > 500000 || var_3 <= 0 || !scripts\mp\utility\game::isreallyalive(var_0)) {
        self notify("abandon_target");
        return;
      }

      wait 1;
    }
  }
}

func_1155A(var_0) {
  self endon("abandon_target");
  self endon("leaving");
  self endon("helicopter_removed");
  var_0 waittill("death");
  self notify("target_killed");
}

func_136B2() {
  self endon("helicopter_removed");
  self endon("leaving");
  self endon("target_killed");
  self endon("abandon_target");

  for(;;) {
    wait 0.05;
  }
}

func_1AE7(var_0, var_1, var_2, var_3, var_4) {
  self notify("airshipFlyGunner");
  self endon("airshipFlyGunner");
  self endon("helicopter_removed");
  self endon("death");
  self endon("leaving");
  thread func_7DFC(var_2);
  scripts\mp\killstreaks\helicopter::heli_fly_simple_path(var_1);
  thread scripts\mp\killstreaks\helicopter::heli_leave_on_timeout(level.var_C73F[self.var_C740].timeout);
  var_5 = self.angles;
  self setyawspeed(30, 30, 30, 0.3);
  var_6 = self.origin;
  var_7 = self.angles[1];
  var_8 = self.angles[0];
  self.timeout = level.var_C73F[self.var_C740].timeout;
  self setvehgoalpos(var_2, 1);
  var_9 = gettime();
  self waittill("goal");
  var_10 = (gettime() - var_9) * 0.001;
  self.timeout = self.timeout - var_10;
  thread func_1AEE();
  var_11 = var_2 * (1, 1, 0);
  var_11 = var_11 + (0, 0, self.var_2A95);
  self vehicle_setspeed(25, 10, 10);
  self setyawspeed(20, 10, 10, 0.3);
  self setvehgoalpos(var_11, 1);
  var_9 = gettime();
  self waittill("goal");
  var_10 = (gettime() - var_9) * 0.001;
  self.timeout = self.timeout - var_10;
  func_C73D(1, level.var_C73F[self.var_C740].var_113F0, var_11);
  var_12 = 1.0;

  if(isDefined(var_0)) {
    var_0 scripts\engine\utility::waittill_any_timeout(var_12, "disconnect");
  }

  self.timeout = self.timeout - var_12;
  self setvehgoalpos(var_2, 1);
  var_9 = gettime();
  self waittill("goal");
  var_10 = (gettime() - var_9) * 0.001;
  self.timeout = self.timeout - var_10;
  var_13 = getEntArray("heli_attack_area", "targetname");
  var_14 = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];

  if(var_13.size) {
    thread scripts\mp\killstreaks\helicopter::func_8D55(var_13);
  } else {
    thread scripts\mp\killstreaks\helicopter::heli_fly_loop_path(var_14);
  }

  self waittill("leaving");
  thread func_1AED();
}

func_C73E(var_0, var_1, var_2) {
  thread func_1AEB();
  self waittill("hatch_down");
  level notify("escort_airdrop_started", self);
  var_3[0] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(10), randomint(10), randomint(10)), undefined, var_1);
  wait 0.05;
  self notify("drop_crate");
  wait(var_0);
  var_3[1] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(100), randomint(100), randomint(100)), var_3, var_1);
  wait 0.05;
  self notify("drop_crate");
  wait(var_0);
  var_3[2] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(50), randomint(50), randomint(50)), var_3, var_1);
  wait 0.05;
  self notify("drop_crate");
  wait(var_0);
  var_3[3] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomintrange(-100, 0), randomintrange(-100, 0), randomintrange(-100, 0)), var_3, var_1);
  wait 0.05;
  self notify("drop_crate");
  wait(var_0);
  thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomintrange(-50, 0), randomintrange(-50, 0), randomintrange(-50, 0)), var_3, var_1);
  wait 0.05;
  self notify("drop_crate");
  wait 1.0;
  thread func_1AEC();
}

func_C73D(var_0, var_1, var_2) {
  thread func_1AEB();
  self waittill("hatch_down");
  var_3[0] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(10), randomint(10), randomint(10)), undefined, var_1);
  wait 0.05;
  self.timeout = self.timeout - 0.05;
  self notify("drop_crate");
  wait(var_0);
  self.timeout = self.timeout - var_0;
  var_3[1] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(100), randomint(100), randomint(100)), var_3, var_1);
  wait 0.05;
  self.timeout = self.timeout - 0.05;
  self notify("drop_crate");
  wait(var_0);
  self.timeout = self.timeout - var_0;
  var_3[2] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(50), randomint(50), randomint(50)), var_3, var_1);
  wait 0.05;
  self.timeout = self.timeout - 0.05;
  self notify("drop_crate");
  wait 1.0;
  thread func_1AEC();
}

func_6380(var_0) {
  if(isDefined(self.var_6741)) {
    self.var_6741 scripts\mp\hud_util::destroyelem();
  }

  self _meth_8258();
  self thermalvisionoff();
  self thermalvisionfofoverlayoff();
  self unlink();
  scripts\mp\utility\game::clearusingremote();

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\game::setthirdpersondof(1);
  }

  self visionsetthermalforplayer(game["thermal_vision"], 0);

  if(isDefined(var_0)) {
    var_0 _meth_83EC(self);
  }

  self notify("heliPlayer_removed");
  scripts\mp\utility\game::_switchtoweapon(scripts\engine\utility::getlastweapon());
  scripts\mp\utility\game::_takeweapon("heli_remote_mp");
}

func_6381(var_0) {
  self endon("disconnect");
  var_0 waittill("helicopter_done");
  func_6380(var_0);
}