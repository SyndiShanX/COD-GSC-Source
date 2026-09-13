/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_538f66fce659a889.gsc
***********************************************/

_id_FE852F92145C24A6() {
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("loot", "tryAssignTask", ::_id_1A86AFC387820604);
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("loot", "onPlayerSelectTask", ::_id_B3AE9B96B9B77128);
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("loot", "onTaskEnd", ::_id_AFAACBFFDDFF4911);
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("loot", "tryBindObjective", ::_id_F06F2A906262B65C);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerKioskUsed", ::_id_E5E74D645A0D055E);
}

_id_1A86AFC387820604(_id_17953215DD7C5F9B) {
  thread _id_78D7A14C7DFB37C4(_id_17953215DD7C5F9B);
}

_id_78D7A14C7DFB37C4(_id_17953215DD7C5F9B) {
  level endon("game_ended");
  _id_17953215DD7C5F9B endon("task_end");

  for(;;) {
    flag = _id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D + "_" + _id_17953215DD7C5F9B.team;
    level waittill(flag, player, value, instance);

    if(_id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D == "open_loot_box")
      _id_DC3E112CADB47514(instance);

    if(isDefined(player))
      player _id_5BC86A57086A4774::_id_89B8BCE3BAA45EDC(_id_17953215DD7C5F9B, value);
  }
}

_id_AFAACBFFDDFF4911(_id_17953215DD7C5F9B) {
  foreach(player in scripts\mp\utility\teams::getteamdata(_id_17953215DD7C5F9B.team, "players"))
  player _id_B3AE9B96B9B77128(_id_17953215DD7C5F9B, 0);
}

_id_B3AE9B96B9B77128(_id_17953215DD7C5F9B, selected) {
  if(_id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D == "buy_station_cash_spent")
    self setclientomnvar("ui_champion_br_task_buy_station_hint", selected);
}

_id_8E36F666C0242FE6(_id_17953215DD7C5F9B, _id_15B89FF206500554) {
  return !istrue(_id_15B89FF206500554.disabled);
}

_id_44B2E353A03C56A5(_id_17953215DD7C5F9B, _id_36B81911E31BB387) {
  partname = _id_36B81911E31BB387 _meth_EC5F4851431F3382();
  state = _id_36B81911E31BB387 getscriptablepartstate(partname, 1);
  return isDefined(state) && state == "closed_usable";
}

_id_F06F2A906262B65C(_id_17953215DD7C5F9B) {
  switch (_id_17953215DD7C5F9B.info._id_1C9CB43BCF3EB16D) {
    case "buy_station_cash_spent":
      _id_5BC86A57086A4774::_id_2E55101FFD0D483C(_id_17953215DD7C5F9B, level.br_armory_kiosk.scriptables, ::_id_8E36F666C0242FE6);
      break;
    case "open_loot_box":
      _id_5BC86A57086A4774::_id_2E55101FFD0D483C(_id_17953215DD7C5F9B, _id_3525B317DC93F4E9(), ::_id_44B2E353A03C56A5);
      break;
  }
}

_id_E5E74D645A0D055E(_id_15B89FF206500554) {
  if(isDefined(self._id_B8ABADD2C4D56FD8) && isDefined(self._id_B8ABADD2C4D56FD8.item.type) && self._id_B8ABADD2C4D56FD8.item.type == "br_plunder_box")
    _id_5BC86A57086A4774::_id_AFE6658CFFE7D1A8();
}

_id_DC3E112CADB47514(_id_36B81911E31BB387) {
  if(!isDefined(_id_36B81911E31BB387)) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player._id_B8ABADD2C4D56FD8) && player._id_B8ABADD2C4D56FD8.item == _id_36B81911E31BB387)
      player _id_5BC86A57086A4774::_id_8FD21242A694AA72();
  }
}

_id_3525B317DC93F4E9() {
  _id_510C132B62D77D0A = ["br_loot_cache", "br_loot_cache_lege", "br_reusable_loot_cache"];
  return getlootscriptablearrayinradius(_id_510C132B62D77D0A, undefined, self.origin, 10000);
}