/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gameadvertisement.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\dev;
#using scripts\mp_common\gametypes\globallogic_utils;
#namespace gameadvertisement;

function init() {
  level.sessionadvertstatus = 1;
  thread sessionadvertismentupdatedebughud();

  level.var_b02808b6 = getgametypesetting(#"hash_69f74281cacb8a0f");
  level.gameadvertisementrulescorepercent = getgametypesetting(#"gameadvertisementrulescorepercent");
  level.gameadvertisementruletimeleft = 60000 * getgametypesetting(#"gameadvertisementruletimeleft");
  level.gameadvertisementruleround = getgametypesetting(#"gameadvertisementruleround");
  level.gameadvertisementruleroundswon = getgametypesetting(#"gameadvertisementruleroundswon");

  if(!isDefined(level.var_a962eeb6)) {
    level.var_a962eeb6 = &default_rules;
  }

  callback::on_game_playing(&sessionadvertisementcheck);
}

function setadvertisedstatus(onoff) {
  level.sessionadvertstatus = onoff;

  changeadvertisedstatus(onoff);
}

function sessionadvertisementcheck() {
  if(sessionmodeisprivate()) {
    return;
  }

  if(!isDefined(level.var_a962eeb6)) {
    return;
  }

  level endon(#"game_end");

  for(currentadvertisedstatus = undefined; true; currentadvertisedstatus = advertise) {
    sessionadvertcheckwait = getdvarint(#"sessionadvertcheckwait", 1);
    wait sessionadvertcheckwait;
    advertise = [[level.var_a962eeb6]]();

    if(!isDefined(currentadvertisedstatus) || isDefined(advertise) && currentadvertisedstatus != advertise) {
      println("<dev string:x38>" + (advertise ? "<dev string:x4e>" : "<dev string:x56>"));
      setadvertisedstatus(advertise);
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

    foreach(team, _ in level.teams) {
      scorepercentageleft = 100 - game.stat[# "teamscores"][team] / scorelimit * 100;

      if(minscorepercentageleft > scorepercentageleft) {
        minscorepercentageleft = scorepercentageleft;
      }

      if(rulescorepercent >= scorepercentageleft) {
        debug_count = updatedebughud(debug_count, "<dev string:x5f>", int(scorepercentageleft));

        return false;
      }
    }

    debug_count = updatedebughud(debug_count, "<dev string:x5f>", int(minscorepercentageleft));
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
  currentround = game.roundsplayed + 1;
  debug_count = 1;

  if(level.gameadvertisementrulescorepercent) {
    debug_count = updatedebughud(debug_count, "<dev string:x7a>", level.gameadvertisementrulescorepercent);

    if(level.teambased) {
      if(currentround >= level.gameadvertisementruleround - 1) {
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

      scorepercentageleft = 100 - highestscore / level.scorelimit * 100;

      debug_count = updatedebughud(debug_count, "<dev string:x5f>", int(scorepercentageleft));

      if(level.gameadvertisementrulescorepercent >= scorepercentageleft) {
        return false;
      }
    }
  }

  if(level.gameadvertisementruletimeleft && currentround >= level.gameadvertisementruleround - 1) {
    debug_count = updatedebughud(debug_count, "<dev string:xae>", level.gameadvertisementruletimeleft / 60000);

    if(timelimitcheck(level.gameadvertisementruletimeleft) == 0) {
      return false;
    }
  }

  if(level.gameadvertisementruleround) {
    debug_count = updatedebughud(debug_count, "<dev string:xde>", level.gameadvertisementruleround);
    debug_count = updatedebughud(debug_count, "<dev string:xec>", currentround);

    if(level.gameadvertisementruleround <= currentround) {
      return false;
    }
  }

  if(level.gameadvertisementruleroundswon) {
    debug_count = updatedebughud(debug_count, "<dev string:xff>", level.gameadvertisementruleroundswon);

    maxroundswon = 0;

    foreach(team, _ in level.teams) {
      roundswon = game.stat[# "teamscores"][team];

      if(maxroundswon < roundswon) {
        maxroundswon = roundswon;
      }

      if(level.gameadvertisementruleroundswon <= roundswon) {
        debug_count = updatedebughud(debug_count, "<dev string:x11c>", maxroundswon);

        return false;
      }
    }

    debug_count = updatedebughud(debug_count, "<dev string:x11c>", maxroundswon);
  }

  return true;
}

function sessionadvertismentcreatedebughud(linenum, alignx) {
  debug_hud = dev::new_hud("<dev string:x130>", "<dev string:x142>", 0, 0, 1);
  debug_hud.hidewheninmenu = 1;
  debug_hud.horzalign = "<dev string:x14f>";
  debug_hud.vertalign = "<dev string:x158>";
  debug_hud.alignx = "<dev string:x14f>";
  debug_hud.aligny = "<dev string:x158>";
  debug_hud.x = alignx;
  debug_hud.y = -50 + linenum * 15;
  debug_hud.foreground = 1;
  debug_hud.font = "<dev string:x162>";
  debug_hud.fontscale = 1.5;
  debug_hud.color = (1, 1, 1);
  debug_hud.alpha = 1;
  debug_hud settext("<dev string:x16d>");
  return debug_hud;
}

function updatedebughud(hudindex, text, value) {
  switch (hudindex) {
    case 1:
      level.sessionadverthud_1a_text = text;
      level.sessionadverthud_1b_text = value;
      break;
    case 2:
      level.sessionadverthud_2a_text = text;
      level.sessionadverthud_2b_text = value;
      break;
    case 3:
      level.sessionadverthud_3a_text = text;
      level.sessionadverthud_3b_text = value;
      break;
    case 4:
      level.sessionadverthud_4a_text = text;
      level.sessionadverthud_4b_text = value;
      break;
  }

  return hudindex + 1;
}

function sessionadvertismentupdatedebughud() {
  level endon(#"game_end");
  sessionadverthud_0 = undefined;
  sessionadverthud_1a = undefined;
  sessionadverthud_1b = undefined;
  sessionadverthud_2a = undefined;
  sessionadverthud_2b = undefined;
  sessionadverthud_3a = undefined;
  sessionadverthud_3b = undefined;
  sessionadverthud_4a = undefined;
  sessionadverthud_4b = undefined;
  level.sessionadverthud_0_text = "<dev string:x16d>";
  level.sessionadverthud_1a_text = "<dev string:x16d>";
  level.sessionadverthud_1b_text = "<dev string:x16d>";
  level.sessionadverthud_2a_text = "<dev string:x16d>";
  level.sessionadverthud_2b_text = "<dev string:x16d>";
  level.sessionadverthud_3a_text = "<dev string:x16d>";
  level.sessionadverthud_3b_text = "<dev string:x16d>";
  level.sessionadverthud_4a_text = "<dev string:x16d>";
  level.sessionadverthud_4b_text = "<dev string:x16d>";

  while(true) {
    wait 1;
    showdebughud = getdvarint(#"sessionadvertshowdebughud", 0);
    level.sessionadverthud_0_text = "<dev string:x171>";

    if(level.sessionadvertstatus == 0) {
      level.sessionadverthud_0_text = "<dev string:x18a>";
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
      sessionadverthud_1a.color = (0, 0.5, 0);
      sessionadverthud_1b.color = (0, 0.5, 0);
      sessionadverthud_2a.color = (0, 0.5, 0);
      sessionadverthud_2b.color = (0, 0.5, 0);
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
        continue;
      }

      if(level.sessionadvertstatus == 1) {
        sessionadverthud_0.color = (1, 1, 1);
      } else {
        sessionadverthud_0.color = (0.9, 0, 0);
      }

      sessionadverthud_0 settext(level.sessionadverthud_0_text);

      if(level.sessionadverthud_1a_text != "<dev string:x16d>") {
        sessionadverthud_1a settext(level.sessionadverthud_1a_text);
        sessionadverthud_1b setvalue(level.sessionadverthud_1b_text);
      }

      if(level.sessionadverthud_2a_text != "<dev string:x16d>") {
        sessionadverthud_2a settext(level.sessionadverthud_2a_text);
        sessionadverthud_2b setvalue(level.sessionadverthud_2b_text);
      }

      if(level.sessionadverthud_3a_text != "<dev string:x16d>") {
        sessionadverthud_3a settext(level.sessionadverthud_3a_text);
        sessionadverthud_3b setvalue(level.sessionadverthud_3b_text);
      }

      if(level.sessionadverthud_4a_text != "<dev string:x16d>") {
        sessionadverthud_4a settext(level.sessionadverthud_4a_text);
        sessionadverthud_4b setvalue(level.sessionadverthud_4b_text);
      }
    }
  }
}