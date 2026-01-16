/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_blackstation_utility.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_hazard;
#using scripts\cp\_objectives;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget_firefly;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_battlechatter;
#using scripts\cp\gametypes\coop;
#using scripts\shared\ai_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\colors_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicleriders_shared;
#using_animtree("generic");
#namespace blackstation_utility;

function init_hendricks(str_objective) {
  level.ai_hendricks = util::get_hero("hendricks");
  level.ai_hendricks colors::set_force_color("b");
  level.ai_hendricks setthreatbiasgroup("heroes");
  skipto::teleport_ai(str_objective, level.ai_hendricks);
  level.ai_hendricks setgoal(level.ai_hendricks.origin, 1);
}

function init_kane(str_objective) {
  level.ai_kane = util::get_hero("kane");
  level.ai_kane setthreatbiasgroup("heroes");
  skipto::teleport_ai(str_objective, level.ai_kane);
}

function player_underwater() {
  self notify("hash_1fffa65c");
  self endon("death");
  self endon("hash_1fffa65c");
  while (true) {
    if(self isplayerunderwater() && (!(isdefined(self.is_underwater) && self.is_underwater))) {
      self thread function_41018429();
    }
    wait(0.5);
  }
}

function function_41018429() {
  self notify("hash_8f1abd30");
  self endon("hash_8f1abd30");
  self endon("death");
  self.is_underwater = 1;
  self hazard::function_459e5eff("o2", 0);
  var_dd075cd2 = 1;
  e_volume = getent("subway_water", "targetname");
  if(isdefined(e_volume) && self istouching(e_volume)) {
    self thread function_c6b38f1e();
  }
  while (self isplayerunderwater()) {
    wait(1);
    var_dd075cd2 = self hazard::do_damage("o2", 5);
  }
  self hazard::function_459e5eff("o2", 1);
  self.is_underwater = 0;
}

function function_c6b38f1e() {
  self endon("death");
  self clientfield::set_to_player("subway_water", 1);
  while (self isplayerunderwater()) {
    wait(0.05);
  }
  self clientfield::set_to_player("subway_water", 0);
}

function function_8f7c9f3c() {
  self toggle_player_anchor(0);
}

function player_anchor() {
  self notify("end_anchor");
  self endon("death");
  self endon("end_anchor");
  self.is_anchored = 0;
  self.is_wet = 0;
  while (true) {
    level flag::wait_till("objective_igc_completed");
    if(self util::use_button_held() && (self.is_wind_affected || self.is_surge_affected) && !self.is_anchored) {
      self toggle_player_anchor(1);
      while (util::use_button_held()) {
        wait(0.05);
      }
      while (!self usebuttonpressed() && !self jumpbuttonpressed() && !self sprintbuttonpressed() && self.is_anchored) {
        wait(0.05);
      }
      if(self.is_anchored) {
        self toggle_player_anchor(0);
      }
    }
    wait(0.05);
  }
}

function function_ed7faf05() {
  self notify("end_anchor");
  self toggle_player_anchor(0);
}

function toggle_player_anchor(b_anchor) {
  if(isdefined(self.is_anchored) && self.is_anchored && !b_anchor) {
    if(isdefined(self.e_anchor)) {
      self.e_anchor delete();
    }
    self allowstand(1);
    self allowprone(1);
    self allowsprint(1);
    self setstance("stand");
    if(isdefined(self getluimenu("AnchorDeployed"))) {
      self closeluimenu(self getluimenu("AnchorDeployed"));
    }
    self.is_anchored = 0;
    level notify("enable_cybercom", self, 1);
    self util::hide_hint_text();
    self notify("hash_af6705ff");
  } else if(b_anchor) {
    if(!self iswallrunning() && (!(isdefined(self.laststand) && self.laststand)) && !self isplayerunderwater() && !self ismantling()) {
      level notify("disable_cybercom", self, 1);
      if(!self isonground()) {
        self.e_anchor = spawn("script_origin", self.origin);
        self playerlinkto(self.e_anchor);
        v_ground = groundpos_ignore_water(self.origin);
        n_speed = distance(v_ground, self.origin) * 0.002;
        self.e_anchor moveto(v_ground, n_speed);
        self.e_anchor waittill("movedone");
        self unlink();
        self.e_anchor delete();
      }
      if(!(isdefined(self.is_reviving_any) && self.is_reviving_any)) {
        self thread scene::play("cin_gen_ground_anchor_player", self);
        self waittill("hash_97a4dd11");
      }
      self.is_anchored = 1;
      self allowstand(0);
      self allowprone(0);
      self allowsprint(0);
      self.e_anchor = spawn("script_origin", self.origin);
      if(!isdefined(self getluimenu("AnchorDeployed"))) {
        self openluimenu("AnchorDeployed");
      }
      self thread function_a81e2f8f();
      self thread function_c87bc7e2();
    }
  }
}

function function_c87bc7e2() {
  self endon("death");
  self endon("hash_af6705ff");
  wait(20);
  if(self.is_anchored) {
    self toggle_player_anchor(0);
  }
}

function function_a81e2f8f() {
  self endon("death");
  while (isdefined(self.e_anchor) && (self.is_wind_affected || self.is_surge_affected)) {
    var_3b8c7376 = distance2dsquared(self.origin, self.e_anchor.origin);
    if(var_3b8c7376 > 3600 && var_3b8c7376 < 10000) {
      if(!self.var_62269fcc) {
        self.var_62269fcc = 1;
        self util::show_hint_text(&"CP_MI_SING_BLACKSTATION_ANCHOR_WARNRANGE", 1);
      }
    } else {
      if(var_3b8c7376 > 10000 && var_3b8c7376 <= 22500) {
        if(!self.var_62269fcc) {
          self.var_62269fcc = 1;
          self util::show_hint_text(&"CP_MI_SING_BLACKSTATION_ANCHOR_OUTRANGE", 1);
        }
      } else {
        if(var_3b8c7376 > 22500) {
          if(self.is_anchored) {
            self.var_62269fcc = 0;
            self toggle_player_anchor(0);
          }
        } else {
          self.var_62269fcc = 0;
          self util::hide_hint_text();
        }
      }
    }
    if(!isdefined(self.hint_menu_handle)) {
      self.var_62269fcc = 0;
    }
    util::wait_network_frame();
  }
  if(isdefined(self getluimenu("AnchorDeployed"))) {
    self closeluimenu(self getluimenu("AnchorDeployed"));
  }
  self util::hide_hint_text();
}

function function_12398a8b(a_ents) {
  self endon("death");
  e_anchor = a_ents["spike"];
  self waittill("hash_97a4dd11");
  if(isdefined(e_anchor)) {
    wait(0.1);
    while (isdefined(self.is_anchored) && self.is_anchored) {
      wait(0.1);
    }
    e_anchor delete();
  }
}

function anchor_tutorial() {
  foreach(player in level.activeplayers) {
    player util::show_hint_text(&"CP_MI_SING_BLACKSTATION_USE_ANCHOR_FULL");
  }
  wait(4);
  foreach(player in level.activeplayers) {
    player util::show_hint_text(&"CP_MI_SING_BLACKSTATION_ANCHOR_AREA");
  }
}

function function_72b35612() {
  foreach(player in level.activeplayers) {
    if(!isdefined(player.var_22246212)) {
      player.var_22246212 = 0;
    }
    if(isdefined(player.var_f3d107c2) && player.var_f3d107c2) {
      if(player.var_22246212 < 2) {
        player.var_22246212++;
        player.var_f3d107c2 = 0;
        player util::show_hint_text(&"CP_MI_SING_BLACKSTATION_USE_ANCHOR");
      }
    }
  }
}

function setup_wind_storm() {
  t_intro_storm = getent("anchor_intro_wind", "targetname");
  t_intro_storm trigger::wait_till();
  self thread player_wind_trigger_tracker(t_intro_storm);
  self thread player_wind_sound_tracker(t_intro_storm);
}

function player_wind_trigger_tracker(t_storm) {
  self notify("hash_afb0e5d8");
  self endon("hash_afb0e5d8");
  self endon("disconnect");
  t_storm endon("death");
  self.is_wind_affected = 0;
  while (!level flag::get("breached")) {
    while (self istouching(t_storm)) {
      self.is_wind_affected = 1;
      self allowsprint(0);
      if(!(isdefined(t_storm.is_gusting) && t_storm.is_gusting)) {
        self setmovespeedscale(0.7);
        if(self.is_anchored) {
          self playrumbleonentity("bs_wind_rumble_low");
        } else {
          self playrumbleonentity("bs_wind_rumble");
        }
      } else {
        self setmovespeedscale(0.5);
      }
      wait(0.05);
    }
    self allowsprint(1);
    self setmovespeedscale(1);
    self.is_wind_affected = 0;
    wait(0.05);
  }
}

function player_wind_sound_tracker(t_storm) {
  self notify("hash_27db3d49");
  self endon("hash_27db3d49");
  self endon("disconnect");
  t_storm endon("death");
  self.currentsndwind = 0;
  while (!level flag::get("breached")) {
    while (self istouching(t_storm)) {
      if(!(isdefined(t_storm.is_high) && t_storm.is_high)) {
        if(self.currentsndwind != 1) {
          self.currentsndwind = 1;
          self clientfield::set_to_player("sndWindSystem", 1);
        }
      } else if(self.currentsndwind != 2) {
        self.currentsndwind = 2;
        self clientfield::set_to_player("sndWindSystem", 2);
      }
      wait(0.05);
    }
    if(self.currentsndwind != 0) {
      self.currentsndwind = 0;
      self clientfield::set_to_player("sndWindSystem", 0);
    }
    wait(0.05);
  }
}

function wind_manager() {
  self endon("death");
  while (true) {
    level flag::wait_till("allow_wind_gust");
    level exploder::exploder("fx_expl_debris_high_winds");
    level thread create_gust(self);
    n_time = randomfloatrange(3, 4);
    foreach(player in level.activeplayers) {
      if(isdefined(player.is_wind_affected) && player.is_wind_affected) {
        if(!isdefined(player.var_ce01d699)) {
          player.var_ce01d699 = 0;
        }
        if(!player.var_ce01d699) {
          player.var_ce01d699 = 1;
          player util::show_hint_text(&"CP_MI_SING_BLACKSTATION_USE_ANCHOR");
        }
        player thread weather_menu("WeatherWarning", "kill_weather");
        player thread function_c86ecb59(n_time);
      }
    }
    wait(n_time);
    level exploder::stop_exploder("fx_expl_debris_high_winds");
    level flag::set("kill_weather");
    self.is_gusting = 0;
    self.is_high = 0;
    level thread function_72b35612();
    foreach(player in level.activeplayers) {
      if(player.is_anchored && (isdefined(player.is_wind_affected) && player.is_wind_affected)) {
        player toggle_player_anchor(0);
      }
    }
    n_timeout = randomfloatrange(5.5, 8.5);
    level flag::wait_till_clear_timeout(n_timeout, "allow_wind_gust");
  }
}

function function_c86ecb59(n_time) {
  self endon("death");
  wait(1);
  self clientfield::set_to_player("wind_blur", 1);
  wait(n_time);
  self clientfield::set_to_player("wind_blur", 0);
}

function create_gust(t_storm) {
  level flag::clear("kill_weather");
  level endon("kill_weather");
  t_storm endon("death");
  s_wind = struct::get(t_storm.target);
  level notify("wind_warning");
  t_storm.is_high = 1;
  util::waittill_notify_or_timeout("end_gust_warning", 1);
  while (true) {
    foreach(player in level.players) {
      if(player istouching(t_storm)) {
        if(!isdefined(player getluimenu("WeatherWarning"))) {
          player thread weather_menu("WeatherWarning", "kill_weather");
        }
        v_dir = anglestoforward((0, s_wind.angles[1], 0));
        n_push_strength = 250;
        t_storm.is_gusting = 1;
        if(!player.b_safezone && (!(isdefined(player.laststand) && player.laststand))) {
          if(!player.is_anchored) {
            player setvelocity(v_dir * n_push_strength);
            player.var_f3d107c2 = 1;
          } else if(isdefined(player.e_anchor)) {
            var_3b8c7376 = distance2dsquared(player.origin, player.e_anchor.origin);
            if(distance2dsquared(player.origin, player.e_anchor.origin) > 10000) {
              player setvelocity(v_dir * n_push_strength);
            }
          }
        }
        if(player.is_anchored) {
          player playrumbleonentity("bs_gust_rumble_low");
          continue;
        }
        player playrumbleonentity("bs_gust_rumble");
      }
    }
    wait(0.05);
  }
}

function debris_at_players() {
  level endon("anchor_intro_done");
  s_debris = struct::get("debris_junk_fling");
  s_move = struct::get("debris_junk_move");
  level thread boat_fly();
  while (true) {
    level waittill("wind_warning");
    wait(1.5);
    foreach(player in level.activeplayers) {
      e_debris = spawn("script_model", s_debris.origin);
      e_debris get_debris_model();
      e_debris setplayercollision(0);
      if(isdefined(player)) {
        player fling_player_debris(e_debris);
      }
    }
  }
}

function boat_fly() {
  trigger::wait_till("trigger_hendricks_anchor_done");
  level thread scene::play("p7_fxanim_cp_blackstation_boatroom_bundle");
  wait(2.5);
  var_c6dce143 = struct::get("objective_port_assault_ai");
  foreach(player in level.activeplayers) {
    if(distance2dsquared(player.origin, var_c6dce143.origin) <= 640000) {
      player playrumbleonentity("cp_blackstation_shelter_rumble");
    }
  }
}

function random_debris() {
  level endon("anchor_intro_done");
  while (true) {
    level waittill("wind_warning");
    level thread setup_random_debris();
  }
}

function setup_random_debris() {
  a_s_starts = struct::get_array("debris_random_start");
  a_e_debris = array("p7_debris_junkyard_scrap_pile_01", "p7_debris_junkyard_scrap_pile_02", "p7_debris_junkyard_scrap_pile_03", "p7_debris_concrete_rubble_lg_03", "p7_debris_metal_scrap_01", "p7_debris_ibeam_dmg", "p7_sin_wall_metal_slats", "p7_toilet_bathroom_open");
  for (i = 0; i < randomintrange(10, 16); i++) {
    e_debris = spawn("script_model", a_s_starts[randomint(a_s_starts.size)].origin);
    e_debris setmodel(a_e_debris[randomint(a_e_debris.size)]);
    if(randomint(2) == 0) {
      e_debris playloopsound("evt_debris_rando_looper");
    } else {
      e_debris playloopsound("evt_debris_metal_looper");
    }
    wait(randomfloatrange(0.1, 0.5));
    e_debris thread fling_random_debris();
  }
}

function debris_embedded_trigger() {
  a_e_debris1 = getentarray("debris_stage_1", "targetname");
  foreach(e_debris1 in a_e_debris1) {
    e_debris1 thread debris_shake();
  }
  trigger::wait_till("trigger_stage_1");
  foreach(e_debris1 in a_e_debris1) {
    e_debris1 thread debris_launch();
    e_debris1 thread debris_rotate();
    e_debris1 thread check_player_hit();
  }
  e_fridge = getent("debris_fridge", "targetname");
  a_e_debris2 = getentarray("debris_stage_2", "targetname");
  arrayinsert(a_e_debris2, e_fridge, 0);
  foreach(e_debris2 in a_e_debris2) {
    e_debris2 thread debris_shake();
  }
  trigger::wait_till("trigger_stage_2");
  level waittill("wind_warning");
  wait(1.7);
  foreach(e_debris2 in a_e_debris2) {
    e_debris2 thread debris_launch();
    e_debris2 thread debris_rotate();
    e_debris2 thread check_player_hit();
  }
  e_tree = getent("debris_tree", "targetname");
  e_tree thread debris_shake();
  trigger::wait_till("trigger_stage_3");
  level waittill("wind_warning");
  wait(1.7);
  e_tree thread debris_launch();
  e_tree thread debris_rotate();
  e_tree thread check_player_hit();
}

function debris_shake() {
  self endon("death");
  self endon("launch");
  while (true) {
    self movey(1, 0.05);
    self rotatepitch(1, 0.05);
    self waittill("movedone");
    self movey(-1, 0.05);
    self rotatepitch(-1, 0.05);
    self waittill("movedone");
  }
}

function debris_launch() {
  self notify("launch");
  self moveto(self.origin + vectorscale((0, 1, 0), 200), 0.5);
  self waittill("movedone");
  self moveto(self.origin + (0, 6000, 1200), 8);
  self waittill("movedone");
  self delete();
}

function fling_random_debris() {
  self movez(240, 0.1);
  self waittill("movedone");
  self thread debris_rotate();
  self thread check_player_hit();
  self moveto(self.origin + (0, 6000, randomintrange(20, 60)), 4);
  self waittill("movedone");
  self delete();
}

function fling_player_debris(e_debris) {
  self endon("disconnect");
  e_debris thread debris_rotate();
  e_debris thread check_player_hit();
  e_debris movez(240, 0.1);
  e_debris waittill("movedone");
  e_debris moveto(self.origin + (randomint(100), 1000, randomintrange(80, 100)), 3);
  e_debris waittill("movedone");
  e_debris delete();
}

function debris_rotate() {
  self endon("death");
  while (true) {
    self rotateroll(-90, 0.3);
    wait(0.25);
  }
}

function get_debris_model() {
  n_rand = randomint(7);
  switch (n_rand) {
    case 0: {
      str_debris = "p7_bucket_plastic_5_gal_blue";
      self playloopsound("evt_debris_rando_looper");
      break;
    }
    case 1: {
      str_debris = "p7_sin_wall_metal_slats";
      self playloopsound("evt_debris_metal_looper");
      break;
    }
    case 2: {
      str_debris = "p7_debris_metal_scrap_01";
      self playloopsound("evt_debris_metal_looper");
      break;
    }
    case 3: {
      str_debris = "p7_water_container_plastic_large_distressed";
      self playloopsound("evt_debris_metal_special_looper");
      break;
    }
    case 4: {
      str_debris = "p7_light_spotlight_generator_02";
      self playloopsound("evt_debris_metal_special_looper");
      break;
    }
    case 5: {
      str_debris = "p7_foliage_treetrunk_fallen_01";
      self playloopsound("evt_debris_tree_looper");
      break;
    }
    case 6: {
      str_debris = "p7_debris_drywall_chunks_corner_01";
      self playloopsound("evt_debris_rando_looper");
      break;
    }
  }
  self setmodel(str_debris);
}

function shake_debris() {
  self endon("death");
  while (true) {
    self movez(3, 0.1);
    wait(0.05);
    self movez(-3, 0.1);
    wait(0.05);
  }
}

function check_player_hit() {
  self endon("death");
  self endon("stop_moving");
  n_hit_dist_sq = 1600;
  while (true) {
    foreach(player in level.players) {
      if(distancesquared(self.origin, player getcentroid()) < n_hit_dist_sq) {
        player dodamage(player.health / 8, self.origin, undefined, undefined, undefined, "MOD_FALLING");
        player shellshock("default", 1.5);
        player playrumbleonentity("artillery_rumble");
        break;
      }
    }
    wait(0.05);
  }
}

function groundpos_ignore_water(origin) {
  return groundtrace(origin, origin + (vectorscale((0, 0, -1), 100000)), 0, undefined, 1)["position"];
}

function weather_menu(str_menu, str_flag, str_notify) {
  self endon("death");
  if(!isdefined(self getluimenu(str_menu))) {
    warning = self openluimenu(str_menu);
    self thread function_c4626d1d();
  }
  if(isdefined(str_notify)) {
    self util::waittill_any_timeout(3, str_notify);
  } else {
    util::waittill_any_ents(level, str_flag, self, "player_bleedout");
  }
  if(isdefined(warning)) {
    self closeluimenu(warning);
    self notify("hash_72181299");
  }
}

function function_c4626d1d() {
  self endon("death");
  self endon("hash_72181299");
  while (true) {
    self playlocalsound("uin_weather_warning");
    wait(0.25);
  }
}

function hendricks_anchor(str_warning, str_flag, str_endon) {
  self thread hendricks_safe_area_tracker();
  while (true) {
    level waittill(str_warning);
    if(level.ai_hendricks istouching(self) && !level.ai_hendricks.is_in_safety_zone) {
      level.ai_hendricks scene::play("cin_gen_ground_anchor_start", level.ai_hendricks);
      level.ai_hendricks thread scene::play("cin_gen_ground_anchor_idle", level.ai_hendricks);
      wait(0.5);
      level flag::wait_till(str_flag);
      level.ai_hendricks scene::play("cin_gen_ground_anchor_end", level.ai_hendricks);
    }
    if(level flag::get(str_endon)) {
      break;
    }
  }
}

function hendricks_safe_area_tracker() {
  level endon("kill_hendricks_anchor");
  t_safe_area = getent(self.targetname + "_hero_safety", "script_noteworthy");
  if(!isdefined(t_safe_area)) {
    return;
  }
  while (true) {
    while (level.ai_hendricks istouching(t_safe_area)) {
      level.ai_hendricks.is_in_safety_zone = 1;
      wait(0.05);
    }
    level.ai_hendricks.is_in_safety_zone = 0;
    wait(0.05);
  }
}

function setup_surge(t_storm) {
  t_storm thread surge_manager();
  t_storm thread hendricks_anchor("surge_warning", "kill_surge", "surge_done");
  t_storm thread function_e7121462();
}

function is_touching_triggers(a_triggers) {
  b_touched = 0;
  foreach(trigger in a_triggers) {
    if(self istouching(trigger)) {
      b_touched = 1;
      continue;
    }
  }
  return b_touched;
}

function surge_manager() {
  self endon("death");
  while (true) {
    level flag::set("surging_inward");
    level thread create_surge(self);
    wait(1.5);
    level flag::wait_till_clear("surging_inward");
    self.is_surging = 0;
    wait(randomfloatrange(5.5, 6.5));
  }
}

function water_manager() {
  level endon("tanker_smash");
  level clientfield::set("water_level", 1);
}

function function_3c57957(t_start, a_e_debris, str_endon) {
  var_e7610d59 = ("p7_fxanim_cp_blackstation_" + t_start.script_string) + "_bundle";
  level scene::add_scene_func(var_e7610d59, & function_8fbe0681, "play", str_endon, a_e_debris, t_start);
  if(isdefined(a_e_debris)) {
    array::thread_all(a_e_debris, & function_c1eab89b, t_start);
  }
  level flag::wait_till("surging_inward");
  while (!level flag::get(str_endon)) {
    level scene::play(t_start.targetname);
    t_start notify("hash_856e667");
    level flag::wait_till_clear("surging_inward");
  }
}

function function_8fbe0681(a_ents, str_endon, a_e_debris, t_start) {
  var_e7610d59 = t_start.script_string;
  e_wave = a_ents[var_e7610d59];
  e_debris = a_ents[var_e7610d59 + "_debris"];
  e_debris thread function_1168d325(t_start);
  str_joint = "wave_trigger_jnt";
  t_start enablelinkto();
  t_start.origin = e_wave gettagorigin(str_joint);
  t_start linkto(e_wave, str_joint, (0, 120, -35), vectorscale((0, -1, 0), 90));
  level flag::set("surge_active");
  foreach(player in level.players) {
    t_start thread surge_player_tracker(player);
    t_start thread surge_warning(player);
  }
  t_start thread hendricks_surge_tracker();
  t_start thread enemy_surge_tracker();
  wait(0.05);
  e_wave clientfield::set("water_disturbance", 1);
  t_start waittill("hash_856e667");
  e_wave notify(self.scriptbundlename);
  level notify(t_start.script_noteworthy);
  level flag::set("end_surge");
  if(self.scriptbundlename == "p7_fxanim_cp_blackstation_wave_01_bundle") {
    level flag::set("cover_switch");
  }
  level flag::clear("surging_inward");
  level flag::clear("surge_active");
  level flag::clear("end_surge");
  e_wave stopanimscripted();
  e_wave clientfield::set("water_disturbance", 0);
}

function function_1168d325(t_start) {
  var_b7926b3a = t_start.script_float;
  for (x = 1; x <= var_b7926b3a; x++) {
    if(x < 10) {
      str_bone_name = ("debris_0" + x) + "_jnt";
    } else {
      str_bone_name = ("debris_" + x) + "_jnt";
    }
    n_chance = randomintrange(0, 100);
    if(n_chance > 33) {
      self hidepart(str_bone_name);
      continue;
    }
    self showpart(str_bone_name);
  }
}

function surge_warning(player) {
  self endon("death");
  self endon("wave_stop");
  level endon("end_surge");
  player endon("death");
  while (distance2dsquared(self.origin, player.origin) > 490000) {
    wait(0.1);
  }
  if(player.is_wet && !isdefined(player getluimenu("SurgeWarning"))) {
    player thread function_8b5bccf1("SurgeWarning");
  } else {
    while (!player.is_wet) {
      wait(0.05);
    }
    if(!isdefined(player getluimenu("SurgeWarning"))) {
      player thread function_8b5bccf1("SurgeWarning");
    }
  }
}

function function_8b5bccf1(str_menu) {
  if(!isdefined(self.var_25f6f033)) {
    self.var_25f6f033 = 0;
  }
  if(!self.var_25f6f033) {
    self.var_25f6f033 = 1;
    self util::show_hint_text(&"CP_MI_SING_BLACKSTATION_USE_ANCHOR");
  }
  self thread weather_menu(str_menu, "end_surge", "stop_surge");
}

function enemy_surge_tracker() {
  self endon("death");
  level endon(self.script_noteworthy);
  while (true) {
    self waittill("trigger", ai_entity);
    if(isalive(ai_entity) && ai_entity.team == "axis" && (isdefined(ai_entity.b_swept) && !ai_entity.b_swept)) {
      ai_entity.b_swept = 1;
      ai_entity thread enemy_surge_hit(self);
    }
  }
}

function enemy_surge_hit(t_surge) {
  self endon("death");
  v_dir = vectornormalize(self.origin - t_surge.origin);
  self startragdoll();
  self launchragdoll(v_dir * 75);
  self kill();
}

function function_c1eab89b(t_surge) {
  self endon("death");
  t_surge endon("death");
  n_factor = 0.012;
  n_offset = 180;
  if(isdefined(self.target)) {
    while (!self istouching(t_surge)) {
      wait(0.1);
    }
    s_goal = struct::get(self.target);
    n_speed = distance(s_goal.origin, self.origin) * n_factor;
    self clientfield::increment("water_splash_lrg");
    self playsound("evt_surge_impact_debris");
    self moveto(s_goal.origin, n_speed);
    self rotateto(s_goal.angles, n_speed);
    self waittill("movedone");
    level flag::wait_till_clear("surging_inward");
    while (isdefined(s_goal.target)) {
      s_goal = struct::get(s_goal.target);
      level flag::wait_till("surging_inward");
      while (!self istouching(t_surge)) {
        wait(0.1);
      }
      n_speed = distance(s_goal.origin, self.origin) * n_factor;
      self clientfield::increment("water_splash_lrg");
      self moveto(s_goal.origin, n_speed);
      self rotateto(s_goal.angles, n_speed);
      self waittill("movedone");
      if(isdefined(s_goal.target)) {
        level flag::wait_till_clear("surging_inward");
      }
    }
  }
  self thread function_d1bc8584();
  self thread function_43990014(t_surge);
}

function function_43990014(t_surge) {
  self endon("death");
  t_surge endon("death");
  while (true) {
    level flag::wait_till("surging_inward");
    while (!self istouching(t_surge)) {
      wait(0.1);
    }
    self clientfield::increment("water_splash_lrg");
    level flag::wait_till_clear("surging_inward");
  }
}

function function_d1bc8584() {
  self endon("death");
  if(isdefined(self.script_int)) {
    str_scene = ("p7_fxanim_cp_blackstation_cars_rocking_0" + self.script_int) + "_bundle";
    level thread scene::play(str_scene);
  }
}

function set_model_scale() {
  if(isdefined(self.modelscale)) {
    self setscale(self.modelscale);
  }
}

function hendricks_surge_tracker() {
  self endon("death");
  level endon(self.script_noteworthy);
  level endon("tanker_ride_done");
  while (true) {
    while (distance2dsquared(self.origin, level.ai_hendricks.origin) > 722500) {
      wait(0.05);
    }
    self thread hendricks_surge_warning();
    break;
  }
}

function hendricks_surge_warning() {
  level endon("tanker_ride_done");
  level flag::clear("kill_surge");
  level notify("surge_warning");
  while (isdefined(self) && level.ai_hendricks istouching(self)) {
    wait(0.05);
  }
  level flag::set("kill_surge");
}

function surge_player_tracker(player) {
  self endon("death");
  self endon("wave_stop");
  level endon(self.script_noteworthy);
  player endon("death");
  while (true) {
    self waittill("trigger", e_hit);
    if(e_hit == player && !player.is_surged) {
      player.is_surged = 1;
      player thread surge_trigger_watcher(self);
      player thread surge_player_push(self);
      player thread surge_player_rumble(self);
      player thread function_6b6e7b58(self);
      player playsound("evt_surge_impact");
      break;
    }
  }
}

function function_6b6e7b58(t_surge) {
  self endon("death");
  while (self istouching(t_surge)) {
    util::wait_network_frame();
  }
  wait(0.5);
  if(self.is_anchored) {
    self toggle_player_anchor(0);
  }
}

function surge_trigger_watcher(t_surge) {
  self endon("death");
  self clientfield::set_to_player("wave_hit", 1);
  self clientfield::set_to_player("wind_blur", 1);
  while (isdefined(t_surge) && self istouching(t_surge)) {
    wait(0.05);
  }
  self.is_surged = 0;
  if(isdefined(t_surge)) {
    t_surge notify("wave_stop");
  }
  self clientfield::set_to_player("wave_hit", 0);
  self clientfield::set_to_player("wind_blur", 0);
}

function surge_player_rumble(t_wave) {
  level endon("end_surge");
  self endon("death");
  self endon("stop_surge");
  t_wave endon("wave_stop");
  earthquake(0.5, 2, self.origin, 100);
  while (true) {
    self playrumbleonentity("damage_heavy");
    wait(0.1);
  }
}

function surge_player_push(t_wave) {
  level endon("end_surge");
  self endon("death");
  self endon("stop_surge");
  t_wave endon("wave_stop");
  n_push_strength = 200;
  v_dir = anglestoforward(vectorscale((0, 1, 0), 90));
  while (true) {
    if(!self.b_safezone && !self.is_anchored && (!(isdefined(self.laststand) && self.laststand))) {
      self setvelocity(v_dir * n_push_strength);
    } else if(isdefined(self.e_anchor)) {
      var_3b8c7376 = distance2dsquared(self.origin, self.e_anchor.origin);
      if(distance2dsquared(self.origin, self.e_anchor.origin) > 10000) {
        self setvelocity(v_dir * n_push_strength);
      }
    }
    if(!self.is_wet) {
      self notify("stop_surge");
      self util::hide_hint_text();
      break;
    }
    wait(0.05);
  }
}

function create_surge(t_storm) {
  level endon("end_surge");
  t_storm endon("death");
  while (true) {
    foreach(player in level.players) {
      if(player istouching(t_storm)) {
        player.is_wet = 1;
        t_storm.is_surging = 1;
      }
    }
    wait(0.05);
  }
}

function player_surge_trigger_tracker() {
  self notify("hash_8af17fe2");
  self endon("hash_8af17fe2");
  self endon("death");
  t_storm = getent("port_assault_low_surge", "targetname");
  t_storm endon("death");
  self.is_surge_affected = 0;
  while (true) {
    while (self istouching(t_storm)) {
      self.is_surge_affected = 1;
      self.is_wet = 1;
      self allowprone(0);
      self allowsprint(0);
      if(!(isdefined(t_storm.is_surging) && t_storm.is_surging)) {
        switch (t_storm.script_string) {
          case "high": {
            self setmovespeedscale(0.7);
            break;
          }
          default: {
            self setmovespeedscale(0.9);
            break;
          }
        }
      } else {
        switch (t_storm.script_string) {
          case "high": {
            self setmovespeedscale(0.5);
            break;
          }
          default: {
            self setmovespeedscale(0.7);
            break;
          }
        }
      }
      wait(0.05);
    }
    a_t_surge = getentarray(t_storm.script_noteworthy, "script_noteworthy");
    b_in_surge_trigger = 0;
    foreach(trigger in a_t_surge) {
      if(self istouching(trigger)) {
        b_in_surge_trigger = 1;
      }
    }
    if(!b_in_surge_trigger) {
      self setmovespeedscale(1);
      self allowprone(1);
      self allowsprint(1);
      self.is_surge_affected = 0;
      self.is_wet = 0;
    }
    wait(0.05);
  }
}

function function_e7121462() {
  self endon("death");
  while (true) {
    while (level.ai_hendricks istouching(self)) {
      level.ai_hendricks asmsetanimationrate(0.9);
      wait(0.1);
    }
    level.ai_hendricks asmsetanimationrate(1);
    wait(0.1);
  }
}

function prep_waves() {
  a_waves_left = getentarray("pier_wave_left", "script_noteworthy");
  a_waves_right = getentarray("pier_wave_right", "script_noteworthy");
  a_waves = arraycombine(a_waves_left, a_waves_right, 0, 0);
  foreach(wave in a_waves) {
    wave ghost();
    t_wave = getent(wave.target, "targetname");
    t_wave enablelinkto();
    t_wave linkto(wave);
  }
}

function pier_safe_zones() {
  level flag::wait_till("all_players_spawned");
  foreach(player in level.players) {
    player thread player_safezone_watcher();
  }
}

function player_safezone_watcher() {
  a_t_safezones = getentarray("trigger_pier_safe", "targetname");
  for (i = 0; i < a_t_safezones.size; i++) {
    self thread player_safezone_watcher_trigger();
  }
}

function player_safezone_watcher_trigger() {
  self endon("death");
  while (true) {
    self waittill("trigger", player);
    if(isplayer(player)) {
      self.b_safezone = 1;
      player notify("safezone_trigger");
      self thread player_safezone_watcher_trigger_end(player);
    }
  }
}

function player_safezone_watcher_trigger_end(player) {
  player endon("death");
  player endon("safezone_trigger");
  while (true) {
    if(!player istouching(self)) {
      self.b_safezone = 0;
      break;
    }
    wait(0.05);
  }
}

function wave_manager() {
  self endon("death");
  while (true) {
    wait(randomfloatrange(3.5, 4.5));
    level thread create_wave(self);
    self.is_wavy = 0;
  }
}

function create_wave(t_storm) {
  level flag::clear("kill_wave");
  level endon("kill_wave");
  t_storm endon("death");
  level notify("wave_warning");
  wait(1);
  a_waves_left = getentarray("pier_wave_left", "script_noteworthy");
  a_waves_right = getentarray("pier_wave_right", "script_noteworthy");
  a_waves = arraycombine(a_waves_left, a_waves_right, 0, 0);
  e_wave = a_waves[randomintrange(0, a_waves.size)];
  s_wave = struct::get(e_wave.target, "targetname");
  t_wave = getent(e_wave.target, "targetname");
  e_wave playsound("evt_wave_dist");
  t_wave playsound("evt_wave_splash");
  array::thread_all(getentarray("wave_fodder", "script_noteworthy"), & enemy_wave_tracker, t_wave, s_wave);
  foreach(player in level.players) {
    player thread player_wave_trigger_tracker(t_wave);
  }
  t_wave thread ai_wave_trigger_tracker();
  level thread move_wave(e_wave);
  while (true) {
    foreach(player in level.players) {
      if(player istouching(t_wave)) {
        if(!isdefined(player getluimenu("WaveWarning"))) {
          player thread weather_menu("WaveWarning", "kill_wave");
        }
        v_dir = anglestoforward((0, s_wave.angles[1], 0));
        n_push_strength = 250;
        t_wave.is_wavy = 1;
        if(!player.b_safezone && !player.is_anchored) {
          player setvelocity(v_dir * n_push_strength);
        }
        if(player.is_anchored) {
          player playrumbleonentity("bs_wave_anchored");
          continue;
        }
        player playrumbleonentity("bs_wave");
      }
    }
    wait(0.05);
  }
}

function enemy_wave_tracker(t_wave, s_wave) {
  self endon("death");
  t_wave endon("death");
  level endon("kill_wave");
  while (true) {
    if(self istouching(t_wave)) {
      v_dir = vectornormalize(self.origin - (s_wave.origin[0], self.origin[1], s_wave.origin[2]));
      self startragdoll();
      self launchragdoll(v_dir * 100);
      self kill();
    }
    wait(0.05);
  }
}

function move_wave(e_wave) {
  s_wave = struct::get(e_wave.target, "targetname");
  e_wave.t_wave = getent(e_wave.target, "targetname");
  e_wave.origin = s_wave.origin;
  e_wave.angles = s_wave.angles;
  if(e_wave.script_noteworthy == "pier_wave_left") {
    n_dist = -450;
  } else {
    n_dist = 450;
  }
  e_wave moveto(e_wave.origin + vectorscale((0, 0, 1), 150), 0.1);
  e_wave waittill("movedone");
  e_wave moveto(e_wave.origin + (n_dist, 0, 150), 2.5);
  foreach(player in level.players) {
    e_wave thread player_wave_protect(player);
  }
  e_wave thread play_temp_wave_fx();
  e_wave waittill("movedone");
  e_wave moveto(e_wave.origin + (n_dist, 0, -150), 0.5);
  e_wave waittill("movedone");
  e_wave notify("wave_passed");
  level flag::set("kill_wave");
}

function player_wave_protect(player) {
  player endon("death");
  self endon("wave_passed");
  player.is_protected = 0;
  while (true) {
    self.t_wave waittill("trigger", e_hit);
    if(e_hit == player && !player.is_protected) {
      n_attackeraccuracy = player.attackeraccuracy;
      player.attackeraccuracy = 0;
      player.is_protected = 1;
      self waittill("movedone");
      player.attackeraccuracy = n_attackeraccuracy;
      player.is_protected = 0;
    }
  }
}

function player_wave_trigger_tracker(t_storm) {
  self endon("death");
  t_storm endon("death");
  level endon("kill_weather");
  self.is_wavy = 0;
  while (true) {
    while (self istouching(t_storm)) {
      self.is_wavy = 1;
      wait(0.05);
    }
    self.is_wavy = 0;
    wait(0.05);
  }
}

function ai_wave_trigger_tracker() {
  self endon("death");
  level endon("kill_weather");
  while (true) {
    self waittill("trigger", ai_entity);
    if(isalive(ai_entity) && ai_entity.team == "axis" && !isdefined(ai_entity.b_swept)) {
      self function_9cf489b(ai_entity);
    }
  }
}

function function_9cf489b(ai_entity) {
  self endon("death");
  ai_entity endon("death");
  ai_entity.b_swept = 1;
  n_face = ai_entity.angles[1];
  if(n_face >= 0 && n_face <= 180) {
    if(self.script_noteworthy == "pier_wave_left_trigger") {
      n_dir = -100;
      ai_entity thread scene::play("cin_bla_06_02_vign_wave_swept_left", ai_entity);
    } else {
      n_dir = 100;
      ai_entity thread scene::play("cin_bla_06_02_vign_wave_swept_right", ai_entity);
    }
  } else {
    if(self.script_noteworthy == "pier_wave_left_trigger") {
      n_dir = -100;
      ai_entity thread scene::play("cin_bla_06_02_vign_wave_swept_right", ai_entity);
    } else {
      n_dir = 100;
      ai_entity thread scene::play("cin_bla_06_02_vign_wave_swept_left", ai_entity);
    }
  }
  ai_entity waittill("swept_away");
  ai_entity startragdoll();
  ai_entity launchragdoll((0, 100, 40));
  ai_entity kill();
}

function truck_gunner_replace(n_gunners = 1, n_delay = 1, str_endon) {
  self endon("death");
  if(isdefined(str_endon)) {
    level endon(str_endon);
  }
  n_guys = 0;
  while (n_guys < n_gunners) {
    ai_gunner = self vehicle::get_rider("gunner1");
    if(isalive(ai_gunner)) {
      ai_gunner waittill("death");
    } else {
      ai_gunner = get_truck_gunner(self);
      if(isalive(ai_gunner)) {
        ai_gunner vehicle::get_in(self, "gunner1", 0);
        n_guys++;
      }
    }
    wait(n_delay);
  }
}

function get_truck_gunner(vh_truck) {
  a_ai_enemies = getaiarchetypearray("human", "axis");
  a_ai_gunners = arraysortclosest(a_ai_enemies, vh_truck.origin);
  return a_ai_gunners[0];
}

function truck_unload(str_pos) {
  ai_rider = self vehicle::get_rider(str_pos);
  if(isdefined(ai_rider)) {
    ai_rider vehicle::get_out();
    ai_rider util::stop_magic_bullet_shield();
    ai_rider.nocybercom = 0;
  }
}

function protect_riders() {
  self endon("death");
  while (!isdefined(self vehicle::get_rider("driver"))) {
    wait(0.1);
  }
  ai_driver = self vehicle::get_rider("driver");
  if(isalive(ai_driver)) {
    ai_driver.nocybercom = 1;
    ai_driver util::magic_bullet_shield();
  }
}

function play_temp_wave_fx() {
  self.e_fx = util::spawn_model("tag_origin", self.origin);
  self.e_fx linkto(self);
  self.e_fx fx::play("wave_pier", self.e_fx.origin + (vectorscale((0, 0, -1), 32)), undefined, 2, 1);
  self waittill("movedone");
  if(isdefined(self.e_fx)) {
    self.e_fx delete();
  }
}

function police_station_corpses() {
  a_corpses = getentarray("immortal_police_station_corpse", "targetname");
  foreach(a_e_corpse in a_corpses) {
    a_e_corpse thread scene::play(a_e_corpse.script_noteworthy, a_e_corpse);
  }
}

function player_rain_intensity(str_intensity) {
  switch (str_intensity) {
    case "none": {
      n_rain = 0;
      break;
    }
    case "light_se": {
      n_rain = 1;
      break;
    }
    case "med_se": {
      n_rain = 2;
      break;
    }
    case "drench_se": {
      n_rain = 3;
      break;
    }
    case "light_ne": {
      n_rain = 4;
      break;
    }
    case "med_ne": {
      n_rain = 5;
      break;
    }
    case "drench_ne": {
      n_rain = 6;
      break;
    }
  }
  if(self == level) {
    foreach(player in level.players) {
      player.b_rain_on = 1;
      player clientfield::set_to_player("player_rain", n_rain);
    }
  } else if(isplayer(self)) {
    self.b_rain_on = 1;
    self clientfield::set_to_player("player_rain", n_rain);
  }
}

function lightning_flashes(str_exploder, str_endon) {
  level endon(str_endon);
  while (true) {
    for (i = 0; i < 5; i++) {
      level exploder::exploder(str_exploder);
      wait(0.05);
      level exploder::stop_exploder(str_exploder);
      wait(0.05);
    }
    playsoundatposition("amb_2d_thunder_hits", (0, 0, 0));
    level exploder::exploder_duration(str_exploder, 1);
    wait(randomfloatrange(8, 11.5));
  }
}

function function_bd1bfce2(var_4afc7733, var_d8f507f8, var_fef78261, var_6908bd27, str_endon) {
  level endon(str_endon);
  while (true) {
    exploder::exploder(var_4afc7733);
    level thread function_5bf870a4(var_6908bd27);
    wait(randomfloatrange(0.05, 0.11));
    exploder::exploder(var_d8f507f8);
    level thread function_5bf870a4(var_6908bd27);
    wait(randomfloatrange(0.11, 0.25));
    if(math::cointoss()) {
      exploder::exploder(var_fef78261);
      level thread function_5bf870a4(var_6908bd27);
    }
    wait(randomfloatrange(0.7, 3));
  }
}

function function_5bf870a4(var_6908bd27) {
  foreach(player in level.activeplayers) {
    player clientfield::set_to_player("toggle_ukko", var_6908bd27);
  }
}

function function_d1dc735f() {
  level thread anchor_tutorial();
  foreach(player in level.activeplayers) {
    player thread player_anchor();
  }
  level.ai_hendricks colors::disable();
  level.ai_hendricks ai::set_behavior_attribute("move_mode", "rambo");
  level.ai_hendricks ai::set_behavior_attribute("can_melee", 0);
  level thread scene::play("cin_bla_05_01_debristraversal_vign_useanchor_start");
  level waittill("hash_153898ed");
  level flag::set("hendricks_debris_traversal_ready");
  level.ai_hendricks ai::set_behavior_attribute("move_mode", "normal");
  level.ai_hendricks ai::set_behavior_attribute("can_melee", 1);
}

function function_ef275fb3() {
  self endon("death");
  while (true) {
    self waittill("missile_fire", e_proj);
    if(isdefined(e_proj)) {
      e_proj thread function_eef51bcb(e_proj, self);
    }
    wait(0.05);
  }
}

function function_eef51bcb(e_proj, e_shooter) {
  self endon("death");
  e_target = e_shooter.enemy;
  n_dist = distancesquared(e_shooter.origin, e_target.origin);
  var_c003c84d = getent("wind_target", "targetname");
  while (isdefined(e_proj)) {
    if(isdefined(e_target) && distancesquared(e_proj.origin, e_target.origin) < (0.5 * n_dist)) {
      e_proj missile_settarget(var_c003c84d);
      break;
    }
    wait(0.05);
  }
}

function function_33942907() {
  level notify("hash_affb79f4");
  level endon("hash_affb79f4");
  while (true) {
    if(isdefined(level.heroes) && level.heroes.size > 0) {
      foreach(e_hero in level.heroes) {
        if(e_hero function_30dbc9bf()) {
          e_hero.allowbattlechatter["bc"] = 1;
          continue;
        }
        e_hero.allowbattlechatter["bc"] = 0;
      }
    }
    a_ai = getaiteamarray("axis");
    var_39e0fee4 = 0;
    if(isdefined(a_ai) && a_ai.size > 0) {
      foreach(ai in a_ai) {
        if(ai function_30dbc9bf()) {
          var_39e0fee4 = 1;
        }
      }
    }
    if(var_39e0fee4) {
      battlechatter::function_d9f49fba(1);
    } else {
      battlechatter::function_d9f49fba(0);
    }
    wait(1);
  }
}

function function_704add6a() {
  level notify("hash_affb79f4");
  if(isdefined(level.heroes) && level.heroes.size > 0) {
    foreach(e_hero in level.heroes) {
      e_hero.allowbattlechatter["bc"] = 1;
    }
  }
  battlechatter::function_d9f49fba(1);
}

function function_30dbc9bf() {
  return isdefined(self) && isalive(self) && (!isdefined(self.current_scene) && !isdefined(self._o_scene)) && (!(isdefined(self.ignoreme) && self.ignoreme) && (!(isdefined(self.ignoreall) && self.ignoreall)));
}

function dynamic_run_speed(var_c047ec73 = 250, var_3b15866b = var_c047ec73 * 0.5) {
  self notify("start_dynamic_run_speed");
  self endon("death");
  self endon("start_dynamic_run_speed");
  self endon("stop_dynamic_run_speed");
  self thread stop_dynamic_run_speed();
  while (true) {
    wait(0.05);
    if(!isdefined(self.goalpos)) {
      continue;
    }
    v_goal = self.goalpos;
    e_player = arraygetclosest(v_goal, level.players);
    e_closest = arraygetclosest(v_goal, array(e_player, self));
    n_dist = distance2dsquared(self.origin, e_player.origin);
    is_behind = isplayer(e_closest);
    if(n_dist < (var_3b15866b * var_3b15866b) || is_behind) {
      self ai::set_behavior_attribute("cqb", 0);
      self ai::set_behavior_attribute("sprint", 1);
      continue;
    } else {
      if(n_dist < (var_c047ec73 * var_c047ec73)) {
        self ai::set_behavior_attribute("cqb", 0);
        self ai::set_behavior_attribute("sprint", 0);
        continue;
      } else if(n_dist > ((var_c047ec73 * var_c047ec73) * 1.25)) {
        self ai::set_behavior_attribute("cqb", 1);
        self ai::set_behavior_attribute("sprint", 0);
        continue;
      }
    }
  }
}

function stop_dynamic_run_speed() {
  self endon("start_dynamic_run_speed");
  self endon("death");
  self waittill("stop_dynamic_run_speed");
  self ai::set_behavior_attribute("cqb", 0);
  self ai::set_behavior_attribute("sprint", 0);
}

function coop_teleport_on_igc_end(a_ents, str_teleport_name) {
  util::teleport_players_igc(str_teleport_name);
}

function function_da77906f(a_ents, str_state) {
  if(!isdefined(a_ents)) {
    a_ents = [];
  } else if(!isarray(a_ents)) {
    a_ents = array(a_ents);
  }
  foreach(e_ent in a_ents) {
    if(e_ent.spawnflags & 1) {
      if(str_state === "connect") {
        e_ent connectpaths();
        continue;
      }
      if(str_state === "disconnect") {
        e_ent disconnectpaths(2, 0);
      }
    }
  }
}

function cleanup_ai() {
  array::run_all(getaiteamarray("axis"), & delete);
}

function missile_launcher_equip_hint() {
  self endon("death");
  self util::show_hint_text(&"COOP_EQUIP_MICROMISSILE");
  n_timeout = 0;
  while (self getcurrentweapon() != getweapon("micromissile_launcher") && n_timeout <= 10) {
    n_timeout = n_timeout + 0.1;
    wait(0.1);
  }
  if(self getcurrentweapon() == getweapon("micromissile_launcher")) {
    self.var_f44af1ef = 1;
  }
  self util::hide_hint_text();
}

function launcher_hint_watcher() {
  self endon("death");
  self endon("weapon_change");
  n_timeout = 0;
  while (!self adsbuttonpressed() && n_timeout >= 10) {
    n_timeout = n_timeout + 0.05;
    wait(0.05);
  }
  wait(2);
  if(isdefined(self getluimenu("MissileLauncherHint"))) {
    self closeluimenu(self getluimenu("MissileLauncherHint"));
    self.b_launcher_hint = 1;
    self notify("launcher_hint");
  }
}

function close_launcher_hint() {
  self endon("death");
  self endon("launcher_hint");
  self waittill("weapon_change");
  if(isdefined(self getluimenu("MissileLauncherHint"))) {
    self closeluimenu(self getluimenu("MissileLauncherHint"));
  }
}

function function_76b75dc7(str_endon, var_cca258db = 12, var_ab7d99d = 200) {
  level endon(str_endon);
  self endon("death");
  while (true) {
    self waittill("trigger", player);
    player thread function_ed7faf05();
    if(!player.var_32939eb7) {
      player.var_32939eb7 = 1;
      player thread function_7b145e0b(self, str_endon, var_cca258db, var_ab7d99d);
    }
  }
}

function function_7b145e0b(t_water, str_endon, var_cca258db, var_ab7d99d) {
  self endon("death");
  level endon(str_endon);
  t_water endon("death");
  if(self laststand::player_is_in_laststand()) {
    self.var_116f2fb8 = 1;
  }
  e_linkto = util::spawn_model("tag_origin", self.origin, self.angles);
  self playerlinktodelta(e_linkto, "tag_origin", 1, 45, 45, 45, 45);
  self clientfield::set_to_player("player_water_swept", 1);
  e_linkto thread scene::play("cin_blackstation_24_01_ride_vign_body_player_flail", self);
  e_linkto moveto((e_linkto.origin[0], e_linkto.origin[1], var_cca258db), 0.3);
  e_linkto waittill("movedone");
  s_pos = struct::get(t_water.target);
  n_dist = distance(e_linkto.origin, s_pos.origin);
  n_time = n_dist / var_ab7d99d;
  e_linkto thread spin_player(3);
  e_linkto moveto((s_pos.origin[0], s_pos.origin[1], var_cca258db), n_time);
  e_linkto waittill("movedone");
  e_linkto moveto(s_pos.origin, 1);
  e_linkto waittill("movedone");
  e_linkto scene::stop("cin_blackstation_24_01_ride_vign_body_player_flail");
  self unlink();
  self.var_32939eb7 = 0;
  self clientfield::set_to_player("player_water_swept", 0);
  util::wait_network_frame();
  self setplayerangles(s_pos.angles);
  e_linkto delete();
  self thread player_anchor();
  if(self.var_116f2fb8) {
    self.var_116f2fb8 = 0;
    self dodamage(self.health, self.origin);
  }
}

function spin_player(n_rate) {
  self endon("death");
  while (true) {
    self rotateyaw(-180, n_rate);
    wait(0.9);
  }
}

function function_d70754a2() {
  objectives::set("cp_level_blackstation_qzone");
  objectives::set("cp_level_blackstation_intercept");
  objectives::set("cp_level_blackstation_goto_docks");
  objectives::set("cp_level_blackstation_neutralize");
  objectives::complete("cp_level_blackstation_neutralize");
}

function dead_civilians() {
  a_e_civs = getentarray("qzone_civilian_body", "targetname");
  foreach(e_corpse in a_e_civs) {
    e_corpse thread scene::play(e_corpse.script_noteworthy, e_corpse);
  }
  level flag::wait_till("tanker_go");
  foreach(e_corpse in a_e_civs) {
    if(isdefined(e_corpse)) {
      e_corpse delete();
    }
  }
}

function function_4f96504c(ai_target) {
  type = self cybercom::function_5e3d3aa();
  var_1eba5cf1 = vectortoangles(ai_target.origin - self.origin);
  var_1eba5cf1 = (0, var_1eba5cf1[1], 0);
  self animscripted("ai_cybercom_anim", self.origin, var_1eba5cf1, ("ai_base_rifle_" + type) + "_exposed_cybercom_activate", "normal", undefined, undefined, 0.3, 0.3);
  self cybercom::cybercom_armpulse(0);
  self waittillmatch("ai_cybercom_anim");
}

function function_dccf6ccc() {
  self endon("hash_d60979de");
  while (true) {
    wait(randomfloatrange(5, 7));
    if(isdefined(self.enemy) && !isdefined(self.enemy.current_scene) && !isdefined(self.enemy._o_scene) && self.enemy.archetype != "warlord") {
      ai_target = self.enemy;
      if(isalive(ai_target) && !self isplayinganimscripted()) {
        if(ai_target.archetype == "human") {
          var_3e2155a7 = "cybercom_immolation";
        } else {
          if(math::cointoss()) {
            var_3e2155a7 = "cybercom_servoshortout";
          } else {
            var_3e2155a7 = "cybercom_immolation";
          }
        }
        self ai::set_ignoreall(1);
        self function_4f96504c(ai_target);
        if(isalive(ai_target)) {
          self thread cybercom::function_d240e350(var_3e2155a7, ai_target, 0, 1);
        }
        self ai::set_ignoreall(0);
      }
    }
  }
}

function function_d870e0(str_trigger) {
  self endon("death");
  trigger::wait_till(str_trigger, "targetname", self);
  self thread coop::function_e9f7384d();
}

function function_46dd77b0() {
  level endon("hash_e2a9cc43");
  level flag::wait_till("hendricks_debris_traversal_ready");
  wait(5);
  level.ai_hendricks dialog::say("hend_hurry_it_up_we_need_0");
  wait(6);
  level.ai_hendricks dialog::say("hend_what_are_you_waiting_6");
  wait(7);
  level.ai_hendricks dialog::say("hend_we_d_better_get_movi_0");
}

function function_70aaf37b(b_active) {
  e_blocker = getent("hotel_blocker", "targetname");
  if(b_active) {
    e_blocker solid();
  } else {
    e_blocker notsolid();
  }
}