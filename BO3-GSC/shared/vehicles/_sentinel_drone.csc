/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_sentinel_drone.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\beam_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace sentinel_drone;

function autoexec __init__sytem__() {
  system::register("sentinel_drone", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "sentinel_drone_beam_set_target_id", 12000, 5, "int", & sentinel_drone_beam_set_target_id, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_beam_set_source_to_target", 12000, 5, "int", & sentinel_drone_beam_set_source_to_target, 0, 0);
  clientfield::register("toplayer", "sentinel_drone_damage_player_fx", 12000, 1, "counter", & sentinel_drone_damage_player_fx, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_beam_fire1", 12000, 1, "int", & sentinel_drone_beam_fire1, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_beam_fire2", 12000, 1, "int", & sentinel_drone_beam_fire2, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_beam_fire3", 12000, 1, "int", & sentinel_drone_beam_fire3, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_arm_cut_1", 12000, 1, "int", & sentinel_drone_arm_cut_1, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_arm_cut_2", 12000, 1, "int", & sentinel_drone_arm_cut_2, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_arm_cut_3", 12000, 1, "int", & sentinel_drone_arm_cut_3, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_face_cut", 12000, 1, "int", & sentinel_drone_face_cut, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_beam_charge", 12000, 1, "int", & sentinel_drone_beam_charge, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_camera_scanner", 12000, 1, "int", & sentinel_drone_camera_scanner, 0, 0);
  clientfield::register("vehicle", "sentinel_drone_camera_destroyed", 12000, 1, "int", & sentinel_drone_camera_destroyed, 0, 0);
  clientfield::register("scriptmover", "sentinel_drone_deathfx", 1, 1, "int", & sentinel_drone_deathfx, 0, 0);
  level._sentinel_enemy_detected_taunts = [];
  if(!isDefined(level._sentinel_enemy_detected_taunts)) {
    level._sentinel_enemy_detected_taunts = [];
  } else if(!isarray(level._sentinel_enemy_detected_taunts)) {
    level._sentinel_enemy_detected_taunts = array(level._sentinel_enemy_detected_taunts);
  }
  level._sentinel_enemy_detected_taunts[level._sentinel_enemy_detected_taunts.size] = "vox_valk_valkyrie_detected_0";
  if(!isDefined(level._sentinel_enemy_detected_taunts)) {
    level._sentinel_enemy_detected_taunts = [];
  } else if(!isarray(level._sentinel_enemy_detected_taunts)) {
    level._sentinel_enemy_detected_taunts = array(level._sentinel_enemy_detected_taunts);
  }
  level._sentinel_enemy_detected_taunts[level._sentinel_enemy_detected_taunts.size] = "vox_valk_valkyrie_detected_1";
  if(!isDefined(level._sentinel_enemy_detected_taunts)) {
    level._sentinel_enemy_detected_taunts = [];
  } else if(!isarray(level._sentinel_enemy_detected_taunts)) {
    level._sentinel_enemy_detected_taunts = array(level._sentinel_enemy_detected_taunts);
  }
  level._sentinel_enemy_detected_taunts[level._sentinel_enemy_detected_taunts.size] = "vox_valk_valkyrie_detected_2";
  if(!isDefined(level._sentinel_enemy_detected_taunts)) {
    level._sentinel_enemy_detected_taunts = [];
  } else if(!isarray(level._sentinel_enemy_detected_taunts)) {
    level._sentinel_enemy_detected_taunts = array(level._sentinel_enemy_detected_taunts);
  }
  level._sentinel_enemy_detected_taunts[level._sentinel_enemy_detected_taunts.size] = "vox_valk_valkyrie_detected_3";
  if(!isDefined(level._sentinel_enemy_detected_taunts)) {
    level._sentinel_enemy_detected_taunts = [];
  } else if(!isarray(level._sentinel_enemy_detected_taunts)) {
    level._sentinel_enemy_detected_taunts = array(level._sentinel_enemy_detected_taunts);
  }
  level._sentinel_enemy_detected_taunts[level._sentinel_enemy_detected_taunts.size] = "vox_valk_valkyrie_detected_4";
  level._sentinel_attack_taunts = [];
  if(!isDefined(level._sentinel_attack_taunts)) {
    level._sentinel_attack_taunts = [];
  } else if(!isarray(level._sentinel_attack_taunts)) {
    level._sentinel_attack_taunts = array(level._sentinel_attack_taunts);
  }
  level._sentinel_attack_taunts[level._sentinel_attack_taunts.size] = "vox_valk_valkyrie_attack_0";
  if(!isDefined(level._sentinel_attack_taunts)) {
    level._sentinel_attack_taunts = [];
  } else if(!isarray(level._sentinel_attack_taunts)) {
    level._sentinel_attack_taunts = array(level._sentinel_attack_taunts);
  }
  level._sentinel_attack_taunts[level._sentinel_attack_taunts.size] = "vox_valk_valkyrie_attack_1";
  if(!isDefined(level._sentinel_attack_taunts)) {
    level._sentinel_attack_taunts = [];
  } else if(!isarray(level._sentinel_attack_taunts)) {
    level._sentinel_attack_taunts = array(level._sentinel_attack_taunts);
  }
  level._sentinel_attack_taunts[level._sentinel_attack_taunts.size] = "vox_valk_valkyrie_attack_2";
  if(!isDefined(level._sentinel_attack_taunts)) {
    level._sentinel_attack_taunts = [];
  } else if(!isarray(level._sentinel_attack_taunts)) {
    level._sentinel_attack_taunts = array(level._sentinel_attack_taunts);
  }
  level._sentinel_attack_taunts[level._sentinel_attack_taunts.size] = "vox_valk_valkyrie_attack_3";
  if(!isDefined(level._sentinel_attack_taunts)) {
    level._sentinel_attack_taunts = [];
  } else if(!isarray(level._sentinel_attack_taunts)) {
    level._sentinel_attack_taunts = array(level._sentinel_attack_taunts);
  }
  level._sentinel_attack_taunts[level._sentinel_attack_taunts.size] = "vox_valk_valkyrie_attack_4";
}

function sentinel_is_drone_initialized(localclientnum, b_check_for_target_existance_only) {
  if(!(isDefined(b_check_for_target_existance_only) && b_check_for_target_existance_only)) {
    if(!(isDefined(self.init) && self.init)) {
      return false;
    }
    if(!self hasdobj(localclientnum)) {
      return false;
    }
    return true;
  }
  source_num = self getentitynumber();
  if(isDefined(level.sentinel_drone_source_to_target) && isDefined(level.sentinel_drone_source_to_target[source_num]) && isDefined(level.sentinel_drone_target_id) && isDefined(level.sentinel_drone_target_id[level.sentinel_drone_source_to_target[source_num]])) {
    return true;
  }
  return false;
}

function sentinel_drone_damage_player_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = getlocalplayer(localclientnum);
  if(isDefined(localplayer)) {
    localplayer thread postfx::playpostfxbundle("sentinel_pstfx_shock_charge");
  }
}

function sentinel_drone_deathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  settings = struct::get_script_bundle("vehiclecustomsettings", "sentinel_drone_settings");
  if(isDefined(settings)) {
    if(newval) {
      handle = playFX(localclientnum, settings.drone_secondary_death_fx_1, self.origin);
      setfxignorepause(localclientnum, handle, 1);
      if(isDefined(self.beam_target_fx) && isDefined(self.beam_target_fx[localclientnum])) {
        stopfx(localclientnum, self.beam_target_fx[localclientnum]);
        self.beam_target_fx[localclientnum] = undefined;
      }
    }
  }
}

function sentinel_drone_camera_scanner(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!sentinel_is_drone_initialized(localclientnum)) {
    return false;
  }
  if(newval == 1) {
    if(!isDefined(self.camerascannerfx) && (!(isDefined(self.cameradestroyed) && self.cameradestroyed))) {
      self.camerascannerfx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_scanner_light_glow", self, "tag_flash");
    }
    sentinel_play_engine_fx(localclientnum, 0, 1);
  } else {
    keep_scanner_on = getdvarint("", 0);
    if(isDefined(self.camerascannerfx) && (!(isDefined(keep_scanner_on) && keep_scanner_on))) {
      stopfx(localclientnum, self.camerascannerfx);
      self.camerascannerfx = undefined;
    }
    sentinel_play_engine_fx(localclientnum, 1, 0);
  }
}

function sentinel_drone_camera_destroyed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.cameradestroyed = 1;
  if(isDefined(self.camerascannerfx)) {
    stopfx(localclientnum, self.camerascannerfx);
    self.camerascannerfx = undefined;
  }
  if(isDefined(self.cameraambientfx)) {
    stopfx(localclientnum, self.cameraambientfx);
    self.cameraambientfx = undefined;
  }
}

function sentinel_drone_beam_fire1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  sentinel_drone_beam_fire(localclientnum, newval, "tag_fx1");
}

function sentinel_drone_beam_fire2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  sentinel_drone_beam_fire(localclientnum, newval, "tag_fx2");
}

function sentinel_drone_beam_fire3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  sentinel_drone_beam_fire(localclientnum, newval, "tag_fx3");
}

function sentinel_drone_beam_fire(localclientnum, newval, tag_id) {
  if(sentinel_is_drone_initialized(localclientnum, newval == 0)) {
    source_num = self getentitynumber();
    beam_target = level.sentinel_drone_target_id[level.sentinel_drone_source_to_target[source_num]];
  } else {
    return;
  }
  if(newval == 1) {
    level beam::launch(self, tag_id, beam_target, "tag_origin", "electric_taser_beam_1");
    self playSound(0, "zmb_sentinel_attack_short");
    if(!isDefined(beam_target.beam_target_fx)) {
      beam_target.beam_target_fx = [];
    }
    if(!isDefined(beam_target.beam_target_fx[localclientnum])) {
      beam_target.beam_target_fx[localclientnum] = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_fire_tgt", beam_target, "tag_origin");
    }
    keep_scanner_on = getdvarint("", 0);
    if(isDefined(self.camerascannerfx) && (!(isDefined(keep_scanner_on) && keep_scanner_on))) {
      stopfx(localclientnum, self.camerascannerfx);
      self.camerascannerfx = undefined;
    }
  } else {
    level beam::kill(self, tag_id, beam_target, "tag_origin", "electric_taser_beam_1");
    if(isDefined(beam_target.beam_target_fx) && isDefined(beam_target.beam_target_fx[localclientnum])) {
      stopfx(localclientnum, beam_target.beam_target_fx[localclientnum]);
      beam_target.beam_target_fx[localclientnum] = undefined;
    }
    self sentinel_play_claws_ambient_fx(localclientnum);
  }
}

function sentinel_drone_beam_set_target_id(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.sentinel_drone_target_id)) {
    level.sentinel_drone_target_id = [];
  }
  level.sentinel_drone_target_id[newval] = self;
}

function sentinel_drone_beam_set_source_to_target(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.sentinel_drone_source_to_target)) {
    level.sentinel_drone_source_to_target = [];
  }
  source_num = self getentitynumber();
  level.sentinel_drone_source_to_target[source_num] = newval;
  self.init = 1;
  self sentinel_play_claws_ambient_fx(localclientnum);
  self.cameraambientfx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_eye_camera_lens_glow", self, "tag_flash");
  self.camerascannerfx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_scanner_light_glow", self, "tag_flash");
  sentinel_play_engine_fx(localclientnum, 1, 0);
  self useanimtree($generic);
  self setanim("ai_zm_dlc3_sentinel_antenna_twitch");
}

function sentinel_drone_arm_cut_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  sentinel_drone_arm_cut(localclientnum, 1);
}

function sentinel_drone_arm_cut_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  sentinel_drone_arm_cut(localclientnum, 2);
}

function sentinel_drone_arm_cut_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  sentinel_drone_arm_cut(localclientnum, 3);
}

function sentinel_spawn_broken_arm(localclientnum, arm, arm_tag, claw_tag) {
  if(!sentinel_is_drone_initialized(localclientnum)) {
    return false;
  }
  velocity = self getvelocity();
  velocity_normal = vectornormalize(velocity);
  velocity_length = length(velocity);
  if(arm == 3) {
    launch_dir = anglesToForward(self.angles) * -1;
    launch_dir = launch_dir + (0, 0, 1);
    launch_dir = vectornormalize(launch_dir);
  } else {
    if(arm == 1) {
      launch_dir = anglestoright(self.angles);
    } else {
      launch_dir = anglestoright(self.angles) * -1;
    }
  }
  velocity_length = velocity_length * 0.1;
  if(velocity_length < 10) {
    velocity_length = 10;
  }
  launch_dir = (launch_dir * 0.5) + (velocity_normal * 0.5);
  launch_dir = launch_dir * velocity_length;
  claw_pos = self gettagorigin(claw_tag) + (launch_dir * 3);
  claw_ang = self gettagangles(claw_tag);
  thread sentinel_launch_piece(localclientnum, "veh_t7_dlc3_sentinel_drone_spawn_claw", claw_pos, claw_ang, self.origin, launch_dir * 1.3);
  arm_pos = self gettagorigin(arm_tag) + (launch_dir * 2);
  arm_ang = self gettagangles(arm_tag);
  thread sentinel_launch_piece(localclientnum, "veh_t7_dlc3_sentinel_drone_spawn_arm", arm_pos, arm_ang, self.origin, launch_dir);
}

function sentinel_drone_arm_cut(localclientnum, arm) {
  if(arm == 1) {
    if(!(isDefined(self.rightarmlost) && self.rightarmlost)) {
      sentinel_spawn_broken_arm(localclientnum, 1, "tag_arm_right_04_d1", "tag_fx1");
      self.rightarmlost = 1;
      sentinel_drone_beam_fire(localclientnum, 0, "tag_fx1");
      if(isDefined(self.rightclawambientfx)) {
        stopfx(localclientnum, self.rightclawambientfx);
        self.rightclawambientfx = undefined;
      }
      if(isDefined(self.rightclawchargefx)) {
        stopfx(localclientnum, self.rightclawchargefx);
        self.rightclawchargefx = undefined;
      }
      if(sentinel_is_drone_initialized(localclientnum)) {
        playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_arm", self, "tag_arm_right_04_d1");
        self setanim("ai_zm_dlc3_sentinel_arms_broken_right");
      }
    }
  } else {
    if(arm == 2) {
      if(!(isDefined(self.leftarmlost) && self.leftarmlost)) {
        sentinel_spawn_broken_arm(localclientnum, 2, "tag_arm_left_03_d1", "tag_fx2");
        self.leftarmlost = 1;
        sentinel_drone_beam_fire(localclientnum, 0, "tag_fx2");
        if(isDefined(self.leftclawambientfx)) {
          stopfx(localclientnum, self.leftclawambientfx);
          self.leftclawambientfx = undefined;
        }
        if(isDefined(self.leftclawchargefx)) {
          stopfx(localclientnum, self.leftclawchargefx);
          self.leftclawchargefx = undefined;
        }
        if(sentinel_is_drone_initialized(localclientnum)) {
          playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_arm", self, "tag_arm_left_03_d1");
          self setanim("ai_zm_dlc3_sentinel_arms_broken_left");
        }
      }
    } else if(arm == 3) {
      if(!(isDefined(self.toparmlost) && self.toparmlost)) {
        sentinel_spawn_broken_arm(localclientnum, 3, "tag_arm_top_03_d1", "tag_fx3");
        self.toparmlost = 1;
        sentinel_drone_beam_fire(localclientnum, 0, "tag_fx3");
        if(isDefined(self.topclawambientfx)) {
          stopfx(localclientnum, self.topclawambientfx);
          self.topclawambientfx = undefined;
        }
        if(isDefined(self.topclawchargefx)) {
          stopfx(localclientnum, self.topclawchargefx);
          self.topclawchargefx = undefined;
        }
        if(sentinel_is_drone_initialized(localclientnum)) {
          playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_arm", self, "tag_arm_top_03_d1");
          self setanim("ai_zm_dlc3_sentinel_arms_broken_top");
        }
      }
    }
  }
}

function sentinel_drone_beam_charge(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!sentinel_is_drone_initialized(localclientnum)) {
    return false;
  }
  if(newval == 1) {
    if(!isDefined(self.camerascannerfx)) {
      self.camerascannerfx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_scanner_light_glow", self, "tag_flash");
    }
    self sentinel_play_claws_ambient_fx(localclientnum, 1);
    if(!(isDefined(self.rightarmlost) && self.rightarmlost)) {
      self.rightclawchargefx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_charging", self, "tag_fx1");
    }
    if(!(isDefined(self.leftarmlost) && self.leftarmlost)) {
      self.leftclawchargefx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_charging", self, "tag_fx2");
    }
    if(!(isDefined(self.toparmlost) && self.toparmlost)) {
      self.topclawchargefx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_charging", self, "tag_fx3");
    }
    if(isDefined(self.enemy_already_spotted)) {
      if(randomint(100) < 30) {
        sentinel_play_taunt(localclientnum, level._sentinel_attack_taunts);
      }
    } else {
      self.enemy_already_spotted = 1;
      sentinel_play_taunt(localclientnum, level._sentinel_enemy_detected_taunts);
    }
  } else {
    if(isDefined(self.rightclawchargefx)) {
      stopfx(localclientnum, self.rightclawchargefx);
      self.rightclawchargefx = undefined;
    }
    if(isDefined(self.leftclawchargefx)) {
      stopfx(localclientnum, self.leftclawchargefx);
      self.leftclawchargefx = undefined;
    }
    if(isDefined(self.topclawchargefx)) {
      stopfx(localclientnum, self.topclawchargefx);
      self.topclawchargefx = undefined;
    }
  }
}

function sentinel_drone_face_cut(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!sentinel_is_drone_initialized(localclientnum)) {
    return false;
  }
  face_pos = self gettagorigin("tag_faceplate_d0");
  face_ang = self gettagangles("tag_faceplate_d0");
  velocity = self getvelocity();
  velocity_normal = vectornormalize(velocity);
  velocity_length = length(velocity);
  launch_dir = anglesToForward(self.angles);
  velocity_length = velocity_length * 0.1;
  if(velocity_length < 10) {
    velocity_length = 10;
  }
  launch_dir = (launch_dir * 0.5) + (velocity_normal * 0.5);
  launch_dir = launch_dir * velocity_length;
  thread sentinel_launch_piece(localclientnum, "veh_t7_dlc3_sentinel_drone_faceplate", face_pos, face_ang, self.origin, launch_dir);
  playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_core", self, "tag_faceplate_d0");
  playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_energy_core_glow", self, "ag_core_d0");
}

function sentinel_play_claws_ambient_fx(localclientnum, b_false) {
  if(!sentinel_is_drone_initialized(localclientnum)) {
    return false;
  }
  if(!(isDefined(b_false) && b_false)) {
    if(!(isDefined(self.rightarmlost) && self.rightarmlost) && !isDefined(self.rightclawambientfx)) {
      self.rightclawambientfx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_idle", self, "tag_fx1");
    }
    if(!(isDefined(self.leftarmlost) && self.leftarmlost) && !isDefined(self.leftclawambientfx)) {
      self.leftclawambientfx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_idle", self, "tag_fx2");
    }
    if(!(isDefined(self.toparmlost) && self.toparmlost) && !isDefined(self.topclawambientfx)) {
      self.topclawambientfx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_idle", self, "tag_fx3");
    }
  } else {
    if(isDefined(self.rightclawambientfx)) {
      stopfx(localclientnum, self.rightclawambientfx);
      self.rightclawambientfx = undefined;
    }
    if(isDefined(self.leftclawambientfx)) {
      stopfx(localclientnum, self.leftclawambientfx);
      self.leftclawambientfx = undefined;
    }
    if(isDefined(self.topclawambientfx)) {
      stopfx(localclientnum, self.topclawambientfx);
      self.topclawambientfx = undefined;
    }
  }
}

function sentinel_play_engine_fx(localclientnum, b_engine, b_roll_engine) {
  if(!sentinel_is_drone_initialized(localclientnum)) {
    return false;
  }
  if(isDefined(b_engine) && b_engine) {
    self.enginefx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_engine_idle", self, "tag_fx_engine_left");
  } else if(isDefined(self.enginefx)) {
    stopfx(localclientnum, self.enginefx);
  }
  if(isDefined(b_roll_engine) && b_roll_engine) {
    self.enginerollfx = playFXOnTag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_engine_smk_fast", self, "tag_fx_engine_left");
  } else if(isDefined(self.enginerollfx)) {
    stopfx(localclientnum, self.enginerollfx);
  }
}

function sentinel_play_taunt(localclientnum, taunt_arr) {
  if(isDefined(level._lastplayed_drone_taunt) && (gettime() - level._lastplayed_drone_taunt) < 6000) {
    return;
  }
  if(isDefined(level.voxaideactivate) && level.voxaideactivate) {
    return;
  }
  taunt = randomint(taunt_arr.size);
  level._lastplayed_drone_taunt = gettime();
  self playSound(localclientnum, taunt_arr[taunt]);
}

function sentinel_launch_piece(localclientnum, model, pos, angles, hitpos, force) {
  dynent = createdynentandlaunch(localclientnum, model, pos, angles, hitpos, force);
  if(!isDefined(dynent)) {
    return;
  }
  posheight = pos[2];
  wait(0.5);
  if(!isDefined(dynent) || !isdynentvalid(dynent)) {
    return false;
  }
  if(dynent.origin == pos) {
    setdynentenabled(dynent, 0);
    return;
  }
  pos = dynent.origin;
  wait(0.4);
  if(!isDefined(dynent) || !isdynentvalid(dynent)) {
    return false;
  }
  if(dynent.origin == pos) {
    setdynentenabled(dynent, 0);
    return;
  }
  wait(1);
  if(!isDefined(dynent) || !isdynentvalid(dynent)) {
    return false;
  }
  count = 0;
  old_pos = dynent.origin;
  while(isDefined(dynent) && isdynentvalid(dynent)) {
    if(old_pos == dynent.origin) {
      old_pos = dynent.origin;
      count++;
      if(count == 5) {
        if((posheight - dynent.origin[2]) < 15) {
          setdynentenabled(dynent, 0);
        } else {
          break;
        }
      }
    } else {
      count = 0;
    }
    wait(0.2);
  }
}