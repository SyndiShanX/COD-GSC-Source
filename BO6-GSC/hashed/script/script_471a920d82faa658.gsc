/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_471a920d82faa658.gsc
*****************************************************/

#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\common\values;
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
      return &function_1a89fb33a52c0a6d;
    case #"hash_55e74e391a612ea8":
      return &function_ac14f53dfbbc3f61;
    case #"hash_d8934b522ed927fa":
      return &function_74224370800569f3;
    case #"hash_818982b14b2af1f":
      return &arrivalsetup;
    case #"hash_3454d29ae45c6cdb":
      return &function_e54a331046a245a6;
    case #"hash_c5687eec52003555":
      return &onarrival;
    case #"hash_e016759d0510a58c":
      return &onbailout;
    case #"hash_d50b41c248a37316":
      return &onenter;
    case #"hash_214ba25246813d79":
      return &function_b595ba767a02acd6;
    case #"hash_1ac92cc267a9ec26":
      return &goalcheckcleanup;
    case #"hash_f81d03def0fb7e01":
      return &function_5a16a388b5b60258;
    case #"hash_94e93145a62541a4":
      return &function_726da87b73b442c1;
    case #"hash_987435cc91e79a2f":
      return &function_64b687adee682fde;
  }

  return interaction_common::function_f33a8e8ea5e9c7cb(funcid);
}

function private onuserinit(interactionid) {
  setdvarifuninitialized(@ "hash_6bff7f7a44419fce", 0);

  if(!isDefined(function_9ba3cc4cff45eece(interactionid, "\xc4N\xca\x16l\x1a:/p\xca"))) {
    types = ["^-\xc5\xdc\xc1\f", "\xed@C\x98", "f\x8d,nh\xc4\v\xb9\xb3"];
    type = utility::random(types);
    function_756f062b5dfc6afa(interactionid, "\xc4N\xca\x16l\x1a:/p\xca", type);
  }

  self.doorcheck = spawnStruct();

  if(isDefined(self.node)) {
    self.doorcheck.priornode = self.node;
    return;
  }

  self.doorcheck.priorgoalpos = self.pathgoalpos;
}

function private onuserterminate(interactionid) {
  val::reset("9\xc9\x10L\xbf\xd6C\x90\x8a\x90", "T\xbf\x84KN\xc6\xc9\x97mk\xd33\xa9\xb4\xf5");
  val::reset("9\xc9\x10L\xbf\xd6C\x90\x8a\x90", "|]Nf\xad\xb49W>O\xcfW\x91\x11\x99]\xa7\xf68,\xf1");
  self.doorcheck = undefined;
  self clearbtgoal(3);
  self.capdata = undefined;
  self.customarrivalhandler = undefined;

  if(self.defaultasm != self.asmname) {
    cap::cap_exit();
  }

  users = function_c922f1d69b3b8e4b(interactionid);

  if(users.size == 1) {
    doorid = function_9ba3cc4cff45eece(interactionid, "\xdb\x84\x85\xfel\xde\x83\xfal");

    if(isDefined(doorid)) {
      function_acb9e6c11997e4ec(doorid, gettime() + 10000);
    }
  }
}

function private calcstartorigin(statename, role) {
  id = self getinteractionid();
  assert(isDefined(id));
  origin = function_658a8c3245e83656(id);
  angles = function_93a9087f0dbeff28(id);
  doordir = anglesToForward(angles);
  var_26fb733dad7884eb = origin - self.origin;
  cross = vectorcross(var_26fb733dad7884eb, doordir);
  bleft = 1;

  if(cross[2] < 0) {
    bleft = 0;
  }

  idlestate = "\xc4\x87W\x9a=\xdaWN\xa6";

  if(bleft) {
    idlealias = "=\xff0b";
  } else {
    idlealias = "o0\xee\xc1\x8c";
  }

  door_knob = function_9ba3cc4cff45eece(id, "\xb62o\xc8L\xab\x9d\xfa\xdf");

  if(isDefined(door_knob)) {
    idlealias = door_knob;
  }

  if(role == "\xe3\x93}=nD") {
    function_756f062b5dfc6afa(id, "\x7f\x9b\xc3\x83\xd7\xd1\x98\x81@\xa9", idlealias);
  } else {
    occupiedside = function_9ba3cc4cff45eece(id, "\x7f\x9b\xc3\x83\xd7\xd1\x98\x81@\xa9");

    if(occupiedside == "=\xff0b") {
      idlealias = "o0\xee\xc1\x8c";
    } else {
      idlealias = "=\xff0b";
    }
  }

  openness = function_9ba3cc4cff45eece(id, "'\x98vI\x16Y5]");

  if(isDefined(openness)) {
    openness = abs(openness);
  }

  if(!istrue(function_9ba3cc4cff45eece(id, "n\x95\xf0x[\x10\xc7\xb9\xb1\xda\xaes\xd3")) || isDefined(openness) && openness > 45) {
    idlealias += ">\xed\xeey\xb6L\x02JJ";
  }

  type = function_9ba3cc4cff45eece(id, "\xc4N\xca\x16l\x1a:/p\xca");
  rolestring = type;
  capinfo = function_a00d7cf424ac2865(self, rolestring);
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

  self.customarrivalstate = idlealias + "\xe1\xdb\xc5\xc0\xf1\xc6S?\b\xb0\x99\xbc\xf3";
  self.customarrivalanimset = animset;
  self.customarrivalangles = angles;
  self.customarrivalanimangles = idleangles;
  self.var_ae2790476708dfb3 = 1;
  self.var_a455788a527e5bcd = 1;
  self.capdata = spawnStruct();
  self.capdata.asmname = capinfo.capname;
  self.capdata.animsetname = animset;
  self.capdata.dooralias = idlealias;
  self.capdata.angles = idleangles;
  self.capdata.var_7f854f6eb1de7f4 = "\xf1Z\x8c\x9b";
  self.capdata.role = role;
  self.capdata.idleorigin = idleorigin;

  if(role == "v\xa0\fnG\x14\a") {
    self.capdata.var_7f854f6eb1de7f4 = "2\xf3\xc4\x1a";
  }

  self.customarrivalhandler = &customarrivalhandler;

  if(getdvarint(@ "hash_6bff7f7a44419fce", 0) == 1) {
    thread function_328dc70bf6456ad6(idleorigin, idleangles);
  }

  return idleorigin;
}

function private function_1a89fb33a52c0a6d(statename, mindist, maxdist) {
  id = self getinteractionid();
  origin = function_658a8c3245e83656(id);
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
        print3d(point.origin + (0, 0, 100), "<dev string:x24>", (255, 255, 255), 1, 0.6, 200);
        utility::draw_circle(point.origin, 16, (1, 1, 0), 1, 0, 200);
      }

      return point.origin;
    } else {
      point = self getclosestreachablepointonnavmesh(endpoint);
    }

    if(getdvarint(@ "hash_6bff7f7a44419fce", 0) == 1) {
      print3d(point + (0, 0, 100), "<dev string:x24>", (255, 255, 255), 1, 0.6, 200);
      utility::draw_circle(point, 16, (1, 1, 0), 1, 0, 200);
    }
  }

  return point;
}

function private customarrivalhandler() {
  assert(isDefined(self.capdata));
  self.capdata.var_533eb93889eb1960 = 1;
  cap::cap_start(self.capdata.asmname, self.capdata.animsetname);
}

function private arrivalsetup(statename, params) {}

function private arrivalcleanup(statename, params) {
  self.customarrivalstate = undefined;
  self.customarrivalanimset = undefined;
  self.customarrivalangles = undefined;
  self.customarrivalanimangles = undefined;
  self.var_ae2790476708dfb3 = 0;
  self.var_a455788a527e5bcd = 0;
}

function private opendoor(interactionid, var_7844fa61b173094a) {
  doorobj = function_9ba3cc4cff45eece(interactionid, "\xe2\xc0Qo");

  if(isDefined(doorobj) && doorobj scriptabledoorisclosed()) {
    doorobj scriptabledooropen("\xca\xed\x88\xa9", self.origin);
  }
}

function private onarrival(statename, params) {
  if(!istrue(self.capdata.var_533eb93889eb1960)) {
    arrivalcleanup();
    cap::cap_start(self.capdata.asmname, self.capdata.animsetname);
  }

  self.doorcheck.arrived = 1;
  val::set("9\xc9\x10L\xbf\xd6C\x90\x8a\x90", "T\xbf\x84KN\xc6\xc9\x97mk\xd33\xa9\xb4\xf5", 0);
  val::set("9\xc9\x10L\xbf\xd6C\x90\x8a\x90", "|]Nf\xad\xb49W>O\xcfW\x91\x11\x99]\xa7\xf68,\xf1", 0);
  sidetoken = self.capdata.dooralias;
  numbertoken = self.capdata.var_7f854f6eb1de7f4;
  roletoken = self.capdata.role;
  self.capdata.var_8b58cf2cd94cd535 = sidetoken + "w" + numbertoken + "w" + roletoken;
  self function_8230c20d85235be6();
  id = self getinteractionid();
  breachtype = function_9ba3cc4cff45eece(id, "\xc4N\xca\x16l\x1a:/p\xca");
  var_a476451e154e01a4 = isDefined(breachtype) && breachtype == "f\x8d,nh\xc4\v\xb9\xb3";

  if(var_a476451e154e01a4 && istrue(function_9ba3cc4cff45eece(id, "n\x95\xf0x[\x10\xc7\xb9\xb1\xda\xaes\xd3"))) {
    opendoor(id, self.origin);
  }
}

function private onbailout(statename, params) {
  id = self getinteractionid();
  abortinteraction(id);
  doorid = function_9ba3cc4cff45eece(id, "\xdb\x84\x85\xfel\xde\x83\xfal");

  if(isDefined(doorid)) {
    function_acb9e6c11997e4ec(doorid, gettime() + 10000);
  }
}

function private onenter(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.capdata.var_e52cf7bbf2bb8587 = 1;

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
    if(self asmeventfired(self.asmname, "8\xdb\x90")) {
      break;
    }

    waitframe();
  }
}

function doorcheck_shoulddoarrival(asmname, statename, tostatename, params) {
  return istrue(self.capdata.var_533eb93889eb1960);
}

function function_dde1f6fc067c436a(asmname, statename, tostatename, params) {
  return istrue(self.capdata.var_e52cf7bbf2bb8587);
}

function function_16ab5152508eabdd(asmname, statename, params) {
  alias = self.capdata.dooralias;
  return asm::asm_lookupanimfromalias(statename, alias);
}

function function_593bfd341dbdb19(asmname, statename, params) {
  alias = self.capdata.dooralias + "w" + self.capdata.var_7f854f6eb1de7f4 + "w" + self.capdata.role;
  return asm::asm_lookupanimfromalias(statename, alias);
}

function function_c59104f74a0edeb9() {
  if(utility::issp()) {
    return "\xef\xd8\x94\x8d\xba";
  }

  return "\xd333_\b\xef\xc7#\x1d\xfd1I\xddi-\xa2";
}

function function_46ec76e6b196a7a0(note) {
  if(note == "\x03\xd7b\x86w\xb7\x9f\xea\xd5") {
    opendoor(self getinteractionid(), self.origin);
    return;
  }

  if(note == "_\x8fQv\x1b\xfdi\\n\xe8\x15n" || note == "\xfe-\xc5[\x81\n\xef\xe7\xed\x0fD`\xcb") {
    grenadeweapon = function_c59104f74a0edeb9();
    grenademodel = getweaponmodel(grenadeweapon);
    assert(isDefined(grenademodel));

    if(note == "_\x8fQv\x1b\xfdi\\n\xe8\x15n") {
      self.grenadeattachtag = #"tag_accessory_left";
    } else {
      self.grenadeattachtag = #"tag_accessory_right";
    }

    self attach(grenademodel, self.grenadeattachtag);
    self.grenademodel = grenademodel;
    thread function_83ce1631f7c48bb3();
    return;
  }

  if(note == "\x9e\x19\xa8K\xf6\xfc3<R\xc1\xd4\xbay") {
    assert(isDefined(self.grenadeattachtag));
    grenadeweapon = function_c59104f74a0edeb9();
    grenadepos = self gettagorigin(self.grenadeattachtag);
    magicgrenademanual(grenadeweapon, grenadepos, self.doorcheck.grenadedir * 20, 1, self);
    self detach(self.grenademodel, self.grenadeattachtag);
    self.grenademodel = undefined;
    self.grenadeattachtag = undefined;
  }
}

function function_83ce1631f7c48bb3() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xa4\xc8\xbas\x90\x8b\xbe\xd1\xef<R\xda\xc4\xe3\x9b\x9f\x0f");
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

function function_34840dd313e6d059(asmname, statename, params) {
  thread asm::function_1be97a4513bb86d2(asmname, statename, 1);
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.capdata.angles[1]);
  self asmfireephemeralevent("X\x93\xc9i;\xac\x8c", "8\xdb\x90");
  self.doorcheck.arrived = 1;
}

function function_ed94a31b396a3c5(asmname, statename, params) {
  thread asm::asm_playanimstate(asmname, statename, params);
  self function_566298330e6e18fa(self.capdata.idleorigin, self.capdata.angles, 0.3);
}

function function_4c8260e2e16b4508(asmname, statename, tostatename, params) {
  if(!isDefined(params) || isarray(params)) {
    assertmsg("<dev string:x3b>");
    return false;
  }

  if(!isDefined(self.capdata.dooralias)) {
    return false;
  }

  side = self.capdata.dooralias;

  if(isDefined(self.capdata.role) && self.capdata.role == "v\xa0\fnG\x14\a") {
    if(side == "=\xff0b") {
      side = "o0\xee\xc1\x8c";
    } else if(side == "o0\xee\xc1\x8c") {
      side = "=\xff0b";
    }
  }

  return self.capdata.dooralias == params;
}

function private function_726da87b73b442c1(params) {
  barriving = self.arriving;

  if(istrue(barriving)) {
    return false;
  }

  return istrue(self.doorcheck.arrived) || self isingoal(self.origin);
}

function private function_64b687adee682fde(params) {
  return istrue(self.doorcheck.arrived);
}

function private function_ac14f53dfbbc3f61(asmname, statename, tostatename, params) {
  id = self getinteractionid();
  assert(isDefined(id));
  origin = function_658a8c3245e83656(id);
  angles = function_93a9087f0dbeff28(id);
  doordir = anglesToForward(angles);
  var_26fb733dad7884eb = origin - self.origin;
  cross = vectorcross(var_26fb733dad7884eb, doordir);
  bleft = 1;

  if(cross[2] < 0) {
    bleft = 0;
  }

  if(bleft) {
    desiredside = "=\xff0b";
  } else {
    desiredside = "o0\xee\xc1\x8c";
  }

  var_647a6d896eb14f21 = function_9ba3cc4cff45eece(id, "\xb62o\xc8L\xab\x9d\xfa\xdf");
  mustcross = desiredside == var_647a6d896eb14f21;
  openness = function_9ba3cc4cff45eece(id, "'\x98vI\x16Y5]");
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

function private function_74224370800569f3(asmname, statename, tostatename, params) {
  id = self getinteractionid();
  hasdoor = function_9ba3cc4cff45eece(id, "n\x95\xf0x[\x10\xc7\xb9\xb1\xda\xaes\xd3");
  return !istrue(hasdoor);
}

function private function_5a16a388b5b60258(asmname, statename, tostatename, params) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  id = self getinteractionid();
  origin = function_658a8c3245e83656(id);
  angles = function_93a9087f0dbeff28(id);
  doordir = anglesToForward(angles);
  enemypos = self.enemy.origin;
  toenemy = vectornormalize2(enemypos - origin);
  delta = vectordot(doordir, toenemy);
  return delta <= 0;
}

function private function_e54a331046a245a6(interactionid) {
  self.capdata.var_7f854f6eb1de7f4 = "2\xf3\xc4\x1a";
}

function function_b595ba767a02acd6(interactionid) {}

function goalcheckcleanup(interactionid) {}

function private function_328dc70bf6456ad6(idleorigin, idleangles) {
  self endon("\x1e\xfd\xd1\xa2\a");
  forward = anglesToForward(idleangles);
  end = idleorigin + forward * 32;
  id = self getinteractionid();
  breachtype = function_9ba3cc4cff45eece(id, "\xc4N\xca\x16l\x1a:/p\xca");
  intorg = function_658a8c3245e83656(id);
  intfwd = anglesToForward(function_93a9087f0dbeff28(id));
  intend = intorg + intfwd * 32;
  utility::draw_arrow_time(intorg, intend, (150, 50, 150), 5);
  utility::draw_arrow_time(idleorigin, end, (150, 50, 150), 5);

  print3d(idleorigin + (0, 0, 100), breachtype, (255, 255, 255), 1, 0.6, 200);

  print3d(idleorigin + (0, 0, 80), self.capdata.dooralias + "<dev string:x76>" + self.capdata.var_7f854f6eb1de7f4 + "<dev string:x76>" + self.capdata.role, (255, 255, 255), 1, 0.6, 150);

  print3d(idleorigin + (0, 0, 60), self.customarrivalstate, (255, 255, 255), 1, 0.4, 150);
}