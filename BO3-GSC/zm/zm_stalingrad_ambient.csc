/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_ambient.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace zm_stalingrad_ambient;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_ambient", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "ambient_mortar_strike", 12000, 2, "int", & ambient_mortar_strike, 0, 0);
  clientfield::register("scriptmover", "ambient_artillery_strike", 12000, 2, "int", & ambient_artillery_strike, 0, 0);
  clientfield::register("world", "power_on_level", 12000, 1, "int", & power_on_level, 0, 0);
  level thread function_866a2751();
  level thread function_a8bcf075();
  level thread function_1eb91e4b();
  level thread function_b833e317();
  level thread function_65c51e85();
}

function ambient_mortar_strike(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1: {
      var_df2299f9 = "ambient_mortar_small";
      break;
    }
    case 2: {
      var_df2299f9 = "ambient_mortar_medium";
      break;
    }
    case 3: {
      var_df2299f9 = "ambient_mortar_large";
      break;
    }
    default: {
      return;
    }
  }
  self thread function_a7d3e4ff(localclientnum, var_df2299f9);
}

function ambient_artillery_strike(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1: {
      var_df2299f9 = "ambient_artillery_small";
      break;
    }
    case 2: {
      var_df2299f9 = "ambient_artillery_medium";
      break;
    }
    case 3: {
      var_df2299f9 = "ambient_artillery_large";
      break;
    }
    default: {
      return;
    }
  }
  self thread function_a7d3e4ff(localclientnum, var_df2299f9);
}

function function_a7d3e4ff(localclientnum, var_df2299f9) {
  level endon("demo_jump");
  playsound(localclientnum, "prj_mortar_incoming", self.origin);
  wait(1);
  playsound(localclientnum, "exp_mortar", self.origin);
  playfx(localclientnum, level._effect[var_df2299f9], self.origin);
  playrumbleonposition(localclientnum, "artillery_rumble", self.origin);
}

function power_on_level(n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump) {
  if(n_new) {
    level notify("power_on_level");
  }
}

function function_866a2751() {
  level thread function_916d6917("comm_monitor_lrg_combined");
  level thread function_916d6917("comm_equip_top_01");
  level thread function_916d6917("comm_equip_top_02");
  level thread function_916d6917("comm_equip_top_03");
  level thread function_916d6917("comm_equip_top_04");
  level thread function_916d6917("comm_equip_base_02");
  level waittill("power_on_level");
  function_4820908f("comm_monitor_lrg_combined_off");
  function_4820908f("comm_equip_top_01_off");
  function_4820908f("comm_equip_top_02_off");
  function_4820908f("comm_equip_top_03_off");
  function_4820908f("comm_equip_top_04_off");
  function_4820908f("comm_equip_base_02_off");
}

function function_916d6917(str_targetname) {
  var_1bbd14fd = findstaticmodelindexarray(str_targetname);
  foreach(n_model_index in var_1bbd14fd) {
    hidestaticmodel(n_model_index);
  }
  level waittill("power_on_level");
  foreach(n_model_index in var_1bbd14fd) {
    unhidestaticmodel(n_model_index);
  }
}

function function_4820908f(str_targetname) {
  var_1bbd14fd = findstaticmodelindexarray(str_targetname);
  foreach(n_model_index in var_1bbd14fd) {
    unhidestaticmodel(n_model_index);
  }
  level waittill("power_on_level");
  foreach(n_model_index in var_1bbd14fd) {
    hidestaticmodel(n_model_index);
  }
}

function function_a8bcf075() {
  level waittill("nbs");
  audio::snd_set_snapshot("zmb_stal_boss_fight");
}

function function_1eb91e4b() {
  level waittill("nbstp");
  audio::snd_set_snapshot("default");
}

function function_b833e317() {
  level waittill("dfs");
  audio::snd_set_snapshot("zmb_stal_dragon_fight");
}

function function_b6e2489() {
  level waittill("dfss");
  audio::snd_set_snapshot("default");
}

function function_65c51e85() {
  audio::playloopat("amb_air_raid", (-1819, 2705, 1167));
}