/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\fx_shared.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;
#namespace fx;

function set_forward_and_up_vectors() {
  self.v[#"up"] = anglestoup(self.v[#"angles"]);
  self.v[#"forward"] = anglesToForward(self.v[#"angles"]);
}

function get(fx) {
  if(isDefined(level._effect[fx])) {
    return level._effect[fx];
  }

  return fx;
}

function create_effect(type, fxid) {
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

function create_loop_effect(fxid) {
  ent = create_effect("loopfx", fxid);
  ent.v[#"delay"] = 0.5;
  return ent;
}

function create_oneshot_effect(fxid) {
  ent = create_effect("oneshotfx", fxid);
  ent.v[#"delay"] = -15;
  return ent;
}

function play(str_fx, v_origin = (0, 0, 0), v_angles = (0, 0, 0), time_to_delete_or_notify, b_link_to_self = 0, str_tag, b_no_cull, b_ignore_pause_world) {
  self notify(str_fx);

  if((!isDefined(time_to_delete_or_notify) || !isstring(time_to_delete_or_notify) && !ishash(time_to_delete_or_notify) && time_to_delete_or_notify == -1) && is_true(b_link_to_self) && isDefined(str_tag)) {
    playFXOnTag(get(str_fx), self, str_tag, b_ignore_pause_world);
    return self;
  }

  if(isDefined(time_to_delete_or_notify)) {
    m_fx = util::spawn_model("tag_origin", v_origin, v_angles);

    if(is_true(b_link_to_self)) {
      if(isDefined(str_tag)) {
        m_fx linkto(self, str_tag, (0, 0, 0), (0, 0, 0));
      } else {
        m_fx linkto(self);
      }
    }

    if(is_true(b_no_cull)) {
      m_fx setforcenocull();
    }

    playFXOnTag(get(str_fx), m_fx, "tag_origin", b_ignore_pause_world);
    m_fx thread _play_fx_delete(self, time_to_delete_or_notify);
    return m_fx;
  }

  playFX(get(str_fx), v_origin, anglesToForward(v_angles), anglestoup(v_angles), b_ignore_pause_world);
}

function _play_fx_delete(ent, time_to_delete_or_notify = -1) {
  if(isstring(time_to_delete_or_notify) || ishash(time_to_delete_or_notify)) {
    ent waittill(#"death", time_to_delete_or_notify);
  } else if(time_to_delete_or_notify > 0) {
    ent waittilltimeout(time_to_delete_or_notify, #"death");
  } else {
    ent waittill(#"death");
  }

  if(isDefined(self)) {
    self delete();
  }
}

function lighting_target_dof(target, f_fstop, var_bef008a5, f_fstop_time, var_1436aa92) {
  self flag::set("flag_autofocus_on");
  function_5ac4dc99("_internal_dof_i_target_type", -1);
  function_5ac4dc99("_internal_dof_i_target_entnum", -1);
  function_5ac4dc99("_internal_dof_v_target_origin", (-1, -1, -1));
  function_5ac4dc99("_internal_dof_s_target_tag", "-1");
  function_5ac4dc99("_internal_dof_f_fstop", -1);
  function_5ac4dc99("_internal_dof_f_focus_time", -1);
  function_5ac4dc99("_internal_dof_f_fstop_time", -1);
  function_5ac4dc99("_internal_dof_i_playernum", -1);
  function_5ac4dc99("_internal_dof_i_refcounter", 0);

  if(!isDefined(target)) {
    return;
  }

  if(isvec(target)) {
    setDvar(#"_internal_dof_i_target_entnum", -999);
    setDvar(#"_internal_dof_i_target_type", -1);
    setDvar(#"hash_7c405920e0b200ee", target);
  } else {
    var_3ed74fac = target getentitynumber();
    var_dc3df1b8 = target getentitytype();
    setDvar(#"_internal_dof_i_target_entnum", var_3ed74fac);
    setDvar(#"_internal_dof_i_target_type", var_dc3df1b8);
    setDvar(#"_internal_dof_v_target_origin", (-1, -1, -1));

    if(isDefined(var_1436aa92)) {
      setDvar(#"_internal_dof_s_target_tag", var_1436aa92);
    } else {
      setDvar(#"_internal_dof_s_target_tag", "-1");
    }
  }

  if(isDefined(f_fstop)) {
    setDvar(#"_internal_dof_f_fstop", float(f_fstop));
  } else {
    setDvar(#"_internal_dof_f_fstop", -1);
  }

  if(isDefined(var_bef008a5)) {
    setDvar(#"_internal_dof_f_focus_time", float(var_bef008a5));
  } else {
    setDvar(#"_internal_dof_f_focus_time", -1);
  }

  if(isDefined(f_fstop_time)) {
    setDvar(#"_internal_dof_f_fstop_time", float(f_fstop_time));
  } else {
    setDvar(#"_internal_dof_f_fstop_time", -1);
  }

  entnum = self getentitynumber();
  setDvar(#"_internal_dof_i_playernum", entnum);
  refcount = getdvarint(#"_internal_dof_i_refcounter", 0);
  refcount++;
  setDvar(#"_internal_dof_i_refcounter", refcount);
  self thread function_13fa0731();
}

function function_82104e32(f_fstop, f_fstop_time) {
  self flag::set("flag_autofocus_on");
  function_5ac4dc99("_internal_fob_i_playernum", -1);
  function_5ac4dc99("_internal_fob_f_fstop", -1);
  function_5ac4dc99("_internal_fob_f_fstop_time", -1);
  function_5ac4dc99("_internal_fob_or_dof_i_refcounter", 0);
  function_5ac4dc99("_internal_debug_dof", 0);

  if(isDefined(f_fstop)) {
    setDvar(#"_internal_fob_f_fstop", float(f_fstop));
  } else {
    setDvar(#"_internal_fob_f_fstop", -1);
  }

  if(isDefined(f_fstop_time)) {
    setDvar(#"_internal_fob_f_fstop_time", float(f_fstop_time));
  } else {
    setDvar(#"_internal_fob_f_fstop_time", -1);
  }

  entnum = self getentitynumber();
  setDvar(#"_internal_fob_i_playernum", entnum);
  refcount = getdvarint(#"_internal_fob_i_refcounter", 0);
  refcount++;
  setDvar(#"_internal_fob_i_refcounter", refcount);
  self thread function_13fa0731();
}

function private function_13fa0731() {
  self notify(#"hash_1481a83e14539c4");
  self endon(#"hash_1481a83e14539c4");
  self endoncallback(&function_e592b635, #"death");

  while(true) {
    self flag::wait_till_clear("flag_autofocus_on");
    function_e592b635();
    break;
  }
}

function private function_e592b635(eventstruct) {
  setDvar(#"_internal_dof_i_playernum", -1);
  setDvar(#"_internal_dof_i_target_type", -1);
  setDvar(#"_internal_dof_i_target_entnum", -1);
  setDvar(#"_internal_dof_v_target_origin", (-1, -1, -1));
  setDvar(#"_internal_dof_s_target_tag", "-1");
  setDvar(#"_internal_dof_f_fstop", -1);
  setDvar(#"_internal_dof_f_focus_time", -1);
  setDvar(#"_internal_dof_f_fstop_time", -1);
  setDvar(#"_internal_fob_i_playernum", -1);
  setDvar(#"_internal_fob_f_fstop", -1);
}