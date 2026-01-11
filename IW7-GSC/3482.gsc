/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3482.gsc
***************************************/

init() {
  level.func_C73F = [];
  level.func_C73F["escort_airdrop"] = spawnStruct();
  level.func_C73F["escort_airdrop"].vehicle = "osprey_mp";
  level.func_C73F["escort_airdrop"].modelbase = "vehicle_v22_osprey_body_mp";
  level.func_C73F["escort_airdrop"].func_B91B = "vehicle_v22_osprey_blades_mp";
  level.func_C73F["escort_airdrop"].func_11415 = "tag_le_door_attach";
  level.func_C73F["escort_airdrop"].func_11416 = "tag_ri_door_attach";
  level.func_C73F["escort_airdrop"].func_113F0 = "tag_turret_attach";
  level.func_C73F["escort_airdrop"].func_DA71 = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
  level.func_C73F["escort_airdrop"].name = &"KILLSTREAKS_ESCORT_AIRDROP";
  level.func_C73F["escort_airdrop"].weaponinfo = "osprey_minigun_mp";
  level.func_C73F["escort_airdrop"].helitype = "osprey";
  level.func_C73F["escort_airdrop"].droptype = "airdrop_escort";
  level.func_C73F["escort_airdrop"].maxhealth = level.func_8D73 * 2;
  level.func_C73F["escort_airdrop"].timeout = 60.0;
  level.func_C73F["osprey_gunner"] = spawnStruct();
  level.func_C73F["osprey_gunner"].vehicle = "osprey_player_mp";
  level.func_C73F["osprey_gunner"].modelbase = "vehicle_v22_osprey_body_mp";
  level.func_C73F["osprey_gunner"].func_B91B = "vehicle_v22_osprey_blades_mp";
  level.func_C73F["osprey_gunner"].func_11415 = "tag_le_door_attach";
  level.func_C73F["osprey_gunner"].func_11416 = "tag_ri_door_attach";
  level.func_C73F["osprey_gunner"].func_113F0 = "tag_turret_attach";
  level.func_C73F["osprey_gunner"].func_DA71 = &"KILLSTREAKS_DEFEND_AIRDROP_PACKAGES";
  level.func_C73F["osprey_gunner"].name = &"KILLSTREAKS_OSPREY_GUNNER";
  level.func_C73F["osprey_gunner"].weaponinfo = "osprey_player_minigun_mp";
  level.func_C73F["osprey_gunner"].helitype = "osprey_gunner";
  level.func_C73F["osprey_gunner"].droptype = "airdrop_osprey_gunner";
  level.func_C73F["osprey_gunner"].maxhealth = level.func_8D73 * 2;
  level.func_C73F["osprey_gunner"].timeout = 75.0;

  foreach(var_01 in level.func_C73F) {
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

  level.func_1A6F = [];
  scripts\mp\killstreaks\killstreaks::registerkillstreak("escort_airdrop", ::tryuseescortairdrop);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("osprey_gunner", ::func_128F3);
}

tryuseescortairdrop(var_00, var_01) {
  var_02 = 1;

  if(isDefined(level.chopper)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  if(scripts\mp\utility\game::iskillstreakdenied())
    return 0;

  scripts\mp\utility\game::incrementfauxvehiclecount();
  return 1;
}

func_128F3(var_00, var_01) {
  var_02 = 1;

  if(isDefined(level.chopper)) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_04 = func_F1AD(var_00, "osprey_gunner", "compass_objpoint_osprey_friendly", "compass_objpoint_osprey_enemy", &"KILLSTREAKS_SELECT_MOBILE_MORTAR_LOCATION");

  if(!isDefined(var_04) || !var_04) {
    scripts\mp\utility::decrementfauxvehiclecount();
    return 0;
  }

  scripts\mp\matchdata::logkillstreakevent("osprey_gunner", self.origin);
  return 1;
}

func_6CE4(var_00, var_01, var_02, var_03) {
  self notify("used");
  var_04 = (0, var_02, 0);
  var_05 = 12000;
  var_06 = getent("airstrikeheight", "targetname");
  var_07 = var_6.origin[2];
  var_08 = level.func_8D96[randomint(level.func_8D96.size)];
  var_09 = var_8.origin;
  var_10 = (var_1[0], var_1[1], var_07);
  var_11 = var_01 + anglesToForward(var_04) * var_05;
  var_12 = vectortoangles(var_10 - var_09);
  var_13 = var_01;
  var_01 = (var_1[0], var_1[1], var_07);
  var_14 = func_4983(self, var_00, var_09, var_12, var_01, var_03);
  var_09 = var_08;
  func_130E3(var_00, var_14, var_09, var_10, var_11, var_07, var_13);
}

func_6CDF(var_00, var_01, var_02, var_03) {
  self notify("used");
  var_04 = (0, var_02, 0);
  var_05 = 12000;
  var_06 = getent("airstrikeheight", "targetname");
  var_07 = var_6.origin[2];
  var_08 = level.func_8D96[randomint(level.func_8D96.size)];
  var_09 = var_8.origin;
  var_10 = (var_1[0], var_1[1], var_07);
  var_11 = var_01 + anglesToForward(var_04) * var_05;
  var_12 = vectortoangles(var_10 - var_09);
  var_01 = (var_1[0], var_1[1], var_07);
  var_13 = func_4983(self, var_00, var_09, var_12, var_01, var_03);
  var_09 = var_08;
  func_130B6(var_00, var_13, var_09, var_10, var_11, var_07);
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

func_F1AD(var_00, var_01, var_02, var_03, var_04) {
  self endon("customCancelLocation");
  var_05 = undefined;
  var_06 = level.mapsize / 6.46875;

  if(level.splitscreen)
    var_06 = var_06 * 1.5;

  scripts\mp\utility\game::_beginlocationselection(var_01, "map_artillery_selector", 0, 500);
  thread func_11089();
  self waittill("confirm_location", var_07, var_08);
  scripts\mp\utility\game::func_11079(0);
  scripts\mp\utility\game::setusingremote(var_01);
  var_09 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var_01);

  if(var_09 != "success") {
    if(var_09 != "disconnect")
      scripts\mp\utility\game::clearusingremote();

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

  thread func_6CDF(var_00, var_07, var_08, var_01);
  return 1;
}

func_1012E(var_00, var_01, var_02, var_03) {
  var_04 = scripts\mp\hud_util::createfontstring("bigfixed", 0.5);
  var_04 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  var_04 give_zap_perk(var_02);
  self.locationobjectives = [];

  for(var_05 = 0; var_05 < var_03; var_5++) {
    self.locationobjectives[var_05] = ::scripts\mp\objidpoolmanager::requestminimapid(1);

    if(self.locationobjectives[var_05] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(self.locationobjectives[var_05], "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_position(self.locationobjectives[var_05], level.func_1A6F[level.script][var_05]["origin"]);
      scripts\mp\objidpoolmanager::minimap_objective_state(self.locationobjectives[var_05], "active");
      scripts\mp\objidpoolmanager::minimap_objective_player(self.locationobjectives[var_05], self getentitynumber());

      if(level.func_1A6F[level.script][var_05]["in_use"] == 1) {
        scripts\mp\objidpoolmanager::minimap_objective_icon(self.locationobjectives[var_05], var_01);
        continue;
      }

      scripts\mp\objidpoolmanager::minimap_objective_icon(self.locationobjectives[var_05], var_00);
    }
  }

  scripts\engine\utility::waittill_any("cancel_location", "picked_location", "stop_location_selection");
  var_04 scripts\mp\hud_util::destroyelem();

  for(var_05 = 0; var_05 < var_03; var_5++)
    scripts\mp\objidpoolmanager::returnminimapid(self.locationobjectives[var_05]);
}

func_4983(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = spawnhelicopter(var_00, var_02, var_03, level.func_C73F[var_05].vehicle, level.func_C73F[var_05].modelbase);

  if(!isDefined(var_06))
    return undefined;

  var_6.func_C740 = var_05;
  var_6.func_8DA0 = level.func_C73F[var_05].modelbase;
  var_6.helitype = level.func_C73F[var_05].helitype;
  var_6.attractor = missile_createattractorent(var_06, level.func_8D2E, level.func_8D2D);
  var_6.lifeid = var_01;
  var_6.team = var_0.pers["team"];
  var_6.pers["team"] = var_0.pers["team"];
  var_6.owner = var_00;
  var_06 setotherent(var_00);
  var_6.maxhealth = level.func_C73F[var_05].maxhealth;
  var_6.zoffset = (0, 0, 0);
  var_6.func_11568 = level.func_8D9A;
  var_6.primarytarget = undefined;
  var_6.secondarytarget = undefined;
  var_6.attacker = undefined;
  var_6.currentstate = "ok";
  var_6.droptype = level.func_C73F[var_05].droptype;
  var_06 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_00);
  level.chopper = var_06;
  var_06 scripts\mp\killstreaks\helicopter::func_184E();
  var_06 thread scripts\mp\killstreaks\flares::flares_monitor(2);
  var_06 thread scripts\mp\killstreaks\helicopter::heli_leave_on_disconnect(var_00);
  var_06 thread scripts\mp\killstreaks\helicopter::heli_leave_on_changeteams(var_00);
  var_06 thread scripts\mp\killstreaks\helicopter::heli_leave_on_gameended(var_00);
  var_07 = level.func_C73F[var_05].timeout;
  var_06 thread scripts\mp\killstreaks\helicopter::heli_leave_on_timeout(var_07);
  var_06 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor(var_05, 0);
  var_06 thread scripts\mp\killstreaks\helicopter::heli_health();
  var_06 thread scripts\mp\killstreaks\helicopter::func_8D49();
  var_06 thread func_1AE8();
  var_06 thread func_1AEA();

  if(var_05 == "escort_airdrop") {
    var_08 = var_6.origin + (anglesToForward(var_6.angles) * -200 + anglestoright(var_6.angles) * -200) + (0, 0, 200);
    var_6.killcament = spawn("script_model", var_08);
    var_6.killcament setscriptmoverkillcam("explosive");
    var_6.killcament linkto(var_06, "tag_origin");
  }

  return var_06;
}

func_1AE8() {
  self endon("death");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait 0.05;
  playFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.func_C73F[self.func_C740].modelbase], self, "TAG_BLADES_ATTACH");
  wait 0.05;
  playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11415);
  wait 0.05;
  playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11416);
}

func_1AEA() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_00);
    thread func_1AE9(var_00);
  }
}

func_1AE9(var_00) {
  self endon("death");
  level endon("game_ended");
  var_00 endon("disconnect");
  wait 0.05;
  playfxontagforclients(level.chopper_fx["light"]["tail"], self, "tag_light_tail", var_00);
  wait 0.05;
  playfxontagforclients(level.chopper_fx["light"]["belly"], self, "tag_light_belly", var_00);

  if(isDefined(self.func_DA9F)) {
    if(self.func_DA9F == "up") {
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["blades_static_up"][level.func_C73F[self.func_C740].modelbase], self, "TAG_BLADES_ATTACH", var_00);
    } else {
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["blades_static_down"][level.func_C73F[self.func_C740].modelbase], self, "TAG_BLADES_ATTACH", var_00);
    }
  } else {
    wait 0.05;
    playfxontagforclients(level.chopper_fx["anim"]["blades_static_down"][level.func_C73F[self.func_C740].modelbase], self, "TAG_BLADES_ATTACH", var_00);
  }

  if(isDefined(self.func_8C42)) {
    if(self.func_8C42 == "down") {
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_down"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11415, var_00);
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_down"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11416, var_00);
    } else {
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11415, var_00);
      wait 0.05;
      playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11416, var_00);
    }
  } else {
    wait 0.05;
    playfxontagforclients(level.chopper_fx["anim"]["hatch_left_static_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11415, var_00);
    wait 0.05;
    playfxontagforclients(level.chopper_fx["anim"]["hatch_right_static_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11416, var_00);
  }
}

func_130E3(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_01 thread func_1AE6(self, var_02, var_03, var_04, var_05, var_06);
}

func_130B6(var_00, var_01, var_02, var_03, var_04, var_05) {
  thread func_E4F8(var_00, var_01);
  var_01 thread func_1AE7(self, var_02, var_03, var_04, var_05);
}

func_E4F8(var_00, var_01) {
  self endon("disconnect");
  var_01 endon("helicopter_done");
  thread scripts\mp\utility\game::teamplayercardsplash("used_osprey_gunner", self);
  scripts\mp\utility\game::_giveweapon("heli_remote_mp");
  scripts\mp\utility\game::_switchtoweapon("heli_remote_mp");

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(0);

  var_01 _meth_83ED(self);
  self getwholescenedurationmax(var_01, "tag_player", 1.0, 0, 0, 0, 0, 1);
  self setplayerangles(var_01 gettagangles("tag_player"));
  var_01 thread scripts\mp\killstreaks\helicopter::heli_targeting();
  var_1.gunner = self;
  self.func_8DD2 = var_00;
  thread func_6381(var_01);
  thread waitsetthermal(1.0, var_01);
  thread scripts\mp\utility\game::reinitializethermal(var_01);

  for(;;) {
    var_01 waittill("turret_fire");
    var_01 fireweapon();
    earthquake(0.2, 1, var_1.origin, 1000);
  }
}

waitsetthermal(var_00, var_01) {
  self endon("disconnect");
  var_01 endon("death");
  var_01 endon("helicopter_done");
  var_01 endon("crashing");
  var_01 endon("leaving");
  wait(var_00);
  self visionsetthermalforplayer(level.ac130.enhanced_vision, 0);
  self.lastvisionsetthermal = level.ac130.enhanced_vision;
  self thermalvisionon();
  self thermalvisionfofoverlayon();
}

func_1011E(var_00) {
  self endon("disconnect");
  var_00 endon("helicopter_done");
  self.func_6741 = scripts\mp\hud_util::createfontstring("bigfixed", 1.5);
  self.func_6741 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  self.func_6741 give_zap_perk(level.func_C73F[var_0.func_C740].func_DA71);
  wait 6;

  if(isDefined(self.func_6741))
    self.func_6741 scripts\mp\hud_util::destroyelem();
}

func_1AEE() {
  self endon("crashing");
  self endon("death");
  stopFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.func_C73F[self.func_C740].modelbase], self, "TAG_BLADES_ATTACH");
  playFXOnTag(level.chopper_fx["anim"]["blades_anim_up"][level.func_C73F[self.func_C740].modelbase], self, "TAG_BLADES_ATTACH");
  wait 1.0;

  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["blades_static_up"][level.func_C73F[self.func_C740].modelbase], self, "TAG_BLADES_ATTACH");
    self.func_DA9F = "up";
  }
}

func_1AED() {
  self endon("crashing");
  self endon("death");
  stopFXOnTag(level.chopper_fx["anim"]["blades_static_up"][level.func_C73F[self.func_C740].modelbase], self, "TAG_BLADES_ATTACH");
  playFXOnTag(level.chopper_fx["anim"]["blades_anim_down"][level.func_C73F[self.func_C740].modelbase], self, "TAG_BLADES_ATTACH");
  wait 1.0;

  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["blades_static_down"][level.func_C73F[self.func_C740].modelbase], self, "TAG_BLADES_ATTACH");
    self.func_DA9F = "down";
  }
}

func_1AEC() {
  self endon("crashing");
  self endon("death");
  stopFXOnTag(level.chopper_fx["anim"]["hatch_left_static_down"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11415);
  playFXOnTag(level.chopper_fx["anim"]["hatch_left_anim_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11415);
  stopFXOnTag(level.chopper_fx["anim"]["hatch_right_static_down"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11416);
  playFXOnTag(level.chopper_fx["anim"]["hatch_right_anim_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11416);
  wait 1.0;

  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11415);
    playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11416);
    self.func_8C42 = "up";
  }
}

func_1AEB() {
  self endon("crashing");
  self endon("death");
  stopFXOnTag(level.chopper_fx["anim"]["hatch_left_static_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11415);
  playFXOnTag(level.chopper_fx["anim"]["hatch_left_anim_down"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11415);
  stopFXOnTag(level.chopper_fx["anim"]["hatch_right_static_up"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11416);
  playFXOnTag(level.chopper_fx["anim"]["hatch_right_anim_down"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11416);
  wait 1.0;

  if(isDefined(self)) {
    playFXOnTag(level.chopper_fx["anim"]["hatch_left_static_down"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11415);
    playFXOnTag(level.chopper_fx["anim"]["hatch_right_static_down"][level.func_C73F[self.func_C740].modelbase], self, level.func_C73F[self.func_C740].func_11416);
    self.func_8C42 = "down";
  }

  self notify("hatch_down");
}

func_7DFC(var_00) {
  self endon("helicopter_removed");
  self endon("heightReturned");
  var_01 = getent("airstrikeheight", "targetname");

  if(isDefined(var_01))
    var_02 = var_1.origin[2];
  else if(isDefined(level.airstrikeheightscale))
    var_02 = 850 * level.airstrikeheightscale;
  else
    var_02 = 850;

  self.func_2A95 = var_02;
  var_03 = 200;
  var_04 = 0;
  var_05 = 0;

  for(var_06 = 0; var_06 < 125; var_6++) {
    wait 0.05;
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

    var_09 = bulletTrace(var_00 + (var_04, var_05, 1000), var_00 + (var_04, var_05, -10000), 1, self);

    if(var_9["position"][2] > var_03)
      var_03 = var_9["position"][2];
  }

  self.func_2A95 = var_03 + 300;

  switch (getdvar("mapname")) {
    case "mp_morningwood":
      self.func_2A95 = self.func_2A95 + 600;
      break;
    case "mp_overwatch":
      var_10 = level.spawnpoints;
      var_11 = var_10[0];
      var_12 = var_10[0];

      foreach(var_14 in var_10) {
        if(var_14.origin[2] < var_11.origin[2])
          var_11 = var_14;

        if(var_14.origin[2] > var_12.origin[2])
          var_12 = var_14;
      }

      if(var_03 < var_11.origin[2] - 100)
        self.func_2A95 = var_12.origin[2] + 900;

      break;
  }
}

func_1AE6(var_00, var_01, var_02, var_03, var_04, var_05) {
  self notify("airshipFlyDefense");
  self endon("airshipFlyDefense");
  self endon("helicopter_removed");
  self endon("death");
  self endon("leaving");
  thread func_7DFC(var_02);
  scripts\mp\killstreaks\helicopter::heli_fly_simple_path(var_01);
  self.func_C96C = var_02;
  var_06 = self.angles;
  self setyawspeed(30, 30, 30, 0.3);
  var_07 = self.origin;
  var_08 = self.angles[1];
  var_09 = self.angles[0];
  self.timeout = level.func_C73F[self.func_C740].timeout;
  self setvehgoalpos(var_02, 1);
  var_10 = gettime();
  self waittill("goal");
  var_11 = (gettime() - var_10) * 0.001;
  self.timeout = self.timeout - var_11;
  thread func_1AEE();
  var_12 = var_02 * (1, 1, 0);
  var_12 = var_12 + (0, 0, self.func_2A95);
  self vehicle_setspeed(25, 10, 10);
  self setyawspeed(20, 10, 10, 0.3);
  self setvehgoalpos(var_12, 1);
  var_10 = gettime();
  self waittill("goal");
  var_11 = (gettime() - var_10) * 0.001;
  self.timeout = self.timeout - var_11;
  self sethoverparams(65, 50, 50);
  func_C73E(1, level.func_C73F[self.func_C740].func_113F0, var_12);
  thread func_A663(var_05);

  if(isDefined(var_00))
    var_00 scripts\engine\utility::waittill_any_timeout(self.timeout, "disconnect");

  self waittill("leaving");
  self notify("osprey_leaving");
  thread func_1AED();
}

wait_and_delete(var_00) {
  self endon("death");
  level endon("game_ended");
  wait(var_00);
  self delete();
}

func_A663(var_00) {
  self endon("osprey_leaving");
  self endon("helicopter_removed");
  self endon("death");
  var_01 = var_00;

  for(;;) {
    foreach(var_03 in level.players) {
      wait 0.05;

      if(!isDefined(self)) {
        return;
      }
      if(!isDefined(var_03)) {
        continue;
      }
      if(!scripts\mp\utility\game::isreallyalive(var_03)) {
        continue;
      }
      if(!self.owner scripts\mp\utility\game::isenemy(var_03)) {
        continue;
      }
      if(var_03 scripts\mp\utility\game::_hasperk("specialty_blindeye")) {
        continue;
      }
      if(distancesquared(var_01, var_3.origin) > 500000) {
        continue;
      }
      thread func_1B01(var_03, var_01);
      func_136B2();
    }
  }
}

func_1B01(var_00, var_01) {
  self notify("aiShootPlayer");
  self endon("aiShootPlayer");
  self endon("helicopter_removed");
  self endon("leaving");
  var_00 endon("death");
  self setturrettargetent(var_00);
  self setlookatent(var_00);
  thread func_1155A(var_00);
  var_02 = 6;
  var_03 = 2;

  for(;;) {
    var_2--;
    self fireweapon("tag_flash", var_00);
    wait 0.15;

    if(var_02 <= 0) {
      var_3--;
      var_02 = 6;

      if(distancesquared(var_0.origin, var_01) > 500000 || var_03 <= 0 || !scripts\mp\utility\game::isreallyalive(var_00)) {
        self notify("abandon_target");
        return;
      }

      wait 1;
    }
  }
}

func_1155A(var_00) {
  self endon("abandon_target");
  self endon("leaving");
  self endon("helicopter_removed");
  var_00 waittill("death");
  self notify("target_killed");
}

func_136B2() {
  self endon("helicopter_removed");
  self endon("leaving");
  self endon("target_killed");
  self endon("abandon_target");

  for(;;)
    wait 0.05;
}

func_1AE7(var_00, var_01, var_02, var_03, var_04) {
  self notify("airshipFlyGunner");
  self endon("airshipFlyGunner");
  self endon("helicopter_removed");
  self endon("death");
  self endon("leaving");
  thread func_7DFC(var_02);
  scripts\mp\killstreaks\helicopter::heli_fly_simple_path(var_01);
  thread scripts\mp\killstreaks\helicopter::heli_leave_on_timeout(level.func_C73F[self.func_C740].timeout);
  var_05 = self.angles;
  self setyawspeed(30, 30, 30, 0.3);
  var_06 = self.origin;
  var_07 = self.angles[1];
  var_08 = self.angles[0];
  self.timeout = level.func_C73F[self.func_C740].timeout;
  self setvehgoalpos(var_02, 1);
  var_09 = gettime();
  self waittill("goal");
  var_10 = (gettime() - var_09) * 0.001;
  self.timeout = self.timeout - var_10;
  thread func_1AEE();
  var_11 = var_02 * (1, 1, 0);
  var_11 = var_11 + (0, 0, self.func_2A95);
  self vehicle_setspeed(25, 10, 10);
  self setyawspeed(20, 10, 10, 0.3);
  self setvehgoalpos(var_11, 1);
  var_09 = gettime();
  self waittill("goal");
  var_10 = (gettime() - var_09) * 0.001;
  self.timeout = self.timeout - var_10;
  func_C73D(1, level.func_C73F[self.func_C740].func_113F0, var_11);
  var_12 = 1.0;

  if(isDefined(var_00))
    var_00 scripts\engine\utility::waittill_any_timeout(var_12, "disconnect");

  self.timeout = self.timeout - var_12;
  self setvehgoalpos(var_02, 1);
  var_09 = gettime();
  self waittill("goal");
  var_10 = (gettime() - var_09) * 0.001;
  self.timeout = self.timeout - var_10;
  var_13 = getEntArray("heli_attack_area", "targetname");
  var_14 = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];

  if(var_13.size)
    thread scripts\mp\killstreaks\helicopter::func_8D55(var_13);
  else
    thread scripts\mp\killstreaks\helicopter::heli_fly_loop_path(var_14);

  self waittill("leaving");
  thread func_1AED();
}

func_C73E(var_00, var_01, var_02) {
  thread func_1AEB();
  self waittill("hatch_down");
  level notify("escort_airdrop_started", self);
  var_3[0] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(10), randomint(10), randomint(10)), undefined, var_01);
  wait 0.05;
  self notify("drop_crate");
  wait(var_00);
  var_3[1] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(100), randomint(100), randomint(100)), var_03, var_01);
  wait 0.05;
  self notify("drop_crate");
  wait(var_00);
  var_3[2] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(50), randomint(50), randomint(50)), var_03, var_01);
  wait 0.05;
  self notify("drop_crate");
  wait(var_00);
  var_3[3] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomintrange(-100, 0), randomintrange(-100, 0), randomintrange(-100, 0)), var_03, var_01);
  wait 0.05;
  self notify("drop_crate");
  wait(var_00);
  thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomintrange(-50, 0), randomintrange(-50, 0), randomintrange(-50, 0)), var_03, var_01);
  wait 0.05;
  self notify("drop_crate");
  wait 1.0;
  thread func_1AEC();
}

func_C73D(var_00, var_01, var_02) {
  thread func_1AEB();
  self waittill("hatch_down");
  var_3[0] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(10), randomint(10), randomint(10)), undefined, var_01);
  wait 0.05;
  self.timeout = self.timeout - 0.05;
  self notify("drop_crate");
  wait(var_00);
  self.timeout = self.timeout - var_00;
  var_3[1] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(100), randomint(100), randomint(100)), var_03, var_01);
  wait 0.05;
  self.timeout = self.timeout - 0.05;
  self notify("drop_crate");
  wait(var_00);
  self.timeout = self.timeout - var_00;
  var_3[2] = thread scripts\mp\killstreaks\airdrop::dropthecrate(undefined, self.droptype, undefined, 0, undefined, self.origin, (randomint(50), randomint(50), randomint(50)), var_03, var_01);
  wait 0.05;
  self.timeout = self.timeout - 0.05;
  self notify("drop_crate");
  wait 1.0;
  thread func_1AEC();
}

func_6380(var_00) {
  if(isDefined(self.func_6741))
    self.func_6741 scripts\mp\hud_util::destroyelem();

  self _meth_8258();
  self thermalvisionoff();
  self thermalvisionfofoverlayoff();
  self unlink();
  scripts\mp\utility\game::clearusingremote();

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(1);

  self visionsetthermalforplayer(game["thermal_vision"], 0);

  if(isDefined(var_00))
    var_00 _meth_83EC(self);

  self notify("heliPlayer_removed");
  scripts\mp\utility\game::_switchtoweapon(scripts\engine\utility::getlastweapon());
  scripts\mp\utility\game::_takeweapon("heli_remote_mp");
}

func_6381(var_00) {
  self endon("disconnect");
  var_00 waittill("helicopter_done");
  func_6380(var_00);
}