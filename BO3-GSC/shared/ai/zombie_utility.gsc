/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\zombie_utility.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#namespace zombie_utility;

function zombiespawnsetup() {
  self.zombie_move_speed = "walk";
  if(!isDefined(self.zombie_arms_position)) {
    if(randomint(2) == 0) {
      self.zombie_arms_position = "up";
    } else {
      self.zombie_arms_position = "down";
    }
  }
  self.missinglegs = 0;
  self setavoidancemask("avoid none");
  self pushactors(1);
  clientfield::set("zombie", 1);
  self.ignorepathenemyfightdist = 1;
}

function get_closest_valid_player(origin, ignore_player, ignore_laststand_players = 0) {
  pixbeginevent("get_closest_valid_player");
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

function is_player_valid(player, checkignoremeflag, ignore_laststand_players) {
  if(!isDefined(player)) {
    return 0;
  }
  if(!isalive(player)) {
    return 0;
  }
  if(!isplayer(player)) {
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
  if(isDefined(player.intermission) && player.intermission) {
    return 0;
  }
  if(!(isDefined(ignore_laststand_players) && ignore_laststand_players)) {
    if(player laststand::player_is_in_laststand()) {
      return 0;
    }
  }
  if(player isnotarget()) {
    return 0;
  }
  if(isDefined(checkignoremeflag) && checkignoremeflag && player.ignoreme) {
    return 0;
  }
  if(isDefined(level.is_player_valid_override)) {
    return [[level.is_player_valid_override]](player);
  }
  return 1;
}

function append_missing_legs_suffix(animstate) {
  if(self.missinglegs && self hasanimstatefromasd(animstate + "_crawl")) {
    return animstate + "_crawl";
  }
  return animstate;
}

function initanimtree(animscript) {
  if(animscript != "pain" && animscript != "death") {
    self.a.special = "none";
  }
  assert(isDefined(animscript), "");
  self.a.script = animscript;
}

function updateanimpose() {
  assert(self.a.movement == "" || self.a.movement == "" || self.a.movement == "", (("" + self.a.pose) + "") + self.a.movement);
  self.desired_anim_pose = undefined;
}

function initialize(animscript) {
  if(isDefined(self.longdeathstarting)) {
    if(animscript != "pain" && animscript != "death") {
      self dodamage(self.health + 100, self.origin);
    }
    if(animscript != "pain") {
      self.longdeathstarting = undefined;
      self notify("kill_long_death");
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
  if(isDefined(self.node) && (self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand")) {
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
    forward = anglesToForward(self.covernode.angles + self.animarray["angle_step_out"][self.a.cornermode]);
    forward = vectorscale(forward, 150);
    pos = self.origin + forward;
  }
  yaw = (self.covernode.angles[1] + self.animarray["angle_step_out"][self.a.cornermode]) - getyaw(pos);
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
  yaw = (self.covernode.angles[1] + self.animarray["angle_step_out"][self.a.cornermode]) - getyaw(org);
  yaw = angleclamp180(yaw);
  return yaw;
}

function isstanceallowedwrapper(stance) {
  if(isDefined(self.covernode)) {
    return self.covernode doesnodeallowstance(stance);
  }
  return self isstanceallowed(stance);
}

function getclaimednode() {
  mynode = self.node;
  if(isDefined(mynode) && (self nearnode(mynode) || (isDefined(self.covernode) && mynode == self.covernode))) {
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
  result = result + b;
  return result % b;
}

function angleclamp(angle) {
  anglefrac = angle / 360;
  angle = (anglefrac - floor(anglefrac)) * 360;
  return angle;
}

function quadrantanimweights(yaw) {
  forwardweight = (90 - abs(yaw)) / 90;
  leftweight = (90 - (absangleclamp180(abs(yaw - 90)))) / 90;
  result["front"] = 0;
  result["right"] = 0;
  result["back"] = 0;
  result["left"] = 0;
  if(isDefined(self.alwaysrunforward)) {
    assert(self.alwaysrunforward);
    result["front"] = 1;
    return result;
  }
  useleans = getdvarint("ai_useLeanRunAnimations");
  if(forwardweight > 0) {
    result["front"] = forwardweight;
    if(leftweight > 0) {
      result["left"] = leftweight;
    } else {
      result["right"] = -1 * leftweight;
    }
  } else {
    if(useleans) {
      result["back"] = -1 * forwardweight;
      if(leftweight > 0) {
        result["left"] = leftweight;
      } else {
        result["right"] = -1 * leftweight;
      }
    } else {
      backweight = -1 * forwardweight;
      if(leftweight > backweight) {
        result["left"] = 1;
      } else {
        if(leftweight < forwardweight) {
          result["right"] = 1;
        } else {
          result["back"] = 1;
        }
      }
    }
  }
  return result;
}

function getquadrant(angle) {
  angle = angleclamp(angle);
  if(angle < 45 || angle > 315) {
    quadrant = "front";
  } else {
    if(angle < 135) {
      quadrant = "left";
    } else {
      if(angle < 225) {
        quadrant = "back";
      } else {
        quadrant = "right";
      }
    }
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
  self endon("death");
  self endon(killmestring);
  wait(time);
  self notify(notifystring);
}

function drawstringtime(msg, org, color, timer) {
  maxtime = timer * 20;
  for(i = 0; i < maxtime; i++) {
    print3d(org, msg, color, 1, 1);
    wait(0.05);
  }
}

function showlastenemysightpos(string) {
  self notify("hash_a5fb63c6");
  self endon("hash_a5fb63c6");
  self endon("death");
  if(!isvalidenemy(self.enemy)) {
    return;
  }
  if(self.enemy.team == "") {
    color = (0.4, 0.7, 1);
  } else {
    color = (1, 0.7, 0.4);
  }
  while(true) {
    wait(0.05);
    if(!isDefined(self.lastenemysightpos)) {
      continue;
    }
    print3d(self.lastenemysightpos, string, color, 1, 2.15);
  }
}

function debugtimeout() {
  wait(5);
  self notify("timeout");
}

function debugposinternal(org, string, size) {
  self endon("death");
  self notify("" + org);
  self endon("" + org);
  ent = spawnStruct();
  ent thread debugtimeout();
  ent endon("timeout");
  if(self.enemy.team == "") {
    color = (0.4, 0.7, 1);
  } else {
    color = (1, 0.7, 0.4);
  }
  while(true) {
    wait(0.05);
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
  self endon("death");
  timer = printtime * 20;
  i = 0;
  while(i < timer) {
    wait(0.05);
    line(frompoint, topoint, color);
    i = i + 1;
  }
}

function showdebugline(frompoint, topoint, color, printtime) {
  self thread showdebugproc(frompoint, topoint + (vectorscale((0, 0, -1), 5)), color, printtime);
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
    case "Cover Left":
    case "Cover Left Wide": {
      if(node isnodedontstand() && !node isnodedontcrouch()) {
        nodeoffset = calculatenodeoffset(right, forward, cover_left_crouch_offset);
      } else {
        nodeoffset = calculatenodeoffset(right, forward, cover_left_stand_offset);
      }
      break;
    }
    case "Cover Right":
    case "Cover Right Wide": {
      if(node isnodedontstand() && !node isnodedontcrouch()) {
        nodeoffset = calculatenodeoffset(right, forward, cover_right_crouch_offset);
      } else {
        nodeoffset = calculatenodeoffset(right, forward, cover_right_stand_offset);
      }
      break;
    }
    case "Conceal Stand":
    case "Cover Stand":
    case "Turret": {
      nodeoffset = calculatenodeoffset(right, forward, cover_stand_offset);
      break;
    }
    case "Conceal Crouch":
    case "Cover Crouch":
    case "Cover Crouch Window": {
      nodeoffset = calculatenodeoffset(right, forward, cover_crouch_offset);
      break;
    }
  }
  node.offset = nodeoffset;
  return node.offset;
}

function calculatenodeoffset(right, forward, baseoffset) {
  return (vectorscale(right, baseoffset[0]) + vectorscale(forward, baseoffset[1])) + (0, 0, baseoffset[2]);
}

function checkpitchvisibility(frompoint, topoint, atnode) {
  pitch = angleclamp180(vectortoangles(topoint - frompoint)[0]);
  if(abs(pitch) > 45) {
    if(isDefined(atnode) && atnode.type != "Cover Crouch" && atnode.type != "Conceal Crouch") {
      return false;
    }
    if(pitch > 45 || pitch < (anim.covercrouchleanpitch - 45)) {
      return false;
    }
  }
  return true;
}

function showlines(start, end, end2) {
  for(;;) {
    line(start, end, (1, 0, 0), 1);
    wait(0.05);
    line(start, end2, (0, 0, 1), 1);
    wait(0.05);
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
    total_weight = total_weight + animweights[i];
  }
  anim_play = randomfloat(total_weight);
  current_weight = 0;
  for(i = 0; i < total_anims; i++) {
    current_weight = current_weight + animweights[i];
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
    wait(0.05);
  }
}

function print3drise(org, msg, color, alpha, scale) {
  newtime = 100;
  up = 0;
  org = org;
  for(i = 0; i < newtime; i++) {
    up = up + 0.5;
    print3d(org + (0, 0, up), msg, color, alpha, scale);
    wait(0.05);
  }
}

function crossproduct(vec1, vec2) {
  return (vec1[0] * vec2[1]) - (vec1[1] * vec2[0]) > 0;
}

function scriptchange() {
  self.a.current_script = "none";
  self notify(anim.scriptchange);
}

function delayedscriptchange() {
  wait(0.05);
  scriptchange();
}

function sawenemymove(timer = 500) {
  return (gettime() - self.personalsighttime) < timer;
}

function canthrowgrenade() {
  if(!self.grenadeammo) {
    return 0;
  }
  if(self.script_forcegrenade) {
    return 1;
  }
  return isplayer(self.enemy);
}

function random_weight(array) {
  idleanim = randomint(array.size);
  if(array.size > 1) {
    anim_weight = 0;
    for(i = 0; i < array.size; i++) {
      anim_weight = anim_weight + array[i];
    }
    anim_play = randomfloat(anim_weight);
    anim_weight = 0;
    for(i = 0; i < array.size; i++) {
      anim_weight = anim_weight + array[i];
      if(anim_play < anim_weight) {
        idleanim = i;
        break;
      }
    }
  }
  return idleanim;
}

function setfootstepeffect(name, fx) {
  assert(isDefined(name), "");
  assert(isDefined(fx), "");
  if(!isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }
  anim.optionalstepeffects[anim.optionalstepeffects.size] = name;
  level._effect["step_" + name] = fx;
  anim.optionalstepeffectfunction = &zombie_shared::playfootstepeffect;
}

function persistentdebugline(start, end) {
  self endon("death");
  level notify("newdebugline");
  level endon("newdebugline");
  for(;;) {
    line(start, end, (0.3, 1, 0), 1);
    wait(0.05);
  }
}

function isnodedontstand() {
  return (self.spawnflags & 4) == 4;
}

function isnodedontcrouch() {
  return (self.spawnflags & 8) == 8;
}

function doesnodeallowstance(stance) {
  if(stance == "stand") {
    return !self isnodedontstand();
  }
  assert(stance == "");
  return !self isnodedontcrouch();
}

function animarray(animname) {
  assert(isDefined(self.a.array));
  if(!isDefined(self.a.array[animname])) {
    dumpanimarray();
    assert(isDefined(self.a.array[animname]), ("" + animname) + "");
  }
  return self.a.array[animname];
}

function animarrayanyexist(animname) {
  assert(isDefined(self.a.array));
  if(!isDefined(self.a.array[animname])) {
    dumpanimarray();
    assert(isDefined(self.a.array[animname]), ("" + animname) + "");
  }
  return self.a.array[animname].size > 0;
}

function animarraypickrandom(animname) {
  assert(isDefined(self.a.array));
  if(!isDefined(self.a.array[animname])) {
    dumpanimarray();
    assert(isDefined(self.a.array[animname]), ("" + animname) + "");
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
  println("");
  keys = getarraykeys(self.a.array);
  for(i = 0; i < keys.size; i++) {
    if(isarray(self.a.array[keys[i]])) {
      println(((("" + keys[i]) + "") + self.a.array[keys[i]].size) + "");
      continue;
    }
    println(("" + keys[i]) + "", self.a.array[keys[i]]);
  }
}

function getanimendpos(theanim) {
  movedelta = getmovedelta(theanim, 0, 1, self);
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

function ragdolldeath(moveanim) {
  self endon("killanimscript");
  lastorg = self.origin;
  movevec = (0, 0, 0);
  for(;;) {
    wait(0.05);
    force = distance(self.origin, lastorg);
    lastorg = self.origin;
    if(self.health == 1) {
      self.a.nodeath = 1;
      self startragdoll();
      wait(0.05);
      physicsexplosionsphere(lastorg, 600, 0, force * 0.1);
      self notify("killanimscript");
      return;
    }
  }
}

function iscqbwalking() {
  return isDefined(self.cqbwalking) && self.cqbwalking;
}

function squared(value) {
  return value * value;
}

function randomizeidleset() {
  self.a.idleset = randomint(2);
}

function getrandomintfromseed(intseed, intmax) {
  assert(intmax > 0);
  index = intseed % anim.randominttablesize;
  return anim.randominttable[index] % intmax;
}

function is_banzai() {
  return isDefined(self.banzai) && self.banzai;
}

function is_heavy_machine_gun() {
  return isDefined(self.heavy_machine_gunner) && self.heavy_machine_gunner;
}

function is_zombie() {
  if(isDefined(self.is_zombie) && self.is_zombie) {
    return true;
  }
  return false;
}

function is_civilian() {
  if(isDefined(self.is_civilian) && self.is_civilian) {
    return true;
  }
  return false;
}

function is_skeleton(skeleton) {
  if(skeleton == "base" && issubstr(get_skeleton(), "scaled")) {
    return 1;
  }
  return get_skeleton() == skeleton;
}

function get_skeleton() {
  if(isDefined(self.skeleton)) {
    return self.skeleton;
  }
  return "base";
}

function set_orient_mode(mode, val1) {
  if(level.dog_debug_orient == self getentnum()) {
    if(isDefined(val1)) {
      println((((("" + mode) + "") + val1) + "") + gettime());
    } else {
      println((("" + mode) + "") + gettime());
    }
  }
  if(isDefined(val1)) {
    self orientmode(mode, val1);
  } else {
    self orientmode(mode);
  }
}

function debug_anim_print(text) {
  if(isDefined(level.dog_debug_anims) && level.dog_debug_anims) {
    println((text + "") + gettime());
  }
  if(isDefined(level.dog_debug_anims_ent) && level.dog_debug_anims_ent == self getentnum()) {
    println((text + "") + gettime());
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
    println(((((((text + "") + gettime() + "") + currentyaw) + "") + lookaheadyaw) + "") + desiredyaw);
  }
}

function debug_allow_combat() {
  return anim_get_dvar_int("", "");
}

function debug_allow_movement() {
  return anim_get_dvar_int("", "");
}

function set_zombie_var(zvar, value, is_float = 0, column = 1, is_team_based = 0) {
  if(!isDefined(level.zombie_vars)) {
    level.zombie_vars = [];
  }
  if(is_team_based) {
    foreach(team in level.teams) {
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

function spawn_zombie(spawner, target_name, spawn_point, round_number) {
  if(!isDefined(spawner)) {
    println("");
    return undefined;
  }
  while(getfreeactorcount() < 1) {
    wait(0.05);
  }
  spawner.script_moveoverride = 1;
  if(isDefined(spawner.script_forcespawn) && spawner.script_forcespawn) {
    if(sessionmodeiscampaignzombiesgame()) {
      guy = spawner spawner::spawn(1);
    } else {
      if(isactorspawner(spawner) && isDefined(level.overridezombiespawn)) {
        guy = [[level.overridezombiespawn]]();
      } else {
        guy = spawner spawnfromspawner(0, 1);
      }
    }
    if(!zombie_spawn_failed(guy)) {
      guy.spawn_time = gettime();
      if(isDefined(level.giveextrazombies)) {
        guy[[level.giveextrazombies]]();
      }
      guy enableaimassist();
      if(isDefined(round_number)) {
        guy._starting_round_number = round_number;
      }
      guy.team = level.zombie_team;
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
    }
    println("", spawner.origin);
    return undefined;
  }
  println("", spawner.origin);
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
    assert(isDefined(ent), (("" + self.target) + "") + self.origin);
    return ent.origin;
  }
  return undefined;
}

function hide_pop() {
  self endon("death");
  self ghost();
  wait(0.5);
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
    self notify("zombie_rise_death_out");
    wait(2);
    spot notify("stop_zombie_rise_fx");
  }
}

function zombie_rise_death(zombie, spot) {
  zombie.zombie_rise_death_out = 0;
  zombie endon("rise_anim_finished");
  while(isDefined(zombie) && isDefined(zombie.health) && zombie.health > 1) {
    zombie waittill("damage", amount);
  }
  if(isDefined(spot)) {
    spot notify("stop_zombie_rise_fx");
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
  if(isDefined(self.attacking_node)) {
    node = self.attacking_node;
    index = self.attacking_spot_index;
    node.attack_spots_taken[index] = 0;
    self.attacking_node = undefined;
    self.attacking_spot_index = undefined;
  }
}

function zombie_gut_explosion() {
  self.guts_explosion = 1;
  gibserverutils::annihilate(self);
}

function delayed_zombie_eye_glow() {
  self endon("zombie_delete");
  self endon("death");
  if(isDefined(self.in_the_ground) && self.in_the_ground || (isDefined(self.in_the_ceiling) && self.in_the_ceiling)) {
    while(!isDefined(self.create_eyes)) {
      wait(0.1);
    }
  } else {
    wait(0.5);
  }
  self zombie_eye_glow();
}

function zombie_eye_glow() {
  if(!isDefined(self) || !isactor(self)) {
    return;
  }
  if(!isDefined(self.no_eye_glow) || !self.no_eye_glow) {
    self clientfield::set("zombie_has_eyes", 1);
  }
}

function zombie_eye_glow_stop() {
  if(!isDefined(self) || !isactor(self)) {
    return;
  }
  if(!isDefined(self.no_eye_glow) || !self.no_eye_glow) {
    self clientfield::set("zombie_has_eyes", 0);
  }
}

function round_spawn_failsafe_debug_draw() {
  self endon("death");
  prevorigin = self.origin;
  while(true) {
    if(isDefined(level.toggle_keyline_always) && level.toggle_keyline_always) {
      self clientfield::set("zombie_keyline_render", 1);
      wait(1);
      continue;
    }
    wait(4);
    if(isDefined(self.lastchunk_destroy_time)) {
      if((gettime() - self.lastchunk_destroy_time) < 8000) {
        continue;
      }
    }
    if(distancesquared(self.origin, prevorigin) < 576) {
      self clientfield::set("zombie_keyline_render", 1);
    } else {
      self clientfield::set("zombie_keyline_render", 0);
    }
    prevorigin = self.origin;
  }
}

function round_spawn_failsafe() {
  self endon("death");
  if(isDefined(level.debug_keyline_zombies) && level.debug_keyline_zombies) {
    self thread round_spawn_failsafe_debug_draw();
  }
  prevorigin = self.origin;
  while(true) {
    if(!level.zombie_vars["zombie_use_failsafe"]) {
      return;
    }
    if(isDefined(self.ignore_round_spawn_failsafe) && self.ignore_round_spawn_failsafe) {
      return;
    }
    if(!isDefined(level.failsafe_waittime)) {
      level.failsafe_waittime = 30;
    }
    wait(level.failsafe_waittime);
    if(self.missinglegs) {
      wait(10);
    }
    if(isDefined(self.is_inert) && self.is_inert) {
      continue;
    }
    if(isDefined(self.lastchunk_destroy_time)) {
      if((gettime() - self.lastchunk_destroy_time) < 8000) {
        continue;
      }
    }
    if(self.origin[2] < level.zombie_vars["below_world_check"]) {
      if(isDefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue && !level flag::get("special_round") && (!(isDefined(self.isscreecher) && self.isscreecher))) {
        level.zombie_total++;
        level.zombie_total_subtract++;
      }
      self dodamage(self.health + 100, (0, 0, 0));
      break;
    }
    if(distancesquared(self.origin, prevorigin) < 576) {
      if(isDefined(level.move_failsafe_override)) {
        self thread[[level.move_failsafe_override]](prevorigin);
      } else {
        if(isDefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue && !level flag::get("special_round")) {
          if(!self.ignoreall && (!(isDefined(self.nuked) && self.nuked)) && (!(isDefined(self.marked_for_death) && self.marked_for_death)) && (!(isDefined(self.isscreecher) && self.isscreecher)) && !self.missinglegs) {
            level.zombie_total++;
            level.zombie_total_subtract++;
          }
        }
        level.zombies_timeout_playspace++;
        self dodamage(self.health + 100, (0, 0, 0));
      }
      break;
    }
    prevorigin = self.origin;
  }
}

function ai_calculate_health(round_number) {
  level.zombie_health = level.zombie_vars["zombie_health_start"];
  for(i = 2; i <= round_number; i++) {
    if(i >= 10) {
      old_health = level.zombie_health;
      level.zombie_health = level.zombie_health + (int(level.zombie_health * level.zombie_vars["zombie_health_increase_multiplier"]));
      if(level.zombie_health < old_health) {
        level.zombie_health = old_health;
        return;
      }
      continue;
    }
    level.zombie_health = int(level.zombie_health + level.zombie_vars["zombie_health_increase"]);
  }
}

function default_max_zombie_func(max_num, n_round) {
  count = getdvarint("", -1);
  if(count > -1) {
    return count;
  }
  max = max_num;
  if(n_round < 2) {
    max = int(max_num * 0.25);
  } else {
    if(n_round < 3) {
      max = int(max_num * 0.3);
    } else {
      if(n_round < 4) {
        max = int(max_num * 0.5);
      } else {
        if(n_round < 5) {
          max = int(max_num * 0.7);
        } else if(n_round < 6) {
          max = int(max_num * 0.9);
        }
      }
    }
  }
  return max;
}

function zombie_speed_up() {
  if(level.round_number <= 3) {
    return;
  }
  level endon("intermission");
  level endon("end_of_round");
  level endon("restart_round");
  level endon("kill_round");
  while(level.zombie_total > 4) {
    wait(3);
  }
  a_ai_zombies = get_round_enemy_array();
  while(a_ai_zombies.size > 0 || level.zombie_total > 0) {
    if(a_ai_zombies.size == 1) {
      ai_zombie = a_ai_zombies[0];
      if(isalive(ai_zombie)) {
        if(isDefined(level.zombie_speed_up)) {
          ai_zombie thread[[level.zombie_speed_up]]();
        } else if(!ai_zombie.zombie_move_speed === "sprint") {
          ai_zombie set_zombie_run_cycle("sprint");
          ai_zombie.zombie_move_speed_original = ai_zombie.zombie_move_speed;
        }
      }
    }
    wait(0.5);
    a_ai_zombies = get_round_enemy_array();
  }
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
    if(isDefined(a_ai_enemies[i].ignore_enemy_count) && a_ai_enemies[i].ignore_enemy_count) {
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
  enemies = [];
  valid_enemies = [];
  enemies = getaispeciesarray(level.zombie_team, "all");
  for(i = 0; i < enemies.size; i++) {
    if(enemies[i].archetype == "zombie") {
      if(!isDefined(valid_enemies)) {
        valid_enemies = [];
      } else if(!isarray(valid_enemies)) {
        valid_enemies = array(valid_enemies);
      }
      valid_enemies[valid_enemies.size] = enemies[i];
    }
  }
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

function set_zombie_run_cycle(new_move_speed) {
  if(isDefined(self.zombie_move_speed_override)) {
    self.zombie_move_speed_restore = new_move_speed;
    return;
  }
  self.zombie_move_speed_original = self.zombie_move_speed;
  if(isDefined(new_move_speed)) {
    self.zombie_move_speed = new_move_speed;
  } else {
    if(level.gamedifficulty == 0) {
      self set_run_speed_easy();
    } else {
      self set_run_speed();
    }
  }
  if(isDefined(level.zm_variant_type_max)) {
    if(0) {
      debug_variant_type = getdvarint("", -1);
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
    if(self.archetype === "zombie") {
      if(isDefined(self.zm_variant_type_max)) {
        self.variant_type = randomint(self.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
      } else {
        if(isDefined(level.zm_variant_type_max[self.zombie_move_speed])) {
          self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
        } else {
          errormsg("" + self.zombie_move_speed);
          self.variant_type = 0;
        }
      }
    }
  }
  self.needs_run_update = 1;
  self notify("needs_run_update");
  self.deathanim = self append_missing_legs_suffix("zm_death");
}

function set_run_speed() {
  if(isDefined(level.zombie_force_run)) {
    self.zombie_move_speed = "run";
    level.zombie_force_run--;
    if(level.zombie_force_run <= 0) {
      level.zombie_force_run = undefined;
    }
    return;
  }
  rand = randomintrange(level.zombie_move_speed, level.zombie_move_speed + 35);
  if(rand <= 35) {
    self.zombie_move_speed = "walk";
  } else {
    if(rand <= 70) {
      self.zombie_move_speed = "run";
    } else {
      self.zombie_move_speed = "sprint";
    }
  }
}

function set_run_speed_easy() {
  rand = randomintrange(level.zombie_move_speed, level.zombie_move_speed + 25);
  if(rand <= 35) {
    self.zombie_move_speed = "walk";
  } else {
    self.zombie_move_speed = "run";
  }
}

function setup_zombie_knockdown(entity) {
  self.knockdown = 1;
  zombie_to_entity = entity.origin - self.origin;
  zombie_to_entity_2d = vectornormalize((zombie_to_entity[0], zombie_to_entity[1], 0));
  zombie_forward = anglesToForward(self.angles);
  zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
  zombie_right = anglestoright(self.angles);
  zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
  dot = vectordot(zombie_to_entity_2d, zombie_forward_2d);
  if(dot >= 0.5) {
    self.knockdown_direction = "front";
    self.getup_direction = "getup_back";
  } else {
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
    } else {
      self.knockdown_direction = "back";
      self.getup_direction = "getup_belly";
    }
  }
}

function clear_all_corpses() {
  corpse_array = getcorpsearray();
  for(i = 0; i < corpse_array.size; i++) {
    if(isDefined(corpse_array[i])) {
      corpse_array[i] delete();
    }
  }
}

function get_current_actor_count() {
  count = 0;
  actors = getaispeciesarray(level.zombie_team, "all");
  if(isDefined(actors)) {
    count = count + actors.size;
  }
  count = count + get_current_corpse_count();
  return count;
}

function get_current_corpse_count() {
  corpse_array = getcorpsearray();
  if(isDefined(corpse_array)) {
    return corpse_array.size;
  }
  return 0;
}

function zombie_gib_on_damage() {
  while(true) {
    self waittill("damage", amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon);
    if(!isDefined(self)) {
      return;
    }
    if(!self zombie_should_gib(amount, attacker, type)) {
      continue;
    }
    if(self head_should_gib(attacker, type, point) && type != "MOD_BURNED") {
      self zombie_head_gib(attacker, type);
      continue;
    }
    if(!(isDefined(self.gibbed) && self.gibbed) && isDefined(self.damagelocation)) {
      if(self damagelocationisany("head", "helmet", "neck")) {
        continue;
      }
      self.stumble = undefined;
      switch (self.damagelocation) {
        case "torso_lower":
        case "torso_upper": {
          if(!gibserverutils::isgibbed(self, 32)) {
            gibserverutils::gibrightarm(self);
          }
          break;
        }
        case "right_arm_lower":
        case "right_arm_upper":
        case "right_hand": {
          if(!gibserverutils::isgibbed(self, 32)) {
            gibserverutils::gibrightarm(self);
          }
          break;
        }
        case "left_arm_lower":
        case "left_arm_upper":
        case "left_hand": {
          if(!gibserverutils::isgibbed(self, 16)) {
            gibserverutils::gibleftarm(self);
          }
          break;
        }
        case "right_foot":
        case "right_leg_lower":
        case "right_leg_upper": {
          if(self.health <= 0) {
            gibserverutils::gibrightleg(self);
            if(randomint(100) > 75) {
              gibserverutils::gibleftleg(self);
            }
            self.missinglegs = 1;
          }
          break;
        }
        case "left_foot":
        case "left_leg_lower":
        case "left_leg_upper": {
          if(self.health <= 0) {
            gibserverutils::gibleftleg(self);
            if(randomint(100) > 75) {
              gibserverutils::gibrightleg(self);
            }
            self.missinglegs = 1;
          }
          break;
        }
        default: {
          if(self.damagelocation == "none") {
            if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
              self derive_damage_refs(point);
              break;
            }
          }
        }
      }
      if(isDefined(self.missinglegs) && self.missinglegs && self.health > 0) {
        self allowedstances("crouch");
        self setphysparams(15, 0, 24);
        self allowpitchangle(1);
        self setpitchorient();
        health = self.health;
        health = health * 0.1;
        if(isDefined(self.crawl_anim_override)) {
          self[[self.crawl_anim_override]]();
        }
      }
      if(self.health > 0) {
        if(isDefined(level.gib_on_damage)) {
          self thread[[level.gib_on_damage]]();
        }
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

function zombie_should_gib(amount, attacker, type) {
  if(!isDefined(type)) {
    return false;
  }
  if(isDefined(self.is_on_fire) && self.is_on_fire) {
    return false;
  }
  if(isDefined(self.no_gib) && self.no_gib == 1) {
    return false;
  }
  prev_health = amount + self.health;
  if(prev_health <= 0) {
    prev_health = 1;
  }
  damage_percent = (amount / prev_health) * 100;
  weapon = undefined;
  if(isDefined(attacker)) {
    if(isplayer(attacker) || (isDefined(attacker.can_gib_zombies) && attacker.can_gib_zombies)) {
      if(isplayer(attacker)) {
        weapon = attacker getcurrentweapon();
      } else {
        weapon = attacker.weapon;
      }
      if(have_zombie_weapon_gib_callback(weapon)) {
        if(self get_zombie_weapon_gib_callback(weapon, damage_percent)) {
          return true;
        }
        return false;
      }
    }
  }
  switch (type) {
    case "MOD_BURNED":
    case "MOD_FALLING":
    case "MOD_SUICIDE":
    case "MOD_TELEFRAG":
    case "MOD_TRIGGER_HURT":
    case "MOD_UNKNOWN": {
      return false;
    }
    case "MOD_MELEE": {
      return false;
    }
  }
  if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
    if(!isDefined(attacker) || !isplayer(attacker)) {
      return false;
    }
    if(weapon == level.weaponnone || (isDefined(level.start_weapon) && weapon == level.start_weapon) || weapon.isgasweapon) {
      return false;
    }
  }
  if(damage_percent < 10) {
    return false;
  }
  return true;
}

function head_should_gib(attacker, type, point) {
  if(isDefined(self.head_gibbed) && self.head_gibbed) {
    return false;
  }
  if(!isDefined(attacker)) {
    return false;
  }
  if(!isplayer(attacker)) {
    if(!(isDefined(attacker.can_gib_zombies) && attacker.can_gib_zombies)) {
      return false;
    }
  }
  if(isplayer(attacker)) {
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
      if(distance(point, self gettagorigin("j_head")) > 55) {
        return false;
      }
      return true;
    }
    if(type == "MOD_PROJECTILE") {
      if(distance(point, self gettagorigin("j_head")) > 10) {
        return false;
      }
      return true;
    }
    if(weapon.weapclass != "spread") {
      return false;
    }
  }
  if(!self damagelocationisany("head", "helmet", "neck")) {
    return false;
  }
  if(type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg" && weapon.weapclass != "spread" || weapon == level.weaponnone || (isDefined(level.start_weapon) && weapon == level.start_weapon) || weapon.isgasweapon) {
    return false;
  }
  if(sessionmodeiscampaigngame() && (type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg")) {
    return false;
  }
  low_health_percent = (self.health / self.maxhealth) * 100;
  if(low_health_percent > 10) {
    return false;
  }
  return true;
}

function zombie_hat_gib(attacker, means_of_death) {
  self endon("death");
  if(isDefined(self.hat_gibbed) && self.hat_gibbed) {
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

function head_gib_damage_over_time(dmg, delay, attacker, means_of_death) {
  self endon("death");
  self endon("exploding");
  if(!isalive(self)) {
    return;
  }
  if(!isplayer(attacker)) {
    attacker = self;
  }
  if(!isDefined(means_of_death)) {
    means_of_death = "MOD_UNKNOWN";
  }
  dot_location = self.damagelocation;
  dot_weapon = self.damageweapon;
  while(true) {
    if(isDefined(delay)) {
      wait(delay);
    }
    if(isDefined(self)) {
      if(isDefined(self.no_gib) && self.no_gib) {
        return;
      }
      if(isDefined(attacker)) {
        self dodamage(dmg, self gettagorigin("j_neck"), attacker, self, dot_location, means_of_death, 0, dot_weapon);
      } else {
        self dodamage(dmg, self gettagorigin("j_neck"));
      }
    }
  }
}

function derive_damage_refs(point) {
  if(!isDefined(level.gib_tags)) {
    init_gib_tags();
  }
  closesttag = undefined;
  for(i = 0; i < level.gib_tags.size; i++) {
    if(!isDefined(closesttag)) {
      closesttag = level.gib_tags[i];
      continue;
    }
    if(distancesquared(point, self gettagorigin(level.gib_tags[i])) < distancesquared(point, self gettagorigin(closesttag))) {
      closesttag = level.gib_tags[i];
    }
  }
  if(closesttag == "J_SpineLower" || closesttag == "J_SpineUpper" || closesttag == "J_Spine4") {
    gibserverutils::gibrightarm(self);
  } else {
    if(closesttag == "J_Shoulder_LE" || closesttag == "J_Elbow_LE" || closesttag == "J_Wrist_LE") {
      if(!gibserverutils::isgibbed(self, 16)) {
        gibserverutils::gibleftarm(self);
      }
    } else {
      if(closesttag == "J_Shoulder_RI" || closesttag == "J_Elbow_RI" || closesttag == "J_Wrist_RI") {
        if(!gibserverutils::isgibbed(self, 32)) {
          gibserverutils::gibrightarm(self);
        }
      } else {
        if(closesttag == "J_Hip_LE" || closesttag == "J_Knee_LE" || closesttag == "J_Ankle_LE") {
          if(isDefined(self.nocrawler) && self.nocrawler) {
            return;
          }
          gibserverutils::gibleftleg(self);
          if(randomint(100) > 75) {
            gibserverutils::gibrightleg(self);
          }
          self.missinglegs = 1;
        } else if(closesttag == "J_Hip_RI" || closesttag == "J_Knee_RI" || closesttag == "J_Ankle_RI") {
          if(isDefined(self.nocrawler) && self.nocrawler) {
            return;
          }
          gibserverutils::gibrightleg(self);
          if(randomint(100) > 75) {
            gibserverutils::gibleftleg(self);
          }
          self.missinglegs = 1;
        }
      }
    }
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
  }
  if(damageyaw > 45 && damageyaw <= 135) {
    return "right";
  }
  if(damageyaw > -45 && damageyaw <= 45) {
    return "back";
  }
  return "left";
}

function anim_get_dvar_int(dvar, def) {
  return int(anim_get_dvar(dvar, def));
}

function anim_get_dvar(dvar, def) {
  if(getdvarstring(dvar) != "") {
    return getdvarfloat(dvar);
  }
  setdvar(dvar, def);
  return def;
}

function makezombiecrawler(b_both_legs) {
  if(isDefined(b_both_legs) && b_both_legs) {
    val = 100;
  } else {
    val = randomint(100);
  }
  if(val > 75) {
    gibserverutils::gibrightleg(self);
    gibserverutils::gibleftleg(self);
  } else {
    if(val > 37) {
      gibserverutils::gibrightleg(self);
    } else {
      gibserverutils::gibleftleg(self);
    }
  }
  self.missinglegs = 1;
  self allowedstances("crouch");
  self setphysparams(15, 0, 24);
  self allowpitchangle(1);
  self setpitchorient();
  health = self.health;
  health = health * 0.1;
}

function zombie_head_gib(attacker, means_of_death) {
  self endon("death");
  if(isDefined(self.head_gibbed) && self.head_gibbed) {
    return;
  }
  if(isDefined(self.no_gib) && self.no_gib) {
    return;
  }
  self.head_gibbed = 1;
  self zombie_eye_glow_stop();
  if(!(isDefined(self.disable_head_gib) && self.disable_head_gib)) {
    gibserverutils::gibhead(self);
  }
  self thread head_gib_damage_over_time(ceil(self.health * 0.2), 1, attacker, means_of_death);
}

function gib_random_parts() {
  if(isDefined(self.no_gib) && self.no_gib) {
    return;
  }
  val = randomint(100);
  if(val > 50) {
    self zombie_head_gib();
  }
  val = randomint(100);
  if(val > 50) {
    gibserverutils::gibrightleg(self);
  }
  val = randomint(100);
  if(val > 50) {
    gibserverutils::gibleftleg(self);
  }
  val = randomint(100);
  if(val > 50) {
    if(!gibserverutils::isgibbed(self, 32)) {
      gibserverutils::gibrightarm(self);
    }
  }
  val = randomint(100);
  if(val > 50) {
    if(!gibserverutils::isgibbed(self, 16)) {
      gibserverutils::gibleftarm(self);
    }
  }
}

function autoexec init_ignore_player_handler() {
  level._ignore_player_handler = [];
}

function register_ignore_player_handler(archetype, ignore_player_func) {
  assert(isDefined(archetype), "");
  assert(!isDefined(level._ignore_player_handler[archetype]), ("" + archetype) + "");
  level._ignore_player_handler[archetype] = ignore_player_func;
}

function run_ignore_player_handler() {
  if(isDefined(level._ignore_player_handler[self.archetype])) {
    self[[level._ignore_player_handler[self.archetype]]]();
  }
}

function show_hit_marker() {
  if(isDefined(self) && isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime(1);
    self.hud_damagefeedback.alpha = 0;
  }
}