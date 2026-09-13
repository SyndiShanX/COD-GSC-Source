/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4aa198af4457349e.gsc
***********************************************/

main() {
  level.raid_seq3_objectives_func = ::register_sequence_3_objectives;
  level.skip_nav_check_on_spectate_respawn = 1;
  level thread _id_732B09C1B8599D25();
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  scripts\engine\utility::flag_init("seq3_poweron");
  scripts\engine\utility::flag_init("seq3_reset_once");
  scripts\engine\utility::flag_init("seq3_keypad_intel_activated");
  level init_warning_levels();
  scripts\cp\cp_remote_tank::init_remote_tank();
  thread _id_A623D3196178AA53();
  thread scripts\cp\cp_electricswitch::main();
  thread _id_72936E9D89227EAF::register_spawners();
  thread _id_6E2CD47141F9745B::_id_09766CDB112671D7("nums_drone_killtrigger");
  thread _id_78B690F869D12A6B();
  level thread _id_65DFAAE634DF359D();
  level.raid_objective_cleanup_func["s3_enter_numbers"] = ::seq3_cleanup_leftovers;
}

_id_732B09C1B8599D25() {
  level._id_82BD02B6A0D0F1E6 = level.prespawnfromspectatorfunc;
  level.prespawnfromspectatorfunc = ::_id_0F3E93AAFA206C62;
}

_id_0F3E93AAFA206C62(player) {
  player._id_57C207FDE9B78089 = 1;

  if(isDefined(level._id_82BD02B6A0D0F1E6))
    [[level._id_82BD02B6A0D0F1E6]](player);
}

_id_6FC3E3F99B7F30B2(player) {
  _id_1CD29382D1867470 = player _id_07C40FA80892A721::_id_0600F6CF462E983F();
  _id_A81ADEB0E1F89320 = player _id_07C40FA80892A721::_id_047320A25B8EE003();

  if(_id_1CD29382D1867470 < _id_A81ADEB0E1F89320)
    player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_A81ADEB0E1F89320 - _id_1CD29382D1867470);
}

load_sequence_3_vfx() {
  level._effect["vfx_javelin_expl"] = loadfx("vfx/core/expl/javelin_explosion.vfx");
}

_id_9C660C8EF32706C8() {
  load_sequence_3_vfx();
  level._effect["gas_cloud"] = loadfx("vfx/iw9/cp/raid/vfx_cp_raid_gas_cloud.vfx");
}

register_respawn_functions() {
  scripts\cp\coop_stealth::coop_stealth_init();
  level.getspawnpoint = ::getnumbersspawnpoint;
  level.force_respawn_location = ::getnumbersspawnpoint_late;
  level.enter_spectator_func = ::numbersroomdogtagrevive;
}

getnumbersspawnpoint() {
  if(isDefined(self.respawn_forcespawnorigin)) {
    _id_60F7CB484EC61F6C = spawnStruct();
    _id_60F7CB484EC61F6C.origin = self.respawn_forcespawnorigin;
    _id_60F7CB484EC61F6C.origin = getclosestpointonnavmesh(_id_60F7CB484EC61F6C.origin);
    _id_60F7CB484EC61F6C.angles = self.respawn_forcespawnangles;
    return _id_60F7CB484EC61F6C;
  }

  return _id_6425D54AF3CD5A44::getassignedspawnpoint(scripts\engine\utility::getStructArray("numbers_room_dogtags", "targetname"));
}

getnumbersspawnpoint_late(downed_player) {
  _id_60F7CB484EC61F6C = spawnStruct();
  _id_60F7CB484EC61F6C.origin = downed_player.respawn_forcespawnorigin;
  _id_60F7CB484EC61F6C.origin = getclosestpointonnavmesh(_id_60F7CB484EC61F6C.origin);
  _id_60F7CB484EC61F6C.angles = downed_player.respawn_forcespawnangles;
  return _id_60F7CB484EC61F6C;
}

numbersroomdogtagrevive(downed_player) {
  if(istrue(downed_player._id_74D989FDE24CE851))
    downed_player _id_F5EDED8E40C88A1B();

  downed_player thread scripts\stealth\player::combatstate_thread(0);
  level thread _id_0AFB7E332AEE4BF2::enable_dogtag_revive(downed_player);
}

_id_5EE15FF9CC6E092B() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");

  if(istrue(level._id_879B23A40EC61933)) {
    return;
  }
  level._id_879B23A40EC61933 = 1;

  if(istrue(level._id_C6081A8F8E88DC09) || istrue(level._id_E13D1DE65E306886)) {
    level thread _id_B6E0E3CEF865C8F7(0);
    return;
  }

  start_trigger = getEnt("trigger_numspuzzle_start", "targetname");

  for(;;) {
    start_trigger waittill("trigger", player);

    if(isPlayer(player)) {
      level thread _id_B6E0E3CEF865C8F7(0);
      break;
    }
  }

  wait 1;
  start_trigger delete();
}

_id_1B628CCB942DD4E5() {
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  trigger = getEnt("ai_watertrigger_nums", "targetname");
  enabled = getdvarint("dvar_42B49A4803A4ABCC", 1);

  if(!enabled) {
    return;
  }
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_CB527A1B28E21DFD", 1, 0);
  level thread _id_371B4C2AB5861E62::_id_0E942BEA168527F6(trigger);
}

register_sequence_3_objectives() {
  scripts\cp\cp_objectives::registerobjective("s3_enter_numbers", ::enter_numbers_init, ::enter_numbers_start, ::enter_numbers_end, scripts\cp\cp_objectives::debugbeatobjective, ::enter_numbers_debug_start);
}

_id_B6E0E3CEF865C8F7(_id_3675D567917DF505) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");

  if(istrue(level._id_209BA7DB51980D53)) {
    return;
  }
  level._id_209BA7DB51980D53 = 1;
  level thread _id_05826D0CB5E16A10();
  scripts\cp\cp_objectives::run_objective("s3_enter_numbers", "primary", "allies", 1);
  level thread _id_28ED994AF377B8B2();

  if(isDefined(level._id_3FD34375D8E0A2B5))
    level thread[[level._id_3FD34375D8E0A2B5]]();

  enter_numbers_init();

  if(istrue(_id_3675D567917DF505))
    enter_numbers_debug_start(_id_3675D567917DF505);
  else if(istrue(level._id_C6081A8F8E88DC09)) {} else if(istrue(level._id_E13D1DE65E306886))
    level thread _id_6DCC1A7B37CD64FE();
  else if(scripts\cp\cp_checkpoint::_id_9EED75023A958C18() != "checkpoint_nums_ready_intro") {
    scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_nums_ready_intro");
    level thread scripts\cp\utility::thread_teleportplayertoteamstructs_latejoin("allies", "numbers_debug_start_loc");
  }

  enter_numbers_start(undefined, undefined, _id_3675D567917DF505);
  enter_numbers_end();
}

_id_28ED994AF377B8B2() {
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
}

_id_05826D0CB5E16A10() {
  level thread scripts\cp\tripwire_cp::_id_7BDA4E577B34A556();
  level thread _id_71717E6C4597A196::_id_34E54622B902890B();
  level thread _id_1DB8D0E02A99C5E2::_id_D0E0B1A0DC489379();
  level thread _id_1E9BF201EA44567C::_id_57F2802F8F41E497();
}

enter_numbers_init(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level thread register_respawn_functions();
  level.suppress_spawn_vo = 1;
  level._id_9A478B5F4F67D5CD = 4;
  level._id_EAD88CE0CD1E577D = 1;
}

enter_numbers_start(objectivestruct, _id_5DCDFD3A4EFF9961, _id_3675D567917DF505) {
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");

  if(istrue(level._id_E13D1DE65E306886)) {
    if(istrue(_id_3675D567917DF505))
      level waittill("debug_start_button_pressed");

    return;
  }

  level thread _id_0DC44FA229B0BBE9();
  struct = scripts\engine\utility::getStruct("seq3_approachstruct", "targetname");
  dist = 1102500;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(struct.origin, dist)) {
      break;
    }

    wait 0.1;
  }

  level thread _id_669C0F6CB0B7F0CD::_id_865D6CF09798ED49(struct);
  wait 1;
}

enter_numbers_end(objectivestruct, _id_5DCDFD3A4EFF9961) {
  level thread _id_8EBAD89F8329A92E();
  level thread seq3_thermitetank_settings();
  level thread start_puzzle();
  level thread spawn_elevator_gate();
  level thread _id_1B628CCB942DD4E5();
  level thread scripts\cp\coop_stealth::_id_FE683C90EAD4E88B();
  level thread _id_CD24105424BFA41C();
  level notify("players_approaching_puzzle_entrance");
}

_id_6DCC1A7B37CD64FE() {
  wait 0.5;
  level thread _id_4BD54A20D801A3D4();
}

_id_4BD54A20D801A3D4() {
  level endon("game_ended");

  while(level.players.size == 0)
    wait 0.1;

  wait 0.1;

  foreach(player in level.players)
  _id_6FC3E3F99B7F30B2(player);
}

seq3_thermitetank_settings() {
  while(!isDefined(level.tanksettings))
    wait 0.1;

  level.seq3_tanksettings = level.tanksettings["remote_tank"];
  level.seq3_tanksettings.mgturretinfo = "pac_sentry_turret_cp_raid";
  level.seq3_tanksettings.turretoverridefunc = _id_72936E9D89227EAF::wheelson_fire_thermite;
  level.seq3_tanksettings.maxhealth = 450;
  level.seq3_tanksettings.mgturretmodelbase = "veh8_mil_lnd_whotel_turret_cp";
  level.seq3_tanksettings.turretlightsonstate = "on_red";
}

_id_78B690F869D12A6B() {
  level.astar_node_radius_override = 16;
  level._id_9DEF439B33EAC09D = 0;
  level._id_0AC33444DF3B5F6B = 4;
  level._id_E769257BA0EA53F7 = -4;
  level._id_2C85DB303881A3C8 = 2;
  level._id_3E81A9FCEDD1021D = 45;
  level._id_903F92904B8791E0 = 32;
}

enter_numbers_debug_start(_id_3675D567917DF505) {
  thread debug_start_numbers_threaded(_id_3675D567917DF505);
}

debug_start_numbers_threaded(_id_3675D567917DF505) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  level thread _id_A89155E0BDA5E866();

  if(istrue(_id_3675D567917DF505))
    level waittill("debug_start_button_pressed");

  _id_1E9BF201EA44567C::_id_5A52715BF68D9C6C();

  if(istrue(level._id_E13D1DE65E306886))
    level thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "numbers_checkpoint_debug_start_loc", 1);
  else
    level thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "numbers_debug_start_loc", 1);
}

_id_A89155E0BDA5E866() {
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  wait 0.5;
  start_struct = scripts\engine\utility::getStruct("nums_test_start", "script_noteworthy");
  startfunc = ::_id_905B6E0BDE024462;

  if(!isDefined(start_struct)) {
    return;
  }
  pos = scripts\engine\utility::getStruct("intro_ammo_crate", "targetname").origin;
  pos = scripts\engine\utility::drop_to_ground(pos, 100);
  level thread _id_18AF78602B67B70C::ammo_crate_spawn(pos, (0, 0, 0));
  _id_64A6D12971A22D83 = scripts\engine\utility::getStruct("intro_ks_sentry", "targetname").origin;
  level thread _id_C13975C405CE8CFC(_id_64A6D12971A22D83, (0, 0, 0), "sentry");
  level thread scripts\cp\utility::teleportallplayersinteamtostructs("allies", "numbersweps_debug_start_loc", 1);
  level thread _id_4BD54A20D801A3D4();
  hintstring = &"CP_RAID1_NUMSPUZZLE/ENTER_NUMBERS";

  if(istrue(level._id_922A06644812D5DE)) {
    hintstring = &"CP_RAID1_NUMSPUZZLE/WAITELEVATOR";
    level thread scripts\engine\utility::delaythread(3, scripts\cp\cp_hud_message::teamhudtutorialmessage, hintstring);
  } else if(istrue(level._id_E13D1DE65E306886)) {
    hintstring = &"CP_RAID1_NUMSPUZZLE/NEEDS_POWER";
    level thread scripts\engine\utility::delaythread(3, scripts\cp\cp_hud_message::teamhudtutorialmessage, hintstring);
  }

  button = _id_18AF78602B67B70C::script_model_spawn_and_use(start_struct.origin, start_struct.angles, startfunc, "button_on", hintstring);
  button setuseholdduration("duration_short");
}

_id_D4DDEC2480AF1209(weapon) {
  _id_04AB44FCB2DA757D = _id_18AF78602B67B70C::_id_848D98522B5E2243;
  _id_CBA40E031462D0A0 = level[[_id_04AB44FCB2DA757D]]("sm_beta_model_puzzle", "iw9_sm_mpapa7_mp+bar_sm_p09+ironsdefault_mpapa7+mag_sm_p09+pgrip_p09+rec_mpapa7+stock_sm_light_p09", "sm_beta_give_button_puzzle", &"CP_HARRIER_BOSS/TAKE_SMG_BETA", 1);
  button = _id_CBA40E031462D0A0._id_ACE531FE5DA6E1A5[0];
  weapon = _id_CBA40E031462D0A0._id_711D53C4B8AE7F3A[0];
  button setModel("tag_origin");
  button.origin = weapon.origin;
  button sethintdisplayrange(96);
  wait 0.1;
  _id_CBA40E031462D0A0 = level[[_id_04AB44FCB2DA757D]]("ar_charlie1_model_puzzle", "iw9_ar_akilo_mp+ammo_762s+bar_ar_long_p04+ironsdefault_akilo+mag_ar_p04+pgrip_p04+rec_akilo+selectsemi_akilo+stock_ar_p04", "ar_charlie1_give_button_puzzle", &"CP_HARRIER_BOSS/TAKE_AR_CHARLIE");
  button = _id_CBA40E031462D0A0._id_ACE531FE5DA6E1A5[0];
  weapon = _id_CBA40E031462D0A0._id_711D53C4B8AE7F3A[0];
  button setModel("tag_origin");
  button.origin = weapon.origin;
  button sethintdisplayrange(96);
}

_id_C13975C405CE8CFC(origin, angles, type, _id_F38C82C3A771999C) {
  if(!isDefined(type)) {
    return;
  }
  icon = undefined;

  if(type == "sentry") {
    if(!isDefined(_id_F38C82C3A771999C))
      _id_F38C82C3A771999C = 0;

    _id_B23E13281A551465 = origin + (0, 0, _id_F38C82C3A771999C);
    _id_CB04D051801DB715 = spawn("script_model", _id_B23E13281A551465);
    _id_CB04D051801DB715.angles = angles;
    _id_CB04D051801DB715 setModel("wpn_wm_p45_mg_auto_sentry_held_v0");
    _id_CB04D051801DB715.targetname = "ks_model_" + type;
    _id_9A257FA33F18D244 = spawn("script_model", origin);
    _id_9A257FA33F18D244.angles = angles;
    _id_9A257FA33F18D244 setModel("tag_origin");
    _id_9A257FA33F18D244.targetname = "ks_usable_" + type;
    _id_9A257FA33F18D244 endon("death");
    _id_9A257FA33F18D244 makeusable();
    _id_9A257FA33F18D244 setHintString(level.sentrysettings["sentry_turret"].ownerusehintstring);
    _id_9A257FA33F18D244 setCursorHint("HINT_BUTTON");
    _id_9A257FA33F18D244 sethintdisplayrange(150);
    _id_9A257FA33F18D244 sethintdisplayfov(70);
    _id_9A257FA33F18D244 setuserange(95);
    _id_9A257FA33F18D244 setusefov(50);
    _id_9A257FA33F18D244 sethintonobstruction("show");
    _id_9A257FA33F18D244 setuseholdduration("duration_medium");
    icon = _id_9A257FA33F18D244 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage("allies", "hud_icon_killstreak_sentry", 12, 1, 150);

    for(;;) {
      _id_9A257FA33F18D244 waittill("trigger", player);

      if(isDefined(player)) {
        if(!player scripts\cp\utility::is_valid_player()) {
          continue;
        }
        if(!scripts\cp\killstreaks\sentry_gun_cp::_id_42FD6416C3355566(player)) {
          continue;
        }
        player playlocalsound("grenade_pickup");

        if(isDefined(icon))
          scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);

        _id_CB04D051801DB715 delete();
        _id_9A257FA33F18D244 delete();
        return;
      }
    }
  }
}

_id_0DC44FA229B0BBE9() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  _id_64A6D12971A22D83 = scripts\engine\utility::getStruct("nums_armory_ks_sentry", "targetname");
  angles = _id_64A6D12971A22D83.angles + (0, 270, 0);

  if(!scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    if(isDefined(_id_64A6D12971A22D83))
      level thread _id_C13975C405CE8CFC(_id_64A6D12971A22D83.origin, angles, "sentry", -58.5);
  }
}

_id_905B6E0BDE024462(_id_B1AD25AD91B2627D, _id_6DFB045EE2B42AAD) {
  level notify("debug_start_button_pressed");
}

start_puzzle() {
  level endon("seq3_puzzle_complete");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid Transition: Water Maze - Nums");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Numbers-Puzzle: Intro");

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F();

  _id_1FDB885090FA3875::_id_3AA305CAB5BF65C5();
  level._id_A482AE70A62B5FB7.increase_sequence_tier = ::increase_sequence_tier;
  level._id_A482AE70A62B5FB7.puzzle_mark_complete = ::puzzle_mark_complete;
  level._id_A482AE70A62B5FB7._id_BD1B0809D148CE9C = ::_id_BD1B0809D148CE9C;
  level._id_A482AE70A62B5FB7._id_A3B356F2158A1EB3 = ::_id_A3B356F2158A1EB3;
  level._id_A482AE70A62B5FB7._id_37DE616924E20CB0 = ::_id_37DE616924E20CB0;
  level._id_39BC47CBD32AD77E._id_1EDCD0185B996C10 = 15;
  level._id_39BC47CBD32AD77E._id_0E7D8F530D432967 = 3;
  level thread spawn_atmines();
  level thread reset_button_handler();
  level thread wait_for_computer_power();
  center = scripts\engine\utility::getStruct("seq3_center", "targetname");
  level thread _id_1FDB885090FA3875::init_keypad_display_digits(center);
  _id_79AFE3DE97F7463A = scripts\engine\utility::getStruct("cypher_location", "targetname");
  level.seq3_cypher_tagorigin = scripts\engine\utility::spawn_tag_origin(_id_79AFE3DE97F7463A.origin, _id_79AFE3DE97F7463A.angles);
  level.seq3_cypher_tagorigin show();
  level thread _id_72936E9D89227EAF::spawn_enemies_intro();
  level thread ammo_cache_setup();
  level thread spawn_loot_pickups();
  level thread elevator_lights_toggle(0);
  level thread _id_997AD81DADDDA3A9();
  level thread _id_CED4D9E4B823CE0C();

  foreach(player in level.players)
  player _id_4D5D872A7BD5C0C3::_id_8FC85383E9F1B6E6();

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    scripts\cp\cp_gameskill::_id_3898E5F82C5C37DF(0);

  level thread _id_8AB3F2FEFB6B25DA();
  thread scripts\cp\utility::objective_update("s3_findpower");
  level thread _id_18AF78602B67B70C::_id_6AE8E5D7C480EF7D();
  _id_62DA2FDE40C98DAE = 0;

  if(getdvarint("dvar_DB60DF8EE2A2C313", 0) > 0) {
    _id_62DA2FDE40C98DAE = 1;
    wait 1;
    scripts\engine\utility::flag_set("seq3_poweron");
  }

  if(getdvarint("dvar_B83DAF6DB341BEBE", 0) == 1) {
    level.seq3_tier = 1;
    scripts\engine\utility::flag_wait("seq3_reset_once");
    level _id_1FDB885090FA3875::generate_cypher();
    scripts\engine\utility::flag_wait("seq3_poweron");
  } else {
    scripts\engine\utility::flag_wait("seq3_poweron");
    level thread wait_for_players_init_puzzle();
    scripts\engine\utility::flag_wait("seq3_reset_once");
    _id_EE35439A10245F9F = scripts\engine\utility::getStruct("seq3_interaction_computer", "targetname");
    level thread _id_1FDB885090FA3875::_id_A0B2561CEDE911A2(_id_EE35439A10245F9F.origin);
    level thread _id_1FDB885090FA3875::_id_CCCB426B669C407C(level.seq3_cypher_tagorigin.origin);
  }

  level thread _id_669C0F6CB0B7F0CD::_id_73F5EE271C35C4E8();
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Numbers-Puzzle: Intro");

  for(;;) {
    level thread play_reset_sequences();
    level waittill("seq3_reset_trigger");
  }
}

_id_8AB3F2FEFB6B25DA() {
  wait 2;
  level thread _id_1FDB885090FA3875::_id_66E614363F4AAB26();
}

wait_for_players_init_puzzle() {
  level endon("game_ended");
  _id_636C8575D7A7768B = 350;
  level thread players_approach_puzzle_monitor("cypher_location", _id_636C8575D7A7768B);
  level waittill("players_approaching_puzzle");
  level notify("players_approaching_puzzle_trigger");
  scripts\cp\cp_objectives::lua_objective_complete("s3_findpower");
  thread scripts\cp\utility::objective_update("s3_overall_goal");
  level thread _id_18AF78602B67B70C::_id_6AE8E5D7C480EF7D();
}

players_approach_puzzle_monitor(_id_CAB957ADC8D7710F, _id_76C663E82A2008DC) {
  level endon("game_ended");
  level endon("players_approaching_puzzle_trigger");
  struct = scripts\engine\utility::getStruct(_id_CAB957ADC8D7710F, "targetname");
  dist = _id_76C663E82A2008DC * _id_76C663E82A2008DC;

  while(!scripts\cp\utility::any_player_nearby(struct.origin, dist))
    wait 0.2;

  level notify("players_approaching_puzzle");
}

_id_997AD81DADDDA3A9() {
  struct = scripts\engine\utility::getStruct("cypher_location", "targetname");
  struct thread _id_18AF78602B67B70C::_id_26198B4BB49A3DF5(700);
}

_id_CED4D9E4B823CE0C() {
  _id_C9D8E37D473209B2 = scripts\engine\utility::getStructArray("seq3_computer", "targetname");

  foreach(_id_88A5B6AAD8A3BF4C in _id_C9D8E37D473209B2)
  _id_88A5B6AAD8A3BF4C thread _id_18AF78602B67B70C::_id_26198B4BB49A3DF5(700);
}

play_reset_sequences(_id_D37F60602F646BFB) {
  level endon("seq3_puzzle_complete");
  level notify("seq3_reset");
  level endon("seq3_reset");
  level endon("seq3_puzzle_lockdown");
  waitframe();

  if(!istrue(_id_D37F60602F646BFB))
    level thread _id_1FDB885090FA3875::code_generation_init(9);

  waitframe();

  if(!istrue(_id_D37F60602F646BFB))
    level.seq3_tier = 1;
  else
    level.seq3_tier = level.seq3_tier - 1;

  for(_id_AC0E594AC96AA3A8 = level.seq3_tier; _id_AC0E594AC96AA3A8 <= level._id_39BC47CBD32AD77E._id_0E7D8F530D432967; _id_AC0E594AC96AA3A8++) {
    _id_C3A462B4B661DCFC = level.seq3_tier;
    scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Numbers Sequence: " + _id_C3A462B4B661DCFC);

    while(level.seq3_tier == _id_C3A462B4B661DCFC) {
      level timer_sequence(level.seq3_tier);
      waitframe();
    }

    scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Numbers Sequence: " + _id_C3A462B4B661DCFC);
  }

  level.seq3_tier = 5;
  level notify("seq3_tier_increase");
  level thread _id_72936E9D89227EAF::_id_86BE9288A43C423C();
}

increase_sequence_tier(_id_DF071553D0996FF9) {
  level.seq3_tier++;

  switch (level.seq3_tier) {
    case 2:
      level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_finalpuzzle1";
      setmusicstate(level._id_7CAA8AB2F4145CFA);
      break;
    case 3:
      level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_finalpuzzle2";
      setmusicstate(level._id_7CAA8AB2F4145CFA);
      break;
    case 4:
      level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_defendnm";

      if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        level._id_7CAA8AB2F4145CFA = "mx_cp_raid1_defendhd";

      setmusicstate(level._id_7CAA8AB2F4145CFA);
      break;
  }

  level notify("seq3_tier_increase");
  level thread _id_1FDB885090FA3875::set_tier_lights(level.seq3_tier, _id_DF071553D0996FF9);
  level thread _id_72936E9D89227EAF::_id_86BE9288A43C423C();
}

_id_BD1B0809D148CE9C(_id_A5D1DF55FE16B5E1) {
  objective_timers_reset_both();
  level thread trigger_stop_bombticks();
  level thread defcon_alarms_stop();
  thread scripts\cp\utility::objective_update("s3_resetting", _id_A5D1DF55FE16B5E1, undefined, undefined, 1);
  _id_1FDB885090FA3875::_id_508A84E5FBB679A7();
}

_id_A3B356F2158A1EB3() {
  thread scripts\cp\utility::objective_update("s3_ready_to_reset");
  hintstring = &"CP_RAID1_NUMSPUZZLE/RESET_BUTTON";
  level.seq3_reset_switch setHintString(hintstring);
  level.seq3_reset_switch setuseholdduration("duration_short");
}

_id_37DE616924E20CB0() {}

timer_sequence(num) {
  level endon("exit_sequence_early");
  level endon("seq3_puzzle_complete");
  level endon("seq3_tier_increase");
  level endon("seq3_gofor_device");
  level._id_C7CE28D1FB1348C3 = 60;
  level._id_C7CE28D1FB1348C3 = _id_706AD8880B96289B(num);
  level.seq3_wave_delay = 0;

  if(is_first_time_high_tier(num)) {
    level.seq3_wave_delay = level.seq3_wave_delay + get_intermission_time(num);
    level._id_C7CE28D1FB1348C3 = level._id_C7CE28D1FB1348C3 + get_intermission_time(num);
  }

  objective_timers_reset_both();
  level thread play_sound_countdown();
  level thread _id_E8246BDB0E81A491();
  level childthread _id_05D1ED2D035E3E98(num);
  level thread _id_1FDB885090FA3875::spawn_new_digits(num, "f14_code_locations");
  level thread set_warning_levels();
  level thread _id_18AF78602B67B70C::_id_6AE8E5D7C480EF7D();
  wait(level._id_C7CE28D1FB1348C3);
  childthread _id_669C0F6CB0B7F0CD::_id_1DE187F9C5F686D2();
}

_id_05D1ED2D035E3E98(num) {
  level notify("objective_timers_set_safe");
  level endon("objective_timers_set_safe");
  level thread _id_715E1362682265EA();
  _id_7E280FDEB0981F77 = gettime();
  _id_6CDA8F01E0A3F355 = level._id_C7CE28D1FB1348C3;
  _id_FFF95C6F631401BF = 0;

  while(istrue(level._id_77F52E0CCB8547EB) || istrue(level._id_CA6BF37F89442C78)) {
    _id_FFF95C6F631401BF = 1;
    wait 0.5;
  }

  if(_id_FFF95C6F631401BF)
    wait 1;

  currenttime = gettime();

  if(currenttime > _id_7E280FDEB0981F77) {
    _id_3777ECE6A73EADA5 = currenttime - _id_7E280FDEB0981F77;
    _id_FBD43DA47D8CECDF = _id_3777ECE6A73EADA5 / 1000;
    _id_6CDA8F01E0A3F355 = _id_6CDA8F01E0A3F355 - _id_FBD43DA47D8CECDF;
  }

  _id_6CDA8F01E0A3F355 = int(_id_6CDA8F01E0A3F355);

  if(_id_6CDA8F01E0A3F355 <= 0) {
    return;
  }
  _id_BE6BE38915AC7A3C = int(_id_6CDA8F01E0A3F355 * 0.66);
  _id_77C9D992AD05C029 = int(_id_6CDA8F01E0A3F355 * 0.1);
  level thread scripts\cp\utility::objective_update("s3_numbers_display", _id_6CDA8F01E0A3F355, _id_BE6BE38915AC7A3C, _id_77C9D992AD05C029, 1, num);
}

_id_715E1362682265EA() {
  level endon("exit_sequence_early");
  level endon("seq3_puzzle_complete");
  level endon("seq3_tier_increase");
  level endon("seq3_gofor_device");
  level endon("game_ended");
  level notify("objective_timers_pause_on_dogtags");
  level endon("objective_timers_pause_on_dogtags");
  level waittill("hardModeWipeTimerActive");
  level notify("s3_numbers_display_update_instance");
}

objective_timers_reset_both() {
  level notify("s3_numbers_countdown_update_instance");
  level notify("s3_numbers_display_update_instance");

  if(!istrue(level._id_77F52E0CCB8547EB))
    setomnvar("cp_countdown_timer", 0);

  waitframe();
}

is_first_time_high_tier(num) {
  if(!isDefined(level.seq3_has_seen_tiers)) {
    level.seq3_has_seen_tiers = [];
    return 0;
  }

  if(scripts\engine\utility::array_contains(level.seq3_has_seen_tiers, num))
    return 0;

  level.seq3_has_seen_tiers[level.seq3_has_seen_tiers.size] = num;
  return 1;
}

get_intermission_time(num) {
  time = 0;

  switch (num) {
    case 1:
      time = 0;
      break;
    case 2:
      time = 0;
      break;
    case 3:
      time = 0;
      break;
  }

  return time;
}

_id_706AD8880B96289B(tier) {
  time = 60;

  switch (tier) {
    case 1:
      time = 60;
      break;
    case 2:
      time = 40;
      break;
    case 3:
      time = 25;
      break;
  }

  return time;
}

_id_F0924B014A7D6BCA(tier) {
  time = 10;

  switch (tier) {
    case 1:
      time = 0;
      break;
    case 2:
      time = 0;
      break;
    case 3:
      time = 0;
      break;
  }

  return time;
}

poweron_warnings() {
  scripts\engine\utility::flag_wait("cp_raid1_nums_puzzle_cs_completed");
  center = scripts\engine\utility::getStruct("seq3_center", "targetname");
  thread scripts\cp\utility::playsoundatpos_safe(center.origin, "emt_alarm_power_button");
  level thread _id_6D05E66323AFE5F9("a", undefined, center);
  level thread _id_6D05E66323AFE5F9("b", undefined, center);
}

init_warning_levels() {
  level.seq3_wave_delay = 0;
  level.seq3_warning_tier = 0;
  level.seq3_tier = 0;
  level.seq3_displaymodels = [];
  level.seq3_tvnums_str = "";
  level.seq3_warning_room_a = undefined;
  level.seq3_warning_room_b = undefined;
  level.seq3_warning_room_c = undefined;
  level.seq3_sequences = [];
  level.seq3_sequence[1] = [1, 1];
  level.seq3_sequence[2] = [3, 2];
  level.seq3_sequence[3] = [2, 1];
  level._id_414592408DF6A273 = [];
}

set_warning_levels() {
  waitframe();
  level request_warning_level(level.seq3_tier);
}

request_warning_level(wave_num) {
  _id_CA2608BC643DF9B0 = scripts\engine\utility::array_randomize(level.seq3_sequence[wave_num]);
  _id_CA2608BC643DF9B0 = scripts\engine\utility::array_randomize(level.seq3_sequence[wave_num]);

  if(!isDefined(level._id_63455D588EBADE59))
    level._id_63455D588EBADE59 = [];

  if(level._id_63455D588EBADE59.size == 2) {
    if(scripts\cp\utility::array_compare(level._id_63455D588EBADE59[0], _id_CA2608BC643DF9B0) && scripts\cp\utility::array_compare(level._id_63455D588EBADE59[1], _id_CA2608BC643DF9B0))
      _id_CA2608BC643DF9B0 = scripts\engine\utility::array_reverse(_id_CA2608BC643DF9B0);
  }

  level._id_63455D588EBADE59 = scripts\engine\utility::array_add(level._id_63455D588EBADE59, _id_CA2608BC643DF9B0);

  if(level._id_63455D588EBADE59.size > 2)
    level._id_63455D588EBADE59 = scripts\engine\utility::array_remove_index(level._id_63455D588EBADE59, 0);

  level.seq3_warning_room_a = _id_CA2608BC643DF9B0[0];
  level.seq3_warning_room_b = _id_CA2608BC643DF9B0[1];
  center = scripts\engine\utility::getStruct("seq3_center", "targetname");
  level thread _id_6D05E66323AFE5F9("a", level.seq3_warning_room_a, center);
  level thread _id_6D05E66323AFE5F9("b", level.seq3_warning_room_b, center);
}

colorise_warnings_clear(_id_3BBF7989DC6C1CE7) {
  foreach(model in _id_3BBF7989DC6C1CE7) {
    model setscriptablepartstate("root", "off");
    waitframe();
  }
}

_id_6D05E66323AFE5F9(id, _id_5E4805A7089F5E2F, _id_2CD6C893F875D032) {
  if(!isDefined(_id_2CD6C893F875D032)) {
    return;
  }
  _id_4A67207D6B3A5E32 = "seq3_defcon_" + id;
  _id_3BBF7989DC6C1CE7 = [];
  _id_0FC7E3F359CFB5BA = "seq3_defcon_a";

  if(id == "b")
    _id_0FC7E3F359CFB5BA = "seq3_defcon_c";
  else if(id == "c")
    _id_0FC7E3F359CFB5BA = "seq3_defcon_b";

  _id_E0F561E6FADA7B92 = getEntArray(_id_0FC7E3F359CFB5BA + "_left", "targetname");
  _id_AEFF64C6E00183D3 = getEntArray(_id_0FC7E3F359CFB5BA + "_right", "targetname");
  _id_3BBF7989DC6C1CE7[_id_3BBF7989DC6C1CE7.size] = scripts\engine\utility::getclosest(_id_2CD6C893F875D032.origin, _id_E0F561E6FADA7B92);
  _id_3BBF7989DC6C1CE7[_id_3BBF7989DC6C1CE7.size] = scripts\engine\utility::getclosest(_id_2CD6C893F875D032.origin, _id_AEFF64C6E00183D3);
  colorise_warnings_clear(_id_3BBF7989DC6C1CE7);

  if(!isDefined(_id_5E4805A7089F5E2F)) {
    return;
  }
  if(getdvarint("dvar_5D4E444732204CDC", 0) > 0) {
    announcement("^1 FORCE DIFFICULTY ENABLED");
    _id_5E4805A7089F5E2F = getdvarint("dvar_5D4E444732204CDC", 0);
  }

  switch (_id_5E4805A7089F5E2F) {
    case 1:
      _id_3BBF7989DC6C1CE7 thread colorise_toggle_onto("green");
      level thread _id_72936E9D89227EAF::delay_spawn_room_soldiers(id, "easy");
      level thread _id_72936E9D89227EAF::_id_D2C1401BEA9CD6A1(id);
      break;
    case 2:
      _id_3BBF7989DC6C1CE7 thread colorise_toggle_onto("yellow");
      level thread _id_72936E9D89227EAF::delay_spawn_room_soldiers(id, "med");
      break;
    case 3:
      _id_3BBF7989DC6C1CE7 thread colorise_toggle_onto("red");

      if(id == "a") {
        level thread _id_72936E9D89227EAF::delay_spawn_room_soldiers(id, "hard");
        level thread _id_8F84AEB1A7549AC5(id, level._id_C7CE28D1FB1348C3);
      } else
        level thread _id_72936E9D89227EAF::delay_spawn_room_soldiers(id, "hard", "red");

      break;
  }
}

colorise_toggle_onto(state) {
  foreach(model in self) {
    model setscriptablepartstate("root", state);
    waitframe();
  }
}

defcon_alarms_stop() {
  _id_3BBF7989DC6C1CE7 = [];
  _id_3BBF7989DC6C1CE7 = scripts\engine\utility::array_combine(_id_3BBF7989DC6C1CE7, getEntArray("seq3_defcon_a_left", "targetname"));
  _id_3BBF7989DC6C1CE7 = scripts\engine\utility::array_combine(_id_3BBF7989DC6C1CE7, getEntArray("seq3_defcon_a_right", "targetname"));
  _id_3BBF7989DC6C1CE7 = scripts\engine\utility::array_combine(_id_3BBF7989DC6C1CE7, getEntArray("seq3_defcon_b_left", "targetname"));
  _id_3BBF7989DC6C1CE7 = scripts\engine\utility::array_combine(_id_3BBF7989DC6C1CE7, getEntArray("seq3_defcon_b_right", "targetname"));
  _id_3BBF7989DC6C1CE7 = scripts\engine\utility::array_combine(_id_3BBF7989DC6C1CE7, getEntArray("seq3_defcon_c_left", "targetname"));
  _id_3BBF7989DC6C1CE7 = scripts\engine\utility::array_combine(_id_3BBF7989DC6C1CE7, getEntArray("seq3_defcon_c_right", "targetname"));

  foreach(model in _id_3BBF7989DC6C1CE7) {
    if(model isscriptable())
      model setscriptablepartstate("root", "off");
  }
}

defcon_models_cleanup() {
  _id_3BBF7989DC6C1CE7 = [];
  _id_3BBF7989DC6C1CE7[_id_3BBF7989DC6C1CE7.size] = getEnt("seq3_defcon_a_left", "targetname");
  _id_3BBF7989DC6C1CE7[_id_3BBF7989DC6C1CE7.size] = getEnt("seq3_defcon_a_right", "targetname");
  _id_3BBF7989DC6C1CE7[_id_3BBF7989DC6C1CE7.size] = getEnt("seq3_defcon_b_left", "targetname");
  _id_3BBF7989DC6C1CE7[_id_3BBF7989DC6C1CE7.size] = getEnt("seq3_defcon_b_right", "targetname");
  _id_3BBF7989DC6C1CE7[_id_3BBF7989DC6C1CE7.size] = getEnt("seq3_defcon_c_left", "targetname");
  _id_3BBF7989DC6C1CE7[_id_3BBF7989DC6C1CE7.size] = getEnt("seq3_defcon_c_right", "targetname");

  foreach(ent in _id_3BBF7989DC6C1CE7) {
    if(isent(ent))
      ent delete();
  }
}

keyboard_make_usable() {
  _id_1E0FD8DBAECF48E9 = spawn("script_model", self.origin);
  _id_1E0FD8DBAECF48E9.angles = self.origin;
  _id_1E0FD8DBAECF48E9 setModel("tag_origin");
  _id_1E0FD8DBAECF48E9.targetname = "seq3_keyboard";
  level.seq3_keyboards[level.seq3_keyboards.size] = _id_1E0FD8DBAECF48E9;
  _id_1E0FD8DBAECF48E9 endon("death");
  _id_1E0FD8DBAECF48E9 makeusable();
  hintstring = &"CP_RAID1_NUMSPUZZLE/COMPUTERUSE";
  _id_1E0FD8DBAECF48E9 setHintString(hintstring);
  _id_1E0FD8DBAECF48E9 setCursorHint("HINT_BUTTON");
  _id_1E0FD8DBAECF48E9 sethintdisplayrange(265);
  _id_1E0FD8DBAECF48E9 sethintdisplayfov(80);
  _id_1E0FD8DBAECF48E9 setuserange(95);
  _id_1E0FD8DBAECF48E9 setusefov(50);
  _id_1E0FD8DBAECF48E9 sethintonobstruction("show");
  _id_1E0FD8DBAECF48E9 setuseholdduration("duration_short");
  _id_1E0FD8DBAECF48E9 thread play_sparks_power();

  for(;;) {
    _id_1E0FD8DBAECF48E9 waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      _id_1E0FD8DBAECF48E9 _meth_DFB78B3E724AD620(0);
      _id_1FDB885090FA3875::_id_C990007D659769D7(player);
      _id_1E0FD8DBAECF48E9 _meth_DFB78B3E724AD620(1);
      level.seq3_computersused++;
      _id_1E0FD8DBAECF48E9 notify("computer_used");
      level thread turn_on_nearby_model_screen(_id_1E0FD8DBAECF48E9.origin);
      setomnvar("ui_raid_number_retries", 3);
      _id_1E0FD8DBAECF48E9 setuseholdduration("duration_none");
      hintstring = &"CP_RAID1_NUMSPUZZLE/NEEDS_POWER";
      _id_1E0FD8DBAECF48E9 setHintString(hintstring);
      return;
    }
  }
}

turn_on_nearby_model_screen(position) {
  _id_BCDC96B1B54390D7 = getEntArray("seq3_command_console_model", "targetname");

  if(!isDefined(_id_BCDC96B1B54390D7) || _id_BCDC96B1B54390D7.size == 0) {
    return;
  }
  _id_6867E3C434F34DE4 = scripts\engine\utility::getclosest(position, _id_BCDC96B1B54390D7);

  if(!isDefined(_id_6867E3C434F34DE4)) {
    return;
  }
  _id_E1ADB533235A6119 = "" + _id_6867E3C434F34DE4.model + "_on";
  _id_6867E3C434F34DE4 setModel(_id_E1ADB533235A6119);
  level thread scripts\cp\utility::playsoundatpos_safe(_id_6867E3C434F34DE4.origin, "emt_computer_enabled");
  wait 0.1;
  _id_6867E3C434F34DE4 thread scripts\engine\utility::play_loop_sound_on_entity("emt_computer_enabled_lp");
}

wait_for_computer_power() {
  if(istrue(level._id_922A06644812D5DE)) {
    thread scripts\cp\utility::objective_update("s3_overall_goal");
    wait 1.5;
    level thread wait_for_elevator(1);
    return;
  } else if(istrue(level._id_E13D1DE65E306886)) {
    wait 1.5;
    level _id_FED3013A5AA5FF2D();
    _id_AA5D8290994454A6 = scripts\engine\utility::getStructArray("seq3_computeron", "targetname");

    foreach(_id_8ED7EFDCDFC4F998 in _id_AA5D8290994454A6)
    level thread turn_on_nearby_model_screen(_id_8ED7EFDCDFC4F998.origin);

    return;
  }

  _id_C9D8E37D473209B2 = scripts\engine\utility::getStructArray("seq3_computer", "targetname");
  level.seq3_computersused = 0;
  level.seq3_keyboards = [];
  _id_AA5D8290994454A6 = scripts\engine\utility::getStructArray("seq3_computeron", "targetname");

  foreach(_id_8ED7EFDCDFC4F998 in _id_AA5D8290994454A6)
  _id_8ED7EFDCDFC4F998 thread keyboard_make_usable();

  _id_8AC702E20FAA1552 = 0;

  while(level.seq3_computersused < _id_AA5D8290994454A6.size) {
    if(_id_8AC702E20FAA1552 != level.seq3_computersused) {
      hintstring = &"CP_RAID1_NUMSPUZZLE/NEEDS_POWER_PROGRESS";
      level.seq3_reset_switch setHintString(hintstring);
      _id_8AC702E20FAA1552 = level.seq3_computersused;
    }

    wait 0.2;
  }

  if(scripts\cp\cp_checkpoint::_id_9EED75023A958C18() != "checkpoint_nums_ready_puzzle") {
    scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_nums_ready_puzzle");
    level thread scripts\cp\utility::thread_teleportplayertoteamstructs_latejoin("allies", "numbers_debug_start_loc");
  }

  level _id_FED3013A5AA5FF2D();

  foreach(_id_8ED7EFDCDFC4F998 in level.seq3_keyboards)
  _id_8ED7EFDCDFC4F998 makeunusable();

  if(getdvarint("dvar_B83DAF6DB341BEBE", 0) == 0) {
    foreach(computer in _id_C9D8E37D473209B2)
    level thread display_ready_for_sequence(computer.origin);
  }
}

_id_FED3013A5AA5FF2D() {
  hintstring = &"CP_RAID1_NUMSPUZZLE/NEEDS_POWER";
  level.seq3_reset_switch setHintString(hintstring);
  level thread poweron_warnings();
  scripts\engine\utility::flag_set("seq3_poweron");
  level notify("seq3_poweron");
  level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_NUMSPUZZLE/CONNECTION_ESTABLISHED");
}

gas_at_computer(id) {
  level endon("seq3_clear_gas");
  level endon("game_ended");
  level notify("seq3_end_gas_" + id);
  level endon("seq3_end_gas_" + id);
  level endon("seq3_puzzle_complete");
  level endon("seq3_tier_increase");
  _id_8B4BA669452DB241 = 3;
  maxdist = undefined;
  _id_C6A3A43FA767D8D2 = scripts\engine\utility::getStruct("seq3_computer_" + id, "script_noteworthy");

  switch (id) {
    case "a":
      maxdist = 1440000;
      break;
    case "b":
      maxdist = 1000000;
      break;
    case "c":
      maxdist = 1440000;
      break;
  }

  wait(5 - _id_8B4BA669452DB241 + level.seq3_wave_delay);
  nearbyplayer = _id_C6A3A43FA767D8D2 scripts\cp\utility::get_closest_living_player(maxdist);

  if(isDefined(nearbyplayer))
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(nearbyplayer, "incoming_gas");

  wait(_id_8B4BA669452DB241);

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.player.size; _id_AC0E594AC96AA3A8++) {
      player = level.players[_id_AC0E594AC96AA3A8];

      if(_id_DD981F080D5F7317(player, _id_C6A3A43FA767D8D2, maxdist)) {
        player scripts\cp_mp\utility\shellshock_utility::_shellshock("gas_grenade_heavy_mp", "gas", 0.5, 0);

        if(!istrue(player.was_seq3_gassed)) {
          player scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
          player.was_seq3_gassed = 1;
          player visionsetnakedforplayer("wp_flare", 1);
          level thread set_slow_healthregen(player);
          level thread player_gassed_effects(player);
        }

        continue;
      }

      if(istrue(player.was_seq3_gassed)) {
        level thread unset_slow_healthregen(player);
        player.was_seq3_gassed = undefined;
        player scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();

        if(player scripts\cp_mp\utility\player_utility::_isalive())
          player visionsetnakedforplayer("", 2);
      }
    }

    wait 1;
  }
}

_id_DD981F080D5F7317(player, _id_C6A3A43FA767D8D2, maxdist) {
  _id_D43D6364668556C7 = distance2dsquared(player.origin, _id_C6A3A43FA767D8D2.origin) < maxdist;
  hasgasmask = istrue(player.gasmaskequipped);

  if(hasgasmask)
    return 0;

  if(_id_D43D6364668556C7 && player _meth_6F55D55CCFF20D14())
    return 0;

  if(_id_D43D6364668556C7)
    return 1;

  return 0;
}

player_gassed_effects(player) {
  player notify("record_gas_effects");
  player endon("record_gas_effects");
  player endon("death_or_disconnect");
  level waittill("seq3_clear_gas");

  if(istrue(player.was_seq3_gassed)) {
    level thread unset_slow_healthregen(player);
    player.was_seq3_gassed = undefined;
    player scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();

    if(player scripts\cp_mp\utility\player_utility::_isalive())
      player visionsetnakedforplayer("", 2);
  }
}

set_slow_healthregen(player) {
  while(!isDefined(player.gs))
    waitframe();

  player.og_health_regen_delay = player.gs.healthregendelay;
  player.og_health_regen_rate = player.gs.healthregenrate;
  player.gs.healthregendelay = 5;
  player.gs.healthregenrate = 20;
}

unset_slow_healthregen(player) {
  player.gs.healthregendelay = player.og_health_regen_delay;
  player.gs.healthregenrate = player.og_health_regen_rate;
}

ammo_cache_setup() {
  if(getdvarint("dvar_B83DAF6DB341BEBE", 0) == 1) {
    return;
  }
  models = getEntArray("seq3_ammo_restock", "targetname");

  foreach(model in models) {
    model setscriptablepartstate("military_ammo_restock", "USEABLE_OFF");
    _id_835CDAF68B8624E1 = spawn("script_model", model.origin + (0, 0, 32));
    _id_835CDAF68B8624E1.angles = model.angles;
    _id_835CDAF68B8624E1 setModel("tag_origin");
    _id_835CDAF68B8624E1.targetname = "seq3_cache";
    _id_835CDAF68B8624E1 makeusable();
    type = "default";

    if(isDefined(model.script_noteworthy) && model.script_noteworthy == "no_armor")
      type = "no_armor";

    hintstring = &"MP_INGAME_ONLY/REFILL_AMMO_EQUIPMENT_ARMOR";

    if(type == "no_armor")
      hintstring = &"MP_INGAME_ONLY/REFILL_AMMO";

    _id_835CDAF68B8624E1 setHintString(hintstring);
    _id_835CDAF68B8624E1 setCursorHint("HINT_BUTTON");
    _id_835CDAF68B8624E1 sethintdisplayrange(270);
    _id_835CDAF68B8624E1 sethintdisplayfov(140);
    _id_835CDAF68B8624E1 setuserange(105);
    _id_835CDAF68B8624E1 setusefov(65);
    _id_835CDAF68B8624E1 sethintonobstruction("show");
    _id_835CDAF68B8624E1 setuseholdduration("duration_short");
    _id_835CDAF68B8624E1 sethinticon("hud_icon_fieldupgrade_ammo_box");
    _id_835CDAF68B8624E1 thread ammo_cache_think(type);
    _id_835CDAF68B8624E1.badplace = createnavbadplacebyent(_id_835CDAF68B8624E1, "axis");

    if(!isDefined(level._id_A3EA2A1E0BBA66B7))
      level._id_A3EA2A1E0BBA66B7 = [];

    level._id_A3EA2A1E0BBA66B7[level._id_A3EA2A1E0BBA66B7.size] = _id_835CDAF68B8624E1;
  }
}

ammo_cache_think(type) {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      thread ammo_cache_used(player, type);
    }
  }
}

ammo_cache_used(player, type) {
  if(type != "no_armor") {
    _id_1CD29382D1867470 = player _id_07C40FA80892A721::_id_0600F6CF462E983F();
    _id_FDD4FDD3217010F0 = 8;

    if(_id_1CD29382D1867470 < _id_FDD4FDD3217010F0)
      player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_FDD4FDD3217010F0 - _id_1CD29382D1867470);
  }

  _id_BC002676438672C9 = player _id_7EF95BBA57DC4B82::getcurrentequipment("primary");
  _id_2AEE5A9B1A165F09 = player _id_7EF95BBA57DC4B82::getcurrentequipment("secondary");
  player thread _id_7EF95BBA57DC4B82::setequipmentammo(_id_BC002676438672C9, 4);
  player thread _id_7EF95BBA57DC4B82::setequipmentammo(_id_2AEE5A9B1A165F09, 4);
  success = player scripts\cp\cp_ammo_crate::supportbox_onusedeployable();

  if(istrue(success)) {
    player playlocalsound("weap_ammo_pickup");
    player thread _id_354C862768CFE202::hudicontype("ammobox");
    player thread _id_66122A002AFF5D57::_id_EE5540242EF172D4();
  }
}

ammo_cache_delete() {
  models = getEntArray("seq3_ammo_restock", "targetname");

  foreach(model in models) {
    if(isent(model))
      model delete();
  }

  foreach(usable in level._id_A3EA2A1E0BBA66B7) {
    if(isDefined(usable) && isent(usable)) {
      if(isDefined(usable.badplace))
        destroynavobstacle(usable.badplace);

      usable delete();
    }
  }
}

reset_button_handler() {
  _id_1E4C761B386C2D1B = scripts\engine\utility::getStruct("seq3_resetbutton", "targetname");
  level.seq3_reset_switch = spawn("script_model", _id_1E4C761B386C2D1B.origin);
  level.seq3_reset_switch setModel("tag_origin");
  level.seq3_reset_switch.targetname = "seq3_resetbutton";
  waitframe();
  level.seq3_reset_switch makeusable();
  level thread reset_button_init(level.seq3_reset_switch);

  if(getdvarint("dvar_B83DAF6DB341BEBE", 0) == 1)
    wait 1;
  else
    scripts\engine\utility::flag_wait("seq3_poweron");

  hintstring = &"CP_RAID1_NUMSPUZZLE/RESET_BUTTON";
  level.seq3_reset_switch setHintString(hintstring);
  level.seq3_reset_switch setCursorHint("HINT_BUTTON");
  level.seq3_reset_switch sethintdisplayrange(265);
  level.seq3_reset_switch sethintdisplayfov(140);
  level.seq3_reset_switch setuserange(65);
  level.seq3_reset_switch setusefov(35);
  level.seq3_reset_switch sethintonobstruction("show");
  level.seq3_reset_switch setuseholdduration("duration_short");
  level.seq3_reset_switch sethinticon("icon_electrical_box");
  level.seq3_reset_switch thread reset_use_think();
}

reset_button_init(_id_BA9FC18C0856DDE5) {
  _id_BA9FC18C0856DDE5 makeusable();
  hintstring = &"CP_RAID1_NUMSPUZZLE/NEEDS_POWER";
  _id_BA9FC18C0856DDE5 setHintString(hintstring);
  _id_BA9FC18C0856DDE5 setCursorHint("HINT_BUTTON");
  _id_BA9FC18C0856DDE5 sethintdisplayrange(165);
  _id_BA9FC18C0856DDE5 sethintdisplayfov(140);
  _id_BA9FC18C0856DDE5 setuserange(65);
  _id_BA9FC18C0856DDE5 setusefov(50);
  _id_BA9FC18C0856DDE5 sethintonobstruction("show");
  _id_BA9FC18C0856DDE5 setuseholdduration("duration_none");
}

reset_use_think() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      level thread reset_use_trigger(self, player);
    }
  }
}

reset_use_trigger(model, player) {
  level endon("game_ended");
  level endon("seq3_puzzle_lockdown");
  model _meth_DFB78B3E724AD620(0);
  _id_1FDB885090FA3875::_id_B0CE90035E6B64D0(player);
  level notify("radio_power_on");
  level notify("computer_power_on");
  scripts\engine\utility::flag_set("seq3_reset_once");
  level thread reset_use_puzzle_effects();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, "obj_device_set");
  level thread _id_03DAF8A4D8E82EAD::_id_21928006927D8163();
}

reset_use_puzzle_effects() {
  level notify("seq3_reset_trigger");
  enable_keypad_interaction();
  _id_1FDB885090FA3875::clear_keypad_currentdisplay_models();

  if(!isDefined(level.seq3_wheelson_starts))
    level.seq3_wheelson_starts = [];

  setomnvar("ui_raid_number_retries", 3);
  level.seq3_puzzle_attempts = undefined;
  level notify("end_wave_seq3_spawners");
  level thread _id_1FDB885090FA3875::clear_cypher_icon();
  center = scripts\engine\utility::getStruct("seq3_center", "targetname");
  level thread _id_6D05E66323AFE5F9("a", undefined, center);
  level thread _id_6D05E66323AFE5F9("b", undefined, center);
}

remove_old_wheelsons() {
  if(!isDefined(level.assaultdrones)) {
    return;
  }
  foreach(tank in level.assaultdrones) {
    if(isent(tank))
      tank notify("death");
  }
}

display_ready_for_sequence(origin) {
  level endon("game_ended");
  level endon("seq3_reset_trigger");
  dist = 40000;
  wait 2;

  for(;;) {
    _id_78122E18403A8DC4 = scripts\cp\utility::give_all_players_nearby(origin, dist);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_78122E18403A8DC4.size; _id_AC0E594AC96AA3A8++)
      _id_78122E18403A8DC4[_id_AC0E594AC96AA3A8] thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID1_NUMSPUZZLE/READY_FOR_SEQ", 1.5);

    wait 2;
  }
}

reload_currentsequence_button_handler() {
  _id_72B56C6C2F455BAF = scripts\engine\utility::getStruct("seq3_reloadbutton", "targetname");
  _id_82AB5773763542D1 = spawn("script_model", _id_72B56C6C2F455BAF.origin);
  _id_82AB5773763542D1 setModel("tag_origin");
  _id_82AB5773763542D1.targetname = "seq3_reloadbutton";
  waitframe();
  scripts\engine\utility::flag_wait("seq3_reset_once");
  _id_82AB5773763542D1 makeusable();
  hintstring = &"CP_RAID1_NUMSPUZZLE/RELOADSEQ1";
  _id_82AB5773763542D1 setHintString(hintstring);
  _id_82AB5773763542D1 setCursorHint("HINT_BUTTON");
  _id_82AB5773763542D1 sethintdisplayrange(165);
  _id_82AB5773763542D1 sethintdisplayfov(140);
  _id_82AB5773763542D1 setuserange(65);
  _id_82AB5773763542D1 setusefov(35);
  _id_82AB5773763542D1 sethintonobstruction("show");
  _id_82AB5773763542D1 setuseholdduration("duration_short");
  level thread reload_handle_hintstring(_id_82AB5773763542D1);
  _id_82AB5773763542D1 thread reload_use_think();
}

reload_handle_hintstring(_id_82AB5773763542D1) {
  level endon("game_ended");
  level endon("seq3_puzzle_complete");

  for(;;) {
    waitframe();
    hintstring = undefined;

    switch (level.seq3_tier) {
      case 2:
        hintstring = &"CP_RAID1_NUMSPUZZLE/RELOADSEQ1";
        break;
      case 3:
        hintstring = &"CP_RAID1_NUMSPUZZLE/RELOADSEQ2";
        break;
      case 4:
        hintstring = &"CP_RAID1_NUMSPUZZLE/RELOADSEQ3";
        break;
      case 5:
        hintstring = &"CP_RAID1_NUMSPUZZLE/RELOADSEQ4";
        break;
    }

    if(isDefined(hintstring) && (isDefined(level.seq3_puzzle_attempts) && level.seq3_puzzle_attempts < 2 || !isDefined(level.seq3_puzzle_attempts))) {
      _id_82AB5773763542D1 setHintString(hintstring);
      _id_82AB5773763542D1 setuseholdduration("duration_short");
      _id_82AB5773763542D1.switch_disabled = 0;
    } else {
      _id_82AB5773763542D1 setHintString(&"CP_RAID1_NUMSPUZZLE/RELOADDISABLE");
      _id_82AB5773763542D1 setuseholdduration("duration_none");
      _id_82AB5773763542D1.switch_disabled = 1;
    }

    level scripts\engine\utility::waittill_any_3("seq3_reset", "seq3_fail_input", "seq3_tier_increase");
  }
}

reload_use_think() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(istrue(self.switch_disabled)) {
        continue;
      }
      level thread reload_use_trigger(self, player);
    }
  }
}

reload_use_trigger(model, player) {
  model makeunusable();
  level thread play_reset_sequences(1);
  level _id_1FDB885090FA3875::keypad_increase_failnum();
  _id_1FDB885090FA3875::clear_keypad_currentdisplay_models();
  _id_1FDB885090FA3875::clear_three_room_screens();
  wait 1;
  model makeusable();
}

spawn_atmines() {
  spawners = getEntArray("seq3_atmine", "targetname");

  foreach(model in spawners) {
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdropinfo(model.origin, model.angles);
    item = _id_66122A002AFF5D57::spawnpickup("brloot_offhand_atmine", _id_CB4FAD49263E20C4, 1, undefined, undefined, 0);
    model delete();
    wait 0.1;
  }

  level thread _id_9F3F1AAEA93837F5();
}

_id_9F3F1AAEA93837F5() {
  _id_28A6B68460F4FD6B = scripts\engine\utility::getStruct("start_weapon_nums", "targetname");
  _id_CDE2F078F52F09C5 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo");
  _id_CDE2F078F52F09C5 = _id_CDE2F078F52F09C5 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["bar_ar_light", "stock_ar_light", "reddot"]);
  _id_28A6B68460F4FD6B _id_03DAF8A4D8E82EAD::_id_9655BF427A5ABDB8(undefined, _id_CDE2F078F52F09C5);
}

allow_pickup_atmine() {
  self endon("death");

  if(getdvarint("dvar_B83DAF6DB341BEBE", 0) == 1) {
    return;
  }
  self makeusable();
  hintstring = &"CP_RAID1_NUMSPUZZLE/ATMINE";
  self setHintString(hintstring);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(265);
  self sethintdisplayfov(80);
  self setuserange(95);
  self setusefov(35);
  self sethintonobstruction("show");
  self setuseholdduration("duration_short");
  _id_A77FD39990CB4198 = "equip_at_mine";

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(player)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      ammo = 0;

      if(player _id_7EF95BBA57DC4B82::hasequipment(_id_A77FD39990CB4198)) {
        maxammo = 2;
        ammo = player _id_7EF95BBA57DC4B82::getequipmentslotammo("primary");

        if(ammo >= maxammo)
          continue;
      }

      player playlocalsound("grenade_pickup");

      if(ammo > 0)
        player thread _id_7EF95BBA57DC4B82::setequipmentammo(_id_A77FD39990CB4198, ammo + 1);
      else
        player thread _id_7EF95BBA57DC4B82::giveequipment(_id_A77FD39990CB4198, "primary");

      self delete();
    }
  }
}

atmines_delete() {
  spawners = getEntArray("seq3_atmine", "targetname");

  foreach(mine in spawners) {
    if(isent(mine))
      mine delete();
  }
}

enable_keypad_interaction() {
  if(istrue(level.seq3_keypad_init)) {
    return;
  }
  level.seq3_keypad_init = 1;
  _id_88A5B6AAD8A3BF4C = scripts\engine\utility::getStruct("seq3_interaction_computer", "targetname");
  level thread _id_1FDB885090FA3875::computer_listener_all(_id_88A5B6AAD8A3BF4C);
  level thread keyboard_monitor_disable(level.seq3_computer_interaction);
  level thread _id_83B7D034B44A4B3D();
}

_id_83B7D034B44A4B3D() {
  _id_88A5B6AAD8A3BF4C = scripts\engine\utility::getStruct("seq3_interaction_computer", "targetname");
  level thread _id_6E2CD47141F9745B::_id_1EF2364D60A8AF83(_id_88A5B6AAD8A3BF4C);
}

keyboard_monitor_disable(_id_287CC7482806C9F7) {
  level waittill("seq3_puzzle_complete");
  _id_1FDB885090FA3875::computer_force_player_to_exit();
  _id_287CC7482806C9F7.disable_playeruse = 1;
  _id_287CC7482806C9F7 makeunusable();
}

_id_543F86F6A4594160() {
  objective_timers_reset_both();
  scripts\cp\cp_objectives::reset_objective_timers();
  center = scripts\engine\utility::getStruct("seq3_center", "targetname");
  thread scripts\cp\utility::playsoundatpos_safe(center.origin, "emt_alarm_power_button");

  if(isDefined(level.seq3_reset_switch) && isent(level.seq3_reset_switch))
    level.seq3_reset_switch makeunusable();

  level notify("seq3_gofor_device");
  level notify("s3_numbers_countdown_completed");
  level thread scripts\engine\utility::delaythread(3, ::wait_for_elevator);
}

spawn_elevator_gate() {
  if(isDefined(level._id_3D247A2128AC423B)) {
    return;
  }
  _id_A3C2CEDEFEF30464 = undefined;
  _id_64084650276504B1 = undefined;

  while(!isDefined(_id_A3C2CEDEFEF30464)) {
    _id_A3C2CEDEFEF30464 = getEnt("seq3_elevatordoor_left", "targetname");
    _id_64084650276504B1 = getEnt("seq3_elevatordoor_right", "targetname");
    wait 1;
  }

  _id_E5D875E471CB6D53 = getEnt("nums_ending_gate_left", "targetname");
  _id_9EA5E5682363D55C = getEnt("nums_ending_gate_right", "targetname");

  if(!isDefined(_id_E5D875E471CB6D53)) {
    announcement("No gate collision numspuzzle. RECOMPILE MAP.");
    return;
  }

  _id_E5D875E471CB6D53 disconnectPaths();
  _id_9EA5E5682363D55C disconnectPaths();
  level._id_3D247A2128AC423B = _id_E5D875E471CB6D53;
  level._id_C2C4F5BF44CF0984 = _id_9EA5E5682363D55C;
  _id_4C1B43D62505FB0A = getEnt("seq3_elevatordoor_left_2", "targetname");
  _id_BF29B0B0589B1A77 = getEnt("seq3_elevatordoor_right_2", "targetname");
  level._id_3D247A2128AC423B linkTo(_id_4C1B43D62505FB0A);
  level._id_C2C4F5BF44CF0984 linkTo(_id_BF29B0B0589B1A77);
}

puzzle_mark_complete() {
  level notify("seq3_puzzle_complete");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Numbers Sequence: " + level.seq3_tier);
  level.seq3_puzzle_complete = 1;
  level thread trigger_stop_bombticks();
  level thread _id_1FDB885090FA3875::clear_cypher_icon();
  level thread defcon_alarms_stop();
  level thread _id_543F86F6A4594160();
  level thread scripts\cp\utility::playsoundatpos_safe(level.seq3_computer_interaction.origin, "dx_cp_cpr1_intr_cmpv_authenticationconfir_01");
}

spawn_loot_pickups() {
  wait 1;

  if(getdvarint("dvar_1353EB52222528A0")) {
    _id_E86D48DDDC4F4E3D = scripts\engine\utility::getStructArray("seq3_loot_room_a", "targetname");
    _id_E86D48DDDC4F4E3D = scripts\engine\utility::array_randomize(_id_E86D48DDDC4F4E3D);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++)
      level thread scripts\cp\utility::create_fake_loot_model_from_struct(_id_E86D48DDDC4F4E3D[_id_AC0E594AC96AA3A8]);

    _id_E86D45DDDC4F47A4 = scripts\engine\utility::getStructArray("seq3_loot_room_b", "targetname");
    _id_E86D45DDDC4F47A4 = scripts\engine\utility::array_randomize(_id_E86D45DDDC4F47A4);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++)
      level thread scripts\cp\utility::create_fake_loot_model_from_struct(_id_E86D45DDDC4F47A4[_id_AC0E594AC96AA3A8]);

    _id_E86D46DDDC4F49D7 = scripts\engine\utility::getStructArray("seq3_loot_room_c", "targetname");
    _id_E86D46DDDC4F49D7 = scripts\engine\utility::array_randomize(_id_E86D46DDDC4F49D7);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++)
      level thread scripts\cp\utility::create_fake_loot_model_from_struct(_id_E86D46DDDC4F49D7[_id_AC0E594AC96AA3A8]);

    wait 1;
    _id_7BC24930907ACD4D = ["brloot_munition_grenade_crate", "brloot_munition_armor", "brloot_munition_deployable_cover"];
    _id_EC56966114DCFD91 = getEntArray("seq3_loot_room_a", "targetname");
    level thread mix_loot_pickups(_id_EC56966114DCFD91, _id_7BC24930907ACD4D);
    _id_EC56936114DCF6F8 = getEntArray("seq3_loot_room_b", "targetname");
    level thread mix_loot_pickups(_id_EC56936114DCF6F8, _id_7BC24930907ACD4D);
    _id_EC56946114DCF92B = getEntArray("seq3_loot_room_c", "targetname");
    level thread mix_loot_pickups(_id_EC56946114DCF92B, _id_7BC24930907ACD4D);
  } else {
    _id_EC56966114DCFD91 = getEntArray("seq3_loot_room_a", "targetname");

    foreach(model in _id_EC56966114DCFD91) {
      if(isent(model))
        model delete();
    }

    _id_EC56936114DCF6F8 = getEntArray("seq3_loot_room_b", "targetname");

    foreach(model in _id_EC56936114DCF6F8) {
      if(isent(model))
        model delete();
    }

    _id_EC56946114DCF92B = getEntArray("seq3_loot_room_c", "targetname");

    foreach(model in _id_EC56946114DCF92B) {
      if(isent(model))
        model delete();
    }
  }
}

mix_loot_pickups(_id_F8953FA9BCF991B3, _id_7BC24930907ACD4D) {
  _id_ED195A8E452E6F00 = _id_F8953FA9BCF991B3[0];
  _id_ED195A8E452E6F00 thread scripts\cp\utility::create_fake_loot(_id_7BC24930907ACD4D[0]);
  _id_ED195D8E452E7599 = _id_F8953FA9BCF991B3[1];
  _id_ED195D8E452E7599 thread scripts\cp\utility::create_fake_loot(_id_7BC24930907ACD4D[1]);
  _id_ED195C8E452E7366 = _id_F8953FA9BCF991B3[2];
  _id_ED195C8E452E7366 thread scripts\cp\utility::create_fake_loot(_id_7BC24930907ACD4D[2]);
}

cleanup_loot_pickups() {
  _id_A39FC0D2C48AA997 = getEntArray("seq3_loot_room_a", "targetname");
  _id_A39FC1D2C48AABCA = getEntArray("seq3_loot_room_a", "targetname");
  _id_A39FC2D2C48AADFD = getEntArray("seq3_loot_room_a", "targetname");
  _id_774D964A7AB43387 = scripts\engine\utility::array_combine(_id_A39FC0D2C48AA997, _id_A39FC1D2C48AABCA, _id_A39FC2D2C48AADFD);

  foreach(loot in _id_774D964A7AB43387) {
    if(isent(loot))
      loot delete();
  }
}

_id_8F84AEB1A7549AC5(id, duration) {
  wait 0.25;
  level endon("seq3_clear_gas");

  if(!isDefined(level._id_DAD8FFB3EE5ED71E))
    level._id_DAD8FFB3EE5ED71E = [];

  _id_3EC9465475CE1166 = scripts\engine\utility::getStructArray("maze_gas_trigger", "targetname");

  foreach(_id_73862822B52EBF71 in _id_3EC9465475CE1166) {
    if(!isDefined(_id_73862822B52EBF71.script_noteworthy) || _id_73862822B52EBF71.script_noteworthy != id) {
      continue;
    }
    if(!isDefined(_id_73862822B52EBF71.height))
      _id_73862822B52EBF71.height = 256;

    trigger = spawn("trigger_rotatable_radius", _id_73862822B52EBF71.origin, 0, int(_id_73862822B52EBF71.radius), int(_id_73862822B52EBF71.height));
    trigger thread _id_930AB2E9B854AE79(duration, _id_73862822B52EBF71.radius, 5);
    level._id_DAD8FFB3EE5ED71E[level._id_DAD8FFB3EE5ED71E.size] = trigger;
  }

  scripts\engine\utility::exploder("gas_attack");
  level thread _id_A08D2F978E4651A8(id, duration);
  wait(duration);
  level thread _id_E8246BDB0E81A491();
}

_id_A08D2F978E4651A8(id, duration) {
  _id_9088D6CD76F4BDE6 = scripts\engine\utility::getStructArray("maze_gas_fx", "targetname");
  _id_AA5D8290994454A6 = scripts\engine\utility::getStructArray("seq3_computeron", "targetname");

  foreach(_id_429C465DED2CAEB1 in _id_AA5D8290994454A6)
  level thread scripts\cp\utility::playsoundatpos_safe(_id_429C465DED2CAEB1.origin, "cp_raid_gas_attack_alarm");

  foreach(fx_struct in _id_9088D6CD76F4BDE6) {
    if(!isDefined(fx_struct.script_noteworthy) || fx_struct.script_noteworthy != id) {
      continue;
    }
    level thread _id_90607D1E4B2E62B9(fx_struct, duration);
    wait 0.05;
  }
}

_id_E8246BDB0E81A491() {
  if(isDefined(level._id_DAD8FFB3EE5ED71E)) {
    level notify("seq3_clear_gas");

    foreach(trigger in level._id_DAD8FFB3EE5ED71E) {
      if(isDefined(trigger) && isent(trigger)) {
        level._id_DAD8FFB3EE5ED71E = scripts\engine\utility::array_remove(level._id_DAD8FFB3EE5ED71E, trigger);
        trigger delete();
      }
    }
  }
}

_id_90607D1E4B2E62B9(struct, duration) {
  if(!isDefined(struct)) {
    return;
  }
  if(!isDefined(duration))
    duration = 5;

  location = struct.origin;
  _id_06DD4A74B5CEA5FB = scripts\engine\utility::getfx("gas_cloud");
  effect = spawnfx(_id_06DD4A74B5CEA5FB, struct.origin, anglesToForward(struct.angles), anglestoup(struct.angles));
  wait 0.05;
  triggerfx(effect);
  scripts\engine\utility::play_sound_in_space("cp_raid_gas_attack", struct.origin);
  wait(duration);
  effect delete();
}

_id_930AB2E9B854AE79(duration, radius, start_delay) {
  self endon("death");
  level endon("game_ended");
  _id_92B1963E201DF321();
  badplace_cylinder("gas", duration, self.origin, int(radius), 1000, "axis");

  if(isDefined(start_delay) && start_delay > 0)
    wait(start_delay);

  childthread _id_669C0F6CB0B7F0CD::_id_C47D2F984D3BF0A0();

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(istrue(player._id_74D989FDE24CE851)) {
      continue;
    }
    if(istrue(player _meth_6F55D55CCFF20D14())) {
      continue;
    }
    if(getdvarint("dvar_A389E23A5EAC5E22", 0) == 1)
      player scripts\cp_mp\gasmask::init();

    player thread _id_7D6AF32749AFCA24(self);
    waitframe();
  }
}

_id_92B1963E201DF321() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "no_visionset") {
    self._id_2530B70405BB6444 = "";
    self._id_7E0319E77D0C4EA4 = "";
    return;
  }

  self._id_2530B70405BB6444 = "hometown_gas_close_less";

  if(isDefined(level._id_6F8D4906EF39F333))
    self._id_2530B70405BB6444 = level._id_6F8D4906EF39F333;

  self._id_7E0319E77D0C4EA4 = "hometown_gas_close";

  if(isDefined(level._id_22E8FFA026097A51))
    self._id_7E0319E77D0C4EA4 = level._id_22E8FFA026097A51;
}

_id_7D6AF32749AFCA24(_id_88729697EE65F2D4) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(istrue(self._id_D243690C7DE50370)) {
    return;
  }
  self._id_D243690C7DE50370 = 1;
  thread monitor_player_death();
  _id_538C41EFBECD1173 = 0;
  _id_6D576BD7066E38A8 = 0;
  _id_FA00FD901DA494DD = 0;

  for(;;) {
    if(isDefined(_id_88729697EE65F2D4) && self istouching(_id_88729697EE65F2D4)) {
      if(!istrue(self._id_74D989FDE24CE851)) {
        _id_538C41EFBECD1173 = gettime();
        _id_6D576BD7066E38A8 = 0;

        if(!scripts\cp_mp\gasmask::hasgasmask(self))
          self.disable_health_regen = 1;
      }

      self._id_74D989FDE24CE851 = 1;

      if(!isDefined(self._id_A84DB9E74FE14F9A) || self._id_A84DB9E74FE14F9A != _id_88729697EE65F2D4)
        self visionsetnakedforplayer(_id_88729697EE65F2D4._id_2530B70405BB6444, 0.2);

      self._id_A84DB9E74FE14F9A = _id_88729697EE65F2D4;

      if(istrue(self _meth_6F55D55CCFF20D14())) {} else if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        if(!istrue(self.gasmaskequipped) && !istrue(self.gasmaskswapinprogress))
          thread scripts\cp_mp\gasmask::equipgasmask();

        if(getdvarint("dvar_F6E32C18676A102F", 0) > 0)
          scripts\cp_mp\gasmask::processdamage(5);
      } else if(_id_538C41EFBECD1173 == 0 || gettime() - _id_538C41EFBECD1173 >= 1500) {
        if(_id_88729697EE65F2D4._id_7E0319E77D0C4EA4 != "")
          self visionsetnakedforplayer(_id_88729697EE65F2D4._id_7E0319E77D0C4EA4, 0.5);

        if(_id_FA00FD901DA494DD <= 0 || gettime() >= _id_FA00FD901DA494DD + 3000) {
          self dodamage(15, self.origin, undefined, undefined, "MOD_TRIGGER_HURT");
          _id_FA00FD901DA494DD = gettime();

          if(isalive(self) && !istrue(self.inlaststand)) {
            thread _id_8C4069DA757FD711();
            thread _id_5EE5342217DA4345();
            _id_893FF9B814E04F95 = self getcurrentweapon();

            if(_id_893FF9B814E04F95.basename != "none") {
              if(self isgestureplaying("iw9_ges_gas_cough"))
                self stopgestureviewmodel("iw9_ges_gas_cough", 0, 1);

              self playgestureviewmodel("iw9_ges_gas_cough");
            }
          }
        }
      }
    } else {
      _id_F5EDED8E40C88A1B(_id_6D576BD7066E38A8);

      if(!isent(_id_88729697EE65F2D4))
        return;
    }

    wait 0.5;
  }
}

_id_F5EDED8E40C88A1B(_id_6D576BD7066E38A8) {
  if(istrue(self._id_74D989FDE24CE851)) {
    _id_6D576BD7066E38A8 = gettime();
    _id_538C41EFBECD1173 = 0;
  }

  self.disable_health_regen = 0;
  self notify("force_regeneration");
  self._id_A84DB9E74FE14F9A = undefined;
  self._id_74D989FDE24CE851 = undefined;
  self visionsetnakedforplayer("", 0.5);
  self._id_D243690C7DE50370 = 0;

  if(isDefined(_id_6D576BD7066E38A8)) {
    if(_id_6D576BD7066E38A8 == 0 || gettime() - _id_6D576BD7066E38A8 >= 5000) {
      if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        if(istrue(self.gasmaskequipped) && !istrue(self.gasmaskswapinprogress))
          thread scripts\cp_mp\gasmask::removegasmask();
      }

      self._id_D243690C7DE50370 = 0;
      return;
    }
  } else
    self._id_D243690C7DE50370 = 0;
}

monitor_player_death() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("last_stand", "death");
  self visionsetnakedforplayer("", 0);
}

_id_8C4069DA757FD711() {
  player = self;

  if(!isalive(player)) {
    return;
  }
  if(isDefined(player.brcirclecoughnexttime) && gettime() < player.brcirclecoughnexttime) {
    return;
  }
  player.brcirclecoughnexttime = gettime() + randomintrange(5000, 7000);

  if(!isai(player))
    player playlocalsound("gas_player_cough");

  _id_4DE0F8859B1A8D67 = "allies_male_cough";
  _id_95CE4F91D0F58568 = player.defaultoperatorteam;

  if(!isDefined(_id_95CE4F91D0F58568))
    _id_95CE4F91D0F58568 = "allies";

  _id_AE461AB77282F77C = player.operatorcustomization.gender;

  if(_id_95CE4F91D0F58568 == "axis") {
    if(isDefined(_id_AE461AB77282F77C) && _id_AE461AB77282F77C == "female")
      _id_4DE0F8859B1A8D67 = "axis_female_cough";
    else
      _id_4DE0F8859B1A8D67 = "axis_male_cough";
  } else if(isDefined(_id_AE461AB77282F77C) && _id_AE461AB77282F77C == "female")
    _id_4DE0F8859B1A8D67 = "allies_female_cough";
  else
    _id_4DE0F8859B1A8D67 = "allies_male_cough";

  _id_D4EB9B956E707234 = randomint(game["dialogue"][_id_4DE0F8859B1A8D67].size);
  _id_818F7C4CF3588018 = game["dialogue"][_id_4DE0F8859B1A8D67][_id_D4EB9B956E707234];
  player playsoundonmovingent(_id_818F7C4CF3588018);
}

_id_5EE5342217DA4345() {
  if(!isDefined(self._id_35435159D84850B6) || isDefined(self._id_35435159D84850B6) && gettime() > self._id_35435159D84850B6 + 15000) {
    self._id_35435159D84850B6 = gettime();
    thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID1_NUMSPUZZLE/HINT_GAS", 5);
  }
}

wait_for_elevator(_id_8F326AB0287421A3) {
  level endon("game_ended");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Numbers Sequence: 4");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Numbers Puzzle: Defend");

  if(isDefined(level.interactions["f14_puzzle_keypad"]))
    _id_71332A5B74214116::removefrominteractionslistbynoteworthy("f14_puzzle_keypad");

  if(!istrue(_id_8F326AB0287421A3)) {
    thread scripts\cp\utility::objective_update("s3_overall_goal");
    level thread scripts\engine\utility::delaythread(1.5, scripts\cp\cp_objectives::lua_objective_complete, "s3_overall_goal");
  } else {
    level thread scripts\cp\cp_objectives::lua_objective_complete("s3_overall_goal");
    level thread scripts\cp\cp_objectives::lua_objective_complete("s3_findpower");
  }

  if(scripts\cp\cp_checkpoint::_id_9EED75023A958C18() != "checkpoint_nums_ready_finale") {
    scripts\cp\cp_checkpoint::checkpoint_set("checkpoint_nums_ready_finale");
    level thread scripts\cp\utility::thread_teleportplayertoteamstructs_latejoin("allies", "numbers_checkpoint_defend_debug_start_loc");
  }

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_192FBA54D0D22AC1 = scripts\engine\utility::getStructArray("numbers_checkpoint_defend_debug_start_loc", "targetname");
    level scripts\engine\utility::delaythread(10, _id_0AFB7E332AEE4BF2::_id_79DDAC0EF09B8D0F, _id_192FBA54D0D22AC1, 0);
  }

  center = scripts\engine\utility::getStruct("seq3_center", "targetname");
  _id_87D2A2C169137669 = getEntArray("seq3_resetbutton", "targetname");
  _id_BA9FC18C0856DDE5 = scripts\engine\utility::getclosest(center.origin, _id_87D2A2C169137669);
  _id_BA9FC18C0856DDE5 makeunusable();
  _id_C9BCEA237F19C3DD = getEntArray("seq3_reloadbutton", "targetname");
  _id_82AB5773763542D1 = scripts\engine\utility::getclosest(center.origin, _id_C9BCEA237F19C3DD);

  if(isDefined(_id_82AB5773763542D1) && isent(_id_82AB5773763542D1))
    _id_82AB5773763542D1 makeunusable();

  foreach(button in level.seq3_displaymodels) {
    if(istrue(button.outlined))
      button hudoutlinedisable();
  }

  center = scripts\engine\utility::getStruct("seq3_center", "targetname");
  thread scripts\cp\utility::playsoundatpos_safe(center.origin, "emt_alarm_power_button");
  scripts\cp\cp_objectives::reset_objective_timers();
  waitframe();
  objective_timers_reset_both();
  waitframe();

  if(istrue(level._id_922A06644812D5DE))
    _id_FAB3E275B4CAC0A4();
  else {
    setomnvar("cp_objective_sub_1_index", 0);
    setomnvar("cp_objective_sub_count_1", -1);
  }

  totaltime = 240;
  level thread _id_18AF78602B67B70C::_id_6AE8E5D7C480EF7D();
  level thread scripts\cp\utility::objective_update("s3_waitelevator", totaltime, 30, 10, 1);
  level thread elevator_doors_open(0, totaltime);
  level thread elevator_lights_toggle(1);

  if(istrue(level._id_922A06644812D5DE))
    wait 1;
  else
    wait 15;

  level._id_38B8D41AA0C9B2B2 = undefined;
  level thread _id_04A107D2049AAC63();

  if(getdvarint("dvar_F73753F636A66C95", 0) == 0 && !istrue(level._id_A70195BBD734F8DA)) {
    level.spawn_module_current = thread _id_18A73A64992DD07D::run_spawn_module("seq3_group_finale");
    level thread _id_72936E9D89227EAF::_id_0DF8F59541BDDD28();
    level thread _id_72936E9D89227EAF::_id_49C4EEBA5A55A46D(25);
    level thread _id_72936E9D89227EAF::_id_3AE5F9B05F0B2523(40);
    level thread _id_72936E9D89227EAF::_id_49C4EBBA5A559DD4(135);

    if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
      level thread _id_72936E9D89227EAF::_id_3AE5FAB05F0B2756(1);
      level thread _id_72936E9D89227EAF::_id_3AE5FBB05F0B2989(110);
      level thread _id_72936E9D89227EAF::_id_3AE5FCB05F0B2BBC(150);
    }
  }

  level thread scripts\engine\utility::delaythread(30, ::_id_8F84AEB1A7549AC5, "a", 270);
  level thread scripts\engine\utility::delaythread(30, ::_id_8F84AEB1A7549AC5, "b", 270);

  if(istrue(level._id_922A06644812D5DE))
    wait(totaltime - 1);
  else
    wait(totaltime - 15);

  if(isDefined(level._id_7CAA8AB2F4145CFA))
    _func_A3901A965FC1D7DD(level._id_7CAA8AB2F4145CFA);

  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Numbers Puzzle: Defend");
  scripts\cp\cp_analytics::_id_0AE955CCDEF747B0("Raid: Numbers Puzzle: Ending");
  thread scripts\cp\utility::playsoundatpos_safe(center.origin, "emt_alarm_power_button");
  level thread scripts\cp\cp_objectives::lua_objective_complete("s3_waitelevator");
  level notify("stop_finale_drones");
  level notify("end_wave_seq3_spawners");
  level thread _id_18A73A64992DD07D::pause_all_other_groups("asdf");
  level thread _id_6E2CD47141F9745B::_id_18871F933340B91B(1600);
  scripts\cp\cp_objectives::run_objective("s3_regroup_exit", "primary", "allies");
  level _id_65186E53085C1DDA();
  level thread scripts\cp\cp_objectives::lua_objective_complete("s3_regroup_exit");
  wait 0.05;
  level thread complete_game_win();
  level thread _id_6E2CD47141F9745B::_id_18871F933340B91B();
  _id_01D4621C77C9108F = getaiarray("axis");

  foreach(ai in _id_01D4621C77C9108F)
  ai _id_18A73A64992DD07D::script_kill_ai();
}

_id_04A107D2049AAC63() {
  level endon("game_ended");
  level endon("stop_finale_drones");
  level thread _id_77F401C06E799794();
  level._id_E151D3B4EBF727DA = 1;
  script_noteworthy = "bomber_point_numspuzzle";
  _id_18F3121E8D570C1B = scripts\engine\utility::getStruct(script_noteworthy, "script_noteworthy");
  _id_1A96B3062BB2C598 = squared(1200);
  radius_min_sq = squared(400);
  _id_63A45C9E48F9D118 = _id_3F3AB06505AA7C46::_id_E96CD5024F2AC563;
  _id_3CCEEDE82F85C495 = scripts\engine\utility::getStructArray("c4_plant_interact_spot", "targetname");
  level._id_15F2D97EE1ACECD4 = undefined;

  for(;;) {
    wait 2;
    nearbyplayer = _id_18F3121E8D570C1B scripts\cp\utility::get_closest_living_player(radius_min_sq);

    if(isDefined(nearbyplayer)) {
      continue;
    }
    _id_01D4621C77C9108F = getaiarray("axis");
    _id_CA8C6A312E6ED900 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_01D4621C77C9108F.size; _id_AC0E594AC96AA3A8++) {
      if(isalive(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8])) {
        if(!_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8] _id_137E96D7CB098BC4()) {
          continue;
        }
        if(distance2dsquared(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].origin, _id_18F3121E8D570C1B.origin) > _id_1A96B3062BB2C598) {
          continue;
        }
        _id_CA8C6A312E6ED900[_id_CA8C6A312E6ED900.size] = _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8];
      }
    }

    if(_id_CA8C6A312E6ED900.size > 0 && !isDefined(level._id_15F2D97EE1ACECD4)) {
      level._id_15F2D97EE1ACECD4 = scripts\engine\utility::random(_id_CA8C6A312E6ED900);
      level._id_15F2D97EE1ACECD4 thread[[_id_63A45C9E48F9D118]](undefined, script_noteworthy, undefined, 15, 1);
      level thread _id_4CD40CDF88C4F725(level._id_15F2D97EE1ACECD4);
      continue;
    }
  }
}

_id_4CD40CDF88C4F725(guy) {
  level endon("game_ended");
  guy waittill("death");
  _id_809B9259FA935868 = 30;

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
    _id_809B9259FA935868 = 15;

  wait(_id_809B9259FA935868);
  level._id_15F2D97EE1ACECD4 = undefined;
}

_id_77F401C06E799794() {
  level endon("game_ended");
  level endon("stop_finale_drones");
  level waittill("ai_bomb_detonated");
  level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_BOMBER_AI/MISSION_FAIL");
  wait 2;
  level thread[[level.endgame]]("axis", level.end_game_string_index["enemy_bomb_exploded"]);
}

_id_137E96D7CB098BC4() {
  if(isDefined(self.unittype) && self.unittype == "juggernaut")
    return 0;

  if(scripts\cp\utility::isjuggernaut())
    return 0;

  if(isDefined(self.aitype) && self.aitype == "juggernaut")
    return 0;

  if(isDefined(self.unittype) && self.unittype == "suicidebomber")
    return 0;

  if(istrue(self.hasriotshieldequipped) || istrue(self.bhasriotshieldattached))
    return 0;

  return 1;
}

_id_FAB3E275B4CAC0A4() {
  level endon("game_ended");
  _id_421681406E479DAF = scripts\engine\utility::getStruct("seq3_elevator_arrival", "targetname");
  objectiveindex = scripts\cp\cp_objectives::requestworldid("blastdoor_checkpoint");
  objective_setminimapiconsize(objectiveindex, "icon_regular");
  objective_setlabel(objectiveindex, &"CP_RAID1_NUMSPUZZLE/BLAST_DOOR_REGROUP");
  objective_position(objectiveindex, _id_421681406E479DAF.origin + (0, 0, 100));
  objective_setshowoncompass(objectiveindex, 1);
  objective_icon(objectiveindex, "icon_waypoint_objective_general");
  objective_state(objectiveindex, "current");
  objective_setplayintro(objectiveindex, 1);
  objective_setplayoutro(objectiveindex, 1);

  for(;;) {
    foreach(player in level.players) {
      if(distance(player.origin, _id_421681406E479DAF.origin) <= 300) {
        objective_delete(objectiveindex);
        scripts\cp\cp_objectives::freeworldid("blastdoor_checkpoint");
        return;
      }
    }

    wait 1;
  }
}

_id_AAF55A9A32F6E313() {
  level endon("game_ended");
  _id_4549CD5FC4176D49 = undefined;
  _id_F95FEB63C772E28F = undefined;
  _id_482BFE636B50DC53 = 500;
  wait 0.5;

  foreach(player in level.players) {
    if(!isDefined(_id_F95FEB63C772E28F)) {
      _id_4549CD5FC4176D49 = player.origin;
      continue;
    }

    _id_4549CD5FC4176D49 = _id_4549CD5FC4176D49 + player.origin;
  }

  for(;;) {
    _id_F95FEB63C772E28F = undefined;

    foreach(player in level.players) {
      if(!isDefined(_id_F95FEB63C772E28F)) {
        _id_F95FEB63C772E28F = player.origin;
        continue;
      }

      _id_F95FEB63C772E28F = _id_F95FEB63C772E28F + player.origin;
    }

    if(isDefined(_id_F95FEB63C772E28F) && isDefined(_id_4549CD5FC4176D49)) {
      if(distance(_id_F95FEB63C772E28F, _id_4549CD5FC4176D49) > _id_482BFE636B50DC53)
        return;
    }

    wait 0.5;
  }
}

_id_65186E53085C1DDA() {
  level endon("game_ended");
  level._id_3D247A2128AC423B unlink();
  level._id_C2C4F5BF44CF0984 unlink();
  level._id_3D247A2128AC423B.origin = level._id_3D247A2128AC423B.origin + rotatevector((40, 0, 0), level._id_3D247A2128AC423B.angles);
  level._id_C2C4F5BF44CF0984.origin = level._id_C2C4F5BF44CF0984.origin + rotatevector((40, 0, 0), level._id_C2C4F5BF44CF0984.angles);
  use_struct = scripts\engine\utility::getStruct("nums_finale_door_interact_struct", "targetname");
  model = spawn("script_model", use_struct.origin);
  model setModel("tag_origin");
  model makeusable();
  model sethintdisplayrange(220);
  model sethintdisplayfov(85);
  model setuserange(110);
  model setusefov(60);
  model setusepriority(1);
  model setuseholdduration("duration_short");
  model setCursorHint("HINT_BUTTON");
  model sethintonobstruction("hide");
  model setHintString(&"CP_RAID1_NUMSPUZZLE/CLEAR_THE_AREA");
  model thread _id_688164290FBB361D();
  level thread scripts\cp\utility::objective_update("s3_regroup_exit", undefined, undefined, undefined, 1, 0);
  level thread _id_1E9BF201EA44567C::_id_5A52715BF68D9C6C(1600);

  for(_id_2E55675D530EFA46 = getaiarray("axis"); _id_2E55675D530EFA46.size > 0; _id_2E55675D530EFA46 = scripts\engine\utility::array_combine(_id_2E55675D530EFA46, _id_9A55D2A0D832D232)) {
    wait 0.1;
    _id_01D4621C77C9108F = getaiarray("axis");
    _id_9A55D2A0D832D232 = level.drone_turrets;
    _id_2E55675D530EFA46 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_01D4621C77C9108F.size; _id_AC0E594AC96AA3A8++) {
      if(distance(_id_01D4621C77C9108F[_id_AC0E594AC96AA3A8].origin, model.origin) < 1600)
        _id_2E55675D530EFA46[_id_2E55675D530EFA46.size] = _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8];
    }
  }

  level childthread _id_669C0F6CB0B7F0CD::_id_D760E9C63602F0AA();
  model setHintString(&"CP_RAID1_NUMSPUZZLE/OBJ_REGROUP_EXIT_0");
  level._id_4371DA166FCFAB5E = [];
  level thread _id_BF1014F12A178FB6(model);

  while(level._id_4371DA166FCFAB5E.size < level.players.size) {
    model waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!isDefined(scripts\engine\utility::array_find(level._id_4371DA166FCFAB5E, player))) {
      level._id_4371DA166FCFAB5E = scripts\engine\utility::array_add(level._id_4371DA166FCFAB5E, player);

      if(level._id_4371DA166FCFAB5E.size == 1) {
        model setHintString(&"CP_RAID1_NUMSPUZZLE/OBJ_REGROUP_EXIT_1");
        level thread scripts\cp\utility::objective_update("s3_regroup_exit", undefined, undefined, undefined, 1, 1);
      } else if(level._id_4371DA166FCFAB5E.size == 2) {
        model setHintString(&"CP_RAID1_NUMSPUZZLE/OBJ_REGROUP_EXIT_2");
        level thread scripts\cp\utility::objective_update("s3_regroup_exit", undefined, undefined, undefined, 1, 2);
      } else if(level._id_4371DA166FCFAB5E.size == 3) {
        model setHintString(&"CP_RAID1_NUMSPUZZLE/OBJ_REGROUP_EXIT_3");
        level thread scripts\cp\utility::objective_update("s3_regroup_exit", undefined, undefined, undefined, 1, 3);
      }
    }

    if(level._id_4371DA166FCFAB5E.size >= level.players.size) {
      break;
    }
  }

  if(soundexists("cp_raid_silo_door_regroup"))
    playsoundatpos(model.origin, "cp_raid_silo_door_regroup");

  if(isDefined(level._id_3930E5D7659C7FF1))
    _id_BE4C4431B7527C8F(level._id_3930E5D7659C7FF1);

  model _meth_DFB78B3E724AD620(0);
  model delete();
}

_id_BF1014F12A178FB6(model) {
  level endon("game_ended");
  model endon("death");
  distsq = squared(70);

  for(;;) {
    player = model scripts\cp\utility::get_closest_living_player(distsq);

    if(isDefined(player)) {
      if(!isDefined(scripts\engine\utility::array_find(level._id_4371DA166FCFAB5E, player))) {
        if(!isDefined(player._id_9B5CF50B7567C6CC))
          player._id_9B5CF50B7567C6CC = 0;

        player._id_9B5CF50B7567C6CC++;

        if(player._id_9B5CF50B7567C6CC >= 5)
          model notify("trigger", player);
      }
    }

    wait 1;
  }
}

_id_688164290FBB361D() {
  level endon("game_ended");
  self endon("trigger");
  level._id_3930E5D7659C7FF1 = _id_9D4775D1E93211E7(self.origin + (0, 0, 10));
}

_id_9D4775D1E93211E7(_id_49ECE3D0608350F7) {
  objindex = scripts\cp\cp_objectives::requestworldid("final_objective", 35);
  objective_state(objindex, "current");
  objective_position(objindex, _id_49ECE3D0608350F7);
  objective_icon(objindex, "icon_waypoint_objective_general");
  objective_setminimapiconsize(objindex, "icon_regular");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 1);
  objective_sethot(objindex, 0);
  return objindex;
}

_id_BE4C4431B7527C8F(objindex) {
  objective_delete(objindex);
  scripts\cp\cp_objectives::freeworldidbyobjid(objindex);
}

_id_F9EA1D98F557E042() {
  level endon("game_ended");
  level endon("enter_silo_triggered");
  _id_AF123F3B3717038E = getEnt("nums_finale_ending_trigger", "targetname");

  for(;;) {
    _id_AF123F3B3717038E waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    break;
  }

  level notify("enter_silo_triggered");
  _id_AF123F3B3717038E delete();
}

complete_game_win() {
  level endon("game_ended");
  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Numbers Puzzle: Ending");
  _id_BB6F264BF4547737 = getdvarfloat("dvar_22B17CCC1FE31F3D", 2.0);

  foreach(player in level.players) {
    player thread _id_C110DCDE4E5A2AAE();
    player thread _id_6F1004E80B298892(_id_BB6F264BF4547737, player);
  }

  wait(_id_BB6F264BF4547737);
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

_id_6F1004E80B298892(_id_BB6F264BF4547737, player) {
  player endon("disconnect");
  level endon("game_ended");
  player setsoundsubmix("fade_to_black_all_except_music_and_scripted5", _id_BB6F264BF4547737);
  wait 0.3;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.3);
  wait(_id_BB6F264BF4547737);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.3);
}

_id_C110DCDE4E5A2AAE() {
  self endon("disconnect");
  _id_3B64EB40368C1450::set("game_win", "damage", 0);
  level waittill("game_ended");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("game_win");
}

elevator_lights_toggle(_id_41D8BF229CF29051) {
  if(istrue(_id_41D8BF229CF29051)) {
    _id_CB2CFD47969D515D = getEnt("seq3_elevator_light_red", "targetname");
    _id_B3DCE08F1359A896 = getEnt("seq3_elevator_light_green", "targetname");

    if(!isent(_id_CB2CFD47969D515D)) {
      return;
    }
    _id_CB2CFD47969D515D setModel("ee_light_mounted_exterior_industrial_caged_02");
    _id_B3DCE08F1359A896 setModel("ee_light_mounted_exterior_industrial_caged_02_on_cargo_green");
  } else {
    _id_CB2CFD47969D515D = getEnt("seq3_elevator_light_red", "targetname");
    _id_B3DCE08F1359A896 = getEnt("seq3_elevator_light_green", "targetname");

    if(!isent(_id_CB2CFD47969D515D)) {
      return;
    }
    _id_CB2CFD47969D515D setModel("light_industrial_caged_02_on_red_lm");
    _id_B3DCE08F1359A896 setModel("ee_light_mounted_exterior_industrial_caged_02");
  }
}

elevator_doors_open(delay, _id_53A189B7414318B9) {
  scripts\engine\utility::flag_init("end_doors_pipes_open");
  scripts\engine\utility::flag_init("end_doors_fully_opened");
  level thread _id_1C2942E72AAC4950();
  thread _id_669C0F6CB0B7F0CD::_id_96AAADBB5D1468B8();
  _id_42D1475172601C18 = getEntArray("nums_endgate_pipe_left", "targetname");

  foreach(_id_3F0B819F2F7B898D in _id_42D1475172601C18)
  _id_3F0B819F2F7B898D delete();

  _id_42D1475172601C18 = getEntArray("nums_endgate_pipe_right", "targetname");

  foreach(_id_3F0B819F2F7B898D in _id_42D1475172601C18)
  _id_3F0B819F2F7B898D delete();

  level thread _id_876D7707A2BD40EA("seq3_elevatordoor_left", "seq3_elevatordoor_right", 0, 45);
  _id_5447D133C50E577D = _id_53A189B7414318B9 + 20;
  level thread _id_876D7707A2BD40EA("nums_endgate_pipe_left", "nums_endgate_pipe_right", 0, _id_5447D133C50E577D, (0, 0, 0), 65, "script_noteworthy");
  wait(_id_53A189B7414318B9);
  scripts\engine\utility::flag_set("end_doors_pipes_open");
  scripts\engine\utility::flag_set("end_doors_fully_opened");
  thread _id_669C0F6CB0B7F0CD::_id_F69BE58BD5E267C9();
}

_id_876D7707A2BD40EA(_id_C60A22ADFDF83E0F, _id_8447AE65353E2422, delay, _id_53A189B7414318B9, anglesoffset, _id_B2C75C57E854AB13, _id_3EC0CE479098AF29) {
  type = "targetname";

  if(isDefined(_id_3EC0CE479098AF29))
    type = _id_3EC0CE479098AF29;

  _id_2DA6C3993CD69773 = getEntArray(_id_C60A22ADFDF83E0F, type);
  _id_1209A9F809F4C1FC = getEntArray(_id_8447AE65353E2422, type);

  if(!isDefined(anglesoffset))
    anglesoffset = (0, 0, 0);

  if(!isDefined(_id_B2C75C57E854AB13))
    _id_B2C75C57E854AB13 = 0;

  _id_E520906C5F9D7A67 = (50 + _id_B2C75C57E854AB13, 0, 0);
  _id_E520906C5F9D7A67 = rotatevector(_id_E520906C5F9D7A67, _id_2DA6C3993CD69773[0].angles + anglesoffset);
  _id_8A444F6F271A657A = (-1 * (50 + _id_B2C75C57E854AB13), 0, 0);
  _id_8A444F6F271A657A = rotatevector(_id_8A444F6F271A657A, _id_1209A9F809F4C1FC[0].angles + anglesoffset);

  if(isDefined(delay) && delay > 0)
    wait(delay);

  _id_BC2187027C9A7659 = 10;

  if(isDefined(_id_53A189B7414318B9))
    _id_BC2187027C9A7659 = _id_53A189B7414318B9;

  _id_1D5DB5EEFD5BE7C6 = _id_BC2187027C9A7659 * 0.05;
  _id_7B7BEDC9F1D38784 = _id_BC2187027C9A7659 * 0.05;

  foreach(_id_A3C2CEDEFEF30464 in _id_2DA6C3993CD69773)
  _id_A3C2CEDEFEF30464 moveTo(_id_A3C2CEDEFEF30464.origin + _id_8A444F6F271A657A, _id_BC2187027C9A7659, _id_1D5DB5EEFD5BE7C6, _id_7B7BEDC9F1D38784);

  foreach(_id_64084650276504B1 in _id_1209A9F809F4C1FC)
  _id_64084650276504B1 moveTo(_id_64084650276504B1.origin + _id_E520906C5F9D7A67, _id_BC2187027C9A7659, _id_1D5DB5EEFD5BE7C6, _id_7B7BEDC9F1D38784);

  wait(_id_BC2187027C9A7659);
}

_id_1C2942E72AAC4950() {
  level endon("game_ended");
  struct = scripts\engine\utility::getStruct("seq3_elevator_arrival", "targetname");
  offset = rotatevector((0, -16, 40), struct.angles);
  soundent = scripts\engine\utility::spawn_tag_origin(struct.origin + offset, struct.angles);
  soundent show();
  wait 0.05;

  if(soundexists("cp_raid_silo_door_open_start"))
    soundent playSound("cp_raid_silo_door_open_start");

  if(soundexists("cp_raid_silo_door_open_lp"))
    soundent playLoopSound("cp_raid_silo_door_open_lp");

  scripts\engine\utility::flag_wait("end_doors_fully_opened");

  if(soundexists("cp_raid_silo_door_open_stop"))
    soundent playSound("cp_raid_silo_door_open_stop");

  if(soundexists("cp_raid_silo_door_open_lp"))
    soundent stoploopsound();
}

elevator_raise() {
  elevator_model = getEnt("silo_elevator", "targetname");
  elevator_model moveTo(elevator_model.origin + (0, 0, 1048), 120, 1, 1);
}

turn_off_silo_lights() {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 11; _id_AC0E594AC96AA3A8++) {
    lights = getEntArray("silo_light_" + _id_AC0E594AC96AA3A8, "targetname");

    if(isDefined(lights) && lights.size > 0) {
      foreach(light in lights)
      light setlightintensity(0);
    }

    wait 0.1;
  }
}

turn_on_silo_lights() {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 11; _id_AC0E594AC96AA3A8++) {
    lights = getEntArray("silo_light_" + _id_AC0E594AC96AA3A8, "targetname");

    if(isDefined(lights) && lights.size > 0) {
      foreach(light in lights)
      light setlightintensity(5);
    }

    wait 0.1;
  }
}

_id_A623D3196178AA53() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  wait 5;
  scripts\engine\utility::flag_wait("seq3_poweron");
  level._id_DF2F5CF1D779EA0C = 1;
  scripts\engine\utility::flag_wait("seq3_keypad_intel_activated");
  thread _id_435C3F85A3D06576::_id_491A6611A0B52B99();
  doors = getEntArray("dynamic_door", "targetname");
  button = level.seq3_reset_switch;
  _id_CDC5DD6C28C9709D = squared(1500);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < doors.size; _id_AC0E594AC96AA3A8++) {
    if(distance2dsquared(doors[_id_AC0E594AC96AA3A8].origin, button.origin) < _id_CDC5DD6C28C9709D) {
      doors[_id_AC0E594AC96AA3A8] _id_7712F476EF0D6D4F();
      doors[_id_AC0E594AC96AA3A8] thread _id_69429A5FCB7D741D();
    }
  }
}

_id_7712F476EF0D6D4F() {
  if(isDefined(self.target)) {
    self.collision = getEnt(self.target, "targetname");
    self.collision linkTo(self);
  }
}

_id_69429A5FCB7D741D() {
  wait 0.05;
  offset = rotatevector((90, 0, 0), self.angles);
  self moveTo(self.origin + offset, 5, 1, 1);
}

ent_delete_by_targetname(targetname) {
  ent = getEnt(targetname, "targetname");

  if(isent(ent))
    ent delete();
}

seq3_cleanup_leftovers() {
  level thread ammo_cache_delete();
  level thread atmines_delete();
  level thread _id_1FDB885090FA3875::clear_keypad_currentdisplay_models();
  level thread delete_keypad_display_models();
  level thread cleanup_loot_pickups();
  level thread defcon_models_cleanup();
  _id_18A73A64992DD07D::stop_all_groups();

  foreach(ai in getaiarray("axis"))
  ai _id_18A73A64992DD07D::script_kill_ai();

  if(isDefined(level.remote_tanks)) {
    foreach(tank in level.remote_tanks) {
      if(isent(tank))
        tank scripts\cp\cp_remote_tank::tank_destroy();
    }
  }

  level thread ent_delete_by_targetname("seq3_elevatordoor_left");
  level thread ent_delete_by_targetname("seq3_elevatordoor_right");
  level thread ent_delete_by_targetname("seq3_elevator_light_green");
  level thread ent_delete_by_targetname("seq3_elevator_light_red");
  level thread ent_delete_by_targetname("seq3_keypad_greenlight_01");
  level thread ent_delete_by_targetname("seq3_keypad_greenlight_02");
  level thread ent_delete_by_targetname("seq3_keypad_greenlight_03");
  level thread ent_delete_by_targetname("seq3_keypad_greenlight_04");
  level.prespawnfromspectatorfunc = level._id_82BD02B6A0D0F1E6;
  level._id_82BD02B6A0D0F1E6 = undefined;
}

delete_keypad_display_models() {
  _id_8EBAD89F8329A92E();
  _id_BCDC96B1B54390D7 = getEntArray("seq3_command_console_model", "targetname");

  foreach(model in _id_BCDC96B1B54390D7) {
    if(isent(model))
      model delete();
  }

  if(isDefined(level.seq3_keyboards)) {
    foreach(_id_8ED7EFDCDFC4F998 in level.seq3_keyboards) {
      if(isent(_id_8ED7EFDCDFC4F998))
        _id_8ED7EFDCDFC4F998 delete();
    }
  }

  _id_3E6E0FDFA34F41C2 = getEnt("seq3_large_screen_a", "targetname");

  if(isent(_id_3E6E0FDFA34F41C2))
    _id_3E6E0FDFA34F41C2 delete();

  _id_3E6E0FDFA34F41C2 = getEnt("seq3_large_screen_b", "targetname");

  if(isent(_id_3E6E0FDFA34F41C2))
    _id_3E6E0FDFA34F41C2 delete();

  _id_3E6E0FDFA34F41C2 = getEnt("seq3_large_screen_c", "targetname");

  if(isent(_id_3E6E0FDFA34F41C2))
    _id_3E6E0FDFA34F41C2 delete();
}

_id_8EBAD89F8329A92E() {
  if(isDefined(level.seq3_digits_display_array)) {
    foreach(_id_A166868464F52912 in level.seq3_digits_display_array) {
      if(isent(_id_A166868464F52912))
        _id_A166868464F52912 delete();
    }
  }
}

play_sound_countdown() {
  level endon("game_ended");
  level endon("seq3_puzzle_complete");
  level endon("seq3_tier_increase");
  level endon("seq3_puzzle_lockdown");
  level thread trigger_stop_bombticks();
  _id_D8B19FC0EF4125C4 = level._id_C7CE28D1FB1348C3 - 10;

  if(_id_D8B19FC0EF4125C4 < 10)
    _id_D8B19FC0EF4125C4 = 10;

  wait(_id_D8B19FC0EF4125C4);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
    level.players[_id_AC0E594AC96AA3A8] thread _id_447B6795641BADED();
}

_id_447B6795641BADED() {
  level endon("game_ended");
  level endon("stop_bomb_ticks");
  self endon("disconnect");
  self playlocalsound("cp_raid_clock_tick");

  for(;;) {
    wait 1;

    if(!isalive(self)) {
      continue;
    }
    if(soundexists("cp_raid_clock_tick"))
      self playlocalsound("cp_raid_clock_tick");
  }
}

trigger_stop_bombticks() {
  level notify("stop_bomb_ticks");
}

play_sparks_power() {
  level endon("game_ended");
  level endon("seq3_reset_trigger");
  alias = "cp_raid_numbers_computer_terminal_beep_lp";
  pos = self.origin;
  _id_4CF58793CC4F1AD6 = spawn("script_origin", pos);
  _id_4CF58793CC4F1AD6 playLoopSound(alias);
  self waittill("computer_used");
  _id_4CF58793CC4F1AD6 stoploopsound();
  _id_4CF58793CC4F1AD6 delete();
}

_id_CD24105424BFA41C() {
  level._id_F57B5DB263860330 = 1;
  level.skip_nav_check_on_spectate_respawn = 1;
  level.disable_start_spawn_on_navmesh = 1;
  level._id_A4977696D3393DD8 = 1;
  level._id_7194135F0D48546E = 0.25;
  _id_7DC093FB71342953["prone"] = level._id_7194135F0D48546E * 800;
  _id_7DC093FB71342953["crouch"] = level._id_7194135F0D48546E * 1200;
  _id_7DC093FB71342953["stand"] = level._id_7194135F0D48546E * 2500;
  _id_7DC093FB71342953["shadow_prone"] = 0.05;
  _id_7DC093FB71342953["shadow_crouch"] = 0.05;
  _id_7DC093FB71342953["shadow_stand"] = 0.3;
  _id_3B0034EB96B13650["prone"] = level._id_7194135F0D48546E * 8000;
  _id_3B0034EB96B13650["crouch"] = level._id_7194135F0D48546E * 8000;
  _id_3B0034EB96B13650["stand"] = level._id_7194135F0D48546E * 8000;
  _id_3B0034EB96B13650["shadow_prone"] = 0.01;
  _id_3B0034EB96B13650["shadow_crouch"] = 0.02;
  _id_3B0034EB96B13650["shadow_stand"] = 0.38;
  _id_8F3F480583606401["prone"] = 1.1;
  _id_8F3F480583606401["crouch"] = 1.15;
  _id_8F3F480583606401["stand"] = 1.4;
  scripts\stealth\utility::set_detect_ranges(_id_7DC093FB71342953, _id_3B0034EB96B13650, _id_8F3F480583606401);
  _id_B6B642CBEFF52B88["prone"] = level._id_7194135F0D48546E * 150;
  _id_B6B642CBEFF52B88["crouch"] = level._id_7194135F0D48546E * 350;
  _id_B6B642CBEFF52B88["stand"] = level._id_7194135F0D48546E * 1000;
  _id_D0F35FC0A5C3DF79["prone"] = level._id_7194135F0D48546E * 250;
  _id_D0F35FC0A5C3DF79["crouch"] = level._id_7194135F0D48546E * 1000;
  _id_D0F35FC0A5C3DF79["stand"] = level._id_7194135F0D48546E * 1800;
  scripts\stealth\utility::set_min_detect_range_darkness(_id_B6B642CBEFF52B88, _id_D0F35FC0A5C3DF79);
  _id_FAC370D058479827["prone"] = 0;
  _id_FAC370D058479827["crouch"] = 0;
  _id_FAC370D058479827["stand"] = 0;
  _id_FB574B7959625BF0["prone"] = 0;
  _id_FB574B7959625BF0["crouch"] = 0;
  _id_FB574B7959625BF0["stand"] = 0;
  scripts\stealth\utility::_id_0F3883FE06A11269(_id_FAC370D058479827, _id_FB574B7959625BF0);
  _id_04E4F703E8EA149C["spotted"]["explosion"] = level._id_7194135F0D48546E * 2500;
  _id_04E4F703E8EA149C["hidden"]["explosion"] = level._id_7194135F0D48546E * 2500;
  _id_04E4F703E8EA149C["spotted"]["gunshot"] = level._id_7194135F0D48546E * 2000;
  _id_04E4F703E8EA149C["hidden"]["gunshot"] = level._id_7194135F0D48546E * 1000;
  scripts\stealth\manager::set_custom_distances(_id_04E4F703E8EA149C);
  scripts\stealth\utility::group_setcombatgoalRadius("group", 1024);
  scripts\stealth\utility::group_setcombatgoalRadius("seq3_spawners_intro_ambush", 1024);
  scripts\stealth\utility::group_setcombatgoalRadius("seq3_group_intro_jugg", 1024);
}

_id_65DFAAE634DF359D() {
  level endon("game_ended");
  wait 1;
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 1;
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / Warp Keypad P1\" \"set scr_numspuzzle_warpkeypadp1 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_54B0379A58BE5152", ::_id_94B28045BAD85F83);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / Warp Keypad P2\" \"set scr_numspuzzle_warpkeypadp2 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_54B0369A58BE4F1F", ::_id_94B28145BAD861B6);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / Warp Keypad P3\" \"set scr_numspuzzle_warpkeypadp3 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_54B0359A58BE4CEC", ::_id_94B28245BAD863E9);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / Use Intro Gate P1\" \"set scr_numspuzzle_useintrogatep1 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_6397148AD38369EC", ::_id_B3342E650768A75F);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / Use Intro Gate P2\" \"set scr_numspuzzle_useintrogatep2 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_6397178AD3837085", ::_id_B3342F650768A992);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / Use Intro Gate P3\" \"set scr_numspuzzle_useintrogatep3 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_6397168AD3836E52", ::_id_B33430650768ABC5);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / SwarmDrone Debug\" \"set scr_numspuzzle_drones 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_771BD154BEE9FA10", ::_id_F0BADB9B67B76B5D);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / SwarmDrone StopNDie\" \"set scr_numspuzzle_dronestop 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_331A0F02BD1457EB", ::_id_4CB57057805B906D);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / SwarmDrone AStar\" \"set scr_numspuzzle_astar 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_190E7A8DFCA7D1A2", ::_id_FC99E35E0724A8BC);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / SwarmDrone Gas A\" \"set scr_numspuzzle_gasa 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_4E733A17A47DF88B", ::_id_2B684989AB3C959E);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / SwarmDrone Gas B\" \"set scr_numspuzzle_gasb 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_4E733B17A47DFABE", ::_id_2B684889AB3C936B);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle QA / SwarmDrone SpawnA\" \"set scr_numspuzzle_qaspawna 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_5F1259C14494ABB7", ::_id_39A7318B7E757F0D);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle QA / SwarmDrone SpawnB\" \"set scr_numspuzzle_qaspawnb 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_5F125AC14494ADEA", ::_id_39A72E8B7E757874);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle QA / SwarmDrone SpawnSwarm\" \"set scr_numspuzzle_qaspawnswarm 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_2ABEF16DD37193D0", ::_id_83A78077A2E4EA9A);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle QA / SwarmDrone SpawnFinale\" \"set scr_numspuzzle_dronefinale 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_2D7E2DA3370138A4", ::_id_61A34F697C64641E);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle QA / Spawn Killwave B\" \"set scr_numspuzzle_spawnkillwaveb 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_7FCECA944C1EC70F", ::_id_8685CA72E66FB34D);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle QA / Spawn Finale Door 1\" \"set scr_numspuzzle_spawndoor1 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_C83C506B05860765", ::_id_CE25F2DB998AA057);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle QA / Spawn Finale Door 2\" \"set scr_numspuzzle_spawndoor2 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_C83C4D6B058600CC", ::_id_CE25F3DB998AA28A);
}

_id_F0BADB9B67B76B5D() {
  level notify("new_nums_debug_display");
  level endon("new_nums_debug_display");

  if(isDefined(level._id_FFCE363B6AEAACC8))
    level._id_FFCE363B6AEAACC8 destroy();

  level._id_FFCE363B6AEAACC8 = newhudelem();
  level._id_FFCE363B6AEAACC8.x = 400;
  level._id_FFCE363B6AEAACC8.y = 125;
  level._id_FFCE363B6AEAACC8.color = (1, 0, 0.9);
  level._id_FFCE363B6AEAACC8.alpha = 1.0;
  level._id_FFCE363B6AEAACC8.hidden = 0;
  level._id_FFCE363B6AEAACC8._id_9E76FE13C19DA9A3 = 0;
  level._id_FFCE363B6AEAACC8._id_95EF0E28E73E593C = 0;
  level._id_FFCE363B6AEAACC8.fontscale = 1.0;
  level._id_77D9637A0FC5A67E = 1;
  max = 120;
  text = "";
  level._id_FFCE363B6AEAACC8 thread scripts\engine\utility::delaycall(max + 1, ::destroy);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < max; _id_AC0E594AC96AA3A8++) {
    text = "";
    text = text + "^1Drones Debug: ..";

    foreach(group in level._id_EF94125F71754B2F)
    text = text + ("\n .. Drones in room ^3" + group.id + "^1 : ^2" + group.drones.size + "^1 .. ");

    if(isDefined(level._id_452EBC20A68AA0F0))
      text = text + ("\n ..^3 Times re-pathed frozen failsafe drones: ^6" + level._id_452EBC20A68AA0F0 + "^1 .. ");

    if(isDefined(level._id_7E0160E361500662))
      text = text + ("\n ..^3 Times killed frozen failsafe drones: ^5" + level._id_7E0160E361500662 + "^1 .. ");

    if(isDefined(level._id_02BB6DD8F3F3F19A))
      text = text + ("\n ..^3 Times killed frozen node failsafe drones: ^7" + level._id_02BB6DD8F3F3F19A + "^1 .. ");

    text = text + ("\n (" + (max - _id_AC0E594AC96AA3A8) + "s) .. ");

    if(isDefined(level._id_8D1CB2F62CE55C8A) && isDefined(level._id_8D1CB2F62CE55C8A.origin)) {}

    wait 1;
  }

  if(isDefined(level._id_FFCE363B6AEAACC8)) {
    level._id_FFCE363B6AEAACC8 destroy();
    level._id_77D9637A0FC5A67E = undefined;
  }
}

_id_4CB57057805B906D() {
  level notify("stop_swarm_drones");

  foreach(drone in level.drone_turrets)
  drone.clip dodamage(999999, drone.origin, level.players[0]);
}

_id_FC99E35E0724A8BC() {
  if(!isDefined(level._id_D33D8B91D93CD505)) {
    level._id_D33D8B91D93CD505 = 1;
    setdvarifuninitialized("astar_debug", 1);
  } else {
    level._id_D33D8B91D93CD505 = undefined;
    setdvarifuninitialized("astar_debug", 0);
  }
}

_id_39A7318B7E757F0D() {
  level thread _id_72936E9D89227EAF::_id_6739CAD53E0EB3E2("a", undefined, "1");
  level thread _id_72936E9D89227EAF::_id_6739CAD53E0EB3E2("a", undefined, "2");
}

_id_39A72E8B7E757874() {
  level thread _id_72936E9D89227EAF::_id_6739CAD53E0EB3E2("b", undefined, "1");
  level thread _id_72936E9D89227EAF::_id_6739CAD53E0EB3E2("b", undefined, "2");
}

_id_83A78077A2E4EA9A() {
  level._id_F753D22AE87B557B = 0;
  level thread _id_72936E9D89227EAF::_id_6739CAD53E0EB3E2("a", 6);
}

_id_61A34F697C64641E() {
  level thread _id_72936E9D89227EAF::_id_0DF8F59541BDDD28();
}

_id_8685CA72E66FB34D() {
  level thread _id_72936E9D89227EAF::_id_9868B574FF995881();
}

_id_CE25F2DB998AA057() {
  level thread _id_72936E9D89227EAF::_id_49C4EEBA5A55A46D(1);
}

_id_CE25F3DB998AA28A() {
  level thread _id_72936E9D89227EAF::_id_49C4EBBA5A559DD4(1);
}

_id_2B684989AB3C959E() {
  level thread _id_8F84AEB1A7549AC5("a", 60);
  announcement("60 seconds gas A");
}

_id_2B684889AB3C936B() {
  level thread _id_8F84AEB1A7549AC5("b", 60);
  announcement("60 seconds gas B");
}

_id_94B28045BAD85F83() {
  level thread _id_8FE8CFA178A9A30B(0);
}

_id_94B28145BAD861B6() {
  level thread _id_8FE8CFA178A9A30B(1);
}

_id_94B28245BAD863E9() {
  level thread _id_8FE8CFA178A9A30B(2);
}

_id_8FE8CFA178A9A30B(_id_CDD22A751B5E19BD) {
  if(isDefined(level.players[_id_CDD22A751B5E19BD])) {
    player = level.players[_id_CDD22A751B5E19BD];
    _id_F85F022CF90CAE89 = scripts\engine\utility::getStructArray("f14_puzzle_keypad", "script_noteworthy");
    _id_12A2A021A66D1E63 = scripts\engine\utility::getclosest(player.origin, _id_F85F022CF90CAE89);
    offset = rotatevector((25, 0, 0), _id_12A2A021A66D1E63.angles);
    player setOrigin(_id_12A2A021A66D1E63.origin + offset);
    player.angles = vectortoangles(_id_12A2A021A66D1E63.origin - player.origin);
    wait 0.1;
    level notify("manifest_computer_used", player);
    wait 1;
    _id_11019BDA5662ACAF = strtok(level.seq3_tvnums_str, " ");
    start = undefined;

    switch (level.seq3_tier) {
      case 1:
        start = 0;
        break;
      case 2:
        start = 3;
        break;
      case 3:
        start = 6;
        break;
      case 4:
        start = 9;
        break;
    }

    end = start + 3;

    for(_id_AC0E594AC96AA3A8 = start; _id_AC0E594AC96AA3A8 < end; _id_AC0E594AC96AA3A8++) {
      _id_A166868464F52912 = _id_11019BDA5662ACAF[_id_AC0E594AC96AA3A8];
      player notify("luinotifyserver", "number_pad_digit", _id_A166868464F52912);
      wait 0.3;
    }

    wait 0.1;
    player notify("exit_computer");
  }
}

_id_B3342E650768A75F() {
  level thread _id_359854C99A114F0B(level.players[0]);
}

_id_B3342F650768A992() {
  level thread _id_359854C99A114F0B(level.players[1]);
}

_id_B33430650768ABC5() {
  level thread _id_359854C99A114F0B(level.players[2]);
}

_id_359854C99A114F0B(player) {
  level._id_E688351D24B0B0DC notify("trigger", player);
}