/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perkfunctions.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\uav_tower;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\archetypes\archassault;
#using scripts\mp\class;
#using scripts\mp\destructible;
#using scripts\mp\door;
#using scripts\mp\equipment;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\equipment\snapshot_grenade;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\lightarmor;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\perks\perk_mark_targets;
#using scripts\mp\perks\perks;
#using scripts\mp\rank;
#using scripts\mp\spawncamera;
#using scripts\mp\supers;
#using scripts\mp\teamrevive;
#using scripts\mp\tweakables;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\usability;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace perkfunctions;

function sethealer() {
  thread radialhealer();
}

function radialhealer() {
  self endon("unset_healer");
  self endon("disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }

  self.teammateswithhealperk = [];

  while(true) {
    if(player_utility::_isalive()) {
      players = player::getplayersinradius(self.origin, 350, self.team, self);

      foreach(player in players) {
        if(player perk::_hasperk("specialty_healer")) {
          continue;
        }

        if(self.team == player.team && player player_utility::_isalive() && !isDefined(player.healer)) {
          playerentitynum = player getentitynumber();

          if(self.teammateswithhealperk.size == 0) {
            hud_message::showmiscmessage("healing_players");
          }

          player.healer = self;
          self.teammateswithhealperk[playerentitynum] = 1;
          player perk::giveperk("specialty_regenfaster");
          player perk::giveperk("specialty_regen_delay_reduced");
          player hud_message::showmiscmessage("in_healing_range");
          givehealedoverlay(player);
          thread healerperkteammatewatcher(player);
          thread healerperkteammatedestructor(player);
        }
      }
    }

    wait 0.3;
  }
}

function healerperkteammatewatcher(player) {
  level endon("game_ended");
  self endon("unset_healer");
  self endon("death_or_disconnect");
  player endon("death_or_disconnect");

  while(true) {
    lim = 400;

    if(distancesquared(self.origin, player.origin) > lim * lim || player.team != self.team) {
      player notify("out_of_healing_range");
      return;
    }

    playerentitynum = player getentitynumber();

    if(player.health < player.maxhealth && player.healedoverlay.alpha == player.healedoverlay.lowalpha) {
      player thread healedoverlayfade(player.healedoverlay, self, player.healedoverlay.highalpha);
    } else if(player.health == player.maxhealth) {
      player thread healedoverlayfade(player.healedoverlay, self, player.healedoverlay.lowalpha);
    }

    wait 0.1;
  }
}

function healerperkteammatedestructor(player) {
  level endon("game_ended");
  playerentitynum = player getentitynumber();
  waittill_any_ents(self, "unset_healer", self, "death_or_disconnect", player, "death_or_disconnect", player, "out_of_healing_range");

  if(isDefined(player)) {
    player perk::removeperk("specialty_regenfaster");
    player perk::removeperk("specialty_regen_delay_reduced");
    player.healer = undefined;
    player hud_message::showmiscmessage("out_of_healing_range");
  }

  if(isDefined(self)) {
    self.teammateswithhealperk[playerentitynum] = undefined;

    if(self.teammateswithhealperk.size == 0) {
      hud_message::showmiscmessage("no_healing_players");
    }
  }
}

function unsethealer() {
  self notify("unset_healer");
}

function givehealedoverlay(player) {
  healedoverlay = newclienthudelem(player);
  healedoverlay.x = 0;
  healedoverlay.y = 0;
  healedoverlay setshader("overlay_healer", 640, 480);
  healedoverlay.alignx = "left";
  healedoverlay.aligny = "top";
  healedoverlay.horzalign = "fullscreen";
  healedoverlay.vertalign = "fullscreen";
  healedoverlay.alpha = 0;
  healedoverlay.lowalpha = 0;
  healedoverlay.highalpha = 0.75;
  player.healedoverlay = healedoverlay;
  player thread healedoverlayfade(healedoverlay, self, healedoverlay.lowalpha);
  player thread healedoverlaydestructor(healedoverlay, self);
}

function healedoverlayfade(healedoverlay, healer, final) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("out_of_healing_range");
  healer endon("death_or_disconnect");
  healer endon("unset_healer");
  healedoverlay fadeovertime(0.5);
  healedoverlay.alpha = final;
}

function healedoverlaydestructor(healedoverlay, healer) {
  waittill_any_ents(level, "game_ended", healer, "unset_healer", healer, "death_or_disconnect", self, "death_or_disconnect", self, "out_of_healing_range");

  if(isDefined(healedoverlay)) {
    healedoverlay fadeovertime(1);
    healedoverlay.alpha = 0;
    wait 1;
    healedoverlay destroy();
  }
}

function setbreacher() {
  door::updatealldoorslockvisibilityforplayer(self, 1);
}

function unsetbreacher() {
  door::updatealldoorslockvisibilityforplayer(self, 0);
}

function setoffhandprovider() {
  thread offhandproviderthread();
}

function offhandproviderthread() {
  level endon("game_ended");
  self endon("unset_offhand_provider");
  self endon("death_or_disconnect");

  while(true) {
    players = player::getplayersinradius(self.origin, 144, self.team, self);

    foreach(player in players) {
      if(!isDefined(player.ohpequipmentrefills)) {
        player.ohpequipmentrefills = [];
      }

      if(player equipmentusedbyslot("primary") == 0 && player equipmentusedbyslot("secondary") == 0) {
        continue;
      }

      if(!isDefined(player.ohpequipmentrefills[self getentitynumber()]) && player player_utility::_isalive()) {
        player.ohpequipmentrefills[self getentitynumber()] = 1;
        equipmentfilled = player refillequipment();

        for(i = 0; i < equipmentfilled["primary"]; i++) {
          player thread ohpequipmentfillednotification(self.name, player equipment::getcurrentequipment("primary"));
        }

        for(i = 0; i < equipmentfilled["secondary"]; i++) {
          player thread ohpequipmentfillednotification(self.name, player equipment::getcurrentequipment("secondary"));
        }

        thread ohpallowuseonplayerdeath(player);
        player playsoundtoplayer("scavenger_pack_pickup", player);
      }
    }

    wait 0.1;
  }
}

function ohpallowuseonplayerdeath(player) {
  level endon("game_ended");
  player endon("disconnect");
  entnum = self getentitynumber();
  utility::waittill_any_ents_return(self, "disconnect", player, "death");
  player.ohpequipmentrefills[entnum] = undefined;
}

function unsetoffhandprovider() {
  self notify("unset_offhand_provider");
}

function refillequipment() {
  var_7bad5d0b3ab39f16 = [];
  var_7bad5d0b3ab39f16["primary"] = equipmentusedbyslot("primary", 1);
  var_7bad5d0b3ab39f16["secondary"] = equipmentusedbyslot("secondary", 1);
  return var_7bad5d0b3ab39f16;
}

function equipmentusedbyslot(slot, refill) {
  assertex(slot == "<dev string:x1c>" || slot == "<dev string:x27>", "<dev string:x34>");

  if(!isDefined(refill)) {
    refill = 0;
  }

  eq = equipment::getcurrentequipment(slot);
  eqcap = getequipmentstartammo(slot);
  var_bd0ead7ae63d86d = equipment::getequipmentammo(eq);

  if(refill && eqcap - var_bd0ead7ae63d86d > 0) {
    equipment::incrementequipmentammo(eq, eqcap - var_bd0ead7ae63d86d);
  }

  return eqcap - var_bd0ead7ae63d86d;
}

function getequipmentstartammo(slot) {
  assertex(slot == "<dev string:x1c>" || slot == "<dev string:x27>", "<dev string:x34>");
  eq = equipment::getcurrentequipment(slot);
  eqcap = equipment::getequipmentstartammo(eq);

  if(slot == "primary" && perk::_hasperk("specialty_extra_deadly")) {
    eqcap = equipment::getequipmentmaxammo(eq);
  }

  if(slot == "secondary" && perk::_hasperk("specialty_extra_tactical")) {
    eqcap = equipment::getequipmentmaxammo(eq);
  }

  return eqcap;
}

function ohpequipmentfillednotification(ohpname, equip) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.munitionsnotifications)) {
    self.munitionsnotifications = [];
  }

  size = self.munitionsnotifications.size;

  for(i = 0; i < size; i++) {
    if(i < 2) {
      thread movenotificationup(self.munitionsnotifications[i]);
      continue;
    }

    notif = self.munitionsnotifications[i];
    self.munitionsnotifications[i] = undefined;
    notif notify("delete_icon_elem");
  }

  finalx = 620;
  finaly = 360;
  x = 352;
  y = 264;
  iconelem = newclienthudelem(self);
  iconelem.x = x;
  iconelem.y = y;
  iconelem.alignx = "right";
  iconelem.aligny = "top";
  iconelem.sort = 2;
  iconelem.alpha = 0;
  equipinfo = equipment::getequipmenttableinfo(equip);

  if(isDefined(equipinfo)) {
    iconelem setshader(equipinfo.image, 25, 25);
  }

  iconelem fadeovertime(0.15);
  iconelem moveovertime(0.35);
  iconelem.alpha = 1;
  iconelem.x = finalx;
  iconelem.y = finaly;
  self.munitionsnotifications = utility::array_insert(self.munitionsnotifications, iconelem, 0);
  iconelem endon("delete_icon_elem");
  thread ohpcleanupnotificationondeath(iconelem);
  iconelem.isanimating = 1;
  wait 0.35;
  iconelem.isanimating = 0;
  wait 3;
  iconelem fadeovertime(0.5);
  iconelem.alpha = 0;
  wait 0.5;
  iconelem notify("delete_icon_elem");
}

function ohpcleanupnotificationondeath(iconelem) {
  level endon("game_ended");
  utility::waittill_any_ents(self, "death_or_disconnect", iconelem, "delete_icon_elem");

  if(isDefined(self)) {
    self.munitionsnotifications = utility::array_remove(self.munitionsnotifications, iconelem);
  }

  iconelem destroy();
}

function movenotificationup(iconelem) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  iconelem endon("delete_icon_elem");

  if(!istrue(iconelem.isanimating)) {
    iconelem moveovertime(0.35);
  }

  iconelem.y -= 25;
  wait 0.35;
}

function setoverkillpro() {}

function unsetoverkillpro() {}

function setempimmune() {}

function unsetempimmune() {}

function setautospot() {
  if(!isPlayer(self)) {
    return;
  }

  autospotadswatcher();
  autospotdeathwatcher();
}

function autospotdeathwatcher() {
  self waittill("death");
  self endon("disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  self autospotoverlayoff();
}

function unsetautospot() {
  if(!isPlayer(self)) {
    return;
  }

  self notify("endAutoSpotAdsWatcher");
  self autospotoverlayoff();
}

function autospotadswatcher() {
  self endon("death_or_disconnect");
  self endon("endAutoSpotAdsWatcher");
  level endon("game_ended");
  spotter = 0;

  for(;;) {
    waitframe();

    if(self isusingturret()) {
      self autospotoverlayoff();
      continue;
    }

    adslevel = self playerads();

    if(adslevel < 1 && spotter) {
      spotter = 0;
      self autospotoverlayoff();
    }

    if(adslevel < 1 && !spotter) {
      continue;
    }

    if(adslevel == 1 && !spotter) {
      spotter = 1;
      self autospotoverlayon();
    }
  }
}

function setregenfaster() {}

function unsetregenfaster() {}

function timeoutregenfaster() {
  self.hasregenfaster = undefined;
  perk::removeperk("specialty_regenfaster");
  self setclientdvar(@ "hash_c0673d13f0144bfb", 0);
  self notify("timeOutRegenFaster");
}

function sethardshell() {
  self.shellshockreduction = 0.25;
}

function unsethardshell() {
  self.shellshockreduction = 0;
}

function setsharpfocus() {
  thread monitorsharpfocus();
}

function monitorsharpfocus() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("stop_monitorSharpFocus");

  for(;;) {
    updatesharpfocus();
    self waittill("weapon_change");
  }
}

function updatesharpfocus() {
  newweapon = self.currentweapon;
  scale = undefined;
  flinchtype = weapon::weapongetflinchtype(newweapon);

  if(flinchtype == 4) {
    scale = 1;
  } else if(flinchtype == 3) {
    scale = 1;
  } else if(flinchtype == 1) {
    scale = 1;
  } else {
    scale = 1;
  }

  weapons::updateviewkickscale(scale);
}

function unsetsharpfocus() {
  self notify("stop_monitorSharpFocus");
  weapons::updateviewkickscale(1);
}

function updatedefaultflinchreduction() {
  if(isagent(self)) {
    return;
  }

  scale = undefined;
  flinchtype = weapon::weapongetflinchtype(self.currentweapon);

  if(flinchtype == 4) {
    scale = 1;
  } else if(flinchtype == 3) {
    scale = 1;
  } else if(flinchtype == 1) {
    scale = 1;
  } else {
    scale = 1;
  }

  weapons::updateviewkickscale(scale);
}

function ammodisabling_run(victim, isthrowstar, additionaltime) {
  victim notify("disablingRun");
  victim endon("disablingRun");
  victim endon("disconnect");
  level endon("game_ended");

  if(!isDefined(victim.disabledspeedmod)) {
    victim.disabledspeedmod = -0.05;
    victim weapons::updatemovespeedscale();
    victim ammodisabling_impair();
  }

  if(isthrowstar) {
    timer = 0.4;
  } else {
    timer = 0.2;
  }

  if(!istrue(isthrowstar) && victim _hasperk("specialty_frangible_resist")) {
    timer *= 1 + getdvarfloat(@ "hash_47984606bec7ddf7", -0.5);
  }

  if(isDefined(additionaltime)) {
    timer += additionaltime;
  }

  currtime = gettime();

  if(!isDefined(victim.disabledshocktime) || currtime - victim.disabledshocktime > 200 || isthrowstar) {
    if(isthrowstar) {
      duration = 0.4;
    } else {
      duration = 0.2;
    }

    victim shellshock("chargemode_mp", duration);
    victim.disabledshocktime = currtime;
  }

  while(isalive(victim) && timer > 0) {
    timer -= level.framedurationseconds;
    waitframe();
  }

  victim ammodisabling_impairend();
  victim.disabledspeedmod = undefined;
  victim.disabledshocktime = undefined;
  victim weapons::updatemovespeedscale();
}

function ammodisabling_impair() {
  val::set("ammoDisabling", "jog", 0);
  val::set("ammoDisabling", "sprint", 0);
  val::set("ammoDisabling", "slide", 0);
  val::set("ammoDisabling", "allow_jump", 0);
}

function ammodisabling_impairend() {
  val::reset_all("ammoDisabling");
}

function setviewkickoverride() {
  self.overrideviewkickscale = getdvarfloat(@ "hash_31381fbc6af88e90", 0.7);
  self.overrideviewkickscaledmr = getdvarfloat(@ "hash_d92f9fdbd9218170", 0.7);
  self.overrideviewkickscalesniper = getdvarfloat(@ "hash_7c78c2f583a1c0e", 0.7);
  self.overrideviewkickscalepistol = getdvarfloat(@ "hash_904eb284a2b8107e", 0.7);
  weapons::updateviewkickscale();
}

function unsetviewkickoverride() {
  self.overrideviewkickscale = undefined;
  self.overrideviewkickscaledmr = undefined;
  self.overrideviewkickscalesniper = undefined;
  self.overrideviewkickscalepistol = undefined;
  weapons::updateviewkickscale();
}

function setaffinityspeedboost() {
  self.weaponaffinityspeedboost = 0.08;
  weapons::updatemovespeedscale();
}

function unsetaffinityspeedboost() {
  self.weaponaffinityspeedboost = undefined;
  weapons::updatemovespeedscale();
}

function setaffinityextralauncher() {
  self.weaponaffinityextralauncher = 1;
  primary = weapon::buildweapon(self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle, self.loadoutprimaryvariantid);
  secondary = weapon::buildweapon(self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle, self.loadoutsecondaryvariantid);

  if(weapon::getweapongroup(primary.basename) == "weapon_projectile") {
    self setweaponammoclip(primary, weaponclipsize(primary));
  }

  if(weapon::getweapongroup(secondary.basename) == "weapon_projectile") {
    self setweaponammoclip(secondary, weaponclipsize(secondary));
  }

  if(istrue(level.tertiaryweaponslotenabled)) {
    tertiary = weapon::buildweapon(self.loadouttertiary, self.var_494870a5978b5a09, self.loadouttertiarycamo, self.loadouttertiaryreticle, self.loadouttertiaryvariantid);

    if(weapon::getweapongroup(tertiary.basename) == "weapon_projectile") {
      self setweaponammoclip(tertiary, weaponclipsize(tertiary));
    }
  }
}

function unsetaffinityextralauncher() {
  self.weaponaffinityextralauncher = undefined;
}

function setdoubleload() {
  self endon("death_or_disconnect");
  self endon("endDoubleLoad");
  level endon("game_ended");

  for(;;) {
    self waittill("reload");
    weapons = self getweaponslist("primary");

    foreach(weapon in weapons) {
      ammoinclip = self getweaponammoclip(weapon);
      clipsize = weaponclipsize(weapon);
      difference = clipsize - ammoinclip;
      var_70d8543518ee27d2 = self getweaponammostock(weapon);

      if(ammoinclip != clipsize && var_70d8543518ee27d2 > 0) {
        if(ammoinclip + var_70d8543518ee27d2 >= clipsize) {
          self setweaponammoclip(weapon, clipsize);
          self setweaponammostock(weapon, var_70d8543518ee27d2 - difference);
          continue;
        }

        self setweaponammoclip(weapon, ammoinclip + var_70d8543518ee27d2);

        if(var_70d8543518ee27d2 - difference > 0) {
          self setweaponammostock(weapon, var_70d8543518ee27d2 - difference);
          continue;
        }

        self setweaponammostock(weapon, 0);
      }
    }
  }
}

function unsetdoubleload() {
  self notify("endDoubleLoad");
}

function setmarksman(power) {}

function unsetmarksman() {}

function setfastcrouch() {
  thread watchfastcrouch();
}

function watchfastcrouch() {
  self endon("death_or_disconnect");
  self endon("fastcrouch_unset");

  while(true) {
    iscrouched = (self getstance() == "crouch" || self getstance() == "prone") && !self issprintsliding();

    if(!isDefined(self.fastcrouchspeedmod)) {
      if(iscrouched) {
        self.fastcrouchspeedmod = 0.2;
        weapons::updatemovespeedscale();
      }
    } else if(!iscrouched) {
      self.fastcrouchspeedmod = undefined;
      weapons::updatemovespeedscale();
    }

    waitframe();
  }
}

function unsetfastcrouch() {
  self notify("fastcrouch_unset");

  if(isDefined(self.fastcrouchspeedmod)) {
    self.fastcrouchspeedmod = undefined;
    weapons::updatemovespeedscale();
  }
}

function setrshieldradar() {
  self endon("unsetRShieldRadar");
  wait 0.75;
  self makeportableradar();
  thread setrshieldradar_cleanup();
}

function setrshieldradar_cleanup() {
  self endon("unsetRShieldRadar");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    unsetrshieldradar();
  }
}

function unsetrshieldradar() {
  self clearportableradar();
  self notify("unsetRShieldRadar");
}

function setrshieldscrambler() {
  self makescrambler();
  thread setrshieldscrambler_cleanup();
}

function setrshieldscrambler_cleanup() {
  self endon("unsetRShieldScrambler");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    unsetrshieldscrambler();
  }
}

function unsetrshieldscrambler() {
  self clearscrambler();
  self notify("unsetRShieldScrambler");
}

function setstunresistance(power) {
  if(!isDefined(power)) {
    power = 4;
  }

  power = int(power);

  if(power == 10) {
    self.stunscalar = 0;
    return;
  }

  self.stunscalar = power / 10;
}

function unsetstunresistance() {
  self.stunscalar = 1;
}

function applystunresistence(attacker, victim, time) {
  if(isDefined(attacker)) {
    var_8907f741f3a7b3f7 = attacker == victim;
  } else {
    var_8907f741f3a7b3f7 = 0;
  }

  if(victim perk::_hasperk("specialty_stun_resistance") && !var_8907f741f3a7b3f7) {
    if(isDefined(victim.stunscalar) && isDefined(time)) {
      time *= victim.stunscalar;
    }

    attackerowner = utility::ter_op(isDefined(attacker.owner), attacker.owner, attacker);
    victimowner = utility::ter_op(isDefined(victim.owner), victim.owner, victim);

    if(isPlayer(attackerowner) && attackerowner != victim) {
      attacker damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
    }

    if(istrue(player_utility::playersareenemies(attackerowner, victimowner))) {
      victim challenges::resistedstun(attackerowner);
      perks::activateperk("specialty_tac_resist");
    }
  } else if(!istrue(victim val::get("stunned"))) {
    time = 0;
  }

  if(victim game_utility::ismatchstartprotected()) {
    time *= 0.1;
  }

  return time;
}

function setweaponlaser() {
  if(isagent(self)) {
    return;
  }

  self endon("unsetWeaponLaser");
  wait 0.5;
  thread setweaponlaser_internal();
}

function unsetweaponlaser() {
  self notify("unsetWeaponLaser");

  if(isDefined(self.perkweaponlaseron) && self.perkweaponlaseron) {
    weapon::disableweaponlaser();
  }

  self.perkweaponlaseron = undefined;
  self.perkweaponlaseroffforswitchstart = undefined;
}

function setweaponlaser_waitforlaserweapon(weapon) {
  for(weapon = getweaponbasename(weapon); true; weapon = objweapon.basename) {
    if(isDefined(weapon) && (weapon == "iw6_kac_mp" || weapon == "iw6_arx160_mp")) {
      break;
    }

    self waittill("weapon_change", objweapon);
  }
}

function setweaponlaser_internal() {
  self endon("death_or_disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  weapon = self getcurrentweapon();

  while(true) {
    setweaponlaser_waitforlaserweapon(weapon);

    if(self.perkweaponlaseron == 0) {
      self.perkweaponlaseron = 1;
      weapon::enableweaponlaser();
    }

    childthread setweaponlaser_monitorads();
    childthread setweaponlaser_monitorweaponswitchstart(1);
    self.perkweaponlaseroffforswitchstart = undefined;
    self waittill("weapon_change");

    if(self.perkweaponlaseron == 1) {
      self.perkweaponlaseron = 0;
      weapon::disableweaponlaser();
    }
  }
}

function setweaponlaser_monitorweaponswitchstart(offtime) {
  self endon("weapon_change");

  while(true) {
    self waittill("weapon_switch_started");
    childthread setweaponlaser_onweaponswitchstart(offtime);
  }
}

function setweaponlaser_onweaponswitchstart(offtime) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    weapon::disableweaponlaser();
  }

  wait offtime;
  self.perkweaponlaseroffforswitchstart = undefined;

  if(self.perkweaponlaseron == 0 && self playerads() <= 0.6) {
    self.perkweaponlaseron = 1;
    weapon::enableweaponlaser();
  }
}

function setweaponlaser_monitorads() {
  self endon("weapon_change");

  while(true) {
    if(!isDefined(self.perkweaponlaseroffforswitchstart) || self.perkweaponlaseroffforswitchstart == 0) {
      if(self playerads() > 0.6) {
        if(self.perkweaponlaseron == 1) {
          self.perkweaponlaseron = 0;
          weapon::disableweaponlaser();
        }
      } else if(self.perkweaponlaseron == 0) {
        self.perkweaponlaseron = 1;
        weapon::enableweaponlaser();
      }
    }

    waitframe();
  }
}

function setsteadyaimpro() {
  self setaimspreadmovementscale(0.85);
}

function unsetsteadyaimpro() {
  self notify("end_SteadyAimPro");
  self setaimspreadmovementscale(1);
}

function perkusedeathtracker() {
  self endon("disconnect");
  self waittill("death");
  self._useperkenabled = undefined;
}

function setendgame() {
  if(isDefined(self.endgame)) {
    return;
  }

  self.maxhealth = tweakables::gettweakablevalue("player", "maxhealth") * 4;
  self.health = self.maxhealth;
  self.endgame = 1;
  self.attackertable[0] = "";
  self visionsetnakedforplayer("end_game", 5);
  thread endgamedeath(7);
  gamelogic::sethasdonecombat(self, 1);
}

function unsetendgame() {
  self notify("stopEndGame");
  self.endgame = undefined;
  player::restorebasevisionset(1);

  if(!isDefined(self.endgametimer)) {
    return;
  }

  self.endgametimer hud_util::destroyelem();
  self.endgameicon hud_util::destroyelem();
}

function endgamedeath(duration) {
  self endon("death_or_disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self endon("stopEndGame");
  wait duration + 1;
  damage::_suicide();
}

function setsaboteur() {
  self.objectivescaler = 1.2;
}

function unsetsaboteur() {
  self.objectivescaler = 1;
}

function setcombatspeed() {
  self endon("death_or_disconnect");
  self endon("unsetCombatSpeed");
  self.incombatspeed = 0;
  unsetcombatspeedscalar();

  for(;;) {
    self waittill("damage", dmg, attacker);

    if(!isDefined(attacker.team)) {
      continue;
    }

    if(level.teambased && attacker.team == self.team) {
      continue;
    }

    if(self.incombatspeed) {
      continue;
    }

    setcombatspeedscalar();
    self.incombatspeed = 1;
    thread endofspeedwatcher();
  }
}

function endofspeedwatcher() {
  self notify("endOfSpeedWatcher");
  self endon("endOfSpeedWatcher");
  self endon("death_or_disconnect");
  self waittill("healed");
  unsetcombatspeedscalar();
  self.incombatspeed = 0;
}

function setcombatspeedscalar() {
  if(self.weaponspeed <= 0.8) {
    self.combatspeedscalar = 1.4;
  } else if(self.weaponspeed <= 0.9) {
    self.combatspeedscalar = 1.3;
  } else {
    self.combatspeedscalar = 1.2;
  }

  weapons::updatemovespeedscale();
}

function unsetcombatspeedscalar() {
  self.combatspeedscalar = 1;
  weapons::updatemovespeedscale();
}

function unsetcombatspeed() {
  unsetcombatspeedscalar();
  self notify("unsetCombatSpeed");
}

function setblackbox() {}

function unsetblackbox() {}

function setsteelnerves() {
  perk::giveperk("specialty_bulletaccuracy");
  perk::giveperk("specialty_holdbreath");
}

function unsetsteelnerves() {
  perk::removeperk("specialty_bulletaccuracy");
  perk::removeperk("specialty_holdbreath");
}

function setdelaymine() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self.var_f19a8bf0b538aaf8 = 1;
    self.var_8eaa5f2e840b1665 = 1;
    self.minedelayseconds = level.delayminetime;
  }
}

function unsetdelaymine() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self.var_f19a8bf0b538aaf8 = undefined;
    self.var_8eaa5f2e840b1665 = undefined;
    self.minedelayseconds = undefined;
  }
}

function setlocaljammer() {
  if(emp_debuff::is_empd()) {
    self makescrambler();
  }
}

function unsetlocaljammer() {
  self clearscrambler();
}

function setthermal() {
  self thermalvisionon();
}

function unsetthermal() {
  self thermalvisionoff();
}

function setonemanarmy() {
  thread onemanarmyweaponchangetracker();
}

function unsetonemanarmy() {
  self notify("stop_oneManArmyTracker");
}

function onemanarmyweaponchangetracker() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("stop_oneManArmyTracker");

  for(;;) {
    self waittill("weapon_change", objweapon);

    if(objweapon.basename != "onemanarmy_mp") {
      continue;
    }

    thread selectonemanarmyclass();
  }
}

function isonemanarmymenu(menu) {
  if(menu == game["menu_onemanarmy"]) {
    return true;
  }

  if(isDefined(game["menu_onemanarmy_defaults_splitscreen"]) && menu == game["menu_onemanarmy_defaults_splitscreen"]) {
    return true;
  }

  if(isDefined(game["menu_onemanarmy_custom_splitscreen"]) && menu == game["menu_onemanarmy_custom_splitscreen"]) {
    return true;
  }

  return false;
}

function selectonemanarmyclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  val::set("one_man_army", "weapon_switch", 0);
  val::set("one_man_army", "offhand_weapons", 0);
  val::set("one_man_army", "usability", 0);
  thread closeomamenuondeath();
  self waittill("menuresponse", menu, classname);
  val::reset_all("one_man_army");

  if(classname == "back" || !isonemanarmymenu(menu) || utility::isusingremote()) {
    currentweapon = self getcurrentweapon();

    if(currentweapon.basename == "onemanarmy_mp") {
      val::set("one_man_army", "weapon_switch", 0);
      val::set("one_man_army", "offhand_weapons", 0);
      val::set("one_man_army", "usability", 0);
      inventory_utility::_switchtoweapon(inventory::getlastweapon());
      self waittill("weapon_change");
      val::reset_all("one_man_army");
    }

    return;
  }

  thread giveonemanarmyclass(classname);
}

function closeomamenuondeath() {
  self endon("menuresponse");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  val::reset_all("one_man_army");
}

function giveonemanarmyclass(classname) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(perk::_hasperk("specialty_omaquickchange")) {
    changeduration = 3;
    player_utility::playplayerandnpcsounds(self, "foly_onemanarmy_bag3_plr", "foly_onemanarmy_bag3_npc");
  } else {
    changeduration = 6;
    player_utility::playplayerandnpcsounds(self, "foly_onemanarmy_bag6_plr", "foly_onemanarmy_bag6_npc");
  }

  thread omausebar(changeduration);
  val::set("one_man_army", "weapon_switch", 0);
  val::set("one_man_army", "offhand_weapons", 0);
  val::set("one_man_army", "usability", 0);
  wait changeduration;
  val::reset_all("one_man_army");
  class::giveloadout(self.pers["team"], classname);

  if(isDefined(self.carryflag)) {
    self attach(self.carryflag, "J_spine4", 1);
  }

  self notify("changed_kit");
  level notify("changed_kit");
  rank::tryresetrankxp();
}

function omausebar(duration) {
  self endon("disconnect");
  usebar = hud_util::createprimaryprogressbar();
  usebartext = hud_util::createprimaryprogressbartext();
  usebartext settext(&"MPUI_CHANGING_KIT");
  usebar hud_util::updatebar(0, 1 / duration);
  waitedtime = 0;

  while(waitedtime < duration && isalive(self) && !level.gameended) {
    wait 0.05;
    waitedtime += 0.05;
  }

  usebar hud_util::destroyelem();
  usebartext hud_util::destroyelem();
}

function setafterburner() {
  self energy_setrestorerate(0, utility::ter_op(game_utility::isanymlgmatch(), 600, 1000));
  self energy_setresttimems(0, utility::ter_op(game_utility::isanymlgmatch(), 750, 750));
}

function unsetafterburner() {
  self energy_setrestorerate(0, 400);
  self energy_setresttimems(0, 900);
}

function setfreefall() {}

function unsetfreefall() {}

function settacticalinsertion() {
  equipment::giveequipment("equip_tac_insert", "secondary");
}

function unsettacticalinsertion() {}

function setpainted(attacker) {
  if(isPlayer(self)) {
    outlinetime = 0.5;

    if(!perk::_hasperk("specialty_engineer") && !perk::_hasperk("specialty_noscopeoutline")) {
      self.painted = 1;
      id = outline::outlineenableforplayer(self, attacker, "outline_nodepth_orange", "perk");
      thread watchpainted(id, outlinetime);
      thread watchpaintedagain(id);
    }
  }
}

function watchpainted(id, timeout) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  level endon("game_ended");
  utility::waittill_any_timeout_1(timeout, "death");
  self.painted = 0;
  outline::outlinedisable(id, self);
  self notify("painted_end");
}

function watchpaintedagain(id) {
  self endon("disconnect");
  level endon("game_ended");
  utility::waittill_any_2("painted_again", "painted_end");
  outline::outlinedisable(id, self);
}

function ispainted() {
  return isDefined(self.painted) && self.painted;
}

function setassists() {}

function unsetassists() {}

function setrefillgrenades() {
  if(isDefined(self.primarygrenade)) {
    self givemaxammo(self.primarygrenade);
  }

  if(isDefined(self.secondarygrenade)) {
    self givemaxammo(self.secondarygrenade);
  }
}

function unsetrefillgrenades() {}

function setrefillammo() {
  if(isDefined(self.primaryweapon)) {
    self givemaxammo(self.primaryweapon);
  }

  if(isDefined(self.secondaryweapon)) {
    self givemaxammo(self.secondaryweapon);
  }
}

function unsetrefillammo() {}

function setcomexp() {}

function unsetcomexp() {}

function settagger() {
  thread settaggerinternal();
}

function settaggerinternal() {
  self endon("death_or_disconnect");
  self endon("unsetTagger");
  level endon("game_ended");

  while(true) {
    self waittill("eyesOn");
    var_804646ef19a59c8c = self getplayerssightingme();

    foreach(otherplayer in var_804646ef19a59c8c) {
      if(level.teambased && otherplayer.team == self.team) {
        continue;
      }

      if(isalive(otherplayer) && otherplayer.sessionstate == "playing") {
        if(!isDefined(otherplayer.perkoutlined)) {
          otherplayer.perkoutlined = 0;
        }

        if(!otherplayer.perkoutlined) {
          otherplayer.perkoutlined = 1;
        }

        otherplayer thread outlinewatcher(self);
      }
    }
  }
}

function outlinewatcher(victim) {
  self endon("death_or_disconnect");
  self endon("eyesOff");
  level endon("game_ended");

  for(;;) {
    notwatching = 1;
    var_804646ef19a59c8c = victim getplayerssightingme();

    foreach(otherplayer in var_804646ef19a59c8c) {
      if(otherplayer == self) {
        notwatching = 0;
        break;
      }
    }

    if(notwatching) {
      self.perkoutlined = 0;
      self notify("eyesOff");
    }

    wait 0.5;
  }
}

function unsettagger() {
  self notify("unsetTagger");
}

function setpitcher() {
  thread setpitcherinternal();
}

function setpitcherinternal() {
  self endon("death_or_disconnect");
  self endon("unsetPitcher");
  level endon("game_ended");

  for(;;) {
    self setgrenadethrowscale(1.25);
    self waittill("grenade_pullback", objweapon);
    grenadename = objweapon.basename;

    if(grenadename == "airdrop_marker_mp" || grenadename == "deployable_vest_marker_mp" || grenadename == "deployable_weapon_crate_marker_mp") {
      self setgrenadethrowscale(1);
    }

    self waittill("grenade_fire", grenade, objweapon);
  }
}

function unsetpitcher() {
  self setgrenadecookscale(1);
  self setgrenadethrowscale(1);
  self notify("unsetPitcher");
}

function setboom() {}

function setboominternal(attacker) {
  self endon("death_or_disconnect");
  self endon("unsetBoom");
  level endon("game_ended");
  attacker endon("death_or_disconnect");
  waitframe();
  triggerportableradarping(self.origin, attacker, 800, 1500);
  attacker boomtrackplayers(self.origin, self);
}

function boomtrackplayers(targetpos, victim) {
  boomplayers = utility::playersinsphere(targetpos, 700);

  foreach(player in boomplayers) {
    if(victim == player) {
      continue;
    }

    if(player_utility::isenemy(player) && isalive(player) && !player perk::_hasperk("specialty_gpsjammer")) {}
  }
}

function boomtrackplayerdeath(attacker, id) {
  self endon("disconnect");
  attacker endon("removearchetype");
  msg = utility::waittill_any_timeout_1(2 + 5, "death");

  if(msg == "timeout" && isDefined(self.markedbyboomperk[id])) {
    self.markedbyboomperk[id] = undefined;
    return;
  }

  self waittill("spawned_player");
  self.markedbyboomperk = undefined;
}

function unsetboom() {
  self notify("unsetBoom");
}

function customjuiced(waittime) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("unset_custom_juiced");
  level endon("game_ended");
  self.isjuiced = 1;
  self.movespeedscaler = 1.1;
  weapons::updatemovespeedscale();
  perk::giveperk("specialty_fastreload");
  perk::giveperk("specialty_quickdraw");
  perk::giveperk("specialty_stalker");
  perk::giveperk("specialty_fastoffhand");
  perk::giveperk("specialty_fastsprintrecovery");
  perk::giveperk("specialty_quickswap");
  thread unsetcustomjuicedondeath();
  thread unsetcustomjuicedonride();
  thread unsetcustomjuicedonmatchend();
  endtime = waittime * 1000 + gettime();

  if(isai(self)) {}

  wait waittime;
  unsetcustomjuiced();
}

function unsetcustomjuiced(death) {
  if(!isDefined(death)) {
    self.movespeedscaler = 1;

    if(perk::_hasperk("specialty_lightweight")) {
      self.movespeedscaler = perk::lightweightscalar();
    }

    assert(isDefined(self.movespeedscaler));
    weapons::updatemovespeedscale();
  }

  perk::removeperk("specialty_fastreload");
  perk::removeperk("specialty_quickdraw");
  perk::removeperk("specialty_stalker");
  perk::removeperk("specialty_fastoffhand");
  perk::removeperk("specialty_fastsprintrecovery");
  perk::removeperk("specialty_quickswap");
  self.isjuiced = undefined;

  if(isai(self)) {}

  self notify("unset_custom_juiced");
}

function unsetcustomjuicedonride() {
  self endon("disconnect");
  self endon("unset_custom_juiced");

  while(true) {
    waitframe();

    if(utility::isusingremote()) {
      thread unsetcustomjuiced();
      break;
    }
  }
}

function unsetcustomjuicedondeath() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  utility::waittill_any_2("death", "faux_spawn");
  thread unsetcustomjuiced(1);
}

function unsetcustomjuicedonmatchend() {
  self endon("disconnect");
  self endon("unset_custom_juiced");
  level utility::waittill_any_2("round_end_finished", "game_ended");
  thread unsetcustomjuiced();
}

function settriggerhappy() {}

function settriggerhappyinternal() {
  self endon("death_or_disconnect");
  self endon("unsetTriggerHappy");
  level endon("game_ended");
  objweapon = self.lastdroppableweaponobj;
  var_4fe33ef2e789f809 = self getweaponammostock(objweapon);
  var_b94f757213c141bf = self getweaponammoclip(objweapon);
  self givestartammo(objweapon);
  var_f34e7874e06f27ef = self getweaponammoclip(objweapon);
  clipdifference = var_f34e7874e06f27ef - var_b94f757213c141bf;
  var_91aaeeca66e5f1dc = var_4fe33ef2e789f809 - clipdifference;

  if(clipdifference > var_4fe33ef2e789f809) {
    self setweaponammoclip(objweapon, var_b94f757213c141bf + var_4fe33ef2e789f809);
    var_91aaeeca66e5f1dc = 0;
  }

  self setweaponammostock(objweapon, var_91aaeeca66e5f1dc);
  self playlocalsound("ammo_crate_use");
  self setclientomnvar("ui_trigger_happy", 1);
  wait 0.2;
  self setclientomnvar("ui_trigger_happy", 0);
}

function unsettriggerhappy() {
  self setclientomnvar("ui_trigger_happy", 0);
  self notify("unsetTriggerHappy");
}

function setincog() {}

function unsetincog() {}

function setblindeye() {}

function unsetblindeye() {}

function setquickswap() {}

function unsetquickswap() {}

function setextraammo() {
  self endon("death_or_disconnect");
  self endon("unset_extraammo");
  level endon("game_ended");

  if(self.gettingloadout) {
    self waittill("giveLoadout");
  }

  playerprimaries = weapon::getvalidextraammoweapons();

  foreach(primary in playerprimaries) {
    if(isDefined(primary) && !isnullweapon(primary)) {
      self givemaxammo(primary);
    }
  }
}

function unsetextraammo() {
  self notify("unset_extraammo");
}

function setextradeadly() {
  self endon("death_or_disconnect");
  self endon("unset_extradeadly");
  level endon("game_ended");
  giveammo = 1;

  if(self.gettingloadout) {
    self waittill("giveLoadout");
  } else {
    giveammo = istrue(level.var_eeccf9e10242815);
  }

  ref = equipment::getcurrentequipment("primary");

  if(!isDefined(ref)) {
    return;
  }

  if(_hasperk("specialty_ninja_vest")) {
    if(issubstr(ref, "throwing_knife") || issubstr(ref, "shuriken") || issubstr(ref, "throwstar")) {
      equipment::incrementequipmentammo(ref);
    }

    return;
  }

  if(ref != "none" && giveammo) {
    equipment::incrementequipmentammo(ref);
  }
}

function unsetextradeadly() {
  self notify("unset_extradeadly");
}

function setbattleslide() {}

function unsetbattleslide() {}

function setoverkill() {}

function unsetoverkill() {}

function setactivereload() {}

function unsetactivereload() {}

function setlifepack() {
  if(!isDefined(level._effect["life_pack_pickup"])) {
    level._effect["life_pack_pickup"] = undefined;
  }

  thread watchlifepackkills();
}

function watchlifepackkills() {
  self endon("death_or_disconnect");
  self notify("unset_lifepack");
  self endon("unset_lifepack");

  while(true) {
    self waittill("got_a_kill", victim, weapon, meansofdeath);
    spawnloc = self.origin;
    triggerradius = 20;
    triggerheight = 20;
    lifepack = spawn("script_model", self.origin + (0, 0, 10));
    lifepack setModel("weapon_life_pack");
    lifepack.owner = self;
    lifepack.team = self.team;
    lifepack hidefromplayer(self);
    var_4529d94a150d03f6 = spawn("trigger_radius", self.origin, 0, triggerradius, triggerheight);
    var_4529d94a150d03f6 thread watchlifepackuse(lifepack);
    var_4529d94a150d03f6 thread watchlifepackdeath(lifepack);
    lifepack thread hoverlifepack();
    lifepack rotateYaw(1000, 30, 0.2, 0.2);
    lifepack thread watchlifepacklifetime(10, var_4529d94a150d03f6);
    lifepack thread watchlifepackowner();

    foreach(player in level.players) {
      lifepack setlifepackvisualforplayer(player);
    }
  }
}

function activatelifepackboost(owner, duration, disableondeath) {
  self.lifeboostactive = 1;

  if(isDefined(duration) && duration > 0) {
    thread watchlifepackboostlifetime(duration);
  }

  if(isDefined(disableondeath) && disableondeath) {
    thread watchlifepackuserdeath();
  }

  perk::giveperk("specialty_regenfaster");
  self setclientomnvar("ui_life_link", 1);
  self notify("enabled_life_pack_boost");
  self.lifepackowner = owner;
  gamescore::trackbuffassist(owner, self, "medic_lifepack");
}

function watchlifepackboostlifetime(duration) {
  self endon("death_or_disconnect");
  wait duration;

  if(isDefined(self.lifeboostactive)) {
    disablelifepackboost();
  }
}

function disablelifepackboost() {
  if(isDefined(self) && isDefined(self.lifeboostactive)) {
    self.lifeboostactive = undefined;
    self setclientomnvar("ui_life_link", 0);
    self notify("disabled_life_pack_boost");
    perk::removeperk("specialty_regenfaster");
    gamescore::untrackbuffassist(self.lifepackowner, self, "medic_lifepack");
    self.lifepackowner = undefined;
  }
}

function setlifepackvisualforplayer(player) {
  if(level.teambased && player.team == self.team && player != self.owner) {
    setlifepackoutlinestate(player);
    self showtoplayer(player);
    thread watchlifepackoutlinestate(player);
    return;
  }

  self hidefromplayer(player);
}

function setlifepackoutlinestate(player) {
  if(isDefined(player.lifeboostactive)) {
    if(isDefined(player.lifepackoutlines) && player.lifepackoutlines.size > 0) {
      foreach(outline in player.lifepackoutlines) {
        if(self == outline.pack) {
          outline::outlinedisable(outline.id, outline.pack);
          player.lifepackoutlines = utility::array_remove(player.lifepackoutlines, outline);
          outline = undefined;
        }
      }
    }

    return;
  }

  if(!isDefined(player.lifepackoutlines)) {
    player.lifepackoutlines = [];
  }

  var_fe215d90a7b55680 = spawnStruct();
  var_fe215d90a7b55680.id = outline::outlineenableforplayer(self, player, "outline_depth_cyan", "equipment");
  var_fe215d90a7b55680.pack = self;
  player.lifepackoutlines = utility::array_add_safe(player.lifepackoutlines, var_fe215d90a7b55680);
}

function watchlifepackoutlinestate(player) {
  self endon("death");

  while(true) {
    player utility::waittill_any_2("enabled_life_pack_boost", "disabled_life_pack_boost");
    setlifepackoutlinestate(player);
  }
}

function hoverlifepack() {
  self endon("death");
  self endon("phase_resource_pickup");
  originalposition = self.origin;

  while(true) {
    self moveTo(originalposition + (0, 0, 15), 1, 0.2, 0.2);
    wait 1;
    self moveTo(originalposition, 1, 0.2, 0.2);
    wait 1;
  }
}

function watchlifepackuse(lifepack) {
  self endon("death");

  while(true) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(player.team != lifepack.team) {
      continue;
    }

    if(isDefined(player.lifeboostactive)) {
      continue;
    }

    if(player == lifepack.owner) {
      continue;
    }

    player activatelifepackboost(lifepack.owner, 5, 1);
    player playlocalsound("scavenger_pack_pickup");
    pickupfxent = spawnfx(utility::getfx("life_pack_pickup"), self.origin);
    triggerfx(pickupfxent);
    pickupfxent thread script::delayentdelete(2);

    foreach(otherplayer in level.players) {
      if(otherplayer.team == player.team) {
        continue;
      }

      pickupfxent hidefromplayer(otherplayer);
    }

    lifepack delete();
  }
}

function watchlifepackdeath(lifepack) {
  self endon("death");
  lifepack waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

function watchlifepacklifetime(lifetime, var_4529d94a150d03f6) {
  self endon("death");
  wait lifetime;
  var_4529d94a150d03f6 delete();
  self delete();
}

function watchlifepackowner() {
  self endon("death");
  self.owner waittill("disconnect");

  if(isDefined(self)) {
    self delete();
  }
}

function watchlifepackuserdeath() {
  self endon("disconnect");
  self waittill("death");
  disablelifepackboost();
}

function unsetlifepack() {
  disablelifepackboost();
  self notify("unset_lifepack");
}

function settoughenup() {
  if(!isDefined(level._effect["toughen_up_screen"])) {
    level._effect["toughen_up_screen"] = loadfx("vfx/iw7/_requests/mp/vfx_toughen_up_scrn");
  }

  setdvarifuninitialized(@ "hash_ca00b7e167d0d57", 1);

  thread watchtoughenup();
}

function watchtoughenup() {
  self endon("death_or_disconnect");
  self endon("unsetToughenUp");
  level endon("game_ended");
  shieldnumber = 0;
  var_ff2e69feff3a395b = 15;
  var_6a48c4a0c488c4c3 = 7.5;
  var_74874432bf895240 = 4;
  effectlifetime = 5;
  effecttype = 2;
  var_d601ff4572d88d47 = [];
  var_d601ff4572d88d47 = utility::array_add_safe(var_d601ff4572d88d47, (35, 0, 10));
  var_d601ff4572d88d47 = utility::array_add_safe(var_d601ff4572d88d47, (0, 35, 10));
  var_d601ff4572d88d47 = utility::array_add_safe(var_d601ff4572d88d47, (-35, 0, 10));
  var_d601ff4572d88d47 = utility::array_add_safe(var_d601ff4572d88d47, (0, -35, 10));
  self waittill("spawned_player");

  while(true) {
    self waittill("got_a_kill", victim, weapon, meansofdeath);

    if(!isDefined(self.toughenedup)) {
      self.toughenedup = 1;
      screenfx = spawnfxforclient(utility::getfx("toughen_up_screen"), self getEye(), self);
      triggerfx(screenfx);
      thread attachtoughenuparmor("j_forehead", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_reflector_arm_le", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_reflector_arm_ri", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_spineupper", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("tag_shield_back", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_hip_le", level.bulletstormshield["section"].friendlymodel);
      thread attachtoughenuparmor("j_hip_ri", level.bulletstormshield["section"].friendlymodel);

      if(effecttype == 1) {
        damage::sethealthshield(var_ff2e69feff3a395b);
        thread watchtoughenuplifetime(effectlifetime);
      } else {
        lightarmor::setlightarmorvalue(self, 100);
        thread watchtoughenuplightarmorend();
      }

      screenfx thread watchtoughenupplayerend(self);
      continue;
    }

    if(effecttype == 1) {
      self notify("toughen_up_reset");
      thread watchtoughenuplifetime(effectlifetime);
    }
  }
}

function attachtoughenuparmor(tag, model, originoverride, angleoverride, teamversion) {
  shieldorigin = self gettagorigin(tag);
  shieldmodel = spawn("script_model", shieldorigin);
  shieldmodel setModel(model);
  originoffset = (0, 0, 0);
  anglesoffset = (0, 0, 0);

  if(isDefined(originoverride)) {
    originoffset = originoverride;
  }

  if(isDefined(angleoverride)) {
    anglesoffset = angleoverride;
  }

  shieldmodel.angles = self.angles;
  shieldmodel linkTo(self, tag, originoffset, anglesoffset);
  shieldmodel thread watchtoughenupplayerend(self);
  shieldmodel thread watchtoughenupgameend();
  return shieldmodel;
}

function settoughenupmodel(var_28476f7cd7b8999, shieldoffset, shieldnumber, teamversion) {
  shieldmodel = spawn("script_model", self.origin + (0, 0, 50));
  shieldmodel.team = self.owner.team;

  if(teamversion == "friendly") {
    shieldmodel setModel(level.bulletstormshield["section"].friendlymodel);
  } else {
    shieldmodel setModel(level.bulletstormshield["section"].enemymodel);
  }

  shieldmodel linkTo(self, "tag_origin", shieldoffset, (0, 90 * (shieldnumber + 1), 0));
  shieldmodel hide();
  shieldmodel thread watchtoughenupplayerend(self.owner);
  shieldmodel thread watchtoughenupgameend();
  shieldmodel thread settoughenupvisiblestate(teamversion, self.owner);
}

function watchtoughenuplightarmorend() {
  self endon("disconnect");
  self waittill("remove_light_armor");
}

function watchtoughenupplayerend(owner) {
  self endon("death");
  owner utility::waittill_any_2("death_or_disconnect", "toughen_up_end");
  owner.toughenedup = undefined;

  if(owner lightarmor::haslightarmor(owner)) {
    owner unsetlightarmor();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function watchtoughenupgameend() {
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self delete();
  }
}

function watchtoughenuplifetime(lifetime) {
  self endon("death");
  self endon("toughen_up_reset");

  while(lifetime > 0) {
    lifetime -= 1;
    wait 1;
  }

  self notify("toughen_up_end");
}

function settoughenupvisiblestate(teamversion, owner) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player == owner) {
      continue;
    }

    if(canshowtoughenupshield(player, teamversion)) {
      self showtoplayer(player);
    }

    thread watchtoughenupplayerbegin(player, teamversion);
  }
}

function watchtoughenupplayerbegin(player, teamversion) {
  player endon("disconnect");
  level endon("game_ended");
  self endon("death");

  while(true) {
    player waittill("spawned_player");
    self hidefromplayer(player);

    if(canshowtoughenupshield(player, teamversion)) {
      self showtoplayer(player);
    }
  }
}

function canshowtoughenupshield(player, teamversion) {
  var_b10a7206cd00b51 = 0;

  if(teamversion == "friendly" && player.team == self.team || teamversion == "enemy" && player.team != self.team) {
    var_b10a7206cd00b51 = 1;
  }

  return var_b10a7206cd00b51;
}

function unsettoughenup() {
  damage::clearhealthshield();
  unsetlightarmor();
  self notify("unsetToughenUp");
}

function setscoutping() {
  thread updatescoutping();
}

function updatescoutping() {
  self endon("death_or_disconnect");
  self endon("unsetScoutPing");
  baseradius = 50;
  var_b45893c03493d1f5 = 1200;

  while(true) {
    pingradius = baseradius;
    var_ff9d6502d5d4dc7a = var_b45893c03493d1f5;

    if(isDefined(self.scoutpingradius)) {
      pingradius = self.scoutpingradius;
    }

    if(isDefined(self.scoutsweeptime)) {
      var_ff9d6502d5d4dc7a = self.scoutsweeptime;
    }

    pingradius = int(pingradius);
    var_ff9d6502d5d4dc7a = int(var_ff9d6502d5d4dc7a);

    if(pingradius != baseradius) {
      triggerportableradarpingteam(self.origin, self.team, pingradius, var_ff9d6502d5d4dc7a);
    }

    wait var_b45893c03493d1f5 / 1200;
  }
}

function updatescoutpingvalues(momentumstage) {
  modvalue = 0;
  pingradius = 150;
  sweeptime = 3000;

  if(isDefined(self.scoutpingmod)) {
    modvalue = self.scoutpingmod;
  }

  if(isDefined(self.scoutpingpreviousstage)) {
    if(momentumstage > self.scoutpingpreviousstage) {
      change = momentumstage - self.scoutpingpreviousstage;
      modvalue += change / 10;
    } else if(momentumstage < self.scoutpingpreviousstage) {
      change = self.scoutpingpreviousstage - momentumstage;
      modvalue -= change / 10;
    }
  }

  if(isDefined(self.scoutpingmod)) {
    if(modvalue > self.scoutpingmod || modvalue < self.scoutpingmod) {
      pingradius += pingradius * modvalue * 1.5;
      sweeptime -= sweeptime * modvalue / 1.5;
      self.scoutpingradius = pingradius;
      self.scoutsweeptime = sweeptime;
    }
  }

  if(momentumstage == 0) {
    self.scoutpingradius = undefined;
    self.scoutsweeptime = undefined;
  }

  self.scoutpingmod = modvalue;
  self.scoutpingpreviousstage = momentumstage;
}

function unsetscoutping() {
  self.scoutpingradius = undefined;
  self.scoutsweeptime = undefined;
  self.scoutpingmod = undefined;
  self.scoutpingpreviousstage = undefined;
  self notify("unsetScoutPing");
}

function setphasespeed() {
  thread watchphasespeedshift();
  thread watchphasespeedendshift();
}

function watchphasespeedshift() {
  self endon("death_or_disconnect");

  while(true) {
    self waittill("phase_shift_start");
    self.phasespeedmod = 0.2;
    weapons::updatemovespeedscale();
  }
}

function watchphasespeedendshift() {
  self endon("death_or_disconnect");

  while(true) {
    self waittill("phase_shift_completed");
    self.phasespeedmod = undefined;
    weapons::updatemovespeedscale();
  }
}

function unsetphasespeed() {
  self.phasespeedmod = undefined;
}

function setdodge() {
  self allowdodge(1);
}

function unsetdodge() {
  self allowdodge(0);
}

function setextradodge() {
  self energy_setmax(1, 100);
  self energy_setenergy(1, 100);
}

function unsetextradodge() {
  self energy_setmax(1, 50);
  self energy_setenergy(1, 50);
}

function sixthsense_shouldwarnaboutotherplayer(otherplayer) {
  if(!perk::_hasperk("specialty_sixth_sense")) {
    return false;
  }

  if(!player_utility::_isalive()) {
    return false;
  }

  if(!isDefined(otherplayer)) {
    return false;
  }

  if(!otherplayer player_utility::_isalive()) {
    return false;
  }

  if(otherplayer.team == self.team) {
    return false;
  }

  if(distancesquared(otherplayer.origin, self.origin) > 16000000) {
    return false;
  }

  if(otherplayer perk::_hasperk("specialty_sixth_sense_immune")) {
    return false;
  }

  vehicle = otherplayer player_utility::getvehicle();

  if(isDefined(vehicle) && isDefined(vehicle.vehiclename)) {
    isdriver = vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(otherplayer);

    if(isdriver) {
      if(vehicle.vehiclename != "light_tank" && vehicle.vehiclename != "apc_russian") {
        return false;
      }
    } else if(vehicle.vehiclename == "apc_russian") {
      return false;
    }
  }

  if(otherplayer utility::isusingremote()) {
    remotename = otherplayer player::getremotename();

    if(remotename == "gunship" || remotename == "radar_drone_recon" || remotename == "chopper_gunner" || remotename == "cruise_predator" || remotename == "assault_drone") {
      return false;
    }
  }

  return true;
}

function sixthsense_inotherplayertargetcone(otherplayer, playerpos, otherplayerpos, var_ed6e173aa5e562a5) {
  fromotherplayer = playerpos - otherplayerpos;
  dot = vectordot(fromotherplayer, var_ed6e173aa5e562a5);

  if(dot <= 0) {
    return false;
  }

  var_33e2af87c7b68ce8 = length(fromotherplayer);
  var_a4b3b596dcf9790c = 12;
  var_a4b3b596dcf9790c += -0.15 * sqrt(var_33e2af87c7b68ce8);
  var_b6b1cd24e33b485f = math::degrees_to_radians(var_a4b3b596dcf9790c);
  var_29f5e95c42138166 = 1 - 0.5 * var_b6b1cd24e33b485f * var_b6b1cd24e33b485f;

  if(dot < var_29f5e95c42138166 * var_33e2af87c7b68ce8) {
    return false;
  }

  return true;
}

function sixthsense_playerseesotherplayer(playeraim, playerpos, otherplayerpos) {
  tootherplayer = otherplayerpos - playerpos;
  dot = vectordot(playeraim, vectorNormalize(tootherplayer));

  if(dot < 0.382683) {
    return true;
  }

  return false;
}

function sixthsense_think_internal() {
  tracecontents = trace::create_default_contents(1);
  sixthsensedebug = 0;

  sixthsensedebug = getdvarint(@ "hash_3a87475a75de0350") == 1;

  var_139c4666448ffeac = getdvarint(@ "hash_423b0fbeb5f130c5") == 1;
  process = 0;
  tootherplayer = undefined;
  var_746071ab06f38fd = undefined;
  time = getsystemtimeinmicroseconds();

  foreach(num, player in level.sixth_sense_players) {
    if(!isDefined(player)) {
      level.sixth_sense_players[num] = undefined;
      break;
    }

    sightmask = 0;

    if(var_139c4666448ffeac && !isbot(player)) {
      if(!player perk::_hasperk("specialty_sixth_sense")) {
        continue;
      }

      if(!player player_utility::_isalive()) {
        continue;
      }

      var_24f9b94a171cca52 = player player::getstancecenter();
      var_cbff770c2e560a93 = player getplayerssightingme();

      foreach(otherplayer in var_cbff770c2e560a93) {
        if(process >= 25) {
          process = 0;
          waitframe();
        }

        if(!isDefined(player)) {
          level.sixth_sense_players[num] = undefined;
          break;
        }

        if(!player sixthsense_shouldwarnaboutotherplayer(otherplayer)) {
          continue;
        }

        process++;
        otherplayerpos = otherplayer getvieworigin();
        var_ed6e173aa5e562a5 = anglesToForward(otherplayer getplayerangles());

        if(!player sixthsense_inotherplayertargetcone(otherplayer, var_24f9b94a171cca52, otherplayerpos, var_ed6e173aa5e562a5)) {
          continue;
        }

        sightmask |= player getsixthsensedirection(otherplayer);
      }
    } else {
      var_24f9b94a171cca52 = player gettagorigin("j_spinelower");
      var_64a457a19d7daa44 = player getEye();
      playeraim = anglesToForward(player getplayerangles());

      foreach(otherplayer in level.players) {
        if(process >= 25) {
          process = 0;
          waitframe();
        }

        if(!isDefined(player)) {
          level.sixth_sense_players[num] = undefined;
          break;
        }

        if(!player sixthsense_shouldwarnaboutotherplayer(otherplayer)) {
          continue;
        }

        process++;
        otherplayerpos = otherplayer getvieworigin();
        var_ed6e173aa5e562a5 = anglesToForward(otherplayer getplayerangles());

        if(!player sixthsense_inotherplayertargetcone(otherplayer, var_24f9b94a171cca52, otherplayerpos, var_ed6e173aa5e562a5)) {
          continue;
        }

        if(sixthsense_playerseesotherplayer(playeraim, var_24f9b94a171cca52, otherplayerpos)) {
          process += 2;
          ignoreents = [player];
          vehicle = otherplayer player_utility::getvehicle();

          if(isDefined(vehicle)) {
            outlineents = getchildoutlineents(vehicle);

            foreach(ent in outlineents) {
              ignoreents[ignoreents.size] = ent;
            }
          }

          turret = otherplayer.currentturret;

          if(isDefined(turret)) {
            ignoreents[ignoreents.size] = turret;
          }

          if(trace::ray_trace_detail_passed(otherplayerpos, var_64a457a19d7daa44, ignoreents, tracecontents)) {
            if(sixthsensedebug) {
              thread utility::draw_line_for_time(otherplayerpos, var_64a457a19d7daa44, 0, 0, 1, 0.2);
            }

            sightmask = 255;
            break;
          }
        }

        if(sixthsensedebug) {
          thread utility::draw_line_for_time(otherplayerpos, var_64a457a19d7daa44, 1, 0, 0, 0.2);
        }
      }
    }

    player updatesixthsensevfx(sightmask);

    if(sightmask != 0) {
      baseevent = "highalert_spotted";

      if(sightmask == 4 || sightmask == 128 || sightmask == 32) {
        baseevent += "_left";
      } else if(sightmask == 1 || sightmask == 64 || sightmask == 8) {
        baseevent += "_right";
      }

      scripts\cp_mp\talking_gun::function_55b08d6d71b41402(player, baseevent);

      if(getdvarint(@ "hash_9d4361be8e1b02ee", 1)) {
        if((!isDefined(player.var_57efb5bf50dc35ea) || gettime() > player.var_57efb5bf50dc35ea) && scripts\cp_mp\execution::function_700277400dcb7857(player.executionref)) {
          player.var_57efb5bf50dc35ea = gettime() + getdvarint(@ "hash_505f54e32e56d815", 3000) + randomint(1000);

          if(getdvarint(@ "hash_87e6b1e56b17932a", 0)) {
            player playlocalsound("perk_iw9_high_alert_dog_growl");
            continue;
          }

          player playsoundonmovingent("perk_iw9_high_alert_dog_growl");
        }
      }
    }
  }
}

function sixthsense_think() {
  level.sixth_sense_players = [];

  while(true) {
    waitframe();
    sixthsense_think_internal();
  }
}

function setsixthsense() {
  if(getdvarint(@ "hash_a013b18d3ee5cc85", 0) == 1) {
    return;
  }

  self.sixthsenselastactivetime = 0;
  self.sixthsensestate = 0;
  updatesixthsensevfx(0);
  playernum = self getentitynumber();
  level.sixth_sense_players[playernum] = self;
}

function unsetsixthsense() {
  thread clearsixthsense();
}

function clearsixthsense() {
  self endon("disconnect");
  self.sixthsenselastactivetime = undefined;
  self.sixthsensestate = undefined;
  self.sixthsensesource = undefined;
  self notify("removeSixthSense");
  playernum = self getentitynumber();
  level.sixth_sense_players[playernum] = undefined;
  waitframe();
  updatesixthsensevfx(0);
}

function setenhancedsixthsense() {}

function unsetenhancedsixthsense() {}

function updatesixthsensevfx(sightmask) {
  self setclientomnvar("ui_edge_glow", sightmask);
}

function getsixthsensedirection(enemy) {
  forward = anglesToForward(self getplayerangles());
  forward2d = (forward[0], forward[1], forward[2]);
  forward2d = vectorNormalize(forward2d);
  toenemy = enemy.origin - self.origin;
  toenemy2d = (toenemy[0], toenemy[1], toenemy[2]);
  toenemy2d = vectorNormalize(toenemy2d);
  dot = vectordot(forward2d, toenemy2d);

  if(dot >= 0.92388) {
    return 2;
  }

  if(dot >= 0.5) {
    return utility::ter_op(utility::isleft2d(self.origin, forward2d, enemy.origin), 4, 1);
  }

  if(dot >= 0.5) {
    return utility::ter_op(utility::isleft2d(self.origin, forward2d, enemy.origin), 128, 64);
  }

  if(dot >= -0.707107) {
    return utility::ter_op(utility::isleft2d(self.origin, forward2d, enemy.origin), 32, 8);
  }

  return 16;
}

function markassixthsensesource(otherplayer) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("markAsSixthSenseSource");
  self endon("markAsSixthSenseSource");
  idx = otherplayer getentitynumber();
  self.sixthsensesource[idx] = 1;
  otherplayer utility::waittill_any_in_array_or_timeout(["death"], 10);
  self.sixthsensesource[idx] = 0;
}

function setcamoelite() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");

  while(true) {
    traces = 0;
    players = level.players;
    var_fd9f8011e476976c = 0;

    foreach(otherplayer in players) {
      if(!isDefined(otherplayer) || !otherplayer player_utility::_isalive()) {
        continue;
      }

      if(otherplayer.team == self.team) {
        continue;
      }

      if(otherplayer perk::_hasperk("specialty_empimmune")) {
        continue;
      }

      fromotherplayer = self.origin - otherplayer.origin;
      var_ed6e173aa5e562a5 = anglesToForward(otherplayer getplayerangles());
      dot = vectordot(fromotherplayer, var_ed6e173aa5e562a5);

      if(dot <= 0) {
        continue;
      }

      var_2a2e8de350c69ca = vectorNormalize(fromotherplayer);
      var_7e1a1e00d916674f = vectorNormalize(var_ed6e173aa5e562a5);
      dot = vectordot(var_2a2e8de350c69ca, var_7e1a1e00d916674f);

      if(dot < 12) {
        continue;
      }

      traces++;
      tracestart = otherplayer getEye();
      traceend = self getEye();

      if(trace::ray_trace_passed(tracestart, traceend, self, trace::create_default_contents(1))) {
        var_fd9f8011e476976c = 1;
        break;
      }

      if(traces >= 10) {
        waitframe();
        traces = 0;
      }
    }

    updatecamoeliteoverlay(var_fd9f8011e476976c);
    waitframe();
  }
}

function updatecamoeliteoverlay(visible) {}

function unsetcamoelite() {}

function setcarepackage() {
  thread killstreaks::givekillstreak("airdrop_assault", 0, 0);
}

function unsetcarepackage() {}

function setuav() {
  thread killstreaks::givekillstreak("uav", 0, 0);
}

function unsetuav() {}

function setjuiced(waittime) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("unset_juiced");
  level endon("game_ended");
  self.isjuiced = 1;
  self.movespeedscaler = 1.25;
  weapons::updatemovespeedscale();
  perk::giveperk("specialty_fastreload");
  perk::giveperk("specialty_quickdraw");
  perk::giveperk("specialty_stalker");
  perk::giveperk("specialty_fastoffhand");
  perk::giveperk("specialty_fastsprintrecovery");
  perk::giveperk("specialty_quickswap");
  thread unsetjuicedondeath();
  thread unsetjuicedonride();
  thread unsetjuicedonmatchend();

  if(!isDefined(waittime)) {
    waittime = 10;
  }

  endtime = waittime * 1000 + gettime();

  if(isai(self)) {}

  wait waittime;
  unsetjuiced();
}

function unsetjuiced(death) {
  if(!isDefined(death)) {
    assert(isalive(self));
    self.movespeedscaler = 1;

    if(perk::_hasperk("specialty_lightweight")) {
      self.movespeedscaler = perk::lightweightscalar();
    }

    assert(isDefined(self.movespeedscaler));
    weapons::updatemovespeedscale();
  }

  perk::removeperk("specialty_fastreload");
  perk::removeperk("specialty_quickdraw");
  perk::removeperk("specialty_stalker");
  perk::removeperk("specialty_fastoffhand");
  perk::removeperk("specialty_fastsprintrecovery");
  perk::removeperk("specialty_quickswap");
  self.isjuiced = undefined;

  if(isai(self)) {}

  self notify("unset_juiced");
}

function unsetjuicedonride() {
  self endon("disconnect");
  self endon("unset_juiced");

  while(true) {
    waitframe();

    if(utility::isusingremote()) {
      thread unsetjuiced();
      break;
    }
  }
}

function unsetjuicedondeath() {
  self endon("disconnect");
  self endon("unset_juiced");
  utility::waittill_any_2("death", "faux_spawn");
  thread unsetjuiced(1);
}

function unsetjuicedonmatchend() {
  self endon("disconnect");
  self endon("unset_juiced");
  level utility::waittill_any_2("round_end_finished", "game_ended");
  thread unsetjuiced();
}

function hasjuiced() {
  return isDefined(self.isjuiced);
}

function setcombathigh() {
  self endon("death_or_disconnect");
  self endon("unset_combathigh");
  level endon("end_game");
  self.damageblockedtotal = 0;

  if(level.splitscreen) {
    yoffset = 56;
    iconsize = 21;
  } else {
    yoffset = 112;
    iconsize = 32;
  }

  if(isDefined(self.juicedtimer)) {
    self.juicedtimer destroy();
  }

  if(isDefined(self.juicedicon)) {
    self.juicedicon destroy();
  }

  self.combathighoverlay = newclienthudelem(self);
  self.combathighoverlay.x = 0;
  self.combathighoverlay.y = 0;
  self.combathighoverlay.alignx = "left";
  self.combathighoverlay.aligny = "top";
  self.combathighoverlay.horzalign = "fullscreen";
  self.combathighoverlay.vertalign = "fullscreen";
  self.combathighoverlay setshader("combathigh_overlay", 640, 480);
  self.combathighoverlay.sort = -10;
  self.combathighoverlay.archived = 1;
  self.combathightimer = hud_util::createtimer("hudsmall", 1);
  self.combathightimer hud_util::setpoint("CENTER", "CENTER", 0, yoffset);
  self.combathightimer settimer(10);
  self.combathightimer.color = (0.8, 0.8, 0);
  self.combathightimer.archived = 0;
  self.combathightimer.foreground = 1;
  self.combathighicon = hud_util::createicon("specialty_painkiller", iconsize, iconsize);
  self.combathighicon.alpha = 0;
  self.combathighicon hud_util::setparent(self.combathightimer);
  self.combathighicon hud_util::setpoint("BOTTOM", "TOP");
  self.combathighicon.archived = 1;
  self.combathighicon.sort = 1;
  self.combathighicon.foreground = 1;
  self.combathighoverlay.alpha = 0;
  self.combathighoverlay fadeovertime(1);
  self.combathighicon fadeovertime(1);
  self.combathighoverlay.alpha = 1;
  self.combathighicon.alpha = 0.85;
  thread unsetcombathighondeath();
  thread unsetcombathighonride();
  wait 8;
  self.combathighicon fadeovertime(2);
  self.combathighicon.alpha = 0;
  self.combathighoverlay fadeovertime(2);
  self.combathighoverlay.alpha = 0;
  self.combathightimer fadeovertime(2);
  self.combathightimer.alpha = 0;
  wait 2;
  self.damageblockedtotal = undefined;
  perk::removeperk("specialty_combathigh");
}

function unsetcombathighondeath() {
  self endon("disconnect");
  self endon("unset_combathigh");
  self waittill("death");
  thread perk::removeperk("specialty_combathigh");
}

function unsetcombathighonride() {
  self endon("disconnect");
  self endon("unset_combathigh");

  for(;;) {
    waitframe();

    if(utility::isusingremote()) {
      thread perk::removeperk("specialty_combathigh");
      break;
    }
  }
}

function unsetcombathigh() {
  self notify("unset_combathigh");
  self.combathighoverlay destroy();
  self.combathighicon destroy();
  self.combathightimer destroy();
}

function setlightarmor() {
  lightarmor::setlightarmorvalue(self, 150);
}

function unsetlightarmor() {
  lightarmor::lightarmor_unset(self);
}

function setrevenge() {
  self notify("stopRevenge");
  waitframe();

  if(!isDefined(self.lastkilledby)) {
    return;
  }

  if(level.teambased && self.team == self.lastkilledby.team) {
    return;
  }

  revengeparams = spawnStruct();
  revengeparams.showto = self;
  revengeparams.icon = "compassping_revenge";
  revengeparams.offset = (0, 0, 64);
  revengeparams.width = 10;
  revengeparams.height = 10;
  revengeparams.archived = 0;
  revengeparams.delay = 1.5;
  revengeparams.constantsize = 0;
  revengeparams.pintoscreenedge = 1;
  revengeparams.fadeoutpinnedicon = 0;
  revengeparams.is3d = 0;
  self.revengeparams = revengeparams;
  self.lastkilledby thread entityheadicons::setheadicon_singleimage(revengeparams.showto, revengeparams.icon, revengeparams.offset, undefined, undefined, undefined, revengeparams.delay);
  thread watchrevengedeath();
  thread watchrevengekill();
  thread watchrevengedisconnected();
  thread watchrevengevictimdisconnected();
  thread watchstoprevenge();
}

function watchrevengedeath() {
  self endon("stopRevenge");
  self endon("disconnect");
  lastkilledby = self.lastkilledby;

  while(true) {
    lastkilledby waittill("spawned_player");
    lastkilledby thread entityheadicons::setheadicon_singleimage(self.revengeparams.showto, self.revengeparams.icon, self.revengeparams.offset, undefined, undefined, undefined, self.revengeparams.delay);
  }
}

function watchrevengekill() {
  self endon("stopRevenge");
  self waittill("killed_enemy");
  self notify("stopRevenge");
}

function watchrevengedisconnected() {
  self endon("stopRevenge");
  self.lastkilledby waittill("disconnect");
  self notify("stopRevenge");
}

function watchstoprevenge() {
  lastkilledby = self.lastkilledby;
  self waittill("stopRevenge");

  if(!isDefined(lastkilledby)) {
    return;
  }

  foreach(headicon in lastkilledby.entityheadicons) {
    if(!isDefined(headicon)) {
      continue;
    }

    headicon destroy();
  }
}

function watchrevengevictimdisconnected() {
  objid = self.objidfriendly;
  lastkilledby = self.lastkilledby;
  lastkilledby endon("disconnect");
  level endon("game_ended");
  self endon("stopRevenge");
  self waittill("disconnect");

  if(!isDefined(lastkilledby)) {
    return;
  }

  foreach(headicon in lastkilledby.entityheadicons) {
    if(!isDefined(headicon)) {
      continue;
    }

    headicon destroy();
  }
}

function unsetrevenge() {
  self notify("stopRevenge");
}

function setphaseslide() {
  self.canphaseslide = 1;
}

function unsetphaseslide() {
  self.canphaseslide = 0;
}

function setteleslide() {
  self.canteleslide = 1;
}

function unsetteleslide() {
  self.canteleslide = 0;
}

function setphaseslashrephase() {
  self.hasrephase = 1;
}

function unsetphaseslashrephase() {
  self.hasrephase = 0;
}

function setphasefall() {}

function unsetphasefall() {}

function setextenddodge() {}

function unsetextenddodge() {}

function setauraquickswap() {
  archassault::auraquickswap_run();
}

function unsetauraquickswap() {}

function setauraspeed() {}

function unsetauraspeed() {}

function setmarktargets() {
  perk_mark_targets::marktarget_init();
}

function unsetmarktargets() {}

function setbatterypack() {}

function unsetbatterypack() {}

function setcamoclone() {}

function unsetcamoclone() {}

function setblockhealthregen() {
  self.healthregendisabled = 1;
  self notify("force_regeneration");
}

function unsetblockhealthregen() {
  self.healthregendisabled = undefined;
  self notify("force_regeneration");
}

function setscorestreakpack() {}

function unsetscorestreakpack() {}

function setsuperpack() {}

function unsetsuperpack() {}

function setspawncloak() {}

function unsetspawncloak() {}

function setdodgedefense() {
  damage_utility::adddamagemodifier("dodgeDefense", 0.5, 0, &dodgedefenseignorefunc);
}

function unsetdodgedefense() {
  damage_utility::removedamagemodifier("dodgeDefense", 0);
}

function dodgedefenseignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(!(isDefined(victim.dodging) && victim.dodging && victim perk::_hasperk("specialty_dodge_defense"))) {
    return true;
  }

  return false;
}

function setdodgewave() {}

function unsetdodgewave() {}

function setgroundpound() {}

function unsetgroundpound() {}

function setmeleekill() {
  self giveweapon("iw7_fistsperk_mp");
  self assignweaponmeleeslot("iw7_fistsperk_mp");

  if(self hasweapon("iw9_me_fists_mp")) {
    currweap = self getcurrentweapon();
    inventory_utility::_takeweapon("iw9_me_fists_mp");
    self giveweapon("iw7_fistslethal_mp");

    if(currweap.basename == "iw9_me_fists_mp") {
      inventory_utility::_switchtoweapon("iw7_fistslethal_mp");

      if(isDefined(self.gettingloadout) && self.gettingloadout && isDefined(self.spawnweaponobj) && self.spawnweaponobj.basename == "iw9_me_fists_mp") {
        self.spawnweaponobj = makeweapon("iw7_fistslethal_mp");
        self setspawnweapon(self.spawnweaponobj);
      }
    }
  }
}

function unsetmeleekill() {
  inventory_utility::_takeweapon("iw7_fistsperk_mp");

  if(self hasweapon("iw7_fistslethal_mp")) {
    currweap = self.currentweapon;
    inventory_utility::_takeweapon("iw7_fistslethal_mp");
    self giveweapon("iw9_me_fists_mp");

    if(currweap.basename == "iw7_fistslethal_mp") {
      inventory_utility::_switchtoweapon("iw9_me_fists_mp");
    }
  }
}

function setpowercell() {}

function unsetpowercell() {}

function sethardline() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");
  killstreaks::updatestreakcosts();
  killstreaks::checkstreakreward(self.streakpoints);
  killstreaks::updatestreakmeterui();
  self.hardlineactive["assists"] = 0;
}

function watchhardlineassists() {
  self endon("death_or_disconnect");
  self endon("perk_end_hardline");
}

function unsethardline() {
  self.hardlineactive = undefined;
  self notify("perk_end_hardline");
}

function setoverclock() {}

function unsetoverclock() {}

function setovercharge() {
  self setclientomnvar("ui_overcharge", 1);
}

function unsetovercharge() {
  self setclientomnvar("ui_overcharge", 0);
}

function setsupersprintenhanced() {
  thread watchforsupersprintenhancedused();
}

function unsetsupersprintenhanced() {
  self notify("unsetSuperSprintEnhanced");
}

function watchforsupersprintenhancedused() {
  self endon("unsetSuperSprintEnhanced");
  self endon("disconnect");
  var_928acaeced291d4 = 0;

  while(2000 > var_928acaeced291d4) {
    waitframe();

    if(isDefined(self) && istrue(self issupersprinting())) {
      deltatime = level.frameduration;
      var_928acaeced291d4 += deltatime;
    }
  }

  gamelogic::sethasdonecombat(self, 1);
}

function settracker() {}

function unsettracker() {}

function setpersonaltrophy() {}

function unsetpersonaltrophy() {}

function setdisruptorpunch() {}

function unsetdisruptorpunch() {}

function setequipmentping() {
  if(!game_utility::lpcfeaturegated()) {
    level.equipmentpingactive = 1;
  }
}

function unsetequipmentping() {}

function setmanatarms() {}

function unsetmanatarms() {}

function setoutlinekillstreaks() {
  thread outlinekillstreaks_enablemarksafterprematch();
}

function outlinekillstreaks_enablemarksafterprematch() {
  self endon("unsetOutlineKillstreak");
  self endon("disconnect");
  flags::gameflagwait("prematch_done");
  dist = 1000000;

  if(game_utility::isbrstylegametype()) {
    dist = 1000;
  }

  if(perk::_hasperk("specialty_tactician")) {
    bundle = level.perkbundles["specialty_tactician"];
    dist = utility::default_to(bundle.var_3649c0ffe7799945, dist);
  }

  if(isDefined(self)) {
    self enableentitymarks("killstreak", dist);
    self enableentitymarks("air_killstreak", dist);
    self.perkoutlinekillstreaksset = 1;
    vehicle_compass::vehicle_compass_updateallvisibilityforplayer(self);
  }
}

function unsetoutlinekillstreaks() {
  if(istrue(self.perkoutlinekillstreaksset)) {
    self disableentitymarks("killstreak");
    self disableentitymarks("air_killstreak");
    self.perkoutlinekillstreaksset = undefined;
  }

  vehicle_compass::vehicle_compass_updateallvisibilityforplayer(self);
  self notify("unsetOutlineKillstreak");
}

function setengineer() {
  thread engineer_enablemarksafterprematch();
}

function engineer_enablemarksafterprematch() {
  self endon("unsetEngineer");
  self endon("disconnect");
  flags::gameflagwait("prematch_done");
  dist = 1000000;

  if(game_utility::isbrstylegametype()) {
    dist = 1000;
  }

  if(isDefined(self)) {
    self enableentitymarks("equipment", dist);
    self.perkengineerset = 1;
  }
}

function unsetengineer() {
  if(istrue(self.perkengineerset)) {
    self disableentitymarks("equipment");
    self.perkengineerset = undefined;
  }

  self notify("unsetEngineer");
}

function function_a20970a318808f61() {
  if(!isDefined(level.var_1a439e77dde46982)) {
    level.var_1a439e77dde46982 = [];
  }

  if(isDefined(level.var_2a83795d29778aea)) {
    return;
  }

  bundle = level.perkbundles["specialty_engineer"];

  if(!isDefined(bundle)) {
    return;
  }

  level.var_2a83795d29778aea = utility::ter_op(isDefined(bundle.var_ba12045354dd234f), [], undefined);

  foreach(killstreakref in bundle.var_ba12045354dd234f) {
    level.var_2a83795d29778aea[killstreakref.streakref] = killstreakref;
  }
}

function function_71fce3d1d414f5f9() {
  level function_e381f9fcd740f0bd(self);
}

function function_96fb684092d79102() {
  level function_349ab9d8e2296ef6(self);
}

function function_e381f9fcd740f0bd(player) {
  if(level.var_1a439e77dde46982[player.name] == undefined) {
    level.var_1a439e77dde46982[player.name] = player;
  }

  if(!isDefined(level.var_44007c283e07f7c2)) {
    return;
  }

  foreach(killstreakobjid in level.var_44007c283e07f7c2) {
    killstreak = level.var_932b68e7ca895a9f[killstreakobjid];
    killstreakowner = level.killstreakowners[killstreak];

    if(istrue(player_utility::playersareenemies(player, killstreakowner))) {
      objidpoolmanager::objective_playermask_addshowplayer(killstreakobjid, player);
    }
  }
}

function function_349ab9d8e2296ef6(player) {
  level.var_1a439e77dde46982[player.name] = undefined;

  if(!isDefined(level.var_44007c283e07f7c2)) {
    return;
  }

  foreach(killstreakobjid in level.var_44007c283e07f7c2) {
    objidpoolmanager::objective_playermask_hidefrom(killstreakobjid, player);
  }
}

function setnoscopeoutline() {
  if(!isDefined(level.noscopeoutlinesetnotifs)) {
    level.noscopeoutlinesetnotifs = [];
    level.noscopeoutlineunsetnotifs = [];
    level thread processnoscopeoutlinesetnotifs();
    level thread processnoscopeoutlineunsetnotifs();
  }

  level.noscopeoutlinesetnotifs[level.noscopeoutlinesetnotifs.size] = self;
}

function unsetnoscopeoutline() {
  level.noscopeoutlineunsetnotifs[level.noscopeoutlineunsetnotifs.size] = self;
}

function processnoscopeoutlinesetnotifs() {
  level endon("game_ended");

  while(true) {
    if(level.noscopeoutlinesetnotifs.size > 0) {
      i = 0;

      while(isDefined(level.noscopeoutlinesetnotifs[i])) {
        level notify("set_noscopeoutline", level.noscopeoutlinesetnotifs[i]);
        level.noscopeoutlinesetnotifs[i] notify("set_noscopeoutline");
        i++;
        waitframe();
      }

      level.noscopeoutlinesetnotifs = [];
      continue;
    }

    waitframe();
  }
}

function processnoscopeoutlineunsetnotifs() {
  level endon("game_ended");

  while(true) {
    if(level.noscopeoutlineunsetnotifs.size > 0) {
      i = 0;

      while(isDefined(level.noscopeoutlineunsetnotifs[i])) {
        level notify("unset_noscopeoutline", level.noscopeoutlineunsetnotifs[i]);
        level.noscopeoutlineunsetnotifs[i] notify("unset_noscopeoutline");
        i++;
        waitframe();
      }

      level.noscopeoutlineunsetnotifs = [];
      continue;
    }

    waitframe();
  }
}

function setcloak() {}

function unsetcloak() {}

function setwalllock() {}

function unsetwalllock() {}

function setrush() {}

function unsetrush() {
  self notify("removeCombatHigh");
  self.speedonkillmod = undefined;
}

function sethover() {
  thread runhover();
}

function unsethover() {}

function setmomentum() {
  self.momentumspeedincrease = 0.05;
  weapons::updatemovespeedscale();
}

function unsetmomentum() {
  self.momentumspeedincrease = undefined;
  weapons::updatemovespeedscale();
}

function setscavengereqp() {}

function unsetscavengereqp() {}

function setspawnview() {}

function unsetspawnview() {
  foreach(player in level.players) {
    player notify("end_spawnview");
  }
}

function setheadgear(power) {}

function unsetheadgear() {}

function setftlslide() {}

function unsetftlslide() {}

function setimprovedprone() {}

function unsetimprovedprone() {}

function setghost() {
  thread startgpsjammer();
  self.canghost = 0;
}

function unsetghost() {
  thread removegpsjammer();
  self.canghost = undefined;
}

function function_46a8a30fa0be5b5c() {
  self.canghost = 1;
  thread function_799abf543f79895a();
}

function function_3dddddc711e8ab99() {
  thread removegpsjammer();
  self.canghost = undefined;
}

function setsupportkillstreaks() {
  self endon("disconnect");
  self waittill("equipKillstreaksFinished");

  if(!isDefined(self.streakdata.streaks[1])) {
    foreach(streak in self.streakdata.streaks["killstreaks"]) {
      streak.earned = 0;
    }
  }
}

function unsetsupportkillstreaks() {
  self notify("end_support_killstreaks");
}

function setoverrideweaponspeed() {
  self.overrideweaponspeed_speedscale = 0.98;
  weapons::updatemovespeedscale();
}

function unsetoverrideweaponspeed() {
  self.overrideweaponspeed_speedscale = undefined;
}

function setcloakaerial() {}

function unsetcloakaerial() {}

function setspawnradar() {
  self.hasspawnradar = 1;
}

function unsetspawnradar() {
  self.hasspawnradar = 1;
}

function setimprovedmelee() {}

function unsetimprovedmelee() {}

function setthief() {}

function unsetthief() {}

function setadsawareness() {
  thread runadsawareness();
  self setscriptablepartstate("heightened_senses", "default");
}

function runadsawareness() {
  self endon("death_or_disconnect");
  self endon("unsetADSAwareness");
  self.awarenessradius = 256;
  self.awarenessqueryrate = 2;
  thread awarenessmonitorstance();

  while(true) {
    wait self.awarenessqueryrate;
    awarenessplayers = utility::playersinsphere(self.origin, self.awarenessradius);

    foreach(player in level.players) {
      if(player.team == self.team) {
        continue;
      }

      if(player perk::_hasperk("specialty_coldblooded")) {
        bundle = level.perkbundles["specialty_coldblooded"];

        if(!isDefined(bundle) || !istrue(bundle.var_66e227164a07489c)) {
          continue;
        }
      }

      if(player isonground() && !player issprinting() && !player iswallrunning() && !player issprintsliding()) {
        continue;
      }

      thread playincomingwarning(player);
    }
  }
}

function playincomingwarning(target) {
  self setscriptablepartstate("heightened_senses", "scrn_pulse");
  self playRumbleOnEntity("damage_heavy");
  target playsoundtoplayer("ghost_senses_ping", self);
  wait 0.2;

  if(isDefined(self)) {
    self setscriptablepartstate("heightened_senses", "default");

    if(player_utility::_isalive()) {
      self playRumbleOnEntity("damage_heavy");

      if(isDefined(target) && target player_utility::_isalive()) {
        target playsoundtoplayer("ghost_senses_ping", self);
      }
    }
  }
}

function awarenessmonitorstance() {
  self endon("death_or_disconnect");

  while(true) {
    stance = self getstance();
    velocity = self getvelocity();

    switch (stance) {
      case #"hash_c6775c88e38f7803":
        self.awarenessradius = 400;
        self.awarenessqueryrate = 2;
        break;
      case #"hash_3fed0cbd303639eb":
        self.awarenessradius = 650;
        self.awarenessqueryrate = 1;
        break;
      case #"hash_d91940431ed7c605":
        self.awarenessradius = 700;
        self.awarenessqueryrate = 0.5;
        break;
    }

    wait 0.01;
  }
}

function awarenessaudiopulse() {
  self endon("death_or_disconnect");
  self endon("stop_awareness");

  while(true) {
    playsoundatpos(self.origin + (0, 0, 5), "ghost_senses_ping");
    wait 2;
  }
}

function unsetadsawareness() {
  self notify("unsetADSAwareness");
  self setscriptablepartstate("heightened_senses", "default");
}

function setrearguard() {}

function unsetrearguard() {
  self.hasrearguardshield = undefined;
}

function setsolobuddyboost() {
  self.hassolobuddyboost = 1;
}

function unsetsolobuddyboost() {
  self.hassolobuddyboost = undefined;
}

function setthrowingknifemelee() {
  if(!isDefined(self.throwingknifemelee)) {
    iprintln("<dev string:x69>");

    return;
  }

  self giveweapon(self.throwingknifemelee);
  self assignweaponmeleeslot(self.throwingknifemelee);
  thread watchthrowingknifescavenge();
}

function unsetthrowingknifemelee() {
  if(isDefined(self.throwingknifemelee) && self hasweapon(self.throwingknifemelee)) {
    self takeweapon(self.throwingknifemelee);
  }

  self notify("specialty_equip_throwingKnife_end");
}

function watchthrowingkifefireswipe() {
  self endon("death_or_disconnect");
  self endon("specialty_equip_throwingKnife_end");

  while(true) {
    self waittill("weapon_change", weapon);

    if(weapon.basename == "iw8_throwingknife_fire_melee_mp") {
      self setscriptablepartstate("equipFlamingKnife", "active");
      self waittill("weapon_change");
      self setscriptablepartstate("equipFlamingKnife", "neutral");
    }
  }
}

function killthrowingknifefire() {
  self setscriptablepartstate("equipFlamingKnife", "neutral");
}

function function_a722bb83c625e6c0() {
  self endon("death_or_disconnect");
  self endon("specialty_equip_throwingKnife_end");

  while(true) {
    self waittill("weapon_change", weapon);

    if(weapon.basename == "iw8_throwingknife_electric_melee_mp") {
      self setscriptablepartstate("equipFlamingKnife", "active");
      self waittill("weapon_change");
      self setscriptablepartstate("equipFlamingKnife", "neutral");
    }
  }
}

function function_6b1e598a80ac49() {
  self setscriptablepartstate("equipFlamingKnife", "neutral");
}

function watchthrowingknifescavenge() {
  self endon("death_or_disconnect");
  self endon("specialty_equip_throwingKnife_end");

  while(true) {
    self waittill("offhand_fired", weapon);

    if(weapon::isthrowingknife(weapon)) {
      ammo = self getammocount(weapon);

      if(ammo == 0) {
        if(isDefined(self.throwingknifemelee) && self hasweapon(self.throwingknifemelee)) {
          self takeweapon(self.throwingknifemelee);
        }
      }

      while(self getammocount(weapon) == 0) {
        wait 0.05;
      }

      self giveweapon(self.throwingknifemelee);
      self assignweaponmeleeslot(self.throwingknifemelee);
    }
  }
}

function setbulletoutline() {
  self.bulletoutline = spawnStruct();
  self.bulletoutline.player = self;
  self.bulletoutline.enemies = [];
  self.bulletoutline.enemyids = [];
  self.bulletoutline.enemyendtimes = [];
  self.bulletoutline thread watchbulletoutline();
  self.bulletoutline thread watchbulletoutlinecleanup();
}

function unsetbulletoutline() {
  self notify("unsetBulletOutline");
  self.bulletoutline = undefined;
}

function watchbulletoutline() {
  self.player endon("death_or_disconnect");
  self.player endon("unsetBulletOutline");

  while(isDefined(self.player)) {
    time = gettime();

    foreach(index, enemy in self.enemies) {
      if(!isDefined(enemy)) {
        bulletoutlineremoveenemy(undefined, index);
        continue;
      }

      if(enemy perk::_hasperk("specialty_noscopeoutline")) {
        bulletoutlineremoveenemy(enemy, index);
        continue;
      }

      if(time >= self.enemyendtimes[index]) {
        bulletoutlineremoveenemy(enemy, index);
      }
    }

    waitframe();
  }
}

function watchbulletoutlinecleanup() {
  self.player utility::waittill_any_2("disconnect", "unsetBulletOutline");

  foreach(index, enemy in self.enemies) {
    if(isDefined(enemy)) {
      bulletoutlineremoveenemy(enemy, index);
    }
  }
}

function bulletoutlineaddenemy(enemy, duration, offensive) {
  entnum = enemy getentitynumber();
  endtime = gettime() + duration * 1000;
  self.enemies[entnum] = enemy;

  if(!isDefined(self.enemyids[entnum])) {
    self.enemyids[entnum] = outline::outlineenableforplayer(enemy, self.player, "outline_depth_red", "perk");
  }

  if(!isDefined(self.enemyendtimes[entnum]) || !isDefined(offensive) || offensive) {
    self.enemyendtimes[entnum] = endtime;
  }
}

function bulletoutlineremoveenemy(enemy, index) {
  assert(isDefined(enemy) || isDefined(index));

  if(!isDefined(index)) {
    index = enemy getentitynumber();
  }

  self.enemies[index] = undefined;
  self.enemyendtimes[index] = undefined;

  if(isDefined(enemy)) {
    outline::outlinedisable(self.enemyids[index], enemy);
  }

  self.enemyids[index] = undefined;
}

function bulletoutlinecheck(attacker, victim, weapon, meansofdeath) {
  if(!(meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET")) {
    return;
  }

  if(!isDefined(attacker) || !isDefined(victim)) {
    return;
  }

  if(!isPlayer(attacker) || !isPlayer(victim)) {
    return;
  }

  attackerowner = attacker;

  if(isDefined(attacker.owner)) {
    attackerowner = attacker.owner;
  }

  victimowner = victim;

  if(isDefined(victim.owner)) {
    victimowner = victim.owner;
  }

  if(!istrue(player_utility::playersareenemies(attackerowner, victimowner))) {
    return;
  }

  if(isPlayer(attacker) && isPlayer(victim) && outline::outlineoccluded(attacker getEye(), victim getEye())) {
    return;
  }

  if(isDefined(attacker.bulletoutline) && !victim perk::_hasperk("specialty_noscopeoutline")) {
    attacker.bulletoutline bulletoutlineaddenemy(victim, 1);
  }

  if(isDefined(victim.bulletoutline) && !attacker perk::_hasperk("specialty_noscopeoutline")) {
    victim.bulletoutline bulletoutlineaddenemy(attacker, 2, 0);
  }
}

function markempsignatures(target, id) {
  if(!isDefined(target.empmarked)) {
    target.empmarked = [];
  }

  if(isDefined(target.empmarked[id]) && target.empmarked[id] == "active") {
    return;
  }

  target.empmarked[id] = "active";
  thread empvfx(target, id);
  target utility::waittill_any_2("death", "cloak_end");
  target.empmarked[id] = undefined;
}

function empvfx(target, id) {
  locationtags = ["j_shoulder_ri", "j_shoulder_le", "j_hip_ri", "j_hip_le", "j_spine4", "j_wrist_ri", "j_wrist_le"];
  target.empmarked[id] = undefined;
}

function startgpsjammer() {
  self endon("remove_gpsjammer");
  self endon("death_or_disconnect");

  if(isai(self) && !isbot(self)) {
    function_a587d6e4331b6211(self.avoidkillstreakonspawntimer);
    self.avoidkillstreakonspawntimer = undefined;
  }

  if(level.minspeedsq == 0) {
    return;
  }

  assert(level.timeperiod >= 0.05);

  if(level.timeperiod < 0.05) {
    return;
  }

  self.timesincelastweaponfire = 0;
  thread ghostadvanceduavwatcher();
  bundle = level.perkbundles["specialty_ghost"];

  if(istrue(game_utility::isbrstylegametype())) {
    minspeed = getdvarint(@ "hash_884bab3a224ed6f0", 65);
    thread function_d32c8e85d6e01e4b(minspeed);
  } else if(isDefined(bundle) && istrue(bundle.var_33c678397e625e15)) {
    thread function_d32c8e85d6e01e4b(bundle.var_35bc9bc901c56258);
  }

  self.timesincelastweaponfire = 0;
  self setplayerghost(istrue(self.canghost));

  while(true) {
    self waittill("weapon_fired", objweapon);

    if(class::isweaponsilenced(objweapon)) {
      continue;
    }

    doghostweaponfired();
  }
}

function function_799abf543f79895a() {
  self endon("remove_gpsjammer");
  self endon("death_or_disconnect");

  if(isai(self) && !isbot(self)) {
    function_a587d6e4331b6211(self.avoidkillstreakonspawntimer);
    self.avoidkillstreakonspawntimer = undefined;
  }

  if(level.minspeedsq == 0) {
    return;
  }

  assert(level.timeperiod >= 0.05);

  if(level.timeperiod < 0.05) {
    return;
  }

  self.timesincelastweaponfire = 0;
  thread ghostadvanceduavwatcher();
  self.timesincelastweaponfire = 0;
  self setplayerghost(istrue(self.canghost));

  while(true) {
    self waittill("weapon_fired", objweapon);

    if(class::isweaponsilenced(objweapon)) {
      continue;
    }

    doghostweaponfired();
  }
}

function function_a587d6e4331b6211(killstreaktimer) {
  delay = utility::default_to(killstreaktimer, 0);

  if(delay > 0) {
    if(istrue(self.inspawncamera)) {
      delay += spawncamera::getspawncamerablendtime();
    }

    wait delay;
  }
}

function doghostweaponfired() {
  self endon("remove_gpsjammer");
  self endon("death_or_disconnect");
  self setplayerghost(0);
  thread checkforghostweaponfire();

  while(self.timesincelastweaponfire < 3) {
    wait level.timeperiod;
    self.timesincelastweaponfire += level.timeperiod;
  }

  self notify("ghost_restored");
  self.timesincelastweaponfire = 0;
  self setplayerghost(self.canghost);
}

function checkforghostweaponfire() {
  self endon("death_or_disconnect");
  self endon("remove_gpsjammer");
  self endon("ghost_restored");

  while(true) {
    self waittill("weapon_fired");
    self.timesincelastweaponfire = 0;
  }
}

function ghostadvanceduavwatcher() {
  self endon("death_or_disconnect");
  self endon("remove_gpsjammer");
  var_498a2226e5aa47ee = game_utility::isbrstylegametype();

  if(var_498a2226e5aa47ee) {
    self setplayeradvanceduavdot(1);
    return;
  }

  bundle = level.streakglobals.streakbundles["directional_uav"];
  var_f12970142a5c902b = isDefined(bundle) && istrue(bundle.var_4e4c0a55c6b62c82);

  while(true) {
    if(level.teambased) {
      enemyhasauav = level.activeadvanceduavcount - level.activeadvanceduavs[self.team] > 0;

      if(enemyhasauav) {
        self setplayeradvanceduavdot(!var_f12970142a5c902b);
        self setplayerghost(0);

        while(enemyhasauav) {
          waitframe();
          enemyhasauav = level.activeadvanceduavcount - level.activeadvanceduavs[self.team] > 0;
        }

        self setplayerghost(self.canghost);
        self setplayeradvanceduavdot(!self.canghost);
      }
    } else {
      foreach(player in level.players) {
        if(player == self) {
          continue;
        }

        if(istrue(level.activeadvanceduavs[player.guid]) && level.activeadvanceduavs[player.guid] > 0) {
          self setplayeradvanceduavdot(1);
          self setplayerghost(0);

          while(istrue(level.activeadvanceduavs[player.guid]) && level.activeadvanceduavs[player.guid] > 0) {
            level waittill("uav_update");
          }

          self setplayerghost(self.canghost);
          self setplayeradvanceduavdot(!self.canghost);
        }
      }
    }

    waitframe();
  }
}

function function_d32c8e85d6e01e4b(minspeed) {
  self endon("death_or_disconnect");
  self endon("remove_gpsjammer");
  self.canghost = istrue(self.canghost);

  while(true) {
    laststatus = self.canghost;
    self.canghost = function_c1e6eda48a5eca42(minspeed);

    if(istrue(self.var_8d9c40fe23269431)) {
      self.canghost = 1;
    }

    if(!game_utility::isbrstylegametype() && function_a13d64596c10eeca()) {
      self.canghost = 0;
    }

    if(laststatus != self.canghost) {
      self setplayerghost(self.canghost);
    }

    waitframe();
  }
}

function function_a13d64596c10eeca() {
  key = utility::ter_op(level.teambased, self.team, self.guid);
  var_10f26e662f7fa622 = utility::default_to(level.activeadvanceduavs[key], 0);
  return level.activeadvanceduavcount - var_10f26e662f7fa622 > 0;
}

function function_c1e6eda48a5eca42(minspeed) {
  var_3bad2e994099c990 = lengthsquared(self getvelocity()) >= squared(minspeed);

  if(var_3bad2e994099c990) {
    if(isDefined(self.var_a99ec1c2df05eefd)) {
      self.var_a99ec1c2df05eefd = undefined;
    }

    return true;
  }

  if(istrue(self.isdefusing)) {
    return true;
  }

  if(istrue(self.isplanting)) {
    return true;
  }

  if(isDefined(self.vehicle_controlling) && isDefined(self.vehicle_controlling.streakinfo)) {
    return true;
  }

  if(!isDefined(self.var_a99ec1c2df05eefd)) {
    gracetime = getdvarfloat(@ "hash_5cf78be1abae9320", 2);
    self.var_a99ec1c2df05eefd = gettime() + gracetime * 1000;
    return true;
  }

  if(gettime() < self.var_a99ec1c2df05eefd) {
    return true;
  }

  return false;
}

function removegpsjammer() {
  self notify("remove_gpsjammer");
  self setplayerghost(0);
  self setplayeradvanceduavdot(0);
}

function setgroundpoundshield() {
  level._effect["groundPoundShield_impact"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

function unsetgroundpoundshield() {
  self notify("groundPoundShield_unset");
}

function groundpoundshield_onimpact(var_af29b63bc110dcf1) {
  thread groundpoundshield_raiseondelay();
}

function groundpoundshield_raiseondelay() {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundLand");
  wait 0.25;
  groundpoundshield_raise();
}

function groundpoundshield_raise() {
  if(isDefined(self.groundpoundshield)) {
    thread groundpoundshield_lower(self.groundpoundshield);
  }

  origin = self.origin + anglesToForward(self.angles) * 5;
  angles = self.angles + (0, 90, 0);
  xmodel = spawn("script_model", origin);
  xmodel.angles = angles;
  xmodel setModel("weapon_shinguard_col_wm");
  var_d96e6ddab67fb9be = spawn("script_model", origin);
  var_d96e6ddab67fb9be.angles = angles;
  var_d96e6ddab67fb9be setModel("weapon_shinguard_fr_wm");
  var_d96e6ddab67fb9be.outlineid = outline::outlineenableforall(var_d96e6ddab67fb9be, "outline_nodepth_cyan", "equipment");
  var_d97b7bdab68ded0d = spawn("script_model", origin);
  var_d97b7bdab68ded0d.angles = angles;
  var_d97b7bdab68ded0d setModel("weapon_shinguard_en_wm");
  var_d97b7bdab68ded0d.outlineid = outline::outlineenableforall(var_d97b7bdab68ded0d, "outline_nodepth_orange", "equipment");
  xmodel.visfr = var_d96e6ddab67fb9be;
  xmodel.visen = var_d97b7bdab68ded0d;
  xmodel.owner = self;
  xmodel setCanDamage(1);
  xmodel.health = 9999;
  xmodel.shieldhealth = 210;
  self.groundpoundshield = xmodel;
  players = level.characters;

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(level.teambased && player.team == self.team) {
      var_d97b7bdab68ded0d hidefromplayer(player);
      continue;
    }

    var_d96e6ddab67fb9be hidefromplayer(player);
  }

  thread groundpoundshield_monitorjoinedteam(xmodel);
  thread groundpoundshield_loweronleavearea(xmodel);
  thread groundpoundshield_lowerontime(xmodel, 3.25);
  thread groundpoundshield_loweronjump(xmodel);
  thread groundpoundshield_deleteondisconnect(xmodel);
  thread groundpoundshield_monitorhealth(xmodel);
  thread groundpound_raisefx();
  return xmodel;
}

function groundpoundshield_lower(xmodel) {
  self notify("groundPoundShield_end");

  if(!isDefined(xmodel)) {
    return;
  }

  thread groundpoundshield_lowerfx();
  thread groundpoundshield_deleteshield(xmodel);
}

function groundpoundshield_break(xmodel) {
  self notify("groundPoundShield_end");

  if(!isDefined(xmodel)) {
    return;
  }

  thread groundpoundshield_breakfx();
  thread groundpoundshield_deleteshield(xmodel);
}

function groundpoundshield_monitorhealth(xmodel) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");

  while(true) {
    xmodel waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon);

    if(isDefined(attacker)) {
      if(attacker == self || attacker.team != self.team) {
        xmodel.shieldhealth -= damage;
      }
    }

    xmodel.health = 9999;
    thread groundpoundshield_damagedfx(attacker, point, direction_vec);

    if(xmodel.shieldhealth <= 0) {
      thread groundpoundshield_break(xmodel);
      return;
    }

    if(xmodel.shieldhealth <= 105) {
      if(xmodel.visfr.model != "weapon_shinguard_dam_wm") {
        xmodel.visfr setModel("weapon_shinguard_dam_wm");
        outline::outlinerefresh(xmodel.visfr);
      }

      if(xmodel.visen.model != "weapon_shinguard_dam_wm") {
        xmodel.visen setModel("weapon_shinguard_dam_wm");
        outline::outlinerefresh(xmodel.visen);
      }
    }
  }
}

function groundpoundshield_loweronjump(xmodel) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  jumpcur = self isjumping();
  jumpprev = undefined;

  while(true) {
    jumpprev = jumpcur;
    jumpcur = self isjumping();

    if(!jumpprev && jumpcur) {
      thread groundpoundshield_lower(xmodel);
      return;
    }

    waitframe();
  }
}

function groundpoundshield_lowerontime(xmodel, time) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  wait time;
  thread groundpoundshield_lower(xmodel);
}

function groundpoundshield_loweronleavearea(xmodel) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");

  while(isDefined(xmodel)) {
    if(lengthsquared(xmodel.origin - self.origin) > 11664) {
      thread groundpoundshield_lower(xmodel);
      return;
    }

    waitframe();
  }
}

function groundpoundshield_deleteondisconnect(xmodel) {
  self endon("groundPoundShield_deleteShield");
  utility::waittill_any_2("death_or_disconnect", "groundPound_unset");
  thread groundpoundshield_deleteshield(xmodel);
}

function groundpoundshield_monitorjoinedteam(xmodel) {}

function groundpoundshield_deleteshield(xmodel) {
  self notify("groundPoundShield_deleteShield");
  outline::outlinedisable(xmodel.visen.outlineid, xmodel.visen);
  outline::outlinedisable(xmodel.visfr.outlineid, xmodel.visfr);
  xmodel.visfr delete();
  xmodel.visen delete();
  xmodel delete();
}

function groundpound_raisefx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

function groundpoundshield_lowerfx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

function groundpoundshield_damagedfx(attacker, point, direction_vec) {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
  playFX(utility::getfx("groundPoundShield_impact"), point, -1 * direction_vec);
  playsoundatpos(point, "ds_shield_impact");
  attacker damagefeedback::updatedamagefeedback("hitbulletstorm");
}

function groundpoundshield_breakfx() {
  self endon("disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShield_end");
  self endon("groundPoundShield_deleteShield");
}

function setgroundpoundshock() {
  level._effect["groundPoundShock_impact_sm"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["groundPoundShock_impact_lrg"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

function unsetgroundpoundshock() {
  self notify("groundPoundShock_unset");
}

function groundpoundshock_onimpact(var_af29b63bc110dcf1) {
  self endon("death_or_disconnect");
  self endon("groundPound_unset");
  self endon("groundPoundShock_unset");
  radius = undefined;
  effectid = undefined;

  switch (var_af29b63bc110dcf1) {
    case #"hash_845a1f955e7fce37":
      effectid = utility::getfx("groundPoundShock_impact_sm");
      radius = 144;
      break;
    case #"hash_845a1e955e7fcca4":
      effectid = utility::getfx("groundPoundShock_impact_sm");
      radius = 180;
      break;
    case #"hash_845a21955e7fd15d":
      effectid = utility::getfx("groundPoundShock_impact_lrg");
      radius = 216;
      break;
  }

  thread groundpoundshock_onimpactfx(radius, effectid);
  enemies = undefined;

  if(level.teambased) {
    enemies = teams::getenemyplayers(self.team, 1);
  } else {
    enemies = level.characters;
  }

  radiussqr = radius * radius;
  contents = trace::create_contents(0, 1, 0, 0, 1, 0, 0);

  foreach(enemy in enemies) {
    if(lengthsquared(enemy getEye() - self getEye()) > radiussqr) {
      continue;
    }

    castresult = physics_raycast(self getEye(), enemy getEye(), contents, undefined, 0, "physicsquery_closest");

    if(isDefined(castresult) && castresult.size > 0) {
      continue;
    }

    thread groundpoundshock_empplayer(enemy);
  }
}

function groundpoundshock_empplayer(victim) {
  victim endon("death_or_disconnect");
  gamescore::trackdebuffassist(self, victim, "groundpound_mp");
  wait 3;

  if(isDefined(self)) {
    gamescore::untrackdebuffassist(self, victim, "groundpound_mp");
  }
}

function groundpoundshock_onimpactfx(radius, effectid) {
  playFX(effectid, self.origin + (0, 0, 20), (0, 0, 1));
}

function setgroundpoundboost() {}

function unsetgroundpoundboost() {
  self notify("groundPoundBoost_unset");
}

function groundpoundboost_onimpact(var_af29b63bc110dcf1) {
  utility::set_doublejumpenergy(self energy_getmax(0));
}

function setbattleslideshield() {
  level._effect["battleSlideShield_damage"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  thread battleslideshield_monitor();
}

function unsetbattleslideshield() {
  self notify("battleSlideShield_unset");
}

function battleslideshield_monitor() {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self notify("battleSlideShield_monitor");
  self endon("battleSlideShield_monitor");

  while(true) {
    self waittill("sprint_slide_begin");
    thread battleslideshield_raise();
  }
}

function battleslideshield_monitorhealth(xmodel) {
  self endon("disconnect");
  self endon("battleSlide_unset");

  while(isDefined(xmodel)) {
    xmodel waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon);
    thread battleslideshield_damagedfx(xmodel, attacker, point, direction_vec);

    if(xmodel.health <= 0) {
      thread battleslideshield_break(xmodel);
      xmodel delete();
      continue;
    }

    if(xmodel.health <= 125) {
      if(xmodel.model != "weapon_shinguard_dam_wm") {
        xmodel setModel("weapon_shinguard_dam_wm");
      }

      continue;
    }

    if(xmodel.model != "weapon_shinguard_wm") {
      xmodel setModel("weapon_shinguard_wm");
    }
  }
}

function battleslideshield_raise() {
  if(isDefined(self.battleslideshield)) {
    thread battleslideshield_lower(self.battleslideshield);
  }

  xmodel = utility::spawn_tag_origin();
  xmodel setModel("weapon_shinguard_wm");
  xmodel setCanDamage(1);
  xmodel.health = 250;
  xmodel linkTo(self, "tag_origin", (30, 0, 0), (0, 90, 0));
  xmodel show();
  self.battleslideshield = xmodel;
  thread battleslideshield_killonjumpfall(xmodel);
  thread battleslideshield_killonsprint(xmodel);
  thread battleslideshield_killontime(xmodel);
  thread battleslideshield_unlinkonstop(xmodel);
  thread battleslideshield_monitorhealth(xmodel);
  thread battleslideshield_killondeathdisconnectunset(xmodel);
  thread battleslideshield_raisefx(xmodel);
  return xmodel;
}

function battleslideshield_lower(xmodel) {
  self notify("battleSlideShield_end");

  if(!isDefined(xmodel)) {
    return;
  }

  thread battleslideshield_lowerfx(xmodel);
  xmodel delete();
}

function battleslideshield_killondeathdisconnectunset(xmodel) {
  xmodel endon("death");
  utility::waittill_any_2("death_or_disconnect", "battleSlide_unset");
  xmodel delete();
}

function battleslideshield_killonjumpfall(xmodel) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  xmodel endon("death");

  while(true) {
    if(!self isonground()) {
      xmodel delete();
      self notify("battleSlideShield_end");
      return;
    }

    waitframe();
  }
}

function battleslideshield_killonsprint(xmodel) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  xmodel endon("death");
  self waittill("sprint_begin");
  xmodel delete();
  self notify("battleSlideShield_end");
}

function battleslideshield_loweronleavearea(xmodel) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  xmodel endon("death");

  while(true) {
    if(lengthsquared(xmodel.origin - self.origin) > 11664) {
      thread battleslideshield_lower(xmodel);
      return;
    }

    waitframe();
  }
}

function battleslideshield_lowerontime(xmodel) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_end");
  xmodel endon("death");
  wait 3.5;
  thread battleslideshield_lower(xmodel);
}

function battleslideshield_unlink(xmodel) {
  if(!isDefined(xmodel)) {
    return;
  }

  xmodel unlink();
  self notify("battleSlideShield_unlink");
  thread battleslideshield_lowerontime(xmodel);
  thread battleslideshield_loweronleavearea(xmodel);
  self notify("battleSlideShield_unlink");
}

function battleslideshield_killontime(xmodel) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  xmodel endon("death");
  self waittill("sprint_slide_end");
  wait 0.75;
  xmodel delete();
  self notify("battleSlideShield_end");
}

function battleslideshield_unlinkonstop(xmodel) {
  self endon("death_or_disconnect");
  self endon("battleSlide_unset");
  self endon("battleSlideShield_unlink");
  self endon("battleSlideShield_end");
  xmodel endon("death");
  self waittill("sprint_slide_end");

  while(true) {
    if(lengthsquared(self getvelocity()) < 100) {
      thread battleslideshield_unlink(xmodel);
      return;
    }

    waitframe();
  }
}

function battleslideshield_break(xmodel) {
  if(!isDefined(xmodel)) {
    return;
  }

  thread battleslideshield_breakfx(xmodel);
  self notify("battleSlideShield_end");
}

function battleslideshield_raisefx(xmodel) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  xmodel endon("death");
}

function battleslideshield_lowerfx(xmodel) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  xmodel endon("death");
}

function battleslideshield_damagedfx(xmodel, attacker, point, direction_vec) {
  self endon("disconnect");
  self endon("battleSlide_unset");
  xmodel endon("death");
  playFX(utility::getfx("battleSlideShield_damage"), point, -1 * direction_vec);
  playsoundatpos(point, "ds_shield_impact");
  attacker damagefeedback::updatedamagefeedback("hitbulletstorm");
}

function battleslideshield_breakfx(xmodel) {}

function setbattleslideoffense() {}

function unsetbattleslideoffense() {}

function getbattleslideoffensedamage() {
  return 100;
}

function setthruster() {
  level._effect["thrusterRadFr"] = loadfx("vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_fr");
  level._effect["thrusterRadEn"] = loadfx("vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_en");
  thrusterwatchdoublejump();
}

function unsetthruster() {
  if(isDefined(self.thrustfxent)) {
    self.thrustfxent delete();
  }

  self notify("thruster_unset");
}

function thrusterwatchdoublejump() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");

  while(true) {
    self waittill("doubleJumpBoostBegin");
    thread thrusterloop();
    thread thrusterdamageloop();
  }
}

function thrusterloop() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");
  thread thrusterstopfx();

  if(!isDefined(self.thrustfxent)) {
    self.thrustfxent = spawn("script_model", self.origin);
    self.thrustfxent setModel("tag_origin");
  } else {
    self.thrustfxent.origin = self.origin;
  }

  waitframe();

  for(;;) {
    self playRumbleOnEntity("damage_light");
    earthquake(0.1, 0.3, self.origin, 120);
    groundposition = playerphysicstrace(self.origin + (0, 0, 10), self.origin - (0, 0, 600)) + (0, 0, 1);
    self.thrustfxent.origin = groundposition;
    self.thrustfxent.angles = (90, 0, 0);
    waitframe();
    wait 0.33;
  }
}

function thrusterdamageloop() {
  self endon("death_or_disconnect");
  self endon("thruster_unset");
  level endon("game_ended");
  self endon("doubleJumpBoostEnd");

  while(true) {
    damage::radiusplayerdamage(self.origin, 12, 64, 5, 12, self, undefined, "MOD_IMPACT", "thruster_mp", 1);
    wait 0.05;
  }
}

function thrusterstopfx() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  utility::waittill_any_2("doubleJumpBoostEnd", "thruster_unset");
  waitframe();
}

function runhover() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");

  while(true) {
    if(self ishighjumping() && self playerads() > 0.3 && self energy_getenergy(0) > 0) {
      executehover();
      thread watchhoverend();
      self waittill("hover_ended");
      endhover();
    }

    wait 0.1;
  }
}

function watchhoverend() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self endon("walllock_ended");

  while(self playerads() > 0.3) {
    waitframe();
  }

  self notify("hover_ended");
}

function executehover() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.ishovering = 1;
  self allowmovement(0);
  self allowjump(0);
  self playlocalsound("ghost_wall_attach");
  org = utility::spawn_tag_origin();
  self playerlinkTo(org);
  thread managetimeout(org);
}

function managetimeout(org) {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  oldrate = self energy_getrestorerate(0);
  self energy_setrestorerate(0, 1);
  wait 2;
  self notify("hover_ended");
  self energy_setrestorerate(0, oldrate);
  self energy_setenergy(0, 0);
}

function endhover() {
  self endon("death_or_disconnect");
  self endon("removeArchetype");
  level endon("game_ended");
  self.ishovering = undefined;
  self allowmovement(1);
  self allowjump(1);
  self playlocalsound("ghost_wall_detach");
  self unlink();
}

function setadsmarktarget() {}

function perk_adsmarktarget_think() {
  self endon("death_or_disconnect");
  self endon("ADSTargetMarkUnset");
  level endon("game_ended");

  while(true) {
    if(self playerads() > 0.5) {
      foreach(potentialtarget in level.players) {
        if(potentialtarget perk::_hasperk("specialty_noscopeoutline")) {
          continue;
        }

        if(potentialtarget.team == self.team) {
          continue;
        }

        if(istrue(potentialtarget.isperk_adsmarked)) {
          continue;
        }

        if(istrue(potentialtarget.ischeckingadsmarking)) {
          continue;
        }

        potentialtarget.ischeckingadsmarking = 1;
        thread perk_adstargetmark_disconnectcleanupthink(potentialtarget);
        potentialtarget thread perk_adstargetmark_disconnectcleanupthink(potentialtarget);

        if(perk_adsmarktarget_check(potentialtarget)) {
          thread perk_adsmarktarget_confirmtargetandmark(potentialtarget);
          continue;
        }

        potentialtarget.ischeckingadsmarking = 0;
      }
    }

    wait 0.2;
  }
}

function perk_adsmarktarget_check(target) {
  self endon("death_or_disconnect");
  self endon("ADSTargetMarkUnset");
  level endon("game_ended");
  contents = physics_createcontents(["physicscontents_playernosight", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  dist = distance(target.origin, self.origin);
  var_f34da3f94b82b632 = 0;

  if(dist != 0) {
    var_f34da3f94b82b632 = 1000 * 10 / dist;
  }

  targeteye = target getEye();

  if(target.team != self.team && (self worldpointinreticle_circle(target.origin + (0, 0, 24), 90, var_f34da3f94b82b632) || self worldpointinreticle_circle(targeteye, 90, var_f34da3f94b82b632))) {
    caststart = self getEye();
    castend = targeteye;
    var_615161fa74c174f5 = physics_raycast(caststart, castend, contents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var_615161fa74c174f5) && var_615161fa74c174f5.size == 0) {
      return true;
    }

    waitframe();
    castend = target.origin + (0, 0, 24);
    var_4b6158e7ccc8b787 = physics_raycast(caststart, castend, contents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var_4b6158e7ccc8b787) && var_4b6158e7ccc8b787.size == 0) {
      return true;
    }
  }

  return false;
}

function perk_adsmarktarget_confirmtargetandmark(target) {
  target endon("death_or_disconnect");
  level endon("game_ended");
  self endon("ADSTargetMarkUnset");
  outlineid = undefined;
  waittime = getdvarfloat(@ "hash_3e533d050b224320");

  if(perk::_hasperk("specialty_improved_target_mark")) {
    waittime *= getdvarfloat(@ "hash_9bcdf0887b3696ad");
  }

  wait waittime;
  markheadicon = "hud_icon_new_marked";

  if(entityheadicons::function_6ede573723f08c0f()) {
    markheadicon = "hud_icon_head_marked";
  }

  if(self playerads() > 0.5 && perk_adsmarktarget_check(target)) {
    markedent = spawn("script_model", target.origin);
    markicon = markedent thread entityheadicons::setheadicon_singleimage(getlivingplayers_team(self.team), markheadicon, 35, 1, 5000, 0, undefined, 1);
    outlineid = outline::outlineenableforplayer(target, self, "outlinefill_nodepth_orange", "equipment");
    target outline::_hudoutlineviewmodelenable("outline_nodepth_orange", 0);
    target.isperk_adsmarked = 1;
    thread perk_trackadsmarktargetoutline(markicon, markedent, outlineid, target);
    return;
  }

  target.ischeckingadsmarking = 0;
}

function perk_trackadsmarktargetoutline(markicon, markedent, outlineid, markedplayer) {
  level endon("game_ended");
  wait 0.6;
  outline::outlinedisable(outlineid, markedplayer);

  if(isDefined(markedplayer)) {
    markedplayer outline::_hudoutlineviewmodeldisable();
  }

  markedtimeremaining = getdvarfloat(@ "hash_54bdba56629eb6d4");

  if(perk::_hasperk("specialty_improved_target_mark")) {
    markedtimeremaining *= getdvarfloat(@ "hash_db82bf037e180634");
  }

  wait markedtimeremaining - 0.6;
  entityheadicons::setheadicon_deleteicon(markicon);
  markedent delete();

  if(isDefined(markedplayer)) {
    markedplayer.isperk_adsmarked = 0;
    markedplayer.ischeckingadsmarking = 0;
  }

  self notify("adsmark_ended");
}

function getlivingplayers_team(team) {
  players = [];

  foreach(player in level.players) {
    if(!isDefined(player.team)) {
      continue;
    }

    if(player player_utility::_isalive() && player.team == team) {
      players[players.size] = player;
    }
  }

  return players;
}

function perk_adstargetmark_disconnectcleanupthink(target) {
  utility::waittill_any_2("ADSTargetMarkUnset", "death_or_disconnect");

  if(isDefined(target)) {
    target.ischeckingadsmarking = 0;
  }
}

function unsetadsmarktarget() {
  self notify("ADSTargetMarkUnset");
}

function sethelmet() {}

function unsethelmet() {}

function setarmorvest() {
  self.tookvesthit = 0;
}

function unsetarmorvest() {}

function setdoorbreach() {
  destructible::allowplayertobreach(self);
  door::updatealldoorslockvisibilityforplayer(self, 1);
}

function unsetdoorbreach() {
  destructible::allowplayertobreach(self);
}

function setdoorsense() {
  if(!isDefined(level.playerswithdoorsense)) {
    level.playerswithdoorsense = 1;
    return;
  }

  level.playerswithdoorsense += 1;
}

function unsetdoorsense() {
  level.playerswithdoorsense -= 1;
}

function setworsenedgunkick() {
  updateweaponkick();
}

function unsetworsenedgunkick() {
  updateweaponkick(1);
}

function updateweaponkick(var_d32e25e546898f0f) {
  if(!isDefined(self.weaponkickrecoil)) {
    self.weaponkickrecoil = 0;
  }

  recoil = -25;

  if(perk::_hasperk("specialty_worsenedgunkick") && !istrue(var_d32e25e546898f0f)) {
    if(isDefined(self.currentweapon)) {
      switch (self.currentweapon.classname) {
        case #"hash_8cdaf2e4ecfe5b51":
          recoil = -20;
          break;
        case #"hash_fa24dff6bd60a12d":
          recoil = -20;
          break;
      }
    }
  } else {
    recoil = 0;
  }

  if(recoil != self.weaponkickrecoil) {
    weapon::setrecoilscale(-1 * self.weaponkickrecoil);
    weapon::setrecoilscale(recoil);
    self.weaponkickrecoil = recoil;
  }
}

function setkillstreaktoscorestreak() {
  if(killstreak_utility::function_9f1dc821e9a8506()) {
    return;
  }

  newpoints = undefined;

  if(isDefined(self.pers["killstreakToScorestreak_lifeId"]) && self.pers["killstreakToScorestreak_lifeId"] == self.lifeid) {
    newpoints = self.pers["killstreakToScorestreak"];
    self.pers["killstreakToScorestreak"] = undefined;
    self.pers["killstreakToScorestreak_lifeId"] = undefined;
  } else {
    newpoints = killstreaktoscorestreak_killtoscore(self.streakpoints);
  }

  killstreaks::updatestreakcosts();
  killstreaks::setstreakpoints(newpoints);
  killstreaks::checkstreakreward(self.streakpoints);
  killstreaks::updatestreakmeterui();
}

function unsetkillstreaktoscorestreak() {
  if(killstreak_utility::function_9f1dc821e9a8506()) {
    return;
  }

  self.pers["killstreakToScorestreak"] = self.streakpoints;
  self.pers["killstreakToScorestreak_lifeId"] = self.lifeid;
  newpoints = killstreaktoscorestreak_scoretokill(self.streakpoints);
  killstreaks::updatestreakcosts();
  killstreaks::setstreakpoints(newpoints);
  killstreaks::checkstreakreward(self.streakpoints);
  killstreaks::updatestreakmeterui();
}

function killstreaktoscorestreak_killtoscore(streakpoints) {
  return streakpoints * 125;
}

function killstreaktoscorestreak_scoretokill(streakpoints) {
  return int(streakpoints / 125);
}

function setchainkillstreaks() {
  if(self.streakpoints <= 0) {
    self.pers["canKillChain"] = 1;
  }
}

function unsetchainkillstreaks() {
  if(!istrue(level.gameended)) {
    self.pers["canKillChain"] = undefined;
  }
}

function setscrapweapons() {
  if(getdvarint(@ "hash_eb1e94069d5150f2") == 1) {
    self setclientomnvar("ui_graverobber", 1);
  }
}

function unsetscrapweapons() {
  self setclientomnvar("ui_graverobber", 0);
}

function setdooralarm() {
  self.alarmeddoors = [];
  door::updatealldoorsalarmvisibilityforplayer(self, 1);
}

function unsetdooralarm() {
  foreach(alarmeddoor in self.alarmeddoors) {
    alarmeddoor door::removealarmdoor(0);
  }

  self.alarmeddoors = undefined;
  door::updatealldoorsalarmvisibilityforplayer(self, 0);
}

function setreviveuseweapon() {
  thread proximityrevivethink();
}

function proximityrevivethink() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unset_revive_use_weapon");

  if(!isDefined(self.proximityrevivefauxtrigger)) {
    fauxtrigger = spawnStruct();
    fauxtrigger.usetime = getdvarfloat(@ "hash_6f08a22fd52e004c") * dvars::getwatcheddvar("lastStandReviveTimer");
    fauxtrigger.curprogress = 0;
    fauxtrigger.owner = undefined;
    fauxtrigger.id = "laststand_reviver";
    fauxtrigger.trigger = spawnStruct();
    fauxtrigger.trigger.id = "laststand_reviver";
    self.proximityrevivefauxtrigger = fauxtrigger;
  }

  fauxtrigger = self.proximityrevivefauxtrigger;

  if(!isDefined(self.hiddenreviveents)) {
    self.hiddenreviveents = [];
  }

  self.canrevivewithweapon = 1;

  if(isDefined(level.revivetriggers)) {
    foreach(entnum, ent in level.revivetriggers) {
      if(!isDefined(self.hiddenreviveents[entnum])) {
        ent.trigger disableplayeruse(self);
        self.hiddenreviveents[entnum] = ent.trigger;
      }
    }
  }

  foreach(entnum, ent in level.laststandreviveents) {
    if(!isDefined(self.hiddenreviveents[entnum])) {
      ent disableplayeruse(self);
      self.hiddenreviveents[entnum] = ent;
    }
  }

  while(true) {
    players = player::getplayersinradius(self.origin, 150, self.team, self);

    foreach(player in players) {
      if(istrue(player.inlaststand) && !istrue(player.stuckinlaststand) && !istrue(player.laststandhealisactive) && !istrue(player player::getbeingrevivedinternal()) && !isDefined(fauxtrigger.owner)) {
        thread proximityrevive(player, fauxtrigger);
      }
    }

    if(isDefined(level.revivetriggers)) {
      foreach(useent in level.revivetriggers) {
        if(useent.ownerteam == self.team) {
          if(!istrue(useent.trigger.owner player::getbeingrevivedinternal()) && !isDefined(fauxtrigger.owner)) {
            if(distancesquared(useent.trigger.origin, self.origin) <= 22500) {
              thread proximityrevive(useent.trigger.owner, fauxtrigger, useent);
            }
          }
        }
      }
    }

    wait 0.1;
  }
}

function proximityrevive(player, fauxtrigger, reviveent) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unset_revive_use_weapon");
  player endon("death_or_disconnect");
  player endon("last_stand_finished");
  player player::setbeingrevivedinternal(1);
  fauxtrigger.owner = player;
  fauxtrigger.trigger.owner = player;
  thread watchproximityrevivefail(player, fauxtrigger, reviveent);

  if(isDefined(reviveent)) {
    reviveent.trigger hide();
    reviveent.trigger makeunusable();
    reviveent teamrevive::revivetriggerholdonusebegin(self, 1);
  } else if(isDefined(player.laststandreviveent)) {
    player.laststandreviveent hide();
    player.laststandreviveent makeunusable();
  }

  player notify("handle_revive_message");
  player player::_freezecontrols(1, undefined, "proximityRevive");

  while(fauxtrigger.curprogress < fauxtrigger.usetime) {
    if(distancesquared(self.origin, player.origin) > 90000) {
      self notify("prox_revive_fail");
      return;
    }

    gameobjects::updateuiprogress(fauxtrigger, 1);
    fauxtrigger.curprogress += level.framedurationseconds;
    waitframe();
  }

  gameobjects::updateuiprogress(fauxtrigger, 0);
  player gameobjects::updateuiprogress(fauxtrigger, 0);
  player player::_freezecontrols(0, undefined, "proximityRevive");
  fauxtrigger.curprogress = 0;
  fauxtrigger.owner = undefined;
  fauxtrigger.trigger.owner = undefined;

  if(istrue(player.inlaststand)) {
    player notify("last_stand_revived");
    return;
  }

  reviveent teamrevive::revivetriggerholdonuseend(self.team, self, 1, 1);
  reviveent teamrevive::revivetriggerholdonuse(self);
}

function watchproximityrevivefail(player, fauxtrigger, reviveent) {
  level endon("game_ended");
  player endon("last_stand_revived");
  player endon("spawned_player");
  team = player.team;
  waittill_any_ents_return(self, "death_or_disconnect", self, "unset_revive_use_weapon", self, "prox_revive_fail", player, "death_or_disconnect", player, "last_stand_finished");

  if(isDefined(reviveent)) {
    reviveent.trigger show();
    reviveent.trigger makeusable();
    reviveent teamrevive::revivetriggerholdonuseend(team, self, 0, 1);
  }

  if(isDefined(player)) {
    player player::setbeingrevivedinternal(0);
    player gameobjects::updateuiprogress(fauxtrigger, 0);
    player player::_freezecontrols(0, undefined, "proximityRevive");

    if(isDefined(player.laststandreviveent)) {
      player.laststandreviveent show();
      player.laststandreviveent makeusable();
    }

    player notify("handle_revive_message");
  }

  if(isDefined(self)) {
    fauxtrigger.owner = undefined;
    fauxtrigger.trigger.owner = undefined;
    fauxtrigger.curprogress = 0;
    gameobjects::updateuiprogress(fauxtrigger, 0);
  }
}

function unsetreviveuseweapon() {
  self notify("unset_revive_use_weapon");
  self.canrevivewithweapon = undefined;

  foreach(ent in self.hiddenreviveents) {
    if(isDefined(ent) && ent.owner != self) {
      ent showtoplayer(self);
      ent enableplayeruse(self);
    }
  }
}

function setlocationmarking() {}

function unsetlocationmarking() {}

function setremotedefuse() {}

function unsetremotedefuse() {}

function setalwaysminimap() {
  player::showminimap();
}

function unsetalwaysminimap() {
  player::hideminimap();
}

function supersprintkillrefresh_init() {
  level._effect["super_sprint_refresh"] = loadfx("vfx/iw8_mp/perk/vfx_hustle.vfx");
  level._effect["super_sprint_refresh_night"] = loadfx("vfx/iw8_mp/perk/vfx_hustle_night.vfx");
}

function supersprintkillrefresh_onkill() {
  var_b684eb73c290c40f = self getsprintmeterfraction();

  if(var_b684eb73c290c40f < 1) {
    perks::activateperk("specialty_super_sprint_kill_refresh");
    self refreshsprinttime();
  }
}

function setgasgrenaderesist() {
  if(player_utility::_isalive()) {
    return;
  }

  gas_grenade::gas_updateplayereffects();
}

function unsetgasgrenaderesist() {
  if(player_utility::_isalive()) {
    return;
  }

  gas_grenade::gas_updateplayereffects();
}

function setfastreloadlaunchers() {}

function unsetfastreloadlaunchers() {
  if(istrue(self.fastreloadlaunchers)) {
    perk::removeperk("specialty_fastreload");
    self.fastreloadlaunchers = undefined;
  }
}

function setreduceregendelay() {
  playerhealth::function_5457f0107a845374("setReduceRegenDelay_perks", 1);
}

function unsetreduceregendelay() {
  playerhealth::function_4f8b5efd1816f6c3("setReduceRegenDelay_perks");
}

function regendelayreduce_onkill() {
  var_39e91d553a7e0c6c = game_utility::function_d2d2b803a7b741a4();
  var_35592968b84e0d = self isnightvisionon();
  var_efcad1fd61529517 = var_39e91d553a7e0c6c && var_35592968b84e0d;
  fx = utility::ter_op(var_efcad1fd61529517, utility::getfx("super_sprint_refresh_night"), utility::getfx("super_sprint_refresh"));
  playfxontagforclients(fx, self, "tag_eye", self);

  if(self.health < 100) {
    if(_hasperk("specialty_compression_carrier")) {
      perks::activateperk("specialty_compression_carrier");
    } else {
      perks::activateperk("specialty_quick_fix");
    }
  }

  thread regendelayreduce_delayedregen();
}

function regenonkill() {
  if(self.health < self.maxhealth) {
    perks::activateperk("specialty_compression_plate");
  }

  self notify("force_regeneration");
}

function regendelayreduce_delayedregen() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("regenDelayReduce_delayedRegen");
  self endon("regenDelayReduce_delayedRegen");
  playerhealth::function_5457f0107a845374("regenDelayReduce_delayedRegen", 1, 140);
}

function setregenonobjectivecapture() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unsetRegenOnObjectiveCapture");

  while(true) {
    waittill_any_7("domFlag_captured", "ctfFlag_captured", "bomb_planted", "segment_captured", "escort_zone_captured", "hackZone_captured", "wmObj_captured");

    if(self.health < self.maxhealth) {
      perks::activateperk("specialty_compression_plate");
    }

    self notify("force_regeneration");
    wait 0.5;
  }
}

function unsetregenonobjectivecapture() {
  self notify("unsetRegenOnObjectiveCapture");
}

function setreduceregendelayonkill() {
  if(isDefined(self.lastgunkilltime) && self.lastgunkilltime == gettime()) {
    regendelayreduce_onkill();
  }
}

function unsetreduceregendelayonkill() {}

function setreduceregendelayonobjective() {
  updatereduceregendelayonobjective();
  thread monitorreduceregendelayonobjective();
}

function unsetreduceregendelayonobjective() {
  self notify("unsetReduceRegenDelayOnObjective");
  updatereduceregendelayonobjective(1);
}

function monitorreduceregendelayonobjective() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("unsetReduceRegenDelayOnObjective");

  while(true) {
    wait 0.5;
    updatereduceregendelayonobjective();
  }
}

function updatereduceregendelayonobjective(forceoff) {
  var_d8688e5e358c46e8 = isDefined(self.carryobject);
  touchinggameobject = isDefined(self.touchinggameobjects) && self.touchinggameobjects.size > 0;
  usinggameobject = isDefined(self.usinggameobjects) && self.usinggameobjects.size > 0;
  reduceregendelay = var_d8688e5e358c46e8 || touchinggameobject || usinggameobject;
  atfullhealth = self.health / self.maxhealth >= 1;

  if(reduceregendelay && !atfullhealth && !istrue(forceoff)) {
    if(!istrue(self.isonobjective)) {
      var_39e91d553a7e0c6c = scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4();
      var_35592968b84e0d = self isnightvisionon();
      var_efcad1fd61529517 = var_39e91d553a7e0c6c && var_35592968b84e0d;
      fx = ter_op(var_efcad1fd61529517, getfx("super_sprint_refresh_night"), getfx("super_sprint_refresh"));
      playfxontagforclients(fx, self, "tag_eye", self);
      self.isonobjective = 1;
      perk::giveperk("specialty_regen_delay_reduced");
      activateperk("specialty_quick_fix");
    }

    return;
  }

  if(istrue(self.isonobjective)) {
    self.isonobjective = 0;
    perk::removeperk("specialty_regen_delay_reduced");
  }
}

function setrechargeequipment() {
  if(!isDefined(level.perkrechargeequipmentplayers)) {
    return;
  }

  self notify("setRechargeEquipment");
  level.perkrechargeequipmentplayers = utility::array_add(level.perkrechargeequipmentplayers, self);
}

function unsetrechargeequipment() {
  if(!isDefined(level.perkrechargeequipmentplayers)) {
    return;
  }

  level.perkrechargeequipmentplayers = utility::array_remove(level.perkrechargeequipmentplayers, self);
  thread rechargeequipment_clearplayer(self);
}

function rechargeequipmentthink_init() {
  level.perkrechargeequipmentplayers = [];
  var_bb293d0be6d94bb = int(ceil(0.5 / level.framedurationseconds));

  while(true) {
    var_b8009f31b1522792 = level.perkrechargeequipmentplayers;
    var_e9a4c83bb773349 = int(ceil(var_b8009f31b1522792.size / var_bb293d0be6d94bb));

    for(frameindex = 0; frameindex < var_bb293d0be6d94bb; frameindex++) {
      for(playerindex = 0; playerindex < var_e9a4c83bb773349; playerindex++) {
        globalplayerindex = frameindex * var_e9a4c83bb773349 + playerindex;

        if(globalplayerindex > var_b8009f31b1522792.size) {
          break;
        }

        player = var_b8009f31b1522792[globalplayerindex];

        if(!isDefined(player)) {
          continue;
        }

        if(!player player_utility::_isalive() || istrue(player.inlaststand) || istrue(self.stuckinlaststand)) {
          continue;
        }

        rechargeequipment_updatestate(player);
      }

      waitframe();
    }
  }
}

function rechargeequipment_updatestate(player) {
  if(!isDefined(player.rechargeequipmentstate)) {
    player.rechargeequipmentstate = spawnStruct();
    player.rechargeequipmentstate.progress = [];
    player.rechargeequipmentstate.recharged = [];
    player.rechargeequipmentstate.equipments = [];
  }

  var_4b97fb6cc3aedcce = 1;
  var_1804b63851f70ea7 = 1;

  if(isDefined(level.var_d6a96dc3229dfd3c)) {
    var_4b97fb6cc3aedcce = player[[level.var_d6a96dc3229dfd3c]]("primary");
    var_1804b63851f70ea7 = player[[level.var_d6a96dc3229dfd3c]]("secondary");
  }

  if(var_4b97fb6cc3aedcce) {
    rechargeequipment_updateslot(player, "primary");
  }

  if(var_1804b63851f70ea7) {
    rechargeequipment_updateslot(player, "secondary");
  }

  rechargeequipment_updateui(player);
}

function rechargeequipment_updateslot(player, slot) {
  state = player.rechargeequipmentstate;

  if(!isDefined(state.progress[slot])) {
    state.progress[slot] = 0;
  }

  state.recharged[slot] = undefined;
  equipment = player equipment::getcurrentequipment(slot);

  if(player _hasperk("specialty_grenade_bandolier")) {
    if(!isDefined(equipment) || isDefined(state.equipments[slot]) && equipment != state.equipments[slot]) {
      state.progress[slot] = 0;
    }
  }

  state.equipments[slot] = equipment;

  if(!isDefined(equipment)) {
    return;
  }

  if(player _hasperk("specialty_ninja_vest")) {
    validequipment = 0;

    if(slot == "secondary") {
      return;
    }

    if(issubstr(equipment, "throwing_knife") || issubstr(equipment, "throwstar") || issubstr(equipment, "shuriken")) {
      validequipment = 1;
    }

    if(!validequipment) {
      return;
    }
  }

  ammo = player equipment::getequipmentammo(equipment);
  ammomax = player equipment::getequipmentmaxammo(equipment);
  startammo = player equipment::getequipmentstartammo(equipment);

  if(isDefined(level.gamemodeoverriderestockrechargeperupdate)) {
    rechargeperupdate = level.gamemodeoverriderestockrechargeperupdate;
  } else {
    rechargeperupdate = utility::ter_op(game_utility::isbrstylegametype(), 0.01, 0.02);
  }

  if(player _hasperk("specialty_grenade_bandolier")) {
    rechargetime = 0;

    if(slot == "primary") {
      if(issubstr(equipment, "aether_blade")) {
        return;
      } else {
        rechargetime = getdvarfloat(@ "hash_63e37ef08c86ccc", 45);
      }
    } else if(issubstr(equipment, "blackhole") || issubstr(equipment, "monkey")) {
      rechargetime = getdvarfloat(@ "hash_b0610c059ea24de9", 240);
    } else if(issubstr(equipment, "decoy")) {
      rechargetime = getdvarfloat(@ "hash_4db65827e4f40d8a", 55);
    } else {
      rechargetime = getdvarfloat(@ "hash_e912109249383dff", 45);
    }

    rechargeperupdate = 0.5 / rechargetime;
  }

  if(ammo < ammomax) {
    state.progress[slot] += rechargeperupdate;
  } else {
    state.progress[slot] = 0;
  }

  if(state.progress[slot] > 1 || abs(state.progress[slot] - 1) < 0.001) {
    player equipment::incrementequipmentslotammo(slot, 1);
    state.progress[slot] = 0;
    state.recharged[slot] = 1;
  }
}

function rechargeequipment_clearplayer(player) {
  player endon("setRechargeEquipment");
  player endon("disconnect");
  player.rechargeequipmentstate = undefined;
  waitframe();
  rechargeequipment_updateui(player);
}

function rechargeequipment_updateui(player) {
  lethalprogress = 0;
  tacticalprogress = 0;
  var_7732b71eb53c0af1 = -1;
  var_4b97fb6cc3aedcce = 1;
  var_1804b63851f70ea7 = 1;

  if(isDefined(level.var_d6a96dc3229dfd3c)) {
    var_4b97fb6cc3aedcce = player[[level.var_d6a96dc3229dfd3c]]("primary");
    var_1804b63851f70ea7 = player[[level.var_d6a96dc3229dfd3c]]("secondary");
  }

  if(isDefined(player) && isDefined(player.rechargeequipmentstate)) {
    player stats::initpersstat("restockCount");
    state = player.rechargeequipmentstate;

    if(isDefined(state.progress["primary"]) && var_4b97fb6cc3aedcce) {
      lethalprogress = state.progress["primary"];
    }

    if(isDefined(state.progress["secondary"]) && var_1804b63851f70ea7) {
      tacticalprogress = state.progress["secondary"];
    }

    foreach(slot, _ in state.recharged) {
      if(slot == "primary" && var_4b97fb6cc3aedcce) {
        var_7732b71eb53c0af1 += 1;
        player playlocalsound("ui_restock_lethals");
        player stats::incpersstat("restockCount", 1);
      }

      if(slot == "secondary" && var_1804b63851f70ea7) {
        var_7732b71eb53c0af1 += 2;
        player playlocalsound("ui_restock_tactical");
        player stats::incpersstat("restockCount", 1);
      }
    }
  }

  if(var_4b97fb6cc3aedcce) {
    player setclientomnvar("ui_lethal_recharge_progress", lethalprogress);
    player setpowerprogress("primary", lethalprogress);
  }

  if(var_1804b63851f70ea7) {
    player setclientomnvar("ui_tactical_recharge_progress", tacticalprogress);
    player setpowerprogress("secondary", tacticalprogress);
  }

  if(var_4b97fb6cc3aedcce || var_1804b63851f70ea7) {
    player setclientomnvar("ui_recharge_notify", var_7732b71eb53c0af1);
  }
}

function markequipment_monitorlook() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  flags::gameflagwait("prematch_done");

  if(!isDefined(self.markequipmentstate)) {
    self.markequipmentstate = spawnStruct();
    self.markequipmentstate.markingtime = 0;
    self.markequipmentstate.markingent = undefined;
    self.markequipmentstate.markedents = [];
    self.markequipmentstate.markedentindex = 0;
    self.markequipmentstate.pastmarkedents = [];
    self.markequipmentstate.pastmarkedentindex = 0;
  }

  while(true) {
    self waittill("marks_target_changed", ent);
    startmarking = isDefined(ent) && !isDefined(self.markequipmentstate.markingent);
    self.markequipmentstate.markingent = ent;
    self.markequipmentstate.markingtime = 0;

    if(startmarking) {
      thread markequipment_updatestate();
    }
  }
}

function markequipment_updatestate() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("mark_equip_ended");
  lasttime = gettime();
  maxdist = 0;

  if(self entityhasmark("air_killstreak", self.markequipmentstate.markingent)) {
    maxdist = getdvarint(@ "hash_1641bba59e207f8e");
  } else if(self entityhasmark("killstreak", self.markequipmentstate.markingent)) {
    maxdist = getdvarint(@ "hash_26ab663a769726a9");
  } else if(self entityhasmark("equipment", self.markequipmentstate.markingent)) {
    maxdist = getdvarint(@ "hash_6a6e4f9ae2a2a1");
  } else {
    assert(0, "<dev string:xcb>");
  }

  maxdistsqrd = maxdist * maxdist;

  while(isDefined(self.markequipmentstate.markingent) && !istrue(self.ishacking)) {
    if(self entitymarkfilteredin(self.markequipmentstate.markingent)) {
      break;
    }

    if(isDefined(self.vehicle) && self.vehicle == self.markequipmentstate.markingent) {
      break;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self) && !self isinvehicleleanout()) {
      break;
    }

    if(distancesquared(self.origin, self.markequipmentstate.markingent.origin) > maxdistsqrd) {
      break;
    }

    currenttime = gettime();
    deltatime = currenttime - lasttime;
    self.markequipmentstate.markingtime += deltatime;

    if(!utility::array_contains(self.markequipmentstate.markedents, self.markequipmentstate.markingent)) {
      if(player::isplayerads()) {
        markindex = self.markequipmentstate.markedentindex;
        ent = self.markequipmentstate.markedents[markindex];

        if(isDefined(ent)) {
          ent filterinplayermarks(undefined);
          outlinehelper_updateentityoutline(ent);
        }

        if(level.teambased) {
          self.markequipmentstate.markingent filterinplayermarks(self.team);
        } else {
          self.markequipmentstate.markingent filterinplayermarks(self);
        }

        outlinehelper_updateentityoutline(self.markequipmentstate.markingent);
        self playlocalsound("iw8_mp_perk_tactical_recon_marked");

        if(level.teambased && vehicle_compass::vehicle_compass_instanceisregistered(self.markequipmentstate.markingent)) {
          self.markequipmentstate.markingent.teammarkedfor = self.team;
          players = teams::getteamdata(self.markequipmentstate.markingent.teammarkedfor, "players");

          foreach(player in players) {
            vehicle_compass::vehicle_compass_updatevisibilityforplayer(self.markequipmentstate.markingent, player);
          }
        }

        self.markequipmentstate.markedents[markindex] = self.markequipmentstate.markingent;
        self.markequipmentstate.markedentindex = (markindex + 1) % 999;

        if(!utility::array_contains(self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent)) {
          killstreaks::givescoreformarktarget(1);
          self.markequipmentstate.pastmarkedents[self.markequipmentstate.pastmarkedentindex] = self.markequipmentstate.markingent;
          self.markequipmentstate.pastmarkedentindex++;
        } else {
          killstreaks::givescoreformarktarget(0);
        }

        thread unmarkafterduration(self.markequipmentstate.markingent);
        break;
      }
    }

    lasttime = currenttime;
    waitframe();
  }

  if(!istrue(self.ishacking)) {
    self setclientomnvar("ui_securing", 0);
    self setclientomnvar("ui_securing_progress", 0);
  }

  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markingtime = 0;
}

function unmarkafterduration(markedent) {
  level endon("game_ended");
  self endon("mark_equip_ended");
  self endon("unmarkEnt_" + self getentitynumber());
  markedent endon("death");
  timeoutduration = getdvarint(@ "hash_6a381b8385734e4e");
  utility::waittill_any_timeout_no_endon_death_1(timeoutduration, "disconnect");
  unmarkent(markedent);
}

function unmarkent(markedent) {
  markedent filterinplayermarks(undefined);

  if(isDefined(markedent.teammarkedfor)) {
    if(level.teambased && vehicle_compass::vehicle_compass_instanceisregistered(markedent)) {
      players = teams::getteamdata(markedent.teammarkedfor, "players");

      foreach(player in players) {
        vehicle_compass::vehicle_compass_updatevisibilityforplayer(markedent, player);
      }
    }

    markedent.teammarkedfor = undefined;
  }

  if(isDefined(self)) {
    self.markequipmentstate.markedents = utility::array_remove(self.markequipmentstate.markedents, markedent);
    markedent notify("unmarkEnt_" + self getentitynumber());
  }
}

function setmarkequipment() {
  if(!level.teambased) {
    return;
  }

  self enabletargetmarks();
  thread markequipment_monitorlook();
}

function unsetmarkequipment() {
  if(!level.teambased) {
    return;
  }

  if(isDefined(self.markequipmentstate)) {
    foreach(ent in self.markequipmentstate.markedents) {
      if(isDefined(ent)) {
        unmarkent(ent);
      }
    }
  }

  self.markequipmentstate = undefined;
  self disabletargetmarks();
  self notify("mark_equip_ended");
}

function getchildoutlineents(ent) {
  if(!isDefined(ent)) {
    return [];
  }

  if(!isDefined(ent.childoutlineents)) {
    return [ent];
  }

  return ent.childoutlineents;
}

function outlinehelper_getallplayers(ent, outlinedata) {
  return level.players;
}

function outlinehelper_validplayer(player) {
  return true;
}

function outlinehelper_verifydata(outlinedata) {
  assert(isDefined(outlinedata));

  if(!isDefined(outlinedata.getplayers)) {
    outlinedata.getplayers = &outlinehelper_getallplayers;
  }

  if(!isDefined(outlinedata.validplayer)) {
    outlinedata.validplayer = &outlinehelper_validplayer;
  }

  if(!isDefined(outlinedata.hudoutlineassetname)) {
    outlinedata.hudoutlineassetname = "spotter_notarget";
  }

  if(!isDefined(outlinedata.prioritygroup)) {
    outlinedata.prioritygroup = "perk";
  }

  if(!isDefined(outlinedata.waittime)) {
    outlinedata.waittime = 0.1;
  }
}

function outlinehelper_updateentityoutline(ent) {
  if(isDefined(ent)) {
    entitynum = ent getentitynumber();
    outlinehelper_disableentityoutline(entitynum);
    outlinehelper_enableentityoutline(ent);
  }
}

function outlinehelper_enableentityoutline(ent) {
  if(!isDefined(ent)) {
    return;
  }

  entitynum = ent getentitynumber();
  entitydata = self.entityoutlines[entitynum];

  if(isDefined(entitydata)) {
    return;
  }

  outlinedata = undefined;

  if(self entitymarkfilteredin(ent)) {
    outlinedata = spawnStruct();
    outlinedata.prioritygroup = "perk_superior";
    outlinedata.hudoutlineassetname = "spotter_target";
    outlinehelper_verifydata(outlinedata);
  }

  ismarked = self entitymarkfilteredin(ent);

  if(self entityhasmark("air_killstreak", ent)) {
    if(!isDefined(ent.model)) {
      return;
    }

    outlinedata = spawnStruct();

    if(ismarked) {
      outlinedata.prioritygroup = "perk_superior";
      outlinedata.hudoutlineassetname = "spotter_target_killstreak_air";
    } else {
      outlinedata.prioritygroup = "perk";
      outlinedata.hudoutlineassetname = "spotter_notarget_killstreak_air";
    }

    outlinehelper_verifydata(outlinedata);
  } else if(self entityhasmark("killstreak", ent)) {
    if(!isDefined(ent.model)) {
      return;
    }

    outlinedata = spawnStruct();

    if(ismarked) {
      outlinedata.prioritygroup = "perk_superior";
      outlinedata.hudoutlineassetname = "spotter_target_killstreak";
    } else {
      outlinedata.prioritygroup = "perk";
      outlinedata.hudoutlineassetname = "spotter_notarget_killstreak";
    }

    outlinehelper_verifydata(outlinedata);
  } else if(self entityhasmark("equipment", ent)) {
    outlinedata = spawnStruct();

    if(ismarked) {
      outlinedata.prioritygroup = "perk_superior";
      outlinedata.hudoutlineassetname = "spotter_target_equipment";
    } else {
      outlinedata.prioritygroup = "perk";
      outlinedata.hudoutlineassetname = "spotter_notarget_equipment";
    }

    outlinehelper_verifydata(outlinedata);
  }

  if(isDefined(outlinedata)) {
    entitydata = spawnStruct();
    self.entityoutlines[entitynum] = entitydata;
    entitydata.list = [];
    entitydata.ent = ent;
    childents = getchildoutlineents(ent);

    foreach(child in childents) {
      entoutlineid = outlineenableforplayer(child, self, outlinedata.hudoutlineassetname, outlinedata.prioritygroup);
      outline = spawnStruct();
      outline.ent = child;
      outline.id = entoutlineid;
      childnum = child getentitynumber();
      entitydata.list[childnum] = outline;
    }
  }
}

function outlinehelper_disableentityoutline(entnum) {
  if(isDefined(entnum)) {
    entitydata = self.entityoutlines[entnum];

    if(isDefined(entitydata)) {
      foreach(outline in entitydata.list) {
        outline::outlinedisable(outline.id, outline.ent);
      }

      self.entityoutlines[entnum] = undefined;
    }
  }
}

function markedentities_removeentsbyindex(entarray, var_223829bbefc81935) {
  resultarray = [];

  foreach(ent in entarray) {
    if(!isDefined(ent)) {
      continue;
    }

    entnum = ent getentitynumber();

    if(!utility::array_contains(var_223829bbefc81935, entnum)) {
      resultarray[resultarray.size] = ent;
    }
  }

  return resultarray;
}

function markedentities_think() {
  self endon("disconnect");
  level endon("game_ended");
  self.entityoutlines = [];

  while(true) {
    self waittill("marks_changed", var_b56ac8b012f37095, var_7b50cc9c94be9505, var_c5dda6b7a37d4129);

    if(isDefined(var_b56ac8b012f37095)) {
      foreach(var_e0abeaa6ef08e178 in var_b56ac8b012f37095) {
        outlinehelper_disableentityoutline(var_e0abeaa6ef08e178);
      }

      if(isDefined(self.markequipmentstate)) {
        self.markequipmentstate.markedents = markedentities_removeentsbyindex(self.markequipmentstate.markedents, var_b56ac8b012f37095);

        if(self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size) {
          self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
        }
      }
    }

    if(isDefined(var_7b50cc9c94be9505)) {
      foreach(var_4905d157180507c8 in var_7b50cc9c94be9505) {
        outlinehelper_disableentityoutline(var_4905d157180507c8);
      }
    }

    if(isDefined(var_c5dda6b7a37d4129)) {
      foreach(addedent in var_c5dda6b7a37d4129) {
        outlinehelper_enableentityoutline(addedent);
      }
    }
  }
}

function setbettermissionrewards() {}

function unsetbettermissionrewards() {}

function setspecialistbonus() {
  if(!game_utility::isbrstylegametype()) {
    self setclientomnvar("ui_specialist_bonus_active", 1);
  }
}

function unsetspecialistbonus() {
  if(!game_utility::isbrstylegametype()) {
    self setclientomnvar("ui_specialist_bonus_active", 0);
  }
}

function setthirdpersonmode() {
  self.perkthirdperson = 1;
  class::setthirdpersonview();
}

function function_fbd953549be66251() {
  self.perkthirdperson = undefined;

  if(!istrue(level.gameended)) {
    class::setthirdpersonview();
  }
}

function function_d31614685fb778e1() {
  self notify("undying");
  self.undying = 1;
}

function function_62e54942c53b9bda() {
  self notify("undyingEnd");
  self.undying = undefined;
}

function function_7cfa6000210cbd68() {
  self setclientomnvar("ui_overcharge", 2);
}

function function_f1a813fe1b8a2275() {
  self setclientomnvar("ui_overcharge", 0);
}

function function_6faff35e3a38ba5f() {
  thread function_28c65ef144ef09ed();
}

function function_d02ed6d205e7eb64() {}

function setsurvivor() {}

function unsetsurvivor() {}

function function_17f9b8d5579b7e98() {
  if(game_utility::isbrstylegametype()) {
    if(getdvarint(@ "hash_8c032d1b63113ba0", 0) != 0) {
      return;
    }

    self.var_678855513f5076ca = 1;
    self.var_514192f8282796c = getdvarint(@ "hash_5873a982b260e538", 1);
    self.overclockcharge = 0;
    superammo = equipment::getequipmentslotammo("super");

    if(isDefined(supers::getcurrentsuper()) && isDefined(superammo) && superammo > 0) {
      if(function_66f0cbd5ff8458fe()) {
        equipment::setequipmentslotammo("super", 0);
        supers::givesuperpoints(supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);
      }
    } else if(isDefined(supers::getcurrentsuper())) {
      self setclientomnvar("ui_perk_package_state", 3);
    }
  } else if(!isDefined(self.overclockcharge)) {
    self.overclockcharge = 0;
  }

  thread function_e382d4a17c2fd280();
}

function function_66f0cbd5ff8458fe() {
  assert(isPlayer(self));
  currentsuper = supers::getcurrentsuper();

  if(!isDefined(currentsuper)) {
    return false;
  }

  if(level.allowsupers && !game_utility::isbrstylegametype()) {
    return true;
  }

  if(!istrue(self.var_678855513f5076ca) && !istrue(supers::function_868a75fd7c215c07())) {
    return false;
  }

  if(supers::function_f95bcca44e8cba53(currentsuper.staticdata.ref)) {
    return false;
  }

  return true;
}

function function_448448ac4206d715() {
  if(isDefined(self.var_2c0bf62a8db71fd0)) {
    self.var_2c0bf62a8db71fd0 = undefined;
  }

  if(isDefined(self.var_491f93d0219d8d44) && self.var_491f93d0219d8d44 > 1) {
    self.var_491f93d0219d8d44 -= 1;
  }

  if(game_utility::isbrstylegametype()) {
    if(isDefined(supers::getcurrentsuper())) {
      supers::function_8c7b1312cf5986b(0);

      if(supers::getcurrentsuperpoints() < supers::getsuperpointsneeded()) {
        if(!supers::issuperinuse()) {
          supers::setsuperbasepoints(0);
          thread supers::function_e648b6fc93bbc0e0();
          self setclientomnvar("ui_perk_package_state", 0);
        }
      }
    }
  }

  if(isDefined(self.var_678855513f5076ca)) {
    self.var_678855513f5076ca = undefined;
  }

  if(isDefined(self.var_514192f8282796c)) {
    self.var_514192f8282796c = undefined;
  }

  self notify("end_overcharge_field_upgrade");
}

function function_e382d4a17c2fd280() {
  self endon("death_or_disconnect");
  self endon("end_overcharge_field_upgrade");

  while(!isDefined(self.var_678855513f5076ca)) {
    self waittill("super_use_charging");
    waitframe();

    if(self.super.isinuse) {
      continue;
    }

    if(!function_66f0cbd5ff8458fe()) {
      continue;
    }

    if(self.overclockcharge > 0 && supers::issupercharging()) {
      supers::givesuperpoints(self.overclockcharge, undefined, undefined, undefined, 1);
      self.overclockcharge = 0;
      self setclientomnvar("ui_super_second_progress", 0);
    }
  }
}

function function_28c65ef144ef09ed() {
  self endon("death_or_disconnect");
  waitframe();
  armor::givestartingarmor(50, 1);
}

function function_6964a0e0e8d00b09(perk) {
  if(!istrue(level.var_606eb45e074ff204)) {
    return;
  }

  switch (perk) {
    case #"hash_53b0051b1bb90222":
      function_c0480a308e322f5e();
      break;
    case #"hash_f3b391e08ecec3c1":
      function_deaae24be7f66b43();
      break;
  }
}

function function_f1aded34ad0d8d15() {
  super = supers::getcurrentsuper();

  if(!isDefined(super)) {
    return false;
  }

  if(!isDefined(super.basepoints)) {
    return false;
  }

  if(!isDefined(super.extrapoints)) {
    return false;
  }

  if(!isDefined(super.staticdata.pointsneeded)) {
    return false;
  }

  return true;
}

function function_c0480a308e322f5e() {
  if(!function_f1aded34ad0d8d15()) {
    return;
  }

  currentpoints = ter_op(supers::issuperready() || supers::issuperinuse(), supers::getsuperpointsneeded(), supers::getcurrentsuperpoints());
  maxpoints = supers::getsuperpointsneeded();
  overchargepoints = max(0, maxpoints - currentpoints);
  supers::givesuperpoints(supers::getsuperpointsneeded());
  self.overclockcharge = clamp(currentpoints, 0, maxpoints);

  if(!isDefined(self.var_491f93d0219d8d44)) {
    self.var_491f93d0219d8d44 = 1;
  }

  self.var_491f93d0219d8d44 += 1;
}

function function_deaae24be7f66b43() {
  triggerportableradarping(self.origin, self, 3000, 3000);
}

function function_5574429fa21b6a4b() {
  self.pers["hasEarnedHardlineStreak"] = 0;
  killstreaks::givestreakpoints(#"hash_faa043c8926419e6", 3, 0);
}

function function_de2e2e90e60ab20b() {
  equipment = self getweaponslistoffhands();

  foreach(item in equipment) {
    self givemaxammo(item);
  }
}

function function_649944f83a9270f1() {
  killstreaks::awardkillstreak("scrambler_drone_guard", "other");
}

function function_9569d64cd3471640() {
  playertargets = utility::function_2d7fd59d039fa69b(self.origin, 3000);
  outlinedata = snapshot_grenade::snapshot_grenade_createoutlinedata(self, self.origin);

  foreach(player in playertargets) {
    if(!player::isreallyalive(player)) {
      continue;
    }

    if(!player_utility::playersareenemies(self, player)) {
      continue;
    }

    snapshot_grenade::snapshot_grenade_applysnapshot(player, self, outlinedata, 2500, 1);
  }
}

function function_2afcfd10baa613f4() {
  if(perk::_hasperk("specialty_armored") && self getammocount("bandage_br") < 1) {
    armor::function_9c6e9a6643b6c9a6(1);
  }
}

function setanteup() {
  self notify("setAnteUp_singleton");
  self endon("setAnteUp_singleton");
  self endon("death_or_disconnect");

  if(istrue(self.gettingloadout)) {
    self waittill("giveLoadout");
  }

  bundle = level.perkbundles["specialty_ante_up"];
  points = utility::default_to(bundle.var_6ad84838e108705a, 0);

  if(!istrue(self.var_606b2fb83bfcb7d1) && isDefined(self.streakpoints)) {
    events::killeventtextpopup(#"ante_up", 0);
    killstreaks::setstreakpoints(self.streakpoints + points);
    self.var_606b2fb83bfcb7d1 = 1;
  }
}

function function_22483f0bf514320b() {
  bundle = level.perkbundles["specialty_ante_up"];
  points = utility::default_to(bundle.var_6ad84838e108705a, 0);

  if(istrue(self.var_606b2fb83bfcb7d1) && isDefined(self.streakpoints)) {
    killstreaks::setstreakpoints(self.streakpoints - points);
    self.var_606b2fb83bfcb7d1 = 0;
  }
}

function function_f20745ab641c4bb7() {
  thread function_72c65d09b47dfda1();
}

function function_6df29935c2b4318c() {
  self notify("unset_high_gain_antenna");

  if(self.var_78ede70519cfb53b.size > 0) {
    var_17f63f0b03e2f03d = self.var_78ede70519cfb53b;
    self.var_78ede70519cfb53b = [];

    foreach(player in var_17f63f0b03e2f03d) {
      player notify("disable_high_gain_effect");
    }
  }
}

function function_72c65d09b47dfda1() {
  self endon("disconnect");
  self endon("unset_high_gain_antenna");
  level endon("game_ended");

  if(!isDefined(self.var_78ede70519cfb53b)) {
    self.var_78ede70519cfb53b = [];
  }

  if(!istrue(level.teambased)) {
    return;
  }

  flags::function_1240434f4201ac9d("prematch_done");
  var_54fee845c3f950c1 = perk::_hasperk("specialty_cct_vest");
  var_1e25161c8146f05f = perk::_hasperk("specialty_signal_jammer");
  thread function_312d166c148ae59();

  while(true) {
    if(!player::isreallyalive(self)) {
      if(self.var_78ede70519cfb53b.size > 0) {
        var_17f63f0b03e2f03d = self.var_78ede70519cfb53b;
        self.var_78ede70519cfb53b = [];

        foreach(player in var_17f63f0b03e2f03d) {
          player notify("disable_high_gain_effect");
        }
      }

      wait 0.2;
      continue;
    }

    var_17f63f0b03e2f03d = self.var_78ede70519cfb53b;
    var_7bc1965cd73d3522 = player::getplayersinradius(self.origin, 700, self.team, self);
    self.var_78ede70519cfb53b = var_7bc1965cd73d3522;
    var_998b8aea34c5bd8d = var_54fee845c3f950c1;
    var_e91dc26e9a03ed28 = 0;

    foreach(player in var_17f63f0b03e2f03d) {
      if(!isDefined(player)) {
        continue;
      }

      if(utility::array_contains(var_7bc1965cd73d3522, player)) {
        continue;
      }

      player notify("disable_high_gain_effect");

      if(player perk::_hasperk("specialty_signal_jammer")) {
        self.var_9eee5250fa710b87 = array_remove(self.var_9eee5250fa710b87, player);
        thread function_14887aa48f755651(0);
      }
    }

    foreach(player in var_7bc1965cd73d3522) {
      if(!isDefined(player)) {
        continue;
      }

      if(!var_998b8aea34c5bd8d && player perk::_hasperk("specialty_cct_vest")) {
        var_998b8aea34c5bd8d = 1;
      }

      if(player perk::_hasperk("specialty_signal_jammer")) {
        if(!isDefined(self.var_9eee5250fa710b87)) {
          self.var_9eee5250fa710b87 = var_1e25161c8146f05f ? [self] : [];
        }

        if(!arraycontains(self.var_9eee5250fa710b87, player)) {
          self.var_9eee5250fa710b87 = function_6d6af8144a5131f1(self.var_9eee5250fa710b87, player);
          var_e91dc26e9a03ed28 = 1;
        }
      }

      if(utility::array_contains(var_17f63f0b03e2f03d, player)) {
        continue;
      }

      if(!player perk::_hasperk("specialty_high_gain_antenna") && !player perk::_hasperk("specialty_cct_vest")) {
        player perk::giveperk("specialty_expanded_minimap");
      }

      if(var_1e25161c8146f05f) {
        player thread function_d3a88fbbd1592a94(self);
      }

      player thread function_771a3235fe378b71(self);
    }

    self.var_a368775db4f59f8a = var_998b8aea34c5bd8d;

    if(var_e91dc26e9a03ed28) {
      thread function_d3a88fbbd1592a94(self);
    }

    foreach(player in var_7bc1965cd73d3522) {
      var_823ebd7bfe78d14a = player perk::_hasperk("specialty_acousticSensor");
      var_161c08f533c48c10 = player perk::_hasperk("specialty_cct_vest");

      if(var_998b8aea34c5bd8d && !var_823ebd7bfe78d14a) {
        player perk::giveperk("specialty_acousticSensor");
      } else if(!var_998b8aea34c5bd8d && var_823ebd7bfe78d14a && !var_161c08f533c48c10) {
        player perk::removeperk("specialty_acousticSensor");
      }

      if(var_e91dc26e9a03ed28) {
        player thread function_d3a88fbbd1592a94(self);
      }
    }

    wait 0.2;
  }
}

function function_312d166c148ae59() {
  self endon("unset_high_gain_antenna");
  level endon("game_ended");

  while(isDefined(self)) {
    var_17f63f0b03e2f03d = self.var_78ede70519cfb53b;
    wait 0.2;
  }

  foreach(player in var_17f63f0b03e2f03d) {
    player notify("disable_high_gain_effect");
  }
}

function function_f0acc19bc9f58105(equipment) {
  if(!isDefined(self.var_e9414cc5514761a7)) {
    self.var_e9414cc5514761a7 = [];
  }

  self.var_e9414cc5514761a7 = utility::function_6d6af8144a5131f1(self.var_e9414cc5514761a7, equipment);

  if(!isDefined(self.var_8b4a3e70676f710f) || self.var_8b4a3e70676f710f.size == 0) {
    return;
  }

  playerlist = self.var_8b4a3e70676f710f;

  foreach(player in self.var_8b4a3e70676f710f) {
    playerlist = array_combine_unique(playerlist, player.var_78ede70519cfb53b);
  }

  if(perk::_hasperk("specialty_high_gain_antenna")) {
    playerlist = array_combine_unique(playerlist, self.var_78ede70519cfb53b);
  }

  foreach(player in playerlist) {
    objidpoolmanager::objective_playermask_addshowplayer(equipment.var_50d8a278fa3d1ddd, player);
    player.var_85e3aca304e129b2 = utility::function_6d6af8144a5131f1(self.var_e9414cc5514761a7, equipment);
  }
}

function function_6cf221eaa466443b(equipment) {
  if(isDefined(self.var_e9414cc5514761a7) && isDefined(equipment)) {
    self.var_e9414cc5514761a7 = utility::array_remove(self.var_e9414cc5514761a7, equipment);
  }

  if(!isDefined(self.var_8b4a3e70676f710f) || self.var_8b4a3e70676f710f.size == 0) {
    return;
  }

  playerlist = [];

  foreach(player in self.var_8b4a3e70676f710f) {
    playerlist = array_combine_unique(playerlist, player.var_78ede70519cfb53b);
  }

  if(perk::_hasperk("specialty_high_gain_antenna")) {
    playerlist = array_combine_unique(playerlist, self.var_78ede70519cfb53b);
  }

  foreach(player in playerlist) {
    if(isDefined(equipment) && isDefined(equipment.var_50d8a278fa3d1ddd)) {
      objidpoolmanager::objective_playermask_hidefrom(equipment.var_50d8a278fa3d1ddd, player);

      if(isDefined(self.var_e9414cc5514761a7)) {
        player.var_85e3aca304e129b2 = utility::array_remove(self.var_e9414cc5514761a7, equipment);
      }
    }
  }
}

function function_d3a88fbbd1592a94(var_d1a37ff59732b305) {
  if(!isDefined(var_d1a37ff59732b305.var_9eee5250fa710b87) || var_d1a37ff59732b305.var_9eee5250fa710b87.size == 0) {
    return;
  }

  if(!isDefined(self.var_85e3aca304e129b2)) {
    self.var_85e3aca304e129b2 = [];
  }

  foreach(player in var_d1a37ff59732b305.var_9eee5250fa710b87) {
    if(isDefined(player.var_e9414cc5514761a7) && isarray(player.var_e9414cc5514761a7)) {
      self.var_85e3aca304e129b2 = array_combine_unique(self.var_85e3aca304e129b2, player.var_e9414cc5514761a7);
    }
  }

  foreach(equipment in self.var_85e3aca304e129b2) {
    if(isDefined(equipment) && isDefined(equipment.var_50d8a278fa3d1ddd)) {
      objidpoolmanager::objective_playermask_addshowplayer(equipment.var_50d8a278fa3d1ddd, self);
    }
  }
}

function function_14887aa48f755651(fromdeath) {
  if(istrue(fromdeath)) {
    self.var_85e3aca304e129b2 = undefined;
    return;
  }

  var_1e25161c8146f05f = perk::_hasperk("specialty_signal_jammer");
  var_f8c5d29ff44c8ec4 = perk::_hasperk("specialty_high_gain_antenna");
  var_f5b8769d7e9c57d3 = istrue(var_1e25161c8146f05f) ? self.var_e9414cc5514761a7 : [];

  if(!isDefined(var_f5b8769d7e9c57d3)) {
    var_f5b8769d7e9c57d3 = [];
  }

  if(isDefined(self.var_8b4a3e70676f710f) && self.var_8b4a3e70676f710f.size > 0) {
    foreach(ally in self.var_8b4a3e70676f710f) {
      if(!isDefined(ally)) {
        continue;
      }

      if(isDefined(ally.var_9eee5250fa710b87)) {
        foreach(player in ally.var_9eee5250fa710b87) {
          if(isDefined(player.var_e9414cc5514761a7)) {
            var_f5b8769d7e9c57d3 = array_combine_unique(var_f5b8769d7e9c57d3, player.var_e9414cc5514761a7);
          }
        }
      }
    }
  }

  if(istrue(var_f8c5d29ff44c8ec4) && isDefined(self.var_9eee5250fa710b87)) {
    foreach(player in self.var_9eee5250fa710b87) {
      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(player.var_e9414cc5514761a7)) {
        var_f5b8769d7e9c57d3 = array_combine_unique(var_f5b8769d7e9c57d3, player.var_e9414cc5514761a7);
      }
    }
  }

  if(isDefined(self.var_85e3aca304e129b2)) {
    foreach(equipment in self.var_85e3aca304e129b2) {
      if(!isDefined(equipment)) {
        continue;
      }

      var_b9be45355e6b3143 = arraycontains(var_f5b8769d7e9c57d3, equipment);

      if(!var_b9be45355e6b3143) {
        if(isDefined(equipment) && isDefined(equipment.var_50d8a278fa3d1ddd)) {
          objidpoolmanager::objective_playermask_hidefrom(equipment.var_50d8a278fa3d1ddd, self);
        }
      }
    }
  }
}

function function_771a3235fe378b71(sourceplayer) {
  self notify("monitoring_expanded_minimap");
  self endon("monitoring_expanded_minimap");

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.var_8b4a3e70676f710f)) {
    self.var_8b4a3e70676f710f = [];
  }

  self.var_8b4a3e70676f710f = function_6d6af8144a5131f1(self.var_8b4a3e70676f710f, sourceplayer);
  var_54fee845c3f950c1 = perk::_hasperk("specialty_cct_vest");
  var_d9eca2d80fb3c507 = perk::_hasperk("specialty_high_gain_antenna");
  var_1e25161c8146f05f = perk::_hasperk("specialty_signal_jammer");

  while(true) {
    result = utility::waittill_any_return_2("death_or_disconnect", "disable_high_gain_effect");

    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(result) || result == "death_or_disconnect") {
      if(!var_54fee845c3f950c1 && !var_d9eca2d80fb3c507) {
        perk::removeperk("specialty_expanded_minimap");
      }

      if(!var_54fee845c3f950c1) {
        perk::removeperk("specialty_acousticSensor");
      }

      self.var_8b4a3e70676f710f = [];
      thread function_14887aa48f755651(1);
      return;
    }

    if(result == "disable_high_gain_effect") {
      var_ff70a362648a3141 = 0;

      if(self.var_8b4a3e70676f710f.size == 1) {
        if(!var_54fee845c3f950c1 && !var_d9eca2d80fb3c507) {
          perk::removeperk("specialty_expanded_minimap");
        }

        if(!var_54fee845c3f950c1) {
          perk::removeperk("specialty_acousticSensor");
        }

        self.var_8b4a3e70676f710f = [];
        thread function_14887aa48f755651(0);
        return;
      }

      if(isDefined(self) && isDefined(self.var_78ede70519cfb53b)) {
        foreach(player in self.var_8b4a3e70676f710f) {
          if(!(isDefined(player) && isDefined(player.var_78ede70519cfb53b))) {
            continue;
          }

          if(utility::array_contains(player.var_78ede70519cfb53b, self) && isalive(player)) {
            if(istrue(player.var_a368775db4f59f8a)) {
              var_ff70a362648a3141 = 1;
            }

            continue;
          }

          self.var_8b4a3e70676f710f = utility::array_remove(self.var_8b4a3e70676f710f, player);
        }

        thread function_14887aa48f755651(0);

        if(self.var_8b4a3e70676f710f.size == 0) {
          if(!var_54fee845c3f950c1 && !var_d9eca2d80fb3c507) {
            perk::removeperk("specialty_expanded_minimap");
          }

          if(!var_54fee845c3f950c1) {
            perk::removeperk("specialty_acousticSensor");
          }

          return;
        }

        if(!var_ff70a362648a3141 && !var_54fee845c3f950c1 && perk::_hasperk("specialty_acousticSensor")) {
          perk::removeperk("specialty_acousticSensor");
        }
      }
    }
  }
}

function function_eed479acba7fe853() {
  if(getdvarint(@ "hash_a93a2419d7580413", 0) == 1) {
    return;
  }

  self.var_9d84a996d9e90c2 = 0;
  self.var_1df3276704659646 = 0;
  function_1d114ca0c1f73008(0);
  function_b287c9114a845cee(0);
  playernum = self getentitynumber();
  level.var_52ec346520cb321c[playernum] = self;
  self.var_5dcd6d4ac51be6d5 = [];
}

function function_98c1ad957058c942() {
  thread function_e41537546ebf302a();
}

function function_e41537546ebf302a() {
  self endon("disconnect");
  self.var_9d84a996d9e90c2 = undefined;
  self.var_1df3276704659646 = undefined;
  self.var_caeaabdc03ba4508 = undefined;
  self.var_5dcd6d4ac51be6d5 = undefined;
  self.var_df81db1ae87349f2 = undefined;
  self notify("removeLRDetector");
  playernum = self getentitynumber();
  level.var_52ec346520cb321c[playernum] = undefined;
  waitframe();
  function_1d114ca0c1f73008(0);
  function_b287c9114a845cee(0);
}

function function_83091d5e2028334f() {
  playernum = self getentitynumber();
  level.var_ff7ad25f9727ddc4[playernum] = self;
  level.delayminetime = 1.5;
  function_3f33157318043ac2(0);
}

function function_1e8369c15351446a() {
  playernum = self getentitynumber();
  level.var_ff7ad25f9727ddc4[playernum] = undefined;
  function_3f33157318043ac2(0);
}

function function_76e4f570efdfa175() {
  if(!isDefined(self.var_d0205933322679a9)) {
    self.var_d0205933322679a9 = 1;
    return;
  }

  self.var_d0205933322679a9 += 1;
}

function function_9a193d97b9a9b860() {
  if(!isDefined(self.var_d0205933322679a9)) {
    return;
  }

  if(self.var_d0205933322679a9 > 1) {
    self.var_d0205933322679a9 -= 1;
    return;
  }

  self.var_d0205933322679a9 = undefined;
}

function function_7051260539f7f5cf() {
  thread armor::function_c49eb6797b9eec64();
}

function function_d98540c03eb44f92() {
  self notify("armor_regen_end");
}

function function_de6e36b06bd630c4(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip) {
  var_9aa3334c23f7c3bb = armor::function_ac266fc218266d08();
  var_29f26361d277c4c8 = level.var_4b78859bacc88808;
  var_7ab9a8f132665d68 = self.maxarmorhealth;
  var_a81e45534563d02a = int(var_7ab9a8f132665d68 / var_29f26361d277c4c8);

  if(pickupent.count > 0 && var_9aa3334c23f7c3bb < var_7ab9a8f132665d68) {
    var_a86307ef44894749 = 0;
    var_aed59370e8ac080f = var_7ab9a8f132665d68 - var_9aa3334c23f7c3bb;

    if(var_aed59370e8ac080f <= var_29f26361d277c4c8) {
      var_a86307ef44894749 = 1;
    } else {
      var_a86307ef44894749 = ceil(var_aed59370e8ac080f / var_29f26361d277c4c8);
    }

    if(var_a86307ef44894749 == pickupent.count) {
      pickupent.count = 0;
      armor::setarmorhealth(var_7ab9a8f132665d68);
      return 0;
    } else if(var_a86307ef44894749 < pickupent.count) {
      pickupent.count -= var_a86307ef44894749;
      armor::setarmorhealth(var_7ab9a8f132665d68);
      pickupremains = br_pickups::takeequipmentpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
      return pickupremains;
    } else {
      newarmoramount = min(pickupent.count * var_29f26361d277c4c8, var_7ab9a8f132665d68);
      pickupent.count = 0;
      armor::setarmorhealth(newarmoramount);
      return 0;
    }

    return;
  }

  pickupremains = br_pickups::takeequipmentpickup(pickupent, fromkiosk, var_db943473454f6ea6, backpackequip);
  return pickupremains;
}

function function_c5d5909e07c87005(armor) {
  var_9aa3334c23f7c3bb = armor::function_ac266fc218266d08();
  var_29f26361d277c4c8 = level.var_4b78859bacc88808;
  var_7ab9a8f132665d68 = self.maxarmorhealth;
  var_a81e45534563d02a = int(var_7ab9a8f132665d68 / var_29f26361d277c4c8);

  if(var_9aa3334c23f7c3bb < var_7ab9a8f132665d68) {
    var_a86307ef44894749 = 0;
    var_aed59370e8ac080f = var_7ab9a8f132665d68 - var_9aa3334c23f7c3bb;

    if(var_aed59370e8ac080f <= var_29f26361d277c4c8) {
      var_a86307ef44894749 = 1;
    } else {
      var_a86307ef44894749 = ceil(var_aed59370e8ac080f / var_29f26361d277c4c8);
    }

    if(var_a86307ef44894749 == 1) {
      armor::setarmorhealth(var_7ab9a8f132665d68);
      return true;
    } else {
      newarmoramount = min(var_29f26361d277c4c8, var_7ab9a8f132665d68);
      armor::setarmorhealth(newarmoramount);
      return true;
    }
  }

  return false;
}

function setdurability() {
  healthscale = getdvarfloat(@ "hash_295c99a0f67c5f7d", 1.5);
  self.maxhealth = int(healthscale * float(letweakables::gettweakablevalue("player", "maxhealth")));
  self.health = self.maxhealth;
}

function unsetdurability() {
  self.maxhealth = tweakables::gettweakablevalue("player", "maxhealth");
}

function function_a85e18c43231438d() {
  speedboost = getdvarfloat(@ "hash_94084550cb0f64e7", 2);
  self.var_a100e03b8bb95214 = self.movespeedscaler;
  self.movespeedscaler = speedboost;
  weapons::updatemovespeedscale();
}

function function_b9186877a86e12f0() {
  self.movespeedscaler = self.var_a100e03b8bb95214;
  self.var_a100e03b8bb95214 = undefined;
  weapons::updatemovespeedscale();
}

function setoperative() {
  if(!isDefined(self.var_892c291c8eec8af2)) {
    self.var_892c291c8eec8af2 = 0;
    return;
  }

  if(istrue(self.var_892c291c8eec8af2)) {
    return;
  }

  thread function_b2219a25a144067();
  self notify("setoperative_outlines");

  if(istrue(self.gettingloadout)) {
    self endon("setoperative_outlines");
    self endon("death_or_disconnect");
    self waittill("giveLoadout");
  }

  bundle = level.perkbundles["specialty_operative"];
  buffduration = utility::default_to(bundle.var_ffe863e741796294, 0);
  setoperativeoutlines();
  function_4030b0cbd934f9c(buffduration);
}

function function_b2219a25a144067() {
  self notify("resetOperativeSingleton");
  self endon("resetOperativeSingleton");
  self endon("disconnect");
  self waittill("death");
  self.var_892c291c8eec8af2 = 0;
}

function setoperativeoutlines() {
  self.var_892c291c8eec8af2 = 1;

  if(!isDefined(self.var_4920729d2bb168e6)) {
    self.var_4920729d2bb168e6 = [];
  }

  foreach(enemy in level.players) {
    if(!isPlayer(enemy)) {
      continue;
    }

    if(!player_utility::isenemy(enemy)) {
      continue;
    }

    self.var_4920729d2bb168e6[enemy getentitynumber()] = outline::outlineenableforplayer(enemy, self, "outline_nodepth_red", "level_script");
  }
}

function function_4030b0cbd934f9c(delaytime) {
  if(!isarray(self.var_4920729d2bb168e6)) {
    return;
  }

  if(delaytime) {
    self endon("setoperative_outlines");
    self endon("death_or_disconnect");
    wait delaytime;
  }

  foreach(enemy in level.players) {
    if(!isPlayer(enemy)) {
      continue;
    }

    if(!player_utility::isenemy(enemy)) {
      continue;
    }

    enemyentnum = enemy getentitynumber();

    if(!isDefined(self.var_4920729d2bb168e6[enemyentnum])) {
      continue;
    }

    outline::outlinedisable(self.var_4920729d2bb168e6[enemyentnum], enemy);
  }
}

function unsetoperative() {
  function_4030b0cbd934f9c(0);
}

function setoverwatch() {
  self.radarshowenemydirection = 1;
}

function unsetoverwatch() {
  if(isDefined(level.activeadvanceduavs) && isDefined(level.activeadvanceduavs[self.team]) && level.activeadvanceduavs[self.team] > 0) {
    return;
  }

  self.radarshowenemydirection = 0;
}

function function_af3d35751dfd4e79() {
  if(game_utility::isbrstylegametype()) {
    return undefined;
  }

  return ["specialty_expanded_minimap"];
}

function function_81f0718f6c5ab1d7() {
  self setgrenadethrowscale(1.25);
}

function function_2bba0e9e144c276c() {
  self setgrenadethrowscale(1);
}

function function_e2df669ada6f810c() {
  bundle = level.perkbundles["specialty_scavenger"];
  var_d86975024a74ba6c = isDefined(bundle) && istrue(bundle.var_a17534d1b2c3f881);

  if(!var_d86975024a74ba6c && perk::_hasperk("specialty_scavenger_equipment")) {
    perks::_unsetperk("specialty_scavenger_equipment");
  }
}

function function_76826219412c80ce() {
  bundle = level.perkbundles["specialty_flak_jacket"];

  if(!isDefined(bundle) && perk::_hasperk("specialty_flak_jacket")) {
    perks::_unsetperk("specialty_flak_jacket");
    return;
  }

  if(isDefined(self.flakjackethealth)) {
    if(self.flakjackethealth <= 0) {
      function_bbfb43eded941446();
    }

    return;
  }

  self.flakjackethealth = utility::default_to(bundle.var_ae4892e2f1bb4145, 200);
  self.var_8cbe63a199e19de = utility::default_to(bundle.var_8cbe63a199e19de, 50);
  self.var_fb1106d94cc95901 = utility::default_to(bundle.var_fb1106d94cc95901, 50);
  self.var_567daf189be4de79 = utility::default_to(bundle.var_13d115cb3cbfd2d0, 0);
  function_576ff7cb2b682b18();
}

function function_2a071b7e5d0351d3() {
  self.flakjackethealth = undefined;
  self.var_8ddde3a19b245a2 = undefined;
  self.var_fb21fed94cdb51c5 = undefined;
  self.var_567daf189be4de79 = undefined;
  function_8a6140b305c1b22b();
}

function initflakjacket() {
  damagefeedback::function_7bc7c3983cef0956("hitFlakJacket", 20);
}

function function_21ec07ce4e600c3a(amount) {
  startinghealth = self.flakjackethealth;
  self.flakjackethealth += amount;

  if(startinghealth <= 0 && self.flakjackethealth > 0) {
    perks::_setperk("specialty_blastshield");
    perks::_setperk("specialty_fire_resistence");
    function_576ff7cb2b682b18();
  }
}

function function_576ff7cb2b682b18() {
  self notify("flakJacket_Singleton");
  self endon("flakJacket_Singleton");
  self setclientomnvar("ui_flakJacket", 1);
  thread function_46990aae5ce032ad();
  self notify("blast_shield_damaged", self.flakjackethealth);
}

function function_8a6140b305c1b22b() {
  self setclientomnvar("ui_flakJacket", 0);
  self notify("blast_shield_removed");
}

function function_46990aae5ce032ad() {
  self endon("death_or_disconnect");
  self endon("blast_shield_removed");

  while(true) {
    self waittill("blast_shield_damaged", remaining);
    self setclientomnvar("ui_flakJacket_health", int(max(remaining, 0)));
  }
}

function function_df1f464b16738e76() {
  bundle = level.perkbundles["specialty_flak_jacket"];

  if(!isDefined(bundle)) {
    return;
  }

  if(isDefined(self.var_fb21fed94cdb51c5)) {
    return;
  }

  self.var_fb21fed94cdb51c5 = utility::default_to(bundle.var_fb21fed94cdb51c5, 50);
}

function function_9a3330b21e0ad027() {
  self.var_fb21fed94cdb51c5 = undefined;
}

function breakflakjacket() {
  function_bbfb43eded941446();
  function_8a6140b305c1b22b();
}

function function_bbfb43eded941446() {
  perks::_unsetperk("specialty_blastshield");
  perks::_unsetperk("specialty_fire_resistence");
}

function function_c834f1eacbb06d09() {}

function function_b35c8cf5dd0e38a2() {}

function function_57fa0386e81eaf33() {
  self.radarshowenemydirection = 1;

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    level thread overlord::function_aea00c3815b226da(self);
  }
}

function function_4173e65571fbfd44() {
  if(!isDefined(self) || !isDefined(self.team)) {
    return 0;
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    self notify("monitor_enemy_prox");
  }

  if(isDefined(level.activeadvanceduavs) && isDefined(level.activeadvanceduavs[self.team]) && level.activeadvanceduavs[self.team] > 0) {
    return;
  }

  self.radarshowenemydirection = 0;
}

function function_4ca1864c4b501d86() {
  return ceil(self.maxarmorhealth / (scripts\cp_mp\armor::function_829e435158d419cf() - 1));
}

function function_f307e70927a22f9e() {
  self.var_42294cc94c3bf2c3 = &function_4ca1864c4b501d86;
  self.var_cc09658e840807ae = 1;
  scripts\cp_mp\armor::setarmoromnvars(1);
}

function function_618d9ea3d5fd1a77() {
  self.var_42294cc94c3bf2c3 = undefined;
  self.var_cc09658e840807ae = undefined;
  scripts\cp_mp\armor::setarmoromnvars(1);
}

function function_7603aadd14da7ec6() {
  self.hasplatepouch = 1;
}

function function_6af20073381a18d3() {
  self.hasplatepouch = 0;
}

function function_da3d9f34d24ac85a() {
  scripts\cp_mp\talking_gun::function_f70b3ce9138e10b(self);
}

function function_96f59fefd781e47() {
  if(!getdvarint(@ "hash_18bf04d5c5766462")) {
    return;
  }

  scripts\cp_mp\talking_gun::function_2cc0d17b7e641e00(self, "announcer");
}

function function_96f5afefd78207a() {
  if(!getdvarint(@ "hash_18bf04d5c5766462")) {
    return;
  }

  scripts\cp_mp\talking_gun::function_2cc0d17b7e641e00(self, "robot");
}

function function_96f5bfefd7822ad() {
  if(!getdvarint(@ "hash_18bf04d5c5766462")) {
    return;
  }

  scripts\cp_mp\talking_gun::function_2cc0d17b7e641e00(self, "hypeman");
}

function function_96f54fefd781348() {
  if(!getdvarint(@ "hash_18bf04d5c5766462")) {
    return;
  }

  scripts\cp_mp\talking_gun::function_2cc0d17b7e641e00(self, "blackcell");
}

function function_fc6e0b02abb995cb() {
  scripts\cp_mp\talking_gun::function_2cc0d17b7e641e00(self, "announcer");
}

function function_73e4ae4f932e9f30() {
  scripts\cp_mp\talking_gun::function_2cc0d17b7e641e00(self, "robot");
}

function function_53e56fe3fd9ad3e1() {
  if(isDefined(level.nvgvisionsetoverride) && isstring(level.nvgvisionsetoverride)) {
    visionsetnight(level.nvgvisionsetoverride);
  } else {
    self visionsetnightforplayer(function_1564f9bd3b0b6974());
    self visionsetthermalforplayer("flir_2_color_gradient", 100);
  }

  if(!isDefined(self.pers["killstreak_forcedNVGOff"])) {
    self.pers["killstreak_forcedNVGOff"] = 0;
  }

  thread function_f45b32f9e7bc9d8d(0);
  thread function_a13126ffa1e84c59(2);
  self notifyonplayercommand("nods_button_down", "+usereload");
  self notifyonplayercommand("nods_button_up", "-usereload");
  self notifyonplayercommand("nods_kbm_button", "nightvision");
  thread function_4a6d4f51c86333c8();
}

function function_d23fd2ceae84da28() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self notify("nods_removed");
  self notifyonplayercommandremove("nods_button_down", "+usereload");
  self notifyonplayercommandremove("nods_button_up", "-usereload");
  self notifyonplayercommandremove("nods_kbm_button", "nightvision");

  if(istrue(self.pers["useNVG"])) {
    wait 1;
    function_5de0156e74e1a721();
  }
}

function function_1564f9bd3b0b6974() {
  value = getdvarint(@ "hash_35d51fe231a93ba9", 0);
  visionset = undefined;

  switch (value) {
    case 0:
      visionset = "nvg_base_mp";
      break;
    case 1:
      visionset = "flir_2_color_gradient";
      break;
    case 2:
      visionset = "nvg_base_color_nods_jup_test";
      break;
    case 3:
      visionset = "nvg_base_color_nods_jup_test_02";
      break;
    case 4:
      visionset = "nvg_base_color_nods_jup_test_03";
      break;
    case 5:
      visionset = "nvg_base_color_nods_jup_test_04";
      break;
    case 6:
      visionset = "nvg_base_color_nods_jup_test_05";
      break;
    default:
      visionset = "nvg_base_mp";
      break;
  }

  return visionset;
}

function function_4a6d4f51c86333c8() {
  self endon("death_or_disconnect");
  self endon("nods_removed");

  while(true) {
    result = utility::waittill_any_return_2("nods_button_down", "nods_kbm_button");

    if(result == "nods_kbm_button" && !self usinggamepad()) {
      function_5de0156e74e1a721();
      wait 1;
      continue;
    }

    if(result == "nods_button_down") {
      result = utility::waittill_any_timeout_1(0.5, "nods_button_up");
    }

    if(result != "nods_button_up") {
      function_5de0156e74e1a721();
      wait 1;
    }
  }
}

function function_5de0156e74e1a721() {
  if(self isonladder() || self ishanging() || self isthrowinggrenade()) {
    return;
  }

  if(isDefined(level.nvgvisionsetoverride) && isstring(level.nvgvisionsetoverride)) {
    visionsetnight(level.nvgvisionsetoverride);
  } else {
    self visionsetnightforplayer(function_1564f9bd3b0b6974());
    self visionsetthermalforplayer("flir_2_color_gradient", 100);
  }

  var_463eede85943f8d1 = getdvarint(@ "hash_787fb71bbd471c11", 3);

  if(istrue(self.pers["useNVG"])) {
    self notify("perk_nods_off");

    if(var_463eede85943f8d1 == 0 || var_463eede85943f8d1 == 3) {
      self nightvisionviewoff();
      thread function_f45b32f9e7bc9d8d(0);

      if(var_463eede85943f8d1 == 3) {
        thread function_c5f054586f38e212(0.5);
      }
    } else if(var_463eede85943f8d1 == 1) {
      player_utility::setthermalvision(0);
    }

    function_4c1282555bf1a747();
    return;
  }

  thread function_187253ccc9a3b3d3();

  if(var_463eede85943f8d1 == 0 || var_463eede85943f8d1 == 3) {
    self nightvisionviewon();
    thread function_f45b32f9e7bc9d8d(1);

    if(var_463eede85943f8d1 == 3) {
      thread function_a2668409a49bdef4(0.6);
    }
  } else if(var_463eede85943f8d1 == 1) {
    player_utility::setthermalvision(1, 12, 1000);
  }

  function_4c1282555bf1a747();
}

function function_4c1282555bf1a747() {
  if(!istrue(self.pers["useNVG"])) {
    self.pers["useNVG"] = 1;
    return;
  }

  if(istrue(self.pers["useNVG"]) && !istrue(self.pers["killstreak_forcedNVGOff"])) {
    self.pers["useNVG"] = 0;
  }
}

function function_a13126ffa1e84c59(delay, var_b34a1ff2f59f1fe7) {
  if(!istrue(game["flags"]["prematch_done"])) {
    flags::gameflagwait("prematch_done");
  }

  wait delay;
  time = 4;

  if(isDefined(var_b34a1ff2f59f1fe7) && (isint(var_b34a1ff2f59f1fe7) || isfloat(var_b34a1ff2f59f1fe7))) {
    time = var_b34a1ff2f59f1fe7;
  }

  if(self usinggamepad()) {
    thread print::tutorialprint(&"JUP_PERKS/NODS_PRESS_TO_USE", time);
    return;
  }

  thread print::tutorialprint(&"JUP_PERKS/NODS_PRESS_TO_USE_KB", time);
}

function function_187253ccc9a3b3d3() {
  self endon("perk_nods_off");
  self waittill("death_or_disconnect");
  self notify("perk_nods_off_death");
  var_463eede85943f8d1 = getdvarint(@ "hash_787fb71bbd471c11", 0);

  if(var_463eede85943f8d1 == 0 || var_463eede85943f8d1 == 3) {
    self nightvisionviewoff();
    waitframe();

    if(var_463eede85943f8d1 == 3) {
      function_c5f054586f38e212();
    }
  } else if(var_463eede85943f8d1 == 1) {
    player_utility::setthermalvision(0);
  }

  function_4c1282555bf1a747();
}

function function_f45b32f9e7bc9d8d(enabled) {
  if(getdvarint(@ "hash_1ffc5f854690aa28", 1) == 0) {
    return;
  }

  if(isDefined(self.nvg3rdpersonmodel)) {
    self detach(self.nvg3rdpersonmodel, "j_head");
    self.nvg3rdpersonmodel = undefined;
  }

  if(enabled) {
    modeldown = function_b9ae2029e2c1f6fb();

    if(isDefined(modeldown)) {
      self.nvg3rdpersonmodel = modeldown;
      self attach(self.nvg3rdpersonmodel, "j_head");
    }

    return;
  }

  modelup = function_f88841fc0718438();

  if(isDefined(modelup)) {
    self.nvg3rdpersonmodel = modelup;
    self attach(self.nvg3rdpersonmodel, "j_head");
  }
}

function function_b9ae2029e2c1f6fb() {
  modeldown = undefined;

  if(isDefined(level.nvgheadoverrides) && isDefined(level.nvgheadoverrides[self.operatorcustomization.head])) {
    modeldown = level.nvgheadoverrides[self.operatorcustomization.head]["down"];
  }

  if(!isDefined(modeldown)) {
    modeldown = "offhand_wm_nvgquad_mp_1";
  } else if(modeldown == "nvg_2") {
    modeldown = "offhand_wm_nvgquad_mp_2";
  } else if(modeldown == "nvg_3") {
    modeldown = "offhand_wm_nvgquad_mp_3";
  } else if(modeldown == "nvg_4") {
    modeldown = "offhand_wm_nvgquad_mp_4";
  } else if(modeldown == "none") {
    modeldown = undefined;
  } else {
    assert(0, "<dev string:x12a>");
    modeldown = "offhand_wm_nvgquad_mp_1";
  }

  return modeldown;
}

function function_f88841fc0718438() {
  modelup = undefined;

  if(isDefined(level.nvgheadoverrides) && isDefined(level.nvgheadoverrides[self.operatorcustomization.head])) {
    modelup = level.nvgheadoverrides[self.operatorcustomization.head]["up"];
  }

  if(!isDefined(modelup)) {
    modelup = "offhand_wm_nvgquad_mp_1_up";
  } else if(modelup == "nvg_2") {
    modelup = "offhand_wm_nvgquad_mp_2_up";
  } else if(modelup == "nvg_3") {
    modelup = "offhand_wm_nvgquad_mp_3_up";
  } else if(modelup == "nvg_4") {
    modelup = "offhand_wm_nvgquad_mp_3_up";
  } else if(modelup == "none") {
    modelup = undefined;
  } else {
    assert(0, "<dev string:x175>");
    modelup = "offhand_wm_nvgquad_mp_1_up";
  }

  return modelup;
}

function function_a2668409a49bdef4(animdelay) {
  self endon("perk_nods_off");
  self endon("perk_nods_off_death");

  if(isDefined(animdelay) && animdelay > 0) {
    wait animdelay;
  }

  distancechecks = getdvarint(@ "hash_b439df56cc1fc84c", 1);
  distancethreshold = getdvarint(@ "hash_aaccfa1cd779f68", 3000);
  distancethreshold *= distancethreshold;
  var_5b27571147e34abd = getdvarint(@ "hash_1151abd1f1c19ee3", 1);
  outlineasset = undefined;

  while(true) {
    foreach(player in level.players) {
      if(player == self) {
        continue;
      }

      inrange = 1;

      if(distancechecks) {
        dist = distancesquared(self.origin, player.origin);

        if(dist >= distancethreshold) {
          inrange = 0;
        }
      }

      entnum = player getentitynumber();

      if(!isDefined(self.outlineents)) {
        self.outlineents = [];
      }

      if(isDefined(self.outlineents[entnum]) && inrange) {
        continue;
      } else if(isDefined(self.outlineents[entnum])) {
        outline::outlinedisable(self.outlineents[entnum], player);
        continue;
      }

      if(player.team == self.team) {
        if(var_5b27571147e34abd) {
          outlineasset = "outline_depth_blue";
        }
      } else {
        outlineasset = "outline_depth_orange";
      }

      self.outlineents[entnum] = outline::outlineenableforplayer(player, self, outlineasset, "level_script");
    }

    wait 0.5;
  }
}

function function_c5f054586f38e212(animdelay) {
  if(isDefined(animdelay) && animdelay > 0) {
    wait animdelay;
  }

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }

    entnum = player getentitynumber();

    if(!isDefined(self.outlineents) || !isDefined(self.outlineents[entnum])) {
      continue;
    }

    outline::outlinedisable(self.outlineents[entnum], player);
  }

  self.outlineents = undefined;
}

function function_4d3b1a8f38c4d448(damage, attacker, victim) {
  dmgmod = clamp(getdvarfloat(@ "hash_3bb44b33b3bf5abd", 0.25), 0, 1);
  dmgclamp = clamp(getdvarfloat(@ "hash_36b8e20bff4b3196", 0.8), 0, 1);
  var_46381c94b0138dc7 = int(damage * dmgmod);

  if(attacker != victim) {
    var_46381c94b0138dc7 = int(clamp(var_46381c94b0138dc7, 0, victim.maxhealth * dmgclamp));
  }

  return var_46381c94b0138dc7;
}

function function_3c677364a897306(attacker, victim, objweapon, smeansofdeath, inflictor, hitloc) {
  if(smeansofdeath != "MOD_FIRE") {
    return true;
  }

  if(isDefined(attacker) && attacker == victim && !istrue(victim.var_89feaaadef58c4d4)) {
    return true;
  }

  data = damage_utility::packdamagedata(attacker, victim, undefined, objweapon, smeansofdeath, inflictor);

  if(victim damage_utility::isstuckdamage(data)) {
    return true;
  }

  if(function_bd9883d12fef0b36(objweapon, hitloc)) {
    return true;
  }

  return false;
}

function function_bd9883d12fef0b36(objweapon, hitloc) {
  weaponbasename = objweapon.basename;

  if(weapon::issuperweapon(weaponbasename)) {
    return 1;
  }

  if(weapon::iskillstreakweapon(weaponbasename)) {
    return 1;
  }

  switch (weaponbasename) {
    case #"hash_1ed1da8a2c218aa7":
      return 1;
    default:
      return 0;
  }
}

function settaccom() {
  thread function_2ecdf54199c3435d();
}

function unsettaccom() {
  self notify("unset_perk_taccom");
}

function function_2ecdf54199c3435d() {
  self endon("death_or_disconnect");
  self endon("unset_perk_taccom");
  self.var_3a394cc3ef43fb5e = spawnStruct();
  self.var_3a394cc3ef43fb5e.player = [];
  self.var_3a394cc3ef43fb5e.cooldown = [];
  var_e2073531fa9c0c72 = getdvarint(@ "hash_87ea8b287cb730ea", 1);
  bundle = level.perkbundles["specialty_taccom_system"];

  while(true) {
    if(var_e2073531fa9c0c72 && self playerads() < 1) {
      wait 0.1;
      continue;
    }

    targetedenemy = function_f660aecf9c2aeec6(bundle, targetedenemy);

    if(!isDefined(targetedenemy)) {
      if(isDefined(self.var_c140bf1d7f29d341)) {
        self.var_c140bf1d7f29d341 = undefined;
        self.var_3863644935270551 = undefined;
      }

      wait 0.1;
      continue;
    }

    if(!isDefined(self.var_c140bf1d7f29d341) || self.var_c140bf1d7f29d341 != targetedenemy) {
      self.var_c140bf1d7f29d341 = targetedenemy;
      self.var_d82e94d7c3c73fb = gettime() + bundle.var_d62b2bffaa3a63d3;
      wait 0.1;
    } else if(!isDefined(self.var_d82e94d7c3c73fb)) {
      self.var_d82e94d7c3c73fb = gettime() + bundle.var_d62b2bffaa3a63d3;
    } else if(gettime() >= self.var_d82e94d7c3c73fb) {
      num = targetedenemy getentitynumber();

      if(isDefined(self.var_3a394cc3ef43fb5e.player[num]) && self.var_3a394cc3ef43fb5e.player[num] == targetedenemy) {
        if(isDefined(self.var_3a394cc3ef43fb5e.cooldown[num]) && self.var_3a394cc3ef43fb5e.cooldown[num] > gettime()) {
          wait 0.1;
          continue;
        }
      }

      newpingindex = scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(6, self.var_c140bf1d7f29d341.origin + (0, 0, 50));
      thread scripts\cp_mp\calloutmarkerping::function_9a7200f5142066ba(self, newpingindex, undefined, ["unset_perk_taccom", "disconnect"], bundle.var_84d180cfd1b00a40);
      perks::activateperk("specialty_taccom_system");
      self.var_d82e94d7c3c73fb = undefined;
      self.var_3a394cc3ef43fb5e.player[num] = targetedenemy;
      self.var_3a394cc3ef43fb5e.cooldown[num] = gettime() + bundle.var_3430721118ed09d0;
      targetedenemy = undefined;
      wait bundle.var_4c64062ca9e30f17;
    }

    wait 0.1;
  }
}

function function_f660aecf9c2aeec6(bundle, var_34aba8d62374a55b) {
  selfpos = self getvieworigin();
  var_e61f6cdf1a489f08 = anglesToForward(self getplayerangles());
  targetedenemy = undefined;
  enemydist = undefined;

  foreach(player in level.players) {
    if(self.team == player.team) {
      continue;
    }

    if(!isalive(player)) {
      continue;
    }

    playermodel = player getviewmodel();

    if(!isDefined(playermodel) || !modelhastag(playermodel, "j_spinelower")) {
      continue;
    }

    if(player perk::_hasperk("specialty_thermal_camo")) {
      continue;
    }

    enemypos = player gettagorigin("j_spinelower");

    if(function_acd8e1bf3a604aea(self, enemypos, selfpos, var_e61f6cdf1a489f08, bundle)) {
      dist = distancesquared(selfpos, enemypos);
      maxdist = bundle.var_86d66e96ee4b380b * bundle.var_86d66e96ee4b380b;

      if(dist > maxdist) {
        continue;
      }

      if(isDefined(var_34aba8d62374a55b) && player == var_34aba8d62374a55b) {
        return player;
      }

      if(!isDefined(targetedenemy)) {
        targetedenemy = player;
        enemydist = dist;
        continue;
      }

      if(dist < enemydist) {
        targetedenemy = player;
        enemydist = dist;
      }
    }
  }

  return targetedenemy;
}

function function_acd8e1bf3a604aea(player, enemypos, playerpos, playeraim, bundle) {
  fromplayer = enemypos - playerpos;
  dot = vectordot(fromplayer, playeraim);

  if(dot <= 0) {
    return 0;
  }

  var_a2585110d07faeb8 = length(fromplayer);
  var_a4b3b596dcf9790c = bundle.var_50ea6089f0e95fe1;
  var_a4b3b596dcf9790c += bundle.var_90d691af1d7be5e6 * sqrt(var_a2585110d07faeb8);
  var_b6b1cd24e33b485f = math::degrees_to_radians(var_a4b3b596dcf9790c);
  var_29f5e95c42138166 = 1 - 0.5 * var_b6b1cd24e33b485f * var_b6b1cd24e33b485f;

  if(dot < var_29f5e95c42138166 * var_a2585110d07faeb8) {
    return 0;
  }

  if(function_fe136c3b362a577e(playerpos, enemypos)) {
    return 1;
  }

  return 0;
}

function function_fe136c3b362a577e(playerpos, enemypos) {
  var_68e6f05a4ee24dee = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot", "physicscontents_playernosight"]);
  var_97db5d48f2509e02 = physics_raycast(playerpos, enemypos, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_any", 1);
  return !var_97db5d48f2509e02;
}

function function_cc2cf1db71343d8f() {
  self.var_4aec8a632dc40e2c = &function_5790c8111baf94d3;
}

function function_5ab8f9c4d813c44a() {
  self.var_4aec8a632dc40e2c = undefined;
}

function function_5790c8111baf94d3() {
  scripts\mp\perks\perks::activateperk("specialty_compression_carrier");
}

function function_e906d1c066af953a() {
  self function_9354c4c50c43abc0(1.3);
}

function function_488e69b3f2811165() {
  self function_9354c4c50c43abc0(1);
}

function function_3e285d679cd4ac57() {
  bundle = level.perkbundles["specialty_support_streaker"];

  if(!isDefined(bundle) || !isDefined(bundle.var_673e66d59cd548eb) || isDefined(level.var_39c3f3e4abe0da33)) {
    return;
  }

  var_dc9b09da91621b2c = bundle.var_673e66d59cd548eb;
  level.var_39c3f3e4abe0da33 = [];

  for(i = 0; i < var_dc9b09da91621b2c.size; i++) {
    streakbundle = var_dc9b09da91621b2c[i];
    overridesstruct = spawnStruct();
    overridesstruct.values = [];
    overridesstruct.values["support_streaker"] = streakbundle.cost;
    level.var_39c3f3e4abe0da33[streakbundle.streakname] = overridesstruct;
  }
}

function function_37de052fb8326c6f() {
  if(!isDefined(level.var_39c3f3e4abe0da33)) {
    return;
  }

  if(!isDefined(self.var_f3c2f1677bc581d7) || self.var_f3c2f1677bc581d7.size == 0) {
    self.var_f3c2f1677bc581d7 = level.var_39c3f3e4abe0da33;
  } else {
    foreach(streakname, var_d5efe609fc99681c in level.var_39c3f3e4abe0da33) {
      if(isDefined(self.var_f3c2f1677bc581d7[streakname])) {
        self.var_f3c2f1677bc581d7[streakname].values["support_streaker"] = var_d5efe609fc99681c.values["support_streaker"];
        continue;
      }

      self.var_f3c2f1677bc581d7[streakname] = var_d5efe609fc99681c;
    }
  }

  function_9735e382a48bd594();
}

function function_191ab60d4588d0c8() {
  if(!isDefined(self.var_f3c2f1677bc581d7) || !isDefined(level.var_39c3f3e4abe0da33)) {
    return;
  }

  foreach(streakname, var_d5efe609fc99681c in level.var_39c3f3e4abe0da33) {
    if(self.var_f3c2f1677bc581d7[streakname].values.size > 1) {
      self.var_f3c2f1677bc581d7[streakname].values["support_streaker"] = undefined;
      continue;
    }

    self.var_f3c2f1677bc581d7[streakname] = undefined;
  }

  if(self.var_f3c2f1677bc581d7.size == 0) {
    self.var_f3c2f1677bc581d7 = undefined;
  }

  function_9735e382a48bd594();
}

function function_9735e382a48bd594() {
  killstreaks::updatestreakcosts();
  killstreaks::checkstreakreward(self.streakpoints);
  killstreaks::updatestreakmeterui();
}

function function_a01c9e1d5b2abc3a() {
  level.var_ff7ad25f9727ddc4 = [];
  level.var_58e389cffaea4aec = [];

  while(true) {
    waitframe();
    function_4730863c5f3d4d76();
  }
}

function function_4730863c5f3d4d76() {
  var_4d2c89632f9bac8a = getdvarint(@ "hash_6cf8ef451d7eb086", 500);
  var_e04256cb6e7bec04 = var_4d2c89632f9bac8a * var_4d2c89632f9bac8a;
  var_e58f7f1e0b03e93c = getdvarint(@ "hash_9e837079460d2ffd", 800);
  var_c6a2d67e179c09c6 = getdvarint(@ "hash_db6950720d7faa27", 100);
  equipmentarray = [[level.getactiveequipmentarray]]();

  foreach(player in level.var_ff7ad25f9727ddc4) {
    foreach(equipment in equipmentarray) {
      if(isDefined(player.team) && isDefined(equipment.team) && equipment.team != player.team) {
        thisdistsqr = distancesquared(player.origin, equipment.origin);

        if(thisdistsqr < var_e04256cb6e7bec04) {
          if(!isDefined(equipment.var_50d8a278fa3d1ddd)) {
            objid = objidpoolmanager::requestobjectiveid();

            if(objid != -1) {
              objidpoolmanager::objective_add_objective(objid, "active", equipment.origin, "icon_navbar_signal_jammer", "icon_small");
              objective_setshowoncompass(objid, 1);
              function_9766d0b79eada249(objid, 1);
              objective_setbackground(objid, 1);
              equipment.var_50d8a278fa3d1ddd = objid;
              level.var_58e389cffaea4aec[objid] = equipment;
            }
          }

          objidpoolmanager::objective_playermask_addshowplayer(equipment.var_50d8a278fa3d1ddd, player);
          player thread function_f0acc19bc9f58105(equipment);
          prop = float(thisdistsqr) / float(var_e04256cb6e7bec04);
          var_261285cfc88f8ee0 = math::lerp(var_c6a2d67e179c09c6, var_e58f7f1e0b03e93c, prop);
          player function_3f33157318043ac2(var_261285cfc88f8ee0, equipment);
          continue;
        }

        if(isDefined(equipment.var_50d8a278fa3d1ddd)) {
          objective_removeclientfrommask(equipment.var_50d8a278fa3d1ddd, player);
          player thread function_6cf221eaa466443b(equipment);
        }
      }
    }
  }

  foreach(objid, equipment in level.var_58e389cffaea4aec) {
    if(!utility::array_contains(equipmentarray, equipment)) {
      objidpoolmanager::returnobjectiveid(objid);
      level.var_58e389cffaea4aec[objid] = undefined;
    }
  }
}

function function_8d63cc03c22e972() {
  level endon("game_ended");
  level.var_52ec346520cb321c = [];

  while(true) {
    waitframe();
    function_7cbf935d70716bce();
  }
}

function function_7cbf935d70716bce() {
  tracecontents = trace::create_default_contents(1);
  process = 0;
  var_6d7eba8a96f9541 = 1;

  if(getdvarint(@ "hash_331b1ec774a4d54b", 0)) {
    var_6d7eba8a96f9541 = 0;
  }

  foreach(num, player in level.var_52ec346520cb321c) {
    var_2f3b228d8493de0e = [];
    otherplayerlaser = undefined;
    var_50843d76956e8fd4 = undefined;
    var_7160ff774dc6778d = undefined;
    var_96f404f41dcf0af0 = 0;
    var_2d8cf2fc75fdaece = undefined;

    if(!isDefined(player)) {
      level.var_52ec346520cb321c[num] = undefined;
      continue;
    }

    var_24f9b94a171cca52 = player gettagorigin("j_spinelower");
    var_64a457a19d7daa44 = player getEye();
    playeraim = anglesToForward(player getplayerangles());
    equipmentarray = [[level.getactiveequipmentarray]]();
    playerarray = level.players;
    var_2ce72edced53e34c = level.activekillstreaks;
    activeobjects = undefined;

    if(isDefined(equipmentarray) && isDefined(playerarray)) {
      activeobjects = utility::array_combine_unique(playerarray, equipmentarray);
    } else {
      if(isDefined(equipmentarray)) {
        activeobjects = equipmentarray;
      }

      if(isDefined(playerarray)) {
        activeobjects = playerarray;
      }
    }

    if(isDefined(var_2ce72edced53e34c)) {
      var_1c657e4ea33dcdd6 = [];

      foreach(streak in var_2ce72edced53e34c) {
        switch (streak.streakname) {
          case #"hash_fa4536bde6f7ad9":
          case #"hash_ab5712e297cd430e":
          case #"hash_cf0ef5bef19a311b":
            var_1c657e4ea33dcdd6[var_1c657e4ea33dcdd6.size] = streak;
            break;
        }
      }

      activeobjects = utility::array_combine_unique(activeobjects, var_1c657e4ea33dcdd6);
    }

    if(!isDefined(activeobjects)) {
      continue;
    }

    foreach(targetobj in activeobjects) {
      if(process >= 25) {
        process = 0;
        waitframe();
      }

      if(!isDefined(player)) {
        level.var_52ec346520cb321c[num] = undefined;
        break;
      }

      if(isPlayer(targetobj)) {
        if(!player function_3b9f02152a634ee9(targetobj)) {
          continue;
        }

        process++;

        if(targetobj utility::isusingremote()) {
          var_7160ff774dc6778d = targetobj.origin;
        } else if(isPlayer(targetobj) || isagent(targetobj)) {
          var_7160ff774dc6778d = targetobj getEye();
        } else {
          var_7160ff774dc6778d = targetobj gettagorigin("j_spinelower");
        }

        var_ed6e173aa5e562a5 = anglesToForward(targetobj getplayerangles());
        otherplayerlaser = function_3a930ec69b2ea052(targetobj);
        var_50843d76956e8fd4 = player function_54a4fb429eda8e2(targetobj, var_24f9b94a171cca52);

        if(getdvarint(@ "hash_4a5e53c86be19882", 0) > 0) {
          otherplayerlaser = 1;
        }

        if(getdvarint(@ "hash_72de1d9c7d36f7e2", 0) > 0) {
          var_50843d76956e8fd4 = 1;
        }

        if(!istrue(otherplayerlaser) && !istrue(var_50843d76956e8fd4)) {
          continue;
        }

        if(istrue(var_50843d76956e8fd4)) {
          var_96f404f41dcf0af0 = 1;
          var_2f3b228d8493de0e[var_2f3b228d8493de0e.size] = targetobj;
        } else if(player function_33662f36c6e2421a(targetobj, var_24f9b94a171cca52, var_7160ff774dc6778d, var_ed6e173aa5e562a5)) {
          castcontents = physics_createcontents(["physicscontents_ainosight"]);
          castresults = physics_raycast(var_24f9b94a171cca52, var_7160ff774dc6778d, castcontents, [player, targetobj], 0, "physicsquery_closest");

          if(isDefined(castresults) && castresults.size > 0) {
            continue;
          } else {
            var_96f404f41dcf0af0 = 1;
            var_2f3b228d8493de0e[var_2f3b228d8493de0e.size] = targetobj;
          }
        }
      } else if(isDefined(targetobj)) {
        if(istrue(targetobj.exploding)) {
          continue;
        }

        var_7160ff774dc6778d = targetobj.origin;
        process++;

        if(isDefined(targetobj.streakname)) {
          if(function_6dbc5df69e5134a0(targetobj, player)) {
            var_96f404f41dcf0af0 = 1;
            var_2f3b228d8493de0e[var_2f3b228d8493de0e.size] = targetobj;
          }
        } else if(function_151d6bf67d113b1e(targetobj, player)) {
          var_96f404f41dcf0af0 = 1;
          var_2f3b228d8493de0e[var_2f3b228d8493de0e.size] = targetobj;
        }
      } else {
        continue;
      }

      if(isDefined(targetobj) && !utility::array_contains(player.var_5dcd6d4ac51be6d5, targetobj) && utility::array_contains(var_2f3b228d8493de0e, targetobj)) {
        var_2d8cf2fc75fdaece = 1;
      }
    }

    if(!isDefined(player)) {
      level.var_52ec346520cb321c[num] = undefined;
      continue;
    }

    var_2f3b228d8493de0e = player function_377b7c0c8c274789(var_2f3b228d8493de0e);
    player.var_5dcd6d4ac51be6d5 = var_2f3b228d8493de0e;

    if(var_96f404f41dcf0af0) {
      dot = undefined;
      var_8b9593a2b3f37e08 = getdvarfloat(@ "hash_176909c53ee0395e", 0.985);

      foreach(targetobj in var_2f3b228d8493de0e) {
        if(!isDefined(dot)) {
          dot = function_f8ae6ea503ee187a(playeraim, var_24f9b94a171cca52, targetobj.origin);
          break;
        }

        tempdot = function_f8ae6ea503ee187a(playeraim, var_24f9b94a171cca52, targetobj.origin);

        if(tempdot > dot) {
          dot = tempdot;
        }
      }

      if(dot >= var_8b9593a2b3f37e08) {
        var_6d7eba8a96f9541 = 1;
      }
    }

    player thread function_bc9281d925b86c7e(var_96f404f41dcf0af0, var_6d7eba8a96f9541, var_2d8cf2fc75fdaece);
  }
}

function function_377b7c0c8c274789(var_2f3b228d8493de0e) {
  if(!isDefined(750) || false) {
    return var_2f3b228d8493de0e;
  }

  if(!isDefined(self.var_df81db1ae87349f2)) {
    self.var_df81db1ae87349f2 = [];
  }

  if(!isDefined(var_2f3b228d8493de0e)) {
    var_2f3b228d8493de0e = [];
  }

  foreach(ent in self.var_5dcd6d4ac51be6d5) {
    if(!isDefined(ent)) {
      continue;
    }

    entdetected = utility::array_contains(var_2f3b228d8493de0e, ent);
    var_c34e02f7e11269cf = 0;
    var_7e04d11079ba5e66 = undefined;

    if(self.var_df81db1ae87349f2.size > 0) {
      for(index = 0; index < self.var_df81db1ae87349f2.size; index++) {
        if(self.var_df81db1ae87349f2[index].ent == ent) {
          var_7e04d11079ba5e66 = index;
          var_c34e02f7e11269cf = 1;
          break;
        }
      }
    }

    if(entdetected && var_c34e02f7e11269cf) {
      self.var_df81db1ae87349f2 = utility::array_remove_index(self.var_df81db1ae87349f2, var_7e04d11079ba5e66, 0);
      continue;
    }

    if(!entdetected && !var_c34e02f7e11269cf) {
      newentry = spawnStruct();
      newentry.ent = ent;
      newentry.time = gettime();
      self.var_df81db1ae87349f2[self.var_df81db1ae87349f2.size] = newentry;
    }
  }

  removedelay = getdvarint(@ "hash_1418e2a60694ce70", 750);

  for(index = self.var_df81db1ae87349f2.size - 1; index >= 0; index--) {
    ent = self.var_df81db1ae87349f2[index];

    if(!isDefined(ent)) {
      self.var_df81db1ae87349f2 = utility::array_remove_index(self.var_df81db1ae87349f2, index, 0);
      continue;
    }

    entdetected = utility::array_contains(var_2f3b228d8493de0e, ent.ent);

    if(!entdetected) {
      removetime = ent.time + removedelay;

      if(gettime() < removetime) {
        var_2f3b228d8493de0e[var_2f3b228d8493de0e.size] = ent.ent;
        continue;
      }

      self.var_df81db1ae87349f2 = utility::array_remove_index(self.var_df81db1ae87349f2, index, 0);
    }
  }

  return var_2f3b228d8493de0e;
}

function function_bc9281d925b86c7e(var_96f404f41dcf0af0, var_6d7eba8a96f9541, var_2d8cf2fc75fdaece) {
  if(var_96f404f41dcf0af0) {
    if(istrue(var_2d8cf2fc75fdaece)) {
      thread function_76607a90fc659cd7();
    }

    if(!isDefined(self.var_be2b394965b786ba)) {
      self.var_be2b394965b786ba = gettime();
      function_1d114ca0c1f73008(16);
      function_b287c9114a845cee(var_6d7eba8a96f9541);
    } else {
      currtime = gettime();
      var_58e6805f5b00a307 = undefined;

      switch (var_6d7eba8a96f9541) {
        case 1:
          var_58e6805f5b00a307 = 500;
          break;
      }

      if(isDefined(var_58e6805f5b00a307) && currtime - var_58e6805f5b00a307 >= self.var_be2b394965b786ba) {
        function_1d114ca0c1f73008(16);
        function_b287c9114a845cee(var_6d7eba8a96f9541);
        self.var_be2b394965b786ba = currtime;
      } else if(!istrue(var_2d8cf2fc75fdaece)) {
        function_1d114ca0c1f73008(0);
      }
    }

    return;
  }

  function_1d114ca0c1f73008(0);
}

function function_151d6bf67d113b1e(targetobj, player) {
  var_c7afe0cfc4a23bb9 = targetobj.owner;
  var_f31940d93afc41db = 1;

  if(var_f31940d93afc41db) {
    if(isDefined(var_c7afe0cfc4a23bb9) && !istrue(player_utility::playersareenemies(player, var_c7afe0cfc4a23bb9))) {
      return false;
    }
  }

  if(distancesquared(targetobj.origin, player.origin) > 202500) {
    return false;
  }

  var_6f6a39d243eb6a5 = undefined;

  if(isDefined(targetobj.weapon_name)) {
    var_6f6a39d243eb6a5 = targetobj.weapon_name;
  }

  if(!isDefined(var_6f6a39d243eb6a5) && isDefined(targetobj.weapon_object)) {
    var_6f6a39d243eb6a5 = targetobj.weapon_object.basename;
  }

  if(isDefined(var_6f6a39d243eb6a5)) {
    if(var_6f6a39d243eb6a5 == "claymore_mp" || var_6f6a39d243eb6a5 == "jup_claymore_mp" || var_6f6a39d243eb6a5 == "jup_claymore_cp") {
      if(player function_33662f36c6e2421a(targetobj, player.origin, targetobj.origin, anglesToForward(targetobj.angles), 25)) {
        castcontents = physics_createcontents(["physicscontents_ainosight"]);
        castresults = physics_raycast(player.origin, targetobj.origin, castcontents, [player, targetobj], 0, "physicsquery_closest");

        if(isDefined(castresults) && castresults.size > 0) {
          return false;
        }

        return true;
      }
    }
  }

  return false;
}

function function_6dbc5df69e5134a0(killstreak, player) {
  streakname = killstreak.streakname;

  if(isDefined(streakname)) {
    if(streakname == "remote_turret" || streakname == "pac_sentry" || streakname == "sentry_turret") {
      if(isDefined(killstreak.owner) && !istrue(player_utility::playersareenemies(player, killstreak.owner))) {
        return false;
      }

      if(distancesquared(killstreak.origin, player.origin) > 36000000) {
        return false;
      }

      if(player function_33662f36c6e2421a(killstreak, player.origin, killstreak.origin, anglesToForward(killstreak.angles))) {
        traceloc = killstreak gettagorigin("tag_flash", 1);

        if(!isDefined(traceloc)) {
          traceloc = killstreak.origin + (0, 0, 6);
        }

        castcontents = physics_createcontents(["physicscontents_ainosight"]);
        castresults = physics_raycast(player.origin, traceloc, castcontents, [player, killstreak], 0, "physicsquery_closest");

        if(isDefined(castresults) && castresults.size > 0) {
          return false;
        }

        return true;
      }
    }
  }

  return false;
}

function function_3b9f02152a634ee9(otherplayer) {
  if(!perk::_hasperk("specialty_lr_detector")) {
    return false;
  }

  if(!player_utility::_isalive()) {
    return false;
  }

  if(!isDefined(otherplayer)) {
    return false;
  }

  if(!otherplayer player_utility::_isalive()) {
    return false;
  }

  if(otherplayer.team == self.team) {
    return false;
  }

  if(otherplayer == self) {
    return false;
  }

  if(distancesquared(otherplayer.origin, self.origin) > 36000000) {
    return false;
  }

  vehicle = otherplayer player_utility::getvehicle();

  if(isDefined(vehicle) && isDefined(vehicle.vehiclename)) {
    isdriver = vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(otherplayer);

    if(isdriver) {
      if(vehicle.vehiclename != "light_tank" && vehicle.vehiclename != "apc_russian") {
        return false;
      }
    } else if(vehicle.vehiclename == "apc_russian") {
      return false;
    }
  }

  if(otherplayer utility::isusingremote()) {
    remotename = otherplayer player::getremotename();

    if(remotename == "gunship" || remotename == "radar_drone_recon" || remotename == "chopper_gunner" || remotename == "cruise_predator") {
      return false;
    }
  }

  return true;
}

function function_3a930ec69b2ea052(otherplayer) {
  var_e939d845c078f13a = [];
  equippedweapon = undefined;
  equippedweapon = otherplayer getcurrentweapon();

  if(isDefined(equippedweapon)) {
    var_e939d845c078f13a = getweaponattachments(equippedweapon);
  } else {
    return false;
  }

  if(isDefined(equippedweapon.basename) && issubstr(equippedweapon.basename, "laser")) {
    return true;
  }

  if(isDefined(var_e939d845c078f13a)) {
    foreach(attachment in var_e939d845c078f13a) {
      attachmentdataname = function_d3831c58b9d05ac2(equippedweapon.basename, attachment);

      if(!isDefined(attachmentdataname)) {
        continue;
      }

      attachmentcategory = tolower(getscriptbundlefieldvalue(attachmentdataname, #"category"));

      if(isDefined(attachmentcategory) && attachmentcategory != "") {
        switch (attachmentcategory) {
          case #"hash_c9e63a9bddd371e":
            if(function_ec9cd761df1a3271(equippedweapon.basename, attachment) || issubstr(attachment, "therm") || issubstr(attachment, "range") || issubstr(attachment, "rf") || issubstr(attachment, "las") && !issubstr(attachment, "flashlight")) {
              return true;
            }

            break;
          case #"hash_db653a4972b3c13b":
            if(issubstr(attachment, "las") && !issubstr(attachment, "flashlight")) {
              return true;
            }

            break;
          case #"hash_2bc3eb92ebf513f8":
            if(issubstr(attachment, "las") && !issubstr(attachment, "flashlight")) {
              return true;
            }

            break;
          case #"hash_6fc1c97a058fdcc9":
            if(issubstr(attachment, "las") && !issubstr(attachment, "flashlight")) {
              return true;
            }

            break;
        }
      }
    }
  }

  return false;
}

function function_54a4fb429eda8e2(otherplayer, var_24f9b94a171cca52) {
  if(distancesquared(otherplayer.origin, self.origin) > 562500) {
    return 0;
  }

  if(otherplayer utility::isusingremote()) {
    remotename = otherplayer player::getremotename();

    if(remotename == "assault_drone" || remotename == "sentry_turret" || remotename == "recon_drone" || remotename == "tacCam" || remotename == "remote_turret" || remotename == "pac_sentry") {
      if(getdvarint(@ "hash_1440d4d37f1d5de5") == 1) {
        castcontents = physics_createcontents(["physicscontents_ainosight"]);
        castresults = physics_raycast(var_24f9b94a171cca52, otherplayer.origin, castcontents, [self, otherplayer], 0, "physicsquery_closest");

        if(isDefined(castresults) && castresults.size > 0) {
          return 0;
        }

        return 1;
      } else {
        return 1;
      }
    } else {
      return 0;
    }

    return;
  }

  return 0;
}

function function_33662f36c6e2421a(otherplayer, playerpos, otherplayerpos, var_ed6e173aa5e562a5, var_bbc7488043a90e4b) {
  fromotherplayer = playerpos - otherplayerpos;
  dot = vectordot(fromotherplayer, var_ed6e173aa5e562a5);

  if(dot <= 0) {
    return false;
  }

  var_33e2af87c7b68ce8 = length(fromotherplayer);

  if(isDefined(var_bbc7488043a90e4b)) {
    var_a4b3b596dcf9790c = var_bbc7488043a90e4b;
  } else {
    var_a4b3b596dcf9790c = 12;
  }

  var_a4b3b596dcf9790c += -0.15 * sqrt(var_33e2af87c7b68ce8);
  var_b6b1cd24e33b485f = math::degrees_to_radians(var_a4b3b596dcf9790c);
  var_29f5e95c42138166 = 1 - 0.5 * var_b6b1cd24e33b485f * var_b6b1cd24e33b485f;

  if(dot < var_29f5e95c42138166 * var_33e2af87c7b68ce8) {
    return false;
  }

  return true;
}

function function_f8ae6ea503ee187a(playeraim, playerpos, otherplayerpos) {
  tootherplayer = otherplayerpos - playerpos;
  dot = vectordot(playeraim, vectorNormalize(tootherplayer));
  return dot;
}

function function_1d114ca0c1f73008(vfxvalue) {
  if(vfxvalue == 0) {
    if(istrue(self.var_bc4c5b060cdf149f)) {
      self setscriptablepartstate("lrDetector", "lrDetector_off", 0);
      self.var_bc4c5b060cdf149f = 0;
    }

    return;
  }

  self setclientomnvar("ui_lr_detector", gettime());

  if(!istrue(self.var_bc4c5b060cdf149f)) {
    self setscriptablepartstate("lrDetector", "lrDetector_on", 0);
    self.var_bc4c5b060cdf149f = 1;
  }
}

function function_76607a90fc659cd7() {
  function_1d114ca0c1f73008(16);
  self playsoundtoplayer("prk_lr_detector_first_beep", self);
  wait 0.1;
  function_1d114ca0c1f73008(16);
  self playsoundtoplayer("prk_lr_detector_first_beep", self);
}

function function_b287c9114a845cee(var_6d7eba8a96f9541) {
  if(var_6d7eba8a96f9541 != 0) {
    self playsoundtoplayer("prk_lr_detector_beep", self);
  }
}

function function_3f33157318043ac2(var_3f532f304395a854, fromentity) {
  if(var_3f532f304395a854 > 0 && isDefined(fromentity)) {
    if(!isDefined(self.var_29c495bc5fed0c4c)) {
      self.var_29c495bc5fed0c4c = gettime();
      self playsoundtoplayer("prk_signal_jammer_beep", self, fromentity);
      return;
    }

    currtime = gettime();

    if(currtime - self.var_29c495bc5fed0c4c >= var_3f532f304395a854) {
      self.var_29c495bc5fed0c4c = currtime;
      self playsoundtoplayer("prk_signal_jammer_beep", self, fromentity);
    }
  }
}

function settacmask() {
  bundle = level.perkbundles["specialty_tac_mask"];

  if(!isDefined(bundle) || !isDefined(bundle.var_e9766119e389af1c)) {
    return;
  }

  self.var_a5ccdc92ae9b4392 = [];

  foreach(index, var_e9b0f38faaf7b29b in bundle.var_e9766119e389af1c) {
    switch (var_e9b0f38faaf7b29b.var_b84101f4c3174b88) {
      case #"hash_23f2c68a2fc41281":
        if(isDefined(var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c)) {
          switch (var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c) {
            case #"hash_8b85ac7f081e7060":
              perks::_setperk("specialty_stun_resistance");
              self.var_a5ccdc92ae9b4392[index] = "specialty_stun_resistance";
              break;
            case #"hash_db653a4972b3c13b":
            case #"hash_e3ea33954e1ac9f7":
            default:
              break;
          }
        }

        break;
      case #"hash_ed469a6bfff6b265":
        if(isDefined(var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c)) {
          switch (var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c) {
            case #"hash_8b85ac7f081e7060":
              perks::_setperk("specialty_emp_resist");
              self.var_a5ccdc92ae9b4392[index] = "specialty_emp_resist";
              break;
            case #"hash_e3ea33954e1ac9f7":
              perks::_setperk("specialty_emp_immunity");
              perks::_setperk("specialty_empimmune");
              self.var_a5ccdc92ae9b4392[index] = "specialty_emp_immunity";
              self.var_a5ccdc92ae9b4392[bundle.var_e9766119e389af1c.size] = "specialty_empimmune";
              break;
            case #"hash_db653a4972b3c13b":
            default:
              break;
          }
        }

        break;
      case #"hash_fb36696c0708bf42":
        if(isDefined(var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c)) {
          switch (var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c) {
            case #"hash_8b85ac7f081e7060":
              perks::_setperk("specialty_gas_grenade_resist");
              self.var_a5ccdc92ae9b4392[index] = "specialty_gas_grenade_resist";
              break;
            case #"hash_e3ea33954e1ac9f7":
              perks::_setperk("specialty_gas_immunity");
              self.var_a5ccdc92ae9b4392[index] = "specialty_gas_immunity";
            case #"hash_db653a4972b3c13b":
            default:
              break;
          }
        }

        break;
      case #"hash_ce04129c57195506":
        if(isDefined(var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c)) {
          switch (var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c) {
            case #"hash_e3ea33954e1ac9f7":
              perks::_setperk("specialty_hallucination_immunity");
              self.var_a5ccdc92ae9b4392[index] = "specialty_hallucination_immunity";
              break;
            case #"hash_8b85ac7f081e7060":
            case #"hash_db653a4972b3c13b":
            default:
              break;
          }
        }

        break;
      case #"hash_1f1d7b3efcb82111":
        if(isDefined(var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c)) {
          switch (var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c) {
            case #"hash_e3ea33954e1ac9f7":
              perks::_setperk("specialty_shock_immunity");
              self.var_a5ccdc92ae9b4392[index] = "specialty_shock_immunity";
              break;
            case #"hash_8b85ac7f081e7060":
            case #"hash_db653a4972b3c13b":
            default:
              break;
          }
        }

        break;
      case #"hash_ed1356899cfee3ed":
        if(isDefined(var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c)) {
          switch (var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c) {
            case #"hash_e3ea33954e1ac9f7":
              perks::_setperk("specialty_snapshot_immunity");
              self.var_a5ccdc92ae9b4392[index] = "specialty_snapshot_immunity";
              break;
            case #"hash_8b85ac7f081e7060":
            case #"hash_db653a4972b3c13b":
            default:
              break;
          }
        }

        break;
      case #"hash_1b98d081f90934b8":
        if(isDefined(var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c)) {
          switch (var_e9b0f38faaf7b29b.var_c1ab5588db5fa28c) {
            case #"hash_8b85ac7f081e7060":
              perks::_setperk("specialty_gas_warlord_resist");
              self.var_a5ccdc92ae9b4392[index] = "specialty_gas_warlord_resist";
              break;
            case #"hash_db653a4972b3c13b":
            case #"hash_e3ea33954e1ac9f7":
            default:
              break;
          }
        }

        break;
      default:
        break;
    }
  }
}

function unsettacmask() {
  if(!isDefined(self.var_a5ccdc92ae9b4392)) {
    return;
  }

  foreach(var_f98915c242e60c19 in self.var_a5ccdc92ae9b4392) {
    if(perk::_hasperk(var_f98915c242e60c19)) {
      perks::_unsetperk(var_f98915c242e60c19);
    }
  }

  self.var_a5ccdc92ae9b4392 = undefined;
}

function function_9ab9afce9ddf23d3() {
  submix = "jup_mp_bone_conduction";
  var_fdd4cb56c3b978a3 = scripts\cp_mp\utility\game_utility::isbrstylegametype();

  if(istrue(var_fdd4cb56c3b978a3)) {
    submix = "wz_mp_bone_conduction";
  }

  self setsoundsubmix(submix, 0.2);
}

function function_f4981401b60aff4e() {
  submix = "jup_mp_bone_conduction";
  var_fdd4cb56c3b978a3 = scripts\cp_mp\utility\game_utility::isbrstylegametype();

  if(istrue(var_fdd4cb56c3b978a3)) {
    submix = "wz_mp_bone_conduction";
  }

  self clearsoundsubmix(submix, 0.2);
}

function function_e77e0f080cbde77a() {
  if(!isDefined(level.perkbundles)) {
    return;
  }

  var_ce97d61299ae4f64 = level.perkbundles["specialty_gearhead"];

  if(!isstruct(var_ce97d61299ae4f64)) {
    return;
  }

  perk_faster_field_upgrade_rate = var_ce97d61299ae4f64.perk_faster_field_upgrade_rate;

  if(isnumber(perk_faster_field_upgrade_rate)) {
    if(!isDefined(self.perktunables)) {
      self.perktunables = spawnStruct();
    }

    self.perktunables.perk_faster_field_upgrade_rate = perk_faster_field_upgrade_rate;
  }
}

function function_91c59fd71ce44c87() {
  if(!isDefined(self.perktunables)) {
    return;
  }

  if(isDefined(self.perktunables.perk_faster_field_upgrade_rate)) {
    self.perktunables.perk_faster_field_upgrade_rate = undefined;
  }
}

function setoutlander() {
  if(!isDefined(self.var_c2c2848ce2585f29)) {
    self.var_c2c2848ce2585f29 = 0;
  }

  self.var_29c2f60059bfa3aa = 1;
  self.var_c2c2848ce2585f29 += getdvarfloat(@ "hash_50dc5065112199d7", -0.2);

  if(!getdvarint(@ "hash_e57295eeedbf41eb", 0)) {
    thread function_b58456eeca76b311();
  }

  function_2a32431b16c54b0d();
}

function unsetoutlander() {
  self.var_29c2f60059bfa3aa = 0;
  self.var_c2c2848ce2585f29 -= getdvarfloat(@ "hash_50dc5065112199d7", -0.2);
  self notify("outlander_unset");
  function_2a32431b16c54b0d();
}

function function_2a32431b16c54b0d() {
  if(!istrue(self.var_9ee4330fe38ffc6) && istrue(self.var_29c2f60059bfa3aa) && istrue(self.isincircle)) {
    if(!isDefined(self.outlanderspeedmod) || self.outlanderspeedmod != getdvarfloat(@ "hash_f12f9c3e925d6a69", 0.1)) {
      self.outlanderspeedmod = getdvarfloat(@ "hash_f12f9c3e925d6a69", 0.1);
      scripts\mp\weapons::updatemovespeedscale();
      function_332887b37621cafe("outlander");
    }

    return;
  }

  if(isDefined(self.outlanderspeedmod) && self.outlanderspeedmod != 0) {
    self.outlanderspeedmod = 0;
    scripts\mp\weapons::updatemovespeedscale();
    function_dc6425bc8ea85ac0("outlander");
  }
}

function function_b58456eeca76b311() {
  self endon("death_or_disconnect");
  self endon("outlander_unset");
  level endon("game_ended");

  while(true) {
    waittill_any_2("powerup_apply_zombie_legs", "powerup_remove_zombie_legs");
    function_2a32431b16c54b0d();
  }
}

function function_198adc5136f6a4b3() {
  self.var_4d52ef6a17e52924 = getdvarfloat(@ "hash_28d9e384824bc463", 0.2);
}

function function_a4142d5fdfc879b4() {
  self.var_4d52ef6a17e52924 = undefined;
}

function function_7c927ee710825162() {
  self.var_86d77db605c0c948 = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

function function_33f65bc5db503a11() {
  self.var_86d77db605c0c948 = undefined;
  scripts\mp\weapons::updatemovespeedscale();
}

function function_b128334187ed23fb() {
  self.var_2da660fa32b4cd1 = getdvarfloat(@ "hash_d2139809963cc0c8", 0.8);
}

function function_26088d91835eae50() {
  self.var_2da660fa32b4cd1 = undefined;
}

function function_763531f5f7839ab6() {
  self.var_a7004ed1f5ca8132 = getdvarfloat(@ "hash_c825c43c66abd9c7", 0.8);
}

function function_d5d1e40fc4911309() {
  self.var_a7004ed1f5ca8132 = undefined;
}

function function_91d30d6bd5c9987e() {
  self.var_dc3b97ba2322ca5a = getdvarfloat(@ "hash_80d20097a357fa4b", 0.8);
}

function function_67f057d98cc8b147() {
  self.var_dc3b97ba2322ca5a = undefined;
}

function function_416b659a8c183f5() {
  self.var_ce58e8eff85f7366 = 0;
  self.var_381cb6b216dfa1a5 = 1;
  thread function_a107792339aa634a();
}

function function_61f59f06b860e9de() {
  self.var_381cb6b216dfa1a5 = undefined;
}

function function_a107792339aa634a() {
  level endon("game_ended");
  self endon("disconnect");
  speedbuffduration = getdvarint(@ "hash_526707faa275db17", 3000);
  var_a3bec96e7cc640f3 = getdvarfloat(@ "hash_f01c092cfcf11d56", 0.05);
  var_910c617d84c5e97c = getdvarint(@ "hash_13b7c83a06a9ea71", 3000);

  if(!isDefined(self.var_7698968039f1d786)) {
    self.var_7698968039f1d786 = [];
  }

  while(istrue(self.var_381cb6b216dfa1a5)) {
    speedmod = 0;
    timestamp = gettime();

    if(!istrue(self.var_9ee4330fe38ffc6) && isDefined(self.lastshottime) && isreallyalive(self) && self.lastshottime + speedbuffduration >= timestamp) {
      speedmod = var_a3bec96e7cc640f3;
    }

    if(speedmod != self.var_ce58e8eff85f7366) {
      self.var_ce58e8eff85f7366 = speedmod;

      if(isreallyalive(self)) {
        scripts\mp\weapons::updatemovespeedscale();
      }

      if(speedmod > 0) {
        function_332887b37621cafe("lightweight");
      } else {
        function_dc6425bc8ea85ac0("lightweight");
        self.var_7698968039f1d786 = [];
      }
    }

    if(self.var_7698968039f1d786.size > 0) {
      foreach(guid, ts in self.var_7698968039f1d786) {
        if(isDefined(ts) && timestamp >= ts + var_910c617d84c5e97c) {
          self.var_7698968039f1d786[guid] = undefined;
        }
      }
    }

    waitframe();
  }

  self.var_7698968039f1d786 = undefined;

  if(isDefined(self.var_ce58e8eff85f7366)) {
    self.var_ce58e8eff85f7366 = undefined;
    function_dc6425bc8ea85ac0("lightweight");

    if(isreallyalive(self)) {
      scripts\mp\weapons::updatemovespeedscale();
    }
  }

  self.lastshottime = undefined;
}

function function_332887b37621cafe(source) {
  level endon("game_ended");
  self endon("disconnect");
  assertex(isDefined(source), "<dev string:x1be>");

  if(!isDefined(self.var_54812cfe36016249)) {
    self.var_54812cfe36016249 = [];
  }

  if(!array_contains(self.var_54812cfe36016249, source)) {
    self.var_54812cfe36016249[self.var_54812cfe36016249.size] = source;
  }

  if(!istrue(self.var_9fc96f05758bf981)) {
    self.var_9fc96f05758bf981 = 1;
    self lerpfovbypreset("zombiedefault");
    self setclientomnvar("ui_speedboost_overlay", 0);
  }

  waitframe();
}

function function_dc6425bc8ea85ac0(source) {
  level endon("game_ended");
  self endon("disconnect");
  assertex(isDefined(source), "<dev string:x1ef>");

  if(!isDefined(self.var_54812cfe36016249) || self.var_54812cfe36016249.size <= 0) {
    return;
  }

  sources = self.var_54812cfe36016249;

  if(array_contains(sources, source)) {
    self.var_54812cfe36016249 = array_remove(sources, source);
  }

  if(self.var_54812cfe36016249.size <= 0) {
    if(istrue(self.var_9fc96f05758bf981)) {
      self.var_9fc96f05758bf981 = undefined;
      childthread function_2348d57e12fccb7c();
      self lerpfovbypreset("default_2seconds");
    }

    self.var_54812cfe36016249 = undefined;
  }

  waitframe();
}

function function_bd90db337f1ae0d4(victim, attacker) {
  return istrue(victim.var_381cb6b216dfa1a5) && isDefined(attacker) && isDefined(attacker.guid) && (!isDefined(victim.var_7698968039f1d786) || !array_contains_key(victim.var_7698968039f1d786, attacker.guid));
}

function function_675990374e11b0f7(victim, attacker) {
  if(istrue(victim.var_381cb6b216dfa1a5)) {
    if(!isDefined(victim.var_7698968039f1d786)) {
      victim.var_7698968039f1d786 = [];
    }

    victim.var_7698968039f1d786[attacker.guid] = gettime();
  }
}

function private function_2348d57e12fccb7c() {
  self setclientomnvar("ui_speedboost_overlay", 2);
  wait 1;
  self setclientomnvar("ui_speedboost_overlay", -1);
}

function setblastshield() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self.var_567daf189be4de79 = getdvarint(@ "hash_23a1060a2b94c0ad", 1);
  }
}

function unsetblastshield() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self.var_567daf189be4de79 = undefined;
  }
}

function function_2cfe8d3390ebf739() {
  scripts\cp_mp\uav_tower::function_5ee813ae390b4ce5("discount_perk", getdvarfloat(@ "hash_cf717cd86623a83e", 0.5));
}

function function_2aa14f9e313a7ba0() {
  scripts\cp_mp\uav_tower::function_ade912f6ea99fe68("discount_perk");
}

function function_30aea63c9309d877() {
  function_dfd6f3f52d42539e();
}

function function_9fc353061d5d9106() {
  function_dfd6f3f52d42539e();
}

function function_dfd6f3f52d42539e() {
  if(istrue(getdvarint(@ "hash_a50815ce2cfbefbc", 0))) {
    squad = getteamarray(self.team);

    if(isDefined(squad)) {
      foreach(player in squad) {
        player function_2188834b8d5fe9e(scripts\mp\gametypes\br_quest_util::function_fd4c76c90a1a0333(player));
      }
    }

    return;
  }

  function_2188834b8d5fe9e(scripts\mp\gametypes\br_quest_util::function_fd4c76c90a1a0333(self));
}

function function_2188834b8d5fe9e(mod) {
  self setclientomnvar("ui_br_contract_plunder_mod", mod);
}

function function_63e67108575e2dd7() {
  self.var_11554e20eb10a6dd = 1;
}

function function_e750c905a0033fc0() {
  self.var_11554e20eb10a6dd = undefined;
}

function function_a0bbf85d80bdaabe() {
  self.var_a3376181eed3ffac = getdvarfloat(@ "hash_dcefbf9575257226", 3);
}

function function_78abdd07d9b93295() {
  self.var_a3376181eed3ffac = undefined;
}

function function_dd4a053345e159c2(victim) {
  victim notify("explosiveSlow");
  victim endon("explosiveSlow");
  victim endon("disconnect");
  level endon("game_ended");

  if(!isDefined(victim.var_db8213973d2bb844)) {
    victim.var_db8213973d2bb844 = getdvarfloat(@ "hash_c4d8d43799f0121a", -0.2);
    victim weapons::updatemovespeedscale();
  }

  timer = getdvarfloat(@ "hash_829c5a80bc42ed8a", 3);

  if(victim _hasperk("specialty_frangible_resist")) {
    timer *= 1 + getdvarfloat(@ "hash_47984606bec7ddf7", -0.5);
  }

  currtime = gettime();

  if(!isDefined(victim.disabledshocktime) || currtime - victim.disabledshocktime > 800) {
    duration = 0.8;
    victim shellshock("chargemode_mp", duration);
    victim.disabledshocktime = currtime;
  }

  while(isalive(victim) && timer > 0) {
    timer -= level.framedurationseconds;
    waitframe();
  }

  victim.var_db8213973d2bb844 = undefined;
  victim.disabledshocktime = undefined;
  victim weapons::updatemovespeedscale();
}

function setscavenger() {
  if(isDefined(level.var_331f0fbe61a03f2b)) {
    self[[level.var_331f0fbe61a03f2b]]();
  }
}

function unsetscavenger() {
  if(isDefined(level.var_36ed758616fc9e8d)) {
    self[[level.var_36ed758616fc9e8d]]();
  }
}

function function_3922f41cdbeb95b9() {
  self.var_93d588c5ef8b2dec = getdvarfloat(@ "hash_9c6401e541da3ee", 4);
}

function function_de875074da5476ca() {
  self.healthregendelayoverride = undefined;
}

function function_a8f9bfbe4bdf794() {
  self.var_c6ae3b455bfb5ac6 = getdvarfloat(@ "hash_2f47a9b7c7ebab97", 0.8);
}

function function_5ad4b969c3cf8f77() {
  self.var_c6ae3b455bfb5ac6 = undefined;
}

function function_5ba973385ec4be3() {
  self.var_c101ccd3d5f8bd81 = getdvarfloat(@ "hash_62f5a23e338fbc5c", 3.5);
}

function function_1021beef855460ac() {
  self.var_c101ccd3d5f8bd81 = undefined;
}

function function_3a2773d17b85afb2() {
  self.var_1f8a2a7d3f537 = getdvarfloat(@ "hash_d273a042e1a2ba0d", 0.75);
}

function function_90ff5254f7e28f7() {
  self.var_1f8a2a7d3f537 = undefined;
}

function function_1665d49ac1a4f08e(mindistoverride, maxdistoverride) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("last_stand_finished");
  mindist = mindistoverride;
  maxdist = maxdistoverride;

  if(!isDefined(mindist)) {
    mindist = getdvarfloat(@ "hash_24af95923d90f4fd", 0);
  }

  if(!isDefined(maxdist)) {
    maxdist = getdvarfloat(@ "hash_cb9da631139b0a77", 24);
  }

  for(landed = self isonground() || self isswimming(); !landed; landed = self isonground() || self isswimming()) {
    waitframe();
  }

  droporigin = self.origin + (0, 0, 5);

  if(mindist != maxdist) {
    originoffsetdist = randomfloatrange(mindist, maxdist);
  } else {
    originoffsetdist = maxdist;
  }

  velocity = (0, 0, 0);

  if(originoffsetdist != 0) {
    originoffsetdir = anglesToForward((0, randomfloat(359), 0));
    targetposition = droporigin + originoffsetdir * originoffsetdist;
    gravity = (0, 0, getdvarint(@ "bg_gravity") * -1);
    velocity = trajectorycalculateinitialvelocity(droporigin, targetposition, gravity, 0.5);
  }

  grenade = self launchgrenade("jup_smoke_grenade_mp", droporigin, velocity, 0.5);

  if(istrue(getdvarint(@ "hash_21a13d02148f35f5", 0))) {
    grenade waittill("<dev string:x221>", position);
    thread draw_line_for_time(droporigin, position, 1, 0, 0, 10);
    frameduration = int(10000 / level.frameduration + 0.5);
    print3d(position + (0, 0, 20), string(distance2d(droporigin, position)) + "<dev string:x22c>", (1, 0, 0), 1, 1, frameduration, 1);
  }
}

function function_2b0cefc5ad5021df() {
  self.var_1ea761e3a3d0b5f7 = 0;

  if(!isDefined(level.var_5b4603b61b5a134f)) {
    bundle = level.perkbundles["specialty_assist_streak"];

    if(isDefined(bundle) && isDefined(bundle.var_87f7b2c4fb91ea3b)) {
      level.var_5b4603b61b5a134f = [];

      foreach(var_6357989f21bcdefa in bundle.var_87f7b2c4fb91ea3b) {
        level.var_5b4603b61b5a134f = array_add(level.var_5b4603b61b5a134f, var_6357989f21bcdefa.name);
      }
    } else {
      level.var_5b4603b61b5a134f = [#"assist", #"assist_ffa"];
    }
  }

  thread function_442f053b6dc8c9f7();
}

function function_442f053b6dc8c9f7() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("assistStreakUnset");

  while(true) {
    self waittill("death");
    self.var_1ea761e3a3d0b5f7 = 0;
    self setclientomnvar("ui_score_streak_assist_progress", 0);
  }
}

function function_fb5a950aee49424() {
  self.var_1ea761e3a3d0b5f7 = undefined;
  self notify("assistStreakUnset");
}

function function_388eaeb897276caa(event, objweapon) {
  if(!isDefined(self.var_1ea761e3a3d0b5f7)) {
    return;
  }

  iskillstreakweapon = isDefined(objweapon) && scripts\cp_mp\weapon::iskillstreakweapon(objweapon);
  var_4057c6ccc0529d32 = scripts\mp\utility\killstreak::isjuggernaut() && !isjuggermoshgamemode();

  if(iskillstreakweapon || var_4057c6ccc0529d32) {
    return;
  }

  var_d227741417890117 = array_contains(level.var_5b4603b61b5a134f, event);

  if(var_d227741417890117) {
    bundle = level.perkbundles["specialty_assist_streak"];
    var_f195a48a16060c19 = getdvarint(@ "hash_bb386158253597e8", isDefined(bundle) && isDefined(bundle.var_39dfbb886f32f9b2) ? bundle.var_39dfbb886f32f9b2 : 2);
    self.var_1ea761e3a3d0b5f7++;

    if(self.var_1ea761e3a3d0b5f7 == var_f195a48a16060c19) {
      var_50a82b35a3e043a = isDefined(bundle) && isDefined(bundle.var_34f87fda4c079053) ? bundle.var_34f87fda4c079053 : 1;
      var_5178f6ac63d4e466 = isDefined(bundle) && isDefined(bundle.var_29f388e74fd2a0a1) ? bundle.var_29f388e74fd2a0a1 : 125;
      scripts\mp\killstreaks\killstreaks::givestreakpoints(#"hash_27f3af586ae69f94", var_50a82b35a3e043a, var_5178f6ac63d4e466);
      perks::activateperk("specialty_assist_streak");
      self.var_1ea761e3a3d0b5f7 = 0;
      self setclientomnvar("ui_score_streak_assist_progress", 0);
      return;
    }

    if(self.var_1ea761e3a3d0b5f7 == var_f195a48a16060c19 - 1) {
      self setclientomnvar("ui_score_streak_assist_progress", 1);
    }
  }
}

function setmutationmodeperk01() {
  callsharedfunc("game", "setMutationModePerk01");
}

function setmutationmodeperk02() {
  callsharedfunc("game", "setMutationModePerk02");
}

function setmutationmodeperk03() {
  callsharedfunc("game", "setMutationModePerk03");
}

function setmutationmodeperk04() {
  callsharedfunc("game", "setMutationModePerk04");
}

function setmutationmodeperk05() {
  callsharedfunc("game", "setMutationModePerk05");
}

function unsetmutationmodeperk01() {
  callsharedfunc("game", "unsetMutationModePerk01");
}

function unsetmutationmodeperk02() {
  callsharedfunc("game", "unsetMutationModePerk02");
}

function unsetmutationmodeperk03() {
  callsharedfunc("game", "unsetMutationModePerk03");
}

function unsetmutationmodeperk04() {
  callsharedfunc("game", "unsetMutationModePerk04");
}

function unsetmutationmodeperk05() {
  callsharedfunc("game", "unsetMutationModePerk05");
}