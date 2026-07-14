/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_53651341190c5aab.gsc
*****************************************************/

#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\common\cap;
#namespace interaction_common;

function onadduser(interactionid) {
  self notify("\xd9^\xfd\\%\x8f \x01\xe9mQ\a\xdf\x06\x1b\xa4\x83\xf7\xf0");
}

function ondeleteuser(interactionid) {
  if(isai(self)) {
    self.var_2e9190fb4a36ab3a = undefined;
    self._blackboard.idlenode = undefined;
    self._blackboard.var_efc6f1808bb99442 = undefined;
    self.var_cfc29353d5327ef7 = undefined;
  }

  self notify("/\xea\xde \xef\xad\x86:'o\x853R.\xfa");
}

function function_f33a8e8ea5e9c7cb(funcid) {
  switch (funcid) {
    case #"hash_4d7ca12cb5ce1028":
      return &startcap;
    case #"hash_303d74db152a39b9":
      return &function_9489bf6295c09884;
    case #"hash_996b6e15533d90f1":
      return &withindisttogoal;
    case #"hash_b541f16499b1633d":
      return &processevent;
    case #"hash_c0639b15cea67610":
      return &onadduser;
    case #"hash_96053be986d24f88":
      return &ondeleteuser;
    case #"hash_cec0f8624eb06844":
      return &asm_cap::function_598120a431bcec4c;
    case #"hash_af8904470869cfc3":
      return &function_9e054cf688bde9c2;
    case #"hash_a56eca06864aaf61":
      return &inplace;
    case #"hash_8cc77e3e31358f72":
      return &usecustomreact;
    case #"hash_fd9154ff75bc4e6b":
      return &function_747f51a6a109d8a2;
    case #"hash_e8db290ca384380d":
      return &isfrienddown;
    case #"hash_256be1b3fc8ce14c":
      return &addscriptmodel;
    case #"hash_1e571ef374ec6101":
      return &cleanupscriptmodel;
    case #"hash_694e601f9cb204ca":
      return &setupscriptmodel;
    case #"hash_d218d98026b6b9d7":
      return &markscriptmodelreachedend;
  }

  assertmsg("<dev string:x24>" + funcid);
}

function function_9489bf6295c09884(statename, params) {
  assert(params.size == 1);
  phasename = params[0];
  self._blackboard.bseqphase = phasename;
  function_4a6d88257711c8c5(phasename);
}

function startcap(statename, params) {
  if(istrue(self.startinteractionimmediate)) {
    startcap_immediate(statename, params);
    return;
  }

  capinfo = function_4b3a8f32b9155a2c(self);

  if(!isDefined(capinfo)) {
    capinfo = function_a00d7cf424ac2865(self, params[0]);

    if(!isDefined(capinfo)) {
      return;
    }
  }

  capname = capinfo.capname;
  animset = capinfo.animation;
  arrivalstateoverride = capinfo.arrivalstateoverride;
  introstatename = capinfo.initialstate;
  introaliasname = capinfo.initialalias;
  interaction = spawnStruct();
  interaction.angles = self._blackboard.var_5134c0f792da7ea8;
  interaction.origin = self._blackboard.var_231644aacb03b5d6;

  if(isDefined(self findoverridearchetype("\x91\xca\xcc\v\xab\xd8:"))) {
    var_fe3ada30bfd36152 = self findoverridearchetype("\x91\xca\xcc\v\xab\xd8:") + "\xbdOL#\xe3\xc3\xc5r\xc0\xb3x\x81";

    if(archetypehasstate(capname, var_fe3ada30bfd36152)) {
      arrivalstateoverride = var_fe3ada30bfd36152;
    }
  }

  if(isDefined(introstatename) && isDefined(introaliasname)) {
    alias = archetypegetalias(animset, introstatename, introaliasname, 0);
    animation = alias.anims;

    if(isarray(animation)) {
      animation = animation[0];
    }

    originalangles = interaction.angles;
    originalorigin = interaction.origin;
    interaction.origin = getstartorigin(originalorigin, originalangles, animation);
    interaction.angles = getstartangles(originalorigin, originalangles, animation);
  }

  self.interaction_angles = interaction.angles;
  self.interaction_origin = getgroundposition(interaction.origin, 1);
  function_9345d11748ec5c2f(arrivalstateoverride, animset);
  cap::cap_reach_and_arrive(interaction, capname, animset, arrivalstateoverride);
}

function startcap_immediate(statename, params) {
  capinfo = function_4b3a8f32b9155a2c(self);

  if(!isDefined(capinfo)) {
    capinfo = function_a00d7cf424ac2865(self, params[0]);

    if(!isDefined(capinfo)) {
      return;
    }
  }

  capname = capinfo.capname;
  animset = capinfo.animation;
  arrivalstateoverride = capinfo.arrivalstateoverride;
  introstatename = capinfo.initialstate;
  introaliasname = capinfo.initialalias;
  interaction = spawnStruct();
  interaction.angles = self._blackboard.var_5134c0f792da7ea8;
  interaction.origin = self._blackboard.var_231644aacb03b5d6;

  if(isDefined(self findoverridearchetype("\x91\xca\xcc\v\xab\xd8:"))) {
    var_fe3ada30bfd36152 = self findoverridearchetype("\x91\xca\xcc\v\xab\xd8:") + "\xbdOL#\xe3\xc3\xc5r\xc0\xb3x\x81";

    if(archetypehasstate(capname, var_fe3ada30bfd36152)) {
      arrivalstateoverride = var_fe3ada30bfd36152;
    }
  }

  if(isDefined(introstatename) && isDefined(introaliasname)) {
    alias = archetypegetalias(animset, introstatename, introaliasname, 0);
    animation = alias.anims;

    if(isarray(animation)) {
      animation = animation[0];
    }

    originalangles = interaction.angles;
    originalorigin = interaction.origin;
    interaction.origin = getstartorigin(originalorigin, originalangles, animation);
    interaction.angles = getstartangles(originalorigin, originalangles, animation);
  }

  self.interaction_angles = interaction.angles;
  self.interaction_origin = interaction.origin;
  cap::cap_start(capname, animset, 0);
  asm::asm_fireephemeralevent("\x80[\xb3\x9d", "8\xdb\x90");
  self forceteleport(self.interaction_origin, self.interaction_angles, 2048);
}

function withindisttogoal(statename, params) {
  mindist = params[0];

  if(self.pathpending) {
    return false;
  }

  return self pathdisttogoal() <= mindist;
}

function processevent(receiver, info, origin) {
  self notify("m\x15n\x89\xe6\xd8\xa3\xc0\x0f<\x1b\x9d\\:\xd6\xda^5\x81\xcf\r:\xdd\\\b");

  if(info == "4}\xad\xb6z7\xa5") {
    return true;
  } else if(info == "\xea\x90\xc0\x14V\xccyv" || info == "\x1eJ\xb8\x14\xc2" || info == "\xbbB\xef\xf1a\xb1" || info == "9\x7f\x9b\xad") {
    asm_cap::prop_drop();
    self._blackboard.bseqphase = "0\xb0\xc0\xda";
  } else if(info == "9\xa6H\n\b\xcd$") {
    self._blackboard.var_efc6f1808bb99442 = self._blackboard.bseqphase;
    var_e7467a4f2d823b9 = self function_40e8cddf9c6c798d();

    if(asm_cap::cap_hasalias("9\xa6H\n\b\xcd$", "W\r\xb3\xf2|Y\xf1\xe7<\xb4\x038")) {
      self._blackboard.bseqphase = "9\xa6H\n\b\xcd$";
      return true;
    } else if(!var_e7467a4f2d823b9) {
      return true;
    } else {
      asm_cap::prop_drop();
      self._blackboard.bseqphase = "0\xb0\xc0\xda";
      return false;
    }
  } else if(!isDefined(self._blackboard.bseqphase) || isDefined(self._blackboard.bseqphase) && self._blackboard.bseqphase != "8\xdb\x90") {
    self._blackboard.bseqphase = "\xfe\xde\x92Xt";
    return true;
  }

  return false;
}

function empty(params) {}

function function_9e054cf688bde9c2(param) {
  statename = "9\xa6H\n\b\xcd$";
  alias = "W\r\xb3\xf2|Y\xf1\xe7<\xb4\x038";
  animresult = archetypegetrandomalias(self.animsetname, statename, alias, 0);

  if(isDefined(animresult)) {
    return true;
  }

  return false;
}

function inplace(statename, params) {
  self._blackboard.bseqinplace = 1;
  interactionid = self getinteractionid();
  assert(isDefined(interactionid));

  if(istrue(level.var_3d220d0e8490952a)) {
    createinteractionnavobstacle(interactionid);
    return;
  }

  createinteractionnavrepulsor(interactionid);
}

function function_f11b053ae72adf57(interactionid) {
  repulsorname = function_dee7cade3cdd18ee(interactionid);
  destroynavrepulsor(repulsorname);
}

function function_807f4f609fab6eec(interactionid) {
  if(isDefined(self._blackboard.var_af365aa1bc50dffa)) {
    destroynavobstacle(self._blackboard.var_af365aa1bc50dffa);
    self._blackboard.var_af365aa1bc50dffa = undefined;
  }

  bsequsers = function_c922f1d69b3b8e4b(interactionid);

  if(bsequsers.size == 0) {
    return;
  }

  foreach(bsequser in bsequsers) {
    obstacleid = bsequser._blackboard.var_af365aa1bc50dffa;

    if(isDefined(obstacleid)) {
      destroynavobstacle(obstacleid);
      bsequser._blackboard.var_af365aa1bc50dffa = undefined;
    }
  }
}

function private function_dee7cade3cdd18ee(interactionid) {
  return "\xb7\xa6@\xbd(\x03\xd5\xf0VV'\x0e\xc4K\xda\xbfM\xa2\xc3\x92X" + interactionid;
}

function private createinteractionnavrepulsor(interactionid) {
  bsequsers = function_c922f1d69b3b8e4b(interactionid);

  if(bsequsers.size == 0) {
    return;
  }

  var_682c807bf17bfb2b = [];

  foreach(bsequser in bsequsers) {
    if(isDefined(bsequser._blackboard) && bsequser._blackboard.bseqinplace) {
      var_682c807bf17bfb2b[var_682c807bf17bfb2b.size] = bsequser;
    }
  }

  if(var_682c807bf17bfb2b.size <= 1) {
    return;
  }

  circleorigin = (0, 0, 0);
  circleradius = 0;

  if(var_682c807bf17bfb2b.size >= 2) {
    minx = var_682c807bf17bfb2b[0].origin[0];
    maxx = var_682c807bf17bfb2b[0].origin[0];
    miny = var_682c807bf17bfb2b[0].origin[1];
    maxy = var_682c807bf17bfb2b[0].origin[1];

    for(bsequserindex = 1; bsequserindex < var_682c807bf17bfb2b.size; bsequserindex++) {
      bsequserorigin = var_682c807bf17bfb2b[bsequserindex].origin;

      if(bsequserorigin[0] < minx) {
        minx = bsequserorigin[0];
      } else if(bsequserorigin[0] > maxx) {
        maxx = bsequserorigin[0];
      }

      if(bsequserorigin[1] < miny) {
        miny = bsequserorigin[1];
        continue;
      }

      if(bsequserorigin[1] > maxy) {
        maxy = bsequserorigin[1];
      }
    }

    circleorigin = ((maxx + minx) / 2, (maxy + miny) / 2, 0);
    circleradiussq = 0;
    circleoriginz = 0;

    foreach(user in var_682c807bf17bfb2b) {
      circleoriginz += user.origin[2];
      distancefromcentersq = distance2dsquared(circleorigin, user.origin);

      if(distancefromcentersq > circleradiussq) {
        circleradiussq = distancefromcentersq;
      }
    }

    circleoriginz /= var_682c807bf17bfb2b.size;
    circleorigin += (0, 0, circleoriginz);
    circleradius = sqrt(circleradiussq) + 24;
  }

  repulsorname = function_dee7cade3cdd18ee(interactionid);
  destroynavrepulsor(repulsorname);
  createnavrepulsor(repulsorname, -1, circleorigin, circleradius, 0, "\xc0\xc6J");
  thread function_c57b794a49f33cf4();
}

function private createinteractionnavobstacle(interactionid) {
  bsequsers = function_c922f1d69b3b8e4b(interactionid);

  if(bsequsers.size == 0) {
    return;
  }

  var_682c807bf17bfb2b = [];

  foreach(bsequser in bsequsers) {
    if(bsequser._blackboard.bseqinplace) {
      var_682c807bf17bfb2b[var_682c807bf17bfb2b.size] = bsequser;
    }
  }

  if(var_682c807bf17bfb2b.size <= 1) {
    return;
  }

  obstacleorigin = (0, 0, 0);
  obstacleangle = (0, 0, 0);
  var_b25c0c6d4b27a3a6 = 0;
  var_544f4772a1b0635d = 0;
  userhalfsize = 7;

  if(var_682c807bf17bfb2b.size == 2) {
    obstacleorigin = (var_682c807bf17bfb2b[0].origin + var_682c807bf17bfb2b[1].origin) / 2;
    userdiff = var_682c807bf17bfb2b[1].origin - var_682c807bf17bfb2b[0].origin;
    obstacleangle = vectortoangles(userdiff);
    var_544f4772a1b0635d = userhalfsize;
    var_b25c0c6d4b27a3a6 = length(userdiff) / 2 + userhalfsize;
  } else if(var_682c807bf17bfb2b.size > 2) {
    minx = var_682c807bf17bfb2b[0].origin[0];
    maxx = var_682c807bf17bfb2b[0].origin[0];
    miny = var_682c807bf17bfb2b[0].origin[1];
    maxy = var_682c807bf17bfb2b[0].origin[1];
    obstacleoriginz = 0;

    for(bsequserindex = 1; bsequserindex < var_682c807bf17bfb2b.size; bsequserindex++) {
      obstacleoriginz += var_682c807bf17bfb2b[bsequserindex].origin[2];
      bsequserorigin = var_682c807bf17bfb2b[bsequserindex].origin;

      if(bsequserorigin[0] < minx) {
        minx = bsequserorigin[0];
      } else if(bsequserorigin[0] > maxx) {
        maxx = bsequserorigin[0];
      }

      if(bsequserorigin[1] < miny) {
        miny = bsequserorigin[1];
        continue;
      }

      if(bsequserorigin[1] > maxy) {
        maxy = bsequserorigin[1];
      }
    }

    obstacleoriginz /= var_682c807bf17bfb2b.size;
    obstacleorigin = ((maxx + minx) / 2, (maxy + miny) / 2, obstacleoriginz);
    var_b25c0c6d4b27a3a6 = (maxx - minx) / 2 + userhalfsize;
    var_544f4772a1b0635d = (maxy - miny) / 2 + userhalfsize;
  }

  function_807f4f609fab6eec(interactionid);
  bounds = (var_b25c0c6d4b27a3a6, var_544f4772a1b0635d, userhalfsize);
  self._blackboard.var_af365aa1bc50dffa = createnavbadplacebybounds(obstacleorigin, bounds, obstacleangle, 5);
  thread function_c57b794a49f33cf4();
}

function usecustomreact(param) {
  statename = "\xfe\xde\x92Xt";
  alias = "\f";
  animresult = archetypegetrandomalias(self.animsetname, statename, alias, 0);

  if(isDefined(animresult)) {
    return true;
  }

  return false;
}

function function_747f51a6a109d8a2(statename, params) {
  newstate = "\xb3\x16\xea\xf0\xfb\x97z\xd96,\x99\xf5$\xf6\x8aw\xef\xe3\x84Y\f\xdb\x88\xd6\x95/Q?\x8d\x14\x88\xac\xaf2\by";

  if(!isDefined(params[0])) {
    newstate = "\xecX6\xbfH\x8b\xd6<7x\x0e\xe9|f\x1b\x9eexV\xfeb";

    if(!isDefined(self.var_7d8356884d4e9935)) {
      self.var_7d8356884d4e9935 = "i\x14\x92";
    }
  }

  if(self asmhasstate(self.asmname, newstate)) {
    assert(self asmhasstate(self.asmname, newstate));
    self asmsetstate(self.asmname, newstate);
  }
}

function isfrienddown(param) {
  statename = "\xecY\xd3\x8e\x14?\x17\xac\xe4cu";
  alias = "&\x89\xa5\x14\x18I\xbd\xa3\xff\xdfK\x90\x10l\xe1c";

  if(!asm_cap::cap_hasalias(statename, alias)) {
    return false;
  }

  if(!isDefined(self._blackboard.bseqphase)) {
    return false;
  }

  return self._blackboard.bseqphase == "\xecY\xd3\x8e\x14?\x17\xac\xe4cu";
}

function addscriptmodel(statename, param) {
  scriptlinkname = self function_bc7ccb2dc604cfd6();

  if(isDefined(scriptlinkname)) {
    scriptmodel = getEnt(scriptlinkname, #script_linkname);
    id = self getinteractionid();
    scriptmodel function_db177847391047b0(id);
  }
}

function setupscriptmodel(statename, param) {
  self.animname = "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6";
  self useanimtree(level.scr_animtree[self.animname]);
  self.var_46978a402a7c79b7 = 0;
}

function cleanupscriptmodel(statename, param) {
  self stopanimScripted();
  self unlink();

  if(!self.var_46978a402a7c79b7) {
    self physicslaunchserver(self.origin, (0, 0, 0));
  }
}

function markscriptmodelreachedend(statename, param) {
  interactionscriptmodel = self function_55007374a93fa3f7();

  if(isDefined(interactionscriptmodel)) {
    interactionscriptmodel.var_46978a402a7c79b7 = 1;
  }
}

function private function_9345d11748ec5c2f(statename, animset) {
  aliases = archetypegetaliases(animset, statename);

  if(isDefined(aliases)) {
    if(aliases.size == 18) {
      self.var_cfc29353d5327ef7 = 1;
      return;
    }
  }

  self.var_cfc29353d5327ef7 = 0;
}

function private function_4a6d88257711c8c5(phasename) {
  userhalfsize = 5;

  if(phasename == "\x88;\x84s\x1aC\x8f\xd1\xc7\x971" || phasename == "\x94\x17\xae~\x1c\x9f\xe5") {
    if(!isDefined(self._blackboard.var_8ecfd4141169d4fa)) {
      if(istrue(level.var_3d220d0e8490952a)) {
        bounds = (userhalfsize, userhalfsize, userhalfsize);
        self._blackboard.var_8ecfd4141169d4fa = createnavbadplacebybounds(self.origin, bounds, self.angles, 5);
      } else {
        interactionid = self getinteractionid();
        self._blackboard.var_8ecfd4141169d4fa = "\xac\x10p\x0f\x99\xee\x9b\x7fn\xdb\xd0\xa5\x1c0\x14}n" + interactionid;
        createnavrepulsor(self._blackboard.var_8ecfd4141169d4fa, -1, self, undefined, undefined, "O\x15\x1b\xad\x9ff", "\xba\xa5\x1f\xc9m\x80i", "?\xb1\xc0\x9a");
      }

      thread function_c57b794a49f33cf4();
    }

    return;
  }

  if(isDefined(self._blackboard.var_8ecfd4141169d4fa)) {
    if(istrue(level.var_3d220d0e8490952a)) {
      destroynavobstacle(self._blackboard.var_8ecfd4141169d4fa);
    } else {
      destroynavrepulsor(self._blackboard.var_8ecfd4141169d4fa);
    }

    self._blackboard.var_8ecfd4141169d4fa = undefined;
  }
}

function private function_c57b794a49f33cf4() {
  self notify("w\xb3rJ'\xe4\xb0\xf4s $<\xf9\xb3><");
  self endon("w\xb3rJ'\xe4\xb0\xf4s $<\xf9\xb3><");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self waittill("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self._blackboard.var_af365aa1bc50dffa)) {
    if(istrue(level.var_3d220d0e8490952a)) {
      destroynavobstacle(self._blackboard.var_af365aa1bc50dffa);
    } else {
      destroynavrepulsor(self._blackboard.var_af365aa1bc50dffa);
    }
  }

  if(isDefined(self._blackboard.var_8ecfd4141169d4fa)) {
    if(istrue(level.var_3d220d0e8490952a)) {
      destroynavobstacle(self._blackboard.var_8ecfd4141169d4fa);
      return;
    }

    destroynavrepulsor(self._blackboard.var_8ecfd4141169d4fa);
  }
}