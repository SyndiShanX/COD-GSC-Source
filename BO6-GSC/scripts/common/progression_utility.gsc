/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\progression_utility.gsc
**************************************************/

#using scripts\engine\utility;
#namespace progression_utility;

function getranktablebundle() {
  assert(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.ranktable), "<dev string:x24>");
  ranktablebundle = getscriptbundle(level.gamemodebundle.ranktable);
  assert(isDefined(ranktablebundle), "<dev string:x50>");
  return ranktablebundle;
}

function getrankbundle(rankbundlename) {
  rankbundle = getscriptbundle(rankbundlename);
  assert(isDefined(rankbundle), "<dev string:x6a>");
  return rankbundle;
}

function getrankinfostruct(rankid) {
  ranktablebundle = getranktablebundle();
  assert(length(ranktablebundle.ranklist) > rankid);
  return getrankbundle(ranktablebundle.ranklist[rankid].rank);
}

function function_5e8badb5210a53f2(rankid) {
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
  rankxp = utility::callsharedfunc(#"stats", #"getpersstat", "\x86\x9ax\xfa\xf7=");
  rankid = utility::callsharedfunc(#"stats", #"getpersstat", "}6\x94\xad");

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
  assert(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.weaponranktable), "<dev string:x83>");
  weaponranktablebundle = getscriptbundle(level.gamemodebundle.weaponranktable);
  assert(isDefined(weaponranktablebundle), "<dev string:xb5>");
  return weaponranktablebundle;
}

function function_39449bb019d8b640(rankbundlename) {
  weaponrankbundle = getscriptbundle(rankbundlename);
  assert(isDefined(weaponrankbundle), "<dev string:xd9>");
  return weaponrankbundle;
}

function getweaponranktableentry(rankid) {
  ranktablebundle = getweaponranktablebundle();
  assert(length(ranktablebundle.weaponranklist) > rankid);
  return getrankbundle(ranktablebundle.weaponranklist[rankid].rank);
}