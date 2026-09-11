/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\green_beam.gsc
***********************************************/

function laser_init_simple(var0, var1) {
  laser_init((0, 0, 0), 0, var0, var1, 1);
}

function laser_init(var0, var1, var2, var3, var4) {
  level endon("green_beam_disable");

  if(!isDefined(var4)) {
    var4 = 0;
  }

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

  if(var4) {
    scripts\engine\utility::flag_set("simple_mode");
    level.green_beam_does_vo = 0;
  } else {
    level._effect["vfx_explo_hydra"] = loadfx("vfx/iw8/weap/_explo/rocket_hydra/vfx_explo_hydra.vfx");

    if(!isDefined(var0)) {
      var0 = (0, 0, 0);
    }

    level.drone = spawnStruct();
    level.drone.origin = var0;
    level.drone.angles = (0, 0, 0);
    level.drone.allow_audio_hints = 0;
    level.hellfire_count = var1;
    level.hellfire_max = var1;
    level.drone.fx_explode = "vfx_explo_hydra";
    level.drone.killcount = 0;
    level.green_beam_does_vo = 0;
    thread drone_ammo_watcher();
  }

  level.instructions_flag = var2;
  scripts\engine\sp\utility::add_hint_string("drone_reloading", &"EQUIPMENT/DRONE_RELOADING", &rocket_hint_shutdown);
  scripts\engine\sp\utility::add_hint_string("green_beam_equip", &"EQUIPMENT/GREENBEAM_EQUIP", &green_beam_equip_hint_check);
  scripts\engine\sp\utility::add_hint_string("green_beam_fire", &"EQUIPMENT/GREENBEAM_FIRE", &green_beam_target_hint_check);
  scripts\engine\sp\utility::add_hint_string("green_beam_notarget", &"EQUIPMENT/NOTARGET");
  scripts\engine\sp\utility::add_hint_string("green_beam_allyclose", &"EQUIPMENT/ALLYCLOSE");
  GscBinSkip4(0x35, var2, var3);
}

function player_green_beam(var0, var1) {
  scripts\engine\utility::flag_wait("allow_green_beam");

  if(!isDefined(level.green_beam_icon)) {
    level.green_beam_icon = "hud_icon_equipment_green_laser";
  }

  level.player childthread scripts\engine\sp\utility::actionslotoverride(1, level.green_beam_icon, undefined, &give_green_beam);
  GscBinSkip4(0x35, var0, var1);
}

function laser_player_instructions(var0, var1) {
  if(isDefined(var1)) {
    level endon(var1);
  }

  for(;;) {
    scripts\engine\utility::flag_wait("allow_green_beam");

    if(isDefined(var0)) {
      scripts\engine\utility::flag_wait(var0);
    }

    if(!scripts\engine\utility::flag("laser_marker_on")) {
      if(isDefined(level.last_beam_time)) {
        scripts\engine\utility::delaythread(5, &scripts\engine\utility::flag_clear, var0);
      }

      level notify("instruct_equip_green_beam");
      scripts\engine\sp\utility::display_hint_forced("green_beam_equip");
      scripts\engine\utility::flag_wait("laser_marker_on");
      scripts\engine\utility::flag_clear("laser_marker_off");
    }

    if(isDefined(level.last_beam_time)) {
      scripts\engine\utility::flag_clear(var0);
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
    scripts\engine\utility::flag_clear(var0);
  }
}

function give_green_beam() {
  var0 = beam_weapon_check();
  var1 = self.currentweapon;

  if(!scripts\engine\utility::is_equal(var1.basename, var0)) {
    level.previous_weapon = var1;
    var2 = getcompleteweaponname(var0);
    self giveweapon(var2);
    self switchtoweapon(var2);
    level.player.beam_in_hand = 1;
    scripts\engine\utility::flag_set("laser_marker_on");
    scripts\engine\utility::flag_clear("laser_marker_off");
    waitframe();
    thread laser_targeting();
    thread check_weapon_switch();
    thread demeanor_switch();
    return;
  }

  if(level.player.currentweapon.basename == beam_weapon_check()) {
    level notify("stop_green_beam_weapon_check");
    take_green_beam(0);
    return;
  }
}

function check_weapon_switch() {
  level endon("stop_green_beam_weapon_check");
  self waittill("weapon_change");

  if(scripts\engine\utility::is_equal(self.currentweapon.basename, beam_weapon_check())) {
    self waittill("weapon_change");
  }

  take_green_beam(0);
}

function demeanor_switch() {
  self waittill("weapon_switch_pressed");
  level.player.beam_in_hand = 0;
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
}

function take_green_beam(var0) {
  level notify("green_beam_down");
  scripts\engine\utility::flag_clear("laser_marker_on");
  scripts\engine\utility::flag_set("laser_marker_off");
  level.player disableslowaim();
  level.player laserforceoff();
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  var1 = 0;

  while(var1 < 3 && level.player.currentweapon.basename == beam_weapon_check()) {
    if(isDefined(level.previous_weapon)) {
      level.player switchtoweapon(level.previous_weapon);
    } else if(isDefined(level.player.primaryweapons[0])) {
      level.player switchtoweapon(level.player.primaryweapons[0]);
    } else if(isDefined(self.primaryweapons[1])) {
      level.player switchtoweapon(level.player.primaryweapons[1]);
    }

    level.previous_weapon = undefined;
    var1++;
    wait 1;
  }

  if(!isDefined(var0) || var0) {
    disable_green_beam();
    return;
  }
}

function disable_green_beam() {
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

function remove_action_slot_after_put_away() {
  scripts\engine\utility::flag_waitopen("laser_marker_on");
  level.player scripts\engine\sp\utility::actionslotoverrideremove(1);
}

function beam_weapon_check() {
  if(!isDefined(level.green_beam_weapon)) {
    level.green_beam_weapon = "iw8_green_beam";
  }

  return level.green_beam_weapon;
}

function rocket_hint_shutdown() {
  return istrue(level.hellfire_count);
}

function laser_targeting() {
  level.player enableslowaim(0.5, 0.5);

  if(scripts\engine\utility::flag("simple_mode")) {
    thread target_highlight_attempt();
    return;
  }

  thread hellfire_launch_attempt();
  thread drone_gone_watcher();
}

function target_highlight_attempt() {
  level.player endon("laser_marker_on");
  level.player endon("laser_marker_off");
  level endon("green_beam_down");
  level.player.greenbeamerror = "";
  wait 1;

  for(;;) {
    level.player waittill("attack_pressed");

    if(!isDefined(level.allies)) {
      level.allies = [];
    }

    var0 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0, 1);
    var1 = scripts\engine\utility::array_add(level.allies, level.player);
    var2 = scripts\engine\trace::ray_trace_detail(level.player getEye(), level.player getEye() + anglesToForward(level.player getplayerangles()) * 9999, var1, var0, 1);

    if(check_target_is_valid(var2)) {
      thread check_target_in_hit_zone(var2);
      continue;
    }

    level notify("green_beam_error", var2["position"]);
    scripts\engine\utility::flag_waitopen("laser_armed");
    waitframe();
  }
}

function check_target_in_hit_zone(var0) {
  scripts\engine\utility::flag_set("laser_armed");
  level notify("check_green_beam_target", var0["position"]);
  var1 = level scripts\engine\utility::waittill_any_return("green_beam_good", "green_beam_fail");

  if(var1 == "green_beam_good") {
    var2 = var0["position"];
    level notify("green_beam_target_confirmed");
    level.last_beam_time = gettime();

    if(istrue(level.green_beam_does_vo)) {
      level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_ukp1_defend_helo_30");
    }

    scripts\engine\utility::flag_set("hellfire_launched");
    wait 1.25;
    scripts\engine\utility::flag_clear("hellfire_launched");
  }

  scripts\engine\utility::flag_clear("laser_armed");
}

function hellfire_launch_attempt() {
  level.player endon("laser_marker_on");
  level.player endon("laser_marker_off");
  level endon("allow_green_beam");
  level endon("green_beam_down");
  level.player.greenbeamerror = "";
  wait 0.7;

  for(;;) {
    scripts\engine\utility::flag_waitopen("hellfire_launched");

    if(!isDefined(level.hellfire_count) || level.hellfire_count > 0) {
      self laserforceon();
    }

    level.player waittill("attack_pressed");

    if(level.hellfire_count < 1) {
      wait 0.1;
      continue;
    }

    self laserforceoff();

    if(!isDefined(level.allies)) {
      level.allies = [];
    }

    var0 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0, 1);
    var1 = scripts\engine\utility::array_add(level.allies, level.player);
    var2 = anglesToForward(level.player getplayerangles());
    var3 = level.player getEye();
    var4 = var3 + var2 * 9001;
    var5 = scripts\engine\trace::ray_trace_detail(var3, var4, var1, var0, 1);

    if(check_target_is_valid(var5)) {
      if(istrue(level.drone_updater)) {
        level.drone.origin = drone_origin_updater(var5["position"]);
      }

      thread fire_drone_rocket(var5);
      level.player playSound("laze_targetting");
      continue;
    }

    level notify("green_beam_error");
    var6 = gettime();

    if(!isDefined(level.player.beam_fail_cooldown) || level.player.beam_fail_cooldown <= var6) {
      level.player playSound("laze_denial");
      level.player.beam_fail_cooldown = var6 + 2000;
    }

    scripts\engine\utility::flag_waitopen("laser_armed");
    waitframe();
  }
}

function drone_fail_audio() {
  level.player scripts\engine\sp\utility::play_sound_on_entity("laze_targetting");
  level.player thread scripts\engine\sp\utility::play_sound_on_entity("laze_targetting");
}

function drone_origin_updater(var0) {
  var1 = level.player.origin + (0, 0, 500);
  var1 += anglesToForward(level.player.angles) * -1500;
  var1 += anglestoleft(level.player.angles) * 1500;
  var2 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0, 1);
  var3 = 0;

  while(var3 < 12) {
    var4 = scripts\engine\trace::sphere_trace(var1, var0, 30, level.allies, var2);
    var6 = !isDefined(physics_querypoint(var1, 30, var2, level.allies, "physicsquery_closest"));

    if(!var6 && distance2dsquared(var4["position"], var0) < 10000) {
      return var1;
    }

    var1 += anglestoright(level.player.angles) * 1000;
    var3++;

    if(var3 % 4 == 0) {
      var1 += (0, 0, 1000);
      var1 += anglestoleft(level.player.angles) * 4000;
    }
  }
}

function fire_drone_rocket(var0) {
  scripts\engine\utility::flag_set("laser_armed");
  var1 = var0["position"];

  if(isDefined(level.drone_rocket_delay_msg)) {
    level waittill(level.drone_rocket_delay_msg);
  }

  level notify("green_beam_target_confirmed");
  level.last_beam_time = gettime();

  if(istrue(level.green_beam_does_vo)) {
    level.player thread scripts\engine\sp\utility::play_sound_on_entity("dx_vom_ukp1_defend_helo_30");
  }

  wait 0.5;
  take_beam_ammo(1);
  fire_drone_rocket_internal(level.drone, var1, var0["entity"]);
  scripts\engine\utility::flag_clear("laser_armed");
}

function fire_drone_rocket_internal(var0, var1) {
  var2 = undefined;

  if(!isDefined(self.origin)) {
    self.origin = level.player.origin + (0, 0, 1500);
    self.origin += anglesToForward(level.player.angles) * -1000;
  }

  var3 = self.origin;
  var4 = magicbullet("iw8_projectile_hfoxtrot", var3, var0, level.player);

  if(level.script == "lab") {
    thread rocket_ff_check(var0);
  }

  self notify("missile_fired", var4);

  if(isDefined(level.rocket_func)) {
    var4 thread[[level.rocket_func]](var0);
  }

  thread hellfire_rocket_launch_sfx(var4, var0);

  if(isDefined(var1) && var1 scripts\common\vehicle::ishelicopter() && var1 vehicle_getspeed() < 15 && !isDefined(var1.no_gb_lockon)) {
    var4.locked_target = var1;
    var4 scripts\engine\utility::missile_settargetandflightmode(var1, "top", (0, 0, -60));

    if(level.script == "lab") {
      var2 = level.drone.fx_explode;
      level.drone.fx_explode = level.helidronefx;
    }
  }

  thread track_hellfire_kills();
  scripts\engine\utility::flag_set("hellfire_launched");
  var4 scripts\engine\utility::waittill_any_timeout(3, "explode");
  scripts\engine\utility::flag_clear("hellfire_launched");
  level notify("hellfire_impact", var4.origin, var1);
  var5 = var4.origin;

  if(isDefined(var5)) {
    if(level.script == "embassy" && scripts\engine\sp\utility::getvehiclearray_in_radius(var5, 650, "axis").size != 0) {
      radiusdamage(var5 + (0, 0, 100), 500, 30000, 20000, level.player, "MOD_EXPLOSIVE", getcompleteweaponname("iw8_projectile_hfoxtrot"));
    }

    earthquake(0.5, 1.5, var5, 4000);
    playrumbleonposition("damage_heavy", level.player.origin);
    var6 = vectorNormalize(level.player.origin - var5);

    if(level.script == "lab") {
      if(isDefined(level.hilltop_heli)) {
        if(distancesquared(var5, level.hilltop_heli.origin) > 10000) {
          playFX(scripts\engine\utility::getfx(level.drone.fx_explode), var5, var6);

          if(scripts\engine\sp\utility::getvehiclearray_in_radius(var5, 650, "allies").size == 0) {
            radiusdamage(var5 + (0, 0, 100), 500, 2500, 2000, level.player, "MOD_EXPLOSIVE", getcompleteweaponname("iw8_projectile_hfoxtrot"));
          }
        }
      } else {
        playFX(scripts\engine\utility::getfx(level.drone.fx_explode), var5, var6);

        if(scripts\engine\sp\utility::getvehiclearray_in_radius(var5, 650, "allies").size == 0) {
          radiusdamage(var5 + (0, 0, 100), 500, 2500, 2000, level.player, "MOD_EXPLOSIVE", getcompleteweaponname("iw8_projectile_hfoxtrot"));
        }
      }

      if(isDefined(var2)) {
        level.drone.fx_explode = var2;
        var2 = undefined;
        return;
      }

      return;
    }

    playFX(scripts\engine\utility::getfx(level.drone.fx_explode), var5, var6);
    return;
  }
}

function hellfire_rocket_launch_sfx(var0, var1) {
  var2 = 0;
  var3 = distance(var1, var0.origin);

  if(var3 > 3000) {
    var2 = (var3 - 2500) / 5000;
  }

  var4 = spawn("script_origin", var0.origin);
  var4 linkTo(var0);
  wait var2;
  var4 playSound("weap_hellfire_incoming");
  level waittill("hellfire_impact");
  var4 stopsounds();
  wait 0.1;
  var4 delete();
}

function rocket_ff_check(var0) {
  var1 = getaiarrayinradius(var0, 500, "allies").size;
  var2 = getaiarrayinradius(var0, 500, "axis").size;
  level waittill("hellfire_impact");

  if(var1 > 0) {
    level.player.participation += level.friendlyfire["friend_kill_points"] * var1 - level.friendlyfire["friend_kill_points"] * var2;
    scripts\sp\friendlyfire::friendly_fire_checkpoints(0);
    return;
  }
}

function track_hellfire_kills(var0) {
  var1 = spawnStruct();
  var1.killcount = 0;
  var1.vehiclekills = 0;
  var1.towerkills = 0;
  var1.helokills = 0;
  thread get_hellfire_killcount();
  scripts\engine\utility::waittill_any_timeout(3, "explode");
  waitframe();
  level notify("hellfire_killcount", var1.killcount, var1.vehiclekills, var1.towerkills, var1.helokills);
}

function get_hellfire_killcount() {
  level endon("hellfire_killcount");
  var0 = vehicle_getarray();
  var2 = getfirstarraykey(var0);

  if(isDefined(var2)) {
    var1 = var0[var2];
    GscBinSkip4(0x35, var1);
  }

  var0 = undefined;
  var2 = undefined;
  GscBinSkip4(0x35);
}

function track_hellfire_tower_kills() {
  for(;;) {
    level waittill("guard_tower_destroyed", var0, var1, var2, var3, var4);

    if(!isDefined(var1) || var1 != level.player || !isDefined(var4)) {
      continue;
    }

    if(!isDefined(var4) || var4 == "iw8_projectile_hfoxtrot" || var4 == "hellfire_rocket") {
      self.towerkills++;
    }
  }
}

function track_hellfire_vehicle_kills(var0) {
  for(;;) {
    var0 waittill("death", var1, var2, var3);

    if(!isDefined(var1) || var1 != level.player || !isDefined(var0)) {
      continue;
    }

    if(!isDefined(var3) || var3.basename == "iw8_projectile_hfoxtrot" || var3.basename == "hellfire_rocket") {
      if(var0.classname == "script_vehicle_blima" || var0.classname == "script_vehicle_iw8_lbravo_carrier_east") {
        self.helokills++;
      }

      self.vehiclekills++;
      self.killcount += var0.riders.size;
    }

    if((!isDefined(var0.riders) || var0.riders.size == 0) && var0.classname == "script_vehicle_iw8_vindia_a1") {
      self.killcount++;
    }
  }
}

function vo_killcount() {
  if(!soundexists("dx_vom_udp_drone_onekill_01")) {
    return;
  }

  wait 1.3;

  if(!level.drone.killcount) {
    return;
  }

  var0 = "dx_vom_udp_drone_";
  var1 = "";
  var2 = 1;
  var3 = 2;

  switch (level.drone.killcount) {
    case 1:
      var1 = "onekill_0";
      var3 = 3;
      break;
    case 2:
      var1 = "twokill_0";
      break;
    case 3:
      var1 = "threekill_0";
      break;
    case 4:
      var1 = "fourkill_0";
      break;
    case 5:
      var1 = "fivekill_0";
      break;
    case 6:
      var1 = "sixkill_0";
      break;
    default:
      var1 = "groupkill_0";
      break;
  }

  var4 = var0 + var1 + randomintrange(var2, var3);

  if(!soundexists(var4)) {
    iprintlnbold("Incorrect Drone VO alias: " + var4);
    return;
  }

  level.player scripts\engine\sp\utility::play_sound_on_entity(var4);
}

function check_target_is_valid(var0) {
  if(scripts\engine\utility::is_equal(var0["hittype"], "hittype_none")) {
    level.player.greenbeamerror = "hit_none";
    return false;
  }

  if(distance(level.player.origin, var0["position"]) < 500) {
    level.player.greenbeamerror = "allies_too_close";
    return false;
  }

  if(getaiarrayinradius(var0["position"], 500, "allies").size > 0 && getaiarrayinradius(var0["position"], 500, "axis").size > 0) {}

  if(scripts\engine\sp\utility::getvehiclearray_in_radius(var0["position"], 500, "allies").size > 0) {
    level.player.greenbeamerror = "allies_too_close";
    return false;
  }

  if(scripts\engine\utility::flag("laser_armed")) {
    level.player.greenbeamerror = "not_ready";
    return false;
  }

  return true;
}

function drone_gone_watcher() {
  level.player endon("laser_marker_on");
  level endon("green_beam_down");
  level endon("allow_green_beam");
  thread green_beam_demeanor();
  var0 = 0;

  for(;;) {
    level.player waittill("attack_pressed");

    if(level.hellfire_count < 1 && !scripts\engine\utility::flag("no_beam_nag")) {
      level notify("attempted_green_beam_while_reloading");
      scripts\engine\sp\utility::display_hint("drone_reloading", 3);
      var1 = gettime();

      if(!isDefined(level.player.beam_fail_cooldown) || level.player.beam_fail_cooldown <= var1) {
        level.player playSound("laze_denial");
        level.player.beam_fail_cooldown = var1 + 2000;
      }
    }
  }
}

function drone_ammo_watcher() {
  level endon("stop_drone_regen");
  jumpiffalse(getDvar("mapname") != "embassy") LOC_000000ad;

  for(;;) {
    scripts\engine\utility::flag_wait("allow_green_beam");

    if(!scripts\engine\utility::flag("beam_ammo_out")) {
      var0 = scripts\engine\utility::ter_op(level.gameskill <= 2, 12, 18);
      give_beam_ammo(1, var0, "beam_ammo_out");
      continue;
    }

    var0 = scripts\engine\utility::ter_op(level.gameskill <= 2, 15, 25);
    level.player laserforceoff();
    scripts\engine\utility::flag_set("beam_down");
    give_beam_ammo(level.hellfire_max, var0);
    scripts\engine\utility::flag_clear("beam_down");
    scripts\engine\utility::flag_clear("beam_ammo_out");
    level.player laserforceon();
  }

  return;
}

function take_beam_ammo(var0) {
  level.hellfire_count -= var0;

  if(level.hellfire_count < 0) {
    level.hellfire_count = 0;
  } else if(level.hellfire_count > level.hellfire_max) {
    level.hellfire_count = level.hellfire_max;
  }

  if(level.hellfire_count == 0) {
    scripts\engine\utility::flag_set("beam_ammo_out");
    return;
  }
}

function give_beam_ammo(var0, var1, var2) {
  if(isDefined(var2)) {
    level endon(var2);
  }

  if(isDefined(var1)) {
    wait var1;
  }

  level.hellfire_count += var0;

  if(level.hellfire_count < 0) {
    level.hellfire_count = 0;
    return;
  }

  if(level.hellfire_count > level.hellfire_max) {
    level.hellfire_count = level.hellfire_max;
    return;
  }
}

function green_beam_demeanor() {
  for(;;) {
    waitframe();
    var0 = scripts\engine\sp\utility::get_player_demeanor();

    if(scripts\engine\utility::flag("beam_down") && level.player.currentweapon.basename == beam_weapon_check()) {
      if(!scripts\engine\utility::is_equal(var0, "relaxed") && level.player.beam_in_hand) {
        wait 0.75;
        level.player scripts\engine\sp\utility::set_player_demeanor("green_beam");

        while(scripts\engine\utility::flag("beam_down") && level.player.beam_in_hand) {
          waitframe();
        }
      }

      continue;
    }

    if(!scripts\engine\utility::is_equal(var0, "normal")) {
      level.player scripts\engine\sp\utility::set_player_demeanor("normal");
    }
  }
}

function set_green_beam_demeanor(var0) {
  while(level.player isswitchingweapon()) {
    waitframe();
  }

  level.player scripts\engine\sp\utility::set_player_demeanor(var0);
}

function target_designation_nag() {
  level endon("wave_5_end");

  while(scripts\engine\utility::flag("allow_green_beam")) {
    wait 10;

    if(!scripts\engine\utility::flag("hellfire_launched") && scripts\engine\utility::flag("allow_green_beam")) {
      level thread scripts\engine\utility::add_dialogue_line("PILOT", "Designate a target.", "green");
    }
  }
}

function green_beam_equip_hint_check() {
  if(isDefined(level.instructions_flag) && !scripts\engine\utility::flag(level.instructions_flag)) {
    return 1;
  }

  if(!scripts\engine\utility::flag("allow_green_beam")) {
    return 1;
  }

  return scripts\engine\utility::flag("laser_marker_on");
}

function green_beam_target_hint_check() {
  if(!scripts\engine\utility::flag("allow_green_beam")) {
    return true;
  }

  return scripts\engine\utility::flag("hellfire_launched") || scripts\engine\utility::flag("laser_marker_off");
}