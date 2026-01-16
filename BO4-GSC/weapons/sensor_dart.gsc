/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\sensor_dart.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damage;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\weapons\weaponobjects;

#namespace sensor_dart;

autoexec __init__system__() {
  system::register(#"sensor_dart", &init_shared, undefined, undefined);
}

init_shared() {
  level thread register();
  callback::on_spawned(&on_player_spawned);
  weaponobjects::function_e6400478(#"eq_sensor", &function_eb12ff13, 1);
  globallogic_score::register_kill_callback(getweapon("eq_sensor"), &function_4d8676af);
  globallogic_score::function_86f90713(getweapon("eq_sensor"), &function_4d8676af);
  level.sensordartweapon = getweapon("eq_sensor");

  if(getgametypesetting(#"competitivesettings") === 1) {
    level.var_e88e144b = getscriptbundle("sensor_custom_settings_comp");
  } else if(isDefined(level.sensordartweapon.customsettings)) {
    level.var_e88e144b = getscriptbundle(level.sensordartweapon.customsettings);
  } else {
    level.var_e88e144b = getscriptbundle("sensor_custom_settings");
  }

  level.var_9911d36f = &function_4db10465;
  callback::on_finalize_initialization(&function_1c601b99);
}

function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](level.sensordartweapon, &function_bff5c062);
  }

  if(isDefined(level.var_a5dacbea)) {
    [[level.var_a5dacbea]](level.sensordartweapon, &weaponobjects::function_127fb8f3);
  }
}

function_bff5c062(sensordart, attackingplayer) {
  sensordart.owner weaponobjects::hackerremoveweapon(sensordart);

  if(isDefined(sensordart.owner.sensor_darts)) {
    arrayremovevalue(sensordart.owner.sensor_darts, sensordart);
  }

  sensordart setteam(attackingplayer.team);
  sensordart.team = attackingplayer.team;
  sensordart.owner = attackingplayer;
  sensordart setowner(attackingplayer);
  sensordart notify(#"hacked");
  sensordart clientfield::set("sensor_dart_state", 1);
  sensordart weaponobjects::function_386fa470(attackingplayer);

  if(!isDefined(attackingplayer.sensor_darts)) {
    attackingplayer.sensor_darts = [];
  }

  if(!isDefined(attackingplayer.sensor_darts)) {
    attackingplayer.sensor_darts = [];
  } else if(!isarray(attackingplayer.sensor_darts)) {
    attackingplayer.sensor_darts = array(attackingplayer.sensor_darts);
  }

  attackingplayer.sensor_darts[attackingplayer.sensor_darts.size] = sensordart;

  if(isDefined(level.var_f1edf93f)) {
    _station_up_to_detention_center_triggers = [[level.var_f1edf93f]]() * 1000;

    if(isDefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
      sensordart notify(#"cancel_timeout");
      sensordart thread weaponobjects::function_d9c08e94(_station_up_to_detention_center_triggers, &function_4db10465);
    }
  }

  if(isDefined(level.var_fc1bbaef)) {
    [[level.var_fc1bbaef]](sensordart);
  }

  sensordart thread weaponobjects::function_6d8aa6a0(attackingplayer, sensordart.var_2d045452);
}

register() {
  clientfield::register("missile", "sensor_dart_state", 1, 1, "int");
  clientfield::register("clientuimodel", "hudItems.sensorDartCount", 1, 3, "int");
}

on_player_spawned() {
  weapon = getweapon("eq_sensor");

  if(isDefined(weapon) && !self hasweapon(weapon)) {
    self clientfield::set_player_uimodel("hudItems.sensorDartCount", 0);
  }
}

function_4d8676af(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(!isDefined(attackerweapon) || !isDefined(attacker) || !isDefined(victim) || !isDefined(weapon)) {
    return false;
  }

  if(isDefined(attacker.sensor_darts)) {
    foreach(dart in attacker.sensor_darts) {
      if(isDefined(dart) && distancesquared(victim.origin, dart.origin) < ((sessionmodeiswarzonegame() ? 2400 : 800) + 50) * ((sessionmodeiswarzonegame() ? 2400 : 800) + 50) && weapon != attackerweapon) {
        dart.killcount = (isDefined(dart.killcount) ? dart.killcount : 0) + 1;

        if(!isDefined(dart.var_cbca1a8f) && isDefined(level.var_ac6052e9) && dart.killcount >= [
            [level.var_ac6052e9]
          ]("sensorDartSuccessKillCount", 0) && isDefined(level.playgadgetsuccess) && isDefined(dart.owner)) {
          dart.owner[[level.playgadgetsuccess]](getweapon("eq_sensor"), undefined, victim);
          dart.var_cbca1a8f = 1;
        }

        return true;
      }
    }
  }

  return false;
}

function_eb12ff13(watcher) {
  watcher.ondetonatecallback = &function_4b3bc61d;
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.deleteonplayerspawn = 0;
  watcher.enemydestroy = 1;
  watcher.onspawn = &function_f4970a20;
  watcher.ondamage = &function_55de888f;
  watcher.ondestroyed = &function_c142e8ec;
  watcher.pickup = &weaponobjects::function_db70257;
  watcher.var_994b472b = &function_95c69960;
}

function_95c69960(player) {
  self function_c142e8ec(undefined, undefined);
}

function_f4970a20(watcher, player) {
  player endon(#"death", #"disconnect");
  level endon(#"game_ended");
  self endon(#"death");
  self weaponobjects::onspawnuseweaponobject(watcher, player);
  self clientfield::set("sensor_dart_state", 1);
  self.var_2d045452 = watcher;
  self.weapon = getweapon(#"eq_sensor");
  self setweapon(self.weapon);

  if(!isDefined(player.sensor_darts)) {
    player.sensor_darts = [];
  }

  if(!isDefined(player.sensor_darts)) {
    player.sensor_darts = [];
  } else if(!isarray(player.sensor_darts)) {
    player.sensor_darts = array(player.sensor_darts);
  }

  player.sensor_darts[player.sensor_darts.size] = self;
  waitresult = self waittilltimeout(5, #"stationary");

  if(waitresult._notify == #"timeout") {
    function_4db10465();
    return;
  }

  player notify(#"hash_70f03cfbb15356c0", {
    #dart: self
  });
  player clientfield::set_player_uimodel("hudItems.sensorDartCount", player.sensor_darts.size);
  player stats::function_e24eec31(self.weapon, #"used", 1);
  self util::make_sentient();
  self thread function_cc9ab1fc();
  self thread function_cb672f03();

  if(isDefined(level.var_6ec46eeb)) {
    level thread[[level.var_6ec46eeb]](self, player);
  }

  if(isDefined(level.var_2e552187)) {
    n_fuse_time = level.var_2e552187;
  } else {
    n_fuse_time = int((isDefined(level.var_e88e144b.var_f196f1c0) ? level.var_e88e144b.var_f196f1c0 : 0) * 1000);
  }

  self thread weaponobjects::function_d9c08e94(n_fuse_time, &function_4db10465);
  self clientfield::set("enemyequip", 1);
  playFXOnTag(#"hash_1307839267d89579", self, "tag_fx");
}

private function_cb672f03() {
  owner = self.owner;
  waitresult = self waittill(#"picked_up", #"death");

  if(isDefined(owner) && isDefined(owner.sensor_darts)) {
    arrayremovevalue(owner.sensor_darts, undefined);
    owner clientfield::set_player_uimodel("hudItems.sensorDartCount", owner.sensor_darts.size);
  }

  if(waitresult._notify == "death") {
    return;
  }

  if(isDefined(self)) {
    self clientfield::set("sensor_dart_state", 0);
  }
}

function_cc9ab1fc() {
  self endon(#"death");
  self waittill(#"hacked");
}

function_c142e8ec(attacker, callback_data) {
  playFX(level._equipment_explode_fx_lg, self.origin);
  self playSound(#"hash_2e37b2a562ab2bf8");
  var_3c4d4b60 = isDefined(self.owner);

  if(isDefined(attacker) && (!var_3c4d4b60 || self.owner util::isenemyplayer(attacker))) {
    if(var_3c4d4b60) {
      self.owner thread killstreaks::play_taacom_dialog("sensorDartDestroyedFriendly");
    }

    attacker challenges::destroyedequipment();
    scoreevents::processscoreevent(#"hash_4c5d3e163d180de8", attacker, self.owner, undefined);

    if(isDefined(level.var_d2600afc)) {
      self[[level.var_d2600afc]](attacker, self.owner, self.weapon);
    }
  }

  self delete();
}

function_4db10465() {
  self thread function_c142e8ec(undefined, undefined);
}

function_4b3bc61d(attacker, weapon, target) {
  level notify(#"hash_4ee855fb0aa467c9");

  if(!isDefined(weapon) || !weapon.isemp) {
    playFX(level._equipment_explode_fx_lg, self.origin);
  }

  if(isDefined(level.var_e88e144b.var_bb6c29b4) && isDefined(weapon) && weapon == getweapon(#"shock_rifle")) {
    playFX(level.var_e88e144b.var_bb6c29b4, self.origin);
  }

  if(isDefined(attacker) && self.owner util::isenemyplayer(attacker)) {
    attacker challenges::destroyedequipment(weapon);
    self.owner globallogic_score::function_5829abe3(attacker, weapon, self.weapon);
  }

  if(validateorigin(self.origin)) {
    playsoundatposition(#"hash_206452ff3953c686", self.origin);
  }

  if(isDefined(level.var_d2600afc)) {
    self[[level.var_d2600afc]](attacker, self.owner, self.weapon, weapon);
  }

  self.owner luinotifyevent(#"hash_4ee855fb0aa467c9");
  self delete();
}

function_55de888f(watcher) {
  self endon(#"death");
  self setCanDamage(1);
  damagemax = 20;

  if(!self util::ishacked()) {
    self.damagetaken = 0;
  }

  self.maxhealth = 10000;
  self.health = self.maxhealth;
  self setmaxhealth(self.maxhealth);
  attacker = undefined;

  while(true) {
    waitresult = self waittill(#"damage");
    profilestart();
    damage = waitresult.amount;
    type = waitresult.mod;
    weapon = waitresult.weapon;
    damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
    attacker = self[[level.figure_out_attacker]](waitresult.attacker);
    attackerisplayer = isplayer(attacker);
    profilestop();

    if(level.teambased && !sessionmodeiswarzonegame()) {
      if(attackerisplayer && !(isDefined(level.hardcoremode) && level.hardcoremode) && !util::function_fbce7263(self.owner.team, attacker.pers[#"team"]) && self.owner != attacker) {
        continue;
      }
    }

    profilestart();

    if(watcher.stuntime > 0 && weapon.dostun) {
      self thread weaponobjects::stunstart(watcher, watcher.stuntime);
    }

    if(attackerisplayer && damage::friendlyfirecheck(self.owner, attacker)) {
      if(damagefeedback::dodamagefeedback(weapon, attacker)) {
        attacker damagefeedback::update();
      }
    }

    if(type == "MOD_MELEE" || type == "MOD_MELEE_WEAPON_BUTT" || weapon.isemp || weapon.destroysequipment) {
      self.damagetaken = damagemax;
    } else {
      self.damagetaken += damage;
    }

    if(self.damagetaken >= damagemax) {
      watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
      profilestop();
      return;
    }

    profilestop();
  }
}