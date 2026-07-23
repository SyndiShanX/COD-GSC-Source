/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_assassin_payback.gsc
************************************************/

#using_animtree("generic_human");

main() {
  maps/so_assassin_payback_precache::main();
  maps\payback_precache::main();
  precacheitem("smoke_grenade_american");
  precacheitem("zippy_rockets");
  level.delay_createfx_seconds = 0.5;
  maps\_compass::setupminimap("compass_map_payback_port", "port_minimap_corner");
  maps\payback_fx::main();
  _id_562F();
  level._effect["_breach_doorbreach_detpack"] = loadfx("explosions/exp_pack_doorbreach");
  level._effect["aerial_explosion_large_linger"] = loadfx("explosions/aerial_explosion_large_linger");
  maps/_chopperboss::chopper_boss_load_fx();
  level._effect["extraction_smoke"] = loadfx("smoke/signal_smoke_green");
  precacheminimapsentrycodeassets();
  maps\_utility::add_hint_string("contact_hostage", &"SO_ASSASSIN_PAYBACK_USE_HOSTAGE", ::_id_5BB2);
  maps\_utility::add_hint_string("throw_smoke", &"SO_ASSASSIN_PAYBACK_THROW_SMOKE", ::_id_5BB4);
  setup_players();
  maps\_load::main();
  maps\_stinger::init();
  _id_5BB5();
  level thread maps\_specialops::enable_escape_warning();
  level thread maps\_specialops::enable_escape_failure();
  thread maps\_specialops::enable_challenge_timer("so_assassin_payback_start", "so_assassin_payback_complete");
  thread maps\_specialops::fade_challenge_in();
  thread maps\_specialops::fade_challenge_out("so_assassin_payback_complete");
  wait 0.1;
  getEnt("pb_end_vista", "targetname") hide();
  var_0 = getEnt("intro_gate_right", "targetname");
  var_0 delete();
  var_1 = getEnt("intro_gate_left", "targetname");
  var_1 delete();
  level.scr_anim["generic"]["casual_killer_walk_f"][0] = % casual_killer_walk_f;
  level.scr_anim["generic"]["casual_stand_idle"] = % casual_stand_idle;
  level.scr_anim["generic"]["death_pose_07"] = % paris_npc_dead_poses_v07;
  level.scr_anim["generic"]["death_pose_08"] = % paris_npc_dead_poses_v08;
  maps\_shg_common::so_mark_class("trigger_multiple_audio");
  maps\_shg_common::so_mark_class("trigger_multiple_visionset");
  maps\payback_aud::main();
  wait 0.1;
  setup();
  thread _id_47C4();
  wait 0.1;
  setup_ent_rockers();
}

_id_562F() {
  foreach(var_2, var_1 in level.createfxent) {
    if(attachpath(var_1)) {
      level.createfxent[var_2] = undefined;
      var_1.v = undefined;
      continue;
    }

    var_1.script_specialops = 1;
  }

  level.createfxent = common_scripts\utility::array_removeundefined(level.createfxent);
}

attachpath(var_0) {
  if(var_0.v["type"] != "soundfx_interval" && var_0.v["type"] != "soundfx") {
    return 0;
  }
  if(var_0.v["origin"][0] > 3400) {
    return 1;
  }
  if(var_0.v["origin"][0] < -2400) {
    return 1;
  }
  if(var_0.v["origin"][1] < 3500) {
    return 1;
  }
  return 0;
}

_id_5BB2() {
  var_0 = maps\_utility::get_player_from_self();

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(var_0 == level.players[var_1]) {
      break;
    }
  }

  if(level._id_5BB3[var_1] == 1) {
    return 0;
  } else {
    return 1;
  }
}

_id_5BB4() {
  if(common_scripts\utility::flag("smoke_thrown")) {
    return 1;
  } else {
    return 0;
  }
}

_id_5BB5() {
  common_scripts\utility::flag_init("player_has_escaped");
  common_scripts\utility::flag_init("triggered_alert");
  common_scripts\utility::flag_init("triggered_alert_1");
  common_scripts\utility::flag_init("triggered_alert_3");
  common_scripts\utility::flag_init("out_of_stage_1");
  common_scripts\utility::flag_init("attack_heli_spawned");
  common_scripts\utility::flag_init("hostages_vulnerable");
  common_scripts\utility::flag_init("near_hostages");
  common_scripts\utility::flag_init("hostage_x_pressed");
  common_scripts\utility::flag_init("hostage_reached");
  common_scripts\utility::flag_init("smoke_thrown");
  common_scripts\utility::flag_init("stop_green_smoke_fx");
  common_scripts\utility::flag_init("rescue_arrives");
  common_scripts\utility::flag_init("obj_vips_dead");
  common_scripts\utility::flag_init("no_prone_water_trigger");
}

setup() {
  _id_5BD5();
  _id_555F();
  maps\_specialops::so_delete_all_by_type(maps\_specialops::type_spawn_trigger, maps\_specialops::type_vehicle, maps\_specialops::type_spawners);
  _id_5561();
  _id_5633();
  disconnect_specops_paths();
  level._id_5BB6 = [];
  level._id_5BB7 = [];
  level._id_5BB8 = [];
  level._id_5BB9 = [];
  level._id_5BBA = [];
  level._id_5BBB = [];
  level._id_5BBC = [];
  level._id_5BBD = 0;
  level._id_5BBE = 0;
  level.challenge_start_time = 0;
  level._id_5BBF = undefined;
  level._id_5BC0 = 1575;
  level._id_5BC1 = 0;
  level._id_5BC2 = 0;
  level._id_5BC3 = 0;
  level._id_5BC4 = [];
  level._id_5BC5 = [];
  level._id_5BC5[0] = 0;
  level._id_5BC5[1] = 0;
  level._id_5BC5[2] = 0;
  level._id_5BC5[3] = 0;
  level._id_5BC6 = [];
  level._id_5BB3 = [];
  level._id_5BC7 = 90;
  level._id_5BC8 = 5;
  level._id_5BC9 = 20;
  level._id_5BCA = 5;
  level._id_5BCB = 4;

  if(level.gameskill <= 1 && !maps\_utility::is_coop()) {
    level._id_5BCC = 32 + 10 * level._id_5BCB;
  } else {
    level._id_5BCC = 34 + 10 * level._id_5BCB;
  }
  level._id_5BCD = 120000;
  level._id_5BCE = 720000;
  level._id_5BCF = undefined;
  level._id_5BD0 = 15;
  level._id_5BD1 = 64;
  level._id_5BD2 = level._id_5BD1 * level._id_5BD1;
  level._id_5BD3 = 30;
  level._id_5BD4 = 0;
  thread spawn_corpses("balcony_corpses");
  _id_5BD7();
  level._id_5BBD = level._id_5BBC.size;
  level._id_5BBE = 0;
  _id_5BDA();
  level.challenge_start_time = gettime();
  level thread _id_5BF3();
}

_id_5BD5() {
  level._id_5BD6 = common_scripts\utility::array_combine(getEntArray("chopper_fog_brush", "targetname"), getEntArray("sandstorm_sky", "targetname"));

  foreach(var_1 in level._id_5BD6) {
    var_1 hide();
    var_1 notsolid();
  }
}

_id_555F() {
  var_0 = getEntArray();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_flag) && var_2.script_flag == "no_prone_water_trigger") {
      var_2.script_specialops = 1;
    }
  }
}

_id_5561() {
  var_0 = getEntArray("SO_remove_model", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] delete();
  }
  var_2 = getEntArray("SO_remove_brush", "targetname");

  for(var_1 = 0; var_1 < var_2.size; var_1++) {
    var_2[var_1] notsolid();

    if(var_2[var_1].spawnflags & 1) {
      var_2[var_1] connectpaths();
    }
  }
}

_id_5633() {
  _id_5562("placeholder_hummer_alpha", "targetname");
  _id_5562("placeholder_hummer_bravo", "targetname");
  _id_5562("misc_turret", "classname");
  _id_5562("rpg_crate_clip", "targetname");
  _id_5562("hostage_dragunov", "targetname");
  var_0 = getEntArray("explodable_barrel", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].target)) {
      var_2 = getEnt(var_0[var_1].target, "targetname");

      if(isDefined(var_2)) {
        var_2 maps\_utility::hide_entity();
      }
    }

    var_0[var_1] delete();
  }

  var_3 = getEntArray("script_model", "classname");

  for(var_1 = 0; var_1 < var_3.size; var_1++) {
    if(!isDefined(var_3[var_1].model)) {
      continue;
    }
    if(var_3[var_1].model == "pb_mortar_dmg") {
      var_3[var_1] delete();
      continue;
    }

    if(var_3[var_1].model == "prop_mortar") {
      var_3[var_1] delete();
      continue;
    }
  }

  var_4 = getEntArray("script_brushmodel", "classname");

  for(var_1 = 0; var_1 < var_4.size; var_1++) {
    if(!isDefined(var_4[var_1].script_noteworthy)) {
      continue;
    }
    if(var_4[var_1].script_noteworthy == "so_railing_remove") {
      var_4[var_1] delete();
    }
  }
}

_id_5562(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(isDefined(var_5)) {
      if(isDefined(var_2) && var_2) {
        if(isDefined(var_5.target)) {
          var_6 = getEnt(var_5.target, "targetname");

          if(isDefined(var_6)) {
            var_6 maps\_utility::hide_entity();
          }
        }
      }

      var_5 notify("delete");
      var_5 delete();
    }
  }
}

disconnect_specops_paths() {
  var_0 = getEntArray("assassin_box_clip", "targetname");

  foreach(var_2 in var_0) {}
  var_2 disconnectPaths();
}

setup_players() {
  level.sniper_primary = "dragunov";
  level.sniper_secondary = "mp5";
  level.heavy_primary = "mp5";
  level.heavy_secondary = "usp";
}

_id_5BD7() {
  maps/_chopperboss::chopper_boss_locs_populate("script_noteworthy", "struct_chopper_boss_loc");
  _id_5BD8();
  var_0 = getEntArray("vip1_guard", "script_noteworthy");
  var_1 = getEntArray("roof_guard", "script_noteworthy");
  var_0 = common_scripts\utility::array_combine(var_0, var_1);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2] maps\_utility::spawn_ai(1, 0);
    var_3.maxsightdistsqrd = level._id_5BD2;
    var_3.pacifist = 1;
    var_3.goalradius = 32;
    var_3 maps\_utility::set_generic_run_anim("casual_killer_walk_f");
    var_3 maps\_utility::set_generic_idle_anim("casual_stand_idle");
    var_3 allowedstances("stand");
    var_3.disablearrivals = 1;
    var_3.disableexits = 1;
    var_3.alertlevel = "noncombat";

    if(isDefined(var_3.target)) {
      var_3 thread _id_5C01();
    } else {
      var_3 setgoalpos(var_3.origin);
    }
    level._id_5BB6 = common_scripts\utility::add_to_array(level._id_5BB6, var_3);

    if(var_3.script_noteworthy == "roof_guard") {
      level._id_5BBB = common_scripts\utility::add_to_array(level._id_5BBB, var_3);
      var_3 thread _id_5BDF();
      continue;
    }

    var_3 thread _id_5BDE(1);
  }

  var_4 = getEntArray("vip2_guard", "script_noteworthy");

  for(var_2 = 0; var_2 < var_4.size; var_2++) {
    var_5 = var_4[var_2] maps\_utility::spawn_ai(1, 0);
    var_5.maxsightdistsqrd = level._id_5BD2;
    var_5.pacifist = 1;
    var_5.goalradius = 32;
    var_5 maps\_utility::set_generic_run_anim("casual_killer_walk_f");
    var_5 maps\_utility::set_generic_idle_anim("casual_stand_idle");
    var_5 allowedstances("stand");
    var_5.disablearrivals = 1;
    var_5.disableexits = 1;
    var_5.alertlevel = "noncombat";

    if(isDefined(var_5.target)) {
      var_5 thread _id_5C01();
    } else {
      var_5 setgoalpos(var_5.origin);
    }
    level._id_5BB7 = common_scripts\utility::add_to_array(level._id_5BB7, var_5);
    var_5 thread _id_5BDE(2);
  }

  var_6 = getEntArray("vip3_guard", "script_noteworthy");

  for(var_2 = 0; var_2 < var_6.size; var_2++) {
    var_7 = var_6[var_2] maps\_utility::spawn_ai(1, 0);
    var_7.maxsightdistsqrd = level._id_5BD2;
    var_7.pacifist = 1;
    var_7.goalradius = 32;
    var_7 setgoalpos(var_7.origin);
    var_7 maps\_utility::set_generic_run_anim("casual_killer_walk_f");
    var_7 allowedstances("stand");
    var_7.disablearrivals = 1;
    var_7.disableexits = 1;
    level._id_5BB8 = common_scripts\utility::add_to_array(level._id_5BB8, var_7);
    var_7 thread _id_5BDE(3);
  }
}

_id_5BD8() {
  var_0 = getEnt("vip_1_spawner", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1, 0);
  _id_5BD9(var_1, 1);
  var_1.targetname = "vip_1";
  level._id_5BB6[0] = var_1;
  var_2 = getEnt("vip_2_spawner", "targetname");
  var_3 = var_2 maps\_utility::spawn_ai(1, 0);
  _id_5BD9(var_3, 2);
  var_3.targetname = "vip_2";
  level._id_5BB7[0] = var_3;
  level._id_5BBC = getEntArray("vips", "script_noteworthy");
  var_1 thread _id_5BFF();
  var_3 thread _id_5C00();
  var_1 startusingheroonlylighting();
  var_3 startusingheroonlylighting();
}

_id_5BD9(var_0, var_1) {
  var_2 = 128;
  var_3 = var_2 * var_2;
  var_0.maxsightdistsqrd = var_3;
  var_0.pacifist = 1;
  var_0.goalradius = 32;
  var_0 maps\_utility::set_generic_run_anim("casual_killer_walk_f");
  var_0 allowedstances("stand");
  var_0.disablearrivals = 1;
  var_0.disableexits = 1;
  var_0 thread _id_5BE4(var_1);
  var_0 thread _id_5BDE(var_1);
  var_0.script_noteworthy = "vips";
}

_id_5BDA() {
  createthreatbiasgroup("hostages");
  maps\_utility::array_spawn_function_targetname("hostage_spawner", ::_id_5BDB);
  maps\_utility::array_spawn_targetname("hostage_spawner", 1);
  maps\_utility::ignoreeachother("hostages", "axis");
  var_0 = common_scripts\utility::getStruct("hostage_loc", "targetname");
  level._id_5BBF = var_0;
}

_id_5BDB() {
  self._id_5BDC = 1;
  self.grenadeawareness = 0;
  self.team = "allies";
  self.ignoreme = 1;
  thread maps\_utility::magic_bullet_shield();
  self.ignorerandombulletdamage = 1;
  self setthreatbiasgroup("hostages");
  thread _id_5BDD();
}

_id_5BDD() {
  common_scripts\utility::flag_wait("hostages_vulnerable");
  maps\_utility::stop_magic_bullet_shield();
  self waittill("death");

  if(common_scripts\utility::flag("so_assassin_payback_complete")) {
    return;
  }
  level._id_5BC1++;
  level.challenge_end_time = gettime();
  maps\_specialops::so_force_deadquote("@SO_ASSASSIN_PAYBACK_HOSTAGE_DEATH");
  level maps\_utility::missionfailedwrapper();
}

_id_5BDE(var_0) {
  level endon("special_op_terminated");
  common_scripts\utility::waittill_any("bulletwhizby", "flashbang", "grenade danger", "explode", "pain", "death");
  _id_5BE2();
  wait(randomfloatrange(0.5, 1.0));
  _id_5BE0(var_0, 0);
}

_id_5BDF() {
  level endon("special_op_terminated");
  level endon("roof_alerted");
  common_scripts\utility::waittill_any("bulletwhizby", "flashbang", "grenade danger", "explode", "pain", "death");
  _id_5BE2();
  wait(randomfloatrange(0.5, 1.0));

  foreach(var_1 in level._id_5BBB) {}
  var_1 _id_5BE2();

  _id_5BE0(1, 0);
  level notify("roof_alerted");
}

_id_5BE0(var_0, var_1) {
  if(_id_5BE1(var_0)) {
    return;
  }
  var_2 = [];

  switch (var_0) {
    case 1:
      var_2 = maps\_utility::remove_dead_from_array(level._id_5BB6);
      level._id_5BC5[0] = 1;

      foreach(var_4 in var_2) {
        if(isDefined(var_4) && isalive(var_4)) {
          var_4 _id_5BE2();

          if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "vips") {
            var_5 = common_scripts\utility::getStruct("vip1_hide_spot", "targetname");
            var_4 setgoalpos(var_5.origin);
            var_4.goalradius = 64;
          } else {
            var_4 maps\_utility::set_force_color("b");
          }
        }

        var_4 notify("group_wake");

        if(!var_1) {
          wait(randomfloatrange(0.2, 0.5));
        }
      }

      break;
    case 2:
      var_2 = maps\_utility::remove_dead_from_array(level._id_5BB7);
      level._id_5BC5[1] = 1;

      foreach(var_4 in var_2) {
        if(isDefined(var_4) && isalive(var_4)) {
          var_4 _id_5BE2();

          if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "vips") {
            var_5 = common_scripts\utility::getStruct("vip2_hide_spot", "targetname");
            var_4 setgoalpos(var_5.origin);
            var_4.goalradius = 24;
            var_4.pathenemyfightdist = 8;
            var_4.pathenemylookahead = 8;
          } else {
            var_4 maps\_utility::set_force_color("r");
          }
        }

        var_4 notify("group_wake");

        if(!var_1) {
          wait(randomfloatrange(0.2, 0.5));
        }
      }

      break;
    case 3:
      var_2 = maps\_utility::remove_dead_from_array(level._id_5BB8);
      level._id_5BC5[2] = 1;

      foreach(var_4 in var_2) {
        if(isDefined(var_4) && isalive(var_4)) {
          var_4 _id_5BE2();

          if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "vips") {
            var_5 = common_scripts\utility::getStruct("vip_escape_wait_3", "targetname");
            var_4 setgoalpos(var_5.origin);
            var_4.goalradius = 64;
          } else {
            var_4 maps\_utility::set_force_color("c");
          }
        }

        var_4 notify("group_wake");

        if(!var_1) {
          wait(randomfloatrange(0.2, 0.5));
        }
      }

      break;
    case 4:
      var_2 = maps\_utility::remove_dead_from_array(level._id_5BB9);
      level._id_5BC5[3] = 1;

      foreach(var_4 in var_2) {
        if(isDefined(var_4) && isalive(var_4)) {
          var_4 _id_5BE2();
        }
        var_4 notify("group_wake");

        if(!var_1) {
          wait(randomfloatrange(0.2, 0.5));
        }
      }

      break;
  }

  _id_5BE6(1);
}

_id_5BE1(var_0) {
  return level._id_5BC5[var_0 - 1];
}

_id_5BE2() {
  if(isDefined(self) && isalive(self)) {
    self.maxsightdistsqrd = 25000000;
    self.goalradius = 256;
    self.pacifist = 0;
    maps\_utility::clear_run_anim();
    maps\_utility::clear_generic_idle_anim();
    self allowedstances("stand", "prone", "crouch");
    self.disablearrivals = 0;
    self.disableexits = 0;
    self.ignoreall = 0;
    self.script_forcegoal = 0;
  }
}

_id_5BE3() {
  for(var_0 = 0; var_0 < level._id_5BBC.size; var_0++) {
    if(isalive(level._id_5BBC[var_0])) {
      level._id_5BBC[var_0] maps\_utility::unset_forcegoal();
      var_1 = common_scripts\utility::getStruct("vip_escape_wait_" + (var_0 + 1), "targetname");
      level._id_5BBC[var_0] setgoalpos(var_1.origin);
    }
  }
}

_id_5BE4(var_0) {
  level endon("special_op_terminated");
  self waittill("death");
  var_1 = 0;
  var_2 = 0;
  level._id_5BBC = maps\_utility::array_removedead(level._id_5BBC);

  for(var_3 = 0; var_3 < level._id_5BBC.size; var_3++) {
    if(isalive(level._id_5BBC[var_3])) {
      var_1++;
    }
  }

  if(var_1 > 0) {
    maps\ss_util::radio_dialogue_queue_single("so_assassin_kill_confirmed");
    maps\ss_util::radio_dialogue_queue_single("so_assassin_one_more");
  } else {
    _id_5BE6(4);

    if(!var_2) {
      var_2 = 1;
      common_scripts\utility::flag_set("obj_vips_dead");
    }
  }
}

setup_ent_rockers() {
  level thread _id_558F();
  level.custom_eog_no_defaults = 1;
  level.eog_summary_callback = ::customeogsummary;
  thread objectives();

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] thread _id_5640();
  }
  common_scripts\utility::flag_set("so_assassin_payback_start");
  level thread _id_5BE7();
  thread _id_5BEE();
  thread _id_5BEF();
}

customeogsummary() {
  var_0 = int(min(level.challenge_end_time - level.challenge_start_time, 86400000));
  var_1 = 0;

  foreach(var_3 in level.players) {}
  var_1 = var_1 + var_3.so_eog_summary_data["kills"];

  var_5 = int(level.specops_reward_gameskill * 10000);
  level.session_score = var_5;
  var_6 = int(var_1 * 25);
  level.session_score = level.session_score + var_6;
  var_7 = 120000;
  var_8 = 1.0 - min(1.0, level._id_5BE5 / var_7);
  var_9 = 5000 - 25 * level._id_5BCC;
  var_10 = int(var_8 * var_9);
  level.session_score = level.session_score + var_10;
  var_11 = 0;

  if(var_0 <= level._id_5BCD) {
    var_11 = 5000;
  } else if(var_0 <= level._id_5BCE) {
    var_11 = int(5000 * (1 - (var_0 - level._id_5BCD) / (level._id_5BCE - level._id_5BCD)));
  }
  level.session_score = level.session_score + var_11;

  foreach(var_3 in level.players) {}
  var_3 maps\_specialops::override_summary_score(level.session_score);

  var_14[0] = "@MENU_RECRUIT";
  var_14[1] = "@MENU_REGULAR";
  var_14[2] = "@MENU_HARDENED";
  var_14[3] = "@MENU_VETERAN";
  var_15 = undefined;
  var_16 = undefined;
  var_17 = undefined;
  var_18 = undefined;

  if(maps\_utility::is_coop()) {
    var_15 = "@SPECIAL_OPS_UI_TEAM_SCORE";
    var_16 = "@SPECIAL_OPS_PERFORMANCE_YOU";
    var_17 = "@SPECIAL_OPS_PERFORMANCE_PARTNER";
    var_18 = "@SPECIAL_OPS_POINTS";
  } else {
    var_15 = "@SPECIAL_OPS_UI_SCORE";
    var_16 = "";
    var_17 = "@SPECIAL_OPS_POINTS";
  }

  maps\_utility::clear_custom_eog_summary();

  foreach(var_3 in level.players) {
    var_20 = var_3.so_eog_summary_data["kills"];
    var_21 = var_3.so_eog_summary_data["time"] * 0.001;
    var_22 = maps\_utility::convert_to_time_string(var_21, 1);
    var_23 = maps\_utility::convert_to_time_string(level._id_5BE5 / 1000, 1);
    var_24 = var_14[var_3.so_eog_summary_data["difficulty"]];
    var_25 = var_3.so_eog_summary_data["score"];

    if(maps\_utility::is_coop()) {
      var_26 = maps\_utility::get_other_player(var_3).so_eog_summary_data["kills"];
      var_27 = var_14[maps\_utility::get_other_player(var_3).so_eog_summary_data["difficulty"]];

      if(!level.missionfailed) {
        var_3 maps\_utility::add_custom_eog_summary_line("", var_16, var_17, var_18, 1);
        var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY", var_24, var_27, var_5, 2);
        var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_TIME", var_22, var_22, var_11, 3);
        var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS", var_20, var_26, var_6, 4);
        var_3 maps\_utility::add_custom_eog_summary_line("@SO_ASSASSIN_PAYBACK_HELI_KILL", var_23, var_23, var_10, 5);
        var_3 maps\_utility::add_custom_eog_summary_line("", "", undefined, undefined, 6);
        var_3 maps\_utility::add_custom_eog_summary_line(var_15, var_25, undefined, undefined, 7);
      } else {
        var_3 maps\_utility::add_custom_eog_summary_line("", var_16, var_17, undefined, 1);
        var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY", var_24, var_27, undefined, 2);
        var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_TIME", var_22, var_22, undefined, 3);
        var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS", var_20, var_26, undefined, 4);
      }

      continue;
    }

    if(!level.missionfailed) {
      var_3 maps\_utility::add_custom_eog_summary_line("", var_16, var_17, var_18, 1);
      var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY", var_24, var_5, undefined, 2);
      var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_TIME", var_22, var_11, undefined, 3);
      var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS", var_20, var_6, undefined, 4);
      var_3 maps\_utility::add_custom_eog_summary_line("@SO_ASSASSIN_PAYBACK_HELI_KILL", var_23, var_10, undefined, 5);
      var_3 maps\_utility::add_custom_eog_summary_line("", "", undefined, undefined, 6);
      var_3 maps\_utility::add_custom_eog_summary_line(var_15, var_25, undefined, undefined, 7);
      continue;
    }

    var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY", var_24, undefined, undefined, 1);
    var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_TIME", var_22, undefined, undefined, 2);
    var_3 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS", var_20, undefined, undefined, 3);
  }

  if(!level.missionfailed) {
    setDvar("ui_hide_hint", 1);
  } else {
    setDvar("ui_hide_hint", 0);
  }
}

_id_5640() {
  level endon("special_op_terminated");
  level endon("so_assassin_payback_complete");

  for(;;) {
    common_scripts\utility::flag_wait("no_prone_water_trigger");

    if(self getstance() == "prone") {
      self setstance("stand");
    }
    self allowprone(0);
    common_scripts\utility::flag_waitopen("no_prone_water_trigger");
    self allowprone(1);
  }
}

_id_5BE6(var_0) {
  if(var_0 > level._id_5BD4) {
    level._id_5BD4 = var_0;
  }
}

_id_5BE7() {
  level endon("special_op_terminated");
  thread _id_5BE8();
  thread _id_5BE9();
  thread _id_5BEA();

  foreach(var_1 in level.players) {}
  var_1 thread _id_5BEB();

  thread opening_dialogue();

  while(level._id_5BD4 < 1) {
    wait 1.0;
  }
  common_scripts\utility::flag_set("out_of_stage_1");
  thread maps\ss_util::radio_dialogue_queue_single("so_assassin_enemy_heading_your_way");
  var_3 = getEntArray("hostage_guard", "script_noteworthy");
  var_4 = common_scripts\utility::getStruct("hostage_loc", "targetname");

  foreach(var_6 in var_3) {
    var_7 = var_6 maps\_utility::spawn_ai(1, 0);
    var_7.goalradius = 512;
    var_7 setgoalpos(var_4.origin);
    level._id_5BBA = common_scripts\utility::add_to_array(level._id_5BBA, var_7);
  }

  if(_id_5BE1(1)) {
    _id_5BE0(4, 0);
    wait 3.0;
    _id_5BE0(2, 0);
    wait 5.0;
    _id_5BE0(3, 0);
  } else if(_id_5BE1(2)) {
    wait 3.0;
    _id_5BE0(1, 0);
    _id_5BE0(4, 0);
    wait 5.0;
    _id_5BE0(3, 0);
  } else if(_id_5BE1(3)) {
    wait 5.0;
    _id_5BE0(2, 0);
    _id_5BE0(4, 0);
    wait 3.0;
    _id_5BE0(1, 0);
  } else if(_id_5BE1(4)) {
    wait 1.0;
    _id_5BE0(2, 0);
    _id_5BE0(1, 0);
    wait 8.0;
    _id_5BE0(3, 0);
  } else {
    _id_5BE0(1, 0);
    _id_5BE0(2, 0);
    _id_5BE0(3, 0);
    wait 1.0;
  }

  _id_5BE6(2);

  if(level._id_5BD4 < 6) {
    thread maps\ss_util::radio_dialogue_queue_single("so_assassin_team_large_enemy_force");
  }
  for(level._id_5BBC = maps\_utility::array_removedead(level._id_5BBC); level._id_5BBC.size > 0; level._id_5BBC = maps\_utility::array_removedead(level._id_5BBC)) {
    wait 1.0;
  }
  _id_5BE6(3);
  thread maps\ss_util::radio_dialogue_queue_single("so_assassin_nice_work");
  var_9 = getaiarray("axis");

  for(var_10 = 0; var_10 < var_9.size; var_10++) {
    if(!isDefined(var_9[var_10].script_noteworthy) || var_9[var_10].script_noteworthy != "hostage_guard") {
      var_9[var_10] thread maps\_utility::player_seek_enable();
    }
  }

  while(level._id_5BD4 < 4) {
    wait 1.0;
  }
  common_scripts\utility::flag_wait("hostage_x_pressed");
  _id_5BE6(5);

  foreach(var_1 in level.players) {
    var_1 setoffhandsecondaryclass("smoke");
    var_1 giveweapon("smoke_grenade_american");
    var_1 thread _id_47BE();
    var_1 thread maps\_utility::display_hint_timeout("throw_smoke", undefined);
  }

  _id_5BE6(6);
  common_scripts\utility::flag_wait("smoke_thrown");
  thread maps\ss_util::radio_dialogue_queue_single("so_assassin_chopping_a_task_force");
  thread maps\_specialops::enable_countdown_timer(level._id_5BC7, 0, &"SO_ASSASSIN_PAYBACK_EXFIL_HUD");
  thread _id_5BEC();
  wait(level._id_5BC7 - level._id_5BC9 - level._id_5BC8);
  var_13 = getEnt("cobra", "targetname");
  var_14 = var_13 maps\_vehicle::spawn_vehicle_and_gopath();
  var_14 thread _id_5BFB();
  wait(level._id_5BC8);
  var_15 = getEnt("blackhawk", "targetname");
  var_16 = var_15 maps\_vehicle::spawn_vehicle_and_gopath();
  var_17 = getEnt("blackhawk_pilot", "targetname");
  var_18 = var_17 maps\_utility::spawn_ai(1, 0);
  var_18 thread maps\_utility::set_battlechatter(0);
  var_16 thread maps\_vehicle_aianim::guy_enter(var_18);
  var_19 = getEnt("blackhawk_copilot", "targetname");
  var_20 = var_19 maps\_utility::spawn_ai(1, 0);
  var_20 thread maps\_utility::set_battlechatter(0);
  var_16 thread maps\_vehicle_aianim::guy_enter(var_20);
  wait(level._id_5BCA);
  var_21 = common_scripts\utility::getStruct("last_wave_flee", "targetname");
  var_9 = getaiarray("axis");

  for(var_10 = 0; var_10 < var_9.size; var_10++) {
    var_9[var_10] maps\_utility::player_seek_disable();
    var_9[var_10] setgoalpos(var_21.origin);
    var_9[var_10].ignoreme = 1;
  }

  wait(level._id_5BC9 - level._id_5BCA);
  common_scripts\utility::flag_set("rescue_arrives");
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_set("so_assassin_payback_complete");
}

_id_5BE8() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("triggered_alert");
  _id_5BE0(4, 0);
}

_id_5BE9() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("triggered_alert_1");
  _id_5BE0(1, 1);
}

_id_5BEA() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("triggered_alert_3");
  common_scripts\utility::flag_set("hostages_vulnerable");
  _id_5BE0(3, 1);
}

_id_5BEB() {
  self endon("death");
  level endon("out_of_stage_1");
  level endon("special_op_terminated");

  while(level._id_5BD4 < 1) {
    self waittill("weapon_fired");
    _id_5BE0(1, 0);
  }
}

opening_dialogue() {
  wait 2.5;
  maps\ss_util::radio_dialogue_queue_single("so_assassin_approved_to_engage");
}

_id_5BEC() {
  level endon("special_op_terminated");
  var_0 = getEnt("intro_gate_right_so", "targetname");
  var_1 = getEnt("intro_gate_left_so", "targetname");
  var_2 = getEnt("gate_clip", "targetname");
  var_2 delete();
  var_3 = common_scripts\utility::getStruct("end_gate_origin", "targetname");
  var_4 = common_scripts\utility::getStruct("right_gate_dest", "targetname");
  var_0 moveTo(var_4.origin, 3.0, 0.5, 0.5);
  var_5 = common_scripts\utility::getStruct("left_gate_dest", "targetname");
  var_1 moveTo(var_5.origin, 3.0, 0.5, 0.5);
  var_6 = getEntArray("last_wave", "script_noteworthy");
  var_7 = getaiarray("axis");

  foreach(var_9 in var_7) {
    if(isalive(var_9)) {
      var_9 thread maps\_utility::player_seek_enable();
    }
  }

  var_11 = gettime();

  for(var_12 = 0; var_12 < var_6.size; var_12++) {
    var_9 = var_6[var_12] maps\_utility::spawn_ai(1, 0);
    var_9 thread maps\_utility::player_seek_enable();
    level._id_5BC4 = common_scripts\utility::add_to_array(level._id_5BC4, var_9);
  }

  for(level._id_5BC2++; level._id_5BC2 < level._id_5BCB; level._id_5BC2++) {
    var_13 = 0;
    var_14 = level._id_5BC4.size;
    var_15 = 0.3;
    var_16 = var_11 + 45000;

    while(!var_13) {
      wait 1;
      var_7 = getaiarray("axis");
      var_17 = var_7.size / var_14;
      var_18 = gettime();

      if(var_17 < var_15 || var_18 > var_16) {
        var_13 = 1;
      }
    }

    for(var_12 = 0; var_12 < var_6.size; var_12++) {
      var_9 = var_6[var_12] maps\_utility::spawn_ai(1, 0);
      var_9 thread maps\_utility::player_seek_enable();
      level._id_5BC4 = common_scripts\utility::add_to_array(level._id_5BC4, var_9);
    }
  }
}

_id_47BE() {
  self endon("death");
  level endon("smoke_thrown");
  level endon("special_op_terminated");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "smoke_grenade_american") {
      var_0 thread _id_5BED();

      foreach(var_3 in level.players) {}
      var_3 setoffhandsecondaryclass("flash");

      common_scripts\utility::flag_set("smoke_thrown");
    }
  }
}

_id_5BED() {
  wait 3.8;
  thread playfx_then_stop("extraction_smoke", self, "stop_green_smoke_fx");
  wait 0.1;
  self delete();
}

playfx_then_stop(var_0, var_1, var_2, var_3) {
  var_4 = spawn_tag_to_loc(var_1);
  var_4 rotateTo((180, 180, 0), 0.1);
  playFXOnTag(common_scripts\utility::getfx(var_0), var_4, "tag_origin");
  common_scripts\utility::flag_wait(var_2);
  stopFXOnTag(common_scripts\utility::getfx(var_0), var_4, "tag_origin");
}

spawn_tag_to_loc(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 angles_and_origin(var_0);
  return var_1;
}

angles_and_origin(var_0) {
  self.origin = var_0.origin;

  if(isDefined(var_0.angles)) {
    self.angles = var_0.angles;
  }
}

_id_5BEE() {
  level endon("special_op_terminated");
  var_0 = getEntArray("patrol_guy", "script_noteworthy");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1] maps\_utility::spawn_ai(1, 0);
    var_2.maxsightdistsqrd = level._id_5BD2;
    var_2.pacifist = 1;
    var_2.goalradius = 32;
    var_2 maps\_utility::set_generic_run_anim("casual_killer_walk_f");
    var_2 allowedstances("stand");
    var_2.disablearrivals = 1;
    var_2.disableexits = 1;
    level._id_5BB9 = common_scripts\utility::add_to_array(level._id_5BB9, var_2);
    var_2 thread _id_5BDE(4);
  }

  wait(level._id_5BD3);

  if(level._id_5BD4 > 0) {
    return;
  }
  thread maps\ss_util::radio_dialogue_queue_single("so_assassin_enemy_contacts");
  var_3 = common_scripts\utility::getStruct("patrol_goal_struct1", "targetname");
  var_4 = common_scripts\utility::getStruct("patrol_goal_struct2", "targetname");
  var_5 = common_scripts\utility::getStruct("patrol_goal_struct3", "targetname");
  level._id_5BB9[0] setgoalpos(var_3.origin);
  level._id_5BB9[1] setgoalpos(var_4.origin);
  level._id_5BB9[2] setgoalpos(var_5.origin);
  level._id_5BB9[0] waittill("goal");

  if(isDefined(level._id_5BB9[0]) && isalive(level._id_5BB9[0]) && level._id_5BC5[3] == 0) {
    _id_5BE0(4, 0);
  }
}

_id_5BEF() {
  level endon("special_op_terminated");

  foreach(var_1 in level.players) {}
  var_1 thread _id_5BF8();

  while(level._id_5BD4 < 2) {
    wait 1.0;
  }
  _id_5BF0("attack_littlebird_spawner", "attack_heli_start", "attack_heli_pilot");

  if(level.gameskill > 1 || maps\_utility::is_coop()) {
    wait 3.0;
    level thread _id_5BF1("attack_littlebird_spawner", "attack_heli_2_start", "attack_heli_start", "attack_heli_pilot_2");
  }

  while(level._id_5BD4 < 6) {
    wait 1.0;
  }
  wait 5;
  _id_5BF0("attack_littlebird_spawner_2", "attack_heli_start_dock_1", "attack_heli_pilot_3");
}

_id_5BF0(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "targetname");
  var_4 = var_3 maps\_vehicle::spawn_vehicle_and_gopath();
  var_5 = common_scripts\utility::getStruct(var_1, "targetname");
  var_4.health = 2 * var_4.health - var_4.healthbuffer;
  var_6 = getEnt(var_2, "targetname");
  var_7 = var_6 maps\_utility::spawn_ai(1, 0);
  var_4 thread maps\_vehicle_aianim::guy_enter(var_7);
  var_4 thread maps/_chopperboss::chopper_boss_behavior_little_bird(var_5);
  var_4 thread maps/_chopperboss::chopper_path_release("death deathspin");
  level._id_5BC6 = maps\_utility::array_add(level._id_5BC6, var_4);
  common_scripts\utility::flag_set("attack_heli_spawned");
  level notify("start_heli_timer");
  level._id_5BC3++;
  var_4 thread _id_5BF2();
  wait 3.0;
  thread maps\ss_util::radio_dialogue_queue_single("so_assassin_enemy_littlebird");
}

_id_5BF1(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getStruct(var_1, "targetname");
  var_5 = common_scripts\utility::getStruct(var_2, "targetname");
  var_6 = 0;

  while(!var_6) {
    if(isDefined(var_4.in_use) && var_4.in_use) {
      if(isDefined(var_5.in_use) && var_5.in_use) {
        wait 0.5;
      } else {
        var_6 = 1;
        _id_5BF0(var_0, var_2, var_3);
      }

      continue;
    }

    var_6 = 1;
    _id_5BF0(var_0, var_1, var_3);
  }
}

_id_5BF2() {
  level endon("special_op_terminated");
  self waittill("death");
  level._id_5BC3--;
}

_id_5BF3() {
  level endon("special_op_terminated");
  var_0 = 0;
  level._id_5BE5 = 0;

  foreach(var_2 in level.players) {}
  var_2 thread _id_5BF4();

  for(;;) {
    if(level._id_5BC3 > 0) {
      level._id_5BE5 = level._id_5BE5 + (gettime() - var_0);
      var_0 = gettime();
      common_scripts\utility::waitframe();
      continue;
    }

    level waittill("start_heli_timer");
    var_0 = gettime();
  }
}

_id_5BF4() {
  level endon("special_op_terminated");
  var_0 = maps\_specialops::so_hud_ypos();
  self._id_5BF5 = maps\_specialops::so_create_hud_item(3, var_0, &"SO_ASSASSIN_PAYBACK_HELI_HUD", self);
  self._id_5BF6 = maps\_specialops::so_create_hud_item(3, var_0, undefined, self);
  self._id_5BF6.alignx = "left";
  thread maps\_specialops::info_hud_handle_fade(self._id_5BF5);
  thread maps\_specialops::info_hud_handle_fade(self._id_5BF6);
  thread _id_5BF7();
  var_1 = maps\_utility::convert_to_time_string(level._id_5BE5 / 1000, 1);
  self._id_5BF6 settext(var_1);

  for(;;) {
    if(level._id_5BC3 > 0) {
      var_1 = maps\_utility::convert_to_time_string(level._id_5BE5 / 1000, 1);
      self._id_5BF6 settext(var_1);
    } else {
      level waittill("start_heli_timer");
    }
    common_scripts\utility::waitframe();
  }
}

_id_5BF7() {
  level endon("special_op_terminated");

  for(;;) {
    if(level._id_5BC3 > 0) {
      self._id_5BF6 maps\_specialops::set_hud_yellow();
      self._id_5BF5 maps\_specialops::set_hud_yellow();
    } else {
      self._id_5BF6 maps\_specialops::set_hud_white();
      self._id_5BF5 maps\_specialops::set_hud_white();
      level waittill("start_heli_timer");
    }

    common_scripts\utility::waitframe();
  }
}

_id_5BF8() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    while(!maps\_stinger::playerstingerads()) {
      wait 0.05;
    }
    level._id_5BC6 = maps\_utility::remove_dead_from_array(level._id_5BC6);

    foreach(var_1 in level._id_5BC6) {
      target_set(var_1);

      if(maps\_utility::is_coop()) {
        if(self == level.players[0]) {
          target_hidefromplayer(var_1, level.players[1]);
          continue;
        }

        target_hidefromplayer(var_1, level.players[0]);
      }
    }

    while(maps\_stinger::playerstingerads()) {
      wait 0.05;
    }
    level._id_5BC6 = maps\_utility::remove_dead_from_array(level._id_5BC6);

    foreach(var_1 in level._id_5BC6) {
      if(target_istarget(var_1)) {
        if(maps\_utility::is_coop()) {
          if(self == level.players[0]) {
            target_hidefromplayer(var_1, level.players[0]);
          } else {
            target_hidefromplayer(var_1, level.players[1]);
          }
        }

        target_remove(var_1);
      }
    }
  }
}

_id_5BF9() {
  level endon("special_op_terminated");
  var_0 = getEnt("hostage_trigger", "targetname");
  level thread _id_5BFA();
  maps\_utility::trigger_wait("hostage_trigger", "targetname");
  common_scripts\utility::flag_set("hostage_reached");
  level._id_5BB3[0] = 0;
  level._id_5BB3[1] = 0;
  var_1 = 1;

  while(var_1) {
    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      if(level.players[var_2] istouching(var_0)) {
        var_3 = 1;

        if(level._id_5BB3[var_2] == 0) {
          level._id_5BB3[var_2] = 1;
          level.players[var_2] thread maps\_utility::display_hint_timeout("contact_hostage", undefined);
        }

        if(level.players[var_2] useButtonPressed()) {
          var_1 = 0;
          break;
        }

        continue;
      }

      level._id_5BB3[var_2] = 0;
    }

    wait 0.1;
  }

  level._id_5BB3[0] = 0;
  level._id_5BB3[1] = 0;
  common_scripts\utility::flag_set("hostage_x_pressed");
}

_id_5BFA() {
  level endon("special_op_terminated");
  var_0 = 1;

  while(var_0) {
    foreach(var_2 in level.players) {
      var_3 = distance2d(level._id_5BBF.origin, var_2.origin);

      if(var_3 < level._id_5BC0) {
        common_scripts\utility::flag_set("near_hostages");
        var_0 = 0;
        break;
      }
    }

    wait 0.1;
  }
}

_id_5BFB() {
  wait 3;
  level._id_5BC6 = maps\_utility::remove_dead_from_array(level._id_5BC6);

  for(var_0 = level._id_5BC6.size - 1; var_0 >= 0; var_0--) {
    var_1 = level._id_5BC6[var_0];

    if(isalive(var_1)) {
      thread maps\_helicopter_globals::fire_missile("cobra_zippy", 4, var_1, 0.1);
    }
    wait 2.0;
  }
}

so_objective_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("special_op_terminated");
  objective_add(maps\_utility::obj(var_0), "active", var_1);
  objective_current(maps\_utility::obj(var_0));

  if(isDefined(var_6)) {
    objective_setpointertextoverride(maps\_utility::obj(var_0), var_6);
  }
  if(isDefined(var_4)) {
    objective_position(maps\_utility::obj(var_0), var_4.origin);
    common_scripts\utility::flag_wait(var_5);
    objective_position(maps\_utility::obj(var_0), (0, 0, 0));
  }

  if(isDefined(var_2)) {
    objective_position(maps\_utility::obj(var_0), var_2.origin);
  }
  common_scripts\utility::flag_wait(var_3);
  objective_position(maps\_utility::obj(var_0), (0, 0, 0));

  if(!isDefined(var_7) || var_7 == 0) {
    maps\_utility::objective_complete(maps\_utility::obj(var_0));
  }
}

objectives() {
  level endon("special_op_terminated");
  thread _id_5BFC();
  common_scripts\utility::flag_wait("obj_vips_dead");
  thread _id_5BF9();
  wait 0.1;
  so_objective_handler(maps\_utility::obj("hostage"), &"SO_ASSASSIN_PAYBACK_OBJECTIVE_RESCUE", level._id_5BBF, "hostage_x_pressed", undefined, undefined, &"SO_ASSASSIN_PAYBACK_OBJECTIVE_HOSTAGES");
  wait 0.1;
  so_objective_handler(maps\_utility::obj("smoke"), &"SO_ASSASSIN_PAYBACK_OBJECTIVE_SIGNAL", undefined, "smoke_thrown");
  wait 0.1;
  so_objective_handler(maps\_utility::obj("defend"), &"SO_ASSASSIN_PAYBACK_OBJECTIVE_DEFEND_EXFIL", undefined, "rescue_arrives");
  wait 0.1;
  level.challenge_end_time = gettime();
  common_scripts\utility::flag_set("so_assassin_payback_complete");
}

_id_5BFC() {
  level endon("obj_vips_dead");
  objective_add(maps\_utility::obj("kill_vips"), "active", &"SO_ASSASSIN_PAYBACK_OBJECTIVE_ELIMINATE_VIP1");
  objective_add(maps\_utility::obj("kill_vips2"), "active", &"SO_ASSASSIN_PAYBACK_OBJECTIVE_ELIMINATE_VIP2");
  objective_current(maps\_utility::obj("kill_vips"), maps\_utility::obj("kill_vips2"));
  level._id_5BBC[0] thread _id_5BFE(maps\_utility::obj("kill_vips"));
  level._id_5BBC[0] thread _id_5BFD(maps\_utility::obj("kill_vips"));
  level._id_5BBC[1] thread _id_5BFE(maps\_utility::obj("kill_vips2"));
  level._id_5BBC[1] thread _id_5BFD(maps\_utility::obj("kill_vips2"));
}

_id_5BFD(var_0) {
  level endon("special_op_terminated");
  self waittill("death");
  maps\_utility::objective_complete(var_0);
}

_id_5BFE(var_0) {
  level endon("special_op_terminated");
  self endon("death");
  var_1 = 0;

  while(!var_1) {
    objective_position(var_0, self.origin);

    if(maps\_utility::either_player_looking_at(self getEye()) || maps\_utility::either_player_looking_at(self.origin)) {
      var_1 = 1;
    }
    wait 0.1;
  }

  objective_onentity(var_0, self);
  objective_setpointertextoverride(var_0, &"SO_ASSASSIN_PAYBACK_OBJECTIVE_KILL");
}

_id_5BFF() {
  level endon("special_op_terminated");
  self endon("death");
  self endon("pain");
  self endon("group_wake");
  var_0 = common_scripts\utility::getStruct("vip1_struct1", "targetname");
  var_1 = common_scripts\utility::getStruct("vip1_struct2", "targetname");
  var_2 = common_scripts\utility::getStruct("vip1_struct3", "targetname");

  for(;;) {
    self setgoalpos(var_0.origin);
    self waittill("goal");
    wait 4.0;
    self setgoalpos(var_1.origin);
    self waittill("goal");
    wait 2.0;
    self setgoalpos(var_2.origin);
    self waittill("goal");
    wait 5.0;
  }
}

_id_5C00() {
  level endon("special_op_terminated");
  self endon("death");
  self endon("pain");
  self endon("group_wake");
  var_0 = common_scripts\utility::getStruct("vip2_struct1", "targetname");
  var_1 = common_scripts\utility::getStruct("vip2_struct2", "targetname");
  var_2 = common_scripts\utility::getStruct("vip2_struct3", "targetname");

  for(;;) {
    self setgoalpos(var_0.origin);
    self waittill("goal");
    wait 6.0;
    self setgoalpos(var_1.origin);
    self waittill("goal");
    wait 8.0;
    self setgoalpos(var_2.origin);
    self waittill("goal");
    wait 5.0;
  }
}

_id_5C01() {
  level endon("special_op_terminated");
  self endon("death");
  self endon("pain");
  self endon("group_wake");
  common_scripts\utility::waitframe();
  self notify("stop_going_to_node");
  var_0 = common_scripts\utility::getStruct(self.target, "targetname");

  for(;;) {
    self.pathenemylookahead = 8;
    self setgoalpos(var_0.origin);
    maps\_utility::set_generic_idle_anim("casual_stand_idle");
    self.goalradius = 16;
    self.ignoreall = 1;
    self waittill("goal");
    self.script_forcegoal = 1;
    wait 6.0;
    var_0 = common_scripts\utility::getStruct(var_0.target, "targetname");
  }
}

sandstorm_skybox_hide() {
  var_0 = getEntArray("sandstorm_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("blue_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();
}

sandstorm_skybox_show() {
  var_0 = getEntArray("sandstorm_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("blue_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();
}

spawn_corpses(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in getEntArray(var_0, "targetname")) {
    if(isspawner(var_4)) {
      var_5 = var_4.script_noteworthy;

      if(isDefined(var_1)) {
        var_5 = var_1;
      }
      var_2[var_2.size] = spawn_corpse(var_4, var_5, var_4.origin, var_4.angles);
    }
  }

  var_7 = common_scripts\utility::getStructArray(var_0, "targetname");

  foreach(var_9 in var_7) {
    var_10 = var_9.script_noteworthy;
    var_11 = getEntArray(var_10, "classname");
    var_12 = undefined;

    foreach(var_14 in var_11) {
      if(isspawner(var_14) && isDefined(var_14.script_noteworthy) && var_14.script_noteworthy == "corpse_spawner") {
        var_12 = var_14;
        break;
      }
    }

    if(isDefined(var_12)) {
      var_2[var_2.size] = spawn_corpse(var_12, var_9.script_animation, var_9.origin, var_9.angles);
      continue;
    }
  }

  return var_2;
}

spawn_corpse(var_0, var_1, var_2, var_3) {
  var_0.count++;
  var_4 = undefined;

  for(;;) {
    var_4 = var_0 maps\_utility::spawn_ai(1);

    if(isDefined(var_4)) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  if(isDefined(var_4)) {
    var_4.animname = "generic";
    var_4 maps\_utility::gun_remove();
    var_4 forceteleport(var_2, var_3);
    var_5 = var_4 maps\_utility::getanim(var_1);
    var_4 maps\_anim::anim_generic_first_frame(var_4, var_1);
    var_6 = maps\_vehicle_aianim::convert_guy_to_drone(var_4);
    var_6 setanim(var_5, 1, 0.2);
    var_6 notsolid();
    return var_6;
  }
}

add_radio(var_0) {
  foreach(var_2 in var_0) {}
  level.scr_radio[var_2] = var_2;
}

_id_47C4() {
  add_radio(["so_assassin_enemy_heading_your_way", "so_assassin_team_large_enemy_force", "so_assassin_chopping_a_task_force", "so_assassin_enemy_contacts", "so_assassin_enemy_littlebird", "so_assassin_approved_to_engage", "so_assassin_kill_confirmed", "so_assassin_one_more", "so_assassin_nice_work"]);
}

_id_558F() {
  maps\_audio_music::mus_play("pybk_mx_construction");
}