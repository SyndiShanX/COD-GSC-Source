/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_proxyagent.gsc
**************************************************/

func_45D0(param_00, param_01, param_02, param_03, param_04, param_05) {
  self.var_DAD6 = undefined;
  if(param_03 < 3) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_SCORESTREAK_ENDING");
    return 0;
  }

  var_06 = scripts\mp\killstreaks\_killstreaks::func_D507(param_01, 1);
  if(!var_06) {
    return 0;
  }

  thread watchplayerkillstreakend(param_02);
  thread watchgameend();
  if(!isDefined(param_04) || !param_04) {
    thread watchplayerkillstreakearlyexit(param_02);
  }

  if(isalive(param_00) && !scripts\mp\utility::istrue(param_00.var_5F6F)) {
    startcontrol(param_00, param_01.streakname, param_02, param_05);
  } else {
    self notify(param_02);
    return 0;
  }

  return 1;
}

func_13B01(param_00, param_01) {
  self endon("disconnect");
  self endon(param_00);
  for(;;) {
    self waittill("player_killstreak_death", var_02, var_03, var_04, var_05, var_06, var_07);
    if(var_03 != self && isplayer(var_03)) {
      var_03 notify("destroyed_killstreak", var_07);
      var_03 scripts\mp\utility::giveunifiedpoints("destroyed_" + param_01);
      thread scripts\mp\utility::teamplayercardsplash("callout_destroyed_" + param_01, var_03);
      thread scripts\mp\missions::killstreakkilled(param_01, self, self, undefined, var_03, var_04, var_06, var_07, "destroyed_" + param_01);
      thread scripts\mp\utility::leaderdialogonplayer(param_01 + "_destroyed", undefined, undefined, self.origin);
    }

    self notify(param_00, 1);
  }
}

watchplayerkillstreakdisconnect(param_00) {
  self endon(param_00);
  self waittill("disconnect");
  self notify(param_00, 1);
}

watchplayerkillstreakswitchteam(param_00) {
  self endon(param_00);
  self waittill("joined_team");
  self notify(param_00, 1);
}

watchplayerkillstreakearlyexit(param_00) {
  self endon("disconnect");
  self endon(param_00);
  for(;;) {
    var_01 = 0;
    while(self usebuttonpressed()) {
      var_01 = var_01 + 0.05;
      if(var_01 > 0.75) {
        self.var_D3CB = self.origin;
        self notify(param_00);
        return;
      }

      wait(0.05);
    }

    wait(0.05);
  }
}

watchplayerkillstreaktimeout(param_00, param_01) {
  self endon("disconnect");
  self endon(param_00);
  wait(param_01);
  self notify(param_00, 1);
}

watchplayerkillstreakemp(param_00) {
  self endon("disconnect");
  self endon(param_00);
  self waittill("emp_damage", var_01, var_02);
}

watchplayerkillstreakend(param_00) {
  scripts\engine\utility::waittill_any_3(param_00, "level_game_ended");
  stopcontrol();
}

watchgameend() {
  level waittill("game_ended");
  self notify("level_game_ended");
}

startcontrol(param_00, param_01, param_02, param_03) {
  if(isDefined(self) && isalive(param_00)) {
    self controlagent(param_00);
    if(isDefined(param_03)) {
      self visionsetnakedforplayer(param_03, 0);
    }

    self.playerproxyagent = param_00;
  }
}

getplayerlookattarget(param_00) {
  var_01 = 0;
  switch (param_00) {
    case "spiderbot":
      var_01 = 0.45;
      break;

    case "remote_c8":
      var_01 = -0.2;
      break;
  }

  return var_01;
}

stopcontrol() {
  if(isDefined(self)) {
    if(scripts\mp\utility::iscontrollingproxyagent()) {
      self restorecontrolagent();
      self visionsetnakedforplayer("", 0);
    }

    thread scripts\mp\killstreaks\_killstreaks::func_11086(1);
    self.playerproxyagent = undefined;
    self.var_165A = undefined;
  }
}

cleararchetype(param_00) {
  scripts\mp\archetypes\archcommon::removearchetype(param_00.loadoutarchetype);
  scripts\mp\perks\_perks::_clearperks();
}

func_DDA3(param_00) {
  var_01 = undefined;
  switch (param_00.loadoutarchetype) {
    case "archetype_assault":
      var_01 = ::scripts\mp\archetypes\archassault::applyarchetype;
      break;

    case "archetype_heavy":
      var_01 = ::scripts\mp\archetypes\archheavy::applyarchetype;
      break;

    case "archetype_scout":
      var_01 = ::scripts\mp\archetypes\archscout::applyarchetype;
      break;

    case "archetype_assassin":
      var_01 = ::scripts\mp\archetypes\archassassin::applyarchetype;
      break;

    case "archetype_engineer":
      var_01 = ::scripts\mp\archetypes\archengineer::applyarchetype;
      break;

    case "archetype_sniper":
      var_01 = ::scripts\mp\archetypes\archsniper::applyarchetype;
      break;
  }

  scripts\mp\class::loadout_updateplayerperks(param_00);
  if(isDefined(var_01)) {
    self[[var_01]]();
  }
}

func_A670(param_00) {}