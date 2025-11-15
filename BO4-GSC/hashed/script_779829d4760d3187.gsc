/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_779829d4760d3187.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_office_special_rounds;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_unitrigger;

#namespace namespace_ba52581a;

autoexec __init__system__() {
  system::register(#"hash_14819f0ef5a24379", &__init__, undefined, undefined);
}

__init__() {
  init_flags();
  init_clientfields();
  init_quest();
}

init_flags() {
  level flag::init(#"hash_67df8b68575ba704");
  level flag::init(#"hash_10d5bcbc42acc9b");
  level flag::init(#"hash_1fa9f2f17d2cb5f9");
  level flag::init(#"hash_36e8f27bbd8b02d5");
  level flag::init(#"hash_1c296f8c578e2659");
}

init_clientfields() {
  clientfield::register("toplayer", "" + #"hash_7eefa4acee4c1d55", 1, 1, "counter");
}

init_quest() {
  level.var_774c21fa = struct::get(#"hash_117cb1e7c329e0ad");
  level.mcnamara = spawn("script_model", level.var_774c21fa.origin);
  level.var_33d3e84a = 0;
  zm_sq::register(#"hash_5a9580406af2d773", #"step_1", #"hash_5cbd9c892dca9e05", &function_4b16859a, &function_53935f3d);
  zm_sq::register(#"hash_5a9580406af2d773", #"step_2", #"hash_5cbd99892dca98ec", &function_9235fc9a, &function_fe3de565);
  zm_sq::register(#"hash_5a9580406af2d773", #"step_3", #"hash_5cbd9a892dca9a9f", &function_2e57632b, &function_3409e90e);
  zm_sq::register(#"hash_5a9580406af2d773", #"step_4", #"hash_5cbd97892dca9586", &function_7991d694, &function_c2bd8b3d);
  zm_sq::register(#"hash_5a9580406af2d773", #"step_5", #"hash_5cbd98892dca9739", &function_8ca22055, &function_d8b688e7);
  zm_sq::start(#"hash_5a9580406af2d773");
}

function_4b16859a(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level.var_774c21fa zm_unitrigger::create("", 64, &function_5ce4f28f);
    level flag::wait_till(#"hash_67df8b68575ba704");
  }
}

function_53935f3d(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
    level.var_33d3e84a = 1;
    level flag::set(#"hash_67df8b68575ba704");
    return;
  }

  zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
  level.var_33d3e84a = 1;
  playsoundatposition(#"hash_61901dee5b81dba2", level.var_774c21fa.origin);
  level.var_38ea4233 clientfield::increment_to_player("" + #"hash_7eefa4acee4c1d55", 1);
  wait 3;
  zm_hms_util::function_e308175e(#"hash_40c5232d4f3e85b", level.mcnamara.origin);
}

function_9235fc9a(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level.var_774c21fa zm_unitrigger::create("", 64, &function_5ce4f28f);
    level flag::wait_till(#"hash_10d5bcbc42acc9b");
  }
}

function_fe3de565(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
    level.var_33d3e84a = 2;
    level flag::set(#"hash_10d5bcbc42acc9b");
    return;
  }

  zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
  level.var_33d3e84a = 2;
  playsoundatposition(#"hash_61901dee5b81dba2", level.var_774c21fa.origin);
  level.var_38ea4233 clientfield::increment_to_player("" + #"hash_7eefa4acee4c1d55", 1);
  wait 3;
  zm_hms_util::function_e308175e(#"hash_338550de989ad1a7", level.mcnamara.origin);
}

function_2e57632b(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level.var_774c21fa zm_unitrigger::create("", 64, &function_5ce4f28f);
    level flag::wait_till(#"hash_1fa9f2f17d2cb5f9");
  }
}

function_3409e90e(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
    level.var_33d3e84a = 3;
    level flag::set(#"hash_1fa9f2f17d2cb5f9");
    return;
  }

  zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
  level.var_33d3e84a = 3;
  playsoundatposition(#"hash_61901dee5b81dba2", level.var_774c21fa.origin);
  level.var_38ea4233 clientfield::increment_to_player("" + #"hash_7eefa4acee4c1d55", 1);
  wait 3;
  zm_hms_util::function_e308175e(#"hash_182892c4bb99b96a", level.mcnamara.origin);
}

function_7991d694(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level.var_774c21fa zm_unitrigger::create("", 64, &function_5ce4f28f);
    level flag::wait_till(#"hash_36e8f27bbd8b02d5");
  }
}

function_c2bd8b3d(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
    level.var_33d3e84a = 4;
    level flag::set(#"hash_36e8f27bbd8b02d5");
    return;
  }

  zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
  level.var_33d3e84a = 4;
  playsoundatposition(#"hash_61901dee5b81dba2", level.var_774c21fa.origin);
  level.var_38ea4233 clientfield::increment_to_player("" + #"hash_7eefa4acee4c1d55", 1);
  wait 3;
  zm_hms_util::function_e308175e(#"hash_1d3964f5cb0069af", level.mcnamara.origin);
}

function_8ca22055(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level.var_774c21fa zm_unitrigger::create("", 64, &function_5ce4f28f);
    level flag::wait_till(#"hash_1c296f8c578e2659");
  }
}

function_d8b688e7(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
    level.var_33d3e84a = 5;
    level flag::set(#"hash_1c296f8c578e2659");
  } else {
    zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
    level.var_33d3e84a = 5;
    playsoundatposition(#"hash_61901dee5b81dba2", level.var_774c21fa.origin);
    level.var_38ea4233 clientfield::increment_to_player("" + #"hash_7eefa4acee4c1d55", 1);
    wait 3;
    zm_hms_util::function_e308175e(#"hash_e51948d3d12b229", level.mcnamara.origin);
  }

  level thread zm_office_special_rounds::function_6b3512d();
}

function_5ce4f28f() {
  switch (level.var_33d3e84a) {
    case 0:
      waitresult = self waittill(#"trigger");
      level.var_38ea4233 = waitresult.activator;
      level flag::set(#"hash_67df8b68575ba704");
    case 1:
      waitresult = self waittill(#"trigger");
      level.var_38ea4233 = waitresult.activator;
      level flag::set(#"hash_10d5bcbc42acc9b");
    case 2:
      waitresult = self waittill(#"trigger");
      level.var_38ea4233 = waitresult.activator;
      level flag::set(#"hash_1fa9f2f17d2cb5f9");
    case 3:
      waitresult = self waittill(#"trigger");
      level.var_38ea4233 = waitresult.activator;
      level flag::set(#"hash_36e8f27bbd8b02d5");
    case 4:
      waitresult = self waittill(#"trigger");
      level.var_38ea4233 = waitresult.activator;
      level flag::set(#"hash_1c296f8c578e2659");
      break;
  }
}