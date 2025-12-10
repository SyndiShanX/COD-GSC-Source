/**********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_cairo_infection_sgen_test_chamber.csc
**********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#namespace cp_mi_cairo_infection_sgen_test_chamber;

function main() {
  init_clientfields();
}

function init_clientfields() {
  clientfield::register("world", "sgen_test_chamber_pod_graphics", 1, 1, "int", &function_8d81452c, 0, 0);
  clientfield::register("world", "sgen_test_chamber_time_lapse", 1, 1, "int", &callback_time_lapse, 0, 0);
  clientfield::register("scriptmover", "sgen_test_guys_decay", 1, 1, "int", &callback_guys_decay, 0, 0);
  clientfield::register("world", "fxanim_hive_cluster_break", 1, 1, "int", &fxanim_hive_cluster_break, 0, 0);
  clientfield::register("world", "fxanim_time_lapse_objects", 1, 1, "int", &fxanim_time_lapse_objects, 0, 0);
}

function fxanim_hive_cluster_break(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread scene::init("p7_fxanim_cp_infection_sgen_hive_drop_bundle");
  } else {
    scene::add_scene_func("p7_fxanim_cp_infection_sgen_hive_drop_bundle", &callback_hive_remove, "play");
    level thread scene::play("p7_fxanim_cp_infection_sgen_hive_drop_bundle");
  }
}

function callback_hive_remove(a_ent) {
  wait(8);
  a_ent["sgen_hive_drop"] delete();
}

function function_8d81452c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  testing_pod_ents = getEntArray(localclientnum, "dni_testing_pod", "targetname");
  if(oldval != newval) {
    if(newval == 1) {
      foreach(testing_pod_ent in testing_pod_ents) {
        testing_pod_ent attach("p7_sgen_dni_testing_pod_graphics_01_screen", "tag_origin");
        testing_pod_ent attach("p7_sgen_dni_testing_pod_graphics_01_door", "tag_door_anim");
      }
    } else {
      foreach(testing_pod_ent in testing_pod_ents) {
        testing_pod_ent detach("p7_sgen_dni_testing_pod_graphics_01_screen", "tag_origin");
        testing_pod_ent detach("p7_sgen_dni_testing_pod_graphics_01_door", "tag_door_anim");
      }
    }
  }
}

function callback_time_lapse(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  testing_pod_ents = getEntArray(localclientnum, "dni_testing_pod", "targetname");
  foreach(testing_pod_ent in testing_pod_ents) {
    testing_pod_ent thread time_lapse();
  }
}

function time_lapse() {
  n_wait_per_cycle = 0.06666667;
  n_growth_increment = 1 / 180;
  n_growth = 0;
  i = 0;
  while(i <= 12) {
    self mapshaderconstant(0, 0, "scriptVector0", n_growth, 0, 0, 0);
    n_growth = n_growth + n_growth_increment;
    wait(n_wait_per_cycle);
    i = i + n_wait_per_cycle;
  }
}

function callback_guys_decay(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread decaymanmaterial(localclientnum);
}

function decaymanmaterial(localclientnum) {
  self endon("disconnect");
  self endon("death");
  self notify("decaymanmaterial");
  self endon("decaymanmaterial");
  var_9ef7f234 = 1 / 6.5;
  i = 0;
  while(i <= 6.5) {
    if(!isDefined(self)) {
      return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector0", i * var_9ef7f234, 0, 0, 0);
    wait(0.01);
    i = i + 0.01;
  }
}

function fxanim_time_lapse_objects(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread scene::play("p7_fxanim_cp_infection_sgen_time_lapse_objects_bundle");
  }
}