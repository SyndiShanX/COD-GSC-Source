/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\cash.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace cash;

function playersetplunderomnvar(value) {
  assert(isDefined(value));

  if(!isDefined(value)) {
    return;
  }

  squadmemberindex = self.sessionuimemberindex;

  if(!isDefined(squadmemberindex) || !isDefined(self.team) || istrue(self.isdisconnecting) || isDefined(level.maxsquadsize) && squadmemberindex >= level.maxsquadsize) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
    self setclientomnvar("ui_cash_squad_index_" + squadmemberindex, value);
    return;
  }

  squadmates = level.teamdata[self.team]["players"];

  if(isDefined(level.squaddata) && isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self.sessionsquadid])) {
    squadmates = level.squaddata[self.team][self.sessionsquadid].players;
  }

  foreach(player in squadmates) {
    if(isDefined(player)) {
      player setclientomnvar("ui_cash_squad_index_" + squadmemberindex, value);
    }
  }
}

function function_52bea99a5c38fbe5(value, var_10aaaaa566515888) {
  if(!isDefined(var_10aaaaa566515888)) {
    var_10aaaaa566515888 = 0;
  }

  assert(isDefined(value));

  if(!isDefined(value)) {
    return;
  }

  if(!var_10aaaaa566515888 && isDefined(self.var_d62416826f295c0b) && self.var_d62416826f295c0b == value) {
    return;
  }

  squadmemberindex = self.sessionuimemberindex;

  if(!isDefined(squadmemberindex) || !isDefined(self.team) || istrue(self.isdisconnecting)) {
    return;
  }

  if(isDefined(level.var_5f92f1f4d7faf5a0) && squadmemberindex >= level.var_5f92f1f4d7faf5a0) {
    return;
  }

  if(!isDefined(level.var_5f92f1f4d7faf5a0) && isDefined(level.maxsquadsize) && squadmemberindex >= level.maxsquadsize) {
    return;
  }

  if(squadmemberindex < 0) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
    self setclientomnvar("ui_zm_essence_squad_index_" + squadmemberindex, value);
  } else {
    squadmates = level.teamdata[self.team]["players"];

    if(isDefined(level.squaddata) && isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self.sessionsquadid])) {
      squadmates = level.squaddata[self.team][self.sessionsquadid].players;
    }

    foreach(player in squadmates) {
      player setclientomnvar("ui_zm_essence_squad_index_" + squadmemberindex, value);
    }
  }

  self.var_d62416826f295c0b = value;
}

function function_6da8b65579348d0b() {
  if(!isDefined(self.plundercount)) {
    self.plundercount = 0;
  }

  if(isDefined(self.team) && !scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
    squadmates = level.teamdata[self.team]["players"];

    if(isDefined(level.squaddata) && isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self.sessionsquadid])) {
      squadmates = level.squaddata[self.team][self.sessionsquadid].players;
    }

    foreach(player in squadmates) {
      squadmemberindex = player.sessionuimemberindex;

      if(self != player && isDefined(squadmemberindex)) {
        value = player getclientomnvar("ui_cash_squad_index_" + squadmemberindex);
        self setclientomnvar("ui_cash_squad_index_" + squadmemberindex, value);
        var_6214ba0b9e2c422e = player getclientomnvar("ui_zm_essence_squad_index_" + squadmemberindex);
        self setclientomnvar("ui_zm_essence_squad_index_" + squadmemberindex, var_6214ba0b9e2c422e);
      }
    }
  }
}