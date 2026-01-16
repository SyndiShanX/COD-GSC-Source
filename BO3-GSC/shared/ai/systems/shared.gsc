/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\shared.gsc
*************************************************/

#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\init;
#using scripts\shared\ai\systems\weaponlist;
#using scripts\shared\ai_shared;
#using scripts\shared\math_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\throttle_shared;
#using scripts\shared\util_shared;
#using_animtree("generic");
#namespace shared;

function autoexec main() {
  level.ai_weapon_throttle = new throttle();
  [[level.ai_weapon_throttle]] - > initialize(1, 0.1);
}

function private _throwstowedweapon(entity, weapon, weaponmodel) {
  entity waittill("death");
  if(isdefined(entity)) {
    weaponmodel unlink();
    entity throwweapon(weapon, gettagforpos("back"), 0);
  }
  weaponmodel delete();
}

function stowweapon(weapon, positionoffset, orientationoffset) {
  entity = self;
  if(!isdefined(positionoffset)) {
    positionoffset = (0, 0, 0);
  }
  if(!isdefined(orientationoffset)) {
    orientationoffset = (0, 0, 0);
  }
  weaponmodel = spawn("script_model", (0, 0, 0));
  weaponmodel setmodel(weapon.worldmodel);
  weaponmodel linkto(entity, "tag_stowed_back", positionoffset, orientationoffset);
  entity thread _throwstowedweapon(entity, weapon, weaponmodel);
}

function placeweaponon(weapon, position) {
  self notify("weapon_position_change");
  if(isstring(weapon)) {
    weapon = getweapon(weapon);
  }
  if(!isdefined(self.weaponinfo[weapon.name])) {
    self init::initweapon(weapon);
  }
  curposition = self.weaponinfo[weapon.name].position;
  assert(curposition == "" || self.a.weaponpos[curposition] == weapon);
  if(!isarray(self.a.weaponpos)) {
    self.a.weaponpos = [];
  }
  assert(isarray(self.a.weaponpos));
  assert(position == "" || isdefined(self.a.weaponpos[position]), ("" + position) + "");
  assert(isweapon(weapon));
  if(position != "none" && self.a.weaponpos[position] == weapon) {
    return;
  }
  self detachallweaponmodels();
  if(curposition != "none") {
    self detachweapon(weapon);
  }
  if(position == "none") {
    self updateattachedweaponmodels();
    self aiutility::setcurrentweapon(level.weaponnone);
    return;
  }
  if(self.a.weaponpos[position] != level.weaponnone) {
    self detachweapon(self.a.weaponpos[position]);
  }
  if(position == "left" || position == "right") {
    self updatescriptweaponinfoandpos(weapon, position);
    self aiutility::setcurrentweapon(weapon);
  } else {
    self updatescriptweaponinfoandpos(weapon, position);
  }
  self updateattachedweaponmodels();
  assert(self.a.weaponpos[""] == level.weaponnone || self.a.weaponpos[""] == level.weaponnone);
}

function detachweapon(weapon) {
  self.a.weaponpos[self.weaponinfo[weapon.name].position] = level.weaponnone;
  self.weaponinfo[weapon.name].position = "none";
}

function updatescriptweaponinfoandpos(weapon, position) {
  self.weaponinfo[weapon.name].position = position;
  self.a.weaponpos[position] = weapon;
}

function detachallweaponmodels() {
  if(isdefined(self.weapon_positions)) {
    for (index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponpos[self.weapon_positions[index]];
      if(weapon == level.weaponnone) {
        continue;
      }
      self setactorweapon(level.weaponnone, self getactorweaponoptions());
    }
  }
}

function updateattachedweaponmodels() {
  if(isdefined(self.weapon_positions)) {
    for (index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponpos[self.weapon_positions[index]];
      if(weapon == level.weaponnone) {
        continue;
      }
      if(self.weapon_positions[index] != "right") {
        continue;
      }
      self setactorweapon(weapon, self getactorweaponoptions());
      if(self.weaponinfo[weapon.name].useclip && !self.weaponinfo[weapon.name].hasclip) {
        self hidepart("tag_clip");
      }
    }
  }
}

function gettagforpos(position) {
  switch (position) {
    case "chest": {
      return "tag_weapon_chest";
    }
    case "back": {
      return "tag_stowed_back";
    }
    case "left": {
      return "tag_weapon_left";
    }
    case "right": {
      return "tag_weapon_right";
    }
    case "hand": {
      return "tag_inhand";
    }
    default: {
      assertmsg("" + position);
      break;
    }
  }
}

function throwweapon(weapon, positiontag, scavenger) {
  waittime = 0.1;
  linearscalar = 2;
  angularscalar = 10;
  startposition = self gettagorigin(positiontag);
  startangles = self gettagangles(positiontag);
  wait(waittime);
  if(isdefined(self)) {
    endposition = self gettagorigin(positiontag);
    endangles = self gettagangles(positiontag);
    linearvelocity = (endposition - startposition) * (1 / waittime) * linearscalar;
    angularvelocity = (vectornormalize(endangles - startangles)) * angularscalar;
    throwweapon = self dropweapon(weapon, positiontag, linearvelocity, angularvelocity, scavenger);
    if(isdefined(throwweapon)) {
      throwweapon setcontents(throwweapon setcontents(0) & (~(((32768 | 67108864) | 8388608) | 33554432)));
    }
    return throwweapon;
  }
}

function dropaiweapon() {
  self endon("death");
  if(self.weapon == level.weaponnone) {
    return;
  }
  if(isdefined(self.script_nodropsecondaryweapon) && self.script_nodropsecondaryweapon && self.weapon == self.initial_secondaryweapon) {
    println(("" + self.weapon.name) + "");
    return;
  }
  if(isdefined(self.script_nodropsidearm) && self.script_nodropsidearm && self.weapon == self.sidearm) {
    println(("" + self.weapon.name) + "");
    return;
  }
  [[level.ai_weapon_throttle]] - > waitinqueue(self);
  current_weapon = self.weapon;
  dropweaponname = player_weapon_drop(current_weapon);
  position = self.weaponinfo[current_weapon.name].position;
  shoulddropweapon = !isdefined(self.dontdropweapon) || self.dontdropweapon === 0;
  if(current_weapon.isscavengable == 0) {
    shoulddropweapon = 0;
  }
  if(shoulddropweapon && self.dropweapon) {
    self.dontdropweapon = 1;
    positiontag = gettagforpos(position);
    throwweapon(dropweaponname, positiontag, 0);
  }
  if(self.weapon != level.weaponnone) {
    placeweaponon(current_weapon, "none");
    if(self.weapon == self.primaryweapon) {
      self aiutility::setprimaryweapon(level.weaponnone);
    } else if(self.weapon == self.secondaryweapon) {
      self aiutility::setsecondaryweapon(level.weaponnone);
    }
  }
  self aiutility::setcurrentweapon(level.weaponnone);
}

function dropallaiweapons() {
  if(isdefined(self.a.dropping_weapons) && self.a.dropping_weapons) {
    return;
  }
  if(!self.dropweapon) {
    if(self.weapon != level.weaponnone) {
      placeweaponon(self.weapon, "none");
      self aiutility::setcurrentweapon(level.weaponnone);
    }
    return;
  }
  self.a.dropping_weapons = 1;
  self detachallweaponmodels();
  droppedsidearm = 0;
  if(isdefined(self.weapon_positions)) {
    for (index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponpos[self.weapon_positions[index]];
      if(weapon != level.weaponnone) {
        self.weaponinfo[weapon.name].position = "none";
        self.a.weaponpos[self.weapon_positions[index]] = level.weaponnone;
        if(isdefined(self.script_nodropsecondaryweapon) && self.script_nodropsecondaryweapon && weapon == self.initial_secondaryweapon) {
          println(("" + weapon.name) + "");
          continue;
        }
        if(isdefined(self.script_nodropsidearm) && self.script_nodropsidearm && weapon == self.sidearm) {
          println(("" + weapon.name) + "");
          continue;
        }
        velocity = self getvelocity();
        speed = length(velocity) * 0.5;
        weapon = player_weapon_drop(weapon);
        droppedweapon = self dropweapon(weapon, self.weapon_positions[index], speed);
        if(self.sidearm != level.weaponnone) {
          if(weapon == self.sidearm) {
            droppedsidearm = 1;
          }
        }
      }
    }
  }
  if(!droppedsidearm && self.sidearm != level.weaponnone) {
    if(randomint(100) <= 10) {
      velocity = self getvelocity();
      speed = length(velocity) * 0.5;
      droppedweapon = self dropweapon(self.sidearm, "chest", speed);
    }
  }
  self aiutility::setcurrentweapon(level.weaponnone);
  self.a.dropping_weapons = undefined;
}

function player_weapon_drop(weapon) {
  if(issubstr(weapon.name, "rpg")) {
    return getweapon("rpg_player");
  }
  return weapon;
}

function handlenotetrack(note, flagname, customfunction, var1) {}

function donotetracks(flagname, customfunction, debugidentifier, var1) {
  for (;;) {
    self waittill(flagname, note);
    if(!isdefined(note)) {
      note = "undefined";
    }
    val = self handlenotetrack(note, flagname, customfunction, var1);
    if(isdefined(val)) {
      return val;
    }
  }
}

function donotetracksintercept(flagname, interceptfunction, debugidentifier) {
  assert(isdefined(interceptfunction));
  for (;;) {
    self waittill(flagname, note);
    if(!isdefined(note)) {
      note = "undefined";
    }
    intercepted = [
      [interceptfunction]
    ](note);
    if(isdefined(intercepted) && intercepted) {
      continue;
    }
    val = self handlenotetrack(note, flagname);
    if(isdefined(val)) {
      return val;
    }
  }
}

function donotetrackspostcallback(flagname, postfunction) {
  assert(isdefined(postfunction));
  for (;;) {
    self waittill(flagname, note);
    if(!isdefined(note)) {
      note = "undefined";
    }
    val = self handlenotetrack(note, flagname);
    [
      [postfunction]
    ](note);
    if(isdefined(val)) {
      return val;
    }
  }
}

function donotetracksforever(flagname, killstring, customfunction, debugidentifier) {
  donotetracksforeverproc( & donotetracks, flagname, killstring, customfunction, debugidentifier);
}

function donotetracksforeverintercept(flagname, killstring, interceptfunction, debugidentifier) {
  donotetracksforeverproc( & donotetracksintercept, flagname, killstring, interceptfunction, debugidentifier);
}

function donotetracksforeverproc(notetracksfunc, flagname, killstring, customfunction, debugidentifier) {
  if(isdefined(killstring)) {
    self endon(killstring);
  }
  self endon("killanimscript");
  if(!isdefined(debugidentifier)) {
    debugidentifier = "undefined";
  }
  for (;;) {
    time = gettime();
    returnednote = [
      [notetracksfunc]
    ](flagname, customfunction, debugidentifier);
    timetaken = gettime() - time;
    if(timetaken < 0.05) {
      time = gettime();
      returnednote = [
        [notetracksfunc]
      ](flagname, customfunction, debugidentifier);
      timetaken = gettime() - time;
      if(timetaken < 0.05) {
        println(((((((gettime() + "") + debugidentifier) + "") + flagname) + "") + returnednote) + "");
        wait(0.05 - timetaken);
      }
    }
  }
}

function donotetracksfortime(time, flagname, customfunction, debugidentifier) {
  ent = spawnstruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc( & donotetracksforever, time, flagname, customfunction, debugidentifier, ent);
}

function donotetracksfortimeintercept(time, flagname, interceptfunction, debugidentifier) {
  ent = spawnstruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc( & donotetracksforeverintercept, time, flagname, interceptfunction, debugidentifier, ent);
}

function donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, debugidentifier, ent) {
  ent endon("stop_notetracks");
  [[donotetracksforeverfunc]](flagname, undefined, customfunction, debugidentifier);
}

function donotetracksfortimeendnotify(time) {
  wait(time);
  self notify("stop_notetracks");
}