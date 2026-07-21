/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_siege.gsc
***********************************************/

main() {
  setup_callbacks();

  if(level.unset_relic_lfo)
    _encstr_9615268BD18667DA6837F78D098A66B72D4BC662B85DB759987BBD8DE9D02AC7C063BAEB28BCFF8E::setup_bot_war();
  else {
    thread bot_siege_manager_think();
    setup_bot_siege();
  }
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_siege_think;
}

setup_bot_siege() {
  level.bot_gametype_precaching_done = 1;
}

bot_siege_manager_think() {
  level.siege_bot_team_need_flags = [];
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level._id_13391 = [];
  level._id_13390 = [];

  for(;;) {
    level.siege_bot_team_need_flags = [];

    foreach(var_1 in level.players) {
      if(!scripts\mp\utility\player::isreallyalive(var_1) && var_1.hasspawned) {
        if(var_1.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_1.team != "_encstr_A7A408B9CA5D1D4E2C63")
          level.siege_bot_team_need_flags[var_1.team] = 1;
      }
    }

    var_3 = [];

    foreach(var_5 in level.objectives) {
      var_6 = var_5 scripts\mp\gameobjects::getownerteam();

      if(var_6 != "_encstr_A7A408B9CA5D1D4E2C63") {
        if(!isDefined(var_3[var_6])) {
          var_3[var_6] = 1;
          continue;
        }

        var_3[var_6]++;
      }
    }

    foreach(var_6, var_9 in var_3) {
      if(var_9 >= 2) {
        var_10 = scripts\mp\utility\game::getotherteam(var_6)[0];
        level.siege_bot_team_need_flags[var_10] = 1;

        if(var_9 == 2 && !istrue(level._id_13391[var_6])) {
          if(randomint(100) > 75)
            level.siege_bot_team_need_flags[var_6] = 1;
          else
            level._id_13391[var_6] = 0;

          level._id_13390[var_6] = 1;
        }

        continue;
      }

      if(var_9 < 2 && istrue(level._id_13390[var_6])) {
        level._id_13390[var_6] = 0;
        level._id_13391[var_6] = 0;
      }
    }

    wait 1.0;
  }
}

bot_siege_think() {
  self notify("_encstr_A68610A268BDF752D853C7CD0F18DC77E880");
  self endon("_encstr_A68610A268BDF752D853C7CD0F18DC77E880");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  while(!isDefined(level.siege_bot_team_need_flags))
    wait 0.05;

  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  self botsetflag("_encstr_8D1813AECD95D7B731A9BE83C21D0DAF9B8EBC6395", 1);

  for(;;) {
    if(isDefined(level.siege_bot_team_need_flags[self.team]) && level.siege_bot_team_need_flags[self.team])
      bot_choose_flag();
    else if(isDefined(self.goalflag)) {
      if(scripts\mp\bots\bots_util::bot_is_defending())
        scripts\mp\bots\bots_strategy::bot_defend_stop();

      self.goalflag = undefined;
    }

    wait 1.0;
  }
}

bot_choose_flag() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level.objectives) {
    var_4 = var_3 scripts\mp\gameobjects::getownerteam();

    if(var_4 != self.team) {
      var_5 = distancesquared(self.origin, var_3.trigger.origin);

      if(!isDefined(var_1) || var_5 < var_1) {
        var_1 = var_5;
        var_0 = var_3;
      }
    }
  }

  if(isDefined(var_0)) {
    if(!isDefined(self.goalflag) || self.goalflag != var_0) {
      self.goalflag = var_0;
      scripts\mp\bots\bots_strategy::bot_capture_point(var_0.trigger.origin, 100);
    }
  }
}