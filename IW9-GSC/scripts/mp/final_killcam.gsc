/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\final_killcam.gsc
***********************************************/

initfinalkillcam() {
  level.finalkillcamenabled = level.finalkillcamtype == 0;
  level.finalkillcams = [];

  foreach(_id_FABF84450735DD93 in level.teamnamelist)
  level.finalkillcams[_id_FABF84450735DD93] = undefined;

  level.finalkillcams["none"] = undefined;
  level.finalkillcam_winner = undefined;
  level.recordfinalkillcam = 1;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    level.finalkillcamenabled = 1;
    return;
  }
}

erasefinalkillcam() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamnamelist.size; _id_AC0E594AC96AA3A8++)
    level.finalkillcams[level.teamnamelist[_id_AC0E594AC96AA3A8]] = undefined;

  level.finalkillcams["none"] = undefined;
  level.finalkillcam_winner = undefined;
}

preloadfinalkillcam() {
  spectateentity = undefined;

  if(istrue(level.nukeinfo._id_AD590A75663898F3)) {
    return;
  }
  if(istrue(level.brdisablefinalkillcam)) {
    return;
  }
  if(getdvarint("dvar_166B51BF7450FC22", 0) == 1) {
    return;
  }
  if(istrue(level.skipfinalkillcam)) {
    return;
  }
  if(level.potgenabled) {
    if(scripts\mp\potg::shouldskippotg()) {
      level.potgenabled = 0;
      level.finalkillcamtype = 0;
      level.finalkillcamenabled = 1;
    }
  }

  _id_B5A1F56C62BDB31D = undefined;

  if(level.finalkillcamenabled) {
    _id_B5A1F56C62BDB31D = level.finalkillcams[level.finalkillcam_winner];

    if(!isDefined(_id_B5A1F56C62BDB31D)) {
      scripts\mp\flags::levelflagset("final_killcam_preloaded");
      return;
    }

    spectateentity = _id_B5A1F56C62BDB31D.attacker;
  } else {
    _id_599BE23B9AFB9909 = gettime();

    while(!scripts\mp\potg::issystemfinalized())
      waitframe();

    if(scripts\mp\potg::shouldskippotg() == 0) {
      _id_A1F409E21EB26925 = scripts\mp\potg::getfinalpotginfo();

      if(!isDefined(_id_A1F409E21EB26925)) {
        scripts\mp\flags::levelflagset("final_killcam_preloaded");
        return;
      }

      spectateentity = _id_A1F409E21EB26925.spectateentity;
    } else {
      level.potgenabled = 0;
      level.finalkillcamtype = 0;
      level.finalkillcamenabled = 1;
      _id_B5A1F56C62BDB31D = level.finalkillcams[level.finalkillcam_winner];

      if(!isDefined(_id_B5A1F56C62BDB31D)) {
        scripts\mp\flags::levelflagset("final_killcam_preloaded");
        return;
      }

      spectateentity = _id_B5A1F56C62BDB31D.attacker;
    }
  }

  if(!isDefined(spectateentity) || !isPlayer(spectateentity)) {
    scripts\mp\flags::levelflagset("final_killcam_preloaded");
    return;
  }

  if(isDefined(_id_B5A1F56C62BDB31D) && isDefined(_id_B5A1F56C62BDB31D._id_14A780F439CFFF1D))
    _id_B2D56FE9C46FB7B4 = _id_B5A1F56C62BDB31D._id_14A780F439CFFF1D;
  else
    _id_B2D56FE9C46FB7B4 = spectateentity getEye();

  foreach(player in level.players) {
    player loadcustomizationplayerview(spectateentity);
    player _meth_BC667001F9DD3808(_id_B2D56FE9C46FB7B4);
  }

  if(level.potgenabled)
    wait 1.0;

  scripts\mp\flags::levelflagset("final_killcam_preloaded");
}

dopotgkillcam() {
  if(istrue(level.skipfinalkillcam) || istrue(level.nukeinfo._id_AD590A75663898F3)) {
    return;
  }
  level.showingfinalkillcam = 1;
  level.maxkillcamdelay = 0.0;

  foreach(player in level.players)
  player thread dopotgkillcamforplayer();

  for(;;) {
    anyplayersinkillcam = 0;

    foreach(player in level.players) {
      if(istrue(player.inpotgkillcam)) {
        anyplayersinkillcam = 1;
        break;
      }
    }

    if(!anyplayersinkillcam) {
      break;
    }

    waitframe();
  }

  level.showingfinalkillcam = 0;
}

dopotgkillcamforplayer() {
  self endon("disconnect");
  self.inpotgkillcam = 1;
  scripts\mp\utility\player::restorebasevisionset(0);
  self setclientomnvar("post_game_state", 4);
  _id_A1F409E21EB26925 = scripts\mp\potg::getfinalpotginfo();

  if(!isDefined(_id_A1F409E21EB26925) || !isDefined(_id_A1F409E21EB26925.spectateentity)) {
    potgkillcamover();
    return;
  }

  thread scripts\mp\killcam::potg_killcam(_id_A1F409E21EB26925.spectateentity, _id_A1F409E21EB26925.psoffsettime, _id_A1F409E21EB26925.starttime, _id_A1F409E21EB26925.endtime);
  result = scripts\engine\utility::waittill_any_return_no_endon_death_2("begin_killcam", "killcam_ended");

  if(result == "killcam_ended") {
    potgkillcamover();
    return;
  }

  thread scripts\mp\utility\game::setuipostgamefade(1, self.killcamlength - 0.5);
  self waittill("killcam_ended");
  potgkillcamover();
}

potgkillcamover() {
  self setclientomnvar("post_game_state", 1);
  self.inpotgkillcam = 0;
}

dofinalkillcam() {
  if(!level.finalkillcamenabled)
    return 0;

  if(istrue(level.skipfinalkillcam) || istrue(level.nukeinfo._id_AD590A75663898F3))
    return 0;

  level.showingfinalkillcam = 1;
  winner = "none";

  if(isDefined(level.finalkillcam_winner))
    winner = level.finalkillcam_winner;

  _id_B5A1F56C62BDB31D = level.finalkillcams[winner];

  if(!isDefined(_id_B5A1F56C62BDB31D)) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  attacker = _id_B5A1F56C62BDB31D.attacker;
  victim = _id_B5A1F56C62BDB31D.victim;

  if(!isDefined(victim) || !isDefined(attacker)) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  _id_16ABE9498A90C7BF = 20;
  _id_B9C918312AA1BB86 = scripts\mp\utility\game::getsecondspassed() - _id_B5A1F56C62BDB31D.timerecorded;

  if(_id_B9C918312AA1BB86 > _id_16ABE9498A90C7BF) {
    level.showingfinalkillcam = 0;
    return 0;
  }

  level thread scripts\cp_mp\challenges::processfinalkillchallenges(attacker, victim);
  _id_0B052F94A95993A6 = (gettime() - victim.deathtime) / 1000;
  setglobalsoundcontext("atmosphere", "killcam", 0.1);
  level.maxkillcamdelay = 0.0;

  foreach(player in level.players) {
    player scripts\mp\utility\player::restorebasevisionset(0);
    player.killcamentitylookat = victim getentitynumber();
    player scripts\mp\damage::updatedeathdetails(_id_B5A1F56C62BDB31D.attackers, _id_B5A1F56C62BDB31D.attackerdata, attacker);

    if(!_id_2669878CF5A1B6BC::iskillstreakweapon(_id_B5A1F56C62BDB31D.objweapon.basename))
      player scripts\mp\killcam::setkillcamnormalweaponomnvars(_id_B5A1F56C62BDB31D.objweapon, _id_B5A1F56C62BDB31D.smeansofdeath, _id_B5A1F56C62BDB31D.einflictor, _id_B5A1F56C62BDB31D.executionref, _id_B5A1F56C62BDB31D.attacker);

    player setclientomnvar("post_game_state", 3);
    player setclientomnvar("ui_killcam_victim_or_attacker", 1);

    if(player _meth_8420670EAFC8D391())
      player setclientomnvar("ui_killcam_killedby_health_ratio", _id_B5A1F56C62BDB31D._id_6035B072327656EB);

    player playlocalsound("final_killcam_in");
    player setclienttriggeraudiozonepartial("killcam", "mix");
    player thread scripts\mp\killcam::dokillcamfromstruct(_id_B5A1F56C62BDB31D, _id_0B052F94A95993A6, 0, 1);
  }

  wait(0.15 + level.maxkillcamdelay);

  while(anyplayersinkillcam())
    waitframe();

  level.showingfinalkillcam = 0;
}

finalkillcamplaybackbegin() {
  self notify("showing_final_killcam");
  thread scripts\mp\utility\game::setuipostgamefade(1, self.killcamlength - 0.5);
  self setclientomnvar("post_game_state", 3);
  thread watchplaybackend();
}

watchplaybackend() {
  self endon("killcam_canceled");
  self waittill("killcam_ended");
  setglobalsoundcontext("atmosphere", "", 0.5);

  if(scripts\mp\utility\game::getgametype() != "arena")
    self playlocalsound("final_killcam_out");

  self clearclienttriggeraudiozone(4);
  thread scripts\mp\playerlogic::spawnendofgame();
}

recordfinalkillcam(delay, victim, attacker, attackernum, einflictor, killcamentityindex, killcamentitystarttime, _id_F2D4E6802C5D8473, objweapon, psoffsettime, smeansofdeath) {
  if(!scripts\mp\potg::shouldskippotg()) {
    return;
  }
  inflictoragentinfo = spawnStruct();

  if(isDefined(einflictor) && isagent(einflictor)) {
    inflictoragentinfo.agent_type = einflictor.agent_type;
    inflictoragentinfo.lastspawntime = einflictor.lastspawntime;

    if(!isDefined(inflictoragentinfo.lastspawntime))
      inflictoragentinfo.lastspawntime = einflictor.spawntime;
  }

  _id_23CC182D2553796A = [];

  foreach(perk in attacker.pers["loadoutPerks"])
  _id_23CC182D2553796A[_id_23CC182D2553796A.size] = perk;

  if(isDefined(attacker._id_15F3E6DF722FB1CF))
    _id_23CC182D2553796A[_id_23CC182D2553796A.size] = attacker._id_15F3E6DF722FB1CF;

  if(isDefined(attacker._id_15F3E5DF722FAF9C))
    _id_23CC182D2553796A[_id_23CC182D2553796A.size] = attacker._id_15F3E5DF722FAF9C;

  _id_B5A1F56C62BDB31D = scripts\mp\killcam::makekillcamdata(einflictor, inflictoragentinfo, attackernum, killcamentityindex, killcamentitystarttime, victim getentitynumber(), _id_F2D4E6802C5D8473, objweapon, psoffsettime, 12, attacker, victim, smeansofdeath, _id_23CC182D2553796A, 0, 1);
  _id_B5A1F56C62BDB31D.timerecorded = scripts\mp\utility\game::getsecondspassed();

  if(smeansofdeath == "MOD_EXECUTION") {
    _id_B5A1F56C62BDB31D.timerecorded = _id_B5A1F56C62BDB31D.timerecorded - 3.0;
    _id_B5A1F56C62BDB31D.timerecorded = max(0, _id_B5A1F56C62BDB31D.timerecorded);
  }

  _id_B5A1F56C62BDB31D.attackers = victim.attackers;
  _id_B5A1F56C62BDB31D.attackerdata = victim.attackerdata;

  if(level.teambased && isDefined(attacker.team))
    level.finalkillcams[attacker.team] = _id_B5A1F56C62BDB31D;
  else if(!level.teambased)
    level.finalkillcams[attacker.guid] = _id_B5A1F56C62BDB31D;

  level.finalkillcams["none"] = _id_B5A1F56C62BDB31D;
}

waitskipkillcambuttonduringdeathtimer() {
  self endon("disconnect");
  self endon("killcam_death_done_waiting");
  self notifyonplayercommand("death_respawn", "+usereload");
  self notifyonplayercommand("death_respawn", "+activate");
  self waittill("death_respawn");
  self notify("killcam_death_button_cancel");
}

waitskipkillcamduringdeathtimer(waittime) {
  self endon("disconnect");
  self endon("killcam_death_button_cancel");
  wait(waittime);
  self notify("killcam_death_done_waiting");
}

skipkillcamduringdeathtimer(waittime) {
  if(!isDefined(self))
    return 0;

  self endon("disconnect");

  if(level.showingfinalkillcam)
    return 0;

  if(!isai(self)) {
    thread waitskipkillcambuttonduringdeathtimer();
    thread waitskipkillcamduringdeathtimer(waittime);
    result = scripts\engine\utility::waittill_any_return_2("killcam_death_done_waiting", "killcam_death_button_cancel");

    if(!isDefined(self))
      return 0;

    if(isDefined(result) && result == "killcam_death_done_waiting") {
      self.skippedkillcam = 0;
      return 0;
    } else {
      self.skippedkillcam = 1;
      scripts\mp\utility\stats::incpersstat("skippedKillcams", 1);
      return 1;
    }
  }

  return 0;
}

anyplayersinkillcam() {
  foreach(player in level.players) {
    if(isDefined(player.killcam))
      return 1;
  }

  return 0;
}