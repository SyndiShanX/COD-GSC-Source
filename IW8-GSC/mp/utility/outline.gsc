/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\outline.gsc
***********************************************/

outlineenableforall(var_0, var_1, var_2) {
  var_3 = level.players;
  var_4 = scripts\mp\outline::outlineprioritygroupmap(var_2);
  return scripts\mp\outline::outlineenableinternal(var_0, var_3, var_1, var_4, "_encstr_AF190427B939");
}

outlineenableforteam(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

  if(isDefined(var_4) && isDefined(var_4.team) && var_4.team == var_1)
    var_5 = scripts\engine\utility::array_remove(var_5, var_4);

  var_6 = scripts\mp\outline::outlineprioritygroupmap(var_3);
  return scripts\mp\outline::outlineenableinternal(var_0, var_5, var_2, var_6, "_encstr_8AEF05452A82D4", var_1);
}

outlineenableforsquad(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.squaddata[var_1][var_2].players;
  var_6 = scripts\mp\outline::outlineprioritygroupmap(var_4);
  return scripts\mp\outline::outlineenableinternal(var_0, var_5, var_3, var_6, "_encstr_8C950636CAC91B1D", var_1, var_2);
}

outlineenableforplayer(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\outline::outlineprioritygroupmap(var_3);

  if(isagent(var_1))
    return scripts\mp\outline::outlinegenerateuniqueid();

  return scripts\mp\outline::outlineenableinternal(var_0, [var_1], var_2, var_4, "_encstr_850E073B8BF1131999");
}

outlinedisable(var_0, var_1) {
  scripts\mp\outline::outlinedisableinternal(var_0, var_1);
}

outlinerefresh(var_0) {
  scripts\mp\outline::outlinerefreshinternal(var_0);
}

initoutlineoccluders() {
  level.outlineoccluders = [];
  level.outlineoccludersid = 0;
}

addoutlineoccluder(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.position = var_0;
  var_2.radius = var_1;
  var_3 = level.outlineoccludersid;
  level.outlineoccluders[var_3] = var_2;
  level.outlineoccludersid++;
  return var_3;
}

removeoutlineoccluder(var_0) {
  level.outlineoccluders[var_0] = undefined;
}

outlineoccluded(var_0, var_1) {
  foreach(var_3 in level.outlineoccluders) {
    if(!isDefined(var_3) || !isDefined(var_3.position) || !isDefined(var_3.radius)) {
      continue;
    }
    if(scripts\engine\math::segmentvssphere(var_0, var_1, var_3.position, var_3.radius))
      return 1;
  }

  return 0;
}

_hudoutlineviewmodeldisable() {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  self hudoutlineviewmodeldisable();
}

_hudoutlineviewmodelenable(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isPlayer(self)) {}

  if(!var_1 && !scripts\cp_mp\utility\player_utility::_isalive()) {}

  if(var_1 && !scripts\cp_mp\utility\player_utility::_isalive()) {
    thread hudoutlineviewmodelenableonnextspawn(var_0);
    return;
  }

  self hudoutlineviewmodelenable(var_0);
}

hudoutlineviewmodelenableonnextspawn(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_BA350853C128FB939DB9");

  if(!isDefined(self)) {
    return;
  }
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  self hudoutlineviewmodelenable(var_0);
}