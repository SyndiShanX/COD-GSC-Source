/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_31b23f5316d1b26d.csc
***********************************************/

#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace namespace_f27a9d0d;

function private event_handler[createstruct] function_e0a8e4ba(struct) {
  foreach(var_7b62a41a, k in ["rg_tag_type"]) {
    if(!isDefined(level.var_41204f29)) {
      level.var_41204f29 = [];
    } else if(!isarray(level.var_41204f29)) {
      level.var_41204f29 = array(level.var_41204f29);
    }

    if(!isinarray(level.var_41204f29, tolower(k))) {
      level.var_41204f29[level.var_41204f29.size] = tolower(k);
    }
  }

  level.var_5e990e96 = arraycopy(level.var_41204f29);

  if(isDefined(level.struct)) {
    temp = arraycopy(level.struct);
    level.struct = [];

    foreach(struct in temp) {
      struct::init(struct);
    }
  }

  function_6c07201b("CreateStruct", &function_e0a8e4ba);
}

function function_e667ba34(to, from) {
  foreach(tag_name in level.var_4392df44) {
    if(isDefined(from.(tag_name))) {
      to.(tag_name) = from.(tag_name);
    }
  }
}

function private function_a06dcd8b(v) {
  return (round(v[0]), round(v[1]), round(v[2]));
}

function function_2ff463e2(name) {
  var_64f87a02 = getent(0, name, "targetname");
  assert(isDefined(var_64f87a02));
  level.var_a40e1682[name] = var_64f87a02;
  var_64f87a02 hide();
  var_64f87a02.spawned_origin = function_a06dcd8b(var_64f87a02.origin);
  var_64f87a02.var_66b667b0 = function_a06dcd8b(var_64f87a02.angles);
  var_64f87a02.tags = [];
  var_e8da8fdb = struct::get_array(name, "rg_room");

  foreach(room_struct in var_e8da8fdb) {
    if(isDefined(room_struct.rg_tag_type)) {
      var_4a14890d = spawnStruct();
      var_4a14890d.type = room_struct.rg_tag_type;
      var_4a14890d.id = room_struct.var_d0971441;
      var_4a14890d.origin = coordtransformtranspose(room_struct.origin, var_64f87a02.spawned_origin, var_64f87a02.var_66b667b0);
      var_4a14890d.angles = function_bdd10bae(room_struct.angles, var_64f87a02.var_66b667b0);
      function_e667ba34(var_4a14890d, room_struct);
      var_64f87a02.tags[var_64f87a02.tags.size] = var_4a14890d;
    }
  }
}

function private function_2f65cd89() {
  result = "rg_room_" + level.var_eb3397eb;
  level.var_eb3397eb++;
  return result;
}

function private function_b36a26fe() {
  result = "rg_node_" + level.var_c43edd0c;
  level.var_c43edd0c++;
  return result;
}

function private function_8396377c(var_57617236, origin, angles) {
  assert(isDefined(var_57617236));
  door = spawnStruct();
  door.targetname = function_2f65cd89();
  door.origin = origin;
  door.angles = angles;
  door.spawned_origin = function_a06dcd8b(origin);
  door.var_66b667b0 = function_a06dcd8b(angles);
  door.template = var_57617236;
  door.neighbors = [];
  door.var_12650ad6 = [];
  door.tags = [];

  foreach(var_5cf84433 in var_57617236.tags) {
    var_df2b5097 = spawnStruct();
    var_df2b5097.id = var_5cf84433.id;
    var_df2b5097.owner = door;
    var_df2b5097.origin = coordtransform(var_5cf84433.origin, door.spawned_origin, door.var_66b667b0);
    var_df2b5097.angles = combineangles(door.var_66b667b0, var_5cf84433.angles);
    var_df2b5097.type = var_5cf84433.type;
    function_e667ba34(var_df2b5097, var_5cf84433);
    door.tags[door.tags.size] = var_df2b5097;
  }

  level.var_e5ed336c[door.targetname] = door;
  return door;
}

function private function_9a75d6e9(var_64f87a02, origin, angles) {
  assert(isDefined(var_64f87a02));
  room = spawnStruct();
  room.targetname = function_2f65cd89();
  room.origin = origin;
  room.angles = angles;
  room.spawned_origin = function_a06dcd8b(origin);
  room.var_66b667b0 = function_a06dcd8b(angles);
  room.template = var_64f87a02;
  room.neighbors = [];
  room.var_12650ad6 = [];
  room.tags = [];

  foreach(var_103a1f3b in var_64f87a02.tags) {
    var_4a14890d = spawnStruct();
    var_4a14890d.id = var_103a1f3b.id;
    var_4a14890d.owner = room;
    var_4a14890d.origin = coordtransform(var_103a1f3b.origin, room.spawned_origin, room.var_66b667b0);
    var_4a14890d.angles = combineangles(room.var_66b667b0, var_103a1f3b.angles);
    var_4a14890d.type = var_103a1f3b.type;
    function_e667ba34(var_4a14890d, var_103a1f3b);
    room.tags[room.tags.size] = var_4a14890d;

    if(var_4a14890d.type === "room_center") {
      room.var_5f5fe462 = var_4a14890d.origin;
    }
  }

  if(isDefined(level.var_40450ea6)) {
    room[[level.var_40450ea6]]();
  }

  level.var_c97eeeb4[room.targetname] = room;
  return room;
}

function private function_700ae446(var_c71df200, var_6a0a1cc4) {
  if(isDefined(self.var_12650ad6[var_c71df200])) {
    return false;
  }

  self.var_12650ad6[var_c71df200] = var_6a0a1cc4;

  if(isDefined(var_6a0a1cc4.owner)) {
    self.neighbors[var_c71df200] = var_6a0a1cc4.owner;
  }

  return true;
}

function private function_71b94f8a(tag1, tag2) {
  if(isDefined(tag1.owner)) {
    if(!tag1.owner function_700ae446(tag1.id, tag2)) {
      return false;
    }
  }

  if(isDefined(tag2.owner)) {
    if(!tag2.owner function_700ae446(tag2.id, tag1)) {
      return false;
    }
  }

  return true;
}

function function_b3f5992c() {
  self notify("34fbc225b71f70d5");
  self endon("34fbc225b71f70d5");
  level endon(#"hash_186e943c1cd0db52");

  if(!isDefined(level.var_c97eeeb4) || level.var_c97eeeb4.size == 0) {
    return;
  }

  function_f4b7f348("connect_all_rooms initialized. level.rg_rooms.size : " + level.var_c97eeeb4.size);

  foreach(room in level.var_c97eeeb4) {
    if(!isDefined(room)) {
      continue;
    }

    if(issubstr(room.template.targetname, "<dev string:x38>")) {
      if(!isDefined(level.var_5d40e975)) {
        level.var_5d40e975 = 0;
      }

      level.var_5d40e975++;
    }

    if(issubstr(room.template.targetname, "<dev string:x41>")) {
      if(!isDefined(level.var_d5561d56)) {
        level.var_d5561d56 = 0;
      }

      level.var_d5561d56++;
    }

    var_eebf1bb0 = room function_cee62dac("type", "room_connector");

    foreach(var_29e30639 in var_eebf1bb0) {
      var_ae433e22 = c_t8_zmb_dlc0_zombie_male_body4_g_lowclean(var_29e30639.origin, array("start", "room_connector"), 4);

      foreach(var_194401e3 in var_ae433e22) {
        if(var_194401e3 != var_29e30639) {
          room function_71b94f8a(var_29e30639, var_194401e3);
        }
      }
    }

    if(!getdvarint(#"hash_55c78475b1ebf3de", 1)) {
      waitframe(1);
    }
  }

  if(!getdvarint(#"hash_55c78475b1ebf3de", 1)) {
    waitframe(1);
    level notify(#"hash_2afb084294b9f124");
  }
}

function private function_28cdb1db(depth) {
  if(isDefined(self.var_d51e68d)) {
    return;
  }

  self.var_d51e68d = depth;

  foreach(var_6a0a1cc4 in self.var_12650ad6) {
    if(isDefined(var_6a0a1cc4.owner)) {
      if(isDefined(var_6a0a1cc4.door)) {
        var_6a0a1cc4.owner function_28cdb1db(depth + 1);
        continue;
      }

      var_6a0a1cc4.owner function_28cdb1db(depth);
    }
  }
}

function function_f4b7f348(text) {
  println("<dev string:x4a>" + text);
}

function function_3a9f29b2(room) {
  if(!isDefined(room)) {
    return;
  }

  function_f4b7f348("Room Cleanup:" + room.targetname);

  if(isDefined(room.var_d8d445c4)) {
    room[[room.var_d8d445c4]]();
  }

  function_f4b7f348("Room Cleanup:" + room.targetname + " clearning pathnodes");
  function_f4b7f348("Room Cleanup:" + room.targetname + " clearning tags");
  room.owner = undefined;

  foreach(tag in room.tags) {
    tag.var_12650ad6 = undefined;
    tag.neighbors = undefined;
    tag.owner = undefined;
  }

  room.tags = [];
  room.neighbors = [];
  room.var_12650ad6 = [];
  room.var_dbb4ff9a = undefined;
  room.template = undefined;
  function_f4b7f348("Room Cleanup:" + room.targetname + " done");
  room struct::delete();
}

function cleanup(full = 0) {
  function_f4b7f348("ROGUE Cleanup - FULL=" + (full ? "true" : "false"));

  if(isDefined(level.var_c97eeeb4)) {
    foreach(room in level.var_c97eeeb4) {
      if(isDefined(room)) {
        function_3a9f29b2(room);
      }

      if(!getdvarint(#"hash_55c78475b1ebf3de", 1)) {
        waitframe(1);
      }
    }
  }

  level.var_c97eeeb4 = [];

  if(isDefined(level.var_e5ed336c)) {
    foreach(door in level.var_e5ed336c) {
      if(isDefined(door)) {
        function_3a9f29b2(door);
      }

      if(!getdvarint(#"hash_55c78475b1ebf3de", 1)) {
        waitframe(1);
      }
    }
  }

  level.var_e5ed336c = [];

  if(full) {
    function_f4b7f348("ROGUE cleaning room templates");
    level.var_a40e1682 = [];
  }

  function_f4b7f348("ROGUE Cleanup DONE!");
  level notify(#"hash_83fa90e9e007988");
}

function function_1648f5a1(name) {
  if(isDefined(level.var_21910540)) {
    [[level.var_21910540]](name);
    return;
  }

  function_2ff463e2("room_1_exit_1024x1024");
  function_2ff463e2("room_2i_exit_1024x1024");
  function_2ff463e2("room_2l_exit_1024x1024");
  function_2ff463e2("room_3_exit_1024x1024");
  function_2ff463e2("room_4_exit_1024x1024");
  function_2ff463e2("hall_1_exit_1024x1024");
  function_2ff463e2("hall_2i_exit_1024x1024");
  function_2ff463e2("hall_2l_exit_1024x1024");
  function_2ff463e2("hall_3_exit_1024x1024");
  function_2ff463e2("hall_4_exit_1024x1024");
  function_2ff463e2("doorbuy_96x128");
}

function init(name) {
  if(!is_true(level.var_f98a5dcd)) {
    level.var_a40e1682 = [];
    level.var_c97eeeb4 = [];
    level.var_e5ed336c = [];
    level.var_4392df44 = [];
    level.var_4392df44[level.var_4392df44.size] = "targetname";
    level.var_4392df44[level.var_4392df44.size] = "target";
    level.var_4392df44[level.var_4392df44.size] = "script_noteworthy";
    level.var_4392df44[level.var_4392df44.size] = "script_string";
    level.var_4392df44[level.var_4392df44.size] = "script_team";
    level.var_4392df44[level.var_4392df44.size] = "script_int";
    level.var_4392df44[level.var_4392df44.size] = "script_parameters";
    var_60f6aaec = struct::get_array("start", "rg_tag_type");
    assert(isDefined(var_60f6aaec.size > 0));
    level.var_60f6aaec = [];

    foreach(start_tag in var_60f6aaec) {
      start_node = spawnStruct();
      start_node.origin = start_tag.origin;
      start_node.angles = start_tag.angles;
      start_node.type = start_tag.rg_tag_type;
      start_node.name = start_tag.targetname;
      start_node.target = start_tag.target;
      start_node.script_int = start_tag.script_int;
      start_node.script_string = start_tag.script_string;
      start_node.script_noteworthy = start_tag.script_noteworty;
      level.var_60f6aaec[level.var_60f6aaec.size] = start_node;
    }
  }

  level.var_c43edd0c = 0;
  level.var_eb3397eb = 0;
  function_c73d6f14(name);
  level.var_f98a5dcd = 1;
  return level.var_49329074;
}

function function_df3f8608(name) {
  foreach(node in level.var_60f6aaec) {
    if(node.name === name) {
      return node;
    }
  }
}

function function_c73d6f14(name) {
  cleanup(1);
  function_1648f5a1(name);
  function_30589a63(name);
}

function function_30589a63(name) {
  if(isDefined(level.var_49329074)) {
    level.var_49329074 struct::delete();
    level.var_49329074 = undefined;
  }

  level.var_49329074 = spawnStruct();

  if(isDefined(name)) {
    start_tag = function_363c84ff(name);
  } else {
    start_tag = level.var_60f6aaec[0];
  }

  level.var_49329074.origin = start_tag.origin;
  level.var_49329074.angles = start_tag.angles;
  level.var_49329074.type = start_tag.type;
}

function function_363c84ff(name) {
  foreach(start_tag in level.var_60f6aaec) {
    if(start_tag.name === name) {
      return start_tag;
    }
  }

  assert(0, "<dev string:x5d>" + name + "<dev string:x74>");
}

function function_e1842922(x, y) {
  return (x * 1024, y * 1024, 0);
}

function function_a8d8b1ab(var_603479c6) {
  switch (var_603479c6) {
    case 0:
      return 0;
    case 1:
      return 90;
    case 2:
      return 180;
    case 3:
      return 270;
    default:
      assertmsg("<dev string:x87>");
      break;
  }
}

function function_cee62dac(key, value) {
  assert(isDefined(self.tags));
  result = [];

  foreach(tag in self.tags) {
    if(isDefined(tag.(key)) && tag.(key) === value) {
      result[result.size] = tag;
    }
  }

  return result;
}

function function_5165998(key, value) {
  found = function_cee62dac(key, value);
  assert(found.size <= 1, "<dev string:xa0>" + (isDefined(key) ? "<dev string:xd2>" + key : "<dev string:xd2>") + "<dev string:xd6>" + (isDefined(value) ? "<dev string:xd2>" + value : "<dev string:xd2>") + "<dev string:xdf>");
  return found.size < 0 ? undefined : found[0];
}

function function_eaad15e2(attach_tag, var_da1a882e, var_c71df200) {
  var_64f87a02 = level.var_a40e1682[var_da1a882e];
  assert(isDefined(var_64f87a02));
  var_103a1f3b = var_64f87a02 function_5165998("id", var_c71df200);
  assert(isDefined(var_103a1f3b));
  var_cde36dad = vectortoangles(anglesToForward(attach_tag.angles) * -1);
  var_e3438a3b = function_bdd10bae(var_cde36dad, var_103a1f3b.angles);
  room_origin = attach_tag.origin + rotatepoint(var_103a1f3b.origin * -1, var_e3438a3b);
  return function_9a75d6e9(var_64f87a02, room_origin, var_e3438a3b);
}

function function_5b611d11(attach_tag, door_name) {
  var_57617236 = level.var_a40e1682[door_name];
  assert(isDefined(var_57617236));
  var_5cf84433 = var_57617236 function_5165998("type", "room_center");
  assert(isDefined(var_5cf84433));
  var_cde36dad = vectortoangles(anglesToForward(attach_tag.angles) * -1);
  door_angles = function_bdd10bae(var_cde36dad, var_5cf84433.angles);
  door_origin = attach_tag.origin + rotatepoint(var_5cf84433.origin * -1, door_angles);
  door = function_8396377c(var_57617236, door_origin, door_angles);
  door.attach_tag = attach_tag;
  return door;
}

function function_40681754(var_da1a882e, x, y, var_603479c6) {
  var_64f87a02 = level.var_a40e1682[var_da1a882e];
  assert(isDefined(var_64f87a02));
  var_103a1f3b = var_64f87a02 function_5165998("type", "room_center");
  assert(isDefined(var_103a1f3b));
  var_e3438a3b = (0, function_a8d8b1ab(var_603479c6), 0);
  var_85f8c961 = function_e1842922(x, y);
  room_origin = var_85f8c961 + rotatepoint(var_103a1f3b.origin * -1, var_e3438a3b);
  return function_9a75d6e9(var_64f87a02, room_origin, var_e3438a3b);
}

function c_t8_zmb_dlc0_zombie_male_body4_g_lowclean(origin, var_816442c9, distancetolerance) {
  if(!isarray(var_816442c9)) {
    var_816442c9 = array(var_816442c9);
  }

  result = [];

  foreach(var_7758b4f0 in var_816442c9) {
    var_21a0f66a = sqr(distancetolerance);

    foreach(room in level.var_c97eeeb4) {
      if(!isDefined(room)) {
        continue;
      }

      var_c9780d2e = room function_cee62dac("type", var_7758b4f0);

      foreach(var_4a14890d in var_c9780d2e) {
        if(var_4a14890d.type == var_7758b4f0 && distancesquared(var_4a14890d.origin, origin) <= var_21a0f66a) {
          result[result.size] = var_4a14890d;
        }
      }
    }

    if(var_7758b4f0 == "start" && distancesquared(level.var_49329074.origin, origin) <= var_21a0f66a) {
      result[result.size] = level.var_49329074;
    }
  }

  return result;
}

function function_39736661(var_816442c9) {
  if(!isarray(var_816442c9)) {
    var_816442c9 = array(var_816442c9);
  }

  result = [];

  foreach(var_7758b4f0 in var_816442c9) {
    foreach(room in level.var_c97eeeb4) {
      if(!isDefined(room)) {
        continue;
      }

      var_c9780d2e = room function_cee62dac("type", var_7758b4f0);

      foreach(var_4a14890d in var_c9780d2e) {
        if(var_4a14890d.type == var_7758b4f0) {
          result[result.size] = var_4a14890d;
        }
      }
    }

    if(var_7758b4f0 == "start") {
      result[result.size] = level.var_49329074;
    }
  }

  return result;
}

function function_612d8b4e() {
  assert(isDefined(level.var_ee250665));

  foreach(room in level.var_c97eeeb4) {
    if(!isDefined(room)) {
      continue;
    }

    room.var_d51e68d = undefined;
  }

  level.var_ee250665 function_28cdb1db(0);
}