/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\whizby.gsc
***********************************************/

#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace whizby;

function init(var_8611e1d824bbdb4a) {
  setdvarifuninitialized(@ "hash_15c99dd2f2a0921a", 1);

  setdvarifuninitialized(@ "hash_7774635c5712048e", 0);
  setdvarifuninitialized(@ "hash_a6017ebde71968e5", "<dev string:x1c>");
}

function initplayer() {
  self.whizby = spawnStruct();
  self.whizby.lasttime = -999999;
  function_bcd1a794fb26ee5c();
}

function function_a6e6611efb4164d5(attacker, distance, position, forward) {
  if(getdvarint(@ "hash_7774635c5712048e")) {
    if(distance > 120) {
      print3d(position, int(sqrt(distance)), (1, 1, 1), 0.7, 0.45, 20);
    } else {
      eye = self getEye();
      print3d(position, distance, (1, 0, 0), 0.7, 0.45, 20);
    }
  }

  if(isDefined(attacker) && isai(attacker) && isalive(attacker)) {
    function_216c67ab6749137a(attacker, undefined, "shot_at_target", "target_unhurt");
  }

  time = gettime();

  if(function_43d3999d682de782(attacker, distance, position, forward, time)) {
    weapon = undefined;

    if(isPlayer(attacker) || isbot(attacker)) {
      weapon = attacker getcurrentweapon();
    } else if(isai(attacker)) {
      weapon = attacker.weapon;
    } else {
      assertmsg("<dev string:x20>");
    }

    weapclass = weaponclass(weapon);

    if(getDvar(@ "hash_a6017ebde71968e5") != "<dev string:x1c>") {
      switch (getDvar(@ "hash_a6017ebde71968e5")) {
        case #"hash_900cb06c552c5063":
          weapclass = "<dev string:x57>";
          break;
        case #"hash_28a7ce6c1f1955d9":
          weapclass = "<dev string:x65>";
          break;
        case #"hash_2f69646c2276faf4":
          weapclass = "<dev string:x75>";
          break;
      }
    }

    self notify("whizbyBlur_reset");
    var_85b3cf23250d4543 = function_21676cfe493c7014(weapclass, distance, time);
    function_2fad28813245304d(var_85b3cf23250d4543);
    function_b04dc57d51b057c(weapclass, weapon, var_85b3cf23250d4543);
    function_5e980dbce5b2122(attacker, position, time, var_85b3cf23250d4543, distance);
    self.whizby.lasttime = time;
    function_bcd1a794fb26ee5c();
  }
}

function function_43d3999d682de782(attacker, distance, position, forward, time) {
  if(getdvarint(@ "hash_15c99dd2f2a0921a", 1) != 1) {
    return false;
  }

  if(!isDefined(attacker) || !isDefined(distance) || !isDefined(position) || !isDefined(forward)) {
    return false;
  }

  if(!isai(attacker) && !isPlayer(attacker)) {
    return false;
  }

  if(!isalive(attacker)) {
    return false;
  }

  if(time - self.whizby.lasttime < self.whizby.cooldown) {
    return false;
  }

  if(!val::get("whizby")) {
    return false;
  }

  if(istrue(self.nowhizby)) {
    return false;
  }

  if(!isenemyteam(self.team, attacker.team)) {
    return false;
  }

  if(istrue(self.deathsdoor)) {
    return false;
  }

  if(function_cee14923e29e38ab(time)) {
    return false;
  }

  return true;
}

function function_cee14923e29e38ab(time) {
  if(!isDefined(self.lastdamagedtime)) {
    return false;
  }

  damagedcooldowntime = getdvarint(@ "hash_902f31627206f3", 750);

  if(self.lastdamagedtime + damagedcooldowntime > time) {
    return true;
  }

  return false;
}

function function_2fad28813245304d(var_85b3cf23250d4543) {
  zoomlevel = self playergetzoomfov();
  zoomfactor = math::normalize_value(4, 65, zoomlevel);
  var_15801234316e9c14 = math::factor_value(0.3, 0.85, zoomfactor);
  var_f8e72f77b5116a2f = math::factor_value(1, var_15801234316e9c14, self playerads());
  var_7ae8eaf92080ffc9 = math::factor_value(0.03, 0.28, var_85b3cf23250d4543);
  var_376b7286a8ff4b23 = math::factor_value(0.35, 0.35, var_85b3cf23250d4543);
  var_7ae8eaf92080ffc9 *= var_f8e72f77b5116a2f;
  self earthquakeforplayer(var_7ae8eaf92080ffc9, var_376b7286a8ff4b23, self.origin, 1000);
}

function function_b04dc57d51b057c(weapclass, weapon, var_85b3cf23250d4543) {
  eventtype = undefined;
  highestevent = 2;

  switch (weapclass) {
    case #"hash_fa24dff6bd60a12d":
      highestevent = 3;
      break;
    case #"hash_6191aaef9f922f96":
      if(string_starts_with("iw9_dm", weapon.basename)) {
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

  if(var_85b3cf23250d4543 < 0.3) {
    eventindex -= 2;
  } else if(var_85b3cf23250d4543 < 0.6) {
    eventindex -= 1;
  }

  switch (eventindex) {
    case 3:
      eventtype = "vsp_large";
      break;
    case 2:
      eventtype = "vsp_medium";
      break;
    case 1:
      eventtype = "vsp_small";
      break;
  }

  if(eventindex > 0) {
    self function_38e25fa379161404(eventtype);
  }
}

function function_5e980dbce5b2122(attacker, position, time, var_85b3cf23250d4543, distance) {
  playerang = self getplayerangles();
  eyepos = self getEye();
  playeraxis = anglestoaxis(playerang);
  attackerpos = attacker.origin + (0, 0, 50);
  toattackervec = vectorNormalize(attackerpos - eyepos);
  var_7caf68458d047d37 = vectordot(toattackervec, playeraxis["forward"]);
  var_31659d73698c898a = vectordot(toattackervec, playeraxis["right"]);
  var_7f628b9bd51160d5 = vectordot(toattackervec, playeraxis["up"]);
  var_3ca1b715ac9ad24e = attacker getentitynumber();
  var_dd9bb8522cc9e666 = clamp(var_7caf68458d047d37, 0, 1);
  var_b4b4994e3604ce34 = 1 - abs(var_7caf68458d047d37);
  var_f3dae9eeecbc6a28 = clamp(-1 * var_7caf68458d047d37, 0, 1);
  var_3783a488b009bc61 = function_dbabf852a35102e4(var_31659d73698c898a, var_7f628b9bd51160d5);
  backorigin = position + -500 * toattackervec;
  var_dd9bb8522cc9e666 = math::normalized_float_smooth_out(var_dd9bb8522cc9e666);
  var_b4b4994e3604ce34 = math::normalized_float_smooth_out(var_b4b4994e3604ce34);
  self setclientomnvar("ui_whizby_alpha_front", var_dd9bb8522cc9e666 * var_85b3cf23250d4543 * 0.5);
  self setclientomnvar("ui_whizby_alpha_side", var_b4b4994e3604ce34 * var_85b3cf23250d4543 * 1);
  self setclientomnvar("ui_whizby_alpha_back", var_f3dae9eeecbc6a28 * var_85b3cf23250d4543 * 1);
  self setclientomnvar("ui_whizby_side_angle", int(var_3783a488b009bc61));
  self setclientomnvar("ui_whizby_ent", var_3ca1b715ac9ad24e);
  self setclientomnvar("ui_whizby_back_x", int(backorigin[0]));
  self setclientomnvar("ui_whizby_back_y", int(backorigin[1]));
  self setclientomnvar("ui_whizby_back_z", int(backorigin[2]));
  xpos = self getclientomnvar("ui_whizby_back_x");
  ypos = self getclientomnvar("ui_whizby_back_y");
  zpos = self getclientomnvar("ui_whizby_back_z");
  self setclientomnvar("ui_whizby_notify", time);

  if(getdvarint(@ "hash_7774635c5712048e")) {
    function_708f66676f77c951(attacker, position, backorigin, var_85b3cf23250d4543, distance);
  }
}

function function_dbabf852a35102e4(var_31659d73698c898a, var_7f628b9bd51160d5) {
  var_45c4bee623ce2bf8 = abs(var_31659d73698c898a) + abs(var_7f628b9bd51160d5);

  if(var_45c4bee623ce2bf8 > 0) {
    rightfrac = var_31659d73698c898a / var_45c4bee623ce2bf8;
    upfrac = var_7f628b9bd51160d5 / var_45c4bee623ce2bf8;
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

function function_21676cfe493c7014(weapclass, distance, time) {
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

  distmultiplier = math::normalize_value(50, 120, distance);
  distmultiplier = factor_value(1, 0.5, distmultiplier);
  var_34d803dbf2021e83 = randomfloatrange(0.08, 0.27);
  timesincelast = time - self.whizby.lasttime;
  var_b2a42028cd0d9167 = math::normalize_value(2000, 6000, timesincelast);
  var_9416ac5e3a43d3bd = math::factor_value(var_34d803dbf2021e83, 1, var_b2a42028cd0d9167);
  return basemag * distmultiplier * var_9416ac5e3a43d3bd;
}

function function_bcd1a794fb26ee5c() {
  self.whizby.cooldown = randomfloatrange(100, 450);
}

function function_ecc51bc3ffb94164() {
  setdevdvar(@ "hash_15c99dd2f2a0921a", 1);

  if(isbot(self)) {
    return;
  }

  self endon("<dev string:x7f>");
  self endon("<dev string:x88>");
  thread function_4905c442ccddf750();

  while(true) {
    self waittill("<dev string:x96>");
    function_f3cad80dd510b802();
  }
}

function function_4905c442ccddf750() {
  while(true) {
    while(!self buttonPressed("<dev string:xa7>")) {
      wait 0.05;
    }

    self notify("<dev string:x96>");

    while(self buttonPressed("<dev string:xa7>")) {
      wait 0.05;
    }
  }
}

function function_f3cad80dd510b802() {
  self endon("<dev string:x96>");
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
      attacker = getclosest(self.origin, ai, 5000);
    }
  }

  effecttime = gettime();

  while(true) {
    if(isDefined(attacker)) {
      vecoffset = anglesToForward(self getplayerangles(1));
      dirtoattacker = vectorNormalize((attacker.origin[0], attacker.origin[1], 0) - (self.origin[0], self.origin[1], 0));
      var_86e3015864ec3379 = 1;
      vecoffset = rotatevector(dirtoattacker, (0, 90 * var_86e3015864ec3379, 0));
      height = (0, 0, randomfloatrange(45, 65));
      position = self.origin + height + vecoffset * dist[i];
      self notify("<dev string:xb5>", attacker, dist[i], position, dirtoattacker * -1);
      i++;

      if(i >= dist.size) {
        i = 0;
      }
    }

    switch (getDvar(@ "hash_a6017ebde71968e5")) {
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

function function_708f66676f77c951(attacker, position, backorigin, var_85b3cf23250d4543, distance) {
  if(isDefined(attacker) && isDefined(position)) {
    if(isDefined(attacker.currentweapon) && attacker tagexists("<dev string:xc5>")) {
      start = attacker gettagorigin("<dev string:xc5>");
    } else {
      start = attacker.origin + (0, 0, 50);
    }

    line(start, position, (1, 0, 0), 1, 1, 20);
    line(backorigin, position, (0.5, 0.5, 0.5), 1, 1, 20);
    iprintln("<dev string:xd2>" + distance + "<dev string:xed>" + var_85b3cf23250d4543 + "<dev string:x101>");
  }
}

# /