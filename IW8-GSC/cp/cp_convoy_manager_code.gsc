/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_convoy_manager_code.gsc
***********************************************/

spawn_convoy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  wait 0.05;

  if(!isDefined(level.vehicle_all_stop_func))
    level.vehicle_all_stop_func = ::stop_all_convoy_cars;

  var_8 = undefined;
  var_9 = undefined;

  if(isstruct(var_2)) {
    var_10 = strtok(var_2.targetname, "_encstr_BA4C02DF");
    var_10 = scripts\engine\utility::array_remove(var_10, var_10[0]);
    var_10 = scripts\engine\utility::array_remove(var_10, var_10[0]);
    var_11 = "_encstr_B40101";

    for(var_12 = 0; var_12 < var_10.size; var_12++) {
      if(var_12 > 0)
        var_11 = var_11 + "_encstr_BA4C02DF";

      var_11 = var_11 + var_10[var_12];
    }

    var_2 = var_11;
    var_13 = spawnStruct();
    var_13.targetname = "_encstr_BD550E72389DA3871A805B54A743D321" + var_2;
  } else {}

  var_8 = "_encstr_8BB710D077A60B1F2B61169FC6E355D1021F" + var_2;
  var_9 = scripts\engine\utility::getStruct(var_8, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_14 = scripts\engine\utility::getStruct("_encstr_BD550E72389DA3871A805B54A743D321" + var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_9)) {
    var_9 = spawnStruct();
    var_9.classname_mp = "_encstr_8F1F252BCBDD72E84D7E4E7BE1A95130C521D343A9DFBB539D23108F5DEB987808C68748EAF368";
    var_9.lookahead = 1;
    var_9.script_modelname = "_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382";
    var_9.speed = 30;
    var_9.targetname = var_8;
    var_9.origin = var_14.origin;
  }

  var_15 = spawnStruct();
  var_15.name = var_0;
  var_15.type = var_1;
  var_15.spawner = var_9;
  var_15.nodefaultweapon = 1;
  var_15.spawned_vehicles = [];
  var_15.alive_support_vehicles = 0;
  var_15.using_path = var_2;
  var_15.not_compromised = 1;
  var_15.backup_spawned = 0;
  var_15.amount_to_compromise_left = -1;
  var_15.team = scripts\engine\utility::ter_op(isDefined(var_6), var_6, "_encstr_8E8405EA382B2A");
  var_15.cp_speed = scripts\engine\utility::ter_op(isDefined(var_7), var_7, 300);

  if(isDefined(var_5))
    var_15.eventname = var_5;
  else
    var_15.eventname = "_encstr_B40101";

  var_15.targeted_hvt = undefined;
  var_15.settings = spawnStruct();
  var_15.settings.target = undefined;
  var_15.settings.can_steal_hvt = 1;
  var_15.settings.can_pickup_hvt = 1;
  var_15.settings.hide_icon_on_pickup = 0;
  var_15.settings.lookahead = -500;
  var_15.settings.unload_at_target = 0;
  var_15.settings.roaming = 0;
  var_15.settings.attach_icon = 0;
  var_15.settings.show_health = 0;
  var_15.settings._id_13898 = 0;
  var_15.settings.amount_to_compromise = -1;
  var_15.settings.center_compromises = 1;
  var_15.settings.can_compromise_before_first_target = 0;
  var_15.settings.health_drain = -1;
  var_15.settings.long_low_health = 0;
  var_15.settings.toggle_vo_on_hvt_pickup = 0;
  var_15.settings.toggle_vo_on_hvt_rescued = 0;
  var_15.settings.toggle_vo_on_convoy_death = 0;
  var_15.settings.toggle_vo_on_nearby_convoy = 0;
  var_15.settings.recruit_enable = 1;
  var_15.settings.recruit_juggs = 1;
  var_15.settings.recruit_time_between = 3;
  var_15.settings.recruit_time_until = 12;
  var_15.settings.recruit_amount = 5;
  var_15.settings.recruit_distance = 4000;
  var_15.settings.goal_distance = 1000;
  var_15.settings.pickup_uses_origin = 0;
  var_15.settings.defeated_on_kill_backup = 0;
  var_15.settings.backup_deposit_names = undefined;
  var_15.settings.route_to_any_veh = 1;
  var_15.settings.route_to_other_veh = 1;
  var_15.settings.route_to_other_support_veh = 1;
  var_15.settings.enable_stop_all_cars = 1;
  var_15.settings.path_jitter = undefined;
  var_15.settings.use_path_speeds = undefined;
  var_15.settings.despawn_dist = 7000;
  var_15.settings.despawn_dist_enable = 1;
  var_15.settings.distance_z = -1;
  var_15.settings.suspend_at_end_path = undefined;
  var_15.convoy_objectivestruct = var_3;
  level add_convoy_to_level(var_15);
  level thread scripts\cp\cp_vehicle_turretdrone::process_turret_sweep_nodes(var_15.using_path);
  level thread allow_soldiers_attempt_take_target(var_15);
  level spawn_convoy_from_type(var_15);
  var_15 thread waittillconvoydead();
  level thread waittill_return_to_truck(var_15.using_path, var_15);

  if(isDefined(var_4))
    level thread kill_convoy_all(var_15, var_4);

  var_15 notify("_encstr_8AD8152BD9B2CDE8AF36DBCD3BEDE5BE9B072CBBDCB223");
  level notify("_encstr_B17D13F86783D9EA48858BD8A3892F5A592C60DA7B");
  return var_15;
}

spawn_convoy_from_type(var_0) {
  if(!isDefined(var_0)) {
    var_1 = "_encstr_8BB710D077A60B1F2B61169FC6E355D1021F" + var_0.using_path;
    var_0 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  if(isDefined(getvehiclenode("_encstr_BD550E72389DA3871A805B54A743D321" + var_0.using_path, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")))
    var_2 = getvehiclenodearray("_encstr_BD550E72389DA3871A805B54A743D321" + var_0.using_path, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  else
    var_2 = scripts\engine\utility::getStructArray("_encstr_BD550E72389DA3871A805B54A743D321" + var_0.using_path, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_2.size > 1) {}

  var_3 = 1;

  if(isDefined(level.convoy_speed_override))
    var_3 = 30 / level.convoy_speed_override;

  switch (var_0.type) {
    case "_encstr_AB5E07609A5B7368E5":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 1, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 1, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_6 = thread create_convoy_truck(var_0, "_encstr_B87406412C6229ED", 0, undefined, 9, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_7 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 1, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_7.spawned_after_convoy_center = 1;
      var_8 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 1, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      var_0.vehicles_remaining = 5;
      break;
    case "_encstr_A7670FB5AC19B4AEDAD2C9DB856B5ACD3B":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_6 = thread create_convoy_truck(var_0, "_encstr_BAFE0DB5B54B1BDB6973B7A30B2707", 3, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_7 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_8 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      var_0.vehicles_remaining = 5;
      break;
    case "_encstr_A972062F7FDAF9B0":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_6 = thread create_convoy_truck(var_0, "_encstr_B87406412C6229ED", 0, undefined, 4, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      var_0.vehicles_remaining = 3;
      break;
    case "_encstr_8F480E406FB958091E5A0807F5324561":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 3, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_6 = thread create_convoy_truck(var_0, "_encstr_BAFE0DB5B54B1BDB6973B7A30B2707", 3, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 3, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      var_0.vehicles_remaining = 3;
      break;
    case "_encstr_AC08175707A281D8ED5A20F98581804CDED7C1F3CF9ADBF0FF":
      var_0.settings._id_13898 = 1;
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_6 = thread create_convoy_truck(var_0, "_encstr_BAFE0DB5B54B1BDB6973B7A30B2707", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      var_0.vehicles_remaining = 3;
      break;
    case "_encstr_9B0D15E65BC2B11BB43216379D2B279627ED58DA4B9BEC":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 3, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_6 = thread create_convoy_truck(var_0, "_encstr_BAFE0DB5B54B1BDB6973B7A30B2707", 3, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_ACE3106FA0F325F1B7FFB0018D518DD67FE2", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 3, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      var_0.vehicles_remaining = 3;
      break;
    case "_encstr_BDDC07EBCCB5CA4BED":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      var_0.vehicles_remaining = 1;
      break;
    case "_encstr_AA410D6ED2B9EC8DB296B2AD0E1DCB":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 0, "_encstr_B82406A33073460F", undefined, var_2[0]);
      var_0.vehicles_remaining = 1;
      break;
    case "_encstr_8B560D6EB1633139BF3E98A09215C7":
      var_6 = thread create_convoy_truck(var_0, "_encstr_BAFE0DB5B54B1BDB6973B7A30B2707", 3, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      var_0.vehicles_remaining = 1;
      break;
    case "_encstr_999E140339D2AF91B8F6C50772F46FBD0D7BA882F7EB":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      var_0.vehicles_remaining = 1;
      break;
    case "_encstr_8B041479C0E398F1F96E2B1D08688A4355ABFB8B0F5B":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      var_0.vehicles_remaining = 2;
      break;
    case "_encstr_95EB0DE5480F7BD8AB23F13BB6D01F":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      var_5.spawned_after_convoy_center = 1;
      var_0.vehicles_remaining = 2;
      break;
    case "_encstr_86B31448CBB411786F2D3DBD7B83C0635B03F0E0D28B":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_7 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 2, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", "_encstr_8E1A0BBD7BCD6F1F2BC8417A20", var_2[0]);
      var_7.spawned_after_convoy_center = 1;
      var_0.vehicles_remaining = 3;
      break;
    case "_encstr_8DF7110290D745CB2943949F575166DB4B28CA":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8C1904676089", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      var_0.vehicles_remaining = 1;
      break;
    case "_encstr_B4CA0E4917B2B3F0CF4F312BF6CFC873":
      var_6 = thread create_convoy_truck(var_0, "_encstr_B4750649E5A638C0", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 0, "_encstr_B82406A33073460F", undefined, var_2[0]);
      var_0.vehicles_remaining = 1;
      break;
    case "_encstr_A61D120825E030801BF56FA675C38B1039F870D5":
      var_3 = 0.95;
      var_4 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_7 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_8 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_9 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_10 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_11 = thread create_convoy_truck(var_0, "_encstr_8348061DACC643DE", 0, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      var_9.spawned_after_convoy_center = 1;
      var_10.spawned_after_convoy_center = 1;
      var_11.spawned_after_convoy_center = 1;
      var_0.vehicles_remaining = 7;
      break;
    case "_encstr_82AA138270283F92FD1393AFF713EA3D18D97A0F28":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8B070C8E956CD07BA58D0B9376F6", 5, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      var_0.vehicles_remaining = 1;
      break;
    case "_encstr_A1E31329FD0593ABAAB2B1B808B0652586365A9770":
      var_4 = thread create_convoy_truck(var_0, "_encstr_8B070C8E956CD07BA58D0B9376F6", 5, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      wait(randomfloatrange(2.75, 4.55) * var_3);
      var_5 = thread create_convoy_truck(var_0, "_encstr_8B070C8E956CD07BA58D0B9376F6", 5, "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93", 1, "_encstr_B82406A33073460F", undefined, var_2[0]);
      var_5.spawned_after_convoy_center = 1;
      var_0.vehicles_remaining = 2;
      break;
    default:
      break;
  }
}

create_convoy_truck(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0)) {
    return;
  }
  var_10 = undefined;

  switch (var_1) {
    case "_encstr_B4750649E5A638C0":
      var_10 = spawn_convoy_decho(var_0);
      break;
    case "_encstr_8B070C8E956CD07BA58D0B9376F6":
    case "_encstr_8348061DACC643DE":
      var_10 = spawn_convoy_truck(var_0);
      break;
    case "_encstr_844706EBB792B220":
    case "_encstr_8C1904676089":
      var_10 = spawn_convoy_apc(var_0);
      break;
    case "_encstr_B87406412C6229ED":
      var_10 = spawn_convoy_mkilo23(var_0);
      var_10.guys_assigned = 0;
      break;
    case "_encstr_BAFE0DB5B54B1BDB6973B7A30B2707":
      var_10 = spawn_convoy_mkilo23(var_0, 1);
      var_10.guys_assigned = 0;
      break;
    default:
      break;
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(istrue(var_0.settings._id_13898))
    var_10._id_13898 = 1;

  if(isDefined(var_0.main_truck) && var_10 != var_0.main_truck)
    var_10.spawned_after_convoy_center = 1;
  else
    var_10.spawned_after_convoy_center = 0;

  var_10 scripts\engine\utility::ent_flag_init("_encstr_A7010F14764BF3BF23A9CB4080D74A0D41");

  if(isDefined(var_2) && var_2 > 0) {
    if(isDefined(var_3))
      var_0.spawner.script_noteworthy = var_3;
    else
      var_0.spawner.script_noteworthy = "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93";

    if(var_1 == "_encstr_8348061DACC643DE")
      var_10 thread trial_start_time(var_0);
    else if(var_1 == "_encstr_8B070C8E956CD07BA58D0B9376F6")
      var_10 thread trial_stat_row();

    level thread _id_135DA(var_10, var_2, var_0);
  }

  thread killoff_vis_passed(var_10);

  if(isDefined(var_4) && var_4 > 0) {
    var_11 = "_encstr_B40101";

    switch (var_1) {
      case "_encstr_8B070C8E956CD07BA58D0B9376F6":
      case "_encstr_8348061DACC643DE":
        var_11 = "_encstr_96EC0BA32B8D1AB7D70E8697E6";
        break;
      case "_encstr_BAFE0DB5B54B1BDB6973B7A30B2707":
      case "_encstr_B87406412C6229ED":
        var_11 = "_encstr_BD8411B5DAD28DF61999AF0B2DD7D2DC33B41B";
        break;
    }

    level thread scripts\cp\cp_vehicles::_id_135CB(var_10, var_11);
    var_10 scripts\engine\utility::ent_flag_set("_encstr_A7010F14764BF3BF23A9CB4080D74A0D41");
    level thread wait_to_deposit_driver(var_0);
  }

  if(isDefined(var_7))
    thread trial_retrieve_persistent_values(var_10, var_7, var_0);

  var_10.measure_origin = var_10.origin;

  if(!isDefined(var_0.using_path))
    return;
  else
    var_10 thread convoy_vehicle_monitor(var_0.using_path, var_0);

  if(isDefined(var_6) && var_6 != "_encstr_B40101")
    var_10 thread _id_135E2(var_10);

  return var_10;
}

_id_135E2(var_0) {
  var_0.computerscriptable = 1;
  var_0.zombiejumping = [];
  var_1 = (-62, 0, 45);
  var_2 = level scripts\cp\cp_vehicles::spawn_ai_in_truck(var_0, 1, undefined, 0, undefined, "_encstr_975F0A8AFB473F790F1F0BF0", 5);

  if(isDefined(var_2) && var_2.size > 0) {
    var_2[0].equip_armor = 1;
    var_2[0].equip_helmet = 1;
    var_2[0].maxhealth = 600;
    var_2[0].health = 600;
    var_2[0].i_see_laststand_player_watcher = 1;
    var_0.zombiejumping[0] = var_2[0];
  }

  var_3 = (-92, 0, 60);
  var_4 = level scripts\cp\cp_vehicles::spawn_ai_in_truck(var_0, 1, undefined, 0, undefined, "_encstr_975F0A8AFB473F790F1F0BF0", 6);

  if(isDefined(var_4) && var_4.size > 0) {
    var_4[0].equip_armor = 1;
    var_4[0].equip_helmet = 1;
    var_4[0].maxhealth = 600;
    var_4[0].health = 600;
    var_4[0].i_see_laststand_player_watcher = 1;
    var_0.zombiejumping[1] = var_4[0];
  }

  wait 5;
  var_0.computerscriptable = undefined;
}

_id_135DA(var_0, var_1, var_2) {
  level thread scripts\cp\cp_vehicles::spawn_ai_in_truck(var_0, var_1, var_2.spawner, 0, undefined);
}

trial_start_time(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  if(self.type != "_encstr_8348061DACC643DE") {
    return;
  }
  self waittill("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
  var_1 = "_encstr_B6AB0A59CD3AD29356B18589";

  if(isDefined(var_0) && isDefined(var_0.settings._id_13F14))
    var_1 = var_0.settings._id_13F14;

  scripts\common\vehicle::vehicle_unload(var_1);
}

trial_stat_row() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  if(self.type != "_encstr_8B070C8E956CD07BA58D0B9376F6") {
    return;
  }
  self waittill("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
  level scripts\cp\cp_vehicles::lastteamused(self);
  scripts\common\vehicle::vehicle_unload("_encstr_8B1608EC43B8D647A113");
}

wait_to_deposit_driver(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  var_0 waittill("_encstr_AA0117D053B4796F8B1D1085F7A347E3E9A399708B59D3C3D3");

  for(var_1 = 0; var_1 < var_0.spawned_vehicles.size; var_1++) {
    if(isDefined(var_0.spawned_vehicles[var_1]) && isalive(var_0.spawned_vehicles[var_1]))
      var_0.spawned_vehicles[var_1] thread scripts\cp\cp_vehicles::deposit_ai_from_drones_in_vehicle(1, 0);
  }
}

killoff_vis_passed(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 15;
  var_0.nav_obstacle = createnavrepulsor("_encstr_A6420BC2D2D7CEAC43A5B1B1CA", 0, var_0, 150, 1);
}

trial_retrieve_persistent_values(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(level.convoy_speed_override))
    var_0.speed_override = level.convoy_speed_override;
  else
    var_0.speed_override = 30;

  var_3 = var_1;
  var_0.pathing_array = [];
  var_0.pathing_array[var_0.pathing_array.size] = var_1;

  for(var_3.pathing_index = var_0.pathing_array.size; isDefined(var_3) && isDefined(var_3.target); var_0.pathing_array[var_0.pathing_array.size] = var_3) {
    var_3 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3.pathing_index = var_0.pathing_array.size;
  }

  if(var_0.pathing_array.size > 27)
    var_0 scripts\cp\cp_vehicles::split_large_pathing_array();

  if(isDefined(level.convoy_path_jitter) && level.convoy_path_jitter > 0)
    var_2.settings.path_jitter = level.convoy_path_jitter;

  if(!isDefined(var_0.pathing_arrays))
    var_4 = var_0.pathing_array;
  else
    var_4 = var_0.pathing_arrays;

  var_0 thread scripts\cp\cp_vehicles::vehiclefollowstructpath(var_4);
  var_0 thread intro_stop_car_if_too_close(var_0, var_2);
}

intro_stop_car_if_too_close(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
  var_2 = 650;
  var_3 = var_2 * var_2;

  if(istrue(var_0.spawned_after_convoy_center)) {
    for(;;) {
      if(isent(var_1.main_truck) && isent(var_0)) {
        if(distancesquared(var_1.main_truck.origin, var_0.origin) < var_3) {
          var_0 vehicle_setspeed(0, 70, 70);
          var_0 notify("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
        }
      }

      wait 0.25;
    }
  }
}

add_convoy_to_level(var_0) {
  if(!isDefined(level.all_convoys))
    level.all_convoys = [];

  if(isDefined(level.all_convoys[var_0.name])) {
    level thread kill_convoy_all(level.all_convoys[var_0.name], 0);
    wait 0.05;
  }

  level.all_convoys[var_0.name] = var_0;
}

remove_convoy_from_level(var_0) {
  if(!isDefined(level.all_convoys)) {
    return;
  }
  if(!isDefined(level.all_convoys[var_0.name])) {
    return;
  }
  if(isDefined(var_0.saved_struct_paths)) {
    var_1 = var_0.saved_struct_paths.size;

    for(var_2 = 0; var_2 < var_1; var_2++) {
      scripts\engine\utility::deletestruct_ref(var_0.saved_struct_paths[var_2]);
      var_0.saved_struct_paths[var_2] = undefined;
    }
  }

  var_0 notify("_encstr_8DA60E3357366397BE27B2DABDECB28C");
  level.all_convoys = scripts\engine\utility::array_remove(level.all_convoys, level.all_convoys[var_0.name]);

  if(isDefined(isDefined(level.all_convoys[var_0.name])))
    level.all_convoys[var_0.name] = undefined;
}

change_convoy_objective_target(var_0, var_1, var_2, var_3) {
  self.settings.target = var_0;

  if(istrue(var_2)) {
    if(istrue(self.settings.unload_at_target)) {
      foreach(var_5 in self.spawned_vehicles) {
        if(isalive(var_5)) {
          if(isDefined(level.vehicle_all_stop_func))
            var_5[[level.vehicle_all_stop_func]](0);

          var_5 notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC");
        }
      }
    }

    return;
  }

  if(istrue(var_3)) {
    return;
  }
  var_7 = 1000;
  var_8 = var_7 * var_7;

  foreach(var_5 in self.spawned_vehicles) {
    if(isalive(var_5)) {
      var_5.path_gobbler = 1;

      if(isstring(var_0)) {
        var_10 = var_0;
        var_0 = scripts\engine\utility::getent_or_struct(var_10, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;

        if(!isDefined(var_0))
          var_0 = scripts\engine\utility::getent_or_struct(var_10, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
      } else if(!isvector(var_0) && isDefined(var_0.origin))
        var_0 = var_0.origin;

      var_11 = 60;
      var_12 = "_encstr_BD8411B5DAD28DF61999AF0B2DD7D2DC33B41B";
      var_13 = level.ai_spawn_vehicle_func[var_12].path_start_points;

      if(isDefined(self.convoy_paths_override))
        var_13 = self.convoy_paths_override;

      var_14 = scripts\engine\utility::getStructArray(var_13, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(!isDefined(var_14) || var_14.size == 0) {
        return;
      }
      if(isDefined(var_5.pathing_array)) {
        foreach(var_16 in var_5.pathing_array)
        level notify("_encstr_91140CAD2D8DC6BE919589D5D9EB" + var_16.pathing_index);
      }

      if(isDefined(var_5.pathing_arrays))
        var_5.pathing_arrays = undefined;

      var_18 = undefined;
      var_19 = scripts\engine\utility::getclosest(var_5.origin, var_14);

      if(!var_5 is_struct_in_front_of_me(var_19)) {
        var_20 = var_19 scripts\cp\cp_vehicles::get_veh_linked_structs();

        for(var_21 = 0; var_21 < var_20.size; var_21++) {
          if(var_5 is_struct_in_front_of_me(var_20[var_21])) {
            var_18 = var_20[var_21];
            break;
          }
        }

        if(!isDefined(var_18)) {
          for(var_21 = 0; var_21 < var_20.size; var_21++) {
            var_22 = var_20[var_21] scripts\cp\cp_vehicles::get_veh_linked_structs();

            for(var_23 = 0; var_23 < var_22.size; var_23++) {
              if(var_5 is_struct_in_front_of_me(var_22[var_23])) {
                var_18 = var_22[var_23];
                break;
              }
            }
          }
        }

        if(isDefined(var_18))
          var_19 = var_18;
      }

      var_24 = scripts\engine\utility::getclosest(var_0, var_14);

      if(distance2dsquared(var_5.origin, var_24.origin) < var_8) {
        break;
      }

      var_5 notify("_encstr_8C9E0BD847079DA879ABD879E1");
      var_25 = scripts\cp\cp_vehicles::duplicate_struct(var_19);
      var_25.speed = var_11;
      var_25.angles = vectortoangles(var_25.origin - var_5.origin);
      scripts\cp\cp_vehicles::add_targetname_kvps(var_25, undefined, var_12 + 0 + "_encstr_879E0E19A1B0A6A3084BCF674927ABF4");
      add_to_convoy_structs(var_25);
      var_26 = scripts\cp\cp_vehicles::duplicate_struct(var_24);
      var_26.speed = var_11;
      var_26.script_pathtype = "_encstr_81A8077D3088BFA631";
      scripts\cp\cp_vehicles::add_targetname_kvps(var_26, undefined, var_12 + 0 + "_encstr_95280C6987E27396C0A3311FD8EF");
      add_to_convoy_structs(var_26);
      var_27 = [];

      if(isDefined(var_1) && var_1.size > 0) {
        for(var_21 = 0; var_21 < var_1.size; var_21++) {
          var_28 = var_1[var_21];

          if(isstruct(var_1[var_21]))
            var_28 = var_1[var_21].origin;

          var_29 = scripts\engine\utility::getclosest(var_28, var_14);
          var_30 = scripts\cp\cp_vehicles::duplicate_struct(var_29);
          var_30.speed = var_11;
          scripts\cp\cp_vehicles::add_targetname_kvps(var_29, undefined, var_12 + 0 + "_encstr_95730D7EA22FB8385DF9C7B51C8320");
          add_to_convoy_structs(var_30);
          var_27[var_27.size] = var_29;
        }
      }

      follow_path_from_grid(var_5, var_25, var_26, var_27, var_14);
      wait 2.0;
    }
  }
}

is_struct_in_front_of_me(var_0) {
  var_1 = vectordot(self.angles, vectorNormalize(var_0.origin - self.origin));
  return var_1 > 0;
}

add_to_convoy_structs(var_0) {
  if(!isDefined(self.saved_struct_paths))
    self.saved_struct_paths = [];

  if(isDefined(var_0) && isstruct(var_0))
    self.saved_struct_paths[self.saved_struct_paths.size] = var_0;
}

handle_set_speed_to_goal(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  self.disable_set_speed = 1;
  var_2 = getdvarint("_encstr_ADDA19BF3BCAA9FD9312F0BBD9AFA078639F136FB3B2B035E30B4B", 0);

  if(var_2 == 0) {
    return;
  }
  if(var_2 > 400)
    var_2 = 400;

  var_3 = scripts\cp\cp_vehicles::getvehiclepath("_encstr_BD550E72389DA3871A805B54A743D321" + var_0);

  while(isDefined(var_3.target)) {
    var_3 = scripts\cp\cp_vehicles::getvehiclepath(var_3.target);
    var_3 waittill("_encstr_8F5C086405E70FBA4B4A");

    if(var_3.speed > 15)
      self vehicle_setspeedimmediate(var_2, 15, 15);

    if(isDefined(var_3.script_pathtype) && var_3.script_pathtype == "_encstr_81A1106F279A6308B301B6C1B88C9D2814C2") {
      self vehicle_setspeedimmediate(15, 350, 350);
      wait 5;
      return;
    }
  }
}

follow_path_from_grid(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");

  if(!isDefined(level.convoy_path_number))
    level.convoy_path_number = 0;

  var_0.pathing_array = undefined;
  var_0.veh_path = [];

  if(isDefined(var_3) && var_3.size > 0) {
    var_5 = [];
    var_5[0] = var_1;

    foreach(var_7 in var_3)
    var_5[var_5.size] = var_7;

    var_5[var_5.size] = var_2;

    for(var_9 = 0; var_9 < var_5.size; var_9++) {
      if(!isDefined(var_5[var_9 + 1])) {
        break;
      }

      var_10 = var_5[var_9];
      var_11 = undefined;

      if(isDefined(var_10)) {
        var_12 = var_10 scripts\cp\cp_vehicles::get_veh_linked_structs();
        var_13 = -5;

        foreach(var_15 in var_12) {
          var_16 = scripts\engine\math::get_dot(var_0.origin, var_0.angles, var_15.origin);
          var_17 = scripts\engine\math::get_dot(var_0.origin, vectortoangles(var_10.origin - var_0.origin), var_15.origin);
          var_18 = var_16 + var_17;

          if(var_18 > var_13) {
            var_13 = var_18;
            var_11 = var_15;
          }
        }
      }

      if(!isDefined(var_11))
        var_11 = scripts\engine\utility::getclosest(var_0.origin, var_4);

      var_0 scripts\cp\cp_vehicles::create_path_from_struct_to_struct(var_11, var_5[var_9 + 1], level.convoy_path_number, "_encstr_BD8411B5DAD28DF61999AF0B2DD7D2DC33B41B", "_encstr_917E18B87BA7D0CDFDBBC990A2558749E3DFB72FC463F83527E1", (1, 1, 1));
      var_0 scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", scripts\cp\cp_vehicles::reset_spawn_point_targetname, undefined, undefined, var_0);
      level.convoy_path_number++;
      var_20 = 1;

      if(var_5[var_9 + 1] == var_2)
        var_20 = 0;

      self.settings.unload_at_target = !var_20;
      var_0 scripts\cp\cp_vehicles::vehiclefollowstructpath(var_0.pathing_array[0]);
    }
  } else {
    var_21 = var_0.vehicletype;
    var_0 scripts\cp\cp_vehicles::create_path_from_struct_to_struct(var_1, var_2, level.convoy_path_number, var_21, "_encstr_917E18B87BA7D0CDFDBBC990A2558749E3DFB72FC463F83527E1", (1, 1, 1));
    var_0 scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", scripts\cp\cp_vehicles::reset_spawn_point_targetname, undefined, undefined, var_0);
    var_0 thread scripts\cp\cp_vehicles::vehiclefollowstructpath(var_0.pathing_array[0]);
    level.convoy_path_number++;
  }
}

allow_soldiers_attempt_take_target(var_0) {
  scripts\engine\utility::waittill_any_ents(level, "_encstr_A7731DEF08E01F03C7CE5D15AC7F3BE7ABA8536348B95A0BEF5D260A1C03A3", var_0, "_encstr_B44117C6F0686EE2B3B787331553BBB5E05EFE8B6E50057B0D");
  level thread attempt_new_pulse_set(var_0);
}

attempt_new_pulse_set(var_0) {
  if(istrue(var_0.settings.recruit_enable))
    var_0 thread pulse_soldiers_to_help_convoy();
}

set_roaming() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8C9E0BD847079DA879ABD879E1");
  var_0 = undefined;
  var_1 = 192;
  var_2 = var_1 * var_1;
  var_3 = 10000;
  var_4 = var_3 * var_3;
  var_5 = 1;
  var_6 = "_encstr_BD8411B5DAD28DF61999AF0B2DD7D2DC33B41B";
  var_7 = undefined;

  for(var_8 = 0; var_8 < self.spawned_vehicles.size; var_8++) {
    if(isDefined(self.spawned_vehicles[var_8]) && isalive(self.spawned_vehicles[var_8])) {
      var_7 = self.spawned_vehicles[var_8];
      break;
    }
  }

  var_7 endon("_encstr_AD75063D571AE108");
  var_9 = 0.1;

  for(;;) {
    if(var_5 == 1) {
      var_10 = level.ai_spawn_vehicle_func[var_6].path_start_points;

      if(isDefined(self.convoy_paths_override))
        var_10 = self.convoy_paths_override;

      var_11 = scripts\engine\utility::getStructArray(var_10, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      for(var_8 = 0; var_8 < var_11.size; var_8++) {
        var_12 = var_11[var_8] scripts\cp\cp_vehicles::get_veh_linked_structs();
        var_13 = var_12.size;

        if(var_13 < 2)
          var_11 = scripts\engine\utility::array_remove(var_11, var_11[var_8]);
      }

      var_11 = sortbydistance(var_11, var_7.origin);
      var_14 = [];
      var_15 = int(var_11.size * 0.66);

      for(var_8 = 0; var_8 < var_11.size; var_8++) {
        if(var_8 >= var_15)
          var_14[var_14.size] = var_11[var_8];
      }

      if(var_14.size == 0)
        var_14[var_14.size] = var_11[var_8];

      var_0 = scripts\engine\utility::random(var_14);

      if(!isDefined(var_0.origin)) {}

      change_convoy_objective_target(var_0.origin);
      var_5 = 0;
    }

    if(distance2dsquared(var_7.origin, var_0.origin) > var_4)
      var_9 = 1;
    else if(distance2dsquared(var_7.origin, var_0.origin) > var_2)
      var_9 = 0.1;
    else if(distance2dsquared(var_7.origin, var_0.origin) < var_2)
      var_5 = 1;

    wait(var_9);
  }
}

debug_draw_until_newpath(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 notify("_encstr_AAAC19C81982BB895F2B23DB97614D4B7C5F05B0A82A5798E3A8C0");
  var_1 endon("_encstr_AAAC19C81982BB895F2B23DB97614D4B7C5F05B0A82A5798E3A8C0");

  for(;;) {
    level thread scripts\engine\utility::draw_capsule(var_0.origin, 128, 2000, undefined, (1, 0, 1), undefined, 1);
    waitframe();
  }
}

toggle_trucks_disable_leave(var_0) {
  foreach(var_2 in self.spawned_vehicles) {
    if(isent(var_2)) {
      var_2.disable_leave_truck = var_0;

      if(istrue(var_0))
        var_2 notify("_encstr_965214322D9BB031C62BBE1B9558672BBE1D9C57365B");
    }
  }
}

spawn_convoy_truck(var_0) {
  var_1 = var_0.spawner;

  if(isDefined(getvehiclenode("_encstr_AF7A17E05F465432A26792E4A7E87C01C03880E01C1D639DE2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"))) {
    var_1.vehicletype = "_encstr_ADA706A3E4BA1BB6";
    var_1.script_modelname = "_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382";
  } else {
    var_1.vehicletype = "_encstr_AB560E05670AE9D86FEB60D0DF619117";
    var_1.script_modelname = "_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382";
  }

  var_1.classname_mp = "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98";
  var_1.script_team = "_encstr_8E8405EA382B2A";

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  var_2 = scripts\common\vehicle::vehicle_spawn(var_1);
  var_2.vehicle_skipdeathmodel = 1;
  var_2.death_fx_on_self = 1;
  var_2.disable_leave_truck = 1;
  var_2 setvehicleteam("_encstr_8E8405EA382B2A");
  var_2.orig_health = var_2.health;
  var_2.type = "_encstr_8348061DACC643DE";
  var_2.riders = [];
  var_0.alive_support_vehicles++;
  var_0.spawned_vehicles[var_0.spawned_vehicles.size] = var_2;
  var_2.spawner = var_1;
  var_2.convoy = var_0;
  return var_2;
}

spawn_convoy_decho(var_0) {
  if(!isDefined(var_0.team))
    var_0.team = "_encstr_8E8405EA382B2A";

  var_1 = var_0.spawner;
  var_1.vehicletype = "_encstr_AB560E05670AE9D86FEB60D0DF619117";
  var_1.script_modelname = "_encstr_A5491B5415D372C7A61238695A3D79565BBD56C367672391085BC88083";
  var_1.classname_mp = "_encstr_8F1F252BCBDD72E84D7E4E7BE1A95130C521D343A9DFBB539D23108F5DEB987808C68748EAF368";
  var_1.script_team = var_0.team;

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  var_2 = scripts\common\vehicle::vehicle_spawn(var_1);
  var_2.vehicle_skipdeathmodel = 1;
  var_2.death_fx_on_self = 1;
  var_2.disable_leave_truck = 1;
  var_2 setvehicleteam("_encstr_8E8405EA382B2A");
  var_2.orig_health = var_2.health;
  var_2.type = "_encstr_B4750649E5A638C0";
  var_2.riders = [];
  var_0.alive_support_vehicles++;
  var_0.spawned_vehicles[var_0.spawned_vehicles.size] = var_2;
  var_2.spawner = var_1;
  var_2.convoy = var_0;
  return var_2;
}

spawn_convoy_apc(var_0) {
  if(!isDefined(var_0.team))
    var_0.team = "_encstr_8E8405EA382B2A";

  var_1 = var_0.team;
  var_2 = var_0.spawner;
  var_2.vehicletype = "_encstr_8E641237209F30ECB721BBC83323E2A7AFD7956F";
  var_2.script_modelname = "_encstr_96621FDE15A8424943D84A7118AD7F272305514EBC1097CA1160A3EA78AFF9A7FB";
  var_2.classname_mp = "_encstr_8C1904676089";
  var_2.targetname = "_encstr_8C1904676089";
  var_2.script_team = var_1;

  if(!isDefined(var_2.angles))
    var_2.angles = (0, 0, 0);

  var_3 = scripts\common\vehicle::vehicle_spawn(var_2);
  var_3.vehicle_skipdeathmodel = 1;
  var_3.death_fx_on_self = 1;
  var_3 setCanDamage(0);
  var_3 setvehicleteam(var_1);
  var_3.script_team = var_1;
  var_3.orig_health = var_3.health * 2;
  var_3.type = "_encstr_8C1904676089";
  var_3.riders = [];
  var_3.cp_speed = scripts\engine\utility::ter_op(isDefined(var_0.cp_speed), var_0.cp_speed, 300);
  var_0.main_truck = var_3;
  var_0.spawned_vehicles[var_0.spawned_vehicles.size] = var_3;
  var_3.spawner = var_2;
  var_3.convoy = var_0;
  return var_3;
}

spawn_convoy_mkilo23(var_0, var_1) {
  var_2 = var_0.spawner;
  var_2.vehicletype = "_encstr_B87B11439AA9512A79A760E17BE35A272F677A";
  var_2.script_modelname = "_encstr_A27620B3B21A077DAD5AC6AF1B3719FADADAA563DB2399AF07A15E37D2B1E6F56B07";
  var_2.classname_mp = "_encstr_AD6C2DB9D8274B07E8BED9B24370D7B696B1F5B1B923AFB66DD28D7B19CC7D1C0D2FE6D2C6B97DB05AAFB4CDCC96B1";
  var_2.script_team = "_encstr_8E8405EA382B2A";

  if(!isDefined(var_2.angles))
    var_2.angles = (0, 0, 0);

  var_3 = scripts\common\vehicle::vehicle_spawn(var_2);
  var_3.vehicle_skipdeathmodel = 1;
  var_3.death_fx_on_self = 1;
  var_3 setCanDamage(1);
  var_3 setvehicleteam("_encstr_8E8405EA382B2A");
  var_3.script_team = "_encstr_8E8405EA382B2A";
  var_3.orig_health = var_3.health;
  var_3.disable_leave_truck = 1;

  if(!istrue(var_1))
    var_3.tarp = var_3 thread scripts\cp\vehicles\vehicle_cp::spawn_vehicle_accessory("_encstr_82181A1477AA59CE4DBF70F1B396615F021C03914DA717B63CB78880", undefined, undefined, (0, 0, 0));
  else
    var_0.no_tarp = 1;

  var_4 = 500;
  var_5 = 26.6;
  add_wheel_tag(var_3, "_encstr_822E1C35718FFEF704722B50C99E9B90BB1DBE38CE73203DEBF940103273", var_4, var_5);
  add_wheel_tag(var_3, "_encstr_84311D85A15F2E27D482F080192ECBC0CB4D0EE83EA3904DBB4940A07204D1", var_4, var_5);
  add_wheel_tag(var_3, "_encstr_B6271D4758D9D7771A56598DFA1BB2E6E8CAC9D7AD9623321B957DD8B2331D", var_4, var_5);
  add_wheel_tag(var_3, "_encstr_91F81E3A859DFABB862B9563EB1B593747AC39F5ADB423C88DCABE9CD23BD08E", var_4, var_5);
  add_wheel_tag(var_3, "_encstr_95401B1D2C9DFA77D02B59C6D7C6B2DCE82B397D312C36ADAF8DB2CC47", var_4, var_5);
  add_wheel_tag(var_3, "_encstr_B8C91CC3D3BCF97F4051AFF50EC0B5228D6353F7BDD7622BD15BA43FC010", var_4, var_5);
  var_3.type = "_encstr_B87406412C6229ED";
  var_3.riders = [];
  var_0.main_truck = var_3;
  var_0.spawned_vehicles[var_0.spawned_vehicles.size] = var_3;
  var_3.spawner = var_2;
  var_3.convoy = var_0;
  var_3 thread is_ascender_use_allowed();
  return var_3;
}

is_ascender_use_allowed() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.convoy endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  self endon("_encstr_AD75063D571AE108");
  var_0 = undefined;
  var_1 = 40000;
  var_2 = 2;
  wait 10;

  for(;;) {
    var_0 = vehicle_getarray();
    var_2 = 2;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!isDefined(var_0[var_3].convoy) && istrue(var_0[var_3].isempty) && isDefined(var_0[var_3].team) && var_0[var_3].team != "_encstr_8E8405EA382B2A" && isent(var_0[var_3]) && isDefined(var_0[var_3].vehiclename) && var_0[var_3].vehiclename == "_encstr_8C190467402B" && self != var_0[var_3] && !var_0[var_3] issuspendedvehicle()) {
        var_4 = self gettagorigin("_encstr_91CF1653C6DFF98A38B418500F6DABDDFD33261D9F975434");

        if(distancesquared(var_4, var_0[var_3].origin) < var_1) {
          var_0[var_3] dodamage(90, self.origin);
          var_2 = 0.5;
        }
      }
    }

    wait(var_2);
  }
}

convoy_vehicle_monitor(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread handle_set_speed_to_goal(var_0, var_1);
  self.damage_functions[0] = ::convoy_damage_monitor;
  thread waittilldeath();
  thread waittillarriveatdestination(var_0, var_1);
  thread waittillcompromised(var_0, var_1);
  thread waittillhealthlow(var_0);
  thread waittilltoofarz();
}

convoy_damage_monitor(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;

  if(!isDefined(self.team))
    self.team = "_encstr_8E8405EA382B2A";

  if(!isPlayer(var_1)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner) && isexplosivedamagemod(var_4) && self.health > self.healthbuffer) {
      if(self.type == "_encstr_B87406412C6229ED")
        apply_truck_dmg(var_0, 1, 0.7, var_4);

      var_1.owner scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_BD0F0DA49018CCA2987F27534B305B", 0, var_0, 1, 0);
      var_1.owner playlocalsound("_encstr_A24818AF17AF6B6019273858A368A69FEB700F3009FA52A5A8CA");
    }

    return;
  }

  if(self.type == "_encstr_B87406412C6229ED") {
    if(!isDefined(self.is_correct_wire_color_sync))
      self.is_correct_wire_color_sync = 0.03;

    if(self.health > self.healthbuffer) {
      var_1 scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_BD0F0DA49018CCA2987F27534B305B", 0, var_0, 0, 0);
      var_1 playlocalsound("_encstr_A24818AF17AF6B6019273858A368A69FEB700F3009FA52A5A8CA");
    }

    if(!isexplosivedamagemod(var_4))
      apply_truck_dmg(var_0, 1, 0.95, var_4);
    else
      apply_truck_dmg(var_0, 0, 0.6, var_4);
  } else {
    if(self.health > self.healthbuffer)
      var_1 scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_8CA60B7260BB860F1FF9D83F35", 0, var_0, 0, 0);

    if(isexplosivedamagemod(var_4))
      apply_truck_dmg(var_0, 0, 1.8, var_4);
    else
      apply_truck_dmg(var_0, 1, 0.55, var_4);
  }

  foreach(var_12 in self.riders) {
    if(isalive(var_12)) {
      if(isDefined(var_1) && isPlayer(var_1))
        var_12 getenemyinfo(var_1);
    }
  }

  if(self.health < self.healthbuffer)
    var_1 scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_8CA60B7260BB860F1FF9D83F35", 0, var_0, 0, 0);
}

apply_truck_dmg(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && var_3 == "_encstr_AB590C99ED78875F650F3951034D") {
    return;
  }
  if(istrue(self.draining_health))
    self.health = self.health + var_0;
  else {
    if(!istrue(self.hull_invulnerable)) {
      if(istrue(var_1)) {
        self.health = self.health + int(var_0 * var_2);
        return;
      }

      self.health = self.health - int(var_0 * var_2);
      return;
      return;
    }

    self.health = self.orig_health;
  }
}

add_wheel_tag(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_1)) {
    if(!isDefined(var_0.wheel_tags))
      var_0.wheel_tags = [];

    if(!isDefined(var_2))
      var_2 = 500;

    if(!isDefined(var_3))
      var_3 = 60;

    if(!isDefined(var_4))
      var_4 = "_encstr_B8331DD0FD200F1F2E24FE699488E21078951EB37F713FE91D37D24E6AA288";

    var_5 = spawnStruct();
    var_5.tag = var_1;
    var_5.health = var_2;
    var_5.radius = var_3;
    var_5.model = var_4;
    var_5.orientation = "_encstr_8253060E2B5FE330";
    var_6 = strtok(var_1, "_encstr_BA4C02DF");

    foreach(var_8 in var_6) {
      if(var_8 == "_encstr_A5AD056A019C63")
        var_5.orientation = "_encstr_A5AD056A019C63";
    }

    var_0.wheel_tags[var_0.wheel_tags.size] = var_5;
  }
}

init_tire_outlines(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.wheel_tags) || var_0.wheel_tags.size == 0) {
    return;
  }
  level thread barrel_setup_anims();

  for(var_1 = 0; var_1 < var_0.wheel_tags.size; var_1++) {
    var_2 = var_0.wheel_tags[var_1];
    var_2.model_created = spawn_wheel_outline_model(var_0, var_2);
    var_2.collision_created = spawn_wheel_collision(var_0, var_2);
    var_2.collision_created thread track_tire_damage(var_0, var_2);
  }
}

spawn_wheel_outline_model(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin(var_1.tag));
  var_2.angles = var_0.angles;
  var_2 setModel(var_1.model);
  var_2 notsolid();
  var_2 show();
  var_2.owner = var_0;
  var_3 = -8;
  var_4 = 180;

  if(var_1.orientation == "_encstr_A5AD056A019C63") {
    var_3 = var_3 * -1;
    var_4 = 0;
  }

  var_2 linkTo(var_0, var_1.tag, (0, var_3, 0), (0, var_4, 0));
  return var_2;
}

spawn_wheel_collision(var_0, var_1) {
  level.obj_overwatch_coll_type = 0;

  if(!isDefined(level.taccoverbulletcollision)) {
    var_2 = getEntArray("_encstr_B4D51A3A166C3AB4C62C63FA1BBDCE9593BEC4AB1B8DACD1AF8DEDD8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_2)) {
      level.taccoverbulletcollision = var_2[0];
      level.obj_overwatch_coll_type = 1;
    }
  }

  if(!isDefined(level.taccoverbulletcollision)) {
    var_2 = getEntArray("_encstr_A2B10E0E63C2CB954E338C0F66C81EC1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_2)) {
      level.taccoverbulletcollision = var_2[0];
      level.obj_overwatch_coll_type = 2;
    }
  }

  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin(var_1.tag));
  var_3 dontinterpolate();
  var_3.angles = var_0.angles;
  var_3.owner = var_0;
  var_3.maxhealth = 999999;
  var_3.health = 500;
  var_3.team = var_0.script_team;
  var_3 setCanDamage(1);
  var_3 clonebrushmodeltoscriptmodel(level.taccoverbulletcollision);
  var_4 = -10;

  if(var_1.orientation == "_encstr_A5AD056A019C63")
    var_4 = var_4 * -1;

  var_5 = (0, 90, 0);

  if(level.obj_overwatch_coll_type == 2)
    var_5 = (90, 90, 0);

  var_3 linkTo(var_0, var_1.tag, (0, var_4, 5), var_5);
  return var_3;
}

track_tire_damage(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = var_1.collision_created;

  while(var_2.health > 0) {
    var_2 waittill("_encstr_B2BE0788BAF573592F", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(!isPlayer(var_4)) {
      if(isDefined(var_4.owner) && isPlayer(var_4.owner) && isexplosivedamagemod(var_7)) {
        var_2.health = var_2.health + int(var_3 * 0.99);
        var_2 thread blink_tire_outline(var_1);
      } else
        var_2.health = var_2.health + int(var_3);

      continue;
    }

    if(isexplosivedamagemod(var_7)) {
      var_2 dodamage(var_3 * 0.88, var_6, var_4);
      var_2 thread blink_tire_outline(var_1);
      continue;
    }

    var_2.health = var_2.health + int(var_3 * 0.7);
    var_2 thread blink_tire_outline(var_1);
  }

  var_2 delete();
  level thread toggle_tire_outlines(var_0, var_1);
  var_0.convoy notify("_encstr_ADB413354F5A6BF884B71E70DD63B88843E39BABC3");
  var_0 notify("_encstr_8DB90B12386E0B095839959DD9");
  var_1 notify("_encstr_96AF0C7FCB02A109392913327748");

  if(soundexists("_encstr_AA84191EFD527731C70F18A8C311E993B96713271509019BA11308"))
    var_1.model_created playsoundonmovingent("_encstr_AA84191EFD527731C70F18A8C311E993B96713271509019BA11308");

  if(isDefined(var_1.orientation)) {
    if(var_1.orientation == "_encstr_A5AD056A019C63")
      playFXOnTag(scripts\engine\utility::getfx("_encstr_AF0F1CBCEE6B664B4C0AC0D041A31B9B77AF4D335083A8913771F898AAFB"), var_0, var_1.tag);
    else
      playFXOnTag(scripts\engine\utility::getfx("_encstr_820F1D7B6C286FFA4B84C0D79EE0B03335E11290B03B6044C58813415A3C53"), var_0, var_1.tag);
  }
}

blink_tire_outline(var_0) {
  var_0 notify("_encstr_8F0C0E13D85A736DAFF6D51DB15A9B56");
  var_0 endon("_encstr_8F0C0E13D85A736DAFF6D51DB15A9B56");
  var_0 endon("_encstr_96AF0C7FCB02A109392913327748");
  var_0.model_created hudoutlinedisable();
  var_0.model_created hudoutlineenable("_encstr_8C0316DEABE836A5DCB299B436D8FA19590EE8347DE4B246");
  wait 0.1;
  var_0.model_created hudoutlinedisable();
  var_0.model_created hudoutlineenable("_encstr_865D19FAA0E11DA730459681E958B7A77B20D30289BFD2BFE8BC9D");
}

toggle_tire_outlines(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    if(!isDefined(var_0.toggled_tire_outlines)) {
      init_tire_outlines(var_0);
      var_0.toggled_tire_outlines = 1;
    }
  }

  if(isDefined(var_0.wheel_tags)) {
    if(!isDefined(var_2)) {
      if(istrue(var_1.outlined)) {
        if(isDefined(var_1.model_created))
          var_1.model_created hudoutlinedisable();

        var_1.outlined = 0;
      } else {
        if(isDefined(var_1.model_created))
          var_1.model_created hudoutlineenable("_encstr_865D19FAA0E11DA730459681E958B7A77B20D30289BFD2BFE8BC9D");

        var_1.outlined = 1;
      }
    } else if(!istrue(var_2)) {
      if(isDefined(var_1.model_created))
        var_1.model_created hudoutlinedisable();

      var_1.outlined = 0;
    } else {
      if(isDefined(var_1.model_created))
        var_1.model_created hudoutlineenable("_encstr_865D19FAA0E11DA730459681E958B7A77B20D30289BFD2BFE8BC9D");

      var_1.outlined = 1;
    }
  }
}

check_backup_is_set(var_0) {
  if(isDefined(var_0.settings.backup_deposit_names))
    return 1;

  return 0;
}

route_soldiers_towards_backup_location(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_A32D1ACBDF45BB9D09833DC55980A5931E275BC7D766525340ABF20A");
  var_0 endon("_encstr_A32D1ACBDF45BB9D09833DC55980A5931E275BC7D766525340ABF20A");
  var_1 = var_0.targeted_hvt;

  if(!istrue(var_0._id_13069)) {
    var_0._id_13069 = 1;
    var_0.initialize_switches_pattern = undefined;

    if(isDefined(var_1.carrier))
      var_0.initialize_switches_pattern = var_1.carrier;

    var_0.initialize_water_trap = gettime();
    level thread allow_routing_to_end(var_0);
  }

  if(isDefined(var_1.carrier)) {
    if(!isDefined(var_0.initialize_switches_pattern) || var_1.carrier != var_0.initialize_switches_pattern || gettime() > var_0.initialize_water_trap + 45000) {
      var_0.initialize_switches_pattern = var_1.carrier;
      var_0.initialize_water_trap = gettime();
    } else if(isDefined(var_0.chopper_carepackage_set_useable))
      return;
  } else
    return;

  if(isDefined(var_1.waypoint)) {
    if(isDefined(var_1.sethotfunc))
      var_1 thread[[var_1.sethotfunc]](1);
  }

  var_2 = scripts\engine\utility::getStructArray(var_0.settings.backup_deposit_names, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_2) || var_2.size == 0) {
    var_0 notify("_encstr_87EA1527C028C7DB0F8E659BF50B029716A8A757108004");
    return;
  }

  var_3 = 2250000;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(distance2dsquared(var_2[var_4].origin, var_1.origin) < var_3)
      var_2 = scripts\engine\utility::array_remove(var_2, var_2[var_4]);
  }

  var_5 = scripts\engine\utility::getclosest(var_1.origin, var_2);
  var_0.chopper_carepackage_set_useable = var_5;

  if(istrue(var_0.settings.recruit_enable))
    var_0 thread pulse_soldiers_to_help_convoy();

  if(!isDefined(var_0.settings.backup_deposit_names)) {
    var_0 notify("_encstr_87EA1527C028C7DB0F8E659BF50B029716A8A757108004");
    return;
  }

  if(var_0.backup_soldiers.size > 0) {
    foreach(var_7 in var_0.backup_soldiers) {
      if(istrue(var_0.targeted_hvt.pickedup)) {
        var_7 send_convoy_soldier_here(var_5.origin, undefined, 1);

        if(istrue(var_7.has_hvt)) {
          var_7.goalradius = 50;
          continue;
        }

        var_7.goalradius = 150;
      }
    }
  }
}

allow_routing_to_end(var_0) {
  var_0 waittill("_encstr_87EA1527C028C7DB0F8E659BF50B029716A8A757108004");
  level thread remove_convoy_from_level(var_0);

  if(isDefined(var_0.eventname) && var_0.eventname != "_encstr_B40101")
    scripts\cp\cp_objectives_events::mark_event_completed(var_0.eventname);
}

is_convoy() {
  if(!isDefined(self.spawner))
    return 0;

  return 1;
}

kill_convoy_all_safe(var_0) {
  var_1 = 0.05;

  if(isDefined(var_0))
    var_1 = var_0;

  if(var_1 > 0)
    wait(var_1);

  foreach(var_3 in self.spawned_vehicles) {
    if(isalive(var_3))
      var_3 thread waittillplayersleavearea();
  }
}

kill_convoy_all(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_1))
    var_1 = 180;

  var_2 = var_0 scripts\engine\utility::waittill_any_ents_or_timeout_return(var_1, level, "_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0.eventname + "_encstr_A7A70B7DDE989AAC6CA3D2B359", var_0, "_encstr_9515115A7CCDCCF78F3D335BBFAF899720DB47");
  var_0 notify("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");

  foreach(var_4 in var_0.spawned_vehicles) {
    if(isalive(var_4)) {
      var_4 thread kill_truck_riders();
      var_4 thread delete_accessories();
      var_4 thread delete_tires();
      var_4 thread delete_my_drone_models();
      var_4 delete();
    }
  }

  if(isDefined(var_0.convoy_hvt_struct))
    var_0.convoy_hvt_struct.script_noteworthy = "_encstr_B40101";

  var_6 = getEnt("_encstr_A5781AA7F3DACD98FCD45B3171D3C0F0B35F03BF9FB20C4B0C2CA168", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(var_6))
    var_6 delete();

  if(isDefined(var_0.targeted_hvt) && isent(var_0.targeted_hvt) && istrue(var_0.targeted_hvt.pickedup))
    var_0.targeted_hvt delete();

  if(isDefined(var_0.targeted_hvt) && isalive(var_0.targeted_hvt))
    var_0.targeted_hvt kill();

  level thread remove_convoy_from_level(var_0);

  if(isDefined(var_0.eventname) && var_0.eventname != "_encstr_B40101")
    scripts\cp\cp_objectives_events::mark_event_completed(var_0.eventname);
}

kill_main_truck(var_0, var_1) {
  var_2 = var_0.main_truck;

  if(isDefined(var_1))
    wait(var_1);

  if(isalive(var_2)) {
    var_2 thread kill_truck_riders();
    var_2 thread delete_accessories();
    var_2 thread delete_tires();
    var_2 thread delete_my_drone_models();
    var_2 delete();
  }
}

kill_truck_riders() {
  foreach(var_1 in self.riders) {
    if(isalive(var_1))
      var_1 dodamage(var_1.health + 9990, var_1.origin, undefined, undefined, "_encstr_BDB50C41D83F8F9F030B60E80F5B");
  }

  if(isDefined(self.spawned_guys)) {
    foreach(var_4 in self.spawned_guys) {
      if(isalive(var_4))
        var_4 dodamage(var_4.health + 9990, var_4.origin, undefined, undefined, "_encstr_BDB50C41D83F8F9F030B60E80F5B");
    }
  }

  if(isDefined(self.zombiejumping)) {
    foreach(var_4 in self.zombiejumping) {
      if(isalive(var_4))
        var_4 dodamage(var_4.health + 9990, var_4.origin, undefined, undefined, "_encstr_BDB50C41D83F8F9F030B60E80F5B");
    }
  }
}

delete_my_drone_models() {
  var_0 = self.attached_drones;

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2))
        var_2 delete();

      if(isDefined(self.type) && self.type == "_encstr_B87406412C6229ED") {
        if(isDefined(level.reserved_spawn_slots["_encstr_99530D0353B07BA2A0C1CB472D55EB"]))
          scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "_encstr_99530D0353B07BA2A0C1CB472D55EB");
      }
    }
  }

  scripts\cp\cp_vehicle_turretdrone::delete_vehicles_turrets();
}

waittillconvoydead() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");

  if(!isDefined(self.vehicles_remaining)) {
    return;
  }
  while(self.vehicles_remaining > 0)
    wait 0.5;

  if(istrue(self.settings.toggle_vo_on_convoy_death) && !istrue(self.despawned_vehicles))
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A1791EC86B3937FB375FB034745F41E7DD3318B8718F7BD3578AC9A5543743E1", "_encstr_9A8507BA4040188D08");

  if(check_backup_is_set(self))
    level thread route_soldiers_towards_backup_location(self);
  else {
    level thread remove_convoy_from_level(self);

    if(isDefined(self.eventname) && self.eventname != "_encstr_B40101")
      scripts\cp\cp_objectives_events::mark_event_completed(self.eventname);
  }
}

waittilldeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.convoy endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  var_0 = self.convoy;
  wait 1;
  self waittill("_encstr_AD75063D571AE108", var_1, var_2, var_3, var_4);

  if(isDefined(self.convoy.vehicles_remaining))
    self.convoy.vehicles_remaining--;

  if(!isDefined(var_4))
    var_4 = self.origin;

  if(isDefined(self.origin))
    thread play_deathfx_convoy(var_1, var_2, var_4);

  thread scripts\cp\utility::vehicle_freehealthbarui();
  thread delete_my_old_path();
  thread delete_my_drone_models();
  thread kill_truck_riders();
  thread truck_barrels_on_death(var_0);
  childthread handle_vehicle_death_type();
}

play_deathfx_convoy(var_0, var_1, var_2) {
  scripts\common\vehicle_code::vehicle_playdeatheffects(var_0, var_1, var_2);
}

handle_vehicle_death_type() {
  if(self.type != "_encstr_B87406412C6229ED") {
    self.convoy.alive_support_vehicles--;

    if(istrue(self.has_hvt) && istrue(self.convoy.exiting)) {
      thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_832D209D4301F1A27949F36DAA769CE9D96853E6DCC70C117820181FE44CDD6B0687");
      self.convoy.targeted_hvt thread spawnheliactorsfunc(self);
    }
  } else if(self.type == "_encstr_B87406412C6229ED" && !istrue(self.convoy.exiting)) {
    foreach(var_1 in self.convoy.spawned_vehicles) {
      if(isalive(var_1)) {
        var_1.disable_leave_truck = 0;
        var_1 vehicle_setspeed(0, 10, 10);
        var_1 thread waittillplayersleavearea();
      }

      var_1 notify("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
      self.convoy notify("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
    }

    if(isDefined(self.convoy.targeted_hvt) && istrue(self.has_hvt))
      self.convoy.targeted_hvt.origin = getclosestpointonnavmesh(self.convoy.targeted_hvt.origin) + (0, 0, 10);
  }

  if(self.type == "_encstr_B87406412C6229ED") {
    if(istrue(self.convoy.exiting)) {
      if(self.convoy.vehicles_remaining > 0)
        thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_832D209D4301F1A27949F36DAA769CE9D96853E6DCC70C117820181FE44CDD6B0687");

      if(isDefined(self.convoy.targeted_hvt) && istrue(self.has_hvt))
        self.convoy.targeted_hvt thread spawnheliactorsfunc(self);
    }

    self.convoy notify("_encstr_A3E5145B2888AB302AC6B1F8FE15103B3889DD49CB30");
    level thread main_truck_compromise(self.convoy);
  }

  if((!isDefined(self.convoy.vehicles_remaining) || self.convoy.vehicles_remaining == 0) && istrue(self.convoy.not_compromised))
    self.convoy childthread delay_kill_convoy_ents();

  if(isDefined(self) && isent(self)) {
    if(isDefined(self) && isent(self) && isDefined(self.dmg_vfx_tag))
      stopFXOnTag(scripts\engine\utility::getfx("_encstr_BA93109D66F0FA2CB4EBD95637FA33B4E42B"), self, self.dmg_vfx_tag);

    thread delete_accessories();
    thread delete_tires();

    if(getdvarint("_encstr_BD8A19026E05118BED8023BFC0FE43DADD7F8A3FD8437AD189B867", 0) == 0)
      self delete();
  }
}

delete_accessories(var_0) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  if(isDefined(self.accessories)) {
    foreach(var_2 in self.accessories)
    var_2 delete();
  }
}

delete_tires(var_0) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  if(isDefined(self.wheel_tags)) {
    foreach(var_2 in self.wheel_tags) {
      if(isent(var_2.model_created))
        var_2.model_created delete();

      if(isent(var_2.collision_created))
        var_2.collision_created delete();
    }
  }
}

delay_kill_convoy_ents() {
  wait 0.5;
  self notify("_encstr_9515115A7CCDCCF78F3D335BBFAF899720DB47");
}

delete_my_old_path() {
  scripts\cp\cp_vehicles::reset_spawn_point_targetname();
}

waittillplayersleavearea() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.convoy endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  self endon("_encstr_AD75063D571AE108");

  if(!istrue(self.convoy.settings.despawn_dist_enable)) {
    return;
  }
  var_0 = self.convoy.settings.despawn_dist;
  var_1 = var_0 * var_0;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, var_1)) {
      wait 1;
      continue;
    }

    break;
  }

  thread kill_truck_riders();
  thread delete_my_drone_models();
  thread delete_accessories();
  thread delete_tires();
  level thread remove_convoy_from_level(self.convoy);

  if(isDefined(self.convoy.eventname) && self.convoy.eventname != "_encstr_B40101")
    scripts\cp\cp_objectives_events::mark_event_completed(self.convoy.eventname);

  self.convoy notify("_encstr_91C81819ACB90E0BEEDC5932AF8EC9D56CAD7D588EEBC8D2371D");
  self.convoy.despawned_vehicles = 1;
  self delete();
}

waittilltoofarz() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.convoy endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    wait 3;

    if(self.convoy.settings.distance_z > 0) {
      if(isalive(self)) {
        if(abs(self.origin[2] - self.measure_origin[2]) > self.convoy.settings.distance_z) {
          thread kill_truck_riders();
          thread delete_accessories();
          thread delete_tires();
          thread delete_my_drone_models();
          self delete();
        }
      }
    }
  }
}

waittillhealthlow(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.convoy endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  self endon("_encstr_AD75063D571AE108");
  self.convoy endon("_encstr_A1C30B134DAFA0D92CC9203023");
  self.convoy waittill("_encstr_8AD8152BD9B2CDE8AF36DBCD3BEDE5BE9B072CBBDCB223");
  childthread handle_vfx_on_damage();

  if(isDefined(self.type) && (self.convoy.settings.amount_to_compromise > 0 || istrue(self.convoy.settings.center_compromises) && self.type == "_encstr_B87406412C6229ED")) {
    while(self.health > self.healthbuffer + 600)
      wait 0.25;

    if(istrue(self.convoy.settings.long_low_health))
      self.health = self.health + 20000;

    if(isDefined(self.convoy.amount_to_compromise_left))
      self.convoy.amount_to_compromise_left--;

    if(self.convoy.settings.amount_to_compromise > 0) {
      while(self.convoy.amount_to_compromise_left > 0)
        wait 0.25;
    }

    while(!istrue(self.arrived_at_goal) && !istrue(self.convoy.settings.can_compromise_before_first_target) && !istrue(self.convoy.settings.roaming))
      wait 0.5;

    thread truck_compromise(1);
  }
}

main_truck_compromise(var_0) {
  if(isalive(var_0.main_truck) && istrue(var_0.not_compromised)) {
    var_0.settings._id_13F14 = undefined;
    var_0.main_truck.disable_leave_truck = 0;

    if(istrue(var_0.main_truck.hull_invulnerable))
      var_0.main_truck.health = var_0.main_truck.orig_health;

    var_0.main_truck thread truck_compromise(1);

    if(soundexists("_encstr_8E4D15A4C503886FB5E241605A4A2B06376B2E955DC750"))
      var_0.main_truck playSound("_encstr_8E4D15A4C503886FB5E241605A4A2B06376B2E955DC750");
  }
}

truck_compromise(var_0) {
  var_1 = self.convoy;
  var_1.lastconfirmedpos = undefined;

  foreach(var_3 in self.convoy.spawned_vehicles) {
    if(isalive(var_3)) {
      var_3.disable_leave_truck = 0;
      level thread scripts\cp\cp_vehicles::make_guys_leave_truck(var_3);
      var_3 notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC", "_encstr_A1C30B134DAFA0D92CC9203023");
      var_3 notify("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
      var_1.lastconfirmedpos = var_3.origin;
    }
  }

  wait 0.05;

  if(istrue(var_0)) {
    if(isDefined(var_1.attached_barrels) && var_1.attached_barrels.size > 0)
      thread truck_barrels_compromised(var_1);

    thread handle_healthdrain_from_lowhealth(var_1);
    var_1 notify("_encstr_A1C30B134DAFA0D92CC9203023");
    var_1.lastconfirmedpos = self.origin;
  }

  var_1.not_compromised = 0;
  var_1 notify("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
}

handle_healthdrain_from_lowhealth(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0.settings.health_drain) || var_0.settings.health_drain <= 0) {
    return;
  }
  if(self.type != "_encstr_B87406412C6229ED") {
    return;
  }
  self.draining_health = 1;
  objective_setplayintro(var_0.convoy_objectivestruct.objectiveindex, 0);
  objective_setplayoutro(var_0.convoy_objectivestruct.objectiveindex, 0);
  var_1 = int(var_0.settings.health_drain);
  wait 1;

  for(;;) {
    self dodamage(var_1, self.origin, undefined, undefined, "_encstr_AB590C99ED78875F650F3951034D");
    objective_sethot(var_0.convoy_objectivestruct.objectiveindex, 0);
    wait 0.7;
    objective_sethot(var_0.convoy_objectivestruct.objectiveindex, 1);
    wait 0.3;
  }
}

handle_vfx_on_damage() {
  self endon("_encstr_AD75063D571AE108");
  self.dmg_vfx_tag = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";

  if(!isDefined(self.type)) {
    return;
  }
  switch (self.type) {
    case "_encstr_B87406412C6229ED":
      self.dmg_vfx_tag = "_encstr_AB231493838CC95D40C17C85B9F16673483D6F2779AD";
      self.dmg_vfx_smoke = "_encstr_96FF139DEBF3D870E95120F8C4C4C810FB6F372F9F";
      self.dmg_vfx_smoke_move = "_encstr_84741AEC6687BEC2B4D7B6AD4B1BBDAF6EB6F6DA2BFADABD672D73B3";
      self.dmg_vfx_hp = 1000;
      break;
    default:
      self.dmg_vfx_tag = "_encstr_8864130B408791D7F0845946ADFE93E04F8082A210";
      self.dmg_vfx_smoke = "_encstr_96FF139DEBF3D870E95120F8C4C4C810FB6F372F9F";
      self.dmg_vfx_smoke_move = "_encstr_84741AEC6687BEC2B4D7B6AD4B1BBDAF6EB6F6DA2BFADABD672D73B3";
      self.dmg_vfx_hp = 1000;
      break;
  }

  while(self.health > self.healthbuffer + self.dmg_vfx_hp)
    wait 0.25;

  scripts\cp\utility::debugprintline("_encstr_8AC20B2B3D49E03F038F9F9FC7");
  playFXOnTag(scripts\engine\utility::getfx(self.dmg_vfx_smoke), self, self.dmg_vfx_tag);
  wait 0.05;

  while(self.health > self.healthbuffer + 550)
    wait 0.25;

  scripts\cp\utility::debugprintline("_encstr_BAD40AD31A5F6BD257A12573");
  stopFXOnTag(scripts\engine\utility::getfx(self.dmg_vfx_smoke), self, self.dmg_vfx_tag);
  playFXOnTag(scripts\engine\utility::getfx("_encstr_BA93109D66F0FA2CB4EBD95637FA33B4E42B"), self, self.dmg_vfx_tag);
}

handle_smuggler_loot_attach(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_1 != var_2)
    var_3 = randomintrange(var_1, var_2 + 1);
  else
    var_3 = var_1;

  if(isDefined(self.main_truck) && isalive(self.main_truck))
    self.main_truck thread attach_barrels_to_truck("_encstr_93011173A849F7BA7706E71A7607C389168ADE", var_3);
}

handle_smuggler_loot_drop(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 1;

  if(isDefined(var_1))
    var_3 = var_1;

  if(isDefined(var_2))
    var_4 = var_2;

  if(var_3 > var_4)
    var_3 = var_4 - 1;

  if(var_4 <= 0 || var_3 < 0)
    self.settings.barrels_on_death = 0;
  else {
    if(var_3 == var_4) {
      self.settings.barrels_on_death = var_3;
      return;
    }

    self.settings.barrels_on_death = randomintrange(var_3, var_4 + 1);
  }
}

attach_barrels_to_truck(var_0, var_1) {
  var_2 = self gettagorigin(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = 28;
  var_4 = 2;
  var_5 = self gettagangles(var_0);

  if(!isDefined(self.convoy.attached_barrels))
    self.convoy.attached_barrels = [];

  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_7 = var_3 * 0.51;

    if(var_6 % 2 == 0)
      var_7 = var_7 * -1;

    var_8 = var_6 * (var_3 * 0.5 + var_4);
    var_9 = (var_8 * -1, var_7, 0);
    var_10 = rotatevector(var_9, self.angles);
    var_11 = var_2 + var_10;
    var_12 = randomintrange(0, 359);
    var_13 = (var_5[0], var_12, var_5[2]);
    var_14 = level thread spawn_phys_barrel_pickup(var_11, var_13, self);
    self.convoy.attached_barrels[self.convoy.attached_barrels.size] = var_14;
  }
}

spawn_phys_barrel_pickup(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3.angles = var_1;
  var_3 setModel("_encstr_8A5B1CF8E576BCD04CC38398412044081BE88BAD7E16197D7E1042A7D9F3");
  var_3 notsolid();
  var_3 show();
  var_3.owner = var_2;
  var_3 linkTo(var_2);
  var_3 spawn_barrel_straps();
  return var_3;
}

spawn_barrel_collision(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1 dontinterpolate();
  var_1.angles = var_0;
  var_1 clonebrushmodeltoscriptmodel(level.taccovercollision);
  var_1 linkTo(self);
  return var_1;
}

spawn_barrel_straps() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0.angles = self.angles;
  var_0 setModel("_encstr_9B471F37FE025DBB6AE20EB959F528DA0ABF21D711206B9B874673D2C0895772DF");
  var_0 notsolid();
  var_0 show();
  var_0 linkTo(self);

  if(!isDefined(self.straps))
    self.straps = [];

  self.straps[self.straps.size] = var_0;
  return var_0;
}

spawn_barrel_tracker(var_0) {
  var_1 = (0, 0, 3);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + var_1);
  var_2.angles = (0, 0, 0);
  var_2 setModel("_encstr_8C611746CA36DB39EB31B0C61BDBDBB9FA135DCDC6D0F56062");
  var_2 notsolid();
  var_2 show();
  var_2 linkTo(self);
  var_2 playLoopSound("_encstr_BEFA116727A39DABC2EF56E9D5BD70D509BBF9");

  if(!isDefined(self.trackers))
    self.trackers = [];

  self.trackers[self.trackers.size] = var_2;
  return var_2;
}

delay_suspend_vehicle() {
  self endon("_encstr_AD75063D571AE108");

  if(self.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0" || !self vehicle_isphysveh()) {
    return;
  }
  while(self vehicle_getspeed() > 1)
    wait 0.05;

  wait 1.1;

  if(isDefined(self) && isent(self))
    self vehphys_deactivate();
}

truck_barrels_compromised(var_0) {
  if(!isDefined(var_0.attached_barrels)) {
    return;
  }
  delay_suspend_vehicle();
  var_1 = 10;

  for(var_2 = 0; var_2 < var_0.attached_barrels.size; var_2++) {
    if(var_2 == 0) {
      playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0.attached_barrels[var_2].origin);
      earthquake(0.5, 1.0, var_0.attached_barrels[var_2].origin, 1500);
    }

    var_3 = var_0.attached_barrels[var_2];
    var_3 solid();
    var_3 show();
    var_3 unlink();

    for(var_4 = 0; var_4 < var_3.straps.size; var_4++)
      var_3.straps[var_4] delete();

    var_3 thread launch_barrel_away(28, var_1, self);
    var_3 hudoutlineenable("_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246");
    thread init_smuggler_loot_interaction();
  }

  physicsexplosionsphere(var_0.attached_barrels[0].origin, 150, 120, 90);
}

launch_barrel_away(var_0, var_1, var_2) {
  self endon("_encstr_8F1E0C34C7E7A391C1B94A67FBA4");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0))
    var_0 = 30;

  var_3 = var_2.origin;
  self physicslaunchserver(self.origin, (0, 0, 0));
  var_4 = 0;
  var_5 = (0, 0, 0);
  wait(var_1 / 2);

  if(self.origin[2] > var_3[2])
    physicsexplosionsphere(self.origin + (0, 1, 1), 3, 2, 10);
}

barrel_freeze() {
  if(istrue(self.frozen)) {
    return;
  }
  self.frozen = 1;
  self physicsstopserver();
}

barrel_unfreeze() {
  if(!istrue(self.frozen)) {
    return;
  }
  self.frozen = 0;
  self physicslaunchserver();
}

barrel_fulton(var_0) {
  var_1 = 15;
  var_2 = randomintrange(2300, 2800);
  var_3 = randomintrange(1, 3);
  self moveTo(self.origin + (0, 0, var_2), var_1, var_3, 4);
  wait(var_1 * 0.66);
  barrel_wind_to_above_truck(var_0);
}

barrel_wind_to_above_truck(var_0) {
  if(distance2d(self.origin, var_0) > 500) {
    var_1 = (var_0[0], var_0[1], self.origin[2]);
    self moveTo(var_1, 8, 3, 3);
  }
}

truck_barrels_on_death(var_0) {
  if(!isDefined(var_0.attached_barrels) || var_0.attached_barrels.size <= var_0.settings.barrels_on_death) {
    return;
  }
  if(!isDefined(level._effect["_encstr_8276136768516E12C1BD4F1E1F8F7A2D9968A73330"]))
    level._effect["_encstr_8276136768516E12C1BD4F1E1F8F7A2D9968A73330"] = loadfx("_encstr_8AF621C466E3E0CFD533305A7A28A1C0E60F4E35F62F311BBF7B90D10207B5B967BCD5");

  var_1 = var_0.settings.barrels_on_death;

  for(var_2 = 0; var_2 < var_0.attached_barrels.size; var_2++) {
    if(istrue(var_0.attached_barrels[var_2].loot_marked)) {
      var_1 = -1;
      continue;
    }

    if(!isDefined(var_0.attached_barrels[var_2]) || !isDefined(var_0.attached_barrels[var_2].origin)) {
      continue;
    }
    var_3 = var_0.lastconfirmedpos;

    if(isDefined(var_3)) {
      if(distance2d(var_0.attached_barrels[var_2].origin, var_3) > 1200)
        continue;
    }

    if(isDefined(var_1) && var_1 > 0) {
      var_1--;
      continue;
    }

    if(isent(var_0.attached_barrels[var_2])) {
      var_4 = anglesToForward(var_0.attached_barrels[var_2].angles);
      playFX(scripts\engine\utility::getfx("_encstr_8276136768516E12C1BD4F1E1F8F7A2D9968A73330"), var_0.attached_barrels[var_2].origin, var_4);

      if(soundexists("_encstr_967915892759C26C86D7D886F5591E0E8DFA8E2716B9CD"))
        playsoundatpos(var_0.attached_barrels[var_2].origin, "_encstr_967915892759C26C86D7D886F5591E0E8DFA8E2716B9CD");

      earthquake(0.4, 0.7, var_0.attached_barrels[var_2].origin, 800);
      playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0.attached_barrels[var_2].origin);
      var_0.attached_barrels[var_2] delete();

      if(isDefined(var_0.attached_barrels[var_2].last_player)) {
        var_0.attached_barrels[var_2].last_player cameradefault();
        var_0.attached_barrels[var_2].last_player scripts\cp\utility::freezecontrolswrapper(0);

        if(istrue(var_0.attached_barrels[var_2].last_player.cantswitch)) {
          var_0.attached_barrels[var_2].last_player scripts\common\utility::allow_weapon_switch(1);
          var_0.attached_barrels[var_2].last_player.cantswitch = undefined;
        }

        var_0.attached_barrels[var_2].last_player scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
        var_0.attached_barrels[var_2].last_player setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
        var_0.attached_barrels[var_2].last_player setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
        level thread barrel_cancel_animate_player(var_0.attached_barrels[var_2].last_player);
      }
    }
  }

  convoy_update_label_to_loot_num(var_0);
}

init_smuggler_loot_interaction() {
  for(var_0 = 0; var_0 < self.convoy.attached_barrels.size; var_0++) {
    if(istrue(self.convoy.attached_barrels[var_0].setup_interact)) {
      return;
    }
    var_1 = spawnStruct();
    var_1.origin = self.convoy.attached_barrels[var_0].origin;
    var_1.targetname = "_encstr_9B260D22788D2F22C80FA4B12588AF";
    var_1.script_noteworthy = "_encstr_B1AD1A7F6BC5F297BD283317F82FE89926375AEDB8E0E08F79E03FAD";
    self.convoy.attached_barrels[var_0].interaction = var_1;
    self.convoy.attached_barrels[var_0].setup_interact = 1;
    temp_make_barrel_interactible(self.convoy.attached_barrels[var_0], self.origin);
  }

  wait 0.05;
}

temp_make_barrel_interactible(var_0, var_1) {
  var_0 setHintString(&"_encstr_BD571570C1FFEE07FC046779BEE8332577793968A13D54");
  var_0 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0 sethintdisplayrange(1200);
  var_0 sethintdisplayfov(150);
  var_0 sethinticon("_encstr_8B401369C3458FD392602607E27A3773EF98B862FD");
  var_0 setuserange(112);
  var_0 setusefov(90);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
  var_0 makeusable();
  var_0 thread temp_make_barrel_think(var_1);
  var_0 thread barrel_early_exit();
}

temp_make_barrel_think(var_0) {
  self endon("_encstr_AD75063D571AE108");
  childthread barrel_handle_cancellation();
  thread smuggler_loot_despawn(8000);

  for(;;) {
    self waittill("_encstr_B1CF098D5838A3D5C95623", var_1);

    if(isDefined(var_1)) {
      if(!var_1 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      self.looted_by = var_1;
      var_1 cameradefault();
      var_1 scripts\cp\utility::freezecontrolswrapper(0);
      var_1 scripts\cp\cp_kidnapper::setimmunetokidnapper(0);

      if(istrue(var_1.cantswitch)) {
        var_1 scripts\common\utility::allow_weapon_switch(1);
        var_1.cantswitch = undefined;
      }

      var_1 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
      var_1 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
      level thread barrel_cancel_animate_player(var_1);
      self.last_player = undefined;

      if(!isDefined(level.obj_current_barrels_scanned)) {
        level.obj_current_barrels_scanned = 0;
        level.obj_max_barrels_scan = 3;

        switch (level.players.size) {
          case 1:
            level.obj_max_barrels_scan = 1;
            break;
          case 2:
            level.obj_max_barrels_scan = 2;
            break;
          default:
            level.obj_max_barrels_scan = 3;
            break;
        }
      }

      level.obj_current_barrels_scanned++;

      if(level.obj_current_barrels_scanned >= level.obj_max_barrels_scan && barrel_collect_chance()) {
        smuggler_collect_loot();
        self.loot_marked = 1;
        self notify("_encstr_8F1E0C34C7E7A391C1B94A67FBA4");
        level notify("_encstr_B8B91523CAD8AC8ECAFADB3AD0954EBE26B09C4E568DCD");
        level notify("_encstr_A98213D0DF701B5763486527C78B9EEFFE8624F10F");
        childthread convoy_update_label_to_loot_num(self.owner.convoy);
        thread spawn_barrel_tracker(var_1);
      }

      barrel_freeze();
      self makeunusable();
      self hudoutlinedisable();

      if(istrue(self.loot_marked))
        barrel_fulton(var_0);
    }
  }
}

barrel_collect_chance() {
  var_0 = 10;
  var_1 = 0;

  if(level.obj_current_barrels_scanned < var_0)
    var_1 = level.obj_current_barrels_scanned / var_0;
  else
    var_1 = 100;

  return var_1 > randomintrange(0, 11);
}

barrel_early_exit() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_B8B91523CAD8AC8ECAFADB3AD0954EBE26B09C4E568DCD");

  if(istrue(self.loot_marked)) {
    return;
  }
  barrel_freeze();
  self makeunusable();
  self hudoutlinedisable();
}

reenable_barrel_interaction() {
  if(!istrue(self.loot_marked)) {
    for(var_0 = 0; var_0 < level.players.size; var_0++)
      self enableplayeruse(level.players[var_0]);

    barrel_unfreeze();
  }
}

convoy_update_label_to_loot_num(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(1) {
    return;
  }
  var_1 = var_0 scripts\cp\cp_convoy_manager::get_smuggler_loot_amount();

  if(isDefined(var_1)) {
    if(var_1 <= 0) {
      var_0 objective_icon_show(0);
      var_0 notify("_encstr_A9C616DF778DA0B8EFF1D1782A9FE1B065C41F79E1B47070");
    } else {
      var_2 = get_nitrate_label(var_1);
      var_0 objective_icon_show_label(var_2);
    }
  }
}

barrel_handle_cancellation() {
  for(;;) {
    self waittill("_encstr_93461143DEC7CA1FF04AD13A3A32EF6A5F700B", var_0);

    if(isDefined(var_0)) {
      if(!var_0 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      self.last_player = var_0;
      var_1 = 4096;

      if(distancesquared(self.origin, getclosestpointonnavmesh(self.origin)) < var_1)
        thread barrel_animate_player(self, var_0);

      var_0 cameraset("_encstr_8ECB168D856BB2C9857D6C576E47ED6BBEB7C989D247EBC4");
      var_0 scripts\cp\utility::freezecontrolswrapper(1);
      var_0 scripts\cp\cp_kidnapper::setimmunetokidnapper(1);
      var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 1);
      var_0 scripts\common\utility::allow_weapon_switch(0);
      var_0.cantswitch = 1;
      barrel_freeze();

      for(var_2 = 0; var_2 < level.players.size; var_2++) {
        if(level.players[var_2] != var_0)
          self disableplayeruse(level.players[var_2]);
      }

      var_3 = 5;

      for(var_4 = 0; var_0 useButtonPressed() && var_4 < var_3; var_4 = var_4 + 0.05) {
        var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_4 / var_3);
        wait 0.05;
      }

      self notify("_encstr_B1CF098D5838A3D5C95623", var_0);
      self.last_player = undefined;
      var_0 cameradefault();
      var_0 scripts\cp\utility::freezecontrolswrapper(0);
      var_0 scripts\cp\cp_kidnapper::setimmunetokidnapper(0);

      if(istrue(var_0.cantswitch)) {
        var_0 scripts\common\utility::allow_weapon_switch(1);
        var_0.cantswitch = undefined;
      }

      var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
      var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
      level thread barrel_cancel_animate_player(var_0);
      reenable_barrel_interaction();
    }
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

barrel_setup_anims() {
  if(isDefined(level.scr_anim["_encstr_8BB007E03658CBCAE4"]) && isDefined(level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_B1090C4A265B7AFFE9A07B73E840"])) {
    return;
  }
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_B1090C4A265B7AFFE9A07B73E840"][0] = % _encstr_A99320D760D938BDB3BB18201147F6B8EBD82769143E988DE3E1DB0E4A0F20200330;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_B1090C4A265B7AFFE9A07B73E840"] = "_encstr_A99320D760D938BDB3BB18201147F6B8EBD82769143E988DE3E1DB0E4A0F20200330";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_B1090C4A265B7AFFE9A07B73E840"][0] = "_encstr_A99320D760D938BDB3BB18201147F6B8EBD82769143E988DE3E1DB0E4A0F20200330";
}

barrel_animate_player(var_0, var_1) {
  if(!isDefined(level.scr_anim["_encstr_8BB007E03658CBCAE4"]) || !isDefined(level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_B1090C4A265B7AFFE9A07B73E840"])) {
    return;
  }
  var_2 = (0, vectortoangles(self.origin - var_1.origin)[1], 0);
  var_3 = vectorNormalize(var_1.origin - self.origin);
  var_3 = var_3 * 32;
  var_1.barrelscan_animscene = spawnStruct();
  var_4 = scripts\engine\utility::drop_to_ground(self.origin + var_3);
  var_1.barrelscan_animscene.origin = var_4;
  var_1.barrelscan_animscene.angles = var_2;
  var_5 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "_encstr_8BB007E03658CBCAE4", 1, 0, 1);
  var_1.barrelscan_animactor = var_5;
  var_5 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var_6 = var_1.barrelscan_animscene scripts\cp_mp\anim_scene::anim_scene_loop([var_5], "_encstr_B1090C4A265B7AFFE9A07B73E840");
  var_1.barrelscan_animscene = undefined;
}

barrel_cancel_animate_player(var_0) {
  if(isDefined(var_0.barrelscan_animscene)) {
    var_0.barrelscan_animscene scripts\cp_mp\anim_scene::anim_scene_stop_actor(var_0.barrelscan_animactor);
    var_0.barrelscan_animscene scripts\cp_mp\anim_scene::anim_scene_stop(1);
  }
}

smuggler_loot_hint_func(var_0, var_1) {
  return &"_encstr_BD571570C1FFEE07FC046779BEE8332577793968A13D54";
}

smuggler_loot_activate_func(var_0, var_1) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(var_0.disabled)) {
    return;
  }
  if(istrue(var_1.tablet_out))
    return;
}

smuggler_loot_init_func(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.pentskipfov["_encstr_B1AD1A7F6BC5F297BD283317F82FE89926375AEDB8E0E08F79E03FAD"] = 1;

  foreach(var_2 in var_0) {
    var_2.p_ent_skip_fov = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var_2);
  }
}

smuggler_collect_loot() {
  if(istrue(level.smuggler_disable_loots)) {
    return;
  }
  if(!isDefined(level.smuggler_loot_collected))
    level.smuggler_loot_collected = 0;

  if(!isDefined(level.smuggler_loot_max))
    level.smuggler_loot_max = 5;

  level.smuggler_loot_collected++;
  level thread print_nitrate_text(level.smuggler_loot_collected);

  foreach(var_1 in level.players)
  var_1 iprintlnbold("_encstr_BAB51445CBFE815B3BC3F15B9A4211A002FB4BB95A46" + level.smuggler_loot_collected + "_encstr_83170430221F" + level.smuggler_loot_max);

  if(level.smuggler_loot_collected >= level.smuggler_loot_max)
    level thread smuggler_temp_ending();
}

smuggler_loot_despawn(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = self.owner;
  var_2 = var_0 * var_0;

  for(;;) {
    wait 1;

    if(!scripts\cp\utility::any_player_nearby(self.origin, var_2)) {
      break;
    }
  }

  if(isDefined(self.trackers) && self.trackers.size > 0) {
    foreach(var_4 in self.trackers) {
      var_4 stoploopsound();
      var_4 delete();
    }
  }

  self delete();
  convoy_update_label_to_loot_num(var_1.convoy);
}

smuggler_temp_ending() {
  level.smuggler_disable_loots = 1;
  level notify("_encstr_A3E01807AF2508B7575908B0A347CB08FD078FE7450A605D0B92");
  wait 3;
}

get_nitrate_label(var_0) {
  var_1 = &"_encstr_B40101";

  if(!isDefined(var_0))
    return var_1;

  switch (var_0) {
    case 1:
      var_1 = &"_encstr_8BEE112599598D08F96BA51B6F77B199B9B64B";
      break;
    case 2:
      var_1 = &"_encstr_83EE113F9180186751D7C5586F82A3A1FE7772";
      break;
    case 3:
      var_1 = &"_encstr_9BEE11BEF917D32D35249F137E18D10BA26912";
      break;
    case 4:
      var_1 = &"_encstr_9AEE113BD981AEBFA0476009CF38F7D3415FC4";
      break;
    case 5:
      var_1 = &"_encstr_AFEE11B3C706E7357D69205959E77AF3DF284D";
      break;
    case 6:
      var_1 = &"_encstr_8DEE1126D8F7E50F05F9D96181756F5FABAFE4";
      break;
    case 7:
      var_1 = &"_encstr_A5EE11FD82C7813840F32F0B8F3E7E41A229EB";
      break;
    case 8:
      var_1 = &"_encstr_B1EE11FF41C1EDF95BB9870BD19D1F738D07F2";
      break;
    case 9:
      var_1 = &"_encstr_BAEE1156A887959F956969D111E59FCF1B3FF3";
      break;
    case 10:
      var_1 = &"_encstr_97FB120D28EB1A7A9CB29ECA4D97D44594D71318";
      break;
    case 11:
      var_1 = &"_encstr_AAFB127EA751EB50B835AFEF27E05934C1AE7A6A";
      break;
    case 12:
      var_1 = &"_encstr_85FB120F5AB126970BEFF9132AAFCF1CBA7F89A2";
      break;
    case 13:
      var_1 = &"_encstr_ADFB123EC74FC0B734B1377781C06379EDF82ABA";
      break;
    case 14:
      var_1 = &"_encstr_84FB12E9B3AF8577E44B7063124E172FCAF7F2CA";
      break;
    case 15:
      var_1 = &"_encstr_8AFB125E507F6D979D7161E919FDE7C71337EF1D";
      break;
    case 16:
      var_1 = &"_encstr_A6FB1290D85FA0E7FCF3B48BBFB8DE312EF1AF12";
      break;
    case 17:
      var_1 = &"_encstr_B2FB121E116188A7048DD7F97F0F47258BD74BB2";
      break;
    case 18:
      var_1 = &"_encstr_92FB1219204956DF90CCF041763206793DF0E7C2";
      break;
    case 19:
      var_1 = &"_encstr_BEFB1227E35106D1FE2354EE1AF779C5D9777B5B";
      break;
    case 20:
      var_1 = &"_encstr_BDFB126B0FCE2FCD85A1F89161AF328B87108290";
      break;
  }

  return var_1;
}

print_nitrate_text(var_0) {
  if(isDefined(level.convoy_hud_text))
    level.convoy_hud_text destroy();

  var_1 = newhudelem();
  var_1.alignx = "_encstr_A5AD056A019C63";
  var_1.aligny = "_encstr_AC190479FF92";
  var_1.x = -32;
  var_1.y = 47;
  var_2 = get_nitrate_label(var_0);
  var_1 settext(var_2);
  var_1.fontscale = 1;
  var_1.alpha = 1;
  level.convoy_hud_text = var_1;
}

waittillcompromised(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");

  if(isDefined(var_1.eventname) && var_1.eventname != "_encstr_B40101")
    level endon("_encstr_9BED0777936DE52771" + var_1.eventname + "_encstr_93D80BF536F6B638D8AC1D95C8");

  self endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_8A3419F627F3838F08A97810A2626D7817D9067D848FA9DBB28290");

  if(!isDefined(var_1.backup_soldiers))
    var_1.backup_soldiers = [];

  wait 1;

  if(isDefined(self.type) && (var_1.settings.amount_to_compromise > 0 || istrue(var_1.settings.center_compromises) && self.type == "_encstr_B87406412C6229ED") && var_1.alive_support_vehicles > 0) {
    while((self.convoy.alive_support_vehicles > 0 || var_1.backup_soldiers.size > 0) && istrue(self.convoy.not_compromised))
      wait 0.5;

    while(!istrue(self.arrived_at_goal) && !istrue(var_1.settings.can_compromise_before_first_target) && !istrue(self.convoy.settings.roaming))
      wait 0.5;

    if(isDefined(var_1.main_truck) && self != var_1.main_truck) {
      return;
    }
    foreach(var_3 in self.convoy.spawned_vehicles) {
      if(isalive(var_3)) {
        var_3 vehicle_setspeed(0, 150, 150);
        var_3.disable_leave_truck = 0;
      }

      var_3 notify("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
      self.convoy notify("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
    }

    self notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC", "_encstr_87620CB1EDD683E4B76B4BCD9519");
    self notify("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
    self.convoy notify("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");

    if(istrue(self.convoy.settings.route_to_other_veh) && istrue(self.convoy.settings.route_to_any_veh) && istrue(self.convoy.not_compromised))
      thread route_spawned_soldiers_to_new_vehicle();
    else if(check_backup_is_set(self.convoy))
      level thread route_soldiers_towards_backup_location(self.convoy);
  }
}

waittillarriveatdestination(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  var_1 endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");

  if(isDefined(self.type) && self.type != "_encstr_B87406412C6229ED") {
    return;
  }
  self waittill("_encstr_AB850C5DDC8DED168CF59DBA5EDC", var_2);
  wait 0.05;
  var_1 notify("_encstr_B44117C6F0686EE2B3B787331553BBB5E05EFE8B6E50057B0D");
  self.arrived_at_goal = 1;

  if(soundexists("_encstr_8E4D15A4C503886FB5E241605A4A2B06376B2E955DC750"))
    self playSound("_encstr_8E4D15A4C503886FB5E241605A4A2B06376B2E955DC750");

  while(!istrue(var_1.settings.unload_at_target))
    wait 0.5;

  var_0 = var_1.using_path;
  childthread spawn_soldiers_route_to_hvt(var_0);
}

stop_all_convoy_cars(var_0) {
  if(!istrue(self.convoy.settings.enable_stop_all_cars)) {
    return;
  }
  foreach(var_2 in self.convoy.spawned_vehicles) {
    if(isalive(var_2)) {
      if(!istrue(var_0))
        var_2 notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC", "_encstr_A222153B03D0FB71B7D9A89F7AFFA80B5FE871F36AB30B");

      var_2 notify("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
      var_2 vehicle_setspeedimmediate(0, 120, 120);
      var_2.veh_brake = 1;
      var_2.disable_horn = 1;
    }
  }
}

spawn_soldiers_route_to_hvt(var_0) {
  var_0 = self.convoy.using_path;
  thread stop_all_convoy_cars();
  wait 1;
  var_1 = undefined;

  if(isent(self.convoy.settings.target))
    var_1 = self.convoy.settings.target;

  if(isDefined(self.convoy.targeted_hvt))
    var_1 = self.convoy.targeted_hvt;

  if(!isDefined(var_1))
    var_1 = getEnt("_encstr_B48F1B4DD9C0F5BABD53A3E7D7EEA22688C040D991A0AE52994B07D3EF" + var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1)) {
    var_1 = getEnt(self.convoy.settings.target, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
    self.convoy.targeted_hvt = var_1;
  }

  if(!isDefined(var_1)) {
    if(isDefined(self.convoy.settings.target)) {
      wait 15;
      var_1 = getEnt(self.convoy.settings.target, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
      self.convoy.targeted_hvt = var_1;
    } else
      return;

    if(!isDefined(self.convoy.targeted_hvt)) {
      self.convoy.exiting = 1;
      self.convoy notify("_encstr_A10A12DA433D2B8B6167C7DE55B890A755FA9253");
      return;
    }
  }

  self.convoy notify("_encstr_8CEE121FB74D60782F31B07BEB37A028A903ABB9");

  if(!istrue(var_1.carried_by_vehicle) && !(isDefined(var_1.carrier) && isPlayer(var_1.carrier)))
    var_1 unlink();

  var_2 = self;

  if(isDefined(self.convoy.main_truck))
    var_2 = self.convoy.main_truck;

  if(istrue(self.convoy.settings.route_to_any_veh))
    var_2 thread waittill_hvt_at_vehicle(var_1, self.convoy);

  if(!isDefined(self.riders) || self.riders.size == 0) {
    return;
  }
  if(isDefined(self.type) && self.type == "_encstr_B87406412C6229ED") {
    if(istrue(self.convoy.settings.recruit_enable))
      thread temp_spawn_backup_on_apc(var_1);

    var_3 = self.riders.size;
    var_4 = [];

    foreach(var_6 in self.riders) {
      if(isalive(var_6))
        var_4[var_4.size] = var_6;
    }

    var_8 = int(var_4.size / 4 * 3);
    var_8 = var_4.size;
    self.convoy.convoy_hvt_squad_alive = var_8;
    self.convoy_apc_spawned_riders = [];

    foreach(var_10 in var_4)
    self.convoy_apc_spawned_riders[self.convoy_apc_spawned_riders.size] = var_10;

    for(var_12 = 0; var_12 < var_8; var_12++) {
      var_4[var_12] apply_apc_soldier_settings(var_1, self.convoy);
      var_4[var_12].convoy = self.convoy;
    }
  }
}

route_spawned_soldiers_to_new_vehicle() {
  if(!isDefined(self.convoy.backup_soldiers)) {
    return;
  }
  if(istrue(self.convoy.exiting)) {
    return;
  }
  if(self.type == "_encstr_B87406412C6229ED") {
    if(!istrue(self.convoy.exiting)) {
      if(isDefined(self.convoy.main_truck))
        self.convoy.main_truck notify("_encstr_9688179BB2DDFAAD854BDCBE36B7CD67BDCB7DB186DEE6569B");

      foreach(var_1 in self.convoy.spawned_vehicles) {
        if(can_route_othercar(var_1)) {
          var_1 thread waittill_hvt_at_vehicle(self.convoy.targeted_hvt, self.convoy);

          if(self.convoy.backup_soldiers.size > 0) {
            foreach(var_3 in self.convoy.backup_soldiers) {
              if(isalive(var_3))
                var_3.truck = var_1;

              if(istrue(self.convoy.targeted_hvt.pickedup)) {
                var_3 send_convoy_soldier_here(var_1.origin);

                if(istrue(var_3.has_hvt))
                  var_3.goalradius = 50;
                else
                  var_3.goalradius = 250;
              }

              var_1.riders[var_1.riders.size] = var_3;
            }
          }

          break;
        }
      }
    }
  }
}

can_route_othercar(var_0) {
  if(!istrue(self.convoy.settings.route_to_any_veh))
    return 0;

  if(isDefined(var_0) && isalive(var_0) && var_0 != self) {
    if(var_0.type != "_encstr_B87406412C6229ED" && istrue(self.convoy.settings.route_to_other_support_veh))
      return 1;
    else if(var_0.type == "_encstr_B87406412C6229ED")
      return 1;
  }

  return 0;
}

pulse_soldiers_to_help_convoy() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  self endon("_encstr_A10A12DA433D2B8B6167C7DE55B890A755FA9253");
  level notify("_encstr_87A016D263A8BB92105F0F1B6923DAF2E88E8E9DF8907F6B");
  level endon("_encstr_87A016D263A8BB92105F0F1B6923DAF2E88E8E9DF8907F6B");

  if(!isDefined(self.targeted_hvt)) {
    if(isent(self.settings.target))
      var_0 = self.settings.target;
    else
      var_0 = getEnt(self.settings.target, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    self.targeted_hvt = var_0;
  }

  if(!isDefined(self.targeted_hvt)) {
    return;
  }
  self.targeted_hvt endon("_encstr_AD75063D571AE108");
  var_1 = self.settings.recruit_time_until;
  wait(var_1);

  for(;;) {
    self.targeted_hvt childthread grab_nearby_soldiers_and_apply_settings(self);
    wait(self.settings.recruit_time_between);
  }
}

grab_nearby_soldiers_and_apply_settings(var_0) {
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_1 = sortbydistance(var_1, self.origin);
  var_2 = var_0.settings.recruit_distance * var_0.settings.recruit_distance;

  if(!isDefined(var_0.backup_soldiers))
    var_0.backup_soldiers = [];

  foreach(var_4 in var_1) {
    if(!(isDefined(var_4) && isalive(var_4))) {
      continue;
    }
    if(!isDefined(var_4.agent_type)) {
      continue;
    }
    if(distance2dsquared(self.origin, var_4.origin) > var_2) {
      continue;
    }
    if(!istrue(var_0.settings.recruit_juggs) && var_4 scripts\cp\cp_modular_spawning::is_juggernaut_aitype()) {
      continue;
    }
    if(isDefined(var_4.agent_type) && istrue(var_4.agent_type == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")) {
      continue;
    }
    if(isDefined(var_4.aitype) && istrue(var_4.aitype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")) {
      continue;
    }
    if(isDefined(var_4.aitype) && istrue(var_4.aitype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B")) {
      continue;
    }
    if(isDefined(var_0.main_truck.riders) && scripts\engine\utility::array_contains(var_0.main_truck.riders, var_4)) {
      continue;
    }
    var_4 apply_apc_soldier_settings(undefined, var_0);
  }
}

apply_apc_soldier_settings(var_0, var_1) {
  if(!isDefined(var_0)) {
    if(isDefined(var_1.targeted_hvt))
      var_0 = var_1.targeted_hvt;
  }

  if(!isDefined(var_1.backup_soldiers))
    var_1.backup_soldiers = [];

  if(!scripts\engine\utility::array_contains(var_1.backup_soldiers, self) && var_1.backup_soldiers.size < var_1.settings.recruit_amount) {
    var_1.backup_soldiers[var_1.backup_soldiers.size] = self;
    thread waittillarriveathvt(var_0, var_1);
    thread waittill_backup_death(var_1);

    if(isDefined(self.script_origin_other))
      self.script_origin_other = undefined;

    if(!scripts\cp\cp_modular_spawning::is_juggernaut_aitype())
      scripts\engine\utility::set_movement_speed(230);

    if(isDefined(var_1))
      self.convoy = var_1;

    scripts\cp\cp_squadmanager::removefromsquad();
  }
}

waittill_backup_death(var_0) {
  var_0 endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  var_0.backup_soldiers = scripts\engine\utility::array_remove(var_0.backup_soldiers, self);
}

temp_spawn_backup_on_apc(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.convoy endon("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.convoy endon("_encstr_A10A12DA433D2B8B6167C7DE55B890A755FA9253");

  if(getdvarint("_encstr_8A201F9B1B27EB2B3BB2731DAF36DBE6CEBDF2D7914B6E0B311B561385C6ADD507", 0) == 1) {
    return;
  }
  for(;;) {
    var_1 = [];

    foreach(var_3 in self.riders) {
      if(isalive(var_3))
        var_1[var_1.size] = var_3;
    }

    if(var_1.size > 5) {
      break;
    }

    wait 0.25;
  }

  while(!istrue(self.convoy.backup_spawned)) {
    var_1 = [];

    foreach(var_3 in self.riders) {
      if(isalive(var_3))
        var_1[var_1.size] = var_3;
    }

    if(var_1.size < 4) {
      wait 0.05;
      self notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC", "_encstr_B2D10DAF58CA1BF6504A13DE8778A8");

      foreach(var_3 in self.riders) {
        if(isalive(var_3))
          var_3 apply_apc_soldier_settings(var_0, self.convoy);
      }

      wait 1;
      self.convoy.backup_spawned = 1;
    } else
      self.convoy.backup_spawned = 0;

    wait 3;
  }

  for(;;) {
    var_1 = [];

    foreach(var_3 in self.riders) {
      if(isalive(var_3)) {
        if(!scripts\engine\utility::array_contains(var_1, var_3))
          var_1[var_1.size] = var_3;
      }
    }

    if(var_1.size < 1 && istrue(self.convoy.backup_spawned)) {
      if(istrue(self.convoy.settings.hide_icon_on_pickup))
        self.convoy objective_icon_show(0);

      thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_8B2D20514999D51F2733CB4633FF650171F089D9202587B72767FED0DEF32C53292F");

      if(istrue(self.convoy.settings.defeated_on_kill_backup)) {
        if(istrue(self.convoy.settings.hide_icon_on_pickup))
          self.convoy objective_icon_show(0);

        thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_8B2D20514999D51F2733CB4633FF650171F089D9202587B72767FED0DEF32C53292F");
        self.convoy.exiting = 1;
        self.convoy notify("_encstr_8AA216516365703DF99FC7FDF3C283B13DBA19A98AC1C87C");
        wait 0.05;
        self.convoy notify("_encstr_A10A12DA433D2B8B6167C7DE55B890A755FA9253");
      }
    } else {
      foreach(var_3 in var_1) {
        var_3 setgoalentity(var_0, 500);
        var_3.goalradius = 80;
      }
    }

    wait 3;
  }
}

waittillarriveathvt(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  var_1 endon("_encstr_A10A12DA433D2B8B6167C7DE55B890A755FA9253");
  self notify("_encstr_95721EB99353B94051E3A7AD1E8598E8F7DA90816A7FEE3972FD698139AD2046");
  self endon("_encstr_95721EB99353B94051E3A7AD1E8598E8F7DA90816A7FEE3972FD698139AD2046");
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = 60;
  var_3 = var_2 * var_2;
  var_4 = 400;
  var_5 = var_4 * var_4;

  while(isalive(self) && !scripts\engine\utility::doinglongdeath()) {
    if(!isalive(self)) {
      return;
    }
    if(scripts\engine\utility::doinglongdeath()) {
      return;
    }
    if(!istrue(var_0.pickedup) && !istrue(var_0.carried)) {
      while(distancesquared(self.origin, var_0.origin) > var_3) {
        if(istrue(var_0.pickedup) || istrue(var_0.carried)) {
          break;
        }

        wait 1;

        if(isalive(self)) {
          send_convoy_soldier_here(var_0.origin);

          if(!var_0 event_can_pickup_hvt(var_1)) {
            self.goalradius = var_1.settings.goal_distance;
            continue;
          }

          scripts\engine\utility::set_movement_speed(190);
          self.goalradius = 80;
        }
      }

      if(isalive(self) && !istrue(var_0.pickedup) && !istrue(var_0.carried) && !istrue(var_0.pickup_disabled) && var_0 event_can_pickup_hvt(var_1) && !istrue(players_nearby_hvt(var_0)) && !istrue(self.little_bird_mg_cp_createfromstructs)) {
        if(istrue(var_0.carried_by_vehicle)) {
          if(istrue(var_1.settings.can_steal_hvt)) {
            self.goalradius = 450;
            thread convoy_steal_hvt_from_player_car();
          } else
            self.goalradius = 1200;

          wait 1;
        } else if(var_1.vehicles_remaining <= 0 && !isDefined(var_1.settings.backup_deposit_names)) {
          self.goalradius = 4000;
          wait 1;
        } else {
          thread first_hvt_pickup(var_0, var_1);
          thread monitor_hvt_pickup(var_0, var_1);
          convoy_pickup_hvt_settings(var_0, var_1);
        }
      }
    } else if(istrue(var_0.pickedup))
      take_cover_near_hvt(var_1);

    var_6 = randomfloatrange(2, 4);
    wait(var_6);
  }
}

convoy_steal_hvt_from_player_car() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getclosest(self.origin, level.vehicle_travel_array);

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 vehicle_getspeed() > 1) {
    return;
  }
  if(!istrue(var_0.stealing_hvt)) {
    var_0.stealing_hvt = 1;
    wait 1.5;

    if(isDefined(var_0)) {
      var_0.stealing_hvt = 0;

      if(var_0 vehicle_getspeed() > 1) {
        return;
      }
      if(isalive(self) && isDefined(var_0) && isDefined(var_0.hostage)) {
        var_1 = level.vehicle_interaction_info["_encstr_88FE111A736CFBB8871823FF0B605F3B922987"];
        _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::exit_retrieve_hostage(var_1, self, var_0);
      }
    }
  }
}

convoy_pickup_hvt_settings(var_0, var_1) {
  var_0.pickedup = 1;
  var_0.pickup_disabled = 1;
  var_0 makeunusable();

  if(isDefined(var_0.trigger))
    var_0.trigger makeunusable();

  if(isDefined(var_0.interaction_handle))
    var_0.interaction_handle makeunusable();

  binoculars_setexpirationtimer(var_0, var_1);

  if(!isalive(self) || scripts\engine\utility::doinglongdeath()) {
    return;
  }
  var_2 = "_encstr_9A8610EB2818A99B30D71B4A31A15E09A177";
  var_3 = 0;
  var_4 = undefined;

  if(istrue(var_1.settings.pickup_uses_origin)) {
    var_3 = -768;
    var_2 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
  }

  var_0 linkTo(self, var_2, (0, 0, var_3), (0, 0, 0));
  self.has_hvt = 1;
  self.dontkilloff = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.maxhealth = 400;
  self.health = self.maxhealth;
  scripts\common\utility::demeanor_override("_encstr_92100762872552A643");
  self.scripted_mode = 1;
  var_0.carrier = self;
  self notify("_encstr_8BCB143FF560013B7D6DF9139163F8B527B9F44F95DB");
  var_0 setCanDamage(0);
  var_0.scripted_mode = 1;

  if(!isDefined(var_0.bodymodel))
    var_0.bodymodel = var_0.model;

  self.default_starting_pistol = level.players[0].default_starting_pistol;

  if(istrue(var_1.settings.hide_icon_on_pickup))
    var_1 objective_icon_show(0);

  self setcarryobject("_encstr_A3CE0D9B4053345287FD8105D7BF2A");

  if(isDefined(var_0.waypoint)) {
    if(isDefined(var_0.sethotfunc))
      var_0 thread[[var_0.sethotfunc]](1);
  }

  if(isagent(var_0)) {
    if(isDefined(var_0.head))
      var_0.head setModel("_encstr_A73F17335B3FCAD728132DB68E5022B183F5C3AF1F53F2AC80");

    var_0 setModel("_encstr_826E178A5069070933481AF241733AE7A0480609F610A30DCB");
    var_0 scripts\cp\cp_vip::disable_outline();

    if(isDefined(var_0.objnum))
      objective_setzoffset(var_0.objnum, 768);
  } else {
    var_0 hide();

    if(isDefined(var_0.body))
      var_0.body hide();

    if(isDefined(var_0.head))
      var_0.head hide();
  }
}

binoculars_setexpirationtimer(var_0, var_1) {
  if(isai(self)) {
    self.scripted_mode = 1;
    self.restoreweapon = self._id_1237E;
    self takeweapon(self.weapon);
    var_0.clearandrestoreinfectedtacinsert = 1;
    var_0.play_trialympic_flames = 1;
    var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);
    var_2.origin = var_0.origin;
    var_2.angles = var_0.angles;
    self._id_12F89 = var_2;
    self._id_12F89 scripts\common\anim::anim_first_frame_solo(var_0.body, "_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868");
    self._id_12F89 thread binoculars_setpendingtimer(self, var_0);
    scripts\asm\shared\mp\utility::burningpartlogic("_encstr_910E24D754B2D196E3E918E0332B5FD88F97597BFB5CD867374253E8BB6B8561620C83D36542", self._id_12F89, undefined, 0, "_encstr_A6F70EB2E633421759FA701F5BF14557");
  }

  if(isDefined(self._id_12F89)) {
    self._id_12F89 delete();
    self._id_12F89 = undefined;
  }

  var_0.clearandrestoreinfectedtacinsert = 0;

  if(!isalive(self))
    return 0;

  if(isDefined(self.restoreweapon))
    self giveweapon(self.restoreweapon);

  self.scripted_mode = 0;
  scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0.play_trialympic_flames = 0;
  return 1;
}

binoculars_setpendingtimer(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 = "_encstr_AA0E125077B3A023C3698394BB695FCB17BF2868";
  var_1.body endon(var_2);
  var_1.body childthread scripts\common\anim::anim_single_solo(var_1.body, var_2);
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_1.idleanim)) {
    var_1.body scriptmodelplayanim(var_1.idleanim);

    if(isDefined(var_1.head))
      var_1.head scriptmodelplayanim(var_1.idleanim);
  }

  var_1.body notify(var_2);
}

event_can_pickup_hvt(var_0) {
  return (isDefined(self.convoy_can_pickup) && istrue(self.convoy_can_pickup) || !isDefined(self.convoy_can_pickup)) && isDefined(var_0.settings) && istrue(var_0.settings.can_pickup_hvt);
}

players_nearby_hvt(var_0) {
  var_1 = 165;
  var_2 = var_1 * var_1;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(!level.players[var_3] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var_3].inlaststand)) {
      continue;
    }
    if(distancesquared(level.players[var_3].origin, var_0.origin) > var_2) {
      continue;
    }
    return 1;
  }

  return 0;
}

first_hvt_pickup(var_0, var_1) {
  if(!istrue(var_1.target_first_interacted)) {
    var_0 notify("_encstr_84EC1422F820C3C5E897405187100FF3D573791A6385");
    var_1.target_first_interacted = 1;
    var_1.target_first_interacted_routing = 1;
    take_cover_near_hvt(var_1);
    wait 1.25;
    var_1.target_first_interacted_routing = undefined;
    take_cover_near_hvt(var_1);
    wait 2.25;

    if(isalive(self) && isDefined(var_1.main_truck)) {
      if(istrue(var_1.settings.toggle_vo_on_hvt_pickup)) {
        if(!isDefined(self.played_convoy_vo)) {
          level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B1CD22911EAF1BC1CDF57B67D8F56C7B379DEDF2FACDABD8B12B6EE6BEE6169959EB130C", "_encstr_9A8507BA4040188D08");
          wait 1.15;
          level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_9B2D206B0FCE2B8AA7899921A14F37EB269DF9E1A9947703CB52200891657DF79ECD");
          self.played_convoy_vo = 1;
        } else {
          level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_819E24613089C1871301B8CC39981E289843AF18988062F8778DF6869808AD85D3C8CCB66BEA", "_encstr_9A8507BA4040188D08");
          wait 1.15;
          level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A72D20A141F54829F56AAC92D27DD189BE11520A13E93A5515F234F4E4B27ACAAF6C");
          self.played_convoy_vo = undefined;
        }
      }
    }

    wait 6;
    var_1.target_first_interacted = undefined;
  }
}

#using_animtree("_encstr_B40101");

take_cover_near_hvt(var_0) {
  if(istrue(var_0.target_first_interacted_routing) && level.gameskill <= 2) {
    send_convoy_soldier_here(self.origin);
    self.goalradius = 1500;
  } else {
    if(isDefined(var_0.main_truck) && isalive(var_0.main_truck) && !istrue(var_0.exiting) && istrue(var_0.settings.route_to_any_veh) && istrue(var_0.not_compromised)) {
      var_1 = getstartorigin(var_0.main_truck.origin, var_0.main_truck.angles, %_encstr_AA952E6E32E4D71B0EAFD0BDDC1D163B597DC89CDE1CF66633F5DA6DB41BB719CCF53616399CF2D7E65BAB3BD98DCA4E);
      send_convoy_soldier_here(var_1, var_0);
    } else if(check_backup_is_set(var_0))
      level thread route_soldiers_towards_backup_location(var_0);

    if(istrue(self.has_hvt))
      self.goalradius = 50;
    else
      self.goalradius = 600;
  }
}

send_convoy_soldier_here(var_0, var_1, var_2) {
  var_3 = getclosestpointonnavmesh(var_0);

  if(isDefined(var_1))
    var_1.convoy_board_pos = var_3;

  self setgoalpos(var_3);

  if(istrue(var_2))
    thread little_bird_mg_cp_initlate(var_3);
  else
    self notify("_encstr_882C16A39C588DD65AB9B3EBD9598E8EDB7DA53BE6BD27AC");
}

little_bird_mg_cp_initlate(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_882C16A39C588DD65AB9B3EBD9598E8EDB7DA53BE6BD27AC");
  self endon("_encstr_882C16A39C588DD65AB9B3EBD9598E8EDB7DA53BE6BD27AC");
  var_1 = 14400;
  self.ignoreall = 1;

  for(;;) {
    if(distancesquared(self.origin, var_0) < var_1)
      self.ignoreall = 0;

    wait 1;
  }
}

monitor_hvt_pickup(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  var_1 endon("_encstr_A10A12DA433D2B8B6167C7DE55B890A755FA9253");
  level notify("_encstr_8E901329E7E8B443D7B3AF77B56A0BC703695B8B1B");
  level endon("_encstr_8E901329E7E8B443D7B3AF77B56A0BC703695B8B1B");
  wait 0.1;

  while(istrue(var_0.clearandrestoreinfectedtacinsert))
    waitframe();

  var_2 = 200;
  var_3 = var_2 * var_2;

  while(isalive(self) && !scripts\engine\utility::doinglongdeath()) {
    wait 0.1;

    if(distance2dsquared(self.origin, var_0.origin) > var_3) {
      var_0.origin = self.origin;
      var_0 linkTo(self, "_encstr_9A8610EB2818A99B30D71B4A31A15E09A177", (0, 0, 0), (0, 0, 0));
    }

    if(isDefined(var_0.carrier)) {
      if(var_0.carrier != self) {
        break;
      }
    }
  }

  if(isagent(var_0)) {
    if(isDefined(var_0.head))
      var_0.head setModel(var_0.head.oldhead);

    var_0 setModel(var_0.bodymodel);
    var_0 scripts\cp\cp_vip::enable_outline();

    if(isDefined(var_0.objnum))
      objective_setzoffset(var_0.objnum, 75);
  } else {
    var_0 show();

    if(isDefined(var_0.body))
      var_0.body show();

    if(isDefined(var_0.head))
      var_0.head show();
  }

  if(isDefined(var_0.waypoint)) {
    if(isDefined(var_0.sethotfunc))
      var_0 thread[[var_0.sethotfunc]](1);
  }

  var_0 unlink();
  self.dontkilloff = 0;
  var_0.pickedup = 0;
  var_0.pickup_disabled = 0;
  self.has_hvt = 0;
  self.ignoreall = 0;
  var_0 setCanDamage(1);
  var_0.scripted_mode = 0;

  if(isDefined(var_0.trigger))
    var_0.trigger makeusable();

  if(isDefined(var_0.interaction_handle))
    var_0.interaction_handle makeusable();

  if(!istrue(var_0.play_trialympic_flames)) {
    var_4 = scripts\cp\cp_pickup_hostage::get_hostage_drop_pos(self);
    var_4 = scripts\cp\cp_pickup_hostage::_getphysicspointaboutnavmesh(var_4) + (0, 0, 2);
    var_0.origin = var_4;
    var_0.angles = (0, var_0.angles[1], 0);
  }

  var_0 thread scripts\cp\cp_pickup_hostage::spawn_module_building_chopper2(self);

  if(isDefined(var_0.idleanim)) {
    var_0.body scriptmodelplayanim(var_0.idleanim);

    if(isDefined(var_0.head))
      var_0.head scriptmodelplayanim(var_0.idleanim);
  }

  hvt_ent_delete_wm(var_1);
  var_1 objective_icon_show(1);
}

hvt_ent_delete_wm(var_0) {
  var_1 = undefined;

  if(isDefined(self.wmhostage))
    var_1 = self.wmhostage;

  if(isDefined(var_0.soldier_wmhostage))
    var_1 = var_0.soldier_wmhostage;

  self resetcarryobject();

  if(isDefined(var_1)) {
    var_1 unlink();

    if(isDefined(var_1.head))
      var_1.head delete();

    var_1 delete();
    var_1 = undefined;
  }
}

spawnheliactorsfunc(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0.convoy objective_icon_show(1);
  var_1 = var_0.convoy.settings.toggle_vo_on_hvt_rescued;
  self unlink();
  wait 0.5;
  self.origin = getclosestpointonnavmesh(self.origin) + (0, 0, 10);
  var_2 = scripts\cp\cp_pickup_hostage::get_hostage_drop_pos(self);
  var_2 = scripts\cp\cp_pickup_hostage::_getphysicspointaboutnavmesh(var_2) + (0, 0, 2);
  self.origin = var_2;
  self.angles = (0, self.angles[1], 0);
  wait 5;

  if(istrue(var_1)) {
    thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_992D20F7338156E9DF52A6DF4CF7899939CB7B7B3BE88CE91DA5ED74258691ABD192");
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_81902331A09FD8FFFBAF070D5B014E7076BBD86A811BD03E922F370F7F4A0B60199546EBE2", "_encstr_9A8507BA4040188D08");
  }
}

waittill_hvt_at_vehicle(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  var_1 endon("_encstr_A10A12DA433D2B8B6167C7DE55B890A755FA9253");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1.main_truck endon("_encstr_9688179BB2DDFAAD854BDCBE36B7CD67BDCB7DB186DEE6569B");
  var_1.main_truck = self;
  var_2 = 96;
  var_3 = var_2 * var_2;

  for(;;) {
    wait 0.5;

    if(!isDefined(var_1.convoy_board_pos)) {
      continue;
    }
    var_4 = distance2dsquared(var_1.convoy_board_pos, var_0.origin);

    if(var_4 > var_3) {
      continue;
    }
    if(!istrue(var_0.pickedup)) {
      continue;
    }
    if(istrue(var_0.carried_by_vehicle)) {
      continue;
    }
    if(istrue(var_0.carried) || isDefined(var_0.carrier) && isPlayer(var_0.carrier)) {
      continue;
    }
    break;
  }

  childthread attach_hvt_to_vehicle(var_0, var_1, 1);
}

attach_hvt_to_vehicle(var_0, var_1, var_2) {
  var_0 unlink();
  var_0.pickedup = 0;
  var_0.pickup_disabled = 0;

  if(isDefined(var_0.carrier)) {
    var_0.carrier.tugofwar_anim = "_encstr_959329D81D44CF0BBADF977ACA6197FB1352FEFDDB9A775BB281872BC8CB8FCBC917AA370DF5081D414EE3";
    var_0.carrier notify("_encstr_81551253E51F5715132A6AA6FBFC875A6925A0C8");
  }

  var_3 = (0, 0, 130);

  if(self.type == "_encstr_8348061DACC643DE")
    var_3 = (0, 0, 86);

  var_4 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";

  if(isagent(var_0))
    var_4 = "_encstr_B63914E80B3BD7EEB43746DCD05AACB1C8BE4C16C6AD";

  if(istrue(var_1.no_tarp)) {
    var_4 = "_encstr_93011173A849F7BA7706E71A7607C389168ADE";
    var_3 = (-96, 0, -13);
  }

  var_0 linkTo(self, var_4, var_3, (0, 180, 0));
  var_0 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");

  if(isDefined(var_0.interaction_handle))
    var_0.interaction_handle makeusable();

  if(!isagent(var_0))
    var_0 makeusable();

  self.has_hvt = 1;
  var_0.convoy_pickedup = 1;
  var_0.carried_by_vehicle = 1;
  var_1.has_hvt = 1;

  if(isDefined(var_0.idleanim)) {
    var_0.body scriptmodelplayanim(var_0.idleanim);

    if(isDefined(var_0.head))
      var_0.head scriptmodelplayanim(var_0.idleanim);
  }

  if(isDefined(var_0.carrier)) {
    if(istrue(var_0.dontkilloff))
      var_0.dontkilloff = 0;

    var_0.carrier thread hvt_ent_delete_wm(var_1);
  }

  if(istrue(self.convoy.settings.pickup_uses_origin)) {
    var_0 setCanDamage(0);
    var_0.ignoreme = 1;
    var_0.scripted_mode = 1;
    var_0.ignoreall = 1;
  }

  self.convoy objective_icon_show(1);

  if(isagent(var_0)) {
    if(isDefined(var_0.head))
      var_0.head setModel(var_0.head.oldhead);

    var_0 setModel(var_0.bodymodel);
    var_0 scripts\cp\cp_vip::enable_outline();

    if(isDefined(var_0.objnum))
      objective_setzoffset(var_0.objnum, 75);
  } else {
    var_0 show();

    if(isDefined(var_0.body))
      var_0.body show();

    if(isDefined(var_0.head))
      var_0.head show();

    if(isDefined(var_0.waypoint)) {
      if(isDefined(var_0.sethotfunc))
        var_0 thread[[var_0.sethotfunc]](1);
    }

    level thread spawnintermission_nocam(var_0, var_1);
  }

  if(istrue(var_2))
    convoy_force_exit();
}

convoy_force_exit() {
  self.convoy.exiting = 1;
  self.convoy notify("_encstr_A10A12DA433D2B8B6167C7DE55B890A755FA9253");
}

spawnintermission_nocam(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB");

  if(isDefined(var_0.waypoint)) {
    if(isDefined(var_0.sethotfunc))
      var_0 thread[[var_0.sethotfunc]](0);

    var_0 notify("_encstr_BAA50F4626B18F0FCF18A2AAE801840B69");
    scripts\cp\cp_objectives::freeworldid("_encstr_88190F07B4B1B5BA83F5A1BDB98E58CECA");
    objective_delete(var_0.waypoint);
    var_0.waypoint = undefined;
  }

  if(isDefined(var_1)) {
    var_1 notify("_encstr_8A3419F627F3838F08A97810A2626D7817D9067D848FA9DBB28290");

    foreach(var_3 in var_1.spawned_vehicles) {
      if(isent(var_3) && istrue(var_3.has_hvt))
        var_3.has_hvt = undefined;
    }
  }

  if(check_backup_is_set(var_1))
    level thread route_soldiers_towards_backup_location(var_1);
}

waittill_return_to_truck(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  var_1 waittill("_encstr_A10A12DA433D2B8B6167C7DE55B890A755FA9253");
  var_0 = var_1.using_path;
  level childthread send_out_convoy_towards_exit(var_0, var_1);
}

send_out_convoy_towards_exit(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  var_1 endon("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  var_2 = 16;
  var_3 = getdvarint("_encstr_883D1BA00AA2FFE99335606537FF90550B52783982F82B83EF48FDD5E4", 0);

  if(var_3 > 0)
    var_2 = var_3;

  if(var_2 > 400)
    var_2 = 400;

  wait 9;
  var_1 notify("_encstr_B2371C528850B3B5B8C7E5F04338FC0B0C26CA8A73BDEBE1C8B31BFB4340");
  level notify("_encstr_B2371C528850B3B5B8C7E5F04338FC0B0C26CA8A73BDEBE1C8B31BFB4340", var_1);
  var_1.allowed_to_exit = 1;
}

slow_down_if_leader() {
  if(isDefined(self.type) && self.type != "_encstr_B87406412C6229ED") {
    return;
  }
  var_0 = undefined;
  var_1 = 1.5;
  var_2 = 2000;

  for(;;) {
    if(isDefined(self.leading_veh)) {
      var_0 = self.veh_speed;
      self.speed_override = 5;
      var_3 = self.leading_veh / var_2 * var_1;
      wait(var_3);
      self.speed_override = var_0;
    }

    wait 10;
  }
}

adjust_vehicle_speed_on_player_dist() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.convoy endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  self.convoy endon("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AB850C5DDC8DED168CF59DBA5EDC");
  self notify("_encstr_AF17172862BCC343E35108F40F9BE8B320DA08518BD22B599B");
  self endon("_encstr_AF17172862BCC343E35108F40F9BE8B320DA08518BD22B599B");

  if(isDefined(self.type) && self.type != "_encstr_B87406412C6229ED") {
    return;
  }
  if(!self vehicle_isphysveh()) {
    return;
  }
  var_0 = 2500;
  var_1 = var_0 * var_0;

  while(isalive(self)) {
    wait 0.5;

    if(!isDefined(level.vehicle_travel_array)) {
      continue;
    }
    var_2 = scripts\engine\utility::getclosest(self.origin, level.vehicle_travel_array, var_0);

    if(!isDefined(var_2)) {
      self.convoy.main_truck.following_player = undefined;

      if(isalive(self) && self vehicle_isphysveh() && isDefined(self.current_path) && !istrue(self.disable_set_speed))
        set_convoy_vehicle_speed(self.current_path.speed, 30, 30);

      continue;
    }

    self.convoy.main_truck.following_player = 1;
    var_3 = var_2 vehicle_getspeed();

    if(var_3 > 15) {
      if(var_3 > 45)
        var_4 = 45;
      else
        var_4 = var_3 + 5;

      foreach(var_6 in self.convoy.spawned_vehicles) {
        if(isalive(var_6))
          var_6 set_convoy_vehicle_speed(var_4, 30, 30);
      }

      continue;
    }

    foreach(var_6 in self.convoy.spawned_vehicles) {
      if(isalive(var_6))
        var_6 set_convoy_vehicle_speed(15, 30, 30);
    }
  }
}

adjust_vehicle_speed_on_center_dist() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.convoy endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  self.convoy endon("_encstr_8CB013EE0FDBABB7308160F85A8A45400FA16E559C");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AB850C5DDC8DED168CF59DBA5EDC");
  self notify("_encstr_BE4E174A878883C2F40870778F839228A551C53958B0C163E2");
  self endon("_encstr_BE4E174A878883C2F40870778F839228A551C53958B0C163E2");

  if(isDefined(self.type) && self.type == "_encstr_B87406412C6229ED") {
    return;
  }
  if(!self vehicle_isphysveh()) {
    return;
  }
  childthread slow_down_if_leader();

  if(isDefined(self.convoy.main_truck) && self == self.convoy.main_truck) {
    return;
  }
  var_0 = 0.25;
  var_1 = 1000;
  var_2 = undefined;

  while(isalive(self)) {
    wait(var_0);
    var_2 = self.convoy.main_truck;

    if(!isDefined(var_2) || istrue(self.convoy.main_truck.following_player)) {
      continue;
    }
    var_3 = var_2;

    if(isDefined(self.pathing_array) && self.pathing_array.size > 0 && isDefined(self.dist_from_node_to_end)) {
      var_4 = [];

      for(var_5 = 0; var_5 < self.convoy.spawned_vehicles.size; var_5++) {
        if(isalive(self.convoy.spawned_vehicles[var_5]) && isDefined(self.convoy.spawned_vehicles[var_5].dist_from_node_to_end))
          var_4[var_4.size] = self.convoy.spawned_vehicles[var_5];
      }

      if(var_4.size > 1) {
        var_6 = scripts\engine\utility::array_sort_with_func(var_4, ::comparevehdisttoends);

        if(var_6[0] == self.convoy.main_truck) {
          var_7 = self.convoy.main_truck.dist_from_node_to_end;
          var_8 = var_6[1].dist_from_node_to_end;
          self.convoy.main_truck.leading_veh = var_7 - var_8;
        } else
          self.convoy.main_truck.leading_veh = undefined;

        var_9 = var_6.size / 2;
        var_3 = undefined;

        for(var_5 = 0; var_5 < var_4.size; var_5++) {
          if(isDefined(var_3)) {
            break;
          }

          var_10 = 0;

          foreach(var_12 in var_6) {
            if(var_12 == self) {
              if(var_10 < var_9) {
                var_3 = var_6[var_10 + 1];
                break;
              } else {
                var_3 = var_6[var_10 - 1];
                break;
              }
            }

            var_10++;
          }
        }
      }
    }

    var_14 = calc_length_of_full_veh_path(var_3);
    var_15 = calc_length_of_full_veh_path(self);
    var_16 = var_3 vehicle_getspeed();
    var_17 = self vehicle_getspeed();

    if(isalive(self.convoy.main_truck)) {
      var_18 = self.convoy.main_truck vehicle_getspeed();
      var_16 = (var_18 * 1 + var_16) / 2;
    }

    var_19 = 1;
    var_20 = undefined;

    if(var_14 == 0) {
      var_0 = 0.25;
      var_1 = 1000;
      var_20 = distance2d(self.origin, var_3.origin);

      if(istrue(self.spawned_after_convoy_center))
        var_19 = var_19 * -1;
    } else {
      var_0 = 0.5;
      var_1 = 2100;
      var_21 = var_14 - var_15;
      var_20 = abs(var_14 - var_15);

      if(var_21 < 0)
        var_19 = var_19 * -1;
    }

    if(!isDefined(var_20)) {
      continue;
    }
    if(var_20 > var_1) {
      var_22 = get_vehicle_adjust_speed(var_17, var_20) * var_19;
      var_23 = var_16 - var_22;
      var_23 = (var_23 + var_16) / 2;

      if(var_23 <= 0)
        var_23 = 1;

      if(isalive(self)) {
        set_convoy_vehicle_speed(var_23, 30, 30);
        self.locksetspeed = 1;
      }

      continue;
    }

    if(isalive(self)) {
      self.locksetspeed = 0;
      var_22 = var_16 + get_vehicle_adjust_speed(var_17, var_20) * var_19;
      var_23 = var_22;
      var_23 = (var_23 + var_16) / 2;

      if(var_23 <= 0)
        var_23 = 1;

      set_convoy_vehicle_speed(var_23, 30, 30);
    }
  }
}

get_vehicle_adjust_speed(var_0, var_1) {
  var_2 = 5000;

  if(var_1 > var_2)
    var_1 = var_2;

  var_3 = var_1 / var_2;
  var_4 = scripts\engine\math::lerp(var_0, 15, var_3);
  return var_4;
}

set_convoy_vehicle_speed(var_0, var_1, var_2) {
  self vehicle_setspeedimmediate(var_0, var_1, var_2);
}

calc_length_of_full_veh_path(var_0) {
  if(!isDefined(var_0.pathing_array))
    return 0;

  if(var_0.pathing_array.size <= 1)
    return 0;

  if(!isDefined(var_0.current_path))
    return 0;

  var_1 = undefined;
  var_2 = undefined;

  for(var_3 = var_0.pathing_array.size - 1; var_3 > 0; var_3--) {
    if(var_0.pathing_array[var_3].origin == var_0.current_path.origin) {
      var_1 = var_0.pathing_array[var_3];
      var_2 = var_3;
      break;
    }
  }

  if(!isDefined(var_1))
    return 0;

  var_4 = 0;

  for(var_5 = var_2; var_5 < var_0.pathing_array.size - 1; var_5++)
    var_4 = var_4 + distance2d(var_0.pathing_array[var_5].origin, var_0.pathing_array[var_5 + 1].origin);

  var_0.dist_from_node_to_end = var_4;
  return var_4;
}

comparevehdisttoends(var_0, var_1) {
  if(var_0.dist_from_node_to_end == var_1.dist_from_node_to_end)
    return var_0.dist_from_node_to_end < var_1.dist_from_node_to_end;
  else
    return var_0.dist_from_node_to_end < var_1.dist_from_node_to_end;
}

objective_icon_show(var_0, var_1) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }
  if(!istrue(var_0)) {
    if(isDefined(self.convoy_objectivestruct.objectiveindex))
      objective_addteamtomask(self.convoy_objectivestruct.objectiveindex, "_encstr_AF8C0A1B6A1D6045925B4F7D");
  } else if(isDefined(self.convoy_objectivestruct.objectiveindex)) {
    objective_addalltomask(self.convoy_objectivestruct.objectiveindex);

    if(isDefined(var_1))
      objective_sethot(self.convoy_objectivestruct.objectiveindex, var_1);
  }
}

objective_icon_override(var_0) {
  if(isDefined(var_0))
    self.convoy_objectivestruct = var_0;
}

objective_icon_attach_to_center_vehicle(var_0, var_1, var_2) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  var_3 = undefined;

  if(isalive(self.main_truck))
    var_3 = self.main_truck;
  else {
    for(var_4 = 0; var_4 < self.spawned_vehicles.size; var_4++) {
      if(isalive(self.spawned_vehicles[var_4])) {
        var_3 = self.spawned_vehicles[var_4];
        break;
      }
    }
  }

  if(!isDefined(var_3)) {
    return;
  }
  if(istrue(var_0)) {
    objective_setplayintro(self.convoy_objectivestruct.objectiveindex, 1);
    objective_setplayoutro(self.convoy_objectivestruct.objectiveindex, 1);
    objective_onentity(self.convoy_objectivestruct.objectiveindex, var_3);
    objective_setzoffset(self.convoy_objectivestruct.objectiveindex, var_1);
  } else {}
}

objective_icon_show_health(var_0) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }
  var_1 = undefined;

  if(isalive(self.main_truck))
    var_1 = self.main_truck;
  else {
    for(var_2 = 0; var_2 < self.spawned_vehicles.size; var_2++) {
      if(isalive(self.spawned_vehicles[var_2])) {
        var_1 = self.spawned_vehicles[var_2];
        break;
      }
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(istrue(var_0)) {
    objective_sethot(self.convoy_objectivestruct.objectiveindex, 1);
    thread hold_health_on_objectiveicon(var_1);
  } else {
    self notify("_encstr_85B314EABB4840D99EF1A7CFDBC882B79861E6B513C8");
    objective_sethot(self.convoy_objectivestruct.objectiveindex, 0);
    var_1 scripts\cp\utility::vehicle_freehealthbarui();
  }
}

objective_icon_show_label(var_0) {
  if(!isDefined(self.convoy_objectivestruct)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 != &"_encstr_B40101")
    objective_setlabel(self.convoy_objectivestruct.objectiveindex, var_0);
  else
    objective_setlabel(self.convoy_objectivestruct.objectiveindex, "_encstr_B40101");
}

hold_health_on_objectiveicon(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_85B314EABB4840D99EF1A7CFDBC882B79861E6B513C8");
  var_1 = var_0.health - var_0.healthbuffer;

  if(var_1 < var_0.health)
    var_1 = var_0.health - var_0.healthbuffer;

  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 190), (0, 0, 0));
  var_3 = scripts\cp\utility::vehicle_gethealthbarid();

  if(!isDefined(var_3)) {
    return;
  }
  var_0.healthbarid = var_3;
  var_4 = scripts\engine\utility::ter_op(isDefined(var_0.script_team) && var_0.script_team != "_encstr_8E8405EA382B2A", 2, 1);

  if(!isDefined(level.healthbars))
    level.healthbars = [];

  level.healthbars[var_0.healthbarid] = var_2;
  setomnvar("_encstr_9B021A17FBD1D16DE7A910F79F6438822C0B0F2BF708D7D1B8E0E571" + var_0.healthbarid, var_2);
  setomnvar("_encstr_883F1B90AAE99388D731E1ED37C350478CE34960C27D2FE6F35DFFD1DF" + var_0.healthbarid, var_4);
  setomnvar("_encstr_8E251D5D5ABE4BDCB316D62B7DB1B4D91A8E7DE80B73DABE34CAB01BA30DFA" + var_0.healthbarid, 1);

  for(;;) {
    var_5 = var_0.health - var_0.healthbuffer;
    setomnvar("_encstr_8E251D5D5ABE4BDCB316D62B7DB1B4D91A8E7DE80B73DABE34CAB01BA30DFA" + var_0.healthbarid, var_5 / var_1);
    wait 0.2;
  }
}