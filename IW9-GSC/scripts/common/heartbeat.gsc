/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\heartbeat.gsc
***********************************************/

_id_94461E6FD9196C6A(_id_230B60EF0852DCB8) {
  level._id_7FB1B36BDC873CAB = spawnStruct();
  level._id_7FB1B36BDC873CAB._id_230B60EF0852DCB8 = _id_230B60EF0852DCB8;
}

_id_A9C6F7587066CE13() {
  self._id_7FB1B36BDC873CAB = spawnStruct();
  self._id_7FB1B36BDC873CAB.pulsetime = 0;
  thread _id_59AFA4F0666570D0();
}

_id_6C37D427B68FF9C7() {
  return [["mvmt_heartbeat_plr_superfast", 1.3], ["mvmt_heartbeat_plr_fast", 1.721], ["mvmt_heartbeat_plr_med", 1.973], ["mvmt_heartbeat_plr_slow", 2.321], ["mvmt_heartbeat_plr_superslow", 2.86]];
}

_id_FA062C79F577073C() {
  return [["mvmt_swim_heartbeat_plr_superfast", 1.3], ["mvmt_swim_heartbeat_plr_fast", 1.721], ["mvmt_swim_heartbeat_plr_med", 1.973], ["mvmt_swim_heartbeat_plr_slow", 2.321], ["mvmt_swim_heartbeat_plr_superslow", 2.86]];
}

_id_59AFA4F0666570D0() {
  self notify("heartBeatTimer");
  self endon("heartBeatTimer");
  self endon("death_or_disconnect");

  for(;;) {
    time = gettime();
    _id_BE61059BB932DDD5 = _id_8C8FF6FC7B5B3D67();

    if(isDefined(_id_BE61059BB932DDD5)) {
      _id_80B36D51E63183A3 = _id_BE61059BB932DDD5[0];
      childthread _id_7C867EA17D64A37C(_id_80B36D51E63183A3);
      _id_B50E35D9C370899B = 2;

      for(_id_134842F971B65EF6 = _id_BE61059BB932DDD5[1] * 1000 * 0.5; _id_B50E35D9C370899B > 0; _id_B50E35D9C370899B--) {
        for(_id_CFC5BE6822858733 = time; time < _id_CFC5BE6822858733 + _id_134842F971B65EF6; time = gettime()) {
          _id_70DD1E8302BB7A82(time, _id_CFC5BE6822858733, _id_134842F971B65EF6);
          waitframe();
        }
      }

      continue;
    }

    self waittill("startHeartbeatPulse");
  }
}

_id_70DD1E8302BB7A82(time, _id_CFC5BE6822858733, _id_134842F971B65EF6) {
  _id_22FD1081463A401F = (time - _id_CFC5BE6822858733) / _id_134842F971B65EF6;
  _id_22FD1081463A401F = scripts\engine\math::_id_4118613456C64C5E(_id_22FD1081463A401F, 0.65);
  self._id_7FB1B36BDC873CAB.pulsetime = 1 - scripts\engine\math::normalized_parabola(_id_22FD1081463A401F);
}

_id_8B94DCC60025C0DE(_id_134842F971B65EF6) {
  if(_id_4B87F2871B6B025C::_id_EA8199F09C110522() || !_id_AFB9ED6354E03DFA() || !_id_7B09A3E02E70B0D2()) {
    return;
  }
  _id_7AC5B3B3E8DF90D6 = _id_134842F971B65EF6 / 1000;
  wait(_id_7AC5B3B3E8DF90D6 * 0.1);
  childthread _id_B7C36A804415225B("heartbeatSuperLight");
}

_id_AFB9ED6354E03DFA() {
  return !isDefined(self.usingremote);
}

_id_B7C36A804415225B(_id_7FB1B36BDC873CAB) {
  self setscriptablepartstate("heartbeat", _id_7FB1B36BDC873CAB);
  wait 0.05;
  self setscriptablepartstate("heartbeat", "neutral");
}

_id_8C8FF6FC7B5B3D67() {
  if(_id_7B09A3E02E70B0D2())
    return _id_1078275B178DB870();
  else if(_id_4B87F2871B6B025C::_id_1CF18F5E612E68C5())
    return _id_14F4CBD1901F7812();
}

_id_1078275B178DB870() {
  if(!isDefined(self.currentregendelay) && !self._id_34F355A9DA5039E1)
    return undefined;

  _id_B10FF79982C0153B = _id_6C37D427B68FF9C7();

  if(isDefined(self.currentregendelay) && self.currentregendelay > 4.5)
    return _id_B10FF79982C0153B[0];
  else if(isDefined(self.currentregendelay) && self.currentregendelay > 2.8)
    return _id_B10FF79982C0153B[1];
  else if(isDefined(self.currentregendelay) && self.currentregendelay > 0.7)
    return _id_B10FF79982C0153B[2];
  else
    return _id_B10FF79982C0153B[3];
}

_id_14F4CBD1901F7812() {
  if(!_id_4B87F2871B6B025C::_id_3776BACC92B445D3())
    return undefined;

  _id_FE17E9129D4B4BFA = 2;
  _id_6B54ED3D32416E64 = 0;
  time = 0;
  _id_511925E2C9007AE6 = 0;

  if(_id_4B87F2871B6B025C::_id_BAB53C4F3C6062B9())
    return ["mvmt_swim_heartbeat_plr_ultrafast", 0.65];

  _id_B10FF79982C0153B = _id_FA062C79F577073C();

  if(_id_4B87F2871B6B025C::_id_EA8199F09C110522()) {
    _id_B10FF79982C0153B = [_id_B10FF79982C0153B[0], _id_B10FF79982C0153B[1]];
    remainingtime = _id_4B87F2871B6B025C::_id_B1B34805F6F1B18F();
  } else {
    _id_B10FF79982C0153B = [_id_B10FF79982C0153B[2], _id_B10FF79982C0153B[3], _id_B10FF79982C0153B[4]];
    remainingtime = _id_4B87F2871B6B025C::_id_B1B34805F6F1B18F() - [[level._id_C3A0F3B16CCE4CA9._id_575E6F276810675E]]();
  }

  for(;;) {
    if(_id_511925E2C9007AE6 < _id_FE17E9129D4B4BFA) {
      time = time + _id_B10FF79982C0153B[_id_6B54ED3D32416E64][1];
      _id_511925E2C9007AE6++;

      if(time > remainingtime) {
        break;
      }
    } else {
      _id_6B54ED3D32416E64++;
      _id_511925E2C9007AE6 = 0;

      if(_id_6B54ED3D32416E64 >= _id_B10FF79982C0153B.size - 1) {
        break;
      }
    }
  }

  return _id_B10FF79982C0153B[_id_6B54ED3D32416E64];
}

_id_2FB10E0F50E2D6C1() {
  _id_B10FF79982C0153B = _id_6C37D427B68FF9C7();
  return _id_B10FF79982C0153B[5];
}

_id_7B09A3E02E70B0D2() {
  return isDefined(self.deathsdoor) && self.deathsdoor;
}

_id_B8C77229D67126BF() {
  return isDefined(self.focus) && self.focus;
}

_id_7C867EA17D64A37C(_id_23EEAA8C13B1CB24) {
  if(!_id_4B87F2871B6B025C::_id_C2BE12529B0F0AD2()) {
    return;
  }
  self[[level._id_7FB1B36BDC873CAB._id_230B60EF0852DCB8]](_id_23EEAA8C13B1CB24);
}