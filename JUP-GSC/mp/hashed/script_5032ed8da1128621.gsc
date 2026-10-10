/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5032ed8da1128621.gsc
*************************************************/

#using scripts\common\callbacks;
#namespace namespace_7c5bb630aad381e;

function function_200bd098377a8674(group_id, var_449da622a6fe97bd, var_9137b8627fdf4cc8) {
  if(!isDefined(level.var_c51387d07af317b7)) {
    level.var_c51387d07af317b7 = [];
  }

  assertex(!isDefined(level.var_c51387d07af317b7[group_id]), "<dev string:x1c>" + group_id + "<dev string:x3a>");
  group = spawnStruct();
  group.scriptables = [];
  group.start_id = 0;
  group.current_id = 0;
  group.group_id = group_id;
  group.max_count = var_449da622a6fe97bd;
  group.var_35b0b2e8bee60af4 = var_9137b8627fdf4cc8;
  assertex(group.var_35b0b2e8bee60af4 < group.max_count, "<dev string:x1c>" + group_id + "<dev string:x5c>");
  level.var_c51387d07af317b7[group_id] = group;
}

function function_f8ecd6e02634e682(group_id) {
  if(isDefined(level.var_c51387d07af317b7) && isDefined(level.var_c51387d07af317b7[group_id])) {
    group = level.var_c51387d07af317b7[group_id];
    return group.scriptables;
  }

  return undefined;
}

function function_476b3beecd82dcca(group_id, instance) {
  if(!isDefined(level.var_c51387d07af317b7) || !isDefined(level.var_c51387d07af317b7[group_id])) {
    assertmsg("<dev string:xb0>" + group_id + "<dev string:xd8>");
    return;
  }

  group = level.var_c51387d07af317b7[group_id];
  function_3e036cf2bd9bf933(group);
  instance.var_4a0145502132790a = group.current_id;
  group.scriptables[instance.var_4a0145502132790a] = instance;
  group.current_id++;
  instance callback::callback(#"hash_f24c94436ace19e3", group);
}

function function_879ccb6a53e634f5(group_id, instance) {
  if(!isDefined(level.var_c51387d07af317b7[group_id])) {
    assertmsg("<dev string:xb0>" + group_id + "<dev string:xd8>");
    return;
  }

  group = level.var_c51387d07af317b7[group_id];
  instance callback::callback(#"hash_8e9040f5886c6379", group);
  group.scriptables[instance.var_4a0145502132790a] = undefined;
  instance.var_4a0145502132790a = undefined;
}

function private function_3e036cf2bd9bf933(group) {
  if(group.scriptables.size < group.max_count) {
    return;
  }

  var_d89dfb4bd556862a = 0;

  for(id = group.start_id; id < group.current_id; id++) {
    if(var_d89dfb4bd556862a == group.var_35b0b2e8bee60af4) {
      break;
    }

    instance = group.scriptables[id];

    if(isDefined(instance)) {
      instance callback::callback(#"hash_c6a6fbc56f71a3b1", group);

      if(isent(instance)) {
        instance delete();
      } else {
        instance notify("death");
        instance freescriptable();
      }

      var_d89dfb4bd556862a++;
    }

    group.scriptables[id] = undefined;
    group.start_id++;
  }
}