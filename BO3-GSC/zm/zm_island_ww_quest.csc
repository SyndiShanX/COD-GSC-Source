/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_ww_quest.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using_animtree("generic");
#namespace zm_island_ww_quest;

function function_30d4f164() {
  clientfield::register("scriptmover", "play_underwater_plant_fx", 9000, 1, "int", & play_underwater_plant_fx, 0, 0);
  clientfield::register("actor", "play_carrier_fx", 9000, 1, "int", & function_f0e89ab2, 0, 0);
  clientfield::register("scriptmover", "play_vial_fx", 9000, 1, "int", & function_e9572f40, 0, 0);
  clientfield::register("world", "add_ww_to_box", 9000, 4, "int", & add_ww_to_box, 0, 0);
  clientfield::register("scriptmover", "spider_bait", 9000, 1, "int", & function_6eb27bd9, 0, 0);
}

function add_ww_to_box(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    var_989d36e = getweapon("hero_mirg2000");
    addzombieboxweapon(var_989d36e, var_989d36e.worldmodel, var_989d36e.isdualwield);
  }
}

function play_underwater_plant_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playfxontag(localclientnum, level._effect["ww_part_underwater_plant"], self, "tag_origin");
}

function function_f0e89ab2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playfxontag(localclientnum, level._effect["ww_part_scientist_vial"], self, "j_spineupper");
}

function function_e9572f40(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playfxontag(localclientnum, level._effect["ww_part_scientist_vial"], self, "tag_origin");
}

function function_6eb27bd9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.n_fx_id = playfx(localclientnum, level._effect["spider_pheromone"], self.origin + (vectorscale((0, 0, -1), 100)));
  } else if(isdefined(self.n_fx_id)) {
    stopfx(localclientnum, self.n_fx_id);
  }
}