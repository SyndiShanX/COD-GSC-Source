/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_6b221588ece2c4aa.gsc
***********************************************/

#include scripts\core_common\player\player_stats;
#include scripts\core_common\util_shared;
#include scripts\weapons\weaponobjects;

#namespace weaponobjects;

function_b455d5d8() {
  function_e6400478(#"hatchet", &createhatchetwatcher, 1);
  function_e6400478(#"tactical_insertion", &createtactinsertwatcher, 1);
  function_e6400478(#"rcbomb", &creatercbombwatcher, 1);
  function_e6400478(#"qrdrone", &createqrdronewatcher, 1);
  function_e6400478(#"helicopter_player", &createplayerhelicopterwatcher, 1);
  function_e6400478(#"tr_flechette_t8", &function_1eaa3e20);
  function_e6400478(#"hash_17ac9a2101b6ff2d", &function_1eaa3e20);

  if(isDefined(level.var_b68902c4) && level.var_b68902c4) {
    function_e6400478(#"tr_flechette_t8_upgraded", &function_1eaa3e20);
  }
}

createspecialcrossbowwatchertypes(watcher) {
  watcher.ondetonatecallback = &deleteent;
  watcher.ondamage = &voidondamage;

  if(isDefined(level.b_crossbow_bolt_destroy_on_impact) && level.b_crossbow_bolt_destroy_on_impact) {
    watcher.onspawn = &onspawncrossbowboltimpact;
    watcher.onspawnretrievetriggers = &voidonspawnretrievetriggers;
    watcher.pickup = &voidpickup;
    return;
  }

  watcher.onspawn = &onspawncrossbowbolt;
  watcher.onspawnretrievetriggers = &function_23b0aea9;
  watcher.pickup = &function_d9219ce2;
}

function_f297d773() {
  function_e6400478(#"special_crossbow_t8", &createspecialcrossbowwatchertypes, 1);
  function_e6400478(#"special_crossbowlh", &createspecialcrossbowwatchertypes, 1);
  function_e6400478(#"special_crossbow_dw", &createspecialcrossbowwatchertypes, 1);

  if(isDefined(level.b_create_upgraded_crossbow_watchers) && level.b_create_upgraded_crossbow_watchers) {
    function_e6400478(#"special_crossbow_t8_upgraded", &createspecialcrossbowwatchertypes, 1);
  }
}

function_1eaa3e20(watcher) {
  watcher.notequipment = 1;
  watcher.onfizzleout = undefined;
}

createhatchetwatcher(watcher) {
  watcher.ondetonatecallback = &deleteent;
  watcher.onspawn = &onspawnhatchet;
  watcher.ondamage = &voidondamage;
  watcher.onspawnretrievetriggers = &function_23b0aea9;

  if(!sessionmodeiswarzonegame()) {
    watcher.timeout = 120;
  }

  watcher.pickup = &function_d9219ce2;
}

createtactinsertwatcher(watcher) {
  watcher.playdestroyeddialog = 0;
}

creatercbombwatcher(watcher) {
  watcher.altdetonate = 0;
  watcher.ismovable = 1;
  watcher.ownergetsassist = 1;
  watcher.playdestroyeddialog = 0;
  watcher.deleteonkillbrush = 0;
  watcher.ondetonatecallback = level.rcbombonblowup;
  watcher.stuntime = 1;
  watcher.notequipment = 1;
}

createqrdronewatcher(watcher) {
  watcher.altdetonate = 0;
  watcher.ismovable = 1;
  watcher.ownergetsassist = 1;
  watcher.playdestroyeddialog = 0;
  watcher.deleteonkillbrush = 0;
  watcher.ondetonatecallback = level.qrdroneonblowup;
  watcher.ondamage = level.qrdroneondamage;
  watcher.stuntime = 5;
  watcher.notequipment = 1;
}

getspikelauncheractivespikecount(watcher) {
  currentitemcount = 0;

  foreach(obj in watcher.objectarray) {
    if(isDefined(obj) && obj.item !== watcher.weapon) {
      currentitemcount++;
    }
  }

  return currentitemcount;
}

watchspikelauncheritemcountchanged(watcher) {
  self endon(#"death");
  lastitemcount = undefined;

  while(true) {
    waitresult = self waittill(#"weapon_change");

    for(weapon = waitresult.weapon; weapon.name == #"spike_launcher"; weapon = self getcurrentweapon()) {
      currentitemcount = getspikelauncheractivespikecount(watcher);

      if(currentitemcount !== lastitemcount) {
        self setcontrolleruimodelvalue("spikeLauncherCounter.spikesReady", currentitemcount);
        lastitemcount = currentitemcount;
      }

      wait 0.1;
    }
  }
}

spikesdetonating(watcher) {
  spikecount = getspikelauncheractivespikecount(watcher);

  if(spikecount > 0) {
    self setcontrolleruimodelvalue("spikeLauncherCounter.blasting", 1);
    wait 2;
    self setcontrolleruimodelvalue("spikeLauncherCounter.blasting", 0);
  }
}

createspikelauncherwatcher(watcher) {
  watcher.altname = #"spike_charge";
  watcher.altweapon = getweapon(#"spike_charge");
  watcher.altdetonate = 0;
  watcher.watchforfire = 1;
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ondetonatecallback = &spikedetonate;
  watcher.onstun = &weaponstun;
  watcher.stuntime = 1;
  watcher.ownergetsassist = 1;
  watcher.detonatestationary = 0;
  watcher.detonationdelay = 0;
  watcher.detonationsound = #"wpn_claymore_alert";
  watcher.ondetonationhandle = &spikesdetonating;
}

createplayerhelicopterwatcher(watcher) {
  watcher.altdetonate = 1;
  watcher.notequipment = 1;
}

function_50d4198b(watcher) {
  watcher.hackable = 0;
  watcher.headicon = 0;
  watcher.deleteonplayerspawn = 0;
  watcher.enemydestroy = 0;
  watcher.onspawn = &function_f0e307a2;
}

function_f0e307a2(watcher, player) {
  level endon(#"game_ended");
  self endon(#"death");

  if(isDefined(player)) {
    player stats::function_e24eec31(self.weapon, #"used", 1);
  }

  self playLoopSound(#"uin_c4_air_alarm_loop");
  self waittilltimeout(10, #"stationary");
  function_b70eb3a9(watcher, player);
}

function_b70eb3a9(watcher, player) {
  pos = self.origin + (0, 0, 15);
  self.ammo_trigger = spawn("trigger_radius", pos, 0, 50, 50);
  self.ammo_trigger setteamfortrigger(player.team);
  self.ammo_trigger.owner = player;
  self thread function_5742754c();
  self thread function_42eeab72(self);
}

function_5742754c() {
  station = self;
  station endon(#"death");

  if(!isDefined(station.ammo_resupplies_given)) {
    station.ammo_resupplies_given = 0;
  }

  assert(isDefined(station.ammo_trigger));
  trigger = station.ammo_trigger;

  while(isDefined(trigger)) {
    waitresult = trigger waittill(#"touch");
    player = waitresult.entity;

    if(!isplayer(player)) {
      continue;
    }

    if(!isalive(player)) {
      continue;
    }

    if(isDefined(trigger.team) && util::function_fbce7263(player.team, trigger.team)) {
      continue;
    }

    station function_e98cee52(player, station);
  }
}

function_e98cee52(player, station) {
  primary_weapons = player getweaponslistprimaries();
  gaveammo = 0;

  foreach(weapon in primary_weapons) {
    gaveammo |= player function_61bdb626(weapon);
  }

  if(!gaveammo) {
    return;
  }

  if(!isDefined(station.last_ammo_resupply_time)) {
    station.last_ammo_resupply_time = [];
  }

  station.last_ammo_resupply_time[player getentitynumber()] = gettime();
  station.ammo_resupplies_given++;

  if(station.ammo_resupplies_given >= 1) {
    station function_f47cd4cb();
    station delete();
  }
}

function_61bdb626(weapon) {
  player = self;
  new_ammo = weapon.clipsize;
  stockammo = player getweaponammostock(weapon);
  player setweaponammostock(weapon, int(stockammo + new_ammo));
  newammo = player getweaponammostock(weapon);
  return newammo > stockammo;
}

function_42eeab72(station) {
  self waittill(#"death");
  self function_f47cd4cb();
}

function_f47cd4cb() {
  if(isDefined(self.ammo_trigger)) {
    self.ammo_trigger delete();
  }
}

delayedspikedetonation(attacker, weapon) {
  if(!isDefined(self.owner.spikedelay)) {
    self.owner.spikedelay = 0;
  }

  delaytime = self.owner.spikedelay;
  owner = self.owner;
  self.owner.spikedelay += 0.3;
  waittillframeend();
  wait delaytime;
  owner.spikedelay -= 0.3;

  if(isDefined(self)) {
    self weapondetonate(attacker, weapon);
  }
}

spikedetonate(attacker, weapon, target) {
  if(isDefined(weapon) && weapon.isvalid) {
    if(isDefined(attacker)) {
      if(self.owner util::isenemyplayer(attacker)) {}
    }
  }

  thread delayedspikedetonation(attacker, weapon);
}

onspawnhatchet(watcher, player) {
  if(isDefined(level.playthrowhatchet)) {
    player[[level.playthrowhatchet]]();
  }
}

onspawncrossbowbolt(watcher, player) {
  self.delete_on_death = 1;
  self thread onspawncrossbowbolt_internal(watcher, player);
}

onspawncrossbowbolt_internal(watcher, player) {
  player endon(#"disconnect");
  self endon(#"death");
  wait 0.25;
  linkedent = self getlinkedent();

  if(!isDefined(linkedent) || !isvehicle(linkedent)) {
    self.takedamage = 0;
    return;
  }

  self.takedamage = 1;

  if(isvehicle(linkedent)) {
    self thread dieonentitydeath(linkedent, player);
  }
}

onspawncrossbowboltimpact(s_watcher, e_player) {
  self.delete_on_death = 1;
  self thread onspawncrossbowboltimpact_internal(s_watcher, e_player);
}

onspawncrossbowboltimpact_internal(s_watcher, e_player) {
  self endon(#"death");
  e_player endon(#"disconnect");
  self waittill(#"stationary");
  s_watcher thread waitandfizzleout(self, 0);

  foreach(n_index, e_object in s_watcher.objectarray) {
    if(self == e_object) {
      s_watcher.objectarray[n_index] = undefined;
    }
  }

  cleanweaponobjectarray(s_watcher);
}

dieonentitydeath(entity, player) {
  player endon(#"disconnect");
  self endon(#"death");
  alreadydead = entity.dead === 1 || isDefined(entity.health) && entity.health < 0;

  if(!alreadydead) {
    entity waittill(#"death");
  }

  self notify(#"death");
}