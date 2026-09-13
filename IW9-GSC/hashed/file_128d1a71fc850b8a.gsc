/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_128d1a71fc850b8a.gsc
***********************************************/

init() {
  level.brgametype._id_D5C773AFD22DA0C5 = getdvarint("dvar_158F6C01CCEFB107", 0) == 1;

  if(!istrue(level.brgametype._id_D5C773AFD22DA0C5)) {
    return;
  }
  level.brgametype._id_00D03527FF0E6315 = getdvarint("dvar_BEEF8246B709C849", 5);
  level.brgametype._id_3F4C679970C59455 = getdvarint("dvar_EC1144DA8D0EBB36", 4);
  level.brgametype._id_4B58204F3C5987D8 = getdvarint("dvar_BA144C4A820CD8F9", 1);
  level.brgametype._id_CC07CA7D5AEB1F87 = getdvarint("dvar_E2660EC466D23BF9", 100);
  level.brgametype._id_6D7EB4B39F6FEA2D = pow(getdvarint("dvar_7000264C08E7AC45", 500), 2);
  level.brgametype._id_D0ADFB51398BDF71 = getdvarint("dvar_3A8F51B0EAA8B895", 3);
  level.brgametype._id_5FCA7073368D1EEB = getdvarint("dvar_22C52597541EC14C", 100);
  _id_6269246106806189 = scripts\engine\utility::getStructArray("racket", "targetname");

  if(_id_6269246106806189.size == 0 || level.brgametype._id_00D03527FF0E6315 == 0) {
    return;
  }
  if(_id_6269246106806189.size < level.brgametype._id_00D03527FF0E6315)
    level.brgametype._id_00D03527FF0E6315 = _id_6269246106806189.size;

  _id_6269246106806189 = scripts\engine\utility::array_randomize(_id_6269246106806189);

  foreach(_id_9C5522E892F1F89F in _id_6269246106806189)
  _id_719E6E9E78EEC15F(_id_9C5522E892F1F89F);

  level.brgametype._id_74CBED034A36DBAA = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.brgametype._id_00D03527FF0E6315; _id_AC0E594AC96AA3A8++) {
    _id_9C5522E892F1F89F = _id_6269246106806189[_id_AC0E594AC96AA3A8];
    level.brgametype._id_74CBED034A36DBAA[level.brgametype._id_74CBED034A36DBAA.size] = _id_9C5522E892F1F89F;
    thread _id_EB74659878A99A6C(_id_9C5522E892F1F89F);
  }

  scripts\mp\flags::gameflagwait("prematch_fade_done");
  _id_48814951E916AF89::_id_BA4022744DCE59F6("racket");

  foreach(_id_9C5522E892F1F89F in level.brgametype._id_74CBED034A36DBAA)
  thread _id_73572D13BC47F601(_id_9C5522E892F1F89F);
}

_id_719E6E9E78EEC15F(_id_9C5522E892F1F89F) {
  _id_9C5522E892F1F89F._id_2EF873E30A270BCF = [];
  _id_9C5522E892F1F89F._id_4CC04C6A9DBFD0EE = [];
  _id_9C5522E892F1F89F._id_F5D30F51AB09B3F8 = [];
  _id_B5C3A12C64229F24 = scripts\engine\utility::getStructArray(_id_9C5522E892F1F89F.target, "targetname");

  foreach(node in _id_B5C3A12C64229F24) {
    if(!isDefined(node.script_noteworthy)) {
      continue;
    }
    script_noteworthy = tolower(node.script_noteworthy);

    switch (script_noteworthy) {
      case "guard":
        _id_9C5522E892F1F89F._id_2EF873E30A270BCF[_id_9C5522E892F1F89F._id_2EF873E30A270BCF.size] = node;
        break;
      case "cache":
        _id_9C5522E892F1F89F._id_4CC04C6A9DBFD0EE[_id_9C5522E892F1F89F._id_4CC04C6A9DBFD0EE.size] = node;
        break;
      case "flag":
        _id_9C5522E892F1F89F._id_F5D30F51AB09B3F8[_id_9C5522E892F1F89F._id_F5D30F51AB09B3F8.size] = node;
        break;
      default:
        break;
    }
  }
}

_id_EB74659878A99A6C(_id_9C5522E892F1F89F) {
  _id_B006C818269D9E9C = _id_A33799270D64C339(_id_9C5522E892F1F89F);

  if(isDefined(_id_B006C818269D9E9C)) {
    _id_B006C818269D9E9C = "brstageditems:" + _id_B006C818269D9E9C;
    thread _id_15074130DA8A935C::init(_id_B006C818269D9E9C, undefined, 1);
  }
}

_id_73572D13BC47F601(_id_9C5522E892F1F89F) {
  level endon("game_ended");
  _id_9C5522E892F1F89F.agents = [];
  _id_9C5522E892F1F89F._id_2EF873E30A270BCF = scripts\engine\utility::array_randomize(_id_9C5522E892F1F89F._id_2EF873E30A270BCF);
  _id_675517B7C4C0DE3D(_id_9C5522E892F1F89F, level.brgametype._id_3F4C679970C59455, 1);
  _id_675517B7C4C0DE3D(_id_9C5522E892F1F89F, level.brgametype._id_4B58204F3C5987D8, 2);
  _id_48814951E916AF89::_id_35BAE74232FF8B77(0);
  _id_9C5522E892F1F89F._id_4CC04C6A9DBFD0EE = scripts\engine\utility::array_randomize(_id_9C5522E892F1F89F._id_4CC04C6A9DBFD0EE);
  _id_625FD0EB153C43B0(_id_9C5522E892F1F89F);
  _id_C851837194379726(_id_9C5522E892F1F89F);
  _id_D34497AE5051AB11(_id_9C5522E892F1F89F);
  thread _id_3D9918F00F98B775(_id_9C5522E892F1F89F);
}

_id_A33799270D64C339(_id_9C5522E892F1F89F) {
  _id_44E91535F06B130D = _id_9C5522E892F1F89F.script_noteworthy;

  if(!isDefined(_id_44E91535F06B130D)) {
    return;
  }
  mapname = level.mapname;
  _id_D7EABA8BF8FF0B00 = strtok(mapname, "_");
  _id_F3BBD3BE79C0316E = _id_D7EABA8BF8FF0B00[_id_D7EABA8BF8FF0B00.size - 1];
  return "wz2_" + _id_F3BBD3BE79C0316E + "_staged_" + _id_44E91535F06B130D;
}

_id_675517B7C4C0DE3D(_id_9C5522E892F1F89F, number, tier) {
  if(_id_9C5522E892F1F89F._id_2EF873E30A270BCF.size < number) {
    msg = "Not enough guard nodes with target : " + _id_9C5522E892F1F89F.target;
    number = _id_9C5522E892F1F89F._id_2EF873E30A270BCF.size;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < number; _id_AC0E594AC96AA3A8++) {
    _id_7D5ACB0650804B86 = _id_9C5522E892F1F89F._id_2EF873E30A270BCF[0];
    agent = _id_E7EF87A1BF538DBC(_id_9C5522E892F1F89F, _id_7D5ACB0650804B86, tier);
    _id_9C5522E892F1F89F.agents[_id_9C5522E892F1F89F.agents.size] = agent;
    _id_9C5522E892F1F89F._id_2EF873E30A270BCF = scripts\engine\utility::array_remove_index(_id_9C5522E892F1F89F._id_2EF873E30A270BCF, 0);
  }
}

_id_E7EF87A1BF538DBC(_id_9C5522E892F1F89F, _id_7D5ACB0650804B86, tier) {
  _id_1439F86640D42E34 = _id_48814951E916AF89::_id_06D1E55C48E2C12F();
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693(_id_1439F86640D42E34, tier);
  _id_2AC210AF318CF38B = getclosestpointonnavmesh(_id_7D5ACB0650804B86.origin + (0, 0, 30));
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, _id_2AC210AF318CF38B, undefined, "absolute", "racket");

  if(isagent(agent)) {
    agent.health = level.brgametype._id_CC07CA7D5AEB1F87;
    agent.maxhealth = level.brgametype._id_CC07CA7D5AEB1F87;
    agent.combatmode = "cover";
    agent.maxsightdistsqrd = level.brgametype._id_6D7EB4B39F6FEA2D;
    agent thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent, 0, _id_2AC210AF318CF38B);
    agent thread _id_4986E54BA19DE354(_id_9C5522E892F1F89F);
    return agent;
  }

  return undefined;
}

_id_625FD0EB153C43B0(_id_9C5522E892F1F89F) {
  number = level.brgametype._id_D0ADFB51398BDF71;

  if(_id_9C5522E892F1F89F._id_4CC04C6A9DBFD0EE.size < number) {
    msg = "Not enough cache nodes with target : " + _id_9C5522E892F1F89F.target;
    number = _id_9C5522E892F1F89F._id_4CC04C6A9DBFD0EE.size;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < number; _id_AC0E594AC96AA3A8++) {
    node = _id_9C5522E892F1F89F._id_4CC04C6A9DBFD0EE[_id_AC0E594AC96AA3A8];
    roll = randomint(100);
    _id_2B48101CA8AD8249 = "br_loot_cache";

    if(roll < level.brgametype._id_5FCA7073368D1EEB)
      _id_2B48101CA8AD8249 = "br_loot_cache_lege";

    scriptable = spawnscriptable(_id_2B48101CA8AD8249, node.origin, node.angles);
    scriptable setscriptablepartstate("body", "closed_usable");
  }
}

_id_C851837194379726(_id_9C5522E892F1F89F) {
  if(_id_9C5522E892F1F89F._id_F5D30F51AB09B3F8.size < 0)
    msg = "No flag node found with target : " + _id_9C5522E892F1F89F.target;

  foreach(node in _id_9C5522E892F1F89F._id_F5D30F51AB09B3F8)
  scripts\common\utility::_id_22490AAEBAAC105E("fabric_rectangular_aq_flag_windlevel_2_konni", node.origin, node.angles);
}

_id_D34497AE5051AB11(_id_9C5522E892F1F89F) {
  objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  scripts\mp\objidpoolmanager::objective_add(objidnum, "active", _id_9C5522E892F1F89F.origin, "hud_icon_objective_rackets", "icon_regular");
  objective_setbackground(objidnum, 1);
  objective_setrotateonminimap(objidnum, 1);
  objective_sethideelevation(objidnum, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objidnum);
  _id_9C5522E892F1F89F.objidnum = objidnum;
}

_id_2CCBD153C93AADE1(_id_9C5522E892F1F89F) {
  objective_delete(_id_9C5522E892F1F89F.objidnum);
  scripts\mp\objidpoolmanager::returnobjectiveid(_id_9C5522E892F1F89F.objidnum);
  _id_9C5522E892F1F89F notify("cleared");
}

_id_3D9918F00F98B775(_id_9C5522E892F1F89F) {
  level endon("game_ended");
  _id_9C5522E892F1F89F endon("cleared");

  for(;;) {
    if(_id_2695A20D4011076D::_id_024C5A8D31AE262F(_id_9C5522E892F1F89F.origin)) {
      if(_id_9C5522E892F1F89F.agents.size != 0) {
        foreach(agent in _id_9C5522E892F1F89F.agents)
        scripts\mp\agents\agent_utility::killagent(agent);
      }
    }

    wait 1;
  }
}

_id_4986E54BA19DE354(_id_9C5522E892F1F89F) {
  level endon("game_ended");
  self waittill("death");
  _id_9C5522E892F1F89F.agents = scripts\engine\utility::array_remove(_id_9C5522E892F1F89F.agents, self);

  if(_id_9C5522E892F1F89F.agents.size == 0)
    _id_2CCBD153C93AADE1(_id_9C5522E892F1F89F);
}