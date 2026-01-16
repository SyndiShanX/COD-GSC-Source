/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_net.gsc
***********************************************/

#include scripts\core_common\struct;
#include scripts\core_common\util_shared;

#namespace zm_net;

network_choke_init(id, max) {
  if(!isDefined(level.zombie_network_choke_ids_max)) {
    level.zombie_network_choke_ids_max = [];
    level.zombie_network_choke_ids_count = [];
  }

  level.zombie_network_choke_ids_max[id] = max;
  level.zombie_network_choke_ids_count[id] = 0;
  level thread network_choke_thread(id);
}

network_choke_thread(id) {
  while(true) {
    util::wait_network_frame();
    util::wait_network_frame();
    level.zombie_network_choke_ids_count[id] = 0;
  }
}

network_choke_safe(id) {
  return level.zombie_network_choke_ids_count[id] < level.zombie_network_choke_ids_max[id];
}

network_choke_action(id, choke_action, arg1, arg2, arg3) {
  assert(isDefined(level.zombie_network_choke_ids_max[id]), "<dev string:x38>" + id + "<dev string:x4a>");

  while(!network_choke_safe(id)) {
    waitframe(1);
  }

  level.zombie_network_choke_ids_count[id]++;

  if(!isDefined(arg1)) {
    return [[choke_action]]();
  }

  if(!isDefined(arg2)) {
    return [[choke_action]](arg1);
  }

  if(!isDefined(arg3)) {
    return [[choke_action]](arg1, arg2);
  }

  return [[choke_action]](arg1, arg2, arg3);
}

network_entity_valid(entity) {
  if(!isDefined(entity)) {
    return false;
  }

  return true;
}

network_safe_init(id, max) {
  if(!isDefined(level.zombie_network_choke_ids_max) || !isDefined(level.zombie_network_choke_ids_max[id])) {
    network_choke_init(id, max);
  }

  assert(max == level.zombie_network_choke_ids_max[id]);
}

_network_safe_spawn(classname, origin) {
  return spawn(classname, origin);
}

network_safe_spawn(id, max, classname, origin) {
  network_safe_init(id, max);
  return network_choke_action(id, &_network_safe_spawn, classname, origin);
}

_network_safe_play_fx_on_tag(fx, entity, tag) {
  if(network_entity_valid(entity)) {
    playFXOnTag(fx, entity, tag);
  }
}

network_safe_play_fx_on_tag(id, max, fx, entity, tag) {
  network_safe_init(id, max);
  network_choke_action(id, &_network_safe_play_fx_on_tag, fx, entity, tag);
}