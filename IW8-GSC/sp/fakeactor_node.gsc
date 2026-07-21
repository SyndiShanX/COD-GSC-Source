/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\fakeactor_node.gsc
***********************************************/

fakeactor_node_setup() {
  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  if(self.script_fakeactor_node == "path" || self.script_fakeactor_node == "turn")
    self.wait_state = 2;
  else
    self.wait_state = 0;

  switch (self.script_fakeactor_node) {
    case "traverse":
      if(isDefined(self.target)) {
        var_0 = getnodearray(self.target, "targetname");

        if(!var_0.size) {
          if(isDefined(self.script_linkto))
            var_0 = getnodearray(self.script_linkto, "script_linkname");
        }

        if(var_0.size > 0) {
          foreach(var_2 in var_0) {
            if(var_2.type == "Begin")
              self.traverse_animscript = var_2.animscript;
          }
        }

        var_4 = scripts\engine\utility::getStructArray(self.target, "targetname");

        if(isDefined(self.script_linkto))
          var_4 = scripts\engine\utility::array_combine(var_4, scripts\engine\utility::getStructArray(self.script_linkto, "script_linkname"));

        foreach(var_6 in var_4) {
          if(isDefined(var_6.animation)) {
            self.origin = var_6.origin;
            self.angles = var_6.angles;
          }
        }
      }

      break;
    case "animation":
      break;
  }

  fakeactor_node_init_type();
  fakeactor_node_init_params();
  fakeactor_node_init_flags();
  waitframe();

  switch (self.script_fakeactor_node) {
    case "animation":
      self.anim_node = spawnStruct();
      self.anim_node.origin = self.origin;
      self.anim_node.angles = self.angles;
      var_8 = scripts\engine\utility::getanim_generic(self.animation);
      var_9 = getstartorigin(self.origin, self.angles, var_8);
      var_10 = getstartangles(self.origin, self.angles, var_8);
      self.origin = var_9;
      self.angles = var_10;
      break;
  }
}

fakeactor_node_init_type() {
  switch (self.script_fakeactor_node) {
    case "cover_left":
      self.type = "Cover Left";
      return;
    case "cover_right":
      self.type = "Cover Right";
      return;
    case "cover_crouch":
      self.type = "Cover Crouch";
      return;
    case "cover_stand":
      self.type = "Cover Stand";
      return;
  }
}

fakeactor_node_init_params() {
  if(!isDefined(self.script_parameters)) {
    return;
  }
  var_0 = strtok(self.script_parameters, " ");

  foreach(var_2 in var_0) {
    if(!isDefined(level.fakeactor_node_group[var_2]))
      level.fakeactor_node_group[var_2] = [];

    level.fakeactor_node_group[var_2] = scripts\engine\utility::array_add(level.fakeactor_node_group[var_2], self);
  }
}

fakeactor_node_init_flags() {
  if(!isDefined(self.spawnflags))
    self.spawnflags = 0;

  if(!(self.spawnflags & 64)) {
    var_0 = 32 * anglestoup(self.angles);
    var_1 = -20000 * anglestoup(self.angles);
    var_2 = scripts\engine\trace::ray_trace(self.origin + var_0, self.origin + var_1, undefined, scripts\engine\trace::create_solid_ai_contents());

    if(var_2["hittype"] == "hittype_none") {}

    self.origin = var_2["position"];

    if(self.spawnflags & 32) {
      if(isDefined(var_2["entity"])) {
        self.ground_ent = var_2["entity"];
        self.ground_ent_offset = self.ground_ent scripts\engine\sp\utility::worldtolocalcoords(self.origin);

        if(!isDefined(self.angles))
          self.angles = (0, 0, 0);

        self.ground_ent_angles_offset = self.angles - self.ground_ent.angles;
      }
    }
  }

  if(self.spawnflags & 8)
    fakeactor_node_set_disabled(1);

  if(self.spawnflags & 16)
    self.wait_state = 2;

  self.node_claimed = [];
}

setup_fakeactor_nodes() {
  level.fakeactor_node_group = [];

  foreach(var_1 in level.struct) {
    if(isDefined(var_1.script_fakeactor_node))
      var_1 thread fakeactor_node_setup();
  }
}

is_fakeactor_node() {
  return isDefined(self.script_fakeactor_node);
}

fakeactor_node_update() {
  if(!isDefined(self.ground_ent)) {
    return;
  }
  self.origin = self.ground_ent localtoworldcoords(self.ground_ent_offset);
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.angles = self.ground_ent.angles;
  var_0 addpitch(self.ground_ent_angles_offset[0]);
  var_0 addyaw(self.ground_ent_angles_offset[1]);
  var_0 addroll(self.ground_ent_angles_offset[2]);
  self.angles = var_0.angles;
  var_0 delete();
}

fakeactor_node_get_cover_list() {
  var_0 = [];
  var_1 = 0;

  if(isDefined(self.spawnflags))
    var_1 = self.spawnflags;

  if(self.script_fakeactor_node == "cover_left") {
    if(!(var_1 & 1))
      var_0 = scripts\engine\utility::array_add(var_0, "cover_left");

    if(!(var_1 & 2))
      var_0 = scripts\engine\utility::array_add(var_0, "cover_left_crouch");
  } else if(self.script_fakeactor_node == "cover_right") {
    if(!(var_1 & 1))
      var_0 = scripts\engine\utility::array_add(var_0, "cover_right");

    if(!(var_1 & 2))
      var_0 = scripts\engine\utility::array_add(var_0, "cover_right_crouch");
  } else if(self.script_fakeactor_node == "cover_stand")
    var_0 = scripts\engine\utility::array_add(var_0, "cover_stand");
  else if(self.script_fakeactor_node == "cover_crouch")
    var_0 = scripts\engine\utility::array_add(var_0, "cover_crouch");
  else
    var_0 = scripts\engine\utility::array_add(var_0, "exposed");

  if(var_0.size == 0) {}

  return var_0;
}

fakeactor_node_get_next() {
  if(!isDefined(self.target))
    return undefined;

  var_0 = fakeactor_node_get_all_valid();

  if(var_0.size)
    return scripts\engine\utility::random(var_0);

  return undefined;
}

fakeactor_node_get_all_valid() {
  var_0 = [];

  if(!isDefined(self.target))
    return var_0;

  var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_3 in var_1) {
    if(!var_3 is_fakeactor_node()) {
      continue;
    }
    if(!var_3 fakeactor_node_is_valid()) {
      continue;
    }
    var_0 = scripts\engine\utility::array_add(var_0, var_3);
  }

  return var_0;
}

fakeactor_node_get_valid_count() {
  if(!isDefined(self.target))
    return 0;

  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(!var_3 is_fakeactor_node()) {
      continue;
    }
    if(!var_3 fakeactor_node_is_valid()) {
      continue;
    }
    var_1++;
  }

  return var_1;
}

fakeactor_node_get_angles(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = spawn("script_origin", (0, 0, 0));

  if(isDefined(self.angles))
    var_1.angles = self.angles;

  if(isDefined(self.type)) {
    if(var_0 && isDefined(anim.fa_franticnodeyaws)) {
      if(isDefined(anim.fa_franticnodeyaws[self.type]))
        var_1 addyaw(anim.fa_franticnodeyaws[self.type]);
    } else if(isDefined(anim.fa_nodeyaws)) {
      if(isDefined(anim.fa_nodeyaws[self.type]))
        var_1 addyaw(anim.fa_nodeyaws[self.type]);
    }
  }

  var_2 = var_1.angles;
  var_1 delete();
  return var_2;
}

fakeactor_node_get_path(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0]["origin"] = var_1;
  var_4[0]["dist"] = 0;
  var_4[0]["radius"] = 0;
  var_4[0]["node"] = undefined;
  var_4[0]["total_dist"] = 0;
  var_5 = 1;
  var_6 = 200;

  for(;;) {
    var_7 = var_4.size;
    var_8 = undefined;

    if(var_5) {
      var_8 = var_0;
      var_5 = 0;
    } else
      var_8 = var_4[var_7 - 1]["node"] fakeactor_node_get_next();

    if(!isDefined(var_8)) {
      break;
    }

    var_4[var_7]["node"] = var_8;
    var_9 = var_8.origin;

    if(isDefined(var_8.radius)) {
      if(!isDefined(self.dronerunoffset))
        self.dronerunoffset = -1 + randomfloat(2);

      if(!isDefined(var_8.angles))
        var_8.angles = (0, 0, 0);

      var_10 = anglesToForward(var_8.angles);
      var_11 = anglestoright(var_8.angles);
      var_12 = anglestoup(var_8.angles);
      var_13 = (0, self.dronerunoffset * var_8.radius, 0);
      var_9 = var_9 + var_10 * var_13[0];
      var_9 = var_9 + var_11 * var_13[1];
      var_9 = var_9 + var_12 * var_13[2];
    }

    var_4[var_7]["origin"] = var_9;
    var_4[var_7]["angles"] = var_8 fakeactor_node_get_angles(var_2);

    if(var_7 > 0) {
      var_14 = var_9 - var_4[var_7 - 1]["origin"];
      var_4[var_7 - 1]["dist"] = length(var_14);
      var_4[0]["total_dist"] = var_4[0]["total_dist"] + var_4[var_7 - 1]["dist"];
      var_4[var_7 - 1]["to_next_node"] = vectorNormalize(var_14);

      if(isDefined(var_8.radius))
        var_4[var_7 - 1]["radius"] = var_8.radius;
      else
        var_4[var_7 - 1]["radius"] = var_6;
    }

    var_15 = var_3 && var_7 == 1;

    if(var_8 fakeactor_node_is_end_path(var_15)) {
      break;
    }
  }

  var_4[var_7]["dist"] = 0;
  var_4[var_7]["radius"] = 0;
  var_4[var_7]["to_next_node"] = var_4[var_7 - 1]["to_next_node"];
  return var_4;
}

fakeactor_node_is_valid() {
  if(isDefined(self.disabled))
    return 0;

  return 1;
}

fakeactor_node_is_end_path(var_0) {
  if(fakeactor_node_is_animation() && !var_0)
    return 1;

  if(fakeactor_node_is_traverse() && !var_0)
    return 1;

  if(fakeactor_node_is_turn() && !var_0)
    return 1;

  if(fakeactor_node_get_valid_count() == 0)
    return 1;

  if(fakeactor_node_is_passthrough())
    return 0;

  if(fakeactor_node_is_wait() && var_0)
    return 0;

  return 1;
}

fakeactor_node_set_disabled(var_0) {
  if(var_0)
    self.disabled = 1;
  else
    self.disabled = undefined;
}

fakeactor_node_group_set_disabled(var_0, var_1) {
  if(isDefined(level.fakeactor_node_group[var_0])) {
    foreach(var_3 in level.fakeactor_node_group[var_0])
    var_3 fakeactor_node_set_disabled(var_1);
  }
}

fakeactor_node_set_path_claimed(var_0) {
  self.path_claimed = var_0;
}

fakeactor_node_clear_path_claimed() {
  self.path_claimed = undefined;
}

fakeactor_node_set_claimed(var_0) {
  self.node_claimed[self.node_claimed.size] = var_0;
}

fakeactor_node_is_claimed_by(var_0) {
  if(self.node_claimed.size <= 0)
    return 0;

  foreach(var_2 in self.node_claimed) {
    if(var_2 == var_0)
      return 1;
  }

  return 0;
}

fakeactor_node_remove_claimed(var_0) {
  var_1 = [];

  foreach(var_3 in self.node_claimed) {
    if(var_3 != var_0)
      var_1[var_1.size] = var_3;
  }

  self.node_claimed = var_1;
}

fakeactor_node_clear_claimed() {
  self.node_claimed = [];
}

fakeactor_node_set_wait() {
  self.wait_state = 0;
}

fakeactor_node_set_locked() {
  self.wait_state = 1;
}

fakeactor_node_set_passthrough() {
  self.wait_state = 2;
}

fakeactor_node_is_wait() {
  return self.wait_state == 0;
}

fakeactor_node_is_locked() {
  return self.wait_state == 1;
}

fakeactor_node_is_passthrough() {
  return self.wait_state == 2;
}

fakeactor_node_is_on_moving_platform() {
  return isDefined(self.ground_ent);
}

fakeactor_node_is_disabled() {
  return isDefined(self.disabled);
}

fakeactor_node_is_turn() {
  return self.script_fakeactor_node == "turn";
}

fakeactor_node_is_traverse() {
  return self.script_fakeactor_node == "traverse" && isDefined(self.traverse_animscript);
}

fakeactor_node_is_animation() {
  return self.script_fakeactor_node == "animation";
}

fakeactor_node_allow_exits() {
  return !(self.spawnflags & 128);
}

fakeactor_node_allow_arrivals() {
  return !(self.spawnflags & 256);
}

fakeactor_node_debug() {}