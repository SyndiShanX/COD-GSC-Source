/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\proxyagent.gsc
*************************************************/

function controlproxyagent(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.proxydisableweapon = undefined;

  if(var_3 < 3) {
    return false;
  }

  var_6 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_1);

  if(!var_6) {
    return false;
  }

  thread watchplayerkillstreakend(var_2);
  thread watchgameend();

  if(!isDefined(var_4) || !var_4) {
    thread watchplayerkillstreakearlyexit(var_2);
  }

  if(isalive(var_0) && !istrue(var_0.dying)) {
    startcontrol(var_0, var_1.streakname, var_2, var_5);
  } else {
    self notify(var_2);
    return false;
  }

  return true;
}

function watchplayerkillstreakdeath(var_0, var_1) {
  self endon("disconnect");
  self endon(var_0);

  for(;;) {
    self waittill("player_killstreak_death", var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_3 != self && isPlayer(var_3)) {
      var_3 scripts\mp\utility\points::giveunifiedpoints("destroyed_" + var_1);
      thread scripts\mp\hud_util::teamplayercardsplash("callout_destroyed_" + var_1, var_3);
      var_8 = asmdevgetallstates(var_7);
      thread scripts\cp\vehicles\vehicle_compass_cp::killstreakkilled(var_1, self, self, var_3, var_4, var_6, var_8, "destroyed_" + var_1);
      thread scripts\mp\utility\dialog::leaderdialogonplayer(var_1 + "_destroyed", undefined, undefined, self.origin);
    }

    self notify(var_0, 1);
  }
}

function watchplayerkillstreakdisconnect(var_0) {
  self endon(var_0);
  self waittill("disconnect");
  self notify(var_0, 1);
}

function watchplayerkillstreakswitchteam(var_0) {
  self endon(var_0);
  self waittill("joined_team");
  self notify(var_0, 1);
}

function watchplayerkillstreakearlyexit(var_0) {
  self endon("disconnect");
  self endon(var_0);
  var_1 = level.framedurationseconds;

  for(;;) {
    var_2 = 0;

    while(self useButtonPressed()) {
      var_2 += var_1;

      if(var_2 > 0.75) {
        self.playerkillstreakearlyexitlocation = self.origin;
        self notify(var_0);
        return;
      }

      wait var_1;
    }

    waitframe();
  }
}

function watchplayerkillstreaktimeout(var_0, var_1) {
  self endon("disconnect");
  self endon(var_0);
  wait var_1;
  self notify(var_0, 1);
}

function watchplayerkillstreakemp(var_0) {
  self endon("disconnect");
  self endon(var_0);

  for(;;) {
    self waittill("emp_damage", var_1, var_2);
  }
}

function watchplayerkillstreakend(var_0) {
  scripts\engine\utility::ref_143A5(var_0, "level_game_ended");
  stopcontrol();
}

function watchgameend() {
  level waittill("game_ended");
  self notify("level_game_ended");
}

function startcontrol(var_0, var_1, var_2, var_3) {
  if(isDefined(self) && isalive(var_0)) {
    self controlagent(var_0);

    if(isDefined(var_3)) {
      self visionsetnakedforplayer(var_3, 0);
    }

    self.playerproxyagent = var_0;
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

function cleararchetype(var_0) {
  scripts\mp\archetypes\archcommon::removearchetype(var_0.loadoutarchetype);
  scripts\mp\class::loadout_clearperks();
}

function reapplyarchetype(var_0) {
  var_1 = undefined;

  switch (var_0.loadoutarchetype) {
    case "archetype_assault":
      var_1 = &scripts\mp\archetypes\archassault::applyarchetype;
      break;
  }

  scripts\mp\class::loadout_updateplayerperks(var_0);

  if(isDefined(var_1)) {
    self[[var_1]]();
    return;
  }
}

function killproxy(var_0) {}