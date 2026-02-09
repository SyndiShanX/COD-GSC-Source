/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_zodiac2_ny_harbor.gsc
*************************************************/

main() {
  level._id_1C72 = "mp7_reflex";
  level._id_1C73 = "aa12";
  setsaveddvar("sm_sunshadowscale", 0.85);
  level._id_4A4C = getdvarfloat("sm_sunshadowscale");
  maps\_shg_common::_id_1691("msg_vfx");
  maps\_shg_common::_id_1694("trigger_multiple_audio");
  maps\_specialops::_id_1835();
  maps\_specialops::_id_1837();
  maps\_specialops::_id_1836();
  common_scripts\utility::flag_init("hatch_player_using_ladder");
  common_scripts\utility::flag_init("outside_above_water");
  common_scripts\utility::flag_init("so_zodiac2_ny_harbor_complete");
  common_scripts\utility::flag_init("so_zodiac2_ny_harbor_start");
  common_scripts\utility::flag_init("players_in_reactor_room");
  common_scripts\utility::flag_init("stop_missile_launch");
  common_scripts\utility::flag_init("times_up");
  common_scripts\utility::flag_init("hatch_open");
  common_scripts\utility::flag_init("times_up_reactor");
  common_scripts\utility::flag_init("bombs_defused_missile_room");
  common_scripts\utility::flag_init("bombs_defused_reactor_room");
  common_scripts\utility::flag_init("reactor_thermite_start");
  common_scripts\utility::flag_init("detonate_sub");
  common_scripts\utility::flag_init("submine_planted");
  common_scripts\utility::flag_init("sub_breach_started");
  common_scripts\utility::flag_init("entering_water");
  common_scripts\utility::flag_init("launch_missiles");
  common_scripts\utility::flag_init("player_on_boat");
  common_scripts\utility::flag_init("msg_vfx_sub_interior_red_light_pulse");
  common_scripts\utility::flag_init("laststand_downed");
  common_scripts\utility::flag_init("a_thing_is_being_defused");
  common_scripts\utility::flag_init("russian_sub_spawned");
  common_scripts\utility::flag_init("reactor_saved");
  common_scripts\utility::flag_init("close_hatch");
  common_scripts\utility::flag_init("switch_chinook");
  common_scripts\utility::flag_init("door_3_is_open");
  common_scripts\utility::flag_init("been_hit");
  precacheitem("mp7_reflex");
  precachemodel("weapon_thermite_device_obj");
  precachemodel("ny_harbor_sub_pipe_valve_02_obj");
  precacheshader("nightvision_overlay_goggles");
  precachestring("SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
  maps\_utility::add_hint_string("hint_friendly", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN", ::_id_02AF);
  _id_4CAA();
  _id_4CAF();
  _id_4CB0();
  precacheminimapsentrycodeassets();
  _id_02AD::main();
  _id_03C4::main();
  maps\ny_harbor_aud::main();
  maps\_load::main();
  maps\so_aud::main();
  maps\_compass::setupminimap("compass_map_ny_harbor");
  level._id_00AB = 1;
  _id_03C3::main();
  maps\_audio::_id_1740("shg");
  _id_1109();
  _id_4BF6();
}

_id_1109() {
  thread maps\_specialops::_id_1802("so_zodiac2_ny_harbor_start", "so_zodiac2_ny_harbor_complete");
  thread maps\_specialops::_id_17F3();
  thread maps\_specialops::_id_17F5("so_zodiac2_ny_harbor_complete");
  thread maps\_specialops::_id_181D();
  thread maps\_specialops::_id_1825();
  thread maps\_audio_zone_manager::_id_156C("nyhb_surface_battle");
  _id_3F71();
  thread _id_479C();
  _id_4CB1();
  common_scripts\utility::array_thread(level.players, maps\_specialops::_id_1808, 3, &"SO_ZODIAC2_NY_HARBOR_BONUS_CLOSE_SMALL", "bonus1_count");
  level._id_16CB = 600000;
  level._id_4412 = 104000;
  maps\_shg_common::_id_16B7("@SO_ZODIAC2_NY_HARBOR_BONUS_CLOSE", 250, undefined);
}

_id_4BF6() {
  _id_4BF8();
  _id_4A2F();
  thread _id_4C08();
  thread _id_4C09();
  thread _id_4C0A();
  _id_4C28();
}

_id_4BF7() {
  wait 3;
  iprintlnbold("start_time= " + level._id_16CF);
}

_id_4BF8() {
  maps\_utility::_id_1A5A("axis", ::_id_4CB2);
  common_scripts\utility::array_thread(level.players, ::_id_4BFE);
  thread _id_02AE();
  level._id_4BF9 = 1.5;
  level._id_4BFA = 7;
  level.pipesdamage = 0;

  if(level._id_4BFB) {
    level._id_4BFC = 14;
    level._id_4BFD = 4;
  } else {
    level._id_4BFC = 9;
    level._id_4BFD = 8;
  }
}

_id_02AE() {
  level waittill("friendlyfire_mission_fail");

  foreach(var_1 in level.players) {}
  var_1 thread maps\_utility::_id_1823("hint_friendly", 2);
}

_id_02AF() {
  if(common_scripts\utility::flag("laststand_downed")) {
    return 1;
  } else {
    return 0;
  }
}

_id_4BFE() {
  for(;;) {
    self waittill("player_downed");
    common_scripts\utility::flag_set("laststand_downed");
    self waittill("revived");
    common_scripts\utility::flag_clear("laststand_downed");
  }
}

_id_3F71() {
  level._id_4BFB = 1;

  if(isDefined(level.players[1])) {
    level._id_4BFB = 0;
  }
  foreach(var_1 in level.players) {
    var_1 takeallweapons();
    var_1 giveweapon(level._id_1C72);
    var_1 giveweapon(level._id_1C73);
    var_1 giveweapon("fraggrenade");
    var_1 giveweapon("flash_grenade");
    var_1 setoffhandsecondaryclass("flash");
    var_1 switchtoweapon(level._id_1C72);
  }
}

_id_4BFF(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  objective_add(maps\_utility::_id_2816(var_0), "active", var_1);
  objective_current(maps\_utility::_id_2816(var_0));
  objective_position(maps\_utility::_id_2816(var_0), (var_2.origin[0], var_2.origin[1], var_2.origin[2] + var_3));
}

_id_4C00(var_0) {
  maps\_utility::_id_2813(var_0);
  maps\_utility::_id_2727(maps\_utility::_id_2816(var_0));
}

_id_479C() {
  wait 10;
  _id_4C01();
  _id_4C02();
  _id_4C04();
  _id_4C07();
}

_id_4C01() {
  var_0 = getent("obj_get_in_sub", "targetname");
  _id_4BFF(1, &"SO_ZODIAC2_NY_HARBOR_OBJ_GET_IN_SUB", var_0);
  objective_setpointertextoverride(1, &"SO_ZODIAC2_NY_HARBOR_HINT_DISARM");
  common_scripts\utility::flag_wait("hatch_open");
  objective_position(maps\_utility::_id_2816(1), (0, 0, 0));
  maps\_utility::_id_2727(maps\_utility::_id_2816(1));
}

_id_4C02() {
  objective_add(maps\_utility::_id_2816(2), "active", &"SO_ZODIAC2_NY_HARBOR_OBJ_REACTOR");
  objective_current(maps\_utility::_id_2816(2));
  var_0 = getent("obj_reactor2", "targetname");
  objective_position(maps\_utility::_id_2816(2), var_0.origin);
  common_scripts\utility::flag_wait("bombs_defused_missile_room");
  wait 5.5;
  objective_position(maps\_utility::_id_2816(2), (0, 0, 0));
  wait 0.5;
  var_1 = [];

  if(level._id_4BFB) {
    if(isDefined(level.players[0]._id_4C03) && level.players[0]._id_4C03) {
      var_1 = getEntArray("exit_hint_single", "targetname");
    } else {
      var_1 = getEntArray("exit_hint_single_bottom", "targetname");
    }
  }

  if(!level._id_4BFB) {
    var_1 = getEntArray("exit_hint_multi", "targetname");
  }
  var_2 = [];

  foreach(var_5, var_4 in var_1) {
    objective_additionalposition(maps\_utility::_id_2816(2), var_5 + 1, var_4.origin);
    objective_setpointertextoverride(2, &"SO_ZODIAC2_NY_HARBOR_HINT_EXIT");
    var_2[var_5] = var_5 + 1;
  }

  wait 7;

  foreach(var_7 in var_2) {}
  objective_additionalposition(maps\_utility::_id_2816(2), var_7, (0, 0, 0));

  wait 0.5;
  objective_setpointertextoverride(2, "");
  var_0 = getent("obj_reactor2", "targetname");
  objective_position(maps\_utility::_id_2816(2), var_0.origin);
  common_scripts\utility::flag_wait("reactor_saved");
  objective_position(maps\_utility::_id_2816(2), (0, 0, 0));
  maps\_utility::_id_2727(maps\_utility::_id_2816(2));
}

_id_4C04() {
  objective_add(maps\_utility::_id_2816(3), "active", &"SO_ZODIAC2_NY_HARBOR_OBJ_GET_OUT");
  objective_current(maps\_utility::_id_2816(3));
  common_scripts\utility::array_thread(level.players, ::_id_4C05);
  common_scripts\utility::flag_wait("obj_zod_crumb_flag");
  objective_position(maps\_utility::_id_2816(3), (0, 0, 0));
  maps\_utility::_id_2727(maps\_utility::_id_2816(3));
  wait 0.1;
}

_id_4C05(var_0, var_1) {
  _id_4C06(3, "obj_escape_bc1");
  _id_4C06(3, "obj_escape_bc2");
  _id_4C06(3, "obj_get_to_zodiac_crumb1", 1);
  _id_4C06(3, "obj_get_to_zodiac_crumb2");
}

_id_4C06(var_0, var_1, var_2) {
  var_3 = getent(var_1, "targetname");
  objective_position(maps\_utility::_id_2816(var_0), var_3.origin);

  if(isDefined(var_2)) {
    objective_setpointertextoverride(3, &"SO_ZODIAC2_NY_HARBOR_HINT_EXIT");
  }
  while(distance(self.origin, var_3.origin) > 96) {
    wait 0.05;
  }
}

_id_4C07() {
  objective_add(maps\_utility::_id_2816(4), "active", &"SO_ZODIAC2_NY_HARBOR_OBJ_AWAIT_CHOPPER");
  objective_current(maps\_utility::_id_2816(4));
  wait 2;
  var_0 = getent("obj_extraction", "targetname");
  objective_position(maps\_utility::_id_2816(4), var_0.origin);
  common_scripts\utility::flag_wait("so_zodiac2_ny_harbor_complete");
  maps\_utility::_id_2727(maps\_utility::_id_2816(4));
}

_id_4C08() {
  common_scripts\utility::flag_wait("vo_nuclear");
  maps\_utility::_id_11F4("so_zodiac2_hqr_riggedsub");
  common_scripts\utility::flag_wait("vo_reactor");
  maps\_utility::_id_11F4("so_zodiac2_hqr_nearingreactor");
  common_scripts\utility::flag_wait("start_reactor_countdown");
  maps\_utility::_id_11F4("so_zodiac2_hqr_raditionlevels");
  common_scripts\utility::flag_wait("reactor_saved");
  maps\_utility::_id_11F4("so_zodiac2_hqr_rendezvous");
  common_scripts\utility::flag_wait("kill_spawners_4");
  maps\_utility::_id_11F4("so_zodiac2_hqr_areaishot");
  common_scripts\utility::flag_wait("open_rear_hatch");
  maps\_utility::_id_11F4("so_zodiac2_hqr_onisr");
  common_scripts\utility::flag_wait("shoot_at_stragglers");
  maps\_utility::_id_11F4("so_zodiac2_hqr_readywhen");
}

_id_4C09() {
  common_scripts\utility::flag_set("so_zodiac2_ny_harbor_start");
  thread _id_4C12();
  thread _id_4C9C();
  common_scripts\utility::array_thread(level.players, ::_id_4C0B);
  thread _id_4C3D();
  thread _id_4C2A();
  thread _id_4C1F();
  thread _id_4C1D();
  level._id_45C0 = getent("sandman", "targetname");
  wait 0.05;
  level._id_45C0 kill();
}

_id_4C0A() {
  thread _id_4CA1();
  thread _id_4C15();
  thread _id_4C17();
  thread _id_4C5C();
  thread _id_4C43();
  thread _id_4C89();
  thread _id_4C2C();
  common_scripts\utility::array_thread(level.players, ::_id_4B4D);
}

_id_4C0B() {
  self notifyonplayercommand("use_thermal", "+actionslot 4");
  self setweaponhudiconoverride("actionslot4", "hud_icon_nvg");
  self._id_4C0C = 0;

  for(;;) {
    self waittill("use_thermal");
    _id_4C0D();
    self waittill("use_thermal");
    _id_4C0E();
  }
}

_id_4C0D() {
  maps\_load::_id_1FB1();
  self thermalvisionon();
  self visionsetthermalforplayer("so_sniper_hamburg_thermal", 0);
  self playSound("item_nightvision_on");
  self._id_4C0C = 1;
  _id_4C0F();
  wait 0.5;
}

_id_4C0E() {
  maps\_load::_id_1FB3();
  self thermalvisionoff();
  self playSound("item_nightvision_off");
  self._id_4C0C = 0;
  _id_4C11();
  wait 0.5;
}

_id_4C0F() {
  sethudlighting(1);
  self._id_4C10 = newclienthudelem(self);
  self._id_4C10.x = 0;
  self._id_4C10.y = 0;
  self._id_4C10.alignx = "left";
  self._id_4C10.aligny = "top";
  self._id_4C10.horzalign = "fullscreen";
  self._id_4C10.vertalign = "fullscreen";
  self._id_4C10.foreground = 0;
  self._id_4C10.sort = -10;
  self._id_4C10 setshader("nightvision_overlay_goggles", 650, 490);
  self._id_4C10.archived = 1;
  self._id_4C10.hidein3rdperson = 1;
  self._id_4C10.alpha = 1.0;
}

_id_4C11() {
  if(isDefined(self._id_4C10)) {
    self._id_4C10 destroy();
    sethudlighting(0);
  }
}

_id_4C12() {
  thread _id_4C13();
  thread _id_4C14();
  common_scripts\utility::flag_wait("hind_ready_for_land");
  maps\_audio_music::_id_15A7("so_harb_board_sub", 4);
  common_scripts\utility::flag_wait("in_missile_room");
  maps\_audio_music::_id_15A7("so_harb_sub_combat2", 0.2, 3);
  level waittill("trigger_missile_bombs");
  maps\_audio_music::_id_15A7("so_harb_sub_combat1", 0.2, 3);
  level notify("msg_vfx_sub_interior_b_deactivating");
  common_scripts\utility::flag_clear("msg_vfx_sub_interior_b");
  level waittill("in_missile_room2");
  maps\_audio_music::_id_15A7("so_harb_sub_combat2", 0.2, 3);
  level waittill("reactor_area_clear");
  maps\_audio_music::_id_15A7("so_harb_board_sub", 4);
  common_scripts\utility::flag_wait("start_reactor_countdown");
  maps\_audio_music::_id_15A7("so_harb_sub_combat1", 0.2, 3);
  common_scripts\utility::flag_wait("kill_spawners_4");
  maps\_audio_music::_id_15A7("so_harb_finale", 4);
}

_id_4C13() {
  common_scripts\utility::flag_wait("stop_missile_launch");
  var_0 = common_scripts\utility::getstructarray("ambient_sound", "targetname");
  var_1 = ["harb_battleship_stress", "harb_battleship_sink", "harb_sub_stress", "harb_sub_stress_sub_by", "russian_sub_missile_door"];
  var_2 = common_scripts\utility::spawn_tag_origin();

  for(;;) {
    wait(randomfloatrange(5.0, 15.0));
    var_3 = maps\_utility::_id_0AE9(level.players[0].origin, var_0);
    var_2.origin = var_3.origin;
    var_2 playSound(var_1[randomint(var_1.size)], "sound_done");
    var_2 waittill("sound_done");
  }
}

_id_4C14() {
  var_0 = common_scripts\utility::getstruct("fx_oil_fire", "targetname");
  playFX(common_scripts\utility::getfx("burning_oil_slick_1"), var_0.origin);
  var_1 = getent("sinking_ship", "targetname");
  var_1 delete();
  common_scripts\utility::flag_wait("turn_off_fire");
  common_scripts\utility::flag_clear("msg_vfx_sub_interior_a");
  var_2 = getent("for_fire", "targetname");
  playFX(common_scripts\utility::getfx("fire_gen"), var_2.origin);
  var_3 = getent("for_fire_steam", "targetname");
  var_4 = _id_4C9A(var_3);
  playFXOnTag(common_scripts\utility::getfx("steam_jet1"), var_4, "tag_origin");
  var_5 = getent("for_fire_jet", "targetname");
  var_6 = _id_4C9A(var_5);
  playFXOnTag(common_scripts\utility::getfx("fire_steam"), var_6, "tag_origin");
}

_id_4C15() {
  for(;;) {
    var_0 = getaiarray("axis");
    common_scripts\utility::array_thread(var_0, ::_id_4C7D);
    wait 2;
  }
}

_id_4C16(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_5 maps\_utility::_id_166F(1);
    var_3[var_3.size] = var_6;
  }

  return var_3;
}

_id_4C17() {
  var_0 = getent("bridge_breach_loc", "targetname");
  var_1 = getent("captain_dead", "targetname");
  var_2 = var_1 maps\_utility::_id_166F(1);
  var_2._id_1032 = "generic";
  var_0 maps\_anim::_id_11C1(var_2, "ny_harbor_paried_takedown_captain_die");
  var_2 = var_2 _id_4BF0(var_0, "ny_harbor_paried_takedown_captain_dead_1");
  common_scripts\utility::array_thread(level.players, ::_id_4C18);
}

_id_4C18() {
  var_0 = getent("no_prone_vol", "targetname");

  for(;;) {
    if(var_0 istouching(self)) {
      self allowprone(0);

      while(var_0 istouching(self)) {
        wait 0.05;
      }
      self allowprone(1);
    }

    wait 0.05;
  }
}

_id_4C19() {
  var_0 = getEntArray("ladder_trigger", "targetname");
  var_1 = getEntArray("ladder_trigger_2", "targetname");
  var_2 = getEntArray("missile_silo_door", "targetname");
}

_id_4C1A(var_0, var_1, var_2) {
  for(;;) {
    _id_4C1B(var_1, var_0);
    common_scripts\utility::array_call(var_2, ::hide);
    _id_4C1B(var_0, var_1);
    common_scripts\utility::array_call(var_2, ::show);
  }
}

_id_4C1B(var_0, var_1) {
  level._id_4C1C = 0;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(var_2 == self) {
      var_1 waittill("trigger", var_2);

      if(var_2 == self) {
        level._id_4C1C++;
      }
    }

    if(level._id_4C1C >= level.players.size) {
      break;
    }
  }
}

_id_4BF0(var_0, var_1) {
  var_2 = maps\_vehicle_aianim::_id_25C1(self);
  var_2 startusingheroonlylighting();

  if(isarray(maps\_utility::_id_270F(var_1))) {
    var_1 = var_1 + "_nl";
  }
  var_0 maps\_anim::_id_11C0(var_2, var_1);
  var_2 notsolid();
  return var_2;
}

_id_4C1D() {
  _id_4C1E("kill_spawners_1", 6901);
  _id_4C1E("kill_spawners_2", 6902);
  _id_4C1E("kill_spawners_3", 6903);
  _id_4C1E("kill_spawners_4", 6904);
}

_id_4C1E(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  maps\_spawner::_id_213E(var_1);
}

_id_4C1F() {
  thread _id_4B7D();
  thread _id_4C23();
  thread _id_4C21();

  if(level.gameskill > 1) {
    maps\_utility::_id_1A5A("axis", ::_id_02B0);
  }
  level._id_4C20 = _id_4C6D(undefined, "thermite_entrance", undefined, 75);
  level._id_4C20 _id_4C25("hatch_open");
  common_scripts\utility::flag_wait("start_jet_strafe");

  if(level.gameskill > 1) {
    maps\_utility::_id_26BB("axis", ::_id_02B0);
  }
}

_id_02B0() {
  self endon("deah");

  if(isDefined(self)) {
    self.ignoreall = 1;
  }
  common_scripts\utility::flag_wait("start_jet_strafe");
  wait 1.25;

  if(isDefined(self)) {
    self.ignoreall = 0;
  }
}

_id_4C21() {
  var_0 = getent("sight_trigger_front_hatch", "targetname");
  var_1 = var_0.origin;
  var_0.origin = (50, 50, 50);
  var_0._id_4C22 = 1;
  common_scripts\utility::flag_wait("hatch_open");
  wait 2;
  var_0.origin = var_1;
  var_0._id_4C22 = 0;
  common_scripts\utility::array_thread(level.players, ::_id_4C84, var_0, "check_for_player_front_hatch");
  _id_4B85("sight_trigger_front_hatch", "rear_ladder_pos1", "rear_ladder_pos2");
}

_id_4C23() {
  var_0 = getent("ladder_brush", "targetname");
  var_1 = var_0.origin;
  var_0.origin = (50, 50, 50);
  var_2 = getent("rear_hatch_cap", "targetname");
  var_3 = getent("downed_vol_deck", "targetname");

  for(;;) {
    common_scripts\utility::flag_wait("laststand_downed");

    if(common_scripts\utility::flag("hatch_open")) {
      if(_id_4C24(var_3)) {
        var_0.origin = var_1;
        var_2 notsolid();
        var_4 = getent("rear_hatch_col", "targetname");
        var_4 notsolid();
        var_5 = getent("rear_cap_coll_2", "targetname");
        var_5 notsolid();
      }

      while(common_scripts\utility::flag("laststand_downed")) {
        wait 0.05;
      }
      var_0.origin = (50, 50, 50);
    }

    wait 0.05;
  }
}

_id_4C24(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 istouching(var_2) && var_2 maps\_utility::_id_133C("laststand_downed") && var_2 maps\_utility::_id_1008("laststand_downed")) {
      return 1;
    }
  }

  return 0;
}

_id_4C25(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 75;
  }
  level._id_4656 = self[0];
  level._id_4656._id_4C26 = [];

  foreach(var_3 in level.players) {
    var_3 thread _id_4C33(level._id_4656, 100, var_1);
    var_3 thread _id_4C27();
  }

  _id_4C70(var_0, self);
}

_id_4C27() {
  level._id_4656 waittill("im_defused");
  self forceusehintoff();

  foreach(var_1 in level._id_4656._id_4C26) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

_id_4C28() {
  var_0 = 0;

  if(level._id_4BFB) {
    var_1 = getEntArray("multi_player", "script_noteworthy");
  } else {
    var_1 = getEntArray("single_player", "script_noteworthy");
  }
  foreach(var_3 in var_1) {}
  var_3 delete();
}

_id_4C29(var_0) {
  common_scripts\utility::flag_wait("hatch_open");
  maps\_audio::aud_send_msg("so_harbor_kill_helis", var_0);

  foreach(var_2 in var_0) {
    foreach(var_4 in var_2._id_0A39) {}
    var_4 kill();

    var_2 delete();
  }
}

_id_4C2A() {
  var_0 = getEntArray("ally_helis", "targetname");
  maps\_audio::aud_send_msg("so_harbor_ally_helis", var_0);
  common_scripts\utility::array_thread(var_0, maps\_vehicle::_id_1FA6);
  common_scripts\utility::array_thread(var_0, ::_id_4C2B);
  thread _id_4C29(var_0);
  level notify("missiles_spawned");
}

_id_4C2B() {
  foreach(var_1 in self._id_0A39) {}
  var_1._id_2982 = 1;
}

_id_4C2C() {
  level waittill("spawn_exit_chopper");
  var_0 = maps\_vehicle::_id_2881("end_enemy_chopper");
  maps\_audio::aud_send_msg("so_harbor_enemy_chopper_flyover", var_0);
  var_1 = getent("exit_ladder_pos1", "targetname");
  wait 20;
  var_2 = _id_4C2D("f15_enemy_intro");
  wait 1;
  var_3 = _id_4C2D("f15_enemy_intro2");
  var_1 playSound("f15_final_flyby_fronts", "sound_done");
}

_id_4C2D(var_0) {
  var_1 = maps\_vehicle::_id_2881(var_0);
  var_1 thread _id_4C2E();
  return var_1;
}

_id_4C2E() {
  common_scripts\utility::flag_wait("remove_intro_f15");
  self delete();
}

_id_4C2F(var_0, var_1, var_2, var_3) {
  var_4 = var_2[0] + randomfloatrange(var_1 * -1, var_1);
  var_5 = var_2[1] + randomfloatrange(var_1 * -1, var_1);
  var_6 = var_2[2] + randomfloatrange(var_1 * -1, var_1);
  magicbullet(var_0, var_3.origin, (var_4, var_5, var_6));
}

_id_4C30(var_0) {
  var_0 waittill("im_defused");

  if(isDefined(self.item) && self.item == var_0) {
    self.item = undefined;
  }
}

_id_4C31(var_0) {
  if(common_scripts\utility::flag("times_up")) {
    return 0;
  } else if(common_scripts\utility::flag("laststand_downed")) {
    return 0;
  } else if(!isDefined(self.item)) {
    self.item = var_0;
    return 1;
  } else if(self.item == var_0) {
    return 1;
  } else if(self.item != var_0) {
    return 0;
  } else {
    return 1;
  }
}

_id_4C32() {
  common_scripts\utility::flag_wait("times_up");
  self notify("times_up");
}

_id_4C33(var_0, var_1, var_2) {
  level._id_4656 endon("im_defused");
  level._id_4656 thread _id_4C32();
  thread _id_4C30(level._id_4656);
  level._id_4656.hidden = 0;
  level._id_4656._id_4C34 = 0;
  var_3 = undefined;
  self._id_4C35 = 0;
  level._id_4656._id_3D0B = 0;

  if(!isDefined(var_2)) {
    var_2 = 50;
  }
  while(!level._id_4656._id_4C34) {
    wait 0.05;
    var_4 = self getEye();
    _id_4C39(var_4, var_2);

    if(isDefined(level._id_4656) && !level._id_4656.hidden && distance(var_4, level._id_4656.origin) < var_2) {
      level._id_4656._id_4C26[level._id_4656._id_4C26.size] = _id_4C3A(level._id_4656);
      level._id_4656 remove();
      continue;
    }

    if(isDefined(level._id_4656) && level._id_4656.hidden && distance(var_4, level._id_4656.origin) < var_2 && (!isDefined(level._id_4656.inuse) || !level._id_4656.inuse)) {
      while(!common_scripts\utility::flag("laststand_downed") && self usebuttonpressed()) {
        self forceusehintoff();

        if(_id_4C31(level._id_4656) && level._id_4656 maps\_shg_common::_id_16A8(self, undefined, 2, &"SO_ZODIAC2_NY_HARBOR_HINT_DEFUSING", &"SO_ZODIAC2_NY_HARBOR_HINT_DISARM_SUCCESS", undefined, &"SO_ZODIAC2_NY_HARBOR_HINT_DISARM_FAIL")) {
          level._id_4656._id_4C34 = 1;
          level._id_4656 _id_4C3B();
          _id_4C36(var_3);
          level._id_4656 notify("im_defused");
        } else {
          self forceusehinton(&"SO_ZODIAC2_NY_HARBOR_HINT_DEFUSE");
          self.item = undefined;
        }

        wait 0.05;
      }

      continue;
    }

    if(isDefined(level._id_4656) && level._id_4656.hidden && isDefined(var_3) && distance(var_4, level._id_4656.origin) > var_2) {
      _id_4C37(var_3);
      level._id_4656 _id_40CB();
      continue;
    }

    if(!isDefined(level._id_4656)) {
      _id_4C37(var_3);
      break;
    } else if(common_scripts\utility::flag("laststand_downed")) {
      _id_4C38(var_3);
    }
  }
}

_id_4C36(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }
  if(isDefined(level._id_4656)) {
    level._id_4656 hide();
  }
}

_id_4C37(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }
  self forceusehintoff();
}

_id_4C38(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }
  level._id_4656 _id_40CB();
  self forceusehintoff();

  while(common_scripts\utility::flag("laststand_downed")) {
    wait 0.05;
  }
}

_id_4C39(var_0, var_1) {
  if(!level._id_4656._id_3D0B && !self._id_4C35 && distance(var_0, level._id_4656.origin) < var_1) {
    self forceusehinton(&"SO_ZODIAC2_NY_HARBOR_HINT_DEFUSE");
    self._id_4C35 = 1;
  } else if(level._id_4656._id_3D0B && !self._id_4C35 && distance(var_0, level._id_4656.origin) < var_1) {
    self forceusehintoff();
    self._id_4C35 = 0;
  } else if(distance(var_0, level._id_4656.origin) > var_1) {
    self forceusehintoff();
    self._id_4C35 = 0;
  }
}

_id_40CB() {
  self show();
  self.hidden = 0;
}

remove() {
  self hide();
  self.hidden = 1;
}

_id_4C3A(var_0) {
  var_1 = "weapon_thermite_device_obj";
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_1);
  var_2 _id_4C9B(var_0);
  return var_2;
}

_id_4C3B() {
  stopFXOnTag(common_scripts\utility::getfx("red_dot"), self._id_4C3C, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("red_dot"), self, "tag_fx");
  stopFXOnTag(common_scripts\utility::getfx("light_c4_blink"), self, "tag_fx");
  stopFXOnTag(common_scripts\utility::getfx("white_light"), self, "tag_fx");
}

_id_4C3D() {
  level._id_4483 = maps\_vehicle::_id_2881("player_hind");
  maps\_audio::aud_send_msg("so_start_harbor_player_hind", level._id_4483);
  thread _id_4CB6();
  level._id_4483._id_4C3E = _id_4C96("hind_bow", level._id_4483);
  level.players[0]._id_4C3F[0] = _id_4C97("player_position1", level._id_4483);
  level.players[0]._id_4C3F[1] = _id_4C97("player_position1b", level._id_4483);
  level.players[0]._id_4C3F[2] = _id_4C97("player_position1c", level._id_4483);
  level.players[0] thread _id_4C41();

  if(!level._id_4BFB) {
    level.players[1]._id_4C3F[0] = _id_4C97("player_position2", level._id_4483);
    level.players[1]._id_4C3F[1] = _id_4C97("player_position2b", level._id_4483);
    level.players[1]._id_4C3F[2] = _id_4C97("player_position2c", level._id_4483);
    level.players[1] thread _id_4C41();
  }

  foreach(var_1 in level.players) {
    var_1 _id_4C79(var_1._id_4C3F[0]);
    var_1 allowstand(0);
    var_1 allowprone(0);
  }

  level._id_4483 thread _id_4C40();
  level._id_4483 _id_4C42();
}

_id_4C40() {
  while(!common_scripts\utility::flag("hind_ready_for_land")) {
    self.health = 30000;
    wait 0.05;
  }

  wait 1;
}

_id_4C41() {
  common_scripts\utility::flag_clear("laststand_on");
  common_scripts\utility::flag_wait("start_jet_strafe");
  common_scripts\utility::flag_set("laststand_on");
  var_0 = _id_4C9A(self._id_4C3F[1]);
  self playerlinktoblend(self._id_4C3F[1], "tag_origin", 0.25);
  wait 0.25;
  self playerlinktoblend(self._id_4C3F[2], "tag_origin", 0.25);
  wait 0.25;
  self unlink();
  wait 1;
  self disableinvulnerability();
  self enableweapons();
  self allowstand(1);
  self allowprone(1);
}

_id_4C42() {
  wait 0.05;
  var_0 = [];
  var_0[0] = self;
  maps\_anim::_id_11DD(var_0, "open_door_idle", undefined, undefined, "ny_harbor_hind");
}

_id_4C43() {
  thread _id_4C48();
  thread _id_4C4E();
  thread _id_4C5A();
  thread _id_4C4B();
  thread _id_4C49();
  thread _id_4C58();

  foreach(var_1 in level.players) {}
  var_1 thread _id_4C44("so_missed_reactor_objective", &"SO_ZODIAC2_NY_HARBOR_HINT_OBJ_MISSED", "reactor_saved");

  level waittill("rotation_counter");
  thread _id_4C71("door_reactor2", "org_door_reactor2", 100, "reactor_clip2");
  thread _id_4C71("door_reactor3", "org_door_reactor3", 100, "reactor_clip3");
  maps\_utility::_id_26C0("reactor_spawner");
}

_id_4C44(var_0, var_1, var_2) {
  level endon("special_op_terminated");

  if(!common_scripts\utility::flag(var_2)) {
    level._id_4C45 = getEntArray(var_0, "script_noteworthy");

    while(!common_scripts\utility::flag(var_2)) {
      wait 0.05;

      foreach(var_4 in level._id_4C45) {
        if(!isDefined(self._id_4C46)) {
          if(self istouching(var_4)) {
            self._id_4C46 = 1;
            thread _id_4CA2(var_1, var_4, var_2);
          }

          continue;
        }

        if(!isDefined(self._id_4C47)) {
          thread _id_4CA2(var_1, var_4, var_2);
        }
      }
    }
  }
}

_id_4C48() {
  common_scripts\utility::flag_wait("hatch_open");
  thread _id_4C73();
}

_id_4C49() {
  level waittill("in_missile_room2");
  var_0 = getent("camera_reactor", "targetname");
  var_0 playLoopSound("sub_emt_alarm_01");
  level._id_4C4A _id_4C54();
  common_scripts\utility::flag_wait("reactor_saved");
  var_0 stoploopsound();
}

_id_4C4B() {
  var_0 = common_scripts\utility::getstructarray("ambient_light", "targetname");
  common_scripts\utility::array_thread(var_0, ::_id_4C4C);
}

_id_4C4C() {
  var_0 = _id_4C9A(self);
  common_scripts\utility::flag_wait("reactor_saved");
}

_id_4C4D(var_0) {
  for(;;) {
    _id_4C9B(var_0);
    wait 0.05;
  }
}

_id_4C4E() {
  level._id_4C4A = getent("reactor_valve", "targetname");
  var_0 = _id_4C59(level._id_4C4A);
  var_0 thread _id_4C4D(level._id_4C4A);
  level._id_4C4F = 0;
  var_1 = undefined;
  level._id_4C4A._id_41B4 = 0;

  while(!common_scripts\utility::flag("reactor_saved")) {
    _id_4C51(var_0);
    _id_4C50(var_1);
    var_0 waittill("trigger", var_2);
    level._id_4C4A thread _id_4C53(var_2);
    _id_4C52(var_0);
    var_1 = _id_4C9A(level._id_4C4A);

    if(var_1 _id_3F42(6, var_2)) {
      common_scripts\utility::flag_set("reactor_saved");
      var_0 hide();
      level._id_4C4A show();
      break;
    }
  }
}

_id_4C50(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }
  if(level._id_4C4A._id_41B4 > 0) {
    level._id_4C4A thread _id_4C55();
  }
}

_id_4C51(var_0) {
  var_0 makeusable();
  level._id_4C4A hide();
  var_0 show();
}

_id_4C52(var_0) {
  var_0 makeunusable();
  var_0 hide();
  level._id_4C4A show();
}

_id_4C53(var_0) {
  var_1 = 10;

  while(var_0 usebuttonpressed()) {
    level._id_4C4F = 1;
    var_2 = self.angles;
    self rotateto((var_2[0], var_2[1], var_2[2] - var_1), 0.1);
    self._id_41B4 = self._id_41B4 + var_1;
    level._id_4BFA = level._id_4BFA - 0.1;
    wait 0.1;

    if(var_0.laststand == 1) {
      break;
    }

    if(common_scripts\utility::flag("reactor_saved")) {
      break;
    }
  }

  level._id_4C4F = 0;
}

_id_4C54() {
  while(!level._id_4C4F) {
    wait 0.05;
  }
  self playLoopSound("sub_emt_vent_steamy");
  var_0 = _id_4C9A(self);
  common_scripts\utility::flag_wait("reactor_saved");
  self stoploopsound();
  var_0 waittill("sound_done");
  var_0 delete();
}

_id_4C55(var_0) {
  self endon("trigger");
  var_1 = 5;

  while(!_id_4C56() && !self._id_41B4 <= 0 && !common_scripts\utility::flag("reactor_saved")) {
    var_2 = self.angles;
    self rotateto((var_2[0], var_2[1], var_2[2] + var_1), 0.1);
    self._id_41B4 = self._id_41B4 - var_1;
    level._id_4BFA = level._id_4BFA + 0.05;
    wait 0.1;
  }
}

_id_4C56() {
  level._id_4C57 = 0;

  foreach(var_1 in level.players) {
    if(var_1 usebuttonpressed()) {
      level._id_4C57++;
    }
  }

  if(level._id_4C57 > 0) {
    return 1;
  } else {
    return 0;
  }
}

_id_4C58() {
  var_0 = level._id_4C4A._id_41B4;

  while(!common_scripts\utility::flag("reactor_saved")) {
    if(var_0 < level._id_4C4A._id_41B4 - 10 || var_0 > level._id_4C4A._id_41B4 + 10) {
      level notify("rotation_counter");
      var_0 = level._id_4C4A._id_41B4;
    }

    wait 0.05;
  }
}

_id_3F42(var_0, var_1) {
  if(maps\_shg_common::_id_16A8(var_1, undefined, level._id_4BFA, &"SO_ZODIAC2_NY_HARBOR_HINT_VALVE_TURNING", &"SO_ZODIAC2_NY_HARBOR_HINT_DISARM_SUCCESS", undefined, undefined)) {
    return 1;
  } else {
    return 0;
  }
}

_id_4C59(var_0) {
  var_1 = "ny_harbor_sub_pipe_valve_02_obj";
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_1);
  var_2 _id_4C9B(var_0);
  var_2 sethintstring(&"SO_ZODIAC2_NY_HARBOR_HINT_VALVE");
  return var_2;
}

_id_4C5A() {
  var_0 = getEntArray("reactor_steam", "targetname");
  var_1 = _id_4C5B(var_0);
  var_1 = maps\_utility::_id_0B53(var_1);
  var_2 = 0;

  while(!common_scripts\utility::flag("reactor_saved")) {
    var_3 = level._id_4C4A._id_41B4;
    level waittill("rotation_counter");

    if(var_3 < level._id_4C4A._id_41B4) {
      if(isDefined(var_1[var_2])) {
        stopFXOnTag(common_scripts\utility::getfx("steam_jet1"), var_1[var_2], "tag_origin");
        var_1[var_2] stoploopsound();
      }

      var_2++;
      continue;
    }

    if(isDefined(var_1[var_2])) {
      playFXOnTag(common_scripts\utility::getfx("steam_jet1"), var_1[var_2], "tag_origin");
      var_1[var_2] playLoopSound("sub_emt_steam_lp_01");
    }

    var_2--;
  }

  common_scripts\utility::flag_wait("reactor_saved");

  foreach(var_5 in var_1) {}
  stopFXOnTag(common_scripts\utility::getfx("steam_jet1"), var_5, "tag_origin");
}

_id_4C5B(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_4] = _id_4C9A(var_3);
    playFXOnTag(common_scripts\utility::getfx("steam_jet1"), var_1[var_4], "tag_origin");
    var_1[var_4] playLoopSound("sub_emt_steam_lp_01");
  }

  return var_1;
}

_id_4C5C() {
  _id_4C7E();
  thread _id_4C6C();
  thread _id_4C5D();
  thread _id_4C7C();
}

_id_4C5D() {
  thread _id_4C62();
  common_scripts\utility::flag_wait("kill_spawners_1");
  var_0 = _id_4C16("spawner_mis1_1", ::_id_4C6B);
  common_scripts\utility::array_thread(level.players, ::_id_4C5E, "thermal_reminder_trig");
  common_scripts\utility::array_thread(level.players, ::_id_4C5F, "exit_missile_room_1");
  common_scripts\utility::flag_wait("in_missile_room");
  common_scripts\utility::array_thread(level.players, ::_id_4C7B);
  _id_4C6A(var_0);
  common_scripts\utility::flag_set("bombs_defused_missile_room");
  thread _id_4C61();
}

_id_471A(var_0, var_1) {
  wait(var_0);
  self notify(var_1);
}

_id_4C5E(var_0) {
  for(;;) {
    var_1 = _id_4C60(var_0);

    if(var_1 == self && !self._id_4C0C) {
      self forceusehinton(&"SO_ZODIAC2_NY_HARBOR_HINT_THERMAL_ON");
      thread _id_471A(3.5, "timer_up");
      common_scripts\utility::waittill_either("thermal_on", "timer_up");
      self forceusehintoff();
      break;
    }
  }
}

_id_4C5F(var_0) {
  for(;;) {
    var_1 = _id_4C60(var_0);

    if(var_1 == self && self._id_4C0C) {
      self forceusehinton(&"SO_ZODIAC2_NY_HARBOR_HINT_THERMAL_ON");
      thread _id_471A(3.5, "timer_up");
      common_scripts\utility::waittill_either("thermal_off", "timer_up");
      self forceusehintoff();
      break;
    }
  }
}

_id_4C60(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger", var_2);
  return var_2;
}

_id_4C61() {
  var_0 = getent("camera1", "targetname");
  var_1 = getent("camera2", "targetname");
  var_1 playLoopSound("sub_emt_alarm_01");
  var_0 playLoopSound("sub_emt_alarm_01");
  wait 1;
  level notify("trigger_missile_bombs");
}

_id_4C62() {
  thread _id_4C66();
  common_scripts\utility::flag_wait("bombs_defused_missile_room");
  var_0 = getent("spawners_door_guys", "targetname");

  if(level._id_4BFB) {
    var_1 = getent("upper_vol", "targetname");
    var_2 = getent("big_coll_block1_b", "targetname");
    var_2 notsolid();
    var_3 = getent("big_coll_block2_b", "targetname");
    var_3 notsolid();
    var_4 = getent("big_coll_block1", "targetname");
    var_4 notsolid();
    var_5 = getent("big_coll_block2", "targetname");
    var_5 notsolid();

    if(var_1 istouching(level.players[0])) {
      thread _id_4C68(var_0, "door_open_north_top_org", "door_missile_room_1_1", "door_clip_top_north");
      level.players[0]._id_4C03 = 1;
      return;
    }

    thread _id_4C68(var_0, "door_open_north_org", "door_missile_room_1_2", "door_clip_bottom_north");
    return;
  } else {
    thread _id_4C65(var_0, "door_open_south_org", "door_missile_room_1_3", "door_clip_top_south", "door_exit_1_3_origin", "door_exit_1_3_coll2");
    wait 0.5;
    thread _id_4C68(var_0, "door_open_north_org", "door_missile_room_1_2", "door_clip_bottom_north");
  }
}

_id_4C63(var_0) {
  var_1 = getent(var_0, "targetname");
  var_2 = getent("vol_for_door_coll_issue", "targetname");

  for(;;) {
    wait 0.05;

    if(_id_4C64(var_2)) {
      var_1 notsolid();
    } else {
      var_1 solid();
    }
    if(common_scripts\utility::flag("door_3_is_open") && !_id_4C64(var_2)) {
      var_1 solid();
      break;
    }
  }
}

_id_4C64(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 istouching(var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_4C65(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getent(var_1, "targetname");
  var_7 = getent(var_3, "targetname");
  var_8 = getent(var_2, "targetname");
  var_9 = getent(var_5, "targetname");
  var_10 = getent("path_blocker", "targetname");
  var_9 notsolid();
  var_10 notsolid();
  var_11 = getent("vol_for_door_coll_issue", "targetname");
  var_6 _id_4C67(var_0);
  wait 6.83333;
  var_12 = getent(var_4, "targetname");
  var_13 = _id_4C9A(var_12);
  var_9 linkto(var_13, "tag_origin");
  var_8 linkto(var_13, "tag_origin");
  var_13 rotateto((0, 80, 0), 1);
  wait 1;
  var_13 rotateto((0, 120, 0), 1.1);
  wait 1;
  var_7.origin = (0, 0, 0);
  wait 5.83333;
  common_scripts\utility::flag_set("door_3_is_open");
  var_7 connectpaths();
  var_10 solid();
  var_10 connectpaths();
  var_9 connectpaths();
}

_id_4C66() {
  var_0 = getent("big_coll_block2", "targetname");
  var_1 = getent("big_coll_block1", "targetname");
  var_1 notsolid();
  var_2 = getent("big_coll_block2_b", "targetname");
  var_3 = getent("big_coll_block1_b", "targetname");
  var_3 notsolid();
  var_4 = var_0.origin;
  var_5 = var_1.origin;
  var_6 = var_3.origin;
  common_scripts\utility::flag_wait("bombs_defused_missile_room");
  wait 6.83333;
  var_0 moveto(var_5, 1.5);
  var_2 moveto(var_6, 1.5);
  wait 1.5;
  var_0 connectpaths();
  var_2 connectpaths();
  var_1 connectpaths();
  var_3 connectpaths();
  var_0 delete();
}

_id_4C67(var_0) {
  wait(randomfloatrange(0.5, 1.2));
  var_1 = var_0 stalingradspawn();

  if(isDefined(var_1)) {
    var_2 = self.animation;
    var_1._id_1032 = "generic";
    thread maps\_anim::_id_11C1(var_1, var_2);
    var_1 thread _id_4C69();
  }
}

_id_4C68(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getent(var_1, "targetname");
  var_6 = getent(var_3, "targetname");
  var_7 = getent(var_2, "targetname");
  var_7.origin = (0, 0, 0);
  var_8 = maps\_utility::_id_1287("door", var_5.origin);
  var_9 = "open_with_wheel";
  var_5 maps\_anim::_id_11CF(var_8, var_9);
  var_5 _id_4C67(var_0);
  var_8._id_1032 = "door";
  var_8 maps\_anim::_id_1244();
  var_5 thread maps\_anim::_id_1246(var_8, var_9);
  wait 7.83333;
  var_6.origin = (0, 0, 0);
  var_6 connectpaths();
}

_id_4C69() {
  while(isDefined(self) && self.health > 10) {
    wait 0.05;
  }
  if(isDefined(self)) {
    self stopanimscripted();
  }
}

_id_4C6A(var_0) {
  var_1 = var_0.size - 2;
  var_2 = var_0.size - var_1;

  while(var_0.size > var_2) {
    var_0 = maps\_utility::_id_1361(var_0);
    wait 0.05;
  }
}

_id_4C6B() {}

_id_4C6C() {
  var_0 = getEntArray("therm_mis1", "targetname");
  common_scripts\utility::array_call(var_0, ::delete);
}

_id_4C6D(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = [];
  var_5 = getEntArray(var_1, "targetname");
  var_5 = maps\_utility::_id_0B53(var_5);

  if(!isDefined(var_0)) {
    var_0 = var_5.size;
  }
  foreach(var_7 in var_5) {}
  var_7 hide();

  for(var_9 = 0; var_9 < var_0; var_9++) {
    var_5[var_9] show();
    var_4[var_4.size] = var_5[var_9];
    var_5[var_9] thread _id_4C6E(var_2);
  }

  return var_4;
}

_id_4C6E(var_0) {
  if(isDefined(var_0)) {
    level waittill(var_0);
  }
  var_1 = self gettagangles("tag_fx");
  var_2 = anglestoup(var_1);
  var_3 = self.origin + var_2 * 5;
  self._id_4C3C = common_scripts\utility::spawn_tag_origin();
  self._id_4C3C.origin = var_3;
  wait(randomfloatrange(0.1, 0.6));
  playFXOnTag(level._effect["red_dot"], self._id_4C3C, "tag_origin");
  playFXOnTag(level._effect["light_c4_blink"], self, "tag_fx");
  playFXOnTag(level._effect["light_c4_blink"], self, "tag_fx");
  playFXOnTag(level._effect["red_dot"], self, "tag_fx");
  playFXOnTag(level._effect["white_light"], self, "tag_fx");
  thread _id_4C6F();
}

_id_4C6F() {
  if(!isDefined(self._id_4C34)) {
    self._id_4C34 = 0;
  }
  while(!self._id_4C34) {
    if(isDefined(self)) {
      thread maps\_utility::play_sound_on_entity("veh_mine_beep");
    } else {
      break;
    }
    wait 1;
  }
}

_id_4C70(var_0, var_1) {
  level.bombs = var_1.size + 1;

  while(!common_scripts\utility::flag(var_0)) {
    if(var_1.size < 1) {
      common_scripts\utility::flag_set(var_0);
    } else {
      foreach(var_3 in var_1) {
        if(isDefined(var_3._id_4C34) && var_3._id_4C34) {
          var_1 = common_scripts\utility::array_remove(var_1, var_3);
          level.bombs--;

          if(level.bombs == 1) {
            level notify("one_bomb_left");
          }
          if(level.bombs == var_1.size) {
            level notify("one_bomb_defused");
          }
        }
      }
    }

    wait 0.05;
  }
}

_id_4C71(var_0, var_1, var_2, var_3) {
  var_4 = 3;
  var_5 = getent(var_0, "targetname");
  var_6 = getent(var_1, "targetname");
  var_7 = _id_4C9A(var_6);
  var_5 linkto(var_7, "tag_origin");
  var_7 rotateto((0, var_2, 0), var_4);
  wait(var_4 / 2);

  if(isDefined(var_3)) {
    var_8 = getent(var_3, "targetname");
    var_8.origin = (0, 0, 0);
    var_8 connectpaths();
  }
}

_id_4C72(var_0, var_1) {
  var_2 = -1;

  foreach(var_5, var_4 in var_0) {
    if(var_4 == var_1) {
      var_2 = var_5;
    }
  }

  return var_2;
}

_id_4C73() {
  var_0 = 300;
  thread _id_4CA7(var_0, &"SO_ZODIAC2_NY_HARBOR_HINT_MELTDOWN", "times_up_reactor");
  thread _id_4C77("times_up_reactor", "reactor_saved");
  thread _id_4C75();
  common_scripts\utility::flag_wait("reactor_saved");

  foreach(var_2 in level._id_4C74) {
    if(isDefined(var_2)) {
      var_2 destroy();
    }
  }
}

_id_4C75() {
  while(!common_scripts\utility::flag("reactor_saved")) {
    if(level._id_4C4F) {
      level._id_4C74 _id_4C76(0);
    } else {
      level._id_4C74 _id_4C76(1);
    }
    wait 0.05;
  }
}

_id_4C76(var_0) {
  foreach(var_2 in self) {
    if(isDefined(var_2)) {
      var_2.alpha = var_0;
    }
  }
}

_id_4C77(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  var_2 = getEntArray("nuke_view", "targetname");
  wait 0.25;

  while(level._id_4C4F) {
    wait 0.5;
  }
  if(!common_scripts\utility::flag(var_1)) {
    var_3 = blackout(&"SO_ZODIAC2_NY_HARBOR_HINT_FAIL");
    var_3 thread _id_4CA4(0.25);
    wait 0.5;
    _id_4C78();
  }
}

_id_4C78() {
  level._id_16CE = gettime();
  maps\_specialops::_id_183F("@DEADQUOTE_SO_TRY_NEW_DIFFICULTY");
  maps\_utility::_id_1826();
}

_id_4C79(var_0) {
  _id_4C7A(var_0);
  self playerlinktodelta(var_0, "tag_origin", 1);
  self lerpviewangleclamp(0, 0.5, 0, 110, 110, 90, 90);
}

_id_4C7A(var_0) {
  self setorigin(var_0.origin);

  if(isDefined(var_0.angles)) {
    self setplayerangles(var_0.angles);
  }
}

_id_4C7B() {
  var_0 = getent("exit_missile_room_1", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);
    level notify("in_missile_room2");

    if(var_1 == self) {
      break;
    }
  }
}

_id_4C7C() {
  common_scripts\utility::flag_wait("bombs_defused_missile_room");
  maps\_utility::_id_26C0("f_spawner_mis2");
}

_id_4C7D() {
  var_0 = 0.7;
  var_1 = 1;
  maps\_utility::_id_109B();
  self.accuracy = var_0;
  self._id_20AF = self._id_20AF * var_1;

  if(common_scripts\utility::cointoss()) {
    self.ignoresuppression = 1;
  } else {
    self.ignoresuppression = 0;
  }
}

_id_4C7E() {
  var_0 = getEntArray("pressure_door_model", "targetname");
  common_scripts\utility::array_call(var_0, ::delete);
  var_1 = getEntArray("pressure_door_coll", "targetname");
  common_scripts\utility::array_call(var_1, ::delete);
  var_2 = getEntArray("sub_pressuredoor_rocker_opposite", "targetname");
  common_scripts\utility::array_call(var_2, ::delete);
  var_3 = getEntArray("sub_pressuredoor_rocker", "targetname");
  common_scripts\utility::array_call(var_3, ::delete);
  var_4 = getEntArray("ladder_coll_bridge_exit", "targetname");
  common_scripts\utility::array_call(var_4, ::delete);
  _id_4C7F("barracks_door_coll_01", 1);
  _id_4C7F("breach_door_col");
  _id_4C7F("brush_missile_room_door", 1);
  _id_4C7F("clip_reactor_room_hall_door", 1);
  _id_4C7F("clip_barracks_exit", 1);
  _id_4C7F("barracks_open_door_col", 1);
  _id_4C7F("barracks_open_door_right_col", 1);
  _id_4C7F("sub_graph_blocker", 1);
  level._id_4B81 = getent("frag_grenade", "targetname");
  level._id_4B81 hide();
}

_id_4C7F(var_0, var_1) {
  var_2 = getent(var_0, "targetname");

  if(isDefined(var_2)) {
    var_2.origin = (0, 0, 0);

    if(isDefined(var_1)) {
      var_2 connectpaths();
    }
  }
}

_id_4B7C() {
  foreach(var_1 in level.players) {}
  var_1._id_4C80 = 0;

  common_scripts\utility::flag_wait("open_rear_hatch");
  maps\_compass::setupminimap("compass_map_ny_harbor");
  var_3 = getEntArray("rear_hatch_collision", "targetname");
  common_scripts\utility::array_call(var_3, ::delete);
  var_4 = getent("hatch_component1", "targetname");
  var_5 = getent("hatch_component2", "targetname");
  var_6 = getent("hatch_org", "targetname");
  var_7 = _id_4C9A(var_6);
  var_4 linkto(var_7, "tag_origin");
  var_5 linkto(var_7, "tag_origin");
  var_7 rotateto((154, 0, 180), 1.35);
  level notify("spawn_exit_chopper");
}

_id_4C81() {
  thread _id_4B7C();
  thread _id_4C82("hatch_player_slide", "exit_trigger_sub", "check_for_player_using_ladder");
}

_id_4C82(var_0, var_1, var_2) {
  thread _id_4B85(var_0, "exit_ladder_pos1", "exit_ladder_pos0");
  var_3 = getent(var_0, "targetname");
  var_3._id_4C22 = 0;
  common_scripts\utility::array_thread(level.players, ::_id_4C83, var_3, var_2);
  var_4 = getent(var_1, "targetname");

  for(;;) {
    var_4 waittill("trigger", var_5);
    var_5 _id_4C88();
  }
}

_id_4C83(var_0, var_1) {
  var_2 = getent(var_1, "targetname");
  var_3 = var_0.origin;

  for(;;) {
    wait 0.05;

    if(var_2 istouching(self) && !var_0._id_4C22) {
      var_0._id_4C22 = 1;
      var_0.origin = (50, 50, 50);
      continue;
    }

    if(!var_2 istouching(self) && var_0._id_4C22) {
      var_0.origin = var_3;
      var_0._id_4C22 = 0;
    }
  }
}

_id_4C84(var_0, var_1) {
  var_2 = getent(var_1, "targetname");
  var_3 = var_0.origin;

  for(;;) {
    wait 0.05;

    if(var_2 istouching(self) && !var_0._id_4C22) {
      var_0._id_4C22 = 1;
      var_0.origin = (50, 50, 50);
      continue;
    }

    if(!var_2 istouching(self) && var_0._id_4C22 && _id_4C85(self)) {
      var_0.origin = var_3;
      var_0._id_4C22 = 0;
    }
  }
}

_id_4C85(var_0) {
  var_1 = getent("ladder_safety_clip_vol", "targetname");

  if(!level._id_4BFB) {
    foreach(var_3 in level.players) {
      if(var_1 istouching(var_3)) {
        return 0;
      }
    }

    return 1;
  } else {
    return 1;
  }
}

_id_4B85(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
  var_4 = getent("dont_allow_ladder", "targetname");

  for(;;) {
    var_3 sethintstring(&"NY_HARBOR_HINT_USE_TO_ENTER");
    var_3 usetriggerrequirelookat();
    var_3 waittill("trigger", var_5);

    if(!var_4 istouching(var_5)) {
      var_5 _id_4C87(var_1, var_2);
    }
  }
}

_id_4C86() {
  var_0 = getent("check_for_player_using_ladder", "targetname");

  foreach(var_2 in level.players) {
    if(var_0 istouching(var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_4C87(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = getent(var_1, "targetname");

  if(!self._id_4C80 && !_id_4C86()) {
    var_4 = _id_4C9A(self);
    self._id_4C80 = 1;
    self playerlinkto(var_4, "tag_origin", 1);
    var_4 moveto(var_2.origin, 0.25);
    wait 0.25;
    var_4 moveto(var_3.origin, 0.75);
    var_4 rotateto(var_3.angles, 0.75);
    wait 0.8;
    self unlink();
    self._id_4C80 = 0;
    var_4 delete();
  }
}

_id_4C88() {
  var_0 = getent("exit_ladder_pos1", "targetname");
  var_1 = getent("exit_ladder_pos2_p0", "targetname");
  var_2 = getent("exit_ladder_pos2_p1", "targetname");

  if(!self._id_4C80) {
    var_3 = _id_4C9A(self);
    self._id_4C80 = 1;
    self playerlinkto(var_3, "tag_origin", 1);
    var_3 moveto(var_0.origin, 1);
    wait 1;

    if(self == level.players[0]) {
      var_3 moveto(var_1.origin, 1);
      var_3 rotateto(var_1.angles, 1);
    } else {
      var_3 moveto(var_2.origin, 1);
      var_3 rotateto(var_2.angles, 1);
    }

    wait 1;
    self unlink();
    self._id_4C80 = 0;
  }
}

_id_4C89() {
  thread _id_4C8C();
  thread _id_4C8A();
  thread _id_4C8B();
  thread _id_4C81();
  thread _id_4C91();
  common_scripts\utility::flag_wait("reactor_saved");
  common_scripts\utility::flag_init("so_exit_volume");
  maps\_specialops::_id_17EF("so_exit_volume", "so_zodiac2_ny_harbor_complete", "all");
  common_scripts\utility::flag_wait("so_zodiac2_ny_harbor_complete");
  var_0 = getaiarray("axis");
  common_scripts\utility::array_call(var_0, ::kill);
}

_id_4C8A() {
  level waittill("spawn_exit_chopper");
  var_0 = getEntArray("player_trying_to_escape", "targetname");

  foreach(var_2 in var_0) {}
  var_2.origin = (0, 0, 0);
}

_id_4C8B() {
  common_scripts\utility::flag_wait("spawn_enemy_chopper2");
  var_0 = maps\_vehicle::_id_2881("end_enemy_chopper2");
}

_id_4C8C() {
  common_scripts\utility::flag_wait("spawn_exit_chopper");
  var_0 = getent("so_exit_volume", "script_noteworthy");
  maps\_audio::aud_send_msg("so_start_harbor_exit_hind", level._id_4483);
  var_0 thread _id_4C90(level._id_4483);
}

_id_4C8D() {
  common_scripts\utility::flag_wait("shoot_at_stragglers");

  for(;;) {
    wait 0.05;
    var_0 = maps\_utility::_id_1EE9(self.origin, "axis");
    var_1 = self._id_4C8E[randomint(self._id_4C8E.size)];

    if(isDefined(var_0)) {
      var_1 _id_4C8F(var_0);
    }
  }
}

_id_4C8F(var_0) {
  var_1 = randomintrange(5, 12);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(isDefined(var_0)) {
      _id_4C2F("mp7_reflex", 15, var_0.origin, self);
    }
    wait 0.05;
  }
}

_id_4C90(var_0) {
  for(;;) {
    self.origin = var_0.origin;
    wait 0.05;
  }
}

_id_4B7D() {
  var_0 = getent("rear_hatch_col", "targetname");
  var_0 notsolid();
  common_scripts\utility::flag_wait("hatch_open");
  var_1 = _id_4C94();
  maps\_compass::setupminimap("compass_map_ny_harbor_sub", "sub_minimap_corner");
  setsaveddvar("compassmaxrange", 1000);
  var_1 rotateto((89, var_1.angles[1], var_1.angles[2]), 3);
}

_id_4C91() {
  var_0 = getent("exit_missile_room_1", "targetname");
  common_scripts\utility::array_thread(level.players, ::_id_4C92, var_0);
  var_1 = getent("ladder_brush_bridge", "targetname");
  var_2 = var_1.origin;
  var_1.origin = (50, 50, 50);
  common_scripts\utility::flag_wait("spawn_enemy_chopper2");
  var_3 = getent("sight_trigger_front_hatch", "targetname");
  var_3.origin = (50, 50, 50);

  if(common_scripts\utility::flag("close_hatch")) {
    var_4 = _id_4C94();
    var_4 rotateto((-89, var_4.angles[1], var_4.angles[2]), 3);
    var_5 = getent("rear_hatch_col", "targetname");
    var_5 solid();
    var_6 = getent("rear_hatch_cap", "targetname");
    var_6 solid();
    var_7 = getent("rear_cap_coll_2", "targetname");
    var_7 solid();
  } else {
    var_1.origin = var_2;
  }
}

_id_4C92(var_0) {
  level._id_4C93 = 0;

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == self) {
      level._id_4C93++;

      if(level._id_4C93 == level.players.size) {
        common_scripts\utility::flag_set("close_hatch");
      }
      break;
    }
  }
}

_id_4C94() {
  var_0 = getent("rear_hatch_component1", "targetname");
  var_1 = getent("rear_hatch_component2", "targetname");
  var_2 = getent("rear_hatch_col_top", "targetname");
  var_2 notsolid();
  var_3 = getent("rear_hatch_org", "targetname");
  var_4 = _id_4C9A(var_3);
  var_0 linkto(var_4, "tag_origin");
  var_1 linkto(var_4, "tag_origin");
  var_2 linkto(var_4, "tag_origin");
  var_5 = getent("rear_hatch_col_interior", "targetname");
  var_5 notsolid();
  return var_4;
}

_id_4C95(var_0, var_1) {
  var_2 = [];
  var_3 = common_scripts\utility::getstructarray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_6 = _id_4C99(var_5, var_1);
    var_2[var_2.size] = var_6;
  }

  return var_2;
}

_id_4C96(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, "targetname");
  var_3 = _id_4C99(var_2, var_1);
  return var_3;
}

_id_4C97(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = _id_4C99(var_2, var_1);
  return var_3;
}

_id_4C98(var_0, var_1) {
  var_2 = _id_4C99(var_0, var_1);
  return var_2;
}

_id_4C99(var_0, var_1) {
  var_2 = _id_4C9A(var_0);
  var_2 linkto(var_1, "tag_origin");
  return var_2;
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

_id_4C9C() {
  thread _id_4CA5();
  var_0 = ["missile_hatch_r_8", "missiles_r_8", "missle_silo_r_5"];
  var_1 = ["missile_hatch_r_7", "missiles_r_7", "missle_silo_r_4", "missle_silo_r_3"];
  var_2 = ["missile_hatch_r_6", "missiles_r_6", "missle_silo_r_3"];
  var_3 = ["missile_hatch_r_5", "missiles_r_5", "missle_silo_r_3"];
  var_4 = ["missile_hatch_r_4", "missiles_r_4", "missle_silo_r_2"];
  var_5 = ["missile_hatch_r_3", "missiles_r_3", "missle_silo_r_2"];
  var_6 = ["missile_hatch_r_2", "missiles_r_2", "missle_silo_r_1"];
  var_7 = ["missile_hatch_r_1", "missiles_r_1", "missle_silo_r_1", "missle_silo_r_0"];
  var_8 = ["missile_hatch_r_1", "missiles_r_1", "missle_silo_r_0"];
  var_9 = ["missile_hatch_l_8", "missiles_l_8", "missle_silo_l_5"];
  var_10 = ["missile_hatch_l_7", "missiles_l_7", "missle_silo_l_4", "missle_silo_l_3"];
  var_11 = ["missile_hatch_l_6", "missiles_l_6", "missle_silo_l_3"];
  var_12 = ["missile_hatch_l_5", "missiles_l_5", "missle_silo_l_3"];
  var_13 = ["missile_hatch_l_4", "missiles_l_4", "missle_silo_l_2"];
  var_14 = ["missile_hatch_l_3", "missiles_l_3", "missle_silo_l_2"];
  var_15 = ["missile_hatch_l_2", "missiles_l_2", "missle_silo_l_1"];
  var_16 = ["missile_hatch_l_1", "missiles_l_1", "missle_silo_l_1", "missle_silo_l_0"];
  var_17 = ["missile_hatch_l_1", "missiles_l_1", "missle_silo_l_0"];
  level._id_4C9D = [];
  level._id_4C9D[0] = var_0;
  level._id_4C9D[1] = var_8;
  level._id_4C9E = [];
  level._id_4C9E[0] = var_9;
  level._id_4C9E[1] = var_17;
  common_scripts\utility::flag_wait("hind_ready_for_land");
  _id_4CA0();
}

_id_4C9F(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  wait(randomfloatrange(1.0, 4.0));

  while(!common_scripts\utility::flag("in_missile_room")) {
    var_4 = randomint(var_0.size);

    if(!isDefined(var_3[var_4])) {
      var_1[var_1.size] = _id_4B5C(var_0[var_4][2], var_4);
      var_3[var_4] = 1;
    } else {
      wait 4;
    }
    var_2[var_2.size] = _id_4B5B(var_0[var_4][0]);
    _id_4B61(var_0[var_4][1]);
    wait(randomfloatrange(0.05, 0.5));
  }
}

_id_4CA0(var_0, var_1) {
  var_2 = getEntArray("missile_silo_door", "targetname");
  common_scripts\utility::array_call(var_2, ::hide);
  var_3 = getEntArray("missle_silo_pocket_middle", "targetname");
  common_scripts\utility::array_call(var_3, ::hide);
  var_4 = getEntArray("missle_silo_pocket", "targetname");
  common_scripts\utility::array_call(var_4, ::hide);
  var_5 = getEntArray("missle_silo_pocket_rear", "targetname");
  common_scripts\utility::array_call(var_5, ::hide);
}

_id_4B5B(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4.targetname)) {
      continue;
    }
    if(var_4.targetname == "missile_hatch") {
      var_2 = var_4;
      break;
    }
  }

  var_2._id_1032 = "missile_hatch";
  var_2 maps\_anim::_id_1244();
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6.origin = var_2.origin;
  var_6.angles = (270, 0, 0);
  playFXOnTag(common_scripts\utility::getfx("steam_missile_tube"), var_6, "tag_origin");
  var_2 maps\_anim::_id_1246(var_2, "open");
  var_7 = randomfloat(3) + 2;
  wait(var_7);
  stopFXOnTag(common_scripts\utility::getfx("steam_missile_tube"), var_6, "tag_origin");
  var_6 delete();
  return var_2;
}

_id_4B5C(var_0, var_1) {
  var_2 = getEntArray(var_0, "script_noteworthy");
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.targetname)) {
      continue;
    }
    if(var_5.targetname == "missile_silo_door") {
      var_3 = var_5;
      break;
    }
  }

  var_7 = undefined;

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.targetname)) {
      continue;
    }
    if(var_5.targetname == var_3.target) {
      var_7 = var_5;
      break;
    }
  }

  var_3._id_1032 = "missile_door";
  var_3 maps\_anim::_id_1244();
  var_7 linkto(var_3, "door");
  maps\_audio::aud_send_msg("sub_missile_door_open", var_7);
  var_7 playSound("russian_sub_missile_door");
  var_3 maps\_anim::_id_1246(var_3, "open");
  return var_3;
}

_id_4B5E(var_0) {
  wait 0.95;
  playFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke12"), self, "tag_tail");
  wait 0.5;
  maps\_utility::_id_13DB("contrails");
  stopFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke12"), self, "tag_tail");
}

_id_4B5F(var_0) {
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke"), self, "tag_tail");
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("ssn12_init"), self, "tag_tail");
}

_id_4B60() {
  self endon("death");
  wait 0.5;
  self setanim(level._id_0C59["ss_n_12_missile"]["open"], 1, 0);
}

_id_4B61(var_0) {
  var_1 = maps\_vehicle::_id_2A99(var_0);
  var_1._id_1032 = "ss_n_12_missile";
  var_1 maps\_anim::_id_1244();
  var_1 setanim(var_1 maps\_utility::_id_1281("close_idle"), 1, 0);
  var_1._id_2950 = 1;
  var_1 thread _id_4B5E(var_0);
  maps\_audio::aud_send_msg("so_sub_missile_launch", var_1);
  wait 0.75;
  var_1 thread _id_4B60();
  thread maps\_vehicle::_id_1FA6(var_1);
  maps\_audio::aud_send_msg("so_sub_missile_launch", var_1);
}

_id_4B45(var_0) {
  common_scripts\utility::flag_wait("so_zodiac2_ny_harbor_complete");
  level notify("stop_rocking");
  level.player playersetgroundreferenceent(undefined);
  self delete();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_4B46() {
  level._id_4B47[0] = 0.5;
  level._id_4B47[1] = 1.5;
  common_scripts\utility::flag_set("outside_above_water");
}

_id_4B48() {
  level._id_4B47[0] = 1.0;
  level._id_4B47[1] = 2.5;
  common_scripts\utility::flag_clear("outside_above_water");
}

_id_4B4D() {
  level endon("stop_rocking");
  var_0 = getent("rocking_reference", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = undefined;

  if(!isDefined(var_0)) {
    var_1.angles = (0, 0, 0);
  } else {
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
  }

  var_1 thread _id_4B45(var_2);
  var_3 = 1;
  level._id_4B47[0] = 1.0;
  level._id_4B47[1] = 2.5;
  var_4 = getEntArray("rocking_water", "targetname");
  var_5 = getEntArray("bobbing_small", "script_noteworthy");

  foreach(var_7 in var_5) {
    var_7._id_4B07 = var_7.origin;
    var_7._id_4B4E = var_7.angles;
    var_8 = cos(var_7.angles[1]);
    var_9 = sin(var_7.angles[1]);
    var_7._id_4B4F = (var_8, 0, var_9);
  }

  if(isDefined(var_2)) {
    foreach(var_7 in var_4) {}
    var_7 linkto(var_2, "tag_origin");
  }

  thread _id_4B54();
  self playersetgroundreferenceent(var_1);
  thread _id_4B52(var_1);

  for(;;) {
    var_13 = randomfloatrange(2.0, 3.0);
    var_14 = var_3 * randomfloatrange(level._id_4B47[0], level._id_4B47[1]);
    var_3 = -1 * var_3;
    var_15 = (0, 0, var_14);
    var_1._id_4B50 = var_15;
    var_1._id_4B51 = gettime() + 1000 * var_13;
    maps\_audio::aud_send_msg("if_the_sub_is_a_rocking_dont_come_a_knocking");
    var_1 rotateto(var_15, var_13, var_13 / 3, var_13 / 3);

    if(isDefined(var_2)) {
      var_15 = (0, 0, 0.5 * var_14);
      var_2 rotateto(var_15, var_13, var_13 / 3, var_13 / 3);
    }

    wait(var_13);
  }
}

_id_4B54() {
  level._id_4B55 = [];
  level._id_4B56 = [];
  level._id_4B57 = [];
  var_0 = getEntArray("sub_pressuredoor_rocker", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    var_2 linkto(var_3);
    level._id_4B55[level._id_4B55.size] = var_3;
  }

  var_0 = getEntArray("sub_pressuredoor_rocker_opposite", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    var_2 linkto(var_3);
    level._id_4B56[level._id_4B56.size] = var_3;
  }

  var_7 = getEntArray("dyn_hanger", "targetname");

  foreach(var_9 in var_7) {
    var_3 = getent(var_9.target, "targetname");
    var_9 linkto(var_3);
    level._id_4B57[level._id_4B57.size] = var_3;
  }
}

_id_4B58(var_0, var_1, var_2, var_3) {
  var_4 = 3 * (level._id_4B47[1] * var_0);

  foreach(var_6 in level._id_4B55) {}
  var_6 rotateto((var_6.angles[0], var_6.angles[1] + var_4, var_6.angles[0]), var_1, var_2, var_3);

  foreach(var_6 in level._id_4B56) {}
  var_6 rotateto((var_6.angles[0], var_6.angles[1] + -1 * var_4, var_6.angles[0]), var_1, var_2, var_3);

  foreach(var_6 in level._id_4B57) {
    switch (var_6.script_noteworthy) {
      case "x":
        var_6 rotateto((var_6.angles[0] + var_4, var_6.angles[1], var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "x_neg":
        var_6 rotateto((var_6.angles[0] + -1 * var_4, var_6.angles[1], var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "y":
        var_6 rotateto((var_6.angles[0], var_6.angles[1] + var_4, var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "y_neg":
        var_6 rotateto((var_6.angles[0], var_6.angles[1] + -1 * var_4, var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "z":
        var_6 rotateto((var_6.angles[0], var_6.angles[1], var_6.angles[0] + var_4), var_1, var_2, var_3);
        break;
      case "z_neg":
        var_6 rotateto((var_6.angles[0], var_6.angles[1], var_6.angles[0] + -1 * var_4), var_1, var_2, var_3);
        break;
      default:
        break;
    }
  }
}

_id_4B59(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, 1, 0);
  var_6 = var_1[2];
  var_7 = var_6 / 2.5;

  foreach(var_9 in var_0) {
    var_10 = randomfloatrange(4, 12);
    var_11 = var_9._id_4B07 + var_10 * var_7 * var_5;
    var_9 moveto(var_11, var_2, var_3, var_4);
    var_12 = randomfloatrange(3 * level._id_4B47[0], 3 * level._id_4B47[1]);
    var_13 = var_12 * var_7;
    var_14 = (var_9._id_4B4F[0] * var_13, var_9._id_4B4F[1] * var_13, var_9._id_4B4F[2] * var_13);
    var_1 = var_9._id_4B4E + var_14;
    var_9 rotateto(var_1, var_2, var_3, var_4);
  }
}

_id_4B52(var_0) {
  level endon("stop_rocking");
  thread _id_4B53();
  var_1 = 0;
  var_2 = common_scripts\utility::getstruct("jolter", "targetname");
  common_scripts\utility::flag_wait("hatch_player_using_ladder");

  for(;;) {
    var_3 = anglestoup(var_0.angles);
    var_4 = -1 * var_3;
    var_5 = var_4 * (1, 10, 0.75);
    var_6 = vectornormalize(var_5);
    setphysicsgravitydir(var_6);
    var_1++;

    if(var_1 > 10) {
      physicsjitter(var_2.origin, 1000, 800, 0.01, 0.1);
      var_1 = 0;
    }

    wait 0.05;
  }
}

_id_4B53() {
  level waittill("stop_rocking");
  wait 0.05;
  setphysicsgravitydir((0, 0, -1));
}

_id_4CA1() {
  var_0 = maps\_utility::create_vision_set_fog("so_zodiac2_ny_harbor_sub_1");
  var_0.startdist = 163.765;
  var_0.halfwaydist = 624.903;
  var_0.red = 0.311765;
  var_0.green = 0.311765;
  var_0.blue = 0.321765;
  var_0.maxopacity = 0.332562;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0._id_1AF0 = 0.75853;
  var_0._id_1AF1 = 0.747528;
  var_0._id_1AF2 = 0.658636;
  var_0._id_1AF3 = (-0.506012, 0.588929, 0.630171);
  var_0._id_1AF4 = 0;
  var_0._id_1AF5 = 17.001;
  var_0._id_1AF6 = 3.83587;
  var_0 = maps\_utility::create_vision_set_fog("so_zodiac2_ny_harbor_sub_2");
  var_0.startdist = 263.765;
  var_0.halfwaydist = 624.903;
  var_0.red = 0.311765;
  var_0.green = 0.311765;
  var_0.blue = 0.321765;
  var_0.maxopacity = 0.232562;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  var_0._id_1AF0 = 0.75853;
  var_0._id_1AF1 = 0.747528;
  var_0._id_1AF2 = 0.658636;
  var_0._id_1AF3 = (-0.506012, 0.588929, 0.630171);
  var_0._id_1AF4 = 0;
  var_0._id_1AF5 = 17.001;
  var_0._id_1AF6 = 3.83587;
  common_scripts\utility::flag_wait("in_missile_room");
  thread maps\_utility::vision_set_fog_changes("so_zodiac2_ny_harbor_sub_1", 1);
  level waittill("in_missile_room2");
  thread maps\_utility::vision_set_fog_changes("so_zodiac2_ny_harbor_sub_2", 2);
}

_id_4CA2(var_0, var_1, var_2) {
  if(isDefined(self._id_4C47)) {
    return;
  }
  if(!self istouching(var_1)) {
    return;
  }
  if(common_scripts\utility::flag(var_2)) {
    return;
  }
  self endon("death");
  self._id_4C47 = maps\_shg_common::_id_16B5(3.5, 0, var_0);
  self._id_4C47.alignx = "center";
  self._id_4C47.horzalign = "center";

  while(self istouching(var_1)) {
    self._id_4C47.alpha = 1;
    self._id_4C47 fadeovertime(1);
    self._id_4C47.alpha = 0.5;
    self._id_4C47.fontscale = 1.5;
    self._id_4C47 changefontscaleovertime(1);
    self._id_4C47.fontscale = 1;
    wait 1;
  }

  self._id_4C47.alpha = 0.5;
  self._id_4C47 fadeovertime(0.25);
  self._id_4C47.alpha = 0;
  wait 0.25;
  self._id_1821 = undefined;

  if(isDefined(self._id_4C47)) {
    self._id_4C47 destroy();
  }
}

_id_4CA3(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {}

  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  var_0 = var_0 + 2;
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_5 = maps\_hud_util::_id_09A5(-60, undefined, var_3, 1);
  } else {
    var_5 = maps\_hud_util::_id_09A5(-60, undefined, undefined, 1);
  }
  var_5.alignx = "center";
  var_5.aligny = "top";
  var_5.horzalign = "center";
  var_5.vertalign = "middle";
  var_5.x = var_1;
  var_5.y = -160 + 15 * var_0;
  var_5.font = "hudsmall";
  var_5.foreground = 1;
  var_5.hidewheninmenu = 1;
  var_5.hidewhendead = 1;
  var_5.sort = 2;
  var_5.color = (0.9, 0.9, 1);
  var_5.fontscale = 1.15;

  if(isDefined(var_2)) {
    var_5.label = var_2;
  }
  if(!isDefined(var_4) || !var_4) {
    if(isDefined(var_3)) {
      if(!var_3 maps\_specialops_code::_id_1844()) {
        var_3 thread maps\_specialops_code::_id_1845(var_5);
      }
    }
  }

  return var_5;
}

_id_4CA4(var_0) {
  self fadeovertime(var_0);
  self.alpha = 1;
}

blackout(var_0) {
  var_1 = newhudelem();
  var_1 setshader("black", 640, 480);
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 0;
  var_1.sort = 2;
  return var_1;
}

_id_4CA5() {
  var_0 = common_scripts\utility::getstructarray("missile_smoke", "targetname");

  foreach(var_2 in var_0) {}
  playFX(common_scripts\utility::getfx("smokescreen"), var_2.origin);

  wait 1;

  for(;;) {
    var_0 _id_4CA6();
  }
}

_id_4CA6() {
  foreach(var_1 in self) {}
  playFX(common_scripts\utility::getfx("smokescreen"), var_1.origin);

  wait 30;
}

_id_4CA7(var_0, var_1, var_2, var_3) {
  thread _id_4CA8(var_0, 0, var_1, undefined, var_3);
  wait(var_0);

  if(isDefined(var_2)) {
    common_scripts\utility::flag_set(var_2);
  } else {
    return 1;
  }
}

_id_4CA8(var_0, var_1, var_2, var_3, var_4) {
  level endon("special_op_terminated");

  if(!isDefined(var_2)) {
    var_2 = &"SPECIAL_OPS_STARTING_IN";
  }
  var_5 = _id_4CA3(0, -60, var_2, var_4);
  var_5 setpulsefx(50, var_0 * 1000, 500);
  var_6 = _id_4CA3(0, 115, undefined, var_4);
  var_6 thread maps\_specialops::_id_1801(var_0, var_3);
  level._id_4C74 = [var_5, var_6];
  wait(var_0);
  level.player playSound("arcademode_zerodeaths");

  if(isDefined(var_1) && var_1) {
    level._id_16CF = gettime();
  }
  thread _id_4CA9(var_5, var_6);
}

_id_4CA9(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
  }
  wait 1;

  if(isDefined(var_0) && isDefined(var_1)) {
    var_0 destroy();
    var_1 destroy();
  }
}

_id_4A25(var_0, var_1, var_2, var_3, var_4) {
  var_5[0] = 3;
  var_6[0] = 3;
  var_7[0] = 30;
  var_8[0] = 4;
  var_9[0] = 0;
  var_5[1] = 8;
  var_6[1] = 8;
  var_7[1] = 10;
  var_8[1] = 1.75;
  var_9[1] = 45;
  var_5[2] = 2;
  var_6[2] = 2;
  var_7[2] = 0;
  var_8[2] = 2;
  var_9[2] = 315;
  maps\ocean_perlin::_id_4A19(var_0);

  for(var_10 = 0; var_10 < 3; var_10++) {
    var_0._id_4A26[var_10] = 0.0001 * var_1 * var_5[var_10];
    var_0._id_4A27[var_10] = 0.0001 * var_2 * var_6[var_10];
    var_0._id_4A28[var_10] = var_3 * var_7[var_10];
    var_0._id_4A29[var_10] = cos(var_9[var_10]) * var_4 * var_8[var_10];
    var_0._id_4A2A[var_10] = sin(var_9[var_10]) * var_4 * var_8[var_10];
  }

  var_0._id_4A2B = -0.5;
  var_0._id_4A2C = -0.5;
  var_0._id_4A2D = 0.0;
  var_0._id_4A2E = 1.0;
  maps\ny_harbor_code_sub::_id_4B14(0);
}

_id_4A2F() {
  var_0 = 1;
  var_1 = 1;
  var_2 = 1;
  var_3 = 0.025;
  level._id_4A30["water_patch"] = spawnStruct();
  _id_4A25(level._id_4A30["water_patch"], var_0, var_1, var_2, var_3);
  level._id_4A30["water_patch_med"] = spawnStruct();
  _id_4A25(level._id_4A30["water_patch_med"], var_0, var_1, 0.5 * var_2, var_3);
  level._id_4A30["water_patch_calm"] = spawnStruct();
  _id_4A25(level._id_4A30["water_patch_calm"], var_0, var_1, 0, var_3);
}

_id_4CAA() {
  _id_47DB();
  _id_4CAC();
  _id_47D8();
  _id_4CAE();
  _id_4CAD();
}

_id_47D9() {}

_id_4CAB() {}

#using_animtree("vehicles");

_id_47DB() {
  level._id_1245["ny_harbor_hind"] = #animtree;
  level._id_0C59["ny_harbor_hind"]["open_door"] = % ny_harbor_hind_open_door;
  level._id_0C59["ny_harbor_hind"]["open_door_idle"] = % ny_harbor_hind_open_door_idle;
}

#using_animtree("script_model");

_id_4CAC() {
  level._id_1245["door_charge"] = #animtree;
  level._id_1F90["door_charge"] = "weapon_frame_charge_iw5";
  level._id_0C59["door_charge"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_player_charge2;
  level._id_1245["breach_door"] = #animtree;
  level._id_1F90["breach_door"] = "ny_harbor_sub_pressuredoor_bridge";
  level._id_0C59["breach_door"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_pressure_door;
  level._id_1245["smoke_column"] = #animtree;
  level._id_0C59["smoke_column"]["fire"] = % fx_ny_smoke_column_anim;
  level._id_0C59["smoke_column"]["rot"] = % fx_ny_smoke_column_rot_anim;
  level._id_1245["missile_door"] = #animtree;
  level._id_0C59["missile_door"]["open"] = % ny_harbor_sub_missile_door_open;
  level._id_1245["missile_hatch"] = #animtree;
  level._id_0C59["missile_hatch"]["open"] = % ny_harbor_sub_missile_hatch_open;
  level._id_1245["wave_front"] = #animtree;
  level._id_0C59["wave_front"]["wave"] = % fx_nyharbor_wave_front_anim;
  level._id_1245["wave_crashing"] = #animtree;
  level._id_0C59["wave_crashing"]["wave"] = % fx_nyharbor_wave_crashing_anim;
  level._id_1245["wave_side"] = #animtree;
  level._id_0C59["wave_side"]["wave"] = % fx_nyharbor_wave_side_anim;
  level._id_1245["explosion_wave"] = #animtree;
  level._id_0C59["explosion_wave"]["wave"] = % fx_nyharbor_explosion_wave_anim;
  level._id_1245["wave_displace"] = #animtree;
  level._id_0C59["wave_displace"]["wave"] = % fx_nyharbor_wave_displace_anim;
}

_id_47D8() {
  level._id_1245["building_des"] = #animtree;
  level._id_0C59["building_des"]["ny_manhattan_building_exchange_01_facade_des_anim"] = % ny_manhattan_building_exchange_01_facade_des_anim;
}

_id_4CAD() {
  level._id_1245["door"] = #animtree;
  level._id_1F90["door"] = "ny_harbor_sub_pressuredoor_rigged";
  level._id_0C59["door"]["open_with_wheel"] = % ny_harbor_delta_bulkhead_open_door_v2;
}

#using_animtree("generic_human");

_id_4CAE() {
  level._id_1245["floating_body"] = #animtree;
  level._id_0C59["generic"]["ny_harbor_paried_takedown_captain_dead_1"] = % ny_harbor_paried_takedown_captain_dead_1;
  level._id_0C59["generic"]["ny_harbor_paried_takedown_captain_die"] = % ny_harbor_paried_takedown_captain_die;
  level._id_0C59["generic"]["ny_harbor_delta_bulkhead_open_guy1_v2"] = % ny_harbor_delta_bulkhead_open_guy1_v2;
}

_id_4CAF() {
  level._effect["smokescreen"] = loadfx("smoke/smoke_grenade_low");
  level._effect["red_dot"] = loadfx("misc/aircraft_light_cockpit_red");
  level._effect["light_c4_blink"] = loadfx("misc/light_c4_blink");
  level._effect["white_light"] = loadfx("misc/aircraft_light_white_blink");
  level._effect["red_light"] = loadfx("lights/hijack_fxlight_red_blink");
  level._effect["steam_jet1"] = loadfx("smoke/steam_jet_loop_cheap");
  level._effect["steam_jet2"] = loadfx("smoke/steam_jet_med_loop_harbor");
  level._effect["fire_gen"] = loadfx("fire/cpu_fire");
  level._effect["fire_steam"] = loadfx("impacts/pipe_fire_looping");
}

_id_4CB0() {
  level._id_11BB["so_zodiac2_hqr_oncamera"] = "so_zodiac2_hqr_oncamera";
  level._id_11BB["so_zodiac2_hqr_riggedsub"] = "so_zodiac2_hqr_riggedsub";
  level._id_11BB["so_zodiac2_hqr_nearingreactor"] = "so_zodiac2_hqr_nearingreactor";
  level._id_11BB["so_zodiac2_hqr_raditionlevels"] = "so_zodiac2_hqr_raditionlevels";
  level._id_11BB["so_zodiac2_hqr_rendezvous"] = "so_zodiac2_hqr_rendezvous";
  level._id_11BB["so_zodiac2_hqr_areaishot"] = "so_zodiac2_hqr_areaishot";
  level._id_11BB["so_zodiac2_hqr_readywhen"] = "so_zodiac2_hqr_readywhen";
  level._id_11BB["so_zodiac2_hqr_onisr"] = "so_zodiac2_hqr_onisr";
}

_id_4CB1() {
  foreach(var_1 in level.players) {
    var_1._id_16C0 = 0;
    var_1._id_16C1 = 1;
  }

  thread _id_4CB4();
}

_id_4CB2() {
  var_0 = getent("smoke_kills_vol", "targetname");
  self waittill("death", var_1, var_2, var_3);

  if(isPlayer(var_1) && var_0 istouching(self)) {
    var_1._id_16C0++;
    var_1 notify("bonus1_count", var_1._id_16C0);
  }
}

_id_4CB3(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_1)) {
    return 0;
  }
  if(var_0 == "MOD_MELEE") {
    return 1;
  } else {
    return 0;
  }
}

_id_4CB4() {
  common_scripts\utility::array_thread(level.players, ::_id_4CB5);
  common_scripts\utility::array_thread(level.players, ::_id_02B1);
  wait 300;

  foreach(var_1 in level.players) {}
  var_1._id_16C1 = 0;
}

_id_4CB5() {
  self waittill("death");

  foreach(var_1 in level.players) {}
  var_1._id_16C1 = 0;
}

_id_02B1() {
  level waittill("friendlyfire_mission_fail");

  foreach(var_1 in level.players) {}
  var_1._id_16C1 = 0;
}

_id_4CB6() {
  level endon("so_zodiac2_ny_harbor_complete");
  common_scripts\utility::flag_set("special_op_no_unlink");
  level waittill("missionfailed");

  if(!isDefined(level._id_4483)) {
    return;
  }
  level._id_4483 vehicle_setspeedimmediate(0, 60, 60);

  foreach(var_1 in level.players) {}
  var_1 takeallweapons();
}