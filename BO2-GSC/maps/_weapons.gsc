/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_weapons.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_empgrenade;
#include maps\_flashgrenades;
#include maps\_weaponobjects;
#include maps\_explosive_bolt;
#include maps\_explosive_dart;
#include maps\_sticky_grenade;
#include maps\_flamethrower_plight;
#include maps\_ballistic_knife;
#include maps\_riotshield;
#include maps\_titus;
#include maps\_afghanstinger;
#include maps\_shellshock;

init() {
  level thread on_player_connect();
  precacheitem("scavenger_item_sp");
  maps\_empgrenade::init();
  maps\_flashgrenades::main();
  maps\_weaponobjects::init();
  maps\_explosive_bolt::init();
  maps\_explosive_dart::init();
  maps\_sticky_grenade::init();
  maps\_flamethrower_plight::init();
  maps\_ballistic_knife::init();
  maps\_riotshield::init();
  maps\_titus::init();
  maps\_afghanstinger::init();
}

on_player_connect() {
  while(true) {
    level waittill("connecting", player);
    player.usedweapons = 0;
    player.hits = 0;
    player thread on_player_spawned();
  }
}

on_player_spawned() {
  self endon("disconnect");
  self endon("death");
  self.usedweapons = 0;
  self.hits = 0;

  while(true) {
    self waittill("spawned_player");
    self thread maps\_titus::_titus_fire_watcher();
    self thread maps\_afghanstinger::_afghanstinger_fire_watcher();
    self thread watch_weapon_usage();
    self thread watch_grenade_usage();
    self thread watch_riotshield_usage();
    self thread watch_metalstorm_mms_usage();
  }
}

watch_weapon_usage() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("begin_firing");
    curweapon = self getcurrentweapon();

    switch (weaponclass(curweapon)) {
      case "mg":
      case "pistol":
      case "rifle":
      case "smg":
      case "spread":
        break;
      case "grenade":
      case "rocketlauncher":
        if(weaponinventorytype(curweapon) != "item")
          self thread maps\_shellshock::rocket_earthquake();

        break;
      default:
        break;
    }

    self waittill("end_firing");
  }
}

watch_grenade_usage() {
  self endon("death");
  self endon("disconnect");
  self thread begin_other_grenade_tracking();

  while(true) {
    self waittill("grenade_pullback", weaponname);

    if(weaponname == "claymore_sp" || weaponname == "claymore_80s_sp") {
      continue;
    }
    self begin_grenade_tracking();
  }
}

watch_riotshield_usage() {
  self endon("death");
  self endon("disconnect");
  self thread maps\_riotshield::trackriotshield();

  for(;;) {
    self waittill("raise_riotshield");
    self thread maps\_riotshield::startriotshielddeploy();
  }
}

watch_metalstorm_mms_usage() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_change", weapon);

    while(issubstr(weapon, "metalstorm_mms")) {
      self metalstorm_mms_charge_watch();
      weapon = level.player getcurrentweapon();
    }
  }
}

metalstorm_mms_charge_watch() {
  self endon("death");
  self endon("disconnect");
  self endon("weapon_change");
  self endon("weapon_fired");
  self waittill("action_notify_attack");

  while(true) {
    switch (self.chargeshotlevel) {
      case 1:
      case 2:
        level.player playrumbleonentity("anim_light");
        break;
      case 3:
      case 4:
        level.player playrumbleonentity("anim_med");
        break;
      case 5:
        level.player playrumbleonentity("anim_heavy");
        break;
    }

    wait 0.1;
  }
}

begin_grenade_tracking() {
  self endon("death");
  self endon("disconnect");
  starttime = gettime();
  self waittill("grenade_fire", grenade, weaponname);

  if(gettime() - starttime > 1000)
    grenade.iscooked = 1;

  switch (weaponname) {
    case "frag_grenade_80s_sp":
    case "frag_grenade_sp":
    case "sticky_grenade_80s_sp":
    case "sticky_grenade_sp":
      grenade thread maps\_shellshock::grenade_earthquake();
      grenade.originalowner = self;
      break;
    case "satchel_charge_80s_sp":
    case "satchel_charge_sp":
      grenade thread maps\_shellshock::satchel_earthquake();
      break;
    case "c4_sp":
      grenade thread maps\_shellshock::c4_earthquake();
      break;
  }

  self.throwinggrenade = 0;
}

begin_other_grenade_tracking() {
  self notify("grenadeTrackingStart");
  self endon("grenadeTrackingStart");
  self endon("disconnect");

  while(true) {
    self waittill("grenade_fire", grenade, weaponname, parent);

    switch (weaponname) {
      case "flash_grenade_80s_sp":
      case "flash_grenade_sp":
        break;
      case "signal_flare_sp":
        break;
      case "tabun_gas_sp":
        break;
      case "vc_grenade_sp":
        break;
      case "m8_orange_smoke_sp":
      case "willy_pete_80s_sp":
      case "willy_pete_sp":
        grenade thread watchsmokegrenadedetonation();
        break;
      case "c4_sp":
      case "satchel_charge_80s_sp":
      case "satchel_charge_sp":
      case "sticky_grenade_80s_sp":
      case "sticky_grenade_sp":
        break;
      case "emp_grenade_sp":
        grenade thread watch_emp_grenade(self, "emp_grenade_sp");
        break;
    }
  }
}

watch_emp_grenade(owner, weaponname) {
  level endon("death");
  self waittill("explode", origin);
  ents = getdamageableents(origin, 512);

  foreach(ent in ents) {
    if(isplayer(ent.entity) || isDefined(ent.entity.classname) && ent.entity.classname == "script_vehicle" || isDefined(ent.entity.isbigdog) && ent.entity.isbigdog)
      ent.entity dodamage(1, origin, owner, "none", "MOD_GRENADE_SPLASH", 0, weaponname);
  }
}

getdamageableents(pos, radius, dolos, startradius) {
  ents = [];

  if(!isDefined(dolos))
    dolos = 0;

  if(!isDefined(startradius))
    startradius = 0;

  players = getplayers();

  for(i = 0; i < players.size; i++) {
    if(!isalive(players[i]) || players[i].sessionstate != "playing") {
      continue;
    }
    playerpos = players[i].origin + vectorscale((0, 0, 1), 32.0);
    distsq = distancesquared(pos, playerpos);

    if(distsq < radius * radius && (!dolos || weapondamagetracepassed(pos, playerpos, startradius, undefined))) {
      newent = spawnstruct();
      newent.isplayer = 1;
      newent.isadestructable = 0;
      newent.entity = players[i];
      newent.damagecenter = playerpos;
      ents[ents.size] = newent;
    }
  }

  guys = getaiarray("axis", "allies", "neutral");

  for(i = 0; i < guys.size; i++) {
    entpos = guys[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radius * radius && (!dolos || weapondamagetracepassed(pos, entpos, startradius, guys[i]))) {
      newent = spawnstruct();
      newent.isplayer = 0;
      newent.isadestructable = 0;
      newent.entity = guys[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  vehicles = getvehiclearray("axis", "allies", "neutral");

  for(i = 0; i < vehicles.size; i++) {
    entpos = vehicles[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radius * radius && (!dolos || weapondamagetracepassed(pos, entpos, startradius, vehicles[i]))) {
      newent = spawnstruct();
      newent.isplayer = 0;
      newent.isadestructable = 0;
      newent.entity = vehicles[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  grenades = getentarray("grenade", "classname");

  for(i = 0; i < grenades.size; i++) {
    entpos = grenades[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radius * radius && (!dolos || weapondamagetracepassed(pos, entpos, startradius, grenades[i]))) {
      newent = spawnstruct();
      newent.isplayer = 0;
      newent.isadestructable = 0;
      newent.entity = grenades[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  destructibles = getentarray("destructible", "targetname");

  for(i = 0; i < destructibles.size; i++) {
    entpos = destructibles[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radius * radius && (!dolos || weapondamagetracepassed(pos, entpos, startradius, destructibles[i]))) {
      newent = spawnstruct();
      newent.isplayer = 0;
      newent.isadestructable = 0;
      newent.entity = destructibles[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  destructables = getentarray("destructable", "targetname");

  for(i = 0; i < destructables.size; i++) {
    entpos = destructables[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radius * radius && (!dolos || weapondamagetracepassed(pos, entpos, startradius, destructables[i]))) {
      newent = spawnstruct();
      newent.isplayer = 0;
      newent.isadestructable = 1;
      newent.entity = destructables[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  return ents;
}

weapondamagetracepassed(from, to, startradius, ignore) {
  midpos = undefined;
  diff = to - from;

  if(lengthsquared(diff) < startradius * startradius)
    midpos = to;

  dir = vectornormalize(diff);
  midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
  trace = bullettrace(midpos, to, 0, ignore);
  return trace["fraction"] == 1;
}

damageent(einflictor, eattacker, idamage, smeansofdeath, sweapon, damagepos, damagedir) {
  if(self.isplayer) {
    self.damageorigin = damagepos;
    self.entity thread[[level.callbackplayerdamage]](einflictor, eattacker, idamage, 0, smeansofdeath, sweapon, damagepos, damagedir, "none", 0, 0);
  } else if(isalive(self.entity))
    self.entity dodamage(idamage, damagepos, eattacker, einflictor, smeansofdeath, 0);
  else {
    if(self.isadestructable && (sweapon == "artillery_sp" || sweapon == "mine_bouncing_betty_sp")) {
      return;
    }
    self.entity damage_notify_wrapper(idamage, eattacker, (0, 0, 0), (0, 0, 0), "mod_explosive", "", "");
  }
}

watchsmokegrenadedetonation() {
  self waittill("explode", position, surface);
  smokesound = spawn("script_origin", (0, 0, 1));
  smokesound.origin = position;
  smokesound playsound("wpn_smoke_hiss_start");
  smokesound playloopsound("wpn_smoke_hiss_lp");
  wait 6;
  playsoundatposition("wpn_smoke_hiss_end", position);
  smokesound stoploopsound(0.5);
  wait 0.5;
  smokesound delete();
}

isreloadablealtweapon(weapon) {
  if(getsubstr(weapon, 0, 3) == "gl_")
    return true;

  switch (weapon) {
    case "exptitus6_sp":
      return true;
  }

  return false;
}

scavenger_think() {
  self endon("death");
  self waittill("scavenger", player);
  primary_weapons = player getweaponslistprimaries();
  offhand_weapons = array_exclude(player getweaponslist(), primary_weapons);
  arrayremovevalue(offhand_weapons, "knife_sp");
  player playsound("fly_equipment_pickup_npc");
  player playlocalsound("fly_equipment_pickup_plr");

  for(i = 0; i < offhand_weapons.size; i++) {
    weapon = offhand_weapons[i];

    if(islauncherkweapon(weapon)) {
      continue;
    }
    switch (weapon) {
      case "concussion_grenade_80s_sp":
      case "concussion_grenade_sp":
      case "emp_grenade_sp":
      case "flash_grenade_80s_sp":
      case "flash_grenade_sp":
      case "frag_grenade_80s_sp":
      case "frag_grenade_sp":
      case "hatchet_80s_sp":
      case "hatchet_sp":
      case "nightingale_sp":
      case "proximity_grenade_sp":
      case "sticky_grenade_80s_sp":
      case "sticky_grenade_sp":
      case "tabun_gas_sp":
      case "willy_pete_80s_sp":
      case "willy_pete_sp":
        stock = player getweaponammostock(weapon);
        maxammo = weaponmaxammo(weapon);

        if(stock < maxammo) {
          ammo = stock + 1;
          player setweaponammostock(weapon, ammo);
        }

        break;
      default:
        if(isreloadablealtweapon(weapon)) {
          stock = player getweaponammostock(weapon);
          start = player getfractionstartammo(weapon);
          clip = weaponclipsize(weapon);
          clip = clip * getdvarfloatdefault("scavenger_clip_multiplier", 2);
          clip = int(clip);
          maxammo = weaponmaxammo(weapon);

          if(stock < maxammo - clip) {
            ammo = stock + clip;
            player setweaponammostock(weapon, ammo);
          } else
            player setweaponammostock(weapon, maxammo);
        }

        break;
    }
  }

  for(i = 0; i < primary_weapons.size; i++) {
    weapon = primary_weapons[i];

    if(islauncherkweapon(weapon)) {
      continue;
    }
    stock = player getweaponammostock(weapon);
    start = player getfractionstartammo(weapon);
    clip = weaponclipsize(weapon);
    maxammo = weaponmaxammo(weapon);

    if(stock < maxammo - clip) {
      ammo = stock + clip;
      player setweaponammostock(weapon, ammo);
      continue;
    }

    player setweaponammostock(weapon, maxammo);
  }
}

islauncherkweapon(weapon) {
  if(getsubstr(weapon, 0, 2) == "gl_")
    return true;

  switch (weapon) {
    case "china_lake_sp":
    case "fhj18_sp":
    case "m202_flash_sp":
    case "m220_tow_sp_sp":
    case "m72_law_sp":
    case "rpg_sp":
    case "smaw_sp":
    case "strela_sp":
      return true;
    default:
      return false;
  }
}