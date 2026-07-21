/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_br_syrk\vehicle_travel.gsc
*************************************************/

init() {
  init_vehicle_repair_anims();
  load_fx();
  level thread hostage_near_vehicle_monitor();
  level thread watch_for_host_migration();
  level.vehicle_interaction_info = [];
  level.unidentified_ieds = [];
  level.marked_enemy_ai = [];
  level.marked_critical_enemy_ai = [];
  level.removefromtargetmarkeronkillfunc = ::remove_from_overwatch_target_group;
  register_vehicle_interaction_info("_encstr_9AE307B956E345D0AB", &"_encstr_AA751968A0FAB28A4252346251AFA8A482AC2AC4CB8829922B8A4A", ::try_start_driving, ::start_driver_role, ::exit_driver_role, "_encstr_A6E308B2DCE8B0B936B2", 200, 90, 72, 90, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_8CF00A181FEBFB5B6A5FCD4E", &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", undefined, ::enter_passenger_seat, ::exit_passenger_seat, "_encstr_A6E308B2DCE8B0B936B2", 200, 90, 72, 90, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698", &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", undefined, ::enter_left_back_seat, ::exit_left_back_seat, "_encstr_A6E308B2DCE8B0B936B2", 200, 90, 72, 90, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B", &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", undefined, ::enter_right_back_seat, ::exit_right_back_seat, "_encstr_A6E308B2DCE8B0B936B2", 200, 90, 72, 90, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_8D48079DD59BE65627", &"_encstr_AA07196828FA958A244A68C4547D514A142B512679A3AA9C9C5425", undefined, ::enter_gunner_seat, ::exit_gunner_seat, "_encstr_A6E308B2DCE8B0B936B2", 100, 360, 64, 360, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_AC480A070831CEB2611BEF22", &"_encstr_824E1C9659BF1BB91B6F7B81B1E1113FEFA717EBAFC4DA6F8ED751A46F53", undefined, ::enter_grenadier_seat, ::exit_grenadier_seat, "_encstr_A6E308B2DCE8B0B936B2", 100, 90, 64, 90, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_838910DD3CC32B6739B8AF8BC9732122B155", &"_encstr_81561C9EC06FB353DCA826C42FCF1D3F6D2B25ECE8A0D6B74AD48F7B39BC", undefined, ::enter_reaper_right, ::exit_reaper, "_encstr_A6E308B2DCE8B0B936B2", 30, 90, 30, 65, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_9BA00F277525B3E7800BA66C86633D2A05", &"_encstr_81561C9EC06FB353DCA826C42FCF1D3F6D2B25ECE8A0D6B74AD48F7B39BC", undefined, ::enter_reaper_left, ::exit_reaper, "_encstr_A6E308B2DCE8B0B936B2", 30, 90, 30, 65, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_ADF31660AF7B6BD33AAF40D587B20370C3376910D70740D1", &"_encstr_BD3922514999FDFD7B29C6493DFF073DF6D1E9B116A59B777F0179D5CFBB6D6DAFF8A171", undefined, ::enter_missile_defense_right, ::exit_missile_defense, "_encstr_A6E308B2DCE8B0B936B2", 20, 90, 20, 40, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_B4AC15DDA818F3EA41BB17F3937C1256B0B1D9E541E8BC", &"_encstr_BD3922514999FDFD7B29C6493DFF073DF6D1E9B116A59B777F0179D5CFBB6D6DAFF8A171", undefined, ::enter_missile_defense_left, ::exit_missile_defense, "_encstr_A6E308B2DCE8B0B936B2", 20, 90, 20, 40, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_92651150529E9FA6E33D6C5D2FB32971C63A28", &"_encstr_911919735121AB27B4F9E780FDE99457F535EF7128A17D29290F59", undefined, ::enter_repair, ::exit_repair, undefined, 200, 90, 72, 90, "_encstr_97C20EB5FD43A179CC6AD05152651579", 0);
  register_vehicle_interaction_info("_encstr_B6B91289161BD6AF9CD23B1A8EFA4E2B382CD2E4", &"_encstr_911919735121AB27B4F9E780FDE99457F535EF7128A17D29290F59", undefined, ::enter_repair, ::exit_repair, undefined, 200, 90, 72, 90, "_encstr_97C20EB5FD43A179CC6AD05152651579", 0);
  register_vehicle_interaction_info("_encstr_81EF129927BD73D1D71B956647D74ECA0E2CD2E4", &"_encstr_911919735121AB27B4F9E780FDE99457F535EF7128A17D29290F59", undefined, ::enter_repair, ::exit_repair, undefined, 200, 90, 72, 90, "_encstr_97C20EB5FD43A179CC6AD05152651579", 0);
  register_vehicle_interaction_info("_encstr_ADE513BDDB5F2DA459FBFB7F1AA4C7C23B6A499F6B", &"_encstr_911919735121AB27B4F9E780FDE99457F535EF7128A17D29290F59", undefined, ::enter_repair, ::exit_repair, undefined, 200, 90, 72, 90, "_encstr_97C20EB5FD43A179CC6AD05152651579", 0);
  register_vehicle_interaction_info("_encstr_B4610CAA50F73F5F53A560694BBB", &"_encstr_911919735121AB27B4F9E780FDE99457F535EF7128A17D29290F59", undefined, ::enter_hood_repair, ::exit_hood_repair, undefined, 200, 90, 72, 90, "_encstr_97C20EB5FD43A179CC6AD05152651579", 0);
  register_vehicle_interaction_info("_encstr_BEC00FF820362DE7B7215A5FD8E1DFF3D3", &"_encstr_95DD216D1257B9AD903FA7B127C96DC121FBD50455F38177081F938F7B90DFB9F7837F", undefined, ::enter_change_loadout, ::exit_change_loadout, undefined, 200, 45, 72, 45, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 1);
  register_vehicle_interaction_info("_encstr_AFA81237E3D0C6E3307D07135341AA3F58E86DFD", &"_encstr_8A3C1E67A311CCC1B8A4958C5F4781062813D3F1C6A93D8181CD7CE6760D31D0", undefined, ::enter_refill_ammo, undefined, undefined, 35, 45, 30, 45, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", 1);
  register_vehicle_interaction_info("_encstr_861B171385B1ADAFE4D2ECD03ABE939533963663BE58B6DAED", &"_encstr_8A3C1E67A311CCC1B8A4958C5F4781062813D3F1C6A93D8181CD7CE6760D31D0", undefined, ::enter_refill_ammo, undefined, undefined, 20, 15, 20, 15, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", 1);
  register_vehicle_interaction_info("_encstr_AF4816130BD8D6D7C695CCA37D395933A5D8C6EB586BB5DB", &"_encstr_8A3C1E67A311CCC1B8A4958C5F4781062813D3F1C6A93D8181CD7CE6760D31D0", undefined, ::enter_refill_ammo, undefined, undefined, 20, 15, 20, 15, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", 1);
  register_vehicle_interaction_info("_encstr_88FE111A736CFBB8871823FF0B605F3B922987", &"_encstr_A34A23F599E7BCB99CC107E135B1F96647518D9CF6BB7D6922E903DD1DE961A0A789856538", undefined, ::enter_retrieve_hostage, ::exit_retrieve_hostage, undefined, 200, 90, 72, 90, "_encstr_82370F09B522B08D175A6876A32BC8E07B", 0);
}

deploy_vehicle(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_2 = spawnVehicle(var_1.model, "_encstr_AC540D92105BA5B3D95D1C12ED21EF", var_1.vehicle_gdt, var_0.origin, var_0.angles);
  var_2 makeentitysentient("_encstr_9A8507BA4040188D08", 0);
  process_linked_ents(var_2, var_0);
  init_vehicle(var_2, var_1);
  var_2.infected_music = "_encstr_AC540D92105BA5B3D95D1C12ED21EF";
  set_up_fake_character_models(var_2);
  set_up_vehicle_interactions(var_2, var_1);
  set_up_ied_triggering_tags(var_2, var_1);
  add_additional_parts(var_2, var_1);
  add_to_vehicle_travel_array(var_2);
  make_reaper_drone(var_2);
  var_2 thread vehicle_damage_monitor(var_2, var_1);
  var_2 thread tread_vfx_think(var_2);
  var_2 thread debug_setup_warp_jeep_to_players();
  var_2 thread _id_14222(var_2);
  var_2 thread _id_14223(var_2);
  level.player_humvee = var_2;
  level notify("_encstr_91FC13D6727A87A805CBA9C8F35902EB33D146574A");
  var_2.nav_obstacle = createnavrepulsor("_encstr_919A0C0984B819E44F52E0A97A27", 0, var_2, 128, 1);
}

deploy_friendly_hvi_vehicle(var_0, var_1) {
  var_2 = spawnVehicle(var_1.model, "_encstr_951F0C5C02D7D9A5674240D0FBFC", var_1.vehicle_gdt, var_0.origin, var_0.angles);
  process_linked_ents(var_2, var_0);
  init_vehicle(var_2, var_1);
  set_up_fake_character_models(var_2);
  set_up_vehicle_interactions(var_2, var_1);
  set_up_ied_triggering_tags(var_2, var_1);
  add_additional_parts(var_2, var_1);
  var_2 thread tread_vfx_think(var_2);
  disable_vehicle_interaction(var_2, "_encstr_9AE307B956E345D0AB");
  disable_vehicle_interaction(var_2, "_encstr_8CF00A181FEBFB5B6A5FCD4E");
  disable_vehicle_interaction(var_2, "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B");
  return var_2;
}

process_linked_ents(var_0, var_1) {
  var_2 = getEntArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    switch (var_4.script_noteworthy) {
      case "_encstr_AF740E06B01E0F3ABFDA63704BE8D8F8":
        var_4 linkTo(var_0);
        var_4 thread vehicle_linked_ent_clean_up_think(var_0, var_4);
        break;
      case "_encstr_AD4916577332AC9CF5CECA34A5D81B56BE8EE4A576CE59E4":
        var_4 enablelinkTo();
        var_4 linkTo(var_0);
        var_4 thread vehicle_linked_ent_clean_up_think(var_0, var_4);
        var_0.under_vehicle_trigger = var_4;
        break;
      default:
    }
  }
}

vehicle_linked_ent_clean_up_think(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");
  var_1 delete();
}

teleport_humvee_to_struct(var_0) {
  if(isDefined(level.player_humvee)) {
    if(level.player_humvee vehicle_isphysveh()) {
      var_1 = getclosestpointonnavmesh(var_0.origin);
      var_2 = (0, var_0.angles[1], 0);
      level.player_humvee vehicle_teleport(var_1, var_2);
    }
  }
}

enter_change_loadout(var_0, var_1, var_2) {
  var_1 notify("_encstr_AFEE1595D8637F7A5FC052DAB077F7DF1830190CE0EBE3");
  var_1 setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);
  waitframe();

  for(;;) {
    var_1 waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_3, var_4);

    if(var_3 == "_encstr_A5EF0DF98DF99B2651677B6157FAED" || var_3 == "_encstr_88D00B37718B3BE3F7ED25D31C" || var_3 == "_encstr_81EC128DC6859BCDD75B95E657D76CD8ED6ECAC8") {
      enable_vehicle_interaction(var_2, "_encstr_BEC00FF820362DE7B7215A5FD8E1DFF3D3");
      break;
    }
  }

  var_0 notify("_encstr_83721B5A73E82BE4C2C6E82DED73AF1CEDA5B9D1AF465AB916C48DCAC8");
}

exit_change_loadout(var_0, var_1, var_2, var_3) {
  var_1 notify("_encstr_953C14590FA5A3F5C64358E6D9CAAFD8DE0B32BDBA8E");
}

enter_refill_ammo(var_0, var_1, var_2) {
  var_1 thread scripts\cp\cp_ammo_crate::supportbox_onusedeployable();
  waitframe();
  var_0 notify("_encstr_83721B5A73E82BE4C2C6E82DED73AF1CEDA5B9D1AF465AB916C48DCAC8");
  waitframe();
  var_0 makeusable();
  var_0.being_used = 0;
}

try_start_driving(var_0, var_1) {
  update_driver_interaction_hint(var_0);

  if(istrue(var_0.disabled)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A26B26B9A1712DE7CFEB13EE9BA70D6929485121F89DEFDF9F8F9E6DB807349D8111B9F140268195");
    return 0;
  }

  if(isDefined(level._id_13E02))
    return [[level._id_13E02]]();
  else
    return 1;
}

start_driver_role(var_0, var_1, var_2) {
  level notify("_encstr_A1851BAB3A10EABAC2A1E3C355C0F08031CF4CA33438B89AD18B0BB003");
  var_1.disable_map_tablet = 1;
  enter_vehicle(var_1, var_2);
  var_1.current_vehicle_seat = "_encstr_9AE307B956E345D0AB";
  var_1.start_anim_train_scene = 1;
  var_1 enter_seat_omnvar(var_1, "_encstr_9AE307B956E345D0AB");
  var_1 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 1);
  var_1 scripts\common\utility::allow_weapon(0);
  var_1 setplayerangles(var_2.angles);
  var_1 controlslinkTo(var_2);
  var_1 scripts\common\utility::allow_usability(0);
  var_2 setotherent(var_1);
  var_2 setentityowner(var_1);
  play_seat_animation(var_1, var_2, "_encstr_9AE307B956E345D0AB");
}

exit_driver_role(var_0, var_1, var_2, var_3) {
  var_2 setotherent(undefined);
  var_2 setentityowner(undefined);
  var_1.start_anim_train_scene = undefined;
  var_1 technical_stopanimatingplayer();
  var_1 scripts\common\utility::allow_weapon(1);
  var_1 controlsunlink();
  var_1 unlink();
  var_1 exit_vehicle(var_1, var_2, "_encstr_9AE307B956E345D0AB");
  var_1 exit_seat_omnvar(var_1, "_encstr_9AE307B956E345D0AB", var_2);
  var_1 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 0);
  var_1.disable_map_tablet = undefined;
  var_1 scripts\common\utility::allow_usability(1);
}

enter_repair(var_0, var_1, var_2) {
  var_3 = do_vehicle_repair_animation(var_2, var_1, var_0.repair_tag);

  if(!var_3) {
    var_0 makeusable();
    var_0.being_used = 0;
    return;
  }

  waitframe();
  var_0 notify("_encstr_83721B5A73E82BE4C2C6E82DED73AF1CEDA5B9D1AF465AB916C48DCAC8");
  remove_from_vehicle_repair_interaction_list(var_2, var_0, var_0.repair_tag);
}

exit_repair(var_0, var_1, var_2, var_3) {
  if(all_repairs_are_done(var_2)) {
    var_2.disabled = 0;
    set_repair_omnvars("_encstr_B4610CAA50F73F5F53A560694BBB", 0);
    update_driver_interaction_hint(var_2);
    level notify("_encstr_BD3C11CECA345A8DD8ACEBC9B283B0A5E49519");
  }
}

enter_retrieve_hostage(var_0, var_1, var_2) {
  waitframe();

  if(!isDefined(var_1.hostagecarried) && !has_hostage_on_board(var_2)) {
    return;
  }
  var_0 notify("_encstr_83721B5A73E82BE4C2C6E82DED73AF1CEDA5B9D1AF465AB916C48DCAC8");
}

exit_retrieve_hostage(var_0, var_1, var_2, var_3) {
  if(isPlayer(var_1) && !isDefined(var_1.hostagecarried) && !has_hostage_on_board(var_2)) {
    return;
  }
  if(!has_hostage_on_board(var_2)) {
    return;
  }
  var_4 = var_2.hostage;
  var_4 unlink();
  var_2.hostage = undefined;

  if(isPlayer(var_1))
    var_4 notify("_encstr_8F5C086405E70FBA4B4A", var_1);
  else {
    var_4.origin = var_1.origin;
    disable_vehicle_interaction(var_2, "_encstr_88FE111A736CFBB8871823FF0B605F3B922987");
    var_4.carried_by_vehicle = 0;
  }

  var_4 notify("_encstr_8F5C086405E70FBA4B4A", var_1);
}

enter_hood_repair(var_0, var_1, var_2) {
  var_2 thread _id_1421E(var_2);
  var_3 = do_hood_repair_animation(var_2, var_1, "_encstr_8AD00A6D0E22EFA13AE75850", var_0);
  var_2 notify("_encstr_A686150268301B599353D0C96328114B6B206A3B109DD3");

  if(!var_3) {
    var_0 makeusable();
    var_0.being_used = 0;
    return;
  }

  waitframe();
  var_0 notify("_encstr_83721B5A73E82BE4C2C6E82DED73AF1CEDA5B9D1AF465AB916C48DCAC8");
  remove_from_vehicle_repair_interaction_list(var_2, var_0);
}

_id_1421E(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A686150268301B599353D0C96328114B6B206A3B109DD3");
  var_1 = var_0.origin;
  var_2 = var_0.angles;

  for(;;) {
    var_0 vehicle_teleport(var_1, var_2);
    waitframe();
  }
}

exit_hood_repair(var_0, var_1, var_2, var_3) {
  if(all_repairs_are_done(var_2)) {
    var_2.disabled = 0;
    var_2.fake_health = var_2.max_fake_health;
    var_2.showing_damage_state = 0;
    var_2.disabled_due_to_damage = 0;
    set_repair_omnvars("_encstr_B4610CAA50F73F5F53A560694BBB", 0);
    update_driver_interaction_hint(var_2);
    level notify("_encstr_BD3C11CECA345A8DD8ACEBC9B283B0A5E49519");
  }
}

enter_passenger_seat(var_0, var_1, var_2) {
  enter_vehicle(var_1, var_2);
  enter_seat(var_1, var_2, "_encstr_8CF00A181FEBFB5B6A5FCD4E");
}

exit_passenger_seat(var_0, var_1, var_2, var_3) {
  exit_seat(var_1, 1);
  try_exit_vehicle(var_1, var_2, "_encstr_8CF00A181FEBFB5B6A5FCD4E");
}

enter_left_back_seat(var_0, var_1, var_2) {
  enter_vehicle(var_1, var_2);
  enter_seat(var_1, var_2, "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698");
}

exit_left_back_seat(var_0, var_1, var_2, var_3) {
  exit_seat(var_1, 1);
  try_exit_vehicle(var_1, var_2, "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698");
}

enter_right_back_seat(var_0, var_1, var_2) {
  enter_vehicle(var_1, var_2);
  enter_seat(var_1, var_2, "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B");
}

exit_right_back_seat(var_0, var_1, var_2, var_3) {
  exit_seat(var_1, 1);
  try_exit_vehicle(var_1, var_2, "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B");
}

enter_gunner_seat(var_0, var_1, var_2) {
  level notify("_encstr_819B22603921EF5FE501A3DBC811191B1993F1EB41C92FE7C3601AB2580F8BAF13064574");
  var_1 unlink();
  var_1 setworldupreference(undefined);
  var_1.disable_map_tablet = 1;
  scripts\cp\coop_super::little_bird_mg_init(var_1);
  exit_seat_but_stay_in_vehicle(var_1, var_2);
  record_seat(var_1, "_encstr_8D48079DD59BE65627");
  var_1 enter_seat_omnvar(var_1, "_encstr_8D48079DD59BE65627");
  var_1 setplayerangles(var_2.gunner_turret.angles);
  var_1 thread give_gunner_turret(var_0, var_1, var_2);
  var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", 10);
}

give_gunner_turret(var_0, var_1, var_2) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_A1A011D7B343D3C77108130B908B8FEB23471B");
  var_1.pre_gunner_weapon = var_1 getcurrentweapon();
  var_1 scripts\cp\utility::_giveweapon(var_2.gunner_weapon, undefined, undefined, 1);

  while(var_1 scripts\cp\cp_weapons::switchtoweaponreliable(var_2.gunner_weapon, 1) == 0)
    waitframe();

  var_2.gunner_turret setotherent(var_1);
  var_2.gunner_turret setentityowner(var_1);
  var_2.gunner_turret setsentryowner(var_1);
  var_2.gunner_turret.owner = var_1;
  var_1 disableturretdismount();
  var_1 controlturreton(var_2.gunner_turret);
}

exit_gunner_seat(var_0, var_1, var_2, var_3) {
  var_1 notify("_encstr_A1A011D7B343D3C77108130B908B8FEB23471B");
  var_1 takeweapon(var_2.gunner_weapon);
  var_1 switchtoweapon(var_1.pre_gunner_weapon);
  var_1 enableturretdismount();
  var_1 controlturretoff(var_2.gunner_turret);
  var_1 unlink();
  var_2.gunner_turret setotherent(undefined);
  var_2.gunner_turret setentityowner(undefined);
  var_2.gunner_turret setsentryowner(undefined);
  enable_vehicle_interaction(var_2, "_encstr_8D48079DD59BE65627");
  var_1.disable_map_tablet = undefined;
  scripts\cp\coop_super::mousetraps(var_1);

  if(var_3 == "_encstr_8CBE0BD1BED30936AB03C0B02B" || var_3 == "_encstr_A7951A99DE93C656EBE0C60BBC2B39BE953CA51DF5CEB2D096C663CA") {
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
    var_1 exit_seat_omnvar(var_1, "_encstr_8D48079DD59BE65627", var_2);
  } else {
    return_to_previous_seat(var_1, var_2);
    var_1 exit_seat_omnvar(var_1, "_encstr_8D48079DD59BE65627", var_2);
  }
}

enter_grenadier_seat(var_0, var_1, var_2) {
  var_1 unlink();
  var_1 setworldupreference(undefined);
  var_1.disable_map_tablet = 1;
  exit_seat_but_stay_in_vehicle(var_1, var_2);
  waitframe();
  record_seat(var_1, "_encstr_AC480A070831CEB2611BEF22");
  var_1 enter_seat_omnvar(var_1, "_encstr_AC480A070831CEB2611BEF22");
  var_1 setplayerangles(var_2.angles);
  var_1 playerlinktodelta(var_2.grenadier_anchor, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 0, 180, 180, 180, 25);
  var_1 thread give_grenadier_launcher(var_0, var_1, var_2);
  var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", 10);
}

give_grenadier_launcher(var_0, var_1, var_2) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_86EF1437512BDBC7A8C3DFE5594809027E87E78FCBCD");
  var_1.pre_gunner_weapon = var_1 getcurrentweapon();
  var_1 scripts\cp\utility::_giveweapon(var_2.grenadier_weapon, undefined, undefined, 1);

  while(var_1 scripts\cp\cp_weapons::switchtoweaponreliable(var_2.grenadier_weapon, 1) == 0)
    waitframe();
}

exit_grenadier_seat(var_0, var_1, var_2, var_3) {
  var_1 notify("_encstr_86EF1437512BDBC7A8C3DFE5594809027E87E78FCBCD");
  var_1 takeweapon(var_2.grenadier_weapon);
  var_1 switchtoweapon(var_1.pre_gunner_weapon);
  var_1 unlink();
  enable_vehicle_interaction(var_2, "_encstr_AC480A070831CEB2611BEF22");
  var_1.disable_map_tablet = undefined;

  if(var_3 == "_encstr_8CBE0BD1BED30936AB03C0B02B" || var_3 == "_encstr_A7951A99DE93C656EBE0C60BBC2B39BE953CA51DF5CEB2D096C663CA") {
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
    var_1 exit_seat_omnvar(var_1, "_encstr_AC480A070831CEB2611BEF22", var_2);
  } else {
    return_to_previous_seat(var_1, var_2);
    var_1 exit_seat_omnvar(var_1, "_encstr_AC480A070831CEB2611BEF22", var_2);
  }
}

_id_11D06(var_0, var_1, var_2) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_1 notify("_encstr_A9A317B97FAB38F1C503D118BB1CB9B6CF1633ADC13F432BEF");
  var_1 endon("_encstr_A9A317B97FAB38F1C503D118BB1CB9B6CF1633ADC13F432BEF");
  var_3 = gettime() + 1000;
  var_4 = 0;
  var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", 0);
  var_5 = level.framedurationseconds;
  waitframe();

  for(;;) {
    var_6 = 0;
    var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", 0);

    while(var_1 stancebuttonPressed()) {
      var_6 = var_6 + var_5;

      if(var_1 usinggamepad())
        var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", var_6 / 0.3);

      if(var_1 usinggamepad() && var_6 > 0.3 || istrue(var_2) || !var_1 usinggamepad()) {
        var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", 0);
        return 1;
      }

      wait(var_5);
    }

    waitframe();
  }
}

_id_11D05(var_0, var_1, var_2) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_1 notify("_encstr_A9A317B97FAB38F1C503D118BB1CB9B6CF1633ADC13F432BEF");
  var_1 endon("_encstr_A9A317B97FAB38F1C503D118BB1CB9B6CF1633ADC13F432BEF");
  var_3 = gettime() + 1000;
  var_4 = 0;
  var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", 0);
  var_5 = level.framedurationseconds;
  waitframe();

  for(;;) {
    var_6 = 0;
    var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", 0);

    while(var_1 useButtonPressed()) {
      var_6 = var_6 + var_5;

      if(var_1 usinggamepad())
        var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", var_6 / 0.3);

      if(var_1 usinggamepad() && var_6 > 0.3 || istrue(var_2) || !var_1 usinggamepad()) {
        var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", 0);
        return 1;
      }

      wait(var_5);
    }

    waitframe();
  }
}

enter_mine_drone_right(var_0, var_1, var_2) {
  var_0 = get_vehicle_interaction_point(var_2, "_encstr_A9EC1055334A5117D432C7EDCDEF68ADC143");
  var_0 makeunusable();
  var_0.being_used = 1;
  enter_mine_drone(var_0, var_1, var_2, "_encstr_8D7811F837FE2137C2E2C0583FA9B5685F8BB8");
}

enter_mine_drone_left(var_0, var_1, var_2) {
  var_0 = get_vehicle_interaction_point(var_2, "_encstr_8D7811F837FE2137C2E2C0583FA9B5685F8BB8");
  var_0 makeunusable();
  var_0.being_used = 1;
  enter_mine_drone(var_0, var_1, var_2, "_encstr_A9EC1055334A5117D432C7EDCDEF68ADC143");
}

enter_mine_drone(var_0, var_1, var_2, var_3) {
  level notify("_encstr_8ABE1FDB88A373C550C110B3CD0A119B8D8B8B66986FE8E2C8A5B7611C83985E05");
  var_1 notify("_encstr_A51711EF8051EAB22EA07763C8069C23CF2877");
  var_1.outofrangefunc = ::mine_drone_out_of_range;
  var_1.disable_map_tablet = 1;
  var_1 setplayerangles(var_2.angles);
  var_1 show_fake_player(var_1, var_2);
  exit_seat_but_stay_on_seat(var_1);
  record_seat(var_1, var_3);
  var_1 scripts\common\utility::allow_weapon(0);
  var_1 remove_from_players_cannot_see_vehicle_icon_list(var_2, var_1);
  var_1 update_vehicle_objective_visibility(var_2);
  var_1 animscriptexitvehicle();
  var_1 thread unlink_and_travel_with_vehicle(var_1, var_2);
  var_1 thread scripts\cp\drone\scout_drone::deploy_scout_detonate_drone(var_1);
  var_1.drone scripts\cp_mp\outofrange::setupoutofrangewatcher(var_1.drone, undefined, var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 2560000, 5760000);
  var_1.drone thread drone_killed_due_to_out_of_range_monitor(var_1.drone, var_1);
}

show_fake_player(var_0, var_1) {
  if(var_0.current_vehicle_seat == "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B")
    var_1.fake_back_right_passenger show();
  else if(var_0.current_vehicle_seat == "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698")
    var_1.fake_back_left_passenger show();
}

mine_drone_out_of_range(var_0) {
  var_1 = 10;

  if(!isDefined(var_0.next_mine_drone_out_of_range_vo_time))
    var_0.next_mine_drone_out_of_range_vo_time = 0;

  var_2 = gettime();

  if(var_2 > var_0.next_mine_drone_out_of_range_vo_time) {
    var_0.next_mine_drone_out_of_range_vo_time = var_2 + var_1 * 1000;
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("_encstr_8DD523A431391E0B763E2A836058DB5758FB5B249391A5479D56228AEE26BFCD485BEFE191", "_encstr_99140ED629C9C62FA399EFB01B5F748F", "_encstr_B23608E248D4CB37E891", 10, 0, 0, 1, 100);
  }
}

unlink_and_travel_with_vehicle(var_0, var_1) {
  var_0 endon("_encstr_B80910D79858A80105B4FE12F101C5F76343");
  var_0 endon("_encstr_88D00E3B7B9B3CA095EFB8551AAA05C9");
  var_0 waittill("_encstr_86090DC9722588458FBAEAF0E31B06");
  var_0 unlink();
  var_0 playerhide();
  var_2 = var_0.origin;
  var_3 = var_0.origin;

  for(;;) {
    var_2 = get_player_seat_org(var_0, var_1);

    if(var_2 != var_3) {
      var_0 setOrigin(var_2);
      var_3 = var_2;
    }

    waitframe();
  }
}

get_player_seat_org(var_0, var_1) {
  switch (var_0.current_vehicle_seat) {
    case "_encstr_A9EC1055334A5117D432C7EDCDEF68ADC143":
      return var_1 gettagorigin("_encstr_A30D0B30D3708180E951D37165");
    case "_encstr_8D7811F837FE2137C2E2C0583FA9B5685F8BB8":
      return var_1 gettagorigin("_encstr_930D0BB31F7F41CB11C81BAF42");
  }
}

drone_killed_due_to_out_of_range_monitor(var_0, var_1) {
  var_0 waittill("_encstr_AD75063D571AE108");
  var_1 notify("_encstr_92E51669D8A16860027F3D238FBA3E684E77D6030417C0AD");
  var_1 notify("_encstr_9AC2152B87D2D1FADA96B92BEB4693F6B92BF51B56CC47");
}

exit_mine_drone(var_0, var_1, var_2, var_3) {
  var_1 notify("_encstr_B80910D79858A80105B4FE12F101C5F76343");

  if(isDefined(var_1.drone))
    var_1.drone dodamage(var_1.drone.fake_health + 100, var_1.drone.origin);

  var_1.outofrangefunc = undefined;
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", undefined, var_1, 0.05, "_encstr_AC6D0770ABB619D877");
  var_1 setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
  var_1 scripts\common\utility::allow_weapon(1);
  enable_vehicle_interaction(var_2, "_encstr_8D7811F837FE2137C2E2C0583FA9B5685F8BB8");
  enable_vehicle_interaction(var_2, "_encstr_A9EC1055334A5117D432C7EDCDEF68ADC143");
  var_1 add_to_players_cannot_see_vehicle_icon_list(var_2, var_1);
  var_1 update_vehicle_objective_visibility(var_2);
  var_2.fake_back_right_passenger hide();
  var_2.fake_back_left_passenger hide();
  var_1 playershow();
  var_1.disable_map_tablet = undefined;

  if(var_3 == "_encstr_8CBE0BD1BED30936AB03C0B02B") {
    var_1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
  } else {
    var_1 animscriptentervehicle();
    return_to_previous_seat(var_1, var_2);
  }
}

enter_missile_defense_right(var_0, var_1, var_2) {
  var_0 = get_vehicle_interaction_point(var_2, "_encstr_B4AC15DDA818F3EA41BB17F3937C1256B0B1D9E541E8BC");
  var_0 makeunusable();
  var_0.being_used = 1;
  enter_missile_defense(var_0, var_1, var_2, "_encstr_ADF31660AF7B6BD33AAF40D587B20370C3376910D70740D1");
}

enter_missile_defense_left(var_0, var_1, var_2) {
  var_0 = get_vehicle_interaction_point(var_2, "_encstr_ADF31660AF7B6BD33AAF40D587B20370C3376910D70740D1");
  var_0 makeunusable();
  var_0.being_used = 1;
  enter_missile_defense(var_0, var_1, var_2, "_encstr_B4AC15DDA818F3EA41BB17F3937C1256B0B1D9E541E8BC");
}

enter_missile_defense(var_0, var_1, var_2, var_3) {
  var_1 notify("_encstr_8D881689D00BF7101711F8F8534B1BC94F53BDB9A76013C7");
  var_1.disable_map_tablet = 1;
  var_1.target_circle_fov = 35;
  var_1.target_circle_radius = 20;
  exit_seat_but_stay_on_seat(var_1);
  record_seat(var_1, var_3);
  var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", -1);
  var_1 setclientomnvar("_encstr_841A12AEB4AFDBB3B239DDB03A1B86BE9DD256DD", 2);
  var_1 setclientomnvar("_encstr_82EC1095EBB80302F8474BBD056859301BAF", 0);
  var_1 enter_missile_defense_view(var_1, var_2);
  var_1 mark_vehicle_as_friendly_target_group(var_1, var_2);
  var_1 give_missile_defense_weapons(var_1);
  var_1 see_icon_on_cruise_missiles(var_1);
  var_1 see_icon_on_interceptor_missiles(var_1);
  var_1 thread enter_missile_defense_control(var_1, var_2);
  var_1 thread enter_missile_defense_vision_set(var_1);
}

enter_missile_defense_control(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_960B159810824D0908E25B3633E8EB67656DDA45508B48");
  var_0 thread missile_defense_lock_on_cruise_missile_think(var_0, var_1);
  var_0 thread missile_defense_fire_interceptor_missiles(var_0, var_1);
  var_0 thread missile_defense_camera_focus_think(var_0, var_1);
}

missile_defense_camera_focus_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_960B159810824D0908E25B3633E8EB67656DDA45508B48");
  var_1 endon("_encstr_8F0607E89A9639D85A");
  var_0 notifyonplayercommand("_encstr_84F21D73F06BDD6BF628AB06A373D8B2E80B1A36F7D592229747EFC16F93F1", "_encstr_A6E60A229B175A3B48A543AB");

  for(;;) {
    var_0 waittill("_encstr_84F21D73F06BDD6BF628AB06A373D8B2E80B1A36F7D592229747EFC16F93F1");
    var_0 setplayerangles(vectortoangles(var_1.origin - var_1.reaper.missile_defense_camera_anchor.origin));
  }
}

missile_defense_fire_interceptor_missiles(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_960B159810824D0908E25B3633E8EB67656DDA45508B48");
  var_1 endon("_encstr_8F0607E89A9639D85A");
  var_0 notifyonplayercommand("_encstr_A99B195401A3C1CF2C9A20A0B34663BB13BFE6406DB74BDF14A250", "_encstr_A9E60828803C73F11780");

  for(;;) {
    var_0 waittill("_encstr_A99B195401A3C1CF2C9A20A0B34663BB13BFE6406DB74BDF14A250");
    var_2 = get_locked_on_cruise_missile_to_intercept();

    if(isDefined(var_2))
      fire_interceptor_missile_toward(var_2, var_0, var_1);
  }
}

get_locked_on_cruise_missile_to_intercept() {
  if(!isDefined(level.locked_on_cruise_missiles))
    return undefined;

  var_0 = [];

  foreach(var_2 in level.locked_on_cruise_missiles) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(istrue(var_2.being_intercepted)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return sortbydistance(var_0, level.player_humvee.origin)[0];
}

fire_interceptor_missile_toward(var_0, var_1, var_2) {
  var_3 = 3;
  var_0.being_intercepted = 1;
  var_4 = anglestoleft(var_1 getplayerangles());
  var_5 = var_2.reaper.missile_defense_camera_anchor.origin + var_4 * var_3;
  var_6 = magicbullet("_encstr_BDA01797D0CB05BDF2D5C093DF5841383B5327E148DF3FE84A", var_5, var_0.origin);
  var_6.target_anchor = make_interceptor_missile_target_anchor(var_6);
  var_6 missile_settargetEnt(var_6.target_anchor);
  var_6 missile_setflightmodedirect();
  var_6 setscriptablepartstate("_encstr_9601091D1A39AE373A564E", "_encstr_AB0703DBB9", 0);
  set_interceptor_missile_target(var_6, var_0);
  var_6 thread hit_target_entity_monitor(var_6);
  var_6 thread get_away_from_target_entity_monitor(var_6);

  if(!isDefined(level.interceptor_missiles))
    level.interceptor_missiles = [];

  level.interceptor_missiles[level.interceptor_missiles.size] = var_6;
  var_0.interceptor_missile = var_6;
  put_objective_icon_on_interceptor_missile(var_6);
  var_6 thread interceptor_missile_death_monitor(var_6, var_6.interceptor_missile_objective_id, var_6 getentitynumber());
  update_missile_lock_hud_for_missile_defense_player();
}

put_objective_icon_on_interceptor_missile(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_A38323D2CD8E2B9CD8B21C8EDB9CFA5B5ADCB9D2C656EBB2DC474BE8BCFADCAB6B895639D7" + var_0 getentitynumber(), 22);
  objective_state(var_1, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_icon(var_1, "_encstr_924010A1057791D6E79AD823D2A718D98E6F");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 0);
  objective_removeallfrommask(var_1);
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_setshowdistance(var_1, 1);
  objective_setshowprogress(var_1, 1);
  objective_setfadedisabled(var_1, 1);
  var_0.interceptor_missile_objective_id = var_1;
  make_visible_to_missile_defense_player(var_1);
}

get_away_from_target_entity_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread start_chasing_target_entity_think(var_0);
  var_0 waittill("_encstr_B4291C17B5467AC9398E110F1FDFC5570FE4104BCFD109AF62568B12611F");
  var_1 = distancesquared(var_0.origin, var_0.target_entity.origin);

  for(;;) {
    waitframe();

    if(isDefined(var_0.target_entity) && isDefined(var_0.target_entity.origin)) {
      var_2 = distancesquared(var_0.origin, var_0.target_entity.origin);

      if(var_2 < var_1)
        var_1 = var_2;
      else {
        interceptor_missile_explodes_with_target(var_0);
        return;
      }
    }
  }
}

start_chasing_target_entity_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(isDefined(var_0.target_entity) && isDefined(var_0.target_entity.angles)) {
      var_1 = anglesToForward(var_0.angles);
      var_2 = anglesToForward(var_0.target_entity.angles);

      if(vectordot(var_2, var_1) > 0) {
        var_0 notify("_encstr_B4291C17B5467AC9398E110F1FDFC5570FE4104BCFD109AF62568B12611F");
        return;
      }
    }

    waitframe();
  }
}

hit_target_entity_monitor(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(isDefined(var_0.target_entity) && isDefined(var_0.target_entity.origin)) {
      if(distancesquared(var_0.origin, var_0.target_entity.origin) <= 22500)
        interceptor_missile_explodes_with_target(var_0);
    }

    waitframe();
  }
}

interceptor_missile_explodes_with_target(var_0) {
  playFX(scripts\engine\utility::getfx("_encstr_8A0E1883388BB7FD51FA4B93E83B9664218331B23F12515DDA63"), var_0.target_entity.origin);
  playsoundatpos(var_0.target_entity.origin, "_encstr_8432170BB7222E0F52839078BA21DB20D75B83713D17D161BA");
  var_0.target_entity delete();
  var_0 delete();
}

interceptor_missile_death_monitor(var_0, var_1, var_2) {
  var_0 waittill("_encstr_AD75063D571AE108");
  level.interceptor_missiles = scripts\engine\utility::array_remove(level.interceptor_missiles, var_0);
  scripts\cp\cp_objectives::freeworldid("_encstr_A38323D2CD8E2B9CD8B21C8EDB9CFA5B5ADCB9D2C656EBB2DC474BE8BCFADCAB6B895639D7" + var_2);
  objective_delete(var_1);
}

make_interceptor_missile_target_anchor(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 thread missile_anchor_clean_up_think(var_1, var_0);
  return var_1;
}

missile_anchor_clean_up_think(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

missile_defense_lock_on_cruise_missile_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_960B159810824D0908E25B3633E8EB67656DDA45508B48");
  var_1 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(isDefined(level.cruise_missiles)) {
      foreach(var_3 in level.cruise_missiles) {
        if(var_0 worldpointinreticle_circle(var_3.origin, var_0.target_circle_fov, var_0.target_circle_radius))
          var_3.lock_on_progress = var_3.lock_on_progress + 0.05;

        if(var_3.lock_on_progress >= 0.5)
          mark_cruise_missile_as_locked_on(var_3, var_0, var_1);
      }
    }

    waitframe();
  }
}

mark_cruise_missile_as_locked_on(var_0, var_1, var_2) {
  if(!isDefined(level.locked_on_cruise_missiles))
    level.locked_on_cruise_missiles = [];

  if(!scripts\engine\utility::array_contains(level.locked_on_cruise_missiles, var_0)) {
    objective_icon(var_0.cruise_missile_objective_id, "_encstr_8A6F1834EA46BE8DC28D639B4BD99BBE4CECBE9346F533D58DC6");
    var_2.reaper.missile_defense_camera_anchor playsoundtoplayer("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E", var_1);
    level.locked_on_cruise_missiles = scripts\engine\utility::array_add(level.locked_on_cruise_missiles, var_0);
    var_1 setclientomnvar("_encstr_82EC1095EBB80302F8474BBD056859301BAF", 1);
  }
}

enter_missile_defense_vision_set(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_960B159810824D0908E25B3633E8EB67656DDA45508B48");
  overwatch_screen_transition(var_0);
  wait 0.25;
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", "_encstr_882F130BD84CCC60D78DB78DDB9CEBEC1BA5D11B86", var_0, 0.25);
  wait 0.25;
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", "_encstr_AF500C2C1B136660BE8D7BC6F627", var_0, 0);
}

give_missile_defense_weapons(var_0) {
  var_0 scripts\cp\utility::_giveweapon("_encstr_85BC0F7A700BAAA2B6CF607D899857C6F1");
  var_0 scripts\cp\cp_weapons::_switchtoweaponimmediate("_encstr_85BC0F7A700BAAA2B6CF607D899857C6F1");
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0.pre_missile_defense_weapon = var_0 getcurrentweapon();
}

enter_missile_defense_view(var_0, var_1) {
  var_0 playerlinkweaponviewtodelta(var_1.reaper.missile_defense_camera_anchor, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 180, 180, 90, 80, 0);
  var_0 playerlinkedsetviewznear(0);
  var_2 = anglesToForward(var_1.angles);
  var_2 = var_2 * (1, 1, 0);
  var_0 setplayerangles(vectortoangles(var_2));
}

exit_missile_defense(var_0, var_1, var_2, var_3) {
  var_1 notify("_encstr_960B159810824D0908E25B3633E8EB67656DDA45508B48");
  var_1 thread exit_missile_defense_vision_set(var_1);
  var_1 setclientomnvar("_encstr_841A12AEB4AFDBB3B239DDB03A1B86BE9DD256DD", 0);
  var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", 10);
  enable_vehicle_interaction(var_2, "_encstr_B4AC15DDA818F3EA41BB17F3937C1256B0B1D9E541E8BC");
  enable_vehicle_interaction(var_2, "_encstr_ADF31660AF7B6BD33AAF40D587B20370C3376910D70740D1");
  var_1.disable_map_tablet = undefined;
  var_1 exit_missile_defense_view(var_1);
  var_1 unmark_vehicle_as_friendly_target_group(var_1);
  var_1 remove_missile_defense_weapons(var_1);
  var_1 clear_icon_on_cruise_missiles(var_1);
  var_1 clear_icon_on_interceptor_missiles(var_1);

  if(var_3 == "_encstr_8CBE0BD1BED30936AB03C0B02B") {
    var_1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
  } else {
    var_1 animscriptentervehicle();
    return_to_previous_seat(var_1, var_2);
  }
}

clear_icon_on_cruise_missiles(var_0) {
  if(isDefined(level.cruise_missiles)) {
    foreach(var_2 in level.cruise_missiles)
    objective_removeclientfrommask(var_2.cruise_missile_objective_id, var_0);
  }
}

clear_icon_on_interceptor_missiles(var_0) {
  if(isDefined(level.interceptor_missiles)) {
    foreach(var_2 in level.interceptor_missiles) {
      if(isDefined(var_2))
        objective_removeclientfrommask(var_2.interceptor_missile_objective_id, var_0);
    }
  }
}

remove_missile_defense_weapons(var_0) {
  var_0 scripts\cp\cp_weapons::_takeweapon("_encstr_85BC0F7A700BAAA2B6CF607D899857C6F1");
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0 switchtoweaponimmediate(var_0.pre_missile_defense_weapon);
}

exit_missile_defense_view(var_0) {
  var_0 cameraunlink();
}

exit_missile_defense_vision_set(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8D881689D00BF7101711F8F8534B1BC94F53BDB9A76013C7");
  overwatch_screen_transition(var_0);
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", undefined, var_0, 0, "_encstr_AF500C2C1B136660BE8D7BC6F627");
  waitframe();
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", undefined, var_0, 0, "_encstr_882F130BD84CCC60D78DB78DDB9CEBEC1BA5D11B86");
}

enter_reaper_right(var_0, var_1, var_2) {
  enter_reaper(var_0, var_1, var_2, "_encstr_838910DD3CC32B6739B8AF8BC9732122B155");
  disable_vehicle_interaction(var_2, "_encstr_9BA00F277525B3E7800BA66C86633D2A05");
}

enter_reaper_left(var_0, var_1, var_2) {
  enter_reaper(var_0, var_1, var_2, "_encstr_9BA00F277525B3E7800BA66C86633D2A05");
  disable_vehicle_interaction(var_2, "_encstr_838910DD3CC32B6739B8AF8BC9732122B155");
}

enter_reaper(var_0, var_1, var_2, var_3) {
  var_1 notify("_encstr_AA43104AD025B7BAD1EF4E25ADE806BBC688");
  var_1.disable_map_tablet = 1;
  exit_seat_but_stay_on_seat(var_1);
  record_seat(var_1, var_3);
  var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", -1);
  var_1 setclientomnvar("_encstr_841A12AEB4AFDBB3B239DDB03A1B86BE9DD256DD", 1);
  var_1 show_ied_zone_to_player(var_1);
  var_1 update_enemy_visualization_for_entering_reaper(var_1);
  var_1 delete_non_overwatch_ied_marker_vfx_for_player(var_1);
  var_1 enter_reaper_view(var_1, var_2);
  var_1 make_camera_point(var_1, var_2);
  var_1 mark_vehicle_as_friendly_target_group(var_1, var_2);
  var_1 give_reaper_weapons(var_1);
  var_1 thread enter_reaper_control(var_1, var_2);
  var_1 thread enter_overwatch_vision_set(var_1);
  var_1 thread target_in_red_circle_think(var_1, ::reaper_get_target_in_circle_omnvar_value);
  var_1 thread reaper_radar_control(var_1, var_2);
}

see_icon_on_cruise_missiles(var_0) {
  if(isDefined(level.cruise_missiles)) {
    foreach(var_2 in level.cruise_missiles)
    objective_addclienttomask(var_2.cruise_missile_objective_id, var_0);
  }
}

see_icon_on_interceptor_missiles(var_0) {
  if(isDefined(level.interceptor_missiles)) {
    foreach(var_2 in level.interceptor_missiles)
    objective_addclienttomask(var_2.interceptor_missile_objective_id, var_0);
  }
}

play_cloud_vfx(var_0, var_1) {
  playfxontagforclients(scripts\engine\utility::getfx("_encstr_A2630EB65AC209DA83AF7A1DA0B3AA18"), var_1.reaper.missile_defense_camera_anchor, "_encstr_8E010B996FB7B6B3C1D1183343", var_0);
}

enter_reaper_control(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_0 thread reaper_camera_zoom_think(var_0, var_1);
  var_0 thread reaper_camera_reset_think(var_0, var_1);
  var_0 thread reaper_fire_missile_think(var_0, var_1);
}

reaper_fire_missile_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_1 endon("_encstr_AD75063D571AE108");

  if(_id_12A4D())
    _id_12A4C(var_0);

  var_0 notifyonplayercommand("_encstr_855F14C99585E0AC9C7D662D3995BEB6966EDCD21B59", "_encstr_A9E60828803C73F11780");
  var_2 = 2;
  var_0 setclientomnvar("_encstr_88B61CBA5AEB6D968DB1DC8E27AC2CB6FABB950BC1B7CDAF8CF5586BDABD", var_2);

  for(;;) {
    var_0 waittill("_encstr_855F14C99585E0AC9C7D662D3995BEB6966EDCD21B59");
    var_3 = fire_reaper_missile(var_0, var_1);
    var_2 = var_2 - 1;
    var_0 setclientomnvar("_encstr_88B61CBA5AEB6D968DB1DC8E27AC2CB6FABB950BC1B7CDAF8CF5586BDABD", var_2);

    if(var_2 == 0) {
      var_0 reaper_waitforweaponreloadtime(var_0);
      var_2 = 2;
      var_0 setclientomnvar("_encstr_88B61CBA5AEB6D968DB1DC8E27AC2CB6FABB950BC1B7CDAF8CF5586BDABD", var_2);
    }
  }
}

fire_reaper_missile(var_0, var_1) {
  var_2 = 3;
  var_3 = make_reaper_missile_target_ent(var_0, var_1);
  var_4 = anglestoleft(var_0 getplayerangles());
  var_5 = var_1.reaper.missile_defense_camera_anchor.origin + var_4 * var_2;
  var_6 = magicbullet("_encstr_A2DC15EDEC9539DD8547D81AAFADA5E69BD236B2D7D81C", var_5, var_3.origin, var_0);
  var_6 missile_settargetEnt(var_3);
  var_6 missile_setflightmodedirect();
  var_6 setscriptablepartstate("_encstr_9601091D1A39AE373A564E", "_encstr_AB0703DBB9", 0);
  var_3 thread clean_up_monitor(var_3, var_6);
  return var_6;
}

reaper_waitforweaponreloadtime(var_0) {
  var_1 = 4;
  level._id_12A4B = gettime() + int(var_1 * 1000);
  var_0 setclientomnvar("_encstr_87BF19F55379DE0717F39F512BAF7795210D9D64C7202783D3D0C2", level._id_12A4B);

  for(;;) {
    wait 0.05;
    var_1 = var_1 - 0.05;

    if(var_1 <= 0) {
      break;
    }
  }
}

_id_12A4D() {
  return isDefined(level._id_12A4B) && level._id_12A4B > gettime();
}

_id_12A4C(var_0) {
  var_1 = gettime();
  var_2 = level._id_12A4B - var_1;
  var_3 = var_2 / 1000;
  var_0 setclientomnvar("_encstr_87BF19F55379DE0717F39F512BAF7795210D9D64C7202783D3D0C2", level._id_12A4B);
  wait(var_3);
}

clean_up_monitor(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

make_reaper_missile_target_ent(var_0, var_1) {
  var_2 = get_reaper_player_look_at_ground_pos(var_0, var_1);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 thread _id_123FC(var_3, var_0);
  put_objective_icon_on_reaper_missile_target_ent(var_3, var_0);
  var_3 thread follow_player_look_at(var_3, var_0, var_1);
  return var_3;
}

_id_123FC(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  waitframe();
  playfxontagforclients(level._effect["_encstr_AA0116484FB9DB1BEB11090372934B8DE50F08588B5BB1ED"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_1);
}

put_objective_icon_on_reaper_missile_target_ent(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::requestworldid("_encstr_917F1A2E7D9F13EBBAD9587073928BE8E7DFB52FC25F7901294258E0" + var_0 getentitynumber(), 22);
  objective_state(var_2, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_icon(var_2, "_encstr_A7D11DD4751921B713C8232FF08B739A97811C8ADEAB4AC55E68673328813C");
  objective_onentity(var_2, var_0);
  objective_setzoffset(var_2, 0);
  objective_removeallfrommask(var_2);
  objective_setplayintro(var_2, 0);
  objective_setplayoutro(var_2, 0);
  objective_setbackground(var_2, 1);
  objective_setshowdistance(var_2, 0);
  objective_setshowprogress(var_2, 1);
  objective_setfadedisabled(var_2, 1);
  objective_addclienttomask(var_2, var_1);
  var_0 thread reaper_missile_target_ent_objective_clean_up_think(var_0, var_2, var_0 getentitynumber());
}

reaper_missile_target_ent_objective_clean_up_think(var_0, var_1, var_2) {
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\cp\cp_objectives::freeworldid("_encstr_917F1A2E7D9F13EBBAD9587073928BE8E7DFB52FC25F7901294258E0" + var_2);
  objective_delete(var_1);
}

follow_player_look_at(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_1 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");

  for(;;) {
    waitframe();
    var_0.origin = get_reaper_player_look_at_ground_pos(var_1, var_2);
  }
}

reaper_radar_control(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_0 notifyonplayercommand("_encstr_8C0514DEB3CA39DDC23A8D34AFE40B19584EBE38A5DC", "_encstr_97120D65B983599519EB1D86C9B7EE");

  for(;;) {
    var_0 waittill("_encstr_8C0514DEB3CA39DDC23A8D34AFE40B19584EBE38A5DC");
    var_0.overwatch_camera_point playsoundtoplayer("_encstr_A1FF13932B0B0EB2C9AFCDB18573EBA358393B5947", var_0);
    var_2 = get_reaper_player_look_at_ground_pos(var_0, var_1);
    waitframe();
    level thread show_unidentified_ied_within_target_circle(var_0, var_2);
    level thread show_ai_within_target_circle(var_0, var_2);
    wait 1;
  }
}

get_reaper_player_look_at_ground_pos(var_0, var_1) {
  var_2 = anglesToForward(var_0 getplayerangles());
  var_3 = var_1.reaper.scanning_camera_anchor.origin + var_2 * 50;
  var_4 = var_1.reaper.scanning_camera_anchor.origin + var_2 * 30000;
  var_5 = scripts\engine\trace::ray_trace_detail(var_3, var_4, var_1.reaper);
  var_6 = var_5["_encstr_BD260953AA97E3F014279D"];
  return var_6;
}

show_unidentified_ied_within_target_circle(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_2 = [];

  foreach(var_4 in level.unidentified_ieds) {
    if(istrue(var_4.in_reaper_target_circle))
      var_2[var_2.size] = var_4;
  }

  var_6 = sortbydistance(var_2, var_1);

  foreach(var_8 in var_6) {
    var_0.overwatch_camera_point playsoundtoplayer("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E", var_0);
    mark_ied_as_identified(var_0, var_8);
    wait(randomfloatrange(0.05, 0.1));
  }
}

show_ai_within_target_circle(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_2 = [];

  foreach(var_4 in level.agentarray) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!isalive(var_4)) {
      continue;
    }
    if(istrue(var_4.marked_by_overwatch_scan)) {
      continue;
    }
    if(var_4.team == "_encstr_9A8507BA4040188D08") {
      continue;
    }
    if(istrue(var_4.in_reaper_target_circle))
      var_2[var_2.size] = var_4;
  }

  var_6 = sortbydistance(var_2, var_1);

  foreach(var_4 in var_6) {
    var_0.overwatch_camera_point playsoundtoplayer("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E", var_0);
    var_4.marked_by_overwatch_scan = 1;
    add_ai_to_marked_enemy_ai_list(var_4);
    outline_enemy_ai_for_overwatch(var_4, var_0);

    if(istrue(var_4.is_critical_ai_target)) {
      add_ai_to_marked_critical_enemy_ai_list(var_4);
      put_target_marker_on_critical_enemy_ai(var_4, var_0);
      make_critical_target_icon_on_ai(var_4);

      foreach(var_9 in level.players) {
        if(var_9 == var_0) {
          continue;
        }
        show_critical_target_icon_to_player(var_4, var_9);
      }
    }

    wait(randomfloatrange(0.05, 0.1));
  }
}

reaper_get_target_in_circle_omnvar_value(var_0) {
  if(player_in_intercept_mode(var_0))
    return intercept_mode_get_target_in_circle_omnvar_value(var_0);
  else
    return scanning_mode_get_target_in_circle_omnvar_value(var_0);
}

player_in_intercept_mode(var_0) {
  return var_0.current_reaper_camera_zoom_level == 3;
}

intercept_mode_get_target_in_circle_omnvar_value(var_0) {
  foreach(var_2 in level.unidentified_ieds)
  var_2.in_reaper_target_circle = undefined;

  foreach(var_5 in level.agentarray)
  var_5.in_reaper_target_circle = undefined;

  return 0;
}

scanning_mode_get_target_in_circle_omnvar_value(var_0) {
  var_1 = 0;

  foreach(var_3 in level.unidentified_ieds) {
    if(var_0 worldpointinreticle_circle(var_3.origin, var_0.target_circle_fov, var_0.target_circle_radius)) {
      var_3.in_reaper_target_circle = 1;
      var_1 = var_1 + 1;
      continue;
    }

    var_3.in_reaper_target_circle = undefined;
  }

  foreach(var_6 in level.agentarray) {
    if(!isDefined(var_6)) {
      var_6.in_reaper_target_circle = undefined;
      continue;
    }

    if(!isalive(var_6)) {
      var_6.in_reaper_target_circle = undefined;
      continue;
    }

    if(istrue(var_6.marked_by_overwatch_scan)) {
      var_6.in_reaper_target_circle = undefined;
      continue;
    }

    if(istrue(var_6.team == "_encstr_9A8507BA4040188D08")) {
      var_6.in_reaper_target_circle = undefined;
      continue;
    }

    if(var_0 worldpointinreticle_circle(var_6.origin, var_0.target_circle_fov, var_0.target_circle_radius)) {
      var_6.in_reaper_target_circle = 1;
      var_1 = var_1 + 1;
    }
  }

  var_1 = min(var_1, 7) / 7 * 0.4;
  return var_1;
}

reaper_camera_zoom_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_1 endon("_encstr_8F0607E89A9639D85A");
  var_0 notifyonplayercommand("_encstr_96E016C65282191A5B27764080CACA475772E00A65076828", "_encstr_AF5C0E59B08DA32D7B7337D8ED3A1098");
  var_0 notifyonplayercommand("_encstr_8E0A170E5DBF338BDAB94850B2379DA9EFDA1808BD9F18E303", "_encstr_9A5C0E7471AFC0EA624018717863626F");
  set_current_reaper_camera_zoom_level(var_0, 2, var_1);

  for(;;) {
    var_2 = var_0 scripts\engine\utility::_id_143AD("_encstr_96E016C65282191A5B27764080CACA475772E00A65076828", "_encstr_8E0A170E5DBF338BDAB94850B2379DA9EFDA1808BD9F18E303");

    if(var_2 == "_encstr_96E016C65282191A5B27764080CACA475772E00A65076828")
      adjust_reaper_camera_zoom_level(var_0, -1, var_1);
    else if(var_2 == "_encstr_8E0A170E5DBF338BDAB94850B2379DA9EFDA1808BD9F18E303")
      adjust_reaper_camera_zoom_level(var_0, 1, var_1);

    waitframe();
  }
}

reaper_camera_reset_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 notifyonplayercommand("_encstr_9570177507A32538FF7D631922BFD8E5DA5BB7DFAFEAFDF019", "_encstr_A6E60A229B175A3B48A543AB");

  for(;;) {
    var_0 waittill("_encstr_9570177507A32538FF7D631922BFD8E5DA5BB7DFAFEAFDF019");
    var_0 setplayerangles(vectortoangles(var_1.origin - var_1.reaper.scanning_camera_anchor.origin));
  }
}

adjust_reaper_camera_zoom_level(var_0, var_1, var_2) {
  var_3 = int(clamp(var_0.current_reaper_camera_zoom_level + var_1, 1, 2));
  set_current_reaper_camera_zoom_level(var_0, var_3, var_2);
}

set_current_reaper_camera_zoom_level(var_0, var_1, var_2) {
  if(isDefined(var_0.current_reaper_camera_zoom_level) && var_0.current_reaper_camera_zoom_level == var_1) {
    return;
  }
  var_3 = var_0.current_reaper_camera_zoom_level;
  var_0.current_reaper_camera_zoom_level = var_1;
  switch_to_proper_zoom_weapon(var_0);
  adjust_target_circle_fov_and_radius(var_0);
}

switch_to_proper_zoom_weapon(var_0) {
  var_1 = get_proper_zoom_weapon(var_0);
  var_0 scripts\cp\cp_weapons::_switchtoweaponimmediate(var_1);
}

adjust_target_circle_fov_and_radius(var_0) {
  switch (var_0.current_reaper_camera_zoom_level) {
    case 1:
      var_0.target_circle_fov = 10;
      var_0.target_circle_radius = 150;
      return;
    case 2:
      var_0.target_circle_fov = 22;
      var_0.target_circle_radius = 150;
      return;
    case 3:
      var_0.target_circle_fov = 35;
      var_0.target_circle_radius = 20;
      return;
  }
}

get_proper_zoom_weapon(var_0) {
  switch (var_0.current_reaper_camera_zoom_level) {
    case 1:
      return "_encstr_A3F90EBB3B32C3D21E5A2DFA07B72A93";
    case 2:
      return "_encstr_9A710EF13EAB468A3FDA77BA08E79683";
    case 3:
      return "_encstr_85BC0F7A700BAAA2B6CF607D899857C6F1";
  }
}

mark_vehicle_as_friendly_target_group(var_0, var_1) {
  var_0.humvee_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_8AA71D73E46590B11AA3F5F3E7A288383EFA58290DCCD873A26FDDEB979A4D", var_0, var_1, var_0);

  if(isDefined(level.friendly_convoy)) {
    foreach(var_3 in level.friendly_convoy) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3 == var_1) {
        continue;
      }
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_3, var_0.humvee_marker_group_id);
    }
  }
}

unmark_vehicle_as_friendly_target_group(var_0) {
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_0.humvee_marker_group_id);
}

make_camera_point(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.reaper.scanning_camera_anchor.origin);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = var_1.reaper.scanning_camera_anchor.angles;
  var_2 linkTo(var_1.reaper.scanning_camera_anchor);
  var_0.overwatch_camera_point = var_2;
}

enter_reaper_view(var_0, var_1) {
  var_0 playerlinkweaponviewtodelta(var_1.reaper.scanning_camera_anchor, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 45, 45, 30, 30, 0);
  var_0 playerlinkedsetviewznear(0);
  var_0 setplayerangles(vectortoangles(var_1.origin - var_1.reaper.scanning_camera_anchor.origin));
}

give_reaper_weapons(var_0) {
  var_0 scripts\cp\utility::_giveweapon("_encstr_85BC0F7A700BAAA2B6CF607D899857C6F1");
  var_0 scripts\cp\utility::_giveweapon("_encstr_9A710EF13EAB468A3FDA77BA08E79683");
  var_0 scripts\cp\utility::_giveweapon("_encstr_A3F90EBB3B32C3D21E5A2DFA07B72A93");
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0.pre_reaper_weapon = var_0 getcurrentweapon();
}

exit_reaper(var_0, var_1, var_2, var_3) {
  var_1 notify("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_1 thread exit_overwatch_vision_set(var_1);
  var_1 setclientomnvar("_encstr_841A12AEB4AFDBB3B239DDB03A1B86BE9DD256DD", 0);
  var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", 10);
  var_1 hide_ied_zone_from_player(var_1);
  var_1 update_enemy_visualization_for_exiting_reaper(var_1);
  var_1 hide_ai_marker_vfx_to_player(var_1);
  enable_vehicle_interaction(var_2, "_encstr_838910DD3CC32B6739B8AF8BC9732122B155");
  enable_vehicle_interaction(var_2, "_encstr_9BA00F277525B3E7800BA66C86633D2A05");
  var_1.disable_map_tablet = undefined;
  var_1 exit_reaper_view(var_1);
  var_1 delete_camera_point(var_1);
  var_1 unmark_vehicle_as_friendly_target_group(var_1);
  var_1 remove_reaper_weapons(var_1);
  var_1 unset_player_zoom_setting(var_1);

  if(var_3 == "_encstr_8CBE0BD1BED30936AB03C0B02B" || var_3 == "_encstr_A7951A99DE93C656EBE0C60BBC2B39BE953CA51DF5CEB2D096C663CA") {
    var_1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
  } else
    return_to_previous_seat(var_1, var_2);
}

unset_player_zoom_setting(var_0) {
  var_0.current_reaper_camera_zoom_level = undefined;
}

delete_camera_point(var_0) {
  var_0.overwatch_camera_point delete();
}

exit_reaper_view(var_0) {
  var_0 cameraunlink();
}

remove_reaper_weapons(var_0) {
  var_0 scripts\cp\cp_weapons::_takeweapon("_encstr_85BC0F7A700BAAA2B6CF607D899857C6F1");
  var_0 scripts\cp\cp_weapons::_takeweapon("_encstr_9A710EF13EAB468A3FDA77BA08E79683");
  var_0 scripts\cp\cp_weapons::_takeweapon("_encstr_A3F90EBB3B32C3D21E5A2DFA07B72A93");
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0 switchtoweaponimmediate(var_0.pre_reaper_weapon);
}

put_target_marker_on_critical_enemy_ai(var_0, var_1) {
  if(isDefined(var_1.overwatch_target_marker_group_id))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_0, var_1.overwatch_target_marker_group_id);
  else
    var_1.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_91BE0FB4CA199139F69BB2D158E4CECA8E", var_1, var_0, var_1);

  var_0.target_marker_group_id = var_1.overwatch_target_marker_group_id;
}

add_ai_to_marked_enemy_ai_list(var_0) {
  if(scripts\engine\utility::array_contains(level.marked_enemy_ai, var_0)) {
    return;
  }
  level.marked_enemy_ai = scripts\engine\utility::array_add(level.marked_enemy_ai, var_0);
  var_0 thread remove_from_marked_enemy_ai_list_on_death(var_0);
}

remove_from_marked_enemy_ai_list_on_death(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  level.marked_enemy_ai = scripts\engine\utility::array_remove(level.marked_enemy_ai, var_0);
}

add_ai_to_marked_critical_enemy_ai_list(var_0) {
  if(scripts\engine\utility::array_contains(level.marked_critical_enemy_ai, var_0)) {
    return;
  }
  level.marked_critical_enemy_ai = scripts\engine\utility::array_add(level.marked_critical_enemy_ai, var_0);
  var_0 thread remove_from_marked_critical_enemy_ai_list_on_death(var_0);
}

remove_from_marked_critical_enemy_ai_list_on_death(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  level.marked_critical_enemy_ai = scripts\engine\utility::array_remove(level.marked_critical_enemy_ai, var_0);
}

make_critical_target_icon_on_ai(var_0) {
  if(has_critical_target_icon(var_0)) {
    return;
  }
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_A6051DE0B881DF13FF51DC4F913BD3AB1360D1BAD1CB5032C7DFD1219F70E9" + var_0 getentitynumber(), 22);
  objective_state(var_1, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_icon(var_1, "_encstr_93CB1867D828A6391D6706FB5B27E24F102BBFDBA1C1EEC27303");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 90);
  objective_removeallfrommask(var_1);
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_setshowdistance(var_1, 0);
  objective_setshowprogress(var_1, 0);
  objective_setfadedisabled(var_1, 1);
  var_0.critical_target_icon_objective_id = var_1;
  var_0 thread delete_critical_target_icon_on_death(var_0, var_0 getentitynumber(), var_1);
}

has_critical_target_icon(var_0) {
  return isDefined(var_0.critical_target_icon_objective_id);
}

delete_critical_target_icon_on_death(var_0, var_1, var_2) {
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\cp\cp_objectives::freeworldid("_encstr_A6051DE0B881DF13FF51DC4F913BD3AB1360D1BAD1CB5032C7DFD1219F70E9" + var_1);
  objective_delete(var_2);
  var_0.critical_target_icon_objective_id = undefined;
}

show_critical_target_icon_to_player(var_0, var_1) {
  if(has_critical_target_icon(var_0))
    objective_addclienttomask(var_0.critical_target_icon_objective_id, var_1);
}

hide_critical_target_icon_to_player(var_0, var_1) {
  if(has_critical_target_icon(var_0))
    objective_removeclientfrommask(var_0.critical_target_icon_objective_id, var_1);
}

update_enemy_visualization_for_entering_reaper(var_0) {
  foreach(var_2 in level.marked_enemy_ai)
  outline_enemy_ai_for_overwatch(var_2, var_0);

  foreach(var_2 in level.marked_critical_enemy_ai) {
    hide_critical_target_icon_to_player(var_2, var_0);

    if(isDefined(var_0.overwatch_target_marker_group_id))
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_2, var_0.overwatch_target_marker_group_id);
    else
      var_0.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_91BE0FB4CA199139F69BB2D158E4CECA8E", var_0, var_2, var_0);

    var_2.target_marker_group_id = var_0.overwatch_target_marker_group_id;
  }
}

update_enemy_visualization_for_exiting_reaper(var_0) {
  foreach(var_2 in level.marked_enemy_ai)
  remove_enemy_ai_outline_for_overwatch(var_2, var_0);

  foreach(var_2 in level.marked_critical_enemy_ai) {
    make_critical_target_icon_on_ai(var_2);
    show_critical_target_icon_to_player(var_2, var_0);
  }

  if(isDefined(var_0.overwatch_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_0.overwatch_target_marker_group_id);
    var_0.overwatch_target_marker_group_id = undefined;
  }
}

outline_enemy_ai_for_overwatch(var_0, var_1) {
  var_0 hudoutlineenableforclient(var_1, "_encstr_92C519DBCE9527DD58E86C0DFA8E2CE43B2BD1FAF65D8E632D73AC");
}

remove_enemy_ai_outline_for_overwatch(var_0, var_1) {
  var_0 hudoutlinedisableforclient(var_1);
}

enter_overwatch(var_0, var_1, var_2) {
  var_1 notify("_encstr_AA43104AD025B7BAD1EF4E25ADE806BBC688");
  var_1.disable_map_tablet = 1;
  exit_seat_but_stay_on_seat(var_1);
  record_seat(var_1, "_encstr_8D390A3813DA6D6BE1AB6828");
  var_1 scripts\common\utility::allow_weapon(0);
  var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", -1);
  var_1 setclientomnvar("_encstr_841A12AEB4AFDBB3B239DDB03A1B86BE9DD256DD", 1);
  var_1 show_ied_zone_to_player(var_1);
  var_1 remove_from_players_cannot_see_vehicle_icon_list(var_2, var_1);
  var_1 update_vehicle_objective_visibility(var_2);
  var_1 delete_non_overwatch_ied_marker_vfx_for_player(var_1);
  var_1 show_ai_marker_vfx_to_player(var_1);
  var_1 thread enter_overwatch_vision_set(var_1);
  var_1 thread enter_overwatch_control(var_1, var_2);
  var_1 thread target_in_red_circle_think(var_1, ::overwatch_get_target_in_circle_omnvar_value);
  var_1 thread move_cursor_near_identified_ied(var_1);
  var_1 thread overwatch_radar_control(var_1, var_2);
  level thread enable_overwatch_model();
}

exit_overwatch(var_0, var_1, var_2, var_3) {
  var_1 notify("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_1 thread exit_overwatch_vision_set(var_1);
  var_1 scripts\common\utility::allow_weapon(1);
  var_1 setclientomnvar("_encstr_841A12AEB4AFDBB3B239DDB03A1B86BE9DD256DD", 0);
  var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", 10);
  var_1 hide_ied_zone_from_player(var_1);
  var_1 add_to_players_cannot_see_vehicle_icon_list(var_2, var_1);
  var_1 update_vehicle_objective_visibility(var_2);
  var_1 hide_ai_marker_vfx_to_player(var_1);
  exit_overwatch_control(var_1, var_2);
  enable_vehicle_interaction(var_2, "_encstr_8D390A3813DA6D6BE1AB6828");
  level thread disable_overwatch_model();
  var_1.disable_map_tablet = undefined;

  if(var_3 == "_encstr_8CBE0BD1BED30936AB03C0B02B") {
    var_1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
  } else
    return_to_previous_seat(var_1, var_2);
}

put_icon_on_vehicle(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_A2320D5D273203A0AC9F26F8068780", 20);
  objective_setplayintro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_state(var_1, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_icon(var_1, "_encstr_AC7B1868B32FE3AB528963F55FC9E34977B301584FA098674A2F");
  objective_setlabel(var_1, "_encstr_B40101");
  objective_onentity(var_1, var_0);
  objective_addalltomask(var_1);
  var_0.objective_id = var_1;

  if(getdvarint("_encstr_8505199B1B93D7C84BCDB031C695FAB3AC43D21B1B95EB4BC6DBCD", 0) != 0)
    objective_removeallfrommask(var_0.objective_id);

  var_0 thread icon_clean_up_think(var_0);
}

icon_clean_up_think(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\cp\cp_objectives::freeworldid("_encstr_A2320D5D273203A0AC9F26F8068780");
}

enter_overwatch_control(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", get_camera_spawn_point(var_1));
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = vectortoangles((0, 0, -1));
  var_2.camera_height = var_2.origin[2];
  var_2.camera_min_height = var_2.camera_height - get_overwatch_camera_zoom_max_delta();
  var_2.camera_max_height = var_2.camera_height + get_overwatch_camera_zoom_max_delta();
  var_2 thread clean_up_overwatch_camera_point(var_2, var_0, var_1);
  var_0.overwatch_camera_point = var_2;
  var_0 cameralinkTo(var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 thread camera_zoom_think(var_0, var_1);
  var_0 thread camera_movement_think(var_0, var_1);
  var_0 thread camera_reset_think(var_0, var_1);
  var_0 thread camera_min_height_think(var_0, var_1);
  var_0 thread overwatch_radar_control(var_0, var_1);
}

get_overwatch_camera_zoom_max_delta() {
  if(isDefined(level.overwatch_camera_zoom_max_delta))
    return level.overwatch_camera_zoom_max_delta;

  return 2000;
}

target_in_red_circle_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_0 setclientomnvar("_encstr_AAC6155D96AFE81693D959A3DC7D96DCD7B15AC98DC695", 0);

  for(;;) {
    var_2 = [[var_1]](var_0);
    var_0 setclientomnvar("_encstr_AAC6155D96AFE81693D959A3DC7D96DCD7B15AC98DC695", var_2);
    waitframe();
  }
}

overwatch_get_target_in_circle_omnvar_value(var_0) {
  var_1 = 0;
  var_2 = get_unidentidied_ieds_within_scan_range(var_0, var_0.overwatch_camera_point.camera_ground_point);
  var_3 = squared(600);

  foreach(var_5 in var_2)
  var_1 = var_1 + (1 - distance2dsquared(var_5.origin, var_0.overwatch_camera_point.camera_ground_point) / var_3);

  foreach(var_8 in level.agentarray) {
    if(!isDefined(var_8)) {
      continue;
    }
    if(!isalive(var_8)) {
      continue;
    }
    if(istrue(var_8.marked_by_overwatch_scan)) {
      continue;
    }
    var_9 = distance2dsquared(var_8.origin, var_0.overwatch_camera_point.camera_ground_point);

    if(var_9 <= var_3)
      var_1 = var_1 + (1 - var_9 / var_3);
  }

  var_1 = min(var_1, 7) / 7 * 0.4;
  return var_1;
}

overwatch_radar_control(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_0.false_positive_dots_bank = [];
  var_0.next_false_positive_bank_index = 0;
  var_0 notifyonplayercommand("_encstr_8C0514DEB3CA39DDC23A8D34AFE40B19584EBE38A5DC", "_encstr_B44609DFE7078F394E1651");

  for(;;) {
    var_0 waittill("_encstr_8C0514DEB3CA39DDC23A8D34AFE40B19584EBE38A5DC");
    playFX(level._effect["_encstr_83160F59712D072EB9CFD96BC75F319E78"], var_0.overwatch_camera_point.camera_ground_point, undefined, undefined, var_0);
    show_unidentified_ied_within_scan_range(var_0, var_0.overwatch_camera_point.camera_ground_point);
    level thread show_ai_within_scan_range(var_0, var_0.overwatch_camera_point.camera_ground_point);
    wait 1;
  }
}

show_false_positive_dots(var_0, var_1, var_2) {
  var_3 = get_false_positive_dots_within_scan_range(var_1, var_0);
  var_4 = [];

  if(additional_false_positive_dots_needed(var_3)) {
    var_5 = get_additional_num_false_positive_dots_needed(var_3);
    var_4 = make_false_positive_dots(var_0, var_1, var_5);
  }

  foreach(var_7 in var_3)
  level thread show_false_positive_dot(var_0, var_1, var_7);

  foreach(var_7 in var_4)
  level thread show_false_positive_dot(var_0, var_1, var_7);
}

show_unidentified_ied_within_scan_range(var_0, var_1) {
  var_2 = get_unidentidied_ieds_within_scan_range(var_0, var_1);

  foreach(var_4 in var_2)
  level thread show_ied(var_0, var_1, var_4);
}

show_ai_within_scan_range(var_0, var_1) {
  var_2 = int(30.0);
  var_3 = 400.0;
  var_4 = var_3 * 0.05;

  for(var_5 = 1; var_5 <= var_2; var_5++) {
    var_6 = min(600, var_4 * (1.5 * var_5));

    foreach(var_8 in level.agentarray) {
      if(!isDefined(var_8)) {
        continue;
      }
      if(!isalive(var_8)) {
        continue;
      }
      if(istrue(var_8.marked_by_overwatch_scan)) {
        continue;
      }
      if(distance2dsquared(var_8.origin, var_1) <= var_6 * var_6) {
        var_0.overwatch_camera_point playsoundtoplayer("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E", var_0);
        var_8 hudoutlineenable("_encstr_AA2E1BE85B7C68BBF28FEDFB83FAE8200F77D18383D83960CB87C5FFDF");
        var_8.marked_by_overwatch_scan = 1;
        show_enemy_ai_to_overwatch_player(var_8, var_0);
      }
    }

    waitframe();
  }
}

show_enemy_ai_to_overwatch_player(var_0, var_1) {
  if(isDefined(var_1.enemy_ai_target_marker_group_id))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_0, var_1.enemy_ai_target_marker_group_id);
  else
    var_1.enemy_ai_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_91BE0FB4CA199139F69BB2D158E4CECA8E", var_1, var_0, var_1);

  var_0.target_marker_group_id = var_1.overwatch_target_marker_group_id;
}

hide_ai_marker_vfx_to_player(var_0) {
  if(isDefined(var_0.enemy_ai_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_0.enemy_ai_target_marker_group_id);
    var_0.enemy_ai_target_marker_group_id = undefined;
  }
}

show_ai_marker_vfx_to_player(var_0) {
  foreach(var_2 in level.agentarray) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(istrue(var_2.marked_by_overwatch_scan))
      show_enemy_ai_to_overwatch_player(var_2, var_0);
  }
}

additional_false_positive_dots_needed(var_0) {
  return var_0.size < 5;
}

make_false_positive_dots(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = get_random_value_in_segment(var_2, 360);
  var_5 = get_random_value_in_segment(var_2, 600);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = (0, var_4[var_6], 0);
    var_8 = anglesToForward(var_7);
    var_9 = var_5[var_6];
    var_10 = var_0.overwatch_camera_point.origin;
    var_11 = var_1 + var_8 * var_9;
    var_10 = (var_11[0], var_11[1], var_10[2]);
    var_11 = scripts\engine\trace::ray_trace_detail(var_10, var_11 + (0, 0, -5000))["_encstr_BD260953AA97E3F014279D"] + (0, 0, 5);
    var_3[var_3.size] = var_11;
    put_into_player_false_positive_bank(var_0, var_11);
  }

  return var_3;
}

put_into_player_false_positive_bank(var_0, var_1) {
  var_0.false_positive_dots_bank[var_0.next_false_positive_bank_index] = var_1;
  var_0.next_false_positive_bank_index++;

  if(var_0.next_false_positive_bank_index >= 200)
    var_0.next_false_positive_bank_index = 0;
}

get_additional_num_false_positive_dots_needed(var_0) {
  var_1 = get_num_of_segments();
  return var_1 - var_0.size;
}

get_false_positive_dots_within_scan_range(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1.false_positive_dots_bank) {
    if(distance2dsquared(var_4, var_0) <= 360000)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

get_unidentidied_ieds_within_scan_range(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.unidentified_ieds) {
    if(distance2dsquared(var_4.origin, var_1) <= 360000)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

show_ied(var_0, var_1, var_2) {
  var_3 = distance(var_1, var_2.origin);
  var_4 = 400.0;
  var_5 = var_3 / var_4;
  var_6 = int(var_5 * 20);
  var_5 = var_6 * 0.05;
  wait(max(0.05, var_5 - 0.55));

  if(isDefined(var_0.overwatch_camera_point))
    var_0.overwatch_camera_point playsoundtoplayer("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E", var_0);

  mark_ied_as_identified(var_0, var_2);
}

show_false_positive_dot(var_0, var_1, var_2) {
  var_3 = distance(var_1, var_2);
  var_4 = 400.0;
  var_5 = var_3 / var_4;
  var_6 = int(var_5 * 20);
  var_5 = var_6 * 0.05;
  wait(max(0.05, var_5 - 0.5));
  playFX(level._effect["_encstr_9AD613D1351DEF174BE04B2291818D87101549664D"], var_2, (0, 0, 1), (1, 0, 0), var_0);
}

get_random_value_in_segment(var_0, var_1) {
  var_2 = [];
  var_3 = var_1 / var_0;

  for(var_4 = 0; var_4 < var_0; var_4++)
    var_2[var_2.size] = randomfloatrange(var_4 * var_3, (var_4 + 1) * var_3);

  for(var_5 = 0; var_5 < 5; var_5++)
    var_2 = scripts\engine\utility::array_randomize(var_2);

  return var_2;
}

get_num_of_segments() {
  return randomintrange(5, 11);
}

get_ai_highlight_hudoutline(var_0) {
  return "_encstr_847E18A5C56942E140B80307C8389F2A07D5AF1A2DF9C922C958";
}

mark_enemy_as_identified(var_0, var_1) {
  var_0.highlighted_enemies = scripts\engine\utility::array_remove(var_0.highlighted_enemies, var_1);
  var_1.marked_by_overwatch = 1;
  var_1 hudoutlineenable(get_ai_highlight_hudoutline(var_1));
}

mark_ied_as_identified(var_0, var_1) {
  if(!is_ied_identified(var_1) && isDefined(var_1)) {
    level notify("_encstr_8FDA0B19E14061651FBE28CF8A");
    remove_from_unidentified_ieds_list(var_1);
    mark_ied_controller_as_identified(var_1);
    add_to_identified_ieds_list(var_1);
    show_identified_ied_to_overwatch(var_1, var_0);
    show_identified_ied_to_non_overwatch(var_1, var_0);
    set_ied_scanned_flag_from_ied_controller(var_1);
  }
}

mark_ied_controller_as_identified(var_0) {
  var_1 = var_0.ied_controller;
  var_1.identified = 1;

  if(isDefined(var_1.unidentified_zone_vfxs)) {
    foreach(var_3 in var_1.unidentified_zone_vfxs) {
      if(isDefined(var_3))
        var_3 delete();
    }
  }
}

camera_movement_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_1 endon("_encstr_8F0607E89A9639D85A");

  for(;;) {
    var_2 = var_0 getnormalizedmovement();
    var_3 = var_2[0];
    var_4 = var_2[1];

    if(player_moving_camera(var_3, var_4)) {
      var_0 notify("_encstr_8C921426838A7D1BCF3FF8C8D706B1EF726E91A59AE2");
      var_5 = (var_3 * get_camera_dist_per_frame(var_0), var_4 * get_camera_dist_per_frame(var_0) * -1, 0);
      var_6 = var_0.overwatch_camera_point.origin + var_5;
      var_6 = (var_6[0], var_6[1], var_0.overwatch_camera_point.camera_height);
      var_0.overwatch_camera_point.origin = var_6;
    }

    waitframe();
  }
}

get_camera_dist_per_frame(var_0) {
  var_1 = var_0.overwatch_camera_point.camera_max_height - var_0.overwatch_camera_point.camera_min_height;
  var_2 = var_0.overwatch_camera_point.camera_height - var_0.overwatch_camera_point.camera_min_height;
  var_3 = var_2 / var_1 * 90;
  var_4 = 10 + var_3;
  return var_4;
}

camera_zoom_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_1 endon("_encstr_8F0607E89A9639D85A");

  for(;;) {
    if(var_0 attackButtonPressed()) {
      var_0 notify("_encstr_8C921426838A7D1BCF3FF8C8D706B1EF726E91A59AE2");
      var_0.overwatch_camera_point.camera_height = max(var_0.overwatch_camera_point.camera_min_height, var_0.overwatch_camera_point.camera_height - 160);
      var_0.overwatch_camera_point.origin = (var_0.overwatch_camera_point.origin[0], var_0.overwatch_camera_point.origin[1], var_0.overwatch_camera_point.camera_height);
    }

    if(var_0 adsButtonPressed()) {
      var_0 notify("_encstr_8C921426838A7D1BCF3FF8C8D706B1EF726E91A59AE2");
      var_0.overwatch_camera_point.camera_height = min(var_0.overwatch_camera_point.camera_max_height, var_0.overwatch_camera_point.camera_height + 160);
      var_0.overwatch_camera_point.origin = (var_0.overwatch_camera_point.origin[0], var_0.overwatch_camera_point.origin[1], var_0.overwatch_camera_point.camera_height);
    }

    waitframe();
  }
}

camera_min_height_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_1 endon("_encstr_8F0607E89A9639D85A");

  for(;;) {
    var_2 = scripts\engine\trace::ray_trace_detail(var_0.overwatch_camera_point.origin + (0, 0, -5), var_0.overwatch_camera_point.origin + (0, 0, -50000));
    var_3 = var_2["_encstr_BD260953AA97E3F014279D"];
    var_0.overwatch_camera_point.camera_ground_point = var_3;
    var_4 = var_3[2] + 500;
    var_0.overwatch_camera_point.camera_min_height = var_4;

    if(var_0.overwatch_camera_point.origin[2] < var_4)
      var_0.overwatch_camera_point.origin = (var_0.overwatch_camera_point.origin[0], var_0.overwatch_camera_point.origin[1], var_4);

    waitframe();
  }
}

clean_up_overwatch_camera_point(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::waittill_any_ents_return(var_1, "_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D", var_1, "_encstr_8D820B49520F0EC02DDE6367EC", var_1, "_encstr_8CBE0BD1BED30936AB03C0B02B", var_2, "_encstr_AD75063D571AE108");
  var_0 delete();
}

player_moving_camera(var_0, var_1) {
  if(abs(var_0) != 0)
    return 1;

  if(abs(var_1) != 0)
    return 1;

  return 0;
}

camera_reset_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_1 endon("_encstr_8F0607E89A9639D85A");
  var_0 notifyonplayercommand("_encstr_9570177507A32538FF7D631922BFD8E5DA5BB7DFAFEAFDF019", "_encstr_A6E60A229B175A3B48A543AB");

  for(;;) {
    var_0 thread lock_camera_on_vehicle_until_moving_camera(var_0, var_1);
    var_0 waittill("_encstr_9570177507A32538FF7D631922BFD8E5DA5BB7DFAFEAFDF019");
  }
}

lock_camera_on_vehicle_until_moving_camera(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_0 endon("_encstr_8C921426838A7D1BCF3FF8C8D706B1EF726E91A59AE2");
  var_1 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_2 = get_camera_reset_point(var_0, var_1);
    var_0.overwatch_camera_point.origin = var_2;
    waitframe();
  }
}

get_camera_spawn_point(var_0) {
  return var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37") + (0, 0, get_camera_control_up_offset());
}

get_camera_control_up_offset() {
  if(isDefined(level.overwatch_control_up_offset))
    return level.overwatch_control_up_offset;

  return 2550;
}

get_camera_reset_point(var_0, var_1) {
  var_2 = var_1 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  return (var_2[0], var_2[1], var_0.overwatch_camera_point.camera_height);
}

exit_overwatch_control(var_0, var_1) {
  var_0 cameraunlink();
}

enter_overwatch_vision_set(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  overwatch_screen_transition(var_0);
  wait 0.25;
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", "_encstr_882F130BD84CCC60D78DB78DDB9CEBEC1BA5D11B86", var_0, 0.25);
  wait 0.25;
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", "_encstr_AF500C2C1B136660BE8D7BC6F627", var_0, 0);
}

exit_overwatch_vision_set(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AA43104AD025B7BAD1EF4E25ADE806BBC688");
  overwatch_screen_transition(var_0);
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", undefined, var_0, 0, "_encstr_AF500C2C1B136660BE8D7BC6F627");
  waitframe();
  level notify("_encstr_96291AA5D89B04C875960FA5AB2729121B05F9EF8F72B807A5454724", undefined, var_0, 0, "_encstr_882F130BD84CCC60D78DB78DDB9CEBEC1BA5D11B86");
}

enable_overwatch_model() {
  if(isDefined(level.uavrig))
    level.uavrig show();
  else {
    var_0 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_0.size) {
      var_1 = var_0[0].origin;
      var_2 = var_0[1].origin;
      var_3 = (0, 0, 0);
      var_3 = var_2 - var_1;
      var_3 = (var_3[0] / 2, var_3[1] / 2, var_3[2] / 2) + var_1;
      level.uavrotationorigin = var_3;
    } else
      level.uavrotationorigin = (0, 0, 0);

    level.uavrig = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.uavrotationorigin);
    level.uavrig setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    level.uavrig.angles = (0, 115, 0);
    level.uavrig.targetname = "_encstr_AB6814D5360B8D480727C8508B5123C9E15D40D58F02";
    level.uavrig thread rotateuavrig(70);
  }
}

disable_overwatch_model() {
  if(isDefined(level.uavrig))
    level.uavrig hide();
}

rotateuavrig(var_0, var_1, var_2) {
  if(isDefined(var_2))
    self endon(var_2);

  if(!isDefined(var_0))
    var_0 = 60;

  if(!isDefined(var_1))
    var_1 = -360;

  for(;;) {
    self rotateYaw(var_1, var_0);
    wait(var_0);
  }
}

disable_vehicle_interaction(var_0, var_1) {
  var_2 = get_vehicle_interaction_point(var_0, var_1);
  var_2 makeunusable();
}

enable_vehicle_interaction(var_0, var_1) {
  var_2 = get_vehicle_interaction_point(var_0, var_1);
  var_2 makeusable();
  var_2.being_used = 0;
}

enter_seat(var_0, var_1, var_2) {
  record_seat(var_0, var_2);
  var_0.exit_vehicle_when_exit_seat = 1;
  var_0.stay_on_seat_when_exit_seat = 0;
  play_seat_animation(var_0, var_1, var_2);
  var_0 enter_seat_omnvar(var_0, var_2);
}

play_seat_animation(var_0, var_1, var_2) {
  var_3 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";
  var_4 = get_seat_tag_name(var_2);
  var_5 = var_1 gettagorigin(var_4);
  var_6 = var_1 gettagangles(var_4);
  var_0.player_rig = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
  var_0.player_rig.angles = var_6;
  var_0.player_rig linkTo(var_1, var_4);
  var_0.player_rig setModel(var_3);
  var_0.player_rig hide();
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 animscriptentervehicle();
  var_0 setplayerangles(var_0.player_rig.angles);
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 0, 120, 120, 120, 35, 1);
}

technical_stopanimatingplayer() {
  if(!isDefined(self.player_rig)) {
    return;
  }
  self notify("_encstr_82AD1E43F14030B2FB8FC78B8F9E5B7F80DD7D8C68B8D41A40AF0B83DB43B2BA");
  self.animname = undefined;
  self.player_rig delete();

  if(scripts\cp_mp\utility\player_utility::_isalive())
    self stopanimscriptsceneevent();

  self animscriptexitvehicle();
}

get_seat_tag_name(var_0) {
  var_1 = "_encstr_A10D0BA3B27F17C327D98568E0";

  switch (var_0) {
    case "_encstr_9AE307B956E345D0AB":
      var_1 = "_encstr_A10D0BA3B27F17C327D98568E0";
      break;
    case "_encstr_8CF00A181FEBFB5B6A5FCD4E":
      var_1 = "_encstr_A70D0BFBD379B6D25977D3700A";
      break;
    case "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698":
      var_1 = "_encstr_A30D0B30D3708180E951D37165";
      break;
    case "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B":
      var_1 = "_encstr_930D0BB31F7F41CB11C81BAF42";
      break;
  }

  return var_1;
}

enter_seat_omnvar(var_0, var_1) {
  for(var_2 = 0; var_2 <= var_0.vehicle_riding_on.players_as_passenger.size - 1; var_2++) {
    var_3 = var_0.vehicle_riding_on.players_as_passenger[var_2];
    var_4 = var_3 getentitynumber() + 1;
    var_1 = var_3.current_vehicle_seat;
    var_3 thread enter_seat_omnvar_internal(var_3, var_4, var_1);
  }
}

enter_seat_omnvar_internal(var_0, var_1, var_2) {
  var_3 = get_seat_omnvar_name(var_2);

  foreach(var_5 in level.players) {
    if(isDefined(var_5.vehicle_riding_on) && var_5.vehicle_riding_on == var_0.vehicle_riding_on) {
      var_6 = var_5.vehicle_riding_on;
      var_5 setclientomnvar(var_3, var_1 - 1);

      if(isDefined(var_6.fake_health) && isDefined(var_6.max_fake_health)) {
        var_7 = int(clamp(var_6.fake_health / var_6.max_fake_health * 100, 0, 100));
        var_5 setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", int(var_7));

        if(var_7 < 1 && var_7 > 0)
          var_5 setclientomnvar("_encstr_AF2B1327037F0B9D9BA6C76388341704ED5E116B83", 1);
        else
          var_5 setclientomnvar("_encstr_AF2B1327037F0B9D9BA6C76388341704ED5E116B83", 0);
      } else
        var_5 setclientomnvar("_encstr_AF2B1327037F0B9D9BA6C76388341704ED5E116B83", 0);
    }
  }
}

get_seat_omnvar_name(var_0) {
  var_1 = "_encstr_A93C12AB4BFAB3CAA1D7BDD836BA07583747EB81";

  switch (var_0) {
    case "_encstr_9AE307B956E345D0AB":
      var_1 = "_encstr_A93C12AB4BFAB3CAA1D7BDD836BA07583747EB81";
      break;
    case "_encstr_8D390A3813DA6D6BE1AB6828":
    case "_encstr_8CF00A181FEBFB5B6A5FCD4E":
      var_1 = "_encstr_BA3C1265BBE6D35FD10102DAF833D247789DC7B9";
      break;
    case "_encstr_A9EC1055334A5117D432C7EDCDEF68ADC143":
    case "_encstr_B4AC15DDA818F3EA41BB17F3937C1256B0B1D9E541E8BC":
    case "_encstr_9BA00F277525B3E7800BA66C86633D2A05":
    case "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698":
      var_1 = "_encstr_B13C127DDBF1938723F6D21A59858B0E1099DFA2";
      break;
    case "_encstr_8D7811F837FE2137C2E2C0583FA9B5685F8BB8":
    case "_encstr_ADF31660AF7B6BD33AAF40D587B20370C3376910D70740D1":
    case "_encstr_838910DD3CC32B6739B8AF8BC9732122B155":
    case "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B":
      var_1 = "_encstr_A23C12CD2C819DC1681F2048C7353BEBFA135076";
      break;
    case "_encstr_AC480A070831CEB2611BEF22":
    case "_encstr_8D48079DD59BE65627":
      var_1 = "_encstr_8D3C128564C9D5995857581B9F7DF33302CB68AD";
      break;
  }

  return var_1;
}

watch_for_host_migration() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");

    foreach(var_1 in level.players) {
      var_1 setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 1);
      var_1 scripts\cp\utility::init_vehicle_omnvars();

      if(isDefined(var_1.vehicle_riding_on.players_as_passenger)) {
        enter_seat_omnvar(var_1);
        continue;
      }

      var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", -1);
    }
  }
}

exit_seat_omnvar(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  var_0 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", -1);
  var_4 = get_seat_omnvar_name(var_1);

  foreach(var_0 in level.players) {
    if(isDefined(var_0.vehicle_riding_on) && var_0.vehicle_riding_on == var_2)
      var_0 setclientomnvar(var_4, -1);
  }
}

delay_relax_view_arc(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_826B147091C9EABD482911E3EF0301A661B8D2EB626D");
  waitframe();
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 0, 120, 120, 120, 120, 1);
}

exit_seat(var_0, var_1) {
  if(istrue(var_1) && !istrue(var_0.stay_on_seat_when_exit_seat)) {
    var_0 technical_stopanimatingplayer();
    var_0 unlink();
  }
}

exit_seat_but_stay_in_vehicle(var_0, var_1) {
  var_0.exit_vehicle_when_exit_seat = 0;
  var_0 notify("_encstr_B41206B813CC7176" + var_0.current_vehicle_seat);
  var_0 exit_seat_omnvar(var_0, var_0.current_vehicle_seat, var_1);
}

exit_seat_but_stay_on_seat(var_0) {
  var_0.exit_vehicle_when_exit_seat = 0;
  var_0.stay_on_seat_when_exit_seat = 1;
  var_0 notify("_encstr_B41206B813CC7176" + var_0.current_vehicle_seat);
}

record_seat(var_0, var_1) {
  var_0.previous_vehicle_seat = var_0.current_vehicle_seat;
  var_0.current_vehicle_seat = var_1;
}

return_to_previous_seat(var_0, var_1) {
  var_2 = get_vehicle_interaction_point(var_1, var_0.previous_vehicle_seat);
  var_2 notify("_encstr_8F5C086405E70FBA4B4A", var_0);
  var_0 enter_seat_omnvar(var_0, var_0.previous_vehicle_seat);
}

force_player_to_stand(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 allowstand(1);
  var_0 allowprone(0);
  var_0 allowcrouch(0);
  wait 0.5;
  var_0 allowprone(1);
  var_0 allowcrouch(1);
}

try_exit_vehicle(var_0, var_1, var_2) {
  if(istrue(var_0.exit_vehicle_when_exit_seat))
    exit_vehicle(var_0, var_1, var_2);
}

enter_vehicle(var_0, var_1) {
  level notify("_encstr_878218AF8D826321FA4F8158D314F9AD6A37B034A76A0BA9DC0F");
  var_0 notify("_encstr_857115E0B10B5ECAE4FACAE63A2BE4F53B950D4B6CB1B2");
  var_0 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", 10);
  var_0.vehicle_riding_on = var_1;
  var_0 disableoffhandprimaryweapons();
  var_0 disableoffhandsecondaryweapons();
  var_0 allowsprint(0);
  var_0 allowsupersprint(0);
  var_0 scripts\cp\cp_kidnapper::setimmunetokidnapper(1);
  add_to_players_as_passenger_list(var_1, var_0);
  add_to_players_cannot_see_vehicle_icon_list(var_1, var_0);
  update_vehicle_objective_visibility(var_1);
  _id_12BEC(var_0, var_1);
  update_driver_interaction_hint(var_1);
}

exit_vehicle(var_0, var_1, var_2) {
  var_0 notify("_encstr_826B147091C9EABD482911E3EF0301A661B8D2EB626D");
  var_0 exit_seat_omnvar(var_0, var_2, var_1);
  var_0.vehicle_riding_on = undefined;
  var_0 scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
  remove_from_players_as_passenger_list(var_1, var_0);
  remove_from_players_cannot_see_vehicle_icon_list(var_1, var_0);
  update_vehicle_objective_visibility(var_1);
  var_0.current_vehicle_seat = undefined;
  var_3 = get_exit_vehicle_teleport_to_loc(var_0, var_1, var_2);
  var_0 setOrigin(var_3, 1);
  var_0 setworldupreference(undefined);
  var_0 enableoffhandprimaryweapons();
  var_0 enableoffhandsecondaryweapons();
  var_0 allowsprint(1);
  var_0 allowsupersprint(1);
  var_0 thread force_player_to_stand(var_0);
  var_0 race_set_next_checkpoint(var_0);
  update_driver_interaction_hint(var_1);

  if(should_enable_seat_when_exit_vehicle(var_1, var_2))
    enable_vehicle_interaction(var_1, var_2);
}

_id_12BEC(var_0, var_1) {
  if(isDefined(var_1._id_128C0)) {
    var_0._id_128C1 = [];
    var_2 = var_0 getweaponslistprimaries();
    var_3 = var_0 getcurrentweapon();
    var_4 = scripts\engine\utility::array_contains(var_1._id_128C0, var_3.basename);

    foreach(var_6 in var_2) {
      if(isDefined(var_6.basename) && scripts\engine\utility::array_contains(var_1._id_128C0, var_6.basename)) {
        var_0._id_128C1[var_0._id_128C1.size] = var_6;
        var_0 takeweapon(var_6);
      }
    }

    if(istrue(var_4))
      var_0 switchtoweapon(var_0 getweaponslistprimaries()[0]);
  }
}

race_set_next_checkpoint(var_0) {
  var_1 = 0;

  if(isDefined(var_0._id_128C1)) {
    foreach(var_3 in var_0._id_128C1) {
      var_0 giveweapon(var_3);

      if(issubstr(var_3.basename, "_encstr_A5450BC280BF4B604068C33187"))
        var_1 = 1;
    }

    var_0._id_128C1 = undefined;
  }

  if(istrue(var_1))
    var_0 scripts\cp\cp_weapon::riotshieldonweaponchange();
}

update_vehicle_objective_visibility(var_0) {
  if(getdvarint("_encstr_8505199B1B93D7C84BCDB031C695FAB3AC43D21B1B95EB4BC6DBCD", 0) != 0) {
    return;
  }
  if(!isDefined(var_0.objective_id)) {
    return;
  }
  foreach(var_2 in level.players) {
    if(scripts\engine\utility::array_contains(var_0.players_cannot_see_vehicle_icon, var_2)) {
      objective_removeclientfrommask(var_0.objective_id, var_2);
      continue;
    }

    objective_addclienttomask(var_0.objective_id, var_2);
  }

  objective_showtoplayersinmask(var_0.objective_id);
}

should_enable_seat_when_exit_vehicle(var_0, var_1) {
  return 1;
}

get_exit_vehicle_teleport_to_loc(var_0, var_1, var_2) {
  var_3 = create_seat_name_array(var_2);
  var_4 = 0;
  var_2 = var_3[var_4];
  var_5 = get_exit_base_interaction_point(var_0, var_1, var_2);
  var_6 = get_exit_direction_vector(var_0, var_1, var_2);
  var_7 = vectorNormalize(var_6);
  var_7 = var_7 * -5;
  var_8 = var_5.origin + var_6;
  var_9 = scripts\engine\trace::capsule_trace(var_5.origin + var_7, var_8, 6, 80, undefined, var_1);
  var_10 = 1;

  if(distance2dsquared(var_9["_encstr_BD260953AA97E3F014279D"], var_8) < 225) {
    if(abs(var_9["_encstr_BD260953AA97E3F014279D"][2] - var_8[2]) < 25)
      var_10 = 0;

    if(!ispointonnavmesh(var_9["_encstr_BD260953AA97E3F014279D"]))
      var_10 = 0;
  }

  while(var_10 && var_4 < var_3.size) {
    var_2 = var_3[var_4];
    var_5 = get_exit_base_interaction_point(var_0, var_1, var_2);

    if(isDefined(var_5)) {
      var_6 = get_exit_direction_vector(var_0, var_1, var_2);
      var_7 = vectorNormalize(var_6);
      var_7 = var_7 * -5;
      var_8 = var_5.origin + var_6;
      var_9 = scripts\engine\trace::capsule_trace(var_5.origin + var_7, var_8, 6, 80, undefined, var_1);

      if(distance2dsquared(var_9["_encstr_BD260953AA97E3F014279D"], var_8) < 225) {
        if(abs(var_9["_encstr_BD260953AA97E3F014279D"][2] - var_8[2]) < 25)
          var_10 = 0;

        if(!ispointonnavmesh(var_9["_encstr_BD260953AA97E3F014279D"]))
          var_10 = 0;
      }
    }

    if(var_10)
      var_4++;

    waitframe();
  }

  if(var_4 >= var_3.size)
    var_8 = var_1.origin + (0, 0, 100);

  var_11 = scripts\engine\trace::capsule_trace(var_8 + (0, 0, 0), var_8 + (0, 0, -256), 6, 80)["_encstr_BD260953AA97E3F014279D"];
  return var_11;
}

create_seat_name_array(var_0) {
  switch (var_0) {
    case "_encstr_9AE307B956E345D0AB":
      return ["_encstr_9AE307B956E345D0AB", "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698", "_encstr_8CF00A181FEBFB5B6A5FCD4E", "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B"];
    case "_encstr_8CF00A181FEBFB5B6A5FCD4E":
      return ["_encstr_8CF00A181FEBFB5B6A5FCD4E", "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B", "_encstr_9AE307B956E345D0AB", "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698"];
    case "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698":
      return ["_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698", "_encstr_9AE307B956E345D0AB", "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B", "_encstr_8CF00A181FEBFB5B6A5FCD4E"];
    case "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B":
      return ["_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B", "_encstr_8CF00A181FEBFB5B6A5FCD4E", "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698", "_encstr_9AE307B956E345D0AB"];
  }
}

get_exit_base_interaction_point(var_0, var_1, var_2) {
  switch (var_2) {
    case "_encstr_9AE307B956E345D0AB":
      return get_vehicle_interaction_point(var_1, "_encstr_9AE307B956E345D0AB");
    case "_encstr_8CF00A181FEBFB5B6A5FCD4E":
      return get_vehicle_interaction_point(var_1, "_encstr_8CF00A181FEBFB5B6A5FCD4E");
    case "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698":
      return get_vehicle_interaction_point(var_1, "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698");
    case "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B":
      return get_vehicle_interaction_point(var_1, "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B");
  }
}

get_exit_direction_vector(var_0, var_1, var_2) {
  var_3 = anglestoright(var_1.angles);
  var_4 = var_3 * -1;

  switch (var_2) {
    case "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698":
    case "_encstr_9AE307B956E345D0AB":
      return var_4 * 50;
    case "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B":
    case "_encstr_8CF00A181FEBFB5B6A5FCD4E":
      return var_3 * 50;
  }
}

get_vehicle_interaction_point(var_0, var_1) {
  return var_0.vehicle_interactions[var_1];
}

make_vehicle_seat(var_0, var_1, var_2, var_3) {
  var_4 = var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 = anglesToForward(var_0.angles);
  var_6 = anglestoright(var_0.angles);
  var_7 = anglestoup(var_0.angles);
  var_8 = var_4 + var_5 * var_1 + var_6 * var_2 + var_7 * var_3;
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8);
  var_9 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_9.angles = var_0.angles;
  var_9.vehicle = var_0;
  var_9 linkTo(var_0);
  var_9 thread clean_up_on_vehicle_death(var_9, var_0);
  return var_9;
}

init_vehicle(var_0, var_1) {
  var_0.ied_triggering_tag_to_repair_tag_mapping = var_1.ied_triggering_tag_to_repair_tag_mapping;
  var_0.repair_interaction_list = [];
  var_0.players_as_passenger = [];
  var_0.players_cannot_see_vehicle_icon = [];
  var_0.disabled = 0;
  var_0.script_badplace = 1;
  var_0.classname_mp = var_1.classname_mp;
  var_0.slow_tread_vfx_trigger_speed = var_1.slow_tread_vfx_trigger_speed;
  var_0.fast_tread_vfx_trigger_speed = var_1.fast_tread_vfx_trigger_speed;
  var_0.tread_vfx_tags = var_1.tread_vfx_tags;
  var_0._id_128C0 = var_1._id_128C0;
}

vehicle_damage_monitor(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0.max_fake_health = var_1.fake_health;
  var_0.fake_health = var_1.fake_health;
  var_0.trigger_damage_state_health = int(var_0.fake_health * var_1.show_damage_state_health_ratio);
  var_0.showing_damage_state = 0;
  var_0.disabled_due_to_damage = 0;

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health = 999999;

    if(is_friendly_fire(var_3, var_11)) {
      var_0 thread melee_to_nudge_car(var_0, var_5, var_6);
      continue;
    }

    if(isDefined(var_2)) {
      if(isDefined(var_11))
        var_2 = adjust_damage_to_vehicle(var_2, var_11, var_0);

      var_0.fake_health = var_0.fake_health - var_2;
      var_12 = int(clamp(var_0.fake_health / var_1.fake_health * 100, 0, 100));

      foreach(var_14 in level.players) {
        if(isDefined(var_14.vehicle_riding_on) && var_14.vehicle_riding_on == var_0) {
          var_14 setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", int(var_12));
          var_14 setclientomnvar("_encstr_AF2B1327037F0B9D9BA6C76388341704ED5E116B83", 1);
        }
      }

      if(var_0.fake_health < 0 && !istrue(var_0.disabled_due_to_damage))
        disabling_vehicle_due_to_damage(var_0);
      else if(var_0.fake_health < var_0.trigger_damage_state_health)
        show_vehicle_damage_state(var_0);
    }
  }
}

adjust_damage_to_vehicle(var_0, var_1, var_2) {
  if(isDefined(var_1.basename) && (var_1.basename == "_encstr_8E9312AAFDE9B461BB61CB63B2BBE8CB3B69DE4B" || var_1.basename == "_encstr_81ED0FC9079DFAB55ADCCD96C659EBC60E" || var_1.basename == "_encstr_96891AD839D54B6E95FADAD237B92DC695FADDB027D0CA1619AFB1E0"))
    return var_2.fake_health + 100;

  return var_0;
}

is_friendly_fire(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(isPlayer(var_0))
    return 1;

  if(isDefined(var_0.owner) && isPlayer(var_0.owner))
    return 1;

  if(isDefined(var_1) && isDefined(var_1.basename) && var_1.basename == "_encstr_A2DC15EDEC9539DD8547D81AAFADA5E69BD236B2D7D81C")
    return 1;

  return 0;
}

melee_to_nudge_car(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 == "_encstr_8DED0A21C79B660BC7588981" && var_0.players_as_passenger.size == 0) {
    var_3 = (var_1 + var_0.origin) / 2 - (0, 0, 40);
    physicsexplosionsphere(var_3, 3, 2, 4);
  }
}

show_vehicle_damage_state(var_0) {
  if(istrue(var_0.showing_damage_state)) {
    return;
  }
  var_0.showing_damage_state = 1;
  var_1 = get_vehicle_interaction_point(var_0, "_encstr_B4610CAA50F73F5F53A560694BBB");
  var_1 thread play_vfx_on_repair_part(var_0, "_encstr_8AD00A6D0E22EFA13AE75850", "_encstr_A7B01AD5AFBA8B582417BE50BD1F5828D2276B034FB258904DED20C9", var_1, anglesToForward(var_0.angles));
}

disabling_vehicle_due_to_damage(var_0) {
  var_0.disabled_due_to_damage = 1;
  var_0.disabled = 1;
  update_driver_interaction_hint(var_0);
  level notify("_encstr_974C1523E973EF9630933F06BB509F5F30E3EACBF15BCB");
  var_1 = get_vehicle_interaction_point(var_0, "_encstr_B4610CAA50F73F5F53A560694BBB");
  put_icon_on_vehicle_repair_point(var_0, var_1);
  set_repair_omnvars("_encstr_B4610CAA50F73F5F53A560694BBB", 1);
  var_1 thread play_vfx_on_repair_part(var_0, "_encstr_B81E18E85876D7B1D2B3D0A3D733E47BE68EFAC9D23B43E8FA8C", "_encstr_A7B01AD5AFBA8B582417BE50BD1F5828D2276B034FB258904DED20C9", var_1, anglesToForward(var_0.angles));
  var_1 thread play_vfx_on_repair_part(var_0, "_encstr_AA2117AB7E4FD119A2A791A12F3A5E08EE937620E7B640582F", "_encstr_A7B01AD5AFBA8B582417BE50BD1F5828D2276B034FB258904DED20C9", var_1, anglesToForward(var_0.angles));
  force_driver_out_of_vehicle(var_0);
  show_vehicle_damage_state(var_0);
  enable_vehicle_interaction(var_0, "_encstr_B4610CAA50F73F5F53A560694BBB");
  var_1 = get_vehicle_interaction_point(var_0, "_encstr_B4610CAA50F73F5F53A560694BBB");
  add_to_vehicle_repair_interaction_list(var_0, var_1);
}

set_up_vehicle_interactions(var_0, var_1) {
  var_2 = var_0.angles;
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);
  var_5 = anglestoup(var_2);
  var_6 = var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0.vehicle_interactions = [];

  foreach(var_11, var_8 in var_1.interaction_setups_array) {
    var_9 = var_6 + var_3 * var_8.front_offset_from_tag_origin + var_4 * var_8.right_offset_from_tag_origin + var_5 * var_8.up_offset_from_tag_origin;
    var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_9);
    var_10 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_10 linkTo(var_0);
    var_8 = get_vehicle_interaction_info(var_11);
    var_10 setHintString(var_8.hint_string);
    var_10 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
    var_10 sethintdisplayrange(var_8.display_range);
    var_10 sethintdisplayfov(var_8.display_fov);
    var_10 setuserange(var_8.use_range);
    var_10 setusefov(var_8.use_fov);
    var_10 sethintonobstruction("_encstr_BECC055CF3811A");
    var_10 setuseholdduration(var_8.use_hold_duration);
    var_10 thread use_think(var_11, var_10, var_0, var_8.try_use_func, var_8.start_use_func, var_8.exit_use_func, var_8.exit_button, var_8.available_on_start);
    var_0.vehicle_interactions[var_11] = var_10;
  }
}

set_up_ied_triggering_tags(var_0, var_1) {
  var_0.ied_triggering_tags = var_1.ied_triggering_tags;
}

use_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_2 endon("_encstr_AD75063D571AE108");
  var_8 = "_encstr_B41206B813CC7176" + var_0;

  if(istrue(var_7))
    var_1 makeusable();

  var_1.being_used = 0;

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_9);

    if(isDefined(var_3) && ![[var_3]](var_2, var_9)) {
      continue;
    }
    if(isDefined(var_6))
      var_9 notifyonplayercommand(var_8, var_6);

    var_1 makeunusable();
    var_1.being_used = 1;
    var_1 thread[[var_4]](var_1, var_9, var_2);

    if(isDefined(var_6))
      var_10 = var_9 scripts\engine\utility::waittill_any_ents_return(var_9, "_encstr_8D820B49520F0EC02DDE6367EC", var_9, var_8, var_1, "_encstr_83721B5A73E82BE4C2C6E82DED73AF1CEDA5B9D1AF465AB916C48DCAC8", var_9, "_encstr_8CBE0BD1BED30936AB03C0B02B", var_9, "_encstr_A7951A99DE93C656EBE0C60BBC2B39BE953CA51DF5CEB2D096C663CA", var_9, "_encstr_82A21718DAB2F799473071FF21F723C7DF13E810310A23D1C3");
    else
      var_10 = var_9 scripts\engine\utility::waittill_any_ents_return(var_9, "_encstr_8D820B49520F0EC02DDE6367EC", var_1, "_encstr_83721B5A73E82BE4C2C6E82DED73AF1CEDA5B9D1AF465AB916C48DCAC8", var_9, "_encstr_8CBE0BD1BED30936AB03C0B02B", var_9, "_encstr_9BCB0E9B2F18AFC0A25EB8CFE214034B", var_9, "_encstr_A7951A99DE93C656EBE0C60BBC2B39BE953CA51DF5CEB2D096C663CA", var_9, "_encstr_82A21718DAB2F799473071FF21F723C7DF13E810310A23D1C3");

    if(isDefined(var_5))
      var_1 thread[[var_5]](var_1, var_9, var_2, var_10);
  }
}

register_vehicle_interaction_info(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = spawnStruct();
  var_12.hint_string = var_1;
  var_12.try_use_func = var_2;
  var_12.start_use_func = var_3;
  var_12.exit_use_func = var_4;
  var_12.exit_button = var_5;
  var_12.display_range = var_6;
  var_12.display_fov = var_7;
  var_12.use_range = var_8;
  var_12.use_fov = var_9;
  var_12.use_hold_duration = var_10;
  var_12.available_on_start = var_11;
  level.vehicle_interaction_info[var_0] = var_12;
}

get_vehicle_interaction_info(var_0) {
  return level.vehicle_interaction_info[var_0];
}

assign_vehicle_interaction(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.front_offset_from_tag_origin = var_1;
  var_5.right_offset_from_tag_origin = var_2;
  var_5.up_offset_from_tag_origin = var_3;
  var_4[var_0] = var_5;
  return var_4;
}

debug_interaction_point(var_0) {
  for(;;)
    waitframe();
}

add_additional_parts(var_0, var_1) {
  if(isDefined(var_1.add_additional_parts_func))
    level thread[[var_1.add_additional_parts_func]](var_0);
}

set_up_fake_character_models(var_0) {
  var_0.fake_back_right_passenger = make_fake_character_model(var_0, "_encstr_930D0BB31F7F41CB11C81BAF42", 1);
  var_0.fake_back_left_passenger = make_fake_character_model(var_0, "_encstr_A30D0B30D3708180E951D37165", 1);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

make_fake_character_model(var_0, var_1, var_2, var_3) {
  var_4 = var_0 gettagorigin(var_1);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4, 0, 1);
  var_5 setModel("_encstr_BDD61A99ABB163C4BD23E5F5A12B4EBDBE0EC95A36B2BED5274C2CE6");
  var_5.angles = var_0.angles;
  var_5 useanimtree(#animtree);

  if(isDefined(var_3))
    var_5 linkTo(var_0, var_1, var_3, (0, 0, 0));
  else
    var_5 linkTo(var_0, var_1);

  var_5 thread fake_driver_anim_loop(var_5);
  var_5 thread clean_up_on_vehicle_death(var_5, var_0);

  if(istrue(var_2))
    var_5 hide();

  return var_5;
}

clean_up_on_vehicle_death(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

#using_animtree("_encstr_B40101");

fake_driver_anim_loop(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = 17.5;
  wait(randomfloatrange(0.5, 3.5));

  for(;;) {
    var_0 scriptmodelplayanim(%_encstr_8ECF1882C83763C35EB301889D3D2B73051067901F8309112843);
    wait(var_1);
  }
}

overwatch_screen_transition(var_0) {
  if(!isDefined(var_0.overwatch_transition_screen)) {
    var_0.overwatch_transition_screen = newclienthudelem(var_0);
    var_0.overwatch_transition_screen.x = 0;
    var_0.overwatch_transition_screen.y = 0;
    var_0.overwatch_transition_screen setshader("_encstr_83AB065EE1391A7B", 640, 480);
    var_0.overwatch_transition_screen.alignx = "_encstr_A5AD056A019C63";
    var_0.overwatch_transition_screen.aligny = "_encstr_AC190479FF92";
    var_0.overwatch_transition_screen.sort = 1;
    var_0.overwatch_transition_screen.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
    var_0.overwatch_transition_screen.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
    var_0.overwatch_transition_screen.foreground = 1;
  }

  var_0.overwatch_transition_screen.alpha = 1;
  var_0.overwatch_transition_screen fadeovertime(0.25);
  var_0.overwatch_transition_screen.alpha = 0;
}

set_up_ieds() {
  level.unidentified_ieds = [];
  level.identified_ieds = [];

  if(!ied_enabled()) {
    return;
  }
  var_0 = scripts\engine\utility::getStructArray("_encstr_B47C0FB4FF0159BFD543F86B0FFC28B78E", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    spawn_ied_zone(var_2);
    waitframe();
  }
}

spawn_ied_zone(var_0) {
  if(!should_spawn_ied_zone(var_0)) {
    return;
  }
  var_0.identified = 0;
  var_1 = get_num_of_ied_to_spawn(var_0);

  if(isDefined(var_0.target))
    var_2 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  else
    var_2 = [];

  if(var_2.size > 0) {
    for(var_3 = 0; var_3 < 5; var_3++)
      var_2 = scripts\engine\utility::array_randomize(var_2);

    for(var_4 = 0; var_4 < var_1; var_4++)
      spawn_ied(var_2[var_4], var_0);
  } else if(var_2.size == 0 && var_1 > 0) {
    if(!isDefined(level.ied_unique_names))
      level.ied_unique_names = 0;

    var_5 = "_encstr_BE3510411F4CEEC3ABEB584807F31713C0DF" + level.ied_unique_names;
    var_0.target = var_5;
    level.ied_unique_names++;
    var_6 = 256;

    if(isDefined(var_0.radius))
      var_6 = var_0.radius;

    if(var_6 < 20)
      var_6 = 20;

    var_7 = var_6 * 0.1;

    for(var_3 = 0; var_3 < var_1; var_3++) {
      var_8 = randomfloatrange(var_7, var_6);
      var_9 = randomfloatrange(var_7, var_6);

      if(scripts\engine\utility::cointoss())
        var_8 = var_8 * -1;

      if(scripts\engine\utility::cointoss())
        var_9 = var_9 * -1;

      var_10 = (var_8, var_9, 0);
      var_11 = spawnStruct();
      var_11.origin = var_0.origin + var_10;
      var_11.origin = scripts\engine\utility::drop_to_ground(var_11.origin);

      if(isDefined(var_0.script_label) && var_0.script_label != "_encstr_B40101") {
        var_11.script_parameters = var_0.script_label;
        var_11.angles = (0, randomfloat(360), 0);
        var_11.origin = var_11.origin + (0, 0, 2);
      } else {
        var_11.script_parameters = "_encstr_87A1155620A0AA318B67073F7B27CAE589280B9FDEA221";
        var_11.angles = (randomfloat(360), randomfloat(360), randomfloat(360));
      }

      var_11.targetname = var_5;
      spawn_ied(var_11, var_0);
    }
  }

  var_0 thread ied_controller_activation_monitor(var_0);
}

should_spawn_ied_zone(var_0) {
  var_1 = 1;

  if(getdvarfloat("_encstr_928B15076FC348A095EF166B12799818C9C789ABC3BA2D", 0) != 0)
    var_1 = getdvarfloat("_encstr_928B15076FC348A095EF166B12799818C9C789ABC3BA2D");

  return randomfloat(1) < var_1;
}

get_num_of_ied_to_spawn(var_0) {
  if(isDefined(var_0.script_parameters))
    return int(var_0.script_parameters);
  else
    return scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").size;
}

spawn_ied(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2 setModel(var_0.script_parameters);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_2.target = var_0.target;
  var_2.ied_controller = var_1;
  var_2.active = 0;
  var_3 = anglestoup(var_2.angles);
  var_2.center_point = var_2.origin + var_3 * 10;
  add_to_unidentified_ieds_list(var_2);
  var_2 thread ied_damage_monitor(var_2);
  var_2 thread ied_trigger_monitor(var_2);
}

ied_damage_monitor(var_0) {
  var_0 endon("_encstr_9A010DC9D097372173E8A910D42F49");
  var_0 setCanDamage(1);
  var_0.health = 999999;

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    var_0.health = 999999;

    if(isDefined(var_2) && isPlayer(var_2) || isDefined(var_2.owner) && isPlayer(var_2.owner) || isDefined(var_10) && var_10.basename == "_encstr_A2DC15EDEC9539DD8547D81AAFADA5E69BD236B2D7D81C")
      ied_explodes(var_0);
  }
}

ied_controller_activation_monitor(var_0) {
  for(;;) {
    if(!isDefined(scripts\engine\utility::getclosest(var_0.origin, level.players, 1024)))
      deactivate_linked_ied_spawners(var_0);
    else
      activate_linked_ied_spawners(var_0);

    wait 0.25;
  }
}

deactivate_linked_ied_spawners(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].ied_controller) && istrue(var_1[var_2].active)) {
      var_1[var_2] notify("_encstr_827414DFD1755F43EDBBCFC795D5C925B810D753E8EB");
      var_1[var_2].active = 0;
    }
  }
}

activate_linked_ied_spawners(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].ied_controller) && !istrue(var_1[var_2].active)) {
      var_1[var_2].active = 1;
      var_1[var_2] thread ied_trigger_monitor(var_1[var_2]);
    }
  }
}

ied_trigger_monitor(var_0) {
  var_0 notify("_encstr_827414DFD1755F43EDBBCFC795D5C925B810D753E8EB");
  var_0 endon("_encstr_827414DFD1755F43EDBBCFC795D5C925B810D753E8EB");
  var_0 endon("_encstr_9A010DC9D097372173E8A910D42F49");

  for(;;) {
    if(ied_should_explode(var_0))
      ied_explodes(var_0);

    wait 0.1;
  }
}

ied_should_explode(var_0) {
  if(ied_triggered_by_players(var_0))
    return 1;

  if(ied_triggered_by_vehicles(var_0))
    return 1;

  return 0;
}

ied_explodes(var_0, var_1) {
  earthquake(0.5, 1.2, var_0.origin, 400);
  playFX(level._effect["_encstr_9BCB0E77AFB9B0A020BBE8C843111763"], var_0.origin);
  playsoundatpos(var_0.origin, "_encstr_AF36183D3BE24401679AA1D8464C18901ABB89A1F7DB96C8B632");

  if(isDefined(var_0.overwatch_target_marker_group_id))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_0, var_0 getentitynumber(), var_0.overwatch_target_marker_group_id);

  remove_from_unidentified_ieds_list(var_0);
  remove_from_identified_ieds_list(var_0);
  remove_ied_marker_vfx(var_0);
  mark_ied_controller_as_identified(var_0);
  level thread delay_respawn_ied_zone(var_0);
  damage_nearby_players(var_0, 100, 6400);
  damage_nearby_map_vehicles(var_0, 9216);
  damage_nearby_vehicles(var_0, 1600);
  send_notify_from_ied_controller(var_0);
  delete_ied_marker_vfx_to_non_overwatch(var_0);
  do_level_specific_callback(var_0);
  var_0 delete();
  var_0 notify("_encstr_9A010DC9D097372173E8A910D42F49");
}

remove_from_target_marker_group(var_0) {
  if(isDefined(var_0.target_marker_group_id_list)) {
    foreach(var_2 in var_0.target_marker_group_id_list)
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_0, var_2);
  }
}

do_level_specific_callback(var_0) {
  if(isDefined(level.ied_explosion_action_func))
    level thread[[level.ied_explosion_action_func]](var_0);
}

delete_ied_marker_vfx_to_non_overwatch(var_0) {
  if(!isDefined(var_0.ied_marker_vfxs_non_overwatch)) {
    return;
  }
  foreach(var_2 in var_0.ied_marker_vfxs_non_overwatch) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

send_notify_from_ied_controller(var_0) {
  var_1 = var_0.ied_controller;

  if(isDefined(var_1.groupname))
    level notify(var_1.groupname);
}

set_ied_scanned_flag_from_ied_controller(var_0) {
  var_1 = var_0.ied_controller;

  if(isDefined(var_1.script_side)) {
    if(!scripts\engine\utility::flag_exist(var_1.script_side))
      scripts\engine\utility::flag_init(var_1.script_side);

    scripts\engine\utility::flag_set(var_1.script_side);
  }
}

ied_triggered_by_vehicles(var_0) {
  for(var_1 = 0; var_1 < level.vehicle_travel_array.size; var_1++) {
    if(isDefined(level.vehicle_travel_array[var_1].under_vehicle_trigger) && var_0 istouching(level.vehicle_travel_array[var_1].under_vehicle_trigger))
      return 1;
  }

  if(isDefined(level.ied_triggered_by_friendly_convoy_func))
    return [[level.ied_triggered_by_friendly_convoy_func]](var_0);

  return 0;
}

ied_triggered_by_players(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(istrue(level.players[var_1].b_in_vehicle)) {
      continue;
    }
    if(isDefined(level.player_is_terrorist_func) && [[level.player_is_terrorist_func]](level.players[var_1])) {
      continue;
    }
    if(distancesquared(level.players[var_1].origin, var_0.center_point) < 1600)
      return 1;
  }

  return 0;
}

add_to_vehicle_travel_array(var_0) {
  if(!isDefined(level.vehicle_travel_array))
    level.vehicle_travel_array = [];

  level.vehicle_travel_array = scripts\engine\utility::array_add(level.vehicle_travel_array, var_0);
}

damage_nearby_players(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0.origin) < var_2)
      var_4 dodamage(var_1, var_0.origin);
  }
}

damage_nearby_map_vehicles(var_0, var_1) {
  if(!isDefined(level.veh_map_ieddamage))
    level.veh_map_ieddamage = getcompleteweaponname("_encstr_91730EE7A8D8C8B0A5FD1FF790E72860");

  var_0.team = "_encstr_8E8405EA382B2A";

  foreach(var_3 in level.technicals) {
    if(!isent(var_3)) {
      continue;
    }
    if(distancesquared(var_3.origin, var_0.origin) < var_1)
      var_3 dodamage(800, var_0.origin, var_0, var_0, "_encstr_AB590C99ED78875F650F3951034D", level.veh_map_ieddamage);
  }
}

damage_nearby_vehicles(var_0, var_1) {
  var_2 = get_nearby_vehicles(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = var_4.vehicle;
    var_6 = var_4.ied_triggering_tag;
    var_7 = get_repair_interaction_point_name(var_6);
    var_8 = get_vehicle_interaction_point(var_5, var_7);
    try_enable_repair_interaction(var_5, var_6, var_0.origin, var_7, var_8);
  }
}

try_enable_repair_interaction(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\engine\utility::array_contains(var_0.repair_interaction_list, var_4)) {
    level thread do_damage_to_all_players_as_passenger(var_2, var_0.players_as_passenger);
    enable_vehicle_interaction(var_0, var_3);
    var_5 = var_0.ied_triggering_tag_to_repair_tag_mapping[var_1];
    var_4.repair_tag = var_5;
    add_to_vehicle_repair_interaction_list(var_0, var_4, var_5);
    put_icon_on_vehicle_repair_point(var_0, var_4);
    var_4 thread play_vfx_on_repair_part(var_0, var_5, get_fire_damage_vfx(var_5), var_4, anglesToForward(var_0.angles));
    var_0.disabled = 1;
    update_driver_interaction_hint(var_0);
    level notify("_encstr_974C1523E973EF9630933F06BB509F5F30E3EACBF15BCB");
    force_driver_out_of_vehicle(var_0);
  }
}

update_driver_interaction_hint(var_0) {
  var_1 = get_vehicle_interaction_point(var_0, "_encstr_9AE307B956E345D0AB");
  var_1 setHintString(prophidetime(var_0));
}

prophidetime(var_0) {
  if(istrue(var_0.disabled))
    return &"_encstr_AA1A1F3405EBB2A89094341351FAA892282B519879258AA0A0254ABE3294946A2A";
  else if(isDefined(level.reduce_accuracy_while_stunned))
    return [[level.reduce_accuracy_while_stunned]](var_0);
  else
    return &"_encstr_AA751968A0FAB28A4252346251AFA8A482AC2AC4CB8829922B8A4A";
}

get_fire_damage_vfx(var_0) {
  if(issubstr(var_0, "_encstr_A5AD056A019C63"))
    return "_encstr_99211FEC59A15AD81B95EBD1D2C9B2BE91C25B58B3957D9BD67BB6CABE1B59991D";
  else
    return "_encstr_AF892050E7D3CB3FC949E70310F2B9CFD06E8D78840DB75F315F47D5D19B03B00D83";
}

force_driver_out_of_vehicle(var_0) {
  var_1 = get_vehicle_interaction_point(var_0, "_encstr_9AE307B956E345D0AB");
  var_1 notify("_encstr_83721B5A73E82BE4C2C6E82DED73AF1CEDA5B9D1AF465AB916C48DCAC8");
}

do_damage_to_all_players_as_passenger(var_0, var_1) {
  waitframe();

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3))
      var_3 dodamage(20, var_0);
  }
}

get_repair_interaction_point_name(var_0) {
  switch (var_0) {
    case "_encstr_A6B41463B859E7CB117597CD702DE26360E19BAF78D3":
      return "_encstr_92651150529E9FA6E33D6C5D2FB32971C63A28";
    case "_encstr_838D158DEEC20F43C037B0F0F7E259AFEA99069BC78A11":
      return "_encstr_B6B91289161BD6AF9CD23B1A8EFA4E2B382CD2E4";
    case "_encstr_958A15D158CEAFDDA159CA8DFA33C9BDB9A3D71B566647":
      return "_encstr_81EF129927BD73D1D71B956647D74ECA0E2CD2E4";
    case "_encstr_932416D159EFC9948B72B198F99BCE9045A47F55C957385D":
      return "_encstr_ADE513BDDB5F2DA459FBFB7F1AA4C7C23B6A499F6B";
  }
}

add_to_vehicle_repair_interaction_list(var_0, var_1, var_2) {
  if(!scripts\engine\utility::array_contains(var_0.repair_interaction_list, var_1)) {
    var_0.repair_interaction_list = scripts\engine\utility::array_add(var_0.repair_interaction_list, var_1);

    if(isDefined(var_2))
      set_repair_omnvars(var_2, 1);
  }
}

remove_from_vehicle_repair_interaction_list(var_0, var_1, var_2) {
  if(scripts\engine\utility::array_contains(var_0.repair_interaction_list, var_1)) {
    var_0.repair_interaction_list = scripts\engine\utility::array_remove(var_0.repair_interaction_list, var_1);

    if(isDefined(var_2))
      set_repair_omnvars(var_2, 0);
  }
}

set_repair_omnvars(var_0, var_1) {
  var_2 = "_encstr_9B251482BB1863E7801BB3B42B11EF87B9315A6AA6C7";

  switch (var_0) {
    case "_encstr_822E1C35718FFEF704722B50C99E9B90BB1DBE38CE73203DEBF940103273":
      var_2 = "_encstr_9B251482BB1863E7801BB3B42B11EF87B9315A6AA6C7";
      break;
    case "_encstr_84311D85A15F2E27D482F080192ECBC0CB4D0EE83EA3904DBB4940A07204D1":
      var_2 = "_encstr_832514E833AF2323628466F99F497989F50F4040277A";
      break;
    case "_encstr_95401B1D2C9DFA77D02B59C6D7C6B2DCE82B397D312C36ADAF8DB2CC47":
      var_2 = "_encstr_8B2514B1C2BF50556A573FD99FE12D20551EB9C9A1BB";
      break;
    case "_encstr_B8C91CC3D3BCF97F4051AFF50EC0B5228D6353F7BDD7622BD15BA43FC010":
      var_2 = "_encstr_862514612AEFCE57BA4050F8458EBA4F614E9787D0A1";
      break;
    case "_encstr_B4610CAA50F73F5F53A560694BBB":
      var_2 = "_encstr_A5251439C7178B67C0CC22420F70D9DA871E793721C7";
      break;
  }

  if(istrue(var_1))
    var_3 = 1;
  else
    var_3 = 0;

  foreach(var_5 in level.players)
  var_5 setclientomnvar(var_2, var_3);
}

all_repairs_are_done(var_0) {
  if(var_0.repair_interaction_list.size == 0)
    return 1;
  else if(var_0.repair_interaction_list.size == 1) {
    if(!var_0.disabled_due_to_damage && var_0.repair_interaction_list[0] == var_0.vehicle_interactions["_encstr_B4610CAA50F73F5F53A560694BBB"])
      return 1;
  }

  return 0;
}

add_to_players_as_passenger_list(var_0, var_1) {
  var_1.b_in_vehicle = 1;

  if(!scripts\engine\utility::array_contains(var_0.players_as_passenger, var_1))
    var_0.players_as_passenger = scripts\engine\utility::array_add(var_0.players_as_passenger, var_1);
}

remove_from_players_as_passenger_list(var_0, var_1) {
  var_1.b_in_vehicle = 0;

  if(scripts\engine\utility::array_contains(var_0.players_as_passenger, var_1))
    var_0.players_as_passenger = scripts\engine\utility::array_remove(var_0.players_as_passenger, var_1);
}

add_to_players_cannot_see_vehicle_icon_list(var_0, var_1) {
  if(!scripts\engine\utility::array_contains(var_0.players_cannot_see_vehicle_icon, var_1))
    var_0.players_cannot_see_vehicle_icon = scripts\engine\utility::array_add(var_0.players_cannot_see_vehicle_icon, var_1);
}

remove_from_players_cannot_see_vehicle_icon_list(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_0.players_cannot_see_vehicle_icon, var_1))
    var_0.players_cannot_see_vehicle_icon = scripts\engine\utility::array_remove(var_0.players_cannot_see_vehicle_icon, var_1);
}

player_in_vehicle(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_1.players_as_passenger, var_0);
}

get_nearby_vehicles(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.vehicle_travel_array) {
    if(isDefined(var_4.ied_triggering_tags)) {
      foreach(var_6 in var_4.ied_triggering_tags) {
        if(distancesquared(var_4 gettagorigin(var_6), var_0.origin) < var_1 && !scripts\engine\utility::array_contains(var_2, var_4)) {
          var_7 = spawnStruct();
          var_7.vehicle = var_4;
          var_7.ied_triggering_tag = var_6;
          var_2 = scripts\engine\utility::array_add(var_2, var_7);
        }
      }
    }
  }

  return var_2;
}

play_vfx_on_repair_part(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 gettagorigin(var_1);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
  var_6 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6.angles = vectortoangles(var_4);
  var_6 linkTo(var_0);
  wait 0.1;
  playFXOnTag(level._effect[var_2], var_6, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  scripts\engine\utility::waittill_any_ents(var_0, "_encstr_AD75063D571AE108", var_3, "_encstr_83721B5A73E82BE4C2C6E82DED73AF1CEDA5B9D1AF465AB916C48DCAC8");
  stopFXOnTag(level._effect[var_2], var_6, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6 delete();
}

put_icon_on_vehicle_repair_point(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::requestworldid("_encstr_A1720C33B92F9F44B097595B9F38", 21);
  objective_setplayintro(var_2, 0);
  objective_setbackground(var_2, 1);
  objective_state(var_2, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_icon(var_2, "_encstr_8A0B17D9B3CF95A07EFF497BECA938D6E7AAD6634ACB47A852");
  objective_setlabel(var_2, "_encstr_B40101");
  objective_onentity(var_2, var_1);
  objective_addalltomask(var_2);
  var_1.objective_id = var_2;
  var_1 thread repair_icon_clean_up_think(var_0, var_1, var_2);
}

repair_icon_clean_up_think(var_0, var_1, var_2) {
  scripts\engine\utility::waittill_any_ents(var_0, "_encstr_AD75063D571AE108", var_1, "_encstr_83721B5A73E82BE4C2C6E82DED73AF1CEDA5B9D1AF465AB916C48DCAC8");
  objective_delete(var_2);
  scripts\cp\cp_objectives::freeworldid("_encstr_A1720C33B92F9F44B097595B9F38");
}

delay_respawn_ied_zone(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0.ied_controller;
  wait(randomfloatrange(600, 900));

  for(;;) {
    if(can_respawn_ied_zone(var_1)) {
      spawn_ied_zone(var_1);
      return;
    }

    wait 15;
  }
}

can_respawn_ied_zone(var_0) {
  foreach(var_2 in level.players) {
    if(distance2dsquared(var_2.origin, var_0.origin) < 250000)
      return 0;

    if(isDefined(var_2.overwatch_camera_point) && distance2dsquared(var_2.overwatch_camera_point.origin, var_0.origin) < 1000000)
      return 0;
  }

  return 1;
}

remove_ied_marker_vfx(var_0) {
  if(isDefined(var_0.marker_vfx))
    var_0.marker_vfx delete();

  if(isDefined(var_0.mine_drone_marker_vfx))
    var_0.mine_drone_marker_vfx delete();
}

show_ied_zone_to_player(var_0) {
  if(!ied_enabled()) {
    return;
  }
  show_identified_ieds_to_overwatch(var_0);
}

ied_enabled() {
  return getdvarint("_encstr_A2530F9F9776B92D3011AE3589E17952C5", 0) != 0;
}

show_identified_ieds_to_overwatch(var_0) {
  if(!isDefined(level.identified_ieds)) {
    return;
  }
  level.identified_ieds = scripts\engine\utility::array_removeundefined(level.identified_ieds);

  if(level.identified_ieds.size > 0)
    var_0.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_91BE0FB4CA199139F69BB2D158E4CECA8E", var_0, level.identified_ieds, var_0);
}

show_identified_ied_to_overwatch(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.origin)) {
    if(isDefined(var_1.overwatch_target_marker_group_id)) {
      handle_identified_ied_to_overwatch_max(var_1);
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_0, var_1.overwatch_target_marker_group_id);
      update_target_marker_group_id_on_ied(var_0, var_1.overwatch_target_marker_group_id);
    } else
      var_1.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_91BE0FB4CA199139F69BB2D158E4CECA8E", var_1, var_0, var_1);

    var_0.overwatch_target_marker_group_id = var_1.overwatch_target_marker_group_id;
  }
}

update_target_marker_group_id_on_ied(var_0, var_1) {
  if(!isDefined(var_0.target_marker_group_id_list))
    var_0.target_marker_group_id_list = [];

  if(!scripts\engine\utility::array_contains(var_0.target_marker_group_id_list, var_1))
    var_0.target_marker_group_id_list = scripts\engine\utility::array_add(var_0.target_marker_group_id_list, var_1);
}

move_cursor_near_identified_ied(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_96590FCA0FB41DFADE3B954EDD2C1D6C0D");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 100;
  var_2 = var_1 * var_1;
  var_3 = 1500;
  var_4 = var_3 * var_3;
  var_5 = var_0.overwatch_target_marker_group_id;
  var_6 = undefined;

  if(isDefined(var_5))
    var_6 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var_5);

  while(!isDefined(var_5) || !isDefined(var_6)) {
    var_5 = var_0.overwatch_target_marker_group_id;

    if(isDefined(var_5))
      var_6 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var_5);

    wait 0.1;
  }

  for(;;) {
    var_7 = var_0.overwatch_camera_point.origin;
    wait 0.1;
    var_8 = var_0.overwatch_camera_point.origin;

    if(distance2dsquared(var_7, var_8) > var_2) {
      for(var_9 = 0; var_9 < level.identified_ieds.size; var_9++) {
        if(distance2dsquared(level.identified_ieds[var_9].origin, var_8) < var_4) {
          var_10 = level.identified_ieds[var_9] getentitynumber();

          if(!isDefined(var_6.markedents[var_10])) {
            handle_identified_ied_to_overwatch_max(var_0);
            scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(level.identified_ieds[var_9], var_5);
          }
        }
      }
    }
  }
}

handle_identified_ied_to_overwatch_max(var_0) {
  var_1 = var_0.overwatch_target_marker_group_id;

  if(isDefined(var_1)) {
    var_2 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var_1);

    if(var_2.markedents.size > 18) {
      var_3 = var_0.overwatch_camera_point.origin;
      hide_farthest_targetmarker_for_player(var_3, var_1, level.identified_ieds);
    }
  }
}

hide_farthest_targetmarker_for_player(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var_1);
  var_4 = sortbydistance(var_2, var_0);
  var_5 = 1;

  for(var_6 = var_4.size - 1; var_6 > 0; var_6--) {
    if(!var_5) {
      break;
    }

    if(isent(var_4[var_6])) {
      var_7 = var_4[var_6] getentitynumber();

      if(isDefined(var_3.markedents[var_7])) {
        scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_4[var_6], var_1);
        var_5 = 0;
      }
    }
  }
}

show_identified_ied_to_non_overwatch(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.origin))
    var_0 hudoutlineenable("_encstr_8C0316DEABE836A5DCB299B436D8FA19590EE8347DE4B246");
}

show_non_overwatch_ied_marker_vfx_to_player(var_0, var_1) {
  if(!isDefined(var_1.ied_marker_vfxs_non_overwatch))
    var_1.ied_marker_vfxs_non_overwatch = [];

  var_2 = spawnfxforclient(level._effect["_encstr_84FF1C39FB51A1CFCFCB3AC2D308636531058796B760B3D76E8392DBD9FB"], var_0.origin, var_1);
  triggerfx(var_2);
  var_1.ied_marker_vfxs_non_overwatch[var_1.ied_marker_vfxs_non_overwatch.size] = var_2;
  var_0.ied_marker_vfxs_non_overwatch[var_0.ied_marker_vfxs_non_overwatch.size] = var_2;
}

delete_non_overwatch_ied_marker_vfx_for_player(var_0) {
  if(!isDefined(var_0.ied_marker_vfxs_non_overwatch)) {
    return;
  }
  foreach(var_2 in var_0.ied_marker_vfxs_non_overwatch) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

show_all_non_overwatch_ied_marker_vfx_to_player(var_0) {
  foreach(var_2 in level.identified_ieds)
  show_non_overwatch_ied_marker_vfx_to_player(var_2, var_0);
}

hide_ied_zone_from_player(var_0) {
  if(isDefined(var_0.overwatch_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_0.overwatch_target_marker_group_id);
    var_0.overwatch_target_marker_group_id = undefined;
  }
}

add_to_unidentified_ieds_list(var_0) {
  if(!scripts\engine\utility::array_contains(level.unidentified_ieds, var_0))
    level.unidentified_ieds = scripts\engine\utility::array_add(level.unidentified_ieds, var_0);
}

remove_from_unidentified_ieds_list(var_0) {
  level.unidentified_ieds = scripts\engine\utility::array_remove(level.unidentified_ieds, var_0);
}

add_to_identified_ieds_list(var_0) {
  if(!scripts\engine\utility::array_contains(level.identified_ieds, var_0))
    level.identified_ieds = scripts\engine\utility::array_add(level.identified_ieds, var_0);
}

is_ied_identified(var_0) {
  return scripts\engine\utility::array_contains(level.identified_ieds, var_0);
}

remove_from_identified_ieds_list(var_0) {
  level.identified_ieds = scripts\engine\utility::array_remove(level.identified_ieds, var_0);
}

hostage_near_vehicle_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_916E1DFB61F092EFA37093EB990C5F01503B6879E7501F27D9687A224350CB");

  for(;;) {
    level waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB", var_0);

    while(!isDefined(level.vehicle_travel_array))
      wait 1;

    var_0 thread carried_hostage_near_vehicle_monitor(var_0);
  }
}

carried_hostage_near_vehicle_monitor(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_87681634BDB91DB03B95FA19E4B7E0E0AC19FAC4F2F5B5B2");
  var_0 endon("_encstr_884A10329CDEE0C1AC91D7D07B37D1C29DB2");

  for(;;) {
    var_1 = get_closest_vehicle_within_range(var_0, 200);

    if(isDefined(var_1)) {
      if(has_hostage_on_board(var_1)) {
        var_0.hostage_drop_override_data = undefined;
        var_0.hostagecarried.overridehintstring = undefined;
      } else {
        var_2 = get_closest_vehicle_door_available(var_0, var_1);
        var_3 = var_1 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
        var_4 = var_1.angles;
        var_5 = anglesToForward(var_4);
        var_6 = anglestoright(var_4);
        var_7 = anglestoup(var_4);
        var_8 = var_3 + var_5 * -92 + var_6 * 0 + var_7 * 50;
        var_9 = distance(var_0.origin, var_8) < 100;

        if(var_9) {
          var_0.hostage_drop_override_data = make_hostage_drop_override_data(var_1, var_2, var_0);
          var_0.hostagecarried.overridehintstring = "_encstr_9A9B1B477D5B97B539F44DE914073A508F18D1505097A44A90406F30A7";
        } else {
          var_0.hostage_drop_override_data = undefined;
          var_0.hostagecarried.overridehintstring = undefined;
        }
      }
    } else
      var_0.hostage_drop_override_data = undefined;

    waitframe();
  }
}

get_closest_vehicle_door_available(var_0, var_1) {
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_8CF00A181FEBFB5B6A5FCD4E", "_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698", "_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B"];
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = get_vehicle_interaction_point(var_1, var_5);

    if(istrue(var_6.being_used)) {
      continue;
    }
    var_3[var_3.size] = var_6;
  }

  if(var_3.size > 0)
    return scripts\engine\utility::getclosest(var_0.origin, var_3);
  else
    return undefined;
}

get_closest_vehicle_within_range(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 100;

  var_2 = scripts\engine\utility::getclosest(var_0.origin, level.vehicle_travel_array, var_1);
  return var_2;
}

make_hostage_drop_override_data(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = -60;
  var_6 = anglesToForward(var_0.angles);
  var_7 = anglestoup(var_0.angles);
  var_8 = anglestoright(var_0.angles);
  var_9 = spawnStruct();
  var_9.vehicle = var_0;
  var_9.vehicle_door_interaction = var_1;
  var_9.player = var_2;
  var_9.position = var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37") + var_6 * var_5 + var_7 * var_3 + var_8 * var_4;
  var_9.waittime = 0.05;
  var_9.forcepos = 1;
  var_9.preventuse = 0;
  var_9.call_back_func = ::hostage_drop_call_back_func;
  return var_9;
}

hostage_drop_call_back_func(var_0, var_1) {
  var_2 = var_1.vehicle_door_interaction;
  var_3 = var_1.player;
  var_4 = var_1.vehicle;
  var_3 scripts\cp\utility::hint_prompt("_encstr_9A9B1B477D5B97B539F44DE914073A508F18D1505097A44A90406F30A7", 0);
  var_0 makeunusable();
  var_0.angles = (var_0.angles[0], var_4.angles[1] + 180, var_0.angles[2]);
  var_0 linkTo(var_4);

  if(isDefined(var_0.waypoint))
    objective_delete(var_0.waypoint);

  var_4.hostage = var_0;
  var_0.carried_by_vehicle = 1;
  var_0 notify("_encstr_B46B1B4BD0D1AF37F928BB4ABB9FB7F83119F8AF96BEA58FA15477A963");
  wait 2;
  enable_vehicle_interaction(var_4, "_encstr_88FE111A736CFBB8871823FF0B605F3B922987");
}

has_hostage_on_board(var_0) {
  return isDefined(var_0.hostage);
}

tread_vfx_think(var_0) {
  if(!tread_vfx_set_up(var_0)) {
    return;
  }
  foreach(var_2 in var_0.tread_vfx_tags)
  var_0 thread play_tread_vfx_think(var_0, var_2);
}

play_tread_vfx_think(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_2 = get_speed_type(var_0);

    if(should_play_tread_vfx(var_2)) {
      var_3 = get_tread_vfx(var_0, var_1, var_2);

      if(isDefined(var_3))
        play_new_tread_vfx(var_0, var_1, var_3);
    }

    wait 0.1;
  }
}

get_tread_vfx(var_0, var_1, var_2) {
  var_3 = var_0 gettagorigin(var_1);
  var_4 = scripts\engine\trace::ray_trace(var_3 + (0, 0, 20), var_3 + (0, 0, -50), var_0, undefined, 1);

  if(var_4["_encstr_A53009A25003666B9818C6"] == 1)
    return undefined;

  var_5 = spawnStruct();
  var_6 = filter_surface_type(var_4["_encstr_8BCA0C2BFD504F333E6D7513637B"], var_2, var_0);
  var_5.surface_speed_index = var_6 + "_encstr_BA4C02DF" + var_2;
  var_5.contact_pos = var_4["_encstr_BD260953AA97E3F014279D"];
  return var_5;
}

filter_surface_type(var_0, var_1, var_2) {
  var_3 = var_0 + "_encstr_BA4C02DF" + var_1;
  var_4 = var_2 scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(level.vehicle.templates.surface_effects[var_4][var_3]))
    return var_0;
  else
    return "_encstr_8B1608EC43B8D647A113";
}

should_play_tread_vfx(var_0) {
  if(var_0 == "_encstr_B419059BD17BE0")
    return 0;

  return 1;
}

get_speed_type(var_0, var_1) {
  var_2 = var_0.slow_tread_vfx_trigger_speed;
  var_3 = var_0.fast_tread_vfx_trigger_speed;
  var_1 = var_0 vehicle_getspeed();

  if(var_1 < var_2)
    return "_encstr_B419059BD17BE0";
  else if(var_1 >= var_2 && var_1 < var_3)
    return "_encstr_A11805E663B7BB";
  else
    return "_encstr_8F7905C4AEC319";
}

play_new_tread_vfx(var_0, var_1, var_2) {
  var_3 = var_0 vehicle_getvelocity();
  var_4 = var_0 scripts\common\vehicle_code::get_vehicle_classname();
  var_5 = var_0 gettagorigin(var_1);
  playFX(level.vehicle.templates.surface_effects[var_4][var_2.surface_speed_index], var_2.contact_pos, var_3);
}

tread_vfx_set_up(var_0) {
  var_1 = var_0 scripts\common\vehicle_code::get_vehicle_classname();
  return isDefined(level.vehicle.templates.surface_effects[var_1]);
}

load_fx() {
  level._effect["_encstr_84FF1C39FB51A1CFCFCB3AC2D308636531058796B760B3D76E8392DBD9FB"] = loadfx("_encstr_82AB33C3919877C2F4393FB7D1B0DA75B059FD1DA930FFAA4EDF87D7FD4A16BE9882B91501988392A6C79BBFE9639AEC78E06B5F9A");
  level._effect["_encstr_9BCB0E77AFB9B0A020BBE8C843111763"] = loadfx("_encstr_ACFD2E1B4889BDD7837B3F3B77A08B77CD38C206F8316923DBD01B290E70BE7B0568793A88C91D5F5623152C083B5380");
  level._effect["_encstr_83160F59712D072EB9CFD96BC75F319E78"] = loadfx("_encstr_91C6359DCC3CE54BEE70D7B138E5B195CE95B1CB6C0EBEC427D7E62F27B5E59D66C37D199CDECD56BE390B8C164ED707B4B9EC71CE99F0");
  level._effect["_encstr_9AD613D1351DEF174BE04B2291818D87101549664D"] = loadfx("_encstr_95C2354E043A8E74C7E2E922885FED7F137DAC9F2E8307FEB5C1139B600F757B495B1745B7AB6FC79DA94A12B857DF272348A38E54F1EB");
  level._effect["_encstr_99211FEC59A15AD81B95EBD1D2C9B2BE91C25B58B3957D9BD67BB6CABE1B59991D"] = loadfx("_encstr_8EED382DA6A0C2036F2F4EF193364958FB3D91674B0AF9DE1331C3BA5BCFD09897886F79F13540949729DB209297BD192AFD85F59D5AE264B373");
  level._effect["_encstr_AF892050E7D3CB3FC949E70310F2B9CFD06E8D78840DB75F315F47D5D19B03B00D83"] = loadfx("_encstr_A9EA4393B42B1821C7A0A7F7D89F68ADC3613C40EF21679ADBE9339BEB50AE73C089AF0A762F53CF99A1472120CF11A6256DF5BB8FAE4E732B04C89889E00C339D565C66D3");
  level._effect["_encstr_A7B01AD5AFBA8B582417BE50BD1F5828D2276B034FB258904DED20C9"] = loadfx("_encstr_9367363B33C397B4DD0E7D6C385EB195675636791BE0F5264EBEB92FC9DA97D9CC0FFA46C2B6C2D959AFB9DAED5BB2FA0DBDEDC8C5ECCCC3");
  level._effect["_encstr_A2630EB65AC209DA83AF7A1DA0B3AA18"] = loadfx("_encstr_8D7635A6CB7095CB239B392018F2D48774C08B20CA153E2840FBC9CA5F787883F4AFE141F76ABAF10AC3FFDB6E42B86AAB8A32E264D503");
  level._effect["_encstr_930A19BF0A2B38D6FF91F0787B8F8348474FE12F8419A89E076A08"] = loadfx("_encstr_82BF382B7F90925B831ABFD3D3EE92782C5533E3E2F5A8023E3B35E1577266D0F16A791E0A4A704DB21B2FFD3F3AAB409CC52350758E627C1A53");
  level._effect["_encstr_8A0E1883388BB7FD51FA4B93E83B9664218331B23F12515DDA63"] = loadfx("_encstr_B41B3AB399C35E4BDD0E79B15667591BCB194EED3795BCD9CCE1FA469CCDEB342B1BD8994B39B2BEACC3831BDE372DBDB97D0B5AC97D0C26E2B3663C");
  level._effect["_encstr_AA0116484FB9DB1BEB11090372934B8DE50F08588B5BB1ED"] = loadfx("_encstr_86042E23C8F22F92E713C1C61F6F1B297840CE5BA0AAE7EB2B47127F06E7A2F9C3504FBB2BA61D825D6A5FB2406DCAA0");
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_vehicle_repair_anims() {
  level.scr_animtree["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"] = #animtree;
  level.scr_anim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_BEEC12EC4B08C7DF9E01B3AAE8F6A73A50C36254"] = % _encstr_8DEF153EEC4366578A69A3E093E705F803AF463541FBCB;
  level.scr_animname["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_BEEC12EC4B08C7DF9E01B3AAE8F6A73A50C36254"] = "_encstr_8DEF153EEC4366578A69A3E093E705F803AF463541FBCB";
  level.scr_eventanim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_BEEC12EC4B08C7DF9E01B3AAE8F6A73A50C36254"] = "_encstr_ADB50A3D4FDB6FA89A39D830";
  scripts\common\anim::addnotetrack_customfunction("_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9", "_encstr_843D230705FB31B3A078797E9369FA2A57A3F78B8F259A8AC826EF050B4022C124276B2F6B", ::_id_13B9F);
  scripts\common\anim::addnotetrack_customfunction("_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9", "_encstr_938C211A09C39F8B066DD72F7920A31DE87114A2C6B861D36D77373F65C87B4418BBCB", ::_id_13B9D);
  level.scr_anim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_A9AF1147D2C9B2FA4EB283165AE47D1BF6B707"] = % _encstr_A66714F02AF2CF19BBDFBD3BEA37616BD8218088F20A;
  level.scr_animname["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_A9AF1147D2C9B2FA4EB283165AE47D1BF6B707"] = "_encstr_A66714F02AF2CF19BBDFBD3BEA37616BD8218088F20A";
  level.scr_eventanim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_A9AF1147D2C9B2FA4EB283165AE47D1BF6B707"] = "_encstr_ADB50A3D4FDB6FA89A3978F3";
  level.scr_anim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_A34B11130A53256912ED61BB19FAA1F693C22B"] = % _encstr_9A681302E42B2788236965E3BB0F3152D38FBD5804;
  level.scr_animname["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_A34B11130A53256912ED61BB19FAA1F693C22B"] = "_encstr_9A681302E42B2788236965E3BB0F3152D38FBD5804";
  level.scr_eventanim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_A34B11130A53256912ED61BB19FAA1F693C22B"] = "_encstr_A92B0B6A4519EA694BF1AFCF80";
  scripts\common\anim::addnotetrack_customfunction("_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9", "_encstr_991E20E699E1D7DCD8B9EB8DE07D39CAC1C25A9CAFD1A59356FA16D2E4D7DCD1DB07", ::_id_13B9E);
  scripts\common\anim::addnotetrack_customfunction("_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9", "_encstr_9B01220F7CE8E72AE34856EFC157E0A22A5F39EBE84BDFB8B8786D4852DB66F2924977C0", ::_id_13BA0);
  level.scr_anim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_B457138E200F4F3C83A74ACB187B1B9F779B30124C"] = % _encstr_A1BE1BD807D7E61B275A071D5923AF66D23C23AC8D86DBFAAC9BD195E4;
  level.scr_animname["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_B457138E200F4F3C83A74ACB187B1B9F779B30124C"] = "_encstr_A1BE1BD807D7E61B275A071D5923AF66D23C23AC8D86DBFAAC9BD195E4";
  level.scr_eventanim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_B457138E200F4F3C83A74ACB187B1B9F779B30124C"] = "_encstr_BD5A18D3682920BAEF6E077ADFABA3CF90D0075B21416E53E306";
  scripts\common\anim::addnotetrack_customfunction("_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9", "_encstr_AC6625F07A53D7EAE77D195AC79FAB87D7CE38C3E611852CA36ABB89CBEDF9EF0B5FB008F9D303", ::_id_12C30);
  level.scr_anim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_99B7124AF3B866E77EA6227B4859CB510849DFB0"] = % _encstr_84FE1A139189AAF746A88BD33195CF2780298C9DCF58F53FE56212DB;
  level.scr_animname["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_99B7124AF3B866E77EA6227B4859CB510849DFB0"] = "_encstr_84FE1A139189AAF746A88BD33195CF2780298C9DCF58F53FE56212DB";
  level.scr_eventanim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_99B7124AF3B866E77EA6227B4859CB510849DFB0"] = "_encstr_B2E41708BF4B28FFE98ABD3FA6620D36B87FC880EFE5628B03";
  scripts\common\anim::addnotetrack_customfunction("_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9", "_encstr_8E98249B2528393F4630F13A1BB0E36FC09309023FB83D277B28AAE1817BC7636175B794D3F0", ::_id_12C31);
  level.scr_anim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_A74A0D62DB904EBF26CE5A131071E3"] = % _encstr_B4221A171876D3924D1BAAA37519298ED8C083B72848379953A5B59F;
  level.scr_animname["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_A74A0D62DB904EBF26CE5A131071E3"] = "_encstr_B4221A171876D3924D1BAAA37519298ED8C083B72848379953A5B59F";
  level.scr_eventanim["_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9"]["_encstr_A74A0D62DB904EBF26CE5A131071E3"] = "_encstr_A607172AC1DED3AD8165EDE05BE832C7F33812B2EEA3BB2578";
  scripts\common\anim::addnotetrack_customfunction("_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9", "_encstr_A31325DB744AE1F386ABFFD98399E32127D2932B20E96BB70BB0D81F7F60E3C0A8E22F85CF383C", ::_id_12C2E);
  scripts\common\anim::addnotetrack_customfunction("_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9", "_encstr_AC99263B53A8C93621FE394FA3BFD61FE340BC33DFD5B0DFEC78F3591BA0F2390ABFA8DE5BC02034", ::_id_12C2F);
}

_id_13B9F(var_0) {
  var_0 playsoundonmovingent("_encstr_A5641FE68D73D7C607F52756C1C24B4E7D8E4B93AC7D2BDCE8CA39FA33BD63B2BC");
}

_id_13B9D(var_0) {
  var_0 playsoundonmovingent("_encstr_8CEA1D3FBB4D297E0B31F319AB272318A904B3B525F910B33B29AB2382B365");
}

_id_13B9E(var_0) {
  var_0 playsoundonmovingent("_encstr_95A01CBFB758990BE0B6CA174B305903B8E15F231368A2C9189E825BC090");
}

_id_13BA0(var_0) {
  var_0 playsoundonmovingent("_encstr_84DD1E430E9AF93A6FF1C35BE3A028CBE680DB3DFABFE253A10D87FAEA55ED9A");
}

_id_12C30(var_0) {
  var_0 playsoundonmovingent("_encstr_822B21B673ABFEDF02D1B8183B1E8313171DB024C103615FAFEA801073B94548738543");
}

_id_12C31(var_0) {
  var_0 playsoundonmovingent("_encstr_B450200AB9A08FFAFF7F7327492F02FA81C1C59710587DF15D29677B2F44AA2C082A");
}

_id_12C2E(var_0) {
  var_0 playsoundonmovingent("_encstr_920A2163BEC077DEE101D3BA601B940B5E15F6EFC3A8C7E9E5587B72B87F41CBB00847");
}

_id_12C2F(var_0) {
  var_0 playsoundonmovingent("_encstr_9301226FB868F79A5118229FF71B72821620A3B770800581452BA894D0CFE94B58085B63");
}

do_vehicle_repair_animation(var_0, var_1, var_2) {
  var_3 = var_1.origin;
  var_4 = var_1.angles;
  var_5 = get_tag_anim_offset(var_2, var_0);
  var_6 = getgroundposition(var_5.animorg, 2, 100, 24);
  var_7 = var_5.animang;
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
  var_8.origin = var_6;
  var_8.angles = var_7;
  var_1 setOrigin(var_6, 1);
  var_1 setplayerangles(var_7);
  var_1 setstance("_encstr_A5AD069B231F0BAF");
  var_1 disableweapons();
  var_1 forceusehinton(&"_encstr_911919735121AB27B4F9E780FDE99457F535EF7128A17D29290F59");
  spawn_can(var_1);
  var_1 thread do_vehicle_repair_animation_actual(var_0, var_1, var_8);
  var_9 = wait_for_repair_done(var_0, var_1, var_8);
  remove_can(var_1);
  waitframe();
  var_1 stoploopsound("_encstr_931F1AA6C6FAA779607790D03389F03531AB13AEDF81A3604A5F6870");
  var_8 delete();
  scripts\cp\cp_destruction::remove_player_rig(var_1);
  var_1 forceusehintoff();
  var_1 setplayerangles(var_4);
  var_1 setstance("_encstr_A5AD069B231F0BAF");
  var_1 cameradefault();
  var_1 enableweapons();
  var_1 setOrigin(var_3, 1);

  if(istrue(var_9))
    return 1;

  return 0;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

do_vehicle_repair_animation_actual(var_0, var_1, var_2) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_9BCB0E9B2F18AFC0A25EB8CFE214034B");
  var_3 = getanimlength(%_encstr_8DEF153EEC4366578A69A3E093E705F803AF463541FBCB);
  var_4 = getanimlength(%_encstr_A66714F02AF2CF19BBDFBD3BEA37616BD8218088F20A);
  var_5 = getanimlength(%_encstr_9A681302E42B2788236965E3BB0F3152D38FBD5804);
  var_6 = var_3 - 0.1;
  var_7 = var_4 - 0.1;
  var_1 thread scripts\cp\cp_destruction::create_player_rig(var_1, "_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9");
  var_1 cameraset("_encstr_B8CB169FD3B95A7A08162EB38B78BF1218775303AB5DA172");
  var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_BEEC12EC4B08C7DF9E01B3AAE8F6A73A50C36254");
  wait(var_6);
  var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_A9AF1147D2C9B2FA4EB283165AE47D1BF6B707");
  var_1 playLoopSound("_encstr_931F1AA6C6FAA779607790D03389F03531AB13AEDF81A3604A5F6870");
  wait(var_7 / 10);

  if(!scripts\cp\cp_laststand::player_in_laststand(var_1)) {
    var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_A34B11130A53256912ED61BB19FAA1F693C22B");
    wait 1;
    var_1.can hide();
    wait(var_5 - 1);
  }
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

do_hood_repair_animation_actual(var_0, var_1, var_2) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_9BCB0E9B2F18AFC0A25EB8CFE214034B");
  var_3 = getanimlength(%_encstr_A1BE1BD807D7E61B275A071D5923AF66D23C23AC8D86DBFAAC9BD195E4);
  var_4 = getanimlength(%_encstr_B4221A171876D3924D1BAAA37519298ED8C083B72848379953A5B59F);
  var_5 = getanimlength(%_encstr_84FE1A139189AAF746A88BD33195CF2780298C9DCF58F53FE56212DB);
  var_6 = var_3;
  var_7 = var_4;
  var_1 thread scripts\cp\cp_destruction::create_player_rig(var_1, "_encstr_AAB9103B561AEB39CAE0582D39F50EB15EC9");
  var_1 cameraset("_encstr_8ECB168D856BB2C9857D6C576E47ED6BBEB7C989D247EBC4");
  var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_B457138E200F4F3C83A74ACB187B1B9F779B30124C");
  wait(var_6);
  var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_A74A0D62DB904EBF26CE5A131071E3");
  wait(var_7);

  if(!scripts\cp\cp_laststand::player_in_laststand(var_1)) {
    var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_99B7124AF3B866E77EA6227B4859CB510849DFB0");
    wait(var_5);
  }
}

do_hood_repair_animation(var_0, var_1, var_2, var_3) {
  var_4 = var_1.origin;
  var_5 = var_1.angles;
  var_6 = get_tag_anim_offset(var_2, var_0);
  var_7 = var_0 gettagorigin("_encstr_958313D185CEEBDEC9B4CED2E6BE85DC4BD685E8CA");
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
  var_8.angles = var_0 gettagangles("_encstr_958313D185CEEBDEC9B4CED2E6BE85DC4BD685E8CA");
  var_1 setstance("_encstr_A5AD069B231F0BAF");
  var_1 disableweapons();
  var_1 forceusehinton(&"_encstr_911919735121AB27B4F9E780FDE99457F535EF7128A17D29290F59");
  var_1 thread do_hood_repair_animation_actual(var_0, var_1, var_8);
  var_9 = wait_for_hood_repair_done(var_0, var_1, var_8);
  var_8 delete();
  scripts\cp\cp_destruction::remove_player_rig(var_1);
  var_1 forceusehintoff();
  var_1 setplayerangles(var_5);
  var_1 setstance("_encstr_A5AD069B231F0BAF");
  var_1 cameradefault();
  var_1 enableweapons();
  var_1 setOrigin(var_4, 0);
  return var_9;
}

get_tag_anim_offset(var_0, var_1) {
  var_2 = var_1 gettagorigin(var_0);
  var_3 = var_1 gettagangles(var_0);
  var_4 = spawnStruct();
  var_4.origin = var_2;
  var_4.angles = var_3;
  var_4.animorg = var_2;
  var_4.animang = var_3;

  switch (var_0) {
    case "_encstr_95401B1D2C9DFA77D02B59C6D7C6B2DCE82B397D312C36ADAF8DB2CC47":
    case "_encstr_822E1C35718FFEF704722B50C99E9B90BB1DBE38CE73203DEBF940103273":
      var_4.animang = var_3 + (0, 180, 0);
      return var_4;
    case "_encstr_B8C91CC3D3BCF97F4051AFF50EC0B5228D6353F7BDD7622BD15BA43FC010":
    case "_encstr_84311D85A15F2E27D482F080192ECBC0CB4D0EE83EA3904DBB4940A07204D1":
      return var_4;
    case "_encstr_8AD00A6D0E22EFA13AE75850":
      var_4.animang = var_3 + (0, 180, 0);
      return var_4;
  }
}

spawn_can(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin("_encstr_97D713BBD1BFE0A996C869808715CA98BF331BF759"));
  var_1 setModel("_encstr_95A41827082BC77A6F8DE45B7D678299F2F19F5720610E81E907");
  var_1.angles = var_0 gettagangles("_encstr_97D713BBD1BFE0A996C869808715CA98BF331BF759");
  var_1 linkTo(var_0, "_encstr_97D713BBD1BFE0A996C869808715CA98BF331BF759");
  var_0.can = var_1;
}

remove_can(var_0) {
  if(isDefined(var_0.can))
    var_0.can delete();
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

wait_for_repair_done(var_0, var_1, var_2) {
  var_3 = getanimlength(%_encstr_8DEF153EEC4366578A69A3E093E705F803AF463541FBCB);
  var_4 = getanimlength(%_encstr_A66714F02AF2CF19BBDFBD3BEA37616BD8218088F20A);
  var_5 = getanimlength(%_encstr_9A681302E42B2788236965E3BB0F3152D38FBD5804);
  var_6 = var_3 - 0.1;
  var_7 = var_4 / 10 - 0.25;
  var_8 = var_5 - 0.1;
  var_9 = var_6 + var_7 + var_8;
  var_10 = var_0 scripts\cp\utility::player_lua_progressbar(var_1, var_9 * 1000, undefined, 12);

  if(!istrue(var_10))
    var_1 notify("_encstr_9BCB0E9B2F18AFC0A25EB8CFE214034B");

  var_1 stoploopsound("_encstr_931F1AA6C6FAA779607790D03389F03531AB13AEDF81A3604A5F6870");
  return var_10;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

wait_for_hood_repair_done(var_0, var_1, var_2) {
  var_3 = getanimlength(%_encstr_A1BE1BD807D7E61B275A071D5923AF66D23C23AC8D86DBFAAC9BD195E4);
  var_4 = getanimlength(%_encstr_B4221A171876D3924D1BAAA37519298ED8C083B72848379953A5B59F);
  var_5 = getanimlength(%_encstr_84FE1A139189AAF746A88BD33195CF2780298C9DCF58F53FE56212DB);
  var_6 = var_3;
  var_7 = var_4;
  var_8 = var_5;
  var_9 = var_6 + var_7 + var_8;
  var_10 = var_0 scripts\cp\utility::player_lua_progressbar(var_1, var_9 * 1000, undefined, 12);

  if(!istrue(var_10))
    var_1 notify("_encstr_9BCB0E9B2F18AFC0A25EB8CFE214034B");

  return var_10;
}

do_hood_repair_anims(var_0, var_1, var_2) {
  var_1 endon("_encstr_9BCB0E9B2F18AFC0A25EB8CFE214034B");
  var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_A74A0D62DB904EBF26CE5A131071E3");
}

fire_cruise_missile_toward(var_0, var_1) {
  var_2 = make_cruise_missile_target_ent(var_0, var_1);
  var_3 = make_cruise_missile(var_0, var_2);
  var_3 put_objective_icon_on_cruise_missile(var_3);
  var_3 add_to_cruise_missile_list(var_3);
  var_2 thread keep_following_target_while_remain_height(var_2, var_1, var_3);
  var_2 thread cruise_missile_target_ent_clean_up(var_2, var_3);
  var_3 thread cruise_missile_reach_target_ent_monitor(var_3, var_2, var_1);
  var_3 thread death_monitor(var_3, var_3.cruise_missile_objective_id, var_3 getentitynumber());
}

cruise_missile_reach_target_ent_monitor(var_0, var_1, var_2) {
  var_2 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(distancesquared(var_0.origin, var_1.origin) < 250000) {
      break;
    }

    var_3 = anglesToForward(var_0.angles);
    var_4 = vectorNormalize(var_1.origin - var_0.origin);

    if(vectordot(var_3, var_4) < 0) {
      break;
    }

    waitframe();
  }

  level thread fire_warhead_toward_target(var_0, var_2);
}

fire_warhead_toward_target(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 setscriptablepartstate("_encstr_99760C3BB425F90F7192E8070B20", "_encstr_BA19049F4B2D");
  var_0 setscriptablepartstate("_encstr_ACE90E9DC2D03A698D78D8DB1B8B72ED", "_encstr_BA19049F4B2D", 0);
  playFXOnTag(scripts\engine\utility::getfx("_encstr_930A19BF0A2B38D6FF91F0787B8F8348474FE12F8419A89E076A08"), var_0, "_encstr_91630C0C561F51EA516F0F610550");
  var_0 notify("_encstr_88E42283830863572F26E3C8BFFA614F8370D8E38098EF111F6ACB3386458F7EC4438725");
  var_2 = var_0.cruise_missile_objective_id;
  var_3 = var_0 getentitynumber();
  waitframe();
  var_4 = make_cruise_missile_warhead_target_ent(var_0);
  var_5 = make_cruise_missile_warhead(var_0, var_4);
  var_5.cruise_missile_objective_id = var_2;
  put_objective_icon_on_warhead(var_5, var_2);
  level.cruise_missiles = scripts\engine\utility::array_remove(level.cruise_missiles, var_0);

  if(isDefined(level.locked_on_cruise_missiles)) {
    level.locked_on_cruise_missiles = scripts\engine\utility::array_remove(level.locked_on_cruise_missiles, var_0);
    update_missile_lock_hud_for_missile_defense_player();
  }

  if(isDefined(var_0.interceptor_missile))
    set_interceptor_missile_target(var_0.interceptor_missile, var_5);

  var_0 delete();
  var_5 thread delay_target_cruise_missile_target(var_5, var_4, var_1);
  var_5 thread death_monitor(var_5, var_2, var_3);
}

update_missile_lock_hud_for_missile_defense_player() {
  var_0 = 0;

  foreach(var_2 in level.locked_on_cruise_missiles) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(istrue(var_2.being_intercepted)) {
      continue;
    }
    var_0++;
  }

  if(var_0 == 0) {
    var_4 = get_missile_defense_player();

    if(isDefined(var_4))
      var_4 setclientomnvar("_encstr_82EC1095EBB80302F8474BBD056859301BAF", 0);
  }
}

get_missile_defense_player() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.current_vehicle_seat) && (var_1.current_vehicle_seat == "_encstr_ADF31660AF7B6BD33AAF40D587B20370C3376910D70740D1" || var_1.current_vehicle_seat == "_encstr_B4AC15DDA818F3EA41BB17F3937C1256B0B1D9E541E8BC"))
      return var_1;
  }

  return undefined;
}

set_interceptor_missile_target(var_0, var_1) {
  var_0.target_anchor.origin = var_1.origin;
  var_0.target_anchor linkTo(var_1);
  var_0.target_entity = var_1;
}

put_objective_icon_on_warhead(var_0, var_1) {
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 0);
}

delay_target_cruise_missile_target(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 0.25;

  if(isDefined(var_2))
    var_0 missile_settargetEnt(var_2);

  var_1 delete();
}

add_to_cruise_missile_list(var_0) {
  if(!isDefined(level.cruise_missiles))
    level.cruise_missiles = [];

  level.cruise_missiles[level.cruise_missiles.size] = var_0;
}

death_monitor(var_0, var_1, var_2) {
  var_0 endon("_encstr_88E42283830863572F26E3C8BFFA614F8370D8E38098EF111F6ACB3386458F7EC4438725");
  var_0 waittill("_encstr_AD75063D571AE108");
  level.cruise_missiles = scripts\engine\utility::array_remove(level.cruise_missiles, var_0);

  if(isDefined(level.locked_on_cruise_missiles)) {
    level.locked_on_cruise_missiles = scripts\engine\utility::array_remove(level.locked_on_cruise_missiles, var_0);
    update_missile_lock_hud_for_missile_defense_player();
  }

  scripts\cp\cp_objectives::freeworldid("_encstr_B8981EB193EA2DE6CAD7B64B379B2D63B27DCAE63A963A5EBEE6ABADC4CA9CFA" + var_2);
  objective_delete(var_1);
}

put_objective_icon_on_cruise_missile(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_B8981EB193EA2DE6CAD7B64B379B2D63B27DCAE63A963A5EBEE6ABADC4CA9CFA" + var_0 getentitynumber(), 22);
  objective_state(var_1, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_icon(var_1, "_encstr_A59713306324B9F65AE38187CF024871FA7F5E8BCF");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 0);
  objective_removeallfrommask(var_1);
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_setshowdistance(var_1, 1);
  objective_setshowprogress(var_1, 1);
  objective_setfadedisabled(var_1, 1);
  var_0.cruise_missile_objective_id = var_1;
  make_visible_to_missile_defense_player(var_1);
}

make_visible_to_missile_defense_player(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2.current_vehicle_seat) && (var_2.current_vehicle_seat == "_encstr_ADF31660AF7B6BD33AAF40D587B20370C3376910D70740D1" || var_2.current_vehicle_seat == "_encstr_B4AC15DDA818F3EA41BB17F3937C1256B0B1D9E541E8BC"))
      objective_addclienttomask(var_0, var_2);
  }
}

cruise_missile_target_ent_clean_up(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

keep_following_target_while_remain_height(var_0, var_1, var_2) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 endon("_encstr_AD75063D571AE108");
  var_3 = var_0.origin[2];

  for(;;) {
    var_4 = var_2.origin - var_1.origin;
    var_4 = var_4 * (1, 1, 0);
    var_4 = vectorNormalize(var_4);
    var_5 = var_1.origin + var_4 * 7500;
    var_5 = (var_5[0], var_5[1], var_3);
    var_0.origin = var_5;
    waitframe();
  }
}

make_cruise_missile(var_0, var_1) {
  var_2 = magicbullet("_encstr_B61512EEC20B8B3B35372870FF5B30C9522156EF", var_0, var_1.origin);
  var_2 missile_settargetEnt(var_1);
  var_2 missile_setflightmodedirect();
  var_2 setscriptablepartstate("_encstr_ACE90E9DC2D03A698D78D8DB1B8B72ED", "_encstr_AB0703DBB9", 0);
  var_2 setscriptablepartstate("_encstr_99760C3BB425F90F7192E8070B20", "_encstr_AB0703DBB9");
  var_2.lock_on_progress = 0;
  return var_2;
}

make_cruise_missile_warhead(var_0, var_1) {
  var_2 = magicbullet("_encstr_96891AD839D54B6E95FADAD237B92DC695FADDB027D0CA1619AFB1E0", var_0 gettagorigin("_encstr_91630C0C561F51EA516F0F610550"), var_1.origin);
  var_2 missile_settargetEnt(var_1);
  var_2 missile_setflightmodedirect();
  var_2 setscriptablepartstate("_encstr_B4AE0D3757C4EBD1D0E4EADC8ECA27", "_encstr_AB0703DBB9", 0);
  var_2.lock_on_progress = 0;
  level.cruise_missiles = scripts\engine\utility::array_add(level.cruise_missiles, var_2);

  if(isDefined(level.locked_on_cruise_missiles) && scripts\engine\utility::array_contains(level.locked_on_cruise_missiles, var_0))
    level.locked_on_cruise_missiles = scripts\engine\utility::array_add(level.locked_on_cruise_missiles, var_2);

  return var_2;
}

make_cruise_missile_target_ent(var_0, var_1) {
  var_2 = var_0[2];
  var_3 = var_1.origin - var_0;
  var_3 = var_3 * (1, 1, 0);
  var_3 = vectorNormalize(var_3);
  var_4 = var_1.origin + var_3 * 7500;
  var_4 = (var_4[0], var_4[1], var_2);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  return var_5;
}

make_cruise_missile_warhead_target_ent(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = var_0.origin + var_1 * 10000;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  return var_3;
}

make_reaper_drone(var_0) {
  var_1 = anglestoright(var_0.angles);
  var_2 = var_0.origin + var_1 * 10000 + (0, 0, 10000);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_3 setModel("_encstr_857B16BB48685099ABC365513F4B83EF10400F7FE8A143A7");
  var_3.angles = var_0.angles;
  var_3 thread clean_up_on_vehicle_death(var_3, var_0);
  var_3 thread keep_circling_around_vehicle(var_0, var_3);
  var_3.missile_defense_camera_anchor = create_missile_defense_camera_anchor(var_0, var_3);
  var_3.scanning_camera_anchor = create_scanning_camera_anchor(var_0, var_3);
  var_0.reaper = var_3;
  return var_3;
}

keep_circling_around_vehicle(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  var_1 linkTo(var_2, "_encstr_8E010B996FB7B6B3C1D1183343");
  var_2 thread keep_rotating(var_2);
  var_2 thread keep_following_vehicle(var_2, var_0);
  var_2 thread clean_up_on_vehicle_death(var_2, var_0);
}

keep_rotating(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 rotateYaw(360, 180);
    wait 180;
  }
}

keep_following_vehicle(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  wait 2;

  for(;;) {
    var_2 = (var_1.origin[0], var_1.origin[1], var_0.origin[2]);
    var_3 = distance2d(var_0.origin, var_2);
    var_4 = var_3 / get_rotation_anchor_move_speed(var_3);

    if(var_3 <= 10) {
      waitframe();
      continue;
    }

    if(var_3 <= 100) {
      var_0 moveTo(var_2, var_4, 0, var_4);
      waitframe();
      continue;
    }

    var_0 moveTo(var_2, var_4);
    var_0 scripts\engine\utility::_id_143B9(var_4, "_encstr_9B420907FD535DAC6DF285");
  }
}

get_rotation_anchor_move_speed(var_0) {
  if(var_0 <= 150)
    return 500;
  else
    return 1000;
}

create_missile_defense_camera_anchor(var_0, var_1) {
  var_2 = anglesToForward(var_1.angles);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin + var_2 * 170 + (0, 0, -140));
  var_3 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  var_3.angles = vectortoangles((0, 0, -1));
  var_3 linkTo(var_1);
  var_3 thread clean_up_on_vehicle_death(var_3, var_0);
  return var_3;
}

create_scanning_camera_anchor(var_0, var_1) {
  var_2 = anglesToForward(var_1.angles);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin + var_2 * 0 + (0, 0, -140));
  var_3 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  var_3.angles = vectortoangles(var_0.origin - var_3.origin);
  var_3 linkTo(var_1);
  var_3 thread clean_up_on_vehicle_death(var_3, var_0);
  var_3 thread keep_focus_on_vehicle(var_3, var_0);
  return var_3;
}

keep_focus_on_vehicle(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0.angles = vectortoangles(var_1.origin - var_0.origin);
    waitframe();
  }
}

get_humvee_info(var_0) {
  var_1 = spawnStruct();
  var_1.model = "_encstr_8F741BC3F11860A1FE9B9B47E9105A4F20593ECC2849D2DA46ABFB4F7D";
  var_1.vehicle_gdt = "_encstr_AF75110CB599395A5F5B13635BC099FBB746F8";
  var_1.add_additional_parts_func = ::humvee_add_additional_parts_func;
  var_1.ied_triggering_tags = ["_encstr_A6B41463B859E7CB117597CD702DE26360E19BAF78D3", "_encstr_958A15D158CEAFDDA159CA8DFA33C9BDB9A3D71B566647", "_encstr_838D158DEEC20F43C037B0F0F7E259AFEA99069BC78A11", "_encstr_932416D159EFC9948B72B198F99BCE9045A47F55C957385D"];
  var_1.fake_health = 750;
  var_1.show_damage_state_health_ratio = 0.3;
  var_1.classname_mp = "_encstr_A1710F4327F68B4FD748F2096023464748";
  var_1.slow_tread_vfx_trigger_speed = 1;
  var_1.fast_tread_vfx_trigger_speed = 20;
  var_1.tread_vfx_tags = ["_encstr_838D158DEEC20F43C037B0F0F7E259AFEA99069BC78A11", "_encstr_A6B41463B859E7CB117597CD702DE26360E19BAF78D3", "_encstr_932416D159EFC9948B72B198F99BCE9045A47F55C957385D", "_encstr_958A15D158CEAFDDA159CA8DFA33C9BDB9A3D71B566647"];
  var_1._id_128C0 = ["_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1"];
  var_2 = [];
  var_2["_encstr_A6B41463B859E7CB117597CD702DE26360E19BAF78D3"] = "_encstr_95401B1D2C9DFA77D02B59C6D7C6B2DCE82B397D312C36ADAF8DB2CC47";
  var_2["_encstr_958A15D158CEAFDDA159CA8DFA33C9BDB9A3D71B566647"] = "_encstr_822E1C35718FFEF704722B50C99E9B90BB1DBE38CE73203DEBF940103273";
  var_2["_encstr_838D158DEEC20F43C037B0F0F7E259AFEA99069BC78A11"] = "_encstr_B8C91CC3D3BCF97F4051AFF50EC0B5228D6353F7BDD7622BD15BA43FC010";
  var_2["_encstr_932416D159EFC9948B72B198F99BCE9045A47F55C957385D"] = "_encstr_84311D85A15F2E27D482F080192ECBC0CB4D0EE83EA3904DBB4940A07204D1";
  var_1.ied_triggering_tag_to_repair_tag_mapping = var_2;
  var_3 = [];
  var_3 = assign_vehicle_interaction("_encstr_9AE307B956E345D0AB", 14, -38, 44.3, var_3);
  var_3 = assign_vehicle_interaction("_encstr_8CF00A181FEBFB5B6A5FCD4E", 14, 38, 44.3, var_3);
  var_3 = assign_vehicle_interaction("_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698", -22.5, -38, 44.3, var_3);
  var_3 = assign_vehicle_interaction("_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B", -22.5, 38, 44.3, var_3);
  var_3 = assign_vehicle_interaction("_encstr_8D48079DD59BE65627", -6, 0, 83, var_3);
  var_3 = assign_vehicle_interaction("_encstr_838910DD3CC32B6739B8AF8BC9732122B155", -5, 19, 68, var_3);
  var_3 = assign_vehicle_interaction("_encstr_9BA00F277525B3E7800BA66C86633D2A05", -5, -19, 68, var_3);
  var_3 = assign_vehicle_interaction("_encstr_92651150529E9FA6E33D6C5D2FB32971C63A28", -48.8, -39, 19.9, var_3);
  var_3 = assign_vehicle_interaction("_encstr_B6B91289161BD6AF9CD23B1A8EFA4E2B382CD2E4", -48.8, 39, 17.5, var_3);
  var_3 = assign_vehicle_interaction("_encstr_81EF129927BD73D1D71B956647D74ECA0E2CD2E4", 74, -39, 17, var_3);
  var_3 = assign_vehicle_interaction("_encstr_ADE513BDDB5F2DA459FBFB7F1AA4C7C23B6A499F6B", 74, 39, 17.5, var_3);
  var_3 = assign_vehicle_interaction("_encstr_B4610CAA50F73F5F53A560694BBB", 105, 0, 42.5, var_3);
  var_3 = assign_vehicle_interaction("_encstr_AFA81237E3D0C6E3307D07135341AA3F58E86DFD", 32, 19, 52, var_3);
  var_3 = assign_vehicle_interaction("_encstr_861B171385B1ADAFE4D2ECD03ABE939533963663BE58B6DAED", -5, 19, 55, var_3);
  var_3 = assign_vehicle_interaction("_encstr_AF4816130BD8D6D7C695CCA37D395933A5D8C6EB586BB5DB", -5, -19, 55, var_3);
  var_3 = assign_vehicle_interaction("_encstr_88FE111A736CFBB8871823FF0B605F3B922987", -92, 0, 50, var_3);
  var_1.interaction_setups_array = var_3;
  return var_1;
}

humvee_add_additional_parts_func(var_0) {
  add_gunner_turret(var_0);
}

add_gunner_turret(var_0) {
  var_1 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1"), "_encstr_B29611E09732D6F763B5882D4F3AD118B75748", 0);
  var_1.angles = var_0.angles;
  var_1.team = "_encstr_9A8507BA4040188D08";
  var_1 linkTo(var_0);
  var_1 setModel("_encstr_8EFF2576CB400877BE387BD1A037D39978A31BE047512247D651D2D9E8EC070DC86F9871D9486C");
  var_1 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_1 setsentryowner(undefined);
  var_1 makeunusable();
  var_1 setdefaultdroppitch(0);
  var_1 setturretmodechangewait(1);
  var_0.gunner_turret = var_1;
  var_0.gunner_weapon = "_encstr_B29611E09732D6F763B5882D4F3AD118B75748";
  var_1 thread clean_up_on_vehicle_death(var_1, var_0);
}

get_friendly_hvi_vehicle_info(var_0) {
  var_1 = spawnStruct();
  var_1.model = "_encstr_8F741BC3F11860A1FE9B9B47E9105A4F20593ECC2849D2DA46ABFB4F7D";
  var_1.vehicle_gdt = "_encstr_AF75110CB599395A5F5B13635BC099FBB746F8";
  var_1.add_additional_parts_func = ::friendly_hvi_vehicle_add_additional_parts_func;
  var_1.ied_triggering_tags = ["_encstr_A6B41463B859E7CB117597CD702DE26360E19BAF78D3", "_encstr_958A15D158CEAFDDA159CA8DFA33C9BDB9A3D71B566647", "_encstr_838D158DEEC20F43C037B0F0F7E259AFEA99069BC78A11", "_encstr_932416D159EFC9948B72B198F99BCE9045A47F55C957385D"];
  var_1.fake_health = 5000;
  var_1.show_damage_state_health_ratio = 0.3;
  var_1.classname_mp = "_encstr_A1710F4327F68B4FD748F2096023464748";
  var_1.slow_tread_vfx_trigger_speed = 1;
  var_1.fast_tread_vfx_trigger_speed = 20;
  var_1.tread_vfx_tags = ["_encstr_838D158DEEC20F43C037B0F0F7E259AFEA99069BC78A11", "_encstr_A6B41463B859E7CB117597CD702DE26360E19BAF78D3", "_encstr_932416D159EFC9948B72B198F99BCE9045A47F55C957385D", "_encstr_958A15D158CEAFDDA159CA8DFA33C9BDB9A3D71B566647"];
  var_1._id_128C0 = ["_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1"];
  var_2 = [];
  var_2["_encstr_A6B41463B859E7CB117597CD702DE26360E19BAF78D3"] = "_encstr_95401B1D2C9DFA77D02B59C6D7C6B2DCE82B397D312C36ADAF8DB2CC47";
  var_2["_encstr_958A15D158CEAFDDA159CA8DFA33C9BDB9A3D71B566647"] = "_encstr_822E1C35718FFEF704722B50C99E9B90BB1DBE38CE73203DEBF940103273";
  var_2["_encstr_838D158DEEC20F43C037B0F0F7E259AFEA99069BC78A11"] = "_encstr_B8C91CC3D3BCF97F4051AFF50EC0B5228D6353F7BDD7622BD15BA43FC010";
  var_2["_encstr_932416D159EFC9948B72B198F99BCE9045A47F55C957385D"] = "_encstr_84311D85A15F2E27D482F080192ECBC0CB4D0EE83EA3904DBB4940A07204D1";
  var_1.ied_triggering_tag_to_repair_tag_mapping = var_2;
  var_3 = [];
  var_3 = assign_vehicle_interaction("_encstr_9AE307B956E345D0AB", 14, -38, 44.3, var_3);
  var_3 = assign_vehicle_interaction("_encstr_8CF00A181FEBFB5B6A5FCD4E", 14, 38, 44.3, var_3);
  var_3 = assign_vehicle_interaction("_encstr_97280F8C2BD0FB97DED9CAB2E6AEB77698", -22.5, -38, 44.3, var_3);
  var_3 = assign_vehicle_interaction("_encstr_8B0310BBC3C7C8C1BE9A6E1E48D14BD3DF8B", -22.5, 38, 44.3, var_3);
  var_3 = assign_vehicle_interaction("_encstr_8D48079DD59BE65627", -6, 0, 83, var_3);
  var_3 = assign_vehicle_interaction("_encstr_92651150529E9FA6E33D6C5D2FB32971C63A28", -48.8, -39, 19.9, var_3);
  var_3 = assign_vehicle_interaction("_encstr_B6B91289161BD6AF9CD23B1A8EFA4E2B382CD2E4", -48.8, 39, 17.5, var_3);
  var_3 = assign_vehicle_interaction("_encstr_81EF129927BD73D1D71B956647D74ECA0E2CD2E4", 74, -39, 17, var_3);
  var_3 = assign_vehicle_interaction("_encstr_ADE513BDDB5F2DA459FBFB7F1AA4C7C23B6A499F6B", 74, 39, 17.5, var_3);
  var_3 = assign_vehicle_interaction("_encstr_B4610CAA50F73F5F53A560694BBB", 105, 0, 42.5, var_3);
  var_3 = assign_vehicle_interaction("_encstr_861B171385B1ADAFE4D2ECD03ABE939533963663BE58B6DAED", -5, 19, 55, var_3);
  var_1.interaction_setups_array = var_3;
  return var_1;
}

friendly_hvi_vehicle_add_additional_parts_func(var_0) {
  add_gunner_turret(var_0);
}

add_grenadier_anchor(var_0) {
  var_1 = -15;
  var_2 = 0;
  var_3 = 50;
  var_4 = var_0.angles;
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = anglestoup(var_4);
  var_8 = var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_9 = var_8 + var_5 * var_1 + var_6 * var_2 + var_7 * var_3;
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_9);
  var_10 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_10 linkTo(var_0);
  var_10 thread clean_up_on_vehicle_death(var_10, var_0);
  var_0.grenadier_anchor = var_10;
  var_0.grenadier_weapon = "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0";
}

remove_from_overwatch_target_group(var_0) {
  if(isDefined(var_0.target_marker_group_id))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_0, var_0 getentitynumber(), var_0.target_marker_group_id);
}

debug_setup_warp_jeep_to_players() {}

debug_warp_jeep_to_player(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 waittill("_encstr_A10A0DFBA1B6530CB06BD8C467A897");

    if(self vehicle_isphysveh()) {
      var_1 = getclosestpointonnavmesh(var_0.origin);
      var_1 = var_1 + (0, 0, 50);
      var_2 = (0, self.angles[1], 0);
      self vehicle_teleport(var_1, var_2);
    }

    wait 0.05;
  }
}

_id_14222(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_1);
    update_driver_interaction_hint(var_0);
  }
}

_id_14223(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_A5C41283E14EE339B347EA3BB0CEB07D26FD790B");
    update_driver_interaction_hint(var_0);
  }
}