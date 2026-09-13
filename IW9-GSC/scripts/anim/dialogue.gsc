/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\dialogue.gsc
***********************************************/

say(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay, scope) {
  if(!soundexists(alias) && !_id_C0AF485270DE3FBF(alias))
    return 0;

  self endon("death");
  priority = scripts\engine\utility::_id_53C4C53197386572(priority, 0);
  _id_F6E387B9F5A2B39C = scripts\engine\utility::_id_53C4C53197386572(_id_F6E387B9F5A2B39C, priority > 0);
  scope = scripts\engine\utility::_id_53C4C53197386572(scope, "self");
  _id_7D2852D02216C876 = self;

  if(self == level)
    _id_7D2852D02216C876 = _id_F5EB5B4D0E6714AA();

  if(scripts\engine\utility::is_dead_or_dying(_id_7D2852D02216C876) || istrue(_id_7D2852D02216C876._id_88E1B2F9582E6283))
    return 0;

  if(isDefined(level._id_32ED4C64DE33EAA6)) {
    _id_4495922F7FAAFFE7(level._id_32ED4C64DE33EAA6, alias);
    level._id_32ED4C64DE33EAA6 = undefined;
  }

  _id_5564A66C3EC1C07B = spawnStruct();
  _id_5564A66C3EC1C07B.alias = alias;
  _id_5564A66C3EC1C07B.priority = priority;
  _id_5564A66C3EC1C07B.timeout = timeout;
  _id_5564A66C3EC1C07B._id_F6E387B9F5A2B39C = _id_F6E387B9F5A2B39C;
  _id_5564A66C3EC1C07B._id_7D2852D02216C876 = _id_7D2852D02216C876;
  _id_5564A66C3EC1C07B.scope = scope;
  _id_5564A66C3EC1C07B._id_9A4096E3A9B92412 = _id_7D2852D02216C876 _id_028E38EEFD3CC4AB();
  _id_5564A66C3EC1C07B thread _id_C616A96AFE9E57BC(_id_7D2852D02216C876, alias, priority, timeout, _id_F6E387B9F5A2B39C, delay);

  if(!istrue(_id_5564A66C3EC1C07B._id_FFC93E687FE93831))
    _id_5564A66C3EC1C07B waittill("vo_done_or_cancelled");

  return _id_5564A66C3EC1C07B._id_6170366B0D0ED9EA;
}

_id_4495922F7FAAFFE7(_id_2E6E4390DC1C2FD9, alias) {
  if(!isDefined(alias)) {
    level._id_32ED4C64DE33EAA6 = _id_2E6E4390DC1C2FD9;
    return;
  }

  if(!isDefined(level._id_CB329546ED01D21A))
    level._id_CB329546ED01D21A = [];

  level._id_CB329546ED01D21A[alias] = _id_2E6E4390DC1C2FD9;
}

say_sequence(_id_927B3199642B75FC, priority, timeout, _id_F6E387B9F5A2B39C, delay, scope, _id_BA7E8AD2868EF874) {
  _id_5564A66C3EC1C07B = create_vo_data(_id_927B3199642B75FC, priority, timeout, scripts\engine\utility::_id_53C4C53197386572(_id_F6E387B9F5A2B39C, 0), delay, scope, _id_BA7E8AD2868EF874);
  return _id_E80002FD834A68B3(_id_5564A66C3EC1C07B);
}

_id_B0C2A659A5C2761F(_id_BA7E8AD2868EF874, _id_927B3199642B75FC, priority, timeout, _id_F6E387B9F5A2B39C, delay, scope) {
  return say_sequence(_id_927B3199642B75FC, priority, timeout, _id_F6E387B9F5A2B39C, delay, scope, _id_BA7E8AD2868EF874);
}

_id_C9A09B3BA9C68F8D(delay, _id_927B3199642B75FC, priority, timeout, _id_F6E387B9F5A2B39C, scope, _id_BA7E8AD2868EF874) {
  return say_sequence(_id_927B3199642B75FC, priority, timeout, _id_F6E387B9F5A2B39C, delay, scope, _id_BA7E8AD2868EF874);
}

_id_072B26BA6D062726(_id_927B3199642B75FC, priority, timeout, _id_F6E387B9F5A2B39C, delay, _id_BA7E8AD2868EF874) {
  return say_sequence(_id_927B3199642B75FC, priority, timeout, _id_F6E387B9F5A2B39C, delay, "global", _id_BA7E8AD2868EF874);
}

_id_5510C489D7F09128(_id_79D89AFD147F1EB1, _id_8BA39402D5530250) {
  if(!isDefined(_id_79D89AFD147F1EB1) || _id_79D89AFD147F1EB1)
    self notify("cancel_queued_vo");

  if(!isDefined(_id_8BA39402D5530250) || _id_8BA39402D5530250)
    self notify("cancel_delayed_vo");

  self notify("stop_vo_sequence");
  self notify("stop_dialogue");
  self notify("stop_facialFiller");

  if(isDefined(self._id_88502EB1E08DFC4D))
    self notify("scripted_face_" + self._id_88502EB1E08DFC4D, "end");

  self._id_E5CF232129F9EC01 = undefined;
  _id_93FA9B11F85EC1A9 = self;

  if(scripts\common\utility::issp() && isPlayer(self) || isstruct(self) || isDefined(self._id_63FDBDDD04BE9F53))
    _id_93FA9B11F85EC1A9 = _id_F5EB5B4D0E6714AA();

  thread _id_3E5D12EB11D543A2(_id_93FA9B11F85EC1A9);
}

_id_3EB481D98453CECB(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay) {
  return say(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay, "self");
}

_id_C47E471F9B42B010(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay) {
  return say(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay, "team");
}

_id_E732B9FBF689E21A(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay) {
  return say(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay, "global");
}

_id_88357F565D1BADF5(delay, alias, priority, timeout, _id_F6E387B9F5A2B39C, scope) {
  return say(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay, scope);
}

_id_8C1BBAEB5D3FE61A(delay, alias, priority, timeout, _id_F6E387B9F5A2B39C) {
  return say(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay, "self");
}

_id_FC0EB6B81C66C661(delay, alias, priority, timeout, _id_F6E387B9F5A2B39C) {
  return say(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay, "team");
}

_id_8C12D3C7FD8BC4FF(delay, alias, priority, timeout, _id_F6E387B9F5A2B39C) {
  return say(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay, "global");
}

_id_CB329CF8896EDEAA(team, _id_79D89AFD147F1EB1, _id_8BA39402D5530250) {
  if(!isDefined(level._id_60DF2B6C3887B3EB) || !isDefined(level._id_60DF2B6C3887B3EB[team])) {
    return;
  }
  foreach(_id_5564A66C3EC1C07B in level._id_60DF2B6C3887B3EB[team]._id_261AAF24A09D231D)
  _id_5564A66C3EC1C07B._id_7D2852D02216C876 _id_5510C489D7F09128(_id_79D89AFD147F1EB1, _id_8BA39402D5530250);
}

_id_54D3BD59BFF7E908(_id_79D89AFD147F1EB1, _id_8BA39402D5530250) {
  if(!isDefined(level._id_261AAF24A09D231D)) {
    return;
  }
  foreach(_id_5564A66C3EC1C07B in level._id_261AAF24A09D231D)
  _id_5564A66C3EC1C07B._id_7D2852D02216C876 _id_5510C489D7F09128(_id_79D89AFD147F1EB1, _id_8BA39402D5530250);
}

is_speaking() {
  _id_7D2852D02216C876 = self;

  if(self == level)
    _id_7D2852D02216C876 = _id_F5EB5B4D0E6714AA();

  if(!isDefined(_id_7D2852D02216C876._id_E5CF232129F9EC01) || !isDefined(_id_7D2852D02216C876._id_88502EB1E08DFC4D) && !isDefined(_id_7D2852D02216C876._id_800206351D64E3F4))
    return 0;

  if(isDefined(_id_7D2852D02216C876._id_261AAF24A09D231D))
    return _id_7D2852D02216C876._id_261AAF24A09D231D.size > 0;

  if(isDefined(_id_7D2852D02216C876._id_800206351D64E3F4))
    _id_B5A05AEF865298B2 = _id_F9E725C7FD059300(_id_7D2852D02216C876._id_800206351D64E3F4) * 1000;
  else
    _id_B5A05AEF865298B2 = lookupsoundlength(_id_7D2852D02216C876._id_88502EB1E08DFC4D);

  return gettime() <= _id_7D2852D02216C876._id_E5CF232129F9EC01 + _id_B5A05AEF865298B2;
}

_id_8951F1A8A6F683C9() {
  _id_7D2852D02216C876 = self;

  if(self == level)
    _id_7D2852D02216C876 = _id_F5EB5B4D0E6714AA();

  return _id_7D2852D02216C876 is_speaking() || isDefined(_id_7D2852D02216C876._id_8329BFD06CBB047A);
}

_id_754C9897F3B89964() {
  _id_7D2852D02216C876 = self;

  if(self == level)
    _id_7D2852D02216C876 = _id_F5EB5B4D0E6714AA();

  return _id_7D2852D02216C876 is_speaking() || istrue(_id_7D2852D02216C876._id_3968DE209A1C2B97);
}

_id_ED8A0BA27B9104C5() {
  _id_7D2852D02216C876 = self;

  if(self == level)
    _id_7D2852D02216C876 = _id_F5EB5B4D0E6714AA();

  return _id_7D2852D02216C876 is_speaking() || istrue(_id_7D2852D02216C876._id_3968DE209A1C2B97) || isDefined(_id_7D2852D02216C876._id_8329BFD06CBB047A);
}

_id_D871F93553913276(team) {
  scripts\engine\utility::_id_53C4C53197386572(team, self.team);

  if(!isDefined(level._id_60DF2B6C3887B3EB) || !isDefined(level._id_60DF2B6C3887B3EB[team]))
    return 0;

  return level._id_60DF2B6C3887B3EB[team]._id_261AAF24A09D231D.size > 0;
}

_id_E9E38931019C791F() {
  if(!isDefined(level._id_261AAF24A09D231D))
    return 0;

  return level._id_261AAF24A09D231D.size > 0;
}

_id_5731E26B3FF6304D(timeout) {
  _id_7D2852D02216C876 = self;

  if(isDefined(timeout)) {
    struct = spawnStruct();
    struct endon("end");
    childthread _id_D74571B48C6D763B(timeout, "end", struct);
  }

  if(self == level)
    _id_7D2852D02216C876 = _id_F5EB5B4D0E6714AA();

  if(!_id_7D2852D02216C876 _id_8951F1A8A6F683C9())
    return 0;

  _id_7D2852D02216C876 endon("death");

  if(isDefined(_id_7D2852D02216C876._id_261AAF24A09D231D) && _id_7D2852D02216C876._id_261AAF24A09D231D.size > 0)
    _id_7D2852D02216C876 waittill("vo_done_or_cancelled");
  else {
    _id_83E3BAAE738687F4 = gettime() - _id_7D2852D02216C876._id_E5CF232129F9EC01;

    if(isDefined(_id_7D2852D02216C876._id_88502EB1E08DFC4D))
      _id_B5A05AEF865298B2 = lookupsoundlength(_id_7D2852D02216C876._id_88502EB1E08DFC4D);
    else
      _id_B5A05AEF865298B2 = _id_F9E725C7FD059300(_id_7D2852D02216C876._id_800206351D64E3F4) * 1000;

    time_remaining = (_id_B5A05AEF865298B2 - _id_83E3BAAE738687F4) / 1000;
    wait(time_remaining);
  }

  return 1;
}

wait_finish_speaking() {
  _id_7D2852D02216C876 = self;

  if(self == level)
    _id_7D2852D02216C876 = _id_F5EB5B4D0E6714AA();

  if(!istrue(_id_7D2852D02216C876._id_3968DE209A1C2B97))
    return _id_5731E26B3FF6304D();

  _id_7D2852D02216C876 endon("cancel_queued_vo");
  _id_7D2852D02216C876 endon("death");

  while(_id_7D2852D02216C876._id_3968DE209A1C2B97 > 0)
    _id_7D2852D02216C876 waittill("vo_done_or_cancelled");

  return 1;
}

_id_BCE20C074033E937() {
  _id_7D2852D02216C876 = self;

  if(self == level)
    _id_7D2852D02216C876 = _id_F5EB5B4D0E6714AA();

  if(!isDefined(_id_7D2852D02216C876._id_E5CF232129F9EC01) || !isDefined(_id_7D2852D02216C876._id_88502EB1E08DFC4D))
    return undefined;

  _id_1189F67CDA3A6EC6 = _id_7D2852D02216C876._id_E5CF232129F9EC01 + lookupsoundlength(_id_7D2852D02216C876._id_88502EB1E08DFC4D);

  if(gettime() < _id_1189F67CDA3A6EC6)
    return undefined;

  return (gettime() - _id_1189F67CDA3A6EC6) / 1000;
}

_id_2E6C500B83DC82F5() {
  _id_7D2852D02216C876 = self;

  if(self == level)
    _id_7D2852D02216C876 = _id_F5EB5B4D0E6714AA();

  _id_3A006B25CF6977AA = isDefined(_id_7D2852D02216C876._id_8329BFD06CBB047A) && isnumber(_id_7D2852D02216C876._id_C037496486CC9D4B);

  if(!_id_3A006B25CF6977AA && !isDefined(_id_7D2852D02216C876._id_E5CF232129F9EC01) || !isDefined(_id_7D2852D02216C876._id_88502EB1E08DFC4D))
    return undefined;

  if(_id_3A006B25CF6977AA)
    _id_1189F67CDA3A6EC6 = _id_7D2852D02216C876._id_8329BFD06CBB047A + _id_7D2852D02216C876._id_C037496486CC9D4B * 1000 + lookupsoundlength(_id_7D2852D02216C876._id_88502EB1E08DFC4D);
  else
    _id_1189F67CDA3A6EC6 = self._id_E5CF232129F9EC01 + lookupsoundlength(self._id_88502EB1E08DFC4D);

  if(gettime() > _id_1189F67CDA3A6EC6)
    return undefined;

  return (_id_1189F67CDA3A6EC6 - gettime()) / 1000;
}

_id_53037A6CAE32FB97(_id_06B5C8034010B9BA, value) {
  if(!isDefined(self._id_A36DE4031E866CE5))
    _id_746D94AC5ED3EE5C();

  self._id_A36DE4031E866CE5[_id_06B5C8034010B9BA] = value;
}

_id_C3A221031A1FF66C(priority, timeout, _id_F6E387B9F5A2B39C, scope) {
  if(!isDefined(self._id_A36DE4031E866CE5))
    _id_746D94AC5ED3EE5C();

  self._id_A36DE4031E866CE5.priority = scripts\engine\utility::_id_53C4C53197386572(priority, self._id_A36DE4031E866CE5.priority);
  self._id_A36DE4031E866CE5.timeout = scripts\engine\utility::_id_53C4C53197386572(timeout, self._id_A36DE4031E866CE5.timeout);
  self._id_A36DE4031E866CE5._id_F6E387B9F5A2B39C = scripts\engine\utility::_id_53C4C53197386572(_id_F6E387B9F5A2B39C, self._id_A36DE4031E866CE5._id_F6E387B9F5A2B39C);
  self._id_A36DE4031E866CE5.scope = scripts\engine\utility::_id_53C4C53197386572(scope, self._id_A36DE4031E866CE5.scope);
}

_id_746D94AC5ED3EE5C() {
  if(self != level && !isDefined(level._id_A36DE4031E866CE5))
    level _id_746D94AC5ED3EE5C();

  self._id_A36DE4031E866CE5 = spawnStruct();
  self._id_A36DE4031E866CE5.priority = scripts\engine\utility::_id_53C4C53197386572(level._id_A36DE4031E866CE5.priority, 0);
  self._id_A36DE4031E866CE5.timeout = scripts\engine\utility::_id_53C4C53197386572(level._id_A36DE4031E866CE5.timeout, 1);
  self._id_A36DE4031E866CE5._id_F6E387B9F5A2B39C = scripts\engine\utility::_id_53C4C53197386572(level._id_A36DE4031E866CE5._id_F6E387B9F5A2B39C, 0);
  self._id_A36DE4031E866CE5.scope = scripts\engine\utility::_id_53C4C53197386572(level._id_A36DE4031E866CE5.scope, "team");
}

nag_wait(_id_F4B4FE5611C0F995, nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343, _id_D032257ACCA66A08) {
  self endon("finished_nag_loop");

  if(scripts\engine\utility::ter_op(istrue(_id_D032257ACCA66A08), !scripts\engine\utility::flag(_id_F4B4FE5611C0F995), scripts\engine\utility::flag(_id_F4B4FE5611C0F995))) {
    return;
  }
  _id_344578FB5C1F5325 = spawnStruct();
  childthread nagtill([_id_344578FB5C1F5325, "stop"], nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343);

  if(istrue(_id_D032257ACCA66A08))
    scripts\engine\utility::flag_waitopen(_id_F4B4FE5611C0F995);
  else
    scripts\engine\utility::flag_wait(_id_F4B4FE5611C0F995);

  _id_344578FB5C1F5325 notify("stop");
}

_id_BACE8AF56EF0688B(_id_F4B4FE5611C0F995, nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343) {
  nag_wait(_id_F4B4FE5611C0F995, nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343, 1);
}

_id_91C23782840CF632(_id_EB053D490B6594D2, nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343, _id_D032257ACCA66A08) {
  self endon("finished_nag_loop");

  foreach(_id_F4B4FE5611C0F995 in _id_EB053D490B6594D2) {
    if(scripts\engine\utility::ter_op(istrue(_id_D032257ACCA66A08), !scripts\engine\utility::flag(_id_F4B4FE5611C0F995), scripts\engine\utility::flag(_id_F4B4FE5611C0F995)))
      return;
  }

  _id_344578FB5C1F5325 = spawnStruct();
  childthread nagtill([_id_344578FB5C1F5325, "stop"], nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343);

  for(;;) {
    scripts\engine\utility::_id_5ADCA43F839A3CCE(_id_EB053D490B6594D2);

    foreach(_id_F4B4FE5611C0F995 in _id_EB053D490B6594D2) {
      if(scripts\engine\utility::ter_op(istrue(_id_D032257ACCA66A08), !scripts\engine\utility::flag(_id_F4B4FE5611C0F995), scripts\engine\utility::flag(_id_F4B4FE5611C0F995))) {
        _id_344578FB5C1F5325 notify("stop");
        return;
      }
    }
  }
}

_id_91CB20828416E24B(_id_EB053D490B6594D2, nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343, _id_D032257ACCA66A08) {
  self endon("finished_nag_loop");

  foreach(_id_F4B4FE5611C0F995 in _id_EB053D490B6594D2) {
    if(scripts\engine\utility::ter_op(istrue(_id_D032257ACCA66A08), scripts\engine\utility::flag(_id_F4B4FE5611C0F995), !scripts\engine\utility::flag(_id_F4B4FE5611C0F995))) {
      continue;
    }
    return;
  }

  _id_344578FB5C1F5325 = spawnStruct();
  childthread nagtill([_id_344578FB5C1F5325, "stop"], nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343);
  _id_9F925F5509626DF1 = 0;

  while(_id_9F925F5509626DF1 == 0) {
    level scripts\engine\utility::_id_5ADCA43F839A3CCE(_id_EB053D490B6594D2);
    _id_9F925F5509626DF1 = 1;

    foreach(_id_F4B4FE5611C0F995 in _id_EB053D490B6594D2) {
      if(scripts\engine\utility::ter_op(istrue(_id_D032257ACCA66A08), scripts\engine\utility::flag(_id_F4B4FE5611C0F995), !scripts\engine\utility::flag(_id_F4B4FE5611C0F995))) {
        _id_9F925F5509626DF1 = 0;
        break;
      }
    }
  }

  _id_344578FB5C1F5325 notify("stop");
}

nagtill(_id_A490EDBA2726EC98, nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343) {
  self endon("finished_nag_loop");
  _id_344578FB5C1F5325 = self;
  _id_AC1CDDFBB55B0E81 = _id_A490EDBA2726EC98;

  if(isarray(_id_A490EDBA2726EC98)) {
    _id_344578FB5C1F5325 = _id_A490EDBA2726EC98[0];
    _id_AC1CDDFBB55B0E81 = _id_A490EDBA2726EC98[1];
  }

  _id_344578FB5C1F5325 endon(_id_AC1CDDFBB55B0E81);
  _id_000407745805F870(nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343);
}

_id_A60FEA4F51763A4F(_id_A490EDBA2726EC98, nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343) {
  _id_344578FB5C1F5325 = self;

  foreach(_id_A240832E918CDA1F in _id_A490EDBA2726EC98) {
    if(isent(_id_A240832E918CDA1F) || isstruct(_id_A240832E918CDA1F)) {
      _id_344578FB5C1F5325 = _id_A240832E918CDA1F;
      continue;
    }

    if(isstring(_id_A240832E918CDA1F)) {
      _id_344578FB5C1F5325 endon(_id_A240832E918CDA1F);
      continue;
    }
  }

  _id_000407745805F870(nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343);
}

_id_B9007D9F0FF19676(start, end, count) {
  delay = spawnStruct();
  delay.current = start;
  delay.maximum = end;
  delay._id_2F977E27FA739602 = (end - start) / count;
  return delay;
}

_id_B0FDDB86A2358953(delay, params) {
  if(isarray(delay)) {
    if(delay.size == 1 && isnumber(delay[0]))
      delay = (delay[0] - gettime()) / 1000;
    else if(isfunction(delay[0]) || isbuiltinmethod(delay[0]) || isbuiltinfunction(delay[0]))
      return call_with_params(delay[0], scripts\engine\utility::array_remove_index(delay, 0));
    else if(delay.size == 2 && (isent(delay[0]) || isstruct(delay[0])) && isstring(delay[1])) {
      delay[0] waittill(delay[1], value);
      return value;
    } else if(delay.size == 2 && isnumber(delay[0]) && isnumber(delay[1])) {
      wait(randomfloatrange(delay[0], delay[1]));
      return 1;
    } else
      return _id_CF139EC9192B3DAE(delay, params);
  }

  if(isnumber(delay)) {
    if(delay <= 0) {
      return;
    }
    wait(delay);
    return 1;
  }

  if(isstruct(delay) && isDefined(delay.current)) {
    wait(delay.current);

    if(isDefined(delay._id_2F977E27FA739602))
      delay.current = delay.current + delay._id_2F977E27FA739602;

    if(isDefined(delay.maximum) && delay.current >= delay.maximum) {
      delay.current = delay.maximum;
      return 1;
    }

    return;
  }

  if(isstring(delay)) {
    self waittill(delay, value);
    return value;
  }

  if(isfunction(delay) || isbuiltinmethod(delay) || isbuiltinfunction(delay))
    return call_with_params(delay, params);
}

_id_CF139EC9192B3DAE(_id_6ADA3242ACD08CF5, params) {
  if(!isarray(_id_6ADA3242ACD08CF5)) {
    _id_B0FDDB86A2358953(_id_6ADA3242ACD08CF5, params);
    return _id_6ADA3242ACD08CF5;
  }

  ent = spawnStruct();
  ent endon("kill");

  foreach(delay in _id_6ADA3242ACD08CF5)
  childthread _id_D74571B48C6D763B(delay, "finished", ent, params);

  ent waittill("finished", result);
  ent scripts\engine\utility::delaythread(0.05, scripts\engine\utility::send_notify, "kill");
  return result;
}

_id_D74571B48C6D763B(delay, msg, _id_83809AD93D7831FA, params) {
  if(!isDefined(_id_83809AD93D7831FA))
    _id_83809AD93D7831FA = self;

  result = _id_B0FDDB86A2358953(delay, params);
  _id_83809AD93D7831FA notify(msg, result, delay, self);
}

_id_5CF2FF53D6A7C938(_id_6ADA3242ACD08CF5, msg, _id_83809AD93D7831FA, params) {
  if(!isDefined(_id_83809AD93D7831FA))
    _id_83809AD93D7831FA = self;

  result = _id_CF139EC9192B3DAE(_id_6ADA3242ACD08CF5, params);
  _id_83809AD93D7831FA notify(msg, result, self);
}

_id_97A6F7C8F1800369(delay, params, msg) {
  struct = spawnStruct();
  thread _id_D74571B48C6D763B(delay, scripts\engine\utility::_id_53C4C53197386572(msg, "finish"), struct, params);
  return struct;
}

call_with_params(func, params) {
  if(isfunction(func))
    return call_with_params_script(func, params);
  else if(isbuiltinmethod(func))
    return call_with_params_builtin(func, params);
  else if(isbuiltinfunction(func))
    return _id_8093AC75AA6ABB73(func, params);
  else {}
}

call_with_params_script(func, params) {
  if(!isDefined(params))
    return self[[func]]();

  if(!isarray(params))
    return self[[func]](params);

  switch (params.size) {
    case 0:
      return self[[func]]();
    case 1:
      return self[[func]](params[0]);
    case 2:
      return self[[func]](params[0], params[1]);
    case 3:
      return self[[func]](params[0], params[1], params[2]);
    case 4:
      return self[[func]](params[0], params[1], params[2], params[3]);
    case 5:
      return self[[func]](params[0], params[1], params[2], params[3], params[4]);
    case 6:
      return self[[func]](params[0], params[1], params[2], params[3], params[4], params[5]);
    case 7:
      return self[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
    case 8:
      return self[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
    case 9:
      return self[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
    default:
      break;
  }
}

call_with_params_builtin(func, params) {
  if(!isDefined(params))
    return self[[func]]();

  if(!isarray(params))
    return self call[[func]](params);

  switch (params.size) {
    case 0:
      return self call[[func]]();
    case 1:
      return self call[[func]](params[0]);
    case 2:
      return self call[[func]](params[0], params[1]);
    case 3:
      return self call[[func]](params[0], params[1], params[2]);
    case 4:
      return self call[[func]](params[0], params[1], params[2], params[3]);
    case 5:
      return self call[[func]](params[0], params[1], params[2], params[3], params[4]);
    case 6:
      return self call[[func]](params[0], params[1], params[2], params[3], params[4], params[5]);
    case 7:
      return self call[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
    case 8:
      return self call[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
    case 9:
      return self call[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
    default:
      break;
  }
}

_id_8093AC75AA6ABB73(func, params) {
  if(!isDefined(params))
    return call[[func]]();

  if(!isarray(params))
    return call[[func]](params);

  switch (params.size) {
    case 0:
      return call[[func]]();
    case 1:
      return call[[func]](params[0]);
    case 2:
      return call[[func]](params[0], params[1]);
    case 3:
      return call[[func]](params[0], params[1], params[2]);
    case 4:
      return call[[func]](params[0], params[1], params[2], params[3]);
    case 5:
      return call[[func]](params[0], params[1], params[2], params[3], params[4]);
    case 6:
      return call[[func]](params[0], params[1], params[2], params[3], params[4], params[5]);
    case 7:
      return call[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
    case 8:
      return call[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
    case 9:
      return call[[func]](params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
    default:
      break;
  }
}

_id_EA6F404468959FD2(timeout, func, params) {
  ent = spawnStruct();
  ent scripts\engine\utility::delaythread(timeout, scripts\engine\utility::send_notify, "kill");
  ent endon("kill");
  return call_with_params(func, params);
}

create_vo_data(_id_927B3199642B75FC, priority, timeout, _id_F6E387B9F5A2B39C, delay, scope, _id_BA7E8AD2868EF874) {
  _id_7D2852D02216C876 = self;

  if(self == level)
    _id_7D2852D02216C876 = _id_F5EB5B4D0E6714AA();

  if(scripts\engine\utility::is_dead_or_dying(_id_7D2852D02216C876) || istrue(_id_7D2852D02216C876._id_88E1B2F9582E6283)) {
    return;
  }
  _id_A7AB82FF3CC6AC85 = scripts\engine\utility::ter_op(isDefined(_id_7D2852D02216C876.team), "team", "global");
  scope = scripts\engine\utility::_id_53C4C53197386572(scope, _id_A7AB82FF3CC6AC85);
  _id_5564A66C3EC1C07B = spawnStruct();
  _id_5564A66C3EC1C07B.owner = self;
  _id_5564A66C3EC1C07B._id_7D2852D02216C876 = _id_7D2852D02216C876;
  _id_5564A66C3EC1C07B._id_9A4096E3A9B92412 = _id_7D2852D02216C876 _id_028E38EEFD3CC4AB();
  _id_5564A66C3EC1C07B._id_C6122C93E719738E = 1;

  if(!isarray(_id_927B3199642B75FC))
    _id_927B3199642B75FC = [_id_927B3199642B75FC];

  _id_5564A66C3EC1C07B.index = 0;
  _id_5564A66C3EC1C07B._id_927B3199642B75FC = _id_927B3199642B75FC;
  _id_5564A66C3EC1C07B.priority = scripts\engine\utility::_id_53C4C53197386572(priority, 0);
  _id_5564A66C3EC1C07B._id_F6E387B9F5A2B39C = scripts\engine\utility::_id_53C4C53197386572(_id_F6E387B9F5A2B39C, 1);
  _id_5564A66C3EC1C07B._id_BA7E8AD2868EF874 = scripts\engine\utility::_id_53C4C53197386572(_id_BA7E8AD2868EF874, []);
  _id_5564A66C3EC1C07B.timeout = timeout;
  _id_5564A66C3EC1C07B.delay = delay;
  _id_5564A66C3EC1C07B.scope = scope;

  if(!isarray(_id_5564A66C3EC1C07B._id_BA7E8AD2868EF874))
    _id_5564A66C3EC1C07B._id_BA7E8AD2868EF874 = [_id_5564A66C3EC1C07B._id_BA7E8AD2868EF874];

  return _id_5564A66C3EC1C07B;
}

_id_E80002FD834A68B3(_id_5564A66C3EC1C07B) {
  if(!isDefined(_id_5564A66C3EC1C07B))
    return 0;

  _id_5564A66C3EC1C07B thread _id_9A5AD53E35891FD4();

  if(!istrue(_id_5564A66C3EC1C07B._id_E304CBC83D937A51))
    _id_5564A66C3EC1C07B waittill("finished_or_cancelled");

  return _id_5564A66C3EC1C07B._id_0F5E6316C2383F5F;
}

_id_C616A96AFE9E57BC(_id_7D2852D02216C876, alias, priority, timeout, _id_F6E387B9F5A2B39C, delay) {
  self._id_0F5E6316C2383F5F = 0;
  _id_7D2852D02216C876._id_44E1869B50A57309 = self.scope;
  _id_7D2852D02216C876 notify("started_queue_wait", self);
  cancelled = self._id_9A4096E3A9B92412[self.scope] _id_0F2A79001721945A(self, timeout);
  _id_7D2852D02216C876 notify("finished_queue_wait", self, cancelled);

  if(!istrue(cancelled) && !scripts\engine\utility::is_dead_or_dying(_id_7D2852D02216C876) && !istrue(_id_7D2852D02216C876._id_88E1B2F9582E6283)) {
    _id_7D2852D02216C876._id_EC9F57E7698BAFFB = priority;

    foreach(ent in self._id_9A4096E3A9B92412)
    ent _id_797820CAD48747EF(self);

    self notify("proceeded");
    cancelled = _id_7D2852D02216C876 _id_19E262DA812CCBEF(delay, alias);
    _id_7D2852D02216C876._id_8329BFD06CBB047A = undefined;
    _id_7D2852D02216C876._id_C037496486CC9D4B = undefined;
    _id_7D2852D02216C876 notify("stop_bcs_sequence");

    if(isDefined(cancelled) && !cancelled) {
      _id_76F8015B9B041E57(_id_F6E387B9F5A2B39C, self._id_9A4096E3A9B92412[self.scope]);
      self._id_6170366B0D0ED9EA = _id_7D2852D02216C876 _id_7B52F05DA542C2FF(alias, _id_F6E387B9F5A2B39C, self._id_9A4096E3A9B92412[self.scope], self._id_5C1322185369EFCD);
    }

    if(scripts\engine\utility::is_dead_or_dying(_id_7D2852D02216C876))
      _id_7D2852D02216C876 _id_5510C489D7F09128(0, 0);

    foreach(ent in self._id_9A4096E3A9B92412)
    ent remove_vo_data(self);
  } else
    self notify("proceeded");

  _id_AB8711048F02259D(self._id_9A4096E3A9B92412);
  self._id_FFC93E687FE93831 = 1;
  _id_7D2852D02216C876 notify("vo_done_or_cancelled", self);
  self notify("vo_done_or_cancelled");
}

_id_76F8015B9B041E57(_id_F6E387B9F5A2B39C, _id_F30B49A2BC186DD5) {
  if(!istrue(_id_F6E387B9F5A2B39C)) {
    _id_7D2852D02216C876 = scripts\engine\utility::_id_53C4C53197386572(self._id_868E98CF48B92CFB, self);

    foreach(_id_5564A66C3EC1C07B in _id_F30B49A2BC186DD5._id_261AAF24A09D231D) {
      if(_id_5564A66C3EC1C07B == self) {
        continue;
      }
      _id_076FF72B66D59A33 = _id_5564A66C3EC1C07B._id_7D2852D02216C876;
      _id_C578B4A015B24CD8 = scripts\common\utility::issp() || isstruct(_id_7D2852D02216C876) || isstruct(_id_076FF72B66D59A33);

      if(_id_C578B4A015B24CD8 || distance2dsquared(_id_7D2852D02216C876.origin, _id_076FF72B66D59A33.origin) <= level._id_C1ED820E79E07B7C)
        _id_076FF72B66D59A33 _id_5510C489D7F09128(0, 1);
    }
  }
}

_id_9A5AD53E35891FD4() {
  self._id_0F5E6316C2383F5F = 0;
  self._id_E304CBC83D937A51 = 0;
  self._id_7D2852D02216C876._id_44E1869B50A57309 = self.scope;
  self._id_7D2852D02216C876 notify("started_queue_wait", self);
  cancelled = self._id_9A4096E3A9B92412[self.scope] _id_0F2A79001721945A(self, self.timeout, self._id_BA7E8AD2868EF874);
  self._id_7D2852D02216C876 notify("finished_queue_wait", self, cancelled);

  if(!istrue(cancelled) && !scripts\engine\utility::is_dead_or_dying(self._id_7D2852D02216C876) && !istrue(self._id_7D2852D02216C876._id_88E1B2F9582E6283))
    _id_A79D3EDB8B0D3D9C();
  else
    self notify("proceeded");

  if(!isDefined(self._id_0F5E6316C2383F5F)) {
    if(isDefined(self._id_5A99A0A244447AFD))
      self thread[[self._id_5A99A0A244447AFD]]();
  } else if(!self._id_0F5E6316C2383F5F) {
    if(isDefined(self._id_7731E4E561FE4D38))
      self thread[[self._id_7731E4E561FE4D38]]();
  } else if(isDefined(self._id_0D33B713A010187C))
    self thread[[self._id_0D33B713A010187C]]();

  _id_AB8711048F02259D(self._id_9A4096E3A9B92412);
  self._id_7D2852D02216C876 notify("vo_finished_or_cancelled", self);
  level notify("vo_finished_or_cancelled", self);
  self._id_E304CBC83D937A51 = 1;
  self notify("finished_or_cancelled");
  return self._id_0F5E6316C2383F5F;
}

_id_A79D3EDB8B0D3D9C() {
  level notify("vo_sequence_started", self);
  self._id_7D2852D02216C876._id_EC9F57E7698BAFFB = self.priority;

  foreach(ent in self._id_9A4096E3A9B92412)
  ent _id_797820CAD48747EF(self);

  self notify("proceeded");
  cancelled = self._id_7D2852D02216C876 _id_19E262DA812CCBEF(self.delay, self.alias);
  self._id_7D2852D02216C876._id_8329BFD06CBB047A = undefined;
  self._id_7D2852D02216C876._id_C037496486CC9D4B = undefined;

  if(isDefined(cancelled) && !cancelled) {
    _id_76F8015B9B041E57(self._id_F6E387B9F5A2B39C, self._id_9A4096E3A9B92412[self.scope]);

    while(isDefined(self._id_0F5E6316C2383F5F) && !self._id_0F5E6316C2383F5F)
      self._id_0F5E6316C2383F5F = _id_2F5F29DA6F0F73E6();

    if(scripts\engine\utility::is_dead_or_dying(self._id_7D2852D02216C876)) {
      self._id_7D2852D02216C876 _id_5510C489D7F09128(0, 0);

      if(isDefined(self._id_547430358C7CE6FE))
        self thread[[self._id_547430358C7CE6FE]]();
    }
  }

  foreach(ent in self._id_9A4096E3A9B92412)
  ent remove_vo_data(self);

  level notify("vo_sequence_ended", self);
}

_id_2F5F29DA6F0F73E6() {
  if(self.index >= self._id_927B3199642B75FC.size)
    return 1;

  if(scripts\engine\utility::is_dead_or_dying(self._id_7D2852D02216C876)) {
    if(isDefined(self._id_8148255515EF1B38))
      self[[self._id_8148255515EF1B38]]();

    if(scripts\engine\utility::is_dead_or_dying(self._id_7D2852D02216C876))
      return _id_139CCEC48E7E3539("DEAD SPEAKER");
  }

  _id_9A4096E3A9B92412 = self._id_7D2852D02216C876 _id_028E38EEFD3CC4AB();
  _id_9A4096E3A9B92412[self.scope] endon("stop_vo_sequence");
  self._id_7D2852D02216C876 endon("stop_vo_sequence");
  self._id_7D2852D02216C876 endon("death");
  self notify("new_segment");
  _id_344578FB5C1F5325 = self._id_7D2852D02216C876;

  foreach(_id_A490EDBA2726EC98 in self._id_BA7E8AD2868EF874) {
    if(isent(_id_A490EDBA2726EC98) || isstruct(_id_A490EDBA2726EC98)) {
      _id_344578FB5C1F5325 = _id_A490EDBA2726EC98;
      continue;
    }

    if(isstring(_id_A490EDBA2726EC98))
      _id_344578FB5C1F5325 endon(_id_A490EDBA2726EC98);
  }

  self.alias = undefined;
  _id_1F7FD473E2E3E8AA = self._id_927B3199642B75FC[self.index];
  self.index++;

  if(isstring(_id_1F7FD473E2E3E8AA)) {
    self.alias = _id_1F7FD473E2E3E8AA;

    if(!soundexists(self.alias) && !_id_C0AF485270DE3FBF(self.alias))
      return _id_139CCEC48E7E3539("MISSING ALIAS");

    _id_0F5E6316C2383F5F = self._id_7D2852D02216C876 _id_7B52F05DA542C2FF(self.alias, self._id_F6E387B9F5A2B39C, self._id_9A4096E3A9B92412[self.scope], self._id_5C1322185369EFCD);

    if(!istrue(_id_0F5E6316C2383F5F))
      return _id_139CCEC48E7E3539("SAY INTERRUPTED");

    return 0;
  } else if(isnumber(_id_1F7FD473E2E3E8AA)) {
    if(_id_1F7FD473E2E3E8AA <= 0)
      return 0;

    wait(_id_1F7FD473E2E3E8AA);
    return 0;
  } else if(isent(_id_1F7FD473E2E3E8AA) || isstruct(_id_1F7FD473E2E3E8AA)) {
    result = _id_8853208B795FE407(_id_1F7FD473E2E3E8AA);
    return 0;
  } else if(isfunction(_id_1F7FD473E2E3E8AA)) {
    result = self[[_id_1F7FD473E2E3E8AA]]();

    if(isDefined(result)) {
      if(isint(result) && result == 0)
        return _id_139CCEC48E7E3539("FUNC RETURNED FALSE");

      self.index--;
      self._id_927B3199642B75FC[self.index] = result;
    }

    return 0;
  } else if(isarray(_id_1F7FD473E2E3E8AA)) {
    self.index--;
    _id_927B3199642B75FC = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_927B3199642B75FC.size; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 == self.index) {
        foreach(item in _id_1F7FD473E2E3E8AA)
        _id_927B3199642B75FC[_id_927B3199642B75FC.size] = item;

        continue;
      }

      _id_927B3199642B75FC[_id_927B3199642B75FC.size] = self._id_927B3199642B75FC[_id_AC0E594AC96AA3A8];
    }

    self._id_927B3199642B75FC = _id_927B3199642B75FC;
    return 0;
  }

  return _id_139CCEC48E7E3539("UNDEFINED SEGMENT");
}

_id_139CCEC48E7E3539(_id_401C3A2E68AAB0FD) {}

_id_8853208B795FE407(_id_65E9C81367809607) {
  foreach(ent in self._id_9A4096E3A9B92412)
  ent remove_vo_data(self);

  if(_id_65E9C81367809607 == level)
    _id_65E9C81367809607 = _id_65E9C81367809607 _id_F5EB5B4D0E6714AA();

  self._id_6727329A89208345 = self._id_7D2852D02216C876;
  self._id_7D2852D02216C876 = _id_65E9C81367809607;
  self._id_7D2852D02216C876._id_EC9F57E7698BAFFB = self.priority;
  self._id_9A4096E3A9B92412 = self._id_7D2852D02216C876 _id_028E38EEFD3CC4AB();

  foreach(ent in self._id_9A4096E3A9B92412)
  ent _id_797820CAD48747EF(self);
}

_id_19E262DA812CCBEF(delay, _id_30356EE6394ECF19) {
  if(!isDefined(delay))
    return 0;

  self endon("death");
  self endon("cancel_delayed_vo");
  self._id_88502EB1E08DFC4D = undefined;
  self._id_800206351D64E3F4 = undefined;
  self._id_8329BFD06CBB047A = gettime();
  self._id_C037496486CC9D4B = delay;

  if(isDefined(_id_30356EE6394ECF19) && _id_C0AF485270DE3FBF(_id_30356EE6394ECF19))
    self._id_800206351D64E3F4 = _id_30356EE6394ECF19;
  else
    self._id_88502EB1E08DFC4D = _id_30356EE6394ECF19;

  result = _id_B0FDDB86A2358953(delay);
  return isDefined(result) && result == 0;
}

_id_7B52F05DA542C2FF(alias, _id_F6E387B9F5A2B39C, _id_F30B49A2BC186DD5, _id_5C1322185369EFCD) {
  if(scripts\engine\utility::is_dead_or_dying(self))
    return 0;

  self notify("started_saying", alias);

  if(isDefined(self._id_AED624967395163B))
    self thread[[self._id_AED624967395163B]](alias);

  if(_id_C0AF485270DE3FBF(alias))
    _id_0F5E6316C2383F5F = _id_932C63C904570806(alias);
  else if(soundexists(alias))
    _id_0F5E6316C2383F5F = _id_E7C1C9DEE13137AA(alias, _id_5C1322185369EFCD);
  else
    _id_0F5E6316C2383F5F = 0;

  self notify("done_saying", alias, _id_0F5E6316C2383F5F);
  return _id_0F5E6316C2383F5F;
}

_id_E7C1C9DEE13137AA(alias, _id_5C1322185369EFCD) {
  self endon("death");
  self._id_E5CF232129F9EC01 = gettime();
  self._id_88502EB1E08DFC4D = alias;
  self._id_800206351D64E3F4 = undefined;

  if(isDefined(_id_5C1322185369EFCD) && scripts\common\utility::issp())
    thread _id_5BAEBD9837531E1F(alias, _id_5C1322185369EFCD);

  return self[[level._id_9A62261B5B534B06]](alias);
}

_id_0F2A79001721945A(_id_5564A66C3EC1C07B, timeout, _id_BA7E8AD2868EF874) {
  _id_5564A66C3EC1C07B endon("proceed");

  if(self._id_261AAF24A09D231D.size == 0 || !istrue(_id_5564A66C3EC1C07B._id_79498ADF23C51E6A) && _id_5564A66C3EC1C07B.priority >= 0 && _id_623D7AA584B346AC())
    return 0;

  _id_5EE32A2DA994AFAB(_id_5564A66C3EC1C07B);
  cancelled = !istrue(_id_5564A66C3EC1C07B._id_7D2852D02216C876 _id_F983CE9B3755F759(timeout, _id_BA7E8AD2868EF874));
  _id_4866DAF9001CDB5F(_id_5564A66C3EC1C07B);

  if(cancelled || !_id_5564A66C3EC1C07B _id_6CF6A58C99522E20(self._id_261AAF24A09D231D))
    return 1;

  return 0;
}

_id_623D7AA584B346AC() {
  foreach(_id_5564A66C3EC1C07B in self._id_261AAF24A09D231D) {
    if(!istrue(_id_5564A66C3EC1C07B._id_79498ADF23C51E6A))
      return 0;
  }

  return 1;
}

_id_AB8711048F02259D(_id_9A4096E3A9B92412) {
  foreach(_id_F30B49A2BC186DD5 in _id_9A4096E3A9B92412) {
    if(!isDefined(_id_F30B49A2BC186DD5.vo_queue) || _id_F30B49A2BC186DD5.vo_queue.size == 0) {
      continue;
    }
    _id_104668542102DC3C = _id_F30B49A2BC186DD5.vo_queue[0];

    if(_id_F30B49A2BC186DD5._id_261AAF24A09D231D.size == 0 || _id_104668542102DC3C _id_CA829A8ED4C9EFBE(_id_F30B49A2BC186DD5)) {
      _id_F30B49A2BC186DD5 _id_4866DAF9001CDB5F(_id_104668542102DC3C);
      _id_104668542102DC3C notify("proceed");
      _id_104668542102DC3C waittill("proceeded");
      return;
    }
  }
}

_id_F983CE9B3755F759(timeout, _id_BA7E8AD2868EF874) {
  self endon("death");

  if(isDefined(_id_BA7E8AD2868EF874)) {
    if(!isarray(_id_BA7E8AD2868EF874))
      _id_BA7E8AD2868EF874 = [_id_BA7E8AD2868EF874];

    _id_344578FB5C1F5325 = self;

    foreach(_id_A490EDBA2726EC98 in _id_BA7E8AD2868EF874) {
      if(isent(_id_A490EDBA2726EC98) || isstruct(_id_A490EDBA2726EC98)) {
        _id_344578FB5C1F5325 = _id_A490EDBA2726EC98;
        continue;
      }

      if(isstring(_id_A490EDBA2726EC98))
        _id_344578FB5C1F5325 endon(_id_A490EDBA2726EC98);
    }
  }

  if(isDefined(timeout)) {
    self endon("cancel_queued_vo");
    result = _id_B0FDDB86A2358953(timeout);
    return !isDefined(result) || result;
  }

  self waittill("cancel_queued_vo");
}

_id_CA829A8ED4C9EFBE(_id_F30B49A2BC186DD5) {
  return 0;
}

_id_6CF6A58C99522E20(_id_372FAC4E460E7107, _id_7F94B97D0581DA71) {
  if(isstruct(_id_372FAC4E460E7107))
    _id_372FAC4E460E7107 = _id_372FAC4E460E7107._id_261AAF24A09D231D;

  speakers = [];

  if(scripts\common\utility::issp() || !isDefined(self._id_7D2852D02216C876.origin) || istrue(self._id_7D2852D02216C876._id_568A463DBBA1469C)) {
    foreach(_id_5564A66C3EC1C07B in _id_372FAC4E460E7107)
    speakers[speakers.size] = _id_5564A66C3EC1C07B._id_7D2852D02216C876;
  } else {
    foreach(_id_5564A66C3EC1C07B in _id_372FAC4E460E7107) {
      _id_7D2852D02216C876 = _id_5564A66C3EC1C07B._id_7D2852D02216C876;

      if(isstruct(_id_7D2852D02216C876) || distance2dsquared(self._id_7D2852D02216C876.origin, _id_7D2852D02216C876.origin) <= level._id_C1ED820E79E07B7C)
        speakers[speakers.size] = _id_7D2852D02216C876;
    }
  }

  if(self.priority >= 1 || speakers.size == 0)
    return 1;

  _id_63803077B6413BA4 = speakers[0]._id_EC9F57E7698BAFFB;

  if(!isDefined(_id_63803077B6413BA4))
    return 1;

  if(istrue(_id_7F94B97D0581DA71))
    return self.priority >= _id_63803077B6413BA4;
  else
    return self.priority > _id_63803077B6413BA4;
}

_id_5EE32A2DA994AFAB(struct) {
  if(!isDefined(struct._id_7D2852D02216C876._id_3968DE209A1C2B97))
    struct._id_7D2852D02216C876._id_3968DE209A1C2B97 = 0;

  struct._id_7D2852D02216C876._id_3968DE209A1C2B97++;
  _id_AC0E594AC96AA3A8 = self.vo_queue.size;

  for(;;) {
    if(_id_AC0E594AC96AA3A8 == 0 || self.vo_queue[_id_AC0E594AC96AA3A8 - 1].priority >= struct.priority) {
      self.vo_queue[_id_AC0E594AC96AA3A8] = struct;
      return;
    }

    self.vo_queue[_id_AC0E594AC96AA3A8] = self.vo_queue[_id_AC0E594AC96AA3A8 - 1];
    _id_AC0E594AC96AA3A8--;
  }
}

_id_4866DAF9001CDB5F(struct) {
  found = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.vo_queue.size; _id_AC0E594AC96AA3A8++) {
    if(found) {
      self.vo_queue[_id_AC0E594AC96AA3A8 - 1] = self.vo_queue[_id_AC0E594AC96AA3A8];
      continue;
    }

    if(self.vo_queue[_id_AC0E594AC96AA3A8] == struct)
      found = 1;
  }

  if(found)
    self.vo_queue[self.vo_queue.size - 1] = undefined;

  if(isDefined(struct._id_7D2852D02216C876) && isDefined(struct._id_7D2852D02216C876._id_3968DE209A1C2B97))
    struct._id_7D2852D02216C876._id_3968DE209A1C2B97--;
}

_id_797820CAD48747EF(_id_5564A66C3EC1C07B) {
  _id_AC0E594AC96AA3A8 = self._id_261AAF24A09D231D.size;

  for(;;) {
    if(_id_AC0E594AC96AA3A8 == 0 || isalive(self._id_261AAF24A09D231D[_id_AC0E594AC96AA3A8 - 1]._id_7D2852D02216C876) && isDefined(self._id_261AAF24A09D231D[_id_AC0E594AC96AA3A8 - 1].priority) && self._id_261AAF24A09D231D[_id_AC0E594AC96AA3A8 - 1].priority >= _id_5564A66C3EC1C07B.priority) {
      self._id_261AAF24A09D231D[_id_AC0E594AC96AA3A8] = _id_5564A66C3EC1C07B;
      return;
    }

    self._id_261AAF24A09D231D[_id_AC0E594AC96AA3A8] = self._id_261AAF24A09D231D[_id_AC0E594AC96AA3A8 - 1];
    _id_AC0E594AC96AA3A8--;
  }
}

remove_vo_data(_id_5564A66C3EC1C07B) {
  if(!isDefined(self) || !isDefined(self._id_261AAF24A09D231D)) {
    return;
  }
  found = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_261AAF24A09D231D.size; _id_AC0E594AC96AA3A8++) {
    if(found) {
      self._id_261AAF24A09D231D[_id_AC0E594AC96AA3A8 - 1] = self._id_261AAF24A09D231D[_id_AC0E594AC96AA3A8];
      continue;
    }

    if(self._id_261AAF24A09D231D[_id_AC0E594AC96AA3A8] == _id_5564A66C3EC1C07B)
      found = 1;
  }

  if(found)
    self._id_261AAF24A09D231D[self._id_261AAF24A09D231D.size - 1] = undefined;
}

_id_028E38EEFD3CC4AB() {
  if(!isDefined(level._id_60DF2B6C3887B3EB))
    level._id_60DF2B6C3887B3EB = [];

  if(isDefined(self.team) && !isDefined(level._id_60DF2B6C3887B3EB[self.team]))
    level._id_60DF2B6C3887B3EB[self.team] = spawnStruct();

  _id_9A4096E3A9B92412 = [];
  _id_9A4096E3A9B92412["self"] = _id_A940EFAE252424C5();

  if(isDefined(self.team))
    _id_9A4096E3A9B92412["team"] = level._id_60DF2B6C3887B3EB[self.team] _id_A940EFAE252424C5();

  _id_9A4096E3A9B92412["global"] = level _id_A940EFAE252424C5();
  return _id_9A4096E3A9B92412;
}

_id_A940EFAE252424C5() {
  if(!isDefined(self._id_261AAF24A09D231D))
    self._id_261AAF24A09D231D = [];

  if(!isDefined(self.vo_queue))
    self.vo_queue = [];

  return self;
}

_id_4FBA9E11EE207D7C(alias) {
  return lookupsoundlength(alias, 1) / 1000;
}

_id_6D4C7D2BD5969057(dialogue) {
  animname = scripts\engine\utility::ter_op(isDefined(self.animname), self.animname, "generic");

  if(!isDefined(level.scr_face) || !isDefined(level.scr_face[animname])) {
    return;
  }
  if(isDefined(level.scr_face[animname][dialogue]))
    return level.scr_face[animname][dialogue];
}

_id_5BAEBD9837531E1F(alias, _id_5C1322185369EFCD) {
  if(!isarray(_id_5C1322185369EFCD))
    _id_5C1322185369EFCD = [_id_5C1322185369EFCD];

  wait 0.1;

  foreach(receiver in _id_5C1322185369EFCD) {
    if(scripts\engine\utility::is_dead_or_dying(receiver) || receiver == self) {
      continue;
    }
    receiver playcontextsound(alias, "dx_type", "dx_radio_3d");
  }
}

_id_F5EB5B4D0E6714AA(tag, _id_1E2F2224127D2990, anglesoffset, _id_AC180CEB6DC3C95B) {
  if(!isDefined(self._id_63FDBDDD04BE9F53))
    self._id_63FDBDDD04BE9F53 = _id_3A8815118A9B0D69(tag, _id_1E2F2224127D2990, anglesoffset, _id_AC180CEB6DC3C95B);

  return self._id_63FDBDDD04BE9F53;
}

_id_3A8815118A9B0D69(tag, _id_1E2F2224127D2990, anglesoffset, _id_AC180CEB6DC3C95B) {
  if(isent(self)) {
    if(self tagexists("j_head"))
      tag = scripts\engine\utility::_id_53C4C53197386572(tag, "j_head");

    _id_1E2F2224127D2990 = scripts\engine\utility::_id_53C4C53197386572(_id_1E2F2224127D2990, (0, 0, 0));
    anglesoffset = scripts\engine\utility::_id_53C4C53197386572(anglesoffset, (0, 0, 0));
    _id_93FA9B11F85EC1A9 = spawn("script_origin", self.origin);

    if(isDefined(tag))
      _id_93FA9B11F85EC1A9 linkTo(self, tag, _id_1E2F2224127D2990, anglesoffset);
    else
      _id_93FA9B11F85EC1A9 linkTo(self);
  } else {
    _id_93FA9B11F85EC1A9 = spawn("script_origin", (0, 0, 0));
    _id_93FA9B11F85EC1A9._id_CBC44E3AB4FE0707 = 1;
    _id_93FA9B11F85EC1A9.name = self.name;
  }

  _id_93FA9B11F85EC1A9._id_58522807BCE24C1C = 1;
  _id_93FA9B11F85EC1A9.team = scripts\engine\utility::_id_53C4C53197386572(self.team, "allies");
  _id_93FA9B11F85EC1A9._id_87D26AB52F61FA8B = _id_AC180CEB6DC3C95B;

  if(!isDefined(level._id_A5A7AD116F37F360))
    level._id_A5A7AD116F37F360 = [];

  level._id_A5A7AD116F37F360[level._id_A5A7AD116F37F360.size] = _id_93FA9B11F85EC1A9;
  return _id_93FA9B11F85EC1A9;
}

_id_52846CD9B5EFEAFE(tag, _id_1E2F2224127D2990, anglesoffset, _id_AC180CEB6DC3C95B) {
  if(!isDefined(self._id_4413114D1D17278B)) {
    origin = scripts\engine\utility::_id_53C4C53197386572(self.origin, _id_1E2F2224127D2990);
    self._id_4413114D1D17278B = spawn("script_origin", origin);

    if(isent(self)) {
      if(self tagexists("j_hip_ri"))
        tag = scripts\engine\utility::_id_53C4C53197386572(tag, "j_hip_ri");

      _id_1E2F2224127D2990 = scripts\engine\utility::_id_53C4C53197386572(_id_1E2F2224127D2990, (0, 0, 0));
      anglesoffset = scripts\engine\utility::_id_53C4C53197386572(anglesoffset, (0, 0, 0));

      if(isDefined(tag))
        self._id_4413114D1D17278B linkTo(self, tag, _id_1E2F2224127D2990, anglesoffset);
      else
        self._id_4413114D1D17278B linkTo(self);
    }

    self._id_4413114D1D17278B._id_ED56B39B72558E56 = 1;
    self._id_4413114D1D17278B.battlechatterallowed = 1;
    self._id_4413114D1D17278B.team = scripts\engine\utility::_id_53C4C53197386572(self.team, "allies");
    self._id_4413114D1D17278B.battlechatter = spawnStruct();

    if(isDefined(self.battlechatter))
      self._id_4413114D1D17278B.battlechatter.countryid = self.battlechatter.countryid;

    self._id_4413114D1D17278B._id_87D26AB52F61FA8B = _id_AC180CEB6DC3C95B;
  }

  return self._id_4413114D1D17278B;
}

get_radio_alias(alias) {
  return alias;
}

_id_3E5D12EB11D543A2(_id_93FA9B11F85EC1A9) {
  if(!isDefined(_id_93FA9B11F85EC1A9)) {
    return;
  }
  _id_93FA9B11F85EC1A9 endon("entitydeleted");
  waittillframeend;

  if(!isDefined(self._id_E5CF232129F9EC01) && isDefined(_id_93FA9B11F85EC1A9))
    _id_93FA9B11F85EC1A9 stopsounds();
}

_id_690CCAE4E694F51E(_id_93FA9B11F85EC1A9) {
  if(!isDefined(_id_93FA9B11F85EC1A9) || _id_93FA9B11F85EC1A9 == self || !istrue(_id_93FA9B11F85EC1A9._id_87D26AB52F61FA8B)) {
    return;
  }
  _id_93FA9B11F85EC1A9._id_7712019717126CB1 = 1;
  _id_93FA9B11F85EC1A9 endon("entitydeleted");
  waitframe();

  if(istrue(_id_93FA9B11F85EC1A9._id_7712019717126CB1))
    _id_93FA9B11F85EC1A9 delete();
}

_id_C0AF485270DE3FBF(text) {
  setdvarifuninitialized("dvar_CE3D6E5D48671653", 1);
  return getdvarint("dvar_CE3D6E5D48671653") && (isistring(text) || !soundexists(text) && getsubstr(text, 0, 3) != "dx_");
  return 0;
}

_id_FB381A52CC8F3784(_id_BCABC3998E6C48BF, _id_BCA6D5998E66477E) {
  _id_BCABC3998E6C48BF = scripts\engine\utility::_id_53C4C53197386572(_id_BCABC3998E6C48BF, 1);
  _id_BCA6D5998E66477E = scripts\engine\utility::_id_53C4C53197386572(_id_BCA6D5998E66477E, 0);
  level._id_A16D55725FEBA235 = _id_BCABC3998E6C48BF;
  level._id_A1682F725FE525CC = _id_BCA6D5998E66477E;

  if(!_id_BCABC3998E6C48BF && !_id_BCA6D5998E66477E) {
    return;
  }
  if(!isDefined(level._id_261AAF24A09D231D)) {
    return;
  }
  foreach(_id_5564A66C3EC1C07B in level._id_261AAF24A09D231D) {
    _id_7D2852D02216C876 = _id_5564A66C3EC1C07B._id_7D2852D02216C876;

    if(_id_7D2852D02216C876._id_EC9F57E7698BAFFB < 0) {
      if(_id_BCABC3998E6C48BF)
        _id_7D2852D02216C876 notify("stop_2d_text");

      if(_id_BCA6D5998E66477E)
        _id_7D2852D02216C876 notify("stop_3d_text");
    }
  }
}

_id_1B22B2D53BA5B092(text, duration) {
  self endon("death");
  self endon("stop_dialogue");
  self notify("stop_3d_text");
  self endon("stop_3d_text");
  alpha = 1;

  while(!isDefined(duration) || duration + 0.3 > 0) {
    if(self tagexists("j_head"))
      origin = self gettagorigin("j_head") + (0, 0, 15);
    else
      origin = self.origin + (0, 0, 70);

    if(isDefined(duration) && duration < 0)
      alpha = 1 - duration * -1 / 0.3;

    if(isDefined(duration))
      duration = duration - 0.05;

    waitframe();
  }
}

_id_F9E725C7FD059300(text) {
  _id_A727023AFA3213A1 = strtok(text, " ").size;
  return max(1.5, _id_A727023AFA3213A1 * 0.3);
}

_id_932C63C904570806(text) {
  self notify("stop_dialogue");
  self endon("death");
  self endon("stop_dialogue");
  _id_93FA9B11F85EC1A9 = self;
  player = undefined;

  if(isPlayer(self))
    player = self;

  if(isDefined(player) || isDefined(self._id_63FDBDDD04BE9F53))
    _id_93FA9B11F85EC1A9 = _id_F5EB5B4D0E6714AA();

  self._id_E5CF232129F9EC01 = gettime();
  self._id_800206351D64E3F4 = text;
  self._id_88502EB1E08DFC4D = undefined;
  holdtime = _id_F9E725C7FD059300(text);
  color = _id_1F6B853C415CB9C1();
  name = get_name();

  if(!isistring(text) && isstartstr(text, ">>"))
    text = "(RADIO) " + getsubstr(text, 2, text.size);
  else if(!istrue(level._id_A1682F725FE525CC) || self._id_EC9F57E7698BAFFB >= 0)
    thread _id_1B22B2D53BA5B092(text, holdtime);

  _id_5A127677FB14F8C2 = istrue(level._id_A16D55725FEBA235) && self._id_EC9F57E7698BAFFB < 0;

  if(_id_5A127677FB14F8C2 || !scripts\common\utility::issp()) {
    wait(holdtime);
    return 1;
  }

  _id_B54520C420443A7C = int(6.96);
  _id_CA02086954972024 = int(17.4);
  _id_7794FDD4649E6D7F = int(5.075);
  _id_DDFEFF0EFA1CD0C4 = 0;

  if(isDefined(level._id_ACE32B0108A3E1F1) && isDefined(level._id_ACE32B0108A3E1F1[text])) {
    lines = [level._id_ACE32B0108A3E1F1[text]];
    _id_DDFEFF0EFA1CD0C4 = 1;
  } else {
    text = color + name + ": ^7" + text;
    lines = scripts\engine\utility::wrap_text(text, int(500 / _id_B54520C420443A7C));
  }

  width = int(clamp(text.size * _id_B54520C420443A7C, 0, 500));
  height = _id_CA02086954972024 * lines.size + _id_7794FDD4649E6D7F;
  _id_688F98559BF04F9D = scripts\engine\utility::_id_53C4C53197386572(level._id_033A0B6852D7FF0D, 300) - height;

  if(!isDefined(level._id_94AD130EEA50B708))
    level._id_94AD130EEA50B708 = [];

  foreach(_id_CD8195C935C24CCC in level._id_94AD130EEA50B708) {
    _id_CD8195C935C24CCC moveovertime(0.2);
    _id_CD8195C935C24CCC.y = _id_CD8195C935C24CCC.y - (height - 2);
  }

  _id_B64928813A4EC80D = [];

  foreach(_id_AC0E594AC96AA3A8, _id_AFE3CA01808D2595 in lines) {
    _id_DB39AC342B5F8704 = newhudelem();
    _id_DB39AC342B5F8704._id_7D2852D02216C876 = self;
    _id_DB39AC342B5F8704.alpha = 0;

    if(_id_DDFEFF0EFA1CD0C4) {
      _id_DB39AC342B5F8704.label = _id_AFE3CA01808D2595;

      if(isDefined(self._id_8284C960AB37A90D) && isistring(self._id_8284C960AB37A90D))
        _id_DB39AC342B5F8704 settext(self._id_8284C960AB37A90D);
      else
        _id_DB39AC342B5F8704 settext(&"DIALOGUE_TEMP/NAME_TEST");
    } else
      _id_DB39AC342B5F8704 settext(_id_AFE3CA01808D2595);

    _id_DB39AC342B5F8704.fontscale = 0.6525;
    _id_DB39AC342B5F8704.font = "bigfixed";
    _id_DB39AC342B5F8704._id_CB89110314447B2F = _id_AC0E594AC96AA3A8;
    _id_DB39AC342B5F8704 _id_866A3B95A50AA7C2(height, _id_688F98559BF04F9D, _id_CA02086954972024, _id_7794FDD4649E6D7F);
    _id_B64928813A4EC80D[_id_B64928813A4EC80D.size] = _id_DB39AC342B5F8704;
  }

  bg = newhudelem();
  bg.alpha = 0;
  bg setshader("black", width, height);
  bg _id_866A3B95A50AA7C2(height, _id_688F98559BF04F9D);
  _id_B64928813A4EC80D[_id_B64928813A4EC80D.size] = bg;
  level._id_94AD130EEA50B708 = scripts\engine\utility::array_combine(level._id_94AD130EEA50B708, _id_B64928813A4EC80D);
  end_time = gettime() + (0.2 + holdtime) * 1000;
  thread _id_F149AFDD57E23278(_id_B64928813A4EC80D, holdtime);
  self waittill("text_display_done", _id_0F5E6316C2383F5F);

  if(isDefined(_id_0F5E6316C2383F5F) && _id_0F5E6316C2383F5F == 0) {
    _id_825E9D34BB2B5E69 = (end_time - gettime()) / 1000;

    if(_id_825E9D34BB2B5E69 > 0)
      wait(_id_825E9D34BB2B5E69);

    _id_0F5E6316C2383F5F = 1;
  }

  return _id_0F5E6316C2383F5F;
}

_id_1F6B853C415CB9C1(team) {
  team = scripts\engine\utility::_id_53C4C53197386572(team, self.team);
  team = scripts\engine\utility::_id_53C4C53197386572(team, "neutral");

  if(isstartstr(team, "team_"))
    return "^1";

  switch (team) {
    case "axis":
      return "^1";
    case "neutral":
    case "allies":
      return "^2";
    default:
      return "^3";
  }
}

get_name() {
  if(isDefined(self.name))
    return self.name;

  if(isDefined(self.ainame))
    return self.ainame;
  else if(isPlayer(self))
    return "Player";

  team = scripts\engine\utility::_id_53C4C53197386572(self.team, "neutral");

  if(isDefined(level._id_FB9CAB687C8A7C70) && isDefined(level._id_FB9CAB687C8A7C70[team]))
    return level._id_FB9CAB687C8A7C70[team];

  if(isstartstr(team, "team_"))
    return "Enemy";

  switch (self.team) {
    case "axis":
      return "Enemy";
    case "allies":
      return "Friendly";
    default:
      return "Civilian";
  }
}

_id_866A3B95A50AA7C2(height, _id_688F98559BF04F9D, _id_CA02086954972024, _id_7794FDD4649E6D7F) {
  self.alignx = "center";
  self.aligny = "top";
  self.x = 320;
  self.y = 300 + height;
  self.sort = 5;

  if(isDefined(self._id_CB89110314447B2F))
    self.y = self.y + (self._id_CB89110314447B2F * _id_CA02086954972024 + _id_7794FDD4649E6D7F);

  self fadeovertime(0.2);

  if(isDefined(self._id_CB89110314447B2F)) {
    self.y = _id_688F98559BF04F9D + self._id_CB89110314447B2F * _id_CA02086954972024 + _id_7794FDD4649E6D7F;
    self.alpha = 1;
  } else {
    self.y = _id_688F98559BF04F9D;
    self.alpha = scripts\engine\utility::_id_53C4C53197386572(level._id_97E909FED3AB1904, 0);
  }
}

_id_F149AFDD57E23278(_id_B64928813A4EC80D, holdtime) {
  _id_0F5E6316C2383F5F = _id_C0F47BF696BD27AC(0.2 + holdtime);
  self notify("text_display_done", _id_0F5E6316C2383F5F);

  foreach(_id_CD8195C935C24CCC in _id_B64928813A4EC80D) {
    _id_CD8195C935C24CCC fadeovertime(0.3);
    _id_CD8195C935C24CCC.alpha = 0;
  }

  wait 0.3;
  level._id_94AD130EEA50B708 = scripts\engine\utility::array_remove_array(level._id_94AD130EEA50B708, _id_B64928813A4EC80D);

  if(!level._id_94AD130EEA50B708.size)
    level._id_94AD130EEA50B708 = undefined;

  foreach(_id_CD8195C935C24CCC in _id_B64928813A4EC80D)
  _id_CD8195C935C24CCC destroy();
}

_id_C0F47BF696BD27AC(holdtime) {
  self endon("death");
  self endon("stop_dialogue");
  return scripts\engine\utility::waittill_notify_or_timeout_return("stop_2d_text", holdtime) == "timeout";
}

_id_000407745805F870(nags, _id_4B0C85BEEE0DF862, _id_FCD35B6807F1776F, _id_206CA980A28E3343) {
  self notify("stop_nag_loop");
  self endon("death");
  self endon("stop_nag_loop");
  _id_FCD35B6807F1776F = scripts\engine\utility::_id_53C4C53197386572(_id_FCD35B6807F1776F, _id_4B0C85BEEE0DF862);

  if(!isDefined(level._id_A36DE4031E866CE5))
    level _id_746D94AC5ED3EE5C();

  if(isarray(nags))
    nags = scripts\engine\utility::create_deck(nags, 1, 0);

  _id_305EDDCDFB20B45D(nags, _id_FCD35B6807F1776F);

  for(nag_count = 1; !isDefined(_id_206CA980A28E3343) || nag_count / nags.items.size < _id_206CA980A28E3343; nag_count++) {
    _id_305EDDCDFB20B45D(nags, _id_4B0C85BEEE0DF862);
    waitframe();
  }

  self notify("finished_nag_loop");
}

_id_305EDDCDFB20B45D(nags, delay) {
  _id_7D2852D02216C876 = self;
  _id_3089D38B926BEB3B = 0;
  current = undefined;
  nag = nags scripts\engine\utility::deck_draw();

  if(isarray(nag)) {
    _id_7D2852D02216C876 = nag[0];
    nag = nag[1];
  }

  if(!isDefined(_id_7D2852D02216C876)) {
    return;
  }
  if(isstruct(delay))
    current = delay.current;

  result = _id_7D2852D02216C876 _id_B0FDDB86A2358953(delay);

  if(!isDefined(result) || result) {
    _id_9080A00567019B53 = scripts\engine\utility::_id_53C4C53197386572(self._id_A36DE4031E866CE5, level._id_A36DE4031E866CE5);
    _id_3089D38B926BEB3B = _id_7D2852D02216C876 say(nag, _id_9080A00567019B53.priority, _id_9080A00567019B53.timeout, _id_9080A00567019B53._id_F6E387B9F5A2B39C, ::_id_51FBC4B28A257C3B, _id_9080A00567019B53.scope);
  }

  if(!isDefined(_id_3089D38B926BEB3B))
    result = "interrupted";
  else if(_id_3089D38B926BEB3B)
    result = "finished";
  else {
    result = "failed";
    nags.index--;

    if(isstruct(delay))
      delay.current = current;
  }

  _id_7D2852D02216C876 notify("nag_" + result, nag);
  _id_7D2852D02216C876 notify("nag_done_or_cancelled", nag, result);
}

_id_51FBC4B28A257C3B() {
  self notify("started_nag", self._id_88502EB1E08DFC4D);

  if(isDefined(self._id_23471685B065B4AD))
    self thread[[self._id_23471685B065B4AD]]();

  if(isDefined(level._id_23471685B065B4AD))
    level thread[[level._id_23471685B065B4AD]]();
}