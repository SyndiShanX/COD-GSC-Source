/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\agent_common.gsc
***********************************************/

codecallback_agentadded() {
  self[[level.initagentscriptvariables]]();
  agentteam = "axis";

  if(level.numagents % 2 == 0)
    agentteam = "allies";

  level.numagents++;
  self sethitlocdamagetable("ai_lochit_dmgtable");
  self[[level.setagentteam]](agentteam);
  level.agentarray[level.agentarray.size] = self;
}

codecallback_agentdamaged(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  sweapon = objweapon;

  if(isDefined(level.weaponmapfunc))
    objweapon = [[level.weaponmapfunc]](objweapon, einflictor);

  eattacker = [[level.agentvalidateattacker]](eattacker);
  _id_B652BF49FD2F53CD = self[[level.agentfunc]]("on_damaged");

  if(isDefined(_id_B652BF49FD2F53CD))
    self[[_id_B652BF49FD2F53CD]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

codecallback_agentimpaled(eattacker, objweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34) {
  if(isDefined(level.callbackplayerimpaled))
    [[level.callbackplayerimpaled]](eattacker, objweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34);
}

codecallback_agentkilled(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(isDefined(level.weaponmapfunc))
    objweapon = [[level.weaponmapfunc]](objweapon, einflictor);

  eattacker = [[level.agentvalidateattacker]](eattacker);
  _id_B652BF49FD2F53CD = self[[level.agentfunc]]("on_killed");

  if(isDefined(_id_B652BF49FD2F53CD))
    self thread[[_id_B652BF49FD2F53CD]](einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration);
}

codecallback_agentfinishweaponchange(_id_492B944276064F63, _id_82533969B4683DE4) {}

init() {
  initagentlevelvariables();
  _id_4F57E90811AA8900::registernotetracks();
  scripts\asm\asm::setup_level_ents();
  level thread add_agents_to_game();
}

connectnewagent(agent_type, team, class) {
  agent = [[level.getfreeagent]](agent_type);

  if(isDefined(agent)) {
    agent.connecttime = gettime();

    if(isDefined(team))
      agent[[level.setagentteam]](team);
    else
      agent[[level.setagentteam]](agent.team);

    if(isDefined(class))
      agent.class_override = class;

    if(isDefined(level.agent_funcs[agent_type]["onAIConnect"]))
      agent[[agent[[level.agentfunc]]("onAIConnect")]]();

    agent[[level.addtocharactersarray]]();
  }

  return agent;
}

initagentlevelvariables() {
  level.agentarray = [];
  level.numagents = 0;
}

add_agents_to_game() {
  level endon("game_ended");
  level waittill("connected", player);
  maxagents = getmaxagents();

  while(level.agentarray.size < maxagents) {
    agent = addagent();

    if(!isDefined(agent)) {
      waitframe();
      continue;
    }
  }

  level._id_61198536443AD7EC = 1;
}

set_agent_health(health) {
  self.health = health;
  self.maxhealth = health;
}