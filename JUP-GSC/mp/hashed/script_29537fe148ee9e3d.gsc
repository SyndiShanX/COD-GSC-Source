/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_29537fe148ee9e3d.gsc
*************************************************/

#using script_53651341190c5aab;
#using scripts\common\ai_lookat;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_6ecb0b3bf9e2cf33;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_dab0d83df51da4d":
      return &function_3dbd361f74b442f9;
    case #"hash_722d767fd6d40f56":
      return &function_a157fbbc31d9eb1a;
    case #"hash_8a6929c703898e78":
      return &function_22ad2c8bca9871a4;
    case #"hash_3830c02ed29b9bd":
      return &reachedprimary;
    case #"hash_2a3b81fd59207935":
      return &function_273633da55df7339;
    case #"hash_1d9348daf6d1a5c7":
      return &function_c441fa0827d790a3;
    case #"hash_b3cada4cba95eb5d":
      return &function_9aa657f85926df09;
    case #"hash_4f54865eea297354":
      return &function_9c6badb8075c4880;
    case #"hash_561e0f0540b7f727":
      return &function_f7911b207b7ea23b;
    case #"hash_dca2cd774e93c43b":
      return &function_f6f3ce8b49c1c3e7;
    case #"hash_cb9a60b9c8cfca45":
      return &function_1eb86a6134b967f9;
    case #"hash_cc3a03d50cb74f10":
      return &function_59f0c716b5f99a1c;
    case #"hash_49987181712dbfd5":
      return &setstationary;
    case #"hash_303d74db152a39b9":
      return &namespace_f901a4f9d899be59::function_606c28b248baddfd;
    case #"hash_2bb757aa70fc12dd":
      return &cleargoal;
  }

  assertmsg("<dev string:x1c>" + funcid);
}

function function_3dbd361f74b442f9(interactionid) {
  if(!isDefined(level.var_80275ca89b572683)) {
    level.var_80275ca89b572683 = [];
  }

  if(!isDefined(level.var_80275ca89b572683[interactionid])) {
    level.var_80275ca89b572683[interactionid] = spawnStruct();
    level.var_80275ca89b572683[interactionid].var_e6aac1358274bc10 = 0;
    level.var_80275ca89b572683[interactionid].var_4e79a41164de0c24 = [];
  }

  if(!isDefined(self.var_80275ca89b572683)) {
    self.var_80275ca89b572683 = spawnStruct();
    self.var_80275ca89b572683.var_35c7cd77665dd90a = 0;
  }

  self.var_34127a7fbdb497c5 = 1;
  self.var_ecb9f6a505b89af6 = 1;
  self reacquireclear();
  self function_9f82c74eb1b7caf9(0, "bseq");
  self.var_80275ca89b572683.speed = self aigetdesiredspeed();
  self aisetdesiredspeed(120);
  self function_e64ea2b4e79c4b74(1);
  self setbtgoalRadius(1, 20);
  level.var_80275ca89b572683[interactionid].var_4e79a41164de0c24[level.var_80275ca89b572683[interactionid].var_4e79a41164de0c24.size] = self.origin;
  self.var_80275ca89b572683.allowedstances = [];
  self.var_80275ca89b572683.numallowedstances = 0;

  if(self function_e862ed56b787162b("stand")) {
    self.var_80275ca89b572683.allowedstances[self.var_80275ca89b572683.numallowedstances] = "stand";
    self.var_80275ca89b572683.numallowedstances += 1;
  }

  if(self function_e862ed56b787162b("crouch")) {
    self.var_80275ca89b572683.allowedstances[self.var_80275ca89b572683.numallowedstances] = "crouch";
    self.var_80275ca89b572683.numallowedstances += 1;
  }

  if(self function_e862ed56b787162b("prone")) {
    self.var_80275ca89b572683.allowedstances[self.var_80275ca89b572683.numallowedstances] = "prone";
    self.var_80275ca89b572683.numallowedstances += 1;
  }

  self allowedstances("stand");
  self notify("startlkpbehavior");
}

function function_a157fbbc31d9eb1a(interactionid) {
  self clearbtgoal(1);
  self aiclearscriptdesiredspeed();
  self function_9f82c74eb1b7caf9(1, "bseq");
  function_ae368fad1a1dc337(interactionid, "lkpanimtype", "none");
  self stoplookat();
  self.var_ecb9f6a505b89af6 = 0;
  self.var_34127a7fbdb497c5 = 0;

  if(self.var_80275ca89b572683.numallowedstances == 3) {
    self allowedstances(self.var_80275ca89b572683.allowedstances[0], self.var_80275ca89b572683.allowedstances[1], self.var_80275ca89b572683.allowedstances[2]);
  } else if(self.var_80275ca89b572683.numallowedstances == 2) {
    self allowedstances(self.var_80275ca89b572683.allowedstances[0], self.var_80275ca89b572683.allowedstances[1]);
  } else if(self.var_80275ca89b572683.numallowedstances == 1) {
    self allowedstances(self.var_80275ca89b572683.allowedstances[0]);
  }

  if(!isalive(self)) {
    function_ae368fad1a1dc337(interactionid, "death", 1);
  }

  self.var_80275ca89b572683 = undefined;
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator", interactionid);

  if(!isDefined(primaryinvestigator) || primaryinvestigator == self) {
    level.var_80275ca89b572683[interactionid] = undefined;
  }

  self notify("endlkpbehavior");
}

function function_22ad2c8bca9871a4(statename, params) {
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator");
  primaryinvestigator endon("death");
  primaryinvestigator endon("endlkpbehavior");
  id = self function_92435c7a6ae85c3c();
  var_70637b1fcca27427 = function_cbd389222bce05ae("backup_investigator");
  var_412ab049e38bf9fa = primaryinvestigator.origin;
  return function_a6f064acc25e8db8(var_412ab049e38bf9fa);
}

function reachedprimary(statename, params) {
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator");
  primaryinvestigator endon("death");
  primaryinvestigator endon("endlkpbehavior");
  id = self function_92435c7a6ae85c3c();
  var_70637b1fcca27427 = function_cbd389222bce05ae("backup_investigator");
  level.var_80275ca89b572683[id].var_e6aac1358274bc10++;

  if(level.var_80275ca89b572683[id].var_e6aac1358274bc10 >= var_70637b1fcca27427.size) {
    function_ae368fad1a1dc337(id, "move_complete_initial", 1);
    level.var_80275ca89b572683[id].var_e6aac1358274bc10 = 0;
  }
}

function function_273633da55df7339(statename, params) {
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator");
  primaryinvestigator endon("death");
  primaryinvestigator endon("endlkpbehavior");
  id = self function_92435c7a6ae85c3c();
  self function_e64ea2b4e79c4b74(1);
  lastknownposition = function_60d6151af81a343(id, "last_known_position");
  self setlookat(lastknownposition + (0, 0, 63));
  function_ae368fad1a1dc337(id, "lkpanimtype", "idle");
}

function function_c441fa0827d790a3(statename, params) {
  self endon("endlkpbehavior");
  self endon("death");
  wait 0.2;
  id = self function_92435c7a6ae85c3c();
  nummembers = function_60d6151af81a343(id, "num_members");

  if(isDefined(level.var_80275ca89b572683) && isDefined(level.var_80275ca89b572683[id]) && isDefined(level.var_80275ca89b572683[id].var_4e79a41164de0c24)) {
    level.var_80275ca89b572683[id].var_4e79a41164de0c24[level.var_80275ca89b572683[id].var_4e79a41164de0c24.size] = self.origin;
    lastknownposition = function_60d6151af81a343(id, "last_known_position");
    level.var_80275ca89b572683[id].var_4e79a41164de0c24[level.var_80275ca89b572683[id].var_4e79a41164de0c24.size] = lastknownposition;
    var_181b810d3de25443 = function_cbd389222bce05ae("backup_investigator");
    numwatchers = function_cbd389222bce05ae("RestOfThem");
    function_ae368fad1a1dc337(id, "num_backup_members", var_181b810d3de25443.size);
    nummembers = var_181b810d3de25443.size + numwatchers.size;
    function_ae368fad1a1dc337(id, "num_members", nummembers);

    if(nummembers > 1) {
      function_ae368fad1a1dc337(id, "lkpanimtype", "cease_fire");
      self.var_63d7585bee031305 = 1;
      function_216c67ab6749137a(self, self.enemy, "last_known_position", "cease_fire", 0);
    }
  }
}

function function_5c56ba321fd2aec8() {
  searchvolume = undefined;

  if(isDefined(level.stealth) && isDefined(level.stealth.combat_volumes) && isDefined(self.stealth) && isDefined(level.stealth.combat_volumes[self.script_stealthgroup])) {
    searchvolume = level.stealth.combat_volumes[self.script_stealthgroup];
  } else {
    searchvolume = self getgoalvolume();
  }

  return searchvolume;
}

function function_9aa657f85926df09(statename, params) {
  id = self function_92435c7a6ae85c3c();
  lastknownposition = function_60d6151af81a343(id, "last_known_position");
  newgoalpos = undefined;
  var_6df5cd3ffe06e6ce = 64;
  self setlookat(lastknownposition + (0, 0, 63));
  function_ae368fad1a1dc337(id, "lkpanimtype", "none");
  searchvolume = function_5c56ba321fd2aec8();

  if(isDefined(searchvolume)) {
    newgoalpos = findclosestlospointwithinvolume(searchvolume, lastknownposition + (0, 0, 63), lastknownposition, level.var_80275ca89b572683[id].var_4e79a41164de0c24, 0);

    if(!isDefined(newgoalpos)) {
      newgoalpos = findclosestnonlospointwithinvolume(searchvolume, lastknownposition + (0, 0, 63), lastknownposition, level.var_80275ca89b572683[id].var_4e79a41164de0c24, var_6df5cd3ffe06e6ce);
    }
  }

  if(!isDefined(newgoalpos)) {
    newgoalpos = lastknownposition;
  }

  goalpos = self getclosestreachablepointonnavmesh(newgoalpos);
  level.var_80275ca89b572683[id].var_4e79a41164de0c24[level.var_80275ca89b572683[id].var_4e79a41164de0c24.size] = goalpos;

  if(getdvarint(@ "hash_9961f6e93a09b113") != 0) {
    sphere(goalpos, 6, (1, 0, 0), 0, 100);
  }

  return goalpos;
}

function function_9c6badb8075c4880(statename, params) {
  id = self function_92435c7a6ae85c3c();
  function_ae368fad1a1dc337(id, "lkpanimtype", "lost_target");
  self.var_63d7585bee031305 = 1;
  function_216c67ab6749137a(self, self.enemy, "last_known_position", "lost_target");
}

function function_f7911b207b7ea23b(statename, params) {
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator");
  primaryinvestigator endon("death");
  primaryinvestigator endon("endlkpbehavior");
  id = self function_92435c7a6ae85c3c();
  lastknownposition = function_60d6151af81a343(id, "last_known_position");
  self setlookat(lastknownposition + (0, 0, 63));
  return function_a6f064acc25e8db8(lastknownposition);
}

function function_f6f3ce8b49c1c3e7(statename, params) {
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator");
  primaryinvestigator endon("death");
  primaryinvestigator endon("endlkpbehavior");
  id = self function_92435c7a6ae85c3c();
  level.var_80275ca89b572683[id].var_e6aac1358274bc10++;
  var_70637b1fcca27427 = function_cbd389222bce05ae("backup_investigator");

  if(level.var_80275ca89b572683[id].var_e6aac1358274bc10 >= var_70637b1fcca27427.size) {
    function_ae368fad1a1dc337(id, "move_complete_lkp", 1);
    level.var_80275ca89b572683[id].var_e6aac1358274bc10 = 0;
  }
}

function function_1eb86a6134b967f9(statename, params) {
  self endon("endlkpbehavior");
  self endon("death");
  waittill_any_timeout_1(5, "exposed_lkp");
  id = self function_92435c7a6ae85c3c();
  animtype = function_60d6151af81a343(id, "lkpanimtype");
  timeout = 10;

  if(animtype == "idle" || animtype == "none") {
    timeout = 2;
  }

  waittill_any_timeout_1(timeout, "exposed_lkp_finished");
}

function setstationary(statename, params) {
  self function_e64ea2b4e79c4b74(1);
  self setbtgoalRadius(1, params[0]);
}

function function_59f0c716b5f99a1c(statename) {
  goalradius = 16;
  pathlength = self pathdisttogoal();

  if(pathlength <= goalradius) {
    return true;
  }

  return false;
}

function cleargoal(statename) {
  self clearbtgoal(1);
}

function function_cbe869548ea6baac(tag, interactionid) {
  self endon("death");
  self endon("endlkpbehavior");
  users = function_cbd389222bce05ae(tag, interactionid);
  return users[0];
}

function function_cbd389222bce05ae(tag, interactionid) {
  self endon("death");
  self endon("endlkpbehavior");

  if(!isDefined(interactionid)) {
    interactionid = self function_92435c7a6ae85c3c();
  }

  users = function_fce201c1f66b31b6(interactionid, tag);
  return users;
}

function function_a6f064acc25e8db8(primarypos) {
  self endon("death");
  self endon("endlkpbehavior");
  id = self function_92435c7a6ae85c3c();
  var_6df5cd3ffe06e6ce = 100;
  searchvolume = function_5c56ba321fd2aec8();

  if(isDefined(searchvolume)) {
    newgoalpos = findclosestlospointwithinvolume(searchvolume, primarypos + (0, 0, 63), primarypos, level.var_80275ca89b572683[id].var_4e79a41164de0c24, var_6df5cd3ffe06e6ce);

    if(!isDefined(newgoalpos)) {
      newgoalpos = findclosestnonlospointwithinvolume(searchvolume, primarypos + (0, 0, 63), primarypos, level.var_80275ca89b572683[id].var_4e79a41164de0c24, var_6df5cd3ffe06e6ce);
    }
  } else {
    var_2e61d47fcb18d101 = 1000;
    newgoalpos = findclosestlospointwithinradius(self.origin, var_2e61d47fcb18d101, primarypos + (0, 0, 63), primarypos, level.var_80275ca89b572683[id].var_4e79a41164de0c24, var_6df5cd3ffe06e6ce);
  }

  if(!isDefined(newgoalpos)) {
    curpos = self.origin;
    variance = randomintrange(100, 150);
    newgoalpos = primarypos - variance * vectorNormalize(primarypos - curpos);
  }

  goalpos = self getclosestreachablepointonnavmesh(newgoalpos);
  level.var_80275ca89b572683[id].var_4e79a41164de0c24[level.var_80275ca89b572683[id].var_4e79a41164de0c24.size] = goalpos;

  if(getdvarint(@ "hash_9961f6e93a09b113") != 0) {
    sphere(goalpos, 6, (0, 0, 1), 0, 100);
  }

  return goalpos;
}