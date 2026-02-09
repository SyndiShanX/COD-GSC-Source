/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\183.gsc
**************************************/

main() {
  if(!isDefined(level.func)) {
    level.func = [];
  }
  level.func["setsaveddvar"] = ::setsaveddvar;
  level.func["useanimtree"] = ::useanimtree;
  level.func["setanim"] = ::setanim;
  level.func["setanimknob"] = ::setanimknob;
  level.func["clearanim"] = ::clearanim;
  level.func["kill"] = ::kill;
  _id_1EBE();
  level._id_1C4D = [];
  level._id_1C4D["_autosave_stealthcheck"] = ::_id_1FCE;
  level._id_1C4D["_patrol_endon_spotted_flag"] = ::_id_1FCE;
  level._id_1C4D["_spawner_stealth_default"] = ::_id_1FCE;
  level._id_1C4D["_idle_call_idle_func"] = ::_id_1FCE;

  if(!isDefined(level._id_1E70)) {
    level._id_1E70 = "cheat_bw";
  }
  visionsetthermal(level._id_1E70);
  visionsetpain("near_death");
  level.func["damagefeedback"] = maps\_damagefeedback::updatedamagefeedback;
  common_scripts\utility::array_thread(getEntArray("script_model_pickup_claymore", "classname"), ::_id_1FB5);
  common_scripts\utility::array_thread(getEntArray("ammo_cache", "targetname"), ::_id_1FB7);
  maps\_utility::_id_135B(getEntArray("trigger_multiple_softlanding", "classname"));

  if(getDvar("debug") == "") {
    setDvar("debug", "0");
  }
  if(getDvar("fallback") == "") {
    setDvar("fallback", "0");
  }
  if(getDvar("angles") == "") {
    setDvar("angles", "0");
  }
  if(getDvar("noai") == "") {
    setDvar("noai", "off");
  }
  if(getDvar("scr_RequiredMapAspectratio") == "") {
    setDvar("scr_RequiredMapAspectratio", "1");
  }
  setDvar("ac130_player_num", -1);
  maps\_utility::_id_1E71();
  setDvar("ui_remotemissile_playernum", 0);
  setDvar("ui_pmc_won", 0);

  if(!isDefined(anim._id_1E72)) {
    anim._id_1E72 = [];
    animscripts\notetracks::_id_1E73();
  }

  maps\_utility::_id_1E74("no_game", ::_id_1F22);
  _id_1FDA();
  level._loadstarted = 1;
  level.first_frame = 1;
  level._id_1B22 = 0;
  thread _id_1F87();
  level._id_1E75 = [];
  level._id_1E76 = [];
  level._id_1E77 = [];
  level._id_1E78 = [];
  level._id_1E79 = [];
  level._id_1E7A = [];

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
  }
  maps\_specialops::_id_17EB();

  if(maps\_utility::_id_0A36() && (issplitscreen() || getDvar("coop") == "1")) {
    setDvar("solo_play", "");
  }
  if(issubstr(level.script, "so_survival_")) {} else {}

  level._id_12E5 = 0;

  if(maps\_utility::_id_0A36()) {
    level._id_12E5 = 1;

    if(maps\_utility::_id_12DC()) {
      level._id_1ABA = 2;
    } else {
      level._id_1ABA = 1;
    }
  } else {
    level._id_1ABA = 0;
  }
  level._id_1E7B["center"] = "dirt_effect_center";
  level._id_1E7B["left"] = "dirt_effect_left";
  level._id_1E7B["right"] = "dirt_effect_right";
  precachemenu(level._id_1E7B["center"]);
  precachemenu(level._id_1E7B["left"]);
  precachemenu(level._id_1E7B["right"]);
  precacheshader("fullscreen_dirt_bottom_b");
  precacheshader("fullscreen_dirt_bottom");
  precacheshader("fullscreen_dirt_left");
  precacheshader("fullscreen_dirt_right");
  precacheshader("fullscreen_bloodsplat_bottom");
  precacheshader("fullscreen_bloodsplat_left");
  precacheshader("fullscreen_bloodsplat_right");
  level._id_1E7C = 0;

  if(!isDefined(level.flag)) {
    common_scripts\utility::init_flags();
  } else {
    var_0 = getarraykeys(level.flag);
    common_scripts\utility::array_levelthread(var_0, ::_id_1F8E);
  }

  _id_1F99();

  if(maps\_utility::_id_12C1()) {
    maps\_coop::main();
  }
  if(maps\_utility::_id_1A5C()) {
    maps\_laststand::main();
  }
  if(issplitscreen()) {
    setsaveddvar("cg_fovScale", "0.75");
  } else {
    setsaveddvar("cg_fovScale", "1");
  }
  level._id_1E7D = 0;
  common_scripts\utility::flag_init("missionfailed");
  common_scripts\utility::flag_init("auto_adjust_initialized");
  common_scripts\utility::flag_init("_radiation_poisoning");
  common_scripts\utility::flag_init("gameskill_selected");
  common_scripts\utility::flag_init("battlechatter_on_thread_waiting");
  thread maps\_gameskill::_id_1E7E();
  thread _id_1F92();
  level._id_1E7F = 190;
  setsaveddvar("g_speed", level._id_1E7F);

  if(maps\_utility::_id_0A36()) {
    setsaveddvar("sv_saveOnStartMap", 0);
  } else if(maps\_utility::_id_09D4()) {
    setsaveddvar("sv_saveOnStartMap", 0);
    thread _id_1F91();
  } else if(isDefined(level._id_1D95)) {
    setsaveddvar("sv_saveOnStartMap", 0);
  } else {
    setsaveddvar("sv_saveOnStartMap", 1);
  }
  common_scripts\utility::create_lock("mg42_drones");
  common_scripts\utility::create_lock("mg42_drones_target_trace");
  level._id_1B45 = [];

  foreach(var_3, var_2 in level.struct) {
    if(!isDefined(var_2.targetname)) {
      continue;
    }
    if(var_2.targetname == "delete_on_load") {
      level.struct[var_3] = undefined;
    }
  }

  common_scripts\utility::struct_class_init();
  common_scripts\utility::flag_init("respawn_friendlies");
  common_scripts\utility::flag_init("player_flashed");
  level._id_1E80 = maps\_utility::_id_1E05;
  level.connectpathsfunction = ::connectpaths;
  level.disconnectpathsfunction = ::disconnectpaths;
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;
  level.isaifunc = ::isai;
  level.createclientfontstring_func = maps\_hud_util::createserverclientfontstring;
  level.hudsetpoint_func = maps\_hud_util::setpoint;
  level._id_1E83 = ::makeentitysentient;
  level._id_1E84 = ::freeentitysentient;
  level.laseron_func = ::laserforceon;
  level.laseroff_func = ::laserforceoff;
  level._id_1E87 = maps\_player_stats::_id_0A34;
  level._id_1E88 = maps\_player_stats::_id_0A3B;
  level._id_1C4C = 1;
  level._id_1C4E = 1;
  level.getnodefunction = ::getnode;
  level.getnodearrayfunction = ::getnodearray;

  if(!isDefined(level._id_1E89)) {
    level._id_1E89 = [];
  }
  foreach(var_5 in level.players) {
    var_5.maxhealth = level.player.health;
    var_5._id_1C53 = 0;
    var_5._id_1E8A = 0;
    var_5 thread watchweaponchange();
  }

  level._id_13D2 = -5000;
  level._id_1E8B = [];
  thread _id_1F8F();

  for(var_7 = 0; var_7 < level.players.size; var_7++) {
    var_5 = level.players[var_7];
    var_5 thread maps\_utility::_id_1E8C();
    var_5 thread maps\_utility::_id_1E8D();
  }

  precachemodel("fx");
  precachemodel("tag_origin");
  precacheshellshock("victoryscreen");
  precacheshellshock("default");
  precacheshellshock("flashbang");
  precacheshellshock("dog_bite");
  precacherumble("damage_heavy");
  precacherumble("damage_light");
  precacherumble("grenade_rumble");
  precacherumble("artillery_rumble");
  precachestring(&"GAME_GET_TO_COVER");
  precachestring(&"GAME_LAST_STAND_GET_BACK_UP");
  precachestring(&"SCRIPT_GRENADE_DEATH");
  precachestring(&"SCRIPT_GRENADE_SUICIDE_LINE1");
  precachestring(&"SCRIPT_GRENADE_SUICIDE_LINE2");
  precachestring(&"SCRIPT_EXPLODING_VEHICLE_DEATH");
  precachestring(&"SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
  precachestring(&"SCRIPT_EXPLODING_BARREL_DEATH");
  precacheshader("hud_grenadeicon");
  precacheshader("hud_grenadepointer");
  precacheshader("hud_burningcaricon");
  precacheshader("death_juggernaut");
  precacheshader("death_friendly_fire");
  precacheshader("hud_destructibledeathicon");
  precacheshader("hud_burningbarrelicon");
  precacheshader("waypoint_ammo");
  level._effect["deathfx_bloodpool_generic"] = loadfx("impacts/deathfx_bloodpool_generic");
  animscripts\pain::_id_0D1A();
  animscripts\melee::_id_1006();
  level.createfx_enabled = getDvar("createfx") != "";
  _id_1FD5();
  maps\_mgturret::main();
  setupexploders();
  maps\_art::main();
  maps\_noder::main();
  common_scripts\_painter::main();
  maps\_gameskill::_id_1E8E();
  maps\_anim::init();
  thread common_scripts\_fx::initfx();

  if(level.createfx_enabled) {
    level._id_1BB2 = 1;
    maps\_createfx::createfx();
  }

  maps\_global_fx::main();
  maps\_detonategrenades::init();
  thread _id_1EC8();
  maps\_names::_id_1299();

  if(isDefined(level._id_1E8F)) {
    thread[[level._id_1E8F]]();
  } else {
    thread _id_1F17();
  }
  if(!isDefined(level.trigger_flags)) {
    common_scripts\utility::init_trigger_flags();
  }
  level._id_1E90 = [];
  _id_1EAE();
  setsaveddvar("ufoHitsTriggers", "0");
  _id_1FDC();

  if(getDvar("g_connectpaths") == "2") {
    level waittill("eternity");
  }
  maps\_autosave::main();

  if(!isDefined(level._id_11E8)) {
    thread maps\_debug::_id_19FB();
  }
  maps\_anim::init();
  maps\_audio::_id_16F4();

  if(isDefined(level._id_1E91)) {
    maps\_audio::_id_1740(level._id_1E91);
  }
  anim._id_0C3B = 0;

  if(!isDefined(level._id_16C9)) {
    level._id_16C9 = 0;
  }
  maps\_loadout::_id_1C5B();
  common_scripts\_destructible::init();
  thread common_scripts\_elevator::init();
  thread common_scripts\_pipes::main();
  thread maps\_vehicle::_id_1E92();
  _id_1F6A();
  common_scripts\_dynamic_world::init();
  setsaveddvar("ui_campaign", level._id_0BA2);
  thread maps\_introscreen::main();
  thread maps\_quotes::main();
  thread maps\_shutter::main();
  thread maps\_endmission::main();
  thread maps\_damagefeedback::init();
  thread maps\_escalator::init();
  maps\_friendlyfire::main();
  common_scripts\utility::array_levelthread(getEntArray("badplace", "targetname"), ::_id_1ED6);
  common_scripts\utility::array_levelthread(getEntArray("delete_on_load", "targetname"), maps\_utility::_id_1E93);
  common_scripts\utility::array_thread(getnodearray("traverse", "targetname"), ::_id_1EF9);
  common_scripts\utility::array_thread(getEntArray("piano_key", "targetname"), ::_id_1EFC);
  common_scripts\utility::array_thread(getEntArray("piano_damage", "targetname"), ::_id_1EFB);
  common_scripts\utility::array_thread(getEntArray("water", "targetname"), ::_id_1F00);
  common_scripts\utility::array_thread(getEntArray("kill_all_players", "targetname"), ::_id_1F9A);
  common_scripts\utility::flag_init("allow_ammo_pickups");
  common_scripts\utility::flag_set("allow_ammo_pickups");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_grenade_launcher", "targetname"), ::_id_1F6B, "grenade_launcher");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_rpg", "targetname"), ::_id_1F6B, "rpg");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_c4", "targetname"), ::_id_1F6B, "c4");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_claymore", "targetname"), ::_id_1F6B, "claymore");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_556", "targetname"), ::_id_1F6B, "556");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_762", "targetname"), ::_id_1F6B, "762");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_45", "targetname"), ::_id_1F6B, "45");
  common_scripts\utility::array_thread(getEntArray("ammo_pickup_pistol", "targetname"), ::_id_1F6B, "pistol");
  thread maps\_interactive_objects::main();
  thread maps\_intelligence::main();
  thread maps\_gameskill::_id_1E94();

  for(var_7 = 0; var_7 < level.players.size; var_7++) {
    var_5 = level.players[var_7];
    var_5 thread maps\_gameskill::playerhealthregen();
    var_5 thread _id_1EEA();
  }

  thread _id_1EEE();
  thread _id_1F05();
  common_scripts\utility::flag_init("spawning_friendlies");
  common_scripts\utility::flag_init("friendly_wave_spawn_enabled");
  common_scripts\utility::flag_clear("spawning_friendlies");
  level._id_1E96["rifleguy"] = getEntArray("rifle_spawner", "script_noteworthy");
  level._id_1E96["smgguy"] = getEntArray("smg_spawner", "script_noteworthy");
  level._id_1E97 = [];
  level._id_1E97["allies"] = [];
  level._id_1E97["axis"] = [];
  level._id_1E97["team3"] = [];
  level._id_1E97["neutral"] = [];
  thread maps\_spawner::_id_1E98();
  thread maps\_spawner::_id_1E99();
  thread maps\_spawner::_id_1E9A();
  common_scripts\utility::array_thread(getEntArray("friendly_spawn", "targetname"), maps\_spawner::_id_1E9B);
  common_scripts\utility::array_thread(getEntArray("flood_and_secure", "targetname"), maps\_spawner::_id_1E9C);
  common_scripts\utility::array_thread(getEntArray("window_poster", "targetname"), ::_id_1FCD);

  if(!isDefined(level._id_1E9D)) {
    level._id_1E9D = [];
    level._id_1E9E = [];
  }

  level._id_1E9F = [];
  level._id_1EA0 = [];
  maps\_spawner::main();
  common_scripts\utility::array_thread(getEntArray("background_block", "targetname"), ::_id_1F52);
  maps\_hud::init();
  thread _id_1F8C();
  thread maps\_animatedmodels::main();

  if(maps\_utility::_id_12C1()) {
    thread maps\_loadout::_id_1C87();
  }
  thread _id_1EC9();

  if(maps\_utility::_id_0A36()) {
    maps\_specialops::_id_17D0();
  }
  if(level.script == level._id_1953._id_190C[0].name && !level.player getlocalplayerprofiledata("hasEverPlayed_SP")) {
    level.player setlocalplayerprofiledata("hasEverPlayed_SP", 1);
    updategamerprofile();
  }

  level notify("load_finished");
}

_id_1EA1() {
  var_0 = [];
  var_0["trigger_multiple_nobloodpool"] = ::_id_1F2C;
  var_0["trigger_multiple_flag_set"] = ::_id_1F30;
  var_0["trigger_multiple_flag_clear"] = ::_id_1F36;
  var_0["trigger_multiple_sun_off"] = ::_id_1F2F;
  var_0["trigger_multiple_sun_on"] = ::_id_1F2E;
  var_0["trigger_use_flag_set"] = ::_id_1F30;
  var_0["trigger_use_flag_clear"] = ::_id_1F36;
  var_0["trigger_multiple_flag_set_touching"] = ::_id_1F69;
  var_0["trigger_multiple_flag_lookat"] = ::_id_1F0E;
  var_0["trigger_multiple_flag_looking"] = ::_id_1F0F;
  var_0["trigger_multiple_no_prone"] = ::_id_1F8A;
  var_0["trigger_multiple_no_crouch_or_prone"] = ::_id_1F88;
  var_0["trigger_multiple_compass"] = ::_id_1FCF;
  var_0["trigger_multiple_specialops_flag_set"] = ::_id_1F31;
  var_0["trigger_multiple_fx_volume"] = ::_id_1FD1;
  var_0["trigger_multiple_light_sunshadow"] = maps\_lights::_id_1661;

  if(!maps\_utility::_id_1C39()) {
    var_0["trigger_multiple_autosave"] = maps\_autosave::_id_1C35;
    var_0["trigger_multiple_spawn"] = maps\_spawner::_id_1EA2;
    var_0["trigger_multiple_spawn_reinforcement"] = maps\_spawner::_id_1EA3;
  }

  var_0["trigger_multiple_slide"] = ::_id_1EC0;
  var_0["trigger_multiple_fog"] = ::_id_1F6F;
  var_0["trigger_damage_doradius_damage"] = ::_id_1F50;
  var_0["trigger_multiple_doradius_damage"] = ::_id_1F4D;
  var_0["trigger_damage_player_flag_set"] = ::_id_1F34;
  var_0["trigger_multiple_visionset"] = ::_id_1FC0;
  var_0["trigger_multiple_glass_break"] = ::_id_1FA0;
  var_0["trigger_radius_glass_break"] = ::_id_1FA0;
  var_0["trigger_multiple_friendly_respawn"] = ::_id_1F4B;
  var_0["trigger_multiple_friendly_stop_respawn"] = ::_id_1F4A;
  var_0["trigger_multiple_physics"] = ::_id_1F48;
  var_0["trigger_multiple_fx_watersheeting"] = maps\_fx::_id_1E54;
  return var_0;
}

_id_1EA4() {
  var_0 = [];
  var_0["friendly_wave"] = maps\_spawner::_id_1EA5;
  var_0["friendly_wave_off"] = maps\_spawner::_id_1EA5;
  var_0["friendly_mgTurret"] = maps\_spawner::_id_1EA6;

  if(!maps\_utility::_id_1C39()) {
    var_0["camper_spawner"] = maps\_spawner::_id_1EA7;
    var_0["flood_spawner"] = maps\_spawner::_id_1EA8;
    var_0["trigger_spawner"] = maps\_spawner::_id_1EA2;
    var_0["trigger_autosave"] = maps\_autosave::_id_1C35;
    var_0["trigger_spawngroup"] = ::_id_1F94;
    var_0["two_stage_spawner"] = maps\_spawner::_id_1EA9;
    var_0["trigger_vehicle_spline_spawn"] = ::_id_1F9B;
    var_0["trigger_vehicle_spawn"] = ::_id_1F9D;
    var_0["trigger_vehicle_getin_spawn"] = ::_id_1FA1;
    var_0["random_spawn"] = maps\_spawner::_id_1EAA;
  }

  var_0["autosave_now"] = maps\_autosave::_id_1C42;
  var_0["trigger_autosave_tactical"] = maps\_autosave::_id_1C33;
  var_0["trigger_autosave_stealth"] = maps\_autosave::_id_1C31;
  var_0["trigger_unlock"] = ::_id_1F08;
  var_0["trigger_lookat"] = ::_id_1F0E;
  var_0["trigger_looking"] = ::_id_1F0F;
  var_0["trigger_cansee"] = ::_id_1F14;
  var_0["autosave_immediate"] = maps\_autosave::_id_1C3C;
  var_0["flag_set"] = ::_id_1F30;

  if(maps\_utility::_id_12C1()) {
    var_0["flag_set_coop"] = ::_id_1F35;
  }
  var_0["flag_set_player"] = ::_id_1F2B;
  var_0["flag_unset"] = ::_id_1F36;
  var_0["flag_clear"] = ::_id_1F36;
  var_0["objective_event"] = maps\_spawner::_id_1EAB;
  var_0["friendly_respawn_trigger"] = ::_id_1F4B;
  var_0["friendly_respawn_clear"] = ::_id_1F4C;
  var_0["radio_trigger"] = ::_id_1F51;
  var_0["trigger_ignore"] = ::_id_1F54;
  var_0["trigger_pacifist"] = ::_id_1F56;
  var_0["trigger_delete"] = ::_id_1F5B;
  var_0["trigger_delete_on_touch"] = ::_id_1F68;
  var_0["trigger_off"] = ::_id_1F5B;
  var_0["trigger_outdoor"] = maps\_spawner::_id_1EAC;
  var_0["trigger_indoor"] = maps\_spawner::_id_1EAD;
  var_0["trigger_hint"] = ::_id_1F5E;
  var_0["trigger_grenade_at_player"] = ::_id_1F65;
  var_0["flag_on_cleared"] = ::_id_1F66;
  var_0["flag_set_touching"] = ::_id_1F69;
  var_0["delete_link_chain"] = ::_id_1F6D;
  var_0["trigger_fog"] = ::_id_1F6F;
  var_0["trigger_slide"] = ::_id_1EC0;
  var_0["trigger_dooropen"] = ::_id_1F9F;
  var_0["no_crouch_or_prone"] = ::_id_1F88;
  var_0["no_prone"] = ::_id_1F8A;
  return var_0;
}

_id_1EAE() {
  var_0 = _id_1EA1();
  var_1 = _id_1EA4();

  foreach(var_5, var_3 in var_0) {
    var_4 = getEntArray(var_5, "classname");
    common_scripts\utility::array_levelthread(var_4, var_3);
  }

  var_6 = getEntArray("trigger_multiple", "classname");
  var_7 = getEntArray("trigger_radius", "classname");
  var_4 = maps\_utility::_id_1843(var_6, var_7);
  var_8 = getEntArray("trigger_disk", "classname");
  var_4 = maps\_utility::_id_1843(var_4, var_8);
  var_9 = getEntArray("trigger_once", "classname");
  var_4 = maps\_utility::_id_1843(var_4, var_9);

  if(!maps\_utility::_id_1C39()) {
    for(var_10 = 0; var_10 < var_4.size; var_10++) {
      if(var_4[var_10].spawnflags & 32) {
        thread maps\_spawner::_id_1EA2(var_4[var_10]);
      }
    }
  }

  for(var_11 = 0; var_11 < 7; var_11++) {
    switch (var_11) {
      case 0:
        var_12 = "trigger_multiple";
        break;
      case 1:
        var_12 = "trigger_once";
        break;
      case 2:
        var_12 = "trigger_use";
        break;
      case 3:
        var_12 = "trigger_radius";
        break;
      case 4:
        var_12 = "trigger_lookat";
        break;
      case 5:
        var_12 = "trigger_disk";
        break;
      default:
        var_12 = "trigger_damage";
        break;
    }

    var_4 = getEntArray(var_12, "code_classname");

    for(var_10 = 0; var_10 < var_4.size; var_10++) {
      if(isDefined(var_4[var_10].script_flag_true)) {
        level thread _id_1F46(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_flag_false)) {
        level thread _id_1F45(var_4[var_10]);
      }
      if(isDefined(var_4[var_10]._id_1C3B) || isDefined(var_4[var_10]._id_1C36)) {
        level thread maps\_autosave::_id_1C38(var_4[var_10]);
      }
      if(isDefined(var_4[var_10]._id_1EAF)) {
        level thread maps\_spawner::_id_1EB0(var_4[var_10]);
      }
      if(isDefined(var_4[var_10]._id_1EB1)) {
        level thread maps\_mgturret::_id_1EB2(var_4[var_10]);
      }
      if(isDefined(var_4[var_10]._id_182E)) {
        level thread maps\_spawner::_id_1EB3(var_4[var_10]);
      }
      if(isDefined(var_4[var_10]._id_1EB4)) {
        level thread maps\_vehicle::_id_1EB5(var_4[var_10]);
      }
      if(isDefined(var_4[var_10]._id_1EB6)) {
        level thread maps\_spawner::_id_1EB7(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].script_prefab_exploder)) {
        var_4[var_10].script_exploder = var_4[var_10].script_prefab_exploder;
      }
      if(isDefined(var_4[var_10].script_exploder)) {
        level thread exploder_load(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].ambient)) {
        var_4[var_10] thread maps\_audio::_id_1765(1);
      }
      if(isDefined(var_4[var_10]._id_1766) || isDefined(var_4[var_10]._id_176E) || isDefined(var_4[var_10]._id_1771) || isDefined(var_4[var_10]._id_176F) || isDefined(var_4[var_10]._id_1769) || isDefined(var_4[var_10]._id_176A) || isDefined(var_4[var_10]._id_176B) || isDefined(var_4[var_10]._id_176C)) {
        var_4[var_10] thread maps\_audio::_id_1765();
      }
      if(isDefined(var_4[var_10]._id_1EB9)) {
        level thread _id_1EF7(var_4[var_10]);
      }
      if(isDefined(var_4[var_10]._id_1EBA)) {
        level thread _id_1EFD(var_4[var_10]);
      }
      if(isDefined(var_4[var_10]._id_1EBB)) {
        var_4[var_10] thread _id_1ECF();
      }
      if(isDefined(var_4[var_10]._id_1EBC)) {
        level thread maps\_spawner::_id_1EBD(var_4[var_10]);
      }
      if(isDefined(var_4[var_10].targetname)) {
        var_13 = var_4[var_10].targetname;

        if(isDefined(var_1[var_13])) {
          level thread[[var_1[var_13]]](var_4[var_10]);
        }
      }
    }
  }
}

_id_1EBE() {
  level._id_1EBF = [];
  level._id_1EBF["intro"] = 1;
  level._id_1EBF["sp_ny_harbor"] = 1;
  level._id_1EBF["sp_ny_manhattan"] = 1;
  level._id_1EBF["warlord"] = 1;
  level._id_1EBF["london"] = 1;
}

_id_1EC0(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 thread _id_1EC1(var_0);
  }
}

_id_1EC1(var_0) {
  if(isDefined(self.vehicle)) {
    return;
  }
  if(maps\_utility::_id_1EC2()) {
    return;
  }
  thread maps\_audio::aud_send_msg("start_player_slide_trigger", self);

  if(isDefined(self._id_1EC3)) {
    return;
  }
  self endon("death");

  if(soundexists("SCN_cliffhanger_player_hillslide")) {
    self playSound("SCN_cliffhanger_player_hillslide");
  }
  var_1 = undefined;

  if(isDefined(var_0.script_accel)) {
    var_1 = var_0.script_accel;
  }
  maps\_utility::_id_1EC5(undefined, var_1);

  for(;;) {
    if(!self istouching(var_0)) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(level._id_1EC6)) {
    wait(level._id_1EC6);
  }
  maps\_utility::_id_1EC7();
  thread maps\_audio::aud_send_msg("end_player_slide_trigger", self);
}

_id_1EC8() {
  var_0 = getEntArray("generic_flickering", "targetname");
  var_1 = getEntArray("generic_pulsing", "targetname");
  var_2 = getEntArray("generic_double_strobe", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_lights::_id_1645);
  common_scripts\utility::array_thread(var_1, maps\_lights::_id_1642);
  common_scripts\utility::array_thread(var_2, maps\_lights::_id_1643);
}

_id_1EC9() {
  var_0 = getEntArray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].classname) && getsubstr(var_0[var_1].classname, 0, 7) == "weapon_") {
      var_2 = var_0[var_1];
      var_3 = getsubstr(var_2.classname, 7);

      if(isDefined(var_2._id_1ECA)) {
        var_4 = weaponclipsize(var_3);
        var_5 = weaponmaxammo(var_3);
        var_2 itemweaponsetammo(var_4, var_5, var_4, 0);
        var_6 = weaponaltweaponname(var_3);

        if(var_6 != "none") {
          var_7 = weaponclipsize(var_6);
          var_8 = weaponmaxammo(var_6);
          var_2 itemweaponsetammo(var_7, var_8, var_7, 1);
        }

        continue;
      }

      var_9 = 0;
      var_4 = undefined;
      var_10 = undefined;
      var_11 = 0;
      var_12 = undefined;
      var_13 = undefined;

      if(isDefined(var_2._id_1ECB)) {
        var_4 = var_2._id_1ECB;
        var_9 = 1;
      }

      if(isDefined(var_2._id_1ECC)) {
        var_10 = var_2._id_1ECC;
        var_9 = 1;
      }

      if(isDefined(var_2._id_1ECD)) {
        var_12 = var_2._id_1ECD;
        var_11 = 1;
      }

      if(isDefined(var_2._id_1ECE)) {
        var_13 = var_2._id_1ECE;
        var_11 = 1;
      }

      if(var_9) {
        if(!isDefined(var_4)) {}

        if(!isDefined(var_10)) {}

        var_2 itemweaponsetammo(var_4, var_10);
      }

      if(var_11) {
        if(!isDefined(var_12)) {}

        if(!isDefined(var_13)) {}

        var_2 itemweaponsetammo(var_12, var_13, 0, 1);
      }
    }
  }
}

_id_1ECF() {
  thread _id_1ED0();
  level endon("trigger_group_" + self._id_1EBB);
  self waittill("trigger");
  level notify("trigger_group_" + self._id_1EBB, self);
}

_id_1ED0() {
  level waittill("trigger_group_" + self._id_1EBB, var_0);

  if(self != var_0) {
    self delete();
  }
}

exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.script_exploder);
  var_0 waittill("trigger");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(!var_0 maps\_utility::script_delay()) {
      wait 4;
    }
    level thread exploder_load(var_0);
    return;
  }

  if(!var_0 maps\_utility::script_delay() && isDefined(var_0._id_1ED3)) {
    wait(var_0._id_1ED3);
  }
  common_scripts\utility::exploder(var_0.script_exploder);
  level notify("killexplodertridgers" + var_0.script_exploder);
}

_id_1ED4() {
  precacheshellshock("pain");
  precacheshellshock("default");
  level.player endon("death");
  setdvarifuninitialized("blurpain", "on");

  for(;;) {
    var_0 = level.player.health;
    level.player waittill("damage");

    if(getDvar("blurpain") == "on") {
      if(var_0 - level.player.health < 129) {
        continue;
      }
      level.player shellshock("default", 5);
    }
  }
}

_id_1ED5() {
  setDvar("usedanim", "");

  for(;;) {
    if(getDvar("usedanim") == "") {
      wait 2;
      continue;
    }

    var_0 = getDvar("usedanim");
    setDvar("usedanim", "");

    if(!isDefined(level._id_1251[var_0])) {
      continue;
    }
    for(var_1 = 0; var_1 < level._id_1251[var_0].size; var_1++) {}
  }
}

_id_1ED6(var_0) {
  if(!isDefined(level._id_1ED7)) {
    level._id_1ED7 = 0;
  }
  level._id_1ED7++;
  badplace_cylinder("badplace" + level._id_1ED7, -1, var_0.origin, var_0.radius, 1024);
}

_id_1ED8(var_0) {
  var_1 = var_0.script_exploder;

  if(!isDefined(level._id_1ED9[var_1])) {
    level._id_1ED9[var_1] = [];
  }
  var_2 = var_0.targetname;

  if(!isDefined(var_2)) {
    var_2 = "";
  }
  level._id_1ED9[var_1][level._id_1ED9[var_1].size] = var_0;

  if(maps\_utility::_id_1EDA(var_0)) {
    var_0 hide();
    return;
  }

  if(maps\_utility::_id_1EDB(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      if(isDefined(var_0.script_disconnectpaths)) {
        var_0 connectpaths();
      }
    }

    return;
  }

  if(maps\_utility::_id_1EDD(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      var_0 connectpaths();
    }
    return;
  }
}

setupexploders() {
  level._id_1ED9 = [];
  var_0 = getEntArray("script_brushmodel", "classname");
  var_1 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_0[var_0.size] = var_1[var_2];
  }
  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_prefab_exploder)) {
      var_4.script_exploder = var_4.script_prefab_exploder;
    }
    if(isDefined(var_4._id_1EDF)) {
      continue;
    }
    if(isDefined(var_4.script_exploder)) {
      _id_1ED8(var_4);
    }
  }

  var_6 = [];
  var_7 = getEntArray("script_brushmodel", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2].script_prefab_exploder)) {
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;
    }
    if(isDefined(var_7[var_2].script_exploder)) {
      var_6[var_6.size] = var_7[var_2];
    }
  }

  var_7 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2].script_prefab_exploder)) {
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;
    }
    if(isDefined(var_7[var_2].script_exploder)) {
      var_6[var_6.size] = var_7[var_2];
    }
  }

  var_7 = getEntArray("item_health", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2].script_prefab_exploder)) {
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;
    }
    if(isDefined(var_7[var_2].script_exploder)) {
      var_6[var_6.size] = var_7[var_2];
    }
  }

  if(isDefined(level._id_1EE0)) {
    var_7 = level.struct;

    for(var_2 = 0; var_2 < var_7.size; var_2++) {
      if(!isDefined(var_7[var_2])) {
        continue;
      }
      if(isDefined(var_7[var_2].script_prefab_exploder)) {
        var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;
      }
      if(isDefined(var_7[var_2].script_exploder)) {
        if(!isDefined(var_7[var_2].angles)) {
          var_7[var_2].angles = (0, 0, 0);
        }
        var_6[var_6.size] = var_7[var_2];
      }
    }
  }

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }
  var_8 = [];
  var_8["exploderchunk visible"] = 1;
  var_8["exploderchunk"] = 1;
  var_8["exploder"] = 1;
  thread _id_1EE5();

  for(var_2 = 0; var_2 < var_6.size; var_2++) {
    var_9 = var_6[var_2];
    var_4 = common_scripts\utility::createexploder(var_9.script_fxid);
    var_4.v = [];
    var_4.v["origin"] = var_9.origin;
    var_4.v["angles"] = var_9.angles;
    var_4.v["delay"] = var_9.script_delay;
    var_4.v["delay_post"] = var_9._id_1EE1;
    var_4.v["firefx"] = var_9.script_firefx;
    var_4.v["firefxdelay"] = var_9.script_firefxdelay;
    var_4.v["firefxsound"] = var_9.script_firefxsound;
    var_4.v["firefxtimeout"] = var_9.script_firefxtimeout;
    var_4.v["earthquake"] = var_9.script_earthquake;
    var_4.v["rumble"] = var_9._id_1EE2;
    var_4.v["damage"] = var_9.script_damage;
    var_4.v["damage_radius"] = var_9.script_radius;
    var_4.v["soundalias"] = var_9.script_soundalias;
    var_4.v["repeat"] = var_9.script_repeat;
    var_4.v["delay_min"] = var_9.script_delay_min;
    var_4.v["delay_max"] = var_9.script_delay_max;
    var_4.v["target"] = var_9.target;
    var_4.v["ender"] = var_9.script_ender;
    var_4.v["physics"] = var_9._id_1EE4;
    var_4.v["type"] = "exploder";

    if(!isDefined(var_9.script_fxid)) {
      var_4.v["fxid"] = "No FX";
    } else {
      var_4.v["fxid"] = var_9.script_fxid;
    }
    var_4.v["exploder"] = var_9.script_exploder;

    if(isDefined(level.createfxexploders)) {
      var_10 = level.createfxexploders[var_4.v["exploder"]];

      if(!isDefined(var_10)) {
        var_10 = [];
      }
      var_10[var_10.size] = var_4;
      level.createfxexploders[var_4.v["exploder"]] = var_10;
    }

    if(!isDefined(var_4.v["delay"])) {
      var_4.v["delay"] = 0;
    }
    if(isDefined(var_9.target)) {
      var_11 = getEntArray(var_4.v["target"], "targetname")[0];

      if(isDefined(var_11)) {
        var_12 = var_11.origin;
        var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
      } else {
        var_11 = common_scripts\utility::get_target_ent(var_4.v["target"]);

        if(isDefined(var_11)) {
          var_12 = var_11.origin;
          var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
        }
      }
    }

    if(!isDefined(level._id_1EE0)) {
      if(var_9.code_classname == "script_brushmodel" || isDefined(var_9.model)) {
        var_4.model = var_9;
        var_4.model.disconnect_paths = var_9.script_disconnectpaths;
      }
    } else {
      var_4.model = var_9;

      if(isDefined(var_4.model.script_modelname)) {
        precachemodel(var_4.model.script_modelname);
      }
    }

    if(isDefined(var_9.targetname) && isDefined(var_8[var_9.targetname])) {
      var_4.v["exploder_type"] = var_9.targetname;
    } else {
      var_4.v["exploder_type"] = "normal";
    }
    if(isDefined(var_9._id_1EDF)) {
      var_4.v["masked_exploder"] = var_9.model;
      var_4.v["masked_exploder_spawnflags"] = var_9.spawnflags;
      var_4.v["masked_exploder_script_disconnectpaths"] = var_9.script_disconnectpaths;
      var_9 delete();
    }

    var_4 common_scripts\_createfx::post_entity_creation_function();
  }
}

_id_1EE5() {
  waittillframeend;
  waittillframeend;
  waittillframeend;
  var_0 = [];

  foreach(var_2 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_3 = var_2.v["flag"];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == "nil") {
      var_2.v["flag"] = undefined;
    }
    var_0[var_3] = 1;
  }

  foreach(var_7, var_6 in var_0) {}
  thread _id_1EE6(var_7);
}

_id_1EE6(var_0) {
  if(!common_scripts\utility::flag_exist(var_0)) {
    common_scripts\utility::flag_init(var_0);
  }
  common_scripts\utility::flag_wait(var_0);

  foreach(var_2 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_3 = var_2.v["flag"];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 != var_0) {
      continue;
    }
    var_2 common_scripts\utility::activate_individual_exploder();
  }
}

_id_1EE7() {
  if(isalive(level._id_1EE8)) {
    return;
  }
  var_0 = maps\_utility::_id_1EE9(level.player.origin, "bad_guys");

  if(!isDefined(var_0)) {
    return;
  }
  if(distance(var_0.origin, level.player.origin) > 400) {
    return;
  }
  level._id_1EE8 = var_0;
  var_0 setgoalentity(level.player);
  var_0.goalradius = 512;
}

_id_1EEA() {
  for(;;) {
    self waittill("damage", var_0);

    if(isDefined(self._id_1EEB)) {
      continue;
    }
    self playrumbleonentity("damage_heavy");
  }
}

_id_1EEC() {
  for(;;) {
    level.player waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH") {
      var_5 = 0;
      var_6 = level.player.maxhealth / 100;
      var_7 = var_0 * var_6;

      if(var_7 >= 90) {
        var_5 = 4;
      } else if(var_7 >= 50) {
        var_5 = 3;
      } else if(var_7 >= 25) {
        var_5 = 2;
      } else if(var_7 > 10) {
        var_5 = 1;
      }
      if(var_5) {
        level.player shellshock("default", var_5);
      }
    }
  }
}

_id_1EED() {
  if(isDefined(level._id_1EBF[level.script])) {
    return level._id_1EBF[level.script];
  } else {
    return 0;
  }
}

_id_1932() {
  self endon("death");
  self._id_193F = 0;

  for(;;) {
    while(!self isthrowinggrenade()) {
      wait 0.05;
    }
    self._id_193F = gettime();

    while(self isthrowinggrenade()) {
      wait 0.05;
    }
  }
}

_id_1EEE() {
  if(maps\_utility::_id_0A36()) {
    return;
  }
  if(isalive(level.player)) {
    thread maps\_quotes::_id_18A8();
  }
  level.player thread _id_1932();
  level.player waittill("death", var_0, var_1, var_2);

  if(var_1 != "MOD_GRENADE" && var_1 != "MOD_GRENADE_SPLASH" && var_1 != "MOD_SUICIDE" && var_1 != "MOD_EXPLOSIVE") {
    return;
  }
  if(level.gameskill >= 2) {
    if(!_id_1EED()) {
      return;
    }
  }

  if(var_1 == "MOD_SUICIDE") {
    if(level.player._id_193F - gettime() > 3500.0) {
      return;
    }
    level notify("new_quote_string");
    thread _id_1EF3(&"SCRIPT_GRENADE_SUICIDE_LINE1", &"SCRIPT_GRENADE_SUICIDE_LINE2");
    return;
  }

  if(var_1 == "MOD_EXPLOSIVE") {
    if(level.player _id_1EF0(var_0)) {
      return;
    }
    if(level.player _id_1EF1(var_0)) {
      return;
    }
    if(level.player _id_1EEF(var_0)) {
      return;
    }
    if(level.player _id_1EF2(var_0)) {
      return;
    }
  }

  if(var_1 == "MOD_GRENADE" || var_1 == "MOD_GRENADE_SPLASH") {
    if(isDefined(var_2) && !isweapondetonationtimed(var_2)) {
      return;
    }
    level notify("new_quote_string");
    setDvar("ui_deadquote", "@SCRIPT_GRENADE_DEATH");
    thread _id_1EF5();
    return;
  }
}

_id_1EEF(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0.code_classname != "script_vehicle") {
    return 0;
  }
  level notify("new_quote_string");
  setDvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
  thread _id_1EF6("hud_burningcaricon", 96, 96);
  return 1;
}

_id_1EF0(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_0.destructible_type)) {
    return 0;
  }
  level notify("new_quote_string");

  if(issubstr(var_0.destructible_type, "vehicle")) {
    setDvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
    thread _id_1EF6("hud_burningcaricon", 96, 96);
  } else {
    setDvar("ui_deadquote", "@SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
    thread _id_1EF6("hud_destructibledeathicon", 96, 96);
  }

  return 1;
}

_id_1EF1(var_0) {
  if(level.script != "af_chase") {
    return 0;
  }
  return _id_1EF2(var_0);
}

_id_1EF2(var_0) {
  if(isDefined(level._id_193D)) {
    if(gettime() != level._id_193D["time"]) {
      return 0;
    }
    var_1 = distance(self.origin, level._id_193D["origin"]);

    if(var_1 > level._id_193D["radius"]) {
      return 0;
    }
    level notify("new_quote_string");
    setDvar("ui_deadquote", "@SCRIPT_EXPLODING_BARREL_DEATH");
    thread _id_1EF6("hud_burningbarrelicon", 64, 64);
    return 1;
  }

  return 0;
}

_id_1EF3(var_0, var_1) {
  level.player._id_1EF4 = 1;
  setDvar("ui_deadquote", "");
  wait 1.5;
  var_2 = newhudelem();
  var_2.elemtype = "font";
  var_2.font = "default";
  var_2.fontscale = 1.5;
  var_2.x = 0;
  var_2.y = -30;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.vertalign = "middle";
  var_2 settext(var_0);
  var_2.foreground = 1;
  var_2.alpha = 0;
  var_2 fadeovertime(1);
  var_2.alpha = 1;

  if(isDefined(var_1)) {
    var_2 = newhudelem();
    var_2.elemtype = "font";
    var_2.font = "default";
    var_2.fontscale = 1.5;
    var_2.x = 0;
    var_2.y = -25 + level.fontheight * var_2.fontscale;
    var_2.alignx = "center";
    var_2.aligny = "middle";
    var_2.horzalign = "center";
    var_2.vertalign = "middle";
    var_2 settext(var_1);
    var_2.foreground = 1;
    var_2.alpha = 0;
    var_2 fadeovertime(1);
    var_2.alpha = 1;
  }
}

_id_1EF5() {
  wait 1.5;
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 68;
  var_0 setshader("hud_grenadeicon", 50, 50);
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.foreground = 1;
  var_0.alpha = 0;
  var_0 fadeovertime(1);
  var_0.alpha = 1;
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 25;
  var_0 setshader("hud_grenadepointer", 50, 25);
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0.foreground = 1;
  var_0.alpha = 0;
  var_0 fadeovertime(1);
  var_0.alpha = 1;
}

_id_1EF6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1.5;
  }
  wait(var_3);
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 40;
  var_4 setshader(var_0, var_1, var_2);
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "center";
  var_4.vertalign = "middle";
  var_4.foreground = 1;
  var_4.alpha = 0;
  var_4 fadeovertime(1);
  var_4.alpha = 1;
}

_id_1EF7(var_0) {
  var_1 = var_0._id_1EB9;
  var_0 waittill("trigger");
  var_2 = getaiarray();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isalive(var_2[var_3])) {
      continue;
    }
    if(isDefined(var_2[var_3]._id_1EB9) && var_2[var_3]._id_1EB9 == var_1) {
      var_2[var_3].goalradius = 800;
      var_2[var_3] setgoalentity(level.player);
      level thread maps\_spawner::_id_1EF8(var_2[var_3]);
    }
  }
}

_id_1EF9() {
  var_0 = getent(self.target, "targetname");
  self._id_1EFA = var_0.origin[2];
  var_0 delete();
}

_id_1EFB() {
  var_0 = self getorigin();
  var_1[0] = "large";
  var_1[1] = "small";

  for(;;) {
    self waittill("trigger");
    thread common_scripts\utility::play_sound_in_space("bullet_" + common_scripts\utility::random(var_1) + "_piano", var_0);
  }
}

_id_1EFC() {
  var_0 = self getorigin();
  var_1 = "piano_" + self.script_noteworthy;
  self sethintstring(&"SCRIPT_PLATFORM_PIANO");

  for(;;) {
    self waittill("trigger");
    thread common_scripts\utility::play_sound_in_space(var_1, var_0);
  }
}

_id_1EFD(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");

    if(issubstr(var_2[0].classname, "trigger")) {
      var_1 = var_2[0];
    }
  }

  if(isDefined(var_1)) {
    var_1 waittill("trigger", var_3);
  } else {
    var_0 waittill("trigger", var_3);
  }
  var_4 = undefined;

  if(isDefined(var_1)) {
    if(var_3.team != level.player.team && level.player istouching(var_0)) {
      var_4 = level.player animscripts\battlechatter::_id_0BF2("custom");
    } else if(var_3.team == level.player.team) {
      var_5 = "axis";

      if(level.player.team == "axis") {
        var_5 = "allies";
      }
      var_6 = animscripts\battlechatter::_id_0BF3("custom", var_5);
      var_6 = maps\_utility::_id_0C26(level.player.origin, var_6);

      foreach(var_8 in var_6) {
        if(var_8 istouching(var_0)) {
          var_4 = var_8;

          if(_id_1EFF(var_8.origin)) {
            break;
          }
        }
      }
    }
  } else if(isPlayer(var_3)) {
    var_4 = var_3 animscripts\battlechatter::_id_0BF2("custom");
  } else {
    var_4 = var_3;
  }
  if(!isDefined(var_4)) {
    return;
  }
  if(!_id_1EFF(var_4.origin)) {
    return;
  }
  var_10 = var_4 maps\_utility::_id_1EFE(var_0._id_1EBA);

  if(!var_10) {
    level maps\_utility::delaythread(0.25, ::_id_1EFD, var_0);
  } else {
    var_0 notify("custom_battlechatter_done");
  }
}

_id_1EFF(var_0) {
  if(distance(var_0, level.player getorigin()) <= 512) {
    return 1;
  }
  return 0;
}

_id_1F00() {
  var_0 = getent(self.target, "targetname");
  var_1 = var_0.origin[2];
  var_0 = undefined;
  level._id_1F01 = 8;
  level._id_1F02 = 33;
  level._id_1F03 = 50;
  var_2 = 0;

  for(;;) {
    wait 0.05;

    if(!level.player._id_1E8A && var_2) {
      var_2 = 0;
      level.player allowprone(1);
      level.player allowcrouch(1);
      level.player allowstand(1);
      thread _id_1F04(level._id_1E7F);
    }

    self waittill("trigger");
    level.player._id_1E8A = 1;
    var_2 = 1;

    while(level.player istouching(self)) {
      level.player._id_1E8A = 1;
      var_3 = level.player getorigin();
      var_4 = var_3[2] - var_1;

      if(var_4 > 0) {
        break;
      }

      var_5 = int(level._id_1E7F - abs(var_4 * 5));

      if(var_5 < 50) {
        var_5 = 50;
      }
      thread _id_1F04(var_5);

      if(abs(var_4) > level._id_1F02) {
        level.player allowcrouch(0);
      } else {
        level.player allowcrouch(1);
      }
      if(abs(var_4) > level._id_1F01) {
        level.player allowprone(0);
      } else {
        level.player allowprone(1);
      }
      wait 0.5;
    }

    level.player._id_1E8A = 0;
    wait 0.05;
  }
}

_id_1F04(var_0) {
  level notify("ramping_water_movement_speed");
  level endon("ramping_water_movement_speed");
  var_1 = 0.5;
  var_2 = int(var_1 * 20);
  var_3 = getdvarint("g_speed");
  var_4 = 0;

  if(var_0 < var_3) {
    var_4 = 1;
  }
  var_5 = int(abs(var_3 - var_0));
  var_6 = int(var_5 / var_2);

  for(var_7 = 0; var_7 < var_2; var_7++) {
    var_3 = getdvarint("g_speed");

    if(var_4) {
      setsaveddvar("g_speed", var_3 - var_6);
    } else {
      setsaveddvar("g_speed", var_3 + var_6);
    }
    wait 0.05;
  }

  setsaveddvar("g_speed", var_0);
}

_id_1F05() {
  var_0 = getallnodes();
  thread maps\_mgturret::_id_1F06(var_0);
  thread maps\_mgturret::_id_1F07(var_0);
  thread maps\_colors::_id_133D(var_0);
}

_id_1F08(var_0) {
  var_1 = "not_set";

  if(isDefined(var_0.script_noteworthy)) {
    var_1 = var_0.script_noteworthy;
  }
  var_2 = getEntArray(var_0.target, "targetname");
  var_0 thread _id_1F0A(var_0.target);

  for(;;) {
    common_scripts\utility::array_thread(var_2, common_scripts\utility::trigger_off);
    var_0 waittill("trigger");
    common_scripts\utility::array_thread(var_2, common_scripts\utility::trigger_on);
    _id_1F0B(var_2, var_1);
    maps\_utility::_id_1F09(var_2, "relock");
  }
}

_id_1F0A(var_0) {
  self waittill("death");
  var_1 = getEntArray(var_0, "targetname");
  common_scripts\utility::array_thread(var_1, common_scripts\utility::trigger_off);
}

_id_1F0B(var_0, var_1) {
  level endon("unlocked_trigger_hit" + var_1);
  var_2 = spawnStruct();

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3] thread _id_1F0C(var_2, var_1);
  }
  var_2 waittill("trigger");
  level notify("unlocked_trigger_hit" + var_1);
}

_id_1F0C(var_0, var_1) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + var_1);
  self waittill("trigger");
  var_0 notify("trigger");
}

_id_1F0D() {
  var_0 = [];
  var_1 = undefined;

  if(isDefined(self.target)) {
    var_2 = getEntArray(self.target, "targetname");
    var_3 = [];

    foreach(var_5 in var_2) {
      if(var_5.classname == "script_origin") {
        var_3[var_3.size] = var_5;
      }
      if(issubstr(var_5.classname, "trigger")) {
        var_0[var_0.size] = var_5;
      }
    }

    var_2 = common_scripts\utility::getstructarray(self.target, "targetname");

    foreach(var_5 in var_2) {}
    var_3[var_3.size] = var_5;

    if(var_3.size == 1) {
      var_9 = var_3[0];
      var_1 = var_9.origin;

      if(isDefined(var_9.code_classname)) {
        var_9 delete();
      }
    }
  }

  var_10 = [];
  var_10["triggers"] = var_0;
  var_10["target_origin"] = var_1;
  return var_10;
}

_id_1F0E(var_0) {
  _id_1F12(var_0, 1);
}

_id_1F0F(var_0) {
  _id_1F12(var_0, 0);
}

_id_1F10(var_0) {
  var_1 = 3;

  if(isDefined(var_0.script_delay)) {
    var_1 = var_0.script_delay;
  }
  for(;;) {
    var_0 waittill("trigger");
    maps\_utility::set_vision_set(var_0.script_visionset, var_1);
    wait(var_1);
  }
}

_id_1F12(var_0, var_1) {
  var_2 = 0.78;

  if(isDefined(var_0._id_1F13)) {
    var_2 = var_0._id_1F13;
  }
  var_3 = var_0 _id_1F0D();
  var_4 = var_3["triggers"];
  var_5 = var_3["target_origin"];
  var_6 = isDefined(var_0._id_1692) || isDefined(var_0.script_noteworthy);
  var_7 = undefined;

  if(var_6) {
    var_7 = var_0 maps\_utility::_id_13C1();

    if(!isDefined(level.flag[var_7])) {
      common_scripts\utility::flag_init(var_7);
    }
  } else if(!var_4.size) {}

  if(var_1 && var_6) {
    level endon(var_7);
  }
  var_0 endon("death");
  var_8 = 0;

  if(isDefined(var_0._id_164F)) {
    var_8 = !issubstr("no_sight", var_0._id_164F);
  }
  for(;;) {
    if(var_6) {
      common_scripts\utility::flag_clear(var_7);
    }
    var_0 waittill("trigger", var_9);
    var_10 = [];

    while(var_9 istouching(var_0)) {
      if(var_8 && !sighttracepassed(var_9 getEye(), var_5, 0, undefined)) {
        if(var_6) {
          common_scripts\utility::flag_clear(var_7);
        }
        wait 0.5;
        continue;
      }

      var_11 = vectornormalize(var_5 - var_9.origin);
      var_12 = var_9 getplayerangles();
      var_13 = anglesToForward(var_12);
      var_14 = vectordot(var_13, var_11);

      if(var_14 >= var_2) {
        common_scripts\utility::array_thread(var_4, maps\_utility::_id_1DAA, "trigger");

        if(var_6) {
          common_scripts\utility::flag_set(var_7, var_9);
        }
        if(var_1) {
          return;
        }
        wait 2;
      } else if(var_6) {
        common_scripts\utility::flag_clear(var_7);
      }
      if(var_8) {
        wait 0.5;
        continue;
      }

      wait 0.05;
    }
  }
}

_id_1F14(var_0) {
  var_1 = [];
  var_2 = undefined;
  var_3 = var_0 _id_1F0D();
  var_1 = var_3["triggers"];
  var_2 = var_3["target_origin"];
  var_4 = isDefined(var_0._id_1692) || isDefined(var_0.script_noteworthy);
  var_5 = undefined;

  if(var_4) {
    var_5 = var_0 maps\_utility::_id_13C1();

    if(!isDefined(level.flag[var_5])) {
      common_scripts\utility::flag_init(var_5);
    }
  } else if(!var_1.size) {}

  var_0 endon("death");
  var_6 = 12;
  var_7 = [];
  var_7[var_7.size] = (0, 0, 0);
  var_7[var_7.size] = (var_6, 0, 0);
  var_7[var_7.size] = (var_6 * -1, 0, 0);
  var_7[var_7.size] = (0, var_6, 0);
  var_7[var_7.size] = (0, var_6 * -1, 0);
  var_7[var_7.size] = (0, 0, var_6);

  for(;;) {
    if(var_4) {
      common_scripts\utility::flag_clear(var_5);
    }
    var_0 waittill("trigger", var_8);

    while(level.player istouching(var_0)) {
      if(!var_8 _id_1F15(var_2, var_7)) {
        if(var_4) {
          common_scripts\utility::flag_clear(var_5);
        }
        wait 0.1;
        continue;
      }

      if(var_4) {
        common_scripts\utility::flag_set(var_5);
      }
      common_scripts\utility::array_thread(var_1, maps\_utility::_id_1DAA, "trigger");
      wait 0.5;
    }
  }
}

_id_1F15(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(sighttracepassed(self getEye(), var_0 + var_1[var_2], 1, self)) {
      return 1;
    }
  }

  return 0;
}

_id_1F16(var_0) {
  var_1 = newhudelem();
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.x = 10;
  var_1.y = 400;
  var_1 settext(var_0);
  var_1.alpha = 0;
  var_1.fontscale = 3;
  wait 1;
  var_1 fadeovertime(1);
  var_1.alpha = 1;
  wait 5;
  var_1 fadeovertime(1);
  var_1.alpha = 0;
  wait 1;
  var_1 destroy();
}

_id_1F17() {
  common_scripts\utility::create_dvar("start", "");

  if(getDvar("scr_generateClipModels") != "" && getDvar("scr_generateClipModels") != "0") {
    return;
  }
  if(!isDefined(level._id_1F18)) {
    level._id_1F18 = [];
  }
  var_0 = tolower(getDvar("start"));
  var_1 = _id_1F23();

  if(isDefined(level._id_1F19)) {
    var_0 = level._id_1F19;
  }
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_0 == var_1[var_3]) {
      var_2 = var_3;
      level._id_1F19 = var_1[var_3];
      break;
    }
  }

  if(isDefined(level._id_1F1A) && !isDefined(level._id_1F19)) {
    foreach(var_6, var_5 in var_1) {
      if(level._id_1F1A == var_5) {
        var_2 = var_6;
        level._id_1F19 = var_5;
        break;
      }
    }
  }

  if(!isDefined(level._id_1F19)) {
    if(isDefined(level._id_1F1B)) {
      level._id_1F19 = "default";
    } else if(maps\_utility::_id_1F1C()) {
      level._id_1F19 = level._id_1F18[0]["name"];
    } else {
      level._id_1F19 = "default";
    }
  }

  waittillframeend;
  thread _id_1F21();

  if(level._id_1F19 == "default") {
    if(isDefined(level._id_1F1B)) {
      level thread[[level._id_1F1B]]();
    }
  } else {
    var_7 = level._id_1F1D[level._id_1F19];
    thread[[var_7["start_func"]]]();
  }

  if(maps\_utility::_id_1451()) {
    var_8 = _id_1F1F(var_1);
    setDvar("start", var_8);
  }

  waittillframeend;
  var_9 = [];

  for(var_3 = var_2; var_3 < level._id_1F18.size; var_3++) {
    var_7 = level._id_1F18[var_3];

    if(!isDefined(var_7["logic_func"])) {
      continue;
    }
    if(_id_1F1E(var_7["logic_func"], var_9)) {
      continue;
    }
    [[var_7["logic_func"]]]();
    var_9[var_9.size] = var_7["logic_func"];
  }
}

_id_1F1E(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_1F1F(var_0) {
  var_1 = " ** No starts have been set up for this map with maps_utility::add_start().";

  if(var_0.size) {
    var_1 = " ** ";

    for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
      var_1 = var_1 + var_0[var_2] + " ";
    }
  }

  setDvar("start", var_1);
  return var_1;
}

_id_1F20(var_0, var_1) {
  var_2 = 1;
  var_3 = (0.9, 0.9, 0.9);

  if(var_1 != -1) {
    var_4 = 5;

    if(var_1 != var_4) {
      var_2 = 1 - abs(var_4 - var_1) / var_4;
    } else {
      var_3 = (1, 1, 0);
    }
  }

  if(var_2 == 0) {
    var_2 = 0.05;
  }
  var_5 = newhudelem();
  var_5.alignx = "left";
  var_5.aligny = "middle";
  var_5.x = 80;
  var_5.y = 80 + var_1 * 18;
  var_5 settext(var_0);
  var_5.alpha = 0;
  var_5.foreground = 1;
  var_5.color = var_3;
  var_5.fontscale = 1.75;
  var_5 fadeovertime(0.5);
  var_5.alpha = var_2;
  return var_5;
}

_id_1F21() {}

_id_1F22() {
  common_scripts\utility::array_call(getaiarray(), ::delete);
  common_scripts\utility::array_call(getspawnerarray(), ::delete);
}

_id_1F23() {
  var_0 = [];

  for(var_1 = 0; var_1 < level._id_1F18.size; var_1++) {
    var_0[var_0.size] = level._id_1F18[var_1]["name"];
  }
  return var_0;
}

_id_1F24() {
  level._id_1F25 = 1;

  if(level._id_1F18.size <= 0) {
    return;
  }
  var_0 = _id_1F23();
  var_0[var_0.size] = "default";
  var_0[var_0.size] = "cancel";
  var_1 = _id_1F26();
  var_2 = _id_1F20("Selected Start:", -1);
  var_2.color = (1, 1, 1);
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];
    var_6 = "[" + var_0[var_4] + "]";

    if(var_5 != "cancel" && var_5 != "default") {
      if(isDefined(level._id_1F1D[var_5]["start_loc_string"])) {
        var_6 = var_6 + " -> ";
        var_6 = var_6 + level._id_1F1D[var_5]["start_loc_string"];
      }
    }

    var_3[var_3.size] = var_6;
  }

  var_7 = var_0.size - 1;
  var_8 = 0;
  var_9 = 0;

  for(var_10 = 0; var_7 > 0; var_7--) {
    if(var_0[var_7] == level._id_1F19) {
      var_10 = 1;
      break;
    }
  }

  if(!var_10) {
    var_7 = var_0.size - 1;
  }
  _id_1F27(var_1, var_3, var_7);
  var_11 = var_7;

  for(;;) {
    if(!level.player buttonpressed("F10")) {
      level._id_1F25 = 0;
    }
    if(var_11 != var_7) {
      _id_1F27(var_1, var_3, var_7);
      var_11 = var_7;
    }

    if(!var_8) {
      if(level.player buttonpressed("UPARROW") || level.player buttonpressed("DPAD_UP") || level.player buttonpressed("APAD_UP")) {
        var_8 = 1;
        var_7--;
      }
    } else if(!level.player buttonpressed("UPARROW") && !level.player buttonpressed("DPAD_UP") && !level.player buttonpressed("APAD_UP")) {
      var_8 = 0;
    }
    if(!var_9) {
      if(level.player buttonpressed("DOWNARROW") || level.player buttonpressed("DPAD_DOWN") || level.player buttonpressed("APAD_DOWN")) {
        var_9 = 1;
        var_7++;
      }
    } else if(!level.player buttonpressed("DOWNARROW") && !level.player buttonpressed("DPAD_DOWN") && !level.player buttonpressed("APAD_DOWN")) {
      var_9 = 0;
    }
    if(var_7 < 0) {
      var_7 = var_0.size - 1;
    }
    if(var_7 >= var_0.size) {
      var_7 = 0;
    }
    if(level.player buttonpressed("BUTTON_B")) {
      _id_1F28(var_1, var_2);
      break;
    }

    if(level.player buttonpressed("kp_enter") || level.player buttonpressed("BUTTON_A") || level.player buttonpressed("enter")) {
      if(var_0[var_7] == "cancel") {
        _id_1F28(var_1, var_2);
        break;
      }

      setDvar("start", var_0[var_7]);
      level.player openpopupmenu("start");
    }

    wait 0.05;
  }
}

_id_1F26() {
  var_0 = [];

  for(var_1 = 0; var_1 < 11; var_1++) {
    var_2 = _id_1F20("", var_1);
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_1F27(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_3 + (var_2 - 5);

    if(isDefined(var_1[var_4])) {
      var_5 = var_1[var_4];
    } else {
      var_5 = "";
    }
    var_0[var_3] settext(var_5);
  }
}

_id_1F28(var_0, var_1) {
  var_1 destroy();

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] destroy();
  }
}

_id_1F29(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    for(var_3 = 0; var_3 < 5; var_3++) {
      var_0[var_2][var_3].alpha = var_1;
    }
  }
}

_id_1F2A() {}

_id_1F2B(var_0) {
  if(maps\_utility::_id_12C1()) {
    thread _id_1F35(var_0);
    return;
  }

  var_1 = var_0 maps\_utility::_id_13C1();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1);
  }
}

_id_1F2C(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isalive(var_1)) {
      continue;
    }
    var_1._id_0ECB = 1;
    var_1 thread _id_1F2D();
  }
}

_id_1F2D() {
  self notify("notify_wait_then_clear_skipBloodPool");
  self endon("notify_wait_then_clear_skipBloodPool");
  self endon("death");
  wait 2;
  self._id_0ECB = undefined;
}

_id_1F2E(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("sm_sunenable") == 1) {
      continue;
    }
    setsaveddvar("sm_sunenable", 1);
  }
}

_id_1F2F(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("sm_sunenable") == 0) {
      continue;
    }
    setsaveddvar("sm_sunenable", 0);
  }
}

_id_1F30(var_0) {
  var_1 = var_0 maps\_utility::_id_13C1();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1, var_2);
  }
}

_id_1F31(var_0) {
  var_1 = var_0 maps\_utility::_id_13C1();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  var_0._id_1F32 = level.players;
  var_0 thread _id_1F33(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0._id_1F32 = common_scripts\utility::array_remove(var_0._id_1F32, var_2);

    if(var_0._id_1F32.size) {
      continue;
    }
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1, var_2);
  }
}

_id_1F33(var_0) {
  for(;;) {
    level waittill(var_0);

    if(common_scripts\utility::flag(var_0)) {
      self._id_1F32 = [];
      continue;
    }

    self._id_1F32 = level.players;
  }
}

_id_1F34(var_0) {
  var_1 = var_0 maps\_utility::_id_13C1();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isalive(var_2)) {
      continue;
    }
    if(!isPlayer(var_2)) {
      continue;
    }
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_set(var_1, var_2);
  }
}

_id_1F35(var_0) {
  var_1 = var_0 maps\_utility::_id_13C1();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  var_2 = [];

  for(;;) {
    var_0 waittill("trigger", var_3);

    if(!isPlayer(var_3)) {
      continue;
    }
    var_4 = [];
    var_4[var_4.size] = var_3;
    var_2 = maps\_utility::_id_1843(var_2, var_4);

    if(var_2.size == level.players.size) {
      break;
    }
  }

  var_0 maps\_utility::script_delay();
  common_scripts\utility::flag_set(var_1);
}

_id_1F36(var_0) {
  var_1 = var_0 maps\_utility::_id_13C1();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger");
    var_0 maps\_utility::script_delay();
    common_scripts\utility::flag_clear(var_1);
  }
}

_id_1F37(var_0) {
  level._id_1F38[1] = ::_id_1F42;
  level._id_1F38[0] = ::_id_1F43;
  var_1 = getent(var_0.target, "targetname");

  for(;;) {
    var_0 waittill("trigger");
    var_2 = getaiarray("allies");

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2[var_3][[level._id_1F38[var_2[var_3] istouching(var_1)]]]();
    }
    while(level.player istouching(var_0)) {
      wait 0.05;
    }
    var_2 = getaiarray("allies");

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2[var_3][[level._id_1F38[0]]]();
    }
  }
}

_id_1F39() {
  self endon("death");
  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;
}

_id_1F3A(var_0) {
  var_1 = [];
  var_1[0] = var_0;

  for(var_2 = 0; var_2 < level._id_1F3B[var_0].size; var_2++) {
    var_1[var_1.size] = level._id_1F3B[var_0][var_2];
  }
  return var_1;
}

_id_1F3C(var_0, var_1) {
  self endon("death");
  var_2 = _id_1F3A(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    self._id_1F3D[var_2[var_3]] = 1;
    self._id_1F3E[var_2[var_3]] = 1;
  }

  thread _id_1F39();
  var_4 = getaiarray();

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(var_6._id_1F3D[var_2[var_3]]) {
        var_6 eqoff();
        break;
      }
    }
  }

  while(self istouching(var_1)) {
    wait 0.05;
  }
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    self._id_1F3D[var_2[var_3]] = 0;
    self._id_1F3E[var_2[var_3]] = undefined;
  }

  var_4 = getaiarray();

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_5];
    var_7 = 0;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(var_6._id_1F3D[var_2[var_3]]) {
        var_7 = 1;
      }
    }

    if(!var_7) {
      continue;
    }
    var_8 = getarraykeys(self._id_1F3E);
    var_9 = 0;

    for(var_10 = 0; var_10 < var_8.size; var_10++) {
      if(!var_6._id_1F3D[var_8[var_10]]) {
        continue;
      }
      var_9 = 1;
      break;
    }

    if(!var_9) {
      var_6 eqon();
    }
  }
}

_id_1F3F(var_0, var_1) {
  self endon("death");
  var_2 = _id_1F3A(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    self._id_1F3D[var_2[var_3]] = 1;
    self._id_1F3E[var_2[var_3]] = 1;
  }

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(level.player._id_1F3D[var_2[var_3]]) {
      self eqoff();
      break;
    }
  }

  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;

  while(self istouching(var_1)) {
    wait 0.5;
  }
  var_2 = _id_1F3A(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    self._id_1F3D[var_2[var_3]] = 0;
    self._id_1F3E[var_2[var_3]] = undefined;
  }

  var_4 = getarraykeys(self._id_1F3E);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(level.player._id_1F3D[var_4[var_5]]) {
      return;
    }
  }

  self eqon();
}

_id_1F40() {
  level._id_1F38[0] = ::_id_1F42;
  level._id_1F38[1] = ::_id_1F43;
  var_0 = 0;

  for(;;) {
    while(!level._id_1F41.size) {
      wait 0.05;
    }
    waittillframeend;
    waittillframeend;
    var_1 = getarraykeys(level._id_1F41);
    var_0++;

    if(var_0 >= var_1.size) {
      var_0 = 0;
    }
    var_2 = level._id_1F41[var_1[var_0]];
    var_2[[level._id_1F38[sighttracepassed(level.player getEye(), var_2 getEye(), 0, undefined)]]]();
    wait 0.05;
  }
}

_id_1F42() {
  self eqon();
}

_id_1F43() {
  self eqoff();
}

_id_1F44(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(level.trigger_flags[var_2])) {
      level.trigger_flags[var_2] = [];
    }
    level.trigger_flags[var_2][level.trigger_flags[var_2].size] = self;
  }
}

_id_1F45(var_0) {
  var_1 = common_scripts\utility::create_flags_and_return_tokens(var_0.script_flag_false);
  var_0 _id_1F44(var_1);
  var_0 common_scripts\utility::update_trigger_based_on_flags();
}

_id_1F46(var_0) {
  var_1 = common_scripts\utility::create_flags_and_return_tokens(var_0.script_flag_true);
  var_0 _id_1F44(var_1);
  var_0 common_scripts\utility::update_trigger_based_on_flags();
}

_id_1F47(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level endon(var_0[var_1]);
  }
  level waittill("foreverrr");
}

_id_1F48(var_0) {
  var_1 = [];
  var_2 = common_scripts\utility::getstructarray(var_0.target, "targetname");
  var_3 = getEntArray(var_0.target, "targetname");

  foreach(var_5 in var_3) {
    var_6 = spawnStruct();
    var_6.origin = var_5.origin;
    var_6._id_164F = var_5._id_164F;
    var_6.script_damage = var_5.script_damage;
    var_6.radius = var_5.radius;
    var_2[var_2.size] = var_6;
    var_5 delete();
  }

  var_0._id_1F49 = var_2[0].origin;
  var_0 waittill("trigger");
  var_0 maps\_utility::script_delay();

  foreach(var_6 in var_2) {
    var_9 = var_6.radius;
    var_10 = var_6._id_164F;
    var_11 = var_6.script_damage;

    if(!isDefined(var_9)) {
      var_9 = 350;
    }
    if(!isDefined(var_10)) {
      var_10 = 0.25;
    }
    setDvar("tempdvar", var_10);
    var_10 = getdvarfloat("tempdvar");

    if(isDefined(var_11)) {
      radiusdamage(var_6.origin, var_9, var_11, var_11 * 0.5);
    }
    physicsexplosionsphere(var_6.origin, var_9, var_9 * 0.5, var_10);
  }
}

_id_1F4A(var_0) {
  for(;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_clear("respawn_friendlies");
  }
}

_id_1F4B(var_0) {
  var_0 endon("death");
  var_1 = getent(var_0.target, "targetname");
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = var_1.origin;
    var_1 delete();
  } else {
    var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
    var_2 = var_1.origin;
  }

  for(;;) {
    var_0 waittill("trigger");
    level._id_13A9 = var_2;
    common_scripts\utility::flag_set("respawn_friendlies");
    wait 0.5;
  }
}

_id_1F4C(var_0) {
  for(;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_clear("respawn_friendlies");
    wait 0.5;
  }
}

_id_1F4D(var_0) {
  var_0 waittill("trigger");
  var_0 _id_1F4E();
}

_id_1F4E() {
  var_0 = 80;

  if(isDefined(self.radius)) {
    var_0 = self.radius;
  }
  var_1 = maps\_utility::_id_1F4F();

  foreach(var_3 in var_1) {}
  radiusdamage(var_3.origin, var_0, 5000, 5000);

  self delete();
}

_id_1F50(var_0) {
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(!isalive(var_2)) {
      continue;
    }
    if(distance(var_2.origin, var_0.origin) > 940) {
      continue;
    }
    break;
  }

  var_0 _id_1F4E();
}

_id_1F51(var_0) {
  var_0 waittill("trigger");
  maps\_utility::_id_11F4(var_0.script_noteworthy);
}

_id_1F52() {
  self.origin = self.origin - self._id_1F53;
}

_id_1F54(var_0) {
  thread _id_1F59(var_0, maps\_utility::_id_0A23, maps\_utility::_id_1F55);
}

_id_1F56(var_0) {
  thread _id_1F59(var_0, maps\_utility::_id_1F58, maps\_utility::_id_1F57);
}

_id_1F59(var_0, var_1, var_2) {
  for(;;) {
    var_0 waittill("trigger", var_3);

    if(!isalive(var_3)) {
      continue;
    }
    if(var_3[[var_2]]()) {
      continue;
    }
    var_3 thread _id_1F5A(var_0, var_1);
  }
}

_id_1F5A(var_0, var_1) {
  self endon("death");
  self.ignoreme = 1;
  [[var_1]](1);
  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;

  while(self istouching(var_0)) {
    wait 1;
  }
  [[var_1]](0);
}

_id_1F5B(var_0) {
  var_0 waittill("trigger");
  var_0 common_scripts\utility::trigger_off();

  if(!isDefined(var_0.script_linkto)) {
    return;
  }
  var_1 = strtok(var_0.script_linkto, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    common_scripts\utility::array_thread(getEntArray(var_1[var_2], "script_linkname"), common_scripts\utility::trigger_off);
  }
}

_id_1F5C(var_0) {
  level._id_1F5D = var_0;
  precachemodel(level._id_1F5D);
}

_id_1F5E(var_0) {
  if(!isDefined(level._id_1F5F)) {
    level._id_1F5F = [];
  }
  waittillframeend;
  var_1 = var_0._id_1F60;
  var_0 waittill("trigger", var_2);

  if(isDefined(level._id_1F5F[var_1])) {
    return;
  }
  level._id_1F5F[var_1] = 1;
  var_2 maps\_utility::_id_1F61(var_1);
}

_id_1F62() {
  if(getDvar("stuntime") == "") {
    setDvar("stuntime", "1");
  }
  level.player._id_1F63 = 1;

  for(;;) {
    self waittill("damage");

    if(getdvarint("stuntime") == 0) {
      continue;
    }
    thread _id_1F64(self playerads());
  }
}

_id_1F64(var_0) {
  self notify("stun_player");
  self endon("stun_player");

  if(var_0 > 0.3) {
    if(level.player._id_1F63 == 1) {
      level.player playSound("player_hit_while_ads");
    }
    level.player._id_1F63 = 0;
    level.player allowads(0);
  }

  level.player setspreadoverride(20);
  wait(getdvarint("stuntime"));
  level.player allowads(1);
  level.player._id_1F63 = 1;
  level.player resetspreadoverride();
}

_id_1F65(var_0) {
  var_0 endon("death");
  var_0 waittill("trigger");
  maps\_utility::_id_0F38();
}

_id_1F66(var_0) {
  var_1 = var_0 maps\_utility::_id_13C1();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger");
    wait 1;

    if(var_0 _id_1F67()) {
      continue;
    }
    break;
  }

  common_scripts\utility::flag_set(var_1);
}

_id_1F67() {
  var_0 = getaiarray("bad_guys");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isalive(var_2)) {
      continue;
    }
    if(var_2 istouching(self)) {
      return 1;
    }
    wait 0.1;
  }

  var_0 = getaiarray("bad_guys");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2 istouching(self)) {
      return 1;
    }
  }

  return 0;
}

_id_1F68(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

_id_1F69(var_0) {
  var_1 = var_0 maps\_utility::_id_13C1();

  if(!isDefined(level.flag[var_1])) {
    common_scripts\utility::flag_init(var_1);
  }
  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 maps\_utility::script_delay();

    if(isalive(var_2) && var_2 istouching(var_0) && isDefined(var_0)) {
      common_scripts\utility::flag_set(var_1);
    }
    while(isalive(var_2) && var_2 istouching(var_0) && isDefined(var_0)) {
      wait 0.25;
    }
    common_scripts\utility::flag_clear(var_1);
  }
}

_id_1F6A() {
  var_0 = "1.0 1.0 1.0";
  var_1 = "0.9 0.9 0.9";
  var_2 = "0.85 0.85 0.85";

  if(level.script == "armada") {
    setsaveddvar("con_typewriterColorBase", var_1);
    return;
  }

  setsaveddvar("con_typewriterColorBase", var_0);
}

_id_1F6B(var_0) {
  var_1 = [];

  if(var_0 == "grenade_launcher") {
    var_1[var_1.size] = "alt_m4_grenadier";
    var_1[var_1.size] = "alt_m4m203_acog";
    var_1[var_1.size] = "alt_m4m203_acog_payback";
    var_1[var_1.size] = "alt_m4m203_eotech";
    var_1[var_1.size] = "alt_m4m203_motion_tracker";
    var_1[var_1.size] = "alt_m4m203_reflex";
    var_1[var_1.size] = "alt_m4m203_reflex_arctic";
    var_1[var_1.size] = "alt_m4m203_silencer";
    var_1[var_1.size] = "alt_m4m203_silencer_reflex";
    var_1[var_1.size] = "alt_m16_grenadier";
    var_1[var_1.size] = "alt_ak47_grenadier";
    var_1[var_1.size] = "alt_ak47_desert_grenadier";
    var_1[var_1.size] = "alt_ak47_digital_grenadier";
    var_1[var_1.size] = "alt_ak47_fall_grenadier";
    var_1[var_1.size] = "alt_ak47_woodland_grenadier";
  } else if(var_0 == "rpg") {
    var_1[var_1.size] = "rpg";
    var_1[var_1.size] = "rpg_player";
    var_1[var_1.size] = "rpg_straight";
  } else if(var_0 == "c4") {
    var_1[var_1.size] = "c4";
  } else if(var_0 == "claymore") {
    var_1[var_1.size] = "claymore";
  } else if(var_0 == "556") {
    var_1[var_1.size] = "m4_grenadier";
    var_1[var_1.size] = "m4_grunt";
    var_1[var_1.size] = "m4_sd_cloth";
    var_1[var_1.size] = "m4_shotgun";
    var_1[var_1.size] = "m4_silencer";
    var_1[var_1.size] = "m4_silencer_acog";
    var_1[var_1.size] = "m4m203_acog";
    var_1[var_1.size] = "m4m203_acog_payback";
    var_1[var_1.size] = "m4m203_eotech";
    var_1[var_1.size] = "m4m203_motion_tracker";
    var_1[var_1.size] = "m4m203_reflex";
    var_1[var_1.size] = "m4m203_reflex_arctic";
    var_1[var_1.size] = "m4m203_silencer";
    var_1[var_1.size] = "m4m203_silencer_reflex";
    var_1[var_1.size] = "m4m203_silencer";
  } else if(var_0 == "762") {
    var_1[var_1.size] = "ak47";
    var_1[var_1.size] = "ak47_acog";
    var_1[var_1.size] = "ak47_eotech";
    var_1[var_1.size] = "ak47_grenadier";
    var_1[var_1.size] = "ak47_reflex";
    var_1[var_1.size] = "ak47_shotgun";
    var_1[var_1.size] = "ak47_silencer";
    var_1[var_1.size] = "ak47_thermal";
    var_1[var_1.size] = "ak47_desert";
    var_1[var_1.size] = "ak47_desert_acog";
    var_1[var_1.size] = "ak47_desert_eotech";
    var_1[var_1.size] = "ak47_desert_grenadier";
    var_1[var_1.size] = "ak47_desert_reflex";
    var_1[var_1.size] = "ak47_digital";
    var_1[var_1.size] = "ak47_digital_acog";
    var_1[var_1.size] = "ak47_digital_eotech";
    var_1[var_1.size] = "ak47_digital_grenadier";
    var_1[var_1.size] = "ak47_digital_reflex";
    var_1[var_1.size] = "ak47_fall";
    var_1[var_1.size] = "ak47_fall_acog";
    var_1[var_1.size] = "ak47_fall_eotech";
    var_1[var_1.size] = "ak47_fall_grenadier";
    var_1[var_1.size] = "ak47_fall_reflex";
    var_1[var_1.size] = "ak47_woodland";
    var_1[var_1.size] = "ak47_woodland_acog";
    var_1[var_1.size] = "ak47_woodland_eotech";
    var_1[var_1.size] = "ak47_woodland_grenadier";
    var_1[var_1.size] = "ak47_woodland_reflex";
  } else if(var_0 == "45") {
    var_1[var_1.size] = "ump45";
    var_1[var_1.size] = "ump45_acog";
    var_1[var_1.size] = "ump45_eotech";
    var_1[var_1.size] = "ump45_reflex";
    var_1[var_1.size] = "ump45_silencer";
    var_1[var_1.size] = "ump45_arctic";
    var_1[var_1.size] = "ump45_arctic_acog";
    var_1[var_1.size] = "ump45_arctic_eotech";
    var_1[var_1.size] = "ump45_arctic_reflex";
    var_1[var_1.size] = "ump45_digital";
    var_1[var_1.size] = "ump45_digital_acog";
    var_1[var_1.size] = "ump45_digital_eotech";
    var_1[var_1.size] = "ump45_digital_reflex";
  } else if(var_0 == "pistol") {
    var_1[var_1.size] = "beretta";
    var_1[var_1.size] = "beretta393";
    var_1[var_1.size] = "usp";
    var_1[var_1.size] = "usp_scripted";
    var_1[var_1.size] = "usp_silencer";
    var_1[var_1.size] = "glock";
  }

  var_2 = spawn("trigger_radius", self.origin, 0, 25, 32);

  for(;;) {
    common_scripts\utility::flag_wait("allow_ammo_pickups");
    var_2 waittill("trigger", var_3);

    if(!common_scripts\utility::flag("allow_ammo_pickups")) {
      continue;
    }
    if(!isDefined(var_3)) {
      continue;
    }
    if(!isPlayer(var_3)) {
      continue;
    }
    var_4 = undefined;
    var_5 = undefined;
    var_6 = var_3 getweaponslistall();

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      for(var_8 = 0; var_8 < var_1.size; var_8++) {
        if(var_6[var_7] == var_1[var_8]) {
          var_4 = var_6[var_7];
        }
      }
    }

    if(!isDefined(var_4) && var_0 == "claymore") {
      var_5 = 1;
      var_4 = "claymore";
      break;
    }

    if(!isDefined(var_4) && var_0 == "c4") {
      var_5 = 1;
      var_4 = "c4";
      break;
    }

    if(!isDefined(var_4)) {
      continue;
    }
    if(var_3 getfractionmaxammo(var_4) >= 1) {
      continue;
    }
    break;
  }

  if(isDefined(var_5)) {
    var_3 giveweapon(var_4);
  } else {
    var_9 = 1;

    if(var_0 == "556" || var_0 == "762") {
      var_9 = 30;
    } else if(var_0 == "45") {
      var_9 = 25;
    } else if(var_0 == "pistol") {
      var_9 = 15;
    }
    var_3 setweaponammostock(var_4, var_3 getweaponammostock(var_4) + var_9);
  }

  var_3 playlocalsound("grenade_pickup");
  var_2 delete();

  if(isDefined(self)) {
    self delete();
  }
}

_id_1F6C() {
  var_0 = [];

  if(!isDefined(self.script_linkto)) {
    return var_0;
  }
  var_1 = strtok(self.script_linkto, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = getent(var_3, "script_linkname");

    if(isDefined(var_4)) {
      var_0[var_0.size] = var_4;
    }
  }

  return var_0;
}

_id_1F6D(var_0) {
  var_0 waittill("trigger");
  var_1 = var_0 _id_1F6C();
  common_scripts\utility::array_thread(var_1, ::_id_1F6E);
}

_id_1F6E() {
  var_0 = _id_1F6C();
  common_scripts\utility::array_thread(var_0, ::_id_1F6E);
  self delete();
}

_id_1F6F(var_0) {
  waittillframeend;
  var_1 = var_0._id_1F70;
  var_2 = var_0._id_1F71;
  var_0._id_1F72 = 0;

  if(isDefined(var_1) && isDefined(var_2)) {
    var_3 = maps\_utility::_id_1F73(var_1);
    var_4 = maps\_utility::_id_1F73(var_2);
    var_0._id_1F74 = var_3.startdist;
    var_0._id_1F75 = var_3.halfwaydist;
    var_0._id_1F76 = (var_3.red, var_3.green, var_3.blue);
    var_0._id_1F77 = var_3.maxopacity;
    var_0._id_1F72 = isDefined(var_3._id_1AF0) || isDefined(var_4._id_1AF0);

    if(isDefined(var_3._id_1AF0)) {
      var_0._id_1F78 = (var_3._id_1AF0, var_3._id_1AF1, var_3._id_1AF2);
      var_0._id_1F79 = var_3._id_1AF3;
      var_0._id_1F7A = var_3._id_1AF4;
      var_0._id_1F7B = var_3._id_1AF5;
      var_0._id_1F7C = var_3._id_1AF6;
    } else if(var_0._id_1F72) {
      var_0._id_1F78 = var_0._id_1F76;
      var_0._id_1F79 = (0, 0, 0);
      var_0._id_1F7A = 0;
      var_0._id_1F7B = 90;
      var_0._id_1F7C = 1;
    }

    var_0._id_1F7D = var_4.startdist;
    var_0._id_1F7E = var_4.halfwaydist;
    var_0._id_1F7F = (var_3.red, var_3.green, var_3.blue);
    var_0._id_1F80 = var_4.maxopacity;

    if(isDefined(var_4._id_1AF0)) {
      var_0._id_1F81 = (var_4._id_1AF0, var_4._id_1AF1, var_4._id_1AF2);
      var_0._id_1F82 = var_4._id_1AF3;
      var_0._id_1F83 = var_4._id_1AF4;
      var_0._id_1F84 = var_4._id_1AF5;
      var_0._id_1F85 = var_4._id_1AF6;
    } else if(var_0._id_1F72) {
      var_0._id_1F81 = var_0._id_1F7F;
      var_0._id_1F82 = (0, 0, 0);
      var_0._id_1F83 = 0;
      var_0._id_1F84 = 90;
      var_0._id_1F85 = 1;
    }
  }

  var_5 = getent(var_0.target, "targetname");
  var_6 = var_5.origin;
  var_7 = undefined;

  if(isDefined(var_5.target)) {
    var_8 = getent(var_5.target, "targetname");
    var_7 = var_8.origin;
  } else {
    var_7 = var_6 + (var_0.origin - var_6) * 2;
  }
  var_9 = distance(var_6, var_7);

  for(;;) {
    var_0 waittill("trigger", var_10);
    var_11 = 0;

    while(var_10 istouching(var_0)) {
      var_11 = maps\_utility::_id_1951(var_6, var_7, var_10.origin, var_9);
      var_11 = clamp(var_11, 0, 1);
      var_0 _id_1F86(var_11);
      wait 0.05;
    }

    if(var_11 > 0.5) {
      var_11 = 1;
    } else {
      var_11 = 0;
    }
    var_0 _id_1F86(var_11);
  }
}

_id_1F86(var_0) {
  var_1 = 1 - var_0;
  var_2 = self._id_1F74 * var_1 + self._id_1F7D * var_0;
  var_3 = self._id_1F75 * var_1 + self._id_1F7E * var_0;
  var_4 = self._id_1F76 * var_1 + self._id_1F7F * var_0;
  var_5 = self._id_1F77;
  var_6 = self._id_1F80;

  if(!isDefined(var_5)) {
    var_5 = 1;
  }
  if(!isDefined(var_6)) {
    var_6 = 1;
  }
  var_7 = var_5 * var_1 + var_6 * var_0;

  if(self._id_1F72) {
    var_8 = self._id_1F78 * var_1 + self._id_1F81 * var_0;
    var_9 = self._id_1F79 * var_1 + self._id_1F82 * var_0;
    var_10 = self._id_1F7A * var_1 + self._id_1F83 * var_0;
    var_11 = self._id_1F7B * var_1 + self._id_1F84 * var_0;
    var_12 = self._id_1F7C * var_1 + self._id_1F85 * var_0;
    setexpfog(var_2, var_3, var_4[0], var_4[1], var_4[2], var_7, 0.4, var_8[0], var_8[1], var_8[2], var_9, var_10, var_11, var_12);
  } else {
    setexpfog(var_2, var_3, var_4[0], var_4[1], var_4[2], var_7, 0.4);
  }
}

_id_1F87() {
  wait 0.05;
  level.first_frame = -1;
}

_id_1F88(var_0) {
  common_scripts\utility::array_thread(level.players, ::_id_1F89, var_0);
}

_id_1F89(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 != self) {
      continue;
    }
    while(var_1 istouching(var_0)) {
      var_1 allowprone(0);
      var_1 allowcrouch(0);
      wait 0.05;
    }

    var_1 allowprone(1);
    var_1 allowcrouch(1);
  }
}

_id_1F8A(var_0) {
  common_scripts\utility::array_thread(level.players, ::_id_1F8B, var_0);
}

_id_1F8B(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 != self) {
      continue;
    }
    while(var_1 istouching(var_0)) {
      var_1 allowprone(0);
      wait 0.05;
    }

    var_1 allowprone(1);
  }
}

_id_1F8C() {
  if(isDefined(game["total characters"])) {
    var_0 = game["total characters"];
  } else {
    return;
  }
  var_1 = getaiarray("allies");
  var_2 = var_1.size;
  var_3 = 0;
  var_4 = getspawnerteamarray("allies");
  var_5 = var_4.size;
  var_6 = 0;

  for(;;) {
    if(var_2 <= 0 && var_5 <= 0 || var_0 <= 0) {
      return;
    }
    if(var_2 > 0) {
      if(isDefined(var_1[var_3]._id_0AB5)) {
        var_2--;
        var_3++;
        continue;
      }

      var_1[var_3] codescripts\character::new();
      var_1[var_3] thread codescripts\character::load(game["character" + (var_0 - 1)]);
      var_2--;
      var_3++;
      var_0--;
      continue;
    }

    if(var_5 > 0) {
      if(isDefined(var_4[var_6]._id_0AB5)) {
        var_5--;
        var_6++;
        continue;
      }

      var_7 = game["character" + (var_0 - 1)];
      maps\_utility::precache(var_7["model"]);
      maps\_utility::precache(var_7["model"]);
      var_4[var_6] thread maps\_utility::_id_1F8D(game["character" + (var_0 - 1)]);
      var_5--;
      var_6++;
      var_0--;
      continue;
    }
  }
}

_id_1F8E(var_0) {
  if(!common_scripts\utility::issuffix(var_0, "aa_")) {
    return;
  }
  [[level.sp_stat_tracking_func]](var_0);
}

_id_1F8F() {
  waittillframeend;

  if(!isDefined(level._id_1F90)) {
    return;
  }
  var_0 = getarraykeys(level._id_1F90);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isarray(level._id_1F90[var_0[var_1]])) {
      for(var_2 = 0; var_2 < level._id_1F90[var_0[var_1]].size; var_2++) {
        precachemodel(level._id_1F90[var_0[var_1]][var_2]);
      }
      continue;
    }

    precachemodel(level._id_1F90[var_0[var_1]]);
  }
}

_id_1F91() {
  var_0 = [];
  var_0["cargoship"] = 1;
  var_0["blackout"] = 1;
  var_0["armada"] = 1;
  var_0["bog_a"] = 1;
  var_0["hunted"] = 1;
  var_0["ac130"] = 1;
  var_0["bog_b"] = 1;
  var_0["airlift"] = 1;
  var_0["village_assault"] = 1;
  var_0["scoutsniper"] = 1;
  var_0["ambush"] = 1;
  var_0["sniperescape"] = 0;
  var_0["village_defend"] = 0;
  var_0["icbm"] = 1;
  var_0["launchfacility_a"] = 1;
  var_0["launchfacility_b"] = 0;
  var_0["jeepride"] = 0;
  var_0["airplane"] = 1;

  if(var_0[level.script]) {
    return;
  }
  wait 2.5;
  var_1 = "levelshots / autosave / autosave_" + level.script + "start";
  savegame("levelstart", &"AUTOSAVE_LEVELSTART", var_1, 1);
}

_id_1F92() {
  setDvar("player_died_recently", "0");
  thread _id_1F93();
  level maps\_utility::_id_09C9(common_scripts\utility::flag_wait, "missionfailed");
  level.player maps\_utility::_id_09C9(maps\_utility::_id_09CA, "death");
  maps\_utility::_id_09CB();
  var_0 = [];
  var_0[0] = 70;
  var_0[1] = 30;
  var_0[2] = 0;
  var_0[3] = 0;
  setDvar("player_died_recently", var_0[level.gameskill]);
}

_id_1F93() {
  for(;;) {
    var_0 = getdvarint("player_died_recently", 0);

    if(var_0 > 0) {
      var_0 = var_0 - 5;
      setDvar("player_died_recently", var_0);
    }

    wait 5;
  }
}

_id_1F94(var_0) {
  waittillframeend;
  var_1 = var_0._id_1F95;

  if(!isDefined(level._id_1EA0[var_1])) {
    return;
  }
  var_0 waittill("trigger");
  var_2 = common_scripts\utility::random(level._id_1EA0[var_1]);

  foreach(var_5, var_4 in var_2) {}
  var_4 maps\_utility::_id_166F();
}

_id_1F96() {
  self notify("new_recon_player");
  self endon("new_recon_player");
  self waittill("death", var_0, var_1, var_2);

  if(!isDefined(var_2)) {
    var_2 = "script_kill";
  }
  var_3 = 0;
  var_4 = "none";
  var_5 = (0, 0, 0);

  if(isDefined(var_0)) {
    var_4 = var_0.classname;
    var_5 = var_0.origin;
    var_6 = vectornormalize(var_5 - self.origin);
    var_7 = anglesToForward(self getplayerangles());
    var_3 = vectordot(var_6, var_7);
  }

  reconspatialevent(self.origin, "script_player_death: playerid %s, enemy %s, enemyposition %v, enemydotproduct %f, cause %s, weapon %s", self.unique_id, var_4, var_5, var_3, var_1, var_2);

  if(isDefined(var_0)) {
    reconspatialevent(var_0.origin, "script_player_killer: playerid %s, enemy %s, playerposition %v, enemydotproduct %f, cause %s, weapon %s", self.unique_id, var_4, self.origin, var_3, var_1, var_2);
  }
}

_id_1F97() {
  self notify("new_player_downed_recon");
  self endon("new_player_downed_recon");
  self endon("death");

  for(;;) {
    self waittill("player_downed");
    var_0 = getlevelticks() * 0.05;
    var_1 = var_0;

    if(isDefined(self._id_1F98)) {
      var_0 = var_1 - self._id_1F98;
    }
    self._id_1F98 = var_1;
    reconspatialevent(self.origin, "script_player_downed: playerid %s, leveltime %d, deltatime %d", self.unique_id, var_1, var_0);
  }
}

_id_1F99() {
  level.players = getEntArray("player", "classname");

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0].unique_id = "player" + var_0;
  }
  level.player = level.players[0];

  if(level.players.size > 1) {
    level._id_1337 = level.players[1];
  }
  level notify("level.players initialized");

  foreach(var_2 in level.players) {
    var_2 thread _id_1F96();

    if(maps\_utility::_id_0A36()) {
      var_2 thread _id_1F97();
    }
  }
}

_id_1F9A() {
  self waittill("trigger", var_0);
  maps\_utility::_id_1887();
}

_id_1F9B(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread maps\_vehicle::_id_1F9C(70);
    wait 0.05;
  }
}

_id_1F9D(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread maps\_vehicle::_id_1F9E();
    wait 0.05;
  }
}

_id_1F9F(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = [];
  var_2["left_door"] = -170;
  var_2["right_door"] = 170;

  foreach(var_4 in var_1) {
    var_5 = var_2[var_4.script_noteworthy];
    var_4 connectpaths();
    var_4 rotateyaw(var_5, 1, 0, 0.5);
  }
}

_id_1FA0(var_0) {
  var_1 = getglassarray(var_0.target);

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  for(;;) {
    level waittill("glass_break", var_2);

    if(var_2 istouching(var_0)) {
      var_3 = var_2.origin;
      wait 0.05;
      var_4 = var_2.origin;
      var_5 = undefined;

      if(var_3 != var_4) {
        var_5 = var_4 - var_3;
      }
      if(isDefined(var_5)) {
        foreach(var_7 in var_1) {}
        destroyglass(var_7, var_5);

        break;
      } else {
        foreach(var_7 in var_1) {}
        destroyglass(var_7);

        break;
      }
    }
  }

  var_0 delete();
}

_id_1FA1(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_4 = getEntArray(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      if(!issubstr(var_6.code_classname, "actor")) {
        continue;
      }
      if(!(var_6.spawnflags & 1)) {
        continue;
      }
      var_6._id_1FA2 = 1;
    }
  }

  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::_id_1FA4);
  common_scripts\utility::array_thread(var_1, maps\_utility::_id_1FA3);
}

_id_1FA4() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "info_vehicle_node") {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_1 = maps\_utility::_id_0AEC(self.origin, var_1);

  foreach(var_7, var_6 in var_1) {}
  var_6 thread maps\_utility::add_spawn_function(::_id_1FA8, self, var_7);

  common_scripts\utility::array_thread(var_1, maps\_utility::_id_166F);
  self waittill("guy_entered");
  wait 3;
  thread maps\_vehicle::_id_1FA5();

  if(!self._id_0A39.size) {
    return;
  }
  maps\_vehicle::_id_1FA6();
  maps\_vehicle::_id_1FA7();
}

_id_1FA8(var_0, var_1) {
  maps\_vehicle::_id_1FA9(var_0, var_1);
}

watchweaponchange() {
  if(!isDefined(level._id_1FAB)) {
    level._id_1FAB = loadfx("misc/thermal_tapereflect_inverted");
  }
  self endon("death");
  var_0 = self getcurrentweapon();

  if(_id_1FAC(var_0)) {
    thread _id_1FAD();
  }
  for(;;) {
    self waittill("weapon_change", var_1);

    if(_id_1FAC(var_1)) {
      thread _id_1FAD();
      continue;
    }

    self notify("acogThermalTracker");
  }
}

_id_1FAC(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 == "none") {
    return 0;
  }
  if(weaponhasthermalscope(var_0)) {
    return 1;
  }
  return 0;
}

_id_1FAD() {
  self endon("death");
  self notify("acogThermalTracker");
  self endon("acogThermalTracker");
  var_0 = 0;

  for(;;) {
    var_1 = var_0;
    var_0 = self playerads();

    if(_id_1FAE(var_0, var_1)) {
      _id_1FB1();
    } else if(_id_1FB0(var_0, var_1)) {
      _id_1FB3();
    }
    wait 0.05;
  }
}

_id_1FAE(var_0, var_1) {
  if(var_0 <= var_1) {
    return 0;
  }
  if(var_0 <= 0.65) {
    return 0;
  }
  return !isDefined(self._id_1FAF);
}

_id_1FB0(var_0, var_1) {
  if(var_0 >= var_1) {
    return 0;
  }
  if(var_0 >= 0.8) {
    return 0;
  }
  return isDefined(self._id_1FAF);
}

_id_1FB1() {
  self._id_1FAF = 1;
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1FB2)) {
      continue;
    }
    var_2._id_1FB2 = 1;
    var_2 thread _id_1FB4(self.unique_id);
  }

  if(maps\_utility::_id_12C1()) {
    var_4 = maps\_utility::_id_133A(self);

    if(!isDefined(var_4._id_1FB2)) {
      var_4._id_1FB2 = 1;
      var_4 thread _id_1FB4(self.unique_id, self);
    }
  }
}

_id_1FB3() {
  self._id_1FAF = undefined;
  level notify("thermal_fx_off" + self.unique_id);
  var_0 = getaiarray("allies");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1]._id_1FB2 = undefined;
  }
  if(maps\_utility::_id_12C1()) {
    var_2 = maps\_utility::_id_133A(self);
    var_2._id_1FB2 = undefined;
  }
}

_id_1FB4(var_0, var_1) {
  if(isDefined(self._id_0CDE)) {
    return;
  }
  level endon("thermal_fx_off" + var_0);
  self endon("death");

  for(;;) {
    if(isDefined(var_1)) {
      playfxontagforclients(level._id_1FAB, self, "J_Spine4", var_1);
    } else {
      playFXOnTag(level._id_1FAB, self, "J_Spine4");
    }
    wait 0.2;
  }
}

_id_1FB5() {
  precacheitem("claymore");
  self endon("deleted");
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"WEAPON_CLAYMORE_PICKUP");
  self makeusable();
  var_0 = weaponmaxammo("claymore") + weaponclipsize("claymore");

  if(isDefined(self._id_1ECB)) {
    var_0 = self._id_1ECB;
  }
  while(var_0 > 0) {
    self waittill("trigger", var_1);
    var_1 playSound("weap_pickup");
    var_2 = 0;

    if(!var_1 hasweapon("claymore")) {
      var_1 giveweapon("claymore");
    } else {
      var_2 = var_1 getammocount("claymore");
    }
    if(isDefined(var_0) && var_0 > 0) {
      var_0 = var_2 + var_0;
      var_3 = weaponmaxammo("claymore");
      var_4 = weaponclipsize("claymore");

      if(var_0 >= var_4) {
        var_0 = var_0 - var_4;
        var_1 setweaponammoclip("claymore", var_4);
      }

      if(var_0 >= var_3) {
        var_0 = var_0 - var_3;
        var_1 setweaponammostock("claymore", var_3);
      } else if(var_0 > 0) {
        var_1 setweaponammostock("claymore", var_0);
        var_0 = 0;
      }
    } else {
      var_1 givemaxammo("claymore");
    }
    var_5 = 4;

    if(isDefined(var_1._id_1FB6) && var_1._id_1FB6 == 4) {
      var_5 = 2;
    }
    var_1 setactionslot(var_5, "weapon", "claymore");
    var_1 switchtoweapon("claymore");
  }

  if(isDefined(self.target)) {
    var_6 = getEntArray(self.target, "targetname");

    foreach(var_8 in var_6) {}
    var_8 delete();
  }

  self makeunusable();
  self delete();
}

_id_1FB7() {
  self._id_1FB8 = spawn("script_model", self.origin + (0, 0, 28));
  self._id_1FB8 setModel("tag_origin");
  self._id_1FB8 makeusable();
  self._id_1FB8 setcursorhint("HINT_NOICON");
  self._id_1FB8 sethintstring(&"WEAPON_CACHE_USE_HINT");
  thread _id_1FB9();

  for(;;) {
    self._id_1FB8 waittill("trigger", var_0);
    self._id_1FB8 makeunusable();
    var_0 playSound("player_refill_all_ammo");
    var_0 disableweapons();
    var_1 = var_0 getweaponslistall();

    foreach(var_3 in var_1) {
      if(var_3 == "claymore") {
        continue;
      }
      if(var_3 == "c4") {
        continue;
      }
      var_0 givemaxammo(var_3);
      var_4 = weaponclipsize(var_3);

      if(isDefined(var_4)) {
        if(var_0 getweaponammoclip(var_3) < var_4) {
          var_0 setweaponammoclip(var_3, var_4);
        }
      }
    }

    wait 1.5;
    var_0 enableweapons();
    self._id_1FB8 makeusable();
  }
}

_id_1FB9() {
  var_0 = spawn("trigger_radius", self.origin, 0, 320, 72);
  var_1 = newhudelem();
  var_1 setshader("waypoint_ammo", 1, 1);
  var_1.alpha = 0;
  var_1.color = (1, 1, 1);
  var_1.x = self.origin[0];
  var_1.y = self.origin[1];
  var_1.z = self.origin[2] + 16;
  var_1 setwaypoint(1, 1);
  self._id_1FBA = var_1;
  self._id_1FBB = var_0;

  if(isDefined(self._id_1FBC) && self._id_1FBC) {
    _id_1FBE(var_1);
    return;
  }

  wait 0.05;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    while(var_2 istouching(var_0)) {
      var_3 = 1;
      var_4 = var_2 getcurrentweapon();

      if(var_4 == "none") {
        var_3 = 0;
      } else if(var_2 getfractionmaxammo(var_4) > 0.9) {
        var_3 = 0;
      }
      if(maps\_utility::_id_1FBD(self.origin, 0.8, 1) && var_3) {
        _id_1FBE(var_1);
      } else {
        _id_1FBF(var_1);
      }
      wait 0.25;
    }

    _id_1FBF(var_1);
  }
}

_id_1FBE(var_0) {
  if(var_0.alpha != 0) {
    return;
  }
  var_0 fadeovertime(0.2);
  var_0.alpha = 0.3;
  wait 0.2;
}

_id_1FBF(var_0) {
  if(var_0.alpha == 0) {
    return;
  }
  var_0 fadeovertime(0.2);
  var_0.alpha = 0;
  wait 0.2;
}

_id_1FC0(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(var_0._id_1B0E) && isDefined(var_0._id_1B0F)) {
    var_1 = 1;
    var_3 = getent(var_0.target, "targetname");

    if(!isDefined(var_3)) {
      var_3 = common_scripts\utility::getstruct(var_0.target, "targetname");
    }
    var_4 = getent(var_3.target, "targetname");

    if(!isDefined(var_4)) {
      var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");
    }
    var_3 = var_3.origin;
    var_4 = var_4.origin;
    var_2 = distance(var_3, var_4);
    var_0 _id_1FC1();
  }

  var_5 = -1;

  for(;;) {
    var_0 waittill("trigger", var_6);

    if(isPlayer(var_6)) {
      if(var_1) {
        var_7 = 0;

        while(var_6 istouching(var_0)) {
          var_7 = maps\_utility::_id_1951(var_3, var_4, var_6.origin, var_2);
          var_7 = clamp(var_7, 0, 1);

          if(var_7 != var_5) {
            var_5 = var_7;
            var_6 _id_1FCB(var_0, var_7);
          }

          wait 0.05;
        }

        if(var_7 < 0.5) {
          var_6 maps\_utility::vision_set_fog_changes(var_0._id_1B0E, var_0.script_delay);
        } else {
          var_6 maps\_utility::vision_set_fog_changes(var_0._id_1B0F, var_0.script_delay);
        }
        continue;
      }

      var_6 maps\_utility::vision_set_fog_changes(var_0.script_visionset, var_0.script_delay);
    }
  }
}

_id_1FC1() {
  if(!isDefined(self.script_delay)) {
    self.script_delay = 2;
  }
  var_0 = maps\_utility::_id_1FC2(self._id_1B0E);
  var_1 = maps\_utility::_id_1FC2(self._id_1B0F);

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = spawnStruct();
  var_2.startdist = var_1.startdist - var_0.startdist;
  var_2.halfwaydist = var_1.halfwaydist - var_0.halfwaydist;
  var_2.red = var_1.red - var_0.red;
  var_2.blue = var_1.blue - var_0.blue;
  var_2.green = var_1.green - var_0.green;
  var_2.maxopacity = var_1.maxopacity - var_0.maxopacity;
  var_2.sunfogenabled = isDefined(var_0.sunfogenabled) || isDefined(var_1.sunfogenabled);
  var_3 = 0;

  if(isDefined(var_0._id_1AF0)) {
    var_3 = var_0._id_1AF0;
  }
  var_4 = 0;

  if(isDefined(var_1._id_1AF0)) {
    var_4 = var_1._id_1AF0;
  }
  var_2._id_1FC3 = var_3;
  var_2._id_1AF0 = var_4 - var_3;
  var_5 = 0;

  if(isDefined(var_0._id_1AF1)) {
    var_5 = var_0._id_1AF1;
  }
  var_6 = 0;

  if(isDefined(var_1._id_1AF1)) {
    var_6 = var_1._id_1AF1;
  }
  var_2._id_1FC4 = var_5;
  var_2._id_1AF1 = var_6 - var_5;
  var_7 = 0;

  if(isDefined(var_0._id_1AF2)) {
    var_7 = var_0._id_1AF2;
  }
  var_8 = 0;

  if(isDefined(var_1._id_1AF2)) {
    var_8 = var_1._id_1AF2;
  }
  var_2._id_1FC5 = var_7;
  var_2._id_1AF2 = var_8 - var_7;
  var_9 = (0, 0, 0);

  if(isDefined(var_0._id_1AF3)) {
    var_9 = var_0._id_1AF3;
  }
  var_10 = (0, 0, 0);

  if(isDefined(var_1._id_1AF3)) {
    var_10 = var_1._id_1AF3;
  }
  var_2._id_1FC6 = var_9;
  var_2._id_1AF3 = var_10 - var_9;
  var_11 = 0;

  if(isDefined(var_0._id_1AF4)) {
    var_11 = var_0._id_1AF4;
  }
  var_12 = 0;

  if(isDefined(var_1._id_1AF4)) {
    var_12 = var_1._id_1AF4;
  }
  var_2._id_1FC7 = var_11;
  var_2._id_1AF4 = var_12 - var_11;
  var_13 = 0;

  if(isDefined(var_0._id_1AF5)) {
    var_13 = var_0._id_1AF5;
  }
  var_14 = 0;

  if(isDefined(var_1._id_1AF5)) {
    var_14 = var_1._id_1AF5;
  }
  var_2._id_1FC8 = var_13;
  var_2._id_1AF5 = var_14 - var_13;
  var_15 = 0;

  if(isDefined(var_0._id_1AF6)) {
    var_15 = var_0._id_1AF6;
  }
  var_16 = 0;

  if(isDefined(var_1._id_1AF6)) {
    var_16 = var_1._id_1AF6;
  }
  var_2._id_1FC9 = var_15;
  var_2._id_1AF6 = var_16 - var_15;
  self._id_1FCA = var_2;
}

_id_1FCB(var_0, var_1) {
  maps\_utility::_id_1FCC();

  if(var_1 < 0.5) {
    self._id_1AE2._id_1AE3 = var_0._id_1B0E;
  } else {
    self._id_1AE2._id_1AE3 = var_0._id_1B0F;
  }
  self._id_1AE2.time = 0;

  if(var_0._id_1B0E == var_0._id_1B0F) {
    return;
  }
  self visionsetnakedforplayer_lerp(var_0._id_1B0E, var_0._id_1B0F, var_1);
  var_2 = maps\_utility::_id_1FC2(var_0._id_1B0E);
  var_3 = maps\_utility::_id_1FC2(var_0._id_1B0F);
  var_4 = var_0._id_1FCA;
  var_5 = spawnStruct();
  var_5.startdist = var_2.startdist + var_4.startdist * var_1;
  var_5.halfwaydist = var_2.halfwaydist + var_4.halfwaydist * var_1;
  var_5.halfwaydist = max(1, var_5.halfwaydist);
  var_5.red = var_2.red + var_4.red * var_1;
  var_5.green = var_2.green + var_4.green * var_1;
  var_5.blue = var_2.blue + var_4.blue * var_1;
  var_5.maxopacity = var_2.maxopacity + var_4.maxopacity * var_1;

  if(var_4.sunfogenabled) {
    var_5.sunfogenabled = 1;
    var_5._id_1AF0 = var_4._id_1FC3 + var_4._id_1AF0 * var_1;
    var_5._id_1AF1 = var_4._id_1FC4 + var_4._id_1AF1 * var_1;
    var_5._id_1AF2 = var_4._id_1FC5 + var_4._id_1AF2 * var_1;
    var_5._id_1AF3 = var_4._id_1FC6 + var_4._id_1AF3 * var_1;
    var_5._id_1AF4 = var_4._id_1FC7 + var_4._id_1AF4 * var_1;
    var_5._id_1AF5 = var_4._id_1FC8 + var_4._id_1AF5 * var_1;
    var_5._id_1AF6 = var_4._id_1FC9 + var_4._id_1AF6 * var_1;
  }

  maps\_utility::_id_1AF7(var_5, 0.05);
}

_id_1FCD() {
  var_0 = getglass(self.target);

  if(!isDefined(var_0)) {
    return;
  }
  level waittillmatch("glass_destroyed", var_0);
  self delete();
}

_id_1FCE(var_0, var_1, var_2, var_3, var_4) {}

_id_1FCF(var_0) {
  var_1 = var_0._id_164F;

  if(!isDefined(level._id_1E6A)) {
    level._id_1E6A = "";
  }
  for(;;) {
    var_0 waittill("trigger");

    if(level._id_1E6A != var_1) {
      maps\_compass::setupminimap(var_1);
    }
  }
}

_id_1FD0(var_0, var_1, var_2) {
  if(isDefined(var_0.v["soundalias"]) && var_0.v["soundalias"] != "nil") {
    if(!isDefined(var_0.v["stopable"]) || !var_0.v["stopable"]) {
      return;
    }
  }

  var_2.origin = var_0.v["origin"];

  if(var_2 istouching(var_1)) {
    var_1.fx[var_1.fx.size] = var_0;
  }
}

_id_1FD1(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0.fx = [];

  foreach(var_3 in level.createfxent) {}
  _id_1FD0(var_3, var_0, var_1);

  var_1 delete();

  if(!isDefined(var_0.target)) {
    return;
  }
  var_5 = getEntArray(var_0.target, "targetname");

  foreach(var_7 in var_5) {
    switch (var_7.classname) {
      case "trigger_multiple_fx_volume_on":
        var_7 thread _id_1FD2(var_0);
        break;
      case "trigger_multiple_fx_volume_off":
        var_7 thread _id_1FD3(var_0);
        break;
      default:
        break;
    }
  }
}

_id_1FD2(var_0) {
  for(;;) {
    self waittill("trigger");
    common_scripts\utility::array_thread(var_0.fx, maps\_utility::_id_1655);
    wait 1;
  }
}

_id_1FD3(var_0) {
  wait 1;
  common_scripts\utility::array_thread(var_0.fx, common_scripts\utility::pauseeffect);

  for(;;) {
    self waittill("trigger");
    common_scripts\utility::array_thread(var_0.fx, common_scripts\utility::pauseeffect);
    wait 1;
  }
}

_id_1FD4() {
  common_scripts\utility::create_dvar("weaponlist", "0");

  if(!getdvarint("weaponlist")) {
    return;
  }
  var_0 = getEntArray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.code_classname)) {
      continue;
    }
    if(issubstr(var_3.code_classname, "weapon")) {
      var_1[var_3.classname] = 1;
    }
  }

  foreach(var_7, var_6 in var_1) {}

  var_8 = getspawnerarray();
  var_9 = [];

  foreach(var_11 in var_8) {}
  var_9[var_11.code_classname] = 1;

  foreach(var_14, var_6 in var_9) {}
}

_id_1FD5() {
  level._id_1A2F = spawnStruct();
  _id_1FD6();
  notifyoncommand("_cheat_player_press_slowmo", "+melee");
  notifyoncommand("_cheat_player_press_slowmo", "+melee_breath");
  notifyoncommand("_cheat_player_press_slowmo", "+melee_zoom");
}

_id_1FD6() {
  level._id_1A2F._id_1FD7 = 0.0;
  level._id_1A2F._id_1FD8 = 0.25;
  level._id_1A2F._id_1A30 = 0.4;
  level._id_1A2F._id_1FD9 = 1.0;
}

_id_1FDA() {
  var_0 = getEntArray("script_origin_start_nogame", "classname");

  if(!var_0.size) {
    return;
  }
  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_1FDB)) {
      continue;
    }
    maps\_utility::_id_1E74("no_game_" + var_2._id_1FDB, ::_id_1F22);
  }
}

_id_1FDC() {
  if(!maps\_utility::_id_1C39()) {
    return;
  }
  setsaveddvar("ufoHitsTriggers", "1");
  level._id_1BB2 = 1;

  if(isDefined(level._id_1FDD)) {
    level[[level._id_1FDD]]();
  }
  maps\_loadout::_id_1C5B();
  thread maps\_audio::_id_16F4();
  maps\_global_fx::main();
  _id_1FDE();
  common_scripts\utility::array_call(getEntArray("truckjunk", "targetname"), ::delete);
  common_scripts\utility::array_call(getEntArray("truckjunk", "script_noteworthy"), ::delete);
  level waittill("eternity");
}

_id_1FDE() {
  var_0 = getEntArray("script_origin_start_nogame", "classname");

  if(!var_0.size) {
    return;
  }
  var_0 = sortbydistance(var_0, level.player.origin);

  if(level._id_1F19 == "no_game") {
    level.player maps\_utility::_id_1FDF(var_0[0]);
    return;
  }

  var_1 = getsubstr(level._id_1F19, 8);
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4._id_1FDB)) {
      continue;
    }
    if(var_1 != var_4._id_1FDB) {
      continue;
    }
    if(isDefined(var_4.script_visionset)) {
      maps\_utility::vision_set_fog_changes(var_4.script_visionset, 0);
    }
    level.player maps\_utility::_id_1FDF(var_4);
    var_2 = 1;
    break;
  }

  if(!var_2) {
    level.player maps\_utility::_id_1FDF(var_0[0]);
  }
}