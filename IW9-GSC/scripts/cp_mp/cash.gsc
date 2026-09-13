/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\cash.gsc
***********************************************/

playersetplunderomnvar(value) {
  if(!isDefined(value)) {
    return;
  }
  squadmemberindex = self._id_3F78C6A0862F9E25;

  if(!isDefined(squadmemberindex) || !isDefined(self.team) || istrue(self.isdisconnecting)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A())
    self setclientomnvar("ui_cash_squad_index_" + squadmemberindex, value);
  else {
    _id_607DA387F3617ED1 = level.teamdata[self.team]["players"];

    if(isDefined(level.squaddata) && isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self._id_0FF97225579DE16A]))
      _id_607DA387F3617ED1 = level.squaddata[self.team][self._id_0FF97225579DE16A].players;

    foreach(player in _id_607DA387F3617ED1) {
      if(isDefined(player))
        player setclientomnvar("ui_cash_squad_index_" + squadmemberindex, value);
    }
  }
}

_id_6DA8B65579348D0B() {
  if(!isDefined(self.plundercount))
    self.plundercount = 0;
}