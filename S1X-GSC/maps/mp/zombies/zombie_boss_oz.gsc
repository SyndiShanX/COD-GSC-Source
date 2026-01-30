/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_boss_oz.gsc
**********************************************/

init() {
  maps\mp\zombies\zombie_boss_oz_stage1::init();
  maps\mp\zombies\zombie_boss_oz_stage2::init();
  level.roundstartfunc["zombie_boss_oz"] = ::bossozroundstart;
  level.zombieroundstartupdate = ::roundstartupdate;
  level._effect["oz_arena_teleport_player"] = loadfx("vfx/unique/dlc_teleport_player");
  level.arenazonename = "arena";
  level.teleportname = "boss_player_teleport";

  if(!isDefined(level.ammodroneillegalzones)) {
    level.ammodroneillegalzones = [];
  }

  level.ammodroneillegalzones[level.ammodroneillegalzones.size] = level.arenazonename;

  foreach(var_1 in level.hostcuremodels) {
    var_1.zone = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_1.origin + (0, 0, 10));
  }

  deactivatearenacurestations();
  initpillars();
  initroomcenter();
  initpower();
  maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault", "ammo", 25, ::ammocratethink, &"ZOMBIE_H2O_AMMO_CRATE", "ammo");
  maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault", "ozMoney", 25, ::moneycratethink, &"ZOMBIES_CRATE_MONEY", "ozMoney");
  level._effect["crate_teleport"] = loadfx("vfx/unique/dlc_teleport_soldier_good");
}

initpillars() {
  level.bossozpillars = common_scripts\utility::getstructarray("oz_room_pillar", "targetname");

  foreach(var_1 in level.bossozpillars) {
    var_1.destroyed = 0;
    var_1.visuals = [];
    var_2 = getEntArray(var_1.target, "targetname");

    foreach(var_4 in var_2) {
      if(var_4.classname == "script_brushmodel") {
        if(var_4.script_noteworthy == "compile_time_path_blocker") {
          var_4 delete();
        } else if(var_4.script_noteworthy == "visuals") {
          var_4 connectpaths();
          var_4 setaisightlinevisible(1);
          var_4 common_scripts\utility::hide_notsolid();
          var_4 common_scripts\utility::show_solid();
          var_1.sightlineent = var_4;
          var_1.visuals[var_1.visuals.size] = var_4;
        } else if(var_4.script_noteworthy == "pillar_path_blocker_top") {
          var_4 notsolid();
          var_4 connectpaths();
          var_1.pathblockertop = var_4;
        } else if(var_4.script_noteworthy == "pillar_path_blocker_ground") {
          var_4 solid();
          var_4 disconnectpaths();
          var_1.pathblockerbottom = var_4;
        }

        continue;
      }

      if(var_4.classname == "script_model") {
        var_4 common_scripts\utility::show_solid();
        var_1.visuals[var_1.visuals.size] = var_4;
      }
    }
  }
}

getrandomactivepillar() {
  var_0 = common_scripts\utility::array_randomize(level.bossozpillars);

  foreach(var_2 in var_0) {
    if(!var_2.destroyed) {
      return var_2;
    }
  }
}

destroypillar() {
  self.pathblockertop solid();
  self.pathblockertop disconnectpaths();
  self.pathblockertop notsolid();
  self.pathblockerbottom connectpaths();
  self.pathblockerbottom notsolid();
  self.sightlineent setaisightlinevisible(0);

  foreach(var_1 in self.visuals) {
    var_1 common_scripts\utility::hide_notsolid();
    var_1 notsolid();
  }

  self.destroyed = 1;
}

initroomcenter() {
  level.bossozstage2roomcenter = (0, 0, 0);

  if(level.bossozpillars.size > 0) {
    foreach(var_1 in level.bossozpillars) {
      level.bossozstage2roomcenter = level.bossozstage2roomcenter + var_1.origin;
    }

    level.bossozstage2roomcenter = level.bossozstage2roomcenter / level.bossozpillars.size;
  }
}

initpower() {
  level.boss_power_switches = [];

  foreach(var_1 in level.power_switches) {
    var_2 = var_1.script_flag;

    if(isDefined(var_2) && issubstr(var_2, "boss_oz_power")) {
      var_1.nopoints = 1;
      level.boss_power_switches[level.boss_power_switches.size] = var_1;
    }
  }

  level thread curestationpower();
}

isbosspreviewround(var_0) {
  return var_0 == 6;
}

roundstartupdate() {
  level endon("game_ended");

  if(isbosspreviewround(level.wavecounter)) {
    level.zombie_wave_running = 1;
    maps\mp\zombies\zombie_boss_oz_stage1::initozrooms();

    while(maps\mp\zombies\_util::is_true(level.zmbbossteleportdelay)) {
      waitframe();
    }

    while(maps\mp\zombies\_util::is_true(level.waitingforteleportout)) {
      waitframe();
    }

    level.zmbbosscountdowninprogress = 1;
    zmbaudioannouncerbossozplayvo("s0intro", 1);
    level thread enablearenazone(1);
    teleportplayerstoarena();
    level thread hideshowkillstreakicons();
    level.zmbbosscountdowninprogress = undefined;
    maps\mp\zombies\zombie_boss_oz_stage1::spawnoz();
    var_0 = common_scripts\utility::random(level.bossozrooms);
    maps\mp\zombies\zombie_boss_oz_stage1::moveoztoroom(var_0);
    wait 1.5;
    zmbaudioplayervo("s0_react", 1);
    zmbaudiochangeozvotoplayonent(level.bossozstage1);
    zmbaudiobossozplayvo("s0fun", 1);
    wait 1.0;
    zmbaudiobossozplayvo("s0intro2", 1);
    var_1 = level.stage1traps["aerial_lasers"];
    [[var_1.runtrapfunc]](var_1, 10.0, 60.0, 1);
    var_1 = level.stage1traps["electricity"];
    [[var_1.runtrapfunc]](var_1, 10.0, 60.0, 1);
    wait 1;
    level thread zmbaudioplayervo("s0_traps", 0);
    wait 5.0;
    level notify("stop_all_boss_traps");
    level notify("teleport_players_back");
    level notify("disable_arena_zone");
    level waittill("teleport_from_arena_complete");
    wait 1.5;
    zmbaudioangplayvo("stage0", 1);
    zmbaudioannouncerbossozplayvo("s0ang", 1);
    wait 0.5;
    zmbaudioplayervo("s0_back", 1);
    waitframe();
    zmbaudioresetozvoent();
    level.bossozstage1 delete();
    level.zombie_wave_running = 0;
  }
}

bossozroundstart() {
  while(maps\mp\zombies\_util::is_true(level.zmbbossteleportdelay)) {
    waitframe();
  }

  while(maps\mp\zombies\_util::is_true(level.waitingforteleportout)) {
    waitframe();
  }

  maps\mp\zombies\_util::waittillzombiegameunpaused();
  level.zmbbosscountdowninprogress = 1;

  if(level.bossozstage == 1) {
    zmbaudioannouncerbossozplayvo("tele", 1);
    wait 0.5;
    zmbaudioannouncerbossozplayvo("count", 1);
  } else if(level.bossozstage == 2) {
    zmbaudioannouncerbossozplayvo("count2", 1);
  }

  teleportplayerstoarena();
  maps\mp\zombies\_util::disablepickups();
  level thread hideshowkillstreakicons();
  level.zmbbosscountdowninprogress = undefined;

  if(level.bossozstage == 1) {
    level.roundtype = "zombie_boss_oz_stage1";
  } else if(level.bossozstage == 2) {
    level.roundtype = "zombie_boss_oz_stage2";
  }

  level.zone_data.spawn_points_update_requested = 1;

  if(isDefined(level.roundstartfunc[level.roundtype])) {
    [[level.roundstartfunc[level.roundtype]]]();
  }

  level thread enablearenazone();
  level thread handlebossroundend();
  level thread handleammo();
}

hideshowkillstreakicons() {
  level.disablecarepackagedrops = 1;
  waitframe();
  var_0 = getEntArray("care_package", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread carepackagehidehudicon();
  }

  var_4 = getEntArray("goliath_pod_model", "targetname");

  foreach(var_6 in var_4) {
    var_6 thread carepackagehidehudicon();
  }

  level waittill("teleport_players_back");
  level.disablecarepackagedrops = undefined;
}

carepackagehidehudicon() {
  level endon("teleport_players_back");
  self endon("death");

  while(!isDefined(self.entityheadicons) || self.entityheadicons.size == 0) {
    waitframe();
  }

  foreach(var_1 in self.entityheadicons) {
    var_1.alpha = 0;
  }

  thread carepackagedelayshowhudicon();
}

carepackagedelayshowhudicon() {
  self endon("death");
  level waittill("teleport_players_back");

  if(isDefined(self.entityheadicons)) {
    foreach(var_1 in self.entityheadicons) {
      var_1.alpha = 1;
    }
  }
}

startinfinitezombiespawning() {
  var_0 = 1;

  if(var_0) {
    level childthread maps\mp\zombies\zombies_spawn_manager::spawnzombies(999999);
  }
}

teleportplayerstoarena() {
  var_0 = common_scripts\utility::getstructarray(level.teleportname, "targetname");

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1] thread teleporttostructandbackatend(var_0[var_1]);
  }

  level waittill("teleport_to_arena_complete");
  thread ensureeveryplayerteleports();
}

ensureeveryplayerteleports() {
  level endon("game_ended");
  var_0 = common_scripts\utility::getstructarray(level.teleportname, "targetname");
  var_1 = 1;
  var_2 = undefined;

  while(var_1) {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(isalive(level.players[var_3]) && !maps\mp\zombies\_util::is_true(level.players[var_3].startedbossteleport)) {
        level.players[var_3] thread teleporttostructandbackatend(var_0[var_3]);
      }
    }

    if(maps\mp\zombies\_util::is_true(level.zombie_wave_running) && !isDefined(var_2)) {
      var_2 = gettime() + 2000;
    }

    if(isDefined(var_2) && gettime() > var_2) {
      var_1 = 0;
    }

    wait 1.0;
  }
}

enablearenazone(var_0) {
  level endon("game_ended");
  level.zone_data.zones[level.arenazonename].is_enabled = 1;
  enablecurestationcost(0);
  activateonlycurestationinzone(level.arenazonename);
  level thread runarenapowerswitches();

  if(isDefined(level.bossozstage) && level.bossozstage == 1) {
    var_1 = level common_scripts\utility::waittill_any_return("activate_terminals", "zombie_wave_interrupt");

    if(var_1 == "zombie_wave_interrupt") {
      return;
    }
  }

  if(!maps\mp\zombies\_util::is_true(var_0)) {
    level childthread handlemagicbox();
  }

  level common_scripts\utility::waittill_any("zombie_wave_ended", "zombie_wave_interrupt", "disable_arena_zone");
  level.zone_data.zones[level.arenazonename].is_enabled = 0;
  deactivatearenacurestations();
  activatenonarenacurestations();
  enablecurestationcost(1);
}

handlemagicbox() {
  foreach(var_1 in level.magicboxlocations) {
    if(maps\mp\zombies\_wall_buys::isscriptedmagicbox(var_1)) {
      var_1 thread maps\mp\zombies\_wall_buys::activatemagicboxeffects(var_1.modelent, var_1.light);
      level thread maps\mp\zombies\_wall_buys::watchmagicboxtrigger(var_1, 0);
      var_1 sethintstring(maps\mp\zombies\_wall_buys::getmagicboxhintsting());
      var_1 setsecondaryhintstring(var_1 maps\mp\zombies\_wall_buys::getmagicboxhintstringcost());
      var_1 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_1.cost));
      var_1 maps\mp\zombies\_util::tokenhintstring(1);
      var_1.active = 1;
    }
  }

  level common_scripts\utility::waittill_any("zombie_boss_wave_ended", "zombie_wave_interrupt");
  level.zone_data.zones[level.arenazonename].is_enabled = 0;

  foreach(var_1 in level.magicboxlocations) {
    if(maps\mp\zombies\_wall_buys::isscriptedmagicbox(var_1)) {
      var_1 thread maps\mp\zombies\_wall_buys::deactivatemagicboxeffects(var_1.modelent, var_1.light);
      var_1 maps\mp\zombies\_wall_buys::deactivatemagicbox();
      var_1 sethintstring(maps\mp\zombies\_wall_buys::getmagicboxhintsting(1));
      var_1 setsecondaryhintstring(var_1 maps\mp\zombies\_wall_buys::getmagicboxhintstringcost(1));
      var_1 maps\mp\zombies\_util::tokenhintstring(0);
      var_1.active = 0;
    }
  }
}

curestationpower() {
  level endon("game_ended");

  if(!common_scripts\utility::flag_exist("boss_cure_station_power")) {
    return;
  }
  for(;;) {
    common_scripts\utility::flag_clear("boss_cure_station_power");
    var_0 = 0;

    while(!var_0) {
      var_0 = 1;

      foreach(var_2 in level.boss_power_switches) {
        if(!common_scripts\utility::flag(var_2.script_flag)) {
          var_0 = 0;
          common_scripts\utility::flag_wait(var_2.script_flag);
          break;
        }
      }
    }

    common_scripts\utility::flag_set("boss_cure_station_power");
    level waittill("arena_power_switches_off");
    waitframe();
  }
}

runarenapowerswitches() {
  level endon("zombie_wave_ended");
  level endon("zombie_wave_interrupt");
  level endon("disable_arena_zone");

  if(!isDefined(level.bossozstage)) {
    arenapowerswitcheson();
  } else if(level.bossozstage == 1) {
    arenapowerswitcheson();
  } else if(level.bossozstage == 2) {
    for(;;) {
      arenapowerswitchesoff();

      foreach(var_1 in level.hostcuremodels) {
        if(var_1 curestationisinarenazone()) {
          var_1.terminal childthread curestationusewatch();
        }
      }

      level waittill("cureStationUsed");
    }
  }
}

curestationusewatch() {
  self notify("endCureStationUseWatch");
  self endon("endCureStationUseWatch");

  for(;;) {
    self waittill("trigger");

    if(common_scripts\utility::flag("boss_cure_station_power")) {
      level notify("cureStationUsed");
    }
  }
}

arenapowerswitcheson() {
  foreach(var_1 in level.boss_power_switches) {
    var_1.trigger notify("trigger");
  }
}

arenapowerswitchesoff() {
  foreach(var_1 in level.boss_power_switches) {
    var_1.trigger notify("trigger_off");
  }

  level notify("arena_power_switches_off");
}

activateonlycurestationinzone(var_0) {
  foreach(var_2 in level.hostcuremodels) {
    var_2.terminal.terminaldeactivated = var_2.zone != var_0;
  }
}

deactivatearenacurestations() {
  foreach(var_1 in level.hostcuremodels) {
    if(var_1 curestationisinarenazone()) {
      var_1.terminal.terminaldeactivated = 1;
    }
  }
}

activatenonarenacurestations() {
  foreach(var_1 in level.hostcuremodels) {
    if(!var_1 curestationisinarenazone()) {
      var_1.terminal.terminaldeactivated = 0;
    }
  }
}

curestationisinarenazone() {
  return self.zone == level.arenazonename;
}

enablecurestationcost(var_0) {
  if(var_0) {
    level.terminalitems["host_cure"].cost = 250;
  } else {
    level.terminalitems["host_cure"].cost = 0;
  }

  level notify("terminal_reenabled");
}

teleporttostructandbackatend(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self.startedbossteleport = 1;

  while(maps\mp\zombies\_util::isplayerteleporting(self)) {
    wait 0.05;
  }

  while(maps\mp\zombies\_util::is_true(self.enteringgoliath)) {
    waitframe();
  }

  self notify("stop_useHoldThinkLoop");

  while(self islinked()) {
    waitframe();
  }

  self cancelmantle();
  self.prebossorigin = self.lastgroundposition;
  self.disabletombstonedropinarea = 1;
  maps\mp\zombies\_teleport::teleport_players_through_chute([self], 0);
  thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self], 0.75);
  var_1 = playerphysicstrace(var_0.origin, var_0.origin - (0, 0, 300), self) - (0, 0, 0.9);
  self setorigin(var_1, 1);

  if(isDefined(var_0.angles)) {
    self.prebossangles = self getangles();
    self setangles(var_0.angles);
  }

  playfxontagforclients(common_scripts\utility::getfx("oz_arena_teleport_player"), self, "tag_origin", self);
  level notify("teleport_to_arena_complete");
  level waittill("teleport_players_back");
  self notify("stop_useHoldThinkLoop");
  self cancelmantle();
  maps\mp\zombies\_teleport::teleport_players_through_chute([self], 0);
  thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self], 0.75);
  var_2 = playerphysicstrace(self.prebossorigin, self.prebossorigin + (0, 0, 1));

  if(distancesquared(var_2, self.prebossorigin) < 0.001) {
    var_2 = playerphysicstrace(self.prebossorigin + (0, 0, 10), self.prebossorigin);
    self.prebossorigin = var_2;
  }

  self setorigin(self.prebossorigin, 1);

  if(isDefined(self.prebossangles)) {
    self setangles(self.prebossangles);
  }

  self.disabletombstonedropinarea = undefined;
  playfxontagforclients(common_scripts\utility::getfx("oz_arena_teleport_player"), self, "tag_origin", self);
  level notify("teleport_from_arena_complete");
  level.waitingforteleportout = undefined;
  self.startedbossteleport = undefined;
}

handlebossroundend() {
  level endon("game_ended");
  level childthread handlepostroundcure();
  level common_scripts\utility::waittill_any("zombie_boss_wave_ended", "zombie_wave_interrupt");
  level thread givereward();
  level.waitingforteleportout = 1;
  wait 10;
  zmbaudioangplayvo("stage1_end3", 1);
  level notify("teleport_players_back");
  level notify("zombie_wave_ended");
  maps\mp\zombies\_util::enablepickups();

  if(level.bossozstage == 1) {
    level waittill("teleport_from_arena_complete");
    wait 1;
    zmbaudioplayervo("s1win", 1);
    wait 0.5;
    zmbaudioannouncerbossozplayvo("s1win", 1);
  }
}

handlepostroundcure() {
  level common_scripts\utility::waittill_any("zombie_boss_wave_ended", "zombie_wave_interrupt", "boss_oz_killed");

  foreach(var_1 in level.players) {
    if(maps\mp\zombies\_util::isplayerinfected(var_1)) {
      var_1 notify("cured", 0);
    }
  }
}

givereward() {
  var_0 = common_scripts\utility::getstructarray("ozCarepackagePosition", "targetname");

  foreach(var_2 in var_0) {
    var_2.in_use = 0;
  }

  foreach(var_5 in level.players) {
    thread giverewardtoplayer(var_5);
  }

  wait 0.75;
  level.disablescoring = 0;
}

giverewardtoplayer(var_0) {
  level endon("teleport_players_back");

  for(;;) {
    var_1 = var_0 getmoneyposition();
    var_1.in_use = 1;
    var_2 = var_0 maps\mp\killstreaks\_airdrop::createairdropcrate(var_0, "airdrop_assault", "ozMoney", var_1.origin, undefined, 0, 1);
    playFX(common_scripts\utility::getfx("crate_teleport"), var_1.origin, (1, 0, 0), (0, 0, 1));
    var_2 thread[[level.cratetypes["airdrop_assault"]["ozMoney"].func]]("airdrop_assault");
    var_2 disconnectpaths();
    var_2 thread deletecrateonteleport();

    while(isDefined(var_2)) {
      waitframe();
    }

    var_1.in_use = 0;
    waitframe();
  }
}

getmoneyposition() {
  var_0 = common_scripts\utility::getstructarray("ozCarepackagePosition", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!var_3.in_use) {
      var_1[var_1.size] = var_3;
    }
  }

  var_5 = common_scripts\utility::get_array_of_closest(self.origin, var_1);
  var_6 = int(var_5.size * 0.75);
  var_7 = randomintrange(1, var_6);
  return var_5[var_7];
}

deletecrateonteleport() {
  self endon("death");
  level waittill("teleport_players_back");
  maps\mp\killstreaks\_airdrop::deletecrate(0);
}

handleammo() {
  level endon("game_ended");
  level.disablescoring = 1;
  level thread handleammodrops();
  level common_scripts\utility::waittill_any("zombie_boss_wave_ended", "zombie_wave_interrupt");

  if(isDefined(level.ammocrate)) {
    level.ammocrate maps\mp\killstreaks\_airdrop::deletecrate(1);
  }
}

handleammodrops() {
  level endon("game_ended");
  level endon("zombie_wave_interrupt");
  level endon("zombie_boss_wave_ended");
  level.noammodroptriggers = [];
  var_0 = common_scripts\utility::getstructarray("ozCarepackagePosition", "targetname");

  for(;;) {
    wait 12.0;
    var_1 = common_scripts\utility::random(level.players);
    var_2 = findammocratedrop(var_0);
    level.ammocrate = var_1 maps\mp\killstreaks\_airdrop::createairdropcrate(var_1, "airdrop_assault", "ammo", var_2.origin, undefined, 0, 1);
    playFX(common_scripts\utility::getfx("crate_teleport"), var_2.origin, (1, 0, 0), (0, 0, 1));
    level.ammocrate thread[[level.cratetypes["airdrop_assault"]["ammo"].func]]("airdrop_assault");
    level.ammocrate disconnectpaths();

    while(isDefined(level.ammocrate)) {
      wait 0.05;
    }
  }
}

findammocratedrop(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = 1;

    foreach(var_6 in level.noammodroptriggers) {
      if(ispointinvolume(var_3.origin + (0, 0, 35), var_6)) {
        var_4 = 0;
        break;
      }
    }

    if(var_4) {
      var_1[var_1.size] = var_3;
    }
  }

  return common_scripts\utility::random(var_1);
}

moneycratethink(var_0) {
  self endon("death");
  self.owner = undefined;
  var_1 = undefined;

  if(isDefined(game["strings"][var_0 + self.cratetype + "_hint"])) {
    var_1 = game["strings"][var_0 + self.cratetype + "_hint"];
  } else {
    var_1 = &"PLATFORM_GET_KILLSTREAK";
  }

  maps\mp\killstreaks\_airdrop::cratesetuphintstrings(var_1);
  maps\mp\killstreaks\_airdrop::cratesetupforuse("all", "hud_carepkg_world_credits");
  thread maps\mp\zombies\killstreaks\_zombie_killstreaks::crateothercapturethink(undefined, 1, 500);

  for(;;) {
    self waittill("captured", var_2);
    var_2 playlocalsound("zmb_ss_credits_acquire");
    var_3 = 250 + randomintrange(0, 20) * 50;
    var_2 maps\mp\gametypes\zombies::givepointsforevent("crate", var_3, 1);
    maps\mp\killstreaks\_airdrop::deletecrate(1);
  }
}

ammocratethink(var_0) {
  self endon("death");
  self.owner = undefined;
  var_1 = &"ZOMBIE_H2O_AMMO_CRATE";
  maps\mp\killstreaks\_airdrop::cratesetuphintstrings(var_1);
  maps\mp\killstreaks\_airdrop::cratesetupforuse("all", "hud_drop_sm_maxammo");
  thread maps\mp\zombies\killstreaks\_zombie_killstreaks::crateothercapturethink(undefined, 1);

  for(;;) {
    self waittill("captured", var_2);
    var_2 playlocalsound("zmb_pickup_general");
    var_2 maps\mp\gametypes\zombies::refillammozombies(var_2, 1);
    var_2 maps\mp\gametypes\zombies::playersetem1maxammo();
    maps\mp\killstreaks\_airdrop::deletecrate(1);
  }
}

zmbaudiochangeozvotoplayonent(var_0) {
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_oz", "janitor_", var_0, 0);
}

zmbaudioresetozvoent() {
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_oz", "janitor_", level.announceroz, 0);
}

zmbaudiobossozplayvo(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
  var_6 endon("death");

  if(isDefined(var_3)) {
    wait(var_3);
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!var_5) {
    waittilldonespeaking();
  }

  var_7 = var_6 maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players", "dlc4_" + var_0, undefined, var_2, var_4);

  if(var_7 && var_1) {
    var_6 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 10);
  }

  return var_7;
}

zmbaudioannouncerbossozplayvo(var_0, var_1) {
  waittilldonespeaking();
  var_2 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
  var_3 = var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", "dlc4_" + var_0);

  if(var_3 && var_1) {
    maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
  }
}

zmbaudioangplayvo(var_0, var_1) {
  waittilldonespeaking();
  var_2 = maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority", var_0);

  if(var_2 && var_1) {
    maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
  }
}

anyplayersspeaking() {
  foreach(var_1 in level.players) {
    if(maps\mp\zombies\_util::is_true(var_1.isspeaking)) {
      return 1;
    }
  }

  return 0;
}

waittilldonespeaking() {
  while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isanyannouncerspeaking()) {
    waitframe();
  }
}

getrandomaliveplayer() {
  var_0 = common_scripts\utility::array_randomize(level.players);

  foreach(var_2 in level.players) {
    if(isalive(var_2) && !maps\mp\zombies\_util::isplayerinlaststand(var_2)) {
      return var_2;
    }
  }
}

zmbaudioplayervo(var_0, var_1, var_2) {
  waittilldonespeaking();

  if(!isDefined(var_2)) {
    var_2 = getrandomaliveplayer();
  }

  var_3 = var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "dlc4_" + var_0);

  if(var_3 && var_1) {
    waittilldonespeaking();
  }
}