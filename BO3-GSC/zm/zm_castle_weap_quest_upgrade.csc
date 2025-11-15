/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_weap_quest_upgrade.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_filter;
#using scripts\zm\_zm_utility;
#namespace zm_castle_weap_quest_upgrade;

function main() {
  level.var_9128852d = [];
  level.var_f91a2b6a = [];
  for(i = 0; i < 4; i++) {
    level.var_f91a2b6a[i] = [];
  }
  level._effect["zombie_soul_demon"] = "dlc1/castle/fx_demon_zombie_death_energy";
  level._effect["zombie_soul_rune"] = "dlc1/castle/fx_rune_zombie_death_energy";
  level._effect["zombie_soul_storm"] = "dlc1/castle/fx_storm_zombie_death_energy";
  level._effect["zombie_soul_wolf"] = "dlc1/castle/fx_wolf_zombie_death_energy";
  level._effect["fossil_collect_fx"] = "dlc1/castle/fx_demon_gate_pick_up";
  level._effect["fossil_trail_fx"] = "dlc1/castle/fx_demon_gate_skulls_trail";
  level._effect["quest_portal_open"] = "dlc1/castle/fx_demon_gate_portal_open";
  level._effect["quest_portal_loop"] = "dlc1/castle/fx_demon_gate_portal_loop";
  level._effect["quest_portal_close"] = "dlc1/castle/fx_demon_gate_portal_close";
  level._effect["tower_break"] = "dlc1/castle/fx_elec_exp_blue";
  level._effect["battery_uncharged"] = "dlc1/castle/fx_battery_elec_beam_castle";
  level._effect["battery_charged"] = "dlc1/castle/fx_battery_elec_beam_castle_2";
  level._effect["arrow_charge"] = "dlc1/zmb_weapon/fx_bow_storm_arrowhead_ug_zmb";
  level._effect["beacon_fire"] = "dlc1/castle/fx_fire_tornado_lg";
  level._effect["beacon_fire_charged"] = "dlc1/castle/fx_fire_elec_tornado";
  level._effect["lightning_strike"] = "dlc1/castle/fx_lightning_strike_weathervane";
  level._effect["lightning_tornado"] = "dlc1/castle/fx_fire_elec_weathervane";
  level._effect["circle_kill_impact"] = "dlc1/castle/fx_rune_zombie_death_impact";
  level._effect["runic_circle"] = "dlc1/castle/fx_rune_circle_fire";
  level._effect["wolf_howl_bones"] = "dlc1/castle/fx_wolf_bones_reveal";
  level._effect["wolf_left_print"] = "dlc1/castle/fx_wolf_footprint_left_zmb";
  level._effect["wolf_right_print"] = "dlc1/castle/fx_wolf_footprint_right_zmb";
  level._effect["wolf_run_body"] = "dlc1/castle/fx_wolf_ink_run_body";
  level._effect["wolf_run_head"] = "dlc1/castle/fx_wolf_ink_run_head";
  level._effect["wolf_walk_body"] = "dlc1/castle/fx_wolf_ink_walk_body";
  level._effect["wolf_walk_head"] = "dlc1/castle/fx_wolf_ink_walk_head";
  level._effect["wolf_hold_body"] = "dlc1/castle/fx_wolf_ink_hold_body";
  level._effect["wolf_hold_head"] = "dlc1/castle/fx_wolf_ink_hold_head";
  level._effect["wolf_trail"] = "dlc1/castle/fx_wolf_ink_trail_lg";
  level._effect["arrow_charge_wolf"] = "dlc1/castle/fx_wolf_arrow_whole_float_glow";
  clientfield::register("scriptmover", "fossil_reveal", 5000, 2, "int", & function_fc150bb9, 0, 0);
  clientfield::register("scriptmover", "fossil_collect_fx", 5000, 1, "int", & function_9a901aeb, 0, 0);
  clientfield::register("scriptmover", "demonic_circle_reveal", 5000, 1, "int", & function_9de15a4d, 0, 0);
  clientfield::register("scriptmover", "init_demongate_fossil", 5000, 2, "int", & function_b2c9069f, 0, 0);
  clientfield::register("scriptmover", "urn_impact_fx", 5000, 1, "counter", & function_f821e372, 0, 0);
  clientfield::register("scriptmover", "demongate_fossil_frenzy", 5000, 1, "int", & function_543f9ebd, 0, 0);
  clientfield::register("scriptmover", "demongate_fossil_outro", 5000, 1, "int", & function_fec30c70, 0, 0);
  clientfield::register("world", "demongate_client_cleanup", 5000, 1, "int", & function_8739dc84, 0, 0);
  clientfield::register("scriptmover", "demongate_quest_portal", 5000, 1, "int", & function_e08420f7, 0, 0);
  clientfield::register("toplayer", "demon_vo_release", 8000, 1, "counter", & function_414a0874, 0, 0);
  clientfield::register("toplayer", "demon_vo_return", 8000, 1, "counter", & function_8a7c68af, 0, 0);
  clientfield::register("toplayer", "demon_vo_souls", 8000, 1, "counter", & function_71168013, 0, 0);
  clientfield::register("toplayer", "demon_vo_name", 8000, 1, "counter", & function_41a3306c, 0, 0);
  clientfield::register("toplayer", "demon_vo_ask_name", 8000, 1, "counter", & function_e13571b8, 0, 0);
  clientfield::register("toplayer", "demon_vo_name_correct", 8000, 1, "counter", & function_2ccca749, 0, 0);
  clientfield::register("toplayer", "demon_vo_name_incorrect", 8000, 1, "counter", & function_8cd2582e, 0, 0);
  clientfield::register("toplayer", "demon_vo_door", 8000, 1, "counter", & function_42fe618d, 0, 0);
  clientfield::register("toplayer", "demon_vo_horn", 8000, 1, "counter", & function_ad13a872, 0, 0);
  clientfield::register("toplayer", "demon_vo_heart", 8000, 1, "counter", & function_9b445487, 0, 0);
  clientfield::register("toplayer", "demon_vo_griffon", 8000, 1, "counter", & function_e2b77200, 0, 0);
  clientfield::register("toplayer", "demon_vo_crown", 8000, 1, "counter", & function_4ab357d6, 0, 0);
  clientfield::register("toplayer", "demon_vo_stag", 8000, 1, "counter", & function_153cf9fc, 0, 0);
  clientfield::register("scriptmover", "tower_break_fx", 5000, 1, "int", & function_7cc0d99b, 0, 0);
  clientfield::register("scriptmover", "beacon_fx", 5000, 2, "int", & function_475de8c4, 0, 0);
  clientfield::register("scriptmover", "wallrun_fx", 5000, 2, "int", & function_6103d0f7, 0, 0);
  clientfield::register("scriptmover", "battery_fx", 5000, 2, "int", & function_f51349bf, 0, 0);
  clientfield::register("scriptmover", "lightning_fx", 5000, 1, "int", & function_c31afa5, 0, 0);
  clientfield::register("scriptmover", "tornado_fx", 5000, 1, "int", & function_9db8b2b2, 0, 0);
  clientfield::register("toplayer", "arrow_charge_fx", 5000, 1, "int", & function_3f451756, 0, 1);
  clientfield::register("world", "storm_variable_cleanup", 5000, 1, "int", & function_e92d950c, 0, 0);
  clientfield::register("scriptmover", "obelisk_magma_reveal", 5000, 1, "int", & function_64bc7af0, 0, 0);
  clientfield::register("scriptmover", "obelisk_runes_reveal", 5000, 1, "int", & function_febf0bf4, 0, 0);
  clientfield::register("scriptmover", "obelisk_runes_drain", 5000, 1, "int", & function_5063c4f7, 0, 0);
  clientfield::register("scriptmover", "runic_circle_reveal", 5000, 1, "int", & function_f32932c3, 0, 0);
  clientfield::register("scriptmover", "runic_circle_fx", 5000, 1, "int", & function_3b5b1626, 0, 0);
  clientfield::register("scriptmover", "runic_circle_death_fx", 5000, 1, "counter", & function_d6434cf, 0, 0);
  clientfield::register("toplayer", "anchor_point_postfx", 5000, 1, "int", & function_c069c332, 0, 0);
  clientfield::register("world", "orb_sanim_cleanup", 5000, 1, "counter", & function_2514cb86, 0, 0);
  clientfield::register("scriptmover", "painting_symbol_reveal", 5000, 1, "int", & function_46f52afa, 0, 0);
  clientfield::register("scriptmover", "painting_symbol_blink", 5000, 1, "counter", & function_6f66f54d, 0, 0);
  clientfield::register("scriptmover", "wolf_howl_bone_fx", 5000, 1, "int", & function_65d81fc2, 0, 0);
  clientfield::register("actor", "wolf_trail_fx", 5000, 2, "int", & function_aefa4e67, 0, 0);
  clientfield::register("actor", "wolf_footprint_fx", 5000, 1, "int", & function_60ae2cd0, 0, 0);
  clientfield::register("actor", "wolf_ghost_shader", 5000, 1, "int", & function_ccf12771, 0, 0);
  clientfield::register("scriptmover", "arrow_charge_wolf_fx", 5000, 1, "int", & function_e051553d, 0, 0);
  clientfield::register("scriptmover", "zombie_soul_demon_fx", 5000, 1, "int", & function_c75de902, 0, 0);
  clientfield::register("scriptmover", "zombie_soul_rune_fx", 5000, 1, "int", & function_3cb9b375, 0, 0);
  clientfield::register("scriptmover", "zombie_soul_storm_fx", 5000, 1, "int", & function_fa1ef690, 0, 0);
  clientfield::register("scriptmover", "zombie_soul_wolf_fx", 5000, 1, "int", & function_d0720a0d, 0, 0);
  clientfield::register("world", "quest_state_demon", 5000, 3, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "quest_state_rune", 5000, 3, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "quest_state_storm", 5000, 3, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "quest_state_wolf", 5000, 3, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "quest_owner_demon", 5000, 3, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "quest_owner_rune", 5000, 3, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "quest_owner_storm", 5000, 3, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("world", "quest_owner_wolf", 5000, 3, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_weap_quest_storm", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_weap_quest_rune", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_weap_quest_wolf", 1, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_weap_quest_demon", 1, 1, "int", undefined, 0, 0);
}

function function_9de15a4d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval == 1) {
    n_start_time = gettime();
    n_end_time = n_start_time + (2 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 1;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  } else {
    n_start_time = gettime();
    n_end_time = n_start_time + (2 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 0;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  }
}

function function_fc150bb9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  b_show = 0;
  var_ad3c7eb7 = 1;
  if(newval == 1) {
    b_show = 1;
  } else if(newval == 2) {
    b_show = 1;
    var_ad3c7eb7 = 0;
  }
  if(self.model == "tag_origin" && isDefined(self.var_89028fd1)) {
    self.var_89028fd1 function_1c4fc326(localclientnum, b_show, var_ad3c7eb7);
  } else {
    self function_1c4fc326(localclientnum, b_show, var_ad3c7eb7);
  }
}

function function_1c4fc326(localclientnum, b_show, var_ad3c7eb7 = 1) {
  if(b_show) {
    n_start_time = gettime();
    n_end_time = n_start_time + (1 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 1;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
      wait(0.01);
    }
    if(var_ad3c7eb7) {
      if(isDefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
      }
      self.n_fx_id = playFXOnTag(localclientnum, level._effect["fossil_trail_fx"], self, "tag_fx");
      playSound(0, "zmb_demon_skulls_ignite", self.origin);
    }
  } else {
    n_start_time = gettime();
    n_end_time = n_start_time + (1 * 1000);
    if(isDefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 0;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
      wait(0.01);
    }
  }
}

function function_9a901aeb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["fossil_collect_fx"], self.origin);
  }
}

function function_b2c9069f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self function_60670dd4(localclientnum, "o_zm_dlc1_chomper_demongate_swarm_trophy_room_solo_idle");
    self playSound(0, "zmb_demon_skulls_appear", self.origin);
  } else {
    if(newval == 2) {
      self function_60670dd4(localclientnum, "o_zm_dlc1_chomper_demongate_swarm_trophy_room_solo_idle_b");
      self playSound(0, "zmb_demon_skulls_appear", self.origin);
    } else {
      if(newval == 3) {
        if(isDefined(self.var_89028fd1)) {
          self.var_89028fd1 setModel("c_zom_chomper");
        }
      } else {
        self scene::stop(1);
        self notify("hash_24d9d4f5");
      }
    }
  }
}

function function_60670dd4(localclientnum, str_scene) {
  self endon("entityshutdown");
  level.var_f91a2b6a[localclientnum][level.var_f91a2b6a[localclientnum].size] = self;
  self.var_89028fd1 = util::spawn_model(localclientnum, "c_zom_chomper_demongate", self.origin, self.angles);
  self thread scene::play(str_scene, self.var_89028fd1);
  if(isdemoplaying()) {
    self thread function_24d9d4f5(localclientnum);
  }
  self.str_scene = str_scene;
}

function function_24d9d4f5(localclientnum, str_fx_name) {
  self notify("hash_24d9d4f5");
  self endon("hash_24d9d4f5");
  level endon("hash_24d9d4f5");
  level waittill("demo_jump");
  self scene::stop(1);
}

function function_f821e372(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["fossil_collect_fx"], self.origin);
  }
}

function function_543f9ebd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_f91a2b6a) || !isDefined(level.var_f91a2b6a[localclientnum])) {
    return;
  }
  if(newval == 1) {
    var_f4c7c18 = [];
    for(i = 0; i < level.var_f91a2b6a[localclientnum].size; i++) {
      if(isDefined(level.var_f91a2b6a[localclientnum][i]) && isDefined(level.var_f91a2b6a[localclientnum][i].var_89028fd1)) {
        if(!isDefined(var_f4c7c18)) {
          var_f4c7c18 = [];
        } else if(!isarray(var_f4c7c18)) {
          var_f4c7c18 = array(var_f4c7c18);
        }
        var_f4c7c18[var_f4c7c18.size] = level.var_f91a2b6a[localclientnum][i].var_89028fd1;
      }
    }
    if(var_f4c7c18.size > 0) {
      self thread scene::play("o_zm_dlc1_chomper_demongate_swarm_trophy_room_active", var_f4c7c18);
    }
  } else {
    for(i = 0; i < level.var_f91a2b6a[localclientnum].size; i++) {
      if(isDefined(level.var_f91a2b6a[localclientnum][i]) && isDefined(level.var_f91a2b6a[localclientnum][i].var_89028fd1)) {
        level.var_f91a2b6a[localclientnum][i] thread scene::play(level.var_f91a2b6a[localclientnum][i].str_scene, level.var_f91a2b6a[localclientnum][i].var_89028fd1);
        wait(randomfloatrange(1, 3));
      }
    }
    self scene::stop("o_zm_dlc1_chomper_demongate_swarm_trophy_room_active");
  }
}

function function_fec30c70(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_f91a2b6a) || !isDefined(level.var_f91a2b6a[localclientnum])) {
    return;
  }
  if(newval == 1) {
    level notify("hash_24d9d4f5");
    var_f4c7c18 = [];
    for(i = 0; i < level.var_f91a2b6a[localclientnum].size; i++) {
      if(isDefined(level.var_f91a2b6a[localclientnum][i]) && isDefined(level.var_f91a2b6a[localclientnum][i].var_89028fd1)) {
        if(!isDefined(var_f4c7c18)) {
          var_f4c7c18 = [];
        } else if(!isarray(var_f4c7c18)) {
          var_f4c7c18 = array(var_f4c7c18);
        }
        var_f4c7c18[var_f4c7c18.size] = level.var_f91a2b6a[localclientnum][i].var_89028fd1;
      }
    }
    if(var_f4c7c18.size > 0) {
      self thread scene::play("o_zm_dlc1_chomper_demongate_swarm_trophy_room_outtro", var_f4c7c18);
    }
  }
}

function function_8739dc84(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    level thread struct::delete_script_bundle("scene", "o_zm_dlc1_chomper_demongate_swarm_trophy_room_solo_idle");
    level thread struct::delete_script_bundle("scene", "o_zm_dlc1_chomper_demongate_swarm_trophy_room_solo_idle_b");
    level thread struct::delete_script_bundle("scene", "o_zm_dlc1_chomper_demongate_swarm_trophy_room_active");
    level thread struct::delete_script_bundle("scene", "o_zm_dlc1_chomper_demongate_swarm_trophy_room_outtro");
    if(!isDefined(level.var_f91a2b6a) || !isDefined(level.var_f91a2b6a[localclientnum])) {
      return;
    }
    for(i = 0; i < level.var_f91a2b6a[localclientnum].size; i++) {
      if(isDefined(level.var_f91a2b6a[localclientnum][i])) {
        if(isDefined(level.var_f91a2b6a[localclientnum][i].var_89028fd1)) {
          level.var_f91a2b6a[localclientnum][i].var_89028fd1 delete();
        }
        level.var_f91a2b6a[localclientnum][i] delete();
      }
    }
    level.var_f91a2b6a[localclientnum] = undefined;
  } else {
    level.var_f91a2b6a = undefined;
  }
}

function function_e08420f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["quest_portal_open"], self.origin, anglesToForward(self.angles));
    wait(0.45);
    self.var_fd0edd83 = playFX(localclientnum, level._effect["quest_portal_loop"], self.origin, anglesToForward(self.angles));
  } else {
    deletefx(localclientnum, self.var_fd0edd83, 0);
    playFX(localclientnum, level._effect["quest_portal_close"], self.origin, anglesToForward(self.angles));
  }
}

function function_414a0874(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 5000, & "ZM_CASTLE_DEMON_VO_RELEASE");
  }
}

function function_8a7c68af(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 6000, & "ZM_CASTLE_DEMON_VO_RETURN");
  }
}

function function_71168013(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 6000, & "ZM_CASTLE_DEMON_VO_SOULS");
  }
}

function function_41a3306c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 6000, & "ZM_CASTLE_DEMON_VO_NAME");
  }
}

function function_e13571b8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 5000, & "ZM_CASTLE_DEMON_VO_ASK_NAME");
  }
}

function function_2ccca749(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 5000, & "ZM_CASTLE_DEMON_VO_NAME_CORRECT");
  }
}

function function_8cd2582e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 5000, & "ZM_CASTLE_DEMON_VO_NAME_INCORRECT");
  }
}

function function_42fe618d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 4000, & "ZM_CASTLE_DEMON_VO_DOOR");
  }
}

function function_ad13a872(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 4000, & "ZM_CASTLE_DEMON_VO_HORN");
  }
}

function function_9b445487(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 4000, & "ZM_CASTLE_DEMON_VO_HEART");
  }
}

function function_e2b77200(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 4000, & "ZM_CASTLE_DEMON_VO_GRIFFON");
  }
}

function function_4ab357d6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 4000, & "ZM_CASTLE_DEMON_VO_CROWN");
  }
}

function function_153cf9fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    subtitleprint(localclientnum, 4000, & "ZM_CASTLE_DEMON_VO_STAG");
  }
}

function function_7cc0d99b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["tower_break"], self.origin, anglesToForward(self.angles));
  }
}

function function_475de8c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
    self.n_fx_id = playFX(localclientnum, level._effect["beacon_fire"], self.origin);
  } else {
    if(newval == 2) {
      if(isDefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
      }
      self.n_fx_id = playFX(localclientnum, level._effect["beacon_fire_charged"], self.origin);
    } else if(isDefined(self.n_fx_id)) {
      stopfx(localclientnum, self.n_fx_id);
    }
  }
}

function function_6103d0f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self notify("hash_a1e4f5f1");
  self endon("hash_a1e4f5f1");
  if(!isDefined(self.n_shader_value)) {
    self.n_shader_value = 0;
  }
  if(newval == 1) {
    n_start_time = gettime();
    var_b1382f05 = n_start_time + (randomfloatrange(0.2, 1.2) * 1000);
    var_c8a6e70a = self.n_shader_value;
    var_2be3abbd = 0.35;
    while(true) {
      n_time = gettime();
      if(n_time >= var_b1382f05) {
        self.n_shader_value = mapfloat(n_start_time, var_b1382f05, var_c8a6e70a, var_2be3abbd, var_b1382f05);
        n_start_time = gettime();
        var_b1382f05 = n_start_time + (randomfloatrange(0.2, 1.2) * 1000);
        var_c8a6e70a = self.n_shader_value;
        var_2be3abbd = (var_2be3abbd == 0.35 ? 0 : 0.35);
      } else {
        self.n_shader_value = mapfloat(n_start_time, var_b1382f05, var_c8a6e70a, var_2be3abbd, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, self.n_shader_value, 0);
      wait(0.01);
    }
  } else {
    if(newval == 2) {
      n_start_time = gettime();
      n_end_time = n_start_time + (0.2 * 1000);
      var_c8a6e70a = self.n_shader_value;
      b_is_updating = 1;
      while(b_is_updating) {
        n_time = gettime();
        if(n_time >= n_end_time) {
          self.n_shader_value = 1;
          b_is_updating = 0;
        } else {
          self.n_shader_value = mapfloat(n_start_time, n_end_time, var_c8a6e70a, 1, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, self.n_shader_value, 0);
        wait(0.01);
      }
    } else {
      n_start_time = gettime();
      n_end_time = n_start_time + (0.2 * 1000);
      var_c8a6e70a = self.n_shader_value;
      b_is_updating = 1;
      while(b_is_updating) {
        n_time = gettime();
        if(n_time >= n_end_time) {
          self.n_shader_value = 0;
          b_is_updating = 0;
        } else {
          self.n_shader_value = mapfloat(n_start_time, n_end_time, var_c8a6e70a, 0, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, self.n_shader_value, 0);
        wait(0.01);
      }
    }
  }
}

function function_f51349bf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
    self.n_fx_id = playFX(localclientnum, level._effect["battery_uncharged"], self.origin, anglesToForward(self.angles), (0, 0, 1));
  } else {
    if(newval == 2) {
      if(isDefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
      }
      self.n_fx_id = playFX(localclientnum, level._effect["battery_charged"], self.origin, anglesToForward(self.angles), (0, 0, 1));
    } else if(isDefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
  }
}

function function_3f451756(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_9128852d)) {
    return;
  }
  if(newval == 1) {
    if(isDefined(level.var_9128852d[localclientnum])) {
      deletefx(localclientnum, level.var_9128852d[localclientnum], 1);
    }
    level.var_9128852d[localclientnum] = playviewmodelfx(localclientnum, level._effect["arrow_charge"], "tag_flash");
  } else if(isDefined(level.var_9128852d[localclientnum])) {
    deletefx(localclientnum, level.var_9128852d[localclientnum], 1);
  }
}

function function_e92d950c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.var_9128852d)) {
    foreach(n_fx_id in level.var_9128852d) {
      if(isDefined(n_fx_id)) {
        n_fx_id = undefined;
      }
    }
    level.var_e71f8892 = undefined;
  }
}

function function_c31afa5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
    self.n_fx_id = playFX(localclientnum, level._effect["lightning_strike"], self.origin);
  } else if(isDefined(self.n_fx_id)) {
    stopfx(localclientnum, self.n_fx_id);
  }
}

function function_9db8b2b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.var_cff5d8ed)) {
      deletefx(localclientnum, self.var_cff5d8ed, 1);
    }
    self.var_cff5d8ed = playFX(localclientnum, level._effect["lightning_tornado"], self.origin);
  } else if(isDefined(self.var_cff5d8ed)) {
    stopfx(localclientnum, self.var_cff5d8ed);
  }
}

function function_64bc7af0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  var_82acb0d9 = 8.5;
  if(newval == 1) {
    self mapshaderconstant(localclientnum, 0, "scriptVector0", 1, 0, 0);
  } else {
    n_start_time = gettime();
    n_end_time = n_start_time + (1 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 0;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
      wait(0.01);
    }
    n_start_time = gettime();
    n_end_time = n_start_time + (var_82acb0d9 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 1;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
      wait(0.01);
    }
  }
}

function function_febf0bf4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  var_82acb0d9 = 8.5;
  if(newval == 1) {
    self mapshaderconstant(localclientnum, 0, "scriptVector0", 1, 0, 0);
  } else {
    n_start_time = gettime();
    n_end_time = n_start_time + (var_82acb0d9 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 0;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
      wait(0.01);
    }
  }
}

function function_5063c4f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval == 1) {
    self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, 0, 0);
  } else {
    n_start_time = gettime();
    n_end_time = n_start_time + (30 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 1;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
      wait(0.01);
    }
  }
}

function function_f32932c3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval == 1) {
    n_start_time = gettime();
    n_end_time = n_start_time + (0.5 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 1;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  } else {
    n_start_time = gettime();
    n_end_time = n_start_time + (0.5 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 0;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  }
}

function function_3b5b1626(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
    self.n_fx_id = playFX(localclientnum, level._effect["runic_circle"], self.origin, anglestoup(self.angles), anglesToForward(self.angles + vectorscale((0, 1, 0), 90)));
  } else if(isDefined(self.n_fx_id)) {
    deletefx(localclientnum, self.n_fx_id, 1);
  }
}

function function_d6434cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["circle_kill_impact"], self.origin, vectorscale((0, 0, 1), 90));
  }
}

function function_c069c332(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle("pstfx_arrow_rune");
  } else {
    self thread postfx::stoppostfxbundle();
  }
}

function function_2514cb86(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    var_c6a8f11b = getent(localclientnum, "quest_rune_orb", "targetname");
    if(isDefined(var_c6a8f11b)) {
      var_c6a8f11b delete();
    }
    wait(5);
    level thread struct::delete_script_bundle("scene", "p7_fxanim_zm_castle_quest_rune_orb_scale_down_bundle");
  }
}

function function_46f52afa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval == 1) {
    n_start_time = gettime();
    n_end_time = n_start_time + (0.5 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 1;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  } else {
    n_start_time = gettime();
    n_end_time = n_start_time + (0.5 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = 0;
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  }
}

function function_6f66f54d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  n_start_time = gettime();
  n_end_time = n_start_time + (0.5 * 1000);
  b_is_updating = 1;
  while(b_is_updating) {
    n_time = gettime();
    if(n_time >= n_end_time) {
      n_shader_value = 1;
      b_is_updating = 0;
    } else {
      n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
    wait(0.01);
  }
  n_start_time = gettime();
  n_end_time = n_start_time + (0.5 * 1000);
  b_is_updating = 1;
  while(b_is_updating) {
    n_time = gettime();
    if(n_time >= n_end_time) {
      n_shader_value = 0;
      b_is_updating = 0;
    } else {
      n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
    wait(0.01);
  }
}

function function_65d81fc2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
    self.n_fx_id = playFX(localclientnum, level._effect["wolf_howl_bones"], self.origin + vectorscale((0, 0, 1), 4), (1, 0, 0), (0, 0, 1));
  } else if(isDefined(self.n_fx_id)) {
    stopfx(localclientnum, self.n_fx_id);
  }
}

function function_aefa4e67(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_d0e1c4f7)) {
    stopfx(localclientnum, self.var_d0e1c4f7);
  }
  if(isDefined(self.var_c35be71d)) {
    stopfx(localclientnum, self.var_c35be71d);
  }
  if(isDefined(self.var_96ef984f)) {
    stopfx(localclientnum, self.var_96ef984f);
  }
  if(newval == 0) {
    return;
  }
  if(newval == 1) {
    var_a975b59c = "wolf_hold_head";
    var_2072b44e = "wolf_hold_body";
  } else {
    if(newval == 2) {
      var_a975b59c = "wolf_walk_head";
      var_2072b44e = "wolf_walk_body";
      self.var_96ef984f = playFXOnTag(localclientnum, level._effect["wolf_trail"], self, "j_mainroot");
    } else if(newval == 3) {
      var_a975b59c = "wolf_run_head";
      var_2072b44e = "wolf_run_body";
      self.var_96ef984f = playFXOnTag(localclientnum, level._effect["wolf_trail"], self, "j_mainroot");
    }
  }
  self.var_d0e1c4f7 = playFXOnTag(localclientnum, level._effect[var_a975b59c], self, "j_head");
  self.var_c35be71d = playFXOnTag(localclientnum, level._effect[var_2072b44e], self, "spine3_jnt");
}

function function_60ae2cd0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread function_a783453f(localclientnum, self);
  } else {
    self notify("hash_5ad4a160");
  }
}

function function_a783453f(localclientnum, var_3a9e6062) {
  var_3a9e6062 endon("death");
  var_3a9e6062 endon("entityshutdown");
  var_3a9e6062 endon("hash_5ad4a160");
  b_left_side = 1;
  var_cc9030a = var_3a9e6062.origin;
  while(isDefined(var_3a9e6062)) {
    wait(0.15);
    if(var_3a9e6062.origin != var_cc9030a) {
      var_cc9030a = var_3a9e6062.origin;
      if(isDefined(b_left_side) && b_left_side) {
        str_tag = "l_frontlegend_jnt";
        var_375e50e1 = "wolf_left_print";
        b_left_side = undefined;
      } else {
        str_tag = "r_frontlegend_jnt";
        var_375e50e1 = "wolf_right_print";
        b_left_side = 1;
      }
      v_pos = var_3a9e6062 gettagorigin(str_tag) + vectorscale((0, 0, 1), 4);
      var_c6f6381a = bulletTrace(v_pos, v_pos - vectorscale((0, 0, 1), 12), 0, undefined);
      v_final_pos = var_c6f6381a["position"] + (0, 0, 1);
      playFX(localclientnum, level._effect[var_375e50e1], v_final_pos, anglesToForward(var_3a9e6062.angles), (0, 0, 1));
    }
  }
}

function function_ccf12771(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval == 1) {
    n_start_time = gettime();
    n_end_time = n_start_time + (2.5 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        var_6d9840be = 1;
        var_11bb1597 = 0.7;
        b_is_updating = 0;
      } else {
        var_6d9840be = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
        var_11bb1597 = mapfloat(n_start_time, n_end_time, 0, 0.7, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", var_6d9840be, var_11bb1597, 0);
      wait(0.01);
    }
  } else {
    n_start_time = gettime();
    n_end_time = n_start_time + (2.5 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        var_6d9840be = 0;
        var_11bb1597 = 0;
        b_is_updating = 0;
      } else {
        var_6d9840be = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
        var_11bb1597 = mapfloat(n_start_time, n_end_time, 0.7, 0, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", var_6d9840be, var_11bb1597, 0);
      wait(0.01);
    }
  }
}

function function_e051553d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.n_fx_id = playFXOnTag(localclientnum, level._effect["arrow_charge_wolf"], self, "tag_fx_base_arrow_jnt");
  } else {
    deletefx(localclientnum, self.n_fx_id);
  }
}

function function_c75de902(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_1ee903c(localclientnum, "zombie_soul_demon", newval);
}

function function_3cb9b375(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_1ee903c(localclientnum, "zombie_soul_rune", newval);
}

function function_fa1ef690(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_1ee903c(localclientnum, "zombie_soul_storm", newval);
}

function function_d0720a0d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_1ee903c(localclientnum, "zombie_soul_wolf", newval);
}

function function_1ee903c(localclientnum, str_fx_name, newval) {
  if(newval == 1) {
    if(isDefined(self.var_1a7640e2)) {
      deletefx(localclientnum, self.var_1a7640e2, 1);
    }
    self.var_1a7640e2 = playFXOnTag(localclientnum, level._effect[str_fx_name], self, "tag_origin");
  } else if(isDefined(self.var_1a7640e2)) {
    deletefx(localclientnum, self.var_1a7640e2, 1);
  }
}