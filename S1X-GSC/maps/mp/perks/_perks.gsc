/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\perks\_perks.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\perks\_perkfunctions;

init() {
  level.perkFuncs = [];

  level.specialty_finalstand_icon = "specialty_s1_temp";
  level.specialty_c4_death_icon = "specialty_s1_temp";
  level.specialty_compassping_revenge_icon = "specialty_s1_temp";
  level.specialty_juiced_icon = "specialty_s1_temp";

  level.spawnGlowModel["enemy"] = "static_tactical_insertion_device";
  level.spawnGlowModel["friendly"] = "static_tactical_insertion_device";
  level.spawnGlow["enemy"] = loadfx("vfx/props/tac_insert_enemy");
  level.spawnGlow["friendly"] = loadfx("vfx/props/tac_insert_friendly");

  level.spawnFire = loadfx("vfx/explosion/mp_tac_explosion");
  level._effect["ricochet"] = loadfx("fx/impacts/large_metalhit_1");

  level.scriptPerks = [];

  level.perkSetFuncs = [];
  level.perkUnsetFuncs = [];

  level.scriptPerks["specialty_blastshield"] = true;
  level.scriptPerks["_specialty_blastshield"] = true;
  level.scriptPerks["specialty_akimbo"] = true;
  level.scriptPerks["specialty_falldamage"] = true;
  level.scriptPerks["specialty_shield"] = true;
  level.scriptPerks["specialty_feigndeath"] = true;
  level.scriptPerks["specialty_shellshock"] = true;
  level.scriptPerks["specialty_delaymine"] = true;
  level.scriptPerks["specialty_localjammer"] = true;
  level.scriptPerks["specialty_thermal"] = true;
  level.scriptPerks["specialty_blackbox"] = true;
  level.scriptPerks["specialty_steelnerves"] = true;
  level.scriptPerks["specialty_flashgrenade"] = true;
  level.scriptPerks["specialty_smokegrenade"] = true;
  level.scriptPerks["specialty_concussiongrenade"] = true;
  level.scriptPerks["specialty_saboteur"] = true;
  level.scriptPerks["specialty_endgame"] = true;
  level.scriptPerks["specialty_rearview"] = true;
  level.scriptPerks["specialty_hardline"] = true;
  level.scriptPerks["specialty_onemanarmy"] = true;
  level.scriptPerks["specialty_primarydeath"] = true;
  level.scriptPerks["specialty_secondarybling"] = true;
  level.scriptPerks["specialty_explosivedamage"] = true;
  level.scriptPerks["specialty_laststandoffhand"] = true;
  level.scriptPerks["specialty_dangerclose"] = true;
  level.scriptPerks["specialty_hardjack"] = true;
  level.scriptPerks["specialty_extraspecialduration"] = true;
  level.scriptPerks["specialty_rollover"] = true;
  level.scriptPerks["specialty_armorpiercing"] = true;
  level.scriptPerks["specialty_omaquickchange"] = true;
  level.scriptPerks["_specialty_rearview"] = true;
  level.scriptPerks["_specialty_onemanarmy"] = true;
  level.scriptPerks["specialty_steadyaimpro"] = true;
  level.scriptPerks["specialty_stun_resistance"] = true;
  level.scriptPerks["specialty_double_load"] = true;
  level.scriptPerks["specialty_regenspeed"] = true;
  level.scriptPerks["specialty_twoprimaries"] = true;
  level.scriptPerks["specialty_autospot"] = true;
  level.scriptPerks["specialty_overkillpro"] = true;
  level.scriptPerks["specialty_anytwo"] = true;
  level.scriptPerks["specialty_fasterlockon"] = true;
  level.scriptPerks["specialty_paint"] = true;
  level.scriptPerks["specialty_paint_pro"] = true;
  level.scriptPerks["specialty_silentkill"] = true;

  level.scriptPerks["specialty_crouchmovement"] = true;
  level.scriptPerks["specialty_personaluav"] = true;
  level.scriptPerks["specialty_unwrapper"] = true;

  level.scriptPerks["specialty_class_blindeye"] = true;
  level.scriptPerks["specialty_class_lowprofile"] = true;
  level.scriptPerks["specialty_class_coldblooded"] = true;
  level.scriptPerks["specialty_class_hardwired"] = true;
  level.scriptPerks["specialty_class_scavenger"] = true;
  level.scriptPerks["specialty_class_hoarder"] = true;
  level.scriptPerks["specialty_class_gungho"] = true;
  level.scriptPerks["specialty_class_steadyhands"] = true;
  level.scriptPerks["specialty_class_hardline"] = true;
  level.scriptPerks["specialty_class_peripherals"] = true;
  level.scriptPerks["specialty_class_quickdraw"] = true;
  level.scriptPerks["specialty_class_toughness"] = true;
  level.scriptPerks["specialty_class_lightweight"] = true;
  level.scriptPerks["specialty_class_engineer"] = true;
  level.scriptPerks["specialty_class_dangerclose"] = true;

  level.scriptPerks["specialty_horde_weaponsfree"] = true;
  level.scriptPerks["specialty_horde_dualprimary"] = true;

  level.scriptPerks["specialty_marksman"] = true;
  level.scriptPerks["specialty_sharp_focus"] = true;
  level.scriptPerks["specialty_moredamage"] = true;

  level.scriptPerks["specialty_copycat"] = true;
  level.scriptPerks["specialty_finalstand"] = true;
  level.scriptPerks["specialty_juiced"] = true;
  level.scriptPerks["specialty_light_armor"] = true;
  level.scriptPerks["specialty_carepackage"] = true;
  level.scriptPerks["specialty_stopping_power"] = true;
  level.scriptPerks["specialty_uav"] = true;

  level.scriptPerks["bouncingbetty_mp"] = true;
  level.scriptPerks["c4_mp"] = true;
  level.scriptPerks["claymore_mp"] = true;
  level.scriptPerks["frag_grenade_mp"] = true;
  level.scriptPerks["semtex_mp"] = true;
  level.scriptPerks["tracking_drone_mp"] = true;
  level.scriptPerks["throwingknife_mp"] = true;
  level.scriptPerks["exoknife_mp"] = true;
  level.scriptPerks["exoknife_jug_mp"] = true;
  level.scriptPerks["paint_grenade_mp"] = true;
  level.scriptPerks["tri_drone_mp"] = true;
  level.scriptPerks["explosive_gel_mp"] = true;
  level.scriptPerks["frag_grenade_var_mp"] = true;
  level.scriptPerks["contact_grenade_var_mp"] = true;
  level.scriptPerks["semtex_grenade_var_mp"] = true;
  level.scriptPerks["stun_grenade_var_mp"] = true;
  level.scriptPerks["emp_grenade_var_mp"] = true;
  level.scriptPerks["paint_grenade_var_mp"] = true;
  level.scriptPerks["smoke_grenade_var_mp"] = true;
  level.scriptPerks["explosive_drone_mp"] = true;

  level.scriptPerks["concussion_grenade_mp"] = true;
  level.scriptPerks["flash_grenade_mp"] = true;
  level.scriptPerks["stun_grenade_mp"] = true;
  level.scriptPerks["smoke_grenade_mp"] = true;
  level.scriptPerks["emp_grenade_mp"] = true;
  level.scriptPerks["portable_radar_mp"] = true;
  level.scriptPerks["scrambler_mp"] = true;
  level.scriptPerks["trophy_mp"] = true;
  level.scriptPerks["s1_tactical_insertion_device_mp"] = true;

  level.scriptPerks["specialty_wildcard_perkslot1"] = true;
  level.scriptPerks["specialty_wildcard_perkslot2"] = true;
  level.scriptPerks["specialty_wildcard_perkslot3"] = true;
  level.scriptPerks["specialty_wildcard_primaryattachment"] = true;
  level.scriptPerks["specialty_wildcard_secondaryattachment"] = true;
  level.scriptPerks["specialty_wildcard_extrastreak"] = true;

  level.scriptPerks["specialty_null"] = true;

  level.perkSetFuncs["specialty_blastshield"] = ::setBlastShield;
  level.perkUnsetFuncs["specialty_blastshield"] = ::unsetBlastShield;

  level.perkSetFuncs["specialty_falldamage"] = ::setFreefall;
  level.perkUnsetFuncs["specialty_falldamage"] = ::unsetFreefall;

  level.perkSetFuncs["specialty_localjammer"] = ::setLocalJammer;
  level.perkUnsetFuncs["specialty_localjammer"] = ::unsetLocalJammer;

  level.perkSetFuncs["specialty_thermal"] = ::setThermal;
  level.perkUnsetFuncs["specialty_thermal"] = ::unsetThermal;

  level.perkSetFuncs["specialty_blackbox"] = ::setBlackBox;
  level.perkUnsetFuncs["specialty_blackbox"] = ::unsetBlackBox;

  level.perkSetFuncs["specialty_lightweight"] = ::setLightWeight;
  level.perkUnsetFuncs["specialty_lightweight"] = ::unsetLightWeight;

  level.perkSetFuncs["specialty_steelnerves"] = ::setSteelNerves;
  level.perkUnsetFuncs["specialty_steelnerves"] = ::unsetSteelNerves;

  level.perkSetFuncs["specialty_delaymine"] = ::setDelayMine;
  level.perkUnsetFuncs["specialty_delaymine"] = ::unsetDelayMine;

  level.perkSetFuncs["specialty_saboteur"] = ::setSaboteur;
  level.perkUnsetFuncs["specialty_saboteur"] = ::unsetSaboteur;

  level.perkSetFuncs["specialty_endgame"] = ::setEndGame;
  level.perkUnsetFuncs["specialty_endgame"] = ::unsetEndGame;

  level.perkSetFuncs["specialty_rearview"] = ::setRearView;
  level.perkUnsetFuncs["specialty_rearview"] = ::unsetRearView;

  level.perkSetFuncs["specialty_onemanarmy"] = ::setOneManArmy;
  level.perkUnsetFuncs["specialty_onemanarmy"] = ::unsetOneManArmy;

  level.perkSetFuncs["specialty_steadyaimpro"] = ::setSteadyAimPro;
  level.perkUnsetFuncs["specialty_steadyaimpro"] = ::unsetSteadyAimPro;

  level.perkSetFuncs["specialty_stun_resistance"] = ::setStunResistance;
  level.perkUnsetFuncs["specialty_stun_resistance"] = ::unsetStunResistance;

  level.perkSetFuncs["specialty_marksman"] = ::setMarksman;
  level.perkUnsetFuncs["specialty_marksman"] = ::unsetMarksman;

  level.perkSetFuncs["specialty_double_load"] = ::setDoubleLoad;
  level.perkUnsetFuncs["specialty_double_load"] = ::unsetDoubleLoad;

  level.perkSetFuncs["specialty_sharp_focus"] = ::setSharpFocus;
  level.perkUnsetFuncs["specialty_sharp_focus"] = ::unsetSharpFocus;

  level.perkSetFuncs["specialty_regenspeed"] = ::setRegenSpeed;
  level.perkUnsetFuncs["specialty_regenspeed"] = ::unsetRegenSpeed;

  level.perkSetFuncs["specialty_autospot"] = ::setAutoSpot;
  level.perkUnsetFuncs["specialty_autospot"] = ::unsetAutoSpot;

  level.perkSetFuncs["specialty_empimmune"] = ::setEmpImmune;
  level.perkUnsetFuncs["specialty_empimmune"] = ::unsetEmpImmune;

  level.perkSetFuncs["specialty_overkill_pro"] = ::setOverkillPro;
  level.perkUnsetFuncs["specialty_overkill_pro"] = ::unsetOverkillPro;

  level.perkSetFuncs["specialty_personaluav"] = ::setPersonalUav;
  level.perkUnsetFuncs["specialty_personaluav"] = ::unsetPersonalUav;

  level.perkSetFuncs["specialty_crouchmovement"] = ::setCrouchMovement;
  level.perkUnsetFuncs["specialty_crouchmovement"] = ::unsetCrouchMovement;

  level.perkSetFuncs["specialty_light_armor"] = ::setLightArmor;
  level.perkUnsetFuncs["specialty_light_armor"] = ::unsetLightArmor;

  level.perkSetFuncs["specialty_finalstand"] = ::setFinalStand;
  level.perkUnsetFuncs["specialty_finalstand"] = ::unsetFinalStand;

  level.perkSetFuncs["specialty_juiced"] = ::setJuiced;
  level.perkUnsetFuncs["specialty_juiced"] = ::unsetJuiced;

  level.perkSetFuncs["specialty_carepackage"] = ::setCarePackage;
  level.perkUnsetFuncs["specialty_carepackage"] = ::unsetCarePackage;

  level.perkSetFuncs["specialty_stopping_power"] = ::setStoppingPower;
  level.perkUnsetFuncs["specialty_stopping_power"] = ::unsetStoppingPower;

  level.perkSetFuncs["specialty_uav"] = ::setUAV;
  level.perkUnsetFuncs["specialty_uav"] = ::unsetUAV;

  initPerkDvars();

  level thread onPlayerConnect();
}

validatePerk(perkIndex, perkName) {
  if(getDvarInt("scr_game_perks") == 0) {
    return "specialty_null";
  }

  if(perkIndex == 0 || perkIndex == 1) {
    switch (perkName) {
      case "specialty_extended_battery":
      case "specialty_class_lowprofile":
      case "specialty_class_flakjacket":
      case "specialty_class_lightweight":
      case "specialty_class_dangerclose":
        return perkName;
      default:
        return "specialty_null";
    }
  } else if(perkIndex == 2 || perkIndex == 3) {
    switch (perkName) {
      case "specialty_class_blindeye":
      case "specialty_class_coldblooded":
      case "specialty_class_peripherals":
      case "specialty_class_fasthands":
      case "specialty_class_dexterity":
        return perkName;
      default:
        return "specialty_null";
    }
  } else if(perkIndex == 4 || perkIndex == 5) {
    switch (perkName) {
      case "specialty_class_hardwired":
      case "specialty_class_toughness":
      case "specialty_class_scavenger":
      case "specialty_class_hardline":
      case "specialty_exo_blastsuppressor":
        return perkName;
      default:
        return "specialty_null";
    }
  }

  return perkName;
}

getEmptyPerks() {
  perks = [];
  for(i = 0; i < 6; i++) {
    perks[i] = "specialty_null";
  }
  return perks;
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  self.perks = [];
  self.weaponList = [];
  self.omaClassChanged = false;

  for(;;) {
    self waittill("spawned_player");

    self.omaClassChanged = false;
    self thread maps\mp\gametypes\_scrambler::scramblerProximityTracker();
  }
}

cac_modified_damage(victim, attacker, damage, meansofdeath, weapon, impactPoint, impactDir, hitLoc, inflictor) {
  assert(isPlayer(victim) || isAgent(victim));
  assert(isDefined(victim.team));

  damageAdd = 0;

  shortWeapon = maps\mp\_utility::strip_suffix(weapon, "_lefthand");

  if(isBulletDamage(meansOfDeath)) {
    assert(isDefined(attacker));

    if(IsPlayer(attacker) && attacker _hasPerk("specialty_paint_pro") && !isKillstreakWeapon(weapon) && IsPlayer(victim) && !victim _hasPerk("specialty_class_lowprofile")) {
      if(!victim isPainted()) {
        attacker maps\mp\gametypes\_missions::processChallenge("ch_bulletpaint");
      }

      if(attacker.trackrounds.has_trackrounds) {
        victim thread maps\mp\_trackrounds::set_painted_trackrounds(attacker);
      }

      victim thread maps\mp\perks\_perkfunctions::setPainted(attacker);
    }

    if(IsPlayer(attacker) && isDefined(weapon) && getWeaponClass(weapon) == "weapon_sniper" && isSubStr(weapon, "silencer")) {
      damage *= 0.75;
    }

    if(IsPlayer(attacker) &&
      (attacker _hasPerk("specialty_bulletdamage") && victim _hasPerk("specialty_armorvest"))) {
      damageAdd += 0;
    } else if(IsPlayer(attacker) &&
      (attacker _hasPerk("specialty_bulletdamage") ||
        attacker _hasPerk("specialty_moredamage"))) {
      damageAdd += damage * level.bulletDamageMod;
    } else if(victim _hasPerk("specialty_armorvest")) {
      damageAdd -= damage * level.armorVestMod;
    }

    if(victim isJuggernaut()) {
      weakToHeadShots = isDefined(victim.juggernautWeak) && victim.juggernautWeak && (hitLoc == "head" || hitLoc == "helmet");

      if(!weakToHeadShots) {
        damage *= level.juggernautMod;
      }

    }
  } else if(IsExplosiveDamageMOD(meansOfDeath)) {
    if(IsPlayer(attacker) &&
      attacker != victim &&
      (attacker IsItemUnlocked("specialty_paint") && attacker _hasPerk("specialty_paint")) && !isKillstreakWeapon(weapon)) {
      if(!victim isPainted()) {
        attacker maps\mp\gametypes\_missions::processChallenge("ch_paint_pro");
      }

      victim thread maps\mp\perks\_perkfunctions::setPainted(attacker);
    }

    if(isPlayer(attacker) && weaponInheritsPerks(weapon) &&
      ((attacker _hasPerk("specialty_explosivedamage")) && victim _hasPerk("_specialty_blastshield"))) {
      damageAdd += 0;
    } else if(isPlayer(attacker) && weaponInheritsPerks(weapon) &&
      (attacker _hasPerk("specialty_explosivedamage"))) {
      damageAdd += damage * level.explosiveDamageMod;
    } else if(victim _hasPerk("_specialty_blastshield") && isDefined(victim.specialty_blastshield_bonus) && (shortWeapon != "semtex_mp" || damage < 125)) {
      damageAdd -= int(damage * victim.specialty_blastshield_bonus);
    }

    if(isKillstreakWeapon(weapon) && isPlayer(attacker) &&
      (attacker _hasPerk("specialty_explosivedamage"))) {
      damageAdd += damage * level.explosiveDamageMod;
    }

    if(victim isJuggernaut()) {
      switch (weapon) {
        case "ac130_25mm_mp":
          damage *= level.juggernautMod;
          break;

        case "remotemissile_projectile_mp":
        case "remotemissile_projectile_cluster_parent_mp":
        case "remotemissile_projectile_gas_mp":
          if(damage < 350) {
            if(damage > 1) {
              damage *= level.juggernautMod;
            }
          }
          break;

        default:
          if(damage < 1000) {
            if(damage > 1) {
              damage *= level.juggernautMod;
            }
          }
          break;
      }
    }

    if(maps\mp\gametypes\_weapons::inGrenadeGracePeriod()) {
      damage *= level.juggernautMod;
    }

  } else if(meansOfDeath == "MOD_FALLING") {
    if(victim IsItemUnlocked("specialty_falldamage") && victim _hasPerk("specialty_falldamage")) {
      damageAdd = 0;
      damage = 0;
    }
  } else if(isMeleeMOD(meansOfDeath)) {
    if(isDefined(victim.hasLightArmor) && victim.hasLightArmor) {
      if(IsSubStr(weapon, "riotshield") || weapon == "exoshield_equipment_mp") {
        damage = Int(victim.maxHealth * 0.66);
      } else {
        damage = victim.maxHealth + 1;
      }
    }

    if(victim isJuggernaut()) {
      damage = 20;
      damageAdd = 0;
    }
  } else if(meansOfDeath == "MOD_IMPACT") {
    if(victim isJuggernaut()) {
      switch (shortWeapon) {
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "smoke_grenade_mp":
        case "smoke_grenade_var_mp":
        case "frag_grenade_mp":
        case "semtex_mp":
        case "stun_grenade_mp":
        case "stun_grenade_var_mp":
        case "stun_grenade_horde_mp":
          damage = 5;
          break;

        default:
          if(damage < 1000) {
            damage = 25;
          }
          break;
      }

      damageAdd = 0;
    }
  }

  baseweaponname = GetWeaponBaseName(weapon);
  if(isDefined(victim.lightArmorHP) && isDefined(baseweaponname)) {
    switch (baseweaponname) {
      case "exoknife_mp":
      case "exoknife_jug_mp": {
        damage = victim.health;
        damageAdd = 0;
        break;
      }
      case "semtexproj_mp":
      case "semtex_mp": {
        if(isDefined(inflictor) && isDefined(inflictor.stuckEnemyEntity) && inflictor.stuckEnemyEntity == victim) {
          damage = victim.health;
          damageAdd = 0;
        }
        break;
      }
      default: {
        if(meansofdeath != "MOD_FALLING" &&
          !isMeleeMOD(meansofdeath) &&
          !isHeadShot(baseweaponname, hitLoc, meansofdeath, attacker) &&
          !isFMJDamage(baseweaponname, meansofdeath, attacker)
        ) {
          victim setLightArmorHP(victim.lightArmorHP - (damage + damageAdd));

          damage = 0;
          damageAdd = 0;
          if(victim.lightArmorHP <= 0) {
            damage = abs(victim.lightArmorHP);
            damageAdd = 0;
            unsetLightArmor();
          }
        }
        break;
      }
    }
  }

  if(getDvar("scr_devPrintDamage") != "") {
    IPrintLn(damage + damageAdd);
  }

  if(damage <= 1) {
    damage = 1;
    return damage;
  } else {
    return int(damage + damageAdd);
  }
}

initPerkDvars() {
  level.juggernautMod = 8 / 100;
  level.juggernatuDefMod = 8 / 100;
  level.armorPiercingMod = 1.5;
  level.regenHealthMod = 0.25;

  level.bulletDamageMod = getIntProperty("perk_bulletDamage", 12) / 100;
  level.explosiveDamageMod = getIntProperty("perk_explosiveDamage", 10) / 100;
  level.riotShieldMod = getIntProperty("perk_riotShield", 100) / 100;
  level.armorVestMod = getIntProperty("perk_armorVest", 20) / 100;
}

cac_selector() {}

giveBlindEyeAfterspawn() {
  self endon("death");
  self endon("disconnect");

  self givePerk("specialty_blindeye", false);
  self.spawnPerk = true;
  while(self.avoidKillstreakOnSpawnTimer > 0) {
    self.avoidKillstreakOnSpawnTimer -= 0.05;
    wait(0.05);
  }

  self _unsetPerk("specialty_blindeye");
  self.spawnPerk = false;
}

applyPerks() {
  self SetViewKickScale(0.5);

  if(self _hasPerk("specialty_extended_battery")) {
    self givePerk("specialty_exo_slamboots", false);
  }

  if(self _hasPerk("specialty_class_lowprofile")) {
    self givePerk("specialty_radarimmune", false);
    self givePerk("specialty_exoping_immune", false);
  }

  if(self _hasPerk("specialty_class_flakjacket")) {
    self givePerk("specialty_hard_shell", false);
    self givePerk("specialty_throwback", false);
    self givePerk("_specialty_blastshield", false);

    self.specialty_blastshield_bonus = getIntProperty("perk_blastShieldScale", 45) / 100;

    if(isDefined(level.hardcoreMode) && level.hardcoreMode) {
      self.specialty_blastshield_bonus = getIntProperty("perk_blastShieldScale_HC", 90) / 100;
    }
  }

  if(self _hasPerk("specialty_class_lightweight")) {
    self givePerk("specialty_lightweight", false);
  }

  if(self _hasPerk("specialty_class_dangerclose")) {
    self givePerk("specialty_explosivedamage", false);
  }

  if(self _hasPerk("specialty_class_blindeye")) {
    self givePerk("specialty_blindeye", false);
    self givePerk("specialty_plainsight", false);
  }

  if(self _hasPerk("specialty_class_coldblooded")) {
    self givePerk("specialty_coldblooded", false);
    self givePerk("specialty_spygame", false);
    self givePerk("specialty_heartbreaker", false);
  }

  if(self _hasPerk("specialty_class_peripherals") || practiceRoundGame()) {
    self givePerk("specialty_moreminimap", false);
    self givePerk("specialty_silentkill", false);
  }

  if(self _hasPerk("specialty_class_fasthands")) {
    self givePerk("specialty_quickswap", false);
    self givePerk("specialty_fastoffhand", false);
    self givePerk("specialty_sprintreload", false);
  }

  if(self _hasPerk("specialty_class_dexterity")) {
    self givePerk("specialty_sprintfire", false);
  }

  if(self _hasPerk("specialty_class_hardwired")) {
    self givePerk("specialty_empimmune", false);
    self givePerk("specialty_stun_resistance", false);
    self.stunScaler = 0.1;
  }

  if(self _hasPerk("specialty_class_toughness")) {
    self setViewKickScale(0.2);
  }

  if(self _hasPerk("specialty_class_scavenger")) {
    self.ammopickup_scalar = 0.2;
    self givePerk("specialty_scavenger", false);
    self givePerk("specialty_bulletresupply", false);

    self givePerk("specialty_extraammo", false);
  }

  if(self _hasPerk("specialty_class_hardline")) {
    self givePerk("specialty_hardline", false);
  }

}