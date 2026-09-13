/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ai_encounters_util.gsc
**********************************************************/

get_ai_team() {
  if(isDefined(self.encounter.info.team))
    return self.encounter.info.team;

  _id_D12A341B40354143 = [];

  foreach(team in level.teamnamelist)
  _id_D12A341B40354143[team] = 0;

  foreach(player in level.players) {
    team = player.pers["team"];

    if(!isDefined(team) || team == "spectator") {
      continue;
    }
    _id_D12A341B40354143[team]++;
  }

  foreach(team, count in _id_D12A341B40354143) {
    if(count == 0) {
      self.encounter.info.team = team;
      break;
    }
  }

  if(!isDefined(self.encounter.info.team))
    self.encounter.info.team = scripts\engine\utility::random(level.teamnamelist);

  return self.encounter.info.team;
}

get_targets() {
  targets = [];

  if(isDefined(self.target)) {
    _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(struct in _id_9E4E1482CB40C9C5)
    targets[targets.size] = struct;

    ents = getEntArray(self.target, "targetname");

    foreach(ent in ents)
    targets[targets.size] = ent;

    nodes = getnodearray(self.target, "targetname");

    foreach(node in nodes)
    targets[targets.size] = node;
  }

  return targets;
}

getvartype(_id_06B5C8034010B9BA) {
  if(!isDefined(_id_06B5C8034010B9BA))
    return "undefined";
  else if(isfunction(_id_06B5C8034010B9BA))
    return "function";
  else if(isbuiltinfunction(_id_06B5C8034010B9BA))
    return "builtin function";
  else if(isbuiltinmethod(_id_06B5C8034010B9BA))
    return "builtin method";
  else if(isanimation(_id_06B5C8034010B9BA))
    return "animation";
  else if(isarray(_id_06B5C8034010B9BA))
    return "array";
  else if(isstruct(_id_06B5C8034010B9BA))
    str = "struct";
  else if(isvector(_id_06B5C8034010B9BA))
    str = "vector";
  else if(isent(_id_06B5C8034010B9BA))
    str = "entity";
  else if(isnode(_id_06B5C8034010B9BA))
    str = "node";
  else if(isint(_id_06B5C8034010B9BA))
    str = "int";
  else if(isfloat(_id_06B5C8034010B9BA))
    str = "float";
  else if(isstring(_id_06B5C8034010B9BA))
    str = "string";
  else if(isistring(_id_06B5C8034010B9BA))
    str = "istring";
  else
    str = "unknown";

  return str;
}

vartostring(_id_06B5C8034010B9BA) {
  type = getvartype(_id_06B5C8034010B9BA);

  switch (type) {
    case "array":
      return _arraytostring(_id_06B5C8034010B9BA);
    case "vector":
      return "(" + _id_06B5C8034010B9BA[0] + "," + _id_06B5C8034010B9BA[1] + "," + _id_06B5C8034010B9BA[2] + ")";
    case "float":
    case "int":
      return "" + _id_06B5C8034010B9BA;
    case "string":
      return _id_06B5C8034010B9BA;
    case "entity":
      return "$e" + _id_06B5C8034010B9BA getentitynumber();
    default:
      return "<" + type + ">";
  }
}

_arraytostring(_id_06B5C8034010B9BA) {
  str = "[ ";
  _id_19E7EC57B8CFB985 = 1;

  foreach(key, value in _id_06B5C8034010B9BA) {
    if(!_id_19E7EC57B8CFB985)
      str = str + ",";
    else
      _id_19E7EC57B8CFB985 = 0;

    str = str + vartostring(value);
  }

  str = str + " ]";
  return str;
}

encounterremovenavobstacle(_id_9794CF618646A8BD) {
  destroynavobstacle(_id_9794CF618646A8BD);
  self notify("nav_obstacle_destroy_" + _id_9794CF618646A8BD);
}

encounterremovenavobstacleonencounterend(_id_9794CF618646A8BD) {
  self endon("nav_obstacle_destroy_" + _id_9794CF618646A8BD);
  self waittill("encounter_end");
  encounterremovenavobstacle(_id_9794CF618646A8BD);
}

encounterremovenavobstacledelay(_id_9794CF618646A8BD, _id_9641FF6635273009) {
  self endon("nav_obstacle_destroy_" + _id_9794CF618646A8BD);
  self endon("encounter_end");
  wait(_id_9641FF6635273009);
  encounterremovenavobstacle(_id_9794CF618646A8BD);
}

encounterdeleteentonend(ent) {
  ent endon("death");
  self waittill("encounter_end");
  ent delete();
}

disablescriptableplayeruseall(_id_DE19F33CB691869D) {
  foreach(player in level.players)
  _id_DE19F33CB691869D disablescriptableplayeruse(player);
}

enablescriptableplayeruseall(_id_DE19F33CB691869D) {
  foreach(player in level.players)
  _id_DE19F33CB691869D enablescriptableplayeruse(player);
}

waittill_dead(guys, num, _id_F6A66E3FC1BF61C0) {
  ent = spawnStruct();

  if(isDefined(_id_F6A66E3FC1BF61C0)) {
    ent endon("thread_timed_out");
    ent thread waittill_dead_timeout(_id_F6A66E3FC1BF61C0);
  }

  ent.count = guys.size;

  if(isDefined(num) && num < ent.count)
    ent.count = num;

  scripts\engine\utility::array_thread(guys, ::waittill_dead_thread, ent);

  while(ent.count > 0)
    ent waittill("waittill_dead guy died");
}

waittill_dead_or_dying(guys, num, _id_F6A66E3FC1BF61C0) {
  _id_BFC65A378A6D8EFE = [];

  foreach(_id_80EF668C09FFB70F in guys) {
    if(isalive(_id_80EF668C09FFB70F) && !_id_80EF668C09FFB70F.ignoreforfixednodesafecheck)
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = _id_80EF668C09FFB70F;
  }

  guys = _id_BFC65A378A6D8EFE;
  ent = spawnStruct();

  if(isDefined(_id_F6A66E3FC1BF61C0)) {
    ent endon("thread_timed_out");
    ent thread waittill_dead_timeout(_id_F6A66E3FC1BF61C0);
  }

  ent.count = guys.size;

  if(isDefined(num) && num < ent.count)
    ent.count = num;

  scripts\engine\utility::array_thread(guys, ::waittill_dead_or_dying_thread, ent);

  while(ent.count > 0)
    ent waittill("waittill_dead_guy_dead_or_dying");
}

waittill_notetrack_or_damage(notetrack) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", notetrack);
}

get_living_ai(name, type) {
  array = get_living_ai_array(name, type);

  if(array.size > 1)
    return undefined;

  return array[0];
}

get_living_ai_array(name, type) {
  ai = getaispeciesarray("all", "all");
  array = [];

  foreach(actor in ai) {
    if(!isalive(actor)) {
      continue;
    }
    switch (type) {
      case "targetname":
        if(isDefined(actor.targetname) && actor.targetname == name)
          array[array.size] = actor;

        break;
      case "script_noteworthy":
        if(isDefined(actor.script_noteworthy) && actor.script_noteworthy == name)
          array[array.size] = actor;

        break;
      case "animname":
        if(isDefined(actor.animname) && actor.animname == name)
          array[array.size] = actor;

        break;
    }
  }

  return array;
}

waittill_dead_thread(ent) {
  self waittill("death");
  ent.count--;
  ent notify("waittill_dead guy died");
}

waittill_dead_or_dying_thread(ent) {
  scripts\engine\utility::waittill_either("death", "long_death");
  ent.count--;
  ent notify("waittill_dead_guy_dead_or_dying");
}

waittill_dead_timeout(_id_F6A66E3FC1BF61C0) {
  wait(_id_F6A66E3FC1BF61C0);
  self notify("thread_timed_out");
}