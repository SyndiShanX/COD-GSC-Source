/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_apache_player_pilot.gsc
****************************************************/

_precache() {
  precacheshader("apache_compass_back");
  precacheshader("apache_hint_back");
  precacheshader("apache_speed_arrow");
  precacheshader("apache_speed_back");
  precacheshader("apache_altitude_arrow");
  precacheshader("apache_altitude_back");
  precacheshader("apache_roll_back");
  precacheshader("apache_roll_marker");
  precacheshader("apache_roll_marker_left1");
  precacheshader("apache_roll_marker_left2");
  precacheshader("apache_roll_marker_right1");
  precacheshader("apache_roll_marker_right2");
  precacheshader("apache_reticle");
  precacheshader("apache_zoom_overlay");
  precacheshader("apache_mg_heat_back");
  precacheshader("apache_mg_heat_warn");
  precacheshader("osp_hud_color_red");
  precacheshader("apache_bottom_mark");
  precacheshader("apache_enemy_thermalbody");
  precacheshader("apache_enemy_thermalbody_no_pulse");
  precachemodel("viewmodel_prototype_apache_visor");
  vehicle_scripts\_apache_player_missile_hydra_and_lockon::_precache();
  _fx();
  _anim();
}

_fx() {
  level._effect["FX_apache_pilot_turret_projectile"] = loadfx("fx/_requests/apache/apache_pilot_turret_projectile");
  level._effect["FX_apache_pilot_turret_flash_view"] = loadfx("fx/_requests/apache/apache_pilot_turret_flash_view");
  level._effect["FX_apache_pilot_shot_blood"] = loadfx("fx/_requests/apache/apache_pilot_shot_blood");
}

#using_animtree("generic_human");

_anim() {
  level.scr_animtree["generic"] = #animtree;
  level.scr_anim["generic"]["helicopter_pilot1_idle"] = % helicopter_pilot1_idle;
  level.scr_anim["generic"]["helicopter_pilot1_twitch_lookback"] = % helicopter_pilot1_twitch_lookback;
  level.scr_anim["generic"]["helicopter_pilot1_twitch_lookoutside"] = % helicopter_pilot1_twitch_lookoutside;
  level.scr_anim["generic"]["helicopter_pilot1_twitch_clickpannel"] = % helicopter_pilot1_twitch_clickpannel;
  level.scr_anim["generic"]["apache_cockpit_copilot_death"] = % apache_cockpit_copilot_death;
}

_init(var_0, var_1) {
  var_2 = getent("apache_pilot", "targetname");
  var_2.origin = var_0 gettagorigin("tag_passenger");
  var_2.angles = var_0 gettagangles("tag_passenger");
  var_3 = var_2 spawndrone();
  var_3 dontcastshadows();
  var_3.animname = "generic";
  var_3 maps\_anim::setanimtree();
  var_3 linkto(var_0, "tag_passenger");
  var_3 thread pilot_ai_start(var_1, self, "tag_passenger");
  var_4 = spawnStruct();
  var_4.owner = var_1;
  var_4.vehicle = var_0;
  var_4.pilot_ai_spawner = var_2;
  var_4.pilot_ai = var_3;
  var_4.type = "pilot";
  var_4.weapon = [];
  var_4 hud_init();
  var_4.weapon["hydra_lockOn_missile"] = vehicle_scripts\_apache_player_missile_hydra_and_lockon::_init(var_1, var_0, var_4.hud);
  var_4.currentweapon = "hydra_lockOn_missile";
  var_4.vehicle.mgturret[0] maps\_utility::ent_flag_init("FLAG_turret_init");
  var_4.vehicle.mgturret[0] thread turret_init(var_4.vehicle, var_4.owner);
  var_1 maps\_utility::ent_flag_init("FLAG_apache_pilot_has_changed_weapons");
  var_1 maps\_utility::ent_flag_init("FLAG_apache_pilot_changed_weapons");
  var_1 maps\_utility::ent_flag_init("FLAG_apache_pilot_ADS");
  return var_4;
}

pilot_ai_start(var_0, var_1, var_2) {
  self endon("death");
  childthread pilot_ai_anim(var_1, var_2);
  thread pilot_ai_death(var_1, var_2);

  for(;;) {
    self waittill("LISTEN_end_pilot");
    self hideonclient(var_0);
    self waittill("LISTEN_start_pilot");
    self showonclient(var_0);
  }
}

pilot_ai_anim(var_0, var_1) {
  var_0 endon("LISTEN_pilot_death");

  for(;;) {
    var_0 maps\_anim::anim_generic(self, "helicopter_pilot1_idle", var_1);
    var_0 maps\_anim::anim_generic(self, "helicopter_pilot1_twitch_lookback", var_1);
    var_0 maps\_anim::anim_generic(self, "helicopter_pilot1_twitch_lookoutside", var_1);
    var_0 maps\_anim::anim_generic(self, "helicopter_pilot1_twitch_clickpannel", var_1);
  }
}

pilot_ai_death(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("LISTEN_pilot_death");
  thread common_scripts\utility::play_sound_in_space("apache_player_pilot_death", self gettagorigin("tag_eye"));
  var_0 thread maps\_anim::anim_generic(self, "apache_cockpit_copilot_death", var_1);
  wait 0.1;
  playFXOnTag(common_scripts\utility::getfx("FX_apache_pilot_shot_blood"), self, "j_head");
}

hud_init() {
  var_0 = self.owner;
  var_1 = [];
  var_1["mg_reticle"] = var_0 maps\_hud_util::createclienticon("apache_reticle", 128, 128);
  var_1["mg_reticle"] maps\_hud_util::setpoint("CENTER", undefined, 0, 0);
  var_1["mg_reticle"].alpha = 1.0;
  var_1["mg_bar"] = var_0 maps\_hud_util::createclientprogressbar(var_0, 36, "osp_hud_color_red", "apache_mg_heat_back", 64, 6, 9, 2);
  var_1["mg_bar"] maps\_hud_util::updatebar(1);
  var_1["mg_bar"].alpha = 0.15;
  var_1["mg_bar_bar"] = var_1["mg_bar"].bar;
  var_1["mg_bar_bar"].alpha = 0.25;
  var_1["mg_warn"] = var_0 maps\_hud_util::createclienticon("apache_mg_heat_warn", 32, 32);
  var_1["mg_warn"] maps\_hud_util::setpoint("TOP", "BOTTOM", 0, -9);
  var_1["mg_warn"].alpha = 0;
  var_1["mg_warn"] maps\_hud_util::setparent(var_1["mg_bar"]);
  var_1["zoom_overlay"] = var_0 maps\_hud_util::createclienticon("apache_zoom_overlay", 256, 256);
  var_1["zoom_overlay"] maps\_hud_util::setpoint("CENTER", undefined, 0, 0);
  var_1["zoom_overlay"].alpha = 0.0;
  var_1["missile_roll"] = [];
  var_1["roll"]["bg"] = var_0 maps\_hud_util::createclienticon("apache_roll_back", 128, 32);
  var_1["roll"]["bg"] maps\_hud_util::setpoint("TOP", "TOP", 0, 42);
  var_1["roll"]["bg"].alpha = 1;
  var_1["roll"]["marker"] = var_0 maps\_hud_util::createclienticon("apache_roll_marker", 64, 64);
  var_1["roll"]["marker"] maps\_hud_util::setpoint("TOP", "TOP", 0, 40);
  var_1["roll"]["marker"].alpha = 1;
  var_1["speed"] = [];
  var_1["speed"]["bg"] = var_0 maps\_hud_util::createclienticon("apache_speed_back", 128, 512);
  var_1["speed"]["bg"] maps\_hud_util::setpoint("RIGHT", "RIGHT", 0, 0);
  var_1["speed"]["bg"].alpha = 1.0;
  var_1["speed"]["arrow"] = var_0 maps\_hud_util::createclienticon("apache_speed_arrow", 64, 32);
  var_1["speed"]["arrow"] maps\_hud_util::setpoint("LEFT", "BOTTOM", -24, -118);
  var_1["speed"]["arrow"].alpha = 1.0;
  var_1["speed"]["arrow"] maps\_hud_util::setparent(var_1["speed"]["bg"]);
  var_1["speed"]["number"] = var_0 maps\_hud_util::createclientfontstring("objective", 1.0);
  var_1["speed"]["number"] maps\_hud_util::setpoint("LEFT", "RIGHT", -10, 0);
  var_1["speed"]["number"].color = (1, 1, 1);
  var_1["speed"]["number"].alpha = 1.0;
  var_1["speed"]["number"].sort = -1;
  var_1["speed"]["number"] maps\_hud_util::setparent(var_1["speed"]["arrow"]);
  var_1["speed"]["number"] settext("0");
  var_1["altitude"] = [];
  var_1["altitude"]["line"] = var_0 maps\_hud_util::createclienticon("apache_altitude_back", 128, 512);
  var_1["altitude"]["line"] maps\_hud_util::setpoint("LEFT", "LEFT", 0, 0);
  var_1["altitude"]["line"].alpha = 1.0;
  var_1["altitude"]["arrow"] = var_0 maps\_hud_util::createclienticon("apache_altitude_arrow", 64, 32);
  var_1["altitude"]["arrow"] maps\_hud_util::setpoint("RIGHT", "BOTTOM", 33, -119);
  var_1["altitude"]["arrow"].alpha = 1.0;
  var_1["altitude"]["arrow"] maps\_hud_util::setparent(var_1["altitude"]["line"]);
  var_1["bottom_mark"] = var_0 maps\_hud_util::createclienticon("apache_bottom_mark", 128, 6);
  var_1["bottom_mark"] maps\_hud_util::setpoint("CENTER", "CENTER", 0, 120);
  var_1["bottom_mark"].alpha = 1;
  self.hud = var_1;
  thread hud_update();
}

hud_update() {
  self endon("LISTEN_destroy_pilot");
  var_0 = self.owner;
  var_1 = self.hud;
  var_2 = self.vehicle;
  childthread hud_update_roll();
  var_1["speed"]["number"].lastspeed = int(floor(var_2 vehicle_getspeed()));
  var_1["speed"]["number"] setvalue(var_1["speed"]["number"].lastspeed);

  for(;;) {
    hud_update_speed();
    hud_update_look_meter();
    hud_update_mg_heat();
    wait 0.05;
  }
}

hud_update_roll() {
  self endon("LISTEN_destroy_pilot");
  var_0 = self.owner;
  var_1 = self.hud;
  var_2 = self.vehicle;
  var_3 = getdvarfloat("vehHelicopterMaxRoll");
  var_4 = -1 * var_3;
  var_5 = var_3 - var_4;
  var_6 = var_5 / 4.0;
  var_7 = ceil(var_6 * 0.5);
  var_8 = ["apache_roll_marker_right2", "apache_roll_marker_right1", "apache_roll_marker", "apache_roll_marker_left1", "apache_roll_marker_left2"];
  var_9 = [];

  for(var_10 = 0; var_10 < var_8.size; var_10++) {
    var_9[int(var_4 + var_6 * var_10)] = var_8[var_10];
  }

  var_8 = undefined;
  var_11 = "";

  for(;;) {
    var_12 = clamp(var_2.angles[2], var_4, var_3);
    var_13 = int(maps\_utility::linear_interpolate(1.0 - (var_12 - var_4) / var_5, var_4, var_3));
    level.audio_roll = var_12;
    var_14 = undefined;

    foreach(var_17, var_16 in var_9) {
      if(var_13 >= var_17 - var_7 && var_13 <= var_17 + var_7) {
        var_14 = var_16;
        break;
      }
    }

    if(var_14 != var_11) {
      var_1["roll"]["marker"] setshader(var_14, 64, 64);
      var_11 = var_14;
    }

    wait 0.05;
  }
}

hud_update_mg_heat() {
  var_0 = self.hud;
  var_1 = self.vehicle.mgturret[0];

  if(!isDefined(var_1.heat)) {
    var_1.heat = 0;
  }

  var_0["mg_bar"] maps\_hud_util::updatebar(var_1.heat);
  var_0["mg_bar"].alpha = 0.24;
  var_0["mg_bar_bar"].alpha = 0.25 + var_1.heat * 0.75;

  if(!isDefined(var_1.heat_warn_toggle)) {
    var_1.heat_warn_toggle = 0;
    var_1.heat_warn_lastoggle = gettime();
  }

  if(!isDefined(var_1.overheated)) {
    var_1.overheated = 0;
  }

  if(var_1.heat > 0.5 && gettime() - var_1.heat_warn_lastoggle >= 100) {
    var_0["mg_warn"].alpha = var_1.heat_warn_toggle;
    var_1.heat_warn_toggle = !var_1.heat_warn_toggle;
    var_1.heat_warn_lastoggle = gettime();
  } else if(!var_1.overheated)
    var_0["mg_warn"].alpha = 0;

  if(var_1.overheated) {
    var_0["mg_bar"] maps\_hud_util::updatebar(var_1.heat);
    var_0["mg_warn"].alpha = 1;
    var_0["mg_bar_bar"].alpha = var_1.heat_warn_toggle;

    if(gettime() - var_1.heat_warn_lastoggle >= 100) {
      var_1.heat_warn_toggle = !var_1.heat_warn_toggle;
      var_1.heat_warn_lastoggle = gettime();
    }
  }
}

hud_update_speed() {
  var_0 = self.vehicle;
  var_1 = self.hud;
  var_2 = var_1["speed"]["number"].lastspeed;
  var_3 = 160;
  var_4 = var_0 vehicle_getspeed();
  var_5 = abs(-400) - abs(-118);
  var_6 = -118 + -1 * max(0, var_4 / var_3 * var_5);
  var_7 = var_5 * 0.04;
  var_6 = var_6 / var_7 * var_7;
  var_6 = int(var_6);
  var_6 = clamp(var_6, -400, -118);
  var_1["speed"]["arrow"] maps\_hud_util::setpoint("LEFT", "BOTTOM", -24, var_6, 0);

  if(var_2 != var_4) {
    var_1["speed"]["number"] setvalue(int(var_4));
    var_1["speed"]["number"].lastspeed = var_4;
  }
}

hud_update_look_meter() {
  var_0 = self.vehicle;
  var_1 = self.hud;
  var_2 = self.owner;
  var_3 = angleclamp180(var_2 getplayerangles()[0]);
  var_4 = 1 - (var_3 - 30) / -60;
  var_5 = abs(-395) - abs(-119);
  var_6 = -119 + -1 * max(0, var_4 * var_5);
  var_6 = int(clamp(var_6, -395, -119));
  var_7 = var_5 * 0.04;
  var_6 = int(var_6 / var_7) * var_7;
  var_1["altitude"]["arrow"] maps\_hud_util::setpoint("RIGHT", "BOTTOM", 33, var_6, 0);
}

_start(var_0) {
  var_1 = self.owner;
  self.pilot_ai notify("LISTEN_start_pilot");
  self.weapon["hydra_lockOn_missile"] thread vehicle_scripts\_apache_player_missile_hydra_and_lockon::_start();

  if(!isplatformweakfillrate()) {
    self.hud_mask_model = spawn("script_model", var_1 getEye());
    self.hud_mask_model setModel("viewmodel_prototype_apache_visor");
    self.hud_mask_model linktoplayerview(var_1, "tag_origin", (7.5, 0, 0.3), (0, 0, 0), 1);
  }

  hud_start();
  thread monitorsaverecentlyloaded();
  thread monitorturretfire();
  thread monitorweaponchange();

  if(var_0) {
    thread monitorads();
  }

  thread monitorthermalvision();
}

isplatformweakfillrate() {
  return !maps\_utility::is_gen4();
}

monitorsaverecentlyloaded() {
  self endon("LISTEN_end_pilot");

  for(;;) {
    if(issaverecentlyloaded()) {
      self.owner notify("SAVGAME_RELEASES_BUTTONS");
      setdvar("ui_deadquote", "");
    }

    wait 0.05;
  }
}

hud_start() {
  maps\_utility::deep_array_thread(self.hud, ::set_key, [1, "alpha"]);
}

turret_init(var_0, var_1) {
  self dontcastshadows();
  self.owner = var_1;
  maps\_utility::ent_flag_set("FLAG_turret_init");
}

monitorturretfire() {
  var_0 = self.owner;
  var_1 = self.vehicle;
  var_2 = var_1.mgturret[0];
  var_0 endon("LISTEN_end_pilot");
  var_2 maps\_utility::ent_flag_wait("FLAG_turret_init");
  childthread monitorturretearthquake();
  childthread monitorturretlookat();
  var_3 = common_scripts\utility::getfx("FX_apache_pilot_turret_projectile");
  var_4 = common_scripts\utility::getfx("FX_apache_pilot_turret_flash_view");
  var_2.heat = 0;
  var_2.overheated = 0;
  var_5 = 0;

  for(;;) {
    if(var_2.overheated) {
      wait 3;
      var_2.heat = 0;
      var_2.overheated = 0;
      var_6 = var_2 maps\_utility::create_blend(::turret_overheat_cool, 1.0, 0);
      var_6.time = 1;
      wait 1;
    }

    var_1 waittill("turret_fire");
    var_2 shootturret();
    var_7 = var_2 gettagangles("tag_flash");
    var_8 = anglesToForward(var_7);
    var_9 = anglestoright(var_7);
    var_10 = anglestoup(var_7);
    var_11 = randomfloatrange(-8, 8);
    var_12 = randomfloatrange(-8, 8);
    playFX(var_3, var_2 gettagorigin("tag_flash") + var_11 * var_9 + var_12 * var_10, var_8);
    playFXOnTag(var_4, var_2, "tag_flash");
    var_2 childthread turret_heat_and_cool();
  }
}

turret_overheat_cool(var_0, var_1, var_2) {
  self.heat = 1 - var_0;
}

turret_heat_and_cool() {
  self.heat = self.heat + 0.01;
  self notify("turret_cool");
  self endon("turret_cool");

  if(self.heat >= 1) {
    self.overheated = 1;
    return;
  }

  wait 0.2;

  while(self.heat >= 0) {
    wait 0.05;
    self.heat = self.heat - 0.02;
  }

  self.heat = 0;
}

monitorturretlookat(var_0, var_1) {
  var_1 = self.owner;
  var_0 = self.vehicle;
  var_2 = var_0.mgturret[0];
  var_3 = var_1 getplayerangles();
  var_4 = var_1 getEye();
  var_5 = anglesToForward(var_3);
  var_6 = 10000;
  var_7 = var_4 + var_6 * var_5;
  var_8 = spawn("script_model", var_7);
  var_8 setModel("tag_origin");
  var_9 = gettime();
  var_2.mytarget = var_8;
  var_2 settargetentity(var_8);

  for(;;) {
    var_3 = var_1 getplayerangles();
    var_5 = anglesToForward(var_3);
    var_10 = var_1 getEye();
    var_11 = var_10 + 512 * var_5;
    var_12 = var_11 + 10000 * var_5;
    var_13 = bulletTrace(var_11, var_12, 0, var_0);
    var_6 = var_13["fraction"] * 10000;
    var_9 = gettime();
    var_8.origin = var_10 + (512 + var_6) * var_5;
    wait 0.05;
  }
}

monitorturretearthquake() {
  var_0 = self.owner;
  var_0 notifyonplayercommand("LISTEN_startTurretFire", "+attack");
  var_0 notifyonplayercommand("LISTEN_stopTurretFire", "-attack");

  for(;;) {
    var_0 waittill("LISTEN_startTurretFire");
    childthread doturretearthquake();
    var_0 childthread player_poll_button_release_and_notify("attack", "LISTEN_stopTurretFire");
    var_0 waittill("LISTEN_stopTurretFire");
  }
}

doturretearthquake() {
  var_0 = self.owner;
  var_0 endon("LISTEN_stopTurretFire");
  wait 0.1;

  for(;;) {
    earthquake(0.1, 0.5, var_0.origin, 512);
    wait 0.1;
  }
}

player_poll_button_release_and_notify(var_0, var_1) {
  self endon("death");
  self endon(var_1);
  waittillframeend;

  for(;;) {
    if(!button_pressed_from_string(var_0)) {
      self notify(var_1);
      break;
    }

    wait 0.05;
  }
}

button_pressed_from_string(var_0) {
  var_4 = undefined;
  var_5 = undefined;

  switch (var_0) {
    case "frag":
      var_4 = ::fragbuttonpressed;
      break;
    case "ads":
      var_4 = ::adsbuttonpressed;
      var_5 = 1;
      break;
    case "attack":
      var_4 = ::attackbuttonpressed;
      break;
    case "melee":
      var_4 = ::meleebuttonpressed;
      break;
    case "use":
      var_4 = ::usebuttonpressed;
      break;
    case "vehicle_attack":
      var_4 = ::vehicleattackbuttonpressed;
      break;
    case "secondary_attack_off_hand":
      var_4 = ::secondaryoffhandbuttonpressed;
      break;
    default:
      break;
  }

  var_6 = undefined;

  if(isDefined(var_5)) {
    var_6 = self call[[var_4]](var_5);
  }
  else {
    var_6 = self call[[var_4]]();
  }

  return var_6;
}

fov_get_default() {
  return 65;
}

fov_get_ads() {
  return 15;
}

monitorads() {
  var_0 = self.owner;
  self endon("LISTEN_end_pilot");
  self.adstoggled = 0;
  self.adszoomed = 0;
  var_1 = 0;
  self.hud["zoom_overlay"].alpha = 0.0;
  thread monitoradshold();
  thread monitoradstoggle();
  var_2 = "LISTEN_apache_player_stop_ADS";
  var_0 endon("death");

  for(;;) {
    var_3 = 0;

    if(self.adszoomed && var_1 && !var_0 adsbuttonpressed()) {
      var_2 = "LISTEN_apache_player_stop_ADS";
      var_3 = 1;
    }

    if(!var_3) {
      var_2 = var_0 common_scripts\utility::waittill_any_return("LISTEN_apache_player_toggle_ADS", "LISTEN_apache_player_start_ADS", "LISTEN_apache_player_stop_ADS", "SAVGAME_RELEASES_BUTTONS");
    }

    if(var_2 == "SAVGAME_RELEASES_BUTTONS") {
      continue;
    }
    var_4 = var_2 == "LISTEN_apache_player_toggle_ADS";
    var_1 = var_2 == "LISTEN_apache_player_start_ADS";
    var_5 = var_2 == "LISTEN_apache_player_stop_ADS";

    if(self.adszoomed) {
      if(self.adstoggled) {
        if(var_4 || var_5) {
          self.adstoggled = 0;
          self.adszoomed = 0;
          monitorads_zoom_out();
        }
      } else if(var_5) {
        monitorads_zoom_out();
        self.adszoomed = 0;
      }

      continue;
    }

    self.adstoggled = 0;

    if(var_4) {
      self.adstoggled = 1;
      self.adszoomed = 1;
      monitorads_zoom_in();
      continue;
    }

    if(var_1) {
      self.adszoomed = 1;
      monitorads_zoom_in();
    }
  }
}

monitoradstoggle() {
  var_0 = self.owner;
  var_0 notifyonplayercommand("LISTEN_apache_player_toggle_ADS", "+sprint_zoom");
  var_0 notifyonplayercommand("LISTEN_apache_player_toggle_ADS", "+sprint");
  var_0 notifyonplayercommand("LISTEN_apache_player_toggle_ADS", "+ads_akimbo_accessible");
  var_0 notifyonplayercommand("LISTEN_apache_player_toggle_ADS", "+toggleads_throw");
}

monitoradshold() {
  var_0 = self.owner;
  var_0 notifyonplayercommand("LISTEN_apache_player_start_ADS", "+speed");
  var_0 notifyonplayercommand("LISTEN_apache_player_start_ADS", "+speed_throw");
  var_0 notifyonplayercommand("LISTEN_apache_player_stop_ADS", "-speed");
  var_0 notifyonplayercommand("LISTEN_apache_player_stop_ADS", "-speed_throw");
}

monitorads_blend_dof(var_0) {
  var_1 = self.owner;
  self notify("monitorADS_blend_dof");
  self endon("monitorADS_blend_dof");
  self endon("LISTEN_end_pilot");

  if(var_0) {
    maps\_art::dof_enable_script(0, 207, 5.4, 70000, 130000, 0.0, 0.15);
    wait 0.15;
    var_1 maps\_utility::ent_flag_set("FLAG_apache_pilot_ADS");
  } else {
    maps\_art::dof_disable_script(0.2);
    var_1 maps\_utility::ent_flag_clear("FLAG_apache_pilot_ADS");
  }
}

monitorads_zoom_elem_offset(var_0, var_1) {
  if(!isDefined(self.xoffset_default)) {
    self.xoffset_default = self.xoffset;
  }

  if(!isDefined(self.yoffset_default)) {
    self.yoffset_default = self.yoffset;
  }

  var_0 = common_scripts\utility::ter_op(isDefined(var_0), var_0, self.xoffset_default);
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, self.yoffset_default);
  maps\_hud_util::setpoint(self.point, self.relativepoint, var_0, var_1);
}

monitorads_zoom_elem_reset() {
  if(isDefined(self.xoffset_default) && isDefined(self.yoffset_default)) {
    maps\_hud_util::setpoint(self.point, self.relativepoint, self.xoffset_default, self.yoffset_default);
    self.xoffset_default = undefined;
    self.yoffset_default = undefined;
  }
}

monitorads_zoom_hud_delay(var_0, var_1) {
  self notify("monitorADS_zoom_overlay_delay");
  self endon("monitorADS_zoom_overlay_delay");
  var_2 = self.vehicle.heli.missiledefense;
  var_3 = self.weapon[self.weapon_curr];

  if(var_0) {
    if(isDefined(var_1)) {
      wait(var_1);
    }

    maps\_utility::deep_array_thread(self.hud, ::set_key, [0.0, "alpha"]);
    self.hud["mg_reticle"].alpha = 1.0;
    self.hud["zoom_overlay"].alpha = 1.0;

    if(isDefined(var_3.hud) && isDefined(var_3.hud["missile_bg"])) {
      var_3.hud["missile_bg"] monitorads_zoom_elem_offset(230, 101);
      var_3.hud["missile_straight_bg"] monitorads_zoom_elem_offset(230, 61);
    }

    if(isDefined(var_2.hud)) {
      if(isDefined(var_2.hud["flares"]) && isDefined(var_2.hud["flares"]["back"])) {
        var_2.hud["flares"]["back"] monitorads_zoom_elem_offset(-230, 101);
      }

      if(isDefined(var_2.hud["warning"]) && isDefined(var_2.hud["warning"]["bg_lock_left"])) {
        var_2.hud["warning"]["bg_lock_left"] monitorads_zoom_elem_offset(-230);
      }

      if(isDefined(var_2.hud["warning"]) && isDefined(var_2.hud["warning"]["bg_lock_right"])) {
        var_2.hud["warning"]["bg_lock_right"] monitorads_zoom_elem_offset(230);
      }
    }

    wait 0.05;
    self.hud["mg_reticle"].alpha = 0.0;
  } else {
    if(isDefined(var_1)) {
      wait(var_1);
    }

    maps\_utility::deep_array_thread(self.hud, ::set_key, [1.0, "alpha"]);

    if(isDefined(var_3.hud) && isDefined(var_3.hud["missile_bg"])) {
      var_3.hud["missile_bg"] monitorads_zoom_elem_reset();
      var_3.hud["missile_straight_bg"] monitorads_zoom_elem_reset();
    }

    if(isDefined(var_2.hud)) {
      if(isDefined(var_2.hud["flares"]) && isDefined(var_2.hud["flares"]["back"])) {
        var_2.hud["flares"]["back"] monitorads_zoom_elem_reset();
      }

      if(isDefined(var_2.hud["warning"]) && isDefined(var_2.hud["warning"]["bg_lock_left"])) {
        var_2.hud["warning"]["bg_lock_left"] monitorads_zoom_elem_reset();
      }

      if(isDefined(var_2.hud["warning"]) && isDefined(var_2.hud["warning"]["bg_lock_right"])) {
        var_2.hud["warning"]["bg_lock_right"] monitorads_zoom_elem_reset();
      }
    }

    wait 0.05;
    self.hud["zoom_overlay"].alpha = 0.0;
  }
}

monitorads_zoom_in() {
  var_0 = self.owner;
  var_0 maps\_utility::lerpfov_saved(15, 0.15);

  if(!maps\_utility::is_coop()) {
    monitorads_blend_dof(1);
  }

  thread monitorads_zoom_hud_delay(1);
}

monitorads_zoom_out() {
  var_0 = self.owner;
  var_0 maps\_utility::lerpfov_saved(65, 0.2);

  if(!maps\_utility::is_coop()) {
    monitorads_blend_dof(0);
  }

  thread monitorads_zoom_hud_delay(0);
}

monitorthermalvision() {
  self endon("LISTEN_end_pilot");
  var_0 = self.owner;
  self.thermal_state = "ON_PULSE";
}

monitorweaponchange() {
  self endon("LISTEN_end_pilot");
  var_0 = self.owner;
  var_1 = [];
  var_2 = 0;

  foreach(var_5, var_4 in self.weapon) {
    var_1[var_1.size] = var_5;

    if(var_5 == self.currentweapon) {
      var_2 = var_1.size - 1;
      activateweapon(var_5);
    }
  }

  var_6 = var_1.size;

  if(var_6 == 1) {
    return;
  }
  var_0 notifyonplayercommand("LISTEN_pilot_weaponSwitch", "weapnext");

  for(;;) {
    var_0 maps\_utility::ent_flag_clear("FLAG_apache_pilot_changed_weapons");
    var_0 waittill("LISTEN_pilot_weaponSwitch");
    var_0 maps\_utility::ent_flag_set("FLAG_apache_pilot_has_changed_weapons");
    var_0 maps\_utility::ent_flag_set("FLAG_apache_pilot_changed_weapons");
    deactivateweapon(self.currentweapon);
    var_2++;
    var_2 = var_2 % var_6;
    self.currentweapon = var_1[var_2];
    activateweapon(self.currentweapon);
    wait 0.1;
  }
}

activateweapon(var_0) {
  switch (var_0) {
    case "hydra_lockOn_missile":
      self.weapon[var_0] vehicle_scripts\_apache_player_missile_hydra_and_lockon::activate();
      break;
    default:
      break;
  }

  self.weapon_curr = var_0;
}

deactivateweapon(var_0) {
  switch (var_0) {
    case "hydra_lockOn_missile":
      self.weapon[var_0] vehicle_scripts\_apache_player_missile_hydra_and_lockon::deactivate();
      break;
    default:
      break;
  }
}

_end() {
  var_0 = self.owner;
  self notify("LISTEN_end_pilot");
  var_0 notify("LISTEN_end_pilot");
  self.pilot_ai notify("LISTEN_end_pilot");
  maps\_utility::deep_array_thread(self.hud, ::set_key, [0, "alpha"]);
  var_0 thermalvisionoff();
  self.weapon["hydra_lockOn_missile"] vehicle_scripts\_apache_player_missile_hydra_and_lockon::_end();
  maps\_art::dof_disable_script(0.2);
}

_destroy() {
  var_0 = self.owner;
  _end();
  var_0 maps\_utility::ent_flag_clear("FLAG_apache_pilot_has_changed_weapons", 1);
  var_0 maps\_utility::ent_flag_clear("FLAG_apache_pilot_changed_weapons", 1);
  var_0 maps\_utility::ent_flag_clear("FLAG_apache_pilot_ADS", 1);
  self.pilot_ai notify("death");
  self notify("LISTEN_destroy_pilot");
  var_0 notify("LISTEN_destroy_pilot");
  maps\_utility::deep_array_call(self.hud, ::destroy);
  self.pilot_ai delete();
  self.vehicle.mgturret[0].mytarget delete();
  self.weapon["hydra_lockOn_missile"] vehicle_scripts\_apache_player_missile_hydra_and_lockon::_destroy();

  if(!isplatformweakfillrate()) {
    self.hud_mask_model delete();
  }
}

set_key(var_0, var_1) {
  if(!isDefined(self) || !isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "alpha":
      self.alpha = var_0;
      break;
  }
}