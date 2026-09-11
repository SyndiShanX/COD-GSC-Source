/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ai_encounters_util.gsc
**********************************************************/

function get_ai_team() {
  if(isDefined(self.encounter.info.team)) {
    return self.encounter.info.team;
  }

  var0 = [];

  foreach(var2 in level.teamnamelist) {
    var0 = 0;
  }

  foreach(var5 in level.players) {
    var2 = var5.pers["team"];

    if(!isDefined(var2) || var2 == "spectator") {
      continue;
    }

    var0++;
  }

  foreach(var2, var8 in var0) {
    if(var8 == 0) {
      self.encounter.info.team = var2;
      break;
    }
  }

  if(!isDefined(self.encounter.info.team)) {
    self.encounter.info.team = scripts\engine\utility::random(level.teamnamelist);
  }

  return self.encounter.info.team;
}

function get_targets() {
  var0 = [];

  if(isDefined(self.target)) {
    var1 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(var3 in var1) {
      var0 = var3;
    }

    var5 = getEntArray(self.target, "targetname");

    foreach(var7 in var5) {
      var0 = var7;
    }

    var9 = getnodearray(self.target, "targetname");

    foreach(var11 in var9) {
      var0 = var11;
    }
  }

  return var0;
}

function getvartype(var0) {
  if(!isDefined(var0)) {
    return "undefined";
  } else if(isbuiltinfunction(var0)) {
    return "function";
  } else if(isbuiltinmethod(var0)) {
    return "builtin function";
  } else if(isanimation(var0)) {
    return "builtin method";
  } else if(dospawnaitype(var0)) {
    return "animation";
  } else if(isarray(var0)) {
    return "array";
  } else if(isstruct(var0)) {
    var1 = "struct";
  } else if(isvector(var1)) {
    var1 = "vector";
  } else if(isent(var1)) {
    var1 = "entity";
  } else if(isnode(var1)) {
    var1 = "node";
  } else if(isint(var1)) {
    var1 = "int";
  } else if(isfloat(var1)) {
    var1 = "float";
  } else if(isstring(var1)) {
    var1 = "string";
  } else if(isistring(var1)) {
    var1 = "istring";
  } else {
    var1 = "unknown";
  }

  return var1;
}

function vartostring(var0) {
  var1 = getvartype(var0);

  switch (var1) {
    case "array":
      return _arraytostring(var0);
    case "vector":
      return ("(" + var0[0] + "," + var0[1] + "," + var0[2] + ")");
    case "float":
    case "int":
      return ("" + var0);
    case "string":
      return var0;
    case "entity":
      return ("$e" + var0 getentitynumber());
    default:
      return ("<" + var1 + ">");
  }
}

function _arraytostring(var0) {
  var1 = "[ ";
  var2 = 1;

  foreach(var4 in var0) {
    if(!var2) {
      var1 += ",";
    } else {
      var2 = 0;
    }

    var1 += vartostring(var4);
  }

  var1 += " ]";
  return var1;
}

function encounterremovenavobstacle(var0) {
  destroynavobstacle(var0);
  self notify("nav_obstacle_destroy_" + var0);
}

function encounterremovenavobstacleonencounterend(var0) {
  self endon("nav_obstacle_destroy_" + var0);
  self waittill("encounter_end");
  encounterremovenavobstacle(var0);
}

function encounterremovenavobstacledelay(var0, var1) {
  self endon("nav_obstacle_destroy_" + var0);
  self endon("encounter_end");
  wait var1;
  encounterremovenavobstacle(var0);
}

function encounterdeleteentonend(var0) {
  var0 endon("death");
  self waittill("encounter_end");
  var0 delete();
}

function disablescriptableplayeruseall(var0) {
  foreach(var2 in level.players) {
    var0 disablescriptableplayeruse(var2);
  }
}

function enablescriptableplayeruseall(var0) {
  foreach(var2 in level.players) {
    var0 enablescriptableplayeruse(var2);
  }
}

function waittill_dead(var0, var1, var2) {
  var10 = spawnStruct();

  if(isDefined(var2)) {
    var10 endon("thread_timed_out");
    thread waittill_dead_timeout(var10);
  }

  var10.count = var0.size;

  if(isDefined(var1) && var1 < var10.count) {
    var10.count = var1;
  }

  scripts\engine\utility::array_thread(var0, &waittill_dead_thread, var10);

  while(var10.count > 0) {
    var10 waittill("waittill_dead guy died");
  }
}

function waittill_dead_or_dying(var0, var1, var2) {
  var3 = [];

  foreach(var5 in var0) {
    if(isalive(var5) && !var5.ignoreforfixednodesafecheck) {
      var3 = var5;
    }
  }

  var0 = var3;
  var7 = spawnStruct();

  if(isDefined(var2)) {
    var7 endon("thread_timed_out");
    thread waittill_dead_timeout(var7);
  }

  var7.count = var0.size;

  if(isDefined(var1) && var1 < var7.count) {
    var7.count = var1;
  }

  scripts\engine\utility::array_thread(var0, &waittill_dead_or_dying_thread, var7);

  while(var7.count > 0) {
    var7 waittill("waittill_dead_guy_dead_or_dying");
  }
}

function waittill_notetrack_or_damage(var0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var0);
}

function get_living_ai(var0, var1) {
  var2 = get_living_ai_array(var0, var1);

  if(var2.size > 1) {
    return undefined;
  }

  return var2[0];
}

function get_living_ai_array(var0, var1) {
  var2 = getaispeciesarray("all", "all");
  var3 = [];

  foreach(var5 in var2) {
    if(!isalive(var5)) {
      continue;
    }

    switch (var1) {
      case "targetname":
        if(isDefined(var5.targetname) && var5.targetname == var0) {
          var3 = var5;
        }

        break;
      case "script_noteworthy":
        if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == var0) {
          var3 = var5;
        }

        break;
      case "animname":
        if(isDefined(var5.animname) && var5.animname == var0) {
          var3 = var5;
        }

        break;
    }
  }

  return var3;
}

function waittill_dead_thread(var0) {
  self waittill("death");
  var0.count--;
  var0 notify("waittill_dead guy died");
}

function waittill_dead_or_dying_thread(var0) {
  scripts\engine\utility::waittill_either("death", "long_death");
  var0.count--;
  var0 notify("waittill_dead_guy_dead_or_dying");
}

function waittill_dead_timeout(var0) {
  wait var0;
  self notify("thread_timed_out");
}