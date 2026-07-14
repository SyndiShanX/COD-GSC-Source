/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_39b1f0d056a0c138.gsc
*****************************************************/

#namespace namespace_6f793d3cf96d68f;

function function_54cd64e94d7d35f(template_name) {
  if(!isDefined(level.var_e49ed3413386b126)) {
    level.var_e49ed3413386b126 = [];
  }

  if(!isDefined(level.var_e49ed3413386b126[template_name])) {
    anim_template = getscriptbundle("d\xe8\v\xcdK\xb5t\xac\xad\xe0c\x85\x8eV\xe8" + template_name);
    assert(isDefined(anim_template), "<dev string:x24>" + template_name);
    level.var_e49ed3413386b126[template_name] = anim_template;
    level.var_e49ed3413386b126[template_name].last_random = -1;
  }
}

function function_88d6e629a3116c84(template_name, position_name) {
  if(isDefined(template_name)) {
    template = level.var_e49ed3413386b126[template_name];

    foreach(pos in template.player_positions) {
      if(pos.name == position_name) {
        return pos;
      }
    }
  }

  return undefined;
}

function function_8ed66d64a89a92cd(template_name, feature) {
  if(isDefined(template_name)) {
    template = level.var_e49ed3413386b126[template_name];

    if(isDefined(template)) {
      switch (feature) {
        case #"hash_1c39674e5b0de0f3":
          if(isDefined(template.idle_shots) && template.idle_shots.size > 0) {
            return template function_3111253527a13c7c(template.idle_shots);
          } else {
            return template function_3111253527a13c7c(template.var_23b689fb9595b43f);
          }
        case #"hash_228e2e6b4608a098":
          if(isDefined(template.var_23b689fb9595b43f) && template.var_23b689fb9595b43f.size > 0) {
            return template function_3111253527a13c7c(template.var_23b689fb9595b43f);
          } else {
            return template function_3111253527a13c7c(template.idle_shots);
          }
        case #"hash_143efe6e1538f5af":
          return template function_3111253527a13c7c(template.talking_shots);
      }
    }
  }

  return undefined;
}

function function_ea78b4318e27edea(template_name) {
  if(isDefined(template_name)) {
    template = level.var_e49ed3413386b126[template_name];

    if(isDefined(template)) {
      return template.scene;
    }
  }

  return undefined;
}

function function_3111253527a13c7c(anim_arr) {
  if(isDefined(anim_arr) && isarray(anim_arr) && anim_arr.size > 0) {
    if(anim_arr.size > 1) {
      r = randomint(anim_arr.size);

      if(r == self.last_random) {
        r = r >= anim_arr.size - 1 ? 0 : r + 1;
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