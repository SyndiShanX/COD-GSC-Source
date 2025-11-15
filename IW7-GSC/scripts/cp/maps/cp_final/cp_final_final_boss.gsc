/************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_final_boss.gsc
************************************************************/

init() {
  scripts\engine\utility::flag_init("meph_fight");
  level.fbd = spawnStruct();
  var_00 = level.fbd;
  var_00.soulprojectilemonitorfunc = ::soulprojectilemonitor;
  var_00.soulprojectiledeathfunc = ::soulprojectiledeathmonitor;
  initfx();
  var_00.circles = scripts\engine\utility::getstructarray("capture_points", "targetname");
  var_00.activatedcircles = [];
  foreach(var_03, var_02 in var_00.circles) {
    var_02.var_3CB7 = 0;
    var_02.buffer = 0;
    var_02.state = "DORMANT";
    var_02.model = spawn("script_model", var_02.origin + (0, 0, 3));
    var_02.model setModel("tag_origin_ritual_circle_0" + var_03 + 1);
    var_02.previouscharge = 0;
    var_02.var_D8B2 = "DORMANT";
    var_02.index = var_03;
    var_02.blinkable = 1;
  }

  var_00.activecircle = undefined;
  var_00.numplayerschargingcircle = 0;
  registeractionstocircles();
  var_00.souls = [];
  var_00.numsoulsalive = 0;
  var_00.numsoulsactive = 0;
  var_00.var_10B41 = 0;
  var_00.victory = 0;
  var_00.bossstate = "MAIN";
  var_00.fightstarted = 0;
  var_00.sectioncomplete = 0;
  var_00.playerschargingcircle = [];
  level.debugdlc4boss = ::start_boss_fight;
  level.debugdlc4bossstart = ::start;
  var_04 = getent("rockwall_clip", "targetname");
  var_05 = getent("rockwall_trig", "targetname");
  var_05 enablelinkto();
  var_05 linkto(var_04);
}

bossfight_loadout() {
  foreach(var_01 in level.players) {
    var_01 scripts\cp\utility::allow_player_teleport(0);
  }

  foreach(var_01 in level.players) {
    var_01 thread scripts\cp\maps\cp_final\cp_final::delay_set_audio_zone(var_01);
  }

  level.magic_weapons["venomx"] = "iw7_venomx_zm_pap2";
  foreach(var_06 in level.var_B163) {
    var_06.var_13C25 = scripts\cp\zombies\interaction_magicwheel::func_7ABF();
  }

  level.consumable_active_override = ::meph_consumable_check;
  level.meph_fight_started = 1;
  level.unlimited_fnf = 1;
  level.magic_wheel_upgraded_pap2 = 1;
  level.fnf_cost = 0;
  enable_bossfight_fnf();
  enable_bossfight_magicwheel();
  thread spawn_perk_pickup();
  var_08 = 300;
  level thread auto_start_boss_fight(var_08);
  var_09 = scripts\engine\utility::getstructarray("afterlife_selfrevive_door", "script_noteworthy");
  foreach(var_0B in var_09) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0B);
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(scripts\engine\utility::getstruct("afterlife_spectate_door", "script_noteworthy"));
  var_0D = getent("bossfight_ala_clip", "targetname");
  var_0D solid();
  var_0E = scripts\engine\utility::getstructarray("afterlife_arcade", "targetname");
  var_0E = scripts\engine\utility::array_randomize(var_0E);
  foreach(var_10, var_01 in level.players) {
    var_01.ability_invulnerable = 1;
    var_01 setorigin(var_0E[var_10].origin);
    var_01 setplayerangles(var_0E[var_10].angles);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(scripts\engine\utility::getstruct("meph_perks", "script_noteworthy"));
  scripts\cp\cp_interaction::add_to_current_interaction_list(scripts\engine\utility::getstruct("start_meph_battle", "script_noteworthy"));
}

auto_start_boss_fight(param_00) {
  level endon("fight_started");
  setomnvar("zm_ui_timer", gettime() + param_00 * 1000);
  wait(param_00 - 5);
  var_01 = spawn("script_origin", (2000, -4814, 446));
  var_01 playLoopSound("quest_rewind_clock_tick_long");
  wait(5);
  var_01 delete();
  playsoundatpos((2000, -4814, 446), "mpq_fail_buzzer");
  arcade_game_cleanup();
  wait(2);
  scripts\cp\cp_vo::set_vo_system_busy(1);
  foreach(var_03 in level.players) {
    scripts\cp\maps\cp_final\cp_final_vo::clear_up_all_vo(var_03);
    var_03 _meth_82C0("bink_fadeout_amb", 0.66);
  }

  scripts\cp\utility::play_bink_video("sysload_o2", 86, 0);
  wait(86.5);
  foreach(var_03 in level.players) {
    var_03 clearclienttriggeraudiozone(0.3);
  }

  spawn_meph();
  start(level.dlc4_boss);
  level.dlc4_boss playSound("cp_final_meph_intro_ground");
}

arcade_game_cleanup() {
  foreach(var_01 in level.players) {
    var_01 notify("arcade_special_interrupt");
    var_01 disableusability();
  }

  wait(0.1);
  level notify("force_exit_arcade");
  foreach(var_01 in level.players) {
    var_01 unlink();
    if(isDefined(var_01.anchor)) {
      var_01.anchor delete();
    }

    if(!var_01 scripts\cp\utility::areinteractionsenabled()) {
      var_01 scripts\cp\utility::allow_player_interactions(1);
    }
  }
}

spawn_perk_pickup() {
  var_00 = scripts\engine\utility::getstruct("meph_perks", "script_noteworthy");
  var_01 = scripts\engine\utility::getstruct(var_00.target, "targetname");
  level.perk_pickup = spawnfx(level._effect["vfx_mep_perk_buy"], var_01.origin);
  wait(0.1);
  triggerfx(level.perk_pickup);
}

try_to_leave_bossfight(param_00, param_01) {
  if(!all_players_near_exit(param_00)) {
    iprintlnbold("All players must be near the exit");
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  level notify("fight_started");
  scripts\cp\cp_vo::set_vo_system_busy(1);
  foreach(param_01 in level.players) {
    scripts\cp\maps\cp_final\cp_final_vo::clear_up_all_vo(param_01);
    param_01 _meth_82C0("bink_fadeout_amb", 0.66);
  }

  scripts\cp\utility::play_bink_video("sysload_o2", 86, 0);
  wait(86.5);
  foreach(param_01 in level.players) {
    param_01 clearclienttriggeraudiozone(0.3);
  }

  spawn_meph();
  start(level.dlc4_boss);
  level.dlc4_boss playSound("cp_final_meph_intro_ground");
}

all_players_near_exit(param_00) {
  var_01 = 128;
  foreach(var_03 in level.players) {
    if(!var_03 scripts\cp\utility::is_valid_player()) {
      return 0;
    }

    if(distance2d(var_03.origin, param_00.origin) > var_01) {
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
  var_00 = getent("bossfight_ala_clip", "targetname");
  var_00 notsolid();
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
  foreach(var_01 in level.boss_fnf_interaction.lights) {
    var_01 setlightintensity(0);
  }
}

enable_bossfight_fnf() {
  level.boss_fnf_interaction.jaw show();
  level.boss_fnf_interaction.machine setscriptablepartstate("teller", "safe_on");
  level.boss_fnf_interaction.machine setscriptablepartstate("machine", "default_on");
  wait(0.1);
  level.boss_fnf_interaction.machine_top setscriptablepartstate("machine", "on");
  level.boss_fnf_interaction.machine.hidden = undefined;
  foreach(var_01 in level.boss_fnf_interaction.lights) {
    var_01 setlightintensity(0.65);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(level.boss_fnf_interaction);
  level thread scripts\cp\cp_music_and_dialog::add_to_ambient_sound_queue("jaroslav_anc_attract", level.boss_fnf_interaction.jaw.origin, 120, 120, 250000, 100);
}

init_bossfight_fnf() {
  var_00 = scripts\engine\utility::getstruct("jaroslav_machine_meph", "script_noteworthy");
  var_01 = getEntArray(var_00.target, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.script_noteworthy == "fnf_machine") {
      var_00.machine = var_03;
      continue;
    }

    if(var_03.script_noteworthy == "fnf_machine_top") {
      var_00.machine_top = var_03;
      continue;
    }

    if(var_03.script_noteworthy == "fnf_jaw") {
      var_00.jaw = var_03;
      continue;
    }

    if(var_03.script_noteworthy == "fnf_light") {
      if(!isDefined(var_00.lights)) {
        var_00.lights = [];
      }

      var_00.lights[var_00.lights.size] = var_03;
    }
  }

  level.boss_fnf_interaction = var_00;
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
  var_00 = getEntArray("out_of_order", "script_noteworthy");
  var_01 = scripts\engine\utility::getclosest(level.bossfight_magicwheel.origin, var_00);
  var_01 hide();
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
  level.bossfight_magicwheel sethintstring( & "CP_FINAL_SPIN_WHEEL_FREE");
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

play_meph_song(param_00, param_01) {
  if(soundexists(param_01)) {
    wait(2.5);
    var_02 = spawn("script_origin", param_00);
    var_02 playLoopSound(param_01);
    level scripts\engine\utility::waittill_any_3("game_ended", "FINAL_BOSS_VICTORY");
    var_02 stoploopsound();
    wait(0.1);
    var_02 delete();
  }
}

disable_laststand_weapon(param_00) {
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
  foreach(var_01 in level.players) {
    var_01 _meth_82C0("final_boss_battle_space_intro", 0.02);
    var_01 thread boss_fight_intro_clear_audio_zone();
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
    var_03 = undefined;
  } else {
    var_04 = "axis";
    var_05 = vectortoangles((688, -11, 0));
    var_03 = scripts\cp\zombies\zombies_spawning::func_13F53("dlc4_boss", (-13314, -337, -109), var_05, var_04);
    level.dlc4_boss = var_03;
    level.dlc4_boss thread clearvaluesondeath();
    foreach(var_08, var_01 in level.players) {
      var_07 = (0, 0, 0);
      switch (var_08) {
        case 0:
          var_07 = (-12819, -327, -106);
          break;

        case 1:
          var_07 = (-12822, -397, -106);
          break;

        case 2:
          var_07 = (-12769, -287, -106);
          break;

        case 3:
          var_07 = (-12776, -361, -106);
          break;
      }

      var_01.ability_invulnerable = undefined;
      var_01 setorigin(var_07);
      var_01 enableusability();
      var_01 setplayerangles(vectortoangles((-13314, -337, -48) - var_01.origin));
    }

    level.dlc4_boss thread persistent_flame_damage();
  }

  scripts\engine\utility::exploder(124);
  setomnvar("zm_meph_battle", 1);
  return var_03;
}

respawn_in_meph_fight(param_00) {
  var_01 = scripts\engine\utility::getstructarray("boss_player_starts", "targetname");
  if(isDefined(param_00) && isplayer(param_00)) {
    foreach(var_03 in var_01) {
      if(positionwouldtelefrag(var_03.origin, param_00)) {
        continue;
      }

      return var_03;
    }
  }

  return var_01[0];
}

clearvaluesondeath() {
  self waittill("death");
  level.loot_time_out = undefined;
  level.disable_loot_fly_to_player = undefined;
  level.movemodefunc["generic_zombie"] = level.originalmovemodefunc;
}

persistent_flame_damage() {
  level endon("game_ended");
  var_00 = getbosstunedata();
  var_01 = spawn("trigger_radius", self.origin, 0, 128, 128);
  var_01 enablelinkto();
  var_01 linkto(self, "tag_origin");
  for(;;) {
    var_01 waittill("trigger", var_02);
    if(!var_02 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!isDefined(var_02.padding_damage)) {
      playfxontagforclients(level._effect["vfx_dlc4_player_burn_flames"], var_02, "tag_eye", var_02);
      var_02.padding_damage = 1;
      var_02 dodamage(getbosstunedata().persistent_fire_damage, var_01.origin, var_01, var_01, "MOD_UNKNOWN", "iw7_electrictrap_zm");
      var_02 thread remove_padding_damage();
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

initinteraction(param_00) {
  var_01 = spawnStruct();
  var_01.name = "capture_points";
  var_01.script_noteworthy = "capture_points";
  var_01.var_336 = "interaction";
  var_01.origin = param_00.origin;
  var_01.custom_search_dist = 130;
  var_01.cost = 0;
  var_01.powered_on = 1;
  var_01.spend_type = undefined;
  var_01.script_parameters = "";
  var_01.requires_power = 0;
  var_01.hint_func = ::ritualcirclehintfunc;
  var_01.activation_func = ::activatecircle;
  var_01.enabled = 1;
  var_01.circle = param_00;
  level.interactions["capture_points"] = var_01;
  param_00.interaction = var_01;
}

ritualcirclehintfunc(param_00, param_01) {
  var_02 = param_00.circle;
  if(var_02.state == "ACTIVE") {
    if(level.fbd.bossstate == "FRENZIED") {
      return & "CP_FINAL_ACTIVATE_TALISMAN";
    }

    return & "CP_FINAL_TALISMANS_NOTREADY";
  }

  return & "CP_FINAL_PLACE_TALISMAN";
}

registeractionstocircles() {
  var_00 = level.fbd;
  var_00.circles[0].actionname = "clap";
  var_00.circles[1].actionname = "throw";
  var_00.circles[2].actionname = "tornado";
  var_00.circles[3].actionname = "air_pound";
  var_00.circles[4].actionname = "fly_over";
}

start(param_00) {
  var_01 = level.fbd;
  var_01.boss = param_00;
  var_02 = getbosstunedata();
  level.no_loot_drop = 1;
  scripts\engine\utility::flag_clear("zombie_drop_powerups");
  scripts\cp\cp_vo::func_C9CB(level.players);
  level.vo_system_busy = 1;
  registerweakspots();
  foreach(var_05, var_04 in var_01.circles) {
    initinteraction(var_04);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_04.interaction);
    var_04.weakspot = var_01.weakspots[var_05];
  }

  level.zombie_ghost_model = var_02.stolen_ghost_model;
  var_01.soultobossmindistsqr = pow(var_02.boss_mid_height + var_02.soul_mid_height, 2);
  level.get_fake_ghost_model_func = ::returnfakesoulmodel;
  foreach(var_07 in level.players) {
    var_07 freezecontrols(1);
  }

  thread pre_fight_cleanup();
  thread waittillintrofinished();
  thread perframeupdate();
  level.loot_time_out = 99999;
  level.disable_loot_fly_to_player = 1;
  level.originalmovemodefunc = level.movemodefunc["generic_zombie"];
  level.movemodefunc["generic_zombie"] = ::makezombiessprint;
  level thread max_ammo_manager();
  var_01.fightstarted = 1;
  var_01.boss.health = 9999999;
}

pre_fight_cleanup() {
  var_00 = scripts\engine\utility::getstructarray("fast_travel_portal", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.trigger)) {
      var_02.trigger delete();
    }

    if(isDefined(var_02.portal_scriptable)) {
      var_02.portal_scriptable delete();
    }

    wait(0.05);
  }
}

makezombiessprint(param_00) {
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
  var_00 = 180;
  var_01 = 60;
  for(;;) {
    try_drop_max_ammo();
    var_02 = isDefined(level.fbd.bossstate) && level.fbd.bossstate == "FRENZIED";
    if(!var_02) {
      wait(var_00);
      continue;
    }

    wait(var_01);
  }
}

try_drop_max_ammo() {
  var_00 = level.dlc4_boss.arenacenter;
  if(!scripts\engine\utility::flag("max_ammo_active")) {
    scripts\engine\utility::flag_set("max_ammo_active");
    level thread[[level.drop_max_ammo_func]](var_00, undefined, "ammo_max", undefined, undefined, 1);
  }
}

max_ammo_pick_up_listener() {
  level endon("game_ended");
  for(;;) {
    level waittill("pick_up_max_ammo");
    scripts\engine\utility::flag_clear("max_ammo_active");
  }
}

returnfakesoulmodel(param_00) {
  return getbosstunedata().fake_ghost_model;
}

waittillintrofinished() {
  level endon("game_ended");
  wait(12);
  foreach(var_01 in level.players) {
    var_01 playlocalsound(var_01.vo_prefix + "meph_encounter");
  }

  while(!isDefined(level.fbd.boss.introfinished) || !level.fbd.boss.introfinished) {
    wait(0.2);
  }

  foreach(var_01 in level.players) {
    var_01 freezecontrols(0);
  }

  if(getdvarint("skip_bossfight_loadout") == 1 || scripts\engine\utility::istrue(level.debug_boss_fight_loadouts)) {
    setupdebugplayerloadouts();
  }

  foreach(var_01 in level.players) {
    giveentangler(var_01);
  }

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    foreach(var_01 in level.players) {
      if(var_01 scripts\cp\utility::has_zombie_perk("perk_machine_revive")) {
        scripts\cp\cp_laststand::enable_self_revive(var_01);
      }
    }
  }
}

setupdebugplayerloadouts() {
  var_00 = ["iw7_mauler_zm"];
  var_01 = ["iw7_fhr_zm"];
  foreach(var_03 in level.players) {
    var_04 = randomint(var_01.size);
    var_05 = randomint(var_00.size);
    var_03 takeweapon(var_03 scripts\cp\utility::getvalidtakeweapon());
    var_06 = scripts\cp\utility::getrawbaseweaponname(var_01[var_04]);
    if(isDefined(var_03.weapon_build_models[var_06])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_03, var_03.weapon_build_models[var_06]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_03, var_01[var_04]);
    }

    var_07 = scripts\cp\utility::getrawbaseweaponname(var_00[var_05]);
    if(isDefined(var_03.weapon_build_models[var_07])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_03, var_03.weapon_build_models[var_07]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_03, var_01[var_04]);
    }

    var_03.total_currency_earned = min(10000, var_03 scripts\cp\cp_persistence::get_player_max_currency());
    var_03 scripts\cp\cp_persistence::set_player_currency(10000);
    var_03.have_permanent_perks = 1;
    level thread scripts\cp\gametypes\zombie::give_permanent_perks(var_03);
    scripts\cp\cp_laststand::enable_self_revive(var_03);
  }

  if(isDefined(level.pap_max) && level.pap_max < 3) {
    level.pap_max++;
  }

  level[[level.upgrade_weapons_func]]();
  level thread[[level.upgrade_weapons_func]]();
}

perframeupdate() {
  var_00 = level.fbd;
  var_01 = getbosstunedata();
  var_00.boss endon("death");
  for(;;) {
    var_00.numplayerschargingcircle = 0;
    var_00.playerschargingcircle = [];
    if(isDefined(var_00.activecircle)) {
      var_02 = var_00.activecircle;
      if(var_02.state == "CHARGING") {
        foreach(var_04 in level.players) {
          if(canchargecircle(var_04, var_02)) {
            var_00.numplayerschargingcircle = var_00.numplayerschargingcircle + 1;
            var_00.playerschargingcircle[var_00.playerschargingcircle.size] = var_04;
            var_05 = var_01.var_3CCC * level.players.size * pow(0.9, level.players.size);
            var_06 = 1 / var_05;
            var_07 = var_06 * 50;
            var_02.var_3CB7 = min(var_02.var_3CB7 + var_07, 1);
            if(level.players.size > 2) {
              var_02.buffer = var_01.buffer_time_coop;
            } else {
              var_02.buffer = var_01.buffer_time_solo;
            }

            var_02.state = "CHARGING";
          }
        }

        var_02.buffer = max(var_02.buffer - 50, 0);
        if(var_02.buffer == 0) {
          var_09 = var_01.decharge_rate * 50;
          var_02.var_3CB7 = max(var_02.var_3CB7 - var_09, 0);
          if(var_02.var_3CB7 == 0) {
            if(isDefined(var_02.talisman)) {
              var_02.talisman delete();
              var_02.talisman = undefined;
            }

            foreach(var_0B in var_00.circles) {
              if(var_0B.state != "ACTIVE") {
                var_0B.state = "DORMANT";
                scripts\cp\cp_interaction::add_to_current_interaction_list(var_0B.interaction);
              }
            }

            foreach(var_04 in level.players) {
              var_04 scripts\cp\cp_interaction::refresh_interaction();
            }
          }
        }
      }

      if(var_02.state == "CHARGING" && var_02.var_D8B2 != "CHARGING") {
        var_02.model setscriptablepartstate("symbol", "on");
      } else if(var_02.state == "DORMANT" && var_02.var_D8B2 != "DORMANT") {
        var_02.model setscriptablepartstate("symbol", "off");
      } else if(var_02.state == "ACTIVE" && var_02.var_D8B2 != "ACTIVE") {
        var_02.model setscriptablepartstate("symbol", "active");
      }

      if(var_02.state == "CHARGING") {
        var_0F = int(floor(var_02.var_3CB7 * 10));
      } else {
        var_0F = int(ceil(var_0F.var_3CB7 * 10));
      }

      if(var_02.state == "CHARGING") {
        var_10 = int(floor(var_02.previouscharge * 10));
      } else {
        var_10 = int(ceil(var_0F.previouscharge * 10));
      }

      if(var_0F != var_10) {
        var_02.model setscriptablepartstate("meter", "" + var_0F);
        if(var_0F > var_10) {
          playsoundatpos(var_02.model.origin + (0, 0, 20), "cp_final_talisman_count_up");
        } else {
          playsoundatpos(var_02.model.origin + (0, 0, 20), "cp_final_talisman_count_down");
        }
      }

      if(var_02.state == "CHARGING") {
        if(var_02.var_3CB7 == 1) {
          var_02.var_3CB7 = 1;
          var_02.state = "ACTIVE";
          releasesouls(var_02);
          thread manageactivecircle();
          var_02.talisman setscriptablepartstate("effects", "charge_complete");
        }
      }

      var_02.var_D8B2 = var_02.state;
      var_02.previouscharge = var_02.var_3CB7;
    }

    wait(0.05);
  }
}

manageactivecircle() {
  var_00 = level.fbd;
  var_01 = getbosstunedata();
  var_00.boss endon(var_01.section_complete_notify);
  var_02 = gettime();
  var_03 = gettime();
  var_04 = var_00.activecircle.origin;
  var_05 = (0, 0, 0);
  for(;;) {
    var_06 = gettime();
    var_00.activecircle.var_3CB7 = 1 - var_06 - var_02 / var_01.active_time;
    if(var_06 > var_02 + var_01.active_time) {
      var_00.summonsouls = 0;
      thread attempttofailstage();
      break;
    }

    if(var_00.summonsouls && var_06 > var_03 + var_01.soul_respawn_time) {
      if(var_00.numsoulsalive < var_01.num_souls_released) {
        thread spawnsoul(var_00.activecircle);
      }

      var_03 = var_06;
    }

    if(!var_00.summonsouls && var_00.numsoulsalive == 0) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

attempttofailstage() {
  var_00 = level.fbd;
  var_00.boss endon(getbosstunedata().section_complete_notify);
  clearsouls();
  wait(2);
  if(!var_00.boss.vulnerable) {
    deactivatecircle();
    var_00.boss.soulhealth = 999;
    wait(2);
    var_00.boss scripts\aitypes\dlc4_boss\behaviors::resetsoulhealth();
    return;
  }

  level waittill("FINAL_BOSS_STAGE_FAILED");
  deactivatecircle();
  var_00.boss.soulhealth = 999;
  wait(2);
  var_00.boss scripts\aitypes\dlc4_boss\behaviors::resetsoulhealth();
}

invulresetsoulhealth() {}

activatecircle(param_00, param_01) {
  var_02 = level.fbd;
  if(!isDefined(level.fbd.circlesactivated)) {
    level.fbd.circlesactivated = 0;
  }

  if(var_02.bossstate == "FRENZIED" && param_00.circle.state == "ACTIVE") {
    level.fbd.circlesactivated = level.fbd.circlesactivated + 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    var_03 = param_00.circle;
    var_03.model setscriptablepartstate("symbol", "complete");
    var_02.boss setscriptablepartstate("circle_" + var_03.index, "completed");
    var_03.talisman setscriptablepartstate("effects", "circle_complete");
    playsoundatpos(var_03.talisman.origin + (0, 0, 30), "cp_final_frenzy_activate_talisman");
  } else if(var_02.bossstate == "MAIN" && param_00.circle.state == "DORMANT") {
    foreach(var_03 in var_02.circles) {
      if(var_03.state != "ACTIVE") {
        var_03.var_3CB7 = 0;
        var_03.state = "LOCKED";
        playsoundatpos(var_03.interaction.origin + (0, 0, 20), "cp_final_talisman_place_on_sign");
        scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03.interaction);
      }
    }

    param_00.circle.state = "CHARGING";
    param_00.circle.talisman = spawn("script_model", param_00.origin + (0, 0, 4));
    param_00.circle.talisman.angles = (-90, 0, 0);
    param_00.circle.talisman setModel("cp_final_talisman_ritual");
    var_02.activecircle = param_00.circle;
  }

  foreach(param_01 in level.players) {
    param_01 scripts\cp\cp_interaction::refresh_interaction();
  }
}

deactivatecircle() {
  var_00 = level.fbd;
  var_00.activecircle.var_3CB7 = 0;
  var_00.activecircle.state = "DORMANT";
  var_00.activecircle.model setscriptablepartstate("symbol", "off");
  var_00.activecircle.model setscriptablepartstate("meter", "0");
  if(isDefined(var_00.activecircle.talisman)) {
    var_00.activecircle.talisman delete();
    var_00.activecircle.talisman = undefined;
  }

  if(!isDefined(var_00.boss.doinggroundvul) || !var_00.boss.doinggroundvul) {
    var_00.boss setscriptablepartstate("circle_" + var_00.activecircle.index, "off");
  }

  foreach(var_02 in var_00.circles) {
    if(var_02.state != "ACTIVE") {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_02.interaction);
      var_02.state = "DORMANT";
    }
  }

  var_00.activecircle.weakspot.health = var_00.activecircle.weakspot.maxhealth;
  foreach(var_05 in level.players) {
    var_05 scripts\cp\cp_interaction::refresh_interaction();
  }
}

canchargecircle(param_00, param_01) {
  if(param_01.state != "CHARGING") {
    return 0;
  }

  if(!param_00 scripts\cp\utility::is_valid_player()) {
    return 0;
  }

  var_02 = distance2dsquared(param_00.origin, param_01.origin);
  if(var_02 > param_01.fgetarg * param_01.fgetarg) {
    return 0;
  }

  return 1;
}

spawnsoul(param_00) {
  var_01 = param_00.origin;
  var_02 = (0, 0, 0);
  var_03 = level.fbd;
  var_04 = getbosstunedata();
  var_03.numsoulsalive = var_03.numsoulsalive + 1;
  var_03.numsoulsactive = var_03.numsoulsactive + 1;
  var_05 = scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::spawn_zombie_ghost(var_01, var_02);
  var_03.souls[var_03.souls.size] = var_05;
  param_00.model playSound("cp_final_talisman_soul_release");
  playFX(level._effect["flying_soul_birth"], param_00.origin, (1, 0, 0), (0, 0, 1));
  thread souldeathmonitor(var_05);
}

releasesouls(param_00) {
  var_01 = level.fbd;
  var_02 = getbosstunedata();
  var_01.summonsouls = 0;
  var_01.souls = [];
  var_03 = param_00.origin;
  var_04 = (0, 0, 0);
  wait(0.75);
  for(var_05 = 0; var_05 < var_02.num_souls_released; var_05++) {
    spawnsoul(var_01.activecircle);
    wait(0.25);
  }

  var_01.summonsouls = 1;
}

soulprojectilemonitor(param_00, param_01) {
  var_02 = level.fbd;
  var_03 = getbosstunedata();
  var_02.boss endon("death");
  param_00 endon("death");
  var_04 = gettime();
  for(;;) {
    var_05 = param_00 gettagorigin("j_spine4");
    if(gettime() - var_04 > var_03.soul_lifetime) {
      var_06 = param_00 gettagorigin("j_spine4");
      playFX(level._effect["flying_soul_hit_fail"], var_06, anglesToForward(param_00.angles), anglestoup(param_00.angles));
      scripts\aitypes\zombie_ghost\behaviors::fake_ghost_explode(param_00, param_01, var_03.soul_explosion_radius);
    }

    var_07 = var_02.boss gettagorigin("j_mainroot");
    var_08 = distancesquared(var_05, var_07);
    if(var_08 < var_02.soultobossmindistsqr) {
      if(!isDefined(level.soul_vo_played)) {
        level.soul_vo_played = 1;
        level thread play_meph_vo(param_01, "meph_damage_souls", 1);
      }

      param_01 thread scripts\cp\cp_damage::updatehitmarker("high_damage_cp");
      var_02.boss scripts\asm\dlc4_boss\dlc4_boss_asm::smallpain();
      var_06 = param_00 gettagorigin("j_spine4");
      playFX(level._effect["flying_soul_death"], var_06, anglesToForward(param_00.angles), anglestoup(param_00.angles));
      playsoundatpos(param_00.origin, "weap_soul_projectile_impact_lg");
      scripts\aitypes\zombie_ghost\behaviors::fake_ghost_explode(param_00, param_01, var_03.soul_explosion_radius);
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

play_meph_vo(param_00, param_01, param_02) {
  wait(param_02);
  foreach(var_04 in level.players) {
    if(var_04 == param_00) {
      param_00 playlocalsound(param_00.vo_prefix + "plr_" + param_01);
      continue;
    }

    var_04 playlocalsound(param_00.vo_prefix + param_01);
  }
}

souldeathmonitor(param_00) {
  level.fbd.boss endon("death");
  param_00 waittill("death");
  level.fbd.numsoulsalive = level.fbd.numsoulsalive - 1;
}

soulprojectiledeathmonitor(param_00) {
  var_01 = level.fbd;
  var_01.boss endon("death");
  param_00 waittill("death");
  var_01.numsoulsactive = var_01.numsoulsactive - 1;
}

clearsouls() {
  var_00 = level.fbd;
  foreach(var_02 in var_00.souls) {
    if(isalive(var_02)) {
      if(scripts\engine\utility::istrue(var_02.is_entangled) && isDefined(var_02.player_entangled_by)) {
        var_02.player_entangled_by.ghost_in_entanglement = undefined;
      }

      var_02.nocorpse = 1;
      var_02 suicide();
      level.fbd.numsoulsactive = level.fbd.numsoulsactive - 1;
    }
  }

  level notify("CLEAR_SOULS");
}

setupfornextwave() {
  var_00 = level.fbd;
  var_01 = getbosstunedata();
  foreach(var_03 in var_00.circles) {
    if(var_03.state != "ACTIVE") {
      var_03.state = "DORMANT";
      var_03.var_3CB7 = 0;
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_03.interaction);
    }
  }

  foreach(var_06 in level.players) {
    var_06 scripts\cp\cp_interaction::refresh_interaction();
  }

  scripts\aitypes\dlc4_boss\behaviors::updateweights();
}

giveentangler(param_00) {
  var_01 = getbosstunedata();
  param_00 thread entanglerhitmonitor(param_00);
  param_00 thread entanglerrechargemonitor(param_00);
  param_00 thread scripts\cp\crafted_entangler::watch_dpad();
  param_00 setclientomnvar("zom_crafted_weapon", 19);
  scripts\cp\utility::set_crafted_inventory_item("crafted_entangler", ::scripts\cp\crafted_entangler::give_crafted_entangler, param_00);
}

entanglerhitmonitor(param_00) {
  var_01 = getbosstunedata();
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon(var_01.entangler_stop_notify);
  for(;;) {
    var_02 = 0;
    for(;;) {
      var_03 = param_00 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(var_01.entangler_track_update_frequency, var_01.entangler_hit_same_target_notify);
      if(var_03 == var_01.entangler_hit_same_target_notify) {
        var_02 = var_02 + var_01.entangler_track_update_frequency;
        var_04 = min(var_02 / var_01.entangler_track_time, 1);
        if(var_04 == 1 && isalive(param_00.current_entangler_target) && !scripts\aitypes\zombie_ghost\behaviors::isentangled(param_00.current_entangler_target) && !isDefined(param_00.ghost_in_entanglement)) {
          param_00.current_entangler_target scripts\aitypes\zombie_ghost\behaviors::entangleghost(param_00.current_entangler_target, param_00);
        }

        continue;
      }

      break;
    }
  }
}

entanglerrechargemonitor(param_00) {
  var_01 = getbosstunedata();
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon(var_01.entangler_stop_notify);
  for(;;) {
    wait(var_01.entangler_recharge_rate);
    param_00 setweaponammoclip(var_01.entangler_weapon_name, weaponclipsize(var_01.entangler_weapon_name));
  }
}

registerweakspots() {
  var_00 = level.fbd;
  var_00.weakspots = [];
  registerweakspot("j_shoulder_ri", (0, 0, -12), (0, 0, -10), (-10, 180, 180), var_00.circles[0]);
  registerweakspot("j_chest", (34, -15, -19), (34, -15, -19), (120, 0, 53), var_00.circles[1]);
  registerweakspot("j_shoulder_le", (3, 0, 14), (3, 0, 14), (0, 0, 180), var_00.circles[2]);
  registerweakspot("j_chest", (42, -16, 0), (42, -16, 0), (90, -30, 15), var_00.circles[3]);
  registerweakspot("j_chest", (34, -17, 19), (34, -17, 19), (80, 0, 53), var_00.circles[4]);
}

registerweakspot(param_00, param_01, param_02, param_03, param_04) {
  var_05 = level.fbd;
  var_06 = spawnStruct();
  var_06.var_332 = param_00;
  var_06.modeloffset = param_01;
  var_06.vfxoffset = param_02;
  var_06.angleoffset = param_03;
  var_06.circle = param_04;
  var_06.maxhealth = int(getbosstunedata().weak_spot_health * level.players.size * pow(0.9, level.players.size - 1));
  var_06.health = var_06.maxhealth;
  var_05.weakspots[var_05.weakspots.size] = var_06;
}

setupweakspot(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = level.fbd;
  var_02 = getbosstunedata();
  var_03 = param_00.weakspot;
  var_04 = var_01.boss gettagorigin(var_03.var_332);
  var_01.boss setscriptablepartstate("circle_" + param_00.index, "on");
  var_05 = spawn("script_model", var_04);
  var_05 setModel(var_02.weak_spot_model);
  var_05 linkto(var_01.boss, var_03.var_332, var_03.modeloffset, var_03.angleoffset);
  var_05 getrandomweaponfromcategory();
  var_05.health = var_03.health;
  var_03.model = var_05;
  thread weakspotmonitor(param_00);
  level thread play_meph_vo(level.dlc4_boss scripts\cp\utility::get_closest_living_player(), "meph_damage_weak", 5);
}

cleanupweakspot(param_00) {
  var_01 = level.fbd;
  if(!isDefined(param_00)) {
    return;
  }

  var_02 = getbosstunedata().min_health_percent * param_00.weakspot.maxhealth;
  param_00.weakspot.health = int(max(param_00.weakspot.model.health, var_02));
  if(isDefined(param_00.weakspot.model)) {
    param_00.weakspot.model delete();
  }

  if(isDefined(param_00.weakspot.vfxent)) {
    var_03 = param_00.weakspot.vfxent;
    param_00.weakspot.vfxent delete();
  }
}

weakspotmonitor(param_00) {
  var_01 = level.fbd;
  var_02 = getbosstunedata();
  var_03 = param_00.weakspot;
  var_03 endon("death");
  var_03.model setCanDamage(1);
  for(;;) {
    var_03.model waittill("damage", var_04, var_05, var_06, var_07);
    if(!isDefined(var_05) || var_05 == var_01.boss || !isplayer(var_05)) {
      continue;
    }

    var_08 = var_06 * -1;
    playFX(level._effect["weak_spot_hit"], var_07, var_08);
    if(var_03.model.health <= 0 && !var_01.sectioncomplete) {
      clearsouls();
      param_00.var_3CB7 = 1;
      param_00.model setscriptablepartstate("symbol", "complete");
      param_00.model setscriptablepartstate("meter", "10");
      var_01.activatedcircles[var_01.activatedcircles.size] = param_00;
      var_01.boss.var_1198.desirednode = 0;
      self.automaticspawn = 0;
      var_09 = var_01.boss.unlockedactions.size;
      if(var_09 == 4) {
        var_01.bossstate = "FRENZIED";
        var_01.boss.showblood = 1;
        level notify("restart_ammo_timer");
        level thread unlimited_max_ammo();
        var_01.boss thread blinkweakspots();
      } else {
        var_01.boss.unlockedactions[var_09] = var_01.boss.specialactionnames[var_09];
      }

      var_01.boss notify(var_02.section_complete_notify);
      var_01.sectioncomplete = 1;
      cleanupweakspot(var_01.activecircle);
      var_01.boss setscriptablepartstate("circle_" + param_00.index, "destroyed");
      playsoundatpos(var_07, "cp_final_meph_destroy_sign_explo");
      break;
    }
  }
}

blinkweakspots() {
  self endon("last_stand");
  self endon("death");
  var_00 = getbosstunedata();
  var_01 = level.fbd;
  var_02 = ["completed", "off", "on", "active"];
  var_03 = [0, 0, 0, 0, 0];
  wait(1);
  for(;;) {
    foreach(var_05 in var_01.circles) {
      if(var_05.blinkable && randomfloat(1) < var_00.frenzied_blink_chance) {
        var_06 = var_03[var_05.index] + randomint(var_02.size - 1) + 1 % var_02.size;
        var_01.boss setscriptablepartstate("circle_" + var_05.index, var_02[var_06]);
        if(var_02[var_06] != "completed") {
          var_05.model setscriptablepartstate("symbol", var_02[var_06]);
        } else {
          var_05.model setscriptablepartstate("symbol", "complete");
        }

        var_05.model setscriptablepartstate("meter", randomint(11));
        var_03[var_05.index] = var_06;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

gointolaststand() {
  var_00 = level.fbd;
  var_01 = getbosstunedata();
  self.cantakedamage = 0;
  var_00.bossstate = "LAST_STAND";
  var_00.boss.laststandhealth = var_01.last_stand_health;
  var_00.boss scripts\aitypes\dlc4_boss\behaviors::setnextaction("ground_vul");
  self notify("stop_blackhole");
  self.blackholetimer = undefined;
  self notify("pain");
  self notify("last_stand");
  self.var_1198.painnotifytime = 100;
}

frenzyprogressmonitor() {
  var_00 = level.fbd;
  var_00.boss endon("death");
  var_01 = getbosstunedata();
  var_02 = var_01.frenzied_health;
  for(var_03 = 0; var_03 < 5; var_03++) {
    var_04 = int(1 * 4 - var_03 / 5 * var_02);
    while(var_00.boss.frenziedhealth > var_04) {
      wait(0.2);
    }

    var_05 = var_00.activatedcircles[var_03];
    var_05.blinkable = 0;
    var_05.model setscriptablepartstate("symbol", "off");
    var_05.model setscriptablepartstate("meter", "0");
    var_00.boss setscriptablepartstate("circle_" + var_05.index, "active");
    var_05.talisman setscriptablepartstate("effects", "charge_complete_raised");
    var_06 = vectortoangles(var_00.boss.arenacenter - var_05.talisman.origin);
    var_05.talisman movez(60, 1, 0.25, 0.25);
    var_05.talisman rotateto((0, 0, 0) + var_06, 0.8);
    thread talismanmovementmonitor(var_05.talisman);
  }

  wait(2);
  foreach(var_05 in var_00.circles) {
    var_05.talisman setscriptablepartstate("effects", "charge_complete_pulsing");
    var_05.model setscriptablepartstate("symbol", "on");
    var_05.model setscriptablepartstate("meter", "10");
    var_00.boss setscriptablepartstate("circle_" + var_05.index, "on");
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_05.interaction);
  }

  var_00.circlesactivated = 0;
  while(var_00.circlesactivated < 5) {
    wait(0.1);
  }

  var_09 = spawn("script_origin", var_00.boss.arenacenter + (0, 0, 300));
  wait(0.5);
  foreach(var_05 in var_00.circles) {
    playFX(level._effect["talisman_flash"], var_05.talisman.origin);
  }

  level notify("STOP_FRENZY_SPAWN");
  level notify("STOP_FRENZY_ARMAGEDDON");
  foreach(var_0D in level.agentarray) {
    if(var_0D == level.dlc4_boss) {
      continue;
    }

    if(isalive(var_0D) && isDefined(var_0D.isactive) && var_0D.isactive) {
      var_0D.nodamagescale = 1;
      var_0D dodamage(var_0D.health + 1000, var_00.boss.arenacenter);
    }
  }

  var_09 playSound("cp_final_frenzy_laser_build_up");
  wait(3);
  foreach(var_05 in var_00.circles) {
    var_10 = self.origin + (0, 0, 250) - var_05.talisman.origin;
    var_05.talisman rotateto(vectortoangles(var_10), 0.25, 0.08, 0.08);
  }

  wait(0.3);
  level notify("KILL_TALISMAN_MOVEMENT");
  playsoundatpos(var_00.boss.arenacenter + (0, 0, 300), "cp_final_frenzy_laser_beam_fire_npc_start");
  var_09 playLoopSound("cp_final_frenzy_laser_beam_fire_npc_loop");
  foreach(var_05 in var_00.circles) {
    var_05.talisman thread activatetalismanbeam();
  }

  gointolaststand();
  wait(2.5);
  playsoundatpos(var_09.origin, "cp_final_frenzy_laser_beam_fire_npc_end");
  var_09 delete();
  foreach(var_05 in var_00.circles) {
    playFX(level._effect["flying_soul_death"], var_05.talisman.origin);
    var_00.boss setscriptablepartstate("circle_" + var_05.index, "destroyed");
    var_05.talisman delete();
    var_05.model setscriptablepartstate("symbol", "off");
    var_05.model setscriptablepartstate("meter", "0");
  }
}

talismanmovementmonitor(param_00) {
  level.fbd.boss endon("death");
  level endon("KILL_TALISMAN_MOVEMENT");
  var_01 = 1.5;
  var_02 = 4;
  var_03 = 3;
  wait(1);
  for(;;) {
    param_00 movez(var_02, var_01, var_01 / var_03, var_01 / var_03);
    wait(var_01);
    param_00 movez(0 - var_02, var_01, var_01 / var_03, var_01 / var_03);
    wait(var_01);
  }
}

activatetalismanbeam() {
  playfxontagsbetweenclients(level._effect["vfx_talisman_beam"], self, "tag_origin", level.fbd.boss, "j_spine4");
  wait(0.5);
  playfxontagsbetweenclients(level._effect["vfx_talisman_beam"], self, "tag_origin", level.fbd.boss, "j_spine4");
}

victory() {
  var_00 = level.fbd;
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
  var_00 = scripts\mp\mp_agent::getaliveagentsofteam("axis");
  foreach(var_02 in var_00) {
    if(var_02 == level.dlc4_boss) {
      continue;
    }

    var_02 dodamage(var_02.health + 1000, var_02.origin);
  }

  level.meph_battle_over = 1;
}

getbosstunedata() {
  return level.agenttunedata["dlc4_boss"];
}

meph_consumable_check(param_00) {
  if(param_00 == "secret_service" || param_00 == "anywhere_but_here") {
    return 0;
  }

  if(isDefined(self.consumables) && isDefined(self.consumables[param_00]) && isDefined(self.consumables[param_00].on) && self.consumables[param_00].on == 1) {
    return 1;
  }

  return 0;
}

meph_intermission_func(param_00) {
  self.forcespawnorigin = level.dlc4_boss.arenacenter + (-250, 0, 500);
  self.forcespawnangles = (60, 0, 0);
  var_01 = self.forcespawnangles;
  scripts\cp\cp_globallogic::spawnplayer();
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
  if(level.console) {
    self setclientdvar("cg_fov", "90");
  }

  scripts\cp\utility::updatesessionstate("intermission");
}