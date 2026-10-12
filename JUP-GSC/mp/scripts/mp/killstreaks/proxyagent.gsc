/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\proxyagent.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\engine\utility;
#using scripts\mp\archetypes\archassault;
#using scripts\mp\archetypes\archcommon;
#using scripts\mp\class;
#using scripts\mp\hud_util;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\points;
#namespace proxyagent;

function controlproxyagent(agent, streakinfo, endnotifymsg, playerkillstreaktimeout, var_f661e51eafc4f486, visionset) {
  self.proxydisableweapon = undefined;

  if(playerkillstreaktimeout < 3) {
    return false;
  }

  result = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo);

  if(!result) {
    return false;
  }

  thread watchplayerkillstreakend(endnotifymsg);
  thread watchgameend();

  if(!isDefined(var_f661e51eafc4f486) || !var_f661e51eafc4f486) {
    thread watchplayerkillstreakearlyexit(endnotifymsg);
  }

  if(isalive(agent) && !istrue(agent.dying)) {
    startcontrol(agent, streakinfo.streakname, endnotifymsg, visionset);
  } else {
    self notify(endnotifymsg);
    return false;
  }

  return true;
}

function watchplayerkillstreakdeath(endnotifymsg, streakname) {
  self endon("disconnect");
  self endon(endnotifymsg);

  while(true) {
    self waittill("player_killstreak_death", einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon);

    if(eattacker != self && isPlayer(eattacker)) {
      eattacker thread doscoreevent(hashcat(#"destroyed_", streakname));
      thread teamplayercardsplash("callout_destroyed_" + streakname, eattacker);
      objweapon = makeweaponfromstring(sweapon);
      thread scripts\cp_mp\challenges::killstreakkilled(streakname, self, self, eattacker, idamage, smeansofdeath, objweapon, "destroyed_" + streakname);
      thread scripts\mp\utility\dialog::leaderdialogonplayer(streakname + "_destroyed", undefined, undefined, self.origin);
    }

    self notify(endnotifymsg, 1);
  }
}

function watchplayerkillstreakdisconnect(endnotifymsg) {
  self endon(endnotifymsg);
  self waittill("disconnect");
  self notify(endnotifymsg, 1);
}

function watchplayerkillstreakswitchteam(endnotifymsg) {
  self endon(endnotifymsg);
  self waittill("joined_team");
  self notify(endnotifymsg, 1);
}

function watchplayerkillstreakearlyexit(endnotifymsg) {
  self endon("disconnect");
  self endon(endnotifymsg);
  updaterate = level.framedurationseconds;

  while(true) {
    timeused = 0;

    while(self useButtonPressed()) {
      timeused += updaterate;

      if(timeused > 0.75) {
        self.playerkillstreakearlyexitlocation = self.origin;
        self notify(endnotifymsg);
        return;
      }

      wait updaterate;
    }

    waitframe();
  }
}

function watchplayerkillstreaktimeout(endnotifymsg, var_e6bcba36402ee560) {
  self endon("disconnect");
  self endon(endnotifymsg);
  wait var_e6bcba36402ee560;
  self notify(endnotifymsg, 1);
}

function watchplayerkillstreakemp(endnotifymsg) {
  self endon("disconnect");
  self endon(endnotifymsg);

  while(true) {
    self waittill("emp_damage", attacker, duration);
  }
}

function watchplayerkillstreakend(endnotifymsg) {
  waittill_any_2(endnotifymsg, "level_game_ended");
  stopcontrol();
}

function watchgameend() {
  level waittill("game_ended");
  self notify("level_game_ended");
}

function startcontrol(agent, streakname, endnotifymsg, visionset) {
  if(isDefined(self) && isalive(agent)) {
    self controlagent(agent);

    if(isDefined(visionset)) {
      self visionsetnakedforplayer(visionset, 0);
    }

    self.playerproxyagent = agent;
  }
}

function stopcontrol() {
  if(isDefined(self)) {
    if(iscontrollingproxyagent()) {
      self restorecontrolagent();
      self visionsetnakedforplayer("", 0);
    }

    assertmsg("<dev string:x1c>");
    self.streakinfo notify("killstreak_finished_with_deploy_weapon");
    self.playerproxyagent = undefined;
  }
}

function cleararchetype(classstruct) {
  scripts\mp\archetypes\archcommon::removearchetype(classstruct.loadoutarchetype);
  scripts\mp\class::loadout_clearperks();
}

function reapplyarchetype(classstruct) {
  funcapply = undefined;

  switch (classstruct.loadoutarchetype) {
    case #"hash_98ff6f21872f18e0":
      funcapply = &scripts\mp\archetypes\archassault::applyarchetype;
      break;
  }

  scripts\mp\class::loadout_updateplayerperks(classstruct);

  if(isDefined(funcapply)) {
    self[[funcapply]]();
  }
}

function killproxy(keepcorpse) {}