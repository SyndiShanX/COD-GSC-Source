/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_fxanim.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;

fxanim_init() {
  flag_init("fxanim_setup_complete");
  a_fxanims = getentarray("fxanim", "script_noteworthy");

  foreach(m_fxanim in a_fxanims) {
    m_fxanim disableclientlinkto();
    m_fxanim _fxanim_check_cheap_entity_flag();

    if(isDefined(m_fxanim.fxanim_parent)) {
      m_fxanim thread _fxanim_link_child_model();
      continue;
    }

    m_fxanim thread _fxanim_setup_parent();
  }

  level notify("_fxanim_parents_initialized");
  wait 0.05;
  flag_set("fxanim_setup_complete");
}

_fxanim_setup_parent() {
  struct_or_ent = self;

  if(is_true(self.fxanim_hide)) {
    struct_or_ent = spawnstruct();
    self _fxanim_copy_kvps(struct_or_ent);
    self delete();
  }

  struct_or_ent thread _fxanim_think();
}

_fxanim_think() {
  self endon("fxanim_delete");
  self _fxanim_wait();
  m_fxanim = self;
  b_is_struct = is_true(self.fxanim_hide);

  if(b_is_struct) {
    m_fxanim = spawn("script_model", self.origin);
    self _fxanim_copy_kvps(m_fxanim);
  }

  self notify("fxanim_start");

  if(b_is_struct)
    self structdelete();

  b_is_struct = undefined;
  m_fxanim _fxanim_play_anim_sequence();
}

#using_animtree("fxanim_props");

_fxanim_play_anim_sequence() {
  self useanimtree(#animtree);
  n_anim_count = self _fxanim_get_anim_count();

  for(n_current_anim = 0; n_current_anim < n_anim_count; n_current_anim++) {
    str_scene = self _fxanim_get_scene_name(n_current_anim);

    if(!self _fxanim_modifier(str_scene)) {
      str_scene = _fxanim_prep_if_looping(str_scene, n_current_anim);
      self thread _preprocess_notetracks(str_scene, "fxanim_props");
      self _fxanim_animate(str_scene);
      self _fxanim_play_fx();
    }

    self _fxanim_change_anim(n_current_anim);
  }
}

_fxanim_modifier(str_scene) {
  switch (str_scene) {
    case "delete":
      self delete();
      break;
    case "hide":
      self _fxanim_hide_tag_modifier();
      break;
    default:
      return false;
      break;
  }

  return true;
}

_fxanim_hide_tag_modifier() {
  assert(isDefined(self.fxanim_tag), "FXAnim at " + self.origin + " has an fxanim_scene of hide, but no fxanim_tag specified.");
  self hidepart(self.fxanim_tag);
  self notify("fxanim hiding tag");
}

_fxanim_wait() {
  self endon("fxanim_delete");

  if(isDefined(self.fxanim_waittill_1)) {
    if(isDefined(self.fxanim_waittill_1))
      _fxanim_change_anim(-1);
  }

  if(isDefined(self.fxanim_waittill_flag))
    flag_wait(self.fxanim_waittill_flag);

  if(isDefined(self.fxanim_wait))
    wait(self.fxanim_wait);
  else if(isDefined(self.fxanim_wait_min) && isDefined(self.fxanim_wait_max)) {
    n_wait_time = randomfloatrange(self.fxanim_wait_min, self.fxanim_wait_max);
    wait(n_wait_time);
  }
}

_fxanim_change_anim(n_fxanim_id) {
  if(!isDefined(n_fxanim_id) || n_fxanim_id != -1)
    self endon("fxanim_delete");

  str_waittill = undefined;

  if(n_fxanim_id == -1 && isDefined(self.fxanim_waittill_1))
    str_waittill = self.fxanim_waittill_1;
  else if(n_fxanim_id == 0 && isDefined(self.fxanim_waittill_2))
    str_waittill = self.fxanim_waittill_2;
  else if(n_fxanim_id == 1 && isDefined(self.fxanim_waittill_3))
    str_waittill = self.fxanim_waittill_3;

  if(!isDefined(str_waittill) && n_fxanim_id != -1)
    self _fxanim_wait_for_anim_to_end(n_fxanim_id);
  else {
    a_changer = strtok(str_waittill, "_");

    if(a_changer[0] == "damage") {
      is_ready_to_change = 0;

      while(!is_ready_to_change) {
        self setcandamage(1);
        self.health = 9999;
        self waittill("damage", undefined, undefined, undefined, undefined, str_mod);

        if(a_changer.size > 1) {
          switch (str_mod) {
            case "MOD_PISTOL_BULLET":
            case "MOD_RIFLE_BULLET":
              if(isinarray(a_changer, "bullet"))
                is_ready_to_change = 1;

              break;
            case "MOD_BAYONET":
            case "MOD_MELEE":
              if(isinarray(a_changer, "melee"))
                is_ready_to_change = 1;

              break;
            case "MOD_PROJECTILE":
              if(isinarray(a_changer, "projectile"))
                is_ready_to_change = 1;
              else if(!isinarray(a_changer, "explosive")) {
                break;
              }
            case "MOD_EXPLOSIVE":
            case "MOD_GRENADE":
              if(isinarray(a_changer, "explosive"))
                is_ready_to_change = 1;

              break;
            case "MOD_GRENADE_SPLASH":
            case "MOD_PROJECTILE_SPLASH":
              if(isinarray(a_changer, "splash"))
                is_ready_to_change = 1;

              break;
            default:
              break;
          }
        } else
          is_ready_to_change = 1;
      }
    } else {
      a_changer = undefined;
      level waittill(str_waittill);
    }
  }
}

_fxanim_wait_for_anim_to_end(n_fxanim_id) {
  self endon("fxanim_delete");
  str_scene = _fxanim_get_scene_name(n_fxanim_id);

  if(issubstr(str_scene, "_loop"))
    self waittillmatch("looping anim", "end");
  else
    self waittillmatch("single anim", "end");
}

_fxanim_animate(str_scene) {
  e_align = undefined;

  if(isDefined(self.fxanim_align)) {
    e_align = getent(self.fxanim_align, "targetname");

    if(!isDefined(e_align))
      e_align = get_struct(self.fxanim_align);
  }

  if(isDefined(e_align) && !isDefined(e_align.angles))
    e_align.angles = (0, 0, 0);

  if(issubstr(str_scene, "_loop")) {
    if(isDefined(e_align))
      e_align thread anim_loop_aligned(self, str_scene, undefined, "stop_loop", "fxanim_props");
    else
      self thread anim_loop(self, str_scene, "stop_loop", "fxanim_props");
  } else if(isDefined(e_align))
    e_align thread anim_single_aligned(self, str_scene, undefined, "fxanim_props");
  else
    self thread anim_single(self, str_scene, "fxanim_props");
}

_fxanim_play_fx() {
  if(isDefined(self.fxanim_fx_1)) {
    assert(isDefined(self.fxanim_fx_1_tag), "KVP fxanim_fx_1_tag must be set on fxanim at " + self.origin);
    playfxontag(getfx(self.fxanim_fx_1), self, self.fxanim_fx_1_tag);
  }

  if(isDefined(self.fxanim_fx_2)) {
    assert(isDefined(self.fxanim_fx_2_tag), "KVP fxanim_fx_2_tag must be set on fxanim at " + self.origin);
    playfxontag(getfx(self.fxanim_fx_2), self, self.fxanim_fx_2_tag);
  }

  if(isDefined(self.fxanim_fx_3)) {
    assert(isDefined(self.fxanim_fx_3_tag), "KVP fxanim_fx_3_tag must be set on fxanim at " + self.origin);
    playfxontag(getfx(self.fxanim_fx_3), self, self.fxanim_fx_3_tag);
  }

  if(isDefined(self.fxanim_fx_4)) {
    assert(isDefined(self.fxanim_fx_4_tag), "KVP fxanim_fx_4_tag must be set on fxanim at " + self.origin);
    playfxontag(getfx(self.fxanim_fx_4), self, self.fxanim_fx_4_tag);
  }

  if(isDefined(self.fxanim_fx_5)) {
    assert(isDefined(self.fxanim_fx_5_tag), "KVP fxanim_fx_5_tag must be set on fxanim at " + self.origin);
    playfxontag(getfx(self.fxanim_fx_5), self, self.fxanim_fx_5_tag);
  }
}

_fxanim_get_anim_count() {
  assert(isDefined(self.fxanim_scene_1), "fxanim at position " + self.origin + " needs at least one scene defined.Use the KVP fxanim_scene_1");
  n_fx_count = 0;

  if(!isDefined(self.fxanim_scene_2))
    n_fx_count = 1;
  else if(!isDefined(self.fxanim_scene_3))
    n_fx_count = 2;
  else
    n_fx_count = 3;

  return n_fx_count;
}

_fxanim_get_scene_name(n_anim_id) {
  str_scene_name = undefined;

  switch (n_anim_id) {
    case 0:
      str_scene_name = self.fxanim_scene_1;
      break;
    case 1:
      str_scene_name = self.fxanim_scene_2;
      break;
    case 2:
      str_scene_name = self.fxanim_scene_3;
      break;
  }

  return str_scene_name;
}

_fxanim_prep_if_looping(str_scene_name, n_anim_id) {
  is_anim_loop = isanimlooping(level.scr_anim["fxanim_props"][str_scene_name]);

  if(is_anim_loop) {
    level.scr_anim["fxanim_props"][str_scene_name + "_loop"][0] = level.scr_anim["fxanim_props"][str_scene_name];
    str_scene_name = str_scene_name + "_loop";

    switch (n_anim_id) {
      case 0:
        self.fxanim_scene_1 = str_scene_name;
        break;
      case 1:
        self.fxanim_scene_2 = str_scene_name;
        break;
      case 2:
        self.fxanim_scene_3 = str_scene_name;
        break;
    }
  }

  return str_scene_name;
}

_fxanim_is_anim_looping(fxanim_scene) {
  is_anim_loop = isanimlooping(level.scr_anim["fxanim_props"][fxanim_scene]);
  return is_anim_loop;
}

_fxanim_check_cheap_entity_flag() {
  if(isDefined(self.fxanim_not_cheap) && self.fxanim_not_cheap)
    self ignorecheapentityflag(1);
}

_fxanim_link_child_model() {
  assert(isDefined(self.fxanim_tag), "Model at origin " + self.origin + " needs an fxanim_tag defined, to show which tag the model will link to");
  level waittill("_fxanim_parents_initialized");
  obj_parent = _fxanim_get_parent_object(self.fxanim_parent);
  b_parent_is_model = isDefined(obj_parent.classname) && obj_parent.classname == "script_model";
  str_model_parent = obj_parent _fxanim_get_parent_model_name(b_parent_is_model);
  b_hide_child = isDefined(self.fxanim_hide);
  obj_parent endon("fxanim_delete");
  waittill_asset_loaded("xmodel", str_model_parent);
  str_model_parent = undefined;
  b_should_hide_tag = isDefined(obj_parent.fxanim_tag) && obj_parent.fxanim_tag == self.fxanim_tag;
  b_can_attach = obj_parent _fxanim_can_attach_model();

  if(b_can_attach) {
    str_model_child = self.model;
    str_tag = self.fxanim_tag;
    obj_parent _fxanim_add_attached_model(str_model_child, str_tag);
    self delete();

    if(b_parent_is_model)
      obj_parent attach(str_model_child, str_tag);
  } else if(!b_can_attach && b_parent_is_model)
    self linkto(obj_parent, self.fxanim_tag);

  if(b_hide_child) {
    if(b_can_attach) {
      if(b_parent_is_model)
        obj_parent detach(str_model_child, str_tag);
    } else
      self hide();

    obj_parent waittill("fxanim_start");

    if(!b_parent_is_model)
      obj_parent = get_ent(obj_parent.targetname, "targetname");

    if(b_can_attach)
      obj_parent attach(str_model_child, str_tag);
    else {
      if(!b_parent_is_model)
        self linkto(obj_parent, self.fxanim_tag);

      self show();
    }
  } else {
    obj_parent waittill("fxanim_start");

    if(!b_parent_is_model)
      obj_parent = get_ent(obj_parent.targetname, "targetname");

    if(b_can_attach) {
      if(!b_parent_is_model)
        obj_parent attach(str_model_child, str_tag);
    } else
      self linkto(obj_parent, self.fxanim_tag);
  }

  if(b_should_hide_tag) {
    obj_parent waittill("fxanim hiding tag");

    if(isDefined(self))
      self delete();
  }
}

_fxanim_get_parent_model_name(b_parent_is_model) {
  if(b_parent_is_model)
    str_model = self.model;
  else
    str_model = self.model_name;

  return str_model;
}

_fxanim_get_parent_object(str_targetname) {
  parent_object = get_ent(str_targetname, "targetname");

  if(!isDefined(parent_object))
    parent_object = get_struct(str_targetname, "targetname");

  assert(isDefined(parent_object), "Model at origin " + self.origin + " does not have a proper parent.Make sure the fxanim_parent matches the targetname of the fxanim");
  return parent_object;
}

_fxanim_can_attach_model() {
  if(!isDefined(self.a_attached_models))
    self.a_attached_models = [];

  return self.a_attached_models.size < 4;
}

_fxanim_add_attached_model(str_model_child, str_tag) {
  s_attached_model = spawnstruct();
  s_attached_model.str_model_child = str_model_child;
  s_attached_model.str_tag = str_tag;
  self.a_attached_models[self.a_attached_models.size] = s_attached_model;
}

_preprocess_notetracks(str_scene, str_animname) {
  animation = get_anim(str_scene, str_animname);
  waittill_asset_loaded("xanim", string(animation));
  notetracks = getnotetracksindelta(animation, 0.5, 9999);

  foreach(info in notetracks) {
    str_notetrack = info[1];
    str_notetrack_no_comment = strtok(str_notetrack, "#")[0];
    a_tokens = strtok(str_notetrack_no_comment, " ");

    switch (a_tokens[0]) {
      case "exploder":
        n_exploder = int(a_tokens[1]);
        addnotetrack_exploder(str_animname, str_notetrack, n_exploder, str_scene);
        break;
      case "stop_exploder":
        n_exploder = int(a_tokens[1]);
        addnotetrack_exploder(str_animname, str_notetrack, n_exploder, str_scene);
        break;
    }
  }

  notetracks = undefined;
  a_tokens = undefined;
  info = undefined;
}

struct_add_to_level_array(s_target, str_key) {
  if(str_key == "targetname") {
    assert(isDefined(s_target.targetname), "targetname parameter missing from struct ");
    _struct_add_to_level_array_internal("targetname", s_target.targetname, s_target);
  } else if(str_key == "script_noteworthy") {
    assert(isDefined(s_target.script_noteworthy), "script_noteworthy parameter missing from struct");
    _struct_add_to_level_array_internal("script_noteworthy", s_target.script_noteworthy, s_target);
  } else {
    assertmsg(str_key + " is not a supported str_key for struct_add_to_level_array. Available options: targetname, script_noteworthy.");

  }
}

_struct_add_to_level_array_internal(str_key, str_value, s_target) {
  if(!isDefined(level.struct_class_names[str_key][str_value]))
    level.struct_class_names[str_key][str_value] = [];

  level.struct_class_names[str_key][str_value][level.struct_class_names[str_key][str_value].size] = s_target;
}

_fxanim_copy_kvps(target) {
  if(isDefined(self.script_noteworthy)) {
    target.script_noteworthy = self.script_noteworthy;

    if(!(isDefined(target.classname) && target.classname == "script_model"))
      struct_add_to_level_array(target, "script_noteworthy");
  }

  if(isDefined(self.targetname)) {
    target.targetname = self.targetname;

    if(!(isDefined(target.classname) && target.classname == "script_model"))
      struct_add_to_level_array(target, "targetname");
  }

  if(isDefined(self.script_string))
    target.script_string = self.script_string;

  if(isDefined(self.origin))
    target.origin = self.origin;

  if(isDefined(self.angles))
    target.angles = self.angles;

  if(isDefined(self.model))
    target.model_name = self.model;

  if(isDefined(self.model_name)) {
    if(isDefined(target.classname) && target.classname == "script_model")
      target setmodel(self.model_name);
  }

  if(isDefined(self.a_fxanim_child_models))
    target.a_fxanim_child_models = self.a_fxanim_child_models;

  if(isDefined(self.fxanim_scene_1))
    target.fxanim_scene_1 = self.fxanim_scene_1;

  if(isDefined(self.fxanim_scene_2))
    target.fxanim_scene_2 = self.fxanim_scene_2;

  if(isDefined(self.fxanim_scene_3))
    target.fxanim_scene_3 = self.fxanim_scene_3;

  if(isDefined(self.fxanim_waittill))
    target.fxanim_waittill = self.fxanim_waittill;

  if(isDefined(self.fxanim_waittill_1))
    target.fxanim_waittill_1 = self.fxanim_waittill_1;

  if(isDefined(self.fxanim_waittill_2))
    target.fxanim_waittill_2 = self.fxanim_waittill_2;

  if(isDefined(self.fxanim_waittill_3))
    target.fxanim_waittill_3 = self.fxanim_waittill_3;

  if(isDefined(self.fxanim_waittill_flag))
    target.fxanim_waittill_flag = self.fxanim_waittill_flag;

  if(isDefined(self.fxanim_fx_1))
    target.fxanim_fx_1 = self.fxanim_fx_1;

  if(isDefined(self.fxanim_fx_2))
    target.fxanim_fx_2 = self.fxanim_fx_2;

  if(isDefined(self.fxanim_fx_3))
    target.fxanim_fx_3 = self.fxanim_fx_3;

  if(isDefined(self.fxanim_fx_4))
    target.fxanim_fx_4 = self.fxanim_fx_4;

  if(isDefined(self.fxanim_fx_5))
    target.fxanim_fx_5 = self.fxanim_fx_5;

  if(isDefined(self.fxanim_fx_1_tag))
    target.fxanim_fx_1_tag = self.fxanim_fx_1_tag;

  if(isDefined(self.fxanim_fx_2_tag))
    target.fxanim_fx_2_tag = self.fxanim_fx_2_tag;

  if(isDefined(self.fxanim_fx_3_tag))
    target.fxanim_fx_3_tag = self.fxanim_fx_3_tag;

  if(isDefined(self.fxanim_fx_4_tag))
    target.fxanim_fx_4_tag = self.fxanim_fx_4_tag;

  if(isDefined(self.fxanim_5_tag))
    target.fxanim_fx_5_tag = self.fxanim_fx_5_tag;

  if(isDefined(self.fxanim_parent))
    target.fxanim_parent = self.fxanim_parent;

  if(isDefined(self.fxanim_tag))
    target.fxanim_tag = self.fxanim_tag;

  if(isDefined(self.fxanim_speed))
    target.fxanim_speed = self.fxanim_speed;

  if(isDefined(self.fxanim_align))
    target.fxanim_align = self.fxanim_align;

  if(isDefined(self.fxanim_wait))
    target.fxanim_wait = self.fxanim_wait;

  if(isDefined(self.fxanim_wait_min))
    target.fxanim_wait_min = self.fxanim_wait_min;

  if(isDefined(self.fxanim_wait_max))
    target.fxanim_wait_max = self.fxanim_wait_max;

  if(isDefined(self.fxanim_hide))
    target.fxanim_hide = self.fxanim_hide;

  if(isDefined(self.fxanim_scene_1_loop))
    target.fxanim_scene_1_loop = self.fxanim_scene_1_loop;

  if(isDefined(self.fxanim_scene_2_loop))
    target.fxanim_scene_2_loop = self.fxanim_scene_2_loop;

  if(isDefined(self.fxanim_3_loop))
    target.fxanim_3_loop = self.fxanim_3_loop;

  if(isDefined(self.fxanim_fx))
    target.fxanim_fx = self.fxanim_fx;

  if(isDefined(self.fxanim_not_cheap))
    target.fxanim_not_cheap = self.fxanim_not_cheap;

  if(isDefined(self.a_attached_models))
    target.a_attached_models = self.a_attached_models;
}

fxanim_delete(str_script_string, b_assert_if_missing) {
  if(!isDefined(b_assert_if_missing))
    b_assert_if_missing = 0;

  assert(isDefined(str_script_string), "str_script_string is a required argument for fxanim_delete");
  a_fxanims = arraycombine(getentarray("fxanim", "script_noteworthy"), getstructarray("fxanim", "script_noteworthy"), 0, 0);
  n_delete_counter = 0;

  foreach(object in a_fxanims) {
    if(isDefined(object.script_string) && object.script_string == str_script_string) {
      n_delete_counter++;
      object notify("fxanim_delete");

      if(isDefined(object.classname) && object.classname == "script_model") {
        object delete();
        continue;
      }

      object structdelete();
    }
  }

  if(b_assert_if_missing)
    assert(n_delete_counter > 0, "fxanim_delete could not find any fxanim objects with script_string " + str_script_string);
}

fxanim_deconstruct(str_fxanim) {
  flag_wait("fxanim_setup_complete");
  a_m_parent_fxanim = getentarray(str_fxanim, "targetname");
  assert(a_m_parent_fxanim.size > 0, "FX anim parent entity not found, make sure the parent entity has a targetname.");
  a_fxanims = getentarray("fxanim", "script_noteworthy");

  foreach(m_parent_fxanim in a_m_parent_fxanim) {
    m_parent_fxanim notify("fxanim_delete");
    s_parent_fxanim = spawnstruct();
    m_parent_fxanim _fxanim_copy_kvps(s_parent_fxanim);
    m_parent_fxanim delete();
    a_child_fxanims = [];

    for(i = a_fxanims.size - 1; i > 0; i--) {
      if(isDefined(a_fxanims[i].fxanim_parent) && a_fxanims[i].fxanim_parent == str_fxanim) {
        s_child = spawnstruct();
        a_fxanims[i] _fxanim_copy_kvps(s_child);
        a_fxanims[i] delete();
        a_child_fxanims = add_to_array(a_child_fxanims, s_child, 1);
      }
    }

    if(a_child_fxanims.size > 0)
      s_parent_fxanim.a_child_fxanims = a_child_fxanims;
  }
}

fxanim_reconstruct(str_fxanim) {
  flag_wait("fxanim_setup_complete");
  a_s_parent_fxanim = getstructarray(str_fxanim, "targetname");
  assert(a_s_parent_fxanim.size > 0, "FX anim parent struct not found, make sure deconstruct was called for this FX anim.");

  foreach(s_parent_fxanim in a_s_parent_fxanim) {
    m_parent_fxanim = spawn("script_model", s_parent_fxanim.origin);
    s_parent_fxanim _fxanim_copy_kvps(m_parent_fxanim);
    s_parent_fxanim structdelete();

    if(isDefined(m_parent_fxanim.a_attached_models)) {
      foreach(s_attachment in m_parent_fxanim.a_attached_models)
      m_parent_fxanim attach(s_attachment.str_model_child, s_attachment.str_tag);
    }

    m_parent_fxanim disableclientlinkto();
    m_parent_fxanim _fxanim_check_cheap_entity_flag();
    m_parent_fxanim thread _fxanim_setup_parent();

    if(isDefined(s_parent_fxanim.a_child_fxanims)) {
      foreach(s_child in s_parent_fxanim.a_child_fxanims) {
        m_child = spawn("script_model", s_child.origin);
        s_child _fxanim_copy_kvps(m_child);
        s_child structdelete();
        m_child disableclientlinkto();
        m_child _fxanim_check_cheap_entity_flag();
        m_child thread _fxanim_link_child_model();
      }
    }
  }

  level notify("_fxanim_parents_initialized");
}