/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3f8889c16399185c.gsc
*************************************************/

#using scripts\engine\utility;
#namespace progression_utility;

function getranktablebundle() {
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

function getrankinfostruct(rankid) {
  ranktablebundle = getranktablebundle();
  assert(length(ranktablebundle.ranklist) > rankid);
  return getrankbundle(ranktablebundle.ranklist[rankid].rank);
}

function function_cd47cbfaa2de3623(rankid) {
  return getrankinfostruct(rankid).ingamerankname;
}

function getrankinfoicon(rankid, prestigeid) {
  ranktablebundle = getranktablebundle();

  if(isDefined(ranktablebundle.prestigeiconlist) && length(ranktablebundle.prestigeiconlist) > prestigeid) {
    return ranktablebundle.prestigeiconlist[prestigeid];
  }

  return getrankinfostruct(rankid).icon;
}

function getrankinfolevel(rankid) {
  return getrankinfostruct(rankid).ingamerank;
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

function getrankinfofullname(rankid) {
  return getrankinfostruct(rankid).ingamerankname;
}

function getrank() {
  rankxp = callsharedfunc("stats", "getPersStat", "rankxp");
  rankid = callsharedfunc("stats", "getPersStat", "rank");

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

function getweaponranktablebundle() {
  assert(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.weaponranktable), "<dev string:xe1>");
  weaponranktablebundle = getscriptbundle(level.gamemodebundle.weaponranktable);
  assert(isDefined(weaponranktablebundle), "<dev string:x113>");
  return weaponranktablebundle;
}

function function_91ce54da71d1008d(rankbundlename) {
  weaponrankbundle = getscriptbundle(rankbundlename);
  assert(isDefined(weaponrankbundle), "<dev string:x137>");
  return weaponrankbundle;
}

function getweaponranktableentry(rankid) {
  ranktablebundle = getweaponranktablebundle();
  assert(length(ranktablebundle.weaponranklist) > rankid);
  return getrankbundle(ranktablebundle.weaponranklist[rankid].rank);
}