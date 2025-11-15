/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\trophy_system.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damage;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\weapons\tacticalinsertion;
#include scripts\weapons\weaponobjects;

#namespace trophy_system;

init_shared() {
  level.trophylongflashfx = #"weapon/fx_trophy_flash";
  level.trophydetonationfx = #"weapon/fx_trophy_detonation";
  level.fx_trophy_radius_indicator = #"weapon/fx_trophy_radius_indicator";
  trophydeployanim = "p8_fxanim_mp_eqp_trophy_system_world_anim";
  trophyspinanim = "p8_fxanim_mp_eqp_trophy_system_world_open_anim";
  level.var_4f3822f4 = &trophysystemdetonate;
  level thread register();
  callback::on_player_killed_with_params(&on_player_killed);
  weaponobjects::function_e6400478(#"trophy_system", &createtrophysystemwatcher, 1);
  callback::on_finalize_initialization(&function_1c601b99);
}

function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon(#"trophy_system"), &function_bff5c062);
  }

  if(isDefined(level.var_a5dacbea)) {
    [[level.var_a5dacbea]](getweapon(#"trophy_system"), &weaponobjects::function_127fb8f3);
  }
}

function_bff5c062(trophysystem, attackingplayer) {
  trophysystem notify(#"hacked");
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
}

function_720ddf7f(func) {
  level.var_ccfcde75 = func;
}

register() {
  clientfield::register("missile", "trophy_system_state", 1, 2, "int");
  clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int");
}

on_player_killed(s_params) {
  attacker = s_params.eattacker;
  weapon = s_params.weapon;

  if(!isDefined(attacker) || !isDefined(weapon)) {
    return;
  }

  if(weapon.name == #"trophy_system") {
    scoreevents::processscoreevent(#"trophy_system_kill", attacker, self, weapon);
  }
}

createtrophysystemwatcher(watcher) {
  watcher.ondetonatecallback = &trophysystemdetonate;
  watcher.activatesound = #"wpn_claymore_alert";
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.activationdelay = 0.1;
  watcher.deleteonplayerspawn = 0;
  watcher.enemydestroy = 1;
  watcher.onspawn = &ontrophysystemspawn;
  watcher.ondamage = &watchtrophysystemdamage;
  watcher.ondestroyed = &ontrophysystemsmashed;
  watcher.var_994b472b = &function_5a4f1e1e;
  watcher.onstun = &weaponobjects::weaponstun;
  watcher.stuntime = 1;
  watcher.ontimeout = &ontrophysystemsmashed;
}

trophysystemstopped() {
  self endon(#"death", #"trophysystemstopped");
  self util::waittillnotmoving();
  self.trophysystemstationary = 1;
  self notify(#"trophysystemstopped");
}

ontrophysystemspawn(watcher, player) {
  player endon(#"disconnect");
  level endon(#"game_ended");
  self endon(#"death");
  self useanimtree("generic");
  self weaponobjects::onspawnuseweaponobject(watcher, player);
  self.trophysystemstationary = 0;
  self.weapon = getweapon(#"trophy_system");
  self.var_2d045452 = watcher;
  self setweapon(self.weapon);
  self.ammo = player ammo_get(self.weapon);
  self thread trophysystemstopped();
  movestate = self util::waittillrollingornotmoving();

  if(movestate == "rolling") {
    self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 1);
    self clientfield::set("trophy_system_state", 1);
  }

  if(!self.trophysystemstationary) {
    trophysystemstopped();
  }

  self.trophysystemstationary = 1;

  if(isalive(player)) {
    player stats::function_e24eec31(self.weapon, #"used", 1);
  }

  self thread trophyactive(player);
  self thread trophywatchhack();
  self util::make_sentient();
  self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 0);
  self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_open_anim", 1);
  self clientfield::set("trophy_system_state", 2);
  self playSound(#"wpn_trophy_deploy_start");
  self playLoopSound(#"wpn_trophy_spin", 0.25);
  self setreconmodeldeployed();
}

setreconmodeldeployed() {
  if(isDefined(self.reconmodelentity)) {
    self.reconmodelentity clientfield::set("trophy_system_state", 2);
  }
}

trophywatchhack() {
  self endon(#"death");
  self waittill(#"hacked");
  self clientfield::set("trophy_system_state", 0);
}

function_5a4f1e1e(player) {
  self thread trophysystemdetonate();
}

ontrophysystemsmashed(attacker, callback_data) {
  playFX(level._equipment_explode_fx_lg, self.origin);
  self playSound(#"dst_trophy_smash");
  var_3c4d4b60 = isDefined(self.owner);

  if(var_3c4d4b60 && isDefined(level.playequipmentdestroyedonplayer)) {
    self.owner[[level.playequipmentdestroyedonplayer]]();
  }

  if(isDefined(attacker) && (!var_3c4d4b60 || self.owner util::isenemyplayer(attacker))) {
    attacker challenges::destroyedequipment();
    scoreevents::processscoreevent(#"destroyed_trophy_system", attacker, self.owner, undefined);
  }

  if(isDefined(level.var_d2600afc)) {
    self[[level.var_d2600afc]](attacker, self.owner, self.weapon);
  }

  self delete();
}

trophyactive(owner) {
  owner endon(#"disconnect");
  self endon(#"death", #"hacked");

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(level.missileentities.size < 1 || isDefined(self.disabled)) {
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

      if(!grenade.weapon.destroyablebytrophysystem) {
        continue;
      }

      if(grenade.destroyablebytrophysystem === 0) {
        continue;
      }

      switch (grenade.model) {
        case #"t6_wpn_grenade_supply_projectile":
          continue;
      }

      if(grenade.weapon == self.weapon) {
        if(isDefined(self.trophysystemstationary) && !self.trophysystemstationary && isDefined(grenade.trophysystemstationary) && grenade.trophysystemstationary) {
          continue;
        }
      }

      if(!isDefined(grenade.owner) && ismissile(grenade)) {
        grenade.owner = getmissileowner(grenade);
      }

      if(isDefined(grenade.owner)) {
        if(level.teambased) {
          if(!grenade.owner util::isenemyteam(owner.team)) {
            continue;
          }
        } else if(grenade.owner == owner) {
          continue;
        }

        if(bullettracepassed(grenade.origin, self.origin + (0, 0, 29), 0, self, grenade, 0, 1)) {
          grenade notify(#"death");

          if(isDefined(level.var_ccfcde75)) {
            owner[[level.var_ccfcde75]](self, grenade);
          }

          fxfwd = grenade.origin - self.origin;

          if(fxfwd == (0, 0, 0)) {
            fxfwd = (1, 0, 0);
          }

          fxup = anglestoup(self.angles);

          if(fxup == (0, 0, 0)) {
            fxup = (0, 0, 1);
          }

          playFX(level.trophylongflashfx, self.origin + (0, 0, 15), fxfwd, fxup);
          owner thread projectileexplode(grenade, self);
          index--;
          self playSound(#"wpn_trophy_alert");

          if(getdvarint(#"player_sustainammo", 0) == 0) {
            if(!isDefined(self.ammo)) {
              self.ammo = 0;
            }

            self.ammo--;

            if(self.ammo <= 0) {
              self thread trophysystemdetonate();
            }
          }
        }
      }
    }
  }
}

projectileexplode(projectile, trophy) {
  self endon(#"death");
  projposition = projectile.origin;
  playFX(level.trophydetonationfx, projposition);
  projectile notify(#"trophy_destroyed");
  trophy radiusdamage(projposition, 128, 105, 10, self);
  scoreevents::processscoreevent(#"trophy_defense", self, projectile.owner, trophy.weapon);
  self function_3170d645(projectile, trophy);
  self challenges::trophy_defense(projposition, 512);

  if(isDefined(level.var_d3a438fb)) {
    if([
        [level.var_d3a438fb]
      ](trophy)) {
      self stats::function_dad108fa(#"hash_707d06184cf09b50", 1);
    }
  }

  if(self util::is_item_purchased(#"trophy_system")) {
    self stats::function_dad108fa(#"destroy_explosive_with_trophy", 1);
  }

  self function_be7a08a8(trophy.weapon, 1);
  projectile delete();
}

_the_root_zurich_spawners(gameobject, trophy) {
  return distancesquared(gameobject.origin, trophy.origin) <= math::pow(512, 2);
}

function_3170d645(projectile, trophy) {
  player = self;
  entities = getentitiesinradius(trophy.origin, 512);
  var_48b7bfeb = 0;

  for(i = 0; i < entities.size; i++) {
    if(!isDefined(self)) {
      return;
    }

    ent = entities[i];

    if(isDefined(ent.owner) && !ent util::isenemyteam(player.team) && (ent.classname === "noclass" || ent.classname === "script_model" || ent.classname === "script_vehicle" || ent.archetype === #"mp_dog" || ent.archetype === #"human" || isDefined(ent.aitype)) && (ent.item !== level.weaponnone || ent.weapon !== level.weaponnone || ent.meleeweapon !== level.weaponnone || ent.turretweapon !== level.weaponnone) && isDefined(ent.takedamage) && ent.takedamage) {
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

      var_2e36557f |= useobj.userate && (!player util::isenemyteam(useobj.claimteam) || useobj.interactteam === #"enemy");

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

      var_2e36557f |= useobj.userate && (!player util::isenemyteam(useobj.claimteam) || useobj.interactteam === #"enemy");

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

      var_2e36557f |= useobj.userate && (!player util::isenemyteam(useobj.claimteam) || useobj.interactteam === #"enemy");

      if(var_2e36557f) {
        break;
      }
    }

    if(var_2e36557f) {
      scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
    }
  }
}

trophydestroytacinsert(tacinsert, trophy) {
  self endon(#"death");
  tacpos = tacinsert.origin;
  playFX(level.trophydetonationfx, tacinsert.origin);
  tacinsert thread tacticalinsertion::tacticalinsertiondestroyedbytrophysystem(self, trophy);
  trophy radiusdamage(tacpos, 128, 105, 10, self);
  scoreevents::processscoreevent(#"trophy_defense", self, undefined, trophy.weapon);

  if(self util::is_item_purchased(#"trophy_system")) {
    self stats::function_dad108fa(#"destroy_explosive_with_trophy", 1);
  }

  self function_be7a08a8(trophy.weapon, 1);
}

trophysystemdetonate(attacker, weapon, target) {
  if(!isDefined(weapon) || !weapon.isemp) {
    playFX(level._equipment_explode_fx_lg, self.origin);
  }

  if(isDefined(attacker) && self.owner util::isenemyplayer(attacker)) {
    attacker challenges::destroyedequipment(weapon);
    scoreevents::processscoreevent(#"destroyed_trophy_system", attacker, self.owner, weapon);

    if(isDefined(level.var_d2600afc)) {
      self[[level.var_d2600afc]](attacker, self.owner, self.weapon, weapon);
    }
  }

  playsoundatposition(#"exp_trophy_system", self.origin);
  self delete();
}

watchtrophysystemdamage(watcher) {
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

    if(!isplayer(attacker)) {
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
        attacker damagefeedback::update();
      }
    }

    if(type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
      self.damagetaken = damagemax;
    } else {
      self.damagetaken += damage;
    }

    if(self.damagetaken >= damagemax) {
      watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
      return;
    }
  }
}

ammo_scavenger(weapon) {
  self ammo_reset();
}

ammo_reset() {
  self._trophy_system_ammo1 = undefined;
  self._trophy_system_ammo2 = undefined;
}

ammo_get(weapon) {
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

ammo_weapon_pickup(ammo) {
  if(isDefined(ammo)) {
    if(isDefined(self._trophy_system_ammo1)) {
      self._trophy_system_ammo2 = self._trophy_system_ammo1;
      self._trophy_system_ammo1 = ammo;
      return;
    }

    self._trophy_system_ammo1 = ammo;
  }
}

ammo_weapon_hacked(ammo) {
  self ammo_weapon_pickup(ammo);
}