/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\shared.gsc
***********************************************/

#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\init;
#using scripts\core_common\throttle_shared;
#using scripts\weapons\weapons;
#namespace shared;

function autoexec main() {
  if(!isDefined(level.ai_weapon_throttle)) {
    level.ai_weapon_throttle = new throttle();
    [[level.ai_weapon_throttle]] - > initialize(1, 0.1);
  }
}

function private _throwstowedweapon(entity, weapon, weaponmodel) {
  entity waittill(#"death");

  if(isDefined(entity)) {
    weaponmodel unlink();
    entity throwweapon(weapon, gettagforpos("back"), 0, 0);
  }

  weaponmodel delete();
}

function stowweapon(weapon, positionoffset, orientationoffset) {
  entity = self;

  if(!isDefined(positionoffset)) {
    positionoffset = (0, 0, 0);
  }

  if(!isDefined(orientationoffset)) {
    orientationoffset = (0, 0, 0);
  }

  weaponmodel = spawn("script_model", (0, 0, 0));
  weaponmodel setModel(weapon.worldmodel);
  weaponmodel linkto(entity, "tag_stowed_back", positionoffset, orientationoffset);
  entity thread _throwstowedweapon(entity, weapon, weaponmodel);
}

function placeweaponon(weapon, position) {
  self notify(#"weapon_position_change");

  if(isstring(weapon) || ishash(weapon)) {
    weapon = getweapon(weapon);
  }

  if(!isDefined(self.weaponinfo[weapon.name])) {
    self init::initweapon(weapon);
  }

  curposition = self.weaponinfo[weapon.name].position;
  assert(curposition == "<dev string:x38>" || self.a.weaponpos[curposition] == weapon);

  if(!isarray(self.a.weaponpos)) {
    self.a.weaponpos = [];
  }

  assert(isarray(self.a.weaponpos));
  assert(position == "<dev string:x38>" || isDefined(self.a.weaponpos[position]), "<dev string:x40>" + position + "<dev string:x55>");
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
  assert(self.a.weaponpos[#"left"] == level.weaponnone || self.a.weaponpos[#"right"] == level.weaponnone);
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
  if(isDefined(self.weapon_positions)) {
    for(index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponpos[self.weapon_positions[index]];

      if(weapon == level.weaponnone) {
        continue;
      }

      self setactorweapon(level.weaponnone, self getactorweaponoptions(), self function_6a055ef4());
    }
  }
}

function updateattachedweaponmodels() {
  if(isDefined(self.weapon_positions)) {
    for(index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponpos[self.weapon_positions[index]];

      if(weapon == level.weaponnone) {
        continue;
      }

      if(self.weapon_positions[index] != "right") {
        continue;
      }

      self setactorweapon(weapon, self getactorweaponoptions(), self function_6a055ef4());

      if(self.weaponinfo[weapon.name].useclip && !self.weaponinfo[weapon.name].hasclip) {
        self hidepart("tag_clip");
      }
    }
  }
}

function gettagforpos(position) {
  switch (position) {
    case # "chest":
      return "tag_weapon_chest";
    case # "back":
      return "tag_stowed_back";
    case # "left":
      return "tag_weapon_left";
    case # "right":
      return "tag_weapon_right";
    case # "hand":
      return "tag_inhand";
    default:
      assertmsg("<dev string:x5a>" + position);
      break;
  }
}

function function_403d795c() {
  self endon(#"death");
  self waittilltimeout(3, #"stationary");

  if(isDefined(self)) {
    self delete();
  }
}

function throwweapon(weapon, positiontag, scavenger, deleteweaponafterdropping) {
  if(!getdvarint(#"hash_6b1268d7e44b1a20", 0) && (positiontag == "tag_weapon_right" || positiontag == "tag_weapon_left")) {
    throwweapon = self dropweapon(weapon, positiontag);

    if(isDefined(throwweapon)) {
      self weapons::dropweaponfordeathlaunch(throwweapon, 50, self.angles, weapon, 0.5, 0.15);
    }

    if(deleteweaponafterdropping) {
      throwweapon thread function_403d795c();
      return;
    }

    return throwweapon;
  }

  waittime = 0.1;
  linearscalar = 2;
  angularscalar = 10;
  startposition = self gettagorigin(positiontag);
  startangles = self gettagangles(positiontag);

  if(!isDefined(startposition) || !isDefined(startangles)) {
    return;
  }

  wait waittime;

  if(isDefined(self)) {
    endposition = self gettagorigin(positiontag);
    endangles = self gettagangles(positiontag);
    linearvelocity = (endposition - startposition) * 1 / waittime * linearscalar;
    angularvelocity = vectornormalize(endangles - startangles) * angularscalar;
    throwweapon = self dropweapon(weapon, positiontag, linearvelocity, angularvelocity, scavenger);

    if(isDefined(throwweapon)) {
      throwweapon setcontents(throwweapon setcontents(0) &~(32768 | 16777216 | 2097152 | 8388608));
    }

    if(deleteweaponafterdropping) {
      throwweapon delete();
      return;
    }

    return throwweapon;
  }
}

function dropaiweapon() {
  self endon(#"death");

  if(self.weapon == level.weaponnone) {
    return;
  }

  if(is_true(self.script_nodropsecondaryweapon) && self.weapon == self.initial_secondaryweapon) {
    println("<dev string:x81>" + self.weapon.name + "<dev string:xa4>");
    return;
  } else if(is_true(self.script_nodropsidearm) && self.weapon == self.sidearm) {
    println("<dev string:xa9>" + self.weapon.name + "<dev string:xa4>");
    return;
  }

  [[level.ai_weapon_throttle]] - > waitinqueue(self);
  current_weapon = self.weapon;
  dropweaponname = player_weapon_drop(current_weapon);
  position = "right";

  if(isDefined(self.weaponinfo[current_weapon.name])) {
    position = self.weaponinfo[current_weapon.name].position;
  }

  shoulddropweapon = !isDefined(self.dontdropweapon) || self.dontdropweapon === 0;
  shoulddeleteafterdropping = current_weapon == getweapon("riotshield");

  if(current_weapon.isscavengable == 0) {
    shoulddropweapon = 0;
  }

  if(shoulddropweapon && self.dropweapon) {
    self.dontdropweapon = 1;
    positiontag = gettagforpos(position);
    throwweapon(dropweaponname, positiontag, 0, shoulddeleteafterdropping);
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
  if(is_true(self.a.dropping_weapons)) {
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

  if(isDefined(self.weapon_positions)) {
    for(index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponpos[self.weapon_positions[index]];

      if(weapon != level.weaponnone) {
        self.weaponinfo[weapon.name].position = "none";
        self.a.weaponpos[self.weapon_positions[index]] = level.weaponnone;

        if(is_true(self.script_nodropsecondaryweapon) && weapon == self.initial_secondaryweapon) {
          println("<dev string:x81>" + weapon.name + "<dev string:xa4>");
          continue;
        }

        if(is_true(self.script_nodropsidearm) && weapon == self.sidearm) {
          println("<dev string:xa9>" + weapon.name + "<dev string:xa4>");
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
  return weapon;
}

function handlenotetrack(note, flagname, customfunction, var1) {}

function donotetracks(flagname, customfunction, debugidentifier, var1) {
  for(;;) {
    waitresult = self waittill(customfunction);
    note = waitresult.notetrack;

    if(!isDefined(note)) {
      note = "undefined";
    }

    val = self handlenotetrack(note, customfunction, debugidentifier, var1);

    if(isDefined(val)) {
      return val;
    }
  }
}

function donotetracksintercept(flagname, interceptfunction, debugidentifier) {
  assert(isDefined(debugidentifier));

  for(;;) {
    waitresult = self waittill(interceptfunction);
    note = waitresult.notetrack;

    if(!isDefined(note)) {
      note = "undefined";
    }

    intercepted = [[debugidentifier]](note);

    if(isDefined(intercepted) && intercepted) {
      continue;
    }

    val = self handlenotetrack(note, interceptfunction);

    if(isDefined(val)) {
      return val;
    }
  }
}

function donotetrackspostcallback(flagname, postfunction) {
  assert(isDefined(postfunction));

  for(;;) {
    waitresult = self waittill(flagname);
    note = waitresult.notetrack;

    if(!isDefined(note)) {
      note = "undefined";
    }

    val = self handlenotetrack(note, flagname);
    [[postfunction]](note);

    if(isDefined(val)) {
      return val;
    }
  }
}

function donotetracksforever(flagname, killstring, customfunction, debugidentifier) {
  donotetracksforeverproc(&donotetracks, flagname, killstring, customfunction, debugidentifier);
}

function donotetracksforeverintercept(flagname, killstring, interceptfunction, debugidentifier) {
  donotetracksforeverproc(&donotetracksintercept, flagname, killstring, interceptfunction, debugidentifier);
}

function donotetracksforeverproc(notetracksfunc, flagname, killstring, customfunction, debugidentifier) {
  if(isDefined(killstring)) {
    self endon(killstring);
  }

  self endon(#"killanimscript");

  if(!isDefined(debugidentifier)) {
    debugidentifier = "undefined";
  }

  for(;;) {
    time = gettime();
    returnednote = [[notetracksfunc]](flagname, customfunction, debugidentifier);
    timetaken = gettime() - time;

    if(timetaken < 0.05) {
      time = gettime();
      returnednote = [[notetracksfunc]](flagname, customfunction, debugidentifier);
      timetaken = gettime() - time;

      if(timetaken < 0.05) {
        println(gettime() + "<dev string:xc3>" + debugidentifier + "<dev string:xc8>" + flagname + "<dev string:x115>" + returnednote + "<dev string:x124>");
        wait 0.05 - timetaken;
      }
    }
  }
}

function donotetracksfortime(time, flagname, customfunction, debugidentifier) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(&donotetracksforever, time, flagname, customfunction, debugidentifier, ent);
}

function donotetracksfortimeintercept(time, flagname, interceptfunction, debugidentifier) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(&donotetracksforeverintercept, time, flagname, interceptfunction, debugidentifier, ent);
}

function donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, debugidentifier, ent) {
  ent endon(#"stop_notetracks");
  [[time]](flagname, undefined, customfunction, debugidentifier);
}

function donotetracksfortimeendnotify(time) {
  wait time;
  self notify(#"stop_notetracks");
}

function event_handler[event_39e29b54] function_d0b05b9e(eventstruct) {}