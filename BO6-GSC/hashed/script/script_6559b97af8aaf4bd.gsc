/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_6559b97af8aaf4bd.gsc
*****************************************************/

#using script_5262c59c62fa4892;
#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\common\cap;
#using scripts\engine\utility;
#namespace ai_revival;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_dab0d83df51da4d":
      return &onuserinit;
    case #"hash_722d767fd6d40f56":
      return &onuserterminate;
    case #"hash_902f9e79d5e57c83":
      return &oneventreceived;
    case #"hash_ae182ac0084f18fa":
      return &movingtodyingguy;
    case #"hash_cfc067e44f70f86b":
      return &reviving;
    case #"hash_e7ffa3549475787":
      return &dyingguybeingrevived;
    case #"hash_f5cf55913a442596":
      return &earlyrevivedsuccess;
    case #"hash_303d74db152a39b9":
      return &interaction_common::function_9489bf6295c09884;
    case #"hash_be6abeab18f64c91":
      return &moveintoposition;
    case #"hash_25397093dba07e3a":
      return &remoterevive;
    case #"hash_2a5b537d23266f19":
      return &providecoverfire;
    case #"hash_669a3d0df855846d":
      return &beingremoterevived;
    case #"hash_18372b0f69e4b08c":
      return &waitforreviver;
  }

  assertmsg("<dev string:x24>" + funcid);
}

function onuserinit(interactionid) {}

function onuserterminate(interactionid) {
  if(isagent(self)) {
    assert(self isscriptable(), "<dev string:x45>" + self.agent_type + "<dev string:x55>");
  }

  scriptablepart = "\x8a\xb2\x9b\x05svC\xf10\xa4,/\"\x82\xfa~\fL\xa3";

  if(self isscriptable() && self getscriptablehaspart(scriptablepart)) {
    self setscriptablepartstate(scriptablepart, "\x91\xca\xcc\v\xab\xd8:");
  }

  self unlink();
  self.pushable = 1;
  self.skipdyingbackcrawl = 0;

  if(!isalive(self)) {
    function_756f062b5dfc6afa(interactionid, "\x1e\xfd\xd1\xa2\a", 1);
  } else {
    if(self.stealth_bsmstate == 0) {
      function_756f062b5dfc6afa(interactionid, ";P\x94\xd8z\x14\x82\xa4U\x82H\xce", 1);
    } else if(self.asmname == self.defaultasm) {
      function_756f062b5dfc6afa(interactionid, "\x1e\xfd\xd1\xa2\a", 1);
    }

    asm::asm_fireephemeralevent("\xf0<\x8eg#\xda\xc6", "8\xdb\x90");
    self clearbtgoal(3);
    self.var_4f5e88d965bf875e = 0;
    self.var_557fa6788942d486 = 0;

    if(self.var_d23e04e64504b9cb) {
      function_fe92c2b17dbf7dd5();
      coveringfirecleanup();
    }
  }

  self notify("\x93/\a\xf8\x1bIa'\xeb7Q");
}

function oneventreceived(receiver, info, origin) {
  if(info == "f\xdb\x8d\xba\xe6\xb2d\xd7o\xdc" && !utility::doinglongdeath()) {
    distsq = distancesquared(receiver.origin, origin);
    breakoutdist = 200;

    if(distsq < breakoutdist * breakoutdist && !istrue(function_9ba3cc4cff45eece(self getinteractionid(), "\x1e\xfd\xd1\xa2\a"))) {
      function_756f062b5dfc6afa(self getinteractionid(), "\x1e\xfd\xd1\xa2\a", 1);
      return true;
    }
  }

  return false;
}

function movingtodyingguy(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93/\a\xf8\x1bIa'\xeb7Q");
  dyingguy = getdyingguy();

  if(!isDefined(dyingguy)) {
    earlyoutinteraction();
  }

  dyingguy endon("\x1e\xfd\xd1\xa2\a");
  dyingguy endon("\x93/\a\xf8\x1bIa'\xeb7Q");
  goalrad = 10;
  dyingguypos = dyingguy.origin;
  self setbtgoalpos(3, dyingguypos);
  self setbtgoalRadius(3, goalrad);
  self waittill("\"}nLZ\x9b\xb7w");
  self.var_4f5e88d965bf875e = 1;
  self.var_557fa6788942d486 = 1;
  var_3788e699f55e6281 = 200;

  for(pathlength = self pathdisttogoal(); pathlength > var_3788e699f55e6281; pathlength = self pathdisttogoal()) {
    if(!isDefined(dyingguy)) {
      earlyoutinteraction();
    }

    dyingguypos = dyingguy.origin;
    self setbtgoalpos(3, dyingguypos);
    wait 0.2;
  }

  if(!isDefined(dyingguy)) {
    earlyoutinteraction();
  }

  dyingguy animmode(".\x0e\xa3\xbf|D\x02\xf3\xd4\xcf\x13\xd1");
  dyingguy.skipdyingbackcrawl = 1;
  dyingguy asmfireevent(dyingguy.asmname, "\x19yK\xcd\xce\xafL\xb0\xd8\xb6\xfa\xb19\xb0w\xc6\xd7\xc8\xbd\x9b\xca");
  dyingguypos = dyingguy.origin;
  dyingguy.pushable = 0;
  self.pushable = 0;
  introalias = function_35a4c084f7c1620a(dyingguy);
  rolestring = "\x0fd\xbf\xddt\xf5X\x99\x82\xbf\xf4\xa2";
  capinfo = function_a00d7cf424ac2865(self, rolestring);
  arcanimset = capinfo.animation;
  introstate = "B\xbc\xceh\xa8\x89W*\x83FQ\x94\x7f\xf1";
  alias = archetypegetalias(arcanimset, introstate, introalias, 0);
  animation = alias.anims;
  startorigin = getstartorigin(dyingguy.origin, dyingguy.angles, animation);
  startangles = getstartangles(dyingguy.origin, dyingguy.angles, animation);

  if(!ispointonnavmesh(startorigin, self)) {
    newalias = function_c9b03f1212c445b(introalias);
    alias = archetypegetalias(arcanimset, introstate, newalias, 0);
    animation = alias.anims;
    startorigin = getstartorigin(dyingguy.origin, dyingguy.angles, animation);
    startangles = getstartangles(dyingguy.origin, dyingguy.angles, animation);

    if(!ispointonnavmesh(startorigin, self)) {
      dyingguy.var_e42ef3393a0ccb72 = 0;
      function_756f062b5dfc6afa(self getinteractionid(), "\x1e\xfd\xd1\xa2\a", 1);
    }
  }

  self.revivetargetpos = startorigin;
  self setbtgoalpos(3, self.revivetargetpos);
  self.revivetargetangles = startangles;
  self.customarrivalangles = self.revivetargetangles;
  self.customarrivalstanceoverride = "1x\xc5\xb4\xabx";
  var_1758b32f889b6083 = 2;
  utility::waittill_any_timeout(var_1758b32f889b6083, "]7\x90\xc1\x84\x9f\x1e");

  while(istrue(self.arriving)) {
    waitframe();
  }

  if(!isDefined(dyingguy)) {
    earlyoutinteraction();
  }

  var_d840b2fbc0ff31f1 = 32;

  if(distancesquared(self.origin, self.revivetargetpos) < var_d840b2fbc0ff31f1 * var_d840b2fbc0ff31f1) {
    cap::cap_start("\xb1\xd0\xe3\x9ey\x06=^/w\x0e&\xa4\x83", "\xe0\xf8~\xf7\xb35J\x15\x9d\xaa5\xa1O\xa6\xe8h\x80\xca\xfe\xe0I\xc44\xf9H\xa4\xd5I'V\x93X");
    self waittill("5\xd9\x1a(2`\xe51\x90\xeb\xbc\xb7\xe5\xfb\xa4#\a\xd2\xda\xe64");
  } else {
    function_756f062b5dfc6afa(self getinteractionid(), "\x1e\xfd\xd1\xa2\a", 1);
  }

  self.var_4f5e88d965bf875e = 0;
  self clearbtgoal(3);
}

function reviving(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93/\a\xf8\x1bIa'\xeb7Q");
  self endon("\x9f{\x05H\xae\xach\xc8]\x19\xbe\xc09=\xfa\x1a\x9e\xd8");
  childthread adjustpos();
  wait 0.3;
  downedguy = getdyingguy();
  self.var_4f5e88d965bf875e = 0;

  if(isDefined(downedguy)) {
    self linktoblendtotag(downedguy, "\x81\xe4\xef\xf50^av");
  }

  self waittill("\x9f{\x05H\xae\xach\xc8]\x19\xbe\xc09=\xfa\x1a\x9e\xd8");
  self.var_b5bb7c85d338f913 = gettime();
}

function dyingguybeingrevived(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93/\a\xf8\x1bIa'\xeb7Q");
  cap::cap_start("\xb1\xd0\xe3\x9ey\x06=^/w\x0e&\xa4\x83", "\xe0\xf8~\xf7\xb35J\x15\x9d\xaa5\xa1O\xa6\xe8h\x80\xca\xfe\xe0I\xc44\xf9H\xa4\xd5I'V\x93X");

  while(!asm::asm_ephemeraleventfired("\xdd\xfb\x88\x7f\xd1\xa3\x951\xe4\x7f\x1dK1", "8\xdb\x90")) {
    frametime = level.frameduration;
    self.desiredtimeofdeath += frametime;
    waitframe();
  }

  self.doinglongdeath = 0;
  self.health = 150;
  self waittill("\x9f{\x05H\xae\xach\xc8]\x19\xbe\xc09=\xfa\x1a\x9e\xd8");
  function_10eaa7f558cdfb88();
}

function earlyrevivedsuccess(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93/\a\xf8\x1bIa'\xeb7Q");
  asm::asm_fireevent(self.asmname, "\xba\x10\x94\xe5\xba\xa9'\xfe\xcb\x05\x05g|c\x89s\xb6\\\xd1Y\xb2");

  if(istrue(self.doinglongdeath)) {
    self.doinglongdeath = 0;
    self.health = 150;
  }

  self waittill("\x9f{\x05H\xae\xach\xc8]\x19\xbe\xc09=\xfa\x1a\x9e\xd8");
  function_10eaa7f558cdfb88();
}

function moveintoposition(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93/\a\xf8\x1bIa'\xeb7Q");
  self setcanusecover(0);
  self allowedstances("\x8b\x90\xb5\xc4W");
  self.revivetarget = getdyingguy();
  targetpos = self.revivetarget.origin;
  canseedyingguy = self cansee(self.revivetarget);

  if(!canseedyingguy || distancesquared(self.origin, targetpos) > self.var_9e73c68d4c22c2de * self.var_9e73c68d4c22c2de) {
    targeteyepos = self.revivetarget getapproxeyepos();
    goalpos = findclosestlospointwithinradius(targeteyepos, self.var_9e73c68d4c22c2de, targeteyepos, self.origin);
    self setbtgoalpos(3, goalpos);
    self setbtgoalRadius(3, 32);
    self waittill("]7\x90\xc1\x84\x9f\x1e");
  } else {
    self setbtgoalstationary(3);
  }

  while(self.arriving) {
    waitframe();
  }
}

function remoterevive(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93/\a\xf8\x1bIa'\xeb7Q");
  cap::cap_start("\xb1\xd0\xe3\x9ey\x06=^/w\x0e&\xa4\x83", "\xe0\xf8~\xf7\xb35J\x15\x9d\xaa5\xa1O\xa6\xe8h\x80\xca\xfe\xe0I\xc44\xf9H\xa4\xd5I'V\x93X");
  self waittill("\x9f{\x05H\xae\xach\xc8]\x19\xbe\xc09=\xfa\x1a\x9e\xd8");
}

function providecoverfire(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93/\a\xf8\x1bIa'\xeb7Q");
  self.revivetarget = undefined;
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.cachemaxfaceenemydist = self.maxfaceenemydist;
  self.maxfaceenemydist = 2048;
  self.providecoveringfire = 1;
  self.balwayscoverexposed = 1;
  self.shootstyleoverride = "\x84\x9b\x8cB";
  wait self.var_19bb52b5f7e9b630;
  coveringfirecleanup();
}

function waitforreviver(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93/\a\xf8\x1bIa'\xeb7Q");
  self waittill("\xcc\a\xcb7R\xc2>\xa7\x9a\r2\xddc\xdd\x1f\x98Z\xbf\xee\xa7\xfe");
}

function beingremoterevived(statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93/\a\xf8\x1bIa'\xeb7Q");
  cap::cap_start("\xb1\xd0\xe3\x9ey\x06=^/w\x0e&\xa4\x83", "\xe0\xf8~\xf7\xb35J\x15\x9d\xaa5\xa1O\xa6\xe8h\x80\xca\xfe\xe0I\xc44\xf9H\xa4\xd5I'V\x93X");
  self waittill("\x9f{\x05H\xae\xach\xc8]\x19\xbe\xc09=\xfa\x1a\x9e\xd8");
  self.doinglongdeath = 0;
  self.health = self.maxhealth;
}

function private coveringfirecleanup() {
  if(!isDefined(self.cachemaxfaceenemydist)) {
    return;
  }

  self.providecoveringfire = 0;
  self.balwayscoverexposed = 0;
  self.shootstyleoverride = undefined;
  self.maxfaceenemydist = self.cachemaxfaceenemydist;
  self.cachemaxfaceenemydist = undefined;
}

function private function_fe92c2b17dbf7dd5() {
  self.ignoreall = 0;
  self.combatmode = ":\xc9\x93\xe1?";
  self setcanusecover(1);
  self allowedstances("\x8b\x90\xb5\xc4W", "1x\xc5\xb4\xabx");
  self clearbtgoal(3);
}

function private function_10eaa7f558cdfb88() {
  helper = function_1bac620ad086b8bf();

  if(isDefined(helper)) {
    helper unlink();
  }
}

function private adjustpos() {
  startpos = self.origin;
  startangles = self.angles;
  stilltoofar = distancesquared(startpos, self.revivetargetpos) > 100;
  var_e9f4dfd716cbb573 = absangleclamp180(startangles[1] - self.revivetargetangles[1]) > 7;

  if(stilltoofar || var_e9f4dfd716cbb573) {
    interval = 300;
    endtime = gettime() + interval;

    while(endtime > gettime()) {
      fraction = 1 - (endtime - gettime()) / interval;
      newpos = vectorlerp(startpos, self.revivetargetpos, fraction);
      newangles = anglelerpquatfrac(startangles, self.revivetargetangles, fraction);
      self forceteleport(newpos, newangles);
      waitframe();
    }
  }
}

function private function_35a4c084f7c1620a(dyingguy) {
  var_6f153b04b485b273 = 6;
  damagedirsuffix = "\x15%\x06\xefm";

  if(isDefined(dyingguy)) {
    var_6f153b04b485b273 = cap_ai_revival::function_af3185c651a23e1e(dyingguy, self);
    damagedirsuffix = dyingguy cap_ai_revival::getdamagedirectionsuffix();
  }

  return var_6f153b04b485b273 + damagedirsuffix;
}

function private function_c9b03f1212c445b(alias) {
  if(alias[0] == "P") {
    return ("\xbb" + getsubstr(alias, 1));
  }

  return "P" + getsubstr(alias, 1);
}

function private earlyoutinteraction() {
  function_756f062b5dfc6afa(self getinteractionid(), "\x1e\xfd\xd1\xa2\a", 1);
  self leaveinteraction();
}

function private getdyingguy() {
  id = self getinteractionid();
  users = function_a57c59df65be713(id, "<\x11\x1d\x91\x93\xe3\xd5=\xc3");
  return users[0];
}

function private function_1bac620ad086b8bf() {
  id = self getinteractionid();
  users = function_a57c59df65be713(id, "\x0fd\xbf\xddt\xf5X\x99\x82\xbf\xf4\xa2");
  return users[0];
}