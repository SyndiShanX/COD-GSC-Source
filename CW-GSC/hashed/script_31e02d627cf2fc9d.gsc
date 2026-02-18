/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_31e02d627cf2fc9d.gsc
***********************************************/

#using script_2d443451ce681a;
#using script_30cfffd6b7b2b212;
#using script_3dc93ca9902a9cda;
#using script_67332a4d085a140a;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#namespace namespace_1ca393d1;

function starting(var_d3440450) {
  level.var_aece851d = [];
  level.var_33621ea7 = 1;
  namespace_42da7c51::function_ed760ecb("woods");
  level thread function_3a28ce3b(level.woods);
  level thread objectives::follow("woods_hit1", level.woods);
  level.var_95a74232 = 1;
  level battlechatter::function_2ab9360b(1);
  level.var_9a3944f4 thread namespace_42da7c51::function_76075c60();
  level flag::set("flag_assault_heli_1");
}

function main(var_d3440450, var_50cc0d4f) {
  level thread function_22755a86();
  level notify(#"hash_4f6dc93101e62ff5");
  level.var_7c11765c = 0;
  level.last_player_attacker = level;
  callback::on_player_damage(&namespace_42da7c51::function_aa3c5fab);
  level thread trailer_park_combat();
  level util::delay_notify(1, "heli_focus_gas_garage");
  level flag::wait_till("flag_trailer_park_complete");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function cleanup(name, starting, direct, player) {
  if(player) {
    level flag::set("flag_trailer_park_complete");
    level thread function_bab09690();
  }
}

function function_bab09690() {
  var_d64a504a = vehicle::simple_spawn_single("veh_trailer_park_truck");
  var_d64a504a vehicle::get_on_path("trailer_truck1_path_end", "targetname");
  var_d64a504a vehicle::lights_off();
  var_d64a504a vehicle::toggle_force_driver_taillights(0);
  spawner::add_spawn_function_group("trailer_park_riders", "targetname", &namespace_42da7c51::function_2afe54);
}

function function_22755a86() {
  level.woods dialogue::queue("vox_cp_chao_03100_wood_21eyesonthetarg_d6");
  dialogue::radio("vox_cp_chao_03100_chp1_runnerboltingth_bd");
  level.woods dialogue::queue("vox_cp_chao_03100_wood_moveuptothegass_9e");
  level.woods dialogue::queue("vox_cp_chao_03100_wood_masongetaroundt_bc");
  wait 2;
  level.woods dialogue::queue("vox_cp_chao_03100_wood_behindthatcount_5c");
  level flag::wait_till("flag_vo_woods_gas_station");
  level.woods dialogue::queue("vox_cp_chao_03100_wood_wereoutofunlead_41");
  wait 6;
  level.woods dialogue::queue("vox_cp_chao_03100_wood_someoneontheroo_3e");
  level flag::wait_till("flag_entering_trailer_park");
  level.woods dialogue::queue("vox_cp_chao_03100_wood_moreofthesefuck_c1");
  wait 1;
  level.woods dialogue::queue("vox_cp_chao_03100_wood_moreontheroof_e8");
  wait 2;
  level.woods dialogue::queue("vox_cp_chao_03100_wood_incomingtruck_9e");
  wait 2;
  dialogue::radio("vox_cp_chao_03100_chp1_iseemovementatt_85");
  level.woods dialogue::queue("vox_cp_chao_03100_wood_rogerthat_f1");
  level thread function_bf9c2634();
}

function function_bf9c2634() {
  level endon(#"hash_adfed45de5ed16d");

  while(true) {
    level.woods dialogue::queue("vox_cp_chao_03100_wood_keepmovingaldri_62");
    wait randomintrange(4, 6);
    level.woods dialogue::queue("vox_cp_chao_03100_wood_theyremovingupt_57");
    wait randomintrange(4, 6);
    level.woods dialogue::queue("vox_cp_chao_03100_wood_letsgettothemot_b9");
    wait randomintrange(4, 6);
    level.woods dialogue::queue("vox_cp_chao_03100_wood_keepmoving_56");
    wait randomintrange(4, 6);
    level.woods dialogue::queue("vox_cp_tdwn_01000_wood_letsgo_aa");
    wait randomintrange(4, 6);
    level.woods dialogue::queue("vox_cp_tdwn_01100_wood_gogomoveup_ab");
  }
}

function trailer_park_combat() {
  player = getplayers()[0];
  player endon(#"death");
  level thread function_d9c93f85();
  var_cb15424a = getent("vol_gas_station_all", "targetname");
  var_bd5393e2 = ai::array_spawn("axis_gas_station");
  level flag::wait_till("flag_gas_station_end");
  function_1eaaceab(var_bd5393e2);

  if(var_bd5393e2.size) {
    array::thread_all(var_bd5393e2, &colors::set_force_color, "y");
  }

  level thread savegame::checkpoint_save();
  a_ai = var_cb15424a ai::function_18c4ff86(#"axis", "human");
  var_1091fb7e = ai::array_spawn("axis_trailer_park_1");

  if(isDefined(a_ai) && a_ai.size) {
    foreach(ai in a_ai) {
      if(isDefined(ai) && isalive(ai)) {
        ai thread namespace_42da7c51::function_603d935("vol_trailer_park_1");
      }
    }

    var_1091fb7e = arraycombine(var_1091fb7e, a_ai);
  }

  level thread namespace_42da7c51::function_d6fedf97(var_1091fb7e, int(ceil(var_1091fb7e.size * 0.8)), "flag_trailer_park_retreat1");
  level flag::wait_till("flag_trailer_park_retreat1");

  if(isDefined(var_1091fb7e) && var_1091fb7e.size) {
    foreach(ai in var_1091fb7e) {
      if(isDefined(ai) && isalive(ai)) {
        ai thread namespace_42da7c51::function_603d935("vol_trailer_park_2");
      }
    }
  }

  var_3753c901 = ai::array_spawn("axis_trailer_park_2");
  level thread namespace_42da7c51::function_d6fedf97(var_1091fb7e, int(ceil(var_1091fb7e.size)), "flag_trailer_park_retreat2");
  level flag::wait_till("flag_trailer_park_retreat2");
  var_1091fb7e = arraycombine(var_1091fb7e, getaiarray("trailer_park_riders", "targetname"));

  if(isDefined(var_1091fb7e) && var_1091fb7e.size) {
    foreach(ai in var_1091fb7e) {
      if(isDefined(ai) && isalive(ai)) {
        ai thread namespace_42da7c51::function_603d935("vol_trailer_park_3");
      }
    }
  }

  level thread namespace_42da7c51::function_d6fedf97(var_3753c901, int(ceil(var_3753c901.size)), "flag_trailer_park_complete");
  level flag::wait_till("flag_trailer_park_complete");

  if(isDefined(var_3753c901) && var_3753c901.size) {
    foreach(ai in var_3753c901) {
      if(isDefined(ai) && isalive(ai)) {
        ai thread namespace_42da7c51::function_603d935("vol_hotel_parking_lot_combat");
      }
    }
  }
}

function function_d9c93f85() {
  level flag::wait_till("flag_entering_trailer_park");
  var_d64a504a = vehicle::simple_spawn_single_and_drive("veh_trailer_park_truck");
  var_d64a504a thread namespace_42da7c51::function_3958f4d7("lights_trailers_truck_01");
  var_d64a504a vehicle::toggle_force_driver_taillights(1);
}

function function_3a28ce3b(var_57e696c1) {
  if(!isDefined(level.var_40b02b72)) {
    level.var_40b02b72 = vehicle::simple_spawn_and_drive("trailer_park_heli");
    level.var_9a3944f4 = level.var_40b02b72[0];
    level.var_9a3944f4 thread namespace_42da7c51::function_fbb0d73f();
    thread namespace_42da7c51::heli_light(level.var_9a3944f4, "ally_heli_spot_light_bustout", "tag_fx_running_light_front_side_left_01", (-20, 12, 0), level.var_9a3944f4, 0, 1);
    level.var_9a3944f4 thread namespace_42da7c51::function_3cebcd1b();
    level.var_9a3944f4 util::delay_notify(0.2, "lights_on");
    level.var_9a3944f4 thread namespace_42da7c51::function_4c12f50();
  }
}