/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_ctf.gsc
*********************************************/

main() {
  setup_callbacks();
  setup_bot_ctf();
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_ctf_think;
}

setup_bot_ctf() {
  scripts\mp\bots\_bots_util::bot_waittill_bots_enabled();
  level.teamflags["allies"].label = "allies";
  level.teamflags["axis"].label = "axis";
  var_0[0] = level.teamflags["allies"].curorigin;
  var_1[0] = "flag_" + level.teamflags["allies"].label;
  var_0[1] = level.teamflags["axis"].curorigin;
  var_1[1] = "flag_" + level.teamflags["axis"].label;
  scripts\mp\bots\_bots_util::func_2D18(var_0, var_1);
  var_2 = getzonenearest(level.teamflags["allies"].curorigin);
  if(isDefined(var_2)) {
    botzonesetteam(var_2, "allies");
  }

  var_2 = getzonenearest(level.teamflags["axis"].curorigin);
  if(isDefined(var_2)) {
    botzonesetteam(var_2, "axis");
  }

  level.bot_gametype_precaching_done = 1;
}

crate_can_use(var_0) {
  if(isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  if(isDefined(self.carryflag)) {
    return 0;
  }

  if(!level.teamflags[self.team] scripts\mp\gameobjects::ishome()) {
    return 0;
  }

  return 1;
}

func_46BE() {
  var_0 = 0;
  foreach(var_2 in level.participants) {
    if(!isDefined(var_2.team)) {
      continue;
    }

    if(var_2 == self) {
      continue;
    }

    if(scripts\mp\utility::isteamparticipant(var_2) && var_2.team == self.team) {
      var_0++;
    }
  }

  return var_0;
}

bot_ctf_think() {
  self notify("bot_ctf_think");
  self endon("bot_ctf_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  init_bot_game_ctf();
  self.var_BF69 = gettime();
  self.var_BF3E = gettime();
  self botsetflag("separation", 0);
  if(!isDefined(level.var_BF3F)) {
    level.var_BF3F = gettime() - 100;
  }

  for(;;) {
    wait(0.05);
    if(gettime() >= level.var_BF3F) {
      func_12DC1();
      level.var_BF3F = gettime() + 100;
    }

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(self.role)) {
      func_F319();
    }

    if(isDefined(self.carryflag)) {
      clear_defend();
      if(!isDefined(level.var_6E28[level.otherteam[self.team]]) || scripts\engine\utility::istrue(level.capturecondition)) {
        self botsetscriptgoal(level.capzones[self.team].curorigin, 16, "critical");
      } else if(isDefined(level.var_6E28[level.otherteam[self.team]]) && func_46BE() == 0) {
        self botclearscriptgoal();
        self botsetscriptgoal(level.var_6E28[level.otherteam[self.team]].origin, 256, "guard");
      } else if(gettime() > self.var_BF3E) {
        var_0 = getnodesinradius(level.capzones[self.team].curorigin, 900, 0, 300);
        var_1 = self botnodepick(var_0, var_0.size * 0.15, "node_hide");
        if(isDefined(var_1)) {
          self botsetscriptgoalnode(var_1, "critical");
        }

        self.var_BF3E = gettime() + 10000;
      }

      continue;
    }

    if(self.role == "attacker") {
      if(isDefined(level.var_6E28[self.team])) {
        if(!scripts\mp\bots\_bots_util::bot_is_bodyguarding()) {
          scripts\mp\bots\_bots_strategy::bot_guard_player(level.var_6E28[self.team], 400);
        }
      } else {
        clear_defend();
        self botsetscriptgoal(level.teamflags[level.otherteam[self.team]].curorigin, 16, "guard");
      }

      continue;
    }

    if(!level.teamflags[self.team] scripts\mp\gameobjects::ishome()) {
      if(!isDefined(level.var_6E28[level.otherteam[self.team]])) {
        clear_defend();
        self botsetscriptgoal(level.teamflags[self.team].curorigin, 16, "critical");
      } else {
        var_2 = level.var_6E28[level.otherteam[self.team]];
        if(gettime() > self.var_BF69 || self botcanseeentity(var_2)) {
          clear_defend();
          self botsetscriptgoal(var_2.origin, 16, "critical");
          self.var_BF69 = gettime() + randomintrange(4500, 5500);
        }
      }

      continue;
    }

    if(!is_protecting_flag()) {
      self botclearscriptgoal();
      var_3["entrance_points_index"] = "flag_" + level.teamflags[self.team].label;
      scripts\mp\bots\_bots_strategy::bot_protect_point(level.teamflags[self.team].curorigin, 600, var_3);
    }
  }
}

clear_defend() {
  if(scripts\mp\bots\_bots_util::bot_is_defending()) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
  }
}

is_protecting_flag() {
  return scripts\mp\bots\_bots_util::bot_is_protecting();
}

func_F319() {
  self.role = level.var_BF57[self.team];
  if(level.var_BF57[self.team] == "attacker") {
    level.var_BF57[self.team] = "defender";
    return;
  }

  if(level.var_BF57[self.team] == "defender") {
    level.var_BF57[self.team] = "attacker";
  }
}

init_bot_game_ctf() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }

  level.bots_gametype_initialized = 1;
  level.var_BF57["allies"] = "attacker";
  level.var_BF57["axis"] = "attacker";
  level.var_6E28 = [];
}

func_12DC1() {
  level.var_6E28["allies"] = undefined;
  level.var_6E28["axis"] = undefined;
  foreach(var_1 in level.participants) {
    if(isalive(var_1) && isDefined(var_1.carryflag)) {
      level.var_6E28[var_1.team] = var_1;
    }
  }

  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  foreach(var_1 in level.participants) {
    if(isDefined(var_1.role)) {
      if(var_1.team == "allies") {
        if(var_1.role == "attacker") {
          var_3[var_3.size] = var_1;
        } else if(var_1.role == "defender") {
          var_4[var_4.size] = var_1;
        }

        continue;
      }

      if(var_1.team == "axis") {
        if(var_1.role == "attacker") {
          var_5[var_5.size] = var_1;
          continue;
        }

        if(var_1.role == "defender") {
          var_6[var_6.size] = var_1;
        }
      }
    }
  }

  if(var_4.size > var_3.size) {
    scripts\engine\utility::random(var_4).role = undefined;
  } else if(var_3.size > var_4.size + 1) {
    scripts\engine\utility::random(var_3).role = undefined;
  }

  if(var_6.size > var_5.size) {
    scripts\engine\utility::random(var_6).role = undefined;
    return;
  }

  if(var_5.size > var_6.size + 1) {
    scripts\engine\utility::random(var_5).role = undefined;
  }
}