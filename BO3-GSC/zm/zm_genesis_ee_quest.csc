/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_ee_quest.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_filter;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_genesis_teleporter;
#using scripts\zm\zm_genesis_util;
#using_animtree("generic");
#namespace zm_genesis_ee_quest;

function autoexec __init__sytem__() {
  system::register("zm_genesis_ee_quest", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("world", "ee_quest_state", 15000, getminbitcountfornum(13), "int", &ee_quest_state, 0, 0);
  clientfield::register("scriptmover", "ghost_entity", 15000, 1, "int", &function_2b5ef9a6, 0, 0);
  clientfield::register("scriptmover", "electric_charge", 15000, 1, "int", &function_ede1c539, 0, 0);
  clientfield::register("scriptmover", "grand_tour_found_toy_fx", 15000, 1, "int", &function_52d5d371, 0, 0);
  clientfield::register("scriptmover", "sophia_transition_fx", 15000, 1, "int", &sophia_transition_fx, 0, 0);
  clientfield::register("allplayers", "sophia_follow", 15000, 3, "int", &sophia_follow, 0, 0);
  clientfield::register("scriptmover", "sophia_eye_on", 15000, 1, "int", &sophia_eye_on, 0, 0);
  clientfield::register("allplayers", "sophia_delete_local", 15000, 1, "int", &sophia_delete_local, 0, 0);
  clientfield::register("world", "GenesisEndGameEEScreen", 15000, 1, "int", &genesisendgameee, 0, 0);
  duplicate_render::set_dr_filter_framebuffer("zod_ghost", 90, "zod_ghost", undefined, 0, "mc/hud_zod_ghost", 0);
  level._effect["electric_charge"] = "electric/fx_elec_arc_med_loop_hacktower";
}

function ee_quest_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level notify("ee_quest_state");
  level endon("ee_quest_state");
  switch (newval) {
    case 7: {
      break;
    }
    case 8: {
      break;
    }
    case 9: {
      break;
    }
    case 10: {
      break;
    }
    case 12: {
      break;
    }
  }
}

function function_2b5ef9a6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self duplicate_render::set_dr_flag("zod_ghost", newval);
  self duplicate_render::update_dr_filters(localclientnum);
}

function function_ede1c539(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_ebad8041)) {
    deletefx(localclientnum, self.var_ebad8041, 0);
    self.var_ebad8041 = undefined;
  }
  if(newval == 1) {
    self.var_ebad8041 = playFXOnTag(localclientnum, level._effect["electric_charge"], self, "tag_origin");
  }
}

function function_52d5d371(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["ee_toy_found"], self.origin);
    self.var_22c9fb1a = playFXOnTag(localclientnum, level._effect["shadow_rq_chomper_light"], self, "tag_origin");
  } else {
    deletefx(localclientnum, self.var_22c9fb1a, 0);
    self.var_22c9fb1a = undefined;
  }
}

function sophia_transition_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.n_fx = playFXOnTag(localclientnum, level._effect["sophia_transition"], self, "tag_origin");
  } else if(isDefined(self.n_fx)) {
    deletefx(localclientnum, self.n_fx, 0);
    self.n_fx = undefined;
  }
}

function sophia_follow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon("hash_249c0595");
  var_1c7b6837 = getent(localclientnum, "sophia_eye", "targetname");
  if(!isDefined(var_1c7b6837)) {
    var_af8a18df = struct::get("ee_beam_sophia", "targetname");
    var_1c7b6837 = util::spawn_model(localclientnum, "p7_zm_gen_dark_arena_sphere", var_af8a18df.origin, var_af8a18df.angles);
    var_1c7b6837.targetname = "sophia_eye";
    var_1c7b6837 mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0);
  }
  level notify("hash_deeb3634");
  wait(0.5);
  if(!isDefined(var_1c7b6837)) {
    return;
  }
  if(newval == 0) {
    var_1c7b6837 rotateto((0, 0, 0), 0.5);
  } else {
    level.var_9a736d20 = 1;
    var_1c7b6837 thread function_36666e11(self);
  }
}

function sophia_eye_on(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0);
}

function function_36666e11(e_player) {
  level endon("demo_jump");
  level endon("hash_deeb3634");
  e_player endon("death");
  self endon("entityshutdown");
  while(isDefined(e_player)) {
    var_c746e6bf = e_player gettagorigin("j_head");
    var_933e0d32 = vectortoangles(var_c746e6bf - self.origin);
    var_933e0d32 = (var_933e0d32[0], var_933e0d32[1], var_933e0d32[2]);
    self rotateto(var_933e0d32, 0.1);
    wait(0.1);
  }
}

function sophia_delete_local(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_1c7b6837 = getent(localclientnum, "sophia_eye", "targetname");
  if(isDefined(var_1c7b6837)) {
    var_1c7b6837 rotateto((0, 0, 0), 0.2);
    var_1c7b6837 delete();
  }
}

function genesisendgameee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "GenesisEndGameEE"), 1);
}