/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6833e29cc169fd4d.gsc
***********************************************/

#using script_6a0921d005260773;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#namespace namespace_8a67e6b6;

function function_a780da8() {
  self abilities::function_6d4cf28e();

  if(!isDefined(self.var_25fa785)) {
    self.var_25fa785 = spawnStruct();
  }

  if(!isDefined(self.var_25fa785.lockon)) {
    self.var_25fa785.lockon = spawnStruct();
  }

  if(!isDefined(self.var_25fa785.lockon.var_1ce9ea0e)) {
    self.var_25fa785.lockon.var_1ce9ea0e = [];
  }

  if(!isDefined(self.var_25fa785.lockon.var_d6c3c148)) {
    self.var_25fa785.lockon.var_d6c3c148 = [];
  }

  if(!isDefined(self.var_25fa785.lockon.var_4e8096b0)) {
    self.var_25fa785.lockon.var_4e8096b0 = 0;
  }
}

function function_6e4ec2c4(slot, weapon, maxtargets, var_e08793c0, var_efb1ea62, var_8ff7e677) {
  function_a780da8();

  if(!isDefined(maxtargets)) {
    maxtargets = getdvarint(#"scr_max_simlocks", 3);
  }

  assert(maxtargets <= 5, "<dev string:x38>");
  self thread function_4b7f8060(slot, weapon, maxtargets, var_e08793c0, var_efb1ea62, var_8ff7e677);
}

function function_6af99b2e(weapon) {
  self function_b4c3d402(weapon);
  waittillframeend();
  function_2ebec96e(1);
  self function_92c4b561();
  self notify(#"hash_28f4b4a3d8b7ffae");
}

function function_8c4799(weapon) {
  self endon(#"death");
  self notify(#"hash_fd27c03c2898a7b");
  self endon(#"hash_fd27c03c2898a7b", #"hash_28f4b4a3d8b7ffae");
  waitresult = self waittill(#"gadget_forced_off");

  if(weapon == waitresult.weapon) {
    self function_6af99b2e(weapon);
    return;
  }

  self thread function_8c4799(weapon);
}

function private function_2b5f5ecf(weapon) {
  self endon(#"disconnect", #"death", #"hash_28f4b4a3d8b7ffae");
  self waittill(weapon.name + "_fired");
  level notify(#"hash_565f18effb8adf04", {
    #owner: self, #weapon: weapon
  });

  foreach(item in self.var_25fa785.lockon.var_d6c3c148) {
    if(isDefined(item.target)) {
      item.target notify(#"hash_565f18effb8adf04", {
        #owner: self, #weapon: weapon
      });

      if(isDefined(item.target.lockon_owner) && item.target.lockon_owner == self) {
        item.target.lockon_owner = undefined;
      }
    }
  }

  self function_6af99b2e(weapon);
}

function private function_c0251c1e(target, var_4f358117 = 1) {
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

  if(!isDefined(target.var_25fa785)) {
    target.var_25fa785 = spawnStruct();
  }

  if(!isDefined(target.var_25fa785.lockon)) {
    target.var_25fa785.lockon = spawnStruct();
  }

  if(!isDefined(target.var_25fa785.lockon.var_61980861)) {
    target.var_25fa785.lockon.var_61980861 = [];
  }

  pos = target getshootatpos();

  if(isDefined(pos)) {
    passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);

    if(passed) {
      target.var_25fa785.lockon.var_61980861[self getentitynumber()] = gettime();
      return 1;
    }
  }

  pos = target getcentroid();

  if(isDefined(pos)) {
    passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);

    if(passed) {
      target.var_25fa785.lockon.var_61980861[self getentitynumber()] = gettime();
      return 1;
    }
  }

  if(var_4f358117) {
    mins = target getmins();
    maxs = target getmaxs();
    var_a0e635a9 = (maxs[2] - mins[2]) / 4;

    for(i = 0; i <= 4; i++) {
      pos = target.origin + (0, 0, var_a0e635a9 * i);
      passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);

      if(passed) {
        target.var_25fa785.lockon.var_61980861[self getentitynumber()] = gettime();
        return 1;
      }

      pos = target.origin + (mins[0], mins[1], var_a0e635a9 * i);
      passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);

      if(passed) {
        target.var_25fa785.lockon.var_61980861[self getentitynumber()] = gettime();
        return 1;
      }

      pos = target.origin + (maxs[0], maxs[1], var_a0e635a9 * i);
      passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);

      if(passed) {
        target.var_25fa785.lockon.var_61980861[self getentitynumber()] = gettime();
        return 1;
      }
    }

    lastseen = target.var_25fa785.lockon.var_61980861[self getentitynumber()];

    if(isDefined(lastseen) && lastseen + getdvarint(#"hash_592433ab4ddff207", 3000) > gettime()) {
      trace = bulletTrace(eyepos, pos, 0, target);
      distsq = distancesquared(pos, trace[#"position"]);

      if(distsq <= getdvarint(#"hash_1fd2e213720ddfb3", sqr(315))) {
        return 2;
      } else {
        return 0;
      }
    }
  }

  return 0;
}

function function_e2ce3b3d(target, weapon, var_54396394 = 1) {
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

  if(isDefined(target.var_6f4d7125)) {
    if(target.var_6f4d7125 == 0) {
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

  if(var_54396394 && isDefined(self.var_25fa785) && isDefined(self.var_25fa785.lockon.var_50ac8140)) {
    result = self[[self.var_25fa785.lockon.var_50ac8140]](target);
  }

  if(result && isDefined(level.var_f320af85)) {
    result &= [[level.var_f320af85]](self, target, weapon);
  }

  return result;
}

function function_397e4d13(target, maxrange, weapon) {
  if(isDefined(weapon)) {
    distancesqr = distancesquared(maxrange.origin, self.origin);

    if(distancesqr > sqr(weapon)) {
      return false;
    }
  }

  return true;
}

function function_2684c502(target, radius, weapon, maxrange, var_efb1ea62) {
  result = 1;
  isvalid = self function_e2ce3b3d(target, weapon);

  if(!is_true(isvalid)) {
    self function_a1dd4489(target, 1);
    return 0;
  }

  var_584c7fc2 = target[[var_efb1ea62]](self, weapon);

  if(!is_true(var_584c7fc2)) {
    self function_a1dd4489(target, 1);
    return 0;
  }

  if(isDefined(maxrange)) {
    distancesqr = distancesquared(target.origin, self.origin);

    if(distancesqr > sqr(maxrange)) {
      self function_a1dd4489(target, 3);
      return 0;
    }
  }

  var_a7e5784a = self function_c0251c1e(target);

  if(var_a7e5784a == 0) {
    self function_a1dd4489(target, 5);
    return 0;
  }

  if(var_a7e5784a == 2) {
    radius *= 2;
  }

  if(isDefined(radius)) {
    distsq = distancesquared(self.origin, target.origin);

    if(distsq > sqr(144)) {
      result = target_isincircle(target, self, 65, radius);
    }
  }

  if(result == 0) {
    self function_a1dd4489(target, 1);
  }

  return result;
}

function function_568e9d1f(a, b) {
  return a.dot < b.dot;
}

function function_bb2cd3c1(target) {
  if(isDefined(target.lockon_owner) && target.lockon_owner == self) {
    function_f9f09e3f(self);
    target.var_7a48f1af = gettime() - target.var_6a1a4bf6;
    target thread function_ddd62d1c();
    target.var_6a1a4bf6 = undefined;
    target.var_784d850f = gettime() + 150;
    target.lockon_owner = undefined;
    target.var_6a1a4bf6 = undefined;
    target.var_3f53671 = undefined;
    self notify(#"hash_5c27ba8c4f6d6d7a");
    self notify(#"ccom_lost_lock", {
      #target: target
    });
  }
}

function function_a8d75f2f(slot, note, var_bf4c2932) {
  if(isDefined(self.var_25fa785.lockon.var_d6c3c148[slot])) {
    item = self.var_25fa785.lockon.var_d6c3c148[slot];

    if(isDefined(item.target)) {
      if(isDefined(note)) {
        item.target notify(note);
      }

      self weaponlocknoclearance(0, item.var_feac9e76);
      self weaponlockremoveslot(item.var_feac9e76);

      if(is_true(var_bf4c2932)) {
        self function_bb2cd3c1(item.target);
      }

      item.target = undefined;
    }
  }
}

function private function_b44cb841(player) {
  self endon(#"ccom_lost_lock");
  self notify(#"hash_2a729778ba08a118");
  self endon(#"hash_2a729778ba08a118");
  slot = player function_cc4e7260(self);
  self waittill(#"death", #"hash_565f18effb8adf04", #"hash_68de5a70849dff37");
  player weaponlocknoclearance(0, slot);
  player weaponlockremoveslot(slot);
}

function function_5085f9ce(slot, target, maxrange, weapon, maxtargets) {
  if(slot == -1 || slot >= maxtargets) {
    return;
  }

  if(isDefined(target.var_784d850f) && gettime() < target.var_784d850f) {
    return;
  }

  if(isDefined(self.var_25fa785.lockon.var_d6c3c148[slot])) {
    self function_a8d75f2f(slot, "ccom_lost_lock");
    newitem = self.var_25fa785.lockon.var_d6c3c148[slot];
    newitem.target = target;
  } else {
    newitem = spawnStruct();
    newitem.target = target;
    newitem.var_feac9e76 = slot;
    self.var_25fa785.lockon.var_d6c3c148[slot] = newitem;
  }

  if(isDefined(newitem.target)) {
    if(isDefined(newitem.target.var_fedddeb8) && isDefined(newitem.target.var_fedddeb8[self.var_25fa785.lockon.var_50087796.name])) {
      if(!isDefined(newitem.target.lockon_owner)) {
        newitem.target.var_6a1a4bf6 = gettime() - newitem.target.var_7a48f1af;
        newitem.target.lockon_owner = self;
        newitem.target notify(#"hash_4e379ec4e6f3cb69");
        curstart = newitem.target.var_7a48f1af / newitem.target.var_fedddeb8[self.var_25fa785.lockon.var_50087796.name] * 1000;
        function_ea7b2cb3(self, newitem.target.var_fedddeb8[self.var_25fa785.lockon.var_50087796.name], curstart);
        level thread function_eeb4c5eb(self);
      }

      if(isDefined(newitem.target.lockon_owner) && newitem.target.lockon_owner == self) {
        newitem.target.var_3f53671 = math::clamp((gettime() - newitem.target.var_6a1a4bf6) / newitem.target.var_fedddeb8[self.var_25fa785.lockon.var_50087796.name] * 1000, 0, 1);
      }
    }

    self weaponlockstart(newitem.target, newitem.var_feac9e76);
    newitem.inrange = 1;

    if(!self function_397e4d13(newitem.target, maxrange, weapon)) {
      newitem.inrange = 0;
      self weaponlocknoclearance(1, slot);
    }

    if(isDefined(newitem.target.var_3f53671)) {
      if(newitem.target.lockon_owner == self) {
        if(newitem.target.var_3f53671 != 1) {
          newitem.inrange = 2;
          self weaponlocknoclearance(1, slot);
        }
      } else {
        newitem.inrange = 0;
        self weaponlocknoclearance(1, slot);
      }
    }

    if(newitem.inrange == 1) {
      function_f9f09e3f(self);
      self weaponlocknoclearance(0, slot);
      self weaponlockfinalize(newitem.target, newitem.var_feac9e76);
      newitem.target notify(#"hash_3e74cb35c04b5632", self);
      level notify(#"hash_3e74cb35c04b5632", newitem.target);
    } else {
      newitem.target notify(#"ccom_lock_being_targeted", {
        #hijacking_player: self
      });
      level notify(#"ccom_lock_being_targeted", {
        #target: newitem.target, #hijacking_player: self
      });
    }

    newitem.target thread function_b44cb841(self);
  }
}

function function_ea7b2cb3(hacker, duration, var_f97b5169) {
  val = duration & 31;

  if(var_f97b5169 > 0) {
    cur = math::clamp(var_f97b5169, 0, 1);
    offset = int(cur * 128) << 5;
    val += offset;
  }
}

function function_f9f09e3f(hacker) {
  if(isDefined(hacker)) {}
}

function function_eeb4c5eb(hacker) {
  hacker endon(#"disconnect");
  hacker notify(#"hash_5c27ba8c4f6d6d7a");
  hacker endon(#"hash_5c27ba8c4f6d6d7a");
  hacker waittill(#"death", #"hash_4b778a3139f80d62", #"ccom_lost_lock", #"hash_3e74cb35c04b5632");
  function_f9f09e3f(hacker);
}

function function_cc4e7260(target) {
  for(i = 0; i < self.var_25fa785.lockon.var_d6c3c148.size; i++) {
    if(!isDefined(self.var_25fa785.lockon.var_d6c3c148[i].target)) {
      continue;
    }

    if(self.var_25fa785.lockon.var_d6c3c148[i].target == target) {
      return i;
    }
  }

  return -1;
}

function function_14c54c6d() {
  targets = [];

  for(i = 0; i < self.var_25fa785.lockon.var_d6c3c148.size; i++) {
    if(!isDefined(self.var_25fa785.lockon.var_d6c3c148[i].target)) {
      continue;
    }

    targets[targets.size] = self.var_25fa785.lockon.var_d6c3c148[i].target;
  }

  return targets;
}

function function_dd8587b2(target, maxtargets) {
  if(self.var_25fa785.lockon.var_d6c3c148.size < maxtargets) {
    return self.var_25fa785.lockon.var_d6c3c148.size;
  }

  playerforward = anglesToForward(self getplayerangles());
  dots = [];

  for(i = 0; i < self.var_25fa785.lockon.var_d6c3c148.size; i++) {
    locktarget = self.var_25fa785.lockon.var_d6c3c148[i].target;

    if(!isDefined(locktarget)) {
      return i;
    }

    newitem = spawnStruct();
    newitem.dot = vectordot(playerforward, vectornormalize(locktarget.origin - self.origin));
    var_3d797059 = isDefined(self.var_25fa785.lockon.var_3d797059) ? self.var_25fa785.lockon.var_3d797059 : 0.95;

    if(newitem.dot > var_3d797059) {
      newitem.target = locktarget;
      array::add_sorted(dots, newitem, 0, &function_568e9d1f);
    }
  }

  newitem = spawnStruct();
  newitem.dot = vectordot(playerforward, vectornormalize(target.origin - self.origin));
  newitem.target = target;
  array::add_sorted(dots, newitem, 0, &function_568e9d1f);
  var_fa05e32a = dots[dots.size - 1].target;

  if(var_fa05e32a == target) {
    return -1;
  }

  return self function_cc4e7260(var_fa05e32a);
}

function function_2ebec96e(var_bf4c2932 = 0) {
  if(isDefined(self.var_25fa785) && isDefined(self.var_25fa785.lockon.var_d6c3c148)) {
    for(i = 0; i < self.var_25fa785.lockon.var_d6c3c148.size; i++) {
      self function_a8d75f2f(i, undefined, var_bf4c2932);
    }
  }

  self weaponlockremoveslot(-1);
  self.var_25fa785.lockon.var_d6c3c148 = [];
}

function function_ddd62d1c() {
  self endon(#"death");
  self notify(#"hash_5527196024cbab2a");
  self endon(#"hash_5527196024cbab2a", #"hash_4e379ec4e6f3cb69");
  var_8c73eccc = int(getdvarfloat(#"hash_20ef93f02210f3f0", 0.25) / 20 * 1000);

  while(self.var_7a48f1af > 0) {
    waitframe(1);
    self.var_7a48f1af -= var_8c73eccc;

    if(self.var_7a48f1af < 0) {
      self.var_7a48f1af = 0;
    }
  }
}

function function_92c4b561() {
  if(!isDefined(self.var_25fa785.lockon.var_1ce9ea0e) || self.var_25fa785.lockon.var_1ce9ea0e.size == 0) {
    return;
  }

  var_1ce9ea0e = [];

  foreach(target in self.var_25fa785.lockon.var_1ce9ea0e) {
    if(!isDefined(target)) {
      continue;
    }

    found = 0;

    if(self.var_25fa785.lockon.var_d6c3c148.size) {
      foreach(var_50af7828 in self.var_25fa785.lockon.var_d6c3c148) {
        if(!isDefined(var_50af7828.target)) {
          continue;
        }

        if(var_50af7828.target == target) {
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

    var_1ce9ea0e[var_1ce9ea0e.size] = target;
  }

  self.var_25fa785.lockon.var_1ce9ea0e = var_1ce9ea0e;
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
  var_9c8f2bcc = self gettagorigin("tag_aim");

  foreach(enemy in enemies) {
    center = enemy getcentroid();
    dirtotarget = vectornormalize(center - var_9c8f2bcc);
    enemy.var_5425b76c = vectordot(dirtotarget, playerforward);
    var_3d797059 = isDefined(self.var_25fa785.lockon.var_3d797059) ? self.var_25fa785.lockon.var_3d797059 : 0.95;

    if(enemy.var_5425b76c < var_3d797059) {
      continue;
    }

    if(!function_e2ce3b3d(enemy, weapon)) {
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

function function_4b7f8060(slot, weapon, maxtargets, var_e08793c0, var_efb1ea62, var_8ff7e677) {
  self notify(#"hash_28f4b4a3d8b7ffae");
  self endon(#"hash_28f4b4a3d8b7ffae", #"disconnect", #"game_ended", #"death");
  radius = self.var_25fa785.lockon.var_4ce73a98;

  if(!isDefined(radius)) {
    radius = 130;
  }

  self thread function_2b5f5ecf(weapon);
  self thread function_8c4799(weapon);

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
    self function_92c4b561();
    self function_2ebec96e();
    self.var_25fa785.lockon.var_4e8096b0 = 0;
    var_56842206 = self.var_25fa785.lockon.var_1ce9ea0e.size;
    enemies = self[[var_e08793c0]](weapon);

    if(!isDefined(enemies) || enemies.size == 0) {
      self function_a1dd4489(undefined, 1);
      continue;
    }

    var_7bc97a0f = [];
    playerforward = anglesToForward(self getplayerangles());
    var_9c8f2bcc = self gettagorigin("tag_aim");

    foreach(enemy in enemies) {
      center = enemy getcentroid();
      dirtotarget = vectornormalize(center - var_9c8f2bcc);
      enemy.var_5425b76c = vectordot(dirtotarget, playerforward);
      var_3d797059 = isDefined(self.var_25fa785.lockon.var_3d797059) ? self.var_25fa785.lockon.var_3d797059 : 0.95;

      if(enemy.var_5425b76c > var_3d797059) {
        var_7bc97a0f[var_7bc97a0f.size] = enemy;
      }
    }

    if(var_7bc97a0f.size == 0) {
      self function_a1dd4489(undefined, 1);
      continue;
    }

    validtargets = [];
    potentialtargets = [];

    foreach(enemy in var_7bc97a0f) {
      if(!isDefined(enemy)) {
        continue;
      }

      if(!self function_2684c502(enemy, radius, weapon, maxrange, var_efb1ea62)) {
        continue;
      }

      validtargets[validtargets.size] = enemy;
    }

    dots = [];

    foreach(target in validtargets) {
      newitem = spawnStruct();
      newitem.dot = target.var_5425b76c;
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
          weapon_slot = self function_cc4e7260(item.target);

          if(weapon_slot != -1) {
            continue;
          }

          if(is_true(item.target.var_2285319)) {
            foreach(other in self.var_25fa785.lockon.var_1ce9ea0e) {
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

          slot = self function_dd8587b2(item.target, maxtargets);

          if(slot == -1) {
            continue;
          }

          if(!isinarray(self.var_25fa785.lockon.var_1ce9ea0e, item.target)) {
            self.var_25fa785.lockon.var_1ce9ea0e[self.var_25fa785.lockon.var_1ce9ea0e.size] = item.target;
          }

          self function_5085f9ce(slot, item.target, maxrange, weapon, maxtargets);
        }
      }

      if(var_56842206 < self.var_25fa785.lockon.var_1ce9ea0e.size) {
        self playrumbleonentity("damage_light");
      }
    }
  }

  self notify(#"hash_28f4b4a3d8b7ffae");
}

function function_b4c3d402(weapon) {
  if(self.var_25fa785.lockon.var_4e8096b0 !== 0 && (self.var_25fa785.lockon.var_d6c3c148.size == 0 || self.var_25fa785.lockon.var_4e8096b0 == 8)) {
    if(self.var_25fa785.lockon.var_4e8096b0 == 2 && isDefined(self.var_25fa785.lockon.var_bf4fab3f)) {
      var_a7e5784a = self function_c0251c1e(self.var_25fa785.lockon.var_bf4fab3f, 0);

      if(var_a7e5784a == 0) {
        self.var_25fa785.lockon.var_4e8096b0 = 1;
      }
    }

    switch (self.var_25fa785.lockon.var_4e8096b0) {
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

    self.var_25fa785.lockon.var_4e8096b0 = 0;
  }
}

function function_a1dd4489(var_bf4fab3f, var_4e8096b0, var_d217d303 = 1, priority = 1) {
  if(!isPlayer(self) || !isDefined(self.var_25fa785)) {
    return;
  }

  if(var_d217d303 && !is_true(self.var_25fa785.lockon.var_45d4eb19)) {
    return;
  }

  if(!is_true(self.var_25fa785.lockon.var_d1052697)) {
    return;
  }

  if(priority) {
    if(var_4e8096b0 > self.var_25fa785.lockon.var_4e8096b0) {
      self.var_25fa785.lockon.var_4e8096b0 = var_4e8096b0;
      self.var_25fa785.lockon.var_bf4fab3f = var_bf4fab3f;
    }

    return;
  }

  self.var_25fa785.lockon.var_4e8096b0 = var_4e8096b0;
  self.var_25fa785.lockon.var_bf4fab3f = var_bf4fab3f;
}