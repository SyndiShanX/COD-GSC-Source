/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_final_boss.gsc
************************************************************/

init() {
  scripts\engine\utility::flag_init("meph_fight");
  level.fbd = spawnStruct();
  var_0 = level.fbd;
  var_0.soulprojectilemonitorfunc = ::soulprojectilemonitor;
  var_0.soulprojectiledeathfunc = ::soulprojectiledeathmonitor;
  initfx();
  var_0.circles = scripts\engine\utility::getstructarray("capture_points", "targetname");
  var_0.activatedcircles = [];
  foreach(var_3, var_2 in var_0.circles) {
    var_2.var_3CB7 = 0;
    var_2.buffer = 0;
    var_2.state = "DORMANT";
    var_2.model = spawn("script_model", var_2.origin + (0, 0, 3));
    var_2.model setModel("tag_origin_ritual_circle_0" + var_3 + 1);
    var_2.previouscharge = 0;
    var_2.var_D8B2 = "DORMANT";
    var_2.index = var_3;
    var_2.blinkable = 1;
  }

  var_0.activecircle = undefined;
  var_0.numplayerschargingcircle = 0;
  registeractionstocircles();
  var_0.souls = [];
  var_0.numsoulsalive = 0;
  var_0.numsoulsactive = 0;
  var_0.var_10B41 = 0;
  var_0.victory = 0;
  var_0.bossstate = "MAIN";
  var_0.fightstarted = 0;
  var_0.sectioncomplete = 0;
  var_0.playerschargingcircle = [];
  level.debugdlc4boss = ::start_boss_fight;
  level.debugdlc4bossstart = ::start;
  var_4 = getent("rockwall_clip", "targetname");
  var_5 = getent("rockwall_trig", "targetname");
  var_5 enablelinkto();
  var_5 linkto(var_4);
}

bossfight_loadout() {
  foreach(var_1 in level.players) {
    var_1 scripts\cp\utility::allow_player_teleport(0);
  }

  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\maps\cp_final\cp_final::delay_set_audio_zone(var_1);
  }

  level.magic_weapons["venomx"] = "iw7_venomx_zm_pap2";
  foreach(var_6 in level.var_B163) {
    var_6.var_13C25 = scripts\cp\zombies\interaction_magicwheel::func_7ABF();
  }

  level.consumable_active_override = ::meph_consumable_check;
  level.meph_fight_started = 1;
  level.unlimited_fnf = 1;
  level.magic_wheel_upgraded_pap2 = 1;
  level.fnf_cost = 0;
  enable_bossfight_fnf();
  enable_bossfight_magicwheel();
  thread spawn_perk_pickup();
  var_8 = 300;
  level thread auto_start_boss_fight(var_8);
  var_9 = scripts\engine\utility::getstructarray("afterlife_selfrevive_door", "script_noteworthy");
  foreach(var_0B in var_9) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0B);
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy"));
  var_0D = getent("bossfight_ala_clip", "targetname");
  var_0D solid();
  var_0E = scripts\engine\utility::getstructarray("afterlife_arcade", "targetname");
  var_0E = scripts\engine\utility::array_randomize(var_0E);
  foreach(var_10, var_1 in level.players) {
    var_1.ability_invulnerable = 1;
    var_1 setorigin(var_0E[var_10].origin);
    var_1 setplayerangles(var_0E[var_10].angles);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(scripts\engine\utility::getstruct("meph_perks", "script_noteworthy"));
  scripts\cp\cp_interaction::add_to_current_interaction_list(scripts\engine\utility::getstruct("start_meph_battle", "script_noteworthy"));
}

auto_start_boss_fight(var_0) {
  level endon("fight_started");
  setomnvar("zm_ui_timer", gettime() + var_0 * 1000);
  wait(var_0 - 5);
  var_1 = spawn("script_origin", (2000, -4814, 446));
  var_1 playLoopSound("quest_rewind_clock_tick_long");
  wait(5);
  var_1 delete();
  playsoundatpos((2000, -4814, 446), "mpq_fail_buzzer");
  arcade_game_cleanup();
  wait(2);
  scripts\cp\cp_vo::set_vo_system_busy(1);
  foreach(var_3 in level.players) {
    scripts\cp\maps\cp_final\cp_final_vo::clear_up_all_vo(var_3);
    var_3 _meth_82C0("bink_fadeout_amb", 0.66);
  }

  scripts\cp\utility::play_bink_video("sysload_o2", 86, 0);
  wait(86.5);
  foreach(var_3 in level.players) {
    var_3 clearclienttriggeraudiozone(0.3);
  }

  spawn_meph();
  start(level.dlc4_boss);
  level.dlc4_boss playSound("cp_final_meph_intro_ground");
}

arcade_game_cleanup() {
  foreach(var_1 in level.players) {
    var_1 notify("arcade_special_interrupt");
    var_1 disableusability();
  }

  wait(0.1);
  level notify("force_exit_arcade");
  foreach(var_1 in level.players) {
    var_1 unlink();
    if(isDefined(var_1.anchor)) {
      var_1.anchor delete();
    }

    if(!var_1 scripts\cp\utility::areinteractionsenabled()) {
      var_1 scripts\cp\utility::allow_player_interactions(1);
    }
  }
}

spawn_perk_pickup() {
  var_0 = scripts\engine\utility::getstruct("meph_perks", "script_noteworthy");
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  level.perk_pickup = spawnfx(level._effect["vfx_mep_perk_buy"], var_1.origin);
  wait(0.1);
  triggerfx(level.perk_pickup);
}

try_to_leave_bossfight(var_0, var_1) {
  if(!all_players_near_exit(var_0)) {
    iprintlnbold("All players must be near the exit");
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level notify("fight_started");
  scripts\cp\cp_vo::set_vo_system_busy(1);
  foreach(var_1 in level.players) {
    scripts\cp\maps\cp_final\cp_final_vo::clear_up_all_vo(var_1);
    var_1 _meth_82C0("bink_fadeout_amb", 0.66);
  }

  scripts\cp\utility::play_bink_video("sysload_o2", 86, 0);
  wait(86.5);
  foreach(var_1 in level.players) {
    var_1 clearclienttriggeraudiozone(0.3);
  }

  spawn_meph();
  start(level.dlc4_boss);
  level.dlc4_boss playSound("cp_final_meph_intro_ground");
}

all_players_near_exit(var_0) {
  var_1 = 128;
  foreach(var_3 in level.players) {
    if(!var_3 scripts\cp\utility::is_valid_player()) {
      return 0;
    }

    if(distance2d(var_3.origin, var_0.origin) > var_1) {
      return 0;
    }
  }

  return 1;
}

pre_bossfight_init() {
  init_bossfight_fnf();
  init_bossfight_magicwheel();
  disable_bossfight_fnf();
  disable_bossfight_magicwheel();
  var_0 = getent("bossfight_ala_clip", "targetname");
  var_0 notsolid();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(scripts\engine\utility::getstruct("meph_perks", "script_noteworthy"));
  scripts\cp\cp_interaction::remove_from_current_interaction_list(scripts\engine\utility::getstruct("start_meph_battle", "script_noteworthy"));
}

disable_bossfight_fnf() {
  level.boss_fnf_interaction.jaw hide();
  level.boss_fnf_interaction.machine setscriptablepartstate("machine", "default");
  level.boss_fnf_interaction.machine setscriptablepartstate("mouth", "off");
  level.boss_fnf_interaction.machine setscriptablepartstate("teller", "off_nomodel");
  level.boss_fnf_interaction.machine_top setscriptablepartstate("machine", "off_nomodel");
  level.boss_fnf_interaction.machine.hidden = 1;
  foreach(var_1 in level.boss_fnf_interaction.lights) {
    var_1 setlightintensity(0);
  }
}

enable_bossfight_fnf() {
  level.boss_fnf_interaction.jaw show();
  level.boss_fnf_interaction.machine setscriptablepartstate("teller", "safe_on");
  level.boss_fnf_interaction.machine setscriptablepartstate("machine", "default_on");
  wait(0.1);
  level.boss_fnf_interaction.machine_top setscriptablepartstate("machine", "on");
  level.boss_fnf_interaction.machine.hidden = undefined;
  foreach(var_1 in level.boss_fnf_interaction.lights) {
    var_1 setlightintensity(0.65);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(level.boss_fnf_interaction);
  level thread scripts\cp\cp_music_and_dialog::add_to_ambient_sound_queue("jaroslav_anc_attract", level.boss_fnf_interaction.jaw.origin, 120, 120, 250000, 100);
}

init_bossfight_fnf() {
  var_0 = scripts\engine\utility::getstruct("jaroslav_machine_meph", "script_noteworthy");
  var_1 = getEntArray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    if(var_3.script_noteworthy == "fnf_machine") {
      var_0.machine = var_3;
      continue;
    }

    if(var_3.script_noteworthy == "fnf_machine_top") {
      var_0.machine_top = var_3;
      continue;
    }

    if(var_3.script_noteworthy == "fnf_jaw") {
      var_0.jaw = var_3;
      continue;
    }

    if(var_3.script_noteworthy == "fnf_light") {
      if(!isDefined(var_0.lights)) {
        var_0.lights = [];
      }

      var_0.lights[var_0.lights.size] = var_3;
    }
  }

  level.boss_fnf_interaction = var_0;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.boss_fnf_interaction);
}

init_bossfight_magicwheel() {
  while(!isDefined(level.var_B163)) {
    wait(0.05);
  }

  wait(1);
  level.bossfight_magicwheel = scripts\engine\utility::getclosest((1679.3, -4209, 331), level.var_B163);
}

disable_bossfight_magicwheel() {
  level.bossfight_magicwheel setscriptablepartstate("base", "off_nomodel");
  level.bossfight_magicwheel setscriptablepartstate("fx", "off");
  level.bossfight_magicwheel setscriptablepartstate("spin_light", "off");
  var_0 = getEntArray("out_of_order", "script_noteworthy");
  var_1 = scripts\engine\utility::getclosest(level.bossfight_magicwheel.origin, var_0);
  var_1 hide();
  level.bossfight_magicwheel.var_10A03 hide();
  level.bossfight_magicwheel makeunusable();
}

enable_bossfight_magicwheel() {
  level.bossfight_magicwheel setscriptablepartstate("base", "on");
  level.bossfight_magicwheel setscriptablepartstate("fx", scripts\cp\zombies\interaction_magicwheel::get_default_fx_state());
  level.bossfight_magicwheel setscriptablepartstate("spin_light", "on");
  level.bossfight_magicwheel.var_10A03 show();
  level.bossfight_magicwheel.var_10A03 setscriptablepartstate("spinner", "idle");
  level.bossfight_magicwheel makeusable();
  level.bossfight_magicwheel _meth_84A7("tag_use");
  level.bossfight_magicwheel setusefov(60);
  level.bossfight_magicwheel setuserange(72);
  level.current_active_wheel = level.bossfight_magicwheel;
  level.bossfight_magicwheel sethintstring(&"CP_FINAL_SPIN_WHEEL_FREE");
}

start_boss_fight() {
  scripts\cp\maps\cp_final\cp_final::disablepas();
  level.meph_fight_started = 1;
  if(isDefined(level.pap_room_portal)) {
    level.pap_room_portal delete();
  }

  if(getdvarint("skip_bossfight_loadout") == 1 || scripts\engine\utility::istrue(level.debug_boss_fight_skip_loadout)) {
    spawn_meph();
    start(level.dlc4_boss);
    return;
  }

  bossfight_loadout();
}

boss_fight_intro_clear_audio_zone() {
  wait(10);
  self clearclienttriggeraudiozone(10);
}

play_meph_song(var_0, var_1) {
  if(soundexists(var_1)) {
    wait(2.5);
    var_2 = spawn("script_origin", var_0);
    var_2 playLoopSound(var_1);
    level scripts\engine\utility::waittill_any_3("game_ended", "FINAL_BOSS_VICTORY");
    var_2 stoploopsound();
    wait(0.1);
    var_2 delete();
  }
}

disable_laststand_weapon(var_0) {
  return 0;
}

spawn_meph() {
  if(isDefined(level.dlc4_boss)) {
    return;
  }

  level.current_vision_set = "cp_final_meph";
  scripts\cp\maps\cp_final\cp_final::disablepas();
  scripts\cp\maps\cp_final\cp_final::enablepa("pa_meph");
  level notify("add_hidden_song_to_playlist");
  scripts\cp\cp_vo::set_vo_system_busy(1);
  level.can_use_pistol_during_laststand_func = ::disable_laststand_weapon;
  foreach(var_1 in level.players) {
    var_1 _meth_82C0("final_boss_battle_space_intro", 0.02);
    var_1 thread boss_fight_intro_clear_audio_zone();
  }

  level thread play_meph_song((1785, -2077, 211), "mus_zombies_boss_battle");
  level.meph_fight_started = 1;
  level.no_laststand_music = 1;
  level.var_4C58 = ::meph_intermission_func;
  level.force_respawn_location = ::respawn_in_meph_fight;
  level.getspawnpoint = ::respawn_in_meph_fight;
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name("meph_arena");
  scripts\engine\utility::flag_set("meph_fight");
  level.zombies_paused = 1;
  if(isDefined(level.dlc4_boss) && isalive(level.dlc4_boss)) {
    level.dlc4_boss suicide();
    level.dlc4_boss = undefined;
    var_3 = undefined;
  } else {
    var_4 = "axis";
    var_5 = vectortoangles((688, -11, 0));
    var_3 = scripts\cp\zombies\zombies_spawning::func_13F53("dlc4_boss", (-13314, -337, -109), var_5, var_4);
    level.dlc4_boss = var_3;
    level.dlc4_boss thread clearvaluesondeath();
    foreach(var_8, var_1 in level.players) {
      var_7 = (0, 0, 0);
      switch (var_8) {
        case 0:
          var_7 = (-12819, -327, -106);
          break;

        case 1:
          var_7 = (-12822, -397, -106);
          break;

        case 2:
          var_7 = (-12769, -287, -106);
          break;

        case 3:
          var_7 = (-12776, -361, -106);
          break;
      }

      var_1.ability_invulnerable = undefined;
      var_1 setorigin(var_7);
      var_1 enableusability();
      var_1 setplayerangles(vectortoangles((-13314, -337, -48) - var_1.origin));
    }

    level.dlc4_boss thread persistent_flame_damage();
  }

  scripts\engine\utility::exploder(124);
  setomnvar("zm_meph_battle", 1);
  return var_3;
}

respawn_in_meph_fight(var_0) {
  var_1 = scripts\engine\utility::getstructarray("boss_player_starts", "targetname");
  if(isDefined(var_0) && isplayer(var_0)) {
    foreach(var_3 in var_1) {
      if(positionwouldtelefrag(var_3.origin, var_0)) {
        continue;
      }

      return var_3;
    }
  }

  return var_1[0];
}

clearvaluesondeath() {
  self waittill("death");
  level.loot_time_out = undefined;
  level.disable_loot_fly_to_player = undefined;
  level.movemodefunc["generic_zombie"] = level.originalmovemodefunc;
}

persistent_flame_damage() {
  level endon("game_ended");
  var_0 = getbosstunedata();
  var_1 = spawn("trigger_radius", self.origin, 0, 128, 128);
  var_1 enablelinkto();
  var_1 linkto(self, "tag_origin");
  for(;;) {
    var_1 waittill("trigger", var_2);
    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!isDefined(var_2.padding_damage)) {
      playfxontagforclients(level._effect["vfx_dlc4_player_burn_flames"], var_2, "tag_eye", var_2);
      var_2.padding_damage = 1;
      var_2 dodamage(getbosstunedata().persistent_fire_damage, var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_electrictrap_zm");
      var_2 thread remove_padding_damage();
      continue;
    }
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait(getbosstunedata().persistent_fire_rate);
  self.padding_damage = undefined;
}

initfx() {
  level._effect["weak_spot_hit"] = loadfx("vfx\iw7\levels\cp_final\boss_demon\vfx_weakspot_hit.vfx");
  level._effect["sb_quest_item_pickup"] = loadfx("vfx\iw7\core\zombie\vfx_zom_souvenir_pickup.vfx");
  level._effect["flying_soul_death"] = loadfx("vfx\iw7\levels\cp_final\boss_demon\vfx_flying_soul_death.vfx");
  level._effect["flying_soul_birth"] = loadfx("vfx\iw7\levels\cp_final\boss_demon\vfx_flying_soul_birth.vfx");
  level._effect["flying_soul_hit_fail"] = loadfx("vfx\iw7\levels\cp_final\boss_demon\vfx_flying_soul_hit_fail.vfx");
  level._effect["boss_shield_hit"] = loadfx("vfx\iw7\levels\cp_final\boss_demon\vfx_boss_shield_hit.vfx");
  level._effect["boss_teleport_start"] = loadfx("vfx\iw7\levels\cp_final\boss\vfx_dlc4_boss_telep_out.vfx");
  level._effect["boss_teleport_start_left"] = loadfx("vfx\iw7\levels\cp_final\boss\vfx_dlc4_boss_telep_out_left.vfx");
  level._effect["boss_teleport_end"] = loadfx("vfx\iw7\levels\cp_final\boss\vfx_dlc4_boss_telep_in.vfx");
  level._effect["boss_teleport_end_left"] = loadfx("vfx\iw7\levels\cp_final\boss\vfx_dlc4_boss_telep_in_left.vfx");
  level._effect["talisman_flash"] = loadfx("vfx\iw7\levels\cp_final\boss\vfx_talisman_flash.vfx");
}

initinteraction(var_0) {
  var_1 = spawnStruct();
  var_1.name = "capture_points";
  var_1.script_noteworthy = "capture_points";
  var_1.var_336 = "interaction";
  var_1.origin = var_0.origin;
  var_1.custom_search_dist = 130;
  var_1.cost = 0;
  var_1.powered_on = 1;
  var_1.spend_type = undefined;
  var_1.script_parameters = "";
  var_1.requires_power = 0;
  var_1.hint_func = ::ritualcirclehintfunc;
  var_1.activation_func = ::activatecircle;
  var_1.enabled = 1;
  var_1.circle = var_0;
  level.interactions["capture_points"] = var_1;
  var_0.interaction = var_1;
}

ritualcirclehintfunc(var_0, var_1) {
  var_2 = var_0.circle;
  if(var_2.state == "ACTIVE") {
    if(level.fbd.bossstate == "FRENZIED") {
      return &"CP_FINAL_ACTIVATE_TALISMAN";
    }

    return &"CP_FINAL_TALISMANS_NOTREADY";
  }

  return &"CP_FINAL_PLACE_TALISMAN";
}

registeractionstocircles() {
  var_0 = level.fbd;
  var_0.circles[0].actionname = "clap";
  var_0.circles[1].actionname = "throw";
  var_0.circles[2].actionname = "tornado";
  var_0.circles[3].actionname = "air_pound";
  var_0.circles[4].actionname = "fly_over";
}

start(var_0) {
  var_1 = level.fbd;
  var_1.boss = var_0;
  var_2 = getbosstunedata();
  level.no_loot_drop = 1;
  scripts\engine\utility::flag_clear("zombie_drop_powerups");
  scripts\cp\cp_vo::func_C9CB(level.players);
  level.vo_system_busy = 1;
  registerweakspots();
  foreach(var_5, var_4 in var_1.circles) {
    initinteraction(var_4);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_4.interaction);
    var_4.weakspot = var_1.weakspots[var_5];
  }

  level.zombie_ghost_model = var_2.stolen_ghost_model;
  var_1.soultobossmindistsqr = pow(var_2.boss_mid_height + var_2.soul_mid_height, 2);
  level.get_fake_ghost_model_func = ::returnfakesoulmodel;
  foreach(var_7 in level.players) {
    var_7 freezecontrols(1);
  }

  thread pre_fight_cleanup();
  thread waittillintrofinished();
  thread perframeupdate();
  level.loot_time_out = 99999;
  level.disable_loot_fly_to_player = 1;
  level.originalmovemodefunc = level.movemodefunc["generic_zombie"];
  level.movemodefunc["generic_zombie"] = ::makezombiessprint;
  level thread max_ammo_manager();
  var_1.fightstarted = 1;
  var_1.boss.health = 9999999;
}

pre_fight_cleanup() {
  var_0 = scripts\engine\utility::getstructarray("fast_travel_portal", "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.trigger)) {
      var_2.trigger delete();
    }

    if(isDefined(var_2.portal_scriptable)) {
      var_2.portal_scriptable delete();
    }

    wait(0.05);
  }
}

makezombiessprint(var_0) {
  return "sprint";
}

max_ammo_manager() {
  wait(3);
  level.drop_max_ammo_func = ::scripts\cp\loot::drop_loot;
  level thread unlimited_max_ammo();
  level thread max_ammo_pick_up_listener();
}

unlimited_max_ammo() {
  level endon("game_ended");
  level endon("restart_ammo_timer");
  scripts\engine\utility::flag_init("max_ammo_active");
  var_0 = 180;
  var_1 = 60;
  for(;;) {
    try_drop_max_ammo();
    var_2 = isDefined(level.fbd.bossstate) && level.fbd.bossstate == "FRENZIED";
    if(!var_2) {
      wait(var_0);
      continue;
    }

    wait(var_1);
  }
}

try_drop_max_ammo() {
  var_0 = level.dlc4_boss.arenacenter;
  if(!scripts\engine\utility::flag("max_ammo_active")) {
    scripts\engine\utility::flag_set("max_ammo_active");
    level thread[[level.drop_max_ammo_func]](var_0, undefined, "ammo_max", undefined, undefined, 1);
  }
}

max_ammo_pick_up_listener() {
  level endon("game_ended");
  for(;;) {
    level waittill("pick_up_max_ammo");
    scripts\engine\utility::flag_clear("max_ammo_active");
  }
}

returnfakesoulmodel(var_0) {
  return getbosstunedata().fake_ghost_model;
}

waittillintrofinished() {
  level endon("game_ended");
  wait(12);
  foreach(var_1 in level.players) {
    var_1 playlocalsound(var_1.vo_prefix + "meph_encounter");
  }

  while(!isDefined(level.fbd.boss.introfinished) || !level.fbd.boss.introfinished) {
    wait(0.2);
  }

  foreach(var_1 in level.players) {
    var_1 freezecontrols(0);
  }

  if(getdvarint("skip_bossfight_loadout") == 1 || scripts\engine\utility::istrue(level.debug_boss_fight_loadouts)) {
    setupdebugplayerloadouts();
  }

  foreach(var_1 in level.players) {
    giveentangler(var_1);
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    foreach(var_1 in level.players) {
      if(var_1 scripts\cp\utility::has_zombie_perk("perk_machine_revive")) {
        scripts\cp\cp_laststand::enable_self_revive(var_1);
      }
    }
  }
}

setupdebugplayerloadouts() {
  var_0 = ["iw7_mauler_zm"];
  var_1 = ["iw7_fhr_zm"];
  foreach(var_3 in level.players) {
    var_4 = randomint(var_1.size);
    var_5 = randomint(var_0.size);
    var_3 takeweapon(var_3 scripts\cp\utility::getvalidtakeweapon());
    var_6 = scripts\cp\utility::getrawbaseweaponname(var_1[var_4]);
    if(isDefined(var_3.weapon_build_models[var_6])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_3, var_3.weapon_build_models[var_6]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_3, var_1[var_4]);
    }

    var_7 = scripts\cp\utility::getrawbaseweaponname(var_0[var_5]);
    if(isDefined(var_3.weapon_build_models[var_7])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_3, var_3.weapon_build_models[var_7]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_3, var_1[var_4]);
    }

    var_3.total_currency_earned = min(10000, var_3 scripts\cp\cp_persistence::get_player_max_currency());
    var_3 scripts\cp\cp_persistence::set_player_currency(10000);
    var_3.have_permanent_perks = 1;
    level thread scripts\cp\gametypes\zombie::give_permanent_perks(var_3);
    scripts\cp\cp_laststand::enable_self_revive(var_3);
  }

  if(isDefined(level.pap_max) && level.pap_max < 3) {
    level.pap_max++;
  }

  level[[level.upgrade_weapons_func]]();
  level thread[[level.upgrade_weapons_func]]();
}

perframeupdate() {
  var_0 = level.fbd;
  var_1 = getbosstunedata();
  var_0.boss endon("death");
  for(;;) {
    var_0.numplayerschargingcircle = 0;
    var_0.playerschargingcircle = [];
    if(isDefined(var_0.activecircle)) {
      var_2 = var_0.activecircle;
      if(var_2.state == "CHARGING") {
        foreach(var_4 in level.players) {
          if(canchargecircle(var_4, var_2)) {
            var_0.numplayerschargingcircle = var_0.numplayerschargingcircle + 1;
            var_0.playerschargingcircle[var_0.playerschargingcircle.size] = var_4;
            var_5 = var_1.var_3CCC * level.players.size * pow(0.9, level.players.size);
            var_6 = 1 / var_5;
            var_7 = var_6 * 50;
            var_2.var_3CB7 = min(var_2.var_3CB7 + var_7, 1);
            if(level.players.size > 2) {
              var_2.buffer = var_1.buffer_time_coop;
            } else {
              var_2.buffer = var_1.buffer_time_solo;
            }

            var_2.state = "CHARGING";
          }
        }

        var_2.buffer = max(var_2.buffer - 50, 0);
        if(var_2.buffer == 0) {
          var_9 = var_1.decharge_rate * 50;
          var_2.var_3CB7 = max(var_2.var_3CB7 - var_9, 0);
          if(var_2.var_3CB7 == 0) {
            if(isDefined(var_2.talisman)) {
              var_2.talisman delete();
              var_2.talisman = undefined;
            }

            foreach(var_0B in var_0.circles) {
              if(var_0B.state != "ACTIVE") {
                var_0B.state = "DORMANT";
                scripts\cp\cp_interaction::add_to_current_interaction_list(var_0B.interaction);
              }
            }

            foreach(var_4 in level.players) {
              var_4 scripts\cp\cp_interaction::refresh_interaction();
            }
          }
        }
      }

      if(var_2.state == "CHARGING" && var_2.var_D8B2 != "CHARGING") {
        var_2.model setscriptablepartstate("symbol", "on");
      } else if(var_2.state == "DORMANT" && var_2.var_D8B2 != "DORMANT") {
        var_2.model setscriptablepartstate("symbol", "off");
      } else if(var_2.state == "ACTIVE" && var_2.var_D8B2 != "ACTIVE") {
        var_2.model setscriptablepartstate("symbol", "active");
      }

      if(var_2.state == "CHARGING") {
        var_0F = int(floor(var_2.var_3CB7 * 10));
      } else {
        var_0F = int(ceil(var_0F.var_3CB7 * 10));
      }

      if(var_2.state == "CHARGING") {
        var_10 = int(floor(var_2.previouscharge * 10));
      } else {
        var_10 = int(ceil(var_0F.previouscharge * 10));
      }

      if(var_0F != var_10) {
        var_2.model setscriptablepartstate("meter", "" + var_0F);
        if(var_0F > var_10) {
          playsoundatpos(var_2.model.origin + (0, 0, 20), "cp_final_talisman_count_up");
        } else {
          playsoundatpos(var_2.model.origin + (0, 0, 20), "cp_final_talisman_count_down");
        }
      }

      if(var_2.state == "CHARGING") {
        if(var_2.var_3CB7 == 1) {
          var_2.var_3CB7 = 1;
          var_2.state = "ACTIVE";
          releasesouls(var_2);
          thread manageactivecircle();
          var_2.talisman setscriptablepartstate("effects", "charge_complete");
        }
      }

      var_2.var_D8B2 = var_2.state;
      var_2.previouscharge = var_2.var_3CB7;
    }

    wait(0.05);
  }
}

manageactivecircle() {
  var_0 = level.fbd;
  var_1 = getbosstunedata();
  var_0.boss endon(var_1.section_complete_notify);
  var_2 = gettime();
  var_3 = gettime();
  var_4 = var_0.activecircle.origin;
  var_5 = (0, 0, 0);
  for(;;) {
    var_6 = gettime();
    var_0.activecircle.var_3CB7 = 1 - var_6 - var_2 / var_1.active_time;
    if(var_6 > var_2 + var_1.active_time) {
      var_0.summonsouls = 0;
      thread attempttofailstage();
      break;
    }

    if(var_0.summonsouls && var_6 > var_3 + var_1.soul_respawn_time) {
      if(var_0.numsoulsalive < var_1.num_souls_released) {
        thread spawnsoul(var_0.activecircle);
      }

      var_3 = var_6;
    }

    if(!var_0.summonsouls && var_0.numsoulsalive == 0) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

attempttofailstage() {
  var_0 = level.fbd;
  var_0.boss endon(getbosstunedata().section_complete_notify);
  clearsouls();
  wait(2);
  if(!var_0.boss.vulnerable) {
    deactivatecircle();
    var_0.boss.soulhealth = 999;
    wait(2);
    var_0.boss scripts\aitypes\dlc4_boss\behaviors::resetsoulhealth();
    return;
  }

  level waittill("FINAL_BOSS_STAGE_FAILED");
  deactivatecircle();
  var_0.boss.soulhealth = 999;
  wait(2);
  var_0.boss scripts\aitypes\dlc4_boss\behaviors::resetsoulhealth();
}

invulresetsoulhealth() {}

activatecircle(var_0, var_1) {
  var_2 = level.fbd;
  if(!isDefined(level.fbd.circlesactivated)) {
    level.fbd.circlesactivated = 0;
  }

  if(var_2.bossstate == "FRENZIED" && var_0.circle.state == "ACTIVE") {
    level.fbd.circlesactivated = level.fbd.circlesactivated + 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    var_3 = var_0.circle;
    var_3.model setscriptablepartstate("symbol", "complete");
    var_2.boss setscriptablepartstate("circle_" + var_3.index, "completed");
    var_3.talisman setscriptablepartstate("effects", "circle_complete");
    playsoundatpos(var_3.talisman.origin + (0, 0, 30), "cp_final_frenzy_activate_talisman");
  } else if(var_2.bossstate == "MAIN" && var_0.circle.state == "DORMANT") {
    foreach(var_3 in var_2.circles) {
      if(var_3.state != "ACTIVE") {
        var_3.var_3CB7 = 0;
        var_3.state = "LOCKED";
        playsoundatpos(var_3.interaction.origin + (0, 0, 20), "cp_final_talisman_place_on_sign");
        scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3.interaction);
      }
    }

    var_0.circle.state = "CHARGING";
    var_0.circle.talisman = spawn("script_model", var_0.origin + (0, 0, 4));
    var_0.circle.talisman.angles = (-90, 0, 0);
    var_0.circle.talisman setModel("cp_final_talisman_ritual");
    var_2.activecircle = var_0.circle;
  }

  foreach(var_1 in level.players) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
  }
}

deactivatecircle() {
  var_0 = level.fbd;
  var_0.activecircle.var_3CB7 = 0;
  var_0.activecircle.state = "DORMANT";
  var_0.activecircle.model setscriptablepartstate("symbol", "off");
  var_0.activecircle.model setscriptablepartstate("meter", "0");
  if(isDefined(var_0.activecircle.talisman)) {
    var_0.activecircle.talisman delete();
    var_0.activecircle.talisman = undefined;
  }

  if(!isDefined(var_0.boss.doinggroundvul) || !var_0.boss.doinggroundvul) {
    var_0.boss setscriptablepartstate("circle_" + var_0.activecircle.index, "off");
  }

  foreach(var_2 in var_0.circles) {
    if(var_2.state != "ACTIVE") {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_2.interaction);
      var_2.state = "DORMANT";
    }
  }

  var_0.activecircle.weakspot.health = var_0.activecircle.weakspot.maxhealth;
  foreach(var_5 in level.players) {
    var_5 scripts\cp\cp_interaction::refresh_interaction();
  }
}

canchargecircle(var_0, var_1) {
  if(var_1.state != "CHARGING") {
    return 0;
  }

  if(!var_0 scripts\cp\utility::is_valid_player()) {
    return 0;
  }

  var_2 = distance2dsquared(var_0.origin, var_1.origin);
  if(var_2 > var_1.fgetarg * var_1.fgetarg) {
    return 0;
  }

  return 1;
}

spawnsoul(var_0) {
  var_1 = var_0.origin;
  var_2 = (0, 0, 0);
  var_3 = level.fbd;
  var_4 = getbosstunedata();
  var_3.numsoulsalive = var_3.numsoulsalive + 1;
  var_3.numsoulsactive = var_3.numsoulsactive + 1;
  var_5 = scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::spawn_zombie_ghost(var_1, var_2);
  var_3.souls[var_3.souls.size] = var_5;
  var_0.model playSound("cp_final_talisman_soul_release");
  playFX(level._effect["flying_soul_birth"], var_0.origin, (1, 0, 0), (0, 0, 1));
  thread souldeathmonitor(var_5);
}

releasesouls(var_0) {
  var_1 = level.fbd;
  var_2 = getbosstunedata();
  var_1.summonsouls = 0;
  var_1.souls = [];
  var_3 = var_0.origin;
  var_4 = (0, 0, 0);
  wait(0.75);
  for(var_5 = 0; var_5 < var_2.num_souls_released; var_5++) {
    spawnsoul(var_1.activecircle);
    wait(0.25);
  }

  var_1.summonsouls = 1;
}

soulprojectilemonitor(var_0, var_1) {
  var_2 = level.fbd;
  var_3 = getbosstunedata();
  var_2.boss endon("death");
  var_0 endon("death");
  var_4 = gettime();
  for(;;) {
    var_5 = var_0 gettagorigin("j_spine4");
    if(gettime() - var_4 > var_3.soul_lifetime) {
      var_6 = var_0 gettagorigin("j_spine4");
      playFX(level._effect["flying_soul_hit_fail"], var_6, anglesToForward(var_0.angles), anglestoup(var_0.angles));
      scripts\aitypes\zombie_ghost\behaviors::fake_ghost_explode(var_0, var_1, var_3.soul_explosion_radius);
    }

    var_7 = var_2.boss gettagorigin("j_mainroot");
    var_8 = distancesquared(var_5, var_7);
    if(var_8 < var_2.soultobossmindistsqr) {
      if(!isDefined(level.soul_vo_played)) {
        level.soul_vo_played = 1;
        level thread play_meph_vo(var_1, "meph_damage_souls", 1);
      }

      var_1 thread scripts\cp\cp_damage::updatehitmarker("high_damage_cp");
      var_2.boss scripts\asm\dlc4_boss\dlc4_boss_asm::smallpain();
      var_6 = var_0 gettagorigin("j_spine4");
      playFX(level._effect["flying_soul_death"], var_6, anglesToForward(var_0.angles), anglestoup(var_0.angles));
      playsoundatpos(var_0.origin, "weap_soul_projectile_impact_lg");
      scripts\aitypes\zombie_ghost\behaviors::fake_ghost_explode(var_0, var_1, var_3.soul_explosion_radius);
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

play_meph_vo(var_0, var_1, var_2) {
  wait(var_2);
  foreach(var_4 in level.players) {
    if(var_4 == var_0) {
      var_0 playlocalsound(var_0.vo_prefix + "plr_" + var_1);
      continue;
    }

    var_4 playlocalsound(var_0.vo_prefix + var_1);
  }
}

souldeathmonitor(var_0) {
  level.fbd.boss endon("death");
  var_0 waittill("death");
  level.fbd.numsoulsalive = level.fbd.numsoulsalive - 1;
}

soulprojectiledeathmonitor(var_0) {
  var_1 = level.fbd;
  var_1.boss endon("death");
  var_0 waittill("death");
  var_1.numsoulsactive = var_1.numsoulsactive - 1;
}

clearsouls() {
  var_0 = level.fbd;
  foreach(var_2 in var_0.souls) {
    if(isalive(var_2)) {
      if(scripts\engine\utility::istrue(var_2.is_entangled) && isDefined(var_2.player_entangled_by)) {
        var_2.player_entangled_by.ghost_in_entanglement = undefined;
      }

      var_2.nocorpse = 1;
      var_2 suicide();
      level.fbd.numsoulsactive = level.fbd.numsoulsactive - 1;
    }
  }

  level notify("CLEAR_SOULS");
}

setupfornextwave() {
  var_0 = level.fbd;
  var_1 = getbosstunedata();
  foreach(var_3 in var_0.circles) {
    if(var_3.state != "ACTIVE") {
      var_3.state = "DORMANT";
      var_3.var_3CB7 = 0;
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_3.interaction);
    }
  }

  foreach(var_6 in level.players) {
    var_6 scripts\cp\cp_interaction::refresh_interaction();
  }

  scripts\aitypes\dlc4_boss\behaviors::updateweights();
}

giveentangler(var_0) {
  var_1 = getbosstunedata();
  var_0 thread entanglerhitmonitor(var_0);
  var_0 thread entanglerrechargemonitor(var_0);
  var_0 thread scripts\cp\crafted_entangler::watch_dpad();
  var_0 setclientomnvar("zom_crafted_weapon", 19);
  scripts\cp\utility::set_crafted_inventory_item("crafted_entangler", ::scripts\cp\crafted_entangler::give_crafted_entangler, var_0);
}

entanglerhitmonitor(var_0) {
  var_1 = getbosstunedata();
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon(var_1.entangler_stop_notify);
  for(;;) {
    var_2 = 0;
    for(;;) {
      var_3 = var_0 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(var_1.entangler_track_update_frequency, var_1.entangler_hit_same_target_notify);
      if(var_3 == var_1.entangler_hit_same_target_notify) {
        var_2 = var_2 + var_1.entangler_track_update_frequency;
        var_4 = min(var_2 / var_1.entangler_track_time, 1);
        if(var_4 == 1 && isalive(var_0.current_entangler_target) && !scripts\aitypes\zombie_ghost\behaviors::isentangled(var_0.current_entangler_target) && !isDefined(var_0.ghost_in_entanglement)) {
          var_0.current_entangler_target scripts\aitypes\zombie_ghost\behaviors::entangleghost(var_0.current_entangler_target, var_0);
        }

        continue;
      }

      break;
    }
  }
}

entanglerrechargemonitor(var_0) {
  var_1 = getbosstunedata();
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon(var_1.entangler_stop_notify);
  for(;;) {
    wait(var_1.entangler_recharge_rate);
    var_0 setweaponammoclip(var_1.entangler_weapon_name, weaponclipsize(var_1.entangler_weapon_name));
  }
}

registerweakspots() {
  var_0 = level.fbd;
  var_0.weakspots = [];
  registerweakspot("j_shoulder_ri", (0, 0, -12), (0, 0, -10), (-10, 180, 180), var_0.circles[0]);
  registerweakspot("j_chest", (34, -15, -19), (34, -15, -19), (120, 0, 53), var_0.circles[1]);
  registerweakspot("j_shoulder_le", (3, 0, 14), (3, 0, 14), (0, 0, 180), var_0.circles[2]);
  registerweakspot("j_chest", (42, -16, 0), (42, -16, 0), (90, -30, 15), var_0.circles[3]);
  registerweakspot("j_chest", (34, -17, 19), (34, -17, 19), (80, 0, 53), var_0.circles[4]);
}

registerweakspot(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.fbd;
  var_6 = spawnStruct();
  var_6.var_332 = var_0;
  var_6.modeloffset = var_1;
  var_6.vfxoffset = var_2;
  var_6.angleoffset = var_3;
  var_6.circle = var_4;
  var_6.maxhealth = int(getbosstunedata().weak_spot_health * level.players.size * pow(0.9, level.players.size - 1));
  var_6.health = var_6.maxhealth;
  var_5.weakspots[var_5.weakspots.size] = var_6;
}

setupweakspot(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = level.fbd;
  var_2 = getbosstunedata();
  var_3 = var_0.weakspot;
  var_4 = var_1.boss gettagorigin(var_3.var_332);
  var_1.boss setscriptablepartstate("circle_" + var_0.index, "on");
  var_5 = spawn("script_model", var_4);
  var_5 setModel(var_2.weak_spot_model);
  var_5 linkto(var_1.boss, var_3.var_332, var_3.modeloffset, var_3.angleoffset);
  var_5 getrandomweaponfromcategory();
  var_5.health = var_3.health;
  var_3.model = var_5;
  thread weakspotmonitor(var_0);
  level thread play_meph_vo(level.dlc4_boss scripts\cp\utility::get_closest_living_player(), "meph_damage_weak", 5);
}

cleanupweakspot(var_0) {
  var_1 = level.fbd;
  if(!isDefined(var_0)) {
    return;
  }

  var_2 = getbosstunedata().min_health_percent * var_0.weakspot.maxhealth;
  var_0.weakspot.health = int(max(var_0.weakspot.model.health, var_2));
  if(isDefined(var_0.weakspot.model)) {
    var_0.weakspot.model delete();
  }

  if(isDefined(var_0.weakspot.vfxent)) {
    var_3 = var_0.weakspot.vfxent;
    var_0.weakspot.vfxent delete();
  }
}

weakspotmonitor(var_0) {
  var_1 = level.fbd;
  var_2 = getbosstunedata();
  var_3 = var_0.weakspot;
  var_3 endon("death");
  var_3.model setCanDamage(1);
  for(;;) {
    var_3.model waittill("damage", var_4, var_5, var_6, var_7);
    if(!isDefined(var_5) || var_5 == var_1.boss || !isplayer(var_5)) {
      continue;
    }

    var_8 = var_6 * -1;
    playFX(level._effect["weak_spot_hit"], var_7, var_8);
    if(var_3.model.health <= 0 && !var_1.sectioncomplete) {
      clearsouls();
      var_0.var_3CB7 = 1;
      var_0.model setscriptablepartstate("symbol", "complete");
      var_0.model setscriptablepartstate("meter", "10");
      var_1.activatedcircles[var_1.activatedcircles.size] = var_0;
      var_1.boss._blackboard.desirednode = 0;
      self.automaticspawn = 0;
      var_9 = var_1.boss.unlockedactions.size;
      if(var_9 == 4) {
        var_1.bossstate = "FRENZIED";
        var_1.boss.showblood = 1;
        level notify("restart_ammo_timer");
        level thread unlimited_max_ammo();
        var_1.boss thread blinkweakspots();
      } else {
        var_1.boss.unlockedactions[var_9] = var_1.boss.specialactionnames[var_9];
      }

      var_1.boss notify(var_2.section_complete_notify);
      var_1.sectioncomplete = 1;
      cleanupweakspot(var_1.activecircle);
      var_1.boss setscriptablepartstate("circle_" + var_0.index, "destroyed");
      playsoundatpos(var_7, "cp_final_meph_destroy_sign_explo");
      break;
    }
  }
}

blinkweakspots() {
  self endon("last_stand");
  self endon("death");
  var_0 = getbosstunedata();
  var_1 = level.fbd;
  var_2 = ["completed", "off", "on", "active"];
  var_3 = [0, 0, 0, 0, 0];
  wait(1);
  for(;;) {
    foreach(var_5 in var_1.circles) {
      if(var_5.blinkable && randomfloat(1) < var_0.frenzied_blink_chance) {
        var_6 = var_3[var_5.index] + randomint(var_2.size - 1) + 1 % var_2.size;
        var_1.boss setscriptablepartstate("circle_" + var_5.index, var_2[var_6]);
        if(var_2[var_6] != "completed") {
          var_5.model setscriptablepartstate("symbol", var_2[var_6]);
        } else {
          var_5.model setscriptablepartstate("symbol", "complete");
        }

        var_5.model setscriptablepartstate("meter", randomint(11));
        var_3[var_5.index] = var_6;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

gointolaststand() {
  var_0 = level.fbd;
  var_1 = getbosstunedata();
  self.cantakedamage = 0;
  var_0.bossstate = "LAST_STAND";
  var_0.boss.laststandhealth = var_1.last_stand_health;
  var_0.boss scripts\aitypes\dlc4_boss\behaviors::setnextaction("ground_vul");
  self notify("stop_blackhole");
  self.blackholetimer = undefined;
  self notify("pain");
  self notify("last_stand");
  self._blackboard.painnotifytime = 100;
}

frenzyprogressmonitor() {
  var_0 = level.fbd;
  var_0.boss endon("death");
  var_1 = getbosstunedata();
  var_2 = var_1.frenzied_health;
  for(var_3 = 0; var_3 < 5; var_3++) {
    var_4 = int(1 * 4 - var_3 / 5 * var_2);
    while(var_0.boss.frenziedhealth > var_4) {
      wait(0.2);
    }

    var_5 = var_0.activatedcircles[var_3];
    var_5.blinkable = 0;
    var_5.model setscriptablepartstate("symbol", "off");
    var_5.model setscriptablepartstate("meter", "0");
    var_0.boss setscriptablepartstate("circle_" + var_5.index, "active");
    var_5.talisman setscriptablepartstate("effects", "charge_complete_raised");
    var_6 = vectortoangles(var_0.boss.arenacenter - var_5.talisman.origin);
    var_5.talisman movez(60, 1, 0.25, 0.25);
    var_5.talisman rotateto((0, 0, 0) + var_6, 0.8);
    thread talismanmovementmonitor(var_5.talisman);
  }

  wait(2);
  foreach(var_5 in var_0.circles) {
    var_5.talisman setscriptablepartstate("effects", "charge_complete_pulsing");
    var_5.model setscriptablepartstate("symbol", "on");
    var_5.model setscriptablepartstate("meter", "10");
    var_0.boss setscriptablepartstate("circle_" + var_5.index, "on");
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_5.interaction);
  }

  var_0.circlesactivated = 0;
  while(var_0.circlesactivated < 5) {
    wait(0.1);
  }

  var_9 = spawn("script_origin", var_0.boss.arenacenter + (0, 0, 300));
  wait(0.5);
  foreach(var_5 in var_0.circles) {
    playFX(level._effect["talisman_flash"], var_5.talisman.origin);
  }

  level notify("STOP_FRENZY_SPAWN");
  level notify("STOP_FRENZY_ARMAGEDDON");
  foreach(var_0D in level.agentarray) {
    if(var_0D == level.dlc4_boss) {
      continue;
    }

    if(isalive(var_0D) && isDefined(var_0D.isactive) && var_0D.isactive) {
      var_0D.nodamagescale = 1;
      var_0D dodamage(var_0D.health + 1000, var_0.boss.arenacenter);
    }
  }

  var_9 playSound("cp_final_frenzy_laser_build_up");
  wait(3);
  foreach(var_5 in var_0.circles) {
    var_10 = self.origin + (0, 0, 250) - var_5.talisman.origin;
    var_5.talisman rotateto(vectortoangles(var_10), 0.25, 0.08, 0.08);
  }

  wait(0.3);
  level notify("KILL_TALISMAN_MOVEMENT");
  playsoundatpos(var_0.boss.arenacenter + (0, 0, 300), "cp_final_frenzy_laser_beam_fire_npc_start");
  var_9 playLoopSound("cp_final_frenzy_laser_beam_fire_npc_loop");
  foreach(var_5 in var_0.circles) {
    var_5.talisman thread activatetalismanbeam();
  }

  gointolaststand();
  wait(2.5);
  playsoundatpos(var_9.origin, "cp_final_frenzy_laser_beam_fire_npc_end");
  var_9 delete();
  foreach(var_5 in var_0.circles) {
    playFX(level._effect["flying_soul_death"], var_5.talisman.origin);
    var_0.boss setscriptablepartstate("circle_" + var_5.index, "destroyed");
    var_5.talisman delete();
    var_5.model setscriptablepartstate("symbol", "off");
    var_5.model setscriptablepartstate("meter", "0");
  }
}

talismanmovementmonitor(var_0) {
  level.fbd.boss endon("death");
  level endon("KILL_TALISMAN_MOVEMENT");
  var_1 = 1.5;
  var_2 = 4;
  var_3 = 3;
  wait(1);
  for(;;) {
    var_0 movez(var_2, var_1, var_1 / var_3, var_1 / var_3);
    wait(var_1);
    var_0 movez(0 - var_2, var_1, var_1 / var_3, var_1 / var_3);
    wait(var_1);
  }
}

activatetalismanbeam() {
  playfxontagsbetweenclients(level._effect["vfx_talisman_beam"], self, "tag_origin", level.fbd.boss, "j_spine4");
  wait(0.5);
  playfxontagsbetweenclients(level._effect["vfx_talisman_beam"], self, "tag_origin", level.fbd.boss, "j_spine4");
}

victory() {
  var_0 = level.fbd;
  level.dlc4_boss stoploopsound();
  thread killbomb();
  level.fbd.victory = 1;
  level.no_loot_drop = undefined;
  level notify("FINAL_BOSS_VICTORY");
}

killbomb() {
  if(isDefined(level.laststandfx)) {
    level.laststandfx delete();
  }

  wait(0.1);
  playsoundatpos(level.fbd.boss.arenacenter + (0, 0, 450), "cp_final_meph_final_soul_bomb_diffuse");
  playFX(level._effect["soul_bomb_die"], level.fbd.boss.arenacenter + (0, 0, 450));
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  foreach(var_2 in var_0) {
    if(var_2 == level.dlc4_boss) {
      continue;
    }

    var_2 dodamage(var_2.health + 1000, var_2.origin);
  }

  level.meph_battle_over = 1;
}

getbosstunedata() {
  return level.agenttunedata["dlc4_boss"];
}

meph_consumable_check(var_0) {
  if(var_0 == "secret_service" || var_0 == "anywhere_but_here") {
    return 0;
  }

  if(isDefined(self.consumables) && isDefined(self.consumables[var_0]) && isDefined(self.consumables[var_0].on) && self.consumables[var_0].on == 1) {
    return 1;
  }

  return 0;
}

meph_intermission_func(var_0) {
  self.forcespawnorigin = level.dlc4_boss.arenacenter + (-250, 0, 500);
  self.forcespawnangles = (60, 0, 0);
  var_1 = self.forcespawnangles;
  scripts\cp\cp_globallogic::spawnplayer();
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
  if(level.console) {
    self setclientdvar("cg_fov", "90");
  }

  scripts\cp\utility::updatesessionstate("intermission");
}