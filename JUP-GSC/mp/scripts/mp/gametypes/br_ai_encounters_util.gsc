/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_ai_encounters_util.gsc
*************************************************************/

#using scripts\engine\utility;
#namespace br_ai_encounters_util;

function get_ai_team() {
  if(isDefined(self.encounter.info.team)) {
    return self.encounter.info.team;
  }

  playercount = [];

  foreach(team in level.teamnamelist) {
    playercount[team] = 0;
  }

  foreach(player in level.players) {
    team = player.pers["team"];

    if(!isDefined(team) || team == "spectator") {
      continue;
    }

    playercount[team]++;
  }

  foreach(team, count in playercount) {
    if(count == 0) {
      self.encounter.info.team = team;
      break;
    }
  }

  if(!isDefined(self.encounter.info.team)) {
    println("<dev string:x1c>");
    self.encounter.info.team = random(level.teamnamelist);
  }

  return self.encounter.info.team;
}

function get_targets() {
  targets = [];

  if(isDefined(self.target)) {
    structs = getStructArray(self.target, "targetname");

    foreach(struct in structs) {
      targets[targets.size] = struct;
    }

    ents = getEntArray(self.target, "targetname");

    foreach(ent in ents) {
      targets[targets.size] = ent;
    }

    nodes = getnodearray(self.target, "targetname");

    foreach(node in nodes) {
      targets[targets.size] = node;
    }
  }

  return targets;
}

function getvartype(var) {
  if(!isDefined(var)) {
    return "undefined";
  } else if(isfunction(var)) {
    return "function";
  } else if(isbuiltinfunction(var)) {
    return "builtin function";
  } else if(isbuiltinmethod(var)) {
    return "builtin method";
  } else if(isanimation(var)) {
    return "animation";
  } else if(isarray(var)) {
    return "array";
  } else if(isstruct(var)) {
    str = "struct";
  } else if(isvector(var)) {
    str = "vector";
  } else if(isent(var)) {
    str = "entity";
  } else if(isnode(var)) {
    str = "node";
  } else if(isint(var)) {
    str = "int";
  } else if(isfloat(var)) {
    str = "float";
  } else if(isstring(var)) {
    str = "string";
  } else if(isistring(var)) {
    str = "istring";
  } else {
    str = "unknown";
  }

  return str;
}

function vartostring(var) {
  type = getvartype(var);

  switch (type) {
    case #"hash_b38a5d117ade0306":
      return _arraytostring(var);
    case #"hash_a08ace5b3c23c762":
      return ("(" + var [0] + "," + var [1] + "," + var [2] + ")");
    case #"hash_3e4a6f464c850b65":
    case #"hash_4730906c2f53f03e":
      return ("" + var);
    case #"hash_2ac140ce3b5ea398":
      return var;
    case #"hash_83e3a4585099313a":
      return ("$e" + var getentitynumber());
    default:
      return ("<" + type + ">");
  }
}

function _arraytostring(var) {
  str = "[ ";
  first = 1;

  foreach(value in
    var) {
    if(!first) {
      str += ",";
    } else {
      first = 0;
    }

    str += vartostring(value);
  }

  str += " ]";
  return str;
}

function encounterremovenavobstacle(obstacleid) {
  destroynavobstacle(obstacleid);
  self notify("nav_obstacle_destroy_" + obstacleid);
}

function encounterremovenavobstacleonencounterend(obstacleid) {
  self endon("nav_obstacle_destroy_" + obstacleid);
  self waittill("encounter_end");
  encounterremovenavobstacle(obstacleid);
}

function encounterremovenavobstacledelay(obstacleid, delaysec) {
  self endon("nav_obstacle_destroy_" + obstacleid);
  self endon("encounter_end");
  wait delaysec;
  encounterremovenavobstacle(obstacleid);
}

function encounterdeleteentonend(ent) {
  ent endon("death");
  self waittill("encounter_end");
  ent delete();
}

function disablescriptableplayeruseall(rewardobject) {
  foreach(player in level.players) {
    rewardobject disablescriptableplayeruse(player);
  }
}

function enablescriptableplayeruseall(rewardobject) {
  foreach(player in level.players) {
    rewardobject enablescriptableplayeruse(player);
  }
}

function waittill_dead(guys, num, timeoutlength) {
  allalive = 1;

  foreach(member in guys) {
    if(isalive(member)) {
      continue;
    }

    allalive = 0;
    break;
  }

  assertex(allalive, "<dev string:x6a>");

  if(!allalive) {
    newarray = [];

    foreach(member in guys) {
      if(isalive(member)) {
        newarray[newarray.size] = member;
      }
    }

    guys = newarray;
  }

  ent = spawnStruct();

  if(isDefined(timeoutlength)) {
    ent endon("thread_timed_out");
    ent thread waittill_dead_timeout(timeoutlength);
  }

  ent.count = guys.size;

  if(isDefined(num) && num < ent.count) {
    ent.count = num;
  }

  array_thread(guys, &waittill_dead_thread, ent);

  while(ent.count > 0) {
    ent waittill("waittill_dead guy died");
  }
}

function waittill_dead_or_dying(guys, num, timeoutlength) {
  newarray = [];

  foreach(member in guys) {
    if(isalive(member) && !member.ignoreforfixednodesafecheck) {
      newarray[newarray.size] = member;
    }
  }

  guys = newarray;
  ent = spawnStruct();

  if(isDefined(timeoutlength)) {
    ent endon("thread_timed_out");
    ent thread waittill_dead_timeout(timeoutlength);
  }

  ent.count = guys.size;

  if(isDefined(num) && num < ent.count) {
    ent.count = num;
  }

  array_thread(guys, &waittill_dead_or_dying_thread, ent);

  while(ent.count > 0) {
    ent waittill("waittill_dead_guy_dead_or_dying");
  }
}

function waittill_notetrack_or_damage(notetrack) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", notetrack);
}

function get_living_ai(name, type) {
  array = get_living_ai_array(name, type);

  if(array.size > 1) {
    assertmsg("<dev string:xc8>" + type + "<dev string:x103>" + name + "<dev string:x10f>");
    return undefined;
  }

  return array[0];
}

function get_living_ai_array(name, type) {
  ai = getaispeciesarray("all", "all");
  array = [];

  foreach(actor in ai) {
    if(!isalive(actor)) {
      continue;
    }

    switch (type) {
      case #"hash_5a532485943b3d4b":
        if(isDefined(actor.targetname) && actor.targetname == name) {
          array[array.size] = actor;
        }

        break;
      case #"hash_6d8a4db48060bf8":
        if(isDefined(actor.script_noteworthy) && actor.script_noteworthy == name) {
          array[array.size] = actor;
        }

        break;
      case #"hash_a9ba80180b5bb733":
        if(isDefined(actor.animname) && actor.animname == name) {
          array[array.size] = actor;
        }

        break;
    }
  }

  return array;
}

function waittill_dead_thread(ent) {
  self waittill("death");
  ent.count--;
  ent notify("waittill_dead guy died");
}

function waittill_dead_or_dying_thread(ent) {
  waittill_either("death", "long_death");
  ent.count--;
  ent notify("waittill_dead_guy_dead_or_dying");
}

function waittill_dead_timeout(timeoutlength) {
  wait timeoutlength;
  self notify("thread_timed_out");
}