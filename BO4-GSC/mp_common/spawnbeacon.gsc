/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\spawnbeacon.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\match_record;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\spawnbeacon_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\draft;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\userspawnselection;
#include scripts\weapons\deployable;
#include scripts\weapons\weaponobjects;

#namespace spawn_beacon;

autoexec __init__system__() {
  system::register(#"spawn_beacon", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
  level.var_9fa5aeb4 = &function_b42580a6;
  level.var_34c482f2 = &function_fa81d248;
  level.var_4b1d905b = &function_4ddddf03;
  level.var_ae2fe442 = &function_b74804ba;
  level.var_a1ca927c = &function_1f5ed165;
  globallogic_score::register_kill_callback(level.spawnbeaconsettings.beaconweapon, &function_ece8f018);
  globallogic_score::function_86f90713(level.spawnbeaconsettings.beaconweapon, &function_ece8f018);
  globallogic_score::function_82fb1afa(level.spawnbeaconsettings.beaconweapon, &function_5bfd1343);
  globallogic_score::function_2b2c09db(level.spawnbeaconsettings.beaconweapon, &function_3e8ff788);
  globallogic_score::function_b150f9ac(level.spawnbeaconsettings.beaconweapon, &function_cdeb9089);
  deployable::register_deployable(getweapon(#"hash_7ab3f9a730359659"), &function_9aafb7bb, undefined);
  weaponobjects::function_e6400478(#"hash_7ab3f9a730359659", &function_d80ff6a7, 1);
  function_50e42513();
  setupspawnlists();
}

function_ece8f018(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(!isDefined(attacker) || !isDefined(attacker.var_7c18e526) || !isDefined(attacker.var_1a6703cc) || attacker.var_1a6703cc + 5000 < gettime()) {
    return false;
  }

  if(attacker == attacker.var_7c18e526) {
    return true;
  }

  return false;
}

function_3e8ff788(attacker, victim, var_f5db414c, killtime, weapon, spawnbeaconweapon) {
  if(!isDefined(attacker) || !isDefined(spawnbeaconweapon) || !isDefined(killtime) || !isDefined(attacker.var_7c18e526)) {
    return;
  }

  if(attacker != attacker.var_7c18e526 && (isDefined(attacker.var_1a6703cc) ? attacker.var_1a6703cc : 0) + 5000 > killtime) {
    scoreevents::processscoreevent(#"hash_62131f4647f7c61a", attacker.var_7c18e526, undefined, spawnbeaconweapon);
  }
}

function_cdeb9089(attacker, victim, spawnbeaconweapon, var_fb972b2b) {
  if(!isDefined(attacker) || !isDefined(spawnbeaconweapon) || !isDefined(attacker.var_7c18e526)) {
    return;
  }

  if(attacker != attacker.var_7c18e526 && (isDefined(attacker.var_1a6703cc) ? attacker.var_1a6703cc : 0) + 5000 > gettime()) {
    scoreevents::processscoreevent(#"hash_17705bbdbf8cf23a", attacker.var_7c18e526, undefined, spawnbeaconweapon);
  }
}

function_5bfd1343(attacker, var_f231d134, killtime, capturedobjective, spawnbeaconweapon) {
  if(!isDefined(attacker) || !isDefined(spawnbeaconweapon) || !isDefined(killtime) || !isDefined(attacker.var_7c18e526)) {
    return;
  }

  if(attacker != attacker.var_7c18e526 && (isDefined(attacker.var_1a6703cc) ? attacker.var_1a6703cc : 0) + 5000 > killtime) {
    scoreevents::processscoreevent(#"hash_5ce122c3419f6a58", attacker.var_7c18e526, undefined, spawnbeaconweapon);
  }
}

function_1f5ed165() {
  if((isDefined(level.spawnbeaconsettings.settingsbundle.var_b4403828) ? level.spawnbeaconsettings.settingsbundle.var_b4403828 : 0) && isDefined(self.var_d7cf6658) && isarray(self.var_d7cf6658) && isDefined(self.var_d7cf6658[#"friendly"].trigger)) {
    self.var_d7cf6658[#"friendly"].trigger triggerenable(0);
  }
}

addprotectedzone(zone) {
  array::add(level.spawnbeaconsettings.objectivezones, zone);
}

removeprotectedzone(zone) {
  arrayremovevalue(level.spawnbeaconsettings.objectivezones, zone);
}

private setupspawnlists() {
  for(spawnlistidx = 0; spawnlistidx < (isDefined(level.spawnbeaconsettings.settingsbundle.spawnlistcount) ? level.spawnbeaconsettings.settingsbundle.spawnlistcount : 0); spawnlistidx++) {
    array::add(level.spawnbeaconsettings.availablespawnlists, (isDefined(level.spawnbeaconsettings.settingsbundle.var_7609eee) ? level.spawnbeaconsettings.settingsbundle.var_7609eee : "") + spawnlistidx);
  }
}

private function_50e42513() {
  level.spawnbeaconsettings.var_613ff100 = [];
  var_bd01a896 = spawnStruct();
  var_862cf298 = isDefined(level.spawnbeaconsettings.settingsbundle.var_6a0e1c10) ? level.spawnbeaconsettings.settingsbundle.var_6a0e1c10 : 0;
  var_bd01a896.zonemax = var_862cf298 * var_862cf298;
  var_bd01a896.points = isDefined(level.spawnbeaconsettings.settingsbundle.var_65a598a7) ? level.spawnbeaconsettings.settingsbundle.var_65a598a7 : 0;
  var_bd01a896.zonemin = 0;
  array::add(level.spawnbeaconsettings.var_613ff100, var_bd01a896);
  var_5c0ba1f = spawnStruct();
  var_862cf298 = isDefined(level.spawnbeaconsettings.settingsbundle.var_95f0a921) ? level.spawnbeaconsettings.settingsbundle.var_95f0a921 : 0;
  var_5c0ba1f.zonemax = var_862cf298 * var_862cf298;
  var_5c0ba1f.points = isDefined(level.spawnbeaconsettings.settingsbundle.var_dcbe0fcc) ? level.spawnbeaconsettings.settingsbundle.var_dcbe0fcc : 0;
  var_5c0ba1f.zonemin = var_bd01a896.zonemax;
  array::add(level.spawnbeaconsettings.var_613ff100, var_5c0ba1f);
}

function_b42580a6() {
  player = self;
  spawnbeacon = player userspawnselection::getspawnbeaconplayerspawnedfrom();

  if(isDefined(spawnbeacon)) {
    player thread playerspawnedfromspawnbeacon(spawnbeacon, isDefined(player.var_4ef33446) && player.var_4ef33446 || isDefined(self.suicide) && self.suicide);
  }

  return false;
}

playerspawnedfromspawnbeacon(spawnbeacon, var_d8f817bc) {
  if(!isDefined(spawnbeacon)) {
    return;
  }

  player = self;
  spawnbeacon.spawncount++;

  if(level.gametype === "dm" || level.gametype === "dm_hc") {
    spawnbeacon.health -= isDefined(level.spawnbeaconsettings.settingsbundle.var_ebe18d92) ? level.spawnbeaconsettings.settingsbundle.var_ebe18d92 : 0;
  } else {
    spawnbeacon.health -= isDefined(level.spawnbeaconsettings.settingsbundle.healthdeductionperspawn) ? level.spawnbeaconsettings.settingsbundle.healthdeductionperspawn : 0;
  }

  if(isDefined(spawnbeacon.owner) && player != spawnbeacon.owner) {
    spawnbeacon.owner luinotifyevent(#"spawn_beacon_used");
  }

  if(isDefined(spawnbeacon.owner) && isDefined(self) && !var_d8f817bc) {
    if(spawnbeacon.owner == player) {
      player thread scoreevents::function_c046c773(0.5, "spawn_beacon_insertion", spawnbeacon.owner, player, level.spawnbeaconsettings.beaconweapon);
    } else {
      scoreevents::processscoreevent(#"spawn_beacon_insertion", spawnbeacon.owner, player, level.spawnbeaconsettings.beaconweapon);
    }

    player.var_1a6703cc = gettime();
    player.var_7c18e526 = spawnbeacon.owner;
    var_f8e6b703 = player match_record::get_player_stat(#"hash_ec4aea1a8bbd82");

    if(isDefined(var_f8e6b703)) {
      player match_record::set_stat(#"lives", var_f8e6b703, #"hash_674598aa9fe3d19a", 1);
    }
  }

  if(isDefined(level.spawnbeaconsettings.settingsbundle.var_7d58193e) && isDefined(spawnbeacon)) {
    var_7f9f4251 = isDefined(level.spawnbeaconsettings.settingsbundle.var_231a393d) ? level.spawnbeaconsettings.settingsbundle.var_231a393d : 0 ? undefined : player;

    if(!isDefined(var_7f9f4251)) {
      var_7f9f4251 = undefined;
    }

    spawnbeacon playsoundtoteam(level.spawnbeaconsettings.settingsbundle.var_7d58193e, player getteam(), var_7f9f4251);
  }

  if(isDefined(level.spawnbeaconsettings.settingsbundle.var_ccf4ec0b)) {
    spawnbeacon playsoundtoteam(level.spawnbeaconsettings.settingsbundle.var_ccf4ec0b, util::getotherteam(player getteam()));
  }

  if(spawnbeacon.threatlevel >= (isDefined(level.spawnbeaconsettings.settingsbundle.var_ba2632d3) ? level.spawnbeaconsettings.settingsbundle.var_ba2632d3 : 0)) {
    player globallogic_audio::play_taacom_dialog("spawnBeaconSpawnDanger");
  } else {
    player globallogic_audio::play_taacom_dialog("spawnBeaconSpawn");
  }

  if(spawnbeacon.health <= 0) {
    spawnbeacon destroyspawnbeacon(0);
  }

  if((isDefined(level.spawnbeaconsettings.var_3c919ca8) ? level.spawnbeaconsettings.var_3c919ca8 : 0) && isDefined(spawnbeacon)) {
    spawnbeacon.var_4fc7245b = 1;
    spawnbeacon thread destroyspawnbeacon(0);
  }
}

function_fa81d248(attacker, weapon) {
  spawnbeacon = self;

  if(isDefined(spawnbeacon.var_a08c7e4)) {
    self influencers::remove_influencer(spawnbeacon.var_a08c7e4);
    self.spawn_influencer_enemy_carrier = undefined;
  }

  if(isDefined(spawnbeacon.var_16b8f97a)) {
    foreach(influencer in spawnbeacon.var_16b8f97a) {
      self influencers::remove_influencer(influencer);
    }
  }

  if(isDefined(level.figure_out_attacker)) {
    attacker = self[[level.figure_out_attacker]](attacker);
  }

  if(isDefined(attacker) && isplayer(attacker) && spawnbeacon.owner !== attacker && isDefined(weapon)) {
    attacker stats::function_e24eec31(weapon, #"hash_1c9da51ed1906285", 1);
  }

  userspawnselection::removespawnbeacon(self.objectiveid);
}

function_b74804ba(origin, angles, player, var_c7a191d5, var_813ea9e) {
  player.var_9bab32d9.spawns = getspawnbeaconspawns(origin);

  if(player.var_9bab32d9.spawns.size == 0) {
    player sethintstring(level.spawnbeaconsettings.settingsbundle.var_bf6a0873);
    return false;
  }

  foreach(protectedzone in level.spawnbeaconsettings.objectivezones) {
    if(protectedzone istouching(origin, (16, 16, 70))) {
      return false;
    }
  }

  var_a25671b9 = isDefined(level.spawnbeaconsettings.settingsbundle.var_77498194) ? level.spawnbeaconsettings.settingsbundle.var_77498194 : 0;
  testdistance = var_a25671b9 * var_a25671b9;
  var_775fe08e = getarraykeys(level.spawnbeaconsettings.userspawnbeacons);

  foreach(var_2e194e82 in var_775fe08e) {
    if(var_2e194e82 == player.clientid) {
      continue;
    }

    var_4d511d74 = level.spawnbeaconsettings.userspawnbeacons[var_2e194e82];

    for(i = 0; i < var_4d511d74.size; i++) {
      if(!isDefined(var_4d511d74[i])) {
        level.spawnbeaconsettings.userspawnbeacons[var_2e194e82] = array::remove_index(var_4d511d74, i, 0);
        continue;
      }

      distsqr = distancesquared(origin, var_4d511d74[i].origin);

      if(distsqr <= testdistance) {
        player sethintstring(level.spawnbeaconsettings.settingsbundle.cannotbuild);
        return false;
      }
    }
  }

  return true;
}

private function_4ddddf03(placedspawnbeacon) {
  player = self;
  placedspawnbeacon util::make_sentient();
  userspawnselection::registeravailablespawnbeacon(placedspawnbeacon.objectiveid, placedspawnbeacon);

  if(isDefined(level.spawnbeaconsettings.settingsbundle.var_6ee7f72) ? level.spawnbeaconsettings.settingsbundle.var_6ee7f72 : 0) {
    function_6c529d0b(placedspawnbeacon, level.spawnbeaconsettings.settingsbundle.var_ac0a9508, player getteam(), #"enemy", #"hash_10169ccdcca54ccf", &function_741d9675, &function_70ca26fc, &function_d77d0cbb);
    placedspawnbeacon.var_d7cf6658[#"enemy"] gameobjects::set_use_time(isDefined(level.spawnbeaconsettings.settingsbundle.deactivatetime) ? level.spawnbeaconsettings.settingsbundle.deactivatetime : 0);
  }

  if(isDefined(level.spawnbeaconsettings.settingsbundle.var_b4403828) ? level.spawnbeaconsettings.settingsbundle.var_b4403828 : 0) {
    function_6c529d0b(placedspawnbeacon, level.spawnbeaconsettings.settingsbundle.var_69fd6325, player getteam(), #"friendly", #"hash_f91a28adadc5409", &function_e67b6bd, &function_4f5f518a, &function_d77d0cbb);
    player clientclaimtrigger(placedspawnbeacon.var_d7cf6658[#"friendly"].trigger);
    placedspawnbeacon.var_d7cf6658[#"friendly"] gameobjects::set_use_time(isDefined(level.spawnbeaconsettings.settingsbundle.pickuptime) ? level.spawnbeaconsettings.settingsbundle.pickuptime : 0);
  }

  placedspawnbeacon.var_a08c7e4 = placedspawnbeacon influencers::create_influencer("activeSpawnBeacon", placedspawnbeacon.origin, util::getteammask(player getteam()));

  if(isDefined(placedspawnbeacon.var_a08c7e4) && placedspawnbeacon.var_a08c7e4 != -1 && isDefined(placedspawnbeacon.spawnlist)) {
    function_8b51d4df(placedspawnbeacon.var_a08c7e4, placedspawnbeacon.spawnlist);
    placedspawnbeacon.var_4dd7c5c5 = placedspawnbeacon.spawns;
  }
}

private function_94dcc72e(&spawnlist, spawnbeacon) {
  var_df1363e1 = [];

  for(index = 0; index < spawnlist.size; index++) {
    if(!sighttracepassed(spawnlist[index].origin + (0, 0, 72), spawnbeacon.origin + (0, 0, 70), 0, spawnbeacon)) {
      array::add(var_df1363e1, index);
    }
  }

  for(index = var_df1363e1.size - 1; index >= 0; index--) {
    spawnlist = array::remove_index(spawnlist, var_df1363e1[index]);
  }

  return spawnlist;
}

function_6c529d0b(beacon, objective, team, var_d1653c48, hinttext, onusefunc, var_24c69a69, var_6a89b347) {
  upangle = vectorscale(vectornormalize(anglestoup(beacon.angles)), 5);
  var_40989bda = beacon.origin + upangle;
  usetrigger = spawn("trigger_radius_use", var_40989bda, 0, isDefined(level.spawnbeaconsettings.settingsbundle.var_ec05f9d4) ? level.spawnbeaconsettings.settingsbundle.var_ec05f9d4 : 0, isDefined(level.spawnbeaconsettings.settingsbundle.var_53e44ebc) ? level.spawnbeaconsettings.settingsbundle.var_53e44ebc : 0);
  usetrigger triggerignoreteam();
  usetrigger setvisibletoall();
  usetrigger setteamfortrigger(#"none");
  usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");

  if(!isDefined(beacon.var_d7cf6658)) {
    beacon.var_d7cf6658 = [];
  }

  beacon.var_d7cf6658[var_d1653c48] = gameobjects::create_use_object(team, usetrigger, [], undefined, objective, 1);
  beacon.var_d7cf6658[var_d1653c48] gameobjects::set_use_hint_text(hinttext);
  beacon.var_d7cf6658[var_d1653c48] gameobjects::set_visible_team(var_d1653c48);
  beacon.var_d7cf6658[var_d1653c48] gameobjects::allow_use(var_d1653c48);
  beacon.var_d7cf6658[var_d1653c48].onuse = onusefunc;
  beacon.var_d7cf6658[var_d1653c48].onbeginuse = var_24c69a69;
  beacon.var_d7cf6658[var_d1653c48].onenduse = var_6a89b347;
  beacon.var_d7cf6658[var_d1653c48].parentobj = beacon;
}

private function_e67b6bd(player) {
  spawnbeacon = self.parentobj;
  spawnbeacon.alivetime = (isDefined(spawnbeacon.alivetime) ? spawnbeacon.alivetime : 0) + float(gettime() - (isDefined(spawnbeacon.var_1df612a0) ? spawnbeacon.var_1df612a0 : spawnbeacon.birthtime)) / 1000;
  remainingtime = (isDefined(level.spawnbeaconsettings.settingsbundle.timeout) ? level.spawnbeaconsettings.settingsbundle.timeout : 0) - spawnbeacon.alivetime;

  if(remainingtime <= (isDefined(level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4) ? level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4 : 0)) {
    return;
  }

  freespawnbeaconspawnlist(spawnbeacon.spawnlist);
  spawnbeacon notify(#"end_timer");
  spawnbeacon.remainingtime = remainingtime;
  spawnbeacon clientfield::set("enemyequip", 0);
  spawnbeacon.isdisabled = 1;
  spawnbeacon setinvisibletoall();
  spawnbeacon.origin = (6000, 6000, 6000);

  if(isDefined(spawnbeacon.var_d7cf6658)) {
    foreach(gameobject in spawnbeacon.var_d7cf6658) {
      gameobject.trigger triggerenable(0);
      gameobject.trigger.origin = spawnbeacon.origin;
    }
  }

  level.spawnbeaconsettings.beacons[spawnbeacon.objectiveid] = undefined;
  userspawnselection::removespawnbeacon(spawnbeacon.objectiveid);
  objective_delete(spawnbeacon.objectiveid);
  heldweapon = getweapon(#"hash_7ab3f9a730359659");
  spawnbeacon.owner giveweapon(heldweapon);
  spawnbeacon.owner switchtoweapon(heldweapon, 1);
  spawnbeacon.owner disableweaponcycling();
  spawnbeacon.owner disableoffhandweapons();
  spawnbeacon.owner setblockweaponpickup(heldweapon, 1);
  spawnbeacon.owner disableoffhandspecial();

  if(isDefined(level.spawnbeaconsettings.settingsbundle.pickupaudio)) {
    player playSound(level.spawnbeaconsettings.settingsbundle.pickupaudio);
  }

  spawnbeacon.owner.var_c4a4cb7d = self;
  spawnbeacon.var_ca3a0f16 = 1;
}

function_f989dc0a(watcher, owner) {
  if(!isDefined(owner) || !isDefined(owner.var_c4a4cb7d)) {
    return;
  }

  spawnbeacon = owner.var_c4a4cb7d.parentobj;
  spawnbeacon endon(#"death");
  spawnbeacon thread weaponobjects::onspawnuseweaponobject(watcher, owner);
  spawnbeacon.var_ca3a0f16 = 0;

  if(!(isDefined(owner.var_c4a4cb7d.previouslyhacked) && owner.var_c4a4cb7d.previouslyhacked)) {
    if(isDefined(owner)) {
      owner stats::function_e24eec31(spawnbeacon.weapon, #"used", 1);
    }

    spawnbeacon.var_1df612a0 = gettime();
    waitresult = spawnbeacon waittilltimeout(0.05, #"stationary");
    spawnbeacon deployable::function_dd266e08(owner);
    spawnbeacon.isdisabled = 0;
    spawnbeacon notify(#"beacon_enabled");
    userspawnselection::registeravailablespawnbeacon(spawnbeacon.objectiveid, spawnbeacon);
    spawnbeacon.var_9bab32d9 = owner.var_9bab32d9;
    owner.var_9bab32d9 = undefined;

    if(isDefined(spawnbeacon.var_9bab32d9) && isDefined(spawnbeacon.var_9bab32d9.spawns)) {
      createspawngroupforspawnbeacon(spawnbeacon, spawnbeacon.var_9bab32d9.spawns);
    }

    owner takeweapon(getweapon(#"hash_7ab3f9a730359659"));
    owner enableweaponcycling();
    owner enableoffhandweapons();
    owner enableoffhandspecial();
    spawnbeacon setvisibletoall();

    if(isDefined(spawnbeacon.othermodel)) {
      spawnbeacon.othermodel setinvisibletoall();
    }

    objective_add(spawnbeacon.objectiveid, "active", spawnbeacon.origin, level.spawnbeaconsettings.settingsbundle.mainobjective);
    objective_setteam(spawnbeacon.objectiveid, spawnbeacon.team);
    function_3ae6fa3(spawnbeacon.objectiveid, owner getteam(), 1);
    objective_setprogress(spawnbeacon.objectiveid, 1);
    level.spawnbeaconsettings.beacons[spawnbeacon.objectiveid] = spawnbeacon;

    if(spawnbeacon.var_a08c7e4 != -1 && isDefined(spawnbeacon.var_a08c7e4) && isDefined(spawnbeacon.spawnlist)) {
      function_8b51d4df(spawnbeacon.var_a08c7e4, spawnbeacon.spawnlist);
    }

    owner clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 1);
    spawnbeacon clientfield::set("enemyequip", 1);
    owner.var_9698a18d = 1;
    owner.var_583f6cce = spawnbeacon;
    spawnbeacon setanim(#"o_spawn_beacon_deploy", 1);
    upangle = vectorscale(vectornormalize(anglestoup(spawnbeacon.angles)), 5);

    if(isDefined(spawnbeacon.var_d7cf6658)) {
      foreach(gameobject in spawnbeacon.var_d7cf6658) {
        gameobject.trigger triggerenable(1);
        gameobject.trigger.origin = spawnbeacon.origin + upangle;
      }
    }

    spawnbeacon function_f8930fa1(spawnbeacon.remainingtime);
  }
}

function_d80ff6a7(watcher) {
  watcher.watchforfire = 1;
  watcher.onspawn = &function_f989dc0a;
  watcher.ontimeout = &function_13ac856e;
  watcher.deleteonplayerspawn = 0;
}

private function_ebac785e(player) {
  if(isDefined(level.spawnbeaconsettings.settingsbundle.var_82360099)) {
    player playLoopSound(level.spawnbeaconsettings.settingsbundle.var_82360099);
  }
}

private function_4f5f518a(player) {
  function_ebac785e(player);
}

private function_70ca26fc(player) {
  function_ebac785e(player);
  playerteam = player getteam();
  playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_2c88033f, util::getotherteam(playerteam), undefined);
  objective_setgamemodeflags(self.parentobj.objectiveid, 4);
  self.parentobj.isdisabled = 1;
}

private function_741d9675(player) {
  spawnbeacon = self.parentobj;
  spawnbeacon.var_b08a3652 = 1;
  spawnbeacon.var_846acfcf = player;
  spawnbeacon thread destroyspawnbeacon(1);

  if(isDefined(level.spawnbeaconsettings.settingsbundle.pickupaudio)) {
    player playSound(level.spawnbeaconsettings.settingsbundle.pickupaudio);
  }
}

private function_d77d0cbb(team, player, result) {
  if(isDefined(level.spawnbeaconsettings.settingsbundle.var_82360099)) {
    player stoploopsound();
  }

  if(self.team == player.team) {
    self.parentobj.owner clientclaimtrigger(self.trigger);
  }

  self.parentobj.isdisabled = 0;
  objective_setgamemodeflags(self.parentobj.objectiveid, 0);
  self.parentobj notify(#"beacon_enabled");
}

function_9aafb7bb(origin, angles, player) {
  if(!isDefined(player.var_9bab32d9)) {
    player.var_9bab32d9 = spawnStruct();
  }

  player.var_9bab32d9.spawns = getspawnbeaconspawns(origin);

  if(player.var_9bab32d9.spawns.size == 0) {
    player sethintstring(level.spawnbeaconsettings.settingsbundle.var_bf6a0873);
    return false;
  }

  foreach(protectedzone in level.spawnbeaconsettings.objectivezones) {
    if(protectedzone istouching(origin, (16, 16, 70))) {
      return false;
    }
  }

  var_a25671b9 = isDefined(level.spawnbeaconsettings.settingsbundle.var_77498194) ? level.spawnbeaconsettings.settingsbundle.var_77498194 : 0;
  testdistance = var_a25671b9 * var_a25671b9;
  var_775fe08e = getarraykeys(level.spawnbeaconsettings.userspawnbeacons);

  foreach(var_2e194e82 in var_775fe08e) {
    if(var_2e194e82 == player.clientid) {
      continue;
    }

    var_4d511d74 = level.spawnbeaconsettings.userspawnbeacons[var_2e194e82];

    foreach(beacon in var_4d511d74) {
      if(!isDefined(beacon)) {
        continue;
      }

      distsqr = distancesquared(origin, beacon.origin);

      if(distsqr <= testdistance) {
        player sethintstring(level.spawnbeaconsettings.settingsbundle.cannotbuild);
        return false;
      }
    }
  }

  return true;
}