/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_quickmessages.gsc
************************************************/

func_00D5() {
  game["menu_quickcommands"] = "quickcommands";
  game["menu_quickstatements"] = "quickstatements";
  game["menu_quickresponses"] = "quickresponses";
  precacheheadicon("talkingicon");
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

func_7892(param_00) {
  self endon("disconnect");
  if(!isDefined(self.var_012C["team"]) || self.var_012C["team"] == "spectator" || isDefined(self.var_8F67)) {
    return;
  }

  self.var_8F67 = 1;
  switch (param_00) {
    case "1":
      var_01 = "mp_cmd_followme";
      var_02 = &"QUICKMESSAGE_FOLLOW_ME";
      break;

    case "2":
      var_01 = "mp_cmd_movein";
      var_02 = &"QUICKMESSAGE_MOVE_IN";
      break;

    case "3":
      var_01 = "mp_cmd_fallback";
      var_02 = &"QUICKMESSAGE_FALL_BACK";
      break;

    case "4":
      var_01 = "mp_cmd_suppressfire";
      var_02 = &"QUICKMESSAGE_SUPPRESSING_FIRE";
      break;

    case "5":
      var_01 = "mp_cmd_attackleftflank";
      var_02 = &"QUICKMESSAGE_ATTACK_LEFT_FLANK";
      break;

    case "6":
      var_01 = "mp_cmd_attackrightflank";
      var_02 = &"QUICKMESSAGE_ATTACK_RIGHT_FLANK";
      break;

    case "7":
      var_01 = "mp_cmd_holdposition";
      var_02 = &"QUICKMESSAGE_HOLD_THIS_POSITION";
      break;

    default:
      var_01 = "mp_cmd_regroup";
      var_02 = &"QUICKMESSAGE_REGROUP";
      break;
  }

  func_8069();
  func_329E(var_01, var_02);
  wait(2);
  self.var_8F67 = undefined;
  func_7DF2();
}

func_789C(param_00) {
  if(!isDefined(self.var_012C["team"]) || self.var_012C["team"] == "spectator" || isDefined(self.var_8F67)) {
    return;
  }

  self.var_8F67 = 1;
  switch (param_00) {
    case "1":
      var_01 = "mp_stm_enemyspotted";
      var_02 = &"QUICKMESSAGE_ENEMY_SPOTTED";
      break;

    case "2":
      var_01 = "mp_stm_enemiesspotted";
      var_02 = &"QUICKMESSAGE_ENEMIES_SPOTTED";
      break;

    case "3":
      var_01 = "mp_stm_iminposition";
      var_02 = &"QUICKMESSAGE_IM_IN_POSITION";
      break;

    case "4":
      var_01 = "mp_stm_areasecure";
      var_02 = &"QUICKMESSAGE_AREA_SECURE";
      break;

    case "5":
      var_01 = "mp_stm_watchsix";
      var_02 = &"QUICKMESSAGE_WATCH_SIX";
      break;

    case "6":
      var_01 = "mp_stm_sniper";
      var_02 = &"QUICKMESSAGE_SNIPER";
      break;

    default:
      var_01 = "mp_stm_needreinforcements";
      var_02 = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
      break;
  }

  func_8069();
  func_329E(var_01, var_02);
  wait(2);
  self.var_8F67 = undefined;
  func_7DF2();
}

func_7896(param_00) {
  if(!isDefined(self.var_012C["team"]) || self.var_012C["team"] == "spectator" || isDefined(self.var_8F67)) {
    return;
  }

  self.var_8F67 = 1;
  switch (param_00) {
    case "1":
      var_01 = "mp_rsp_yessir";
      var_02 = &"QUICKMESSAGE_YES_SIR";
      break;

    case "2":
      var_01 = "mp_rsp_nosir";
      var_02 = &"QUICKMESSAGE_NO_SIR";
      break;

    case "3":
      var_01 = "mp_rsp_onmyway";
      var_02 = &"QUICKMESSAGE_IM_ON_MY_WAY";
      break;

    case "4":
      var_01 = "mp_rsp_sorry";
      var_02 = &"QUICKMESSAGE_SORRY";
      break;

    case "5":
      var_01 = "mp_rsp_greatshot";
      var_02 = &"QUICKMESSAGE_GREAT_SHOT";
      break;

    default:
      var_01 = "mp_rsp_comeon";
      var_02 = &"QUICKMESSAGE_COME_ON";
      break;
  }

  func_8069();
  func_329E(var_01, var_02);
  wait(2);
  self.var_8F67 = undefined;
  func_7DF2();
}

func_329E(param_00, param_01) {
  if(self.var_0178 != "playing") {
    return;
  }

  var_02 = [[level.var_46D9]](self.var_01A7);
  if(isDefined(level.var_7895) && level.var_7895) {
    self.var_00BB = "none";
    self.var_00BA = "talkingicon";
    self method_8617(var_02 + param_00);
    self sayall(param_01);
    return;
  }

  if(self.var_0179 == "allies") {
    self.var_00BB = "allies";
  } else if(self.var_0179 == "axis") {
    self.var_00BB = "axis";
  }

  self.var_00BA = "talkingicon";
  self method_8617(var_02 + param_00);
  self sayteam(param_01);
  self pingplayer();
}

func_8069() {
  if(isDefined(self.var_00BA)) {
    self.var_6A5A = self.var_00BA;
  }

  if(isDefined(self.var_00BB)) {
    self.var_6A5B = self.var_00BB;
  }
}

func_7DF2() {
  if(isDefined(self.var_6A5A)) {
    self.var_00BA = self.var_6A5A;
  }

  if(isDefined(self.var_6A5B)) {
    self.var_00BB = self.var_6A5B;
  }
}