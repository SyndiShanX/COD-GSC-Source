/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3b9af437ca74921e.gsc
***********************************************/

_id_FE852F92145C24A6() {
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("movement", "tryAssignTask", ::_id_851152959E7C1C87);
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("movement", "tryBindObjective", ::_id_F06F2A906262B65C);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onInfilJumpCompleted", ::_id_3002136254D4D287);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerEnterVehicle", ::_id_1C43A59AA76726F3);
}

_id_851152959E7C1C87(_id_17953215DD7C5F9B) {
  thread _id_4DA8FCEF740E954F(_id_17953215DD7C5F9B);
}

_id_4DA8FCEF740E954F(_id_17953215DD7C5F9B) {
  if(!isDefined(_id_17953215DD7C5F9B.info.targetnum)) {
    return;
  }
  level endon("game_ended");
  _id_17953215DD7C5F9B endon("task_end");

  while(_id_17953215DD7C5F9B.currentvalue < _id_17953215DD7C5F9B.info.targetnum) {
    foreach(player in level.teamdata[_id_17953215DD7C5F9B.team]["players"]) {
      isvalid = player _id_017AAE3FD2C16468(_id_17953215DD7C5F9B);

      if(isvalid) {
        _id_FF65E066242C67B1 = _id_FB5759BF8FC4E733(_id_17953215DD7C5F9B, player);
        _id_5BC86A57086A4774::_id_89B8BCE3BAA45EDC(_id_17953215DD7C5F9B, _id_FF65E066242C67B1);
        continue;
      }

      player._id_7F4E080484F571F6 = undefined;
    }

    wait 0.1;
  }
}

_id_FB5759BF8FC4E733(_id_17953215DD7C5F9B, player) {
  if(isDefined(player._id_7F4E080484F571F6)) {
    _id_3572671D48FB48AB = distance(player.origin, player._id_7F4E080484F571F6);
    player._id_7F4E080484F571F6 = player.origin;
    return _id_3572671D48FB48AB * 0.0254;
  } else {
    player._id_7F4E080484F571F6 = player.origin;
    return 0;
  }
}

_id_017AAE3FD2C16468(_id_17953215DD7C5F9B) {
  if(!istrue(self._id_DA8DE99C15DD631E) && getdvarint("dvar_25AD2925D6075C8F", 0) != 2)
    return 0;

  switch (_id_17953215DD7C5F9B.info.ref) {
    case "travelfoot":
      return self isonground();
    case "travelvehicle":
      return self _meth_793F941D7DFF15ED();
    case "parachute":
      return self isparachuting();
    default:
  }

  return 0;
}

_id_3002136254D4D287() {
  self._id_DA8DE99C15DD631E = 1;
}

_id_1C43A59AA76726F3(vehicle, target) {
  if(!isDefined(vehicle)) {
    return;
  }
  if(isDefined(target._id_B8ABADD2C4D56FD8) && target._id_B8ABADD2C4D56FD8.item scripts\common\vehicle::isvehicle())
    target _id_5BC86A57086A4774::_id_AFE6658CFFE7D1A8();

  foreach(player in level.players) {
    _id_600955D039B2FD47 = isDefined(player._id_B8ABADD2C4D56FD8) && isDefined(player._id_B8ABADD2C4D56FD8.item) && player._id_B8ABADD2C4D56FD8.item == vehicle;
    _id_618ADC4F1F1C1872 = target.team != player.team;

    if(_id_600955D039B2FD47 && _id_618ADC4F1F1C1872)
      player _id_5BC86A57086A4774::_id_8FD21242A694AA72();
  }
}

_id_59C1DBDC2AD03AD6(_id_17953215DD7C5F9B, vehicle) {
  if(isDefined(vehicle.team) && vehicle.team != _id_17953215DD7C5F9B.team && vehicle.team != "neutral")
    return 0;

  if(isDefined(vehicle.ownerteam) && vehicle.ownerteam != _id_17953215DD7C5F9B.team && vehicle.ownerteam != "neutral")
    return 0;

  return 1;
}

_id_F06F2A906262B65C(_id_17953215DD7C5F9B) {
  if(_id_17953215DD7C5F9B.info.ref != "travelvehicle" || self _meth_793F941D7DFF15ED()) {
    return;
  }
  items = vehicle_getarrayinradius(self.origin, 50000);
  _id_5BC86A57086A4774::_id_2E55101FFD0D483C(_id_17953215DD7C5F9B, items, ::_id_59C1DBDC2AD03AD6, 100, 1);
}