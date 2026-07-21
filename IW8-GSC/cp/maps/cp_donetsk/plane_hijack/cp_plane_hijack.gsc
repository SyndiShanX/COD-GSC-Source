/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\plane_hijack\cp_plane_hijack.gsc
***************************************************************/

main() {
  load_fx();
  _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::load_fx();
  level thread scripts\cp\cp_breach_c4::main();
  register_plane_hijack_objectives();
  scripts\engine\utility::flag_init("_encstr_99A0281320C16A9198FB4D89C2B46AF186FCC144DBEB2BC2BF4E73423DD58B97957FDF5BFFDC6B26879B");

  if(!scripts\engine\utility::flag_exist("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC"))
    scripts\engine\utility::flag_init("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");

  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  level.unload_fx_func = ::smoke_up_landing_zone_for_enemy_ai;
  thread register_interactions();
  thread heli_crash_path_loc_setup();
  register_spawn_functions();
  claxon_light_init();
  level thread spawn_and_start_c130();

  if(getdvarint("_encstr_96EC149B1BC9D7381A4DF576D29D2B98F6588CB7BA1D", 0) != 0)
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::player_give_gg_loadout);

  stealth_init();
  init_plane_anims();
  init_player_seating_anims();
  init_player_seated_anims();
  syncleadmarkers();
  swivel_dogtag_revive();
  init_alarm_system();
  level thread global_weapons_free();
  level thread load_scriptable_garage_door();
  level.stealth_soundaliases = ["_encstr_B160199BD781CED8E5DE8D1B84F7108BEB4F2B1177DA98F807758B", "_encstr_843C191F1B68F3B49099B5BB9069FCFA56ABD7938FA95A9C1940AA", "_encstr_976A1AE5091F0B81376218200A4149A073AD67DDA7AB30FF5CA91008"];
}

load_scriptable_garage_door() {
  while(!scripts\engine\utility::flag_exist("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    wait 1;

  scripts\engine\utility::flag_wait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  level.garage_door = getEnt("_encstr_9ABA0CC97E5A209C62478997EF7B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.garage_door.current_state = 0;
  level.garage_door.trial_moving_target_mover = getEnt("_encstr_8DD616A703509E577D3EFAB363CDBF95E1FB562C8710E25F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.garage_door.trial_moving_target_mover setHintString(&"_encstr_A2311537F3419411829687300DB8D9D8F907AB9D4F28CD");
  level.garage_door.trial_moving_target_mover setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  level.garage_door.trial_moving_target_mover sethintdisplayrange(50);
  level.garage_door.trial_moving_target_mover sethintdisplayfov(65);
  level.garage_door.trial_moving_target_mover setuserange(50);
  level.garage_door.trial_moving_target_mover setusefov(65);
  level.garage_door.trial_moving_target_mover sethintonobstruction("_encstr_BECC055CF3811A");
  level.garage_door.trial_moving_target_mover makeusable();
  level.garage_door.trial_moving_target_mover delete();
  level.garage_door.door_interaction = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", scripts\engine\utility::getStruct("_encstr_A278151F772DDAB779216B3F507367F29F9623D2E5B7C3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
  level.garage_door.door_interaction makeusable();
  level.garage_door.door_interaction setHintString(&"_encstr_A2311537F3419411829687300DB8D9D8F907AB9D4F28CD");
  level.garage_door.door_interaction setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  level.garage_door.door_interaction sethintdisplayrange(32);
  level.garage_door.door_interaction sethintdisplayfov(180);
  level.garage_door.door_interaction setuserange(32);
  level.garage_door.door_interaction setusefov(180);
  level.garage_door.door_interaction sethintonobstruction("_encstr_BECC055CF3811A");
  level.garage_door.door_interaction thread use_garage();
}

load_fx() {
  level._effect["_encstr_A9BA100388B7B357E9D35858E9409AF7E8A0"] = loadfx("_encstr_B2C22D604BA8281BB3B0181EBA6E7D49781740C847497963DFDA1015907381D0449719F007F2F1FD02F5F188EB2AD1");
  level._effect["_encstr_8CE217B6632B49122BA787EBE1C11A9398282D719BE011BAF5"] = loadfx("_encstr_911128DD56305293FF9FFE610346D4D0C8977F49C79A10EFF362F6891A6F8E61E6128BE363C4CAACEBCB");
  level._effect["_encstr_8D1312A89BE703A96B8FE2658F6F16EF4DD26868"] = loadfx("_encstr_8AC7270EB5B8B5273C8A61AAAB38635F105F9370AF706BD7F03BDAC3116743D9B09307E363BA738B0B");
  level._effect["_encstr_92FE167A080D296708BFB8E32709E9A1A051AA4F77285A38"] = loadfx("_encstr_A9EB2C93B42B1821C7A0A7F7D89FB82C022633AB9721AB995838F14A48707B39E09D475AF63B2FD59BAF32AC68E9");
  level._effect["_encstr_96BD0F89E3570FA0ACEF4F67EA1579448B"] = loadfx("_encstr_842F28A3544048839460F106B8D2E3A27B5F2F7B61B84121DE49E169FE3B9692F2E093A31809AA5B6ED2");
  level._effect["_encstr_B8EF140FE811FF824D1DEE66F36FEB851858875F334A"] = loadfx("_encstr_B49324F35ADBA078F3109FDF60CDE0D79FD348994207D0E88D33C1AF9A42E81707EA88E36A0B");
  level._effect["_encstr_A34A11935A1FA0B859E443A5143C28FC3F522A"] = loadfx("_encstr_ACF9249DEBF3E030F78866F98287B38C4BA72F19770A9ECA6B626E10EEBEC8B3C2DF3D6D3B43");
  level._effect["_encstr_AA320EBF459D5FE8194A77555327792A"] = loadfx("_encstr_BD462E3B660FBC2DEE83BE1BC1CBD93387D7B10E7D38B185B995AFCDB6DBB62B7D38B7B98EEB982795588D4371D9CC1E");
  level._effect["_encstr_B4401283D1D847A239CBE3472D48BABCC8FBFF1A"] = loadfx("_encstr_851C24B69533F760A77F521AE247E87502B441BAC1D70897F108C0F196A54B065F7A154B2A28");
  level._effect["_encstr_872814E7C19763491BFE121DD1808D29F9132F0379C6"] = loadfx("_encstr_851C24B69533F760A77F521AE247E87502B441BAC1D70897F108C0F196A54B065F7A154B2A28");
}

global_weapons_free() {
  self notify("_encstr_95A114EFA9D84A0963B68B1769B85FC2AEB763231375");
  self endon("_encstr_95A114EFA9D84A0963B68B1769B85FC2AEB763231375");

  if(!isDefined(level.global_stealth_tracker))
    level.global_stealth_tracker = [];

  if(!isDefined(level.global_stealth_tracker["_encstr_A7F50D43694B87A7F29F2F9F833743"]))
    level.global_stealth_tracker["_encstr_A7F50D43694B87A7F29F2F9F833743"] = 0;

  if(!isDefined(level.global_stealth_tracker["_encstr_860A0DD16126A058777AABD3220385"]))
    level.global_stealth_tracker["_encstr_860A0DD16126A058777AABD3220385"] = 0;

  if(!isDefined(level.global_stealth_tracker["_encstr_91D10DD385D3EA1A893F1150557F4A"]))
    level.global_stealth_tracker["_encstr_91D10DD385D3EA1A893F1150557F4A"] = 0;

  level waittill("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 = 5;

  if(scripts\cp\cp_objectives::is_objective_active("_encstr_83F00E0229E3C25CC660BFF720F9125B") && (isDefined(level.hack_region) && level.hack_region == "_encstr_A20F0CFBFB0E825958C9C90DE0A0")) {
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_860A0DD16126A058777AABD3220385");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A7F50D43694B87A7F29F2F9F833743");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_844414D18732B2F162CDF0E93357C0E02ABFBB6D0B9B");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_915F125002CECFF6EB47980434F75BDFB2CAC038");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_86DB14342CC6B6FA27DEBD33D1DE38D79BDCD2E0B29C");
    level.global_stealth_tracker["_encstr_A7F50D43694B87A7F29F2F9F833743"] = 1;
    var_0 = 15;
    level thread spawn_waves_after_a_delay(var_0, undefined, "_encstr_9B6D119CB7F6CC47B7077D9BC1B0EEE6B2276E");
    scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_A5E009137C82E371736F82");
  }

  if(scripts\cp\cp_objectives::is_objective_active("_encstr_83F00E0229E3C25CC660BFF720F9125B") && (isDefined(level.hack_region) && level.hack_region == "_encstr_A60108C05863AB184BF8")) {
    level.global_stealth_tracker["_encstr_860A0DD16126A058777AABD3220385"] = 1;
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_860A0DD16126A058777AABD3220385");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A7F50D43694B87A7F29F2F9F833743");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_844414D18732B2F162CDF0E93357C0E02ABFBB6D0B9B");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_915F125002CECFF6EB47980434F75BDFB2CAC038");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_86DB14342CC6B6FA27DEBD33D1DE38D79BDCD2E0B29C");
    var_0 = 15;
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", [scripts\cp\cp_modular_spawning::_id_11CAC, 750]);
    scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", [scripts\cp\cp_modular_spawning::_id_11CAB, 64]);
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
    scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A99C140D0B6CB57DC2D239E0B79C3AFA36EDB6312C47");
  }

  if(scripts\cp\cp_objectives::is_objective_active("_encstr_A54E0C905A2303D079D8795BFEDF") || scripts\cp\cp_objectives::is_objective_active("_encstr_B8190FB22EAB96C1F519A56ED9BAB4CDAC")) {
    level.global_stealth_tracker["_encstr_91D10DD385D3EA1A893F1150557F4A"] = 1;
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_B8CB11D3C9BFEA6DF9B0AB370921B793074D0B");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_91D10DD385D3EA1A893F1150557F4A", 1);
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A99C140D0B6CB57DC2D239E0B79C3AFA36EDB6312C47");
    var_0 = 2;
    level thread spawn_waves_after_a_delay(var_0, undefined, "_encstr_99BD102D5DDEDF5ECFE1FB712B87852385FF");
    scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_83E009D0D24D85366DBE46");
  }

  foreach(var_2 in level.alarm_box_structs)
  thread _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::attract_agent_to_alarm(var_2, var_2.alarm_box);

  level scripts\engine\utility::waittill_notify_or_timeout("_encstr_91B909B0D858935BD77BE6", 30);

  foreach(var_2 in level.alarm_box_structs)
  var_2 notify("_encstr_8DC91067F4A5F8D8F72BEB1342C70578BD7F");

  foreach(var_7 in getaiarray("_encstr_8E8405EA382B2A")) {
    if(isDefined(var_7.going_to_object)) {
      var_7.going_to_object = undefined;
      var_7.goalradius = 2048;
      var_7 _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::clear_custom_anim();
    }
  }
}

spawn_waves_after_a_delay(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0)) {
    wait(var_0 / 2);

    if(istrue(var_1)) {
      thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AA16158E568D347BFA1C435EB9F513DBB9CAE5B0C93226");
      thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_851615D31562681891DBE9F7329789E5787B5B397213E7");
      thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AD16151DCA3643BDAF1C0D979BF513F69BB2F2B0E48C66");
    }

    wait(var_0 / 2);
  }

  var_3 = scripts\cp\cp_modular_spawning::set_wave_ref_override(var_2);
  return var_3;
}

init_alarm_system() {
  level.alarm_box_structs = scripts\engine\utility::getStructArray("_encstr_B6380AC2630B9CDAAF31F61E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.alarm_box_structs) {
    _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::initialize_alarm_box(var_1);
    var_1.alarm_box makeunusable();
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_plane_anims() {
  level.scr_animtree["_encstr_824E060F2147FBB8"] = #animtree;
  level.scr_model["_encstr_824E060F2147FBB8"] = "_encstr_AA181C67560DC1EBDA96C6D7584BE4FA0E365ADA0BF5C2DCB4B52CE82B46";
  level.scr_anim["_encstr_824E060F2147FBB8"]["_encstr_ADB405071B8AE8"] = % _encstr_8A8C1CA7A391DE70022C730BD7FC59977A4F0523874AA8483A899883FFAE;
  level.scr_animname["_encstr_824E060F2147FBB8"]["_encstr_ADB405071B8AE8"] = "_encstr_8A8C1CA7A391DE70022C730BD7FC59977A4F0523874AA8483A899883FFAE";
  level.scr_eventanim["_encstr_824E060F2147FBB8"]["_encstr_ADB405071B8AE8"] = "_encstr_AAA2104BE8A1FEC227AD7D758E7F3AA84980";
  level.scr_anim["_encstr_824E060F2147FBB8"]["_encstr_88950636C6DE9B59"] = % _encstr_8D871D49DFC1AF983A13DBC03251D76B7C47B6D94F21D2EFA8B180393037C2;
  level.scr_animname["_encstr_824E060F2147FBB8"]["_encstr_88950636C6DE9B59"] = "_encstr_8D871D49DFC1AF983A13DBC03251D76B7C47B6D94F21D2EFA8B180393037C2";
  level.scr_eventanim["_encstr_824E060F2147FBB8"]["_encstr_88950636C6DE9B59"] = "_encstr_BA3711798326E57370E7C08722F7C89ADF488A";
  level.scr_anim["_encstr_824E060F2147FBB8"]["_encstr_8820081976CAE1084E87"] = % _encstr_8A8D1EA7A391DE70022C730BD7FC5995AA47070937F9275029C5D966BDA1A8C5;
  level.scr_animname["_encstr_824E060F2147FBB8"]["_encstr_8820081976CAE1084E87"] = "_encstr_8A8D1EA7A391DE70022C730BD7FC5995AA47070937F9275029C5D966BDA1A8C5";
  level.scr_eventanim["_encstr_824E060F2147FBB8"]["_encstr_8820081976CAE1084E87"] = "_encstr_921012A30F0732B8A3291B53E03865F9C197AD5F";
  level.scr_anim["_encstr_824E060F2147FBB8"]["_encstr_A7C5056BD931D1"] = % _encstr_9A761EB11C7DDC8D394BC14756C8BE1DB01BDBC19BEB0EC6C2E656D7968C3656;
  level.scr_animname["_encstr_824E060F2147FBB8"]["_encstr_A7C5056BD931D1"] = "_encstr_9A761EB11C7DDC8D394BC14756C8BE1DB01BDBC19BEB0EC6C2E656D7968C3656";
  level.scr_eventanim["_encstr_824E060F2147FBB8"]["_encstr_A7C5056BD931D1"] = "_encstr_87E61247C21BBD1CB9BEE0D8C2E659FAA5C86395";
  level.scr_anim["_encstr_824E060F2147FBB8"]["_encstr_914808D1B05B2B7B9999"] = % _encstr_B6CC213638EB371BC9D21CE8B2197D47B01BBD0EB9FA831B2CE62BBED185D62BB733CC;
  level.scr_animname["_encstr_824E060F2147FBB8"]["_encstr_914808D1B05B2B7B9999"] = "_encstr_B6CC213638EB371BC9D21CE8B2197D47B01BBD0EB9FA831B2CE62BBED185D62BB733CC";
  level.scr_eventanim["_encstr_824E060F2147FBB8"]["_encstr_914808D1B05B2B7B9999"] = "_encstr_8FEA157C88BBCF404B9703844E8B0A59483074AD352B88";
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_player_seating_anims() {
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_BDB21107D816732B7DDC2DA3E82DCD76BE9673"] = % _encstr_A3DA193638EBE6C627D20E8E56C8FA833685732BBE9B961DFAB473;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_BDB21107D816732B7DDC2DA3E82DCD76BE9673"] = "_encstr_A3DA193638EBE6C627D20E8E56C8FA833685732BBE9B961DFAB473";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_BDB21107D816732B7DDC2DA3E82DCD76BE9673"] = "_encstr_8AD90D83B1B0CDCAAF375A8EAF2DB9";
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_822C13377C97D8D3C91360907B1C8DB1171DBB23DC"] = % _encstr_8D431BEF7847629A45CC4029E1D47813F21262EAE063FC73F8B728E053;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_822C13377C97D8D3C91360907B1C8DB1171DBB23DC"] = "_encstr_8D431BEF7847629A45CC4029E1D47813F21262EAE063FC73F8B728E053";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_822C13377C97D8D3C91360907B1C8DB1171DBB23DC"] = "_encstr_B45D0F10B968FDFFC01BEAC3662543F418";
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_A948160763583795FAB9D247D1D2E676AF1BEDDE0EFA8189"][0] = % _encstr_BD651E91FB874EE872810131B5DF4197138248D9919F8B88C16C370FC84902FF;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_A948160763583795FAB9D247D1D2E676AF1BEDDE0EFA8189"] = "_encstr_BD651E91FB874EE872810131B5DF4197138248D9919F8B88C16C370FC84902FF";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_A948160763583795FAB9D247D1D2E676AF1BEDDE0EFA8189"][0] = "_encstr_BD8412C11BC2CD56AF9BB4A3EB1BDEDE38AF0C89";
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_AF4816836358DC59F5CD2DA3D1B49B3B7DD8F6ED1CFAC08C"][0] = % _encstr_BE651E27B9404EDFA8DA9A8BEF3051A8F861166DEF0F907C7F6AD84FEBF9771E;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_AF4816836358DC59F5CD2DA3D1B49B3B7DD8F6ED1CFAC08C"] = "_encstr_BE651E27B9404EDFA8DA9A8BEF3051A8F861166DEF0F907C7F6AD84FEBF9771E";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_AF4816836358DC59F5CD2DA3D1B49B3B7DD8F6ED1CFAC08C"][0] = "_encstr_88841283C658DCACEBCD2D47F563EDDE0ED78119";
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_9A4816300911836F8FB0B25BB0DB656F0EE1A7D79F7E42A2"][0] = % _encstr_92651E584391AF219B31675D15EB6E7185BAC8E02932D39B572CE0D8F8DFBBBF;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_9A4816300911836F8FB0B25BB0DB656F0EE1A7D79F7E42A2"] = "_encstr_92651E584391AF219B31675D15EB6E7185BAC8E02932D39B572CE0D8F8DFBBBF";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_9A4816300911836F8FB0B25BB0DB656F0EE1A7D79F7E42A2"][0] = "_encstr_9684121C368573AC7D9BD2E8F536EDF6C1FAC099";
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_player_seated_anims() {
  if(!isDefined(level.c130_seat_idles))
    level.c130_seat_idles = ["_encstr_8D30066E2BB0D113", "_encstr_AF3006C31D817B2A", "_encstr_9A30069BCAC649C3", "_encstr_8C3006B9ACC21D0D"];

  level.scr_animtree["_encstr_9ABA0CC97E5A209C62478997EF7B"] = #animtree;
  level.scr_model["_encstr_9ABA0CC97E5A209C62478997EF7B"] = "_encstr_842F1782D0F8E398993D3B07A451F3323A39375B61ACC02FC2";
  level.scr_anim["_encstr_9ABA0CC97E5A209C62478997EF7B"]["_encstr_837E0C0FF940B1BA757F077363A8"] = % _encstr_99C41826C7BF037AE09067BF207B213A9355AD5DAE174AA04988;
  level.scr_animname["_encstr_9ABA0CC97E5A209C62478997EF7B"]["_encstr_837E0C0FF940B1BA757F077363A8"] = "_encstr_99C41826C7BF037AE09067BF207B213A9355AD5DAE174AA04988";
  level.scr_anim["_encstr_9ABA0CC97E5A209C62478997EF7B"]["_encstr_B2A30DE7CF33FFAFBB91529A28AF67"] = % _encstr_BE4919B10EFA83C97B83FA760B9C85CEB232EDEDC9EBB18D7B6E56;
  level.scr_animname["_encstr_9ABA0CC97E5A209C62478997EF7B"]["_encstr_B2A30DE7CF33FFAFBB91529A28AF67"] = "_encstr_BE4919B10EFA83C97B83FA760B9C85CEB232EDEDC9EBB18D7B6E56";
}

register_spawn_functions() {
  level.global_stealth_broken = 0;
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_915F125002CECFF6EB47980434F75BDFB2CAC038", 1, 1, 1, 0.05, ::call_wave_on_group_killed, "_encstr_915F125002CECFF6EB47980434F75BDFB2CAC038", ::increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_915F125002CECFF6EB47980434F75BDFB2CAC038", ::standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A7F50D43694B87A7F29F2F9F833743", 19, 19, 19, 0.05, ::call_wave_on_group_killed, "_encstr_A7F50D43694B87A7F29F2F9F833743", ::increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A7F50D43694B87A7F29F2F9F833743", ::standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_86DB14342CC6B6FA27DEBD33D1DE38D79BDCD2E0B29C", 3, 3, 3, 0.05, ::call_wave_on_group_killed, "_encstr_86DB14342CC6B6FA27DEBD33D1DE38D79BDCD2E0B29C", ::increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_86DB14342CC6B6FA27DEBD33D1DE38D79BDCD2E0B29C", ::sniper_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_844414D18732B2F162CDF0E93357C0E02ABFBB6D0B9B", 3, 3, 3, 0.05, ::call_wave_on_group_killed, "_encstr_844414D18732B2F162CDF0E93357C0E02ABFBB6D0B9B", ::increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_844414D18732B2F162CDF0E93357C0E02ABFBB6D0B9B", ::sniper_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_91CB0C9AAEB3ECFA0EC21D39B78D", 8, 8, 8, 0.05, ::call_wave_on_group_killed, "_encstr_91CB0C9AAEB3ECFA0EC21D39B78D", ::increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_91CB0C9AAEB3ECFA0EC21D39B78D", ::standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AB350B6567C20441A79BE19BC7", 2, 2, 2, 0.05, ::call_wave_on_group_killed, "_encstr_AB350B6567C20441A79BE19BC7", ::increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB350B6567C20441A79BE19BC7", ::jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_860A0DD16126A058777AABD3220385", 0, 16, 16, 0.05, ::call_wave_on_group_killed, "_encstr_860A0DD16126A058777AABD3220385", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_860A0DD16126A058777AABD3220385", ::standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8B8013A957B33BD7DCA3852D3937EBD8BD5B13588E", 0, 1, 1, 0.05, ::call_wave_on_group_killed, "_encstr_8B8013A957B33BD7DCA3852D3937EBD8BD5B13588E", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8B8013A957B33BD7DCA3852D3937EBD8BD5B13588E", ::jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A9CF1B34166CADBEC25A3983F6E48EF553EAB3ECEB2396B9B3AED237AC", 1, 1, 1, 0.05, ::call_wave_on_group_killed, "_encstr_A9CF1B34166CADBEC25A3983F6E48EF553EAB3ECEB2396B9B3AED237AC", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A9CF1B34166CADBEC25A3983F6E48EF553EAB3ECEB2396B9B3AED237AC", ::jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B44B1532B360871F5540430A2B3B57FF4907BF8D35080B", 0, 1, 1, 0.05, ::call_wave_on_group_killed, "_encstr_B44B1532B360871F5540430A2B3B57FF4907BF8D35080B", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B44B1532B360871F5540430A2B3B57FF4907BF8D35080B", ::jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AC2B1934C28DB5AFC296C938EDC93AAFD45DD9ECEB9BE858B493E6", 1, 1, 1, 0.05, ::call_wave_on_group_killed, "_encstr_AC2B1934C28DB5AFC296C938EDC93AAFD45DD9ECEB9BE858B493E6", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AC2B1934C28DB5AFC296C938EDC93AAFD45DD9ECEB9BE858B493E6", ::jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A59D1AA6BA9D76D7C84BB9D9AB5ADCACFA1BF6AD98B03AF5ED738DCB", 0, 1, 1, 0.05, ::call_wave_on_group_killed, "_encstr_AC2B1934C28DB5AFC296C938EDC93AAFD45DD9ECEB9BE858B493E6", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A59D1AA6BA9D76D7C84BB9D9AB5ADCACFA1BF6AD98B03AF5ED738DCB", ::jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_91D10DD385D3EA1A893F1150557F4A", 0, 42, 42, 0.05, ::call_wave_on_group_killed, "_encstr_91D10DD385D3EA1A893F1150557F4A", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_91D10DD385D3EA1A893F1150557F4A", ::plane_patrol_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A721148C3B68A587B6E6130AAB16875DA9811CE14D88", 0, 4, 20, 0.05, ::call_wave_on_group_killed, "_encstr_A721148C3B68A587B6E6130AAB16875DA9811CE14D88", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A721148C3B68A587B6E6130AAB16875DA9811CE14D88", ::plane_patrol_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_88810E470BC9B5581BF507161DC9F68D", 0, 3, 20, 0.05, ::call_wave_on_group_killed, "_encstr_88810E470BC9B5581BF507161DC9F68D", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_88810E470BC9B5581BF507161DC9F68D", ::plane_patrol_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B8CB11D3C9BFEA6DF9B0AB370921B793074D0B", 2, 2, 2, 0.05, ::call_wave_on_group_killed, "_encstr_B8CB11D3C9BFEA6DF9B0AB370921B793074D0B", ::increase_max_dist_and_watch_for_point_crossed, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B8CB11D3C9BFEA6DF9B0AB370921B793074D0B", ::jugg_enemy_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A99C140D0B6CB57DC2D239E0B79C3AFA36EDB6312C47", 0, 16, undefined, 0.05, ::call_wave_on_group_killed, "_encstr_A99C140D0B6CB57DC2D239E0B79C3AFA36EDB6312C47", ::setmapcirclesize, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A99C140D0B6CB57DC2D239E0B79C3AFA36EDB6312C47", [scripts\cp\cp_modular_spawning::_id_11CAB, 64]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A99C140D0B6CB57DC2D239E0B79C3AFA36EDB6312C47", [scripts\cp\cp_modular_spawning::_id_11CAC, 750]);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AB030E43755828980B838BBFE33256E0", 0, 12, undefined, 0.1, undefined, "_encstr_AB030E43755828980B838BBFE33256E0", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB030E43755828980B838BBFE33256E0", ::standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A1FA0D28796B2169A0D790A8AA6580", 4, 4, undefined, 0.5, 0, "_encstr_A1FA0D28796B2169A0D790A8AA6580", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9B3612A7C6BB5BF9F85F20500F0F138F132A888F", 4, 4, 4, 0.5, 0, "_encstr_9B3612A7C6BB5BF9F85F20500F0F138F132A888F");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_863612A9CF6BFF483003EBC1A1E71820F3737FB5", 4, 4, 4, 0.5, 0, "_encstr_863612A9CF6BFF483003EBC1A1E71820F3737FB5");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8B36129AA910E14A439BBBF7E7FC63578013D932", 4, 4, 4, 0.5, 0, "_encstr_8B36129AA910E14A439BBBF7E7FC63578013D932");
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_860A0DD16126A058777AABD3220385", ::soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_A7F50D43694B87A7F29F2F9F833743", ::soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_86DB14342CC6B6FA27DEBD33D1DE38D79BDCD2E0B29C", ::soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_844414D18732B2F162CDF0E93357C0E02ABFBB6D0B9B", ::soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_915F125002CECFF6EB47980434F75BDFB2CAC038", ::soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_91D10DD385D3EA1A893F1150557F4A", ::soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_91CB0C9AAEB3ECFA0EC21D39B78D", ::soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_AB350B6567C20441A79BE19BC7", ::jugg_death_func);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_B8CB11D3C9BFEA6DF9B0AB370921B793074D0B", ::jugg_death_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A9070A7FDB8846BF95C622AA", 1, 1, 1, 0.1, undefined, "_encstr_A9070A7FDB8846BF95C622AA");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A9070A7FDB8846BF95C622AA", ::play_ai_skit);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B13A0C9FFF3BF0380175F8D11AE3", 1, 1, 1, 0.1, undefined, "_encstr_B13A0C9FFF3BF0380175F8D11AE3");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B13A0C9FFF3BF0380175F8D11AE3", ::civ_killers_loop);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A9AF1047EAB9372B8DAF9B0758EEB95927B9", 4, 4, 4, 0.1, 0, "_encstr_A9AF1047EAB9372B8DAF9B0758EEB95927B9", undefined, undefined, ::progress_objective_on_group_killed);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_82ED0E94E52005C2631F46BA017C5D3E", 10, 10, 10, 0.1, ::call_wave_on_group_killed, "_encstr_82ED0E94E52005C2631F46BA017C5D3E", undefined, undefined, ::progress_objective_on_group_killed);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_82ED0E94E52005C2631F46BA017C5D3E", ::standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_82ED0E94E52005C2631F46BA017C5D3E", ::soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_ACC017C3D8BF3361014F8B17806DD17BC180B16E244EE5831B", 5, 5, 5, 0.1, 0, "_encstr_ACC017C3D8BF3361014F8B17806DD17BC180B16E244EE5831B", undefined, undefined, ::progress_objective_on_group_killed);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_ACC017C3D8BF3361014F8B17806DD17BC180B16E244EE5831B", ::standard_soldier_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("_encstr_ACC017C3D8BF3361014F8B17806DD17BC180B16E244EE5831B", ::soldier_enemy_death_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B82D1485E35A6519DCD710B033D71391728B7085BA23", 4, 4, 4, 0.1, 0, "_encstr_B82D1485E35A6519DCD710B033D71391728B7085BA23", undefined, undefined, ::progress_objective_on_veh_group_killed);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A3280AC0EAE7C830033F9FBB", 1, 1, 1, 0.1, 0, "_encstr_A3280AC0EAE7C830033F9FBB", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AFF5108A4C2A69E33BF948634EC66B44CE6B", 24, 24, 24, 0.1, 0, "_encstr_AFF5108A4C2A69E33BF948634EC66B44CE6B", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8DF510D01BDB5E57ABFE24A059B391813F9A", 24, 24, 24, 0.1, 0, "_encstr_8DF510D01BDB5E57ABFE24A059B391813F9A", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A5F510ED9C1971874853171ED863E947D96E", 24, 24, 24, 0.1, 0, "_encstr_A5F510ED9C1971874853171ED863E947D96E", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BE4D14B60D1BFACD830BBBE6FADCD1CEAF19EB8DB5EC", 4, 4, 4, 0.1, 0, "_encstr_BE4D14B60D1BFACD830BBBE6FADCD1CEAF19EB8DB5EC", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AC18184BF856713E436A9BA091977578E11BA7EF903D700C7F72", 2, 2, 2, 0.1, 0, "_encstr_AC18184BF856713E436A9BA091977578E11BA7EF903D700C7F72", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AF5D0C6B348DFA6EA32B16D88E34", 5, 5, 5, 0.05, undefined, "_encstr_AF5D0C6B348DFA6EA32B16D88E34", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AF5D0C6B348DFA6EA32B16D88E34", ::watch_for_plane_spawners);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9B780DB5DB37018BF308D7AB306B43", 40, 48, 48, 0.05, 0, "_encstr_9B780DB5DB37018BF308D7AB306B43", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_887B12B534C67D9B380BEEE6F5CDDABD5B564E9B", 2, 2, 2, 0.1, 0, "_encstr_887B12B534C67D9B380BEEE6F5CDDABD5B564E9B", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_95A30F1B08C8CD597905279FF811B28293", 1, 1, 1, 0.1, 0, "_encstr_95A30F1B08C8CD597905279FF811B28293", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_9B780DB5DB37018BF308D7AB306B43", ::watch_for_players_mhc_spawners);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_887B12B534C67D9B380BEEE6F5CDDABD5B564E9B", ::watch_for_players_mhc_smokers);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8EFA108258E6274563D7030843300D3796D3", 16, 16, 16, 0.1, 0, "_encstr_8EFA108258E6274563D7030843300D3796D3", undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B8A21130047E89BA61290FE889088697F82731", 4, 24, 24, 0.1, 0, "_encstr_B8A21130047E89BA61290FE889088697F82731", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_92A21178525F60A8DD9F5F51C943E035B3991B", 5, 20, 24, 0.1, 0, "_encstr_92A21178525F60A8DD9F5F51C943E035B3991B", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BEA211589353C6F1E2C9AE375E8B2D49AAB722", 10, 20, 48, 0.1, 0, "_encstr_BEA211589353C6F1E2C9AE375E8B2D49AAB722", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BED510F11DB30BF3E70380100FFC6EAD3B87", 2, 2, 2, 0.1, 0, "_encstr_BED510F11DB30BF3E70380100FFC6EAD3B87", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_BED510F11DB30BF3E70380100FFC6EAD3B87", ::lower_level_jugg_properties);
  scripts\cp\cp_modular_spawning::force_module_cqb_scoring("_encstr_B8A21130047E89BA61290FE889088697F82731");
  scripts\cp\cp_modular_spawning::force_module_cqb_scoring("_encstr_92A21178525F60A8DD9F5F51C943E035B3991B");
  scripts\cp\cp_modular_spawning::force_module_cqb_scoring("_encstr_BEA211589353C6F1E2C9AE375E8B2D49AAB722");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8EFA108258E6274563D7030843300D3796D3", ::watch_for_players_mhc_spawners);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_BE400BD158B4D113B7DA38E617", 0, 6, 6, 0.1, undefined, "_encstr_BE400BD158B4D113B7DA38E617", ::watchforstopwaves, [::remove_group_from_combined_module_counters, 12], undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_92400B9118F49153F79A78A667", 0, 6, 6, 0.1, undefined, "_encstr_92400B9118F49153F79A78A667", ::watchforstopwaves, [::remove_group_from_combined_module_counters, 12], undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_82400BA32A0308E0C7F44337B3", 0, 6, 6, 0.1, undefined, "_encstr_82400BA32A0308E0C7F44337B3", ::watchforstopwaves, [::remove_group_from_combined_module_counters, 12], undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8F400B0A3B60D94A0801798F02", 0, 6, 6, 0.1, undefined, "_encstr_8F400B0A3B60D94A0801798F02", ::watchforstopwaves, [::remove_group_from_combined_module_counters, 12], undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_91400B207B4D375C8B58A2D98A", 0, 6, 6, 0.1, undefined, "_encstr_91400B207B4D375C8B58A2D98A", ::watchforstopwaves, [::remove_group_from_combined_module_counters, 12], undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AFA313EB111FB0B811724AD7DAD761488B9B87DFAB", 0, [::_id_12CE1, 10], scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "_encstr_AFA313EB111FB0B811724AD7DAD761488B9B87DFAB", [::_id_13A96, (-18120, 22629, -390), (-16761, 22629, -390)], "_encstr_86A313E309160B754959A8B13721FB77C6A00A1A7B", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_86A313E309160B754959A8B13721FB77C6A00A1A7B", 0, [::_id_12CE1, 10], scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "_encstr_86A313E309160B754959A8B13721FB77C6A00A1A7B", [::_id_13A95, (-16761, 22629, -390), (-15844, 22629, -390), "_encstr_AFA313EB111FB0B811724AD7DAD761488B9B87DFAB"], "_encstr_A5A3131B3BCE0B18C6786093D33161A70A5D63F0F7", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A5A3131B3BCE0B18C6786093D33161A70A5D63F0F7", 0, [::_id_12CE1, 10], scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "_encstr_A5A3131B3BCE0B18C6786093D33161A70A5D63F0F7", [::_id_13A95, (-15844, 22629, -390), (-15307, 22629, -390), "_encstr_86A313E309160B754959A8B13721FB77C6A00A1A7B"], "_encstr_83A313A356C634EDFA83435ECDBE3A0BE46B2C3643", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_83A313A356C634EDFA83435ECDBE3A0BE46B2C3643", 0, [::_id_12CE1, 10], scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "_encstr_83A313A356C634EDFA83435ECDBE3A0BE46B2C3643", [::_id_13A95, (-15307, 22629, -390), (-14313, 22629, -390), "_encstr_A5A3131B3BCE0B18C6786093D33161A70A5D63F0F7"], "_encstr_8BA31334CA811337B9C2D85A8FD7238B36F3726755", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8BA31334CA811337B9C2D85A8FD7238B36F3726755", 0, [::_id_12CE1, 10], scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "_encstr_8BA31334CA811337B9C2D85A8FD7238B36F3726755", [::_id_13A95, (-14313, 22629, -390), (-13808, 22629, -390), "_encstr_83A313A356C634EDFA83435ECDBE3A0BE46B2C3643"], "_encstr_99A313D1B2C634DEF51C342FB9FAD18539B585C6D8", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_99A313D1B2C634DEF51C342FB9FAD18539B585C6D8", 0, [::_id_12CE1, 10], scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "_encstr_99A313D1B2C634DEF51C342FB9FAD18539B585C6D8", [::_id_13A95, (-13808, 22629, -390), (-13021, 22629, -390), "_encstr_8BA31334CA811337B9C2D85A8FD7238B36F3726755"], "_encstr_9BA313C0F7035087A1527383EAD9C9397A4FE0C016", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9BA313C0F7035087A1527383EAD9C9397A4FE0C016", 0, [::_id_12CE1, 10], scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "_encstr_9BA313C0F7035087A1527383EAD9C9397A4FE0C016", [::_id_13A95, (-13021, 22629, -390), (-12442, 22629, -390), "_encstr_99A313D1B2C634DEF51C342FB9FAD18539B585C6D8"], "_encstr_95A3137388C9C05A0F8FA4987667A391B3609FA7FA", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_95A3137388C9C05A0F8FA4987667A391B3609FA7FA", 0, [::_id_12CE1, 10], scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "_encstr_95A3137388C9C05A0F8FA4987667A391B3609FA7FA", [::_id_13A95, (-12442, 22629, -390), undefined, "_encstr_9BA313C0F7035087A1527383EAD9C9397A4FE0C016"], "_encstr_B4A313E09A1903D0CF129B632380703A38D2C1D0C7", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B4A313E09A1903D0CF129B632380703A38D2C1D0C7", 0, [::_id_12CE1, 10], scripts\cp\cp_modular_spawning::shipfx, 0.05, undefined, "_encstr_B4A313E09A1903D0CF129B632380703A38D2C1D0C7", [::_id_13A95, (-12442, 22629, -390), undefined, "_encstr_95A3137388C9C05A0F8FA4987667A391B3609FA7FA"], undefined, undefined);
  scripts\cp\cp_vehicles::_id_12AE5("_encstr_AFA313EB111FB0B811724AD7DAD761488B9B87DFAB", "_encstr_96EC0BA32B8D1AB7D70E8697E6", [1, 2, 3]);
  scripts\cp\cp_vehicles::_id_12AE5("_encstr_86A313E309160B754959A8B13721FB77C6A00A1A7B", "_encstr_96EC0BA32B8D1AB7D70E8697E6", [1, 2, 3]);
  scripts\cp\cp_vehicles::_id_12AE5("_encstr_A5A3131B3BCE0B18C6786093D33161A70A5D63F0F7", "_encstr_96EC0BA32B8D1AB7D70E8697E6", [1, 2, 3]);
  scripts\cp\cp_vehicles::_id_12AE5("_encstr_83A313A356C634EDFA83435ECDBE3A0BE46B2C3643", "_encstr_96EC0BA32B8D1AB7D70E8697E6", [1, 2, 3]);
  scripts\cp\cp_vehicles::_id_12AE5("_encstr_8BA31334CA811337B9C2D85A8FD7238B36F3726755", "_encstr_96EC0BA32B8D1AB7D70E8697E6", [1, 2, 3]);
  scripts\cp\cp_vehicles::_id_12AE5("_encstr_99A313D1B2C634DEF51C342FB9FAD18539B585C6D8", "_encstr_96EC0BA32B8D1AB7D70E8697E6", [1, 2, 3]);
  scripts\cp\cp_vehicles::_id_12AE5("_encstr_9BA313C0F7035087A1527383EAD9C9397A4FE0C016", "_encstr_96EC0BA32B8D1AB7D70E8697E6", [1, 2, 3]);
  scripts\cp\cp_vehicles::_id_12AE5("_encstr_95A3137388C9C05A0F8FA4987667A391B3609FA7FA", "_encstr_96EC0BA32B8D1AB7D70E8697E6", [1, 2, 3]);
  scripts\cp\cp_vehicles::_id_12AE5("_encstr_B4A313E09A1903D0CF129B632380703A38D2C1D0C7", "_encstr_96EC0BA32B8D1AB7D70E8697E6", [1, 2, 3]);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AA16158E568D347BFA1C435EB9F513DBB9CAE5B0C93226", 0, 6, 6, 0.1, undefined, "_encstr_AA16158E568D347BFA1C435EB9F513DBB9CAE5B0C93226", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_851615D31562681891DBE9F7329789E5787B5B397213E7", 0, 6, 6, 0.1, undefined, "_encstr_851615D31562681891DBE9F7329789E5787B5B397213E7", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AD16151DCA3643BDAF1C0D979BF513F69BB2F2B0E48C66", 0, 6, 6, 0.1, undefined, "_encstr_AD16151DCA3643BDAF1C0D979BF513F69BB2F2B0E48C66", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_85190CB2B3384720A909788B0247", 1, 1, 1, 0.1, 0, "_encstr_85190CB2B3384720A909788B0247", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_95960ECA1E66D21BAF6EE62DE095C9E6", 7, 7, 7, 0.1, 0, "_encstr_95960ECA1E66D21BAF6EE62DE095C9E6", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AF770B0D3B393B6A5F7B736C5B", 10, 10, 10, 0.1, 0, "_encstr_AF770B0D3B393B6A5F7B736C5B", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B84E0BAAF2CCA71DF1C97547CF", 7, 7, 7, 0.1, 0, "_encstr_B84E0BAAF2CCA71DF1C97547CF", undefined, undefined, undefined);
}

setmapcirclesize(var_0) {
  scripts\cp\coop_stealth::increase_script_maxdist(var_0);
}

_id_12BF6() {
  if(isDefined(self.spawnflags)) {
    if(self.spawnflags & 512)
      self.spawnflags = self.spawnflags - 512;
  }
}

_id_12CE1(var_0, var_1) {
  if(scripts\cp\cp_modular_spawning::shipfx(var_0)) {
    var_0 mp_hideout_patch();
    return undefined;
  } else
    return var_1;
}

remove_group_from_combined_module_counters(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_88EF202C8DB1BE38C6B097B2C9B9BEE8CAB1951CB7391D5623FA8EB7AF1C1BB0CD2B");
  level endon("_encstr_870119E9027310902DD57353C713A843CF6AC0911B6731D886BE7B");
  level endon("_encstr_969C1436C62BC293AC46EBCCB727FA4785B559B7CC66");
  wait(var_1);

  for(var_2 = getaiarray("_encstr_8E8405EA382B2A").size; var_2 >= 27; var_2 = getaiarray("_encstr_8E8405EA382B2A").size)
    wait 4;

  return var_0.group_name;
}

_id_13A96(var_0, var_1, var_2, var_3) {
  _id_13A95(var_0, var_1, var_2, var_3);
  thread playerhumanhitground();
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_B8CB11D3C9BFEA6DF9B0AB370921B793074D0B");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_91D10DD385D3EA1A893F1150557F4A");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_88810E470BC9B5581BF507161DC9F68D");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A721148C3B68A587B6E6130AAB16875DA9811CE14D88");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A99C140D0B6CB57DC2D239E0B79C3AFA36EDB6312C47");
}

playerhumanhitground(var_0) {
  var_1 = getaiarray("_encstr_8E8405EA382B2A");

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2] thread scripts\cp\cp_modular_spawning::vehicle_preventplayercollisiondamagefortimeafterexit();
}

_id_13A95(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(var_0.group_name == "_encstr_95A3137388C9C05A0F8FA4987667A391B3609FA7FA") {
    while(!istrue(level._id_123A3))
      waitframe();
  }

  scripts\cp\cp_modular_spawning::_id_130F7(var_0, 1);

  if(isDefined(var_3))
    var_0 scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_3);

  var_0 thread watchforstopwaves(var_0);
  var_0 scripts\cp\cp_modular_spawning::watch_for_players_beyond_point_internal(var_0, (-18165, 21233, -390), (0, 90, 0));

  if(isDefined(var_2))
    var_0 thread scripts\cp\cp_modular_spawning::watch_for_players_beyond_point(var_0, var_2, (0, 0, 0), ::mp_hideout_patch);

  if(isDefined(var_1))
    var_0 scripts\cp\cp_modular_spawning::watch_for_players_beyond_point_internal(var_0, var_1, (0, 0, 0));
}

mp_hideout_patch() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(self.group_name, 1);
}

watchforstopwaves(var_0) {
  thread _watchforstopwaves(var_0);
}

_watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\engine\utility::_id_143A6("_encstr_870119E9027310902DD57353C713A843CF6AC0911B6731D886BE7B", "_encstr_969C1436C62BC293AC46EBCCB727FA4785B559B7CC66", "_encstr_88EF202C8DB1BE38C6B097B2C9B9BEE8CAB1951CB7391D5623FA8EB7AF1C1BB0CD2B");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

increase_max_dist_and_watch_for_point_crossed(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\cp_modular_spawning::process_module_var(var_0, var_0.spawn_points);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];
    var_6.script_maxdist = 20000;
  }
}

call_wave_on_group_killed(var_0, var_1, var_2, var_3) {
  var_0 thread call_wave_on_group_killed_interal(var_0, var_1, var_2, var_3);
}

call_wave_on_group_killed_interal(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(level.global_stealth_broken)) {
    return;
  }
  return;
}

watch_for_plane_spawners(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.group endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  scripts\common\ai::find_and_teleport_to_cover();
  self.fixednode = 1;
}

watch_for_players_mhc_spawners(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  if(self.agent_type == "_encstr_A1C91E665198571380E39B8FCBBB0993603E5AEBCB69EA3BE48FBFDB256F93DC") {
    self.juggernautdisablemovebehavior = 1;
    return;
  }

  scripts\common\ai::find_and_teleport_to_cover();
  self.fixednode = 1;
  self.dont_enter_combat = 1;
  self.neverforcesnipermissenemy = 1;
  self.sniperaccuracyset = 1;
  self.baseaccuracy = 1;
  self.combatmode = "_encstr_81240791CBC8C34B18";
}

watch_for_players_mhc_smokers(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
}

watch_for_smokers(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_1, 562500);
  var_2 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_2, 45);
  var_4 = scripts\cp\cp_modular_spawning::define_var_if_undefined(var_4, 2.5);
  var_5 = 0;

  for(;;) {
    self waittill("_encstr_A9980CD206D783ADA12A30A07283", var_6, var_7, var_8, var_9);

    if(isDefined(var_6) && isPlayer(var_6)) {
      if(var_6 scripts\cp\utility::is_valid_player() && !istrue(var_6.ignoreme)) {
        var_10 = distancesquared(self.origin, var_6.origin);

        if(isDefined(var_3)) {
          if(var_10 <= var_3)
            self.group scripts\engine\utility::ent_flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
        } else if(var_10 <= var_1) {
          wait(var_4);
          self.group scripts\engine\utility::ent_flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
        }
      }
    }
  }
}

progress_objective_on_group_killed(var_0, var_1, var_2, var_3) {
  var_0 thread progress_objective_on_group_killed_interal(var_0, var_1, var_2, var_3);
}

progress_objective_on_group_killed_interal(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591");
  level.clear_to_pick_disguise_up = 1;
}

progress_objective_on_veh_group_killed(var_0, var_1, var_2, var_3) {
  var_0 thread progress_objective_on_veh_group_killed_interal(var_0, var_1, var_2, var_3);
}

progress_objective_on_veh_group_killed_interal(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591");
  level.clear_to_pick_disguise_up_veh = 1;
}

spawn_and_start_c130() {
  level.c130_parts = getEntArray("_encstr_92DC153A487B669FA7EEF329473B9DDFD50197DF1A3B17", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = [];
  var_1 = [];
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.c130_parts) {
    switch (var_5.classname) {
      case "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0":
        if(issubstr(var_5.model, "_encstr_A133134C2D2A6B09DFA29B61512B7A61A721073A28")) {
          var_5 setModel("_encstr_AA181C67560DC1EBDA96C6D7584BE4FA0E365ADA0BF5C2DCB4B52CE82B46");
          level.c130 = var_5;

          if(!isDefined(level.c130.body))
            level.c130.body = [];
        } else if(issubstr(var_5.model, "_encstr_975D1B1AEB3706435398E898F3D0DD87B0D06BC02D8B78E0615709AAA3"))
          var_0 = scripts\engine\utility::array_add(var_0, var_5);
        else
          var_1 = scripts\engine\utility::array_add(var_1, var_5);

        break;
      case "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C":
        if(var_5.targetname == "_encstr_A1C60FA291304AC11DF79FD3AF350A8790") {
          var_3 = scripts\engine\utility::array_add(var_3, var_5);
          break;
        }

        if(var_5.targetname == "_encstr_9AE50DB8BF496B9F5ACDB83E29A309") {
          var_2 = var_5;
          break;
        }

        var_1 = scripts\engine\utility::array_add(var_1, var_5);
        break;
    }
  }

  foreach(var_8, var_5 in var_0)
  var_5 linkTo(level.c130);

  foreach(var_8, var_5 in var_1) {
    var_5 linkTo(level.c130);
    level.c130.body = scripts\engine\utility::array_add(level.c130.body, var_5);
  }

  level.c130_seat_refs = var_0;
  level.c130_seat_refs = getEntArray("_encstr_A2B60A2C2D937DDC560BD19B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.c130.plane_seats = level.c130_seat_refs;
  level.c130.seated_players = 0;
  var_10 = getEntArray("_encstr_91720C6F68C7D031C7F625F7B0BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_8, var_5 in level.c130.plane_seats) {
    var_5 setModel("_encstr_975D1B1AEB3706435398E898F3D0DD87B0D06BC02D8B78E0615709AAA3");
    var_5 linkTo(level.c130);
  }

  level._id_12B45 = getEntArray("_encstr_8C200FDAF5876B3FFBD81FAB0850E6D347", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in level._id_12B45)
  var_5 linkTo(level.c130);

  level._id_1341E = getEnt("_encstr_AA320EBF459D5FE8194A77555327792A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_1341E linkTo(level.c130);
  level._id_12B48 = getEnt("_encstr_B686104E953BC9EDD5E07DA327D23BEC5693", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12B48 enablelinkTo(level.c130);
  level._id_12B48 linkTo(level.c130);
  level.air_doors = getEntArray("_encstr_AD33090B4B4EF519BDDE39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in level.air_doors)
  var_5 linkTo(level.c130);

  level.exit_parts = getEntArray("_encstr_96CA1297E9BB2CAFB1E2F5AAD61C51AACF6A831A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in level.exit_parts) {
    var_5 linkTo(level.c130);

    if(!isDefined(var_5.script_noteworthy)) {
      level.c130.exit_breach_area = var_5;
      continue;
    }

    level.c130.exit_breach_door = var_5;
  }

  if(isDefined(level.claxons) && isarray(level.claxons) && level.claxons.size > 0) {
    if(isDefined(level.claxons["_encstr_ADDF0FBBE21B7B48DBA5710FD88598B0EF"])) {
      foreach(var_19 in level.claxons["_encstr_ADDF0FBBE21B7B48DBA5710FD88598B0EF"].models_on) {
        var_19 linkTo(level.c130);

        foreach(var_21 in var_19.lights)
        var_21 linkTo(level.c130);

        var_19.model_off linkTo(level.c130);

        foreach(var_24 in getEntArray(var_19.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"))
        var_24 linkTo(level.c130);
      }
    }
  }

  var_27 = getEntArray("_encstr_95B3139C56C239AF467BED39EB46BDDDE6FA3B2BBD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_27[0])) {
    level.c130.lower_door_geo = var_27[0];

    if(isDefined(var_27[1]))
      var_27[1] delete();

    level.c130.lower_door_geo linkTo(level.c130, "_encstr_8BED0A408AA3897A719BED41");
    level.c130.lower_door_geo solid();
    level.c130.lower_door_geo delete();
  }

  var_28 = getEntArray("_encstr_ACDE146AADFBAE9799FF306801538FD43D323613A860", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_28) && isarray(var_28) && var_28.size > 0) {
    level.c130._id_12A4E = var_28;

    foreach(var_30 in level.c130._id_12A4E)
    var_30 delete();
  }

  var_32 = getEntArray("_encstr_B81E1DE01B169B95BE32DE7B9CFAEC2B862D1BB1CAFA1BDE631B96B9B4DBDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_32) && isarray(var_32) && var_32.size > 0) {
    level.c130._id_14107 = var_32;

    foreach(var_30 in level.c130._id_14107) {
      var_30 linkTo(level.c130, "_encstr_8BED0A408AA3897A719BED41");
      var_30 solid();
    }
  }

  var_35 = getEnt("_encstr_AFD30E20B199C637011E571992A058E3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_35)) {
    level.c130._id_123A2 = var_35;
    level.c130._id_123A2 linkTo(level.c130);
    level.c130 notsolid();
  }

  var_36 = getEnt("_encstr_93A0165B9861F83F2FBBBF12A0D4CF977F1E66D9B2AB8FF9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_36)) {
    level.c130._id_12A4F = var_36;
    level.c130._id_12A4F linkTo(level.c130, "_encstr_8BED0A408AA3897A719BED41");
    level.c130._id_12A4F solid();
  }

  var_37 = getEntArray("_encstr_A938135ABB47687A9A3F9B2FA87371891796DE724F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_39 in var_37)
  var_39 linkTo(level.c130);

  level.c130.air_reference = getEnt("_encstr_9386128D26CC81F53A958DACC1DB4E8E7D0BA5C9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.c130.air_reference linkTo(level.c130);
  thread winindex();
  level.playerpostsetplunder = getEnt("_encstr_93131459B3073DB8DEECA1CF09C518F1471B9321DB3B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(level.playerpostsetplunder))
    level.playerpostsetplunder linkTo(level.c130);

  var_41 = getEntArray("_encstr_B113151BDEDD56C9EB467BDB39FA1BDB36634BE6D2DBE6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_41)) {
    foreach(var_43 in var_41) {
      if(!isDefined(level.c130._id_11A57))
        level.c130._id_11A57 = [];

      var_43 linkTo(level.c130, "_encstr_8BED0A408AA3897A719BED41");
      var_43 notsolid();
      level.c130._id_11A57 = scripts\engine\utility::array_add(level.c130._id_11A57, var_43);
    }
  }

  var_45 = getEnt("_encstr_A3DD0C07362CDCCAF5E60DACC6D8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_45)) {
    level.c130.shell = var_45;
    level.c130.shell linkTo(level.c130);

    foreach(var_8, var_5 in level.c130.body) {
      if(var_5.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C")
        var_5 delete();
    }
  }

  var_47 = getEnt("_encstr_9A08155D830E2B27F523B7ED93D7D8DB8DD85ACDD27B9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_47)) {
    level.c130._id_14038 = var_47;
    level.c130._id_14038 linkTo(level.c130, "_encstr_8B8010A1163A1B1AD7ABC10EB227EB9AB91D");
    level.c130._id_14038 notsolid();
  }

  var_48 = randomint(360);
  var_49 = 80000;

  if(level.script == "_encstr_926A0E67439812C3B69B6456D877F107")
    var_49 = var_49 / 5;

  var_50 = cos(var_48) * var_49;
  var_51 = sin(var_48) * var_49;
  var_52 = 20000;

  if(level.script == "_encstr_926A0E67439812C3B69B6456D877F107")
    var_52 = var_52 / 4;

  var_53 = vectorNormalize((var_50, var_51, var_52));
  var_53 = var_53 * var_49 + (0, 0, var_52);
  var_54 = level.mapcenter * (1, 1, 0) + (0, 0, var_52);
  level.c130 thread handlemovingplatforms(level.c130);
  var_55 = getEntArray("_encstr_9A8513DAB058F886B017DADA91EDDD37A34F47B3FF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.ground_plane_seats = [];

  foreach(var_57 in var_55) {
    if(!scripts\engine\utility::array_contains(level.ground_plane_seats, var_57))
      level.ground_plane_seats = scripts\engine\utility::array_add(level.ground_plane_seats, var_57);
  }
}

handlemovingplatforms(var_0) {
  scripts\cp\cp_movers::stop_handling_moving_platforms();
  var_1 = spawnStruct();

  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      var_1.linkparents = var_0;

      foreach(var_3 in var_1.linkparents) {
        if(self != var_1.linkparent)
          scripts\cp\cp_movers::handle_moving_platforms(var_1);
      }
    } else {
      var_1.linkparent = var_0;

      if(self != var_1.linkparent)
        scripts\cp\cp_movers::handle_moving_platforms(var_1);
    }
  }
}

debugmovingplatformview(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;)
    waitframe();
}

use_seat(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_881C0957B9B2AFB92B16D1");
  self endon("_encstr_881C0957B9B2AFB92B16D1");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(var_0.current_player)) {
      continue;
    }
    if(!isDefined(level.players_inside_plane))
      level.players_inside_plane = [];

    seat_player(var_0, var_1);
  }
}

seat_player(var_0, var_1) {
  var_0 makeunusable();
  thread play_seating_anim(var_0, var_1);
  level.players_inside_plane = scripts\engine\utility::array_add(level.players_inside_plane, var_1);
  level.c130.seated_players++;
  var_0.current_player = var_1;
  level.players_in_c130++;
  var_1.binseat = 1;

  if(isDefined(var_0.headiconid))
    var_0 thread scripts\cp\utility::ent_deleteheadicon(var_0, var_0.headiconid);

  var_1 thread get_up_from_seat_after_teleporting(var_1, var_0);

  if(level.c130.seated_players == level.players.size)
    level notify("_encstr_969C1436C62BC293AC46EBCCB727FA4785B559B7CC66");
}

play_seating_anim(var_0, var_1) {
  var_2 = 0.2;
  var_1 allowfire(0);
  var_1 scripts\cp\cp_disguise::enter_demeanor_relaxed();
  var_3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "_encstr_8BB007E03658CBCAE4", 1, 0, 0);
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_3], "_encstr_BDB21107D816732B7DDC2DA3E82DCD76BE9673", 1, 0, undefined, var_2);
  var_1.actorplayer = var_3;
  var_3 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var_0 thread play_sitting_loop(var_3, var_1);
  wait_for_any_button_press(var_1, var_0);
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_3], "_encstr_822C13377C97D8D3C91360907B1C8DB1171DBB23DC", 0, 1, undefined, var_2);
  var_1 allowfire(1);
  var_1 scripts\cp\cp_disguise::enter_demeanor_normal();
}

play_sitting_loop(var_0, var_1) {
  var_1 endon("_encstr_814E0A7569AFF5276BF7497C");

  for(;;) {
    thread scripts\cp_mp\anim_scene::anim_scene_loop([var_0], "_encstr_A948160763583795FAB9D247D1D2E676AF1BEDDE0EFA8189", 0, 0, undefined, 0.2);
    wait(getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_A948160763583795FAB9D247D1D2E676AF1BEDDE0EFA8189"][0]));
    scripts\cp_mp\anim_scene::anim_scene_stop();
    thread scripts\cp_mp\anim_scene::anim_scene_loop([var_0], "_encstr_AF4816836358DC59F5CD2DA3D1B49B3B7DD8F6ED1CFAC08C", 0, 0, undefined, 0.2);
    wait(getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_AF4816836358DC59F5CD2DA3D1B49B3B7DD8F6ED1CFAC08C"][0]));
    scripts\cp_mp\anim_scene::anim_scene_stop();
    thread scripts\cp_mp\anim_scene::anim_scene_loop([var_0], "_encstr_9A4816300911836F8FB0B25BB0DB656F0EE1A7D79F7E42A2", 0, 0, undefined, 0.2);
    wait(getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_9A4816300911836F8FB0B25BB0DB656F0EE1A7D79F7E42A2"][0]));
    scripts\cp_mp\anim_scene::anim_scene_stop();
  }
}

wait_for_any_button_press(var_0, var_1) {
  var_0 notify("_encstr_A2DC1AEEC2A53A7D99F69CD7B0CDE5BE13EA3A3ADB9BD70E9359DC37");
  var_0 endon("_encstr_A2DC1AEEC2A53A7D99F69CD7B0CDE5BE13EA3A3ADB9BD70E9359DC37");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 2;

  for(;;) {
    if(istrue(var_0.exit_seat)) {
      var_1 scripts\cp_mp\anim_scene::anim_scene_stop(1);
      var_0 notify("_encstr_814E0A7569AFF5276BF7497C");
      return 1;
    }

    waitframe();
  }
}

do_seated_anim(var_0, var_1) {
  if(!isDefined(var_0.c130_idle)) {
    var_2 = "_encstr_AF3006C31D817B2A";
    level.c130_seat_idles = scripts\engine\utility::array_remove(level.c130_seat_idles, var_2);
    var_0.c130_idle = var_2;
  }

  var_0 thread scripts\cp\cp_destruction::create_player_rig(var_0, "_encstr_991C13A8E1F937972D398BE2A049CF1B96DE516327");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin + (0, 0, -8));
  var_3.angles = anglestoleft(var_1.angles);

  if(var_1.struct.name == "_encstr_93E207E28D8303176B" || var_1.struct.name == "_encstr_ABE207C7B7321DD102")
    var_3.angles = var_3.angles + (0, 180, 0);

  var_3 linkTo(level.c130);
  var_0.player_rig linkTo(var_3);
  var_0 lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 10, 60);
  var_0 waittill("_encstr_814E0A7569AFF5276BF7497C");
  var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  var_0 setstance("_encstr_A5AD069B231F0BAF");

  if(level.c130.seated_players == level.players.size)
    close_plane_doors();
}

cornerline_height(var_0) {
  return var_0.intro_offset * 20 - 122;
}

introscreen_corner_line(var_0, var_1) {
  if(!isDefined(self.intro_offset))
    self.intro_offset = 0;
  else
    self.intro_offset++;

  var_2 = cornerline_height(self);
  var_3 = 1.6;

  if(level.splitscreen)
    var_3 = 2;

  var_4 = newclienthudelem(self);
  var_4.x = 20;
  var_4.y = var_2;
  var_4.alignx = "_encstr_A5AD056A019C63";
  var_4.aligny = "_encstr_A146078E65FB5158DD";
  var_4.horzalign = "_encstr_A5AD056A019C63";
  var_4.vertalign = "_encstr_A146078E65FB5158DD";
  var_4.sort = 3;
  var_4.foreground = 1;
  var_4 settext(var_0);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.fontscale = var_3;
  var_4.color = (0.8, 1, 0.8);
  var_4.font = "_encstr_8B1608EC43B8D647A113";
  var_4.glowcolor = (0.3, 0.6, 0.3);
  var_4.glowalpha = 1;
  return var_4;
}

teleport_text(var_0) {
  wait 2;
  var_1 = var_0 introscreen_corner_line(&"_encstr_A99A19C63817A5DBE66811F2D1CF311D839FF6C55F230CA51F91F2", 1);
  wait 1;
  var_2 = var_0 introscreen_corner_line(&"_encstr_8C9A193482AF64551214945EA8A81351A07A92A8BE984AE48ABE46", 2);
  wait 1;
  var_3 = var_0 introscreen_corner_line(&"_encstr_9A9A19DF01915FFB7E6F7A675B4B385180D9EA51B6B1EC58211946", 3);
  wait 1;
  var_4 = var_0 introscreen_corner_line(&"_encstr_B49A1968A0F5C8AA48284AF28A5126A8827A292AEBC4A43954BEA1", 4);
  wait 3.0;
  var_1 fadeovertime(3);
  var_2 fadeovertime(3);
  var_3 fadeovertime(3);
  var_4 fadeovertime(3);
  var_1.alpha = 0;
  var_2.alpha = 0;
  var_3.alpha = 0;
  var_4.alpha = 0;
  var_1 destroy();
  var_2 destroy();
  var_3 destroy();
  var_4 destroy();
}

get_up_from_seat_after_teleporting(var_0, var_1) {
  var_0 notify("_encstr_8B39115F2920DF2B4FCFF3AB87F9B14B2B3113");
  var_0 endon("_encstr_8B39115F2920DF2B4FCFF3AB87F9B14B2B3113");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_B42715153D453DCDB7900F0D110703920FE4584BC75129");
  level waittill("_encstr_A7630E1D16D6CAF57B3333F5467BCDCA");
  exit_seat(var_0, 0, var_1, 1);

  foreach(var_3 in level.ground_plane_seats) {
    if(var_3.struct.name == var_1.struct.name) {
      var_0 notify("_encstr_960B0CE898D241092BF24B3D23E9");
      thread teleport_black_overlay(var_0);
      thread teleport_text(var_0);
      var_0 unlink();
      var_0.exit_seat = 1;
      set_player_angles_inside_plane(var_0, var_3, var_1);
      thread play_seating_anim_and_exit(var_3, var_0);
    }
  }

  var_0 notify("_encstr_A66422943B90AF2B4DEE4A827394E764D093370C5908F747E583F1EAF8E0AB9DA8338572");
  var_1 makeusable();
  level.c130.seated_players--;
  var_0.binc130 = 1;
  var_1.current_player = undefined;
  var_0.binseat = undefined;
}

take_off_loop(var_0) {
  var_1 = level scripts\engine\utility::_id_143AD(var_0.ref + "_encstr_95D510A9455352EDC369171FC0BBAC9A3155", "_encstr_969C1436C62BC293AC46EBCCB727FA4785B559B7CC66");
  level notify("_encstr_B48811276D9D59CB08D30AD748D82F82E787F7");

  foreach(var_3 in level.c130.plane_seats) {
    if(isDefined(var_3.headiconid))
      var_3 thread scripts\cp\utility::ent_deleteheadicon(var_3, var_3.headiconid);
  }

  level thread scripts\cp\utility::_id_123FE("_encstr_B40101");
  level notify("_encstr_870119E9027310902DD57353C713A843CF6AC0911B6731D886BE7B");
  level._id_12213 = 1;
  level._id_12B46 = 1;

  if(var_1 == "_encstr_969C1436C62BC293AC46EBCCB727FA4785B559B7CC66") {
    thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_A66C17C67291EDF71A57D93A7375CDBDF8ABC770DA782B5CC5", "_encstr_9A8507BA4040188D08", 3.75);
    _id_14472();
    close_plane_doors();
    scripts\cp\cp_modular_spawning::stop_all_groups();

    foreach(var_6 in getaiarray("_encstr_8E8405EA382B2A"))
    var_6 scripts\cp\cp_modular_spawning::script_kill_ai();

    c130_take_off_sequence(1);
  } else if(callback_frontendplayeractive()) {
    thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_A66C17C67291EDF71A57D93A7375CDBDF8ABC770DA782B5CC5", "_encstr_9A8507BA4040188D08", 3.75);
    _id_14472();
    close_plane_doors();
    scripts\cp\cp_modular_spawning::stop_all_groups();

    foreach(var_6 in getaiarray("_encstr_8E8405EA382B2A"))
    var_6 scripts\cp\cp_modular_spawning::script_kill_ai();

    c130_take_off_sequence(1);
  } else {
    thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_A66C17C67291EDF71A57D93A7375CDBDF8ABC770DA782B5CC5", "_encstr_9A8507BA4040188D08", 3.75);
    _id_14472();
    close_plane_doors();
  }

  thread _id_12407();
  level notify("_encstr_AF9516239E77A0D19FDB58E1222FAFB84DE599B13D5B182D");
  scripts\cp\cp_objectives::reset_objective_timers();
  level.c130 unlink();
  level.c130.bpaused = 1;
  scripts\cp\cp_modular_spawning::stop_all_groups();

  if(isDefined(level.enemy_tanks) && isarray(level.enemy_tanks))
    scripts\cp\utility::array_notify(level.enemy_tanks, "_encstr_AD75063D571AE108");

  level notify("_encstr_870119E9027310902DD57353C713A843CF6AC0911B6731D886BE7B");

  foreach(var_6 in getaiarray("_encstr_8E8405EA382B2A"))
  var_6 scripts\cp\cp_modular_spawning::script_kill_ai();

  var_12 = scripts\engine\utility::getStructArray("_encstr_BE3E16D955352B1F9F3B9BE6332B5F70CB975977F11DD0E6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level notify("_encstr_B49D197ED2390528B23798510FF18D59437B6EF56E92AF51907718");

  foreach(var_14 in level.players) {
    if(istrue(var_14.binseat)) {
      continue;
    }
    var_14 notify("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");

    if(isDefined(level.players_inside_plane)) {
      if(scripts\engine\utility::array_contains(level.players_inside_plane, var_14))
        continue;
    }

    var_14 notify("_encstr_960B0CE898D241092BF24B3D23E9");
    var_15 = scripts\engine\utility::random(var_12);
    var_12 = scripts\engine\utility::array_remove(var_12, var_15);
    var_16 = var_14 scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(var_16)) {
      var_17 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_16, var_14);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var_16, var_17, var_14, undefined, 1);
    }

    var_14 thread start_nonstealth_teleport_sequence(var_15);
  }

  thread upper_level_plane_combat_start();
  level notify("_encstr_B48811276D9D59CB08D30AD748D82F82E787F7");
  level thread scripts\cp\utility::_id_123FE("_encstr_A5B51D38D5DF08C7134798163177CB0B8A624F11B30F40FA587661333ABE80");
}

_id_14472() {
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    var_2 = scripts\mp\vehicles\vehicle_damage_mp::raid_seq3_objectives_func();

    if(var_2.size == 0) {
      scripts\cp\utility::objective_update("_encstr_A54E0C905A2303D079D8795BFEDF", 6, 3, 1, 1, undefined, 1);
      var_2 = scripts\mp\vehicles\vehicle_damage_mp::raid_seq3_objectives_func();

      if(var_2.size == 0) {
        break;
      }
    }

    waitframe();
  }
}

_id_13BBB(var_0) {
  level.disable_hotjoin_via_ac130 = var_0;
}

_id_12407() {
  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8DD31DA431391E0B763E1AF2834E7F1278EB562DE778A5179E3182AAEE87FA", 2);

  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B1B61DE5C82117C3BBBFE0B81FC17E69BA3668FDE90AC729824BE888EF4A5B", 2);

  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B2D31D1A52F0EF7AF0CF14E16F08496B81E932B21E36A776D09115EC1F22DA", 2);
}

_id_12B43(var_0) {
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_A66C17C67291EDF71A57D93A7375CDBDF8ABC770DA782B5CC5", "_encstr_9A8507BA4040188D08", 3.75);
  scripts\cp\utility::objective_update("_encstr_A54E0C905A2303D079D8795BFEDF", 6, 3, 1, 1, undefined, 1);

  foreach(var_4, var_2 in scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08")) {
    var_2 notify("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
    var_3 = 0;

    if(scripts\cp\cp_laststand::player_in_laststand(var_2) || var_2 isspectatingplayer())
      var_3 = 1;

    var_2 thread _encstr_AA4B3F734EB35FEA197016EA5097E537AB2EA71B5FBED3F5C528ABE3E0FF5EABA61D7F9E7D2347BCFF80E2AA88A995F79B75C7090EA81F87A3383A92180DCF17F1::player_regroup(level._id_12B45, var_4, var_3, "_encstr_88EF202C8DB1BE38C6B097B2C9B9BEE8CAB1951CB7391D5623FA8EB7AF1C1BB0CD2B", "_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959");
  }

  wait 3;
  level notify("_encstr_88EF202C8DB1BE38C6B097B2C9B9BEE8CAB1951CB7391D5623FA8EB7AF1C1BB0CD2B");
}

start_nonstealth_teleport_sequence(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.respawn_forcespawnorigin = var_0.origin;
  self.respawn_forcespawnangles = var_0.angles;
  self.forcespawnorigin = self.respawn_forcespawnorigin;
  self.forcespawnangles = self.respawn_forcespawnangles;

  if(istrue(self.isreviving)) {
    self.can_revive = 0;
    self._id_12D13 = self.forcespawnorigin;
    self notify("_encstr_86660C9CCAEC969DACF58C7BCDB2");
  }

  if(istrue(self.inlaststand)) {
    if(istrue(self.run_kill_watcher))
      self._id_11B09 = 1;

    if(istrue(self.being_revived)) {
      self notify("_encstr_86660C9CCAEC969DACF58C7BCDB2");
      self.being_revived = 0;
      self._id_11B09 = 1;
    } else {
      self notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
      self.binc130 = 1;

      if(isDefined(level.disguised_players)) {
        if(scripts\engine\utility::array_contains(level.disguised_players, self))
          remove_disguise(self);
      }

      return;
    }
  }

  level notify("_encstr_B49D197ED2390528B23798510FF18D59437B6EF56E92AF51907718");

  if(isDefined(level.choppergunners)) {
    foreach(var_2 in level.choppergunners)
    var_2 scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
  }

  if(isDefined(self.helperdrone))
    self.helperdrone scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);

  if(isDefined(self.currentturret)) {
    self.currentturret notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);
    waitframe();
  }

  self._id_132EA = 1;

  if(self istouching(level._id_12B48) || self istouching(level.c130._id_12A4F))
    self._id_132EA = undefined;

  if(istrue(self._id_132EA)) {
    foreach(var_5 in level.c130.body) {
      if(isDefined(var_5)) {
        if(self istouching(var_5)) {
          self._id_132EA = undefined;
          break;
        }

        self._id_132EA = 1;
      }
    }
  }

  if(istrue(self._id_132EA)) {
    foreach(var_8 in level.c130.plane_seats) {
      if(self istouching(var_8)) {
        self._id_132EA = undefined;
        break;
      }

      self._id_132EA = 1;
    }
  }

  if(istrue(self._id_132EA)) {
    if(isDefined(level.c130.shell)) {
      if(self istouching(level.c130.shell))
        self._id_132EA = undefined;
    }
  }

  if(istrue(self._id_132EA)) {
    if(self istouching(level.c130))
      self._id_132EA = undefined;
  }

  if(istrue(self._id_132EA) && !istrue(self._id_11B09)) {
    if(istrue(self.isjuggernaut)) {
      self notify("_encstr_88F016A6D53BCECAC93785571DFAAC9B32D7190BDA85EC56");
      waitframe();
    }

    self notify("_encstr_84C60FB29029874B3EFEA4A106C01FCB61");
    self.shouldskiplaststand = 1;
    self.shouldskipdeathsshield = 1;
    scripts\cp\cp_objectives::_id_12868("_encstr_A54E0C905A2303D079D8795BFEDF");
    self dodamage(self.maxhealth + 100000, self.origin);
    wait 1;
    self notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
    self.binc130 = 1;

    if(isDefined(level.disguised_players)) {
      if(scripts\engine\utility::array_contains(level.disguised_players, self))
        remove_disguise(self);
    }

    return;
  }

  if(istrue(self isparachuting()) || istrue(self isskydiving()))
    self skydive_interrupt();

  var_10 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_10)) {
    var_11 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_10, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var_10, var_11, self, undefined, 1);
  }

  if(istrue(self._id_11B09)) {
    self._id_11B09 = undefined;

    if(istrue(self.run_kill_watcher))
      thread _id_14338(var_0);
    else {
      thread scripts\cp\cp_laststand::instant_revive(self);
      self waittill("_encstr_9695073995D94BD959");
      self setclientomnvar("_encstr_A2AC0FAE96AFD02D19ACD7894BECB6B007", 1);
      self skydive_setbasejumpingstatus(0);
      self skydive_setdeploymentstatus(0);
      thread teleport_black_overlay(self);
      thread _id_13AE2();

      if(self.class == "_encstr_8CFF09D56D88EC030D69EB" || self.class == "_encstr_A12707B8AB65E9A9C3")
        self.disable_super = 1;

      self setmlgdamagedone();
      self setOrigin(var_0.origin, 1);
      thread start_turbulence_sequence();
      thread delay_set_plane_specific_vars(self, 3);

      if(!isDefined(var_0.angles))
        var_0.angles = (0, 0, 0);

      self setplayerangles(var_0.angles);
      self.binc130 = 1;
    }
  } else {
    self setclientomnvar("_encstr_A2AC0FAE96AFD02D19ACD7894BECB6B007", 1);
    self skydive_setbasejumpingstatus(0);
    self skydive_setdeploymentstatus(0);
    thread teleport_black_overlay(self);
    thread _id_13AE2();

    if(self.class == "_encstr_8CFF09D56D88EC030D69EB" || self.class == "_encstr_A12707B8AB65E9A9C3")
      self.disable_super = 1;

    self setmlgdamagedone();
    self setOrigin(var_0.origin, 1);
    thread start_turbulence_sequence();
    thread delay_set_plane_specific_vars(self, 3);

    if(!isDefined(var_0.angles))
      var_0.angles = (0, 0, 0);

    self setplayerangles(var_0.angles);
    self.binc130 = 1;
  }

  wait 3;
  level notify("_encstr_9699171843E193A5813750ED0DDA8B5B77BF78012BB4E96DCA");
  scripts\cp\utility::brjugg_setconfig(1);
  wait 2;
  self.can_revive = 1;

  if(isDefined(level.disguised_players)) {
    if(scripts\engine\utility::array_contains(level.disguised_players, self))
      remove_disguise(self);
  }
}

_id_14338(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(istrue(self.run_kill_watcher))
    waitframe();

  if(istrue(self.binc130)) {
    return;
  }
  self setclientomnvar("_encstr_A2AC0FAE96AFD02D19ACD7894BECB6B007", 1);
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  thread teleport_black_overlay(self);
  thread _id_13AE2();

  if(self.class == "_encstr_8CFF09D56D88EC030D69EB" || self.class == "_encstr_A12707B8AB65E9A9C3")
    self.disable_super = 1;

  self setmlgdamagedone();
  self setOrigin(var_0.origin, 1);
  thread start_turbulence_sequence();
  thread delay_set_plane_specific_vars(self, 3);

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  self setplayerangles(var_0.angles);
  self.binc130 = 1;
}

_id_13AE2() {
  scripts\mp\vehicles\vehicle_damage_mp::_id_1333E("_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959");
  wait 5;
  self setclientomnvar("_encstr_87DC0D2B694129CB535A4F55F99218", 0);
  self setclientomnvar("_encstr_A7FE1805DC2832CA4A98C780F74FB3BEE3CB30035701807931E0", 0);
}

play_seating_anim_and_exit(var_0, var_1) {
  var_1 waittill("_encstr_84C60FB29029874B3EFEA4A106C01FCB61");
  var_2 = 0.2;
  var_1 allowfire(0);
  var_1 scripts\cp\cp_disguise::enter_demeanor_relaxed();
  var_3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "_encstr_8BB007E03658CBCAE4", 1, 0, 0);
  var_1.actorplayer = var_3;
  var_3 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1);
  var_0 thread scripts\cp_mp\anim_scene::anim_scene_loop([var_3], "_encstr_A948160763583795FAB9D247D1D2E676AF1BEDDE0EFA8189", 1, 0, undefined, 0.2);
  wait(getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_A948160763583795FAB9D247D1D2E676AF1BEDDE0EFA8189"][0]));
  var_0 scripts\cp_mp\anim_scene::anim_scene_stop(1);
  var_0 scripts\cp_mp\anim_scene::anim_scene([var_3], "_encstr_822C13377C97D8D3C91360907B1C8DB1171DBB23DC", 0, 1, undefined, var_2);
  level notify("_encstr_9699171843E193A5813750ED0DDA8B5B77BF78012BB4E96DCA");
  var_1 unlink();
  var_1 allowfire(1);
  var_1 scripts\cp\cp_disguise::enter_demeanor_normal();
  var_1 thread start_turbulence_sequence();
  var_1 thread delay_set_plane_specific_vars(var_1, 3);
}

delay_set_plane_specific_vars(var_0, var_1) {
  wait(var_1);
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_0 scripts\cp\utility::giveperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
  var_0 scripts\cp\utility::giveperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");
  var_0 scripts\cp\utility::giveperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
  var_0 scripts\cp\utility::giveperk("_encstr_8D08176EC1956C2D16D83ABCFAA1ACB09347982759B0B5959C");
  var_0.attackeraccuracy = 6;
}

register_interactions() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\engine\utility::flag_exist("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC"))
    scripts\engine\utility::flag_init("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");

  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  scripts\cp\cp_interaction::registerinteraction("_encstr_83BA0D3AF7C9C7A287A86B03B0D71B", ::hack_radar_hint, ::hack_radar_activate, ::init_radar_activate, 0, "_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
  scripts\engine\utility::flag_set("_encstr_99A0281320C16A9198FB4D89C2B46AF186FCC144DBEB2BC2BF4E73423DD58B97957FDF5BFFDC6B26879B");
}

hack_radar_hint(var_0, var_1) {
  if(level.hack_region != var_0.name)
    return "_encstr_B40101";

  if(istrue(var_0.binprogress))
    return "_encstr_B40101";

  return &"_encstr_A1AF1727AF51B4DFA8CD435E816169EC6C7F8427AD910826A2";
}

hack_radar_activate(var_0, var_1) {
  if(level.hack_region != var_0.name) {
    return;
  }
  if(istrue(var_0.binprogress)) {
    return;
  }
  if(level.hacks_done == scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_83F00E0229E3C25CC660BFF720F9125B").radar_structs.size) {}

  level notify("_encstr_B48811276D9D59CB08D30AD748D82F82E787F7");
  var_2 = getdvarint("_encstr_A58D172BE2E5DFF3A0B62BCFB3E3AFC5A140F50F42D0DC8CED", 0);

  if(var_2 != 0)
    level.hack_duration = var_2;

  if(level.hack_region == "_encstr_A20F0CFBFB0E825958C9C90DE0A0") {
    if(istrue(level.global_stealth_broken)) {
      scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_A5E009137C82E371736F82");
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_860A0DD16126A058777AABD3220385");
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A7F50D43694B87A7F29F2F9F833743");
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_844414D18732B2F162CDF0E93357C0E02ABFBB6D0B9B");
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_915F125002CECFF6EB47980434F75BDFB2CAC038");
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_86DB14342CC6B6FA27DEBD33D1DE38D79BDCD2E0B29C");
      level.global_stealth_tracker["_encstr_A7F50D43694B87A7F29F2F9F833743"] = 1;
      var_3 = 2;
      level thread spawn_waves_after_a_delay(var_3, undefined, "_encstr_9B6D119CB7F6CC47B7077D9BC1B0EEE6B2276E");
    }

    level.hack_duration = 240;
  } else
    level.hack_duration = 300;

  if(!istrue(level.global_stealth_broken))
    level.hack_duration = level.hack_duration / 4;

  level thread scripts\cp\cp_objective_mechanics::starthackingdefense(scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_83F00E0229E3C25CC660BFF720F9125B"), var_0.origin + (-25, -15, 45), level.hack_duration, "_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27", 1024);
  var_1 playlocalsound("_encstr_8ED215BE0BE6C7C8558FBB3AFECFDB4896A672ADD7830B");
  var_0.router setModel("_encstr_AFAA1DF783ABC1A329532B5B3F4E9A15F0E9AAF1D960919B6863235BBBF6A2");
  var_0.router setscriptablepartstate("_encstr_A7F409337A498D17F7B75B", "_encstr_99AD06D3A5B1538B");
  var_0.binprogress = 1;
  var_0.model setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_AB0703DBB9");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");

  if(level.hack_region != "_encstr_A20F0CFBFB0E825958C9C90DE0A0")
    objective_unsetlocation(scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_83F00E0229E3C25CC660BFF720F9125B").objectiveindex, var_0.model.index);
  else {
    objective_setlocation(scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_83F00E0229E3C25CC660BFF720F9125B").objectiveindex, var_0.model.index, (-22823.7, 18783.8, -148.12));
    objective_state(scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_83F00E0229E3C25CC660BFF720F9125B").objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
    objective_setlabel(scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_83F00E0229E3C25CC660BFF720F9125B").objectiveindex, &"_encstr_93C217669F07D8958DC19B66C1C4AB21BB373BE9EEFFA0C5F7");
  }

  if(level.hacks_done == 1)
    level thread scripts\cp\utility::_id_123FE("_encstr_97A41FD6BA37FA1BC1F52C39B6CD93C2B1567D995A3695E6FA1BB783A559C8AFC8");
  else if(level.hacks_done == 2)
    level thread scripts\cp\utility::_id_123FE("_encstr_ADA41F6BEAB9FA3607EBC2395BB99C85D895BECCA5D856E6D736BDE096CA327D99");

  var_0.router setscriptablepartstate("_encstr_A7F409337A498D17F7B75B", "_encstr_B4BA07CC5ADCB4CDD0");

  if(level.hack_region == "_encstr_A20F0CFBFB0E825958C9C90DE0A0") {
    level.hack_region = "_encstr_A60108C05863AB184BF8";
    scripts\cp\utility::objective_update("_encstr_8C2E103B606760E42EC8C823F947E31BDF35", undefined, undefined, undefined, 1, undefined, 1);
    thread _id_12418();
    level thread _id_12403(["_encstr_8EC421036120BAF818966D360BC00F4301EBA39F475742B22878E27BA640798A70A362", "_encstr_B2822123E1BE36C1B97D6D2C5BB0AF071B589B59BE0B2D93E0F63947BECD0B76F5C860"], 30);
  } else
    thread _id_123C1();

  foreach(var_6, var_5 in level.radar_models) {
    var_5.index = var_6;

    if(var_5.region == "_encstr_A60108C05863AB184BF8") {
      objective_setlocation(scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_83F00E0229E3C25CC660BFF720F9125B").objectiveindex, var_5.index, (-22823.7, 18783.8, -148.12));
      objective_state(scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_83F00E0229E3C25CC660BFF720F9125B").objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
      objective_setlabel(scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_83F00E0229E3C25CC660BFF720F9125B").objectiveindex, &"_encstr_93C217669F07D8958DC19B66C1C4AB21BB373BE9EEFFA0C5F7");

      if(istrue(level.global_stealth_broken)) {
        scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_860A0DD16126A058777AABD3220385");

        if(istrue(level.wave_cooldown_active)) {}

        level thread vehicle_occupancy_clearforceweaponswitchallowed();
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", [scripts\cp\cp_modular_spawning::_id_11CAC, 750]);
        scripts\cp\cp_modular_spawning::run_func_on_group_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", [scripts\cp\cp_modular_spawning::_id_11CAB, 64]);
        scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
        scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_88810E470BC9B5581BF507161DC9F68D");
        scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A721148C3B68A587B6E6130AAB16875DA9811CE14D88");
        scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A99C140D0B6CB57DC2D239E0B79C3AFA36EDB6312C47");
        continue;
      }

      level thread vehicle_occupancy_clearforceweaponswitchallowed();
    }
  }

  var_0.model setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_AB0703DBB9");
  var_0.binprogress = undefined;
  level.hacks_done++;
  level thread scripts\cp\utility::_id_123FE("_encstr_B40101");

  if(level.hacks_done == scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_83F00E0229E3C25CC660BFF720F9125B").radar_structs.size)
    level notify("_encstr_9B4716237F034CBA6D8385A459F340C4277C3BE5F07055DF");
}

vehicle_occupancy_clearforceweaponswitchallowed() {
  wait 45;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A9CF1B34166CADBEC25A3983F6E48EF553EAB3ECEB2396B9B3AED237AC");
}

_id_12418() {
  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_91362A30EB974BC833796593228E8E990B071288D15B8868294BE039CF94C3BF5F7F0F0F0837E7331FC63A70");

  if(!istrue(level.global_stealth_broken)) {
    while(istrue(level.dialogue_playing))
      wait 1;

    scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B2442AD29A3817823817DBD91BC00123D9D1EA4AC606EFBD4879C7B067B056A7F28EB3F3A9569FF2C8C792F8", 1);
  }

  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_99322391BBA9EEE01BB9F8515AE3619F72470D2B8F12A3B8308D230B49D1A0D52B97F70B4A", 1);
}

_id_123C1() {
  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_BECD2A5F7BF77A203BA1CFEF1851D793791F25977033926A233893A371A8A1EA2FB8EA0BC65FEA936BD196BA");

  if(!istrue(level.global_stealth_broken))
    return;
}

init_radar_activate(var_0) {
  level.hacks_done = 0;
  level thread scripts\cp\cp_hacking::hacking_init();
  level.radar_models = [];

  if(var_0.size > 0) {
    foreach(var_2 in var_0) {
      var_2.model = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
      var_2.model setModel("_encstr_9B8528AD5A1BD247589C2FFAA117F56C4E583A2BFA0698BE0EC9DB0FCBD71B0EEBCD1C0BDD738598632B");

      if(!isDefined(var_2.angles))
        var_2.angles = (0, 0, 0);

      var_2.model.angles = var_2.angles;
      var_2.model.region = var_2.name;
      var_2.router = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
      var_2.router setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

      if(!isDefined(scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles))
        var_2.angles = (0, 0, 0);

      var_2.router.angles = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles;
      var_2.router.region = var_2.name;
      var_2.model.router = var_2.router;
      level.radar_models = scripts\engine\utility::array_add(level.radar_models, var_2.model);
      var_2.origin = var_2.router.origin;
      var_2.angles = var_2.router.angles;
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
    }
  }
}

register_plane_hijack_objectives() {
  scripts\cp\cp_objectives::registerobjective("_encstr_83F00E0229E3C25CC660BFF720F9125B", ::init_plant_jammers, ::start_plant_jammers, ::end_plant_jammers, scripts\cp\cp_objectives::debugbeatobjective, ::debugplantjammers);
  scripts\cp\cp_objectives::registerobjective("_encstr_91C513A862ED2116D37D3820459BDEA7524AD008BB", ::init_kill_tunnel_spawns, ::start_kill_tunnel_spawns, ::end_kill_tunnel_spawns, scripts\cp\cp_objectives::debugbeatobjective, ::debugkill_tunnel_spawns);
  scripts\cp\cp_objectives::registerobjective("_encstr_B8190FB22EAB96C1F519A56ED9BAB4CDAC", ::init_equip_disguise, ::start_equip_disguise, ::end_equip_disguise, scripts\cp\cp_objectives::debugbeatobjective, ::debugequip_disguise);
  scripts\cp\cp_objectives::registerobjective("_encstr_A54E0C905A2303D079D8795BFEDF", ::init_infil_plane, ::start_infil_plane, ::end_infil_plane, scripts\cp\cp_objectives::debugbeatobjective, ::debuginfil_plane);
  scripts\cp\cp_objectives::registerobjective("_encstr_B64C0D22D01BE8836733DFF69FBF6A", ::init_destroy_c130, ::start_destroy_c130, ::end_destroy_c130, scripts\cp\cp_objectives::debugbeatobjective, ::debugstartdestroyc130);
  scripts\cp\cp_objectives::registerobjective("_encstr_B2E0151BF663D8AC6CE87DDCD5B136560B277D8DEDC959", ::init_collect_nuclear_core, ::start_collect_nuclear_core, ::end_collect_nuclear_core, scripts\cp\cp_objectives::debugbeatobjective, ::debugstartc130objective);
  scripts\cp\cp_objectives::registerobjective("_encstr_B4430C432023FB09C10841118DBA", ::init_exfil_plane, ::start_exfil_plane, ::end_exfil_plane, scripts\cp\cp_objectives::debugbeatobjective, ::debugexfilc130objective);
  scripts\cp\cp_objectives::registerobjective("_encstr_A1600B9921A51898B76BCE90B3", ::init_land_at_lz, ::start_land_at_lz, ::end_land_at_lz, scripts\cp\cp_objectives::debugbeatobjective, ::debuglandatlz);
  scripts\cp\cp_objectives::registerobjective("_encstr_812B08C015BCF0608B33", ::init_holdout, ::start_holdout, ::end_holdout, scripts\cp\cp_objectives::debugbeatobjective, ::debugholdout);
  scripts\cp\cp_objectives::registerobjective("_encstr_A9F80B8D207BDD1953FBD978FB", ::init_extract_lz, ::start_extract_lz, ::end_extract_lz, scripts\cp\cp_objectives::debugbeatobjective, ::debugextractlz);
  scripts\cp\cp_objectives::registerobjective("_encstr_A19215CA05D90F336330697220476DFF71761F53A8436F", ::init_recover_nuclear_core, ::start_recover_nuclear_core, ::end_recover_nuclear_core, scripts\cp\cp_objectives::debugbeatobjective, ::debugrecover_nuclear_core);
}

init_plant_jammers(var_0, var_1) {
  scripts\engine\utility::flag_wait("_encstr_99A0281320C16A9198FB4D89C2B46AF186FCC144DBEB2BC2BF4E73423DD58B97957FDF5BFFDC6B26879B");
  scripts\cp\utility::skydivestreamhintdvars("_encstr_84E81590A371C0C3F1E443DABEEA072ED90F0808C71ADB");
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  scripts\cp\cp_modular_spawning::stop_all_groups();
  level.phj_spawners_trigger = getEnt("_encstr_962D0D83864DBE37E0C2DDE6AC9C9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setlocation(var_0.objectiveindex, 0, level.phj_spawners_trigger.origin);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_84B023193CF5C607CDAFADB0B516D707362CDCB27D4E7BBD338E7BC1BEB49BA3E4DBEB9806");
  level notify("_encstr_B83117F8F9E1DAC32823FBCAA7C9F209F0915DAF457127F59C");
  level.battlechatterenabled = 0;
  level._id_139B5 = 1;
  level.phj_spawners_trigger thread watch_for_phj_spawners_triggered();
  thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_9209227433E6871AE70132FA783F19033817F6EDD82BEFE5E5B00AE33161CEF730901130", 1);
  level thread _id_12403(["_encstr_975F210AD137034957AFA830C348E7A8D890AAD5E1AD58B0F24B48BBC6100730A1B2C7", "_encstr_A65F213AB8C7AEB303C80B39F9694732F918E2A2193565175945072098D0873F773A8F", "_encstr_B87121F948F9301FEFE9982133374060CDA96563C71A08E8D373F00B196B07A0A95321"], 30);
  level.hack_region = "_encstr_A20F0CFBFB0E825958C9C90DE0A0";
  var_0.radar_structs = scripts\engine\utility::getStructArray("_encstr_83BA0D3AF7C9C7A287A86B03B0D71B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  scripts\cp\cp_objectives::_id_1317E(var_0, [var_0.radar_structs[0].origin, (-22823.7, 18783.8, -148.12)]);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");

  foreach(var_4, var_3 in level.radar_models) {
    var_3.index = var_4;

    if(var_3.region == "_encstr_A20F0CFBFB0E825958C9C90DE0A0") {
      objective_setlocation(var_0.objectiveindex, var_3.index, var_3.router.origin);
      objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
    }
  }

  foreach(var_6 in scripts\engine\utility::getStructArray("_encstr_B4D515B0964E38B7E48EFAB32BA1EBCD83C2EE73594E6E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
    switch (var_6.script_noteworthy) {
      case "_encstr_84D70A6B2BEF3C9B30A67164":
        scripts\cp\vehicles\technical_cp::spawn_technical_at_location(var_6.origin, var_6.angles, "_encstr_9A8507BA4040188D08", 1);
        break;
      case "_encstr_8C190467402B":
        var_7 = spawnStruct();
        var_7.origin = var_6.origin;
        var_7.angles = var_6.angles;
        var_7.team = "_encstr_9A8507BA4040188D08";
        var_8 = scripts\cp_mp\vehicles\atv::atv_create(var_7);

        if(!isDefined(level.atvs))
          level.atvs = [];

        level.atvs = scripts\engine\utility::array_add(level.atvs, var_8);
        break;
    }
  }
}

_id_12403(var_0, var_1) {
  level notify("_encstr_A31415EB716983313797C7DB790AE360A931832BB66937");
  level endon("_encstr_A31415EB716983313797C7DB790AE360A931832BB66937");
  level endon("_encstr_A9A411BD7E83FEFDC5D21890CA5AEF90EF1F3E");
  level endon("_encstr_96C71197C53D07D3D0E2E04A921B515ACBD8C3");
  level endon("_encstr_B4581005780550FAF3C54BA998B713E35F87");
  level endon("_encstr_A2F00EA3D32AC0301D65A8660DC1900E");
  level endon("_encstr_9AA30E56B919EB560FA5A37DCD16CEDC");
  level endon("_encstr_B48811276D9D59CB08D30AD748D82F82E787F7");
  var_2 = 0;

  for(;;) {
    if(istrue(level.dialogue_playing)) {
      wait 3;
      continue;
    }

    scripts\cp\cp_dialogue::play_vo_to_all(var_0[var_2], var_1);
    var_2++;

    if(var_2 >= var_0.size)
      var_2 = 0;
  }
}

watch_for_phj_spawners_triggered() {
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      waitframe();
      continue;
    }

    break;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_91CB0C9AAEB3ECFA0EC21D39B78D");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AB350B6567C20441A79BE19BC7");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A7F50D43694B87A7F29F2F9F833743");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_844414D18732B2F162CDF0E93357C0E02ABFBB6D0B9B");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_915F125002CECFF6EB47980434F75BDFB2CAC038");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_86DB14342CC6B6FA27DEBD33D1DE38D79BDCD2E0B29C");
  level.phj_spawners_trigger delete();
}

watch_for_spawner_triggered() {
  level endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      waitframe();
      continue;
    }

    players_reached_airport();
    self delete();
  }
}

start_plant_jammers(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread scripts\cp\utility::_id_123FE("_encstr_9A071C5BAB6EFA3607FAB04E6BDC9C586CCAD795DC2B5B5EEBD8B7D6AD37");
  level notify("_encstr_BAD71630FA7365C8D3A12D73EFFCE83B53E249D8D2DBAD28");
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_B48523BF11AF88FA59F7C01AEC8137A0F8C11F2F81A080B5E1508CD6050967D85F41939F21");
  level.airport_spawners_trigger = getEnt("_encstr_A14E16413402F0C05B5337775BB214C897CBABD8DF7F2B06", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.airport_spawners_trigger thread watch_for_spawner_triggered();
  level waittill("_encstr_9B4716237F034CBA6D8385A459F340C4277C3BE5F07055DF");
  level.hack_region = undefined;

  if(istrue(level.global_stealth_broken)) {
    thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_954E2A92DA7857C278579B99DB0BC1E31911AA0A86C643FFB0099C68A720D2D732092211A99783755807D138");
    scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_A54E0C905A2303D079D8795BFEDF");
  }
}

end_plant_jammers(var_0, var_1) {}

debugplantjammers(var_0, var_1) {
  scripts\engine\utility::flag_set("_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E");
  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_ACE712DCC2916A690E98403B1C2723D7C9DEDB47", 1);
}

player_give_gg_loadout() {
  thread give_stealth_loadout();
}

give_stealth_loadout() {
  wait 3;
  var_0 = self getcurrentweapon();
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    switch (weaponclass(var_3)) {
      case "_encstr_BE1904DCDA9D":
        var_4 = scripts\cp\cp_weapon::addattachmenttoweapon(var_3, "_encstr_AD3E09B95A632BDC6CCA27", "_encstr_8E5F063CDA2C3BCD", "_encstr_AB45097102C9209CFA7B51", "_encstr_A28305178878FF");
        self takeweapon(var_3);
        break;
      case "_encstr_965306392D3336B2":
        var_4 = scripts\cp\cp_weapon::addattachmenttoweapon(var_3, "_encstr_AD3E09B95A632BDC6CCA27", "_encstr_8E5F063CDA2C3BCD", "_encstr_AB45097102C9209CFA7B51", "_encstr_931A070469021BF0D9");
        self takeweapon(var_3);
        break;
      case "_encstr_850707F7E5833355B8":
        var_4 = scripts\cp\cp_weapon::addattachmenttoweapon(var_3, "_encstr_AD3E09B95A632BDC6CCA27", "_encstr_8E5F063CDA2C3BCD", "_encstr_A3CA081B50EDAB3D60A9");
        self takeweapon(var_3);
        break;
      case "_encstr_BE0703A54C":
        var_4 = scripts\cp\cp_weapon::addattachmenttoweapon(var_3, "_encstr_AD3E09B95A632BDC6CCA27", "_encstr_8E5F063CDA2C3BCD", "_encstr_AB45097102C9209CFA7B51", "_encstr_931A070469021BF0D9");
        self takeweapon(var_3);
        break;
      case "_encstr_A1100738A33A638123":
        var_4 = scripts\cp\cp_weapon::addattachmenttoweapon(var_3, "_encstr_A3D30A9BD263B29B6C959C19", "_encstr_9B6B081A7BABC93A37DE", "_encstr_8B060D0EA56EE87B8D9D934B070399");
        self takeweapon(var_3);
        break;
      case "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0":
        break;
      case "_encstr_8D940738966ED1DB8D":
        var_4 = scripts\cp\cp_weapon::addattachmenttoweapon(var_3, "_encstr_AD3E09B95A632BDC6CCA27", "_encstr_8E5F063CDA2C3BCD", "_encstr_91EC068D0B372B93", "_encstr_A28305178878FF");
        break;
      default:
        break;
    }
  }

  thread scripts\cp\cp_powers::givepower("_encstr_A22A16E07BEE5693EB9B732C83B934EDE83AE4B2E658C895", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 10);
}

init_kill_tunnel_spawns(var_0, var_1) {}

start_kill_tunnel_spawns(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A9AF1047EAB9372B8DAF9B0758EEB95927B9");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B82D1485E35A6519DCD710B033D71391728B7085BA23");

  while(!istrue(level.clear_to_pick_disguise_up) || !istrue(level.clear_to_pick_disguise_up_veh))
    waitframe();
}

end_kill_tunnel_spawns(var_0, var_1) {
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

debugkill_tunnel_spawns(var_0) {
  scripts\engine\utility::flag_set("_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E");
  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
}

spawn_ai_giving_disguise() {
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A9070A7FDB8846BF95C622AA");
}

play_ai_skit(var_0, var_1) {
  thread skit_logic();
}

ally_death() {
  self dodamage(self.health + 100, self.origin);
  scripts\cp\cp_skits::reset_guy(self);
}

skit_logic() {
  self.maxhealth = 69;
  self.health = 69;
  self.goal_ent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);

  while(!istrue(level.show_garage_waypoint) && !istrue(level.global_stealth_broken))
    wait 0.1;

  if(istrue(level.global_stealth_broken) && !istrue(level.show_garage_waypoint)) {
    ally_death();
    return;
  }

  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_ACEB165FF1E0281D5115A2E5AD5143705D7B97DF070694D6");

  while(level.disguised_players.size < level.players.size && !istrue(level.global_stealth_broken))
    wait 0.1;

  run_and_die();
}

run_and_die() {
  self notify("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  scripts\cp\cp_modular_spawning::set_goal_radius(256);
  scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("_encstr_AA7C07466F9DA30713");
  thread move_goal_ent(self.goal_ent);
}

civ_killers_loop(var_0, var_1, var_2, var_3) {
  self.scripted_mode = 1;
  level.fight_enemy = self;
}

move_goal_ent(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self setgoalentity(self.goal_ent, 250);
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_976D111A0A7D32AA21054AE5D0292BAF49AA9C");

  foreach(var_2 in level.players)
  var_2 scripts\cp\utility::allow_player_ignore_me(1);

  var_4 = scripts\engine\utility::getStruct("_encstr_AB460FF1C4D65995FA375111B7E3E7908C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_0 moveTo(var_4, 2);
  self setgoalpos(var_4);
  scripts\engine\utility::_id_143BA(5, "_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
  thread spawnapc();
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B13A0C9FFF3BF0380175F8D11AE3");
  self.ignoreme = 0;
  ally_death();

  foreach(var_2 in level.players)
  var_2 scripts\cp\utility::allow_player_ignore_me(0);

  level.fight_enemy kill();

  if(soundexists("_encstr_967915892759C26C86D7D886F5591E0E8DFA8E2716B9CD"))
    playsoundatpos(var_4, "_encstr_967915892759C26C86D7D886F5591E0E8DFA8E2716B9CD");

  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_A34F148E3AD9A58F621F817253BD444121D715078384");
  var_0 delete();
}

init_equip_disguise(var_0, var_1) {
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);

  if(istrue(level.global_stealth_broken))
    level thread spawn_waves_after_a_delay(undefined, undefined, "_encstr_99BD102D5DDEDF5ECFE1FB712B87852385FF");
  else
    thread start_tunnel_sequence();

  thread _id_123DC();
  level.disguised_players = [];
  objective_onentity(var_0.objectiveindex, level.garage_door.door_interaction);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  objective_setlabel(var_0.objectiveindex, &"_encstr_BE0711ADD75F4047E4816777B19D1FB8F9C5E5");
  level.can_open_door = 1;
  level.disguise_ent = getEnt("_encstr_BDCA0D5D345BA7CB099778B1D756A3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

_id_123DC() {
  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_860623C97829E0CF3F1968F1E3071030BDF955B337CD689D8BF161F88B3F3D209255AF93E0", 4);
}

watch_for_disguise_vehicle_death(var_0) {
  self waittill("_encstr_AD75063D571AE108");

  if(istrue(level.global_stealth_broken)) {
    scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_A54E0C905A2303D079D8795BFEDF");
    return;
  }

  level.disguise_ent = getEnt("_encstr_BDCA0D5D345BA7CB099778B1D756A3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_onentity(var_0.objectiveindex, level.disguise_ent);
  level.disguise_ent setHintString(&"_encstr_AC0F1FFF287F0E9F6587C940592705C3B25EAF9B19FF23C3EB4BFF7EC071188B81");
  level.disguise_ent sethintdisplayrange(200);
  level.disguise_ent sethintdisplayfov(120);
  level.disguise_ent setusefov(120);
  level.disguise_ent setuserange(72);
  level.disguise_ent sethintonobstruction("_encstr_BD1805CB69C063");
  level.disguise_ent makeusable();
  level.disguise_ent thread grab_disguise();
}

grab_disguise() {
  self notify("_encstr_88690EC0B236661704DF9ECFB309D7C0");
  self endon("_encstr_88690EC0B236661704DF9ECFB309D7C0");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(scripts\engine\utility::array_contains(level.disguised_players, var_0)) {
      continue;
    }
    thread give_disguise_via_clothes(var_0);
    thread _id_1240C(var_0);
  }
}

_id_1240C(var_0) {
  while(istrue(var_0.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_player(var_0, "_encstr_8DED24B5F0F7E1714A69F8A062E677DB5391C8BD7FA368BFB7D3D0289A31CDF0EF364538891A");
  var_1 = lookupsoundlength("_encstr_8DED24B5F0F7E1714A69F8A062E677DB5391C8BD7FA368BFB7D3D0289A31CDF0EF364538891A") / 1000;
  wait(var_1 + 1);

  while(istrue(var_0.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_player(var_0, "_encstr_B1E324230FAFC6079BAFB1C2B9E6AF071BC2E659BE234B9B76D596B9B27D33EDD5CD19EB4681");
}

give_disguise_via_clothes(var_0) {
  disguise_player(var_0);
  level notify("_encstr_810D11DAD07F4F47A03EE527DC2BDFD6851862");
}

start_equip_disguise(var_0, var_1) {
  while(!istrue(level.show_garage_waypoint) && !istrue(level.global_stealth_broken))
    wait 0.1;

  var_2 = scripts\engine\utility::getStruct("_encstr_9562131DB26C0DB9966C1663AFB9E016EE37CA27DC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.disguise_technical = scripts\cp\vehicles\technical_cp::spawn_technical_at_location(var_2.origin, var_2.angles, "_encstr_9A8507BA4040188D08", 1);
  level.disguise_ent setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  level.disguise_ent setHintString(&"_encstr_AC0F1FFF287F0E9F6587C940592705C3B25EAF9B19FF23C3EB4BFF7EC071188B81");
  level.disguise_ent sethintdisplayrange(200);
  level.disguise_ent sethintdisplayfov(120);
  level.disguise_ent setusefov(120);
  level.disguise_ent setuserange(72);
  level.disguise_ent sethintonobstruction("_encstr_BD1805CB69C063");
  level.disguise_ent makeusable();
  level.disguise_ent thread grab_disguise();

  if(!istrue(level.global_stealth_broken))
    thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_9B6F23193CF56C07B9F5B10BCDB9BE073616CD56EBB39C16C47D91D2DC9D5796CDACFA4C18");
  else
    scripts\cp\cp_dialogue::play_vo_to_all("_encstr_831829F1DBF7E73FB227D8CF60395032810F660DFE6363E8A0F9D3D8BF0D86484855554839A2D3770F81AA");

  objective_onentity(var_0.objectiveindex, level.disguise_ent);
  objective_setlabel(var_0.objectiveindex, &"_encstr_93BF187847E04B0349E33A5FF1C95A870D9CF1800ED10F8E19D1");
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  thread _id_12429();

  while(level.disguised_players.size < level.players.size && !istrue(level.global_stealth_broken))
    wait 0.1;

  level notify("_encstr_811D1B41EDE9BF192BC73A09B3BB99691F03E96751E89667F5D3EFD160");
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::givedisguiseonspawn);
  objective_unsetlocation(var_0.objectiveindex, 0);
}

_id_12429() {
  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8FA3237953410638B311A0F9858909C7CA9FF5F3371ADB18FFF3E8B3AF4FB8F092371FA322");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_931A230768D15FD33B69596F4AE8776279BFD567B783225F31283A6397F732E76FC8A81E8A", 1);
}

givedisguiseonspawn() {
  thread wait_for_spawn_loop_to_finish();
}

wait_for_spawn_loop_to_finish() {
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  disguise_player(self);
  level notify("_encstr_810D11DAD07F4F47A03EE527DC2BDFD6851862");
}

end_equip_disguise(var_0, var_1) {
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

debugequip_disguise(var_0) {
  scripts\engine\utility::flag_set("_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E");
  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 10;
  level thread global_weapons_free();
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_91E216CD204ECA4FBFEFB91E5223A3AD2310609F68186403", 1);
}

disguise_player(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_1)) {
    if(istrue(var_1)) {
      var_0 playSound("_encstr_B62211136090306F248073B3B1C64B39CC36CB");
      var_0.disguise_overlay = scripts\cp\utility::create_client_overlay("_encstr_B28311ABA5BE378DB0C9CCEBDB3BB2271B585E", 1.0, var_0);
    } else {}
  } else {}

  var_0 playSound("_encstr_B62211136090306F248073B3B1C64B39CC36CB");
  var_0 scripts\cp_mp\gasmask::createoverlay();
  var_0 setcustomization("_encstr_B29028EAA8B22B4982871F11F3AB7B7F16B509BBA99DAF83CA834031780BFBEB79AA4E8E73BF8D0F0751", "_encstr_83B02360371150D8AA43375B1F939590BA4D0E395C6A2B0502EF5B2727DA5EA07F66139693");
  var_2 = var_0 getcustomizationbody();
  var_3 = var_0 getcustomizationhead();
  var_4 = var_0 getcustomizationviewmodel();
  var_0 scripts\cp\survival\survival_loadout::setcharactermodels("_encstr_B29028EAA8B22B4982871F11F3AB7B7F16B509BBA99DAF83CA834031780BFBEB79AA4E8E73BF8D0F0751", "_encstr_83B02360371150D8AA43375B1F939590BA4D0E395C6A2B0502EF5B2727DA5EA07F66139693", "_encstr_9ADA1667D2ACBBD0B0E6466EFAAD07AF310B6E59F5A5DD1C");
  var_5 = "_encstr_8B1B10E7D8E125229366B137C767CBFDEBC0";
  var_6 = spawnStruct();
  var_6.operatorref = var_5;
  var_6.skinref = 1;
  var_6.body = var_2;
  var_6.head = var_3;
  var_6.vm = var_4;
  var_6.gender = scripts\cp\survival\survival_loadout::getoperatorgender(var_5);
  var_6.voice = scripts\cp\survival\survival_loadout::getoperatorvoice(var_5);
  var_6.superfaction = scripts\cp\survival\survival_loadout::getoperatorsuperfaction(var_5);
  var_0.operatorcustomization = var_6;
  var_0.disguised = 1;

  if(isDefined(var_1)) {
    if(istrue(var_1)) {} else {}
  } else {}

  if(!isDefined(level.disguised_players))
    level.disguised_players = [];

  if(!scripts\engine\utility::array_contains(level.disguised_players, var_0))
    level.disguised_players = scripts\engine\utility::array_add(level.disguised_players, var_0);

  var_0 thread watch_for_disguised_player_disconnect();
  var_0 thread watch_for_disguised_player_death();
  level notify("_encstr_810D11DAD07F4F47A03EE527DC2BDFD6851862");
}

watch_for_disguised_player_death() {
  self notify("_encstr_8D6B26EE2CE8C643EB99BD4EAF91A59BCE572D6EB246BE1C63585E2B9CFA2396B9B1F6CDE6CA6C8E");
  self endon("_encstr_8D6B26EE2CE8C643EB99BD4EAF91A59BCE572D6EB246BE1C63585E2B9CFA2396B9B1F6CDE6CA6C8E");
  self endon("_encstr_A66422943B90AF2B4DEE4A827394E764D093370C5908F747E583F1EAF8E0AB9DA8338572");
  self waittill("_encstr_AD75063D571AE108");
  scripts\cp_mp\gasmask::destroyoverlay();

  if(istrue(self.disguised))
    self.disguised = undefined;

  if(scripts\engine\utility::array_contains(level.disguised_players, self))
    level.disguised_players = scripts\engine\utility::array_remove(level.disguised_players, self);
}

watch_for_disguised_player_disconnect() {
  self notify("_encstr_8D6B26EE2CE8C643EB99BD4EAF91A59BCE572D6EB246BE1C63585E2B9CFA2396B9B1F6CDE6CA6C8E");
  self endon("_encstr_8D6B26EE2CE8C643EB99BD4EAF91A59BCE572D6EB246BE1C63585E2B9CFA2396B9B1F6CDE6CA6C8E");
  self endon("_encstr_A66422943B90AF2B4DEE4A827394E764D093370C5908F747E583F1EAF8E0AB9DA8338572");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(self.disguised))
    self.disguised = undefined;

  if(scripts\engine\utility::array_contains(level.disguised_players, self))
    level.disguised_players = scripts\engine\utility::array_remove(level.disguised_players, self);
}

watch_for_disguised_player_last_stand() {
  self notify("_encstr_A6CC269B017368820160179057EBDB8BBA85E3DB758AD18A511FF2930AF7F9D2936B7750A388A042");
  self endon("_encstr_A6CC269B017368820160179057EBDB8BBA85E3DB758AD18A511FF2930AF7F9D2936B7750A388A042");
  self endon("_encstr_A66422943B90AF2B4DEE4A827394E764D093370C5908F747E583F1EAF8E0AB9DA8338572");
  self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");

  if(istrue(self.disguised))
    self.disguised = undefined;

  if(scripts\engine\utility::array_contains(level.disguised_players, self))
    level.disguised_players = scripts\engine\utility::array_remove(level.disguised_players, self);
}

remove_disguise(var_0, var_1) {
  if(!nullweapon(var_0 getcurrentweapon())) {
    var_2 = var_0 forceplaygestureviewmodel("_encstr_91560DECCA9BBEB34BB97B277DABE0");
    var_0 notify("_encstr_92AF16EFA02B876B431E6F4790439871A158FD7541365A45");
    wait 0.5;
  }

  scripts\cp_mp\gasmask::destroyoverlay();
  var_3 = var_0 scripts\cp\survival\survival_loadout::get_player_character_num();
  var_0 thread scripts\cp\survival\survival_loadout::setmodelfromcustomization(var_3);
  var_4 = scripts\cp\survival\survival_loadout::getplayermodelindex();
  var_5 = var_0 scripts\cp\survival\survival_loadout::getplayerfoleytype(var_4);
  var_0.disguised = undefined;

  if(scripts\engine\utility::array_contains(level.disguised_players, var_0))
    level.disguised_players = scripts\engine\utility::array_remove(level.disguised_players, var_0);

  delete_player_overlay(var_0);

  if(!istrue(var_1))
    reenable_ai_for_player(var_0);
}

reenable_ai_on_player_fire_or_kill(var_0) {
  var_0 notify("_encstr_88432375F5D7F8370BBAD98672FFE038AD77F9D199B8F886D7F2502B1A4FA06809AB73590C");
  var_0 endon("_encstr_88432375F5D7F8370BBAD98672FFE038AD77F9D199B8F886D7F2502B1A4FA06809AB73590C");
  var_0 endon("_encstr_A66422943B90AF2B4DEE4A827394E764D093370C5908F747E583F1EAF8E0AB9DA8338572");

  for(;;) {
    var_0 waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
    reenable_ai_for_player(var_0);
    break;
  }
}

reenable_ai_for_player(var_0) {}

delete_player_overlay(var_0) {
  if(isDefined(var_0.disguise_overlay))
    var_0.disguise_overlay destroy();
}

watch_for_disguised_player_enter_vehicle() {
  self notify("_encstr_8C4A29ABF1E56FFC113D9772B73044E784EBC253D9B5E7B2A01B896DC5C10FCBB501EB19C39DF32C80198D");
  self endon("_encstr_8C4A29ABF1E56FFC113D9772B73044E784EBC253D9B5E7B2A01B896DC5C10FCBB501EB19C39DF32C80198D");
  self endon("_encstr_A66422943B90AF2B4DEE4A827394E764D093370C5908F747E583F1EAF8E0AB9DA8338572");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143AF("_encstr_964E133AAC1B3437961BC21B7D59E6A3CA9C51E646", "_encstr_AF6912946DB17B4D03D0D27A496380370BD5063C", "_encstr_B6F4108D9DFB87CA4858AFBB0960603AA3CF", "_encstr_9A010FA803DC612103C7A415D81FA90987");

    if(var_0 == "_encstr_B6F4108D9DFB87CA4858AFBB0960603AA3CF" || var_0 == "_encstr_857115E0B10B5ECAE4FACAE63A2BE4F53B950D4B6CB1B2") {
      if(!istrue(self.first_time_enter_vehicle) && var_0 == "_encstr_B6F4108D9DFB87CA4858AFBB0960603AA3CF") {
        self.first_time_enter_vehicle = 1;
        disguise_player(self);
        level notify("_encstr_810D11DAD07F4F47A03EE527DC2BDFD6851862");
      }

      self.gasmaskoverlay.alpha = 0;
      continue;
    }

    if(var_0 == "_encstr_9A010FA803DC612103C7A415D81FA90987" || var_0 == "_encstr_826B147091C9EABD482911E3EF0301A661B8D2EB626D") {
      self.gasmaskoverlay fadeovertime(0.1);
      self.gasmaskoverlay.alpha = 1;
    }
  }
}

init_infil_plane(var_0, var_1) {
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  level.players_in_c130 = 0;
  scripts\cp\cp_objectives::_id_1317E(var_0, scripts\engine\utility::getStruct("_encstr_B47F10C250D0B68260174B137B16DBF930D9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");

  if(istrue(level.global_stealth_broken))
    scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_83E009D0D24D85366DBE46");

  thread _id_1445D();
  level.players_in_plane = [];

  foreach(var_3 in level.players)
  var_3 thread watch_for_players_in_plane();

  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::watch_for_players_in_plane);

  if(getdvarint("_encstr_A250119F9776B93C48506FF5E9284F43450F0B", 0) != 0)
    wait 10;
  else if(getdvarint("_encstr_A34111DEBE43DFD039EB68088357CEF15A22D5", 0) != 0)
    wait 10;
  else
    level thread spawn_convoys_as_players_get_closer();

  if(getdvarint("_encstr_868E12B8AF52F6D1E2D53E502ABA037BAD03B0B0", 0) != 0) {
    level.c130.origin = (-5904.63, 24812.8, -453.349);
    level.c130.angles = level.c130.angles + (0, 180, 0);
    level.c130 playLoopSound("_encstr_AF52196E1BE6EBC6E07DB94373F5B2E6ECA57359D72B878E7DB138");

    foreach(var_6 in level.flytime) {
      if(var_6.classname == "_encstr_87320B1AF06C43FB1117886FE1" || var_6.classname == "_encstr_8C1B0B53A80980AB4F40A59DBB")
        var_6 setlightintensity(10);
    }

    var_8 = scripts\cp_mp\anim_scene::anim_scene_create_actor(level.c130, "_encstr_824E060F2147FBB8");
    var_9 = level.c130 scripts\cp_mp\anim_scene::anim_scene([var_8], "_encstr_ADB405071B8AE8", 0, 0);
    level.intro_fadeup = ::intro_fadeup;

    if(isDefined(level.claxons["_encstr_ADDF0FBBE21B7B48DBA5710FD88598B0EF"]))
      claxon_lights_on("_encstr_ADDF0FBBE21B7B48DBA5710FD88598B0EF");
  } else
    start_landing_sequence(var_0);

  level.bad_obstacle_id = createnavbadplacebyent(level.c130);
}

_id_1445D() {
  var_0 = 1;
  var_1 = scripts\engine\utility::getStruct("_encstr_B47F10C250D0B68260174B137B16DBF930D9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;

  while(var_0) {
    var_0 = 1;

    foreach(var_3 in level.players) {
      if(distance2dsquared(var_3.origin, var_1) >= 268435456) {
        var_0 = 1;
        continue;
      } else {
        var_0 = 0;
        break;
      }
    }

    wait 0.5;
  }

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_88810E470BC9B5581BF507161DC9F68D");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A721148C3B68A587B6E6130AAB16875DA9811CE14D88");
  spawn_convoys_as_players_get_closer();
}

dosmokecurtains(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_88EF202C8DB1BE38C6B097B2C9B9BEE8CAB1951CB7391D5623FA8EB7AF1C1BB0CD2B");
  level endon("_encstr_870119E9027310902DD57353C713A843CF6AC0911B6731D886BE7B");
  level endon("_encstr_969C1436C62BC293AC46EBCCB727FA4785B559B7CC66");
  wait(var_1);
  var_2 = scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_3 = 8;

  foreach(var_5 in var_2) {
    var_6 = randomfloat(2);
    thread _id_14403(var_5, var_6);
    waitframe();
  }
}

_id_14403(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_1);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  waitframe();
  var_3 = spawnfx(level._effect["_encstr_851213F394D337D9DA78DFDBB6EF69E9F66B3A33B7"], var_2.origin, anglesToForward(var_2.angles), anglestoup(var_2.angles));
  triggerfx(var_3);
  level scripts\engine\utility::_id_143A6("_encstr_870119E9027310902DD57353C713A843CF6AC0911B6731D886BE7B", "_encstr_969C1436C62BC293AC46EBCCB727FA4785B559B7CC66", "_encstr_88EF202C8DB1BE38C6B097B2C9B9BEE8CAB1951CB7391D5623FA8EB7AF1C1BB0CD2B");
  var_3 delete();
  var_2 delete();
}

_id_1446F() {}

watch_for_players_in_plane() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_960B0CE898D241092BF24B3D23E9");
  self notify("_encstr_93651B9BB3A93240D8FD909297E8D43ACAE8E21FF9C3563F8189FB2DB5");
  self endon("_encstr_93651B9BB3A93240D8FD909297E8D43ACAE8E21FF9C3563F8189FB2DB5");

  if(!isDefined(level.players_in_plane))
    level.players_in_plane = [];

  for(;;) {
    if(istrue(self.inlaststand)) {
      wait 3;
      continue;
    }

    if(self istouching(level._id_12B48)) {
      if(!scripts\engine\utility::array_contains(level.players_in_plane, self))
        level.players_in_plane = scripts\engine\utility::array_add(level.players_in_plane, self);
    } else if(scripts\engine\utility::array_contains(level.players_in_plane, self))
      level.players_in_plane = scripts\engine\utility::array_remove(level.players_in_plane, self);

    if(level.players_in_plane.size >= brdoesloadoutoptiongivecustomweaponsimmediately()) {
      level notify("_encstr_969C1436C62BC293AC46EBCCB727FA4785B559B7CC66");
      break;
    }

    wait 1;
  }
}

callback_frontendplayeractive() {
  foreach(var_1 in brdoesloadoutoptiongivestandardloadoutimmediately()) {
    if(!var_1 istouching(level._id_12B48))
      return 0;
  }

  return 1;
}

start_infil_plane(var_0, var_1) {
  thread stop_clear_players_from_door_way_think();
  level thread scripts\cp\utility::_id_123FE("_encstr_AB851E5BEA6EEB360EF585395BDCC9C2C62BFA8D1399817D0B073893B70BD843");

  if(getdvarint("_encstr_A250119F9776B93C48506FF5E9284F43450F0B", 0) != 0) {
    close_plane_doors();
    thread c130_take_off_sequence();

    for(;;) {
      start_landing_sequence(var_0);
      wait 5;
      close_plane_doors();
      thread c130_take_off_sequence();
      level waittill("_encstr_AA1D1007C62C73ACBE4716DA5973BE7BCC33");
    }
  }

  if(getdvarint("_encstr_A34111DEBE43DFD039EB68088357CEF15A22D5", 0) != 0)
    level waittill("_encstr_8D5609DA3DA4A282035BED");

  var_2 = scripts\engine\utility::ter_op(getdvarint("_encstr_AAE81338923A17C1768BA768BC5F2839294B50406A", 0) != 0, getdvarint("_encstr_AAE81338923A17C1768BA768BC5F2839294B50406A", 0), 300);
  thread scripts\cp\utility::objective_update(var_0.ref, int(var_2), int(var_2 / 2), int(var_2 / 3), 1);

  foreach(var_4 in getaiarray("_encstr_8E8405EA382B2A")) {
    var_5 = scripts\engine\utility::random(brdoesloadoutoptiongivestandardloadoutimmediately());
    var_4 setgoalentity(var_5);
    var_4 thread _id_11CDB(var_5);
  }

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_B8CB11D3C9BFEA6DF9B0AB370921B793074D0B");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_91D10DD385D3EA1A893F1150557F4A");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_88810E470BC9B5581BF507161DC9F68D");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A721148C3B68A587B6E6130AAB16875DA9811CE14D88");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A99C140D0B6CB57DC2D239E0B79C3AFA36EDB6312C47");
  objective_setlocation(var_0.objectiveindex, 0, level._id_12B48.origin);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_1317E(var_0, level._id_12B48.origin);
  objective_setzoffset(var_0.objectiveindex, 90);
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_setshowdistance(var_0.objectiveindex, 1);
  objective_setfadedisabled(var_0.objectiveindex, 1);
  thread little_bird_initdamage(var_2 / 2);
  objective_setlabel(var_0.objectiveindex, &"_encstr_97EC150D28BE325521A0A4BC925450A1127D829882E4A2");
  take_off_loop(var_0);
}

_id_11CDB(var_0) {
  self notify("_encstr_B16F142590081133D88D1FCF8DF5EA49D9995FAE6B90");
  self endon("_encstr_B16F142590081133D88D1FCF8DF5EA49D9995FAE6B90");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::random(brdoesloadoutoptiongivestandardloadoutimmediately());

  if(isDefined(var_1))
    self setgoalentity(var_1);
}

little_bird_initdamage(var_0) {
  wait(var_0);
  _id_138BB();
}

_id_138BB() {
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  _id_13BBB(1);
}

brjugg_oncrateactivate() {
  setnojipscore(0, 1);
  setnojiptime(0, 1);
  _id_13BBB(undefined);
}

stop_clear_players_from_door_way_think() {
  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_86601E8C0F7DD8C16EFA8D58DC6E7D0E8D0BB9CAEB851C384EBD2C1B34FA6203", 3);
  level thread _id_12403(["_encstr_B8451F7D50B98F4B33475020EF6BE6E132BEE07561824F511AC3C1508F973EDB9F", "_encstr_8C231F5F7BF77A203BA1CFEF1851D793791F25977035F279636027CB80499FFF99"], 30);
}

_id_11EE4(var_0) {
  level endon("_encstr_AB5E1481EB5F77D8A4DD7917D58A08CDBB91D9A8C2EB");
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  while(var_0 > 0) {
    if(istrue(level.dialogue_playing)) {
      wait 1;
      continue;
    }

    if(var_0 >= 120 && var_0 <= 140 && (!istrue(var_1) || !istrue(var_1))) {
      if(!istrue(var_1)) {
        scripts\cp\cp_dialogue::play_vo_to_all("_encstr_9A511E49E04707CBCA01BFAF33B1F94B9D7B7AE907D745FFD399A0D00D075F37");
        var_1 = 1;
      } else {
        scripts\cp\cp_dialogue::play_vo_to_all("_encstr_8D8423A9DBC1EF833B08B868B25BD76B7C47B6D94F40C22FB87D903D3587B75572B58F0FEA");
        var_2 = 1;
      }
    } else if(var_0 >= 60 && var_0 <= 69 && !istrue(var_3)) {
      scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B8D62340D1F866537ACF07CFADBFE19893A9B20366FDCD676B5896FD65792AADA3E02F0AC2");
      var_3 = 1;
    } else if(var_0 >= 30 && var_0 <= 35 && !istrue(var_4)) {
      scripts\cp\cp_dialogue::play_vo_to_all("_encstr_858824717B87467032B7371BBD9E4197138248D991EF08D10A6C2B0DDD491A7F877A6106DF6A");
      var_4 = 1;
    }

    var_0--;
    wait 1;
  }
}

spawn_convoys_as_players_get_closer() {
  thread spawn_intro_choppers();
  wait 5;

  if(!istrue(level.spawned_convoys)) {
    thread spawn_convoys();
    level.spawned_convoys = 1;
  }
}

spawn_convoys() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!istrue(level.global_stealth_broken))
    wait 1;

  wait 2;
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AFA313EB111FB0B811724AD7DAD761488B9B87DFAB");
  wait 10;
}

spawn_pavelows() {
  var_0 = scripts\engine\utility::random(level.players);
  scripts\cp\killstreaks\chopper_support_cp::chopper_support_create_enemy_chopper(var_0);
}

spawn_intro_choppers() {
  wait 5;
  var_0 = scripts\engine\utility::getStructArray("_encstr_A7F31147665CB567B983071DC4F72360401825", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_2.classname_mp = "_encstr_8F871B9BD8E4B4388EEBCE590D96D81B95BE2DBBE0D75B2DCD8CA51683";
    var_2.script_modelname = "_encstr_8A67159D594383F5DAB41BF52CB4E47DB55ACD91A52CC1";
    var_2.vehicletype = "_encstr_BAFD0BB5B473195A0BC1AF1B83";
    var_3 = scripts\common\vehicle::vehicle_spawn(var_2);
    var_3 thread setup_pilot();
    var_3.isheli = 1;
    var_3.health = 50000;
    var_3.maxhealth = 50000;
    var_3.team = "_encstr_8E8405EA382B2A";
    var_3 setvehicleteam(var_3.team);
    var_3 setmaxpitchroll(15, 15);
    var_3 sethoverparams(25, 15, 10);
    var_3 thread intro_chopper();
    wait 2;
  }
}

intro_chopper() {
  self endon("_encstr_AD75063D571AE108");
  self vehicle_setspeed(20, 15, 15);
  self setvehgoalpos(self.origin + (0, 0, 1200), 1);
  scripts\engine\utility::_id_143BB(10, "_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_B4D10ADC950BE4EB76DE8536");
  var_0 = scripts\engine\utility::getStruct("_encstr_81F515C7752BFA17D1161BD7F969B2F29FE24118E8142F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self vehicle_setspeed(90, 30, 30);
  self setvehgoalpos(var_0.origin, 1);
  scripts\engine\utility::_id_143A6("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_B4D10ADC950BE4EB76DE8536");
  self.pilot delete();
  self delete();
}

start_convoy(var_0, var_1, var_2) {
  if(!isDefined(level.runway_convoys))
    level.runway_convoys = [];

  var_3 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_2))
    var_2 = "_encstr_8B041479C0E398F1F96E2B1D08688A4355ABFB8B0F5B";

  level thread set_convoy_settings(var_0, var_2, var_3);
}

set_convoy_settings(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_0, var_1, var_2);
  var_4 thread respawn_on_death(var_0, var_1, var_2);
  level.runway_convoys = scripts\engine\utility::array_add(level.runway_convoys, var_4);
  level waittill("_encstr_8E76095022AA99515FE620" + var_0);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var_4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

respawn_on_death(var_0, var_1, var_2) {
  level endon("_encstr_8E76095022AA99515FE620" + var_0);
  self waittill("_encstr_AD75063D571AE108");

  if(scripts\engine\utility::array_contains(level.runway_convoys, self))
    level.runway_convoys = scripts\engine\utility::array_remove(level.runway_convoys, self);

  set_convoy_settings(var_0, var_1, var_2);
}

reduce_timer_on_breaking_stealth(var_0, var_1) {
  level endon("_encstr_969C1436C62BC293AC46EBCCB727FA4785B559B7CC66");
  level endon(var_0.ref + "_encstr_95D510A9455352EDC369171FC0BBAC9A3155");
  level waittill("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_1 = var_1 / 2;
  thread scripts\cp\utility::objective_update(var_0.ref, int(var_1), int(var_1 / 2), int(var_1 / 3), 1);
}

open_plane_doors_anim() {
  var_0 = getanimlength(level.scr_anim["_encstr_824E060F2147FBB8"]["_encstr_ADB405071B8AE8"]);
  var_1 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "_encstr_824E060F2147FBB8");
  var_2 = scripts\cp_mp\anim_scene::anim_scene([var_1], "_encstr_ADB405071B8AE8");
}

close_plane_doors_anim() {
  var_0 = getanimlength(level.scr_anim["_encstr_824E060F2147FBB8"]["_encstr_88950636C6DE9B59"]);
  var_1 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "_encstr_824E060F2147FBB8");
  level.c130._id_12A4F playsoundonmovingent("_encstr_B81C25B96C73F58D07D7C18D5837B27D0D96A9C2C6DA7DC62C9CECF6F546BDF6C9FA6CC67B6ECA");
  var_1 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "_encstr_88950636C6DE9B59", 1);
  var_2 = scripts\cp_mp\anim_scene::anim_scene([var_1], "_encstr_88950636C6DE9B59");
  wait(var_0);
}

open_plane_doors() {
  level.c130.lower_door unlink();
  level.c130.lower_door rotatepitch(-35, 3);
  wait 3;
  level.c130.lower_door.origin = level.c130.lower_door.origin - (0, 0, 110);
}

close_plane_doors() {
  level._id_127F4 = ::playerincrementscoreboardkills;
  level.c130 close_plane_doors_anim();
  level._id_127F4 = undefined;
  level.intro_fadeup = undefined;
}

playerincrementscoreboardkills() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(istrue(self.run_kill_watcher))
    waitframe();

  if(istrue(self.binc130)) {
    return;
  }
  self.combo_progression = 0;
  self.get_vehicle_node_to_wait_for_lbravo_based_on_group = self.name + "_encstr_AD2B21796A04B40438C60B97594E0496E69BC9A3029673401DA1B2801C8DC2DCCA9010";

  if(self istouching(level._id_12B48) || self istouching(level.c130._id_12A4F)) {
    self.combo_progression = 1;
    self.get_vehicle_node_to_wait_for_lbravo_based_on_group = "_encstr_AFA329EB5047D1809F77CEFB5FEF6D3897A18283C3A23C57CAAB16DF03B77C62F8C118AA01B2EACCFA404B";
  }

  if(!istrue(self.combo_progression)) {
    foreach(var_1 in level.c130.body) {
      if(isDefined(var_1)) {
        if(self istouching(var_1)) {
          self.combo_progression = 1;
          self.get_vehicle_node_to_wait_for_lbravo_based_on_group = "_encstr_B2AF1F8DD01846F0F557272CAC1396F7A083868FCA4B50D829C259822EF2483D85";
          break;
        }
      }
    }
  }

  if(!istrue(self.combo_progression)) {
    foreach(var_4 in level.c130.plane_seats) {
      if(self istouching(var_4)) {
        self.combo_progression = 1;
        self.get_vehicle_node_to_wait_for_lbravo_based_on_group = "_encstr_BE3C17D95F733013B75A1183826FFF61CDA96563B85A58EF9B";
        break;
      }
    }
  }

  if(!istrue(self.combo_progression)) {
    if(isDefined(level.c130.shell)) {
      if(self istouching(level.c130.shell)) {
        self.combo_progression = 1;
        self.get_vehicle_node_to_wait_for_lbravo_based_on_group = "_encstr_AC03252457ED69408DD1518D6BF1FA3285D97B27BFF6803F0B6A3343FAC8CD22C6A181CAB22B9E";
      }
    }
  }

  if(!istrue(self.combo_progression)) {
    if(self istouching(level.c130)) {
      self.combo_progression = 1;
      self.get_vehicle_node_to_wait_for_lbravo_based_on_group = "_encstr_AC03252457ED69408DD1518D6BF1FA3285D97B27BFF6803F0B6A3343FAC8CD22C6A181CAB22B9E";
    }
  }

  if(istrue(self.combo_progression)) {
    if(!istrue(self.binc130))
      playerinitpersstats();
    else {}
  } else if(!istrue(self.binc130))
    playerinitpersstats();
  else {}
}

c130_take_off_sequence(var_0, var_1) {
  if(istrue(var_0)) {
    setDvar("_encstr_8B76165BEE4AC107529FB7931F5A4E88E4C74631528F70BE", 1);

    if(!istrue(var_1))
      thread play_turbulence_fx();
  } else
    level notify("_encstr_9602121D58B5ACF5B766CCD79BAC2EBA5637D8B2");
}

play_turbulence_fx() {
  foreach(var_1 in level.players)
  var_1 thread takeoff_turbulence();

  level thread check_for_solo();
}

takeoff_turbulence() {
  self endon("_encstr_84C60FB29029874B3EFEA4A106C01FCB61");

  for(;;) {
    if(istrue(self.pause_turbulence)) {
      waitframe();
      continue;
    }

    var_0 = randomfloatrange(0.4, 0.6);
    var_1 = randomfloatrange(2.5, 5.0);
    earthquake(var_0, var_1, self.origin, 64);
    var_2 = 3.75;

    if(var_1 < var_2)
      self playRumbleOnEntity("_encstr_A2EE0C1037DEC01783C321BE9D2A");
    else
      self playRumbleOnEntity("_encstr_B1EB1099828A6E10B70ADD61B281F3B1F359");

    wait(randomfloatrange(1, 2));
  }
}

check_for_solo() {
  waitframe();
  playsoundatpos((-15423, 29040, -3958), "_encstr_BEF817472F4208B0C0615B430387405F4A9FC7E5A3B9EB73FC");
  level._id_134E1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-15333, 29036, -3976));
  level._id_134E1 playLoopSound("_encstr_937B20C2AD4C7DB507BECDA16EFA33C6A5EC43D1FAA5DC47AF8D9CD76E8D9CD2E01D");
}

end_infil_plane(var_0, var_1) {
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

move_plane(var_0) {
  self notify("_encstr_832B0B58BF93C8E1B2BAEF15BD");
  self endon("_encstr_832B0B58BF93C8E1B2BAEF15BD");
  self endon("_encstr_819016D3A3AF4068DA671D337F12C5F175FDFBE90D0D08B5");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_1 = vectortoangles(anglesToForward(var_0.angles));
    var_0 rotateTo(var_1, 1);
    wait 1;
  }
}

debuginfil_plane(var_0) {
  scripts\engine\utility::flag_set("_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E");
  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 10;

  if(getdvarint("_encstr_A250119F9776B93C48506FF5E9284F43450F0B", 0) != 0)
    scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A95E1719B7ED4EBE472BDC1DF5CDE82C27D1FA83B7B4E63AE6", 1);
  else if(getdvarint("_encstr_A34111DEBE43DFD039EB68088357CEF15A22D5", 0) != 0)
    scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A95E1719B7ED4EBE472BDC1DF5CDE82C27D1FA83B7B4E63AE6", 1);
  else if(getdvarint("_encstr_868E12B8AF52F6D1E2D53E502ABA037BAD03B0B0", 0) != 0)
    scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_A95E1719B7ED4EBE472BDC1DF5CDE82C27D1FA83B7B4E63AE6", 1);
  else
    scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_91E216CD204ECA4FBFEFB91E5223A3AD2310609F68186403", 1);

  if(getdvarint("_encstr_A34111DEBE43DFD039EB68088357CEF15A22D5", 0) == 0 && getdvarint("_encstr_A250119F9776B93C48506FF5E9284F43450F0B", 0) == 0) {
    if(!istrue(level.global_stealth_broken)) {
      level thread global_weapons_free();
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_91D10DD385D3EA1A893F1150557F4A");
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B8CB11D3C9BFEA6DF9B0AB370921B793074D0B");
    }
  }
}

start_landing_sequence(var_0) {
  level.c130 playsoundonmovingent("_encstr_82381C27A32541067359431BE7F74978FD3C9BE54FC128D30B3121B84BB3");
  wait 5;
  level.c130 playsoundonmovingent("_encstr_AC7B17E8FF1E86AF6389CC558BC9E909769BB09847971951CB");
  level.c130 unlink();
  level.c130.scenenode = scripts\engine\utility::getStruct("_encstr_870518CB0247889061DC6B7DFCD4F0C4176B2191CA8F3088C7AD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.c130 thread _id_123A4();
  level.c130 land_at_airport();
}

_id_123A4() {
  var_0 = ["_encstr_8E8F11EBFB84C1476889470D63F99ECB680D13", "_encstr_8DC4122BE28C9F0B3CB237B1BB5E3DF35BE1C417", "_encstr_8E1B10A47F21B71B1190E26A38271217595E"];
  self._id_145AC = [];

  foreach(var_2 in var_0) {
    if(self tagexists(var_2))
      self._id_145AC[var_2] = spawnfx(level._effect["_encstr_A34A11935A1FA0B859E443A5143C28FC3F522A"], self gettagorigin(var_2));
  }

  wait 1;

  foreach(var_5 in self._id_145AC)
  triggerfx(var_5);
}

land_at_airport() {
  self playLoopSound("_encstr_AF52196E1BE6EBC6E07DB94373F5B2E6ECA57359D72B878E7DB138");
  var_0 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "_encstr_824E060F2147FBB8");
  var_1 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_0], "_encstr_8820081976CAE1084E87", 1, 0);
  plane_landed_idle(var_0);
}

plane_landed_idle(var_0) {
  var_1 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_0], "_encstr_A7C5056BD931D1", 0, 0);
  level.c130._id_12A4F playsoundonmovingent("_encstr_9AAE247EAB732617CA296088E265C3FE83590AFF03DF6E5FF6E3E088F93F9FB0B3C7B7EF9DA3");
  level.intro_fadeup = ::intro_fadeup;
  var_1 = scripts\cp_mp\anim_scene::anim_scene([var_0], "_encstr_ADB405071B8AE8", 0, 0);
  level.fly_to_node = createnavbadplacebyent(level.c130._id_12A4F);

  foreach(var_3 in level.flytime) {
    if(var_3.classname == "_encstr_87320B1AF06C43FB1117886FE1" || var_3.classname == "_encstr_8C1B0B53A80980AB4F40A59DBB")
      var_3 setlightintensity(10);

    if(var_3.classname == "_encstr_A67E11DDA78B6AEF47B363B06E4901A8676530")
      var_3 show();
  }

  level._id_123A3 = 1;

  if(isDefined(level.claxons["_encstr_ADDF0FBBE21B7B48DBA5710FD88598B0EF"]))
    claxon_lights_on("_encstr_ADDF0FBBE21B7B48DBA5710FD88598B0EF");

  thread plane_takeoff_from_airport(var_0);
}

intro_fadeup(var_0) {
  var_1 = var_0.origin;
  var_2 = var_1 + (0, 0, -1000);
  var_3 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_9A171A1CA19737D26CB9B17BDC3A5973A3B9F5165AE6B76E437BBDD1", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4"]);
  var_4 = scripts\engine\trace::ray_trace(var_1, var_2, var_0, var_3);
  var_5 = var_4["_encstr_BD260953AA97E3F014279D"];
  var_6 = getclosestpointonnavmesh(var_5);
  var_7 = length(var_6 - var_5);

  if(var_7 > 150) {
    var_8 = scripts\engine\utility::drop_to_ground(var_1, 5, -1500);
    var_8 = getclosestpointonnavmesh(var_8);
    var_0 setOrigin(var_8);
  } else
    var_0 setOrigin(var_5);
}

door_open_close_loop() {
  var_0 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "_encstr_824E060F2147FBB8");

  for(;;) {
    var_0 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "_encstr_ADB405071B8AE8", 1);
    var_1 = scripts\cp_mp\anim_scene::anim_scene([var_0], "_encstr_ADB405071B8AE8");
    wait 15;
    var_0 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "_encstr_88950636C6DE9B59", 1);
    var_1 = scripts\cp_mp\anim_scene::anim_scene([var_0], "_encstr_88950636C6DE9B59");
    wait 15;
  }
}

plane_takeoff_from_airport(var_0) {
  level waittill("_encstr_9602121D58B5ACF5B766CCD79BAC2EBA5637D8B2");
  level.c130 playsoundonmovingent("_encstr_83F817376C73D76CC1F59BA1E6F547C26D59DB66337DB2C3E8");
  wait 4;
  var_1 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_0], "_encstr_914808D1B05B2B7B9999", 0, 1);
  level notify("_encstr_AA1D1007C62C73ACBE4716DA5973BE7BCC33");
}

build_path(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1[var_1.size] = var_2; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = var_2)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

init_collect_nuclear_core(var_0, var_1) {
  level.chopper_death_callback = scripts\engine\utility::getStructArray("_encstr_B6111D190E3B5BE5631799B333DAAFD8C2A326B3F361801DC993B75323F376", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_127F6 = ::getdefaultweaponbasename;

  foreach(var_3 in level.players)
  var_3 setclientomnvar("_encstr_8FCB19BAA5BE3607BEDA969B6E4BDBDCEB66B096D8F5A57332AC0F", 0);

  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);

  if(scripts\engine\utility::array_contains(level.onplayerspawncallbacks, ::watch_for_players_in_plane))
    level.onplayerspawncallbacks = scripts\engine\utility::array_remove(level.onplayerspawncallbacks, ::watch_for_players_in_plane);

  if(scripts\engine\utility::array_contains(level.onplayerspawncallbacks, ::givedisguiseonspawn))
    level.onplayerspawncallbacks = scripts\engine\utility::array_remove(level.onplayerspawncallbacks, ::givedisguiseonspawn);

  if(!scripts\engine\utility::flag_exist("_encstr_BE331528AF7B29C53AAF40D587C221B0EF6FD0C8E70CC1"))
    scripts\engine\utility::flag_init("_encstr_BE331528AF7B29C53AAF40D587C221B0EF6FD0C8E70CC1");

  init_gas_masks();
  setup_aisettings_on_plane();
  level thread watch_for_timer_on_plane(var_0.ref);
  scripts\cp\cp_modular_spawning::stop_all_groups();

  foreach(var_6 in getaiarray("_encstr_8E8405EA382B2A"))
  var_6 scripts\cp\cp_modular_spawning::script_kill_ai();

  scripts\cp\cp_modular_spawning::kill_off_enemies(undefined, level.spawned_enemies.size, 1);
  waitframe();
  level notify("_encstr_A9B10D37E085BB73EBB04BF59BDEDD");
  script_model_anims();
  scripts\mp\playeractions::registeractionset("_encstr_AF960A180D8A1D57633A9308", ["_encstr_914C0EDDB20B837BB97D38D2365BAB83", "_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_8F0508CE59DCA357392B", "_encstr_AD1904291F7B", "_encstr_AF4D07932B1BDE5846", "_encstr_96EB0B0BABD1DB39598DF616C8", "_encstr_92100762872552A643", "_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05", "_encstr_88780599B4E495", "_encstr_A6C7065BACB1CA95", "_encstr_919007AA5148539DA0"]);
  scripts\mp\playeractions::registeractionset("_encstr_B8BD10F06B9785C9F647C5D34F5F38DC4712", ["_encstr_92100762872552A643", "_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05"]);
  var_0.c4_nuke = scripts\cp\cp_breach_c4::setup_c4(scripts\engine\utility::getStruct("_encstr_842B11F27D798037153DBA07AB084722AB3737", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_0.c4_nuke thread watch_for_nuke_planted();
  level.nuclear_core_interaction = ::give_nuclear_core_from_parachute;
}

init_gas_masks() {
  level.gas_masks_middle = [];
  level.gas_masks_side = [];
  var_0 = getscriptablearray("_encstr_A740111743B679E58813ACB28E30390205F18F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  level.gas_masks_middle[level.gas_masks_middle.size] = var_2;

  var_0 = getscriptablearray("_encstr_975E0F5AF36D3F731F16A8A0A7D8D1BC90", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  level.gas_masks_side[level.gas_masks_side.size] = var_2;

  if(isDefined(level.gas_masks_middle)) {
    foreach(var_7 in level.gas_masks_middle)
    var_7 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_8D9C0ECD1AF6DD7DE03996E6D12D7395");
  }

  if(isDefined(level.gas_masks_side)) {
    foreach(var_7 in level.gas_masks_side)
    var_7 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_8293107AA8D8D769A62F4B4BABD623313891");
  }
}

trigger_nearest_gasmasks() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self;

  if(!isDefined(level.gas_masks_middle) && !isDefined(level.gas_masks_side)) {
    return;
  }
  var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.gas_masks_middle, undefined, 5, 1000);
  var_2 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.gas_masks_side, undefined, 5, 1000);

  if(isDefined(var_1) && var_1.size > 0) {
    foreach(var_4 in var_1) {
      if(istrue(var_4.triggered)) {
        if(randomint(100) > 50)
          var_4 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_A5110C93E46FB8A88A87DFC98F02");
        else
          var_4 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_B2BE0C302A755F5E0FA5F1F9B73F");

        continue;
      }

      var_4 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_A9440A17B17044E968A88152");
      var_4.triggered = 1;
    }
  }

  if(isDefined(var_2) && var_2.size > 0) {
    foreach(var_4 in var_2) {
      if(istrue(var_4.triggered)) {
        if(randomint(100) > 50)
          var_4 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_B65D0E9BD0B7BBAF4CBE1AACD81D2D1B");
        else
          var_4 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_86220EBFB917A099411EBAF55B38A2E4");

        continue;
      }

      var_4 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_BD0B0CAF209DF890B3C1E109DAA3");
      var_4.triggered = 1;
    }
  }
}

watch_for_timer_on_plane(var_0) {
  level endon("_encstr_BE3115A8AF65A9E509ACD848C2120B70D5DFB8F0E305C1");
  level waittill(var_0 + "_encstr_95D510A9455352EDC369171FC0BBAC9A3155");

  if(!isDefined(level.nuclear_core_carrier)) {
    foreach(var_2 in level.players)
    var_2 thread screen_fade_to_black(3, 1);

    thread _id_123E2();
    scripts\cp\cp_objectives::_id_12868(var_0);
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
    return;
  }
}

setup_aisettings_on_plane() {}

reset_aisettings_on_plane() {}

give_nuclear_core_from_parachute() {}

start_smoke_show() {
  wait 0.5;
  var_0 = "_encstr_8823119675DAFF897F878020BB99612B219D8F";

  foreach(var_2 in scripts\engine\utility::getStructArray("_encstr_BDB310D6D036FA9BB5DB6D2BBE0EED96DC47", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"))
  playFX(level._effect["_encstr_8D1312A89BE703A96B8FE2658F6F16EF4DD26868"], var_2.origin);
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_anims() {
  level.scr_animtree["_encstr_B8BA05F06B9785"] = #animtree;
  level.scr_anim["_encstr_B8BA05F06B9785"]["_encstr_A5360ABBEB4AAAA788E3BF45"] = % _encstr_BECC1D9E7FF74B22B8D81FD3D811E4C2639669136F15827D016027CF0809AE;
  level.scr_animname["_encstr_B8BA05F06B9785"]["_encstr_A5360ABBEB4AAAA788E3BF45"] = "_encstr_BECC1D9E7FF74B22B8D81FD3D811E4C2639669136F15827D016027CF0809AE";
}

watch_for_nuke_planted() {
  scripts\engine\utility::ent_flag_wait("_encstr_928C0C273211552880ED1089577C");
  playFX(level._effect["_encstr_92FE167A080D296708BFB8E32709E9A1A051AA4F77285A38"], self.origin);
  scripts\engine\utility::array_call(getEntArray("_encstr_8E2C112A98C35E8FF0589487689BB7255BF8C2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), ::delete);
  start_smoke_show();
  thread start_spawners_after_time();
  thread _id_13811();
  level notify("_encstr_AB5E1481EB5F77D8A4DD7917D58A08CDBB91D9A8C2EB");
}

start_spawners_after_time() {
  wait 0.3;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_95A30F1B08C8CD597905279FF811B28293");
}

watch_for_escape_door_breached() {
  scripts\engine\utility::ent_flag_wait("_encstr_928C0C273211552880ED1089577C");
  level._id_13E39 = 2;
  playFX(level._effect["_encstr_8CE217B6632B49122BA787EBE1C11A9398282D719BE011BAF5"], self.origin);
  playsoundatpos(self.origin, "_encstr_95EB166EC9638F3981C777999C362B23178960A3E177739F");
  playsoundatpos(self.origin, "_encstr_967915892759C26C86D7D886F5591E0E8DFA8E2716B9CD");

  foreach(var_1 in level.c4_escape_array) {
    if(isDefined(var_1))
      var_1 delete();
  }

  waitframe();
  var_3 = getEntArray("_encstr_BAB711338B2EF8D77F11B1380A730330C4FF5D", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B")[0];
  var_3 playLoopSound("_encstr_AF52196E1BE6EBC6E07DB94373F5B2E6ECA57359D72B878E7DB138");
  level notify("_encstr_AC780E60BB1541AFE20765E01FBBE3AB");
  level thread check_for_nearby_packages();

  foreach(var_5 in getEntArray("_encstr_B1541E8D831AFF483089E980ADF27125933F03317701BEB8515B709815C95063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
    if(isDefined(var_5.model) && var_5.model == "_encstr_B84E279B51CBE2D110C36E7FEB78A237E7485383181703971933685C8BC82C2F9626AAFAC0760F9A32" || var_5 != var_3)
      var_5 delete();
  }

  _id_137A8();
  thread labels(var_3, 20);
}

labels(var_0, var_1) {
  wait(var_1);
  var_0 stoploopsound();
  var_0 delete();
}

check_for_nearby_packages() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-14784, 28800, -3958));
  var_0 playLoopSound("_encstr_A15B1D8E5B83D6875AB9EAFA17B9BF03EFC2960DB16FF8B7C3A23840898D51");
  wait 20;
  var_0 stoploopsound();
  waitframe();
  var_0 delete();
}

_id_137A8() {
  level.movement_vector = scripts\engine\utility::getStructArray("_encstr_B8EF140FE811FF824D1DEE66F36FEB851858875F334A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.movement_vector) {
    var_1.fx = spawnfx(level._effect[var_1.targetname], var_1.origin);
    waitframe();
  }

  waitframe();

  foreach(var_1 in level.movement_vector) {
    triggerfx(var_1.fx);
    waitframe();
  }
}

_id_138B7() {
  foreach(var_1 in level.movement_vector)
  var_1.fx delete();
}

_id_12404() {
  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_BA511E9FBB37BAE0FB610F2FD89197D3395F6557B0EFA20763E01F0BE00E314F");
}

getdefaultweaponbasename() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(self.binc130)) {
    return;
  }
  if(istrue(self.run_kill_watcher))
    playerincrementscoreboardkills();
  else
    thread playerinitpersstats();
}

playerinitpersstats() {
  var_0 = self;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(istrue(var_0.being_revived))
    waitframe();

  while(istrue(var_0.run_kill_watcher))
    waitframe();

  while(istrue(var_0.isreviving)) {
    var_0.can_revive = 0;
    var_0._id_12D13 = self.forcespawnorigin;
    var_0 notify("_encstr_86660C9CCAEC969DACF58C7BCDB2");
    waitframe();
  }

  var_0 notify("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  var_0 notify("_encstr_960B0CE898D241092BF24B3D23E9");

  if(!isDefined(level.chopper_death_callback))
    level.chopper_death_callback = scripts\engine\utility::getStructArray("_encstr_B6111D190E3B5BE5631799B333DAAFD8C2A326B3F361801DC993B75323F376", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  else if(level.chopper_death_callback.size == 0)
    level.chopper_death_callback = scripts\engine\utility::getStructArray("_encstr_B6111D190E3B5BE5631799B333DAAFD8C2A326B3F361801DC993B75323F376", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  var_1 = scripts\engine\utility::random(level.chopper_death_callback);
  level.chopper_death_callback = scripts\engine\utility::array_remove(level.chopper_death_callback, var_1);
  var_0.respawn_forcespawnorigin = var_1.origin;
  var_0.respawn_forcespawnangles = var_1.angles;
  var_0.forcespawnorigin = var_0.respawn_forcespawnorigin;
  var_0.forcespawnangles = var_0.respawn_forcespawnangles;

  if(istrue(var_0.isreviving)) {
    var_0.can_revive = 0;
    var_0._id_12D13 = var_0.forcespawnorigin;
    var_0 notify("_encstr_86660C9CCAEC969DACF58C7BCDB2");
  }

  if(istrue(var_0.inlaststand)) {
    if(istrue(var_0.being_revived)) {
      var_0 notify("_encstr_86660C9CCAEC969DACF58C7BCDB2");
      var_0.being_revived = 0;
    } else {
      var_0 notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
      var_0.binc130 = 1;

      if(isDefined(level.disguised_players)) {
        if(scripts\engine\utility::array_contains(level.disguised_players, var_0))
          remove_disguise(var_0);
      }

      return;
    }
  }

  level notify("_encstr_B49D197ED2390528B23798510FF18D59437B6EF56E92AF51907718");

  if(isDefined(level.choppergunners)) {
    foreach(var_3 in level.choppergunners)
    var_3 scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
  }

  if(isDefined(var_0.helperdrone))
    var_0.helperdrone scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);

  if(isDefined(var_0.currentturret)) {
    var_0.currentturret notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 0, 0);
    waitframe();
  }

  if(istrue(var_0 isparachuting()) || istrue(var_0 isskydiving()))
    var_0 skydive_interrupt();

  var_5 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_5)) {
    var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_5, var_0);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var_5, var_6, var_0, undefined, 1);
  }

  var_0 setclientomnvar("_encstr_A2AC0FAE96AFD02D19ACD7894BECB6B007", 1);
  var_0 skydive_setbasejumpingstatus(0);
  var_0 skydive_setdeploymentstatus(0);
  thread teleport_black_overlay(var_0);
  var_0 thread _id_13AE2();

  if(var_0.class == "_encstr_8CFF09D56D88EC030D69EB" || var_0.class == "_encstr_A12707B8AB65E9A9C3")
    var_0.disable_super = 1;

  var_0 setmlgdamagedone();
  var_0 setOrigin(var_1.origin, 1);
  var_0 thread start_turbulence_sequence();
  var_0 thread delay_set_plane_specific_vars(var_0, 3);

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  var_0 setplayerangles(var_1.angles);
  var_0.binc130 = 1;
  level notify("_encstr_9699171843E193A5813750ED0DDA8B5B77BF78012BB4E96DCA");
  var_0 scripts\cp\utility::brjugg_setconfig(1);
  var_0.can_revive = 1;

  if(isDefined(level.disguised_players)) {
    if(scripts\engine\utility::array_contains(level.disguised_players, var_0))
      remove_disguise(var_0);
  }
}

_id_12C8F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 8;

  foreach(var_1 in level.players) {
    if(istrue(var_1.binc130)) {
      continue;
    }
    if(!scripts\cp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    var_1 thread playerinitpersstats();
  }

  level._id_127F6 = undefined;
}

start_collect_nuclear_core(var_0, var_1) {
  var_2 = getEntArray("_encstr_A2771733B49B2CB1EB9827B258B11AFAC6DBB1635A37B4B7E6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    var_4 disconnectPaths();
    var_4 solid();
  }

  thread _id_12404();
  thread _id_11EE4(180);
  thread _id_12C8F();
  level waittill("_encstr_AB5E1481EB5F77D8A4DD7917D58A08CDBB91D9A8C2EB");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A6FD1E1B1281B0734B87C04F23D3CE9A3BF36A92DF584E4F08FA8FC3BD295EEA");

  if(isDefined(var_0)) {
    var_0.nuke_interactions = getEntArray("_encstr_A78D13CDD56C6359169CEB36BD27567DADDB9159D8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_7 in var_0.nuke_interactions) {
      var_7 setHintString(&"_encstr_A9ED13DEAF59351DF2FEBD6FE7E02138E60405CCA3");
      var_7 sethintdisplayrange(200);
      var_7 sethintdisplayfov(120);
      var_7 setusefov(120);
      var_7 setuserange(128);
      var_7 sethintonobstruction("_encstr_BD1805CB69C063");
      var_7 sethinticon("_encstr_9A8F11CDC1D816DC34EBA51BB7DCAF9BABD656");
      var_7 makeusable();
      var_7 thread use_nuclear_core(var_7);
      objective_setlocation(var_0.objectiveindex, 0, var_7.origin);
      objective_setlabel(var_0.objectiveindex, &"_encstr_8ECE1C60C937F42F7AE37DB015530D2963615361277F3285304DFFDE19CB");
    }
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8EFA108258E6274563D7030843300D3796D3");
  level waittill("_encstr_BACC0FDF770D70BD87435179196F6058E7");

  foreach(var_10 in level.players)
  var_10 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_A1BD075837DCD29B47");

  thread lowpopcheck();
}

lowpopcheck() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread scripts\cp\utility::_id_123FE("_encstr_B40101");
  wait 7.33;
  level thread scripts\cp\utility::_id_123FE("_encstr_82D41BB65D377DD80EAF0B27ADB9E40B8D56F58D13330C7DB28733D2B1");
}

_id_138CD(var_0, var_1) {
  wait(var_0 - var_1);
  level notify("_encstr_A66C19D67D32A3900783E0D0B345A8D3EA265D70D33A4D39E1FBC8");
}

switch_to_ac130_if_plane_blows_up() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.last_stand_state)) {
      if(var_1.last_stand_state == "_encstr_8FE20AD2903BB77B0E68ADA4")
        thread revive_player_inside_c130(var_1);
    }
  }
}

revive_player_inside_c130(var_0) {
  var_0.binc130 = undefined;

  if(isDefined(var_0.reviveent))
    var_0.reviveent delete();

  if(isDefined(var_0.reviveiconent))
    var_0.reviveiconent delete();

  var_0 notify("_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23");
  var_0 thread screen_fade_to_black(3);
}

end_collect_nuclear_core(var_0, var_1) {
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

debugstartc130objective(var_0) {
  scripts\engine\utility::flag_set("_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E");
  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 10;
  var_1 = getEntArray("_encstr_9A8513DAB058F886B017DADA91EDDD37A34F47B3FF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.ground_plane_seats = [];

  foreach(var_3 in var_1)
  level.ground_plane_seats = scripts\engine\utility::array_add(level.ground_plane_seats, var_3);

  waitframe();

  if(!isDefined(level.disguised_players))
    level.disguised_players = [];

  var_5 = level.ground_plane_seats;
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_BE3E16D955352B1F9F3B9BE6332B5F70CB975977F11DD0E6", 1);
  thread play_turbulence_fx();

  foreach(var_7 in level.players) {
    var_7 setclientomnvar("_encstr_A2AC0FAE96AFD02D19ACD7894BECB6B007", 1);
    level.disguised_players = scripts\engine\utility::array_add(level.disguised_players, var_7);
    var_7.binc130 = 1;
    var_7 thread start_turbulence_sequence();
  }

  wait 2;
  thread upper_level_plane_combat_start(1);
}

debugexfilc130objective(var_0) {
  scripts\engine\utility::flag_set("_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E");
  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  wait 10;
  _id_13811();
  scripts\mp\playeractions::registeractionset("_encstr_AF960A180D8A1D57633A9308", ["_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_8F0508CE59DCA357392B", "_encstr_AD1904291F7B", "_encstr_AF4D07932B1BDE5846", "_encstr_96EB0B0BABD1DB39598DF616C8", "_encstr_92100762872552A643", "_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05", "_encstr_88780599B4E495", "_encstr_A6C7065BACB1CA95", "_encstr_919007AA5148539DA0"]);
  var_1 = getEntArray("_encstr_9A8513DAB058F886B017DADA91EDDD37A34F47B3FF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.ground_plane_seats = [];

  foreach(var_3 in var_1)
  level.ground_plane_seats = scripts\engine\utility::array_add(level.ground_plane_seats, var_3);

  waitframe();
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_8FF216D333E3A82130E2137FAB8A17A882B3D1DA6B691ED3", 1);
  wait 2;
  var_5 = scripts\engine\utility::random(level.players);
  var_5 thread give_nuclear_core();
  wait 3;
}

upper_level_plane_combat_start(var_0) {
  if(!istrue(var_0))
    level waittill("_encstr_9699171843E193A5813750ED0DDA8B5B77BF78012BB4E96DCA");
  else
    level waittill("_encstr_A9B10D37E085BB73EBB04BF59BDEDD");

  level.c130 stoploopsound("_encstr_AF52196E1BE6EBC6E07DB94373F5B2E6ECA57359D72B878E7DB138");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_9B780DB5DB37018BF308D7AB306B43");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_887B12B534C67D9B380BEEE6F5CDDABD5B564E9B");
  level._id_12213 = undefined;
  level._id_12B46 = undefined;
}

debug_teleport_to_c130(var_0, var_1) {
  var_2 = scripts\engine\utility::random(var_1);
  var_1 = scripts\engine\utility::array_remove(var_1, var_2);
  var_0 unlink();
  thread teleport_black_overlay(var_0);
  var_0 setseatedanimconditional("_encstr_82180596773AC1", 0);
  set_player_angles_inside_plane(var_0, var_2, undefined, 1);
  var_0 setseatedanimconditional("_encstr_82180596773AC1", 1);
  var_0 playerlinkTo(var_2);
  delay_relax_view_arc(var_0, var_2);
  exit_seat(var_0, 1, var_2);
  return var_1;
}

set_player_angles_inside_plane(var_0, var_1, var_2, var_3) {
  var_4 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_4 = vectortoangles(anglestoleft(var_2.angles));
    var_5 = var_0.origin - var_1.origin;
    var_6 = rotatevectorinverted(var_5, var_4);
    var_7 = var_0.angles - var_4;
  } else
    var_4 = vectortoangles(anglestoleft(var_1.angles));

  var_5 = var_0.origin - var_1.origin;
  var_6 = rotatevectorinverted(var_5, var_4);
  var_7 = var_0.angles - var_4;
  var_5 = var_0.origin - var_1.origin;
  var_6 = rotatevectorinverted(var_5, var_4);
  var_7 = var_0.angles - var_4;
  var_8 = vectortoangles(anglestoleft(var_1.angles));
  var_9 = rotatevector(var_6, var_8);
  var_0 setplayerangles(var_8 + var_7);
}

delay_relax_view_arc(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_826B147091C9EABD482911E3EF0301A661B8D2EB626D");
  waitframe();
  var_0 playerlinktodelta(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 0, 180, 180, 180, 180, 1);
}

exit_seat(var_0, var_1, var_2, var_3) {
  if(istrue(var_3)) {
    var_0 notify("_encstr_814E0A7569AFF5276BF7497C");
    var_0.exit_seat = 1;
    return;
  }

  if(istrue(var_1)) {
    var_0 unlink();
    var_0 setseatedanimconditional("_encstr_82180596773AC1", 0);
    var_0 setstance("_encstr_A5AD069B231F0BAF");
  }
}

teleport_black_overlay(var_0) {
  var_0 endon("_encstr_84160AF443884D23A8099AF3");
  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
  var_0 scripts\cp\utility::freezecontrolswrapper(1);
  var_1 = newclienthudelem(var_0);
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "_encstr_A5AD056A019C63";
  var_1.aligny = "_encstr_AC190479FF92";
  var_1.sort = 1;
  var_1.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_1.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_1.alpha = 1;
  var_1.foreground = 1;
  var_1 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  wait 4;
  var_0 notify("_encstr_84C60FB29029874B3EFEA4A106C01FCB61");
  var_1 fadeovertime(5);
  var_1.alpha = 0;
  wait 6;
  var_0 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_1 destroy();
}

teleport_after_time(var_0) {
  wait(var_0);
  level notify("_encstr_A7630E1D16D6CAF57B3333F5467BCDCA");
}

#using_animtree("_encstr_B40101");

use_nuclear_core(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_932C11CB76420F80DB9769FF49D81FA76F3BF0");
  self endon("_encstr_932C11CB76420F80DB9769FF49D81FA76F3BF0");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(var_1 meleeButtonPressed()) {
      continue;
    }
    if(istrue(self.occupied)) {
      continue;
    }
    self.occupied = 1;

    if(!istrue(self.first_press)) {
      self makeunusable();
      self useanimtree(#animtree);
      self.animname = "_encstr_B8BA05F06B9785";
      thread scripts\common\anim::anim_single_solo(self, "_encstr_A5360ABBEB4AAAA788E3BF45");
      playFX(level._effect["_encstr_9AF31073BADAB27D1B7B9C56AFEC58387B93"], self.origin);
      wait(getanimlength(level.scr_anim["_encstr_B8BA05F06B9785"]["_encstr_A5360ABBEB4AAAA788E3BF45"]));
      self.occupied = undefined;
      self.first_press = 1;
      thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B8982232C3BE6CE0E6D7360B379BEB833685DC56AFE6BAD8D8560B4EBEC6DB93B2FA8981");
      self setHintString(&"_encstr_B46823785716EDEB9E2EDB8948FFF769229D29E30B9FC3572F5F9BD90D3F579DE7178193AD");
      self makeusable();
      thread use_nuclear_core(self);
      return;
    }

    if(var_1 hasweapon("_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")) {
      self.occupied = undefined;
      var_1 thread scripts\cp\utility::hint_prompt("_encstr_B1F40F50CF26CBFF3B6C9E92C9B2E31197", 1, 2);
      continue;
    }

    thread play_breach_dialogues();
    var_1 thread give_nuclear_core(var_0);
    var_0 setModel("_encstr_A7DE29151B7C50BBD1E2F367C0E5138387D29840603F60106867AB3FFBBFC52D5B61F7B150BB20FACD0F9A");
    var_0 makeunusable();
  }
}

play_breach_dialogues() {
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_852421A1147D9029EB6ACA4A2DFA8E13FA88940A62F48EAA8ACB1D498209BE1A9E4AA8");
  wait 3;
  thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_BAEC2456A887B5A5D139D98990F9B7CC2F24CBDFDC9F5D638F0619B16806F784D798C1A7665F");
}

give_nuclear_core(var_0) {
  if(isDefined(level.nuclear_core))
    level.nuclear_core delete();

  level.nuclear_core_carrier = self;

  if(isDefined(var_0)) {
    if(isDefined(var_0.headiconid))
      var_0 thread scripts\cp\utility::ent_deleteheadicon(var_0, var_0.headiconid);
  }

  self.previousweaponbeforenukein747 = self getcurrentweapon();
  var_1 = getcompleteweaponname("_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F");
  scripts\cp\utility::_giveweapon(var_1);
  self switchtoweaponimmediate(var_1);
  scripts\mp\playeractions::allowactionset("_encstr_AF960A180D8A1D57633A9308", 0);
  self allowmountside(0);
  self allowmounttop(0);
  self allowjog(0);
  self.headicon = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(race_dogtag_init(), "_encstr_956215D838EB8E8536EB86AB32AFD236DE37BEE65DDA95", 30, 1, 29000, 29000, undefined, 1, 0, undefined, 1);
  scripts\cp\respawn\cp_respawn::watchnukeweaponenduse(var_1, self.previousweaponbeforenukein747);
  self notify("_encstr_912D0C88C37F03B7D2A6CE5ABFFB");
  level notify("_encstr_BACC0FDF770D70BD87435179196F6058E7");
}

race_dogtag_init() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(scripts\cp\utility\player::isreallyalive(var_2)) {
      if(istrue(var_2.binc130))
        var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  return var_0;
}

watcher_for_core_pickup() {
  self endon("_encstr_91FF0D5DF29A896B05CBA950FF4A81");

  for(;;) {
    self waittill("_encstr_A6251833B4DCD29BA1EB382DC6B5EA07AFDE33FADD56161CF6E6", var_0, var_1);

    if(var_0 != "_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F") {
      continue;
    }
    var_2 = undefined;

    foreach(var_4 in self getweaponslistprimaries()) {
      if(var_4.basename == var_0) {
        var_2 = var_4;
        break;
      }
    }

    self allowmountside(0);
    self allowmounttop(0);
    self allowjog(0);
    level.nuclear_core_carrier = self;
    scripts\mp\playeractions::allowactionset("_encstr_AF960A180D8A1D57633A9308", 0);
    scripts\cp\respawn\cp_respawn::watchnukeweaponenduse(var_2, var_1);
  }
}

disable_features_for_core_carrier(var_0) {}

lower_level_plane_combat_start() {
  level.c4_escape_array = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_A65B134ADAC72CCBE3D51239FECB4777C70812F3C8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.brmini_createc130pathstruct = ::_id_123CE;

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\cp_breach_c4::setup_c4(var_2);
    var_3 setHintString(&"_encstr_849E14E999DF33035B8F8FF275B96D88DC7E010F0FFF");
    var_3.bskipplantsequence = 1;
    level.c4_escape_array = scripts\engine\utility::array_add(level.c4_escape_array, var_3);
    var_3 thread watch_for_escape_door_breached();
  }
}

start_turbulence_sequence() {
  self notify("_encstr_A66C19D67D32A3900783E0D0B345A8D3EA265D70D33A4D39E1FBC8");
  self endon("_encstr_A66C19D67D32A3900783E0D0B345A8D3EA265D70D33A4D39E1FBC8");
  level endon("_encstr_A66C19D67D32A3900783E0D0B345A8D3EA265D70D33A4D39E1FBC8");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread _id_137E4();

  for(;;) {
    var_0 = randomfloatrange(6, 10);
    self earthquakeforplayer(0.1, var_0 + 1.5, self.origin, 150);
    thread stumble_ai();
    thread stumble_player();
    thread trigger_nearest_gasmasks();
    playsoundatpos((0, 0, 0), "_encstr_93B71A573F5218A0B0112B5313B750452B93C3E1DFBADEA8C7F40853");
    wait(var_0);
  }
}

_id_137E4() {
  self notify("_encstr_A66C19D67D32A3900783E0D0B345A8D3EA265D70D33A4D39E1FBC8");
  self endon("_encstr_A66C19D67D32A3900783E0D0B345A8D3EA265D70D33A4D39E1FBC8");
  level endon("_encstr_A66C19D67D32A3900783E0D0B345A8D3EA265D70D33A4D39E1FBC8");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level._id_13E39 = 1;

  for(;;) {
    self earthquakeforplayer(0.169 * level._id_13E39, 10, self.origin, 150);
    wait 5;
  }
}

stumble_ai() {
  if(istrue(level.ai_stumbling)) {
    return;
  }
  level.ai_stumbling = 1;

  foreach(var_1 in getaiarray("_encstr_8E8405EA382B2A")) {
    if(isDefined(var_1)) {
      if(isDefined(var_1.agent_type) && var_1.agent_type == "_encstr_A1C91E665198571380E39B8FCBBB0993603E5AEBCB69EA3BE48FBFDB256F93DC") {
        continue;
      }
      var_2 = scripts\engine\utility::random(["_encstr_BDF80F4495E9F3C9C1387AF15011FA4F83", "_encstr_BACF0FC17D8FB0A0BB52111E2A5F6CE022", "_encstr_95E80A8D59CCD1F533DBED3A", "_encstr_8B1D10834BA13813E7693FB7D86B8BE80920", "_encstr_A91A1025A967F88DCF6A0971613BC8C83F2A", "_encstr_8ECF0B734B47E3AB67AD07909B"]);
      var_1 dodamage(1, var_1.origin, undefined, undefined, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9", undefined, var_2);
    }

    wait(randomfloatrange(0.05, 0.1));
  }

  level notify("_encstr_B82810F2D06FC6073920EFE1CEC0E78A9FA0");
  wait(randomfloatrange(15, 20));
  level.ai_stumbling = undefined;
}

player_munition_slots_full(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 childthread _encstr_83062042F108F193B56F3EFFADD38A7F58D87D8E2950BF9B8D733BD7B183C66F70A1::flashbangstart(2.5);
}

stumble_player() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(self.pause_turbulence)) {
    return;
  }
  if(istrue(self._id_140AE)) {
    return;
  }
  if(istrue(self.playing_stumble) || istrue(self.shouldplaystumble)) {
    return;
  }
  if(self getcurrentweapon().basename == "_encstr_8BBA05185F8B99") {
    return;
  }
  self.playing_stumble = 1;
  var_0 = randomfloatrange(0.6, 1.2);
  var_1 = randomfloatrange(1.25, 2.5);
  earthquake(var_0, var_1, self.origin, 64);
  var_2 = 1.875;

  if(var_1 < var_2)
    self playRumbleOnEntity("_encstr_A2EE0C1037DEC01783C321BE9D2A");
  else
    self playRumbleOnEntity("_encstr_B1EB1099828A6E10B70ADD61B281F3B1F359");

  if(scripts\engine\utility::cointoss()) {
    self forceplaygestureviewmodel("_encstr_B61E0EF12898304F3C5017B67DCD4E61", undefined, 0.5, 0, 1);
    wait(randomfloatrange(0.6, 1.2));
    self stopgestureviewmodel("_encstr_B61E0EF12898304F3C5017B67DCD4E61", 0.5, 1);
  } else {
    self forceplaygestureviewmodel("_encstr_A61E0E1FA8EBD7BB792DC53E997331E2", undefined, 0.5, 0, 1);
    wait(randomfloatrange(0.6, 1.2));
    self stopgestureviewmodel("_encstr_A61E0E1FA8EBD7BB792DC53E997331E2", 0.5, 1);
  }

  self.playing_stumble = undefined;
}

rotate_plane_randomly() {
  level endon("_encstr_A66C19D67D32A3900783E0D0B345A8D3EA265D70D33A4D39E1FBC8");

  for(;;) {
    wait 0.5;
    var_0 = randomintrange(-20, 20);
    self.og_rotation = var_0 * -1;
    self rotateroll(var_0, 1, 0.5);
    level notify("_encstr_844B171DEA3926AB8DB2E6B1CAFA59CE95CDA3FAE61D16931D");
    wait 2;
    self rotateroll(self.og_rotation, 1, 0.5);
    level notify("_encstr_AF38151927D3C6506C5FC079477718041AE381C71F7A9D");
    wait(randomintrange(5, 10));
  }
}

init_exfil_plane(var_0, var_1) {
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  level.teleport_geo = getEntArray("_encstr_99BC0D2155DC971A97331B2F27CF87", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.teleport_trigger = getEnt("_encstr_835311FD329A6D28BF4B4391F1605C574F4DB3", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level._id_13AE7 = getEnt("_encstr_AA2C0E8B5F642037E2D3C997FBCAF038", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  objective_setlocation(var_0.objectiveindex, 0, level._id_13AE7.origin);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  objective_setlabel(var_0.objectiveindex, &"_encstr_B13919DF1BA97CC92A3E3F98D7C8D18D418B4F7FC7F131210207E4");
  level thread lower_level_plane_combat_start();
}

brdoesloadoutoptiongivestandardloadoutimmediately() {
  var_0 = 0;
  level.brdoesloadoutoptionrequireclassselection = [];

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }
    level.brdoesloadoutoptionrequireclassselection = scripts\engine\utility::array_add(level.brdoesloadoutoptionrequireclassselection, var_2);
  }

  return level.brdoesloadoutoptionrequireclassselection;
}

brdoesloadoutoptiongivecustomweaponsimmediately() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2))
      var_0++;
  }

  level.brdoesloadoutoptiongivecustomweaponsimmediately = abs(level.players.size - var_0);
  return level.brdoesloadoutoptiongivecustomweaponsimmediately;
}

start_exfil_plane(var_0, var_1) {
  level.c130.origin = (-20547, 12615, 12000);
  level.c130.mp_cave_am_patch = (-2160.06, -3585.91, 12000);
  level.c130.mp_crash2 = (80648.1, 28300.1, 3333);
  level.c130.angles = (0, 15, 0);
  level thread watch_for_objective_failure(var_0.ref);
  level._id_13E39 = 2;

  if(!isDefined(level.landed_players))
    level.landed_players = [];

  thread delay_plane_explosion();
  thread _id_123E1();
  var_2 = level scripts\engine\utility::_id_143AD("_encstr_AC780E60BB1541AFE20765E01FBBE3AB", "_encstr_A59A1471A22548F6CAC791DFFFF3CB28C7BB98688F9A");
  objective_unsetlocation(var_0.objectiveindex, 0);

  if(var_2 == "_encstr_AC780E60BB1541AFE20765E01FBBE3AB") {
    level._id_13AE7 delete();
    level._id_1341E thread _id_13805();
    level._id_13AE8 = getEnt("_encstr_835311FD329A6D28BF4B4391F1605C574F4DB3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level._id_13AE8 thread _id_13ADE();
    level thread _id_14324(var_0, 20);

    while(!istrue(level._id_128B8))
      waitframe();

    foreach(var_4 in getaiarray("_encstr_8E8405EA382B2A"))
    var_4 scripts\cp\cp_modular_spawning::script_kill_ai();

    level notify("_encstr_A66C19D67D32A3900783E0D0B345A8D3EA265D70D33A4D39E1FBC8");
  } else {}
}

_id_123E1() {
  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A5D31D8CF0BEC6C137F5C6C2CD37F51C630B9B95BECDEAC6B12BE637F513C0");
}

_id_13805() {
  self endon("_encstr_AD75063D571AE108");
  playFXOnTag(level._effect["_encstr_AA320EBF459D5FE8194A77555327792A"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

_id_14324(var_0, var_1) {
  thread scripts\cp\utility::objective_update(var_0.ref, var_1, int(var_1 / 2), int(var_1 / 3), 1);
  level waittill(var_0.ref + "_encstr_95D510A9455352EDC369171FC0BBAC9A3155");
  level notify("_encstr_B2A910AFF5CB851B8B67036D38F921D8A8F3");

  if(isDefined(level._id_134E1))
    level._id_134E1 delete();

  if(isDefined(level.c130))
    level.c130 notify("_encstr_911C1051C2F3E26BF3F8B7123BE9A4F01053");

  if(istrue(level._id_11EDA)) {
    foreach(var_3 in level.players) {
      if(scripts\engine\utility::array_contains(level.landed_players, var_3)) {
        continue;
      }
      if(istrue(var_3.inlaststand)) {
        var_3 notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
        continue;
      }

      level notify("_encstr_B2A910AFF5CB851B8B67036D38F921D8A8F3");
      var_3.shouldskiplaststand = 1;
      var_3.shouldskipdeathsshield = 1;

      if(var_3.class == "_encstr_8CFF09D56D88EC030D69EB" || var_3.class == "_encstr_A12707B8AB65E9A9C3")
        var_3.disable_super = undefined;

      var_3 thread screen_fade_to_black(3);
      var_3 dodamage(var_3.maxhealth + 100000, var_3.origin);
    }

    level._id_128B8 = 1;
    return;
  } else {
    thread _id_123E2();
    scripts\cp\cp_objectives::_id_12868(var_0.ref);
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
    return;
  }
}

_id_123E2(var_0) {
  level._id_13E39 = 5;
  playsoundatpos((0, 0, 0), "_encstr_93B71A573F5218A0B0112B5313B750452B93C3E1DFBADEA8C7F40853");

  foreach(var_2 in level.players) {
    if(!istrue(var_2.inlaststand))
      var_2 thread _id_137E4();
  }

  var_4 = scripts\engine\utility::getStructArray("_encstr_A65B134ADAC72CCBE3D51239FECB4777C70812F3C8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = getEntArray("_encstr_BAB711338B2EF8D77F11B1380A730330C4FF5D", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B")[0];

  if(istrue(var_0))
    var_4 = level.c4_escape_array;

  foreach(var_7 in var_4) {
    if(isDefined(var_7)) {
      playFX(level._effect["_encstr_8CE217B6632B49122BA787EBE1C11A9398282D719BE011BAF5"], var_7.origin);
      playFX(level._effect["_encstr_8D1312A89BE703A96B8FE2658F6F16EF4DD26868"], var_7.origin);
      var_5 playLoopSound("_encstr_AF52196E1BE6EBC6E07DB94373F5B2E6ECA57359D72B878E7DB138");

      foreach(var_9 in getEntArray("_encstr_B1541E8D831AFF483089E980ADF27125933F03317701BEB8515B709815C95063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
        if(isDefined(var_9.model) && var_9.model == "_encstr_B84E279B51CBE2D110C36E7FEB78A237E7485383181703971933685C8BC82C2F9626AAFAC0760F9A32")
          var_9 delete();
      }

      playsoundatpos(var_5.origin, "_encstr_95EB166EC9638F3981C777999C362B23178960A3E177739F");
      playsoundatpos(var_5.origin, "_encstr_967915892759C26C86D7D886F5591E0E8DFA8E2716B9CD");
      level thread check_for_nearby_packages();
      _id_137A8();
    }
  }

  wait 5;

  if(isDefined(var_5))
    var_5 stoploopsound();
}

kill_players(var_0) {
  if(istrue(self.bteleported)) {
    return;
  }
  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self)
    scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_A19215CA05D90F336330697220476DFF71761F53A8436F");

  self.shouldskiplaststand = 1;
  self.shouldskipdeathsshield = 1;
  self.binc130 = undefined;
  thread screen_fade_to_black(3);
  self dodamage(self.maxhealth + 100000, self.origin);
}

screen_fade_to_black(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_2 = self;

  if(istrue(var_1)) {
    var_2 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    var_2 scripts\cp\utility::freezecontrolswrapper(1);
  }

  if(!isDefined(var_2.black_screen)) {
    var_2.black_screen = newclienthudelem(var_2);
    var_2.black_screen.x = 0;
    var_2.black_screen.y = 0;
    var_2.black_screen setshader("_encstr_83AB065EE1391A7B", 640, 480);
    var_2.black_screen.alignx = "_encstr_A5AD056A019C63";
    var_2.black_screen.aligny = "_encstr_AC190479FF92";
    var_2.black_screen.sort = 1;
    var_2.black_screen.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
    var_2.black_screen.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
    var_2.black_screen.foreground = 1;
  }

  var_2.black_screen.alpha = 0;

  if(istrue(var_1))
    var_2 waittill("_encstr_8D5609DA3DA4A282035BED");

  var_2.black_screen fadeovertime(var_0);
  var_2.black_screen.alpha = 1;
  wait(var_0);

  if(isDefined(var_2.black_screen))
    var_2.black_screen destroy();
}

watch_for_objective_failure(var_0) {
  level endon("_encstr_AC780E60BB1541AFE20765E01FBBE3AB");
  level waittill(var_0 + "_encstr_95D510A9455352EDC369171FC0BBAC9A3155");

  if(!istrue(level._id_13844)) {
    thread _id_123E2();
    scripts\cp\cp_objectives::_id_12868(var_0);
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
    return;
  }
}

record_teleport_data_and_teleport(var_0, var_1) {
  if(istrue(var_1)) {
    var_2 = [(16424, -10046.4, 16000), (16484, -10046.4, 32000), (16384, -10046.4, 32000), (16534, -10046.4, 32000)];
    var_0 shellshock("_encstr_81890DA344E67BB8E372C5BF61E86B", 0.5);
    waitframe();
    var_3 = scripts\engine\utility::random(var_2);
    var_0 setplayerangles((0, -45.0869, 0));
    var_0 setOrigin(var_3, 1);
  } else {
    var_4 = getEnt("_encstr_96E415966A1741F66C8768283B9FAB3139679628D39AA1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = level.c130.air_reference;
    var_6 = var_0.origin - var_4.origin;
    var_7 = rotatevectorinverted(var_6, var_4.angles);
    var_8 = var_0.angles - var_4.angles;
    var_9 = rotatevector(var_7, var_5.angles);
    waitframe();
    var_0 setOrigin(var_5.origin + var_9);
    var_0 setplayerangles(var_5.angles + var_8);
  }

  var_0 visionsetnakedforplayer("_encstr_99640BBF88E674E2C5AD3BF282");
  var_0 notify("_encstr_BD6C137BA3FB838E18AB0C2FB510552F08D932F349");
  var_0.weaponlist = var_0 getweaponslistprimaries();
  var_0.primaryweaponobj = var_0.weaponlist[0];
  var_0.secondaryweaponobj = var_0.weaponlist[1];
  var_0.binc130 = undefined;
  var_0 setclientomnvar("_encstr_A2AC0FAE96AFD02D19ACD7894BECB6B007", 0);
  playFX(level._effect["_encstr_96BD0F89E3570FA0ACEF4F67EA1579448B"], var_0 getEye());
  waitframe();
  var_0 thread parachute();
}

start_parachute_sequence() {
  self notify("_encstr_81FB1973E9089ADBA01B0A030186E313F8A327FB5320E347D09142");
  self endon("_encstr_81FB1973E9089ADBA01B0A030186E313F8A327FB5320E347D09142");
  var_0 = 1200;
  var_1 = (0, 0, 0);
  var_2 = anglesToForward(var_1) * var_0 * -1;

  for(;;) {
    var_3 = self getvelocity();

    if(!isDefined(level.c130)) {
      break;
    }

    if(istrue(self isonground() || self istouching(level.c130))) {
      waitframe();
      continue;
    }

    if(istrue(self.inlaststand)) {
      break;
    }

    if(var_3[2] < -300) {
      break;
    }

    waitframe();
  }

  thread parachute();
}

parachute() {
  var_0 = self getplayerangles();
  self unlink();
  self setplayerangles(var_0);
  self.weaponlist = self.primaryweapons;
  self.primaryweaponobj = self.weaponlist[0];
  self.secondaryweaponobj = self.weaponlist[1];
  thread scripts\cp_mp\parachute::startfreefall(1, 0);
  self weaponswitchbuttonPressed();
  self skydive_cutautodeployoff();

  foreach(var_2 in level.players) {
    var_2.no_outline = 0;
    var_2.no_team_outlines = 0;
    var_2 scripts\cp\utility::_unsetperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
    var_2 scripts\cp\utility::_unsetperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");
    var_2 scripts\cp\utility::_unsetperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
    var_2 scripts\cp\utility::_unsetperk("_encstr_8D08176EC1956C2D16D83ABCFAA1ACB09347982759B0B5959C");
  }
}

spawn_lz_spawners_on_landing(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_A6D31D9B3858DDCDFAB14FFACD1C1677CD95399BEBDEE6D71BC27346D29B9D");
  var_0 endon("_encstr_A6D31D9B3858DDCDFAB14FFACD1C1677CD95399BEBDEE6D71BC27346D29B9D");
  var_0 scripts\engine\utility::_id_143A6("_encstr_A9E113A3A845C6179835FCE5D801DF0DA9587A5B20", "_encstr_9674114388CBE9BA412D83FFAF61D2BE51C06B", "_encstr_8C900C26440B51B8E61F7950CB0C");

  if(level.landed_players.size < 1) {
    level notify("_encstr_AB45183105C4591CBA6B737F5383EEE08AD17B2B6E3F28DDA357");
    waitframe();
  }

  level.landed_players = scripts\engine\utility::array_add(level.landed_players, var_0);
}

end_exfil_plane(var_0, var_1) {
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

init_land_at_lz(var_0, var_1) {
  level.initlocationcircle = "_encstr_A1600B9921A51898B76BCE90B3";
  level.initlethalmaxoffsetmap = "_encstr_A1600B9921A51898B76BCE90B3";
  scripts\cp\cp_modular_spawning::stop_all_groups();
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  var_0.lz_struct = scripts\engine\utility::random(scripts\engine\utility::getStructArray("_encstr_AC100943027F38D8333BF8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));
  objective_setlocation(var_0.objectiveindex, 0, var_0.lz_struct.origin);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  brjugg_oncrateactivate();
  scripts\cp\utility::skydivestreamhintdvars("_encstr_ACBE16F04951C32FCF28F2FA588FE44F69A0669D5BF90BB7");
  thread _id_135C3();
}

_id_135C3() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9BC110FABF69FF24A5D03A4350975B9FC028", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = ["_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", "_encstr_9B69114A571F8EBD17484FBA87220987C71A97", "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA", "_encstr_A3EF0E518C324F35EBD9CA8250CB3A22"];

  foreach(var_3 in var_0) {
    var_3.angles = (0, 0, 0);
    var_4 = scripts\cp\cp_weapon::spawn_script_weapon(scripts\engine\utility::random(var_1), [], var_3.origin + (0, 0, 64), var_3.angles);
    var_4 thread scripts\cp\cp_weapon::watchweaponpickup();
  }
}

start_land_at_lz(var_0, var_1) {
  setDvar("_encstr_8B76165BEE4AC107529FB7931F5A4E88E4C74631528F70BE", 0);
  thread _id_123FB();
  level thread scripts\cp\utility::_id_123FE("_encstr_B40101");
  level thread _id_1446D(scripts\engine\utility::getStruct("_encstr_9BB70F0F8BCB0B0251591AA0FF639968ED", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, 6666);

  foreach(var_3 in level.littlebirds) {
    var_4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(var_3.vehiclename);

    if(isDefined(var_4.destroycallback))
      var_3 thread[[var_4.destroycallback]]();
  }

  thread playericontriggerexit();
  thread start_exfil_spawn_sequence();
  _id_14375(var_0, 3333);

  foreach(var_7 in level.players) {
    var_7 vehiclepinonminimap(0);
    var_7 scripts\cp\utility::brjugg_setconfig(0);
    var_7 scripts\cp\utility::hideminimap(1);

    if(isDefined(level.nuclear_core_carrier)) {
      if(var_7 == level.nuclear_core_carrier) {
        if(!isDefined(var_7.headicon))
          var_7.headicon = var_7 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, "_encstr_956215D838EB8E8536EB86AB32AFD236DE37BEE65DDA95", 30, 1, 29000, 29000, undefined, 1, 0, undefined, 1);
        else
          scripts\cp_mp\entityheadicons::_id_1315D(level.nuclear_core_carrier.headicon, var_7);

        continue;
      }

      scripts\cp_mp\entityheadicons::_id_1315D(level.nuclear_core_carrier.headicon, var_7);
    }
  }

  scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_8BE009D32F68613F1AF8E7");
}

playericontriggerexit() {
  wait 5;

  foreach(var_1 in level.players) {
    if(istrue(var_1.inlaststand)) {
      var_1 notify("_encstr_84C60FB29029874B3EFEA4A106C01FCB61");
      var_1.binc130 = undefined;
      var_1 notify("_encstr_ADDB0D9B2D4B28E08312533B3AFF20");
    }
  }

  level notify("_encstr_ADDB0D9B2D4B28E08312533B3AFF20");
}

_id_123FB() {
  while(istrue(level.dialogue_playing))
    wait 1;

  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_95CF218C877DD80EDCF5B516B658AF838D2CCD2BEB335AB91663EB6E8EB0DC8CFA1306", 10);
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A906217CE9E1C6E39EC6F22A2BF6277A1043FEC50FF08C534F98D973D3C72BB7318D38", 1);
}

start_exfil_after_timeout(var_0, var_1) {
  var_2 = var_0;
  thread scripts\cp\utility::objective_update(var_1.ref, var_2, int(var_2 / 2), int(var_2 / 3), 1);
  objective_setlabel(var_1.objectiveindex, &"_encstr_92AC1437EF8F6BB1425982AD0918D33A30992F70ABB8");
  objective_setdescription(var_1.objectiveindex, &"_encstr_92AC1437EF8F6BB1425982AD0918D33A30992F70ABB8");
  objective_setlocation(var_1.objectiveindex, 0, scripts\engine\utility::getStruct("_encstr_9BB70F0F8BCB0B0251591AA0FF639968ED", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
  objective_setshowdistance(var_1.objectiveindex, 1);
  level waittill(var_1.ref + "_encstr_95D510A9455352EDC369171FC0BBAC9A3155");
  objective_unsetlocation(var_1.objectiveindex, 0);
  level thread listen_for_exfil_heli_ready_to_land(var_1);
  level notify("_encstr_91750BE60B41C076B37326D770", var_1.lz_struct.origin, 1);
}

listen_for_exfil_heli_ready_to_land(var_0) {
  while(!isDefined(level.exfil_heli))
    wait 0.1;

  level.exfil_heli waittill("_encstr_8B7205D9ED5958");
  level notify("_encstr_B48811276D9D59CB08D30AD748D82F82E787F7");
  level thread _id_12403(["_encstr_B25924191ED7D80ECDAF8DB0DCDCF5078D169B59BE59F0CCA5B17D1B85B923EBCDB0B3BE8918", "_encstr_AC5924C2403FA6BB1BC00401EE233F2AF110EAAA1113D82BB0B12F348FE89B390DB8E281C251"], 30);
  level notify("_encstr_95C5114B8D59BF77CFB87A436841AF0B117BAC");
}

_id_14375(var_0, var_1) {
  for(;;) {
    if(!isDefined(level.nuclear_core_carrier)) {
      waitframe();
      continue;
    }

    if(distance(level.nuclear_core_carrier.origin, var_0.lz_struct.origin) <= var_1) {
      break;
    }

    waitframe();
  }
}

_id_14376(var_0, var_1) {
  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(!var_4 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(distance2dsquared(var_4.origin, var_0.lz_struct.origin) <= squared(var_1)) {
        var_2 = 1;
        break;
      }
    }

    if(var_2) {
      break;
    }

    if(isDefined(level.helis) && level.helis.size == 0) {
      break;
    }

    wait 0.5;
  }
}

waitforallplayersnearlz(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_2 = 1;

    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0.lz_struct.origin) > var_1) {
        var_2 = 0;
        continue;
      } else
        var_2 = 1;
    }

    wait 0.5;
  }
}

end_land_at_lz(var_0, var_1) {
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

debuglandatlz(var_0) {
  scripts\engine\utility::flag_set("_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E");
  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_AC100943027F38D8333BF8", 1);
  scripts\mp\playeractions::registeractionset("_encstr_AF960A180D8A1D57633A9308", ["_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_8F0508CE59DCA357392B", "_encstr_AD1904291F7B", "_encstr_AF4D07932B1BDE5846", "_encstr_96EB0B0BABD1DB39598DF616C8", "_encstr_92100762872552A643", "_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05", "_encstr_88780599B4E495", "_encstr_A6C7065BACB1CA95", "_encstr_919007AA5148539DA0"]);
  wait 15;

  foreach(var_3, var_2 in level.players)
  var_2 thread players_waittill_loadout_given_parachute(var_3);

  var_4 = scripts\engine\utility::random(level.players);
  var_4 thread give_loadout_and_core();
}

give_loadout_and_core() {
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  thread give_nuclear_core();
}

players_waittill_loadout_given_parachute(var_0) {
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  var_1 = scripts\engine\utility::random(scripts\engine\utility::getStructArray("_encstr_AC100943027F38D8333BF8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));
  var_2 = getrandomnavpoint(var_1.origin, 5000);
  var_3 = self;
  wait 5;
  var_3 setOrigin(var_2 + (0, 0, 16000), 1);
  var_3 thread scripts\cp_mp\parachute::startfreefall(1, 0);

  if(!isDefined(level.called_wave_spawning))
    level.called_wave_spawning = 1;
}

players_waittill_loadout_given() {
  self waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");
  level.safe_to_start_objective = 1;
}

stealth_init() {
  scripts\cp\coop_stealth::register_stealth_state_funcs();
}

jugg_death_func() {
  var_0 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self)
    level.ai_going_to_alarm = undefined;

  var_0 scripts\cp\coop_stealth::leave_corpse_for_others_to_see();
  var_0 scripts\cp\coop_stealth::delete_stealth_meter(var_0);
  var_0 scripts\cp\coop_stealth::delete_combat_icon(var_0);
  var_0.juggernautdisablemovebehavior = undefined;
  var_0.juggernautforcewalk = undefined;
}

soldier_enemy_death_func() {
  var_0 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self)
    level.ai_going_to_alarm = undefined;

  var_0 scripts\cp\coop_stealth::leave_corpse_for_others_to_see();
  var_0 scripts\cp\coop_stealth::delete_stealth_meter(var_0);
  var_0 scripts\cp\coop_stealth::delete_combat_icon(var_0);
}

jugg_enemy_watcher(var_0) {
  var_1 = self;

  if(istrue(level.global_stealth_broken)) {
    var_1 thread jugg_death_watcher_internal(var_1);
    var_1 thread jugg_damage_watcher_internal(var_1);
    return;
  }

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self)
    level.ai_going_to_alarm = undefined;

  var_1.sightmaxdistance = 2200;
  var_1 thread jugg_death_watcher_internal(var_1);
  var_1 thread jugg_damage_watcher_internal(var_1);
  var_1 thread scripts\cp\coop_stealth::run_common_functions(var_1, 0, 0);
}

_id_13F60() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  _id_12BF6();
}

sniper_enemy_watcher(var_0) {
  var_1 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self)
    level.ai_going_to_alarm = undefined;

  var_1.sightmaxdistance = 2700;
  var_1 thread scripts\cp\coop_stealth::run_common_functions(var_1, 0, 0, 70, 250000);
}

standard_soldier_watcher(var_0) {
  var_1 = self;

  if(isDefined(level.ai_going_to_alarm) && level.ai_going_to_alarm == self)
    level.ai_going_to_alarm = undefined;

  if(istrue(level.global_stealth_broken)) {
    var_1.script_radius = 2048;
    return;
  }

  var_1.sightmaxdistance = 2200;
  var_1 thread scripts\cp\coop_stealth::run_common_functions(var_1, 1, 1, 60, 250000);
}

players_reached_airport() {
  if(istrue(level.global_stealth_broken)) {
    return;
  }
  if(!istrue(level.global_stealth_broken))
    scripts\cp\cp_modular_spawning::stop_all_groups();

  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_860A0DD16126A058777AABD3220385");
}

plane_patrol_watcher(var_0) {
  var_1 = self;
  var_1.sightmaxdistance = 1100.0;
  var_1 thread scripts\cp\coop_stealth::run_common_functions(var_1, 1, 1, 60, 110889);
}

init_destroy_c130(var_0, var_1) {
  if(level.players_in_c130 != level.players.size) {
    foreach(var_3 in level.players)
    var_3 thread screen_fade_to_black(3, 1);

    thread _id_123E2();
    scripts\cp\cp_objectives::_id_12868("_encstr_A54E0C905A2303D079D8795BFEDF");
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
    return;
  }
}

start_destroy_c130(var_0, var_1) {
  waitforc130destroyed();
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_A1600B9921A51898B76BCE90B3");
}

end_destroy_c130(var_0, var_1) {
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

debugstartdestroyc130(var_0) {}

waitforc130destroyed() {
  level.c130 setCanDamage(1);

  foreach(var_1 in level.c130.body) {
    var_1 setCanDamage(1);
    var_1.health = 200 * level.players.size;
    var_1.maxhealth = 200 * level.players.size;
    var_1 thread damage_watcher_for_c130();
  }

  foreach(var_1 in level.c130_parts) {
    var_1 setCanDamage(1);
    var_1.health = 200 * level.players.size;
    var_1.maxhealth = 200 * level.players.size;
    var_1 thread damage_watcher_for_c130();
  }

  foreach(var_1 in level.exit_parts) {
    var_1 setCanDamage(1);
    var_1.health = 200 * level.players.size;
    var_1.maxhealth = 200 * level.players.size;
    var_1 thread damage_watcher_for_c130();
  }

  level.c130.upper_door setCanDamage(1);
  level.c130.upper_door.health = 200 * level.players.size;
  level.c130.upper_door.maxhealth = 200 * level.players.size;
  level.c130.upper_door thread damage_watcher_for_c130();
  level.c130.lower_door setCanDamage(1);
  level.c130.lower_door.health = 200 * level.players.size;
  level.c130.lower_door.maxhealth = 200 * level.players.size;
  level.c130.lower_door thread damage_watcher_for_c130();
  level.c130 waittill("_encstr_AD75063D571AE108");
}

damage_watcher_for_c130() {
  self notify("_encstr_A2A8188C16B6C2EC59EBDD85A36C34B2277DCC7B27BED8986606");
  self endon("_encstr_A2A8188C16B6C2EC59EBDD85A36C34B2277DCC7B27BED8986606");
  self endon("_encstr_977F14B98EDE38FAC816B50B762BD7BB85D1D81AAC9C");
  self.time_hit = gettime();

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(gettime() > self.time_hit) {
      if(self == level.c130)
        playFX(level._effect["_encstr_A9BA100388B7B357E9D35858E9409AF7E8A0"], var_3);

      if(self.health - var_0 <= 0) {
        level thread delay_plane_explosion();
        level.c130 notify("_encstr_977F14B98EDE38FAC816B50B762BD7BB85D1D81AAC9C");
      }

      level.c130.health = level.c130.health - var_0;
      var_1 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");
      self.time_hit = gettime() + 200;
      continue;
    }

    var_1 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_9A1B0E432D3A9AEA76B35939DC855DA3");
    self.health = self.health + var_0;
  }
}

c130_crash_sequence(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::random(scripts\engine\utility::getStructArray("_encstr_AB5D10A1DF06DF3966CA734FC84110CBA332", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B")).origin;
  var_2 = vectorNormalize(anglesToForward(var_0.angles));
  var_3 = vectorNormalize(var_1 - var_0.origin);
  var_4 = vectortoangles(var_3);
  var_2 = anglesToForward(vectortoangles(var_3));
  var_0 rotateTo(vectortoangles(var_2), 1);
  var_5 = anglelerpquatfrac(var_0.angles, var_4, 1);
  var_6 = (0, 0, -1 * getdvarint("_encstr_979A08F619C1EA8361C7", 800));
  var_7 = (0, 0, 0);
  var_8 = (100, 30, -360);
  var_9 = 15;
  var_10 = 10;
  var_11 = 0;
  level thread kill_all_c130_links();

  while(var_10 > 0) {
    var_12 = var_7 * level.framedurationseconds;
    var_13 = var_0.origin + var_12;
    var_14 = var_13 + var_2 * var_9;
    var_0 moveTo(var_14, level.framedurationseconds, level.framedurationseconds);
    var_11 = var_11 - -0.5;
    var_15 = clamp(var_11, -70, 0);

    if(var_15 <= -70)
      var_0 rotatepitch(-0.5, level.framedurationseconds);

    var_10 = var_10 - level.framedurationseconds;
    var_9 = var_9 + var_9 * level.framedurationseconds;

    if(var_9 >= 150)
      var_9 = 150;

    var_7 = var_7 - (0, 0, 1);

    if(var_7[2] <= -50)
      var_7 = (0, 0, -50);

    if(distance(var_0.origin, var_1) <= 3000) {
      break;
    }

    waitframe();
  }

  playFX(level._effect["_encstr_A9BA100388B7B357E9D35858E9409AF7E8A0"], level.c130.origin);
  var_2 = vectorNormalize(anglesToForward(var_0.angles)) * 1000;
  var_12 = var_7 * 2;
  var_13 = var_0.origin + var_12;
  var_9 = 10000;
  var_14 = var_13 + var_2 * var_9;
  var_0 moveTo(var_14, 4);
  playFX(level._effect["_encstr_A9BA100388B7B357E9D35858E9409AF7E8A0"], level.c130.origin);
  var_4 = vectortoangles(var_2);
  var_0 rotateTo(var_0.angles, 1);
  wait 2;
  playFX(level._effect["_encstr_A9BA100388B7B357E9D35858E9409AF7E8A0"], level.c130.origin);
  level.c130 delete();
}

kill_all_c130_links() {
  level.c130 endon("_encstr_AD75063D571AE108");

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("_encstr_A2AC0FAE96AFD02D19ACD7894BECB6B007", 0);
    var_1.binc130 = undefined;
    var_1 vehiclepinonminimap(0);
  }

  stopFXOnTag(level._effect["_encstr_A9BA100388B7B357E9D35858E9409AF7E8A0"], level.c130, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.c130 playsoundonmovingent("_encstr_876524B96CE6FAC638FA83B1859B95BE1AB4A92C366DAF8D62CC60AFAC870E8DD73AEDDCC28D");
  var_3 = level.c130 getlinkedchildren(1);

  if(isDefined(var_3)) {
    foreach(var_6, var_5 in var_3) {
      if(isPlayer(var_5)) {
        continue;
      }
      if(isDefined(var_5))
        var_5 delete();
    }
  }

  level.c130 delete();

  if(1) {
    return;
  }
  level.c130.plane_seats = level.c130_seat_refs;

  foreach(var_6, var_8 in level.c130.body)
  var_8 delete();

  if(isDefined(level.c130_parts)) {
    foreach(var_6, var_8 in level.c130_parts) {
      if(isDefined(var_8) && var_8 != level.c130)
        var_8 delete();
    }
  }

  if(isDefined(level.c130.air_reference))
    level.c130.air_reference delete();

  wait 1;

  if(isDefined(level.c130.plane_seats)) {
    foreach(var_6, var_8 in level.c130.plane_seats)
    var_8 delete();
  }

  if(isDefined(level.exit_parts)) {
    foreach(var_8 in level.exit_parts)
    var_8 delete();
  }

  var_13 = getEnt("_encstr_8E7615E0222E9D9613E738AEFF3B582F552980804A47E9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_13))
    var_13 delete();

  var_14 = getEnt("_encstr_95B3139C56C239AF467BED39EB46BDDDE6FA3B2BBD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_14))
    var_14 delete();

  var_15 = getEnt("_encstr_8F50139356C2E4BE46DBEDC9FA5D0ED7DADB8CAC36", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_15))
    var_15 delete();

  var_16 = getEnt("_encstr_88E11195B5B1F3F7C03F28E0894DE12FD13DD8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_16))
    var_16 delete();

  var_17 = getEntArray("_encstr_AD33090B4B4EF519BDDE39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_17)) {
    foreach(var_8 in var_17) {
      if(isDefined(var_8))
        var_8 delete();
    }
  }

  if(isDefined(level.c130_seat_refs)) {
    foreach(var_8 in level.c130_seat_refs) {
      if(isDefined(var_8))
        var_8 delete();
    }
  }

  var_22 = getEnt("_encstr_AD33090B4B4EF519BDDE39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_22))
    var_22 delete();

  if(isDefined(level.c130.upper_door))
    level.c130.upper_door delete();

  if(isDefined(level.c130.lower_door))
    level.c130.lower_door delete();

  if(isDefined(level.c130.lower_door_geo))
    level.c130.lower_door_geo delete();

  if(isDefined(level.c130.upper_door_geo))
    level.c130.upper_door_geo delete();

  var_23 = getEntArray("_encstr_A938135ABB47687A9A3F9B2FA87371891796DE724F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_25 in var_23) {
    if(isDefined(var_25))
      var_25 delete();
  }

  foreach(var_8 in level.mhc_escape_ents_array) {
    if(isDefined(var_8))
      var_8 delete();
  }

  level.c130 delete();
}

delay_plane_explosion() {
  c130_final_crash_sequence(level.c130);
}

use_garage() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_85A80BF0930F67576AD36F5FF2");
  self endon("_encstr_85A80BF0930F67576AD36F5FF2");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(level.garage_door.current_state == 666) {
      continue;
    }
    if(!istrue(level.can_open_door)) {
      continue;
    }
    operate_garage(var_0);
  }
}

any_ai_around_player(var_0) {
  var_1 = 0;
  var_2 = 10;
  var_3 = 2500;
  var_4 = gettime();

  foreach(var_6 in getaiarray("_encstr_8E8405EA382B2A")) {
    if(distancesquared(var_0.origin, var_6.origin) <= 100000000) {
      if(var_6 seerecently(var_0, var_2)) {
        var_6.killofftime = var_4 + var_3;
        var_1 = 1;
        break;
      } else if(scripts\engine\utility::can_trace_to_ai(var_0 getEye(), var_6, level.characters)) {
        var_6.killofftime = var_4 + var_3;
        var_1 = 1;
        break;
      }
    }
  }

  if(istrue(var_1))
    return 1;
  else
    return 0;
}

pulse_ai() {
  foreach(var_1 in getaiarray("_encstr_8E8405EA382B2A"))
  thread wave_outline(var_1);
}

wave_outline(var_0) {
  var_1 = scripts\cp\cp_outline_utility::outlineenableforall(var_0, "_encstr_8419044EB232", 0, 1, 0, "_encstr_BE8F0A272F9B2BE97268AE8B");
  wait 2.5;
  scripts\cp\cp_outline_utility::outlinedisable(var_1, var_0);
}

operate_garage(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(level.garage_door.current_state == 0) {
    level.garage_door.current_state = 666;
    level.garage_door setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_93CF08C7684F60BBB372");
    wait(getanimlength(level.scr_anim["_encstr_9ABA0CC97E5A209C62478997EF7B"]["_encstr_837E0C0FF940B1BA757F077363A8"]));
    level.garage_door.current_state = 1;
    level.garage_door.door_interaction setHintString(&"_encstr_9A3F16B71918D0E5B98D0A5DE5E13759FDEF5F3785AF88AD");
    level.show_garage_waypoint = 1;
    level.garage_door.door_interaction delete();
  }
}

lower_level_jugg_properties(var_0) {
  var_1 = self;
  var_1 thread jugg_death_watcher_internal(var_1);
  var_1 thread jugg_damage_watcher_internal(var_1);
}

jugg_death_watcher_internal(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108");
  var_0.juggernautforcewalk = undefined;
}

jugg_damage_watcher_internal(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_B2BE0788BAF573592F");
}

start_tunnel_sequence() {
  if(istrue(level.global_stealth_broken)) {
    return;
  }
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_91D10DD385D3EA1A893F1150557F4A");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_82ED0E94E52005C2631F46BA017C5D3E");
  return;
}

spawn_fake_ai_vehicles() {}

spawnapc() {
  level.convoy_speed_override = 12;
  var_0 = scripts\engine\utility::getStruct("_encstr_8FF20EF333F3C807B1F5BF53EB5A9EEB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.owner = level.players[0];
  var_1.disableusabilityatspawn = 1;
  var_1.team = "_encstr_8E8405EA382B2A";
  var_1.cannotbesuspended = 1;
  var_2 = scripts\cp_mp\vehicles\apc_rus::apc_rus_create(var_1);
  wait 2;
  var_3 = var_2;
  var_3 setCanDamage(1);
  var_4 = var_0;
  var_3.pathing_array = [];
  var_3.pathing_array[var_3.pathing_array.size] = var_4;

  for(var_4.pathing_index = var_3.pathing_array.size; isDefined(var_4.target); var_3.pathing_array[var_3.pathing_array.size] = var_4) {
    var_4 = scripts\engine\utility::getStruct(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4.pathing_index = var_3.pathing_array.size;
  }

  if(var_3.pathing_array.size > 27)
    var_3 scripts\cp\cp_vehicles::split_large_pathing_array();

  var_3.cp_speed = 50;
  var_3 thread scripts\cp\cp_vehicles::vehiclefollowstructpath(var_3.pathing_array);
  var_3.health = 50000;
  var_3.angles = var_0.angles;
  var_3 thread watchforvehiclesuspendedstate(var_3);
  var_3 thread watchforplayersgettingclose();
  var_3 thread watchforapcdeath();
  var_3 thread watchforpayloadongoal("_encstr_B1C315B32BD07D36B4B3D76DB48DC6CAC9B9FAD9DE0B8D");
}

watchforplayersgettingclose() {}

watchforvehiclesuspendedstate(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_96E9151F7EB3F9F07983F1906F9189099AA7AF2C556AB1");

  for(;;) {
    if(var_0 issuspendedvehicle())
      var_0 wakeupvehicle();

    wait 0.1;
  }
}

watchforapcdeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0.angles = self.angles;
  var_0 setModel("_encstr_952A1F6407DA29BE3DEF20C1834691AF33EB57E01F421FE30CE7E878975F692FEB");
}

watchforpayloadongoal(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;

  while(distance(self.origin, var_1) > 100)
    wait 0.5;

  waitframe();
  thread apcstop(self);
}

apcstop(var_0) {
  if(var_0 issuspendedvehicle())
    var_0 wakeupvehicle();

  var_0 vehicle_setspeedimmediate(0, 0.002, 0.002);
  var_1 = "_encstr_8823119675DAFF897F878020BB99612B219D8F";

  foreach(var_3 in scripts\engine\utility::getStruct("_encstr_ACC017C3D8BF3361014F8B17806DD17BC180B16E244EE5831B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"))
  magicgrenademanual(var_1, var_3.origin, (0, 0, 5), 0.05);

  scripts\engine\utility::delaythread(1, scripts\cp\cp_modular_spawning::run_spawn_module, "_encstr_ACC017C3D8BF3361014F8B17806DD17BC180B16E244EE5831B");
}

apcstart(var_0) {
  if(var_0 issuspendedvehicle())
    var_0 wakeupvehicle();

  var_0 resumespeed(0.002);
}

cansee_detailed(var_0, var_1, var_2) {
  var_3 = distance(var_0.origin, var_1.origin);
  var_4 = var_3 <= var_2;
  var_5 = var_0 getEye();
  var_6 = var_1 getEye();
  var_7 = anglesToForward(var_0.angles);
  var_8 = vectorNormalize(var_6 - var_5);
  var_9 = vectordot(var_8, var_7);

  if(var_4)
    var_10 = 0.34202;
  else
    var_10 = 0.819152;

  var_11 = var_9 >= var_10;

  if(!var_11) {
    var_12 = 0;
    return var_12;
  }

  var_12 = var_0 cansee(var_1) && var_0 canshootenemy();

  if(var_12) {
    var_13 = angleclamp180(vectortopitch(var_1.origin - var_0.origin));

    if(var_13 < var_0.upaimlimit || var_13 > var_0.downaimlimit)
      var_12 = 0;
  }

  var_14 = sighttracepassed(var_5, var_6, 0, var_1, 1);

  if(!var_14) {
    var_12 = 0;
    return var_12;
  }

  return var_12;
}

c130_final_crash_sequence(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 unlink();
  var_0 waittill("_encstr_952516A2BB02B885630331535BAFD76F5D573FCF8D7FB6B8");
  playFXOnTag(level._effect["_encstr_A9BA100388B7B357E9D35858E9409AF7E8A0"], level.c130, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.c130 playsoundonmovingent("_encstr_876524B96CE6FAC638FA83B1859B95BE1AB4A92C366DAF8D62CC60AFAC870E8DD73AEDDCC28D");

  if(getdvarint("_encstr_A2CE11B9B1397D1C1AA6F5DC43961CD7563CE0", 0) != 0)
    wait 1.5;
  else
    wait 2;

  level.c130 moveTo(level.c130.mp_crash2, 560);
  wait 120;
  level thread kill_all_c130_links();
}

throw_players_out() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.binc130))
      continue;
  }
}

start_exfil_spawn_sequence() {
  scripts\engine\utility::flag_init("_encstr_B6520A8E7852C3499BE8AC34");
  level thread spawn_enemy_chopper();
}

init_holdout(var_0, var_1) {
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  var_0.lz_struct = scripts\engine\utility::getStruct("_encstr_9BB70F0F8BCB0B0251591AA0FF639968ED", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

start_holdout(var_0, var_1) {
  if(level.helis.size > 0) {} else {
    objective_setlabel(var_0.objectiveindex, &"_encstr_AAD61586A0D7C8AA2150A4CB51B0912526D72614091531");
    objective_setdescription(var_0.objectiveindex, &"_encstr_AAD61586A0D7C8AA2150A4CB51B0912526D72614091531");
    objective_setlocation(var_0.objectiveindex, 0, var_0.lz_struct.origin);
    objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
    objective_setshowdistance(var_0.objectiveindex, 1);
  }

  _id_14376(var_0, 7000);
  scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_9AE009A1DBE56BE03AB843");
}

end_holdout(var_0, var_1) {}

debugholdout(var_0) {
  scripts\engine\utility::flag_set("_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E");
  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_AC100943027F38D8333BF8", 1);

  foreach(var_3, var_2 in level.players)
  var_2 thread players_waittill_loadout_given_parachute(var_3);
}

spawn_enemy_chopper() {
  if(scripts\engine\utility::flag_exist("_encstr_B6520A8E7852C3499BE8AC34"))
    scripts\engine\utility::flag_set("_encstr_B6520A8E7852C3499BE8AC34");

  level.helis = [];
  level.skip_basic_combat = 0;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_83692117EF4F0B13ACE6D027B5B02110FFF14F0F7DB55893F709F0DEC1BD7551BB38A3");
  var_0 = scripts\engine\utility::getStruct("_encstr_9B6810FA67AB0B71335563A1E7C3AB89EF2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.classname_mp = "_encstr_AF331BC31EE30FBA4961F3DAC0ABB6D3F9E85958A769538777988AB3C8";
  var_0.script_modelname = "_encstr_8DCA216DE564BAD8C7FAE8B642EF06C97E70D7118DCD72B5E73203BE6AA7BE4819DD71";
  var_0.vehicletype = "_encstr_A60D0E2307118F4150A11F847AC08F30";

  for(var_1 = 0; var_1 < 1; var_1++) {
    level.helis[var_1] = _id_1356A(var_0, level.skip_basic_combat);
    level.helis[var_1] thread watch_for_death(level.skip_basic_combat);
    wait 10;
  }
}

watch_for_death(var_0) {
  self waittill("_encstr_A5D616CECAD0D28DC656F5C89516471A1A7B5BC1D895E8CA");

  if(scripts\engine\utility::array_contains(level.helis, self))
    level.helis = scripts\engine\utility::array_remove(level.helis, self);

  level.skip_basic_combat++;

  if(level.skip_basic_combat >= 1) {
    level.skip_basic_combat = 0;
    level notify("_encstr_B14F116337DD62BFC838121A1128F7DA3D43E3");
    thread scripts\cp\utility::objective_update("_encstr_A9F80B8D207BDD1953FBD978FB", undefined, undefined, undefined, 1, undefined, 1);
    level thread listen_for_exfil_heli_ready_to_land();
    level notify("_encstr_91750BE60B41C076B37326D770", scripts\engine\utility::getStructArray("_encstr_AC100943027F38D8333BF8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B")[0].origin, 1);
  }
}

_id_1356A(var_0, var_1) {
  var_2 = undefined;

  if(var_1 != 0)
    var_2 = "_encstr_91A61001B5D580680FEA99E3923B20886D1C";

  var_3 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_3.death_fx_on_self = 1;
  var_3 scripts\cp\helicopter\cp_helicopter::heli_mg_create("_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED", "_encstr_B1DA118FE9B73268D01EF3BB9340ADFBAF6753", "_encstr_99FE0B2B19086F6B9DC5D387E1");
  var_3 thread setup_pilot(1);
  var_3.isheli = 1;
  var_3.health = 50000;
  var_3.maxhealth = 50000;
  var_3 = _id_13F91(var_3);
  var_3.team = "_encstr_8E8405EA382B2A";
  var_3 setvehicleteam(var_3.team);
  var_3 thread scripts\cp\cp_vehicles::is_done_speaking();
  level thread scripts\cp\cp_weapon::add_to_special_lockon_target_list(var_3);
  var_3 thread scripts\cp\cp_vehicles::smoke_wheelson_chosen_spawn();
  var_3.headicon = deleteheadicon(var_3);
  setheadiconfriendlyimage(var_3.headicon, "_encstr_A6371ED0BAC8D74B6C7BE6BE43AC58C8AFCA17575A0E5B2B73E8BE56E656B697");
  setheadiconsnaptoedges(var_3.headicon, 12000);
  setheadiconmaxdistance(var_3.headicon, 1500);
  addclienttoheadiconmask(var_3.headicon, 10);
  setheadicondrawthroughgeo(var_3.headicon, 1);
  var_3 setmaxpitchroll(15, 15);
  var_3.health_remaining = 2500;

  if(var_1 != 0)
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(var_3, undefined, "_encstr_91A61001B5D580680FEA99E3923B20886D1C");
  else
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(var_3);

  var_3 sethoverparams(25, 15, 10);
  return var_3;
}

_id_13F91(var_0) {
  var_1 = 1;

  if(scripts\cp\cp_relics::calldropbag())
    var_1 = 5;

  var_0.health = var_0.health * var_1;
  var_0.maxhealth = var_0.maxhealth * var_1;
  return var_0;
}

setup_pilot(var_0) {
  var_1 = "_encstr_BDF30A3B51CCFF9AC049F7D4";

  if(!self tagexists(var_1))
    var_1 = "_encstr_AB680B55361AD76B09EB28E886";

  self.pilot = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin(var_1));
  self.pilot setModel("_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4");
  self.pilot linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  self.pilot scriptmodelplayanimdeltamotion("_encstr_AFB4168310E1758238C1A77F8148DBB9A058BB41A8500C1A");

  if(istrue(var_0)) {
    thread _id_14455();
    thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor();
  }
}

kill_chopper_hint(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    level thread scripts\cp\utility::cp_add_dialogue_line(&"_encstr_B4A51859C99E14CDBB5E86061B8BB1E85120045161A748E99859");
    wait 30;
  }
}

_id_14455() {
  self endon("_encstr_ACAA1AFF5FA8235FFB3998E7B97C184D3AFFDD060AC818D7F04D4408");
  self waittill("_encstr_A5D616CECAD0D28DC656F5C89516471A1A7B5BC1D895E8CA", var_0, var_1);

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
    self.headicon = undefined;
  }

  playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], var_0 + (0, 0, -100));
  playsoundatpos(var_0, "_encstr_B4E1196C83BE1327AFE6CB9CDAAF8D43DBE0C159C97DC693B0DCD0");
  self stoploopsound();
  wait 0.05;
  earthquake(0.45, 3, var_0 + (0, 0, -100), 1024);
  wait 0.05;
  radiusdamage(var_0 + (0, 0, -100), 1024, 500, 50);
  wait 0.05;

  if(isDefined(self.pilot))
    self.pilot delete();

  if(isDefined(self))
    self delete();
}

init_extract_lz(var_0, var_1) {
  level thread _id_13561();
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  var_2 = 0;
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("_encstr_9BB70F0F8BCB0B0251591AA0FF639968ED", var_2, ::intro_safehouse_edit_loadout);

  if(level.helis.size > 0)
    thread scripts\cp\utility::objective_update("_encstr_A2E90B1B20988F2BC1852723BF", undefined, undefined, undefined, 1, undefined, 1);
  else
    thread scripts\cp\utility::objective_update("_encstr_A9F80B8D207BDD1953FBD978FB", undefined, undefined, undefined, 1, undefined, 1);

  level thread _id_14456();
  scripts\cp\cp_objectives::_id_1317E(var_0, [scripts\engine\utility::getStruct("_encstr_9BB70F0F8BCB0B0251591AA0FF639968ED", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin]);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  var_0.lz_struct = scripts\engine\utility::random(scripts\engine\utility::getStructArray("_encstr_AC100943027F38D8333BF8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));
}

_id_14456() {
  level endon("_encstr_B14F116337DD62BFC838121A1128F7DA3D43E3");

  for(;;) {
    if(level.helis.size > 0) {
      waitframe();
      continue;
    } else {
      level notify("_encstr_91750BE60B41C076B37326D770", scripts\engine\utility::getStructArray("_encstr_AC100943027F38D8333BF8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B")[0].origin, 1);
      level notify("_encstr_B14F116337DD62BFC838121A1128F7DA3D43E3");
    }
  }
}

_id_1446D(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_1))
    var_1 = 4096;

  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(!var_4 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(distance2dsquared(var_4.origin, var_0) <= squared(var_1)) {
        var_2 = 1;
        break;
      }
    }

    if(var_2) {
      break;
    }

    wait 0.5;
  }

  thread _id_13561();
}

_id_13561() {
  if(istrue(level.onenterbattlechatter)) {
    return;
  }
  level.onenterbattlechatter = 1;
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_95960ECA1E66D21BAF6EE62DE095C9E6");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AF770B0D3B393B6A5F7B736C5B");
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B84E0BAAF2CCA71DF1C97547CF");
  wait 30;
  level thread spawn_waves_after_a_delay(1, undefined, "_encstr_84A70A2190F6D8A169637965");
}

_id_14453() {
  level endon("_encstr_B14F116337DD62BFC838121A1128F7DA3D43E3");

  for(;;) {
    if(level.helis.size > 0) {
      waitframe();
      continue;
    } else
      level notify("_encstr_B14F116337DD62BFC838121A1128F7DA3D43E3");
  }
}

playerhealthomnvarwatcher() {
  if(level.helis.size == 0) {
    level thread listen_for_exfil_heli_ready_to_land();
    level notify("_encstr_91750BE60B41C076B37326D770", scripts\engine\utility::getStructArray("_encstr_AC100943027F38D8333BF8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B")[0].origin, 1);
  }
}

start_extract_lz(var_0, var_1) {
  scripts\engine\utility::flag_init("_encstr_93D00ED3760F28BFBF521679BA5367CB");
  level thread playerhealthomnvarwatcher();
  level thread scripts\cp\utility::_id_123FE("_encstr_BD121B4B481ABEA6EACE216B58CA1823C345617B6BFA8B98D2FF1AA7DA");

  foreach(var_3 in level.players)
  var_3 setsoundsubmix("_encstr_822C12BE606FB8DB03126818DA5FEFF0BF0B3326", 5);

  level thread _id_12403(["_encstr_B20A24E44396F76A9791A24AC8AFE9F3A8A7669D487923374BE09942B8C19A57E11EF82FD72B", "_encstr_910A24398839F0DF2F2958E1F377AF208DE9A5A3071FF02CAF3236E9AB534E206643D15FF292", "_encstr_820A24A871393E53C6FFD9DB273F87BFC1E9A622506D708629C0A750D0DBC5D7B778202FBF3A"], 30);
  level waittill("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");
  thread _id_130A8(level.heli_trip_vehicle);
  level notify("_encstr_B48811276D9D59CB08D30AD748D82F82E787F7");
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_91FD1B5D7099AF6B132730408F4BC6C1D25EC05501325B13FACFA1CAEA");

  foreach(var_3 in level.players) {
    if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == var_3) {
      var_3 scripts\cp\utility::hint_prompt("_encstr_A2B80A8C4E7BC1D7367BC92B", 0);
      var_3 notify("_encstr_8A8211E8F86AF7AB451AF0A74191D60FE6AB12");
      var_6 = var_3 getcurrentweapon();
      var_3 takeweapon(var_6);
    }

    scripts\cp\cp_outofbounds::enableoobimmunity(var_3);
    var_3 thread scripts\cp_mp\xmike109::screenent_d("_encstr_91490A8D397B9B9BDDA537C8");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_3 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_81520E737DB776976FC7A86C683FCFB8");
        continue;
      }

      var_3 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_B8D01211A54FAF66AB7AC36121078839D91B3FCB");
    }
  }

  scripts\cp\cp_achievement::update_achievement_all_players("_encstr_AAB606A02553A822", 1);
  scripts\cp\cp_achievement::update_achievement_all_players("_encstr_88790841A4862D62A29A", 1);
  level thread scripts\cp\utility::_id_123FE("_encstr_B40101");
  scripts\engine\utility::flag_set("_encstr_93D00ED3760F28BFBF521679BA5367CB");
}

end_extract_lz(var_0, var_1) {
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

debugextractlz(var_0) {
  scripts\engine\utility::flag_set("_encstr_8EBB13361CEB07B11673B2AF1AB4A68536B6EB366E");
  scripts\engine\utility::flag_wait("_encstr_83EB1DBFD1802B4428D04FD908B09AF2661FC7277F28420F203B055F63F8DC");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_AC100943027F38D8333BF8", 1);

  foreach(var_3, var_2 in level.players)
  var_2 thread players_waittill_loadout_given_parachute(var_3);
}

intro_safehouse_edit_loadout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self solid();
  self disconnectPaths();
  startplayerboarding();
}

startplayerboarding() {
  level thread wait_for_all_players_ready(self);
  var_0 = self;
  var_0.animname = "_encstr_BD9E0EA7DBEA038131D343F0A34890C0";
  var_0 scripts\cp\vehicles\cp_heli_trip::init_interactions(::_id_14080);
}

wait_for_all_players_ready(var_0) {
  for(;;) {
    if(scripts\cp\infilexfil\blima_exfil::all_alive_players_in_chopper() && istrue(level._id_11EDB)) {
      var_0 notify("_encstr_84B715C263D8BE38B158E5CAE4B9EB7B377D89F6C23991");
      return;
    }

    wait 0.1;
  }
}

_id_14080(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD0E1041F595C028536A184082C7E038AF4E");
  self makeusable();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!istrue(level._id_11EDB)) {
      if(!isDefined(level.nuclear_core_carrier)) {
        thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_BEBD1B057A2F41DD58872DCFDB300EE197060CBF5747919F71531305AF", "_encstr_9A8507BA4040188D08", 3.75);
        continue;
      } else if(var_2 == level.nuclear_core_carrier) {
        var_2 takeweapon("_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F");

        if(istrue(var_2.hasriotshield)) {
          if(isDefined(var_2.primaryweaponobj) && var_2.primaryweaponobj.basename == "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1") {
            if(isDefined(var_2.secondaryweaponobj))
              var_2 switchtoweaponimmediate(var_2.secondaryweaponobj);
            else {
              var_3 = scripts\cp\cp_weapon::buildweapon("_encstr_9106102387E011DF472978E0722F376ADAB9", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
              var_2 scripts\cp\utility::_giveweapon(var_3);
              var_2 switchtoweaponimmediate(var_3);
            }
          } else if(isDefined(var_2.secondaryweaponobj) && var_2.secondaryweaponobj.basename == "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1") {
            if(isDefined(var_2.primaryweaponobj))
              var_2 switchtoweaponimmediate(var_2.primaryweaponobj);
            else {
              var_3 = scripts\cp\cp_weapon::buildweapon("_encstr_9106102387E011DF472978E0722F376ADAB9", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
              var_2 scripts\cp\utility::_giveweapon(var_3);
              var_2 switchtoweaponimmediate(var_3);
            }
          }
        } else {
          var_4 = var_2.default_starting_pistol;

          if(isDefined(var_2.primaryweaponobj))
            var_4 = var_2.primaryweaponobj;
          else if(isDefined(var_2.secondaryweaponobj))
            var_4 = var_2.secondaryweaponobj;

          var_2 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_4, undefined, undefined, 1);
          var_2 switchtoweaponimmediate(var_4);
        }

        var_2 scripts\cp\utility::hint_prompt("_encstr_A2B80A8C4E7BC1D7367BC92B", 0);
        var_2 notify("_encstr_8A8211E8F86AF7AB451AF0A74191D60FE6AB12");
        level._id_11EDB = 1;
      } else {
        thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_BEBD1B057A2F41DD58872DCFDB300EE197060CBF5747919F71531305AF", "_encstr_9A8507BA4040188D08", 3.75);
        continue;
      }
    }

    self makeunusable();
    var_2 thread scripts\cp\vehicles\cp_heli_trip::playerpassengerthink(var_1);
    break;
  }
}

garage_door_anim() {
  while(!scripts\engine\utility::flag_exist("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    wait 1;

  scripts\engine\utility::flag_wait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  var_0 = getEnt("_encstr_911711D1AC6E47BE9D85C985D9ACEB46B7DB27", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 makeusable();
  var_1 setHintString(&"_encstr_A2311537F3419411829687300DB8D9D8F907AB9D4F28CD");
  var_1 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 sethintdisplayrange(128);
  var_1 sethintdisplayfov(65);
  var_1 setuserange(128);
  var_1 setusefov(65);
  var_1 sethintonobstruction("_encstr_BD1805CB69C063");

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A");
    var_0 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_93CF08C7684F60BBB372");
    var_1 makeunusable();
    wait 10;
    var_1.origin = var_1.origin + (0, 0, 80);
    var_1 dontinterpolate();
    var_1 setHintString(&"_encstr_87AF12D9B17D3154FF9A607DB3FF1E871DE8B111");
    var_1 makeusable();
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A");
    var_0 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_BEE608BF50D84BAA9DF4");
    var_1 makeunusable();
    wait 10;
    var_1.origin = var_1.origin - (0, 0, 80);
    var_1 dontinterpolate();
    var_1 setHintString(&"_encstr_BE0711ADD75F4047E4816777B19D1FB8F9C5E5");
    var_1 makeusable();
  }
}

math_pointoncircle(var_0, var_1) {
  var_2 = var_0 * cos(var_1);
  var_3 = var_0 * sin(var_1);
  return (var_2, var_3, 0);
}

math_pointonellipse(var_0, var_1) {
  var_2 = var_0 * cos(var_1);
  var_3 = var_0 * sin(var_1) * 0.5;
  return (var_2, var_3, 0);
}

math_pointonlemniscate(var_0, var_1) {
  var_2 = var_0 * sqrt(2) * cos(var_1) / (squared(sin(var_1)) + 1);
  var_3 = var_0 * sqrt(2) * cos(var_1) * sin(var_1) / (squared(sin(var_1)) + 1);
  return (var_2, var_3, 0);
}

init_recover_nuclear_core(var_0, var_1) {
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  scripts\mp\playeractions::registeractionset("_encstr_AF960A180D8A1D57633A9308", ["_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_8F0508CE59DCA357392B", "_encstr_AD1904291F7B", "_encstr_AF4D07932B1BDE5846", "_encstr_96EB0B0BABD1DB39598DF616C8", "_encstr_92100762872552A643", "_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05", "_encstr_88780599B4E495", "_encstr_A6C7065BACB1CA95", "_encstr_919007AA5148539DA0"]);
  var_0.crashed_nuke_interaction = getEnt("_encstr_85D215A6639239E0435A4F5B801DD3C7291A5766E9D50D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_onentity(var_0.objectiveindex, var_0.crashed_nuke_interaction);
  var_0.crashed_nuke_interaction.origin = var_0.crashed_nuke_interaction.origin + (0, 0, 6669);
  var_0.crashed_nuke_interaction physicslaunchserver(var_0.crashed_nuke_interaction.origin, (0, 0, -1));
  var_2 = var_0.crashed_nuke_interaction physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_2, (0, 0, -1));
  var_0.crashed_nuke_interaction physics_registerforcollisioncallback();
  var_0.crashed_nuke_interaction thread watchnukeimpact();
  level waittill("_encstr_AC8E13D32074FD9BFA280C5852453B09A6A47F9DCB");

  if(isDefined(var_0.crashed_nuke_interaction)) {
    var_0.crashed_nuke_interaction setHintString(&"_encstr_A23A1556E2017D47AAE749AA8B89DD3FC99AD0CE8D69B3");
    var_0.crashed_nuke_interaction sethintdisplayrange(200);
    var_0.crashed_nuke_interaction sethintdisplayfov(120);
    var_0.crashed_nuke_interaction setusefov(120);
    var_0.crashed_nuke_interaction setuserange(72);
    var_0.crashed_nuke_interaction sethintonobstruction("_encstr_BD1805CB69C063");
    var_0.crashed_nuke_interaction sethinticon("_encstr_9A8F11CDC1D816DC34EBA51BB7DCAF9BABD656");
    var_0.crashed_nuke_interaction makeusable();
    var_0.crashed_nuke_interaction thread give_core(var_0.crashed_nuke_interaction);
  }
}

watchnukeimpact() {
  level endon("_encstr_86D808B2CDC8474396E6");
  var_0 = 1;

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    var_9 = "_encstr_AA66152FE0E3D49367871116EE23AB9DEE5897F348391C";
    var_10 = gettime();
    self notify("_encstr_AC01143363EA4BE186D3BE037F53F0FE83E713241975", var_10);

    if(var_7 < 100) {} else if(var_7 < 200) {} else if(var_7 < 300) {} else if(var_7 < 400) {} else if(var_7 > 400) {}

    if(istrue(var_0))
      var_0 = 0;
    else
      self waittill("_encstr_AC5F0F4359CFEB2738C07A0639E81F521B");

    playFX(scripts\engine\utility::getfx(var_9), var_5, var_6);
    level notify("_encstr_AC8E13D32074FD9BFA280C5852453B09A6A47F9DCB");
    level notify("_encstr_86D808B2CDC8474396E6");
  }
}

give_core(var_0) {
  var_0 endon("_encstr_A25F0710622DF3B3D7");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(var_1 hasweapon("_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")) {
      var_1 thread scripts\cp\utility::hint_prompt("_encstr_B1F40F50CF26CBFF3B6C9E92C9B2E31197", 1, 2);
      continue;
    }

    if(isDefined(level.nuclear_core))
      level.nuclear_core delete();

    level.nuclear_core_carrier = var_1;

    if(isDefined(var_0)) {
      if(isDefined(var_0.headiconid))
        var_0 thread scripts\cp\utility::ent_deleteheadicon(var_0, var_0.headiconid);
    }

    var_2 = var_1 getcurrentweapon();
    var_3 = getcompleteweaponname("_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F");
    var_1 scripts\cp\utility::_giveweapon(var_3);
    var_1 switchtoweapon(var_3);
    var_1 scripts\mp\playeractions::allowactionset("_encstr_AF960A180D8A1D57633A9308", 0);
    var_1 allowmountside(0);
    var_1 allowmounttop(0);
    var_1 allowjog(0);
    var_1 scripts\cp\respawn\cp_respawn::watchnukeweaponenduse(var_3, var_2);
    var_1 thread watcher_for_core_pickup();
    level notify("_encstr_BACC0FDF770D70BD87435179196F6058E7");
    var_0 delete();
  }
}

start_recover_nuclear_core(var_0, var_1) {
  level waittill("_encstr_BACC0FDF770D70BD87435179196F6058E7");
}

end_recover_nuclear_core(var_0, var_1) {
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

debugrecover_nuclear_core(var_0) {}

smoke_up_landing_zone_for_enemy_ai(var_0) {
  magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", var_0.origin, (0, 0, 0), 0.3);
}

spawn_enemy_tanks() {
  wait 15;

  while(!isDefined(level.players) || level.players.size < 1)
    wait 1;

  scripts\engine\utility::flag_init("_encstr_85700DE4956BDBECCAFAE816375BE6");
  var_0 = scripts\engine\utility::getStructArray("_encstr_877812DB4D1690D7B8162558F752D32793E9EDA0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.altgunnerturret = "_encstr_ACA312FBB97D1B1EFB17451B90AB4F05ED9FD043";
  level.enemy_tanks = [];

  foreach(var_2 in var_0)
  level thread spawn_enemy_tank(var_2);
}

spawn_enemy_tank(var_0) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawnmethod = "_encstr_AFBE0AD985B659FADABDC856";
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_1);
  var_1.owner = level.players[0];
  var_1.team = "_encstr_8E8405EA382B2A";
  var_1.faceawayfromowner = 0;
  var_1.cancapture = 0;
  var_1.cancaptureimmediately = 0;
  var_1.spawnmethod = "_encstr_AA0B120E360BD8CAAF0B8EF507BDCD2D47B4DB37";
  var_1.activateimmediately = 1;
  var_1.cantimeout = 0;
  var_2 = scripts\cp_mp\vehicles\light_tank::light_tank_create(var_1);

  if(!isDefined(var_2)) {
    return;
  }
  level.enemy_tanks[level.enemy_tanks.size] = var_2;
  var_2 thread tank_waittill_death();
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var_3 = scripts\engine\utility::getStructArray("_encstr_874D103A18A33D87B66D31268ADEEB46F940", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = sortbydistance(var_3, var_2.origin)[0];
  var_5 = build_tank_path(var_4);
  var_6 = build_tank_duration(var_4);
  var_2 startpathnodes(var_5, var_6);
  setheadiconsnaptoedges(var_2.headicon, 8088);
  var_7 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_2, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_8 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_2, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");

  for(;;) {
    if(!isDefined(level.players)) {
      wait 1;
      continue;
    }

    if(scripts\engine\utility::flag("_encstr_85700DE4956BDBECCAFAE816375BE6")) {
      return;
    }
    var_9 = var_2 scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var_9) || !istrue(level.global_stealth_broken)) {
      wait 1;
      continue;
    }

    if(istrue(var_9.binvehicle) && isDefined(var_9.vehicle)) {
      if(var_7 turretcantarget(var_9.vehicle.origin + (0, 0, 50)))
        var_7 settargetentity(var_9.vehicle);

      if(var_8 turretcantarget(var_9.vehicle.origin + (0, 0, 50)))
        var_8 settargetentity(var_9.vehicle);
    } else {
      var_7 settargetentity(var_9);
      var_8 settargetentity(var_9);
    }

    var_2 thread tank_shoot_at_target(var_8, 1);
    var_2 thread tank_shoot_at_target(var_7);
    wait(randomfloatrange(4, 8));
  }
}

tank_shoot_at_target(var_0, var_1) {
  var_2 = 1;
  var_3 = getcompleteweaponname("_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");

  if(istrue(var_1)) {
    var_2 = randomintrange(15, 25);
    var_3 = getcompleteweaponname("_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");
  }

  var_4 = weaponfiretime(var_3);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    if(scripts\engine\utility::flag("_encstr_85700DE4956BDBECCAFAE816375BE6")) {
      return;
    }
    var_0 shootturret();
    wait(var_4);
  }
}

build_tank_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = var_2.origin; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = var_2.origin)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

build_tank_duration(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = 4; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = 4)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

tank_waittill_death() {
  self waittill("_encstr_AD75063D571AE108");
  thread scripts\cp_mp\vehicles\light_tank::light_tank_explode();
  level.enemy_tanks = scripts\engine\utility::array_remove(level.enemy_tanks, self);
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

syncleadmarkers() {
  level.scr_animtree["_encstr_85A10E06AA62F341405F98708F79590D"] = #animtree;
  level.scr_anim["_encstr_85A10E06AA62F341405F98708F79590D"]["_encstr_A7CB0BD97D6968439D304B39C3"] = % _encstr_8A4D22D883F5DC6CC996E0A3B232BE73A19BAFCACDC85ADCCEAFC4C9AC2C6C43FA38D89C;
  level.scr_animname["_encstr_85A10E06AA62F341405F98708F79590D"]["_encstr_A7CB0BD97D6968439D304B39C3"] = "_encstr_8A4D22D883F5DC6CC996E0A3B232BE73A19BAFCACDC85ADCCEAFC4C9AC2C6C43FA38D89C";
  level.scr_eventanim["_encstr_85A10E06AA62F341405F98708F79590D"]["_encstr_A7CB0BD97D6968439D304B39C3"] = "_encstr_81541117FE194F0517C96E03AFF18678AE660B";
  level.scr_animtree["_encstr_AC750A9A1BF529B128C6EFBB"] = #animtree;
  level.scr_model["_encstr_AC750A9A1BF529B128C6EFBB"] = "_encstr_B1BE11D5BB5A3AFFE092C9231DE1B07D710197";
  level.scr_anim["_encstr_AC750A9A1BF529B128C6EFBB"]["_encstr_A7CB0BD97D6968439D304B39C3"] = % _encstr_BAD521B1DBA76EC852A12151D5BF611452078EF9A2A3AB782FBF0D55FD267873573A6B;
  level.scr_animname["_encstr_AC750A9A1BF529B128C6EFBB"]["_encstr_A7CB0BD97D6968439D304B39C3"] = "_encstr_BAD521B1DBA76EC852A12151D5BF611452078EF9A2A3AB782FBF0D55FD267873573A6B";
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

swivel_dogtag_revive() {
  level.scr_animtree["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"] = #animtree;
  level.scr_anim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = % _encstr_8E4F21A38756776E55E0A3DBB841A9AEE3CC175D1099A77517390AC3108191EB80D6E1;
  level.scr_animname["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = "_encstr_8E4F21A38756776E55E0A3DBB841A9AEE3CC175D1099A77517390AC3108191EB80D6E1";
  level.scr_viewmodelanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = "_encstr_8E4F21A38756776E55E0A3DBB841A9AEE3CC175D1099A77517390AC3108191EB80D6E1";
  level.scr_eventanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = "_encstr_82520E8525533FC085FF48A718785D53";
  level.scr_anim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_ABF8090EB10BBCCA93F5C8"] = % _encstr_B84F21CAF350CFDE98C36854E310E9964D8381D258951F55D8477A5D9BD8A1539983CF;
  level.scr_animname["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_ABF8090EB10BBCCA93F5C8"] = "_encstr_B84F21CAF350CFDE98C36854E310E9964D8381D258951F55D8477A5D9BD8A1539983CF";
  level.scr_viewmodelanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = "_encstr_B84F21CAF350CFDE98C36854E310E9964D8381D258951F55D8477A5D9BD8A1539983CF";
  level.scr_eventanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_ABF8090EB10BBCCA93F5C8"] = "_encstr_96520EB2CD23AF35576BE0D7C11B2791";
  level.scr_anim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_A7F8098336C2E5AC4EEBCC"] = % _encstr_AC4F21EAD3702F3E78238874C330C9F62DA3A132B8B53F35F8679A7DFBB881B3B9E3FF;
  level.scr_animname["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_A7F8098336C2E5AC4EEBCC"] = "_encstr_AC4F21EAD3702F3E78238874C330C9F62DA3A132B8B53F35F8679A7DFBB881B3B9E3FF";
  level.scr_viewmodelanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = "_encstr_AC4F21EAD3702F3E78238874C330C9F62DA3A132B8B53F35F8679A7DFBB881B3B9E3FF";
  level.scr_eventanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_A7F8098336C2E5AC4EEBCC"] = "_encstr_87520E571D8D49D218ADBA499BE8F247";
  level.scr_anim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_91F80938B185CBB227FAD0"] = % _encstr_914F21A270577E96BAE7CBAB483307DFA15A989F604DC0402FA640A3D39398ABD1726C;
  level.scr_animname["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_91F80938B185CBB227FAD0"] = "_encstr_914F21A270577E96BAE7CBAB483307DFA15A989F604DC0402FA640A3D39398ABD1726C";
  level.scr_viewmodelanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = "_encstr_914F21A270577E96BAE7CBAB483307DFA15A989F604DC0402FA640A3D39398ABD1726C";
  level.scr_eventanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_91F80938B185CBB227FAD0"] = "_encstr_81520E75459B60F36DD76B57FF3BBB3A";
  level.scr_anim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_876A0D38B1B05EB2937D89D7CA37C8"] = % _encstr_997421B9F2477B777D5460732F98C76A95C7E1C980EDB952DFFF2B28C350D762636ABF;
  level.scr_animname["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_876A0D38B1B05EB2937D89D7CA37C8"] = "_encstr_997421B9F2477B777D5460732F98C76A95C7E1C980EDB952DFFF2B28C350D762636ABF";
  level.scr_viewmodelanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = "_encstr_997421B9F2477B777D5460732F98C76A95C7E1C980EDB952DFFF2B28C350D762636ABF";
  level.scr_eventanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_876A0D38B1B05EB2937D89D7CA37C8"] = "_encstr_A2A80EACE632BEAC1E2D1D7D838D3998";
  level.scr_anim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_83610DB1E342EB7012B12B9E27E6B0"] = % _encstr_9B7421BFD1801B4BB0300A13A9D8AF97CDA7C73F45B5E20E70DE4718C070E79B49858A;
  level.scr_animname["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_83610DB1E342EB7012B12B9E27E6B0"] = "_encstr_9B7421BFD1801B4BB0300A13A9D8AF97CDA7C73F45B5E20E70DE4718C070E79B49858A";
  level.scr_viewmodelanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = "_encstr_9B7421BFD1801B4BB0300A13A9D8AF97CDA7C73F45B5E20E70DE4718C070E79B49858A";
  level.scr_eventanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_83610DB1E342EB7012B12B9E27E6B0"] = "_encstr_A9A80E093DCC511D331F2977131ADE62";
  level.scr_anim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_BD310DC1C6B0CB2B27BECCBE95E632"] = % _encstr_837421D883BE9BC6E4D2E08EAC23AFCD86DC7D9537465A3776BEACF0D23AAF07C693CC;
  level.scr_animname["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_BD310DC1C6B0CB2B27BECCBE95E632"] = "_encstr_837421D883BE9BC6E4D2E08EAC23AFCD86DC7D9537465A3776BEACF0D23AAF07C693CC";
  level.scr_viewmodelanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = "_encstr_837421D883BE9BC6E4D2E08EAC23AFCD86DC7D9537465A3776BEACF0D23AAF07C693CC";
  level.scr_eventanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_BD310DC1C6B0CB2B27BECCBE95E632"] = "_encstr_BAA80ED9ED1C81CD032F7927636A8E5A";
  level.scr_anim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_8D4D0DC1B158975627FA1ABE599B32"] = % _encstr_8B7421592A67A08E63EFB1B1F72AD83AA45346115584B8306A4F8391DFD3AF48849AA3;
  level.scr_animname["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_8D4D0DC1B158975627FA1ABE599B32"] = "_encstr_8B7421592A67A08E63EFB1B1F72AD83AA45346115584B8306A4F8391DFD3AF48849AA3";
  level.scr_viewmodelanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_93F809831B852F954ED798"] = "_encstr_8B7421592A67A08E63EFB1B1F72AD83AA45346115584B8306A4F8391DFD3AF48849AA3";
  level.scr_eventanim["_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9"]["_encstr_8D4D0DC1B158975627FA1ABE599B32"] = "_encstr_B6A80E59CD32BE2B87B4D17D1C639C0D";
}

_id_123CE(var_0) {
  self.scenenode = getEnt("_encstr_81D01556B98C7D894EAC85D834FAB96CAC37CAE4BD192B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13844 = 1;
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.scenenode.origin);
  var_1.angles = self.scenenode.angles;
  var_1 setModel("_encstr_B1BE11D5BB5A3AFFE092C9231DE1B07D710197");
  var_2 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_0, "_encstr_85A10E06AA62F341405F98708F79590D", 1, 1);
  var_3 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_1, "_encstr_AC750A9A1BF529B128C6EFBB");

  if(istrue(var_0.isjuggernaut))
    var_4 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_2, var_3], "_encstr_A7CB0BD97D6968439D304B39C3", undefined, undefined, undefined, 0.5, undefined, 1);
  else
    var_4 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_2, var_3], "_encstr_A7CB0BD97D6968439D304B39C3", undefined, undefined, undefined, 0.5);

  scripts\engine\utility::ent_flag_set("_encstr_A3F10B09271F67380E3EA18B5C");
  level thread scripts\cp\cp_breach_c4::force_ai_to_drop_thermites(var_0);
  level thread scripts\cp\cp_breach_c4::c4_explode(self, var_1);
  thread scripts\engine\utility::delete_on_death(var_1);

  if(var_4)
    return;
}

check_for_trexremoval() {
  wait 0.5;
  wait 0.4;
  self playSound("_encstr_8AA8132693562CB1D0BE6C68FAC11B85DC1D7D0398");
  wait 0.4;
  self playSound("_encstr_84A8139388B14112F980EE33E8B19A09B820EF6222");
  wait 0.73;
  self playSound("_encstr_B2A8136ECDC38327916721C559F92C68A883F7D227");
  wait 1.2;
  self playSound("_encstr_81A8136A3EA987262909DAA72131DD3F60A5CFB075");
  wait 0.5;
  self playSound("_encstr_AAA813F8FBF2390931C76771C7185477662BC907C3");
}

_id_1240D() {
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  self disableweapons();
  self setadditionalstreampos(level.c130.origin, 1);
  self setOrigin(level.c130.origin, 1);
  self setplayerangles(level.c130.angles);
  level.c130 playsoundonmovingent("_encstr_B6961CCDC6E6F53683BE9B43B97D95E6CE96E695BE95878ED719F2D2CDB3");
  self playerlinkTo(level.c130);
  self.binc130 = undefined;
  self setclientomnvar("_encstr_A2AC0FAE96AFD02D19ACD7894BECB6B007", 0);
  waitframe();
  self playlocalsound("_encstr_ADF91F325E2D019BF3F9D6C2A2CE55BB85E37DA1B2737AB03E8087BF40A6184245");
  self playlocalsound("_encstr_920C23620E1D31ABC3290632521E658BD5932D91648D2AF569B0635BF9B059C2AD20B2D5D6");
  var_0 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9", 1, 1, 0);
  var_1 = "_encstr_93F809831B852F954ED798";
  waitframe();
  level.c130 notify("_encstr_952516A2BB02B885630331535BAFD76F5D573FCF8D7FB6B8");
  level.c130 scripts\cp_mp\anim_scene::anim_scene([var_0], var_1 + "_encstr_BD4305AF56CD91", 1, 1);
  self unlink();
  self skydive_beginfreefall();
  self enableweapons();
  self skydive_setbasejumpingstatus(1);
  self skydive_setdeploymentstatus(1);
  scripts\cp\cp_outofbounds::disableoobimmunity(self);
  thread parachute();
}

_id_123C2() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B", self);
  var_1 = level.scr_anim[var_0.streakname]["_encstr_A6D2100BB49CCD8E93A56D2B7D99C6974CE5"];
  var_2 = getanimlength(var_1);
  var_3 = 0;

  while(var_3 <= 4) {
    thread scripts\cp_mp\killstreaks\airstrike::finishairstrikeusage(level.c130.origin, level.c130.angles[1], undefined, var_0, var_1);
    thread _id_14315(var_3, var_2);
    var_3++;
    wait 1;
  }
}

_id_14315(var_0, var_1) {
  if(var_0 > 1) {
    return;
  }
  wait 6;
  level.c130 notify("_encstr_911C1051C2F3E26BF3F8B7123BE9A4F01053");
}

vehicle_remove_invulnerability_onenter() {
  self endon("_encstr_AD75063D571AE108");
  level.c130 endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.cameraent)) {
    var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self getEye());
    var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_0.angles = self.angles;
    self.cameraent = var_0;
    self playerlinkTo(self.cameraent);
  }

  for(;;) {
    var_1 = level.c130.origin;
    var_2 = vectorNormalize(var_1 - self getEye());
    var_3 = scripts\cp\utility::vectortoanglessafe(var_2, (0, 0, 1));
    self setplayerangles(var_3);
    waitframe();
  }
}

_id_13ADE() {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(scripts\engine\utility::array_contains(level.landed_players, var_0)) {
      continue;
    }
    thread playerhastrock(var_0);

    if(scripts\cp\cp_weapon::_id_124AD(var_0))
      scripts\cp\cp_weapon::minigamefinishcount(var_0);

    thread _id_123EA(var_0);
  }
}

playerhastrock(var_0) {
  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == var_0) {
    foreach(var_2 in level.players) {
      if(istrue(var_2.inlaststand))
        var_2 notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
    }
  }
}

_id_123EA(var_0) {
  if(isDefined(level._id_134E1))
    level._id_134E1 delete();

  if(!scripts\engine\utility::array_contains(level.landed_players, var_0))
    level.landed_players = scripts\engine\utility::array_add(level.landed_players, var_0);

  if(isDefined(level.nuclear_core_carrier)) {
    if(var_0 == level.nuclear_core_carrier) {
      level._id_11EDA = 1;

      foreach(var_2 in level.players) {
        if(istrue(var_2.binc130)) {
          scripts\cp_mp\entityheadicons::_id_1315E(level.nuclear_core_carrier.headicon, var_2);
          continue;
        }

        thread scripts\cp\respawn\cp_respawn::autofeeder(var_2, 4);
      }
    } else if(istrue(level._id_11EDA)) {
      if(isDefined(level.nuclear_core_carrier))
        thread scripts\cp\respawn\cp_respawn::autofeeder(var_0, 4);
    } else if(isDefined(level.nuclear_core_carrier))
      scripts\cp_mp\entityheadicons::_id_1315E(level.nuclear_core_carrier.headicon, var_0);
  }

  if(istrue(var_0.isjuggernaut)) {
    var_0.fly_to_end_point = 1;
    var_0 scripts\cp\cp_juggernaut::jugg_removejuggernaut();
  }

  var_0 vehiclepinonminimap(1);
  var_0 notify("_encstr_A66C19D67D32A3900783E0D0B345A8D3EA265D70D33A4D39E1FBC8");
  var_0 notify("_encstr_8A8211E8F86AF7AB451AF0A74191D60FE6AB12");
  var_0 disableweapons();

  if(var_0.class == "_encstr_8CFF09D56D88EC030D69EB" || var_0.class == "_encstr_A12707B8AB65E9A9C3")
    var_0.mousetraplocs = 1;

  scripts\cp\cp_outofbounds::enableoobimmunity(var_0);
  var_4 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_0, "_encstr_AA5E0FE0B9A16FDF6581127A638114FBD9", 1, 1, 0);
  var_0.vehicle_occupancy_mp_giveriotshield = getEnt("_encstr_81D01556B98C7D894EAC85D834FAB96CAC37CAE4BD192B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.vehicle_occupancy_mp_giveriotshield scripts\cp_mp\anim_scene::anim_scene([var_4], "_encstr_93F809831B852F954ED798", 1, 1);
  var_0 thread scripts\cp\respawn\cp_respawn::_id_12768(0, 1.2, 0.3, "_encstr_998806DD1A96D12B");
  var_0 thread _id_1240D();
  level notify("_encstr_B2A910AFF5CB851B8B67036D38F921D8A8F3");
}

_id_13811() {
  claxon_lights_on("_encstr_AB43131045D7889E597B730F6F22E811881D39E86F");
}

#using_animtree("_encstr_B40101");

claxon_light_init() {
  level.claxons = [];
  var_0 = getEntArray("_encstr_AB0310413551F080DA3F938FCB325981E70D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_2 useanimtree(#animtree);
    var_2.lights = [];
    var_3 = getEntArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_5 in var_3) {
      if(var_5.script_namenumber == "_encstr_8FA906CC80677438") {
        var_5 linkTo(var_2, "_encstr_BD160745191A5B246D");
        var_2.lights[var_2.lights.size] = var_5;
      }

      if(var_5.script_namenumber == "_encstr_AD080A8AD0DA50E4977068B1")
        var_2.model_off = var_5;
    }

    if(!isDefined(level.claxons[var_2.script_noteworthy])) {
      level.claxons[var_2.script_noteworthy] = spawnStruct();
      level.claxons[var_2.script_noteworthy].models_on = [];
    }

    var_7 = level.claxons[var_2.script_noteworthy].models_on;
    var_7[var_7.size] = var_2;
    level.claxons[var_2.script_noteworthy].models_on = var_7;
  }

  var_9 = getarraykeys(level.claxons);

  foreach(var_11 in var_9)
  level thread claxon_lights_off(var_11, 0);
}

claxon_lights_on(var_0) {
  foreach(var_2 in level.claxons[var_0].models_on) {
    var_2 show();
    var_2.model_off hide();

    if(isDefined(var_2.script_fxid))
      playFXOnTag(scripts\engine\utility::getfx(var_2.script_fxid), var_2, "_encstr_BD160745191A5B246D");

    foreach(var_4 in var_2.lights) {
      var_4 thread lerp_intensity(1, 1);
      var_4 setlightcolor((1, 0.085294, 0.03137));
    }

    var_2 scriptmodelplayanim("_encstr_87C111C6C685C3DE73D7CD83D2377DB1DBF60E");
    wait 0.3;
  }
}

claxon_lights_off(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_3 in level.claxons[var_0].models_on)
  var_3 thread claxon_stop_spin(var_1);
}

#using_animtree("_encstr_B40101");

claxon_stop_spin(var_0) {
  self clearanim(%_encstr_87C111C6C685C3DE73D7CD83D2377DB1DBF60E, 0.5);

  if(var_0)
    wait 0.5;

  foreach(var_2 in self.lights)
  var_2 thread lerp_intensity(0, 1);

  if(isDefined(self.script_fxid))
    killfxontag(scripts\engine\utility::getfx(self.script_fxid), self, "_encstr_BD160745191A5B246D");
}

lerp_intensity(var_0, var_1) {
  var_2 = int(var_1 * 20);
  var_3 = self getlightintensity();
  var_4 = (var_0 - var_3) / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    thread handle_linked_ents(var_0);
    self setlightintensity(var_3 + var_5 * var_4);
    wait 0.05;
  }

  var_6[0] = self;

  if(isDefined(self.linked_lights))
    var_6 = scripts\engine\utility::array_combine(var_6, self.linked_lights);

  foreach(var_8 in var_6) {
    var_8 thread handle_linked_ents(var_0);
    var_8 setlightintensity(var_0);
  }
}

handle_linked_ents(var_0) {
  if(isDefined(self.script_threshold)) {
    var_1 = var_0 > self.script_threshold;

    foreach(var_3 in self.lit_models) {
      if(var_1 && !var_3.visible) {
        var_3.visible = var_1;
        var_3 show();

        if(isDefined(var_3.effect))
          var_3.effect thread restarteffect();

        continue;
      }

      if(!var_1 && var_3.visible) {
        var_3.visible = var_1;
        var_3 hide();

        if(isDefined(var_3.effect))
          var_3.effect thread scripts\engine\utility::pauseeffect();
      }
    }

    foreach(var_3 in self.unlit_models) {
      if(!var_1 && !var_3.visible) {
        var_3.visible = 1;
        var_3 show();
        continue;
      }

      if(var_1 && var_3.visible) {
        var_3.visible = 0;
        var_3 hide();
      }
    }
  }
}

restarteffect() {
  scripts\common\createfx::restart_fx_looper();
}

heli_crash_path_loc_setup() {
  wait 2;
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
}

winindex() {
  level.flytime = [];
  var_0 = ["_encstr_B65918E0D3019093A115F0046F0B9F1B7A47F8F0B7CB2B53EAFA", "_encstr_848517DBC1A7F275F1A8256B417087CB866F2B073F5E4A2B68", "_encstr_8F8E0EB9041B69D7D1FD4FD05A0E0EFD"];

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_5 in var_3) {
      if(var_5.classname == "_encstr_A67E11DDA78B6AEF47B363B06E4901A8676530") {
        if(isDefined(var_5.target)) {
          var_5.spotlight = getEnt(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

          if(isDefined(var_5.spotlight)) {
            var_5.spotlight setlightintensity(25);
            var_5.spotlight linkTo(var_5);
          }
        }

        var_5 hide();
        var_5 linkTo(level.c130);
        level.flytime = scripts\engine\utility::array_add(level.flytime, var_5);
      }

      if((var_5.classname == "_encstr_87320B1AF06C43FB1117886FE1" || var_5.classname == "_encstr_8C1B0B53A80980AB4F40A59DBB") && var_5.targetname == var_2) {
        var_5.og_intensity = var_5 getlightintensity();
        var_5 setlightintensity(0);
        var_5.spotlight = getEnt(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(issubstr(var_5.target, "_encstr_8D38083FD3CB57C3B6A6"))
          var_5.spotlight = getEnt("_encstr_8D38083FD3CB57C3B6A6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        else if(issubstr(var_5.target, "_encstr_8B3808DE2B20EF5F6C01"))
          var_5.spotlight = getEnt("_encstr_8B3808DE2B20EF5F6C01", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(isDefined(var_5.spotlight)) {
          var_5.spotlight setlightintensity(25);
          var_5.spotlight linkTo(var_5);
        }

        level.flytime = scripts\engine\utility::array_add(level.flytime, var_5);
      }
    }
  }
}

_id_130A8(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_81111CAA18278A23A1B0E5275B48F3168768D1427039074F182DD713E790", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1.origin;
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0));
  var_4 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_6 in level.players)
  var_6 thread scripts\mp\vehicles\vehicle_damage_mp::_id_1340D(2, 1, 1);

  wait 2;

  foreach(var_6 in level.players) {
    var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
    var_9 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_9.angles = var_3;
    var_9 moveTo(var_4.origin, 20, 1, 1);
    var_6 allowfire(0);
    var_6 disableoffhandweapons();
    var_6 disableusability();
    var_6 allowmovement(0);
    var_6 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    var_6 spawn_endgame_camera(var_9);
    var_6 lerpfovscalefactor(0, 0);
  }
}

spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", "_encstr_82070322E1");
}