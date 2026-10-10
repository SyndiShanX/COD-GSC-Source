/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_214930d31a3a8321.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#namespace namespace_bb51033c9ae7d498;

function function_ea74b31deb2a73db() {
  var_b6a1aa299bae1f84 = getStruct("ravenov_spawn", "targetname");

  if(isDefined(var_b6a1aa299bae1f84)) {
    var_67cd14c1cc125b93 = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc("sergei_ravenov")[0];
    level.var_c921cb81dd47af55 = scripts\mp\mp_agent::spawnnewagentaitype(var_67cd14c1cc125b93, var_b6a1aa299bae1f84.origin, var_b6a1aa299bae1f84.angles, level.allyteam);

    if(isDefined(level.var_c921cb81dd47af55)) {
      level.var_c921cb81dd47af55 scripts\common\ai::magic_bullet_shield();
      level.var_c921cb81dd47af55 scripts\common\utility::set_battlechatter(1);
      level.var_c921cb81dd47af55.battlechatter.stateoverride = "combat";
      level.var_c921cb81dd47af55.var_9f009877c3bea958 = 1;
      level.var_c921cb81dd47af55.var_69b049cf4b18c73b = 1;
      level.var_c921cb81dd47af55 setscriptablepartstate("minimap", "active");

      if(!threatbiasgroupexists("ally_ai")) {
        createthreatbiasgroup("ally_ai");
      }

      level.var_c921cb81dd47af55 setthreatbiasgroup("ally_ai");
      level.var_c921cb81dd47af55 function_65cdab0fc78aba8f(level.var_c921cb81dd47af55.origin, 3000);
      level.a_ai_allies = [];
      level.a_ai_allies[level.a_ai_allies.size] = level.var_c921cb81dd47af55;
      level.var_c921cb81dd47af55 thread function_e9bbf51c045b4d47();
    }
  }
}

function function_f246b3550eda8b6f() {
  self notify("new_goal_given");
  aliveplayers = [];
  var_5e7be3a99a2fb3e8 = 0;

  foreach(player in level.players) {
    if(isalive(player) && isPlayer(player)) {
      aliveplayers[var_5e7be3a99a2fb3e8] = player;
    }

    var_5e7be3a99a2fb3e8++;
  }

  var_8850d9f771525016 = random(aliveplayers);

  if(isDefined(var_8850d9f771525016)) {
    self.var_140a5fde675674fe = var_8850d9f771525016;
    self setgoalentity(var_8850d9f771525016);
    self.goalradius = 100;
    self.var_cbd2c45e12e0c27a = var_8850d9f771525016;
    thread function_1744bfae3e614a0e(var_8850d9f771525016);
  }
}

function function_cc2a173f1d10e82e() {
  self notify("new_goal_given");
  self.var_140a5fde675674fe = undefined;

  if(isDefined(level.var_59a5ab1b4256bb79)) {
    self setgoalentity(level.var_59a5ab1b4256bb79);
    self.goalradius = 100;
    self.var_cbd2c45e12e0c27a = level.var_59a5ab1b4256bb79;
  }

  self notify("following_acv");
}

function function_973c94b4840e3cdb() {
  self notify("lead_acv");
  self notify("new_goal_given");
  self endon("lead_acv");
  self endon("new_goal_given");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(level.var_59a5ab1b4256bb79)) {
    self.var_cbd2c45e12e0c27a = level.var_59a5ab1b4256bb79;
  } else {
    assert(0, "<dev string:x1c>");
  }

  while(true) {
    newgoalpos = level.var_59a5ab1b4256bb79.origin + anglesToForward(level.var_59a5ab1b4256bb79.angles) * 700;
    self setgoalpos(newgoalpos);
    self.goalradius = 100;
    wait 0.1;
  }
}

function function_e0d25e0c4548bc8b() {
  self notify("new_goal_given");

  if(!isDefined(level.var_376e6e8117393127)) {
    iprintlnbold("<dev string:x46>");

    return;
  }

  self setgoalentity(level.var_376e6e8117393127);
  self.var_cbd2c45e12e0c27a = level.var_376e6e8117393127;

  iprintlnbold("<dev string:x5e>");
}

function function_1744bfae3e614a0e(var_8850d9f771525016) {
  self endon("following_acv");
  var_8850d9f771525016 waittill("death");
  function_f246b3550eda8b6f();
}

function function_e9bbf51c045b4d47() {
  self notify("stay_near_target");
  self endon("stay_near_target");
  self endon("game_ended");
  self.var_7a09280a7f23f0c5 = 0;
  set("catchup_ignoreall", "ignoreall", 0);

  while(true) {
    if(isDefined(self.var_cbd2c45e12e0c27a)) {
      distsq = distancesquared(self.var_cbd2c45e12e0c27a.origin, self.origin);

      if(distsq > 1000000 && !istrue(self.var_7a09280a7f23f0c5)) {
        set("catchup_ignoreall", "ignoreall", 1);
        self.var_7a09280a7f23f0c5 = 1;
      } else if(istrue(self.var_7a09280a7f23f0c5) && distsq <= 90000) {
        set("catchup_ignoreall", "ignoreall", 0);
        self.var_7a09280a7f23f0c5 = 0;
      }
    } else if(istrue(self.var_7a09280a7f23f0c5)) {
      set("catchup_ignoreall", "ignoreall", 0);
      self.var_7a09280a7f23f0c5 = 0;
    }

    wait 0.3;
  }
}