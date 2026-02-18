/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\territory.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#namespace territory;

function private autoexec __init__system__() {
  system::register(#"territory", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("world", "territory_id", 1, 4, "int", &function_59941838, 1, 0);
  level.territory = {
    #name: ""};
  territories = struct::get_array("territory", "variantName");

  for(index = 1; index <= territories.size; index++) {
    territories[index - 1].id = index;
  }
}

function private function_59941838(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    level.territory = {
      #name: ""};
    territories = struct::get_array("territory", "variantName");

    foreach(territory in territories) {
      if(territory.id == bwastimejump) {
        level.territory = territory;
        level.territory.name = isDefined(level.territory.target) ? level.territory.target : isDefined(level.territory.targetname) ? level.territory.targetname : "";

        if(isDefined(territory.target)) {
          triggers = getEntArray(fieldname, territory.target, "targetname");

          if(!isDefined(territory.circle)) {
            structs = struct::get_array(territory.target, "targetname");

            foreach(struct in structs) {
              if(isDefined(struct.variantname) && struct.variantname == "territory_circle") {
                territory.circle = function_36a1028e(fieldname, struct.origin, struct.radius);
                break;
              }
            }
          }
        }

        break;
      }
    }

    callback::callback(#"territory", fieldname, {
      #newval: bwastimejump
    });
  }
}

function function_1deaf019(name, key, territory = level.territory) {
  var_3e8b00df = [];
  entities = getEntArray(0, name, key);

  foreach(entity in entities) {
    if(!is_valid(entity, territory)) {
      continue;
    }

    if(is_inside(entity.origin, undefined, territory)) {
      var_3e8b00df[var_3e8b00df.size] = entity;
    }
  }

  return var_3e8b00df;
}

function function_1f583d2e(name, key, territory = level.territory) {
  entities = getEntArray(0, name, key);
  return function_39dd704c(entities, territory);
}

function private function_36a1028e(localclientnum, origin, radius) {
  circle = spawn(localclientnum, origin, "script_model");
  circle = spawn(localclientnum, origin, "script_model");
  circle setModel("p9_territory_cylinder");
  circle playrenderoverridebundle(#"hash_43d22d2a5ec27460");
  modelscale = radius / 150000;
  circle function_78233d29(#"hash_43d22d2a5ec27460", "", "Scale", modelscale);
  circle setcompassicon("minimap_collapse_ring");
  circle function_a5edb367(#"death_ring");
  circle function_811196d1(0);
  circle function_95bc465d(1);
  circle function_5e00861(0, 1);
  circle function_60212003(1);
  compassscale = radius * 2;
  circle function_5e00861(compassscale, 1);
}