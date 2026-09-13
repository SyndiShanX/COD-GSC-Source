/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\hitmarker.gsc
***********************************************/

_id_A47FAE6CA49BC2B9(_id_F182D284B07A828E, _id_B3990D56E2779F79, iscivilian, _id_942B8C491D5D7BD1) {
  if(!isDefined(_id_B3990D56E2779F79))
    _id_B3990D56E2779F79 = 0;

  if(!isDefined(iscivilian))
    iscivilian = 0;

  if(!isDefined(_id_942B8C491D5D7BD1))
    _id_942B8C491D5D7BD1 = 0;

  alias = getDvar("snd_hitmarker_alias");

  if(_id_942B8C491D5D7BD1 && _id_B3990D56E2779F79)
    level.player playlocalsound("mp_kill_alert");
  else if(isDefined(_id_F182D284B07A828E))
    playsoundatpos(_id_F182D284B07A828E.origin, alias);
  else
    self playSound(alias);

  _id_02A968DDF3C277CE("standard", _id_B3990D56E2779F79, 0, iscivilian);
}

_id_02A968DDF3C277CE(_id_E0EA2C8DF06F13EB, _id_D7198CEB7D51DB5B, headshot, _id_C4F1516C772B1C2D, _id_DC382B1157307F94) {
  if(!isDefined(_id_E0EA2C8DF06F13EB)) {
    return;
  }
  if(!isDefined(_id_D7198CEB7D51DB5B))
    _id_D7198CEB7D51DB5B = 0;

  if(!isDefined(headshot))
    headshot = 0;

  if(!isDefined(_id_C4F1516C772B1C2D))
    _id_C4F1516C772B1C2D = 0;

  priority = _id_E133BFD0C1AB18C9(_id_E0EA2C8DF06F13EB);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !_id_D7198CEB7D51DB5B) {
    return;
  }
  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;

  if(isDefined(_id_DC382B1157307F94) && !istrue(_id_D7198CEB7D51DB5B)) {
    self setclientomnvar("damage_feedback_icon", _id_DC382B1157307F94);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  self setclientomnvar("damage_feedback", _id_E0EA2C8DF06F13EB);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(_id_D7198CEB7D51DB5B)
    self setclientomnvar("damage_feedback_kill", 1);
  else
    self setclientomnvar("damage_feedback_kill", 0);

  if(headshot)
    self setclientomnvar("damage_feedback_headshot", 1);
  else
    self setclientomnvar("damage_feedback_headshot", 0);

  if(_id_C4F1516C772B1C2D)
    self setclientomnvar("damage_feedback_nonplayer", 1);
  else
    self setclientomnvar("damage_feedback_nonplayer", 0);
}

_id_E133BFD0C1AB18C9(_id_B98146816886D3C4) {
  if(!isDefined(level.hitmarkerpriorities[_id_B98146816886D3C4]))
    return 0;

  return level.hitmarkerpriorities[_id_B98146816886D3C4];
}