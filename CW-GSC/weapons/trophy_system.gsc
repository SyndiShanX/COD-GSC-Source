/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\trophy_system.gsc
***********************************************/

#using script_1435f3c9fc699e04;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weaponobjects;
#namespace trophy_system;

function init_shared() {
  level.trophydetonationfx = # "hash_7e2c1749cc5fcfb9";
  level.fx_trophy_radius_indicator = # "weapon/fx_trophy_radius_indicator";
  trophydeployanim = "p8_fxanim_mp_eqp_trophy_system_world_anim";
  trophyspinanim = "p8_fxanim_mp_eqp_trophy_system_world_open_anim";
  level.var_4f3822f4 = &trophysystemdetonate;
  level thread register();
  callback::on_player_killed(&on_player_killed);
  callback::on_spawned(&ammo_reset);
  weaponobjects::function_e6400478(#"trophy_system", &createtrophysystemwatcher, 1);
  callback::on_finalize_initialization(&function_1c601b99);
}

function function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon(#"trophy_system"), &function_bff5c062);
  }
}

function function_bff5c062(trophysystem, attackingplayer) {
  trophysystem notify(#"hacked");
  var_f3ab6571 = trophysystem.owner weaponobjects::function_7cdcc8ba(trophysystem.var_2d045452) > 1;
  trophysystem.owner thread globallogic_audio::function_a2cde53d(trophysystem.weapon, var_f3ab6571);
  trophysystem.owner weaponobjects::hackerremoveweapon(trophysystem);
  trophysystem.team = attackingplayer.team;
  trophysystem setteam(attackingplayer.team);
  trophysystem.owner = attackingplayer;
  trophysystem setowner(attackingplayer);
  trophysystem thread trophyactive(attackingplayer);
  trophysystem weaponobjects::function_386fa470(attackingplayer);

  if(isDefined(trophysystem) && isDefined(level.var_f1edf93f)) {
    _station_up_to_detention_center_triggers = [[level.var_f1edf93f]]();

    if(isDefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
      trophysystem notify(#"cancel_timeout");
      trophysystem thread weaponobjects::weapon_object_timeout(trophysystem.var_2d045452, _station_up_to_detention_center_triggers);
    }
  }

  trophysystem thread weaponobjects::function_6d8aa6a0(attackingplayer, trophysystem.var_2d045452);

  if(isDefined(trophysystem) && isDefined(level.var_fc1bbaef)) {
    [[level.var_fc1bbaef]](trophysystem);
  }

  if(isDefined(level.var_b7bc3c75.var_1d3ef959)) {
    attackingplayer[[level.var_b7bc3c75.var_1d3ef959]]();
  }
}

function function_720ddf7f(func) {
  level.var_ccfcde75 = func;
}

function register() {
  clientfield::register("missile", "" + # "hash_644cb829d0133e99", 1, 1, "int");
  clientfield::register("missile", "" + # "hash_78a094001c919359", 1, 7, "float");
}

function on_player_killed(s_params) {
  attacker = s_params.eattacker;
  weapon = s_params.weapon;

  if(!isDefined(attacker) || !isDefined(weapon)) {
    return;
  }

  if(weapon.name == # "trophy_system") {
    scoreevents::processscoreevent(#"trophy_system_kill", attacker, self, weapon);
  }
}

function createtrophysystemwatcher(watcher) {
  watcher.ondetonatecallback = &trophysystemdetonate;
  watcher.activatesound = # "wpn_claymore_alert";
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.activationdelay = 0.1;
  watcher.enemydestroy = 1;
  watcher.var_10efd558 = "switched_field_upgrade";
  watcher.onspawn = &ontrophysystemspawn;
  watcher.ondamage = &watchtrophysystemdamage;
  watcher.ondestroyed = &ontrophysystemsmashed;
  watcher.var_994b472b = &function_5a4f1e1e;
  watcher.onstun = &weaponobjects::weaponstun;
  watcher.stuntime = 1;
  watcher.ontimeout = &ontrophysystemsmashed;
}

function trophysystemstopped() {
  self endon(#"death", #"trophysystemstopped");
  self util::waittillnotmoving();
  self.trophysystemstationary = 1;
  self notify(#"trophysystemstopped");
}

function ontrophysystemspawn(watcher, player) {
  player endon(#"disconnect");
  level endon(#"game_ended");
  self endon(#"death");
  self useanimtree("generic");
  self weaponobjects::onspawnuseweaponobject(watcher, player);
  self.trophysystemstationary = 0;
  self.weapon = getweapon(#"trophy_system");
  self.var_2d045452 = watcher;
  self.delete_on_death = 1;
  self.var_48d842c3 = 1;
  self.var_515d6dda = 1;
  self setweapon(self.weapon);
  self.ammo = player ammo_get(self.weapon);
  self.var_bf03cf85 = 0;
  self function_619a5c20();
  player stats::function_e24eec31(self.weapon, #"used", 1);
  player notify(#"hash_50994ef63f120738");
  self thread deployanim();
  self trophysystemstopped();

  if(self depthinwater() > 10) {
    function_3044fc5();
  }

  self thread trophyactive(player);
  self util::make_sentient();

  if(isDefined(player)) {
    player battlechatter::function_fc82b10(getweapon(#"trophy_system"), self.origin, self);
  }
}

function function_5a4f1e1e(player) {
  self thread trophysystemdetonate();
}

function ontrophysystemsmashed(attacker, callback_data) {
  weaponobjects::function_b4793bda(self, self.weapon);
  self playSound(#"exp_trophy_system");
  var_3c4d4b60 = isDefined(self.owner);

  if(var_3c4d4b60 && isDefined(level.playequipmentdestroyedonplayer)) {
    self.owner[[level.playequipmentdestroyedonplayer]]();
  }

  if(isDefined(callback_data) && (!var_3c4d4b60 || self.owner util::isenemyplayer(callback_data))) {
    callback_data challenges::destroyedequipment();
    callback_data challenges::function_24db0c33(undefined, self.weapon);
    scoreevents::processscoreevent(#"destroyed_trophy_system", callback_data, self.owner);
    var_f3ab6571 = self.owner weaponobjects::function_8481fc06(self.weapon) > 1;
    self.owner thread globallogic_audio::function_6daffa93(self.weapon, var_f3ab6571);
  }

  self battlechatter::function_d2600afc(callback_data, self.owner, self.weapon);
  self delete();
}

function trophyactive(owner) {
  owner endon(#"disconnect");
  self endon(#"death", #"hacked");
  traceposition = self.origin + (0, 0, 29);

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(level.missileentities.size < 1 || isDefined(self.disabled) || is_true(self.isjammed)) {
      waitframe(1);
      continue;
    }

    waitframe(1);
    missileents = owner getentitiesinrange(level.missileentities, 512, self.origin);

    for(index = 0; index < missileents.size; index++) {
      if(!isDefined(self)) {
        return;
      }

      grenade = missileents[index];

      if(!isDefined(grenade)) {
        continue;
      }

      if(grenade == self) {
        continue;
      }

      if(is_true(grenade.var_8211c733)) {
        continue;
      }

      if(!grenade.weapon.destroyablebytrophysystem) {
        continue;
      }

      if(grenade.destroyablebytrophysystem === 0) {
        continue;
      }

      if(grenade.weapon == self.weapon) {
        if(is_false(self.trophysystemstationary) && is_true(grenade.trophysystemstationary)) {
          continue;
        }
      }

      if(!isDefined(grenade.owner)) {
        grenade.owner = getmissileowner(grenade);
      }

      if(!isDefined(grenade.owner)) {
        continue;
      }

      if(level.teambased) {
        if(!grenade.owner util::isenemyteam(owner.team)) {
          continue;
        }
      } else if(grenade.owner == owner) {
        continue;
      }

      var_a3e00632 = bullettracepassed(grenade.origin, traceposition, 0, self, grenade, 0, 1);

      if(!var_a3e00632) {
        waitframe(1);
        continue;
      }

      fwd = vectornormalize(grenade.origin - self.origin);

      if(fwd == (0, 0, 0)) {
        fwd = (1, 0, 0);
      }

      angles = vectortoangles(fwd);
      up = anglestoup(angles);
      distance = distance(grenade.origin, traceposition);

      if(distance > 425) {
        fx = # "hash_477d0da44d77c340";
      } else if(distance > 325) {
        fx = # "hash_509348a452bc270b";
      } else if(distance > 225) {
        fx = # "hash_7be30fa46b44c382";
      } else if(distance > 125) {
        fx = # "hash_4f94aa47089274d";
      } else {
        fx = # "hash_6a2339a461182aac";
      }

      playFX(fx, traceposition, fwd, up);
      self playSound(#"hash_59af500c63ca80ac");

      if(getdvarint(#"player_sustainammo", 0) == 0) {
        if(!isDefined(self.ammo)) {
          self.ammo = 0;
        }

        self.ammo--;
      }

      if(isDefined(level.var_ccfcde75)) {
        owner thread[[level.var_ccfcde75]](self, grenade);
      }

      owner projectileexplode(grenade, self, fwd, up);
      self.var_bf03cf85++;
      break;
    }

    if(self.ammo <= 0) {
      if(self.var_bf03cf85 > 1) {
        scoreevents::processscoreevent(#"hash_37f14ae291c32c04", owner, undefined, self.weapon);

        if(self.var_bf03cf85 >= 4) {
          owner contracts::increment_contract(#"hash_6c0438d5a54313d", 1);
        }

        owner stats::function_622feb0d(self.weapon.name, #"hash_1eed93e0c1faa7cf", 1);
      }

      wait 1.5;
      self thread function_3044fc5();
      return;
    }
  }
}

function projectileexplode(projectile, trophy, fxfwd, fxup) {
  if(isDefined(self)) {
    scoreevents::processscoreevent(#"trophy_defense", self, projectile.owner, trophy.weapon);
    self function_3170d645(projectile, trophy);
    self challenges::trophy_defense(projectile.origin, 512, trophy);

    if(isDefined(level.var_d3a438fb)) {
      if([[level.var_d3a438fb]](trophy)) {
        self stats::function_dad108fa(#"hash_707d06184cf09b50", 1);
      }
    }

    if(self util::is_item_purchased(#"trophy_system")) {
      self stats::function_dad108fa(#"destroy_explosive_with_trophy", 1);
    }

    self stats::function_dad108fa(#"hash_37e5b09fc86a64e7", 1);
    self stats::function_dad108fa(#"hash_2757aee498da350f", 1);
    self stats::function_622feb0d(#"trophy_system", #"hash_45668719408ee692", 1);
    self stats::function_6fb0b113(#"trophy_system", #"hash_cac64f745e7f76d");

    if(isvehicle(trophy getgroundent())) {
      self stats::function_dad108fa(#"hash_492f50ceea7d2d5c", 1);
    }
  }

  projposition = projectile.origin;
  playFX(level.trophydetonationfx, projposition, fxfwd, fxup);
  projectile playSound(#"hash_741683e10b98efd8");
  projectile notify(#"trophy_destroyed");

  if(isDefined(trophy)) {
    trophy radiusdamage(projposition, 128, 10, 5, self);
  }

  projectile delete();
}

function _the_root_zurich_spawners(gameobject, trophy) {
  return distancesquared(gameobject.origin, trophy.origin) <= math::pow(512, 2);
}

function function_3170d645(projectile, trophy) {
  player = self;
  entities = getentitiesinradius(trophy.origin, 512);
  var_48b7bfeb = 0;

  for(i = 0; i < entities.size; i++) {
    if(!isDefined(self)) {
      return;
    }

    ent = entities[i];

    if(isDefined(ent.owner) && !ent util::isenemyteam(player.team) && (ent.classname === "noclass" || ent.classname === "script_model" || ent.classname === "script_vehicle" || ent.archetype === # "mp_dog" || ent.archetype === # "human" || isDefined(ent.aitype)) && (ent.item !== level.weaponnone || ent.weapon !== level.weaponnone || ent.meleeweapon !== level.weaponnone || ent.turretweapon !== level.weaponnone) && is_true(ent.takedamage)) {
      if((isDefined(ent.health) ? ent.health : 0) > 0) {
        var_48b7bfeb = 1;
        break;
      }
    }
  }

  if(var_48b7bfeb) {
    scoreevents::processscoreevent(#"hash_1ed8a05490cfe606", player, projectile.owner, trophy.weapon);
  }

  if(isDefined(level.flags)) {
    var_2e36557f = 0;

    foreach(flag in level.flags) {
      useobj = flag.useobj;

      if(!isDefined(useobj) || !_the_root_zurich_spawners(useobj, trophy)) {
        continue;
      }

      var_2e36557f |= useobj.userate && (useobj gameobjects::function_4b64b7fd(player.team) || useobj.interactteam === # "group_enemy");

      if(var_2e36557f) {
        break;
      }
    }

    if(var_2e36557f) {
      scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
    }
  }

  if(isDefined(level.zones)) {
    var_2e36557f = 0;

    foreach(zone in level.zones) {
      useobj = zone.gameobject;

      if(!isDefined(useobj) || !_the_root_zurich_spawners(useobj, trophy)) {
        continue;
      }

      var_2e36557f |= useobj.userate && (useobj gameobjects::function_4b64b7fd(player.team) || useobj.interactteam === # "group_enemy");

      if(var_2e36557f) {
        break;
      }
    }

    if(var_2e36557f) {
      scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
    }
  }

  if(isDefined(level.bombzones)) {
    var_2e36557f = 0;

    foreach(useobj in level.bombzones) {
      if(!isDefined(useobj) || !_the_root_zurich_spawners(useobj, trophy)) {
        continue;
      }

      var_2e36557f |= useobj.userate && (useobj gameobjects::function_4b64b7fd(player.team) || useobj.interactteam === # "group_enemy");

      if(var_2e36557f) {
        break;
      }
    }

    if(var_2e36557f) {
      scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
    }
  }
}

function trophydestroytacinsert(tacinsert, trophy) {
  self endon(#"death");
  tacpos = tacinsert.origin;
  playFX(level.trophydetonationfx, tacinsert.origin);

  if(isDefined(level.var_ef4e178e)) {
    tacinsert thread[[level.var_ef4e178e]](self, trophy);
  }

  trophy radiusdamage(tacpos, 128, 105, 10, self);
  scoreevents::processscoreevent(#"trophy_defense", self, undefined, trophy.weapon);

  if(self util::is_item_purchased(#"trophy_system")) {
    self stats::function_dad108fa(#"destroy_explosive_with_trophy", 1);
  }

  self function_be7a08a8(trophy.weapon, 1);
}

function trophysystemdetonate(attacker, weapon, target) {
  weaponobjects::function_b4793bda(self, self.weapon);

  if(isDefined(weapon) && self.owner util::isenemyplayer(weapon)) {
    weapon challenges::destroyedequipment(target);
    scoreevents::processscoreevent(#"destroyed_trophy_system", weapon, self.owner, target);
    self battlechatter::function_d2600afc(weapon, self.owner, self.weapon, target);
    self.owner globallogic_score::function_5829abe3(weapon, target, self.weapon);
    var_f3ab6571 = self.owner weaponobjects::function_8481fc06(self.weapon) > 1;
    self.owner thread globallogic_audio::function_6daffa93(self.weapon, var_f3ab6571);
  }

  playsoundatposition(#"exp_trophy_system", self.origin);
  self delete();
}

function function_3044fc5() {
  weaponobjects::function_f2a06099(self, self.weapon);
  playsoundatposition(#"exp_trophy_system", self.origin);
  self deletedelay();
}

function watchtrophysystemdamage(watcher) {
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
    damage = waitresult.amount;
    type = waitresult.mod;
    weapon = waitresult.weapon;
    attacker = self[[level.figure_out_attacker]](waitresult.attacker);
    damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(level.teambased) {
      if(!sessionmodeiswarzonegame() && !level.hardcoremode && isDefined(self.owner) && !attacker util::isenemyteam(self.owner.team) && self.owner != attacker) {
        continue;
      }
    }

    if(watcher.stuntime > 0 && weapon.dostun) {
      self thread weaponobjects::stunstart(watcher, watcher.stuntime);
    }

    if(damage::friendlyfirecheck(self.owner, attacker)) {
      if(damagefeedback::dodamagefeedback(weapon, attacker)) {
        attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
      }
    }

    if(type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
      self.damagetaken = damagemax;
    } else {
      self.damagetaken += damage;
    }

    if(self.damagetaken >= damagemax) {
      if(util::function_fbce7263(attacker.team, self.team)) {
        killstreaks::function_e729ccee(attacker, weapon);
      }

      watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
      return;
    }
  }
}

function ammo_reset() {
  self._trophy_system_ammo1 = undefined;
  self._trophy_system_ammo2 = undefined;
}

function ammo_get(weapon) {
  totalammo = weapon.ammocountequipment;

  if(isDefined(self._trophy_system_ammo1) && !self util::ishacked()) {
    totalammo = self._trophy_system_ammo1;
    self._trophy_system_ammo1 = undefined;

    if(isDefined(self._trophy_system_ammo2)) {
      self._trophy_system_ammo1 = self._trophy_system_ammo2;
      self._trophy_system_ammo2 = undefined;
    }
  }

  return totalammo;
}

function ammo_weapon_pickup(ammo) {
  if(isDefined(ammo)) {
    if(isDefined(self._trophy_system_ammo1)) {
      self._trophy_system_ammo2 = self._trophy_system_ammo1;
      self._trophy_system_ammo1 = ammo;
      return;
    }

    self._trophy_system_ammo1 = ammo;
  }
}

function deployanim() {
  self endon(#"death");
  self setanim(#"hash_70b2041b1f6ad89", 1, 0, 0);
  self clientfield::set("" + # "hash_644cb829d0133e99", 1);
  self waittill(#"trophysystemstopped");
  wait 0.1;
  self setanim(#"hash_70b2041b1f6ad89");
  self clientfield::set("" + # "hash_644cb829d0133e99", 0);
  self playSound(#"wpn_trophy_deploy_start");
  self playLoopSound(#"hash_656f8209ae1d1424", 0.25);
  wait getanimlength(#"hash_70b2041b1f6ad89");
  self clearanim(#"hash_70b2041b1f6ad89", 0);
  self setanim(#"hash_3c4ee18df7d43dc7", 1, 0, 2);
}