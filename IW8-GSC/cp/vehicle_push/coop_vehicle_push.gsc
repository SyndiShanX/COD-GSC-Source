/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicle_push\coop_vehicle_push.gsc
*************************************************/

start_coop_push(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("_encstr_8DA40DB1F6B783F5E057B9D07DC6B9");
  level.get_mortar_impact_pos = ::get_mortar_impact_spot;
  level.bomb_defusal_success_func = ::blockade_bomb_defusal_success_func;
  level.process_entities_inside_subway_car = ::computermakingnose;
  level.open_trap_room_door = ::cp_arms_dealer_sound_load;
  level.unloading_func["_encstr_88520840BAB5F918BF78"] = scripts\cp\raid_utility::_id_129E7;
  level.unloading_func["_encstr_BEDB0ABB93F56A5919C1C782"] = ::_id_129ED;
  level.unloading_func["_encstr_B88216702D6F443D40E26F9EA56B6F4201D9F0CB66724ECA"] = ::_id_129EC;
  scripts\cp\cp_modular_spawning::register_aitype_setup("_encstr_850707F7E5833355B8", "_encstr_B44F218EB970BFEB680B0327732361EBF886C21353D17C5256130B7B2FCEBA29A0A97A", undefined, undefined);
  scripts\cp\cp_modular_spawning::register_aitype_setup("_encstr_8A910B8AB8C999EAEA3471A933", "_encstr_867B25E7B62D887EFE902B0FF9EB26BE805871538A17BDF7431B2BCB071A53119FFA77655FC8E1", undefined, undefined);
  setDvar("_encstr_A3C00A15E94D45352D6A2AD3", 0);
  scripts\cp\raid_utility::assignspectatortospectatetryagain(["_encstr_ABB50ED2E7730D4E6B3997604721BB58"]);
  scripts\cp\raid_utility::set_raid_checkpoint("_encstr_B2220F390BA5C8AFD8EDF6E0AF1CEA3743", "_encstr_B61317EE85AAB9BE209FD8784F5890D393AFDE781AF363C30C");
  hide_enemy_mortar_shell();
  assign_more_vehicle_unload_groups();
  set_up_modular_spawning();
  ascendermodelworld();
  scripts\cp\bomb_defusal\coop_bomb_defusal::start_coop_bomb_defusal_sequence("_encstr_B839218B60E86BBAD32547F11EE79232B648EF1330C3A112574ECDB57D858AF438F83B");
  deploy_enemy_turrets();
  scripts\cp\raid_utility::init_player_achievements("_encstr_93370EDCCD4B832BE4AF07B436DA5D0E", "_encstr_95591C34F5179B47055110D8491A0D366F943F2349EE4BDFEEAB202822F2", &"_encstr_ADCC212B111911D19D90AC17AF936039A92FF754E2D1331E839E47994F4759B3378F02", "_encstr_B4190F4BDDC1BE9BB9D70BB10786584D0C", ["_encstr_8BEB08833B38890A08A7"]);
  set_up_blockade_gates();
  level thread close_blockade_gates();
  level thread blockade_landmine();
  level thread computer_interface_think_internal();
  level thread computer_listener_all();
  level thread associate_digit_display_model();
  level thread vehicle_progress_marker_think();
  level thread player_progress_market_think();

  if(1) {
    level thread scripts\asm\soldier\ground_turret::survival_ai_manager(::_id_11ABA);
    level.sentrysettings["_encstr_A2860EB5C2E6735932BE8E5DE49C593A"].overheattime = 6;
    level.sentrysettings["_encstr_A2860EB5C2E6735932BE8E5DE49C593A"].cooldowntime = 0.75;
    level.sentrysettings["_encstr_A2860EB5C2E6735932BE8E5DE49C593A"].burstmin = 60;
    level.sentrysettings["_encstr_A2860EB5C2E6735932BE8E5DE49C593A"].burstmax = 90;
    level.sentrysettings["_encstr_A2860EB5C2E6735932BE8E5DE49C593A"].pausemin = 0.2;
    level.sentrysettings["_encstr_A2860EB5C2E6735932BE8E5DE49C593A"].pausemax = 0.35;
  }

  level waittill("_encstr_8E581D588A959738DF04D5C00B17A373FF52D8F8112AE371BF2DE6CEF67F48");
  scripts\cp\bomb_defusal\coop_bomb_defusal::spawn_and_hide_usb();
  stop_all_spawn_groups();
  linkoffset();
  brdisablefinalkillcam();
  scripts\cp\cp_create_script_utility::cleanup_cs_file_objects("_encstr_8DA40DB1F6B783F5E057B9D07DC6B9");
}

_id_11ABA() {
  thread scripts\asm\soldier\ground_turret::lockscriptabledoors(1);
}

islongshotspecial() {
  while(!isDefined(level.player) || !isalive(level.player))
    wait 1;

  setDvar("_encstr_917A0B2339DE38FAE0A1DE9B59", "_encstr_B40101");
  wait 1;

  while(getDvar("_encstr_917A0B2339DE38FAE0A1DE9B59") != "_encstr_A34C02BB")
    wait 1;

  scripts\cp\bomb_defusal\coop_bomb_defusal::drop_bomb_detonator_from_ai(level.player, "_encstr_B19C0A98DEDA98FAC685CD59");
}

debug_pre_start_coop_push(var_0) {
  scripts\cp\coop_escort::delay_teleport_players(2, "_encstr_86151739287203B7C82F9EC091CA33E7FEEAE5C0928D6B67A5", "_encstr_B61317EE85AAB9BE209FD8784F5890D393AFDE781AF363C30C");
  _id_13102();
}

init() {
  scripts\engine\utility::flag_init("_encstr_83802B4B7990B9FAF10BC7734D28E2FA50038214D0584762D91B5F672F434A3608EE7E9F09F03F0BA519B77799");
  scripts\engine\utility::flag_init("_encstr_923A15DBC7AE534F1888252E80E8BC9A10771F2745DF1B");
  scripts\engine\utility::flag_init("_encstr_828C1CF8AF994843F19FCDD397BB98D8200683B0D4CE8868DB77E3C7AF12");
  load_vfx();
  _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::load_fx();
  level.pindia_positions_override_func = ::pindia_positions_override_func;
  build_vehicles();
}

pindia_positions_override_func(var_0) {
  var_0[0].canshootinvehicle = 0;
  var_0[1].canshootinvehicle = 1;
  var_0[2].canshootinvehicle = 1;
  var_0[3].canshootinvehicle = 1;
  var_0[4].canshootinvehicle = 1;
  var_0[5].canshootinvehicle = 1;
  return var_0;
}

_id_13102() {
  deploy_vehicle_to_push();
}

start_vehicle_push_sequence() {
  set_up_modular_spawning();
}

blockade_bomb_defusal_success_func() {
  level thread scripts\cp\bomb_defusal\coop_bomb_defusal::playerpowerscleanuphud();
  _id_138C3();
  wait 1.5;
  asm_animhasfacialoverridemp();
}

deploy_vehicle_to_push() {
  var_0 = getEnt("_encstr_845D1B81F253480E7B3FA59BFBF2DE18ED41AB1B1AB011C4E29BAB83E7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_8E8119FBFF0280A8349183F944016849DAE74953075A401874744B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getvehiclenode("_encstr_8801155763106723C5472B7F3163FAAC984E4A9B59F024", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawnVehicle("_encstr_AFA722AB1133BA399D340A4F1DE641B98393BBC3A02220165AC9C6FB379F6073485390CB", "_encstr_93221625463BD7B9647728607F879339312B15A3DC42B9E1", "_encstr_BAE70F6F0CB29960293FB870CF5338CFCB", var_2.origin, var_2.angles);
  var_3 attachpath(var_2);
  var_3 startpath();
  var_3 vehicle_setspeedimmediate(0, 1, 1);
  var_3 hidepart("_encstr_883A0A937978CE737D77D823");
  var_3 hidepart("_encstr_AB0111A37657C9870ACF83B7979256B0D79AE3");
  var_3 thread vehicle_to_push_damage_monitor(var_3);
  var_3 thread reach_end_monitor(var_3);
  var_3 set_up_bomb_model_marker(var_3);
  var_3.little_bird_mg_enterend = 1;
  var_3.obj_ow_atvs_spawned = var_0;
  var_3.obj_overwatch_tanks_ref = var_1;
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
  var_4 notsolid();
  var_4 setModel("_encstr_9A1919B3AC340EBED6B41BAFD8B919FA83D2CD32D22CEB13B7AD89");
  var_4.angles = var_3.angles;
  var_4 linkTo(var_3, "_encstr_958313D185CEEBDEC9B4CED2E6BE85DC4BD685E8CA");
  var_4 thread cpoperationcrateactivatecallback(var_3, var_4);
  level.vehicle_to_push = var_3;
  var_1 linkTo(var_3);
  var_0 enablelinkTo();
  var_0 linkTo(var_3);
  var_0 thread player_push_monitor(var_0, var_3);
}

set_up_bomb_model_marker(var_0) {
  var_1 = 5;
  var_2 = 1;
  var_3 = anglestoleft(var_0.angles);
  var_4 = anglestoup(var_0.angles);
  var_5 = scripts\engine\utility::getStruct("_encstr_8B291C138788A8562A6747E9B7E127804B5CBE29ADE588AF125F15DFB71B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin + var_3 * var_1 + var_4 * var_2);
  var_6 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6.angles = var_5.angles;
  var_6 linkTo(var_0);
  var_0.bomb_model = var_6;
}

activate_bomb_interactions(var_0, var_1) {
  var_2 = _id_11A90(var_0);
  var_2 thread _id_12398(var_2, var_0);
}

_id_11A90(var_0) {
  var_1 = var_0.bomb_model.origin;
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = var_0.bomb_model.angles;
  var_2 makeusable();
  var_2 setHintString(&"_encstr_846C1B683DD3A0BECA5109946831A8AF28AA9A90BC0589A06815D70D1A");
  var_2 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_2 sethintdisplayrange(156);
  var_2 sethintdisplayfov(90);
  var_2 setuserange(128);
  var_2 setusefov(60);
  var_2 sethintonobstruction("_encstr_BD1805CB69C063");
  var_2 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_2 linkTo(var_0);
  return var_2;
}

_id_12398(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isPlayer(var_2)) {
      var_2 playSound("_encstr_816F111E80487F8F62F7C238BD53477BE87B7B");
      break;
    }
  }

  place_bomb_in_the_vehicle(var_1);
  var_0 delete();
}

place_bomb_in_the_vehicle(var_0) {
  var_0.bomb_model setModel("_encstr_AD59209DA10CD9C97B322E38689F0EE370B59377E2A75F57118DD5DD76A6BA6EC090");
  var_0.bomb_model notsolid();
  var_0 playSound("_encstr_8BF811E92B51CFF8EA31433742F6D169C8C0BF");
  var_0.bomb_is_loaded = 1;
  try_activate_final_bomb_detonate_sequence(var_0);
}

asm_animhasfacialoverridemp() {
  foreach(var_1 in level.bombs_for_coop_bomb_defusal)
  var_1 thread forbiddencachespawns(var_1);
}

forbiddencachespawns(var_0) {
  var_1 = _id_11A78(var_0.c4);

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isPlayer(var_2)) {
      break;
    }
  }

  activate_bomb_interactions(level.vehicle_to_push, var_2);

  foreach(var_4 in var_0.wire_look_at_markers)
  var_4.wire_model delete();

  var_0.c4 delete();
  var_1 delete();
  return;
}

_id_11A78(var_0) {
  var_1 = var_0.origin + anglestoup(var_0.angles) * 1;
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = var_0.angles;
  var_2 makeusable();
  var_2 setHintString(&"_encstr_8E6A1D67419C5317497950A9F6799D59D7A5193C50B284C6410827D991614A");
  var_2 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_2 sethintdisplayrange(156);
  var_2 sethintdisplayfov(90);
  var_2 setuserange(128);
  var_2 setusefov(60);
  var_2 sethintonobstruction("_encstr_BD1805CB69C063");
  var_2 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_2 linkTo(var_0);
  return var_2;
}

player_push_monitor(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_4 = get_num_of_player_touching_volume(var_0);

    if(var_4 > 0)
      level notify("_encstr_AA9318CEB2D05A1B8DB2BEA5DCD7262B5AB9CED7E05D37862B46");

    if(var_2 != var_4) {
      var_1 vehicle_setspeedimmediate(get_new_vehicle_speed(var_4), 1, 1);

      if(var_4 > 0) {
        if(var_3 == 0) {
          var_1 playLoopSound("_encstr_9560191DB2AD0E7D67AC864BB136CAF5E6BAE46658D895D7B9661E");
          var_3 = 1;
        }
      } else {
        var_1 stoploopsound("_encstr_9560191DB2AD0E7D67AC864BB136CAF5E6BAE46658D895D7B9661E");
        var_3 = 0;
      }

      var_2 = var_4;
    }

    waitframe();
  }
}

get_new_vehicle_speed(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 1:
      var_1 = 1.405;
      break;
    case 2:
      var_1 = 2.81;
      break;
    case 3:
      var_1 = 2.81;
      break;
    case 4:
      var_1 = 2.81;
      break;
  }

  return var_1;
}

get_num_of_player_touching_volume(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }
    if(var_3 getstance() == "_encstr_922406F1A6FD5E05") {
      continue;
    }
    if(var_3 istouching(var_0)) {
      set_player_is_pushing_vehicle(var_3);
      var_1++;
    }
  }

  return var_1;
}

set_player_is_pushing_vehicle(var_0) {
  if(!istrue(var_0.is_pushing_vehicle)) {
    var_0.is_pushing_vehicle = 1;
    var_0 thread continue_to_push_monitor(var_0);
  }
}

unset_player_is_pushing_vehicle(var_0) {
  if(istrue(var_0.is_pushing_vehicle))
    var_0.is_pushing_vehicle = 0;
}

continue_to_push_monitor(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 playerlinkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 linkTo(level.vehicle_to_push);
  var_1 thread player_mover_clean_up_monitor(var_0, var_1);
  var_0 thread player_push_vehicle_stance_update_think(var_0);

  for(;;) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
      break;
    }

    if(!player_controller_push_along_vehicle(var_0)) {
      break;
    }

    waitframe();
  }

  var_0 unlink();
  var_0 allowstand(1);
  var_0 allowcrouch(1);
  var_0 allowprone(1);
  var_0 notify("_encstr_959C15BF99D86B37E0F38A54684857D12CC35B4F1FF1E2");

  if(isDefined(var_1))
    var_1 delete();

  unset_player_is_pushing_vehicle(var_0);
}

player_mover_clean_up_monitor(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::_id_143AD("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_1 delete();
}

player_controller_push_along_vehicle(var_0) {
  var_1 = var_0 getnormalizedmovement();
  var_2 = var_1[0];
  var_3 = var_1[1];

  if(abs(var_2) == 0 && abs(var_3) == 0)
    return 0;

  var_4 = get_player_controller_direction_in_world(var_0);
  var_5 = anglesToForward(level.vehicle_to_push.angles);
  var_6 = acos(vectordot(var_4, var_5));
  return var_6 >= 0 && var_6 <= 30 || var_6 >= 330 && var_6 < 360;
}

get_player_controller_direction_in_world(var_0) {
  var_1 = anglesToForward(var_0 getplayerangles());
  var_2 = anglestoright(var_0 getplayerangles());
  var_3 = var_0 getnormalizedmovement();
  var_4 = var_3[0];
  var_5 = var_3[1];
  return vectorNormalize((var_1 * var_4 + var_2 * var_5) * (1, 1, 0));
}

player_push_vehicle_stance_update_think(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_959C15BF99D86B37E0F38A54684857D12CC35B4F1FF1E2");
  var_0 notify("_encstr_855E28C1B185F2AC9C7D07AEB9A1BE3B560D5AC61B597D378E2C376CAC7D57E08C2CD1B2D78E345A9B6D");
  var_0 endon("_encstr_855E28C1B185F2AC9C7D07AEB9A1BE3B560D5AC61B597D378E2C376CAC7D57E08C2CD1B2D78E345A9B6D");
  var_1 = var_0 getstance();

  switch (var_1) {
    case "_encstr_A5AD069B231F0BAF":
      var_0 allowstand(1);
      var_0 allowcrouch(0);
      var_0 allowprone(0);
      break;
    case "_encstr_B13D076BED70539F23":
      var_0 allowcrouch(1);
      var_0 allowstand(0);
      var_0 allowprone(0);
      break;
    default:
      break;
  }

  var_0 notifyonplayercommand("_encstr_92BB0EC05A863D097FAF4EC569AB71E3", "_encstr_A6E308B2DCE8B0B936B2");

  for(;;) {
    var_0 waittill("_encstr_92BB0EC05A863D097FAF4EC569AB71E3");
    var_1 = var_0 getstance();

    switch (var_1) {
      case "_encstr_A5AD069B231F0BAF":
        var_0 allowcrouch(1);
        var_0 allowstand(0);
        var_0 allowprone(0);
        break;
      case "_encstr_B13D076BED70539F23":
        var_0 allowstand(1);
        var_0 allowcrouch(0);
        var_0 allowprone(0);
        break;
      default:
        break;
    }
  }
}

vehicle_to_push_damage_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0.maxhealth = 999999;

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;
    var_0.maxhealth = 999999;
  }
}

reach_end_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_8EE01139CA2C6C0D958CAF2B7346D737ED8CAC");
  var_0.reached_end_node = 1;
  try_activate_final_bomb_detonate_sequence(var_0);
}

try_activate_final_bomb_detonate_sequence(var_0) {
  if(!istrue(var_0.reached_end_node)) {
    return;
  }
  if(!istrue(var_0.bomb_is_loaded)) {
    return;
  }
  var_1 = get_nearby_players(var_0);

  foreach(var_3 in var_1)
  var_3 thread nearby_player_detonate_monitor(var_3, var_0);

  foreach(var_6 in level.players)
  var_6 thread display_get_away_from_vehicle_message(var_6, var_0);
}

nearby_player_detonate_monitor(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 thread display_detonate_hint_message(var_0, var_1);
  var_0 thread detonate_the_bomb_monitor(var_0, var_1);
}

get_nearby_players(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(distance2dsquared(var_3.origin, var_0.origin) < 360000)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

display_get_away_from_vehicle_message(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(distance2dsquared(var_0.origin, var_1.origin) < 360000)
      var_0 scripts\cp\utility::setlowermessage("_encstr_93601DFBAF9FF14B41EF9E8597C8D7D92BE8F82B18415D3F8F0FDD2DB378F7", &"_encstr_88B928A1D3E90AF5CA1512293489A8F582AA4D42BCA3A82AD714D50AB27D9194E9A9EB2BA242291A268A");
    else
      var_0 scripts\cp\utility::clearlowermessage("_encstr_93601DFBAF9FF14B41EF9E8597C8D7D92BE8F82B18415D3F8F0FDD2DB378F7");

    waitframe();
  }
}

display_detonate_hint_message(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_8FE222F39033B07FAB70A8A275D37FFF51713BEA70F7AE9FA0C6BFAC1D1BC7C58380F2C3");

  for(;;) {
    if(distance2dsquared(var_0.origin, var_1.origin) >= 360000)
      var_0 scripts\cp\utility::setlowermessage("_encstr_A66919483A73AFB8FFF43520FE07607BDD21F088D28E9730F70645", &"_encstr_9AE7253117672F9F79472BA32E306336809729E12EC4C5F1B0BDB7D5B739357C3553C159DF963F");
    else
      var_0 scripts\cp\utility::clearlowermessage("_encstr_A66919483A73AFB8FFF43520FE07607BDD21F088D28E9730F70645");

    waitframe();
  }
}

detonate_the_bomb_monitor(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_8FE222F39033B07FAB70A8A275D37FFF51713BEA70F7AE9FA0C6BFAC1D1BC7C58380F2C3");
  var_0 notifyonplayercommand("_encstr_A56712D3FD7D381EE7B571396BCC4880153F5536", "_encstr_97410B23BD6B976233901AF2F8");
  var_0 notifyonplayercommand("_encstr_A56712D3FD7D381EE7B571396BCC4880153F5536", "_encstr_B4C60AD707B2BDC0E6CE1309");

  for(;;) {
    var_0 waittill("_encstr_A56712D3FD7D381EE7B571396BCC4880153F5536");

    if(distance2dsquared(var_0.origin, var_1.origin) < 360000) {
      continue;
    }
    var_1 thread the_bomb_is_detonated(var_0, var_1);
    return;
  }
}

the_bomb_is_detonated(var_0, var_1) {
  var_1 notify("_encstr_8FE222F39033B07FAB70A8A275D37FFF51713BEA70F7AE9FA0C6BFAC1D1BC7C58380F2C3");

  foreach(var_0 in level.players)
  var_0 scripts\cp\utility::clearlowermessage("_encstr_A66919483A73AFB8FFF43520FE07607BDD21F088D28E9730F70645");

  var_4 = getcompleteweaponname("_encstr_B14F0C678148B28D585B90111030");
  var_0 giveandfireoffhand(var_4);
  level thread kingslayerkills(var_1);
  wait 1;
  var_0 takeweapon(var_4);
}

kingslayerkills(var_0) {
  wait 0.65;
  level thread vehicle_to_push_explode_sequence(var_0);
}

vehicle_to_push_explode_sequence(var_0) {
  foreach(var_2 in level.players)
  var_2 scripts\cp\utility::clearlowermessage("_encstr_93601DFBAF9FF14B41EF9E8597C8D7D92BE8F82B18415D3F8F0FDD2DB378F7");

  var_0 playSound("_encstr_BAE710E54853EF0127F728A88F54B9B73A72");
  computer_player_listener();
  var_0.bomb_model delete();
  var_0.obj_ow_atvs_spawned delete();
  var_0.obj_overwatch_tanks_ref delete();
  var_0 delete();
  level thread open_blockade_gates();
  level notify("_encstr_8872162A913096FFE7D1329939CF430AE87BB28F27905CDB", "_encstr_A25F0710622DF3B3D7");
  level notify("_encstr_8E581D588A959738DF04D5C00B17A373FF52D8F8112AE371BF2DE6CEF67F48");
}

computer_player_listener() {
  var_0 = (39906.7, 15306, -357.645);
  var_1 = (0, 116.999, 0);
  scripts\cp\raid_utility::pausemodetimer("_encstr_9221203B991E7DD8E0EB2785B423EB13C67B6CDA85192B7DB30BE82BFA2B1E071B7B", var_0, var_1);
}

deploy_enemy_turrets() {
  scripts\engine\utility::flag_init("_encstr_A2D42EE7880B12B126700F2B785974F9C7102D18F8816AE249900397809059C3BBB672195BCDC13350C07B8FC8A81ECA");
  scripts\engine\utility::flag_set("_encstr_A2D42EE7880B12B126700F2B785974F9C7102D18F8816AE249900397809059C3BBB672195BCDC13350C07B8FC8A81ECA");
  var_0 = undefined;

  if(1)
    var_0 = scripts\engine\utility::getStructArray("_encstr_A2860EB5C2E6735932BE8E5DE49C593A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  level.enemy_turrets = [];
  var_1 = scripts\engine\utility::getStructArray("_encstr_8B01145940C3E0DBBEFB6B96802B3BA7D929FBA80F3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    if(1 && isDefined(var_0) && var_0.size > 0) {
      var_0 = sortbydistance(var_0, var_3.origin);

      if(distancesquared(var_0[0].origin, var_3.origin) < 4096)
        continue;
    }

    deploy_enemy_turret(var_3);
  }
}

delete_on_death(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

spawn_tag_origin(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_1), var_1, (0, 0, 0));
  return var_2;
}

deploy_enemy_turret(var_0) {
  var_1 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0.origin, "_encstr_8C971096BB1CF55B3BF54D60C62C1BD7C683");
  var_1.angles = var_0.angles;
  var_1 setModel("_encstr_97361AEE590B0EDEE6F55B3BAF4C392CECBDA603F5135836D87BDCE5");
  var_1 setturretteam("_encstr_8E8405EA382B2A");
  var_1 setmode("_encstr_849007B268BD03DFD8");
  var_1 setdefaultdroppitch(90);
  var_1 setleftarc(180);
  var_1 setrightarc(180);
  var_1 settoparc(180);
  var_1 setbottomarc(180);
  var_1 setconvergencetime(0, "_encstr_AF1904C7E3A4");
  var_1 setconvergencetime(0, "_encstr_BD6506F36A2B46B0");
  var_1 makeunusable();
  var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.target_ent = spawn_tag_origin(var_2.origin, var_2.angles);
  var_1.target_ent_marker = var_2;
  var_1 settargetentity(var_1.target_ent);
  var_1.speed = 150;
  var_1.wait_between_shots = 0.1;
  var_1.wait_between_shot_round = 1.5;
  var_1.shots_per_round = 70;
  var_1.track_target_delay = 0.1;
  var_1.warning_time = 0.5;
  level.enemy_turrets[level.enemy_turrets.size] = var_1;
  var_1.target_ent thread delete_on_death(var_1.target_ent, var_1);
}

activate_enemy_turret(var_0) {
  if(istrue(var_0.little_bird_mg_reenter)) {
    return;
  }
  var_0 thread enemy_turret_fire_think(var_0);
  var_0 thread player_monitor(var_0);
  var_0 thread combat_logic(var_0);
}

deactivate_enemy_turret(var_0) {
  var_0 notify("_encstr_9322182D470ADF9B79D3085867B7710D92ED1B389B2385035DF3");
  stop_firing(var_0);
}

combat_logic(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_9322182D470ADF9B79D3085867B7710D92ED1B389B2385035DF3");
  var_0 thread target_select_think(var_0);
  var_1 = undefined;

  for(;;) {
    if(isDefined(var_0.current_target)) {
      if(is_different_target(var_1, var_0.current_target)) {
        stop_firing(var_0);
        wait(randomfloatrange(0.5, 1));
      }

      if(!isDefined(var_1))
        start_firing(var_0);
    } else
      stop_firing(var_0);

    var_1 = var_0.current_target;
    wait 0.5;
  }
}

is_different_target(var_0, var_1) {
  return isDefined(var_0) && var_0 != var_1;
}

target_select_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_9322182D470ADF9B79D3085867B7710D92ED1B389B2385035DF3");
  var_0.current_target = undefined;

  for(;;) {
    var_1 = scripts\cp\raid_utility::get_players_not_in_laststand();

    if(scripts\engine\utility::flag("_encstr_A2D42EE7880B12B126700F2B785974F9C7102D18F8816AE249900397809059C3BBB672195BCDC13350C07B8FC8A81ECA"))
      var_1 = get_players_in_killzone(var_1);

    var_2 = 9;
    var_3 = undefined;

    foreach(var_5 in var_1) {
      var_6 = get_player_target_score(var_5, var_0);

      if(var_6 > var_2) {
        var_2 = var_6;
        var_3 = var_5;
      }
    }

    if(isDefined(var_3)) {
      var_0.current_target = var_3;
      var_0.target_ent.origin = get_target_ent_position_on_player(var_3, var_0);
    } else {
      var_0.current_target = undefined;
      var_0.target_ent.origin = var_0.target_ent_marker.origin;
    }

    wait 0.05;
  }
}

get_players_in_killzone(var_0) {
  var_1 = [];
  var_2 = getEnt("_encstr_828E11B96A91D84C5277C7CB93EA98903FC5C1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_0) {
    if(var_4 istouching(var_2))
      var_1[var_1.size] = var_4;
  }

  return var_1;
}

player_is_in_killzone(var_0) {
  var_1 = getEnt("_encstr_828E11B96A91D84C5277C7CB93EA98903FC5C1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0 istouching(var_1))
    return 1;
  else
    return 0;
}

get_target_ent_position_on_player(var_0, var_1) {
  var_2 = var_0 getvelocity();
  var_3 = var_1 gettagorigin("_encstr_A14F0AE336178944BA076F41");
  var_4 = distance(var_3, var_0.origin);
  var_5 = var_4 / 6000;
  var_6 = var_0.origin + var_2 * var_5;

  if(is_player_part_exposed_to_enemy_turret(var_0, var_1, "_encstr_97FE07DE392D76D2CD"))
    return var_6;
  else
    return var_6 + (var_0 getEye() - var_0.origin);
}

get_player_target_score(var_0, var_1) {
  var_2 = 25000000;
  var_3 = 0;

  if(is_player_part_exposed_to_enemy_turret(var_0, var_1, "_encstr_A6180438A081"))
    var_3 = var_3 + 45;

  if(is_player_part_exposed_to_enemy_turret(var_0, var_1, "_encstr_97FE07DE392D76D2CD"))
    var_3 = var_3 + 45;

  var_4 = distance2dsquared(var_0.origin, var_1.origin);
  var_3 = var_3 + 9 * (1 - clamp(var_4 / var_2, 0, 1));
  return var_3;
}

is_player_part_exposed_to_enemy_turret(var_0, var_1, var_2) {
  var_3 = var_1.player_exposure_data[var_0 getentitynumber()];
  return scripts\engine\utility::array_contains(var_3.loc_exposed_to_enemy_turret, var_2);
}

player_monitor(var_0) {
  foreach(var_2 in level.players)
  var_2 thread enemy_turret_player_monitor(var_2, var_0);

  level thread enemy_turret_players_connect_monitor(var_0);
}

enemy_turret_players_connect_monitor(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_9322182D470ADF9B79D3085867B7710D92ED1B389B2385035DF3");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    var_1 thread enemy_turret_player_monitor(var_1, var_0);
  }
}

enemy_turret_player_monitor(var_0, var_1) {
  var_0 thread exposure_monitor(var_0, var_1);
  var_0 thread speed_monitor(var_0, var_1);
}

exposure_monitor(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_9322182D470ADF9B79D3085867B7710D92ED1B389B2385035DF3");

  if(!isDefined(var_1.player_exposure_data))
    var_1.player_exposure_data = [];

  var_2 = var_0 getentitynumber();
  var_3 = spawnStruct();
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
  var_3.exposed_to_enemy_turret_time = 0;

  for(;;) {
    var_3.loc_exposed_to_enemy_turret = [];

    if(scripts\engine\trace::ray_trace_passed(var_0.origin, var_1 gettagorigin("_encstr_8E300878E04AE8B18198"), [var_1], var_4))
      var_3.loc_exposed_to_enemy_turret[var_3.loc_exposed_to_enemy_turret.size] = "_encstr_97FE07DE392D76D2CD";

    if(scripts\engine\trace::ray_trace_passed(var_0 getEye() + (0, 0, -5), var_1 gettagorigin("_encstr_8E300878E04AE8B18198"), [var_1], var_4))
      var_3.loc_exposed_to_enemy_turret[var_3.loc_exposed_to_enemy_turret.size] = "_encstr_A6180438A081";

    if(var_3.loc_exposed_to_enemy_turret.size > 0)
      var_3.exposed_to_enemy_turret_time = var_3.exposed_to_enemy_turret_time + 0.05;
    else
      var_3.exposed_to_enemy_turret_time = 0;

    var_1.player_exposure_data[var_2] = var_3;
    waitframe();
  }
}

speed_monitor(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_9322182D470ADF9B79D3085867B7710D92ED1B389B2385035DF3");

  for(;;) {
    var_2 = var_0.origin;
    wait 0.05;
    var_3 = var_0.origin;
    var_0.speed = length(var_2 - var_3);
  }
}

enemy_turret_fire_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_9322182D470ADF9B79D3085867B7710D92ED1B389B2385035DF3");

  for(;;) {
    var_0 waittill("_encstr_99570D833B0773A33905B9AA33982F");
    reset_enemy_turret_shot_count(var_0);
    wait(var_0.warning_time);

    while(enemy_turret_should_keep_firing(var_0)) {
      fire_one_shot(var_0);
      wait(var_0.wait_between_shots);

      if(!should_continue_current_shot_run(var_0)) {
        if(get_shot_fired(var_0) == var_0.shots_per_round) {
          reset_enemy_turret_shot_count(var_0);
          wait(var_0.wait_between_shot_round);
        }

        if(!enemy_turret_should_keep_firing(var_0)) {
          break;
        }
      }
    }
  }
}

fire_one_shot(var_0) {
  var_0 shootturret();
  var_0.shot_count++;
}

reset_enemy_turret_shot_count(var_0) {
  var_0.shot_count = 0;
}

enemy_turret_should_keep_firing(var_0) {
  return istrue(var_0.keep_firing);
}

start_firing(var_0) {
  var_0.keep_firing = 1;
  var_0 notify("_encstr_99570D833B0773A33905B9AA33982F");
}

stop_firing(var_0) {
  var_0.keep_firing = 0;
}

should_continue_current_shot_run(var_0) {
  if(!enemy_turret_should_keep_firing(var_0))
    return 0;

  if(get_shot_fired(var_0) == var_0.shots_per_round)
    return 0;

  return 1;
}

get_shot_fired(var_0) {
  return var_0.shot_count;
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
  level thread enemy_spawner_vehicle_spawned_monitor();

  if(level.script == "_encstr_8D5C0C360ED7318DB736DA0B32AC")
    cp_blockade_spawning();
  else if(level.script == "_encstr_AC530FEAD3702BBEA039A770D918C2BFAF" || level.script == "_encstr_ACFA0BB7B381457BEEDF03FB44" || level.script == "_encstr_ABB40E5E9BB78D683307878123218F50")
    cp_donetsk_spawning();
}

cp_donetsk_spawning() {
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A234126927D28D41A55D617880B750452BD3E3D1", 1, 1, 999999, [::_id_143CE, 1, 10, 20], undefined, ::select_left_turret_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8D1B134EA59D1A3AAF95DC2BDA5EEB3AAB4E392BD1", 1, 1, 999999, [::_id_143CE, 1, 10, 20], undefined, ::select_right_turret_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8726149FFB15624C30FE579D51989129F52B7B6B5B45", 1, 1, 999999, [::_id_143CE, 1, 7, 15], undefined, ::select_middle_turret_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_95240DE7B3421899C6E23243D5AEC3", 1, 1, 999999, [::_id_143CE, 1, 25, 35], undefined, ::select_mortar_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_83CB0DD992E7D9A0B11385833867A0", 1, ::get_enemy_sniper_max_spawn, 999999, [::_id_143CE, ::get_enemy_sniper_max_spawn, 15, 25], undefined, ::select_enemy_sniper_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A92A0E6E4023DA5FE9A097D3232D59A2", 1, 1, 1, 0.05, 0, "_encstr_BDC2164CB75BC4F53B57B04E234B2CB9D7E60E2CBBB92BE4", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8C5D1238D8C2BC594ED79C96B343A3AFCDB48C95", 2, 6, 6, 1, [::wait_all_spawns_dead_and_time, 20, 35, "_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591"], "_encstr_AD771A37151AFBA9728760A07FB0437F83FCA535A153B1115FABD070", ::increase_script_maxdist, "_encstr_8C5D1238D8C2BC594ED79C96B343A3AFCDB48C95", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8F8511831BC2BCB24EEB8D59CC47D7DCA5C8AC", 2, 6, 6, 1, [::wait_all_spawns_dead_and_time, 20, 35, "_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591"], "_encstr_820B190859B633F146FFD9D30D23873E43ECAD814678B8972EE1FD", ::increase_script_maxdist, "_encstr_8F8511831BC2BCB24EEB8D59CC47D7DCA5C8AC", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A5BA12D2896FF9CF33F7C4591D59508BAD573FA0", 2, 8, 8, 0.05, undefined, "_encstr_9AA51A07B1582F564E7D6395CC47BE5DB596D695BEB98316EECDB29C", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_824513723923B1D08A96EA3B87203969EBE8800221", 2, 8, 8, 0.05, undefined, "_encstr_934E1B9FC42F827B2A495080A2C4011ED77DAB9A252F0B99D6D3C8F8CB", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8FC313B811C09047EE3622BA39C5778B68ED2439A3", 2, 6, 6, 0.05, undefined, "_encstr_8B741B3B2D59F08D63378993FB2BD830F905219096BF683F0AEF95ABB3", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A2C714831BC22FCA937D275AB386A3AF9DA5E6C85AB0", 2, 6, 6, 0.05, undefined, "_encstr_B6E71C22B03041621697EBBFDF33BBAF50F85DAF8898DF5B6F83F7AB33E6", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BD6211506A6B58E072812917B511281B3F120B", 1, ::get_under_bridge_max_spawn, 999999, [::waittill_num_and_all_spawns_dead_and_time, ::get_under_bridge_max_spawn, 10, 20], undefined, ::select_mid_bridge_right_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8AEB10D64BC8F58993B4C8B3ACD763CA33D1", 1, ::get_under_bridge_max_spawn, 999999, [::waittill_num_and_all_spawns_dead_and_time, ::get_under_bridge_max_spawn, 10, 20], undefined, ::select_mid_bridge_left_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A57911B3C33AD090FAD41971FFEF20FDC24715", 1, 2, 999999, 4.5, undefined, ::select_end_bridge_stair_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AF560ACB6EA7904B8FC9EF35", 1, ::get_enemy_rpg_max_spawn, 9999999, [::waittill_num_and_all_spawns_dead_and_time, ::get_enemy_rpg_max_spawn, 15, 25], undefined, ::select_enemy_rpg_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A1D90C3B2552318BC8C30817EBFB", 1, ::get_enemy_right_max_spawn, 999999, 3.5, undefined, ::select_enemy_right_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_92060B7538A1BF58BF98A28A40", 1, ::get_enemy_left_max_spawn, 999999, 3.5, undefined, ::select_enemy_left_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A3A30D5DCD912B39FA894EA5193B56", 1, 3, 3, 1.5, [::waittill_all_spawns_dead_and_time, 3, "_encstr_A20418C8827FA323FB0ACBB5F70F4E7B259AB0200917EB199B08", 5, 8], "_encstr_929E15134EC282C02E9DFA7A81C8D7160312C7AB2B0752", ::increase_script_maxdist, "_encstr_82C017F3BACBE5C0992AA5EB54FF30A0CBA2C818A20FA6902F", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_82C017F3BACBE5C0992AA5EB54FF30A0CBA2C818A20FA6902F", 1, 2, 8, 3.5, undefined, ::select_under_bridge_reinforce_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8CC60FAD20236A5E407F79B3CB4DA81817", 6, 48, 12, 0.5, undefined, "_encstr_B8AF17C7A095C55EBEE6F133A938A76B9F294733D84C5AF73A", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8FB6151C5E23EFFBBFA1625AD0DD74B75BA89087EC697B", 8, 8, 8, 0.1, 0, "_encstr_8FB6151C5E23EFFBBFA1625AD0DD74B75BA89087EC697B", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9B0C1BD898E4859DBDAF36B0C99396B227EB1ADEB3594EAFCC9CDB73D1", 3, 8, 8, 0.1, 0, "_encstr_9B0C1BD898E4859DBDAF36B0C99396B227EB1ADEB3594EAFCC9CDB73D1", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_99701AA81A7AB948BFC1D8EBE0132DA86A81D08886E53D2E758AB1F7", 3, 8, 8, 0.1, 0, "_encstr_99701AA81A7AB948BFC1D8EBE0132DA86A81D08886E53D2E758AB1F7", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A234126927D28D41A55D617880B750452BD3E3D1", ::turret_enemy_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8D1B134EA59D1A3AAF95DC2BDA5EEB3AAB4E392BD1", ::turret_enemy_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8726149FFB15624C30FE579D51989129F52B7B6B5B45", ::turret_enemy_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A92A0E6E4023DA5FE9A097D3232D59A2", ::bomb_guardian_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_83CB0DD992E7D9A0B11385833867A0", ::activate_sniper);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BD6211506A6B58E072812917B511281B3F120B", ::bridge_stair_up_enemy);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8AEB10D64BC8F58993B4C8B3ACD763CA33D1", ::bridge_stair_up_enemy);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A57911B3C33AD090FAD41971FFEF20FDC24715", ::bridge_stair_up_enemy);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_95240DE7B3421899C6E23243D5AEC3", ::enemy_mortar_think);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A3A30D5DCD912B39FA894EA5193B56", ::underbridge_enemy_monitor);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_82C017F3BACBE5C0992AA5EB54FF30A0CBA2C818A20FA6902F", ::_id_13F04);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A1D90C3B2552318BC8C30817EBFB", ::nocrouch);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_92060B7538A1BF58BF98A28A40", ::nextswitch);
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("_encstr_A1D90C3B2552318BC8C30817EBFB");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("_encstr_92060B7538A1BF58BF98A28A40");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("_encstr_82C017F3BACBE5C0992AA5EB54FF30A0CBA2C818A20FA6902F");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("_encstr_BD6211506A6B58E072812917B511281B3F120B");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("_encstr_8AEB10D64BC8F58993B4C8B3ACD763CA33D1");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("_encstr_A57911B3C33AD090FAD41971FFEF20FDC24715");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("_encstr_83CB0DD992E7D9A0B11385833867A0");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("_encstr_AF560ACB6EA7904B8FC9EF35");
  level thread run_cp_donetsk_start_spawning();
}

stop_all_spawn_groups() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A234126927D28D41A55D617880B750452BD3E3D1");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8D1B134EA59D1A3AAF95DC2BDA5EEB3AAB4E392BD1");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8726149FFB15624C30FE579D51989129F52B7B6B5B45");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A92A0E6E4023DA5FE9A097D3232D59A2");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8C5D1238D8C2BC594ED79C96B343A3AFCDB48C95");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8F8511831BC2BCB24EEB8D59CC47D7DCA5C8AC");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A5BA12D2896FF9CF33F7C4591D59508BAD573FA0");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_824513723923B1D08A96EA3B87203969EBE8800221");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_BD6211506A6B58E072812917B511281B3F120B");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8AEB10D64BC8F58993B4C8B3ACD763CA33D1");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A57911B3C33AD090FAD41971FFEF20FDC24715");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_95240DE7B3421899C6E23243D5AEC3");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_AF560ACB6EA7904B8FC9EF35");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_83CB0DD992E7D9A0B11385833867A0");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1D90C3B2552318BC8C30817EBFB");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_92060B7538A1BF58BF98A28A40");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A3A30D5DCD912B39FA894EA5193B56");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_82C017F3BACBE5C0992AA5EB54FF30A0CBA2C818A20FA6902F");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8CC60FAD20236A5E407F79B3CB4DA81817");
}

run_cp_donetsk_start_spawning() {
  scripts\engine\utility::flag_wait("_encstr_83802B4B7990B9FAF10BC7734D28E2FA50038214D0584762D91B5F672F434A3608EE7E9F09F03F0BA519B77799");
  level thread _id_12500();
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A234126927D28D41A55D617880B750452BD3E3D1");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8D1B134EA59D1A3AAF95DC2BDA5EEB3AAB4E392BD1");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8726149FFB15624C30FE579D51989129F52B7B6B5B45");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A3A30D5DCD912B39FA894EA5193B56");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A92A0E6E4023DA5FE9A097D3232D59A2");
  scripts\engine\utility::flag_wait("_encstr_B89B173B2BD02DC6D859AF2BE6A3AC93B291BE26399632D9CA");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_95240DE7B3421899C6E23243D5AEC3");
  scripts\engine\utility::flag_wait("_encstr_8B5419ECBD7BF027FDBA09E82354D1C9A71FF665111F39176532C0");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1D90C3B2552318BC8C30817EBFB");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_92060B7538A1BF58BF98A28A40");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8FB6151C5E23EFFBBFA1625AD0DD74B75BA89087EC697B");
  scripts\engine\utility::flag_wait("_encstr_A7531963F7D8F8067A5777151372DDC06DC14BBB1E3F40D0D3771F");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_83CB0DD992E7D9A0B11385833867A0");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8CC60FAD20236A5E407F79B3CB4DA81817");
  scripts\engine\utility::flag_wait("_encstr_92111B230D1152AB40F8A76B78D8647AD388EA5BE7A72ACF2BF81B7F28");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_9B0C1BD898E4859DBDAF36B0C99396B227EB1ADEB3594EAFCC9CDB73D1");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_99701AA81A7AB948BFC1D8EBE0132DA86A81D08886E53D2E758AB1F7");
  level thread shrink_poi();
  scripts\engine\utility::flag_wait("_encstr_84371A4B7990B9FAF10BC73B4D2BD2EF5086825311107DF1DC071763");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BD6211506A6B58E072812917B511281B3F120B");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8AEB10D64BC8F58993B4C8B3ACD763CA33D1");
  scripts\engine\utility::flag_wait("_encstr_B2371A03C953CFB610B3DFEA75D0BF2F0D26EBABD1BCB7E178B30EF5");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A57911B3C33AD090FAD41971FFEF20FDC24715");
}

shrink_poi() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8E581D588A959738DF04D5C00B17A373FF52D8F8112AE371BF2DE6CEF67F48");
  level thread wassquadspawned();

  for(;;) {
    level waittill("_encstr_A198197CBF63DBDAE9F012AA1911155F3B17FFD7CE6BD7E3F538BA", var_0);
    var_1 = var_0.owner;
    var_1 thread _id_12D12(var_1);

    if(triggerremoveobjectivetext(var_0)) {
      if(!buy_points()) {
        scripts\engine\utility::flag_set("_encstr_828C1CF8AF994843F19FCDD397BB98D8200683B0D4CE8868DB77E3C7AF12");
        level thread _id_124DE();
        scripts\engine\utility::flag_waitopen("_encstr_828C1CF8AF994843F19FCDD397BB98D8200683B0D4CE8868DB77E3C7AF12");
      }
    }
  }
}

_id_124DE() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8E581D588A959738DF04D5C00B17A373FF52D8F8112AE371BF2DE6CEF67F48");
  level endon("_encstr_828C1CF8AF994843F19FCDD397BB98D8200683B0D4CE8868DB77E3C7AF12");
  level waittill("_encstr_AA9318CEB2D05A1B8DB2BEA5DCD7262B5AB9CED7E05D37862B46");
  scripts\engine\utility::flag_clear("_encstr_828C1CF8AF994843F19FCDD397BB98D8200683B0D4CE8868DB77E3C7AF12");
}

_id_12D12(var_0) {
  var_1 = 20;
  var_2 = var_0 scripts\engine\utility::_id_143AD("_encstr_9695073995D94BD959", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(var_2 == "_encstr_9695073995D94BD959") {
    wait(var_1);
    scripts\engine\utility::flag_clear("_encstr_828C1CF8AF994843F19FCDD397BB98D8200683B0D4CE8868DB77E3C7AF12");
  } else if(var_2 == "_encstr_8D820B49520F0EC02DDE6367EC") {
    var_3 = questrewarduav();

    if(var_3 == 0)
      scripts\engine\utility::flag_clear("_encstr_828C1CF8AF994843F19FCDD397BB98D8200683B0D4CE8868DB77E3C7AF12");
  }
}

wassquadspawned() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8E581D588A959738DF04D5C00B17A373FF52D8F8112AE371BF2DE6CEF67F48");
  level.watch_and_open_scriptable_doors_in_radius = [];

  for(;;) {
    level waittill("_encstr_A198197CBF63DBDAE9F012AA1911155F3B17FFD7CE6BD7E3F538BA", var_0);
    level.watch_and_open_scriptable_doors_in_radius = scripts\engine\utility::array_removeundefined(level.watch_and_open_scriptable_doors_in_radius);
    level.watch_and_open_scriptable_doors_in_radius = scripts\engine\utility::array_add(level.watch_and_open_scriptable_doors_in_radius, var_0);
  }
}

questrewarduav() {
  var_0 = 0;

  foreach(var_2 in level.watch_and_open_scriptable_doors_in_radius) {
    if(triggerremoveobjectivetext(var_2))
      var_0++;
  }

  return var_0;
}

buy_points() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }
    if(triggerremoveobjectivetext(var_2)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

triggerremoveobjectivetext(var_0) {
  var_1 = getEnt("_encstr_828E11B96A91D84C5277C7CB93EA98903FC5C1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_A939122BCB07486BE902C3372D27A0CE33901D37", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(ispointinvolume(var_0.origin, var_1))
    return 1;

  if(ispointinvolume(var_0.origin, var_2))
    return 1;

  return 0;
}

_id_12500() {
  var_0 = ["_encstr_8FC313B811C09047EE3622BA39C5778B68ED2439A3", "_encstr_A2C714831BC22FCA937D275AB386A3AF9DA5E6C85AB0"];

  for(var_1 = 5; var_1 > 0; var_1--)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  for(;;) {
    if(any_player_under_bridge()) {
      break;
    }

    wait 1;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module(var_0[0]);
  scripts\engine\utility::flag_wait("_encstr_B2371A03C953CFB610B3DFEA75D0BF2F0D26EBABD1BCB7E178B30EF5");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_0[1]);
}

underbridge_enemy_monitor(var_0) {
  var_1 = self;
  c4vehiclecooperator(var_1);
  var_1 thread underbridge_enemy_death_monitor(var_1);
}

_id_13F04(var_0) {
  var_1 = self;
  c4vehiclecooperator(var_1);
}

nocrouch(var_0) {
  var_1 = self;
  c4vehiclecooperator(var_1);
}

nextswitch(var_0) {
  var_1 = self;
  c4vehiclecooperator(var_1);
}

c4vehiclecooperator(var_0) {
  var_0.maxfaceenemydist = 1200;
  var_0 scripts\cp\cp_modular_spawning::numfound();
}

underbridge_enemy_death_monitor(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  level notify("_encstr_A20418C8827FA323FB0ACBB5F70F4E7B259AB0200917EB199B08");
}

waittill_all_spawns_dead_and_time(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isbuiltinfunction(var_1))
    var_5 = [[var_1]]();
  else
    var_5 = var_1;

  var_6 = 0;

  for(;;) {
    level waittill(var_2);
    var_6++;

    if(var_6 == var_5) {
      break;
    }
  }

  return randomfloatrange(var_3, var_4);
}

get_enemy_right_max_spawn(var_0) {
  if(scripts\engine\utility::flag("_encstr_B2371A03C953CFB610B3DFEA75D0BF2F0D26EBABD1BCB7E178B30EF5"))
    return 4;
  else if(scripts\engine\utility::flag("_encstr_84371A4B7990B9FAF10BC73B4D2BD2EF5086825311107DF1DC071763"))
    return 3;
  else
    return 2;
}

get_enemy_left_max_spawn(var_0) {
  if(scripts\engine\utility::flag("_encstr_B2371A03C953CFB610B3DFEA75D0BF2F0D26EBABD1BCB7E178B30EF5"))
    return 5;
  else if(scripts\engine\utility::flag("_encstr_84371A4B7990B9FAF10BC73B4D2BD2EF5086825311107DF1DC071763"))
    return 4;
  else
    return 3;
}

get_under_bridge_max_spawn(var_0) {
  if(scripts\engine\utility::flag("_encstr_B2371A03C953CFB610B3DFEA75D0BF2F0D26EBABD1BCB7E178B30EF5"))
    return 2;
  else
    return 1;
}

get_enemy_rpg_max_spawn(var_0) {
  if(scripts\engine\utility::flag("_encstr_92111B230D1152AB40F8A76B78D8647AD388EA5BE7A72ACF2BF81B7F28"))
    return 2;
  else
    return 1;
}

get_enemy_sniper_max_spawn(var_0) {
  if(scripts\engine\utility::flag("_encstr_A7531963F7D8F8067A5777151372DDC06DC14BBB1E3F40D0D3771F"))
    return 2;
  else
    return 1;
}

select_left_turret_spawners(var_0) {
  if(1)
    return scripts\cp\raid_utility::select_random_spawners("_encstr_9ACE1BB51D7DF3E710C8736BF069AFBBE32EBA6F7DE75BF0B9107B4F60");
  else
    return scripts\cp\raid_utility::select_random_spawners("_encstr_92451AF94587B8B887EAA9506397E5785ACA6371D7AAE0FFE7C2A1BB");
}

select_right_turret_spawners(var_0) {
  if(1)
    return scripts\cp\raid_utility::select_random_spawners("_encstr_B8E41C5A73074AA43EB0675380516CE1C995A2D2ED9971EBA3C8074B206B");
  else
    return scripts\cp\raid_utility::select_random_spawners("_encstr_BEEE1BEA4BA08473080152EA6873A7FB58E56245D9B98AABCF7B4A9293");
}

select_middle_turret_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("_encstr_BD7A1C19504541192AF15B10A7B86A37417563C601988FC368F9EFE5BF5A");
}

select_enemy_right_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("_encstr_92A014334ED202982EBDE19A0D503F9370569FED075B");
}

select_enemy_left_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("_encstr_BDC213AC3759DA97FAC6B2CCA3FA6EC158EECDAC93");
}

select_under_bridge_reinforce_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("_encstr_8C101F8310F8BDF3600D0B1F7914CACF10D93CCD8948523A455F07735BC4822DB8");
}

select_mid_bridge_right_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("_encstr_8C3119B62DC8D79827B491B3CAEB395AB334E8FA6E0E58DD379527");
}

select_mid_bridge_left_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("_encstr_834A185B2DC8FAC4935A323B59EBD85699D1FADC38B077CD594E");
}

select_end_bridge_stair_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("_encstr_BAC3193F25488E062324615A578902033009062F2283019FCEA9E2");
}

select_enemy_sniper_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("_encstr_AB2615E548D1CF28CFF082CAD083A24F4B2F698FD0790B");
}

select_enemy_rpg_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("_encstr_8DEA15B6E437E147CEDA885191AA473E2F804FB44EA70B");
}

select_mortar_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("_encstr_BA140FA8DD7AA8BF3367C7C9B74B707812");
}

left_turret_wait_between_spawn(var_0) {
  return randomfloatrange(5, 10);
}

cp_blockade_spawning() {
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BDC5160E3658F25693F5392D3B438E7D98EA2D8D23A573CE", 8, 8, 8, 0.05, 0, "_encstr_B1961E5063B1E203E3698E1B7F1A796E1ABF1028AB41D8CF190A871753929373", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8F1F1528C4FB73404E7E547BFDB4D640CD9051210B1BD9", 2, 2, 2, 0.05, 0, "_encstr_AF811D3836852FCAC9AF362B993ABEC4ABB41B8C969BCEFA37C185EE9B59C9", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A234126927D28D41A55D617880B750452BD3E3D1", 0, 1, undefined, [::wait_all_spawns_dead_and_time, 5, 10, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 0, "_encstr_92451AF94587B8B887EAA9506397E5785ACA6371D7AAE0FFE7C2A1BB", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8D1B134EA59D1A3AAF95DC2BDA5EEB3AAB4E392BD1", 0, 1, undefined, [::wait_all_spawns_dead_and_time, 5, 10, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 0, "_encstr_BEEE1BEA4BA08473080152EA6873A7FB58E56245D9B98AABCF7B4A9293", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A92A0E6E4023DA5FE9A097D3232D59A2", 1, 1, 1, 0.05, 0, "_encstr_BDC2164CB75BC4F53B57B04E234B2CB9D7E60E2CBBB92BE4", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8C5D1238D8C2BC594ED79C96B343A3AFCDB48C95", 2, 5, 5, 0.05, [::wait_all_spawns_dead_and_time, 15, 30, "_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591"], "_encstr_AD771A37151AFBA9728760A07FB0437F83FCA535A153B1115FABD070", ::increase_script_maxdist, "_encstr_8C5D1238D8C2BC594ED79C96B343A3AFCDB48C95", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8F8511831BC2BCB24EEB8D59CC47D7DCA5C8AC", 2, 5, 5, 0.05, [::wait_all_spawns_dead_and_time, 15, 30, "_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591"], "_encstr_820B190859B633F146FFD9D30D23873E43ECAD814678B8972EE1FD", ::increase_script_maxdist, "_encstr_8F8511831BC2BCB24EEB8D59CC47D7DCA5C8AC", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A7640B5B96C8BE26934B237656", 2, 3, 3, 0.05, [::wait_all_spawns_dead, 20, 30], "_encstr_A19313D50339CF364DE8DAE2A03FAAAB71F42E5526", ::increase_script_maxdist, "_encstr_A7640B5B96C8BE26934B237656", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BDAC0B3D15CA37C9F2DF5050F7", 2, 3, 3, 0.05, [::wait_all_spawns_dead, 20, 30], "_encstr_86CE133048EBB9454018BCF7A2878FB939E3620AF6", ::increase_script_maxdist, "_encstr_BDAC0B3D15CA37C9F2DF5050F7", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8DCD0B50847B06356A6A203042", 2, 5, 5, 0.05, [::wait_all_spawns_dead, 10, 20], "_encstr_ABEA13B22089E9B37B9B4C47A5E6CFEA2B602AEA38", ::increase_script_maxdist, "_encstr_8DCD0B50847B06356A6A203042", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_95F50A133B97989301A2171F", 0, 1, undefined, [::wait_all_spawns_dead_and_time, 15, 25, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 1.5, "_encstr_ABBE1239A5760D47D7250AD1FA3783B0BBE6ACC9", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A55F0990A26F11164B58AC", 0, 1, undefined, [::wait_all_spawns_dead_and_time, 15, 25, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 1.5, "_encstr_AB661159370A818E321B69B18F4801CFF25FCE", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8E3008B0A07AE882B8C9", 0, 1, undefined, [::wait_all_spawns_dead_and_time, 15, 25, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 1.5, "_encstr_A33810F3E263D733F0C5F770CA178B95C83B", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_969B0D1027E770918135D0664B5AA5", 0, 1, undefined, [::wait_all_spawns_dead_and_time, 20, 30, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 1.5, "_encstr_ACE6155A42115A301850303B1CDF03B7D3C08F577DBF28", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A5390CB3CBCCBBA798ED7AC3F958", 0, 1, undefined, [::wait_all_spawns_dead_and_time, 20, 30, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 1.5, "_encstr_9A85146A0810F0B7F8D75A5B91EAC01BC35F1F35A7F3", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A9FD0B3B89C7216E6B5ACB1193", 0, 1, undefined, [::wait_all_spawns_dead_and_time, 20, 30, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 1.5, "_encstr_A7441301DA423FD8F5DB702D2AF150B8FBDFD517DD", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_92BB0CB88A47090E279E43C76DDB", 0, 1, undefined, [::wait_all_spawns_dead_and_time, 20, 30, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 1.5, "_encstr_BDF214BAD14C5351104DF1D063206907EFC983E2B91E", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AB8A0D6368F4EB53A9BF0E0191501A", 0, 1, undefined, [::wait_all_spawns_dead_and_time, 20, 20, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 1.5, "_encstr_9AB4153996CEA1D1BE9BCDD2835927BECD380BEE372B93", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A1D90C3B2552318BC8C30817EBFB", 1, 2, undefined, [::wait_all_spawns_dead_and_time, 5, 10, "_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF"], 1.5, "_encstr_92A014334ED202982EBDE19A0D503F9370569FED075B", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_92060B7538A1BF58BF98A28A40", 1, 3, undefined, [::waittill_num_and_all_spawns_dead_and_time, 3, 5, 10], 1.5, "_encstr_BDC213AC3759DA97FAC6B2CCA3FA6EC158EECDAC93", ::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A234126927D28D41A55D617880B750452BD3E3D1", ::turret_enemy_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8D1B134EA59D1A3AAF95DC2BDA5EEB3AAB4E392BD1", ::turret_enemy_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A92A0E6E4023DA5FE9A097D3232D59A2", ::bomb_guardian_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB8A0D6368F4EB53A9BF0E0191501A", ::activate_sniper);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_92BB0CB88A47090E279E43C76DDB", ::activate_sniper);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A9FD0B3B89C7216E6B5ACB1193", ::activate_sniper);
  level thread run_cp_blockade_start_spawning();
}

wait_no_vehicles_and_time(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AF591BED65E4B04643BA0E93827F08B3FFFC37B51A8D28808723ED7BBB");
  wait(randomfloatrange(var_1, var_2));
}

wait_all_spawns_dead(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591");
}

_id_143CE(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isbuiltinfunction(var_1))
    var_4 = [[var_1]]();
  else
    var_4 = var_1;

  if(var_0.spawn_count % var_4 == 0) {
    if(var_0 scripts\cp\cp_modular_spawning::get_activecount_from_group(1) > 0) {
      var_0 waittill("_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF");

      if(scripts\engine\utility::flag("_encstr_828C1CF8AF994843F19FCDD397BB98D8200683B0D4CE8868DB77E3C7AF12"))
        scripts\engine\utility::flag_waitopen("_encstr_828C1CF8AF994843F19FCDD397BB98D8200683B0D4CE8868DB77E3C7AF12");

      return randomfloatrange(var_2, var_3);
    } else
      return 1.5;
  } else
    return 1.5;
}

waittill_num_and_all_spawns_dead_and_time(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isbuiltinfunction(var_1))
    var_4 = [[var_1]]();
  else
    var_4 = var_1;

  if(var_0.spawn_count % var_4 == 0) {
    if(var_0 scripts\cp\cp_modular_spawning::get_activecount_from_group(1) > 0) {
      var_0 waittill("_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF");
      return randomfloatrange(var_2, var_3);
    } else
      return 1.5;
  } else
    return 1.5;
}

wait_all_spawns_dead_and_time(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill(var_3);
  wait(randomfloatrange(var_1, var_2));
}

run_cp_blockade_start_spawning() {
  wait 5;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A234126927D28D41A55D617880B750452BD3E3D1");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8D1B134EA59D1A3AAF95DC2BDA5EEB3AAB4E392BD1");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A92A0E6E4023DA5FE9A097D3232D59A2");
  var_0 = get_player_side_spawn_group_randomized();
  var_1 = get_rpg_group_randomized();
  var_2 = get_mortar_group_randomized();
  var_3 = get_sniper_group_randomized();
  var_4 = get_enemy_group_randomized();
  scripts\engine\utility::flag_wait("_encstr_B89B173B2BD02DC6D859AF2BE6A3AC93B291BE26399632D9CA");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_1[0]);
  scripts\engine\utility::flag_wait("_encstr_8B5419ECBD7BF027FDBA09E82354D1C9A71FF665111F39176532C0");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_0[0]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_1[1]);
  scripts\engine\utility::flag_wait("_encstr_A7531963F7D8F8067A5777151372DDC06DC14BBB1E3F40D0D3771F");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_0[1]);
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A7640B5B96C8BE26934B237656");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_3[0]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_1[2]);
  scripts\engine\utility::flag_wait("_encstr_92111B230D1152AB40F8A76B78D8647AD388EA5BE7A72ACF2BF81B7F28");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BDAC0B3D15CA37C9F2DF5050F7");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_3[1]);
  scripts\engine\utility::flag_wait("_encstr_84371A4B7990B9FAF10BC73B4D2BD2EF5086825311107DF1DC071763");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8DCD0B50847B06356A6A203042");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_4[0]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_3[2]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_2[0]);
  activate_mortar(var_2[0]);
  scripts\engine\utility::flag_wait("_encstr_B2371A03C953CFB610B3DFEA75D0BF2F0D26EBABD1BCB7E178B30EF5");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_4[1]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_2[1]);
  activate_mortar(var_2[1]);
}

get_player_side_spawn_group_randomized() {
  return get_randomized_group(["_encstr_8C5D1238D8C2BC594ED79C96B343A3AFCDB48C95", "_encstr_8F8511831BC2BCB24EEB8D59CC47D7DCA5C8AC"]);
}

get_rpg_group_randomized() {
  return get_randomized_group(["_encstr_95F50A133B97989301A2171F", "_encstr_A55F0990A26F11164B58AC", "_encstr_8E3008B0A07AE882B8C9"]);
}

get_mortar_group_randomized() {
  return get_randomized_group(["_encstr_969B0D1027E770918135D0664B5AA5", "_encstr_A5390CB3CBCCBBA798ED7AC3F958"]);
}

get_sniper_group_randomized() {
  return get_randomized_group(["_encstr_AB8A0D6368F4EB53A9BF0E0191501A", "_encstr_92BB0CB88A47090E279E43C76DDB", "_encstr_A9FD0B3B89C7216E6B5ACB1193"]);
}

get_enemy_group_randomized() {
  return get_randomized_group(["_encstr_A1D90C3B2552318BC8C30817EBFB", "_encstr_92060B7538A1BF58BF98A28A40"]);
}

activate_mortar(var_0) {
  var_1 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 thread mortar_think(var_1);
}

mortar_think(var_0) {
  var_0 endon("_encstr_8102126E1DDE38D76BBD9C8E2C397D3A1A969BB6");
  var_0.targets = undefined;

  for(;;) {
    var_1 = scripts\cp\raid_utility::get_players_not_in_laststand();
    var_1 = get_players_in_killzone(var_1);

    if(var_1.size > 0) {
      var_0.targets = var_1;
      _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::attract_agent_to_mortar(var_0);
      var_0.targets = undefined;
      wait(randomintrange(5, 10));
      continue;
    }

    wait 1;
  }
}

get_randomized_group(var_0) {
  for(var_1 = 0; var_1 < 5; var_1++)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  return var_0;
}

bridge_stair_up_enemy(var_0) {
  var_1 = self;
  var_1 thread bridge_stair_up_combat_think(var_0);
}

bridge_stair_up_combat_think(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self;
  var_1 waittill("_encstr_8DFD1123C0C1937233CDD112A7C9AA67E920F3");

  if(any_player_under_bridge())
    var_1 thread go_hunt_down_player(var_1, 0);
  else
    var_1 thread go_hunt_down_player(var_1, 1);
}

activate_sniper(var_0) {
  var_1 = self;
  var_1.neverforcesnipermissenemy = 1;
  var_1.sniperaccuracyset = 1;
  var_1.baseaccuracy = 1;
  var_1 laseron();
  c4vehiclecooperator(var_1);
  var_1 thread delay_activate_laser(var_1);
}

activate_mortar_enemy(var_0) {
  var_1 = self;
  var_1.dontevershoot = 1;
}

delay_activate_laser(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
  var_0.gunposeoverride = "_encstr_AD1904291F7B";
  var_0 thread sniper_player_monitor(var_0);
  var_0 thread sniper_target_think(var_0);
  var_0 thread sniper_laser_think(var_0);
}

sniper_player_monitor(var_0) {
  foreach(var_2 in level.players)
  var_2 thread enemy_sniper_player_monitor(var_2, var_0);

  level thread sniper_players_connect_monitor(var_0);
}

sniper_players_connect_monitor(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    var_1 thread enemy_sniper_player_monitor(var_1, var_0);
  }
}

enemy_sniper_player_monitor(var_0, var_1) {
  var_0 thread exposure_to_sniper_monitor(var_0, var_1);
}

exposure_to_sniper_monitor(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_1.player_exposure_data))
    var_1.player_exposure_data = [];

  var_2 = var_0 getentitynumber();
  var_3 = spawnStruct();
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
  var_3.exposed_to_enemy_sniper_time = 0;

  for(;;) {
    var_3.loc_exposed_to_enemy_sniper = [];

    if(scripts\engine\trace::ray_trace_passed(var_0.origin, var_1 getEye(), [var_1], var_4))
      var_3.loc_exposed_to_enemy_sniper[var_3.loc_exposed_to_enemy_sniper.size] = "_encstr_97FE07DE392D76D2CD";

    if(scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), [var_1], var_4))
      var_3.loc_exposed_to_enemy_sniper[var_3.loc_exposed_to_enemy_sniper.size] = "_encstr_A6180438A081";

    if(scripts\engine\trace::ray_trace_passed(var_0 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"), var_1 getEye(), [var_1], var_4))
      var_3.loc_exposed_to_enemy_sniper[var_3.loc_exposed_to_enemy_sniper.size] = "_encstr_9A7606B11A95DCD1";

    if(var_3.loc_exposed_to_enemy_sniper.size > 0)
      var_3.exposed_to_enemy_sniper_time = var_3.exposed_to_enemy_sniper_time + 0.05;
    else
      var_3.exposed_to_enemy_sniper_time = 0;

    var_1.player_exposure_data[var_2] = var_3;
    waitframe();
  }
}

sniper_target_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.current_target = undefined;

  for(;;) {
    var_1 = scripts\cp\raid_utility::get_players_not_in_laststand();
    var_2 = 9;
    var_3 = undefined;

    foreach(var_5 in var_1) {
      if(!isDefined(var_5.num_sniper_covering_me))
        var_5.num_snipers_covering_me = 0;

      var_6 = get_player_target_score_for_sniper(var_5, var_0);

      if(var_6 > var_2) {
        var_2 = var_6;
        var_3 = var_5;
      }
    }

    if(isDefined(var_3) && is_new_target(var_3, var_0)) {
      if(has_current_target(var_0)) {
        wait(randomfloatrange(0.5, 1));
        unmark_player_as_sniper_target(var_0.current_target);
      }

      mark_player_as_sniper_target(var_0, var_3);
      var_3 thread sniper_death_monitor(var_3, var_0);
      var_8 = var_3 scripts\engine\utility::_id_143B9(randomfloatrange(1.5, 2), "_encstr_8CBE0BD1BED30936AB03C0B02B");

      if(var_8 == "_encstr_8CBE0BD1BED30936AB03C0B02B") {
        unmark_player_as_sniper_target(var_3);
        wait 1.5;
      }

      continue;
    }

    wait 0.05;
  }
}

has_current_target(var_0) {
  return isDefined(var_0.current_target);
}

is_new_target(var_0, var_1) {
  if(!has_current_target(var_1))
    return 1;

  return var_1.current_target != var_0;
}

mark_player_as_sniper_target(var_0, var_1) {
  var_0.current_target = var_1;
  var_0 getenemyinfo(var_1);
  var_0 setlookatentity(var_1);
  var_0.favoriteenemy = var_1;
  var_1.num_snipers_covering_me = var_1.num_snipers_covering_me + 1;
}

unmark_player_as_sniper_target(var_0) {
  var_0.num_snipers_covering_me = var_0.num_snipers_covering_me - 1;
}

sniper_death_monitor(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 waittill("_encstr_AD75063D571AE108");
  unmark_player_as_sniper_target(var_0);
}

get_player_target_score_for_sniper(var_0, var_1) {
  var_2 = 25000000;
  var_3 = 0;

  if(is_player_part_exposed_to_sniper(var_0, var_1, "_encstr_A6180438A081"))
    var_3 = var_3 + 45;

  if(is_player_part_exposed_to_sniper(var_0, var_1, "_encstr_97FE07DE392D76D2CD"))
    var_3 = var_3 + 45;

  if(player_is_in_killzone(var_0))
    var_3 = var_3 + 200;

  var_4 = get_player_expose_time_to_sniper(var_0, var_1);
  var_3 = var_3 + var_4 * 10;
  var_3 = int(max(0, var_3 + var_0.num_snipers_covering_me * -45));
  var_5 = distance2dsquared(var_0.origin, var_1.origin);
  var_3 = var_3 + 9 * (1 - clamp(var_5 / var_2, 0, 1));
  var_3 = var_3 + randomfloat(18);
  return var_3;
}

is_player_part_exposed_to_sniper(var_0, var_1, var_2) {
  var_3 = var_1.player_exposure_data[var_0 getentitynumber()];
  return scripts\engine\utility::array_contains(var_3.loc_exposed_to_enemy_sniper, var_2);
}

get_player_expose_time_to_sniper(var_0, var_1) {
  var_2 = var_1.player_exposure_data[var_0 getentitynumber()];
  return var_2.exposed_to_enemy_sniper_time;
}

sniper_laser_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = var_0 gettagorigin("_encstr_BA991101FFE81FF0F940C80B5F70A11312F2A9");
  var_2 = create_tag_origin(var_1, var_0);
  var_2 thread follow_tag_laser_attach(var_0, var_2);
  var_3 = create_tag_origin(var_1, var_0);
  var_0.laser_start_ent = var_2;
  var_0.laser_end_ent = var_3;
  var_0 thread waittill_any_return_no_endon_death_2(var_0);

  for(;;) {
    if(has_current_target(var_0)) {
      if(player_is_exposed_to_sniper(var_0.current_target, var_0)) {
        if(!istrue(var_3.is_linked_to_target)) {
          var_4 = get_target_tag_to_link_to(var_0.current_target, var_0);
          var_5 = var_0.current_target gettagorigin(var_4);
          var_3.origin = var_5;
          var_3 linkTo(var_0.current_target, var_4);
          var_3.is_linked_to_target = 1;
        }
      } else {
        var_3 unlink();
        var_3.is_linked_to_target = 0;
        var_6 = get_laser_end_pos(var_0.current_target, var_2);
        var_3 moveTo(var_6, 0.25);
      }
    }

    wait 0.05;
  }
}

waittill_any_return_no_endon_death_2(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  _id_13E50(var_0);

  for(;;) {
    if(!_id_1343B(var_0) && _id_1343C(var_0))
      _id_13E50(var_0);
    else if(_id_1343B(var_0) && !_id_1343C(var_0))
      _id_13E43(var_0);

    waitframe();
  }
}

_id_13E50(var_0) {
  var_1 = playfxontagsbetweenclients(level._effect["_encstr_836B11D7287971056B68E3FF25B0719237B835"], var_0.laser_start_ent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0.laser_end_ent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0._id_1343D = var_1;
}

_id_13E43(var_0) {
  var_0._id_1343D delete();
}

_id_1343B(var_0) {
  return isDefined(var_0._id_1343D);
}

_id_1343C(var_0) {
  var_1 = 0.5;
  var_2 = anglesToForward(var_0 getplayerangles());
  var_3 = vectorNormalize(var_0.laser_end_ent.origin - var_0.laser_start_ent.origin);
  var_4 = vectordot(var_3, var_2);

  if(var_4 < var_1)
    return 0;

  var_5 = var_0 getcurrentweapon();

  if(var_5.classname != "_encstr_850707F7E5833355B8")
    return 0;

  return 1;
}

get_target_tag_to_link_to(var_0, var_1) {
  if(is_player_part_exposed_to_sniper(var_0, var_1, "_encstr_9A7606B11A95DCD1"))
    return "_encstr_813B0D4027B390B37585BBC819FD28";
  else if(is_player_part_exposed_to_sniper(var_0, var_1, "_encstr_A6180438A081"))
    return "_encstr_A130084D2FDAD8AA8F62";
  else
    return "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
}

follow_tag_laser_attach(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(var_0 tagexists("_encstr_BA991101FFE81FF0F940C80B5F70A11312F2A9")) {
      var_2 = var_0 gettagorigin("_encstr_BA991101FFE81FF0F940C80B5F70A11312F2A9");
      var_1.origin = var_2;
    }

    waitframe();
  }
}

try_shoot_at_current_target(var_0, var_1) {
  var_2 = var_0.current_target;

  if(!isDefined(var_2.time_stamp_can_be_damaged_by_sniper))
    var_2.time_stamp_can_be_damaged_by_sniper = 0;

  if(player_can_take_sniper_damage(var_2) && player_expose_to_sniper_long_enough(var_2, var_0)) {
    var_3 = var_2.origin - var_1.origin;
    playFX(level._effect["_encstr_95781433AB1FA24AA891D7BBEBF358EF81E0B210886B"], var_1.origin, var_3);
    var_0 playSound("_encstr_99A519CD37D238CA27D7B14EB01BAD7D3385C9BEB92B0BC9D7C6C1");
    var_2 dodamage(80, var_0.origin, var_0);
    set_next_can_take_sniper_damage_time_stamp(var_2);
  }
}

player_can_take_sniper_damage(var_0) {
  var_1 = gettime();
  return var_1 > var_0.time_stamp_can_be_damaged_by_sniper;
}

set_next_can_take_sniper_damage_time_stamp(var_0) {
  var_1 = gettime();
  var_0.time_stamp_can_be_damaged_by_sniper = var_1 + randomfloatrange(3, 4) * 1000;
}

player_expose_to_sniper_long_enough(var_0, var_1) {
  return get_player_expose_time_to_sniper(var_0, var_1) >= 1;
}

mark_laser_end_ent(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;)
    waitframe();
}

get_laser_end_pos(var_0, var_1) {
  var_2 = 40;
  var_3 = 2;
  var_4 = 40;
  var_5 = 50;
  var_6 = 25;
  var_7 = 35;
  var_8 = 10;
  var_9 = 5;
  var_10 = anglesToForward(var_0 getplayerangles());
  var_11 = var_0 getEye() + var_10 * var_2;
  var_11 = (var_11[0] + randomfloatrange(var_3 * -1, var_3), var_11[1] + randomfloatrange(var_3 * -1, var_3), var_11[2]);
  var_11 = scripts\engine\utility::drop_to_ground(var_11, 0, -500);
  var_12 = var_0 getstance();

  switch (var_12) {
    case "_encstr_A5AD069B231F0BAF":
      var_11 = (var_11[0], var_11[1], var_11[2] + randomfloatrange(var_4, var_5));
      break;
    case "_encstr_922406F1A6FD5E05":
    case "_encstr_B13D076BED70539F23":
      var_11 = (var_11[0], var_11[1], var_11[2] + randomfloatrange(var_6, var_7));
      break;
  }

  var_13 = vectorNormalize(var_11 - var_1.origin);
  var_14 = var_1.origin + var_13 * 20000;
  var_15 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
  var_11 = scripts\engine\trace::ray_trace(var_1.origin, var_14, undefined, var_15);

  if(player_is_near_vehicle_to_push(var_0)) {
    if(player_is_facing_away_from_vehicle_to_push(var_0)) {
      var_16 = var_11["_encstr_BD260953AA97E3F014279D"] + (0, 0, 21);
      var_17 = vectorNormalize(var_16 - var_1.origin);
      var_18 = anglestoright(vectortoangles(var_17));
      var_16 = var_16 + var_18 * randomfloatrange(var_8 * -1, var_8);
      var_17 = vectorNormalize(var_16 - var_1.origin);
      var_14 = var_1.origin + var_17 * 20000;
      var_15 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
      var_11 = scripts\engine\trace::ray_trace(var_1.origin, var_14, undefined, var_15);
    } else if(player_is_facing_vehicle_to_push(var_0)) {
      var_16 = var_11["_encstr_BD260953AA97E3F014279D"] + (0, 0, 23);
      var_17 = vectorNormalize(var_16 - var_1.origin);
      var_18 = anglestoright(vectortoangles(var_17));
      var_16 = var_16 + var_18 * randomfloatrange(var_9 * -1, var_9);
      var_17 = vectorNormalize(var_16 - var_1.origin);
      var_14 = var_1.origin + var_17 * 20000;
      var_15 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
      var_11 = scripts\engine\trace::ray_trace(var_1.origin, var_14, undefined, var_15);
    }
  }

  return var_11["_encstr_BD260953AA97E3F014279D"];
}

player_is_near_vehicle_to_push(var_0) {
  if(istrue(var_0.is_pushing_vehicle))
    return 1;

  if(!isDefined(level.vehicle_to_push))
    return 0;

  return distance2dsquared(var_0.origin, level.vehicle_to_push.origin) <= 40000;
}

player_is_facing_away_from_vehicle_to_push(var_0) {
  var_1 = anglesToForward(var_0 getplayerangles());
  var_2 = anglesToForward(level.vehicle_to_push.angles);
  var_3 = var_2 * -1;
  var_4 = acos(vectordot(var_1, var_3));
  return abs(var_4) < 75;
}

player_is_facing_vehicle_to_push(var_0) {
  var_1 = anglesToForward(var_0 getplayerangles());
  var_2 = anglesToForward(level.vehicle_to_push.angles);
  var_3 = acos(vectordot(var_1, var_2));
  return abs(var_3) < 80;
}

player_is_exposed_to_sniper(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  return var_1.player_exposure_data[var_2].exposed_to_enemy_sniper_time > 0;
}

create_tag_origin(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 thread clean_up_think(var_2, var_1);
  return var_2;
}

clean_up_think(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

bomb_guardian_watcher(var_0) {
  var_1 = self;
  var_1 thread bomb_guardian_death_watcher_internal(var_1);
}

bomb_guardian_death_watcher_internal(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\cp\bomb_defusal\coop_bomb_defusal::drop_bomb_detonator_from_ai(var_0, "_encstr_B19C0A98DEDA98FAC685CD59");
  level.bomb_guardian_is_killed = 1;
}

turret_enemy_watcher(var_0) {
  thread _id_13E67(var_0);
}

_id_13E67(var_0) {
  var_1 = self;
  wait 0.05;
  var_1 notify("_encstr_96BD0D89D20F0BA061D3777BFAD620");

  if(isDefined(var_1.spawnpoint) && issubstr(var_1.spawnpoint.targetname, "_encstr_A2860EB5C2E6735932BE8E5DE49C593A")) {
    if(isDefined(var_1.spawnpoint.target)) {
      var_2 = scripts\engine\utility::getStruct(var_1.spawnpoint.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(isDefined(var_2)) {
        var_1 setgoalpos(var_2.origin);
        var_1.script_origin_other = var_2.origin;
      }
    }

    var_1.goalradius = 64;
    var_1 allowedstances("_encstr_A5AD069B231F0BAF");
    var_1.combatmode = "_encstr_821109FAE81117DA568730";
  } else {
    var_1.goalradius = 10;
    var_1.dontevershoot = 1;
    var_1 thread activate_enemy_turret_when_reach_it(var_1);
  }
}

enemy_mortar_think(var_0) {
  var_1 = self;
  c4vehiclecooperator(var_1);
  var_1 thread activate_mortar_when_reach_path_end(var_1);
}

activate_mortar_when_reach_path_end(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_923A15DBC7AE534F1888252E80E8BC9A10771F2745DF1B");

  if(scripts\engine\utility::flag("_encstr_923A15DBC7AE534F1888252E80E8BC9A10771F2745DF1B"))
    var_0 thread go_hunt_down_player(var_0, 0);
  else {
    var_0 waittill("_encstr_8DFD1123C0C1937233CDD112A7C9AA67E920F3");
    var_1 = scripts\engine\utility::getclosest(var_0.origin, getEntArray("_encstr_95240DE7B3421899C6E23243D5AEC3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
    var_0.ignoreall = 1;
    var_1 thread mortar_think(var_1);
    var_0 thread mortar_enemy_death_watcher(var_0, var_1);
  }
}

mortar_enemy_death_watcher(var_0, var_1) {
  var_0 waittill("_encstr_AD75063D571AE108");
  var_1 notify("_encstr_8102126E1DDE38D76BBD9C8E2C397D3A1A969BB6");
  var_1.targets = undefined;
}

activate_enemy_turret_when_reach_it(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_923A15DBC7AE534F1888252E80E8BC9A10771F2745DF1B");
  var_0 scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
  var_1 = scripts\engine\utility::getclosest(var_0.origin, level.enemy_turrets);
  activate_enemy_turret(var_1);
  var_0 allowedstances("_encstr_A5AD069B231F0BAF");
  var_0 setlookatentity(var_1);
  var_0.ignoreall = 1;
  var_0.combatmode = "_encstr_821109FAE81117DA568730";
  var_0 link_to_turret_enemy_mover(var_0);
  var_0 thread death_monitor(var_0, var_1);
}

link_to_turret_enemy_mover(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_84DF140BE3769B0FF8DF0D1EB3E8D0E71E3BE38389CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getclosest(var_0.origin, var_1, 100000);
  var_2.origin = var_0.origin;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3.angles = var_2.angles;
  var_0.angles = var_3.angles;
  var_0 linkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0.wztrain_info = var_3;
  var_3 thread turret_enemy_mover_clean_up(var_3, var_0);
}

turret_enemy_mover_clean_up(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

death_monitor(var_0, var_1) {
  var_0 waittill("_encstr_AD75063D571AE108");
  deactivate_enemy_turret(var_1);
}

enemy_spawner_vehicle_spawned_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.enemy_spawner_vehicles = [];

  for(;;) {
    level waittill("_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501", var_0, var_1);

    if(scripts\engine\utility::array_contains(level.enemy_spawner_vehicles, var_1)) {
      continue;
    }
    level.enemy_spawner_vehicles[level.enemy_spawner_vehicles.size] = var_1;

    switch (var_0.group_name) {
      case "_encstr_8DCD0B50847B06356A6A203042":
      case "_encstr_BDAC0B3D15CA37C9F2DF5050F7":
      case "_encstr_A7640B5B96C8BE26934B237656":
      case "_encstr_8F8511831BC2BCB24EEB8D59CC47D7DCA5C8AC":
      case "_encstr_8C5D1238D8C2BC594ED79C96B343A3AFCDB48C95":
        var_1 thread enemy_spawner_vehicle_think(var_1, var_0.group_name);
        break;
      case "_encstr_824513723923B1D08A96EA3B87203969EBE8800221":
      case "_encstr_A5BA12D2896FF9CF33F7C4591D59508BAD573FA0":
        var_1 thread enemy_spawner_umike_think(var_1, var_0.group_name);
        break;
      case "_encstr_8CC60FAD20236A5E407F79B3CB4DA81817":
      case "_encstr_A2C714831BC22FCA937D275AB386A3AF9DA5E6C85AB0":
      case "_encstr_8FC313B811C09047EE3622BA39C5778B68ED2439A3":
        var_1 thread enemy_back_line_spawner_think(var_1, var_0.group_name);
        break;
      case "_encstr_8FB6151C5E23EFFBBFA1625AD0DD74B75BA89087EC697B":
        var_1 thread watchgastrapdamage(var_1, ::_id_12FF5);
        break;
      case "_encstr_9B0C1BD898E4859DBDAF36B0C99396B227EB1ADEB3594EAFCC9CDB73D1":
        var_1 thread watchgastrapdamage(var_1, ::_id_12FF6);
        break;
      case "_encstr_99701AA81A7AB948BFC1D8EBE0132DA86A81D08886E53D2E758AB1F7":
        var_1 thread watchgastrapdamage(var_1, ::_id_12FF7);
        break;
    }
  }
}

enemy_back_line_spawner_think(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_damage_monitor(var_0, 500000);
  wait 10;
  var_2 = var_0.riders;
  var_0 waittill("_encstr_A9210A283BEC90BB323450EC");
  var_0 thread infil_enemies_attack_logic(var_2, get_infil_rider_start_targetname(var_1));
}

get_infil_rider_start_targetname(var_0) {
  switch (var_0) {
    case "_encstr_8CC60FAD20236A5E407F79B3CB4DA81817":
      return::get_mindia_infil_rider_start_targetname;
    case "_encstr_8FC313B811C09047EE3622BA39C5778B68ED2439A3":
      return::get_left_vindia_infil_rider_start_targetname;
    case "_encstr_A2C714831BC22FCA937D275AB386A3AF9DA5E6C85AB0":
      return::get_right_vindia_infil_rider_start_targetname;
  }
}

infil_enemies_attack_logic(var_0, var_1) {
  foreach(var_3 in var_0)
  var_3 thread infil_enemy_combat_logic(var_3, var_1);
}

infil_enemy_combat_logic(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_B4350A0AAB73BA371120E5FC");
  var_0 waittill("_encstr_9AA60FC6859CEC56EB997BBD8E37E859C1");
  wait 0.1;
  var_2 = getgroundposition(var_0.origin, 25, 256, 256);

  if(var_2 != var_0.origin)
    var_0 forceteleport(var_2, var_0.angles, 256);

  level thread _id_11E5E(var_0.origin, var_0.angles, var_1);
  var_0.nocorpse = 1;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "_encstr_AB590C99ED78875F650F3951034D");
}

_id_11E5E(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_3.script_forcespawn = 1;
  var_3.script_noteworthy = "_encstr_A5450BC280BF4B604068C33187";
  var_4 = var_3 scripts\cp\cp_modular_spawning::spawn_ai();
  var_4 endon("_encstr_AD75063D571AE108");

  if(scripts\engine\utility::flag("_encstr_923A15DBC7AE534F1888252E80E8BC9A10771F2745DF1B"))
    var_4 thread _id_127F2(var_4);
  else {
    var_4.never_kill_off = 1;
    var_4.dontkilloff = 1;
    var_4.ignoreall = 0;
    var_4.skip_clear_kill_off_flag = 1;
    var_4 advance_through_struct_path(var_4, [[var_2]]());
  }
}

get_mindia_infil_rider_start_targetname() {
  var_0 = ["_encstr_924013911F7520D6F7A93BC352EB9B588D572735BD", "_encstr_993F130B70D15C8F5158839C6F5B6F656D59D3F308", "_encstr_A95D151CB78D2DC656FADC1D16D1D2EDE67DA34339B256", "_encstr_AF2714B8CA259329DF0FEE6509A350570D5180B8837A", "_encstr_BD3D0BEDCC335A8DCAEBEDB9B2", "_encstr_A73E0B2F5DBC1AEBA8966BB388", "_encstr_919C0CCD8EEDC985CE95F5DEB956", "_encstr_8D9C0CCD1DF6C985CEB2F5E8DDED", "_encstr_816A0E83AB57DEE807BD6F21A82A802D", "_encstr_B4BB0D2C1DE8B08DD69539FAB7372B", "_encstr_8CBB0D57FBA323B1B34758396BC748", "_encstr_874C0B4AF8BB7FFFF1F83F268D", "_encstr_864C0B4DFADCA0CCEF81E38BAA"];

  if(!isDefined(level.mindia_infil_start_targetname_array)) {
    level.mindia_infil_start_targetname_array = randomize_start_targetname_array(var_0);
    level.mindia_infil_start_targetname_array_index = 0;
  }

  var_1 = level.mindia_infil_start_targetname_array[level.mindia_infil_start_targetname_array_index];
  level.mindia_infil_start_targetname_array_index++;
  return var_1;
}

get_left_vindia_infil_rider_start_targetname() {
  var_0 = ["_encstr_B1DF0F63AC33E8F593B4D9CA39BEB7E659", "_encstr_8DE00F8D5699A3FAC9B4672B4E7DE8EEDE", "_encstr_8D7D11F007F60337A3244CDDFAA9B9484ABF30", "_encstr_9956107219846B69501BA6BD05116FBFB553", "_encstr_9A561071CD3FA330530243295B0F5410D325", "_encstr_87E00FC65699D1D7E45ACE59E47DE64B3C"];

  if(!isDefined(level.left_vindia_infil_start_targetname_array)) {
    level.left_vindia_infil_start_targetname_array = randomize_start_targetname_array(var_0);
    level.left_vindia_infil_start_targetname_array_index = 0;
  }

  var_1 = level.left_vindia_infil_start_targetname_array[level.left_vindia_infil_start_targetname_array_index];
  level.left_vindia_infil_start_targetname_array_index++;
  return var_1;
}

get_right_vindia_infil_rider_start_targetname() {
  var_0 = ["_encstr_95A010BBA3DCEA1C99130CD3E9A86FD220C3", "_encstr_B2A01013CAC763F0993A93D555BAE135DF02", "_encstr_AC1612CA6B80A413688342BB49D6871B50C55525", "_encstr_92C711C92DB343D1AF93A5CEB2E4F533F6BA39", "_encstr_B1C611D6996FF811292340A04ABA8FF1EF2ED5", "_encstr_8EA010C95AD986A3FA9C4BCE59E4F5B9D2F0"];

  if(!isDefined(level.right_vindia_infil_start_targetname_array)) {
    level.right_vindia_infil_start_targetname_array = randomize_start_targetname_array(var_0);
    level.right_vindia_infil_start_targetname_array_index = 0;
  }

  var_1 = level.right_vindia_infil_start_targetname_array[level.right_vindia_infil_start_targetname_array_index];
  level.right_vindia_infil_start_targetname_array_index++;
  return var_1;
}

randomize_start_targetname_array(var_0) {
  for(var_1 = 5; var_1 > 0; var_1--)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  return var_0;
}

enemy_spawner_umike_think(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_damage_monitor(var_0, 500000);
  wait 10;
  var_2 = var_0.riders;
  scripts\cp\vehicle_race\coop_vehicle_race::change_riders_demeanor(var_0);
  var_0 notify("_encstr_A7A420CDE8DB1CEBCE2BD04BD863ACEB7BB9AFC80BB5859DCAFAA537E856E4B92CC6");
  var_0 waittill("_encstr_BD82096B5DA4B07F924F29");
  var_0 thread back_line_enemies_attack_logic(var_2, undefined, var_1);
}

enemy_spawner_vehicle_think(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_damage_monitor(var_0, 5000);
  wait 1.5;
  scripts\cp\vehicle_race\coop_vehicle_race::change_riders_demeanor(var_0);
  var_0 notify("_encstr_A7A420CDE8DB1CEBCE2BD04BD863ACEB7BB9AFC80BB5859DCAFAA537E856E4B92CC6");
  var_0 notify("_encstr_BD97189B8EDBE0F5DD2CB41DA5373BBE33BD937DB90E58DD73B9");
  var_0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_no_rider_monitor(var_0);
  wait 0.5;
  var_0 vehicle_setspeedimmediate(25, 15, 15);
  var_0 thread unload_monitor(var_0, var_1);
}

unload_monitor(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = get_unload_marker_for_spawn_group(var_1);

  for(;;) {
    if(distance2dsquared(var_2.origin, var_0.origin) < 22500) {
      break;
    }

    waitframe();
  }

  var_0 vehicle_setspeedimmediate(0, 15, 15);
  var_0 scripts\common\vehicle::vehicle_unload("_encstr_99AB0BCE2813E78F75C0E32AE0");
  level thread start_riders_combat_logic(var_0.riders, var_0.riders[0], var_1);
  var_0 notify("_encstr_BD82096B5DA4B07F924F29");
  wait 2;
  var_0 vehicle_setspeedimmediate(25, 15, 15);
  var_0 thread reach_path_end_monitor(var_0, var_1);
}

start_riders_combat_logic(var_0, var_1, var_2) {
  wait 2;

  switch (var_2) {
    case "_encstr_8DCD0B50847B06356A6A203042":
      send_riders_to_proper_combat_spot(var_0, var_1, var_2, 0);
      break;
    case "_encstr_BDAC0B3D15CA37C9F2DF5050F7":
    case "_encstr_A7640B5B96C8BE26934B237656":
      under_bridge_enemies_attack_logic(var_0, var_1, var_2, 1);
      break;
    case "_encstr_8F8511831BC2BCB24EEB8D59CC47D7DCA5C8AC":
    case "_encstr_8C5D1238D8C2BC594ED79C96B343A3AFCDB48C95":
      back_line_enemies_attack_logic(var_0, var_1, var_2);
      break;
  }
}

under_bridge_enemies_attack_logic(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0)
  var_5 thread under_bridge_enemy_attack_logic(var_5, var_2, var_3);
}

send_riders_to_proper_combat_spot(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0)
  var_5 thread delay_set_goal_volume(var_5, var_2, var_3);
}

back_line_enemies_attack_logic(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_5.never_kill_off = 1;

    if(istrue(level.bomb_guardian_is_killed)) {
      if(!istrue(var_3)) {
        var_5 thread go_hunt_down_player(var_5, 0);
        var_3 = 1;
      } else
        var_5 thread back_line_enemy_attack_logic(var_5, var_2);

      continue;
    }

    var_5 thread back_line_enemy_attack_logic(var_5, var_2);
  }
}

get_combat_volume_targetname(var_0) {
  switch (var_0) {
    case "_encstr_8DCD0B50847B06356A6A203042":
      return var_0;
    case "_encstr_8C5D1238D8C2BC594ED79C96B343A3AFCDB48C95":
      return "_encstr_9563185937ACADE5F54C274B32B3CAF5F4B7DC56D79CA5D93447";
    case "_encstr_8F8511831BC2BCB24EEB8D59CC47D7DCA5C8AC":
      return "_encstr_8A7B17DDB56889C85191785F72EF5D09CB70FAE147B5F5CCA3";
    default:
      if(any_player_under_bridge()) {
        return "_encstr_A3A30D5DCD912B39FA894EA5193B56";
        return;
      }

      return var_0;
      return;
  }
}

any_player_under_bridge() {
  var_0 = getEnt("_encstr_A939122BCB07486BE902C3372D27A0CE33901D37", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }
    if(var_2 istouching(var_0))
      return 1;
  }

  return 0;
}

advance_through_struct_path(var_0, var_1) {
  level endon("_encstr_923A15DBC7AE534F1888252E80E8BC9A10771F2745DF1B");
  var_2 = 6;
  var_3 = 3;
  var_4 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.goalradius = 64;
  var_0 setgoalpos(getclosestpointonnavmesh(var_4.origin));
  var_0 waittill("_encstr_8B7205D9ED5958");

  for(;;) {
    if(isDefined(var_4.target)) {
      var_4 = scripts\engine\utility::getStruct(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0 setgoalpos(getclosestpointonnavmesh(var_4.origin));
      var_0 waittill("_encstr_8B7205D9ED5958");
      wait(randomfloatrange(var_3, var_2));

      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "_encstr_A3920FA7AF5F9A25AA99E78371F1189252") {
        if(issubstr(var_1, "_encstr_AA7B09475984AF0F6F0F0B"))
          var_0 thread go_hunt_down_player(var_0, 0);
        else
          var_0 thread go_hunt_down_player(var_0, 1);
      }

      continue;
    }

    return;
  }
}

under_bridge_enemy_attack_logic(var_0, var_1, var_2) {
  var_3 = 4;
  var_4 = 2;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.goalradius = 10;

  if(any_player_under_bridge())
    var_0 thread go_hunt_down_player(var_0, 0);
  else {
    var_5 = get_under_bridge_enemy_start_structs(var_1);
    var_0 setgoalpos(getclosestpointonnavmesh(var_5.origin));
    var_0 waittill("_encstr_8B7205D9ED5958");
    wait(randomfloatrange(var_4, var_3));

    for(;;) {
      if(isDefined(var_5.target))
        var_5 = scripts\engine\utility::getStruct(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      else
        var_5 = undefined;

      if(should_advance_to_next_goal_struct(var_5)) {
        var_0 setgoalpos(getclosestpointonnavmesh(var_5.origin));
        var_0 waittill("_encstr_8B7205D9ED5958");
        wait(randomfloatrange(var_4, var_3));
        continue;
      }

      break;
    }

    if(istrue(var_2))
      var_0 thread go_hunt_down_player(var_0, 1);
  }
}

get_under_bridge_enemy_start_structs(var_0) {
  if(!isDefined(level.mid_bridge_start_struct_index))
    level.mid_bridge_start_struct_index = 0;

  if(!isDefined(level.end_bridge_start_struct_index))
    level.end_bridge_start_struct_index = 0;

  if(var_0 == "_encstr_A7640B5B96C8BE26934B237656") {
    var_1 = scripts\engine\utility::getStructArray("_encstr_9B4211077C7267AA2A8205A7888FB8DC197A11", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = level.mid_bridge_start_struct_index;
    level.mid_bridge_start_struct_index++;

    if(level.mid_bridge_start_struct_index == var_1.size)
      level.mid_bridge_start_struct_index = 0;

    return var_1[var_2];
  }

  if(var_0 == "_encstr_BDAC0B3D15CA37C9F2DF5050F7") {
    var_3 = scripts\engine\utility::getStructArray("_encstr_B6791159CD467D269CB4193B2BAFE6E82C4EE8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = level.end_bridge_start_struct_index;
    level.end_bridge_start_struct_index++;

    if(level.end_bridge_start_struct_index == var_3.size)
      level.end_bridge_start_struct_index = 0;

    return var_3[var_2];
  }
}

delay_set_goal_volume(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 2;
  var_3 = getEnt(get_combat_volume_targetname(var_1), "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 setgoalvolumeauto(var_3);

  if(istrue(var_2)) {
    var_0 waittill("_encstr_8B7205D9ED5958");

    if(!is_goal_volume_ahead_of_vehicle_to_push(var_3))
      var_0 thread go_hunt_down_player(var_0, 1);
  }
}

back_line_enemy_attack_logic(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  wait(randomfloatrange(1.2, 2));
  var_2 = get_players_groups_by_whether_in_killzone();

  if(var_2.players_in_killzone.size > 0)
    advance_down_the_bridge(var_0, var_1);
  else
    go_hunt_down_player(var_0, 0);
}

advance_down_the_bridge(var_0, var_1) {
  var_2 = getEnt(get_combat_volume_targetname(var_1), "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_2))
    advance_down_the_bridge_via_volume(var_0, var_2);
  else
    advance_down_the_bridge_via_struct(var_0);
}

advance_down_the_bridge_via_struct(var_0) {
  var_1 = 4;
  var_2 = 2;
  var_0.goalradius = 10;
  var_3 = get_bridge_start_struct();
  var_0 setgoalpos(getclosestpointonnavmesh(var_3.origin));
  var_0 waittill("_encstr_8B7205D9ED5958");
  wait(randomfloatrange(var_2, var_1));

  for(;;) {
    if(isDefined(var_3.target))
      var_3 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else
      var_3 = undefined;

    if(should_advance_to_next_goal_struct(var_3)) {
      var_0 setgoalpos(getclosestpointonnavmesh(var_3.origin));
      var_0 waittill("_encstr_8B7205D9ED5958");
      wait(randomfloatrange(var_2, var_1));
      continue;
    }

    break;
  }

  go_hunt_down_player(var_0, 1);
}

get_bridge_start_struct() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_813D0D9D2A0C70FCDFB153BB3AEB2D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level.bridge_start_struct_index))
    level.bridge_start_struct_index = 0;

  var_1 = level.bridge_start_struct_index;
  level.bridge_start_struct_index++;

  if(level.bridge_start_struct_index == var_0.size)
    level.bridge_start_struct_index = 0;

  return var_0[var_1];
}

should_advance_to_next_goal_struct(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = anglesToForward(level.vehicle_to_push.angles);
  var_2 = vectorNormalize(level.vehicle_to_push.origin - var_0.origin);

  if(vectordot(var_2, var_1) < 0)
    return 0;
  else
    return 1;
}

advance_down_the_bridge_via_volume(var_0, var_1) {
  var_2 = 4;
  var_3 = 2;
  var_0 setgoalvolumeauto(var_1);
  var_0 waittill("_encstr_8B7205D9ED5958");
  wait(randomfloatrange(var_3, var_2));

  for(;;) {
    if(isDefined(var_1.target))
      var_1 = getEnt(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else
      var_1 = undefined;

    if(should_advance_to_next_goal_volume(var_1)) {
      var_0 setgoalvolumeauto(var_1);
      var_0 waittill("_encstr_8B7205D9ED5958");
      wait(randomfloatrange(var_3, var_2));
      continue;
    }

    break;
  }

  go_hunt_down_player(var_0, 1);
}

should_advance_to_next_goal_volume(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = anglesToForward(level.vehicle_to_push.angles);
  var_2 = vectorNormalize(level.vehicle_to_push.origin - var_0.origin);

  if(is_goal_volume_ahead_of_vehicle_to_push(var_0))
    return 0;
  else
    return 1;
}

is_goal_volume_ahead_of_vehicle_to_push(var_0) {
  var_1 = anglesToForward(level.vehicle_to_push.angles);
  var_2 = vectorNormalize(level.vehicle_to_push.origin - var_0.origin);
  return vectordot(var_2, var_1) < 0;
}

go_hunt_down_player(var_0, var_1) {
  var_0 notify("_encstr_BD57143238FF24EFF8157744A0E3BB2109B8DA2B807D");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BD57143238FF24EFF8157744A0E3BB2109B8DA2B807D");

  if(!isai(var_0)) {
    return;
  }
  var_0.goalradius = 256;
  var_0.goalheight = 128;
  var_0 cleargoalvolume();

  for(;;) {
    var_2 = get_rider_initial_target(var_1);

    if(isDefined(var_2)) {
      break;
    }

    wait 0.1;
  }

  var_0 getenemyinfo(var_2);
  var_0 setgoalentity(var_2, 100);
  var_3 = var_2;

  for(;;) {
    var_3 waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
    var_4 = get_closest_alive_player(var_0);
    var_0 getenemyinfo(var_4);
    var_0 setgoalentity(var_4, 100);
    var_3 = var_4;
  }
}

get_closest_alive_player(var_0) {
  var_1 = scripts\cp\raid_utility::get_players_not_in_laststand();
  return scripts\engine\utility::getclosest(var_0.origin, var_1);
}

get_rider_initial_target(var_0) {
  var_1 = get_players_groups_by_whether_in_killzone();

  if(istrue(var_0)) {
    if(var_1.players_in_killzone.size > 0)
      return scripts\engine\utility::random(var_1.players_in_killzone);

    return scripts\engine\utility::random(var_1.players_not_in_killzone);
  } else {
    if(var_1.players_not_in_killzone.size > 0)
      return scripts\engine\utility::random(var_1.players_not_in_killzone);

    return scripts\engine\utility::random(var_1.players_in_killzone);
  }
}

get_players_groups_by_whether_in_killzone() {
  var_0 = spawnStruct();
  var_1 = scripts\cp\raid_utility::get_players_not_in_laststand();
  var_2 = get_players_in_killzone(var_1);
  var_3 = [];

  foreach(var_5 in var_1) {
    if(scripts\engine\utility::array_contains(var_2, var_5)) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  var_0.players_in_killzone = var_2;
  var_0.players_not_in_killzone = var_3;
  return var_0;
}

get_unload_marker_for_spawn_group(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_AF3A223B4BA241305FDA0339C346C9041AFBBBBF3BCAAF68B6F5E8312F0F6B37836F2BE5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == var_0)
      return var_3;
  }
}

increase_script_maxdist(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.spawn_points.size; var_4++) {
    var_5 = var_0.spawn_points[var_4];
    var_5.script_maxdist = 20000;
  }
}

assign_more_vehicle_unload_groups() {}

create_not_driver_group() {
  var_0 = [];
  var_0[0] = 1;
  var_0[1] = 2;
  var_0[2] = 3;
  var_0[3] = 4;
  var_0[4] = 5;
  return var_0;
}

reach_path_end_monitor(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_8EE01139CA2C6C0D958CAF2B7346D737ED8CAC");

  foreach(var_3 in var_0.riders)
  var_3 scripts\cp\cp_modular_spawning::script_kill_ai();

  var_0 delete();
}

get_pre_respawn_group_wait(var_0) {
  switch (var_0) {
    case "_encstr_8C5D1238D8C2BC594ED79C96B343A3AFCDB48C95":
      return randomfloatrange(10, 20);
    case "_encstr_8F8511831BC2BCB24EEB8D59CC47D7DCA5C8AC":
      return randomfloatrange(10, 20);
  }
}

vehicle_progress_marker_think() {
  waitframe();
  var_0 = scripts\engine\utility::getStructArray("_encstr_A17E20AE2372291109D83753F77E2BAB13B3FF9B3398D82A92BBB746B2F7E2B07503", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread activate_vehicle_progress_marker(var_2);

  waitframe();
  scripts\engine\utility::flag_set("_encstr_83802B4B7990B9FAF10BC7734D28E2FA50038214D0584762D91B5F672F434A3608EE7E9F09F03F0BA519B77799");
}

player_progress_market_think() {
  var_0 = getEntArray("_encstr_8BB71B487BA9EA0B9B61979E45E26DD103AF18388B7F831D7217042D1A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread player_progress_trigger_think(var_2);
}

player_progress_trigger_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isPlayer(var_1)) {
      break;
    }
  }

  scripts\engine\utility::flag_set(get_player_progress_flag_to_set(var_1));
}

get_player_progress_flag_to_set(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_A17E20AE2372291109D83753F77E2BAB13B3FF9B3398D82A92BBB746B2F7E2B07503", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = sortbydistance(var_1, var_0.origin)[0];
  return var_2.script_noteworthy;
}

activate_vehicle_progress_marker(var_0) {
  level.vehicle_to_push endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_init(var_0.script_noteworthy);

  for(;;) {
    if(distance2dsquared(var_0.origin, level.vehicle_to_push.origin) < squared(150)) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set(var_0.script_noteworthy);
}

get_mortar_impact_spot(var_0) {
  if(!isDefined(var_0.targets))
    return undefined;

  var_1 = scripts\engine\utility::random(var_0.targets);
  var_2 = var_1 getvelocity();
  var_3 = distance(var_0.origin, var_1.origin);
  var_4 = 5;
  var_5 = var_1.origin + var_2 * var_4;
  var_6 = scripts\engine\trace::ray_trace(var_5 + (0, 0, 500), var_5, var_1);
  return var_6["_encstr_BD260953AA97E3F014279D"];
}

linkoffset() {
  foreach(var_1 in level.enemy_turrets) {
    deactivate_enemy_turret(var_1);
    var_1.little_bird_mg_reenter = 1;
  }
}

brdisablefinalkillcam() {
  scripts\engine\utility::flag_set("_encstr_923A15DBC7AE534F1888252E80E8BC9A10771F2745DF1B");
  waitframe();
  scripts\cp\cp_modular_spawning::remove_pacifist_from_enemies();
  var_0 = getaiarray("_encstr_8E8405EA382B2A");

  foreach(var_2 in var_0)
  var_2 thread _id_127F2(var_2);
}

_id_127F2(var_0) {
  var_0 notify("_encstr_82C41B53AA976DA9D6249FFF5B7E38BD7FC20878E237A5716D0F87E37B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_82C41B53AA976DA9D6249FFF5B7E38BD7FC20878E237A5716D0F87E37B");

  if(istrue(var_0.is_on_platform)) {
    return;
  }
  if(isDefined(var_0.going_to_object)) {
    var_1 = var_0.going_to_object;

    while(isDefined(var_0.going_to_object))
      waitframe();

    var_1 notify("_encstr_8102126E1DDE38D76BBD9C8E2C397D3A1A969BB6");
    var_1.targets = undefined;
  }

  if(isDefined(var_0.wztrain_info)) {
    var_0 unlink();
    var_0.wztrain_info delete();
    wait(randomfloatrange(0.3, 0.5));
  }

  var_0 thread scripts\cp\cp_modular_spawning::enter_combat();
  wait(randomfloatrange(0.1, 0.3));
  var_0.is_on_platform = 0;
  var_0.dontevershoot = 0;
  var_0 allowedstances("_encstr_A5AD069B231F0BAF", "_encstr_922406F1A6FD5E05", "_encstr_B13D076BED70539F23");
  var_0 setlookatentity();
  var_0.ignoreall = 0;
  var_0.combatmode = "_encstr_B68E06D8F6B3CA27";
  var_0 thread go_hunt_down_player(var_0, 0);
}

set_up_blockade_gates() {
  if(!scripts\engine\utility::flag_exist("_encstr_B105205640B0AB720F7127D76F27CBE5E88E4C1EFB084FDA551B03DF6FDD1367B0F3"))
    scripts\engine\utility::flag_init("_encstr_B105205640B0AB720F7127D76F27CBE5E88E4C1EFB084FDA551B03DF6FDD1367B0F3");

  _id_130FF();
  scripts\engine\utility::flag_set("_encstr_B105205640B0AB720F7127D76F27CBE5E88E4C1EFB084FDA551B03DF6FDD1367B0F3");
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_130FF() {
  laser_switch_manager("_encstr_A3840F11A67428A84AAFC7C557F28D782C");
  laser_switch_manager("_encstr_A9B810B3854795F519DEBD93BE4ED2B386E8");
  laser_switch_manager("_encstr_859F0A846E73FBC6589F80B0");
  level.scr_animtree["_encstr_A3460A8C2193E9F7550268C0"] = #animtree;
  level.scr_model["_encstr_A3460A8C2193E9F7550268C0"] = "_encstr_83BB2C25F3C8E723FBA0BBD108C9DD77806FB4A5AF710F6BABB1720A682B172719D82A51A41E1F7443636A53901D";
  level.scr_anim["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_88950636C6DE9B59"] = % _encstr_A2191F360EEB930BD2C8F53163EDC66DC28CACEBD92CD1B2F51B2B7DD88DBDB9CA;
  level.scr_animname["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_88950636C6DE9B59"] = "_encstr_A2191F360EEB930BD2C8F53163EDC66DC28CACEBD92CD1B2F51B2B7DD88DBDB9CA";
  level.scr_anim["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_AF9B051E14CA0F"] = % _encstr_A24920AF17AF036123CBFED98358A69AAED12716C8FAD3A7AED439673AED354F8BD3;
  level.scr_animname["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_AF9B051E14CA0F"] = "_encstr_A24920AF17AF036123CBFED98358A69AAED12716C8FAD3A7AED439673AED354F8BD3";
  level.scr_animtree["_encstr_AAA60B178003F5617D2B7FB48D"] = #animtree;
  level.scr_model["_encstr_AAA60B178003F5617D2B7FB48D"] = "_encstr_9255319FFB11B254105B50D1B19087EA7A0323372FCC7A2C68C60DA72968EFD2C783BF8733E541E220A9C92AA088141A252F7B";
  level.scr_anim["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_88950636C6DE9B59"] = % _encstr_B4921F513B470E38744C9FDD7CDDE05A6792695ED21745408132FBAF9BC5B81E1F;
  level.scr_animname["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_88950636C6DE9B59"] = "_encstr_B4921F513B470E38744C9FDD7CDDE05A6792695ED21745408132FBAF9BC5B81E1F";
  level.scr_anim["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_AF9B051E14CA0F"] = % _encstr_B271205E8B79F26AC3B917EB81F872532091572901D0BCE2306DD7278511FA8778BB;
  level.scr_animname["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_AF9B051E14CA0F"] = "_encstr_B271205E8B79F26AC3B917EB81F872532091572901D0BCE2306DD7278511FA8778BB";
  var_0 = scripts\engine\utility::getStruct("_encstr_92D90E8A5818EE9BDB65F57F372F5BFB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.targetname = "_encstr_92D90E8A5818EE9BDB65F57F372F5BFB";
    var_0.origin = (39812.5, 15256, -354);
    var_0.angles = (0, 204.999, 0);
  }

  var_1 = scripts\engine\utility::getStruct("_encstr_BDC613DC362BA38E0CCF60E83F4863EB231B43D08F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_1.targetname = "_encstr_BDC613DC362BA38E0CCF60E83F4863EB231B43D08F";
    var_1.origin = (39760, 15368, -354.172);
    var_1.angles = (0, 114.999, 0);
  }

  var_2 = scripts\engine\utility::getStruct("_encstr_848214A7CF69D2D7C3D80703085EB0EB135EEB5C20E3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_2)) {
    var_2 = spawnStruct();
    var_2.targetname = "_encstr_848214A7CF69D2D7C3D80703085EB0EB135EEB5C20E3";
    var_2.origin = (39864.6, 15143.7, -354.291);
    var_2.angles = (0, 114.999, 0);
  }

  var_3 = "_encstr_859017DD33511AE4B90847D7A030A7E2375FE757B0FF522CC1";
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_4.angles = var_1.angles;
  var_4 setModel(var_3);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_5.angles = var_2.angles;
  var_5 setModel(var_3);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_6.angles = var_0.origin;
  var_6 setModel("_encstr_83BB2C25F3C8E723FBA0BBD108C9DD77806FB4A5AF710F6BABB1720A682B172719D82A51A41E1F7443636A53901D");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_7.angles = var_0.origin;
  var_7 setModel("_encstr_9255319FFB11B254105B50D1B19087EA7A0323372FCC7A2C68C60DA72968EFD2C783BF8733E541E220A9C92AA088141A252F7B");
  level.computer_objective = [];
  level.computer_objective["_encstr_AB990AE088DF688706FFD4E9"] = var_0;
  level.computer_objective["_encstr_A59306224004FA23"] = [];
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_86ED0963452DABECD840DF"] = [];
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_86ED0963452DABECD840DF"]["_encstr_A5AD056A019C63"] = var_4;
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_86ED0963452DABECD840DF"]["_encstr_8253060E2B5FE330"] = var_5;
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"] = [];
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_A5AD056A019C63"] = var_6;
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_8253060E2B5FE330"] = var_7;
  level.computer_objective["_encstr_BA9105D8C6D283"] = [];
  level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_8A620726B266ED39B2"] = getEnt("_encstr_88B11AF0538FB10FC2D775106FBA4939D7F708108B6769DB9A3DF605", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"] = getEnt("_encstr_973219228DDF63C3D14A01E7E1270B45E7688C646BF8C730D461FB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.computer_objective["_encstr_BA9B052DF8A025"] = [];
  level.computer_objective["_encstr_BA9B052DF8A025"]["_encstr_A5AD056A019C63"] = "_encstr_BDF213DA964E335D9047F9C46349674FED4901C2B9";
  level.computer_objective["_encstr_BA9B052DF8A025"]["_encstr_8253060E2B5FE330"] = "_encstr_85F213AA49BA4178F3278858E737B193036F882E5C";
  var_6 useanimtree(#animtree);
  var_6.animname = "_encstr_A3460A8C2193E9F7550268C0";
  level.computer_objective["_encstr_AB990AE088DF688706FFD4E9"] thread scripts\common\anim::anim_first_frame_solo(var_6, "_encstr_88950636C6DE9B59");
  var_7 useanimtree(#animtree);
  var_7.animname = "_encstr_AAA60B178003F5617D2B7FB48D";
  level.computer_objective["_encstr_AB990AE088DF688706FFD4E9"] thread scripts\common\anim::anim_first_frame_solo(var_7, "_encstr_88950636C6DE9B59");
  var_8 = var_4.origin - var_6 gettagorigin("_encstr_BDF213DA964E335D9047F9C46349674FED4901C2B9");
  var_9 = var_4.angles - var_6 gettagangles("_encstr_BDF213DA964E335D9047F9C46349674FED4901C2B9");
  var_4 linktomoveoffset(var_6, "_encstr_BDF213DA964E335D9047F9C46349674FED4901C2B9", var_8, var_9);
  var_8 = var_7 gettagorigin("_encstr_85F213AA49BA4178F3278858E737B193036F882E5C") - var_5.origin;
  var_9 = var_7 gettagangles("_encstr_85F213AA49BA4178F3278858E737B193036F882E5C") - var_5.angles;
  var_5 linktomoveoffset(var_7, "_encstr_85F213AA49BA4178F3278858E737B193036F882E5C", var_8, var_9);
  var_6 hide();
  var_7 hide();

  if(isDefined(level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_8A620726B266ED39B2"]) && isDefined(level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"])) {
    level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_8A620726B266ED39B2"].original_origin = level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_8A620726B266ED39B2"].origin;
    level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"].original_origin = level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"].origin;
    level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"].origin = level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"].origin + (0, 0, -2000);
  }
}

laser_switch_manager(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1)) {
    foreach(var_3 in var_1)
    var_3 delete();
  }
}

open_blockade_gates() {
  if(!scripts\engine\utility::flag_exist("_encstr_B105205640B0AB720F7127D76F27CBE5E88E4C1EFB084FDA551B03DF6FDD1367B0F3"))
    scripts\engine\utility::flag_init("_encstr_B105205640B0AB720F7127D76F27CBE5E88E4C1EFB084FDA551B03DF6FDD1367B0F3");

  scripts\engine\utility::flag_wait("_encstr_B105205640B0AB720F7127D76F27CBE5E88E4C1EFB084FDA551B03DF6FDD1367B0F3");

  if(istrue(level.blockade_gates_are_opening)) {
    return;
  }
  level.blockade_gates_are_opening = 1;
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_A5AD056A019C63"] show();
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_8253060E2B5FE330"] show();
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_86ED0963452DABECD840DF"]["_encstr_A5AD056A019C63"] hide();
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_86ED0963452DABECD840DF"]["_encstr_8253060E2B5FE330"] hide();
  level.computer_objective["_encstr_AB990AE088DF688706FFD4E9"] thread scripts\common\anim::anim_single_solo(level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_A5AD056A019C63"], "_encstr_AF9B051E14CA0F");
  level.computer_objective["_encstr_AB990AE088DF688706FFD4E9"] scripts\common\anim::anim_single_solo(level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_8253060E2B5FE330"], "_encstr_AF9B051E14CA0F");

  if(isDefined(level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_8A620726B266ED39B2"]) && isDefined(level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"])) {
    level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"].origin = level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"].original_origin;
    level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_8A620726B266ED39B2"].origin = level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_8A620726B266ED39B2"].origin + (0, 0, -2000);
  }

  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_A5AD056A019C63"] notsolid();
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_8253060E2B5FE330"] notsolid();
  level.blockade_gates_are_opening = undefined;
}

close_blockade_gates() {
  if(!scripts\engine\utility::flag_exist("_encstr_B105205640B0AB720F7127D76F27CBE5E88E4C1EFB084FDA551B03DF6FDD1367B0F3"))
    scripts\engine\utility::flag_init("_encstr_B105205640B0AB720F7127D76F27CBE5E88E4C1EFB084FDA551B03DF6FDD1367B0F3");

  scripts\engine\utility::flag_wait("_encstr_B105205640B0AB720F7127D76F27CBE5E88E4C1EFB084FDA551B03DF6FDD1367B0F3");

  if(istrue(level.blockade_gates_are_closing)) {
    return;
  }
  level.blockade_gates_are_closing = 1;
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_A5AD056A019C63"] hide();
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_8253060E2B5FE330"] hide();
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_86ED0963452DABECD840DF"]["_encstr_A5AD056A019C63"] show();
  level.computer_objective["_encstr_A59306224004FA23"]["_encstr_86ED0963452DABECD840DF"]["_encstr_A5AD056A019C63"] show();
  level.computer_objective["_encstr_AB990AE088DF688706FFD4E9"] thread scripts\common\anim::anim_single_solo(level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_A5AD056A019C63"], "_encstr_88950636C6DE9B59");
  level.computer_objective["_encstr_AB990AE088DF688706FFD4E9"] scripts\common\anim::anim_single_solo(level.computer_objective["_encstr_A59306224004FA23"]["_encstr_A2AB064CC6B7EECD"]["_encstr_8253060E2B5FE330"], "_encstr_88950636C6DE9B59");

  if(isDefined(level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_8A620726B266ED39B2"]) && isDefined(level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"])) {
    level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"].origin = level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_960F06A7082B803D"].origin + (0, 0, -2000);
    level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_8A620726B266ED39B2"].origin = level.computer_objective["_encstr_BA9105D8C6D283"]["_encstr_8A620726B266ED39B2"].original_origin;
  }

  level.blockade_gates_are_closing = undefined;
}

cpoperationcrateactivatecallback(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");
  var_1 delete();
}

deploy_friendly_reinforcement_convoy() {
  var_0 = (48941, 12803, -121);
  level.friendly_convoy = [];
  var_1 = scripts\cp\coop_escort::create_friendly_convoy_vehicle("_encstr_A3661FAA65F86B5717508AE2C06B0D5B96DE0F3E04C0FFD11778D28B30C7439FC8");
  scripts\cp\coop_escort::add_to_friendly_convoy_list(var_1);
  var_2 = scripts\cp\coop_escort::create_not_drivable_player_vehicle("_encstr_97661F6605C7A8A5B55360A85ACF7D23C7AB60D08EB7328F9A1B7818E369073887");
  _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::add_gunner_turret(var_2);
  reinforcement_convoy_get_to_blockade(var_1, var_2);
  var_3 = getvehiclenode("_encstr_9103121BAF6A27AF7E2866D64A92C7AA4BD77019", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 attachpath(var_3);
  var_1 startpath();
  wait 1;
  var_4 = scripts\engine\utility::getStructArray("_encstr_BD4A0F2A03196BEF907FBBA01B58756F3E", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_5 = sortbydistance(var_4, var_0)[0];
  level thread _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::deploy_vehicle(var_5, _encstr_B8B92E9BC6E42D0EE89BCBB1E0BCADC207B9CB6C07EB8993FADCF2276DBCD959D096B16356EB479CC23BCA368BB36EC6::get_humvee_info(var_5));
  var_6 = var_2.origin;
  var_7 = var_2.angles;
  var_2 delete();
  level.player_humvee vehicle_teleport(var_6, var_7);
  scripts\cp\coop_escort::add_to_friendly_convoy_list(level.player_humvee);
  iprintlnbold("_encstr_84943C90D0ABC2EBB8FF2C7A27C5B70B49B00ADE6869FF12B3D53851AE887F45F192010232CDB75F296F2C5F17310F8EBD2BCBFA30A33ED3C0254060C49C");
  level waittill("_encstr_A1851BAB3A10EABAC2A1E3C355C0F08031CF4CA33438B89AD18B0BB003");
  var_1 thread scripts\cp\coop_escort::maintain_speed_with_player_vehicle(var_1);
  scripts\cp\coop_escort::waittill_vehicle_node_reached("_encstr_B16E12A2D150138157ABB3FBEF70CA5408FE0B3A");
  iprintlnbold("_encstr_8CC1397A3B59E41BED0B198E08D4D156B08DD1A102A5CD47DB048E432B042A2B049A8E583AA57BCD080BE63280E4CAE68DABAC80D1A1951012CAA4");
}

reinforcement_convoy_get_to_blockade(var_0, var_1) {
  var_2 = 40;
  var_3 = getvehiclenode("_encstr_A3661FAA65F86B5717508AE2C06B0D5B96DE0F3E04C0FFD11778D28B30C7439FC8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = getvehiclenode("_encstr_97661F6605C7A8A5B55360A85ACF7D23C7AB60D08EB7328F9A1B7818E369073887", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  iprintlnbold("_encstr_8536217733BAD69097A6894A1E722B83A2CBBF950FC21190BEFBF938B52B18C90A0317");
  var_0 attachpath(var_3);
  var_0 startpath();
  var_1 attachpath(var_4);
  var_1 startpath();
  var_0 vehicle_setspeedimmediate(var_2, var_2 * 0.5, var_2 * 0.5);
  var_1 vehicle_setspeedimmediate(var_2, var_2 * 0.5, var_2 * 0.5);
  scripts\cp\coop_escort::waittill_vehicle_node_reached("_encstr_849319A2C8BBC6CF1BE03B2104815F0ACB586A29B867BF0796FE61");
  var_0 vehicle_setspeedimmediate(0, 5, 5);
  var_1 vehicle_setspeedimmediate(0, 5, 5);
}

hide_enemy_mortar_shell() {
  var_0 = getEntArray("_encstr_95240DE7B3421899C6E23243D5AEC3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159");
}

vehicle_bridge_stage_five_music() {}

_id_129ED() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = self;
  var_1 = scripts\engine\utility::getStructArray(get_smoke_grenade_struct_targetname(var_0), "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  deploy_smoke_grenades_for_infil_via_structs(var_0, var_1, ["_encstr_9708118EBA934E2B8ED786C2E8C643D7D49B1D"], [(0, 0, 15)]);
}

_id_129EC() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = self;
  var_1 = scripts\engine\utility::getStructArray(get_smoke_grenade_struct_targetname(var_0), "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  deploy_smoke_grenades_for_infil_via_structs(var_0, var_1, ["_encstr_84F317B3D02AC05B30302D08231F99C3F0230B0FAB1497F2C1", "_encstr_A509163A8576D7EE96DC23EDEED7CC397B73A3AF1BACCCE8"], [(0, 0, 30), (0, 0, 30)]);
}

deploy_smoke_grenades_for_infil_via_structs(var_0, var_1, var_2, var_3) {
  for(var_4 = 5; var_4 > 0; var_4--)
    var_1 = scripts\engine\utility::array_randomize(var_1);

  foreach(var_6 in var_1) {
    var_7 = var_6.origin;
    var_8 = readytoleave(var_0, var_7, var_2, var_3);
    var_9 = var_7 - var_8;
    var_9 = var_9 * (1, 1, 0);
    var_9 = var_9 + (0, 0, 1) * length(var_9);
    magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", var_8, var_9 * 0.5, 0.05);
    wait(randomfloatrange(1, 1.5));
  }
}

readytoleave(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = 99999999;

  foreach(var_10, var_7 in var_2) {
    var_8 = var_0 gettagorigin(var_7);
    var_9 = distance2dsquared(var_8, var_1);

    if(var_9 <= var_5) {
      var_4 = var_10;
      var_5 = var_9;
    }
  }

  var_11 = var_2[var_4];
  var_12 = var_3[var_4];
  return var_0 gettagorigin(var_11) + var_12;
}

get_smoke_grenade_struct_targetname(var_0) {
  switch (var_0.targetname) {
    case "_encstr_8B741B3B2D59F08D63378993FB2BD830F905219096BF683F0AEF95ABB3":
    case "_encstr_9AA51A07B1582F564E7D6395CC47BE5DB596D695BEB98316EECDB29C":
      return "_encstr_AF5A1A63B299A3EBB34BE6C82DB0AFB9D6DB6D95D79D4EAC9B582356";
    case "_encstr_B6E71C22B03041621697EBBFDF33BBAF50F85DAF8898DF5B6F83F7AB33E6":
    case "_encstr_934E1B9FC42F827B2A495080A2C4011ED77DAB9A252F0B99D6D3C8F8CB":
      return "_encstr_B1DC1BC3DBB48274013BB47D5198A949167B2F2FBBF03A4A08C0AEC769";
  }
}

watchgastrapdamage(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.spawn_riders_and_play_intro_idle_anim = ["_encstr_A6150A3F942DE85A3772B379", "_encstr_B48D114E7838FECB3565F7C3B7EEE23F704347"];

  for(;;) {
    var_2 = var_0 scripts\engine\utility::_id_143B5("_encstr_8A540D08F2DB4D6821910109B91698", "_encstr_A35C12E79D8E1B5D38437FC9391063A3DE1B475F", "_encstr_97280E883F50BF2340BBAA4343A5A733");

    switch (var_2) {
      case "_encstr_97280E883F50BF2340BBAA4343A5A733":
        var_0.spawn_removefromarrays = undefined;
        var_3 = player_vo_confirm_pickup(var_0);
        var_4 = init_civs(var_3.origin, var_0, 2500, 256, 1, 50, race_ui_add_critical_message(), 12);
        var_5 = var_4[0];
        var_0 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_5);
        break;
      case "_encstr_8A540D08F2DB4D6821910109B91698":
        var_6 = [[var_1]](var_0);
        var_7 = init_civs(var_6, var_0, 2500, 256, 1, 40, protect_obj_a_internal(var_0), 12);
        var_8 = var_7[0];
        var_0 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_8);
        break;
      case "_encstr_A35C12E79D8E1B5D38437FC9391063A3DE1B475F":
        var_9 = var_0.riders;

        foreach(var_11 in var_9) {
          var_11.baseaccuracy = 1000;
          var_0 thread watchheatreduction(var_11, var_0);
        }

        break;
    }
  }
}

_id_12FF5(var_0) {
  var_1 = scripts\engine\utility::getclosest(var_0.origin, level.players);
  var_2 = scripts\cp\raid_utility::get_players_not_in_laststand();

  if(var_2.size >= 1) {
    var_3 = get_players_in_killzone(var_2);

    if(var_3.size >= 1)
      var_1 = scripts\engine\utility::getclosest(var_0.origin, var_3);
  }

  return var_1.origin + (0, 0, 756);
}

_id_12FF6(var_0) {
  var_1 = level.vehicle_to_push;
  var_2 = scripts\cp\raid_utility::get_players_not_in_laststand();

  if(var_2.size >= 1) {
    var_3 = get_players_in_killzone(var_2);

    if(var_3.size >= 1)
      var_1 = scripts\engine\utility::getclosest(var_0.origin, var_3);
  }

  return var_1.origin + (0, 0, 756);
}

_id_12FF7(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_88491B3698E4C2D9ED7DD8C29327A5CAC9AF2616C6ADFAC65673D159C9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1;
  var_3 = scripts\cp\raid_utility::get_players_not_in_laststand();

  if(var_3.size >= 1) {
    var_4 = get_players_groups_by_whether_in_killzone();
    var_5 = var_4.players_not_in_killzone;

    if(var_5.size >= 1)
      var_2 = scripts\engine\utility::getclosest(var_0.origin, var_5);
  }

  return var_2.origin + (0, 0, 756);
}

race_ui_add_critical_message() {
  return scripts\engine\utility::random(["_encstr_A6150A3F942DE85A3772B379", "_encstr_B48D114E7838FECB3565F7C3B7EEE23F704347"]);
}

player_vo_confirm_pickup(var_0) {
  var_1 = rebirthloadout(var_0);
  var_2 = (var_0.origin + var_1.origin) / 2;
  var_3 = _id_11A81(var_2, var_0.angles, 256, 1, 55);
  var_0 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_3);
  var_0 scripts\engine\utility::_id_143A5("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8B7205D9ED5958");
  return var_1;
}

_id_11A81(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.origin = var_0;
  var_5.angles = var_1;
  var_5.radius = var_2;
  var_5.speed = var_3;

  if(istrue(var_4))
    var_5.script_goalyaw = 1;

  return var_5;
}

rebirthloadout(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_97280E883F50BF2340BBAA4343A5A733", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = -99999;
  var_3 = var_1[0];
  var_4 = anglesToForward(var_0.angles);

  foreach(var_6 in var_1) {
    var_7 = vectorNormalize(var_6.origin - var_0.origin);
    var_8 = vectordot(var_7, var_4);

    if(var_8 > var_2) {
      var_2 = var_8;
      var_3 = var_6;
    }
  }

  return var_3;
}

watchheatreduction(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");
  waitframe();
  getdismembermentlist(var_1);
}

getdismembermentlist(var_0) {
  if(!c130_lights(var_0, [2, 3, 4])) {
    _id_12BD4(var_0, "_encstr_B48D114E7838FECB3565F7C3B7EEE23F704347");
    return;
  }

  if(!c130_lights(var_0, [5, 6, 7])) {
    _id_12BD4(var_0, "_encstr_A6150A3F942DE85A3772B379");
    return;
  }
}

_id_12BD4(var_0, var_1) {
  var_0.spawn_riders_and_play_intro_idle_anim = scripts\engine\utility::array_remove(var_0.spawn_riders_and_play_intro_idle_anim, var_1);

  if(isDefined(var_0.spawn_removefromarrays) && var_0.spawn_removefromarrays == var_1)
    var_0 notify("_encstr_97280E883F50BF2340BBAA4343A5A733");
}

_id_13B6F(var_0) {
  wait(10 + var_0.vehicle_position * 2);
  var_0 dodamage(var_0.health + 100, var_0.origin);
}

c130_lights(var_0, var_1) {
  foreach(var_3 in var_1) {
    foreach(var_5 in var_0.riders) {
      if(isalive(var_5) && isDefined(var_5.vehicle_position) && var_5.vehicle_position == var_3)
        return 1;
    }
  }

  return 0;
}

protect_obj_a_internal(var_0) {
  if(isDefined(var_0.spawn_removefromarrays))
    return var_0.spawn_removefromarrays;

  var_1 = scripts\engine\utility::random(var_0.spawn_riders_and_play_intro_idle_anim);
  var_0.spawn_removefromarrays = var_1;
  return var_1;
}

init_civs(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = vectorNormalize(var_1.origin - var_0);
  var_9 = int(360 / var_7);
  var_10 = vectortoangles(var_8);

  if(var_6 == "_encstr_A6150A3F942DE85A3772B379")
    var_9 = var_9 * -1;

  var_11 = [];

  for(var_12 = 1; var_12 <= var_7; var_12++) {
    var_13 = var_10 + (0, var_9 * var_12, 0);
    var_14 = _id_11A8E(var_0, var_13, var_2, var_3, var_4, var_5, var_6);

    if(var_12 == var_7)
      var_14.script_noteworthy = "_encstr_8A540D08F2DB4D6821910109B91698";

    var_11[var_11.size] = var_14;
  }

  hostage_vo(var_11);
  return var_11;
}

hostage_vo(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    var_2 = var_0[var_1];
    var_3 = var_0[var_1 + 1];
    var_2.target = var_3.targetname;
    scripts\cp\utility::addtostructarray("_encstr_A16007A921A23B85E3", var_2.targetname, var_3);
  }
}

_id_11A8E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.origin = var_0 + anglesToForward(var_1) * var_2;
  var_7.radius = var_3;
  var_7.speed = var_5;
  var_7.targetname = scripts\cp\cp_vehicles::create_unique_kvp_string();
  scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_7.targetname, var_7);
  var_8 = vectortoangles(vectorNormalize(var_7.origin - var_0));

  if(istrue(var_4))
    var_7.script_goalyaw = 1;

  if(var_6 == "_encstr_B48D114E7838FECB3565F7C3B7EEE23F704347")
    var_7.angles = vectortoangles(anglestoleft(var_8));
  else
    var_7.angles = vectortoangles(anglestoright(var_8));

  return var_7;
}

build_vehicles() {
  scripts\vehicle\techo::main("_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382", "_encstr_8DC71569E5A638C00F6B687263378E48BD6ED70BB70E40", "_encstr_8F1F252BCBDD72E84D7E4E7BE1A95130C521D343A9DFBB539D23108F5DEB987808C68748EAF368");
  scripts\vehicle\techo::main("_encstr_9AD81367CA0D1CBEB19667EB63CD46AF3A2B6C1AF6", "_encstr_ADA706A3E4BA1BB6", "_encstr_8F1F252BCBDD72E84D7E4E7BE1A95130C521D343A9DFBB539D23108F5DEB987808C68748EAF368");
  scripts\cp\cp_vehicles::register_combined_vehicles(scripts\vehicle\umike::main, "_encstr_BE921B0BC15B92A11053E4CF41D0B7C77D787242A9B8EB24988FE9FB57", "_encstr_9AC61183A0ABF33F2650086A4B2493561003CF", "_encstr_8C1B2F2FF8AB81EB1958635F3BCB125C91B1FFB7BA66D493236E2CD99D9BCA1339495F4FA0992A2A6968F20C838F02A383", undefined, "_encstr_B88216702D6F443D40E26F9EA56B6F4201D9F0CB66724ECA", "_encstr_B88216702D6F443D40E26F9EA56B6F4201D9F0CB66724ECA");
  scripts\cp\cp_vehicles::register_combined_vehicles(scripts\vehicle\umike::main, "_encstr_ADE5229D8758818F7A4A790F5ABEB1891B2D41971A219B0AE7629DCB17231CB7A6F4210A", "_encstr_9AC61183A0ABF33F2650086A4B2493561003CF", "_encstr_91892E9B6C39B438E87DECB2A12DC6B1B27DB4EEC1D7A339D58DB5FAEAB696AD59BE3896D8AD5707BEC11AF2B9968DCD", undefined, "_encstr_ADBD0E10C5D84BE589B80DBA93625F0B", "_encstr_ADBD0E10C5D84BE589B80DBA93625F0B");
  scripts\vehicle\vindia::main("_encstr_8CD81F73639327FFF0B89551F0730CA974938BB3C34F19B952468A644AD059224E", "_encstr_A9BD126328309B5418A75040C3A01CDFE6864B8B", "_encstr_AB911DF6A91A7BB72301C3E5A893A0A0D08163E3312E13A72EF1EF915911BE");
}

ascendermodelworld() {
  var_0 = getEntArray("_encstr_924517EF55858023AF0BEE93E2736D901DCD4F53D76D18F8EB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread scripts\cp\utility::create_fake_loot(["_encstr_99F3154C4EB17BF6D1EB6BD5DCA5474BB7737D58B6DAF6"]);
}

cp_arms_dealer_sound_load() {
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42580.9, 16468.8, -566.727), (359.354, 192.412, 354.078));
  scripts\cp\raid_utility::pausemodetimer("_encstr_8F561D85C952C972509F8A17612C6FF7132BDDAA77136EFC318EA140B03F2B", (42423, 16664.8, -583), (339.085, 204.711, 164.005));
  scripts\cp\raid_utility::pausemodetimer("_encstr_8F561D85C952C972509F8A17612C6FF7132BDDAA77136EFC318EA140B03F2B", (42558.8, 16441.9, -594.659), (338.039, 268.227, 151.674));
  scripts\cp\raid_utility::pausemodetimer("_encstr_8F561D85C952C972509F8A17612C6FF7132BDDAA77136EFC318EA140B03F2B", (42613.7, 16665.5, -366.528), (341.61, 118.659, 198.868));
  scripts\cp\raid_utility::pausemodetimer("_encstr_937F16FCAE2B26358E4AC011C3A5D778B76F8EF80CA72845", (42610.1, 16495.5, -640.002), (0, 107, 0));
  wait 0.25;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42570.9, 16519.9, -517.571), (1.58926, 195.306, 1.01012));
  scripts\cp\raid_utility::pausemodetimer("_encstr_8F561D85C952C972509F8A17612C6FF7132BDDAA77136EFC318EA140B03F2B", (42706.8, 16481.8, -367.527), (288.424, 317.631, 68.1296));
  wait 0.25;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42537.3, 16571.5, -382.172), (0, 0, 168.999));
  wait 0.25;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42408.3, 16542.9, -382.157), (0, 0, 164.999));
  wait 0.25;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42176.4, 16473.7, -382.092), (0, 0, 173.999));
  wait 0.2;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3D312B3CCC3AF9C2CA519AF89A53BAFCC4B39AC", (42670.9, 16822.8, -368.998), (5.6547, 193.44, 1.89147));
  wait 0.1;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42215.1, 16380.4, -382.157), (0, 0, 167.999));
  wait 0.4;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42181.3, 16613, -379.426), (0, 0, 169.999));
  wait 0.1;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42691.5, 16368, -360.016), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42494, 16781.1, -360.068), (8.65305, 193.54, 1.90393));
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3D312B3CCC3AF9C2CA519AF89A53BAFCC4B39AC", (42713.7, 16433.5, -363.777), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3D312B3CCC3AF9C2CA519AF89A53BAFCC4B39AC", (41949, 16462.9, -362.998), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("_encstr_B4FD159B8D03C95AA0C6FA02F8A85F92533D5FC74F2142", (42743.4, 16725.1, -366.527), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("_encstr_B4FD159B8D03C95AA0C6FA02F8A85F92533D5FC74F2142", (42973.5, 16521.4, -363.503), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("_encstr_B4FD159B8D03C95AA0C6FA02F8A85F92533D5FC74F2142", (42330.3, 16200.4, -363.385), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("_encstr_B4FD159B8D03C95AA0C6FA02F8A85F92533D5FC74F2142", (42759, 16904.5, -363.503), (5.6547, 193.44, 1.89147));
  wait 0.2;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42361.1, 16563.5, -366.527), (275.445, 52.3922, 144.714));
  wait 0.1;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42379.1, 16701.9, -360.149), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("_encstr_B4FD159B8D03C95AA0C6FA02F8A85F92533D5FC74F2142", (42776.9, 16515.3, -372.527), (5.6547, 193.44, 1.89147));
  wait 0.2;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42584.2, 16279.4, -360.373), (5.6547, 193.44, 1.89147));
  wait 0.1;
  scripts\cp\raid_utility::pausemodetimer("_encstr_A3561D3C6EEBE6D50DEA3870222783BEBF19463DFF2BE90BF5F130F04BB1E3", (42435.8, 16342.2, -366.527), (275.022, 171.293, 22.0371));
}

load_vfx() {
  level._effect["_encstr_95781433AB1FA24AA891D7BBEBF358EF81E0B210886B"] = loadfx("_encstr_8AE827D933F0E55ADD837D8DE0BC3B661EAF6EB9D21C95937DB5D5F43D36B2AF66D858E61A179D991E");
  level._effect["_encstr_836B11D7287971056B68E3FF25B0719237B835"] = loadfx("_encstr_88092754F7EB374817BAA9508317E3ED93D14ED08CC37BD3D7BB7060577CD93FEA02D0EE22FE1519C8");
}

associate_digit_display_model() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_ACF51DA7FD8739AFA375EF239E8FE01211664D05AB175661AFE5B038A5C0AB");
  var_0 = getEnt("_encstr_BA5D2826D87BC6ADB02395FA9839A519EC56AF1C932BCD9BBA39B2AF37AC7337F627FAA3C9B4D9CE2B39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level.vehicle_to_push)) {
    while(!isDefined(level.vehicle_to_push))
      wait 0.5;
  }

  for(;;) {
    var_1 = level.vehicle_to_push gettagorigin("_encstr_8AD00A6D0E22EFA13AE75850");

    if(ispointinvolume(var_1, var_0)) {
      break;
    }

    var_2 = anglesToForward(level.vehicle_to_push.angles) * (1, 1, 0);
    var_3 = vectorNormalize(var_0.origin - var_1) * (1, 1, 0);

    if(vectordot(var_3, var_2) < 0) {
      break;
    }

    wait 0.1;
  }

  var_0 delete();
  level thread scripts\cp\bomb_defusal\coop_bomb_defusal::bombs_explode();
}

_id_138C3() {
  level notify("_encstr_ACF51DA7FD8739AFA375EF239E8FE01211664D05AB175661AFE5B038A5C0AB");
  var_0 = getEnt("_encstr_BA5D2826D87BC6ADB02395FA9839A519EC56AF1C932BCD9BBA39B2AF37AC7337F627FAA3C9B4D9CE2B39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 delete();
}

computermakingnose() {
  if(istrue(level.coop_bomb_defusal_count_down_started))
    return 2;
  else
    return 1;
}

computer_listener_all(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = getEnt("_encstr_82C7151B4938BAE388F12FB96B3831D385CD67872153D3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = (0, 0, -10000);
  var_1.original_origin = var_1.origin;

  if(!istrue(var_0))
    var_1.origin = var_1.original_origin + var_2;

  for(;;) {
    level waittill("_encstr_8872162A913096FFE7D1329939CF430AE87BB28F27905CDB", var_3);

    if(var_3 == "_encstr_AB0703DBB9") {
      var_1.origin = var_1.original_origin;
      continue;
    }

    if(var_3 == "_encstr_BA19049F4B2D") {
      var_1.origin = var_1.original_origin + var_2;
      continue;
    }

    if(var_3 == "_encstr_A25F0710622DF3B3D7") {
      var_1 delete();
      return;
    } else
      wait 0.05;
  }
}

computer_interface_think_internal() {
  var_0 = getEntArray("_encstr_B6BC1443553198E57B1F8195DFF23CB0DA61C87B7A8C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0)
  thread scripts\cp\raid_utility::_id_130A9(var_2);
}

blockade_landmine() {
  level.landmine_trig = getEnt("_encstr_9B430E037ED25CA5ECF2859FA3D568CF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level.landmine_trig)) {
    return;
  }
  level thread populate_landmine_signs();
  level.landmine_trig thread landmine_think();
}

populate_landmine_signs() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_83380E18FF16F9ABFAFDEDF892D2F7E0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_3 setModel("_encstr_8A6E15B6CAF5E6A5CECDFA6B4B9B59CC2DACD823F50391");
    var_3.angles = var_2.angles;
    waitframe();
  }
}

landmine_think() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  while(!istrue(self.landmine_disabled)) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0, var_1, var_2, var_3, var_4, var_5);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(!isDefined(var_0) || istrue(self.landmine_disabled)) {
      continue;
    }
    if(istrue(var_0.landmine_active)) {
      continue;
    }
    if(istrue(var_0.spectating)) {
      continue;
    }
    childthread landmine_run_on_player(var_0);
  }
}

landmine_run_on_player(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0.landmine_active = 1;
  var_0.waiting_for_lethal_restock = var_0.origin;
  var_1 = 50000;
  var_2 = 3;
  var_3 = "_encstr_B40101";
  var_4 = var_0 getdroptofloorposition(var_0.origin);

  while(var_0 istouching(self) && var_2 > 0) {
    if(abs(var_0.origin[2] - var_4[2]) < 4) {
      break;
    }

    var_2 = var_2 - 0.05;
    wait 0.05;
  }

  var_5 = randomfloatrange(0.35, 0.75);
  var_6 = var_0.origin;
  var_7 = var_6;

  while(var_0 istouching(self) && var_5 > 0) {
    if(distance2dsquared(var_6, var_0.origin) >= 12) {
      break;
    }

    if(distance2dsquared(var_7, var_0.origin) > 2) {
      var_7 = var_0.origin;
      var_5 = var_5 - 0.05;
    }

    wait 0.05;
  }

  if(!var_0 istouching(self)) {
    var_0.shouldskipdeathsshield = undefined;
    var_0.landmine_active = 0;
    var_0.shouldskiplaststand = 0;
  } else {
    var_0.shouldskiplaststand = 1;
    var_4 = var_0 getdroptofloorposition(var_0.origin);
    var_8 = magicgrenademanual("_encstr_81430B218B3F7018458997D78A", var_4 + (0, 0, 10), (0, 0, 4), 0.05);
    var_9 = var_8.origin;
    var_8.owner = spawnStruct();
    var_8.owner.team = "_encstr_8E8405EA382B2A";
    var_8.team = "_encstr_8E8405EA382B2A";
    wait 0.1;
    var_0.shouldskipdeathsshield = 1;
    var_0 dodamage(var_1, var_0.origin, self);

    if(istrue(var_0.inlaststand))
      var_0 notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");

    var_0 scripts\engine\utility::_id_143B9(1, "_encstr_AD75063D571AE108");
    var_0.shouldskipdeathsshield = undefined;
    var_0.landmine_active = 0;
    var_0.shouldskiplaststand = 0;

    while(!isDefined(var_0.dogtag))
      wait 0.05;

    var_10 = (0, 0, 40);

    if(isDefined(var_0.last_good_pos))
      var_0.dogtag.origin = var_0.last_good_pos + var_10;
    else {
      if(isDefined(var_0.waiting_for_lethal_restock)) {
        var_0.dogtag.origin = getclosestpointonnavmesh(var_0.waiting_for_lethal_restock) + var_10;
        return;
      }

      var_0.dogtag.origin = getclosestpointonnavmesh(var_0.dogtag.origin) + var_10;
    }
  }
}