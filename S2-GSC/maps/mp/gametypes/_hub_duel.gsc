/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hub_duel.gsc
*********************************************/

func_52B1() {}

func_11BC(param_00) {
  if(!maps\mp\gametypes\_hub_unk1::func_5790() && !param_00 maps\mp\gametypes\_hub_unk1::func_5790() && getdvarint("spv_hub_dueling_kswitch", 1) == 0) {
    func_778B(param_00);
  }
}

func_778B(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  self endon("death");
  self endon("disconnect");
  if(isDefined(self.var_34CD)) {
    self iclientprintln("You have already challenged someone to Box.");
    return;
  }

  if(isDefined(param_00.var_34CD)) {
    self iclientprintln(param_00.var_0109 + " has already challenged someone to Box.");
    return;
  }

  self.var_5692 = 1;
  maps\mp\gametypes\_hub_unk1::func_870B(1);
  param_00.var_5692 = 1;
  param_00 maps\mp\gametypes\_hub_unk1::func_870B(1);
  self.var_34CD = param_00;
  param_00.var_34CD = self;
  foreach(var_02 in level.var_0813) {
    var_02 disableplayeruse(self);
    var_02 disableplayeruse(param_00);
  }

  param_00 freezecontrols(1);
  wait(0.5);
  maps\mp\gametypes\_hub_notifications::func_8A34(param_00, "DUEL_CHALLENGE", self);
  maps\mp\gametypes\_hub_notifications::func_8A34(self, "BOXING_INVITE_SENT", param_00);
  param_00 freezecontrols(0);
  param_00 thread maps\mp\gametypes\_hub_unk1::func_8636(10, "reject_duel_challenge", ["accept_duel_challenge", "reject_duel_challenge", "forceSurrenderDuel", "death", "disconnect", "duel_choice_made"]);
  for(;;) {
    param_00 waittill("luinotifyserver", var_04, var_05);
    if(var_04 == "enter_duel") {
      if(var_05 == 1) {
        var_06 = "accept_duel_challenge";
      } else {
        var_06 = "reject_duel_challenge";
      }

      break;
    }
  }

  param_00 notify("duel_choice_made");
  self.var_34CD = undefined;
  param_00.var_34CD = undefined;
  if(var_06 == "accept_duel_challenge") {
    thread func_170F(self, param_00);
    return;
  }

  if(var_06 == "reject_duel_challenge" || var_06 == "forceSurrenderDuel") {
    self iclientprintln(param_00.var_0109 + " rejected your duel challenge.");
    param_00 iclientprintln("You rejected " + self.var_0109 + "\'s duel challenge.");
    self.var_5692 = 0;
    maps\mp\gametypes\_hub_unk1::func_870B(0);
    param_00.var_5692 = 0;
    param_00 maps\mp\gametypes\_hub_unk1::func_870B(0);
    foreach(var_02 in level.var_0813) {
      var_02 enableplayeruse(self);
      var_02 enableplayeruse(param_00);
    }

    return;
  }
}

func_170F(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_01 endon("death");
  param_01 endon("disconnect");
  param_00 notify("startedDuel");
  param_01 notify("startedDuel");
  param_00.var_5692 = 1;
  param_00 maps\mp\gametypes\_hub_unk1::func_870B(1);
  param_01.var_5692 = 1;
  param_01 maps\mp\gametypes\_hub_unk1::func_870B(1);
  param_00 maps\mp\gametypes\_hub_unk1::func_7D1D(2);
  param_01 maps\mp\gametypes\_hub_unk1::func_7D1D(2);
  param_00 maps\mp\gametypes\_hub_unk1::func_7D1E(1);
  param_01 maps\mp\gametypes\_hub_unk1::func_7D1E(1);
  param_00 luinotifyeventextraplayer(&"player_interact_notification_end", 0);
  param_00 luinotifyeventextraplayer(&"player_interact_notification_center_end", 0);
  if(param_00.var_56A4) {
    if(isDefined(param_00.var_155F)) {
      param_00.var_155F maps\mp\gametypes\_hub_unk1::func_1543((0, 0, 80), param_00);
    }
  }

  if(param_01.var_56A4) {
    if(isDefined(param_01.var_155F)) {
      param_01.var_155F maps\mp\gametypes\_hub_unk1::func_1543((0, 0, 80), param_01);
    }
  }

  param_00 takeallweapons();
  param_01 takeallweapons();
  param_00 giveweapon("boxing_gloves_hub_mp");
  param_01 giveweapon("boxing_gloves_hub_mp");
  param_00 switchtoweaponimmediate("boxing_gloves_hub_mp");
  param_01 switchtoweaponimmediate("boxing_gloves_hub_mp");
  param_00 method_85C8();
  param_01 method_85C8();
  param_00 method_812B(0);
  param_01 method_812B(0);
  param_00 allowads(0);
  param_01 allowads(0);
  param_00 method_812A(0);
  param_01 method_812A(0);
  maps\mp\gametypes\_hub_unk1::func_6010(param_00, param_01);
  maps\mp\gametypes\_hub_unk1::func_6010(param_01, param_00);
  param_00 sethubopponentent(param_01);
  param_01 sethubopponentent(param_00);
  param_00 hudoutlineenableforclient(param_01, 0, 0);
  param_01 hudoutlineenableforclient(param_00, 0, 0);
  param_00 thread maps\mp\gametypes\_hub_unk1::func_4D09();
  param_01 thread maps\mp\gametypes\_hub_unk1::func_4D09();
  param_00.var_34D2 = param_01;
  param_01.var_34D2 = param_00;
  param_00.var_268C = 0;
  param_00.var_268C = 0;
  thread func_6387(param_00, param_01);
  param_00 thread func_34CE();
  param_01 thread func_34CE();
  while(!param_00.var_268C || !param_01.var_268C) {
    wait 0.05;
  }

  param_00 method_812B(1);
  param_01 method_812B(1);
  param_00 allowads(1);
  param_01 allowads(1);
  param_00 method_812A(1);
  param_01 method_812A(1);
  param_00.var_1B77 = gettime();
  param_01.var_1B77 = gettime();
}

func_6387(param_00, param_01) {
  param_00 thread func_6389();
  param_00 thread func_638A();
  param_00 thread func_638B();
  param_01 thread func_6389();
  param_01 thread func_638A();
  param_01 thread func_638B();
  param_00 thread func_6388(param_01);
  param_01 thread func_6388(param_00);
}

func_6388(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("duel_ended");
  self.var_00BC = self.var_00FB;
  var_01 = 160;
  var_02 = 160;
  self.var_34CF = newclienthudelem(self);
  self.var_34CF setshader("mtl_hub_1v1_health_bar_100", var_01, var_02);
  self.var_34CF.var_0018 = 1;
  self.var_34CF.var_0056 = (1, 1, 1);
  self.var_34CF.var_01D3 = 320;
  self.var_34CF.var_01D7 = 350;
  self.var_34CF.var_0010 = "center";
  self.var_34CF.var_01CA = "fullscreen";
  self.var_34CF.var_35B2 = "icon";
  self.var_34CF.var_6E74 = level.var_A012;
  self.var_34CF.var_6E74 maps\mp\gametypes\_hud_util::func_09A6(self.var_34CF);
  self.var_34CF.var_0109 = "duelHealth1P";
  self.var_34D0 = newclienthudelem(param_00);
  self.var_34D0 setshader("mtl_hub_1v1_health_bar_100", var_01, var_02);
  self.var_34D0.var_0018 = 1;
  self.var_34D0.var_0056 = (1, 1, 1);
  self.var_34D0.var_01D3 = self.var_0116[0];
  self.var_34D0.var_01D7 = self.var_0116[1];
  self.var_34D0.var_01D9 = self.var_0116[2];
  self.var_34D0 setwaypoint(1, 0, 0);
  self.var_34D0 settargetent(self);
  self.var_34D0.var_35B2 = "icon";
  self.var_34D0.var_6E74 = level.var_A012;
  self.var_34D0.var_6E74 maps\mp\gametypes\_hud_util::func_09A6(self.var_34D0);
  self.var_34D0.var_0109 = "duelHealth3P";
  for(;;) {
    var_03 = common_scripts\utility::func_A715("updateDuelHealthDisplay", "lostDuel", "forceSurrenderDuel");
    if(var_03 == "updateDuelHealthDisplay") {
      if(self.var_00BC % 20 == 0) {} else if(self.var_00BC % 20 < 10) {
        self.var_00BC = self.var_00BC - self.var_00BC % 20;
      } else {
        self.var_00BC = self.var_00BC + 10 - self.var_00BC % 10;
      }

      switch (self.var_00BC) {
        case 100:
          self.var_34CF setshader("mtl_hub_1v1_health_bar_100", var_01, var_02);
          self.var_34D0 setshader("mtl_hub_1v1_health_bar_100", var_01, var_02);
          self.var_34D0 setwaypoint(1, 0, 0);
          break;

        case 80:
          self.var_34CF setshader("mtl_hub_1v1_health_bar_80", var_01, var_02);
          self.var_34D0 setshader("mtl_hub_1v1_health_bar_80", var_01, var_02);
          self.var_34D0 setwaypoint(1, 0, 0);
          break;

        case 60:
          self.var_34CF setshader("mtl_hub_1v1_health_bar_60", var_01, var_02);
          self.var_34D0 setshader("mtl_hub_1v1_health_bar_60", var_01, var_02);
          self.var_34D0 setwaypoint(1, 0, 0);
          break;

        case 40:
          self.var_34CF setshader("mtl_hub_1v1_health_bar_40", var_01, var_02);
          self.var_34D0 setshader("mtl_hub_1v1_health_bar_40", var_01, var_02);
          self.var_34D0 setwaypoint(1, 0, 0);
          break;

        case 20:
          self.var_34CF setshader("mtl_hub_1v1_health_bar_20", var_01, var_02);
          self.var_34D0 setshader("mtl_hub_1v1_health_bar_20", var_01, var_02);
          self.var_34D0 setwaypoint(1, 0, 0);
          break;
      }

      continue;
    }

    if(var_03 == "lostDuel" || var_03 == "forceSurrenderDuel") {
      thread func_237E(param_00, self);
      return;
    }
  }
}

func_6389() {
  self endon("duel_ended");
  self waittill("death");
  thread func_237E(self.var_34D2, self, "unexpectedDeath");
}

func_638A() {
  self endon("duel_ended");
  self waittill("disconnect");
  thread func_237E(self.var_34D2, self, "disconnect");
}

func_638B() {
  self endon("duel_ended");
  self notifyonplayercommand("ForfeitButtonDown", "+usereload");
  self notifyonplayercommand("ForfeitButtonUp", "-usereload");
  for(;;) {
    self waittill("ForfeitButtonDown");
    thread func_92D2();
    thread func_1F3E();
  }
}

func_92D2(param_00, param_01) {
  self endon("duel_ended");
  self.var_34D1 = 1;
  thread maps\mp\gametypes\_hub_unk1::func_3010("youForfeit", &"HUB_DUEL_FORFEIT", undefined, -100, 1.75, 1.5);
  wait(1.5);
  if(self.var_34D1 == 1) {
    thread func_237E(self.var_34D2, self, "forfeit");
  }
}

func_1F3E() {
  self endon("duel_ended");
  self waittill("ForfeitButtonUp");
  self.var_34D1 = 0;
}

func_237E(param_00, param_01, param_02) {
  param_00 notify("duel_ended");
  param_01 notify("duel_ended");
  param_00 maps\mp\gametypes\_hub_unk1::func_7E4E(2);
  param_01 maps\mp\gametypes\_hub_unk1::func_7E4E(2);
  param_00 maps\mp\gametypes\_hub_unk1::func_7E4F(1);
  param_01 maps\mp\gametypes\_hub_unk1::func_7E4F(1);
  maps\mp\gametypes\_hub_unk1::func_A03C(param_00, param_01);
  maps\mp\gametypes\_hub_unk1::func_A03C(param_01, param_00);
  param_00 sethubopponentent(undefined);
  param_01 sethubopponentent(undefined);
  if(isDefined(param_00)) {
    if(isDefined(param_01)) {
      param_00 hudoutlinedisableforclient(param_01);
    }

    param_00 maps\mp\gametypes\_missions::func_7752("ch_daily_4");
    param_00.var_34D2 = undefined;
    param_00.var_34CF destroy();
    param_00.var_34D0 destroy();
    param_00 notifyonplayercommand("ForfeitButtonDown", "+usereload");
    param_00 notifyonplayercommand("ForfeitButtonUp", "-usereload");
    param_00 thread maps\mp\gametypes\_hub_unk1::func_8BFB();
    param_00 thread maps\mp\gametypes\_hub_unk1::func_3010("youWon", &"HUB_YOU_WON", undefined, -100, 1, 2.5);
    param_00 maps\mp\gametypes\_hub_notifications::func_2D6D(10);
    param_00 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubBoxing", "numBoxingWins"], 1, undefined, undefined);
    param_00 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubBoxing", "numBoxingMatches"], 1, undefined, undefined);
    param_00 maps\mp\gametypes\_hub_unk1::func_5E88("boxing_match", "hq_boxing", int(gettime() - param_00.var_1B77 / 1000), ["match_id", "0", "winloss", "win"]);
    param_00 thread func_7E2D(1);
  }

  if(isDefined(param_01)) {
    if(isDefined(param_00)) {
      param_01 hudoutlinedisableforclient(param_00);
    }

    param_01.var_34D2 = undefined;
    param_01.var_34CF destroy();
    param_01.var_34D0 destroy();
    param_01 notifyonplayercommand("ForfeitButtonDown", "+usereload");
    param_01 notifyonplayercommand("ForfeitButtonUp", "-usereload");
    param_01 thread maps\mp\gametypes\_hub_unk1::func_8BFB();
    param_01 thread maps\mp\gametypes\_hub_unk1::func_3010("youLost", &"HUB_YOU_LOST", undefined, -100, 1, 2.5);
    param_01 maps\mp\gametypes\_hub_notifications::func_2D6D(1);
    param_01 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubBoxing", "numBoxingMatches"], 1, undefined, undefined);
    param_01 maps\mp\gametypes\_hub_unk1::func_5E88("boxing_match", "hq_boxing", int(gettime() - param_01.var_1B77 / 1000), ["match_id", "0", "winloss", "loss"]);
    param_01 thread func_7E2D(0);
  }
}

func_7E2D(param_00) {
  self endon("death");
  self endon("disconnect");
  if(isDefined(self) && maps\mp\_utility::func_57A0(self)) {
    self freezecontrols(1);
    self.var_00BC = self.var_00FB;
    self.var_542B = 1;
    self method_85C7();
    maps\mp\gametypes\_hub_unk1::func_7446();
    childthread func_75E3(param_00);
    self waittill("postDuelEmoteComplete");
    self.var_5692 = 0;
    maps\mp\gametypes\_hub_unk1::func_870B(0);
    self method_8114(0);
    self freezecontrols(0);
    self method_812A(0);
    self.var_579F = 1;
    self.var_8B93 = 0;
    foreach(var_02 in level.var_0813) {
      var_02 enableplayeruse(self);
    }
  }
}

func_75E3(param_00) {
  if(param_00) {
    maps\mp\gametypes\_hub_unk1::func_721A("mp_emote_clap_jump");
    wait(3.466667);
    self notify("postDuelEmoteComplete");
    return;
  }

  maps\mp\gametypes\_hub_unk1::func_721A("mp_emote_noway");
  wait(5.366667);
  self notify("postDuelEmoteComplete");
}

func_34CE() {
  self endon("death");
  self endon("disconnect");
  self endon("duel_ended");
  thread maps\mp\gametypes\_hub_unk1::func_3010("duelBegin", &"HUB_DUEL_BEGINNING", undefined, -100, 1.5, 1);
  wait(1);
  for(var_00 = 3; var_00 > 0; var_00--) {
    thread maps\mp\gametypes\_hub_unk1::func_3010("duelCount" + var_00, &"HUB_DUEL_COUNTDOWN", var_00, -100, 1.5, 1);
    wait(1);
  }

  self.var_268C = 1;
  thread maps\mp\gametypes\_hub_unk1::func_3010("duelFight", &"HUB_DUEL_FIGHT", undefined, -100, 1.7, 1.5);
  wait(1.5);
}