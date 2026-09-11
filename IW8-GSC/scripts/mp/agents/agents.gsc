/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\agents.gsc
***********************************************/

function main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }

  if(level.gametype == "br") {
    if(!scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe()) {
      return;
    }
  }

  setup_callbacks();
  level.badplace_cylinder_func = &badplace_cylinder;
  level.badplace_delete_func = &badplace_delete;
  level thread scripts\mp\agents\agent_common::init();
  level thread scripts\mp\killstreaks\agent_killstreak::init();
}

function setup_callbacks() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  level.agent_funcs["player"] = [];
  level.agent_funcs["player"]["spawn"] = &spawn_agent_player;
  level.agent_funcs["player"]["think"] = &scripts\mp\bots\bots_gametype_war::bot_war_think;
  level.agent_funcs["player"]["on_killed"] = &on_agent_player_killed;
  level.agent_funcs["player"]["on_damaged"] = &on_agent_player_damaged;
  level.agent_funcs["player"]["on_damaged_finished"] = &agent_damage_finished;
}

function wait_till_agent_funcs_defined() {
  while(!isDefined(level.agent_funcs)) {
    wait 0.05;
  }
}

function add_humanoid_agent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = scripts\mp\agents\agent_common::connectnewagent(var_0, var_1, var_2);

  if(isDefined(var_9)) {
    var_14.classcallback = var_9;
  }

  if(isDefined(var_14)) {
    var_14 thread[[var_14 scripts\mp\agents\agent_utility::agentfunc("spawn")]](var_3, var_4, var_5, var_6, var_7, var_8, var_10, var_11, var_12, var_13);
  }

  return var_14;
}

function spawn_agent_player(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("disconnect");

  while(!isDefined(level.getspawnpoint)) {
    waitframe();
  }

  if(self.hasdied) {
    wait randomintrange(6, 10);
  }

  scripts\mp\agents\agent_utility::initplayerscriptvariables(1);
  jumpiffalse(isDefined(var_0) && isDefined(var_1)) LOC_00000074;
  var_10 = var_0;
  var_11 = var_1;
  self.lastspawnpoint = spawnStruct();
  self.lastspawnpoint.origin = var_10;
  self.lastspawnpoint.angles = var_11;
  goto LOC_0000009c;
}

function destroyonownerdisconnect(var_0) {
  self endon("death");
  GscBinSkip4(0x35, "disconnect", var_0);
}

function watchownerstatus(var_0, var_1) {
  var_1 waittill(var_0);
  self notify("owner_disconnect");

  if(scripts\mp\hostmigration::waittillhostmigrationdone()) {
    wait 0.05;
  }

  self suicide();
}

function agent_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
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
        } else {
          self setagentattacker(var_1);
        }
      }
    }

    self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);

    if(!isDefined(self.isactive)) {
      self.waitingtodeactivate = 1;
    }

    return 1;
  }
}

function on_agent_generic_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = isDefined(var_1) && isDefined(self.owner) && self.owner == var_1;
  var_13 = scripts\mp\utility\damage::attackerishittingteam(self.owner, var_1) || var_12;

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

  if(!isDefined(self) || !scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(isDefined(var_1) && var_1.classname == "script_origin" && isDefined(var_1.type) && var_1.type == "soft_landing") {
    return 0;
  }

  if(var_5 == "killstreak_emp_mp") {
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
    } else {
      var_14 = "standard";
    }

    var_2 thread scripts\mp\damagefeedback::updatedamagefeedback(var_14, var_3 >= self.health);
  }

  if(isDefined(level.modifyplayerdamage)) {
    var_3 = [[level.modifyplayerdamage]](var_1, self, var_2, var_3, var_5, var_6, var_7, var_8, var_9);
  }

  return self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

function on_agent_player_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = isDefined(var_1) && isDefined(self.owner) && self.owner == var_1;

  if(!level.teambased && var_13) {
    return 0;
  }

  if(issameweapon(var_5)) {
    var_14 = createheadicon(var_5);
  } else {
    var_14 = var_6;
  }

  var_13 = asmdevgetallstates(var_14);

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var_13, var_1);
  }

  scripts\mp\damage::callback_playerdamage(var_1, var_2, var_3, var_4, var_5, var_13, var_7, var_8, var_9, var_10, var_11, var_12);
}

function on_agent_player_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);

  if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
    scripts\mp\damage::onkillstreakkilled("squad_mate", var_1, var_4, var_3, var_2, "destroyed_squad_mate");
  }

  thread scripts\mp\weapons::dropscavengerfordeath(var_1);

  if(self.isactive) {
    self.hasdied = 1;

    if(scripts\mp\utility\game::getgametypenumlives() != 1 && isDefined(self.respawn_on_death) && self.respawn_on_death) {
      self thread[[scripts\mp\agents\agent_utility::agentfunc("spawn")]]();
      return;
    }

    scripts\mp\agents\agent_utility::deactivateagent();
    return;
  }
}

function on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
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
    self[[level.weapondropfunction]](var_1, var_3, undefined, var_2);
  }

  scripts\mp\riotshield::riotshield_clear();

  if(isDefined(self.nocorpse)) {
    return;
  }

  self.body = self cloneagent(var_8);
  thread scripts\mp\damage::_startragdoll(self.body, var_3, var_0);
}

function initplayerclass() {
  if(isDefined(self.class_override)) {
    self.class = self.class_override;
    return;
  }

  if(scripts\mp\bots\bots_loadout::bot_setup_loadout_callback()) {
    self.class = "callback";
    return;
  }

  self.class = "class1";
}