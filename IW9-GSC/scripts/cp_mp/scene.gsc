/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\scene.gsc
***********************************************/

_id_683AEFB412AF1596() {
  if(getdvarint("r_reflectionprobegenerate")) {
    return;
  }
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Player", "shotObjectPlayAnim", ::_id_5FD2B7D3C29F131B);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Player", "objectSpawn", ::player_spawn);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Player", "objectSetAnimName", ::_id_24B6B2BFC5BDAB36);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Player", "objectDelete", ::_id_76B8DB54C4FD325E);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Actor", "objectSpawn", ::_id_95C579445E1097CA);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Actor", "objectMatchEntity", ::_id_12F50A9B21B4DD9A);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Actor", "objectDelete", ::_id_4EFD74883670AF4C);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Actor", "objectGetAnimEntity", ::_id_286624909FB93C57);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Object", "shotObjectPlayAnim", ::_id_70BD06355933AEC9);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Object", "shotObjectStopAnim", ::_id_CC538C3233D741AF);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Object", "shotObjectFirstFrame", ::_id_8BAC7EDF73A29D6B);
  _id_72A196B6C7DF2F38::_id_7855EC4CAF5901F9("Object", "objectTeleport", ::_id_E8800B55F7CBD5A4);
}

_id_5FD2B7D3C29F131B(notifystring, _id_BAE27D121B581202, _id_4F3089070D8B1E24, _id_866B3A3066122E39, _id_D180B535A33B044D, _id_20C476D355EBEC07, _id_A326F793BDAF5565) {
  _id_214D924F4E137244 = self;
  player = _id_214D924F4E137244.entity;

  if(!isPlayer(player)) {
    return;
  }
  player notify("scene_play_anim");
  _id_214D924F4E137244 notify("scene_play_anim");
  _id_2E2A2F75FD49152A = getanimname(_id_4F3089070D8B1E24);
  _id_870CC477AC78706C = getanimlength(_id_4F3089070D8B1E24);
  player setOrigin(_id_BAE27D121B581202.origin);
  player setplayerangles(_id_BAE27D121B581202.angles);
  player playanimscriptsceneevent("scripted_scene", _id_2E2A2F75FD49152A);
  wait(_id_870CC477AC78706C);
  return _id_870CC477AC78706C;
}

player_spawn(spawnorigin, spawnangles) {
  _id_214D924F4E137244 = self;
  return level.players[0];
}

_id_24B6B2BFC5BDAB36(animname, animtree) {
  _id_214D924F4E137244 = self;
}

_id_76B8DB54C4FD325E() {}

_id_95C579445E1097CA(spawnorigin, spawnangles) {
  _id_214D924F4E137244 = self;

  if(isDefined(_id_214D924F4E137244._id_9BE58C68789FAF5C._id_CF0D4D8CC5AC99A4._id_39A06A790CAF5608)) {
    _id_373A2C3B02B1D81C = "aitype";
    _id_6FC4D2978CF27BEF = _id_214D924F4E137244._id_9BE58C68789FAF5C._id_CF0D4D8CC5AC99A4._id_39A06A790CAF5608;
  } else if(isDefined(_id_214D924F4E137244._id_9BE58C68789FAF5C._id_CF0D4D8CC5AC99A4._id_E4024BD5BBBD291F)) {
    _id_373A2C3B02B1D81C = "character";
    _id_6FC4D2978CF27BEF = _id_214D924F4E137244._id_9BE58C68789FAF5C._id_CF0D4D8CC5AC99A4._id_E4024BD5BBBD291F;
  } else {
    _id_373A2C3B02B1D81C = "xmodel";
    _id_6FC4D2978CF27BEF = _id_214D924F4E137244._id_9BE58C68789FAF5C._id_CF0D4D8CC5AC99A4._id_4F08E017049AD3CB;
  }

  if(isDefined(_id_214D924F4E137244.entity)) {
    if(isagent(_id_214D924F4E137244.entity))
      _id_214D924F4E137244.entity despawnagent();
    else
      _id_214D924F4E137244.entity delete();
  }

  entity = undefined;

  if(_id_373A2C3B02B1D81C == "aitype") {
    _id_02EA49D6356F3AD8 = "team_eighty";
    entity = scripts\mp\mp_agent::spawnnewagentaitype(_id_6FC4D2978CF27BEF, spawnorigin, spawnangles, _id_02EA49D6356F3AD8);
    entity useanimtree(_id_214D924F4E137244._id_9BE58C68789FAF5C._id_CF0D4D8CC5AC99A4.animtree.id);
  }

  return entity;
}

_id_12F50A9B21B4DD9A(entity) {
  _id_214D924F4E137244 = self;
  return isagent(entity);
}

_id_286624909FB93C57() {
  _id_214D924F4E137244 = self;

  if(isagent(_id_214D924F4E137244.entity) && !isalive(_id_214D924F4E137244.entity))
    return undefined;

  return _id_214D924F4E137244.entity;
}

_id_4EFD74883670AF4C() {
  _id_214D924F4E137244 = self;

  if(isagent(_id_214D924F4E137244.entity)) {
    _id_214D924F4E137244.entity.nocorpse = 1;
    _id_214D924F4E137244.entity despawnagent();
  } else if(isDefined(_id_214D924F4E137244.entity))
    _id_214D924F4E137244.entity delete();
}

_id_70BD06355933AEC9(notifystring, _id_BAE27D121B581202, _id_4F3089070D8B1E24, _id_866B3A3066122E39, _id_D180B535A33B044D, _id_20C476D355EBEC07, _id_A326F793BDAF5565) {
  _id_214D924F4E137244 = self;
  entity = _id_214D924F4E137244.entity;

  if(!isDefined(entity)) {
    return;
  }
  _id_F4C57B09EA3F9539 = 0;
  done = 0;

  if(entity.model == "")
    return 0;

  entity notify("scene_play_anim");
  _id_214D924F4E137244 notify("scene_play_anim");

  if(isDefined(_id_214D924F4E137244._id_84B542BB7490BEA7._id_43286FD46706909C)) {
    _id_D180B535A33B044D = 0.0;
    _id_A326F793BDAF5565 = 0.0;
  }

  _id_2E2A2F75FD49152A = getanimname(_id_4F3089070D8B1E24);
  _id_72A196B6C7DF2F38::_id_E4FC30CCDCA08B9D(_id_BAE27D121B581202);
  entity stopuseanimtree();
  entity scriptmodelplayanimdeltamotionfrompos(_id_2E2A2F75FD49152A, _id_BAE27D121B581202.origin, _id_BAE27D121B581202.angles, notifystring, _id_866B3A3066122E39);

  if(isDefined(_id_866B3A3066122E39) && _id_866B3A3066122E39 > 0.0 && _id_866B3A3066122E39 <= 1.0)
    entity dontinterpolate();

  if(_id_866B3A3066122E39 < 1.0) {
    _id_214D924F4E137244 childthread _id_72A196B6C7DF2F38::_id_8E9F8E1FBE2B7AB4(notifystring, _id_4F3089070D8B1E24);
    entity waittillmatch(notifystring, "end");
  }

  _id_F4C57B09EA3F9539 = _id_F4C57B09EA3F9539 + getanimlength(_id_4F3089070D8B1E24);
  return _id_F4C57B09EA3F9539 - _id_866B3A3066122E39 * _id_F4C57B09EA3F9539;
}

_id_CC538C3233D741AF() {
  _id_214D924F4E137244 = self;

  if(isDefined(_id_214D924F4E137244.entity)) {
    _id_214D924F4E137244.entity scriptmodelclearanim();
    _id_214D924F4E137244.entity notify("stop_loop");
    _id_214D924F4E137244.entity notify("single anim", "end");
    _id_214D924F4E137244.entity notify("looping anim", "end");
    _id_214D924F4E137244.entity notify("stop_animmode");
  }
}

_id_8BAC7EDF73A29D6B(_id_BAE27D121B581202) {
  _id_214D924F4E137244 = self;

  if(isDefined(_id_214D924F4E137244.entity))
    _id_214D924F4E137244.entity scriptmodelclearanim();
}

_id_E8800B55F7CBD5A4(origin, angles) {
  _id_214D924F4E137244 = self;
  entity = _id_214D924F4E137244.entity;

  if(isDefined(entity)) {
    entity scriptmodelclearanim();

    if(isDefined(origin))
      entity.origin = origin;

    if(isDefined(angles))
      entity.angles = angles;
  }
}