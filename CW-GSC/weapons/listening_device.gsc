/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\listening_device.gsc
***********************************************/

#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;
#namespace listening_device;

function private autoexec __init__system__() {
  system::register(#"listening_device", &init_shared, undefined, undefined, undefined);
}

function init_shared() {
  weaponobjects::function_e6400478("listening_device", &function_2111cf41, 0);
  level.var_81286410 = &function_23fef963;
  level.var_5be42934 = &function_f38fc2a8;
  callback::on_game_playing(&on_game_playing);
  callback::on_weapon_fired(&on_weapon_fired);
  level.var_8ddf6d3d = getscriptbundle(#"listeningdevicesettings");
  level.var_96492769 = getscriptbundle(#"listeningdevicesettings_deadsilence");
  callback::on_finalize_initialization(&function_1c601b99);
  deployable::register_deployable(getweapon("listening_device"));
  clientfield::register("missile", "listening_device_hacked", 1, 1, "counter");
}

function function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon("listening_device"), &function_bff5c062);
  }
}

function function_bff5c062(listening_device, attackingplayer) {
  var_f3ab6571 = listening_device.owner weaponobjects::function_8481fc06(listening_device.weapon) > 1;
  listening_device.owner thread globallogic_audio::function_a2cde53d(listening_device.weapon, var_f3ab6571);
  entnum = listening_device getentitynumber();
  level.var_b7bd6b6d[listening_device.team][entnum] = undefined;
  newteam = attackingplayer.team;
  listening_device.team = newteam;
  listening_device setteam(newteam);
  listening_device.owner = attackingplayer;
  listening_device setowner(attackingplayer);

  if(!isDefined(level.var_b7bd6b6d[newteam])) {
    level.var_b7bd6b6d[newteam] = [];
  }

  level.var_b7bd6b6d[newteam][entnum] = listening_device;

  if(isDefined(listening_device) && isDefined(level.var_f1edf93f)) {
    _station_up_to_detention_center_triggers = [[level.var_f1edf93f]]();

    if(isDefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
      listening_device notify(#"cancel_timeout");
      listening_device thread weaponobjects::weapon_object_timeout(listening_device.var_2d045452, _station_up_to_detention_center_triggers);
    }
  }

  listening_device thread weaponobjects::function_6d8aa6a0(attackingplayer, listening_device.var_2d045452);
  listening_device clientfield::increment("listening_device_hacked");

  if(isDefined(level.var_b7bc3c75.var_1d3ef959)) {
    attackingplayer[[level.var_b7bc3c75.var_1d3ef959]]();
  }
}

function function_2111cf41(watcher) {
  watcher.watchforfire = 1;
  watcher.activatesound = # "wpn_claymore_alert";
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = undefined;
  watcher.immediatedetonation = 1;
  watcher.immunespecialty = "specialty_immunetriggerbetty";
  watcher.var_8eda8949 = (0, 0, 0);
  var_167da8cf = getweapon(#"listening_device");

  if(isDefined(var_167da8cf.customsettings)) {
    var_e6fbac16 = getscriptbundle(var_167da8cf.customsettings);
    assert(isDefined(var_e6fbac16));
  }

  watcher.stuntime = 1;
  watcher.ondetonatecallback = &function_ad011f90;
  watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
  watcher.onspawn = &function_8bdff396;
  watcher.stun = &weaponobjects::weaponstun;
  watcher.var_994b472b = &function_7b26afb;
  watcher.var_10efd558 = "switched_field_upgrade";
  watcher.ondestroyed = &function_8af865a6;
}

function function_ad011f90(attacker, weapon, target) {
  if(isDefined(attacker) && isPlayer(attacker) && attacker != self.owner && attacker.team != self.team) {
    var_f3ab6571 = self.owner weaponobjects::function_8481fc06(self.weapon) > 1;
    self.owner thread globallogic_audio::function_6daffa93(self.weapon, var_f3ab6571);
  }

  weaponobjects::proximitydetonate(attacker, weapon, target);
}

function function_7b26afb(player) {
  self weaponobjects::weaponobjectfizzleout();
}

function function_8bdff396(watcher, player) {
  weaponobjects::onspawnproximitygrenadeweaponobject(watcher, player);
  self.weapon = getweapon(#"listening_device");
  self.var_48d842c3 = 1;
  self.var_515d6dda = 1;
  self function_619a5c20();

  if(!isDefined(level.var_b7bd6b6d)) {
    level.var_b7bd6b6d = [];
  }

  team = player.team;

  if(isDefined(team)) {
    if(!isDefined(level.var_b7bd6b6d[team])) {
      level.var_b7bd6b6d[team] = [];
    }

    level.var_b7bd6b6d[team][self getentitynumber()] = self;
  }

  player battlechatter::function_fc82b10(self.weapon, self.origin, self);
}

function function_8af865a6(attacker, callback_data) {
  weaponobjects::proximitydetonate(callback_data);

  if(isPlayer(callback_data) && callback_data != self.owner && callback_data.team != self.team) {
    callback_data challenges::destroyedequipment();
    callback_data challenges::function_24db0c33(undefined, self.weapon);
    scoreevents::processscoreevent(#"hash_20263a44bc86ab70", callback_data);
    self thread battlechatter::function_d2600afc(callback_data, self.owner, self.weapon);
    var_f3ab6571 = self.owner weaponobjects::function_8481fc06(self.weapon) > 1;
    self.owner thread globallogic_audio::function_6daffa93(self.weapon, var_f3ab6571);
  }
}

function function_23fef963() {
  if(!isDefined(self.team)) {
    return;
  }

  if(!isDefined(level.var_b7bd6b6d[self.team])) {
    level.var_b7bd6b6d[self.team] = [];
  }

  var_c3df74e2 = isDefined(level.var_8ddf6d3d.var_ec25308b) ? level.var_8ddf6d3d.var_ec25308b : 0;
  var_bf170232 = [];

  foreach(device in level.var_b7bd6b6d[self.team]) {
    if(!isDefined(device)) {
      continue;
    }

    if(!var_c3df74e2 && device.owner !== self) {
      continue;
    }

    var_48b7953 = spawnStruct();
    var_48b7953.origin = device.origin;
    var_48b7953.angles = device.angles;
    var_48b7953.owner = device.owner;
    var_48b7953.isjammed = device.isjammed;
    var_48b7953.ishacked = device.ishacked;

    if(!isDefined(var_bf170232)) {
      var_bf170232 = [];
    } else if(!isarray(var_bf170232)) {
      var_bf170232 = array(var_bf170232);
    }

    var_bf170232[var_bf170232.size] = var_48b7953;
  }

  return var_bf170232;
}

function private on_game_playing() {
  level thread function_d993c135();
}

function private on_weapon_fired(params) {
  self.var_bb20a522 = gettime();
  self.var_8c3b7f1a = self.origin;
}

function function_d993c135() {
  self notify("53dba4f7fa8e966f");
  self endon("53dba4f7fa8e966f");
  level endon(#"game_ended");
  pass = 0;
  var_af989ae4 = sqr(level.var_8ddf6d3d.var_293163bd);
  var_84dbcde7 = sqr(level.var_96492769.var_293163bd);
  var_24fcb2d = min(var_af989ae4, var_84dbcde7);
  var_24bfde42 = sqr(level.var_8ddf6d3d.var_9b69c823);
  var_46638976 = sqr(level.var_96492769.var_9b69c823);
  var_3d369b0c = min(var_af989ae4, var_84dbcde7);

  while(true) {
    now = gettime();
    players = getplayers();

    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }

      if(player getentitynumber() & 3 != pass) {
        continue;
      }

      if(!isalive(player)) {
        continue;
      }

      var_92c9c085 = length2dsquared(player getvelocity());

      if(player isplayerswimming() && !player isplayerunderwater()) {
        if(var_92c9c085 < var_3d369b0c) {
          continue;
        }

        var_daf9a500 = var_24bfde42;

        if(player hasperk(#"specialty_sixthsensejammer")) {
          var_daf9a500 = var_84dbcde7;
        }

        if(var_92c9c085 > var_daf9a500) {
          player.var_3ab8ccc9 = now;
          player.var_5550488a = player.origin;
        }

        continue;
      }

      if(var_92c9c085 < var_24fcb2d) {
        continue;
      }

      if(var_92c9c085 > 62500) {
        player.var_e5a19e3d = now;
        player.var_50703880 = player.origin;
        continue;
      }

      minspeedsq = var_af989ae4;

      if(player hasperk(#"specialty_sixthsensejammer")) {
        minspeedsq = var_84dbcde7;
      }

      if(var_92c9c085 > minspeedsq) {
        player.var_3ab8ccc9 = now;
        player.var_5550488a = player.origin;
      }
    }

    pass++;

    if(pass >= 4) {
      pass = 0;
    }

    wait 0.1;
  }
}

function function_f38fc2a8(data) {
  attacker = self;

  if(!isDefined(attacker)) {
    return 0;
  }

  victim = data.victim;

  if(!isDefined(victim)) {
    return 0;
  }

  var_bf170232 = data.var_807875bc;

  if(!isDefined(var_bf170232)) {
    return 0;
  }

  if(!isarray(var_bf170232)) {
    return 0;
  }

  arrayremovevalue(var_bf170232, undefined, 0);

  if(var_bf170232.size == 0) {
    return 0;
  }

  var_ca2cadcd = level.var_8ddf6d3d.var_ec25308b !== 1;
  var_52b5458f = getweapon(#"listening_device");
  var_64c27ffb = 0;
  var_55336d8d = level.var_8ddf6d3d;
  var_c394e130 = level.var_96492769;
  bundle = var_55336d8d;

  if(isPlayer(victim) && victim hasperk(#"specialty_sixthsensejammer")) {
    bundle = var_c394e130;
  }

  range = bundle.var_151e2c9b + 30;
  rangesq = sqr(range);
  var_d6ff0766 = 0;

  if(!isDefined(data.var_a73da413)) {
    data.var_a73da413 = 0;
  }

  if(!isDefined(data.var_c23ee432)) {
    data.var_c23ee432 = 0;
  }

  if(data.time - data.var_a73da413 < 6000) {
    var_d6ff0766 = bundle.var_a8e88375 * range;
    var_a8d3770f = data.var_5f1818be;
  } else if(data.time - data.var_c23ee432 < 6000) {
    if(data.var_f0b3c772 >= 1) {
      var_d6ff0766 = bundle.var_2b6e9133 * range;
    } else if(data.var_e05c79a4) {
      var_d6ff0766 = bundle.var_c26d14da * range;
      var_7aeac1e7 = 1;
    } else if(data.victimstance == "stand") {
      var_d6ff0766 = bundle.var_dbf6038b * range;
      var_7aeac1e7 = 1;
    } else if(data.victimstance == "crouch") {
      var_d6ff0766 = bundle.var_dccff18f * range;
    }

    var_a8d3770f = data.var_dbbf805a;
  }

  if(!isDefined(data.var_9c16cd22)) {
    data.var_9c16cd22 = 0;
  }

  if(data.time - data.var_9c16cd22 < 6000) {
    var_f57f785b = bundle.var_abea5dd8 * range;

    if(weaponhasattachment(data.victimweapon, "suppressed") || weaponhasattachment(data.victimweapon, "suppressed2")) {
      var_f57f785b = bundle.var_301350af * range;
    }

    if(var_f57f785b > var_d6ff0766) {
      var_d6ff0766 = var_f57f785b;
      var_a8d3770f = data.var_5d9be0a1;
    }
  }

  if(!isDefined(var_a8d3770f)) {
    var_a8d3770f = data.victimorigin;
  }

  var_8463af9d = sqr(var_d6ff0766);
  var_7f4e7212 = [];
  var_7a6cbc93 = [];

  foreach(var_48b7953 in var_bf170232) {
    if(!isDefined(var_48b7953.owner)) {
      continue;
    }

    if(var_48b7953.isjammed === 1) {
      continue;
    }

    distcurrentsq = distance2dsquared(var_a8d3770f, var_48b7953.origin);

    if(distcurrentsq > rangesq) {
      continue;
    }

    disttovictim = var_a8d3770f - var_48b7953.origin;

    if(bundle.var_b060dd0c < 180) {
      var_fa4e3cfc = vectornormalize((disttovictim[0], disttovictim[1], 0));

      if(!isDefined(var_48b7953.var_fa4e3cfc)) {
        var_48b7953.var_2a5aebad = anglesToForward((0, var_48b7953.angles[1], 0));
      }

      dot = vectordot(var_fa4e3cfc, var_48b7953.var_2a5aebad);

      if(dot < cos(bundle.var_b060dd0c)) {
        continue;
      }
    }

    if(distcurrentsq > var_8463af9d) {
      continue;
    }

    var_a07d912f = !var_ca2cadcd;

    if(var_48b7953.owner == attacker) {
      if(var_7a6cbc93[var_48b7953.owner getentitynumber()] !== 1) {
        scoreevents::processscoreevent(#"hash_18522e88ad05a3b2", attacker, victim, var_52b5458f);
        attacker contracts::increment_contract(#"hash_327ba388df6e6793");
        attacker stats::function_dad108fa(#"hash_13789554a310aa8f", 1);
        attacker stats::function_dad108fa(#"hash_13789354a310a729", 1);
        attacker stats::function_bcf9602(#"hash_5a979e436e74441", 1, #"hash_6abe83944d701459");

        if(isDefined(level.var_b7bc3c75.var_fbbc4c75)) {
          attacker[[level.var_b7bc3c75.var_fbbc4c75]](var_48b7953);
        }

        challenges::function_7f86a7b8(attacker, data.weapon, data.smeansofdeath);

        if(isDefined(data.weapon) && data.weapon !== level.weaponnone) {
          attacker stats::function_622feb0d(var_52b5458f.name, #"kills", 1);
          attacker stats::function_6fb0b113(var_52b5458f.name, #"best_kills");
        }

        var_7a6cbc93[var_48b7953.owner getentitynumber()] = 1;
      }

      if(attacker.var_fa9604fd !== 1) {
        if(!isDefined(attacker.var_90df1936)) {
          attacker.var_90df1936 = 0;
        }

        if(data.time - attacker.var_90df1936 < 4000) {
          scoreevents::processscoreevent(#"hash_293351f0ab09e08e", attacker, victim, var_52b5458f);
          attacker contracts::increment_contract(#"hash_3ae2c7adca1852f3");
          attacker stats::function_622feb0d(var_52b5458f.name, #"hash_7bf29fa438d54aad", 1);
          attacker.var_fa9604fd = 1;
        }

        attacker.var_90df1936 = data.time;
      }

      var_a07d912f = 0;
    }

    if(var_a07d912f && var_7f4e7212[var_48b7953.owner getentitynumber()] !== 1) {
      scoreevents::processscoreevent(#"hash_573fdf319bb7b7d1", var_48b7953.owner, victim, var_52b5458f);
      var_48b7953.owner stats::function_622feb0d(var_52b5458f.name, #"assists", 1);

      if(isDefined(level.var_b7bc3c75.var_e2298731)) {
        var_48b7953.owner[[level.var_b7bc3c75.var_e2298731]]();
      }

      if(isDefined(level.var_b7bc3c75.var_fbbc4c75)) {
        var_48b7953.owner[[level.var_b7bc3c75.var_fbbc4c75]](var_48b7953);
      }

      var_7f4e7212[var_48b7953.owner getentitynumber()] = 1;
    }
  }
}