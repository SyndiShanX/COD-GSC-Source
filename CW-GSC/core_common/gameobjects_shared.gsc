/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\gameobjects_shared.gsc
***********************************************/

#using script_1435f3c9fc699e04;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#namespace gameobjects;
class cinteractobj {
  var e_object;
  var m_a_keyline_objects;
  var m_b_allow_companion_command;
  var m_b_allow_weapons;
  var m_b_auto_reenable;
  var m_b_gameobject_scene_alignment;
  var m_b_reusable;
  var m_b_scene_use_time_override;
  var m_n_trigger_height;
  var m_n_trigger_offset;
  var m_n_trigger_radius;
  var m_n_trigger_use_time;
  var m_s_bundle;
  var m_str_anim;
  var m_str_hint;
  var m_str_identifier;
  var m_str_obj_anim;
  var m_str_objective;
  var m_str_player_scene_anim;
  var m_str_tag;
  var m_str_team;
  var m_str_trigger_type;
  var m_str_type;
  var m_t_interact;
  var m_v_tag_origin;
  var var_14f4f0bc;
  var var_15547ed4;
  var var_26a01d70;
  var var_2854e7f7;
  var var_426bccfd;
  var var_7abf2b16;
  var var_a99c4d4c;

  constructor() {
    m_str_trigger_type = "use";
  }

  function destructor() {
    if(getdvarint(#"scr_debug_gameobjects", 0)) {
      iprintlnbold("<dev string:x369>");
    }
  }

  function create_gameobject_trigger() {
    if(!isDefined(m_t_interact)) {
      if(m_str_type === "generic" || m_str_trigger_type === "proximity") {
        m_t_interact = spawn("trigger_radius", m_v_tag_origin + m_n_trigger_offset + (0, 0, m_n_trigger_height / 2), 0, m_n_trigger_radius, m_n_trigger_height, 1);
      } else {
        m_t_interact = spawn("trigger_radius_use", m_v_tag_origin + m_n_trigger_offset + (0, 0, m_n_trigger_height / 2), 0, m_n_trigger_radius, m_n_trigger_height, 1);

        if(isDefined(e_object.angles)) {
          m_t_interact.angles = e_object.angles;
        }

        m_t_interact usetriggerrequirelookat(is_true(e_object.require_look_at));
        m_t_interact usetriggerrequirelooktoward(is_true(e_object.require_look_toward));
      }
    }

    m_t_interact.trigger_offset = m_n_trigger_offset;
    m_t_interact triggerignoreteam();
    m_t_interact setvisibletoall();
    m_t_interact setcursorhint("HINT_INTERACTIVE_PROMPT");
    m_t_interact.var_a865c2cd = isDefined(m_s_bundle.var_a865c2cd) ? m_s_bundle.var_a865c2cd : 0;
    m_t_interact.str_hint = m_str_hint;

    if(m_str_team != # "any") {
      m_t_interact setteamfortrigger(m_str_team);
    }

    if(!isDefined(m_a_keyline_objects)) {
      m_a_keyline_objects = [];
    } else if(!isarray(m_a_keyline_objects)) {
      m_a_keyline_objects = array(m_a_keyline_objects);
    }

    switch (m_str_type) {
      case # "carry":
        assert(isDefined(m_a_keyline_objects[0]), "<dev string:x431>");
        mdl_gameobject = gameobjects::create_carry_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0), m_str_objective, var_26a01d70);
        break;
      case # "pack":
        assert(isDefined(m_a_keyline_objects[0]), "<dev string:x431>");
        mdl_gameobject = gameobjects::create_pack_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0), m_str_objective, var_26a01d70);
        break;
      case # "generic":
        mdl_gameobject = gameobjects::create_generic_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0));
        break;
      case # "use":
      default:
        mdl_gameobject = gameobjects::create_use_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0), m_str_objective, var_26a01d70, 0, e_object.script_enable_on_start);
        break;
    }

    mdl_gameobject.single_use = 0;

    if(m_str_type == "carry" || m_str_type == "pack") {
      mdl_gameobject.objectiveonself = 1;

      if(isDefined(mdl_gameobject.objectiveid)) {
        objective_setposition(mdl_gameobject.objectiveid, (0, 0, 0));
      }

      if(isDefined(m_s_bundle.carryicon)) {
        if(m_str_type == "carry") {
          mdl_gameobject gameobjects::set_carry_icon(m_s_bundle.carryicon);
        } else {
          mdl_gameobject gameobjects::set_pack_icon(m_s_bundle.carryicon);
        }
      }

      if(isDefined(m_s_bundle.registerline__grow)) {
        mdl_gameobject gameobjects::set_visible_carrier_model(m_s_bundle.registerline__grow);
      }

      if(is_true(m_s_bundle.droponusebutton)) {
        mdl_gameobject gameobjects::function_a8c842d6(m_s_bundle.droponusebutton, 1, 0);
      }

      if(isDefined(m_s_bundle.weapon)) {
        mdl_gameobject gameobjects::function_6e870d38(m_s_bundle.weapon);
      }
    }

    mdl_gameobject gameobjects::set_identifier(m_str_identifier);
    mdl_gameobject.origin = m_t_interact.origin;
    mdl_gameobject.angles = m_t_interact.angles;
    mdl_gameobject gameobjects::set_owner_team(m_str_team);

    if(m_str_team == # "any") {
      mdl_gameobject gameobjects::allow_use(#"group_all");
      mdl_gameobject gameobjects::set_visible(#"group_all");
    } else {
      mdl_gameobject gameobjects::allow_use(#"group_friendly");
      mdl_gameobject gameobjects::set_visible(#"group_friendly");
    }

    mdl_gameobject gameobjects::set_use_time(m_n_trigger_use_time);
    mdl_gameobject gameobjects::function_86d3b442(var_14f4f0bc);
    mdl_gameobject.str_player_scene_anim = m_str_player_scene_anim;
    mdl_gameobject.str_anim = m_str_anim;
    mdl_gameobject.b_reusable = m_b_reusable;
    mdl_gameobject.b_auto_reenable = m_b_auto_reenable;
    mdl_gameobject.allowweapons = m_b_allow_weapons;
    mdl_gameobject.b_scene_use_time_override = m_b_scene_use_time_override;
    mdl_gameobject.b_use_gameobject_for_alignment = m_b_gameobject_scene_alignment;
    mdl_gameobject.var_75ea46f6 = var_7abf2b16;
    mdl_gameobject.var_a7ef92ac = m_s_bundle.var_559e6e9f;
    mdl_gameobject.b_allow_companion_command = m_b_allow_companion_command;

    if(isDefined(m_str_obj_anim)) {
      mdl_gameobject.str_obj_anim = m_str_obj_anim;
    }

    mdl_gameobject.t_interact = m_t_interact;
    mdl_gameobject.t_interact enablelinkto();
    mdl_gameobject.e_object = e_object;

    if(isentity(mdl_gameobject.e_object)) {
      if(isDefined(m_str_tag)) {
        mdl_gameobject.t_interact linkto(mdl_gameobject.e_object, m_str_tag);
      } else {
        mdl_gameobject.t_interact linkto(mdl_gameobject.e_object);
      }
    }

    if(isDefined(mdl_gameobject.str_player_scene_anim) || isDefined(mdl_gameobject.str_anim)) {
      mdl_gameobject.dontlinkplayertotrigger = 1;
    }

    if(!mdl_gameobject.e_object flag::exists("gameobject_end_use")) {
      mdl_gameobject.e_object flag::init("gameobject_end_use");
    }

    e_object.mdl_gameobject = mdl_gameobject;
  }

  function init_game_object(str_bundle, str_team_override, str_tag_override, str_identifier_override, a_keyline_objects, t_override, b_allow_companion_command = 1, str_objective_override) {
    m_s_bundle = getscriptbundle(str_bundle);
    assert(isDefined(m_s_bundle), "<dev string:x38c>" + str_bundle + "<dev string:x3a2>");

    if(isDefined(str_tag_override)) {
      m_str_tag = str_tag_override;
    } else {
      m_str_tag = m_s_bundle.str_tag;
    }

    if(isentity(e_object)) {
      m_v_tag_origin = e_object gettagorigin(m_str_tag);
    }

    if(!isDefined(m_v_tag_origin)) {
      m_str_tag = undefined;
      m_v_tag_origin = e_object.origin;

      if(isentity(e_object)) {
        println("<dev string:x3c7>" + m_s_bundle.str_tag + "<dev string:x3dd>" + e_object.model);
      }
    }

    m_n_trigger_height = m_s_bundle.n_trigger_height;
    m_n_trigger_radius = m_s_bundle.n_trigger_radius;
    m_str_team = m_s_bundle.str_team;
    var_426bccfd = m_s_bundle.var_ce7dda5f;
    var_15547ed4 = is_true(m_s_bundle.b_play_vo);
    m_str_player_scene_anim = m_s_bundle.playerscenebundle;
    m_b_scene_use_time_override = m_s_bundle.playerscenebundletimeoverride;
    m_str_anim = m_s_bundle.viewanim;
    m_str_obj_anim = m_s_bundle.entityanim;
    m_b_reusable = m_s_bundle.b_reusable;
    m_b_auto_reenable = m_s_bundle.autoreenable;
    m_str_identifier = m_s_bundle.str_identifier;
    m_str_trigger_type = m_s_bundle.triggertype;
    m_b_gameobject_scene_alignment = m_s_bundle.playerscenebundlegameobjectalignment;
    var_7abf2b16 = m_s_bundle.var_e45035d4;
    var_26a01d70 = m_s_bundle.var_1a876104;
    m_n_trigger_use_time = m_s_bundle.n_trigger_use_time;

    if(!isDefined(m_n_trigger_use_time)) {
      m_n_trigger_use_time = 0;
    }

    var_14f4f0bc = m_s_bundle.var_f6949418;

    if(!isDefined(var_14f4f0bc)) {
      var_14f4f0bc = 0;
    }

    if(isDefined(str_identifier_override)) {
      m_str_identifier = str_identifier_override;
    }

    m_str_hint = m_s_bundle.str_hint;

    if(isDefined(str_objective_override)) {
      m_str_objective = str_objective_override;
    } else {
      m_str_objective = isDefined(m_s_bundle.objective) ? m_s_bundle.objective : undefined;
    }

    e_object.str_objective_name = m_s_bundle.objective;
    e_object.var_45aad1f4 = m_str_objective;
    m_str_type = m_s_bundle.gameobjecttype;

    if(is_true(m_s_bundle.allowweapons)) {
      m_b_allow_weapons = 1;
    } else {
      m_b_allow_weapons = 0;
    }

    if(isDefined(str_team_override)) {
      m_str_team = str_team_override;
    }

    m_str_team = util::get_team_mapping(m_str_team);

    if(isDefined(a_keyline_objects)) {
      m_a_keyline_objects = a_keyline_objects;
    } else if(isDefined(m_s_bundle.model)) {
      var_ed8e6d51 = util::spawn_model(m_s_bundle.model, e_object.origin, e_object.angles);
      m_a_keyline_objects = array(var_ed8e6d51);
    }

    n_trig_x = m_s_bundle.triggerxoffset;

    if(!isDefined(n_trig_x)) {
      n_trig_x = 0;
    }

    n_trig_y = m_s_bundle.triggeryoffset;

    if(!isDefined(n_trig_y)) {
      n_trig_y = 0;
    }

    n_trig_z = m_s_bundle.triggerzoffset;

    if(!isDefined(n_trig_z)) {
      n_trig_z = 0;
    }

    m_n_trigger_offset = (n_trig_x, n_trig_y, n_trig_z);

    if(isDefined(e_object.func_custom_gameobject_position)) {
      m_n_trigger_offset = (0, 0, 0);
      m_v_tag_origin = e_object[[e_object.func_custom_gameobject_position]]();
    }

    m_b_allow_companion_command = b_allow_companion_command;

    if(isDefined(t_override) && isDefined(t_override.classname)) {
      if(is_valid_gameobject_trigger(t_override)) {
        m_t_interact = t_override;
      } else {
        assert("<dev string:x404>");
      }
    }

    var_a99c4d4c = [];
    var_2854e7f7 = [];
    self create_gameobject_trigger();
    self thread function_768739b6();
  }

  function function_768739b6() {
    level endon(#"game_ended");
    e_object endon(#"death", #"gameobject_end_use");
    e_object.mdl_gameobject endon(#"death");
    level waittill(#"all_players_spawned");

    if(m_str_team == # "group_none") {
      return;
    }

    var_9c2f0815 = var_15547ed4 || isDefined(e_object.var_f66cebb1) ? m_str_team : # "group_none";

    for(var_fb20e730 = getplayers(m_str_team); var_fb20e730.size; var_fb20e730 = getplayers(m_str_team)) {
      foreach(e_player in var_fb20e730) {
        if(function_aa070e6f(e_player) && !isinarray(var_2854e7f7, e_player.team) && !e_player isinvehicle()) {
          voiceparams = {
            #team: m_str_team, #side: var_9c2f0815, #targetname: e_object.var_f66cebb1
          };
          array::add(var_2854e7f7, e_player.team);
          break;
        }
      }

      wait 1;
    }
  }

  function is_valid_gameobject_trigger(t_override) {
    if(m_str_trigger_type === "proximity") {
      switch (t_override.classname) {
        case # "trigger_box":
        case # "trigger_once":
        case # "trigger_radius":
        case # "trigger_multiple":
          return true;
        default:
          return false;
      }
    } else {
      switch (t_override.classname) {
        case # "trigger_radius_use":
        case # "trigger_use":
          return true;
        default:
          return false;
      }
    }

    return false;
  }

  function function_aa070e6f(e_player) {
    if(isDefined(e_object) && isDefined(e_object.mdl_gameobject) && isDefined(e_player) && is_true(e_object.mdl_gameobject.b_enabled)) {
      return (distance2dsquared(e_object.origin, e_player.origin) < sqr(675) && e_player util::is_player_looking_at(e_object.origin));
    }

    return 0;
  }
}

function private event_handler[createstruct] function_e0a8e4ba(struct) {
  foreach(var_d335d6ef, k in ["script_carry_object_key_target", "script_paired_gameobject"]) {
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

function private autoexec __init__system__() {
  system::register(#"gameobjects", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.numgametypereservedobjectives = 1;
  level.releasedobjectives = [];
  level.a_gameobjects = [];
  callback::on_spawned(&function_b737f012);
  callback::on_vehicle_spawned(&function_b737f012);
  callback::on_ai_spawned(&function_b737f012);
  callback::on_disconnect(&on_disconnect);
  callback::on_laststand(&on_player_last_stand);
  level thread function_71699fe2();
}

function main() {
  level.vehiclesenabled = getgametypesetting(#"vehiclesenabled");
  level.vehiclestimed = getgametypesetting(#"vehiclestimed");
  level.objectivepingdelay = getgametypesetting(#"objectivepingtime");
  level.gameobjectscontestedmajoritywins = getgametypesetting(#"gameobjectscontestedmajoritywins");

  if(!isDefined(level.allowedgameobjects)) {
    level.allowedgameobjects = [];
  }

  if(level.vehiclesenabled) {
    level.allowedgameobjects[level.allowedgameobjects.size] = "vehicle";
    filter_script_vehicles_from_vehicle_descriptors(level.allowedgameobjects);
  }

  a_ents = getEntArray();

  for(entity_index = a_ents.size - 1; entity_index >= 0; entity_index--) {
    entity = a_ents[entity_index];

    if(!entity_is_allowed(entity, level.allowedgameobjects)) {
      entity delete();
    }
  }

  level thread function_176070dc();
}

function register_allowed_gameobject(gameobject) {
  if(!isDefined(level.allowedgameobjects)) {
    level.allowedgameobjects = [];
  }

  level.allowedgameobjects[level.allowedgameobjects.size] = gameobject;
}

function clear_allowed_gameobjects() {
  level.allowedgameobjects = [];
}

function entity_is_allowed(entity, allowed_game_modes) {
  allowed = 1;

  if(isDefined(entity.script_gameobjectname) && entity.script_gameobjectname != "[all_modes]") {
    allowed = 0;
    gameobjectnames = strtok(entity.script_gameobjectname, " ");

    for(i = 0; i < allowed_game_modes.size && !allowed; i++) {
      for(j = 0; j < gameobjectnames.size && !allowed; j++) {
        allowed = gameobjectnames[j] == allowed_game_modes[i];
      }
    }
  }

  return allowed;
}

function location_is_allowed(entity, location) {
  allowed = 1;
  location_list = undefined;

  if(isDefined(entity.script_noteworthy)) {
    location_list = entity.script_noteworthy;
  }

  if(isDefined(entity.script_location)) {
    location_list = entity.script_location;
  }

  if(isDefined(location_list)) {
    if(location_list == "[all_modes]") {
      allowed = 1;
    } else {
      allowed = 0;
      gameobjectlocations = strtok(location_list, " ");

      for(j = 0; j < gameobjectlocations.size; j++) {
        if(gameobjectlocations[j] == location) {
          allowed = 1;
          break;
        }
      }
    }
  }

  return allowed;
}

function filter_script_vehicles_from_vehicle_descriptors(allowed_game_modes) {
  vehicle_descriptors = getEntArray("vehicle_descriptor", "targetname");
  script_vehicles = getEntArray("script_vehicle", "classname");
  vehicles_to_remove = [];

  for(descriptor_index = 0; descriptor_index < vehicle_descriptors.size; descriptor_index++) {
    descriptor = vehicle_descriptors[descriptor_index];
    closest_distance_sq = 1e+12;
    closest_vehicle = undefined;

    for(vehicle_index = 0; vehicle_index < script_vehicles.size; vehicle_index++) {
      vehicle = script_vehicles[vehicle_index];
      dsquared = distancesquared(vehicle getorigin(), descriptor getorigin());

      if(dsquared < closest_distance_sq) {
        closest_distance_sq = dsquared;
        closest_vehicle = vehicle;
      }
    }

    if(isDefined(closest_vehicle)) {
      if(!entity_is_allowed(descriptor, allowed_game_modes)) {
        vehicles_to_remove[vehicles_to_remove.size] = closest_vehicle;
      }
    }
  }

  for(vehicle_index = 0; vehicle_index < vehicles_to_remove.size; vehicle_index++) {
    vehicles_to_remove[vehicle_index] delete();
  }
}

function function_71699fe2() {
  level.a_s_gameobjects = struct::get_script_bundle_instances("gameobject");
  n_count = 1;

  foreach(s_radiant in level.a_s_gameobjects) {
    if(isDefined(s_radiant.targetname)) {
      s_radiant.str_identifier = s_radiant.targetname + "_" + n_count;
    } else {
      s_radiant.str_identifier = "gameobject_" + n_count;
    }

    n_count++;
    s_radiant.var_c65066ad = 1;
    s_radiant init_flags();
  }
}

function function_176070dc() {
  waittillframeend();

  foreach(s_radiant in level.a_s_gameobjects) {
    if(isDefined(s_radiant.script_team) && s_radiant.script_team != # "group_none") {
      str_team_override = s_radiant.script_team;
    } else {
      str_team_override = undefined;
    }

    s_radiant init_game_objects(undefined, str_team_override, s_radiant.var_5c8915f4, undefined, undefined, s_radiant.script_objective_override);
    s_radiant disable_object(1);

    if(is_true(s_radiant.script_enable_on_start)) {
      s_radiant thread enable_object(1);
    }

    if(isDefined(s_radiant.script_carry_object_key_target) && is_true(s_radiant.script_destroy_keys_after_use)) {
      s_radiant function_e7e3d146();
    }

    s_radiant function_71479ff3();

    if(isDefined(s_radiant.script_paired_gameobject)) {
      s_radiant.var_84d5c09e = struct::get_array(s_radiant.script_paired_gameobject, "script_paired_gameobject");
      s_radiant.mdl_gameobject.b_auto_reenable = 0;
    }
  }

  function_42b34fc3();
  function_2f3ba1ad();
  function_71a1c90f();
  level flag::set(#"radiant_gameobjects_initialized");
}

function private init_flags() {
  self flag::init("enabled");
  self flag::init("success");

  if(isDefined(self.script_flag_true)) {
    util::create_flags_and_return_tokens(self.script_flag_true);
  }

  if(isDefined(self.script_flag_false)) {
    util::create_flags_and_return_tokens(self.script_flag_false);
  }

  if(isDefined(self.script_flag_set_start)) {
    util::create_flags_and_return_tokens(self.script_flag_set_start);
  }

  if(isDefined(self.script_flag_set)) {
    util::create_flags_and_return_tokens(self.script_flag_set);
  }
}

function private function_35a012bf() {
  if(self flag::get("enabled")) {
    return;
  }

  self.mdl_gameobject endon(#"death");

  if(!is_true(self.mdl_gameobject.var_64b8fc93)) {
    self.mdl_gameobject.var_64b8fc93 = 1;
    self util::function_fb80e9ca();
  }

  self flag::set("enabled");

  if(isDefined(self.script_flag_set_start)) {
    util::function_aebdb74f(self.script_flag_set_start);
  }
}

function function_8dbe8332(b_success, b_destroyed) {
  if(level flag::get(#"radiant_gameobjects_initialized")) {
    self flag::clear("enabled");
  }
}

function private function_49184ad0(str_team, e_player, b_success = 0) {
  if(b_success) {
    if(isDefined(self.var_84d5c09e)) {}

    if(isDefined(self.script_flag_set)) {
      util::function_aebdb74f(self.script_flag_set);
    }
  }
}

function private function_42b34fc3() {
  foreach(var_7418aa09 in trigger::get_all()) {
    var_bf5ad193 = [];

    foreach(e_gameobject in level.a_gameobjects) {
      if(isDefined(e_gameobject) && isDefined(e_gameobject.e_object) && isDefined(var_7418aa09.target) && var_7418aa09.target === e_gameobject.e_object.targetname) {
        array::add(var_bf5ad193, e_gameobject);
      }
    }

    if(var_bf5ad193.size) {
      if(isDefined(var_7418aa09)) {
        var_7418aa09 thread function_d4107dde(var_bf5ad193);
      }
    }
  }
}

function private function_d4107dde(var_bf5ad193) {
  self endon(#"death");
  self trigger::wait_till();

  foreach(e_gameobject in var_bf5ad193) {
    if(isDefined(e_gameobject) && isDefined(e_gameobject.e_object)) {
      e_gameobject.e_object enable_object(1);
    }
  }
}

function private function_2f3ba1ad() {
  foreach(s_key in struct::get_script_bundle_instances("gameobject")) {
    if(isDefined(s_key.script_carry_object_key_src)) {
      var_fac9218d = strtok(s_key.script_carry_object_key_src, " ");
      s_key.a_s_locks = [];

      foreach(var_9d32a381 in var_fac9218d) {
        s_key.a_s_locks = arraycombine(s_key.a_s_locks, struct::get_array(var_9d32a381, "script_carry_object_key_target"), 0, 0);
      }

      foreach(s_lock in s_key.a_s_locks) {
        if(isDefined(s_lock.mdl_gameobject)) {
          s_lock set_key_object(s_key);
          continue;
        }

        s_lock.var_4cd30731 = s_key;
      }

      if(is_true(s_key.script_toggle_lock_visibility) && isDefined(s_key.a_s_locks)) {
        s_key thread function_2e028a0e();
      }
    }
  }
}

function function_2e028a0e() {
  self.mdl_gameobject endon(#"death");

  while(true) {
    self.mdl_gameobject waittill(#"pickup_object");
    self hide_waypoint();

    foreach(s_lock in self.a_s_locks) {
      if(isDefined(s_lock.mdl_gameobject)) {
        s_lock function_924032a4();
        continue;
      }

      if(isDefined(s_lock.var_4cd30731)) {
        s_lock notify(#"hash_58b8542ed702b2a5", {
          #var_36c9fd16: 1, #player: self.mdl_gameobject.carrier
        });
        s_lock.var_459e9174 = 1;
      }
    }

    self.mdl_gameobject waittill(#"dropped");
    self function_924032a4();

    foreach(s_lock in self.a_s_locks) {
      if(isDefined(s_lock.mdl_gameobject)) {
        s_lock function_9f42b8fd(s_lock function_167d3a40());
        continue;
      }

      if(isDefined(s_lock.var_4cd30731)) {
        s_lock notify(#"hash_58b8542ed702b2a5", {
          #var_36c9fd16: 0
        });
        s_lock.var_459e9174 = undefined;
      }
    }
  }
}

function private function_71a1c90f() {
  foreach(var_80ab0aea in struct::get_script_bundle_instances("gameobject")) {
    if(isDefined(var_80ab0aea.linkto)) {
      a_s_structs = struct::get_array(var_80ab0aea.linkto, "linkname");
      var_6e793336 = array::random(a_s_structs);

      if(isDefined(var_6e793336.mdl_gameobject) && var_6e793336.mdl_gameobject.type === "carryObject") {
        var_80ab0aea.mdl_gameobject thread function_d85d429b(var_6e793336.mdl_gameobject);
      }
    }
  }
}

function private function_d85d429b(var_7d01398c) {
  level endon(#"game_ended");
  self.trigger endon(#"destroyed", #"death");
  var_7d01398c.trigger endon(#"destroyed", #"death");
  self endon(#"death");
  var_7d01398c endon(#"death");
  self.trigger unlink();
  self.trigger.origin = var_7d01398c.curorigin;
  self.trigger linkto(var_7d01398c);
  self.e_object.origin = var_7d01398c.curorigin;
  self.e_object.angles = var_7d01398c.e_object.angles;
  self.var_68d8f95e = var_7d01398c;

  if(!isDefined(var_7d01398c.var_bb7aca0c)) {
    var_7d01398c.var_bb7aca0c = [];
  } else if(!isarray(var_7d01398c.var_bb7aca0c)) {
    var_7d01398c.var_bb7aca0c = array(var_7d01398c.var_bb7aca0c);
  }

  var_7d01398c.var_bb7aca0c[var_7d01398c.var_bb7aca0c.size] = self;

  while(true) {
    if(isDefined(var_7d01398c.carrier)) {
      if(!is_true(self.var_2955c864)) {
        var_f857ad18 = self.interactteam;
        self.interrupted = 1;
        self allow_use(#"group_none");
        self set_flags(1);
        self.trigger unlink();
        self.trigger.origin = var_7d01398c.carrier.origin + (0, 0, 64);
        self.trigger linkto(var_7d01398c.carrier);
        var_7d01398c waittill(#"dropped", #"reset", #"death");
        self set_flags(0);
        self.interrupted = undefined;
        self.trigger unlink();
        self.trigger.origin = var_7d01398c.curorigin + (0, 0, 32);
        self.e_object.origin = var_7d01398c.curorigin;
        self.e_object.angles = var_7d01398c.angles;
        waitframe(2);
        self.trigger linkto(var_7d01398c);
        self allow_use(var_f857ad18);
      }
    }

    waitframe(1);
  }
}

function function_e19c7c52(var_7537f028, var_1511a953 = 0) {
  mdl_gameobject = self function_fd4a5f2f();
  mdl_gameobject.trigger unlink();

  if(isvec(var_7537f028)) {
    mdl_gameobject.trigger.origin = var_7537f028;
  } else if(isDefined(var_7537f028.curorigin)) {
    mdl_gameobject.trigger.origin = var_7537f028.curorigin;
  } else {
    mdl_gameobject.trigger.origin = var_7537f028.origin;
  }

  if(isentity(var_7537f028) && var_1511a953) {
    mdl_gameobject.trigger linkto(var_7537f028);
  }
}

function function_71479ff3() {
  if(isDefined(self.target)) {
    a_s_targets = struct::get_array(self.target);

    foreach(s_target in a_s_targets) {
      if(s_target scene::function_9503138e()) {
        if(!isDefined(self.var_abba8d92)) {
          self.var_abba8d92 = [];
        }

        if(!isDefined(self.var_abba8d92)) {
          self.var_abba8d92 = [];
        } else if(!isarray(self.var_abba8d92)) {
          self.var_abba8d92 = array(self.var_abba8d92);
        }

        self.var_abba8d92[self.var_abba8d92.size] = s_target;
      }
    }

    if(isDefined(self.var_abba8d92)) {
      self thread function_9e7fca5f();
    }
  }
}

function function_9e7fca5f() {
  self.mdl_gameobject.trigger endon(#"destroyed");
  self.mdl_gameobject endon(#"death");
  self endon(#"hash_767d05d04b5ba2f6");

  while(true) {
    s_waitresult = self.mdl_gameobject waittill(#"gameobject_end_use_player");

    foreach(s_scene in self.var_abba8d92) {
      if(isPlayer(s_waitresult.player) && scene::get_player_count(s_scene.scriptbundlename) >= 1) {
        s_waitresult.player animation::stop(0);
        s_scene thread scene::play(s_waitresult.player);
        continue;
      }

      s_scene thread scene::play();
    }

    foreach(s_scene in self.var_abba8d92) {
      if(is_true(s_scene.script_play_multiple)) {
        continue;
      }

      arrayremovevalue(self.var_abba8d92, s_scene, 1);
    }

    if(self.var_abba8d92.size == 0) {
      return;
    }
  }
}

function set_use_multiplier_callback(callbackfunction) {
  self.getuseratemultiplier = callbackfunction;
}

function defaultuseratescalercallback(player) {
  useobj = self;
  characterindex = player getspecialistindex();
  assert(player_role::is_valid(characterindex));
  playerrole = getplayerrolecategory(characterindex, currentsessionmode());

  if(isDefined(playerrole) && isDefined(useobj.bundle)) {
    switch (playerrole) {
      case # "prc_mp_slayer":
        scaler = useobj.bundle.slayer_userate_scaler;
        break;
      case # "prc_mp_objective":
        scaler = useobj.bundle.objective_userate_scaler;
        break;
      case # "prc_mp_support":
        scaler = useobj.bundle.support_userate_scaler;
        break;
    }
  }

  if(!isDefined(scaler)) {
    scaler = 1;
  }

  return scaler;
}

function defaultallowweaponscallback(object) {
  player = self;
  characterindex = player getspecialistindex();
  assert(player_role::is_valid(characterindex));
  playerrole = getplayerrolecategory(characterindex, currentsessionmode());

  if(isDefined(playerrole) && isDefined(object.bundle)) {
    switch (playerrole) {
      case # "prc_mp_slayer":
        return is_true(object.bundle.slayer_allow_weapons);
      case # "prc_mp_objective":
        return is_true(object.bundle.objective_allow_weapons);
      case # "prc_mp_support":
        return is_true(object.bundle.support_allow_weapons);
    }
  }

  return object.allowweapons;
}

function function_b737f012() {
  self.touchtriggers = [];
  self.packobject = [];
  self.packicon = [];
  self.carryobject = undefined;
  self.claimtrigger = undefined;
  self.canpickupobject = 1;
  self.disabledweapon = 0;
  self.killedinuse = undefined;
}

function function_19f7be2d(params) {
  if(game.state != # "playing") {
    return;
  }

  self thread gameobjects_dropped(params.mod);
}

function on_disconnect() {
  self thread gameobjects_dropped();
}

function on_player_last_stand() {
  self thread gameobjects_dropped();
}

function gameobjects_dropped(mod) {
  if(isDefined(self.carryobject) && self.carryobject.var_45d1d94d !== 1) {
    self.carryobject.var_8c812e0a = mod === "MOD_META";
    self.carryobject thread set_dropped();
  }

  if(isDefined(self.packobject) && self.packobject.size > 0) {
    foreach(item in self.packobject) {
      item thread set_dropped();
    }
  }
}

function function_4ea98a09() {
  if(!isDefined(self.trigger.var_a865c2cd)) {
    return true;
  }

  if(self.trigger.var_a865c2cd) {
    return true;
  }

  return false;
}

function create_carry_object(ownerteam, trigger, visuals, offset, objectivename, hitsound, allowinitialholddelay = 0, allowweaponcyclingduringhold = 0) {
  carryobject = spawn("script_model", trigger.origin);
  carryobject.type = "carryObject";
  carryobject.curorigin = trigger.origin;
  carryobject.entnum = trigger getentitynumber();
  carryobject.hitsound = hitsound;

  if(issubstr(trigger.classname, "use")) {
    carryobject.triggertype = "use";
  } else {
    carryobject.triggertype = "proximity";
  }

  trigger.baseorigin = trigger.origin;
  carryobject.trigger = trigger;
  trigger enablelinkto();
  carryobject linkto(trigger);
  carryobject.useweapon = undefined;

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  carryobject.visuals = visuals;
  carryobject _set_team(ownerteam);
  carryobject.compassicons = [];
  carryobject.objidpingfriendly = 0;
  carryobject.objidpingenemy = 0;

  if(carryobject function_4ea98a09()) {
    assert(isDefined(objectivename), "<dev string:x38>");
    carryobject.objid = [];
    level.objidstart += 2;
    carryobject.objectiveid = get_next_obj_id();
    objective_add(carryobject.objectiveid, "invisible", carryobject.curorigin, objectivename);
  }

  carryobject.carrier = undefined;
  carryobject.isresetting = 0;
  carryobject.interactteam = # "group_none";
  carryobject.allowweapons = 0;
  carryobject.visiblecarriermodel = undefined;
  carryobject.dropoffset = 0;
  carryobject.disallowremotecontrol = 0;
  carryobject.var_22389d70 = 1;
  carryobject.worldicons = [];
  carryobject.carriervisible = 0;
  carryobject.visibleteam = # "group_none";
  carryobject.worldiswaypoint = [];
  carryobject.worldicons_disabled = [];
  carryobject.carryicon = undefined;
  carryobject.setdropped = undefined;
  carryobject.ondrop = undefined;
  carryobject.onpickup = undefined;
  carryobject.onreset = undefined;
  carryobject.usetime = 10000;
  carryobject.var_9288c4c0 = carryobject.usetime;
  carryobject.decayprogress = 0;
  carryobject.var_98bb0715 = 1;
  carryobject.var_5c196da4 = 0;
  carryobject clear_progress();

  if(carryobject.triggertype == "use") {
    carryobject.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    carryobject.userate = 1;
    carryobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);

    if(!carryobject function_4ea98a09() && isDefined(carryobject.trigger.str_hint)) {
      carryobject.trigger setcursorhint("HINT_NOICON");
      carryobject.trigger sethintstring(carryobject.trigger.str_hint);
    }
  } else {
    carryobject function_e553e480();
    carryobject thread use_object_prox_think();
  }

  carryobject.getuseratemultiplier = &defaultuseratescalercallback;
  carryobject.allowweaponscallback = &defaultallowweaponscallback;

  if(carryobject function_4ea98a09()) {
    carryobject thread update_carry_object_objective_origin();
  }

  array::add(level.a_gameobjects, carryobject, 0);
  carryobject.b_reusable = 1;
  return carryobject;
}

function function_63f73e1d(soundalias) {
  self.var_e810e5f7 = soundalias;
}

function pickup_object_delay(origin) {
  level endon(#"game_ended");
  self endon(#"death", #"disconnect");
  self.canpickupobject = 0;

  for(;;) {
    if(distancesquared(self.origin, origin) > 4096) {
      break;
    }

    wait 0.2;
  }

  self.canpickupobject = 1;
}

function set_picked_up(player) {
  if(!isalive(player)) {
    return;
  }

  if(self.type == "carryObject") {
    if(isDefined(player.carryobject)) {
      if(is_true(player.carryobject.swappable)) {
        player.carryobject thread set_dropped();
      } else {
        if(isDefined(self.onpickupfailed)) {
          self[[self.onpickupfailed]](player);
        }

        return;
      }
    }

    player give_object(self);
  } else if(self.type == "packObject") {
    if(isDefined(level.max_packobjects) && level.max_packobjects <= player.packobject.size) {
      if(isDefined(self.onpickupfailed)) {
        self[[self.onpickupfailed]](player);
      }

      return;
    }

    player give_pack_object(self);
  }

  self set_carrier(player);
  self ghost_visuals();
  self.trigger triggerenable(0);
  self notify(#"pickup_object");

  if(isDefined(self.onpickup)) {
    self[[self.onpickup]](player);
  }

  if(isDefined(self.var_e810e5f7)) {
    self playSound(self.var_e810e5f7);
  }

  self update_objective();
}

function unlink_grenades() {
  radius = 32;
  origin = self.origin;
  grenades = getEntArray("grenade", "classname");
  radiussq = radius * radius;
  linkedgrenades = [];

  foreach(grenade in grenades) {
    if(distancesquared(origin, grenade.origin) < radiussq) {
      if(grenade islinkedto(self)) {
        grenade unlink();
        linkedgrenades[linkedgrenades.size] = grenade;
      }
    }
  }

  waittillframeend();

  foreach(grenade in linkedgrenades) {
    grenade launch((randomfloatrange(-5, 5), randomfloatrange(-5, 5), 5));
  }
}

function ghost_visuals() {
  foreach(visual in self.visuals) {
    visual ghost();
    visual thread unlink_grenades();
  }
}

function update_carry_object_objective_origin() {
  self endon(#"hash_431541b507a8c588");
  level endon(#"game_ended");
  self.trigger endon(#"destroyed", #"death");
  objpingdelay = level.objectivepingdelay;

  for(;;) {
    if(isDefined(self.carrier)) {
      self.curorigin = self.carrier.origin;

      if(isDefined(self.objectiveid)) {
        objective_setposition(self.objectiveid, self.curorigin);
      }

      self util::wait_endon(objpingdelay, "dropped", "reset");
      continue;
    }

    if(isDefined(self.objectiveid)) {
      objective_setposition(self.objectiveid, self.curorigin);
    }

    waitframe(1);
  }
}

function give_object(object) {
  assert(!isDefined(self.carryobject));
  self.carryobject = object;
  self callback::on_death(&function_19f7be2d);
  self thread track_carrier(object);
  allowweapons = object.allowweapons;

  if(isDefined(object.allowweaponscallback)) {
    allowweapons = [[object.allowweaponscallback]](object);
  }

  if(isDefined(object.carryweapon)) {
    if(isDefined(object.carryweaponthink)) {
      self thread[[object.carryweaponthink]]();
    }

    count = 0;

    while(self ismeleeing() && count < 10) {
      count++;
      wait 0.2;
    }

    self giveweapon(object.carryweapon);

    if(self isswitchingweapons()) {
      self waittilltimeout(2, #"weapon_change");
    }

    self switchtoweaponimmediate(object.carryweapon);
    self setblockweaponpickup(object.carryweapon, 1);
    self disableweaponcycling();
  } else if(!allowweapons) {
    self val::set(#"carry_object", "disable_weapons");

    if(!is_true(object.droponusebutton)) {
      self thread manual_drop_think();
    }
  }

  if(is_true(object.droponusebutton)) {
    if(object.droponusehasdelay === 1) {
      self thread droponholdusebutton();
    } else {
      self thread droponusebutton();
    }
  } else if(is_true(object.var_bee2a129)) {
    self thread function_bee2a129();
  }

  if(object.disallowvehicleusage !== 0) {
    self.disallowvehicleusage = 1;
  }

  if(isDefined(object.visiblecarriermodel)) {
    self weapons::force_stowed_weapon_update();
  }
}

function move_visuals_to_base() {
  foreach(visual in self.visuals) {
    visual.origin = visual.baseorigin;
    visual.angles = visual.baseangles;
    visual dontinterpolate();
    visual show();
  }
}

function return_home() {
  self.isresetting = 1;
  prev_origin = self.trigger.origin;
  self notify(#"reset");
  self move_visuals_to_base();
  self.trigger.origin = self.trigger.baseorigin;
  self.curorigin = self.trigger.origin;

  if(isDefined(self.e_object)) {
    self.e_object.origin = self.curorigin;
  }

  if(isDefined(self.var_bb7aca0c)) {
    foreach(var_1bae95c8 in self.var_bb7aca0c) {
      if(isDefined(var_1bae95c8) && isDefined(var_1bae95c8.e_object)) {
        var_1bae95c8.e_object.origin = self.curorigin;
      }
    }
  }

  if(isDefined(self.onreset)) {
    self[[self.onreset]](prev_origin);
  }

  if(self.type == "carryObject" && isDefined(self.droptrigger)) {
    if(isDefined(self.carrier)) {
      if(!isDefined(self.ignore_use_time)) {
        self.ignore_use_time = [];
      }

      self.ignore_use_time[self.carrier getentitynumber()] = level.time + 500;
      self.carrier sethintstring("");

      if(isDefined(self.trigger) && !self function_4ea98a09() && isDefined(self.trigger.str_hint)) {
        self.trigger setcursorhint("HINT_NOICON");
        self.trigger sethintstring(self.trigger.str_hint);
      }
    }

    self.droptrigger delete();
  }

  self clear_carrier();
  update_objective();
  self.isresetting = 0;
}

function set_new_base_position(v_base_pos, v_angles) {
  mdl_gameobject = self function_fd4a5f2f();

  foreach(visual in mdl_gameobject.visuals) {
    visual.baseorigin = v_base_pos;

    if(isDefined(v_angles)) {
      visual.baseangles = v_angles;
    }
  }

  mdl_gameobject.trigger.baseorigin = v_base_pos;
}

function is_object_away_from_home() {
  if(isDefined(self.carrier)) {
    return true;
  }

  if(distancesquared(self.trigger.origin, self.trigger.baseorigin) > 4) {
    return true;
  }

  return false;
}

function set_position(origin, angles) {
  mdl_gameobject = self function_fd4a5f2f();
  mdl_gameobject.isresetting = 1;

  foreach(visual in mdl_gameobject.visuals) {
    visual.origin = origin;
    visual.angles = angles;
    visual dontinterpolate();
    visual show();
  }

  mdl_gameobject.trigger set_trigger_origin(origin);
  mdl_gameobject.curorigin = origin;

  if(isDefined(mdl_gameobject.e_object)) {
    mdl_gameobject.e_object.origin = origin;
    mdl_gameobject.e_object.angles = angles;
  }

  mdl_gameobject clear_carrier();
  mdl_gameobject update_objective();
  mdl_gameobject.isresetting = 0;

  if(isDefined(mdl_gameobject.var_bb7aca0c)) {
    foreach(var_1bae95c8 in mdl_gameobject.var_bb7aca0c) {
      if(isDefined(var_1bae95c8) && isDefined(var_1bae95c8.e_object)) {
        var_1bae95c8.e_object.origin = origin;
        var_1bae95c8.e_object.angles = angles;
      }
    }
  }
}

function set_drop_offset(height) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.dropoffset = height;
}

function set_trigger_origin(origin) {
  offset = (self.maxs[2] - self.mins[2]) / 2;
  self.origin = (origin[0], origin[1], origin[2] + offset);

  if(isvec(self.trigger_offset)) {
    self.origin += self.trigger_offset;
  }
}

function set_dropped(var_e329a2fa) {
  if(isDefined(self.carrier) && isDefined(self.objectiveid)) {
    objective_setvisibletoplayer(self.objectiveid, self.carrier);
  }

  if(self.type == "carryObject" && isDefined(self.droptrigger)) {
    self.droptrigger delete();
  }

  if(isDefined(self.setdropped)) {
    if([[self.setdropped]]()) {
      return;
    }
  }

  if(isDefined(self.var_abcd6a7e)) {
    self thread[[self.var_abcd6a7e]](var_e329a2fa);
    return;
  }

  self.isresetting = 1;
  self notify(#"dropped");
  startorigin = (0, 0, 0);
  endorigin = (0, 0, 0);
  body = undefined;

  if(isDefined(self.carrier) && self.carrier.team != # "spectator") {
    startorigin = self.carrier.origin + (0, 0, 20);
    endorigin = self.carrier.origin - (0, 0, 2000);
    body = self.carrier.body;
  } else if(isDefined(self.safeorigin)) {
    startorigin = self.safeorigin + (0, 0, 20);
    endorigin = self.safeorigin - (0, 0, 20);
  } else {
    startorigin = self.curorigin + (0, 0, 20);
    endorigin = self.curorigin - (0, 0, 20);
  }

  if(isPlayer(var_e329a2fa)) {
    var_88760a3b = var_e329a2fa;
  } else {
    var_88760a3b = self.carrier;
  }

  trace_size = 10;
  trace = physicstrace(startorigin, endorigin, (trace_size * -1, trace_size * -1, 0), (trace_size, trace_size, 2 * trace_size), var_88760a3b, 32);
  droppingplayer = var_88760a3b;
  self clear_carrier();

  if(isDefined(trace)) {
    tempangle = randomfloat(360);
    droporigin = trace[# "position"] + (0, 0, self.dropoffset);

    if(trace[# "fraction"] < 1) {
      forward = (cos(tempangle), sin(tempangle), 0);
      forward = vectornormalize(forward - vectorscale(trace[# "normal"], vectordot(forward, trace[# "normal"])));

      if(isDefined(trace[# "walkable"])) {
        if(trace[# "walkable"] == 0) {
          end_reflect = forward * 1000 + trace[# "position"];
          reflect_trace = physicstrace(trace[# "position"], end_reflect, (trace_size * -1, trace_size * -1, trace_size * -1), (trace_size, trace_size, trace_size), self, 32);

          if(isDefined(reflect_trace)) {
            droporigin = reflect_trace[# "position"] + (0, 0, self.dropoffset);

            if(reflect_trace[# "fraction"] < 1) {
              forward = (cos(tempangle), sin(tempangle), 0);
              forward = vectornormalize(forward - vectorscale(reflect_trace[# "normal"], vectordot(forward, reflect_trace[# "normal"])));
            }
          }
        }
      }

      dropangles = vectortoangles(forward);
    } else {
      dropangles = (0, tempangle, 0);
    }

    foreach(visual in self.visuals) {
      visual animation::stop(0);
      visual.origin = droporigin;
      visual.angles = dropangles;
      visual dontinterpolate();
      visual show();
    }

    self.trigger set_trigger_origin(droporigin);
    self.curorigin = droporigin;

    if(isDefined(self.e_object)) {
      self.e_object.origin = droporigin;
      self.e_object.angles = dropangles;
    }

    self thread pickup_timeout(trace[# "position"][2], startorigin[2]);
  } else {
    self move_visuals_to_base();
    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.baseorigin;
  }

  if(isDefined(self.ondrop)) {
    self[[self.ondrop]](droppingplayer);
  }

  self.trigger triggerenable(1);
  self update_objective();
  self.isresetting = 0;
}

function set_carrier(carrier) {
  self.carrier = carrier;
  self notify(#"reset");

  if(isDefined(self.objectiveid)) {
    objective_setplayerusing(self.objectiveid, carrier);
  }
}

function get_carrier() {
  mdl_gameobject = self function_fd4a5f2f();
  return mdl_gameobject.carrier;
}

function clear_carrier() {
  if(!isDefined(self.carrier)) {
    return;
  }

  self.carrier callback::remove_on_death(&function_19f7be2d);
  self.carrier take_object(self);

  if(isDefined(self.objectiveid)) {
    objective_clearplayerusing(self.objectiveid, self.carrier);
    objective_setvisibletoplayer(self.objectiveid, self.carrier);
  }

  if(isDefined(self.carrier) && isDefined(self.carrier.var_ea1458aa)) {
    if(!isDefined(self.carrier.var_ea1458aa.var_cba684c2)) {
      self.carrier.var_ea1458aa.var_cba684c2 = [];
    }

    self.carrier.var_ea1458aa.var_cba684c2[self getentitynumber()] = 1;
  }

  self.carrier = undefined;
  self notify(#"carrier_cleared");
}

function is_touching_any_trigger(triggers, minz, maxz, var_943e96ce) {
  foreach(trigger in triggers) {
    if(trigger istriggerenabled()) {
      if(is_true(var_943e96ce)) {
        if(istouching(self.origin, trigger)) {
          return true;
        }

        continue;
      }

      if(self istouchingswept(trigger, minz, maxz)) {
        return true;
      }
    }
  }

  return false;
}

function is_touching_any_trigger_key_value(value, key, minz, maxz, var_943e96ce) {
  return self is_touching_any_trigger(getEntArray(value, key), minz, maxz, var_943e96ce);
}

function should_be_reset(minz, maxz) {
  if(self.visuals[0] is_touching_any_trigger_key_value("minefield", "targetname", minz, maxz, self.var_ac304f56)) {
    return true;
  }

  if(self.visuals[0] is_touching_any_trigger_key_value("trigger_hurt", "classname", minz, maxz, self.var_ac304f56)) {
    return true;
  }

  arrayremovevalue(level.oob_triggers, undefined);

  if(self.visuals[0] is_touching_any_trigger(level.oob_triggers, minz, maxz, self.var_ac304f56)) {
    return true;
  }

  if(is_true(self.var_8c812e0a)) {
    self.var_8c812e0a = 0;
    return true;
  }

  elevators = getEntArray("script_elevator", "targetname");

  foreach(elevator in elevators) {
    assert(isDefined(elevator.occupy_volume));

    if(self.visuals[0] istouchingswept(elevator.occupy_volume, minz, maxz)) {
      return true;
    }
  }

  return false;
}

function pickup_timeout(minz, maxz) {
  self endon(#"pickup_object", #"reset", #"death");
  waitframe(1);

  if(self should_be_reset(minz, maxz)) {
    self thread return_home();
    return;
  } else if(self.var_22389d70 && !ispointonnavmesh(self.visuals[0].origin, 32)) {
    v_pos = getclosestpointonnavmesh(self.visuals[0].origin, 256, 16);

    if(!isDefined(v_pos) || sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
      self thread return_home();
      return;
    }

    v_drop = v_pos + (0, 0, self.dropoffset);

    foreach(visual in self.visuals) {
      visual animation::stop(0);
      visual.origin = v_drop;
      visual dontinterpolate();
      visual show();
    }

    self.trigger set_trigger_origin(v_drop);
    self.curorigin = v_drop;

    if(isDefined(self.e_object)) {
      self.e_object.origin = v_drop;
    }
  }

  if(isDefined(self.pickuptimeoutoverride)) {
    self thread[[self.pickuptimeoutoverride]]();
    return;
  }

  if(isDefined(self.autoresettime)) {
    wait self.autoresettime;

    if(!isDefined(self.carrier)) {
      self thread return_home();
    }
  }
}

function take_object(object) {
  if(isDefined(object.visiblecarriermodel)) {
    self weapons::detach_all_weapons();
  }

  shouldenableweapon = 1;

  if(isDefined(object.carryweapon) && !isDefined(self.player_disconnected)) {
    shouldenableweapon = 0;
    self thread wait_take_carry_weapon(object.carryweapon);
  }

  if(object.type == "carryObject") {
    if(isDefined(self.carryicon)) {
      self.carryicon hud::destroyelem();
    }

    self.carryobject = undefined;
  } else if(object.type == "packObject") {
    if(isDefined(self.packicon) && self.packicon.size > 0) {
      for(i = 0; i < self.packicon.size; i++) {
        if(isDefined(self.packicon[i].script_string)) {
          if(self.packicon[i].script_string == object.packicon) {
            elem = self.packicon[i];
            arrayremovevalue(self.packicon, elem);

            elem hud::destroyelem();

            self thread adjust_remaining_packicons();
          }
        }
      }
    }

    arrayremovevalue(self.packobject, object);
  }

  if(!isalive(self) || isDefined(self.player_disconnected)) {
    return;
  }

  self notify(#"drop_object");
  self.disallowvehicleusage = 0;

  if(object.triggertype == "proximity") {
    self thread pickup_object_delay(object.trigger.origin);
  }

  if(isDefined(object.visiblecarriermodel)) {
    self weapons::force_stowed_weapon_update();
  }

  allowweapons = object.allowweapons;

  if(isDefined(object.allowweaponscallback)) {
    allowweapons = [[object.allowweaponscallback]](object);
  }

  if(!allowweapons && shouldenableweapon) {
    self val::reset(#"carry_object", "disable_weapons");
  }
}

function wait_take_carry_weapon(weapon) {
  self thread take_carry_weapon_on_death(weapon);
  wait max(0, weapon.firetime - 2 * float(function_60d95f53()) / 1000);
  self take_carry_weapon(weapon);
}

function take_carry_weapon_on_death(weapon) {
  self endon(#"take_carry_weapon");
  self waittill(#"death");
  self take_carry_weapon(weapon);
}

function take_carry_weapon(weapon) {
  self notify(#"take_carry_weapon");

  if(self hasweapon(weapon, 1)) {
    ballweapon = getweapon(#"ball");
    currweapon = self getcurrentweapon();

    if(weapon == ballweapon && currweapon === ballweapon) {
      self killstreaks::switch_to_last_non_killstreak_weapon(undefined, 1);
    }

    self setblockweaponpickup(weapon, 0);
    self takeweapon(weapon);
    self enableweaponcycling();

    if(level.gametype == "ball") {
      self enableoffhandweapons();
    }
  }
}

function function_6e870d38(weapon) {
  assert(isweapon(weapon), "<dev string:x6b>");
  mdl_gameobject = self function_fd4a5f2f();
  mdl_gameobject.carryweapon = weapon;
}

function function_a8c842d6(var_e13b2d32, b_delay, var_242b6839) {
  mdl_gameobject = self function_fd4a5f2f();
  mdl_gameobject.droponusebutton = var_e13b2d32;
  mdl_gameobject.droponusehasdelay = b_delay;
  mdl_gameobject.var_97c7a495 = var_242b6839;
}

function function_98c39cbc(b_enable) {
  mdl_gameobject = self function_fd4a5f2f();
  mdl_gameobject.var_bee2a129 = b_enable;

  if(b_enable) {
    if(is_true(mdl_gameobject.droponusebutton)) {
      mdl_gameobject.droponusebutton = 0;
    }

    if(is_true(mdl_gameobject.droponusehasdelay)) {
      mdl_gameobject.droponusehasdelay = 0;
    }

    if(is_true(mdl_gameobject.var_97c7a495)) {
      mdl_gameobject.var_97c7a495 = 0;
    }
  }
}

function track_carrier(object) {
  level endon(#"game_ended");
  self endon(#"disconnect", #"death", #"drop_object");
  waitframe(1);

  while(isDefined(object.carrier) && object.carrier == self && isalive(self)) {
    if(self isonground()) {
      trace = bulletTrace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);

      if(trace[# "fraction"] < 1) {
        object.safeorigin = trace[# "position"];
      }
    }

    waitframe(1);
  }
}

function manual_drop_think() {
  level endon(#"game_ended");
  self endon(#"disconnect", #"death", #"drop_object");

  for(;;) {
    while(self attackButtonPressed() || self fragButtonPressed() || self secondaryoffhandbuttonPressed() || self meleeButtonPressed()) {
      waitframe(1);
    }

    while(!self attackButtonPressed() && !self fragButtonPressed() && !self secondaryoffhandbuttonPressed() && !self meleeButtonPressed()) {
      waitframe(1);
    }

    if(isDefined(self.carryobject) && !self useButtonPressed()) {
      self.carryobject thread set_dropped();
    }
  }
}

function droponusebutton() {
  level endon(#"game_ended");
  self endon(#"disconnect", #"death", #"drop_object");

  while(self useButtonPressed()) {
    waitframe(1);
  }

  while(!self useButtonPressed()) {
    waitframe(1);
  }

  if(isDefined(self.carryobject)) {
    self.carryobject thread set_dropped();
  }
}

function watchholdusedrop() {
  level endon(#"game_ended");
  self endon(#"death", #"disconnect", #"drop_object");
  assert(isDefined(self.carryobject));
  assert(isDefined(self.carryobject.droptrigger));
  trigger = self.carryobject.droptrigger;

  while(true) {
    waitresult = trigger waittill(#"trigger");

    if(self useButtonPressed() && !self.throwinggrenade && !self meleeButtonPressed() && !self attackButtonPressed() && !is_true(self.isplanting) && !is_true(self.isdefusing) && !self isremotecontrolling()) {
      if(isDefined(self.carryobject)) {
        if(!isDefined(self.carryobject.ignore_use_time)) {
          self.carryobject.ignore_use_time = [];
        }

        self.carryobject.ignore_use_time[self getentitynumber()] = level.time + 500;
        self sethintstring("");

        if(!self.carryobject function_4ea98a09() && isDefined(self.carryobject.trigger.str_hint)) {
          self.carryobject.trigger setcursorhint("HINT_NOICON");
          self.carryobject.trigger sethintstring(self.carryobject.trigger.str_hint);
        }

        self.carryobject thread set_dropped();
      }
    }
  }
}

function droponholdusebutton() {
  level endon(#"game_ended");
  self endon(#"disconnect", #"death", #"drop_object");

  if(!isDefined(self.carryobject)) {
    return;
  }

  while(self useButtonPressed()) {
    waitframe(1);
  }

  if(!isDefined(self.carryobject.droptrigger)) {
    pos = self.origin + (0, 0, 15);
    self.carryobject.droptrigger = spawn("trigger_radius_use", pos);
  }

  if(self.carryobject.var_97c7a495 === 1) {
    self.carryobject.droptrigger function_750d6379();
  }

  self.carryobject.droptrigger sethintlowpriority(1);
  self.carryobject.droptrigger sethintstring(#"hash_7944e4820b9c7227");
  self.carryobject.droptrigger setcursorhint("HINT_NOICON", self.carryobject);
  self.carryobject.droptrigger enablelinkto();
  self.carryobject.droptrigger linkto(self, "tag_origin", (0, 0, 15));
  self.carryobject.droptrigger setteamfortrigger(self.team);
  self.carryobject.droptrigger setinvisibletoall();
  self.carryobject.droptrigger setvisibletoplayer(self);
  self clientclaimtrigger(self.carryobject.droptrigger);
  self thread watchholdusedrop();
}

function function_2544bab6() {
  level endon(#"game_ended");
  self endon(#"death", #"disconnect", #"drop_object");
  assert(isDefined(self.carryobject));

  while(true) {
    while(!self useButtonPressed()) {
      waitframe(1);
    }

    var_f783260f = gettime();

    while(self useButtonPressed() && var_f783260f + 500 > gettime()) {
      waitframe(1);
    }

    if(var_f783260f + 500 <= gettime()) {
      continue;
    }

    while(!self useButtonPressed() && var_f783260f + 1000 > gettime()) {
      waitframe(1);
    }

    if(var_f783260f + 1000 <= gettime()) {
      continue;
    }

    if(isDefined(self.carryobject)) {
      if(!isDefined(self.carryobject.ignore_use_time)) {
        self.carryobject.ignore_use_time = [];
      }

      self.carryobject.ignore_use_time[self getentitynumber()] = level.time + 500;
      self sethintstring("");

      if(!self.carryobject function_4ea98a09() && isDefined(self.carryobject.trigger.str_hint)) {
        self.carryobject.trigger setcursorhint("HINT_NOICON");
        self.carryobject.trigger sethintstring(self.carryobject.trigger.str_hint);
      }

      self.carryobject thread set_dropped();
    }

    waitframe(1);
  }
}

function function_bee2a129() {
  level endon(#"game_ended");
  self endon(#"disconnect", #"death", #"drop_object");

  if(!isDefined(self.carryobject)) {
    return;
  }

  if(!isDefined(self.carryobject.droptrigger)) {
    pos = self.origin + (0, 0, 15);
    self.carryobject.droptrigger = spawn("trigger_radius_use", pos);
  }

  self.carryobject.droptrigger sethintlowpriority(1);
  self.carryobject.droptrigger sethintstring(#"hash_50dd3fca372feb35");
  self.carryobject.droptrigger setcursorhint("HINT_NOICON", self.carryobject);
  self.carryobject.droptrigger enablelinkto();
  self.carryobject.droptrigger linkto(self, "tag_origin", (0, 0, 15));
  self.carryobject.droptrigger setteamfortrigger(self.team);
  self.carryobject.droptrigger setinvisibletoall();
  self.carryobject.droptrigger setvisibletoplayer(self);
  self clientclaimtrigger(self.carryobject.droptrigger);
  self thread function_2544bab6();
}

function create_generic_object(ownerteam, trigger, visuals, offset) {
  generic_object = spawn("script_model", trigger.origin);
  generic_object.type = "GenericObject";
  generic_object.curorigin = trigger.origin;
  generic_object.entnum = trigger getentitynumber();
  generic_object.keyobject = undefined;
  generic_object.triggertype = "proximity";
  generic_object.trigger = trigger;
  generic_object linkto(trigger);

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  generic_object.visuals = visuals;
  generic_object _set_team(ownerteam);

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  if(sessionmodeiscampaigngame()) {
    generic_object.keepweapon = 1;
  }

  generic_object.interactteam = # "group_none";
  generic_object.onuse = undefined;
  generic_object.oncantuse = undefined;
  generic_object.onresumeuse = undefined;
  generic_object.usetime = 10000;
  generic_object.var_9288c4c0 = generic_object.usetime;
  generic_object.decayprogress = 0;
  generic_object.var_98bb0715 = 1;
  generic_object.var_5c196da4 = 0;
  generic_object clear_progress();

  if(generic_object.triggertype == "proximity") {
    generic_object function_e553e480();
  }

  array::add(level.a_gameobjects, generic_object, 0);
  generic_object.b_reusable = 1;
  return generic_object;
}

function create_use_object(ownerteam, trigger, visuals, var_da26a41 = (0, 0, 0), objectivename, allowinitialholddelay = 0, allowweaponcyclingduringhold = 0, start_enabled = 1, angles) {
  useobject = spawn("script_model", trigger.origin + var_da26a41);
  useobject.type = "useObject";
  useobject.curorigin = trigger.origin;
  useobject.entnum = trigger getentitynumber();
  useobject.keyobject = undefined;

  if(issubstr(trigger.classname, "use")) {
    useobject.triggertype = "use";
  } else {
    useobject.triggertype = "proximity";
  }

  if(visuals.size > 0) {
    useobject.angles = visuals[0].angles;
  } else if(isDefined(angles)) {
    useobject.angles = angles;
  }

  useobject.trigger = trigger;
  useobject linkto(trigger);

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  useobject.visuals = visuals;
  useobject _set_team(ownerteam);

  if(sessionmodeiscampaigngame()) {
    useobject.keepweapon = 1;
  }

  useobject.compassicons = [];

  if(useobject function_4ea98a09()) {
    assert(isDefined(objectivename), "<dev string:xa5>");
    useobject.objid = [];
    useobject.var_f23c87bd = objectivename;
    useobject.var_25010336 = &function_4d047b8d;

    if(is_true(start_enabled)) {
      useobject enable_object();
    }
  } else {
    useobject.trigger setcursorhint("HINT_NOICON");

    if(isDefined(useobject.trigger.str_hint)) {
      useobject.trigger sethintstring(useobject.trigger.str_hint);
    }

    if(is_true(self.m_b_reusable)) {
      allowinitialholddelay = 1;
    }
  }

  useobject.interactteam = # "group_none";
  useobject.worldicons = [];
  useobject.visibleteam = # "group_none";
  useobject.worldiswaypoint = [];
  useobject.worldicons_disabled = [];
  useobject.onuse = undefined;
  useobject.oncantuse = undefined;
  useobject.onresumeuse = undefined;
  useobject.usetext = "default";
  useobject.usetime = 10000;
  useobject.var_9288c4c0 = useobject.usetime;
  useobject.decayprogress = 0;
  useobject.var_98bb0715 = 1;
  useobject.var_5c196da4 = 1;
  useobject.curprogress = 0;
  useobject.decayprogressmin = 0;

  if(useobject.triggertype == "proximity") {
    useobject function_e553e480();
    useobject thread use_object_prox_think();
  } else {
    useobject.userate = 1;
    useobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
  }

  useobject clear_progress();
  array::add(level.a_gameobjects, useobject, 0);
  useobject.b_reusable = 1;
  return useobject;
}

function private function_4d047b8d() {
  useobject = self;
  assert(isDefined(useobject.var_f23c87bd));
  assert(!isDefined(useobject.objectiveid));
  useobject.objectiveid = get_next_obj_id();
  objective_add(useobject.objectiveid, "invisible", useobject, useobject.var_f23c87bd);
  requiredspecialty = objective_getrequiredspecialty(useobject.var_f23c87bd);

  if(isDefined(useobject.trigger) && isDefined(requiredspecialty) && requiredspecialty != "None") {
    useobject.trigger setperkfortrigger(requiredspecialty);
  }

  requiredweapon = function_1fce1758(useobject.objectiveid);

  if(isDefined(requiredweapon)) {
    useobject.requiredweapon = getweapon(requiredweapon);
    useobject.trigger function_ca21f900(useobject.requiredweapon);
  }
}

function set_key_object(object) {
  mdl_gameobject = self function_fd4a5f2f();
  object = object function_fd4a5f2f();

  if(!isDefined(object)) {
    mdl_gameobject.keyobject = undefined;
    return;
  }

  if(!isDefined(mdl_gameobject.keyobject)) {
    mdl_gameobject.keyobject = [];
  }

  if(isarray(object)) {
    foreach(obj in object) {
      mdl_gameobject.keyobject[mdl_gameobject.keyobject.size] = obj;
    }

    return;
  }

  mdl_gameobject.keyobject[mdl_gameobject.keyobject.size] = object;
}

function function_fe788e71(object) {
  mdl_gameobject = self function_fd4a5f2f();
  object = object function_fd4a5f2f();

  if(!isDefined(mdl_gameobject.keyobject)) {
    return;
  }

  arrayremovevalue(mdl_gameobject.keyobject, undefined, 0);

  if(isarray(object)) {
    foreach(obj in object) {
      arrayremovevalue(mdl_gameobject.keyobject, obj, 0);
    }
  } else {
    arrayremovevalue(mdl_gameobject.keyobject, object, 0);
  }

  if(!mdl_gameobject.keyobject.size) {
    mdl_gameobject.keyobject = undefined;
  }
}

function has_key_object(use) {
  if(!isDefined(use.keyobject)) {
    return false;
  }

  for(x = 0; x < use.keyobject.size; x++) {
    if(isDefined(self.carryobject) && self.carryobject == use.keyobject[x]) {
      return true;
    }

    if(isDefined(self.packobject)) {
      for(i = 0; i < self.packobject.size; i++) {
        if(self.packobject[i] == use.keyobject[x]) {
          return true;
        }
      }
    }
  }

  return false;
}

function function_e7e3d146(b_enable = 1) {
  mdl_gameobject = self function_fd4a5f2f();
  mdl_gameobject.var_c0eeec46 = b_enable;
}

function function_f4ccb04c(e_player, var_5098afd6 = 0) {
  mdl_gameobject = self function_fd4a5f2f();
  e_player.var_17bc9194 = 1;
  mdl_gameobject.trigger notify(#"trigger", {
    #activator: e_player, #forced: var_5098afd6
  });
}

function use_object_use_think(disableinitialholddelay, disableweaponcyclingduringhold) {
  self.trigger.mdl_gameobject = self;
  self.trigger endon(#"destroyed", #"death");

  if(self.usetime > 0 && disableinitialholddelay) {
    self.trigger usetriggerignoreuseholdtime();
  }

  while(true) {
    waitresult = self.trigger waittill(#"trigger");
    player = waitresult.activator;

    if(game.state != # "playing") {
      continue;
    }

    if(!is_true(waitresult.forced)) {
      if(!self can_touch(player)) {
        continue;
      }

      if(!self can_interact_with(player)) {
        continue;
      }

      if(!is_true(self.var_33d50507)) {
        if(!player isonground() && !player isplayerswimming() || player iswallrunning()) {
          continue;
        }
      }

      if(is_true(player.var_5e6eba64)) {
        continue;
      }
    }

    if(isDefined(self.keyobject) && !player has_key_object(self)) {
      if(isDefined(self.oncantuse)) {
        self[[self.oncantuse]](player);
      }

      continue;
    }

    self notify(#"engaged");
    result = 1;

    if(self.usetime > 0) {
      self thread play_interact_anim(player);
      self apply_player_use_modifiers(player);

      if(isDefined(self.onbeginuse)) {
        if(isDefined(self.classobj)) {
          self.classobj[[self.onbeginuse]](self, player);
        } else {
          self[[self.onbeginuse]](player);
        }
      }

      team = player.pers[# "team"];
      result = self use_hold_think(player, disableweaponcyclingduringhold);
      self remove_player_use_modifiers(player);

      if(isDefined(self.onenduse)) {
        if(isDefined(self.classobj)) {
          self.classobj[[self.onenduse]](self, team, player, result);
        } else {
          self[[self.onenduse]](team, player, result);
        }
      }
    }

    if(isDefined(self.e_object) && is_true(self.e_object.var_c65066ad)) {
      self.e_object thread function_49184ad0(team, player, result);
    }

    if(!is_true(result)) {
      self notify(#"gameobject_abort");

      if(isDefined(self.e_object)) {
        self.e_object notify(#"gameobject_abort");
      }

      continue;
    }

    if(isDefined(self.e_object)) {
      if(!self.e_object flag::exists("gameobject_end_use")) {
        self.e_object flag::init("gameobject_end_use");
      }

      self.e_object flag::set("gameobject_end_use");
    }

    potm::bookmark(#"interact", gettime(), player);
    self notify(#"gameobject_end_use_player", {
      #player: player
    });

    if(isDefined(self.onuse)) {
      if(is_true(self.onuse_thread)) {
        self thread use_object_onuse(player);
      } else {
        self use_object_onuse(player);
        self callback::callback(#"hash_7de173a0523c27c9", player);
      }
    }

    if(self.type == "carryObject" || self.type === "packObject") {
      self set_picked_up(player);
    }

    self check_gameobject_reenable();
  }
}

function use_object_onuse(player) {
  level endon(#"game_ended");
  self.trigger endon(#"destroyed", #"death");

  if(isDefined(self.classobj)) {
    self.classobj[[self.onuse]](self, player);
    return;
  }

  self[[self.onuse]](player);
}

function get_earliest_claim_player() {
  assert(function_350d0352());
  earliestplayer = self.claimplayer;
  user = self.var_a4926509;

  if(self.users[user].touching.players.size > 0) {
    earliesttime = undefined;

    foreach(touchdata in self.users[user].touching.players) {
      if(!isDefined(earliesttime) || touchdata.starttime < earliesttime) {
        earliestplayer = touchdata.player;
        earliesttime = touchdata.starttime;
      }
    }
  }

  return earliestplayer;
}

function apply_player_use_modifiers(e_player) {
  if(isDefined(level.var_4e3ded37)) {
    e_player[[level.var_4e3ded37]]();
  }
}

function remove_player_use_modifiers(e_player) {
  if(isDefined(level.var_4dbea2a4)) {
    e_player[[level.var_4dbea2a4]]();
  }
}

function private function_76f3a4cd() {
  if(self.cancontestclaim) {
    num = self get_num_touching(self.var_a4926509);
    numother = self function_3a7a2963(self.var_a4926509);

    if(num && numother) {
      if(!level.gameobjectscontestedmajoritywins || num === numother) {
        return true;
      }
    }
  }

  return false;
}

function private function_4783042a() {
  if(isDefined(self.oncontested)) {
    self[[self.oncontested]]();
    self callback::callback(#"hash_7de173a0523c27c9", undefined);
  }

  if(!self.decayprogress || self.curprogress == 0) {
    self function_58901d83();
    self.claimplayer = undefined;
  }
}

function private function_d897ff7() {
  numclaimants = isDefined(get_num_touching(self.var_a4926509)) ? get_num_touching(self.var_a4926509) : 0;

  if(numclaimants == 0) {
    return true;
  } else if(level.gameobjectscontestedmajoritywins) {
    numother = isDefined(function_3a7a2963(self.var_a4926509)) ? function_3a7a2963(self.var_a4926509) : 0;
    return (numother > numclaimants);
  }

  return false;
}

function private function_72307b09(progress) {
  if(!is_true(self.var_5c196da4) || !progress) {
    return;
  }

  user = self.var_a4926509;

  if(!isDefined(user) || !isDefined(self.users[user]) || !isDefined(self.users[user].contributors)) {
    return;
  }

  if(0 > progress) {
    foreach(contributor in self.users[user].contributors) {
      contributor.contribution = math::clamp(contributor.contribution + progress, 0, self.usetime);
    }

    return;
  }

  keys = getarraykeys(self.users[user].touching.players);

  for(i = 0; i < keys.size; i++) {
    contributor = self.users[user].contributors[keys[i]];
    assert(isDefined(contributor));
    contributor.contribution = math::clamp(contributor.contribution + progress, 0, self.usetime);
  }
}

function function_1b4d64d8(enabled) {
  self.var_79f2beba = enabled;
}

function use_object_prox_think() {
  level endon(#"game_ended");
  self.trigger endon(#"destroyed", #"death");
  self thread prox_trigger_think();

  while(true) {
    if(game.state != # "playing") {
      waitframe(1);
      continue;
    }

    if(self.usetime && self.curprogress >= self.usetime || self.usetime <= 0 && get_num_touching(self.var_a4926509) > 0) {
      creditplayer = get_earliest_claim_player();

      if(isDefined(self.onenduse)) {
        if(isDefined(self.classobj)) {
          self.classobj[[self.onenduse]](self, self function_14fccbd9(), creditplayer, isDefined(creditplayer));
        } else {
          self[[self.onenduse]](self function_14fccbd9(), creditplayer, isDefined(creditplayer));
        }
      }

      if(isDefined(self.e_object)) {
        if(!self.e_object flag::exists("gameobject_end_use")) {
          self.e_object flag::init("gameobject_end_use");
        }

        self.e_object flag::set("gameobject_end_use");

        if(is_true(self.e_object.var_c65066ad)) {
          self.e_object thread function_49184ad0(self function_14fccbd9(), creditplayer, isDefined(creditplayer));
        }
      }

      if(isDefined(creditplayer)) {
        self notify(#"gameobject_end_use_player", {
          #player: creditplayer
        });
      }

      if(isDefined(creditplayer) && isDefined(self.onuse)) {
        if(isDefined(self.classobj)) {
          self.classobj[[self.onuse]](self, creditplayer);
        } else {
          self[[self.onuse]](creditplayer);
          self callback::callback(#"hash_7de173a0523c27c9", creditplayer);
        }
      }

      self clear_progress();

      if(!self.mustmaintainclaim) {
        self function_58901d83();
        self.claimplayer = undefined;
      }

      self thread check_gameobject_reenable();

      if(isDefined(creditplayer) && (self.type == "carryObject" || self.type === "packObject")) {
        self set_picked_up(creditplayer);
        self callback::callback(#"hash_7de173a0523c27c9", creditplayer);
      }
    }

    previousprogress = self.curprogress;

    if(self function_350d0352()) {
      if(self.usetime && (!self.mustmaintainclaim || !self function_abe3458c())) {
        if(self.decayprogress && self function_d897ff7()) {
          if(isDefined(self.autodecaytime) && self.autodecaytime > 0 && self.curprogress > 0) {
            self.curprogress -= level.var_9fee970c * self.usetime / int(self.autodecaytime * 1000);
            deltaprogress = self.curprogress - previousprogress;
            self function_72307b09(deltaprogress);
            self update_current_progress();

            if(self.curprogress <= 0) {
              self clear_progress();
            }

            previousprogress = self.curprogress;
          }

          self.inuse = 0;
          hadprogress = self.curprogress > 0;

          if(isDefined(self.claimplayer)) {
            if(isDefined(self.onenduse)) {
              if(isDefined(self.classobj)) {
                self.classobj[[self.onenduse]](self, self function_14fccbd9(), self.claimplayer, 0);
              } else {
                self[[self.onenduse]](self function_14fccbd9(), self.claimplayer, 0);
              }
            }

            if(isDefined(self.e_object) && is_true(self.e_object.var_c65066ad)) {
              self.e_object thread function_49184ad0(self function_14fccbd9(), self.claimplayer, 0);
            }

            self.claimplayer = undefined;
          }

          decayscale = 0;

          if(self.var_98bb0715 && isDefined(self.decaytime) && self.decaytime > 0) {
            decayscale = self.usetime / self.decaytime;
          }

          if(isDefined(self.getuseratemultiplier)) {
            var_5b06cc31 = self[[self.getuseratemultiplier]](self function_14fccbd9());
          }

          if(!isDefined(var_5b06cc31)) {
            var_5b06cc31 = 1;
          }

          self.curprogress -= level.var_9fee970c * self.userate * decayscale * var_5b06cc31;
          deltaprogress = self.curprogress - previousprogress;
          self function_72307b09(deltaprogress);

          if(isDefined(self.decayprogressmin) && self.curprogress < self.decayprogressmin) {
            self.curprogress = self.decayprogressmin;
          }

          if(self.curprogress <= 0) {
            self clear_progress();
          }

          self update_current_progress();

          if(isDefined(self.onuseupdate)) {
            self[[self.onuseupdate]](self function_14fccbd9(), self.curprogress / self.usetime, deltaprogress / self.usetime);
          }

          if(isDefined(self.var_ff74c7e9)) {
            self[[self.var_ff74c7e9]](self function_14fccbd9(), self.curprogress / self.usetime, deltaprogress / self.usetime);
          }

          if(self.curprogress == 0 && self function_350d0352()) {
            self function_58901d83();
          }

          if(is_true(hadprogress) && isDefined(self.ondecaycomplete) && self.curprogress <= (isDefined(self.decayprogressmin) ? self.decayprogressmin : 0)) {
            self[[self.ondecaycomplete]]();
          }
        } else if(get_num_touching(self.var_a4926509) == 0) {
          self.inuse = 0;

          if(isDefined(self.onenduse)) {
            if(isDefined(self.classobj)) {
              self.classobj[[self.onenduse]](self, self function_14fccbd9(), self.claimplayer, 0);
            } else {
              self[[self.onenduse]](self function_14fccbd9(), self.claimplayer, 0);
            }
          }

          if(isDefined(self.e_object) && is_true(self.e_object.var_c65066ad)) {
            self.e_object thread function_49184ad0(self function_14fccbd9(), self.claimplayer, 0);
          }

          self function_58901d83();
          self.claimplayer = undefined;
        } else if(function_76f3a4cd()) {
          function_4783042a();
        } else {
          if(isDefined(self.getuseratemultiplier)) {
            var_5b06cc31 = self[[self.getuseratemultiplier]](self function_14fccbd9());
          }

          if(!isDefined(var_5b06cc31)) {
            var_5b06cc31 = 1;
          }

          self.inuse = 1;
          self.curprogress += level.var_9fee970c * self.userate * var_5b06cc31;
          deltaprogress = self.curprogress - previousprogress;
          function_72307b09(deltaprogress);
          self update_current_progress();

          if(isDefined(self.onuseupdate)) {
            self[[self.onuseupdate]](self function_14fccbd9(), self.curprogress / self.usetime, level.var_9fee970c * self.userate / self.usetime);
          }

          if(isDefined(self.var_ff74c7e9)) {
            self[[self.var_ff74c7e9]](self function_14fccbd9(), self.curprogress / self.usetime, level.var_9fee970c * self.userate / self.usetime);
          }
        }
      } else if(!self.mustmaintainclaim) {
        if(isDefined(self.onuse)) {
          self use_object_onuse(self.claimplayer);
        }

        if(!self.mustmaintainclaim && self function_350d0352()) {
          self function_58901d83();
          self.claimplayer = undefined;
        }
      } else if(get_num_touching(self.var_a4926509) == 0) {
        self.inuse = 0;

        if(isDefined(self.onunoccupied)) {
          self[[self.onunoccupied]]();
        }

        self function_58901d83();
        self.claimplayer = undefined;
      } else if(function_76f3a4cd()) {
        function_4783042a();
      }
    } else {
      if(!self.decayprogress && self.curprogress > 0 && self.var_79f2beba !== 1 && gettime() - self.lastclaimtime > int(self.claimgraceperiod * 1000)) {
        self clear_progress();
      }

      if(self.mustmaintainclaim && self function_abb86400()) {
        if(self function_b64fb43d() == 0) {
          self.inuse = 0;

          if(isDefined(self.onunoccupied)) {
            self[[self.onunoccupied]]();
          }
        } else if(isDefined(self.onuncontested) && self.cancontestclaim && self function_3e092344() && get_num_touching(self.var_5f35f19a) > 0) {
          if(function_3a7a2963(self.var_5f35f19a) == 0) {
            self[[self.onuncontested]](self.var_5f35f19a);
          }
        }
      } else if(function_76f3a4cd()) {
        function_4783042a();
      }
    }

    waitframe(1);
    hostmigration::waittillhostmigrationdone();
  }
}

function check_gameobject_reenable() {
  self endon(#"death");

  if(isDefined(self.e_object) && is_true(self.b_reusable)) {
    self.e_object endon(#"death");

    if(!self.e_object flag::exists("gameobject_end_use")) {
      self.e_object flag::init("gameobject_end_use");
    }

    if(is_true(self.b_auto_reenable)) {
      self disable_object();
      wait 1;
      self.e_object flag::clear("gameobject_end_use");
      self enable_object();
    } else {
      waittillframeend();
      self.e_object flag::clear("gameobject_end_use");
    }
  }

  if(isDefined(self.keyobject) && is_true(self.var_c0eeec46)) {
    foreach(mdl_key in self.keyobject) {
      mdl_key destroy_object(1, 1);
    }
  }

  if(!is_true(self.b_reusable)) {
    self.e_object flag::set(#"gameobject_destroyed");
    util::wait_network_frame();
    self thread destroy_object(1, 1);
  }
}

function can_claim(sentient) {
  if(isDefined(self.carrier)) {
    return false;
  }

  if(self.cancontestclaim) {
    num = self get_num_touching(sentient.team);
    numother = function_3a7a2963(function_4e3386a8(sentient.team));

    if(numother != 0 && (!level.gameobjectscontestedmajoritywins || numother >= num)) {
      return false;
    }
  }

  if(self.var_a4926509 == function_4e3386a8(sentient.team)) {
    return false;
  }

  if(sentient has_key_object(self)) {
    return true;
  }

  if(!isDefined(self.keyobject)) {
    if(level.gameobjectscontestedmajoritywins) {
      num = self get_num_touching(function_4e3386a8(sentient.team));
      numother = function_3a7a2963(function_4e3386a8(sentient.team));

      if(numother >= num) {
        return false;
      }
    }

    return true;
  }

  return false;
}

function private function_dfec159b(player) {
  if(!isalive(player)) {
    return false;
  }

  if(is_true(player.laststand) && !is_true(player.can_capture) && !is_true(player.can_contest)) {
    return false;
  }

  if(player.spawntime == gettime()) {
    return false;
  }

  if(is_true(player.selectinglocation) && self.triggertype === "use") {
    return false;
  }

  if(player isweaponviewonlylinked()) {
    return false;
  }

  if(!is_true(self.cancontestclaim) && isDefined(self.keyobject) && !player has_key_object(self)) {
    return false;
  }

  return true;
}

function private function_bbb55f41(sentient) {
  if(!self can_interact_with(sentient)) {
    return false;
  }

  if(!self function_350d0352() || level.gameobjectscontestedmajoritywins && self.curprogress == 0) {
    if(self can_claim(sentient)) {
      set_claim_team(sentient.team);
      self.claimplayer = sentient;
      var_4cb15f1 = self get_relative_team(sentient.team);

      if(isDefined(self.var_faffc842) && isDefined(self.var_faffc842[var_4cb15f1])) {
        self.usetime = self.var_faffc842[var_4cb15f1];
      }

      self notify(#"engaged");
      self.inuse = 1;

      if(self.usetime && isDefined(self.onbeginuse)) {
        if(isDefined(self.classobj)) {
          self.classobj[[self.onbeginuse]](self, self.claimplayer);
        } else {
          self[[self.onbeginuse]](self.claimplayer);
        }
      }
    } else if(isDefined(self.oncantuse)) {
      self[[self.oncantuse]](sentient);
    }
  } else if(self function_4b64b7fd(sentient.team) && self can_claim(sentient) && get_num_touching(self.var_a4926509) == 0) {
    return true;
  }

  return false;
}

function prox_trigger_think() {
  level endon(#"game_ended");
  self.trigger endon(#"destroyed", #"death");
  entitynumber = self.entnum;

  while(true) {
    waitresult = self.trigger waittill(#"trigger");
    sentient = waitresult.activator;

    if(game.state != # "playing") {
      continue;
    }

    if(!self can_touch(sentient) || !isDefined(sentient.touchtriggers)) {
      continue;
    }

    resume_use = self function_bbb55f41(sentient);

    if(isalive(sentient) && !isDefined(sentient.touchtriggers[entitynumber])) {
      sentient thread trigger_touch_think(self);

      if(resume_use && isDefined(self.onresumeuse)) {
        self[[self.onresumeuse]](sentient);
      }
    }
  }
}

function is_excluded(sentient) {
  if(!isDefined(self.exclusions)) {
    return false;
  }

  foreach(exclusion in self.exclusions) {
    if(isDefined(exclusion) && sentient is_touching_trigger(exclusion)) {
      return true;
    }
  }

  return false;
}

function clear_progress() {
  self.curprogress = 0;
  self.decayprogressmin = 0;
  self update_current_progress();

  if(isDefined(self.onuseclear)) {
    self[[self.onuseclear]]();
  }
}

function function_3510971a(enabled) {
  self.var_5083077c = enabled;
}

function set_claim_team(newteam) {
  new_user = newteam;
  assert(new_user != self.var_a4926509);

  if(self.var_5083077c !== 1) {
    if(!self.decayprogress && !self function_350d0352() && gettime() - self.lastclaimtime > int(self.claimgraceperiod * 1000)) {
      self clear_progress();
    } else if(function_7db44d1b(new_user) && new_user != self.var_5f35f19a) {
      self clear_progress();
    }
  }

  self.var_5f35f19a = self.var_a4926509;
  self.lastclaimtime = gettime();
  self.var_a4926509 = new_user;
  self update_use_rate();
}

function is_touching_trigger(trigger) {
  return self istouching(trigger);
}

function continue_trigger_touch_think(team, object) {
  if(!isalive(self)) {
    return false;
  }

  if(is_true(self.laststand) && !is_true(self.can_capture) && !is_true(self.can_contest)) {
    return false;
  }

  if(!isDefined(object) || !isDefined(object.trigger)) {
    return false;
  }

  if(!object.trigger istriggerenabled()) {
    return false;
  }

  if(!object can_touch(self)) {
    return false;
  }

  if(!self is_touching_trigger(object.trigger)) {
    return false;
  }

  return true;
}

function allow_vehicle_proximity_pickup(b_enable) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.b_allow_vehicle_proximity_pickup = b_enable;
}

function function_ad0c0995(callbackfunc) {
  level.var_5daabc2f = callbackfunc;
}

function function_56be3b4b(player, var_9e1307f8) {
  if(!self.var_5c196da4) {
    return;
  }

  user = function_4e3386a8(player.team);
  function_136c2270(user);
  return function_a1839d6b(user, player, var_9e1307f8);
}

function setplayergametypeuseratecallback(callbackfunc) {
  self.var_def3c25b = callbackfunc;
}

function function_14c9bdaa() {
  player_use_rate = 1;

  if(isDefined(self.playerrole) && isDefined(self.playerrole.gameobjectuserate)) {
    player_use_rate = self.playerrole.gameobjectuserate;
  }

  if(isDefined(self.var_def3c25b)) {
    player_use_rate *= self[[self.var_def3c25b]](self);
  }

  return player_use_rate;
}

function trigger_touch_think(object) {
  object.trigger endon(#"destroyed", #"death");
  user = function_4e3386a8(self.team);
  player_use_rate = self function_14c9bdaa();
  object function_818d69ee(user);
  object function_22c9de38(user);
  object function_f1342bb2(user, player_use_rate);
  var_5717fa0c = self getentitynumber();
  object function_fdf87288(user, self, player_use_rate, var_5717fa0c);
  contribution = object function_56be3b4b(self, var_5717fa0c);

  if(isDefined(level.var_10c0e6bb)) {
    self thread[[level.var_10c0e6bb]](object, 1);
  }

  if(object.usetime) {
    object update_use_rate();
  }

  if(isDefined(object.objectiveid) && object.type != "carryObject") {
    if(isPlayer(self)) {
      objective_setplayerusing(object.objectiveid, self);
    } else {
      objective_setplayerusing(object.objectiveid, self.owner);
    }
  }

  self.touchtriggers[object.entnum] = object.trigger;

  if(isDefined(object.ontouchuse)) {
    object[[object.ontouchuse]](self);
  }

  if(is_true(self.var_17bc9194)) {
    object.curprogress = object.usetime + 1;
    object.users[object.var_a4926509].touching.num = 1;
    self.var_17bc9194 = undefined;

    while(object.curprogress >= 1) {
      waitframe(1);
    }
  } else {
    if(object.usetime == 0 && level.var_c85170d1 === 1) {
      object update_use_rate();
    }

    while(isDefined(self) && self continue_trigger_touch_think(self.team, object)) {
      waitframe(1);
    }
  }

  if(isDefined(self)) {
    self.touchtriggers[object.entnum] = undefined;

    if(isDefined(object.objectiveid) && object.type != "carryObject") {
      if(isPlayer(self)) {
        objective_clearplayerusing(object.objectiveid, self);
      } else {
        objective_clearplayerusing(object.objectiveid, self.owner);
      }
    }
  } else {
    object function_f30290b(user, var_5717fa0c);
  }

  if(game.state != # "playing") {
    return;
  }

  if(isDefined(contribution)) {
    contribution.var_e22ea52b = 0;
  }

  object function_472b3c15(user, var_5717fa0c);
  object function_26237f3c(user);
  object function_27b84c22(user, player_use_rate);

  if(isDefined(level.var_10c0e6bb)) {
    self thread[[level.var_10c0e6bb]](object);
  }

  if(object.usetime) {
    if(object get_num_touching(user) <= 0 && object.curprogress >= object.usetime) {
      object.curprogress = object.usetime - 1;
      object update_current_progress();
    }
  }

  if(isDefined(object.onendtouchuse)) {
    object[[object.onendtouchuse]](self);
  }

  object update_use_rate();
}

function update_use_rate() {
  numclaimants = get_num_touching(self.var_a4926509);
  claimantsuserate = function_9f894584(self.var_a4926509);
  numother = 0;
  numother = function_3a7a2963(self.var_a4926509);
  otheruserate = function_a7dbb00b(self.var_a4926509);
  self.userate = 0;

  if(self.decayprogress) {
    if(numclaimants && !numother) {
      self.userate = claimantsuserate;
    } else if(!numclaimants && numother) {
      self.userate = otheruserate;
    } else if(!numclaimants && !numother) {
      self.userate = 0;
    } else if(numclaimants && numother && level.gameobjectscontestedmajoritywins) {
      self.userate = self function_21db7d02(numclaimants, numother);
    }
  } else if(numclaimants && !numother) {
    self.userate = claimantsuserate;
  }

  if(isDefined(self.onupdateuserate)) {
    self[[self.onupdateuserate]]();
  }
}

function use_hold_think(player, disableweaponcyclingduringhold) {
  player notify(#"use_hold");

  if(!isDefined(self.var_bca8171a)) {
    self.var_bca8171a = spawnStruct();
  }

  self.var_bca8171a.player = player;

  if(!is_true(self.dontlinkplayertotrigger)) {
    if(!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
      gameobject_link = util::spawn_model("tag_origin", player.origin, player.angles);

      if(is_true(self.var_2e39d9ef)) {
        player playerlinktodelta(gameobject_link, "tag_origin", 1, 0, 0, 0, 0);
      } else {
        player playerlinkto(gameobject_link);
      }
    } else {
      player playerlinkto(self.trigger);
      player playerlinkedoffsetenable();
    }
  }

  player clientclaimtrigger(self.trigger);
  player.claimtrigger = self.trigger;
  useweapon = self.useweapon;

  if(isDefined(useweapon)) {
    if(is_true(useweapon.var_d2751f9d)) {
      player val::set(#"gameobject_use", "disable_gestures");
    }

    if(!player hasweapon(useweapon)) {
      player giveweapon(useweapon);
    }

    player setweaponammostock(useweapon, 0);
    player setweaponammoclip(useweapon, 0);
    player switchtoweapon(useweapon);
  } else if(self.keepweapon !== 1) {
    player val::set(#"gameobject_use", "disable_weapons");
  }

  self clear_progress();
  self.inuse = 1;
  self.userate = 0;

  if(isDefined(self.objectiveid)) {
    objective_setplayerusing(self.objectiveid, player);
  }

  if(disableweaponcyclingduringhold) {
    player disableweaponcycling();
    enableweaponcyclingafterhold = 1;
    self.var_bca8171a.enableweaponcycling = 1;
  }

  if(self.var_fd6764c2 === 1 && player getstance() === "stand") {
    player val::set("gameobjects", "allow_crouch", 0);
    player val::set("gameobjects", "allow_prone", 0);
  }

  if(is_true(player.var_17bc9194)) {
    self.curprogress = self.usetime;
    result = 1;
    player.var_17bc9194 = undefined;
  } else {
    result = use_hold_think_loop(player);

    if(!isDefined(result)) {
      result = 0;
    }
  }

  self.inuse = 0;

  if(isDefined(player)) {
    if(enableweaponcyclingafterhold === 1) {
      player enableweaponcycling();
      self.var_bca8171a.enableweaponcycling = 0;
    }

    player val::reset("gameobjects", "allow_crouch");
    player val::reset("gameobjects", "allow_prone");

    if(isDefined(self.objectiveid)) {
      objective_clearplayerusing(self.objectiveid, player);
    }

    self clear_progress();

    if(isDefined(player.attachedusemodel)) {
      player detach(player.attachedusemodel, "tag_inhand");
      player.attachedusemodel = undefined;
    }

    player notify(#"done_using");
    player.claimtrigger = undefined;
    player clientreleasetrigger(self.trigger);

    if(isDefined(useweapon) && !(self.var_dddda5d8 === 1 && result === 1)) {
      player thread take_use_weapon(useweapon);
      player killstreaks::switch_to_last_non_killstreak_weapon();
    } else if(self.keepweapon !== 1) {
      player val::reset(#"gameobject_use", "disable_weapons");
    }

    if(!is_true(self.dontlinkplayertotrigger)) {
      player unlink();
    }

    if(!isalive(player)) {
      player.killedinuse = 1;
    }

    if(level.gameended) {
      player waitthenfreezeplayercontrolsifgameendedstill();
    }
  }

  if(isDefined(gameobject_link)) {
    gameobject_link delete();
  }

  return result;
}

function waitthenfreezeplayercontrolsifgameendedstill(wait_time = 1) {
  player = self;
  wait wait_time;

  if(isDefined(player) && level.gameended) {
    player val::set(#"gameobjects_gameended", "freezecontrols", 1);
  }
}

function take_use_weapon(useweapon) {
  self endon(#"use_hold", #"death", #"disconnect");
  level endon(#"game_ended");

  while(self getcurrentweapon() == useweapon && !self.throwinggrenade) {
    waitframe(1);
  }

  if(is_true(useweapon.var_d2751f9d)) {
    self val::reset(#"gameobject_use", "disable_gestures");
  }

  if(self hasweapon(useweapon)) {
    self takeweapon(useweapon);
  }
}

function has_line_of_sight(player) {
  eye = player util::get_eye();
  trace = sighttracepassed(eye, self.origin, 0, self.parentobj, player);
  return trace;
}

function continue_hold_think_loop(player, waitforweapon, timedout, usetime) {
  maxwaittime = 1.5;

  if(!isalive(player)) {
    return false;
  }

  if(isDefined(player.laststand) && player.laststand) {
    return false;
  }

  if(self.curprogress >= usetime) {
    return false;
  }

  if(!player useButtonPressed()) {
    return false;
  }

  if(player isinexecutionvictim()) {
    return false;
  }

  if(player function_f75eb1ae()) {
    return false;
  }

  if(player.throwinggrenade && (player isthrowinggrenade() || player function_55acff10()) && (!isDefined(self.var_c2f21609) || self.var_c2f21609 != 14 && self.var_c2f21609 != 15)) {
    return false;
  }

  if(player isinvehicle()) {
    return false;
  }

  if(player isremotecontrolling() || player util::isusingremote()) {
    return false;
  }

  if(is_true(player.selectinglocation)) {
    return false;
  }

  if(player isweaponviewonlylinked()) {
    return false;
  }

  if(isDefined(self.var_1567ba56)) {
    if(!self[[self.var_1567ba56]](player)) {
      return false;
    }
  } else if(!player is_touching_trigger(self.trigger)) {
    if(!isDefined(player.cursorhintent) || player.cursorhintent != self) {
      return false;
    }
  }

  if(is_true(self.requireslos) && !has_line_of_sight(player)) {
    return false;
  }

  if(is_true(self.var_fd6764c2) && player getstance() !== "stand") {
    return false;
  }

  if(!self.userate && !waitforweapon) {
    return false;
  }

  if(waitforweapon && timedout > maxwaittime) {
    return false;
  }

  if(is_true(self.interrupted)) {
    return false;
  }

  if(game.state != # "playing") {
    return false;
  }

  return true;
}

function update_current_progress() {
  if(self.usetime) {
    if(isDefined(self.curprogress)) {
      progress = float(self.curprogress) / self.usetime;
    } else {
      progress = 0;
    }

    if(isDefined(self.objectiveid)) {
      objective_setprogress(self.objectiveid, math::clamp(progress, 0, 1));
    }
  }
}

function use_hold_think_loop(player) {
  self endon(#"disabled");
  useweapon = self.useweapon;
  waitforweapon = 1;
  timedout = 0;

  while(self continue_hold_think_loop(player, waitforweapon, timedout, self.usetime)) {
    if(!isDefined(useweapon) || useweapon == level.weaponnone || player getcurrentweapon() == useweapon) {
      playerusemultiplier = 1;

      if(isDefined(self.getuseratemultiplier)) {
        playerusemultiplier = self[[self.getuseratemultiplier]](player);
      }

      if(waitforweapon) {
        userate = isDefined(self.userate) && self.userate !== 0 ? self.userate : 1;
        self.curprogress += int(timedout * 1000) * userate * playerusemultiplier;
      }

      previousprogress = self.curprogress;
      self.curprogress += level.var_9fee970c * self.userate * playerusemultiplier;
      deltaprogress = self.curprogress - previousprogress;
      self function_72307b09(deltaprogress);
      self update_current_progress();

      if(isDefined(self.onuseupdate)) {
        self[[self.onuseupdate]](self function_14fccbd9(), self.curprogress / self.usetime, deltaprogress / self.usetime);
      }

      if(isDefined(self.var_ff74c7e9)) {
        self[[self.var_ff74c7e9]](self function_14fccbd9(), self.curprogress / self.usetime, deltaprogress / self.usetime);
      }

      self.userate = 1;
      waitforweapon = 0;
    } else {
      self.userate = 0;
    }

    if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
      if(self.curprogress >= self.usetime) {
        return true;
      }

      waitframe(1);
    } else {
      waitframe(1);

      if(self.curprogress >= self.usetime) {
        util::wait_network_frame();
        return true;
      }
    }

    timedout += float(function_60d95f53()) / 1000;
    hostmigration::waittillhostmigrationdone();
  }

  return false;
}

function update_trigger() {
  if(self.triggertype != "use") {
    return;
  }

  if(!isDefined(self.trigger)) {
    return;
  }

  if(isDefined(self.absolute_visible_and_interact_team)) {
    self.trigger triggerenable(1);
    self.trigger setteamfortrigger(self.absolute_visible_and_interact_team);
    return;
  }

  if(self.interactteam == # "group_none") {
    self.trigger triggerenable(0);
    return;
  }

  if(self.interactteam == # "group_friendly") {
    self.trigger triggerenable(1);

    if(isDefined(level.teams[self.ownerteam])) {
      self.trigger setteamfortrigger(self.ownerteam);
    } else {
      self.trigger triggerenable(0);
    }

    return;
  }

  if(self.interactteam == # "group_enemy") {
    self.trigger triggerenable(1);
    self.trigger setexcludeteamfortrigger(self.ownerteam);
    return;
  }

  if(self.interactteam == # "group_all" || !level.teambased) {
    self.trigger triggerenable(1);
    self.trigger setteamfortrigger(#"invalid");
  }
}

function update_objective() {
  if(self.type === "GenericObject" || !isDefined(self.objectiveid)) {
    return;
  }

  if(isDefined(self.e_object) && is_true(self.e_object.var_c65066ad)) {
    function_ebffa9f6(self.objectiveid, #"none");
  } else {
    function_ebffa9f6(self.objectiveid, self.ownerteam);
  }

  if(isDefined(self.absolute_visible_and_interact_team) && self.visibleteam != # "group_none") {
    objective_setstate(self.objectiveid, "active");
    function_311b7785(self.objectiveid);
    function_e3cc1e96(self.objectiveid, self.absolute_visible_and_interact_team);
  } else if(isDefined(self.ownerteam) && (self.ownerteam == # "all" || self.ownerteam == # "any") || self.visibleteam == # "group_all") {
    objective_setstate(self.objectiveid, "active");
    function_33420053(self.objectiveid);
  } else if(isDefined(self.ownerteam) && isDefined(level.teams[self.ownerteam]) && self.visibleteam == # "group_friendly") {
    objective_setstate(self.objectiveid, "active");
    function_311b7785(self.objectiveid);
    function_e3cc1e96(self.objectiveid, self.ownerteam);
  } else if(isDefined(self.ownerteam) && isDefined(level.teams[self.ownerteam]) && self.visibleteam == # "group_enemy") {
    objective_setstate(self.objectiveid, "active");
    function_33420053(self.objectiveid);
    function_6c27e90c(self.objectiveid, self.ownerteam);
  } else {
    objective_setstate(self.objectiveid, "invisible");
    function_311b7785(self.objectiveid);
  }

  if(self.type == "carryObject" || self.type == "packObject") {
    if(isalive(self.carrier)) {
      objective_onentity(self.objectiveid, self.carrier);
      objective_setinvisibletoplayer(self.objectiveid, self.carrier);
      return;
    }

    if(isDefined(self.objectiveonvisuals) && self.objectiveonvisuals) {
      objective_onentity(self.objectiveid, self.visuals[0]);
      return;
    }

    if(isDefined(self.objectiveonself) && self.objectiveonself) {
      objective_onentity(self.objectiveid, self);
      return;
    }

    objective_clearentity(self.objectiveid);
  }
}

function function_c59e69d3(team) {
  mdl_gameobject = self function_fd4a5f2f();

  if(!isDefined(team)) {
    team = team.ownerteam;
  }

  team = util::get_team_mapping(team);
  function_29ef32ee(mdl_gameobject.objectiveid, team);
}

function function_9f42b8fd(user) {
  function_c59e69d3(user);
}

function function_2b948aef(team) {
  mdl_gameobject = self function_fd4a5f2f();
  team = util::get_team_mapping(team);
  function_29ef32ee(mdl_gameobject.objectiveid, team);
}

function hide_waypoint(e_player) {
  mdl_gameobject = self function_fd4a5f2f();

  if(!isDefined(mdl_gameobject.objectiveid)) {
    return;
  }

  if(isDefined(e_player)) {
    if(!isPlayer(e_player)) {
      assert(0, "<dev string:xd6>");
      return;
    }

    objective_setinvisibletoplayer(mdl_gameobject.objectiveid, e_player);
    return;
  }

  objective_setinvisibletoall(mdl_gameobject.objectiveid);
}

function show_waypoint(e_player) {
  mdl_gameobject = self function_fd4a5f2f();

  if(!isDefined(mdl_gameobject.objectiveid)) {
    return;
  }

  if(isDefined(e_player)) {
    if(!isPlayer(e_player)) {
      assert(0, "<dev string:x116>");
      return;
    }

    objective_setvisibletoplayer(mdl_gameobject.objectiveid, e_player);
    return;
  }

  objective_setvisibletoall(mdl_gameobject.objectiveid);
}

function function_924032a4() {
  mdl_gameobject = self function_fd4a5f2f();
  objective_setvisibletoall(mdl_gameobject.objectiveid);
}

function should_ping_object(relativeteam) {
  if(relativeteam == # "group_friendly" && self.objidpingfriendly) {
    return true;
  } else if(relativeteam == # "group_enemy" && self.objidpingenemy) {
    return true;
  }

  return false;
}

function should_show_compass_due_to_radar(team) {
  showcompass = 0;

  if(!isDefined(self.carrier)) {
    return 0;
  }

  if(self.carrier hasperk(#"specialty_gpsjammer") == 0) {
    if(killstreaks::hasuav(team)) {
      showcompass = 1;
    }
  }

  if(killstreaks::hassatellite(team)) {
    showcompass = 1;
  }

  return showcompass;
}

function private _set_team(team) {
  self.ownerteam = team;

  if(team != # "any") {
    self.team = team;

    foreach(visual in self.visuals) {
      visual.team = team;
    }
  }
}

function set_owner_team(team) {
  mdl_gameobject = self function_fd4a5f2f();
  team = util::get_team_mapping(team);
  mdl_gameobject _set_team(team);
  mdl_gameobject update_trigger();
  mdl_gameobject update_objective();
}

function get_owner_team() {
  mdl_gameobject = self function_fd4a5f2f();
  return mdl_gameobject.ownerteam;
}

function function_167d3a40() {
  return get_owner_team();
}

function function_2efe0342() {
  self allow_use(#"group_none");
}

function function_407c83be() {
  if(isDefined(level.a_gameobjects)) {
    array::thread_all(level.a_gameobjects, &function_2efe0342);
  }
}

function function_664b40(player) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.trigger setvisibletoplayer(player);
  mdl_gameobject show_waypoint(player);
}

function function_7a00d78c(player) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.trigger setinvisibletoplayer(player);
  mdl_gameobject hide_waypoint(player);
}

function function_8046ddd0(player) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.trigger setinvisibletoplayer(player);
}

function function_6cdadc59(point) {
  if(isDefined(level.a_gameobjects)) {
    return arraygetclosest(point, level.a_gameobjects);
  }
}

function set_decay_time(time) {
  self.decaytime = int(time * 1000);
}

function set_use_time(time) {
  self.usetime = int(time * 1000);
}

function function_e887a9d0(time) {
  self.var_9288c4c0 = int(time * 1000);
}

function function_3dc7107c(var_aad2b0a1) {
  self.maxusers = var_aad2b0a1;
}

function function_3c3a122f(var_a6f93bb0, time) {
  if(!isDefined(self.var_faffc842)) {
    self.var_faffc842 = [];
  }

  self.var_faffc842[var_a6f93bb0] = int(time * 1000);
}

function function_86d3b442(time) {
  self.var_d0b697a4 = int(time * 1000);
}

function set_use_text(text) {
  self.usetext = text;
}

function set_use_hint_text(text) {
  self.trigger sethintstring(text);
}

function allow_carry(relativeteam) {
  function_9ddbc967(relativeteam);

  allow_use(relativeteam);
}

function allow_use(relativeteam) {
  function_9ddbc967(relativeteam);

  mdl_gameobject = self function_fd4a5f2f();
  mdl_gameobject.interactteam = relativeteam;
  mdl_gameobject update_trigger();
}

function function_9ddbc967(group) {
  if(is_relative_team(group)) {
    return;
  }

  assertmsg("<dev string:x156>" + group);
}

function set_visible(relativeteam) {
  function_9ddbc967(relativeteam);

  mdl_gameobject = self function_fd4a5f2f();

  if(!isDefined(mdl_gameobject)) {
    return;
  }

  mdl_gameobject.visibleteam = relativeteam;
  mdl_gameobject update_objective();
}

function set_model_visibility(visibility, var_41e71541) {
  if(visibility) {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index] show();

      if(self.visuals[index].classname == "script_brushmodel" && !is_true(var_41e71541) || self.visuals[index].classname == "script_model") {
        self.visuals[index] thread make_solid();
      }
    }

    return;
  }

  for(index = 0; index < self.visuals.size; index++) {
    self.visuals[index] ghost();

    if(self.visuals[index].classname == "script_brushmodel" && !is_true(var_41e71541) || self.visuals[index].classname == "script_model") {
      self.visuals[index] notify(#"changing_solidness");
      self.visuals[index] notsolid();
    }
  }
}

function make_solid() {
  self endon(#"death");
  self notify(#"changing_solidness");
  self endon(#"changing_solidness");

  while(true) {
    for(i = 0; i < level.players.size; i++) {
      if(level.players[i] is_touching_trigger(self)) {
        break;
      }
    }

    if(i == level.players.size) {
      self solid();
      break;
    }

    waitframe(1);
  }
}

function set_2d_icon(relativeteam, shader) {
  self.compassicons[relativeteam] = shader;
}

function set_3d_icon(relativeteam, shader) {
  if(!isDefined(shader)) {
    self.worldicons_disabled[relativeteam] = 1;
  } else {
    self.worldicons_disabled[relativeteam] = 0;
  }

  self.worldicons[relativeteam] = shader;
}

function set_objective_entity(entity) {
  if(isDefined(self.objectiveid)) {
    objective_onentity(self.objectiveid, entity);
  }
}

function function_ab00d417(objectivename) {
  if(isDefined(self.objectiveid)) {
    function_18fbab10(self.objectiveid, objectivename);
  }
}

function get_objective_ids(team) {
  a_objective_ids = [];

  if(isDefined(self.objectiveid)) {
    if(!isDefined(a_objective_ids)) {
      a_objective_ids = [];
    } else if(!isarray(a_objective_ids)) {
      a_objective_ids = array(a_objective_ids);
    }

    a_objective_ids[a_objective_ids.size] = self.objectiveid;
  }

  return a_objective_ids;
}

function gameobject_is_player_looking_at(origin, dot, do_trace, ignore_ent, ignore_trace_distance) {
  assert(isPlayer(self), "<dev string:x169>");

  if(!isDefined(dot)) {
    dot = 0.7;
  }

  if(!isDefined(do_trace)) {
    do_trace = 1;
  }

  eye = self util::get_eye();
  delta_vec = anglesToForward(vectortoangles(origin - eye));
  view_vec = anglesToForward(self getplayerangles());
  new_dot = vectordot(delta_vec, view_vec);

  if(new_dot >= dot) {
    if(do_trace) {
      trace = bulletTrace(eye, origin, 0, ignore_ent);

      if(trace[# "position"] == origin) {
        return true;
      } else if(isDefined(ignore_trace_distance)) {
        n_mag = distance(origin, eye);
        n_dist = distance(trace[# "position"], eye);
        n_delta = abs(n_dist - n_mag);

        if(n_delta <= ignore_trace_distance) {
          return true;
        }
      }
    } else {
      return true;
    }
  }

  return false;
}

function hide_icons(team) {
  if(self.visibleteam == # "group_all" || self.visibleteam == # "group_friendly") {
    hide_friendly = 1;
  } else {
    hide_friendly = 0;
  }

  if(self.visibleteam == # "group_all" || self.visibleteam == # "group_enemy") {
    hide_enemy = 1;
  } else {
    hide_enemy = 0;
  }

  self.hidden_compassicon = [];
  self.hidden_worldicon = [];

  if(hide_friendly == 1) {
    self.hidden_compassicon[# "group_friendly"] = self.compassicons[# "group_friendly"];
    self.hidden_worldicon[# "group_friendly"] = self.worldicons[# "group_friendly"];
  }

  if(hide_enemy == 1) {
    self.hidden_compassicon[# "group_enemy"] = self.compassicons[# "enemyy"];
    self.hidden_worldicon[# "group_enemy"] = self.worldicons[# "group_enemy"];
  }

  self set_2d_icon(team, undefined);
  self set_3d_icon(team, undefined);
}

function show_icons(team) {
  if(isDefined(self.hidden_compassicon[team])) {
    self set_2d_icon(team, self.hidden_compassicon[team]);
  }

  if(isDefined(self.hidden_worldicon[team])) {
    self set_3d_icon(team, self.hidden_worldicon[team]);
  }
}

function set_3d_use_icon(relativeteam, shader) {
  self.worlduseicons[relativeteam] = shader;
}

function set_3d_is_waypoint(relativeteam, waypoint) {
  self.worldiswaypoint[relativeteam] = waypoint;
}

function set_carry_icon(shader) {
  assert(self.type == "<dev string:x19a>", "<dev string:x1a9>");
  self.carryicon = shader;
}

function set_visible_carrier_model(visiblemodel) {
  self.visiblecarriermodel = visiblemodel;
}

function get_visible_carrier_model() {
  return self.visiblecarriermodel;
}

function destroy_object(deletetrigger, forcehide, b_connect_paths = 0, b_success = 0) {
  mdl_gameobject = function_fd4a5f2f();

  if(isDefined(mdl_gameobject.e_object)) {
    mdl_gameobject.e_object flag::set(#"gameobject_destroyed");
  }

  mdl_gameobject endon(#"death");

  if(!isDefined(forcehide)) {
    forcehide = 1;
  }

  mdl_gameobject disable_object(forcehide, undefined, b_success, 1);

  if(isDefined(self.c_door) && self.c_door.m_str_type === "security") {
    if(isDefined(self.c_door.m_e_door)) {
      self.c_door.m_e_door notify(#"door_cleared");
    }
  }

  waittillframeend();

  foreach(visual in mdl_gameobject.visuals) {
    if(b_connect_paths) {
      visual connectpaths();
    }

    if(isDefined(visual)) {
      visual ghost();
      visual delete();
    }
  }

  if(isDefined(mdl_gameobject.trigger)) {
    mdl_gameobject.trigger notify(#"destroyed");

    if(is_true(deletetrigger)) {
      mdl_gameobject.trigger delete();
    } else {
      mdl_gameobject.trigger triggerenable(1);
    }
  }

  if(isinarray(level.a_gameobjects, mdl_gameobject)) {
    arrayremovevalue(level.a_gameobjects, mdl_gameobject);
  }

  if(isDefined(mdl_gameobject.var_bca8171a) && isDefined(mdl_gameobject.var_bca8171a.player)) {
    if(isDefined(mdl_gameobject.var_bca8171a.enableweaponcycling) && mdl_gameobject.var_bca8171a.enableweaponcycling) {
      mdl_gameobject.var_bca8171a.player enableweaponcycling();
    }
  }

  if(isDefined(mdl_gameobject.var_bca8171a) && isDefined(mdl_gameobject.var_bca8171a.player)) {
    mdl_gameobject.var_bca8171a.player val::reset(#"carry_object", "disable_weapons");
  }

  if(isDefined(mdl_gameobject.droptrigger)) {
    mdl_gameobject.droptrigger delete();
  }

  mdl_gameobject notify(#"destroyed_complete");
  e_container = mdl_gameobject.e_object;

  if(!isDefined(e_container) || !is_true(e_container.var_c65066ad)) {
    mdl_gameobject release_all_objective_ids();
  }

  mdl_gameobject delete();
}

function disable_object(var_fa771a51, var_ffd61eb5 = 1, b_success = 0, b_destroyed = 0) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.b_enabled = undefined;
  mdl_gameobject notify(#"disabled");

  if(isDefined(mdl_gameobject.type) && (mdl_gameobject.type == "carryObject" || mdl_gameobject.type == "packObject") || is_true(var_fa771a51)) {
    if(isDefined(mdl_gameobject.carrier)) {
      mdl_gameobject.carrier take_object(mdl_gameobject);
    }

    for(i = 0; i < mdl_gameobject.visuals.size; i++) {
      if(isDefined(mdl_gameobject.visuals[i])) {
        mdl_gameobject.visuals[i] ghost();
        mdl_gameobject.visuals[i] notsolid();
      }
    }
  }

  if(isDefined(mdl_gameobject.trigger)) {
    mdl_gameobject.trigger triggerenable(0);
  }

  if(var_ffd61eb5) {
    if(!isDefined(mdl_gameobject.str_restore_visible_team_after_disable)) {
      mdl_gameobject.str_restore_visible_team_after_disable = mdl_gameobject.visibleteam;
    }

    mdl_gameobject set_visible(#"group_none");

    if(isDefined(mdl_gameobject.objectiveid)) {
      objective_clearentity(mdl_gameobject.objectiveid);

      if(isDefined(mdl_gameobject.var_25010336)) {
        release_obj_id(mdl_gameobject.objectiveid);
        objective_delete(mdl_gameobject.objectiveid);
        mdl_gameobject.objectiveid = undefined;
      }
    }
  }

  e_container = mdl_gameobject.e_object;

  if(isDefined(e_container) && is_true(e_container.var_c65066ad)) {
    e_container function_8dbe8332(b_success, b_destroyed);
  }
}

function enable_object(var_13c260df, b_show_objective = 1) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject endon(#"death");
  e_container = mdl_gameobject.e_object;

  if(isDefined(e_container) && is_true(e_container.var_c65066ad)) {
    e_container function_35a012bf();
  }

  mdl_gameobject.b_enabled = 1;

  if(isDefined(mdl_gameobject.type) && (mdl_gameobject.type == "carryObject" || mdl_gameobject.type == "packObject") || is_true(var_13c260df)) {
    for(i = 0; i < mdl_gameobject.visuals.size; i++) {
      mdl_gameobject.visuals[i] show();
      mdl_gameobject.visuals[i] solid();
    }
  }

  if(isDefined(mdl_gameobject.trigger)) {
    mdl_gameobject.trigger triggerenable(1);
  }

  if(b_show_objective) {
    if(!isDefined(mdl_gameobject.objectiveid) && isDefined(mdl_gameobject.var_25010336)) {
      mdl_gameobject[[mdl_gameobject.var_25010336]]();
    }

    if(isDefined(mdl_gameobject.str_restore_visible_team_after_disable)) {
      mdl_gameobject set_visible(mdl_gameobject.str_restore_visible_team_after_disable);
      mdl_gameobject.str_restore_visible_team_after_disable = undefined;
    } else if(isDefined(mdl_gameobject.visibleteam)) {
      mdl_gameobject set_visible(mdl_gameobject.visibleteam);
    } else {
      mdl_gameobject set_visible(#"group_all");
    }

    if(isDefined(mdl_gameobject.objectiveid)) {
      objective_onentity(mdl_gameobject.objectiveid, mdl_gameobject);

      if(mdl_gameobject.type == "carryObject" || mdl_gameobject.type == "packObject") {
        mdl_gameobject notify(#"hash_431541b507a8c588");
        objective_setposition(mdl_gameobject.objectiveid, (0, 0, 0));
      }
    }
  }
}

function get_relative_team(team) {
  team = util::get_team_mapping(team);

  if(self.ownerteam == # "any") {
    return # "group_friendly";
  }

  if(team == self.ownerteam) {
    return # "group_friendly";
  } else if(team != self.ownerteam && team != # "neutral") {
    return # "group_enemy";
  }

  return # "group_none";
}

function can_touch(sentient) {
  var_47a62b7b = isvehicle(sentient) || isPlayer(sentient) && sentient isinvehicle() && !sentient function_a867284b();

  if(var_47a62b7b && !is_true(level.b_allow_vehicle_proximity_pickup) && !is_true(self.b_allow_vehicle_proximity_pickup)) {
    if(!isDefined(level.var_5daabc2f) || [[level.var_5daabc2f]](sentient) !== 1) {
      return false;
    }
  }

  if(isPlayer(sentient)) {
    if(!function_dfec159b(sentient)) {
      return false;
    }

    if(is_true(self.var_d647eb08) && sentient isreloading()) {
      return false;
    }
  } else if(!isDefined(sentient.var_69d05189) || sentient.var_69d05189 == 0) {
    return false;
  }

  if(self is_excluded(sentient)) {
    return false;
  }

  if(isDefined(self.canuseobject) && ![[self.canuseobject]](sentient)) {
    return false;
  }

  if(self.triggertype === "use" && isDefined(sentient.var_121392a1) && sentient.var_121392a1.size > 0) {
    foreach(var_cd6ef3e2 in sentient.var_121392a1) {
      if(isDefined(var_cd6ef3e2.var_4f6b79a4) && (isDefined(var_cd6ef3e2.var_4f6b79a4.var_cb34970a) ? var_cd6ef3e2.var_4f6b79a4.var_cb34970a : 0)) {
        return false;
      }
    }
  }

  return true;
}

function can_interact_with(sentient) {
  if(isDefined(self.ignore_use_time)) {
    ignore_time = self.ignore_use_time[sentient getentitynumber()];

    if(isDefined(ignore_time)) {
      if(level.time < ignore_time) {
        return 0;
      } else {
        self.ignore_use_time[sentient getentitynumber()] = undefined;
      }
    }
  }

  team = sentient.team;

  if(isDefined(self.absolute_visible_and_interact_team)) {
    if(team == self.absolute_visible_and_interact_team) {
      return 1;
    }
  }

  if(isDefined(self.requiredweapon) && isPlayer(sentient)) {
    player = sentient;

    if(!player hasweapon(self.requiredweapon)) {
      return 0;
    }

    ammocount = player getammocount(self.requiredweapon);

    if(ammocount == 0) {
      return 0;
    }
  }

  switch (self.interactteam) {
    case # "group_none":
      return 0;
    case # "group_all":
      return 1;
    case # "group_friendly":
      if(team == self.ownerteam) {
        return 1;
      } else {
        return 0;
      }
    case # "group_enemy":
      if(team != self.ownerteam) {
        return 1;
      } else if(isDefined(self.decayprogress) && self.decayprogress && self.curprogress > 0 && (!isDefined(self.decayprogressmin) || self.curprogress > self.decayprogressmin)) {
        return 1;
      } else {
        return 0;
      }
    default:
      assert(0, "<dev string:x1da>");
      return 0;
  }
}

function is_relative_team(relativeteam) {
  switch (relativeteam) {
    case # "group_friendly":
    case # "group_none":
    case # "group_enemy":
    case # "group_all":
      return 1;
    default:
      return 0;
  }
}

function set_absolute_visible_and_interact_team(team) {
  team = util::get_team_mapping(team);
  assert(team == # "allies" || team == # "axis", "<dev string:x1f2>");
  self.absolute_visible_and_interact_team = team;
}

function function_b03b5362(b_enable = 1) {
  mdl_gameobject = self function_fd4a5f2f();
  mdl_gameobject.disallowvehicleusage = !b_enable;
}

function function_8f776dd0(b_enable = 1) {
  mdl_gameobject = self function_fd4a5f2f();
  mdl_gameobject.trigger function_67f9bbb6();
  mdl_gameobject.var_fd6764c2 = b_enable;
}

function get_next_obj_id() {
  if(level.numgametypereservedobjectives < 64) {
    nextid = level.numgametypereservedobjectives;
    level.numgametypereservedobjectives++;
  } else if(level.releasedobjectives.size > 0) {
    nextid = array::pop_front(level.releasedobjectives, 0);
  }

  if(!isDefined(nextid)) {
    println("<dev string:x227>");
    nextid = 63;
  }

  return nextid;
}

function release_obj_id(objid) {
  assert(objid < level.numgametypereservedobjectives);

  for(i = 0; i < level.releasedobjectives.size; i++) {
    if(objid == level.releasedobjectives[i] && objid == 63) {
      return;
    }

    assert(objid != level.releasedobjectives[i], "<dev string:x256>" + objid);
  }

  level.releasedobjectives[level.releasedobjectives.size] = objid;
  objective_setstate(objid, "empty");
}

function release_all_objective_ids() {
  if(isDefined(self.objid)) {
    foreach(v in self.objid) {
      release_obj_id(v);
    }
  }

  if(isDefined(self.objectiveid)) {
    release_obj_id(self.objectiveid);
  }
}

function get_label() {
  label = self.trigger.script_label;

  if(!isDefined(label)) {
    label = "";
    return label;
  }

  if(label[0] != "_") {
    return ("_" + label);
  }

  return label;
}

function must_maintain_claim(enabled) {
  self.mustmaintainclaim = enabled;
}

function can_contest_claim(enabled) {
  self.cancontestclaim = enabled;
}

function set_flags(flags) {
  if(isDefined(self.objectiveid)) {
    objective_setgamemodeflags(self.objectiveid, flags);
  }
}

function get_flags(flags) {
  if(isDefined(self.objectiveid)) {
    return objective_getgamemodeflags(self.objectiveid);
  }

  return 0;
}

function set_identifier(identifier) {
  self.identifier = identifier;
}

function get_identifier() {
  return self.identifier;
}

function create_pack_object(ownerteam, trigger, visuals, offset, objectivename, allowinitialholddelay = 0, allowweaponcyclingduringhold = 0, var_6f828297 = undefined) {
  assert(isDefined(objectivename), "<dev string:x278>");

  if(!isDefined(level.max_packobjects)) {
    level.max_packobjects = 4;
  }

  assert(level.max_packobjects < 5, "<dev string:x2aa>");

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  packobject = spawn("script_model", trigger.origin);
  packobject.type = "packObject";
  packobject.curorigin = trigger.origin;
  packobject.entnum = trigger getentitynumber();

  if(issubstr(trigger.classname, "use")) {
    packobject.triggertype = "use";
  } else {
    packobject.triggertype = "proximity";
  }

  trigger.baseorigin = trigger.origin;
  packobject.trigger = trigger;
  trigger enablelinkto();
  packobject linkto(trigger);
  packobject.useweapon = undefined;

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  packobject.visuals = visuals;
  packobject _set_team(ownerteam);
  packobject.compassicons = [];
  packobject.objidpingfriendly = 0;
  packobject.objidpingenemy = 0;

  if(packobject function_4ea98a09()) {
    assert(isDefined(objectivename), "<dev string:x38>");
    packobject.objid = [];
    level.objidstart += 2;
    packobject.objectiveid = get_next_obj_id();
    objective_add(packobject.objectiveid, "invisible", packobject.curorigin, objectivename);

    if(isDefined(var_6f828297)) {
      function_18fbab10(packobject.objectiveid, var_6f828297);
    }
  }

  packobject.carrier = undefined;
  packobject.isresetting = 0;
  packobject.interactteam = # "group_none";
  packobject.allowweapons = 1;
  packobject.visiblecarriermodel = undefined;
  packobject.dropoffset = 0;
  packobject.worldicons = [];
  packobject.carriervisible = 0;
  packobject.visibleteam = # "group_none";
  packobject.worldiswaypoint = [];
  packobject.worldicons_disabled = [];
  packobject.packicon = undefined;
  packobject.setdropped = undefined;
  packobject.ondrop = undefined;
  packobject.onpickup = undefined;
  packobject.onreset = undefined;
  packobject.usetime = 10000;
  packobject.var_9288c4c0 = packobject.usetime;
  packobject.decayprogress = 0;
  packobject.var_98bb0715 = 1;
  packobject.var_5c196da4 = 0;

  if(packobject.triggertype == "use") {
    packobject.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    packobject.userate = 1;
    packobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
  } else {
    packobject function_e553e480();
    packobject thread use_object_prox_think();
  }

  packobject thread update_carry_object_objective_origin();
  packobject.b_reusable = 1;
  return packobject;
}

function give_pack_object(object) {
  self.packobject[self.packobject.size] = object;
  self thread track_carrier(object);
}

function get_packicon_offset(index = 0) {
  if(self issplitscreen()) {
    size = 25;
    base = -130;
  } else {
    size = 35;
    base = -40;
  }

  int = base - size * index;
  return int;
}

function adjust_remaining_packicons() {
  if(!isDefined(self.packicon)) {
    return;
  }

  if(self.packicon.size > 0) {
    for(i = 0; i < self.packicon.size; i++) {
      self.packicon[i].x = get_packicon_offset(i);
    }
  }
}

function set_pack_icon(shader) {
  assert(self.type == "<dev string:x2f4>", "<dev string:x302>");
  self.packicon = shader;
}

function init_game_objects(str_gameobject_bundle, str_team_override, b_allow_companion_command, t_override, a_keyline_objects, str_objective_override, str_tag_override, str_identifier_override) {
  c_interact_obj = new cinteractobj();
  c_interact_obj.e_object = self;
  str_bundle = undefined;

  if(isDefined(str_gameobject_bundle)) {
    str_bundle = str_gameobject_bundle;
    self.scriptbundlename = str_bundle;
  } else if(self.classname === "scriptbundle_gameobject") {
    str_bundle = self.scriptbundlename;
  }

  assert(isDefined(str_bundle), "<dev string:x335>" + self.origin);
  [[c_interact_obj]] - > init_game_object(str_bundle, str_team_override, str_tag_override, str_identifier_override, a_keyline_objects, t_override, b_allow_companion_command, str_objective_override);
  return c_interact_obj;
}

function assign_class_object(o_class) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.classobj = o_class;
}

function set_onbeginuse_event(func) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.onbeginuse = func;
}

function set_onuse_event(func) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.onuse = func;
}

function set_onenduse_event(func) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.onenduse = func;
}

function set_onpickup_event(func) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.onpickup = func;
}

function function_13798243(func) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.ondrop = func;
}

function function_997b21ed(func) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.oncantuse = func;
}

function function_6362d6ea(func) {
  mdl_gameobject = function_fd4a5f2f();
  mdl_gameobject.onuseupdate = func;
}

function private function_fd4a5f2f() {
  if(isDefined(self.mdl_gameobject)) {
    return self.mdl_gameobject;
  }

  return self;
}

function play_interact_anim(e_player) {
  e_player endon(#"disconnect");

  if(isDefined(self.str_player_scene_anim)) {
    str_player_scene = self.str_player_scene_anim;

    if(is_true(self.b_use_gameobject_for_alignment)) {
      e_align = self.e_object;
    } else if(is_true(self.var_75ea46f6)) {
      e_align = e_player;
    } else {
      e_align = level;
    }

    a_ents = array(e_player);

    if(self.type == "carryObject") {
      if(!isDefined(a_ents)) {
        a_ents = [];
      } else if(!isarray(a_ents)) {
        a_ents = array(a_ents);
      }

      a_ents[a_ents.size] = self.visuals[0];
    }

    if(is_true(self.var_a7ef92ac)) {
      s_waitresult = self waittill(#"gameobject_end_use_player", #"gameobject_abort", #"death");

      if(s_waitresult._notify === "gameobject_end_use_player") {
        e_align thread scene::play(str_player_scene, a_ents);
      }
    } else {
      e_align thread scene::play(str_player_scene, a_ents);
      waitframe(1);

      if(isDefined(self) && isDefined(e_player.str_current_anim) && is_true(self.b_scene_use_time_override)) {
        var_484df237 = getanimlength(e_player.str_current_anim);
        self set_use_time(var_484df237);
      }

      while(e_player useButtonPressed() && isDefined(self) && isDefined(self.e_object) && !self.e_object flag::get("gameobject_end_use")) {
        waitframe(1);
      }

      e_align scene::stop(str_player_scene);

      if(isDefined(self) && self.type == "carryObject" && !isDefined(self.carrier)) {
        self thread set_dropped(e_player);
      }
    }

    return;
  }

  if(isDefined(self.str_anim)) {
    mdl_anchor = util::spawn_model("tag_origin", e_player.origin, e_player.angles);
    self thread anchor_delete_watcher(mdl_anchor);
    str_anim = self.str_anim;

    if(isDefined(str_anim)) {
      e_player thread animation::play(str_anim, mdl_anchor, undefined, 1, 0.2, 0);
    }

    if(isDefined(self.str_obj_anim)) {
      self.e_object thread animation::play(self.str_obj_anim, self.e_object, undefined, 1, 0.2, 0);
    }

    while(e_player useButtonPressed() && isDefined(self) && !self.e_object flag::get("gameobject_end_use")) {
      waitframe(1);
    }

    if(e_player.str_current_anim === str_anim) {
      e_player thread animation::stop();
    }
  }
}

function anchor_delete_watcher(mdl_anchor) {
  self.e_object waittill(#"gameobject_end_use", #"gameobject_abort");
  util::wait_network_frame();

  if(isDefined(mdl_anchor)) {
    mdl_anchor delete();
  }
}

function function_c6fa00c2() {
  if(!is_true(self.var_5c196da4)) {
    return;
  }

  contributors = [];
  var_1dbb2b2b = [];
  user = function_167d3a40();

  if(isDefined(self.users[user]) && isDefined(self.users[user].contributors) && self.users[user].contributors.size > 0) {
    var_1dbb2b2b = self.users[user].contributors;
  } else {
    user = self.var_a4926509;

    if(isDefined(self.users[user]) && isDefined(self.users[user].contributors) && self.users[user].contributors.size > 0) {
      var_1dbb2b2b = self.users[user].contributors;
    }
  }

  foreach(contribution in var_1dbb2b2b) {
    contributor = contribution.player;
    percentage = 100 * contribution.contribution / self.usetime;
    contributor.var_759a143b = int(0.5 + percentage);

    if(contributor.var_759a143b > getgametypesetting(#"contributionmin")) {
      if(!isDefined(contributors)) {
        contributors = [];
      } else if(!isarray(contributors)) {
        contributors = array(contributors);
      }

      contributors[contributors.size] = contributor;
    }
  }

  return contributors;
}

function function_e9492e8f(enabled) {
  if(self function_4ea98a09()) {
    function_9a8950ee(self.objectiveid, enabled);
  }
}