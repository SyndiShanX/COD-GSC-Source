/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 9.gsc
**************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  setup_callbacks();
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;
  scripts\mp\mp_agent::init_agent("mp\default_agent_definition.csv");
  func_0F6E::registerscriptedagent();
  level thread scripts\mp\agents\agent_common::init();
  level thread scripts\mp\killstreaks\agent_killstreak::init();
}

setup_callbacks() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  level.agent_funcs["player"] = [];
  level.agent_funcs["player"]["spawn"] = ::spawn_agent_player;
  level.agent_funcs["player"]["think"] = scripts\mp\bots\gametype_war::bot_war_think;
  level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
  level.agent_funcs["player"]["on_damaged"] = ::on_agent_player_damaged;
  level.agent_funcs["player"]["on_damaged_finished"] = ::agent_damage_finished;
  func_0F6E::setupcallbacks();
  scripts\mp\equipment\phase_split::func_CAC9();
  scripts\mp\killstreaks\agent_killstreak::setup_callbacks();
  scripts\mp\killstreaks\remotec8::setup_callbacks();
}

wait_till_agent_funcs_defined() {
  while(!isDefined(level.agent_funcs)) {
    wait 0.05;
  }
}

add_humanoid_agent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = scripts\mp\agents\agent_common::connectnewagent(var_0, var_1, var_2);

  if(isDefined(var_9)) {
    var_14.classcallback = var_9;
  }

  if(isDefined(var_14)) {
    var_14 thread[[var_14 scripts\mp\agents\agent_utility::agentfunc("spawn")]](var_3, var_4, var_5, var_6, var_7, var_8, var_10, var_11, var_12, var_13);
  }

  return var_14;
}

spawn_agent_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("disconnect");

  while(!isDefined(level.getspawnpoint)) {
    scripts\engine\utility::waitframe();
  }

  if(self.hasdied) {
    wait(randomintrange(6, 10));
  }

  scripts\mp\agents\agent_utility::initplayerscriptvariables(1);

  if(isDefined(var_0) && isDefined(var_1)) {
    var_10 = var_0;
    var_11 = var_1;
    self.lastspawnpoint = spawnStruct();
    self.lastspawnpoint.origin = var_10;
    self.lastspawnpoint.angles = var_11;
  } else {
    var_12 = self[[level.getspawnpoint]]();
    var_10 = var_12.origin;
    var_11 = var_12.angles;
    self.lastspawnpoint = var_12;
  }

  scripts\mp\agents\agent_utility::activateagent();
  self.lastspawntime = gettime();
  self.spawntime = gettime();
  var_13 = var_10 + (0, 0, 25);
  var_14 = var_10;
  var_15 = playerphysicstrace(var_13, var_14);

  if(distancesquared(var_15, var_13) > 1) {
    var_10 = var_15;
  }

  self spawnagent(var_10, var_11);

  if(isDefined(var_3) && var_3) {
    scripts\mp\bots\bots_personality::bot_assign_personality_functions();
  } else {
    scripts\mp\bots\bots_util::bot_set_personality("default");
  }

  if(isDefined(var_5)) {
    scripts\mp\bots\bots_util::bot_set_difficulty(var_5);
  }

  initplayerclass();
  scripts\mp\agents\agent_common::set_agent_health(100);

  if(isDefined(var_4) && var_4) {
    self.respawn_on_death = 1;
  }

  if(isDefined(var_2)) {
    scripts\mp\agents\agent_utility::set_agent_team(var_2.team, var_2);
  }

  if(isDefined(self.owner)) {
    thread destroyonownerdisconnect(self.owner);
  }

  thread scripts\mp\flashgrenades::func_B9D9();
  self enableanimstate(0);
  self takeallweapons();
  self[[level.onspawnplayer]]();

  if(!scripts\mp\utility\game::istrue(var_6)) {
    scripts\mp\class::giveloadout(self.team, self.class, 1);
  }

  thread scripts\mp\bots\bots::bot_think_watch_enemy(1);
  thread scripts\mp\bots\bots::bot_think_crate();

  if(self.agent_type == "player") {
    thread scripts\mp\bots\bots::bot_think_level_acrtions();
  } else if(self.agent_type == "odin_juggernaut") {
    thread scripts\mp\bots\bots::bot_think_level_acrtions(128);
  }

  thread scripts\mp\bots\bots_strategy::bot_think_tactical_goals();
  self thread[[scripts\mp\agents\agent_utility::agentfunc("think")]]();

  if(!self.hasdied) {
    scripts\mp\spawnlogic::addtoparticipantsarray();
  }

  self.hasdied = 0;

  if(!scripts\mp\utility\game::istrue(var_7)) {
    thread scripts\mp\weapons::onplayerspawned();
  }

  if(!scripts\mp\utility\game::istrue(var_8)) {
    thread scripts\mp\healthoverlay::playerhealthregen();
  }

  if(!scripts\mp\utility\game::istrue(var_9)) {
    thread scripts\mp\battlechatter_mp::onplayerspawned();
  }

  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  self notify("spawned_player");
}

destroyonownerdisconnect(var_0) {
  self endon("death");
  var_0 waittill("killstreak_disowned");
  self notify("owner_disconnect");

  if(scripts\mp\hostmigration::waittillhostmigrationdone()) {
    wait 0.05;
  }

  self suicide();
}

agent_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isalive(self)) {
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
        } else
          self setagentattacker(var_1);
      }
    }

    self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);

    if(!isDefined(self.isactive)) {
      self.waitingtodeactivate = 1;
    }

    return 1;
  }
}

on_agent_generic_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = isDefined(var_1) && isDefined(self.owner) && self.owner == var_1;
  var_13 = scripts\mp\utility\game::attackerishittingteam(self.owner, var_1) || var_12;

  if(!(var_12 && self.agent_type == "playerProxy")) {
    if(level.teambased && var_13 && !level.friendlyfire) {
      return 0;
    }

    if(!level.teambased && var_12) {
      return 0;
    }
  }

  if(isDefined(var_4) && var_4 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return 0;
  }

  if(!isDefined(self) || !scripts\mp\utility\game::isreallyalive(self)) {
    return 0;
  }

  if(isDefined(var_1) && var_1.classname == "script_origin" && isDefined(var_1.type) && var_1.type == "soft_landing") {
    return 0;
  }

  if(var_5 == "killstreak_emp_mp") {
    return 0;
  }

  if(var_5 == "bouncingbetty_mp" && !scripts\mp\weapons::minedamageheightpassed(var_0, self)) {
    return 0;
  }

  if(issubstr(var_5, "throwingknife") && var_4 == "MOD_IMPACT") {
    var_2 = self.health + 1;
  }

  if(isDefined(var_0) && isDefined(var_0.stuckenemyentity) && var_0.stuckenemyentity == self) {
    var_2 = self.health + 1;
  }

  if(var_2 <= 0) {
    return 0;
  }

  if(isDefined(var_1) && var_1 != self && var_2 > 0 && (!isDefined(var_8) || var_8 != "shield")) {
    if(var_3 &level.idflags_stun) {
      var_14 = "stun";
    } else if(!scripts\mp\damage::func_100C1(var_5)) {
      var_14 = "none";
    } else {
      var_14 = "standard";
    }

    var_1 thread scripts\mp\damagefeedback::updatedamagefeedback(var_14, var_2 >= self.health);
  }

  if(isDefined(level.modifyplayerdamage)) {
    var_2 = [[level.modifyplayerdamage]](self, var_1, var_2, var_4, var_5, var_6, var_7, var_8);
  }

  return self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

on_agent_player_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = isDefined(var_1) && isDefined(self.owner) && self.owner == var_1;

  if(!level.teambased && var_12) {
    return 0;
  }

  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
  }

  scripts\mp\damage::callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

on_agent_player_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);

  if(isplayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
    scripts\mp\damage::onkillstreakkilled("squad_mate", var_1, var_4, var_3, var_2, "destroyed_squad_mate");
  }

  scripts\mp\weapons::dropscavengerfordeath(var_1);

  if(self.isactive) {
    self.hasdied = 1;

    if(scripts\mp\utility\game::getgametypenumlives() != 1 && (isDefined(self.respawn_on_death) && self.respawn_on_death)) {
      self thread[[scripts\mp\agents\agent_utility::agentfunc("spawn")]]();
    } else {
      scripts\mp\agents\agent_utility::deactivateagent();
    }
  }
}

on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
    scripts\mp\damage::launchshield(var_2, var_3);

    if(!var_9) {
      var_10 = self dropitem(self getcurrentweapon());

      if(isDefined(var_10)) {
        var_10 thread scripts\mp\weapons::deletepickupafterawhile();
        var_10.owner = self;
        var_10.ownersattacker = var_1;
        var_10 makeunusable();
      }
    }
  }

  if(var_9) {
    self[[level.weapondropfunction]](var_1, var_3);
  }

  scripts\mp\utility\game::riotshield_clear();

  if(isDefined(self.nocorpse)) {
    return;
  }
  self.body = self cloneagent(var_8);
  thread scripts\mp\damage::delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
}

initplayerclass() {
  if(isDefined(self.class_override)) {
    self.class = self.class_override;
  } else if(scripts\mp\bots\bots_loadout::bot_setup_loadout_callback()) {
    self.class = "callback";
  } else {
    self.class = "class1";
  }
}