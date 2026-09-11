/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\outline.gsc
***********************************************/

function outlineenableforall(var0, var1, var2) {
  var3 = level.players;
  var4 = scripts\mp\outline::outlineprioritygroupmap(var2);
  return scripts\mp\outline::outlineenableinternal(var0, var3, var1, var4, "ALL");
}

function outlineenableforteam(var0, var1, var2, var3, var4) {
  var5 = scripts\mp\utility\teams::getteamdata(var1, "players");

  if(isDefined(var4) && isDefined(var4.team) && var4.team == var1) {
    var5 = scripts\engine\utility::array_remove(var5, var4);
  }

  var6 = scripts\mp\outline::outlineprioritygroupmap(var3);
  return scripts\mp\outline::outlineenableinternal(var0, var5, var2, var6, "TEAM", var1);
}

function outlineenableforsquad(var0, var1, var2, var3, var4) {
  var5 = level.squaddata[var1][var2].players;
  var6 = scripts\mp\outline::outlineprioritygroupmap(var4);
  return scripts\mp\outline::outlineenableinternal(var0, var5, var3, var6, "SQUAD", var1, var2);
}

function outlineenableforplayer(var0, var1, var2, var3) {
  var4 = scripts\mp\outline::outlineprioritygroupmap(var3);

  if(isagent(var1)) {
    return scripts\mp\outline::outlinegenerateuniqueid();
  }

  return scripts\mp\outline::outlineenableinternal(var0, [var1], var2, var4, "ENTITY");
}

function outlinedisable(var0, var1) {
  scripts\mp\outline::outlinedisableinternal(var0, var1);
}

function outlinerefresh(var0) {
  scripts\mp\outline::outlinerefreshinternal(var0);
}

function initoutlineoccluders() {
  level.outlineoccluders = [];
  level.outlineoccludersid = 0;
}

function addoutlineoccluder(var0, var1) {
  var2 = spawnStruct();
  var2.position = var0;
  var2.radius = var1;
  var3 = level.outlineoccludersid;
  level.outlineoccluders[var3] = var2;
  level.outlineoccludersid++;
  return var3;
}

function removeoutlineoccluder(var0) {
  level.outlineoccluders[var0] = undefined;
}

function outlineoccluded(var0, var1) {
  foreach(var3 in level.outlineoccluders) {
    if(!isDefined(var3) || !isDefined(var3.position) || !isDefined(var3.radius)) {
      continue;
    }

    if(scripts\engine\math::segmentvssphere(var0, var1, var3.position, var3.radius)) {
      return true;
    }
  }

  return false;
}

function _hudoutlineviewmodeldisable() {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  self hudoutlineviewmodeldisable();
}

function _hudoutlineviewmodelenable(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(isPlayer(self)) {}

  if(!var1 && !scripts\cp_mp\utility\player_utility::_isalive()) {}

  if(var1 && !scripts\cp_mp\utility\player_utility::_isalive()) {
    thread hudoutlineviewmodelenableonnextspawn(var0);
    return;
  }

  self hudoutlineviewmodelenable(var0);
}

function hudoutlineviewmodelenableonnextspawn(var0) {
  level endon("game_ended");
  self waittill("spawned");

  if(!isDefined(self)) {
    return;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  self hudoutlineviewmodelenable(var0);
}