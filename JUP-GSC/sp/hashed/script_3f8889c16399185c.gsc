/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3f8889c16399185c.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_a131188218d8b5c3;

function function_766b80da1f882fc3() {
  assert(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.ranktable), "ranktable in gamemodebundle is required.");
  ranktablebundle = getscriptbundle(level.gamemodebundle.ranktable);
  assert(isDefined(ranktablebundle), "mp ranktable undefined");
  return ranktablebundle;
}

function getrankbundle(rankbundlename) {
  rankbundle = getscriptbundle(rankbundlename);
  assert(isDefined(rankbundle), "rank bundle undefined");
  return rankbundle;
}

function function_f44d7988af879414(rankid) {
  ranktablebundle = function_766b80da1f882fc3();
  assert(length(ranktablebundle.ranklist) > rankid);
  return getrankbundle(ranktablebundle.ranklist[rankid].rank);
}

function function_cd47cbfaa2de3623(rankid) {
  return function_f44d7988af879414(rankid).var_7118a72fe332609d;
}

function getrankinfoicon(rankid, prestigeid) {
  ranktablebundle = function_766b80da1f882fc3();

  if(isDefined(ranktablebundle.var_cdd7517c09cf8381) && length(ranktablebundle.var_cdd7517c09cf8381) > prestigeid) {
    return ranktablebundle.var_cdd7517c09cf8381[prestigeid];
  }

  return function_f44d7988af879414(rankid).icon;
}

function getrankinfolevel(rankid) {
  return function_f44d7988af879414(rankid).ingamerank;
}

function getrankinfominxp(rankid) {
  return int(level.ranktable[rankid][0]);
}

function getrankinfoxpamt(rankid) {
  return int(level.ranktable[rankid][1]);
}

function getrankinfomaxxp(rankid) {
  return int(level.ranktable[rankid][2]);
}

function function_997e0cd870844c1b(rankid) {
  return function_f44d7988af879414(rankid).var_7118a72fe332609d;
}

function getrank() {
  rankxp = self.pers["rankxp"];
  rankid = self.pers["rank"];

  if(rankxp < getrankinfominxp(rankid) + getrankinfoxpamt(rankid)) {
    return rankid;
  }

  return getrankforxp(rankxp);
}

function getrankforxp(xpval) {
  rankid = level.maxrank;

  if(xpval >= getrankinfominxp(rankid)) {
    return rankid;
  } else {
    rankid--;
  }

  while(rankid > 0) {
    if(xpval >= getrankinfominxp(rankid) && xpval < getrankinfominxp(rankid) + getrankinfoxpamt(rankid)) {
      return rankid;
    }

    rankid--;
  }

  return rankid;
}

function function_b1e11b17e1fbded3() {
  assert(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.weaponranktable), "weaponranktable in gamemodebundle is required.");
  var_c6e3b34739982959 = getscriptbundle(level.gamemodebundle.weaponranktable);
  assert(isDefined(var_c6e3b34739982959), "weapon ranktable asset undefined");
  return var_c6e3b34739982959;
}

function function_91ce54da71d1008d(rankbundlename) {
  weaponrankbundle = getscriptbundle(rankbundlename);
  assert(isDefined(weaponrankbundle), "weapon rank bundle undefined");
  return weaponrankbundle;
}

function function_6bb67ea6b4f510ed(rankid) {
  ranktablebundle = function_b1e11b17e1fbded3();
  assert(length(ranktablebundle.weaponranklist) > rankid);
  return getrankbundle(ranktablebundle.weaponranklist[rankid].rank);
}