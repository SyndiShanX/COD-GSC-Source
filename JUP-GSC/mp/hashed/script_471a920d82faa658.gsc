/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_471a920d82faa658.gsc
*************************************************/

#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace door_check;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_dab0d83df51da4d":
      return &onuserinit;
    case #"hash_722d767fd6d40f56":
      return &onuserterminate;
    case #"hash_9f9e07224ff2a95a":
      return &calcstartorigin;
    case #"hash_88347dbc54e3c555":
      return &function_17c9514d056f8b0c;
    case #"hash_55e74e391a612ea8":
      return &function_e62b12681729b218;
    case #"hash_d8934b522ed927fa":
      return &function_17557d7a61c7b24a;
    case #"hash_818982b14b2af1f":
      return &arrivalsetup;
    case #"hash_3454d29ae45c6cdb":
      return &function_af686e8a0657ce57;
    case #"hash_c5687eec52003555":
      return &onarrival;
    case #"hash_e016759d0510a58c":
      return &onbailout;
    case #"hash_d50b41c248a37316":
      return &onenter;
    case #"hash_214ba25246813d79":
      return &function_8055622a418ebd4f;
    case #"hash_1ac92cc267a9ec26":
      return &goalcheckcleanup;
    case #"hash_f81d03def0fb7e01":
      return &function_27937ccb1b1abef1;
    case #"hash_94e93145a62541a4":
      return &function_23cd7f6fdf460eb4;
    case #"hash_987435cc91e79a2f":
      return &function_21bcb65ded71229f;
  }

  return namespace_f901a4f9d899be59::function_efcea5d26798e5b6(funcid);
}

function private onuserinit(interactionid) {
  setdvarifuninitialized(@ "hash_6bff7f7a44419fce", 0);

  if(!isDefined(function_60d6151af81a343(interactionid, "breachtype"))) {
    types = ["breach", "kick", "flashbang"];
    type = random(types);
    function_ae368fad1a1dc337(interactionid, "breachtype", type);
  }

  self.doorcheck = spawnStruct();

  if(isDefined(self.node)) {
    self.doorcheck.priornode = self.node;
    return;
  }

  self.doorcheck.priorgoalpos = self.pathgoalpos;
}

function private onuserterminate(interactionid) {
  if(isDefined(self.capdata) && isDefined(self.capdata.var_9c471c82abe76355)) {
    self.script_pushable = self.capdata.var_9c471c82abe76355;
    self.script_pushable_by_ai = self.capdata.var_512299ff86496ad6;
  }

  self.doorcheck = undefined;
  self clearbtgoal(3);
  self.capdata = undefined;
  self.customarrivalhandler = undefined;

  if(self.defaultasm != self.asmname) {
    scripts\common\cap::cap_exit();
  }

  users = getbsequsers(interactionid);

  if(users.size == 1) {
    doorid = function_60d6151af81a343(interactionid, "doorindex");

    if(isDefined(doorid)) {
      updateroomdoorclaim(doorid, gettime() + 10000);
    }
  }
}

function private calcstartorigin(statename, role) {
  id = self getinteractionid();
  assert(isDefined(id));
  origin = getinteractionorigin(id);
  angles = getinteractionangles(id);
  doordir = anglesToForward(angles);
  var_5c6afc1001475042 = origin - self.origin;
  cross = vectorcross(var_5c6afc1001475042, doordir);
  bleft = 1;

  if(cross[2] < 0) {
    bleft = 0;
  }

  idlestate = "door_idle";

  if(bleft) {
    idlealias = "left";
  } else {
    idlealias = "right";
  }

  door_knob = function_60d6151af81a343(id, "door_knob");

  if(isDefined(door_knob)) {
    idlealias = door_knob;
  }

  if(role == "active") {
    function_ae368fad1a1dc337(id, "activeside", idlealias);
  } else {
    occupiedside = function_60d6151af81a343(id, "activeside");

    if(occupiedside == "left") {
      idlealias = "right";
    } else {
      idlealias = "left";
    }
  }

  openness = function_60d6151af81a343(id, "openness");

  if(isDefined(openness)) {
    openness = abs(openness);
  }

  if(!istrue(function_60d6151af81a343(id, "path_has_door")) || isDefined(openness) && openness > 45) {
    idlealias += "_doorless";
  }

  type = function_60d6151af81a343(id, "breachtype");
  rolestring = type;
  capinfo = getcapinfoforrole(self, rolestring);
  animset = capinfo.animation;
  animid = archetypegetrandomalias(animset, idlestate, idlealias, 0);
  assert(animid >= 0);
  xanim = animsetgetanimfromindex(animset, idlestate, animid);
  idleorigin = getstartorigin(origin, angles, xanim);
  idleangles = getstartangles(origin, angles, xanim);
  snappedidleorigin = getclosestpointonnavmesh(idleorigin, self, 0, 1, 0);

  if(isDefined(snappedidleorigin)) {
    idleorigin = snappedidleorigin;
  }

  self.customarrivalstate = idlealias + "_door_arrival";
  self.customarrivalanimset = animset;
  self.customarrivalangles = angles;
  self.customarrivalanimangles = idleangles;
  self.var_171120e99df3e286 = 1;
  self.var_a2a6c6c46defe8c4 = 1;
  self.capdata = spawnStruct();
  self.capdata.asmname = capinfo.capname;
  self.capdata.animsetname = animset;
  self.capdata.dooralias = idlealias;
  self.capdata.angles = idleangles;
  self.capdata.var_2b1676bab1ba8985 = "solo";
  self.capdata.role = role;
  self.capdata.idleorigin = idleorigin;

  if(role == "support") {
    self.capdata.var_2b1676bab1ba8985 = "dual";
  }

  self.customarrivalhandler = &customarrivalhandler;

  if(getdvarint(@ "hash_6bff7f7a44419fce", 0) == 1) {
    thread function_64fca4864613393f(idleorigin, idleangles);
  }

  return idleorigin;
}

function private function_17c9514d056f8b0c(statename, mindist, maxdist) {
  id = self getinteractionid();
  origin = getinteractionorigin(id);
  doortome = vectorNormalize(self.origin - origin);
  dist = randomintrange(mindist, maxdist);
  endpoint = origin + doortome * dist;

  if(getdvarint(@ "hash_6bff7f7a44419fce", 0) == 1) {
    line(origin, endpoint, (0, 0, 1), 1, 0, 200);
  }

  point = findclosestlospointwithinradius(origin, maxdist, origin, endpoint);

  if(!isDefined(point)) {
    point = findclosesttacpoint(endpoint);

    if(isDefined(point)) {
      if(getdvarint(@ "hash_6bff7f7a44419fce", 0) == 1) {
        print3d(point.origin + (0, 0, 100), "<dev string:x1c>", (255, 255, 255), 1, 0.6, 200);
        draw_circle(point.origin, 16, (1, 1, 0), 1, 0, 200);
      }

      return point.origin;
    } else {
      point = self getclosestreachablepointonnavmesh(endpoint);
    }

    if(getdvarint(@ "hash_6bff7f7a44419fce", 0) == 1) {
      print3d(point + (0, 0, 100), "<dev string:x1c>", (255, 255, 255), 1, 0.6, 200);
      draw_circle(point, 16, (1, 1, 0), 1, 0, 200);
    }
  }

  return point;
}

function private customarrivalhandler() {
  assert(isDefined(self.capdata));
  self.capdata.var_74c9b1f78857273d = 1;
  scripts\common\cap::cap_start(self.capdata.asmname, self.capdata.animsetname);
}

function private arrivalsetup(statename, params) {}

function private arrivalcleanup(statename, params) {
  self.customarrivalstate = undefined;
  self.customarrivalanimset = undefined;
  self.customarrivalangles = undefined;
  self.customarrivalanimangles = undefined;
  self.var_171120e99df3e286 = 0;
  self.var_a2a6c6c46defe8c4 = 0;
}

function private opendoor(interactionid, var_d293838fe8a43473) {
  doorobj = function_60d6151af81a343(interactionid, "door");

  if(isDefined(doorobj) && doorobj scriptabledoorisclosed()) {
    doorobj scriptabledooropen("away", self.origin);
  }
}

function private onarrival(statename, params) {
  if(!istrue(self.capdata.var_74c9b1f78857273d)) {
    arrivalcleanup();
    scripts\common\cap::cap_start(self.capdata.asmname, self.capdata.animsetname);
  }

  self.doorcheck.arrived = 1;
  self.capdata.var_9c471c82abe76355 = self.script_pushable;
  self.capdata.var_512299ff86496ad6 = self.script_pushable_by_ai;
  self.script_pushable = 0;
  self.script_pushable_by_ai = 0;
  sidetoken = self.capdata.dooralias;
  numbertoken = self.capdata.var_2b1676bab1ba8985;
  roletoken = self.capdata.role;
  self.capdata.var_c58c71ebc71f7728 = sidetoken + "_" + numbertoken + "_" + roletoken;
  self interactioncleargoalpos();
  id = self getinteractionid();
  breachtype = function_60d6151af81a343(id, "breachtype");
  var_48d356c204bf2b81 = isDefined(breachtype) && breachtype == "flashbang";

  if(var_48d356c204bf2b81 && function_60d6151af81a343(id, "path_has_door")) {
    opendoor(id, self.origin);
  }
}

function private onbailout(statename, params) {
  id = self getinteractionid();
  abortinteraction(id);
  doorid = function_60d6151af81a343(id, "doorindex");

  if(isDefined(doorid)) {
    updateroomdoorclaim(doorid, gettime() + 10000);
  }
}

function private onenter(statename, params) {
  self endon("death");
  self.capdata.var_3f651b778e93656e = 1;

  if(isDefined(self.doorcheck.priornode)) {
    self setbtgoalnode(3, self.doorcheck.priornode);
    self.doorcheck.priornode = undefined;
  } else if(isDefined(self.doorcheck.priorgoalpos)) {
    self setbtgoalpos(3, self.doorcheck.priorgoalpos);
    self.doorcheck.priorgoalpos = undefined;
  }

  endtime = gettime() + 5000;
  waitframe();

  while(gettime() < endtime) {
    if(self asmeventfired(self.asmname, "end")) {
      break;
    }

    waitframe();
  }
}

function doorcheck_shoulddoarrival(asmname, statename, tostatename, params) {
  return istrue(self.capdata.var_74c9b1f78857273d);
}

function function_57787698e416086f(asmname, statename, tostatename, params) {
  return istrue(self.capdata.var_3f651b778e93656e);
}

function function_14242f7e3e92261c(asmname, statename, params) {
  alias = self.capdata.dooralias;
  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

function function_cfa7813e89867c4(asmname, statename, params) {
  alias = self.capdata.dooralias + "_" + self.capdata.var_2b1676bab1ba8985 + "_" + self.capdata.role;
  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

function function_cea2a40434f5918() {
  if(utility::issp()) {
    return "flash";
  }

  return "flash_grenade_mp";
}

function function_ce30ac74cab64cfd(note) {
  if(note == "door_open") {
    opendoor(self getinteractionid(), self.origin);
    return;
  }

  if(note == "grenade_left" || note == "grenade_right") {
    grenadeweapon = function_cea2a40434f5918();
    grenademodel = getweaponmodel(grenadeweapon);
    assert(isDefined(grenademodel));

    if(note == "grenade_left") {
      self.grenadeattachtag = t "tag_accessory_left";
    } else {
      self.grenadeattachtag = t "tag_accessory_right";
    }

    self attach(grenademodel, self.grenadeattachtag);
    self.grenademodel = grenademodel;
    thread function_184b5862455e8902();
    return;
  }

  if(note == "grenade_throw") {
    assert(isDefined(self.grenadeattachtag));
    grenadeweapon = function_cea2a40434f5918();
    grenadepos = self gettagorigin(self.grenadeattachtag);
    magicgrenademanual(grenadeweapon, grenadepos, self.doorcheck.grenadedir * 20, 1, self);
    self detach(self.grenademodel, self.grenadeattachtag);
    self.grenademodel = undefined;
    self.grenadeattachtag = undefined;
  }
}

function function_184b5862455e8902() {
  self endon("death");
  self endon("bseq_user_deleted");
  prevhandpos = self gettagorigin(self.grenadeattachtag);
  self.doorcheck.grenadedir = anglesToForward(self.angles);
  waitframe();

  while(isDefined(self.grenadeattachtag)) {
    handpos = self gettagorigin(self.grenadeattachtag);
    self.doorcheck.grenadedir = handpos - prevhandpos;
    prevhandpos = handpos;
    waitframe();
  }
}

function function_a3564484875da8f8(asmname, statename, params) {
  thread scripts\asm\asm::function_fb56c9527636713f(asmname, statename, 1);
  self orientmode("face angle", self.capdata.angles[1]);
  self asmfireephemeralevent("arrived", "end");
  self.doorcheck.arrived = 1;
}

function function_26b903a39f018550(asmname, statename, params) {
  thread scripts\asm\asm::asm_playanimstate(asmname, statename, params);
  self function_802c56a3df8c7797(self.capdata.idleorigin, self.capdata.angles, 0.3);
}

function function_a910d69a0daa7775(asmname, statename, tostatename, params) {
  if(!isDefined(params) || isarray(params)) {
    assertmsg("<dev string:x33>");
    return false;
  }

  if(!isDefined(self.capdata.dooralias)) {
    return false;
  }

  side = self.capdata.dooralias;

  if(isDefined(self.capdata.role) && self.capdata.role == "support") {
    if(side == "left") {
      side = "right";
    } else if(side == "right") {
      side = "left";
    }
  }

  return self.capdata.dooralias == params;
}

function private function_23cd7f6fdf460eb4(params) {
  return istrue(self.doorcheck.arrived) || self isingoal(self.origin);
}

function private function_21bcb65ded71229f(params) {
  return istrue(self.doorcheck.arrived);
}

function private function_e62b12681729b218(asmname, statename, tostatename, params) {
  id = self getinteractionid();
  assert(isDefined(id));
  origin = getinteractionorigin(id);
  angles = getinteractionangles(id);
  doordir = anglesToForward(angles);
  var_5c6afc1001475042 = origin - self.origin;
  cross = vectorcross(var_5c6afc1001475042, doordir);
  bleft = 1;

  if(cross[2] < 0) {
    bleft = 0;
  }

  if(bleft) {
    desiredside = "left";
  } else {
    desiredside = "right";
  }

  var_bb3bfbc5f90b8e98 = function_60d6151af81a343(id, "door_knob");
  mustcross = desiredside == var_bb3bfbc5f90b8e98;
  openness = function_60d6151af81a343(id, "openness");
  dooropen = 1;

  if(isDefined(openness)) {
    openness = abs(openness);
    dooropen = openness >= 45;
  }

  if(mustcross && dooropen) {
    return false;
  }

  return true;
}

function private function_17557d7a61c7b24a(asmname, statename, tostatename, params) {
  id = self getinteractionid();
  hasdoor = function_60d6151af81a343(id, "path_has_door");
  return !istrue(hasdoor);
}

function private function_27937ccb1b1abef1(asmname, statename, tostatename, params) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  id = self getinteractionid();
  origin = getinteractionorigin(id);
  angles = getinteractionangles(id);
  doordir = anglesToForward(angles);
  enemypos = self.enemy.origin;
  toenemy = vectornormalize2(enemypos - origin);
  delta = vectordot(doordir, toenemy);
  return delta <= 0;
}

function private function_af686e8a0657ce57(interactionid) {
  self.capdata.var_2b1676bab1ba8985 = "dual";
}

function function_8055622a418ebd4f(interactionid) {}

function goalcheckcleanup(interactionid) {}

function private function_64fca4864613393f(idleorigin, idleangles) {
  self endon("death");
  forward = anglesToForward(idleangles);
  end = idleorigin + forward * 32;
  id = self getinteractionid();
  breachtype = function_60d6151af81a343(id, "breachtype");
  intorg = getinteractionorigin(id);
  intfwd = anglesToForward(getinteractionangles(id));
  intend = intorg + intfwd * 32;
  draw_arrow_time(intorg, intend, (150, 50, 150), 5);
  draw_arrow_time(idleorigin, end, (150, 50, 150), 5);

  print3d(idleorigin + (0, 0, 100), breachtype, (255, 255, 255), 1, 0.6, 200);

  print3d(idleorigin + (0, 0, 80), self.capdata.dooralias + "<dev string:x6e>" + self.capdata.var_2b1676bab1ba8985 + "<dev string:x6e>" + self.capdata.role, (255, 255, 255), 1, 0.6, 150);

  print3d(idleorigin + (0, 0, 60), self.customarrivalstate, (255, 255, 255), 1, 0.4, 150);
}