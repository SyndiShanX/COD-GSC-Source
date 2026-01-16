/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_lockdown_util.gsc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\systems\debug;
#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_lockdown_util;

class class_6fde4e6 {
  var claimed;
  var owner;
  var var_4f0ea1b5;
  var var_6f08706b;

  constructor() {
    claimed = 0;
    var_4f0ea1b5 = 0;
    owner = undefined;
    var_6f08706b = undefined;
  }

}

class class_b599a4bc {
  var entity;
  var var_f6d13e1b;

  constructor() {
    var_f6d13e1b = [];
    entity = undefined;
  }

}

autoexec __init__system__() {
  system::register(#"zm_lockdown_util", &__init__, undefined, undefined);
}

__init__() {
  level thread function_b595044c();
  level thread function_ccf7ac87();
  level.var_492142a5 = [#"lockdown_stub_type_boards":&function_8850974b, #"lockdown_stub_type_crafting_tables":&function_d0e1d38c, #"lockdown_stub_type_magic_box":&function_e6761711, #"lockdown_stub_type_pap":&function_165e2bd6, #"lockdown_stub_type_perks":&function_db989a2a, #"lockdown_stub_type_traps":&function_d2ce5ac1, #"lockdown_stub_type_wallbuys":&function_9c7d5271];
  level.var_85c076ab = [];

  level function_946bb116();

}

private function_b595044c() {
  level endon(#"end_game");

  if(!isDefined(level.var_f17bdf53)) {
    level.var_f17bdf53 = [];
  }

  if(!isDefined(level.pap_lockdown_stubs)) {
    level.pap_lockdown_stubs = [];
  }

  if(!isDefined(level.var_9235b607)) {
    level.var_9235b607 = [];
  }

  if(!isDefined(level.var_16cfe3ef)) {
    level.var_16cfe3ef = [];
  }

  level flagsys::wait_till("start_zombie_round_logic");
  function_eeeb30d7();
  function_9559446b();
  function_f7bd473a();
  level flag::wait_till("pap_machine_active");
  function_2bdb235d();
}

private function_ccf7ac87() {
  level endon(#"end_game");

  if(!isDefined(level.var_2510f3e4)) {
    level.var_2510f3e4 = [];
  }

  level flagsys::wait_till("start_zombie_round_logic");
  traps = getEntArray("zombie_trap", "targetname");

  foreach(trap in traps) {
    if(!isDefined(trap._trap_use_trigs)) {
      continue;
    }

    foreach(trap_trig in trap._trap_use_trigs) {
      if(!isDefined(trap_trig._trap)) {
        continue;
      }

      if(!isDefined(level.var_2510f3e4)) {
        level.var_2510f3e4 = [];
      } else if(!isarray(level.var_2510f3e4)) {
        level.var_2510f3e4 = array(level.var_2510f3e4);
      }

      level.var_2510f3e4[level.var_2510f3e4.size] = trap_trig;
    }
  }
}

function_d67bafb5(stub, category) {
  if(!isDefined(stub) || !isDefined(category)) {
    return;
  }

  switch (category) {
    case #"lockdown_stub_type_wallbuys":
      if(!isDefined(level.var_f17bdf53)) {
        level.var_f17bdf53 = [];
      }

      if(!isinarray(level.var_f17bdf53, stub)) {
        if(!isDefined(level.var_f17bdf53)) {
          level.var_f17bdf53 = [];
        } else if(!isarray(level.var_f17bdf53)) {
          level.var_f17bdf53 = array(level.var_f17bdf53);
        }

        level.var_f17bdf53[level.var_f17bdf53.size] = stub;
      }

      break;
    case #"lockdown_stub_type_pap":
      if(!isDefined(level.pap_lockdown_stubs)) {
        level.pap_lockdown_stubs = [];
      }

      if(!isinarray(level.pap_lockdown_stubs, stub)) {
        if(!isDefined(level.pap_lockdown_stubs)) {
          level.pap_lockdown_stubs = [];
        } else if(!isarray(level.pap_lockdown_stubs)) {
          level.pap_lockdown_stubs = array(level.pap_lockdown_stubs);
        }

        level.pap_lockdown_stubs[level.pap_lockdown_stubs.size] = stub;
      }

      break;
    case #"lockdown_stub_type_perks":
      if(!isDefined(level.var_9235b607)) {
        level.var_9235b607 = [];
      }

      if(!isinarray(level.var_9235b607, stub)) {
        if(!isDefined(level.var_9235b607)) {
          level.var_9235b607 = [];
        } else if(!isarray(level.var_9235b607)) {
          level.var_9235b607 = array(level.var_9235b607);
        }

        level.var_9235b607[level.var_9235b607.size] = stub;
      }

      break;
    case #"lockdown_stub_type_crafting_tables":
      if(!isDefined(level.var_16cfe3ef)) {
        level.var_16cfe3ef = [];
      }

      if(!isinarray(level.var_16cfe3ef, stub)) {
        if(!isDefined(level.var_16cfe3ef)) {
          level.var_16cfe3ef = [];
        } else if(!isarray(level.var_16cfe3ef)) {
          level.var_16cfe3ef = array(level.var_16cfe3ef);
        }

        level.var_16cfe3ef[level.var_16cfe3ef.size] = stub;
      }

      break;
  }
}

function_6b9e848(stub) {
  function_77caff8b(stub);

  if(isDefined(level.var_f17bdf53) && isinarray(level.var_f17bdf53, stub)) {
    arrayremovevalue(level.var_f17bdf53, stub);
  }

  if(isDefined(level.pap_lockdown_stubs) && isinarray(level.pap_lockdown_stubs, stub)) {
    arrayremovevalue(level.pap_lockdown_stubs, stub);
  }

  if(isDefined(level.var_9235b607) && isinarray(level.var_9235b607, stub)) {
    arrayremovevalue(level.var_9235b607, stub);
  }

  if(isDefined(level.var_16cfe3ef) && isinarray(level.var_16cfe3ef, stub)) {
    arrayremovevalue(level.var_16cfe3ef, stub);
  }
}

private function_b913ec1b(targetname, category) {
  foreach(stub in level._unitriggers.trigger_stubs) {
    if(isDefined(stub.targetname) && stub.targetname == targetname) {
      function_d67bafb5(stub, category);
    }
  }
}

private function_eeeb30d7() {
  function_b913ec1b("weapon_upgrade", "lockdown_stub_type_wallbuys");
  function_b913ec1b("bowie_upgrade", "lockdown_stub_type_wallbuys");
}

private function_9559446b() {
  function_b913ec1b("perk_vapor_altar_stub", "lockdown_stub_type_perks");
}

private function_f7bd473a() {
  function_b913ec1b("crafting_trigger", "lockdown_stub_type_crafting_tables");
}

function_2bdb235d() {
  function_b913ec1b("pap_machine_stub", "lockdown_stub_type_pap");
}

private function_2bdff7e1(entity, stub, node) {
  var_5bd89846 = groundtrace(node.origin + (0, 0, 8), node.origin + (0, 0, -100000), 0, entity)[#"position"];
  var_66694b96 = {
    #origin: var_5bd89846, 
    #angles: node.angles
  };

  if(!(isDefined(stub.var_7c2f9a8b) && stub.var_7c2f9a8b)) {
    stub.var_66694b96 = var_66694b96;
  }

  return var_66694b96;
}

function_dab6d796(entity, stub) {
  if(!isDefined(stub)) {
    return undefined;
  }

  if(isDefined(stub.var_66694b96)) {
    return stub.var_66694b96;
  }

  if(isDefined(stub.target)) {
    node = getnode(stub.target, "targetname");

    if(isDefined(node)) {
      return function_2bdff7e1(entity, stub, node);
    }
  }

  radius = entity getpathfindingradius();
  height = entity function_6a9ae71();
  heightoffset = (0, 0, height * -1 / 2);
  var_e790dc87 = (radius, radius, height / 2);

  if(isentity(stub)) {
    maxs = stub.maxs;
  } else {
    switch (stub.script_unitrigger_type) {
      case #"unitrigger_box_use":
        maxs = (stub.script_width / 2, stub.script_height / 2, stub.script_length / 2);
        break;
      case #"unitrigger_radius_use":
        maxs = (stub.radius, stub.script_height / 2, stub.radius);
        break;
    }
  }

  search_radius = max(max(maxs[0] + var_e790dc87[0], maxs[1] + var_e790dc87[1]), maxs[2] + var_e790dc87[2]);
  nodes = getnodearray("lockdown_alignment_node", "script_noteworthy");
  nodes = arraysortclosest(nodes, stub.origin + heightoffset, 1, 0, search_radius);
  fallback_node = undefined;

  foreach(node in nodes) {
    if(!isDefined(fallback_node)) {
      fallback_node = node;
    }

    if(node.script_noteworthy === "lockdown_alignment_node") {
      return function_2bdff7e1(entity, stub, node);
    }
  }

  if(isDefined(fallback_node)) {
    return function_2bdff7e1(entity, stub, fallback_node);
  }
}

function_da72073(stub) {
  if(!isDefined(stub)) {
    return undefined;
  }

  if(isDefined(stub.fxnode)) {
    return stub.fxnode;
  }

  if(isDefined(stub.script_height)) {
    n_radius = stub.script_height;
  } else {
    n_radius = 64;
  }

  a_structs = struct::get_array("lockdown_fx", "targetname");
  fxnode = arraygetclosest(stub.origin, a_structs, n_radius);

  if(isDefined(fxnode) && !(isDefined(stub.var_7e4bc0a2) && stub.var_7e4bc0a2)) {
    stub.fxnode = fxnode;
  }

  return fxnode;
}

private function_9f952db3(stub, entity, maxheight) {
  if(entity.origin[2] > stub.origin[2]) {

    if(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
      function_78eae22a(entity, stub, 7);
    }

      return false;
  }

  if(stub.origin[2] - entity.origin[2] > maxheight) {

    if(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
      function_78eae22a(entity, stub, 11, stub.origin[2] - entity.origin[2]);
    }

      return false;
  }

  return true;
}

private function_adb36e84(stub) {
  self waittill(#"death");
  function_77caff8b(stub);
}

function_77caff8b(stub) {
  if(!isDefined(stub)) {
    return;
  }

  var_a0692a89 = function_fd31eb92(stub);

  if(isDefined(var_a0692a89) && var_a0692a89.claimed) {
    function_66941fc3(stub);
  }
}

private function_66941fc3(stub) {
  for(var_77f297ef = 0; var_77f297ef < level.var_85c076ab.size; var_77f297ef++) {
    var_2943f1ec = level.var_85c076ab[var_77f297ef];

    for(index = 0; index < var_2943f1ec.var_f6d13e1b.size; index++) {
      if(var_2943f1ec.var_f6d13e1b[index].stub == stub) {
        var_2943f1ec.var_f6d13e1b = array::remove_index(var_2943f1ec.var_f6d13e1b, index);
        break;
      }
    }

    if(var_2943f1ec.var_f6d13e1b.size == 0) {
      level.var_85c076ab = array::remove_index(level.var_85c076ab, var_77f297ef);
    }
  }
}

private function_fd31eb92(stub) {
  foreach(var_2943f1ec in level.var_85c076ab) {
    foreach(var_f1e20c7f in var_2943f1ec.var_f6d13e1b) {
      if(var_f1e20c7f.stub === stub || var_f1e20c7f.var_6f08706b === stub) {
        return var_f1e20c7f;
      }
    }
  }
}

private function_f7315b07(entity) {
  foreach(var_2943f1ec in level.var_85c076ab) {
    if(var_2943f1ec.entity === entity) {
      return var_2943f1ec;
    }
  }
}

private function_4ad92a9a(entity) {
  foreach(var_2943f1ec in level.var_85c076ab) {
    if(var_2943f1ec.entity === entity) {
      foreach(var_f1e20c7f in var_2943f1ec.var_f6d13e1b) {
        if(isDefined(var_f1e20c7f.claimed) && var_f1e20c7f.claimed) {
          return var_f1e20c7f;
        }
      }
    }
  }
}

private function_e1f6d06a(stub) {
  var_f1e20c7f = function_fd31eb92(stub);
  return isDefined(var_f1e20c7f) && isDefined(var_f1e20c7f.var_4f0ea1b5) && var_f1e20c7f.var_4f0ea1b5;
}

private function_55d2ad24(stub, entity) {
  var_f1e20c7f = function_fd31eb92(stub);
  return isDefined(var_f1e20c7f) && isDefined(var_f1e20c7f.claimed) && var_f1e20c7f.claimed && entity !== var_f1e20c7f.owner;
}

private function_d3fbb5ec(entity, stub, current_zone) {
  if(isDefined(current_zone) && isDefined(stub.in_zone) && stub.in_zone != current_zone) {

    function_78eae22a(entity, stub, 2);

      return false;
  }

  return true;
}

private function_9c7d5271(entity, &registerlotus_right, range) {
  current_zone = entity zm_utility::get_current_zone();
  stubs = arraysortclosest(level.var_f17bdf53, entity.origin, undefined, 0, range);

  foreach(stub in stubs) {
    if(function_e1f6d06a(stub)) {

      function_78eae22a(entity, stub, 0);

        continue;
    }

    if(function_55d2ad24(stub, entity)) {

      function_78eae22a(entity, stub, 1);

        continue;
    }

    if(!function_d3fbb5ec(entity, stub, current_zone)) {
      continue;
    }

    stub.lockdowntype = "lockdown_stub_type_wallbuys";

    if(!isDefined(registerlotus_right)) {
      registerlotus_right = [];
    } else if(!isarray(registerlotus_right)) {
      registerlotus_right = array(registerlotus_right);
    }

    if(!isinarray(registerlotus_right, stub)) {
      registerlotus_right[registerlotus_right.size] = stub;
    }
  }
}

private function_fea6f0c0(entity, stub, current_zone) {
  if(isDefined(current_zone) && isDefined(stub.in_zone) && stub.in_zone != current_zone) {

    function_78eae22a(entity, stub, 2);

      return false;
  }

  if(isDefined(stub.var_3468124) && stub.var_3468124.var_2977c27 !== "on") {

    function_78eae22a(entity, stub, 17);

      return false;
  }

  return true;
}

private function_db989a2a(entity, &registerlotus_right, range) {
  current_zone = entity zm_utility::get_current_zone();
  stubs = arraysortclosest(level.var_9235b607, entity.origin, undefined, 0, range);

  foreach(stub in stubs) {
    if(function_e1f6d06a(stub)) {

      function_78eae22a(entity, stub, 0);

        continue;
    }

    if(function_55d2ad24(stub, entity)) {

      function_78eae22a(entity, stub, 1);

        continue;
    }

    if(!function_fea6f0c0(entity, stub, current_zone)) {
      continue;
    }

    stub.lockdowntype = "lockdown_stub_type_perks";

    if(!isDefined(registerlotus_right)) {
      registerlotus_right = [];
    } else if(!isarray(registerlotus_right)) {
      registerlotus_right = array(registerlotus_right);
    }

    if(!isinarray(registerlotus_right, stub)) {
      registerlotus_right[registerlotus_right.size] = stub;
    }
  }
}

private function_ea677a9a(entity, stub, current_zone) {
  if(isDefined(current_zone) && isDefined(stub.in_zone) && stub.in_zone != current_zone) {

    function_78eae22a(entity, stub, 2);

      return false;
  }

  return true;
}

private function_d0e1d38c(entity, &registerlotus_right, range) {
  current_zone = entity zm_utility::get_current_zone();
  stubs = arraysortclosest(level.var_16cfe3ef, entity.origin, undefined, 0, range);

  foreach(stub in stubs) {
    if(function_e1f6d06a(stub)) {

      function_78eae22a(entity, stub, 0);

        continue;
    }

    if(function_55d2ad24(stub, entity)) {

      function_78eae22a(entity, stub, 1);

        continue;
    }

    if(!function_ea677a9a(entity, stub, current_zone)) {
      continue;
    }

    stub.lockdowntype = "lockdown_stub_type_crafting_tables";

    if(!isDefined(registerlotus_right)) {
      registerlotus_right = [];
    } else if(!isarray(registerlotus_right)) {
      registerlotus_right = array(registerlotus_right);
    }

    if(!isinarray(registerlotus_right, stub)) {
      registerlotus_right[registerlotus_right.size] = stub;
    }
  }
}

private function_95250640(entity, stub) {
  if(level flag::get("moving_chest_now")) {

    function_78eae22a(entity, stub.trigger_target, 15);

      return false;
  }

  if(isDefined(stub.trigger_target.hidden) && stub.trigger_target.hidden) {

    function_78eae22a(entity, stub.trigger_target, 3);

      return false;
  }

  if(isDefined(stub.trigger_target._box_open) && stub.trigger_target._box_open) {

    function_78eae22a(entity, stub.trigger_target, 4);

      return false;
  }

  if(isDefined(stub.trigger_target.was_temp) && stub.trigger_target.was_temp || isDefined(stub.trigger_target.being_removed) && stub.trigger_target.being_removed) {

    function_78eae22a(entity, stub.trigger_target, 13);

      return false;
  }

  return true;
}

private function_e6761711(entity, &registerlotus_right, range) {
  chests = arraysortclosest(level.chests, entity.origin, undefined, 0, range);

  foreach(chest in chests) {
    if(!function_95250640(entity, chest.unitrigger_stub)) {
      continue;
    }

    if(function_e1f6d06a(chest.unitrigger_stub)) {

      function_78eae22a(entity, chest, 0);

        continue;
    }

    if(function_55d2ad24(chest.unitrigger_stub, entity)) {

      function_78eae22a(entity, chest, 1);

        continue;
    }

    chest.unitrigger_stub.lockdowntype = "lockdown_stub_type_magic_box";

    if(!isDefined(registerlotus_right)) {
      registerlotus_right = [];
    } else if(!isarray(registerlotus_right)) {
      registerlotus_right = array(registerlotus_right);
    }

    if(!isinarray(registerlotus_right, chest.unitrigger_stub)) {
      registerlotus_right[registerlotus_right.size] = chest.unitrigger_stub;
    }
  }
}

private function_790e3eb0(entity, trigger) {
  if(trigger.pap_machine.state !== "powered") {

    function_78eae22a(entity, trigger, 5);

      return false;
  }

  if(!trigger.pap_machine flag::get("pap_waiting_for_user")) {

    function_78eae22a(entity, trigger, 6);

      return false;
  }

  return true;
}

private function_165e2bd6(entity, &registerlotus_right, range) {
  if(!level flag::get("pap_machine_active")) {
    return;
  }

  foreach(stub in level.pap_lockdown_stubs) {
    if(function_55d2ad24(stub, entity)) {

      function_78eae22a(entity, stub, 1);

        continue;
    }

    if(!function_790e3eb0(entity, stub)) {
      continue;
    }

    if(function_e1f6d06a(stub)) {

      function_78eae22a(entity, stub, 0);

        continue;
    }

    stub.lockdowntype = "lockdown_stub_type_pap";

    if(!isDefined(registerlotus_right)) {
      registerlotus_right = [];
    } else if(!isarray(registerlotus_right)) {
      registerlotus_right = array(registerlotus_right);
    }

    if(!isinarray(registerlotus_right, stub)) {
      registerlotus_right[registerlotus_right.size] = stub;
    }
  }
}

private function_809ae5cb(entity, blocker) {
  if(zm_utility::all_chunks_destroyed(blocker, blocker.barrier_chunks)) {

    function_78eae22a(entity, blocker, 12);

      return false;
  }

  return true;
}

private function_8850974b(entity, &registerlotus_right, range) {
  blockers = arraysortclosest(level.exterior_goals, entity.origin, undefined, 0, range);

  foreach(blocker in blockers) {
    if(function_55d2ad24(blocker, entity)) {

      function_78eae22a(entity, blocker, 1);

        continue;
    }

    if(function_e1f6d06a(blocker)) {

      function_78eae22a(entity, blocker, 0);

        continue;
    }

    if(!function_809ae5cb(entity, blocker)) {

      function_78eae22a(entity, blocker, 12);

        continue;
    }

    blocker.lockdowntype = "lockdown_stub_type_boards";

    if(!isDefined(registerlotus_right)) {
      registerlotus_right = [];
    } else if(!isarray(registerlotus_right)) {
      registerlotus_right = array(registerlotus_right);
    }

    if(!isinarray(registerlotus_right, blocker)) {
      registerlotus_right[registerlotus_right.size] = blocker;
    }
  }
}

private function_387fd27e(entity, trap_trig) {
  if(!trap_trig._trap._trap_in_use || !trap_trig._trap istriggerenabled()) {

    function_78eae22a(entity, trap_trig, 16);

      return false;
  }

  return true;
}

private function_d2ce5ac1(entity, &registerlotus_right, range) {
  trap_trigs = arraysortclosest(level.var_2510f3e4, entity.origin, undefined, 0, range);

  foreach(trap_trig in trap_trigs) {
    if(function_55d2ad24(trap_trig, entity)) {

      function_78eae22a(entity, trap_trig, 1);

        continue;
    }

    if(!function_387fd27e(entity, trap_trig)) {
      continue;
    }

    trap_trig.lockdowntype = "lockdown_stub_type_traps";

    if(!isDefined(registerlotus_right)) {
      registerlotus_right = [];
    } else if(!isarray(registerlotus_right)) {
      registerlotus_right = array(registerlotus_right);
    }

    if(!isinarray(registerlotus_right, trap_trig)) {
      registerlotus_right[registerlotus_right.size] = trap_trig;
    }
  }
}

function_22aeb4e9(lockdowntype) {
  switch (lockdowntype) {
    case #"lockdown_stub_type_pap":
      return "PAP";
    case #"lockdown_stub_type_magic_box":
      return "MAGIC_BOX";
    case #"lockdown_stub_type_boards":
      return "BOARDS";
    case #"lockdown_stub_type_wallbuys":
      return "WALLBUY";
    case #"lockdown_stub_type_crafting_tables":
      return "CRAFTING_TABLE";
    case #"lockdown_stub_type_perks":
      return "PERK";
    case #"lockdown_stub_type_traps":
      return "TRAP";
  }

  return "INVALID";
}

function_87c1193e(entity) {
  var_a0692a89 = function_4ad92a9a(entity);

  if(isDefined(var_a0692a89)) {
    return var_a0692a89.stub;
  }
}

function_50ba1eb0(entity, stub) {
  var_2943f1ec = function_f7315b07(entity);

  if(!isDefined(var_2943f1ec)) {
    var_2943f1ec = new class_b599a4bc();
    var_2943f1ec.entity = entity;
    array::add(level.var_85c076ab, var_2943f1ec);
  }

  var_f1e20c7f = function_fd31eb92(stub);

  if(!isDefined(var_f1e20c7f)) {
    var_f1e20c7f = new class_6fde4e6();
    var_f1e20c7f.stub = stub;
    var_f1e20c7f.owner = entity;
    var_f1e20c7f.claimed = 1;
    array::add(var_2943f1ec.var_f6d13e1b, var_f1e20c7f);

    function_78eae22a(entity, stub, 10);

  }

  entity thread function_adb36e84(stub);
}

function_9b84bb88(entity, stubtypes, var_d05e79c8, var_c7455683) {

  if(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
    entity.var_d187874c = [];
  }

    registerlotus_right = [];

  foreach(stubtype in stubtypes) {
    [[level.var_492142a5[stubtype]]](entity, registerlotus_right, var_d05e79c8);
  }

  registerlotus_right = array::filter(registerlotus_right, 0, &function_9f952db3, entity, var_c7455683);

  if(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
    function_6351d1c3(entity, registerlotus_right, var_d05e79c8);
  }

    return arraysortclosest(registerlotus_right, entity.origin);
}

function_7258b5cc(entity, var_410a8c7, var_2baba799, unlockfunc) {
  var_a0692a89 = function_4ad92a9a(entity);

  if(!isDefined(var_a0692a89) || !isDefined(var_a0692a89.stub)) {
    return;
  }

  if(!function_c9105448(entity, var_a0692a89.stub)) {
    function_77caff8b(var_a0692a89.stub);
    return undefined;
  }

  stub = var_a0692a89.stub;

  if(stub.lockdowntype === "lockdown_stub_type_boards") {
    zm_blockers::open_zbarrier(stub);
    function_66941fc3(stub);
    return;
  }

  if(stub.lockdowntype === "lockdown_stub_type_traps") {
    stub._trap notify(#"trap_finished");
    function_66941fc3(stub);
    return;
  } else if(!isentity(stub)) {
    if(!isDefined(stub.var_a0fc37f6)) {
      stub.var_a0fc37f6 = stub.prompt_and_visibility_func;
    }

    stub.prompt_and_visibility_func = var_410a8c7;

    if(!isDefined(stub.var_492080a5)) {
      stub.var_492080a5 = stub.trigger_func;
    }

    stub.trigger_func = var_2baba799;
    zm_unitrigger::reregister_unitrigger(stub);
  } else {
    stub triggerenable(0);
    newstub = stub zm_unitrigger::function_9267812e(stub.maxs[0] - stub.mins[0], stub.maxs[1] - stub.mins[1], stub.maxs[2] - stub.mins[2]);
    newstub.prompt_and_visibility_func = var_410a8c7;
    newstub.var_6f08706b = stub;
    newstub.lockdowntype = stub.lockdowntype;
    newstub.script_string = stub.script_string;
    stub.lockdowntype = undefined;
    stub.lockdownstub = newstub;
    var_a0692a89.stub = newstub;
    var_a0692a89.var_6f08706b = stub;
    stub = newstub;
    zm_unitrigger::register_unitrigger(newstub, var_2baba799);
  }

  if(stub.lockdowntype === "lockdown_stub_type_perks") {
    stub.var_3468124 zm_perks::function_efd2c9e6();
  }

  stub.unlockfunc = unlockfunc;
  var_a0692a89.var_4f0ea1b5 = 1;
  var_a0692a89.claimed = 0;
  return stub;
}

function_7bfa8895(entity) {
  return isDefined(function_4ad92a9a(entity));
}

function_b5dd9241(stub) {
  var_a0692a89 = function_fd31eb92(stub);

  if(!isDefined(var_a0692a89)) {
    return false;
  }

  return var_a0692a89.var_4f0ea1b5 === 1;
}

function_c9105448(entity, stub) {
  switch (stub.lockdowntype) {
    case #"lockdown_stub_type_boards":
      return function_809ae5cb(entity, stub);
    case #"lockdown_stub_type_crafting_tables":
      current_zone = entity zm_utility::get_current_zone();
      return function_ea677a9a(entity, stub, current_zone);
    case #"lockdown_stub_type_magic_box":
      return function_95250640(entity, stub);
    case #"lockdown_stub_type_pap":
      return function_790e3eb0(entity, stub);
    case #"lockdown_stub_type_perks":
      current_zone = entity zm_utility::get_current_zone();
      return function_fea6f0c0(entity, stub, current_zone);
    case #"lockdown_stub_type_wallbuys":
      current_zone = entity zm_utility::get_current_zone();
      return function_d3fbb5ec(entity, stub, current_zone);
    case #"lockdown_stub_type_traps":
      return function_387fd27e(entity, stub);
    default:
      return true;
  }
}

function_ac6907ec() {
  var_a0692a89 = function_fd31eb92(self);

  if(isDefined(var_a0692a89)) {
    var_a0692a89.var_4f0ea1b5 = 2;
  }

  if(isDefined(self) && isDefined(self.unlockfunc)) {
    [[self.unlockfunc]](self);
  }

  self.prompt_and_visibility_func = self.var_a0fc37f6;
  self.trigger_func = self.var_492080a5;

  if(self.lockdowntype === "lockdown_stub_type_perks") {
    self.var_3468124 zm_perks::function_1e721859();
  }

  self.var_a0fc37f6 = undefined;
  self.var_492080a5 = undefined;
  function_66941fc3(self);
  zm_unitrigger::reregister_unitrigger(self);
}

function_4de23f77() {
  var_a0692a89 = function_fd31eb92(self);

  if(isDefined(var_a0692a89)) {
    var_a0692a89.var_4f0ea1b5 = 2;
  }

  self.var_6f08706b.lockdownstub = undefined;

  if(isDefined(self) && isDefined(self.unlockfunc)) {
    [[self.unlockfunc]](self);
  }

  self.var_6f08706b triggerenable(1);
  function_66941fc3(self);
  zm_unitrigger::unregister_unitrigger(self);
}

function_61a9bc58() {
  var_a0692a89 = function_fd31eb92(self);
  assert(isDefined(var_a0692a89));
  self.var_6156031a = 1;

  if(isDefined(self.var_6f08706b)) {
    self function_4de23f77();
  } else {
    self function_ac6907ec();
  }

  self.var_6156031a = undefined;
}

function_78eae22a(entity, stub, reason, ...) {
  if(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1) {
    if(!isDefined(entity.var_d187874c)) {
      entity.var_d187874c = [];
    } else if(!isarray(entity.var_d187874c)) {
      entity.var_d187874c = array(entity.var_d187874c);
    }

    entity.var_d187874c[entity.var_d187874c.size] = {
      #stub: stub, 
      #reason: reason, 
      #args: vararg
    };
  }
}

function_f3cff6ff(entity) {
  if(!(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1)) {
    return;
  }

  if(!isDefined(entity.var_d187874c)) {
    return;
  }

  if(getdvarint(#"zm_lockdown_ent", -1) != entity getentitynumber()) {
    return;
  }

  foreach(var_ca00d79a in entity.var_d187874c) {
    text = entity getentitynumber() + "<dev string:x38>";
    color = (1, 0, 0);

    switch (var_ca00d79a.reason) {
      case 0:
        text += "<dev string:x3d>";
        break;
      case 1:
        text += "<dev string:x53>";
        break;
      case 2:
        text += "<dev string:x6c>";
        break;
      case 3:
        text += "<dev string:x7a>";
        break;
      case 4:
        text += "<dev string:x87>";
        break;
      case 5:
        text += "<dev string:x94>";
        break;
      case 6:
        text += "<dev string:xa6>";
        break;
      case 8:
        text += "<dev string:xbb>" + var_ca00d79a.args[0];
        break;
      case 9:
        text += "<dev string:xcd>";
        break;
      case 7:
        text += "<dev string:xe0>";
        break;
      case 11:
        text += "<dev string:xea>" + var_ca00d79a.args[0];
        break;
      case 10:
        text += "<dev string:xf8>";
        color = (0, 1, 0);
        break;
      case 13:
        text += "<dev string:x102>";
        break;
      case 14:
        text += "<dev string:x110>";
        recordstar(var_ca00d79a.args[0], (0, 1, 1));
        recordstar(var_ca00d79a.args[1].origin, (1, 0, 1));
        recordline(var_ca00d79a.args[1].origin, var_ca00d79a.args[1].origin + anglesToForward(var_ca00d79a.args[1].angles) * 10, (1, 1, 0));
        break;
      case 15:
        text += "<dev string:x135>";
        break;
      case 16:
        text += "<dev string:x145>";
        break;
      case 17:
        text += "<dev string:x157>";
        break;
    }

    recordstar(var_ca00d79a.stub.origin, (1, 1, 0));
    record3dtext(text, var_ca00d79a.stub.origin + (0, 0, 10), color);
  }
}

private function_6351d1c3(entity, registerlotus_right, var_d05e79c8) {
  foreach(stub in registerlotus_right) {
    dist = distancesquared(entity.origin, stub.origin);

    if(dist > var_d05e79c8 * var_d05e79c8) {
      function_78eae22a(entity, stub, 8, sqrt(dist));
    }
  }
}

private function_946bb116() {
  zm_devgui::add_custom_devgui_callback(&function_2765c63);
  adddebugcommand("<dev string:x16d>");
  adddebugcommand("<dev string:x1a7>");
  adddebugcommand("<dev string:x1cd>");
  adddebugcommand("<dev string:x208>");
  adddebugcommand("<dev string:x269>");
}

private function_2765c63(cmd) {
  switch (cmd) {
    case #"hash_619d20b906a39230":
      level.var_cd20e41b = !(isDefined(level.var_cd20e41b) && level.var_cd20e41b);

      if(isDefined(level.var_cd20e41b) && level.var_cd20e41b) {
        level thread function_6e1690d5();
      } else {
        level notify(#"hash_52b90374b27fcb8a");
      }

      break;
  }
}

private function_6e1690d5() {
  self notify("<dev string:x2ca>");
  self endon("<dev string:x2ca>");
  level endon(#"hash_52b90374b27fcb8a");
  stubs = arraycombine(level.exterior_goals, level.var_16cfe3ef, 0, 0);
  stubs = arraycombine(stubs, level.pap_lockdown_stubs, 0, 0);
  stubs = arraycombine(stubs, level.var_9235b607, 0, 0);
  stubs = arraycombine(stubs, level.var_2510f3e4, 0, 0);
  stubs = arraycombine(stubs, level.var_f17bdf53, 0, 0);

  foreach(chest in level.chests) {
    if(!isDefined(stubs)) {
      stubs = [];
    } else if(!isarray(stubs)) {
      stubs = array(stubs);
    }

    stubs[stubs.size] = chest.unitrigger_stub;
  }

  var_3bd3c0c1 = (-16, -16, 0);
  var_cbe5413e = (16, 16, 32);

  while(true) {
    wait 0.5;
    entity = getentbynum(getdvarint(#"zm_lockdown_ent", -1));

    if(!isDefined(entity)) {
      continue;
    }

    foreach(stub in stubs) {
      var_754b10b4 = function_dab6d796(entity, stub);

      if(isDefined(var_754b10b4)) {
        box(var_754b10b4.origin, var_3bd3c0c1, var_cbe5413e, var_754b10b4.angles[1], (0, 1, 0), 1, 0, 10);
        line(var_754b10b4.origin, var_754b10b4.origin + anglesToForward(var_754b10b4.angles) * 32, (0, 1, 0), 1, 0, 10);
        continue;
      }

      circle(stub.origin, 16, (1, 0, 0), 0, 0, 10);
    }
  }
}

