/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_arena.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_genesis_util;
#using_animtree("generic");
#namespace zm_genesis_arena;

function autoexec __init__sytem__() {
  system::register("zm_genesis_arena", &__init__, undefined, undefined);
}

function __init__() {
  level.var_51541120 = [];
  clientfield::register("world", "arena_state", 15000, getminbitcountfornum(5), "int", &arena_state, 0, 0);
  clientfield::register("world", "circle_state", 15000, getminbitcountfornum(6), "int", &circle_state, 0, 0);
  clientfield::register("world", "circle_challenge_identity", 15000, getminbitcountfornum(6), "int", undefined, 0, 0);
  clientfield::register("world", "summoning_key_charge_state", 15000, getminbitcountfornum(4), "int", &summoning_key_charge_state, 0, 1);
  clientfield::register("toplayer", "fire_postfx_set", 15000, 1, "int", &fire_postfx_set, 0, 0);
  clientfield::register("scriptmover", "fire_column", 15000, 1, "int", &fire_column, 0, 0);
  clientfield::register("scriptmover", "summoning_circle_fx", 15000, 1, "int", &summoning_circle_fx, 0, 0);
  clientfield::register("toplayer", "darkness_postfx_set", 15000, 1, "int", &darkness_postfx_set, 0, 0);
  clientfield::register("toplayer", "electricity_postfx_set", 15000, 1, "int", &electricity_postfx_set, 0, 0);
  clientfield::register("world", "light_challenge_floor", 15000, 1, "int", &light_challenge_floor, 0, 0);
  clientfield::register("actor", "arena_margwa_init", 15000, 1, "int", &arena_margwa_init, 0, 0);
  clientfield::register("scriptmover", "arena_tornado", 15000, 1, "int", &arena_tornado, 0, 0);
  clientfield::register("scriptmover", "arena_shadow_pillar", 15000, 1, "int", &arena_shadow_pillar, 0, 0);
  clientfield::register("scriptmover", "elec_wall_tell", 15000, 1, "counter", &elec_wall_tell, 0, 0);
  clientfield::register("world", "summoning_key_pickup", 15000, getminbitcountfornum(3), "int", &summoning_key_pickup, 0, 0);
  clientfield::register("world", "arena_timeout_warning", 15000, 1, "int", &arena_timeout_warning, 0, 0);
  clientfield::register("world", "basin_state_0", 15000, getminbitcountfornum(5), "int", &basin_state_0, 0, 1);
  clientfield::register("world", "basin_state_1", 15000, getminbitcountfornum(5), "int", &basin_state_1, 0, 1);
  clientfield::register("world", "basin_state_2", 15000, getminbitcountfornum(5), "int", &basin_state_2, 0, 1);
  clientfield::register("world", "basin_state_3", 15000, getminbitcountfornum(5), "int", &basin_state_3, 0, 1);
  clientfield::register("scriptmover", "runeprison_rock_fx", 5000, 1, "int", &runeprison_rock_fx, 0, 0);
  clientfield::register("scriptmover", "runeprison_explode_fx", 5000, 1, "int", &runeprison_explode_fx, 0, 0);
  var_29441edd = struct::get_array("powerup_visual", "targetname");
  foreach(s_powerup_loc in var_29441edd) {
    s_powerup_loc.var_90369c89 = [];
  }
  clientfield::register("toplayer", "powerup_visual_marker", 15000, 2, "int", &function_b9c422c3, 0, 1);
}

function summoning_key_charge_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_244d3483(localclientnum);
  level.var_530ae70[localclientnum] util::waittill_dobj(localclientnum);
  if(isDefined(level.var_530ae70[localclientnum].var_1397ba8a)) {
    stopfx(localclientnum, level.var_530ae70[localclientnum].var_1397ba8a);
  }
  level.var_530ae70[localclientnum].var_1397ba8a = playFXOnTag(localclientnum, level._effect["summoning_key_charge_" + (newval + 1)], level.var_530ae70[localclientnum], "key_root_jnt");
}

function arena_timeout_warning(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_players = getplayers(localclientnum);
  foreach(player in a_players) {
    if(newval > 0) {
      var_946b7723 = 5;
    } else {
      var_946b7723 = 0;
    }
    player thread zm_genesis_util::player_rumble_and_shake(localclientnum, oldval, var_946b7723, bnewent, binitialsnap, fieldname, bwastimejump);
  }
}

function elec_wall_tell(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    playFXOnTag(localclientnum, level._effect["elec_wall_tell"], self, "tag_origin");
    v_origin = self.origin;
    wait(0.25);
    if(isDefined(self)) {
      fx = playFX(localclientnum, level._effect["elec_wall_arc"], v_origin, anglesToForward(self.angles));
      self waittill("entityshutdown");
      stopfx(localclientnum, fx);
    }
  }
}

function runeprison_rock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 0: {
      self.var_f8ac8c8b animation::play("p7_fxanim_zm_bow_rune_prison_02_anim");
      if(!isDefined(self)) {
        return;
      }
      self.var_f8ac8c8b setModel("p7_fxanim_zm_bow_rune_prison_dissolve_mod");
      self.var_f8ac8c8b thread function_79854312(localclientnum);
      self.var_f8ac8c8b animation::play("p7_fxanim_zm_bow_rune_prison_dissolve_anim");
      self.var_f8ac8c8b delete();
      break;
    }
    case 1: {
      self.var_f8ac8c8b = util::spawn_model(localclientnum, "p7_fxanim_zm_bow_rune_prison_mod", self.origin, self.angles);
      self.var_f8ac8c8b useanimtree($generic);
      self.var_f8ac8c8b animation::play("p7_fxanim_zm_bow_rune_prison_01_anim");
      break;
    }
  }
}

function function_79854312(localclientnum) {
  self endon("entityshutdown");
  n_start_time = gettime();
  n_end_time = n_start_time + 1633;
  b_is_updating = 1;
  while(b_is_updating) {
    n_time = gettime();
    if(n_time >= n_end_time) {
      n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_end_time);
      b_is_updating = 0;
    } else {
      n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
    wait(0.016);
  }
}

function runeprison_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["rune_fire_eruption"], self.origin, (0, 0, 1), (1, 0, 0));
  }
}

function basin_state_0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_bb70f55a(localclientnum, newval, 0);
}

function basin_state_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_bb70f55a(localclientnum, newval, 1);
}

function basin_state_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_bb70f55a(localclientnum, newval, 2);
}

function basin_state_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_bb70f55a(localclientnum, newval, 3);
}

function function_bb70f55a(localclientnum, newval, var_549b41ba) {
  function_244d3483(localclientnum);
  level.var_530ae70[localclientnum] util::waittill_dobj(localclientnum);
  switch (newval) {
    case 0: {
      if(isDefined(level.var_9431a5ac) && isDefined(level.var_9431a5ac[var_549b41ba])) {
        stopfx(localclientnum, level.var_9431a5ac[var_549b41ba]);
      }
      if(isDefined(level.var_1da8ae2)) {
        stopfx(localclientnum, level.var_1da8ae2);
      }
      level.var_530ae70[localclientnum] hide();
      if(isDefined(level.var_57b86889) && isDefined(level.var_57b86889[var_549b41ba])) {
        stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
      }
      var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
      audio::stoploopat("zmb_finalfight_key_holder_lp", var_e764f9dc.origin);
      audio::stoploopat("zmb_finalfight_key_charging_lp", var_e764f9dc.origin);
      break;
    }
    case 1: {
      if(isDefined(level.var_9431a5ac) && isDefined(level.var_9431a5ac[var_549b41ba])) {
        stopfx(localclientnum, level.var_9431a5ac[var_549b41ba]);
      }
      if(isDefined(level.var_1da8ae2)) {
        stopfx(localclientnum, level.var_1da8ae2);
      }
      level.var_530ae70[localclientnum] hide();
      if(isDefined(level.var_57b86889) && isDefined(level.var_57b86889[var_549b41ba])) {
        stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
      }
      if(!isDefined(level.var_57b86889)) {
        level.var_57b86889 = array(undefined, undefined, undefined, undefined);
      }
      if(isDefined(level.var_57b86889[var_549b41ba])) {
        stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
      }
      var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
      level.var_57b86889[var_549b41ba] = playFX(localclientnum, level._effect["gateworm_basin_ready"], var_e764f9dc.origin, vectorscale((1, 0, 0), 90));
      audio::playloopat("zmb_finalfight_key_holder_lp", var_e764f9dc.origin);
      audio::stoploopat("zmb_finalfight_key_charging_lp", var_e764f9dc.origin);
      break;
    }
    case 2: {
      if(isDefined(level.var_9431a5ac) && isDefined(level.var_9431a5ac[var_549b41ba])) {
        stopfx(localclientnum, level.var_9431a5ac[var_549b41ba]);
      }
      s_loc = struct::get("clientside_key_" + var_549b41ba, "targetname");
      level.var_530ae70[localclientnum].origin = s_loc.origin;
      level.var_530ae70[localclientnum] thread animation::play("p7_fxanim_zm_zod_summoning_key_idle_anim");
      if(!isDefined(level.var_1da8ae2)) {
        level.var_1da8ae2 = playFXOnTag(localclientnum, level._effect["summoning_key_glow"], level.var_530ae70[localclientnum], "key_root_jnt");
      }
      level.var_530ae70[localclientnum] show();
      level.var_530ae70[localclientnum] playSound(0, "zmb_finalfight_key_place");
      if(!isDefined(level.var_57b86889)) {
        level.var_57b86889 = array(undefined, undefined, undefined, undefined);
      }
      if(isDefined(level.var_57b86889[var_549b41ba])) {
        stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
      }
      var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
      level.var_57b86889[var_549b41ba] = playFX(localclientnum, level._effect["gateworm_basin_start"], var_e764f9dc.origin, vectorscale((1, 0, 0), 90));
      audio::stoploopat("zmb_finalfight_key_holder_lp", var_e764f9dc.origin);
      audio::playloopat("zmb_finalfight_key_charging_lp", var_e764f9dc.origin);
      break;
    }
    case 3: {
      if(isDefined(level.var_9431a5ac) && isDefined(level.var_9431a5ac[var_549b41ba])) {
        stopfx(localclientnum, level.var_9431a5ac[var_549b41ba]);
      }
      s_loc = struct::get("clientside_key_" + var_549b41ba, "targetname");
      level.var_530ae70[localclientnum].origin = s_loc.origin;
      level.var_530ae70[localclientnum] thread animation::play("p7_fxanim_zm_zod_summoning_key_idle_anim");
      if(!isDefined(level.var_1da8ae2)) {
        level.var_1da8ae2 = playFXOnTag(localclientnum, level._effect["summoning_key_glow"], level.var_530ae70[localclientnum], "key_root_jnt");
      }
      level.var_530ae70[localclientnum] show();
      level.var_530ae70[localclientnum] playSound(0, "zmb_finalfight_key_ready");
      if(!isDefined(level.var_57b86889)) {
        level.var_57b86889 = array(undefined, undefined, undefined, undefined);
      }
      if(isDefined(level.var_57b86889[var_549b41ba])) {
        stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
      }
      var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
      level.var_57b86889[var_549b41ba] = playFX(localclientnum, level._effect["gateworm_basin_charging"], var_e764f9dc.origin, vectorscale((1, 0, 0), 90));
      audio::playloopat("zmb_finalfight_key_holder_lp", var_e764f9dc.origin);
      audio::stoploopat("zmb_finalfight_key_charging_lp", var_e764f9dc.origin);
      break;
    }
    case 4: {
      if(isDefined(level.var_1da8ae2)) {
        stopfx(localclientnum, level.var_1da8ae2);
      }
      if(!isDefined(level.var_9431a5ac)) {
        level.var_9431a5ac = array(undefined, undefined, undefined, undefined);
      }
      if(!isDefined(level.var_9431a5ac[var_549b41ba])) {
        var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
        level.var_9431a5ac[var_549b41ba] = playFX(localclientnum, level._effect["curse_tell"], var_e764f9dc.origin, vectorscale((1, 0, 0), 90));
      }
      if(isDefined(level.var_57b86889) && isDefined(level.var_57b86889[var_549b41ba])) {
        stopfx(localclientnum, level.var_57b86889[var_549b41ba]);
      }
      var_e764f9dc = struct::get("clientside_flame_" + var_549b41ba, "targetname");
      audio::stoploopat("zmb_finalfight_key_holder_lp", var_e764f9dc.origin);
      audio::stoploopat("zmb_finalfight_key_charging_lp", var_e764f9dc.origin);
      level.var_530ae70[localclientnum] hide();
      break;
    }
  }
}

function parasite_fog_on(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
      setlitfogbank(localclientnum, -1, 1, -1);
      setworldfogactivebank(localclientnum, 2);
    }
  }
  if(newval == 2) {
    for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
      setlitfogbank(localclientnum, -1, 0, -1);
      setworldfogactivebank(localclientnum, 1);
    }
  }
}

function summoning_circle_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_63082da9 = playFX(localclientnum, level._effect["summoning_circle_fx"], self.origin, self.angles);
  } else if(isDefined(self.var_63082da9)) {
    stopfx(localclientnum, self.var_63082da9);
  }
}

function summoning_key_pickup(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level notify("summoning_key_pickup");
  level endon("summoning_key_pickup");
  function_244d3483(localclientnum);
  level.var_530ae70[localclientnum] util::waittill_dobj(localclientnum);
  var_1f5092c = struct::get("arena_reward_pickup", "targetname");
  switch (newval) {
    case 0: {
      level.var_530ae70[localclientnum] hide();
      if(isDefined(level.var_530ae70[localclientnum].fxid)) {
        stopfx(localclientnum, level.var_530ae70[localclientnum].fxid);
        level.var_530ae70[localclientnum].fxid = undefined;
      }
      if(isDefined(level.var_530ae70[localclientnum].var_e377eac9)) {
        stopfx(localclientnum, level.var_530ae70[localclientnum].var_e377eac9);
        level.var_530ae70[localclientnum].var_e377eac9 = undefined;
      }
      break;
    }
    case 1: {
      level.var_530ae70[localclientnum].origin = var_1f5092c.origin + vectorscale((0, 0, 1), 196);
      level.var_530ae70[localclientnum] show();
      if(!isDefined(level.var_530ae70[localclientnum].fxid)) {
        level.var_530ae70[localclientnum].fxid = playFXOnTag(localclientnum, level._effect["summoning_key_glow"], level.var_530ae70[localclientnum], "key_root_jnt");
      }
      if(!isDefined(level.var_530ae70[localclientnum].var_e377eac9)) {
        level.var_530ae70[localclientnum].var_e377eac9 = playFXOnTag(localclientnum, level._effect["summoning_key_holder"], level.var_530ae70[localclientnum], "key_root_jnt");
      }
      break;
    }
    case 2: {
      level.var_530ae70[localclientnum].origin = var_1f5092c.origin + vectorscale((0, 0, 1), 196);
      level.var_530ae70[localclientnum] show();
      level.var_530ae70[localclientnum] moveto(var_1f5092c.origin, 3);
      if(!isDefined(level.var_530ae70[localclientnum].fxid)) {
        level.var_530ae70[localclientnum].fxid = playFXOnTag(localclientnum, level._effect["summoning_key_glow"], level.var_530ae70[localclientnum], "key_root_jnt");
      }
      if(isDefined(level.var_530ae70[localclientnum].var_e377eac9)) {
        stopfx(localclientnum, level.var_530ae70[localclientnum].var_e377eac9);
        level.var_530ae70[localclientnum].var_e377eac9 = undefined;
      }
      break;
    }
  }
}

function arena_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level notify("arena_state");
  level endon("arena_state");
  if(!isDefined(level.var_b175da10)) {
    function_8fbd23f4(localclientnum);
  }
  switch (newval) {
    case 0: {
      break;
    }
    case 1: {
      break;
    }
    case 2: {
      break;
    }
    case 3: {
      break;
    }
    case 4: {
      break;
    }
  }
}

function circle_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level notify("circle_state");
  level endon("circle_state");
  n_challenge_index = clientfield::get("circle_challenge_identity");
  switch (newval) {
    case 0: {
      if(n_challenge_index == 0) {
        level thread player_screen_fx(localclientnum, 0);
        level thread function_df81c23d(localclientnum, 0);
      }
      break;
    }
    case 1: {
      if(n_challenge_index == 0) {
        level thread player_screen_fx(localclientnum, 0);
        level thread function_df81c23d(localclientnum, 0);
      }
      break;
    }
    case 2: {
      break;
    }
    case 3: {
      if(n_challenge_index == 0) {
        level thread player_screen_fx(localclientnum, 1);
        level thread function_df81c23d(localclientnum, 1);
      }
      break;
    }
    case 4: {
      if(n_challenge_index == 0) {
        level thread player_screen_fx(localclientnum, 0);
        level thread function_df81c23d(localclientnum, 0);
      }
      break;
    }
    case 5: {
      if(n_challenge_index == 0) {
        level thread player_screen_fx(localclientnum, 0);
        level thread function_df81c23d(localclientnum, 0);
      }
      break;
    }
  }
}

function function_8fbd23f4(localclientnum) {
  level.var_b175da10 = spawnStruct();
}

function function_244d3483(localclientnum) {
  if(!isDefined(level.var_530ae70)) {
    level.var_530ae70 = [];
  }
  if(!isDefined(level.var_530ae70[localclientnum])) {
    s_summoning_key = struct::get("summoning_key", "targetname");
    level.var_530ae70[localclientnum] = spawn(localclientnum, s_summoning_key.origin, "script_model");
    level.var_530ae70[localclientnum] setModel("p7_fxanim_zm_zod_summoning_key_mod");
    level.var_530ae70[localclientnum] useanimtree($generic);
    level.var_530ae70[localclientnum] hide();
    var_3b86bdff = struct::get("dark_arena_podium", "targetname");
    v_fwd = anglesToForward(var_3b86bdff.angles);
    playFX(localclientnum, level._effect["dark_arena_podium"], var_3b86bdff.origin, v_fwd);
  }
}

function function_a8a110ed(localclientnum, s_location, v_angle_offset = (0, 0, 0)) {
  var_244bacb5 = spawn(localclientnum, s_location.origin, "script_model");
  var_244bacb5.angles = s_location.angles + v_angle_offset;
  var_244bacb5 setModel(s_location.model);
  return var_244bacb5;
}

function function_3d5c3a74(var_9494ad2f) {
  s_summoning_key = struct::get("summoning_key", "targetname");
  v_offset = vectorscale((0, 0, 1), 512);
  if(!var_9494ad2f) {
    v_offset = (0, 0, 0);
  }
  self moveto(s_summoning_key.origin + v_offset, 3);
}

function function_17ef53cd() {
  self notify("hash_17ef53cd");
  self endon("hash_17ef53cd");
  v_origin = self.v_origin;
  n_duration = randomfloatrange(4.75, 5);
  while(true) {
    self.var_b079127 moveto(v_origin + vectorscale((0, 0, 1), 4), n_duration);
    self.var_4100f709 moveto(v_origin + vectorscale((0, 0, 1), 4), n_duration);
    wait(n_duration);
    self.var_b079127 moveto(v_origin, n_duration);
    self.var_4100f709 moveto(v_origin, n_duration);
    wait(n_duration);
  }
}

function function_5ce8eb7d(n_height) {
  for(i = 0; i < 5; i++) {
    level.var_8962a8a0[i] thread function_fad1f25a(n_height);
  }
}

function function_fad1f25a(n_height) {
  self notify("hash_17ef53cd");
  switch (n_height) {
    case 0: {
      n_duration = randomfloatrange(1.75, 2);
      self.var_b079127 moveto(self.v_origin + (vectorscale((0, 0, -1), 128)), n_duration);
      self.var_4100f709 moveto(self.v_origin + (vectorscale((0, 0, -1), 128)), n_duration);
      break;
    }
    case 1: {
      n_duration = randomfloatrange(1.75, 2);
      self.var_b079127 moveto(self.v_origin, n_duration);
      self.var_4100f709 moveto(self.v_origin, n_duration);
      break;
    }
    case 2: {
      n_duration = randomfloatrange(1.75, 2);
      self.var_b079127 moveto(self.v_origin + vectorscale((0, 0, 1), 128), n_duration);
      self.var_4100f709 moveto(self.v_origin + vectorscale((0, 0, 1), 128), n_duration);
      break;
    }
  }
}

function function_99a05235(b_on) {
  for(i = 0; i < 5; i++) {
    function_7277f824(i, b_on);
  }
}

function function_7277f824(n_index, b_on) {
  if(b_on) {
    level.var_8962a8a0[n_index].var_b079127 show();
    level.var_8962a8a0[n_index].var_4100f709 hide();
  } else {
    level.var_8962a8a0[n_index].var_b079127 hide();
    level.var_8962a8a0[n_index].var_4100f709 show();
  }
}

function function_3de943fb(state, e_model) {
  level notify("hash_3de943fb");
  level endon("hash_3de943fb");
  switch (state) {
    case 0: {
      e_model playSound(0, "evt_zod_ritual_reset");
      if(isDefined(e_model.sndent)) {
        e_model.sndent delete();
        e_model.sndent = undefined;
      }
      break;
    }
    case 1: {
      e_model playSound(0, "evt_zod_ritual_ready");
      if(!isDefined(e_model.sndent)) {
        e_model.sndent = spawn(0, e_model.origin, "script_origin");
        e_model.sndent linkto(e_model, "tag_origin");
      }
      e_model.sndent playLoopSound("evt_zod_ritual_ready_loop", 2);
      break;
    }
    case 2: {
      e_model playSound(0, "evt_zod_ritual_started");
      if(!isDefined(e_model.sndent)) {
        e_model.sndent = spawn(0, e_model.origin, "script_origin");
        e_model.sndent linkto(e_model, "tag_origin");
      }
      looper = e_model.sndent playLoopSound("evt_zod_ritual_started_loop", 2);
      pitch = 0.5;
      while(true) {
        setsoundpitch(looper, pitch);
        setsoundpitchrate(looper, 0.1);
        wait(1);
        pitch = pitch + 0.05;
      }
      break;
    }
    case 4: {
      e_model playSound(0, "evt_zod_ritual_finished");
      if(isDefined(e_model.sndent)) {
        e_model.sndent delete();
        e_model.sndent = undefined;
      }
      break;
    }
  }
}

function function_2bcc6bd2(state, e_model) {
  level notify("hash_2bcc6bd2");
  level endon("hash_2bcc6bd2");
  switch (state) {
    case 0: {
      e_model playSound(0, "evt_zod_ritual_reset");
      if(isDefined(e_model.sndent)) {
        e_model.sndent delete();
        e_model.sndent = undefined;
      }
      break;
    }
    case 1: {
      e_model playSound(0, "evt_zod_ritual_ready");
      if(!isDefined(e_model.sndent)) {
        e_model.sndent = spawn(0, e_model.origin, "script_origin");
        e_model.sndent linkto(e_model, "tag_origin");
      }
      e_model.sndent playLoopSound("evt_zod_ritual_ready_loop", 2);
      break;
    }
    case 2: {
      e_model playSound(0, "evt_zod_ritual_started");
      if(!isDefined(e_model.sndent)) {
        e_model.sndent = spawn(0, e_model.origin, "script_origin");
        e_model.sndent linkto(e_model, "tag_origin");
      }
      looper = e_model.sndent playLoopSound("evt_zod_ritual_started_loop", 2);
      pitch = 0.5;
      while(true) {
        setsoundpitch(looper, pitch);
        setsoundpitchrate(looper, 0.1);
        wait(1);
        pitch = pitch + 0.05;
      }
      break;
    }
    case 3: {
      e_model playSound(0, "evt_zod_ritual_started");
      if(!isDefined(e_model.sndent)) {
        e_model.sndent = spawn(0, e_model.origin, "script_origin");
        e_model.sndent linkto(e_model, "tag_origin");
      }
      looper = e_model.sndent playLoopSound("evt_zod_ritual_started_loop", 2);
      pitch = 0.5;
      while(true) {
        setsoundpitch(looper, pitch);
        setsoundpitchrate(looper, 0.1);
        wait(1);
        pitch = pitch + 0.05;
      }
      break;
    }
    case 4: {
      e_model playSound(0, "evt_zod_ritual_finished");
      if(isDefined(e_model.sndent)) {
        e_model.sndent delete();
        e_model.sndent = undefined;
      }
      break;
    }
    case 5: {
      e_model playSound(0, "evt_zod_ritual_finished");
      if(isDefined(e_model.sndent)) {
        e_model.sndent delete();
        e_model.sndent = undefined;
      }
      break;
    }
  }
}

function function_b9c422c3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_a42274ee = struct::get_array("challenge_fire_struct", "targetname");
  foreach(var_d2c81bd9 in var_a42274ee) {
    if(var_d2c81bd9.script_int == self getentitynumber()) {
      if(!isDefined(var_d2c81bd9.var_90369c89[localclientnum])) {
        var_d2c81bd9.var_90369c89[localclientnum] = playFX(localclientnum, level._effect["random_weapon_powerup_marker"], var_d2c81bd9.origin + (vectorscale((0, 0, -1), 8)));
      }
      continue;
    }
    if(isDefined(var_d2c81bd9.var_90369c89[localclientnum])) {
      deletefx(localclientnum, var_d2c81bd9.var_90369c89[localclientnum]);
      var_d2c81bd9.var_90369c89[localclientnum] = undefined;
    }
  }
}

function arena_margwa_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.margwa_spawn_effect = level._effect["arena_margwa_spawn"];
}

function electricity_postfx_set(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle("pstfx_shock_charge");
  } else {
    self thread postfx::exitpostfxbundle();
  }
}

function darkness_postfx_set(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle("pstfx_gen_chal_shadow");
  } else {
    self thread postfx::exitpostfxbundle();
  }
}

function fire_postfx_set(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle("pstfx_burn_loop");
  } else {
    self thread postfx::exitpostfxbundle();
  }
}

function fire_column(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_7dec59b4 = playFX(localclientnum, level._effect["fire_column"], self.origin + (vectorscale((0, 0, -1), 90)), (0, -1, 0));
  } else {
    stopfx(localclientnum, self.var_7dec59b4);
    self.var_7dec59b4 = undefined;
  }
}

function player_screen_fx(localclientnum, newval) {
  if(newval == 1) {
    if(isDefined(level.var_51541120[localclientnum])) {
      deletefx(localclientnum, level.var_51541120[localclientnum], 1);
    }
    level.var_51541120[localclientnum] = playfxoncamera(localclientnum, level._effect["low_grav_screen_fx"]);
  } else if(isDefined(level.var_51541120[localclientnum])) {
    deletefx(localclientnum, level.var_51541120[localclientnum], 1);
  }
}

function function_df81c23d(localclientnum, newval) {
  if(newval == 1) {
    setpbgactivebank(localclientnum, 2);
    level.localplayers[0] thread postfx::playpostfxbundle("pstfx_115_castle_loop");
  } else {
    setpbgactivebank(localclientnum, 1);
    level.localplayers[0] thread postfx::exitpostfxbundle();
  }
}

function light_challenge_floor(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    var_377bdd93 = struct::get("arena_light_challenge_floor", "targetname");
    level.var_be73cf11 = util::spawn_model(localclientnum, var_377bdd93.model, var_377bdd93.origin, var_377bdd93.angles);
  } else if(isDefined(level.var_be73cf11)) {
    level.var_be73cf11 delete();
  }
}

function arena_tornado(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_247afb5a = playFXOnTag(localclientnum, level._effect["arena_tornado"], self, "tag_origin");
  } else if(isDefined(self.var_247afb5a)) {
    stopfx(localclientnum, self.var_247afb5a);
  }
}

function arena_shadow_pillar(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_e29992ef = playFXOnTag(localclientnum, level._effect["arena_shadow_pillar"], self, "tag_origin");
  } else if(isDefined(self.var_e29992ef)) {
    stopfx(localclientnum, self.var_e29992ef);
  }
}