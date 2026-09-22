/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_quickmessages.gsc
********************************************************/

init() {
  game["menu_quickcommands"] = "quickcommands";
  game["menu_quickstatements"] = "quickstatements";
  game["menu_quickresponses"] = "quickresponses";
  _precacheheadicon("talkingicon");
  precachestring(&"QUICKMESSAGE_FOLLOW_ME");
  precachestring(&"QUICKMESSAGE_MOVE_IN");
  precachestring(&"QUICKMESSAGE_FALL_BACK");
  precachestring(&"QUICKMESSAGE_SUPPRESSING_FIRE");
  precachestring(&"QUICKMESSAGE_ATTACK_LEFT_FLANK");
  precachestring(&"QUICKMESSAGE_ATTACK_RIGHT_FLANK");
  precachestring(&"QUICKMESSAGE_HOLD_THIS_POSITION");
  precachestring(&"QUICKMESSAGE_REGROUP");
  precachestring(&"QUICKMESSAGE_ENEMY_SPOTTED");
  precachestring(&"QUICKMESSAGE_ENEMIES_SPOTTED");
  precachestring(&"QUICKMESSAGE_IM_IN_POSITION");
  precachestring(&"QUICKMESSAGE_AREA_SECURE");
  precachestring(&"QUICKMESSAGE_GRENADE");
  precachestring(&"QUICKMESSAGE_SNIPER");
  precachestring(&"QUICKMESSAGE_NEED_REINFORCEMENTS");
  precachestring(&"QUICKMESSAGE_HOLD_YOUR_FIRE");
  precachestring(&"QUICKMESSAGE_YES_SIR");
  precachestring(&"QUICKMESSAGE_NO_SIR");
  precachestring(&"QUICKMESSAGE_IM_ON_MY_WAY");
  precachestring(&"QUICKMESSAGE_SORRY");
  precachestring(&"QUICKMESSAGE_GREAT_SHOT");
  precachestring(&"QUICKMESSAGE_TOOK_LONG_ENOUGH");
  precachestring(&"QUICKMESSAGE_ARE_YOU_CRAZY");
  precachestring(&"QUICKMESSAGE_WATCH_SIX");
  precachestring(&"QUICKMESSAGE_COME_ON");
}

_id_7892(var_0) {
  self endon("disconnect");

  if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator" || isDefined(self._id_8F67)) {
    return;
  }
  self._id_8F67 = 1;

  switch (var_0) {
    case "1":
      var_1 = "mp_cmd_followme";
      var_2 = &"QUICKMESSAGE_FOLLOW_ME";
      break;
    case "2":
      var_1 = "mp_cmd_movein";
      var_2 = &"QUICKMESSAGE_MOVE_IN";
      break;
    case "3":
      var_1 = "mp_cmd_fallback";
      var_2 = &"QUICKMESSAGE_FALL_BACK";
      break;
    case "4":
      var_1 = "mp_cmd_suppressfire";
      var_2 = &"QUICKMESSAGE_SUPPRESSING_FIRE";
      break;
    case "5":
      var_1 = "mp_cmd_attackleftflank";
      var_2 = &"QUICKMESSAGE_ATTACK_LEFT_FLANK";
      break;
    case "6":
      var_1 = "mp_cmd_attackrightflank";
      var_2 = &"QUICKMESSAGE_ATTACK_RIGHT_FLANK";
      break;
    case "7":
      var_1 = "mp_cmd_holdposition";
      var_2 = &"QUICKMESSAGE_HOLD_THIS_POSITION";
      break;
    default:
      var_1 = "mp_cmd_regroup";
      var_2 = &"QUICKMESSAGE_REGROUP";
      break;
  }

  clearthermalfog();
  _id_329E(var_1, var_2);
  wait 2;
  self._id_8F67 = undefined;
  _id_7DF2();
}

_id_789C(var_0) {
  if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator" || isDefined(self._id_8F67)) {
    return;
  }
  self._id_8F67 = 1;

  switch (var_0) {
    case "1":
      var_1 = "mp_stm_enemyspotted";
      var_2 = &"QUICKMESSAGE_ENEMY_SPOTTED";
      break;
    case "2":
      var_1 = "mp_stm_enemiesspotted";
      var_2 = &"QUICKMESSAGE_ENEMIES_SPOTTED";
      break;
    case "3":
      var_1 = "mp_stm_iminposition";
      var_2 = &"QUICKMESSAGE_IM_IN_POSITION";
      break;
    case "4":
      var_1 = "mp_stm_areasecure";
      var_2 = &"QUICKMESSAGE_AREA_SECURE";
      break;
    case "5":
      var_1 = "mp_stm_watchsix";
      var_2 = &"QUICKMESSAGE_WATCH_SIX";
      break;
    case "6":
      var_1 = "mp_stm_sniper";
      var_2 = &"QUICKMESSAGE_SNIPER";
      break;
    default:
      var_1 = "mp_stm_needreinforcements";
      var_2 = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
      break;
  }

  clearthermalfog();
  _id_329E(var_1, var_2);
  wait 2;
  self._id_8F67 = undefined;
  _id_7DF2();
}

_id_7896(var_0) {
  if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator" || isDefined(self._id_8F67)) {
    return;
  }
  self._id_8F67 = 1;

  switch (var_0) {
    case "1":
      var_1 = "mp_rsp_yessir";
      var_2 = &"QUICKMESSAGE_YES_SIR";
      break;
    case "2":
      var_1 = "mp_rsp_nosir";
      var_2 = &"QUICKMESSAGE_NO_SIR";
      break;
    case "3":
      var_1 = "mp_rsp_onmyway";
      var_2 = &"QUICKMESSAGE_IM_ON_MY_WAY";
      break;
    case "4":
      var_1 = "mp_rsp_sorry";
      var_2 = &"QUICKMESSAGE_SORRY";
      break;
    case "5":
      var_1 = "mp_rsp_greatshot";
      var_2 = &"QUICKMESSAGE_GREAT_SHOT";
      break;
    default:
      var_1 = "mp_rsp_comeon";
      var_2 = &"QUICKMESSAGE_COME_ON";
      break;
  }

  clearthermalfog();
  _id_329E(var_1, var_2);
  wait 2;
  self._id_8F67 = undefined;
  _id_7DF2();
}

_id_329E(var_0, var_1) {
  if(self.sessionstate != "playing") {
    return;
  }
  var_2 = [[level._id_46D9]](self.team);

  if(isDefined(level._id_7895) && level._id_7895) {
    self._id_00BB = "none";
    self._id_00BA = "talkingicon";
    self playSound(var_2 + var_0);
    self sayteam(var_1);
  } else {
    if(self._id_0179 == "allies") {
      self._id_00BB = "allies";
    } else if(self._id_0179 == "axis") {
      self._id_00BB = "axis";
    }

    self._id_00BA = "talkingicon";
    self playSound(var_2 + var_0);
    self sayall(var_1);
    self pingplayer();
  }
}

clearthermalfog() {
  if(isDefined(self._id_00BA)) {
    self._id_6A5A = self._id_00BA;
  }

  if(isDefined(self._id_00BB)) {
    self._id_6A5B = self._id_00BB;
  }
}

_id_7DF2() {
  if(isDefined(self._id_6A5A)) {
    self._id_00BA = self._id_6A5A;
  }

  if(isDefined(self._id_6A5B)) {
    self._id_00BB = self._id_6A5B;
  }
}