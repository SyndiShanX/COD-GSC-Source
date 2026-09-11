/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\proxyagent.gsc
*************************************************/

function controlproxyagent(var0, var1, var2, var3, var4, var5) {
  self.proxydisableweapon = undefined;

  if(var3 < 3) {
    return false;
  }

  var6 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var1);

  if(!var6) {
    return false;
  }

  thread watchplayerkillstreakend(var2);
  thread watchgameend();

  if(!isDefined(var4) || !var4) {
    thread watchplayerkillstreakearlyexit(var2);
  }

  if(isalive(var0) && !istrue(var0.dying)) {
    startcontrol(var0, var1.streakname, var2, var5);
  } else {
    self notify(var2);
    return false;
  }

  return true;
}

function watchplayerkillstreakdeath(var0, var1) {
  self endon("disconnect");
  self endon(var0);

  for(;;) {
    self waittill("player_killstreak_death", var2, var3, var4, var5, var6, var7);

    if(var3 != self && isPlayer(var3)) {
      var3 scripts\mp\utility\points::giveunifiedpoints("destroyed_" + var1);
      thread scripts\mp\hud_util::teamplayercardsplash("callout_destroyed_" + var1, var3);
      var8 = asmdevgetallstates(var7);
      thread scripts\cp\vehicles\vehicle_compass_cp::killstreakkilled(var1, self, self, var3, var4, var6, var8, "destroyed_" + var1);
      thread scripts\mp\utility\dialog::leaderdialogonplayer(var1 + "_destroyed", undefined, undefined, self.origin);
    }

    self notify(var0, 1);
  }
}

function watchplayerkillstreakdisconnect(var0) {
  self endon(var0);
  self waittill("disconnect");
  self notify(var0, 1);
}

function watchplayerkillstreakswitchteam(var0) {
  self endon(var0);
  self waittill("joined_team");
  self notify(var0, 1);
}

function watchplayerkillstreakearlyexit(var0) {
  self endon("disconnect");
  self endon(var0);
  var1 = level.framedurationseconds;

  for(;;) {
    var2 = 0;

    while(self useButtonPressed()) {
      var2 += var1;

      if(var2 > 0.75) {
        self.playerkillstreakearlyexitlocation = self.origin;
        self notify(var0);
        return;
      }

      wait var1;
    }

    waitframe();
  }
}

function watchplayerkillstreaktimeout(var0, var1) {
  self endon("disconnect");
  self endon(var0);
  wait var1;
  self notify(var0, 1);
}

function watchplayerkillstreakemp(var0) {
  self endon("disconnect");
  self endon(var0);

  for(;;) {
    self waittill("emp_damage", var1, var2);
  }
}

function watchplayerkillstreakend(var0) {
  scripts\engine\utility::ref_143a5(var0, "level_game_ended");
  stopcontrol();
}

function watchgameend() {
  level waittill("game_ended");
  self notify("level_game_ended");
}

function startcontrol(var0, var1, var2, var3) {
  if(isDefined(self) && isalive(var0)) {
    self controlagent(var0);

    if(isDefined(var3)) {
      self visionsetnakedforplayer(var3, 0);
    }

    self.playerproxyagent = var0;
    return;
  }
}

function stopcontrol() {
  if(isDefined(self)) {
    if(scripts\mp\utility\killstreak::iscontrollingproxyagent()) {
      self restorecontrolagent();
      self visionsetnakedforplayer("", 0);
    }

    self.streakinfo notify("killstreak_finished_with_deploy_weapon");
    self.playerproxyagent = undefined;
    self.activeplayerstreak = undefined;
    return;
  }
}

function cleararchetype(var0) {
  scripts\mp\archetypes\archcommon::removearchetype(var0.loadoutarchetype);
  scripts\mp\class::loadout_clearperks();
}

function reapplyarchetype(var0) {
  var1 = undefined;

  switch (var0.loadoutarchetype) {
    case "archetype_assault":
      var1 = &scripts\mp\archetypes\archassault::applyarchetype;
      break;
  }

  scripts\mp\class::loadout_updateplayerperks(var0);

  if(isDefined(var1)) {
    self[[var1]]();
    return;
  }
}

function killproxy(var0) {}