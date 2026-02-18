/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie_utility.gsc
***********************************************/

#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#namespace zombie_utility;

function zombiespawnsetup() {
  self.zombie_move_speed = "walk";

  if(!isDefined(self.zombie_arms_position)) {
    if(randomint(3) == 0) {
      self.zombie_arms_position = "up";
    } else {
      self.zombie_arms_position = "down";
    }
  }

  self function_df5afb5e(0);

  if(!is_true(self.ai.var_870d0893)) {
    self setavoidancemask("avoid none");
  }

  self collidewithactors(1);
  clientfield::set("zombie", 1);
  self.ignorepathenemyfightdist = 1;
}

function get_closest_valid_player(origin, ignore_player, ignore_laststand_players = 0) {
  pixbeginevent(#"");
  valid_player_found = 0;
  targets = getplayers();

  if(isDefined(level.closest_player_targets_override)) {
    targets = [[level.closest_player_targets_override]]();
  }

  if(isDefined(ignore_player)) {
    for(i = 0; i < ignore_player.size; i++) {
      arrayremovevalue(targets, ignore_player[i]);
    }
  }

  done = 1;

  while(targets.size && !done) {
    done = 1;

    for(i = 0; i < targets.size; i++) {
      target = targets[i];

      if(!is_player_valid(target, 1, ignore_laststand_players)) {
        arrayremovevalue(targets, target);
        done = 0;
        break;
      }
    }
  }

  if(targets.size == 0) {
    pixendevent();
    return undefined;
  }

  if(isDefined(self.closest_player_override)) {
    target = [[self.closest_player_override]](origin, targets);
  } else if(isDefined(level.closest_player_override)) {
    target = [[level.closest_player_override]](origin, targets);
  }

  if(isDefined(target)) {
    pixendevent();
    return target;
  }

  sortedpotentialtargets = arraysortclosest(targets, self.origin);

  while(sortedpotentialtargets.size) {
    if(is_player_valid(sortedpotentialtargets[0], 1, ignore_laststand_players)) {
      pixendevent();
      return sortedpotentialtargets[0];
    }

    arrayremovevalue(sortedpotentialtargets, sortedpotentialtargets[0]);
  }

  pixendevent();
  return undefined;
}

function is_player_valid(player, checkignoremeflag, ignore_laststand_players, var_da861165 = 1) {
  if(!isDefined(player)) {
    return 0;
  }

  if(!isalive(player)) {
    return 0;
  }

  if(!isPlayer(player)) {
    return 0;
  }

  if(isDefined(player.is_zombie) && player.is_zombie == 1) {
    return 0;
  }

  if(player.sessionstate == "spectator") {
    return 0;
  }

  if(player.sessionstate == "intermission") {
    return 0;
  }

  if(!var_da861165 && player scene::is_igc_active()) {
    return 0;
  }

  if(is_true(player.intermission)) {
    return 0;
  }

  if(!is_true(ignore_laststand_players)) {
    if(player laststand::player_is_in_laststand()) {
      return 0;
    }
  }

  if(is_true(checkignoremeflag) && (player.ignoreme || player isnotarget())) {
    return 0;
  }

  if(isDefined(level.is_player_valid_override)) {
    return [[level.is_player_valid_override]](player);
  }

  return 1;
}

function append_missing_legs_suffix(animstate) {
  if(is_true(self.missinglegs) && self hasanimstatefromasd(animstate + "_crawl")) {
    return (animstate + "_crawl");
  }

  return animstate;
}

function initanimtree(animscript) {
  if(animscript != "pain" && animscript != "death") {
    self.a.special = "none";
  }

  assert(isDefined(animscript), "<dev string:x38>");
  self.a.script = animscript;
}

function updateanimpose() {
  assert(self.a.movement == "<dev string:x64>" || self.a.movement == "<dev string:x6c>" || self.a.movement == "<dev string:x74>", "<dev string:x7b>" + self.a.pose + "<dev string:x8e>" + self.a.movement);
  self.desired_anim_pose = undefined;
}

function initialize(animscript) {
  if(isDefined(self.longdeathstarting)) {
    if(animscript != "pain" && animscript != "death") {
      self dodamage(self.health + 100, self.origin);
    }

    if(animscript != "pain") {
      self.longdeathstarting = undefined;
      self notify(#"kill_long_death");
    }
  }

  if(isDefined(self.a.mayonlydie) && animscript != "death") {
    self dodamage(self.health + 100, self.origin);
  }

  if(isDefined(self.a.postscriptfunc)) {
    scriptfunc = self.a.postscriptfunc;
    self.a.postscriptfunc = undefined;
    [[scriptfunc]](animscript);
  }

  if(animscript != "death") {
    self.a.nodeath = 0;
  }

  self.isholdinggrenade = undefined;
  self.covernode = undefined;
  self.changingcoverpos = 0;
  self.a.scriptstarttime = gettime();
  self.a.atconcealmentnode = 0;

  if(isDefined(self.node) && (self.node.type == # "conceal crouch" || self.node.type == # "conceal stand")) {
    self.a.atconcealmentnode = 1;
  }

  initanimtree(animscript);
  updateanimpose();
}

function getnodeyawtoorigin(pos) {
  if(isDefined(self.node)) {
    yaw = self.node.angles[1] - getyaw(pos);
  } else {
    yaw = self.angles[1] - getyaw(pos);
  }

  yaw = angleclamp180(yaw);
  return yaw;
}

function getnodeyawtoenemy() {
  pos = undefined;

  if(isvalidenemy(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    if(isDefined(self.node)) {
      forward = anglesToForward(self.node.angles);
    } else {
      forward = anglesToForward(self.angles);
    }

    forward = vectorscale(forward, 150);
    pos = self.origin + forward;
  }

  if(isDefined(self.node)) {
    yaw = self.node.angles[1] - getyaw(pos);
  } else {
    yaw = self.angles[1] - getyaw(pos);
  }

  yaw = angleclamp180(yaw);
  return yaw;
}

function getcovernodeyawtoenemy() {
  pos = undefined;

  if(isvalidenemy(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    forward = anglesToForward(self.covernode.angles + self.animarray[# "angle_step_out"][self.a.cornermode]);
    forward = vectorscale(forward, 150);
    pos = self.origin + forward;
  }

  yaw = self.covernode.angles[1] + self.animarray[# "angle_step_out"][self.a.cornermode] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyawtospot(spot) {
  pos = spot;
  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyawtoenemy() {
  pos = undefined;

  if(isvalidenemy(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    forward = anglesToForward(self.angles);
    forward = vectorscale(forward, 150);
    pos = self.origin + forward;
  }

  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function getyaw2d(org) {
  angles = vectortoangles((org[0], org[1], 0) - (self.origin[0], self.origin[1], 0));
  return angles[1];
}

function absyawtoenemy() {
  assert(isvalidenemy(self.enemy));
  yaw = self.angles[1] - getyaw(self.enemy.origin);
  yaw = angleclamp180(yaw);

  if(yaw < 0) {
    yaw = -1 * yaw;
  }

  return yaw;
}

function absyawtoenemy2d() {
  assert(isvalidenemy(self.enemy));
  yaw = self.angles[1] - getyaw2d(self.enemy.origin);
  yaw = angleclamp180(yaw);

  if(yaw < 0) {
    yaw = -1 * yaw;
  }

  return yaw;
}

function absyawtoorigin(org) {
  yaw = self.angles[1] - getyaw(org);
  yaw = angleclamp180(yaw);

  if(yaw < 0) {
    yaw = -1 * yaw;
  }

  return yaw;
}

function absyawtoangles(angles) {
  yaw = self.angles[1] - angles;
  yaw = angleclamp180(yaw);

  if(yaw < 0) {
    yaw = -1 * yaw;
  }

  return yaw;
}

function getyawfromorigin(org, start) {
  angles = vectortoangles(org - start);
  return angles[1];
}

function getyawtotag(tag, org) {
  yaw = self gettagangles(tag)[1] - getyawfromorigin(org, self gettagorigin(tag));
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyawtoorigin(org) {
  yaw = self.angles[1] - getyaw(org);
  yaw = angleclamp180(yaw);
  return yaw;
}

function geteyeyawtoorigin(org) {
  yaw = self gettagangles("TAG_EYE")[1] - getyaw(org);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getcovernodeyawtoorigin(org) {
  yaw = self.covernode.angles[1] + self.animarray[# "angle_step_out"][self.a.cornermode] - getyaw(org);
  yaw = angleclamp180(yaw);
  return yaw;
}

function isstanceallowedwrapper(stance) {
  if(isDefined(self.covernode)) {
    return doesnodeallowstance(self.covernode, stance);
  }

  return self isstanceallowed(stance);
}

function getclaimednode() {
  mynode = self.node;

  if(isDefined(mynode) && (self nearnode(mynode) || isDefined(self.covernode) && mynode == self.covernode)) {
    return mynode;
  }

  return undefined;
}

function getnodetype() {
  mynode = getclaimednode();

  if(isDefined(mynode)) {
    return mynode.type;
  }

  return "none";
}

function getnodedirection() {
  mynode = getclaimednode();

  if(isDefined(mynode)) {
    return mynode.angles[1];
  }

  return self.desiredangle;
}

function getnodeforward() {
  mynode = getclaimednode();

  if(isDefined(mynode)) {
    return anglesToForward(mynode.angles);
  }

  return anglesToForward(self.angles);
}

function getnodeorigin() {
  mynode = getclaimednode();

  if(isDefined(mynode)) {
    return mynode.origin;
  }

  return self.origin;
}

function safemod(a, b) {
  result = int(a) % b;
  result += b;
  return result % b;
}

function angleclamp(angle) {
  anglefrac = angle / 360;
  angle = (anglefrac - floor(anglefrac)) * 360;
  return angle;
}

function quadrantanimweights(yaw) {
  forwardweight = (90 - abs(yaw)) / 90;
  leftweight = (90 - absangleclamp180(abs(yaw - 90))) / 90;
  result[# "front"] = 0;
  result[# "right"] = 0;
  result[# "back"] = 0;
  result[# "left"] = 0;

  if(isDefined(self.alwaysrunforward)) {
    assert(self.alwaysrunforward);
    result[# "front"] = 1;
    return result;
  }

  useleans = getdvarint(#"ai_useleanrunanimations", 0);

  if(forwardweight > 0) {
    result[# "front"] = forwardweight;

    if(leftweight > 0) {
      result[# "left"] = leftweight;
    } else {
      result[# "right"] = -1 * leftweight;
    }
  } else if(useleans) {
    result[# "back"] = -1 * forwardweight;

    if(leftweight > 0) {
      result[# "left"] = leftweight;
    } else {
      result[# "right"] = -1 * leftweight;
    }
  } else {
    backweight = -1 * forwardweight;

    if(leftweight > backweight) {
      result[# "left"] = 1;
    } else if(leftweight < forwardweight) {
      result[# "right"] = 1;
    } else {
      result[# "back"] = 1;
    }
  }

  return result;
}

function getquadrant(angle) {
  angle = angleclamp(angle);

  if(angle < 45 || angle > 315) {
    quadrant = "front";
  } else if(angle < 135) {
    quadrant = "left";
  } else if(angle < 225) {
    quadrant = "back";
  } else {
    quadrant = "right";
  }

  return quadrant;
}

function isinset(input, set) {
  for(i = set.size - 1; i >= 0; i--) {
    if(input == set[i]) {
      return true;
    }
  }

  return false;
}

function notifyaftertime(notifystring, killmestring, time) {
  self endon(#"death", killmestring);
  wait time;
  self notify(notifystring);
}

function drawstringtime(msg, org, color, timer) {
  maxtime = timer * 20;

  for(i = 0; i < maxtime; i++) {
    print3d(org, msg, color, 1, 1);
    waitframe(1);
  }
}

function showlastenemysightpos(string) {
  self notify(#"got known enemy2");
  self endon(#"got known enemy2", #"death");

  if(!isvalidenemy(self.enemy)) {
    return;
  }

  if(self.enemy.team == # "allies") {
    color = (0.4, 0.7, 1);
  } else {
    color = (1, 0.7, 0.4);
  }

  while(true) {
    waitframe(1);

    if(!isDefined(self.lastenemysightpos)) {
      continue;
    }

    print3d(self.lastenemysightpos, string, color, 1, 2.15);
  }
}

function debugtimeout() {
  wait 5;
  self notify(#"timeout");
}

function debugposinternal(org, string, size) {
  self endon(#"death");
  self notify("<dev string:x93>" + org);
  self endon("<dev string:x93>" + org);
  ent = spawnStruct();
  ent thread debugtimeout();
  ent endon(#"timeout");

  if(self.enemy.team == # "allies") {
    color = (0.4, 0.7, 1);
  } else {
    color = (1, 0.7, 0.4);
  }

  while(true) {
    waitframe(1);
    print3d(org, string, color, 1, size);
  }
}

function debugpos(org, string) {
  thread debugposinternal(org, string, 2.15);
}

function debugpossize(org, string, size) {
  thread debugposinternal(org, string, size);
}

function showdebugproc(frompoint, topoint, color, printtime) {
  self endon(#"death");
  timer = printtime * 20;
  i = 0;

  while(i < timer) {
    waitframe(1);
    line(frompoint, topoint, color);
    i += 1;
  }
}

function showdebugline(frompoint, topoint, color, printtime) {
  self thread showdebugproc(frompoint, topoint + (0, 0, -5), color, printtime);
}

function getnodeoffset(node) {
  if(isDefined(node.offset)) {
    return node.offset;
  }

  cover_left_crouch_offset = (-26, 0.4, 36);
  cover_left_stand_offset = (-32, 7, 63);
  cover_right_crouch_offset = (43.5, 11, 36);
  cover_right_stand_offset = (36, 8.3, 63);
  cover_crouch_offset = (3.5, -12.5, 45);
  cover_stand_offset = (-3.7, -22, 63);
  cornernode = 0;
  nodeoffset = (0, 0, 0);
  right = anglestoright(node.angles);
  forward = anglesToForward(node.angles);

  switch (node.type) {
    case # "hash_4767a02d3b3b87cc":
    case # "cover left":
      if(node isnodedontstand() && !node isnodedontcrouch()) {
        nodeoffset = calculatenodeoffset(right, forward, cover_left_crouch_offset);
      } else {
        nodeoffset = calculatenodeoffset(right, forward, cover_left_stand_offset);
      }

      break;
    case # "cover right":
    case # "hash_3aeea178f890eb31":
      if(node isnodedontstand() && !node isnodedontcrouch()) {
        nodeoffset = calculatenodeoffset(right, forward, cover_right_crouch_offset);
      } else {
        nodeoffset = calculatenodeoffset(right, forward, cover_right_stand_offset);
      }

      break;
    case # "conceal stand":
    case # "turret":
    case # "cover stand":
      nodeoffset = calculatenodeoffset(right, forward, cover_stand_offset);
      break;
    case # "conceal crouch":
    case # "cover crouch window":
    case # "cover crouch":
      nodeoffset = calculatenodeoffset(right, forward, cover_crouch_offset);
      break;
  }

  node.offset = nodeoffset;
  return node.offset;
}

function calculatenodeoffset(right, forward, baseoffset) {
  return vectorscale(right, baseoffset[0]) + vectorscale(forward, baseoffset[1]) + (0, 0, baseoffset[2]);
}

function showlines(start, end, end2) {
  for(;;) {
    line(start, end, (1, 0, 0), 1);
    waitframe(1);
    line(start, end2, (0, 0, 1), 1);
    waitframe(1);
  }
}

function anim_array(animarray, animweights) {
  total_anims = animarray.size;
  idleanim = randomint(total_anims);
  assert(total_anims);
  assert(animarray.size == animweights.size);

  if(total_anims == 1) {
    return animarray[0];
  }

  weights = 0;
  total_weight = 0;

  for(i = 0; i < total_anims; i++) {
    total_weight += animweights[i];
  }

  anim_play = randomfloat(total_weight);
  current_weight = 0;

  for(i = 0; i < total_anims; i++) {
    current_weight += animweights[i];

    if(anim_play >= current_weight) {
      continue;
    }

    idleanim = i;
    break;
  }

  return animarray[idleanim];
}

function notforcedcover() {
  return self.a.forced_cover == "none" || self.a.forced_cover == "Show";
}

function forcedcover(msg) {
  return isDefined(self.a.forced_cover) && self.a.forced_cover == msg;
}

function print3dtime(timer, org, msg, color, alpha, scale) {
  newtime = timer / 0.05;

  for(i = 0; i < newtime; i++) {
    print3d(org, msg, color, alpha, scale);
    waitframe(1);
  }
}

function print3drise(org, msg, color, alpha, scale) {
  newtime = 100;
  up = 0;
  org = org;

  for(i = 0; i < newtime; i++) {
    up += 0.5;
    print3d(org + (0, 0, up), msg, color, alpha, scale);
    waitframe(1);
  }
}

function random_weight(array) {
  idleanim = randomint(array.size);

  if(array.size > 1) {
    anim_weight = 0;

    for(i = 0; i < array.size; i++) {
      anim_weight += array[i];
    }

    anim_play = randomfloat(anim_weight);
    anim_weight = 0;

    for(i = 0; i < array.size; i++) {
      anim_weight += array[i];

      if(anim_play < anim_weight) {
        idleanim = i;
        break;
      }
    }
  }

  return idleanim;
}

function persistentdebugline(start, end) {
  self endon(#"death");
  level notify(#"newdebugline");
  level endon(#"newdebugline");

  for(;;) {
    line(start, end, (0.3, 1, 0), 1);
    waitframe(1);
  }
}

function isnodedontstand() {
  return (self.spawnflags & 4) == 4;
}

function isnodedontcrouch() {
  return (self.spawnflags & 8) == 8;
}

function animarray(animname) {
  assert(isDefined(self.a.array));

  if(!isDefined(self.a.array[animname])) {
    dumpanimarray();
    assert(isDefined(self.a.array[animname]), "<dev string:xa2>" + animname + "<dev string:xb5>");
  }

  return self.a.array[animname];
}

function animarrayanyexist(animname) {
  assert(isDefined(self.a.array));

  if(!isDefined(self.a.array[animname])) {
    dumpanimarray();
    assert(isDefined(self.a.array[animname]), "<dev string:xa2>" + animname + "<dev string:xb5>");
  }

  return self.a.array[animname].size > 0;
}

function animarraypickrandom(animname) {
  assert(isDefined(self.a.array));

  if(!isDefined(self.a.array[animname])) {
    dumpanimarray();
    assert(isDefined(self.a.array[animname]), "<dev string:xa2>" + animname + "<dev string:xb5>");
  }

  assert(self.a.array[animname].size > 0);

  if(self.a.array[animname].size > 1) {
    index = randomint(self.a.array[animname].size);
  } else {
    index = 0;
  }

  return self.a.array[animname][index];
}

function dumpanimarray() {
  println("<dev string:xc9>");

  foreach(k, v in self.a.array) {
    if(isarray(v)) {
      println("<dev string:xda>" + k + "<dev string:xe7>" + v.size + "<dev string:x100>");
      continue;
    }

    println("<dev string:xda>" + k + "<dev string:x105>", v);
  }
}

function getanimendpos(theanim) {
  movedelta = getmovedelta(theanim, 0, 1);
  return self localtoworldcoords(movedelta);
}

function isvalidenemy(enemy) {
  if(!isDefined(enemy)) {
    return false;
  }

  return true;
}

function damagelocationisany(a, b, c, d, e, f, g, h, i, j, k, ovr) {
  if(!isDefined(self.damagelocation)) {
    return false;
  }

  if(!isDefined(a)) {
    return false;
  }

  if(self.damagelocation == a) {
    return true;
  }

  if(!isDefined(b)) {
    return false;
  }

  if(self.damagelocation == b) {
    return true;
  }

  if(!isDefined(c)) {
    return false;
  }

  if(self.damagelocation == c) {
    return true;
  }

  if(!isDefined(d)) {
    return false;
  }

  if(self.damagelocation == d) {
    return true;
  }

  if(!isDefined(e)) {
    return false;
  }

  if(self.damagelocation == e) {
    return true;
  }

  if(!isDefined(f)) {
    return false;
  }

  if(self.damagelocation == f) {
    return true;
  }

  if(!isDefined(g)) {
    return false;
  }

  if(self.damagelocation == g) {
    return true;
  }

  if(!isDefined(h)) {
    return false;
  }

  if(self.damagelocation == h) {
    return true;
  }

  if(!isDefined(i)) {
    return false;
  }

  if(self.damagelocation == i) {
    return true;
  }

  if(!isDefined(j)) {
    return false;
  }

  if(self.damagelocation == j) {
    return true;
  }

  if(!isDefined(k)) {
    return false;
  }

  if(self.damagelocation == k) {
    return true;
  }

  assert(!isDefined(ovr));
  return false;
}

function set_orient_mode(mode, val1) {
  if(level.dog_debug_orient == self getentnum()) {
    if(isDefined(val1)) {
      println("<dev string:x10f>" + mode + "<dev string:x8e>" + val1 + "<dev string:x8e>" + gettime());
    } else {
      println("<dev string:x10f>" + mode + "<dev string:x8e>" + gettime());
    }
  }

  if(isDefined(val1)) {
    self orientmode(mode, val1);
    return;
  }

  self orientmode(mode);
}

function debug_anim_print(text) {
  if(isDefined(level.dog_debug_anims) && level.dog_debug_anims) {
    println(text + "<dev string:x8e>" + gettime());
  }

  if(isDefined(level.dog_debug_anims_ent) && level.dog_debug_anims_ent == self getentnum()) {
    println(text + "<dev string:x8e>" + gettime());
  }
}

function debug_turn_print(text, line) {
  if(isDefined(level.dog_debug_turns) && level.dog_debug_turns == self getentnum()) {
    duration = 200;
    currentyawcolor = (1, 1, 1);
    lookaheadyawcolor = (1, 0, 0);
    desiredyawcolor = (1, 1, 0);
    currentyaw = angleclamp180(self.angles[1]);
    desiredyaw = angleclamp180(self.desiredangle);
    lookaheaddir = self.lookaheaddir;
    lookaheadangles = vectortoangles(lookaheaddir);
    lookaheadyaw = angleclamp180(lookaheadangles[1]);
    println(line + "<dev string:x8e>" + gettime() + "<dev string:x12e>" + currentyaw + "<dev string:x138>" + lookaheadyaw + "<dev string:x143>" + desiredyaw);
  }
}

function set_zombie_var(zvar, value, defaultvalue, is_team_based = 0) {
  if(!isDefined(level.zombie_vars)) {
    level.zombie_vars = [];
  }

  if(!isDefined(value)) {
    value = defaultvalue;
  }

  if(is_team_based) {
    foreach(team, _ in level.teams) {
      if(!isDefined(level.zombie_vars[team])) {
        level.zombie_vars[team] = [];
      }

      level.zombie_vars[team][zvar] = value;
    }
  } else {
    level.zombie_vars[zvar] = value;
  }

  return value;
}

function set_zombie_var_team(zvar, team, value) {
  if(!isDefined(level.zombie_vars)) {
    level.zombie_vars = [];
  }

  if(!isDefined(level.zombie_vars[team])) {
    level.zombie_vars[team] = [];
  }

  level.zombie_vars[team][zvar] = value;
  return value;
}

function get_zombie_var(zvar) {
  if(!isDefined(level.zombie_vars)) {
    level.zombie_vars = [];
  }

  return level.zombie_vars[zvar];
}

function get_zombie_var_team(zvar, team) {
  if(isDefined(level.zombie_vars[team])) {
    return level.zombie_vars[team][zvar];
  }
}

function set_zombie_var_player(zvar, value) {
  assert(isPlayer(self), "<dev string:x151>");

  if(!isDefined(self.zombie_vars)) {
    self.zombie_vars = [];
  }

  self.zombie_vars[zvar] = value;
}

function get_zombie_var_player(zvar) {
  assert(isPlayer(self), "<dev string:x186>");

  if(!isDefined(self.zombie_vars)) {
    self.zombie_vars = [];
  }

  return self.zombie_vars[zvar];
}

function spawn_zombie(spawner, target_name, spawn_point, round_number) {
  if(!isDefined(spawner)) {
    println("<dev string:x1bb>");
    return undefined;
  }

  while(getfreeactorcount() < 1) {
    waitframe(1);
  }

  spawner.script_moveoverride = 1;

  if(is_true(spawner.script_forcespawn)) {
    if(isactorspawner(spawner) && isDefined(level.overridezombiespawn)) {
      guy = [[level.overridezombiespawn]](spawner, target_name, spawn_point, round_number);
    } else {
      guy = spawner spawnfromspawner(0, 1);
    }

    if(!zombie_spawn_failed(guy)) {
      if(isDefined(level.giveextrazombies)) {
        guy[[level.giveextrazombies]]();
      }

      guy enableaimassist();

      if(isDefined(round_number)) {
        guy._starting_round_number = round_number;
      }

      if(isDefined(level.zombie_team)) {
        guy.team = level.zombie_team;
      }

      if(isactor(guy)) {
        guy clearentityowner();
      }

      level.zombiemeleeplayercounter = 0;

      if(isactor(guy)) {
        guy forceteleport(spawner.origin);
      }

      guy show();
      spawner.count = 666;

      if(isDefined(target_name)) {
        guy.targetname = target_name;
      }

      if(isDefined(spawn_point) && isDefined(level.move_spawn_func)) {
        guy thread[[level.move_spawn_func]](spawn_point);
      }

      if(isDefined(spawner.zm_variant_type)) {
        guy.variant_type = spawner.zm_variant_type;
      }

      return guy;
    } else {
      println("<dev string:x1e6>", spawner.origin);
      return undefined;
    }
  } else {
    println("<dev string:x228>", spawner.origin);
    return undefined;
  }

  return undefined;
}

function zombie_spawn_failed(spawn) {
  if(isDefined(spawn) && isalive(spawn)) {
    if(isalive(spawn)) {
      return false;
    }
  }

  return true;
}

function get_desired_origin() {
  if(isDefined(self.target)) {
    ent = getent(self.target, "targetname");

    if(!isDefined(ent)) {
      ent = struct::get(self.target, "targetname");
    }

    if(!isDefined(ent)) {
      ent = getnode(self.target, "targetname");
    }

    assert(isDefined(ent), "<dev string:x266>" + self.target + "<dev string:x295>" + self.origin);
    return ent.origin;
  }

  return undefined;
}

function hide_pop() {
  self endon(#"death");
  self ghost();
  wait 0.5;

  if(isDefined(self)) {
    self show();
    util::wait_network_frame();

    if(isDefined(self)) {
      self.create_eyes = 1;
    }
  }
}

function handle_rise_notetracks(note, spot) {
  self thread finish_rise_notetracks(note, spot);
}

function finish_rise_notetracks(note, spot) {
  if(note == "deathout" || note == "deathhigh") {
    self.zombie_rise_death_out = 1;
    self notify(#"zombie_rise_death_out");
    wait 2;
    spot notify(#"stop_zombie_rise_fx");
  }
}

function zombie_rise_death(zombie, spot) {
  zombie.zombie_rise_death_out = 0;
  zombie endon(#"rise_anim_finished", #"death");

  while(isDefined(zombie) && isDefined(zombie.health) && zombie.health > 1) {
    zombie waittill(#"damage");
  }

  if(isDefined(spot)) {
    spot notify(#"stop_zombie_rise_fx");
  }

  if(isDefined(zombie)) {
    zombie.deathanim = zombie get_rise_death_anim();
    zombie stopanimscripted();
  }
}

function get_rise_death_anim() {
  if(self.zombie_rise_death_out) {
    return "zm_rise_death_out";
  }

  self.noragdoll = 1;
  self.nodeathragdoll = 1;
  return "zm_rise_death_in";
}

function reset_attack_spot() {
  if(isDefined(self .601)) {
    node = self .601;
    index = self.attacking_spot_index;
    node.attack_spots_taken[index] = 0;
    node notify(#"hash_45aa77702fef26f4");
  }

  self .601 = undefined;
  self.attacking_spot_index = undefined;
  self.attacking_spot = undefined;
}

function zombie_gut_explosion() {
  self.guts_explosion = 1;
  self playSound(#"zmb_zombie_head_gib");
  gibserverutils::annihilate(self);
}

function round_spawn_failsafe_debug_draw() {
  self notify("69e0e8d96408dd3f");
  self endon("69e0e8d96408dd3f");
  self endon(#"death");

  for(prevorigin = self.origin; true; prevorigin = self.origin) {
    if(is_true(level.toggle_keyline_always)) {
      self clientfield::set("zombie_keyline_render", 1);
      wait 1;
      continue;
    }

    wait 4;

    if(isDefined(self.lastchunk_destroy_time)) {
      if(gettime() - self.lastchunk_destroy_time < 8000) {
        continue;
      }
    }

    if(distancesquared(self.origin, prevorigin) < 576) {
      self clientfield::set("zombie_keyline_render", 1);
      continue;
    }

    self clientfield::set("zombie_keyline_render", 0);
  }
}

function round_spawn_failsafe() {
  self notify("43cc888a1767e905");
  self endon("43cc888a1767e905");
  self endon(#"death");

  if(is_true(level.debug_keyline_zombies)) {
    self thread round_spawn_failsafe_debug_draw();
  }

  for(v_prev_origin = self.origin; true; v_prev_origin = self.origin) {
    if(!get_zombie_var(#"zombie_use_failsafe")) {
      return;
    }

    if(is_true(self.ignore_round_spawn_failsafe)) {
      return;
    }

    if(!isDefined(level.failsafe_waittime)) {
      level.failsafe_waittime = 30;
    }

    wait level.failsafe_waittime;

    if(is_true(self.missinglegs)) {
      wait 10;
    }

    if(is_true(self.is_inert)) {
      continue;
    }

    if(isDefined(self.lastchunk_destroy_time) && gettime() - self.lastchunk_destroy_time < 8000) {
      continue;
    }

    if(self.origin[2] < get_zombie_var(#"below_world_check")) {
      if(isDefined(level.var_455393ef)) {
        self thread[[level.var_455393ef]](v_prev_origin);
      } else {
        if(is_true(level.put_timed_out_zombies_back_in_queue) && !is_true(self.isscreecher)) {
          level.zombie_total++;
          level.zombie_total_subtract++;
        }

        self.var_e700d5e2 = 1;
        self.allowdeath = 1;
        self kill(undefined, undefined, undefined, undefined, undefined, 1);
      }

      break;
    }

    var_25e376fd = 0;

    if(isDefined(level.var_62fc4786)) {
      var_25e376fd = self[[level.var_62fc4786]](v_prev_origin);
    } else if(distancesquared(self.origin, v_prev_origin) < 576) {
      var_25e376fd = 1;
    }

    if(var_25e376fd) {
      if(isDefined(level.var_455393ef)) {
        self thread[[level.var_455393ef]](v_prev_origin);
      } else {
        if(is_true(level.put_timed_out_zombies_back_in_queue)) {
          if(!is_true(self.nuked) && !is_true(self.marked_for_death) && !is_true(self.isscreecher) && !is_true(self.missinglegs)) {
            level.zombie_total++;
            level.zombie_total_subtract++;
            var_1a8c05ae = {
              #n_health: self.health, #var_e0d660f6: self.var_e0d660f6
            };

            if(!isDefined(level.var_fc73bad4[self.archetype])) {
              level.var_fc73bad4[self.archetype] = [];
            } else if(!isarray(level.var_fc73bad4[self.archetype])) {
              level.var_fc73bad4[self.archetype] = array(level.var_fc73bad4[self.archetype]);
            }

            level.var_fc73bad4[self.archetype][level.var_fc73bad4[self.archetype].size] = var_1a8c05ae;
          }
        }

        level.zombies_timeout_playspace++;
        self.var_e700d5e2 = 1;
        self.allowdeath = 1;
        self kill(undefined, undefined, undefined, undefined, undefined, 1);
      }

      break;
    }
  }
}

function ai_calculate_health(base_health, round_number) {
  if(isDefined(level.var_5d1805c4)) {
    var_d082c739 = [[level.var_5d1805c4]](base_health, round_number);

    if(var_d082c739 >= 0) {
      return var_d082c739;
    }
  }

  if(util::get_game_type() == # "zclassic" && level.gamedifficulty < 2 && round_number > 35) {
    round_number = 35;
  }

  var_d082c739 = base_health;

  for(i = 2; i <= round_number; i++) {
    if(i >= 10 && !is_true(level.var_50dd0ec5)) {
      old_health = var_d082c739;
      var_d082c739 += int(var_d082c739 * get_zombie_var(#"zombie_health_increase_multiplier"));

      if(var_d082c739 < old_health) {
        var_d082c739 = old_health;
        break;
      }

      continue;
    }

    var_d082c739 = int(var_d082c739 + get_zombie_var(#"zombie_health_increase"));
  }

  return var_d082c739;
}

function default_max_zombie_func(max_num, n_round) {
  count = getdvarint(#"zombie_default_max", -1);

  if(count > -1) {
    return count;
  }

  n_players = getplayers().size;
  var_872cd28a = array(6, 8, 11, 14, 17);
  var_753ada67 = array(9, 11, 14, 18, 21);
  var_41446be2 = array(13, 15, 20, 25, 31);
  var_68849261 = array(18, 20, 25, 33, 40);
  var_979708f = array(24, 25, 32, 42, 48);

  switch (n_round) {
    case 1:
      max = var_872cd28a[n_players - 1];
      break;
    case 2:
      max = var_753ada67[n_players - 1];
      break;
    case 3:
      max = var_41446be2[n_players - 1];
      break;
    case 4:
      max = var_68849261[n_players - 1];
      break;
    case 5:
      max = var_979708f[n_players - 1];
      break;
    default:
      max = max_num;
      break;
  }

  return max;
}

function get_current_zombie_count() {
  enemies = get_round_enemy_array();
  return enemies.size;
}

function get_round_enemy_array() {
  a_ai_enemies = [];
  a_ai_valid_enemies = [];
  a_ai_enemies = getaiteamarray(level.zombie_team);

  for(i = 0; i < a_ai_enemies.size; i++) {
    if(is_true(a_ai_enemies[i].ignore_enemy_count)) {
      continue;
    }

    if(!isDefined(a_ai_valid_enemies)) {
      a_ai_valid_enemies = [];
    } else if(!isarray(a_ai_valid_enemies)) {
      a_ai_valid_enemies = array(a_ai_valid_enemies);
    }

    a_ai_valid_enemies[a_ai_valid_enemies.size] = a_ai_enemies[i];
  }

  return a_ai_valid_enemies;
}

function get_zombie_array() {
  valid_enemies = getaiarchetypearray(#"zombie", level.zombie_team);
  return valid_enemies;
}

function set_zombie_run_cycle_override_value(new_move_speed) {
  set_zombie_run_cycle(new_move_speed);
  self.zombie_move_speed_override = new_move_speed;
}

function set_zombie_run_cycle_restore_from_override() {
  str_restore_move_speed = self.zombie_move_speed_restore;
  self.zombie_move_speed_override = undefined;
  set_zombie_run_cycle(str_restore_move_speed);
}

function function_d2f660ce(var_a598c292) {
  if(is_true(self.var_b518759e)) {
    return var_a598c292;
  }

  if(isDefined(level.var_43fb4347)) {
    switch (level.var_43fb4347) {
      case # "run":
        if(var_a598c292 == "walk") {
          var_70b46d1c = "run";
        }

        break;
      case # "sprint":
        if(var_a598c292 == "walk" || var_a598c292 == "run") {
          var_70b46d1c = "sprint";
        }

        break;
      case # "super_sprint":
        if(var_a598c292 != "super_sprint") {
          var_70b46d1c = "super_sprint";
        }

        break;
    }
  }

  if(isDefined(level.var_102b1301)) {
    switch (level.var_102b1301) {
      case # "walk":
        if(var_a598c292 != "walk") {
          var_70b46d1c = "walk";
        }

        break;
      case # "run":
        if(var_a598c292 == "sprint" || var_a598c292 == "super_sprint") {
          var_70b46d1c = "run";
        }

        break;
      case # "sprint":
        if(var_a598c292 == "super_sprint") {
          var_70b46d1c = "sprint";
        }

        break;
    }
  }

  if(isDefined(var_70b46d1c)) {
    return var_70b46d1c;
  }

  return var_a598c292;
}

function set_zombie_run_cycle(new_move_speed) {
  if(isDefined(level.var_deb2145c)) {
    self[[level.var_deb2145c]]();
    return;
  }

  if(isDefined(self.zombie_move_speed_override)) {
    self.zombie_move_speed_restore = self function_d2f660ce(self.zombie_move_speed_override);
    return;
  }

  if(isDefined(new_move_speed)) {
    self.zombie_move_speed = new_move_speed;
  } else if(level.gamedifficulty === 0) {
    self.zombie_move_speed = function_33da7a07(1);
  } else {
    self.zombie_move_speed = function_33da7a07();
  }

  self.zombie_move_speed = self function_d2f660ce(self.zombie_move_speed);

  if(isDefined(level.zm_variant_type_max)) {
    if(false) {
      debug_variant_type = getdvarint(#"scr_zombie_variant_type", -1);

      if(debug_variant_type != -1) {
        if(debug_variant_type <= level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]) {
          self.variant_type = debug_variant_type;
        } else {
          self.variant_type = level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position] - 1;
        }
      } else {
        self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
      }
    }

    if(self.archetype === # "zombie" || self.archetype === # "catalyst") {
      if(isDefined(self.zm_variant_type_max)) {
        self.variant_type = randomint(self.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
      } else {
        self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
      }
    }
  }

  self.needs_run_update = 1;
  self notify(#"needs_run_update");
  self.deathanim = self append_missing_legs_suffix("zm_death");
  self callback::callback(#"hash_dfbeaa068b23e7c");
}

function function_33da7a07(is_easy) {
  if(!isDefined(self._starting_round_number)) {
    self._starting_round_number = level.round_number;
  }

  if(self._starting_round_number == 1) {
    n_move_speed = 1;
  } else {
    n_move_speed = int(self._starting_round_number * get_zombie_var(#"zombie_move_speed_multiplier"));
  }

  var_750836cc = randomintrange(n_move_speed, n_move_speed + 35);
  return function_f9c50a93(var_750836cc, is_easy);
}

function function_f9c50a93(move_speed, is_easy) {
  if(is_true(is_easy)) {
    if(move_speed <= 35) {
      return "walk";
    } else {
      return "run";
    }
  }

  if(move_speed <= 35) {
    return "walk";
  }

  if(move_speed <= 70) {
    return "run";
  }

  if(move_speed <= 236) {
    return "sprint";
  }

  return "super_sprint";
}

function function_9e46a191(speed) {
  switch (speed) {
    case # "walk":
      return "run";
    case # "run":
      return "sprint";
    case # "sprint":
      return "super_sprint";
    default:
      return "super_sprint";
  }
}

function setup_zombie_knockdown(var_5f02306b, var_43b3242) {
  if(!isactor(self) || is_true(self.missinglegs) || is_true(self.var_5dd07a80) || is_true(self.isinmantleaction) || self isplayinganimscripted() || self function_dd070839() && !is_true(var_43b3242)) {
    return;
  }

  if(!isDefined(var_5f02306b)) {
    return;
  }

  self.knockdown = 1;

  if(isvec(var_5f02306b)) {
    zombie_to_entity = var_5f02306b - self.origin;
  } else {
    zombie_to_entity = var_5f02306b.origin - self.origin;
  }

  zombie_to_entity_2d = vectornormalize((zombie_to_entity[0], zombie_to_entity[1], 0));
  zombie_forward = anglesToForward(self.angles);
  zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
  zombie_right = anglestoright(self.angles);
  zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
  dot = vectordot(zombie_to_entity_2d, zombie_forward_2d);

  if(dot >= 0.5) {
    self.knockdown_direction = "front";
    self.getup_direction = "getup_back";
    return;
  }

  if(dot < 0.5 && dot > -0.5) {
    dot = vectordot(zombie_to_entity_2d, zombie_right_2d);

    if(dot > 0) {
      self.knockdown_direction = "right";

      if(math::cointoss()) {
        self.getup_direction = "getup_back";
      } else {
        self.getup_direction = "getup_belly";
      }
    } else {
      self.knockdown_direction = "left";
      self.getup_direction = "getup_belly";
    }

    return;
  }

  self.knockdown_direction = "back";
  self.getup_direction = "getup_belly";
}

function function_fc0cb93d(entity) {
  self.pushed = 1;
  zombie_to_entity = entity.origin - self.origin;
  zombie_to_entity_2d = vectornormalize((zombie_to_entity[0], zombie_to_entity[1], 0));
  zombie_right = anglestoright(self.angles);
  zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
  dot = vectordot(zombie_to_entity_2d, zombie_right_2d);

  if(dot < 0) {
    self.push_direction = "right";
    return;
  }

  self.push_direction = "left";
}

function clear_all_corpses() {
  level notify(#"clear_all_corpses");
  corpse_array = getcorpsearray();

  for(i = 0; i < corpse_array.size; i++) {
    if(isDefined(corpse_array[i]) && !is_true(corpse_array[i].var_56e602f2)) {
      corpse_array[i] delete();
    }
  }
}

function function_96e9d980(archetype) {
  corpse_array = getcorpsearray();

  for(i = 0; i < corpse_array.size; i++) {
    if(isDefined(corpse_array[i]) && corpse_array[i].archetype === archetype) {
      corpse_array[i] delete();
    }
  }
}

function get_current_actor_count() {
  count = 0;
  actors = getaispeciesarray(level.zombie_team, "all");

  if(isDefined(actors)) {
    count += actors.size;
  }

  count += getcorpsearray().size;
  return count;
}

function zombie_gib_on_damage() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"damage");
    self thread zombie_gib(waitresult.amount, waitresult.attacker, waitresult.direction, waitresult.position, waitresult.mod, waitresult.tag_name, waitresult.model_name, waitresult.part_name, waitresult.weapon, waitresult.var_fd90b0bb);
  }
}

function zombie_gib(amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon, var_fd90b0bb) {
  if(!isDefined(self)) {
    return;
  }

  if(!self zombie_should_gib(type, tagname, partname, weapon)) {
    return;
  }

  if(self head_should_gib(tagname, partname, modelname, weapon) && partname != "MOD_BURNED") {
    self zombie_head_gib(weapon, var_fd90b0bb, tagname, partname);
    return;
  }

  if(!is_true(self.gibbed) && !isDefined(self.damagelocation)) {
    if(type >= self.maxhealth * 0.5) {
      if(partname === "MOD_CRUSH" && type >= self.health) {
        self gib_random_parts();
      } else if(partname != "MOD_GRENADE" || partname != "MOD_GRENADE_SPLASH" || partname != "MOD_PROJECTILE" || partname != "MOD_PROJECTILE_SPLASH") {
        self derive_damage_refs(weapon, var_fd90b0bb, modelname, 0);
      }
    }
  }

  if(!is_true(self.gibbed) && isDefined(self.damagelocation)) {
    if(self damagelocationisany("head", "helmet", "neck")) {
      return;
    }

    if(self damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot", "left_leg_upper", "left_leg_lower", "left_foot") && type < self.maxhealth * 0.5 && (partname != "MOD_GRENADE" || partname != "MOD_GRENADE_SPLASH" || partname != "MOD_PROJECTILE" || partname != "MOD_PROJECTILE_SPLASH")) {
      return;
    }

    self.stumble = undefined;
    b_gibbed = 1;
    var_c3317960 = gibserverutils::function_de4d9d(weapon, var_fd90b0bb);

    switch (self.damagelocation) {
      case # "right_arm_lower":
      case # "right_arm_upper":
      case # "right_hand":
        if(!gibserverutils::isgibbed(self, 32)) {
          gibserverutils::gibrightarm(self, var_c3317960);
        }

        break;
      case # "left_arm_lower":
      case # "left_arm_upper":
      case # "left_hand":
        if(!gibserverutils::isgibbed(self, 16)) {
          gibserverutils::gibleftarm(self, var_c3317960);
        }

        break;
      case # "right_leg_upper":
      case # "right_leg_lower":
      case # "right_foot":
        if(is_true(self.nocrawler) || is_true(level.var_41259f0d) || isDefined(level.var_9b91564e) && (isDefined(level.num_crawlers) ? level.num_crawlers : 0) >= level.var_9b91564e || gibserverutils::isgibbed(self, 16) || gibserverutils::isgibbed(self, 32)) {
          break;
        }

        gibserverutils::gibrightleg(self, var_c3317960);

        if(randomint(100) > 75) {
          gibserverutils::gibleftleg(self, var_c3317960);
        }

        self function_df5afb5e(1);
        break;
      case # "left_leg_lower":
      case # "left_foot":
      case # "left_leg_upper":
        if(is_true(self.nocrawler) || is_true(level.var_41259f0d) || isDefined(level.var_9b91564e) && (isDefined(level.num_crawlers) ? level.num_crawlers : 0) >= level.var_9b91564e || gibserverutils::isgibbed(self, 16) || gibserverutils::isgibbed(self, 32)) {
          break;
        }

        gibserverutils::gibleftleg(self, var_c3317960);

        if(randomint(100) > 75) {
          gibserverutils::gibrightleg(self, var_c3317960);
        }

        self function_df5afb5e(1);
        break;
      default:
        if(self.damagelocation == "none") {
          if(partname === "MOD_CRUSH" && type >= self.health) {
            self gib_random_parts();
          } else if(partname == "MOD_GRENADE" || partname == "MOD_GRENADE_SPLASH" || partname == "MOD_PROJECTILE" || partname == "MOD_PROJECTILE_SPLASH") {
            self derive_damage_refs(weapon, var_fd90b0bb, modelname);
            break;
          }
        }

        break;
    }

    if(isDefined(level.custom_derive_damage_refs)) {
      self[[level.custom_derive_damage_refs]](weapon, var_fd90b0bb, modelname);
    }

    if(is_true(self.missinglegs) && self.health > 0) {
      b_gibbed = 1;
      level notify(#"crawler_created", {
        #zombie: self, #player: tagname, #weapon: weapon
      });
      self allowedstances("crouch");
      self setphysparams(15, 0, 24);
      self allowpitchangle(1);
      self setpitchorient();
      health = self.health;
      health *= 0.1;

      if(isDefined(self.crawl_anim_override)) {
        self[[self.crawl_anim_override]]();
      }
    }

    if(b_gibbed && self.health > 0) {
      if(isDefined(level.gib_on_damage)) {
        self thread[[level.gib_on_damage]](tagname);
      }
    }
  }
}

function add_zombie_gib_weapon_callback(weapon_name, gib_callback, gib_head_callback) {
  if(!isDefined(level.zombie_gib_weapons)) {
    level.zombie_gib_weapons = [];
  }

  if(!isDefined(level.zombie_gib_head_weapons)) {
    level.zombie_gib_head_weapons = [];
  }

  level.zombie_gib_weapons[weapon_name] = gib_callback;
  level.zombie_gib_head_weapons[weapon_name] = gib_head_callback;
}

function have_zombie_weapon_gib_callback(weapon) {
  if(!isDefined(level.zombie_gib_weapons)) {
    level.zombie_gib_weapons = [];
  }

  if(!isDefined(level.zombie_gib_head_weapons)) {
    level.zombie_gib_head_weapons = [];
  }

  if(isweapon(weapon)) {
    weapon = weapon.name;
  }

  if(isDefined(level.zombie_gib_weapons[weapon])) {
    return true;
  }

  return false;
}

function get_zombie_weapon_gib_callback(weapon, damage_percent) {
  if(!isDefined(level.zombie_gib_weapons)) {
    level.zombie_gib_weapons = [];
  }

  if(!isDefined(level.zombie_gib_head_weapons)) {
    level.zombie_gib_head_weapons = [];
  }

  if(isweapon(weapon)) {
    weapon = weapon.name;
  }

  if(isDefined(level.zombie_gib_weapons[weapon])) {
    return self[[level.zombie_gib_weapons[weapon]]](damage_percent);
  }

  return 0;
}

function have_zombie_weapon_gib_head_callback(weapon) {
  if(!isDefined(level.zombie_gib_weapons)) {
    level.zombie_gib_weapons = [];
  }

  if(!isDefined(level.zombie_gib_head_weapons)) {
    level.zombie_gib_head_weapons = [];
  }

  if(isweapon(weapon)) {
    weapon = weapon.name;
  }

  if(isDefined(level.zombie_gib_head_weapons[weapon])) {
    return true;
  }

  return false;
}

function get_zombie_weapon_gib_head_callback(weapon, damage_location) {
  if(!isDefined(level.zombie_gib_weapons)) {
    level.zombie_gib_weapons = [];
  }

  if(!isDefined(level.zombie_gib_head_weapons)) {
    level.zombie_gib_head_weapons = [];
  }

  if(isweapon(weapon)) {
    weapon = weapon.name;
  }

  if(isDefined(level.zombie_gib_head_weapons[weapon])) {
    return self[[level.zombie_gib_head_weapons[weapon]]](damage_location);
  }

  return 0;
}

function zombie_should_gib(amount, attacker, type, weapon) {
  if(!isDefined(type)) {
    return 0;
  }

  if(is_true(self.is_on_fire)) {
    return 0;
  }

  if(isDefined(self.no_gib) && self.no_gib == 1) {
    return 0;
  }

  prev_health = amount + self.health;

  if(prev_health <= 0) {
    prev_health = 1;
  }

  damage_percent = amount / prev_health * 100;

  if(isDefined(attacker)) {
    if(isPlayer(attacker) || is_true(attacker.can_gib_zombies)) {
      if(isDefined(weapon) && is_true(weapon.doannihilate)) {
        return 0;
      }

      if(have_zombie_weapon_gib_callback(weapon)) {
        if(self get_zombie_weapon_gib_callback(weapon, damage_percent)) {
          return 1;
        }

        return 0;
      }
    }
  }

  switch (type) {
    case # "mod_telefrag":
    case # "mod_unknown":
    case # "mod_burned":
    case # "mod_trigger_hurt":
    case # "mod_suicide":
    case # "mod_falling":
      return 0;
    case # "mod_melee":
      dogibbing = 0;

      if(isPlayer(attacker)) {
        var_f879230e = attacker function_8cbd254d(weapon);
        dogibbing = isDefined(function_d7ea9303(weapon, var_f879230e)) ? function_d7ea9303(weapon, var_f879230e) : 0;
      }

      return dogibbing;
  }

  if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
    if(!isDefined(attacker) || !isPlayer(attacker)) {
      return 0;
    }

    if(weapon == level.weaponnone || isDefined(level.start_weapon) && weapon == level.start_weapon || weapon.isgasweapon) {
      return 0;
    }
  }

  return 1;
}

function head_should_gib(attacker, type, point, weaponused) {
  if(is_true(self.head_gibbed)) {
    return false;
  }

  if(!isDefined(attacker) || !isPlayer(attacker)) {
    if(!is_true(attacker.can_gib_zombies)) {
      return false;
    }
  }

  if(isPlayer(attacker)) {
    weapon = attacker getcurrentweapon();
  } else {
    weapon = attacker.weapon;
  }

  if(have_zombie_weapon_gib_head_callback(weapon)) {
    if(self get_zombie_weapon_gib_head_callback(weapon, self.damagelocation)) {
      return true;
    }

    return false;
  }

  if(type != "MOD_RIFLE_BULLET" && type != "MOD_PISTOL_BULLET") {
    if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH") {
      if(distance(point, self gettagorigin("j_head")) > 16 || isDefined(weaponused) && isDefined(weaponused.explosionradius) && weaponused.explosionradius < distance(point, self gettagorigin("j_head"))) {
        return false;
      } else {
        return true;
      }
    } else if(type == "MOD_PROJECTILE") {
      if(distance(point, self gettagorigin("j_head")) > 10) {
        return false;
      } else {
        return true;
      }
    } else if(weapon.weapclass != "spread") {
      if(isPlayer(attacker)) {
        var_f879230e = attacker function_8cbd254d(weapon);
        dogibbing = isDefined(function_d7ea9303(weapon, var_f879230e)) ? function_d7ea9303(weapon, var_f879230e) : 0;

        if(dogibbing) {
          if(distance(point, self gettagorigin("j_head")) > 10) {
            return false;
          } else {
            return true;
          }
        }
      }

      return false;
    }
  }

  if(!self damagelocationisany("head", "helmet", "neck")) {
    return false;
  }

  if(type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg" || weapon == level.weaponnone || isDefined(level.start_weapon) && weapon == level.start_weapon || weapon.isgasweapon) {
    return false;
  }

  if(sessionmodeiscampaigngame() && type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg") {
    return false;
  }

  low_health_percent = self.health / self.maxhealth * 100;

  if(low_health_percent > 10) {
    return false;
  }

  return true;
}

function zombie_hat_gib(attacker, means_of_death) {
  self endon(#"death");

  if(is_true(self.hat_gibbed)) {
    return;
  }

  if(!isDefined(self.gibspawn5) || !isDefined(self.gibspawntag5)) {
    return;
  }

  self.hat_gibbed = 1;

  if(isDefined(self.hatmodel)) {
    self detach(self.hatmodel, "");
  }

  temp_array = [];
  temp_array[0] = level._zombie_gib_piece_index_hat;
  self gib("normal", temp_array);

  if(isDefined(level.track_gibs)) {
    level[[level.track_gibs]](self, temp_array);
  }
}

function damage_over_time(dmg, delay, attacker, means_of_death) {
  self endon(#"death", #"exploding");
  self endon(#"exploding");

  if(!isalive(self)) {
    return;
  }

  if(!isPlayer(attacker)) {
    attacker = self;
  }

  if(!isDefined(means_of_death)) {
    means_of_death = "MOD_UNKNOWN";
  }

  while(true) {
    if(isDefined(delay)) {
      wait delay;
    }

    if(isDefined(self)) {
      var_223fc6f5 = self gettagorigin("j_neck");

      if(!isDefined(var_223fc6f5)) {
        var_223fc6f5 = self.origin;
      }

      if(isDefined(attacker)) {
        self dodamage(dmg, var_223fc6f5, attacker, self, self.damagelocation, means_of_death, 4096, self.damageweapon);
        continue;
      }

      self dodamage(dmg, var_223fc6f5);
    }
  }
}

function derive_damage_refs(weapon, var_fd90b0bb, point, var_87a07ff5 = 1) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(point)) {
    return;
  }

  if(!isDefined(level.gib_tags)) {
    init_gib_tags();
  }

  closesttag = "tag_origin";
  var_19874b3 = [];

  for(i = 0; i < level.gib_tags.size; i++) {
    if(self haspart(level.gib_tags[i])) {
      var_19874b3[var_19874b3.size] = {
        #tag: level.gib_tags[i], #origin: self gettagorigin(level.gib_tags[i])
      };
    }
  }

  var_6844367f = arraygetclosest(point, var_19874b3);

  if(isDefined(var_6844367f)) {
    closesttag = var_6844367f.tag;
  }

  var_c3317960 = gibserverutils::function_de4d9d(weapon, var_fd90b0bb);

  if(closesttag == "J_SpineLower" || closesttag == "J_SpineUpper" || closesttag == "J_Spine4") {
    gibserverutils::gibrightarm(self, var_c3317960);
    return;
  }

  if(closesttag == "J_Shoulder_LE" || closesttag == "J_Elbow_LE" || closesttag == "J_Wrist_LE") {
    if(!gibserverutils::isgibbed(self, 16)) {
      gibserverutils::gibleftarm(self, var_c3317960);
    }

    return;
  }

  if(closesttag == "J_Shoulder_RI" || closesttag == "J_Elbow_RI" || closesttag == "J_Wrist_RI") {
    if(!gibserverutils::isgibbed(self, 32)) {
      gibserverutils::gibrightarm(self, var_c3317960);
    }

    return;
  }

  if(closesttag == "J_Hip_LE" || closesttag == "J_Knee_LE" || closesttag == "J_Ankle_LE") {
    if(is_true(self.nocrawler) || is_true(level.var_41259f0d) || isDefined(level.var_9b91564e) && (isDefined(level.num_crawlers) ? level.num_crawlers : 0) >= level.var_9b91564e || gibserverutils::isgibbed(self, 16) || gibserverutils::isgibbed(self, 32)) {
      return;
    }

    gibserverutils::gibleftleg(self, var_c3317960);

    if(var_87a07ff5) {
      if(randomint(100) > 75) {
        gibserverutils::gibrightleg(self, var_c3317960);
      }
    }

    self function_df5afb5e(1);
    return;
  }

  if(closesttag == "J_Hip_RI" || closesttag == "J_Knee_RI" || closesttag == "J_Ankle_RI") {
    if(is_true(self.nocrawler) || is_true(level.var_41259f0d) || isDefined(level.var_9b91564e) && (isDefined(level.num_crawlers) ? level.num_crawlers : 0) >= level.var_9b91564e || gibserverutils::isgibbed(self, 16) || gibserverutils::isgibbed(self, 32)) {
      return;
    }

    gibserverutils::gibrightleg(self, var_c3317960);

    if(var_87a07ff5) {
      if(randomint(100) > 75) {
        gibserverutils::gibleftleg(self, var_c3317960);
      }
    }

    self function_df5afb5e(1);
  }
}

function init_gib_tags() {
  tags = [];
  tags[tags.size] = "J_SpineLower";
  tags[tags.size] = "J_SpineUpper";
  tags[tags.size] = "J_Spine4";
  tags[tags.size] = "J_Shoulder_LE";
  tags[tags.size] = "J_Elbow_LE";
  tags[tags.size] = "J_Wrist_LE";
  tags[tags.size] = "J_Shoulder_RI";
  tags[tags.size] = "J_Elbow_RI";
  tags[tags.size] = "J_Wrist_RI";
  tags[tags.size] = "J_Hip_LE";
  tags[tags.size] = "J_Knee_LE";
  tags[tags.size] = "J_Ankle_LE";
  tags[tags.size] = "J_Hip_RI";
  tags[tags.size] = "J_Knee_RI";
  tags[tags.size] = "J_Ankle_RI";
  level.gib_tags = tags;
}

function getanimdirection(damageyaw) {
  if(damageyaw > 135 || damageyaw <= -135) {
    return "front";
  } else if(damageyaw > 45 && damageyaw <= 135) {
    return "right";
  } else if(damageyaw > -45 && damageyaw <= 45) {
    return "back";
  } else {
    return "left";
  }

  return "front";
}

function makezombiecrawler(b_both_legs) {
  if(is_true(level.var_41259f0d) || !is_true(level.var_6d8a8e47) && isDefined(level.var_9b91564e) && (isDefined(level.num_crawlers) ? level.num_crawlers : 0) >= level.var_9b91564e) {
    return;
  }

  if(is_true(b_both_legs)) {
    val = 100;
  } else {
    val = randomint(100);
  }

  if(val > 75) {
    gibserverutils::gibrightleg(self, 0);
    gibserverutils::gibleftleg(self, 0);
  } else if(val > 37) {
    gibserverutils::gibrightleg(self, 0);
  } else {
    gibserverutils::gibleftleg(self, 0);
  }

  self.has_legs = 0;
  self function_df5afb5e(1);
  self allowedstances("crouch");
  self setphysparams(15, 0, 24);
  self allowpitchangle(1);
  self setpitchorient();
  health = self.health;
  health *= 0.1;
}

function zombie_head_gib(weapon, var_fd90b0bb, attacker, means_of_death) {
  self endon(#"death");

  if(is_true(self.head_gibbed)) {
    return;
  }

  self.head_gibbed = 1;

  if(!is_true(self.disable_head_gib)) {
    var_897beda3 = gibserverutils::gibhead(self, gibserverutils::function_de4d9d(weapon, var_fd90b0bb));

    if(var_897beda3) {
      self thread damage_over_time(ceil(self.health * 0.2), 1, attacker, means_of_death);
    }
  }
}

function gib_random_part() {
  if(is_true(self.no_gib)) {
    return;
  }

  playsoundatposition(#"zmb_death_gibss", self.origin);
  gib_index = randomint(5);

  if(gib_index == 3 && gibserverutils::isgibbed(self, 32) || gib_index == 4 && gibserverutils::isgibbed(self, 16)) {
    gib_index = randomint(3);
  }

  switch (gib_index) {
    case 0:
      self zombie_head_gib();
      break;
    case 1:
      gibserverutils::gibrightleg(self, 0);
      break;
    case 2:
      gibserverutils::gibleftleg(self, 0);
      break;
    case 3:
      gibserverutils::gibrightarm(self, 0);
      break;
    case 4:
      gibserverutils::gibleftarm(self, 0);
      break;
    default:
      break;
  }
}

function gib_random_parts() {
  if(is_true(self.no_gib)) {
    return;
  }

  playsoundatposition(#"zmb_death_gibss", self.origin);
  val = randomint(100);

  if(val > 50) {
    self zombie_head_gib();
  }

  val = randomint(100);

  if(val > 50) {
    gibserverutils::gibrightleg(self, 0);
  }

  val = randomint(100);

  if(val > 50) {
    gibserverutils::gibleftleg(self, 0);
  }

  val = randomint(100);

  if(val > 50) {
    if(!gibserverutils::isgibbed(self, 32) && !gibserverutils::isgibbed(self, 16)) {
      gibserverutils::gibrightarm(self, 0);
    }
  }

  val = randomint(100);

  if(val > 50) {
    if(!gibserverutils::isgibbed(self, 16) && !gibserverutils::isgibbed(self, 32)) {
      gibserverutils::gibleftarm(self, 0);
    }
  }
}

function function_df5afb5e(missinglegs = 0) {
  if(missinglegs) {
    self.var_177172b0 = gettime();
    self.knockdown = 0;

    if(is_true(self.var_1731eda3)) {
      self.var_1731eda3 = undefined;
    }

    if(isDefined(level.var_9b91564e)) {
      if(!isDefined(level.num_crawlers)) {
        level.num_crawlers = 0;
      }

      level.num_crawlers++;
      self callback::function_d8abfc3d(#"on_ai_killed", &function_c768f32b);
    }
  }

  self.missinglegs = missinglegs;
}

function private function_c768f32b(params) {
  level.num_crawlers--;
}

function autoexec init_ignore_player_handler() {
  level._ignore_player_handler = [];
}

function register_ignore_player_handler(archetype, ignore_player_func) {
  assert(isDefined(archetype), "<dev string:x29e>");
  assert(!isDefined(level._ignore_player_handler[archetype]), "<dev string:x2ca>" + archetype + "<dev string:x2e6>");
  level._ignore_player_handler[archetype] = ignore_player_func;
}

function run_ignore_player_handler() {
  if(isDefined(level._ignore_player_handler[self.archetype])) {
    self[[level._ignore_player_handler[self.archetype]]]();
  }
}

function function_6975aa10(weapon) {
  if(weapon.offhandslot === "Tactical grenade" || weapon.offhandslot === "Lethal grenade" || weapon.offhandslot === "Special" || killstreaks::is_killstreak_weapon(weapon)) {
    self.var_88bc9ca8 = 1;
  }
}

function function_d446de65(entity, position, drop_height, var_e294ac7d = 1) {
  var_53b2da60 = function_9cc082d2(position, drop_height);

  if(isDefined(var_53b2da60[# "point"])) {
    var_62aa07f4 = entity;

    if(isDefined(var_e294ac7d && var_e294ac7d !== 1)) {
      var_62aa07f4 = entity getpathfindingradius() * var_e294ac7d;
    }

    if(ispointonnavmesh(var_53b2da60[# "point"], var_62aa07f4)) {
      return var_53b2da60[# "point"];
    }
  }

  return undefined;
}

function updateanimationrate() {
  self notify(#"updateanimationrate");
  self endon(#"death", #"updateanimationrate");
  settings_bundle = self ai::function_9139c839();

  if(!isDefined(settings_bundle)) {
    return;
  }

  var_fd8e23d9 = self ai::function_9139c839().animationspeed;

  if(isDefined(var_fd8e23d9)) {
    self asmsetanimationrate(var_fd8e23d9);
  }

  while(true) {
    wait 1;
    animation_rate = self ai::function_9139c839().animationspeed;

    if(!isDefined(animation_rate)) {
      return;
    }

    if(var_fd8e23d9 == animation_rate) {
      continue;
    }

    self asmsetanimationrate(animation_rate);
    var_fd8e23d9 = animation_rate;
  }
}