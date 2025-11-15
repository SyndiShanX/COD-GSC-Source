/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_gameadvertisement.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_dev;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\shared\util_shared;
#namespace gameadvertisement;

function init() {
  level.sessionadvertstatus = 1;
  thread sessionadvertismentupdatedebughud();
  level.gameadvertisementrulescorepercent = getgametypesetting("gameAdvertisementRuleScorePercent");
  level.gameadvertisementruletimeleft = 60000 * getgametypesetting("gameAdvertisementRuleTimeLeft");
  level.gameadvertisementruleround = getgametypesetting("gameAdvertisementRuleRound");
  level.gameadvertisementruleroundswon = getgametypesetting("gameAdvertisementRuleRoundsWon");
  thread sessionadvertisementcheck();
}

function setadvertisedstatus(onoff) {
  level.sessionadvertstatus = onoff;
  changeadvertisedstatus(onoff);
}

function sessionadvertisementcheck() {
  if(sessionmodeisprivate()) {
    return;
  }
  runrules = getgametyperules();
  if(!isDefined(runrules)) {
    return;
  }
  level endon("game_end");
  level waittill("prematch_over");
  currentadvertisedstatus = undefined;
  while(true) {
    sessionadvertcheckwait = getdvarint("sessionAdvertCheckwait", 1);
    wait(sessionadvertcheckwait);
    advertise = [[runrules]]();
    if(!isDefined(currentadvertisedstatus) || (isDefined(advertise) && currentadvertisedstatus != advertise)) {
      setadvertisedstatus(advertise);
    }
    currentadvertisedstatus = advertise;
  }
}

function getgametyperules() {
  gametype = level.gametype;
  switch (gametype) {
    case "gun": {
      return & gun_rules;
    }
    default: {
      return & default_rules;
    }
  }
}

function teamscorelimitcheck(rulescorepercent, debug_count) {
  scorelimit = 0;
  if(level.roundscorelimit) {
    scorelimit = util::get_current_round_score_limit();
  } else if(level.scorelimit) {
    scorelimit = level.scorelimit;
  }
  if(scorelimit) {
    minscorepercentageleft = 100;
    foreach(team in level.teams) {
      scorepercentageleft = 100 - ((game["teamScores"][team] / scorelimit) * 100);
      if(minscorepercentageleft > scorepercentageleft) {
        minscorepercentageleft = scorepercentageleft;
      }
      if(rulescorepercent >= scorepercentageleft) {
        debug_count = updatedebughud(debug_count, "", int(scorepercentageleft));
        return false;
      }
    }
    debug_count = updatedebughud(debug_count, "", int(minscorepercentageleft));
  }
  return true;
}

function timelimitcheck(ruletimeleft) {
  maxtime = level.timelimit;
  if(maxtime != 0) {
    timeleft = globallogic_utils::gettimeremaining();
    if(ruletimeleft >= timeleft) {
      return false;
    }
  }
  return true;
}

function default_rules() {
  currentround = game["roundsplayed"] + 1;
  debug_count = 1;
  if(level.gameadvertisementrulescorepercent) {
    debug_count = updatedebughud(debug_count, "", level.gameadvertisementrulescorepercent);
    if(level.teambased) {
      if(currentround >= (level.gameadvertisementruleround - 1)) {
        if(teamscorelimitcheck(level.gameadvertisementrulescorepercent, debug_count) == 0) {
          return false;
        }
        debug_count++;
      }
    } else if(level.scorelimit) {
      highestscore = 0;
      players = getplayers();
      for(i = 0; i < players.size; i++) {
        if(players[i].pointstowin > highestscore) {
          highestscore = players[i].pointstowin;
        }
      }
      scorepercentageleft = 100 - ((highestscore / level.scorelimit) * 100);
      debug_count = updatedebughud(debug_count, "", int(scorepercentageleft));
      if(level.gameadvertisementrulescorepercent >= scorepercentageleft) {
        return false;
      }
    }
  }
  if(level.gameadvertisementruletimeleft && currentround >= (level.gameadvertisementruleround - 1)) {
    debug_count = updatedebughud(debug_count, "", level.gameadvertisementruletimeleft / 60000);
    if(timelimitcheck(level.gameadvertisementruletimeleft) == 0) {
      return false;
    }
  }
  if(level.gameadvertisementruleround) {
    debug_count = updatedebughud(debug_count, "", level.gameadvertisementruleround);
    debug_count = updatedebughud(debug_count, "", currentround);
    if(level.gameadvertisementruleround <= currentround) {
      return false;
    }
  }
  if(level.gameadvertisementruleroundswon) {
    debug_count = updatedebughud(debug_count, "", level.gameadvertisementruleroundswon);
    maxroundswon = 0;
    foreach(team in level.teams) {
      roundswon = game["teamScores"][team];
      if(maxroundswon < roundswon) {
        maxroundswon = roundswon;
      }
      if(level.gameadvertisementruleroundswon <= roundswon) {
        debug_count = updatedebughud(debug_count, "", maxroundswon);
        return false;
      }
    }
    debug_count = updatedebughud(debug_count, "", maxroundswon);
  }
  return true;
}

function gun_rules() {
  ruleweaponsleft = 3;
  updatedebughud(1, "", ruleweaponsleft);
  minweaponsleft = level.gunprogression.size;
  foreach(player in level.activeplayers) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.gunprogress)) {
      continue;
    }
    weaponsleft = level.gunprogression.size - player.gunprogress;
    if(minweaponsleft > weaponsleft) {
      minweaponsleft = weaponsleft;
    }
    if(ruleweaponsleft >= minweaponsleft) {
      updatedebughud(3, "", minweaponsleft);
      return false;
    }
  }
  updatedebughud(3, "", minweaponsleft);
  return true;
}

function sessionadvertismentcreatedebughud(linenum, alignx) {
  debug_hud = dev::new_hud("", "", 0, 0, 1);
  debug_hud.hidewheninmenu = 1;
  debug_hud.horzalign = "";
  debug_hud.vertalign = "";
  debug_hud.alignx = "";
  debug_hud.aligny = "";
  debug_hud.x = alignx;
  debug_hud.y = -50 + (linenum * 15);
  debug_hud.foreground = 1;
  debug_hud.font = "";
  debug_hud.fontscale = 1.5;
  debug_hud.color = (1, 1, 1);
  debug_hud.alpha = 1;
  debug_hud settext("");
  return debug_hud;
}

function updatedebughud(hudindex, text, value) {
  switch (hudindex) {
    case 1: {
      level.sessionadverthud_1a_text = text;
      level.sessionadverthud_1b_text = value;
      break;
    }
    case 2: {
      level.sessionadverthud_2a_text = text;
      level.sessionadverthud_2b_text = value;
      break;
    }
    case 3: {
      level.sessionadverthud_3a_text = text;
      level.sessionadverthud_3b_text = value;
      break;
    }
    case 4: {
      level.sessionadverthud_4a_text = text;
      level.sessionadverthud_4b_text = value;
      break;
    }
  }
  return hudindex + 1;
}

function sessionadvertismentupdatedebughud() {
  level endon("game_end");
  sessionadverthud_0 = undefined;
  sessionadverthud_1a = undefined;
  sessionadverthud_1b = undefined;
  sessionadverthud_2a = undefined;
  sessionadverthud_2b = undefined;
  sessionadverthud_3a = undefined;
  sessionadverthud_3b = undefined;
  sessionadverthud_4a = undefined;
  sessionadverthud_4b = undefined;
  level.sessionadverthud_0_text = "";
  level.sessionadverthud_1a_text = "";
  level.sessionadverthud_1b_text = "";
  level.sessionadverthud_2a_text = "";
  level.sessionadverthud_2b_text = "";
  level.sessionadverthud_3a_text = "";
  level.sessionadverthud_3b_text = "";
  level.sessionadverthud_4a_text = "";
  level.sessionadverthud_4b_text = "";
  while(true) {
    wait(1);
    showdebughud = getdvarint("", 0);
    level.sessionadverthud_0_text = "";
    if(level.sessionadvertstatus == 0) {
      level.sessionadverthud_0_text = "";
    }
    if(!isDefined(sessionadverthud_0) && showdebughud != 0) {
      host = util::gethostplayer();
      if(!isDefined(host)) {
        continue;
      }
      sessionadverthud_0 = host sessionadvertismentcreatedebughud(0, 0);
      sessionadverthud_1a = host sessionadvertismentcreatedebughud(1, -20);
      sessionadverthud_1b = host sessionadvertismentcreatedebughud(1, 0);
      sessionadverthud_2a = host sessionadvertismentcreatedebughud(2, -20);
      sessionadverthud_2b = host sessionadvertismentcreatedebughud(2, 0);
      sessionadverthud_3a = host sessionadvertismentcreatedebughud(3, -20);
      sessionadverthud_3b = host sessionadvertismentcreatedebughud(3, 0);
      sessionadverthud_4a = host sessionadvertismentcreatedebughud(4, -20);
      sessionadverthud_4b = host sessionadvertismentcreatedebughud(4, 0);
      sessionadverthud_1a.color = vectorscale((0, 1, 0), 0.5);
      sessionadverthud_1b.color = vectorscale((0, 1, 0), 0.5);
      sessionadverthud_2a.color = vectorscale((0, 1, 0), 0.5);
      sessionadverthud_2b.color = vectorscale((0, 1, 0), 0.5);
    }
    if(isDefined(sessionadverthud_0)) {
      if(showdebughud == 0) {
        sessionadverthud_0 destroy();
        sessionadverthud_1a destroy();
        sessionadverthud_1b destroy();
        sessionadverthud_2a destroy();
        sessionadverthud_2b destroy();
        sessionadverthud_3a destroy();
        sessionadverthud_3b destroy();
        sessionadverthud_4a destroy();
        sessionadverthud_4b destroy();
        sessionadverthud_0 = undefined;
        sessionadverthud_1a = undefined;
        sessionadverthud_1b = undefined;
        sessionadverthud_2a = undefined;
        sessionadverthud_2b = undefined;
        sessionadverthud_3a = undefined;
        sessionadverthud_3b = undefined;
        sessionadverthud_4a = undefined;
        sessionadverthud_4b = undefined;
      } else {
        if(level.sessionadvertstatus == 1) {
          sessionadverthud_0.color = (1, 1, 1);
        } else {
          sessionadverthud_0.color = vectorscale((1, 0, 0), 0.9);
        }
        sessionadverthud_0 settext(level.sessionadverthud_0_text);
        if(level.sessionadverthud_1a_text != "") {
          sessionadverthud_1a settext(level.sessionadverthud_1a_text);
          sessionadverthud_1b setvalue(level.sessionadverthud_1b_text);
        }
        if(level.sessionadverthud_2a_text != "") {
          sessionadverthud_2a settext(level.sessionadverthud_2a_text);
          sessionadverthud_2b setvalue(level.sessionadverthud_2b_text);
        }
        if(level.sessionadverthud_3a_text != "") {
          sessionadverthud_3a settext(level.sessionadverthud_3a_text);
          sessionadverthud_3b setvalue(level.sessionadverthud_3b_text);
        }
        if(level.sessionadverthud_4a_text != "") {
          sessionadverthud_4a settext(level.sessionadverthud_4a_text);
          sessionadverthud_4b setvalue(level.sessionadverthud_4b_text);
        }
      }
    }
  }
}