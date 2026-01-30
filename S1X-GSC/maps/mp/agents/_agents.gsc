/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents.gsc
**************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  setup_callbacks();
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;
  level thread maps\mp\agents\_agent_common::init();

  if(!maps\mp\_utility::invirtuallobby() && !(isDefined(level.iszombiegame) && level.iszombiegame)) {
    level thread maps\mp\killstreaks\_agent_killstreak::init();
    level thread maps\mp\killstreaks\_dog_killstreak::init();
  }
}

setup_callbacks() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  if(!(isDefined(level.iszombiegame) && level.iszombiegame)) {
    level.agent_funcs["player"] = [];
    level.agent_funcs["player"]["spawn"] = ::spawn_agent_player;
    level.agent_funcs["player"]["think"] = maps\mp\bots\_bots_gametype_war::bot_war_think;
    level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
    level.agent_funcs["player"]["on_damaged"] = ::on_agent_player_damaged;
    level.agent_funcs["player"]["on_damaged_finished"] = ::agent_damage_finished;
    maps\mp\killstreaks\_agent_killstreak::setup_callbacks();
    maps\mp\killstreaks\_dog_killstreak::setup_callbacks();
  }
}

wait_till_agent_funcs_defined() {
  while(!isDefined(level.agent_funcs)) {
    wait 0.05;
  }
}

add_humanoid_agent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = maps\mp\agents\_agent_common::connectnewagent(var_0, var_1, var_2);

  if(isDefined(var_9)) {
    var_9 thread[[var_9 maps\mp\agents\_agent_utility::agentfunc("spawn")]](var_3, var_4, var_5, var_6, var_7, var_8);
  }

  return var_9;
}

spawn_agent_player(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("disconnect");

  while(!isDefined(level.getspawnpoint)) {
    waitframe();
  }

  if(self.hasdied) {
    wait(randomintrange(6, 10));
  }

  maps\mp\agents\_agent_utility::initplayerscriptvariables(1);

  if(isDefined(var_0) && isDefined(var_1)) {
    var_6 = var_0;
    var_7 = var_1;
    self.lastspawnpoint = spawnStruct();
    self.lastspawnpoint.origin = var_6;
    self.lastspawnpoint.angles = var_7;
  } else {
    var_8 = self[[level.getspawnpoint]]();
    var_6 = var_8.origin;
    var_7 = var_8.angles;
    self.lastspawnpoint = var_8;
  }

  maps\mp\agents\_agent_utility::activateagent();
  self.lastspawntime = gettime();
  self.spawntime = gettime();
  var_9 = var_6 + (0, 0, 25);
  var_10 = var_6;
  var_11 = playerphysicstrace(var_9, var_10);

  if(distancesquared(var_11, var_9) > 1) {
    var_6 = var_11;
  }

  self spawnagent(var_6, var_7);

  if(isDefined(var_5)) {
    self.agent_override_difficulty = var_5;
  }

  if(isDefined(self.agent_override_difficulty)) {
    if(self.agent_override_difficulty == "follow_code_and_dev_dvar") {
      maps\mp\bots\_bots_util::bot_set_difficulty(self botgetdifficulty(), 1);
    } else {
      maps\mp\bots\_bots_util::bot_set_difficulty(var_5);
    }
  } else {
    maps\mp\bots\_bots_util::bot_set_difficulty(self botgetdifficulty());
  }

  if(isDefined(var_3) && var_3) {
    self.use_randomized_personality = 1;
  }

  if(isDefined(self.use_randomized_personality) && self.use_randomized_personality) {
    if(!self.hasdied) {
      var_12 = self botgetdifficultysetting("advancedPersonality");

      if(isDefined(var_12) && var_12 != 0) {
        maps\mp\bots\_bots_personality::bot_balance_personality();
      }
    }

    maps\mp\bots\_bots_personality::bot_assign_personality_functions();
  } else {
    maps\mp\bots\_bots_util::bot_set_personality("default");
  }

  initplayerclass();
  maps\mp\agents\_agent_common::set_agent_health(100);

  if(isDefined(var_4) && var_4) {
    self.respawn_on_death = 1;
  }

  if(isDefined(var_2)) {
    maps\mp\agents\_agent_utility::set_agent_team(var_2.team, var_2);
  }

  if(isDefined(self.owner)) {
    thread destroyonownerdisconnect(self.owner);
  }

  thread maps\mp\_flashgrenades::monitorflash();
  self enableanimstate(0);
  self[[level.onspawnplayer]]();
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, self.class, 1);
  thread maps\mp\bots\_bots::bot_think_watch_enemy(1);
  thread maps\mp\bots\_bots::bot_think_crate();

  if(self.agent_type == "player") {
    thread maps\mp\bots\_bots::bot_think_level_actions();
  } else if(self.agent_type == "odin_juggernaut") {
    thread maps\mp\bots\_bots::bot_think_level_actions(128);
  }

  thread maps\mp\bots\_bots_strategy::bot_think_tactical_goals();
  self thread[[maps\mp\agents\_agent_utility::agentfunc("think")]]();

  if(!self.hasdied) {
    maps\mp\gametypes\_spawnlogic::addtoparticipantsarray();
  }

  if(!self.hasdied) {
    thread maps\mp\gametypes\_weapons::onplayerspawned();
    thread maps\mp\gametypes\_battlechatter_mp::onplayerspawned();
  }

  self.hasdied = 0;
  thread maps\mp\gametypes\_healthoverlay::playerhealthregen();

  if(isDefined(self.use_randomized_personality) && self.use_randomized_personality && isDefined(self.respawn_on_death) && self.respawn_on_death) {
    self setagentcostumeindex(1);
  }

  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  level notify("player_spawned", self);
  self notify("spawned_player");
}

destroyonownerdisconnect(var_0) {
  self endon("death");
  var_0 waittill("killstreak_disowned");
  self notify("owner_disconnect");

  if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone()) {
    wait 0.05;
  }

  self suicide();
}

agent_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_0) || isDefined(var_1)) {
    if(!isDefined(var_0)) {
      var_0 = var_1;
    }

    if(isDefined(self.allowvehicledamage) && !self.allowvehicledamage) {
      if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
        return 0;
      }
    }

    if(isDefined(var_0.classname) && var_0.classname == "auto_turret") {
      var_1 = var_0;
    }

    if(isDefined(var_1) && var_4 != "MOD_FALLING" && var_4 != "MOD_SUICIDE") {
      if(level.teambased) {
        if(isDefined(var_1.team) && var_1.team != self.team) {
          self setagentattacker(var_1);
        }
      } else {
        self setagentattacker(var_1);
      }
    }
  }

  var_10 = maps\mp\gametypes\_damage::shouldplayblastimpact(var_3, var_4, var_5);
  var_11 = self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10);

  if(isDefined(var_11)) {
    thread finishagentdamage_impactfxwrapper(var_11[0], var_11[1], var_11[2], var_11[3], var_11[4], var_11[5], var_11[6]);
  }

  if(!isDefined(self.isactive)) {
    self.waitingtodeactivate = 1;
  }

  return 1;
}

finishagentdamage_impactfxwrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  waittillframeend;

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  self finishagentdamage_impactfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

on_agent_generic_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = isDefined(var_1) && isDefined(self.owner) && self.owner == var_1;
  var_11 = maps\mp\_utility::attackerishittingteam(self.owner, var_1) || var_10;

  if(level.teambased && var_11 && !level.friendlyfire) {
    return 0;
  }

  if(!level.teambased && var_10) {
    return 0;
  }

  if(isDefined(var_4) && var_4 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return 0;
  }

  if(!isDefined(self) || !maps\mp\_utility::isreallyalive(self)) {
    return 0;
  }

  if(isDefined(var_1) && var_1.classname == "script_origin" && isDefined(var_1.type) && var_1.type == "soft_landing") {
    return 0;
  }

  if(var_5 == "killstreak_emp_mp") {
    return 0;
  }

  if(var_5 == "bouncingbetty_mp" && !maps\mp\gametypes\_weapons::minedamageheightpassed(var_0, self)) {
    return 0;
  }

  if((var_5 == "throwingknife_mp" || var_5 == "throwingknifejugg_mp") && var_4 == "MOD_IMPACT") {
    var_2 = self.health + 1;
  }

  if(isDefined(var_0) && isDefined(var_0.stuckenemyentity) && var_0.stuckenemyentity == self) {
    var_2 = self.health + 1;
  }

  if(var_2 <= 0) {
    return 0;
  }

  if(isDefined(level.modifyplayerdamage)) {
    var_2 = [[level.modifyplayerdamage]](self, var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8);
  }

  if(isDefined(var_1) && var_1 != self && var_2 > 0 && (!isDefined(var_8) || var_8 != "shield")) {
    if(var_3 &level.idflags_stun) {
      var_12 = "stun";
    } else if(!maps\mp\gametypes\_damage::shouldweaponfeedback(var_5)) {
      var_12 = "none";
    } else {
      var_12 = "standard";

      if(isDefined(level.iszombiegame) && level.iszombiegame) {
        if(var_5 == "trap_zm_mp" || var_5 == "zombie_vaporize_mp" || var_5 == "zombie_trap_turret_mp" || var_5 == "zombie_water_trap_mp") {
          var_12 = "none";
        } else {
          if(var_5 == "iw5_microwavezm_mp") {
            var_12 = "nosound";
          }

          if(var_2 < self.health) {
            switch (var_8) {
              case "neck":
              case "helmet":
              case "head":
                var_12 = "headshot";
                break;
            }
          } else {
            switch (var_8) {
              case "neck":
              case "helmet":
              case "head":
                var_12 = "killshot_headshot";
                break;
              default:
                var_12 = "killshot";
                break;
            }
          }
        }
      }
    }

    var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_12);
  }

  return self[[maps\mp\agents\_agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

on_agent_player_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = isDefined(var_1) && isDefined(self.owner) && self.owner == var_1;

  if(!level.teambased && var_10) {
    return 0;
  }

  maps\mp\gametypes\_damage::callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

on_agent_player_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);

  if(isplayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner) && (!isDefined(self.nonkillstreakagent) || !self.nonkillstreakagent)) {
    maps\mp\gametypes\_damage::onkillstreakkilled(var_1, var_4, var_3, var_2, "destroyed_squad_mate");
  }

  if(isDefined(level.on_agent_player_killed)) {
    [[level.on_agent_player_killed]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  thread maps\mp\gametypes\_weapons::dropscavengerfordeath(var_1);

  if(self.isactive) {
    self.hasdied = 1;

    if(maps\mp\_utility::getgametypenumlives() != 1 && (isDefined(self.respawn_on_death) && self.respawn_on_death)) {
      self thread[[maps\mp\agents\_agent_utility::agentfunc("spawn")]]();
    } else {
      maps\mp\agents\_agent_utility::deactivateagent();
    }
  }
}

on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(maps\mp\_riotshield::hasriotshieldequipped()) {
    maps\mp\gametypes\_damage::launchshield(var_2, var_3);

    if(!var_9) {
      var_10 = self dropitem(self getcurrentweapon());

      if(isDefined(var_10)) {
        var_10 thread maps\mp\gametypes\_weapons::deletepickupafterawhile();
        var_10.owner = self;
        var_10.ownersattacker = var_1;
        var_10 makeunusable();
      }
    }
  }

  if(var_9) {
    self thread[[level.weapondropfunction]](var_1, var_3);
  }

  if(!isDefined(self.bypassagentcorpse) || !self.bypassagentcorpse) {
    self.body = self finishagentdamage(var_8);

    if(isDefined(level.agentshouldragdollimmediatelyfunc) && [[level.agentshouldragdollimmediatelyfunc]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
      self.body startragdoll();

      if(!self.body isragdoll()) {
        thread maps\mp\gametypes\_damage::delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
      }
    } else {
      thread maps\mp\gametypes\_damage::delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
    }
  }

  maps\mp\_riotshield::riotshield_clear();
}

initplayerclass() {
  if(isDefined(self.class_override)) {
    self.class = self.class_override;
  } else if(maps\mp\bots\_bots_loadout::bot_setup_loadout_callback()) {
    self.class = "callback";
  } else {
    self.class = "class1";
  }
}