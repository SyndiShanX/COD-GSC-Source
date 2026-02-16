/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_a10.gsc
*****************************************************/

init_a10() {
  precachemodel("vehicle_a10_warthog_iw6");
  precachemodel("pose_fed_army_stand_idle");
  precacheitem("a10_30mm_player_homecoming");
  precacheitem("remote_tablet");
  precacheitem("AGM_65");
  precacheshader("overlay_grain");
  precacheshader("overlay_static");
  precacheshader("dogcam_edge");
  precacheshader("dogcam_center");
  precacheshader("torpedo_horizonline");
  precacheshader("torpedo_centerline");
  precacheshader("torpedo_center");
  precacheshader("hud_fofbox_self_sp");
  precacheshader("dogcam_target");
  precacheshader("remote_chopper_hud_target_hit");
  precacheshader("apache_target_vehicle");
  precacheshader("dogcam_bracket_l");
  precacheshader("dogcam_bracket_r");
  precacheshader("apache_warn_lock_left");
  precacheshader("apache_warn_lock_right");
  precacheshader("apache_warn_incoming_left");
  precacheshader("apache_warn_incoming_right");
  precacheshader("dpad_killstreak_a10_support_static");
  precacheshader("dpad_killstreak_a10_support_inactive");
  precacheshellshock("homecoming_a10");
  precacheshellshock("nosound");
  precacherumble("ac130_25mm_fire");
  setsaveddvar("r_hudoutlineenable", 1);
  setsaveddvar("r_hudoutlineWidth", 2);
  setsaveddvar("r_hudOutlineWhen", 0);
  setsaveddvar("cg_cinematicFullScreen", "0");
  level.a10_mechanic_skip_end = undefined;
  level.a10_mechanic_ambient_dialogue_off = undefined;
  level.a10_mechanic_skip_end_vo = undefined;
  level.strafetargetvehicles = [];
  level.strafevehicles = [];
  level.enemydeathicons = 0;
  level.strafecooldown = 10000;
  level.a10_total_killed_enemies = 0;
  level._effect["a10_engineeffect"] = loadfx("fx/fire/a10_warthog_afterburner");
  level._effect["a10_afterburner"] = loadfx("fx/fire/a10_warthog_afterburner_ignite");
  level._effect["a10_contrail"] = loadfx("fx/smoke/jet_contrail");
  level._effect["a10_sonicboom"] = loadfx("fx/smoke/a10_warthog_sonic_boom");
  level._effect["a10_muzzle_flash"] = loadfx("fx/_requests/homecoming/a10_muzzle_flash");
  level._effect["a10_player_tracer"] = loadfx("fx/misc/f15_20mm_tracer_close_ac130");
  level._effect["a10_tracer"] = loadfx("fx/misc/f15_20mm_tracer_ac130");
  level._effect["a10_impact"] = loadfx("vfx/moments/homecoming/vfx_a10_exp_dirt_impact");
  level._effect["a10_clouds"] = loadfx("fx/weather/cloud_tunnel");
  level._effect["flying_face_fx"] = loadfx("fx/weather/flying_particulates");
  level._effect["a10_shellejects"] = loadfx("fx/shellejects/a10_shell");
  common_scripts\utility::flag_init("player_not_doing_strafe");
  common_scripts\utility::flag_init("used_a10_strafe");
  common_scripts\utility::flag_init("player_inside_a10");
  common_scripts\utility::flag_init("player_strafe_done");
  common_scripts\utility::flag_init("a10_strafe_complete");
  common_scripts\utility::flag_init("a10_allow_target_elements");
  common_scripts\utility::flag_init("FLAG_player_used_a10_30mm");
  common_scripts\utility::flag_init("FLAG_allow_a10_strafe_crash");
  common_scripts\utility::flag_init("a10_mechanic_off");
  common_scripts\utility::flag_init("a10_achievement_achieved");
  maps\_utility::add_hint_string("hint_a10", &"HOMECOMING_HINT_USE_A10_MECHANIC", ::a10_hint_func);
  maps\_utility::add_hint_string("hint_a10_fire", &"HOMECOMING_HINT_A10_FIRE", ::a10_fire_hint_func);
  common_scripts\utility::flag_set("player_not_doing_strafe");
  common_scripts\utility::array_thread(getEntArray("strafe_fov_trig", "targetname"), ::a10_fov_trig);
  level._effect["contrail"] = loadfx("fx/smoke/jet_contrail");
}

a10_mechanic_off(var_0) {
  if(!common_scripts\utility::flag("player_not_doing_strafe"))
    common_scripts\utility::flag_wait("player_not_doing_strafe");

  common_scripts\utility::flag_set("a10_mechanic_off");
  level notify("A10_MECHANIC_OFF");

  if(isDefined(var_0) && var_0)
    level.player setweaponhudiconoverride("actionslot1", "none");
  else
    level.player setweaponhudiconoverride("actionslot1", "dpad_killstreak_a10_support_inactive");

  level.a10_mechanic_skip_end = undefined;
  level.a10_mechanic_skip_end_vo = undefined;
  level.a10_mechanic_ambient_dialogue_off = undefined;
  level.skipa10endfade = undefined;
  level.a10_uses = undefined;
}

a10_strafe_mechanic(var_0, var_1, var_2, var_3) {
  level endon("A10_MECHANIC_OFF");
  level.player endon("death");
  level.player notifyonplayercommand("BEGIN_A10_STRAFE", "+actionslot 1");
  var_4 = getEntArray(var_0, "targetname");

  if(var_4.size > 1) {
    var_5 = maps\_utility::array_index_by_script_index(var_4);

    if(var_5.size > 0)
      var_4 = var_5;
  }

  common_scripts\utility::flag_clear("a10_mechanic_off");
  level.a10_uses = 0;
  var_6 = 0;

  for(;;) {
    thread a10_strafe_use_nag();
    level.player setweaponhudiconoverride("actionslot1", "dpad_killstreak_a10_support_static");
    common_scripts\utility::flag_clear("used_a10_strafe");

    if(level.a10_uses == 0)
      maps\_utility::display_hint("hint_a10");
    else
      thread a10_delayed_hint();

    level.player waittill("BEGIN_A10_STRAFE");

    if(level.player ismeleeing()) {
      continue;
    }
    if(level.player isthrowinggrenade()) {
      continue;
    }
    if(common_scripts\utility::flag("player_mounting_chaingun_turret")) {
      continue;
    }
    if(isDefined(level.player.using_ammo_cache)) {
      continue;
    }
    common_scripts\utility::flag_set("used_a10_strafe");
    common_scripts\utility::flag_clear("player_not_doing_strafe");

    if(!isDefined(var_4[var_6]))
      var_6 = 0;

    var_7 = var_4[var_6];
    var_6++;
    thread a10_warthog_strafe(var_7, var_1, var_2, var_3);
    common_scripts\utility::flag_clear("a10_strafe_complete");
    common_scripts\utility::flag_wait("a10_strafe_complete");
    common_scripts\utility::flag_set("player_not_doing_strafe");
    common_scripts\utility::flag_clear("player_inside_a10");
    common_scripts\utility::flag_clear("a10_allow_target_elements");
    level.player setweaponhudiconoverride("actionslot1", "dpad_killstreak_a10_support_inactive");
    a10_strafe_repositioning();
  }
}

a10_delayed_hint() {
  level.player endon("BEGIN_A10_STRAFE");
  wait 10;
  maps\_utility::display_hint("hint_a10");
}

a10_strafe_get_location_spawner() {
  var_0 = getEntArray("player_a10_location_check", "targetname");

  foreach(var_2 in var_0) {
    if(level.player istouching(var_2))
      return var_2.script_noteworthy;
  }
}

a10_strafe_use_nag() {
  level endon("A10_MECHANIC_OFF");
  level.player endon("BEGIN_A10_STRAFE");
  var_0 = ["homcom_hsh_thedronesareready", "homcom_hsh_a10dronesarein", "homcom_hsh_takecontrolofthe"];
  var_1 = var_0;

  for(;;) {
    var_2 = common_scripts\utility::random(var_1);
    wait(randomintrange(4, 5));
    level.hesh maps\_utility::generic_dialogue_queue(var_2, 0.05);
    var_1 = common_scripts\utility::array_remove(var_0, var_2);
  }
}

a10_strafe_repositioning() {
  level endon("A10_MECHANIC_OFF");
  thread a10_strafe_respotioning_dialogue();
  var_0 = gettime();

  while(gettime() - var_0 < level.strafecooldown)
    wait 0.05;

  level.player notify("a10_strafe_cooldown_done");
}

a10_strafe_respotioning_dialogue() {
  level endon("A10_MECHANIC_OFF");
  level.player endon("a10_strafe_cooldown_done");

  for(;;) {
    level.player waittill("BEGIN_A10_STRAFE");
    maps\_utility::smart_radio_dialogue("homcom_dcon_dronesarestill", 0.05);
    wait 1;
  }
}

a10_warthog_strafe(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  var_4 = undefined;
  var_5 = [level.balcony_turret, level.ground_turret];

  if(level.player isusingturret()) {
    var_4 = level.balcony_turret;

    if(!isDefined(level.balcony_turret))
      var_4 = level.ground_turret;

    var_4.setturretusable = 0;
    level.player notify("turret_dismount");

    while(common_scripts\utility::flag("player_on_chaingun_turret"))
      wait 0.05;
  }

  foreach(var_4 in var_5) {
    if(isDefined(var_4.destroyed)) {
      continue;
    }
    level.player maps\_chaingun_player::chaingun_turret_disable(var_4);
  }

  level.player.a10_lastweapon = level.player getcurrentweapon();
  setDvar("hideHudFast", 1);
  setsaveddvar("ammoCounterHide", 1);
  level.player.dont_allow_ammo_cache = 1;
  level.player disableweaponswitch();
  level.player disableweaponpickup();
  level.player allowmelee(0);
  level.player giveweapon("remote_tablet");
  level.player switchtoweapon("remote_tablet");
  level.player.a10_grenades = [];
  var_8 = level.player getweaponslistoffhands();

  foreach(var_11, var_10 in var_8) {
    level.player.a10_grenades[var_11] = spawnStruct();
    level.player.a10_grenades[var_11].type = var_10;
    level.player.a10_grenades[var_11].ammo = level.player getweaponammoclip(var_10);
    level.player takeweapon(var_10);
  }

  level.player thread maps\_utility::play_sound_on_entity("a10_tablet_take_out");
  cinematicingameloop("a10tabletin");
  common_scripts\utility::noself_delaycall(4, ::stopcinematicingame);
  wait 1.5;
  var_12 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_12.foreground = 1;
  var_12 maps\_hud_util::fade_over_time(1, 0.4);
  wait 0.1;
  maps\homecoming_util::hud_hide();
  level.player disableweapons();
  level.player allowsprint(0);
  level.player allowjump(0);
  level.player enableinvulnerability();
  level.player maps\_utility::set_vision_set("homecoming_a10", 0);
  level.player enableslowaim(0.8, 0.5);
  thread maps\_utility::battlechatter_off();

  if(maps\_utility::is_gen4())
    level.player lerpfov(70, 0.05);
  else
    level.player lerpfov(55, 0.05);

  var_13 = getaiarray("allies");

  foreach(var_15 in var_13)
  var_15.no_friendly_fire_penalty = 1;

  var_17 = level.drones["allies"].array;

  foreach(var_19 in var_17)
  var_19.no_friendly_fire_penalty = 1;

  common_scripts\utility::flag_clear("player_strafe_done");

  if(level.a10_uses == 0 || !common_scripts\utility::flag("FLAG_player_used_a10_30mm"))
    maps\_utility::display_hint("hint_a10_fire");

  var_21 = a10_player_init(var_0, var_1);
  var_22 = [];
  var_23 = [];
  var_24 = var_21 common_scripts\utility::get_linked_ents();

  foreach(var_26 in var_24) {
    if(var_26 maps\homecoming_util::parameters_check("end_strafe")) {
      if(!isspawner(var_26)) {
        continue;
      }
      var_23[var_23.size] = var_26;
      continue;
    }

    if(var_26 maps\homecoming_util::parameters_check("squadron")) {
      var_27 = var_26 maps\_utility::spawn_vehicle();
      var_27 thread a10_squadron_logic();
      var_27 thread a10_squadron_friendlyfire_watcher();
      var_22[var_22.size] = var_27;

      if(isDefined(var_2))
        thread[[var_2]](var_27);
    }
  }

  var_23 = maps\_utility::array_index_by_script_index(var_23);
  var_22[var_22.size] = var_21;
  var_21 thread a10_target_logic();
  var_21 thread a10_allies_friendlyfire_watcher();
  var_21 thread a10_ambient_clouds();
  wait 0.65;
  level.player common_scripts\utility::delaycall(0.35, ::freezecontrols, 0);

  foreach(var_27 in var_22)
  thread maps\_vehicle::gopath(var_27);

  level.player stopshellshock();
  var_12 thread maps\_hud_util::fade_over_time(0, 0.2);
  common_scripts\utility::flag_set("a10_allow_target_elements");
  thread a10_strafe_dialogue();
  common_scripts\utility::flag_wait("player_strafe_done");
  var_5 = [level.balcony_turret, level.ground_turret];

  foreach(var_4 in var_5) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.destroyed)) {
      continue;
    }
    var_4 thread maps\_chaingun_player::chaingun_turret_init(1);
  }

  var_13 = getaiarray("allies");

  foreach(var_15 in var_13)
  var_15.no_friendly_fire_penalty = undefined;

  var_17 = level.drones["allies"].array;

  foreach(var_19 in var_17)
  var_19.no_friendly_fire_penalty = undefined;

  var_21 a10_strafe_cleanup(var_12, var_22, var_4, var_3);
  level notify("player_strafe_cleanup_done");
  level.a10_uses++;

  if(isDefined(level.a10_mechanic_skip_end)) {
    common_scripts\utility::flag_set("a10_strafe_complete");
    level notify("a10_mechachanic_skip_end");
    return;
  }

  wait(randomfloatrange(0, 0.5));
  var_37 = 0;

  foreach(var_0 in var_23) {
    var_39 = undefined;
    var_40 = var_0 maps\_utility::get_linked_structs();

    foreach(var_42 in var_40) {
      if(var_42 maps\homecoming_util::parameters_check("a10_end_target"))
        var_39 = var_42;
    }

    var_27 = var_0 maps\_utility::spawn_vehicle();
    var_27 thread maps\_utility::play_sound_on_entity("a10_strafe_roar");
    var_27 thread a10_endrun_shooting(var_39);
    var_27 thread a10_endrun_flyby_sound();
    thread maps\_vehicle::gopath(var_27);
    var_44 = 1.5;
    var_37 = 0.5;
  }

  common_scripts\utility::flag_set("a10_strafe_complete");
}

a10_strafe_cleanup(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    thread[[var_3]](self);

  if(!isDefined(level.skipa10endfade))
    var_0 thread maps\_hud_util::fade_over_time(1, 0.3);

  wait 0.3;
  level.player notify("player_warthog_finished");
  a10_player_hud_cleanup();
  level.player freezecontrols(1);
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player lerpfov(65, 0.05);
  level.player unlink();
  self.linker delete();
  level.player thread common_scripts\utility::stop_loop_sound_on_entity("a10p_jet_whine");
  level.player clearclienttriggeraudiozone(0);

  foreach(var_5 in var_1) {
    if(isDefined(var_5.firing_sound_ent))
      var_5.firing_sound_ent thread maps\_utility::sound_fade_and_delete(0.05);

    var_5 hudoutlinedisable();
    var_5 delete();
  }

  maps\_utility::teleport_player(level.player.a10endposition);
  level.player setstance(level.player.a10endstance);
  wait 0.1;
  level.player.a10fakeplayer maps\homecoming_util::delete_safe();
  maps\_utility::array_delete(level.fakea10ai["allies"]);
  maps\homecoming_util::cinematicmode_off(1);
  level.player maps\_utility::set_vision_set("", 0);
  level.player disableslowaim();
  level.player disableinvulnerability();
  level.player stopshellshock();
  level.player freezecontrols(0);
  maps\_utility::battlechatter_on();

  if(!isDefined(level.skipa10endfade)) {
    var_0 thread maps\_hud_util::fade_over_time(0, 0.3);
    var_0 common_scripts\utility::delaycall(0.3, ::destroy);
  }

  level.player thread maps\_utility::play_sound_on_entity("a10_tablet_put_away");

  if(isDefined(level.lasta10cinematic))
    cinematicingameloop("a10tabletinterrupted");
  else
    cinematicingameloop("a10tabletout");

  common_scripts\utility::noself_delaycall(4, ::stopcinematicingame);

  if(level.player.a10_lastweapon == "none") {
    var_7 = level.player getweaponslistall();

    foreach(var_9 in var_7) {
      if(maps\_utility::isprimaryweapon(var_9)) {
        level.player.a10_lastweapon = var_9;
        break;
      }
    }
  }

  level.player enableweapons();
  level.player switchtoweapon(level.player.a10_lastweapon);
  var_11 = level.player.a10_grenades;

  foreach(var_13 in level.player.a10_grenades) {
    level.player giveweapon(var_13.type);
    level.player setweaponammoclip(var_13.type, var_13.ammo);
  }

  level.player.a10_grenades = undefined;
  level.player common_scripts\utility::delaycall(1, ::takeweapon, "remote_tablet");
  level.player common_scripts\utility::delaycall(1, ::enableweaponswitch);
  level.player common_scripts\utility::delaycall(1, ::enableweaponpickup);
  level.player common_scripts\utility::delaycall(1, ::allowmelee, 1);
  setDvar("hideHudFast", 0);
  setsaveddvar("ammoCounterHide", 0);
  level.player.dont_allow_ammo_cache = undefined;
}

a10_strafe_dialogue() {
  var_0 = common_scripts\utility::random(["homcom_us2_hogonesinfrom", "homcom_us2_riflehogwerecoming", "homcom_us2_copythattargetin", "homcom_us2_hogonesin"]);
  maps\_utility::smart_radio_dialogue(var_0, 0);

  if(isDefined(level.a10_mechanic_ambient_dialogue_off)) {
    return;
  }
  var_1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 8, 10, 11, 12];

  for(var_2 = var_1; !common_scripts\utility::flag("player_strafe_done"); var_2 = common_scripts\utility::array_remove(var_2, var_3)) {
    var_3 = common_scripts\utility::random(var_2);
    var_4 = "a10_ambient_line_" + var_3;
    thread maps\_utility::radio_dialogue(var_4);
    var_4 = level.scr_radio[var_4];
    var_5 = lookupsoundlength(var_4);
    common_scripts\utility::flag_wait_or_timeout("player_strafe_done", var_5 / 1000);
  }

  maps\_utility::radio_dialogue_clear_stack();
  maps\_utility::radio_dialogue_stop();
}

a10_fov_change() {
  level.player lerpfov(25, 0.05);
  common_scripts\utility::waitframe();
  level.player lerpfov(65, 10);
}

a10_ambient_clouds() {
  var_0 = anglesToForward(self.angles);
  var_1 = self.origin + var_0 * 100;
  var_2 = common_scripts\utility::spawn_tag_origin();
  playFXOnTag(common_scripts\utility::getfx("a10_clouds"), var_2, "tag_origin");
  common_scripts\utility::flag_wait("player_strafe_done");
  stopFXOnTag(common_scripts\utility::getfx("a10_clouds"), var_2, "tag_origin");
  var_2 delete();
}

a10_do_shots() {
  var_0 = self.storeshots;

  foreach(var_2 in var_0) {
    wait(var_2["time"] / 1000);

    foreach(var_4 in var_2["origins"]) {
      thread common_scripts\utility::play_sound_in_space("a10p_impact", var_4);
      playFX(common_scripts\utility::getfx("a10_impact"), var_4);
      radiusdamage(var_4, 256, 500, 500, self, level.player, "a10_30mm_player_homecoming");
      wait 0.05;
    }
  }

  maps\_utility::play_sound_on_entity("a10_strafe_roar");
}

a10_player_init(var_0, var_1) {
  var_0 a10_get_player_end_position();
  thread a10_player_aftermission_report();
  level.player thread a10_create_fake_player();
  level.fakea10ai = [];
  level.fakea10ai["allies"] = [];
  level.fakea10ai["axis"] = [];
  var_2 = undefined;
  var_3 = var_0 maps\_utility::get_linked_structs();

  foreach(var_5 in var_3) {
    if(var_5 maps\homecoming_util::parameters_check("targetStruct"))
      var_2 = var_5;

    if(var_5 maps\homecoming_util::parameters_check("fakeAI"))
      thread a10_create_fake_ai(var_5);
  }

  var_7 = var_0 maps\_utility::spawn_vehicle();
  var_8 = "tag_camera2";
  var_7.linker = var_7 common_scripts\utility::spawn_tag_origin();
  var_7.linker.angles = var_7 gettagangles(var_8);
  var_7.linker linkto(var_7, var_8, (0, 0, -55), (0, 0, 0));
  var_7.hud = a10_player_init_hud();
  var_7 dontcastshadows();
  level.player.warthog = var_7;
  var_7 thread a10_player_lockon_warning();
  level.player playerlinktodelta(var_7.linker, "tag_origin", 1, 20, 20, 15, 5, 1);
  level.player setstance("stand");
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player setclienttriggeraudiozone("homecoming_a10_int", 0);
  common_scripts\utility::flag_set("player_inside_a10");

  while(level.player getstance() != "stand")
    wait 0.05;

  level.player freezecontrols(1);

  if(isDefined(var_2)) {
    var_9 = var_2.origin;

    if(isDefined(var_2.radius))
      var_9 = maps\homecoming_util::return_point_in_circle(var_2.origin, var_2.radius);

    var_10 = vectornormalize(var_9 - var_7 gettagorigin(var_8));
    var_11 = vectortoangles(var_10);
    level.player setplayerangles(var_11);
  } else
    level.player setplayerangles(var_7 gettagangles(var_8));

  level.player.isfiringa10 = 0;
  level.player thread a10_player_30mm(var_7);
  level.player thread common_scripts\utility::play_loop_sound_on_entity("a10p_jet_whine");
  playFXOnTag(common_scripts\utility::getfx("flying_face_fx"), var_7.linker, "tag_origin");
  var_7 hudoutline_enable(0);

  if(isDefined(var_1))
    thread[[var_1]](var_7);

  return var_7;
}

a10_player_30mm(var_0) {
  self endon("player_warthog_finished");
  self notifyonplayercommand("a10_fire_30mm", "+attack");
  self notifyonplayercommand("a10_stop_fire_30mm", "-attack");
  self notifyonplayercommand("a10_fire_30mm", "+attack_akimbo_accessible");
  self notifyonplayercommand("a10_stop_fire_30mm", "-attack_akimbo_accessible");
  thread a10_inital_fire_check();
  self.storeshots = [];
  var_1 = gettime();
  var_2 = 0;
  var_3 = 1;

  for(;;) {
    self waittill("a10_fire_30mm");
    self.isfiringa10 = 1;

    if(!isDefined(var_3))
      var_2 = gettime() - var_1;

    var_3 = undefined;
    childthread a10_player_30mm_fire(var_0, var_2);
    self waittill("a10_stop_fire_30mm");
    self.isfiringa10 = 0;
    var_1 = gettime();
    var_0.firing_sound_ent thread maps\_utility::sound_fade_and_delete(0.05);
    thread aud_30mm_tail();
  }
}

aud_30mm_tail() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0 playSound("a10p_gatling_tail", "soundone");
  var_0 waittill("sounddone");
  var_0 delete();
}

a10_inital_fire_check() {
  self endon("a10_stop_fire_30mm");

  while(self attackButtonPressed()) {
    level.player notify("a10_fire_30mm");
    wait 0.05;
  }
}

a10_player_30mm_fire(var_0, var_1) {
  self endon("a10_stop_fire_30mm");
  var_0.firing_sound_ent = spawn("script_origin", (0, 0, 0));
  var_0.firing_sound_ent linkto(var_0, "tag_gun", (0, 0, 0), (0, 0, 0));
  var_0.firing_sound_ent thread common_scripts\utility::play_loop_sound_on_entity("a10p_gatling_loop");
  var_2 = self.storeshots.size;
  self.storeshots[var_2] = [];
  self.storeshots[var_2]["time"] = var_1;
  self.storeshots[var_2]["origins"] = [];
  var_3 = 0;

  for(;;) {
    var_4 = anglesToForward(var_0 gettagangles("tag_gun"));
    var_5 = self getEye();
    var_4 = anglesToForward(self getplayerangles());
    var_6 = var_5 + var_4 * 99999;
    var_7 = var_0 gettagorigin("tag_gun");
    var_8 = anglesToForward(var_0 gettagangles("tag_gun"));
    var_7 = var_7 + var_8 * 150;
    var_9 = bulletTrace(var_5, var_6, 0);
    var_10 = maps\homecoming_util::return_point_in_circle(var_9["position"], 128);
    var_9 = bulletTrace(var_5, var_10, 0);
    var_4 = vectornormalize(var_9["position"] - var_7);
    playFX(common_scripts\utility::getfx("a10_player_tracer"), var_7, var_4);
    var_0 thread a10_player_shot_think(var_9, var_7, var_4);
    var_11 = self.storeshots[var_2]["origins"].size;
    self.storeshots[var_2]["origins"][var_11] = var_9["position"];
    playFXOnTag(common_scripts\utility::getfx("a10_muzzle_flash"), var_0, "tag_gun");
    earthquake(0.22, 0.05, self.origin, 999999);
    self playrumbleonentity("ac130_25mm_fire");
    wait 0.05;
  }
}

a10_player_shot_think(var_0, var_1, var_2) {
  level endon("a10_mechachanic_skip_end");
  var_3 = var_0["position"];
  var_4 = var_0["entity"];

  if(isDefined(var_4) && isDefined(var_4.vehicletype) && (var_4 maps\_vehicle::ishelicopter() || var_4 maps\_vehicle::isairplane())) {} else
    wait 0.2;

  if(common_scripts\utility::flag("player_strafe_done")) {
    return;
  }
  playFX(common_scripts\utility::getfx("a10_impact"), var_3);
  thread common_scripts\utility::play_sound_in_space("a10p_impact", var_3, 0);
  radiusdamage(var_3, 256, 500, 500, level.player, "MOD_EXPLOSIVE", "a10_30mm_player_homecoming");
}

a10_player_lockon_warning() {
  self endon("death");
  level.player waittill("enable_a10_lockon_warning");
  thread common_scripts\utility::play_loop_sound_on_entity("apache_player_damaged_alarm");
  var_0 = self.hud;
  var_1 = [1, 0];

  for(;;) {
    foreach(var_3 in var_1) {
      wait 0.25;
      common_scripts\utility::array_thread(var_0["warning"], ::a10_hud_set_alpha, var_3);
    }
  }
}

a10_get_player_end_position() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = maps\_utility::get_linked_structs();

  foreach(var_4 in var_2) {
    if(var_4 maps\homecoming_util::parameters_check("a10_strafe_watcher")) {
      if(isDefined(var_4.script_count)) {
        if(level.a10_uses != var_4.script_count) {
          break;
        }
      }

      if(!isDefined(var_4.angles))
        var_4.angles = (0, 0, 0);

      var_0 = var_4;
      var_1 = "stand";
    }
  }

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = level.player.origin;
    var_0.angles = level.player.angles;
    var_1 = level.player getstance();
  }

  level.player.a10endposition = var_0;
  level.player.a10endstance = var_1;
}

a10_create_fake_player() {
  var_0 = getent("a10_player_spawner", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 maps\_utility::magic_bullet_shield();
  var_1.origin = level.player.origin;
  var_1.angles = level.player.angles;
  level.player.a10fakeplayer = var_1;
  common_scripts\utility::flag_wait("a10_allow_target_elements");
  target_set(var_1, (0, 0, 64));
  target_setshader(var_1, "hud_fofbox_self_sp");
}

a10_player_aftermission_report() {
  level.a10_player_kills = [];
  level.a10_player_kills["ai"] = 0;
  level.a10_player_kills["tanks"] = 0;
  level.a10_player_kills["armor"] = 0;
  common_scripts\utility::flag_wait("player_strafe_done");

  if(isDefined(level.a10_mechanic_skip_end) || isDefined(level.a10_mechanic_skip_end_vo)) {
    return;
  }
  wait 0.5;
  var_0 = level.a10_player_kills["ai"];
  var_1 = level.a10_player_kills["tanks"];
  var_2 = "homcom_dcon_repositioningdronestoyour";

  if(var_1 > 0 && var_0 > 0) {
    if(common_scripts\utility::cointoss())
      var_2 = "homcom_dcon_enemyarmorconfirmed";
    else
      var_2 = "homcom_dcon_confirmedarmorandinfantry";
  } else if(var_1 > 0) {
    if(common_scripts\utility::cointoss())
      var_2 = "homcom_dcon_confirmedtankkillsgood";
    else
      var_2 = "homcom_dcon_enemyarmorconfirmed";
  } else if(var_0 > 0 && var_0 < 10)
    var_2 = "homcom_dcon_goodkillsraptor21";
  else if(var_0 > 10)
    var_2 = "homcom_dcon_tenpluskiasgood";

  maps\_utility::radio_dialogue_clear_stack();
  maps\_utility::radio_dialogue_interupt(var_2);

  if(var_2 != "homcom_dcon_repositioningdronestoyour")
    maps\_utility::smart_radio_dialogue("homcom_dcon_repositioningdronestoyour", 0.05);
}

a10_squadron_logic() {
  self endon("death");
  self endon("stop_shooting");
  hudoutline_enable(0);
  self dontcastshadows();
  var_0 = common_scripts\utility::getfx("a10_engineeffect");
  playFXOnTag(var_0, self, "tag_engine_right");
  playFXOnTag(var_0, self, "tag_engine_left");

  if(!isDefined(self.script_linkto)) {
    return;
  }
  var_1 = maps\_utility::get_linked_structs();
  wait 1.5;
  var_2 = [];
  var_2["long"] = spawnStruct();
  var_2["long"].alias = "a10_gatling_long";
  var_2["long"].time = 2000;
  var_2["short"] = spawnStruct();
  var_2["short"].alias = "a10_gatling_short";
  var_2["short"].time = 1500.0;

  for(;;) {
    thread maps\homecoming_util::playloopingfx("a10_muzzle_flash", 0.05, undefined, "tag_gun");
    var_3 = common_scripts\utility::random(var_2);
    thread maps\_utility::play_sound_on_tag(var_3.alias, "tag_gun");
    var_4 = common_scripts\utility::random(var_1);
    var_5 = gettime();
    var_6 = var_3.time;

    while(gettime() - var_5 <= var_6) {
      thread a10_squadron_shoot(var_4);
      wait 0.05;
    }

    self notify("stop_looping_fx");
    wait(randomfloatrange(0.5, 1));
  }
}

a10_squadron_shoot(var_0) {
  var_1 = self gettagorigin("tag_gun");
  var_2 = return_random_spot_in_circle(var_0);
  var_3 = bulletTrace(var_1, var_2, 0);
  var_4 = vectornormalize(var_2 - var_1);
  playFX(common_scripts\utility::getfx("a10_player_tracer"), var_1, var_4);
  wait 0.2;
  playFX(common_scripts\utility::getfx("a10_impact"), var_3["position"]);
  thread common_scripts\utility::play_sound_in_space("a10p_impact", var_3["position"], 0);
}

a10_endrun_shooting(var_0) {
  self endon("stop_shooting");
  self endon("death");
  var_1 = self gettagorigin("tag_gun");
  var_2 = anglesToForward(self gettagangles("tag_gun"));
  var_3 = 200;
  var_4 = undefined;

  if(isDefined(var_0)) {
    var_4 = var_0.origin;

    if(isDefined(var_0.radius))
      var_3 = var_0.radius;
  } else {
    var_5 = var_1 + var_2 * 50000;
    var_6 = bulletTrace(var_1, var_5, 0);
    var_4 = var_6["position"];
  }

  var_7 = 1;

  for(;;) {
    wait(randomfloatrange(0.05, 0.1));
    var_1 = self gettagorigin("tag_gun");
    var_8 = maps\homecoming_util::return_point_in_circle(var_4, var_3);
    var_6 = bulletTrace(var_1, var_8, 0);
    var_9 = vectornormalize(var_6["position"] - var_1);
    playFX(common_scripts\utility::getfx("a10_player_tracer"), var_1, var_9);
    common_scripts\utility::noself_delaycall(0.4, ::playfx, common_scripts\utility::getfx("a10_impact"), var_6["position"]);

    if(var_7) {
      maps\_utility::delaythread(0.4, ::a10_endrun_shooting_impacts, var_6["position"]);
      var_7 = 0;
    }
  }
}

a10_endrun_shooting_impacts(var_0) {
  self endon("stop_shooting");

  for(;;)
    common_scripts\utility::play_sound_in_space("a10p_impact_ground", var_0);
}

a10_endrun_flyby_sound() {
  self waittill("flyby_sound");
  thread maps\_utility::play_sound_on_entity("a10_flyby_short");
}

a10_player_init_hud() {
  var_0 = [];
  var_0["reticle"] = level.player maps\_hud_util::createclienticon("dogcam_center", 600, 300);
  var_0["reticle"] maps\_hud_util::setpoint("CENTER", undefined, 0, 0);
  var_0["reticle2"] = level.player maps\_hud_util::createclienticon("torpedo_center", 300, 300);
  var_0["reticle2"] maps\_hud_util::setpoint("CENTER", undefined, 1, -5);
  var_0["reticle2"].color = (1, 1, 1);
  var_0["hit"] = level.player maps\_hud_util::createclienticon("remote_chopper_hud_target_hit", 32, 32);
  var_0["hit"] maps\_hud_util::setpoint("CENTER", undefined, 0, 0);
  var_0["hit"].alpha = 0;
  var_1 = 1;
  var_2 = 0.5;
  var_0["text"] = [];
  var_0["text"]["connection"] = level.player maps\_hud_util::createclientfontstring("objective", var_1);
  var_0["text"]["connection"] maps\_hud_util::setpoint("CENTER", "CENTER", -4, 175);
  var_0["text"]["connection"].color = (1, 1, 1);
  var_0["text"]["connection"].alpha = var_2;
  var_0["text"]["connection"].sort = -1;
  var_0["text"]["connection"] settext(&"HOMECOMING_CONNECTED");
  var_0["text"]["connection"] thread a10_hud_connected_pulse();
  var_0["text"]["ID"] = level.player maps\_hud_util::createclientfontstring("objective", var_1);
  var_0["text"]["ID"] maps\_hud_util::setpoint("CENTER", "CENTER", -5, 190);
  var_0["text"]["ID"].color = (1, 1, 1);
  var_0["text"]["ID"].alpha = var_2;
  var_0["text"]["ID"].sort = -1;
  var_0["text"]["ID"] settext("");
  var_0["text"]["ID"] thread a10_hud_set_id();
  var_0["text"]["guns"] = level.player maps\_hud_util::createclientfontstring("objective", var_1);
  var_0["text"]["guns"] maps\_hud_util::setpoint("LEFT", "LEFT", 150, 105);
  var_0["text"]["guns"].color = (1, 1, 1);
  var_0["text"]["guns"].alpha = var_2;
  var_0["text"]["guns"].sort = -1;
  var_0["text"]["guns"] settext(&"HOMECOMING_GUNSREADY");
  var_0["text"]["loc"] = level.player maps\_hud_util::createclientfontstring("objective", var_1);
  var_0["text"]["loc"] maps\_hud_util::setpoint("CENTER", "CENTER", 0, -185);
  var_0["text"]["loc"].color = (1, 1, 1);
  var_0["text"]["loc"].alpha = var_2;
  var_0["text"]["loc"].sort = -1;
  var_0["text"]["loc"] settext(&"HOMECOMING_SANTAMONICA");
  var_0["text"]["coords"] = level.player maps\_hud_util::createclientfontstring("objective", var_1);
  var_0["text"]["coords"] maps\_hud_util::setpoint("CENTER", "CENTER", 2, -175);
  var_0["text"]["coords"].color = (1, 1, 1);
  var_0["text"]["coords"].alpha = var_2;
  var_0["text"]["coords"].sort = -1;
  var_0["text"]["coords"] thread a10_hud_set_coords();
  var_0["text"]["30mm"] = level.player maps\_hud_util::createclientfontstring("objective", var_1);
  var_0["text"]["30mm"] maps\_hud_util::setpoint("RIGHT", "RIGHT", -200, 100);
  var_0["text"]["30mm"].color = (1, 1, 1);
  var_0["text"]["30mm"].alpha = var_2;
  var_0["text"]["30mm"].sort = -1;
  var_0["text"]["30mm"] settext(&"HOMECOMING_30MM");
  var_0["text"]["rounds"] = level.player maps\_hud_util::createclientfontstring("objective", var_1);
  var_0["text"]["rounds"] maps\_hud_util::setpoint("RIGHT", "RIGHT", -193, 110);
  var_0["text"]["rounds"].color = (1, 1, 1);
  var_0["text"]["rounds"].alpha = var_2;
  var_0["text"]["rounds"].sort = -1;
  var_0["text"]["rounds"] settext(&"HOMECOMING_ROUNDS");
  var_0["text"]["ammo"] = level.player maps\_hud_util::createclientfontstring("objective", var_1);
  var_0["text"]["ammo"] maps\_hud_util::setpoint("RIGHT", "RIGHT", -140, 110);
  var_0["text"]["ammo"].color = (1, 1, 1);
  var_0["text"]["ammo"].alpha = var_2;
  var_0["text"]["ammo"].sort = -1;
  var_0["text"]["ammo"] thread a10_hud_ammo_counter();
  var_3 = 100;
  var_4 = 400;
  var_5 = randomintrange(-500, -425);
  var_0["sidebars"] = [];
  var_0["sidebars"]["right"] = level.player maps\_hud_util::createclienticon("dogcam_bracket_r", var_3, var_4);
  var_0["sidebars"]["right"] maps\_hud_util::setpoint("RIGHT", "RIGHT", 0, 0);
  var_0["sidebars"]["right"].alpha = 1.0;
  var_0["sidebars"]["right"].sort = 1;
  var_0["sidebars"]["left"] = level.player maps\_hud_util::createclienticon("dogcam_bracket_l", var_3, var_4);
  var_0["sidebars"]["left"] maps\_hud_util::setpoint("LEFT", "LEFT", 0, 0);
  var_0["sidebars"]["left"].alpha = 1.0;
  var_0["sidebars"]["left"].sort = 1;
  var_0["hline"] = level.player maps\_hud_util::createclienticon("torpedo_horizonline", 750, 40);
  var_0["hline"] maps\_hud_util::setpoint("CENTER", undefined, 0, 0);
  var_0["cline"] = level.player maps\_hud_util::createclienticon("torpedo_centerline", 100, 50);
  var_0["cline"] maps\_hud_util::setpoint("CENTER", undefined, 0, -107);
  var_0["edge"] = level.player maps\_hud_util::create_client_overlay("dogcam_edge", 1, level.player);
  var_0["edge"].sort = -1;
  var_0["grain"] = maps\_hud_util::create_client_overlay("overlay_grain", 0.3, level.player);
  var_0["grain"] thread a10_hud_grain();
  var_6 = 128;
  var_7 = 128;
  var_0["warning"] = [];
  var_0["warning"]["bg_lock_left"] = level.player maps\_hud_util::createclienticon("apache_warn_lock_left", var_6, var_7);
  var_0["warning"]["bg_lock_left"] maps\_hud_util::setpoint("CENTER", "CENTER", -185, 0);
  var_0["warning"]["bg_lock_left"].color = (1, 0, 0);
  var_0["warning"]["bg_lock_left"].alpha = 0;
  var_0["warning"]["bg_lock_right"] = level.player maps\_hud_util::createclienticon("apache_warn_lock_right", var_6, var_7);
  var_0["warning"]["bg_lock_right"] maps\_hud_util::setpoint("CENTER", "CENTER", 185, 0);
  var_0["warning"]["bg_lock_right"].color = (1, 0, 0);
  var_0["warning"]["bg_lock_right"].alpha = 0;
  var_0["warning"]["bg_inc_left"] = level.player maps\_hud_util::createclienticon("apache_warn_incoming_left", var_6, var_7);
  var_0["warning"]["bg_inc_left"] maps\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
  var_0["warning"]["bg_inc_left"].color = (1, 0, 0);
  var_0["warning"]["bg_inc_left"].alpha = 0;
  var_0["warning"]["bg_inc_left"] maps\_hud_util::setparent(var_0["warning"]["bg_lock_left"]);
  var_0["warning"]["bg_inc_right"] = level.player maps\_hud_util::createclienticon("apache_warn_incoming_right", var_6, var_7);
  var_0["warning"]["bg_inc_right"] maps\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
  var_0["warning"]["bg_inc_right"].color = (1, 0, 0);
  var_0["warning"]["bg_inc_right"].alpha = 0;
  var_0["warning"]["bg_inc_right"] maps\_hud_util::setparent(var_0["warning"]["bg_lock_right"]);
  var_0["warning"]["msg_left"] = level.player maps\_hud_util::createclientfontstring("objective", 0.8);
  var_0["warning"]["msg_left"] maps\_hud_util::setpoint("CENTER", "CENTER", 4, 0);
  var_0["warning"]["msg_left"] settext(&"HOMECOMING_ENEMY_LOCK");
  var_0["warning"]["msg_left"].alpha = 0;
  var_0["warning"]["msg_left"] maps\_hud_util::setparent(var_0["warning"]["bg_lock_left"]);
  var_0["warning"]["msg_right"] = level.player maps\_hud_util::createclientfontstring("objective", 0.8);
  var_0["warning"]["msg_right"] maps\_hud_util::setpoint("CENTER", "CENTER", -4, 0);
  var_0["warning"]["msg_right"] settext(&"HOMECOMING_ENEMY_LOCK");
  var_0["warning"]["msg_right"].alpha = 0;
  var_0["warning"]["msg_right"] maps\_hud_util::setparent(var_0["warning"]["bg_lock_right"]);
  return var_0;
}

a10_hud_grain() {
  self endon("death");

  for(;;) {
    self.alpha = randomfloatrange(0.1, 0.2);
    wait(randomfloatrange(0.4, 1));
  }
}

a10_hud_connected_pulse() {
  self endon("death");
  var_0 = 0.5;

  for(;;) {
    self fadeovertime(1);
    self.alpha = 1;
    wait(var_0);
    self fadeovertime(1);
    self.alpha = 0.4;
    wait(var_0);
  }
}

a10_hud_set_id() {
  var_0 = "DRONE ID : ";
  var_1 = 15;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = "";

    if(common_scripts\utility::cointoss())
      var_3 = randomint(10);
    else
      var_3 = common_scripts\utility::random(["A", "Y", "R", "Q", "V", "O", "Z", "J", "W", "", "B", "S"]);

    var_0 = var_0 + var_3;
  }

  self settext(var_0);
}

a10_hud_set_coords() {
  self endon("death");

  for(;;) {
    var_0 = randomfloatrange(34.0, 34.5);
    var_1 = randomfloatrange(-118.4, -118.0);
    var_2 = var_0 + " N, " + var_1 + " W";
    self settext(var_2);
    wait 0.3;
  }
}

a10_hud_ammo_counter() {
  self endon("death");
  var_0 = randomintrange(500, 1174);
  self settext(var_0);

  for(;;) {
    while(level.player attackButtonPressed()) {
      var_0--;
      self settext(var_0);
      wait 0.05;
    }

    level.player waittill("a10_fire_30mm");
  }
}

scanline_move() {
  self endon("death");
  var_0 = 1;
  self moveovertime(var_0 / 2);
  self.y = 400;
  wait(var_0 / 2);

  for(;;) {
    wait 0.05;
    self.y = -400;
    wait 0.05;
    self moveovertime(var_0);
    self.y = 400;
    wait(var_0);
  }
}

scanline_flicker() {
  for(;;) {
    var_0 = randomfloatrange(0.5, 1);
    self fadeovertime(var_0);
    self.alpha = 0;
    wait(var_0);
    self fadeovertime(var_0);
    self.alpha = 0.1;
    wait(var_0);
  }
}

a10_hud_set_connection() {
  self endon("death");
  common_scripts\utility::flag_wait("player_strafe_done");
  self settext(&"HOMECOMING_DISCONNECTING");
}

a10_hud_set_altitude(var_0) {
  self endon("death");
  var_1 = level.player.origin[2];

  for(;;) {
    if(level.player.origin[2] > var_1)
      var_0++;
    else if(level.player.origin[2] < var_1)
      var_0 = var_0 - 1;

    var_1 = var_0;
    maps\_hud_util::setpoint("RIGHT", "BOTTOM", 33, var_0, 0);
    wait 0.05;
  }
}

a10_hud_set_speed() {
  self endon("death");
  var_0 = randomintrange(-20, 20);
  var_1 = var_0 + 20;
  var_2 = var_0 - 20;

  for(;;) {
    maps\_hud_util::setpoint("RIGHT", "RIGHT", -60, var_0);

    if(common_scripts\utility::cointoss())
      var_0++;
    else
      var_0--;

    if(var_0 == var_1)
      var_0++;
    else if(var_0 == var_2)
      var_0--;

    wait 0.05;
  }
}

a10_player_hud_cleanup() {
  var_0 = self.hud;
  var_0["edge"] destroy();
  var_0["reticle"] destroy();
  var_0["grain"] destroy();
  var_0["hline"] destroy();
  var_0["cline"] destroy();
  var_0["reticle2"] destroy();

  foreach(var_2 in var_0["sidebars"])
  var_2 destroy();

  foreach(var_2 in var_0["warning"])
  var_2 destroy();

  foreach(var_2 in var_0["text"])
  var_2 destroy();

  level.enemydeathicons = 0;
}

a10_hud_set_alpha(var_0) {
  self.alpha = var_0;
}

a10_target_logic() {
  level.player endon("player_warthog_finished");
  common_scripts\utility::flag_wait("a10_allow_target_elements");
  thread a10_vehicle_target_logic();
  thread a10_allies_target_logic();
  thread a10_enemies_target_logic();
}

a10_allies_target_logic() {
  level.player endon("player_warthog_finished");
  var_0 = [];

  for(;;) {
    var_1 = common_scripts\utility::array_combine(level.drones["allies"].array, getaiarray("allies"));
    var_1 = common_scripts\utility::array_combine(var_1, level.fakea10ai["allies"]);
    var_1 = common_scripts\utility::array_remove_array(var_1, var_0);

    foreach(var_3 in var_1) {
      var_3 thread a10_ally_friendlyfire_think();
      var_3 thread hudoutline_enable(3);
      var_3 thread remove_target_on_death();
      var_0 = common_scripts\utility::array_add(var_0, var_3);
    }

    wait 0.05;
  }
}

a10_enemies_target_logic() {
  level.player endon("player_warthog_finished");
  var_0 = [];

  for(;;) {
    var_1 = common_scripts\utility::array_combine(level.drones["axis"].array, getaiarray("axis"));
    var_1 = common_scripts\utility::array_combine(var_1, level.fakea10ai["axis"]);
    var_1 = common_scripts\utility::array_remove_array(var_1, var_0);
    var_1 = common_scripts\utility::array_removeundefined(var_1);

    foreach(var_3 in var_1) {
      var_3 hudoutline_enable(4);
      thread a10_kill_notification(var_3);
      var_3 thread remove_target_on_death();
      var_0 = common_scripts\utility::array_add(var_0, var_3);
    }

    wait 0.05;
  }
}

a10_vehicle_target_logic() {
  level.player endon("player_warthog_finished");
  var_0 = self;
  level.strafetargetvehicles = maps\_utility::remove_dead_from_array(level.strafetargetvehicles);

  foreach(var_2 in level.strafetargetvehicles) {
    var_2 thread a10_enable_target("orange");
    var_2 thread hudoutline_enable(4);
    var_2 thread remove_target_on_death();
    var_2 thread a10_player_hit_strafe_vehicles(var_0);
    var_0 thread a10_kill_notification(var_2);
  }

  var_4 = [];

  for(;;) {
    level.strafevehicles = maps\_utility::remove_dead_from_array(level.strafevehicles);
    var_5 = common_scripts\utility::array_remove_array(level.strafevehicles, var_4);

    foreach(var_2 in var_5) {
      var_2 thread hudoutline_enable(4);
      var_0 thread a10_kill_notification(var_2);
      var_2 thread remove_target_on_death();
      var_2 thread a10_player_hit_strafe_vehicles(var_0);
      var_4 = common_scripts\utility::array_add(var_4, var_2);
    }

    wait 0.05;
  }
}

a10_kill_notification(var_0) {
  level endon("player_strafe_cleanup_done");
  var_1 = self;
  var_0 waittill("death", var_2, var_3, var_4);

  if(!isDefined(var_2) || var_2 != level.player) {
    return;
  }
  if(!isDefined(var_4)) {
    return;
  }
  if(var_4 != "a10_30mm_player_homecoming") {
    return;
  }
  thread a10_mechanic_achievement_check();

  if(var_0 maps\_vehicle::isvehicle()) {
    if(issubstr(var_0.classname, "t90ms"))
      level.a10_player_kills["tanks"]++;
    else
      level.a10_player_kills["armor"]++;

    return;
  } else
    level.a10_player_kills["ai"]++;

  if(level.enemydeathicons == 20) {
    return;
  }
  if(isDefined(self.lastkilliconloc)) {
    if(distancesquared(self.lastkilliconloc, var_0.origin) < 40000)
      return;
  }

  if(!isDefined(self.lastkillsoundtime) || gettime() - self.lastkillsoundtime > 166) {
    thread maps\_utility::play_sound_on_entity("a10_kill_npc_ui_beep");
    self.lastkillsoundtime = gettime();
  }

  thread a10_player_hit_hudelem();
  var_5 = var_0.origin;
  self.lastkilliconloc = var_5;
  level.enemydeathicons++;
  var_6 = spawn("script_origin", var_5 + (0, 0, -32));
  var_7 = level.player maps\_hud_util::createclienticon("dogcam_target", 1, 1);
  var_7.width = 0.1;
  var_7.height = 0.1;
  var_7 setwaypoint(1, 0, 1);
  var_7 settargetent(var_6);
  var_8 = 0.75;
  var_7.alpha = 0.5;
  var_7 fadeovertime(var_8);
  var_7.alpha = 0;
  maps\_utility::add_wait(maps\_utility::timeout, var_8);
  maps\_utility::add_wait(common_scripts\utility::flag_wait, "player_strafe_done");

  if(common_scripts\utility::flag("FLAG_allow_a10_strafe_crash"))
    maps\_utility::add_wait(common_scripts\utility::flag_wait, "player_strafe_crash");

  maps\_utility::do_wait_any();
  var_7 destroy();
  level.enemydeathicons--;

  if(isDefined(self.lastkilliconloc) && self.lastkilliconloc == var_5)
    self.lastkilliconloc = undefined;

  var_6 delete();
}

a10_player_hit_strafe_vehicles(var_0) {
  level endon("player_strafe_cleanup_done");
  self endon("death");

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(!isDefined(var_2) || var_2 != level.player) {
      return;
    }
    var_0 thread a10_player_hit_hudelem();
  }
}

a10_player_hit_hudelem() {
  self notify("player_hit_hudelem");
  self endon("player_hit_hudelem");
  self.hud["hit"].alpha = 0.8;
  self.hud["hit"] fadeovertime(0.2);
  self.hud["hit"].alpha = 0;
}

a10_targeting_think(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [];
  self.avaiabletargets = 0;

  for(;;) {
    wait 0.05;

    if(self.avaiabletargets == var_2) {
      continue;
    }
    var_0 = common_scripts\utility::array_removeundefined(var_0);

    foreach(var_6 in var_0) {
      if(self.avaiabletargets == var_2) {
        continue;
      }
      if(isDefined(var_6.alreadytarget)) {
        continue;
      }
      var_7 = anglesToForward(level.player getplayerangles());
      var_8 = level.player.origin + var_7 * 10000000;
      var_9 = bulletTrace(level.player.origin, var_8, 0, self);

      if(common_scripts\utility::distance_2d_squared(var_9["position"], var_6.origin) < 22500) {
        var_6.alreadytarget = 1;
        var_6 a10_enable_target("red", "apache_enemy_ai_target_s_w");
        var_6 childthread a10_targeting_watcher(var_9);
        self.avaiabletargets--;
      }
    }
  }
}

a10_targeting_watcher(var_0) {
  self endon("death");

  while(common_scripts\utility::distance_2d_squared(var_0["position"], self.origin) < 22500)
    wait 0.05;

  a10_remove_target();
  self.avaiabletargets++;
  self.alreadytarget = undefined;
}

a10_enable_target(var_0, var_1) {
  var_2 = self;
  var_3 = 1;

  if(isstring(var_0)) {
    switch (tolower(var_0)) {
      case "red":
        var_0 = (1, 0, 0);
        break;
      case "green":
        var_0 = (0, 1, 0);
        break;
      case "orange":
        var_0 = (1, 0.65, 0.2);
        break;
      case "cyan":
        var_0 = (0.35, 1, 1);
        break;
    }
  }

  if(var_2 maps\_vehicle::isvehicle()) {
    var_2.alreadytarget = 1;
    target_set(var_2, (0, 0, 32));
    target_drawsingle(var_2);
    target_setshader(var_2, "apache_target_vehicle");
    target_showtoplayer(var_2, level.player);

    if(isDefined(var_0))
      target_setcolor(var_2, var_0);
  } else if(isai(var_2)) {
    var_2.alreadytarget = 1;
    target_alloc(var_2, (0, 0, 0));
    target_set(var_2, (0, 0, 0));

    if(isDefined(var_1))
      target_setshader(var_2, var_1);

    target_setscaledrendermode(var_2, 1);

    if(isDefined(var_0))
      target_setcolor(var_2, var_0);

    target_setmaxsize(var_2, 4);
    target_setminsize(var_2, 4, 0);
    target_flush(var_2);
  }
}

a10_remove_target() {
  self.alreadytarget = undefined;
  target_remove(self);
}

set_a10_strafe_target_vehicle() {
  level.strafetargetvehicles = common_scripts\utility::array_add(level.strafetargetvehicles, self);
}

set_a10_strafe_vehicle() {
  level.strafevehicles = common_scripts\utility::array_add(level.strafevehicles, self);
}

remove_target_on_death() {
  maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "ragdoll");
  level.player maps\_utility::add_wait(maps\_utility::waittill_msg, "player_warthog_finished");
  maps\_utility::do_wait_any();

  if(isDefined(self)) {
    self.alreadytarget = undefined;
    self hudoutlinedisable();

    if(target_istarget(self))
      target_remove(self);
  }
}

a10_create_fake_ai(var_0) {
  var_1 = "pose_fed_army_stand_idle";
  var_2 = randomintrange(10, 15);

  if(isDefined(var_0.script_index))
    var_2 = var_0.script_index;

  var_3 = "axis";

  if(var_0 maps\homecoming_util::parameters_check("allies"))
    var_3 = "allies";

  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_5 = maps\homecoming_util::return_point_in_circle(var_0.origin, var_0.radius);
    var_6 = spawn("script_model", var_5);
    var_6 setModel(var_1);
    var_6.angles = (0, randomint(360), 0);

    if(var_3 == "axis")
      var_6 thread a10_fake_ai_death();

    level.fakea10ai[var_3] = common_scripts\utility::array_add(level.fakea10ai[var_3], var_6);
  }
}

a10_fake_ai_death() {
  self setCanDamage(1);
  level.player maps\_utility::add_wait(maps\_utility::waittill_msg, "player_warthog_finished");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "damage");
  maps\_utility::do_wait_any();
  level.fakea10ai["axis"] common_scripts\utility::array_remove(level.fakea10ai["axis"], self);
  self delete();
}

hudoutline_enable(var_0) {
  var_1 = 0;

  if(var_1 == 1) {
    return;
  }
  self hudoutlineenable(var_0, 0);
}

target_outofrange_check() {
  var_0 = squared(1500);

  for(;;) {
    var_1 = distancesquared(self.origin, level.player.origin);

    if(var_1 <= var_0) {
      break;
    }

    wait 0.05;
  }

  self notify("out_of_range");
}

a10_fov_trig() {
  self waittill("trigger");
  iprintln("fov change");
  var_0 = self.script_count;
  var_1 = self.script_timer;
  level.player lerpfov(var_0, var_1);
}

a10_missile_lockon() {
  var_0 = level.player maps\_hud_util::createclienticon("apache_warn_lock_left", 128, 128);
  var_0 maps\_hud_util::setpoint("CENTER", "CENTER", -185, 0);
  var_0.alpha = 0;
  var_1 = level.player maps\_hud_util::createclienticon("apache_warn_lock_right", 128, 128);
  var_1 maps\_hud_util::setpoint("CENTER", "CENTER", 185, 0);
  var_1.alpha = 0;
}

a10_hint_func() {
  if(common_scripts\utility::flag("used_a10_strafe") || common_scripts\utility::flag("a10_mechanic_off"))
    return 1;

  return 0;
}

a10_fire_hint_func() {
  if(level.player attackButtonPressed()) {
    common_scripts\utility::flag_set("FLAG_player_used_a10_30mm");
    return 1;
  }

  return common_scripts\utility::flag("player_strafe_done");
}

a10_allies_friendlyfire_watcher() {
  level.player endon("player_warthog_finished");
  var_0 = 0;

  for(;;) {
    level waittill("a10_friendlyfire_notify");
    var_1 = gettime();

    if(gettime() - var_1 > 5000)
      var_0 = 0;

    var_0++;

    if(15 == var_0) {
      break;
    }
  }

  maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
  maps\_utility::missionfailedwrapper();
}

a10_ally_friendlyfire_think() {
  level.player endon("player_warthog_finished");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_1 != level.player) {
      continue;
    }
    if(var_4 != "MOD_EXPLOSIVE") {
      continue;
    }
    level notify("a10_friendlyfire_notify");
  }
}

a10_squadron_friendlyfire_watcher() {
  level.player endon("player_warthog_finished");
  maps\_utility::set_allowdeath(1);
  var_0 = 0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(var_2 != level.player) {
      continue;
    }
    var_6 = gettime();

    if(gettime() - var_6 > 5000)
      var_0 = 0;

    var_0++;

    if(5 == var_0) {
      break;
    }
  }

  maps\_player_death::set_deadquote(&"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
  maps\_utility::missionfailedwrapper();
}

a10_mechanic_achievement_check() {
  if(common_scripts\utility::flag("a10_achievement_achieved")) {
    return;
  }
  level.a10_total_killed_enemies++;

  if(level.a10_total_killed_enemies < 50) {
    return;
  }
  common_scripts\utility::flag_set("a10_achievement_achieved");
  level.player maps\_utility::player_giveachievement_wrapper("LEVEL_5A");
}

return_random_spot_in_circle(var_0) {
  var_1 = var_0.radius;
  var_2 = randomintrange(var_1 * -1, var_1);
  var_3 = var_0.origin[0] + var_2;
  var_2 = randomintrange(var_1 * -1, var_1);
  var_4 = var_0.origin[1] + var_2;
  return (var_3, var_4, var_0.origin[2]);
}