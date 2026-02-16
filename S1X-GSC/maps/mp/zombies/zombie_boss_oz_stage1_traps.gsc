/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_boss_oz_stage1_traps.gsc
***********************************************************/

init_traps() {
  level.stage1traps = [];
  level.invalidationtrapsequence = [];
  level.invalidationtrapwarningtime = [-1, 5.0, 4.25, 3.5];
  level.invalidationtrapdamagetime = [-1, 40.0, 34.0, 28.0];
  level.trapsequencetime = [-1, 50.0, 42.5, 35.0];
  var_0 = spawnStruct();
  var_0.type = "aerial_lasers";
  var_0.weight = 1.0;
  var_0.lasers = aeriallaser_init();
  var_0.istrapactivefunc = ::aeriallaser_istrapactive;
  var_0.canruntrapfunc = ::aeriallaser_canruntrap;
  var_0.runtrapfunc = ::aeriallaser_runtrap;
  var_0.gettraptriggersfunc = ::aeriallaser_gettriggers;
  var_0 setup_trap_overlap(["electricity", "gas"], ["electricity", "gas"], ["electricity"], ["electricity"]);
  level.stage1traps[var_0.type] = var_0;
  var_0 = spawnStruct();
  var_0.type = "electricity";
  var_0.weight = 1.0;
  var_0.electricity = electrotrap_init();
  var_0.istrapactivefunc = ::electrotrap_istrapactive;
  var_0.canruntrapfunc = ::electrotrap_canruntrap;
  var_0.runtrapfunc = ::electrotrap_runtrap;
  var_0 setup_trap_overlap(["aerial_lasers", "gas"], ["aerial_lasers", "gas"], ["aerial_lasers", "gas"], ["aerial_lasers"]);
  level.stage1traps[var_0.type] = var_0;
  var_0 = spawnStruct();
  var_0.type = "gas";
  var_0.weight = 1.0;
  var_0.gas = gastrap_init();
  var_0.istrapactivefunc = ::gastrap_istrapactive;
  var_0.canruntrapfunc = ::gastrap_canruntrap;
  var_0.runtrapfunc = ::gastrap_runtrap;
  var_0.gettraptriggersfunc = ::gastrap_gettriggers;
  var_0 setup_trap_overlap(["aerial_lasers", "electricity"], ["aerial_lasers", "electricity"], ["electricity"], []);
  level.stage1traps[var_0.type] = var_0;
  var_0 = spawnStruct();
  var_0.type = "stationary_turrets";
  var_0.weight = 1.0;
  var_0.turretdoors = stationaryturret_init();
  var_0.canruntrapfunc = ::stationaryturret_canrunturrettrap;
  var_0.runtrapfunc = ::stationaryturret_runturrettrap;
  level.stage1traps[var_0.type] = var_0;
  var_0 = spawnStruct();
  var_0.type = "mounted_turrets";
  var_0.weight = 1.0;
  var_0.turrets = mountedturret_init();
  var_0.canruntrapfunc = ::mountedturret_canrunturrettrap;
  var_0.runtrapfunc = ::mountedturret_runturrettrap;
  level.stage1traps[var_0.type] = var_0;
  var_0 = spawnStruct();
  var_0.type = "zombies";
  var_0.weight = 1.0;
  var_0.canruntrapfunc = ::zombietrap_canruntrap;
  var_0.runtrapfunc = ::zombietrap_runtrap;
  level.stage1traps[var_0.type] = var_0;
}

begin_round_init_traps() {
  var_0 = getEntArray("boss_oz_mounted_turret", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

setup_trap_overlap(var_0, var_1, var_2, var_3) {
  self.nooverlapwith[0] = var_0;
  self.nooverlapwith[1] = var_1;
  self.nooverlapwith[2] = var_2;
  self.nooverlapwith[3] = var_3;
}

run_trap_sequence(var_0) {
  level endon("game_ended");
  level endon("zombie_wave_interrupt");
  level endon("zombie_boss_wave_ended");
  var_1 = ["aerial_lasers", "electricity", "gas"];
  var_2[0] = ["stationary_turrets", "mounted_turrets"];
  var_2[1] = ["zombies"];
  var_3 = maps\mp\zombies\zombie_boss_oz_stage1::getstage1phase();
  maps\mp\zombies\_util::waittillzombiegameunpaused();
  wait 0.5;
  var_10 = level.trapsequencetime[var_3] / 3.0;

  for(var_9 = 0; var_9 < var_0; var_9++) {
    if(level.invalidationtrapsequence.size == 0) {
      level.invalidationtrapsequence = var_1;
    }

    if(level.invalidationtrapsequence.size > 0) {
      var_11 = level.invalidationtrapsequence[0];
      var_12 = level.stage1traps[var_11];
      level thread[[var_12.runtrapfunc]](var_12, level.invalidationtrapwarningtime[var_3], level.invalidationtrapdamagetime[var_3]);
      thread maps\mp\zombies\zombie_boss_oz_stage1::ozplaytrapanim(var_10);
      level.invalidationtrapsequence = common_scripts\utility::array_remove(level.invalidationtrapsequence, var_11);
      level childthread playozrandomvo(var_10);
    }

    wait(var_10);
    maps\mp\zombies\_util::waittillzombiegameunpaused();
    var_2 = common_scripts\utility::array_randomize(var_2);
    run_trap_from_list(var_2[0]);
    thread maps\mp\zombies\zombie_boss_oz_stage1::ozplaytrapanim(var_10);
    level childthread playozrandomvo(var_10);
    wait(var_10);
    maps\mp\zombies\_util::waittillzombiegameunpaused();
    run_trap_from_list(var_2[1]);
    thread maps\mp\zombies\zombie_boss_oz_stage1::ozplaytrapanim(var_10);
    level childthread playozrandomvo(var_10);
    wait(var_10);
    maps\mp\zombies\_util::waittillzombiegameunpaused();
  }
}

playozrandomvo(var_0) {
  var_1 = 8;
  var_2 = var_0 - 5;

  if(var_2 < 0 || var_1 > var_0 || var_1 > var_2) {
    return;
  }
  wait(randomfloatrange(var_1, var_2));
  maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("rand1", 0, undefined, undefined, undefined, 1);
}

run_trap_from_list(var_0) {
  var_1 = pick_trap_from_named_list(var_0);

  if(isDefined(var_1)) {
    level thread[[var_1.runtrapfunc]](var_1);
  }
}

pick_trap_from_named_list(var_0) {
  var_1 = [];

  foreach(var_3 in level.stage1traps) {
    if(common_scripts\utility::array_contains(var_0, var_3.type)) {
      var_1[var_1.size] = var_3;
    }
  }

  var_5 = undefined;

  while(!isDefined(var_5) && var_1.size > 0) {
    var_6 = 0.0;

    foreach(var_3 in var_1) {
      var_6 = var_6 + var_3.weight;
    }

    var_9 = randomfloat(var_6);

    foreach(var_3 in var_1) {
      if(var_9 < var_3.weight) {
        var_5 = var_3;
        break;
      } else {
        var_9 = var_9 - var_3.weight;
      }
    }

    var_12 = [[var_5.canruntrapfunc]](var_5);

    if(var_12) {
      var_12 = !trapoverlapsactiveillegaltrap(var_5);
    }

    if(!var_12) {
      var_1 = common_scripts\utility::array_remove(var_1, var_5);
      var_5 = undefined;
    }
  }

  return var_5;
}

trapoverlapsactiveillegaltrap(var_0) {
  if(!isDefined(var_0.nooverlapwith)) {
    return 0;
  }

  var_1 = maps\mp\zombies\zombie_boss_oz_stage1::getstage1phase();
  var_2 = var_0.nooverlapwith[var_1];

  if(!isDefined(var_2)) {
    return 0;
  }

  foreach(var_4 in var_2) {
    var_5 = level.stage1traps[var_4];

    if([[var_5.istrapactivefunc]](var_5)) {
      return 1;
    }
  }

  return 0;
}

waittilltimeorroundend(var_0) {
  var_1 = level common_scripts\utility::waittill_any_timeout(var_0, "game_ended", "zombie_wave_interrupt", "zombie_boss_wave_ended", "stop_all_boss_traps");
  return var_1 == "timeout";
}

turrethandledeath() {
  var_0 = self getentitynumber();
  self waittill("death", var_1, var_2, var_3);

  if(isremovedentity(self)) {
    return;
  }
  self.isalive = 0;
  self.damagecallback = undefined;
  self setCanDamage(0);
  self setdamagecallbackon(0);
  self freeentitysentient();
  self setmode("sentry_offline");
  self setdefaultdroppitch(35);
  self setsentryowner(undefined);
  self setturretminimapvisible(0);
  var_4 = self.owner;
  self.waitingtodie = 1;
  self playSound("sentry_explode");
  playFXOnTag(common_scripts\utility::getfx("sentry_explode_mp"), self, "tag_aim");
  self playSound("sentry_explode_smoke");
  wait 0.5;
  self notify("deleting");
  self delete();
}

turretsetupdamagecallback() {
  self.damagecallback = ::turrethandledamagecallback;
  self setCanDamage(1);
  self setdamagecallbackon(1);
}

turrethandledamagecallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_1) || var_1.classname == "worldspawn") {
    return;
  }
  if(var_1.team == self.team) {
    return;
  }
  var_12 = maps\mp\zombies\zombie_boss_oz_stage1::ozscaledamageforkillstreakorweaponlevel(var_0, var_1, var_5, var_4, var_2);
  self.wasdamaged = 1;
  self.damagefade = 0.0;

  if(isPlayer(var_1)) {
    var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("remote_turret");
  }

  self finishentitydamage(var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

turretgetenemy(var_0, var_1) {
  var_2 = (0, 0, 72);
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5.ignoreme || var_5 isnotarget()) {
      continue;
    }
    if(var_5.sessionstate == "spectator") {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  var_7 = 500000000;
  var_8 = undefined;

  foreach(var_5 in var_3) {
    var_10 = distancesquared(var_5.origin, var_0.origin);

    if(var_10 < var_7) {
      if(sighttracepassed(var_5.origin + var_2, var_0.origin + var_1, 0, undefined)) {
        var_7 = var_10;
        var_8 = var_5;
      }
    }
  }

  return var_8;
}

stationaryturret_init() {
  level._effect["stationary_turret_teleport"] = loadfx("vfx/unique/dlc_teleport_soldier_bad");
  var_0 = common_scripts\utility::getStructArray("arena_turret_door", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread init_arena_turret_door();
  }

  return var_0;
}

stationaryturret_getnumtoactivate() {
  if(maps\mp\zombies\_util::getnumplayers() <= 2) {
    return 1;
  } else {
    return 2;
  }
}

stationaryturret_canrunturrettrap(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0.turretdoors) {
    if(!var_3.open) {
      var_1++;
    }
  }

  return var_1 > stationaryturret_getnumtoactivate();
}

stationaryturret_runturrettrap(var_0) {
  var_1 = common_scripts\utility::array_randomize(var_0.turretdoors);

  if(level.currentgen) {
    var_2 = 0;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3].open) {
        var_2++;
      }
    }

    if(var_2 >= 2) {
      return;
    }
  }

  var_4 = 0;

  for(var_3 = 0; var_3 < var_1.size && var_4 < stationaryturret_getnumtoactivate(); var_3++) {
    if(!var_1[var_3].open) {
      var_1[var_3] thread open_door();
      var_5 = stationaryturret_spawnenemyturret("boss_oz_sentry_minigun_mp", var_1[var_3]);
      var_5 thread closedooronturretdeath(var_1[var_3]);
      var_5 thread destroyturretonroundend();
      var_4++;
    }
  }

  level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("sentry", 0);
}

destroyturretonroundend() {
  self endon("death");
  level common_scripts\utility::waittill_any("game_ended", "zombie_wave_interrupt", "zombie_boss_wave_ended");
  self notify("death");
}

stationaryturret_spawnenemyturret(var_0, var_1) {
  var_2 = spawnturret("misc_turret", var_1.origin, var_0);
  var_2.angles = var_1.angles;
  var_2.owner = undefined;
  var_2.health = 1000;
  var_2.maxhealth = 1000;
  var_2.turrettype = "mg_turret";
  var_2.stunned = 0;
  var_2.directhacked = 0;
  var_2.stunnedtime = 5.0;
  var_2.issentry = 1;
  var_2.weaponinfo = var_0;
  var_2.energyturret = 0;
  var_2.rocketturret = 0;
  var_2.guardian = 0;
  var_2.isalive = 1;
  var_2 setModel("npc_sentry_minigun_turret_base");
  var_2 setmode("sentry_manual");
  var_2 setturretteam("axis");
  var_2 setsentryowner(undefined);
  var_2 setturretminimapvisible(1, var_0);
  var_2 setleftarc(48);
  var_2 setrightarc(48);
  var_2 setdefaultdroppitch(-89.0);
  var_2.damagefade = 1.0;
  var_2 laseron("trap_zm");
  playFX(common_scripts\utility::getfx("stationary_turret_teleport"), var_2.origin, (1, 0, 0), (0, 0, 1));
  var_2 thread stationaryturret_picktarget();
  var_2 thread stationaryturret_shoot();
  var_2 thread stationaryturret_setactive();
  return var_2;
}

stationaryturret_shoot() {
  self endon("death");
  self endon("deleting");
  level endon("game_ended");
  wait 3.0;

  for(;;) {
    wait 0.05;

    if(isDefined(self.targetplayer) && (isPlayer(self.targetplayer) && self.targetplayer.ignoreme)) {
      continue;
    }
    if(isDefined(self.targetplayer)) {
      if(isDefined(self getturrettarget(1))) {
        var_0 = randomintrange(25, 50);

        for(var_1 = 0; var_1 < var_0; var_1++) {
          self shootturret();
          wait 0.1;
        }

        wait(randomintrange(3, 5));
        continue;
      }

      wait(randomintrange(1, 3));
    }
  }
}

stationaryturret_picktarget() {
  self endon("death");
  self endon("deleting");
  level endon("game_ended");

  for(;;) {
    var_0 = turretgetenemy(self, (0, 0, 40));

    if(!isDefined(self.waitingtodie) && isDefined(var_0)) {
      if(isDefined(var_0.isaerialassaultdrone) && var_0.isaerialassaultdrone) {
        self settargetentity(var_0, (0, 0, -20));
      } else {
        self settargetentity(var_0);
      }

      self.targetplayer = var_0;
    } else {
      self cleartargetentity();
      self.targetplayer = undefined;
    }

    wait 0.1;
  }
}

stationaryturret_setactive() {
  self endon("death");
  self setdefaultdroppitch(0.0);
  self makeunusable();
  self maketurretsolid();
  self.team = "axis";
  self setturretteam("axis");
  thread turrethandledeath();
  thread turretsetupdamagecallback();
}

closedooronturretdeath(var_0) {
  self waittill("death");

  while(!var_0.open) {
    wait 0.05;
  }

  var_0 close_door();
}

init_arena_turret_door() {
  self.mover = getent(self.target, "targetname");
  self.mover.closed_pos = self.mover.origin;
  var_0 = common_scripts\utility::getstruct(self.mover.target, "targetname");
  self.mover.open_pos = var_0.origin;
  var_1 = getent(self.mover.target, "targetname");
  var_1 linkto(self.mover);

  if(level.nextgen) {
    var_2 = getscriptablearray("light_pluse_turret_mp_zombie_h2o", "targetname");
    self.scriptablelight = common_scripts\utility::get_array_of_closest(self.mover.origin, var_2)[0];
    self.scriptablelight setscriptablepartstate(0, 0);
  }

  self.open = 0;
}

open_door() {
  level endon("game_ended");

  if(level.nextgen) {
    self.scriptablelight setscriptablepartstate(0, 1);
  }

  self.mover activate_door("open", 3.0);
  self.open = 1;
}

close_door() {
  level endon("game_ended");

  if(level.nextgen) {
    self.scriptablelight setscriptablepartstate(0, 0);
  }

  self.mover activate_door("close", 0.5);
  self.open = 0;
}

activate_door(var_0, var_1) {
  if(var_0 == "open") {
    self moveto(self.open_pos, var_1);
  } else if(var_0 == "close") {
    self moveto(self.closed_pos, var_1);
  }

  self playSound("interact_door");
  wait(var_1);

  if(maps\mp\_movers::script_mover_is_dynamic_path()) {
    if(var_0 == "open") {
      self connectpaths();
    } else if(var_0 == "close") {
      self disconnectpaths();
    }
  }
}

mountedturret_init() {
  level._effect["mounted_turret_teleport"] = loadfx("vfx/unique/dlc_teleport_soldier_bad");

  if(!isDefined(level.sentrysettings)) {
    level.sentrysettings = [];
  }

  var_0 = "boss_oz_mounted_turret";
  level.sentrysettings[var_0] = spawnStruct();
  level.sentrysettings[var_0].health = 250;
  level.sentrysettings[var_0].maxhealth = 250;
  level.sentrysettings[var_0].burstmin = 20;
  level.sentrysettings[var_0].burstmax = 120;
  level.sentrysettings[var_0].pausemin = 0.15;
  level.sentrysettings[var_0].pausemax = 0.35;
  level.sentrysettings[var_0].sentrymodeon = "sentry_manual";
  level.sentrysettings[var_0].sentrymodeoff = "sentry_offline";
  level.sentrysettings[var_0].timeout = 90.0;
  level.sentrysettings[var_0].spinuptime = 0.05;
  level.sentrysettings[var_0].overheattime = 8.0;
  level.sentrysettings[var_0].cooldowntime = 0.1;
  level.sentrysettings[var_0].fxtime = 0.3;
  level.sentrysettings[var_0].streakname = "sentry";
  level.sentrysettings[var_0].weaponinfo = "boss_oz_mounted_turret_mp";
  level.sentrysettings[var_0].modelbase = "boss_oz_mounted_turret";
  return common_scripts\utility::getStructArray("boss_turret_elevated", "targetname");
}

mountedturret_initsentry() {
  self.sentrytype = "boss_oz_mounted_turret";
  self setleftarc(180);
  self setrightarc(180);
  self settoparc(89);
  self setbottomarc(89);
  self setModel(level.sentrysettings[self.sentrytype].modelbase);
  self maketurretinoperable();
  self setdefaultdroppitch(0);
  self setCanDamage(0);
  self.team = "axis";
  self setturretteam("axis");
  self.aimingorg = common_scripts\utility::getstruct(self.target, "targetname");
  self setturretmodechangewait(1);
  maps\mp\killstreaks\_autosentry::sentry_setinactive();
}

mountedturret_spawnturret() {
  self.turret = spawnturret("misc_turret", self.origin, level.sentrysettings["boss_oz_mounted_turret"].weaponinfo);
  self.turret.angles = self.angles;
  self.turret.weaponinfo = level.sentrysettings["boss_oz_mounted_turret"].weaponinfo;
  self.turret setModel(level.sentrysettings["boss_oz_mounted_turret"].modelbase);
  self.turret.target = self.target;
  self.turret.targetname = "boss_oz_mounted_turret";
  self.turret mountedturret_initsentry();
  playFX(common_scripts\utility::getfx("mounted_turret_teleport"), self.turret.origin, (1, 0, 0), (0, 0, 1));
}

mountedturret_activateturret() {
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
  thread mountedturret_handletargeting();
  self.isalive = 1;
  self.health = level.sentrysettings[self.sentrytype].health;
  self.maxhealth = level.sentrysettings[self.sentrytype].maxhealth;
  self makeunusable();
  self maketurretsolid();
  thread turrethandledeath();
  thread turretsetupdamagecallback();
  self laseron("trap_zm");
}

mountedturret_handletargeting() {
  self endon("death");
  self endon("deleting");
  self endon("disable_turret");
  level endon("game_ended");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  childthread maps\mp\killstreaks\_autosentry::sentry_heatmonitor();
  var_0 = undefined;

  for(;;) {
    var_1 = turretgetenemy(self.aimingorg, (0, 0, 0));

    if(!isDefined(var_0) && isDefined(var_1)) {
      childthread maps\mp\killstreaks\_autosentry::sentry_burstfirestart();
    } else if(isDefined(var_0) && !isDefined(var_1)) {
      childthread maps\mp\killstreaks\_autosentry::sentry_burstfirestop();
    }

    var_0 = var_1;

    if(isDefined(var_1)) {
      self settargetentity(var_1);
    } else {
      self cleartargetentity();
    }

    wait 0.5;
  }
}

mountedturret_getnumtoactivate() {
  if(maps\mp\zombies\_util::getnumplayers() <= 2) {
    return 1;
  } else {
    return 2;
  }
}

mountedturret_canrunturrettrap(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0.turrets) {
    if(!(isDefined(var_3.turret) && isalive(var_3.turret))) {
      var_1++;
    }
  }

  return var_1 >= mountedturret_getnumtoactivate();
}

mountedturret_runturrettrap(var_0) {
  var_1 = common_scripts\utility::array_randomize(var_0.turrets);

  if(level.currentgen) {
    var_2 = 0;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(isDefined(var_1[var_3].turret) && isalive(var_1[var_3].turret)) {
        var_2++;
      }
    }

    if(var_2 >= 4) {
      return;
    }
  }

  var_4 = 0;

  for(var_3 = 0; var_3 < var_1.size && var_4 < mountedturret_getnumtoactivate(); var_3++) {
    if(!(isDefined(var_1[var_3].turret) && isalive(var_1[var_3].turret))) {
      var_1[var_3] mountedturret_spawnturret();
      var_1[var_3].turret mountedturret_activateturret();
      var_1[var_3].turret thread deactivateturretonroundend();
      var_4++;
    }
  }

  level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("turret", 0);
}

deactivateturretonroundend() {
  self endon("death");
  level common_scripts\utility::waittill_any("game_ended", "zombie_wave_interrupt", "zombie_boss_wave_ended");
  self cleartargetentity();
  self laseroff();
  self notify("disable_turret");
  mountedturret_initsentry();
}

aeriallaser_init() {
  var_0 = getEntArray("boss_oz_air_laser", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::getStructArray(var_2.target, "targetname");
    var_2.laser_ents = [];

    foreach(var_5 in var_3) {
      var_2.laser_ents[var_2.laser_ents.size] = setup_laser_trap(var_5);
    }

    var_2.enabled = 0;
  }

  return var_0;
}

setup_laser_trap(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1.start_origin = var_1.origin;
  var_1.start_angles = var_1.angles;
  var_1 setModel("tag_laser");
  return var_1;
}

aeriallaser_istrapactive(var_0) {
  foreach(var_2 in var_0.lasers) {
    if(var_2.enabled) {
      return 1;
    }
  }

  return 0;
}

aeriallaser_canruntrap(var_0) {
  return !aeriallaser_istrapactive(var_0);
}

aeriallaser_runtrap(var_0, var_1, var_2, var_3) {
  level thread aeriallaser_fx(var_1, var_2);

  foreach(var_5 in var_0.lasers) {
    var_5 thread start_laser(var_1, var_2);
  }

  if(!isDefined(var_3)) {
    level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("laser", 0);
  }
}

aeriallaser_gettriggers(var_0) {
  return var_0.lasers;
}

aeriallaser_fx(var_0, var_1) {
  var_2 = 91;
  var_3 = 92;
  activatepersistentclientexploder(var_2);
  var_4 = waittilltimeorroundend(var_0);

  if(var_4) {
    stopclientexploder(var_2);
    activatepersistentclientexploder(var_3);
    waittilltimeorroundend(var_1);
    stopclientexploder(var_3);
  } else {
    stopclientexploder(var_2);
  }
}

start_laser(var_0, var_1) {
  self.enabled = 1;
  start_laser_sounds();
  var_2 = waittilltimeorroundend(var_0);

  if(var_2) {
    childthread start_laser_damage();
    waittilltimeorroundend(var_1);
  }

  stop_laser_sounds();
  self notify("cooldown");
  self.enabled = 0;
}

start_laser_damage() {
  self endon("cooldown");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      if(isDefined(var_0.nextlasertrapdamagetime) && var_0.nextlasertrapdamagetime > gettime()) {
        continue;
      }
      var_0.nextlasertrapdamagetime = gettime() + 2500;
      var_0 dodamage(40, var_0.origin, undefined, undefined, "MOD_TRIGGER_HURT");

      if(isDefined(var_0.exosuitonline) && var_0.exosuitonline && !(isDefined(var_0.nextlasertrapemptime) && var_0.nextlasertrapemptime > gettime())) {
        var_0.nextlasertrapemptime = gettime() + 2500;
        var_0 thread maps\mp\zombies\_mutators::mutatoremz_applyemp();
        playFX(level._effect["mut_emz_attack_sm"], var_0.origin);
        var_0 playlocalsound("zmb_emz_impact");
      }
    }
  }
}

start_laser_sounds() {
  playsoundatpos((0, 0, 0), "zom_boss_grid_trap_on");

  foreach(var_1 in self.laser_ents) {}
}

stop_laser_sounds() {
  playsoundatpos((0, 0, 0), "zom_boss_grid_trap_off");

  foreach(var_1 in self.laser_ents) {}
}

electrotrap_init() {
  level._effect["trap_electric_floor_shock_warning"] = loadfx("vfx/map/mp_zombie_h2o/electrified_floor_warning");
  level._effect["trap_electric_floor_shock_active"] = loadfx("vfx/map/mp_zombie_brg/electrified_floor");
  var_0 = common_scripts\utility::getStructArray("trap_electricity", "targetname");

  foreach(var_2 in var_0) {
    var_2.damage_triggers = [];
    var_2.fx_structs = [];
    var_2.enabled = 0;
    var_3 = common_scripts\utility::array_combine(getEntArray(var_2.target, "targetname"), common_scripts\utility::getStructArray(var_2.target, "targetname"));

    foreach(var_5 in var_3) {
      if(var_5.script_noteworthy == "damage_over_time") {
        var_2.damage_triggers[var_2.damage_triggers.size] = var_5;
        continue;
      }

      if(var_5.script_noteworthy == "fx_trap") {
        var_2.fx_structs[var_2.fx_structs.size] = var_5;
      }
    }
  }

  return var_0;
}

electrotrap_istrapactive(var_0) {
  foreach(var_2 in var_0.electricity) {
    if(var_2.enabled) {
      return 1;
    }
  }

  return 0;
}

electrotrap_canruntrap(var_0) {
  return !electrotrap_istrapactive(var_0);
}

electrotrap_runtrap(var_0, var_1, var_2, var_3) {
  thread electrotrap_startelectricity(var_0.electricity, var_1, var_2);

  if(!isDefined(var_3)) {
    level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("elect", 0);
  }
}

electrotrap_startelectricity(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::array_randomize(var_0);
  var_3 = common_scripts\utility::array_combine(var_3, var_3);

  foreach(var_5 in var_0) {
    var_5 start_electricity_warning_fx();
  }

  var_7 = waittilltimeorroundend(var_1);

  foreach(var_5 in var_0) {
    var_5 stop_electricity_fx();
  }

  if(!var_7) {
    return;
  }
  foreach(var_5 in var_3) {
    var_5.enabled = 1;

    foreach(var_12 in var_5.damage_triggers) {
      var_12 thread start_electricity_damage();
    }

    var_5 start_electricity_fx();
    var_5 start_electricity_sound();
    var_7 = waittilltimeorroundend(var_2 / 4);

    foreach(var_12 in var_5.damage_triggers) {
      var_12 stop_electricity_damage();
    }

    var_5 stop_electricity_fx();
    var_5 stop_electricity_sound();
    var_5.enabled = 0;

    if(!var_7) {
      return;
    }
  }
}

start_electricity_damage() {
  self endon("cooldown");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      if(isDefined(var_0.nextelectricitytrapdamagetime) && var_0.nextelectricitytrapdamagetime > gettime()) {
        continue;
      }
      var_0.nextelectricitytrapdamagetime = gettime() + 1000;
      var_0 dodamage(17, var_0.origin, undefined, undefined, "MOD_TRIGGER_HURT");
    }
  }
}

stop_electricity_damage() {
  self notify("cooldown");
}

start_electricity_warning_fx() {
  foreach(var_1 in self.fx_structs) {
    var_1.fx = spawnfx(common_scripts\utility::getfx("trap_electric_floor_shock_warning"), var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
    triggerfx(var_1.fx);
  }
}

start_electricity_fx() {
  foreach(var_1 in self.fx_structs) {
    var_1.fx = spawnfx(common_scripts\utility::getfx("trap_electric_floor_shock_active"), var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
    triggerfx(var_1.fx);
  }
}

stop_electricity_fx() {
  foreach(var_1 in self.fx_structs) {
    var_1.fx delete();
  }
}

start_electricity_sound() {
  self.electricity_sound = spawn("script_origin", self.origin);
  playsoundatpos(self.electricity_sound.origin, "electric_floor_start");
  self.electricity_sound playLoopSound("electric_floor_loop");
}

stop_electricity_sound() {
  playsoundatpos(self.electricity_sound.origin, "electric_floor_stop");
  self.electricity_sound scalevolume(0, 0.25);
  wait 0.25;
  self.electricity_sound stoploopsound();
  waitframe();
  self.electricity_sound delete();
}

gastrap_init() {
  var_0 = getEntArray("boss_oz_gas", "targetname");

  foreach(var_2 in var_0) {
    var_2.enabled = 0;
  }

  return var_0;
}

gastrap_istrapactive(var_0) {
  foreach(var_2 in var_0.gas) {
    if(var_2.enabled) {
      return 1;
    }
  }

  return 0;
}

gastrap_canruntrap(var_0) {
  return !gastrap_istrapactive(var_0);
}

gastrap_runtrap(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0.gas) {
    var_5 thread start_gas(var_1, var_2);
  }

  if(!isDefined(var_3)) {
    level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("gas", 0);
  }
}

gastrap_gettriggers(var_0) {
  return var_0.gas;
}

start_gas(var_0, var_1) {
  self.enabled = 1;
  start_gas_fx();
  var_2 = waittilltimeorroundend(var_0);

  if(var_2) {
    childthread start_gas_damage();
    waittilltimeorroundend(var_1);
  }

  stop_gas_fx();
  self notify("cooldown");
  self.enabled = 0;
}

start_gas_fx() {
  activatepersistentclientexploder(90);
  playsoundatpos((0, 0, 0), "zom_boss_gas_trap_on");
}

stop_gas_fx() {
  stopclientexploder(90);
  playsoundatpos((0, 0, 0), "zom_boss_gas_trap_off");
}

start_gas_damage() {
  self endon("cooldown");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      if(isDefined(var_0.nextgastrapdamagetime) && var_0.nextgastrapdamagetime > gettime()) {
        continue;
      }
      var_0.nextgastrapdamagetime = gettime() + 2000;

      if(!var_0 maps\mp\_utility::isjuggernaut() && !maps\mp\zombies\_util::isplayerinlaststand(var_0)) {
        if(!maps\mp\zombies\_util::isplayerinfected(var_0) && !var_0 isgod()) {
          var_0 thread maps\mp\zombies\_zombies_laststand::hostzombielaststand();
          var_0.lastinfectdamagetime = gettime();
          continue;
        }

        var_0 dodamage(50, var_0.origin, undefined, undefined, "MOD_TRIGGER_HURT");
      }
    }
  }
}

zombietrap_canruntrap(var_0) {
  return 1;
}

zombietrap_runtrap(var_0) {
  var_1 = getarraykeys(level.special_mutators);
  var_1[var_1.size] = "zombie_dog";
  var_1[var_1.size] = "zombie_host";
  level.nextbosswavezombietype = common_scripts\utility::random(var_1);
  var_2["limitedSpawns"] = 1;
  var_2["forceSpawnDelay"] = 1;

  if(level.nextbosswavezombietype == "zombie_dog" || level.nextbosswavezombietype == "zombie_host") {
    var_2["overrideSpawnType"] = level.nextbosswavezombietype;
    level childthread maps\mp\zombies\zombies_spawn_manager::spawnzombies(zombietrap_getnumzombiestospawn(), 0.05, var_2);
  } else {
    var_2["mutatorFunc"] = ::zombietrap_applymutator;
    level childthread maps\mp\zombies\zombies_spawn_manager::spawnzombies(zombietrap_getnumzombiestospawn(), 0.05, var_2);
  }

  if(level.nextbosswavezombietype == "zombie_dog") {
    level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("dog", 0);
  } else if(level.nextbosswavezombietype == "zombie_host") {
    level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("host", 0);
  } else if(issubstr(level.nextbosswavezombietype, "combo")) {
    level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("mut", 0);
  } else {
    level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("zomb", 0);
  }
}

zombietrap_applymutator(var_0) {
  var_0 thread maps\mp\zombies\_mutators::mutator_apply("exo");
  var_0 thread maps\mp\zombies\_mutators::mutator_apply(level.nextbosswavezombietype);
}

zombietrap_getnumzombiestospawn() {
  var_0 = maps\mp\zombies\zombie_boss_oz_stage1::getstage1phase();
  var_1 = 1;

  if(var_0 == 2) {
    var_1 = 2;
  } else if(var_0 == 3) {
    var_1 = 3;
  }

  return int(var_1 * maps\mp\zombies\_util::getnumplayers());
}