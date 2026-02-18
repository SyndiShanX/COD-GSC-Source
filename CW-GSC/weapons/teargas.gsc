/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\teargas.gsc
***********************************************/

#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\util_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;
#namespace teargas;

function init_shared() {
  level.var_2ee59975 = [];
  level.var_29115f03 = [];
  level.var_29115f03[1] = {
    #slow: # "hash_8a5fd5a0a3d0325", #var_18c0a09d: # "hash_42b275f8ad52e92d"};
  level.var_29115f03[2] = {
    #slow: # "hash_8a5fa5a0a3cfe0c", #var_18c0a09d: # "hash_42b272f8ad52e414"};
  level.var_29115f03[3] = {
    #slow: # "hash_8a5fb5a0a3cffbf", #var_18c0a09d: # "hash_42b273f8ad52e5c7"};
  weapon = getweapon(#"tear_gas");
  clientfield::register("toplayer", "in_tear_gas", 1, 2, "int");
  weaponobjects::function_e6400478(#"tear_gas", &function_db9e3adb, 0);
  deployable::register_deployable(weapon);
  globallogic_score::function_a458dbe1(#"hash_69c2a47bf2322b6b", &function_dbdedd18);
  globallogic_score::function_69c6cfcc(#"hash_69c2a47bf2322b6b", &function_c402f4b4);
  callback::on_finalize_initialization(&function_1c601b99);
}

function function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon("tear_gas"), &function_bff5c062);
  }
}

function function_bff5c062(teargas, attackingplayer) {
  var_f3ab6571 = teargas.owner weaponobjects::function_8481fc06(teargas.weapon) > 1;
  teargas.owner thread globallogic_audio::function_a2cde53d(teargas.weapon, var_f3ab6571);
  teargas.owner weaponobjects::hackerremoveweapon(teargas);
  teargas weaponobjects::function_fb7b0024(teargas.owner);
  teargas.team = attackingplayer.team;
  teargas setteam(attackingplayer.team);
  teargas.owner = attackingplayer;
  teargas setowner(attackingplayer);
  teargas weaponobjects::function_386fa470(attackingplayer);
  teargas weaponobjects::function_931041f8(attackingplayer);

  if(isDefined(teargas) && isDefined(level.var_f1edf93f)) {
    _station_up_to_detention_center_triggers = [[level.var_f1edf93f]]();

    if(isDefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
      teargas notify(#"cancel_timeout");
      teargas thread weaponobjects::weapon_object_timeout(teargas.var_2d045452, _station_up_to_detention_center_triggers);
    }
  }

  teargas thread weaponobjects::function_6d8aa6a0(attackingplayer, teargas.var_2d045452);

  if(isDefined(level.var_b7bc3c75.var_1d3ef959)) {
    attackingplayer[[level.var_b7bc3c75.var_1d3ef959]]();
  }
}

function function_db9e3adb(watcher) {
  watcher.watchforfire = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.immediatedetonation = 1;
  watcher.immunespecialty = "specialty_immunegastrap";
  watcher.var_8eda8949 = (0, 0, 0);
  watcher.stuntime = 1;
  watcher.var_10efd558 = "switched_field_upgrade";

  if(isDefined(watcher.weapon.customsettings)) {
    var_e6fbac16 = getscriptbundle(watcher.weapon.customsettings);
    watcher.triggertime = var_e6fbac16.var_af22b5dc;
    watcher.activationdelay = var_e6fbac16.var_a3fd61e7;
    watcher.detectiongraceperiod = isDefined(var_e6fbac16.var_88b0248b) ? var_e6fbac16.var_88b0248b : 0;

    if(isDefined(var_e6fbac16.var_29467698) && var_e6fbac16.var_29467698 != 0) {
      watcher.detonateradius = var_e6fbac16.var_29467698;
    }
  }

  watcher.ondetonatecallback = &function_f82566e8;
  watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
  watcher.onspawn = &function_7641afa6;
  watcher.var_994b472b = &function_5192d9d6;
  watcher.stun = &weaponobjects::weaponstun;
}

function function_dbdedd18(attacker, victim, var_3d1ed4bd, weapon, meansofdeath, var_b5bddaea) {
  victim contracts::increment_contract(#"hash_d9376f51d3c734c");

  if(meansofdeath != weapon) {
    level scoreevents::function_2a2e1723(#"hash_5a02ff4e546b68f1", victim, var_3d1ed4bd);
    victim stats::function_dad108fa(#"hash_6e9f9d0d3ae59765", 1);
    victim stats::function_dad108fa(#"hash_24b8c6ce81fdead6", 1);
    victim stats::function_dad108fa(#"hash_24b8c5ce81fde923", 1);
    victim stats::function_bcf9602(#"hash_5a979e436e74441", 1, #"hash_6abe83944d701459");
  }

  if(isDefined(level.var_b7bc3c75.var_fbbc4c75)) {
    victim[[level.var_b7bc3c75.var_fbbc4c75]](var_b5bddaea);
  }

  return true;
}

function function_c402f4b4(attacker, victim, var_3d1ed4bd, weapon, meansofdeath, var_b5bddaea) {
  self stats::function_dad108fa(#"hash_6e9f9d0d3ae59765", 1);
  self stats::function_dad108fa(#"hash_24b8c6ce81fdead6", 1);
  self stats::function_dad108fa(#"hash_24b8c5ce81fde923", 1);
  self stats::function_bcf9602(#"hash_5a979e436e74441", 1, #"hash_6abe83944d701459");

  if(isDefined(level.var_b7bc3c75.var_fbbc4c75)) {
    self[[level.var_b7bc3c75.var_fbbc4c75]](var_b5bddaea);
  }
}

function function_7641afa6(watcher, player) {
  self.delete_on_death = 1;
  self.var_48d842c3 = 1;
  self.var_515d6dda = 1;
  self function_619a5c20();
  player notify(#"hash_228d061be1b2a83a");
  var_e6fbac16 = getscriptbundle(self.weapon.customsettings);
  self.var_b2ed661a = var_e6fbac16.teargasduration + 3;
  self weaponobjects::onspawnproximitygrenadeweaponobject(watcher, player);
  player battlechatter::function_fc82b10(self.weapon, self.origin, self);
  level influencers::create_grenade_influencers(player.team, self.weapon, self);
}

function function_5192d9d6(player) {
  self weaponobjects::weaponobjectfizzleout();
}

function function_f82566e8(attacker, weapon, target) {
  var_7e6e7f9f = self.weapon;

  if(is_true(self.wasdamaged)) {
    if(self.owner util::isenemyplayer(attacker)) {
      attacker challenges::destroyedexplosive(weapon);
      scoreevents::processscoreevent(#"hash_6913b395f1030cd3", attacker, self.owner, weapon);
      self thread battlechatter::function_d2600afc(attacker, self.owner, var_7e6e7f9f, weapon);
      self.owner globallogic_score::function_5829abe3(attacker, weapon, var_7e6e7f9f);
      var_f3ab6571 = self.owner weaponobjects::function_8481fc06(var_7e6e7f9f) > 1;
      self.owner thread globallogic_audio::function_6daffa93(var_7e6e7f9f, var_f3ab6571);
    }

    if(isDefined(level._equipment_explode_fx)) {
      playFX(level._equipment_explode_fx, self.origin);
    }

    self playSound(#"hash_16dfe84ea21fd143");
    self delete();
    return;
  }

  var_e6fbac16 = getscriptbundle(var_7e6e7f9f.customsettings);
  radius = var_e6fbac16.var_b86ce9f4;
  duration = var_e6fbac16.teargasduration;
  position = self.origin;
  dir_up = (0, 0, 1);
  ent = spawn("script_model", position);
  ent setteam(self.team);
  ent.team = self.team;
  owner = self.owner;
  ent.killcament = self.killcament;
  ent.ishacked = self.ishacked;

  if(isDefined(owner)) {
    ent setowner(owner);
    ent.owner = owner;
    owner.var_d56524fc = gettime();
    owner.var_2af14143 = position;
  }

  ent thread function_2f37f73e(var_7e6e7f9f, duration, radius);
  level influencers::create_grenade_influencers(ent.team, var_7e6e7f9f, ent);
  level thread function_a2493473(position, duration, var_7e6e7f9f.projsmokestartsound, var_7e6e7f9f.projsmokeendsound, var_7e6e7f9f.projsmokeloopsound);
  self weaponobjects::proximitydetonate(attacker, weapon, target);
}

function function_2f37f73e(var_7e6e7f9f, duration, radius) {
  team = self.team;
  owner = self.owner;
  trigger = spawn("trigger_radius", self.origin, 0, radius, radius);
  trigger.owner = owner;
  self.var_160d2855 = trigger;

  if(!isDefined(level.var_2ee59975)) {
    level.var_2ee59975 = [];
  } else if(!isarray(level.var_2ee59975)) {
    level.var_2ee59975 = array(level.var_2ee59975);
  }

  level.var_2ee59975[level.var_2ee59975.size] = trigger;
  level thread function_516794d8(self, var_7e6e7f9f);
  killcament = self.killcament;
  self waittilltimeout(duration, #"death");
  arrayremovevalue(level.var_2ee59975, trigger);

  if(isDefined(killcament)) {
    killcament thread util::deleteaftertime(5);
  }

  if(isDefined(trigger)) {
    trigger delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function function_12b45f48(skiptrigger, team) {
  foreach(trigger in level.var_2ee59975) {
    if(isDefined(team) && trigger util::isenemyteam(team)) {
      continue;
    }

    if(self istouching(trigger)) {
      if(isDefined(skiptrigger)) {
        if(skiptrigger != trigger) {
          return trigger;
        }

        continue;
      }

      return trigger;
    }
  }

  return undefined;
}

function function_585ad28f(weapon) {
  if(getweapon(#"tear_gas") == weapon.rootweapon) {
    return true;
  }

  return false;
}

function function_516794d8(grenadeent, var_7e6e7f9f) {
  var_160d2855 = grenadeent.var_160d2855;

  if(!isDefined(var_160d2855)) {
    return;
  }

  grenadeteam = grenadeent.team;
  owner = grenadeent.owner;

  while(true) {
    waitresult = var_160d2855 waittilltimeout(0.2, #"death");
    playertargets = grenadeent getpotentialtargets(owner, grenadeteam, var_7e6e7f9f);

    foreach(player in playertargets) {
      if(player hasperk(#"hash_5fef46715b368a6e")) {
        continue;
      }

      if(waitresult._notify == # "timeout" && isDefined(var_160d2855) && player istouching(var_160d2855) && bullettracepassed(grenadeent.origin, player.origin + (0, 0, 12), 0, player)) {
        if(!isDefined(player.var_2ee59975)) {
          player.var_2ee59975 = [];
        } else if(!isarray(player.var_2ee59975)) {
          player.var_2ee59975 = array(player.var_2ee59975);
        }

        if(!isinarray(player.var_2ee59975, var_160d2855)) {
          player.var_2ee59975[var_160d2855 getentitynumber()] = var_160d2855;

          if(!isDefined(player.var_1b05dcde)) {
            player thread function_78d7002(var_7e6e7f9f, owner, grenadeent);
          }
        }

        continue;
      }

      if(isDefined(player.var_1b05dcde)) {
        player function_9eda41cd(var_160d2855, var_7e6e7f9f, owner);
      }
    }

    if(!isDefined(var_160d2855) || waitresult._notify != "timeout") {
      return;
    }
  }
}

function private getpotentialtargets(owner, ownerteam, var_7e6e7f9f) {
  if(level.friendlyfire) {
    return function_a1ef346b();
  }

  potentialtargets = function_f6f34851(ownerteam);
  var_e6fbac16 = getscriptbundle(var_7e6e7f9f.customsettings);

  if(is_true(var_e6fbac16.var_fc20cda3) && isalive(owner)) {
    potentialtargets[potentialtargets.size] = owner;
  }

  return potentialtargets;
}

function private function_78d7002(var_7e6e7f9f, owner, grenadeent) {
  self endoncallback(&function_ac86e0a9, #"death", #"hash_7adffd186663a874");

  if(level.hardcoremode === 1) {
    dot = getstatuseffect(#"hash_5f651c0a59d8c40d");
  } else if(level.gametype == "spy") {
    dot = getstatuseffect(#"hash_4602509692959a4a");
  } else {
    dot = getstatuseffect(#"hash_69c2a47bf2322b6b");
  }

  dot.killcament = grenadeent.killcament;
  dot.sourceent = grenadeent;
  self thread status_effect::status_effect_apply(dot, var_7e6e7f9f, owner, 0, undefined, undefined, grenadeent.origin);
  self playsoundtoplayer(#"hash_569fa11d8a4005ba", self);

  foreach(stage, var_c62d6d34 in level.var_29115f03) {
    self.var_1b05dcde = stage;
    slow = getstatuseffect(var_c62d6d34.slow);
    self thread status_effect::status_effect_apply(slow, var_7e6e7f9f, owner);
    self clientfield::set_to_player("in_tear_gas", stage);
    wait float(slow.seduration) / 1000;
  }
}

function private function_ac86e0a9(notifyhash) {
  if(notifyhash == "death" && isDefined(self)) {
    if(isDefined(self.var_1b05dcde)) {
      var_c62d6d34 = level.var_29115f03[self.var_1b05dcde];
      slow = getstatuseffect(var_c62d6d34.slow);
      self status_effect::function_408158ef(slow.setype, slow.var_18d16a6b);
      self.var_1b05dcde = undefined;
    }

    dot = level.hardcoremode === 1 ? getstatuseffect(#"hash_5f651c0a59d8c40d") : getstatuseffect(#"hash_69c2a47bf2322b6b");
    self status_effect::function_408158ef(dot.setype, dot.var_18d16a6b);
    self clientfield::set_to_player("in_tear_gas", 0);
    self.var_2ee59975 = undefined;
  }
}

function private function_9eda41cd(var_160d2855, var_7e6e7f9f, owner) {
  if(isarray(self.var_2ee59975) && isinarray(self.var_2ee59975, var_160d2855)) {
    arrayremovevalue(self.var_2ee59975, var_160d2855);

    if(!self.var_2ee59975.size) {
      self.var_2ee59975 = undefined;
    }
  }

  if(isDefined(self.var_2ee59975)) {
    return;
  }

  self notify(#"hash_7adffd186663a874");

  if(!isDefined(self.var_1b05dcde)) {
    return;
  }

  var_c62d6d34 = level.var_29115f03[self.var_1b05dcde];
  slow = getstatuseffect(var_c62d6d34.slow);
  var_18c0a09d = getstatuseffect(var_c62d6d34.var_18c0a09d);
  dot = level.hardcoremode === 1 ? getstatuseffect(#"hash_5f651c0a59d8c40d") : getstatuseffect(#"hash_69c2a47bf2322b6b");
  self status_effect::function_408158ef(dot.setype, dot.var_18d16a6b);
  self status_effect::function_408158ef(slow.setype, slow.var_18d16a6b);
  self thread status_effect::status_effect_apply(var_18c0a09d, var_7e6e7f9f, owner);
  self clientfield::set_to_player("in_tear_gas", 0);
  self.var_1b05dcde = undefined;
}

function function_a2493473(position, duration, startsound, stopsound, loopsound) {
  var_4af5a2e7 = spawn("script_origin", (0, 0, 1));

  if(isDefined(var_4af5a2e7)) {
    var_4af5a2e7 endon(#"death");
    var_4af5a2e7.origin = position;

    if(isDefined(startsound)) {
      var_4af5a2e7 playSound(startsound);
    }

    if(isDefined(loopsound)) {
      var_4af5a2e7 playLoopSound(loopsound);
    }

    if(duration > 7.5) {
      wait duration - 7.5;
    }

    if(isDefined(stopsound)) {
      thread sound::play_in_space(stopsound, position);
    }

    var_4af5a2e7 stoploopsound(0.5);
    wait 0.5;
    var_4af5a2e7 delete();
  }
}