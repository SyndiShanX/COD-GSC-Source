/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3512.gsc
***************************************/

func_45D0(var_00, var_01, var_02, var_03, var_04, var_05) {
  self.func_DAD6 = undefined;

  if(var_03 < 3.0) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_SCORESTREAK_ENDING");
    return 0;
  }

  var_06 = scripts\mp\killstreaks\killstreaks::func_D507(var_01, 1);

  if(!var_06) {
    return 0;
  }

  thread watchplayerkillstreakend(var_02);
  thread watchgameend();

  if(!isDefined(var_04) || !var_04) {
    thread watchplayerkillstreakearlyexit(var_02);
  }

  if(isalive(var_00) && !scripts\mp\utility\game::istrue(var_0.func_5F6F)) {
    startcontrol(var_00, var_1.streakname, var_02, var_05);
  } else {
    self notify(var_02);
    return 0;
  }

  return 1;
}

func_13B01(var_00, var_01) {
  self endon("disconnect");
  self endon(var_00);

  for(;;) {
    self waittill("player_killstreak_death", var_02, var_03, var_04, var_05, var_06, var_07);

    if(var_03 != self && isplayer(var_03)) {
      var_03 notify("destroyed_killstreak", var_07);
      var_03 scripts\mp\utility\game::giveunifiedpoints("destroyed_" + var_01);
      thread scripts\mp\utility\game::teamplayercardsplash("callout_destroyed_" + var_01, var_03);
      thread scripts\mp\missions::killstreakkilled(var_01, self, self, undefined, var_03, var_04, var_06, var_07, "destroyed_" + var_01);
      thread scripts\mp\utility\game::leaderdialogonplayer(var_01 + "_destroyed", undefined, undefined, self.origin);
    }

    self notify(var_00, 1);
  }
}

watchplayerkillstreakdisconnect(var_00) {
  self endon(var_00);
  self waittill("disconnect");
  self notify(var_00, 1);
}

watchplayerkillstreakswitchteam(var_00) {
  self endon(var_00);
  self waittill("joined_team");
  self notify(var_00, 1);
}

watchplayerkillstreakearlyexit(var_00) {
  self endon("disconnect");
  self endon(var_00);

  for(;;) {
    var_01 = 0;

    while(self usebuttonpressed()) {
      var_01 = var_01 + 0.05;

      if(var_01 > 0.75) {
        self.func_D3CB = self.origin;
        self notify(var_00);
        return;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

watchplayerkillstreaktimeout(var_00, var_01) {
  self endon("disconnect");
  self endon(var_00);
  wait(var_01);
  self notify(var_00, 1);
}

watchplayerkillstreakemp(var_00) {
  self endon("disconnect");
  self endon(var_00);

  for(;;) {
    self waittill("emp_damage", var_01, var_02);
  }
}

watchplayerkillstreakend(var_00) {
  scripts\engine\utility::waittill_any(var_00, "level_game_ended");
  stopcontrol();
}

watchgameend() {
  level waittill("game_ended");
  self notify("level_game_ended");
}

startcontrol(var_00, var_01, var_02, var_03) {
  if(isDefined(self) && isalive(var_00)) {
    self controlagent(var_00);

    if(isDefined(var_03)) {
      self visionsetnakedforplayer(var_03, 0);
    }

    self.playerproxyagent = var_00;
  }
}

getplayerlookattarget(var_00) {
  var_01 = 0;

  switch (var_00) {
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
    if(scripts\mp\utility\game::iscontrollingproxyagent()) {
      self restorecontrolagent();
      self visionsetnakedforplayer("", 0);
    }

    thread scripts\mp\killstreaks\killstreaks::func_11086(1);
    self.playerproxyagent = undefined;
    self.func_165A = undefined;
  }
}

cleararchetype(var_00) {
  scripts\mp\archetypes\archcommon::removearchetype(var_0.loadoutarchetype);
  scripts\mp\perks::_clearperks();
}

func_DDA3(var_00) {
  var_01 = undefined;

  switch (var_0.loadoutarchetype) {
    case "archetype_assault":
      var_01 = scripts\mp\archetypes\archassault::applyarchetype;
      break;
    case "archetype_heavy":
      var_01 = scripts\mp\archetypes\archheavy::applyarchetype;
      break;
    case "archetype_scout":
      var_01 = scripts\mp\archetypes\archscout::applyarchetype;
      break;
    case "archetype_assassin":
      var_01 = scripts\mp\archetypes\archassassin::applyarchetype;
      break;
    case "archetype_engineer":
      var_01 = scripts\mp\archetypes\archengineer::applyarchetype;
      break;
    case "archetype_sniper":
      var_01 = scripts\mp\archetypes\archsniper::applyarchetype;
      break;
  }

  scripts\mp\class::loadout_updateplayerperks(var_00);

  if(isDefined(var_01)) {
    self[[var_01]]();
  }
}

func_A670(var_00) {}