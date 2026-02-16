/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_proxyagent.gsc
**************************************************/

func_45D0(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.var_DAD6 = undefined;
  if(var_3 < 3) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_SCORESTREAK_ENDING");
    return 0;
  }

  var_6 = scripts\mp\killstreaks\killstreaks::func_D507(var_1, 1);
  if(!var_6) {
    return 0;
  }

  thread watchplayerkillstreakend(var_2);
  thread watchgameend();
  if(!isDefined(var_4) || !var_4) {
    thread watchplayerkillstreakearlyexit(var_2);
  }

  if(isalive(var_0) && !scripts\mp\utility::istrue(var_0.var_5F6F)) {
    startcontrol(var_0, var_1.streakname, var_2, var_5);
  } else {
    self notify(var_2);
    return 0;
  }

  return 1;
}

func_13B01(var_0, var_1) {
  self endon("disconnect");
  self endon(var_0);
  for(;;) {
    self waittill("player_killstreak_death", var_2, var_3, var_4, var_5, var_6, var_7);
    if(var_3 != self && isPlayer(var_3)) {
      var_3 notify("destroyed_killstreak", var_7);
      var_3 scripts\mp\utility::giveunifiedpoints("destroyed_" + var_1);
      thread scripts\mp\utility::teamplayercardsplash("callout_destroyed_" + var_1, var_3);
      thread scripts\mp\missions::killstreakkilled(var_1, self, self, undefined, var_3, var_4, var_6, var_7, "destroyed_" + var_1);
      thread scripts\mp\utility::leaderdialogonplayer(var_1 + "_destroyed", undefined, undefined, self.origin);
    }

    self notify(var_0, 1);
  }
}

watchplayerkillstreakdisconnect(var_0) {
  self endon(var_0);
  self waittill("disconnect");
  self notify(var_0, 1);
}

watchplayerkillstreakswitchteam(var_0) {
  self endon(var_0);
  self waittill("joined_team");
  self notify(var_0, 1);
}

watchplayerkillstreakearlyexit(var_0) {
  self endon("disconnect");
  self endon(var_0);
  for(;;) {
    var_1 = 0;
    while(self useButtonPressed()) {
      var_1 = var_1 + 0.05;
      if(var_1 > 0.75) {
        self.var_D3CB = self.origin;
        self notify(var_0);
        return;
      }

      wait(0.05);
    }

    wait(0.05);
  }
}

watchplayerkillstreaktimeout(var_0, var_1) {
  self endon("disconnect");
  self endon(var_0);
  wait(var_1);
  self notify(var_0, 1);
}

watchplayerkillstreakemp(var_0) {
  self endon("disconnect");
  self endon(var_0);
  self waittill("emp_damage", var_1, var_2);
}

watchplayerkillstreakend(var_0) {
  scripts\engine\utility::waittill_any(var_0, "level_game_ended");
  stopcontrol();
}

watchgameend() {
  level waittill("game_ended");
  self notify("level_game_ended");
}

startcontrol(var_0, var_1, var_2, var_3) {
  if(isDefined(self) && isalive(var_0)) {
    self controlagent(var_0);
    if(isDefined(var_3)) {
      self visionsetnakedforplayer(var_3, 0);
    }

    self.playerproxyagent = var_0;
  }
}

getplayerlookattarget(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "spiderbot":
      var_1 = 0.45;
      break;

    case "remote_c8":
      var_1 = -0.2;
      break;
  }

  return var_1;
}

stopcontrol() {
  if(isDefined(self)) {
    if(scripts\mp\utility::iscontrollingproxyagent()) {
      self restorecontrolagent();
      self visionsetnakedforplayer("", 0);
    }

    thread scripts\mp\killstreaks\killstreaks::func_11086(1);
    self.playerproxyagent = undefined;
    self.var_165A = undefined;
  }
}

cleararchetype(var_0) {
  scripts\mp\archetypes\archcommon::removearchetype(var_0.loadoutarchetype);
  scripts\mp\perks\perks::_clearperks();
}

func_DDA3(var_0) {
  var_1 = undefined;
  switch (var_0.loadoutarchetype) {
    case "archetype_assault":
      var_1 = scripts\mp\archetypes\archassault::applyarchetype;
      break;

    case "archetype_heavy":
      var_1 = scripts\mp\archetypes\archheavy::applyarchetype;
      break;

    case "archetype_scout":
      var_1 = scripts\mp\archetypes\archscout::applyarchetype;
      break;

    case "archetype_assassin":
      var_1 = scripts\mp\archetypes\archassassin::applyarchetype;
      break;

    case "archetype_engineer":
      var_1 = scripts\mp\archetypes\archengineer::applyarchetype;
      break;

    case "archetype_sniper":
      var_1 = scripts\mp\archetypes\archsniper::applyarchetype;
      break;
  }

  scripts\mp\class::loadout_updateplayerperks(var_0);
  if(isDefined(var_1)) {
    self[[var_1]]();
  }
}

func_A670(var_0) {}