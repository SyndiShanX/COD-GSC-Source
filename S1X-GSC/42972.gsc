/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42972.gsc
**************************************/

init() {
  level.perkfuncs = [];
  level.specialty_finalstand_icon = "specialty_s1_temp";
  level.specialty_c4_death_icon = "specialty_s1_temp";
  level.specialty_compassping_revenge_icon = "specialty_s1_temp";
  level.specialty_juiced_icon = "specialty_s1_temp";

  if(!isDefined(level.iszombiegame) || !level.iszombiegame) {
    level.spawnglowmodel["enemy"] = "static_tactical_insertion_device";
    level.spawnglowmodel["friendly"] = "static_tactical_insertion_device";
    level.spawnglow["enemy"] = loadfx("vfx/props/tac_insert_enemy");
    level.spawnglow["friendly"] = loadfx("vfx/props/tac_insert_friendly");
    level.spawnfire = loadfx("vfx/explosion/mp_tac_explosion");
  }

  level._effect["ricochet"] = loadfx("fx/impacts/large_metalhit_1");
  level.scriptperks = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.scriptperks["specialty_blastshield"] = 1;
  level.scriptperks["_specialty_blastshield"] = 1;
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
  level.scriptperks["specialty_carepackage"] = 1;
  level.scriptperks["specialty_stopping_power"] = 1;
  level.scriptperks["specialty_uav"] = 1;
  level.scriptperks["bouncingbetty_mp"] = 1;
  level.scriptperks["c4_mp"] = 1;
  level.scriptperks["claymore_mp"] = 1;
  level.scriptperks["frag_grenade_mp"] = 1;
  level.scriptperks["semtex_mp"] = 1;
  level.scriptperks["tracking_drone_mp"] = 1;
  level.scriptperks["throwingknife_mp"] = 1;
  level.scriptperks["exoknife_mp"] = 1;
  level.scriptperks["exoknife_jug_mp"] = 1;
  level.scriptperks["paint_grenade_mp"] = 1;
  level.scriptperks["tri_drone_mp"] = 1;
  level.scriptperks["explosive_gel_mp"] = 1;
  level.scriptperks["frag_grenade_var_mp"] = 1;
  level.scriptperks["contact_grenade_var_mp"] = 1;
  level.scriptperks["semtex_grenade_var_mp"] = 1;
  level.scriptperks["stun_grenade_var_mp"] = 1;
  level.scriptperks["emp_grenade_var_mp"] = 1;
  level.scriptperks["paint_grenade_var_mp"] = 1;
  level.scriptperks["smoke_grenade_var_mp"] = 1;
  level.scriptperks["explosive_drone_mp"] = 1;
  level.scriptperks["concussion_grenade_mp"] = 1;
  level.scriptperks["flash_grenade_mp"] = 1;
  level.scriptperks["stun_grenade_mp"] = 1;
  level.scriptperks["smoke_grenade_mp"] = 1;
  level.scriptperks["emp_grenade_mp"] = 1;
  level.scriptperks["portable_radar_mp"] = 1;
  level.scriptperks["scrambler_mp"] = 1;
  level.scriptperks["trophy_mp"] = 1;
  level.scriptperks["s1_tactical_insertion_device_mp"] = 1;
  level.scriptperks["specialty_wildcard_perkslot1"] = 1;
  level.scriptperks["specialty_wildcard_perkslot2"] = 1;
  level.scriptperks["specialty_wildcard_perkslot3"] = 1;
  level.scriptperks["specialty_wildcard_primaryattachment"] = 1;
  level.scriptperks["specialty_wildcard_secondaryattachment"] = 1;
  level.scriptperks["specialty_wildcard_extrastreak"] = 1;
  level.scriptperks["specialty_null"] = 1;
  level.perksetfuncs["specialty_blastshield"] = maps\mp\perks\_perkfunctions::setblastshield;
  level.perkunsetfuncs["specialty_blastshield"] = maps\mp\perks\_perkfunctions::unsetblastshield;
  level.perksetfuncs["specialty_falldamage"] = maps\mp\perks\_perkfunctions::setfreefall;
  level.perkunsetfuncs["specialty_falldamage"] = maps\mp\perks\_perkfunctions::unsetfreefall;
  level.perksetfuncs["specialty_localjammer"] = maps\mp\perks\_perkfunctions::setlocaljammer;
  level.perkunsetfuncs["specialty_localjammer"] = maps\mp\perks\_perkfunctions::unsetlocaljammer;
  level.perksetfuncs["specialty_thermal"] = maps\mp\perks\_perkfunctions::setthermal;
  level.perkunsetfuncs["specialty_thermal"] = maps\mp\perks\_perkfunctions::unsetthermal;
  level.perksetfuncs["specialty_blackbox"] = maps\mp\perks\_perkfunctions::setblackbox;
  level.perkunsetfuncs["specialty_blackbox"] = maps\mp\perks\_perkfunctions::unsetblackbox;
  level.perksetfuncs["specialty_lightweight"] = maps\mp\perks\_perkfunctions::setlightweight;
  level.perkunsetfuncs["specialty_lightweight"] = maps\mp\perks\_perkfunctions::unsetlightweight;
  level.perksetfuncs["specialty_steelnerves"] = maps\mp\perks\_perkfunctions::setsteelnerves;
  level.perkunsetfuncs["specialty_steelnerves"] = maps\mp\perks\_perkfunctions::unsetsteelnerves;
  level.perksetfuncs["specialty_delaymine"] = maps\mp\perks\_perkfunctions::setdelaymine;
  level.perkunsetfuncs["specialty_delaymine"] = maps\mp\perks\_perkfunctions::unsetdelaymine;
  level.perksetfuncs["specialty_saboteur"] = maps\mp\perks\_perkfunctions::setsaboteur;
  level.perkunsetfuncs["specialty_saboteur"] = maps\mp\perks\_perkfunctions::unsetsaboteur;
  level.perksetfuncs["specialty_endgame"] = maps\mp\perks\_perkfunctions::setendgame;
  level.perkunsetfuncs["specialty_endgame"] = maps\mp\perks\_perkfunctions::unsetendgame;
  level.perksetfuncs["specialty_rearview"] = maps\mp\perks\_perkfunctions::setrearview;
  level.perkunsetfuncs["specialty_rearview"] = maps\mp\perks\_perkfunctions::unsetrearview;
  level.perksetfuncs["specialty_onemanarmy"] = maps\mp\perks\_perkfunctions::setonemanarmy;
  level.perkunsetfuncs["specialty_onemanarmy"] = maps\mp\perks\_perkfunctions::unsetonemanarmy;
  level.perksetfuncs["specialty_steadyaimpro"] = maps\mp\perks\_perkfunctions::setsteadyaimpro;
  level.perkunsetfuncs["specialty_steadyaimpro"] = maps\mp\perks\_perkfunctions::unsetsteadyaimpro;
  level.perksetfuncs["specialty_stun_resistance"] = maps\mp\perks\_perkfunctions::setstunresistance;
  level.perkunsetfuncs["specialty_stun_resistance"] = maps\mp\perks\_perkfunctions::unsetstunresistance;
  level.perksetfuncs["specialty_marksman"] = maps\mp\perks\_perkfunctions::setmarksman;
  level.perkunsetfuncs["specialty_marksman"] = maps\mp\perks\_perkfunctions::unsetmarksman;
  level.perksetfuncs["specialty_double_load"] = maps\mp\perks\_perkfunctions::setdoubleload;
  level.perkunsetfuncs["specialty_double_load"] = maps\mp\perks\_perkfunctions::unsetdoubleload;
  level.perksetfuncs["specialty_sharp_focus"] = maps\mp\perks\_perkfunctions::setsharpfocus;
  level.perkunsetfuncs["specialty_sharp_focus"] = maps\mp\perks\_perkfunctions::unsetsharpfocus;
  level.perksetfuncs["specialty_regenspeed"] = maps\mp\perks\_perkfunctions::setregenspeed;
  level.perkunsetfuncs["specialty_regenspeed"] = maps\mp\perks\_perkfunctions::unsetregenspeed;
  level.perksetfuncs["specialty_autospot"] = maps\mp\perks\_perkfunctions::setautospot;
  level.perkunsetfuncs["specialty_autospot"] = maps\mp\perks\_perkfunctions::unsetautospot;
  level.perksetfuncs["specialty_empimmune"] = maps\mp\perks\_perkfunctions::setempimmune;
  level.perkunsetfuncs["specialty_empimmune"] = maps\mp\perks\_perkfunctions::unsetempimmune;
  level.perksetfuncs["specialty_overkill_pro"] = maps\mp\perks\_perkfunctions::setoverkillpro;
  level.perkunsetfuncs["specialty_overkill_pro"] = maps\mp\perks\_perkfunctions::unsetoverkillpro;
  level.perksetfuncs["specialty_personaluav"] = maps\mp\perks\_perkfunctions::setpersonaluav;
  level.perkunsetfuncs["specialty_personaluav"] = maps\mp\perks\_perkfunctions::unsetpersonaluav;
  level.perksetfuncs["specialty_crouchmovement"] = maps\mp\perks\_perkfunctions::setcrouchmovement;
  level.perkunsetfuncs["specialty_crouchmovement"] = maps\mp\perks\_perkfunctions::unsetcrouchmovement;
  level.perksetfuncs["specialty_light_armor"] = maps\mp\perks\_perkfunctions::setlightarmor;
  level.perkunsetfuncs["specialty_light_armor"] = maps\mp\perks\_perkfunctions::unsetlightarmor;
  level.perksetfuncs["specialty_finalstand"] = maps\mp\perks\_perkfunctions::setfinalstand;
  level.perkunsetfuncs["specialty_finalstand"] = maps\mp\perks\_perkfunctions::unsetfinalstand;
  level.perksetfuncs["specialty_juiced"] = maps\mp\perks\_perkfunctions::setjuiced;
  level.perkunsetfuncs["specialty_juiced"] = maps\mp\perks\_perkfunctions::unsetjuiced;
  level.perksetfuncs["specialty_carepackage"] = maps\mp\perks\_perkfunctions::setcarepackage;
  level.perkunsetfuncs["specialty_carepackage"] = maps\mp\perks\_perkfunctions::unsetcarepackage;
  level.perksetfuncs["specialty_stopping_power"] = maps\mp\perks\_perkfunctions::setstoppingpower;
  level.perkunsetfuncs["specialty_stopping_power"] = maps\mp\perks\_perkfunctions::unsetstoppingpower;
  level.perksetfuncs["specialty_uav"] = maps\mp\perks\_perkfunctions::setuav;
  level.perkunsetfuncs["specialty_uav"] = maps\mp\perks\_perkfunctions::unsetuav;
  initperkdvars();
  level thread onplayerconnect();
}

validateperk(var_0, var_1) {
  if(getdvarint("scr_game_perks") == 0) {
    return "specialty_null";
  }

  if(var_0 == 0 || var_0 == 1) {
    switch (var_1) {
      case "specialty_class_flakjacket":
      case "specialty_extended_battery":
      case "specialty_class_dangerclose":
      case "specialty_class_lightweight":
      case "specialty_class_lowprofile":
        return var_1;
      default:
        return "specialty_null";
    }
  } else if(var_0 == 2 || var_0 == 3) {
    switch (var_1) {
      case "specialty_class_dexterity":
      case "specialty_class_fasthands":
      case "specialty_class_peripherals":
      case "specialty_class_coldblooded":
      case "specialty_class_blindeye":
        return var_1;
      default:
        return "specialty_null";
    }
  } else if(var_0 == 4 || var_0 == 5) {
    switch (var_1) {
      case "specialty_exo_blastsuppressor":
      case "specialty_class_toughness":
      case "specialty_class_hardline":
      case "specialty_class_scavenger":
      case "specialty_class_hardwired":
        return var_1;
      default:
        return "specialty_null";
    }
  }

  return var_1;
}

getemptyperks() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++) {
    var_0[var_1] = "specialty_null";
  }

  return var_0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  self.perks = [];
  self.weaponlist = [];
  self.omaclasschanged = 0;

  for(;;) {
    self waittill("spawned_player");
    self.omaclasschanged = 0;
    thread maps\mp\gametypes\_scrambler::scramblerproximitytracker();
  }
}

cac_modified_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;
  var_10 = maps\mp\_utility::strip_suffix(var_4, "_lefthand");

  if(maps\mp\_utility::isbulletdamage(var_3)) {
    if(isplayer(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_paint_pro") && !maps\mp\_utility::iskillstreakweapon(var_4) && isplayer(var_0) && !var_0 maps\mp\_utility::_hasperk("specialty_class_lowprofile")) {
      if(!var_0 maps\mp\perks\_perkfunctions::ispainted()) {
        var_1 maps\mp\gametypes\_missions::processchallenge("ch_bulletpaint");
      }

      if(var_1.trackrounds.has_trackrounds) {
        var_0 thread maps\mp\_trackrounds::set_painted_trackrounds(var_1);
      }

      var_0 thread maps\mp\perks\_perkfunctions::setpainted(var_1);
    }

    if(isplayer(var_1) && isDefined(var_4) && maps\mp\_utility::getweaponclass(var_4) == "weapon_sniper" && issubstr(var_4, "silencer")) {
      var_2 = var_2 * 0.75;
    }

    if(isplayer(var_1) && (var_1 maps\mp\_utility::_hasperk("specialty_bulletdamage") && var_0 maps\mp\_utility::_hasperk("specialty_armorvest"))) {
      var_9 = var_9 + 0;
    } else if(isplayer(var_1) && (var_1 maps\mp\_utility::_hasperk("specialty_bulletdamage") || var_1 maps\mp\_utility::_hasperk("specialty_moredamage"))) {
      var_9 = var_9 + var_2 * level.bulletdamagemod;
    } else if(var_0 maps\mp\_utility::_hasperk("specialty_armorvest")) {
      var_9 = var_9 - var_2 * level.armorvestmod;
    }

    if(var_0 maps\mp\_utility::isjuggernaut()) {
      var_11 = isDefined(var_0.juggernautweak) && var_0.juggernautweak && (var_7 == "head" || var_7 == "helmet");

      if(!var_11) {
        var_2 = var_2 * level.juggernautmod;
      }
    }
  } else if(isexplosivedamagemod(var_3)) {
    if(isplayer(var_1) && var_1 != var_0 && (var_1 isitemunlocked("specialty_paint") && var_1 maps\mp\_utility::_hasperk("specialty_paint")) && !maps\mp\_utility::iskillstreakweapon(var_4)) {
      if(!var_0 maps\mp\perks\_perkfunctions::ispainted()) {
        var_1 maps\mp\gametypes\_missions::processchallenge("ch_paint_pro");
      }

      var_0 thread maps\mp\perks\_perkfunctions::setpainted(var_1);
    }

    if(isplayer(var_1) && weaponinheritsperks(var_4) && (var_1 maps\mp\_utility::_hasperk("specialty_explosivedamage") && var_0 maps\mp\_utility::_hasperk("_specialty_blastshield"))) {
      var_9 = var_9 + 0;
    } else if(isplayer(var_1) && weaponinheritsperks(var_4) && var_1 maps\mp\_utility::_hasperk("specialty_explosivedamage")) {
      var_9 = var_9 + var_2 * level.explosivedamagemod;
    } else if(var_0 maps\mp\_utility::_hasperk("_specialty_blastshield") && isDefined(var_0.specialty_blastshield_bonus) && (var_10 != "semtex_mp" || var_2 < 125)) {
      var_9 = var_9 - int(var_2 * var_0.specialty_blastshield_bonus);
    }

    if(maps\mp\_utility::iskillstreakweapon(var_4) && isplayer(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_explosivedamage")) {
      var_9 = var_9 + var_2 * level.explosivedamagemod;
    }

    if(var_0 maps\mp\_utility::isjuggernaut()) {
      switch (var_4) {
        case "ac130_25mm_mp":
          var_2 = var_2 * level.juggernautmod;
          break;
        case "remotemissile_projectile_gas_mp":
        case "remotemissile_projectile_cluster_parent_mp":
        case "remotemissile_projectile_mp":
          if(var_2 < 350) {
            if(var_2 > 1) {
              var_2 = var_2 * level.juggernautmod;
            }
          }

          break;
        default:
          if(var_2 < 1000) {
            if(var_2 > 1) {
              var_2 = var_2 * level.juggernautmod;
            }
          }

          break;
      }
    }

    if(maps\mp\gametypes\_weapons::ingrenadegraceperiod()) {
      var_2 = var_2 * level.juggernautmod;
    }
  } else if(var_3 == "MOD_FALLING") {
    if(var_0 isitemunlocked("specialty_falldamage") && var_0 maps\mp\_utility::_hasperk("specialty_falldamage")) {
      var_9 = 0;
      var_2 = 0;
    }
  } else if(maps\mp\_utility::ismeleemod(var_3)) {
    if(isDefined(var_0.haslightarmor) && var_0.haslightarmor) {
      if(issubstr(var_4, "riotshield") || var_4 == "exoshield_equipment_mp") {
        var_2 = int(var_0.maxhealth * 0.66);
      } else {
        var_2 = var_0.maxhealth + 1;
      }
    }

    if(var_0 maps\mp\_utility::isjuggernaut()) {
      var_2 = 20;
      var_9 = 0;
    }
  } else if(var_3 == "MOD_IMPACT") {
    if(var_0 maps\mp\_utility::isjuggernaut()) {
      switch (var_10) {
        case "smoke_grenade_var_mp":
        case "stun_grenade_var_mp":
        case "smoke_grenade_mp":
        case "stun_grenade_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "semtex_mp":
        case "stun_grenade_horde_mp":
        case "frag_grenade_mp":
          var_2 = 5;
          break;
        default:
          if(var_2 < 1000) {
            var_2 = 25;
          }

          break;
      }

      var_9 = 0;
    }
  }

  var_12 = getweaponbasename(var_4);

  if(isDefined(var_0.lightarmorhp) && isDefined(var_12)) {
    switch (var_12) {
      case "exoknife_mp":
      case "exoknife_jug_mp":
        var_2 = var_0.health;
        var_9 = 0;
        break;
      case "semtex_mp":
      case "semtexproj_mp":
        if(isDefined(var_8) && isDefined(var_8.stuckenemyentity) && var_8.stuckenemyentity == var_0) {
          var_2 = var_0.health;
          var_9 = 0;
        }

        break;
      default:
        if(var_3 != "MOD_FALLING" && !maps\mp\_utility::ismeleemod(var_3) && !maps\mp\_utility::isheadshot(var_12, var_7, var_3, var_1) && !maps\mp\_utility::isfmjdamage(var_12, var_3, var_1)) {
          var_0 maps\mp\perks\_perkfunctions::setlightarmorhp(var_0.lightarmorhp - (var_2 + var_9));
          var_2 = 0;
          var_9 = 0;

          if(var_0.lightarmorhp <= 0) {
            var_2 = abs(var_0.lightarmorhp);
            var_9 = 0;
            maps\mp\perks\_perkfunctions::unsetlightarmor();
          }
        }

        break;
    }
  }

  if(var_2 <= 1) {
    var_2 = 1;
    return var_2;
  } else {
    return int(var_2 + var_9);
  }
}

initperkdvars() {
  level.juggernautmod = 0.08;
  level.juggernatudefmod = 0.08;
  level.armorpiercingmod = 1.5;
  level.regenhealthmod = 0.25;
  level.bulletdamagemod = maps\mp\_utility::getintproperty("perk_bulletDamage", 12) / 100;
  level.explosivedamagemod = maps\mp\_utility::getintproperty("perk_explosiveDamage", 10) / 100;
  level.riotshieldmod = maps\mp\_utility::getintproperty("perk_riotShield", 100) / 100;
  level.armorvestmod = maps\mp\_utility::getintproperty("perk_armorVest", 20) / 100;
}

cac_selector() {}

giveblindeyeafterspawn() {
  self endon("death");
  self endon("disconnect");
  maps\mp\_utility::giveperk("specialty_blindeye", 0);
  self.spawnperk = 1;

  while(self.avoidkillstreakonspawntimer > 0) {
    self.avoidkillstreakonspawntimer = self.avoidkillstreakonspawntimer - 0.05;
    wait 0.05;
  }

  maps\mp\_utility::_unsetperk("specialty_blindeye");
  self.spawnperk = 0;
}

applyperks() {
  self setviewkickscale(0.5);

  if(maps\mp\_utility::_hasperk("specialty_extended_battery")) {
    maps\mp\_utility::giveperk("specialty_exo_slamboots", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_lowprofile")) {
    maps\mp\_utility::giveperk("specialty_radarimmune", 0);
    maps\mp\_utility::giveperk("specialty_exoping_immune", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_flakjacket")) {
    maps\mp\_utility::giveperk("specialty_hard_shell", 0);
    maps\mp\_utility::giveperk("specialty_throwback", 0);
    maps\mp\_utility::giveperk("_specialty_blastshield", 0);
    self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale", 45) / 100;

    if(isDefined(level.hardcoremode) && level.hardcoremode) {
      self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC", 50) / 100;
    }
  }

  if(maps\mp\_utility::_hasperk("specialty_class_lightweight")) {
    maps\mp\_utility::giveperk("specialty_lightweight", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_dangerclose")) {
    maps\mp\_utility::giveperk("specialty_explosivedamage", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_blindeye")) {
    maps\mp\_utility::giveperk("specialty_blindeye", 0);
    maps\mp\_utility::giveperk("specialty_plainsight", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_coldblooded")) {
    maps\mp\_utility::giveperk("specialty_coldblooded", 0);
    maps\mp\_utility::giveperk("specialty_spygame", 0);
    maps\mp\_utility::giveperk("specialty_heartbreaker", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_peripherals") || maps\mp\_utility::practiceroundgame()) {
    maps\mp\_utility::giveperk("specialty_moreminimap", 0);
    maps\mp\_utility::giveperk("specialty_silentkill", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_fasthands")) {
    maps\mp\_utility::giveperk("specialty_quickswap", 0);
    maps\mp\_utility::giveperk("specialty_fastoffhand", 0);
    maps\mp\_utility::giveperk("specialty_sprintreload", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_dexterity")) {
    maps\mp\_utility::giveperk("specialty_sprintfire", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_hardwired")) {
    maps\mp\_utility::giveperk("specialty_empimmune", 0);
    maps\mp\_utility::giveperk("specialty_stun_resistance", 0);
    self.stunscaler = 0.1;
  }

  if(maps\mp\_utility::_hasperk("specialty_class_toughness")) {
    self setviewkickscale(0.2);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_scavenger")) {
    self.ammopickup_scalar = 0.2;
    maps\mp\_utility::giveperk("specialty_scavenger", 0);
    maps\mp\_utility::giveperk("specialty_bulletresupply", 0);
    maps\mp\_utility::giveperk("specialty_extraammo", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_hardline")) {
    maps\mp\_utility::giveperk("specialty_hardline", 0);
  }
}