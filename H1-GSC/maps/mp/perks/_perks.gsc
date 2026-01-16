/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\perks\_perks.gsc
********************************/

init() {
  level.perkfuncs = [];
  level.specialty_finalstand_icon = "specialty_pistoldeath";
  level.specialty_c4_death_icon = "specialty_s1_temp";
  level.specialty_compassping_revenge_icon = "specialty_s1_temp";
  level.specialty_juiced_icon = "specialty_s1_temp";
  precacheshader(level.specialty_finalstand_icon);
  level.scriptperks = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.scriptperks["specialty_blastshield"] = 1;
  level.scriptperks["specialty_blastshield2"] = 1;
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
  level.perksetfuncs["specialty_stopping_power"] = maps\mp\perks\_perkfunctions::setstoppingpower;
  level.perkunsetfuncs["specialty_stopping_power"] = maps\mp\perks\_perkfunctions::unsetstoppingpower;
  level.perksetfuncs["specialty_uav"] = maps\mp\perks\_perkfunctions::setuav;
  level.perkunsetfuncs["specialty_uav"] = maps\mp\perks\_perkfunctions::unsetuav;
  initperkdvars();
  level thread onplayerconnect();
}

perktablelookupgroup(var_0) {
  return tablelookup("mp\perktable.csv", 1, var_0, 13);
}

perktablelookupcount(var_0) {
  return int(tablelookup("mp\perktable.csv", 1, var_0, 6));
}

perktablelookupslot(var_0) {
  return int(tablelookup("mp\perktable.csv", 1, var_0, 12));
}

perktablelookuplocalizedname(var_0) {
  return tablelookupistring("mp\perktable.csv", 1, var_0, 2);
}

perktablelookupimage(var_0) {
  return tablelookup("mp\perktable.csv", 1, var_0, 3);
}

validateperk(var_0, var_1) {
  if(getdvarint("scr_game_perks") == 0)
    return "specialty_null";

  if(var_0 == 0) {
    switch (var_1) {
      case "specialty_detectexplosive":
      case "specialty_fraggrenade":
      case "rpg_mp":
      case "c4_mp":
      case "specialty_extraammo":
      case "specialty_specialgrenade":
      case "claymore_mp":
        return var_1;
      default:
        return "specialty_null";
    }
  } else if(var_0 == 1) {
    switch (var_1) {
      case "specialty_radarimmune":
      case "specialty_rof":
      case "specialty_fastreload":
      case "specialty_armorvest":
      case "specialty_bulletdamage":
      case "specialty_twoprimaries":
      case "specialty_explosivedamage":
        return var_1;
      default:
        return "specialty_null";
    }
  } else if(var_0 == 2) {
    switch (var_1) {
      case "specialty_parabolic":
      case "specialty_quieter":
      case "specialty_holdbreath":
      case "specialty_grenadepulldeath":
      case "specialty_bulletaccuracy":
      case "specialty_longersprint":
      case "specialty_pistoldeath":
      case "specialty_bulletpenetration":
        return var_1;
      default:
        return "specialty_null";
    }
  }

  return "specialty_null";
}

getemptyperks() {
  var_0 = [];

  for (var_1 = 0; var_1 < 3; var_1++)
    var_0[var_1] = "specialty_null";

  return var_0;
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  self.perks = [];
  self.weaponlist = [];
}

cac_modified_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isdefined(var_0) || !isdefined(var_1) || !isplayer(var_1) || !maps\mp\_utility::invirtuallobby() && !isplayer(var_0))
    return var_2;

  if(var_1.sessionstate != "playing" || !isdefined(var_2) || !isdefined(var_3))
    return var_2;

  if(var_3 == "")
    return var_2;

  var_9 = var_2;
  var_10 = var_2;

  if(isdefined(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_bulletdamage") && maps\mp\_utility::isbulletdamage(var_3)) {
    if(isdefined(var_0) && isplayer(var_0) && var_0 maps\mp\_utility::_hasperk("specialty_armorvest"))
      var_10 = var_9;
    else
      var_10 = var_10 + var_2 * level.bulletdamagemod;
  } else if(isdefined(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_explosivedamage") && isexplosivedamagemod(var_3)) {
    if(isdefined(var_0) && isplayer(var_0) && var_0 maps\mp\_utility::_hasperk("specialty_armorvest"))
      var_10 = var_9;
    else
      var_10 = var_10 + var_2 * level.explosivedamagemod;
  } else if(isdefined(var_0) && isplayer(var_0) && var_0 maps\mp\_utility::_hasperk("specialty_armorvest"))
    var_10 = var_10 - var_2 * level.armorvestmod;
  else
    var_10 = var_9;

  if(isexplosivedamagemod(var_3)) {
    if(maps\mp\gametypes\_weapons::ingrenadegraceperiod())
      var_10 = var_10 * level.juggernautmod;
  }

  if(var_10 <= 1) {
    var_10 = 1;
    return var_10;
  } else
    return int(var_10);
}

initperkdvars() {
  level.juggernautmod = 0.08;
  level.juggernatudefmod = 0.08;
  level.armorpiercingmod = 1.5;
  level.regenhealthmod = 0.25;
  level.bulletdamagemod = maps\mp\_utility::getintproperty("perk_bulletDamage", 40) / 100;
  level.explosivedamagemod = maps\mp\_utility::getintproperty("perk_explosiveDamage", 25) / 100;
  level.armorvestmod = maps\mp\_utility::getintproperty("perk_armorVest", 25) / 100;
}

cac_selector() {}

giveblindeyeafterspawn() {
  self endon("death");
  self endon("disconnect");
  maps\mp\_utility::giveperk("specialty_blindeye", 0);
  self.spawnperk = 1;

  while (self.avoidkillstreakonspawntimer > 0) {
    self.avoidkillstreakonspawntimer = self.avoidkillstreakonspawntimer - 0.05;
    wait 0.05;
  }

  maps\mp\_utility::_unsetperk("specialty_blindeye");
  self.spawnperk = 0;
}

applyperks() {
  self setviewkickscale(1.0);

  if(maps\mp\_utility::_hasperk("specialty_extended_battery"))
    maps\mp\_utility::giveperk("specialty_exo_slamboots", 0);

  if(maps\mp\_utility::_hasperk("specialty_class_lowprofile"))
    maps\mp\_utility::giveperk("specialty_radarimmune", 0);

  if(maps\mp\_utility::_hasperk("specialty_class_flakjacket")) {
    maps\mp\_utility::giveperk("specialty_hard_shell", 0);
    maps\mp\_utility::giveperk("specialty_throwback", 0);
    maps\mp\_utility::giveperk("specialty_blastshield2", 0);
    self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale", 45) / 100;

    if(isdefined(level.hardcoremode) && level.hardcoremode)
      self.specialty_blastshield_bonus = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC", 50) / 100;
  }

  if(maps\mp\_utility::_hasperk("specialty_class_lightweight"))
    maps\mp\_utility::giveperk("specialty_lightweight", 0);

  if(maps\mp\_utility::_hasperk("specialty_class_dangerclose"))
    maps\mp\_utility::giveperk("specialty_explosivedamage", 0);

  if(maps\mp\_utility::_hasperk("specialty_class_blindeye")) {
    maps\mp\_utility::giveperk("specialty_blindeye", 0);
    maps\mp\_utility::giveperk("specialty_plainsight", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_coldblooded")) {
    maps\mp\_utility::giveperk("specialty_coldblooded", 0);
    maps\mp\_utility::giveperk("specialty_spygame", 0);
    maps\mp\_utility::giveperk("specialty_heartbreaker", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_peripherals")) {
    maps\mp\_utility::giveperk("specialty_moreminimap", 0);
    maps\mp\_utility::giveperk("specialty_silentkill", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_fasthands")) {
    maps\mp\_utility::giveperk("specialty_quickswap", 0);
    maps\mp\_utility::giveperk("specialty_fastoffhand", 0);
    maps\mp\_utility::giveperk("specialty_sprintreload", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_dexterity"))
    maps\mp\_utility::giveperk("specialty_sprintfire", 0);

  if(maps\mp\_utility::_hasperk("specialty_class_hardwired")) {
    maps\mp\_utility::giveperk("specialty_empimmune", 0);
    maps\mp\_utility::giveperk("specialty_stun_resistance", 0);
    self.stunscaler = 0.1;
  }

  if(maps\mp\_utility::_hasperk("specialty_class_toughness"))
    self setviewkickscale(0.2);

  if(maps\mp\_utility::_hasperk("specialty_class_scavenger")) {
    self.ammopickup_scalar = 0.2;
    maps\mp\_utility::giveperk("specialty_scavenger", 0);
    maps\mp\_utility::giveperk("specialty_bulletresupply", 0);
    maps\mp\_utility::giveperk("specialty_extraammo", 0);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_hardline"))
    maps\mp\_utility::giveperk("specialty_hardline", 0);
}

get_specialtydata(var_0, var_1, var_2) {
  var_3 = perktablelookupgroup(var_0);
  var_4 = perktablelookupcount(var_0);

  if(var_1 == "specialty1") {
    if(issubstr(var_3, "grenade")) {
      if(var_0 == "specialty_fraggrenade")
        self.perkscustom["grenades_count"] = var_4;
      else
        self.perkscustom["grenades_count"] = 1;

      if(var_0 == "specialty_specialgrenade" && isdefined(var_2.offhand) && var_2.offhand != "h1_smokegrenade_mp")
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

  if(isdefined(var_0) && var_0 != "") {
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