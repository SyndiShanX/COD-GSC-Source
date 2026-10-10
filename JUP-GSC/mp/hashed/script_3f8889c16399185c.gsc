/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3f8889c16399185c.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_a131188218d8b5c3;

function function_766b80da1f882fc3() {
  assert(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.ranktable), "<dev string:x1c>");
  ranktablebundle = getscriptbundle(level.gamemodebundle.ranktable);
  assert(isDefined(ranktablebundle), "<dev string:x48>");
  return ranktablebundle;
}

function getrankbundle(rankbundlename) {
  rankbundle = getscriptbundle(rankbundlename);
  assert(isDefined(rankbundle), "<dev string:x62>");
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
  rankxp = function_f3bb4f4911a1beb2("stats", "getPersStat", "rankxp");
  rankid = function_f3bb4f4911a1beb2("stats", "getPersStat", "rank");

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

  lowerbound = 0;
  upperbound = rankid;

  while(lowerbound <= upperbound) {
    rankid = int(floor((lowerbound + upperbound) / 2));
    minxp = getrankinfominxp(rankid);
    maxxp = getrankinfomaxxp(rankid);

    if(xpval >= minxp && xpval < maxxp) {
      return rankid;
    }

    if(xpval >= maxxp) {
      lowerbound = rankid + 1;
      continue;
    }

    if(xpval < minxp) {
      upperbound = rankid - 1;
      continue;
    }

    assertmsg("<dev string:x7b>");
    return 0;
  }

  return rankid;
}

function function_b1e11b17e1fbded3() {
  assert(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.weaponranktable), "<dev string:xe1>");
  var_c6e3b34739982959 = getscriptbundle(level.gamemodebundle.weaponranktable);
  assert(isDefined(var_c6e3b34739982959), "<dev string:x113>");
  return var_c6e3b34739982959;
}

function function_91ce54da71d1008d(rankbundlename) {
  weaponrankbundle = getscriptbundle(rankbundlename);
  assert(isDefined(weaponrankbundle), "<dev string:x137>");
  return weaponrankbundle;
}

function function_6bb67ea6b4f510ed(rankid) {
  ranktablebundle = function_b1e11b17e1fbded3();
  assert(length(ranktablebundle.weaponranklist) > rankid);
  return getrankbundle(ranktablebundle.weaponranklist[rankid].rank);
}