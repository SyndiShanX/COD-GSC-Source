/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_remoteturret.gsc
*****************************************************/

precache_cam_names(var_0) {
  if(!isDefined(var_0) || !isarray(var_0)) {
    return;
  }
  level._remoteturret_loc_table = var_0;
  var_1 = get_terminals();

  foreach(var_3 in var_1) {
    var_4 = var_3 common_scripts\utility::get_linked_ents();

    foreach(var_6 in var_4) {
      if(isDefined(var_0[var_6.script_startname]))
        precachestring(var_0[var_6.script_startname]);
    }
  }
}

init() {
  precacheshader("uav_crosshair");
  precacheshader("uav_vertical_meter");
  precacheshader("uav_horizontal_meter");
  precacheshader("overlay_grain");
  precacheshader("uav_arrow_up");
  precacheshader("uav_arrow_left");
  precacheshader("ac130_thermal_overlay_bar");
  var_0 = get_terminals();
  common_scripts\utility::array_thread(var_0, ::remote_turret_terminal_think);

  foreach(var_2 in level.players)
  var_2 maps\_utility::ent_flag_init("on_remote_turret");

  common_scripts\utility::flag_init("_remoteturret_manual_getoff");
  common_scripts\utility::flag_init("_remoteturret_nofade");
  common_scripts\utility::flag_set("_remoteturret_manual_getoff");
}

get_terminals() {
  return getEntArray("remote_turret_terminal", "targetname");
}

remote_turret_terminal_think() {
  var_0 = spawn("script_model", self.origin);
  self.trigger = var_0;
  self.lastturretindex = 0;
  self._remote_turrets = common_scripts\utility::get_linked_ents();
  common_scripts\utility::array_thread(self._remote_turrets, ::setup_turret, self);
  var_0.angles = self.angles;
  var_0 setModel("com_laptop_2_open_obj");
  var_0 makeusable();
  var_0 sethintstring(&"PLATFORM_HOLD_TO_USE");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_0 common_scripts\utility::trigger_off();
    var_1 thread maps\_utility::play_sound_on_entity("intelligence_pickup");
    var_1 thread remote_turret_loop(self);
    var_1 waittill("get_off_turret");
    var_0 common_scripts\utility::trigger_on();
  }
}

remote_turret_loop(var_0) {
  self endon("transfer_terminal");

  if(common_scripts\utility::flag("_remoteturret_manual_getoff"))
    self notifyonplayercommand("get_off_turret", "+stance");

  if(var_0._remote_turrets.size > 1)
    thread turret_switch_input_loop(var_0);

  thread remote_turret_enable(var_0._remote_turrets[var_0.lastturretindex], var_0);
  thread cancel_on_player_damage();
  self waittill("get_off_turret");
  thread remote_turret_disable(var_0._remote_turrets[var_0.lastturretindex], var_0);
  maps\_utility::ent_flag_waitopen("on_remote_turret");
}

turret_switch_input_loop(var_0) {
  self endon("no_switching_allowed");
  self endon("get_off_turret");
  self notifyonplayercommand("next_turret", "weapnext");
  waittillframeend;

  for(;;) {
    self waittill("next_turret");

    if(maps\_utility::ent_flag("on_remote_turret"))
      remote_turret_next(var_0);
  }
}

setup_turret(var_0) {
  var_1 = self;
  var_1 makeunusable();
  var_1.issentrygun = 1;

  if(isDefined(var_1.target)) {
    var_2 = var_1 common_scripts\utility::get_target_ent();
    var_1.last_look_origin = var_2.origin;
  }

  if(!isDefined(var_1.leftarc))
    var_1.leftarc = 70;

  if(!isDefined(var_1.rightarc))
    var_1.rightarc = 70;

  if(!isDefined(var_1.toparc))
    var_1.toparc = 60;

  if(!isDefined(var_1.bottomarc))
    var_1.bottomarc = 60;

  var_1 setrightarc(var_1.rightarc);
  var_1 setleftarc(var_1.rightarc);
  var_1 settoparc(var_1.toparc);
  var_1 setbottomarc(var_1.bottomarc);
  var_1.terminal = var_0;
  var_1.turret = spawnturret("misc_turret", var_1.origin, var_1.weaponinfo);
  var_1.turret.angles = var_1.angles;
  var_1.turret setModel(var_1.model);
  var_1.turret hide();
  var_1.turret makeunusable();
  var_1.turret setdefaultdroppitch(0);
}

player_turret_shoot(var_0) {
  var_0 endon("stop_use_turret");

  for(;;) {
    while(!self attackbuttonpressed())
      wait 0.05;

    var_0 shootturret();
    var_0 notify("create_badplace");
    wait 0.05;
  }
}

player_look_aim(var_0, var_1) {
  var_0 endon("stop_use_turret");
  var_2 = getaiarray("axis");
  var_3 = var_0 gettagorigin("tag_player");
  var_0 setmode("manual");
  var_0 settargetentity(var_1);

  for(;;) {
    var_4 = self getplayerangles();
    var_5 = anglesToForward(var_4);
    var_6 = var_3 + var_5 * 999999;
    var_1.origin = var_6;
    var_0.last_look_origin = var_6;
    wait 0.1;
  }
}

remote_turret_enable(var_0, var_1) {
  self endon("get_off_turret");
  var_0.attacker = self;
  var_0.owner = self;
  var_0 setsentryowner(self);
  self freezecontrols(1);
  self.oldangles = self getplayerangles();
  self disableweapons();
  holdstancechange(0);
  rt_fade_out();
  self thermalvisionon();
  self remotecamerasoundscapeon();
  text_titlecreate();
  maps\_utility::ent_flag_set("on_remote_turret");
  huditemshide();
  thread turret_activate(var_0, var_1);
  rt_fade_in();
  self freezecontrols(0);
}

remote_turret_disable(var_0, var_1) {
  var_0.attacker = undefined;
  var_0.owner = undefined;
  self setsentryowner(undefined);
  maps\_utility::ent_flag_clear("on_remote_turret");

  if(!common_scripts\utility::flag("_remoteturret_nofade"))
    rt_fade_out();

  turret_deactivate(var_0, var_1);
  self enableweapons();
  self thermalvisionoff();
  self remotecamerasoundscapeoff();
  self setplayerangles(self.oldangles);
  holdstancechange(1);
  huditemsshow();
  text_titledestroy();

  if(!common_scripts\utility::flag("_remoteturret_nofade"))
    rt_fade_in();
}

remote_turret_next(var_0) {
  maps\_utility::ent_flag_clear("on_remote_turret");
  self endon("get_off_turret");

  if(!common_scripts\utility::flag("_remoteturret_nofade"))
    rt_fade_out();

  turret_deactivate(var_0._remote_turrets[var_0.lastturretindex], var_0);
  var_0.lastturretindex = var_0.lastturretindex + 1;
  var_0.lastturretindex = var_0.lastturretindex % var_0._remote_turrets.size;
  thread turret_activate(var_0._remote_turrets[var_0.lastturretindex], var_0);

  if(!common_scripts\utility::flag("_remoteturret_nofade"))
    rt_fade_in();

  maps\_utility::ent_flag_set("on_remote_turret");
}

turret_activate(var_0, var_1) {
  if(isDefined(level._remoteturret_loc_table) && isDefined(var_0.script_startname) && isDefined(level._remoteturret_loc_table[var_0.script_startname]))
    text_titlesettext(level._remoteturret_loc_table[var_0.script_startname]);
  else
    text_titlesettext("CAMERA: " + (var_1.lastturretindex + 1));

  var_0 hideonclient(self);
  uav_enable_view();
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = var_0 gettagangles("tag_origin");

  if(isDefined(var_0.last_look_origin))
    var_3 = vectortoangles(var_0.last_look_origin - var_0.origin);

  self setplayerangles((var_3[0], var_3[1], self.angles[2]));
  self playerlinkto(var_0, "tag_player", 0, var_0.rightarc * 0.9, var_0.leftarc * 0.9, var_0.toparc * 0.9, var_0.bottomarc * 0.9);
  var_0 turretfireenable();
  var_0 makeusable();
  var_0 useby(self);
  var_0 makeunusable();
  self disableturretdismount();
  var_2 delete();
}

turret_deactivate(var_0, var_1) {
  uav_disable_view();
  var_0 turretfiredisable();
  var_0 stopfiring();
  wait 0.1;
  self unlink();
  self enableturretdismount();
  var_0 makeusable();
  var_0 useby(self);
  var_0 makeunusable();
  var_0 notify("stop_use_turret");
  var_0 showonclient(self);
}

remote_turret_badplace(var_0, var_1) {
  var_0 endon("stop_use_turret");

  for(;;) {
    var_0 waittill("create_badplace");
    var_2 = var_0 gettagorigin("tag_flash");
    var_3 = var_0 gettagangles("tag_flash");
    var_4 = var_2 + anglesToForward(var_3) * 9999;
    var_5 = bulletTrace(var_2, var_4, 0);
    badplace_cylinder("bullet_impact", 1, var_5["position"], 256, 96, "axis");
    wait 1;
  }
}

rt_fade_in() {
  if(level.missionfailed) {
    return;
  }
  level notify("now_fade_in");
  wait 0.05;
  var_0 = get_white_overlay();
  var_0 fadeovertime(0.2);
  var_0.alpha = 0;
  wait 0.3;
}

rt_fade_out() {
  var_0 = get_white_overlay();
  var_0 fadeovertime(0.2);
  var_0.alpha = 1;
  wait 0.2;
}

get_white_overlay() {
  if(!isDefined(self.white_overlay))
    self.white_overlay = maps\_hud_util::create_client_overlay("white", 0, self);

  self.white_overlay.sort = -1;
  self.white_overlay.foreground = 0;
  return self.white_overlay;
}

huditemshide() {
  if(level.players.size > 0) {
    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      if(level.players[var_0] maps\_utility::ent_flag("on_remote_turret"))
        setdvar("ui_remotemissile_playernum", var_0 + 1);
    }
  } else {
    setsaveddvar("compass", "0");
    setsaveddvar("ammoCounterHide", "1");
    setsaveddvar("actionSlotsHide", "1");
  }
}

huditemsshow() {
  if(level.players.size > 0)
    setdvar("ui_remotemissile_playernum", 0);
  else {
    setsaveddvar("compass", "1");
    setsaveddvar("ammoCounterHide", "0");
    setsaveddvar("actionSlotsHide", "0");
  }
}

holdstancechange(var_0) {
  if(!var_0) {
    var_1 = self getstance();

    if(var_1 != "prone")
      self allowprone(var_0);

    if(var_1 != "crouch")
      self allowcrouch(var_0);

    if(var_1 != "stand") {
      self allowstand(var_0);
      return;
    }
  } else {
    self allowprone(var_0);
    self allowcrouch(var_0);
    self allowstand(var_0);
  }
}

uav_enable_view(var_0, var_1) {
  level.uav_sort = -5;
  level.uav_hud_color = (1, 1, 1);
  self.uav_huds = [];
  self.uav_huds["static_hud"] = create_hud_static_overlay(var_0);
  self.uav_huds["scanline"] = create_hud_scanline_overlay(var_0);
  self.uav_huds["crosshair"] = create_hud_crosshair(var_0);
  setsaveddvar("sm_sunsamplesizenear", "1");
  setsaveddvar("sm_cameraoffset", "3400");
  thread uav_hud_scanline();
}

hud_fade_in_time(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_1))
    var_1 = 1;

  self.alpha = 0;
  self fadeovertime(var_0);
  self.alpha = var_1;
  return 1;
}

create_hud_static_overlay(var_0) {
  var_1 = maps\_hud_util::create_client_overlay("overlay_grain", 0.3, self);
  var_1.sort = level.uav_sort;

  if(!var_1 hud_fade_in_time(var_0, 0.3))
    var_1.alpha = 0.3;

  return var_1;
}

create_hud_scanline_overlay(var_0) {
  var_1 = maps\_hud_util::create_client_overlay("ac130_thermal_overlay_bar", 1, self);
  var_1.x = 0;
  var_1.y = 0;
  var_1.sort = level.uav_sort + 1;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";

  if(!var_1 hud_fade_in_time(var_0, 1))
    var_1.alpha = 1;

  return var_1;
}

create_hud_horizontal_meter(var_0) {
  var_1 = newhudelem();
  var_1.x = 320;
  var_1.y = 40;
  var_1.sort = level.uav_sort;
  var_1.alignx = "center";
  var_1.aligny = "bottom";
  var_1.color = level.uav_hud_color;
  var_1 setshader("uav_horizontal_meter", 96, 16);
  var_1 hud_fade_in_time(var_0);
  return var_1;
}

create_hud_vertical_meter(var_0) {
  var_1 = newhudelem();
  var_1.x = 40;
  var_1.y = 240;
  var_1.sort = level.uav_sort;
  var_1.alignx = "right";
  var_1.aligny = "middle";
  var_1.color = level.uav_hud_color;
  var_1 setshader("uav_vertical_meter", 16, 96);
  var_1 hud_fade_in_time(var_0);
  return var_1;
}

create_hud_crosshair(var_0) {
  var_1 = maps\_hud_util::createclienticon("uav_crosshair", 320, 240);
  var_1.sort = level.uav_sort;
  var_1.elemtype = "icon";
  var_1 maps\_hud_util::setparent(level.uiparent);
  var_1 maps\_hud_util::setpoint("CENTER", undefined, 0, 0);
  var_1 hud_fade_in_time(var_0);
  return var_1;
}

uav_set_target_hud_data(var_0, var_1) {
  self.uav_huds["lower_right"][var_0].data_value setvalue(var_1);
}

uav_set_hud_data(var_0, var_1) {
  self.uav_huds[var_0].data_value setvalue(var_1);
}

create_hud_upper_left(var_0) {
  var_1 = [];
  var_1["nar"] = [ &"UAV_NAR", "none"];
  var_1["white"] = [ &"UAV_WHT", "none"];
  var_1["rate"] = [ &"UAV_RATE", "none"];
  var_1["angle"] = [ &"UAV_RATIO", "none"];
  var_1["numbers"] = [ &"UAV_ABOVE_TEMP_NUMBERS", "none"];
  var_1["temp"] = [ &"UAV_TEMP", "none"];
  return create_hud_section(var_1, 10, 80, "left", var_0);
}

create_hud_upper_right(var_0) {
  var_1 = [];
  var_1["acft"] = [ &"UAV_ACFT", "none"];
  var_1["long"] = [ &"UAV_N", "none"];
  var_1["lat"] = [ &"UAV_W", "none"];
  var_1["angle"] = [ &"UAV_HAT", "none"];
  return create_hud_section(var_1, 510, 80, "left", var_0);
}

create_hud_lower_right(var_0) {
  var_1 = [];
  var_1["long"] = [ &"UAV_N", "none"];
  var_1["lat"] = [ &"UAV_W", "none"];
  var_2 = create_hud_section(var_1, 500, 335, "left", var_0);
  var_1 = [];
  var_1["brg"] = [ &"UAV_BRG", ""];
  var_1["rng_m"] = [ &"UAV_RNG", &"UAV_M"];
  var_1["rng_nm"] = [ &"UAV_RNG", &"UAV_NM"];
  var_1["elv"] = [ &"UAV_ELV", &"UAV_F"];
  var_3 = create_hud_section(var_1, 510, 360, "right", var_0);

  foreach(var_6, var_5 in var_3)
  var_2[var_6] = var_5;

  return var_2;
}

create_hud_section(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = 10 * level.uav_fontscale;

  foreach(var_10, var_8 in var_0) {
    var_9 = newhudelem();
    var_9.x = var_1;
    var_9.y = var_2;
    var_9.sort = level.uav_sort;
    var_9.alignx = var_3;
    var_9.aligny = "middle";
    var_9.fontscale = level.uav_fontscale;
    var_9.color = level.uav_hud_color;
    var_9 settext(var_8[0]);

    if(isDefined(var_8[1])) {
      if(!string_is_valid(var_8[1], "none"))
        var_9 create_hud_data_value(var_8[1], var_4);
    } else
      var_9 create_hud_data_value(undefined, var_4);

    var_9 hud_fade_in_time(var_4);
    var_5[var_10] = var_9;
    var_2 = var_2 + var_6;
  }

  return var_5;
}

string_is_valid(var_0, var_1) {
  if(isstring(var_0)) {
    if(var_0 == var_1)
      return 1;
  }

  return 0;
}

create_hud_data_value(var_0, var_1) {
  var_2 = 75;

  if(isDefined(var_0) && !string_is_valid(var_0, "")) {
    var_3 = newhudelem();
    var_3.x = self.x + var_2;
    var_3.y = self.y;
    var_3.alignx = "right";
    var_3.aligny = "middle";
    var_3.fontscale = level.uav_fontscale;
    var_3.color = level.uav_hud_color;
    var_3.sort = level.uav_sort;
    var_3 settext(var_0);
    self.data_value_suffix = var_3;
    var_4 = 1;

    if(var_0 == &"UAV_NM")
      var_4 = 2;

    var_3 hud_fade_in_time(var_1);
    var_2 = var_2 - 10 * var_4;
  }

  var_5 = newhudelem();
  var_5.x = self.x + var_2;
  var_5.y = self.y;
  var_5.alignx = "right";
  var_5.aligny = "middle";
  var_5.fontscale = level.uav_fontscale;
  var_5.color = level.uav_hud_color;
  var_5.sort = level.uav_sort;
  var_5 setvalue(0);
  var_5 hud_fade_in_time(var_1);
  self.data_value = var_5;
}

create_hud_arrow(var_0, var_1) {
  if(var_0 == "up") {
    var_2 = "uav_arrow_up";
    var_3 = self.uav_huds["horz_meter"];
    var_4 = 320;
    var_5 = var_3.y + 10;
    var_6 = "center";
    var_7 = "top";
  } else {
    var_2 = "uav_arrow_left";
    var_3 = self.uav_huds["vert_meter"];
    var_4 = var_3.x + 10;
    var_5 = 240;
    var_6 = "left";
    var_7 = "middle";
  }

  var_8 = newhudelem();
  var_8.x = var_4;
  var_8.y = var_5;
  var_8.alignx = var_6;
  var_8.aligny = var_7;
  var_8.sort = level.uav_sort;
  var_8 setshader(var_2, 16, 16);
  var_8 hud_fade_in_time(var_1);
  var_8 create_hud_arrow_value(var_0, var_1);
  return var_8;
}

create_hud_arrow_value(var_0, var_1) {
  if(var_0 == "up") {
    var_2 = self.x;
    var_3 = self.y + 16;
    var_4 = "center";
    var_5 = "top";
  } else {
    var_2 = self.x + 16;
    var_3 = self.y;
    var_4 = "left";
    var_5 = "middle";
  }

  var_6 = newhudelem();
  var_6.x = var_2;
  var_6.y = var_3;
  var_6.alignx = var_4;
  var_6.aligny = var_5;
  var_6.sort = level.uav_sort;
  var_6 setvalue(0);
  var_6 hud_fade_in_time(var_1);
  self.data_value = var_6;
}

uav_disable_view(var_0) {
  if(isDefined(self.uav_huds)) {
    foreach(var_2 in self.uav_huds) {
      if(isarray(var_2)) {
        foreach(var_4 in var_2)
        uav_destroy_hud(var_4, var_0);

        var_2 = undefined;
        continue;
      }

      uav_destroy_hud(var_2, var_0);
    }
  }

  if(!isDefined(var_0))
    var_0 = 0.05;

  setsaveddvar("sm_sunenable", 1.0);
}

uav_destroy_hud(var_0, var_1) {
  if(isDefined(var_0.data_value))
    var_0.data_value thread uav_destroy_hud_wrapper(var_1);

  if(isDefined(var_0.data_value_suffix))
    var_0.data_value_suffix thread uav_destroy_hud_wrapper(var_1);

  var_0 thread uav_destroy_hud_wrapper(var_1);
}

uav_destroy_hud_wrapper(var_0) {
  if(isDefined(var_0)) {
    self fadeovertime(var_0);
    self.alpha = 0;
    wait(var_0);
  }

  if(isDefined(self))
    self destroy();
}

text_titlecreate() {
  level.text1 = maps\_hud_util::createclientfontstring("objective", 2.0);
  level.text1 maps\_hud_util::setpoint("TOP", undefined, 0, 10);
}

text_titlesettext(var_0) {
  level.text1 settext(var_0);
}

text_titlefadeout() {
  level.text1 fadeovertime(0.25);
  level.text1.alpha = 0;
}

text_titledestroy() {
  if(!isDefined(level.text1)) {
    return;
  }
  level.text1 destroy();
  level.text1 = undefined;
}

cancel_on_player_damage() {
  self endon("get_off_turret");
  self.took_damage = 0;
  common_scripts\utility::waittill_any("damage", "dtest", "force_out_of_uav");
  self.took_damage = 1;
  self notify("get_off_turret");
}

uav_hud_scanline() {
  var_0 = self.uav_huds["scanline"];

  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  var_1 = 80;
  var_2 = 280;
  var_3 = 7;
  var_4 = 15;
  var_5 = -100;
  var_6 = 580;

  for(;;) {
    var_0.y = var_5;
    var_7 = randomintrange(var_1, var_2);
    var_0 setshader("ac130_thermal_overlay_bar", 640, var_7);
    var_8 = randomfloatrange(var_3, var_4);
    var_0 moveovertime(var_8);
    var_0.y = var_6;
    wait(var_8);
  }
}

transfer_to_new_terminal(var_0, var_1) {
  common_scripts\utility::flag_set("_remoteturret_nofade");
  maps\_utility::ent_flag_clear("on_remote_turret");
  self notify("no_switching_allowed");
  rt_fade_out();
  turret_deactivate(var_0 get_active_turret());
  self notify("transfer_terminal");
  self notify("get_off_turret");
  text_titledestroy();
  thread remote_turret_loop(var_1);
  rt_fade_in();
  maps\_utility::ent_flag_set("on_remote_turret");
  common_scripts\utility::flag_clear("_remoteturret_nofade");
}

get_active_turret() {
  return self._remote_turrets[self.lastturretindex];
}