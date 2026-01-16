/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_elemental_bow_demongate.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weap_elemental_bow;
#using_animtree("generic");
#namespace _zm_weap_elemental_bow_demongate;

function autoexec __init__sytem__() {
  system::register("_zm_weap_elemental_bow_demongate", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "elemental_bow_demongate" + "_ambient_bow_fx", 5000, 1, "int", & function_da7a9948, 0, 0);
  clientfield::register("missile", "elemental_bow_demongate" + "_arrow_impact_fx", 5000, 1, "int", & function_f514bd4b, 0, 0);
  clientfield::register("missile", "elemental_bow_demongate4" + "_arrow_impact_fx", 5000, 1, "int", & function_3e42c666, 0, 0);
  clientfield::register("scriptmover", "demongate_portal_fx", 5000, 1, "int", & demongate_portal_fx, 0, 0);
  clientfield::register("toplayer", "demongate_portal_rumble", 1, 1, "int", & demongate_portal_rumble, 0, 0);
  clientfield::register("scriptmover", "demongate_wander_locomotion_anim", 5000, 1, "int", & demongate_wander_locomotion_anim, 0, 0);
  clientfield::register("scriptmover", "demongate_attack_locomotion_anim", 5000, 1, "int", & demongate_attack_locomotion_anim, 0, 0);
  clientfield::register("scriptmover", "demongate_chomper_fx", 5000, 1, "int", & demongate_chomper_fx, 0, 0);
  clientfield::register("scriptmover", "demongate_chomper_bite_fx", 5000, 1, "counter", & demongate_chomper_bite_fx, 0, 0);
  level._effect["demongate_ambient_bow"] = "dlc1/zmb_weapon/fx_bow_demongate_ambient_1p_zmb";
  level._effect["demongate_arrow_impact"] = "dlc1/zmb_weapon/fx_bow_demongate_impact_zmb";
  level._effect["demongate_arrow_charged_impact"] = "dlc1/zmb_weapon/fx_bow_demongate_impact_ug_zmb";
  level._effect["demongate_chomper_trail"] = "dlc1/zmb_weapon/fx_bow_demonhead_trail_zmb";
  level._effect["demongate_chomper_bite"] = "dlc1/zmb_weapon/fx_bow_demonhead_bite_zmb";
  level._effect["demongate_chomper_end"] = "dlc1/zmb_weapon/fx_bow_demonhead_despawn_zmb";
  level._effect["demongate_portal_open"] = "dlc1/zmb_weapon/fx_bow_demongate_portal_open_zmb";
  level._effect["demongate_portal_loop"] = "dlc1/zmb_weapon/fx_bow_demongate_portal_loop_zmb";
  level._effect["demongate_portal_close"] = "dlc1/zmb_weapon/fx_bow_demongate_portal_close_zmb";
}

function function_da7a9948(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self zm_weap_elemental_bow::function_3158b481(localclientnum, newval, "demongate_ambient_bow");
}

function function_f514bd4b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playfx(localclientnum, level._effect["demongate_arrow_impact"], self.origin);
  }
}

function function_3e42c666(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playfx(localclientnum, level._effect["demongate_arrow_charged_impact"], self.origin);
  }
}

function demongate_portal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playfx(localclientnum, level._effect["demongate_portal_open"], self.origin, anglestoforward(self.angles));
    self.var_4b6fd850 = self playloopsound("zmb_demongate_portal_lp", 1);
    wait(0.45);
    self.var_fd0edd83 = playfx(localclientnum, level._effect["demongate_portal_loop"], self.origin, anglestoforward(self.angles));
  } else {
    deletefx(localclientnum, self.var_fd0edd83, 0);
    playfx(localclientnum, level._effect["demongate_portal_close"], self.origin, anglestoforward(self.angles));
    if(isdefined(self.var_4b6fd850)) {
      self stoploopsound(self.var_4b6fd850, 1);
    }
  }
}

function demongate_portal_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread function_35e3ef91(localclientnum);
  } else {
    self notify("hash_3e0789ec");
  }
}

function function_35e3ef91(localclientnum) {
  level endon("demo_jump");
  self endon("hash_3e0789ec");
  self endon("death");
  while (isdefined(self)) {
    self playrumbleonentity(localclientnum, "zod_idgun_vortex_interior");
    wait(0.075);
  }
}

function demongate_wander_locomotion_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self hasanimtree()) {
    self useanimtree($generic);
  }
  if(newval) {
    self setanim("ai_zm_dlc1_chomper_a_demongate_swarm_locomotion_f_notrans");
  }
}

function demongate_attack_locomotion_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self hasanimtree()) {
    self useanimtree($generic);
  }
  if(newval) {
    self setanim("ai_zm_dlc1_chomper_a_demongate_swarm_locomotion_f_notrans");
  }
}

function demongate_chomper_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval) {
    if(isdefined(self.var_a581816a)) {
      deletefx(localclientnum, self.var_a581816a, 1);
    }
    self.var_a581816a = playfxontag(localclientnum, level._effect["demongate_chomper_trail"], self, "tag_fx");
  } else {
    if(isdefined(self.var_a581816a)) {
      deletefx(localclientnum, self.var_a581816a, 0);
      self.var_a581816a = undefined;
    }
    self playsound(0, "zmb_demongate_chomper_disappear");
    playfxontag(localclientnum, level._effect["demongate_chomper_end"], self, "tag_fx");
    wait(0.4);
    self hide();
  }
}

function demongate_chomper_bite_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(isdefined(self.var_64b4f506)) {
    stopfx(localclientnum, self.var_64b4f506);
  }
  self playsound(0, "zmb_demongate_chomper_bite");
  self.var_64b4f506 = playfx(localclientnum, level._effect["demongate_chomper_bite"], self.origin);
  wait(0.1);
  if(isdefined(self.var_64b4f506)) {
    stopfx(localclientnum, self.var_64b4f506);
  }
}