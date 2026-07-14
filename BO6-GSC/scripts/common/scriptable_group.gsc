/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\scriptable_group.gsc
***********************************************/

#using scripts\common\callbacks;
#namespace scriptable_group;

function function_5681bb5bfd57a83d(group_id, var_e29bfc4d29fb7e58, var_9a11cd395d18beb5) {
  if(!isDefined(level.scriptable_groups)) {
    level.scriptable_groups = [];
  }

  assert(!isDefined(level.scriptable_groups[group_id]), "<dev string:x24>" + group_id + "<dev string:x42>");
  group = spawnStruct();
  group.scriptables = [];
  group.start_id = 0;
  group.current_id = 0;
  group.group_id = group_id;
  group.max_count = var_e29bfc4d29fb7e58;
  group.var_4463b026393b1409 = var_9a11cd395d18beb5;
  assert(group.var_4463b026393b1409 < group.max_count, "<dev string:x24>" + group_id + "<dev string:x64>");
  level.scriptable_groups[group_id] = group;
}

function function_143f20f4d17c9e1b(group_id) {
  if(isDefined(level.scriptable_groups) && isDefined(level.scriptable_groups[group_id])) {
    group = level.scriptable_groups[group_id];
    return group.scriptables;
  }

  return undefined;
}

function function_42b4ed7bf32e34bf(group_id, instance) {
  if(!(isDefined(level.scriptable_groups) && isDefined(level.scriptable_groups[group_id]))) {
    assertmsg("<dev string:xb8>" + group_id + "<dev string:xe0>");
    return;
  }

  group = level.scriptable_groups[group_id];
  function_93578f48888ceede(group);
  instance.var_caf29f3bb92117f3 = group.current_id;
  group.scriptables[instance.var_caf29f3bb92117f3] = instance;
  group.current_id++;
  instance callback::callback(#"scriptable_group_addition", group);
}

function function_8fff7e7c59c492a0(group_id, instance) {
  if(!isDefined(level.scriptable_groups[group_id])) {
    assertmsg("<dev string:xb8>" + group_id + "<dev string:xe0>");
    return;
  }

  group = level.scriptable_groups[group_id];
  instance callback::callback(#"scriptable_group_removal", group);
  group.scriptables[instance.var_caf29f3bb92117f3] = undefined;
  instance.var_caf29f3bb92117f3 = undefined;
}

function private function_93578f48888ceede(group) {
  if(group.scriptables.size < group.max_count) {
    return;
  }

  var_c7d8e95e76431e37 = 0;

  for(id = group.start_id; id < group.current_id; id++) {
    if(var_c7d8e95e76431e37 == group.var_4463b026393b1409) {
      break;
    }

    instance = group.scriptables[id];

    if(isDefined(instance) && !istrue(instance.critical)) {
      instance callback::callback(#"hash_c6a6fbc56f71a3b1", group);

      if(isent(instance)) {
        instance delete();
      } else {
        instance notify("\x1e\xfd\xd1\xa2\a");
        instance freescriptable();
      }

      var_c7d8e95e76431e37++;
    }

    group.scriptables[id] = undefined;
    group.start_id++;
  }
}