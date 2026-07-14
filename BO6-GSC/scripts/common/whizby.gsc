/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\whizby.gsc
**************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace whizby;

function init(var_f06805c4d42f072f) {
  setdvarifuninitialized(@ "scr_whizby", 1);

  setdvarifuninitialized(@ "scr_debug_whizby", 0);
  setdvarifuninitialized(@ "scr_test_whizby", "<dev string:x24>");

  callback::add(#"player_spawned", &onplayerspawned);

  if(isDefined(level.players)) {
    foreach(player in level.players) {
      player thread whizbythink();
    }
  }
}

function private onplayerspawned(params) {
  thread whizbythink();
}

function private initplayer() {
  self.whizby = spawnStruct();
  self.whizby.var_f02dd59afc28cc6 = -999999;
  self.whizby.var_3bd9b51ddba6cc5c = -999999;
  function_c0187af010b61b9();

  if(istrue(level.gamemodebundle.var_f605d2943b760502) && !function_9ed3f515e2439095()) {
    level.gamemodebundle.var_f605d2943b760502 = 0;

    function_b9c9a404b5a0ee(#"hash_404f3e574dfa47be");
  }

  if(istrue(level.gamemodebundle.var_f605d2943b760502)) {
    tempinithud();
  }
}

function private tempinithud() {
  self setclientomnvar("\xd1\x11\a\xd5\xe9%\x0e^\xbaoyy\\\xd9X\x16\xf0G\x95e\xf4", 0);
  self setclientomnvar("h%\x80\xf8\xa8zi\xd5d Z\x9c\xff\\'\xca\b%l\xea", 0);
  self setclientomnvar("\x13\x01r\xd6N\x7f\xf2\xa5\xcbV<\x90Zo\v9*8!\xb2", 0);
  self setclientomnvar("\xff\x18P\xfb\x89\xe7\xb5X{\xa41\x8b\xde cy\x98?\xa9\xde", 1);
  self setclientomnvar("\x1aW?j\bK\xc1\xecO\xc6F\b-}\x05\x88", 0);
  self setclientomnvar("v\x06}yY!\x98o|\x17jC\x9e|\xe1\x9b", 0);
  self setclientomnvar("\xde\xf3\x817\x8d\\`\xda\xb9\xd9\xfd\x9aW\x98@9", 0);
  self setclientomnvar("0\x1b\xe9\xdd|2\xaf\xe40\x98\xc6\xb3\xd6\x87\xdej", -999);
}

function private whizbythink() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  initplayer();

  for(;;) {
    self waittill("\x9c\xae\x01\x94\xb8\xb5F\xc1\x94\row", attacker, distance, position, forward);

    if(!utility::isusingremote()) {
      thread whizbyeffect(attacker, distance, position, forward);
    }

    if(isPlayer(attacker)) {
      weapon = attacker getcurrentweapon();

      if(isDefined(weapon) && weaponclass(weapon) == "\xff\x12\x9a\xbe.a") {
        namespace_bc7cdace2d7445a5::trysaylocalsoundsharedfunc(self, #"bc_combat_threat_sniper", 0.2);
      }
    }

    namespace_bc7cdace2d7445a5::addrecentattackersharedfunc(attacker);
  }
}

function whizbyeffect(attacker, distance, position, forward, forceweapon) {
  if(getdvarint(@ "scr_debug_whizby")) {
    if(distance > 1000) {
      print3d(position, int(sqrt(distance)), (1, 1, 1), 0.7, 0.45, 20);
    } else {
      eye = self getEye();
      print3d(position, distance, (1, 0, 0), 0.7, 0.45, 20);
    }
  }

  if(isDefined(level.battlechatter) && isDefined(attacker) && isai(attacker) && isalive(attacker)) {
    function_99e8e66d1969d7cb(attacker, undefined, "9\xa2K\xdb\xa6B5\xbe\xdb\x95(1\xf3)", "P'\xa3bZ\xd2\x16\x19\x84\xeb\xe9\xf2\xc7");
  }

  self notify("\x7fr\xbb(I\xe3B}~\x0f:");
  self endon("\x7fr\xbb(I\xe3B}~\x0f:");
  waittillframeend();
  time = gettime();

  if(!shoulddowhizby(attacker, distance, position, forward, time)) {
    if(isDefined(level.battlechatter) && isDefined(attacker) && isai(attacker) && isalive(attacker)) {
      attacker setbattlechatterflag("\x9d%\x80\xa3~p4\x80\xa6\xad\x11R", 0);
    }

    return;
  } else if(isDefined(level.battlechatter) && isDefined(attacker) && isai(attacker) && isalive(attacker)) {
    attacker setbattlechatterflag("\x9d%\x80\xa3~p4\x80\xa6\xad\x11R", 1);
  }

  weapon = undefined;

  if(isDefined(forceweapon)) {
    weapon = forceweapon;
  }

  if(isPlayer(attacker) || isbot(attacker)) {
    weapon = attacker getcurrentweapon();
  } else if(isai(attacker)) {
    weapon = attacker.weapon;
  } else {
    assertmsg("<dev string:x28>");
  }

  weapclass = weaponclass(weapon);

  if(getDvar(@ "scr_test_whizby") != "<dev string:x24>") {
    switch (getDvar(@ "scr_test_whizby")) {
      case #"hash_900cb06c552c5063":
        weapclass = "<dev string:x5f>";
        break;
      case #"hash_28a7ce6c1f1955d9":
        weapclass = "<dev string:x6d>";
        break;
      case #"hash_2f69646c2276faf4":
        weapclass = "<dev string:x7d>";
        break;
    }
  }

  whizbymag = function_ee46d30d5a1f7079(weapclass, distance, time);
  whizbyquake(whizbymag);
  whizbyvision(weapclass, weapon, whizbymag);
  whizby_hud(attacker, position, time, whizbymag, distance);
  self.whizby.var_f02dd59afc28cc6 = time;

  if(!isDefined(attacker.whizby)) {
    attacker.whizby = spawnStruct();
  }

  attacker.whizby.var_3bd9b51ddba6cc5c = time;
  function_c0187af010b61b9();
}

function shoulddowhizby(attacker, distance, position, forward, time) {
  if(getdvarint(@ "scr_whizby", 1) != 1) {
    return false;
  }

  if(!(isDefined(position) && isDefined(distance) && isDefined(attacker) && isDefined(self) && isDefined(forward))) {
    return false;
  }

  if(!isai(attacker) && !isPlayer(attacker)) {
    return false;
  }

  if(!isalive(attacker)) {
    return false;
  }

  if(time - self.whizby.var_f02dd59afc28cc6 < self.whizby.cooldown) {
    return false;
  }

  if(!val::get("+\xa8\x1d\xb65\x1f")) {
    return false;
  }

  if(istrue(self.nowhizby)) {
    return false;
  }

  if(isDefined(self.team) && isDefined(attacker.team) && !isenemyteam(self.team, attacker.team)) {
    return false;
  }

  if(istrue(self.deathsdoor)) {
    return false;
  }

  if(function_6c03419c0c3f87d6(time)) {
    return false;
  }

  return true;
}

function function_6c03419c0c3f87d6(time) {
  if(!isDefined(self.lastdamagedtime)) {
    return false;
  }

  damagedcooldowntime = getdvarint(@ "hash_902f31627206f3", 750);

  if(self.lastdamagedtime + damagedcooldowntime > time) {
    return true;
  }

  return false;
}

function whizbyquake(whizbymag) {
  zoomlevel = self playergetzoomfov();
  zoomfactor = math::normalize_value(4, 65, zoomlevel);
  var_841a4d1aa0958e5d = math::factor_value(0.3, 0.85, zoomfactor);
  var_1750a9334b359eea = math::factor_value(1, var_841a4d1aa0958e5d, self playerads());
  quakemag = math::factor_value(0.03, 0.28, whizbymag);
  quaketime = math::factor_value(0.35, 0.35, whizbymag);
  quakemag *= var_1750a9334b359eea;
  self earthquakeforplayer(quakemag, quaketime, self.origin, 1000);
}

function whizbyvision(weapclass, weapon, whizbymag) {
  eventtype = undefined;
  highestevent = 2;

  switch (weapclass) {
    case #"hash_fa24dff6bd60a12d":
      highestevent = 3;
      break;
    case #"hash_6191aaef9f922f96":
      if(utility::string_starts_with("\xb5\x15\xa6>\xd0\x05", weapon.basename)) {
        highestevent = 2;
      } else {
        highestevent = 3;
      }

      break;
    case #"hash_8cdaf2e4ecfe5b51":
      highestevent = 2;
      break;
    case #"hash_719417cb1de832b6":
    case #"hash_900cb96c552c5e8e":
      highestevent = 2;
      break;
  }

  eventindex = highestevent;

  if(whizbymag < 0.3) {
    eventindex -= 2;
  } else if(whizbymag < 0.6) {
    eventindex -= 1;
  }

  switch (eventindex) {
    case 3:
      eventtype = "\xe3W\xf8M\x18C\x7fz{";
      break;
    case 2:
      eventtype = "\xf5\xf4\xa8\xe0>O\xa9c[\xbb";
      break;
    case 1:
      eventtype = "\xbd\x160V:\n\xaa\x98\x98";
      break;
  }

  if(eventindex > 0) {
    self function_fadd6ff56c299471(eventtype);
  }
}

function whizby_hud(attacker, position, time, whizbymag, distance) {
  if(!istrue(level.gamemodebundle.var_f605d2943b760502)) {
    return;
  }

  playerang = self getplayerangles();
  eyepos = self getEye();
  playeraxis = anglestoaxis(playerang);
  attackerpos = attacker.origin + (0, 0, 50);
  toattackervec = vectorNormalize(attackerpos - eyepos);
  var_990967cee4fbade2 = vectordot(toattackervec, playeraxis["\xa17\xd3\x9fT\x14P"]);
  var_6634fe9130dc63a7 = vectordot(toattackervec, playeraxis["o0\xee\xc1\x8c"]);
  var_e8baf5417c1f89ac = vectordot(toattackervec, playeraxis["\xf3\xf2"]);
  whizybyent = attacker getentitynumber();
  var_c38a45d370e28a67 = clamp(var_990967cee4fbade2, 0, 1);
  var_53fefe45a6a3e639 = 1 - abs(var_990967cee4fbade2);
  var_2fdeddcaa37db67d = clamp(-1 * var_990967cee4fbade2, 0, 1);
  var_c13b9457c2572648 = function_4e68914b3d42d59d(var_6634fe9130dc63a7, var_e8baf5417c1f89ac);
  backorigin = position + -500 * toattackervec;
  var_c38a45d370e28a67 = math::normalized_float_smooth_out(var_c38a45d370e28a67);
  var_53fefe45a6a3e639 = math::normalized_float_smooth_out(var_53fefe45a6a3e639);
  self setclientomnvar("\xd1\x11\a\xd5\xe9%\x0e^\xbaoyy\\\xd9X\x16\xf0G\x95e\xf4", var_c38a45d370e28a67 * whizbymag * 0.5);
  self setclientomnvar("h%\x80\xf8\xa8zi\xd5d Z\x9c\xff\\'\xca\b%l\xea", var_53fefe45a6a3e639 * whizbymag * 1);
  self setclientomnvar("\x13\x01r\xd6N\x7f\xf2\xa5\xcbV<\x90Zo\v9*8!\xb2", var_2fdeddcaa37db67d * whizbymag * 1);
  self setclientomnvar("\xff\x18P\xfb\x89\xe7\xb5X{\xa41\x8b\xde cy\x98?\xa9\xde", int(var_c13b9457c2572648));
  self setclientomnvar("\xda\xec\xc3s\x8c\x1c\x1aC\x9c\x1a\x7f\xec\x9d", whizybyent);
  self setclientomnvar("\x1aW?j\bK\xc1\xecO\xc6F\b-}\x05\x88", int(backorigin[0]));
  self setclientomnvar("v\x06}yY!\x98o|\x17jC\x9e|\xe1\x9b", int(backorigin[1]));
  self setclientomnvar("\xde\xf3\x817\x8d\\`\xda\xb9\xd9\xfd\x9aW\x98@9", int(backorigin[2]));
  xpos = self getclientomnvar("\x1aW?j\bK\xc1\xecO\xc6F\b-}\x05\x88");
  ypos = self getclientomnvar("v\x06}yY!\x98o|\x17jC\x9e|\xe1\x9b");
  zpos = self getclientomnvar("\xde\xf3\x817\x8d\\`\xda\xb9\xd9\xfd\x9aW\x98@9");
  self setclientomnvar("0\x1b\xe9\xdd|2\xaf\xe40\x98\xc6\xb3\xd6\x87\xdej", time);

  if(getdvarint(@ "scr_debug_whizby")) {
    debugwhizby(attacker, position, backorigin, whizbymag, distance);
  }
}

function function_4e68914b3d42d59d(var_6634fe9130dc63a7, var_e8baf5417c1f89ac) {
  var_37463764e9ffc589 = abs(var_6634fe9130dc63a7) + abs(var_e8baf5417c1f89ac);

  if(var_37463764e9ffc589 > 0) {
    rightfrac = var_6634fe9130dc63a7 / var_37463764e9ffc589;
    upfrac = var_e8baf5417c1f89ac / var_37463764e9ffc589;
  } else {
    rightfrac = 1;
    upfrac = 1;
  }

  if(upfrac < 0) {
    angle = 90 * rightfrac;
  } else {
    angle = 90 + 90 * upfrac;

    if(rightfrac < 0) {
      angle *= -1;
    }
  }

  return angle;
}

function function_ee46d30d5a1f7079(weapclass, distance, time) {
  basemag = 0.8;

  switch (weapclass) {
    case #"hash_fa24dff6bd60a12d":
      basemag = 1;
      break;
    case #"hash_6191aaef9f922f96":
      basemag = 1;
      break;
    case #"hash_900cb96c552c5e8e":
      basemag = 0.6;
      break;
    case #"hash_fa4dbdf6bd80bf52":
      basemag = 0.6;
      break;
  }

  distmultiplier = math::normalize_value(999, 1000, distance);
  distmultiplier = math::factor_value(1, 1, distmultiplier);
  whizby_min = randomfloatrange(0.14, 0.28);
  timesincelastreceived = time - self.whizby.var_f02dd59afc28cc6;
  var_bee2a5eab34cff0e = math::normalize_value(1000, 4000, timesincelastreceived);
  var_d5b9fe25cabf77bc = math::factor_value(whizby_min, 1, var_bee2a5eab34cff0e);
  return basemag * distmultiplier * var_d5b9fe25cabf77bc;
}

function function_c0187af010b61b9() {
  self.whizby.cooldown = randomfloatrange(100, 200);
}

function testwhizby() {
  setdevdvar(@ "scr_whizby", 1);

  if(isbot(self)) {
    return;
  }

  self endon("<dev string:x87>");
  self endon("<dev string:x90>");
  thread function_56497ca5bf5678a1();

  while(true) {
    self waittill("<dev string:x9e>");
    function_88ac40cc84e041d3();
  }
}

function function_56497ca5bf5678a1() {
  while(true) {
    while(!self buttonPressed("<dev string:xaf>")) {
      wait 0.05;
    }

    self notify("<dev string:x9e>");

    while(self buttonPressed("<dev string:xaf>")) {
      wait 0.05;
    }
  }
}

function function_88ac40cc84e041d3() {
  self endon("<dev string:x9e>");
  i = 0;
  dist = [10, 25, 50, 75];
  attacker = undefined;

  foreach(player in level.players) {
    if(player != self) {
      attacker = player;
    }
  }

  if(!isDefined(attacker)) {
    ai = getaiarray();

    if(ai.size > 0) {
      attacker = utility::getclosest(self.origin, ai, 5000);
    }
  }

  effecttime = gettime();

  while(true) {
    if(isDefined(attacker)) {
      vecoffset = anglesToForward(self getplayerangles(1));
      dirtoattacker = vectorNormalize((attacker.origin[0], attacker.origin[1], 0) - (self.origin[0], self.origin[1], 0));
      var_a3a6a6d94e5c4cc0 = 1;
      vecoffset = rotatevector(dirtoattacker, (0, 90 * var_a3a6a6d94e5c4cc0, 0));
      height = (0, 0, randomfloatrange(45, 65));
      position = self.origin + height + vecoffset * dist[i];
      self notify("<dev string:xbd>", attacker, dist[i], position, dirtoattacker * -1);
      i++;

      if(i >= dist.size) {
        i = 0;
      }
    }

    switch (getDvar(@ "scr_test_whizby")) {
      case #"hash_900cb06c552c5063":
        wait 0.22;
        break;
      case #"hash_28a7ce6c1f1955d9":
        wait 0.3;
        break;
      case #"hash_2f69646c2276faf4":
        wait 0.75;
        break;
      default:
        wait 0.22;
        break;
    }
  }
}

function debugwhizby(attacker, position, backorigin, whizbymag, distance) {
  if(isDefined(attacker) && isDefined(position)) {
    if(isDefined(attacker.currentweapon) && attacker tagexists("<dev string:xcd>")) {
      start = attacker gettagorigin("<dev string:xcd>");
    } else {
      start = attacker.origin + (0, 0, 50);
    }

    line(start, position, (1, 0, 0), 1, 1, 20);
    line(backorigin, position, (0.5, 0.5, 0.5), 1, 1, 20);
    iprintln("<dev string:xda>" + distance + "<dev string:xf5>" + whizbymag + "<dev string:x109>");
  }
}

# /