/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\agent_common.gsc
***********************************************/



#using scripts\anim\notetracks_mp;
#using scripts\asm\asm;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace agent_common;

function codecallback_agentadded() {
  self[[level.initagentscriptvariables]]();
  agentteam = "axis";

  if(level.numagents % 2 == 0) {
    agentteam = "allies";
  }

  level.numagents++;
  self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  self[[level.setagentteam]](agentteam);
  level.agentarray[level.agentarray.size] = self;
}

function codecallback_agentdamaged(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  sweapon = objweapon;

  if(isDefined(level.weaponmapfunc)) {
    objweapon = [[level.weaponmapfunc]](objweapon, einflictor);
  }

  eattacker = [[level.agentvalidateattacker]](eattacker);
  agent_func = self[[level.agentfunc]]("on_damaged");

  if(isDefined(agent_func)) {
    self[[agent_func]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  }
}

function codecallback_agentimpaled(eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34) {
  if(isDefined(level.callbackplayerimpaled)) {
    [[level.callbackplayerimpaled]](eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34);
  }
}

function codecallback_agentkilled(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(isDefined(level.weaponmapfunc)) {
    objweapon = [[level.weaponmapfunc]](objweapon, einflictor);
  }

  eattacker = [[level.agentvalidateattacker]](eattacker);
  agent_func = self[[level.agentfunc]]("on_killed");

  if(isDefined(agent_func)) {
    self thread[[agent_func]](einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration);
  }
}

function codecallback_agentfinishweaponchange(objoldweapon, objnewweapon) {}

function init() {
  initagentlevelvariables();
  scripts\anim\notetracks_mp::registernotetracks();
  level thread scripts\asm\asm::setup_level_ents();
  level thread add_agents_to_game();
}

function connectnewagent(agent_type, team, class) {
  agent = [[level.getfreeagent]](agent_type);

  if(isDefined(agent)) {
    agent.connecttime = gettime();

    if(isDefined(team)) {
      agent[[level.setagentteam]](team);
    } else {
      agent[[level.setagentteam]](agent.team);
    }

    if(isDefined(class)) {
      agent.class_override = class;
    }

    if(isDefined(level.agent_funcs[agent_type]["onAIConnect"])) {
      agent[[agent[[level.agentfunc]]("onAIConnect")]]();
    }

    agent[[level.addtocharactersarray]]();
    assertex(agent.connecttime == gettime(), "Agent spawn took too long - there should be no waits in connectNewAgent");
  }

  return agent;
}

function initagentlevelvariables() {
  level.agentarray = [];
  level.numagents = 0;

  if(!isDefined(level.var_e58efb25be1ee016)) {
    level.var_e58efb25be1ee016 = 0;
  }
}

function add_agents_to_game() {
  level endon("game_ended");
  level waittill("connected", player);
  maxagents = getmaxagents();
  println("<dev string:x1c>" + maxagents + "<dev string:x3a>");
  var_48a1bbbf94f76091 = getdvarint(@ "hash_3c453eaf21ea4a86", -1);

  while(level.agentarray.size < maxagents) {
    if(var_48a1bbbf94f76091 != -1 && level.agentarray.size != 0 && level.agentarray.size % var_48a1bbbf94f76091 == 0) {
      waitframe();
    }

    agent = addagent();

    if(!isDefined(agent)) {
      waitframe();
      continue;
    }
  }

  level.var_61198536443ad7ec = 1;
}

function set_agent_health(health) {
  self.health = health;
  self.maxhealth = health;
}

function ondeactivate() {
  self notify("killanimscript");
  self notify("terminate_ai_threads");
}