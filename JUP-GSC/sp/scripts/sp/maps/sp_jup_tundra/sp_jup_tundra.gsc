/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_tundra\sp_jup_tundra.gsc
**************************************************************/

#using script_1031976741eb6674;
#using script_159c1d9ebef7e54c;
#using script_2c5456a9a7133a7c;
#using script_412aa76130fc9a7b;
#using script_4fd531b693fc2ff3;
#using script_51d5c955e19f49e8;
#using script_60add030ce1a42b6;
#using script_686d874f22ef4fba;
#using script_7295d46a1f0881ad;
#using script_82cc6442916277b;
#using scripts\common\utility;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\load;
#using scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_fx;
#using scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting;
#namespace sp_jup_tundra;

function main() {
  namespace_bcd0468caad598e5::main();
  namespace_ad892f5ce18e7e65::initanims();
  sp_jup_tundra_fx::main();
  sp_jup_tundra_lighting::main();
  namespace_93635c21ec57253a::main();
  transient_init("sp_jup_tundra_lake_tr");
  transient_init("sp_jup_tundra_lake_campfire_tr");
  transient_init("sp_jup_tundra_forest_walk_tr");
  transient_init("sp_jup_tundra_forest_design_tr");
  transient_init("sp_jup_tundra_forest_sniper_tr");
  transient_init("sp_jup_tundra_forest_field_tr");
  transient_init("sp_jup_tundra_forest_uphill_tr");
  transient_init("sp_jup_tundra_lumber_mill_proxy_tr");
  transient_init("sp_jup_tundra_lumbermill_buildings_tr");
  transient_init("sp_jup_tundra_lumbermill_view_tr");
  transient_init("sp_jup_tundra_lumbermill_tr");
  transient_init("sp_jup_tundra_cliff_tr");
  transient_init("sp_jup_tundra_shipyard_tr");
  precache();
  setup_starts();
  thread function_f16eda64d3d69428();
  level.var_bae0e0b3c3ce64a3 = 1;
  level.foliagecontent = scripts\engine\trace::function_416688b9ffe933c4();
  load::main();
  setup_player();
  level thread setup_objectives();
  level thread namespace_8339f6377b6ba60e::function_24a9b0a62967cc84();
  level thread namespace_8339f6377b6ba60e::function_316231399e57bdf9();
  level thread namespace_8339f6377b6ba60e::function_a2ebc5141fd47f76();
  level thread namespace_8339f6377b6ba60e::function_2ec574a17890b82d();
  initdvars();
  function_1a640fdad233420a();
  level.var_4c9c84f746d64381 = 1;
  flag_init("introscreen_start_wait");
  level.trigger_hint_func["focus_hint"] = &function_f64093180ed2b66a;
  add_hint_string("takedown_hint", &"TAKEDOWN/TAKEDOWN", &function_3757341c1835c0ef, 2);
  wait 1;
  setsaveddvar(@ "hash_1d03444cd52cc348", 0);
  setsaveddvar(@ "hash_8adcf05d62fe94fd", 0);
  setsaveddvar(@ "hash_710ab425dbbc775", 0);
  level.loot.maxweapons = 25;

  level thread function_24dffa9e3996a493("<dev string:x1c>");
}

function function_f16eda64d3d69428() {
  var_88d5aa082c0129af = ["sp_jup_tundra_lake_tr", "sp_jup_tundra_lake_campfire_tr", "sp_jup_tundra_forest_walk_tr", "sp_jup_tundra_forest_sniper_tr", "sp_jup_tundra_forest_design_tr", "sp_jup_tundra_forest_field_tr", "sp_jup_tundra_forest_uphill_tr", "sp_jup_tundra_lumbermill_buildings_tr", "sp_jup_tundra_lumbermill_view_tr", "sp_jup_tundra_lumbermill_tr", "sp_jup_tundra_cliff_tr", "sp_jup_tundra_shipyard_tr"];

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1") {
    waitframe();
    transient_load_array(var_88d5aa082c0129af);
    transient_unload("sp_jup_tundra_lumber_mill_proxy_tr");
  }
}

function precache() {
  var_2f7136cf6c5b1b14 = ["frag", "smoke", "throwingknife", "flash", "semtex", "smoke_tundra"];
  offhandprecache(var_2f7136cf6c5b1b14);
  precachestring(&"SHARED_HINTSTRINGS/AMMO_PICKUP");
  precachestring(&"JUP_WEAPON/M67FRAGGRENADE");
  add_hint_string("tundra_switch_weapon", &"SP_JUP_TUNDRA/SWAP_WEAPON", &function_fa4e3e5505164e66);
  add_hint_string("tundra_thermal_scope", &"SP_JUP_TUNDRA/THERMALSCOPE_USE", &function_73ca7ba04ae7e51e);
  add_hint_string("finale_exit_ads", &"SP_JUP_TUNDRA/FINALE_EXIT_ADS_HINT", &function_ac398fb0efc1b781);
}

function function_a94633115d03acac() {}

function setup_player() {
  function_7d89f98164b6df3d("vm_c_jup_sp_hero_price_tundra_diver");
  level.player function_c4ec7d985422ce24("vm_c_jup_sp_hero_price_tundra_diver");
  level.player function_6078d3c20d55c620(1);
  level.player setmovespeedscale(1);
}

function function_7d89f98164b6df3d(viewmodel) {
  if(isDefined(viewmodel)) {
    level.player setviewmodel(viewmodel);
  }
}

function setup_starts() {
  set_default_start("lake_intro");
  add_start("lake_intro", &function_7e3a2aa7302c9df0, &lake_intro, ["sp_jup_tundra_lake_tr"], &function_aa66ffde4d265926);
  add_start("lake_detonate", &function_521c270fd86a5290, &lake_detonate, ["sp_jup_tundra_lake_tr"], &function_dffe8a3baa2618c6);
  add_start("lake_main", &function_37cd27042f339151, &lake_main, ["sp_jup_tundra_lake_tr"], &function_bfea90384462b323);
  add_start("lake_rescue", &function_11e6f441784d86d, &lake_rescue, ["sp_jup_tundra_lake_tr"], &function_746fe8fd9724cc8f);
  add_start("forest_campfire", &function_4a61ed6faa426e3, &function_11ba903aeae3f374, ["sp_jup_tundra_lake_campfire_tr", "sp_jup_tundra_forest_walk_tr"], &function_783509975b12f6d5);
  add_start("forest_walk", &function_5d7b40326f372043, &function_57c07a6813bb4b54, ["sp_jup_tundra_lake_campfire_tr", "sp_jup_tundra_forest_walk_tr", "sp_jup_tundra_forest_design_tr"], &function_d79da6fbc9c93e35);
  add_start("forest_patrol", &forest_patrol_start, &forest_patrol_main, ["sp_jup_tundra_lake_campfire_tr", "sp_jup_tundra_forest_walk_tr", "sp_jup_tundra_forest_sniper_tr", "sp_jup_tundra_forest_design_tr"], &forest_patrol_catchup);
  add_start("forest_sniper", &function_49108ebe658c26d5, &function_ea79d7ed7869b0e, ["sp_jup_tundra_forest_walk_tr", "sp_jup_tundra_forest_sniper_tr", "sp_jup_tundra_forest_design_tr"], &function_39983a9cf152f047);
  add_start("forest_field", &function_1a19c58671092238, &function_bd7e85ffb13a8811, ["sp_jup_tundra_forest_sniper_tr", "sp_jup_tundra_forest_field_tr", "sp_jup_tundra_forest_uphill_tr", "sp_jup_tundra_forest_design_tr"], &function_7aebd8c76bfd6ebe);
  add_start("forest_vista", &function_3609e7a245dfc171, &function_627041f6f1c79eb2, ["sp_jup_tundra_lumber_mill_proxy_tr", "sp_jup_tundra_forest_field_tr", "sp_jup_tundra_forest_uphill_tr", "sp_jup_tundra_lumbermill_view_tr", "sp_jup_tundra_forest_design_tr"], &function_b19cf0d076d19243);
  add_start("lumber_mill", &function_979ccc727f468b3e, &function_1f0f73377673d767, ["sp_jup_tundra_lumbermill_buildings_tr", "sp_jup_tundra_forest_uphill_tr", "sp_jup_tundra_lumbermill_view_tr", "sp_jup_tundra_lumbermill_tr"], &function_e9156a415d1dd024);
  add_start("cliff", &cliff_start, &cliff_main, ["sp_jup_tundra_lumbermill_buildings_tr", "sp_jup_tundra_lumbermill_tr", "sp_jup_tundra_cliff_tr", "sp_jup_tundra_shipyard_tr", "sp_jup_tundra_lumbermill_view_tr"], &function_45ec82c0014d1b4c);
  add_start("shipyard", &shipyard_start, &function_c1351e9f0bc9e601, ["sp_jup_tundra_cliff_tr", "sp_jup_tundra_shipyard_tr"], &function_b97fcea70c9dd1ae);
  add_start("finale_holdout", &function_e60c3ad55fae83fd, &function_8a49fc8e888ef2b6, ["sp_jup_tundra_shipyard_tr"], &function_83cf07e21d98eebf);
  add_start("finale_exfil", &function_15ff29f3be957a62, &function_2ce2e5069f5e9b73, ["sp_jup_tundra_shipyard_tr"], &function_c9033c8590b6d7e8);
}

function initdvars() {
  setDvar(@ "hash_2a4f08bc79265550", 1);
  setDvar(@ "hash_7b7242d185f5621c", 0);
}

function function_b6badfad142e5fef() {}

function setup_objectives() {
  level.obj_ent = spawn_tag_origin();

  switch (level.start_point) {
    case #"hash_2c0432745bb65b7f":
    case #"hash_6eed531c57154087":
      objectives::objective_add("lake_extract", "current", undefined, &"SP_JUP_TUNDRA/OBJ_LAKE_DETONATE_DESC", undefined, "icon_waypoint_objective_general");
      level utility::flag_wait("lake_detonate_complete");
    case #"hash_19d4a1786ac7b982":
      s_obj = getStruct("start_scene_interact_break_window", "targetname");
      v_obj = s_obj.origin + (0, 0, 80);

      if(!objectives::objective_exists("lake_extract")) {
        objectives::objective_add("lake_extract", "current", undefined, &"SP_JUP_TUNDRA/OBJ_LAKE_SEARCH_DESC", undefined, "icon_waypoint_objective_general");
      } else {
        objectives::objective_set_description("lake_extract", &"SP_JUP_TUNDRA/OBJ_LAKE_SEARCH_DESC");
      }

      level utility::flag_wait("flg_prisoner_location_revealed");
      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("lake_extract", "uw_ambush_makarov_vehicle", v_obj);
      level utility::flag_wait("flag_rescue_prisoner_obj_show");
    case #"hash_a2d7f52c18cab89e":
      s_obj = getStruct("start_scene_interact_break_window", "targetname");
      v_obj = s_obj.origin + (0, 0, 80);

      if(!objectives::objective_exists("lake_extract")) {
        objectives::objective_add("lake_extract", "current", undefined, &"SP_JUP_TUNDRA/OBJ_LAKE_RESCUE_DESC", undefined, "icon_waypoint_objective_general");
        namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("lake_extract", "uw_ambush_makarov_vehicle", v_obj);
      } else {
        objectives::objective_set_description("lake_extract", &"SP_JUP_TUNDRA/OBJ_LAKE_RESCUE_DESC");
      }

      level utility::flag_wait("lake_rescue_complete");
      objectives::objective_remove_location("lake_extract", "uw_ambush_makarov_vehicle");
      objectives::objective_remove("lake_extract");
      level utility::flag_wait("tundra_forest_reveal_complete");
    case #"hash_4f606d24766fac00":
    case #"hash_795476e926438123":
    case #"hash_7d57250fef928ff8":
      objectives::objective_add("forest_escort", "current", undefined, &"SP_JUP_TUNDRA/OBJ_FOREST_ESCORT_DESC", undefined, "icon_waypoint_objective_general");
      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("forest_escort", "forest_transport", "s_obj_forest_escort");
    case #"hash_3a6d1fcb1896b67e":
      if(!objectives::objective_exists("forest_escort")) {
        objectives::objective_add("forest_escort", "current", undefined, &"SP_JUP_TUNDRA/OBJ_FOREST_ESCORT_DESC", undefined, "icon_waypoint_objective_general");
        namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("forest_escort", "forest_transport", "s_obj_forest_escort");
      }

      level utility::flag_wait_any("flag_forest_obj_sniper", "flag_forest_sniper_04");
      objectives::objective_set_description("forest_escort", &"SP_JUP_TUNDRA/OBJ_FOREST_SNIPER_DESC");
      objectives::objective_remove_location("forest_escort", "forest_transport");
      level utility::flag_wait_any("flag_forest_obj_sniper_complete", "flag_forest_obj_sniper_trigger_end");
      objectives::objective_set_description("forest_escort", &"SP_JUP_TUNDRA/OBJ_FOREST_TRANSPORT_DESC");
      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("forest_escort", "forest_transport", "s_obj_forest_escort");
    case #"hash_53bdf6c30f98009f":
      if(!objectives::objective_exists("forest_escort")) {
        objectives::objective_add("forest_escort", "current", undefined, &"SP_JUP_TUNDRA/OBJ_FOREST_TRANSPORT_DESC", undefined, "icon_waypoint_objective_general");
        namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("forest_escort", "forest_transport", "s_obj_forest_escort");
      }

      level utility::flag_wait_any("flag_forest_obj_secondary_route", "flag_forest_field_04");
      objectives::objective_remove_location("forest_escort", "forest_transport");
      objectives::objective_set_description("forest_escort", &"SP_JUP_TUNDRA/OBJ_FOREST_SECONDARY_DESC");
      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("forest_escort", "forest_secondary", "s_obj_forest_secondary");
      level utility::flag_wait_any("flag_forest_obj_field_snipers", "flag_forest_field_08");
      objectives::objective_remove_location("forest_escort", "forest_secondary");
      objectives::objective_set_description("forest_escort", &"SP_JUP_TUNDRA/OBJ_FOREST_FIELD_DESC");
      msg = level utility::flag_wait_any_return("flag_forest_obj_field_snipers_complete", "flag_forest_obj_field_snipers_trigger_end");

      if(msg == "flag_forest_obj_field_snipers_trigger_end") {
        if(isDefined(level.var_2f9f697bc727f253) && level.var_2f9f697bc727f253.size > 0) {
          var_2f9f697bc727f253 = level.var_2f9f697bc727f253;

          while(var_2f9f697bc727f253.size > 0) {
            var_2f9f697bc727f253 = utility::array_removedead_or_dying(var_2f9f697bc727f253);
            wait 0.5;
          }
        }
      }

      objectives::objective_set_description("forest_escort", &"SP_JUP_TUNDRA/OBJ_FOREST_SECONDARY_DESC");
      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("forest_escort", "forest_secondary", "s_obj_forest_secondary");
    case #"hash_387c935fcbb0771a":
      if(!objectives::objective_exists("forest_escort")) {
        objectives::objective_add("forest_escort", "current", undefined, &"SP_JUP_TUNDRA/OBJ_FOREST_SECONDARY_DESC", undefined, "icon_waypoint_objective_general");
        namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("forest_escort", "forest_secondary", "s_obj_forest_secondary");
      }

      level utility::flag_wait("flag_forest_vista_complete");
      objectives::objective_remove_location("forest_escort", "forest_secondary");
      objectives::objective_remove("forest_escort");
    case #"hash_aedf6071a2b3bc31":
      while(!isDefined(level.farah)) {
        waitframe();
      }

      level utility::flag_wait_all("lumber_mill_farah_spawned", "flag_lumbermill_player_gave_orders");
      objectives::objective_add("lumbermill_fight", "current", undefined, &"SP_JUP_TUNDRA/OBJ_LUMBERMILL_SAWMILL_DESC", undefined, "icon_waypoint_objective_general");
      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("lumbermill_fight", "lumbermill_primary", "s_lumber_mill_clear_enemies_objective");
      level utility::flag_wait_any("flag_lumbermill_all_enemies_cleared", "flag_lumbermill_exit_farah_rappel_ready");
      objectives::objective_set_description("lumbermill_fight", &"SP_JUP_TUNDRA/OBJ_LUMBERMILL_REGROUP_DESC");
      objectives::objective_remove_location("lumbermill_fight", "lumbermill_primary");
      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("lumbermill_fight", "lumbermill_secondary", "s_lumber_mill_farah_meetup_objective");
      level utility::flag_wait_any("flag_lumbermill_obj_clear_complete", "flag_lumbermill_obj_trigger_end");
      objectives::objective_remove_location("lumbermill_fight", "lumbermill_secondary");
      objectives::objective_remove("lumbermill_fight");
    case #"hash_8ff02eb8ab5d8721":
      objectives::objective_add("push_to_exfil", "current", undefined, &"SP_JUP_TUNDRA/OBJ_CLIFF_DESCENT_DESC", undefined, "icon_waypoint_objective_general");
      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("push_to_exfil", "cliff_descend_1", "s_obj_cliff_descend");
      level utility::flag_wait("flag_end_cliff");
      objectives::objective_remove_location("push_to_exfil", "cliff_descend_1");
      level utility::flag_wait("flag_shipyard_obj_start");
    case #"hash_6e796d4e120a505f":
      if(!objectives::objective_exists("push_to_exfil")) {
        objectives::objective_add("push_to_exfil", "current", undefined, &"SP_JUP_TUNDRA/OBJ_SHIPYARD_FIGHT_DESC", undefined, "icon_waypoint_objective_general");
      } else {
        objectives::objective_set_description("push_to_exfil", &"SP_JUP_TUNDRA/OBJ_SHIPYARD_FIGHT_DESC");
      }

      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("push_to_exfil", "shipyard_fight_1", "s_obj_shipyard_fight");
      level utility::flag_wait_any("flag_shipyard_obj_clear_complete", "flag_shipyard_complete");
      objectives::objective_remove_location("push_to_exfil", "shipyard_fight_1");
      objectives::objective_set_description("push_to_exfil", &"SP_JUP_TUNDRA/OBJ_FINALE_REGROUP_DESC");
      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("push_to_exfil", "exfil_flare", "s_obj_finale_holdout");
    case #"hash_94348ef8447b43be":
      if(!objectives::objective_exists("push_to_exfil")) {
        objectives::objective_add("push_to_exfil", "current", undefined, &"SP_JUP_TUNDRA/OBJ_FINALE_REGROUP_DESC", undefined, "icon_waypoint_objective_general");
        namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("push_to_exfil", "exfil_flare", "s_obj_finale_holdout");
      }

      level utility::flag_wait("flag_finale_obj_holdout");
      objectives::objective_remove_location("push_to_exfil", "exfil_flare");
      objectives::objective_remove("push_to_exfil");
      objectives::objective_add("finale_holdout", "current", undefined, &"SP_JUP_TUNDRA/OBJ_FINALE_HOLDOUT_DESC", undefined, "icon_waypoint_objective_general");
      level utility::flag_wait("flag_finale_obj_holdout_complete");
    case #"hash_58cf141c1578fc75":
      if(!objectives::objective_exists("finale_holdout")) {
        objectives::objective_add("finale_holdout", "current", undefined, &"SP_JUP_TUNDRA/OBJ_FINALE_HOLDOUT_DESC", undefined, "icon_waypoint_objective_general");
      }

      level utility::flag_wait("flag_finale_obj_exfil");
      objectives::objective_set_description("finale_holdout", &"SP_JUP_TUNDRA/OBJ_FINALE_EXFIL_DESC");
      namespace_8339f6377b6ba60e::function_b9c45aef7508e9cd("finale_holdout", "exfil_heli", "s_obj_finale_exfil");
      level utility::flag_wait("flag_finale_exfil_outro_begin");
      objectives::objective_remove_location("finale_holdout", "exfil_heli");
      objectives::objective_remove("finale_holdout");
      break;
  }
}