/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\killstreaks_util.gsc
***********************************************/

#using scripts\abilities\ability_util;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace killstreaks;

function switch_to_last_non_killstreak_weapon(immediate, awayfromball, gameended) {
  if(self.sessionstate === "disconnected") {
    return 0;
  }

  ball = getweapon(#"ball");

  if(isDefined(ball) && self hasweapon(ball) && !is_true(awayfromball)) {
    self switchtoweaponimmediate(ball);
    self disableweaponcycling();
    self disableoffhandweapons();
  } else if(is_true(self.laststand)) {
    if(isDefined(self.laststandpistol) && self hasweapon(self.laststandpistol)) {
      self switchtoweapon(self.laststandpistol);
    }
  } else if(isDefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon) && self getcurrentweapon() != self.lastnonkillstreakweapon) {
    if(ability_util::is_hero_weapon(self.lastnonkillstreakweapon)) {
      if(self.lastnonkillstreakweapon.gadget_heroversion_2_0) {
        if(self.lastnonkillstreakweapon.isgadget && self getammocount(self.lastnonkillstreakweapon) > 0) {
          slot = self gadgetgetslot(self.lastnonkillstreakweapon);

          if(self util::gadget_is_in_use(slot)) {
            return self switchtoweapon(self.lastnonkillstreakweapon);
          } else {
            return 1;
          }
        }
      } else if(self getammocount(self.lastnonkillstreakweapon) > 0) {
        return self switchtoweapon(self.lastnonkillstreakweapon);
      }

      if(is_true(awayfromball) && isDefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
        self switchtoweapon(self.lastdroppableweapon);
      } else {
        self switchtoweapon();
      }

      return 1;
    } else if(is_true(immediate)) {
      self switchtoweaponimmediate(self.lastnonkillstreakweapon, is_true(gameended));
    } else {
      self switchtoweapon(self.lastnonkillstreakweapon);
    }
  } else if(isDefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon) && self getcurrentweapon() != self.lastdroppableweapon) {
    self switchtoweapon(self.lastdroppableweapon);
  } else {
    return 0;
  }

  return 1;
}

function hasuav(team_or_entnum) {
  if(!isDefined(level.activeuavs)) {
    return true;
  }

  if(!isDefined(level.activeuavs[team_or_entnum])) {
    return false;
  }

  return level.activeuavs[team_or_entnum] > 0;
}

function hassatellite(team_or_entnum) {
  if(!isDefined(level.activesatellites)) {
    return true;
  }

  return level.activesatellites[team_or_entnum] > 0;
}

function function_f479a2ff(weapon) {
  if(isDefined(level.var_3ff1b984) && isDefined(level.var_3ff1b984[weapon])) {
    return true;
  }

  return false;
}

function function_e3a30c69(weapon) {
  assert(isDefined(isDefined(level.killstreakweapons[weapon])));
  killstreak = level.killstreaks[level.killstreakweapons[weapon]];
  return isDefined(killstreak.script_bundle.var_a82b593f) ? killstreak.script_bundle.var_a82b593f : 0;
}

function is_killstreak_weapon(weapon) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(weapon == level.weaponnone || weapon.notkillstreak) {
    return false;
  }

  if(weapon.isspecificuse || is_weapon_associated_with_killstreak(weapon)) {
    return true;
  }

  return false;
}

function get_killstreak_weapon(killstreak) {
  if(!isDefined(killstreak)) {
    return level.weaponnone;
  }

  assert(isDefined(level.killstreaks[killstreak]));
  return level.killstreaks[killstreak].weapon;
}

function function_c5927b3f(weapon) {
  return isDefined(level.var_b1dfdc3b[weapon]);
}

function is_weapon_associated_with_killstreak(weapon) {
  return isDefined(level.killstreakweapons[weapon]);
}

function function_4a1fb0f() {
  onkillstreak = 0;

  if(!isDefined(self.pers[# "kill_streak_before_death"])) {
    self.pers[# "kill_streak_before_death"] = 0;
  }

  streakplusone = self.pers[# "kill_streak_before_death"] + 1;

  if(self.pers[# "kill_streak_before_death"] >= 5) {
    onkillstreak = 1;
  }

  return onkillstreak;
}

function get_killstreak_team_kill_penalty_scale(weapon) {
  killstreak = get_killstreak_for_weapon(weapon);

  if(!isDefined(killstreak)) {
    return 1;
  }

  return isDefined(level.killstreaks[killstreak].teamkillpenaltyscale) ? level.killstreaks[killstreak].teamkillpenaltyscale : 1;
}

function get_killstreak_for_weapon(weapon) {
  if(!isDefined(level.killstreakweapons)) {
    return undefined;
  }

  if(isDefined(level.killstreakweapons[weapon])) {
    return level.killstreakweapons[weapon];
  }

  return level.killstreakweapons[weapon.rootweapon];
}

function function_73b4659(killstreak) {
  if(isDefined(killstreak)) {
    prefix = "inventory_";

    if(strstartswith(killstreak, prefix)) {
      killstreak = getsubstr(killstreak, prefix.size);
    }
  }

  return killstreak;
}

function get_killstreak_for_weapon_for_stats(weapon) {
  killstreak = get_killstreak_for_weapon(weapon);
  return function_73b4659(killstreak);
}

function function_a2c375bb(killstreaktype) {
  if(!isDefined(killstreaktype)) {
    return undefined;
  }

  if(self.usingkillstreakfrominventory === 1) {
    return 3;
  }

  killstreak_weapon = get_killstreak_weapon(killstreaktype);
  keys = getarraykeys(self.killstreak);

  foreach(key in keys) {
    if(self.killstreak[key] === killstreak_weapon.rootweapon.name) {
      return key;
    }
  }

  return undefined;
}

function function_fde227c6(weapon, stat_weapon) {
  assert(weapon.iscarriedkillstreak);
  assert(stat_weapon.iscarriedkillstreak);

  if(weapon.var_6f41c2a9) {
    assert(isDefined(level.var_6110cb51[stat_weapon]));
    assert(level.var_6110cb51[stat_weapon] != level.weaponnone);
    return level.var_6110cb51[stat_weapon];
  }

  return stat_weapon;
}

function function_fa6e0467(weapon) {
  if(weapon.iscliponly) {
    self setweaponammoclip(weapon, self.pers[# "held_killstreak_ammo_count"][weapon]);
    return;
  }

  self setweaponammoclip(weapon, self.pers[# "held_killstreak_clip_count"][weapon]);
  self setweaponammostock(weapon, self.pers[# "held_killstreak_ammo_count"][weapon] - self.pers[# "held_killstreak_clip_count"][weapon]);
}

function function_43f4782d() {
  airsupport_height = struct::get("air_support_height", "targetname");

  if(isDefined(airsupport_height)) {
    height = airsupport_height.origin[2];
  } else {
    println("<dev string:x38>");
    height = 1000;

    if(isDefined(level.mapcenter)) {
      height += level.mapcenter[2];
    }
  }

  return height;
}

function private function_a021023d(rotator, angle, radius, var_b468418b, var_93e44bb3, roll) {
  radiusoffset = radius + (var_b468418b == 0 ? 0 : randomint(var_b468418b));
  xoffset = cos(angle) * radiusoffset;
  yoffset = sin(angle) * radiusoffset;
  anglevector = vectornormalize((xoffset, yoffset, 0));
  anglevector *= radius;
  anglevector = (anglevector[0], anglevector[1], 0);
  angle_offset = 90 * (var_93e44bb3 > 0 ? 1 : -1);
  self linkto(rotator, "tag_origin", anglevector, (0, angle + angle_offset, roll));
}

function function_67d553c4(rotator, radius, var_b468418b, var_93e44bb3, roll = 0) {
  angle = randomint(360);
  self function_a021023d(rotator, angle, radius, var_b468418b, var_93e44bb3, roll);
}

function function_d7123898(rotator, var_4fb9010a, var_93e44bb3, roll = 0) {
  originoffset = (var_4fb9010a[0], var_4fb9010a[1], rotator.origin[2]) - rotator.origin;
  angle = vectortoangles(originoffset)[1] - rotator.angles[1];
  radius = length(originoffset);
  self function_a021023d(rotator, angle, radius, 0, var_93e44bb3, roll);
}

function function_f3875fb0(var_d22c85cf, height_offset, var_b6417305, var_93e44bb3, var_e690ed4e = 0) {
  height = int(function_43f4782d()) + height_offset;
  var_564cfb64 = (isDefined(var_d22c85cf[0]) ? var_d22c85cf[0] : level.mapcenter[0], isDefined(var_d22c85cf[1]) ? var_d22c85cf[1] : level.mapcenter[1], height);
  rotator = spawn("script_model", var_564cfb64);
  rotator setModel(#"tag_origin");
  rotator.angles = (0, 115, 0);
  rotator hide();
  rotator thread function_1ddb2653(var_b6417305, var_93e44bb3);

  if(var_e690ed4e) {
    rotator thread function_8294e9b3();
  }

  rotator setforcenocull();
  return rotator;
}

function function_1ddb2653(seconds, direction) {
  self endon(#"death");

  for(;;) {
    self rotateyaw(360 * (direction > 0 ? 1 : -1), seconds);
    wait seconds;
  }
}

function function_8294e9b3() {
  self endon(#"death");
  centerorigin = self.origin;

  for(;;) {
    z = randomintrange(-200, -100);
    time = randomintrange(3, 6);
    self moveto(centerorigin + (0, 0, z), time, 1, 1);
    wait time;
    z = randomintrange(100, 200);
    time = randomintrange(3, 6);
    self moveto(centerorigin + (0, 0, z), time, 1, 1);
    wait time;
  }
}

function function_5a7ecb6b(var_56422be = 0.01) {
  self endon(#"death");
  scale = 0.1;
  scalestep = 0.1;

  while(scale < 1) {
    self setscale(scale);
    waitframe(1);
    scale += scalestep;

    if(scalestep > var_56422be + 0.01) {
      scalestep -= var_56422be;
    }
  }

  self setscale(1);
}

function outro_scaling(var_56422be = 0.001) {
  self endon(#"death");

  if(target_istarget(self)) {
    target_remove(self);
  }

  if(issentient(self)) {
    self function_60d50ea4();
  }

  scale = 0.99;
  scalestep = 0.01;

  while(scale > 0.01) {
    self setscale(scale);
    waitframe(1);
    scale -= scalestep;

    if(scalestep < 0.1) {
      scalestep += var_56422be;
    }
  }

  self hide();
}

function function_e729ccee(attacker, weapon) {
  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  killstreaktype = get_killstreak_for_weapon(weapon);

  if(isDefined(killstreaktype) && (killstreaktype == "planemortar" || killstreaktype == "remote_missile" || killstreaktype == "straferun")) {
    attacker.(killstreaktype + "_hitconfirmed") = 1;
  }
}

function function_47b44bcc(attacker, weapon, aircraft) {
  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  killstreaktype = get_killstreak_for_weapon(weapon);

  if(isDefined(killstreaktype) && (killstreaktype == "planemortar" || killstreaktype == "remote_missile" || killstreaktype == "straferun")) {
    if(aircraft === 1) {
      attacker.(killstreaktype + "_killAircraft") = 1;
      return;
    }

    attacker.(killstreaktype + "_killGroundVehicle") = 1;
  }
}

function function_59e2c378() {
  if(is_true(level.var_e80a117f) && self arecontrolsfrozen()) {
    return false;
  }

  return true;
}

function function_eb52ba7(killstreaktype, team, killstreak_id) {
  var_88dc634d = hash(killstreaktype);

  if(isDefined(self.var_9fa3bd36[killstreak_id]) || isDefined(self.var_63fa6458[var_88dc634d])) {
    return;
  }

  session = {
    #spawnid: getplayerspawnid(self), #name: var_88dc634d, #starttime: function_f8d53445(), #endtime: 0, #team: team, #kills: 0, #var_e72137e8: # "streak_ended", #var_6e1d768e: # ""};
  weapon = get_killstreak_weapon(killstreaktype);

  if(weapon.iscarriedkillstreak === 1) {
    if(!isDefined(self.var_63fa6458)) {
      self.var_63fa6458 = [];
    }

    self.var_63fa6458[var_88dc634d] = session;
    return;
  }

  if(!isDefined(self.var_9fa3bd36)) {
    self.var_9fa3bd36 = [];
  }

  self.var_9fa3bd36[killstreak_id] = session;
}

function function_fda235cf(killstreaktype, killstreak_id, var_e72137e8) {
  var_571c684 = function_73b4659(killstreaktype);

  if(isDefined(level.var_11e725c2[var_571c684])) {
    var_4fbb4b53 = level.var_11e725c2[var_571c684];
  } else {
    var_4fbb4b53 = &function_79e49b15;
  }

  params = {
    #killstreaktype: var_571c684, #killstreak_id: killstreak_id, #var_e72137e8: var_e72137e8
  };
  [[var_4fbb4b53]](params);
}

function function_79e49b15(params) {
  killstreaktype = params.killstreaktype;
  killstreak_id = params.killstreak_id;
  var_e72137e8 = params.var_e72137e8;
  weapon = get_killstreak_weapon(killstreaktype);

  if(weapon.iscarriedkillstreak === 1) {
    var_88dc634d = hash(killstreaktype);

    if(isDefined(self.var_63fa6458[var_88dc634d])) {
      self.var_63fa6458[var_88dc634d].endtime = function_f8d53445();
      self.var_63fa6458[var_88dc634d].var_e72137e8 = isDefined(var_e72137e8) ? var_e72137e8 : self.var_63fa6458[var_88dc634d].var_e72137e8;
      var_8756d70f = function_16a1f9b6();
      self function_678f57c8(var_8756d70f, self.var_63fa6458[var_88dc634d]);
      self.var_63fa6458[var_88dc634d] = undefined;
    }

    return;
  }

  if(isDefined(self.var_9fa3bd36[killstreak_id])) {
    self.var_9fa3bd36[killstreak_id].endtime = function_f8d53445();
    self.var_9fa3bd36[killstreak_id].var_e72137e8 = isDefined(var_e72137e8) ? var_e72137e8 : self.var_9fa3bd36[killstreak_id].var_e72137e8;
    var_8756d70f = function_16a1f9b6();
    self function_678f57c8(var_8756d70f, self.var_9fa3bd36[killstreak_id]);
    self.var_9fa3bd36[killstreak_id] = undefined;
  }
}

function function_ef1303ba(end_time, var_e72137e8) {
  if(isDefined(self.var_63fa6458)) {
    foreach(session in self.var_63fa6458) {
      session.endtime = end_time;
      session.var_e72137e8 = isDefined(var_e72137e8) ? var_e72137e8 : session.var_e72137e8;
      var_8756d70f = function_16a1f9b6();
      self function_678f57c8(var_8756d70f, session);
    }

    self.var_63fa6458 = [];
  }

  if(isDefined(self.var_9fa3bd36)) {
    foreach(session in self.var_9fa3bd36) {
      session.endtime = end_time;
      session.var_e72137e8 = isDefined(var_e72137e8) ? var_e72137e8 : session.var_e72137e8;
      var_8756d70f = function_16a1f9b6();
      self function_678f57c8(var_8756d70f, session);
    }

    self.var_9fa3bd36 = [];
  }
}

function function_16a1f9b6() {
  if(sessionmodeiszombiesgame()) {
    var_8756d70f = # "hash_5c02726a4663b7dd";
  } else {
    var_8756d70f = # "hash_25d8f7d855b13f45";
  }

  return var_8756d70f;
}

function function_cb0594d5() {
  if(sessionmodeiszombiesgame()) {
    var_8756d70f = # "hash_45468d6066fbc34e";
  } else {
    var_8756d70f = # "hash_710b205b26e46446";
  }

  return var_8756d70f;
}

function function_e9873ef7(killstreaktype, killstreak_id, var_e72137e8) {
  weapon = get_killstreak_weapon(killstreaktype);

  if(weapon.iscarriedkillstreak === 1) {
    var_88dc634d = hash(killstreaktype);

    if(isDefined(self.var_63fa6458[var_88dc634d])) {
      self.var_63fa6458[var_88dc634d].var_e72137e8 = isDefined(var_e72137e8) ? var_e72137e8 : self.var_63fa6458[var_88dc634d].var_e72137e8;
    }

    return;
  }

  if(isDefined(self.var_9fa3bd36[killstreak_id])) {
    self.var_9fa3bd36[killstreak_id].var_e72137e8 = isDefined(var_e72137e8) ? var_e72137e8 : self.var_9fa3bd36[killstreak_id].var_e72137e8;
  }
}

function function_4aad9803(killstreaktype, killstreak_id, var_6e1d768e) {
  if(!isDefined(var_6e1d768e)) {
    return;
  }

  weapon = get_killstreak_weapon(killstreaktype);

  if(weapon.iscarriedkillstreak === 1) {
    var_88dc634d = hash(killstreaktype);

    if(isDefined(self.var_63fa6458[var_88dc634d])) {
      self.var_63fa6458[var_88dc634d].var_6e1d768e = var_6e1d768e.name;
    }

    return;
  }

  if(isDefined(self.var_9fa3bd36[killstreak_id])) {
    self.var_9fa3bd36[killstreak_id].var_6e1d768e = var_6e1d768e.name;
  }
}

function function_1e016087(killstreaktype, callback_function) {
  if(!isDefined(level.var_11e725c2)) {
    level.var_11e725c2 = [];
  }

  level.var_11e725c2[killstreaktype] = callback_function;
}