/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_special_rounds.csc
***********************************************/

#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\audio_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_white_special_rounds;

init() {
  level._effect[#"fx8_toxic_gas_lg"] = "maps/zm_white/fx8_toxic_gas_lg";
  level._effect[#"fx8_toxic_gas_venting_lg"] = "maps/zm_white/fx8_toxic_gas_venting_lg";
  level._effect[#"fx8_special_round_green_gas_md"] = "maps/zm_towers/fx8_special_round_green_gas_md";
  level._effect[#"hash_670acb2528e7f014"] = #"hash_67f59250cb33cc07";
  function_aa1e486e();
}

register_clientfields() {
  clientfield::register("scriptmover", "white_event_gas_lg_clientfield", 1, 1, "int", &function_e54e60de, 0, 0);
  clientfield::register("scriptmover", "white_event_gas_MD_clientfield", 1, 1, "int", &function_32acf82a, 0, 0);
  clientfield::register("scriptmover", "white_event_gas_lg_vent_clientfield", 1, 1, "int", &function_a9b5240b, 0, 0);
  clientfield::register("world", "portal_map_gas_indicators_init", 1, 1, "int", &portal_map_gas_indicators_init, 0, 0);
  clientfield::register("world", "portal_map_gas_indicator_green_house", 1, 1, "int", &portal_map_gas_indicator_green_house, 0, 0);
  clientfield::register("world", "portal_map_gas_indicator_hammond_house", 1, 1, "int", &portal_map_gas_indicator_hammond_house, 0, 0);
  clientfield::register("world", "portal_map_gas_indicator_hoggatt_house", 1, 1, "int", &portal_map_gas_indicator_hoggatt_house, 0, 0);
  clientfield::register("world", "portal_map_gas_indicator_obrien_house", 1, 1, "int", &portal_map_gas_indicator_obrien_house, 0, 0);
  clientfield::register("world", "portal_map_gas_indicator_reinsel_house", 1, 1, "int", &portal_map_gas_indicator_reinsel_house, 0, 0);
  clientfield::register("world", "portal_map_gas_indicator_yellow_house", 1, 1, "int", &portal_map_gas_indicator_yellow_house, 0, 0);
  clientfield::register("world", "portal_map_gas_indicator_generators", 1, 1, "int", &portal_map_gas_indicator_generators, 0, 0);
  clientfield::register("world", "generator_sound_sweetner", 1, 1, "int", &play_generator_sound_sweetner, 0, 0);
  clientfield::register("world", "" + #"hash_1c11f70bb8445095", 1, 3, "int", &function_88991669, 0, 0);
  clientfield::register("toplayer", "vent_interact_feedback", 20000, 1, "counter", &vent_interact_feedback, 0, 0);
}

function_e54e60de(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"fx8_toxic_gas_lg"], self, "tag_origin");
}

function_a9b5240b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"fx8_toxic_gas_venting_lg"], self, "tag_origin");
}

function_32acf82a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"fx8_special_round_green_gas_md"], self, "tag_origin");
}

vent_interact_feedback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrumbleonentity(localclientnum, "damage_light");
  }
}

function_aa1e486e() {
  level.a_str_tag_names[0] = "tag_green_house";
  level.a_str_tag_names[1] = "tag_hammond_house";
  level.a_str_tag_names[2] = "tag_hoggatt_house";
  level.a_str_tag_names[3] = "tag_obrien_house";
  level.a_str_tag_names[4] = "tag_reinsel_house";
  level.a_str_tag_names[5] = "tag_yellow_house";
  level.a_str_tag_names[6] = "tag_generators";
}

portal_map_gas_indicators_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    level.var_8f14a19 = getEntArray(localclientnum, "portal_map", "targetname");

    foreach(var_35f97c42 in level.var_8f14a19) {
      var_35f97c42 util::waittill_dobj(localclientnum);

      foreach(str_tag_name in level.a_str_tag_names) {
        var_35f97c42 hidepart(localclientnum, str_tag_name + "_clear");
        var_35f97c42 hidepart(localclientnum, str_tag_name + "_clogged");
      }
    }

    return;
  }

  if(!isDefined(level.var_8f14a19)) {
    level.var_8f14a19 = getEntArray(localclientnum, "portal_map", "targetname");
  }

  foreach(var_35f97c42 in level.var_8f14a19) {
    for(i = 0; i < 6; i++) {
      var_35f97c42 util::waittill_dobj(localclientnum);
      var_35f97c42 showpart(localclientnum, level.a_str_tag_names[i] + "_clear");
    }
  }
}

portal_map_gas_indicator_green_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 0) {
    function_f05553f1(localclientnum, "tag_green_house");
    return;
  }

  if(newval == 1) {
    function_a7084ac5(localclientnum, "tag_green_house");
  }
}

portal_map_gas_indicator_hammond_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 0) {
    function_f05553f1(localclientnum, "tag_hammond_house");
    return;
  }

  if(newval == 1) {
    function_a7084ac5(localclientnum, "tag_hammond_house");
  }
}

portal_map_gas_indicator_hoggatt_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 0) {
    function_f05553f1(localclientnum, "tag_hoggatt_house");
    return;
  }

  if(newval == 1) {
    function_a7084ac5(localclientnum, "tag_hoggatt_house");
  }
}

portal_map_gas_indicator_obrien_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 0) {
    function_f05553f1(localclientnum, "tag_obrien_house");
    return;
  }

  if(newval == 1) {
    function_a7084ac5(localclientnum, "tag_obrien_house");
  }
}

portal_map_gas_indicator_reinsel_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 0) {
    function_f05553f1(localclientnum, "tag_reinsel_house");
    return;
  }

  if(newval == 1) {
    function_a7084ac5(localclientnum, "tag_reinsel_house");
  }
}

portal_map_gas_indicator_yellow_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 0) {
    function_f05553f1(localclientnum, "tag_yellow_house");
    return;
  }

  if(newval == 1) {
    function_a7084ac5(localclientnum, "tag_yellow_house");
  }
}

portal_map_gas_indicator_generators(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 0) {
    function_f05553f1(localclientnum, "tag_generators");
    return;
  }

  if(newval == 1) {
    function_a7084ac5(localclientnum, "tag_generators");
  }
}

function_a7084ac5(localclientnum, tag) {
  if(!isDefined(level.var_8f14a19)) {
    level.var_8f14a19 = getEntArray(localclientnum, "portal_map", "targetname");
  }

  foreach(var_35f97c42 in level.var_8f14a19) {
    var_35f97c42 util::waittill_dobj(localclientnum);
    var_35f97c42 showpart(localclientnum, tag + "_clogged");
    var_35f97c42 hidepart(localclientnum, tag + "_clear");
  }
}

function_f05553f1(localclientnum, tag) {
  if(!isDefined(level.var_8f14a19)) {
    level.var_8f14a19 = getEntArray(localclientnum, "portal_map", "targetname");
  }

  foreach(var_35f97c42 in level.var_8f14a19) {
    var_35f97c42 util::waittill_dobj(localclientnum);
    var_35f97c42 showpart(localclientnum, tag + "_clear");
    var_35f97c42 hidepart(localclientnum, tag + "_clogged");
  }
}

function_88991669(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(level.var_41858f75)) {
    level.var_41858f75 = getent(localclientnum, "pap_control_panel", "targetname");
    level.var_41858f75 util::waittill_dobj(localclientnum);

    if(isDefined(level.var_41858f75)) {
      for(i = 0; i < 4; i++) {
        level.var_41858f75 hidepart(localclientnum, "tag_lt_good_" + string(i));
        util::playFXOnTag(localclientnum, "maps/zm_white/fx8_lgt_pap_console_green", level.var_41858f75, "tag_lt_good_" + string(i));
        util::playFXOnTag(localclientnum, "maps/zm_white/fx8_lgt_pap_console_red", level.var_41858f75, "tag_lt_bad_" + string(i));
      }
    }

    return;
  }

  for(i = 0; i < 4; i++) {
    level.var_41858f75 hidepart(localclientnum, "tag_lt_good_" + string(i));
    level.var_41858f75 hidepart(localclientnum, "tag_lt_bad_" + string(i));
  }

  for(i = 0; i < newval; i++) {
    level.var_41858f75 showpart(localclientnum, "tag_lt_bad_" + string(i));
  }

  for(i = newval; i < 4; i++) {
    level.var_41858f75 showpart(localclientnum, "tag_lt_good_" + string(i));
  }
}

play_generator_sound_sweetner(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  audio::playloopat(#"hash_3f579b3632b29a2", (-158, -352, -379));
  audio::playloopat(#"hash_3f579b3632b29a2", (86, -345, -367));
}