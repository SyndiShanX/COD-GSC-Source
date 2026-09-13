/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\mp_agent.gsc
***********************************************/

setup_bt_and_asm() {
  self._id_A942DD31D55102C9 = self.asmasset;
  scripts\mp\agents\scriptedagents::ai_init(self.behaviortreeasset, self.asmasset);
}

setupweapon(_id_9EF97DB737B5030E) {
  self.weapon = _id_9EF97DB737B5030E;
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = nullweapon();
  self.grenadeammo = 0;
}

spawnnewagentaitype(aitype, position, angles, team) {
  if(!scripts\engine\utility::string_starts_with(aitype, "actor_"))
    aitype = "actor_" + aitype;

  if(!isDefined(level.agent_definition[aitype]) || !isDefined(level.agent_definition[aitype]["setup_func"]))
    return undefined;

  agent = spawnnewagent(aitype, team, position, angles);
  return agent;
}

spawnnewagent(agent_type, _id_00091AB00DAAD678, _id_0C95C2773DD1279E, _id_E21A7BAA6BA10015, _id_F9E7DC261E07162E) {
  agent = getfreeagent(agent_type);

  if(isDefined(agent)) {
    _id_371B4C2AB5861E62::_id_51DE6DA7B0DCF26F(agent);
    agent.connecttime = gettime();
    agent.spawntime = agent.connecttime;

    if(!isDefined(_id_00091AB00DAAD678)) {
      _id_00091AB00DAAD678 = level.agent_definition[agent_type]["team"];

      if(!isDefined(_id_00091AB00DAAD678))
        _id_00091AB00DAAD678 = "axis";
    }

    agent set_agent_team(_id_00091AB00DAAD678);
    agent set_agent_model();
    agent _id_AF0713CAAF6C21C5();
    agent.is_scripted_agent = isDefined(agent.animationarchetype);
    agent spawnagent(_id_0C95C2773DD1279E, _id_E21A7BAA6BA10015, agent.animationarchetype);
    agent _id_6874E26FC94F0027();
    agent scripts\cp_mp\utility\game_utility::addtocharactersarray();
    agent _meth_C4F5A500340FE6C2(agent.agent_type);

    if(agent.is_scripted_agent)
      agent setup_bt_and_asm();

    if(isDefined(_id_F9E7DC261E07162E)) {
      if(isweapon(_id_F9E7DC261E07162E))
        agent setupweapon(_id_F9E7DC261E07162E);
      else
        return undefined;
    }

    agent activateagent();
    agent scripts\engine\utility::set_ai_number();
    agent scripts\engine\utility::_id_82581894F5A1C71C();
  }

  return agent;
}

set_agent_model() {
  _id_D1B17F5AE26C69DB = level.agent_definition[self.agent_type]["setup_model_func"];

  if(!isDefined(_id_D1B17F5AE26C69DB))
    return 0;

  self[[_id_D1B17F5AE26C69DB]](self.agent_type);
  return 1;
}

_id_6874E26FC94F0027() {
  _id_D0E49134703DA0D5 = level.agent_definition[self.agent_type]["setup_func"];
  self[[_id_D0E49134703DA0D5]]();
}

_id_AF0713CAAF6C21C5() {
  if(!isDefined(level.agent_funcs[self.agent_type])) {
    level.agent_funcs[self.agent_type] = [];
    assign_agent_func("on_damaged", ::default_on_damage);
    assign_agent_func("on_damaged_finished", ::default_on_damage_finished);
    assign_agent_func("on_killed", ::default_on_killed);
  }
}

assign_agent_func(_id_AD662D6A990F6FCC, _id_428D899920A93A15) {
  level.agent_funcs[self.agent_type][_id_AD662D6A990F6FCC] = _id_428D899920A93A15;
}

getfreeagent(agent_type) {
  if(!isDefined(level.agentarray))
    return undefined;

  _id_7818398CDD97FE84 = _func_76B285B4BAE7356C();

  if(isDefined(_id_7818398CDD97FE84)) {
    _id_7818398CDD97FE84.agent_type = agent_type;
    _id_7818398CDD97FE84 initagentscriptvariables();
  }

  return _id_7818398CDD97FE84;
}

initagentscriptvariables() {
  self.pers = [];
  self.hasdied = 0;
  self.isactive = 0;
  self.isagent = 1;
  self.agent_teamparticipant = 0;
  self.agent_gameparticipant = 0;
  self.agentname = undefined;
  self detachall();
  initplayerscriptvariables();
}

initplayerscriptvariables() {
  self.class = undefined;
  self.movespeedscaler = undefined;
  self.avoidkillstreakonspawntimer = undefined;
  self.guid = undefined;
  self.name = undefined;
  self.perks = undefined;
  self.weaponlist = undefined;
  self.objectivescaler = undefined;
  self.sessionteam = undefined;
  self.sessionstate = undefined;
  _id_3B64EB40368C1450::nuke("weapon");
  _id_3B64EB40368C1450::nuke("weapon_switch");
  _id_3B64EB40368C1450::nuke("offhand_weapons");
  _id_3B64EB40368C1450::nuke("usability");
  self.nocorpse = undefined;
  self.ignoreme = 0;
  self.ignoreall = istrue(level._id_BDB4D0CD41B1C39D);
  self.command_given = undefined;
  self.current_icon = undefined;
  self.do_immediate_ragdoll = undefined;

  if(isDefined(level.gametype_agent_init))
    self[[level.gametype_agent_init]]();
}

set_agent_team(team, _id_123F05CF9530A069) {
  self.team = team;
  self.agentteam = team;
  self.pers["team"] = team;

  if(isDefined(_id_123F05CF9530A069)) {
    self.owner = _id_123F05CF9530A069;
    self setotherent(_id_123F05CF9530A069);
    self setentityowner(_id_123F05CF9530A069);
  }
}

set_agent_health(health) {
  self.health = health;
  self.maxhealth = health;
}

is_friendly_damage(agent, attacker) {
  if(isDefined(attacker) && isDefined(agent) && isDefined(agent.team)) {
    if(isDefined(attacker.team) && attacker.team == agent.team)
      return 1;

    if(isDefined(attacker.owner) && isDefined(attacker.owner.team) && attacker.owner.team == agent.team)
      return 1;

    if(isDefined(attacker.vehicle) && isDefined(attacker.vehicle.team) && attacker.vehicle.team == agent.team)
      return 1;
  }

  return 0;
}

default_on_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  victim = self;
  func = undefined;

  if(isDefined(self._id_D88ACF085F34A24F))
    idamage = self[[self._id_D88ACF085F34A24F]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);

  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]))
    func = level.agent_funcs[self.unittype]["gametype_on_damaged"];

  if(isDefined(func))
    [[func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname);
  else {
    func = level.agent_funcs[self.agent_type]["gametype_on_damaged"];

    if(isDefined(func))
      [[func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname);
  }

  if(is_friendly_damage(victim, einflictor)) {
    return;
  }
  if(istrue(victim.agentdamagefeedback)) {
    _id_22602300DECB102B = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
      _id_22602300DECB102B = isDefined(objweapon) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](objweapon.basename);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "handleDamageFeedback"))
        eattacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "handleDamageFeedback")]](einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, _id_22602300DECB102B);
    }
  }

  if(isDefined(victim.unittype) && isDefined(level.agent_funcs[victim.unittype]) && isDefined(level.agent_funcs[victim.unittype]["on_damaged_finished"]))
    victim[[level.agent_funcs[victim.unittype]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0.0, modelindex, partname);
  else
    victim[[level.agent_funcs[victim.agent_type]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0.0, modelindex, partname);
}

default_on_damage_finished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_B2883531AFA6B83D) {
  prevhealth = self.health;
  objweapon = sweapon;
  self.damagedby = eattacker;
  self.damagepoint = vpoint;
  self finishagentdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset, 0.0, modelindex, partname, istrue(_id_B2883531AFA6B83D));

  if(self.health > 0 && self.health < prevhealth) {
    self notify("pain");
    scripts\asm\asm_mp::runpain();
  }

  if(isalive(self)) {
    if(isDefined(self._id_1EC812B92A31CDD3)) {
      foreach(func in self._id_1EC812B92A31CDD3)
      self[[func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname);
    }

    if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype]["gametype_on_damage_finished"])) {
      func = level.agent_funcs[self.unittype]["gametype_on_damage_finished"];

      if(isDefined(func)) {
        [[func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname);
        return;
      }
    } else if(isDefined(self.agent_type)) {
      func = level.agent_funcs[self.agent_type]["gametype_on_damage_finished"];

      if(isDefined(func))
        [[func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname);
    }
  }
}

default_on_killed(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(isDefined(self.on_zombie_agent_killed_common))
    self[[self.on_zombie_agent_killed_common]](einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, 0);
  else
    on_humanoid_agent_killed_common(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, 0);

  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype]["gametype_on_killed"])) {
    func = level.agent_funcs[self.unittype]["gametype_on_killed"];

    if(isDefined(func))
      self[[func]](einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration);
  } else {
    func = level.agent_funcs[self.agent_type]["gametype_on_killed"];

    if(isDefined(func))
      self[[func]](einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration);
  }

  _id_D785E68A23BA79C1 = spawnStruct();
  _id_D785E68A23BA79C1.einflictor = einflictor;
  _id_D785E68A23BA79C1.eattacker = eattacker;
  _id_D785E68A23BA79C1.idamage = idamage;
  _id_D785E68A23BA79C1.smeansofdeath = smeansofdeath;
  _id_D785E68A23BA79C1.sweapon = objweapon;
  _id_D785E68A23BA79C1.vdir = vdir;
  _id_D785E68A23BA79C1.shitloc = shitloc;
  _id_D785E68A23BA79C1.timeoffset = timeoffset;
  _id_D785E68A23BA79C1.deathanimduration = deathanimduration;
  _id_4C770A9A4AD7659C::callback("on_ai_killed", _id_D785E68A23BA79C1);
}

getnumactiveagents(type) {
  if(!isDefined(type))
    type = "all";

  agents = getactiveagentsoftype(type);
  return agents.size;
}

getactiveagentsoftype(type) {
  if(!isDefined(level.agentarray))
    return [];

  agents = [];

  foreach(agent in level.agentarray) {
    if(istrue(agent.isactive)) {
      if(type == "all" || agent.agent_type == type)
        agents[agents.size] = agent;
    }
  }

  return agents;
}

getaliveagentsofteam(team) {
  _id_C5C35CC6C0816DE1 = [];

  foreach(agent in level.agentarray) {
    if(isalive(agent) && isDefined(agent.team) && agent.team == team)
      _id_C5C35CC6C0816DE1[_id_C5C35CC6C0816DE1.size] = agent;
  }

  return _id_C5C35CC6C0816DE1;
}

activateagent() {
  self.isactive = 1;
}

ai_washitbyvehicle(meansofdeath, attacker) {
  if(meansofdeath != "MOD_CRUSH")
    return 0;

  if(!isDefined(attacker))
    return 0;

  if(!attacker scripts\cp_mp\vehicles\vehicle::isvehicle())
    return 0;

  return 1;
}

on_humanoid_agent_killed_common(einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, _id_6F593AD6C6267D6D) {
  _id_37A99E672A1ECC0E = ai_washitbyvehicle(smeansofdeath, einflictor);
  self asmdodeathtransition(self.asmname);

  if(isDefined(self.deathanimduration))
    deathanimduration = self.deathanimduration;
  else if(deathanimduration == 0)
    deathanimduration = 500;

  if(isDefined(self.fncleanupbt))
    self[[self.fncleanupbt]]();

  if(isDefined(self.nocorpse)) {
    return;
  }
  victim = self;
  self.body = self cloneagent(deathanimduration);

  if(_id_0CBB0697DE4C5728::_id_BBEE2E46AB15A720(eattacker, objweapon, smeansofdeath, shitloc, einflictor)) {
    return;
  }
  _id_8FD538CBEEACDFA8 = spawnStruct();
  _id_8FD538CBEEACDFA8.body = self.body;
  _id_4C770A9A4AD7659C::callback("killed_body_cloned", _id_8FD538CBEEACDFA8);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ai_mp_controller", "agentPers_setAgentPersData", 1)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "agentPers_setAgentPersData")]](self, "weaponDropOrigin", self gettagorigin("tag_weapon_right"));
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("ai_mp_controller", "agentPers_setAgentPersData")]](self, "weaponDropAngles", self gettagangles("tag_weapon_right"));
  }

  if(isDefined(self._blackboard.currentvehicle)) {
    if(isDefined(smeansofdeath) && smeansofdeath == "MOD_FIRE")
      self.ragdoll_directionscale = 0;

    if(istrue(self.burningtodeath)) {
      if(self isscriptable() && self.body isscriptable()) {
        currentstate = self getscriptablepartstate("burn_to_death_by_molotov", 1);

        if(isDefined(currentstate) && currentstate == "active") {
          self.body setscriptablepartstate("burn_to_death_by_molotov", "active", 1);
          thread updateburningtodeath(self.body);
        }
      }
    }

    if(!self._blackboard.invehicle || istrue(self._blackboard._id_80912EC8ADE08716)) {
      if(_id_37A99E672A1ECC0E)
        self.body startragdollfromvehicleimpact(einflictor);
      else if(should_do_immediate_ragdoll(self)) {
        if(isDefined(self.ragdollhitloc) && isDefined(self.ragdollimpactvector))
          self.body startragdollfromimpact(self.ragdollhitloc, self.ragdollimpactvector);
        else
          do_immediate_ragdoll(self.body);
      } else
        thread delaystartragdoll(self.body, shitloc, vdir, objweapon, einflictor, smeansofdeath);
    } else {
      self.body enablelinkTo();
      deathanim = self.body getcorpseanim();
      _id_689EF6000ED3E5FC = getnotetracktimes(deathanim, "start_ragdoll");
      _id_10CCD1EB1D027B69 = isDefined(_id_689EF6000ED3E5FC) && _id_689EF6000ED3E5FC.size > 0;

      if(istrue(self._blackboard._id_F6D06D1E68F4F4E5))
        self.body linktoblendtotag(self._blackboard.currentvehicle, self._blackboard._id_1745D2B69C72C627, 0);
      else
        self.body linktomoveoffset(self._blackboard.currentvehicle, self._blackboard._id_1745D2B69C72C627);

      if(isDefined(self._blackboard.vehicledeathwait) || _id_10CCD1EB1D027B69)
        thread delaystartragdoll(self.body, shitloc, objweapon, einflictor, smeansofdeath);
      else {
        self.body thread ragdoll_on_vehicle_death(self._blackboard.currentvehicle);
        seatid = _id_07687424C385DE94(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA);

        if(isDefined(seatid))
          thread _id_89FCC8D16C4FD558(self.body, self._blackboard.currentvehicle, seatid, 1);
      }
    }
  } else if(istrue(self.burningtodeath)) {
    if(self isscriptable() && self.body isscriptable()) {
      currentstate = self getscriptablepartstate("burn_to_death_by_molotov", 1);

      if(isDefined(currentstate) && currentstate == "active") {
        self.body setscriptablepartstate("burn_to_death_by_molotov", "active", 1);
        thread updateburningtodeath(self.body);
        thread delaystartragdoll(self.body, shitloc, vdir, objweapon, einflictor, smeansofdeath);
      }
    }
  } else if(_id_37A99E672A1ECC0E)
    self.body startragdollfromvehicleimpact(einflictor);
  else if(should_do_immediate_ragdoll(self)) {
    if(isDefined(self.ragdollhitloc) && isDefined(self.ragdollimpactvector))
      self.body startragdollfromimpact(self.ragdollhitloc, self.ragdollimpactvector);
    else
      do_immediate_ragdoll(self.body);
  } else
    thread delaystartragdoll(self.body, shitloc, vdir, objweapon, einflictor, smeansofdeath);
}

_id_89FCC8D16C4FD558(corpse, vehicle, seatid, _id_F9E25038FED22BF0) {
  corpse endon("death");
  corpse endon("cancel_delete_corpse");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_assignseatcorpse(corpse, vehicle, seatid, _id_F9E25038FED22BF0);
  vehicle waittill("death");

  if(isDefined(corpse))
    corpse delete();
}

_id_07687424C385DE94(vehicle, _id_BC676A8C07563150) {
  foreach(seatid, _id_5539341A688C012F in scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD()).occupancy.seatids) {
    if(_id_5539341A688C012F == _id_BC676A8C07563150)
      return seatid;
  }
}

ragdoll_on_vehicle_death(vehicle) {
  self endon("entitydeleted");

  if(self isragdoll()) {
    return;
  }
  if(isDefined(vehicle)) {
    for(;;) {
      if(!isDefined(self)) {
        return;
      }
      if(!isDefined(vehicle) || vehicle scripts\common\vehicle_code::vehicle_iscorpse()) {
        self unlink();
        self startragdoll();
        return;
      }

      waitframe();
    }
  }
}

should_do_immediate_ragdoll(agent) {
  if(istrue(agent.do_immediate_ragdoll))
    return 1;

  if(istrue(agent.forceragdollimmediate))
    return 1;

  if(istrue(self._id_0AA0214E1292A7B3) && !isDefined(self.vehicledeathwait))
    return 1;

  return 0;
}

do_immediate_ragdoll(_id_9EBD9BA17CF84487) {
  if(!isDefined(_id_9EBD9BA17CF84487)) {
    return;
  }
  if(isDefined(_id_9EBD9BA17CF84487.ragdollhitloc) && isDefined(_id_9EBD9BA17CF84487.ragdollimpactvector)) {
    _id_9EBD9BA17CF84487 startragdollfromimpact(_id_9EBD9BA17CF84487.ragdollhitloc, _id_9EBD9BA17CF84487.ragdollimpactvector);
    return;
  }

  _id_BFEBD8ADBC01A3B6 = 10;
  _id_D95DA0355CF4CCB4 = scripts\common\utility::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && isPlayer(self.attacker) && _id_D95DA0355CF4CCB4 == "melee")
    _id_BFEBD8ADBC01A3B6 = 5;

  damagetaken = self.damagetaken;

  if(_id_D95DA0355CF4CCB4 == "bullet" || isDefined(self.damagemod) && self.damagemod == "MOD_FIRE")
    damagetaken = min(damagetaken, 300);

  _id_AD937FF34AB29B84 = _id_BFEBD8ADBC01A3B6 * damagetaken;
  _id_041F464988E49DDB = max(0.3, self.damagedir[2]);
  direction = (self.damagedir[0], self.damagedir[1], _id_041F464988E49DDB);

  if(isDefined(self.ragdoll_directionscale))
    direction = direction * self.ragdoll_directionscale;
  else
    direction = direction * _id_AD937FF34AB29B84;

  if(self.forceragdollimmediate)
    direction = direction + self.prevanimdelta * 20 * 10;

  if(isDefined(self.ragdoll_start_vel))
    direction = direction + self.ragdoll_start_vel * 10;

  damagelocation = self.damagelocation;

  if(isDefined(self.ragdoll_damagelocation_none) && damagelocation == "none")
    damagelocation = self.ragdoll_damagelocation_none;

  _id_9EBD9BA17CF84487 startragdollfromimpact(damagelocation, direction);
}

delaystartragdoll(ent, shitloc, vdir, objweapon, einflictor, smeansofdeath) {
  if(isDefined(ent)) {
    deathanim = ent getcorpseanim();

    if(animhasnotetrack(deathanim, "ignore_ragdoll"))
      return;
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(_id_672C0CCE467A1C00 in level.noragdollents) {
      if(distancesquared(ent.origin, _id_672C0CCE467A1C00.origin) < 65536)
        return;
    }
  }

  _id_F0B2847D70267F37 = undefined;

  if(isDefined(self._blackboard.vehicledeathwait))
    _id_F0B2847D70267F37 = self._blackboard.vehicledeathwait;

  waitframe();

  if(!isDefined(ent)) {
    return;
  }
  if(ent isragdoll()) {
    return;
  }
  deathanim = ent getcorpseanim();

  if(animisleaf(deathanim)) {
    _id_E53A7053733AF173 = 0.35;
    waittime = 0;

    if(isDefined(_id_F0B2847D70267F37))
      waittime = _id_F0B2847D70267F37;
    else {
      times = getnotetracktimes(deathanim, "start_ragdoll");

      if(isDefined(times) && times.size > 0)
        _id_E53A7053733AF173 = times[0];
      else {
        times = getnotetracktimes(deathanim, "vehicle_death_ragdoll");

        if(isDefined(times) && times.size > 0)
          _id_E53A7053733AF173 = times[0];
      }

      waittime = _id_E53A7053733AF173 * getanimlength(deathanim) - level.frameduration / 1000;
    }

    if(waittime > 0)
      wait(waittime);
  }

  self unlink();

  if(isDefined(ent)) {
    if(isDefined(ent.ragdollhitloc) && isDefined(ent.ragdollimpactvector))
      ent startragdollfromimpact(ent.ragdollhitloc, ent.ragdollimpactvector);
    else
      ent startragdoll();
  }
}

updateburningtodeath(corpse) {
  wait 0.7;

  if(!isDefined(corpse)) {
    return;
  }
  corpse setcorpsemodel("burntbody_male_cp", 1);
  corpse dontinterpolate();
  wait 0.95;

  if(!isDefined(corpse)) {
    return;
  }
  corpse setscriptablepartstate("burn_to_death_by_molotov", "inactive");
}