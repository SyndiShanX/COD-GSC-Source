/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_ai_encounters_util.gsc
**************************************************/

get_ai_team() {
  if(isDefined(self.encounter.info.team))
    return self.encounter.info.team;

  var_0 = [];

  foreach(var_2 in level.teamnamelist)
  var_0[var_2] = 0;

  foreach(var_5 in level.players) {
    var_2 = var_5.pers["_encstr_8AEF05472BC2D6"];

    if(!isDefined(var_2) || var_2 == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    var_0[var_2]++;
  }

  foreach(var_2, var_8 in var_0) {
    if(var_8 == 0) {
      self.encounter.info.team = var_2;
      break;
    }
  }

  if(!isDefined(self.encounter.info.team))
    self.encounter.info.team = scripts\engine\utility::random(level.teamnamelist);

  return self.encounter.info.team;
}

get_targets() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_1 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_3 in var_1)
    var_0[var_0.size] = var_3;

    var_5 = getEntArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_7 in var_5)
    var_0[var_0.size] = var_7;

    var_9 = getnodearray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_11 in var_9)
    var_0[var_0.size] = var_11;
  }

  return var_0;
}

getvartype(var_0) {
  if(!isDefined(var_0))
    return "_encstr_8C500ABA9B23CACC2D37AC8C";
  else if(isbuiltinfunction(var_0))
    return "_encstr_B2BB0998FB35773B1FAFF0";
  else if(isbuiltinmethod(var_0))
    return "_encstr_92F81110052A9DE403D006B265381E784BE812";
  else if(isanimation(var_0))
    return "_encstr_BA8A0F26EAB48DE85A7310B659A31ADE8C";
  else if(dospawnaitype(var_0))
    return "_encstr_8F4C0AD063B178138B9C0880";
  else if(isarray(var_0))
    return "_encstr_91B606B0E49C0B5E";
  else if(isstruct(var_0))
    var_1 = "_encstr_91D8076ED193D5B11D";
  else if(isvector(var_0))
    var_1 = "_encstr_8DCA076DE5A6D8C0BB";
  else if(isent(var_0))
    var_1 = "_encstr_850E077B0BF30318B9";
  else if(isnode(var_0))
    var_1 = "_encstr_B2BA05D85AB77B";
  else if(isint(var_0))
    var_1 = "_encstr_921904C3DEF8";
  else if(isfloat(var_0))
    var_1 = "_encstr_8AA9066663F62C3A";
  else if(isstring(var_0))
    var_1 = "_encstr_A1D80717112333A5D4";
  else if(isistring(var_0))
    var_1 = "_encstr_A73408D8D8411BF8BE77";
  else
    var_1 = "_encstr_8DC7086BEEA408C0AF8A";

  return var_1;
}

vartostring(var_0) {
  var_1 = getvartype(var_0);

  switch (var_1) {
    case "_encstr_91B606B0E49C0B5E":
      return _arraytostring(var_0);
    case "_encstr_8DCA076DE5A6D8C0BB":
      return "_encstr_924C021E" + var_0[0] + "_encstr_964C0249" + var_0[1] + "_encstr_964C0249" + var_0[2] + "_encstr_824C0266";
    case "_encstr_8AA9066663F62C3A":
    case "_encstr_921904C3DEF8":
      return "_encstr_B40101" + var_0;
    case "_encstr_A1D80717112333A5D4":
      return var_0;
    case "_encstr_850E077B0BF30318B9":
      return "_encstr_A307039A57" + var_0 getentitynumber();
    default:
      return "_encstr_994C02EF" + var_1 + "_encstr_834C028F";
  }
}

_arraytostring(var_0) {
  var_1 = "_encstr_B40703E8E9";
  var_2 = 1;

  foreach(var_5, var_4 in var_0) {
    if(!var_2)
      var_1 = var_1 + "_encstr_964C0249";
    else
      var_2 = 0;

    var_1 = var_1 + vartostring(var_4);
  }

  var_1 = var_1 + "_encstr_B60703AE59";
  return var_1;
}

encounterremovenavobstacle(var_0) {
  destroynavobstacle(var_0);
  self notify("_encstr_A9AF16E6C2D9AF7B4CB9A316D8D895D746B237A327DB2FF5" + var_0);
}

encounterremovenavobstacleonencounterend(var_0) {
  self endon("_encstr_A9AF16E6C2D9AF7B4CB9A316D8D895D746B237A327DB2FF5" + var_0);
  self waittill("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  encounterremovenavobstacle(var_0);
}

encounterremovenavobstacledelay(var_0, var_1) {
  self endon("_encstr_A9AF16E6C2D9AF7B4CB9A316D8D895D746B237A327DB2FF5" + var_0);
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  wait(var_1);
  encounterremovenavobstacle(var_0);
}

encounterdeleteentonend(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  var_0 delete();
}

disablescriptableplayeruseall(var_0) {
  foreach(var_2 in level.players)
  var_0 disablescriptableplayeruse(var_2);
}

enablescriptableplayeruseall(var_0) {
  foreach(var_2 in level.players)
  var_0 enablescriptableplayeruse(var_2);
}

waittill_dead(var_0, var_1, var_2) {
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("_encstr_A5E711A9E363F5403481D348351DA0206A7F51");
    var_10 thread waittill_dead_timeout(var_2);
  }

  var_10.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_10.count)
    var_10.count = var_1;

  scripts\engine\utility::array_thread(var_0, ::waittill_dead_thread, var_10);

  while(var_10.count > 0)
    var_10 waittill("_encstr_A1B817836F8093101018B8EFA7CDBB9BFEFC8FD352C2548D9A");
}

waittill_dead_or_dying(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isalive(var_5) && !var_5.ignoreforfixednodesafecheck)
      var_3[var_3.size] = var_5;
  }

  var_0 = var_3;
  var_7 = spawnStruct();

  if(isDefined(var_2)) {
    var_7 endon("_encstr_A5E711A9E363F5403481D348351DA0206A7F51");
    var_7 thread waittill_dead_timeout(var_2);
  }

  var_7.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_7.count)
    var_7.count = var_1;

  scripts\engine\utility::array_thread(var_0, ::waittill_dead_or_dying_thread, var_7);

  while(var_7.count > 0)
    var_7 waittill("_encstr_ABBC20BB85968E475AC68DD723560B32FA76AEE5F5912B858CFAED397D8CBC969BEC");
}

waittill_notetrack_or_damage(var_0) {
  self endon("_encstr_B2BE0788BAF573592F");
  self endon("_encstr_AD75063D571AE108");
  self waittillmatch("_encstr_B26B0C62E310EFF82760E3BB9B80", var_0);
}

get_living_ai(var_0, var_1) {
  var_2 = get_living_ai_array(var_0, var_1);

  if(var_2.size > 1)
    return undefined;

  return var_2[0];
}

get_living_ai_array(var_0, var_1) {
  var_2 = getaispeciesarray("_encstr_AF1904A7F929", "_encstr_AF1904A7F929");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isalive(var_5)) {
      continue;
    }
    switch (var_1) {
      case "_encstr_B2CE0BA1D0FB19FDC54613D9BF":
        if(isDefined(var_5.targetname) && var_5.targetname == var_0)
          var_3[var_3.size] = var_5;

        break;
      case "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B":
        if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0)
          var_3[var_3.size] = var_5;

        break;
      case "_encstr_9BD50919A530253B3720C2":
        if(isDefined(var_5.animname) && var_5.animname == var_0)
          var_3[var_3.size] = var_5;

        break;
    }
  }

  return var_3;
}

waittill_dead_thread(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  var_0.count--;
  var_0 notify("_encstr_A1B817836F8093101018B8EFA7CDBB9BFEFC8FD352C2548D9A");
}

waittill_dead_or_dying_thread(var_0) {
  scripts\engine\utility::waittill_either("_encstr_AD75063D571AE108", "_encstr_93530B91C713410FAFEAC86852");
  var_0.count--;
  var_0 notify("_encstr_ABBC20BB85968E475AC68DD723560B32FA76AEE5F5912B858CFAED397D8CBC969BEC");
}

waittill_dead_timeout(var_0) {
  wait(var_0);
  self notify("_encstr_A5E711A9E363F5403481D348351DA0206A7F51");
}