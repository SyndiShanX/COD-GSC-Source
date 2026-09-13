/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\squad_utility.gsc
***************************************************/

_id_C9406922E0267F09() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("squad_utility", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("squad_utility", "init")]]();
}

_id_5A009FE17F688C92(_id_68BB1F110EC06A58, _id_7102F45D5F0B5834) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("squad_utility", "getSquadMembers"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("squad_utility", "getSquadMembers")]](_id_68BB1F110EC06A58, _id_7102F45D5F0B5834);

  return [];
}

getsquadleader(team, index) {
  if(!istrue(level.usesquadleader))
    return undefined;

  return level.squaddata[team][index]._id_D6EE3E704C6731D4;
}

shouldmodesetsquads() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(istrue(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("teamAssim", "isEnabled"))) {
      _id_14BABD7BB6A93112 = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("teamAssim", "getMaxAssimilationTeamSize");
      return isDefined(_id_14BABD7BB6A93112) && _id_14BABD7BB6A93112 > 1;
    } else
      return issquadmode();
  }

  switch (level.gametype) {
    case "bigctf":
    case "incursion":
    case "brtdm_mgl":
    case "brtdm":
    case "missions":
    case "arena":
    case "ob":
    case "gwai":
    case "gwbomb":
    case "risk":
    case "pill":
    case "defcon":
    case "conflict":
    case "gwtdm":
    case "arm":
      return issquadmode();
    default:
      return 0;
  }
}

_id_A9CB1BBCE9EB3D1B() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(getDvar("dvar_7611A2790A0BF7FE", "") == "rumble_mgl")
      return 0;
    else if(getdvarint("dvar_80BA0C604A8E46F3", 0) == 1)
      return 0;
    else
      return 1;
  }

  switch (level.gametype) {
    case "arena":
      return 1;
    default:
      return 0;
  }
}

issquadmode() {
  return level.maxsquadsize > 1;
}

_id_6B09C63FEBC4655C(team, index) {
  if(!isDefined(level.squaddata[team][index]))
    return 0;

  return level.squaddata[team][index].players.size == level.maxsquadsize;
}