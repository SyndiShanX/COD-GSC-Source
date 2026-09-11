/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\fakeactor_node.gsc
***********************************************/

function fakeactor_node_setup() {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  if(self.script_fakeactor_node == "path" || self.script_fakeactor_node == "turn") {
    self.wait_state = 2;
  } else {
    self.wait_state = 0;
  }

  switch (self.script_fakeactor_node) {
    case "traverse":
      if(isDefined(self.target)) {
        var0 = getnodearray(self.target, "targetname");

        if(!var0.size) {
          if(isDefined(self.script_linkto)) {
            var0 = getnodearray(self.script_linkto, "script_linkname");
          }
        }

        if(var0.size > 0) {
          foreach(var2 in var0) {
            if(var2.type == "Begin") {
              self.traverse_animscript = var2.animscript;
            }
          }
        }

        var4 = scripts\engine\utility::getStructArray(self.target, "targetname");

        if(isDefined(self.script_linkto)) {
          var4 = scripts\engine\utility::array_combine(var4, scripts\engine\utility::getStructArray(self.script_linkto, "script_linkname"));
        }

        foreach(var6 in var4) {
          if(isDefined(var6.animation)) {
            self.origin = var6.origin;
            self.angles = var6.angles;
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
      var8 = scripts\engine\utility::getanim_generic(self.animation);
      var9 = getstartorigin(self.origin, self.angles, var8);
      var10 = getstartangles(self.origin, self.angles, var8);
      self.origin = var9;
      self.angles = var10;
      break;
  }
}

function fakeactor_node_init_type() {
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

function fakeactor_node_init_params() {
  if(!isDefined(self.script_parameters)) {
    return;
  }

  var0 = strtok(self.script_parameters, " ");

  foreach(var2 in var0) {
    if(!isDefined(level.fakeactor_node_group[var2])) {
      level.fakeactor_node_group[var2] = [];
    }

    level.fakeactor_node_group[var2] = scripts\engine\utility::array_add(level.fakeactor_node_group[var2], self);
  }
}

function fakeactor_node_init_flags() {
  if(!isDefined(self.spawnflags)) {
    self.spawnflags = 0;
  }

  if(!(self.spawnflags & 64)) {
    var0 = 32 * anglestoup(self.angles);
    var1 = -20000 * anglestoup(self.angles);
    var2 = scripts\engine\trace::ray_trace(self.origin + var0, self.origin + var1, undefined, scripts\engine\trace::create_solid_ai_contents());

    if(var2["hittype"] == "hittype_none") {}

    self.origin = var2["position"];

    if(self.spawnflags & 32) {
      if(isDefined(var2["entity"])) {
        self.ground_ent = var2["entity"];
        self.ground_ent_offset = self.ground_ent scripts\engine\sp\utility::worldtolocalcoords(self.origin);

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

  foreach(var1 in level.struct) {
    if(isDefined(var1.script_fakeactor_node)) {
      thread fakeactor_node_setup();
    }
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
  var0 = spawn("script_origin", (0, 0, 0));
  var0.angles = self.ground_ent.angles;
  var0 addpitch(self.ground_ent_angles_offset[0]);
  var0 addyaw(self.ground_ent_angles_offset[1]);
  var0 addroll(self.ground_ent_angles_offset[2]);
  self.angles = var0.angles;
  var0 delete();
}

function fakeactor_node_get_cover_list() {
  var0 = [];
  var1 = 0;

  if(isDefined(self.spawnflags)) {
    var1 = self.spawnflags;
  }

  if(self.script_fakeactor_node == "cover_left") {
    if(!(var1 & 1)) {
      var0 = scripts\engine\utility::array_add(var0, "cover_left");
    }

    if(!(var1 & 2)) {
      var0 = scripts\engine\utility::array_add(var0, "cover_left_crouch");
    }
  } else if(self.script_fakeactor_node == "cover_right") {
    if(!(var1 & 1)) {
      var0 = scripts\engine\utility::array_add(var0, "cover_right");
    }

    if(!(var1 & 2)) {
      var0 = scripts\engine\utility::array_add(var0, "cover_right_crouch");
    }
  } else if(self.script_fakeactor_node == "cover_stand") {
    var0 = scripts\engine\utility::array_add(var0, "cover_stand");
  } else if(self.script_fakeactor_node == "cover_crouch") {
    var0 = scripts\engine\utility::array_add(var0, "cover_crouch");
  } else {
    var0 = scripts\engine\utility::array_add(var0, "exposed");
  }

  if(var0.size == 0) {}

  return var0;
}

function fakeactor_node_get_next() {
  if(!isDefined(self.target)) {
    return undefined;
  }

  var0 = fakeactor_node_get_all_valid();

  if(var0.size) {
    return scripts\engine\utility::random(var0);
  }

  return undefined;
}

function fakeactor_node_get_all_valid() {
  var0 = [];

  if(!isDefined(self.target)) {
    return var0;
  }

  var1 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var3 in var1) {
    if(!is_fakeactor_node(var3)) {
      continue;
    }

    if(!fakeactor_node_is_valid(var3)) {
      continue;
    }

    var0 = scripts\engine\utility::array_add(var0, var3);
  }

  return var0;
}

function fakeactor_node_get_valid_count() {
  if(!isDefined(self.target)) {
    return 0;
  }

  var0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var1 = 0;

  foreach(var3 in var0) {
    if(!is_fakeactor_node(var3)) {
      continue;
    }

    if(!fakeactor_node_is_valid(var3)) {
      continue;
    }

    var1++;
  }

  return var1;
}

function fakeactor_node_get_angles(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  var1 = spawn("script_origin", (0, 0, 0));

  if(isDefined(self.angles)) {
    var1.angles = self.angles;
  }

  if(isDefined(self.type)) {
    if(var0 && isDefined(anim.fa_franticnodeyaws)) {
      if(isDefined(anim.fa_franticnodeyaws[self.type])) {
        var1 addyaw(anim.fa_franticnodeyaws[self.type]);
      }
    } else if(isDefined(anim.fa_nodeyaws)) {
      if(isDefined(anim.fa_nodeyaws[self.type])) {
        var1 addyaw(anim.fa_nodeyaws[self.type]);
      }
    }
  }

  var2 = var1.angles;
  var1 delete();
  return var2;
}

function fakeactor_node_get_path(var0, var1, var2, var3) {
  var4 = [];
  GscBinSkip0(0x2e, 0, "origin", var1);
}

function fakeactor_node_is_valid() {
  if(isDefined(self.disabled)) {
    return false;
  }

  return true;
}

function fakeactor_node_is_end_path(var0) {
  if(fakeactor_node_is_animation() && !var0) {
    return true;
  }

  if(fakeactor_node_is_traverse() && !var0) {
    return true;
  }

  if(fakeactor_node_is_turn() && !var0) {
    return true;
  }

  if(fakeactor_node_get_valid_count() == 0) {
    return true;
  }

  if(fakeactor_node_is_passthrough()) {
    return false;
  }

  if(fakeactor_node_is_wait() && var0) {
    return false;
  }

  return true;
}

function fakeactor_node_set_disabled(var0) {
  if(var0) {
    self.disabled = 1;
    return;
  }

  self.disabled = undefined;
}

function fakeactor_node_group_set_disabled(var0, var1) {
  if(isDefined(level.fakeactor_node_group[var0])) {
    foreach(var3 in level.fakeactor_node_group[var0]) {
      fakeactor_node_set_disabled(var3, var1);
    }

    return;
  }
}

function fakeactor_node_set_path_claimed(var0) {
  self.path_claimed = var0;
}

function fakeactor_node_clear_path_claimed() {
  self.path_claimed = undefined;
}

function fakeactor_node_set_claimed(var0) {
  self.node_claimed[self.node_claimed.size] = var0;
}

function fakeactor_node_is_claimed_by(var0) {
  if(self.node_claimed.size <= 0) {
    return false;
  }

  foreach(var2 in self.node_claimed) {
    if(var2 == var0) {
      return true;
    }
  }

  return false;
}

function fakeactor_node_remove_claimed(var0) {
  var1 = [];

  foreach(var3 in self.node_claimed) {
    if(var3 != var0) {
      var1 = var3;
    }
  }

  self.node_claimed = var1;
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
  return self.script_fakeactor_node == "turn";
}

function fakeactor_node_is_traverse() {
  return self.script_fakeactor_node == "traverse" && isDefined(self.traverse_animscript);
}

function fakeactor_node_is_animation() {
  return self.script_fakeactor_node == "animation";
}

function fakeactor_node_allow_exits() {
  return !(self.spawnflags & 128);
}

function fakeactor_node_allow_arrivals() {
  return !(self.spawnflags & 256);
}

function fakeactor_node_debug() {}