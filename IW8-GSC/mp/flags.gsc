/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\flags.gsc
***********************************************/

initgameflags() {
  if(!isDefined(game["_encstr_B2A9066FF1CB8F67"]))
    game["_encstr_B2A9066FF1CB8F67"] = [];
}

gameflaginit(var_0, var_1) {
  game["_encstr_B2A9066FF1CB8F67"][var_0] = var_1;
}

playerzombiethermalcleanup(var_0) {
  return isDefined(game["_encstr_B2A9066FF1CB8F67"][var_0]);
}

gameflag(var_0) {
  return game["_encstr_B2A9066FF1CB8F67"][var_0];
}

gameflagset(var_0) {
  game["_encstr_B2A9066FF1CB8F67"][var_0] = 1;
  level notify(var_0);
}

gameflagclear(var_0) {
  game["_encstr_B2A9066FF1CB8F67"][var_0] = 0;
}

gameflagwait(var_0) {
  while(!gameflag(var_0))
    level waittill(var_0);
}

initlevelflags() {
  if(!isDefined(level.levelflags))
    level.levelflags = [];
}

levelflaginit(var_0, var_1) {
  level.levelflags[var_0] = var_1;
}

levelflag(var_0) {
  return level.levelflags[var_0];
}

levelflagset(var_0) {
  level.levelflags[var_0] = 1;
  level notify(var_0);
}

levelflagclear(var_0) {
  level.levelflags[var_0] = 0;
  level notify(var_0);
}

levelflagwait(var_0) {
  while(!levelflag(var_0))
    level waittill(var_0);
}

levelflagwaitopen(var_0) {
  while(levelflag(var_0))
    level waittill(var_0);
}