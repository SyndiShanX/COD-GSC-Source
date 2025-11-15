/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_giant_robot.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_tomb_amb;
#namespace zm_tomb_giant_robot;

function init() {
  clientfield::register("scriptmover", "register_giant_robot", 21000, 1, "int", & register_giant_robot, 0, 0);
  clientfield::register("world", "start_anim_robot_0", 21000, 1, "int", & function_7e19465b, 0, 0);
  clientfield::register("world", "start_anim_robot_1", 21000, 1, "int", & function_7e19465b, 0, 0);
  clientfield::register("world", "start_anim_robot_2", 21000, 1, "int", & function_7e19465b, 0, 0);
  clientfield::register("world", "play_foot_stomp_fx_robot_0", 21000, 2, "int", & function_36b7480d, 0, 0);
  clientfield::register("world", "play_foot_stomp_fx_robot_1", 21000, 2, "int", & function_36b7480d, 0, 0);
  clientfield::register("world", "play_foot_stomp_fx_robot_2", 21000, 2, "int", & function_36b7480d, 0, 0);
  clientfield::register("world", "play_foot_open_fx_robot_0", 21000, 2, "int", & function_6e99bd62, 0, 0);
  clientfield::register("world", "play_foot_open_fx_robot_1", 21000, 2, "int", & function_6e99bd62, 0, 0);
  clientfield::register("world", "play_foot_open_fx_robot_2", 21000, 2, "int", & function_6e99bd62, 0, 0);
  clientfield::register("world", "eject_warning_fx_robot_0", 21000, 1, "int", & function_aa136ff9, 0, 0);
  clientfield::register("world", "eject_warning_fx_robot_1", 21000, 1, "int", & function_aa136ff9, 0, 0);
  clientfield::register("world", "eject_warning_fx_robot_2", 21000, 1, "int", & function_aa136ff9, 0, 0);
  clientfield::register("scriptmover", "light_foot_fx_robot", 21000, 2, "int", & function_98a05ad2, 0, 0);
  clientfield::register("allplayers", "eject_steam_fx", 21000, 1, "int", & function_d4c69cd, 0, 0);
  clientfield::register("allplayers", "all_tubes_play_eject_steam_fx", 21000, 1, "int", & all_tubes_play_eject_steam_fx, 0, 0);
  clientfield::register("allplayers", "gr_eject_player_impact_fx", 21000, 1, "int", & gr_eject_player_impact_fx, 0, 0);
  clientfield::register("toplayer", "giant_robot_rumble_and_shake", 21000, 2, "int", & giant_robot_rumble_and_shake, 0, 0);
  clientfield::register("world", "church_ceiling_fxanim", 21000, 1, "int", & church_ceiling_fxanim, 0, 0);
}

function register_giant_robot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(level.a_giant_robots)) {
    level.a_giant_robots = [];
    level.a_giant_robots[localclientnum] = [];
  }
  if(self.model == "veh_t7_zhd_robot_0") {
    level.a_giant_robots[localclientnum][0] = self;
  } else {
    if(self.model == "veh_t7_zhd_robot_1") {
      level.a_giant_robots[localclientnum][1] = self;
    } else if(self.model == "veh_t7_zhd_robot_2") {
      level.a_giant_robots[localclientnum][2] = self;
    }
  }
}

function function_36b7480d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  ai_robot = function_9f95c19e(localclientnum, fieldname);
  if(!isDefined(ai_robot)) {
    return;
  }
  ai_robot thread function_d46dfa88(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
  if(newval == 1) {
    ai_robot.var_16a8765e = playFXOnTag(localclientnum, level._effect["robot_foot_stomp"], ai_robot, "tag_hatch_fx_ri");
    origin = ai_robot gettagorigin("tag_hatch_fx_ri");
    playSound(0, "zmb_robot_foot_impact", origin);
  } else if(newval == 2) {
    ai_robot.var_16a8765e = playFXOnTag(localclientnum, level._effect["robot_foot_stomp"], ai_robot, "tag_hatch_fx_le");
    origin = ai_robot gettagorigin("tag_hatch_fx_le");
    playSound(0, "zmb_robot_foot_impact", origin);
  }
  setfxignorepause(localclientnum, ai_robot.var_16a8765e, 1);
}

function function_98a05ad2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self.var_e655463b = playFXOnTag(localclientnum, level._effect["giant_robot_foot_light"], self, "tag_foot_bottom_left");
    setfxignorepause(localclientnum, self.var_e655463b, 1);
  } else {
    if(newval == 2) {
      self.var_e655463b = playFXOnTag(localclientnum, level._effect["giant_robot_foot_light"], self, "tag_foot_bottom_right");
      setfxignorepause(localclientnum, self.var_e655463b, 1);
    } else if(isDefined(self.var_e655463b)) {
      killfx(localclientnum, self.var_e655463b);
    }
  }
}

function function_6e99bd62(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  ai_robot = function_9f95c19e(localclientnum, fieldname);
  if(!isDefined(ai_robot)) {
    return;
  }
  v_fx_offset = vectorscale((0, 0, 1), 56);
  if(newval == 1) {
    v_fx_pos = ai_robot gettagorigin("tag_hatch_fx_ri");
    v_fx_pos = v_fx_pos - v_fx_offset;
    ai_robot.var_140b6e83 = spawn(localclientnum, v_fx_pos, "script_model");
    ai_robot.var_140b6e83 setModel("tag_origin");
    ai_robot.var_140b6e83 linkto(ai_robot, "tag_hatch_fx_ri");
    ai_robot.var_140b6e83 playSound(0, "zmb_zombieblood_3rd_plane_explode");
    ai_robot.var_140b6e83.n_death_fx = playFXOnTag(localclientnum, level._effect["mechz_death"], ai_robot.var_140b6e83, "tag_origin");
    setfxignorepause(localclientnum, ai_robot.var_140b6e83.n_death_fx, 1);
  } else {
    if(newval == 2) {
      v_fx_pos = ai_robot gettagorigin("tag_hatch_fx_le");
      v_fx_pos = v_fx_pos - v_fx_offset;
      ai_robot.var_140b6e83 = spawn(localclientnum, v_fx_pos, "script_model");
      ai_robot.var_140b6e83 setModel("tag_origin");
      ai_robot.var_140b6e83 linkto(ai_robot, "tag_hatch_fx_le");
      ai_robot.var_140b6e83 playSound(0, "zmb_zombieblood_3rd_plane_explode");
      ai_robot.var_140b6e83.n_death_fx = playFXOnTag(localclientnum, level._effect["mechz_death"], ai_robot.var_140b6e83, "tag_origin");
      setfxignorepause(localclientnum, ai_robot.var_140b6e83.n_death_fx, 1);
    } else if(isDefined(ai_robot.var_140b6e83)) {
      ai_robot.var_140b6e83 delete();
    }
  }
}

function function_aa136ff9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    s_origin = struct::get(fieldname, "targetname");
    v_fx_pos = s_origin.origin;
    level.fieldname[localclientnum] = spawn(localclientnum, v_fx_pos, "script_model");
    level.fieldname[localclientnum] setModel("tag_origin");
    level.fieldname[localclientnum].var_68f810db = playFXOnTag(localclientnum, level._effect["eject_warning"], level.fieldname[localclientnum], "tag_origin");
    setfxignorepause(localclientnum, level.fieldname[localclientnum].var_68f810db, 1);
  } else if(isDefined(level.fieldname[localclientnum])) {
    level.fieldname[localclientnum] delete();
  }
}

function function_d4c69cd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self thread function_691b8375(localclientnum);
  } else {
    self notify("stop_eject_steam_fx");
    if(isDefined(self.fieldname)) {
      stopfx(localclientnum, self.fieldname);
    }
  }
}

function function_691b8375(localclientnum) {
  self endon("stop_eject_steam_fx");
  self endon("player_intermission");
  var_bd5df270 = struct::get_array("giant_robot_eject_tube", "script_noteworthy");
  s_tube = arraygetclosest(self.origin, var_bd5df270);
  self thread function_caeb1b02("stop_eject_steam_fx", s_tube.origin);
  while(isDefined(self)) {
    self.fieldname = playFX(localclientnum, level._effect["eject_steam"], s_tube.origin, anglesToForward(s_tube.angles), anglestoup(s_tube.angles));
    setfxignorepause(localclientnum, self.fieldname, 1);
    wait(0.1);
  }
}

function all_tubes_play_eject_steam_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    var_66a1e889 = struct::get_array("giant_robot_eject_tube", "script_noteworthy");
    var_8356f695 = arraygetclosest(self.origin, var_66a1e889);
    n_robot_id = var_8356f695.script_int;
    level.var_bd5df270 = [];
    level.var_bd5df270[localclientnum] = [];
    n_index = 0;
    foreach(struct in var_66a1e889) {
      if(struct.script_int == n_robot_id) {
        struct thread function_3ae72e85(localclientnum);
        level.var_bd5df270[localclientnum][n_index] = struct;
        n_index++;
      }
    }
  } else if(isDefined(level.var_bd5df270[localclientnum])) {
    foreach(struct in level.var_bd5df270[localclientnum]) {
      struct notify("stop_all_tubes_eject_steam");
    }
  }
}

function function_3ae72e85(localclientnum) {
  self endon("stop_all_tubes_eject_steam");
  self thread function_caeb1b02("stop_all_tubes_eject_steam", self.origin);
  while(true) {
    self.var_d1c8c63f = playFX(localclientnum, level._effect["eject_steam"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    setfxignorepause(localclientnum, self.var_d1c8c63f, 1);
    wait(0.1);
  }
}

function function_caeb1b02(var_365d1fde, origin) {
  audio::playloopat("zmb_bot_timeout_steam", origin);
  self waittill(var_365d1fde);
  audio::stoploopat("zmb_bot_timeout_steam", origin);
}

function gr_eject_player_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self.fieldname = playFX(localclientnum, level._effect["beacon_shell_explosion"], self.origin);
    setfxignorepause(localclientnum, self.fieldname, 1);
  } else if(isDefined(self.fieldname)) {
    stopfx(localclientnum, self.fieldname);
  }
}

function function_9f95c19e(localclientnum, fieldname) {
  if(!isDefined(level.a_giant_robots) || !isDefined(level.a_giant_robots[localclientnum])) {
    return undefined;
  }
  ai_robot = undefined;
  if(issubstr(fieldname, 0)) {
    ai_robot = level.a_giant_robots[localclientnum][0];
    if(isDefined(ai_robot)) {
      ai_robot.var_90d8d560 = 0;
    }
  } else {
    if(issubstr(fieldname, 1)) {
      ai_robot = level.a_giant_robots[localclientnum][1];
      if(isDefined(ai_robot)) {
        ai_robot.var_90d8d560 = 1;
      }
    } else {
      ai_robot = level.a_giant_robots[localclientnum][2];
      if(isDefined(ai_robot)) {
        ai_robot.var_90d8d560 = 2;
      }
    }
  }
  return ai_robot;
}

function function_7e19465b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(level.var_58b72d2f)) {
    level.var_58b72d2f = [];
    level.var_58b72d2f[0] = spawnStruct();
    level.var_58b72d2f[0].struct_name = "nml_warn_light_fp_ref";
    level.var_58b72d2f[0].var_11927f3d = struct::get_array("nml_foot_warn_light", "targetname");
    assert(level.var_58b72d2f[0].var_11927f3d.size > 0, "");
    level.var_58b72d2f[1] = spawnStruct();
    level.var_58b72d2f[1].struct_name = "trench_warn_light_fp_ref";
    level.var_58b72d2f[1].var_11927f3d = [];
    level.var_58b72d2f[1].var_11927f3d = struct::get_array("trench_foot_warn_light", "targetname");
    assert(level.var_58b72d2f[1].var_11927f3d.size > 0, "");
    level.var_58b72d2f[2] = spawnStruct();
    level.var_58b72d2f[2].struct_name = "church_warn_light_fp_ref";
    level.var_58b72d2f[2].var_11927f3d = [];
    level.var_58b72d2f[2].var_11927f3d = struct::get_array("church_foot_warn_light", "targetname");
    assert(level.var_58b72d2f[2].var_11927f3d.size > 0, "");
  }
  ai_robot = function_9f95c19e(localclientnum, fieldname);
  if(!isDefined(ai_robot) || !isDefined(level.var_58b72d2f[ai_robot.var_90d8d560])) {
    return;
  }
  if(newval == 1) {
    ai_robot.var_6e5e4d07 = struct::get(level.var_58b72d2f[ai_robot.var_90d8d560].struct_name + "_left", "targetname");
    ai_robot.var_bd0d6d82 = struct::get(level.var_58b72d2f[ai_robot.var_90d8d560].struct_name + "_right", "targetname");
    ai_robot function_bbae1203(localclientnum, ai_robot.var_6e5e4d07);
    ai_robot function_bbae1203(localclientnum, ai_robot.var_bd0d6d82);
  } else {
    ai_robot function_aacf48b5(localclientnum);
    ai_robot.var_6e5e4d07 = undefined;
    ai_robot.var_bd0d6d82 = undefined;
  }
}

function function_bbae1203(localclientnum, var_75158c9e) {
  a_lights = function_d31a2386(var_75158c9e);
  foreach(light in a_lights) {
    if(!isDefined(light.var_1398bc94)) {
      if(!isDefined(light.angles)) {
        light.angles = (0, 0, 0);
      }
      light.var_1398bc94 = playFX(localclientnum, level._effect["giant_robot_footstep_warning_light"], light.origin, anglesToForward(light.angles), anglestoup(light.angles));
      setfxignorepause(localclientnum, light.var_1398bc94, 1);
    }
  }
}

function function_d91e5529(localclientnum, var_75158c9e) {
  a_lights = function_d31a2386(var_75158c9e);
  foreach(light in a_lights) {
    if(isDefined(light.var_1398bc94)) {
      stopfx(localclientnum, light.var_1398bc94);
      light.var_1398bc94 = undefined;
    }
  }
}

function function_aacf48b5(localclientnum) {
  foreach(light in level.var_58b72d2f[self.var_90d8d560].var_11927f3d) {
    if(isDefined(light.var_1398bc94)) {
      stopfx(localclientnum, light.var_1398bc94);
      light.var_1398bc94 = undefined;
    }
  }
}

function function_d31a2386(var_75158c9e) {
  var_fa1ca319 = [];
  foreach(light in level.var_58b72d2f[self.var_90d8d560].var_11927f3d) {
    if(distancesquared(var_75158c9e.origin, light.origin) < 640000) {
      if(!isDefined(var_fa1ca319)) {
        var_fa1ca319 = [];
      } else if(!isarray(var_fa1ca319)) {
        var_fa1ca319 = array(var_fa1ca319);
      }
      var_fa1ca319[var_fa1ca319.size] = light;
    }
  }
  return var_fa1ca319;
}

function function_d46dfa88(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  wait(1);
  if(newval == 1) {
    if(isDefined(self.var_bd0d6d82)) {
      var_8f93a98e = self gettagorigin("tag_hatch_fx_ri");
      if(distancesquared(self.var_bd0d6d82.origin, var_8f93a98e) < (300 * 300)) {
        function_d91e5529(localclientnum, self.var_bd0d6d82);
        wait(0.05);
        if(isDefined(self.var_bd0d6d82.target)) {
          self.var_bd0d6d82 = struct::get(self.var_bd0d6d82.target, "targetname");
          function_bbae1203(localclientnum, self.var_bd0d6d82);
        } else {
          self.var_bd0d6d82 = undefined;
        }
      }
    }
  } else if(newval == 2) {
    if(isDefined(self.var_6e5e4d07)) {
      var_8f93a98e = self gettagorigin("tag_hatch_fx_le");
      if(distancesquared(self.var_6e5e4d07.origin, var_8f93a98e) < (300 * 300)) {
        function_d91e5529(localclientnum, self.var_6e5e4d07);
        wait(0.05);
        if(isDefined(self.var_6e5e4d07.target)) {
          self.var_6e5e4d07 = struct::get(self.var_6e5e4d07.target, "targetname");
          function_bbae1203(localclientnum, self.var_6e5e4d07);
        } else {
          self.var_6e5e4d07 = undefined;
        }
      }
    }
  }
}

function giant_robot_rumble_and_shake(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("disconnect");
  if(newval == 3) {
    self earthquake(0.6, 1.5, self.origin, 100);
    self playrumbleonentity(localclientnum, "artillery_rumble");
    soundrattle(self.origin, 250, 750);
  } else {
    if(newval == 2) {
      self earthquake(0.3, 1.5, self.origin, 100);
      self playrumbleonentity(localclientnum, "shotgun_fire");
      soundrattle(self.origin, 100, 500);
    } else {
      if(newval == 1) {
        self earthquake(0.1, 1, self.origin, 100);
        self playrumbleonentity(localclientnum, "damage_heavy");
        soundrattle(self.origin, 10, 350);
      } else {
        self notify("hash_ee5c27b3");
      }
    }
  }
}

function church_ceiling_fxanim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    var_61cbe98c = getent(localclientnum, "church_ceiling", "targetname");
    var_61cbe98c scene::play("p7_fxanim_zm_ori_church_ceiling_bundle", var_61cbe98c);
  }
}