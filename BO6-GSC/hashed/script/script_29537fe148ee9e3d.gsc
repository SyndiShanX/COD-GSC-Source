/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_29537fe148ee9e3d.gsc
*****************************************************/

#using script_53651341190c5aab;
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
      return &function_da7f705d8024f8b9;
    case #"hash_49987181712dbfd5":
      return &setstationary;
    case #"hash_303d74db152a39b9":
      return &interaction_common::function_9489bf6295c09884;
    case #"hash_2bb757aa70fc12dd":
      return &cleargoal;
  }

  assertmsg("<dev string:x24>" + funcid);
}

function onuserinit(interactionid) {
  if(!isDefined(level.bseqinstancedata)) {
    level.bseqinstancedata = [];
  }

  if(!isDefined(level.bseqinstancedata[interactionid])) {
    level.bseqinstancedata[interactionid] = spawnStruct();
    level.bseqinstancedata[interactionid].var_7d93ff00851ab8ad = 0;
    level.bseqinstancedata[interactionid].var_6954cc6bca15b0c5 = [];
  }

  if(!isDefined(self.bseqinstancedata)) {
    self.bseqinstancedata = spawnStruct();
    self.bseqinstancedata.var_7c320f632aa7c6d7 = 0;
  }

  self.var_a9502368db24e834 = 1;
  self.bdisablereacquire = 1;
  self reacquireclear();
  self setcanusecover(0, "d\x93\xd9\x9e");
  self.bseqinstancedata.speed = self aigetdesiredspeed();
  self aisetdesiredspeed(120);
  self setbtgoalstationary(1);
  self setbtgoalRadius(1, 20);
  level.bseqinstancedata[interactionid].var_6954cc6bca15b0c5[level.bseqinstancedata[interactionid].var_6954cc6bca15b0c5.size] = self.origin;
  self.bseqinstancedata.allowedstances = [];
  self.bseqinstancedata.numallowedstances = 0;

  if(self function_5ed40322c06819ea("\x8b\x90\xb5\xc4W")) {
    self.bseqinstancedata.allowedstances[self.bseqinstancedata.numallowedstances] = "\x8b\x90\xb5\xc4W";
    self.bseqinstancedata.numallowedstances += 1;
  }

  if(self function_5ed40322c06819ea("1x\xc5\xb4\xabx")) {
    self.bseqinstancedata.allowedstances[self.bseqinstancedata.numallowedstances] = "1x\xc5\xb4\xabx";
    self.bseqinstancedata.numallowedstances += 1;
  }

  if(self function_5ed40322c06819ea("GX\xa9]\x82")) {
    self.bseqinstancedata.allowedstances[self.bseqinstancedata.numallowedstances] = "GX\xa9]\x82";
    self.bseqinstancedata.numallowedstances += 1;
  }

  self allowedstances("\x8b\x90\xb5\xc4W");
  self notify("T\x1d\x96\xab\xf7\x80\x11yq\xc9\xd0\xab;\xb4yP");
}

function onuserterminate(interactionid) {
  self clearbtgoal(1);
  self aiclearscriptdesiredspeed();
  self setcanusecover(1, "d\x93\xd9\x9e");
  function_756f062b5dfc6afa(interactionid, "ZL`\xb2a\xe5\xc9\xd1\x1b\xa4\xe7", "\r+x5");
  self stoplookat();
  self.bdisablereacquire = 0;
  self.var_a9502368db24e834 = 0;

  if(self.bseqinstancedata.numallowedstances == 3) {
    self allowedstances(self.bseqinstancedata.allowedstances[0], self.bseqinstancedata.allowedstances[1], self.bseqinstancedata.allowedstances[2]);
  } else if(self.bseqinstancedata.numallowedstances == 2) {
    self allowedstances(self.bseqinstancedata.allowedstances[0], self.bseqinstancedata.allowedstances[1]);
  } else if(self.bseqinstancedata.numallowedstances == 1) {
    self allowedstances(self.bseqinstancedata.allowedstances[0]);
  }

  if(!isalive(self)) {
    function_756f062b5dfc6afa(interactionid, "\x1e\xfd\xd1\xa2\a", 1);
  }

  self.bseqinstancedata = undefined;
  primaryinvestigator = function_5fd1c7552b7a86ad("\xcb83T\x11\x97\xb4\x91cf\x887\xe3t\xb1\x19\xfcS\xa5!", interactionid);

  if(!isDefined(primaryinvestigator) || primaryinvestigator == self) {
    level.bseqinstancedata[interactionid] = undefined;
  }

  self notify("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");
}

function setupmeetuppositions(statename, params) {
  primaryinvestigator = function_5fd1c7552b7a86ad("\xcb83T\x11\x97\xb4\x91cf\x887\xe3t\xb1\x19\xfcS\xa5!");
  primaryinvestigator endon("\x1e\xfd\xd1\xa2\a");
  primaryinvestigator endon("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");
  id = self getinteractionid();
  backupinvestigators = function_bc72299f31e2663("l\x9f\x13z\x80|\xff\x11\x85\xedCmN\xcf\xe0\xb4$h%");
  primaryinvestigatorpos = primaryinvestigator.origin;
  return function_9352268dfbfd73c5(primaryinvestigatorpos);
}

function reachedprimary(statename, params) {
  primaryinvestigator = function_5fd1c7552b7a86ad("\xcb83T\x11\x97\xb4\x91cf\x887\xe3t\xb1\x19\xfcS\xa5!");
  primaryinvestigator endon("\x1e\xfd\xd1\xa2\a");
  primaryinvestigator endon("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");
  id = self getinteractionid();
  backupinvestigators = function_bc72299f31e2663("l\x9f\x13z\x80|\xff\x11\x85\xedCmN\xcf\xe0\xb4$h%");
  level.bseqinstancedata[id].var_7d93ff00851ab8ad++;

  if(level.bseqinstancedata[id].var_7d93ff00851ab8ad >= backupinvestigators.size) {
    function_756f062b5dfc6afa(id, "\xef\x90y\rG\\p\x95\xa8\x89\xd6v\xa4H\x9eH\xf6\xc5\xe8`\xc2", 1);
    level.bseqinstancedata[id].var_7d93ff00851ab8ad = 0;
  }
}

function setwatcherstoidle(statename, params) {
  primaryinvestigator = function_5fd1c7552b7a86ad("\xcb83T\x11\x97\xb4\x91cf\x887\xe3t\xb1\x19\xfcS\xa5!");
  primaryinvestigator endon("\x1e\xfd\xd1\xa2\a");
  primaryinvestigator endon("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");
  id = self getinteractionid();
  self setbtgoalstationary(1);
  lastknownposition = function_9ba3cc4cff45eece(id, "q\xe77\r\x9e\t\xff`K)\xd2\xa9z\x809\xe5\xb4\xb19");
  self setlookat(lastknownposition + (0, 0, 63));
  function_756f062b5dfc6afa(id, "ZL`\xb2a\xe5\xc9\xd1\x1b\xa4\xe7", "\x91\x88\xc2*");
}

function callaceasefire(statename, params) {
  self endon("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 0.2;
  id = self getinteractionid();
  nummembers = function_9ba3cc4cff45eece(id, "\x8ek\xbf\xcbE>`u\xcf/\xbf");

  if(isDefined(level.bseqinstancedata[id]) && isDefined(level.bseqinstancedata) && isDefined(level.bseqinstancedata[id].var_6954cc6bca15b0c5)) {
    level.bseqinstancedata[id].var_6954cc6bca15b0c5[level.bseqinstancedata[id].var_6954cc6bca15b0c5.size] = self.origin;
    lastknownposition = function_9ba3cc4cff45eece(id, "q\xe77\r\x9e\t\xff`K)\xd2\xa9z\x809\xe5\xb4\xb19");
    level.bseqinstancedata[id].var_6954cc6bca15b0c5[level.bseqinstancedata[id].var_6954cc6bca15b0c5.size] = lastknownposition;
    var_89e3f5d459c0bf9a = function_bc72299f31e2663("l\x9f\x13z\x80|\xff\x11\x85\xedCmN\xcf\xe0\xb4$h%");
    numwatchers = function_bc72299f31e2663("\xe5\xdaq|\x89W\xa5\x84\xb1\x1e");
    function_756f062b5dfc6afa(id, "\xe6\xba\xd6\xeb\x89\v\xc6\xdau\xc1\xf5\xb6+\xb6\x89eN\xb9", var_89e3f5d459c0bf9a.size);
    nummembers = var_89e3f5d459c0bf9a.size + numwatchers.size;
    function_756f062b5dfc6afa(id, "\x8ek\xbf\xcbE>`u\xcf/\xbf", nummembers);

    if(nummembers > 1) {
      function_756f062b5dfc6afa(id, "ZL`\xb2a\xe5\xc9\xd1\x1b\xa4\xe7", "\x9d\xd5\x04rJ\x80\x1bq\x15\xbf");
      self.var_4ed0d0d9eac95854 = 1;
      function_99e8e66d1969d7cb(self, self.enemy, "q\xe77\r\x9e\t\xff`K)\xd2\xa9z\x809\xe5\xb4\xb19", "\x9d\xd5\x04rJ\x80\x1bq\x15\xbf", 0);
    }
  }
}

function function_77eff6b1390eb7a1() {
  searchvolume = undefined;

  if(isDefined(self.stealth) && isDefined(level.stealth.combat_volumes) && isDefined(level.stealth) && isDefined(level.stealth.combat_volumes[self.script_stealthgroup])) {
    searchvolume = level.stealth.combat_volumes[self.script_stealthgroup];
  } else {
    searchvolume = self getgoalvolume();
  }

  return searchvolume;
}

function setgoalposlkp(statename, params) {
  id = self getinteractionid();
  lastknownposition = function_9ba3cc4cff45eece(id, "q\xe77\r\x9e\t\xff`K)\xd2\xa9z\x809\xe5\xb4\xb19");
  newgoalpos = undefined;
  cignoreradius = 64;
  self setlookat(lastknownposition + (0, 0, 63));
  function_756f062b5dfc6afa(id, "ZL`\xb2a\xe5\xc9\xd1\x1b\xa4\xe7", "\r+x5");
  searchvolume = function_77eff6b1390eb7a1();

  if(isDefined(searchvolume)) {
    newgoalpos = findclosestlospointwithinvolume(searchvolume, lastknownposition + (0, 0, 63), lastknownposition, level.bseqinstancedata[id].var_6954cc6bca15b0c5, 0);

    if(!isDefined(newgoalpos)) {
      newgoalpos = findclosestnonlospointwithinvolume(searchvolume, lastknownposition + (0, 0, 63), lastknownposition, level.bseqinstancedata[id].var_6954cc6bca15b0c5, cignoreradius);
    }
  }

  if(!isDefined(newgoalpos)) {
    newgoalpos = lastknownposition;
  }

  goalpos = self getclosestreachablepointonnavmesh(newgoalpos);
  level.bseqinstancedata[id].var_6954cc6bca15b0c5[level.bseqinstancedata[id].var_6954cc6bca15b0c5.size] = goalpos;

  if(getdvarint(@ "ai_debuglkpsquad") != 0) {
    sphere(goalpos, 6, (1, 0, 0), 0, 100);
  }

  return goalpos;
}

function reachedlkp(statename, params) {
  id = self getinteractionid();
  function_756f062b5dfc6afa(id, "ZL`\xb2a\xe5\xc9\xd1\x1b\xa4\xe7", "Z\x1f]/\xc9\x10\xaf$}q\x1d");
  self.var_4ed0d0d9eac95854 = 1;
  function_99e8e66d1969d7cb(self, self.enemy, "q\xe77\r\x9e\t\xff`K)\xd2\xa9z\x809\xe5\xb4\xb19", "Z\x1f]/\xc9\x10\xaf$}q\x1d");
}

function setuppositionsnearlkp(statename, params) {
  primaryinvestigator = function_5fd1c7552b7a86ad("\xcb83T\x11\x97\xb4\x91cf\x887\xe3t\xb1\x19\xfcS\xa5!");
  primaryinvestigator endon("\x1e\xfd\xd1\xa2\a");
  primaryinvestigator endon("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");
  id = self getinteractionid();
  lastknownposition = function_9ba3cc4cff45eece(id, "q\xe77\r\x9e\t\xff`K)\xd2\xa9z\x809\xe5\xb4\xb19");
  self setlookat(lastknownposition + (0, 0, 63));
  return function_9352268dfbfd73c5(lastknownposition);
}

function reachedlkprandom(statename, params) {
  primaryinvestigator = function_5fd1c7552b7a86ad("\xcb83T\x11\x97\xb4\x91cf\x887\xe3t\xb1\x19\xfcS\xa5!");
  primaryinvestigator endon("\x1e\xfd\xd1\xa2\a");
  primaryinvestigator endon("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");
  id = self getinteractionid();
  level.bseqinstancedata[id].var_7d93ff00851ab8ad++;
  backupinvestigators = function_bc72299f31e2663("l\x9f\x13z\x80|\xff\x11\x85\xedCmN\xcf\xe0\xb4$h%");

  if(level.bseqinstancedata[id].var_7d93ff00851ab8ad >= backupinvestigators.size) {
    function_756f062b5dfc6afa(id, "\x04\r\xe6\x9dx\xbb\xf6\xd8\xb9\xa3\xedG\x9f#)\xe0\xc3", 1);
    level.bseqinstancedata[id].var_7d93ff00851ab8ad = 0;
  }
}

function waitforlkpanimfinished(statename, params) {
  self endon("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");
  self endon("\x1e\xfd\xd1\xa2\a");
  utility::waittill_any_timeout(5, "\x02\xc4\xa8\xac\xc1\x9cySY\xfay");
  id = self getinteractionid();
  animtype = function_9ba3cc4cff45eece(id, "ZL`\xb2a\xe5\xc9\xd1\x1b\xa4\xe7");
  timeout = 10;

  if(animtype == "\x91\x88\xc2*" || animtype == "\r+x5") {
    timeout = 2;
  }

  utility::waittill_any_timeout(timeout, "\xdbu\xf6,\x9e\xc0W\xa6[\xfa\xfb\xdb\x14\"uv\xd7\xcb\xda\x9b");
}

function setstationary(statename, params) {
  self setbtgoalstationary(1);
  self setbtgoalRadius(1, params[0]);
}

function function_da7f705d8024f8b9(statename) {
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

function function_5fd1c7552b7a86ad(tag, interactionid) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");
  users = function_bc72299f31e2663(tag, interactionid);
  return users[0];
}

function function_bc72299f31e2663(tag, interactionid) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");

  if(!isDefined(interactionid)) {
    interactionid = self getinteractionid();
  }

  users = function_a57c59df65be713(interactionid, tag);
  return users;
}

function function_9352268dfbfd73c5(primarypos) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x14\x18q}y\xfa\x12\xf0\xa0\xde\x8bi\xbe\xf1");
  id = self getinteractionid();
  cignoreradius = 100;
  searchvolume = function_77eff6b1390eb7a1();

  if(isDefined(searchvolume)) {
    newgoalpos = findclosestlospointwithinvolume(searchvolume, primarypos + (0, 0, 63), primarypos, level.bseqinstancedata[id].var_6954cc6bca15b0c5, cignoreradius);

    if(!isDefined(newgoalpos)) {
      newgoalpos = findclosestnonlospointwithinvolume(searchvolume, primarypos + (0, 0, 63), primarypos, level.bseqinstancedata[id].var_6954cc6bca15b0c5, cignoreradius);
    }
  } else {
    carearadius = 1000;
    newgoalpos = findclosestlospointwithinradius(self.origin, carearadius, primarypos + (0, 0, 63), primarypos, level.bseqinstancedata[id].var_6954cc6bca15b0c5, cignoreradius);
  }

  if(!isDefined(newgoalpos)) {
    curpos = self.origin;
    variance = randomintrange(100, 150);
    newgoalpos = primarypos - variance * vectorNormalize(primarypos - curpos);
  }

  goalpos = self getclosestreachablepointonnavmesh(newgoalpos);
  level.bseqinstancedata[id].var_6954cc6bca15b0c5[level.bseqinstancedata[id].var_6954cc6bca15b0c5.size] = goalpos;

  if(getdvarint(@ "ai_debuglkpsquad") != 0) {
    sphere(goalpos, 6, (0, 0, 1), 0, 100);
  }

  return goalpos;
}