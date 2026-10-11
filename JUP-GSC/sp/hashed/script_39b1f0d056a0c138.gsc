/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_39b1f0d056a0c138.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_f13e1c376c4ed4d6;

function function_efafec9a80234daa(template_name) {
  if(!isDefined(level.var_2d50d527b0001797)) {
    level.var_2d50d527b0001797 = [];
  }

  if(!isDefined(level.var_2d50d527b0001797[template_name])) {
    anim_template = getscriptbundle("dtanimtemplate:" + template_name);
    assertex(isDefined(anim_template), "ERROR: Attempting to use undefined dialog tree animation template: " + template_name);
    level.var_2d50d527b0001797[template_name] = anim_template;
    level.var_2d50d527b0001797[template_name].last_random = -1;
  }
}

function function_1d41e14159f8de35(template_name, position_name) {
  if(isDefined(template_name)) {
    template = level.var_2d50d527b0001797[template_name];

    foreach(pos in template.player_positions) {
      if(pos.name == position_name) {
        return pos;
      }
    }
  }

  return undefined;
}

function function_7dc5dc6ca7fc72c4(template_name, feature) {
  if(isDefined(template_name)) {
    template = level.var_2d50d527b0001797[template_name];

    if(isDefined(template)) {
      switch (feature) {
        case #"hash_1c39674e5b0de0f3":
          if(isDefined(template.idle_shots) && template.idle_shots.size > 0) {
            return template function_ee798af1fbe1bf55(template.idle_shots);
          } else {
            return template function_ee798af1fbe1bf55(template.var_1ed047e294633c0e);
          }
        case #"hash_228e2e6b4608a098":
          if(isDefined(template.var_1ed047e294633c0e) && template.var_1ed047e294633c0e.size > 0) {
            return template function_ee798af1fbe1bf55(template.var_1ed047e294633c0e);
          } else {
            return template function_ee798af1fbe1bf55(template.idle_shots);
          }
        case #"hash_143efe6e1538f5af":
          return template function_ee798af1fbe1bf55(template.talking_shots);
      }
    }
  }

  return undefined;
}

function function_d66c0bfe054fd887(template_name) {
  if(isDefined(template_name)) {
    template = level.var_2d50d527b0001797[template_name];

    if(isDefined(template)) {
      return template.scene;
    }
  }

  return undefined;
}

function function_ee798af1fbe1bf55(anim_arr) {
  if(isDefined(anim_arr) && isarray(anim_arr) && anim_arr.size > 0) {
    if(anim_arr.size > 1) {
      r = randomint(anim_arr.size);

      if(r == self.last_random) {
        r = ter_op(r >= anim_arr.size - 1, 0, r + 1);
      }

      self.last_random = r;
      return anim_arr[r].shot;
    } else {
      return anim_arr[0].shot;
    }

    return;
  }

  return undefined;
}