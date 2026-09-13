/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\agents.gsc
***********************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(getdvarint("dvar_0DAA8C29D1AF4AB6", 0) < 1 && !istrue(level.brenableagents))
      return;
  } else if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && scripts\mp\utility\game::getsubgametype() != "champion") {
    return;
  }
  setup_callbacks();
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;
  level thread scripts\mp\agents\agent_common::init();
  level thread scripts\mp\killstreaks\agent_killstreak::init();
}

setup_callbacks() {
  if(!isDefined(level.agent_funcs))
    level.agent_funcs = [];

  level.agent_funcs["player"] = [];
  level.agent_funcs["player"]["spawn"] = ::spawn_agent_player;
  level.agent_funcs["player"]["think"] = _id_0E494DD5DEBDA9C7::bot_war_think;
  level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
  level.agent_funcs["player"]["on_damaged"] = ::on_agent_player_damaged;
  level.agent_funcs["player"]["on_damaged_finished"] = ::agent_damage_finished;
}

wait_till_agent_funcs_defined() {
  while(!isDefined(level.agent_funcs))
    wait 0.05;
}

add_humanoid_agent(agent_type, team, class, _id_6BE522BC520519BF, _id_A980E6BE815E19E1, _id_123F05CF9530A069, _id_9FEE3FE2E8DDD1F3, respawn_on_death, difficulty, classcallback, _id_3408B3BE04FF0639, _id_B72E32B38F8041C6, _id_DB8E73AAA2758D76, disablebattlechatter) {
  agent = scripts\mp\agents\agent_common::connectnewagent(agent_type, team, class);

  if(isDefined(classcallback))
    agent.classcallback = classcallback;

  if(isDefined(agent))
    agent thread[[agent scripts\mp\agents\agent_utility::agentfunc("spawn")]](_id_6BE522BC520519BF, _id_A980E6BE815E19E1, _id_123F05CF9530A069, _id_9FEE3FE2E8DDD1F3, respawn_on_death, difficulty, _id_3408B3BE04FF0639, _id_B72E32B38F8041C6, _id_DB8E73AAA2758D76, disablebattlechatter);

  return agent;
}

spawn_agent_player(_id_6BE522BC520519BF, _id_A980E6BE815E19E1, _id_123F05CF9530A069, _id_9FEE3FE2E8DDD1F3, respawn_on_death, difficulty, _id_3408B3BE04FF0639, _id_B72E32B38F8041C6, _id_DB8E73AAA2758D76, disablebattlechatter) {
  self endon("disconnect");

  while(!isDefined(level.getspawnpoint))
    waitframe();

  if(self.hasdied)
    wait(randomintrange(6, 10));

  scripts\mp\agents\agent_utility::initplayerscriptvariables(1);

  if(isDefined(_id_6BE522BC520519BF) && isDefined(_id_A980E6BE815E19E1)) {
    spawnorigin = _id_6BE522BC520519BF;
    spawnangles = _id_A980E6BE815E19E1;
    self.lastspawnpoint = spawnStruct();
    self.lastspawnpoint.origin = spawnorigin;
    self.lastspawnpoint.angles = spawnangles;
  } else {
    spawnpoint = self[[level.getspawnpoint]]();
    spawnorigin = spawnpoint.origin;
    spawnangles = spawnpoint.angles;
    self.lastspawnpoint = spawnpoint;
  }

  scripts\mp\agents\agent_utility::activateagent();
  self.lastspawntime = gettime();
  self.spawntime = gettime();
  _id_095E3F96CA970054 = spawnorigin + (0, 0, 25);
  _id_EC89DA43F5A8E18D = spawnorigin;
  _id_6F6D1E15D5BFC8D2 = playerphysicstrace(_id_095E3F96CA970054, _id_EC89DA43F5A8E18D);

  if(distancesquared(_id_6F6D1E15D5BFC8D2, _id_095E3F96CA970054) > 1)
    spawnorigin = _id_6F6D1E15D5BFC8D2;

  self spawnagent(spawnorigin, spawnangles);

  if(isDefined(_id_9FEE3FE2E8DDD1F3) && _id_9FEE3FE2E8DDD1F3)
    scripts\mp\bots\bots_personality::bot_assign_personality_functions();
  else
    scripts\mp\bots\bots_util::bot_set_personality("default");

  if(isDefined(difficulty))
    scripts\mp\bots\bots_util::bot_set_difficulty(difficulty);

  initplayerclass();
  scripts\mp\agents\agent_common::set_agent_health(100);

  if(isDefined(respawn_on_death) && respawn_on_death)
    self.respawn_on_death = 1;

  if(isDefined(_id_123F05CF9530A069))
    scripts\mp\agents\agent_utility::set_agent_team(_id_123F05CF9530A069.team, _id_123F05CF9530A069);

  if(isDefined(self.owner))
    thread destroyonownerdisconnect(self.owner);

  self enableanimstate(0);
  self takeallweapons();
  self[[level.onspawnplayer]](0);

  if(!istrue(_id_3408B3BE04FF0639))
    scripts\mp\class::giveloadout(self.team, self.class, 1);

  thread scripts\mp\bots\bots::bot_think_watch_enemy(1);
  thread scripts\mp\bots\bots::bot_think_crate();
  thread scripts\mp\bots\bots_strategy::bot_think_tactical_goals();
  self thread[[scripts\mp\agents\agent_utility::agentfunc("think")]]();

  if(!self.hasdied)
    scripts\cp_mp\utility\game_utility::addtoparticipantsarray();

  self.hasdied = 0;

  if(!istrue(_id_B72E32B38F8041C6))
    thread scripts\mp\weapons::onplayerspawned();

  if(!istrue(_id_DB8E73AAA2758D76))
    thread _id_0372301AF73968CB::manageplayerregen();

  if(!istrue(disablebattlechatter))
    thread scripts\mp\battlechatter_mp::onplayerspawned();

  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  self notify("spawned_player");
  _id_4C770A9A4AD7659C::callback("player_spawned");
}

destroyonownerdisconnect(owner) {
  self endon("death");
  childthread watchownerstatus("disconnect", owner);
  childthread watchownerstatus("joined_team", owner);
  childthread watchownerstatus("joined_spectators", owner);
}

watchownerstatus(_id_70687E0CC558A009, owner) {
  owner waittill(_id_70687E0CC558A009);
  self notify("owner_disconnect");

  if(scripts\mp\hostmigration::waittillhostmigrationdone())
    wait 0.05;

  self suicide();
}

agent_damage_finished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  if(isalive(self)) {
    if(isDefined(einflictor) || isDefined(eattacker)) {
      if(!isDefined(einflictor))
        einflictor = eattacker;

      if(isDefined(self.allowvehicledamage) && !self.allowvehicledamage) {
        if(isDefined(einflictor.classname) && einflictor.classname == "script_vehicle")
          return 0;
      }

      if(isDefined(einflictor.classname) && einflictor.classname == "auto_turret")
        eattacker = einflictor;

      if(isDefined(eattacker) && smeansofdeath != "MOD_FALLING" && smeansofdeath != "MOD_SUICIDE") {
        if(level.teambased) {
          if(isDefined(eattacker.team) && eattacker.team != self.team)
            self setagentattacker(eattacker);
        } else
          self setagentattacker(eattacker);
      }
    }

    self finishagentdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0.0, modelindex, partname);
    return 1;
  }
}

on_agent_generic_damaged(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  _id_B404412D0857AE99 = isDefined(eattacker) && isDefined(self.owner) && self.owner == eattacker;
  _id_FE3B391623AC9612 = scripts\mp\utility\damage::attackerishittingteam(self.owner, eattacker) || _id_B404412D0857AE99;

  if(!(_id_B404412D0857AE99 && self.agent_type == "playerProxy")) {
    if(level.teambased && _id_FE3B391623AC9612 && !level.friendlyfire)
      return 0;

    if(!level.teambased && _id_B404412D0857AE99)
      return 0;
  }

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && isDefined(einflictor.classname) && einflictor.classname == "script_vehicle")
    return 0;

  if(!isDefined(self) || !scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(isDefined(eattacker) && eattacker.classname == "script_origin" && isDefined(eattacker.type) && eattacker.type == "soft_landing")
    return 0;

  if(sweapon == "killstreak_emp_mp")
    return 0;

  if(issubstr(sweapon, "throwingknife") && smeansofdeath == "MOD_IMPACT")
    idamage = self.health + 1;

  if(isDefined(einflictor) && isDefined(einflictor.stuckenemyentity) && einflictor.stuckenemyentity == self)
    idamage = self.health + 1;

  if(idamage <= 0)
    return 0;

  if(isDefined(eattacker) && eattacker != self && idamage > 0 && (!isDefined(shitloc) || shitloc != "shield")) {
    if(idflags &level.idflags_stun)
      _id_CDCEDB142F61B43E = "stun";
    else
      _id_CDCEDB142F61B43E = "standard";

    eattacker _id_5762AC2F22202BA2::updatedamagefeedback(_id_CDCEDB142F61B43E, idamage >= self.health);
  }

  if(isDefined(level.modifyplayerdamage))
    idamage = [[level.modifyplayerdamage]](einflictor, self, eattacker, idamage, smeansofdeath, sweapon, vpoint, vdir, shitloc);

  return self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname);
}

on_agent_player_damaged(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  _id_B404412D0857AE99 = isDefined(eattacker) && isDefined(self.owner) && self.owner == eattacker;

  if(!level.teambased && _id_B404412D0857AE99)
    return 0;

  if(isweapon(sweapon))
    weaponname = getcompleteweaponname(sweapon);
  else
    weaponname = sweapon;

  objweapon = makeweaponfromstring(weaponname);

  if(isDefined(level.weaponmapfunc))
    [[level.weaponmapfunc]](objweapon, einflictor);

  scripts\mp\damage::callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname);
}

on_agent_player_killed(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  on_humanoid_agent_killed_common(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration, 1);

  if(isPlayer(eattacker) && (!isDefined(self.owner) || eattacker != self.owner))
    scripts\mp\damage::onkillstreakkilled("squad_mate", eattacker, sweapon, smeansofdeath, idamage, "destroyed_squad_mate");

  thread scripts\mp\weapons::dropscavengerfordeath(eattacker);

  if(self.isactive) {
    self.hasdied = 1;

    if(scripts\mp\utility\game::getgametypenumlives() != 1 && (isDefined(self.respawn_on_death) && self.respawn_on_death))
      self thread[[scripts\mp\agents\agent_utility::agentfunc("spawn")]]();
    else
      scripts\mp\agents\agent_utility::deactivateagent();
  }
}

on_humanoid_agent_killed_common(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration, _id_6F593AD6C6267D6D) {
  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
    scripts\mp\damage::launchshield(idamage, smeansofdeath);

    if(!_id_6F593AD6C6267D6D) {
      item = self dropitem(self getcurrentweapon());

      if(isDefined(item)) {
        item thread scripts\mp\weapons::deletepickupafterawhile();
        item.owner = self;
        item.ownersattacker = eattacker;
        item makeunusable();
      }
    }
  }

  if(_id_6F593AD6C6267D6D)
    self[[level.weapondropfunction]](eattacker, smeansofdeath, undefined, idamage);

  scripts\mp\riotshield::riotshield_clear();

  if(isDefined(self.nocorpse)) {
    return;
  }
  self.body = self cloneagent(deathanimduration);

  if(_id_0CBB0697DE4C5728::_id_BBEE2E46AB15A720(eattacker, sweapon, smeansofdeath, shitloc, einflictor)) {
    return;
  }
  if(istrue(self._id_250A0D62E13C6E73))
    self.body setscriptablepartstate("helmet", "damaged");
  else if(istrue(self._id_3FE8AB9198171C21))
    self.body setscriptablepartstate("helmet", "off");

  thread scripts\mp\damage::_startragdoll(self.body, smeansofdeath, einflictor);
}

initplayerclass() {
  if(isDefined(self.class_override))
    self.class = self.class_override;
  else if(scripts\mp\bots\bots_loadout::_id_A693C24DEF6FB1ED())
    self.class = "callback";
  else
    self.class = "class1";
}