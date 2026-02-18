/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_73ad7687b437e468.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_48e04a393ec6d855;
#using script_4d748e58ce25b60c;
#using script_50fca1a24ae351;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_746267f0669c40ae;
#using script_74a56359b7d02ab6;
#using script_77357b2d180aa2b8;
#using script_dc59353021baee1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_5849a337;

function init() {}

function function_2d3e0ee4() {
  foreach(door in level.doa.var_a8a563fc) {
    if(isDefined(door.model)) {
      door.model delete();
    }
  }

  level.doa.var_a8a563fc = [];
}

function function_fabbde0d() {
  foreach(door in level.doa.var_a8a563fc) {
    var_c9d9522c = isDefined(door.model) ? door.model : door.script_string;
    assert(isDefined(var_c9d9522c));
    model = namespace_f63bdb08::function_2a1e5c1f(door.origin, door.angles, var_c9d9522c, undefined, 1, 2, door.script_parameters);

    if(isDefined(door.model)) {
      door.model delete();
    }

    door.model = model;
  }
}