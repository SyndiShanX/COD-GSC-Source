/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_skullweapon_quest.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\craftables\_zm_craftables;
#using_animtree("generic");
#namespace zm_island_skullquest;

function init() {
  clientfield::register("world", "keeper_spawn_portals", 1, 1, "int", &keeper_spawn_portals, 0, 0);
  clientfield::register("actor", "keeper_fx", 1, 1, "int", &keeper_fx, 0, 0);
  clientfield::register("actor", "ritual_attacker_fx", 1, 1, "int", &ritual_attacker_fx, 0, 0);
  clientfield::register("world", "skullquest_ritual_1_fx", 1, 3, "int", &skullquest_ritual_1_fx, 0, 0);
  clientfield::register("world", "skullquest_ritual_2_fx", 1, 3, "int", &skullquest_ritual_2_fx, 0, 0);
  clientfield::register("world", "skullquest_ritual_3_fx", 1, 3, "int", &skullquest_ritual_3_fx, 0, 0);
  clientfield::register("world", "skullquest_ritual_4_fx", 1, 3, "int", &skullquest_ritual_4_fx, 0, 0);
  clientfield::register("scriptmover", "skullquest_finish_start_fx", 1, 1, "int", &skullquest_finish_start_fx, 0, 0);
  clientfield::register("scriptmover", "skullquest_finish_trail_fx", 1, 1, "int", &skullquest_finish_trail_fx, 0, 0);
  clientfield::register("scriptmover", "skullquest_finish_end_fx", 1, 1, "int", &skullquest_finish_end_fx, 0, 0);
  clientfield::register("scriptmover", "skullquest_finish_done_glow_fx", 1, 1, "int", &skullquest_finish_done_glow_fx, 0, 0);
}

function keeper_spawn_portals(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_eebff756 = "s_spawnpt_skullroom";
  function_46df8306(localclientnum, var_eebff756, newval);
}

function function_46df8306(localclientnum, str_name, b_on = 1) {
  a_s_spawn_points = struct::get_array(str_name, "targetname");
  foreach(s_spawn_point in a_s_spawn_points) {
    s_spawn_point function_267f859f(localclientnum, level._effect["keeper_spawn"], b_on);
    if(!isDefined(s_spawn_point.var_d52fc488)) {
      s_spawn_point.var_d52fc488 = 0;
    }
    if(isDefined(b_on) && b_on) {
      if(!(isDefined(s_spawn_point.var_d52fc488) && s_spawn_point.var_d52fc488)) {
        s_spawn_point.var_d52fc488 = 1;
        playSound(0, "evt_keeper_portal_start", s_spawn_point.origin);
        audio::playloopat("evt_keeper_portal_loop", s_spawn_point.origin);
      }
    } else if(isDefined(s_spawn_point.var_d52fc488) && s_spawn_point.var_d52fc488) {
      s_spawn_point.var_d52fc488 = 0;
      playSound(0, "evt_keeper_portal_end", s_spawn_point.origin);
      audio::stoploopat("evt_keeper_portal_loop", s_spawn_point.origin);
    }
    wait(0.2);
  }
}

function function_f58977cd(localclientnum, str_name, b_on = 1) {
  a_s_spawn_points = struct::get_array(str_name, "targetname");
  foreach(s_spawn_point in a_s_spawn_points) {
    s_spawn_point function_267f859f(localclientnum, level._effect["ritual_portal_start"], b_on);
    s_spawn_point function_267f859f(localclientnum, level._effect["ritual_portal_loop"], b_on);
    if(!isDefined(s_spawn_point.var_d52fc488)) {
      s_spawn_point.var_d52fc488 = 0;
    }
    if(isDefined(b_on) && b_on) {
      if(!(isDefined(s_spawn_point.var_d52fc488) && s_spawn_point.var_d52fc488)) {
        s_spawn_point.var_d52fc488 = 1;
        playSound(0, "zmb_skull_ritual_portal_start", s_spawn_point.origin);
        audio::playloopat("zmb_skull_ritual_portal_lp", s_spawn_point.origin);
      }
    } else {
      s_spawn_point function_267f859f(localclientnum, level._effect["ritual_portal_end"], b_on);
      if(isDefined(s_spawn_point.var_d52fc488) && s_spawn_point.var_d52fc488) {
        s_spawn_point.var_d52fc488 = 0;
        playSound(0, "zmb_skull_ritual_portal_end", s_spawn_point.origin);
        audio::stoploopat("zmb_skull_ritual_portal_lp", s_spawn_point.origin);
      }
    }
    wait(0.2);
  }
}

function skullquest_ritual_1_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_4dcbb3a6(localclientnum, 1, newval);
}

function skullquest_ritual_2_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_4dcbb3a6(localclientnum, 2, newval);
}

function skullquest_ritual_3_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_4dcbb3a6(localclientnum, 3, newval);
}

function skullquest_ritual_4_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_4dcbb3a6(localclientnum, 4, newval);
}

function function_4dcbb3a6(localclientnum, var_f2e38849, n_fx_type = 1) {
  var_f4fc4e39[0] = "";
  var_f4fc4e39[1] = level._effect["ritual_progress_skull"];
  var_f4fc4e39[2] = level._effect["ritual_progress_skull_75"];
  var_f4fc4e39[3] = level._effect["ritual_progress_skull_50"];
  var_f4fc4e39[4] = level._effect["ritual_progress_skull_25"];
  var_d9cf2ecd = struct::get_array("s_skulltar_skull_pos", "targetname");
  foreach(var_89669ffb in var_d9cf2ecd) {
    if(var_89669ffb.script_special == var_f2e38849) {
      var_b9533b1f = var_89669ffb;
      break;
    }
  }
  var_14c8adef = struct::get_array("s_skulltar_base_pos", "targetname");
  foreach(var_9915798f in var_14c8adef) {
    if(var_9915798f.script_special == var_f2e38849) {
      var_4b429234 = var_9915798f;
    }
  }
  var_4a347901 = ("skulltar_" + var_f2e38849) + "_spawnpts";
  if(isDefined(n_fx_type) && n_fx_type >= 0 && n_fx_type < 5) {
    var_b9533b1f function_267f859f(localclientnum, var_f4fc4e39[n_fx_type], n_fx_type);
    var_4b429234 function_267f859f(localclientnum, level._effect["ritual_progress_skulltar"], n_fx_type);
    if(n_fx_type > 0) {
      if(n_fx_type === 1) {
        level thread function_f58977cd(localclientnum, var_4a347901, 1);
      }
      if(!(isDefined(var_b9533b1f.var_d52fc488) && var_b9533b1f.var_d52fc488)) {
        var_b9533b1f.var_d52fc488 = 1;
      }
    } else if(isDefined(var_b9533b1f.var_d52fc488) && var_b9533b1f.var_d52fc488) {
      var_b9533b1f.var_d52fc488 = 0;
    }
  } else {
    level thread function_f58977cd(localclientnum, var_4a347901, 0);
    if(n_fx_type === 5) {
      var_b9533b1f function_267f859f(localclientnum, level._effect["ritual_success_skull"], 1);
      var_4b429234 function_267f859f(localclientnum, level._effect["ritual_progress_skulltar"], 0);
    } else if(n_fx_type === 6) {
      var_b9533b1f function_267f859f(localclientnum, level._effect["ritual_progress_skull_fail"], 1);
      var_4b429234 function_267f859f(localclientnum, level._effect["ritual_progress_skulltar"], 0);
    }
  }
  wait(0.2);
}

function skullquest_finish_start_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_2c75d806 = playFXOnTag(localclientnum, level._effect["skullquest_finish_start"], self, "tag_origin");
  } else {
    if(isDefined(self.var_2c75d806)) {
      stopfx(localclientnum, self.var_2c75d806);
    }
    self.var_2c75d806 = undefined;
  }
}

function skullquest_finish_trail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_8d24a0fa = playFXOnTag(localclientnum, level._effect["skullquest_finish_trail"], self, "tag_origin");
  } else {
    if(isDefined(self.var_8d24a0fa)) {
      stopfx(localclientnum, self.var_8d24a0fa);
    }
    self.var_8d24a0fa = undefined;
  }
}

function skullquest_finish_end_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_f88006a5 = playFXOnTag(localclientnum, level._effect["skullquest_finish_end"], self, "tag_origin");
  } else {
    if(isDefined(self.var_f88006a5)) {
      stopfx(localclientnum, self.var_f88006a5);
    }
    self.var_f88006a5 = undefined;
  }
}

function skullquest_finish_done_glow_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_f88006a5 = playFXOnTag(localclientnum, level._effect["skullquest_skull_done_glow"], self, "tag_origin");
  } else {
    if(isDefined(self.var_f88006a5)) {
      stopfx(localclientnum, self.var_f88006a5);
    }
    self.var_f88006a5 = undefined;
  }
}

function keeper_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);
  if(isDefined(self)) {
    if(newval === 1) {
      self.var_341f7209 = playFXOnTag(localclientnum, level._effect["keeper_glow"], self, "j_spineupper");
      self.var_c5e3cf4b = playFXOnTag(localclientnum, level._effect["keeper_mouth"], self, "j_head");
      self.var_2d3cc156 = playFXOnTag(localclientnum, level._effect["keeper_trail"], self, "j_robe_front_03");
      if(!isDefined(self.sndlooper)) {
        self.sndlooper = self playLoopSound("zmb_keeper_looper");
      }
    } else {
      if(isDefined(self.var_341f7209)) {
        stopfx(localclientnum, self.var_341f7209);
      }
      self.var_341f7209 = undefined;
      if(isDefined(self.var_c5e3cf4b)) {
        stopfx(localclientnum, self.var_c5e3cf4b);
      }
      self.var_c5e3cf4b = undefined;
      if(isDefined(self.var_2d3cc156)) {
        stopfx(localclientnum, self.var_2d3cc156);
      }
      self.var_2d3cc156 = undefined;
      v_origin = self gettagorigin("j_spineupper");
      v_angles = self gettagangles("j_spineupper");
      if(isDefined(v_origin) && isDefined(v_angles)) {
        playFX(localclientnum, level._effect["keeper_death"], v_origin, v_angles);
      }
      self stopallloopsounds(1);
    }
  }
}

function ritual_attacker_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);
  if(isDefined(self)) {
    if(newval === 1) {
      if(self.archetype === "zombie") {
        self.var_341f7209 = playFXOnTag(localclientnum, level._effect["ritual_attacker"], self, "j_spine4");
      } else {
        self.var_341f7209 = playFXOnTag(localclientnum, level._effect["ritual_attacker"], self, "tag_origin");
      }
      if(!isDefined(self.sndlooper)) {
        self.sndlooper = self playLoopSound("zmb_keeper_looper");
      }
    } else {
      if(isDefined(self.var_341f7209)) {
        stopfx(localclientnum, self.var_341f7209);
        self.var_341f7209 = undefined;
      }
      v_origin = self gettagorigin("tag_origin");
      v_angles = self gettagangles("tag_origin");
      if(isDefined(v_origin) && isDefined(v_angles)) {
        playFX(localclientnum, level._effect["keeper_death"], v_origin, v_angles);
      }
      self stopallloopsounds(1);
    }
  }
}

function function_267f859f(localclientnum, fx_id = undefined, b_on = 1, var_afcc5d76 = 0, str_tag = "tag_origin") {
  if(!isDefined(self.vfx_ref)) {
    self.vfx_ref = [];
  }
  if(b_on) {
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(self.vfx_ref[localclientnum])) {
      stopfx(localclientnum, self.vfx_ref[localclientnum]);
    }
    if(var_afcc5d76) {
      self.vfx_ref[localclientnum] = playFXOnTag(localclientnum, fx_id, self, str_tag);
    } else {
      self.vfx_ref[localclientnum] = playFX(localclientnum, fx_id, self.origin, anglesToForward(self.angles));
    }
  } else if(isDefined(self.vfx_ref[localclientnum])) {
    stopfx(localclientnum, self.vfx_ref[localclientnum]);
    self.vfx_ref[localclientnum] = undefined;
  }
}