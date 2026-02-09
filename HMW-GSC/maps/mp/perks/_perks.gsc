#include maps\mp\_utility;

init() {
  game["dialog"]["ti_destroyed"] = "glowstick_destroyed";

  precacheShader("specialty_painkiller");
  precacheShader("specialty_copycat");
  precacheShader("combathigh_overlay");
  precacheShader("h2_grenadepulldeath");
  precacheShader("h2_scavenger");
  precacheShader("h2_blastshield");
  precacheShader("ballistic_overlay");

  //precacheItem( "onemanarmy_mp" );
  //precacheItem( "flare_mp" );

  precacheModel("weapon_scavenger_grenadebag");
  precacheModel("weapon_light_stick_tactical_bombsquad");

  level.spawnGlowModel["enemy"] = "mil_emergency_flare";
  level.spawnGlowModel["friendly"] = "mil_emergency_flare";
  level.spawnGlow["enemy"] = loadfx("fx/misc/flare_ambient");
  level.spawnGlow["friendly"] = loadfx("fx/misc/handflare_green_view");

  precacheModel(level.spawnGlowModel["enemy"]);
  precacheModel(level.spawnGlowModel["friendly"]);

  level.perkfuncs = [];
  level.specialty_finalstand_icon = "specialty_finalstand";
  level.specialty_laststand_icon = "specialty_pistoldeath";
  level.specialty_c4_death_icon = "specialty_s1_temp";
  level.specialty_compassping_revenge_icon = "specialty_s1_temp";
  level.specialty_juiced_icon = "specialty_s1_temp";
  precacheshader(level.specialty_finalstand_icon);
  precacheshader(level.specialty_laststand_icon);
  level.scriptperks = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.scriptPerks["specialty_tacticalinsertion"] = true;
  level.scriptperks["specialty_combathigh"] = 1;
  level.scriptperks["specialty_blastshield"] = 1;
  level.scriptperks["specialty_akimbo"] = 1;
  level.scriptperks["specialty_falldamage"] = 1;
  level.scriptperks["specialty_shield"] = 1;
  level.scriptperks["specialty_feigndeath"] = 1;
  level.scriptperks["specialty_shellshock"] = 1;
  level.scriptperks["specialty_delaymine"] = 1;
  level.scriptperks["specialty_localjammer"] = 1;
  level.scriptperks["specialty_thermal"] = 1;
  level.scriptperks["specialty_blackbox"] = 1;
  level.scriptperks["specialty_steelnerves"] = 1;
  level.scriptperks["specialty_flashgrenade"] = 1;
  level.scriptperks["specialty_smokegrenade"] = 1;
  level.scriptperks["specialty_concussiongrenade"] = 1;
  level.scriptperks["specialty_saboteur"] = 1;
  level.scriptperks["specialty_endgame"] = 1;
  level.scriptperks["specialty_rearview"] = 1;
  level.scriptperks["specialty_hardline"] = 1;
  level.scriptperks["specialty_onemanarmy"] = 1;
  level.scriptperks["specialty_omaquickchange"] = 1;
  level.scriptperks["specialty_primarydeath"] = 1;
  level.scriptperks["specialty_secondarybling"] = 1;
  level.scriptperks["specialty_explosivedamage"] = 1;
  level.scriptperks["specialty_laststandoffhand"] = 1;
  level.scriptperks["specialty_dangerclose"] = 1;
  level.scriptperks["specialty_hardjack"] = 1;
  level.scriptperks["specialty_extraspecialduration"] = 1;
  level.scriptperks["specialty_rollover"] = 1;
  level.scriptperks["specialty_armorpiercing"] = 1;
  level.scriptperks["specialty_omaquickchange"] = 1;
  level.scriptperks["_specialty_rearview"] = 1;
  level.scriptperks["_specialty_onemanarmy"] = 1;
  level.scriptperks["_specialty_omaquickchange"] = 1;
  level.scriptperks["specialty_steadyaimpro"] = 1;
  level.scriptperks["specialty_stun_resistance"] = 1;
  level.scriptperks["specialty_double_load"] = 1;
  level.scriptperks["specialty_regenspeed"] = 1;
  level.scriptperks["specialty_twoprimaries"] = 1;
  level.scriptperks["specialty_autospot"] = 1;
  level.scriptperks["specialty_overkillpro"] = 1;
  level.scriptperks["specialty_anytwo"] = 1;
  level.scriptperks["specialty_fasterlockon"] = 1;
  level.scriptperks["specialty_paint"] = 1;
  level.scriptperks["specialty_paint_pro"] = 1;
  level.scriptperks["specialty_silentkill"] = 1;
  level.scriptperks["specialty_crouchmovement"] = 1;
  level.scriptperks["specialty_personaluav"] = 1;
  level.scriptperks["specialty_unwrapper"] = 1;
  level.scriptperks["specialty_class_blindeye"] = 1;
  level.scriptperks["specialty_class_lowprofile"] = 1;
  level.scriptperks["specialty_class_coldblooded"] = 1;
  level.scriptperks["specialty_class_hardwired"] = 1;
  level.scriptperks["specialty_class_scavenger"] = 1;
  level.scriptperks["specialty_class_hoarder"] = 1;
  level.scriptperks["specialty_class_gungho"] = 1;
  level.scriptperks["specialty_class_steadyhands"] = 1;
  level.scriptperks["specialty_class_hardline"] = 1;
  level.scriptperks["specialty_class_peripherals"] = 1;
  level.scriptperks["specialty_class_quickdraw"] = 1;
  level.scriptperks["specialty_class_toughness"] = 1;
  level.scriptperks["specialty_class_lightweight"] = 1;
  level.scriptperks["specialty_class_engineer"] = 1;
  level.scriptperks["specialty_class_dangerclose"] = 1;
  level.scriptperks["specialty_horde_weaponsfree"] = 1;
  level.scriptperks["specialty_horde_dualprimary"] = 1;
  level.scriptperks["specialty_marksman"] = 1;
  level.scriptperks["specialty_sharp_focus"] = 1;
  level.scriptperks["specialty_moredamage"] = 1;
  level.scriptperks["specialty_copycat"] = 1;
  level.scriptperks["specialty_finalstand"] = 1;
  level.scriptperks["specialty_juiced"] = 1;
  level.scriptperks["specialty_light_armor"] = 1;
  level.scriptperks["specialty_stopping_power"] = 1;
  level.scriptperks["specialty_uav"] = 1;
  level.scriptperks["h1_concussiongrenade_mp"] = 1;
  level.scriptperks["h1_flashgrenade_mp"] = 1;
  level.scriptperks["h1_fraggrenade_mp"] = 1;
  level.scriptperks["h1_smokegrenade_mp"] = 1;
  level.scriptperks["bouncingbetty_mp"] = 1;
  level.scriptperks["c4_mp"] = 1;
  level.scriptperks["claymore_mp"] = 1;
  level.scriptperks["frag_grenade_mp"] = 1;
  level.scriptperks["rpg_mp"] = 1;
  level.scriptperks["concussion_grenade_mp"] = 1;
  level.scriptperks["flash_grenade_mp"] = 1;
  level.scriptperks["smoke_grenade_mp"] = 1;
  level.scriptperks["portable_radar_mp"] = 1;
  level.scriptperks["scrambler_mp"] = 1;
  level.scriptperks["trophy_mp"] = 1;
  level.scriptperks["specialty_wildcard_perkslot1"] = 1;
  level.scriptperks["specialty_wildcard_perkslot2"] = 1;
  level.scriptperks["specialty_wildcard_perkslot3"] = 1;
  level.scriptperks["specialty_wildcard_primaryattachment"] = 1;
  level.scriptperks["specialty_wildcard_secondaryattachment"] = 1;
  level.scriptperks["specialty_wildcard_extrastreak"] = 1;
  level.scriptperks["specialty_extraammo"] = 1;
  level.scriptperks["specialty_bulletdamage"] = 1;
  level.scriptperks["specialty_armorvest"] = 1;
  level.scriptperks["specialty_twoprimaries"] = 1;
  level.scriptperks["specialty_explosivedamage"] = 1;
  level.scriptperks["specialty_grenadepulldeath"] = 1;
  level.scriptperks["specialty_bling"] = 1;
  level.scriptperks["specialty_null"] = 1;

  level.perksetfuncs["specialty_blastshield"] = maps\mp\perks\_perkfunctions::setblastshield;
  level.perkunsetfuncs["specialty_blastshield"] = maps\mp\perks\_perkfunctions::unsetblastshield;

  level.perksetfuncs["specialty_localjammer"] = maps\mp\perks\_perkfunctions::setlocaljammer;
  level.perkunsetfuncs["specialty_localjammer"] = maps\mp\perks\_perkfunctions::unsetlocaljammer;

  level.perksetfuncs["specialty_thermal"] = maps\mp\perks\_perkfunctions::setthermal;
  level.perkunsetfuncs["specialty_thermal"] = maps\mp\perks\_perkfunctions::unsetthermal;

  level.perksetfuncs["specialty_lightweight"] = maps\mp\perks\_perkfunctions::setlightweight;
  level.perkunsetfuncs["specialty_lightweight"] = maps\mp\perks\_perkfunctions::unsetlightweight;

  level.perksetfuncs["specialty_delaymine"] = maps\mp\perks\_perkfunctions::setdelaymine;
  level.perkunsetfuncs["specialty_delaymine"] = maps\mp\perks\_perkfunctions::unsetdelaymine;

  level.perksetfuncs["specialty_onemanarmy"] = maps\mp\perks\_perkfunctions::setonemanarmy;
  level.perksetfuncs["specialty_omaquickchange"] = maps\mp\perks\_perkfunctions::setonemanarmy;

  level.perkunsetfuncs["specialty_onemanarmy"] = maps\mp\perks\_perkfunctions::unsetonemanarmy;
  level.perkunsetfuncs["specialty_omaquickchange"] = maps\mp\perks\_perkfunctions::unsetonemanarmy;

  level.perksetfuncs["specialty_combathigh"] = maps\mp\perks\_perkfunctions::setCombatHigh;
  level.perkunsetfuncs["specialty_combathigh"] = maps\mp\perks\_perkfunctions::unsetCombatHigh;

  level.perksetfuncs["specialty_steadyaimpro"] = maps\mp\perks\_perkfunctions::setsteadyaimpro;
  level.perkunsetfuncs["specialty_steadyaimpro"] = maps\mp\perks\_perkfunctions::unsetsteadyaimpro;

  level.perksetfuncs["specialty_overkill_pro"] = maps\mp\perks\_perkfunctions::setoverkillpro;
  level.perkunsetfuncs["specialty_overkill_pro"] = maps\mp\perks\_perkfunctions::unsetoverkillpro;

  level.perksetfuncs["specialty_finalstand"] = maps\mp\perks\_perkfunctions::setfinalstand;
  level.perkunsetfuncs["specialty_finalstand"] = maps\mp\perks\_perkfunctions::unsetfinalstand;

  level.perksetfuncs["specialty_juiced"] = maps\mp\perks\_perkfunctions::setjuiced;
  level.perkunsetfuncs["specialty_juiced"] = maps\mp\perks\_perkfunctions::unsetjuiced;

  level.fauxPerks["specialty_tacticalinsertion"] = true;
  level.fauxPerks["specialty_shield"] = true;

  level.perkSetFuncs["specialty_tacticalinsertion"] = maps\mp\perks\_perkfunctions::h2_setTacticalInsertion;
  level.perkUnsetFuncs["specialty_tacticalinsertion"] = maps\mp\perks\_perkfunctions::h2_unsetTacticalInsertion;

  level.perksetfuncs["specialty_grenadepulldeath"] = maps\mp\perks\_perkfunctions::setmartyr;
  level.perkunsetfuncs["specialty_grenadepulldeath"] = maps\mp\gametypes\_callbacksetup::callbackvoid;

  initperkdvars();
  level thread onplayerconnect();
}

perktablelookupgroup(var_0) {
  return tablelookup("mp/perktable.csv", 1, var_0, 13);
}

perktablelookupcount(var_0) {
  return int(tablelookup("mp/perktable.csv", 1, var_0, 6));
}

perktablelookupslot(var_0) {
  return int(tablelookup("mp/perktable.csv", 1, var_0, 12));
}

perktablelookuplocalizedname(var_0) {
  return tablelookupistring("mp/perktable.csv", 1, var_0, 2);
}

perktablelookupimage(var_0) {
  return tablelookup("mp/perktable.csv", 1, var_0, 3);
}

validateperk(var_0, var_1) {
  if(getdvarint("scr_game_perks") == 0)
    return "specialty_null";

  if(var_0 == 0) {
    switch (var_1) {
      case "specialty_longersprint":
      case "specialty_fastmantle":
      case "specialty_fastreload":
      case "specialty_quickdraw":
      case "specialty_scavenger":
      case "specialty_extraammo":
      case "specialty_bling":
      case "specialty_secondarybling":
      case "specialty_onemanarmy":
      case "specialty_omaquickchange":
        return var_1;
      default:
        break;
    }
  } else if(var_0 == 1) {
    switch (var_1) {
      case "specialty_bulletdamage":
      case "specialty_armorpiercing":
      case "specialty_lightweight":
      case "specialty_fastsprintrecovery":
      case "specialty_hardline":
      case "specialty_rollover":
      case "specialty_radarimmune":
      case "specialty_spygame":
      case "specialty_explosivedamage":
      case "specialty_dangerclose":
        return var_1;
      default:
        break;
    }
  } else if(var_0 == 2) {
    switch (var_1) {
      case "specialty_extendedmelee":
      case "specialty_falldamage":
      case "specialty_bulletaccuracy":
      case "specialty_holdbreath":
      case "specialty_localjammer":
      case "specialty_delaymine":
      case "specialty_heartbreaker":
      case "specialty_quieter":
      case "specialty_detectexplosive":
      case "specialty_selectivehearing":
      case "specialty_pistoldeath":
      case "specialty_laststandoffhand":
        return var_1;
      default:
        break;
    }
  }

  return "specialty_null";
}

getemptyperks() {
  var_0 = [];

  for(var_1 = 0; var_1 < 3; var_1++)
    var_0[var_1] = "specialty_null";

  return var_0;
}

onplayerconnect() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  self.perks = [];
  self.weaponlist = [];
}

isExplosiveDamage(meansofdeath) {
  return isExplosiveDamageMOD(meansofdeath) || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH";
}

isPrimaryDamage(meansofdeath) {
  return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET";
}

cac_modified_damage(victim, attacker, damage, meansofdeath, weapon, impactPoint, impactDir, hitLoc) {
  assert(isPlayer(victim));
  assert(isDefined(victim.team));

  if(!isDefined(victim) || !isDefined(attacker) || !isPlayer(attacker) || !maps\mp\_utility::invirtuallobby() && !isPlayer(victim))
    return damage;

  if(attacker.sessionstate != "playing" || !isDefined(damage) || !isDefined(meansofdeath))
    return damage;

  if(meansofdeath == "")
    return damage;

  //if( isDefined( victim.inlaststand ) && victim.inlaststand )
  //return 0;

  damageAdd = 0;

  //print( "pre damage: " + damage );

  if(isPrimaryDamage(meansofdeath)) {
    assert(isDefined(attacker));

    if(isPlayer(attacker) && weaponInheritsPerks(weapon) && attacker _hasPerk("specialty_bulletdamage") && victim _hasPerk("specialty_armorvest"))
      damageAdd += 0;
    else if(isPlayer(attacker) && weaponInheritsPerks(weapon) && attacker _hasPerk("specialty_bulletdamage"))
      damageAdd += damage * level.bulletDamageMod;
    else if(victim _hasPerk("specialty_armorvest"))
      damageAdd -= damage * (level.armorVestMod * -1);

    if(isPlayer(attacker) && attacker _hasPerk("specialty_fmj") && victim _hasPerk("specialty_armorvest"))
      damageAdd += damage * level.hollowPointDamageMod;
  } else if(isExplosiveDamage(meansofdeath)) {
    if(isPlayer(attacker) && weaponInheritsPerks(weapon) && attacker _hasPerk("specialty_explosivedamage") && isDefined(victim.blastShielded))
      damageAdd += 0;
    else if(isPlayer(attacker) && weaponInheritsPerks(weapon) && attacker _hasPerk("specialty_explosivedamage"))
      damageAdd += damage * level.explosiveDamageMod;
    else if(isDefined(victim.blastShielded))
      damageAdd -= damage * (level.blastShieldMod * -1);
    else if(maps\mp\gametypes\_weapons::ingrenadegraceperiod()) // is this needed?
      damageAdd *= level.juggernautmod;

    if(isKillstreakWeapon(weapon) && isPlayer(attacker) && attacker _hasPerk("specialty_dangerclose"))
      damageAdd += damage * level.dangerCloseMod;
  } else if(meansofdeath == "MOD_FALLING") {
    if(victim _hasPerk("specialty_falldamage")) {
      damageAdd = 0;
      damage = 0;
    }
  }

  if(victim _hasperk("specialty_combathigh")) {
    if(isDefined(self.damageBlockedTotal) && (!level.teamBased || (isDefined(attacker) && isDefined(attacker.team) && victim.team != attacker.team))) {
      damageTotal = damage + damageAdd;
      damageBlocked = (damageTotal - (damageTotal / 3));
      self.damageBlockedTotal += damageBlocked;

      if(self.damageBlockedTotal >= 101) {
        self notify("combathigh_survived");
        self.damageBlockedTotal = undefined;
      }
    }

    if(weapon != "iw9_throwknife_mp") {
      switch (meansOfDeath) {
        case "MOD_FALLING":
        case "MOD_MELEE":
          break;
        default:
          damage = damage / 3;
          damageAdd = damageAdd / 3;
          break;
      }
    }
  }

  //print( "post damage: " + int( damage + damageAdd ) );	

  return int(damage + damageAdd);
}

initperkdvars() {
    level.juggernautmod = 0.08;
    level.juggernatudefmod = 0.08;
    level.regenhealthmod = 0.25;

    level.bulletDamageMod = getIntProperty("perk_bulletDamage", 40) / 100; // increased bullet damage by this % level.hollowPointDamageMod = getIntProperty("perk_hollowPointDamage", 65) / 100; // increased bullet damage by this % level.armorVestMod = getIntProperty("perk_armorVest", 75) / 100; // percentage of damage you take
    level.explosiveDamageMod = getIntProperty("perk_explosiveDamage", 40) / 100; // increased explosive damage by this % level.blastShieldMod = getIntProperty("perk_blastShield", 45) / 100; // percentage of damage you take
    level.riotShieldMod = getIntProperty("perk_riotShield", 100) / 100;
    level.dangerCloseMod = getIntProperty("perk_dangerClose", 100) / 100;
    level.armorPiercingMod = getIntProperty("perk_armorPiercingDamage", 40) / 100; // increased bullet damage by this %}

    cac_selector() {}

    giveblindeyeafterspawn() {
      self endon("death");
      self endon("disconnect");
      maps\mp\_utility::giveperk("specialty_blindeye", 0);
      self.spawnperk = 1;

      while(self.avoidkillstreakonspawntimer > 0) {
        self.avoidkillstreakonspawntimer -= 0.05;
        wait 0.05;
      }

      maps\mp\_utility::_unsetperk("specialty_blindeye");
      self.spawnperk = 0;
    }

    applyperks() {
      self endon("disconnect");
      level endon("game_ended");

      self setviewkickscale(1.0);

      table = "mp/perkTable.csv";

      for(i = 0; i < tablegetrowcount(table); i++) {
        pro_perk = tableLookup(table, 0, i, 8);

        if(!isSubStr(pro_perk, "specialty_")) {
          continue;
        }
        if(self maps\mp\_utility::_hasPerk(pro_perk))
          self maps\mp\_utility::givePerk(tableLookup(table, 0, i, 1), false);
      }
    }

    get_specialtydata(var_0, var_1, var_2) // iw3/h1 remnants? this sucks
    {
      var_3 = perktablelookupgroup(var_0);
      var_4 = perktablelookupcount(var_0);

      if(var_1 == "specialty1") {
        if(issubstr(var_3, "grenade")) {
          if(var_0 == "specialty_fraggrenade")
            self.perkscustom["grenades_count"] = var_4;
          else
            self.perkscustom["grenades_count"] = 1;

          if(var_0 == "specialty_specialgrenade" && isDefined(var_2.offhand) && var_2.offhand != "h1_smokegrenade_mp")
            self.perkscustom["specialgrenades_count"] = var_4;
          else
            self.perkscustom["specialgrenades_count"] = 1;

          return;
        } else {
          self.perkscustom["grenades_count"] = 1;
          self.perkscustom["specialgrenades_count"] = 1;
        }
      }

      if(var_3 == "inventory") {
        self.perkscustom["inventory"] = var_0;
        self.perkscustom["inventory_count"] = var_4;
      }
    }

    giveperkinventory() {
      var_0 = self.perkscustom["inventory"];

      if(isDefined(var_0) && var_0 != "") {
        var_0 = "h1_" + var_0;
        self giveweapon(var_0);
        setweaponammooverall(var_0, self.perkscustom["inventory_count"]);
        self setactionslot(3, "weapon", var_0);
      } else
        self setactionslot(3, "altMode");
    }

    setweaponammooverall(var_0, var_1) {
      if(isweaponcliponly(var_0))
        self setweaponammoclip(var_0, var_1);
      else {
        self setweaponammoclip(var_0, var_1);
        var_2 = var_1 - self getweaponammoclip(var_0);
        self setweaponammostock(var_0, var_2);
      }
    }