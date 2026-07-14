/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\fakeactor_node.gsc
*****************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\debug;
#namespace fakeactor_node;

function fakeactor_node_setup() {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  if(self.script_fakeactor_node == "D\xc7\xb3\x91" || self.script_fakeactor_node == "\x03\x9c\xb4\xa2") {
    self.wait_state = 2;
  } else {
    self.wait_state = 0;
  }

  switch (self.script_fakeactor_node) {
    case #"hash_c2850561e0f6b33b":
      if(isDefined(self.target)) {
        path_nodes = getnodearray(self.target, #targetname);

        if(!path_nodes.size) {
          if(isDefined(self.script_linkto)) {
            path_nodes = getnodearray(self.script_linkto, #script_linkname);
          }
        }

        if(path_nodes.size > 0) {
          foreach(path_node in path_nodes) {
            if(path_node.type == "\x90\xcav-7") {
              self.traverse_animscript = path_node.animscript;
            }
          }
        }

        assert(isDefined(self.traverse_animscript), "<dev string:x24>" + self.origin + "<dev string:x3a>");
        all_structs = utility::getStructArray(self.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

        if(isDefined(self.script_linkto)) {
          all_structs = utility::array_combine(all_structs, utility::getStructArray(self.script_linkto, "F\x83\x1c\x9d\x19\xc5\xd7\x13;\xb3\x14n\x18\xf5\x13"));
        }

        foreach(struct in all_structs) {
          if(isDefined(struct.animation)) {
            self.origin = struct.origin;
            self.angles = struct.angles;
          }
        }
      }

      break;
    case #"hash_fcf513967a3ef3d":
      assert(isDefined(self.animation), "<dev string:x9b>");
      break;
  }

  fakeactor_node_init_type();
  fakeactor_node_init_params();
  fakeactor_node_init_flags();
  waitframe();

  switch (self.script_fakeactor_node) {
    case #"hash_fcf513967a3ef3d":
      self.anim_node = spawnStruct();
      self.anim_node.origin = self.origin;
      self.anim_node.angles = self.angles;
      assert(utility::hasanim_generic(self.animation), "<dev string:xe1>");
      play_animation = utility::getanim_generic(self.animation);
      new_origin = getstartorigin(self.origin, self.angles, play_animation);
      new_angles = getstartangles(self.origin, self.angles, play_animation);
      self.origin = new_origin;
      self.angles = new_angles;

      move_delta = getmovedelta(play_animation, 0, 1);
      angles_delta = getangledelta3d(play_animation, 0, 1);
      var_f09654c1f92aac70 = invertangles(angles_delta);
      self.end_angles = combineangles(self.angles, var_f09654c1f92aac70);
      self.end_origin = self.origin - rotatevector(move_delta, self.end_angles);

      break;
  }
}

function fakeactor_node_init_type() {
  switch (self.script_fakeactor_node) {
    case #"hash_4ddb655e251e06c8":
      self.type = "g\x1fWv\xec\xec@P(o";
      return;
    case #"hash_175771022bc5e75d":
      self.type = "c\xb0\x14\xd5\xd9\xe4\xaf\x8d\x91}\xc2";
      return;
    case #"hash_9d76c99eddd14433":
      self.type = "\xd2\xc8\xaf/\xf5\x1c\xdfs\xfes\x06\xce";
      return;
    case #"hash_f1676baca0ae608b":
      self.type = "\xcalv\xe9\xf1\xb1\x89\x96\x9d^#";
      return;
  }
}

function fakeactor_node_init_params() {
  if(!isDefined(self.script_parameters)) {
    return;
  }

  node_groups = strtok(self.script_parameters, "\xda");

  foreach(node_group in node_groups) {
    if(!isDefined(level.fakeactor_node_group[node_group])) {
      level.fakeactor_node_group[node_group] = [];
    }

    level.fakeactor_node_group[node_group] = utility::array_add(level.fakeactor_node_group[node_group], self);
  }
}

function fakeactor_node_init_flags() {
  if(!isDefined(self.spawnflags)) {
    self.spawnflags = 0;
  }

  if(!(self.spawnflags & 64)) {
    up = 32 * anglestoup(self.angles);
    down = -20000 * anglestoup(self.angles);
    trace = trace::ray_trace(self.origin + up, self.origin + down, undefined, trace::create_solid_ai_contents());

    if(trace["<dev string:x10f>"] == "<dev string:x11a>") {
      println(trace["<dev string:x12a>"] < 1, "<dev string:x136>" + self.origin + "<dev string:x14e>");
    }

    self.origin = trace["\xc1\xbd\xdci\xe8i{7"];

    if(self.spawnflags & 32) {
      if(isDefined(trace["\x1f\xa8\x10WP\xa9"])) {
        self.ground_ent = trace["\x1f\xa8\x10WP\xa9"];
        self.ground_ent_offset = self.ground_ent utility_sp::worldtolocalcoords(self.origin);

        if(!isDefined(self.angles)) {
          self.angles = (0, 0, 0);
        }

        self.ground_ent_angles_offset = self.angles - self.ground_ent.angles;
      }
    }
  }

  if(self.spawnflags & 8) {
    fakeactor_node_set_disabled(1);
  }

  if(self.spawnflags & 16) {
    self.wait_state = 2;
  }

  self.node_claimed = [];
}

function setup_fakeactor_nodes() {
  level.fakeactor_node_group = [];
  level.var_c4050b5ae05fa7a3 = &utility::random;

  foreach(fakeactor_node in level.struct_fakeactors) {
    fakeactor_node thread fakeactor_node_setup();
  }
}

function is_fakeactor_node() {
  return isDefined(self.script_fakeactor_node);
}

function fakeactor_node_update() {
  if(!isDefined(self.ground_ent)) {
    return;
  }

  self.origin = self.ground_ent localtoworldcoords(self.ground_ent_offset);
  struct_angles = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
  struct_angles.angles = self.ground_ent.angles;
  struct_angles addpitch(self.ground_ent_angles_offset[0]);
  struct_angles addyaw(self.ground_ent_angles_offset[1]);
  struct_angles addroll(self.ground_ent_angles_offset[2]);
  self.angles = struct_angles.angles;
  struct_angles delete();
}

function fakeactor_node_get_cover_list() {
  cover_list = [];
  spawnflags = 0;

  if(isDefined(self.spawnflags)) {
    spawnflags = self.spawnflags;
  }

  if(self.script_fakeactor_node == "}ET\xc9\xe8\xbc&\xe5xD") {
    if(!(spawnflags & 1)) {
      cover_list = utility::array_add(cover_list, "}ET\xc9\xe8\xbc&\xe5xD");
    }

    if(!(spawnflags & 2)) {
      cover_list = utility::array_add(cover_list, "B\xfd\xf0g\x1b\xd9#.\xd5~9\x1e\x80%&\x05\xcd");
    }
  } else if(self.script_fakeactor_node == "M\xd5\xd0\xd2\xc4\x99\xe2c\xfe=\x80") {
    if(!(spawnflags & 1)) {
      cover_list = utility::array_add(cover_list, "M\xd5\xd0\xd2\xc4\x99\xe2c\xfe=\x80");
    }

    if(!(spawnflags & 2)) {
      cover_list = utility::array_add(cover_list, "\x16\xc5\x94;\xbbk\x90;;\x90\xca\xe1\x0f\x17\xbe\xd6\x10\xf3");
    }
  } else if(self.script_fakeactor_node == "L)\x81\xfbpg6\xbd\xe0\xb04") {
    cover_list = utility::array_add(cover_list, "L)\x81\xfbpg6\xbd\xe0\xb04");
  } else if(self.script_fakeactor_node == "\x01f\xf6\xa5\xff\xb80W\x86\xe9\xb7\xe5") {
    cover_list = utility::array_add(cover_list, "\x01f\xf6\xa5\xff\xb80W\x86\xe9\xb7\xe5");
  } else {
    cover_list = utility::array_add(cover_list, "\xff\xd5d'hTb");
  }

  if(cover_list.size == 0) {
    assertmsg("<dev string:x196>");
  }

  return cover_list;
}

function fakeactor_node_get_next() {
  if(!isDefined(self.target)) {
    return undefined;
  }

  valid_nodes = fakeactor_node_get_all_valid();

  if(valid_nodes.size) {
    return self[[level.var_c4050b5ae05fa7a3]](valid_nodes);
  }

  return undefined;
}

function fakeactor_node_get_all_valid() {
  valid_nodes = [];

  if(!isDefined(self.target)) {
    return valid_nodes;
  }

  all_nodes = utility::getStructArray(self.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

  foreach(this_node in all_nodes) {
    if(!this_node is_fakeactor_node()) {
      continue;
    }

    if(!this_node fakeactor_node_is_valid()) {
      continue;
    }

    valid_nodes = utility::array_add(valid_nodes, this_node);
  }

  return valid_nodes;
}

function fakeactor_node_get_valid_count() {
  if(!isDefined(self.target)) {
    return 0;
  }

  all_nodes = utility::getStructArray(self.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  valid_count = 0;

  foreach(this_node in all_nodes) {
    if(!this_node is_fakeactor_node()) {
      continue;
    }

    if(!this_node fakeactor_node_is_valid()) {
      continue;
    }

    valid_count++;
  }

  return valid_count;
}

function fakeactor_node_get_angles(frantic) {
  if(!isDefined(frantic)) {
    frantic = 0;
  }

  struct_angles = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));

  if(isDefined(self.angles)) {
    struct_angles.angles = self.angles;
  }

  if(isDefined(self.type)) {
    if(frantic && isDefined(anim.fa_franticnodeyaws)) {
      if(isDefined(anim.fa_franticnodeyaws[self.type])) {
        struct_angles addyaw(anim.fa_franticnodeyaws[self.type]);
      }
    } else if(isDefined(anim.fa_nodeyaws)) {
      if(isDefined(anim.fa_nodeyaws[self.type])) {
        struct_angles addyaw(anim.fa_nodeyaws[self.type]);
      }
    }
  }

  angles = struct_angles.angles;
  struct_angles delete();
  return angles;
}

function fakeactor_node_get_path(first_node, start_pos, frantic, wants_to_move) {
  node_path = [];
  node_path[0]["\xb0$R\x8b\xc9\x17"] = start_pos;
  node_path[0]["_ts\xfc"] = 0;
  node_path[0]["\x04\x1f\xf9.\xdbw"] = 0;
  node_path[0]["H\x86\n\x01"] = undefined;
  node_path[0]["\xd7\xdbDs[\xc9\xa1J\xc1\xdc"] = 0;
  var_14c5b9a246f45e90 = 1;
  var_40682e74165a8deb = 200;

  while(true) {
    index = node_path.size;
    assert(node_path.size < 100, "<dev string:x214>" + start_pos);
    next_node = undefined;

    if(var_14c5b9a246f45e90) {
      next_node = first_node;
      var_14c5b9a246f45e90 = 0;
    } else {
      next_node = node_path[index - 1]["H\x86\n\x01"] fakeactor_node_get_next();
    }

    if(!isDefined(next_node)) {
      break;
    }

    looping_path = 0;

    if(index > 1) {
      for(node_index = 1; node_index < node_path.size - 1; node_index++) {
        if(node_path[node_index]["H\x86\n\x01"] == next_node) {
          looping_path = 1;
          break;
        }
      }

      if(looping_path) {
        node_path[index]["_ts\xfc"] = 0;
        node_path[index]["H\x86\n\x01"] = next_node;
        node_path[index]["\x94\x17\xae~\x1c\x9f\xe5"] = 1;
        node_path[index]["\xb0$R\x8b\xc9\x17"] = next_node.origin;
        node_path[index]["\xc5\x94\x82H\x9a`"] = next_node fakeactor_node_get_angles(frantic);
        to_next_node = next_node.origin - node_path[index - 1]["\xb0$R\x8b\xc9\x17"];
        node_path[index - 1]["_ts\xfc"] = length(to_next_node);
        node_path[index - 1][":\xbd\xd7\xe6\x95\x87t_\xe6o\x91\xac"] = vectorNormalize(to_next_node);
        break;
      }
    }

    node_path[index]["H\x86\n\x01"] = next_node;
    node_origin = next_node.origin;

    if(isDefined(next_node.radius)) {
      assert(next_node.radius > 0);

      if(!isDefined(self.dronerunoffset)) {
        self.dronerunoffset = -1 + randomfloat(2);
      }

      if(!isDefined(next_node.angles)) {
        next_node.angles = (0, 0, 0);
      }

      forwardvec = anglesToForward(next_node.angles);
      rightvec = anglestoright(next_node.angles);
      upvec = anglestoup(next_node.angles);
      relativeoffset = (0, self.dronerunoffset * next_node.radius, 0);
      node_origin += forwardvec * relativeoffset[0];
      node_origin += rightvec * relativeoffset[1];
      node_origin += upvec * relativeoffset[2];
    }

    node_path[index]["\xb0$R\x8b\xc9\x17"] = node_origin;
    node_path[index]["\xc5\x94\x82H\x9a`"] = next_node fakeactor_node_get_angles(frantic);

    if(index > 0) {
      to_next_node = node_origin - node_path[index - 1]["\xb0$R\x8b\xc9\x17"];
      node_path[index - 1]["_ts\xfc"] = length(to_next_node);
      node_path[0]["\xd7\xdbDs[\xc9\xa1J\xc1\xdc"] = node_path[0]["\xd7\xdbDs[\xc9\xa1J\xc1\xdc"] + node_path[index - 1]["_ts\xfc"];
      node_path[index - 1][":\xbd\xd7\xe6\x95\x87t_\xe6o\x91\xac"] = vectorNormalize(to_next_node);

      if(isDefined(next_node.radius)) {
        node_path[index - 1]["\x04\x1f\xf9.\xdbw"] = next_node.radius;
      } else {
        node_path[index - 1]["\x04\x1f\xf9.\xdbw"] = var_40682e74165a8deb;
      }
    }

    var_1c748101e6404923 = wants_to_move && index == 1;

    if(next_node fakeactor_node_is_end_path(var_1c748101e6404923)) {
      break;
    }
  }

  node_path[index]["_ts\xfc"] = 0;
  node_path[index]["\x04\x1f\xf9.\xdbw"] = 0;
  node_path[index][":\xbd\xd7\xe6\x95\x87t_\xe6o\x91\xac"] = node_path[index - 1][":\xbd\xd7\xe6\x95\x87t_\xe6o\x91\xac"];
  return node_path;
}

function fakeactor_node_is_valid() {
  if(isDefined(self.disabled)) {
    return false;
  }

  return true;
}

function fakeactor_node_is_end_path(wants_to_move) {
  if(fakeactor_node_is_animation() && !wants_to_move) {
    return true;
  }

  if(fakeactor_node_is_traverse() && !wants_to_move) {
    return true;
  }

  if(fakeactor_node_is_turn() && !wants_to_move) {
    return true;
  }

  if(fakeactor_node_get_valid_count() == 0) {
    return true;
  }

  if(fakeactor_node_is_passthrough()) {
    return false;
  }

  if(fakeactor_node_is_wait() && wants_to_move) {
    return false;
  }

  return true;
}

function fakeactor_node_set_disabled(disabled) {
  if(disabled) {
    self.disabled = 1;
    return;
  }

  self.disabled = undefined;
}

function fakeactor_node_group_set_disabled(node_group, disabled) {
  if(isDefined(level.fakeactor_node_group[node_group])) {
    foreach(fakeactor_node in level.fakeactor_node_group[node_group]) {
      fakeactor_node fakeactor_node_set_disabled(disabled);
    }
  }
}

function fakeactor_node_set_path_claimed(ent) {
  self.path_claimed = ent;
}

function fakeactor_node_clear_path_claimed() {
  self.path_claimed = undefined;
}

function fakeactor_node_set_claimed(ent) {
  self.node_claimed[self.node_claimed.size] = ent;
}

function fakeactor_node_is_claimed_by(checked_ent) {
  if(self.node_claimed.size <= 0) {
    return false;
  }

  foreach(ent in self.node_claimed) {
    if(ent == checked_ent) {
      return true;
    }
  }

  return false;
}

function fakeactor_node_remove_claimed(removed_ent) {
  new_array = [];

  foreach(ent in self.node_claimed) {
    if(ent != removed_ent) {
      new_array[new_array.size] = ent;
    }
  }

  self.node_claimed = new_array;
}

function fakeactor_node_clear_claimed() {
  self.node_claimed = [];
}

function fakeactor_node_set_wait() {
  self.wait_state = 0;
}

function fakeactor_node_set_locked() {
  self.wait_state = 1;
}

function fakeactor_node_set_passthrough() {
  self.wait_state = 2;
}

function fakeactor_node_is_wait() {
  return self.wait_state == 0;
}

function fakeactor_node_is_locked() {
  return self.wait_state == 1;
}

function fakeactor_node_is_passthrough() {
  return self.wait_state == 2;
}

function fakeactor_node_is_on_moving_platform() {
  return isDefined(self.ground_ent);
}

function fakeactor_node_is_disabled() {
  return isDefined(self.disabled);
}

function fakeactor_node_is_turn() {
  return self.script_fakeactor_node == "\x03\x9c\xb4\xa2";
}

function fakeactor_node_is_traverse() {
  return self.script_fakeactor_node == "\x0eq\x9e\b\xf4\xd9*Y" && isDefined(self.traverse_animscript);
}

function fakeactor_node_is_animation() {
  return self.script_fakeactor_node == "a\x9b\x96\xda\xb0:\x96\xde\xb9";
}

function fakeactor_node_allow_exits() {
  return !(self.spawnflags & 128);
}

function fakeactor_node_allow_arrivals() {
  return !(self.spawnflags & 256);
}

function fakeactor_node_debug() {
  setdvarifuninitialized(@ "hash_4d695f34fb13688a", 0);
  fakeactor_nodes = level.struct_fakeactors;
  waitframe();
  text_scale = 0.5;
  new_line = 11 * text_scale;
  debug_info = [];
  debug_info["<dev string:x244>"]["<dev string:x252>"] = (0.5, 0.35, 0);
  debug_info["<dev string:x244>"]["<dev string:x25b>"] = 32;
  debug_info["<dev string:x263>"]["<dev string:x252>"] = (0.425, 0.425, 0.05);
  debug_info["<dev string:x263>"]["<dev string:x25b>"] = 32;
  debug_info["<dev string:x272>"]["<dev string:x252>"] = (0, 0.27, 0.33);
  debug_info["<dev string:x272>"]["<dev string:x25b>"] = 32;
  debug_info["<dev string:x281>"]["<dev string:x252>"] = (0, 0.46, 0.36);
  debug_info["<dev string:x281>"]["<dev string:x25b>"] = 32;
  debug_info["<dev string:x291>"]["<dev string:x252>"] = (0.5, 0, 0.5);
  debug_info["<dev string:x291>"]["<dev string:x25b>"] = 16;
  debug_info["<dev string:x299>"]["<dev string:x252>"] = (0.55, 0.45, 0.1);
  debug_info["<dev string:x299>"]["<dev string:x25b>"] = 16;
  debug_info["<dev string:x2a1>"]["<dev string:x252>"] = (0.15, 0.55, 0.35);
  debug_info["<dev string:x2a1>"]["<dev string:x25b>"] = 16;
  debug_info["<dev string:x2ad>"]["<dev string:x252>"] = (0.45, 0.2, 0.1);
  debug_info["<dev string:x2ad>"]["<dev string:x25b>"] = 16;

  while(true) {
    if(getDvar(@ "hash_4d695f34fb13688a") == "<dev string:x2ba>") {
      cam_angles = level.player getplayerangles();
      cam_up = anglestoup(cam_angles);

      foreach(fakeactor_node in fakeactor_nodes) {
        if(distance(level.player.origin, fakeactor_node.origin) > 1024) {
          continue;
        }

        text_pos = fakeactor_node.origin;
        debug::draw_node(fakeactor_node.origin, fakeactor_node.angles, debug_info[fakeactor_node.script_fakeactor_node]["<dev string:x252>"], debug_info[fakeactor_node.script_fakeactor_node]["<dev string:x25b>"]);

        if(fakeactor_node.script_fakeactor_node != "<dev string:x291>") {
          print3d(text_pos, fakeactor_node.script_fakeactor_node, (1, 1, 1), 1, text_scale);
        }

        if(isDefined(fakeactor_node.radius)) {
          utility::draw_circle(fakeactor_node.origin, fakeactor_node.radius, (1, 0, 0), 1, 1, 1);
        }

        if(fakeactor_node fakeactor_node_is_disabled()) {
          print3d(text_pos - cam_up * new_line * -2, "<dev string:x2bf>", (1, 0, 0), 1, text_scale);
          debug::draw_node(fakeactor_node.origin, fakeactor_node.angles, (1, 0, 0), debug_info[fakeactor_node.script_fakeactor_node]["<dev string:x25b>"] * 1.1);
        }

        if(isDefined(fakeactor_node.path_claimed)) {
          print3d(text_pos - cam_up * new_line * -1, "<dev string:x2cb>", (0, 1, 1), 1, text_scale);
          line(fakeactor_node.origin, fakeactor_node.path_claimed.origin, (0.5, 0.5, 1), 1, 0, 1);
        }

        if(isDefined(fakeactor_node.traverse_animscript)) {
          print3d(text_pos - cam_up * new_line * 1, "<dev string:x2db>" + fakeactor_node.traverse_animscript, (1, 1, 1), 1, text_scale);
        } else if(isDefined(fakeactor_node.animation)) {
          print3d(text_pos - cam_up * new_line * 1, "<dev string:x2e5>" + fakeactor_node.animation, (1, 1, 1), 1, text_scale);
        }

        if(isDefined(fakeactor_node.ground_ent)) {
          fakeactor_node fakeactor_node_update();
          print3d(text_pos - cam_up * new_line * 2, "<dev string:x2ef>", (1, 1, 0), 1, text_scale);
          line(fakeactor_node.origin, fakeactor_node.ground_ent.origin, (1, 1, 0), 0.5, 1, 1);
        }

        if(isDefined(fakeactor_node.script_parameters)) {
          print3d(text_pos - cam_up * new_line * 3, "<dev string:x305>" + fakeactor_node.script_parameters, (1, 1, 1), 1, text_scale);
        }

        if(isDefined(fakeactor_node.end_origin)) {
          line(fakeactor_node.origin, fakeactor_node.end_origin, (0.5, 1, 0.5), 0.5, 1, 1);
          debug::draw_node(fakeactor_node.end_origin, fakeactor_node.end_angles, 0.5 * debug_info[fakeactor_node.script_fakeactor_node]["<dev string:x252>"], debug_info[fakeactor_node.script_fakeactor_node]["<dev string:x25b>"] * 1.1);
        }

        if(isDefined(fakeactor_node.target)) {
          connected_nodes = utility::getStructArray(fakeactor_node.target, "<dev string:x311>");

          if(connected_nodes.size) {
            foreach(this_node in connected_nodes) {
              start_pos = fakeactor_node.origin;

              if(isDefined(fakeactor_node.end_origin)) {
                start_pos = fakeactor_node.end_origin;
              }

              if(this_node fakeactor_node_is_valid()) {
                line(start_pos, this_node.origin, (0, 1, 0), 1, 1, 1);
                continue;
              }

              line(start_pos, this_node.origin, (1, 0, 0), 1, 1, 1);
            }
          }
        }
      }
    }

    waitframe();
  }
}

# /