/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3fb16506404e5493.gsc
***********************************************/

_id_237759A1F240D382() {
  if(istrue(level._id_B203A586F65AC136)) {
    return;
  }
  _id_4D9D174FBEE35B79();
  level._id_B203A586F65AC136 = 1;
}

_id_86403E1B6EC0B2F6(_id_F7E96D6052425187) {
  data = spawnStruct();
  data.player = self;
  data._id_42BB97B677759800 = _id_63B9F951B5057272(_id_F7E96D6052425187);
  data._id_7D41FD60BB145BDA = 1000;
  data._id_8C3C07D02DE9A304 = 1;
  data._id_0C999CC7A0D182B0 = 1;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("mobile_ftue_step_start", data);
}

_id_05B53803303E63EB(_id_F7E96D6052425187, _id_7D41FD60BB145BDA) {
  data = spawnStruct();
  data.player = self;
  data._id_42BB97B677759800 = _id_63B9F951B5057272(_id_F7E96D6052425187);
  data._id_7D41FD60BB145BDA = _id_7D41FD60BB145BDA;
  data._id_8C3C07D02DE9A304 = 1;
  data._id_0C999CC7A0D182B0 = 1;
  data.result = "SUCCESS";
  _id_4A6760982B403BAD::_id_80820D6D364C1836("mobile_ftue_step_finished", data);
}

_id_547D18417766045A(_id_401C3A2E68AAB0FD) {
  data = spawnStruct();
  data.player = self;
  data._id_401C3A2E68AAB0FD = _id_401C3A2E68AAB0FD;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("mobile_ftue_skip_contextual_tip", data);
}

_id_4D9D174FBEE35B79() {
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("mobile_ftue_step_start", ::_id_EA6F670B79578BA0);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("mobile_ftue_step_finished", ::_id_54DCA51D6309297A);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("mobile_ftue_step_single", ::_id_9BA5BFF1F30B7938);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("mobile_ftue_skip_contextual_tip", ::_id_FDABA2229EF7881C);
}

_id_EA6F670B79578BA0(data) {
  data.player dlog_recordplayerevent("dlog_event_mobile_ftue_step_start", _id_C86FF8CFC88B4677(data), 0);
}

_id_54DCA51D6309297A(data) {
  _id_5814D27874B48E54 = _id_C86FF8CFC88B4677(data);
  _id_5814D27874B48E54 = _id_7FADD2DC679F8F4C(_id_5814D27874B48E54, data);
  data.player dlog_recordplayerevent("dlog_event_mobile_ftue_step_finished", _id_5814D27874B48E54);
}

_id_9BA5BFF1F30B7938(data) {
  _id_5814D27874B48E54 = _id_C86FF8CFC88B4677(data);
  data.player dlog_recordplayerevent("dlog_event_mobile_ftue_step_start", _id_5814D27874B48E54);
  _id_5814D27874B48E54 = _id_7FADD2DC679F8F4C(_id_5814D27874B48E54, data);
  data.player dlog_recordplayerevent("dlog_event_mobile_ftue_step_finished", _id_5814D27874B48E54);
}

_id_FDABA2229EF7881C(data) {
  _id_5814D27874B48E54 = ["reason", data._id_401C3A2E68AAB0FD];
  data.player dlog_recordplayerevent("dlog_event_mobile_ftue_skip_contextual_tips", _id_5814D27874B48E54);
}

_id_C86FF8CFC88B4677(data) {
  _id_00AE17C5A8B1BC1B = data.player _id_23A85A6F3340BF6F::_id_217FAB64BECD170A();
  _id_A4C363F54F833920 = data.player _id_5C61825C1DCE3571::_id_7FBC76F1AEFC8FC5();
  _id_7D41FD60BB145BDA = 0;

  if(isDefined(data._id_7D41FD60BB145BDA))
    _id_7D41FD60BB145BDA = int(data._id_7D41FD60BB145BDA);

  return ["step_name", data._id_42BB97B677759800, "step_number", _id_7D41FD60BB145BDA, "tutorial_type", "GAME", "tutorial_expertise", _id_A4C363F54F833920, "mandatory_step", istrue(data._id_8C3C07D02DE9A304), "player_rank", _id_00AE17C5A8B1BC1B, "automatic", istrue(data._id_0C999CC7A0D182B0), "ftue_version", _id_5F15879FE297CE1E::_id_93F5074380E8C2B8(), "progress_version", 0];
}

_id_7FADD2DC679F8F4C(_id_88A0DCBEA6A169C2, data) {
  _id_88A0DCBEA6A169C2[_id_88A0DCBEA6A169C2.size] = "result";
  _id_88A0DCBEA6A169C2[_id_88A0DCBEA6A169C2.size] = data.result;
  return _id_88A0DCBEA6A169C2;
}

_id_63B9F951B5057272(_id_F7E96D6052425187) {
  return "ftue_match_" + _id_F7E96D6052425187;
}

_id_B1FF196D3899D7C4() {
  data = spawnStruct();
  data.player = self;
  data._id_42BB97B677759800 = "orientation_match";
  data._id_7D41FD60BB145BDA = 1000;
  data._id_8C3C07D02DE9A304 = 1;
  data._id_0C999CC7A0D182B0 = 1;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("mobile_ftue_step_start", data);
}

_id_9C335ACC44971F71() {
  data = spawnStruct();
  data.player = self;
  data._id_42BB97B677759800 = "orientation_match";
  data._id_7D41FD60BB145BDA = 1000;
  data._id_8C3C07D02DE9A304 = 1;
  data._id_0C999CC7A0D182B0 = 1;
  data.result = "SUCCESS";
  _id_4A6760982B403BAD::_id_80820D6D364C1836("mobile_ftue_step_finished", data);
}

_id_12F253484907A29D(_id_D0DE0DB1760B9C5B, _id_AC07EEE564E51C5F) {
  data = spawnStruct();
  data.player = self;
  data._id_42BB97B677759800 = _id_D0DE0DB1760B9C5B;
  data._id_7D41FD60BB145BDA = 1000;
  data._id_8C3C07D02DE9A304 = 1;
  data._id_0C999CC7A0D182B0 = 1;

  if(_id_AC07EEE564E51C5F == "mobile_ftue_step_single" || _id_AC07EEE564E51C5F == "mobile_ftue_step_finished")
    data.result = "SUCCESS";

  _id_4A6760982B403BAD::_id_80820D6D364C1836(_id_AC07EEE564E51C5F, data);
}

_id_7ACF4442545D6B26(_id_D0DE0DB1760B9C5B) {
  _id_12F253484907A29D(_id_D0DE0DB1760B9C5B, "mobile_ftue_step_start");
}

_id_7004AD4F3793CEDB(_id_D0DE0DB1760B9C5B) {
  _id_12F253484907A29D(_id_D0DE0DB1760B9C5B, "mobile_ftue_step_finished");
}

_id_42716045CDD993D1(_id_D0DE0DB1760B9C5B) {
  _id_12F253484907A29D(_id_D0DE0DB1760B9C5B, "mobile_ftue_step_single");
}

_id_767631661C482A58(_id_D0DE0DB1760B9C5B) {
  _id_5814D27874B48E54 = ["initialization_step", _id_D0DE0DB1760B9C5B];
  dlog_recordevent("dlog_event_mobile_ftue_contextual_tips_initialization", _id_5814D27874B48E54);
}