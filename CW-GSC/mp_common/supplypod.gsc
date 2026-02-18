/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\supplypod.gsc
***********************************************/

#using script_7f6cd71c43c45c57;
#using scripts\abilities\ability_player;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\draft;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;
#namespace supplypod;

function private autoexec __init__system__() {
  system::register(#"supplypod", &preinit, undefined, &finalize, #"killstreaks");
}

function private preinit() {
  if(!isDefined(game.var_6ccfdacd)) {
    game.var_6ccfdacd = 0;
  }

  level.var_934fb97 = spawnStruct();
  level.var_934fb97.var_27fce4c0 = [];
  level.var_934fb97.audiothrottletracker = [];
  level.var_934fb97.bundle = getscriptbundle("killstreak_supplypod");
  level.var_934fb97.weapon = getweapon("gadget_supplypod");
  level.var_934fb97.var_ff101fac = getweapon(#"supplypod_catch");
  level.var_dc8edcba = &function_827486aa;
  level.var_49ef5263 = &function_49ef5263;
  level.hintobjectivehint_updat = &hintobjectivehint_updat;
  setupcallbacks();
  setupclientfields();
  deployable::register_deployable(level.var_934fb97.weapon, &function_1f8cd247);
  globallogic_score::register_kill_callback(level.var_934fb97.weapon, &function_92856c6);
  globallogic_score::function_c1e9b86b(level.var_934fb97.weapon, &function_8d653231);
}

function finalize() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](level.var_934fb97.weapon, &function_bff5c062);
  }
}

function function_127fb8f3(supplypod, attackingplayer) {
  attackingplayer.gameobject gameobjects::allow_use(#"group_none");

  if(isDefined(level.var_86e3d17a)) {
    _station_up_to_detention_center_triggers = [[level.var_86e3d17a]]();

    if((isDefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) > 0) {
      attackingplayer notify(#"cancel_timeout");
      attackingplayer thread weaponobjects::weapon_object_timeout(attackingplayer.var_2d045452, _station_up_to_detention_center_triggers);
    }
  }
}

function function_bff5c062(supplypod, attackingplayer) {
  if(!isDefined(supplypod.gameobject)) {
    return;
  }

  original_owner = supplypod.owner;
  supplypod.owner weaponobjects::hackerremoveweapon(supplypod);
  supplypod.owner function_890b2784();
  supplypod.owner = attackingplayer;
  supplypod setowner(attackingplayer);
  supplypod setteam(attackingplayer getteam());
  supplypod.team = attackingplayer getteam();
  supplypod.gameobject gameobjects::set_owner_team(attackingplayer.team);
  supplypod.gameobject gameobjects::set_visible(#"group_friendly");
  supplypod.gameobject gameobjects::allow_use(#"group_friendly");
  supplypod notify(#"hash_523ddcbd662010e5");
  supplypod notify(#"hacked");

  if(isDefined(supplypod.var_2d045452)) {
    supplypod.var_2d045452 notify(#"hacked");
  }

  supplypod thread watchfordamage();
  supplypod thread watchfordeath();
  var_a87deb22 = 1;

  if(!level.teambased) {
    supplypod.gameobject.trigger setteamfortrigger(supplypod.team);
  }

  if(isDefined(level.var_f1edf93f) && isDefined(supplypod.var_2d045452)) {
    _station_up_to_detention_center_triggers = [[level.var_f1edf93f]]();

    if(isDefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
      supplypod.var_2d045452 notify(#"cancel_timeout");

      if(isDefined(original_owner)) {
        watcher = original_owner weaponobjects::getweaponobjectwatcherbyweapon(supplypod.var_2d045452.weapon);

        if(isDefined(watcher)) {
          supplypod.var_2d045452 thread weaponobjects::function_6d8aa6a0(attackingplayer, watcher);
          supplypod.var_2d045452 thread weaponobjects::weapon_object_timeout(watcher, _station_up_to_detention_center_triggers);
          var_a87deb22 = 0;
        }
      }
    }
  }

  if(isDefined(level.var_fc1bbaef)) {
    [[level.var_fc1bbaef]](supplypod);
  }

  level.var_934fb97.supplypods[supplypod.objectiveid] = supplypod;

  if(!isDefined(level.var_934fb97.var_27fce4c0[attackingplayer.clientid])) {
    level.var_934fb97.var_27fce4c0[attackingplayer.clientid] = [];
  }

  var_a7edcaed = level.var_934fb97.var_27fce4c0.size + 1;
  array::push(level.var_934fb97.var_27fce4c0[attackingplayer.clientid], supplypod, var_a7edcaed);

  if(var_a87deb22) {
    supplypod thread function_827486aa(0);
  }
}

function function_29de6f1f(weapon, meansofdeath = undefined) {
  baseweapon = weapons::getbaseweapon(weapon);
  var_62c1bfaa = weapon.inventorytype == "ability" && weapon.offhandslot == "Special";
  islethalgrenade = weapon.inventorytype == "offhand" && weapon.offhandslot == "Lethal grenade";
  istacticalgrenade = weapon.inventorytype == "offhand" && weapon.offhandslot == "Tactical grenade";
  iskillstreak = isDefined(killstreaks::get_from_weapon(weapon));
  ismelee = isDefined(meansofdeath) && (meansofdeath == # "mod_melee" || meansofdeath == # "mod_melee_weapon_butt");
  var_4ea2a976 = weapon.name == "launcher_standard_t9" || weapon.name == "sig_buckler_dw" || weapon.name == "briefcase_bomb";

  if(var_62c1bfaa || islethalgrenade || istacticalgrenade || iskillstreak || ismelee || var_4ea2a976) {
    return false;
  }

  return true;
}

function function_49ef5263() {
  if(self function_e8e1d88e() > 0) {
    return true;
  }

  return false;
}

function hintobjectivehint_updat(weapon) {
  if(!isDefined(self) || !isPlayer(self) || !self function_49ef5263() || !isDefined(weapon) || weapon.name != "launcher_standard_t8") {
    return;
  }

  scoreevents::processscoreevent(#"golden_kill_bonus", self, undefined, level.var_934fb97.weapon);

  if(isDefined(self.var_bfeea3dd) && isalive(self.var_bfeea3dd) && self != self.var_bfeea3dd && self.team == self.var_bfeea3dd.team) {
    scoreevents::processscoreevent(#"hash_131b23d720fc82c3", self.var_bfeea3dd, undefined, level.var_934fb97.weapon);

    if(isDefined(level.var_b7bc3c75.var_e2298731)) {
      self.var_bfeea3dd[[level.var_b7bc3c75.var_e2298731]]();
    }
  }

  self playlocalsound(#"hash_6c2a2fee191330a0");
}

function function_92856c6(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(!isDefined(victim) || !isDefined(weapon) || !isDefined(meansofdeath)) {
    return false;
  }

  if(!function_29de6f1f(attackerweapon, meansofdeath)) {
    return false;
  }

  if(victim function_49ef5263()) {
    if(isDefined(victim.var_bfeea3dd) && isalive(victim.var_bfeea3dd) && victim != victim.var_bfeea3dd && victim.team == victim.var_bfeea3dd.team) {
      scoreevents::processscoreevent(#"hash_131b23d720fc82c3", victim.var_bfeea3dd, undefined, level.var_934fb97.weapon);

      if(isDefined(level.var_b7bc3c75.var_e2298731)) {
        victim.var_bfeea3dd[[level.var_b7bc3c75.var_e2298731]]();
      }
    }

    victim playlocalsound(#"hash_6c2a2fee191330a0");
    return true;
  }

  return false;
}

function function_8d653231(params) {
  attacker = params.attacker;
  attacker stats::function_dad108fa(#"hash_816e30933fc24d9", 1);
  attacker stats::function_dad108fa(#"hash_1355b2bc41e3a3d6", 1);
  attacker contracts::increment_contract(#"hash_4804c7317d2347ba");
  attacker stats::function_bcf9602(#"hash_5a979e436e74441", 1, #"hash_6abe83944d701459");
}

function function_f579e72b(watcher) {
  watcher.watchforfire = 1;
  watcher.onspawn = &supplypod_spawned;
  watcher.timeout = float(level.var_934fb97.bundle.ksduration) / 1000;
  watcher.ontimeout = &function_7c0d095c;
  watcher.var_994b472b = &function_f7d9ebce;
  watcher.var_10efd558 = "switched_field_upgrade";
}

function function_f7d9ebce(player) {
  if(!isDefined(self.supplypod)) {
    return;
  }

  self.supplypod.var_8d834202 = 1;
  self.supplypod thread function_827486aa(0);
}

function function_7c0d095c() {
  if(!isDefined(self.supplypod)) {
    return;
  }

  self.supplypod thread function_827486aa(0);
}

function supplypod_spawned(watcher, owner) {
  self endon(#"death");
  self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
  self hide();
  self.canthack = 1;
  self.ignoreemp = 1;
  self.delete_on_death = 1;

  if(!is_true(self.previouslyhacked)) {
    if(isDefined(owner)) {
      owner stats::function_e24eec31(self.weapon, #"used", 1);
      owner notify(#"supplypod");
    }

    self waittilltimeout(0.05, #"stationary");

    if(!owner deployable::location_valid()) {
      owner setriotshieldfailhint();
      self deletedelay();
      return;
    }

    self deployable::function_dd266e08(owner);
    self.var_3823265d = owner.var_3823265d;
    owner.var_3823265d = undefined;
    owner function_63c23d02(watcher, self);
    supplypod = self.supplypod;
    supplypod.var_48d842c3 = 1;
    supplypod.var_515d6dda = 1;
  }
}

function playdeathfx() {
  weaponobjects::function_b4793bda(self, level.var_934fb97.weapon);
  self playSound(level.var_934fb97.bundle.destructionaudio);
}

function function_263be969() {
  weaponobjects::function_f2a06099(self, level.var_934fb97.weapon);
  self playSound(level.var_934fb97.bundle.destructionaudio);
}

function playcommanderaudio(soundbank, team) {
  if(!isDefined(team)) {
    return;
  }

  if(!isDefined(level.var_934fb97.audiothrottletracker[team])) {
    level.var_934fb97.audiothrottletracker[team] = 0;
  }

  lasttimeplayed = level.var_934fb97.audiothrottletracker[team];

  if(lasttimeplayed != 0 && gettime() < int(5 * 1000) + lasttimeplayed) {
    return;
  }

  level.var_934fb97.audiothrottletracker[team] = gettime();
}

function setupclientfields() {
  clientfield::register("scriptmover", "supplypod_placed", 1, 1, "int");
}

function private setupcallbacks() {
  ability_player::register_gadget_activation_callbacks(35, &supplypod_on, &supplypod_off);
  callback::on_spawned(&on_player_spawned);
  weaponobjects::function_e6400478(#"gadget_supplypod", &function_f579e72b, 1);
}

function on_player_spawned() {
  player = self;
  player.var_2383a10c = [];
  self function_46d74bb7(0);
  changedteam = isDefined(player.var_29fdd9dd) && player.team != player.var_29fdd9dd;

  if((isDefined(player.var_228b6835) ? player.var_228b6835 : 0) || changedteam || (isDefined(level.var_934fb97.bundle.var_18ede0bb) ? level.var_934fb97.bundle.var_18ede0bb : 0)) {
    player.var_17d74a5c = undefined;
    player.var_29fdd9dd = undefined;
    player.var_48107b1c = undefined;
    player function_a0814839(0);
  }

  if(isDefined(player.var_17d74a5c)) {
    if(isDefined(player.var_57de9100)) {
      player.var_57de9100.trigger setinvisibletoplayer(player);
    }

    player thread function_18f999b5(float(player.var_17d74a5c) / 1000);
    player.var_17d74a5c += gettime();
    player function_3ea286();
  }
}

function function_46d74bb7(var_70150641) {
  if(isDefined(var_70150641) ? var_70150641 : 0) {
    players = getplayers(self.team);
  } else {
    players = getplayers();
  }

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    assert(isDefined(player.clientid));

    if(!isDefined(player.clientid)) {
      continue;
    }

    pods = level.var_934fb97.var_27fce4c0[player.clientid];

    if(isDefined(pods)) {
      foreach(pod in pods) {
        if(!isDefined(pod)) {
          continue;
        }

        if(isDefined(pod.gameobject)) {
          gameobject = pod.gameobject;

          if(!(isDefined(level.var_934fb97.bundle.var_82fccdb8) ? level.var_934fb97.bundle.var_82fccdb8 : 0) && isDefined(self.var_2383a10c[gameobject.entnum]) && self.var_2383a10c[gameobject.entnum] >= level.var_934fb97.bundle.var_186e07b5) {
            continue;
          }

          pod.gameobject.trigger setvisibletoplayer(self);
        }
      }
    }
  }
}

function supplypod_on(slot, playerweapon) {
  assert(isPlayer(self));
  self notify(#"start_killstreak", {
    #weapon: playerweapon
  });
}

function supplypod_off(slot, weapon) {}

function getobjectiveid() {
  return gameobjects::get_next_obj_id();
}

function deleteobjective(objectiveid) {
  if(isDefined(objectiveid)) {
    objective_delete(objectiveid);
    gameobjects::release_obj_id(objectiveid);
  }
}

function function_890b2784() {
  indextoremove = undefined;

  for(index = 0; index < level.var_934fb97.var_27fce4c0[self.clientid].size; index++) {
    if(level.var_934fb97.var_27fce4c0[self.clientid][index] == self) {
      indextoremove = index;
    }
  }

  if(isDefined(indextoremove)) {
    level.var_934fb97.var_27fce4c0[self.clientid] = array::remove_index(level.var_934fb97.var_27fce4c0[self.clientid], indextoremove, 0);
  }
}

function function_827486aa(destroyedbyenemy, var_7497ba51 = 1) {
  self notify(#"hash_523ddcbd662010e5");
  self.var_ab0875aa = 1;

  if(isDefined(self.var_83d9bfb5) && self.var_83d9bfb5) {
    return;
  }

  deleteobjective(self.objectiveid);
  deleteobjective(self.var_134eefb9);
  self.var_83d9bfb5 = 1;
  level.var_934fb97.supplypods[self.objectiveid] = undefined;
  self clientfield::set("enemyequip", 0);

  if(isDefined(self.gameobject)) {
    self.gameobject thread gameobjects::destroy_object(1, 1);
  }

  self function_890b2784();

  if(isDefined(self.owner)) {
    if(game.state == # "playing") {
      if(is_true(destroyedbyenemy)) {
        self.owner globallogic_score::function_5829abe3(self.var_846acfcf, self.var_d02ddb8e, level.var_934fb97.weapon);
      }
    }
  }

  if(var_7497ba51 && self.var_8d834202 === 1) {
    wait(isDefined(level.var_934fb97.bundle.var_fd663ee0) ? level.var_934fb97.bundle.var_fd663ee0 : 0) / 1000;
  }

  profilestart();
  function_9d4aabb9(destroyedbyenemy);
  profilestop();
}

function function_9d4aabb9(destroyedbyenemy) {
  if(!isDefined(self)) {
    return;
  }

  player = self.owner;

  if(isDefined(self.var_846acfcf) && isDefined(player) && self.var_846acfcf != player) {
    self battlechatter::function_d2600afc(self.var_846acfcf, player, level.var_934fb97.weapon, self.var_d02ddb8e);
  }

  if(game.state == # "playing") {
    if(self.health <= 0) {
      if(isDefined(level.var_934fb97.bundle.destructionaudio)) {
        self playSound(level.var_934fb97.bundle.destructionaudio);
      }
    }

    if(is_true(destroyedbyenemy)) {
      if(isDefined(player)) {
        var_f3ab6571 = self.owner weaponobjects::function_8481fc06(level.var_934fb97.weapon) > 1;
        self.owner thread globallogic_audio::function_6daffa93(level.var_934fb97.weapon, var_f3ab6571);
      }

      if(isPlayer(self.var_846acfcf)) {
        self.var_846acfcf challenges::destroyedequipment(self.var_d02ddb8e);
      }

      playcommanderaudio(level.var_934fb97.bundle.var_2ee73347, self.team);
      playcommanderaudio(level.var_934fb97.bundle.var_79efc1, util::getotherteam(self.team));
    } else {
      playcommanderaudio(level.var_934fb97.bundle.var_10c9ba2d, self.team);
      playcommanderaudio(level.var_934fb97.bundle.var_f29e64de, util::getotherteam(self.team));
    }
  }

  if(self.var_8d834202 === 1) {
    function_263be969();
  } else {
    playdeathfx();
  }

  if(isDefined(level.var_934fb97.bundle.var_bb6c29b4) && isDefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
    playFX(level.var_934fb97.bundle.var_bb6c29b4, self.origin);
  }

  deployable::function_81598103(self);

  if(isDefined(self.var_2d045452)) {
    self.var_2d045452 delete();
  }

  self stoploopsound();
  self notify(#"supplypod_removed");
  self deletedelay();
}

function private function_5761966a(supplypod) {
  player = self;
  player endon(#"disconnect");
  level endon(#"game_ended");
  supplypod endon(#"supplypod_removed");

  if(!isDefined(supplypod.var_7b7607df[player.clientid])) {
    return;
  }

  objective_setvisibletoplayer(supplypod.var_134eefb9, player);

  while(isDefined(supplypod.var_7b7607df[player.clientid]) && supplypod.var_7b7607df[player.clientid] > gettime()) {
    timeremaining = float(supplypod.var_7b7607df[player.clientid] - gettime()) / 1000;

    if(timeremaining > 0) {
      wait timeremaining;
    }
  }

  objective_setinvisibletoplayer(supplypod.var_134eefb9, player);
  supplypod.var_7b7607df[player.clientid] = undefined;
}

function private function_3c4843e3(supplypod, timetoadd) {
  supplypod.var_7b7607df[self.clientid] = gettime() + int(timetoadd * 1000);
}

function watchfordeath() {
  level endon(#"game_ended");
  self.owner endon(#"disconnect", #"joined_team", #"changed_specialist");
  self endon(#"hash_523ddcbd662010e5");
  waitresult = self waittill(#"death");

  if(!isDefined(self)) {
    return;
  }

  var_b08a3652 = 1;

  if(isDefined(level.figure_out_attacker)) {
    self.var_846acfcf = self[[level.figure_out_attacker]](waitresult.attacker);
  } else {
    self.var_846acfcf = waitresult.attacker;
  }

  self.var_d02ddb8e = waitresult.weapon;

  if(isDefined(waitresult.attacker) && isDefined(self) && isDefined(self.owner) && waitresult.attacker.team == self.owner.team) {
    var_b08a3652 = 0;
  } else {
    killstreaks::function_e729ccee(waitresult.attacker, waitresult.weapon);
  }

  self thread function_827486aa(var_b08a3652);
}

function watchfordamage() {
  self endon(#"death");
  level endon(#"game_ended");
  self endon(#"hash_523ddcbd662010e5");
  supplypod = self;
  supplypod endon(#"death");
  supplypod.health = level.var_934fb97.bundle.kshealth;
  startinghealth = supplypod.health;

  while(true) {
    waitresult = self waittill(#"damage");

    if((isDefined(level.var_934fb97.bundle.var_4f845dc4) ? level.var_934fb97.bundle.var_4f845dc4 : 0) && isDefined(waitresult.attacker) && isPlayer(waitresult.attacker)) {
      healthprct = supplypod.health / startinghealth;
      objective_setprogress(supplypod.var_134eefb9, healthprct);
      var_adb78fe4 = isDefined(supplypod.var_7b7607df[waitresult.attacker.clientid]);
      waitresult.attacker function_3c4843e3(supplypod, level.var_934fb97.bundle.var_c14832cd);

      if(!var_adb78fe4) {
        waitresult.attacker thread function_5761966a(supplypod);
      }
    }

    if(isDefined(waitresult.attacker) && waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker)) {
      waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
    }
  }
}

function function_8d362deb(einflictor, attacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex) {
  bundle = level.var_934fb97.bundle;
  chargelevel = 0;
  weapon_damage = killstreak_bundles::get_weapon_damage("killstreak_supplypod", bundle.kshealth, vdir, imodelindex, iboneindex, shitloc, psoffsettime, chargelevel);

  if(!isDefined(weapon_damage)) {
    weapon_damage = killstreaks::get_old_damage(vdir, imodelindex, iboneindex, shitloc, 1);
  }

  return int(weapon_damage);
}

function function_438ca4e0() {
  supplypod = self;
  supplypod endon(#"supplypod_removed", #"death");
  level waittill(#"game_ended");

  if(!isDefined(self)) {
    return;
  }

  supplypod.var_8d834202 = 1;
  self thread function_827486aa(0, 0);
  supplypod.var_648955e6 = 1;
}

function function_fec0924() {
  currentid = game.var_6ccfdacd;
  game.var_6ccfdacd += 1;
  return currentid;
}

function function_9abdee8c(watcher, object) {
  player = self;

  if(isDefined(level.var_934fb97.var_27fce4c0[player.clientid]) && level.var_934fb97.var_27fce4c0[player.clientid].size >= (isDefined(level.var_934fb97.bundle.var_cbe1e532) ? level.var_934fb97.bundle.var_cbe1e532 : 1)) {
    obj = level.var_934fb97.var_27fce4c0[player.clientid][0];

    if(isDefined(obj)) {
      obj.var_8d834202 = 1;
      obj thread function_827486aa(0);
    } else {
      level.var_934fb97.var_27fce4c0[self.clientid] = undefined;
    }
  }

  slot = player gadgetgetslot(level.var_934fb97.weapon);
  player gadgetpowerreset(slot);
  player gadgetpowerset(slot, 0);
  supplypod = spawn("script_model", object.origin);
  supplypod function_619a5c20();
  supplypod setModel(level.var_934fb97.weapon.var_22082a57);
  object.supplypod = supplypod;
  supplypod.var_2d045452 = object;
  supplypod setdestructibledef("wpn_t9_eqp_supply_pod_destructible");
  supplypod useanimtree("generic");
  supplypod.owner = player;
  supplypod.clientid = supplypod.owner.clientid;
  supplypod.angles = player.angles;
  supplypod clientfield::set("supplypod_placed", 1);
  supplypod setteam(player getteam());
  supplypod.var_86a21346 = &function_8d362deb;
  supplypod solid();
  supplypod show();
  supplypod.victimsoundmod = "vehicle";
  supplypod.weapon = level.var_934fb97.weapon;
  supplypod setweapon(supplypod.weapon);
  supplypod.maxusecount = isDefined(level.var_934fb97.bundle.var_5a0d87e0) ? level.var_934fb97.bundle.var_5a0d87e0 : 20;
  supplypod.usecount = 0;
  supplypod.objectiveid = getobjectiveid();
  level.var_934fb97.supplypods[supplypod.objectiveid] = supplypod;

  if(!isDefined(level.var_934fb97.var_27fce4c0[player.clientid])) {
    level.var_934fb97.var_27fce4c0[player.clientid] = [];
  }

  var_a7edcaed = level.var_934fb97.var_27fce4c0.size + 1;
  array::push(level.var_934fb97.var_27fce4c0[player.clientid], supplypod, var_a7edcaed);
  supplypod setCanDamage(1);
  supplypod clientfield::set("enemyequip", 1);
  supplypod.builttime = gettime();
  supplypod.uniqueid = function_fec0924();
  playcommanderaudio(level.var_934fb97.bundle.var_69b1ff7, player getteam());
  playcommanderaudio(level.var_934fb97.bundle.deployedenemy, util::getotherteam(player getteam()));

  if(isDefined(level.var_934fb97.bundle.ambientaudio)) {
    supplypod playLoopSound(level.var_934fb97.bundle.ambientaudio);
  }

  if(isDefined(level.var_934fb97.bundle.var_4f845dc4) ? level.var_934fb97.bundle.var_4f845dc4 : 0) {
    supplypod.var_134eefb9 = getobjectiveid();
    supplypod.var_7b7607df = [];
    objective_add(supplypod.var_134eefb9, "active", supplypod.origin, level.var_934fb97.bundle.var_ce75f65c);
    objective_setprogress(supplypod.var_134eefb9, 1);
    objective_setinvisibletoall(supplypod.var_134eefb9);
  }

  triggerradius = level.var_934fb97.bundle.var_366f43e9;
  triggerheight = level.var_934fb97.bundle.var_2f1567fb;
  var_b1a6d849 = level.var_934fb97.bundle.var_2d890f85;
  upangle = vectorscale(vectornormalize(anglestoup(supplypod.angles)), 5);
  var_40989bda = supplypod.origin + upangle;
  usetrigger = spawn("trigger_radius_use", var_40989bda, 0, triggerradius, triggerheight);
  usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
  usetrigger function_49462027(1, 1 | 4096 | 2 | 2097152 | 2048);
  usetrigger function_cb5cf7cb();
  usetrigger usetriggerignoreuseholdtime();
  supplypod.gameobject = gameobjects::create_use_object(#"any", usetrigger, [], undefined, level.var_934fb97.bundle.var_9333131b, 1, 1);
  supplypod.gameobject gameobjects::set_use_time(var_b1a6d849);
  supplypod.gameobject.onbeginuse = &function_8c8fb7b5;
  supplypod.gameobject.onenduse = &function_a1434496;
  supplypod.gameobject.canuseobject = &canuseobject;
  supplypod.gameobject.parentobj = supplypod;
  supplypod.gameobject.var_33d50507 = 1;
  supplypod.gameobject.dontlinkplayertotrigger = 1;
  supplypod.gameobject.keepweapon = 1;
  supplypod.gameobject.requireslos = 1;
  supplypod.gameobject.var_d647eb08 = 1;
  player deployable::function_6ec9ee30(supplypod, level.var_934fb97.weapon);
  supplypod animation::play(#"hash_7540bb5a61e603a");
  supplypod.gameobject gameobjects::set_visible(#"group_all");
  supplypod.gameobject gameobjects::allow_use(#"group_all");

  if(supplypod.gameobject canuseobject(player)) {
    supplypod.gameobject function_a1434496(undefined, player, 1, 1);
  }

  supplypod thread function_438ca4e0();
  supplypod thread watchfordamage();
  supplypod thread watchfordeath();
}

function private function_8c8fb7b5(player) {}

function private function_a143899c(player, waittime) {}

function private function_a1434496(team, player, result, var_d862c76d) {
  supplypod = self.parentobj;

  if(!isDefined(supplypod)) {
    return;
  }

  supplypod.isdisabled = 0;

  if(is_true(result)) {
    var_8a0724f7 = supplypod.team !== player.team;
    supplypod.usecount++;

    if(!isDefined(player.var_2383a10c[self.entnum])) {
      player.var_2383a10c[self.entnum] = 0;
    }

    player.var_2383a10c[self.entnum]++;

    if(isDefined(supplypod.owner) && isPlayer(player) && !var_8a0724f7) {
      if(supplypod.owner != player) {
        scoreevents::processscoreevent(#"hash_69dbfbd660f8c53e", supplypod.owner, undefined, level.var_934fb97.weapon);
        supplypod.owner contracts::increment_contract(#"hash_67f98344b931e7ff");
        supplypod.owner stats::function_dad108fa(#"hash_3d7d26fa33ba6f97", 1);
      }

      player battlechatter::function_fc82b10(level.var_934fb97.weapon, self.origin, self);
    }

    thread function_a143899c(player, 1.5);

    if(var_d862c76d !== 1) {
      player thread gestures::function_f3e2696f(supplypod, level.var_934fb97.var_ff101fac, undefined, 0.5);
    }

    supplypod thread animation::play(#"hash_79647b3513fd2190");
    player function_bcf0dd99();

    if(!(isDefined(level.var_934fb97.bundle.var_82fccdb8) ? level.var_934fb97.bundle.var_82fccdb8 : 0) && player.var_2383a10c[self.entnum] >= level.var_934fb97.bundle.var_186e07b5) {
      self.trigger setinvisibletoplayer(player);
    }

    player.var_57de9100 = self;
    player.var_29fdd9dd = self.team;
    player.var_bfeea3dd = supplypod.owner;
    player notify(#"hash_69dbfbd660f8c53e");

    if(!(isDefined(level.var_934fb97.bundle.var_18ede0bb) ? level.var_934fb97.bundle.var_18ede0bb : 0)) {
      self.trigger setinvisibletoplayer(player);
      duration = isDefined(level.var_934fb97.bundle.var_84471829) ? level.var_934fb97.bundle.var_84471829 : 30;
      player.var_17d74a5c = gettime() + int(duration * 1000);
      player thread function_18f999b5(duration);
    } else {
      player.var_48107b1c = 1;
    }

    if(var_8a0724f7) {
      supplypod.var_846acfcf = player;
      supplypod thread function_827486aa(1);
    } else if(supplypod.usecount == supplypod.maxusecount) {
      supplypod.var_8d834202 = 1;
      supplypod thread function_827486aa(0);
    }

    return;
  }

  thread function_a143899c(player, 0);
}

function canuseobject(user) {
  return user function_f828c1cd();
}

function function_18f999b5(waittime) {
  self notify(#"hash_10cd6a20d4e45365");
  self endon(#"hash_10cd6a20d4e45365", #"disconnect");
  result = self waittilltimeout(waittime, #"death");

  if(result._notify == # "timeout") {
    self function_46d74bb7(1);
  } else if(isDefined(level.var_934fb97.bundle.var_98da26d) ? level.var_934fb97.bundle.var_98da26d : 0) {
    self.var_17d74a5c -= gettime();
  } else {
    self.var_17d74a5c = undefined;
    self.var_bfeea3dd = undefined;
  }

  self function_a0814839(0);
}

function function_1f8cd247(origin, angles, player) {
  if(!isDefined(player.var_3823265d)) {
    player.var_3823265d = spawnStruct();
  }

  var_1898acdc = isDefined(level.var_934fb97.bundle.var_bdc8276) ? level.var_934fb97.bundle.var_bdc8276 : 0;
  testdistance = var_1898acdc * var_1898acdc;
  ids = getarraykeys(level.var_934fb97.var_27fce4c0);

  foreach(id in ids) {
    if(id == player.clientid) {
      continue;
    }

    pods = level.var_934fb97.var_27fce4c0[id];

    foreach(pod in pods) {
      if(!isDefined(pod)) {
        continue;
      }

      distsqr = distancesquared(angles, pod.origin);

      if(distsqr <= testdistance) {
        return false;
      }
    }
  }

  return true;
}

function function_63c23d02(watcher, supplypod) {
  supplypod setvisibletoall();

  if(isDefined(supplypod.othermodel)) {
    supplypod.othermodel setinvisibletoall();
  }

  if(isDefined(supplypod.var_3823265d)) {
    self function_9abdee8c(watcher, supplypod);
  }

  if(isDefined(level.var_84bf013e)) {
    self notify(#"supplypod_placed", {
      #pod: supplypod
    });
  }
}

function oncancelplacement(supplypod) {
  slot = self gadgetgetslot(level.var_934fb97.weapon);
  self gadgetdeactivate(slot, level.var_934fb97.weapon, 0);
  self gadgetpowerset(slot, 100);
}

function function_452147b1(weapon, weaponindex) {
  player = self;
  level endon(#"game_ended");
  player notify("on_death_ammon_backup" + weaponindex);
  player endon("on_death_ammon_backup" + weaponindex, #"disconnect");
  player waittill(#"death");
  player.pers["pod_ammo" + weaponindex] = player getweaponammostock(weapon);
}

function function_5bc9564e(weapon) {
  player = self;
  level endon(#"game_ended");
  player notify(#"hash_620e9c8ce0a79cf7");
  player endon(#"hash_620e9c8ce0a79cf7", #"disconnect");

  while(isDefined(player.pod_ammo) && player.pod_ammo.size > 0) {
    weapon = player getcurrentweapon();
    var_2f9ea2b9 = weapons::getbaseweapon(weapon);
    baseweaponindex = getbaseweaponitemindex(var_2f9ea2b9);

    if(is_true(player.pod_ammo[baseweaponindex])) {
      curammo = player getweaponammostock(weapon);

      if(curammo == 0) {
        player setweaponammostock(weapon, int(player.pod_ammo[baseweaponindex]));
        player.pod_ammo[baseweaponindex] = undefined;
        player thread function_452147b1(weapon, baseweaponindex);
      }
    }

    waitframe(1);
  }
}

function function_740ec27e() {
  player = self;
  primary_weapons = player getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    var_2f9ea2b9 = weapons::getbaseweapon(weapon);
    baseweaponindex = getbaseweaponitemindex(var_2f9ea2b9);
    player.pod_ammo[baseweaponindex] = (isDefined(getgametypesetting(#"hash_1441f7ad44e1cfd4")) ? getgametypesetting(#"hash_1441f7ad44e1cfd4") : 0) * weapon.clipsize;
  }

  player thread function_5bc9564e();
}

function function_bcf0dd99() {
  player = self;
  primary_weapons = player getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    curammo = player getweaponammostock(weapon);
    bonusammo = (isDefined(getgametypesetting(#"hash_1441f7ad44e1cfd4")) ? getgametypesetting(#"hash_1441f7ad44e1cfd4") : 0) * weapon.clipsize;
    player setweaponammostock(weapon, int(curammo + bonusammo));
  }

  player function_3ea286();
}

function function_b8a25634(owner) {
  player = self;
  cooldowns[0] = level.var_934fb97.bundle.var_b9443d6b;
  cooldowns[1] = level.var_934fb97.bundle.var_ea340924;
  cooldowns[2] = level.var_934fb97.bundle.var_ff3d4d40;

  for(slot = 0; slot < 3; slot++) {
    if(!isDefined(cooldowns[slot])) {
      continue;
    }

    if(!isDefined(player._gadgets_player[slot])) {
      continue;
    }

    cooldown = cooldowns[slot] * (isDefined(player._gadgets_player[slot].var_e4d4fa7e) ? player._gadgets_player[slot].var_e4d4fa7e : 0);

    if(is_true(owner)) {
      cooldown *= isDefined(level.var_934fb97.bundle.var_44a195ff) ? level.var_934fb97.bundle.var_44a195ff : 0;
    }

    player gadgetpowerchange(slot, cooldown);
  }
}

function function_de737a35() {
  player = self;

  for(weapon = player getcurrentweapon(); weapon == level.weaponnone; weapon = player getcurrentweapon()) {
    waitframe(1);
  }

  slot = player gadgetgetslot(weapon);

  if(slot == 2 || weapon == getweapon(#"sig_buckler_turret")) {
    if(isDefined(weapon.var_7a93ed37)) {
      player gadgetpowerchange(slot, weapon.var_7a93ed37);
    }

    if(isDefined(weapon.var_60563796)) {
      if(weapon == getweapon(#"sig_buckler_turret") || weapon == getweapon(#"sig_buckler_dw")) {
        stockammo = player getweaponammoclip(weapon);
        player setweaponammoclip(weapon, stockammo + int(weapon.var_60563796));
        return;
      }

      stockammo = player getweaponammostock(weapon);
      player setweaponammostock(weapon, stockammo + int(weapon.var_60563796));
    }
  }
}