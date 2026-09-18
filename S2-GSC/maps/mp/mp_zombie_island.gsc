/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island.gsc
*********************************************/

main() {
  level.zmb_uses_hint_notebook = 0;
  level.st_144545 = 1;
  level.var_AC2E = 3;
  level.var_A96A = 0.7;
  level.var_scaling_reach_min_wave = 15;
  level.var_scaling_reach_max_wave = 28;
  level.zmb_max_soul_collection_beams = 3;
  level.custom_camo_func_on = ::island_camo_vision_start;
  level.custom_camo_func_off = ::island_camo_vision_stop;
  level.st_142418 = 1;
  level.var_6BD5 = ::island_hc_kill_tracking;
  level.var_8B96 = ::zombies_players_secret_room_handle_ignore;
  level.custom_solo_zombie_sprint_rule = ::dont_solo_sprint_on_wave_0;
  level.use_zombie_unresolved_collision = 1;
  level.zmb_contracts_get_map_fog_state = ::maps / mp / mp_zombie_island_ee_fog_manager::get_is_fog_active;
  common_scripts\utility::flag_init("power_sz2");
  common_scripts\utility::flag_init("isolated_entry_to_isolated");
  level.cart_train_size = 2;
  level.quest_warp_table = "mp/questWarpValuesIsland.csv";
  level.quest_assert_no_hints = 1;
  level.var_2B7C = "shovel_zm";
  level.var_ABD3 = -500;
  level.var_C11 = 0;
  level.var_783F = 0;
  level.door_data_out_of_date = 0;
  level.zmb_exempt_from_passive_list = ["zombie_assassin"];
  level.zombie_prevent_fx_play_func = ::preventzmbfxfunc;
  level.additional_revive_spot_handling_func = ::zmb_island_link_revive_ent_to_cart;
  level.additional_on_revive_end_func = ::zmb_island_cart_on_revive;
  level.var_A96B = ::func_30D7;
  level.zmb_jumpscares_optional_cooldown_override_range = [12, 25];
  lib_055B::set_optional_new_cooldown();
  maps / mp / gametypes / zombies::register_addition_revive_rule(::separated_by_combat_event, ::debug_highlight_player_separation, "scr_hightLightPlayerSeparation");
  level.disable_jumpscare_playerdata = 0;
  level.var_6BB0 = ::onislandstartgame;
  level.wait_for_initial_fog_conditions_func = ::wait_for_initial_fog_conditions;
  level.zmb_custom_crawl_rule = ::dont_crawl_on_round_zero;
  level.means_of_skipping_rounds_func = ::maps / mp / mp_zombie_nest_ee_wave_manipulation::skiproundwait2;
  level.upgrade_machine_reveal_func = ::maps / mp / mp_zombie_island_ee_pack_a_punch_unlock::wait_for_upgrade_machine_arrived;
  maps / mp / mp_zombie_island_precache::main();
  maps / createart / mp_zombie_island_art::main();
  maps / createart / mp_zombie_island_fog_hdr::main();
  maps / mp / mp_zombie_island_fx::main();
  maps\mp\_load::main();
  maps / mp / mp_zombie_island_lighting::main();
  maps / mp / mp_zombie_island_aud::main();
  maps\mp\_water::init();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  maps / mp / zquests / casual / island_ee_main::init_difficulty_settings();
  func_5375();
  func_5339();
  initweapons();
  initialize_conditional_spawners();
  maps / mp / mp_zombies_attack_object::init();
  maps / mp / mp_zombie_island_straub_pa_events::init();
  level thread maps / mp / mp_zombie_falldamage_modifier::main();
  level thread lib_053D::init();
  level thread maps\mp\zombies\_zombies_money::init();
  level thread lib_057D::func_5162();
  level thread lib_0580::init();
  level thread maps / mp / mp_zombie_island_straub_apperances::main();
  level thread maps / mp / mp_zombie_island_cart::main();
  level thread maps / mp / zombies / weapons / _zombie_razer_gun::init();
  level thread maps / mp / mp_zombie_island_ee_fog_manager::init();
  level thread maps / mp / zombies / _zombies_audio_dlc1::initdlc1audio();
  if(maps\mp\_utility::isproductionlevelactive(10)) {
    level thread maps / mp / zombies / _zombies_lo_events::init_zm_lo_events();
  }

  level.initnewzombietypes = ::init_new_zombie_types;
  setDvar("2494", "0.12, 0, 0");
  setDvar("4341", "0");
  level.scaretable = "mp/zombieJumpScareTableS2DLC1.csv";
  level thread jump_scare_setup();
  level thread init_island_traps();
  level thread maps / mp / zombies / weapons / _zombie_aoe_grenade::init();
  level thread ambient_fx_trigger();
  level thread run_kill_barrier();
  level thread run_island_power_scriptable();
  level thread run_island_power_lights_scriptable();
  level thread run_island_power_lights_scriptable3();
  level thread run_island_power_lights_scriptable4();
  level thread run_island_power_lights_scriptable5();
  level thread run_island_power_lights_scriptable6();
  level thread run_island_power_lights_scriptable7();
  level thread vista_beach_listener();
  level.var_902A = ::func_902A;
  level.zombiespawnfxcount = 0;
  level thread monitor_explored_zones_achievement();
  lib_0547::func_7BA9(::enemykilled_assassinachievement);
  level thread maps / mp / mp_zombie_island_jumpscares::init();
  level thread maps / mp / zquests / dlc1_secrets_mp_zombie_island::init_dlc1_secrets_mp_zombie_island();
  level thread door_death_fix();
  level thread maps\mp\_utility::func_6F74(::mute_audio_on_intro);
  level thread maps\mp\_utility::func_6F74(::bunker_3_exploit_fix);
  level thread lib_0557::manage_mtx5_event();
}

bunker_3_exploit_fix() {
  var_00 = self;
  var_00 endon("disconnect");
  var_01 = 50;
  var_02 = getEntArray("zmb_island_bunker_exploit_hammer", "targetname");
  var_03 = common_scripts\utility::func_46B7("zmb_island_bunker_exploit_hammer_origin", "targetname");
  var_04 = common_scripts\utility::func_46B5("zmb_island_bunker_exploit_hammer_y", "targetname");
  for(;;) {
    var_05 = 0;
    foreach(var_07 in var_02) {
      if(var_00 istouching(var_07)) {
        var_05 = 1;
        break;
      }
    }

    if(var_05) {
      if(!isDefined(var_00.bunker3count)) {
        var_00.bunker3count = 1;
      } else {
        var_00.bunker3count = var_00.bunker3count + 5;
      }

      if(var_00.bunker3count >= var_01) {
        var_00.bunker3count = 0;
        var_09 = common_scripts\utility::func_4461(var_00.origin, var_03);
        var_00 setOrigin(getclosestpointonnavmesh(var_09.origin, var_00), 1);
      }
    } else {
      var_00.bunker3count = 0;
    }

    for(var_0A = 0; var_0A < 5; var_0A++) {
      wait 0.05;
    }
  }
}

debug_highlight_player_separation() {}

separated_by_combat_event(param_00, param_01) {
  if(!common_scripts\utility::func_562E(level.zmb_lockdown_event_active)) {
    return 0;
  }

  var_02 = common_scripts\utility::func_562E(param_00.participatinginevent) == common_scripts\utility::func_562E(param_01.participatinginevent);
  return !var_02;
}

door_death_fix() {
  while(!isDefined(level.var_AC1D)) {
    wait 0.05;
  }

  add_zombie_door_collision_handling("start_to_right_climb", 1, 0);
}

add_zombie_door_collision_handling(param_00, param_01, param_02) {
  var_03 = get_zombie_door(param_00);
  foreach(var_05 in var_03.var_64C5) {
    var_03 thread assign_collision_handling(var_05, param_01, param_02);
  }
}

get_zombie_door(param_00) {
  foreach(var_02 in level.var_AC1D) {
    if(lib_0547::func_5565(var_02.var_819A, param_00)) {
      return var_02;
    }
  }
}

assign_collision_handling(param_00, param_01, param_02) {
  param_00.var_A048 = [];
  var_03 = 2;
  foreach(var_05 in self.setclientdvars) {
    if(common_scripts\utility::func_562E(param_01)) {
      param_00 assign_door_collision_node(var_05, 1);
    }

    if(common_scripts\utility::func_562E(param_02)) {
      param_00 assign_door_collision_node(var_05, 0);
    }
  }

  param_00.var_A045 = ::zmi_door_collision_handler;
}

assign_door_collision_node(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.origin = getclosestpointonnavmesh(param_00.origin + pow(-1, !common_scripts\utility::func_562E(param_01)) * 32 * vectorNormalize(anglestoright(param_00.angles)));
  self.var_A048 = common_scripts\utility::func_F6F(self.var_A048, var_02);
}

zmi_door_collision_handler(param_00) {
  maps\mp\_movers::func_A047(param_00, 0);
}

dont_solo_sprint_on_wave_0() {
  return !lib_0547::func_5565(level.var_A980, 0);
}

agent_is_in_secret_room(param_00) {
  var_01 = undefined;
  if(common_scripts\utility::func_562E(param_00) && !common_scripts\utility::func_562E(self.wasteleported)) {
    var_01 = lib_0547::func_5565(self.var_9024, "isolated_room_zone") || lib_0547::func_5565(self.var_9024, "isolated_room_entry_zone");
  }

  return common_scripts\utility::func_562E(var_01) || lib_055A::func_AC29(self, "isolated_room_zone") || lib_055A::func_AC29(self, "isolated_room_entry_zone");
}

zombies_players_secret_room_handle_ignore(param_00) {
  if(!isPlayer(param_00)) {
    return 0;
  }

  var_01 = agents_are_separated(param_00, self);
  return var_01;
}

agents_are_separated(param_00, param_01) {
  return param_01 agent_is_in_secret_room(1) != param_00 agent_is_in_secret_room();
}

island_hc_kill_tracking(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isPlayer(param_00)) {
    return;
  }

  if(!isDefined(level.zmb_hc_subpens_kills)) {
    level.zmb_hc_subpens_kills = 0;
  }

  if(common_scripts\utility::func_562E(self.participatinginevent) && common_scripts\utility::func_562E(param_00.participatinginevent)) {
    level.zmb_hc_subpens_kills++;
  }
}

mute_audio_on_intro() {
  self setaltsceneobj("isl_intro_movie");
  while(!level.gamehasstarted) {
    wait 0.05;
  }

  self method_8627("isl_intro_movie");
}

collect_all_lore() {
  var_00 = getEntArray("lore_primary", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = getEnt(var_02.target, "targetname");
    var_03 notify("trigger", level.player);
    wait(0.2);
  }
}

initialize_conditional_spawners() {
  var_00 = common_scripts\utility::func_46B7("zombie_spawner", "script_noteworthy");
  if(!isDefined(level.zmb_isl_conditional_boss_spawns)) {
    level.zmb_isl_conditional_boss_spawns = [];
  }

  if(!isDefined(level.zmb_isl_conditional_cart_spawns)) {
    level.zmb_isl_conditional_cart_spawns = spawnStruct();
    level.zmb_isl_conditional_cart_spawns.var_905E = [];
  }

  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_82EC) && issubstr(var_02.var_82EC, "boss_fight_disable")) {
      level.zmb_isl_conditional_boss_spawns = common_scripts\utility::func_F6F(level.zmb_isl_conditional_boss_spawns, var_02);
    }

    if(isDefined(var_02.var_82EC) && issubstr(var_02.var_82EC, "needs_cart_stationed")) {
      var_02.is_zombies_spawner_script_disabled = 1;
      var_03 = strtok(var_02.var_82EC, ",");
      if(!isDefined(level.zmb_isl_conditional_cart_spawns.var_905E[var_03[1]])) {
        level.zmb_isl_conditional_cart_spawns.var_905E[var_03[1]] = [];
      }

      level.zmb_isl_conditional_cart_spawns.var_905E[var_03[1]] = common_scripts\utility::func_F6F(level.zmb_isl_conditional_cart_spawns.var_905E[var_03[1]], var_02);
    }
  }
}

dont_crawl_on_round_zero(param_00) {
  if(level.var_A980 > 0) {
    return param_00;
  }

  return 5;
}

func_30D7() {}

zmb_island_link_revive_ent_to_cart(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_01.oncartride)) {
    param_00 delete();
    return level.zmb_island_artillery_sled;
  }

  return param_00;
}

zmb_island_cart_on_revive(param_00, param_01, param_02) {
  if(isDefined(param_00) && maps\mp\_utility::isreallyalive(param_00)) {
    if(!common_scripts\utility::func_562E(param_00.oncartride)) {
      param_00 unlink();
    }

    if(param_01) {
      param_00 common_scripts\utility::func_616();
    }
  }
}

island_camo_vision_start() {
  self setclutforplayer("clut_mp_zombie_island_camo", 0.25);
}

island_camo_vision_stop() {
  self setclutforplayer("clut_mp_zombie_island", 0.25);
}

wait_for_initial_fog_conditions() {
  common_scripts\utility::func_3C9F(lib_0557::func_7838("Explore the Beach", "Survive the Beach"));
  level thread timeout_door_buy(600);
  level endon("doorbuy_timeout");
  var_00 = [];
  foreach(var_02 in level.var_AC1D) {
    if(isDefined(var_02.script_linkname) && issubstr(var_02.script_linkname, "assassin_wait")) {
      var_00[var_00.size] = var_02;
    }
  }

  if(var_00.size) {
    foreach(var_02 in var_00) {
      if(!common_scripts\utility::func_562E(var_02.var_6BE1)) {
        var_02 waittill("open");
      }
    }
  } else {}

  var_06 = level.var_A980 + randomint(1);
  while(level.var_A980 < var_06) {
    wait(0.125);
  }
}

timeout_door_buy(param_00) {
  wait(param_00);
  level notify("doorbuy_timeout");
}

preventzmbfxfunc() {
  var_00 = ["zombie_assassin"];
  return common_scripts\utility::func_F79(var_00, self.var_A4B);
}

func_902A(param_00) {
  if(lib_0547::func_5565(self.var_A4B, "zombie_assassin")) {
    return::assassin_scare_landing;
  }

  if(isDefined(param_00.var_82EC)) {
    switch (param_00.var_82EC) {
      case "spawn_dirt":
        return::dirtspawnnotetrackhandler;

      case "spawn_concrete":
        return::concretespawnnotetrackhandler;

      case "spawn_mud":
        return::mudspawnnotetrackhandler;

      case "spawn_sand":
        return::sandspawnnotetrackhandler;

      case "spawn_water":
        return::waterspawnnotetrackhandler;
    }
  }
}

assassin_scare_landing(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "land":
      lib_0378::func_8D74("js_assassin_landing");
      break;
  }
}

dirtspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_dirt");
  }
}

mudspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_mud");
  }
}

concretespawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_concrete");
  }
}

sandspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_sand");
  }
}

waterspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_water");
    thread zombiedripfx("zmb_spawn_water");
  }
}

zombiedripfx(param_00) {
  if(level.var_A980 >= 20) {
    return;
  }

  var_01 = "spawn_water_drip";
  if(isDefined(param_00)) {
    var_01 = param_00 + "_drip";
  }

  var_02 = ["J_Shoulder_RI", "J_Shoulder_LE", "J_Hip_LE", "J_Hip_RI", "J_Head"];
  foreach(var_05 in var_02) {
    if(isDefined(self gettagorigin(var_05))) {
      lib_0547::func_74A5(common_scripts\utility::func_44F5(var_01), self, var_05);
    }
  }

  zombiedripfxcleanup(var_02, var_01);
}

zombiedripfxcleanup(param_00, param_01) {
  self endon("death");
  while(isDefined(self) && isalive(self)) {
    wait(0.1);
    if(!isDefined(self.var_53D9) || !self.var_53D9) {
      break;
    }
  }

  wait(randomfloatrange(5, 15));
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  foreach(var_03 in param_00) {
    if(isDefined(self gettagorigin(var_03))) {
      lib_0547::func_9406(common_scripts\utility::func_44F5(param_01), self, var_03);
    }
  }
}

zombiespawnfx(param_00) {
  if(level.zombiespawnfxcount >= 12) {
    return;
  }

  var_01 = spawnfx(common_scripts\utility::func_44F5(param_00), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  triggerfx(var_01);
  level.zombiespawnfxcount++;
  common_scripts\utility::waittill_notify_or_timeout("death", 2);
  level.zombiespawnfxcount--;
  var_01 delete();
}

onislandstartgame() {
  initislandwavestories();
  level.var_7F22["normal"] = ::islandroundstart;
  level.var_7F22["zombie_dog"] = ::islandroundstart;
  level.var_7F18["normal"] = ::islandroundend;
  level.var_7F18["zombie_dog"] = ::islandroundend;
  lib_0547::remove_wallbuys_from_box();
}

initislandwavestories() {
  maps / mp / zombies / _zombies_audio_dlc1::initwavestories();
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_mari_rememberthoserangerswereh", 1];
  var_00[var_00.size] = ["zmb_isla_dros_idontknowmateimnotsuretha", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_dros_onceagainourdearleaderhas", 1];
  var_00[var_00.size] = ["zmb_isla_mari_isawtheintelthatrideauhad", 1];
  var_00[var_00.size] = ["zmb_isla_oliv_itwasfoolishtosendusintot", 1];
  var_00[var_00.size] = ["zmb_isla_jeff_rideauwassmarthewentaroun", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_oliv_youhatethisplacedrostanwh", 1];
  var_00[var_00.size] = ["zmb_isla_dros_youdontwanttotalkaboutthi", 1];
  var_00[var_00.size] = ["zmb_isla_jeff_manwantstokeephissecrets", 1];
  var_00[var_00.size] = ["zmb_isla_mari_thosesecretsmightbethekey", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_mari_thetimefordiscretionislon", 1];
  var_00[var_00.size] = ["zmb_isla_jeff_yeahnomoresecretsthisplac", 1];
  var_00[var_00.size] = ["zmb_isla_oliv_iclosemyeyesandicanfeelth", 1];
  var_00[var_00.size] = ["zmb_isla_dros_ohsoweregoingtohaveoursel", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_mari_fineilltalkillplayyourlit", 1];
  var_00[var_00.size] = ["zmb_isla_oliv_thisisnosecretmariemyself", 1];
  var_00[var_00.size] = ["zmb_isla_jeff_imasoldierivekilledthosep", 1];
  var_00[var_00.size] = ["zmb_isla_dros_whoayoureasicklotbastards", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_dros_finefineyaallconfessedtot", 1];
  var_00[var_00.size] = ["zmb_isla_mari_angrilyweknowthatpart", 1];
  var_00[var_00.size] = ["zmb_isla_dros_yawelliwashereatthereques", 1];
  var_00[var_00.size] = ["zmb_isla_mari_himmleryousonofabitchyouw", 1];
  var_00[var_00.size] = ["zmb_isla_dros_nowjustholdonmatethiswasb", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_oliv_whydidntyoutellusyounever", 1];
  var_00[var_00.size] = ["zmb_isla_dros_noneofusknewwhatwashappen", 1];
  var_00[var_00.size] = ["zmb_isla_oliv_youcouldhavesaidsomething", 1];
  var_00[var_00.size] = ["zmb_isla_dros_likewhatthatthesenazibast", 1];
  var_00[var_00.size] = ["zmb_isla_oliv_stillthereissomethingyour", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_jeff_talktousmananythingyoukno", 1];
  var_00[var_00.size] = ["zmb_isla_dros_rightwellasiwassayingearl", 1];
  var_00[var_00.size] = ["zmb_isla_jeff_sowhydidthenaziswantyouhe", 1];
  var_00[var_00.size] = ["zmb_isla_dros_theywantedmyperspectivewe", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_mari_sowhydidntyoumentionanyth", 1];
  var_00[var_00.size] = ["zmb_isla_dros_ididtorideauheknewandtold", 1];
  var_00[var_00.size] = ["zmb_isla_mari_beforeweknewmoreimgoingto", 1];
  var_00[var_00.size] = ["zmb_isla_dros_ifoundalotofbonescarvings", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_oliv_youdidntfindanythingfromb", 1];
  var_00[var_00.size] = ["zmb_isla_dros_notahairfoundsomenicepott", 1];
  var_00[var_00.size] = ["zmb_isla_oliv_whatdidthescrollssay", 1];
  var_00[var_00.size] = ["zmb_isla_dros_scribblesandravingsmostly", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_jeff_sohimmlerwasnthappywithyo", 1];
  var_00[var_00.size] = ["zmb_isla_dros_defensiveitwasntmyfaultic", 1];
  var_00[var_00.size] = ["zmb_isla_jeff_youcouldntgetthenaziswhat", 1];
  var_00[var_00.size] = ["zmb_isla_dros_ohisawhowthewindwasblowin", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_mari_comenowhimmlerissmarterth", 1];
  var_00[var_00.size] = ["zmb_isla_dros_iagreewithyalovebutaccide", 1];
  var_00[var_00.size] = ["zmb_isla_mari_hardtobelievetheydjustlet", 1];
  var_00[var_00.size] = ["zmb_isla_dros_wasnteasyespeciallythepar", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_oliv_yourobbedfromyourowndigsi", 1];
  var_00[var_00.size] = ["zmb_isla_dros_keepyerwigonistolefromnaz", 1];
  var_00[var_00.size] = ["zmb_isla_oliv_youarenotrobinhood", 1];
  var_00[var_00.size] = ["zmb_isla_dros_truerobinhoodwouldnthavek", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_jeff_whydidyoukeepthescrolltho", 1];
  var_00[var_00.size] = ["zmb_isla_dros_amanwholoveshisworkwhistl", 1];
  var_00[var_00.size] = ["zmb_isla_jeff_youstillhaveit", 1];
  var_00[var_00.size] = ["zmb_isla_dros_goingonabouttheartwonderf", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_mari_youstolesomescrollsfromhi", 1];
  var_00[var_00.size] = ["zmb_isla_dros_notreallythatswhyikeptitt", 1];
  var_00[var_00.size] = ["zmb_isla_mari_yourebeingmysteriousagain", 1];
  var_00[var_00.size] = ["zmb_isla_dros_yeahwelltheresmoreonthisi", 1];
  maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_isla_dros_ihatetobethebearerofbadne", 1];
  var_00[var_00.size] = ["zmb_isla_dros_thecavalry", 1];
  var_00[var_00.size] = ["zmb_isla_mari_itsthebritsdammititstooso", 1];
  var_00[var_00.size] = ["zmb_isla_dros_theyreapunctuallothopingt", 1];
  var_00[var_00.size] = ["zmb_isla_oliv_merdewewillhavetofindanot", 1];
  var_00[var_00.size] = ["zmb_isla_mari_whyisthat", 1];
  level.on_boss_finished_story = maps / mp / zombies / _zombies_audio_dlc1::addwavestory(var_00, 1, "final_boss_outro");
}

islandroundstart() {}

islandroundend() {
  level thread maps / mp / mp_zombie_island_ee_fog_manager::update_assassin_fog_count();
  level thread attempt_to_play_an_intermission_dialog_event();
}

attempt_to_play_an_intermission_dialog_event() {
  var_00 = randomint(4);
  switch (var_00) {
    case 0:
      level thread maps / mp / zombies / _zombies_audio_dlc1::playnextwavestory(undefined, undefined, [::try_play_weapon_nag]);
      break;

    case 1:
      level thread maps / mp / mp_zombie_island_straub_pa_events::play_next_straub_story();
      break;

    case 2:
      break;

    case 3:
      break;
  }
}

try_play_weapon_nag(param_00) {
  if(common_scripts\utility::func_562E(param_00) || level.var_A980 == 2 || level.var_A980 == 3 || level.var_A980 == 5) {
    nag_player_about_weapon_state_if_appropriate(common_scripts\utility::random(["weaponreminder", "weaponreminder2"]));
  }
}

nag_player_about_weapon_state_if_appropriate(param_00) {
  foreach(var_02 in level.players) {
    if(var_02 should_work_on_upgrading_gun()) {
      var_02 thread lib_0367::func_8E3C(param_00);
    }
  }
}

should_work_on_upgrading_gun() {
  var_00 = self getweaponslistprimaries();
  var_01 = [];
  var_01[var_01.size] = "m1911_zm";
  var_01[var_01.size] = "g43_zm";
  var_01[var_01.size] = "m712_zm";
  var_01[var_01.size] = "sten_zm";
  var_01[var_01.size] = "shovel_zm";
  var_02 = common_scripts\utility::func_F94(var_00, var_01);
  return var_02.size == 0;
}

func_5375() {
  lib_055A::init();
  lib_055A::func_530A("start_zone", 1);
  lib_055A::func_530A("isolated_room_entry_zone", 0);
  lib_055A::func_530A("isolated_room_zone", 0);
  level.zmb_registered_quest_zones = ["isolated_room_entry_zone", "isolated_room_zone"];
  lib_055A::func_530A("cart_tunnel_zone", 1);
  lib_055A::func_530A("climb_right_zone", 0);
  lib_055A::func_530A("corner_bluffs_zone", 0);
  lib_055A::func_530A("vista_beach_zone", 0);
  lib_055A::func_530A("vista_middle_zone", 0);
  lib_055A::func_530A("high_canon", 0);
  lib_055A::func_530A("mining_corner", 0);
  lib_055A::func_530A("vista_zone_3", 0);
  lib_055A::func_530A("sub_pens_1_zone", 0);
  lib_055A::func_993("start_zone", "climb_right_zone", "start_to_right_climb");
  lib_055A::func_993("high_canon", "vista_middle_zone", "high_canon_to_vista_mid");
  lib_055A::func_993("vista_middle_zone", "vista_zone_3", "middle_vista_to_vista_3");
  lib_055A::func_993("vista_zone_3", "mining_corner", "vista_3_to_mining");
  lib_055A::func_993("vista_zone_3", "corner_bluffs_zone", "corner_bluffs_to_vista_3");
  lib_055A::func_993("corner_bluffs_zone", "climb_right_zone", "right_climb_to_corner_bluffs");
  lib_055A::func_993("corner_bluffs_zone", "vista_beach_zone", "corner_bluffs_to_vista_beach");
  lib_055A::func_993("vista_beach_zone", "mining_corner", "vista_beach_to_mining");
  lib_055A::func_993("sub_pens_1_zone", "vista_beach_zone", "vista_beach_to_sub_pens_1");
  lib_055A::func_993("sub_pens_1_zone", "climb_right_zone", "right_climb_to_sub_pens_1");
  lib_055A::func_993("isolated_room_entry_zone", "isolated_room_zone", "isolated_entry_to_isolated");
  lib_055A::func_993("isolated_room_entry_zone", "cart_tunnel_zone", "zmb_secret_pomel_room_access_bomb_detonated");
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_TUNNELS", "start_to_right_climb", 0);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_TUNNELS", "start_to_right_climb", 1);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_CORNER", "right_climb_to_corner_bluffs", 0);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_CORNER", "right_climb_to_corner_bluffs", 1);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_SUBPENS", "right_climb_to_sub_pens_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_SUBPENS", "right_climb_to_sub_pens_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_VISTA_BEACH", "vista_beach_to_sub_pens_1", 0);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_SUBPENS", "vista_beach_to_sub_pens_1", 1);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_VISTA_BEACH", "corner_bluffs_to_vista_beach", 0);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_CORNER", "corner_bluffs_to_vista_beach", 1);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_VISTA_BEACH", "vista_beach_to_mining", 0);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_MINING", "vista_beach_to_mining", 1);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_MINING", "vista_3_to_mining", 0);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_OBERLAND", "vista_3_to_mining", 1);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_OBERLAND", "corner_bluffs_to_vista_3", 0);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_CORNER", "corner_bluffs_to_vista_3", 1);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_BUNKERS", "middle_vista_to_vista_3", 0);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_BUNKERS", "middle_vista_to_vista_3", 1);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_ARTILLERY", "high_canon_to_vista_mid", 0);
  lib_053F::func_7BE6(&"ZOMBIE_ISLAND_AREA_BUNKERS", "high_canon_to_vista_mid", 1);
  level thread sub_pens_door_listener1();
  level thread sub_pens_door_listener2();
  lib_055A::func_88A();
}

sub_pens_door_listener1() {
  common_scripts\utility::func_3C9F("vista_beach_to_sub_pens_1");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "right_climb_to_sub_pens_1" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

sub_pens_door_listener2() {
  common_scripts\utility::func_3C9F("right_climb_to_sub_pens_1");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "vista_beach_to_sub_pens_1" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

run_island_power_scriptable() {
  var_00 = function_021F("power_switch_island", "targetname");
  var_00 = var_00[0];
  var_00 setscriptablepartstate("cbreaker", "standby_idle");
  var_00 setscriptablepartstate("light_red", "on");
  var_00 setscriptablepartstate("light_green", "off");
  var_00 setscriptablepartstate("light_power", "off");
  var_00 setscriptablepartstate("light_graph", "off");
  common_scripts\utility::func_3C9F("power_sz2");
  level childthread common_scripts\_exploder::func_88E(227);
  level childthread common_scripts\_exploder::func_88E(228);
  level childthread common_scripts\_exploder::func_88E(229);
  var_00 setscriptablepartstate("cbreaker", "ready");
  var_00 setscriptablepartstate("light_red", "off");
  var_00 setscriptablepartstate("light_green", "on");
  var_00 setscriptablepartstate("light_power", "on");
  var_00 setscriptablepartstate("light_graph", "on");
}

run_island_power_lights_scriptable() {
  var_00 = function_021F("power_switch_island_lgt", "targetname");
  var_00 = var_00[0];
  var_00 setscriptablepartstate("light_bunker", "off");
  common_scripts\utility::func_3C9F("power_sz2");
  var_00 setscriptablepartstate("light_bunker", "on");
}

run_island_power_lights_scriptable3() {
  var_00 = function_021F("power_switch_island_lgt3", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "on");
  }

  common_scripts\utility::func_3C9F("power_sz2");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "off");
  }
}

run_island_power_lights_scriptable4() {
  var_00 = function_021F("power_switch_island_lgt4", "targetname");
  var_00 = var_00[0];
  var_00 setscriptablepartstate("lightpart", "flicker");
  common_scripts\utility::func_3C9F("power_sz2");
  var_00 setscriptablepartstate("lightpart", "flickerfast");
}

run_island_power_lights_scriptable5() {
  var_00 = function_021F("power_switch_island_lgt5", "targetname");
  var_00 = var_00[0];
  var_00 setscriptablepartstate("lightpart", "off");
  common_scripts\utility::func_3C9F("power_sz2");
  wait(1);
  var_00 setscriptablepartstate("lightpart", "flicker");
}

run_island_power_lights_scriptable6() {
  var_00 = function_021F("power_switch_island_lgt6", "targetname");
  var_00 = var_00[0];
  var_00 setscriptablepartstate("puzzlelight", "lightoff");
  common_scripts\utility::func_3C9F("power_sz2");
  wait(2);
  var_00 setscriptablepartstate("puzzlelight", "on");
}

run_island_power_lights_scriptable7() {
  var_00 = function_021F("power_switch_island_lgt7", "targetname");
  foreach(var_02 in var_00) {
    wait(0.61);
    var_02 setscriptablepartstate("puzzlelight", "lightoff");
  }

  common_scripts\utility::func_3C9F("power_sz2");
  foreach(var_02 in var_00) {
    wait(1);
    var_02 setscriptablepartstate("puzzlelight", "on");
  }
}

vista_beach_listener() {
  common_scripts\utility::func_3C9F("corner_bluffs_to_vista_beach");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "corner_bluffs_to_vista_beach" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

init_island_traps() {
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_sub", "active", ::maps / mp / mp_zombie_island_trap_2::trap_2);
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_spike", "active", ::maps / mp / mp_zombie_island_trap_1::trap_1);
  maps\mp\zombies\_zombies_traps::func_9CC7("trap_sub", &"ZOMBIE_ISLAND_ACTIVATE_PROP_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "prop");
  maps\mp\zombies\_zombies_traps::func_9CC7("trap_spike", &"ZOMBIE_ISLAND_ACTIVATE_SPIKE_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "spike");
  while(!isDefined(level.var_AC1D)) {
    wait 0.05;
  }

  var_00 = common_scripts\utility::func_46B5("trap_spike", "script_noteworthy");
  wait 0.05;
  var_00 maps\mp\zombies\_zombies_traps::func_9CC5("deactivate");
  foreach(var_02 in level.var_AC1D) {
    if(isDefined(var_02.script_linkname) && issubstr(var_02.script_linkname, "trap_rnd")) {
      var_02 waittill("open");
    }
  }

  var_00 maps\mp\zombies\_zombies_traps::func_9CC5("ready");
}

init_island_objectives() {
  setup_objective_flags();
  level thread maps / mp / mp_zombie_nest_ee_wave_manipulation::main();
  level thread maps / mp / zquests / casual / island_ee_main::init();
  level thread maps / mp / zquests / casual / island_ee_util::init_util();
  level thread maps / mp / zquests / hardcore / island_ee_hc::init();
  level thread maps / mp / mp_zombie_island_ee_pack_a_punch_unlock::init();
}

setup_objective_flags() {
  common_scripts\utility::flag_init("spawn_ships_ee_destroyer_attacker");
}

jump_scare_setup() {
  level thread func_3D8A();
  level thread func_3284();
  level thread func_1DA6();
  level thread func_1DA9();
  level thread sidestepjumpscare();
  level thread sidestepleftjumpscare();
}

func_3D8A() {
  var_00 = getEntArray("floor_burst_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::func_3D86();
  }
}

func_3284() {
  var_00 = getEntArray("door_burst_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::func_3266();
  }
}

func_1DA6() {
  var_00 = getEntArray("drop_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::func_1D91();
  }
}

func_1DA9() {
  var_00 = getEntArray("bunker_window_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_81A1)) {
      var_02 thread func_1706(var_02.var_81A1);
      continue;
    }

    var_02 thread lib_055B::func_1DA1();
  }
}

sidestepjumpscare() {
  var_00 = getEntArray("sidestep_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::sidestep_js_thinker();
  }
}

sidestepleftjumpscare() {
  var_00 = getEntArray("sidestep_left_jumpscare", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread lib_055B::sidestep_left_js_thinker();
  }
}

func_1706(param_00) {
  common_scripts\utility::func_3C9F(param_00);
  thread lib_055B::func_1DA1();
}

ambient_fx_trigger() {
  wait(1);
  level thread common_scripts\_exploder::func_88E(206);
  level childthread common_scripts\_exploder::func_88E(211);
}

ee_casual_plane_cliff_crash() {
  wait 0.05;
  level thread common_scripts\_exploder::func_88E(215);
}

init_new_zombie_types() {
  maps / mp / zombies / zombie_assassin::init();
}

init_assassin() {}

run_kill_barrier() {
  var_00 = getEnt("kill_barrier", "targetname");
  var_01 = common_scripts\utility::func_46B7("zmb_beach_test_spawns", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_02);
    if(isPlayer(var_02)) {
      var_02 setOrigin(var_01[0].origin);
    }
  }
}

createperkmachineicon(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_7E5D)) {
    self.var_7E5D destroy();
  }

  var_04 = newhudelem();
  var_04 setshader(param_00, param_01, param_02);
  var_04 setwaypoint(1, 1);
  var_04 settargetEnt(self);
  var_04.color = param_03;
  self.var_7E5D = var_04;
  return var_04;
}

initquestscollectibles() {
  var_00 = lib_0557::func_7838("Explore the Beach", "Survive the Beach");
  lib_0557::func_AB8C(var_00);
  common_scripts\utility::flag_init("zombie_island_power");
  lib_0547::func_3C8A("power_sz2", "zombie_island_power");
  lib_0557::func_AB8C("zombie_island_power");
  lib_0557::func_AB8C("flag_ranger_head_taken");
  lib_0557::func_AB8C("CORPSE_GATE");
  lib_0557::func_AB8C("players_have_razergun_1");
  lib_0557::func_AB8C("players_have_razergun_2");
  var_01 = lib_0557::func_7838("Aquire Wonder Weapon", "Melee Razor Gun Built");
  lib_0557::func_AB8C(var_01);
  lib_0557::func_AB8C("players_have_razergun_3");
  var_02 = lib_0557::func_7838("Aquire Wonder Weapon", "Ranged Razor Gun Built");
  lib_0557::func_AB8C(var_02);
  lib_0557::func_AB8C("any_minecart_used");
  lib_0557::func_AB8C("pap_elevator_arrived");
  lib_0557::func_AB8C("flag_radio_part_1_collected");
  lib_0557::func_AB8C("flag_radio_part_2_collected");
  var_03 = lib_0557::func_7838("Interact with radio", "Place Radio");
  lib_0557::func_AB8C(var_03);
  lib_0557::func_AB8C("flag_used_island_turret");
  lib_0557::func_AB8C("flag_ui_planes_ee_done");
  lib_0557::func_AB8C("flag_loaded_flak_cannon");
  lib_0557::func_AB8C("Destroy 2nd Destroyer");
  var_04 = lib_0557::func_7838("Final Boss Island", "Defeat Wustlings");
  lib_0557::func_AB8C(var_04);
  lib_0557::func_AB8C("flag_found_pommel_door");
  lib_0557::func_AB8C("flag_monk_head_found");
  lib_0557::func_AB8C("players_placed_statue_piece_1");
  lib_0557::func_AB8C("players_placed_statue_piece_2");
  lib_0557::func_AB8C("players_placed_statue_piece_3");
  lib_0557::func_AB8C("flag_sacrificed_assassin_spine");
  lib_0557::func_AB8C("flag_sacrificed_sprinter_spine");
  lib_0557::func_AB8C("flag_sacrificed_follower_spine");
  lib_0557::func_AB8C("flag_pommel_given");
}

func_5339() {
  lib_0557::func_786C();
  init_island_objectives();
  initquestscollectibles();
}

initweapons() {
  level.var_8AF = ::islandmaxammo;
}

islandmaxammo() {
  var_00 = self;
  var_01 = maps / mp / zombies / weapons / _zombie_razer_gun::get_razorgun_gunname();
  var_02 = var_00 getweaponslistall();
  foreach(var_04 in var_02) {
    if(isDefined(var_04) && issubstr(var_04, var_01)) {
      var_00 givemaxammo(var_04);
      var_05 = weaponclipsize(var_04);
      var_00 setweaponammoclip(var_04, var_05);
    }
  }
}

monitor_explored_zones_achievement() {
  level.explorationachievementzones = ["start_zone", "isolated_room_entry_zone", "isolated_room_zone", "cart_tunnel_zone", "climb_right_zone", "corner_bluffs_zone", "vista_beach_zone", "high_canon", "mining_corner", "vista_zone_3", "vista_middle_zone"];
  thread maps\mp\_utility::func_6F74(::monitor_explored_zones_player);
}

monitor_explored_zones_player() {
  self endon("disconnect");
  self.zonesleft = [];
  foreach(var_01 in level.explorationachievementzones) {
    self.zonesleft[var_01] = 1;
  }

  while(self.zonesleft.size > 0) {
    self waittill("zone_entered", var_01);
    self.zonesleft[var_01] = undefined;
  }

  maps / mp / gametypes / zombies::func_47C8("DLC1_ZM_ISLAND");
}

enemykilled_assassinachievement(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_01) || !isPlayer(param_01)) {
    return;
  }

  if(!maps / mp / mp_zombie_island_fog_behavior::is_in_a_fog_filled_zone()) {
    return;
  }

  if(!lib_0547::func_5565(self.var_A4B, "zombie_assassin")) {
    return;
  }

  if(!isDefined(param_01.assassin_fog_kills)) {
    param_01.assassin_fog_kills = 0;
  }

  param_01.assassin_fog_kills++;
  if(param_01.assassin_fog_kills == 1) {
    param_01 maps / mp / gametypes / zombies::func_47C8("DLC1_ZM_FOG");
  }
}