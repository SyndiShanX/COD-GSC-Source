/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1242.gsc
**************************************/

_id_52B1() {}

_id_11BC(var_0) {
  if(!_id_04E0::_id_5790() && !var_0 _id_04E0::_id_5790() && getdvarint("spv_hub_dueling_kswitch", 1) == 0) {
    _id_778B(var_0);
  }
}

_id_778B(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  self endon("death");
  self endon("disconnect");

  if(isDefined(self._id_34CD)) {
    self iprintln("You have already challenged someone to Box.");
  } else {
    if(isDefined(var_0._id_34CD)) {
      self iprintln(var_0.name + " has already challenged someone to Box.");
      return;
    }

    self._id_5692 = 1;
    _id_04E0::_id_870B(1);
    var_0._id_5692 = 1;
    var_0 _id_04E0::_id_870B(1);
    self._id_34CD = var_0;
    var_0._id_34CD = self;

    foreach(var_2 in level._id_0813) {
      var_2 disableplayeruse(self);
      var_2 disableplayeruse(var_0);
    }

    var_0 freezecontrols(1);
    wait 0.5;
    _id_04DC::_id_8A34(var_0, "DUEL_CHALLENGE", self);
    _id_04DC::_id_8A34(self, "BOXING_INVITE_SENT", var_0);
    var_0 freezecontrols(0);
    var_0 thread _id_04E0::disablefocus(10, "reject_duel_challenge", ["accept_duel_challenge", "reject_duel_challenge", "forceSurrenderDuel", "death", "disconnect", "duel_choice_made"]);

    for(;;) {
      var_0 waittill("luinotifyserver", var_4, var_5);

      if(var_4 == "enter_duel") {
        if(var_5 == 1) {
          var_6 = "accept_duel_challenge";
        } else {
          var_6 = "reject_duel_challenge";
        }

        break;
      }
    }

    var_0 notify("duel_choice_made");
    self._id_34CD = undefined;
    var_0._id_34CD = undefined;

    if(var_6 == "accept_duel_challenge") {
      thread _id_170F(self, var_0);
      return;
    }

    if(var_6 == "reject_duel_challenge" || var_6 == "forceSurrenderDuel") {
      self iprintln(var_0.name + " rejected your duel challenge.");
      var_0 iprintln("You rejected " + self.name + "'s duel challenge.");
      self._id_5692 = 0;
      _id_04E0::_id_870B(0);
      var_0._id_5692 = 0;
      var_0 _id_04E0::_id_870B(0);

      foreach(var_2 in level._id_0813) {
        var_2 enableplayeruse(self);
        var_2 enableplayeruse(var_0);
      }

      return;
    }
  }
}

_id_170F(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_1 endon("death");
  var_1 endon("disconnect");
  var_0 notify("startedDuel");
  var_1 notify("startedDuel");
  var_0._id_5692 = 1;
  var_0 _id_04E0::_id_870B(1);
  var_1._id_5692 = 1;
  var_1 _id_04E0::_id_870B(1);
  var_0 _id_04E0::_id_7D1D(2);
  var_1 _id_04E0::_id_7D1D(2);
  var_0 _id_04E0::_id_7D1E(1);
  var_1 _id_04E0::_id_7D1E(1);
  var_0 _meth_866C(&"player_interact_notification_end", 0);
  var_0 _meth_866C(&"player_interact_notification_center_end", 0);

  if(var_0._id_56A4) {
    if(isDefined(var_0._id_155F)) {
      var_0._id_155F _id_04E0::_id_1543((0, 0, 80), var_0);
    }
  }

  if(var_1._id_56A4) {
    if(isDefined(var_1._id_155F)) {
      var_1._id_155F _id_04E0::_id_1543((0, 0, 80), var_1);
    }
  }

  var_0 takeallweapons();
  var_1 takeallweapons();
  var_0 giveweapon("boxing_gloves_hub_mp");
  var_1 giveweapon("boxing_gloves_hub_mp");
  var_0 switchtoweaponimmediate("boxing_gloves_hub_mp");
  var_1 switchtoweaponimmediate("boxing_gloves_hub_mp");
  var_0 _meth_85C8();
  var_1 _meth_85C8();
  var_0 allowfire(0);
  var_1 allowfire(0);
  var_0 allowads(0);
  var_1 allowads(0);
  var_0 allowmelee(0);
  var_1 allowmelee(0);
  _id_04E0::_id_6010(var_0, var_1);
  _id_04E0::_id_6010(var_1, var_0);
  var_0 _meth_8656(var_1);
  var_1 _meth_8656(var_0);
  var_0 hudoutlineenableforclient(var_1, 0, 0);
  var_1 hudoutlineenableforclient(var_0, 0, 0);
  var_0 thread _id_04E0::_id_4D09();
  var_1 thread _id_04E0::_id_4D09();
  var_0._id_34D2 = var_1;
  var_1._id_34D2 = var_0;
  var_0._id_268C = 0;
  var_0._id_268C = 0;
  thread _id_6387(var_0, var_1);
  var_0 thread _id_34CE();
  var_1 thread _id_34CE();

  while(!var_0._id_268C || !var_1._id_268C) {
    waitframe();
  }

  var_0 allowfire(1);
  var_1 allowfire(1);
  var_0 allowads(1);
  var_1 allowads(1);
  var_0 allowmelee(1);
  var_1 allowmelee(1);
  var_0._id_1B77 = gettime();
  var_1._id_1B77 = gettime();
}

_id_6387(var_0, var_1) {
  var_0 thread _id_6389();
  var_0 thread _id_638A();
  var_0 thread _id_638B();
  var_1 thread _id_6389();
  var_1 thread _id_638A();
  var_1 thread _id_638B();
  var_0 thread _id_6388(var_1);
  var_1 thread _id_6388(var_0);
}

_id_6388(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("duel_ended");
  self.health = self.maxhealth;
  var_1 = 160;
  var_2 = 160;
  self._id_34CF = _newclienthudelem(self);
  self._id_34CF setshader("mtl_hub_1v1_health_bar_100", var_1, var_2);
  self._id_34CF.alpha = 1;
  self._id_34CF.color = (1, 1, 1);
  self._id_34CF.x = 320;
  self._id_34CF.y = 350;
  self._id_34CF.alignx = "center";
  self._id_34CF._id_01CA = "fullscreen";
  self._id_34CF._id_35B2 = "icon";
  self._id_34CF._id_6E74 = level._id_A012;
  self._id_34CF._id_6E74 maps\mp\gametypes\_hud_util::_id_09A6(self._id_34CF);
  self._id_34CF.name = "duelHealth1P";
  self._id_34D0 = _newclienthudelem(var_0);
  self._id_34D0 setshader("mtl_hub_1v1_health_bar_100", var_1, var_2);
  self._id_34D0.alpha = 1;
  self._id_34D0.color = (1, 1, 1);
  self._id_34D0.x = self.origin[0];
  self._id_34D0.y = self.origin[1];
  self._id_34D0._id_01D9 = self.origin[2];
  self._id_34D0 setwaypoint(1, 0, 0);
  self._id_34D0 settargetEnt(self);
  self._id_34D0._id_35B2 = "icon";
  self._id_34D0._id_6E74 = level._id_A012;
  self._id_34D0._id_6E74 maps\mp\gametypes\_hud_util::_id_09A6(self._id_34D0);
  self._id_34D0.name = "duelHealth3P";

  for(;;) {
    var_3 = common_scripts\utility::waittill_any_return("updateDuelHealthDisplay", "lostDuel", "forceSurrenderDuel");

    if(var_3 == "updateDuelHealthDisplay") {
      if(self.health % 20 == 0) {} else if(self.health % 20 < 10) {
        self.health = self.health - self.health % 20;
      } else {
        self.health = self.health + (10 - self.health % 10);
      }

      switch (self.health) {
        case 100:
          self._id_34CF setshader("mtl_hub_1v1_health_bar_100", var_1, var_2);
          self._id_34D0 setshader("mtl_hub_1v1_health_bar_100", var_1, var_2);
          self._id_34D0 setwaypoint(1, 0, 0);
          break;
        case 80:
          self._id_34CF setshader("mtl_hub_1v1_health_bar_80", var_1, var_2);
          self._id_34D0 setshader("mtl_hub_1v1_health_bar_80", var_1, var_2);
          self._id_34D0 setwaypoint(1, 0, 0);
          break;
        case 60:
          self._id_34CF setshader("mtl_hub_1v1_health_bar_60", var_1, var_2);
          self._id_34D0 setshader("mtl_hub_1v1_health_bar_60", var_1, var_2);
          self._id_34D0 setwaypoint(1, 0, 0);
          break;
        case 40:
          self._id_34CF setshader("mtl_hub_1v1_health_bar_40", var_1, var_2);
          self._id_34D0 setshader("mtl_hub_1v1_health_bar_40", var_1, var_2);
          self._id_34D0 setwaypoint(1, 0, 0);
          break;
        case 20:
          self._id_34CF setshader("mtl_hub_1v1_health_bar_20", var_1, var_2);
          self._id_34D0 setshader("mtl_hub_1v1_health_bar_20", var_1, var_2);
          self._id_34D0 setwaypoint(1, 0, 0);
          break;
      }

      continue;
    }

    if(var_3 == "lostDuel" || var_3 == "forceSurrenderDuel") {
      thread _id_237E(var_0, self);
      return;
    }
  }
}

_id_6389() {
  self endon("duel_ended");
  self waittill("death");
  thread _id_237E(self._id_34D2, self, "unexpectedDeath");
}

_id_638A() {
  self endon("duel_ended");
  self waittill("disconnect");
  thread _id_237E(self._id_34D2, self, "disconnect");
}

_id_638B() {
  self endon("duel_ended");
  self notifyonplayercommand("ForfeitButtonDown", "+usereload");
  self notifyonplayercommand("ForfeitButtonUp", "-usereload");

  for(;;) {
    self waittill("ForfeitButtonDown");
    thread _id_92D2();
    thread _id_1F3E();
  }
}

_id_92D2(var_0, var_1) {
  self endon("duel_ended");
  self._id_34D1 = 1;
  thread _id_04E0::_id_3010("youForfeit", &"HUB_DUEL_FORFEIT", undefined, -100, 1.75, 1.5);
  wait 1.5;

  if(self._id_34D1 == 1) {
    thread _id_237E(self._id_34D2, self, "forfeit");
  }
}

_id_1F3E() {
  self endon("duel_ended");
  self waittill("ForfeitButtonUp");
  self._id_34D1 = 0;
}

_id_237E(var_0, var_1, var_2) {
  var_0 notify("duel_ended");
  var_1 notify("duel_ended");
  var_0 _id_04E0::_id_7E4E(2);
  var_1 _id_04E0::_id_7E4E(2);
  var_0 _id_04E0::_id_7E4F(1);
  var_1 _id_04E0::_id_7E4F(1);
  _id_04E0::_id_A03C(var_0, var_1);
  _id_04E0::_id_A03C(var_1, var_0);
  var_0 _meth_8656(undefined);
  var_1 _meth_8656(undefined);

  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      var_0 hudoutlinedisableforclient(var_1);
    }

    var_0 maps\mp\gametypes\_missions::_id_7752("ch_daily_4");
    var_0._id_34D2 = undefined;
    var_0._id_34CF destroy();
    var_0._id_34D0 destroy();
    var_0 notifyonplayercommand("ForfeitButtonDown", "+usereload");
    var_0 notifyonplayercommand("ForfeitButtonUp", "-usereload");
    var_0 thread _id_04E0::_id_8BFB();
    var_0 thread _id_04E0::_id_3010("youWon", &"HUB_YOU_WON", undefined, -100, 1, 2.5);
    var_0 _id_04DC::_id_2D6D(10);
    var_0 _id_04E0::_id_50F0(["hubFeatureStats", "hubBoxing", "numBoxingWins"], 1, undefined, undefined);
    var_0 _id_04E0::_id_50F0(["hubFeatureStats", "hubBoxing", "numBoxingMatches"], 1, undefined, undefined);
    var_0 _id_04E0::_id_5E88("boxing_match", "hq_boxing", int((gettime() - var_0._id_1B77) / 1000), ["match_id", "0", "winloss", "win"]);
    var_0 thread _id_7E2D(1);
  }

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      var_1 hudoutlinedisableforclient(var_0);
    }

    var_1._id_34D2 = undefined;
    var_1._id_34CF destroy();
    var_1._id_34D0 destroy();
    var_1 notifyonplayercommand("ForfeitButtonDown", "+usereload");
    var_1 notifyonplayercommand("ForfeitButtonUp", "-usereload");
    var_1 thread _id_04E0::_id_8BFB();
    var_1 thread _id_04E0::_id_3010("youLost", &"HUB_YOU_LOST", undefined, -100, 1, 2.5);
    var_1 _id_04DC::_id_2D6D(1);
    var_1 _id_04E0::_id_50F0(["hubFeatureStats", "hubBoxing", "numBoxingMatches"], 1, undefined, undefined);
    var_1 _id_04E0::_id_5E88("boxing_match", "hq_boxing", int((gettime() - var_1._id_1B77) / 1000), ["match_id", "0", "winloss", "loss"]);
    var_1 thread _id_7E2D(0);
  }
}

_id_7E2D(var_0) {
  self endon("death");
  self endon("disconnect");

  if(isDefined(self) && maps\mp\_utility::isreallyalive(self)) {
    self freezecontrols(1);
    self.health = self.maxhealth;
    self._id_542B = 1;
    self _meth_85C7();
    _id_04E0::_id_7446();
    childthread _id_75E3(var_0);
    self waittill("postDuelEmoteComplete");
    self._id_5692 = 0;
    _id_04E0::_id_870B(0);
    self allowprone(0);
    self freezecontrols(0);
    self allowmelee(0);
    self._id_579F = 1;
    self._id_8B93 = 0;

    foreach(var_2 in level._id_0813) {
      var_2 enableplayeruse(self);
    }
  }
}

_id_75E3(var_0) {
  if(var_0) {
    _id_04E0::_id_721A("mp_emote_clap_jump");
    wait 3.46667;
    self notify("postDuelEmoteComplete");
  } else {
    _id_04E0::_id_721A("mp_emote_noway");
    wait 5.36667;
    self notify("postDuelEmoteComplete");
  }
}

_id_34CE() {
  self endon("death");
  self endon("disconnect");
  self endon("duel_ended");
  thread _id_04E0::_id_3010("duelBegin", &"HUB_DUEL_BEGINNING", undefined, -100, 1.5, 1);
  wait 1;

  for(var_0 = 3; var_0 > 0; var_0--) {
    thread _id_04E0::_id_3010("duelCount" + var_0, &"HUB_DUEL_COUNTDOWN", var_0, -100, 1.5, 1);
    wait 1;
  }

  self._id_268C = 1;
  thread _id_04E0::_id_3010("duelFight", &"HUB_DUEL_FIGHT", undefined, -100, 1.7, 1.5);
  wait 1.5;
}