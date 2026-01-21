/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_rooftop_intro.gsc
******************************************/

enemyhq_rooftop_intro_pre_load() {
  common_scripts\utility::flag_init("finished_intro_dof");
  common_scripts\utility::flag_init("bishop_glimpse_over");
  common_scripts\utility::flag_init("watching_bishop_glimpse");
  common_scripts\utility::flag_init("activate_vip_sniper");
  common_scripts\utility::flag_init("enable_butchdance");
  common_scripts\utility::flag_init("start_rpg_kibble");
  common_scripts\utility::flag_init("start_exfil_sniper");
  common_scripts\utility::flag_init("blow_koolaid_wall");
  common_scripts\utility::flag_init("FLAG_move_to_player_truck");
  common_scripts\utility::flag_init("checkit_zoom");
  common_scripts\utility::flag_init("checkit_dryfire");
  common_scripts\utility::flag_init("checkit_pan");
  common_scripts\utility::flag_init("start_convoy");
  common_scripts\utility::flag_init("bishop_glimpse");
  common_scripts\utility::flag_init("kill_player_fail");
  common_scripts\utility::flag_init("FLAG_dead_guys_near_truck");
  common_scripts\utility::flag_init("bishop_in_crosshairs");
  common_scripts\utility::flag_init("merrick_done_lookat");
  precachemodel("weapon_bursted_sticky_grenade");
  precachemodel("weapon_sticky_grenade");
  precachemodel("ehq_seat_dyn");
  precachemodel("viewmodel_mk14");
  precachemodel("cargocontainer_20ft_white");
  precachemodel("com_ammo_pallet");
  precachemodel("berlin_barrelcluster_pallet_01");
  precachemodel("shipping_frame_boxes");
  precachemodel("weapon_remote_sniper_tripod");
  precachemodel("weapon_remote_sniper_gun");
  precachemodel("mil_mre_chocolate02");
  precachemodel("ehq_intro_window_vines_anim");
  precachemodel("viewmodel_mk32_dud_bolt_ring_off");
  precachemodel("dub_restaurant_chair_dirty_01b");
  precacheshader("killiconheadshot");
  precacheitem("remote_chopper_gunner");
  precacheitem("remote_chopper_gunner_nopullout");
  precachemodel("weapon_mts_255_small");
  precacheitem("remote_tablet_nopullout");
  precacheitem("remote_tablet");
  precacheshader("remote_chopper_hud_target_enemy");
  precacheshader("remote_chopper_hud_target_friendly");
  precacheshader("remote_chopper_hud_target_e_vehicle");
  precacheshader("inventory_stickybomb");
  precacheitem("nosound_magicbullet");
  precacheitem("mk32_dud_rocket");
  precacheitem("mk32_dud");
  precacheitem("freerunner");
  thread sniper_vip_breach();
  thread butchdance();
  thread rpg_kibble();
  thread exfil_sniper();
  thread handle_m32_launcher();
  level.player thread handle_sticky_clacker();
  level.switching_to_detonator = 0;
  level.switching_from_detonator = 0;
  var_0 = getEntArray("intro_hide_on_load", "script_noteworthy");
  var_1 = getEntArray("flyby_hide_on_load", "script_noteworthy");
  var_2 = getEntArray("flybyA_hide_on_load", "script_noteworthy");
  var_3 = common_scripts\utility::array_combine(var_0, var_1);
  var_4 = common_scripts\utility::array_combine(var_3, var_2);
  common_scripts\utility::array_call(var_4, ::hide);
  common_scripts\utility::array_call(var_4, ::notsolid);
  precachedigitaldistortcodeassets();
  precachestring(&"ENEMY_HQ_ZOOMHINT");
  precachestring(&"ENEMY_HQ_ZOOMHINT_NO_GLYPH");
  level.mk32_mode = "instant";
  thread listen_mk32_mode();
  thread sniper_nade_setup();
}

listen_mk32_mode() {
  wait 1;
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");
  level.mk32_mode = "instant";
}

setup_rooftop_intro() {
  level.remote_target_override_function = ::handle_intro_sniper_outline;
  level.ehq_blackout_time = 5;
  maps\_utility::intro_screen_create(&"ENEMY_HQ_INTROSCREEN_LINE_1", &"ENEMY_HQ_INTROSCREEN_LINE_2", &"ENEMY_HQ_INTROSCREEN_LINE_3");
  maps\_utility::intro_screen_custom_timing(2, 1);
  maps\_utility::intro_screen_custom_func(::introscreen);
  level.sniper_wait_extra_black = 1;
  level.start_point = "intro";
  maps\enemyhq::setup_common("introroof");
  thread cargo_choppers();
  level.mk32_mode = "delay";
  level.dog maps\enemyhq_code::lock_player_control();
}

begin_rooftop_intro() {
  level.ehq_znear_default = getdvar("r_znear");
  setsaveddvar("r_znear", 40.0);
  thread maps\enemyhq_intro::spawn_player_truck();
  maps\_utility::disable_trigger_with_targetname("TRIG_get_in_truck");
  thread intro_common();
  thread maps\_utility::autosave_tactical();
  thread field_activity();
  thread maps\enemyhq_intro::dead_guys_near_truck();
  level.player.allow_dry_fire = 1;
  level.intro_grenades = level.player getweaponammoclip("fraggrenade");
  level.player takeallweapons();
  level.player_intro_weapon = "freerunner";
  level.player giveweapon(level.player_intro_weapon);
  level.player switchtoweapon(level.player_intro_weapon);
  level.player.presniper_weapon = level.player_intro_weapon;
  level.player.presniper_weapon_clip = 0;
  level.player.presniper_weapon_stock = 0;
  level.player giveweapon("remote_tablet");
  level.player switchtoweapon("remote_tablet");
  level.player freezecontrols(1);
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  wait(level.ehq_blackout_time);
  thread digital_malarky(0.5, 1.75);
  level.player freezecontrols(0);
  maps\enemyhq_code::safe_activate_trigger_with_targetname("rooftop_intro_color");
  thread bishop_glimpse();
  level.player intro_overlook_static();
  common_scripts\utility::flag_set("FLAG_dead_guys_near_truck");
  common_scripts\utility::flag_wait("bishop_glimpse_over");
  setsaveddvar("r_znear", level.ehq_znear_default);
}

setup_rooftop_shoot() {
  level.start_point = "introshoot";
  maps\enemyhq_intro::spawn_player_truck();
  maps\enemyhq::setup_common("introroof");
  thread maps\enemyhq_audio::aud_check("rooftop_shoot");
  thread intro_common();
  thread air_armada();
  level.mk32_mode = "delay";
  level.dog maps\enemyhq_code::lock_player_control();
  setsaveddvar("ammoCounterHide", 1);
}

begin_rooftop_shoot() {
  thread cargo_choppers();
  thread maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(989);
  common_scripts\utility::exploder("5600");
  level.allies[0].disable_sniper_glint = 1;
  level.allies[0].old_weap = level.allies[0].primaryweapon;
  level.allies[0] maps\_utility::forceuseweapon("mk32_dud_rocket", "primary");
  level.allies[0].noreload = 1;
  level.remote_target_override_function = undefined;
  level.player_intro_weapon = "sc2010+reflex_sp";
  level.mk32_intro_fire = 1;
  level.player_mk32 = "mk32_dud+eotech_sp_mk32dud";
  thread watch_weaponswitch();
  thread maps\enemyhq_intro::player_failcase_road();
  thread player_failcase_road_mk32();
  maps\_utility::disable_trigger_with_targetname("picked_up_mk32");
  maps\_utility::disable_trigger_with_targetname("TRIG_get_in_truck");
  level.player.allow_dry_fire = 0;
  level.next_repeat_vo = 0;
  thread keegan_tinkers_with_rifle();
  level.player setstance("crouch");
  wait 0.05;
  level.player setstance("crouch");
  thread maps\_utility::autosave_by_name("intro_rooftop");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("rooftop_crawl_forward");
  level.allies[1] thread maps\enemyhq_intro::keegan_enter_veh();
  thread intro_plane_flyby_01();
  pickup_mk32();
  level waittill("stop_convoy");
  level.player thread swapout_mk32();
  thread go_street();
  thread remove_ally_mk32();
  common_scripts\utility::flag_set("kill_player_fail");
}

player_failcase_road_mk32() {
  thread player_failcase_road_overrun_mk32();
  level endon("kill_player_fail");
  var_0 = [];
  var_0[0] = "enemyhq_mrk_logangetbackhere";
  var_0[1] = "enemyhq_mrk_whereareyougoing";

  for(;;) {
    common_scripts\utility::flag_wait("FLAG_player_failcase_road_mk32");
    var_1 = 0;

    while(common_scripts\utility::flag("FLAG_player_failcase_road_mk32")) {
      if(var_1 > var_0.size - 1) {
        setdvar("ui_deadquote", &"ENEMY_HQ_YOU_LEFT_YOUR_TEAM_BEHIND");
        maps\_utility::missionfailedwrapper();
        break;
      }

      level.allies[0] maps\enemyhq_code::char_dialog_add_and_go(var_0[var_1]);
      var_1++;
      wait(randomfloatrange(2, 4));
    }
  }
}

player_failcase_road_overrun_mk32() {
  level endon("kill_player_fail");
  common_scripts\utility::flag_wait("FLAG_player_failcase_road_overrun_mk32");
  setdvar("ui_deadquote", &"ENEMY_HQ_YOU_LEFT_YOUR_TEAM_BEHIND");
  maps\_utility::missionfailedwrapper();
}

remove_ally_mk32() {
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");
  wait 3;
  level.allies[0].noreload = undefined;
  level.allies[0] maps\_utility::forceuseweapon(level.allies[0].old_weap, "primary");
  level.allies[0].old_weapon = "none";

  if(isDefined(level.allies[0].weaponinfo["mk32_dud_rocket"]) && isDefined(level.allies[0].weaponinfo["mk32_dud_rocket"].hasclip))
    level.allies[0].weaponinfo["mk32_dud_rocket"].hasclip = 0;
}

introscreen() {
  maps\_utility::delaythread(2, maps\_utility::smart_radio_dialogue, "enemyhq_kgn_poweringupremotesniper");
  thread maps\enemyhq_audio::aud_start_sniper_intro();
  maps\_introscreen::introscreen(0, level.ehq_blackout_time);
}

intro_common() {
  thread ship_vista();
}

monitor_player_used_zoom(var_0) {
  while(!common_scripts\utility::flag("checkit_zoom")) {
    if(abs(var_0 - level.remote_turret_current_fov) > 20)
      common_scripts\utility::flag_set("checkit_zoom");

    wait 0.05;
  }
}

sniper_paces() {
  sniper_paces_static();
  level.player forceusehintoff();
}

zoom_hint_wait() {
  if(common_scripts\utility::flag("checkit_zoom"))
    return 1;

  return 0;
}

sniper_paces_static() {
  level endon("bishop_glimpse");
  level.player.prev_stance = "crouch";
  maps\_utility::smart_radio_dialogue("enemyhq_mrk_scanaroundforfed");
  wait 4;

  if(!common_scripts\utility::flag("checkit_zoom")) {
    maps\_utility::smart_radio_dialogue("enemyhq_mrk_zoominonthe");
    common_scripts\utility::flag_wait_or_timeout("checkit_zoom", 2);

    if(!common_scripts\utility::flag("checkit_zoom")) {
      maps\_utility::display_hint("zoom_hint");
      common_scripts\utility::flag_wait_or_timeout("checkit_zoom", 4);
      var_0 = 9;

      while(!common_scripts\utility::flag("checkit_zoom")) {
        maps\_utility::smart_radio_dialogue("enemyhq_mrk_logantryzoomingin");
        common_scripts\utility::flag_wait_or_timeout("checkit_zoom", var_0);

        if(var_0 < 30)
          var_0 = var_0 * 1.5;
      }
    }

    wait 0.1;
  }
}

watch_dryfire() {
  level.player endon("use_remote_turret");
  var_0 = 0;
  var_0 = gettime();
  var_1 = 7000;

  for(;;) {
    common_scripts\utility::flag_wait("checkit_dryfire");
    common_scripts\utility::flag_clear("checkit_dryfire");

    if(var_0 < gettime()) {
      var_0 = gettime() + var_1;
      var_1 = var_1 * 1.5;
      maps\_utility::smart_radio_dialogue("enemyhq_kgn_itsnotloaded");
    }

    wait 0.05;
  }
}

intro_overlook_static() {
  var_0 = common_scripts\utility::getstruct("sniper_introaim_static", "targetname");
  level.remote_turret_current_fov = 55;
  level.remote_turret_right_arc = 22;
  level.remote_turret_left_arc = 45;
  level.remote_turret_top_arc = 15;
  level.remote_turret_bottom_arc = 17;
  setup_sniper_view("sniper_introaim_static");
  common_scripts\utility::flag_wait("remote_sniper_ready");
  self.turret_look_at_ent.origin = var_0.origin;
  level.remote_turret_current_fov = 55;
  self lerpfov(level.remote_turret_current_fov, 0.05);
  thread air_armada();
  thread monitor_player_used_zoom(55);
  thread watch_dryfire();
  wait 2;
  thread intro_objectives();
  thread sniper_paces();
  monitor_player_bishop();

  if(!common_scripts\utility::flag("bishop_glimpse")) {
    self notify("remote_turret_nozoom");
    thread maps\_utility::add_dialogue_line("Merrick", "I see activity in VIP suites. I'm Overriding control.");
    thread maps\_utility::smart_radio_dialogue("enemyhq_mrk_iseeactivityin");
    thread intro_dof(0.7);
    wait 0.4;
    var_1 = length(self.turret_look_at_ent.origin - self.origin);
    var_0 = common_scripts\utility::getstruct("sniper_introaim_4", "targetname");
    var_2 = self.origin + anglesToForward(level.player getplayerangles()) * var_1;
    self.turret_look_at_ent.origin = var_2;
    self.player_view_controller snaptotargetentity(self.turret_look_at_ent);
    self lerpviewangleclamp(0, 0, 0, 0, 0, 0, 0);
    level.remote_turret_right_arc = 0;
    level.remote_turret_left_arc = 0;
    level.remote_turret_top_arc = 0;
    level.remote_turret_bottom_arc = 0;
    var_3 = length(var_0.origin - self.turret_look_at_ent.origin) / 1000;
    var_3 = min(var_3, 4);
    var_3 = max(var_3, 1);
    wait 0.05;
    self.turret_look_at_ent moveto(var_0.origin, var_3, var_3 / 4, var_3 / 4);
    var_4 = 2;
    self lerpfov(var_4, var_3);
    level.remote_turret_current_fov = var_4;
    thread maps\enemyhq_audio::aud_focus_zoom();
    common_scripts\utility::flag_set("watching_bishop_glimpse");
    wait(var_3);
    self lerpviewangleclamp(0, 0, 0, 5, 5, 1, 1);
    level.remote_turret_right_arc = 5;
    level.remote_turret_left_arc = 5;
    level.remote_turret_top_arc = 1;
    level.remote_turret_bottom_arc = 1;
    level.remote_turret_min_fov = 1;
    level.remote_turret_max_fov = 4;
    thread maps\enemyhq_remoteturret::remote_turret_handle_zoom();
  } else {
    common_scripts\utility::flag_set("watching_bishop_glimpse");
    maps\_utility::radio_dialogue_stop();
    wait 0.05;
    thread maps\_utility::smart_radio_dialogue("enemyhq_mrk_waityouhavesomething");
    level.remote_turret_min_fov = 1;
  }

  var_5 = gettime();
  var_6 = level common_scripts\utility::waittill_any_return("bishop_in_crosshairs", "identify_vo_timeout");
  thread maps\_utility::smart_radio_dialogue("enemyhq_mrk_wehaveapossible");

  if(var_6 != "identify_vo_timeout")
    level waittill("identify_vo_timeout");

  var_7 = 9.5;
  maps\_utility::delaythread(var_7, maps\_utility::send_notify, "use_remote_turret");
  level maps\_utility::delaythread(var_7, common_scripts\utility::flag_set, "bishop_glimpse_over");
  wait 4.5;
  thread maps\_utility::smart_radio_dialogue("enemyhq_kgn_thenthatswherewere");
  wait 1;
  thread maps\_utility::smart_radio_dialogue("enemyhq_hsh_weregoinginthere");
  wait 1;
  maps\_utility::smart_radio_dialogue("enemyhq_mrk_alrightadamletsfinish");
}

monitor_player_bishop() {
  var_0 = gettime() + 45000;
  var_1 = 0;
  var_2 = 0;
  var_3 = [];
  var_3[var_3.size] = "enemyhq_mrk_heavyfedactivity12";
  var_3[var_3.size] = "enemyhq_mrk_fedactivitydeadahead";
  var_4 = 8000;
  var_5 = [];
  var_5["field_area"] = 0;
  var_5["stadium_left"] = 0;
  var_5["stadium_right"] = 0;
  var_5["armada"] = 0;
  var_6 = common_scripts\utility::getstructarray("bishop_search", "targetname");
  var_7 = 0;
  var_8 = [];
  var_8[var_8.size] = "enemyhq_mrk_enemypatrolsnothingmore";
  var_8[var_8.size] = "enemyhq_mrk_morepatrolsnosign";
  var_8[var_8.size] = "enemyhq_mrk_thatsjustanenemy";
  var_9 = [];
  var_9[var_9.size] = "enemyhq_mrk_lookaroundthepress";
  var_9[var_9.size] = "enemyhq_mrk_iseeactivityon";
  var_9[var_9.size] = "enemyhq_mrk_checkoutthevip";
  var_10 = 0;
  var_11 = gettime() + 25000;
  var_12 = 0;

  for(;;) {
    if(var_11 < gettime()) {
      var_11 = gettime() + 35000;
      thread maps\_utility::smart_radio_dialogue(var_9[var_10]);
      var_10++;

      if(var_10 >= var_9.size)
        var_10 = 0;
    }

    var_13 = level.player getplayerangles();
    var_14 = anglesToForward(var_13);

    if(common_scripts\utility::flag("bishop_glimpse_lookflag")) {
      if(level.remote_turret_current_fov <= 6 && var_13[0] > 0.5 && var_13[0] < 2.2 && var_13[1] > -100 && var_13[1] < -97.5) {
        level.glimpse_time = gettime();
        common_scripts\utility::flag_set("bishop_glimpse");
        break;
      } else if(var_1 < gettime() && level.remote_turret_current_fov <= 30) {
        thread maps\_utility::smart_radio_dialogue(var_3[var_2]);
        var_2++;

        if(var_2 >= var_3.size)
          var_2 = 0;

        var_1 = gettime() + var_4;
        var_4 = var_4 * 1.5;
      }
    }

    if(level.remote_turret_current_fov < 45) {
      foreach(var_16 in var_6) {
        if(!isDefined(var_16.found)) {
          var_17 = vectornormalize(var_16.origin - level.player.origin);
          var_18 = vectordot(var_17, var_14);
          var_19 = 0.9975;

          if(isDefined(var_16.script_parameters))
            var_19 = int(var_16.script_parameters);

          if(var_18 > var_19) {
            var_16.found = 1;
            var_5[var_16.script_noteworthy]++;
            break;
          }
        }
      }
    }

    var_21 = 1;

    if(var_13[1] > -104 && var_13[1] < -94 && var_13[0] < 10)
      var_21 = 0;

    if(var_21 && var_7 < gettime() && level.remote_turret_current_fov < 25) {
      var_7 = gettime() + 1000;
      var_22 = 0;
      var_23 = [];

      foreach(var_25 in level.drones["axis"].array) {
        if(isDefined(var_25.found)) {
          continue;
        }
        var_17 = vectornormalize(var_25.origin - level.player.origin);
        var_18 = vectordot(var_17, var_14);

        if(var_18 > 0.998) {
          var_23[var_23.size] = var_25;
          var_22++;
        }

        if(var_22 >= 3) {
          foreach(var_27 in var_23)
          var_27.found = 1;

          thread maps\_utility::smart_radio_dialogue(var_8[var_12]);
          var_12++;

          if(var_12 >= var_8.size)
            var_12 = 0;

          var_7 = gettime() + 8000;
          break;
        }
      }
    }

    if(var_5["field_area"] == 3) {
      var_5["field_area"]++;
      thread maps\_utility::smart_radio_dialogue("enemyhq_mrk_doesntlooklikehes_2");
    }

    if(var_5["field_area"] == 6) {
      var_5["field_area"]++;
      thread maps\_utility::smart_radio_dialogue("enemyhq_mrk_fieldclear");
    }

    if(var_5["stadium_left"] == 4) {
      var_5["stadium_left"]++;
      thread maps\_utility::smart_radio_dialogue("enemyhq_mrk_leftsideclear");
    }

    if(var_5["stadium_right"] == 4) {
      var_5["stadium_right"]++;
      thread maps\_utility::smart_radio_dialogue("enemyhq_mrk_rightsideclear");
    }

    if(var_5["armada"] == 4)
      var_5["armada"]++;

    wait 0.05;
  }
}

bishop_in_crosshairs() {
  level endon("intro_done");

  for(;;) {
    if(isDefined(level.remote_turret_trace["entity"])) {
      var_0 = level.remote_turret_trace["entity"];

      if(isai(var_0) && var_0.team == "allies" && level.remote_turret_current_fov < 4) {
        common_scripts\utility::flag_set("bishop_in_crosshairs");
        break;
      }
    }

    wait 0.05;
  }
}

bishop_glimpse() {
  var_0 = common_scripts\utility::getstruct("vip_sniper_breach_struct", "targetname");
  var_1 = maps\_utility::spawn_targetname("bishop_tease_hech", 1);
  var_1.animname = "bishop";
  var_1.disable_sniper_outline = 1;
  var_1.script_friendname = "Ajax";
  var_1.name = "Ajax";
  var_2 = maps\enemyhq_code::array_spawn_targetname_allow_fail("bishop_tease");
  var_2[0].animname = "bish_e1";
  var_2[1].animname = "bish_e2";
  var_2[2].animname = "bish_e3";
  var_2[var_2.size] = var_1;
  var_2[3] maps\_utility::gun_remove();
  var_3 = maps\_utility::spawn_anim_model("mr_chair");
  var_4 = maps\_utility::spawn_anim_model("mr_chair");
  var_4 setModel("dub_restaurant_chair_dirty_01b");
  var_4 linkto(var_3, "J_Prop_1");
  var_5 = [var_2[0], var_2[2]];
  var_6 = [var_1, var_3, var_2[1]];
  var_0 maps\_anim::anim_first_frame([var_3], "bishop_glimpse");
  var_7 = 2.8;
  level.start_len = 2.5;
  var_7 = 1.3;
  level.start_len = 2.7;
  wait 0.05;
  level.start_anim_time = gettime() - level.start_len * 1000;
  var_0 thread maps\_anim::anim_loop(var_2, "bishop_glimpse_loop");
  common_scripts\utility::flag_wait("bishop_glimpse");
  common_scripts\utility::array_thread(var_2, maps\_utility::anim_stopanimscripted);
  waittillframeend;
  var_0 thread maps\_anim::anim_single(var_2, "bishop_glimpse");
  var_8 = 11800;
  level.time_cut = var_8;
  level thread maps\_utility::notify_delay("identify_vo_timeout", var_8 / 1000);
  thread bishop_in_crosshairs();
  common_scripts\utility::flag_wait("bishop_glimpse_over");
  wait 0.2;
  common_scripts\utility::array_call(var_2, ::delete);
  var_4 delete();
}

glimpsethefuture(var_0, var_1) {
  var_2 = var_1 / getanimlength(level.scr_anim["bish_e1"]["bishop_glimpse"]);
  level.future_start_percent = var_2;

  foreach(var_4 in var_0)
  var_4 setanimtime(maps\_utility::getanim_from_animname("bishop_glimpse", var_4.animname), level.future_start_percent);
}

intro_dof(var_0) {
  level notify("stop_introdof");
  level endon("stop_introdof");

  if(isDefined(var_0)) {
    var_1 = var_0;
    maps\_art::dof_enable_script(50, 55, 10, 60, 65, 10, var_1);
    wait(var_1);
    var_1 = var_0 * 2;
    maps\_art::dof_disable_script(var_1);
    wait(var_1);
    return;
  }

  var_1 = 4;
  maps\_art::dof_enable_script(50, 55, 8, 60, 65, 8, var_1);
  wait(var_1);
  var_1 = 1;
  maps\_art::dof_disable_script(var_1);
  wait(var_1);
  common_scripts\utility::flag_set("finished_intro_dof");
}

opening_view_anims(var_0) {
  maps\_utility::delaythread(5, ::player_get_mk32);
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  var_2 = var_1;
  var_3 = maps\_utility::spawn_anim_model("remote_sniper");
  var_4 = maps\_utility::spawn_anim_model("remote_sniper");
  var_4 setModel("weapon_remote_sniper_gun");
  var_5 = maps\_utility::spawn_anim_model("remote_sniper");
  var_5 setModel("weapon_remote_sniper_tripod");
  var_4 linkto(var_3, "j_prop_2");
  var_5 linkto(var_3, "j_prop_1");
  level.prop_sentry = var_3;
  level.intro_anim_from = var_1;
  level.intro_anim_from_keegan = var_2;
  level.allies[0].goalradius = 128;
  level.vines = maps\_utility::spawn_anim_model("viney");
  level.vines setModel("ehq_intro_window_vines_anim");
  var_6 = level.allies[0] gettagorigin("tag_weapon_left");
  level.bone = spawn("script_model", var_6);
  level.bone setModel("mil_mre_chocolate02");
  level.bone linkto(level.allies[0], "tag_weapon_left", (0, 0, 0), (0, 0, 0));
  level.allies[1] thread end_anim_then_loop(var_2, "intro_loop_keegan", "stop_intro_loop", 1);
  level.allies[2] thread end_anim_then_loop(var_1, "intro_player_loop", "stop_intro_loop", 0);
  var_2 maps\_anim::anim_first_frame([level.prop_sentry], "intro_player");
  var_1 maps\_anim::anim_first_frame([level.allies[2], level.dog], "intro_player");
  var_1 thread maps\_anim::anim_single([level.allies[0], level.vines], "intro_player");
  thread maps\enemyhq_audio::aud_intro_keegan_tinkering();
  var_2 thread maps\_anim::anim_single([level.allies[1]], "intro_player");
}

anim_intro_dog(var_0) {
  level.intro_anim_from maps\_anim::anim_single([level.allies[2], level.dog], "intro_player");
}

anim_intro_sniper(var_0) {
  level.intro_anim_from_keegan maps\_anim::anim_single([level.prop_sentry], "intro_player");
}

anim_drop_bone(var_0) {
  level.bone unlink();
}

end_anim_then_loop(var_0, var_1, var_2, var_3) {
  wait 0.1;
  self waittillmatch("single anim", "end");

  if(var_3) {
    if(common_scripts\utility::flag("picked_up_mk32"))
      return;
  }

  var_0 thread maps\_anim::anim_loop_solo(self, var_1, var_2);
  level waittill("stop_intro_loop");
  var_0 notify("stop_intro_loop");
}

trig_active_on_look(var_0, var_1, var_2) {
  common_scripts\utility::trigger_off();
  var_3 = 0;

  while(!common_scripts\utility::flag(var_2)) {
    var_4 = anglesToForward(level.player.angles);
    var_5 = vectornormalize(var_0 - level.player.origin);
    var_6 = vectordot(var_4, var_5);

    if(var_3 && var_6 < var_1) {
      var_3 = 0;
      common_scripts\utility::trigger_off();
    } else if(!var_3 && var_6 >= var_1) {
      var_3 = 1;
      common_scripts\utility::trigger_on();
    }

    wait 0.05;
  }
}

handle_intro_ammo_counter() {
  while(isDefined(level.sniper_wait_extra_black))
    wait 0.05;

  setsaveddvar("ammoCounterHide", 1);
}

pickup_mk32(var_0) {
  var_1 = getent("mk32_noglow", "targetname");
  var_2 = getent("mk32_glowy", "targetname");
  var_2 hide();
  thread opening_view_anims("sniper_placement_merrick");
  maps\_utility::enable_trigger_with_targetname("picked_up_mk32");
  var_3 = common_scripts\utility::getstruct("mk32_noglow_lookstruct", "targetname");
  var_4 = getent("picked_up_mk32", "targetname");
  var_4 thread trig_active_on_look(var_3.origin, 0.8, "picked_up_mk32");
  common_scripts\utility::flag_wait_or_timeout("picked_up_mk32", 10);
  var_1 delete();

  if(!common_scripts\utility::flag("picked_up_mk32"))
    var_2 show();

  var_5 = common_scripts\utility::getstruct("sniper_placement_forward", "targetname");
  thread convoy();
  common_scripts\utility::flag_wait("picked_up_mk32");
  setsaveddvar("ammoCounterHide", 0);
  thread intro_helis_overhead();
  level.prop_sentry setanimtime(maps\_utility::getanim_from_animname("intro_player", "remote_sniper"), 1);
  thread maps\enemyhq_audio::aud_pickup_mk32();
  var_2 delete();
  level.player disableweaponswitch();
  maps\enemyhq_code::safe_disable_trigger_with_targetname("picked_up_mk32");
  maps\enemyhq_code::setupplayerforgameplay();
  level.player giveweapon(level.player_mk32);
  level.player switchtoweapon(level.player_mk32);
  wait 0.1;
  var_6 = spawn("script_model", level.player.origin);
  var_6 setModel("viewmodel_mk32_dud_bolt_ring_off");
  var_6 linktoplayerview(level.player, "J_Ammo1_Cap", (0, 0, 0), (0, 0, 0), 1);

  if(level.start_point != "introshoot")
    wait 2.6;
  else
    wait 3.1;

  var_6 unlinkfromplayerview(level.player);
  var_6 delete();
}

intro_helis_overhead() {
  var_0 = thread maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(988);
  wait 1;

  foreach(var_2 in var_0) {
    var_2 setmaxpitchroll(20, 60);
    var_2 setturningability(1);
  }
}

fast_convoy() {
  level endon("stop_fast_convoy");
  level endon("stop_convoy");
  var_0 = getEntArray("intro_convoy_fast", "targetname");
  wait 8;
  var_1 = 0;

  while(var_1 < 2) {
    var_2 = var_0[0];
    var_1++;
    var_3 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
    thread maps\enemyhq_audio::aud_convoy_start(var_3);
    var_3.cargo = [];
    wait(randomfloatrange(1.2, 2));
  }

  while(level.player_hit_convoy < 3) {
    level waittill("safe_spawn_fast");
    var_2 = var_0[0];
    var_1++;
    var_3 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
    thread maps\enemyhq_audio::aud_convoy_start(var_3);
    var_3.cargo = [];
  }
}

convoy() {
  common_scripts\utility::flag_wait("start_convoy");
  maps\_utility::delaythread(11, common_scripts\utility::flag_set, "intro_littlebirds");
  wait 2;
  thread fast_convoy();
  level.allies[0] thread ally_shoot_convoy();
  level endon("stop_convoy");
  thread watch_convoy_trig();
  level.player_hit_convoy = 0;
  var_0 = 0;
  var_1 = getEntArray("intro_convoy", "targetname");
  var_2 = undefined;
  var_3 = 1;
  var_4 = 10;

  while(var_3 < var_4) {
    if(var_3 % 3)
      var_5 = var_1[0];
    else
      var_5 = var_1[1];

    level thread maps\_utility::notify_delay("safe_spawn_fast", 10);
    var_2 = var_5 maps\_vehicle::spawn_vehicle_and_gopath();
    thread maps\enemyhq_audio::aud_convoy_start(var_2);
    var_2.cargo = [];

    if(common_scripts\utility::string_starts_with(var_2.classname, "script_vehicle_man_7t"))
      var_2 load_up();

    var_0++;

    if(var_3 % 3)
      wait(randomfloatrange(3, 4));
    else
      wait(randomfloatrange(2.5, 3));

    var_3++;

    if(level.player_hit_convoy > 0)
      var_4 = 6;
  }

  level.last_spawned_veh = var_2;
  level notify("stop_fast_convoy");
  level waittill("stop_convoy");
}

load_up() {
  var_0 = [];
  var_0[var_0.size] = "com_ammo_pallet";
  var_0[var_0.size] = "berlin_barrelcluster_pallet_01";
  var_0[var_0.size] = "shipping_frame_boxes";
  var_0[var_0.size] = "com_ammo_pallet";
  var_0[var_0.size] = "shipping_frame_boxes";
  var_0[var_0.size] = "empty";
  var_1 = 3;
  var_2 = anglesToForward(self gettagangles("tag_body"));

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = randomint(var_0.size);

    if(var_0[var_4] == "empty") {
      continue;
    }
    var_5 = self gettagorigin("tag_body") + var_2 * -80 * var_3;
    self.cargo[self.cargo.size] = spawn("script_model", var_5);
    self.cargo[self.cargo.size - 1].angles = self gettagangles("tag_body");
    self.cargo[self.cargo.size - 1] setModel(var_0[var_4]);
    self.cargo[self.cargo.size - 1] linkto(self);
    self.cargo[self.cargo.size - 1].linked_vehicle = self;
  }
}

watch_convoy_trig() {
  var_0 = getent("convoy_touchup", "targetname");

  while(isDefined(var_0)) {
    var_0 waittill("trigger", var_1);

    if(isDefined(level.last_spawned_veh) && var_1 == level.last_spawned_veh)
      var_0 delete();

    foreach(var_3 in var_1.cargo)
    var_3 delete();

    var_1 delete();
  }
}

player_get_mk32() {
  wait 4;

  if(!common_scripts\utility::flag("picked_up_mk32")) {
    level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_grabthatgrenadelauncher");
    var_0 = 0;
    var_1 = 0.2;
    var_2 = 8;

    for(;;) {
      wait(var_1);

      if(common_scripts\utility::string_starts_with(level.player getcurrentprimaryweapon(), "mk32_du")) {
        break;
      }

      var_0++;

      if(var_0 * var_1 > var_2) {
        level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_pickupthelauncher");
        var_2 = var_2 * 1.5;
        var_0 = 0;
      }
    }
  }

  level.allies[0] maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_thegrenadesareon");
  common_scripts\utility::flag_set("start_convoy");
  wait 4.5;
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_heretheycometag");
}

keegan_tinkers_with_rifle() {
  level waittill("stop_intro_loop");
  wait 0.1;
  level.allies[1] maps\_utility::enable_ai_color();
  maps\enemyhq_code::safe_activate_trigger_with_targetname("keegan_post_tinker");
  var_0 = getnode("keegan_please_shift_it", "targetname");
  level.allies[1] setgoalnode(var_0);
  level.allies[1].goalradius = 64;
  wait 0.2;
  level.allies[1] maps\_utility::gun_recall();
}

go_street() {
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_convoyclearletsmove");
  common_scripts\utility::flag_set("intro_done");
  thread maps\enemyhq_audio::aud_convoy_done();
  common_scripts\utility::flag_waitopen_or_timeout("player_looking_out_window", 5);
  level notify("keegan_stop_tinkering");
  level notify("stop_intro_loop");
  waittillframeend;
  var_0 = getent("beta_blocker_player_clip", "targetname");

  if(isDefined(var_0))
    var_0 notsolid();

  common_scripts\utility::flag_set("FLAG_move_to_player_truck");

  if(isDefined(level.intro_grenades)) {
    level.player giveweapon("fraggrenade");
    level.player setweaponammoclip("fraggrenade", level.intro_grenades);
  }
}

merrick_look_at_flyby() {
  wait 2;
  level.allies[0] maps\_utility::disable_ai_color();
  var_0 = common_scripts\utility::getstruct("merrick_plane_look", "targetname");
  level.allies[0].animname = "baker";
  var_0 maps\_anim::anim_reach_solo(level.allies[0], "merrick_intro_watch_planes");
  var_0 maps\_anim::anim_single_solo(level.allies[0], "merrick_intro_watch_planes");
  common_scripts\utility::flag_set("merrick_done_lookat");
  level notify("merrick_done_lookat");
}

ally_shoot_convoy() {
  level endon("stop_convoy");
  self.old_weapon = self.weapon;
  self notify("got_mk32dud");
  thread ally_grenade();
  anim.grenadetimers["AI_teargas_grenade"] = randomintrange(0, 20000);
  var_0 = self;
  var_1 = getent("stick_me", "targetname");
  var_2 = 0;
  var_3 = 0;
  thread watch_last_truck();

  for(;;) {
    var_1 waittill("trigger", var_4);

    if(var_4 maps\_vehicle::isvehicle() && var_0 != var_4) {
      var_0 = var_4;
      self setentitytarget(var_4);
      wait 0.5;
      var_5 = self getmuzzlepos();
      var_6 = var_4.origin + (0, 0, 90);
      wait 0.5;
      self clearentitytarget(var_4);
      var_2++;

      if(level.player_hit_convoy == 0 && common_scripts\utility::mod(var_2, 4) == 0) {
        if(var_2 < 5)
          level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_tagthetrucks");
        else
          level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_logantagem");
      }

      continue;
    }

    wait 1.2;
  }
}

watch_last_truck() {
  var_0 = getent("stick_me", "targetname");
  var_1 = level.player;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(var_1 == var_2) {
      continue;
    }
    var_1 = var_2;

    if(isDefined(level.last_spawned_veh) && var_2 == level.last_spawned_veh) {
      wait 3;

      if(level.player_hit_convoy == 0) {
        setdvar("ui_deadquote", &"ENEMY_HQ_YOU_FAILED_TO_HIT_ENOUGH");
        maps\_utility::missionfailedwrapper();
        wait 20;
      }

      level notify("stop_convoy");
      break;
    }
  }
}

ally_grenade() {
  level endon("intro_done");

  for(;;) {
    level.allies[0] waittill("missile_fire", var_0, var_1);
    playFXOnTag(common_scripts\utility::getfx("vfx_glow_stickyg_static"), var_0, "tag_origin");
    var_0.ally_fired = 1;
    var_0 thread track_dud();
  }
}

handle_m32_launcher() {
  level notify("watching_player_mk32");
  level endon("watching_player_mk32");
  level endon("death");
  level.mk32_intro_fire = 0;
  thread maps\enemyhq_audio::aud_listen_mk32_reload();

  for(;;) {
    level.player waittill("grenade_fire", var_0, var_1);

    if(common_scripts\utility::string_starts_with(var_1, "mk32_du")) {
      var_2 = level.player getweaponammoclip("mk32_dud+eotech_sp_mk32dud");

      if(var_2 == 0)
        level.player notify(level.c4_weaponname);

      playFXOnTag(common_scripts\utility::getfx("vfx_glow_stickyg_static"), var_0, "tag_origin");
      var_0.ally_fired = 0;

      if(level.mk32_intro_fire)
        var_0 thread track_dud();
      else
        var_0 thread track_live();
    }
  }
}

handle_sticky_clacker() {
  self endon("death");
  var_0 = 0;
  level.num_active_clacks = 0;

  for(;;) {
    var_1 = common_scripts\utility::waittill_any_return("sticky_gone_boom", "new_sticky_attached", "clack_stickies");
    var_2 = getEntArray("live_sticky_grenade", "targetname");

    if(var_1 == "sticky_gone_boom") {
      if(var_2.size == 0)
        self notify("cancel_clacker_ui");

      continue;
    }

    if(var_1 == "clack_stickies") {
      level.my_clack_num = 0;
      level.player notify("exploderize_me");
      self notify("cancel_clacker_ui");
      continue;
    }

    if(var_1 == "new_sticky_attached") {
      if(var_2.size == 1) {
        var_0 = 1;
        thread watch_clacker();
      }
    }
  }
}

safe_switch_to_detonator() {
  while(level.switching_from_detonator)
    wait 0.05;

  level.switching_to_detonator = 1;
  level.preclack_weapon = self getcurrentweapon();
  self giveweapon(level.c4_weaponname);
  self setweaponammoclip(level.c4_weaponname, 0);
  self switchtoweapon(level.c4_weaponname);
  self disableweaponswitch();
  self disableweaponpickup();
  self waittill("weapon_change", var_0);
  level.switching_to_detonator = 0;
}

safe_switch_from_detonator() {
  while(level.switching_to_detonator)
    wait 0.05;

  level.switching_from_detonator = 1;
  self switchtoweapon(level.preclack_weapon);
  self waittill("weapon_change");
  self takeweapon(level.c4_weaponname);
  level.switching_from_detonator = 0;
  self enableweaponswitch();
  self enableweaponpickup();
}

watch_clacker() {
  self endon("death");
  self notify("stop_watch_clacker");
  self endon("stop_watch_clacker");
  self notifyonplayercommand(level.c4_weaponname, "+actionslot 4");
  self setweaponhudiconoverride("actionslot4", "inventory_stickybomb");
  refreshhudammocounter();
  var_0 = common_scripts\utility::waittill_any_return("cancel_clacker_ui", level.c4_weaponname);

  if(var_0 == "cancel_clacker_ui") {
    self setweaponhudiconoverride("actionslot4", "none");
    self notifyonplayercommand("", "+actionslot 4");
    refreshhudammocounter();
    return;
  }

  thread safe_switch_to_detonator();

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("detonate", level.c4_weaponname, "cancel_clacker_ui");
    thread safe_switch_from_detonator();

    if(var_0 == "detonate") {
      self notify("clack_stickies");
      self setweaponhudiconoverride("actionslot4", "none");
      self notifyonplayercommand("", "+actionslot 4");
      refreshhudammocounter();
      return;
    } else {
      if(var_0 == level.c4_weaponname) {
        self setweaponhudiconoverride("actionslot4", "none");
        self notifyonplayercommand("", "+actionslot 4");
        thread watch_clacker();
        wait 1;
        continue;
      }

      if(var_0 == "cancel_clacker_ui") {
        self setweaponhudiconoverride("actionslot4", "none");
        self notifyonplayercommand("", "+actionslot 4");
        refreshhudammocounter();
        return;
      } else {
        iprintlnbold("WATCH CLACKER messedup- got unknown message");
        return;
      }
    }
  }
}

track_live() {
  level.player endon("death");
  var_0 = self.origin;
  self waittill("explode", var_1);

  if(!isDefined(self)) {
    return;
  }
  stopFXOnTag(common_scripts\utility::getfx("vfx_glow_stickyg_static"), self, "tag_origin");

  if(level.mk32_mode != "delay") {
    var_2 = length(level.player.origin + (0, 0, 36) - self.origin);

    if(var_2 > 256) {
      magicgrenademanual("fraggrenade", var_1, (0, 0, 0), 0);
      return;
    }
  }

  var_3 = (var_0 - var_1) / 2;
  var_0 = var_3 + var_1;
  var_1 = var_1 - var_3;
  var_4 = 6;
  var_5 = bulletTrace(var_0, var_1, 1, level.player, 1, 1);

  if(isDefined(var_5) && isDefined(var_5["position"])) {
    var_1 = var_5["position"] + var_5["normal"] * 1;
    var_6 = spawn("script_model", var_1);
    var_6 setModel("weapon_sticky_grenade");
    var_6.angles = vectortoangles(var_5["normal"]);
    var_6.targetname = "live_sticky_grenade";
    var_7 = common_scripts\utility::spawn_tag_origin();
    var_8 = undefined;
    var_9 = 1;

    if(isDefined(var_5["entity"])) {
      var_10 = var_5["entity"];

      if(isai(var_10) && isalive(var_10)) {
        var_11 = 1;

        if(!var_10.delayeddeath && !isDefined(var_10.melee) && (!isDefined(var_10.magic_bullet_shield) || var_10.magic_bullet_shield == 0)) {
          var_10 thread maps\_utility::magic_bullet_shield(1);
          var_11 = 0;
        } else
          var_9 = 0;

        var_10 thread do_dud_damage(var_0, var_1);
        var_10 waittill("damage", var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21);

        if(!var_11)
          var_10 maps\_utility::stop_magic_bullet_shield();

        var_22 = "";

        if(isDefined(var_19) && var_19 != "")
          var_22 = var_19;
        else if(isDefined(var_18) && var_18 != "")
          var_22 = var_18;

        if(var_22 != "")
          var_6 linkto(var_10, var_22);
        else
          var_9 = 0;
      } else
        var_6 linkto(var_10);
    }

    if(var_9) {
      var_7 linkto(var_6);
      playFXOnTag(common_scripts\utility::getfx("vfx_glow_stickyg_blink"), var_7, "tag_origin");
      wait 7;
      stopFXOnTag(common_scripts\utility::getfx("vfx_glow_stickyg_blink"), var_7, "tag_origin");
      var_7 unlink();
      var_7 delete();
      var_6 unlink();
    }

    var_6 delete();
  }
}

do_dud_damage(var_0, var_1) {
  wait 0.05;
  magicbullet("nosound_magicbullet", var_0, var_1, level.player);
}

track_dud() {
  level endon("death");
  var_0 = self.origin;
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 linkto(self);
  thread maps\enemyhq_audio::aud_mk32_dud_beep(var_1);
  self waittill("explode", var_2);

  if(!isDefined(self)) {
    return;
  }
  stopFXOnTag(common_scripts\utility::getfx("vfx_glow_stickyg_static"), self, "tag_origin");
  var_3 = self.ally_fired;
  var_1 unlink();
  var_4 = (var_0 - var_2) / 2;
  var_0 = var_4 + var_2;
  var_2 = var_2 - var_4;
  var_5 = bulletTrace(var_0, var_2, 1, level.player, 1, 1);

  if(isDefined(var_5) && isDefined(var_5["position"])) {
    var_6 = "default";

    if(isDefined(var_5["surfacetype"]))
      var_6 = var_5["surfacetype"];

    var_2 = var_5["position"] + var_5["normal"] * 1.5;
    var_7 = spawn("script_model", var_2);
    var_7 setModel("weapon_sticky_grenade");
    var_7.angles = vectortoangles(var_5["normal"]);
    var_8 = undefined;
    var_9 = undefined;

    if(isDefined(var_5["entity"])) {
      var_9 = var_5["entity"];

      if(isDefined(var_9.linked_vehicle))
        var_9 = var_9.linked_vehicle;
    }

    if(isDefined(var_9) && (var_9 == level.player_truck || isai(var_9) && var_9.team == "allies")) {
      if(var_9 == level.player_truck)
        setdvar("ui_deadquote", &"ENEMY_HQ_YOUR_ACTIONS_COMPROMISED");
      else
        setdvar("ui_deadquote", &"ENEMY_HQ_FRIENDLY_FIRE_WILL_NOT");

      maps\_utility::missionfailedwrapper();
      wait 10;
    }

    var_10 = 0;

    if(isDefined(var_9) && var_9 maps\_vehicle::isvehicle()) {
      var_10 = 1;

      if(!isDefined(var_9.already_stuck) && var_3 == 0) {
        var_9.already_stuck = 0;

        if(level.player_hit_convoy < 5 && level.player_hit_convoy % 2 == 0)
          thread player_hit_vo(var_9.vehicletype, level.player_hit_convoy);

        level.player_hit_convoy++;
        level.player notify("player_tagged_truck");
      }

      var_7 linkto(var_9);
    }

    var_1 linkto(var_7);
    thread maps\enemyhq_audio::aud_mk32_dud_beep_hit(var_1, var_10, var_6);
    playFXOnTag(common_scripts\utility::getfx("vfx_glow_stickyg_blink"), var_1, "tag_origin");
    wait 0.6;
    wait 7;
    stopFXOnTag(common_scripts\utility::getfx("vfx_glow_stickyg_blink"), var_1, "tag_origin");
    var_1 unlink();
    var_1 delete();
    var_7 unlink();
    var_7 delete();
  } else
    var_1 delete();
}

player_hit_vo(var_0, var_1) {
  if(!isDefined(level.hit_vo))
    level.hit_vo = 0;

  var_2 = [];
  var_2[var_2.size] = "enemyhq_mrk_thatsahit";
  var_2[var_2.size] = "enemyhq_mrk_confirmedhit";
  var_2[var_2.size] = "enemyhq_mrk_thatstuck";
  var_2[var_2.size] = "enemyhq_mrk_gotit";
  var_2[var_2.size] = "enemyhq_mrk_ontarget";
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go(var_2[level.hit_vo]);
  level.hit_vo++;

  if(level.hit_vo >= var_2.size)
    level.hit_vo = 0;
}

watch_for_remote_turret_activate(var_0) {
  self endon("death");
  self notify("stop_watching_remote_sniper");
  self endon("stop_watching_remote_sniper");
  var_1 = common_scripts\utility::getstruct("sniper_placement", "targetname");
  var_2 = common_scripts\utility::getstruct("sniper_teleport_default", "targetname");

  for(;;) {
    self waittill("use_remote_turret");

    if(self getstance() == "prone")
      self setstance("crouch");

    var_3 = var_2.origin + anglesToForward(var_2.angles) * var_0;
    var_4 = var_2.angles;
    maps\enemyhq_remoteturret::remote_turret_activate("remote_sniper", var_3, var_4, level.remote_turret_right_arc, level.remote_turret_left_arc, level.remote_turret_top_arc, level.remote_turret_bottom_arc);
    var_5 = common_scripts\utility::waittill_any_return("use_remote_turret", "remote_turret_deactivate");

    if(var_5 == "use_remote_turret") {
      setsaveddvar("cg_cinematicFullScreen", "0");
      thread maps\enemyhq_code::set_black_fade(1, 0.1);
      self notify("remote_turret_nozoom");
      wait 0.2;
      var_6 = 0;

      if(isDefined(level.sniper_wait_extra_black)) {
        var_6 = level.sniper_wait_extra_black;

        if(isDefined(level.ps3) && level.ps3)
          var_6 = var_6 + 0.75;
      }

      self giveweapon("remote_tablet_nopullout");
      level.pre_sniping_weapon = "remote_tablet_nopullout";
      thread maps\enemyhq_remoteturret::remote_turret_deactivate();

      if(var_6)
        wait(var_6);

      cinematicingame("ehq_tablet_outro");
      wait 0.1;
      self giveweapon(self.presniper_weapon, 0, 0, 0, 1);
      self setweaponammoclip(self.presniper_weapon, self.presniper_weapon_clip);
      self setweaponammostock(self.presniper_weapon, self.presniper_weapon_stock);
      self switchtoweapon(self.presniper_weapon);
      self notify("remote_sniper_pad_down");
      wait 0.9;
      thread maps\enemyhq_code::set_black_fade(0, 0.1);
      wait 0.1;
      self.ignoreme = 0;
      self.allow_dry_fire = 0;

      if(isDefined(level.presnipe_grenades)) {
        level.player giveweapon("fraggrenade");
        level.player setweaponammoclip("fraggrenade", level.presnipe_grenades);
        level.presnipe_grenades = undefined;
      }

      wait 0.1;
      wait 1.5;
      self takeweapon("remote_tablet");
      self takeweapon("remote_tablet_nopullout");
    }
  }
}

handle_loopers() {
  var_0 = maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(983);
  common_scripts\utility::array_thread(var_0, ::handle_looper);
}

handle_looper() {
  self endon("kill_war_ambiance");
  var_0 = self.origin;
  var_1 = self.angles;
  var_2 = self.target;

  for(;;) {
    self waittill("reached_dynamic_path_end");
    self hide();
    self vehicle_teleport(var_0, var_1);
    wait 0.1;
    self show();
    var_3 = common_scripts\utility::getstruct(var_2, "targetname");
    thread maps\_vehicle::vehicle_paths(var_3);
  }
}

cargo_choppers() {
  var_0 = getEntArray("intro_hide_on_load", "script_noteworthy");
  common_scripts\utility::array_call(var_0, ::show);
  common_scripts\utility::array_call(var_0, ::notsolid);
  var_1 = maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(982);
  thread handle_loopers();
  var_2 = getEntArray("cargo_heli_group2", "targetname");

  foreach(var_4 in var_2) {
    var_5 = getEntArray(var_4.script_noteworthy, "targetname");

    foreach(var_7 in var_5)
    var_7 hide();

    var_4.cargo_item_spawners = var_5;
  }

  var_10 = 0;

  for(var_11 = 1; var_11 > 0; var_11--) {
    for(var_12 = var_2.size; var_12 > 0; var_12--) {
      if(var_10 >= var_2.size)
        var_10 = 0;

      thread spawn_cargo_carrier(var_2[var_10]);
      var_10++;
    }
  }
}

spawn_cargo_carrier(var_0) {
  var_1 = maps\_vehicle::vehicle_spawn(var_0);
  wait 0.1;
  var_2 = var_0.cargo_item_spawners;
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_3[var_4] = spawn(var_2[var_4].classname, var_2[var_4].origin);
    var_3[var_4].angles = var_2[var_4].angles;

    if(var_3[var_4].classname == "script_model") {
      var_3[var_4] setModel(var_2[var_4].model);
      var_3[var_4] notsolid();
    }

    var_3[var_4] linkto(var_1);
  }

  wait 0.1;
  thread maps\_vehicle::gopath(var_1);
  var_1 waittill("death");

  foreach(var_6 in var_3)
  var_6 delete();
}

air_armada() {
  var_0 = getEntArray("air_armada", "targetname");
  common_scripts\utility::array_thread(var_0, ::oneshot_armada, 60000, 15);
  var_0 = getEntArray("air_armada_looper", "targetname");
  common_scripts\utility::array_thread(var_0, ::loop_armada, 140000, 28);
}

oneshot_armada(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 20000;

  if(!isDefined(var_1))
    var_1 = int(self.script_noteworthy);

  var_2 = anglesToForward(self.angles);
  var_3 = self.origin + var_2 * var_0;
  self moveto(var_3, var_1, 1, 1);
  wait(var_1);
  self delete();
}

loop_armada(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 30000.0;

  if(!isDefined(var_1))
    var_1 = int(self.script_noteworthy) * 1.5;

  var_1 = var_1 + (randomfloat(2) - 1);
  self endon("kill_war_ambiance");
  var_2 = self.origin;
  var_3 = self.angles;

  for(;;) {
    var_4 = anglesToForward(self.angles);
    var_5 = self.origin + var_4 * var_0;
    self moveto(var_5, var_1, 1, 1);
    thread maps\enemyhq_audio::aud_fx_planes();
    wait(var_1);
    self hide();
    wait(randomfloatrange(3, 8));
    self.origin = var_2;
    self.angles = var_3;
    wait 0.1;
    self show();
  }
}

ship_vista() {
  var_0 = getEntArray("ship_cards", "script_noteworthy");
  var_1 = 30000.0;
  var_2 = 300;

  foreach(var_4 in var_0) {
    var_4.my_extra = 1;
    var_5 = 3;

    if(var_4.origin[1] > -30000)
      var_5 = 0;
    else if(var_4.origin[1] > -36000)
      var_5 = 1;
    else if(var_4.origin[1] > -42000) {
      var_4.my_extra = 1.5;
      var_5 = 2;
    } else
      var_4.my_extra = 2;

    var_6 = anglesToForward(var_4.angles);
    var_4.startpos = var_4.origin - var_6 * var_1 / 2;
    var_4.origpos = var_4.origin;
    var_4.startang = var_4.angles;
    var_4.dest = var_4.origin + var_6 * var_1 / 2 * var_4.my_extra;
    var_4.curr_movetime = var_2 / 2;
    var_4.my_speed = var_5;
    var_7 = spawn("script_model", var_4.startpos);
    var_7.startpos = var_7.origin;
    var_7.angles = var_4.angles;
    var_7.startang = var_7.angles;
    var_7.dest = var_4.dest;
    var_7.curr_movetime = var_2;
    var_7.my_speed = var_5;
    var_7 setModel(var_4.model);
    var_4 thread loop_new_ships();
    var_7 thread loop_new_ships();
  }
}

loop_new_ships() {
  var_0 = 30000.0;
  var_1 = 300;

  if(!isDefined(self.my_extra))
    self.my_extra = 1;

  self endon("kill_war_ambiance");
  var_2 = anglesToForward(self.angles);
  var_3 = [1, 1.3, 1.7, 2];

  for(;;) {
    self moveto(self.dest, self.curr_movetime * var_3[self.my_speed] * self.my_extra, 1, 1);
    wait(self.curr_movetime * var_3[self.my_speed] * self.my_extra);
    self.curr_movetime = var_1;
    self.origin = self.startpos;
    self.angles = self.startang;
  }
}

blow_wall() {
  common_scripts\utility::flag_wait("kick_off_atrium_combat");
  var_0 = getent("security_gate_crash_pieces2", "targetname");
  var_1 = common_scripts\utility::getstruct("player_teleport_atrium", "targetname");
  var_0.animname = "hamburg_security_gate_crash";
  common_scripts\utility::exploder(666);
  common_scripts\utility::exploder(777);
  playFXOnTag(level._effect["vfx_ehq_seat_trail"], var_0, "J_frag_05");
  playFXOnTag(level._effect["vfx_ehq_seat_trail"], var_0, "J_frag_17");
  playFXOnTag(level._effect["vfx_ehq_seat_trail"], var_0, "J_frag_23");
  playFXOnTag(level._effect["vfx_ehq_seat_trail"], var_0, "J_frag_28");
  playFXOnTag(level._effect["vfx_ehq_seat_trail"], var_0, "J_frag_49");
  playFXOnTag(level._effect["vfx_ehq_seat_trail"], var_0, "J_frag_51");
  playFXOnTag(level._effect["vfx_ehq_seat_trail"], var_0, "J_frag_30");
  var_0 useanimtree(level.scr_animtree[var_0.animname]);
  thread maps\enemyhq_code::play_rumble_seconds("damage_heavy", 1);
  var_1 thread maps\_anim::anim_single_solo(var_0, "security_gate_crash");
  wait 1;
  thread maps\enemyhq_code::play_rumble_seconds("damage_light", 1);
  wait 1.25;
  thread maps\enemyhq_code::play_rumble_seconds("damage_heavy", 1);
}

handle_intro_sniper_outline() {
  for(;;) {
    var_0 = gettime();
    var_1 = anglesToForward(level.player getplayerangles());
    var_2 = common_scripts\utility::array_combine(level.drones["axis"].array, getaiarray());

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(isDefined(var_4.dot_check_time) && var_4.dot_check_time > var_0) {
        continue;
      }
      var_5 = 0.998;
      var_6 = 0;
      var_7 = vectornormalize(var_4.origin - level.player.origin);

      if(vectordot(var_1, var_7) >= var_5)
        var_6 = 1;

      if(isDefined(var_4.has_target_shader) && var_4.has_target_shader && (!isDefined(var_4.disable_sniper_outline) || !var_4.disable_sniper_outline)) {
        if(var_6)
          continue;
      }

      if((!isDefined(var_4.has_target_shader) || var_4.has_target_shader == 0) && isDefined(var_4.disable_sniper_outline) && var_4.disable_sniper_outline) {
        continue;
      }
      if((!isDefined(var_4.disable_sniper_outline) || !var_4.disable_sniper_outline) && var_6) {
        var_4.has_target_shader = 1;

        if(var_4.team == "axis")
          var_4 maps\_utility::set_hudoutline("enemy", 1);
        else
          var_4 maps\_utility::set_hudoutline("friendly", 1);

        var_4.dot_check_time = var_0 + 2000;
        var_4 thread maps\enemyhq_remoteturret::remove_remote_turret_target_on_death();
        continue;
      }

      var_4.has_target_shader = 0;
      var_4 notify("remove_sniper_outline");
    }

    if(isDefined(level.dog)) {
      if(isDefined(level.dog.has_target_shader) && level.dog.has_target_shader && isDefined(level.dog.disable_sniper_outline) && level.dog.disable_sniper_outline) {
        level.dog hudoutlinedisable();
        level.dog.has_target_shader = 0;
      } else if((!isDefined(level.dog.has_target_shader) || !level.dog.has_target_shader) && (!isDefined(level.dog.disable_sniper_outline) || !level.dog.disable_sniper_outline)) {
        level.dog maps\_utility::set_hudoutline("friendly", 1);
        level.dog.has_target_shader = 1;
      }
    }

    wait 0.05;
  }
}

intro_plane_flyby_01() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_escort_01a");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("intro_escort_01b");
  var_2 = getEntArray("flybyA_hide_on_load", "script_noteworthy");
  common_scripts\utility::array_call(var_2, ::show);
  var_3 = getent("intro_transport_03", "targetname");
  var_4 = getent("intro_transport_04", "targetname");
  var_5 = getent("intro_transport_05", "targetname");
  var_3 thread maps\enemyhq_intro::intro_transport_mover(65000, 17);
  var_4 thread maps\enemyhq_intro::intro_transport_mover(65000, 17);
  var_5 thread maps\enemyhq_intro::intro_transport_mover(65000, 17);
}

watch_weaponswitch() {
  if(level.start_point != "introshoot") {
    wait 0.5;
    level.player waittill("weapon_change", var_0);
    level.player disableweaponswitch();
  }

  level.player disableweapons();
}

digital_malarky(var_0, var_1) {
  level.player digitaldistortsetparams(1, 0);
  wait 0.7;
  var_2 = 1;
  var_3 = 0.3;
  var_4 = var_2;

  if(isDefined(var_0))
    var_3 = var_0;

  var_5 = 1.25;

  if(isDefined(var_1))
    var_5 = var_1;

  var_6 = 0.05;
  var_7 = var_5 / var_6;
  var_8 = var_2 / var_7;
  var_9 = 90 / var_7;

  for(var_10 = 0; var_4 > var_8; var_10 = var_10 + var_9) {
    level.player digitaldistortsetparams(cos(var_10), var_3);
    wait 0.05;
    var_4 = var_4 - var_8;
  }

  level.player digitaldistortsetparams(0, 1);
}

swapout_mk32() {
  self giveweapon(level.player_intro_weapon);

  if(maps\_utility::player_has_weapon("m9a1"))
    self takeweapon("m9a1");

  if(maps\_utility::player_has_weapon("freerunner"))
    self takeweapon("freerunner");

  self enableweaponswitch();
  self enableweaponpickup();
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");
  level.mk32_intro_fire = 0;
}

text_3d_ent(var_0) {}

#using_animtree("generic_human");

pick_drone_patrol_anim() {
  var_0 = undefined;

  if(self.update_drone_anim) {
    var_0 = spawnStruct();

    if(randomint(5) == 1) {
      self.moveplaybackrate = randomfloatrange(0.9, 1.1);
      var_1 = % patrol_bored_patrolwalk_twitch;
    } else {
      self.moveplaybackrate = randomfloatrange(0.95, 1.05);
      var_1 = % patrol_bored_patrolwalk;
    }

    var_0.runanim = var_1;
    var_2 = maps\_drone::get_anim_data(var_0.runanim);
    var_0.anim_relative = var_2.anim_relative;
    var_0.run_speed = var_2.run_speed;
    return var_0;
  }

  return var_0;
}

pick_drone_gundown_anim() {
  var_0 = undefined;

  if(self.update_drone_anim) {
    var_0 = spawnStruct();
    self.update_drone_anim = 0;

    if(!randomint(5)) {
      self.moveplaybackrate = randomfloatrange(0.9, 1.1);
      var_1 = randomint(level.gundown_twitch.size);
      var_2 = level.gundown_twitch[var_1];
      self.gundown_walk = undefined;
    } else {
      self.moveplaybackrate = randomfloatrange(0.95, 1.05);

      if(!isDefined(self.gundown_walk)) {
        var_1 = randomint(level.gundown_patrol.size);
        self.gundown_walk = level.gundown_patrol[var_1];
      }

      var_2 = self.gundown_walk;
    }

    var_0.runanim = var_2;
    var_3 = maps\_drone::get_anim_data(var_0.runanim);
    var_0.anim_relative = var_3.anim_relative;
    var_0.run_speed = var_3.run_speed;
    return var_0;
  }

  return var_0;
}

watch_anim_end(var_0) {
  if(!isDefined(var_0))
    var_0 = "gundown";

  self endon("death");
  self endon("goal");
  self.update_drone_anim = 1;

  for(;;) {
    self waittillmatch("drone_anim", "end");
    self.update_drone_anim = 1;

    if(var_0 == "gundown")
      var_1 = pick_drone_gundown_anim();
    else
      var_1 = pick_drone_patrol_anim();

    if(!isDefined(self.last_runanim) || isDefined(var_1) && var_1.runanim != self.last_runanim) {
      self.last_runanim = var_1.runanim;
      var_2 = var_1.runanim;
      var_3 = var_1.run_speed;
      var_4 = var_1.anim_relative;

      if(!var_4)
        thread maps\_drone::drone_move_z(var_3);
      else
        self notify("drone_move_z");

      maps\_drone::drone_play_looping_anim(var_2, self.moveplaybackrate);
      wait 0.3;
    }
  }
}

pick_drone_gundown_dummy() {
  return undefined;
}

field_activity() {
  level.runanimdebug = 0;
  var_0 = maps\_utility::array_spawn_targetname("field_activity_drones");
  level.gundown_twitch = [ % patrol_bored_gundown_walk_twitch1, %patrol_bored_gundown_walk_twitch1, %patrol_bored_gundown_walk_twitch2, %patrol_bored_gundown_walk_twitch2, %patrol_bored_gundown_walk_twitch3, %patrol_bored_gundown_walk_twitch4, %patrol_bored_gundown_walk_twitch4];
  level.gundown_patrol = [ % patrol_bored_gundown_walk1, %patrol_bored_gundown_walk1, %patrol_bored_gundown_walk2, %patrol_bored_gundown_walk2, %patrol_bored_gundown_walk3];
  thread setup_soccer_scene();

  foreach(var_2 in var_0) {
    var_2.ignoreall = 1;

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "pushup_guy1") {
      var_2.animname = "generic";
      var_2 thread maps\_anim::anim_loop_solo(var_2, "intro_pushups1");
      continue;
    }

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "pushup_guy2") {
      var_2.animname = "generic";
      var_2 thread maps\_anim::anim_loop_solo(var_2, "intro_pushups2");
      continue;
    }

    if(!isDefined(var_2.script_patroller)) {
      if(randomint(4)) {
        var_2.debug_anim = 0;
        var_2.drone_move_time = -1;
        var_2 thread watch_anim_end();
        var_2.drone_move_callback = ::pick_drone_gundown_dummy;
        continue;
      }

      var_2 thread watch_anim_end("patrol");
      var_2.drone_move_time = -1;
      var_2.drone_move_callback = ::pick_drone_gundown_dummy;
    }
  }

  var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("field_activity_veh_01");
  var_5 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("field_activity_veh_02");
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

setup_soccer_scene() {
  var_0 = common_scripts\utility::getstruct("field_soccer_struct", "targetname");
  var_1 = getent("soccer_pass_guy1", "targetname");
  level.soccer_pass_guy1 = var_1 maps\_utility::spawn_ai(1);
  var_2 = getent("soccer_pass_guy2", "targetname");
  level.soccer_pass_guy2 = var_2 maps\_utility::spawn_ai(1);
  var_3 = getent("soccer_goal_guy1", "targetname");
  level.soccer_goal_guy1 = var_3 maps\_utility::spawn_ai(1);
  var_4 = getent("soccer_goal_guy2", "targetname");
  level.soccer_goal_guy2 = var_4 maps\_utility::spawn_ai(1);
  level.soccer_goal_guy1.animname = "soccer_goal_guy1";
  level.soccer_goal_guy2.animname = "soccer_goal_guy2";
  level.soccer_pass_guy1.animname = "soccer_pass_guy1";
  level.soccer_pass_guy2.animname = "soccer_pass_guy2";
  level.soccerball_goal = maps\_utility::spawn_anim_model("soccerball_goal", var_0.origin);
  level.soccerball_goal setModel("soccer_ball");
  level.soccerball_goal.animname = "soccerball_goal";
  level.soccerball_pass = maps\_utility::spawn_anim_model("soccerball_pass", var_0.origin);
  level.soccerball_pass setModel("soccer_ball");
  level.soccerball_pass.animname = "soccerball_pass";
  var_5 = [];
  var_5[0] = level.soccer_pass_guy1;
  var_5[1] = level.soccer_pass_guy2;
  var_5[2] = level.soccerball_pass;
  var_6 = [];
  var_6[0] = level.soccer_goal_guy1;
  var_6[1] = level.soccer_goal_guy2;
  var_6[2] = level.soccerball_goal;
  var_0 thread maps\_anim::anim_loop(var_5, "soccer_scene_pass");
  var_0 thread maps\_anim::anim_loop(var_6, "soccer_scene_goal");
  common_scripts\utility::flag_wait("FLAG_player_enter_truck");

  foreach(var_8 in var_5) {
    if(isDefined(var_8))
      var_8 delete();
  }

  foreach(var_8 in var_6) {
    if(isDefined(var_8))
      var_8 delete();
  }
}

exfil_sniper() {
  level.player endon("death");
  common_scripts\utility::flag_wait("start_exfil_sniper");
  level.remote_turret_right_arc = 30;
  level.remote_turret_left_arc = 30;
  level.remote_turret_top_arc = 2;
  level.remote_turret_bottom_arc = 25;
  wait_for_dpad();
  level.player.remote_canreload = 1;
  level.player setup_sniper_view("exfil_sniper_struct");
  level.player endon("remote_turret_deactivate");
  common_scripts\utility::flag_wait("remote_sniper_ready");
  level.remote_turret_max_fov = 45;
  level.remote_turret_min_fov = 5;
  var_0 = common_scripts\utility::getstruct("exfil_sniper_struct", "targetname");
  level.player.turret_look_at_ent.origin = var_0.origin;
  level.remote_turret_current_fov = 25;
  level.player lerpfov(level.remote_turret_current_fov, 0.05);
  level.player thread intro_dof(0.3);
  level waittill("done_sniping_early");
  level.player notify("use_remote_turret");
}

butchdance() {
  level.player endon("death");
  common_scripts\utility::flag_wait("enable_butchdance");
  level.remote_turret_right_arc = 30;
  level.remote_turret_left_arc = 10;
  level.remote_turret_top_arc = 8;
  level.remote_turret_bottom_arc = 8;
  wait_for_dpad();
  level.player.remote_canreload = 1;
  level.player setup_sniper_view("butchdance_struct", 2000);
  level.player endon("remote_turret_deactivate");
  common_scripts\utility::flag_wait("remote_sniper_ready");
  level.remote_turret_max_fov = 30;
  level.remote_turret_min_fov = 5;
  var_0 = common_scripts\utility::getstruct("butchdance_struct", "targetname");
  level.player.turret_look_at_ent.origin = var_0.origin;
  var_1 = 4;
  level.remote_turret_current_fov = 20;
  level.player lerpfov(level.remote_turret_current_fov, 0.05);
  level.player thread intro_dof(0.3);
  level.player waittill("weapon_fired");
  level notify("hot_butchdance_action");
  level waittill("done_sniping_early");
  wait 0.5;
  level.player notify("use_remote_turret");
}

rpg_kibble() {
  level.player endon("death");
  level endon("cancel_rpg_sniper");
  common_scripts\utility::flag_wait("start_rpg_kibble");
  level.remote_turret_right_arc = 5;
  level.remote_turret_left_arc = 5;
  level.remote_turret_top_arc = 3;
  level.remote_turret_bottom_arc = 3;
  wait_for_dpad();
  level.player.remote_canreload = 1;
  var_0 = common_scripts\utility::spawn_tag_origin();
  level.player setup_sniper_view("rpg_kibble_struct");
  level.player endon("remote_turret_deactivate");
  common_scripts\utility::flag_wait("remote_sniper_ready");
  level.remote_turret_max_fov = 15;
  level.remote_turret_min_fov = 4;
  var_1 = common_scripts\utility::getstruct("rpg_kibble_struct", "targetname");
  level.player.turret_look_at_ent.origin = var_1.origin;
  level.remote_turret_current_fov = 12;
  level.player lerpfov(level.remote_turret_current_fov, 0.05);
  level.player thread intro_dof(0.3);
  level notify("ppoor_kibble_action");
  common_scripts\utility::flag_wait_or_timeout("done_sniping_early", 60);
  wait 0.5;
  level.player notify("use_remote_turret");
  var_0 delete();
}

sniper_vip_breach() {
  level.player endon("death");
  common_scripts\utility::flag_wait("activate_vip_sniper");
  var_0 = common_scripts\utility::getstruct("vip_sniper_breach_struct", "targetname");
  level.remote_turret_start_look = var_0.origin;
  level.remote_turret_right_arc = 10;
  level.remote_turret_left_arc = 10;
  level.remote_turret_top_arc = 5;
  level.remote_turret_bottom_arc = 5;
  wait_for_dpad();
  level.player.remote_canreload = 1;
  level.player setup_sniper_view("vip_sniper_breach_struct", 1000);
  level.player endon("remote_turret_deactivate");
  common_scripts\utility::flag_wait("remote_sniper_ready");
  level.remote_turret_max_fov = 20;
  level.remote_turret_min_fov = 2;
  level.player.turret_look_at_ent.origin = var_0.origin;
  var_1 = 4;
  level.remote_turret_current_fov = 6;
  level.player lerpfov(level.remote_turret_current_fov, 0.05);
  level.player thread intro_dof(0.3);
  level.player waittill("weapon_fired");
  level.player giveweapon("freerunner");
  level.player.presniper_weapon = "freerunner";
  level.player giveweapon("freerunner");
  level.player.presniper_weapon = "freerunner";
  level notify("vip_breach_hot");
  level common_scripts\utility::waittill_notify_or_timeout("done_sniping_early", 10);
  wait 0.5;
  level.player notify("use_remote_turret");
}

wait_for_dpad() {
  level.player notifyonplayercommand("scripted_sniper_dpad", "+actionslot 1");
  level.player setweaponhudiconoverride("actionslot1", "killiconheadshot");
  refreshhudammocounter();
  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingame("ehq_tablet_intro", 1);
  var_0 = 0;

  while(!var_0) {
    var_0 = 1;
    level.player waittill("scripted_sniper_dpad");

    if(level.player isthrowinggrenade() || common_scripts\utility::flag("sniper_block_player_nade"))
      var_0 = 0;
  }

  level.presnipe_grenades = level.player getweaponammoclip("fraggrenade");
  level.player takeweapon("fraggrenade");
  level.player.ignoreme = 1;
  level.player setweaponhudiconoverride("actionslot1", "none");
  level.player notifyonplayercommand("", "+actionslot 1");
  level.player.presniper_weapon = level.player getcurrentweapon();
  level.player.presniper_weapon_clip = level.player getweaponammoclip(level.player.presniper_weapon);
  level.player.presniper_weapon_stock = level.player getweaponammostock(level.player.presniper_weapon);
  level.player giveweapon("remote_tablet");
  level.player switchtoweapon("remote_tablet");
  level.player notify("player_switching_to_tablet");
  wait 1.0;
  pausecinematicingame(0);
  wait 0.4;
  thread maps\enemyhq_code::set_black_fade(1, 0.15);
  maps\_utility::delaythread(0.45, maps\enemyhq_code::set_black_fade, 0, 0.15, 1);
  wait 0.25;
}

sniper_nade_setup() {
  if(common_scripts\utility::flag_exist("sniper_block_player_nade")) {
    return;
  }
  common_scripts\utility::flag_init("sniper_block_player_nade");
  level.sniper_player_nades = 0;
  level.player sniper_grenade_check();
}

sniper_grenade_check() {
  for(;;) {
    self waittill("grenade_fire", var_0);
    common_scripts\utility::flag_set("sniper_block_player_nade");
    thread sniper_grenade_check_dieout(var_0);
  }
}

sniper_grenade_check_dieout(var_0) {
  level.sniper_player_nades++;
  var_0 common_scripts\utility::waittill_notify_or_timeout("death", 10);
  level.sniper_player_nades--;
  waittillframeend;

  if(!level.sniper_player_nades)
    common_scripts\utility::flag_clear("sniper_block_player_nade");
}

setup_sniper_view(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 0;

  level.player thread watch_for_remote_turret_activate(var_1);
  var_2 = common_scripts\utility::getstruct("sniper_placement", "targetname");
  level.remote_sniper_origin = var_2.origin;
  var_3 = common_scripts\utility::getstruct(var_0, "targetname");

  if(!isDefined(self.turret_look_at_ent)) {
    self.turret_look_at_ent = spawn("script_model", self.origin);
    self.turret_look_at_ent setModel("tag_origin");
  }

  self.turret_look_at_ent.origin = var_3.origin;
  self notify("use_remote_turret");
}

intro_objectives() {
  var_0 = maps\_utility::obj("find_ajax");
  objective_add(var_0, "active", &"ENEMY_HQ_LOCATE_AJAX_USING_THE");
  objective_current(var_0);
  common_scripts\utility::flag_wait("bishop_glimpse_over");
  maps\_utility::objective_complete(var_0);
  common_scripts\utility::flag_wait("picked_up_mk32");
  var_1 = maps\_utility::obj("tag_trucks");
  objective_add(var_1, "active", &"ENEMY_HQ_MARK_THE_CONVOY_WITH");
  objective_current(var_1);
  level.player waittill("player_tagged_truck");
  maps\_utility::objective_complete(var_1);
}