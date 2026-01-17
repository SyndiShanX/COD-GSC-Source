/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_rcbomb.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_challenges;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\gametypes\_hostmigration;
#using scripts\mp\gametypes\_shellshock;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\killstreaks\_emp;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreak_detect;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_remote_weapons;
#using scripts\shared\_oob;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\tweakables_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\weapons\_flashgrenades;
#using scripts\shared\weapons\_weaponobjects;
#namespace rcbomb;

function init() {
  level._effect["rcbombexplosion"] = "killstreaks/fx_rcxd_exp";
  killstreaks::register("rcbomb", "rcbomb", "killstreak_rcbomb", "rcbomb_used", &activatercbomb);
  killstreaks::register_strings("rcbomb", &"KILLSTREAK_EARNED_RCBOMB", &"KILLSTREAK_RCBOMB_NOT_AVAILABLE", &"KILLSTREAK_RCBOMB_INBOUND", undefined, &"KILLSTREAK_RCBOMB_HACKED", 0);
  killstreaks::register_dialog("rcbomb", "mpl_killstreak_rcbomb", "rcBombDialogBundle", undefined, "friendlyRcBomb", "enemyRcBomb", "enemyRcBombMultiple", "friendlyRcBombHacked", "enemyRcBombHacked", "requestRcBomb");
  killstreaks::allow_assists("rcbomb", 1);
  killstreaks::register_alt_weapon("rcbomb", "killstreak_remote");
  killstreaks::register_alt_weapon("rcbomb", "rcbomb_turret");
  remote_weapons::registerremoteweapon("rcbomb", &"", &startremotecontrol, &endremotecontrol, 0);
  vehicle::add_main_callback("rc_car_mp", &initrcbomb);
  clientfield::register("vehicle", "rcbomb_stunned", 1, 1, "int");
}

function initrcbomb() {
  rcbomb = self;
  rcbomb clientfield::set("enemyvehicle", 1);
  rcbomb.allowfriendlyfiredamageoverride = &rccarallowfriendlyfiredamage;
  rcbomb enableaimassist();
  rcbomb setdrawinfrared(1);
  rcbomb.delete_on_death = 1;
  rcbomb.death_enter_cb = &waitremotecontrol;
  rcbomb.disableremoteweaponswitch = 1;
  rcbomb.overridevehicledamage = &ondamage;
  rcbomb.overridevehicledeath = &ondeath;
  rcbomb.watch_remote_weapon_death = 1;
  rcbomb.watch_remote_weapon_death_duration = 0.3;
  if(issentient(rcbomb) == 0) {
    rcbomb makesentient();
  }
}

function waitremotecontrol() {
  remote_controlled = isDefined(self.control_initiated) && self.control_initiated || (isDefined(self.controlled) && self.controlled);
  if(remote_controlled) {
    notifystring = self util::waittill_any_return("remote_weapon_end", "rcbomb_shutdown");
    if(notifystring == "remote_weapon_end") {
      self waittill("rcbomb_shutdown");
    } else {
      self waittill("remote_weapon_end");
    }
  } else {
    self waittill("rcbomb_shutdown");
  }
}

function togglelightsonaftertime(time) {
  self notify("togglelightsonaftertime_singleton");
  self endon("togglelightsonaftertime_singleton");
  rcbomb = self;
  rcbomb endon("death");
  wait(time);
  rcbomb clientfield::set("toggle_lights", 0);
}

function hackedprefunction(hacker) {
  rcbomb = self;
  rcbomb clientfield::set("toggle_lights", 1);
  rcbomb.owner unlink();
  rcbomb clientfield::set("vehicletransition", 0);
  rcbomb.owner killstreaks::clear_using_remote();
  rcbomb makevehicleunusable();
}

function hackedpostfunction(hacker) {
  rcbomb = self;
  hacker remote_weapons::useremoteweapon(rcbomb, "rcbomb", 1, 0);
  rcbomb makevehicleunusable();
  hacker killstreaks::set_killstreak_delay_killcam("rcbomb");
  hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(rcbomb);
}

function configureteampost(owner, ishacked) {
  rcbomb = self;
  rcbomb thread watchownergameevents();
}

function activatercbomb(hardpointtype) {
  assert(isplayer(self));
  player = self;
  if(!player killstreakrules::iskillstreakallowed(hardpointtype, player.team)) {
    return false;
  }
  if(player usebuttonpressed()) {
    return false;
  }
  placement = calculatespawnorigin(self.origin, self.angles);
  if(!isDefined(placement) || !self isonground() || self util::isusingremote() || killstreaks::is_interacting_with_object() || self oob::istouchinganyoobtrigger() || self killstreaks::is_killstreak_start_blocked()) {
    self iprintlnbold(&"KILLSTREAK_RCBOMB_NOT_PLACEABLE");
    return false;
  }
  killstreak_id = player killstreakrules::killstreakstart("rcbomb", player.team, 0, 1);
  if(killstreak_id == -1) {
    return false;
  }
  rcbomb = spawnvehicle("rc_car_mp", placement.origin, placement.angles, "rcbomb");
  rcbomb killstreaks::configure_team("rcbomb", killstreak_id, player, "small_vehicle", undefined, &configureteampost);
  rcbomb killstreak_hacking::enable_hacking("rcbomb", &hackedprefunction, &hackedpostfunction);
  rcbomb.damagetaken = 0;
  rcbomb.abandoned = 0;
  rcbomb.killstreak_id = killstreak_id;
  rcbomb.activatingkillstreak = 1;
  rcbomb setinvisibletoall();
  rcbomb thread watchshutdown();
  rcbomb.health = killstreak_bundles::get_max_health(hardpointtype);
  rcbomb.maxhealth = killstreak_bundles::get_max_health(hardpointtype);
  rcbomb.hackedhealth = killstreak_bundles::get_hacked_health(hardpointtype);
  rcbomb.hackedhealthupdatecallback = &rcbomb_hacked_health_update;
  rcbomb.ignore_vehicle_underneath_splash_scalar = 1;
  self thread killstreaks::play_killstreak_start_dialog("rcbomb", self.team, killstreak_id);
  self addweaponstat(getweapon("rcbomb"), "used", 1);
  remote_weapons::useremoteweapon(rcbomb, "rcbomb", 1, 0);
  if(!isDefined(player) || !isalive(player) || (isDefined(player.laststand) && player.laststand) || player isempjammed()) {
    if(isDefined(rcbomb)) {
      rcbomb notify("remote_weapon_shutdown");
      rcbomb notify("rcbomb_shutdown");
    }
    return false;
  }
  rcbomb setvisibletoall();
  rcbomb.activatingkillstreak = 0;
  target_set(rcbomb);
  rcbomb thread watchgameended();
  return true;
}

function rcbomb_hacked_health_update(hacker) {
  rcbomb = self;
  if(rcbomb.health > rcbomb.hackedhealth) {
    rcbomb.health = rcbomb.hackedhealth;
  }
}

function startremotecontrol(rcbomb) {
  player = self;
  rcbomb usevehicle(player, 0);
  rcbomb clientfield::set("vehicletransition", 1);
  rcbomb thread audio::sndupdatevehiclecontext(1);
  rcbomb thread watchtimeout();
  rcbomb thread watchdetonation();
  rcbomb thread watchhurttriggers();
  rcbomb thread watchwater();
  player vehicle::set_vehicle_drivable_time_starting_now(40000);
}

function endremotecontrol(rcbomb, exitrequestedbyowner) {
  if(exitrequestedbyowner == 0) {
    rcbomb notify("rcbomb_shutdown");
    rcbomb thread audio::sndupdatevehiclecontext(0);
  }
  rcbomb clientfield::set("vehicletransition", 0);
}

function watchdetonation() {
  rcbomb = self;
  rcbomb endon("rcbomb_shutdown");
  rcbomb endon("death");
  while(!rcbomb.owner attackbuttonpressed()) {
    wait(0.05);
  }
  rcbomb notify("rcbomb_shutdown");
}

function watchwater() {
  self endon("rcbomb_shutdown");
  inwater = 0;
  while(!inwater) {
    wait(0.5);
    trace = physicstrace(self.origin + vectorscale((0, 0, 1), 10), self.origin + vectorscale((0, 0, 1), 6), vectorscale((-1, -1, -1), 2), vectorscale((1, 1, 1), 2), self, 4);
    inwater = trace["fraction"] < 1;
  }
  self.abandoned = 1;
  self notify("rcbomb_shutdown");
}

function watchownergameevents() {
  self notify("watchownergameevents_singleton");
  self endon("watchownergameevents_singleton");
  rcbomb = self;
  rcbomb endon("rcbomb_shutdown");
  rcbomb.owner util::waittill_any("joined_team", "disconnect", "joined_spectators");
  rcbomb.abandoned = 1;
  rcbomb notify("rcbomb_shutdown");
}

function watchtimeout() {
  rcbomb = self;
  rcbomb thread killstreaks::waitfortimeout("rcbomb", 40000, &rc_shutdown, "rcbomb_shutdown");
}

function rc_shutdown() {
  rcbomb = self;
  rcbomb notify("rcbomb_shutdown");
}

function watchshutdown() {
  rcbomb = self;
  rcbomb endon("death");
  rcbomb waittill("rcbomb_shutdown");
  if(isDefined(rcbomb.activatingkillstreak) && rcbomb.activatingkillstreak) {
    killstreakrules::killstreakstop("rcbomb", rcbomb.originalteam, rcbomb.killstreak_id);
    rcbomb notify("rcbomb_shutdown");
    rcbomb delete();
  } else {
    attacker = (isDefined(rcbomb.owner) ? rcbomb.owner : undefined);
    rcbomb dodamage(rcbomb.health + 1, rcbomb.origin + vectorscale((0, 0, 1), 10), attacker, attacker, "none", "MOD_EXPLOSIVE", 0);
  }
}

function watchhurttriggers() {
  rcbomb = self;
  rcbomb endon("rcbomb_shutdown");
  while(true) {
    rcbomb waittill("touch", ent);
    if(isDefined(ent.classname) && (ent.classname == "trigger_hurt" || ent.classname == "trigger_out_of_bounds")) {
      rcbomb notify("rcbomb_shutdown");
    }
  }
}

function ondamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(self.activatingkillstreak) {
    return 0;
  }
  if(!isDefined(eattacker) || eattacker != self.owner) {
    idamage = killstreaks::ondamageperweapon("rcbomb", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
  }
  if(isDefined(eattacker) && isDefined(eattacker.team) && eattacker.team != self.team) {
    if(weapon.isemp) {
      self.damage_on_death = 0;
      self.died_by_emp = 1;
      idamage = self.health + 1;
    }
  }
  if(weapon.name == "satchel_charge" && smeansofdeath == "MOD_EXPLOSIVE") {
    idamage = self.health + 1;
  }
  return idamage;
}

function ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  rcbomb = self;
  player = rcbomb.owner;
  player endon("disconnect");
  player endon("joined_team");
  player endon("joined_spectators");
  killstreakrules::killstreakstop("rcbomb", rcbomb.originalteam, rcbomb.killstreak_id);
  rcbomb clientfield::set("enemyvehicle", 0);
  rcbomb explode(eattacker, weapon);
  hide_after_wait_time = (rcbomb.died_by_emp === 1 ? 0.2 : 0.1);
  if(isDefined(player)) {
    player util::freeze_player_controls(1);
    rcbomb thread hideafterwait(hide_after_wait_time);
    wait(0.2);
    player util::freeze_player_controls(0);
  } else {
    rcbomb thread hideafterwait(hide_after_wait_time);
  }
  if(isDefined(rcbomb)) {
    rcbomb notify("rcbomb_shutdown");
  }
}

function watchgameended() {
  rcbomb = self;
  rcbomb endon("death");
  level waittill("game_ended");
  rcbomb.abandoned = 1;
  rcbomb.selfdestruct = 1;
  rcbomb notify("rcbomb_shutdown");
}

function hideafterwait(waittime) {
  self endon("death");
  wait(waittime);
  self setinvisibletoall();
}

function explode(attacker, weapon) {
  self endon("death");
  owner = self.owner;
  if(!isDefined(attacker) && isDefined(self.owner)) {
    attacker = self.owner;
  }
  self vehicle_death::death_fx();
  self thread vehicle_death::death_radius_damage();
  self thread vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self vehicle::toggle_tread_fx(0);
  self vehicle::toggle_exhaust_fx(0);
  self vehicle::toggle_sounds(0);
  self vehicle::lights_off();
  self playrumbleonentity("rcbomb_explosion");
  if(!self.abandoned && attacker != self.owner && isplayer(attacker)) {
    attacker challenges::destroyrcbomb(weapon);
    if(self.owner util::isenemyplayer(attacker)) {
      scoreevents::processscoreevent("destroyed_hover_rcxd", attacker, self.owner, weapon);
      luinotifyevent(&"player_callout", 2, &"KILLSTREAK_DESTROYED_RCBOMB", attacker.entnum);
      if(isDefined(weapon) && weapon.isvalid) {
        weaponstatname = "destroyed";
        level.globalkillstreaksdestroyed++;
        weapon_rcbomb = getweapon("rcbomb");
        attacker addweaponstat(weapon_rcbomb, "destroyed", 1);
        attacker addweaponstat(weapon, "destroyed_controlled_killstreak", 1);
      }
      self killstreaks::play_destroyed_dialog_on_owner("rcbomb", self.killstreak_id);
    }
  }
}

function rccarallowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
  if(isDefined(eattacker) && eattacker == self.owner) {
    return true;
  }
  if(isDefined(einflictor) && einflictor islinkedto(self)) {
    return true;
  }
  return false;
}

function getplacementstartheight() {
  startheight = 50;
  switch (self getstance()) {
    case "crouch": {
      startheight = 30;
      break;
    }
    case "prone": {
      startheight = 15;
      break;
    }
  }
  return startheight;
}

function calculatespawnorigin(origin, angles) {
  startheight = getplacementstartheight();
  mins = vectorscale((-1, -1, 0), 5);
  maxs = (5, 5, 10);
  startpoints = [];
  startangles = [];
  wheelcounts = [];
  testcheck = [];
  largestcount = 0;
  largestcountindex = 0;
  testangles = [];
  testangles[0] = (0, 0, 0);
  testangles[1] = vectorscale((0, 1, 0), 20);
  testangles[2] = vectorscale((0, -1, 0), 20);
  testangles[3] = vectorscale((0, 1, 0), 45);
  testangles[4] = vectorscale((0, -1, 0), 45);
  heightoffset = 5;
  for(i = 0; i < testangles.size; i++) {
    testcheck[i] = 0;
    startangles[i] = (0, angles[1], 0);
    startpoint = origin + (vectorscale(anglesToForward(startangles[i] + testangles[i]), 70));
    endpoint = startpoint - vectorscale((0, 0, 1), 100);
    startpoint = startpoint + (0, 0, startheight);
    mask = 1 | 2;
    trace = physicstrace(startpoint, endpoint, mins, maxs, self, mask);
    if(isDefined(trace["entity"]) && isplayer(trace["entity"])) {
      wheelcounts[i] = 0;
      continue;
    }
    startpoints[i] = trace["position"] + (0, 0, heightoffset);
    wheelcounts[i] = testwheellocations(startpoints[i], startangles[i], heightoffset);
    if(positionwouldtelefrag(startpoints[i])) {
      continue;
    }
    if(largestcount < wheelcounts[i]) {
      largestcount = wheelcounts[i];
      largestcountindex = i;
    }
    if(wheelcounts[i] >= 3) {
      testcheck[i] = 1;
      if(testspawnorigin(startpoints[i], startangles[i])) {
        placement = spawnStruct();
        placement.origin = startpoints[i];
        placement.angles = startangles[i];
        return placement;
      }
    }
  }
  for(i = 0; i < testangles.size; i++) {
    if(!testcheck[i]) {
      if(wheelcounts[i] >= 2) {
        if(testspawnorigin(startpoints[i], startangles[i])) {
          placement = spawnStruct();
          placement.origin = startpoints[i];
          placement.angles = startangles[i];
          return placement;
        }
      }
    }
  }
  return undefined;
}

function testwheellocations(origin, angles, heightoffset) {
  forward = 13;
  side = 10;
  wheels = [];
  wheels[0] = (forward, side, 0);
  wheels[1] = (forward, -1 * side, 0);
  wheels[2] = (-1 * forward, -1 * side, 0);
  wheels[3] = (-1 * forward, side, 0);
  height = 5;
  touchcount = 0;
  yawangles = (0, angles[1], 0);
  for(i = 0; i < 4; i++) {
    wheel = rotatepoint(wheels[i], yawangles);
    startpoint = origin + wheel;
    endpoint = startpoint + (0, 0, -1 * height - heightoffset);
    startpoint = startpoint + (0, 0, height - heightoffset);
    trace = bulletTrace(startpoint, endpoint, 0, self);
    if(trace["fraction"] < 1) {
      touchcount++;
    }
  }
  return touchcount;
}

function testspawnorigin(origin, angles) {
  liftedorigin = origin + vectorscale((0, 0, 1), 5);
  size = 12;
  height = 15;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  absmins = liftedorigin + mins;
  absmaxs = liftedorigin + maxs;
  if(boundswouldtelefrag(absmins, absmaxs)) {
    return false;
  }
  startheight = getplacementstartheight();
  mask = (1 | 2) | 4;
  trace = physicstrace(liftedorigin, origin + (0, 0, 1), mins, maxs, self, mask);
  if(trace["fraction"] < 1) {
    return false;
  }
  size = 2.5;
  height = size * 2;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  sweeptrace = physicstrace(self.origin + (0, 0, startheight), liftedorigin, mins, maxs, self, mask);
  if(sweeptrace["fraction"] < 1) {
    return false;
  }
  return true;
}