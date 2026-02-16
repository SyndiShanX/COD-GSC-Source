/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_assassin_payback.gsc
************************************************/

#using_animtree("generic_human");

main() {
  _id_02F0::main();
  maps\payback_precache::main();
  precacheitem("smoke_grenade_american");
  precacheitem("zippy_rockets");
  level.delay_createfx_seconds = 0.5;
  maps\_compass::setupminimap("compass_map_payback_port", "port_minimap_corner");
  maps\payback_fx::main();
  _id_562F();
  level._effect["_breach_doorbreach_detpack"] = loadfx("explosions/exp_pack_doorbreach");
  level._effect["aerial_explosion_large_linger"] = loadfx("explosions/aerial_explosion_large_linger");
  _id_0619::_id_3D06();
  level._effect["extraction_smoke"] = loadfx("smoke/signal_smoke_green");
  precacheminimapsentrycodeassets();
  maps\_utility::add_hint_string("contact_hostage", &"SO_ASSASSIN_PAYBACK_USE_HOSTAGE", ::_id_5BB2);
  maps\_utility::add_hint_string("throw_smoke", &"SO_ASSASSIN_PAYBACK_THROW_SMOKE", ::_id_5BB4);
  _id_3F71();
  maps\_load::main();
  maps\_stinger::init();
  _id_5BB5();
  level thread maps\_specialops::_id_181D();
  level thread maps\_specialops::_id_1825();
  thread maps\_specialops::_id_1802("so_assassin_payback_start", "so_assassin_payback_complete");
  thread maps\_specialops::_id_17F3();
  thread maps\_specialops::_id_17F5("so_assassin_payback_complete");
  wait 0.1;
  getent("pb_end_vista", "targetname") hide();
  var_0 = getent("intro_gate_right", "targetname");
  var_0 delete();
  var_1 = getent("intro_gate_left", "targetname");
  var_1 delete();
  level._id_0C59["generic"]["casual_killer_walk_f"][0] = % casual_killer_walk_f;
  level._id_0C59["generic"]["casual_stand_idle"] = % casual_stand_idle;
  level._id_0C59["generic"]["death_pose_07"] = % paris_npc_dead_poses_v07;
  level._id_0C59["generic"]["death_pose_08"] = % paris_npc_dead_poses_v08;
  maps\_shg_common::_id_1694("trigger_multiple_audio");
  maps\_shg_common::_id_1694("trigger_multiple_visionset");
  maps\payback_aud::main();
  wait 0.1;
  _id_1109();
  thread _id_47C4();
  wait 0.1;
  _id_4794();
}

_id_562F() {
  foreach(var_2, var_1 in level.createfxent) {
    if(attachpath(var_1)) {
      level.createfxent[var_2] = undefined;
      var_1.v = undefined;
      continue;
    }

    var_1._id_1693 = 1;
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
  var_0 = maps\_utility::_id_09A9();

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

_id_1109() {
  _id_5BD5();
  _id_555F();
  maps\_specialops::_id_1827(maps\_specialops::_id_182A, maps\_specialops::_id_1829, maps\_specialops::_id_1828);
  _id_5561();
  _id_5633();
  _id_02F1();
  level._id_5BB6 = [];
  level._id_5BB7 = [];
  level._id_5BB8 = [];
  level._id_5BB9 = [];
  level._id_5BBA = [];
  level._id_5BBB = [];
  level._id_5BBC = [];
  level._id_5BBD = 0;
  level._id_5BBE = 0;
  level._id_16CF = 0;
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

  if(level.gameskill <= 1 && !maps\_utility::_id_12C1()) {
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
  thread _id_5093("balcony_corpses");
  _id_5BD7();
  level._id_5BBD = level._id_5BBC.size;
  level._id_5BBE = 0;
  _id_5BDA();
  level._id_16CF = gettime();
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
    if(isDefined(var_2._id_1692) && var_2._id_1692 == "no_prone_water_trigger") {
      var_2._id_1693 = 1;
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
      var_2 = getent(var_0[var_1].target, "targetname");

      if(isDefined(var_2)) {
        var_2 maps\_utility::_id_27C5();
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
          var_6 = getent(var_5.target, "targetname");

          if(isDefined(var_6)) {
            var_6 maps\_utility::_id_27C5();
          }
        }
      }

      var_5 notify("delete");
      var_5 delete();
    }
  }
}

_id_02F1() {
  var_0 = getEntArray("assassin_box_clip", "targetname");

  foreach(var_2 in var_0) {}
  var_2 disconnectpaths();
}

_id_3F71() {
  level._id_1C74 = "dragunov";
  level._id_1C75 = "mp5";
  level._id_1C76 = "mp5";
  level._id_1C77 = "usp";
}

_id_5BD7() {
  _id_0619::_id_3D07("script_noteworthy", "struct_chopper_boss_loc");
  _id_5BD8();
  var_0 = getEntArray("vip1_guard", "script_noteworthy");
  var_1 = getEntArray("roof_guard", "script_noteworthy");
  var_0 = common_scripts\utility::array_combine(var_0, var_1);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2] maps\_utility::_id_166F(1, 0);
    var_3.maxsightdistsqrd = level._id_5BD2;
    var_3.pacifist = 1;
    var_3.goalradius = 32;
    var_3 maps\_utility::_id_140B("casual_killer_walk_f");
    var_3 maps\_utility::_id_26FA("casual_stand_idle");
    var_3 allowedstances("stand");
    var_3._id_117F = 1;
    var_3._id_1199 = 1;
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
    var_5 = var_4[var_2] maps\_utility::_id_166F(1, 0);
    var_5.maxsightdistsqrd = level._id_5BD2;
    var_5.pacifist = 1;
    var_5.goalradius = 32;
    var_5 maps\_utility::_id_140B("casual_killer_walk_f");
    var_5 maps\_utility::_id_26FA("casual_stand_idle");
    var_5 allowedstances("stand");
    var_5._id_117F = 1;
    var_5._id_1199 = 1;
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
    var_7 = var_6[var_2] maps\_utility::_id_166F(1, 0);
    var_7.maxsightdistsqrd = level._id_5BD2;
    var_7.pacifist = 1;
    var_7.goalradius = 32;
    var_7 setgoalpos(var_7.origin);
    var_7 maps\_utility::_id_140B("casual_killer_walk_f");
    var_7 allowedstances("stand");
    var_7._id_117F = 1;
    var_7._id_1199 = 1;
    level._id_5BB8 = common_scripts\utility::add_to_array(level._id_5BB8, var_7);
    var_7 thread _id_5BDE(3);
  }
}

_id_5BD8() {
  var_0 = getent("vip_1_spawner", "targetname");
  var_1 = var_0 maps\_utility::_id_166F(1, 0);
  _id_5BD9(var_1, 1);
  var_1.targetname = "vip_1";
  level._id_5BB6[0] = var_1;
  var_2 = getent("vip_2_spawner", "targetname");
  var_3 = var_2 maps\_utility::_id_166F(1, 0);
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
  var_0 maps\_utility::_id_140B("casual_killer_walk_f");
  var_0 allowedstances("stand");
  var_0._id_117F = 1;
  var_0._id_1199 = 1;
  var_0 thread _id_5BE4(var_1);
  var_0 thread _id_5BDE(var_1);
  var_0.script_noteworthy = "vips";
}

_id_5BDA() {
  createthreatbiasgroup("hostages");
  maps\_utility::_id_27CA("hostage_spawner", ::_id_5BDB);
  maps\_utility::_id_272C("hostage_spawner", 1);
  maps\_utility::_id_26BA("hostages", "axis");
  var_0 = common_scripts\utility::getstruct("hostage_loc", "targetname");
  level._id_5BBF = var_0;
}

_id_5BDB() {
  self._id_5BDC = 1;
  self.grenadeawareness = 0;
  self.team = "allies";
  self.ignoreme = 1;
  thread maps\_utility::_id_0D04();
  self.ignorerandombulletdamage = 1;
  self setthreatbiasgroup("hostages");
  thread _id_5BDD();
}

_id_5BDD() {
  common_scripts\utility::flag_wait("hostages_vulnerable");
  maps\_utility::_id_1902();
  self waittill("death");

  if(common_scripts\utility::flag("so_assassin_payback_complete")) {
    return;
  }
  level._id_5BC1++;
  level._id_16CE = gettime();
  maps\_specialops::_id_183F("@SO_ASSASSIN_PAYBACK_HOSTAGE_DEATH");
  level maps\_utility::_id_1826();
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
      var_2 = maps\_utility::_id_1228(level._id_5BB6);
      level._id_5BC5[0] = 1;

      foreach(var_4 in var_2) {
        if(isDefined(var_4) && isalive(var_4)) {
          var_4 _id_5BE2();

          if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "vips") {
            var_5 = common_scripts\utility::getstruct("vip1_hide_spot", "targetname");
            var_4 setgoalpos(var_5.origin);
            var_4.goalradius = 64;
          } else {
            var_4 maps\_utility::_id_13A4("b");
          }
        }

        var_4 notify("group_wake");

        if(!var_1) {
          wait(randomfloatrange(0.2, 0.5));
        }
      }

      break;
    case 2:
      var_2 = maps\_utility::_id_1228(level._id_5BB7);
      level._id_5BC5[1] = 1;

      foreach(var_4 in var_2) {
        if(isDefined(var_4) && isalive(var_4)) {
          var_4 _id_5BE2();

          if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "vips") {
            var_5 = common_scripts\utility::getstruct("vip2_hide_spot", "targetname");
            var_4 setgoalpos(var_5.origin);
            var_4.goalradius = 24;
            var_4.pathenemyfightdist = 8;
            var_4.pathenemylookahead = 8;
          } else {
            var_4 maps\_utility::_id_13A4("r");
          }
        }

        var_4 notify("group_wake");

        if(!var_1) {
          wait(randomfloatrange(0.2, 0.5));
        }
      }

      break;
    case 3:
      var_2 = maps\_utility::_id_1228(level._id_5BB8);
      level._id_5BC5[2] = 1;

      foreach(var_4 in var_2) {
        if(isDefined(var_4) && isalive(var_4)) {
          var_4 _id_5BE2();

          if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "vips") {
            var_5 = common_scripts\utility::getstruct("vip_escape_wait_3", "targetname");
            var_4 setgoalpos(var_5.origin);
            var_4.goalradius = 64;
          } else {
            var_4 maps\_utility::_id_13A4("c");
          }
        }

        var_4 notify("group_wake");

        if(!var_1) {
          wait(randomfloatrange(0.2, 0.5));
        }
      }

      break;
    case 4:
      var_2 = maps\_utility::_id_1228(level._id_5BB9);
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
    maps\_utility::_id_140C();
    maps\_utility::_id_26FC();
    self allowedstances("stand", "prone", "crouch");
    self._id_117F = 0;
    self._id_1199 = 0;
    self.ignoreall = 0;
    self._id_1382 = 0;
  }
}

_id_5BE3() {
  for(var_0 = 0; var_0 < level._id_5BBC.size; var_0++) {
    if(isalive(level._id_5BBC[var_0])) {
      level._id_5BBC[var_0] maps\_utility::_id_2521();
      var_1 = common_scripts\utility::getstruct("vip_escape_wait_" + (var_0 + 1), "targetname");
      level._id_5BBC[var_0] setgoalpos(var_1.origin);
    }
  }
}

_id_5BE4(var_0) {
  level endon("special_op_terminated");
  self waittill("death");
  var_1 = 0;
  var_2 = 0;
  level._id_5BBC = maps\_utility::_id_1361(level._id_5BBC);

  for(var_3 = 0; var_3 < level._id_5BBC.size; var_3++) {
    if(isalive(level._id_5BBC[var_3])) {
      var_1++;
    }
  }

  if(var_1 > 0) {
    maps\ss_util::_id_4421("so_assassin_kill_confirmed");
    maps\ss_util::_id_4421("so_assassin_one_more");
  } else {
    _id_5BE6(4);

    if(!var_2) {
      var_2 = 1;
      common_scripts\utility::flag_set("obj_vips_dead");
    }
  }
}

_id_4794() {
  level thread _id_558F();
  level._id_16BC = 1;
  level._id_16BD = ::_id_5B6F;
  thread _id_479C();

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] thread _id_5640();
  }
  common_scripts\utility::flag_set("so_assassin_payback_start");
  level thread _id_5BE7();
  thread _id_5BEE();
  thread _id_5BEF();
}

_id_5B6F() {
  var_0 = int(min(level._id_16CE - level._id_16CF, 86400000));
  var_1 = 0;

  foreach(var_3 in level.players) {}
  var_1 = var_1 + var_3._id_16C6["kills"];

  var_5 = int(level._id_16D1 * 10000);
  level._id_16C4 = var_5;
  var_6 = int(var_1 * 25);
  level._id_16C4 = level._id_16C4 + var_6;
  var_7 = 120000;
  var_8 = 1.0 - min(1.0, level._id_5BE5 / var_7);
  var_9 = 5000 - 25 * level._id_5BCC;
  var_10 = int(var_8 * var_9);
  level._id_16C4 = level._id_16C4 + var_10;
  var_11 = 0;

  if(var_0 <= level._id_5BCD) {
    var_11 = 5000;
  } else if(var_0 <= level._id_5BCE) {
    var_11 = int(5000 * (1 - (var_0 - level._id_5BCD) / (level._id_5BCE - level._id_5BCD)));
  }
  level._id_16C4 = level._id_16C4 + var_11;

  foreach(var_3 in level.players) {}
  var_3 maps\_specialops::_id_17FE(level._id_16C4);

  var_14[0] = "@MENU_RECRUIT";
  var_14[1] = "@MENU_REGULAR";
  var_14[2] = "@MENU_HARDENED";
  var_14[3] = "@MENU_VETERAN";
  var_15 = undefined;
  var_16 = undefined;
  var_17 = undefined;
  var_18 = undefined;

  if(maps\_utility::_id_12C1()) {
    var_15 = "@SPECIAL_OPS_UI_TEAM_SCORE";
    var_16 = "@SPECIAL_OPS_PERFORMANCE_YOU";
    var_17 = "@SPECIAL_OPS_PERFORMANCE_PARTNER";
    var_18 = "@SPECIAL_OPS_POINTS";
  } else {
    var_15 = "@SPECIAL_OPS_UI_SCORE";
    var_16 = "";
    var_17 = "@SPECIAL_OPS_POINTS";
  }

  maps\_utility::_id_1E71();

  foreach(var_3 in level.players) {
    var_20 = var_3._id_16C6["kills"];
    var_21 = var_3._id_16C6["time"] * 0.001;
    var_22 = maps\_utility::_id_16D0(var_21, 1);
    var_23 = maps\_utility::_id_16D0(level._id_5BE5 / 1000, 1);
    var_24 = var_14[var_3._id_16C6["difficulty"]];
    var_25 = var_3._id_16C6["score"];

    if(maps\_utility::_id_12C1()) {
      var_26 = maps\_utility::_id_133A(var_3)._id_16C6["kills"];
      var_27 = var_14[maps\_utility::_id_133A(var_3)._id_16C6["difficulty"]];

      if(!level._id_16C9) {
        var_3 maps\_utility::_id_16C7("", var_16, var_17, var_18, 1);
        var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_24, var_27, var_5, 2);
        var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_TIME", var_22, var_22, var_11, 3);
        var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_20, var_26, var_6, 4);
        var_3 maps\_utility::_id_16C7("@SO_ASSASSIN_PAYBACK_HELI_KILL", var_23, var_23, var_10, 5);
        var_3 maps\_utility::_id_16C7("", "", undefined, undefined, 6);
        var_3 maps\_utility::_id_16C7(var_15, var_25, undefined, undefined, 7);
      } else {
        var_3 maps\_utility::_id_16C7("", var_16, var_17, undefined, 1);
        var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_24, var_27, undefined, 2);
        var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_TIME", var_22, var_22, undefined, 3);
        var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_20, var_26, undefined, 4);
      }

      continue;
    }

    if(!level._id_16C9) {
      var_3 maps\_utility::_id_16C7("", var_16, var_17, var_18, 1);
      var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_24, var_5, undefined, 2);
      var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_TIME", var_22, var_11, undefined, 3);
      var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_20, var_6, undefined, 4);
      var_3 maps\_utility::_id_16C7("@SO_ASSASSIN_PAYBACK_HELI_KILL", var_23, var_10, undefined, 5);
      var_3 maps\_utility::_id_16C7("", "", undefined, undefined, 6);
      var_3 maps\_utility::_id_16C7(var_15, var_25, undefined, undefined, 7);
      continue;
    }

    var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_24, undefined, undefined, 1);
    var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_TIME", var_22, undefined, undefined, 2);
    var_3 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_20, undefined, undefined, 3);
  }

  if(!level._id_16C9) {
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

  thread _id_50E5();

  while(level._id_5BD4 < 1) {
    wait 1.0;
  }
  common_scripts\utility::flag_set("out_of_stage_1");
  thread maps\ss_util::_id_4421("so_assassin_enemy_heading_your_way");
  var_3 = getEntArray("hostage_guard", "script_noteworthy");
  var_4 = common_scripts\utility::getstruct("hostage_loc", "targetname");

  foreach(var_6 in var_3) {
    var_7 = var_6 maps\_utility::_id_166F(1, 0);
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
    thread maps\ss_util::_id_4421("so_assassin_team_large_enemy_force");
  }
  for(level._id_5BBC = maps\_utility::_id_1361(level._id_5BBC); level._id_5BBC.size > 0; level._id_5BBC = maps\_utility::_id_1361(level._id_5BBC)) {
    wait 1.0;
  }
  _id_5BE6(3);
  thread maps\ss_util::_id_4421("so_assassin_nice_work");
  var_9 = getaiarray("axis");

  for(var_10 = 0; var_10 < var_9.size; var_10++) {
    if(!isDefined(var_9[var_10].script_noteworthy) || var_9[var_10].script_noteworthy != "hostage_guard") {
      var_9[var_10] thread maps\_utility::_id_2790();
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
    var_1 thread maps\_utility::_id_1823("throw_smoke", undefined);
  }

  _id_5BE6(6);
  common_scripts\utility::flag_wait("smoke_thrown");
  thread maps\ss_util::_id_4421("so_assassin_chopping_a_task_force");
  thread maps\_specialops::_id_17FF(level._id_5BC7, 0, &"SO_ASSASSIN_PAYBACK_EXFIL_HUD");
  thread _id_5BEC();
  wait(level._id_5BC7 - level._id_5BC9 - level._id_5BC8);
  var_13 = getent("cobra", "targetname");
  var_14 = var_13 maps\_vehicle::_id_1F9E();
  var_14 thread _id_5BFB();
  wait(level._id_5BC8);
  var_15 = getent("blackhawk", "targetname");
  var_16 = var_15 maps\_vehicle::_id_1F9E();
  var_17 = getent("blackhawk_pilot", "targetname");
  var_18 = var_17 maps\_utility::_id_166F(1, 0);
  var_18 thread maps\_utility::_id_0D72(0);
  var_16 thread maps\_vehicle_aianim::_id_24E5(var_18);
  var_19 = getent("blackhawk_copilot", "targetname");
  var_20 = var_19 maps\_utility::_id_166F(1, 0);
  var_20 thread maps\_utility::_id_0D72(0);
  var_16 thread maps\_vehicle_aianim::_id_24E5(var_20);
  wait(level._id_5BCA);
  var_21 = common_scripts\utility::getstruct("last_wave_flee", "targetname");
  var_9 = getaiarray("axis");

  for(var_10 = 0; var_10 < var_9.size; var_10++) {
    var_9[var_10] maps\_utility::_id_2791();
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

_id_50E5() {
  wait 2.5;
  maps\ss_util::_id_4421("so_assassin_approved_to_engage");
}

_id_5BEC() {
  level endon("special_op_terminated");
  var_0 = getent("intro_gate_right_so", "targetname");
  var_1 = getent("intro_gate_left_so", "targetname");
  var_2 = getent("gate_clip", "targetname");
  var_2 delete();
  var_3 = common_scripts\utility::getstruct("end_gate_origin", "targetname");
  var_4 = common_scripts\utility::getstruct("right_gate_dest", "targetname");
  var_0 moveto(var_4.origin, 3.0, 0.5, 0.5);
  var_5 = common_scripts\utility::getstruct("left_gate_dest", "targetname");
  var_1 moveto(var_5.origin, 3.0, 0.5, 0.5);
  var_6 = getEntArray("last_wave", "script_noteworthy");
  var_7 = getaiarray("axis");

  foreach(var_9 in var_7) {
    if(isalive(var_9)) {
      var_9 thread maps\_utility::_id_2790();
    }
  }

  var_11 = gettime();

  for(var_12 = 0; var_12 < var_6.size; var_12++) {
    var_9 = var_6[var_12] maps\_utility::_id_166F(1, 0);
    var_9 thread maps\_utility::_id_2790();
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
      var_9 = var_6[var_12] maps\_utility::_id_166F(1, 0);
      var_9 thread maps\_utility::_id_2790();
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
  thread _id_4FA4("extraction_smoke", self, "stop_green_smoke_fx");
  wait 0.1;
  self delete();
}

_id_4FA4(var_0, var_1, var_2, var_3) {
  var_4 = _id_4C9A(var_1);
  var_4 rotateto((180, 180, 0), 0.1);
  playFXOnTag(common_scripts\utility::getfx(var_0), var_4, "tag_origin");
  common_scripts\utility::flag_wait(var_2);
  stopFXOnTag(common_scripts\utility::getfx(var_0), var_4, "tag_origin");
}

_id_4C9A(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 _id_4C9B(var_0);
  return var_1;
}

_id_4C9B(var_0) {
  self.origin = var_0.origin;

  if(isDefined(var_0.angles)) {
    self.angles = var_0.angles;
  }
}

_id_5BEE() {
  level endon("special_op_terminated");
  var_0 = getEntArray("patrol_guy", "script_noteworthy");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1] maps\_utility::_id_166F(1, 0);
    var_2.maxsightdistsqrd = level._id_5BD2;
    var_2.pacifist = 1;
    var_2.goalradius = 32;
    var_2 maps\_utility::_id_140B("casual_killer_walk_f");
    var_2 allowedstances("stand");
    var_2._id_117F = 1;
    var_2._id_1199 = 1;
    level._id_5BB9 = common_scripts\utility::add_to_array(level._id_5BB9, var_2);
    var_2 thread _id_5BDE(4);
  }

  wait(level._id_5BD3);

  if(level._id_5BD4 > 0) {
    return;
  }
  thread maps\ss_util::_id_4421("so_assassin_enemy_contacts");
  var_3 = common_scripts\utility::getstruct("patrol_goal_struct1", "targetname");
  var_4 = common_scripts\utility::getstruct("patrol_goal_struct2", "targetname");
  var_5 = common_scripts\utility::getstruct("patrol_goal_struct3", "targetname");
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

  if(level.gameskill > 1 || maps\_utility::_id_12C1()) {
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
  var_3 = getent(var_0, "targetname");
  var_4 = var_3 maps\_vehicle::_id_1F9E();
  var_5 = common_scripts\utility::getstruct(var_1, "targetname");
  var_4.health = 2 * var_4.health - var_4._id_163B;
  var_6 = getent(var_2, "targetname");
  var_7 = var_6 maps\_utility::_id_166F(1, 0);
  var_4 thread maps\_vehicle_aianim::_id_24E5(var_7);
  var_4 thread _id_0619::_id_3D0C(var_5);
  var_4 thread _id_0619::_id_3D09("death deathspin");
  level._id_5BC6 = maps\_utility::_id_0BC3(level._id_5BC6, var_4);
  common_scripts\utility::flag_set("attack_heli_spawned");
  level notify("start_heli_timer");
  level._id_5BC3++;
  var_4 thread _id_5BF2();
  wait 3.0;
  thread maps\ss_util::_id_4421("so_assassin_enemy_littlebird");
}

_id_5BF1(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct(var_1, "targetname");
  var_5 = common_scripts\utility::getstruct(var_2, "targetname");
  var_6 = 0;

  while(!var_6) {
    if(isDefined(var_4._id_3D0B) && var_4._id_3D0B) {
      if(isDefined(var_5._id_3D0B) && var_5._id_3D0B) {
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
  var_0 = maps\_specialops::_id_185B();
  self._id_5BF5 = maps\_specialops::_id_16B6(3, var_0, &"SO_ASSASSIN_PAYBACK_HELI_HUD", self);
  self._id_5BF6 = maps\_specialops::_id_16B6(3, var_0, undefined, self);
  self._id_5BF6.alignx = "left";
  thread maps\_specialops::_id_1866(self._id_5BF5);
  thread maps\_specialops::_id_1866(self._id_5BF6);
  thread _id_5BF7();
  var_1 = maps\_utility::_id_16D0(level._id_5BE5 / 1000, 1);
  self._id_5BF6 settext(var_1);

  for(;;) {
    if(level._id_5BC3 > 0) {
      var_1 = maps\_utility::_id_16D0(level._id_5BE5 / 1000, 1);
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
      self._id_5BF6 maps\_specialops::_id_185F();
      self._id_5BF5 maps\_specialops::_id_185F();
    } else {
      self._id_5BF6 maps\_specialops::_id_185D();
      self._id_5BF5 maps\_specialops::_id_185D();
      level waittill("start_heli_timer");
    }

    common_scripts\utility::waitframe();
  }
}

_id_5BF8() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    while(!maps\_stinger::_id_5BAD()) {
      wait 0.05;
    }
    level._id_5BC6 = maps\_utility::_id_1228(level._id_5BC6);

    foreach(var_1 in level._id_5BC6) {
      target_set(var_1);

      if(maps\_utility::_id_12C1()) {
        if(self == level.players[0]) {
          target_hidefromplayer(var_1, level.players[1]);
          continue;
        }

        target_hidefromplayer(var_1, level.players[0]);
      }
    }

    while(maps\_stinger::_id_5BAD()) {
      wait 0.05;
    }
    level._id_5BC6 = maps\_utility::_id_1228(level._id_5BC6);

    foreach(var_1 in level._id_5BC6) {
      if(target_istarget(var_1)) {
        if(maps\_utility::_id_12C1()) {
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
  var_0 = getent("hostage_trigger", "targetname");
  level thread _id_5BFA();
  maps\_utility::_id_262B("hostage_trigger", "targetname");
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
          level.players[var_2] thread maps\_utility::_id_1823("contact_hostage", undefined);
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
  level._id_5BC6 = maps\_utility::_id_1228(level._id_5BC6);

  for(var_0 = level._id_5BC6.size - 1; var_0 >= 0; var_0--) {
    var_1 = level._id_5BC6[var_0];

    if(isalive(var_1)) {
      thread maps\_helicopter_globals::fire_missile("cobra_zippy", 4, var_1, 0.1);
    }
    wait 2.0;
  }
}

_id_4F95(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("special_op_terminated");
  objective_add(maps\_utility::_id_2816(var_0), "active", var_1);
  objective_current(maps\_utility::_id_2816(var_0));

  if(isDefined(var_6)) {
    objective_setpointertextoverride(maps\_utility::_id_2816(var_0), var_6);
  }
  if(isDefined(var_4)) {
    objective_position(maps\_utility::_id_2816(var_0), var_4.origin);
    common_scripts\utility::flag_wait(var_5);
    objective_position(maps\_utility::_id_2816(var_0), (0, 0, 0));
  }

  if(isDefined(var_2)) {
    objective_position(maps\_utility::_id_2816(var_0), var_2.origin);
  }
  common_scripts\utility::flag_wait(var_3);
  objective_position(maps\_utility::_id_2816(var_0), (0, 0, 0));

  if(!isDefined(var_7) || var_7 == 0) {
    maps\_utility::_id_2727(maps\_utility::_id_2816(var_0));
  }
}

_id_479C() {
  level endon("special_op_terminated");
  thread _id_5BFC();
  common_scripts\utility::flag_wait("obj_vips_dead");
  thread _id_5BF9();
  wait 0.1;
  _id_4F95(maps\_utility::_id_2816("hostage"), &"SO_ASSASSIN_PAYBACK_OBJECTIVE_RESCUE", level._id_5BBF, "hostage_x_pressed", undefined, undefined, &"SO_ASSASSIN_PAYBACK_OBJECTIVE_HOSTAGES");
  wait 0.1;
  _id_4F95(maps\_utility::_id_2816("smoke"), &"SO_ASSASSIN_PAYBACK_OBJECTIVE_SIGNAL", undefined, "smoke_thrown");
  wait 0.1;
  _id_4F95(maps\_utility::_id_2816("defend"), &"SO_ASSASSIN_PAYBACK_OBJECTIVE_DEFEND_EXFIL", undefined, "rescue_arrives");
  wait 0.1;
  level._id_16CE = gettime();
  common_scripts\utility::flag_set("so_assassin_payback_complete");
}

_id_5BFC() {
  level endon("obj_vips_dead");
  objective_add(maps\_utility::_id_2816("kill_vips"), "active", &"SO_ASSASSIN_PAYBACK_OBJECTIVE_ELIMINATE_VIP1");
  objective_add(maps\_utility::_id_2816("kill_vips2"), "active", &"SO_ASSASSIN_PAYBACK_OBJECTIVE_ELIMINATE_VIP2");
  objective_current(maps\_utility::_id_2816("kill_vips"), maps\_utility::_id_2816("kill_vips2"));
  level._id_5BBC[0] thread _id_5BFE(maps\_utility::_id_2816("kill_vips"));
  level._id_5BBC[0] thread _id_5BFD(maps\_utility::_id_2816("kill_vips"));
  level._id_5BBC[1] thread _id_5BFE(maps\_utility::_id_2816("kill_vips2"));
  level._id_5BBC[1] thread _id_5BFD(maps\_utility::_id_2816("kill_vips2"));
}

_id_5BFD(var_0) {
  level endon("special_op_terminated");
  self waittill("death");
  maps\_utility::_id_2727(var_0);
}

_id_5BFE(var_0) {
  level endon("special_op_terminated");
  self endon("death");
  var_1 = 0;

  while(!var_1) {
    objective_position(var_0, self.origin);

    if(maps\_utility::_id_2752(self getEye()) || maps\_utility::_id_2752(self.origin)) {
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
  var_0 = common_scripts\utility::getstruct("vip1_struct1", "targetname");
  var_1 = common_scripts\utility::getstruct("vip1_struct2", "targetname");
  var_2 = common_scripts\utility::getstruct("vip1_struct3", "targetname");

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
  var_0 = common_scripts\utility::getstruct("vip2_struct1", "targetname");
  var_1 = common_scripts\utility::getstruct("vip2_struct2", "targetname");
  var_2 = common_scripts\utility::getstruct("vip2_struct3", "targetname");

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
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");

  for(;;) {
    self.pathenemylookahead = 8;
    self setgoalpos(var_0.origin);
    maps\_utility::_id_26FA("casual_stand_idle");
    self.goalradius = 16;
    self.ignoreall = 1;
    self waittill("goal");
    self._id_1382 = 1;
    wait 6.0;
    var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");
  }
}

_id_5C02() {
  var_0 = getEntArray("sandstorm_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("blue_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();
}

_id_5C03() {
  var_0 = getEntArray("sandstorm_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("blue_sky", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();
}

_id_5093(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in getEntArray(var_0, "targetname")) {
    if(isspawner(var_4)) {
      var_5 = var_4.script_noteworthy;

      if(isDefined(var_1)) {
        var_5 = var_1;
      }
      var_2[var_2.size] = _id_5094(var_4, var_5, var_4.origin, var_4.angles);
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
      var_2[var_2.size] = _id_5094(var_12, var_9._id_205B, var_9.origin, var_9.angles);
      continue;
    }
  }

  return var_2;
}

_id_5094(var_0, var_1, var_2, var_3) {
  var_0.count++;
  var_4 = undefined;

  for(;;) {
    var_4 = var_0 maps\_utility::_id_166F(1);

    if(isDefined(var_4)) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  if(isDefined(var_4)) {
    var_4._id_1032 = "generic";
    var_4 maps\_utility::_id_24F5();
    var_4 forceteleport(var_2, var_3);
    var_5 = var_4 maps\_utility::_id_1281(var_1);
    var_4 maps\_anim::_id_11C0(var_4, var_1);
    var_6 = maps\_vehicle_aianim::_id_25C1(var_4);
    var_6 setanim(var_5, 1, 0.2);
    var_6 notsolid();
    return var_6;
  }
}

_id_47C7(var_0) {
  foreach(var_2 in var_0) {}
  level._id_11BB[var_2] = var_2;
}

_id_47C4() {
  _id_47C7(["so_assassin_enemy_heading_your_way", "so_assassin_team_large_enemy_force", "so_assassin_chopping_a_task_force", "so_assassin_enemy_contacts", "so_assassin_enemy_littlebird", "so_assassin_approved_to_engage", "so_assassin_kill_confirmed", "so_assassin_one_more", "so_assassin_nice_work"]);
}

_id_558F() {
  maps\_audio_music::_id_15A7("pybk_mx_construction");
}