/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_78dac680a1677e7c.gsc
***********************************************/

_id_E27C8EAD6AB015FA(_id_A45669CF75867ED7) {
  if(!isDefined(_id_A45669CF75867ED7)) {
    return;
  }
  _id_AB3D60D5A354D4DA = [];

  foreach(wall in _id_A45669CF75867ED7) {
    _id_9F711536BE9153EB = [];
    _id_9F711536BE9153EB = scripts\engine\utility::array_add(_id_9F711536BE9153EB, _id_F74CACFD2004DC6D(wall[0], wall[1], wall[2]));
    direction = anglestoleft(wall[2]);
    _id_9A9FA9A5D71889FB = vectorNormalize(direction) * (1, 1, 0);

    switch (wall[0]) {
      case "192x256":
        _id_E2622D8D804C74F6 = _id_9A9FA9A5D71889FB * 192;
        break;
      case "64x256":
        _id_E2622D8D804C74F6 = _id_9A9FA9A5D71889FB * 64;
        break;
      default:
        _id_E2622D8D804C74F6 = _id_9A9FA9A5D71889FB * 192;
        break;
    }

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < wall[3]; _id_AC0E594AC96AA3A8++)
      _id_9F711536BE9153EB = scripts\engine\utility::array_add(_id_9F711536BE9153EB, _id_F74CACFD2004DC6D(wall[0], wall[1] + _id_E2622D8D804C74F6 * _id_AC0E594AC96AA3A8, wall[2]));

    _id_AB3D60D5A354D4DA = scripts\engine\utility::array_add(_id_AB3D60D5A354D4DA, _id_9F711536BE9153EB);
  }

  return _id_AB3D60D5A354D4DA;
}

_id_F74CACFD2004DC6D(scriptable, position, rotation) {
  return spawnscriptable(level._id_DBF4D97004E64BD5._id_2D519D04932F812E.scriptables[_func_1823FF50BB28148D(scriptable)], position, rotation);
}

_id_8EC6FF395F428891(_id_A45669CF75867ED7) {
  foreach(_id_14500EBF04E5180E in _id_A45669CF75867ED7) {
    foreach(wall in _id_14500EBF04E5180E)
    _id_7A423436AAAF2E58(wall);
  }
}

_id_7A423436AAAF2E58(wall) {
  wall.origin = (0, 0, 0);
}

_id_DE1ACB2EC7807E38() {
  if(!isDefined(level._id_DBF4D97004E64BD5._id_E82A930C823A7B9C)) {
    return;
  }
  foreach(_id_0DC609EF4988D3EF in level._id_DBF4D97004E64BD5._id_E82A930C823A7B9C)
  spawnscriptable(level._id_DBF4D97004E64BD5._id_A1C8C05E25923460.scriptables[_func_1823FF50BB28148D(_id_0DC609EF4988D3EF[0])], _id_0DC609EF4988D3EF[1], _id_0DC609EF4988D3EF[2]);
}

_id_FE4AEFEBD9992D47(_id_DED14AE1EA8C4446, _id_400586A35FA91E76, objectivetext) {
  if(_id_400586A35FA91E76) {
    foreach(_id_D1BFF7E80776F894 in _id_DED14AE1EA8C4446)
    level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(_id_D1BFF7E80776F894)]._id_E0E1C48A5393D3D1 _id_4148171500445EAD(objectivetext);
  }

  _id_B599E3F9981DEC25 = 0;

  while(_id_B599E3F9981DEC25 < _id_DED14AE1EA8C4446.size) {
    foreach(_id_D1BFF7E80776F894 in _id_DED14AE1EA8C4446) {
      if(isDefined(level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(_id_D1BFF7E80776F894)]._id_E0E1C48A5393D3D1) && level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(_id_D1BFF7E80776F894)]._id_E0E1C48A5393D3D1.health <= 0) {
        _id_B599E3F9981DEC25++;
        _id_695A872D7D692EFA::_id_B30874D13004D4C5(level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(_id_D1BFF7E80776F894)]._id_E0E1C48A5393D3D1);
        level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(_id_D1BFF7E80776F894)] notify("death_or_disconnect");
        level._id_DBF4D97004E64BD5._id_C0271A486AA56405[_func_1823FF50BB28148D(_id_D1BFF7E80776F894)]._id_E0E1C48A5393D3D1 = undefined;
      }
    }

    waitframe();
  }
}

_id_4148171500445EAD(objectivetext) {
  _id_558783BA07E79060 = getdvarint("dvar_7E3A7D1B515EF19E", 77);

  if(isDefined(objectivetext)) {
    _id_31A28435DF609F42 = undefined;

    switch (objectivetext) {
      case "Autoshoot":
        _id_31A28435DF609F42 = &"FTUE_MOBILE/SHOOT_TEST";
        break;
      case "ADS":
        _id_31A28435DF609F42 = &"FTUE_MOBILE/SHOOT_ADS_TEST";
        break;
    }

    _id_695A872D7D692EFA::_id_070E0DE6281199E7(self, _id_31A28435DF609F42, "mgl_ui_icon_ping_tacmap_enemy", _id_558783BA07E79060);
  } else
    _id_695A872D7D692EFA::_id_070E0DE6281199E7(self, undefined, "mgl_ui_icon_ping_tacmap_enemy", _id_558783BA07E79060);
}

_id_8E8398E14BC1F418(_id_FCFB525DF098DE89, triggerradius, triggerheight, objectivetext, objectiveicon, _id_41C04358E0645EED) {
  trigger = spawn("trigger_radius", _id_FCFB525DF098DE89, 0, triggerradius, triggerheight);
  trigger.radius = triggerradius;
  trigger.height = triggerheight;

  if(isDefined(objectivetext) && isDefined(objectiveicon) && isDefined(_id_41C04358E0645EED)) {
    _id_4CB22D8DDA2E06A9 = _id_695A872D7D692EFA::_id_E5524FB8509827BF(_id_FCFB525DF098DE89, objectivetext, objectiveicon, _id_41C04358E0645EED);
    trigger._id_4CB22D8DDA2E06A9 = _id_4CB22D8DDA2E06A9;
  }

  if(getdvarint("dvar_66535D0F1CE2E9FF", 0))
    trigger thread _id_5557A3C447C06DB9();

  return trigger;
}

_id_5557A3C447C06DB9() {
  self endon("entitydeleted");

  while(getdvarint("dvar_66535D0F1CE2E9FF", 0)) {
    scripts\engine\utility::draw_capsule(self.origin, self.radius, self.height, undefined, (1, 0, 0), 0, 1);
    waitframe();
  }
}

_id_0167D907CC0817D4(_id_14E976B5D4A4EAB0) {
  _id_695A872D7D692EFA::_id_4D03B9EF456D0972(_id_14E976B5D4A4EAB0._id_4CB22D8DDA2E06A9);
  _id_14E976B5D4A4EAB0 delete();
}

_id_A52FB2B2CD1BCEFA(_id_96CAECA39A49D120, _id_91887005C7B1A4D2) {
  if(isDefined(level._id_DBF4D97004E64BD5._id_3D84EEF8B3AFE5EB))
    return [level._id_DBF4D97004E64BD5._id_3D84EEF8B3AFE5EB, level._id_DBF4D97004E64BD5._id_9D94E563E4BE46B8];

  return [_id_96CAECA39A49D120, _id_91887005C7B1A4D2];
}

_id_7FDF3CF66304F3C5(player, _id_EE011D69B16FF21D, _id_DA9F74740B4AF6A7, callback) {
  player endon("currentContextualTipCompleted");
  player endon("currentContextualTipAborted");
  wait(_id_EE011D69B16FF21D);

  if(isDefined(_id_DA9F74740B4AF6A7))
    player _id_52EED65F3AF6AF91::_id_F339C5C73D11EA20(_id_DA9F74740B4AF6A7, 0, level._id_DBF4D97004E64BD5._id_F09F2FFD8A67FE03);

  if(isDefined(callback))
    self[[callback]]();

  player notify("currentContextualTipAborted");
}

_id_C0E79DFB73EAAE6A(_id_2193FDE10BF4B43A, _id_2A423FC276D9F388, player) {
  if(isDefined(player))
    overlay = newclienthudelem(player);
  else
    overlay = newhudelem();

  overlay.x = 0;
  overlay.y = 0;
  overlay setshader(_id_2193FDE10BF4B43A, 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = _id_2A423FC276D9F388;
  overlay.foreground = 1;
  return overlay;
}

_id_0DC51DE4E8CBD07B(pos, angles) {
  cameraent = spawn("script_model", pos);

  if(isDefined(angles))
    cameraent.angles = angles;

  cameraent setModel("tag_origin");
  return cameraent;
}

_id_F765ACF5B7C0C4A1() {
  if(!isDefined(level.players))
    return undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    _id_DD559C1CE15AE3D5 = level.players[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_DD559C1CE15AE3D5) && !isbot(_id_DD559C1CE15AE3D5))
      return _id_DD559C1CE15AE3D5;
  }

  return undefined;
}