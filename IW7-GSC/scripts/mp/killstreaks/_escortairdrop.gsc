/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_escortairdrop.gsc
*****************************************************/

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
  level.var_C73F["escort_airdrop"].var_39B = "osprey_minigun_mp";
  level.var_C73F["escort_airdrop"].helitype = "osprey";
  level.var_C73F["escort_airdrop"].droptype = "airdrop_escort";
  level.var_C73F["escort_airdrop"].maxhealth = level.var_8D73 * 2;
  level.var_C73F["escort_airdrop"].timeout = 60;
  level.var_C73F["osprey_gunner"] = spawnStruct();
  level.var_C73F["osprey_gunner"].vehicle = "osprey_player_mp";
  level.var_C73F["osprey_gunner"].modelbase = "vehicle_v22_osprey_body_mp";
  level.var_C73F["osprey_gunner"].var_B91B = "vehicle_v22_osprey_blades_mp";
  level.var_C73F["osprey_gunner"].var_11415 = "tag_le_door_attach";
  level.var_C73F["osprey_gunner"].var_11416 = "tag_ri_door_attach";
  level.var_C73F["osprey_gunner"].var_113F0 = "tag_turret_attach";
  level.var_C73F["osprey_gunner"].var_DA71 = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
  level.var_C73F["osprey_gunner"].name = &"KILLSTREAKS_OSPREY_GUNNER";
  level.var_C73F["osprey_gunner"].var_39B = "osprey_player_minigun_mp";
  level.var_C73F["osprey_gunner"].helitype = "osprey_gunner";
  level.var_C73F["osprey_gunner"].droptype = "airdrop_osprey_gunner";
  level.var_C73F["osprey_gunner"].maxhealth = level.var_8D73 * 2;
  level.var_C73F["osprey_gunner"].timeout = 75;
  foreach(var_01 in level.var_C73F) {
    level.chopper_fx["explode"]["death"][var_01.modelbase] = loadfx("vfx\core\expl\helicopter_explosion_osprey");
    level.chopper_fx["explode"]["air_death"][var_01.modelbase] = loadfx("vfx\core\expl\helicopter_explosion_osprey_air_mp");
    level.chopper_fx["anim"]["blades_anim_up"][var_01.modelbase] = loadfx("vfx\props\osprey_blades_anim_up");
    level.chopper_fx["anim"]["blades_anim_down"][var_01.modelbase] = loadfx("vfx\props\osprey_blades_anim_down");
    level.chopper_fx["anim"]["blades_static_up"][var_01.modelbase] = loadfx("vfx\props\osprey_blades_up");
    level.chopper_fx["anim"]["blades_static_down"][var_01.modelbase] = loadfx("vfx\props\osprey_blades_default");
    level.chopper_fx["anim"]["hatch_left_static_up"][var_01.modelbase] = loadfx("vfx\props\osprey_bottom_door_left_default");
    level.chopper_fx["anim"]["hatch_left_anim_down"][var_01.modelbase] = loadfx("vfx\props\osprey_bottom_door_left_anim_open");
    level.chopper_fx["anim"]["hatch_left_static_down"][var_01.modelbase] = loadfx("vfx\props\osprey_bottom_door_left_up");
    level.chopper_fx["anim"]["hatch_left_anim_up"][var_01.modelbase] = loadfx("vfx\props\osprey_bottom_door_left_anim_close");
    level.chopper_fx["anim"]["hatch_right_static_up"][var_01.modelbase] = loadfx("vfx\props\osprey_bottom_door_right_default");
    level.chopper_fx["anim"]["hatch_right_anim_down"][var_01.modelbase] = loadfx("vfx\props\osprey_bottom_door_right_anim_open");
    level.chopper_fx["anim"]["hatch_right_static_down"][var_01.modelbase] = loadfx("vfx\props\osprey_bottom_door_right_up");
    level.chopper_fx["anim"]["hatch_right_anim_up"][var_01.modelbase] = loadfx("vfx\props\osprey_bottom_door_right_anim_close");
  }

  level.var_1A6F = [];
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("escort_airdrop", ::tryuseescortairdrop);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("osprey_gunner", ::func_128F3);
}

tryuseescortairdrop(param_00, param_01) {
  var_02 = 1;
  if(isDefined(level.chopper)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  if(scripts\mp\utility::iskillstreakdenied()) {
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  return 1;
}

func_128F3(param_00, param_01) {
  var_02 = 1;
  if(isDefined(level.chopper)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility::incrementfauxvehiclecount();
  var_04 = func_F1AD(param_00, "osprey_gunner", "compass_objpoint_osprey_friendly", "compass_objpoint_osprey_enemy", &"KILLSTREAKS_SELECT_MOBILE_MORTAR_LOCATION");
  if(!isDefined(var_04) || !var_04) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("osprey_gunner", self.origin);
  return 1;
}

func_6CE4(param_00, param_01, param_02, param_03) {
  self notify("used");
  var_04 = (0, param_02, 0);
  var_05 = 12000;
  var_06 = getent("airstrikeheight", "targetname");
  var_07 = var_06.origin[2];
  var_08 = level.var_8D96[randomint(level.var_8D96.size)];
  var_09 = var_08.origin;
  var_0A = (param_01[0], param_01[1], var_07);
  var_0B = param_01 + anglesToForward(var_04) * var_05;
  var_0C = vectortoangles(var_0A - var_09);
  var_0D = param_01;
  param_01 = (param_01[0], param_01[1], var_07);
  var_0E = func_4983(self, param_00, var_09, var_0C, param_01, param_03);
  var_09 = var_08;
  func_130E3(param_00, var_0E, var_09, var_0A, var_0B, var_07, var_0D);
}

func_6CDF(param_00, param_01, param_02, param_03) {
  self notify("used");
  var_04 = (0, param_02, 0);
  var_05 = 12000;
  var_06 = getent("airstrikeheight", "targetname");
  var_07 = var_06.origin[2];
  var_08 = level.var_8D96[randomint(level.var_8D96.size)];
  var_09 = var_08.origin;
  var_0A = (param_01[0], param_01[1], var_07);
  var_0B = param_01 + anglesToForward(var_04) * var_05;
  var_0C = vectortoangles(var_0A - var_09);
  param_01 = (param_01[0], param_01[1], var_07);
  var_0D = func_4983(self, param_00, var_09, var_0C, param_01, param_03);
  var_09 = var_08;
  func_130B6(param_00, var_0D, var_09, var_0A, var_0B, var_07);
}

func_11089() {
  self waittill("stop_location_selection", var_00);
  switch (var_00) {
    case "emp":
    case "weapon_change":
    case "cancel_location":
    case "disconnect":
    case "death":
      self notify("customCancelLocation");
      break;
  }
}

func_F1AD(param_00, param_01, param_02, param_03, param_04) {
  self endon("customCancelLocation");
  var_05 = undefined;
  var_06 = level.mapsize / 6.46875;
  if(level.splitscreen) {
    var_06 = var_06 * 1.5;
  }

  scripts\mp\utility::_beginlocationselection(param_01, "map_artillery_selector", 0, 500);
  thread func_11089();
  self waittill("confirm_location", var_07, var_08);
  scripts\mp\utility::stoplocationselection(0);
  scripts\mp\utility::setusingremote(param_01);
  var_09 = scripts\mp\killstreaks\_killstreaks::initridekillstreak(param_01);
  if(var_09 != "success") {
    if(var_09 != "disconnect") {
      scripts\mp\utility::clearusingremote();
    }

    return 0;
  }

  if(isDefined(level.chopper)) {
    scripts\mp\utility::clearusingremote();
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility::maxvehiclesallowed()) {
    scripts\mp\utility::clearusingremote();
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  thread func_6CDF(param_00, var_07, var_08, param_01);
  return 1;
}

func_1012E(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\hud_util::createfontstring("bigfixed", 0.5);
  var_04 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  var_04 settext(param_02);
  self.locationobjectives = [];
  for(var_05 = 0; var_05 < param_03; var_05++) {
    self.locationobjectives[var_05] = scripts\mp\objidpoolmanager::requestminimapid(1);
    if(self.locationobjectives[var_05] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(self.locationobjectives[var_05], "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_position(self.locationobjectives[var_05], level.var_1A6F[level.script][var_05]["origin"]);
      scripts\mp\objidpoolmanager::minimap_objective_state(self.locationobjectives[var_05], "active");
      scripts\mp\objidpoolmanager::minimap_objective_player(self.locationobjectives[var_05], self getentitynumber());
      if(level.var_1A6F[level.script][var_05]["in_use"] == 1) {
        scripts\mp\objidpoolmanager::minimap_objective_icon(self.locationobjectives[var_05], param_01);
        continue;
      }

      scripts\mp\objidpoolmanager::minimap_objective_icon(self.locationobjectives[var_05], param_00);
    }
  }

  scripts\engine\utility::waittill_any_3("cancel_location", "picked_location", "stop_location_selection");
  var_04 scripts\mp\hud_util::destroyelem();
  for(var_05 = 0; var_05 < param_03; var_05++) {
    scripts\mp\objidpoolmanager::returnminimapid(self.locationobjectives[var_05]);
  }
}

func_4983(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnhelicopter(param_00, param_02, param_03, level.var_C73F[param_05].vehicle, level.var_C73F[param_05].modelbase);
  if(!isDefined(var_06)) {
    return undefined;
  }

  var_06.var_C740 = param_05;
  var_06.var_8DA0 = level.var_C73F[param_05].modelbase;
  var_06.helitype = level.var_C73F[param_05].helitype;
  var_06.attractor = missile_createattractorent(var_06, level.var_8D2E, level.var_8D2D);
  var_06.lifeid = param_01;
  var_06.team = param_00.pers["team"];
  var_06.pers["team"] = param_00.pers["team"];
  var_06.triggerportableradarping = param_00;
  var_06 setotherent(param_00);
  var_06.maxhealth = level.var_C73F[param_05].maxhealth;
  var_06.zoffset = (0, 0, 0);
  var_06.var_11568 = level.var_8D9A;
  var_06.primarytarget = undefined;
  var_06.secondarytarget = undefined;
  var_06.var_4F = undefined;
  var_06.currentstate = "ok";
  var_06.droptype = level.var_C73F[param_05].droptype;
  var_06 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", param_00);
  level.chopper = var_06;
  var_06 scripts\mp\killstreaks\_helicopter::func_184E();
  var_06 thread scripts\mp\killstreaks\_flares::flares_monitor(2);
  var_06 thread scripts\mp\killstreaks\_helicopter::heli_leave_on_disconnect(param_00);
  var_06 thread scripts\mp\killstreaks\_helicopter::heli_leave_on_changeteams(param_00);
  var_06 thread scripts\mp\killstreaks\_helicopter::heli_leave_on_gameended(param_00);
  var_07 = level.var_C73F[param_05].timeout;
  var_06 thread scripts\mp\killstreaks\_helicopter::heli_leave_on_timeout(var_07);
  var_06 thread scripts\mp\killstreaks\_helicopter::heli_damage_monitor(param_05, 0);
  var_06 thread scripts\mp\killstreaks\_helicopter::heli_health();
  var_06 thread scripts\mp\killstreaks\_helicopter::func_8D49();
  var_06 thread func_1AE8();
  var_06 thread func_1AEA();
  if(param_05 == "escort_airdrop") {
    var_08 = var_06.origin + anglesToForward(var_06.angles) * -200 + anglestoright(var_06.angles) * -200 + (0, 0, 200);
    var_06.killcament = spawn("script_model", var_08);
    var_06.killcament setscriptmoverkillcam("explosive");
    var_06.killcament linkto(var_06, "tag_origin");
  }

  return var_06;
}

func_1AE8() {
  self endon("death");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait(0.05);
  playFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH");
  wait(0.05);
  playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415);
  wait(0.05);
  playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416);
}

func_1AEA() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    thread func_1AE9(var_00);
  }
}

func_1AE9(param_00) {
  self endon("death");
  level endon("game_ended");
  param_00 endon("disconnect");
  wait(0.05);
  playfxontagforclients(level.chopper_fx["light"]["tail"], self, "tag_light_tail", param_00);
  wait(0.05);
  playfxontagforclients(level.chopper_fx["light"]["belly"], self, "tag_light_belly", param_00);
  if(isDefined(self.var_DA9F)) {
    if(self.var_DA9F == "up") {
      wait(0.05);
      playfxontagforclients(level.chopper_fx["anim"]["blades_static_up"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH", param_00);
    } else {
      wait(0.05);
      playfxontagforclients(level.chopper_fx["anim"]["blades_static_down"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH", param_00);
    }
  } else {
    wait(0.05);
    playfxontagforclients(level.chopper_fx["anim"]["blades_static_down"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH", param_00);
  }

  if(isDefined(self.var_8C42)) {
    if(self.var_8C42 == "down") {
      wait(0.05);
      playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415, param_00);
      wait(0.05);
      playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416, param_00);
      return;
    }

    wait(0.05);
    playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415, param_00);
    wait(0.05);
    playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416, param_00);
    return;
  }

  wait(0.05);
  playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415, param_00);
  wait(0.05);
  playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_up"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416, param_00);
}

func_130E3(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_01 thread func_1AE6(self, param_02, param_03, param_04, param_05, param_06);
}

func_130B6(param_00, param_01, param_02, param_03, param_04, param_05) {
  thread func_E4F8(param_00, param_01);
  param_01 thread func_1AE7(self, param_02, param_03, param_04, param_05);
}

func_E4F8(param_00, param_01) {
  self endon("disconnect");
  param_01 endon("helicopter_done");
  thread scripts\mp\utility::teamplayercardsplash("used_osprey_gunner", self);
  scripts\mp\utility::_giveweapon("heli_remote_mp");
  scripts\mp\utility::_switchtoweapon("heli_remote_mp");
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  param_01 _meth_83ED(self);
  self playerlinkweaponviewtodelta(param_01, "tag_player", 1, 0, 0, 0, 0, 1);
  self setplayerangles(param_01 gettagangles("tag_player"));
  param_01 thread scripts\mp\killstreaks\_helicopter::heli_targeting();
  param_01.gunner = self;
  self.var_8DD2 = param_00;
  thread func_6381(param_01);
  thread waitsetthermal(1, param_01);
  thread scripts\mp\utility::reinitializethermal(param_01);
  for(;;) {
    param_01 waittill("turret_fire");
    param_01 fireweapon();
    earthquake(0.2, 1, param_01.origin, 1000);
  }
}

waitsetthermal(param_00, param_01) {
  self endon("disconnect");
  param_01 endon("death");
  param_01 endon("helicopter_done");
  param_01 endon("crashing");
  param_01 endon("leaving");
  wait(param_00);
  self visionsetthermalforplayer(level.ac130.enhanced_vision, 0);
  self.lastvisionsetthermal = level.ac130.enhanced_vision;
  self thermalvisionon();
  self thermalvisionfofoverlayon();
}

func_1011E(param_00) {
  self endon("disconnect");
  param_00 endon("helicopter_done");
  self.var_6741 = scripts\mp\hud_util::createfontstring("bigfixed", 1.5);
  self.var_6741 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  self.var_6741 settext(level.var_C73F[param_00.var_C740].var_DA71);
  wait(6);
  if(isDefined(self.var_6741)) {
    self.var_6741 scripts\mp\hud_util::destroyelem();
  }
}

func_1AEE() {
  self endon("crashing");
  self endon("death");
  stopFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH");
  playFXOnTag(level.chopper_fx["anim"]["blades_anim_up"][level.var_C73F[self.var_C740].modelbase], self, "TAG_BLADES_ATTACH");
  wait(1);
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
  wait(1);
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
  wait(1);
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
  wait(1);
  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11415);
    playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_down"][level.var_C73F[self.var_C740].modelbase], self, level.var_C73F[self.var_C740].var_11416);
    self.var_8C42 = "down";
  }

  self notify("hatch_down");
}

func_7DFC(param_00) {
  self endon("helicopter_removed");
  self endon("heightReturned");
  var_01 = getent("airstrikeheight", "targetname");
  if(isDefined(var_01)) {
    var_02 = var_01.origin[2];
  } else if(isDefined(level.airstrikeheightscale)) {
    var_02 = 850 * level.airstrikeheightscale;
  } else {
    var_02 = 850;
  }

  self.var_2A95 = var_02;
  var_03 = 200;
  var_04 = 0;
  var_05 = 0;
  for(var_06 = 0; var_06 < 125; var_06++) {
    wait(0.05);
    var_07 = var_06 % 8;
    var_08 = var_06 * 3;
    switch (var_07) {
      case 0:
        var_04 = var_08;
        var_05 = var_08;
        break;

      case 1:
        var_04 = var_08 * -1;
        var_05 = var_08 * -1;
        break;

      case 2:
        var_04 = var_08 * -1;
        var_05 = var_08;
        break;

      case 3:
        var_04 = var_08;
        var_05 = var_08 * -1;
        break;

      case 4:
        var_04 = 0;
        var_05 = var_08 * -1;
        break;

      case 5:
        var_04 = var_08 * -1;
        var_05 = 0;
        break;

      case 6:
        var_04 = var_08;
        var_05 = 0;
        break;

      case 7:
        var_04 = 0;
        var_05 = var_08;
        break;

      default:
        break;
    }

    var_09 = bulletTrace(param_00 + (var_04, var_05, 1000), param_00 + (var_04, var_05, -10000), 1, self);
    if(var_09["position"][2] > var_03) {
      var_03 = var_09["position"][2];
    }
  }

  self.var_2A95 = var_03 + 300;
  switch (getdvar("mapname")) {
    case "mp_morningwood":
      self.var_2A95 = self.var_2A95 + 600;
      break;

    case "mp_overwatch":
      var_0A = level.spawnpoints;
      var_0B = var_0A[0];
      var_0C = var_0A[0];
      foreach(var_0E in var_0A) {
        if(var_0E.origin[2] < var_0B.origin[2]) {
          var_0B = var_0E;
        }

        if(var_0E.origin[2] > var_0C.origin[2]) {
          var_0C = var_0E;
        }
      }

      if(var_03 < var_0B.origin[2] - 100) {
        self.var_2A95 = var_0C.origin[2] + 900;
      }
      break;
  }
}

func_1AE6(param_00, param_01, param_02, param_03, param_04, param_05) {
  self notify("airshipFlyDefense");
  self endon("airshipFlyDefense");
  self endon("helicopter_removed");
  self endon("death");
  self endon("leaving");
  thread func_7DFC(param_02);
  scripts\mp\killstreaks\_helicopter::heli_fly_simple_path(param_01);
  self.var_C96C = param_02;
  var_06 = self.angles;
  self givelastonteamwarning(30, 30, 30, 0.3);
  var_07 = self.origin;
  var_08 = self.angles[1];
  var_09 = self.angles[0];
  self.timeout = level.var_C73F[self.var_C740].timeout;
  self setvehgoalpos(param_02, 1);
  var_0A = gettime();
  self waittill("goal");
  var_0B = gettime() - var_0A * 0.001;
  self.timeout = self.timeout - var_0B;
  thread func_1AEE();
  var_0C = param_02 * (1, 1, 0);
  var_0C = var_0C + (0, 0, self.var_2A95);
  self vehicle_setspeed(25, 10, 10);
  self givelastonteamwarning(20, 10, 10, 0.3);
  self setvehgoalpos(var_0C, 1);
  var_0A = gettime();
  self waittill("goal");
  var_0B = gettime() - var_0A * 0.001;
  self.timeout = self.timeout - var_0B;
  self sethoverparams(65, 50, 50);
  func_C73E(1, level.var_C73F[self.var_C740].var_113F0, var_0C);
  thread func_A663(param_05);
  if(isDefined(param_00)) {
    param_00 scripts\engine\utility::waittill_any_timeout_1(self.timeout, "disconnect");
  }

  self waittill("leaving");
  self notify("osprey_leaving");
  thread func_1AED();
}

wait_and_delete(param_00) {
  self endon("death");
  level endon("game_ended");
  wait(param_00);
  self delete();
}

func_A663(param_00) {
  self endon("osprey_leaving");
  self endon("helicopter_removed");
  self endon("death");
  var_01 = param_00;
  for(;;) {
    foreach(var_03 in level.players) {
      wait(0.05);
      if(!isDefined(self)) {
        return;
      }

      if(!isDefined(var_03)) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_03)) {
        continue;
      }

      if(!self.triggerportableradarping scripts\mp\utility::isenemy(var_03)) {
        continue;
      }

      if(var_03 scripts\mp\utility::_hasperk("specialty_blindeye")) {
        continue;
      }

      if(distancesquared(var_01, var_03.origin) > 500000) {
        continue;
      }

      thread func_1B01(var_03, var_01);
      func_136B2();
    }
  }
}

func_1B01(param_00, param_01) {
  self notify("aiShootPlayer");
  self endon("aiShootPlayer");
  self endon("helicopter_removed");
  self endon("leaving");
  param_00 endon("death");
  self setturrettargetent(param_00);
  self setlookatent(param_00);
  thread func_1155A(param_00);
  var_02 = 6;
  var_03 = 2;
  for(;;) {
    var_02--;
    self fireweapon("tag_flash", param_00);
    wait(0.15);
    if(var_02 <= 0) {
      var_03--;
      var_02 = 6;
      if(distancesquared(param_00.origin, param_01) > 500000 || var_03 <= 0 || !scripts\mp\utility::isreallyalive(param_00)) {
        self notify("abandon_target");
        return;
      }

      wait(1);
    }
  }
}

func_1155A(param_00) {
  self endon("abandon_target");
  self endon("leaving");
  self endon("helicopter_removed");
  param_00 waittill("death");
  self notify("target_killed");
}

func_136B2() {
  self endon("helicopter_removed");
  self endon("leaving");
  self endon("target_killed");
  self endon("abandon_target");
  wait(0.05);
}

func_1AE7(param_00, param_01, param_02, param_03, param_04) {
  self notify("airshipFlyGunner");
  self endon("airshipFlyGunner");
  self endon("helicopter_removed");
  self endon("death");
  self endon("leaving");
  thread func_7DFC(param_02);
  scripts\mp\killstreaks\_helicopter::heli_fly_simple_path(param_01);
  thread scripts\mp\killstreaks\_helicopter::heli_leave_on_timeout(level.var_C73F[self.var_C740].timeout);
  var_05 = self.angles;
  self givelastonteamwarning(30, 30, 30, 0.3);
  var_06 = self.origin;
  var_07 = self.angles[1];
  var_08 = self.angles[0];
  self.timeout = level.var_C73F[self.var_C740].timeout;
  self setvehgoalpos(param_02, 1);
  var_09 = gettime();
  self waittill("goal");
  var_0A = gettime() - var_09 * 0.001;
  self.timeout = self.timeout - var_0A;
  thread func_1AEE();
  var_0B = param_02 * (1, 1, 0);
  var_0B = var_0B + (0, 0, self.var_2A95);
  self vehicle_setspeed(25, 10, 10);
  self givelastonteamwarning(20, 10, 10, 0.3);
  self setvehgoalpos(var_0B, 1);
  var_09 = gettime();
  self waittill("goal");
  var_0A = gettime() - var_09 * 0.001;
  self.timeout = self.timeout - var_0A;
  func_C73D(1, level.var_C73F[self.var_C740].var_113F0, var_0B);
  var_0C = 1;
  if(isDefined(param_00)) {
    param_00 scripts\engine\utility::waittill_any_timeout_1(var_0C, "disconnect");
  }

  self.timeout = self.timeout - var_0C;
  self setvehgoalpos(param_02, 1);
  var_09 = gettime();
  self waittill("goal");
  var_0A = gettime() - var_09 * 0.001;
  self.timeout = self.timeout - var_0A;
  var_0D = getEntArray("heli_attack_area", "targetname");
  var_0E = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
  if(var_0D.size) {
    thread scripts\mp\killstreaks\_helicopter::func_8D55(var_0D);
  } else {
    thread scripts\mp\killstreaks\_helicopter::heli_fly_loop_path(var_0E);
  }

  self waittill("leaving");
  thread func_1AED();
}

func_C73E(param_00, param_01, param_02) {
  thread func_1AEB();
  self waittill("hatch_down");
  level notify("escort_airdrop_started", self);
  var_03[0] = thread scripts\mp\killstreaks\_airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(10), randomint(10), randomint(10)), undefined, param_01);
  wait(0.05);
  self notify("drop_crate");
  wait(param_00);
  var_03[1] = thread scripts\mp\killstreaks\_airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(100), randomint(100), randomint(100)), var_03, param_01);
  wait(0.05);
  self notify("drop_crate");
  wait(param_00);
  var_03[2] = thread scripts\mp\killstreaks\_airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(50), randomint(50), randomint(50)), var_03, param_01);
  wait(0.05);
  self notify("drop_crate");
  wait(param_00);
  var_03[3] = thread scripts\mp\killstreaks\_airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomintrange(-100, 0), randomintrange(-100, 0), randomintrange(-100, 0)), var_03, param_01);
  wait(0.05);
  self notify("drop_crate");
  wait(param_00);
  thread scripts\mp\killstreaks\_airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomintrange(-50, 0), randomintrange(-50, 0), randomintrange(-50, 0)), var_03, param_01);
  wait(0.05);
  self notify("drop_crate");
  wait(1);
  thread func_1AEC();
}

func_C73D(param_00, param_01, param_02) {
  thread func_1AEB();
  self waittill("hatch_down");
  var_03[0] = thread scripts\mp\killstreaks\_airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(10), randomint(10), randomint(10)), undefined, param_01);
  wait(0.05);
  self.timeout = self.timeout - 0.05;
  self notify("drop_crate");
  wait(param_00);
  self.timeout = self.timeout - param_00;
  var_03[1] = thread scripts\mp\killstreaks\_airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(100), randomint(100), randomint(100)), var_03, param_01);
  wait(0.05);
  self.timeout = self.timeout - 0.05;
  self notify("drop_crate");
  wait(param_00);
  self.timeout = self.timeout - param_00;
  var_03[2] = thread scripts\mp\killstreaks\_airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(50), randomint(50), randomint(50)), var_03, param_01);
  wait(0.05);
  self.timeout = self.timeout - 0.05;
  self notify("drop_crate");
  wait(1);
  thread func_1AEC();
}

func_6380(param_00) {
  if(isDefined(self.var_6741)) {
    self.var_6741 scripts\mp\hud_util::destroyelem();
  }

  self _meth_8258();
  self thermalvisionoff();
  self thermalvisionfofoverlayoff();
  self unlink();
  scripts\mp\utility::clearusingremote();
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(1);
  }

  self visionsetthermalforplayer(game["thermal_vision"], 0);
  if(isDefined(param_00)) {
    param_00 _meth_83EC(self);
  }

  self notify("heliPlayer_removed");
  scripts\mp\utility::_switchtoweapon(scripts\engine\utility::getlastweapon());
  scripts\mp\utility::_takeweapon("heli_remote_mp");
}

func_6381(param_00) {
  self endon("disconnect");
  param_00 waittill("helicopter_done");
  func_6380(param_00);
}