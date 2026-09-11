/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ai_encounters_util.gsc
**********************************************************/

function get_ai_team() {
  if(isDefined(self.encounter.info.team)) {
    return self.encounter.info.team;
  }

  var_0 = [];

  foreach(var_2 in level.teamnamelist) {
    var_0 = 0;
  }

  foreach(var_5 in level.players) {
    var_2 = var_5.pers["team"];

    if(!isDefined(var_2) || var_2 == "spectator") {
      continue;
    }

    var_0++;
  }

  foreach(var_2, var_8 in var_0) {
    if(var_8 == 0) {
      self.encounter.info.team = var_2;
      break;
    }
  }

  if(!isDefined(self.encounter.info.team)) {
    self.encounter.info.team = scripts\engine\utility::random(level.teamnamelist);
  }

  return self.encounter.info.team;
}

function get_targets() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(var_3 in var_1) {
      var_0 = var_3;
    }

    var_5 = getEntArray(self.target, "targetname");

    foreach(var_7 in var_5) {
      var_0 = var_7;
    }

    var_9 = getnodearray(self.target, "targetname");

    foreach(var_11 in var_9) {
      var_0 = var_11;
    }
  }

  return var_0;
}

function getvartype(var_0) {
  if(!isDefined(var_0)) {
    return "undefined";
  } else if(isbuiltinfunction(var_0)) {
    return "function";
  } else if(isbuiltinmethod(var_0)) {
    return "builtin function";
  } else if(isanimation(var_0)) {
    return "builtin method";
  } else if(dospawnaitype(var_0)) {
    return "animation";
  } else if(isarray(var_0)) {
    return "array";
  } else if(isstruct(var_0)) {
    var_1 = "struct";
  } else if(isvector(var_1)) {
    var_1 = "vector";
  } else if(isent(var_1)) {
    var_1 = "entity";
  } else if(isnode(var_1)) {
    var_1 = "node";
  } else if(isint(var_1)) {
    var_1 = "int";
  } else if(isfloat(var_1)) {
    var_1 = "float";
  } else if(isstring(var_1)) {
    var_1 = "string";
  } else if(isistring(var_1)) {
    var_1 = "istring";
  } else {
    var_1 = "unknown";
  }

  return var_1;
}

function vartostring(var_0) {
  var_1 = getvartype(var_0);

  switch (var_1) {
    case "array":
      return _arraytostring(var_0);
    case "vector":
      return ("(" + var_0[0] + "," + var_0[1] + "," + var_0[2] + ")");
    case "float":
    case "int":
      return ("" + var_0);
    case "string":
      return var_0;
    case "entity":
      return ("$e" + var_0 getentitynumber());
    default:
      return ("<" + var_1 + ">");
  }
}

function _arraytostring(var_0) {
  var_1 = "[ ";
  var_2 = 1;

  foreach(var_4 in var_0) {
    if(!var_2) {
      var_1 += ",";
    } else {
      var_2 = 0;
    }

    var_1 += vartostring(var_4);
  }

  var_1 += " ]";
  return var_1;
}

function encounterremovenavobstacle(var_0) {
  destroynavobstacle(var_0);
  self notify("nav_obstacle_destroy_" + var_0);
}

function encounterremovenavobstacleonencounterend(var_0) {
  self endon("nav_obstacle_destroy_" + var_0);
  self waittill("encounter_end");
  encounterremovenavobstacle(var_0);
}

function encounterremovenavobstacledelay(var_0, var_1) {
  self endon("nav_obstacle_destroy_" + var_0);
  self endon("encounter_end");
  wait var_1;
  encounterremovenavobstacle(var_0);
}

function encounterdeleteentonend(var_0) {
  var_0 endon("death");
  self waittill("encounter_end");
  var_0 delete();
}

function disablescriptableplayeruseall(var_0) {
  foreach(var_2 in level.players) {
    var_0 disablescriptableplayeruse(var_2);
  }
}

function enablescriptableplayeruseall(var_0) {
  foreach(var_2 in level.players) {
    var_0 enablescriptableplayeruse(var_2);
  }
}

function waittill_dead(var_0, var_1, var_2) {
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("thread_timed_out");
    thread waittill_dead_timeout(var_10);
  }

  var_10.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_10.count) {
    var_10.count = var_1;
  }

  scripts\engine\utility::array_thread(var_0, &waittill_dead_thread, var_10);

  while(var_10.count > 0) {
    var_10 waittill("waittill_dead guy died");
  }
}

function waittill_dead_or_dying(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isalive(var_5) && !var_5.ignoreforfixednodesafecheck) {
      var_3 = var_5;
    }
  }

  var_0 = var_3;
  var_7 = spawnStruct();

  if(isDefined(var_2)) {
    var_7 endon("thread_timed_out");
    thread waittill_dead_timeout(var_7);
  }

  var_7.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_7.count) {
    var_7.count = var_1;
  }

  scripts\engine\utility::array_thread(var_0, &waittill_dead_or_dying_thread, var_7);

  while(var_7.count > 0) {
    var_7 waittill("waittill_dead_guy_dead_or_dying");
  }
}

function waittill_notetrack_or_damage(var_0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var_0);
}

function get_living_ai(var_0, var_1) {
  var_2 = get_living_ai_array(var_0, var_1);

  if(var_2.size > 1) {
    return undefined;
  }

  return var_2[0];
}

function get_living_ai_array(var_0, var_1) {
  var_2 = getaispeciesarray("all", "all");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isalive(var_5)) {
      continue;
    }

    switch (var_1) {
      case "targetname":
        if(isDefined(var_5.targetname) && var_5.targetname == var_0) {
          var_3 = var_5;
        }

        break;
      case "script_noteworthy":
        if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0) {
          var_3 = var_5;
        }

        break;
      case "animname":
        if(isDefined(var_5.animname) && var_5.animname == var_0) {
          var_3 = var_5;
        }

        break;
    }
  }

  return var_3;
}

function waittill_dead_thread(var_0) {
  self waittill("death");
  var_0.count--;
  var_0 notify("waittill_dead guy died");
}

function waittill_dead_or_dying_thread(var_0) {
  scripts\engine\utility::waittill_either("death", "long_death");
  var_0.count--;
  var_0 notify("waittill_dead_guy_dead_or_dying");
}

function waittill_dead_timeout(var_0) {
  wait var_0;
  self notify("thread_timed_out");
}