/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_damage.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\alien\_utility;
#include maps\mp\alien\_perk_utility;

CONST_FALL_DAMAGE_SCALAR = 0.15;

Callback_AlienPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime) {
  if(flag_exist("player_using_vanguard") && flag("player_using_vanguard") && isDefined(self.remoteUAV)) {
    return;
  }

  if(isDefined(level.ancestor_projectile_solo_scalar) && isPlayingSolo() && sWeapon == "alien_ancestor_mp")
    iDamage = iDamage * level.ancestor_projectile_solo_scalar;

  damageAdd = 0;

  if(self maps\mp\alien\_perk_utility::has_perk("perk_rigger", [0, 1, 2, 3, 4]) && is_trap(eInflictor))
    iDamage = 0;

  if(isDefined(eAttacker) && (sWeapon == "alienspit_mp" || sWeapon == "alienspit_gas_mp")) {
    if(isDefined(eAttacker.team) && (self.team == eAttacker.team)) {
      return false;
    }
  }

  current_weapon = self GetCurrentPrimaryWeapon();

  blockable_weapon = (sWeapon == "spider_beam_mp" || sWeapon == "alienspit_mp" || sWeapon == "alienspit_gas_mp" || sWeapon == "spore_beam_mp" || sWeapon == "gargoyle_beam_mp" || sWeapon == "alien_ancestor_mp");
  if(blockable_weapon && sHitLoc == "shield" && !isDefined(self.spider_shield_block))
    self thread riotshieldAmmoDeplete();

  if(sWeapon == "spider_beam_mp" && isPlayingSolo() && isDefined(level.spider) && !isDefined(level.spider.has_fired_beam))
    iDamage = int(iDamage * 0.17);

  if(sMeansOfDeath == "MOD_TRIGGER_HURT") {
    maps\mp\alien\_death::onPlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime);
  } else if(shouldTakeDamage(eAttacker)) {
    isFriendlyFire = maps\mp\gametypes\_damage::isFriendlyFire(self, eAttacker);

    if(!isFriendlyFire && isDefined(eAttacker) && eAttacker != self)
      iDamage = int(iDamage * level.cycle_damage_scalar);

    if(isDefined(eAttacker) && eAttacker == self) {
      switch (sWeapon) {
        case "alienmortar_strike_mp":
        case "iw6_alienmk321_mp":
        case "iw6_alienmk322_mp":
        case "iw6_alienmk323_mp":
        case "iw6_alienmk324_mp":
        case "alienims_projectile_mp":
        case "alienims_projectileradius_mp":
        case "alienims_projectiledamage_mp":
        case "switchblade_rocket_mp":
        case "switchblade_baby_mp":
        case "switchblade_babyfast_mp":
        case "alienvulture_mp":
        case "alienbetty_mp":
        case "alienclaymore_mp":
        case "aliensoflam_missle_mp":
        case "iw6_alienmaaws_mp":
        case "alien_semtex_turret_proj":
        case "turret_minigun_alien_shock":
        case "alienvanguard_projectile_mp":
        case "alienvanguard_projectile_mini_mp":
        case "iw6_alienrgm_mp":
        case "iw6_alienpanzerfaust3_mp":
        case "iw6_aliendlc41_mp":
        case "iw6_aliendlc42_mp":
          iDamage = 0;
          break;
        default:
          if(!is_hardcore_mode())
            iDamage = int(min(10, iDamage * 0.05));
          else
            iDamage = int(min(level.ricochetDamageMax, iDamage * 0.10));
          break;
      }
    } else if(isFriendlyFire) {
      if(is_hardcore_mode()) {
        switch (sWeapon) {
          case "alienmortar_strike_mp":
          case "alienims_projectile_mp":
          case "alienims_projectileradius_mp":
          case "alienims_projectiledamage_mp":
          case "switchblade_rocket_mp":
          case "switchblade_baby_mp":
          case "switchblade_babyfast_mp":
          case "alienvulture_mp":
          case "alienvanguard_projectile_mp":
          case "alienvanguard_projectile_mini_mp":
            iDamage = 0;
            break;
        }

        if(is_ricochet_damage()) {
          if(isDefined(eAttacker) && IsPlayer(eAttacker) && isDefined(sHitLoc) && sHitLoc != "shield") {
            if(isDefined(eInflictor))
              eAttacker DoDamage(iDamage, (eAttacker.origin - (0, 0, 50)), eAttacker, eInflictor, sMeansOfDeath);
            else
              eAttacker DoDamage(iDamage, eAttacker.origin, eAttacker);
          }
          iDamage = 0;
        }
      } else {
        iDamage = 0;
      }
    } else if(isDefined(eAttacker) &&
      isDefined(eAttacker.classname) &&
      eAttacker.classname == "scriptable" &&
      isDefined(eAttacker.is_hive) &&
      eAttacker.is_hive) {
      iDamage = 1;
    }
    if(isDefined(eAttacker) && isAgent(eAttacker)) {
      if(sWeapon == "alienbetty_mp" || sWeapon == "alienclaymore_mp")
        iDamage = 0;
    }

    if(sMeansOfDeath == "MOD_EXPLOSIVE" && isDefined(eInflictor) && isDefined(eInflictor.targetname) && (eInflictor.targetname == "scriptable_destructible_barrel" || eInflictor.targetname == "armory_transformer")) {
      iDamage = 3;
    }

    if(sMeansOfDeath == "MOD_FALLING") {
      if(self _hasPerk("specialty_falldamage")) {
        iDamage = 0;
      } else {
        if(iDamage > 10) {
          if(iDamage > (self.health * CONST_FALL_DAMAGE_SCALAR))
            iDamage = int(self.health * CONST_FALL_DAMAGE_SCALAR);
        } else
          iDamage = 0;
      }
    }

    if(isDefined(eAttacker) && eAttacker should_snare(self))
      self applyAlienSnare();

    if(sMeansOfDeath == "MOD_EXPLOSIVE_BULLET") {
      if(!is_hardcore_mode() || (eAttacker == self && shitloc == "none"))
        iDamage = 0;
    }

    if(self has_perk("perk_medic", [3, 4]) && self.isReviving == true) {
      iDamage = Int(iDamage * self perk_GetReviveDamageScalar());
    }

    if(self has_perk("perk_rigger", [3, 4]) && self.isRepairing == true) {
      iDamage = Int(iDamage * self perk_GetRepairDamageScalar());
    }

    if((!isFriendlyFire || (eAttacker == self && is_ricochet_damage())) && isDefined(self.bodyArmorHP) && sMeansOfDeath != "MOD_EXPLOSIVE_BULLET" && !isDefined(self.ability_invulnerable)) {
      self.bodyArmorHP -= (iDamage + damageAdd);
      if(self maps\mp\alien\_perk_utility::has_perk("perk_rigger", [0, 1, 2, 3, 4]) && is_trap(eInflictor))
        iDamage = 0;
      else
        iDamage = 1;
      damageAdd = 0;
      if(self.bodyArmorHP <= 0) {
        iDamage = abs(self.bodyArmorHP);
        damageAdd = 0;
        unsetBodyArmor();
      }
      if(isDefined(eAttacker) && eAttacker != self && eAttacker is_alien_agent() && isDefined(self.bodyArmorHP) && self maps\mp\alien\_persistence::is_upgrade_enabled("stun_armor_upgrade") && sMeansOfDeath == "MOD_UNKNOWN") {
        rand = RandomIntRange(0, 100);
        if(rand <= 25)
          eAttacker thread delayed_stun_damage(self);
      }
    }

    stunFraction = 0.0;

    if(isDefined(eAttacker) && sWeapon == "alien_minion_explosion") {
      if(self maps\mp\alien\_persistence::is_upgrade_enabled("minion_protection_upgrade"))
        iDamage *= 0.8;
    }

    prestige_damage_taken_scalar = self maps\mp\alien\_prestige::prestige_getDamageTakenScalar();

    iDamage *= prestige_damage_taken_scalar;

    iDamage = Int(iDamage);

    isUsingRemoteAndWillBeLowHealth = usingRemoteAndWillBeLowHealth(iDamage);

    if(shouldUseInvulnerability(iDamage, isUsingRemoteAndWillBeLowHealth)) {
      useInvulnerability(iDamage);
    }

    if(isDefined(self.ability_invulnerable)) {
      iDamage = Int(0);
    }

    if(iDamage > 0)
      maps\mp\alien\_hud::playPainOverlay(eAttacker, sWeapon, vDir);

    if(!isFriendlyFire || is_hardcore_mode()) {
      self maps\mp\gametypes\_damage::finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime, stunFraction);
      self notify("player_damaged");
    }

    self maps\mp\alien\_gamescore::update_personal_encounter_performance(maps\mp\alien\_gamescore::get_personal_score_component_name(), "damage_taken", iDamage);

    if(iDamage > 0) {
      level.alienBBData["damage_taken"] += iDamage;

      if(isDefined(eAttacker) && IsAgent(eAttacker)) {
        if(!isDefined(eAttacker.damage_done))
          eAttacker.damage_done = 0;
        else
          eAttacker.damage_done += iDamage;
      }
      self notify("dlc_vo_notify", "pain", self);
      if(!isDefined(level.use_dlc_vo))
        self thread maps\mp\alien\_music_and_dialog::player_pain_vo();
    }

    if(iDamage > 0 && isDefined(eAttacker) && isDefined(level.current_challenge)) {
      if(level.current_challenge == "take_no_damage") {
        maps\mp\alien\_challenge::update_challenge("take_no_damage");
      } else if(level.current_challenge == "no_ancestor_damage" && IsAgent(eAttacker) && isDefined(eAttacker.alien_type) && eAttacker.alien_type == "ancestor") {
        level notify("ancestor_damage_taken");
      } else if(level.current_challenge == "avoid_minion_explosion" && isDefined(eAttacker.model) && eAttacker.model != "alien_seeder" && isDefined(sWeapon) && sWeapon == "alien_minion_explosion") {
        maps\mp\alien\_challenge::update_challenge("avoid_minion_explosion");
      }
    }
  }
}

delayed_stun_damage(attacker) {
  self endon("death");
  attacker endon("death");
  wait 0.05;
  self doDamage(2, self.origin, attacker, undefined, "MOD_MELEE");
}

shouldUseInvulnerability(iDamage, isUsingRemoteAndWillBeLowHealth) {
  DAMAGE_BUFFER_LIMIT = 20;
  if(iDamage == 0)
    return false;
  if(isUsingRemoteAndWillBeLowHealth)
    return true;
  else
    return (self.haveInvulnerabilityAvailable && iDamage > self.health && iDamage < (self.health + DAMAGE_BUFFER_LIMIT));
}

usingRemoteAndWillBeLowHealth(iDamage) {
  USING_REMOTE_LOW_HEALTH_RATIO = 0.2;

  low_health_limit = self.maxhealth * USING_REMOTE_LOW_HEALTH_RATIO;

  return (isUsingRemote() && (iDamage > self.health || (self.health - iDamage) <= low_health_limit));
}

stopUsingRemote() {
  self notify("stop_using_remote");
}

useInvulnerability(iDamage) {
  self.health = iDamage + 1;
  self.haveInvulnerabilityAvailable = false;
}

shouldTakeDamage(attacker) {
  if(isDefined(self.inLastStand) && self.inLastStand)
    return false;

  if(getTime() < self.damageShieldExpireTime)
    return false;

  return true;
}

ALIEN_AP_DAMAGE_SCALAR = 2.0;
ARMOR_PIERCING_UPGRADE_SCALAR = 1.10;

is_alien_agent_damage_allowed(eInflictor, eAttacker, sWeapon, sMeansOfDeath) {
  if(level.gameEnded)
    return false;

  if(during_host_migration())
    return false;

  if(!isDefined(self) || !isReallyAlive(self))
    return false;

  isSpiderWeapon = isDefined(sWeapon) && sWeapon == "spider_beam_mp";
  if(!isSpiderWeapon && isDefined(eAttacker) && isDefined(eAttacker.team) && (self.team == eAttacker.team) && !alienTypeCanDoFriendlyDamage(eAttacker, sWeapon))
    return false;

  if(isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_CRUSH" && isDefined(eInflictor) && isDefined(eInflictor.classname) && eInflictor.classname == "script_vehicle")
    return false;

  if(isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_FALLING")
    return false;

  if(isDefined(self.noTriggerHurt) && self.noTriggerHurt && isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_TRIGGER_HURT")
    return false;

  if(isDefined(eAttacker) && isDefined(eAttacker.classname) && eAttacker.classname == "script_origin" && isDefined(eAttacker.type) && eAttacker.type == "soft_landing")
    return false;

  if(sWeapon == "killstreak_emp_mp")
    return false;

  return true;
}

onAlienAgentDamaged(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  if(self.health < 0) {
    self suicide();
    return false;
  }

  if(isDefined(eAttacker) && isPlayer(eAttacker) && sMeansofDeath != "MOD_MELEE" && eAttacker maps\mp\alien\_persistence::is_upgrade_enabled("sniper_soft_upgrade") && getweaponclass(sWeapon) == "weapon_sniper")
    sHitLoc = "soft";

  if(!is_alien_agent_damage_allowed(eInflictor, eAttacker, sWeapon, sMeansOfDeath))
    return false;

  iDamage = scale_alien_damage_func(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);

  if(isDefined(level.custom_scale_alien_damage_func))
    iDamage = [
      [level.custom_scale_alien_damage_func]
    ](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);

  if(isDefined(level.custom_OnAlienAgentDamaged_func))
    iDamage = [
      [level.custom_OnAlienAgentDamaged_func]
    ](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);

  if(sMeansOfDeath == "MOD_MELEE" && level.players.size == 1)
    iDamage = Int(iDamage * 0.9);

  is_burning_damage = false;
  if(isDefined(eAttacker) && isDefined(eAttacker.burning_victim) && eAttacker.burning_victim) {
    is_burning_damage = eAttacker.burning_victim;
    eAttacker.burning_victim = undefined;
  }

  if(isDefined(eAttacker) && isPlayer(eAttacker)) {
    if(sMeansOfDeath == "MOD_MELEE") {
      if(eAttacker maps\mp\alien\_persistence::is_upgrade_enabled("shock_melee_upgrade") && is_true(eAttacker.meleeStrength) && (WeaponType(sWeapon) != "riotshield"))
        eAttacker thread stun_zap_aliens(self.origin, self, (iDamage), sMeansofDeath);
    } else if(eAttacker has_stun_ammo(sWeapon) && eAttacker maps\mp\alien\_persistence::is_upgrade_enabled("stun_ammo_upgrade") && sMeansOfDeath != "MOD_UNKNOWN")
      eAttacker thread stun_zap_aliens(self.origin, self, iDamage, sMeansofDeath);
  }

  if(isDefined(sWeapon) && sWeapon != "alien_ims_projectile_mp" && isPlayer(eAttacker) && eAttacker _hasPerk("specialty_armorpiercing") && isDefined(sHitloc) && sHitLoc == "armor") {
    if(eAttacker maps\mp\alien\_persistence::is_upgrade_enabled("armor_piercing_upgrade"))
      iDamage = Int(iDamage * ALIEN_AP_DAMAGE_SCALAR * ARMOR_PIERCING_UPGRADE_SCALAR);
    else
      iDamage = Int(iDamage * ALIEN_AP_DAMAGE_SCALAR);
  }

  if(sWeapon == "alienspit_mp" || sWeapon == "alienspit_gas_mp")
    iDamage = Int(iDamage * 5);

  if(isDefined(eAttacker) && isDefined(self.pet) && isDefined(eAttacker.team) && (self.team == eAttacker.team))
    return false;

  maps\mp\alien\_chaos::update_alien_damaged_event(sWeapon);

  iDamage = set_alien_damage_by_weapon_type(sMeansOfDeath, sWeapon, iDamage, eAttacker, iDFlags, vPoint, vDir, sHitLoc, timeOffset, eInflictor);

  if(isPlayer(eAttacker) && !self is_trap(eInflictor)) {
    iDamage = scale_alien_damage_by_perks(eAttacker, iDamage, sMeansOfDeath, sWeapon);
    iDamage = scale_alien_damage_by_weapon_type(eAttacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc);

    if(isDefined(sWeapon))
      self thread maps\mp\alien\_achievement::update_achievement_damage_weapon(sWeapon);
  }

  iDamage = typeSpecificDamageProcessing(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);

  if(iDamage <= 0)
    return false;

  if(isDefined(eAttacker) && eAttacker != self && iDamage > 0 && (!isDefined(sHitLoc) || sHitLoc != "shield")) {
    if(is_burning_damage) {
      typeHit = "standard";
    } else if(isDefined(eInflictor) && eInflictor != eAttacker) {
      if(means_of_explosive_damage(sMeansOfDeath))
        typeHit = "standard";
      else
        typeHit = "none";
    } else if(isDefined(eInflictor) && isDefined(eInflictor.damageFeedback) && eInflictor.damageFeedback == false)
      typeHit = "none";
    else if(!maps\mp\gametypes\_damage::shouldWeaponFeedback(sWeapon))
      typeHit = "none";
    else if(iDFlags & level.iDFLAGS_STUN)
      typeHit = "stun";
    else if(!eAttacker _hasperk("specialty_armorpiercing") && sHitLoc == "armor")
      typeHit = "hitalienarmor";
    else if(sHitloc == "soft")
      typeHit = "hitaliensoft";
    else if(sMeansOfDeath == "MOD_MELEE" && sWeapon == "meleestun_mp")
      typeHit = "meleestun";
    else
      typeHit = "standard";

    if(isDefined(level.attack_heli) && eAttacker == level.attack_heli) {
      iDamage = Int(iDamage * 0.6);
    } else {
      if(isDefined(eAttacker.owner)) {
        eAttacker.owner thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(typeHit);
      } else {
        eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(typeHit);
      }
    }
  }

  iDamage = scale_alien_damage_by_prestige(eAttacker, iDamage);
  update_damage_score(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);

  self maps\mp\alien\_debug::debugTrackDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);

  return self[[self maps\mp\agents\_agent_utility::agentFunc("on_damaged_finished")]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

set_alien_damage_by_weapon_type(sMeansOfDeath, sWeapon, iDamage, eAttacker, iDFlags, vPoint, vDir, sHitLoc, timeOffset, eInflictor) {
  if(isDefined(sWeapon)) {
    if(sWeapon == "xm25_mp" && sMeansOfDeath == "MOD_IMPACT")
      iDamage = 95;

    if(sWeapon == "spider_beam_mp")
      iDamage *= 15;

    if(sWeapon == "alienthrowingknife_mp" && sMeansOfDeath == "MOD_IMPACT") {
      if(maps\mp\alien\_utility::can_hypno(eAttacker, false, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, eInflictor))
        iDamage = 20000;
      else if(self.alien_type != "elite")
        iDamage = 500;
    }
    if(sWeapon == "iw6_alienminigun_mp" ||
      sWeapon == "iw6_alienminigun1_mp" ||
      sWeapon == "iw6_alienminigun2_mp" ||
      sWeapon == "iw6_alienminigun3_mp") {
      iDamage = 55;
    }

    if(sWeapon == "iw6_alienminigun4_mp")
      iDamage = 75;
  }

  return iDamage;
}

update_damage_score(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  if(!isDefined(level.attack_heli) || eAttacker != level.attack_heli) {
    if(isDefined(eAttacker) && isDefined(eAttacker.owner)) {
      maps\mp\alien\_gamescore::giveAssistBonus(eAttacker.owner, (iDamage * 0.75));
    } else if(isDefined(eAttacker) && isDefined(eAttacker.pet) && (eAttacker.pet == 1)) {
      assert(isDefined(eAttacker.owner));
      maps\mp\alien\_gamescore::giveAssistBonus(eAttacker.owner, iDamage);
    } else {
      maps\mp\alien\_gamescore::giveAssistBonus(eAttacker, iDamage);
    }

    if(isDefined(eAttacker) && isDefined(sWeapon)) {
      eAttacker thread maps\mp\alien\_persistence::update_weaponstats_hits(sWeapon, 1, sMeansOfDeath);
      level thread maps\mp\alien\_challenge_function::update_alien_damage_challenge(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, self);
    }
  }

  maps\mp\alien\_gamescore::update_performance_alien_damage(eAttacker, iDamage, sMeansOfDeath);
}

scale_alien_damage_by_weapon_type(eAttacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc) {
  if(isDefined(sHitLoc) && sHitLoc != "none")
    iDamage = check_for_explosive_shotgun_damage(self, iDamage, eAttacker, sWeapon, sMeansOfDeath);

  if(isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_EXPLOSIVE_BULLET" && sHitLoc != "none") {
    if(getweaponclass(sWeapon) == "weapon_shotgun") {
      iDamage += Int(idamage * level.shotgunDamageMod);
    } else {
      iDamage += Int(idamage * level.exploImpactMod);
    }
  }

  return iDamage;
}

scale_alien_damage_by_perks(eAttacker, iDamage, sMeansOfDeath, sWeapon) {
  DAMAGE_BOOSTER_UPGRADE_SCALAR = 1.05;

  if(isBulletDamage(sMeansOfDeath) && !isalienturret(sWeapon)) {
    if(!isAlienTurret(sWeapon)) {
      iDamage = Int(iDamage * eAttacker perk_GetBulletDamageScalar());
    } else if(isAlienTrapTurret(sWeapon)) {
      iDamage = Int(iDamage * eAttacker perk_GetTrapDamageScalar());
    }
    if(isDefined(eAttacker.ability_scalar_bullet)) {
      iDamage = Int(iDamage * eAttacker.ability_scalar_bullet);
    }
  }

  if(sMeansOfDeath == "MOD_EXPLOSIVE")
    iDamage = Int(iDamage * eAttacker perk_GetExplosiveDamageScalar());

  if(sMeansOfDeath == "MOD_MELEE") {
    if(WeaponType(sWeapon) == "riotshield") {
      eAttacker riotshieldAmmoTracker();

    }

    playFXOnTag(level._effect["melee_blood"], eAttacker, "tag_weapon_right");
    iDamage = Int(iDamage * eAttacker perk_GetMeleeScalar());
    if(isDefined(eAttacker.ability_scalar_melee)) {
      iDamage = Int(iDamage * eAttacker.ability_scalar_melee);
    }
  }

  if(eAttacker maps\mp\alien\_persistence::is_upgrade_enabled("damage_booster_upgrade"))
    iDamage = Int(iDamage * DAMAGE_BOOSTER_UPGRADE_SCALAR);

  return iDamage;
}

scale_alien_damage_by_prestige(eAttacker, iDamage) {
  if(isPlayer(eAttacker)) {
    prestige_damage_done_scalar = eAttacker maps\mp\alien\_prestige::prestige_getWeaponDamageScalar();
    iDamage *= prestige_damage_done_scalar;
    iDamage = int(iDamage);
  }

  return iDamage;
}

during_host_migration() {
  return (isDefined(level.hostMigrationTimer));
}

means_of_explosive_damage(sMeansOfDeath) {
  return (sMeansOfDeath == "MOD_EXPLOSIVE" ||
    sMeansOfDeath == "MOD_GRENADE_SPLASH" ||
    sMeansOfDeath == "MOD_GRENADE" ||
    sMeansOfDeath == "MOD_PROJECTILE" ||
    sMeansOfDeath == "MOD_PROJECTILE_SPLASH");
}

check_for_explosive_shotgun_damage(alien, iDamage, eAttacker, sWeapon, sMeansOfDeath) {
  MAX_DIST = 500;
  if(!isDefined(alien) || !isReallyAlive(alien))
    return iDamage;

  if(!isDefined(eAttacker) || !isPlayer(eAttacker) || sMeansOfDeath != "MOD_EXPLOSIVE_BULLET")
    return iDamage;

  if(getWeaponClass(sWeapon) == "weapon_shotgun") {
    dist = Distance(eAttacker.origin, alien.origin);
    scale = max(1, dist / MAX_DIST);
    max_dmg = iDamage * 8;
    scaled_damage = max_dmg * scale;

    if(dist > MAX_DIST)
      return (iDamage);

    return int(scaled_damage);
  }
  return iDamage;
}

typeSpecificDamageProcessing(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  switch (get_alien_type()) {
    case "elite":
      iDamage = maps\mp\agents\alien\_alien_elite::eliteDamageProcessing(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
      break;
    default:
      break;
  }

  return int(iDamage);
}

isAlienNonMannedTurret(weapon) {
  if(!isDefined(weapon))
    return false;

  switch (weapon) {
    case "alien_ball_drone_gun_mp":
    case "alien_ball_drone_gun1_mp":
    case "alien_ball_drone_gun2_mp":
    case "alien_ball_drone_gun3_mp":
    case "alien_ball_drone_gun4_mp":
    case "alienvulture_mp":
    case "alien_sentry_minigun_1_mp":
    case "alien_sentry_minigun_2_mp":
    case "alien_sentry_minigun_3_mp":
    case "alien_sentry_minigun_4_mp":
      return true;
    default:
      return false;
  }
  return false;
}

isAlienTurret(weapon) {
  if(!isDefined(weapon))
    return false;

  switch (weapon) {
    case "alien_ball_drone_gun_mp":
    case "alien_ball_drone_gun1_mp":
    case "alien_ball_drone_gun2_mp":
    case "alien_ball_drone_gun3_mp":
    case "alien_ball_drone_gun4_mp":
    case "alienvulture_mp":
    case "alien_sentry_minigun_1_mp":
    case "alien_sentry_minigun_2_mp":
    case "alien_sentry_minigun_3_mp":
    case "alien_sentry_minigun_4_mp":
    case "sentry_minigun_mp":
    case "alien_manned_gl_turret_mp":
    case "alien_manned_gl_turret1_mp":
    case "alien_manned_gl_turret2_mp":
    case "alien_manned_gl_turret3_mp":
    case "alien_manned_gl_turret4_mp":
    case "alien_manned_minigun_turret_mp":
    case "alien_manned_minigun_turret1_mp":
    case "alien_manned_minigun_turret2_mp":
    case "alien_manned_minigun_turret3_mp":
    case "alien_manned_minigun_turret4_mp":
    case "turret_minigun_alien":
    case "turret_minigun_alien_railgun":
    case "turret_minigun_alien_grenade":
    case "alientank_turret_mp":
    case "alientank_rigger_turret_mp":
      return true;
    default:
      return false;
  }
  return false;
}

isAlienTrapTurret(weapon) {
  if(!isDefined(weapon))
    return false;

  switch (weapon) {
    case "turret_minigun_alien":
    case "turret_minigun_alien_railgun":
    case "turret_minigun_alien_grenade":
    case "alientank_turret_mp":
    case "alientank_rigger_turret_mp":
      return true;
    default:
      return false;
  }
  return false;
}

armorMitigation(vPoint, vDir, sHitLoc) {
  if(type_has_head_armor(self get_alien_type())) {
    return maps\mp\agents\alien\_alien_think::armorMitigation(vPoint, vDir, sHitLoc);
  }

  return 1.0;
}

alienTypeCanDoFriendlyDamage(attacker, sWeapon) {
  if(!isDefined(attacker.alien_type))
    return true;

  if(isDefined(sWeapon) && sWeapon == "spider_beam_mp")
    return true;

  switch (attacker get_alien_type()) {
    case "minion":
      return true;
    default:
      return false;
  }
}

riotshieldAmmoTracker() {
  if(!isDefined(self) || !isAlive(self)) {
    return;
  }
  riot_shield = riotShieldName();

  if(!isDefined(riot_shield) || !self HasWeapon(riot_shield)) {
    return;
  }
  shield_ammo = self GetWeaponAmmoClip(riot_shield);
  self SetWeaponAmmoClip(riot_shield, (shield_ammo - 1));
  self notify("riotshield_melee");
  self SetClientOmnvar("ui_alien_stowed_riotshield_ammo", shield_ammo - 1);
  self playSound("crate_impact");
  Earthquake(0.75, 0.5, self.origin, 100);

  if(self GetWeaponAmmoClip(riot_shield) <= 0) {
    front = true;

    if(self.hasRiotShield && !self.hasRiotshieldequipped)
      front = false;

    self TakeWeapon(riot_shield);
    self.hasRiotShield = false;
    self.hasRiotshieldequipped = false;

    if(front) {
      self DetachShieldModel("weapon_riot_shield_iw6", "tag_weapon_right");
      self IPrintLnBold(&"ALIENS_HANDY_RIOT_DESTROYED");

      weapon_list = self GetWeaponsList("primary");
      Assert(weapon_list.size);
      if(weapon_list.size > 0)
        self SwitchToWeapon(weapon_list[0]);
    } else {
      self DetachShieldModel("weapon_riot_shield_iw6", "tag_shield_back");
      self IPrintLnBold(&"ALIENS_STOWED_RIOT_DESTROYED");
    }

    self setclientomnvar("ui_alien_riotshield_equipped", -1);
  }
}

riotshieldAmmoDeplete() {
  {
    self.spider_shield_block = true;
    self riotshieldAmmoTracker();
    wait 0.4;
    self.spider_shield_block = undefined;
  }
}

check_for_special_damage(enemy, sWeapon, sMeansOfDeath) {
  if(sMeansOfDeath == "MOD_MELEE" && WeaponType(sWeapon) != "riotshield") {
    return;
  }
  if(isDefined(sWeapon) && sWeapon == "alienims_projectile_mp") {
    return;
  }
  if(!isDefined(enemy.is_burning) && IsAlive(enemy)) {
    if(isDefined(self.has_incendiary_ammo) && self.has_incendiary_ammo && sMeansOfDeath != "MOD_UNKNOWN") {
      enemy thread catch_alien_on_fire(self, undefined, undefined, true);
    }

    if((sWeapon == "iw5_alienriotshield4_mp") && self.fireShield == 1.0) {
      enemy thread catch_alien_on_fire(self);
    }

    switch (sWeapon) {
      case "iw6_alienmk324_mp":
      case "iw6_alienmk323_mp":
      case "iw6_alienminigun4_mp":
      case "iw6_alienminigun3_mp":
      case "alienvulture_mp":
      case "alien_manned_gl_turret4_mp":
        enemy thread catch_alien_on_fire(self);
        break;
    }

  } else {
    baseweapon = getRawBaseWeaponName(sWeapon);
    if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[baseweapon]) && self.special_ammocount[baseweapon] > 0) {}
  }

}

catch_alien_on_fire(player, burn_time, total_damage, fire_ammo) {
  self endon("death");

  self maps\mp\alien\_alien_fx::alien_fire_on();
  self damage_alien_over_time(player, burn_time, total_damage, fire_ammo);
  self maps\mp\alien\_alien_fx::alien_fire_off();
}

CONST_BURN_DAMAGE_DEFAULT = 150;
CONST_BURN_DAMAGE_BRUTE = 250;
CONST_BURN_DAMAGE_GOON = 150;
CONST_BURN_DAMAGE_SPITTER = 200;
CONST_BURN_DAMAGE_ELITE = 500;
CONST_BURN_DAMAGE_MINION = 100;

CONST_BURN_TIME_DEFAULT = 3;
CONST_BURN_TIME_BRUTE = 4;
CONST_BURN_TIME_GOON = 3;
CONST_BURN_TIME_SPITTER = 4;
CONST_BURN_TIME_ELITE = 4;
CONST_BURN_TIME_MINION = 2;

CONST_FIRE_AMMO_UPGRADE_TOTAL_DAMAGE_SCALAR = 1.20;

damage_alien_over_time(player, burn_time, total_damage, fire_ammo) {
  self endon("death");

  if(!isDefined(burn_time) && !isDefined(total_damage)) {
    if(self.alien_type == "goon") {
      total_damage = CONST_BURN_DAMAGE_GOON;
      burn_time = CONST_BURN_TIME_GOON;
    } else if(self.alien_type == "brute") {
      total_damage = CONST_BURN_DAMAGE_BRUTE;
      burn_time = CONST_BURN_TIME_BRUTE;
    } else if(self.alien_type == "spitter") {
      total_damage = CONST_BURN_DAMAGE_SPITTER;
      burn_time = CONST_BURN_TIME_SPITTER;
    } else if(self.alien_type == "elite") {
      total_damage = CONST_BURN_DAMAGE_ELITE;
      burn_time = CONST_BURN_TIME_ELITE;
    } else if(self.alien_type == "minion") {
      total_damage = CONST_BURN_DAMAGE_MINION;
      burn_time = CONST_BURN_TIME_MINION;
    } else {
      total_damage = CONST_BURN_DAMAGE_DEFAULT;
      burn_time = CONST_BURN_TIME_DEFAULT;
    }
  } else {
    if(!isDefined(total_damage))
      total_damage = CONST_BURN_DAMAGE_DEFAULT;
    if(!isDefined(burn_time))
      burn_time = CONST_BURN_TIME_DEFAULT;
  }

  if(isDefined(player) && isDefined(fire_ammo) && player maps\mp\alien\_persistence::is_upgrade_enabled("incendiary_ammo_upgrade") && isDefined(fire_ammo)) {
    total_damage = total_damage * CONST_FIRE_AMMO_UPGRADE_TOTAL_DAMAGE_SCALAR;
  }

  total_damage *= level.alien_health_per_player_scalar[level.players.size];

  elapsed_time = 0;
  samples = 6;
  interval_wait = burn_time / samples;
  interval_damage = total_damage / samples;

  for(i = 0; i < samples; i++) {
    wait(interval_wait);
    if(IsAlive(self))
      self DoDamage(interval_damage, self.origin, player, player, "MOD_UNKNOWN");
  }
}

setbodyArmor(optionalArmorValue) {
  self notify("give_light_armor");

  if(isDefined(self.bodyArmorHP))
    unsetbodyArmor();

  self thread removebodyArmorOnDeath();
  self thread removebodyArmorOnMatchEnd();

  self.bodyArmorHP = 150;

  if(isDefined(optionalArmorValue))
    self.bodyArmorHP = optionalArmorValue;
}

removebodyArmorOnDeath() {
  self endon("disconnect");
  self endon("give_light_armor");
  self endon("remove_light_armor");

  self waittill("death");
  unsetbodyArmor();
}

unsetbodyArmor() {
  self.bodyArmorHP = undefined;
  self notify("remove_light_armor");
}

removebodyArmorOnMatchEnd() {
  self endon("disconnect");
  self endon("remove_light_armor");

  level waittill_any("round_end_finished", "game_ended");

  self thread unsetbodyArmor();
}

hasbodyArmor() {
  return (isDefined(self.bodyArmorHP) && self.bodyArmorHP > 0);
}

hasHeavyArmor(player) {
  return (isDefined(player.heavyArmorHP) && (player.heavyArmorHP > 0));
}

setHeavyArmor(armorValue) {
  if(isDefined(armorValue)) {
    self.heavyArmorHP = armorValue;
  }
}

ALIEN_SNARE_AMOUNT = 0.68;
ALIEN_SNARE_AMOUNT_MAX = 0.58;
ALIEN_SNARE_DURATION = 0.80;

applyAlienSnare() {
  self thread applyAlienSnareInternal();
}

applyAlienSnareInternal() {
  self notify("stop_applyAlienSnare");
  self endon("stop_applyAlienSnare");
  self endon("disconnect");
  self endon("death");
  self.alienSnareCount++;
  self.alienSnareSpeedScalar = pow(ALIEN_SNARE_AMOUNT, (self.alienSnareCount + 1) * 0.35);
  self.alienSnareSpeedScalar = max(ALIEN_SNARE_AMOUNT_MAX, self.alienSnareSpeedScalar);
  maps\mp\alien\_perkfunctions::updateCombatSpeedScalar();

  wait ALIEN_SNARE_DURATION;
  self.alienSnareCount = 0;
  self.alienSnareSpeedScalar = 1.0;
  maps\mp\alien\_perkfunctions::updateCombatSpeedScalar();
}

scale_alien_damage_func(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  if(self get_alien_type() == "mammoth")
    iDamage = self adjust_mammoth_damage(iDamage);
  weap_class = getWeaponClass(sWeapon);
  if(level.script == "mp_alien_dlc3" && weap_class != "weapon_pistol") {
    scalar = 1.25;
    if(isBulletDamage(sMeansOfDeath) && !isAlienTurret(sWeapon)) {
      if(isDefined(eAttacker) && isPlayer(eAttacker) && isDefined(sWeapon) && weapon_has_alien_attachment(sWeapon)) {
        if(eAttacker maps\mp\alien\_perk_utility::has_perk("perk_bullet_damage", [0, 1, 2, 3, 4]))
          scalar = 1.15;

        adjusted_damage = int(iDamage * scalar);
        return adjusted_damage;
      }
    }
  }

  return iDamage;
}

adjust_mammoth_damage(damage_amount) {
  if(isDefined(self.burrowing) && self.burrowing)
    return 0;

  return damage_amount;
}

stun_zap_aliens(current_origin, enemy, iDamage, sMeansofDeath) {
  if(isDefined(self.stun_struct)) {
    return;
  }
  dist_sq = 62500;

  aliens = maps\mp\alien\_spawnlogic::get_alive_agents();
  if(isDefined(level.seeder_active_turrets))
    aliens = array_combine(aliens, level.seeder_active_turrets);
  alien_array = [];
  foreach(alien in aliens) {
    if(DistanceSquared(current_origin, alien.origin) < dist_sq)
      alien_array[alien_array.size] = alien;
  }

  if(alien_array.size < 1) {
    return;
  }
  bolt_count = 0;
  max_bolts = 1;

  if(!isDefined(self.stun_struct)) {
    self.stun_struct = spawnStruct();
    self.stun_struct.attack_bolt = spawn("script_model", current_origin);
    self.stun_struct.attack_bolt setModel("tag_origin");
    waitframe();
  }
  self.stun_struct.attack_bolt.origin = current_origin;

  stun_ammo_level = self maps\mp\alien\_persistence::get_dpad_up_level();

  if(isDefined(sMeansofDeath) && sMeansofDeath != "MOD_MELEE")
    max_bolts = max_bolts + stun_ammo_level;
  else {
    max_bolts = 4;
    iDamage = iDamage / 4;
  }

  foreach(alien in alien_array) {
    if(isDefined(alien) && alien != enemy && IsAlive(alien)) {
      alien stun_bolt_death(self, iDamage, sMeansofDeath);
      bolt_count++;
      if(bolt_count >= max_bolts) {
        break;
      }
      wait(.1);
    }
  }

  wait(.05);
  KillFXOnTag(level._effect["stun_attack"], self.stun_struct.attack_bolt, "TAG_ORIGIN");
  KillFXOnTag(level._effect["stun_shock"], self.stun_struct.attack_bolt, "TAG_ORIGIN");
  self.stun_struct.attack_bolt delete();
  self.stun_struct = undefined;
}

stun_bolt_death(player, iDamage, sMeansofDeath) {
  waitframe();
  playFXOnTag(level._effect["stun_attack"], player.stun_struct.attack_bolt, "TAG_ORIGIN");
  playFXOnTag(level._effect["stun_shock"], player.stun_struct.attack_bolt, "TAG_ORIGIN");

  move_spot = undefined;

  if(isDefined(self.alien_type) && self.alien_type == "seeder_spore")
    move_spot = self GetTagOrigin("J_Spore_46");
  else if(isDefined(self) && isalive(self) && has_tag(self.model, "J_SpineUpper"))
    move_spot = self GetTagOrigin("J_SpineUpper");

  if(isDefined(move_spot)) {
    player.stun_struct.attack_bolt moveto(move_spot, .05);
    wait(.05);

    if(isDefined(self) && sMeansofDeath == "MOD_MELEE")
      self playSound("alien_fence_shock");

    wait(.05);

    stun_bolt_damage = int(iDamage / 2);

    if(isDefined(self)) {
      guy_to_hurt = self;
      if(isDefined(self.alien_type) && self.alien_type == "seeder_spore")
        guy_to_hurt = self.coll_model;
      if(isDefined(guy_to_hurt))
        guy_to_hurt doDamage(stun_bolt_damage, self.origin, player, player.stun_struct.attack_bolt, sMeansofDeath);
    }
  }
  stopFXOnTag(level._effect["stun_attack"], player.stun_struct.attack_bolt, "TAG_ORIGIN");
}