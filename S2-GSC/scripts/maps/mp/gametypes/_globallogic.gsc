/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_globallogic.gsc
******************************************************/

init() {
  level.splitscreen = _issplitscreen();
  level.console = getDvar("5554") == "true";
  level.onlinegame = _isonlinegame();
  level.rankedmatch = xmodelalias/alias_ger_heads_paris_grey_cap();
  level.practiceround = getdvarint("664");
  level.disableranking = getdvarint("78", 1) == 0;
  level._id_2F7A = getdvarint("1349", 1) == 0;
  level._id_2FAA = getdvarint("437", 1) == 0;
  maps\mp\_utility::_id_86FB();

  if(getdvarint("5357") == 1) {
    level.onlinegame = 1;
  }

  level._id_015D = _tolower(getDvar("1673"));

  if(_func_367()) {
    level.gametype = "hub";
  } else if(getdvarint("4017", 0)) {
    level.gametype = "vlobby";
  } else {
    level.gametype = _tolower(getDvar("1924"));
  }

  level.teamnamelist = ["axis", "allies"];
  level.otherteam["allies"] = "axis";
  level.otherteam["axis"] = "allies";
  level.multiteambased = 0;
  maps\mp\_utility::_id_873B(0);
  level.objectivebased = 0;
  level.endgameontimelimit = 1;
  level.showingfinalkillcam = 0;
  level.tispawndelay = getdvarint("scr_tispawndelay");

  if(!isDefined(level.tweakablesinitialized)) {
    _id_0511::init();
  }

  precachestring(&"MP_HALFTIME");
  precachestring(&"MP_OVERTIME");
  precachestring(&"MP_ROUNDEND");
  precachestring(&"MP_INTERMISSION");
  precachestring(&"MP_SWITCHING_SIDES");
  precachestring(&"MP_FRIENDLY_FIRE_WILL_NOT");
  precachestring(&"MP_SUICIDE_PUNISHED");
  precachestring(&"PLATFORM_REVIVE");
  precachestring(&"MP_OBITUARY_NEUTRAL");
  precachestring(&"MP_OBITUARY_FRIENDLY");
  precachestring(&"MP_OBITUARY_ENEMY");

  if(level.splitscreen) {
    precachestring(&"MP_ENDED_GAME");
  } else {
    precachestring(&"MP_HOST_ENDED_GAME");
  }

  level.halftimetype = "halftime";

  if(level.gametype == "dom" || level.gametype == "lockdown") {
    level.halftimeonscorelimit = 1;
  } else {
    level.halftimeonscorelimit = 0;
  }

  level.halftimestopwatch = 0;
  level.laststatustime = 0;
  level.waswinning = "none";
  level.lastslowprocessframe = 0;
  level.placement["allies"] = [];
  level.placement["axis"] = [];
  level.placement["all"] = [];
  level.postroundtime = 5.0;

  if(maps\mp\_utility::practiceroundgame()) {
    level.postroundtime = 0.0;
  }

  level.playerslookingforsafespawn = [];
  registerdvars();
  precachemodel("tag_origin");
  level.teamcount["allies"] = 0;
  level.teamcount["axis"] = 0;
  level.teamcount["spectator"] = 0;
  level._id_0BC3["allies"] = 0;
  level._id_0BC3["axis"] = 0;
  level._id_0BC3["spectator"] = 0;
  level.livescount["allies"] = 0;
  level.livescount["axis"] = 0;
  level.onelefttime = [];
  level.hasspawned["allies"] = 0;
  level.hasspawned["axis"] = 0;
  var_0 = 9;
  init_multiteamdata(var_0);
}

init_multiteamdata(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = "team_" + var_1;
    level.placement[var_2] = [];
    level.teamcount[var_2] = 0;
    level._id_0BC3[var_2] = 0;
    level.livescount[var_2] = 0;
    level.hasspawned[var_2] = 0;
  }
}

registerdvars() {
  _setomnvar("ui_bomb_a_state", 0);
  _setomnvar("ui_bomb_b_state", 0);
  _setomnvar("ui_nuke_end_milliseconds", 0);
  setDvar("ui_danger_team", "");
  setDvar("ui_inhostmigration", 0);
  setDvar("311", getdvarint("scr_thirdPerson"));
}

setupcallbacks() {
  level.onxpevent = ::onxpevent;
  level.getspawnpoint = ::_id_4437;
  level._id_7658 = _id_050E::_id_4436;
  level._id_A278 = _id_050E::_id_A278;
  level.onspawnplayer = ::blank;
  level.onrespawndelay = ::blank;
  level.ontimelimit = maps\mp\gametypes\_gamelogic::default_ontimelimit;
  level.onhalftime = maps\mp\gametypes\_gamelogic::default_onhalftime;
  level.ondeadevent = maps\mp\gametypes\_gamelogic::default_ondeadevent;
  level.ononeleftevent = maps\mp\gametypes\_gamelogic::default_ononeleftevent;
  level._id_6B86 = ::blank;
  level.onstartgametype = ::blank;
  level._id_6B7B = ::blank;
  level.autoassign = _id_04E8::autoassign;
}

_id_4437() {
  if(!isDefined(self.spawninfo)) {
    self.spawninfo = spawnStruct();
  }

  var_0 = [[level._id_7658]](_func_2D5(self), self.spawninfo, undefined, isPlayer(self), undefined, 1);

  if(isDefined(self.spawninfo)) {
    var_1 = self.spawninfo._id_76E6;
    self.spawninfo._id_76E6 = self.spawninfo._id_9087;
    self.spawninfo._id_9087 = var_0;

    if(getdvarint("spawning_revised_fatique") != 0) {
      var_2 = [];
      var_3 = 0;

      if(isDefined(self.spawninfo._id_3A5D)) {
        foreach(var_5 in self.spawninfo._id_3A5D) {
          var_6 = 0;
          var_7 = var_5["spawnPoint"];

          if(var_7 == var_0) {
            var_3 = 1;

            if(var_5["spawnsSinceLastUsed"] == 0) {
              var_5["spawnCount"]++;
            } else {
              var_5["spawnsSinceLastUsed"] = 0;
              var_5["spawnCount"] = 1;
            }
          } else {
            var_5["spawnCount"] = 0;
            var_5["spawnsSinceLastUsed"]++;

            if(var_5["spawnsSinceLastUsed"] > 3) {
              var_6 = 1;
            }
          }

          if(!var_6) {
            var_2[var_2.size] = var_5;
          }
        }
      }

      if(!var_3) {
        if(isDefined(self.spawninfo._id_76E6) && self.spawninfo._id_76E6 == var_0) {
          var_5["spawnPoint"] = var_0;
          var_5["spawnCount"] = 2;
          var_5["spawnsSinceLastUsed"] = 0;
          var_2[var_2.size] = var_5;
        } else if(isDefined(var_1) && var_1 == var_0) {
          var_5["spawnPoint"] = var_0;
          var_5["spawnCount"] = 1;
          var_5["spawnsSinceLastUsed"] = 0;
          var_2[var_2.size] = var_5;
        }
      }

      self.spawninfo._id_3A5D = var_2;
    }
  }

  if(isDefined(level._id_A278)) {
    self[[level._id_A278]](var_0);
  }

  return var_0;
}

blank(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

testmenu() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    wait 10.0;
    var_0 = spawnStruct();
    var_0.titletext = &"MP_CHALLENGE_COMPLETED";
    var_0.notifytext = "wheee";
    var_0.sound = "mp_challenge_complete";
    thread maps\mp\gametypes\_hud_message::notifymessage(var_0);
  }
}

testshock() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    wait 3.0;
    var_0 = randomint(6);

    for(var_1 = 0; var_1 < var_0; var_1++) {
      _iprintlnbold(var_0);
      self shellshock("frag_grenade_mp", 0.2);
      wait 0.1;
    }
  }
}

onxpevent(var_0) {
  level thread maps\mp\gametypes\_rank::awardgameevent(var_0, self);
}

debugline(var_0, var_1) {
  for(var_2 = 0; var_2 < 50; var_2++) {
    waitframe();
  }
}