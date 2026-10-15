/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6833e29cc169fd4d.gsc
***********************************************/

#using script_6a0921d005260773;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;

#namespace namespace_8a67e6b6;

function function_a780da8() {
  self abilities::cybercom_initentityfields();

  if(!isDefined(self._abilities)) {
    self._abilities = spawnStruct();
  }

  if(!isDefined(self._abilities.lockon)) {
    self._abilities.lockon = spawnStruct();
  }

  if(!isDefined(self._abilities.lockon.lastlockedtargets)) {
    self._abilities.lockon.lastlockedtargets = [];
  }

  if(!isDefined(self._abilities.lockon.lock_targets)) {
    self._abilities.lockon.lock_targets = [];
  }

  if(!isDefined(self._abilities.lockon.fail_type)) {
    self._abilities.lockon.fail_type = 0;
  }
}

function weaponlockwatcher(slot, weapon, maxtargets, var_e08793c0, var_efb1ea62, var_8ff7e677) {
  function_a780da8();

  if(!isDefined(maxtargets)) {
    maxtargets = getdvarint(#"scr_max_simlocks", 3);
  }

  assert(maxtargets <= 5, "<dev string:x38>");
  self thread weaponlockwatchtargets(slot, weapon, maxtargets, var_e08793c0, var_efb1ea62, var_8ff7e677);
}

function weaponendlockwatcher(weapon) {
  self cybercomhintresults(weapon);
  waittillframeend();
  weapon_lock_clearslots(1);
  self weapon_notifylastlocks();
  self notify(#"ccom_stop_lock_on");
}

function _weaponabortwatcher(weapon) {
  self endon(#"death");
  self notify(#"weaponendlockwatcher");
  self endon(#"weaponendlockwatcher", #"ccom_stop_lock_on");
  waitresult = self waittill(#"gadget_forced_off");

  if(weapon == waitresult.weapon) {
    self weaponendlockwatcher(weapon);
    return;
  }

  self thread _weaponabortwatcher(weapon);
}

function private _lock_fired_watcher(weapon) {
  self endon(#"disconnect", #"death", #"ccom_stop_lock_on");
  self waittill(weapon.name + "_fired");
  level notify(#"ccom_lock_fired", {
    #owner: self, #weapon: weapon
  });

  foreach(item in self._abilities.lockon.lock_targets) {
    if(isDefined(item.target)) {
      item.target notify(#"ccom_lock_fired", {
        #owner: self, #weapon: weapon
      });

      if(isDefined(item.target.lockon_owner) && item.target.lockon_owner == self) {
        item.target.lockon_owner = undefined;
      }
    }
  }

  self weaponendlockwatcher(weapon);
}

function private _lock_sighttest(target, var_4f358117 = 1) {
  eyepos = self getEye();

  if(!isDefined(target)) {
    return 0;
  }

  if(!isalive(target)) {
    return 0;
  }

  if(target isragdoll()) {
    return 0;
  }

  if(!isDefined(target._abilities)) {
    target._abilities = spawnStruct();
  }

  if(!isDefined(target._abilities.lockon)) {
    target._abilities.lockon = spawnStruct();
  }

  if(!isDefined(target._abilities.lockon.sighttracetests)) {
    target._abilities.lockon.sighttracetests = [];
  }

  pos = target getshootatpos();

  if(isDefined(pos)) {
    passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);

    if(passed) {
      target._abilities.lockon.sighttracetests[self getentitynumber()] = gettime();
      return 1;
    }
  }

  pos = target getcentroid();

  if(isDefined(pos)) {
    passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);

    if(passed) {
      target._abilities.lockon.sighttracetests[self getentitynumber()] = gettime();
      return 1;
    }
  }

  if(var_4f358117) {
    mins = target getmins();
    maxs = target getmaxs();
    stepz = (maxs[2] - mins[2]) / 4;

    for(i = 0; i <= 4; i++) {
      pos = target.origin + (0, 0, stepz * i);
      passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);

      if(passed) {
        target._abilities.lockon.sighttracetests[self getentitynumber()] = gettime();
        return 1;
      }

      pos = target.origin + (mins[0], mins[1], stepz * i);
      passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);

      if(passed) {
        target._abilities.lockon.sighttracetests[self getentitynumber()] = gettime();
        return 1;
      }

      pos = target.origin + (maxs[0], maxs[1], stepz * i);
      passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);

      if(passed) {
        target._abilities.lockon.sighttracetests[self getentitynumber()] = gettime();
        return 1;
      }
    }

    lastseen = target._abilities.lockon.sighttracetests[self getentitynumber()];

    if(isDefined(lastseen) && lastseen + getdvarint(#"scr_los_latency", 3000) > gettime()) {
      trace = bulletTrace(eyepos, pos, 0, target);
      distsq = distancesquared(pos, trace[#"position"]);

      if(distsq <= getdvarint(#"scr_cached_dist_threshhold", sqr(315))) {
        return 2;
      } else {
        return 0;
      }
    }
  }

  return 0;
}

function targetisValid(target, weapon, lockreq = 1) {
  result = 1;

  if(!isDefined(target)) {
    return 0;
  }

  if(!isalive(target)) {
    return 0;
  }

  if(target isragdoll()) {
    return 0;
  }

  if(is_true(target.is_disabled)) {
    return 0;
  }

  if(!is_true(target.takedamage)) {
    return 0;
  }

  if(isDefined(target._ai_melee_opponent)) {
    return 0;
  }

  if(isactor(target) && (!target isonground() || isDefined(target.traversestartnode))) {
    return 0;
  }

  if(isDefined(target.cybercomtargetstatusoverride)) {
    if(target.cybercomtargetstatusoverride == 0) {
      return 0;
    }
  } else {
    if(is_true(target.magic_bullet_shield)) {
      return 0;
    }

    if(isactor(target) && target isinscriptedstate()) {
      return 0;
    }
  }

  if(lockreq && isDefined(self._abilities) && isDefined(self._abilities.lockon.targetlockrequirementcb)) {
    result = self[[self._abilities.lockon.targetlockrequirementcb]](target);
  }

  if(result && isDefined(level.cybercomtargetlockrequirementcb)) {
    result &= [[level.cybercomtargetlockrequirementcb]](self, target, weapon);
  }

  return result;
}

function weapon_lock_meetsrangerequirement(target, maxrange, weapon) {
  if(isDefined(weapon)) {
    distancesqr = distancesquared(maxrange.origin, self.origin);

    if(distancesqr > sqr(weapon)) {
      return false;
    }
  }

  return true;
}

function weapon_lock_meetsrequirement(target, radius, weapon, maxrange, var_efb1ea62) {
  result = 1;
  isvalid = self targetisValid(target, weapon);

  if(!is_true(isvalid)) {
    self cybercomsetfailhint(target, 1);
    return 0;
  }

  var_584c7fc2 = target[[var_efb1ea62]](self, weapon);

  if(!is_true(var_584c7fc2)) {
    self cybercomsetfailhint(target, 1);
    return 0;
  }

  if(isDefined(maxrange)) {
    distancesqr = distancesquared(target.origin, self.origin);

    if(distancesqr > sqr(maxrange)) {
      self cybercomsetfailhint(target, 3);
      return 0;
    }
  }

  losresult = self _lock_sighttest(target);

  if(losresult == 0) {
    self cybercomsetfailhint(target, 5);
    return 0;
  }

  if(losresult == 2) {
    radius *= 2;
  }

  if(isDefined(radius)) {
    distsq = distancesquared(self.origin, target.origin);

    if(distsq > sqr(144)) {
      result = target_isincircle(target, self, 65, radius);
    }
  }

  if(result == 0) {
    self cybercomsetfailhint(target, 1);
  }

  return result;
}

function function_568e9d1f(a, b) {
  return a.dot < b.dot;
}

function function_bb2cd3c1(target) {
  if(isDefined(target.lockon_owner) && target.lockon_owner == self) {
    ui_hackend(self);
    target.lockon_accumulator = gettime() - target.lockon_lockstart;
    target thread weapon_lock_decayaccumulator();
    target.lockon_lockstart = undefined;
    target.lockon_lockblock = gettime() + 150;
    target.lockon_owner = undefined;
    target.lockon_lockstart = undefined;
    target.lockon_progress = undefined;
    self notify(#"ui_hackwatchabort");
    self notify(#"ccom_lost_lock", {
      #target: target
    });
  }
}

function weapon_lock_clearslot(slot, note, clearprogress) {
  if(isDefined(self._abilities.lockon.lock_targets[slot])) {
    item = self._abilities.lockon.lock_targets[slot];

    if(isDefined(item.target)) {
      if(isDefined(note)) {
        item.target notify(note);
      }

      self weaponlocknoclearance(0, item.lockslot);
      self weaponlockremoveslot(item.lockslot);

      if(is_true(clearprogress)) {
        self function_bb2cd3c1(item.target);
      }

      item.target = undefined;
    }
  }
}

function private _weapon_lock_targetwatchfordeath(player) {
  self endon(#"ccom_lost_lock");
  self notify(#"_weapon_lock_targetwatchfordeath");
  self endon(#"_weapon_lock_targetwatchfordeath");
  slot = player weapon_lock_alreadylocked(self);
  self waittill(#"death", #"ccom_lock_fired", #"ccom_lock_aborted_unique");
  player weaponlocknoclearance(0, slot);
  player weaponlockremoveslot(slot);
}

function weapon_lock_settargettoslot(slot, target, maxrange, weapon, maxtargets) {
  if(slot == -1 || slot >= maxtargets) {
    return;
  }

  if(isDefined(target.lockon_lockblock) && gettime() < target.lockon_lockblock) {
    return;
  }

  if(isDefined(self._abilities.lockon.lock_targets[slot])) {
    self weapon_lock_clearslot(slot, "ccom_lost_lock");
    newitem = self._abilities.lockon.lock_targets[slot];
    newitem.target = target;
  } else {
    newitem = spawnStruct();
    newitem.target = target;
    newitem.lockslot = slot;
    self._abilities.lockon.lock_targets[slot] = newitem;
  }

  if(isDefined(newitem.target)) {
    if(isDefined(newitem.target.lockon_timeduration) && isDefined(newitem.target.lockon_timeduration[self._abilities.lockon.lastequipped.name])) {
      if(!isDefined(newitem.target.lockon_owner)) {
        newitem.target.lockon_lockstart = gettime() - newitem.target.lockon_accumulator;
        newitem.target.lockon_owner = self;
        newitem.target notify(#"ccom_lock_started");
        curstart = newitem.target.lockon_accumulator / newitem.target.lockon_timeduration[self._abilities.lockon.lastequipped.name] * 1000;
        ui_hackstart(self, newitem.target.lockon_timeduration[self._abilities.lockon.lastequipped.name], curstart);
        level thread ui_hackwatchabort(self);
      }

      if(isDefined(newitem.target.lockon_owner) && newitem.target.lockon_owner == self) {
        newitem.target.lockon_progress = math::clamp((gettime() - newitem.target.lockon_lockstart) / newitem.target.lockon_timeduration[self._abilities.lockon.lastequipped.name] * 1000, 0, 1);
      }
    }

    self weaponlockstart(newitem.target, newitem.lockslot);
    newitem.inrange = 1;

    if(!self weapon_lock_meetsrangerequirement(newitem.target, maxrange, weapon)) {
      newitem.inrange = 0;
      self weaponlocknoclearance(1, slot);
    }

    if(isDefined(newitem.target.lockon_progress)) {
      if(newitem.target.lockon_owner == self) {
        if(newitem.target.lockon_progress != 1) {
          newitem.inrange = 2;
          self weaponlocknoclearance(1, slot);
        }
      } else {
        newitem.inrange = 0;
        self weaponlocknoclearance(1, slot);
      }
    }

    if(newitem.inrange == 1) {
      ui_hackend(self);
      self weaponlocknoclearance(0, slot);
      self weaponlockfinalize(newitem.target, newitem.lockslot);
      newitem.target notify(#"ccom_locked_on", self);
      level notify(#"ccom_locked_on", newitem.target);
    } else {
      newitem.target notify(#"ccom_lock_being_targeted", {
        #hijacking_player: self
      });
      level notify(#"ccom_lock_being_targeted", {
        #target: newitem.target, #hijacking_player: self
      });
    }

    newitem.target thread _weapon_lock_targetwatchfordeath(self);
  }
}

function ui_hackstart(hacker, duration, startratio) {
  val = duration & 31;

  if(startratio > 0) {
    cur = math::clamp(startratio, 0, 1);
    offset = int(cur * 128) << 5;
    val += offset;
  }
}

function ui_hackend(hacker) {
  if(isDefined(hacker)) {}
}

function ui_hackwatchabort(hacker) {
  hacker endon(#"disconnect");
  hacker notify(#"ui_hackwatchabort");
  hacker endon(#"ui_hackwatchabort");
  hacker waittill(#"death", #"ccom_lockonprogress_cleared", #"ccom_lost_lock", #"ccom_locked_on");
  ui_hackend(hacker);
}

function weapon_lock_alreadylocked(target) {
  for(i = 0; i < self._abilities.lockon.lock_targets.size; i++) {
    if(!isDefined(self._abilities.lockon.lock_targets[i].target)) {
      continue;
    }

    if(self._abilities.lockon.lock_targets[i].target == target) {
      return i;
    }
  }

  return -1;
}

function weapon_lock_getlockedontargets() {
  targets = [];

  for(i = 0; i < self._abilities.lockon.lock_targets.size; i++) {
    if(!isDefined(self._abilities.lockon.lock_targets[i].target)) {
      continue;
    }

    targets[targets.size] = self._abilities.lockon.lock_targets[i].target;
  }

  return targets;
}

function weapon_lock_getslot(target, maxtargets) {
  if(self._abilities.lockon.lock_targets.size < maxtargets) {
    return self._abilities.lockon.lock_targets.size;
  }

  playerforward = anglesToForward(self getplayerangles());
  dots = [];

  for(i = 0; i < self._abilities.lockon.lock_targets.size; i++) {
    locktarget = self._abilities.lockon.lock_targets[i].target;

    if(!isDefined(locktarget)) {
      return i;
    }

    newitem = spawnStruct();
    newitem.dot = vectordot(playerforward, vectorNormalize(locktarget.origin - self.origin));
    dottolerance = isDefined(self._abilities.lockon.dottolerance) ? self._abilities.lockon.dottolerance : 0.95;

    if(newitem.dot > dottolerance) {
      newitem.target = locktarget;
      array::add_sorted(dots, newitem, 0, &function_568e9d1f);
    }
  }

  newitem = spawnStruct();
  newitem.dot = vectordot(playerforward, vectorNormalize(target.origin - self.origin));
  newitem.target = target;
  array::add_sorted(dots, newitem, 0, &function_568e9d1f);
  worsttarget = dots[dots.size - 1].target;

  if(worsttarget == target) {
    return -1;
  }

  return self weapon_lock_alreadylocked(worsttarget);
}

function weapon_lock_clearslots(clearprogress = 0) {
  if(isDefined(self._abilities) && isDefined(self._abilities.lockon.lock_targets)) {
    for(i = 0; i < self._abilities.lockon.lock_targets.size; i++) {
      self weapon_lock_clearslot(i, undefined, clearprogress);
    }
  }

  self weaponlockremoveslot(-1);
  self._abilities.lockon.lock_targets = [];
}

function weapon_lock_decayaccumulator() {
  self endon(#"death");
  self notify(#"weapon_lock_decayaccumulator");
  self endon(#"weapon_lock_decayaccumulator", #"ccom_lock_started");
  pertick = int(getdvarfloat(#"scr_hacktime_decay_rate", 0.25) / 20 * 1000);

  while(self.lockon_accumulator > 0) {
    waitframe(1);
    self.lockon_accumulator -= pertick;

    if(self.lockon_accumulator < 0) {
      self.lockon_accumulator = 0;
    }
  }
}

function weapon_notifylastlocks() {
  if(!isDefined(self._abilities.lockon.lastlockedtargets) || self._abilities.lockon.lastlockedtargets.size == 0) {
    return;
  }

  lastlockedtargets = [];

  foreach(target in self._abilities.lockon.lastlockedtargets) {
    if(!isDefined(target)) {
      continue;
    }

    found = 0;

    if(self._abilities.lockon.lock_targets.size) {
      foreach(lockitem in self._abilities.lockon.lock_targets) {
        if(!isDefined(lockitem.target)) {
          continue;
        }

        if(lockitem.target == target) {
          found = 1;
          break;
        }
      }
    }

    if(!found) {
      target notify(#"ccom_lost_lock", {
        #owner: self
      });
      level notify(#"ccom_lost_lock", {
        #target: target, #owner: self
      });
      self function_bb2cd3c1(target);
      continue;
    }

    lastlockedtargets[lastlockedtargets.size] = target;
  }

  self._abilities.lockon.lastlockedtargets = lastlockedtargets;
}

function function_a73ea525(weapon) {
  return true;
}

function function_80119fb6(weapon) {
  return self getenemies();
}

function function_d2bc8bb1(enemies, weapon, var_efb1ea62, earlyout = 0) {
  var_5c118373 = [];

  if(!isDefined(enemies) || enemies.size == 0) {
    return var_5c118373;
  }

  playerforward = anglesToForward(self getplayerangles());
  tagaim = self gettagorigin("tag_aim");

  foreach(enemy in enemies) {
    center = enemy getcentroid();
    dirtotarget = vectorNormalize(center - tagaim);
    enemy.dottoplayer = vectordot(dirtotarget, playerforward);
    dottolerance = isDefined(self._abilities.lockon.dottolerance) ? self._abilities.lockon.dottolerance : 0.95;

    if(enemy.dottoplayer < dottolerance) {
      continue;
    }

    if(!targetisValid(enemy, weapon)) {
      continue;
    }

    if(!self[[var_efb1ea62]](enemy, weapon)) {
      continue;
    }

    eyepos = self getEye();
    pos = enemy getshootatpos();

    if(isDefined(pos)) {
      passed = bullettracepassed(eyepos, pos, 0, enemy, undefined, 1, 1);

      if(passed) {
        var_5c118373[var_5c118373.size] = enemy;

        if(earlyout) {
          break;
        }

        continue;
      }
    }

    pos = enemy getcentroid();

    if(isDefined(pos)) {
      passed = bullettracepassed(eyepos, pos, 0, enemy, undefined, 1, 1);

      if(passed) {
        var_5c118373[var_5c118373.size] = enemy;

        if(earlyout) {
          break;
        }
      }
    }
  }

  return var_5c118373;
}

function weaponlockwatchtargets(slot, weapon, maxtargets, var_e08793c0, var_efb1ea62, var_8ff7e677) {
  self notify(#"ccom_stop_lock_on");
  self endon(#"ccom_stop_lock_on", #"disconnect", #"game_ended", #"death");
  radius = self._abilities.lockon.lockradius;

  if(!isDefined(radius)) {
    radius = 130;
  }

  self thread _lock_fired_watcher(weapon);
  self thread _weaponabortwatcher(weapon);

  if(!isDefined(maxtargets)) {
    maxtargets = getdvarint(#"scr_max_simlocks", 3);
  }

  if(maxtargets < 1) {
    maxtargets = 1;
  }

  if(maxtargets > 5) {
    maxtargets = 5;
  }

  maxrange = weapon.lockonmaxrange;

  if(!isDefined(maxrange)) {
    maxrange = 1500;
  }

  validtargets = [];
  dots = [];

  if(!isDefined(var_8ff7e677)) {
    var_8ff7e677 = &function_a73ea525;
  }

  if(!isDefined(var_efb1ea62)) {
    var_efb1ea62 = &function_a73ea525;
  }

  if(!isDefined(var_e08793c0)) {
    var_e08793c0 = &function_80119fb6;
  }

  while(!self[[var_8ff7e677]](weapon)) {
    waitframe(1);
  }

  while(self[[var_8ff7e677]](weapon)) {
    waitframe(1);
    self weapon_notifylastlocks();
    self weapon_lock_clearslots();
    self._abilities.lockon.fail_type = 0;
    var_56842206 = self._abilities.lockon.lastlockedtargets.size;
    enemies = self[[var_e08793c0]](weapon);

    if(!isDefined(enemies) || enemies.size == 0) {
      self cybercomsetfailhint(undefined, 1);
      continue;
    }

    infovenemies = [];
    playerforward = anglesToForward(self getplayerangles());
    tagaim = self gettagorigin("tag_aim");

    foreach(enemy in enemies) {
      center = enemy getcentroid();
      dirtotarget = vectorNormalize(center - tagaim);
      enemy.dottoplayer = vectordot(dirtotarget, playerforward);
      dottolerance = isDefined(self._abilities.lockon.dottolerance) ? self._abilities.lockon.dottolerance : 0.95;

      if(enemy.dottoplayer > dottolerance) {
        infovenemies[infovenemies.size] = enemy;
      }
    }

    if(infovenemies.size == 0) {
      self cybercomsetfailhint(undefined, 1);
      continue;
    }

    validtargets = [];
    potentialtargets = [];

    foreach(enemy in infovenemies) {
      if(!isDefined(enemy)) {
        continue;
      }

      if(!self weapon_lock_meetsrequirement(enemy, radius, weapon, maxrange, var_efb1ea62)) {
        continue;
      }

      validtargets[validtargets.size] = enemy;
    }

    dots = [];

    foreach(target in validtargets) {
      newitem = spawnStruct();
      newitem.dot = target.dottoplayer;
      newitem.target = target;
      array::add_sorted(dots, newitem, 0, &function_568e9d1f);
    }

    if(dots.size) {
      i = 0;

      foreach(item in dots) {
        i++;

        if(i > maxtargets) {
          break;
        }

        if(isDefined(item.target)) {
          weapon_slot = self weapon_lock_alreadylocked(item.target);

          if(weapon_slot != -1) {
            continue;
          }

          if(is_true(item.target.var_2285319)) {
            foreach(other in self._abilities.lockon.lastlockedtargets) {
              if(other == item.target) {
                continue;
              }

              if(is_true(other.var_2285319)) {
                item.target = undefined;
                break;
              }
            }
          }

          if(!isDefined(item.target)) {
            continue;
          }

          slot = self weapon_lock_getslot(item.target, maxtargets);

          if(slot == -1) {
            continue;
          }

          if(!isinarray(self._abilities.lockon.lastlockedtargets, item.target)) {
            self._abilities.lockon.lastlockedtargets[self._abilities.lockon.lastlockedtargets.size] = item.target;
          }

          self weapon_lock_settargettoslot(slot, item.target, maxrange, weapon, maxtargets);
        }
      }

      if(var_56842206 < self._abilities.lockon.lastlockedtargets.size) {
        self playRumbleOnEntity("damage_light");
      }
    }
  }

  self notify(#"ccom_stop_lock_on");
}

function cybercomhintresults(weapon) {
  if(self._abilities.lockon.fail_type !== 0 && (self._abilities.lockon.lock_targets.size == 0 || self._abilities.lockon.fail_type == 8)) {
    if(self._abilities.lockon.fail_type == 2 && isDefined(self._abilities.lockon.fail_ent)) {
      losresult = self _lock_sighttest(self._abilities.lockon.fail_ent, 0);

      if(losresult == 0) {
        self._abilities.lockon.fail_type = 1;
      }
    }

    switch (self._abilities.lockon.fail_type) {
      case 2:
        self settargetwrongtypehint(weapon);
        break;
      case 3:
        self settargetoorhint(weapon);
        break;
      case 4:
        self settargetalreadyinusehint(weapon);
        break;
      case 1:
        self setnotargetshint(weapon);
        break;
      case 5:
        self setnolosontargetshint(weapon);
        break;
      case 6:
        self setdisabledtargethint(weapon);
        break;
      case 7:
        self settargetalreadytargetedhint(weapon);
        break;
      case 8:
        self settargetingabortedhint(weapon);
        break;
    }

    self._abilities.lockon.fail_type = 0;
  }
}

function cybercomsetfailhint(fail_ent, fail_type, requireprime = 1, priority = 1) {
  if(!isPlayer(self) || !isDefined(self._abilities)) {
    return;
  }

  if(requireprime && !is_true(self._abilities.lockon.is_primed)) {
    return;
  }

  if(!is_true(self._abilities.lockon.allowedstate)) {
    return;
  }

  if(priority) {
    if(fail_type > self._abilities.lockon.fail_type) {
      self._abilities.lockon.fail_type = fail_type;
      self._abilities.lockon.fail_ent = fail_ent;
    }

    return;
  }

  self._abilities.lockon.fail_type = fail_type;
  self._abilities.lockon.fail_ent = fail_ent;
}