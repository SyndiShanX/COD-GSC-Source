/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_risk_flag_spawn.gsc
*******************************************************/

init() {
  level.risk_flagspawnminradius = getdvarfloat("dvar_30EA28E66FC1DFA3", 0);
  level.risk_flagspawnmaxradius = getdvarfloat("dvar_98BF29016CA130F5", 70000);
  level.risk_flagspawnminactivetospawn = getdvarfloat("dvar_8AFCADDF97189809", 2);
  level.risk_flagspawnradiuschange = getdvarfloat("dvar_A64C6BDC0958F06B", -10000);
  level.risk_flagspawncount = getdvarfloat("dvar_7DAF1D48BE52BC6B", 10);
  level.risk_flagspawnmincount = getdvarfloat("dvar_86B09D614C713FE4", 4);
  level.risk_flagspawncountchange = getdvarfloat("dvar_990D0D38200FE0EC", -2);
  level.risk_flagspawnshiftingcenter = getdvarint("dvar_5566044EB5856B34", 1);
  level.risk_flagspawnshiftingpercent = getdvarfloat("dvar_1B7F09A2292BB32A", 0.3);
  level.risk_modifyflagstieronrespawn = getdvarfloat("dvar_9FB83C414123B975", 0);
  level.risk_currentflagsactive = 0;
  level.risk_currentflagstier = 0;
  level.risk_currentlocsinuse = [];
  thread riskspawn_initialset();
}

riskspawn_debugobjective(pos) {
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  level.risk_flagspawndebugobjicons[level.risk_flagspawndebugobjicons.size] = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "current", pos, "icon_waypoint_koth");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 0);
  }
}

riskspawn_debugdvar() {
  level.risk_flagspawndebugobjicons = [];

  for(;;) {
    if(getdvarint("dvar_BC5F77F5E98EB2ED", 0) != 0) {
      _id_AC0E5E4AC96AAEA7 = getdvarint("dvar_BC5F77F5E98EB2ED");
      setDvar("dvar_BC5F77F5E98EB2ED", 0);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AC0E5E4AC96AAEA7; _id_AC0E594AC96AA3A8++) {
        riskspawn_flagcaptured();
        wait 0.1;
      }
    }

    if(getdvarint("dvar_9FC32801D390AE4A", 0) != 0) {
      setDvar("dvar_9FC32801D390AE4A", 0);

      if(getdvarint("dvar_4DBA30F9E7210EA7", 0) == 1) {
        foreach(objid in level.risk_flagspawndebugobjicons) {
          scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
          scripts\mp\objidpoolmanager::returnobjectiveid(objid);
        }

        level.risk_flagspawndebugobjicons = [];
      }

      _id_75144959C084E4B0 = [];

      foreach(loc in level.risk_currentlocsinuse)
      _id_75144959C084E4B0[_id_75144959C084E4B0.size] = loc;

      foreach(loc in _id_75144959C084E4B0) {
        riskspawn_flagcaptured(loc);
        wait 0.1;
      }
    }

    if(getdvarint("dvar_8F062DBB890FD7EB", 0) != 0) {
      points = getquestpoints(7);
      maxdist = 0;

      foreach(point in points) {
        dist = distance2d(level.mapcenter, point.origin);

        if(dist > maxdist)
          maxdist = dist;
      }

      setDvar("dvar_8F062DBB890FD7EB", 0);
    }

    waitframe();
  }
}

riskspawn_initialset() {
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 10;
  riskspawn_flagspawnbytier(level.mapcenter, 0, 1);
}

riskspawn_flagspawnbytier(center, tier, firsttime) {
  _id_95BEA949F8FC8A68 = riskspawn_getspawnlocationsbytier(center, tier);

  foreach(loc in _id_95BEA949F8FC8A68) {
    if(getdvarint("dvar_4DBA30F9E7210EA7", 0) == 1)
      riskspawn_debugobjective(loc.origin);

    level.risk_currentlocsinuse[loc.index] = spawnStruct();
    level.risk_currentlocsinuse[loc.index].index = loc.index;
    level.risk_currentlocsinuse[loc.index].origin = loc.origin;
    level.risk_currentlocsinuse[loc.index].spawnflags = loc.spawnflags;
    level.risk_currentflagsactive++;
    label = level.labels[level.labelsused];

    if(level.labelsused == level.labels.size) {
      level.labelsused = 0;
      label = level.labels[level.labelsused];
    } else
      level.labelsused++;

    level.objectives[level.objectives.size] = _id_512B05921DE1EA79::spawndomplateflag(loc, label);
  }

  if(firsttime)
    level thread _id_512B05921DE1EA79::announcedomplatespawns(firsttime);
}

riskspawn_flagcaptured(index) {
  if(isDefined(level.risk_currentlocsinuse)) {
    if(scripts\engine\utility::array_contains_key(level.risk_currentlocsinuse, index))
      level.risk_currentlocsinuse = scripts\engine\utility::array_remove_key(level.risk_currentlocsinuse, index);
    else {}

    level.risk_currentflagsactive--;
  }

  if(level.risk_currentflagsactive < level.risk_flagspawnminactivetospawn) {
    if(level.risk_modifyflagstieronrespawn > 0)
      level.risk_currentflagstier++;

    riskspawn_flagspawnbytier(level.mapcenter, level.risk_currentflagstier, 0);
  }
}

riskspawn_getspawnlocationsbytier(center, tier) {
  _id_5991EF3EA72A6543 = level.risk_flagspawnmaxradius + level.risk_flagspawnradiuschange * tier;

  if(_id_5991EF3EA72A6543 <= level.risk_flagspawnminradius)
    _id_5991EF3EA72A6543 = level.risk_flagspawnminradius - level.risk_flagspawnradiuschange;

  _id_E8BE0C74DF002FE7 = level.risk_flagspawncount + level.risk_flagspawncountchange * tier;

  if(_id_E8BE0C74DF002FE7 < level.risk_flagspawnmincount)
    _id_E8BE0C74DF002FE7 = level.risk_flagspawnmincount;

  return riskspawn_getspawnlocations(center, level.risk_flagspawnminradius, _id_5991EF3EA72A6543, _id_E8BE0C74DF002FE7);
}

riskspawn_getspawnlocations(center, minradius, _id_5991EF3EA72A6543, _id_E8BE0C74DF002FE7) {
  if(level.risk_flagspawnshiftingcenter == 1)
    center = _id_2695A20D4011076D::getrandompointincircle(center, _id_5991EF3EA72A6543 * level.risk_flagspawnshiftingpercent);

  _id_DCE4E61566A75912 = getquestpoints(7, center, _id_5991EF3EA72A6543, minradius, 1);
  _id_DCE4E61566A75912 = scripts\engine\utility::array_randomize(_id_DCE4E61566A75912);
  _id_95BEA949F8FC8A68 = [];

  if(_id_DCE4E61566A75912.size > 0) {
    _id_85F76FD9B5AF5A84 = int(min(_id_E8BE0C74DF002FE7, _id_DCE4E61566A75912.size));
    _id_9A6BA9F5A0E705C7 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_85F76FD9B5AF5A84; _id_AC0E594AC96AA3A8++) {
      while(scripts\engine\utility::array_contains_key(level.risk_currentlocsinuse, _id_DCE4E61566A75912[_id_9A6BA9F5A0E705C7].index)) {
        _id_9A6BA9F5A0E705C7++;

        if(_id_9A6BA9F5A0E705C7 > _id_DCE4E61566A75912.size)
          return _id_95BEA949F8FC8A68;
      }

      _id_95BEA949F8FC8A68[_id_95BEA949F8FC8A68.size] = _id_DCE4E61566A75912[_id_9A6BA9F5A0E705C7];
      _id_9A6BA9F5A0E705C7++;
    }
  }

  return _id_95BEA949F8FC8A68;
}