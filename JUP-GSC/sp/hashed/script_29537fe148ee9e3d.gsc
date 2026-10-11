/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_29537fe148ee9e3d.gsc
*************************************************/

#using script_53651341190c5aab;
#using scripts\common\ai_lookat;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace ai_lkp;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_dab0d83df51da4d":
      return &onuserinit;
    case #"hash_722d767fd6d40f56":
      return &onuserterminate;
    case #"hash_8a6929c703898e78":
      return &setupmeetuppositions;
    case #"hash_3830c02ed29b9bd":
      return &reachedprimary;
    case #"hash_2a3b81fd59207935":
      return &setwatcherstoidle;
    case #"hash_1d9348daf6d1a5c7":
      return &callaceasefire;
    case #"hash_b3cada4cba95eb5d":
      return &setgoalposlkp;
    case #"hash_4f54865eea297354":
      return &reachedlkp;
    case #"hash_561e0f0540b7f727":
      return &setuppositionsnearlkp;
    case #"hash_dca2cd774e93c43b":
      return &reachedlkprandom;
    case #"hash_cb9a60b9c8cfca45":
      return &waitforlkpanimfinished;
    case #"hash_cc3a03d50cb74f10":
      return &function_59f0c716b5f99a1c;
    case #"hash_49987181712dbfd5":
      return &setstationary;
    case #"hash_303d74db152a39b9":
      return &namespace_f901a4f9d899be59::function_606c28b248baddfd;
    case #"hash_2bb757aa70fc12dd":
      return &cleargoal;
  }

  assertmsg("Missing function pointer for " + funcid);
}

function onuserinit(interactionid) {
  if(!isDefined(level.bseqinstancedata)) {
    level.bseqinstancedata = [];
  }

  if(!isDefined(level.bseqinstancedata[interactionid])) {
    level.bseqinstancedata[interactionid] = spawnStruct();
    level.bseqinstancedata[interactionid].var_e6aac1358274bc10 = 0;
    level.bseqinstancedata[interactionid].var_4e79a41164de0c24 = [];
  }

  if(!isDefined(self.bseqinstancedata)) {
    self.bseqinstancedata = spawnStruct();
    self.bseqinstancedata.var_35c7cd77665dd90a = 0;
  }

  self.var_34127a7fbdb497c5 = 1;
  self.bdisablereacquire = 1;
  self reacquireclear();
  self setcanusecover(0, "bseq");
  self.bseqinstancedata.speed = self aigetdesiredspeed();
  self aisetdesiredspeed(120);
  self setbtgoalstationary(1);
  self setbtgoalRadius(1, 20);
  level.bseqinstancedata[interactionid].var_4e79a41164de0c24[level.bseqinstancedata[interactionid].var_4e79a41164de0c24.size] = self.origin;
  self.bseqinstancedata.allowedstances = [];
  self.bseqinstancedata.numallowedstances = 0;

  if(self function_e862ed56b787162b("stand")) {
    self.bseqinstancedata.allowedstances[self.bseqinstancedata.numallowedstances] = "stand";
    self.bseqinstancedata.numallowedstances += 1;
  }

  if(self function_e862ed56b787162b("crouch")) {
    self.bseqinstancedata.allowedstances[self.bseqinstancedata.numallowedstances] = "crouch";
    self.bseqinstancedata.numallowedstances += 1;
  }

  if(self function_e862ed56b787162b("prone")) {
    self.bseqinstancedata.allowedstances[self.bseqinstancedata.numallowedstances] = "prone";
    self.bseqinstancedata.numallowedstances += 1;
  }

  self allowedstances("stand");
  self notify("startlkpbehavior");
}

function onuserterminate(interactionid) {
  self clearbtgoal(1);
  self aiclearscriptdesiredspeed();
  self setcanusecover(1, "bseq");
  function_ae368fad1a1dc337(interactionid, "lkpanimtype", "none");
  self stoplookat();
  self.bdisablereacquire = 0;
  self.var_34127a7fbdb497c5 = 0;

  if(self.bseqinstancedata.numallowedstances == 3) {
    self allowedstances(self.bseqinstancedata.allowedstances[0], self.bseqinstancedata.allowedstances[1], self.bseqinstancedata.allowedstances[2]);
  } else if(self.bseqinstancedata.numallowedstances == 2) {
    self allowedstances(self.bseqinstancedata.allowedstances[0], self.bseqinstancedata.allowedstances[1]);
  } else if(self.bseqinstancedata.numallowedstances == 1) {
    self allowedstances(self.bseqinstancedata.allowedstances[0]);
  }

  if(!isalive(self)) {
    function_ae368fad1a1dc337(interactionid, "death", 1);
  }

  self.bseqinstancedata = undefined;
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator", interactionid);

  if(!isDefined(primaryinvestigator) || primaryinvestigator == self) {
    level.bseqinstancedata[interactionid] = undefined;
  }

  self notify("endlkpbehavior");
}

function setupmeetuppositions(statename, params) {
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator");
  primaryinvestigator endon("death");
  primaryinvestigator endon("endlkpbehavior");
  id = self getinteractionid();
  backupinvestigators = function_cbd389222bce05ae("backup_investigator");
  primaryinvestigatorpos = primaryinvestigator.origin;
  return function_a6f064acc25e8db8(primaryinvestigatorpos);
}

function reachedprimary(statename, params) {
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator");
  primaryinvestigator endon("death");
  primaryinvestigator endon("endlkpbehavior");
  id = self getinteractionid();
  backupinvestigators = function_cbd389222bce05ae("backup_investigator");
  level.bseqinstancedata[id].var_e6aac1358274bc10++;

  if(level.bseqinstancedata[id].var_e6aac1358274bc10 >= backupinvestigators.size) {
    function_ae368fad1a1dc337(id, "move_complete_initial", 1);
    level.bseqinstancedata[id].var_e6aac1358274bc10 = 0;
  }
}

function setwatcherstoidle(statename, params) {
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator");
  primaryinvestigator endon("death");
  primaryinvestigator endon("endlkpbehavior");
  id = self getinteractionid();
  self setbtgoalstationary(1);
  lastknownposition = function_60d6151af81a343(id, "last_known_position");
  self setlookat(lastknownposition + (0, 0, 63));
  function_ae368fad1a1dc337(id, "lkpanimtype", "idle");
}

function callaceasefire(statename, params) {
  self endon("endlkpbehavior");
  self endon("death");
  wait 0.2;
  id = self getinteractionid();
  nummembers = function_60d6151af81a343(id, "num_members");

  if(isDefined(level.bseqinstancedata) && isDefined(level.bseqinstancedata[id]) && isDefined(level.bseqinstancedata[id].var_4e79a41164de0c24)) {
    level.bseqinstancedata[id].var_4e79a41164de0c24[level.bseqinstancedata[id].var_4e79a41164de0c24.size] = self.origin;
    lastknownposition = function_60d6151af81a343(id, "last_known_position");
    level.bseqinstancedata[id].var_4e79a41164de0c24[level.bseqinstancedata[id].var_4e79a41164de0c24.size] = lastknownposition;
    var_181b810d3de25443 = function_cbd389222bce05ae("backup_investigator");
    numwatchers = function_cbd389222bce05ae("RestOfThem");
    function_ae368fad1a1dc337(id, "num_backup_members", var_181b810d3de25443.size);
    nummembers = var_181b810d3de25443.size + numwatchers.size;
    function_ae368fad1a1dc337(id, "num_members", nummembers);

    if(nummembers > 1) {
      function_ae368fad1a1dc337(id, "lkpanimtype", "cease_fire");
      self.var_63d7585bee031305 = 1;
      addbattlechatternotify(self, self.enemy, "last_known_position", "cease_fire", 0);
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

function setgoalposlkp(statename, params) {
  id = self getinteractionid();
  lastknownposition = function_60d6151af81a343(id, "last_known_position");
  newgoalpos = undefined;
  cignoreradius = 64;
  self setlookat(lastknownposition + (0, 0, 63));
  function_ae368fad1a1dc337(id, "lkpanimtype", "none");
  searchvolume = function_5c56ba321fd2aec8();

  if(isDefined(searchvolume)) {
    newgoalpos = findclosestlospointwithinvolume(searchvolume, lastknownposition + (0, 0, 63), lastknownposition, level.bseqinstancedata[id].var_4e79a41164de0c24, 0);

    if(!isDefined(newgoalpos)) {
      newgoalpos = findclosestnonlospointwithinvolume(searchvolume, lastknownposition + (0, 0, 63), lastknownposition, level.bseqinstancedata[id].var_4e79a41164de0c24, cignoreradius);
    }
  }

  if(!isDefined(newgoalpos)) {
    newgoalpos = lastknownposition;
  }

  goalpos = self getclosestreachablepointonnavmesh(newgoalpos);
  level.bseqinstancedata[id].var_4e79a41164de0c24[level.bseqinstancedata[id].var_4e79a41164de0c24.size] = goalpos;

  if(getdvarint(@ "hash_9961f6e93a09b113") != 0) {
    sphere(goalpos, 6, (1, 0, 0), 0, 100);
  }

  return goalpos;
}

function reachedlkp(statename, params) {
  id = self getinteractionid();
  function_ae368fad1a1dc337(id, "lkpanimtype", "lost_target");
  self.var_63d7585bee031305 = 1;
  addbattlechatternotify(self, self.enemy, "last_known_position", "lost_target");
}

function setuppositionsnearlkp(statename, params) {
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator");
  primaryinvestigator endon("death");
  primaryinvestigator endon("endlkpbehavior");
  id = self getinteractionid();
  lastknownposition = function_60d6151af81a343(id, "last_known_position");
  self setlookat(lastknownposition + (0, 0, 63));
  return function_a6f064acc25e8db8(lastknownposition);
}

function reachedlkprandom(statename, params) {
  primaryinvestigator = function_cbe869548ea6baac("primary_investigator");
  primaryinvestigator endon("death");
  primaryinvestigator endon("endlkpbehavior");
  id = self getinteractionid();
  level.bseqinstancedata[id].var_e6aac1358274bc10++;
  backupinvestigators = function_cbd389222bce05ae("backup_investigator");

  if(level.bseqinstancedata[id].var_e6aac1358274bc10 >= backupinvestigators.size) {
    function_ae368fad1a1dc337(id, "move_complete_lkp", 1);
    level.bseqinstancedata[id].var_e6aac1358274bc10 = 0;
  }
}

function waitforlkpanimfinished(statename, params) {
  self endon("endlkpbehavior");
  self endon("death");
  waittill_any_timeout_1(5, "exposed_lkp");
  id = self getinteractionid();
  animtype = function_60d6151af81a343(id, "lkpanimtype");
  timeout = 10;

  if(animtype == "idle" || animtype == "none") {
    timeout = 2;
  }

  waittill_any_timeout_1(timeout, "exposed_lkp_finished");
}

function setstationary(statename, params) {
  self setbtgoalstationary(1);
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
    interactionid = self getinteractionid();
  }

  users = getbsequserswithtag(interactionid, tag);
  return users;
}

function function_a6f064acc25e8db8(primarypos) {
  self endon("death");
  self endon("endlkpbehavior");
  id = self getinteractionid();
  cignoreradius = 100;
  searchvolume = function_5c56ba321fd2aec8();

  if(isDefined(searchvolume)) {
    newgoalpos = findclosestlospointwithinvolume(searchvolume, primarypos + (0, 0, 63), primarypos, level.bseqinstancedata[id].var_4e79a41164de0c24, cignoreradius);

    if(!isDefined(newgoalpos)) {
      newgoalpos = findclosestnonlospointwithinvolume(searchvolume, primarypos + (0, 0, 63), primarypos, level.bseqinstancedata[id].var_4e79a41164de0c24, cignoreradius);
    }
  } else {
    carearadius = 1000;
    newgoalpos = findclosestlospointwithinradius(self.origin, carearadius, primarypos + (0, 0, 63), primarypos, level.bseqinstancedata[id].var_4e79a41164de0c24, cignoreradius);
  }

  if(!isDefined(newgoalpos)) {
    curpos = self.origin;
    variance = randomintrange(100, 150);
    newgoalpos = primarypos - variance * vectorNormalize(primarypos - curpos);
  }

  goalpos = self getclosestreachablepointonnavmesh(newgoalpos);
  level.bseqinstancedata[id].var_4e79a41164de0c24[level.bseqinstancedata[id].var_4e79a41164de0c24.size] = goalpos;

  if(getdvarint(@ "hash_9961f6e93a09b113") != 0) {
    sphere(goalpos, 6, (0, 0, 1), 0, 100);
  }

  return goalpos;
}