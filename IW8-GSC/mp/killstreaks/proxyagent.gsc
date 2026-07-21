/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\proxyagent.gsc
***********************************************/

controlproxyagent(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.proxydisableweapon = undefined;

  if(var_3 < 3.0)
    return 0;

  var_6 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_1);

  if(!var_6)
    return 0;

  thread watchplayerkillstreakend(var_2);
  thread watchgameend();

  if(!isDefined(var_4) || !var_4)
    thread watchplayerkillstreakearlyexit(var_2);

  if(isalive(var_0) && !istrue(var_0.dying))
    startcontrol(var_0, var_1.streakname, var_2, var_5);
  else {
    self notify(var_2);
    return 0;
  }

  return 1;
}

watchplayerkillstreakdeath(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0);

  for(;;) {
    self waittill("_encstr_886F18E08D85BCB293AF5B5AB1366ED1399558DAFA1995B01D86", var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_3 != self && isPlayer(var_3)) {
      var_3 scripts\mp\utility\points::giveunifiedpoints("_encstr_ACB80B32E13893EAC81A9F1209" + var_1);
      thread scripts\mp\hud_util::teamplayercardsplash("_encstr_A76B138D2C1B36EDEA477D19959B1D4E7B97B223F5" + var_1, var_3);
      var_8 = asmdevgetallstates(var_7);
      thread scripts\cp\vehicles\vehicle_compass_cp::killstreakkilled(var_1, self, self, var_3, var_4, var_6, var_8, "_encstr_ACB80B32E13893EAC81A9F1209" + var_1);
      thread scripts\mp\utility\dialog::leaderdialogonplayer(var_1 + "_encstr_8D5A0BF58C59B98E39F65E2B32", undefined, undefined, self.origin);
    }

    self notify(var_0, 1);
  }
}

watchplayerkillstreakdisconnect(var_0) {
  self endon(var_0);
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify(var_0, 1);
}

watchplayerkillstreakswitchteam(var_0) {
  self endon(var_0);
  self waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  self notify(var_0, 1);
}

watchplayerkillstreakearlyexit(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0);
  var_1 = level.framedurationseconds;

  for(;;) {
    var_2 = 0;

    while(self useButtonPressed()) {
      var_2 = var_2 + var_1;

      if(var_2 > 0.75) {
        self.playerkillstreakearlyexitlocation = self.origin;
        self notify(var_0);
        return;
      }

      wait(var_1);
    }

    waitframe();
  }
}

watchplayerkillstreaktimeout(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0);
  wait(var_1);
  self notify(var_0, 1);
}

watchplayerkillstreakemp(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon(var_0);

  for(;;)
    self waittill("_encstr_93F60B2B5BC1EB912C5BB0ECB2", var_1, var_2);
}

watchplayerkillstreakend(var_0) {
  scripts\engine\utility::_id_143A5(var_0, "_encstr_B4A011F997AB03489F27B8C037C7215D323F65");
  stopcontrol();
}

watchgameend() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_B4A011F997AB03489F27B8C037C7215D323F65");
}

startcontrol(var_0, var_1, var_2, var_3) {
  if(isDefined(self) && isalive(var_0)) {
    self controlagent(var_0);

    if(isDefined(var_3))
      self visionsetnakedforplayer(var_3, 0);

    self.playerproxyagent = var_0;
  }
}

stopcontrol() {
  if(isDefined(self)) {
    if(scripts\mp\utility\killstreak::iscontrollingproxyagent()) {
      self restorecontrolagent();
      self visionsetnakedforplayer("_encstr_B40101", 0);
    }

    self.streakinfo notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    self.playerproxyagent = undefined;
    self.activeplayerstreak = undefined;
  }
}

cleararchetype(var_0) {
  scripts\mp\archetypes\archcommon::removearchetype(var_0.loadoutarchetype);
  scripts\mp\class::loadout_clearperks();
}

reapplyarchetype(var_0) {
  var_1 = undefined;

  switch (var_0.loadoutarchetype) {
    case "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D":
      var_1 = scripts\mp\archetypes\archassault::applyarchetype;
      break;
  }

  scripts\mp\class::loadout_updateplayerperks(var_0);

  if(isDefined(var_1))
    self[[var_1]]();
}

killproxy(var_0) {}