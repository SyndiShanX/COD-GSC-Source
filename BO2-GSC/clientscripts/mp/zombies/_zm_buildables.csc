/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_zm_buildables.csc
*********************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\zombies\_zm_utility;

init() {
  level.buildable_piece_count = 0;

  if(isDefined(level.init_buildables))
    [[level.init_buildables]]();
}

add_zombie_buildable(buildable_name) {
  if(!isDefined(level.zombie_include_buildables))
    level.zombie_include_buildables = [];

  if(isDefined(level.zombie_include_buildables) && !isDefined(level.zombie_include_buildables[buildable_name])) {
    return;
  }
  buildable_name = level.zombie_include_buildables[buildable_name];

  if(!isDefined(level.zombie_buildables))
    level.zombie_buildables = [];

  level.zombie_buildables[buildable_name] = buildable_name;

  if(!level.createfx_enabled) {
    if(level.zombie_buildables.size == 1)
      register_clientfields();
  }
}

register_clientfields() {
  if(isDefined(level.buildable_slot_count)) {
    for(i = 0; i < level.buildable_slot_count; i++) {
      bits = getminbitcountfornum(level.buildable_piece_counts[i]);
      registerclientfield("toplayer", level.buildable_clientfields[i], 12000, bits, "int", undefined, 0, 1);
    }
  } else {
    bits = getminbitcountfornum(level.buildable_piece_count);
    registerclientfield("toplayer", "buildable", 1, bits, "int", undefined, 0, 1);
  }
}

set_clientfield_buildables_code_callbacks() {
  wait 0.1;

  if(!level.createfx_enabled) {
    if(level.zombie_buildables.size > 0) {
      if(isDefined(level.buildable_slot_count)) {
        for(i = 0; i < level.buildable_slot_count; i++)
          setupclientfieldcodecallbacks("toplayer", 1, level.buildable_clientfields[i]);
      } else
        setupclientfieldcodecallbacks("toplayer", 1, "buildable");
    }
  }
}

include_zombie_buildable(buiildable_name) {
  if(!isDefined(level.zombie_include_buildables))
    level.zombie_include_buildables = [];

  level.zombie_include_buildables[buiildable_name] = buiildable_name;
}