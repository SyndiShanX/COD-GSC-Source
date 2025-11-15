/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\fx_shared.gsc
***********************************************/

#include scripts\core_common\util_shared;

#namespace fx;

set_forward_and_up_vectors() {
  self.v[#"up"] = anglestoup(self.v[#"angles"]);
  self.v[#"forward"] = anglesToForward(self.v[#"angles"]);
}

get(fx) {
  if(isDefined(level._effect[fx])) {
    return level._effect[fx];
  }

  return fx;
}

create_effect(type, fxid) {
  ent = undefined;

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  if(type == "exploder") {
    ent = spawnStruct();
  } else {
    if(!isDefined(level._fake_createfx_struct)) {
      level._fake_createfx_struct = spawnStruct();
    }

    ent = level._fake_createfx_struct;
  }

  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v[#"type"] = type;
  ent.v[#"fxid"] = fxid;
  ent.v[#"angles"] = (0, 0, 0);
  ent.v[#"origin"] = (0, 0, 0);
  ent.drawn = 1;
  return ent;
}

create_loop_effect(fxid) {
  ent = create_effect("loopfx", fxid);
  ent.v[#"delay"] = 0.5;
  return ent;
}

create_oneshot_effect(fxid) {
  ent = create_effect("oneshotfx", fxid);
  ent.v[#"delay"] = -15;
  return ent;
}

play(str_fx, v_origin = (0, 0, 0), v_angles = (0, 0, 0), time_to_delete_or_notify, b_link_to_self = 0, str_tag, b_no_cull, b_ignore_pause_world) {
  self notify(str_fx);

  if((!isDefined(time_to_delete_or_notify) || !isstring(time_to_delete_or_notify) && !ishash(time_to_delete_or_notify) && time_to_delete_or_notify == -1) && isDefined(b_link_to_self) && b_link_to_self && isDefined(str_tag)) {
    playFXOnTag(get(str_fx), self, str_tag, b_ignore_pause_world);
    return self;
  }

  if(isDefined(time_to_delete_or_notify)) {
    m_fx = util::spawn_model("tag_origin", v_origin, v_angles);

    if(isDefined(b_link_to_self) && b_link_to_self) {
      if(isDefined(str_tag)) {
        m_fx linkto(self, str_tag, (0, 0, 0), (0, 0, 0));
      } else {
        m_fx linkto(self);
      }
    }

    if(isDefined(b_no_cull) && b_no_cull) {
      m_fx setforcenocull();
    }

    playFXOnTag(get(str_fx), m_fx, "tag_origin", b_ignore_pause_world);
    m_fx thread _play_fx_delete(self, time_to_delete_or_notify);
    return m_fx;
  }

  playFX(get(str_fx), v_origin, anglesToForward(v_angles), anglestoup(v_angles), b_ignore_pause_world);
}

_play_fx_delete(ent, time_to_delete_or_notify = -1) {
  if(isstring(time_to_delete_or_notify) || ishash(time_to_delete_or_notify)) {
    ent util::waittill_either("death", time_to_delete_or_notify);
  } else if(time_to_delete_or_notify > 0) {
    ent waittilltimeout(time_to_delete_or_notify, #"death");
  } else {
    ent waittill(#"death");
  }

  if(isDefined(self)) {
    self delete();
  }
}