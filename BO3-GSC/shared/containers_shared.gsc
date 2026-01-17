/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\containers_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\doors_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;

class ccontainer {
  var m_e_container;

  constructor() {}

  destructor() {}

  function init_xmodel(str_xmodel = "script_origin", v_origin, v_angles) {
    m_e_container = util::spawn_model(str_xmodel, v_origin, v_angles);
    return m_e_container;
  }

}

#namespace containers;

function autoexec __init__sytem__() {
  system::register("containers", &__init__, undefined, undefined);
}

function __init__() {
  a_containers = struct::get_array("scriptbundle_containers", "classname");
  foreach(s_instance in a_containers) {
    c_container = s_instance init();
    if(isDefined(c_container)) {
      s_instance.c_container = c_container;
    }
  }
}

function init() {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }
  s_bundle = struct::get_script_bundle("containers", self.scriptbundlename);
  return setup_container_scriptbundle(s_bundle, self);
}

function setup_container_scriptbundle(s_bundle, s_container_instance) {
  c_container = new ccontainer();
  c_container.m_s_container_bundle = s_bundle;
  c_container.m_s_fxanim_bundle = struct::get_script_bundle("scene", s_bundle.theeffectbundle);
  c_container.m_s_container_instance = s_container_instance;
  self scene::init(s_bundle.theeffectbundle, c_container.m_e_container);
  level thread container_update(c_container);
  return c_container;
}

function container_update(c_container) {
  e_ent = c_container.m_e_container;
  s_bundle = c_container.m_s_container_bundle;
  targetname = c_container.m_s_container_instance.targetname;
  n_radius = s_bundle.trigger_radius;
  e_trigger = create_locker_trigger(c_container.m_s_container_instance.origin, n_radius, "Press [{+activate}] to open");
  e_trigger waittill("trigger", e_who);
  e_trigger delete();
  scene::play(targetname, "targetname");
}

function create_locker_trigger(v_pos, n_radius, str_message) {
  v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);
  e_trig = spawn("trigger_radius_use", v_pos, 0, n_radius, 100);
  e_trig triggerignoreteam();
  e_trig setvisibletoall();
  e_trig setteamfortrigger("none");
  e_trig usetriggerrequirelookat();
  e_trig setcursorhint("HINT_NOICON");
  e_trig sethintstring(str_message);
  return e_trig;
}

function setup_general_container_bundle(str_targetname, str_intel_vo, str_narrative_collectable_model, force_open) {
  s_struct = struct::get(str_targetname, "targetname");
  if(!isDefined(s_struct)) {
    return;
  }
  level flag::wait_till("all_players_spawned");
  e_trigger = create_locker_trigger(s_struct.origin, 64, "Press [{+activate}] to open");
  if(!isDefined(force_open) || force_open == 0) {
    e_trigger waittill("trigger", e_who);
  } else {
    rand_time = randomfloatrange(1, 1.5);
    wait(rand_time);
  }
  e_trigger delete();
  level thread scene::play(str_targetname, "targetname");
  if(isDefined(s_struct.a_entity)) {
    for(i = 0; i < s_struct.a_entity.size; i++) {
      s_struct.a_entity[i] notify("opened");
    }
  }
  if(isDefined(str_narrative_collectable_model)) {
    v_pos = s_struct.origin + vectorscale((0, 0, 1), 30);
    if(!isDefined(s_struct.angles)) {
      v_angles = (0, 0, 0);
    } else {
      v_angles = s_struct.angles;
    }
    v_angles = (v_angles[0], v_angles[1] + 90, v_angles[2]);
    e_collectable = spawn("script_model", v_pos);
    e_collectable setModel("p7_int_narrative_collectable");
    e_collectable.angles = v_angles;
    wait(1);
    e_trigger = create_locker_trigger(s_struct.origin, 64, "Press [{+activate}] to pickup collectable");
    e_trigger waittill("trigger", e_who);
    e_trigger delete();
    e_collectable delete();
  }
  if(isDefined(str_intel_vo)) {
    e_who playSound(str_intel_vo);
  }
}

function setup_locker_double_doors(str_left_door_name, str_right_door_name, center_point_offset) {
  a_left_doors = getEntArray(str_left_door_name, "targetname");
  if(!isDefined(a_left_doors)) {
    return;
  }
  a_right_doors = getEntArray(str_right_door_name, "targetname");
  if(!isDefined(a_right_doors)) {
    return;
  }
  for(i = 0; i < a_left_doors.size; i++) {
    e_left_door = a_left_doors[i];
    if(isDefined(center_point_offset)) {
      v_forward = anglesToForward(e_left_door.angles);
      v_search_pos = e_left_door.origin + (v_forward * center_point_offset);
    } else {
      v_search_pos = e_left_door.origin;
    }
    e_right_door = get_closest_ent_from_array(v_search_pos, a_right_doors);
    level thread create_locker_doors(e_left_door, e_right_door, 120, 0.4);
  }
}

function get_closest_ent_from_array(v_pos, a_ents) {
  e_closest = undefined;
  n_closest_dist = 9999999;
  for(i = 0; i < a_ents.size; i++) {
    dist = distance(v_pos, a_ents[i].origin);
    if(dist < n_closest_dist) {
      n_closest_dist = dist;
      e_closest = a_ents[i];
    }
  }
  return e_closest;
}

function create_locker_doors(e_left_door, e_right_door, door_open_angle, door_open_time) {
  v_locker_pos = (e_left_door.origin + e_right_door.origin) / 2;
  n_trigger_radius = 48;
  e_trigger = create_locker_trigger(v_locker_pos, n_trigger_radius, "Press [{+activate}] to open");
  e_trigger waittill("trigger");
  e_left_door playSound("evt_cabinet_open");
  v_angle = (e_left_door.angles[0], e_left_door.angles[1] - door_open_angle, e_left_door.angles[2]);
  e_left_door rotateto(v_angle, door_open_time);
  v_angle = (e_right_door.angles[0], e_right_door.angles[1] + door_open_angle, e_right_door.angles[2]);
  e_right_door rotateto(v_angle, door_open_time);
  e_trigger delete();
}