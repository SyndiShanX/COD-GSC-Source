/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\proxyagent.gsc
*************************************************/

controlproxyagent(agent, streakinfo, _id_5F321A57443E1A54, _id_CC5090D95E0C16D9, _id_F661E51EAFC4F486, _id_FC0043E95242D5CB) {
  self.proxydisableweapon = undefined;

  if(_id_CC5090D95E0C16D9 < 3.0)
    return 0;

  result = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo);

  if(!result)
    return 0;

  thread watchplayerkillstreakend(_id_5F321A57443E1A54);
  thread watchgameend();

  if(!isDefined(_id_F661E51EAFC4F486) || !_id_F661E51EAFC4F486)
    thread watchplayerkillstreakearlyexit(_id_5F321A57443E1A54);

  if(isalive(agent) && !istrue(agent.dying))
    startcontrol(agent, streakinfo.streakname, _id_5F321A57443E1A54, _id_FC0043E95242D5CB);
  else {
    self notify(_id_5F321A57443E1A54);
    return 0;
  }

  return 1;
}

watchplayerkillstreakdeath(_id_5F321A57443E1A54, streakname) {
  self endon("disconnect");
  self endon(_id_5F321A57443E1A54);

  for(;;) {
    self waittill("player_killstreak_death", einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon);

    if(eattacker != self && isPlayer(eattacker)) {
      eattacker thread scripts\mp\utility\points::_id_0366980B6A8796AE(_func_2EF675C13CA1C4AF("stat_88CC18B8BCCF6B09", streakname));
      thread scripts\mp\hud_util::teamplayercardsplash("callout_destroyed_" + streakname, eattacker);
      objweapon = makeweaponfromstring(sweapon);
      thread scripts\cp_mp\challenges::killstreakkilled(streakname, self, self, eattacker, idamage, smeansofdeath, objweapon, "destroyed_" + streakname);
      thread scripts\mp\utility\dialog::leaderdialogonplayer(streakname + "_destroyed", undefined, undefined, self.origin);
    }

    self notify(_id_5F321A57443E1A54, 1);
  }
}

watchplayerkillstreakdisconnect(_id_5F321A57443E1A54) {
  self endon(_id_5F321A57443E1A54);
  self waittill("disconnect");
  self notify(_id_5F321A57443E1A54, 1);
}

watchplayerkillstreakswitchteam(_id_5F321A57443E1A54) {
  self endon(_id_5F321A57443E1A54);
  self waittill("joined_team");
  self notify(_id_5F321A57443E1A54, 1);
}

watchplayerkillstreakearlyexit(_id_5F321A57443E1A54) {
  self endon("disconnect");
  self endon(_id_5F321A57443E1A54);
  _id_038FC7BD1495C4B2 = level.framedurationseconds;

  for(;;) {
    _id_23B90B34FECC58CD = 0;

    while(self useButtonPressed()) {
      _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + _id_038FC7BD1495C4B2;

      if(_id_23B90B34FECC58CD > 0.75) {
        self.playerkillstreakearlyexitlocation = self.origin;
        self notify(_id_5F321A57443E1A54);
        return;
      }

      wait(_id_038FC7BD1495C4B2);
    }

    waitframe();
  }
}

watchplayerkillstreaktimeout(_id_5F321A57443E1A54, _id_E6BCBA36402EE560) {
  self endon("disconnect");
  self endon(_id_5F321A57443E1A54);
  wait(_id_E6BCBA36402EE560);
  self notify(_id_5F321A57443E1A54, 1);
}

watchplayerkillstreakemp(_id_5F321A57443E1A54) {
  self endon("disconnect");
  self endon(_id_5F321A57443E1A54);

  for(;;)
    self waittill("emp_damage", attacker, duration);
}

watchplayerkillstreakend(_id_5F321A57443E1A54) {
  scripts\engine\utility::waittill_any_2(_id_5F321A57443E1A54, "level_game_ended");
  stopcontrol();
}

watchgameend() {
  level waittill("game_ended");
  self notify("level_game_ended");
}

startcontrol(agent, streakname, _id_5F321A57443E1A54, _id_FC0043E95242D5CB) {
  if(isDefined(self) && isalive(agent)) {
    self controlagent(agent);

    if(isDefined(_id_FC0043E95242D5CB))
      self visionsetnakedforplayer(_id_FC0043E95242D5CB, 0);

    self.playerproxyagent = agent;
  }
}

stopcontrol() {
  if(isDefined(self)) {
    if(scripts\mp\utility\killstreak::iscontrollingproxyagent()) {
      self restorecontrolagent();
      self visionsetnakedforplayer("", 0);
    }

    self.streakinfo notify("killstreak_finished_with_deploy_weapon");
    self.playerproxyagent = undefined;
    self.activeplayerstreak = undefined;
  }
}

cleararchetype(classstruct) {
  scripts\mp\archetypes\archcommon::removearchetype(classstruct.loadoutarchetype);
  scripts\mp\class::loadout_clearperks();
}

reapplyarchetype(classstruct) {
  _id_98A729282E6315AD = undefined;

  switch (classstruct.loadoutarchetype) {
    case "archetype_assault":
      _id_98A729282E6315AD = scripts\mp\archetypes\archassault::applyarchetype;
      break;
  }

  scripts\mp\class::loadout_updateplayerperks(classstruct);

  if(isDefined(_id_98A729282E6315AD))
    self[[_id_98A729282E6315AD]]();
}

killproxy(_id_A140225D999DA9A8) {}