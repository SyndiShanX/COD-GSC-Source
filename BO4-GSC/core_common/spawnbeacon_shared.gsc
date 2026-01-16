/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\spawnbeacon_shared.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\weapons\deployable;
#include scripts\weapons\weaponobjects;

#namespace spawn_beacon;

init_shared() {
  level.var_9fa5aeb4 = undefined;
  level.var_34c482f2 = undefined;
  level.var_4b1d905b = undefined;
  level.var_ae2fe442 = undefined;

  if(!isDefined(game.spawnbeaconid)) {
    game.spawnbeaconid = 0;
  }

  if(!isDefined(level.spawnbeaconsettings)) {
    level.spawnbeaconsettings = spawnStruct();
  }

  level.spawnbeaconsettings.userspawnbeacons = [];
  level.spawnbeaconsettings.availablespawnlists = [];
  level.spawnbeaconsettings.objectivezones = [];
  level.spawnbeaconsettings.audiothrottletracker = [];

  if(getgametypesetting(#"competitivesettings") === 1) {
    level.spawnbeaconsettings.settingsbundle = getscriptbundle("spawnbeacon_custom_settings_comp");
  } else {
    level.spawnbeaconsettings.settingsbundle = getscriptbundle("default_spawnbeacon_settings");
  }

  level.spawnbeaconsettings.beaconweapon = getweapon(#"gadget_spawnbeacon");
  level.spawnbeaconsettings.var_613ff100 = [];
  level.spawnbeaconsettings.beacons = [];
  level.spawnbeaconsettings.maxpower = 100;
  level.spawnbeaconsettings.var_b851d15e = (0, 0, 5);
  level.spawnbeaconsettings.var_247a8b = 100;

  level.spawnbeaconsettings.var_e7571ff1 = [];

  setupcallbacks();
  setupclientfields();
  callback::on_finalize_initialization(&function_1c601b99);
  deployable::register_deployable(getweapon("gadget_spawnbeacon"), &function_9aafb7bb, undefined);
}

function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](level.spawnbeaconsettings.beaconweapon, &function_bff5c062);
  }
}

function_bff5c062(spawnbeacon, attackingplayer) {
  spawnbeacon.var_d02ddb8e = getweapon(#"gadget_icepick");
  spawnbeacon thread destroyspawnbeacon(1);
}

function_ee74520a() {
  if(!isDefined(level.spawnbeaconsettings)) {
    level.spawnbeaconsettings = spawnStruct();
  }

  level.spawnbeaconsettings.var_9d48e929 = 1;
}

disabletimeout() {
  if(!isDefined(level.spawnbeaconsettings)) {
    level.spawnbeaconsettings = spawnStruct();
  }

  level.spawnbeaconsettings.disabletimeout = 1;
}

function_5e54a568(var_b71a2a66) {
  if(!isDefined(level.spawnbeaconsettings)) {
    level.spawnbeaconsettings = spawnStruct();
  }

  level.spawnbeaconsettings.var_3c919ca8 = var_b71a2a66;
}

function_6b437265(team) {
  foreach(spawnbeacon in level.spawnbeaconsettings.beacons) {
    if(!isDefined(spawnbeacon)) {
      continue;
    }

    if(team == spawnbeacon.team) {
      return true;
    }
  }

  return false;
}

function_cfabb62c(watcher) {
  watcher.watchforfire = 1;
  watcher.onspawn = &beacon_spawned;
  watcher.ontimeout = &function_13ac856e;
  watcher.var_994b472b = &function_f9d3fff8;
  watcher.deleteonplayerspawn = 0;
}

function_f9d3fff8(player) {
  if(isDefined(self) && isDefined(self.spawnbeacon)) {
    self.spawnbeacon thread destroyspawnbeacon(0);
  }
}

function_13ac856e() {
  if(isDefined(self) && isDefined(self.spawnbeacon)) {
    self.spawnbeacon thread destroyspawnbeacon(0);
  }
}

function_f8930fa1(time) {
  self endon(#"death", #"end_timer");

  if(time == 0) {
    return;
  }

  if(isDefined(level.spawnbeaconsettings.disabletimeout) ? level.spawnbeaconsettings.disabletimeout : 0) {
    return;
  }

  if(isDefined(level.var_7a0aaea2)) {
    time = level.var_7a0aaea2;
  }

  if(time > (isDefined(level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4) ? level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4 : 0)) {
    wait time - (isDefined(level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4) ? level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4 : 0);
  }

  if(!isDefined(self)) {
    return;
  } else if(isDefined(level.var_a1ca927c)) {
    self[[level.var_a1ca927c]]();
  }

  remainingtime = isDefined(level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4) ? level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4 : time > (isDefined(level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4) ? level.spawnbeaconsettings.settingsbundle.var_a0ffd0e4 : 0) ? 0 : time;
  wait remainingtime;

  while(isDefined(level.spawnbeaconsettings.var_9d48e929) && level.spawnbeaconsettings.var_9d48e929 && isDefined(self) && isDefined(self.owner) && !isalive(self.owner)) {
    wait 0.5;
  }

  if(!isDefined(self)) {
    return;
  }

  self thread destroyspawnbeacon(0);
}

beacon_spawned(watcher, owner) {
  self endon(#"death");
  self.canthack = 1;
  self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
  self hide();

  if(isDefined(self.previouslyhacked) && self.previouslyhacked) {
    return;
  }

  if(isDefined(level.var_14151f16)) {
    [[level.var_14151f16]](self, 0);
  }

  waitframe(1);

  if(!isDefined(owner)) {
    self delete();
    return;
  }

  owner notify(#"hash_31be1f8b27209ad0", {
    #player: owner, 
    #beacon: self
  });
  level notify(#"hash_31be1f8b27209ad0", {
    #player: owner, 
    #beacon: self
  });

  if(!owner deployable::location_valid()) {
    owner deployable::function_416f03e6(level.spawnbeaconsettings.beaconweapon);
    self delete();
    return;
  }

  if(isDefined(owner)) {
    owner stats::function_e24eec31(self.weapon, #"used", 1);
  }

  self deployable::function_dd266e08(owner);
  self.var_9bab32d9 = owner.var_9bab32d9;
  owner.var_9bab32d9 = undefined;
  owner onplacespawnbeacon(self);
  owner clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 1);
  owner.var_9698a18d = 1;
  spawnbeacon = self.spawnbeacon;
  spawnbeacon setanim(#"o_spawn_beacon_deploy", 1);
}

playcommanderaudio(soundbank, team, excludeplayer) {
  if(!isDefined(soundbank)) {
    return;
  }

  if(!isDefined(level.spawnbeaconsettings.audiothrottletracker[soundbank])) {
    level.spawnbeaconsettings.audiothrottletracker[soundbank] = 0;
  }

  lasttimeplayed = level.spawnbeaconsettings.audiothrottletracker[soundbank];

  if(lasttimeplayed != 0 && gettime() < int(5 * 1000) + lasttimeplayed) {
    return;
  }

  var_925a9324 = [];
  var_925a9324[0] = excludeplayer;
  killstreaks::leader_dialog(soundbank, team, var_925a9324, "spawnbeacon");
  level.spawnbeaconsettings.audiothrottletracker[soundbank] = gettime();
}

setupclientfields() {
  clientfield::register("scriptmover", "spawnbeacon_placed", 1, 1, "int");
  clientfield::register("clientuimodel", "hudItems.spawnbeacon.active", 1, 1, "int");
}

function_45a43bd6() {
  player = self;

  if(isDefined(player.var_9698a18d) && player.var_9698a18d) {
    player clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 1);
  }
}

private setupcallbacks() {
  ability_player::register_gadget_activation_callbacks(26, &gadget_spawnbeacon_on, &gadget_spawnbeacon_off);
  callback::on_player_killed_with_params(&on_player_killed);
  callback::on_spawned(&on_player_spawned);
  callback::on_loadout(&on_loadout);
  weaponobjects::function_e6400478(#"gadget_spawnbeacon", &function_cfabb62c, 1);
}

private function_9ede386f(slot) {
  wait 0.1;

  if(!isDefined(self)) {
    return;
  }

  self function_19ed70ca(slot, 1);
  self gadgetpowerset(slot, 0);
}

function_8892377a() {
  if(!self hasweapon(level.spawnbeaconsettings.beaconweapon)) {
    self clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 0);
    self.var_9698a18d = 0;
    self.var_583f6cce = undefined;
    return;
  }

  if(!isDefined(self.pers[#"hash_677f229433c8735b"])) {
    self.pers[#"hash_677f229433c8735b"] = 0;
  }

  if(getdvarint(#"hash_da55c6d97d1dc52", 1) && (isDefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0) && self.pers[#"hash_677f229433c8735b"] >= 1) {
    spawnbeaconslot = self gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
    self thread function_9ede386f(spawnbeaconslot);
  }
}

on_loadout() {
  self function_8892377a();
}

on_player_spawned() {
  player = self;
  player function_45a43bd6();

  if(isDefined(level.var_9fa5aeb4)) {
    self[[level.var_9fa5aeb4]]();
  }
}

function_41a037e6() {
  spawnbeacon = self;
  spawnbeacon.threatlevel = 0;

  foreach(player in level.players) {
    if(player getteam() == spawnbeacon.team) {
      continue;
    }

    foreach(var_25d50c8b in level.spawnbeaconsettings.var_613ff100) {
      distance = distancesquared(spawnbeacon.origin, player.origin);

      if(distance <= var_25d50c8b.zonemax && distance > var_25d50c8b.zonemin) {
        spawnbeacon.threatlevel += var_25d50c8b.points;
      }
    }
  }
}

updatethreat() {
  level endon(#"game_ended");
  spawnbeacon = self;
  spawnbeacon endon(#"beacon_removed");

  while(isDefined(spawnbeacon)) {
    if(isDefined(spawnbeacon.isdisabled) && spawnbeacon.isdisabled) {
      spawnbeacon waittill(#"beacon_enabled");
    }

    spawnbeacon function_41a037e6();

    if(spawnbeacon.threatlevel >= (isDefined(level.spawnbeaconsettings.settingsbundle.var_ba2632d3) ? level.spawnbeaconsettings.settingsbundle.var_ba2632d3 : 0)) {
      objective_setgamemodeflags(spawnbeacon.objectiveid, 2);
    } else if(spawnbeacon.threatlevel >= (isDefined(level.spawnbeaconsettings.settingsbundle.var_332c5109) ? level.spawnbeaconsettings.settingsbundle.var_332c5109 : 0)) {
      objective_setgamemodeflags(spawnbeacon.objectiveid, 1);
    } else {
      objective_setgamemodeflags(spawnbeacon.objectiveid, 0);
    }

    wait 1;
  }
}

getnewspawnbeaconspawnlist() {
  if(!sessionmodeiscampaigngame()) {
    assert(level.spawnbeaconsettings.availablespawnlists.size > 0);
    spawnlist = array::pop(level.spawnbeaconsettings.availablespawnlists);
    assert(isDefined(spawnlist));
    return spawnlist;
  }
}

freespawnbeaconspawnlist(spawnlistname) {
  if(isDefined(spawnlistname)) {
    assert(!array::contains(level.spawnbeaconsettings.availablespawnlists, spawnlistname));
    array::push(level.spawnbeaconsettings.availablespawnlists, spawnlistname);
  }
}

gadget_spawnbeacon_on(slot, playerweapon) {
  assert(isplayer(self));
  self notify(#"start_killstreak", {
    #weapon: playerweapon
  });
}

gadget_spawnbeacon_off(slot, weapon) {
  self.isbuildingspawnbeacon = 0;
}

on_player_killed(s_params) {
  if(isDefined(self.spawnbeaconbuildprogressobjid)) {
    deleteobjective(self.spawnbeaconbuildprogressobjid);
    self.spawnbeaconbuildprogressobjid = undefined;
  }

  if(isDefined(self.isbuildingspawnbeacon) && self.isbuildingspawnbeacon && isDefined(s_params.eattacker)) {
    killstreaks::processscoreevent(#"forward_spawn_stopped_activation", s_params.eattacker, undefined, level.spawnbeaconsettings.beaconweapon);
  }
}

getobjectiveid() {
  return gameobjects::get_next_obj_id();
}

deleteobjective(objectiveid) {
  if(isDefined(objectiveid)) {
    objective_delete(objectiveid);
    gameobjects::release_obj_id(objectiveid);
  }
}

calculatecooldownpenalty() {
  spawnbeacon = self;
  player = spawnbeacon.owner;

  if(!isDefined(player)) {
    return;
  }

  if(!player hasweapon(level.spawnbeaconsettings.beaconweapon)) {
    return;
  }

  spawnbeaconslot = player gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
  currentpower = player gadgetpowerget(spawnbeaconslot) / 100;
  penalty = (isDefined(level.spawnbeaconsettings.settingsbundle.var_da5fcc2d) ? level.spawnbeaconsettings.settingsbundle.var_da5fcc2d : 0) - (isDefined(level.spawnbeaconsettings.settingsbundle.var_da5fcc2d) ? level.spawnbeaconsettings.settingsbundle.var_da5fcc2d : 0) * currentpower;
  player.spawnbeaconcooldownpenalty = int(penalty);
}

private function_e46fd633() {
  spawnbeacon = self;

  if(isDefined(level.spawnbeaconsettings.settingsbundle.var_d2110d43) ? level.spawnbeaconsettings.settingsbundle.var_d2110d43 : 0) {
    spawnbeacon calculatecooldownpenalty();
  }

  var_b80d3663 = isDefined(spawnbeacon.var_d02ddb8e) && spawnbeacon.var_d02ddb8e.name === "gadget_icepick";

  if(isDefined(self.owner) && !var_b80d3663) {
    var_9a5be956 = self.owner;
    self.owner thread killstreaks::play_taacom_dialog("spawnBeaconDestroyedFriendly");
  }

  playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_79efc1, util::getotherteam(spawnbeacon.team), spawnbeacon.var_846acfcf);

  if(!var_b80d3663) {
    playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_2ee73347, spawnbeacon.team, var_9a5be956);
    spawnbeacon.owner globallogic_score::function_5829abe3(spawnbeacon.var_846acfcf, spawnbeacon.var_d02ddb8e, level.spawnbeaconsettings.beaconweapon);
  }
}

destroyspawnbeacon(destroyedbyenemy) {
  self notify(#"hash_523ddcbd662010e5");
  self function_68a6ec15();
  self.var_ab0875aa = 1;
  spawnbeacon = self;
  attacker = destroyedbyenemy ? self.var_846acfcf : self.owner;
  spawnbeacon dodamage(spawnbeacon.health + 10000, spawnbeacon.origin, attacker, undefined, undefined, "MOD_EXPLOSIVE");

  if(target_istarget(spawnbeacon)) {
    target_remove(spawnbeacon);
  }

  player = self.owner;

  if(isDefined(self.beacondisabled) && self.beacondisabled) {
    return;
  }

  if(isDefined(level.var_d2600afc) && isDefined(spawnbeacon.var_846acfcf) && spawnbeacon.var_846acfcf != player) {
    self[[level.var_d2600afc]](spawnbeacon.var_846acfcf, player, level.spawnbeaconsettings.beaconweapon, spawnbeacon.var_d02ddb8e);
  }

  if(game.state == "playing") {
    if(spawnbeacon.health <= 0) {
      if(isDefined(level.spawnbeaconsettings.settingsbundle.destructionaudio)) {
        spawnbeacon playSound(level.spawnbeaconsettings.settingsbundle.destructionaudio);
      }
    } else if(isDefined(level.spawnbeaconsettings.settingsbundle.var_b4ecfeb2)) {
      spawnbeacon playSound(level.spawnbeaconsettings.settingsbundle.var_b4ecfeb2);
    }

    if(isDefined(destroyedbyenemy) && destroyedbyenemy) {
      self function_e46fd633();
    } else {
      if(isDefined(self.owner)) {
        var_9a5be956 = self.owner;
        self.owner thread killstreaks::play_taacom_dialog("spawnBeaconOfflineFriendly");
      }

      playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_10c9ba2d, self.team, var_9a5be956);
      playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_f29e64de, util::getotherteam(self.team), undefined);
    }
  }

  if(isDefined(level.spawnbeaconsettings.settingsbundle.destructionfx)) {
    playFX(level.spawnbeaconsettings.settingsbundle.destructionfx, spawnbeacon.origin);
  }

  if(isDefined(level.spawnbeaconsettings.settingsbundle.var_bb6c29b4) && isDefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
    playFX(level.spawnbeaconsettings.settingsbundle.var_bb6c29b4, spawnbeacon.origin);
  }

  if((isDefined(self.var_ca3a0f16) ? self.var_ca3a0f16 : 0) || isDefined(player) && isDefined(player.var_c4a4cb7d) && player hasweapon(getweapon(#"hash_7ab3f9a730359659"), 1)) {
    if(isDefined(self.objectiveid)) {
      gameobjects::release_obj_id(self.objectiveid);
    }
  } else {
    profilestart();

    if(isDefined(level.var_34c482f2)) {
      self[[level.var_34c482f2]](attacker, self.var_d02ddb8e);
    }

    array::push_front(level.spawnbeaconsettings.var_e7571ff1, self.objectiveid);

    if(isDefined(self.objectiveid)) {
      deleteobjective(self.objectiveid);
      level.spawnbeaconsettings.beacons[self.objectiveid] = undefined;
    }

    self.beacondisabled = 1;
    freespawnbeaconspawnlist(self.spawnlist);
    profilestop();
  }

  self clientfield::set("enemyequip", 0);

  if(isDefined(self.var_d7cf6658)) {
    foreach(gameobject in self.var_d7cf6658) {
      gameobject gameobjects::destroy_object(1, 1);
    }
  }

  if(isDefined(self.owner)) {
    var_c2ca0930 = getarraykeys(level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid]);

    foreach(var_2f55edb in var_c2ca0930) {
      if(level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid][var_2f55edb] == self) {
        indextoremove = var_2f55edb;
      }
    }
  }

  if(isDefined(indextoremove)) {
    level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid] = array::remove_index(level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid], indextoremove, 0);
  }

  self stoploopsound();
  self notify(#"beacon_removed");
  self callback::remove_callback(#"on_end_game", &function_438ca4e0);

  if(isDefined(player)) {
    player notify(#"beacon_removed");
    player clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 0);
    player.var_9698a18d = 0;
    player.var_583f6cce = undefined;
  }

  if(isDefined(self.var_2d045452)) {
    self.var_2d045452 delete();
  }

  deployable::function_81598103(self);
  var_b0e81be9 = self gettagorigin("tag_base_d0");

  if(!isDefined(var_b0e81be9)) {
    var_b0e81be9 = self.origin;
  }

  var_505e3308 = self gettagangles("tag_base_d0");

  if(!isDefined(var_505e3308)) {
    var_505e3308 = self.angles;
  }

  var_8fec56c4 = anglesToForward(var_505e3308);
  var_61753233 = anglestoup(var_505e3308);
  playFX(#"hash_695b2e7e4b63a645", var_b0e81be9, var_8fec56c4, var_61753233);

  if(!(isDefined(spawnbeacon.var_4fc7245b) ? spawnbeacon.var_4fc7245b : 0) && (isDefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0) && isDefined(player)) {
    player.pers[#"lives"]--;
  }

  self delete();
}

getspawnbeaconspawns(origin) {
  spawnstoadd = [];
  collectionradiusmax = (isDefined(level.spawnbeaconsettings.settingsbundle.collectionradiusmax) ? level.spawnbeaconsettings.settingsbundle.collectionradiusmax : 0) * (isDefined(level.spawnbeaconsettings.settingsbundle.collectionradiusmax) ? level.spawnbeaconsettings.settingsbundle.collectionradiusmax : 0);
  collectionradiusmin = (isDefined(level.spawnbeaconsettings.settingsbundle.collectionradiusmin) ? level.spawnbeaconsettings.settingsbundle.collectionradiusmin : 0) * (isDefined(level.spawnbeaconsettings.settingsbundle.collectionradiusmin) ? level.spawnbeaconsettings.settingsbundle.collectionradiusmin : 0);
  var_a62d9bc = isDefined(level.spawnbeaconsettings.settingsbundle.var_6150bb7f) ? level.spawnbeaconsettings.settingsbundle.var_6150bb7f : 0;

  if(!isDefined(level.allspawnpoints)) {
    return spawnstoadd;
  }

  foreach(spawnpoint in level.allspawnpoints) {
    if(isDefined(spawnpoint.ct) ? spawnpoint.ct : 0) {
      continue;
    }

    if(var_a62d9bc > 0 && abs(spawnpoint.origin[2] - origin[2]) > var_a62d9bc) {
      continue;
    }

    distsqr = distancesquared(origin, spawnpoint.origin);

    if(distsqr > collectionradiusmax) {
      continue;
    }

    if(distsqr < collectionradiusmin) {
      continue;
    }

    var_dcf0e6cc = 0;

    foreach(protectedzone in level.spawnbeaconsettings.objectivezones) {
      if(protectedzone istouching(spawnpoint.origin, (45, 45, 72))) {
        var_dcf0e6cc = 1;
        break;
      }
    }

    if(var_dcf0e6cc) {
      continue;
    }

    if(!isDefined(spawnpoint.enabled)) {
      spawnpoint.enabled = -1;
    }

    if(!isDefined(spawnstoadd)) {
      spawnstoadd = [];
    } else if(!isarray(spawnstoadd)) {
      spawnstoadd = array(spawnstoadd);
    }

    spawnstoadd[spawnstoadd.size] = spawnpoint;
  }

  return spawnstoadd;
}

createspawngroupforspawnbeacon(associatedspawnbeacon, spawnstoadd) {
  assert(isDefined(spawnstoadd));
  assert(isDefined(associatedspawnbeacon));

  if(spawnstoadd.size == 0) {
    return false;
  }

  team = associatedspawnbeacon.team;
  enemyteam = util::getotherteam(team);
  var_5b29525a = level.teambased && isDefined(game.switchedsides) && game.switchedsides && level.spawnsystem.var_3709dc53;
  associatedspawnbeacon.spawnlist = getnewspawnbeaconspawnlist();
  assert(isDefined(associatedspawnbeacon.spawnlist));

  if(level.teambased) {
    if(var_5b29525a) {
      enemyteam = team;
      team = enemyteam;
    }

    assert(isDefined(team));
    addspawnpoints(team, spawnstoadd, associatedspawnbeacon.spawnlist);
    addspawnpoints(enemyteam, spawnstoadd, associatedspawnbeacon.spawnlist);
  } else {
    addspawnpoints("free", spawnstoadd, associatedspawnbeacon.spawnlist);
  }

  associatedspawnbeacon.spawns = spawnstoadd;
  return true;
}

function_425d8006() {
  spawnbeacon = self;
  spawnbeacon endon(#"beacon_removed");
  level endon(#"game_ended");
  spawnbeacon.isdisabled = 1;
  spawnbeacon notify(#"beacon_disabled");
  objective_setgamemodeflags(spawnbeacon.objectiveid, 3);
  var_d7760961 = isDefined(level.spawnbeaconsettings.settingsbundle.var_26f4f5f0) ? level.spawnbeaconsettings.settingsbundle.var_26f4f5f0 : 0;
  var_f1c32a14 = "";

  if(spawnbeacon.team == #"allies") {
    var_f1c32a14 = "A";
  } else {
    var_f1c32a14 = "B";
  }

  playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_1068819a, spawnbeacon.team, undefined);
  playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_c5d0582b, util::getotherteam(spawnbeacon.team), undefined);
  setbombtimer(var_f1c32a14, gettime() + int(var_d7760961 * 1000));
  wait var_d7760961;
  spawnbeacon.isdisabled = 0;
  spawnbeacon notify(#"beacon_enabled");
}

watchfordeath() {
  level endon(#"game_ended");
  self.owner endon(#"disconnect", #"joined_team", #"changed_specialist");
  self endon(#"hash_523ddcbd662010e5");
  waitresult = self waittill(#"death");

  if(!isDefined(self)) {
    return;
  }

  var_b08a3652 = 1;
  self.var_846acfcf = waitresult.attacker;
  self.var_d02ddb8e = waitresult.weapon;

  if(isDefined(waitresult.attacker) && isDefined(self) && isDefined(self.owner) && waitresult.attacker.team == self.owner.team) {
    var_b08a3652 = 0;
  }

  self thread destroyspawnbeacon(var_b08a3652);
}

watchfordamage() {
  self endon(#"death");
  level endon(#"game_ended");
  self endon(#"hash_523ddcbd662010e5");
  spawnbeacon = self;
  spawnbeacon endon(#"death");
  spawnbeacon.health = level.spawnbeaconsettings.settingsbundle.health;

  if(isDefined(level.var_b8701e49)) {
    spawnbeacon.health = level.var_b8701e49;
  }

  spawnbeacon.maxhealth = spawnbeacon.health;

  while(true) {
    waitresult = self waittill(#"damage");

    if(isDefined(waitresult.attacker) && waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker)) {
      waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
    }
  }
}

function_40c032a1(einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex) {
  bundle = level.spawnbeaconsettings.settingsbundle;
  chargelevel = 0;
  weapon_damage = killstreak_bundles::function_dd7587e4(bundle, bundle.health, attacker, weapon, smeansofdeath, idamage, idflags, chargelevel);

  if(!isDefined(weapon_damage)) {
    weapon_damage = killstreaks::get_old_damage(attacker, weapon, smeansofdeath, idamage, 1);
  }

  return int(weapon_damage);
}

function_438ca4e0() {
  spawnbeacon = self;
  spawnbeacon.var_648955e6 = 1;
  spawnbeacon function_68a6ec15();
}

function_9c87725b() {
  currentid = game.spawnbeaconid;
  game.spawnbeaconid += 1;
  return currentid;
}

function_639cb9da() {
  self endon(#"death");
  self waittill(#"game_ended");

  if(!isDefined(self)) {
    return;
  }

  self destroyspawnbeacon(0);
}

function_b3608e1(spawnbeacon) {
  spawnbeacon.objectiveid = getobjectiveid();
  objective_add(spawnbeacon.objectiveid, "active", spawnbeacon.origin, level.spawnbeaconsettings.settingsbundle.mainobjective);
  objective_setteam(spawnbeacon.objectiveid, spawnbeacon.team);
  function_3ae6fa3(spawnbeacon.objectiveid, spawnbeacon.owner.team, 1);
  objective_setprogress(spawnbeacon.objectiveid, 1);
}

retreatedstartmelee(var_a820f9, spawns) {
  player = self;

  if(isDefined(level.spawnbeaconsettings.userspawnbeacons[player.clientid]) && level.spawnbeaconsettings.userspawnbeacons[player.clientid].size >= (isDefined(level.spawnbeaconsettings.settingsbundle.var_e3d3bd15) ? level.spawnbeaconsettings.settingsbundle.var_e3d3bd15 : 1)) {
    beacontoremove = level.spawnbeaconsettings.userspawnbeacons[player.clientid][0];

    if(isDefined(beacontoremove)) {
      beacontoremove thread destroyspawnbeacon(0);
    } else {
      level.spawnbeaconsettings.userspawnbeacons[self.clientid] = undefined;
    }
  }

  slot = player gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
  player gadgetpowerreset(slot);
  player gadgetpowerset(slot, 0);
  spawnbeaconslot = player gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
  player function_69b5c53c(spawnbeaconslot, 0);
  placedspawnbeacon = spawn("script_model", var_a820f9.origin);
  placedspawnbeacon setModel(level.spawnbeaconsettings.beaconweapon.worldmodel);
  var_a820f9.spawnbeacon = placedspawnbeacon;
  placedspawnbeacon.var_2d045452 = var_a820f9;
  placedspawnbeacon setdestructibledef(#"hash_77200d1bb519ba08");
  placedspawnbeacon useanimtree("generic");
  target_set(placedspawnbeacon, (0, 0, 32));
  placedspawnbeacon.owner = player;
  placedspawnbeacon clientfield::set("spawnbeacon_placed", 1);
  placedspawnbeacon setteam(player getteam());
  placedspawnbeacon.var_86a21346 = &function_40c032a1;
  placedspawnbeacon solid();
  placedspawnbeacon show();
  placedspawnbeacon.victimsoundmod = "vehicle";

  if(isDefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0) {
    player.pers[#"lives"]++;
  }

  placedspawnbeacon setweapon(level.spawnbeaconsettings.beaconweapon);
  placedspawnbeacon.weapon = level.spawnbeaconsettings.beaconweapon;
  function_b3608e1(placedspawnbeacon);
  createspawngroupforspawnbeacon(placedspawnbeacon, spawns);
  level.spawnbeaconsettings.beacons[placedspawnbeacon.objectiveid] = placedspawnbeacon;

  if(!isDefined(level.spawnbeaconsettings.userspawnbeacons[player.clientid])) {
    level.spawnbeaconsettings.userspawnbeacons[player.clientid] = [];
  }

  var_a7edcaed = level.spawnbeaconsettings.userspawnbeacons.size + 1;
  array::push(level.spawnbeaconsettings.userspawnbeacons[player.clientid], placedspawnbeacon, var_a7edcaed);

  if(isDefined(level.spawnbeaconsettings.settingsbundle.canbedamaged) ? level.spawnbeaconsettings.settingsbundle.canbedamaged : 0) {
    placedspawnbeacon setCanDamage(1);
  }

  placedspawnbeacon clientfield::set("enemyequip", 1);
  placedspawnbeacon.builttime = gettime();
  placedspawnbeacon.threatlevel = 0;
  placedspawnbeacon.spawncount = 0;
  placedspawnbeacon.uniqueid = function_9c87725b();
  playcommanderaudio(level.spawnbeaconsettings.settingsbundle.var_69b1ff7, player getteam(), player);
  playcommanderaudio(level.spawnbeaconsettings.settingsbundle.deployedenemy, util::getotherteam(player getteam()), undefined);

  if(isDefined(level.spawnbeaconsettings.settingsbundle.ambientaudio)) {
    placedspawnbeacon playLoopSound(level.spawnbeaconsettings.settingsbundle.ambientaudio);
  }

  if(isDefined(level.var_4b1d905b)) {
    self[[level.var_4b1d905b]](placedspawnbeacon);
  }

  placedspawnbeacon thread updatethreat();
  placedspawnbeacon thread watchfordamage();
  placedspawnbeacon thread watchfordeath();
  placedspawnbeacon thread function_f8930fa1(isDefined(level.spawnbeaconsettings.settingsbundle.timeout) ? level.spawnbeaconsettings.settingsbundle.timeout : 0);
  placedspawnbeacon thread function_639cb9da();
  placedspawnbeacon callback::function_d8abfc3d(#"on_end_game", &function_438ca4e0);
  player deployable::function_6ec9ee30(placedspawnbeacon, level.spawnbeaconsettings.beaconweapon);

  if(!isDefined(player.pers[#"hash_677f229433c8735b"])) {
    player.pers[#"hash_677f229433c8735b"] = 0;
  }

  player.pers[#"hash_677f229433c8735b"]++;

  if(getdvarint(#"hash_da55c6d97d1dc52", 1) && (isDefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0)) {
    player function_19ed70ca(slot, 1);
  }

  player.var_583f6cce = placedspawnbeacon;
  player notify(#"beacon_added");
}

function_264da546(var_cd3712d2, jammer) {
  println("<dev string:x38>");
}

function_9aafb7bb(origin, angles, player) {
  if(!isDefined(player.var_9bab32d9)) {
    player.var_9bab32d9 = spawnStruct();
  }

  player.var_9bab32d9.spawns = [];

  if(isDefined(level.var_ae2fe442)) {
    return [[level.var_ae2fe442]](origin, angles, player);
  }

  return 1;
}

onplacespawnbeacon(spawnbeacon) {
  spawnbeacon setvisibletoall();

  if(isDefined(spawnbeacon.othermodel)) {
    spawnbeacon.othermodel setinvisibletoall();
  }

  if(isDefined(spawnbeacon.var_9bab32d9) && isDefined(spawnbeacon.var_9bab32d9.spawns)) {
    self retreatedstartmelee(spawnbeacon, spawnbeacon.var_9bab32d9.spawns);
  }
}

oncancelplacement(spawnbeacon) {
  spawnbeaconslot = self gadgetgetslot(level.spawnbeaconsettings.beaconweapon);
  self gadgetdeactivate(spawnbeaconslot, level.spawnbeaconsettings.beaconweapon, 0);
  self gadgetpowerset(spawnbeaconslot, 100);
}

function_d82c03d4(player) {
  spawnbeacon = self;
  player endon(#"disconnect");
  spawnbeacon endon(#"death");
  player waittill(#"joined_team");

  if(isDefined(spawnbeacon)) {
    spawnbeacon thread destroyspawnbeacon(0);
  }
}

function_e9fea0ea() {
  player = self;

  if(!isDefined(level.spawnbeaconsettings) || !isDefined(level.spawnbeaconsettings.userspawnbeacons)) {
    return undefined;
  }

  return level.spawnbeaconsettings.userspawnbeacons[player.clientid];
}

function_68a6ec15() {}

function_d32596e5() {}