/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\sentientpoolmanager.gsc
***********************************************/

init() {
  createthreatbiasgroup("_encstr_962E10A2166CE896C6C21BF56A1D0B1DB48D");
  createthreatbiasgroup("_encstr_879610D1FF4A45C8EBD61876F5DF0873327F");
  createthreatbiasgroup("_encstr_849C0E9130898B0EE380AF2867D8882A");
  createthreatbiasgroup("_encstr_8E830EA9A77303302C91E4B8C30173CC");
  createthreatbiasgroup("_encstr_BE230E64859CE87B09557DB81153BB97");
  createthreatbiasgroup("_encstr_B1B01227D9B5C81E73BB39A13207C6C00E3CEBEF");
  createthreatbiasgroup("_encstr_81860F1741A58ADBBB43D3B36C79AF3083");
  createthreatbiasgroup("_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858");
  setignoremegroup("_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858", "_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858");
  setignoremegroup("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", "_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858");
  setignoremegroup("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", "_encstr_81860F1741A58ADBBB43D3B36C79AF3083");
  setignoremegroup("_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858", "_encstr_81860F1741A58ADBBB43D3B36C79AF3083");
  level.sentientpools = [];
  level.sentientpools[level.sentientpools.size] = "_encstr_962E10A2166CE896C6C21BF56A1D0B1DB48D";
  level.sentientpools[level.sentientpools.size] = "_encstr_879610D1FF4A45C8EBD61876F5DF0873327F";
  level.sentientpools[level.sentientpools.size] = "_encstr_849C0E9130898B0EE380AF2867D8882A";
  level.sentientpools[level.sentientpools.size] = "_encstr_8E830EA9A77303302C91E4B8C30173CC";
  level.sentientpools[level.sentientpools.size] = "_encstr_BE230E64859CE87B09557DB81153BB97";
  level.sentientpools[level.sentientpools.size] = "_encstr_B1B01227D9B5C81E73BB39A13207C6C00E3CEBEF";
  level.sentientpools[level.sentientpools.size] = "_encstr_81860F1741A58ADBBB43D3B36C79AF3083";
  level.sentientpools[level.sentientpools.size] = "_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858";
  level.activesentients = [];

  for(var_0 = 0; var_0 < level.sentientpools.size; var_0++)
    level.activesentients[level.sentientpools[var_0]] = [];
}

registersentient(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = -1;

  for(var_7 = 0; var_7 < level.sentientpools.size; var_7++) {
    if(level.sentientpools[var_7] == var_0) {
      var_6 = var_7;
      break;
    }
  }

  if(var_6 == -1) {
    return;
  }
  if(isDefined(self.sentientpool)) {
    return;
  }
  var_8 = getsentientlimits();
  var_9 = nvidiaanselisenabled();

  if(var_8["_encstr_8261067B1D34AC27"] + var_8["_encstr_B8150B455BEB221879B97BC1F3"] >= var_9["_encstr_8261067B1D34AC27"]) {
    var_10 = level removebestsentient(var_6);

    if(!var_10)
      return;
  }

  self.sentientpool = var_0;
  self.sentientaddedtime = gettime();
  self.sentientpoolindex = self getentitynumber();
  var_11 = undefined;

  if(isstring(var_1))
    var_11 = var_1;
  else if(isPlayer(var_1))
    var_11 = var_1.team;

  var_12 = undefined;

  if(isDefined(var_11) && !isagent(self))
    var_12 = self makeentitysentient(var_11, undefined, var_4, var_5);

  if(istrue(var_12)) {
    self setthreatbiasgroup(var_0);

    if(istrue(var_2))
      self makeentitynomeleetarget();

    level.activesentients[var_0][self.sentientpoolindex] = self;
    thread monitorsentient(var_3);
  }
}

monitorsentient(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.sentientpool;
  var_2 = self.sentientpoolindex;

  if(isDefined(var_0))
    scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_A67B103BB1A99FBB2B8F4B2595F004FF400B", var_0);
  else
    scripts\engine\utility::waittill_either("_encstr_AD75063D571AE108", "_encstr_A67B103BB1A99FBB2B8F4B2595F004FF400B");

  unregistersentient(var_1, var_2);
}

removebestsentient(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 <= var_0; var_2++) {
    var_1 = getbestsentientfrompool(level.sentientpools[var_2]);

    if(isDefined(var_1)) {
      break;
    }
  }

  if(!isDefined(var_1))
    return 0;

  var_1 unregistersentient(var_1.sentientpool, var_1.sentientpoolindex);
  return 1;
}

getbestsentientfrompool(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.activesentients[var_0]) {
    if(!isDefined(var_2) || var_4.sentientaddedtime < var_2) {
      var_2 = var_4.sentientaddedtime;
      var_1 = var_4;
    }
  }

  return var_1;
}

unregistersentient(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  level.activesentients[var_0][var_1] = undefined;

  if(isDefined(self)) {
    self.sentientpool = undefined;
    self.sentientpoolindex = undefined;

    if(!isagent(self))
      self freeentitysentient();
  }
}