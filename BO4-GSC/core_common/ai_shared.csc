/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai_shared.csc
***********************************************/

#include scripts\core_common\util_shared;

#namespace ai_shared;

autoexec main() {
  level._customactorcbfunc = &ai::spawned_callback;
}

#namespace ai;

add_ai_spawn_function(func_spawn, ...) {
  if(!isDefined(level.var_71b23817)) {
    level.var_71b23817 = [];
  } else if(!isarray(level.var_71b23817)) {
    level.var_71b23817 = array(level.var_71b23817);
  }

  var_e45a16f3 = {
    #func: func_spawn, 
    #params: vararg
  };

  if(!isDefined(level.var_71b23817)) {
    level.var_71b23817 = [];
  } else if(!isarray(level.var_71b23817)) {
    level.var_71b23817 = array(level.var_71b23817);
  }

  level.var_71b23817[level.var_71b23817.size] = var_e45a16f3;
}

function_932006d1(func_spawn) {
  if(!isDefined(level.var_71b23817)) {
    return;
  }

  foreach(var_e45a16f3 in level.var_71b23817) {
    if(var_e45a16f3.func == func_spawn) {
      arrayremovevalue(level.var_71b23817, var_e45a16f3);
      return;
    }
  }
}

add_archetype_spawn_function(str_archetype, func_spawn, ...) {
  if(!isDefined(level.var_c18b23c1)) {
    level.var_c18b23c1 = [];
  } else if(!isarray(level.var_c18b23c1)) {
    level.var_c18b23c1 = array(level.var_c18b23c1);
  }

  if(!isDefined(level.var_c18b23c1[str_archetype])) {
    level.var_c18b23c1[str_archetype] = [];
  } else if(!isarray(level.var_c18b23c1[str_archetype])) {
    level.var_c18b23c1[str_archetype] = array(level.var_c18b23c1[str_archetype]);
  }

  var_6d69c0bf = {
    #func: func_spawn, 
    #params: vararg
  };

  if(!isDefined(level.var_c18b23c1[str_archetype])) {
    level.var_c18b23c1[str_archetype] = [];
  } else if(!isarray(level.var_c18b23c1[str_archetype])) {
    level.var_c18b23c1[str_archetype] = array(level.var_c18b23c1[str_archetype]);
  }

  level.var_c18b23c1[str_archetype][level.var_c18b23c1[str_archetype].size] = var_6d69c0bf;
}

spawned_callback(localclientnum) {
  if(isDefined(level.var_71b23817)) {
    foreach(var_e45a16f3 in level.var_71b23817) {
      a_args = arraycombine(array(localclientnum), var_e45a16f3.params, 1, 0);
      util::single_func_argarray(self, var_e45a16f3.func, a_args);
    }
  }

  if(isDefined(level.var_c18b23c1) && isDefined(level.var_c18b23c1[self.archetype])) {
    foreach(var_6d69c0bf in level.var_c18b23c1[self.archetype]) {
      a_args = arraycombine(array(localclientnum), var_6d69c0bf.params, 1, 0);
      util::single_func_argarray(self, var_6d69c0bf.func, a_args);
    }
  }
}

shouldregisterclientfieldforarchetype(archetype) {
  if(isDefined(level.clientfieldaicheck) && level.clientfieldaicheck && !isarchetypeloaded(archetype)) {
    return false;
  }

  return true;
}

function_9139c839() {
  if(!isDefined(self.var_76167463)) {
    if(isDefined(self.aisettingsbundle)) {
      settingsbundle = self.aisettingsbundle;
    } else if(isDefined(self.scriptbundlesettings)) {
      settingsbundle = getscriptbundle(self.scriptbundlesettings).aisettingsbundle;
    }

    if(!isDefined(settingsbundle)) {
      return undefined;
    }

    self.var_76167463 = settingsbundle;

    if(!isDefined(level.var_e3a467cf)) {
      level.var_e3a467cf = [];
    }

    if(!isDefined(level.var_e3a467cf[self.var_76167463])) {
      level.var_e3a467cf[self.var_76167463] = getscriptbundle(self.var_76167463);
    }
  }

  return level.var_e3a467cf[self.var_76167463];
}

function_71919555(var_45302432, fieldname, archetype) {
  if(!isDefined(level.var_e3a467cf)) {
    level.var_e3a467cf = [];
  }

  if(!isDefined(level.var_e3a467cf[var_45302432])) {
    level.var_e3a467cf[var_45302432] = getscriptbundle(var_45302432);
  }

  if(isDefined(level.var_e3a467cf[var_45302432])) {
    if(isDefined(archetype)) {
      return level.var_e3a467cf[var_45302432].(archetype + "_" + fieldname);
    }

    return level.var_e3a467cf[var_45302432].(fieldname);
  }

  return undefined;
}