/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3f8889c16399185c.gsc
*************************************************/

#using scripts\engine\utility;
#namespace progression_utility;

function getranktablebundle() {
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

function getweaponranktablebundle() {
  assert(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.weaponranktable), "weaponranktable in gamemodebundle is required.");
  weaponranktablebundle = getscriptbundle(level.gamemodebundle.weaponranktable);
  assert(isDefined(weaponranktablebundle), "weapon ranktable asset undefined");
  return weaponranktablebundle;
}

function function_91ce54da71d1008d(rankbundlename) {
  weaponrankbundle = getscriptbundle(rankbundlename);
  assert(isDefined(weaponrankbundle), "weapon rank bundle undefined");
  return weaponrankbundle;
}

function getweaponranktableentry(rankid) {
  ranktablebundle = getweaponranktablebundle();
  assert(length(ranktablebundle.weaponranklist) > rankid);
  return getrankbundle(ranktablebundle.weaponranklist[rankid].rank);
}