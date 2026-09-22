/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1244.gsc
**************************************/

monitorsocialrankup() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "social_rank_up") {
      continue;
    }
    if(var_1 == -1) {
      continue;
    }
    thread maps\mp\gametypes\_hud_message::_id_9102("social_rank_up", var_1);
  }
}

monitorsocialmaxrankreward() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "social_max_rank_rewarded") {
      continue;
    }
    if(var_1 == -1) {
      continue;
    }
    _func_3B8(var_1, 1);
  }
}

_id_2541(var_0) {
  maps\mp\gametypes\_missions::_id_7752("ch_daily_5");
  var_1 = self getplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "commends") + 1;
  self setplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "commends", var_1);
  _id_04E0::isusingoffhand(["hubFeatureStats", "hubSocialScore", "hubCommends"], var_1);
  _id_04E0::pushplayervector("hubCommends", "hubSocialScore", 1, undefined, undefined);
  var_1 = var_0 getplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "commendations") + 1;
  var_0 setplayerdata(common_scripts\utility::_id_46AB(), "hubStats", "commendations", var_1);
  var_0 _id_04E0::isusingoffhand(["hubFeatureStats", "hubSocialScore", "hubCommendations"], var_1);
  var_0 _id_04E0::pushplayervector("hubCommendations", "hubSocialScore", 1, undefined, undefined);
  self iprintln(&"HUB_YOU_COMMENDED_PLAYER", var_0.name);
  var_0 iprintln(&"HUB_WERE_COMMENDED_BY", self.name);
  var_0 giveachievement("recognition");
}

_id_4AE0(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_existing_interacts");
  var_0 endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 != "hub_character_selection") {
      continue;
    }
    if(var_2 == -1) {
      break;
    }

    switch (var_2) {
      case 1:
        return;
      case 2:
        _id_04E1::_id_7473(var_0);
        return;
      case 3:
        return;
      case 6:
        thread _id_04DB::_id_11BD(var_0);
        return;
      case 15:
        thread challengetotimertag(var_0);
        return;
      case 27:
        _id_2541(var_0);
        return;
      case 100:
        return;
      default:
        return;
    }
  }
}

challengetotimertag(var_0) {
  if(getdvarint("spv_hub_timer_tag_kswitch", 1) == 1) {
    self iprintln(&"HUB_TIMER_TAG_KSWITCH");
  } else {
    if(_id_04E0::_id_5790(0)) {
      return;
    }
    if(var_0 _id_04E0::_id_5790(0)) {
      self iprintln(&"HUB_PLAYER_IS_BUSY", var_0.name);
      return;
    }

    if(isDefined(self.tagchallenger)) {
      self iprintln(&"HUB_ALREADY_CH_TAG");
      return;
    }

    if(isDefined(var_0.tagchallenger)) {
      self iprintln(&"HUB_PLAYER_IS_BUSY", var_0.name);
      return;
    }

    var_1 = proposetimertagchallenge(var_0);

    if(!isDefined(var_1)) {
      var_1 = 0;
      var_0 setclientomnvar("ui_hub_in_timer_tag", 0);
      self.tagchallenger = undefined;
      var_0.tagchallenger = undefined;
      self.isintimertag = 0;
      var_0.isintimertag = 0;
      var_0 _id_04E0::_id_870B(0);
      var_0 freezecontrols(0);
    }

    var_2 = _id_04E0::_id_5790(0);
    var_3 = var_0 _id_04E0::_id_5790(0);

    if(var_2 || var_3) {
      if(var_2) {
        self iprintln(&"HUB_TAG_YOU_BUSY");
        var_0 iprintln(&"HUB_TAG_OPPONENT_BUSY");
      } else if(var_3) {
        var_0 iprintln(&"HUB_TAG_YOU_BUSY");
        self iprintln(&"HUB_TAG_OPPONENT_BUSY");
      }

      self.tagchallenger = undefined;
      var_0.tagchallenger = undefined;
      return;
    }

    if(var_1) {
      self.isintimertag = 1;
      var_0.isintimertag = 1;
      self _meth_85B4();
      var_0 _meth_85B4();
      var_4 = 50 + _randomintrange(5, 15);
      thread monitortimertagtimer(var_4, self, var_0);
      thread starttimertag(1);
      var_0 thread starttimertag(0);
      return;
    }

    self iprintln(&"HUB_TAG_DECLINE");
    var_0 iprintln(&"HUB_TAG_DECLINE");
  }
}

proposetimertagchallenge(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("tagChallengeTimeLimit");
  self endon("death");
  self endon("disconnect");
  self.tagchallenger = var_0;
  var_0.tagchallenger = self;
  var_0 thread checkfordisconnect(self);
  var_0 freezecontrols(1);
  var_0 _id_04E0::_id_870B(1);
  wait 0.5;
  _id_8A34(var_0, "TIMER_TAG_CHALLENGE", self);
  _id_8A34(self, "TAG_CHALLENGE_SENT", var_0);
  var_0 freezecontrols(0);
  var_0 thread _id_04E0::disablefocus(10, "tagChallengeTimeLimit", ["death", "disconnect", "tagChoiceMade"]);

  for(;;) {
    var_0 waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "enter_timer_tag") {
      break;
    }
  }

  var_0 notify("tagChoiceMade");
  var_0 _id_04E0::_id_870B(0);

  if(var_2 == 1) {
    return 1;
  }

  self.tagchallenger = undefined;
  var_0.tagchallenger = undefined;
  return 0;
}

checkfordisconnect(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("tagChallengeTimeLimit");
  self endon("tagChoiceMade");
  var_0 common_scripts\utility::_id_A70A("death", "disconnect");
  self freezecontrols(0);
  _id_04E0::_id_870B(0);
}

starttimertag(var_0) {
  self endon("disconnect");
  self endon("death");

  if(common_scripts\utility::_id_562E(self._id_5721)) {
    _id_04DB::_id_38F2();
  }

  self.canpassbomb = 0;
  _id_04E0::_id_870B(1);
  self.hastagbomb = common_scripts\utility::_id_98E7(var_0, 1, 0);
  self setclientomnvar("ui_hub_in_timer_tag", self.hastagbomb + 1);
  self _meth_8656(self.tagchallenger);
  self.tagchallenger hudoutlineenableforclient(self, 0, 0);
  _id_04E0::_id_7DF8(0, 0, 0, 0, 1);

  if(self.hastagbomb == 1) {
    givetimertagbombmodel();
  }

  thread listenfordeathdisconnect_tag(self);
  thread listenfordeathdisconnect_tag(self.tagchallenger);
  wait 5;

  if(!isDefined(self.tagchallenger)) {
    self iprintln(&"HUB_TAG_OPPONENT_BUSY");

    if(self.hastagbomb) {
      deletetimertagbombmodel();
    }

    _id_04E0::_id_A04C();
    self.tagchallenger = undefined;
    self.isintimertag = 0;
    self setmovespeedscale(1);
    self setclientomnvar("ui_hub_in_timer_tag", 0);
    self _meth_8656(undefined);
    _id_04E0::_id_870B(0);
    return;
  }

  _id_04E0::_id_A04C();
  self setclientomnvar("ui_hub_enable_pause", 0);
  self.canpassbomb = 1;

  if(self.hastagbomb == 1) {
    self setmovespeedscale(1.1);
  }
}

attemptpasstagbomb(var_0) {
  if(self.hastagbomb == 1 && self.canpassbomb) {
    self.hastagbomb = 0;
    self setclientomnvar("ui_hub_in_timer_tag", 1);
    self setmovespeedscale(1);
    _id_0378::_id_8D74("aud_timer_tag_take_bomb");
    deletetimertagbombmodel();
    var_0.hastagbomb = 1;
    var_0 setclientomnvar("ui_hub_in_timer_tag", 2);
    var_0 setmovespeedscale(1.1);
    _id_0378::_id_8D74("aud_timer_tag_give_bomb");
    var_0 givetimertagbombmodel();
  }
}

monitortimertagtimer(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("disconnect");
  var_1 endon("force_end_timer_tag");
  var_2 endon("death");
  var_2 endon("disconnect");
  var_2 endon("force_end_timer_tag");
  wait(var_0);
  var_1 thread completetimertag();
  var_2 thread completetimertag();
}

completetimertag() {
  self endon("disconnect");
  self endon("death");
  var_0 = common_scripts\utility::_id_98E7(self.hastagbomb, 0, 1);
  self _meth_85EF(&"timer_tag_result", 1, var_0);
  _id_04E0::_id_7DF8(0, 0, 0, 0, 1);

  if(self.hastagbomb) {
    deletetimertagbombmodel();
  }

  if(var_0 == 1) {
    _id_04E0::_id_721A("mp_emote_cheer_yeah");
    self iprintln(&"HUB_YOU_WON");
    _id_0468::_id_0A27("timerTagWin");
  } else {
    _playFXOnTag(level._effect["hub_granadier_tag_effect"], self, "tag_origin");
    _id_0378::_id_8D74("aud_timer_tag_fireworks");
    _id_04E0::_id_721A("mp_emote_defeated_c");
    self iprintln(&"HUB_YOU_LOST");
    _id_0468::_id_0A27("timerTagLose");
  }

  self.hastagbomb = -1;
  wait 5;
  _id_04E0::_id_A04C();
  self notify("tag_ended");

  if(maps\mp\_utility::_hasperk("specialty_ballcarrier")) {
    deletetimertagbombmodel();
  }

  if(isDefined(self.tagchallenger)) {
    self.tagchallenger hudoutlinedisableforclient(self);
  }

  self.tagchallenger = undefined;
  self.isintimertag = 0;
  self setmovespeedscale(1);
  self setclientomnvar("ui_hub_in_timer_tag", 0);
  self _meth_8656(undefined);
  _id_04E0::_id_870B(0);
}

listenfordeathdisconnect_tag(var_0) {
  self endon("tag_ended");
  var_1 = var_0 common_scripts\utility::_id_A70A("death", "disconnect");

  if(isDefined(self)) {
    cleanupfailedtimertag();
  }
}

cleanupfailedtimertag(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(common_scripts\utility::_id_562E(self.isintimertag)) {
    self iprintln(&"HUB_TAG_FORCE_END");
  }

  self.isintimertag = 0;

  if(isDefined(self.tagchallenger)) {
    self.tagchallenger hudoutlinedisableforclient(self);

    if(common_scripts\utility::_id_562E(self.tagchallenger.isintimertag)) {
      self.tagchallenger cleanupfailedtimertag();
    }
  }

  self.tagchallenger = undefined;
  self setclientomnvar("ui_hub_in_timer_tag", 0);
  self _meth_85EF(&"timer_tag_result", 1, -1);

  if(self.hastagbomb || maps\mp\_utility::_hasperk("specialty_ballcarrier")) {
    deletetimertagbombmodel();
  }

  self.hastagbomb = -1;
  self setmovespeedscale(1);

  if(var_0 == 0) {
    self _meth_8656(undefined);
    _id_04E0::_id_A04C();
    _id_04E0::_id_870B(0);
  }

  self notify("force_end_timer_tag");
}

_id_2D6D(var_0) {}

_id_8A34(var_0, var_1, var_2) {
  var_3 = "mp/mp_hub_notifications.csv";
  var_4 = 0;
  var_5 = 1;
  var_6 = tablelookup(var_3, var_5, var_1, var_4);

  if(isDefined(var_2)) {
    var_7 = var_2 getentitynumber();
    var_0 _meth_866C(&"player_interact_notification", 2, var_6, var_7);
  } else
    var_0 _meth_866C(&"player_interact_notification", 1, var_6);
}

_id_8A35(var_0, var_1, var_2) {
  var_3 = "mp/mp_hub_notifications_center.csv";
  var_4 = 0;
  var_5 = 1;
  var_6 = tablelookup(var_3, var_5, var_1, var_4);

  if(isDefined(var_2)) {
    var_7 = var_2 getentitynumber();
    var_0 _meth_866C(&"player_interact_notification_center", 2, var_6, var_7);
  } else
    var_0 _meth_866C(&"player_interact_notification_center", 1, var_6);
}

givetimertagbombmodel() {
  maps\mp\_utility::giveperk("specialty_ballcarrier");
  self takeallweapons();
  maps\mp\_utility::_giveweapon("timer_tag_bomb_mp");
  self switchtoweaponimmediate("timer_tag_bomb_mp");
  self disableweaponswitch();
  self allowfire(0);
}

deletetimertagbombmodel() {
  maps\mp\_utility::_id_0735("specialty_ballcarrier");
  self takeallweapons();
  maps\mp\_utility::_giveweapon("emote_weapon_mp");
  self switchtoweaponimmediate("emote_weapon_mp");
}