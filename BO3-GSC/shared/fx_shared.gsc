/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\fx_shared.gsc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace fx;

function autoexec __init__sytem__() {
  system::register("fx", & __init__, undefined, undefined);
}

function __init__() {}

function set_forward_and_up_vectors() {
  self.v["up"] = anglestoup(self.v["angles"]);
  self.v["forward"] = anglestoforward(self.v["angles"]);
}

function get(fx) {
  assert(isdefined(level._effect[fx]), ("" + fx) + "");
  return level._effect[fx];
}

function create_effect(type, fxid) {
  ent = undefined;
  if(!isdefined(level.createfxent)) {
    level.createfxent = [];
  }
  if(type == "exploder") {
    ent = spawnstruct();
  } else {
    if(!isdefined(level._fake_createfx_struct)) {
      level._fake_createfx_struct = spawnstruct();
    }
    ent = level._fake_createfx_struct;
  }
  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v["type"] = type;
  ent.v["fxid"] = fxid;
  ent.v["angles"] = (0, 0, 0);
  ent.v["origin"] = (0, 0, 0);
  ent.drawn = 1;
  return ent;
}

function create_loop_effect(fxid) {
  ent = create_effect("loopfx", fxid);
  ent.v["delay"] = 0.5;
  return ent;
}

function create_oneshot_effect(fxid) {
  ent = create_effect("oneshotfx", fxid);
  ent.v["delay"] = -15;
  return ent;
}

function play(str_fx, v_origin = (0, 0, 0), v_angles = (0, 0, 0), time_to_delete_or_notify, b_link_to_self = 0, str_tag, b_no_cull, b_ignore_pause_world) {
  self notify(str_fx);
  if(!isdefined(time_to_delete_or_notify) || (!isstring(time_to_delete_or_notify) && time_to_delete_or_notify == -1) && (isdefined(b_link_to_self) && b_link_to_self) && isdefined(str_tag)) {
    playfxontag(get(str_fx), self, str_tag, b_ignore_pause_world);
    return self;
  }
  if(isdefined(time_to_delete_or_notify)) {
    m_fx = util::spawn_model("tag_origin", v_origin, v_angles);
    if(isdefined(b_link_to_self) && b_link_to_self) {
      if(isdefined(str_tag)) {
        m_fx linkto(self, str_tag, (0, 0, 0), (0, 0, 0));
      } else {
        m_fx linkto(self);
      }
    }
    if(isdefined(b_no_cull) && b_no_cull) {
      m_fx setforcenocull();
    }
    playfxontag(get(str_fx), m_fx, "tag_origin", b_ignore_pause_world);
    m_fx thread _play_fx_delete(self, time_to_delete_or_notify);
    return m_fx;
  }
  playfx(get(str_fx), v_origin, anglestoforward(v_angles), anglestoup(v_angles), b_ignore_pause_world);
}

function _play_fx_delete(ent, time_to_delete_or_notify = -1) {
  if(isstring(time_to_delete_or_notify)) {
    ent util::waittill_either("death", time_to_delete_or_notify);
  } else {
    if(time_to_delete_or_notify > 0) {
      ent util::waittill_any_timeout(time_to_delete_or_notify, "death");
    } else {
      ent waittill("death");
    }
  }
  if(isdefined(self)) {
    self delete();
  }
}