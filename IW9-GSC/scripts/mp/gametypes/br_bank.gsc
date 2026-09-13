/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_bank.gsc
***********************************************/

init() {
  level.br_bank_alarm_enabled = getdvarint("dvar_BBB179520C2C4A14", 0);

  if(!istrue(level.br_bank_alarm_enabled)) {
    return;
  }
  level._effect["poi_light_bank"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_light_bank.vfx");
  level.bankalltriggers = getEntArray("bank_entry_detector", "targetname");

  foreach(trigger in level.bankalltriggers) {
    if(!isDefined(trigger)) {
      continue;
    }
    trigger.playersinsidebank = 0;
    trigger.alarmstillplaying = 0;
    trigger.banklights = scripts\engine\utility::getStructArray(trigger.target, "targetname");
    trigger thread scripts\mp\utility\trigger::makeenterexittrigger(trigger, ::bankplayerentering, ::bankplayerexiting);
  }
}

bankplayerentering(player, _id_10B336BA132AD5F5) {
  if(!isDefined(_id_10B336BA132AD5F5)) {
    return;
  }
  _id_10B336BA132AD5F5.playersinsidebank = _id_10B336BA132AD5F5.playersinsidebank + 1;

  if(_id_10B336BA132AD5F5.playersinsidebank != 1) {
    return;
  }
  _id_10B336BA132AD5F5 thread bankturnonalarm();
}

bankplayerexiting(player, _id_10B336BA132AD5F5) {
  if(!isDefined(_id_10B336BA132AD5F5)) {
    return;
  }
  _id_10B336BA132AD5F5.playersinsidebank = max(_id_10B336BA132AD5F5.playersinsidebank - 1, 0);

  if(_id_10B336BA132AD5F5.playersinsidebank == 0)
    _id_10B336BA132AD5F5 thread bankturnoffalarm();
}

bankplunderdeposited() {
  if(!istrue(level.br_bank_alarm_enabled)) {
    return;
  }
  player = self;
  player notify("bankPlunderDeposited");
  player endon("bankPlunderDeposited");
  _id_8E204C4ACDB20D51 = scripts\engine\utility::getclosest(player.origin, level.bankalltriggers, 90000);

  if(!isDefined(_id_8E204C4ACDB20D51)) {
    return;
  }
  _id_8E204C4ACDB20D51 bankturnoffalarm();
  _id_B4A32387DBA557B9 = getdvarint("dvar_032EAB55FF865C3C", 15);
  wait(_id_B4A32387DBA557B9);

  if(_id_8E204C4ACDB20D51.playersinsidebank > 0)
    _id_8E204C4ACDB20D51 bankturnonalarm();
}

bankturnonalarm() {
  self notify("bank_alarm_triggered");
  _id_10B336BA132AD5F5 = self;
  _id_10B336BA132AD5F5.alarmstillplaying = 1;
  _id_10B336BA132AD5F5 playLoopSound("bank_alarm_lp");

  foreach(_id_3D1B95CC30175A75 in _id_10B336BA132AD5F5.banklights) {
    _id_72F11FB16A8128C8 = anglesToForward(_id_3D1B95CC30175A75.angles);
    _id_6ED3EEF0E424456E = anglestoup(_id_3D1B95CC30175A75.angles);
    _id_3D1B95CC30175A75.fx = spawnfx(level._effect["poi_light_bank"], _id_3D1B95CC30175A75.origin + _id_72F11FB16A8128C8 * 5, _id_72F11FB16A8128C8, _id_6ED3EEF0E424456E);
    triggerfx(_id_3D1B95CC30175A75.fx);
  }

  _id_50B6C105426B8E48 = getdvarint("dvar_5B11F68D6B008181", 5);
  wait(_id_50B6C105426B8E48);
  _id_10B336BA132AD5F5.alarmstillplaying = 0;

  if(_id_10B336BA132AD5F5.playersinsidebank == 0)
    _id_10B336BA132AD5F5 bankturnoffalarm();
}

bankturnoffalarm() {
  self endon("bank_alarm_triggered");
  _id_10B336BA132AD5F5 = self;

  if(_id_10B336BA132AD5F5.alarmstillplaying) {
    return;
  }
  wait 3;
  _id_10B336BA132AD5F5 stoploopsound();

  foreach(_id_3D1B95CC30175A75 in _id_10B336BA132AD5F5.banklights) {
    if(isDefined(_id_3D1B95CC30175A75.fx))
      _id_3D1B95CC30175A75.fx delete();
  }
}