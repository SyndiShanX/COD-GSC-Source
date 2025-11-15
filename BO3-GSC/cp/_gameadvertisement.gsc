/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_gameadvertisement.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_dev;
#using scripts\cp\gametypes\_globallogic_utils;
#using scripts\shared\util_shared;
#namespace gameadvertisement;

function init() {
  level.sessionadvertstatus = 1;
  thread sessionadvertismentupdatedebughud();
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
  if(sessionmodeiszombiesgame()) {
    setadvertisedstatus(0);
    return;
  }
  runrules = getgametyperules();
  if(!isDefined(runrules)) {
    return;
  }
  level endon("game_end");
  level waittill("prematch_over");
  while(true) {
    sessionadvertcheckwait = getdvarint("sessionAdvertCheckwait", 1);
    wait(sessionadvertcheckwait);
    advertise = [[runrules]]();
    setadvertisedstatus(advertise);
  }
}

function getgametyperules() {
  gametype = level.gametype;
  switch (gametype) {
    case "dm": {
      return & dm_rules;
    }
    case "tdm": {
      return & tdm_rules;
    }
    case "dom": {
      return & dom_rules;
    }
    case "hq": {
      return & hq_rules;
    }
    case "sd": {
      return & sd_rules;
    }
    case "dem": {
      return & dem_rules;
    }
    case "ctf": {
      return & ctf_rules;
    }
    case "koth": {
      return & koth_rules;
    }
    case "conf": {
      return & conf_rules;
    }
    case "oic": {
      return & oic_rules;
    }
    case "sas": {
      return & sas_rules;
    }
    case "gun": {
      return & gun_rules;
    }
    case "shrp": {
      return & shrp_rules;
    }
  }
}

function teamscorelimitcheck(rulescorepercent) {
  if(level.scorelimit) {
    minscorepercentageleft = 100;
    foreach(team in level.teams) {
      scorepercentageleft = 100 - ((game["teamScores"][team] / level.scorelimit) * 100);
      if(minscorepercentageleft > scorepercentageleft) {
        minscorepercentageleft = scorepercentageleft;
      }
      if(rulescorepercent >= scorepercentageleft) {
        updatedebughud(3, "", int(scorepercentageleft));
        return false;
      }
    }
    updatedebughud(3, "", int(minscorepercentageleft));
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

function dm_rules() {
  rulescorepercent = 35;
  ruletimeleft = 60000 * 1.5;
  updatedebughud(1, "", rulescorepercent);
  updatedebughud(2, "", ruletimeleft / 60000);
  if(level.scorelimit) {
    highestscore = 0;
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(players[i].pointstowin > highestscore) {
        highestscore = players[i].pointstowin;
      }
    }
    scorepercentageleft = 100 - ((highestscore / level.scorelimit) * 100);
    updatedebughud(3, "", int(scorepercentageleft));
    if(rulescorepercent >= scorepercentageleft) {
      return false;
    }
  }
  if(timelimitcheck(ruletimeleft) == 0) {
    return false;
  }
  return true;
}

function tdm_rules() {
  rulescorepercent = 15;
  ruletimeleft = 60000 * 1.5;
  updatedebughud(1, "", rulescorepercent);
  updatedebughud(2, "", ruletimeleft / 60000);
  if(teamscorelimitcheck(rulescorepercent) == 0) {
    return false;
  }
  if(timelimitcheck(ruletimeleft) == 0) {
    return false;
  }
  return true;
}

function dom_rules() {
  rulescorepercent = 15;
  ruletimeleft = 60000 * 1.5;
  ruleround = 3;
  currentround = game["roundsplayed"] + 1;
  updatedebughud(1, "", rulescorepercent);
  updatedebughud(2, "", ruleround);
  updatedebughud(4, "", currentround);
  if(currentround >= 2) {
    if(teamscorelimitcheck(rulescorepercent) == 0) {
      return false;
    }
  }
  if(timelimitcheck(ruletimeleft) == 0) {
    return false;
  }
  if(ruleround <= currentround) {
    return false;
  }
  return true;
}

function hq_rules() {
  return koth_rules();
}

function sd_rules() {
  ruleround = 3;
  updatedebughud(1, "", ruleround);
  maxroundswon = 0;
  foreach(team in level.teams) {
    roundswon = game["teamScores"][team];
    if(maxroundswon < roundswon) {
      maxroundswon = roundswon;
    }
    if(ruleround <= roundswon) {
      updatedebughud(3, "", maxroundswon);
      return false;
    }
  }
  updatedebughud(3, "", maxroundswon);
  return true;
}

function dem_rules() {
  return ctf_rules();
}

function ctf_rules() {
  ruleround = 3;
  roundsplayed = game["roundsplayed"];
  updatedebughud(1, "", ruleround);
  updatedebughud(3, "", roundsplayed);
  if(ruleround <= roundsplayed) {
    return false;
  }
  return true;
}

function koth_rules() {
  rulescorepercent = 20;
  ruletimeleft = 60000 * 1.5;
  updatedebughud(1, "", rulescorepercent);
  updatedebughud(2, "", ruletimeleft / 60000);
  if(teamscorelimitcheck(rulescorepercent) == 0) {
    return false;
  }
  if(timelimitcheck(ruletimeleft) == 0) {
    return false;
  }
  return true;
}

function conf_rules() {
  return tdm_rules();
}

function oic_rules() {
  updatedebughud(1, "", 0);
  return false;
}

function sas_rules() {
  rulescorepercent = 35;
  ruletimeleft = 60000 * 1.5;
  updatedebughud(1, "", rulescorepercent);
  updatedebughud(2, "", ruletimeleft / 60000);
  if(teamscorelimitcheck(rulescorepercent) == 0) {
    return false;
  }
  if(timelimitcheck(ruletimeleft) == 0) {
    return false;
  }
  return true;
}

function gun_rules() {
  ruleweaponsleft = 3;
  updatedebughud(1, "", ruleweaponsleft);
  minweaponsleft = level.gunprogression.size;
  foreach(player in level.players) {
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

function shrp_rules() {
  rulescorepercent = 35;
  ruletimeleft = 60000 * 1.5;
  updatedebughud(1, "", rulescorepercent);
  updatedebughud(2, "", ruletimeleft / 60000);
  if(teamscorelimitcheck(rulescorepercent) == 0) {
    return false;
  }
  if(timelimitcheck(ruletimeleft) == 0) {
    return false;
  }
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