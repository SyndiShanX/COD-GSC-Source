/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\gametypes\_weapons.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\bb_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons_shared;
#using scripts\zm\_bb;
#using scripts\zm\_challenges;
#using scripts\zm\_sticky_grenade;
#using scripts\zm\_util;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\gametypes\_globallogic_utils;
#using scripts\zm\gametypes\_shellshock;
#using scripts\zm\gametypes\_weapon_utils;
#using scripts\zm\gametypes\_weaponobjects;
#namespace weapons;

function init() {
  level.missileentities = [];
  level.hackertooltargets = [];
  if(!isDefined(level.grenadelauncherdudtime)) {
    level.grenadelauncherdudtime = 0;
  }
  if(!isDefined(level.throwngrenadedudtime)) {
    level.throwngrenadedudtime = 0;
  }
  level thread onplayerconnect();
  if(level._uses_sticky_grenades) {
    _sticky_grenade::init();
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connecting", player);
    player.usedweapons = 0;
    player.lastfiretime = 0;
    player.hits = 0;
    player scavenger_hud_create();
    player thread onplayerspawned();
  }
}

function onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self.concussionendtime = 0;
    self.hasdonecombat = 0;
    self.shielddamageblocked = 0;
    self thread watchweaponusage();
    self thread watchgrenadeusage();
    self thread watchmissileusage();
    self thread watchweaponchange();
    self thread watchriotshielduse();
    self thread trackweapon();
    self.droppeddeathweapon = undefined;
    self.tookweaponfrom = [];
    self.pickedupweaponkills = [];
    self thread updatestowedweapon();
  }
}

function watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self.lastdroppableweapon = self getcurrentweapon();
  while(true) {
    previous_weapon = self getcurrentweapon();
    self waittill("weapon_change", newweapon);
    if(maydropweapon(newweapon)) {
      self.lastdroppableweapon = newweapon;
    }
  }
}

function watchriotshielduse() {}

function updatelastheldweapontimings(newtime) {
  if(isDefined(self.currentweapon) && isDefined(self.currentweaponstarttime)) {
    totaltime = int((newtime - self.currentweaponstarttime) / 1000);
    if(totaltime > 0) {
      self addweaponstat(self.currentweapon, "timeUsed", totaltime);
      self.currentweaponstarttime = newtime;
    }
  }
}

function updateweapontimings(newtime) {
  if(self util::is_bot()) {
    return;
  }
  updatelastheldweapontimings(newtime);
  if(!isDefined(self.staticweaponsstarttime)) {
    return;
  }
  totaltime = int((newtime - self.staticweaponsstarttime) / 1000);
  if(totaltime < 0) {
    return;
  }
  self.staticweaponsstarttime = newtime;
  if(isDefined(self.weapon_array_grenade)) {
    for(i = 0; i < self.weapon_array_grenade.size; i++) {
      self addweaponstat(self.weapon_array_grenade[i], "timeUsed", totaltime);
    }
  }
  if(isDefined(self.weapon_array_inventory)) {
    for(i = 0; i < self.weapon_array_inventory.size; i++) {
      self addweaponstat(self.weapon_array_inventory[i], "timeUsed", totaltime);
    }
  }
  if(isDefined(self.killstreak)) {
    for(i = 0; i < self.killstreak.size; i++) {
      killstreakweapon = level.menureferenceforkillstreak[self.killstreak[i]];
      if(isDefined(killstreakweapon)) {
        self addweaponstat(killstreakweapon, "timeUsed", totaltime);
      }
    }
  }
  if(level.rankedmatch && level.perksenabled) {
    perksindexarray = [];
    specialtys = self.specialty;
    if(!isDefined(specialtys)) {
      return;
    }
    if(!isDefined(self.curclass)) {
      return;
    }
    if(isDefined(self.class_num)) {
      for(numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
        perk = self getloadoutitem(self.class_num, "specialty" + (numspecialties + 1));
        if(perk != 0) {
          perksindexarray[perk] = 1;
        }
      }
      perkindexarraykeys = getarraykeys(perksindexarray);
      for(i = 0; i < perkindexarraykeys.size; i++) {
        if(perksindexarray[perkindexarraykeys[i]] == 1) {
          self adddstat("itemStats", perkindexarraykeys[i], "stats", "timeUsed", "statValue", totaltime);
        }
      }
    }
  }
}

function trackweapon() {
  currentweapon = self getcurrentweapon();
  currenttime = gettime();
  spawnid = getplayerspawnid(self);
  while(true) {
    event = self util::waittill_any_return("weapon_change", "death", "disconnect");
    newtime = gettime();
    if(event == "weapon_change") {
      self bb::commit_weapon_data(spawnid, currentweapon, currenttime);
      newweapon = self getcurrentweapon();
      if(newweapon != level.weaponnone && newweapon != currentweapon) {
        updatelastheldweapontimings(newtime);
        currentweapon = newweapon;
        currenttime = newtime;
      }
    } else {
      if(event != "disconnect") {
        self bb::commit_weapon_data(spawnid, currentweapon, currenttime);
        updateweapontimings(newtime);
      }
      return;
    }
  }
}

function maydropweapon(weapon) {
  if(level.disableweapondrop == 1) {
    return false;
  }
  if(weapon == level.weaponnone) {
    return false;
  }
  if(!weapon.isprimary) {
    return false;
  }
  return true;
}

function dropweaponfordeath(attacker) {
  if(level.disableweapondrop == 1) {
    return;
  }
  weapon = self.lastdroppableweapon;
  if(isDefined(self.droppeddeathweapon)) {
    return;
  }
  if(!isDefined(weapon)) {
    if(getdvarstring("") == "") {
      println("");
    }
    return;
  }
  if(weapon == level.weaponnone) {
    if(getdvarstring("") == "") {
      println("");
    }
    return;
  }
  if(!self hasweapon(weapon)) {
    if(getdvarstring("") == "") {
      println(("" + weapon.name) + "");
    }
    return;
  }
  if(!self anyammoforweaponmodes(weapon)) {
    if(getdvarstring("") == "") {
      println("");
    }
    return;
  }
  if(!shoulddroplimitedweapon(weapon, self)) {
    return;
  }
  clipammo = self getweaponammoclip(weapon);
  stockammo = self getweaponammostock(weapon);
  clip_and_stock_ammo = clipammo + stockammo;
  if(!clip_and_stock_ammo) {
    if(getdvarstring("") == "") {
      println("");
    }
    return;
  }
  stockmax = weapon.maxammo;
  if(stockammo > stockmax) {
    stockammo = stockmax;
  }
  item = self dropitem(weapon);
  if(!isDefined(item)) {
    iprintlnbold("" + weapon.name);
    return;
  }
  if(getdvarstring("") == "") {
    println("" + weapon.name);
  }
  droplimitedweapon(weapon, self, item);
  self.droppeddeathweapon = 1;
  item itemweaponsetammo(clipammo, stockammo);
  item.owner = self;
  item.ownersattacker = attacker;
  item thread watchpickup();
  item thread deletepickupafterawhile();
}

function deletepickupafterawhile() {
  self endon("death");
  wait(60);
  if(!isDefined(self)) {
    return;
  }
  self delete();
}

function watchpickup() {
  self endon("death");
  weapon = self.item;
  while(true) {
    self waittill("trigger", player, droppeditem);
    if(isDefined(droppeditem)) {
      break;
    }
  }
  if(getdvarstring("") == "") {
    println((("" + weapon.name) + "") + isDefined(self.ownersattacker));
  }
  assert(isDefined(player.tookweaponfrom));
  assert(isDefined(player.pickedupweaponkills));
  if(isDefined(droppeditem)) {
    for(i = 0; i < droppeditem.size; i++) {
      if(!isDefined(droppeditem[i])) {
        continue;
      }
      droppedweapon = droppeditem[i].item;
      if(isDefined(player.tookweaponfrom[droppedweapon])) {
        droppeditem[i].owner = player.tookweaponfrom[droppedweapon];
        droppeditem[i].ownersattacker = player;
        player.tookweaponfrom[droppedweapon] = undefined;
      }
      droppeditem[i] thread watchpickup();
    }
  }
  if(isDefined(self.ownersattacker) && self.ownersattacker == player) {
    player.tookweaponfrom[weapon] = self.owner;
    player.pickedupweaponkills[weapon] = 0;
  } else {
    player.tookweaponfrom[weapon] = undefined;
    player.pickedupweaponkills[weapon] = undefined;
  }
}

function watchweaponusage() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self.usedkillstreakweapon = [];
  self.usedkillstreakweapon["minigun"] = 0;
  self.usedkillstreakweapon["m32"] = 0;
  self.usedkillstreakweapon["m202_flash"] = 0;
  self.usedkillstreakweapon["m220_tow"] = 0;
  self.usedkillstreakweapon["mp40_blinged"] = 0;
  self.killstreaktype = [];
  self.killstreaktype["minigun"] = "minigun";
  self.killstreaktype["m32"] = "m32";
  self.killstreaktype["m202_flash"] = "m202_flash";
  self.killstreaktype["m220_tow"] = "m220_tow";
  self.killstreaktype["mp40_blinged"] = "mp40_blinged_drop";
  for(;;) {
    self waittill("weapon_fired", curweapon);
    self.lastfiretime = gettime();
    self.hasdonecombat = 1;
    switch (curweapon.weapclass) {
      case "mg":
      case "pistol":
      case "rifle":
      case "smg":
      case "spread": {
        self trackweaponfire(curweapon);
        level.globalshotsfired++;
        break;
      }
      case "grenade":
      case "rocketlauncher": {
        self addweaponstat(curweapon, "shots", 1);
        break;
      }
      default: {
        break;
      }
    }
  }
}

function trackweaponfire(curweapon) {
  shotsfired = 1;
  if(isDefined(self.laststandparams) && self.laststandparams.laststandstarttime == gettime()) {
    self.hits = 0;
    return;
  }
  pixbeginevent("trackWeaponFire");
  misses = int(max(0, shotsfired - self.hits));
  self addweaponstat(curweapon, "shots", shotsfired);
  self addweaponstat(curweapon, "hits", self.hits);
  self addweaponstat(curweapon, "misses", misses);
  if(isDefined(level.add_client_stat)) {
    self[[level.add_client_stat]]("total_shots", shotsfired);
    self[[level.add_client_stat]]("hits", self.hits);
    self[[level.add_client_stat]]("misses", misses);
  } else {
    self addplayerstat("total_shots", shotsfired);
    self addplayerstat("hits", self.hits);
    self addplayerstat("misses", misses);
  }
  self incrementplayerstat("total_shots", shotsfired);
  self incrementplayerstat("hits", self.hits);
  self incrementplayerstat("misses", misses);
  self bb::add_to_stat("shots", shotsfired);
  self bb::add_to_stat("hits", self.hits);
  self bb::add_to_stat("misses", misses);
  self.hits = 0;
  pixendevent();
}

function watchgrenadeusage() {
  self endon("death");
  self endon("disconnect");
  self.throwinggrenade = 0;
  self.gotpullbacknotify = 0;
  self thread beginothergrenadetracking();
  self thread watchforthrowbacks();
  self thread watchforgrenadeduds();
  self thread watchforgrenadelauncherduds();
  for(;;) {
    self waittill("grenade_pullback", weapon);
    self addweaponstat(weapon, "shots", 1);
    self.hasdonecombat = 1;
    self.throwinggrenade = 1;
    self.gotpullbacknotify = 1;
    if(weapon.drawoffhandmodelinhand) {
      self setoffhandvisible(1);
      self thread watch_offhand_end();
    }
    self thread begingrenadetracking();
  }
}

function watchmissileusage() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("missile_fire", missile, weapon);
    self.hasdonecombat = 1;
    /
    #
    assert(isDefined(missile));
    level.missileentities[level.missileentities.size] = missile;
    missile.weapon = weapon;
    missile thread watchmissiledeath();
  }
}

function watchmissiledeath() {
  self waittill("death");
  arrayremovevalue(level.missileentities, self);
}

function dropweaponstoground(origin, radius) {
  weapons = getdroppedweapons();
  for(i = 0; i < weapons.size; i++) {
    if(distancesquared(origin, weapons[i].origin) < (radius * radius)) {
      trace = bulletTrace(weapons[i].origin, weapons[i].origin + (vectorscale((0, 0, -1), 2000)), 0, weapons[i]);
      weapons[i].origin = trace["position"];
    }
  }
}

function dropgrenadestoground(origin, radius) {
  grenades = getEntArray("grenade", "classname");
  for(i = 0; i < grenades.size; i++) {
    if(distancesquared(origin, grenades[i].origin) < (radius * radius)) {
      grenades[i] launch(vectorscale((1, 1, 1), 5));
    }
  }
}

function watchgrenadecancel() {
  self endon("death");
  self endon("disconnect");
  self endon("grenade_fire");
  waittillframeend();
  weapon = level.weaponnone;
  while(self isthrowinggrenade() && weapon == level.weaponnone) {
    self waittill("weapon_change", weapon);
  }
  self.throwinggrenade = 0;
  self.gotpullbacknotify = 0;
}

function watch_offhand_end() {
  self notify("watchoffhandend");
  self endon("watchoffhandend");
  while(self is_using_offhand_equipment()) {
    msg = self util::waittill_any_return("death", "disconnect", "grenade_fire", "weapon_change", "watchOffhandEnd");
    if(msg == "death" || msg == "disconnect") {
      break;
    }
  }
  self setoffhandvisible(0);
}

function is_using_offhand_equipment() {
  if(self isusingoffhand()) {
    weapon = self getcurrentoffhand();
    if(weapon.isequipment) {
      return true;
    }
  }
  return false;
}

function begingrenadetracking() {
  self endon("death");
  self endon("disconnect");
  starttime = gettime();
  self thread watchgrenadecancel();
  self waittill("grenade_fire", grenade, weapon);
  if(!isDefined(grenade)) {
    return;
  }
  level.missileentities[level.missileentities.size] = grenade;
  grenade.weapon = weapon;
  grenade thread watchmissiledeath();
  if(grenade util::ishacked()) {
    return;
  }
  if((gettime() - starttime) > 1000) {
    grenade.iscooked = 1;
  }
  switch (weapon.name) {
    case "frag_grenade":
    case "sticky_grenade": {
      self addweaponstat(weapon, "used", 1);
    }
    case "explosive_bolt": {
      grenade.originalowner = self;
      break;
    }
  }
  self.throwinggrenade = 0;
}

function beginothergrenadetracking() {}

function checkstucktoplayer(deleteonteamchange, awardscoreevent, weapon) {
  self endon("death");
  self waittill("stuck_to_player", player);
  if(isDefined(player)) {
    if(deleteonteamchange) {
      self thread stucktoplayerteamchange(player);
    }
    if(awardscoreevent && isDefined(self.originalowner)) {}
    self.stucktoplayer = player;
  }
}

function checkhatchetbounce() {
  self endon("stuck_to_player");
  self endon("death");
  self waittill("grenade_bounce");
  self.bounced = 1;
}

function stucktoplayerteamchange(player) {
  self endon("death");
  player endon("disconnect");
  originalteam = player.pers["team"];
  while(true) {
    player waittill("joined_team");
    if(player.pers["team"] != originalteam) {
      self detonate();
      return;
    }
  }
}

function watchforthrowbacks() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    self waittill("grenade_fire", grenade, weapon);
    if(self.gotpullbacknotify) {
      self.gotpullbacknotify = 0;
      continue;
    }
    if(!issubstr(weapon.name, "frag_")) {
      continue;
    }
    grenade.threwback = 1;
    grenade.originalowner = self;
  }
}

function registergrenadelauncherduddvar(dvarstring, defaultvalue, minvalue, maxvalue) {
  dvarstring = ("scr_" + dvarstring) + "_grenadeLauncherDudTime";
  if(getdvarstring(dvarstring) == "") {
    setdvar(dvarstring, defaultvalue);
  }
  if(getdvarint(dvarstring) > maxvalue) {
    setdvar(dvarstring, maxvalue);
  } else if(getdvarint(dvarstring) < minvalue) {
    setdvar(dvarstring, minvalue);
  }
  level.grenadelauncherdudtimedvar = dvarstring;
  level.grenadelauncherdudtimemin = minvalue;
  level.grenadelauncherdudtimemax = maxvalue;
  level.grenadelauncherdudtime = getdvarint(level.grenadelauncherdudtimedvar);
}

function registerthrowngrenadeduddvar(dvarstring, defaultvalue, minvalue, maxvalue) {
  dvarstring = ("scr_" + dvarstring) + "_thrownGrenadeDudTime";
  if(getdvarstring(dvarstring) == "") {
    setdvar(dvarstring, defaultvalue);
  }
  if(getdvarint(dvarstring) > maxvalue) {
    setdvar(dvarstring, maxvalue);
  } else if(getdvarint(dvarstring) < minvalue) {
    setdvar(dvarstring, minvalue);
  }
  level.throwngrenadedudtimedvar = dvarstring;
  level.throwngrenadedudtimemin = minvalue;
  level.throwngrenadedudtimemax = maxvalue;
  level.throwngrenadedudtime = getdvarint(level.throwngrenadedudtimedvar);
}

function registerkillstreakdelay(dvarstring, defaultvalue, minvalue, maxvalue) {
  dvarstring = ("scr_" + dvarstring) + "_killstreakDelayTime";
  if(getdvarstring(dvarstring) == "") {
    setdvar(dvarstring, defaultvalue);
  }
  if(getdvarint(dvarstring) > maxvalue) {
    setdvar(dvarstring, maxvalue);
  } else if(getdvarint(dvarstring) < minvalue) {
    setdvar(dvarstring, minvalue);
  }
  level.killstreakrounddelay = getdvarint(dvarstring);
}

function turngrenadeintoadud(weapon, isthrowngrenade, player) {
  if(level.roundstartexplosivedelay >= (globallogic_utils::gettimepassed() / 1000)) {
    if(weapon.disallowatmatchstart || weaponhasattachment(weapon, "gl")) {
      timeleft = int(level.roundstartexplosivedelay - (globallogic_utils::gettimepassed() / 1000));
      if(!timeleft) {
        timeleft = 1;
      }
      if(isthrowngrenade) {
        player iprintlnbold(&"MP_GRENADE_UNAVAILABLE_FOR_N", (" " + timeleft) + " ", &"EXE_SECONDS");
      } else {
        player iprintlnbold(&"MP_LAUNCHER_UNAVAILABLE_FOR_N", (" " + timeleft) + " ", &"EXE_SECONDS");
      }
      self makegrenadedud();
    }
  }
}

function watchforgrenadeduds() {
  self endon("spawned_player");
  self endon("disconnect");
  while(true) {
    self waittill("grenade_fire", grenade, weapon);
    grenade turngrenadeintoadud(weapon, 1, self);
  }
}

function watchforgrenadelauncherduds() {
  self endon("spawned_player");
  self endon("disconnect");
  while(true) {
    self waittill("grenade_launcher_fire", grenade, weapon);
    grenade turngrenadeintoadud(weapon, 0, self);
    /
    #
    assert(isDefined(grenade));
    level.missileentities[level.missileentities.size] = grenade;
    grenade.weapon = weapon;
    grenade thread watchmissiledeath();
  }
}

function getdamageableents(pos, radius, dolos, startradius) {
  ents = [];
  if(!isDefined(dolos)) {
    dolos = 0;
  }
  if(!isDefined(startradius)) {
    startradius = 0;
  }
  players = level.players;
  for(i = 0; i < players.size; i++) {
    if(!isalive(players[i]) || players[i].sessionstate != "playing") {
      continue;
    }
    playerpos = players[i].origin + vectorscale((0, 0, 1), 32);
    distsq = distancesquared(pos, playerpos);
    if(distsq < (radius * radius) && (!dolos || weapondamagetracepassed(pos, playerpos, startradius, undefined))) {
      newent = spawnStruct();
      newent.isplayer = 1;
      newent.isadestructable = 0;
      newent.isadestructible = 0;
      newent.isactor = 0;
      newent.entity = players[i];
      newent.damagecenter = playerpos;
      ents[ents.size] = newent;
    }
  }
  grenades = getEntArray("grenade", "classname");
  for(i = 0; i < grenades.size; i++) {
    entpos = grenades[i].origin;
    distsq = distancesquared(pos, entpos);
    if(distsq < (radius * radius) && (!dolos || weapondamagetracepassed(pos, entpos, startradius, grenades[i]))) {
      newent = spawnStruct();
      newent.isplayer = 0;
      newent.isadestructable = 0;
      newent.isadestructible = 0;
      newent.isactor = 0;
      newent.entity = grenades[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }
  destructibles = getEntArray("destructible", "targetname");
  for(i = 0; i < destructibles.size; i++) {
    entpos = destructibles[i].origin;
    distsq = distancesquared(pos, entpos);
    if(distsq < (radius * radius) && (!dolos || weapondamagetracepassed(pos, entpos, startradius, destructibles[i]))) {
      newent = spawnStruct();
      newent.isplayer = 0;
      newent.isadestructable = 0;
      newent.isadestructible = 1;
      newent.isactor = 0;
      newent.entity = destructibles[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }
  destructables = getEntArray("destructable", "targetname");
  for(i = 0; i < destructables.size; i++) {
    entpos = destructables[i].origin;
    distsq = distancesquared(pos, entpos);
    if(distsq < (radius * radius) && (!dolos || weapondamagetracepassed(pos, entpos, startradius, destructables[i]))) {
      newent = spawnStruct();
      newent.isplayer = 0;
      newent.isadestructable = 1;
      newent.isadestructible = 0;
      newent.isactor = 0;
      newent.entity = destructables[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }
  return ents;
}

function damageent(einflictor, eattacker, idamage, smeansofdeath, weapon, damagepos, damagedir) {
  if(self.isplayer) {
    self.damageorigin = damagepos;
    self.entity thread[[level.callbackplayerdamage]](einflictor, eattacker, idamage, 0, smeansofdeath, weapon, damagepos, damagedir, "none", damagepos, 0, 0, (1, 0, 0));
  } else {
    if(self.isactor) {
      self.damageorigin = damagepos;
      self.entity thread[[level.callbackactordamage]](einflictor, eattacker, idamage, 0, smeansofdeath, weapon, damagepos, damagedir, "none", damagepos, 0, 0, 0, (1, 0, 0));
    } else {
      if(self.isadestructible) {
        self.damageorigin = damagepos;
        self.entity dodamage(idamage, damagepos, eattacker, einflictor, 0, smeansofdeath, 0, weapon);
      } else {
        self.entity util::damage_notify_wrapper(idamage, eattacker, (0, 0, 0), (0, 0, 0), "mod_explosive", "", "");
      }
    }
  }
}

function debugline(a, b, color) {
  for(i = 0; i < 600; i++) {
    line(a, b, color);
    wait(0.05);
  }
}

function onweapondamage(eattacker, einflictor, weapon, meansofdeath, damage) {
  self endon("death");
  self endon("disconnect");
  switch (weapon.name) {
    case "concussion_grenade": {
      radius = 512;
      if(self == eattacker) {
        radius = radius * 0.5;
      }
      scale = 1 - (distance(self.origin, einflictor.origin) / radius);
      if(scale < 0) {
        scale = 0;
      }
      time = 2 + (4 * scale);
      wait(0.05);
      if(self hasperk("specialty_stunprotection")) {
        time = time * 0.1;
      }
      self thread playconcussionsound(time);
      if(self util::mayapplyscreeneffect()) {
        self shellshock("concussion_grenade_mp", time, 0);
      }
      self.concussionendtime = gettime() + (time * 1000);
      break;
    }
    default: {
      if(isDefined(level.shellshockonplayerdamage)) {
        [[level.shellshockonplayerdamage]](meansofdeath, damage, weapon);
      }
      break;
    }
  }
}

function playconcussionsound(duration) {
  self endon("death");
  self endon("disconnect");
  concussionsound = spawn("script_origin", (0, 0, 1));
  concussionsound.origin = self.origin;
  concussionsound linkto(self);
  concussionsound thread deleteentonownerdeath(self);
  concussionsound playSound("");
  concussionsound playLoopSound("");
  if(duration > 0.5) {
    wait(duration - 0.5);
  }
  concussionsound playSound("");
  concussionsound stoploopsound(0.5);
  wait(0.5);
  concussionsound notify("delete");
  concussionsound delete();
}

function deleteentonownerdeath(owner) {
  self endon("delete");
  owner waittill("death");
  self delete();
}

function updatestowedweapon() {
  self endon("spawned");
  self endon("killed_player");
  self endon("disconnect");
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
  team = self.pers["team"];
  curclass = self.pers["class"];
  while(true) {
    self waittill("weapon_change", newweapon);
    self.weapon_array_primary = [];
    self.weapon_array_sidearm = [];
    self.weapon_array_grenade = [];
    self.weapon_array_inventory = [];
    weaponslist = self getweaponslist();
    for(idx = 0; idx < weaponslist.size; idx++) {
      switch (weaponslist[idx]) {
        case "m202_flash":
        case "m220_tow":
        case "m32":
        case "minigun":
        case "mp40_blinged":
        case "zipline": {
          continue;
        }
        default: {
          break;
        }
      }
      if(is_primary_weapon(weaponslist[idx])) {
        self.weapon_array_primary[self.weapon_array_primary.size] = weaponslist[idx];
        continue;
      }
      if(is_side_arm(weaponslist[idx])) {
        self.weapon_array_sidearm[self.weapon_array_sidearm.size] = weaponslist[idx];
        continue;
      }
      if(is_grenade(weaponslist[idx])) {
        self.weapon_array_grenade[self.weapon_array_grenade.size] = weaponslist[idx];
        continue;
      }
      if(is_inventory(weaponslist[idx])) {
        self.weapon_array_inventory[self.weapon_array_inventory.size] = weaponslist[idx];
        continue;
      }
      if(weaponslist[idx].isprimary) {
        self.weapon_array_primary[self.weapon_array_primary.size] = weaponslist[idx];
      }
    }
    detach_all_weapons();
    stow_on_back();
    stow_on_hip();
  }
}

function loadout_get_class_num() {
  assert(isplayer(self));
  assert(isDefined(self.curclass));
  if(isDefined(level.classtoclassnum[self.curclass])) {
    return level.classtoclassnum[self.curclass];
  }
  class_num = (int(self.curclass[self.curclass.size - 1])) - 1;
  if(-1 == class_num) {
    class_num = 9;
  }
  return class_num;
}

function loadout_get_offhand_weapon(stat) {
  if(isDefined(level.givecustomloadout)) {
    return level.weaponnone;
  }
  class_num = self loadout_get_class_num();
  index = 0;
  if(isDefined(level.tbl_weaponids[index]) && isDefined(level.tbl_weaponids[index]["reference"])) {
    return getweapon(level.tbl_weaponids[index]["reference"]);
  }
  return level.weaponnone;
}

function loadout_get_offhand_count(stat) {
  if(isDefined(level.givecustomloadout)) {
    return 0;
  }
  class_num = self loadout_get_class_num();
  count = 0;
  return count;
}

function scavenger_think() {
  self endon("death");
  self waittill("scavenger", player);
  primary_weapons = player getweaponslistprimaries();
  offhand_weapons_and_alts = array::exclude(player getweaponslist(1), primary_weapons);
  arrayremovevalue(offhand_weapons_and_alts, level.weaponbasemelee);
  player playSound("wpn_ammo_pickup");
  player playlocalsound("wpn_ammo_pickup");
  player.scavenger_icon.alpha = 1;
  player.scavenger_icon fadeovertime(2.5);
  player.scavenger_icon.alpha = 0;
  scavenger_lethal_proc = 1;
  scavenger_tactical_proc = 1;
  if(!isDefined(player.scavenger_lethal_proc)) {
    player.scavenger_lethal_proc = 0;
    player.scavenger_tactical_proc = 0;
  }
  loadout_primary = player loadout_get_offhand_weapon("primarygrenade");
  loadout_primary_count = player loadout_get_offhand_count("primarygrenadecount");
  loadout_secondary = player loadout_get_offhand_weapon("specialgrenade");
  loadout_secondary_count = player loadout_get_offhand_count("specialgrenadeCount");
  for(i = 0; i < offhand_weapons_and_alts.size; i++) {
    weapon = offhand_weapons_and_alts[i];
    if(!weapon.isscavengable) {
      continue;
    }
    switch (weapon.name) {
      case "bouncingbetty":
      case "claymore":
      case "frag_grenade":
      case "hatchet":
      case "satchel_charge":
      case "sticky_grenade": {
        if(isDefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount < 1) {
          break;
        }
        if(player getweaponammostock(weapon) != loadout_primary_count) {
          if(player.scavenger_lethal_proc < scavenger_lethal_proc) {
            player.scavenger_lethal_proc++;
            break;
          }
          player.scavenger_lethal_proc = 0;
          player.scavenger_tactical_proc = 0;
        }
      }
      case "concussion_grenade":
      case "emp_grenade":
      case "flash_grenade":
      case "nightingale":
      case "pda_hack":
      case "proximity_grenade":
      case "sensor_grenade":
      case "tabun_gas":
      case "trophy_system":
      case "willy_pete": {
        if(isDefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount < 1) {
          break;
        }
        if(weapon == loadout_secondary && player getweaponammostock(weapon) != loadout_secondary_count) {
          if(player.scavenger_tactical_proc < scavenger_tactical_proc) {
            player.scavenger_tactical_proc++;
            break;
          }
          player.scavenger_tactical_proc = 0;
          player.scavenger_lethal_proc = 0;
        }
        maxammo = weapon.maxammo;
        stock = player getweaponammostock(weapon);
        if(isDefined(level.customloadoutscavenge)) {
          maxammo = self[[level.customloadoutscavenge]](weapon);
        } else {
          if(weapon == loadout_primary) {
            maxammo = loadout_primary_count;
          } else if(weapon == loadout_secondary) {
            maxammo = loadout_secondary_count;
          }
        }
        if(stock < maxammo) {
          ammo = stock + 1;
          if(ammo > maxammo) {
            ammo = maxammo;
          }
          player setweaponammostock(weapon, ammo);
          player thread challenges::scavengedgrenade();
        }
        break;
      }
      default: {
        if(weapon.islauncherweapon) {
          stock = player getweaponammostock(weapon);
          start = player getfractionstartammo(weapon);
          clip = weapon.clipsize;
          clip = clip * getdvarfloat("scavenger_clip_multiplier", 2);
          clip = int(clip);
          maxammo = weapon.maxammo;
          if(stock < (maxammo - clip)) {
            ammo = stock + clip;
            player setweaponammostock(weapon, ammo);
          } else {
            player setweaponammostock(weapon, maxammo);
          }
        }
        break;
      }
    }
  }
  for(i = 0; i < primary_weapons.size; i++) {
    weapon = primary_weapons[i];
    if(!weapon.isscavengable) {
      continue;
    }
    stock = player getweaponammostock(weapon);
    start = player getfractionstartammo(weapon);
    clip = weapon.clipsize;
    clip = clip * getdvarfloat("scavenger_clip_multiplier", 2);
    clip = int(clip);
    maxammo = weapon.maxammo;
    if(stock < (maxammo - clip)) {
      ammo = stock + clip;
      player setweaponammostock(weapon, ammo);
      continue;
    }
    player setweaponammostock(weapon, maxammo);
  }
}

function scavenger_hud_create() {
  if(level.wagermatch) {
    return;
  }
  self.scavenger_icon = newclienthudelem(self);
  self.scavenger_icon.horzalign = "center";
  self.scavenger_icon.vertalign = "middle";
  self.scavenger_icon.x = -16;
  self.scavenger_icon.y = 16;
  self.scavenger_icon.alpha = 0;
  width = 32;
  height = 16;
  if(self issplitscreen()) {
    width = int(width * 0.5);
    height = int(height * 0.5);
    self.scavenger_icon.x = -8;
  }
  self.scavenger_icon setshader("hud_scavenger_pickup", width, height);
}

function dropscavengerfordeath(attacker) {
  if(sessionmodeiszombiesgame()) {
    return;
  }
  if(level.wagermatch) {
    return;
  }
  if(!isDefined(attacker)) {
    return;
  }
  if(attacker == self) {
    return;
  }
  if(level.gametype == "hack") {
    item = self dropscavengeritem(getweapon("scavenger_item_hack"));
  } else {
    item = self dropscavengeritem(getweapon("scavenger_item"));
  }
  item thread scavenger_think();
}

function addlimitedweapon(weapon, owner, num_drops) {
  limited_info = spawnStruct();
  limited_info.weapon = weapon;
  limited_info.drops = num_drops;
  owner.limited_info = limited_info;
}

function shoulddroplimitedweapon(weapon, owner) {
  limited_info = owner.limited_info;
  if(!isDefined(limited_info)) {
    return true;
  }
  if(limited_info.weapon != weapon) {
    return true;
  }
  if(limited_info.drops <= 0) {
    return false;
  }
  return true;
}

function droplimitedweapon(weapon, owner, item) {
  limited_info = owner.limited_info;
  if(!isDefined(limited_info)) {
    return;
  }
  if(limited_info.weapon != weapon) {
    return;
  }
  limited_info.drops = limited_info.drops - 1;
  owner.limited_info = undefined;
  item thread limitedpickup(limited_info);
}

function limitedpickup(limited_info) {
  self endon("death");
  self waittill("trigger", player, item);
  if(!isDefined(item)) {
    return;
  }
  player.limited_info = limited_info;
}