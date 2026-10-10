/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1e172edbfbe283b6.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_a9daf88199005717;

function function_53ccaaf3e988ccea() {
  if(!isDefined(level.var_8ce7e9037bc030ec)) {
    var_b86833d977b0e7a7 = getStructArray("poi_bg", "targetname");
    level.var_8ce7e9037bc030ec = [];

    for(i = 0; i < var_b86833d977b0e7a7.size; i++) {
      poi = spawnStruct();
      poi.poi_name = "poi_bg_" + i;
      poi.poi_priority = "background";
      poi.poi_timeout = -1;
      poi.origin = var_b86833d977b0e7a7[i].origin;
      poi.var_317942a59dbeaa5e = 2000;
      poi.script_radius = var_b86833d977b0e7a7[i].script_radius;
      level.var_8ce7e9037bc030ec = array_add(level.var_8ce7e9037bc030ec, poi);
    }
  }

  if(!isDefined(level.var_8a5d122c7f55ca41)) {
    level.var_8a5d122c7f55ca41 = [];
  }
}

function function_c17ad8c0eb460cac(ai, key) {
  num = ai getentitynumber();

  if(!isDefined(num)) {
    return;
  }

  self.poi_keys[num] = key;
}

function function_9a329f00efd39848(ai) {
  num = ai getentitynumber();
  return self.poi_keys[num];
}

function function_9e8aba535d998963() {
  foreach(poi in level.var_8ce7e9037bc030ec) {
    key = undefined;

    if(isent(poi)) {
      key = self function_d5ae7b0d90d15b0f(poi.poi_priority, poi, poi.script_radius, poi.poi_timeout, poi.poi_name, poi.var_317942a59dbeaa5e);
    } else {
      key = self function_d5ae7b0d90d15b0f(poi.poi_priority, poi.origin, poi.script_radius, poi.poi_timeout, poi.poi_name, poi.var_317942a59dbeaa5e);
    }

    poi function_c17ad8c0eb460cac(self, key);
  }

  thread function_278f3d74c2be06e1();

  if(!array_contains(level.var_8a5d122c7f55ca41, self)) {
    level.var_8a5d122c7f55ca41 = array_add(level.var_8a5d122c7f55ca41, self);
  }
}

function function_525424365b615e2c(name, ent) {
  foreach(poi in level.var_8ce7e9037bc030ec) {
    if(isDefined(poi.poi_name) && poi.poi_name == name) {
      if(isDefined(ent) && poi == ent) {
        assertmsg("Tried to create PLA POI with a duplicate name: '" + name + "' on an ent (" + ent.name + ") that already has that POI registered to it");
        return;
      }

      assertmsg("Tried to create PLA POI with duplicate name: " + name);
      return;
    }

    if(isDefined(ent) && poi == ent) {
      assertmsg("Tried to create more than one PLA POI on ent: " + ent.name);
    }
  }
}

function function_278f3d74c2be06e1() {
  entnum = self getentitynumber();
  waittill_any_3("death", "deleted", "poi_pla_death_watcher_" + entnum);
  level.var_8a5d122c7f55ca41 = array_remove(level.var_8a5d122c7f55ca41, self);

  foreach(poi in level.var_8ce7e9037bc030ec) {
    poi.poi_keys = array_remove_key(poi.poi_keys, entnum);
  }
}

function function_4a231fe3dd7a4700(name, priority, origin, radius, timeout, var_b34a3b7b7caba551) {
  poi = spawnStruct();

  if(isDefined(name)) {
    function_525424365b615e2c(name, undefined);

    poi.poi_name = name;
  }

  poi.poi_priority = priority;
  poi.origin = origin;
  poi.script_radius = radius;

  if(timeout < 0) {
    poi.poi_timeout = -1;
  } else {
    poi.poi_timeout = gettime() + timeout * 1000;
  }

  poi.var_317942a59dbeaa5e = var_b34a3b7b7caba551 * 1000;
  level.var_8ce7e9037bc030ec = array_add(level.var_8ce7e9037bc030ec, poi);

  foreach(ai in level.var_8a5d122c7f55ca41) {
    key = ai function_d5ae7b0d90d15b0f(priority, origin, radius, timeout, name, var_b34a3b7b7caba551);
    poi function_c17ad8c0eb460cac(ai, key);
  }

  return poi;
}

function function_1c677895c2060ff6(name, priority, ent, radius, timeout, var_b34a3b7b7caba551) {
  poi = ent;

  if(isDefined(name)) {
    function_525424365b615e2c(name, undefined);

    poi.poi_name = name;
  }

  poi.poi_name = name;
  poi.poi_priority = priority;
  poi.script_radius = radius;

  if(timeout < 0) {
    poi.poi_timeout = -1;
  } else {
    poi.poi_timeout = gettime() + timeout * 1000;
  }

  poi.var_317942a59dbeaa5e = var_b34a3b7b7caba551 * 1000;
  level.var_8ce7e9037bc030ec = array_add(level.var_8ce7e9037bc030ec, poi);

  foreach(ai in level.var_8a5d122c7f55ca41) {
    key = ai function_d5ae7b0d90d15b0f(priority, ent, radius, timeout, name, var_b34a3b7b7caba551);
    poi function_c17ad8c0eb460cac(ai, key);
  }

  return poi;
}

function function_193778cf5fe2f23a(name, ent) {
  foreach(poi in level.var_8ce7e9037bc030ec) {
    if(isDefined(poi.poi_name) && name == poi.poi_name) {
      if(isDefined(ent)) {
        if(poi == ent) {
          return poi;
        }

        continue;
      }

      return poi;
    }
  }

  return undefined;
}

function function_6984185a661c2887(name, ent) {
  poi = function_193778cf5fe2f23a(name, ent);

  if(isDefined(poi)) {
    function_aa83e21136ea8249(poi);
  }
}

function function_aa83e21136ea8249(poi) {
  foreach(ai in level.var_8a5d122c7f55ca41) {
    key = poi function_9a329f00efd39848(ai);

    if(isDefined(key)) {
      ai function_525a16a3cdba1382(key);
    }
  }

  level.var_8ce7e9037bc030ec = array_remove(level.var_8ce7e9037bc030ec, poi);
}

function function_ef6746bc541b0() {
  foreach(poi in level.var_8ce7e9037bc030ec) {
    key = poi function_9a329f00efd39848(self);

    if(isDefined(key)) {
      self function_525a16a3cdba1382(key);
    }
  }

  self notify("poi_pla_death_watcher_" + self getentitynumber());
}