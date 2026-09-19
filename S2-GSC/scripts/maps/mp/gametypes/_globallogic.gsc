/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_globallogic.gsc
******************************************************/

init() {
  level.splitscreen = _issplitscreen();
  level._id_258F = getDvar("5554") == "true";
  level.onlinegame = _isonlinegame();
  level.rankedmatch = _func_3AC();
  level._id_7616 = getdvarint("664");
  level._id_2F98 = getdvarint("78", 1) == 0;
  level._id_2F7A = getdvarint("1349", 1) == 0;
  level._id_2FAA = getdvarint("437", 1) == 0;
  maps\mp\_utility::_id_86FB();

  if(getdvarint("5357") == 1)
    level.onlinegame = 1;

  level._id_015D = _tolower(getDvar("1673"));

  if(_func_367())
    level.gametype = "hub";
  else if(getdvarint("4017", 0))
    level.gametype = "vlobby";
  else
    level.gametype = _tolower(getDvar("1924"));

  level._id_985B = ["axis", "allies"];
  level._id_6C63["allies"] = "axis";
  level._id_6C63["axis"] = "allies";
  level._id_6520 = 0;
  maps\mp\_utility::_id_873B(0);
  level.objectivebased = 0;
  level._id_36BE = 1;
  level._id_8C03 = 0;
  level._id_9A27 = getdvarint("scr_tispawndelay");

  if(!isDefined(level._id_9FC5))
    _id_0511::init();

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

  if(level.splitscreen)
    precachestring(&"MP_ENDED_GAME");
  else
    precachestring(&"MP_HOST_ENDED_GAME");

  level._id_495B = "halftime";

  if(level.gametype == "dom" || level.gametype == "lockdown")
    level._id_4959 = 1;
  else
    level._id_4959 = 0;

  level.halftimestopwatch = 0;
  level._id_5C00 = 0;
  level._id_A87B = "none";
  level.lastslowprocessframe = 0;
  level.placement["allies"] = [];
  level.placement["axis"] = [];
  level.placement["all"] = [];
  level._id_75EE = 5.0;

  if(maps\mp\_utility::_id_761E())
    level._id_75EE = 0.0;

  level._id_7460 = [];
  _id_7BDF();
  precachemodel("tag_origin");
  level.teamcount["allies"] = 0;
  level.teamcount["axis"] = 0;
  level.teamcount["spectator"] = 0;
  level._id_0BC3["allies"] = 0;
  level._id_0BC3["axis"] = 0;
  level._id_0BC3["spectator"] = 0;
  level._id_5DDB["allies"] = 0;
  level._id_5DDB["axis"] = 0;
  level._id_6AF5 = [];
  level.hasspawned["allies"] = 0;
  level.hasspawned["axis"] = 0;
  var_0 = 9;
  _id_5211(var_0);
}

_id_5211(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = "team_" + var_1;
    level.placement[var_2] = [];
    level.teamcount[var_2] = 0;
    level._id_0BC3[var_2] = 0;
    level._id_5DDB[var_2] = 0;
    level.hasspawned[var_2] = 0;
  }
}

_id_7BDF() {
  _setomnvar("ui_bomb_a_state", 0);
  _setomnvar("ui_bomb_b_state", 0);
  _setomnvar("ui_nuke_end_milliseconds", 0);
  setDvar("ui_danger_team", "");
  setDvar("ui_inhostmigration", 0);
  setDvar("311", getdvarint("scr_thirdPerson"));
}

setupcallbacks() {
  level._id_6BCE = ::_id_6BCE;
  level._id_4696 = ::_id_4437;
  level._id_7658 = _id_050E::_id_4436;
  level._id_A278 = _id_050E::_id_A278;
  level._id_6BA7 = ::_id_1786;
  level._id_6B96 = ::_id_1786;
  level._id_6BB6 = maps\mp\gametypes\_gamelogic::_id_2BB0;
  level._id_6B42 = maps\mp\gametypes\_gamelogic::_id_2BAE;
  level._id_6AE2 = maps\mp\gametypes\_gamelogic::_id_2BAD;
  level._id_6B5E = maps\mp\gametypes\_gamelogic::_id_2BAF;
  level._id_6B86 = ::_id_1786;
  level._id_6BAF = ::_id_1786;
  level._id_6B7B = ::_id_1786;
  level._id_1385 = _id_04E8::_id_1385;
}

_id_4437() {
  if(!isDefined(self._id_9070))
    self._id_9070 = spawnStruct();

  var_0 = [[level._id_7658]](_func_2D5(self), self._id_9070, undefined, isPlayer(self), undefined, 1);

  if(isDefined(self._id_9070)) {
    var_1 = self._id_9070._id_76E6;
    self._id_9070._id_76E6 = self._id_9070._id_9087;
    self._id_9070._id_9087 = var_0;

    if(getdvarint("spawning_revised_fatique") != 0) {
      var_2 = [];
      var_3 = 0;

      if(isDefined(self._id_9070._id_3A5D)) {
        foreach(var_5 in self._id_9070._id_3A5D) {
          var_6 = 0;
          var_7 = var_5["spawnPoint"];

          if(var_7 == var_0) {
            var_3 = 1;

            if(var_5["spawnsSinceLastUsed"] == 0)
              var_5["spawnCount"]++;
            else {
              var_5["spawnsSinceLastUsed"] = 0;
              var_5["spawnCount"] = 1;
            }
          } else {
            var_5["spawnCount"] = 0;
            var_5["spawnsSinceLastUsed"]++;

            if(var_5["spawnsSinceLastUsed"] > 3)
              var_6 = 1;
          }

          if(!var_6)
            var_2[var_2.size] = var_5;
        }
      }

      if(!var_3) {
        if(isDefined(self._id_9070._id_76E6) && self._id_9070._id_76E6 == var_0) {
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

      self._id_9070._id_3A5D = var_2;
    }
  }

  if(isDefined(level._id_A278))
    self[[level._id_A278]](var_0);

  return var_0;
}

_id_1786(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

_id_991A() {
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

_id_991C() {
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

_id_6BCE(var_0) {
  level thread maps\mp\gametypes\_rank::_id_1457(var_0, self);
}

_id_2B57(var_0, var_1) {
  for(var_2 = 0; var_2 < 50; var_2++)
    waitframe();
}