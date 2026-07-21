/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\green_beam.gsc
***********************************************/

laser_init_simple(var_0, var_1) {
  laser_init((0, 0, 0), 0, var_0, var_1, 1);
}

laser_init(var_0, var_1, var_2, var_3, var_4) {
  level endon("green_beam_disable");

  if(!isDefined(var_4))
    var_4 = 0;

  level.player.beam_in_hand = 0;
  scripts\engine\utility::flag_init("allow_green_beam");
  scripts\engine\utility::flag_init("laser_marker_on");
  scripts\engine\utility::flag_init("laser_marker_off");
  scripts\engine\utility::flag_init("laser_armed");
  scripts\engine\utility::flag_init("hellfire_launched");
  scripts\engine\utility::flag_init("simple_mode");
  scripts\engine\utility::flag_init("no_beam_nag");
  scripts\engine\utility::flag_init("beam_down");
  scripts\engine\utility::flag_init("beam_ammo_out");
  scripts\engine\utility::flag_init("custom_cooldown");
  precacheshader("hud_icon_equipment_green_laser");

  if(var_4) {
    scripts\engine\utility::flag_set("simple_mode");
    level.green_beam_does_vo = 0;
  } else {
    level._effect["vfx_explo_hydra"] = loadfx("vfx/iw8/weap/_explo/rocket_hydra/vfx_explo_hydra.vfx");

    if(!isDefined(var_0))
      var_0 = (0, 0, 0);

    level.drone = spawnStruct();
    level.drone.origin = var_0;
    level.drone.angles = (0, 0, 0);
    level.drone.allow_audio_hints = 0;
    level.hellfire_count = var_1;
    level.hellfire_max = var_1;
    level.drone.fx_explode = "vfx_explo_hydra";
    level.drone.killcount = 0;
    level.green_beam_does_vo = 0;
    thread drone_ammo_watcher();
  }

  level.instructions_flag = var_2;
  scripts\engine\sp\utility::add_hint_string("drone_reloading", &"EQUIPMENT/DRONE_RELOADING", ::rocket_hint_shutdown);
  scripts\engine\sp\utility::add_hint_string("green_beam_equip", &"EQUIPMENT/GREENBEAM_EQUIP", ::green_beam_equip_hint_check);
  scripts\engine\sp\utility::add_hint_string("green_beam_fire", &"EQUIPMENT/GREENBEAM_FIRE", ::green_beam_target_hint_check);
  scripts\engine\sp\utility::add_hint_string("green_beam_notarget", &"EQUIPMENT/NOTARGET");
  scripts\engine\sp\utility::add_hint_string("green_beam_allyclose", &"EQUIPMENT/ALLYCLOSE");
  childthread player_green_beam(var_2, var_3);
  setdvarifuninitialized("scr_debug_greenbeam", 0);
  setdvarifuninitialized("scr_debug_greenbeam_paths", 0);
}

player_green_beam(var_0, var_1) {
  scripts\engine\utility::flag_wait("allow_green_beam");

  if(!isDefined(level.green_beam_icon))
    level.green_beam_icon = "hud_icon_equipment_green_laser";

  level.player childthread scripts\engine\sp\utility::actionslotoverride(1, level.green_beam_icon, undefined, ::give_green_beam);
  childthread laser_player_instructions(var_0, var_1);
}

laser_player_instructions(var_0, var_1) {
  if(isDefined(var_1))
    level endon(var_1);

  for(;;) {
    scripts\engine\utility::flag_wait("allow_green_beam");

    if(isDefined(var_0))
      scripts\engine\utility::flag_wait(var_0);

    if(!scripts\engine\utility::flag("laser_marker_on")) {
      if(isDefined(level.last_beam_time))
        scripts\engine\utility::delaythread(5, scripts\engine\utility::flag_clear, var_0);

      level notify("instruct_equip_green_beam");
      scripts\engine\sp\utility::display_hint_forced("green_beam_equip");
      scripts\engine\utility::flag_wait("laser_marker_on");
      scripts\engine\utility::flag_clear("laser_marker_off");
    }

    if(isDefined(level.last_beam_time)) {
      scripts\engine\utility::flag_clear(var_0);
      continue;
    }

    wait 1;
    level notify("instruct_use_green_beam");
    scripts\engine\sp\utility::display_hint_forced("green_beam_fire");
    scripts\engine\utility::flag_wait_any("hellfire_launched", "laser_marker_off");

    if(scripts\engine\utility::flag("laser_marker_off")) {
      continue;
    }
    scripts\engine\utility::flag_waitopen("hellfire_launched");
    scripts\engine\utility::flag_clear(var_0);
  }
}

give_green_beam() {
  var_0 = beam_weapon_check();
  var_1 = self.currentweapon;

  if(!scripts\engine\utility::is_equal(var_1.basename, var_0)) {
    level.previous_weapon = var_1;
    var_2 = getcompleteweaponname(var_0);
    self giveweapon(var_2);
    self switchtoweapon(var_2);
    level.player.beam_in_hand = 1;
    scripts\engine\utility::flag_set("laser_marker_on");
    scripts\engine\utility::flag_clear("laser_marker_off");
    waitframe();
    thread laser_targeting();
    thread check_weapon_switch();
    thread demeanor_switch();
  } else if(level.player.currentweapon.basename == beam_weapon_check()) {
    level notify("stop_green_beam_weapon_check");
    take_green_beam(0);
  }
}

check_weapon_switch() {
  level endon("stop_green_beam_weapon_check");
  self waittill("weapon_change");

  if(scripts\engine\utility::is_equal(self.currentweapon.basename, beam_weapon_check()))
    self waittill("weapon_change");

  take_green_beam(0);
}

demeanor_switch() {
  self waittill("weapon_switch_pressed");
  level.player.beam_in_hand = 0;
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
}

take_green_beam(var_0) {
  level notify("green_beam_down");
  scripts\engine\utility::flag_clear("laser_marker_on");
  scripts\engine\utility::flag_set("laser_marker_off");
  level.player disableslowaim();
  level.player laserforceoff();
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  var_1 = 0;

  while(var_1 < 3 && level.player.currentweapon.basename == beam_weapon_check()) {
    if(isDefined(level.previous_weapon))
      level.player switchtoweapon(level.previous_weapon);
    else if(isDefined(level.player.primaryweapons[0]))
      level.player switchtoweapon(level.player.primaryweapons[0]);
    else if(isDefined(self.primaryweapons[1]))
      level.player switchtoweapon(level.player.primaryweapons[1]);

    level.previous_weapon = undefined;
    var_1++;
    wait 1;
  }

  if(!isDefined(var_0) || var_0)
    disable_green_beam();
}

disable_green_beam() {
  level notify("green_beam_disable");
  level notify("stop_drone_regen");
  level notify("green_beam_down");
  scripts\engine\utility::flag_clear("allow_green_beam");
  scripts\engine\utility::flag_set("beam_down");
  level.player disableslowaim();
  level.player laserforceoff();
  level.instructions_flag = undefined;
  level.last_beam_time = undefined;
  level.hellfire_count = undefined;
  thread remove_action_slot_after_put_away();
}

remove_action_slot_after_put_away() {
  scripts\engine\utility::flag_waitopen("laser_marker_on");
  level.player scripts\engine\sp\utility::actionslotoverrideremove(1);
}

beam_weapon_check() {
  if(!isDefined(level.green_beam_weapon))
    level.green_beam_weapon = "iw8_green_beam";

  return level.green_beam_weapon;
}

rocket_hint_shutdown() {
  return istrue(level.hellfire_count);
}

laser_targeting() {
  level.player enableslowaim(0.5, 0.5);

  if(scripts\engine\utility::flag("simple_mode"))
    thread target_highlight_attempt();
  else {
    thread hellfire_launch_attempt();
    thread drone_gone_watcher();
  }
}

target_highlight_attempt() {
  level.player endon("laser_marker_on");
  level.player endon("laser_marker_off");
  level endon("green_beam_down");
  level.player.greenbeamerror = "";
  wait 1;

  for(;;) {
    level.player waittill("attack_pressed");

    if(!isDefined(level.allies))
      level.allies = [];

    var_0 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0, 1);
    var_1 = scripts\engine\utility::array_add(level.allies, level.player);
    var_2 = scripts\engine\trace::ray_trace_detail(level.player getEye(), level.player getEye() + anglesToForward(level.player getplayerangles()) * 9999, var_1, var_0, 1);

    if(check_target_is_valid(var_2)) {
      thread check_target_in_hit_zone(var_2);
      continue;
    }

    level notify("green_beam_error", var_2["position"]);
    scripts\engine\utility::flag_waitopen("laser_armed");
    waitframe();
  }
}

check_target_in_hit_zone(var_0) {
  scripts\engine\utility::flag_set("laser_armed");
  level notify("check_green_beam_target", var_0["position"]);
  var_1 = level scripts\engine\utility::waittill_any_return("green_beam_good", "green_beam_fail");

  if(var_1 == "green_beam_good") {
    var_2 = var_0["position"];
    level notify("green_beam_target_confirmed");
    level.last_beam_time = gettime();

    if(istrue(level.green_beam_does_vo))
      level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_ukp1_defend_helo_30");

    scripts\engine\utility::flag_set("hellfire_launched");
    wait 1.25;
    scripts\engine\utility::flag_clear("hellfire_launched");
  }

  scripts\engine\utility::flag_clear("laser_armed");
}

hellfire_launch_attempt() {
  level.player endon("laser_marker_on");
  level.player endon("laser_marker_off");
  level endon("allow_green_beam");
  level endon("green_beam_down");
  level.player.greenbeamerror = "";
  wait 0.7;

  for(;;) {
    scripts\engine\utility::flag_waitopen("hellfire_launched");

    if(!isDefined(level.hellfire_count) || level.hellfire_count > 0)
      self laserforceon();

    level.player waittill("attack_pressed");

    if(level.hellfire_count < 1) {
      wait 0.1;
      continue;
    }

    self laserforceoff();

    if(!isDefined(level.allies))
      level.allies = [];

    var_0 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0, 1);
    var_1 = scripts\engine\utility::array_add(level.allies, level.player);
    var_2 = anglesToForward(level.player getplayerangles());
    var_3 = level.player getEye();
    var_4 = var_3 + var_2 * 9001;
    var_5 = scripts\engine\trace::ray_trace_detail(var_3, var_4, var_1, var_0, 1);

    if(check_target_is_valid(var_5)) {
      if(istrue(level.drone_updater))
        level.drone.origin = drone_origin_updater(var_5["position"]);

      thread fire_drone_rocket(var_5);
      level.player playSound("laze_targetting");
      continue;
    }

    level notify("green_beam_error");
    var_6 = gettime();

    if(!isDefined(level.player.beam_fail_cooldown) || level.player.beam_fail_cooldown <= var_6) {
      level.player playSound("laze_denial");
      level.player.beam_fail_cooldown = var_6 + 2000;
    }

    scripts\engine\utility::flag_waitopen("laser_armed");
    waitframe();
  }
}

drone_fail_audio() {
  level.player scripts\engine\sp\utility::play_sound_on_entity("laze_targetting");
  level.player thread scripts\engine\sp\utility::play_sound_on_entity("laze_targetting");
}

drone_origin_updater(var_0) {
  var_1 = level.player.origin + (0, 0, 500);
  var_1 = var_1 + anglesToForward(level.player.angles) * -1500;
  var_1 = var_1 + anglestoleft(level.player.angles) * 1500;
  var_2 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0, 1);
  var_3 = 0;

  while(var_3 < 12) {
    var_4 = scripts\engine\trace::sphere_trace(var_1, var_0, 30, level.allies, var_2);
    var_6 = !isDefined(physics_querypoint(var_1, 30, var_2, level.allies, "physicsquery_closest"));

    if(!var_6 && distance2dsquared(var_4["position"], var_0) < 10000)
      return var_1;

    var_1 = var_1 + anglestoright(level.player.angles) * 1000;
    var_3++;

    if(var_3 % 4 == 0) {
      var_1 = var_1 + (0, 0, 1000);
      var_1 = var_1 + anglestoleft(level.player.angles) * 4000;
    }
  }
}

fire_drone_rocket(var_0) {
  scripts\engine\utility::flag_set("laser_armed");
  var_1 = var_0["position"];

  if(isDefined(level.drone_rocket_delay_msg))
    level waittill(level.drone_rocket_delay_msg);

  level notify("green_beam_target_confirmed");
  level.last_beam_time = gettime();

  if(istrue(level.green_beam_does_vo))
    level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_ukp1_defend_helo_30");

  wait 0.5;
  take_beam_ammo(1);
  level.drone fire_drone_rocket_internal(var_1, var_0["entity"]);
  scripts\engine\utility::flag_clear("laser_armed");
}

fire_drone_rocket_internal(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(self.origin)) {
    self.origin = level.player.origin + (0, 0, 1500);
    self.origin = self.origin + anglesToForward(level.player.angles) * -1000;
  }

  var_3 = self.origin;
  var_4 = magicbullet("iw8_projectile_hfoxtrot", var_3, var_0, level.player);

  if(level.script == "lab")
    thread rocket_ff_check(var_0);

  self notify("missile_fired", var_4);

  if(isDefined(level.rocket_func))
    var_4 thread[[level.rocket_func]](var_0);

  thread hellfire_rocket_launch_sfx(var_4, var_0);

  if(isDefined(var_1) && var_1 scripts\common\vehicle::ishelicopter() && var_1 vehicle_getspeed() < 15 && !isDefined(var_1.no_gb_lockon)) {
    var_4.locked_target = var_1;
    var_4 scripts\engine\utility::missile_settargetandflightmode(var_1, "top", (0, 0, -60));

    if(level.script == "lab") {
      var_2 = level.drone.fx_explode;
      level.drone.fx_explode = level.helidronefx;
    }
  }

  var_4 thread track_hellfire_kills();
  scripts\engine\utility::flag_set("hellfire_launched");
  var_4 scripts\engine\utility::waittill_any_timeout(3, "explode");
  scripts\engine\utility::flag_clear("hellfire_launched");
  level notify("hellfire_impact", var_4.origin, var_1);
  var_5 = var_4.origin;

  if(isDefined(var_5)) {
    if(level.script == "embassy" && scripts\engine\sp\utility::getvehiclearray_in_radius(var_5, 650, "axis").size != 0)
      radiusdamage(var_5 + (0, 0, 100), 500, 30000, 20000, level.player, "MOD_EXPLOSIVE", getcompleteweaponname("iw8_projectile_hfoxtrot"));

    earthquake(0.5, 1.5, var_5, 4000);
    playrumbleonposition("damage_heavy", level.player.origin);
    var_6 = vectorNormalize(level.player.origin - var_5);

    if(level.script == "lab") {
      if(isDefined(level.hilltop_heli)) {
        if(distancesquared(var_5, level.hilltop_heli.origin) > 10000) {
          playFX(scripts\engine\utility::getfx(level.drone.fx_explode), var_5, var_6);

          if(scripts\engine\sp\utility::getvehiclearray_in_radius(var_5, 650, "allies").size == 0)
            radiusdamage(var_5 + (0, 0, 100), 500, 2500, 2000, level.player, "MOD_EXPLOSIVE", getcompleteweaponname("iw8_projectile_hfoxtrot"));
        }
      } else {
        playFX(scripts\engine\utility::getfx(level.drone.fx_explode), var_5, var_6);

        if(scripts\engine\sp\utility::getvehiclearray_in_radius(var_5, 650, "allies").size == 0)
          radiusdamage(var_5 + (0, 0, 100), 500, 2500, 2000, level.player, "MOD_EXPLOSIVE", getcompleteweaponname("iw8_projectile_hfoxtrot"));
      }

      if(isDefined(var_2)) {
        level.drone.fx_explode = var_2;
        var_2 = undefined;
      }
    } else
      playFX(scripts\engine\utility::getfx(level.drone.fx_explode), var_5, var_6);
  }
}

hellfire_rocket_launch_sfx(var_0, var_1) {
  var_2 = 0.0;
  var_3 = distance(var_1, var_0.origin);

  if(var_3 > 3000)
    var_2 = (var_3 - 2500) / 5000;

  var_4 = spawn("script_origin", var_0.origin);
  var_4 linkTo(var_0);
  wait(var_2);
  var_4 playSound("weap_hellfire_incoming");
  level waittill("hellfire_impact");
  var_4 stopsounds();
  wait 0.1;
  var_4 delete();
}

rocket_ff_check(var_0) {
  var_1 = getaiarrayinradius(var_0, 500, "allies").size;
  var_2 = getaiarrayinradius(var_0, 500, "axis").size;
  level waittill("hellfire_impact");

  if(var_1 > 0) {
    level.player.participation = level.player.participation + (level.friendlyfire["friend_kill_points"] * var_1 - level.friendlyfire["friend_kill_points"] * var_2);
    scripts\sp\friendlyfire::friendly_fire_checkpoints(0);
  }
}

track_hellfire_kills(var_0) {
  var_1 = spawnStruct();
  var_1.killcount = 0;
  var_1.vehiclekills = 0;
  var_1.towerkills = 0;
  var_1.helokills = 0;
  var_1 thread get_hellfire_killcount();
  scripts\engine\utility::waittill_any_timeout(3, "explode");
  waitframe();
  level notify("hellfire_killcount", var_1.killcount, var_1.vehiclekills, var_1.towerkills, var_1.helokills);
}

get_hellfire_killcount() {
  level endon("hellfire_killcount");

  foreach(var_1 in vehicle_getarray())
  childthread track_hellfire_vehicle_kills(var_1);

  childthread track_hellfire_tower_kills();

  for(;;) {
    level waittill("ai_killed", var_3, var_4, var_5, var_6);

    if(!isDefined(var_3) || var_3.team != "axis" || !isDefined(var_4) || var_4 != level.player) {
      continue;
    }
    if(!isDefined(var_6) || var_6 == "iw8_projectile_hfoxtrot" || var_6 == "hellfire_rocket")
      self.killcount++;
  }
}

track_hellfire_tower_kills() {
  for(;;) {
    level waittill("guard_tower_destroyed", var_0, var_1, var_2, var_3, var_4);

    if(!isDefined(var_1) || var_1 != level.player || !isDefined(var_4)) {
      continue;
    }
    if(!isDefined(var_4) || var_4 == "iw8_projectile_hfoxtrot" || var_4 == "hellfire_rocket")
      self.towerkills++;
  }
}

track_hellfire_vehicle_kills(var_0) {
  for(;;) {
    var_0 waittill("death", var_1, var_2, var_3);

    if(!isDefined(var_1) || var_1 != level.player || !isDefined(var_0)) {
      continue;
    }
    if(!isDefined(var_3) || var_3.basename == "iw8_projectile_hfoxtrot" || var_3.basename == "hellfire_rocket") {
      if(var_0.classname == "script_vehicle_blima" || var_0.classname == "script_vehicle_iw8_lbravo_carrier_east")
        self.helokills++;

      self.vehiclekills++;
      self.killcount = self.killcount + var_0.riders.size;
    }

    if((!isDefined(var_0.riders) || var_0.riders.size == 0) && var_0.classname == "script_vehicle_iw8_vindia_a1")
      self.killcount++;
  }
}

vo_killcount() {
  if(!soundexists("dx_vom_udp_drone_onekill_01")) {
    return;
  }
  wait 1.3;

  if(!level.drone.killcount) {
    return;
  }
  var_0 = "dx_vom_udp_drone_";
  var_1 = "";
  var_2 = 1;
  var_3 = 2;

  switch (level.drone.killcount) {
    case 1:
      var_1 = "onekill_0";
      var_3 = 3;
      break;
    case 2:
      var_1 = "twokill_0";
      break;
    case 3:
      var_1 = "threekill_0";
      break;
    case 4:
      var_1 = "fourkill_0";
      break;
    case 5:
      var_1 = "fivekill_0";
      break;
    case 6:
      var_1 = "sixkill_0";
      break;
    default:
      var_1 = "groupkill_0";
      break;
  }

  var_4 = var_0 + var_1 + randomintrange(var_2, var_3);

  if(!soundexists(var_4))
    iprintlnbold("Incorrect Drone VO alias: " + var_4);
  else
    level.player scripts\engine\sp\utility::play_sound_on_entity(var_4);
}

check_target_is_valid(var_0) {
  if(scripts\engine\utility::is_equal(var_0["hittype"], "hittype_none")) {
    level.player.greenbeamerror = "hit_none";
    return 0;
  }

  if(distance(level.player.origin, var_0["position"]) < 500) {
    level.player.greenbeamerror = "allies_too_close";
    return 0;
  }

  if(getaiarrayinradius(var_0["position"], 500, "allies").size > 0 && getaiarrayinradius(var_0["position"], 500, "axis").size > 0) {}

  if(scripts\engine\sp\utility::getvehiclearray_in_radius(var_0["position"], 500, "allies").size > 0) {
    level.player.greenbeamerror = "allies_too_close";
    return 0;
  }

  if(scripts\engine\utility::flag("laser_armed")) {
    level.player.greenbeamerror = "not_ready";
    return 0;
  }

  return 1;
}

drone_gone_watcher() {
  level.player endon("laser_marker_on");
  level endon("green_beam_down");
  level endon("allow_green_beam");
  thread green_beam_demeanor();
  var_0 = 0;

  for(;;) {
    level.player waittill("attack_pressed");

    if(level.hellfire_count < 1 && !scripts\engine\utility::flag("no_beam_nag")) {
      level notify("attempted_green_beam_while_reloading");
      scripts\engine\sp\utility::display_hint("drone_reloading", 3);
      var_1 = gettime();

      if(!isDefined(level.player.beam_fail_cooldown) || level.player.beam_fail_cooldown <= var_1) {
        level.player playSound("laze_denial");
        level.player.beam_fail_cooldown = var_1 + 2000;
      }
    }
  }
}

drone_ammo_watcher() {
  level endon("stop_drone_regen");

  if(getDvar("mapname") != "embassy") {
    for(;;) {
      scripts\engine\utility::flag_wait("allow_green_beam");

      if(!scripts\engine\utility::flag("beam_ammo_out")) {
        var_0 = scripts\engine\utility::ter_op(level.gameskill <= 2, 12, 18);
        give_beam_ammo(1, var_0, "beam_ammo_out");
        continue;
      }

      var_0 = scripts\engine\utility::ter_op(level.gameskill <= 2, 15, 25);
      level.player laserforceoff();
      scripts\engine\utility::flag_set("beam_down");
      give_beam_ammo(level.hellfire_max, var_0);
      scripts\engine\utility::flag_clear("beam_down");
      scripts\engine\utility::flag_clear("beam_ammo_out");
      level.player laserforceon();
    }
  } else {
    for(;;) {
      scripts\engine\utility::flag_wait("allow_green_beam");

      if(!scripts\engine\utility::flag("beam_ammo_out")) {
        var_0 = scripts\engine\utility::ter_op(level.gameskill <= 2, 8, 8);
        give_beam_ammo(1, var_0, "beam_ammo_out");
        continue;
      }

      var_0 = scripts\engine\utility::ter_op(level.gameskill <= 2, 8, 8);
      level.player laserforceoff();
      scripts\engine\utility::flag_set("beam_down");
      give_beam_ammo(level.hellfire_max, var_0);
      scripts\engine\utility::flag_clear("beam_down");
      scripts\engine\utility::flag_clear("beam_ammo_out");
      level.player laserforceon();
    }
  }
}

take_beam_ammo(var_0) {
  level.hellfire_count = level.hellfire_count - var_0;

  if(level.hellfire_count < 0)
    level.hellfire_count = 0;
  else if(level.hellfire_count > level.hellfire_max)
    level.hellfire_count = level.hellfire_max;

  if(level.hellfire_count == 0)
    scripts\engine\utility::flag_set("beam_ammo_out");
}

give_beam_ammo(var_0, var_1, var_2) {
  if(isDefined(var_2))
    level endon(var_2);

  if(isDefined(var_1))
    wait(var_1);

  level.hellfire_count = level.hellfire_count + var_0;

  if(level.hellfire_count < 0)
    level.hellfire_count = 0;
  else if(level.hellfire_count > level.hellfire_max)
    level.hellfire_count = level.hellfire_max;
}

green_beam_demeanor() {
  for(;;) {
    waitframe();
    var_0 = scripts\engine\sp\utility::get_player_demeanor();

    if(scripts\engine\utility::flag("beam_down") && level.player.currentweapon.basename == beam_weapon_check()) {
      if(!scripts\engine\utility::is_equal(var_0, "relaxed") && level.player.beam_in_hand) {
        wait 0.75;
        level.player scripts\engine\sp\utility::set_player_demeanor("green_beam");

        while(scripts\engine\utility::flag("beam_down") && level.player.beam_in_hand)
          waitframe();
      }

      continue;
    } else if(!scripts\engine\utility::is_equal(var_0, "normal"))
      level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  }
}

set_green_beam_demeanor(var_0) {
  while(level.player isswitchingweapon())
    waitframe();

  level.player scripts\engine\sp\utility::set_player_demeanor(var_0);
}

target_designation_nag() {
  level endon("wave_5_end");

  while(scripts\engine\utility::flag("allow_green_beam")) {
    wait 10;

    if(!scripts\engine\utility::flag("hellfire_launched") && scripts\engine\utility::flag("allow_green_beam"))
      level thread scripts\engine\utility::add_dialogue_line("PILOT", "Designate a target.", "green");
  }
}

green_beam_equip_hint_check() {
  if(isDefined(level.instructions_flag) && !scripts\engine\utility::flag(level.instructions_flag))
    return 1;

  if(!scripts\engine\utility::flag("allow_green_beam"))
    return 1;

  return scripts\engine\utility::flag("laser_marker_on");
}

green_beam_target_hint_check() {
  if(!scripts\engine\utility::flag("allow_green_beam"))
    return 1;

  return scripts\engine\utility::flag("hellfire_launched") || scripts\engine\utility::flag("laser_marker_off");
}