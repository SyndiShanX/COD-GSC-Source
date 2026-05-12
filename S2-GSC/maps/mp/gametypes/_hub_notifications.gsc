/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hub_notifications.gsc
****************************************************/

monitorsocialrankup() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "social_rank_up") {
      continue;
    }

    if(var_01 == -1) {
      continue;
    }

    thread maps\mp\gametypes\_hud_message::func_9102("social_rank_up", var_01);
  }
}

monitorsocialmaxrankreward() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "social_max_rank_rewarded") {
      continue;
    }

    if(var_01 == -1) {
      continue;
    }

    function_03B8(var_01, 1);
  }
}

func_2541(param_00) {
  maps\mp\gametypes\_missions::func_7752("ch_daily_5");
  var_01 = self getrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "commends") + 1;
  self setrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "commends", var_01);
  maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hubSocialScore", "hubCommends"], var_01);
  maps\mp\gametypes\_hub_unk1::func_83DC("hubCommends", "hubSocialScore", 1, undefined, undefined);
  var_01 = param_00 getrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "commendations") + 1;
  param_00 setrankedplayerdata(common_scripts\utility::func_46AB(), "hubStats", "commendations", var_01);
  param_00 maps\mp\gametypes\_hub_unk1::func_84DE(["hubFeatureStats", "hubSocialScore", "hubCommendations"], var_01);
  param_00 maps\mp\gametypes\_hub_unk1::func_83DC("hubCommendations", "hubSocialScore", 1, undefined, undefined);
  self iclientprintln(&"HUB_YOU_COMMENDED_PLAYER", param_00.var_0109);
  param_00 iclientprintln(&"HUB_WERE_COMMENDED_BY", self.var_0109);
  param_00 giveachievement("recognition");
}

func_4AE0(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_existing_interacts");
  param_00 endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, var_02);
    if(var_01 != "hub_character_selection") {
      continue;
    }

    if(var_02 == -1) {
      break;
    }

    switch (var_02) {
      case 1:
        break;

      case 2:
        maps\mp\gametypes\_hub_unk2::func_7473(param_00);
        break;

      case 3:
        break;

      case 6:
        thread maps\mp\gametypes\_hub_range::func_11BD(param_00);
        break;

      case 15:
        thread challengetotimertag(param_00);
        break;

      case 27:
        func_2541(param_00);
        break;

      case 100:
        break;

      default:
        break;
    }
  }
}

challengetotimertag(param_00) {
  if(getdvarint("spv_hub_timer_tag_kswitch", 1) == 1) {
    self iclientprintln(&"HUB_TIMER_TAG_KSWITCH");
    return;
  }

  if(maps\mp\gametypes\_hub_unk1::func_5790(0)) {
    return;
  }

  if(param_00 maps\mp\gametypes\_hub_unk1::func_5790(0)) {
    self iclientprintln(&"HUB_PLAYER_IS_BUSY", param_00.var_0109);
    return;
  }

  if(isDefined(self.tagchallenger)) {
    self iclientprintln(&"HUB_ALREADY_CH_TAG");
    return;
  }

  if(isDefined(param_00.tagchallenger)) {
    self iclientprintln(&"HUB_PLAYER_IS_BUSY", param_00.var_0109);
    return;
  }

  var_01 = proposetimertagchallenge(param_00);
  if(!isDefined(var_01)) {
    var_01 = 0;
    param_00 setclientomnvar("ui_hub_in_timer_tag", 0);
    self.tagchallenger = undefined;
    param_00.tagchallenger = undefined;
    self.isintimertag = 0;
    param_00.isintimertag = 0;
    param_00 maps\mp\gametypes\_hub_unk1::func_870B(0);
    param_00 freezecontrols(0);
  }

  var_02 = maps\mp\gametypes\_hub_unk1::func_5790(0);
  var_03 = param_00 maps\mp\gametypes\_hub_unk1::func_5790(0);
  if(var_02 || var_03) {
    if(var_02) {
      self iclientprintln(&"HUB_TAG_YOU_BUSY");
      param_00 iclientprintln(&"HUB_TAG_OPPONENT_BUSY");
    } else if(var_03) {
      param_00 iclientprintln(&"HUB_TAG_YOU_BUSY");
      self iclientprintln(&"HUB_TAG_OPPONENT_BUSY");
    }

    self.tagchallenger = undefined;
    param_00.tagchallenger = undefined;
    return;
  }

  if(var_01) {
    self.isintimertag = 1;
    param_00.isintimertag = 1;
    self method_85B4();
    param_00 method_85B4();
    var_04 = 50 + randomintrange(5, 15);
    thread monitortimertagtimer(var_04, self, param_00);
    thread starttimertag(1);
    param_00 thread starttimertag(0);
    return;
  }

  self iclientprintln(&"HUB_TAG_DECLINE");
  param_00 iclientprintln(&"HUB_TAG_DECLINE");
}

proposetimertagchallenge(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("tagChallengeTimeLimit");
  self endon("death");
  self endon("disconnect");
  self.tagchallenger = param_00;
  param_00.tagchallenger = self;
  param_00 thread checkfordisconnect(self);
  param_00 freezecontrols(1);
  param_00 maps\mp\gametypes\_hub_unk1::func_870B(1);
  wait(0.5);
  func_8A34(param_00, "TIMER_TAG_CHALLENGE", self);
  func_8A34(self, "TAG_CHALLENGE_SENT", param_00);
  param_00 freezecontrols(0);
  param_00 thread maps\mp\gametypes\_hub_unk1::func_8636(10, "tagChallengeTimeLimit", ["death", "disconnect", "tagChoiceMade"]);
  for(;;) {
    param_00 waittill("luinotifyserver", var_01, var_02);
    if(var_01 == "enter_timer_tag") {
      break;
    }
  }

  param_00 notify("tagChoiceMade");
  param_00 maps\mp\gametypes\_hub_unk1::func_870B(0);
  if(var_02 == 1) {
    return 1;
  }

  self.tagchallenger = undefined;
  param_00.tagchallenger = undefined;
  return 0;
}

checkfordisconnect(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("tagChallengeTimeLimit");
  self endon("tagChoiceMade");
  param_00 common_scripts\utility::func_A70A("death", "disconnect");
  self freezecontrols(0);
  maps\mp\gametypes\_hub_unk1::func_870B(0);
}

starttimertag(param_00) {
  self endon("disconnect");
  self endon("death");
  if(common_scripts\utility::func_562E(self.var_5721)) {
    maps\mp\gametypes\_hub_range::func_38F2();
  }

  self.canpassbomb = 0;
  maps\mp\gametypes\_hub_unk1::func_870B(1);
  self.hastagbomb = common_scripts\utility::func_98E7(param_00, 1, 0);
  self setclientomnvar("ui_hub_in_timer_tag", self.hastagbomb + 1);
  self sethubopponentent(self.tagchallenger);
  self.tagchallenger hudoutlineenableforclient(self, 0, 0);
  maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0, 0, 1);
  if(self.hastagbomb == 1) {
    givetimertagbombmodel();
  }

  thread listenfordeathdisconnect_tag(self);
  thread listenfordeathdisconnect_tag(self.tagchallenger);
  wait(5);
  if(!isDefined(self.tagchallenger)) {
    self iclientprintln(&"HUB_TAG_OPPONENT_BUSY");
    if(self.hastagbomb) {
      deletetimertagbombmodel();
    }

    maps\mp\gametypes\_hub_unk1::func_A04C();
    self.tagchallenger = undefined;
    self.isintimertag = 0;
    self method_81E1(1);
    self setclientomnvar("ui_hub_in_timer_tag", 0);
    self sethubopponentent(undefined);
    maps\mp\gametypes\_hub_unk1::func_870B(0);
    return;
  }

  maps\mp\gametypes\_hub_unk1::func_A04C();
  self setclientomnvar("ui_hub_enable_pause", 0);
  self.canpassbomb = 1;
  if(self.hastagbomb == 1) {
    self method_81E1(1.1);
  }
}

attemptpasstagbomb(param_00) {
  if(self.hastagbomb == 1 && self.canpassbomb) {
    self.hastagbomb = 0;
    self setclientomnvar("ui_hub_in_timer_tag", 1);
    self method_81E1(1);
    lib_0378::func_8D74("aud_timer_tag_take_bomb");
    deletetimertagbombmodel();
    param_00.hastagbomb = 1;
    param_00 setclientomnvar("ui_hub_in_timer_tag", 2);
    param_00 method_81E1(1.1);
    lib_0378::func_8D74("aud_timer_tag_give_bomb");
    param_00 givetimertagbombmodel();
  }
}

monitortimertagtimer(param_00, param_01, param_02) {
  param_01 endon("death");
  param_01 endon("disconnect");
  param_01 endon("force_end_timer_tag");
  param_02 endon("death");
  param_02 endon("disconnect");
  param_02 endon("force_end_timer_tag");
  wait(param_00);
  param_01 thread completetimertag();
  param_02 thread completetimertag();
}

completetimertag() {
  self endon("disconnect");
  self endon("death");
  var_00 = common_scripts\utility::func_98E7(self.hastagbomb, 0, 1);
  self luinotifyevent(&"timer_tag_result", 1, var_00);
  maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0, 0, 1);
  if(self.hastagbomb) {
    deletetimertagbombmodel();
  }

  if(var_00 == 1) {
    maps\mp\gametypes\_hub_unk1::func_721A("mp_emote_cheer_yeah");
    self iclientprintln(&"HUB_YOU_WON");
    lib_0468::func_0A27("timerTagWin");
  } else {
    playFXOnTag(level.var_0611["hub_granadier_tag_effect"], self, "tag_origin");
    lib_0378::func_8D74("aud_timer_tag_fireworks");
    maps\mp\gametypes\_hub_unk1::func_721A("mp_emote_defeated_c");
    self iclientprintln(&"HUB_YOU_LOST");
    lib_0468::func_0A27("timerTagLose");
  }

  self.hastagbomb = -1;
  wait(5);
  maps\mp\gametypes\_hub_unk1::func_A04C();
  self notify("tag_ended");
  if(maps\mp\_utility::func_0649("specialty_ballcarrier")) {
    deletetimertagbombmodel();
  }

  if(isDefined(self.tagchallenger)) {
    self.tagchallenger hudoutlinedisableforclient(self);
  }

  self.tagchallenger = undefined;
  self.isintimertag = 0;
  self method_81E1(1);
  self setclientomnvar("ui_hub_in_timer_tag", 0);
  self sethubopponentent(undefined);
  maps\mp\gametypes\_hub_unk1::func_870B(0);
}

listenfordeathdisconnect_tag(param_00) {
  self endon("tag_ended");
  var_01 = param_00 common_scripts\utility::func_A70A("death", "disconnect");
  if(isDefined(self)) {
    cleanupfailedtimertag();
  }
}

cleanupfailedtimertag(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(common_scripts\utility::func_562E(self.isintimertag)) {
    self iclientprintln(&"HUB_TAG_FORCE_END");
  }

  self.isintimertag = 0;
  if(isDefined(self.tagchallenger)) {
    self.tagchallenger hudoutlinedisableforclient(self);
    if(common_scripts\utility::func_562E(self.tagchallenger.isintimertag)) {
      self.tagchallenger cleanupfailedtimertag();
    }
  }

  self.tagchallenger = undefined;
  self setclientomnvar("ui_hub_in_timer_tag", 0);
  self luinotifyevent(&"timer_tag_result", 1, -1);
  if(self.hastagbomb || maps\mp\_utility::func_0649("specialty_ballcarrier")) {
    deletetimertagbombmodel();
  }

  self.hastagbomb = -1;
  self method_81E1(1);
  if(param_00 == 0) {
    self sethubopponentent(undefined);
    maps\mp\gametypes\_hub_unk1::func_A04C();
    maps\mp\gametypes\_hub_unk1::func_870B(0);
  }

  self notify("force_end_timer_tag");
}

func_2D6D(param_00) {}

func_8A34(param_00, param_01, param_02) {
  var_03 = "mp/mp_hub_notifications.csv";
  var_04 = 0;
  var_05 = 1;
  var_06 = tablelookup(var_03, var_05, param_01, var_04);
  if(isDefined(param_02)) {
    var_07 = param_02 getentitynumber();
    param_00 luinotifyeventextraplayer(&"player_interact_notification", 2, var_06, var_07);
    return;
  }

  param_00 luinotifyeventextraplayer(&"player_interact_notification", 1, var_06);
}

func_8A35(param_00, param_01, param_02) {
  var_03 = "mp/mp_hub_notifications_center.csv";
  var_04 = 0;
  var_05 = 1;
  var_06 = tablelookup(var_03, var_05, param_01, var_04);
  if(isDefined(param_02)) {
    var_07 = param_02 getentitynumber();
    param_00 luinotifyeventextraplayer(&"player_interact_notification_center", 2, var_06, var_07);
    return;
  }

  param_00 luinotifyeventextraplayer(&"player_interact_notification_center", 1, var_06);
}

givetimertagbombmodel() {
  maps\mp\_utility::func_47A2("specialty_ballcarrier");
  self takeallweapons();
  maps\mp\_utility::func_0642("timer_tag_bomb_mp");
  self switchtoweaponimmediate("timer_tag_bomb_mp");
  self method_8326();
  self method_812B(0);
}

deletetimertagbombmodel() {
  maps\mp\_utility::func_0735("specialty_ballcarrier");
  self takeallweapons();
  maps\mp\_utility::func_0642("emote_weapon_mp");
  self switchtoweaponimmediate("emote_weapon_mp");
}