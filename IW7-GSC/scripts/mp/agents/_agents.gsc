/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\_agents.gsc
*****************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }

  setup_callbacks();
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;
  scripts\mp\mp_agent::init_agent("mp\default_agent_definition.csv");
  lib_0F6E::registerscriptedagent();
  level thread scripts\mp\agents\_agent_common::init();
  level thread scripts\mp\killstreaks\_agent_killstreak::init();
}

setup_callbacks() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  level.agent_funcs["player"] = [];
  level.agent_funcs["player"]["spawn"] = ::spawn_agent_player;
  level.agent_funcs["player"]["think"] = ::scripts\mp\bots\gametype_war::bot_war_think;
  level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
  level.agent_funcs["player"]["on_damaged"] = ::on_agent_player_damaged;
  level.agent_funcs["player"]["on_damaged_finished"] = ::agent_damage_finished;
  lib_0F6E::setupcallbacks();
  scripts\mp\equipment\phase_split::func_CAC9();
  scripts\mp\killstreaks\_agent_killstreak::setup_callbacks();
  scripts\mp\killstreaks\_rc8::setup_callbacks();
}

wait_till_agent_funcs_defined() {
  while(!isDefined(level.agent_funcs)) {
    wait(0.05);
  }
}

add_humanoid_agent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D) {
  var_0E = scripts\mp\agents\_agent_common::connectnewagent(var_0, var_1, var_2);
  if(isDefined(var_9)) {
    var_0E.classcallback = var_9;
  }

  if(isDefined(var_0E)) {
    var_0E thread[[var_0E scripts\mp\agents\agent_utility::agentfunc("spawn")]](var_3, var_4, var_5, var_6, var_7, var_8, var_0A, var_0B, var_0C, var_0D);
  }

  return var_0E;
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
    var_0A = var_0;
    var_0B = var_1;
    self.lastspawnpoint = spawnStruct();
    self.lastspawnpoint.origin = var_0A;
    self.lastspawnpoint.angles = var_0B;
  } else {
    var_0C = self[[level.getspawnpoint]]();
    var_0A = var_0C.origin;
    var_0B = var_0C.angles;
    self.lastspawnpoint = var_0C;
  }

  scripts\mp\agents\agent_utility::activateagent();
  self.lastspawntime = gettime();
  self.spawntime = gettime();
  var_0D = var_0A + (0, 0, 25);
  var_0E = var_0A;
  var_0F = playerphysicstrace(var_0D, var_0E);
  if(distancesquared(var_0F, var_0D) > 1) {
    var_0A = var_0F;
  }

  self giveplaceable(var_0A, var_0B);
  if(isDefined(var_3) && var_3) {
    scripts\mp\bots\_bots_personality::bot_assign_personality_functions();
  } else {
    scripts\mp\bots\_bots_util::bot_set_personality("default");
  }

  if(isDefined(var_5)) {
    scripts\mp\bots\_bots_util::bot_set_difficulty(var_5);
  }

  initplayerclass();
  scripts\mp\agents\_agent_common::set_agent_health(100);
  if(isDefined(var_4) && var_4) {
    self.respawn_on_death = 1;
  }

  if(isDefined(var_2)) {
    scripts\mp\agents\agent_utility::set_agent_team(var_2.team, var_2);
  }

  if(isDefined(self.triggerportableradarping)) {
    thread destroyonownerdisconnect(self.triggerportableradarping);
  }

  thread scripts\mp\flashgrenades::func_B9D9();
  self getrank(0);
  self takeallweapons();
  self[[level.onspawnplayer]]();
  if(!scripts\mp\utility::istrue(var_6)) {
    scripts\mp\class::giveloadout(self.team, self.class, 1);
  }

  thread scripts\mp\bots\_bots::bot_think_watch_enemy(1);
  thread scripts\mp\bots\_bots::bot_think_crate();
  if(self.agent_type == "player") {
    thread scripts\mp\bots\_bots::bot_think_level_acrtions();
  } else if(self.agent_type == "odin_juggernaut") {
    thread scripts\mp\bots\_bots::bot_think_level_acrtions(128);
  }

  thread scripts\mp\bots\_bots_strategy::bot_think_tactical_goals();
  self thread[[scripts\mp\agents\agent_utility::agentfunc("think")]]();
  if(!self.hasdied) {
    scripts\mp\spawnlogic::addtoparticipantsarray();
  }

  self.hasdied = 0;
  if(!scripts\mp\utility::istrue(var_7)) {
    thread scripts\mp\weapons::onplayerspawned();
  }

  if(!scripts\mp\utility::istrue(var_8)) {
    thread scripts\mp\healthoverlay::playerhealthregen();
  }

  if(!scripts\mp\utility::istrue(var_9)) {
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
    wait(0.05);
  }

  self suicide();
}

agent_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
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
            self give_ammo(var_1);
          }
        } else {
          self give_ammo(var_1);
        }
      }
    }

    self getrespawndelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_0A, var_0B);
    if(!isDefined(self.isactive)) {
      self.waitingtodeactivate = 1;
    }

    return 1;
  }
}

on_agent_generic_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = isDefined(var_1) && isDefined(self.triggerportableradarping) && self.triggerportableradarping == var_1;
  var_0D = scripts\mp\utility::attackerishittingteam(self.triggerportableradarping, var_1) || var_0C;
  if(!var_0C && self.agent_type == "playerProxy") {
    if(level.teambased && var_0D && !level.friendlyfire) {
      return 0;
    }

    if(!level.teambased && var_0C) {
      return 0;
    }
  }

  if(isDefined(var_4) && var_4 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return 0;
  }

  if(!isDefined(self) || !scripts\mp\utility::isreallyalive(self)) {
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

  if(isDefined(var_1) && var_1 != self && var_2 > 0 && !isDefined(var_8) || var_8 != "shield") {
    if(var_3 &level.idflags_stun) {
      var_0E = "stun";
    } else if(!scripts\mp\damage::func_100C1(var_6)) {
      var_0E = "none";
    } else {
      var_0E = "standard";
    }

    var_1 thread scripts\mp\damagefeedback::updatedamagefeedback(var_0E, var_2 >= self.health);
  }

  if(isDefined(level.modifyplayerdamage)) {
    var_2 = [[level.modifyplayerdamage]](self, var_1, var_2, var_4, var_5, var_6, var_7, var_8);
  }

  return self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
}

on_agent_player_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = isDefined(var_1) && isDefined(self.triggerportableradarping) && self.triggerportableradarping == var_1;
  if(!level.teambased && var_0C) {
    return 0;
  }

  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
  }

  scripts\mp\damage::callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
}

on_agent_player_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);
  if(isplayer(var_1) && !isDefined(self.triggerportableradarping) || var_1 != self.triggerportableradarping) {
    scripts\mp\damage::onkillstreakkilled("squad_mate", var_1, var_4, var_3, var_2, "destroyed_squad_mate");
  }

  scripts\mp\weapons::dropscavengerfordeath(var_1);
  if(self.isactive) {
    self.hasdied = 1;
    if(scripts\mp\utility::getgametypenumlives() != 1 && isDefined(self.respawn_on_death) && self.respawn_on_death) {
      self thread[[scripts\mp\agents\agent_utility::agentfunc("spawn")]]();
      return;
    }

    scripts\mp\agents\agent_utility::deactivateagent();
  }
}

on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
    scripts\mp\damage::launchshield(var_2, var_3);
    if(!var_9) {
      var_0A = self dropitem(self getcurrentweapon());
      if(isDefined(var_0A)) {
        var_0A thread scripts\mp\weapons::deletepickupafterawhile();
        var_0A.triggerportableradarping = self;
        var_0A.ownersattacker = var_1;
        var_0A makeunusable();
      }
    }
  }

  if(var_9) {
    self[[level.weapondropfunction]](var_1, var_3);
  }

  scripts\mp\utility::riotshield_clear();
  if(isDefined(self.nocorpse)) {
    return;
  }

  self.body = self getplayerviewmodelfrombody(var_8);
  thread scripts\mp\damage::delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
}

initplayerclass() {
  if(isDefined(self.class_override)) {
    self.class = self.class_override;
    return;
  }

  if(scripts\mp\bots\_bots_loadout::bot_setup_loadout_callback()) {
    self.class = "callback";
    return;
  }

  self.class = "class1";
}