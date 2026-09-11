/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_crash2\mp_crash2.gsc
***************************************************/

function main() {
  _redbuttonused_internal::keypad_check_levelinput();
  level.music_style = "middle_east";
  scripts\mp\maps\mp_crash2\mp_crash2_precache::main();
  scripts\mp\maps\mp_crash2\gen\mp_crash2_art::main();
  scripts\mp\maps\mp_crash2\mp_crash2_fx::main();
  scripts\mp\maps\mp_crash2\mp_crash2_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_crash2", "codcaster_compass_map_mp_crash2");
  setDvar("MQPQKNPQOK", 3);
  setDvar("MRNRKKOPLN", 0.5);
  setDvar("OLSKLTPPMR", 0.5);
  setDvar("NKLMONNPNN", 512);
  setDvar("PKKMTTRQO", 3.5);
  var0 = scripts\mp\utility\game::getgametype();

  if(var0 == "sd") {
    game["defenders"] = "allies";
    game["attackers"] = "axis";
  } else {
    game["attackers"] = "allies";
    game["defenders"] = "axis";
  }

  game["allies_outfit"] = "desert";
  game["axis_outfit"] = "desert";
  thread spawnstaticvan();
  thread ref_13664();
  thread player_fired_gun_monitor();
  thread ref_121f5();
  thread battle_tracks_vehicleoccupancyenter();
}

function spawnstaticvan() {
  level waittill("infil_setup_complete");

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "get_all_infils")) {
    return;
  }

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "spawnPersistentVan")) {
    return;
  }

  if(!scripts\mp\flags::gameflag("infil_will_run")) {
    foreach(var1 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("infil", "get_all_infils")]]()) {
      if(var1.script_noteworthy != "infil_van_hackney") {
        continue;
      }

      if(var1.name != "alpha") {
        continue;
      }

      game["infil"]["types"]["infil_van_hackney"]["alpha"]["vehicleOrg"] = (1250, -2338, 65);
      game["infil"]["types"]["infil_van_hackney"]["alpha"]["vehicleAng"] = (0, 270, 0);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("infil", "spawnPersistentVan")]]("infil_van_hackney", "alpha");
      var2 = getentarrayinradius("script_brushmodel", "classname", (1250, -2150, 75), 300);

      if(isDefined(var2)) {
        var2[0].origin += anglesToForward((0, 90, 0)) * -50;
      }

      break;
    }

    return;
  }
}

function ref_13664() {
  var0 = spawn("trigger_radius", (-340, 655, 240), 0, 192, 100);
  thread ref_144ff(var0);
}

function ref_144ff(var0) {
  for(;;) {
    self waittill("trigger", var1);

    if(!isPlayer(var1)) {
      continue;
    }

    if(!isDefined(self.ref_126ce)) {
      self.ref_126ce = [];
    }

    if(scripts\engine\utility::array_contains(self.ref_126ce, var1.guid)) {
      continue;
    }

    self.ref_126ce = scripts\engine\utility::array_add(self.ref_126ce, var1.guid);

    switch (var0) {
      case "alley":
        thread ref_14486(var1);
        break;
    }
  }
}

function ref_14486(var0) {
  self endon("death_or_disconnect");
  var1 = self.team;
  var2 = self.guid;
  var3 = [];
  var4 = spawnStruct();
  var4.origin = (-370, -320, 100);
  var4.radius = 330;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (-370, -700, 100);
  var4.radius = 330;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (-370, -1000, 100);
  var4.radius = 330;
  var3 = var4;
  var4 = spawnStruct();
  var4.origin = (-400, -1700, 60);
  var4.radius = 550;
  var3 = var4;
  var5 = [];

  foreach(var7 in var3) {
    var5 = scripts\mp\spawnlogic::addspawndangerzone(var7.origin, var7.radius, 200, var1, undefined, self, 0, self, 1);
  }

  while(isDefined(self) && self istouching(var0)) {
    waitframe();
  }

  foreach(var10 in var5) {
    scripts\mp\spawnlogic::removespawndangerzone(var10);
  }

  var0.ref_126ce = scripts\engine\utility::array_remove(var0.ref_126ce, var2);
}

function player_fired_gun_monitor() {
  var0 = getEnt("clip256x256x256", "targetname");
  var1 = spawn("script_model", (-912, 2072, 520));
  var1.angles = (0, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
}

function ref_121f5() {
  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = [];
  }

  var0 = [(-912, 2072, 530)];

  foreach(var2 in var0) {
    var3 = spawn("trigger_radius", var2, 0, 400, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var3;
  }
}

function battle_tracks_vehicleoccupancyenter() {
  var0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "tjugg":
    case "tdef":
    case "infect":
    case "grnd":
    case "grind":
    case "cranked":
    case "conf":
    case "war":
      level.modifiedspawnpoints["1184 -1832"]["mp_tdm_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1232 -1808"]["mp_tdm_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1224 -1896"]["mp_tdm_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1896"]["mp_tdm_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1224 -1960"]["mp_tdm_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1960"]["mp_tdm_spawn_allies_start"]["remove"] = 1;
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_allies_start", (1109, -1911, 80), (0, 22, 0)));

    case "siege":
    case "dom":
      level.modifiedspawnpoints["1233 -1800"]["mp_dom_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1224 -1888"]["mp_dom_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1888"]["mp_dom_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1222 -1952"]["mp_dom_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1262 -1952"]["mp_dom_spawn_allies_start"]["remove"] = 1;
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_dom_spawn_allies_start", (1109, -1911, 80), (0, 22, 0)));

    case "hq":
    case "koth":
      level.modifiedspawnpoints["1232 -1800"]["mp_koth_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1224 -1888"]["mp_koth_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1888"]["mp_koth_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1224 -1952"]["mp_koth_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1952"]["mp_koth_spawn_allies_start"]["remove"] = 1;
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_koth_spawn_allies_start", (1109, -1911, 80), (0, 22, 0)));

    case "ctf":
      level.modifiedspawnpoints["1232 -1808"]["mp_ctf_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1224 -1896"]["mp_ctf_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1896"]["mp_ctf_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1224 -1960"]["mp_ctf_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1960"]["mp_ctf_spawn_allies_start"]["remove"] = 1;
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_ctf_spawn_allies_start", (1109, -1911, 80), (0, 22, 0)));

    case "rugby":
      level.modifiedspawnpoints["1232 -1800"]["mp_rugby_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1224 -1888"]["mp_rugby_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1888"]["mp_rugby_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1224 -1952"]["mp_rugby_spawn_allies_start"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1952"]["mp_rugby_spawn_allies_start"]["remove"] = 1;
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_rugby_spawn_allies_start", (1109, -1911, 80), (0, 22, 0)));

    case "cyber":
      level.modifiedspawnpoints["1224 -1896"]["mp_cyber_spawn_allies"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1896"]["mp_cyber_spawn_allies"]["remove"] = 1;
      level.modifiedspawnpoints["1224 -1960"]["mp_cyber_spawn_allies"]["remove"] = 1;
      level.modifiedspawnpoints["1264 -1960"]["mp_cyber_spawn_allies"]["remove"] = 1;
      GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_cyber_spawn_allies", (1109, -1911, 80), (0, 22, 0)));
  }

  if(var0.size > 0) {
    scripts\mp\spawnlogic::bdiedonce(var0);
    return;
  }
}