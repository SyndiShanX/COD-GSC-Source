/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_ee.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\zm_tomb_ee_lights;
#namespace zm_tomb_ee;

function init() {
  clientfield::register("world", "wagon_1_fire", 21000, 1, "int", &function_6db69694, 0, 0);
  clientfield::register("world", "wagon_2_fire", 21000, 1, "int", &function_6db69694, 0, 0);
  clientfield::register("world", "wagon_3_fire", 21000, 1, "int", &function_6db69694, 0, 0);
  clientfield::register("world", "ee_sam_portal", 21000, 2, "int", &function_aff1c5b2, 0, 0);
  clientfield::register("actor", "ee_zombie_fist_fx", 21000, 1, "int", &function_64b44f6b, 0, 0);
  clientfield::register("actor", "ee_zombie_soul_portal", 21000, 1, "int", &function_a8fdf631, 0, 0);
  clientfield::register("actor", "ee_zombie_tablet_fx", 21000, 1, "int", &function_74610c8a, 0, 0);
  clientfield::register("vehicle", "ee_plane_fx", 21000, 1, "int", &function_19452a40, 0, 0);
  clientfield::register("toplayer", "ee_beacon_reward", 21000, 1, "int", &function_b628a101, 0, 0);
  clientfield::register("world", "TombEndGameBlackScreen", 21000, 1, "int", &function_13792d2, 0, 0);
  zm_tomb_ee_lights::main();
}

function function_6db69694(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (fieldname) {
    case "wagon_1_fire": {
      str_exploder_name = "fxexp_211";
      break;
    }
    case "wagon_2_fire": {
      str_exploder_name = "fxexp_212";
      break;
    }
    case "wagon_3_fire": {
      str_exploder_name = "fxexp_213";
      break;
    }
    default: {
      str_exploder_name = "";
    }
  }
  if(newval == 1) {
    exploder::stop_exploder(str_exploder_name, localclientnum);
    level thread function_1ebf0afe(1, fieldname);
  } else {
    exploder::exploder(str_exploder_name, localclientnum);
    level thread function_1ebf0afe(0, fieldname);
  }
}

function function_6e543e40(localclientnum, fieldname) {
  level notify("stop_" + fieldname);
  self endon("stop_" + fieldname);
  s_pos = struct::get(fieldname, "targetname");
  while(true) {
    playFX(localclientnum, level._effect["wagon_fire"], s_pos.origin, anglesToForward(s_pos.angles), anglestoup(s_pos.angles));
    wait(0.5);
  }
}

function function_1ebf0afe(ison, fieldname) {
  struct = struct::get(fieldname, "targetname");
  origin = struct.origin;
  if(ison) {
    audio::playloopat("amb_fire_xlg", origin);
  } else {
    audio::stoploopat("amb_fire_xlg", origin);
  }
}

function function_64b44f6b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(!isDefined(self.has_soul)) {
      self.has_soul = 1;
      self.var_8020f50b = playFXOnTag(localclientnum, level._effect["fist_glow"], self, "J_Wrist_RI");
      self.var_9c121695 = playFXOnTag(localclientnum, level._effect["fist_glow"], self, "J_Wrist_LE");
    }
    if(!isDefined(self.var_3a8912f4)) {
      self.var_3a8912f4 = spawn(0, self.origin, "script_origin");
      self.var_3a8912f4 linkto(self);
      self.var_3a8912f4 playLoopSound("zmb_squest_punchtime_fist_loop", 1);
      self thread snddeletesndent(self.var_3a8912f4);
    }
  } else {
    if(isDefined(self.has_soul)) {
      self.has_soul = undefined;
      stopfx(localclientnum, self.var_8020f50b);
      stopfx(localclientnum, self.var_9c121695);
    }
    self notify("snddeleteent");
  }
}

function snddeletesndent(ent) {
  self util::waittill_any("death", "entityshutdown", "sndDeleteEnt");
  ent delete();
}

function function_a8fdf631(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  v_dest = getent(localclientnum, "ee_sam_portal", "targetname").origin;
  e_fx = spawn(localclientnum, self gettagorigin("J_SpineUpper"), "script_model");
  e_fx setModel("tag_origin");
  playSound(localclientnum, "zmb_squest_charge_soul_leave", self.origin);
  e_fx playLoopSound("zmb_squest_charge_soul_lp");
  playFXOnTag(localclientnum, level._effect["staff_soul"], e_fx, "tag_origin");
  e_fx moveto(v_dest + vectorscale((0, 0, 1), 5), 1);
  e_fx waittill("movedone");
  playSound(localclientnum, "zmb_squest_charge_soul_impact", v_dest);
  playFXOnTag(localclientnum, level._effect["staff_charge"], e_fx, "tag_origin");
  wait(0.3);
  e_fx delete();
}

function function_aff1c5b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  e_fx = getent(localclientnum, "ee_sam_portal", "targetname");
  if(isDefined(e_fx.fx_id)) {
    e_fx stoploopsound(5);
    stopfx(localclientnum, e_fx.fx_id);
  }
  if(newval == 1) {
    e_fx.fx_id = playFXOnTag(localclientnum, level._effect["foot_box_glow"], e_fx, "tag_origin");
    e_fx playLoopSound("zmb_squest_sam_portal_closed_loop", 1);
  } else if(newval == 2) {
    if(isDefined(e_fx.fx_id)) {
      stopfx(localclientnum, e_fx.fx_id);
    }
    playSound(0, "zmb_squest_sam_portal_open", e_fx.origin);
    e_fx playLoopSound("zmb_squest_sam_portal_open_loop", 1);
  }
}

function function_19452a40(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  while(true) {
    e_player = getlocalplayer(localclientnum);
    if(isDefined(e_player) && (isDefined(e_player.var_c5eb485f) && e_player.var_c5eb485f) && !isDefined(self.plane_fx)) {
      self.plane_fx = playFXOnTag(localclientnum, level._effect["biplane_glow"], self, "tag_origin");
    }
    if(isDefined(e_player) && (!(isDefined(e_player.var_c5eb485f) && e_player.var_c5eb485f)) && isDefined(self.plane_fx)) {
      stopfx(localclientnum, self.plane_fx);
      self.plane_fx = undefined;
    }
    wait(0.05);
  }
}

function function_74610c8a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  a_structs = struct::get_array("tablet_charge_pos", "targetname");
  s_box = arraygetclosest(self.origin, a_structs);
  e_fx = spawn(localclientnum, self gettagorigin("J_SpineUpper"), "script_model");
  e_fx setModel("tag_origin");
  e_fx playSound(localclientnum, "zmb_squest_charge_soul_leave");
  e_fx playLoopSound("zmb_squest_charge_soul_lp");
  playFXOnTag(localclientnum, level._effect["staff_soul"], e_fx, "tag_origin");
  e_fx moveto(s_box.origin, 1);
  e_fx waittill("movedone");
  playSound(localclientnum, "zmb_squest_charge_soul_impact", e_fx.origin);
  playFXOnTag(localclientnum, level._effect["staff_charge"], e_fx, "tag_origin");
  wait(0.3);
  e_fx delete();
}

function function_b628a101(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(!isDefined(self.var_e6c8ca8e)) {
      self.var_e6c8ca8e = 1;
      self thread function_4e9276ed(localclientnum);
      self.m_reward = util::spawn_model(localclientnum, level.w_beacon.worldmodel, (-141, 4464, -322) + (8, 35, 20), self.angles);
      self.m_reward thread function_17bc361f(localclientnum);
    }
  } else if(isDefined(self.var_e6c8ca8e)) {
    self.var_e6c8ca8e = 0;
    self notify("hash_7066982d");
    self.m_reward delete();
  }
}

function function_17bc361f(localclientnum) {
  self endon("entityshutdown");
  self endon("death");
  self util::waittill_dobj(localclientnum);
  playFXOnTag(localclientnum, level._effect["staff_soul"], self, "tag_origin");
  self playSound(localclientnum, "zmb_spawn_powerup");
  self playLoopSound("zmb_spawn_powerup_loop", 0.5);
  self movey(-50, 2, 0, 1);
  self waittill("movedone");
  while(true) {
    self rotateyaw(360, 4);
    self waittill("rotatedone");
  }
}

function function_4e9276ed(localclientnum) {
  self endon("disconnect");
  self endon("hash_7066982d");
  while(true) {
    playFX(localclientnum, level._effect["bottle_glow"], (-141, 4464, -322) + (60, 10, 25));
    wait(0.1);
  }
}

function function_13792d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  setuimodelvalue(getuimodel(getuimodelforcontroller(localclientnum), "TombEndGameBlackScreen"), newval);
}