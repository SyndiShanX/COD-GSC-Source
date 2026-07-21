/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicle_race\coop_vehicle_race.gsc
*************************************************/

init() {
  level.ied_explosion_action_func = ::vehicle_race_ied_explosion_action;
  init_flags();
  load_vfx();
}

init_flags() {
  scripts\engine\utility::flag_init("_encstr_AA0B1A0D3BA3D7C4B79B6EF536BDB54C163AD7B9A3B0CECABE4777ED");
  scripts\engine\utility::flag_init("_encstr_BA081C944328D7A2C89FBF17A7E09A2238ABC1DA7BE8B7EA0879DBAB839D");
}

start_coop_vehicle_race_sequence() {
  start_enemy_hvt_vehicle();
  level thread enemy_hvt_bodyguard_vehicle_think();
  level thread enemy_blocker_vehicle_think();
  level thread enemy_suicide_truck_think();
}

start_enemy_hvt_vehicle() {
  var_0 = getvehiclenode("_encstr_B1FA0B7F0B73229F203BF63A13", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawnVehicle("_encstr_955E17539903DAE9289B3C07B9186FFFB4B04AFAE06F8F5E92", "_encstr_936115FBB3A5724D4D8F958EAD6BC1D92BE8F82B18415D", "_encstr_AC1207CE6BC8A76777", var_0.origin, var_0.angles);
  var_1 attachpath(var_0);
  var_1 startpath();
  var_1 vehicle_setspeedimmediate(50, 50, 50);
  var_1.num_of_ied_hit = 0;
  level.enemy_hvt_vehicle = var_1;
  var_1 thread track_player_humvee_speed_monitor(var_1);
  var_1 thread start_combat_marker_think(var_1);
  var_1 thread enemy_hvt_vehicle_damage_monitor(var_1);
  var_1 put_icon_on_hvt_vehicle(var_1);
  var_1 thread reach_end_monitor(var_1);
  var_1 thread get_too_far_ahead_monitor(var_1);
  var_1 thread follow_another_vehicle(var_1, level.player_humvee, 60, 35, 1750, 7, 4.5, 2, 155);
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_91CB1759CDB2ADCBEBD09D3AAF4CBDCD6E7DCD1C2CEEDCCA27");
}

reach_end_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::getStruct("_encstr_B1C21F2B73CAB597AFA3584EB3AC47BED9B2435AC663ACBE95B9197D0E7BB4E6A3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    if(distance2dsquared(var_1.origin, var_0.origin) <= 22500) {
      level thread delay_end_game_hvt_escaped();
      return;
    }

    wait 0.1;
  }
}

get_too_far_ahead_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = 0;

  for(;;) {
    if(enemy_hvt_start_to_get_away(var_0)) {
      if(enemy_hvt_got_away_fail(var_0)) {
        level thread delay_end_game_hvt_escaped();
        return;
      }

      if(var_1 == 0) {
        var_1 = 1;
        show_enemy_hvt_get_away_message(var_0);
      }
    } else if(var_1 == 1) {
      var_1 = 0;
      hide_enemy_hvt_get_away_message(var_0);
    }

    waitframe();
  }
}

show_enemy_hvt_get_away_message(var_0) {
  if(should_print_warning_message())
    iprintlnbold("_encstr_84F81BD94B95401BE6CCFCE5CE2A57A1FF1FD8C8FF26D9611A2B6F7BE6");

  objective_addalltomask(var_0.objective_id);
  objective_state(var_0.objective_id, "_encstr_AF5A081BBAC993AC73A3");
}

hide_enemy_hvt_get_away_message(var_0) {
  objective_removeallfrommask(var_0.objective_id);
  objective_state(var_0.objective_id, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
}

should_print_warning_message() {
  if(!isDefined(level.next_warning_message_time_hvt_getting_away))
    level.next_warning_message_time_hvt_getting_away = 0;

  var_0 = gettime();

  if(var_0 > level.next_warning_message_time_hvt_getting_away) {
    level.next_warning_message_time_hvt_getting_away = var_0 + 5000;
    return 1;
  } else
    return 0;
}

enemy_hvt_start_to_get_away(var_0) {
  if(distance2dsquared(level.player_humvee.origin, (0, 0, 0)) < 40000)
    return 0;

  return distance2dsquared(var_0.origin, level.player_humvee.origin) > 25000000;
}

enemy_hvt_got_away_fail(var_0) {
  if(distance2dsquared(level.player_humvee.origin, (0, 0, 0)) < 40000)
    return 0;

  return distance2dsquared(var_0.origin, level.player_humvee.origin) > 256000000;
}

add_weak_spot_on_hvt_vehicle(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_A9501BB2DCB25B5EEB43CE1DEB772B58D6EBCD38DBE87DD62C4E6D5993", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_2 setModel("_encstr_B25916D89C581DAC7D388DB0DC1D9636EB26DB1EBE9CCA8C");
  var_2.angles = var_1.angles;
  var_2 linkTo(var_0);
  var_2 thread clean_up_think(var_2, var_0);
  var_2 thread hvt_vehicle_weak_spot_damage_monitor(var_2, var_0);
}

clean_up_think(var_0, var_1) {
  var_1 waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

hvt_vehicle_weak_spot_damage_monitor(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1.weak_spot_destroyed = 0;
  var_1.weak_spot = var_0;
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0.fake_health = 30;

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health = 999999;

    if(isPlayer(var_3) && isDefined(var_2)) {
      var_3 scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", 1, var_2, 0, 0);
      var_0.fake_health = var_0.fake_health - var_2;

      if(var_0.fake_health < 0) {
        break;
      }
    }
  }

  iprintlnbold("_encstr_8F422151BFB92097D1DDF78EB251EF6BC9AA421FC08E3F4180CF5CA9AFD37B5F171249");
  var_1.weak_spot_destroyed = 1;
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 thread armor_disabled_vfx_loop(var_0);
}

armor_disabled_vfx_loop(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  playFXOnTag(level._effect["_encstr_99241C68FB1C915422DB534F23CA08B8B29530A32975E00F8ADF9F431722"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  for(;;) {
    playFXOnTag(level._effect["_encstr_87561B34EC1DEB67AC0DA58DC656FA2CE4D6BDE4AF46D2B91631D89532"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_1 = randomfloatrange(0.5, 0.9);
    wait(var_1);
  }
}

vehicle_race_ied_explosion_action(var_0) {
  check_ied_blow_up_sight_blocker(var_0);
  check_ied_explodes_near_enemy_hvt(var_0);
}

check_ied_explodes_near_enemy_hvt(var_0) {
  if(!isDefined(level.enemy_hvt_vehicle)) {
    return;
  }
  if(distance2dsquared(var_0.origin, level.enemy_hvt_vehicle.origin) < 90000) {
    level.enemy_hvt_vehicle.num_of_ied_hit++;

    switch (level.enemy_hvt_vehicle.num_of_ied_hit) {
      case 1:
        play_smoke_vfx_on_tires();
        iprintlnbold("_encstr_B6DC14D45D3636956EDC66AB1B40252A8802D0A58E24");
        break;
      case 2:
        play_smoke_vfx_on_vehicle();
        iprintlnbold("_encstr_B6DC14D45D3636956EDC66AB1B40252A8802D0A58E24");
        break;
      case 3:
        enemy_hvt_vehicle_explodes();
        level thread coop_vehicle_race_success();
        break;
    }
  }
}

check_ied_blow_up_sight_blocker(var_0) {
  if(isDefined(var_0.target)) {
    var_1 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = var_1.sight_blocker_models;
    var_2 = scripts\engine\utility::array_removeundefined(var_2);
    var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2)[0];
    playFX(level._effect["_encstr_AFDC18374B76431DBE89C6BD1B6DB2937DACC30763F6DC2DEDDC"], var_3.origin);
    var_3 delete();
  }
}

play_smoke_vfx_on_tires() {
  var_0 = ["_encstr_822E1C35718FFEF704722B50C99E9B90BB1DBE38CE73203DEBF940103273", "_encstr_B6271D4758D9D7771A56598DFA1BB2E6E8CAC9D7AD9623321B957DD8B2331D", "_encstr_95401B1D2C9DFA77D02B59C6D7C6B2DCE82B397D312C36ADAF8DB2CC47"];
  var_1 = ["_encstr_84311D85A15F2E27D482F080192ECBC0CB4D0EE83EA3904DBB4940A07204D1", "_encstr_91F81E3A859DFABB862B9563EB1B593747AC39F5ADB423C88DCABE9CD23BD08E", "_encstr_B8C91CC3D3BCF97F4051AFF50EC0B5228D6353F7BDD7622BD15BA43FC010"];

  foreach(var_3 in var_0)
  playFXOnTag(level._effect["_encstr_92E023944BEB2E565D2888D71C5F79C3D87377AF21E0A557F9928F1809EF5C0AA9D3B71878"], level.enemy_hvt_vehicle, var_3);

  foreach(var_6 in var_1)
  playFXOnTag(level._effect["_encstr_B1DE2443CE3ABE672B34A5C636CAAF475AE456D7C80B6B0B7695F5B9B6BDB5AC7D4E5AEC0DA3"], level.enemy_hvt_vehicle, var_6);
}

play_smoke_vfx_on_vehicle() {
  var_0 = ["_encstr_81A20F7AC30B926F2331631A3890E3CDC0", "_encstr_BD3E128CE4B49D95E46EEBA1B0A3B1A1BEA99B3A"];

  foreach(var_2 in var_0)
  playFXOnTag(level._effect["_encstr_AA171E0D67D1AFB32B1A4BD83656FA1ABDDE91AF91B0AD169D95F59BB67B5B95"], level.enemy_hvt_vehicle, var_2);
}

enemy_hvt_vehicle_explodes() {
  playsoundatpos(level.enemy_hvt_vehicle.origin, "_encstr_AF36183D3BE24401679AA1D8464C18901ABB89A1F7DB96C8B632");
  earthquake(0.5, 1.2, level.enemy_hvt_vehicle.origin, 4000);
  playFX(level._effect["_encstr_8F5916B9CBD3C96671832A07C02D8783D019E10A5B2FED3D"], level.enemy_hvt_vehicle.origin);
  level.enemy_hvt_vehicle delete();
}

coop_vehicle_race_success() {
  iprintln("_encstr_99D709F97DD5D21B60EE51");
  wait 4.0;
  level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_91190447C232"]);
}

put_icon_on_hvt_vehicle(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_8F25178880172311F0A8400B59C5630AB29F3C59D87B58D7C0", 20);
  objective_setplayintro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_state(var_1, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_icon(var_1, "_encstr_BEA22278BF5FE0974246A6355C0A2D0EAB0B900857E65995B96F28B5B54307F3EDE72040");
  objective_onentity(var_1, var_0);
  objective_removeallfrommask(var_1);
  var_0.objective_id = var_1;
  var_0 thread icon_clean_up_think(var_0);
}

icon_clean_up_think(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\cp\cp_objectives::freeworldid("_encstr_8F25178880172311F0A8400B59C5630AB29F3C59D87B58D7C0");
}

follow_another_vehicle(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_92271BDBA83F6F06074B0348773FA718E5C1E8C850EF4D899BE1F673E5");

  for(;;) {
    if(vehicle_is_falling_behind_vehicle_to_follow(var_0, var_1))
      speed_up(var_0, var_2, var_5);
    else if(vehicle_is_too_far_ahead(var_0, var_1, var_4))
      slow_down(var_0, var_3, var_7);
    else if(enemy_hvt_vehicle_should_speed_up(var_0, var_1, var_8))
      speed_up(var_0, var_2, var_6);
    else
      slow_down(var_0, var_3, var_7);

    wait 0.1;
  }
}

vehicle_is_falling_behind_vehicle_to_follow(var_0, var_1) {
  var_2 = vectorNormalize(var_0 vehicle_getvelocity());
  var_3 = vectorNormalize(var_1.origin - var_0.origin);
  var_4 = vectordot(var_3, var_2);
  return var_4 > 0;
}

speed_up(var_0, var_1, var_2) {
  var_3 = var_0 vehicle_getspeed();
  var_4 = min(var_3 + var_2, var_1);
  var_0 vehicle_setspeedimmediate(var_4);
}

slow_down(var_0, var_1, var_2) {
  var_3 = var_0 vehicle_getspeed();
  var_4 = max(var_3 - var_2, var_1);
  var_0 vehicle_setspeedimmediate(var_4);
}

enemy_hvt_vehicle_should_speed_up(var_0, var_1, var_2) {
  var_3 = get_angles_between_two_vehicle(var_0, var_1);

  if(var_3 < var_2)
    return 1;
  else
    return 0;
}

get_angles_between_two_vehicle(var_0, var_1) {
  var_2 = var_0 vehicle_getvelocity();
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectorNormalize(var_2);
  var_3 = var_1.origin - var_0.origin;
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = vectorNormalize(var_3);
  var_4 = vectordot(var_2, var_3);
  var_4 = clamp(var_4, -1, 1);
  return acos(var_4);
}

vehicle_is_too_far_ahead(var_0, var_1, var_2) {
  return distancesquared(var_0.origin, var_1.origin) >= squared(var_2);
}

delay_end_game_hvt_escaped() {
  iprintlnbold("_encstr_A3B5178F10F0B543DF599BEBF1938AE382D9BA8E69B0454A67");
  wait 2.5;
  level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
}

set_up_modular_spawning() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.ambientgroups))
    level.ambientgroups = [];

  if(!isDefined(level.active_spawn_modules))
    level.active_spawn_modules = [];

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(getdvarint("_encstr_A24712B98DC9FAB2E6CAADBCAF9BDEE61CC2BB73", 0) != 0) {
    return;
  }
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_91CB1759CDB2ADCBEBD09D3AAF4CBDCD6E7DCD1C2CEEDCCA27", 1, 1, 1, 0.05, 0, "_encstr_91CB1759CDB2ADCBEBD09D3AAF4CBDCD6E7DCD1C2CEEDCCA27", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9A1B119B8EB09CE8F531DB32F27DD9AB0BE48C", 6, 6, 6, 0.05, 0, "_encstr_AF4D169BA358E41DF589ED23E5B35D0BC9C8F56E1C0BDD9B", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_867E19B30B374393695DCFCC43809B57E661093B139F9FCD9147EB", 6, 6, 6, 0.05, 0, "_encstr_867E19B30B374393695DCFCC43809B57E661093B139F9FCD9147EB", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9B7412BBEF1DBB4F88318A17EE6080F26C15C76E", 6, 6, 6, 0.05, 0, "_encstr_9B7412BBEF1DBB4F88318A17EE6080F26C15C76E", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9974129935313A7F73567033C720E8D83452E123", 12, 12, 12, 0.05, 0, "_encstr_9974129935313A7F73567033C720E8D83452E123", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AB741261EF211B0F753F269547B240511C734126", 12, 12, 12, 0.05, 0, "_encstr_AB741261EF211B0F753F269547B240511C734126", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8D7412B2EF775ECC03377201611012A76FD00E22", 12, 12, 12, 0.05, 0, "_encstr_8D7412B2EF775ECC03377201611012A76FD00E22", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A5741272E8E95EC433D652B10F40C3636F858FBB", 12, 12, 12, 0.05, 0, "_encstr_A5741272E8E95EC433D652B10F40C3636F858FBB", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_867412BA07F8807F5DC1D3BAEEB6DB7E889D0F56", 12, 12, 12, 0.05, 0, "_encstr_867412BA07F8807F5DC1D3BAEEB6DB7E889D0F56", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8B741279ED5CF08C13CFB5911F5B4F88E705465B", 12, 12, 12, 0.05, 0, "_encstr_8B741279ED5CF08C13CFB5911F5B4F88E705465B", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8F7412C6B0782122F58B8BAB8F9E1B71B83831D8", 12, 12, 12, 0.05, 0, "_encstr_8F7412C6B0782122F58B8BAB8F9E1B71B83831D8", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_917412667045687193FF32E3E9BF8BE8177D09C2", 12, 12, 12, 0.05, 0, "_encstr_917412667045687193FF32E3E9BF8BE8177D09C2", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AAD613C4DE192FB3BA58E419D7E61C85BB9BAF13C0", 12, 12, 12, 0.05, 0, "_encstr_AAD613C4DE192FB3BA58E419D7E61C85BB9BAF13C0", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_81D6134CED23BC7657859319FAB90E85BBB9FA894C", 12, 12, 12, 0.05, 0, "_encstr_81D6134CED23BC7657859319FAB90E85BBB9FA894C", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_ADD613E2F7C043842B409315D07B6977EB9EB7BB52", 12, 12, 12, 0.05, 0, "_encstr_ADD613E2F7C043842B409315D07B6977EB9EB7BB52", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_97D613E3107FF3AF13D88B38DF124A9E973B6F22D7", 12, 12, 12, 0.05, 0, "_encstr_97D613E3107FF3AF13D88B38DF124A9E973B6F22D7", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8AD61326655138E87587EBC0A06FBF63AB5AF87FB4", 12, 12, 12, 0.05, 0, "_encstr_8AD61326655138E87587EBC0A06FBF63AB5AF87FB4", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_85D613AAC2E2B3F06B49155C861FF93FAB06AF4753", 12, 12, 12, 0.05, 0, "_encstr_85D613AAC2E2B3F06B49155C861FF93FAB06AF4753", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B2D6137AB06D87BFC0B30AE43708822F0C0821F733", 12, 12, 12, 0.05, 0, "_encstr_B2D6137AB06D87BFC0B30AE43708822F0C0821F733", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_84D6130A50E178BFB3A7626C509B2B863FB041B72A", 12, 12, 12, 0.05, 0, "_encstr_84D6130A50E178BFB3A7626C509B2B863FB041B72A", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AD4610BA40F857B2EFFAC77BCB176378E6EA", 6, 6, 6, 0.05, 0, "_encstr_AD4610BA40F857B2EFFAC77BCB176378E6EA", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_844610C5B3F2B650758AF64B3259F878A9A2", 6, 6, 6, 0.05, 0, "_encstr_844610C5B3F2B650758AF64B3259F878A9A2", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8A46107071704B2A4D523E08B277575617C6", 6, 6, 6, 0.05, 0, "_encstr_8A46107071704B2A4D523E08B277575617C6", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A64610C4D8DB6C6D2BC9AFCDE00B779BAF43", 6, 6, 6, 0.05, 0, "_encstr_A64610C4D8DB6C6D2BC9AFCDE00B779BAF43", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B24610B218201744884DEFCB21C00B5B405B", 6, 6, 6, 0.05, 0, "_encstr_B24610B218201744884DEFCB21C00B5B405B", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B446104D2507EF074F0A2753B1FAEC60BF12", 6, 6, 6, 0.05, 0, "_encstr_B446104D2507EF074F0A2753B1FAEC60BF12", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B64610DBE1BF085BF59358826B4FA37837E3", 6, 6, 6, 0.05, 0, "_encstr_B64610DBE1BF085BF59358826B4FA37837E3", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BD461031C6ED8D6DCA27BE9BC158DD37F50E", 12, 12, 12, 0.05, 0, "_encstr_BD461031C6ED8D6DCA27BE9BC158DD37F50E", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_824610F6393FABA09D33A10F90293F25614A", 12, 12, 12, 0.05, 0, "_encstr_824610F6393FABA09D33A10F90293F25614A", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9B65118A3190365F45B3F13B1BAFF7ADB93350", 12, 12, 12, 0.05, 0, "_encstr_9B65118A3190365F45B3F13B1BAFF7ADB93350", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9965118368E073A2D326F1F20F833B368EFA46", 12, 12, 12, 0.05, 0, "_encstr_9965118368E073A2D326F1F20F833B368EFA46", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8B651189C6B71BD6CA9C7DB907C2DD37F5268C", 12, 12, 12, 0.05, 0, "_encstr_8B651189C6B71BD6CA9C7DB907C2DD37F5268C", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_83651195E3A2E65B05FA861B62E928A8597EAF", 12, 12, 12, 0.05, 0, "_encstr_83651195E3A2E65B05FA861B62E928A8597EAF", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A16511852CE52082A70BCE73138F448031E9A1", 12, 12, 12, 0.05, 0, "_encstr_A16511852CE52082A70BCE73138F448031E9A1", ::increase_script_maxdist, undefined, 10);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_91CB1759CDB2ADCBEBD09D3AAF4CBDCD6E7DCD1C2CEEDCCA27", ::enemy_hvt_boss_watcher);
}

increase_script_maxdist(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.spawn_points.size; var_4++) {
    var_5 = var_0.spawn_points[var_4];
    var_5.script_maxdist = 20000;
  }
}

enemy_hvt_bodyguard_vehicle_think() {
  level.hvt_bodyguard_vehicles = [];
  level thread bodyguard_vehicle_spawned_monitor();

  if(getdvarint("_encstr_BAB3110FDF7859F3B84F7260515007A53FD976", 0))
    scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_867E19B30B374393695DCFCC43809B57E661093B139F9FCD9147EB");
  else
    scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_9A1B119B8EB09CE8F531DB32F27DD9AB0BE48C");

  var_0 = scripts\engine\utility::getStructArray("_encstr_AB5B18813A5B7BF8E3D95561FF4A08CFAF82BECB1387BCC0BFA2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_0 thread bodyguard_vehicle_spawn_trigger_think(var_2, "_encstr_8ACB180B9970A33B28C162DA8A1C6F9E4029AF76DB606CC769D9");

  for(;;) {
    level waittill("_encstr_8ACB180B9970A33B28C162DA8A1C6F9E4029AF76DB606CC769D9", var_4);

    if(other_bodyguard_vehicles_exist()) {
      continue;
    }
    scripts\cp\cp_modular_spawning::run_spawn_module(var_4);
  }
}

enemy_blocker_vehicle_think() {
  level.blocker_vehicles = [];
  level thread blocker_vehicle_spawned_monitor();
  var_0 = scripts\engine\utility::getStructArray("_encstr_95FE16138D7BD85B59E4F5371C85BBB9AFD127A5D9CE959C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread blocker_vehicle_spawn_trigger_think(var_2, "_encstr_931616FB931734F851E2A1AF0B84787E474BB10D6A67E1E8");

  for(;;) {
    level waittill("_encstr_931616FB931734F851E2A1AF0B84787E474BB10D6A67E1E8", var_4);

    if(other_blocker_vehicles_exist()) {
      continue;
    }
    scripts\cp\cp_modular_spawning::run_spawn_module(var_4);
  }
}

enemy_suicide_truck_think() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_B4F51CE6D5968DD24695FA3A93EA1BDABE9B072CEE73BE8E395A9DCEAC27", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread suicide_truck_spawn_trigger_think(var_2);
}

suicide_truck_spawn_trigger_think(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(distance2dsquared(var_0.origin, level.player_humvee.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  spawn_suicide_truck_at_vehicle_spawner(var_0.script_noteworthy, var_0);
}

spawn_suicide_truck_at_vehicle_spawner(var_0, var_1) {
  var_2 = getvehiclenode(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawnVehicle("_encstr_A1961F66BD0DEAD1C7B093198005D7BF3B15FBE0C08E9B67ED383A11C055CDC713", "_encstr_8F4915785FAA391B8B11060DF4924B01E50FC0C0975370", "_encstr_AC1207CE6BC8A76777", var_2.origin, var_2.angles);
  var_3 attachpath(var_2);
  var_3 startpath();
  var_3 vehicle_setspeedimmediate(70, 70, 70);
  var_3 thread suicide_truck_detonate_think(var_3, var_1);
  var_3 thread suicide_truck_damage_monitor(var_3);
}

suicide_truck_damage_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0.fake_health = 500;

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;

    if(isPlayer(var_2) && isDefined(var_1)) {
      var_2 scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", 1, var_1, 0, 0);
      var_0.fake_health = var_0.fake_health - var_1;

      if(var_0.fake_health <= 0) {
        break;
      }
    }
  }

  suicide_truct_explods(var_0);
}

suicide_truck_detonate_think(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait_to_get_to_main_road(var_0, var_1);

  for(;;) {
    if(suicide_truck_should_detonate(var_0))
      suicide_truct_explods(var_0);

    waitframe();
  }
}

suicide_truct_explods(var_0) {
  earthquake(0.5, 1.2, var_0.origin, 400);
  playsoundatpos(var_0.origin, "_encstr_AF36183D3BE24401679AA1D8464C18901ABB89A1F7DB96C8B632");
  playFX(level._effect["_encstr_BD17187DD0D8BEA2AB086108104F7109D2556E67AFEAA15015C7"], var_0.origin);
  _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::damage_nearby_players(var_0, 80, 40000);
  _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::damage_nearby_vehicles(var_0, 22500);
  var_0 delete();
}

suicide_truck_should_detonate(var_0) {
  if(suicide_truck_ahead_of_player_humvee(var_0))
    return 1;

  if(player_humvee_withn_explosion_range(var_0))
    return 1;

  return 0;
}

player_humvee_withn_explosion_range(var_0) {
  var_1 = level.player_humvee.origin;

  if(distance2dsquared(var_1, (0, 0, 0)) > 40000)
    return distance2dsquared(var_0.origin, var_1) < 40000;

  return 0;
}

suicide_truck_ahead_of_player_humvee(var_0) {
  var_1 = level.player_humvee.origin;

  if(distance2dsquared(var_1, (0, 0, 0)) > 40000) {
    var_2 = var_0 vehicle_getvelocity();
    var_2 = (var_2[0], var_2[1], 0);
    var_2 = vectorNormalize(var_2);
    var_3 = var_1 - var_0.origin;
    var_3 = (var_3[0], var_3[1], 0);
    var_3 = vectorNormalize(var_3);
    var_4 = vectordot(var_2, var_3);
    return var_4 < 0;
  }

  return 0;
}

other_bodyguard_vehicles_exist() {
  return level.hvt_bodyguard_vehicles.size > 0;
}

other_blocker_vehicles_exist() {
  return level.blocker_vehicles.size > 0;
}

bodyguard_vehicle_spawn_trigger_think(var_0, var_1) {
  level.enemy_hvt_vehicle endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(distance2dsquared(var_0.origin, level.enemy_hvt_vehicle.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  level notify(var_1, var_0.script_noteworthy);
}

blocker_vehicle_spawn_trigger_think(var_0, var_1) {
  for(;;) {
    if(distance2dsquared(var_0.origin, level.player_humvee.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  level notify(var_1, var_0.script_noteworthy);
}

bodyguard_vehicle_spawned_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501", var_0, var_1);

    if(scripts\engine\utility::array_contains(level.hvt_bodyguard_vehicles, var_1)) {
      continue;
    }
    switch (var_0.group_name) {
      case "_encstr_84D6130A50E178BFB3A7626C509B2B863FB041B72A":
      case "_encstr_B2D6137AB06D87BFC0B30AE43708822F0C0821F733":
      case "_encstr_85D613AAC2E2B3F06B49155C861FF93FAB06AF4753":
      case "_encstr_8AD61326655138E87587EBC0A06FBF63AB5AF87FB4":
      case "_encstr_97D613E3107FF3AF13D88B38DF124A9E973B6F22D7":
      case "_encstr_ADD613E2F7C043842B409315D07B6977EB9EB7BB52":
      case "_encstr_81D6134CED23BC7657859319FAB90E85BBB9FA894C":
      case "_encstr_AAD613C4DE192FB3BA58E419D7E61C85BB9BAF13C0":
      case "_encstr_917412667045687193FF32E3E9BF8BE8177D09C2":
      case "_encstr_8F7412C6B0782122F58B8BAB8F9E1B71B83831D8":
      case "_encstr_8B741279ED5CF08C13CFB5911F5B4F88E705465B":
      case "_encstr_867412BA07F8807F5DC1D3BAEEB6DB7E889D0F56":
      case "_encstr_A5741272E8E95EC433D652B10F40C3636F858FBB":
      case "_encstr_8D7412B2EF775ECC03377201611012A76FD00E22":
      case "_encstr_AB741261EF211B0F753F269547B240511C734126":
      case "_encstr_9974129935313A7F73567033C720E8D83452E123":
      case "_encstr_9B7412BBEF1DBB4F88318A17EE6080F26C15C76E":
      case "_encstr_9A1B119B8EB09CE8F531DB32F27DD9AB0BE48C":
        var_1 thread bodyguard_vehicle_think(var_1);
    }
  }
}

blocker_vehicle_spawned_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501", var_0, var_1);

    if(scripts\engine\utility::array_contains(level.blocker_vehicles, var_1)) {
      continue;
    }
    switch (var_0.group_name) {
      case "_encstr_A16511852CE52082A70BCE73138F448031E9A1":
      case "_encstr_83651195E3A2E65B05FA861B62E928A8597EAF":
      case "_encstr_8B651189C6B71BD6CA9C7DB907C2DD37F5268C":
      case "_encstr_9965118368E073A2D326F1F20F833B368EFA46":
      case "_encstr_9B65118A3190365F45B3F13B1BAFF7ADB93350":
      case "_encstr_824610F6393FABA09D33A10F90293F25614A":
      case "_encstr_BD461031C6ED8D6DCA27BE9BC158DD37F50E":
      case "_encstr_B64610DBE1BF085BF59358826B4FA37837E3":
      case "_encstr_B446104D2507EF074F0A2753B1FAEC60BF12":
      case "_encstr_B24610B218201744884DEFCB21C00B5B405B":
      case "_encstr_A64610C4D8DB6C6D2BC9AFCDE00B779BAF43":
      case "_encstr_8A46107071704B2A4D523E08B277575617C6":
      case "_encstr_844610C5B3F2B650758AF64B3259F878A9A2":
      case "_encstr_AD4610BA40F857B2EFFAC77BCB176378E6EA":
        var_1 thread blocker_vehicle_think(var_1);
    }
  }
}

bodyguard_vehicle_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  add_to_hvt_bodyguard_vehicles_array(var_0);
  var_0 thread bodyguard_vehicle_death_monitor(var_0);
  var_0 thread enemy_vehicle_damage_monitor(var_0, 5000);
  wait 1.5;
  change_riders_demeanor(var_0);
  var_0 notify("_encstr_A7A420CDE8DB1CEBCE2BD04BD863ACEB7BB9AFC80BB5859DCAFAA537E856E4B92CC6");
  var_0 notify("_encstr_BD97189B8EDBE0F5DD2CB41DA5373BBE33BD937DB90E58DD73B9");
  var_0 thread follow_enemy_hvt_vehicle(var_0);
  var_0 thread enemy_vehicle_no_rider_monitor(var_0);
}

blocker_vehicle_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  add_to_blocker_vehicles_array(var_0);
  var_0 thread blocker_vehicle_death_monitor(var_0);
  var_0 thread enemy_vehicle_damage_monitor(var_0, 5000);
  wait 1.5;
  change_riders_demeanor(var_0);
  var_0 notify("_encstr_A7A420CDE8DB1CEBCE2BD04BD863ACEB7BB9AFC80BB5859DCAFAA537E856E4B92CC6");
  var_0 notify("_encstr_BD97189B8EDBE0F5DD2CB41DA5373BBE33BD937DB90E58DD73B9");
  var_0 thread enemy_vehicle_no_rider_monitor(var_0);
  var_0 thread stay_in_front_of_player_vehicle(var_0);
}

change_riders_demeanor(var_0) {
  foreach(var_2 in var_0.riders)
  var_2 scripts\common\utility::demeanor_override("_encstr_AA7C07466F9DA30713");
}

enemy_vehicle_damage_monitor(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.health = 999999;
  var_0.fake_health = var_1;

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health = 999999;

    if(isDefined(var_2)) {
      var_0.fake_health = var_0.fake_health - var_2;

      if(var_0.fake_health < 0)
        var_0 enemy_vehicle_explodes(var_0);
    }
  }
}

enemy_vehicle_no_rider_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_836F13637F80E83F190FDFE2A7BF1F707DB25DD611");

  foreach(var_2 in var_0.riders)
  var_2 thread rider_death_monitor(var_2, var_0);

  for(;;) {
    var_0 waittill("_encstr_A5B912B9C0DD13C9426A691A3D770BF1FAA27539");
    var_4 = get_num_of_alive_riders(var_0);

    if(var_4 == 0)
      var_0 enemy_vehicle_explodes(var_0);
  }
}

get_num_of_alive_riders(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0.riders) {
    if(isai(var_3) && isalive(var_3))
      var_1++;
  }

  return var_1;
}

rider_death_monitor(var_0, var_1) {
  var_0 waittill("_encstr_AD75063D571AE108");
  var_1 notify("_encstr_A5B912B9C0DD13C9426A691A3D770BF1FAA27539");
}

enemy_vehicle_explodes(var_0) {
  foreach(var_2 in var_0.riders) {
    if(isai(var_2) && isalive(var_2)) {
      var_2 unlink();
      var_3 = vectorNormalize(var_2.origin - var_0.origin);
      var_2 setvelocity(var_3 * 1200);
      var_2 dodamage(var_2.health + 100, var_2.origin);
    }
  }

  playFX(level._effect["_encstr_AD021CC47B23E5ECAE589C32BED956A15A8D8D2BF595870EB1F6CDD2F6DC"], var_0.origin + (0, 0, 20));
  var_0 delete();
}

follow_enemy_hvt_vehicle(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level.enemy_hvt_vehicle endon("_encstr_AD75063D571AE108");

  if(!isDefined(level.enemy_hvt_vehicle)) {
    return;
  }
  var_1 = level.enemy_hvt_vehicle;
  var_0 vehicle_setspeedimmediate(65, 65, 65);

  for(;;) {
    if(vehicle_is_too_far_ahead(var_0, var_1, 1300))
      speed_up(var_0, 65, 1);
    else if(hvt_bodyguard_vehicle_should_speed_up(var_0, var_1))
      speed_up(var_0, 65, 1);
    else
      slow_down(var_0, 25, 4);

    waitframe();
  }
}

stay_in_front_of_player_vehicle(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 vehicle_setspeedimmediate(75, 75, 75);
  wait_to_get_to_main_road(var_0, scripts\engine\utility::getStruct(var_0.group.group_name + "_encstr_8ACE08F84B42B5A12D93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));

  for(;;) {
    if(getting_too_close_with_player_humvee(var_0, level.player_humvee))
      speed_up(var_0, 75, 2.5);
    else
      slow_down(var_0, 0, 1);

    waitframe();
  }
}

delay_test_explodes(var_0) {
  wait 5;
  enemy_vehicle_explodes(var_0);
}

wait_to_get_to_main_road(var_0, var_1) {
  for(;;) {
    if(distance2dsquared(var_0.origin, var_1.origin) < 90000) {
      return;
    }
    waitframe();
  }
}

getting_too_close_with_player_humvee(var_0, var_1) {
  return distance2dsquared(var_0.origin, var_1.origin) < 2250000;
}

hvt_bodyguard_vehicle_should_speed_up(var_0, var_1) {
  if(too_close_to_other_bodyguard_vehicle_in_front(var_0))
    return 0;

  var_2 = var_0 vehicle_getvelocity();
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectorNormalize(var_2);
  var_3 = var_1.origin - var_0.origin;
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = vectorNormalize(var_3);
  var_4 = vectordot(var_2, var_3);
  var_5 = acos(var_4);

  if(var_5 < get_desired_bodyguard_vehicle_angle(var_0))
    return 1;
  else
    return 0;
}

too_close_to_other_bodyguard_vehicle_in_front(var_0) {
  var_1 = get_other_bodyguard_vehicles_in_front(var_0);

  foreach(var_3 in var_1) {
    if(distance2dsquared(var_0.origin, var_3.origin) <= 250000)
      return 1;
  }

  return 0;
}

get_other_bodyguard_vehicles_in_front(var_0) {
  var_1 = [];
  var_2 = var_0 vehicle_getvelocity();

  foreach(var_4 in level.hvt_bodyguard_vehicles) {
    if(var_4 == var_0) {
      continue;
    }
    var_5 = var_4.origin - var_0.origin;

    if(vectordot(var_5, var_2) < 0) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

too_close_to_other_blocker_vehicle_in_front(var_0) {
  var_1 = get_other_blocker_vehicles_in_front(var_0);

  foreach(var_3 in var_1) {
    if(distance2dsquared(var_0.origin, var_3.origin) <= 250000)
      return 1;
  }

  return 0;
}

get_other_blocker_vehicles_in_front(var_0) {
  var_1 = [];
  var_2 = var_0 vehicle_getvelocity();

  foreach(var_4 in level.blocker_vehicles) {
    if(var_4 == var_0) {
      continue;
    }
    var_5 = var_4.origin - var_0.origin;

    if(vectordot(var_5, var_2) < 0) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

get_desired_bodyguard_vehicle_angle(var_0) {
  switch (level.hvt_bodyguard_vehicles.size) {
    case 1:
      return 90;
    case 2:
      switch (var_0.bodyguard_vehicle_id) {
        case 1:
          return 135;
        case 2:
          return 90;
      }
    case 3:
      switch (var_0.bodyguard_vehicle_id) {
        case 1:
          return 150;
        case 2:
          return 90;
        case 3:
          return 30;
      }
  }
}

add_to_blocker_vehicles_array(var_0) {
  level.blocker_vehicles = scripts\engine\utility::array_add(level.blocker_vehicles, var_0);
}

add_to_hvt_bodyguard_vehicles_array(var_0) {
  level.hvt_bodyguard_vehicles = scripts\engine\utility::array_add(level.hvt_bodyguard_vehicles, var_0);
  var_0.bodyguard_vehicle_id = level.hvt_bodyguard_vehicles.size;
}

bodyguard_vehicle_death_monitor(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  var_1 = var_0.bodyguard_vehicle_id;
  level.hvt_bodyguard_vehicles = scripts\engine\utility::array_remove(level.hvt_bodyguard_vehicles, var_0);
  reassign_bodyguard_vehicle_id(var_1);
}

blocker_vehicle_death_monitor(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  level.blocker_vehicles = scripts\engine\utility::array_remove(level.blocker_vehicles, var_0);
}

reassign_bodyguard_vehicle_id(var_0) {
  foreach(var_2 in level.hvt_bodyguard_vehicles) {
    if(var_2.bodyguard_vehicle_id > var_0)
      var_2.bodyguard_vehicle_id--;
  }
}

enemy_hvt_vehicle_damage_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setCanDamage(1);
  var_0.health = 999999;

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;
  }
}

deploy_concrtete_blockers_for_puzzle() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9101241A87DA3782FFF06DFF9A3007AE8CC7704F7F0F18C03D4F23F9A195C2307FBCE203FBDC", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    process_concrete_blocker_controlling_struct(var_2);
    waitframe();
  }
}

process_concrete_blocker_controlling_struct(var_0) {
  process_linked_structs(var_0);
  set_up_concrete_blockers(var_0);
  set_up_sight_blockers(var_0);
}

process_linked_structs(var_0) {
  var_0.num_of_concrete_blocks = int(var_0.script_parameters);
  var_1 = [];
  var_2 = [];
  var_3 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3) {
    switch (var_5.script_noteworthy) {
      case "_encstr_ADCA1881359EE8CEAAD3C3AF93E29820230F2B9EDDF9380A8223":
        var_1[var_1.size] = var_5;
        break;
      case "_encstr_8DA715B996B34347BE2636DE8DD6B24EEBDA2C9CDA56C9":
        var_2[var_2.size] = var_5;
        break;
    }
  }

  var_0.concrete_blocker_markers = var_1;
  var_0.sight_blocker_markers = var_2;
}

set_up_concrete_blockers(var_0) {
  var_1 = var_0.concrete_blocker_markers;

  for(var_2 = 0; var_2 < 5; var_2++)
    var_1 = scripts\engine\utility::array_randomize(var_1);

  var_3 = var_0.num_of_concrete_blocks;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_1[var_4];
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin);
    var_6 setModel("_encstr_8D8A2270674BE3BC5A325FA813EF217E323E57366002A348EF1963AF7A696F7B67E86FFB");
    var_6.angles = var_5.angles;
  }
}

set_up_sight_blockers(var_0) {
  var_1 = [];

  foreach(var_3 in var_0.sight_blocker_markers) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
    var_4 setModel("_encstr_B1C521332BDC8D56AF1BDB4E39AE76C2D1B223D7DA2B8EC2B17D0CCCEB919A63FA8DC1");
    var_4.angles = var_3.angles;
    var_1[var_1.size] = var_4;
  }

  var_0.sight_blocker_models = var_1;
}

enemy_hvt_boss_watcher(var_0) {
  var_1 = self;
  var_1.health = 9999;
  var_1.maxhealth = 9999;
  var_1.dontevershoot = 1;
  var_1.invulnerable = 1;
  var_1 scripts\engine\utility::ent_flag_init("_encstr_A2D30C62851FC397A1A86F6BE07B");
  var_1 thread delay_demeanor_override(var_1);
  var_1 thread hvt_boss_damage_monitor(var_1);
  var_1 thread hvt_boss_combat_think(var_1);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1 gettagorigin("_encstr_A130084D2FDAD8AA8F62"));
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = var_1 getplayerangles();
  var_2 linkTo(var_1);
  var_1.hvt_boss_laser_tag = var_2;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3.angles = var_1 getplayerangles();
  var_1.hvt_boss_mover = var_3;
  var_1 linkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 thread hvt_boss_mover_follow_enemy_hvt_vehicle(var_3);
  var_3 thread hvt_boss_mover_face_player_humvee(var_3);
  var_1 thread hvt_boss_clean_up_think(var_1);
}

delay_demeanor_override(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  waitframe();
  var_0 scripts\common\utility::demeanor_override("_encstr_96080730D8534E0A28");
  var_0 allowedstances("_encstr_B13D076BED70539F23");
}

hvt_boss_mover_follow_enemy_hvt_vehicle(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level.enemy_hvt_vehicle endon("_encstr_AD75063D571AE108");
  var_1 = level.enemy_hvt_vehicle;
  var_0.enemy_hvt_mover_vertical_offset = -71;

  for(;;) {
    var_2 = var_1 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1");
    var_3 = var_1 vehicle_getvelocity();
    var_3 = (var_3[0], var_3[1], 0);
    var_3 = var_3 * 0.05;
    var_0.origin = var_2 + (0, 0, var_0.enemy_hvt_mover_vertical_offset) + var_3;
    waitframe();
  }
}

hvt_boss_combat_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait(randomfloatrange(7, 15));
  hvt_boss_do_combat(var_0);
  scripts\engine\utility::flag_wait("_encstr_AA0B1A0D3BA3D7C4B79B6EF536BDB54C163AD7B9A3B0CECABE4777ED");
  hvt_boss_do_combat(var_0);
  scripts\engine\utility::flag_wait("_encstr_BA081C944328D7A2C89FBF17A7E09A2238ABC1DA7BE8B7EA0879DBAB839D");
  hvt_boss_do_combat(var_0);
  level thread play_coop_vehicle_race_successs();
  var_0.invulnerable = 0;
  var_0 dodamage(var_0.health + 100, var_0.origin);
}

play_coop_vehicle_race_successs() {
  enemy_hvt_vehicle_explodes();
  level thread coop_vehicle_race_success();
}

delay_set_starge_two_flag() {
  wait 10;
  scripts\engine\utility::flag_set("_encstr_AA0B1A0D3BA3D7C4B79B6EF536BDB54C163AD7B9A3B0CECABE4777ED");
  iprintlnbold("_encstr_8E320A40482AF4B5B75014CA");
}

delay_set_starge_three_flag() {
  wait 10;
  scripts\engine\utility::flag_set("_encstr_BA081C944328D7A2C89FBF17A7E09A2238ABC1DA7BE8B7EA0879DBAB839D");
  iprintlnbold("_encstr_8FE70CB30B3717D76971C8DA7B90");
}

hvt_boss_do_combat(var_0) {
  var_0 scripts\engine\utility::ent_flag_clear("_encstr_A2D30C62851FC397A1A86F6BE07B");

  for(;;) {
    if(player_humvee_is_within_combar_range()) {
      hvt_boss_move_to_target_vertical_offset(var_0, -45);
      var_0.invulnerable = 0;
      var_0 scripts\common\utility::demeanor_override("_encstr_AA7C07466F9DA30713");
      var_0 waittill("_encstr_B18E2155902BED17AFBAF9905346F5B93F24E8C0E35B485316620120BADDB3133BDDE5");
      hvt_boss_move_to_target_vertical_offset(var_0, -25);

      if(isDefined(level.enemy_hvt_vehicle.damage_state) && level.enemy_hvt_vehicle.damage_state == 3) {
        return;
      }
      wait 1;

      if(!var_0 scripts\engine\utility::ent_flag("_encstr_A2D30C62851FC397A1A86F6BE07B")) {
        var_1 = level.enemy_hvt_vehicle;
        var_2 = var_1 vehicle_getvelocity();
        var_2 = (var_2[0], var_2[1], 0);
        var_2 = var_2 * 0.95;
        var_3 = anglesToForward(var_0 getplayerangles());
        var_4 = var_0 gettagorigin("_encstr_A1190BD4FABB9396DC47EB8DAC") + var_3 * 20 + var_2;
        var_5 = level.player_humvee vehicle_getvelocity();
        var_6 = anglesToForward(level.player_humvee.angles);
        var_7 = level.player_humvee.origin + (0, 0, 40) + var_6 * var_1.player_humvee_speed * 25;
        var_8 = magicbullet("_encstr_81ED0FC9079DFAB55ADCCD96C659EBC60E", var_4, var_7);
        var_8 thread delay_play_ignition_vfx(var_8);
      }

      var_0.invulnerable = 1;

      if(isDefined(level.enemy_hvt_vehicle.damage_state) && level.enemy_hvt_vehicle.damage_state == 3) {
        return;
      }
      var_0 scripts\common\utility::demeanor_override("_encstr_96080730D8534E0A28");
      hvt_boss_move_to_target_vertical_offset(var_0, -71);
      wait(randomfloatrange(3, 6));

      if(var_0 scripts\engine\utility::ent_flag("_encstr_A2D30C62851FC397A1A86F6BE07B"))
        return;
    }

    wait(randomfloatrange(0.5, 1));

    if(var_0 scripts\engine\utility::ent_flag("_encstr_A2D30C62851FC397A1A86F6BE07B"))
      return;
  }
}

do_laser_target_on_player_humvee(var_0) {
  var_1 = int(60);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62");
    var_4 = level.player_humvee vehicle_getvelocity();
    var_5 = level.player_humvee.origin + (0, 0, 80) + var_4 * 0.01;
    var_6 = var_5 - var_3;
    var_7 = vectortoangles(var_6);
    playfxbetweenpoints(level._effect["_encstr_8BBB111B46E3DED1666370781BB1A95147FD9E"], var_3, var_7, var_5);
    var_8 = var_0 scripts\engine\utility::_id_143B9(0.05, "_encstr_B2BE0788BAF573592F");

    if(var_8 == "_encstr_B2BE0788BAF573592F")
      return "_encstr_BD79059C51C351";
  }

  return "_encstr_88E30897BDF1B71F7823";
}

get_target_laser_angles(var_0) {
  var_1 = var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62");
  var_2 = level.player_humvee.origin + (0, 0, 50);
  var_3 = var_2 - var_1;
  return vectortoangles(var_3);
}

switch_to_guiding_missile(var_0) {
  var_1 = var_0.origin;
  var_0 delete();
  var_2 = level.enemy_hvt_vehicle;
  var_3 = var_2 vehicle_getvelocity();
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = var_3 * 0.95;
  var_1 = var_1 + var_3;
  var_4 = level.player_humvee;
  var_5 = magicbullet("_encstr_8E9312AAFDE9B461BB61CB63B2BBE8CB3B69DE4B", var_1, var_4.origin);
  var_5 missile_settargetEnt(var_4);
  var_5 missile_setflightmodetop();
  var_5 thread delay_play_ignition_vfx(var_5);
}

delay_play_ignition_vfx(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 0.1;
  playFXOnTag(level._effect["_encstr_AAB311207AB3D5630436EF9B27AD6025B7F238"], var_0, "_encstr_B2BF0708BA770F795B");
}

hvt_boss_move_to_target_vertical_offset(var_0, var_1) {
  var_2 = var_1 - var_0.hvt_boss_mover.enemy_hvt_mover_vertical_offset;
  var_3 = abs(var_2) / 1;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(var_1 >= var_0.hvt_boss_mover.enemy_hvt_mover_vertical_offset)
      var_0.hvt_boss_mover.enemy_hvt_mover_vertical_offset = var_0.hvt_boss_mover.enemy_hvt_mover_vertical_offset + 1;
    else
      var_0.hvt_boss_mover.enemy_hvt_mover_vertical_offset = var_0.hvt_boss_mover.enemy_hvt_mover_vertical_offset - 1;

    waitframe();
  }
}

player_humvee_is_within_combar_range() {
  var_0 = level.enemy_hvt_vehicle;
  var_1 = level.player_humvee;

  if(distance2dsquared(level.player_humvee.origin, (0, 0, 0)) < 40000)
    return 0;

  return distance2dsquared(var_0.origin, var_1.origin) < 25000000;
}

hvt_boss_mover_face_player_humvee(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_1 = level.player_humvee.origin - var_0.origin;
    var_1 = (var_1[0], var_1[1], 0);
    var_1 = vectorNormalize(var_1);
    var_0.angles = vectortoangles(var_1);
    waitframe();
  }
}

hvt_boss_clean_up_think(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0.hvt_boss_mover))
    var_0.hvt_boss_mover delete();

  if(isDefined(var_0.hvt_boss_laser_tag))
    var_0.hvt_boss_laser_tag delete();
}

hvt_boss_damage_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 9999;
    var_0.maxhealth = 9999;

    if(istrue(var_0.invulnerable)) {
      continue;
    }
    var_11 = get_attacker_as_player(var_2);

    if(isDefined(var_11)) {
      var_0.invulnerable = 1;
      playsoundatpos(var_0.origin, "_encstr_AF36183D3BE24401679AA1D8464C18901ABB89A1F7DB96C8B632");
      playFX(level._effect["_encstr_A676176B16B38EADB543E079AB8A6F462FB0EFD197C730EFDD"], var_0.origin);
      enemy_hvt_vehicle_damage_state();
      var_0 scripts\engine\utility::ent_flag_set("_encstr_A2D30C62851FC397A1A86F6BE07B");
      var_11 thread delay_update_damagefeedback(var_11);
    }
  }
}

get_attacker_as_player(var_0) {
  if(isPlayer(var_0))
    return var_0;

  if(isPlayer(var_0.owner))
    return var_0.owner;

  return undefined;
}

delay_update_damagefeedback(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waittillframeend;

  if(isDefined(level.enemy_hvt_vehicle.damage_state) && level.enemy_hvt_vehicle.damage_state == 3)
    var_0 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8", 1);
  else
    var_0 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");
}

enemy_hvt_vehicle_damage_state() {
  if(!isDefined(level.enemy_hvt_vehicle.damage_state))
    level.enemy_hvt_vehicle.damage_state = 0;

  level.enemy_hvt_vehicle.damage_state++;

  switch (level.enemy_hvt_vehicle.damage_state) {
    case 1:
      level.enemy_hvt_vehicle thread loop_sparks_vfx_on_enemy_hvt_vehicle();
      break;
    case 2:
      play_smoke_vfx_on_tires();
      play_smoke_vfx_on_vehicle();
      break;
    default:
      break;
  }
}

loop_sparks_vfx_on_enemy_hvt_vehicle() {
  level.enemy_hvt_vehicle endon("_encstr_AD75063D571AE108");
  var_0 = ["_encstr_822E1C35718FFEF704722B50C99E9B90BB1DBE38CE73203DEBF940103273", "_encstr_B6271D4758D9D7771A56598DFA1BB2E6E8CAC9D7AD9623321B957DD8B2331D", "_encstr_95401B1D2C9DFA77D02B59C6D7C6B2DCE82B397D312C36ADAF8DB2CC47", "_encstr_84311D85A15F2E27D482F080192ECBC0CB4D0EE83EA3904DBB4940A07204D1", "_encstr_91F81E3A859DFABB862B9563EB1B593747AC39F5ADB423C88DCABE9CD23BD08E", "_encstr_B8C91CC3D3BCF97F4051AFF50EC0B5228D6353F7BDD7622BD15BA43FC010", "_encstr_81A20F7AC30B926F2331631A3890E3CDC0", "_encstr_BD3E128CE4B49D95E46EEBA1B0A3B1A1BEA99B3A"];

  for(;;) {
    var_1 = scripts\engine\utility::random(var_0);
    playFXOnTag(level._effect["_encstr_99241C68FB1C915422DB534F23CA08B8B29530A32975E00F8ADF9F431722"], level.enemy_hvt_vehicle, var_1);
    wait(randomfloatrange(0.15, 0.35));
  }
}

track_player_humvee_speed_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = level.player_humvee;
  var_2 = var_1.origin;

  for(;;) {
    waitframe();
    var_3 = var_1.origin;
    var_4 = length(var_3 - var_2);
    var_0.player_humvee_speed = var_4;
    var_2 = var_3;
  }
}

start_combat_marker_think(var_0) {
  level.enemy_hvt_vehicle endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::getStructArray("_encstr_8F0D1743EC1DFA4CB737CDD78DDB5B260BE8BED65893ADB24E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_3 thread hvt_combat_start_marker_think(var_3);
}

hvt_combat_start_marker_think(var_0) {
  level.enemy_hvt_vehicle endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(distance2dsquared(var_0.origin, level.enemy_hvt_vehicle.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set(var_0.script_noteworthy);
}

load_vfx() {
  level._effect["_encstr_AD021CC47B23E5ECAE589C32BED956A15A8D8D2BF595870EB1F6CDD2F6DC"] = loadfx("_encstr_8BA833769CF8B62DB36FA87873AF0B8A7B0F820BC8F403FAAC4D5BAFDBA488C8337248D1B8B8B23537AB5CCD2DE7FFD7CB259B18E9");
  level._effect["_encstr_99241C68FB1C915422DB534F23CA08B8B29530A32975E00F8ADF9F431722"] = loadfx("_encstr_A9C732F57E086ABEB7235110BA03EFA875D5795BE373C8F3BF0A880693732FF0BA2EF7ED859F30D0973321AB0A5FC83085967D71");
  level._effect["_encstr_87561B34EC1DEB67AC0DA58DC656FA2CE4D6BDE4AF46D2B91631D89532"] = loadfx("_encstr_8DC234AB92037FC8FB67DF318B5035FF1FFBD837404E430E91E5097DD31783A109D5EBA062A12A109E31FF58430925E8A8C35DB3AA49");
  level._effect["_encstr_92E023944BEB2E565D2888D71C5F79C3D87377AF21E0A557F9928F1809EF5C0AA9D3B71878"] = loadfx("_encstr_8EED382DA6A0C2036F2F4EF193364958FB3D91674B0AF9DE1331C3BA5BCFD09897886F79F13540949729DB209297BD192AFD85F59D5AE264B373");
  level._effect["_encstr_B1DE2443CE3ABE672B34A5C636CAAF475AE456D7C80B6B0B7695F5B9B6BDB5AC7D4E5AEC0DA3"] = loadfx("_encstr_A9EA4393B42B1821C7A0A7F7D89F68ADC3613C40EF21679ADBE9339BEB50AE73C089AF0A762F53CF99A1472120CF11A6256DF5BB8FAE4E732B04C89889E00C339D565C66D3");
  level._effect["_encstr_AA171E0D67D1AFB32B1A4BD83656FA1ABDDE91AF91B0AD169D95F59BB67B5B95"] = loadfx("_encstr_9367363B33C397B4DD0E7D6C385EB195675636791BE0F5264EBEB92FC9DA97D9CC0FFA46C2B6C2D959AFB9DAED5BB2FA0DBDEDC8C5ECCCC3");
  level._effect["_encstr_8F5916B9CBD3C96671832A07C02D8783D019E10A5B2FED3D"] = loadfx("_encstr_922836FDAC381F091F1A0EC96516B708F5F9C8D880C7630A86FEB723DF76406267B8C32AE1E8F6C576370FE2E2E7E8AFD3272F0ACD2BD638");
  level._effect["_encstr_BD17187DD0D8BEA2AB086108104F7109D2556E67AFEAA15015C7"] = loadfx("_encstr_922836FDAC381F091F1A0EC96516B708F5F9C8D880C7630A86FEB723DF76406267B8C32AE1E8F6C576370FE2E2E7E8AFD3272F0ACD2BD638");
  level._effect["_encstr_AFDC18374B76431DBE89C6BD1B6DB2937DACC30763F6DC2DEDDC"] = loadfx("_encstr_87D9371B6633A0CF54C80F675A72176FDFDAF8A2E4D7AE607B785692D55ACF3B55CB61FA130BF127A613B3400E72A4F101996051BA96339EC2");
  level._effect["_encstr_A676176B16B38EADB543E079AB8A6F462FB0EFD197C730EFDD"] = loadfx("_encstr_95E82ACE99F0BC96BB0EE5BB56B08397EBAC3CC11BBD974EE03BF2B333C3FACA87388DEDF59C1CD917B3661E");
  level._effect["_encstr_AAB311207AB3D5630436EF9B27AD6025B7F238"] = loadfx("_encstr_968133C3CFC04F0B14B2F1C24F3A40EB1B7119138368709E15E2A75859088F13A1705F4BF312B945EFE8175398C36320B89A5B04A3");
  level._effect["_encstr_8BBB111B46E3DED1666370781BB1A95147FD9E"] = loadfx("_encstr_B43C3D83D1D83782B4797F771170EABFB8BB710B2930097A01EB773B1B0EF2A7D88130D941B8CD52E387B3332938AA2188492A515B58995ABD9BD35A455CB3");
  level._effect["_encstr_BD4D182A6395CFABB025AFB53119F57FBEB903C12B6DEF63D86F"] = loadfx("_encstr_9BC244FEB48A3E2497B29952D80F9E87C0274F765DD06F6E79A0817B48EF574E1B84E027E5F887B53B59FA3388BFCD2F13FD52AF8760FFBD1990A3B98831C6B30856861E14EA");
}