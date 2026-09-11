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

function add_humanoid_agent(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  var14 = scripts\mp\agents\agent_common::connectnewagent(var0, var1, var2);

  if(isDefined(var9)) {
    var14.classcallback = var9;
  }

  if(isDefined(var14)) {
    var14 thread[[var14 scripts\mp\agents\agent_utility::agentfunc("spawn")]](var3, var4, var5, var6, var7, var8, var10, var11, var12, var13);
  }

  return var14;
}

function spawn_agent_player(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  self endon("disconnect");

  while(!isDefined(level.getspawnpoint)) {
    waitframe();
  }

  if(self.hasdied) {
    wait randomintrange(6, 10);
  }

  scripts\mp\agents\agent_utility::initplayerscriptvariables(1);
  jumpiffalse(isDefined(var0) && isDefined(var1)) LOC_00000074;
  var10 = var0;
  var11 = var1;
  self.lastspawnpoint = spawnStruct();
  self.lastspawnpoint.origin = var10;
  self.lastspawnpoint.angles = var11;
  goto LOC_0000009c;
}

function destroyonownerdisconnect(var0) {
  self endon("death");
  GscBinSkip4(0x35, "disconnect", var0);
}

function watchownerstatus(var0, var1) {
  var1 waittill(var0);
  self notify("owner_disconnect");

  if(scripts\mp\hostmigration::waittillhostmigrationdone()) {
    wait 0.05;
  }

  self suicide();
}

function agent_damage_finished(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(isalive(self)) {
    if(isDefined(var0) || isDefined(var1)) {
      if(!isDefined(var0)) {
        var0 = var1;
      }

      if(isDefined(self.allowvehicledamage) && !self.allowvehicledamage) {
        if(isDefined(var0.classname) && var0.classname == "script_vehicle") {
          return 0;
        }
      }

      if(isDefined(var0.classname) && var0.classname == "auto_turret") {
        var1 = var0;
      }

      if(isDefined(var1) && var4 != "MOD_FALLING" && var4 != "MOD_SUICIDE") {
        if(level.teambased) {
          if(isDefined(var1.team) && var1.team != self.team) {
            self setagentattacker(var1);
          }
        } else {
          self setagentattacker(var1);
        }
      }
    }

    self finishagentdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, 0, var10, var11);

    if(!isDefined(self.isactive)) {
      self.waitingtodeactivate = 1;
    }

    return 1;
  }
}

function on_agent_generic_damaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = isDefined(var1) && isDefined(self.owner) && self.owner == var1;
  var13 = scripts\mp\utility\damage::attackerishittingteam(self.owner, var1) || var12;

  if(!(var12 && self.agent_type == "playerProxy")) {
    if(level.teambased && var13 && !level.friendlyfire) {
      return 0;
    }

    if(!level.teambased && var12) {
      return 0;
    }
  }

  if(isDefined(var4) && var4 == "MOD_CRUSH" && isDefined(var0) && isDefined(var0.classname) && var0.classname == "script_vehicle") {
    return 0;
  }

  if(!isDefined(self) || !scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(isDefined(var1) && var1.classname == "script_origin" && isDefined(var1.type) && var1.type == "soft_landing") {
    return 0;
  }

  if(var5 == "killstreak_emp_mp") {
    return 0;
  }

  if(issubstr(var5, "throwingknife") && var4 == "MOD_IMPACT") {
    var2 = self.health + 1;
  }

  if(isDefined(var0) && isDefined(var0.stuckenemyentity) && var0.stuckenemyentity == self) {
    var2 = self.health + 1;
  }

  if(var2 <= 0) {
    return 0;
  }

  if(isDefined(var1) && var1 != self && var2 > 0 && (!isDefined(var8) || var8 != "shield")) {
    if(var3 &level.idflags_stun) {
      var14 = "stun";
    } else {
      var14 = "standard";
    }

    var2 thread scripts\mp\damagefeedback::updatedamagefeedback(var14, var3 >= self.health);
  }

  if(isDefined(level.modifyplayerdamage)) {
    var3 = [[level.modifyplayerdamage]](var1, self, var2, var3, var5, var6, var7, var8, var9);
  }

  return self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
}

function on_agent_player_damaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var13 = isDefined(var1) && isDefined(self.owner) && self.owner == var1;

  if(!level.teambased && var13) {
    return 0;
  }

  if(issameweapon(var5)) {
    var14 = createheadicon(var5);
  } else {
    var14 = var6;
  }

  var13 = asmdevgetallstates(var14);

  if(isDefined(level.weaponmapfunc)) {
    [[level.weaponmapfunc]](var13, var1);
  }

  scripts\mp\damage::callback_playerdamage(var1, var2, var3, var4, var5, var13, var7, var8, var9, var10, var11, var12);
}

function on_agent_player_killed(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  on_humanoid_agent_killed_common(var0, var1, var2, var3, var4, var5, var6, var7, var8, 1);

  if(isPlayer(var1) && (!isDefined(self.owner) || var1 != self.owner)) {
    scripts\mp\damage::onkillstreakkilled("squad_mate", var1, var4, var3, var2, "destroyed_squad_mate");
  }

  thread scripts\mp\weapons::dropscavengerfordeath(var1);

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

function on_humanoid_agent_killed_common(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
    scripts\mp\damage::launchshield(var2, var3);

    if(!var9) {
      var10 = self dropitem(self getcurrentweapon());

      if(isDefined(var10)) {
        var10 thread scripts\mp\weapons::deletepickupafterawhile();
        var10.owner = self;
        var10.ownersattacker = var1;
        var10 makeunusable();
      }
    }
  }

  if(var9) {
    self[[level.weapondropfunction]](var1, var3, undefined, var2);
  }

  scripts\mp\riotshield::riotshield_clear();

  if(isDefined(self.nocorpse)) {
    return;
  }

  self.body = self cloneagent(var8);
  thread scripts\mp\damage::_startragdoll(self.body, var3, var0);
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