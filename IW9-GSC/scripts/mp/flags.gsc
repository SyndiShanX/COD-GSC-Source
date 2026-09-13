/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\flags.gsc
***********************************************/

initgameflags() {
  if(!isDefined(game["flags"]))
    game["flags"] = [];
}

gameflaginit(flagname, _id_E60552DD6ABCC4AA) {
  game["flags"][flagname] = _id_E60552DD6ABCC4AA;
}

gameflagexists(flagname) {
  return isDefined(game["flags"]) && isDefined(game["flags"][flagname]);
}

gameflag(flagname) {
  return game["flags"][flagname];
}

gameflagset(flagname) {
  game["flags"][flagname] = 1;
  level notify(flagname);
}

gameflagclear(flagname) {
  game["flags"][flagname] = 0;
}

gameflagwait(flagname) {
  while(!gameflag(flagname))
    level waittill(flagname);
}

_id_1240434F4201AC9D(flagname) {
  while(!gameflagexists(flagname))
    waitframe();

  gameflagwait(flagname);
}

initlevelflags() {
  if(!isDefined(level.levelflags))
    level.levelflags = [];
}

levelflaginit(flagname, _id_E60552DD6ABCC4AA) {
  level.levelflags[flagname] = _id_E60552DD6ABCC4AA;
}

levelflag(flagname) {
  return level.levelflags[flagname];
}

levelflagset(flagname) {
  level.levelflags[flagname] = 1;
  level notify(flagname);
}

levelflagclear(flagname) {
  level.levelflags[flagname] = 0;
  level notify(flagname);
}

levelflagwait(flagname) {
  while(!levelflag(flagname))
    level waittill(flagname);
}

levelflagwaitopen(flagname) {
  while(levelflag(flagname))
    level waittill(flagname);
}