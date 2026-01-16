/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_training_sim.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_oed;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_quadtank;
#namespace namespace_c550ee23;

function autoexec __init__sytem__() {
  system::register("training_sim", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("actor", "rez_in", 1, 1, "int", & function_86af5f80, 0, 0);
  clientfield::register("actor", "rez_out", 1, 1, "int", & function_11225c9f, 0, 0);
  clientfield::register("vehicle", "rez_in", 1, 1, "int", & function_86af5f80, 0, 0);
  clientfield::register("vehicle", "rez_out", 1, 1, "int", & function_11225c9f, 0, 0);
  clientfield::register("actor", "enable_ethereal_overlay", 1, 1, "int", & function_d3b7cf16, 0, 0);
  clientfield::register("vehicle", "enable_ethereal_overlay", 1, 1, "int", & function_d3b7cf16, 0, 0);
  clientfield::register("scriptmover", "enable_ethereal_overlay", 1, 1, "int", & function_d3b7cf16, 0, 0);
  clientfield::register("toplayer", "postfx_build_world", 1, 1, "counter", & function_14646786, 0, 0);
  clientfield::register("toplayer", "cleanup_sim", 1000, 1, "counter", & function_b699155b, 0, 0);
  duplicate_render::set_dr_filter_framebuffer_duplicate("armor_pl", 0, "armor_on", undefined, 1, "mc/mtl_power_armor", 0);
}

function function_86af5f80(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(issubstr(self.archetype, "human") || issubstr(self.archetype, "robot") || issubstr(self.archetype, "warlord")) {
      playfxontag(localclientnum, "ui/fx_training_rez_in_biped", self, "j_spine4");
      playfxontag(localclientnum, "ui/fx_training_rez_in_biped_leg", self, "j_knee_ri");
      playfxontag(localclientnum, "ui/fx_training_rez_in_biped_leg", self, "j_knee_le");
    } else {
      if(issubstr(self.archetype, "amws") || issubstr(self.archetype, "raps")) {
        playfxontag(localclientnum, "ui/fx_training_rez_in_veh_sm", self, "tag_deathfx");
      } else {
        if(issubstr(self.archetype, "quadtank")) {
          playfxontag(localclientnum, "ui/fx_training_rez_in_veh_quad", self, "tag_turret_animate");
          playfxontag(localclientnum, "ui/fx_training_rez_in_veh_quad_leg", self, "leg_back_right_femur_pitch_fx");
          playfxontag(localclientnum, "ui/fx_training_rez_in_veh_quad_leg", self, "leg_back_left_femur_pitch_fx");
          playfxontag(localclientnum, "ui/fx_training_rez_in_veh_quad_leg", self, "leg_front_left_femur_pitch_fx");
          playfxontag(localclientnum, "ui/fx_training_rez_in_veh_quad_leg", self, "leg_front_right_femur_pitch_fx");
        } else {
          if(issubstr(self.archetype, "hunter")) {
            playfxontag(localclientnum, "ui/fx_training_rez_in_veh_hunter", self, "tag_body");
          } else {
            if(issubstr(self.archetype, "mlrs")) {
              playfxontag(localclientnum, "ui/fx_training_rez_in_veh_mrls", self, "tag_turret_animate");
              playfxontag(localclientnum, "ui/fx_training_rez_in_veh_mrls_leg", self, "leg_back_left_femur_pitch_fx");
              playfxontag(localclientnum, "ui/fx_training_rez_in_veh_mrls_leg", self, "leg_back_right_femur_pitch_fx");
              playfxontag(localclientnum, "ui/fx_training_rez_in_veh_mrls_leg", self, "leg_front_left_femur_pitch_fx");
              playfxontag(localclientnum, "ui/fx_training_rez_in_veh_mrls_leg", self, "leg_front_right_femur_pitch_fx");
            } else {
              if(issubstr(self.archetype, "siege")) {
                playfxontag(localclientnum, "ui/fx_training_rez_in_veh_siege", self, "tag_turret_animate");
                playfxontag(localclientnum, "ui/fx_training_rez_in_veh_siege_leg", self, "tag_leg_left_6_animate");
                playfxontag(localclientnum, "ui/fx_training_rez_in_veh_siege_leg", self, "tag_leg_right_6_animate");
              } else if(issubstr(self.archetype, "wasp")) {
                playfxontag(localclientnum, "ui/fx_training_rez_in_veh_wasp", self, "tag_body");
              }
            }
          }
        }
      }
    }
  }
}

function function_11225c9f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(issubstr(self.archetype, "human") || issubstr(self.archetype, "robot") || issubstr(self.archetype, "warlord")) {
      playfxontag(localclientnum, "ui/fx_training_rez_out_biped", self, "j_spine4");
      playfxontag(localclientnum, "ui/fx_training_rez_out_biped_leg", self, "j_knee_ri");
      playfxontag(localclientnum, "ui/fx_training_rez_out_biped_leg", self, "j_knee_le");
      cleanupspawneddynents();
    } else {
      if(issubstr(self.archetype, "amws") || issubstr(self.archetype, "raps")) {
        playfxontag(localclientnum, "ui/fx_training_rez_out_veh_sm", self, "tag_deathfx");
      } else {
        if(issubstr(self.archetype, "quadtank")) {
          playfxontag(localclientnum, "ui/fx_training_rez_out_veh_quad", self, "tag_turret_animate");
          playfxontag(localclientnum, "ui/fx_training_rez_out_veh_quad_leg", self, "leg_back_right_femur_pitch_fx");
          playfxontag(localclientnum, "ui/fx_training_rez_out_veh_quad_leg", self, "leg_back_left_femur_pitch_fx");
          playfxontag(localclientnum, "ui/fx_training_rez_out_veh_quad_leg", self, "leg_front_left_femur_pitch_fx");
          playfxontag(localclientnum, "ui/fx_training_rez_out_veh_quad_leg", self, "leg_front_right_femur_pitch_fx");
        } else {
          if(issubstr(self.archetype, "hunter")) {
            playfxontag(localclientnum, "ui/fx_training_rez_out_veh_hunter", self, "tag_body");
          } else {
            if(issubstr(self.archetype, "mlrs")) {
              playfxontag(localclientnum, "ui/fx_training_rez_out_veh_mrls", self, "tag_turret_animate");
              playfxontag(localclientnum, "ui/fx_training_rez_out_veh_mrls_leg", self, "leg_back_left_femur_pitch_fx");
              playfxontag(localclientnum, "ui/fx_training_rez_out_veh_mrls_leg", self, "leg_back_right_femur_pitch_fx");
              playfxontag(localclientnum, "ui/fx_training_rez_out_veh_mrls_leg", self, "leg_front_left_femur_pitch_fx");
              playfxontag(localclientnum, "ui/fx_training_rez_out_veh_mrls_leg", self, "leg_front_right_femur_pitch_fx");
            } else {
              if(issubstr(self.archetype, "siege")) {
                playfxontag(localclientnum, "ui/fx_training_rez_out_veh_siege", self, "tag_turret_animate");
                playfxontag(localclientnum, "ui/fx_training_rez_out_veh_siege_leg", self, "tag_leg_left_6_animate");
                playfxontag(localclientnum, "ui/fx_training_rez_out_veh_siege_leg", self, "tag_leg_right_6_animate");
              } else if(issubstr(self.archetype, "wasp")) {
                playfxontag(localclientnum, "ui/fx_training_rez_out_veh_wasp", self, "tag_body");
              }
            }
          }
        }
      }
    }
  }
}

function function_d3b7cf16(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self duplicate_render::set_dr_flag("armor_on", newval);
  self duplicate_render::update_dr_filters(localclientnum);
  if(newval) {
    var_aa5d763a = "scriptVector3";
    var_fc81e73c = 0.4;
    var_754d7044 = 1;
    var_e754df7f = 0.45;
    var_595c4eba = 0;
    var_6c5c3132 = "scriptVector4";
    var_93429fd9 = 0.6;
    self mapshaderconstant(localclientnum, 0, var_aa5d763a, var_fc81e73c, var_754d7044, var_e754df7f, var_595c4eba);
    self mapshaderconstant(localclientnum, 0, var_6c5c3132, var_93429fd9, 0, 0, 0);
    self tmodesetflag(10);
  }
}

function function_14646786(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread postfx::playpostfxbundle("pstfx_world_construction");
  self playsound(0, "evt_glitch_start", self.origin);
}

function function_b699155b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_dynents = getdynentarray();
  foreach(dynent in a_dynents) {
    if(isdefined(dynent) && distance2dsquared(self.origin, dynent.origin) <= (5000 * 5000)) {
      setdynentenabled(dynent, 0);
    }
  }
}