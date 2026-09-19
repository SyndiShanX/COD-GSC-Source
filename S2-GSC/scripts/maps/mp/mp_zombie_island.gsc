/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island.gsc
************************************************/

main() {
  level.zmb_uses_hint_notebook = 0;
  level.st_144545 = 1;
  level._id_AC2E = 3;
  level._id_A96A = 0.7;
  level.var_scaling_reach_min_wave = 15;
  level.var_scaling_reach_max_wave = 28;
  level.zmb_max_soul_collection_beams = 3;
  level.custom_camo_func_on = ::island_camo_vision_start;
  level.custom_camo_func_off = ::island_camo_vision_stop;
  level.st_142418 = 1;
  level._id_6BD5 = ::island_hc_kill_tracking;
  level._id_8B96 = ::zombies_players_secret_room_handle_ignore;
  level.custom_solo_zombie_sprint_rule = ::dont_solo_sprint_on_wave_0;
  level.use_zombie_unresolved_collision = 1;
  level.zmb_contracts_get_map_fog_state = maps\mp\mp_zombie_island_ee_fog_manager::get_is_fog_active;
  common_scripts\utility::flag_init("power_sz2");
  common_scripts\utility::flag_init("isolated_entry_to_isolated");
  level.cart_train_size = 2;
  level.quest_warp_table = "mp/questWarpValuesIsland.csv";
  level.quest_assert_no_hints = 1;
  level._id_2B7C = "shovel_zm";
  level._id_ABD3 = -500;
  level._id_0C11 = 0;
  level._id_783F = 0;
  level.door_data_out_of_date = 0;
  level.zmb_exempt_from_passive_list = ["zombie_assassin"];
  level.zombie_prevent_fx_play_func = ::preventzmbfxfunc;
  level.additional_revive_spot_handling_func = ::zmb_island_link_revive_ent_to_cart;
  level.additional_on_revive_end_func = ::zmb_island_cart_on_revive;
  level._id_A96B = ::_id_30D7;
  level.zmb_jumpscares_optional_cooldown_override_range = [12, 25];
  _id_055B::set_optional_new_cooldown();
  maps\mp\gametypes\zombies::register_addition_revive_rule(::separated_by_combat_event, ::debug_highlight_player_separation, "scr_hightLightPlayerSeparation");
  level.disable_jumpscare_playerdata = 0;
  level._id_6BB0 = ::onislandstartgame;
  level.wait_for_initial_fog_conditions_func = ::wait_for_initial_fog_conditions;
  level.zmb_custom_crawl_rule = ::dont_crawl_on_round_zero;
  level.means_of_skipping_rounds_func = maps\mp\mp_zombie_nest_ee_wave_manipulation::skiproundwait2;
  level.upgrade_machine_reveal_func = maps\mp\mp_zombie_island_ee_pack_a_punch_unlock::wait_for_upgrade_machine_arrived;
  maps\mp\mp_zombie_island_precache::main();
  maps\createart\mp_zombie_island_art::main();
  maps\createart\mp_zombie_island_fog_hdr::main();
  maps\mp\mp_zombie_island_fx::main();
  _id_0483::main();
  maps\mp\mp_zombie_island_lighting::main();
  maps\mp\mp_zombie_island_aud::main();
  _id_0496::init();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  maps\mp\zquests\casual\island_ee_main::init_difficulty_settings();
  _id_5375();
  _id_5339();
  initweapons();
  initialize_conditional_spawners();
  maps\mp\mp_zombies_attack_object::init();
  maps\mp\mp_zombie_island_straub_pa_events::init();
  level thread maps\mp\mp_zombie_falldamage_modifier::main();
  level thread _id_053D::init();
  level thread _id_0544::init();
  level thread _id_057D::_id_5162();
  level thread _id_0580::init();
  level thread maps\mp\mp_zombie_island_straub_apperances::main();
  level thread maps\mp\mp_zombie_island_cart::main();
  level thread maps\mp\zombies\weapons\_zombie_razer_gun::init();
  level thread maps\mp\mp_zombie_island_ee_fog_manager::init();
  level thread maps\mp\zombies\_zombies_audio_dlc1::initdlc1audio();

  if(maps\mp\_utility::isproductionlevelactive(10))
    level thread maps\mp\zombies\_zombies_lo_events::init_zm_lo_events();

  level.initnewzombietypes = ::init_new_zombie_types;
  setDvar("2494", "0.12, 0, 0");
  setDvar("4341", "0");
  level.scaretable = "mp/zombieJumpScareTableS2DLC1.csv";
  level thread jump_scare_setup();
  level thread init_island_traps();
  level thread maps\mp\zombies\weapons\_zombie_aoe_grenade::init();
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
  level._id_902A = ::_id_902A;
  level.zombiespawnfxcount = 0;
  level thread monitor_explored_zones_achievement();
  _id_0547::_id_7BA9(::enemykilled_assassinachievement);
  level thread maps\mp\mp_zombie_island_jumpscares::init();
  level thread maps\mp\zquests\dlc1_secrets_mp_zombie_island::init_dlc1_secrets_mp_zombie_island();
  level thread door_death_fix();
  level thread maps\mp\_utility::_id_6F74(::mute_audio_on_intro);
  level thread maps\mp\_utility::_id_6F74(::bunker_3_exploit_fix);
  level thread _id_0557::manage_mtx5_event();
}

bunker_3_exploit_fix() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = 50;
  var_2 = getEntArray("zmb_island_bunker_exploit_hammer", "targetname");
  var_3 = common_scripts\utility::_id_46B7("zmb_island_bunker_exploit_hammer_origin", "targetname");
  var_4 = common_scripts\utility::_id_46B5("zmb_island_bunker_exploit_hammer_y", "targetname");

  for(;;) {
    var_5 = 0;

    foreach(var_7 in var_2) {
      if(var_0 istouching(var_7)) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      if(!isDefined(var_0.bunker3count))
        var_0.bunker3count = 1;
      else
        var_0.bunker3count = var_0.bunker3count + 5;

      if(var_0.bunker3count >= var_1) {
        var_0.bunker3count = 0;
        var_9 = common_scripts\utility::_id_4461(var_0.origin, var_3);
        var_0 setOrigin(_func_2E1(var_9.origin, var_0), 1);
      }
    } else
      var_0.bunker3count = 0;

    for(var_10 = 0; var_10 < 5; var_10++)
      waitframe();
  }
}

debug_highlight_player_separation() {}

separated_by_combat_event(var_0, var_1) {
  if(!common_scripts\utility::_id_562E(level.zmb_lockdown_event_active))
    return 0;

  var_2 = common_scripts\utility::_id_562E(var_0.participatinginevent) == common_scripts\utility::_id_562E(var_1.participatinginevent);
  return !var_2;
}

door_death_fix() {
  while(!isDefined(level._id_AC1D))
    waitframe();

  add_zombie_door_collision_handling("start_to_right_climb", 1, 0);
}

add_zombie_door_collision_handling(var_0, var_1, var_2) {
  var_3 = get_zombie_door(var_0);

  foreach(var_5 in var_3._id_64C5)
  var_3 thread assign_collision_handling(var_5, var_1, var_2);
}

get_zombie_door(var_0) {
  foreach(var_2 in level._id_AC1D) {
    if(_id_0547::_id_5565(var_2.getnegotiationnextnode, var_0))
      return var_2;
  }
}

assign_collision_handling(var_0, var_1, var_2) {
  var_0._id_A048 = [];
  var_3 = 2;

  foreach(var_5 in self.setclientdvars) {
    if(common_scripts\utility::_id_562E(var_1))
      var_0 assign_door_collision_node(var_5, 1);

    if(common_scripts\utility::_id_562E(var_2))
      var_0 assign_door_collision_node(var_5, 0);
  }

  var_0._id_A045 = ::zmi_door_collision_handler;
}

assign_door_collision_node(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = _func_2E1(var_0.origin + _pow(-1, !common_scripts\utility::_id_562E(var_1)) * 32 * vectorNormalize(anglestoright(var_0.angles)));
  self._id_A048 = common_scripts\utility::_id_0F6F(self._id_A048, var_2);
}

zmi_door_collision_handler(var_0) {
  _id_0488::_id_A047(var_0, 0);
}

dont_solo_sprint_on_wave_0() {
  return !_id_0547::_id_5565(level._id_A980, 0);
}

agent_is_in_secret_room(var_0) {
  var_1 = undefined;

  if(common_scripts\utility::_id_562E(var_0) && !common_scripts\utility::_id_562E(self.wasteleported))
    var_1 = _id_0547::_id_5565(self._id_9024, "isolated_room_zone") || _id_0547::_id_5565(self._id_9024, "isolated_room_entry_zone");

  return common_scripts\utility::_id_562E(var_1) || _id_055A::_id_AC29(self, "isolated_room_zone") || _id_055A::_id_AC29(self, "isolated_room_entry_zone");
}

zombies_players_secret_room_handle_ignore(var_0) {
  if(!isPlayer(var_0))
    return 0;

  var_1 = agents_are_separated(var_0, self);
  return var_1;
}

agents_are_separated(var_0, var_1) {
  return var_1 agent_is_in_secret_room(1) != var_0 agent_is_in_secret_room();
}

island_hc_kill_tracking(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
  if(!isDefined(level.zmb_hc_subpens_kills))
    level.zmb_hc_subpens_kills = 0;

  if(common_scripts\utility::_id_562E(self.participatinginevent) && common_scripts\utility::_id_562E(var_0.participatinginevent))
    level.zmb_hc_subpens_kills++;
}

mute_audio_on_intro() {
  self clientaddsoundsubmix("isl_intro_movie");

  while(!level.gamehasstarted)
    waitframe();

  self clientclearsoundsubmix("isl_intro_movie");
}

collect_all_lore() {
  var_0 = getEntArray("lore_primary", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = _getent(var_2.target, "targetname");
    var_3 notify("trigger", level.player);
    wait 0.2;
  }
}

initialize_conditional_spawners() {
  var_0 = common_scripts\utility::_id_46B7("zombie_spawner", "script_noteworthy");

  if(!isDefined(level.zmb_isl_conditional_boss_spawns))
    level.zmb_isl_conditional_boss_spawns = [];

  if(!isDefined(level.zmb_isl_conditional_cart_spawns)) {
    level.zmb_isl_conditional_cart_spawns = spawnStruct();
    level.zmb_isl_conditional_cart_spawns._id_905E = [];
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2.weaponlocktargettooclose) && issubstr(var_2.weaponlocktargettooclose, "boss_fight_disable"))
      level.zmb_isl_conditional_boss_spawns = common_scripts\utility::_id_0F6F(level.zmb_isl_conditional_boss_spawns, var_2);

    if(isDefined(var_2.weaponlocktargettooclose) && issubstr(var_2.weaponlocktargettooclose, "needs_cart_stationed")) {
      var_2.is_zombies_spawner_script_disabled = 1;
      var_3 = strtok(var_2.weaponlocktargettooclose, ",");

      if(!isDefined(level.zmb_isl_conditional_cart_spawns._id_905E[var_3[1]]))
        level.zmb_isl_conditional_cart_spawns._id_905E[var_3[1]] = [];

      level.zmb_isl_conditional_cart_spawns._id_905E[var_3[1]] = common_scripts\utility::_id_0F6F(level.zmb_isl_conditional_cart_spawns._id_905E[var_3[1]], var_2);
    }
  }
}

dont_crawl_on_round_zero(var_0) {
  if(level._id_A980 > 0)
    return var_0;
  else
    return 5;
}

_id_30D7() {}

zmb_island_link_revive_ent_to_cart(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_1.oncartride)) {
    var_0 delete();
    return level.zmb_island_artillery_sled;
  } else
    return var_0;
}

zmb_island_cart_on_revive(var_0, var_1, var_2) {
  if(isDefined(var_0) && maps\mp\_utility::isreallyalive(var_0)) {
    if(!common_scripts\utility::_id_562E(var_0.oncartride))
      var_0 unlink();

    if(var_1)
      var_0 common_scripts\utility::_id_0616();
  }
}

island_camo_vision_start() {
  self setclutforplayer("clut_mp_zombie_island_camo", 0.25);
}

island_camo_vision_stop() {
  self setclutforplayer("clut_mp_zombie_island", 0.25);
}

wait_for_initial_fog_conditions() {
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("Explore the Beach", "Survive the Beach"));
  level thread timeout_door_buy(600);
  level endon("doorbuy_timeout");
  var_0 = [];

  foreach(var_2 in level._id_AC1D) {
    if(isDefined(var_2._id_0164) && issubstr(var_2._id_0164, "assassin_wait"))
      var_0[var_0.size] = var_2;
  }

  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(!common_scripts\utility::_id_562E(var_2._id_6BE1))
        var_2 waittill("open");
    }
  } else {}

  var_6 = level._id_A980 + randomint(1);

  while(level._id_A980 < var_6)
    wait 0.125;
}

timeout_door_buy(var_0) {
  wait(var_0);
  level notify("doorbuy_timeout");
}

preventzmbfxfunc() {
  var_0 = ["zombie_assassin"];
  return common_scripts\utility::_id_0F79(var_0, self._id_0A4B);
}

_id_902A(var_0) {
  if(_id_0547::_id_5565(self._id_0A4B, "zombie_assassin"))
    return::assassin_scare_landing;

  if(isDefined(var_0.weaponlocktargettooclose)) {
    switch (var_0.weaponlocktargettooclose) {
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

assassin_scare_landing(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "land":
      _id_0378::_id_8D74("js_assassin_landing");
      break;
  }
}

dirtspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event")
    thread zombiespawnfx("zmb_spawn_dirt");
}

mudspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event")
    thread zombiespawnfx("zmb_spawn_mud");
}

concretespawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event")
    thread zombiespawnfx("zmb_spawn_concrete");
}

sandspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event")
    thread zombiespawnfx("zmb_spawn_sand");
}

waterspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_water");
    thread zombiedripfx("zmb_spawn_water");
  }
}

zombiedripfx(var_0) {
  if(level._id_A980 >= 20) {
    return;
  }
  var_1 = "spawn_water_drip";

  if(isDefined(var_0))
    var_1 = var_0 + "_drip";

  var_2 = ["J_Shoulder_RI", "J_Shoulder_LE", "J_Hip_LE", "J_Hip_RI", "J_Head"];

  foreach(var_5 in var_2) {
    if(isDefined(self gettagorigin(var_5)))
      _id_0547::_id_74A5(common_scripts\utility::_id_44F5(var_1), self, var_5);
  }

  zombiedripfxcleanup(var_2, var_1);
}

zombiedripfxcleanup(var_0, var_1) {
  self endon("death");

  while(isDefined(self) && isalive(self)) {
    wait 0.1;

    if(!isDefined(self._id_53D9) || !self._id_53D9) {
      break;
    }
  }

  wait(_randomfloatrange(5.0, 15.0));

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  foreach(var_3 in var_0) {
    if(isDefined(self gettagorigin(var_3)))
      _id_0547::_id_9406(common_scripts\utility::_id_44F5(var_1), self, var_3);
  }
}

zombiespawnfx(var_0) {
  if(level.zombiespawnfxcount >= 12) {
    return;
  }
  var_1 = _spawnfx(common_scripts\utility::_id_44F5(var_0), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  _triggerfx(var_1);
  level.zombiespawnfxcount++;
  common_scripts\utility::waittill_notify_or_timeout("death", 2.0);
  level.zombiespawnfxcount--;
  var_1 delete();
}

onislandstartgame() {
  initislandwavestories();
  level._id_7F22["normal"] = ::islandroundstart;
  level._id_7F22["zombie_dog"] = ::islandroundstart;
  level._id_7F18["normal"] = ::islandroundend;
  level._id_7F18["zombie_dog"] = ::islandroundend;
  _id_0547::remove_wallbuys_from_box();
}

initislandwavestories() {
  maps\mp\zombies\_zombies_audio_dlc1::initwavestories();
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_mari_rememberthoserangerswereh", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_idontknowmateimnotsuretha", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_dros_onceagainourdearleaderhas", 1.0];
  var_0[var_0.size] = ["zmb_isla_mari_isawtheintelthatrideauhad", 1.0];
  var_0[var_0.size] = ["zmb_isla_oliv_itwasfoolishtosendusintot", 1.0];
  var_0[var_0.size] = ["zmb_isla_jeff_rideauwassmarthewentaroun", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_oliv_youhatethisplacedrostanwh", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_youdontwanttotalkaboutthi", 1.0];
  var_0[var_0.size] = ["zmb_isla_jeff_manwantstokeephissecrets", 1.0];
  var_0[var_0.size] = ["zmb_isla_mari_thosesecretsmightbethekey", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_mari_thetimefordiscretionislon", 1.0];
  var_0[var_0.size] = ["zmb_isla_jeff_yeahnomoresecretsthisplac", 1.0];
  var_0[var_0.size] = ["zmb_isla_oliv_iclosemyeyesandicanfeelth", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_ohsoweregoingtohaveoursel", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_mari_fineilltalkillplayyourlit", 1.0];
  var_0[var_0.size] = ["zmb_isla_oliv_thisisnosecretmariemyself", 1.0];
  var_0[var_0.size] = ["zmb_isla_jeff_imasoldierivekilledthosep", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_whoayoureasicklotbastards", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_dros_finefineyaallconfessedtot", 1.0];
  var_0[var_0.size] = ["zmb_isla_mari_angrilyweknowthatpart", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_yawelliwashereatthereques", 1.0];
  var_0[var_0.size] = ["zmb_isla_mari_himmleryousonofabitchyouw", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_nowjustholdonmatethiswasb", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_oliv_whydidntyoutellusyounever", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_noneofusknewwhatwashappen", 1.0];
  var_0[var_0.size] = ["zmb_isla_oliv_youcouldhavesaidsomething", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_likewhatthatthesenazibast", 1.0];
  var_0[var_0.size] = ["zmb_isla_oliv_stillthereissomethingyour", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_jeff_talktousmananythingyoukno", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_rightwellasiwassayingearl", 1.0];
  var_0[var_0.size] = ["zmb_isla_jeff_sowhydidthenaziswantyouhe", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_theywantedmyperspectivewe", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_mari_sowhydidntyoumentionanyth", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_ididtorideauheknewandtold", 1.0];
  var_0[var_0.size] = ["zmb_isla_mari_beforeweknewmoreimgoingto", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_ifoundalotofbonescarvings", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_oliv_youdidntfindanythingfromb", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_notahairfoundsomenicepott", 1.0];
  var_0[var_0.size] = ["zmb_isla_oliv_whatdidthescrollssay", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_scribblesandravingsmostly", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_jeff_sohimmlerwasnthappywithyo", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_defensiveitwasntmyfaultic", 1.0];
  var_0[var_0.size] = ["zmb_isla_jeff_youcouldntgetthenaziswhat", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_ohisawhowthewindwasblowin", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_mari_comenowhimmlerissmarterth", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_iagreewithyalovebutaccide", 1.0];
  var_0[var_0.size] = ["zmb_isla_mari_hardtobelievetheydjustlet", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_wasnteasyespeciallythepar", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_oliv_yourobbedfromyourowndigsi", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_keepyerwigonistolefromnaz", 1.0];
  var_0[var_0.size] = ["zmb_isla_oliv_youarenotrobinhood", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_truerobinhoodwouldnthavek", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_jeff_whydidyoukeepthescrolltho", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_amanwholoveshisworkwhistl", 1.0];
  var_0[var_0.size] = ["zmb_isla_jeff_youstillhaveit", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_goingonabouttheartwonderf", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_mari_youstolesomescrollsfromhi", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_notreallythatswhyikeptitt", 1.0];
  var_0[var_0.size] = ["zmb_isla_mari_yourebeingmysteriousagain", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_yeahwelltheresmoreonthisi", 1.0];
  maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_isla_dros_ihatetobethebearerofbadne", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_thecavalry", 1.0];
  var_0[var_0.size] = ["zmb_isla_mari_itsthebritsdammititstooso", 1.0];
  var_0[var_0.size] = ["zmb_isla_dros_theyreapunctuallothopingt", 1.0];
  var_0[var_0.size] = ["zmb_isla_oliv_merdewewillhavetofindanot", 1.0];
  var_0[var_0.size] = ["zmb_isla_mari_whyisthat", 1.0];
  level.on_boss_finished_story = maps\mp\zombies\_zombies_audio_dlc1::addwavestory(var_0, 1, "final_boss_outro");
}

islandroundstart() {}

islandroundend() {
  level thread maps\mp\mp_zombie_island_ee_fog_manager::update_assassin_fog_count();
  level thread attempt_to_play_an_intermission_dialog_event();
}

attempt_to_play_an_intermission_dialog_event() {
  var_0 = randomint(4);

  switch (var_0) {
    case 0:
      level thread maps\mp\zombies\_zombies_audio_dlc1::playnextwavestory(undefined, undefined, [::try_play_weapon_nag]);
      break;
    case 1:
      level thread maps\mp\mp_zombie_island_straub_pa_events::play_next_straub_story();
      break;
    case 2:
      break;
    case 3:
      break;
  }
}

try_play_weapon_nag(var_0) {
  if(common_scripts\utility::_id_562E(var_0) || level._id_A980 == 2 || level._id_A980 == 3 || level._id_A980 == 5)
    nag_player_about_weapon_state_if_appropriate(common_scripts\utility::random(["weaponreminder", "weaponreminder2"]));
}

nag_player_about_weapon_state_if_appropriate(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 should_work_on_upgrading_gun())
      var_2 thread _id_0367::_id_8E3C(var_0);
  }
}

should_work_on_upgrading_gun() {
  var_0 = self getweaponlistprimaries();
  var_1 = [];
  var_1[var_1.size] = "m1911_zm";
  var_1[var_1.size] = "g43_zm";
  var_1[var_1.size] = "m712_zm";
  var_1[var_1.size] = "sten_zm";
  var_1[var_1.size] = "shovel_zm";
  var_2 = common_scripts\utility::_id_0F94(var_0, var_1);
  return var_2.size == 0;
}

_id_5375() {
  _id_055A::init();
  _id_055A::_id_530A("start_zone", 1);
  _id_055A::_id_530A("isolated_room_entry_zone", 0);
  _id_055A::_id_530A("isolated_room_zone", 0);
  level.zmb_registered_quest_zones = ["isolated_room_entry_zone", "isolated_room_zone"];
  _id_055A::_id_530A("cart_tunnel_zone", 1);
  _id_055A::_id_530A("climb_right_zone", 0);
  _id_055A::_id_530A("corner_bluffs_zone", 0);
  _id_055A::_id_530A("vista_beach_zone", 0);
  _id_055A::_id_530A("vista_middle_zone", 0);
  _id_055A::_id_530A("high_canon", 0);
  _id_055A::_id_530A("mining_corner", 0);
  _id_055A::_id_530A("vista_zone_3", 0);
  _id_055A::_id_530A("sub_pens_1_zone", 0);
  _id_055A::_id_0993("start_zone", "climb_right_zone", "start_to_right_climb");
  _id_055A::_id_0993("high_canon", "vista_middle_zone", "high_canon_to_vista_mid");
  _id_055A::_id_0993("vista_middle_zone", "vista_zone_3", "middle_vista_to_vista_3");
  _id_055A::_id_0993("vista_zone_3", "mining_corner", "vista_3_to_mining");
  _id_055A::_id_0993("vista_zone_3", "corner_bluffs_zone", "corner_bluffs_to_vista_3");
  _id_055A::_id_0993("corner_bluffs_zone", "climb_right_zone", "right_climb_to_corner_bluffs");
  _id_055A::_id_0993("corner_bluffs_zone", "vista_beach_zone", "corner_bluffs_to_vista_beach");
  _id_055A::_id_0993("vista_beach_zone", "mining_corner", "vista_beach_to_mining");
  _id_055A::_id_0993("sub_pens_1_zone", "vista_beach_zone", "vista_beach_to_sub_pens_1");
  _id_055A::_id_0993("sub_pens_1_zone", "climb_right_zone", "right_climb_to_sub_pens_1");
  _id_055A::_id_0993("isolated_room_entry_zone", "isolated_room_zone", "isolated_entry_to_isolated");
  _id_055A::_id_0993("isolated_room_entry_zone", "cart_tunnel_zone", "zmb_secret_pomel_room_access_bomb_detonated");
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_TUNNELS", "start_to_right_climb", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_TUNNELS", "start_to_right_climb", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_CORNER", "right_climb_to_corner_bluffs", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_CORNER", "right_climb_to_corner_bluffs", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_SUBPENS", "right_climb_to_sub_pens_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_SUBPENS", "right_climb_to_sub_pens_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_VISTA_BEACH", "vista_beach_to_sub_pens_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_SUBPENS", "vista_beach_to_sub_pens_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_VISTA_BEACH", "corner_bluffs_to_vista_beach", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_CORNER", "corner_bluffs_to_vista_beach", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_VISTA_BEACH", "vista_beach_to_mining", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_MINING", "vista_beach_to_mining", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_MINING", "vista_3_to_mining", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_OBERLAND", "vista_3_to_mining", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_OBERLAND", "corner_bluffs_to_vista_3", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_CORNER", "corner_bluffs_to_vista_3", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_BUNKERS", "middle_vista_to_vista_3", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_BUNKERS", "middle_vista_to_vista_3", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_ARTILLERY", "high_canon_to_vista_mid", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_ISLAND_AREA_BUNKERS", "high_canon_to_vista_mid", 1);
  level thread sub_pens_door_listener1();
  level thread sub_pens_door_listener2();
  _id_055A::_id_088A();
}

sub_pens_door_listener1() {
  common_scripts\utility::_id_3C9F("vista_beach_to_sub_pens_1");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1.getnegotiationnextnode) && var_1.getnegotiationnextnode == "right_climb_to_sub_pens_1" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1))
      var_1 notify("open", undefined);
  }
}

sub_pens_door_listener2() {
  common_scripts\utility::_id_3C9F("right_climb_to_sub_pens_1");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1.getnegotiationnextnode) && var_1.getnegotiationnextnode == "vista_beach_to_sub_pens_1" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1))
      var_1 notify("open", undefined);
  }
}

run_island_power_scriptable() {
  var_0 = _getscriptablearray("power_switch_island", "targetname");
  var_0 = var_0[0];
  var_0 setscriptablepartstate("cbreaker", "standby_idle");
  var_0 setscriptablepartstate("light_red", "on");
  var_0 setscriptablepartstate("light_green", "off");
  var_0 setscriptablepartstate("light_power", "off");
  var_0 setscriptablepartstate("light_graph", "off");
  common_scripts\utility::_id_3C9F("power_sz2");
  level childthread common_scripts\_exploder::_id_088E(227);
  level childthread common_scripts\_exploder::_id_088E(228);
  level childthread common_scripts\_exploder::_id_088E(229);
  var_0 setscriptablepartstate("cbreaker", "ready");
  var_0 setscriptablepartstate("light_red", "off");
  var_0 setscriptablepartstate("light_green", "on");
  var_0 setscriptablepartstate("light_power", "on");
  var_0 setscriptablepartstate("light_graph", "on");
}

run_island_power_lights_scriptable() {
  var_0 = _getscriptablearray("power_switch_island_lgt", "targetname");
  var_0 = var_0[0];
  var_0 setscriptablepartstate("light_bunker", "off");
  common_scripts\utility::_id_3C9F("power_sz2");
  var_0 setscriptablepartstate("light_bunker", "on");
}

run_island_power_lights_scriptable3() {
  var_0 = _getscriptablearray("power_switch_island_lgt3", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("lightpart", "on");

  common_scripts\utility::_id_3C9F("power_sz2");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("lightpart", "off");
}

run_island_power_lights_scriptable4() {
  var_0 = _getscriptablearray("power_switch_island_lgt4", "targetname");
  var_0 = var_0[0];
  var_0 setscriptablepartstate("lightpart", "flicker");
  common_scripts\utility::_id_3C9F("power_sz2");
  var_0 setscriptablepartstate("lightpart", "flickerfast");
}

run_island_power_lights_scriptable5() {
  var_0 = _getscriptablearray("power_switch_island_lgt5", "targetname");
  var_0 = var_0[0];
  var_0 setscriptablepartstate("lightpart", "off");
  common_scripts\utility::_id_3C9F("power_sz2");
  wait 1;
  var_0 setscriptablepartstate("lightpart", "flicker");
}

run_island_power_lights_scriptable6() {
  var_0 = _getscriptablearray("power_switch_island_lgt6", "targetname");
  var_0 = var_0[0];
  var_0 setscriptablepartstate("puzzlelight", "lightoff");
  common_scripts\utility::_id_3C9F("power_sz2");
  wait 2;
  var_0 setscriptablepartstate("puzzlelight", "on");
}

run_island_power_lights_scriptable7() {
  var_0 = _getscriptablearray("power_switch_island_lgt7", "targetname");

  foreach(var_2 in var_0) {
    wait 0.61;
    var_2 setscriptablepartstate("puzzlelight", "lightoff");
  }

  common_scripts\utility::_id_3C9F("power_sz2");

  foreach(var_2 in var_0) {
    wait 1;
    var_2 setscriptablepartstate("puzzlelight", "on");
  }
}

vista_beach_listener() {
  common_scripts\utility::_id_3C9F("corner_bluffs_to_vista_beach");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1.getnegotiationnextnode) && var_1.getnegotiationnextnode == "corner_bluffs_to_vista_beach" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1))
      var_1 notify("open", undefined);
  }
}

init_island_traps() {
  thread _id_0546::_id_9CC6("trap_sub", "active", maps\mp\mp_zombie_island_trap_2::trap_2);
  thread _id_0546::_id_9CC6("trap_spike", "active", maps\mp\mp_zombie_island_trap_1::trap_1);
  _id_0546::_id_9CC7("trap_sub", &"ZOMBIE_ISLAND_ACTIVATE_PROP_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "prop");
  _id_0546::_id_9CC7("trap_spike", &"ZOMBIE_ISLAND_ACTIVATE_SPIKE_TRAP", &"ZOMBIES_TRAP_COOLDOWN", "spike");

  while(!isDefined(level._id_AC1D))
    waitframe();

  var_0 = common_scripts\utility::_id_46B5("trap_spike", "script_noteworthy");
  waitframe();
  var_0 _id_0546::_id_9CC5("deactivate");

  foreach(var_2 in level._id_AC1D) {
    if(isDefined(var_2._id_0164) && issubstr(var_2._id_0164, "trap_rnd"))
      var_2 waittill("open");
  }

  var_0 _id_0546::_id_9CC5("ready");
}

init_island_objectives() {
  setup_objective_flags();
  level thread maps\mp\mp_zombie_nest_ee_wave_manipulation::main();
  level thread maps\mp\zquests\casual\island_ee_main::init();
  level thread maps\mp\zquests\casual\island_ee_util::init_util();
  level thread maps\mp\zquests\hardcore\island_ee_hc::init();
  level thread maps\mp\mp_zombie_island_ee_pack_a_punch_unlock::init();
}

setup_objective_flags() {
  common_scripts\utility::flag_init("spawn_ships_ee_destroyer_attacker");
}

jump_scare_setup() {
  level thread _id_3D8A();
  level thread _id_3284();
  level thread _id_1DA6();
  level thread _id_1DA9();
  level thread sidestepjumpscare();
  level thread sidestepleftjumpscare();
}

_id_3D8A() {
  var_0 = getEntArray("floor_burst_jumpscare", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_055B::_id_3D86();
}

_id_3284() {
  var_0 = getEntArray("door_burst_jumpscare", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_055B::_id_3266();
}

_id_1DA6() {
  var_0 = getEntArray("drop_jumpscare", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_055B::_id_1D91();
}

_id_1DA9() {
  var_0 = getEntArray("bunker_window_jumpscare", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.setgoalnode)) {
      var_2 thread _id_1706(var_2.setgoalnode);
      continue;
    }

    var_2 thread _id_055B::_id_1DA1();
  }
}

sidestepjumpscare() {
  var_0 = getEntArray("sidestep_jumpscare", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_055B::sidestep_js_thinker();
}

sidestepleftjumpscare() {
  var_0 = getEntArray("sidestep_left_jumpscare", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_055B::sidestep_left_js_thinker();
}

_id_1706(var_0) {
  common_scripts\utility::_id_3C9F(var_0);
  thread _id_055B::_id_1DA1();
}

ambient_fx_trigger() {
  wait 1;
  level thread common_scripts\_exploder::_id_088E(206);
  level childthread common_scripts\_exploder::_id_088E(211);
}

ee_casual_plane_cliff_crash() {
  waitframe();
  level thread common_scripts\_exploder::_id_088E(215);
}

init_new_zombie_types() {
  maps\mp\zombies\zombie_assassin::init();
}

init_assassin() {}

run_kill_barrier() {
  var_0 = _getent("kill_barrier", "targetname");
  var_1 = common_scripts\utility::_id_46B7("zmb_beach_test_spawns", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2))
      var_2 setOrigin(var_1[0].origin);
  }
}

createperkmachineicon(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_7E5D))
    self._id_7E5D destroy();

  var_4 = newhudelem();
  var_4 setshader(var_0, var_1, var_2);
  var_4 setwaypoint(1, 1);
  var_4 settargetent(self);
  var_4.color = var_3;
  self._id_7E5D = var_4;
  return var_4;
}

initquestscollectibles() {
  var_0 = _id_0557::_id_7838("Explore the Beach", "Survive the Beach");
  _id_0557::_id_AB8C(var_0);
  common_scripts\utility::flag_init("zombie_island_power");
  _id_0547::_id_3C8A("power_sz2", "zombie_island_power");
  _id_0557::_id_AB8C("zombie_island_power");
  _id_0557::_id_AB8C("flag_ranger_head_taken");
  _id_0557::_id_AB8C("CORPSE_GATE");
  _id_0557::_id_AB8C("players_have_razergun_1");
  _id_0557::_id_AB8C("players_have_razergun_2");
  var_1 = _id_0557::_id_7838("Aquire Wonder Weapon", "Melee Razor Gun Built");
  _id_0557::_id_AB8C(var_1);
  _id_0557::_id_AB8C("players_have_razergun_3");
  var_2 = _id_0557::_id_7838("Aquire Wonder Weapon", "Ranged Razor Gun Built");
  _id_0557::_id_AB8C(var_2);
  _id_0557::_id_AB8C("any_minecart_used");
  _id_0557::_id_AB8C("pap_elevator_arrived");
  _id_0557::_id_AB8C("flag_radio_part_1_collected");
  _id_0557::_id_AB8C("flag_radio_part_2_collected");
  var_3 = _id_0557::_id_7838("Interact with radio", "Place Radio");
  _id_0557::_id_AB8C(var_3);
  _id_0557::_id_AB8C("flag_used_island_turret");
  _id_0557::_id_AB8C("flag_ui_planes_ee_done");
  _id_0557::_id_AB8C("flag_loaded_flak_cannon");
  _id_0557::_id_AB8C("Destroy 2nd Destroyer");
  var_4 = _id_0557::_id_7838("Final Boss Island", "Defeat Wustlings");
  _id_0557::_id_AB8C(var_4);
  _id_0557::_id_AB8C("flag_found_pommel_door");
  _id_0557::_id_AB8C("flag_monk_head_found");
  _id_0557::_id_AB8C("players_placed_statue_piece_1");
  _id_0557::_id_AB8C("players_placed_statue_piece_2");
  _id_0557::_id_AB8C("players_placed_statue_piece_3");
  _id_0557::_id_AB8C("flag_sacrificed_assassin_spine");
  _id_0557::_id_AB8C("flag_sacrificed_sprinter_spine");
  _id_0557::_id_AB8C("flag_sacrificed_follower_spine");
  _id_0557::_id_AB8C("flag_pommel_given");
}

_id_5339() {
  _id_0557::_id_786C();
  init_island_objectives();
  initquestscollectibles();
}

initweapons() {
  level._id_08AF = ::islandmaxammo;
}

islandmaxammo() {
  var_0 = self;
  var_1 = maps\mp\zombies\weapons\_zombie_razer_gun::get_razorgun_gunname();
  var_2 = var_0 getweaponlistall();

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && issubstr(var_4, var_1)) {
      var_0 givemaxammo(var_4);
      var_5 = _weaponclipsize(var_4);
      var_0 setweaponammoclip(var_4, var_5);
    }
  }
}

monitor_explored_zones_achievement() {
  level.explorationachievementzones = ["start_zone", "isolated_room_entry_zone", "isolated_room_zone", "cart_tunnel_zone", "climb_right_zone", "corner_bluffs_zone", "vista_beach_zone", "high_canon", "mining_corner", "vista_zone_3", "vista_middle_zone"];
  thread maps\mp\_utility::_id_6F74(::monitor_explored_zones_player);
}

monitor_explored_zones_player() {
  self endon("disconnect");
  self.zonesleft = [];

  foreach(var_1 in level.explorationachievementzones)
  self.zonesleft[var_1] = 1;

  while(self.zonesleft.size > 0) {
    self waittill("zone_entered", var_1);
    self.zonesleft[var_1] = undefined;
  }

  maps\mp\gametypes\zombies::_id_47C8("DLC1_ZM_ISLAND");
}

enemykilled_assassinachievement(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  if(!maps\mp\mp_zombie_island_fog_behavior::is_in_a_fog_filled_zone()) {
    return;
  }
  if(!_id_0547::_id_5565(self._id_0A4B, "zombie_assassin")) {
    return;
  }
  if(!isDefined(var_1.assassin_fog_kills))
    var_1.assassin_fog_kills = 0;

  var_1.assassin_fog_kills++;

  if(var_1.assassin_fog_kills == 1)
    var_1 maps\mp\gametypes\zombies::_id_47C8("DLC1_ZM_FOG");
}