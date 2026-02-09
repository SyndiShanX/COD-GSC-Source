/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork_interior.gsc
***************************************/

clockwork_interior_pre_load() {
  common_scripts\utility::flag_init("interior_finished");
  common_scripts\utility::flag_init("interior_combat_finished");
  common_scripts\utility::flag_init("interior_cqb_finished");
  common_scripts\utility::flag_init("at_vault_door");
  common_scripts\utility::flag_init("green_zone");
  common_scripts\utility::flag_init("lights_on");
  common_scripts\utility::flag_init("vault_blast_area");
  common_scripts\utility::flag_init("approaching_vault_door");
  common_scripts\utility::flag_init("drill_pickup_ready");
  common_scripts\utility::flag_init("got_drill");
  common_scripts\utility::flag_init("drill_safezone");
  common_scripts\utility::flag_init("drill_toofar");
  common_scripts\utility::flag_init("drill_spot1_ready");
  common_scripts\utility::flag_init("drill1_start");
  common_scripts\utility::flag_init("drill1_complete");
  common_scripts\utility::flag_init("drill_spot2_ready");
  common_scripts\utility::flag_init("drill2_start");
  common_scripts\utility::flag_init("drill2_complete");
  common_scripts\utility::flag_init("enable_charge");
  common_scripts\utility::flag_init("glow_start");
  common_scripts\utility::flag_init("thermite_start");
  common_scripts\utility::flag_init("thermite_stop");
  common_scripts\utility::flag_init("explosion_start");
  common_scripts\utility::flag_init("start_pip_cams");
  common_scripts\utility::flag_init("discovery_guys");
  common_scripts\utility::flag_init("discovery_spawn");
  common_scripts\utility::flag_init("start_discovery");
  common_scripts\utility::flag_init("end_discovery");
  common_scripts\utility::flag_init("attack_discovery_guys");
  common_scripts\utility::flag_init("combat_start");
  common_scripts\utility::flag_init("combat_guys1");
  common_scripts\utility::flag_init("combat_sidehall");
  common_scripts\utility::flag_init("combat_first_guys_dead");
  common_scripts\utility::flag_init("combat_1_over");
  common_scripts\utility::flag_init("combat_flee");
  common_scripts\utility::flag_init("to_cqb");
  common_scripts\utility::flag_init("to_cqb2");
  common_scripts\utility::flag_init("catwalks_open");
  common_scripts\utility::flag_init("kick_a_door");
  common_scripts\utility::flag_init("shut_catwalk_door");
  common_scripts\utility::flag_init("cqb_attack5");
  common_scripts\utility::flag_init("catwalk_melee_abort");
  common_scripts\utility::flag_init("cqb1_dead");
  common_scripts\utility::flag_init("cqb2_dead");
  common_scripts\utility::flag_init("cqb3_dead");
  common_scripts\utility::flag_init("cqb4_dead");
  common_scripts\utility::flag_init("cqb5_dead");
  common_scripts\utility::flag_init("cqb6_dead");
  common_scripts\utility::flag_init("cqb7_dead");
  common_scripts\utility::flag_init("extra_guys_dead");
  common_scripts\utility::flag_init("round_room_fight");
  common_scripts\utility::flag_init("rotunda_cam");
  common_scripts\utility::flag_init("thermite_started");
  common_scripts\utility::flag_init("aud_drilling_door");
  common_scripts\utility::flag_init("drill_attached");
  common_scripts\utility::flag_init("starting_rotunda_kill");
  common_scripts\utility::flag_init("obj_vault_complete");
  common_scripts\utility::flag_init("Obj_datacenter_complete");
  common_scripts\utility::flag_init("at_slow_door");
  common_scripts\utility::flag_init("hesh_ready_for_catwalks");
}

setup_interior_vault_scene() {
  maps\clockwork_code::dog_setup();
  maps\clockwork_code::setup_player();
  maps\clockwork_code::spawn_allies();
  level.player switchtoweapon("cz805bren+reflex_sp+silencer_sp");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_cqbwalk);
  common_scripts\utility::flag_set("lights_out");
  common_scripts\utility::flag_set("FLAG_eyes_and_ears_complete");
  common_scripts\utility::flag_clear("lights_on");
  maps\_utility::vision_set_changes("clockwork_lights_off", 0);
  visionsetnight("clockwork_night");
  level.player setactionslot(1, "nightvision");
  thread maps\clockwork_audio::checkpoint_interior_vault_scene();
  level.player thread maps\_nightvision::nightvision_on();
  level.player nightvisiongogglesforceon();
  common_scripts\utility::flag_set("nvg_light_on");
  thread maps\clockwork_interior_nvg::player_light();
  thread vault_objective();
}

begin_interior_vault_scene() {
  var_0 = common_scripts\utility::array_combine(getEntArray("chaos_decals", "targetname"), getEntArray("chaos_decals1", "targetname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("chaos_decals2", "targetname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("chaos_decals_delete", "targetname"));

  foreach(var_2 in var_0)
  var_2 hide();

  if(level.woof)
    thread handle_dog_interior_attack();

  maps\clockwork_code::setup_drill(1);
  maps\_utility::disable_trigger_with_targetname("pickup_drill_trigger");
  setup_vault_door(1);
  setup_vault_props();
  thread new_vault_scene();
  thread interior_vault_handle_ps4_ssao();
  common_scripts\utility::flag_wait("interior_finished");
  maps\_utility::delaythread(4, maps\_utility::autosave_by_name, "vault_open");
}

interior_vault_handle_ps4_ssao() {
  if(!level.ps4) {
    return;
  }
  common_scripts\utility::flag_wait("explosion_start");
  maps\_art::disable_ssao_over_time(0.2);
  wait 6;
  maps\_art::enable_ssao_over_time(2);
}

handle_dog_interior_attack() {
  level.dog setdogattackradius(200);
}

setup_vault_props() {
  level.tablet_prop = maps\_utility::spawn_anim_model("vault_tablet_prop");
  level.tablet = maps\_utility::spawn_anim_model("vault_tablet");
  level.tablet linkto(level.tablet_prop, "J_prop_1");
  level.tablet hide();
  playFXOnTag(level._effect["vfx/moments/clockwork/vfx_vault_tablet_screen"], level.tablet_prop, "J_prop_1");
  level.thermite1 = maps\_utility::spawn_anim_model("vault_thermite1");
  level.thermite2 = maps\_utility::spawn_anim_model("vault_thermite2");
  level.thermite3 = maps\_utility::spawn_anim_model("vault_thermite3");
  level.thermite1 hide();
  level.thermite2 hide();
  level.thermite3 hide();
  level.charge1 = maps\_utility::spawn_anim_model("vault_charge1");
  level.charge2 = maps\_utility::spawn_anim_model("vault_charge2");
  level.charge1 hide();
  level.charge2 hide();
  level.drill_prop = maps\_utility::spawn_anim_model("vault_drill_prop");
  maps\clockwork_code::setup_drill(0);

  foreach(var_1 in level.drill_pickup)
  var_1 linkto(level.drill_prop, "J_prop_1", (0, 0, 0), (0, 0, 0));

  level.vault_props = maps\_utility::make_array(level.thermite1, level.thermite2, level.charge1, level.charge2);
  level.spool_prop = maps\_utility::spawn_anim_model("vault_spool_prop");
  level.spool = maps\_utility::spawn_anim_model("vault_spool");
  level.spool linkto(level.spool_prop, "J_prop_1");
  level.spool hide();
  level.glowstick1_prop = maps\_utility::spawn_anim_model("vault_glowstick1_prop");
  level.glowstick1 = maps\_utility::spawn_anim_model("vault_glowstick1");
  level.glowstick1 linkto(level.glowstick1_prop, "J_prop_1");
  level.glowstick1 hide();
  level.glowstick2_prop = maps\_utility::spawn_anim_model("vault_glowstick2_prop");
  level.glowstick2 = maps\_utility::spawn_anim_model("vault_glowstick2");
  level.glowstick2 linkto(level.glowstick2_prop, "J_prop_1");
  level.glowstick2 hide();
}

vault_nvg_off_hint() {
  common_scripts\utility::flag_wait("at_vault_door");
  level.player thread maps\_utility::display_hint_timeout("disable_nvg", 5);
  common_scripts\utility::flag_wait("approaching_vault_door");

  while(level.player isswitchingweapon())
    wait 0.01;

  thread maps\clockwork_code::nvg_goggles_off();
}

new_vault_scene() {
  level.number = 1;
  level.drilled_good_line = 0;
  common_scripts\utility::flag_wait("FLAG_eyes_and_ears_complete");
  thread vault_vo();
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_ai_color);
  var_0 = getent("vault_door_scene", "targetname");
  level.allies[0].animname = "baker";
  level.allies[1].animname = "keegan";
  level.allies[2].animname = "cypher";
  var_0 thread maps\_anim::anim_reach_together(level.allies, "vault_approach");
  common_scripts\utility::array_thread(level.allies, ::ally_animate_vault_scene);
  level.allies[0] waittill("anim_reach_complete");
  var_1 = getaiarray("axis");
  common_scripts\utility::array_thread(var_1, maps\clockwork_code::die_quietly);
  thread vault_nvg_off_hint();
  common_scripts\utility::flag_set("FLAG_obj_enterbase_complete");
  thread vault_objective();
  thread animate_vault_door();
  thread maps\clockwork_audio::vault_foley();
  thread handle_misc_drill_details();
  wait 1;
  maps\_utility::autosave_by_name_silent("at_vault");
  common_scripts\utility::flag_wait_or_timeout("vault_blast_area", 1);
  getdrill();
  level.player_arms = maps\_utility::spawn_anim_model("player_rig");
  level.player_arms hide();
  common_scripts\utility::flag_wait("drill_spot1_ready");
  var_0 thread maps\_anim::anim_first_frame_solo(level.player_arms, "back1");
  handle_drill_spot("drill_spot1", "drill1_start", "drill1_complete", "TAG_FX_XMark_RI");
  var_0 thread maps\_anim::anim_single_solo(level.player_arms, "back1");
  level.player allowads(0);
  level.player playerlinktodelta(level.player_arms, "tag_player", 1, 45, 45, 10, 10);
  level.player_arms waittillmatch("single anim", "end");
  level.player unlink();
  level.player allowads(1);
  common_scripts\utility::flag_wait("drill_spot2_ready");
  var_0 thread maps\_anim::anim_first_frame_solo(level.player_arms, "back2");
  handle_drill_spot("drill_spot2", "drill2_start", "drill2_complete", "TAG_FX_XMark_LE");
  var_2 = getanimlength(level.scr_anim["player_rig"]["back2"]);
  var_0 thread maps\_anim::anim_single_solo(level.player_arms, "back2");
  level.player allowads(0);
  level.player playerlinktodelta(level.player_arms, "tag_player", 0.5, 90, 20, 10, 10);
  level.player_arms waittillmatch("single anim", "end");
  level.player unlink();
  level.player enableweaponpickup();
  level.player giveweapon(level.pre_drill_weapon);
  level.player switchtoweapon(level.pre_drill_weapon);
  level.player allowads(1);
  wait 1;
  level.player takeweapon("drill_press");
  level.player setactionslot(1, "");
  common_scripts\utility::flag_wait("explosion_start");
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_ai_color);

  if(common_scripts\utility::flag("vault_blast_area")) {
    var_3 = getent("smoke_spot", "targetname");
    level.player dodamage(level.player.health - 5, var_3.origin);
    level.player shellshock("default", 5);
    level.player setstance("prone");
    level.player pushplayervector((100, 0, 0), 1);
    wait 0.2;
    level.player pushplayervector((0, 0, 0), 1);
  }

  level.player playrumbleonentity("artillery_rumble");
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::set_team_bcvoice("allies", "taskforce");
}

getdrill() {
  common_scripts\utility::flag_wait("drill_pickup_ready");
  common_scripts\utility::array_thread(level.drill_pickup, maps\_utility::show_entity);
  maps\_utility::enable_trigger_with_targetname("pickup_drill_trigger");
  common_scripts\utility::flag_wait("got_drill");
  maps\_utility::disable_trigger_with_targetname("pickup_drill_trigger");
  common_scripts\utility::array_thread(level.drill_pickup, maps\_utility::hide_entity);
  switchtodrill();
}

switchtodrill() {
  level.pre_drill_weapon = level.player getcurrentweapon();
  level.player giveweapon("drill_press");
  level.player disableweaponpickup();
  level.player switchtoweapon("drill_press");
  level.player disableweapons();
  wait 0.75;
  level.player playSound("clkw_scn_vault_drill_from_bag");
  level.player takeweapon(level.pre_drill_weapon);
  wait 0.5;
  level.player enableweapons();
  wait 1;
}

handle_drill_spot(var_0, var_1, var_2, var_3) {
  thread handle_drilling(var_2, var_1);
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 1;
  var_9 = 1;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = getent("vault_door_scene", "targetname");
  var_13 = spawn("script_origin", (0, 0, 0));
  var_14 = spawn("script_origin", (0, 0, 0));
  var_15 = getent("pip_xray_cam", "targetname");
  maps\_utility::enable_trigger_with_targetname(var_0);

  while(!common_scripts\utility::flag(var_2)) {
    if(!common_scripts\utility::flag(var_1) || var_6 == 1 && level.player getcurrentweapon() != "drill_press" || var_7 == 1 && level.player getcurrentweapon() == "drill_press") {
      var_8 = 1;
      var_9 = 1;
      var_6 = 0;
      var_7 = 0;

      if(isDefined(var_10)) {
        var_10 maps\_utility::hint_delete();
        var_10 = undefined;
      }

      if(isDefined(var_11)) {
        var_11 maps\_utility::hint_delete();
        var_11 = undefined;
      }
    }

    common_scripts\utility::flag_wait(var_1);

    if(common_scripts\utility::flag("drill_toofar")) {
      return;
    }
    if(var_8) {
      var_8 = 0;

      if(level.player getcurrentweapon() == "drill_press") {
        var_10 = maps\_utility::hint_create(&"CLOCKWORK_HINT_DRILL");
        var_6 = 1;
      } else {
        var_10 = maps\_utility::hint_create(&"CLOCKWORK_HINT_DRILL_SWITCH");
        var_7 = 1;
      }
    }

    if((level.player adsbuttonpressed() || level.player attackbuttonpressed()) && level.player getcurrentweapon() == "drill_press" && !level.player isswitchingweapon()) {
      if(isDefined(var_10)) {
        var_10 maps\_utility::hint_delete();
        var_10 = undefined;
      }

      if(var_5 == 0) {
        level.frag_ammo = level.player getweaponammostock("fraggrenade");
        level.flash_ammo = level.player getweaponammostock("flash_grenade");
        level.player takeweapon("fraggrenade");
        level.player takeweapon("flash_grenade");
        level.player setstance("stand");
        level.player allowcrouch(0);
        level.player allowprone(0);
        var_5 = 1;
        level.player disableweaponswitch();
        level.player playerlinktoblend(level.player_arms, "tag_player", 0.25);
        thread maps\clockwork_audio::drill_plant();
        level.player setactionslot(1, "");

        if(level.drill_bink) {} else
          maps\clockwork_pip::pip_enable(var_15, undefined, undefined, undefined, undefined, 50, 50, 400, 225, "clockwork_pillar_room");

        wait 0.3;
        common_scripts\utility::flag_set("drill_attached");
      }

      if(var_9) {
        if(level.drill_bink) {
          if(!isDefined(var_11))
            var_11 = maps\_utility::hint_create(&"CLOCKWORK_HINT_DRILL");
        }

        var_9 = 0;
      }

      if(level.player attackbuttonpressed() && level.player getcurrentweapon() == "drill_press" && !level.player isswitchingweapon()) {
        if(isDefined(var_11)) {
          var_11 maps\_utility::hint_delete();
          var_11 = undefined;
        }

        if(var_4 == 0) {
          level notify("started_drilling");
          thread showdrillhole(var_3);

          if(level.drill_bink)
            pausecinematicingame(0);

          var_4 = 1;
          playFXOnTag(level._effect["drill_sparks"], level.vault_door, var_3);
          thread drill_progress_fx(var_3);
          level.player playSound("clkw_scn_vault_drill_wind_up");
          var_13 playLoopSound("clkw_scn_vault_drill_lp");
        }
      } else if(var_4 == 1) {
        if(level.drill_bink)
          pausecinematicingame(1);

        var_4 = 0;
        stopFXOnTag(level._effect["drill_sparks"], level.vault_door, var_3);
        level notify("kill_drill_progress_fx");
        stop_drilling_sounds(var_13, var_14);
      }
    } else {
      if(var_4 == 1) {
        var_4 = 0;
        stopFXOnTag(level._effect["drill_sparks"], level.vault_door, var_3);
        level notify("kill_drill_progress_fx");
        thread stop_drilling_sounds(var_13, var_14);
      }

      if(var_5 == 1) {
        common_scripts\utility::waitframe();
        restore_grenade_weapons();
        var_8 = 1;
        var_9 = 1;
        var_5 = 0;
        common_scripts\utility::flag_clear("drill_attached");

        if(!common_scripts\utility::flag(var_2))
          level.player unlink();

        level.player thread maps\_utility::play_sound_on_entity("clkw_scn_vault_drill_off_door");

        if(isDefined(var_11)) {
          var_11 maps\_utility::hint_delete();
          var_11 = undefined;
        }

        level.player setactionslot(1, "nightvision");

        if(level.drill_bink)
          reset_tablet_screen();
        else
          maps\clockwork_pip::pip_disable();

        level.player enableweaponswitch();
        level.player allowcrouch(1);
        level.player allowprone(1);
      }
    }

    wait 0.01;
  }

  if(isDefined(var_11)) {
    var_11 maps\_utility::hint_delete();
    var_11 = undefined;
  }

  if(isDefined(var_10)) {
    var_10 maps\_utility::hint_delete();
    var_10 = undefined;
  }

  if(var_4 == 1) {
    var_4 = 0;
    stopFXOnTag(level._effect["drill_sparks"], level.vault_door, var_3);
    level notify("kill_drill_progress_fx");
    thread stop_drilling_sounds(var_13, var_14);
  }

  if(var_5 == 1) {
    restore_grenade_weapons();
    level.player thread maps\_utility::play_sound_on_entity("clkw_scn_vault_drill_pullout");
    level.player setactionslot(1, "nightvision");

    if(level.drill_bink)
      reset_tablet_screen();
    else
      thread maps\clockwork_pip::pip_disable();

    level.player enableweaponswitch();
    level.player allowcrouch(1);
    level.player allowprone(1);
  }

  common_scripts\utility::flag_clear("aud_drilling_door");
  maps\_utility::disable_trigger_with_targetname(var_0);
  common_scripts\utility::flag_set(var_1);
}

restore_grenade_weapons() {
  if(level.woof) {
    return;
  }
  level.player giveweapon("fraggrenade");
  level.player giveweapon("flash_grenade");
  level.player setweaponammostock("fraggrenade", level.frag_ammo);
  level.player setweaponammostock("flash_grenade", level.flash_ammo);
}

drill_fail_animation() {
  var_0 = [];
  var_0[0] = getent("piston_01", "targetname");
  var_0[1] = getent("piston_02", "targetname");
  var_0[2] = getent("piston_03", "targetname");
  var_0[3] = getent("piston_04", "targetname");
  var_1 = [];
  var_1[0] = getent("cog_01", "targetname");
  var_1[1] = getent("cog_02", "targetname");
  var_1[2] = getent("cog_03", "targetname");
  var_1[3] = getent("cog_04", "targetname");
  var_1[0] rotatepitch(90, 1);
  var_1[1] rotatepitch(90, 1.5);
  var_1[2] rotatepitch(-90, 1);
  var_1[3] rotatepitch(-90, 1.5);
  wait 0.25;

  foreach(var_3 in var_0) {
    var_3 movey(200, 0.5);
    wait 0.25;
  }
}

stop_drilling_sounds(var_0, var_1) {
  level.player playSound("clkw_scn_vault_drill_wind_down");
  wait 0.05;
  var_0 stoploopsound("clkw_scn_vault_drill_lp");
  var_1 stopsounds();
}

reset_tablet_screen() {
  if(level.drill_bink) {
    level endon("started_drilling");
    cinematicingame("clockwork_vault_drill");
    wait 0.05;

    while(cinematicgetframe() < 2)
      wait 0.05;

    pausecinematicingame(1);
  }
}

handle_drilling(var_0, var_1) {
  common_scripts\utility::flag_clear("drill_safezone");
  common_scripts\utility::flag_clear("drill_toofar");
  var_2 = 300;

  if(level.drill_bink)
    var_2 = var_2 + 50;

  var_3 = 550;
  var_4 = 450;
  level.backplate_sound_on = 0;
  level.safezone_sound_on = 0;
  var_5 = spawn("script_origin", (0, 0, 0));
  var_6 = spawn("script_origin", (0, 0, 0));
  var_7 = 0;
  var_8 = (0, 4, 0);
  var_9 = 0;
  var_10 = 1;
  var_11 = getent("pip_drill", "targetname");
  var_12 = var_11.angles;

  if(isDefined(level.drill_reset_pos))
    var_13 = level.drill_reset_pos;
  else {
    var_13 = var_11.origin + (0, -900, 0);
    level.drill_reset_pos = var_13;
  }

  var_11.origin = var_13;
  var_14 = var_13;
  var_15 = 0;
  var_16 = 115;
  var_17 = 160;
  var_18 = 200;
  var_19 = 0;
  common_scripts\utility::flag_clear("aud_drilling_door");

  while(!common_scripts\utility::flag(var_0) && !common_scripts\utility::flag("drill_toofar")) {
    common_scripts\utility::flag_wait(var_1);

    if((level.player adsbuttonpressed() || level.player attackbuttonpressed()) && level.player getcurrentweapon() == "drill_press" && !level.player isswitchingweapon()) {
      var_15 = cinematicgetframe();

      if(level.player attackbuttonpressed()) {
        common_scripts\utility::flag_set("aud_drilling_door");
        var_13 = var_13 + var_8;
        var_11.angles = var_11.angles + (45, 0, 0);
        var_11.origin = var_13;
        var_9 = var_13 - var_14[1];

        if(var_15 > var_16) {
          if(!var_7) {
            thread drilled_good_vo(var_0);
            level.player playrumbleonentity("drill_through");
            var_7 = 1;
            level.player thread maps\_utility::play_sound_on_entity("clkw_scn_vault_drill_safezone_beep");
          }
        }

        if(var_15 <= var_16) {
          if(var_15 > var_16 - 15 && var_19 == 0) {
            var_19 = 1;
            var_6 playSound("clkw_scn_vault_drill_safezone");
            level notify("drill_progress_safe");
          }

          thread drillthrough_plate_sound(var_5, "clkw_scn_vault_drill_frontplate");
        }

        if(var_15 > var_18) {
          level notify("stop_drilling_sounds");
          common_scripts\utility::flag_set("drill_toofar");
          common_scripts\utility::flag_set("drill_safezone");

          if(!level.drill_bink)
            thread drill_fail_animation();

          level.player maps\_utility::play_sound_on_entity("clkw_scn_vault_drill_gears");
          thread vault_fail_vo();
          thread maps\clockwork_code::screenshakefade(1, 0.5);
          level.player playrumbleonentity("drill_through");
          level.player playrumbleonentity("drill_through");

          if(level.drill_bink) {
            setDvar("ui_deadquote", &"CLOCKWORK_QUOTE_BACKPLATE");
            maps\_utility::missionfailedwrapper();
          } else
            wait 10;

          break;
        }

        if(var_15 > var_17) {
          thread drillthrough_plate_sound(var_5, "clkw_scn_vault_drill_backplate");
          level notify("drill_progress_danger");
        }
      } else {
        level notify("stop_drilling_sounds");

        if(var_15 > var_16 && !common_scripts\utility::flag(var_0))
          common_scripts\utility::flag_set(var_0);
      }
    } else {
      level notify("stop_drilling_sounds");
      common_scripts\utility::flag_clear("aud_drilling_door");
      var_6 stopsounds();
      var_11.origin = var_14;
      var_13 = var_11.origin;
      var_19 = 0;

      if(var_15 > var_16) {
        common_scripts\utility::flag_set(var_0);
        common_scripts\utility::flag_set("drill_safezone");
      }
    }

    wait 0.05;
  }

  level notify("stop_drilling_sounds");

  if(common_scripts\utility::flag("drill_toofar"))
    wait 100;

  var_11.origin = level.drill_reset_pos;
}

vault_fail_vo() {
  var_0 = [];
  var_0[0] = "clockwork_cyr_toofar";
  var_0[1] = "clockwork_cyr_lockingdown";
  level.allies[2] maps\clockwork_code::char_dialog_add_and_go(var_0[randomint(var_0.size)]);
  level.allies[2] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_abortmission");
}

drillthrough_plate_sound(var_0, var_1) {
  if(level.backplate_sound_on == 0) {
    level.backplate_sound_on = 1;
    common_scripts\utility::flag_wait("drill_attached");

    if(level.player attackbuttonpressed()) {
      var_0 playSound(var_1);
      level waittill("stop_drilling_sounds");
      var_0 stopsounds();
    }

    level.backplate_sound_on = 0;
  }
}

waittill_fired_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
  return 0;
}

watch_for_ally() {
  level.aiming_at_ally = 0;

  while(!common_scripts\utility::flag("thermite_start")) {
    var_0 = level.player waittill_fired_or_timeout("weapon_fired", 0.2);

    if(isDefined(var_0)) {
      level.aiming_at_ally = 1;
      continue;
    }

    level.aiming_at_ally = 0;
  }
}

handle_misc_drill_details() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  thread watch_for_ally();

  while(!common_scripts\utility::flag("thermite_start")) {
    var_4 = level.player getcurrentweapon();

    if(var_4 == "drill_press") {
      setsaveddvar("ammoCounterHide", "1");
      level.player setactionslot(1, "");
    } else {
      setsaveddvar("ammoCounterHide", "0");
      level.player setactionslot(1, "nightvision");
    }

    if(var_4 == "drill_press" && level.player attackbuttonpressed() && !level.aiming_at_ally) {
      common_scripts\utility::waitframe();

      if(var_1 != 1) {
        if(!common_scripts\utility::flag("aud_drilling_door")) {
          var_1 = 1;

          if(var_1 == 1) {
            level.player playSound("clkw_scn_vault_drill_wind_up");
            var_0 playLoopSound("clkw_scn_vault_drill_removed_lp");
          }
        }
      }
    } else if(var_1 == 1) {
      var_1 = 0;
      level.player playSound("clkw_scn_vault_drill_wind_down_removed");
      wait 0.05;
      var_0 stoploopsound("clkw_scn_vault_drill_lp");
    }

    if(var_4 == "drill_press") {
      level.player givemaxammo(var_4);
      level.player setweaponammoclip(var_4, weaponclipsize(var_4));

      if(level.player attackbuttonpressed()) {
        if((common_scripts\utility::flag("drill1_start") || common_scripts\utility::flag("drill2_start")) && (level.player adsbuttonpressed() || level.player attackbuttonpressed())) {
          thread maps\clockwork_code::screenshakefade(0.15, 0.5);
          level.player playrumbleonentity("drill_vault");
        } else if(!level.aiming_at_ally) {
          thread maps\clockwork_code::screenshakefade(0.1, 0.5);
          level.player playrumbleonentity("drill_normal");
        }
      }

      if(level.player adsbuttonpressed() || level.player attackbuttonpressed()) {
        if(var_2 == 0) {
          var_3 = 0;
          var_2 = 1;
          thread maps\clockwork_audio::drill_pullout();
        }
      } else if(var_3 == 0) {
        var_3 = 1;
        var_2 = 0;
        thread maps\clockwork_audio::drill_pullout();
      }
    }

    wait 0.05;
  }
}

get_animating_actors(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4) && isDefined(level.scr_anim[var_4.animname][var_1]))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

ally_animate_vault_scene() {
  var_0 = getent("vault_door_scene", "targetname");
  var_1 = ally_vault_props();
  var_2 = common_scripts\utility::array_add(var_1, self);
  self waittill("anim_reach_complete");

  if(self.animname == "cypher" && level.drill_bink)
    setsaveddvar("cg_cinematicFullScreen", "0");

  var_3 = get_animating_actors(var_2, "vault_approach");
  var_0 maps\_anim::anim_single(var_3, "vault_approach");

  if(self.animname == "cypher")
    level.tablet unlink();

  if(!common_scripts\utility::flag("drill1_complete")) {
    var_3 = get_animating_actors(var_2, "vault_loop1");
    var_0 thread maps\_anim::anim_loop(var_3, "vault_loop1", "drill1_complete" + self.animname);
    common_scripts\utility::flag_wait("drill1_complete");
    var_0 notify("drill1_complete" + self.animname);
  }

  if(self.animname == "cypher")
    level.tablet linkto(level.tablet_prop, "J_prop_1");

  var_3 = get_animating_actors(var_2, "vault_betweener");
  var_0 thread maps\_anim::anim_single(var_3, "vault_betweener");
  self waittillmatch("single anim", "end");

  if(!common_scripts\utility::flag("drill2_complete")) {
    var_3 = get_animating_actors(var_2, "vault_loop2");
    var_0 thread maps\_anim::anim_loop(var_3, "vault_loop2", "drill2_complete" + self.animname);
    common_scripts\utility::flag_wait("drill2_complete");
    var_0 notify("drill2_complete" + self.animname);
  }

  var_3 = get_animating_actors(var_2, "vault_finish");
  var_0 maps\_anim::anim_single(var_3, "vault_finish");
  var_0 thread maps\_anim::anim_loop_solo(self, "vault_loop3", "loop3_complete" + self.animname);
  common_scripts\utility::flag_wait("explosion_start");
  var_0 notify("loop3_complete" + self.animname);
  var_3 = get_animating_actors(var_2, "vault_exit");
  var_0 maps\_anim::anim_single(var_3, "vault_exit");

  if(self.animname == "keegan")
    maps\_utility::forceuseweapon("cz805bren+reflex_sp", "primary");

  if(self.animname == "baker")
    maps\_utility::forceuseweapon("cz805bren+reflex_sp", "primary");

  if(self.animname == "cypher")
    maps\_utility::forceuseweapon("mts255", "primary");
}

animate_vault_door() {
  var_0 = getent("vault_door_scene", "targetname");
  var_1 = maps\_utility::make_array(level.vault_door);
  common_scripts\utility::flag_wait("drill2_complete");
  var_0 notify("animate_vault");
  waittillframeend;
  thread vault_ceiling_lights(var_0);
  wait 1;
  thread thermite_fx();
  common_scripts\utility::flag_wait("glow_start");
  level.player thread maps\_utility::display_hint("disable_nvg");
  thread maps\clockwork_audio::thermite();
  common_scripts\utility::flag_wait("thermite_start");
  level.player setactionslot(1, "");
  thread maps\clockwork_code::nvg_goggles_off();
  level.player setactionslot(1, "");
  var_0 thread maps\_anim::anim_single(var_1, "vault_burn");
  common_scripts\utility::flag_wait("explosion_start");
  var_0 thread maps\_anim::anim_single(var_1, "vault_finish");
  thread turn_on_lights();
  maps\clockwork_code::toggle_visibility("vault_ceiling_structure", 0);
  maps\clockwork_code::toggle_visibility("vault_ceiling_structure_damaged", 1);
  maps\clockwork_code::toggle_visibility("vault_frame_damage", 1);
  maps\clockwork_code::toggle_visibility("drill_hole_01", 0);
  maps\clockwork_code::toggle_visibility("drill_hole_02", 0);
  level.tablet_prop delete();
  level.tablet delete();
  level.thermite3 delete();

  foreach(var_3 in level.vault_props)
  var_3 delete();

  foreach(var_6 in level.chalk_mark)
  var_6 delete();

  if(isDefined(level.spool_prop))
    level.spool_prop delete();

  if(isDefined(level.spool))
    level.spool delete();

  if(isDefined(level.glowstick1))
    level.glowstick1 delete();

  if(isDefined(level.glowstick1_prop))
    level.glowstick1_prop delete();

  if(isDefined(level.glowstick2))
    level.glowstick2 delete();

  if(isDefined(level.glowstick2_prop))
    level.glowstick2_prop delete();

  if(isDefined(level.charge1))
    level.charge1 delete();

  if(isDefined(level.charge2))
    level.charge2 delete();

  if(isDefined(level.thermite1))
    level.thermite1 delete();

  if(isDefined(level.thermite2))
    level.thermite2 delete();

  thread maps\clockwork_code::screenshakefade(0.45, 1.25, 0.25, 0.8);
  var_8 = getent("smoke_spot", "targetname");
  playFX(level._effect["vault_smoke"], var_8.origin);
  common_scripts\utility::exploder(1001);
  common_scripts\utility::exploder(1005);
  level.player giveweapon("fraggrenade");
  level.player setweaponammoclip("fraggrenade", level.grenades);
  level.player setweaponammostock("fraggrenade", level.grenades);
  level.player setweaponammoclip("flash_grenade", level.flashbangs);
  thread handle_pip_cams();
  common_scripts\utility::flag_set("interior_finished");
  thread maps\clockwork_code::nvg_goggles_off();
  open_vault(0, var_0);
}

ally_vault_props() {
  var_0 = [];

  if(self.animname == "cypher")
    var_0 = maps\_utility::make_array(level.tablet_prop);

  if(self.animname == "baker")
    var_0 = maps\_utility::make_array(level.thermite1, level.thermite2, level.thermite3, level.glowstick1_prop, level.spool_prop);

  if(self.animname == "keegan")
    var_0 = maps\_utility::make_array(level.drill_prop, level.charge1, level.charge2, level.glowstick2_prop);

  return var_0;
}

tablet_light_on(var_0) {
  playFXOnTag(level._effect["vfx/moments/clockwork/vfx_vault_tablet_screen"], level.tablet_prop, "J_prop_1");
}

tablet_light_off(var_0) {
  stopFXOnTag(level._effect["vfx/moments/clockwork/vfx_vault_tablet_screen"], level.tablet_prop, "J_prop_1");
}

start_scan(var_0) {
  if(level.drill_bink) {
    thread maps\clockwork_audio::drill_monitor();
    cinematicingameloopresident("clockwork_vault_scan");
  }
}

stop_scan(var_0) {
  if(level.drill_bink) {
    cinematicingame("clockwork_vault_drill");
    wait 0.05;

    while(cinematicgetframe() < 2)
      wait 0.05;

    pausecinematicingame(1);
  }
}

vault_ceiling_lights(var_0) {
  var_1 = getent("vault_ceiling_light_right", "targetname");
  var_2 = getent("vault_ceiling_light_left", "targetname");
  var_1.animname = "vault_light_r";
  var_1 maps\_utility::assign_animtree();
  var_2.animname = "vault_light_l";
  var_2 maps\_utility::assign_animtree();
  common_scripts\utility::flag_wait("explosion_start");
  var_1 thread animate_vault_light(var_0);
  var_2 thread animate_vault_light(var_0);
}

animate_vault_light(var_0) {
  level endon("death");
  var_0 maps\_anim::anim_single_solo(self, "light_explode");
}

setup_vault_door(var_0) {
  level.drill_bink = 1;
  level.world_vault_door = getent("model_vault_door", "targetname");
  level.world_vault_door delete();
  level.world_vault_clip = getent("vault_door_clip", "targetname");
  level.vault_door = maps\_utility::spawn_anim_model("vault_door");
  level.vault_door.animname = "vault_door";

  if(isDefined(var_0) && var_0 == 1) {
    var_1 = getent("vault_door_scene", "targetname");
    var_1 thread maps\_anim::anim_loop_solo(level.vault_door, "vault_closed", "animate_vault");
    maps\clockwork_code::toggle_visibility("vault_ceiling_structure_damaged", 0);
    maps\clockwork_code::toggle_visibility("vault_frame_damage", 0);
    maps\clockwork_code::toggle_visibility("vault_frame_hotmetal", 0);
    maps\clockwork_code::toggle_visibility("vault_frame_destroyed_hotmetal", 0);
  }

  level.chalk_mark = [];
  level.chalk_mark[0] = getent("chalk_swipe_1a", "targetname");
  level.chalk_mark[1] = getent("chalk_swipe_1b", "targetname");
  level.chalk_mark[2] = getent("chalk_swipe_2a", "targetname");
  level.chalk_mark[3] = getent("chalk_swipe_2b", "targetname");
  common_scripts\utility::array_thread(level.chalk_mark, maps\clockwork_code::safe_hide);
  thread align_chalk_marks();
}

align_chalk_marks() {
  wait 1;
  var_0 = level.vault_door gettagorigin("TAG_FX_XMark_RI");
  level.chalk_mark[0].origin = var_0;
  level.chalk_mark[1].origin = var_0;
  level.fx_charge1_pos = common_scripts\utility::spawn_tag_origin();
  level.fx_charge1_pos.origin = var_0;
  var_0 = level.vault_door gettagorigin("TAG_FX_XMark_LE");
  level.chalk_mark[2].origin = var_0;
  level.chalk_mark[3].origin = var_0;
  level.fx_charge2_pos = common_scripts\utility::spawn_tag_origin();
  level.fx_charge2_pos.origin = var_0;
}

showdrillhole(var_0) {
  var_1 = level.vault_door gettagorigin(var_0);
  var_2 = getent("drill_hole_01", "targetname");

  if(var_0 != "TAG_FX_XMark_RI")
    var_2 = getent("drill_hole_02", "targetname");

  var_2.origin = var_1;
}

chalk_swipe1(var_0) {
  thread maps\clockwork_audio::chalk_swipe1();
  level.chalk_mark[1] show();
  wait 0.3;
  level.chalk_mark[0] show();
}

chalk_swipe2(var_0) {
  thread maps\clockwork_audio::chalk_swipe2();
  level.chalk_mark[3] show();
  wait 0.3;
  level.chalk_mark[2] show();
}

turn_on_lights() {
  wait 2;
  common_scripts\utility::flag_set("lights_on");
  thread maps\clockwork_interior_nvg::nvg_area_lights_on_fx();
  common_scripts\utility::exploder(5);
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  wait 0.05;
  maps\_utility::vision_set_changes("clockwork_lights_off", 0);
  wait 0.1;
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  wait 0.05;
  maps\_utility::vision_set_changes("clockwork_lights_off", 0.1);
  wait 0.1;
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  wait 0.05;
  maps\_utility::vision_set_changes("clockwork_lights_off", 0.1);
  wait 0.5;
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  wait 0.1;
  maps\_utility::vision_set_changes("clockwork_lights_off", 0.2);
  wait 0.1;
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  wait 0.05;
  maps\_utility::vision_set_changes("clockwork_lights_off", 0.1);
  wait 0.6;
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  wait 0.05;
  maps\_utility::vision_set_changes("clockwork_lights_off", 0.1);
  wait 0.1;
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  wait 0.1;
  maps\_utility::vision_set_changes("clockwork_lights_off", 0.2);
  wait 0.65;
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  wait 0.1;
  maps\_utility::vision_set_changes("clockwork_lights_off", 0.2);
  wait 0.3;
  maps\_utility::vision_set_changes("clockwork_indoor", 0.1);
}

drill_progress_fx(var_0) {
  level endon("kill_drill_progress_fx");
  level waittill("drill_progress_safe");
  playFXOnTag(level._effect["drill_progress1"], level.vault_door, var_0);
  level waittill("drill_progress_danger");
  playFXOnTag(level._effect["drill_progress2"], level.vault_door, var_0);
}

thermite_fx() {
  var_0 = common_scripts\utility::getfx("vfx/moments/clockwork/vfx_vault_thermite_fuse");
  var_1 = common_scripts\utility::getfx("vfx/moments/clockwork/vfx_vault_thermite_start");
  var_2 = common_scripts\utility::getfx("vfx/moments/clockwork/vfx_vault_thermite_end");
  common_scripts\utility::flag_wait("glow_start");
  playFXOnTag(var_0, level.thermite1, "tag_thermite_strip");
  wait 0.1;
  playFXOnTag(var_0, level.thermite2, "tag_thermite_strip");
  wait 0.15;
  playFXOnTag(var_0, level.thermite3, "tag_thermite_strip");
  common_scripts\utility::flag_wait("thermite_start");
  playFXOnTag(var_1, level.vault_door, "TAG_FX_Thermite_Top_LE");
  playFXOnTag(var_2, level.vault_door, "TAG_FX_Thermite_Top_LE");
  stopFXOnTag(var_0, level.thermite1, "tag_thermite_strip");
  wait 0.25;
  playFXOnTag(var_1, level.vault_door, "TAG_FX_Thermite_Bot_LE");
  playFXOnTag(var_2, level.vault_door, "TAG_FX_Thermite_Bot_LE");
  stopFXOnTag(var_0, level.thermite2, "tag_thermite_strip");
  wait 0.35;
  playFXOnTag(var_1, level.vault_door, "TAG_FX_Thermite_Mid_RI");
  playFXOnTag(var_2, level.vault_door, "TAG_FX_Thermite_Mid_RI");
  stopFXOnTag(var_0, level.thermite3, "tag_thermite_strip");
  level waittill("thermite_stop");
  stopFXOnTag(var_1, level.vault_door, "TAG_FX_Thermite_Top_LE");
  wait 0.25;
  stopFXOnTag(var_1, level.vault_door, "TAG_FX_Thermite_Bot_LE");
  wait 0.5;
  stopFXOnTag(var_1, level.vault_door, "TAG_FX_Thermite_Mid_RI");
  common_scripts\utility::flag_wait("explosion_start");
  stopFXOnTag(var_2, level.vault_door, "TAG_FX_Thermite_Top_LE");
  stopFXOnTag(var_2, level.vault_door, "TAG_FX_Thermite_Bot_LE");
  stopFXOnTag(var_2, level.vault_door, "TAG_FX_Thermite_Mid_RI");
}

breach_charge_fx_unhide(var_0) {
  var_1 = common_scripts\utility::getfx("vfx/moments/clockwork/vfx_vault_charge_warmup");
  playFXOnTag(var_1, var_0, "TAG_LIGHT");
}

breach_charge_fx_set(var_0) {
  var_1 = common_scripts\utility::getfx("vfx/moments/clockwork/vfx_vault_charge_warmup");
  var_2 = common_scripts\utility::getfx("vfx/moments/clockwork/vfx_vault_charge_set");
  stopFXOnTag(var_1, var_0, "TAG_LIGHT");
  playFXOnTag(var_2, var_0, "TAG_LIGHT");
}

breach_charge_fx_activate() {
  var_0 = common_scripts\utility::getfx("vfx/moments/clockwork/vfx_vault_charge_warmup");
  var_1 = common_scripts\utility::getfx("vfx/moments/clockwork/vfx_vault_charge_set");
  var_2 = common_scripts\utility::getfx("vfx/moments/clockwork/vfx_vault_charge_activate");
  var_3 = common_scripts\utility::getfx("vfx/moments/clockwork/vfx_vault_charge_explode");
  stopFXOnTag(var_1, level.charge1, "TAG_LIGHT");
  stopFXOnTag(var_1, level.charge2, "TAG_LIGHT");
  playFXOnTag(var_2, level.charge1, "TAG_LIGHT");
  playFXOnTag(var_2, level.charge2, "TAG_LIGHT");
  common_scripts\utility::flag_wait("explosion_start");
  playFXOnTag(var_3, level.fx_charge1_pos, "tag_origin");
  wait 0.2;
  playFXOnTag(var_3, level.fx_charge2_pos, "tag_origin");
  wait 30;
  level.fx_charge1_pos delete();
  level.fx_charge2_pos delete();
}

open_vault(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = getent("vault_door_scene", "targetname");

  if(isDefined(var_0) && var_0 == 1) {
    maps\clockwork_code::setup_drill(1);
    maps\_utility::disable_trigger_with_targetname("pickup_drill_trigger");
    maps\clockwork_code::toggle_visibility("vault_frame_hotmetal", 0);
    maps\clockwork_code::toggle_visibility("vault_ceiling_structure", 0);
  }

  level.world_vault_clip notsolid();
  level.world_vault_clip connectpaths();
  level.world_vault_clip delete();
  maps\clockwork_code::glass_destroy_targetname("post_vault_door_glass");
}

drilled_good_vo(var_0) {
  var_1 = [];
  var_1[0] = "clockwork_hsh_stopthatsgood";
  var_1[1] = "clockwork_cyr_farenough";
  var_1[2] = "clockwork_cyr_woahwoah";

  while(!common_scripts\utility::flag(var_0) && !common_scripts\utility::flag("drill_toofar")) {
    level.allies[2] maps\clockwork_code::char_dialog_add_and_go(var_1[level.drilled_good_line]);
    level.drilled_good_line++;

    if(level.drilled_good_line >= var_1.size)
      level.drilled_good_line = 0;
  }
}

vault_vo() {
  var_0 = level.allies[0];
  var_1 = level.allies[1];
  var_2 = level.allies[2];
  level.drill_nag_num = 0;
  common_scripts\utility::flag_wait("green_zone");
  level.grenades = level.player getweaponammoclip("fraggrenade");
  level.flashbangs = level.player getweaponammoclip("flash_grenade");
  level.player takeweapon("fraggrenade");
  level.player takeweapon("flash_grenade");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_preppingvictor");
  level.player maps\clockwork_code::radio_dialog_add_and_go("clockwork_diz_powerisrestored");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_hydraulicsealneedsto");
  common_scripts\utility::flag_wait_either("drill_spot1_ready", "drill1_start");

  if(!common_scripts\utility::flag("drill1_start")) {
    var_2 maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_drillhere");
    thread drill_nag("drill1_start", "drill1_complete");
    common_scripts\utility::flag_wait("drill1_start");
  }

  var_2 maps\clockwork_code::char_dialog_add_and_go("clockwork_hsh_theresabacktrip");
  common_scripts\utility::flag_wait("drill1_complete");
  var_2 maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_1stshell");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_settingcharge");
  var_2 maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_number2");
  level.player maps\clockwork_code::radio_dialog_add_and_go("clockwork_brv_20seconds");
  common_scripts\utility::flag_wait("drill_spot2_ready");
  var_2 maps\clockwork_code::char_dialog_add_and_go("clockwork_cyr_yourspot");
  thread drill_nag("drill2_start", "drill2_complete");
  common_scripts\utility::flag_wait("drill2_complete");
  var_2 maps\clockwork_code::char_dialog_add_and_go("clockwork_hsh_hydraulicsealsaredown");
  var_1 maps\clockwork_code::char_dialog_add_and_go("clockwork_kgn_armed");
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_ignitethermite");
  thread thermite_timing();
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_backup2");
  common_scripts\utility::flag_wait("thermite_stop");
  wait 1;
  thread maps\clockwork_audio::blowit_beep();
  var_0 maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_blowit");
  thread breach_charge_fx_activate();
  wait 0.25;
  common_scripts\utility::flag_set("explosion_start");
}

thermite_timing() {
  wait 0.1;
  common_scripts\utility::flag_set("glow_start");
  wait 1.36;
  common_scripts\utility::flag_set("thermite_start");
  wait 6;
  common_scripts\utility::flag_set("thermite_stop");
}

drill_nag(var_0, var_1) {
  var_2 = [];
  var_2[0] = "clockwork_cyr_drillit";
  var_2[1] = "clockwork_hsh_wastingtimehere";
  var_3 = 0;
  wait 8;

  while(!common_scripts\utility::flag(var_0) && !common_scripts\utility::flag(var_1)) {
    level.allies[2] maps\clockwork_code::char_dialog_add_and_go(var_2[level.drill_nag_num]);
    level.drill_nag_num++;

    if(level.drill_nag_num >= var_2.size)
      level.drill_nag_num = 0;

    wait 8;
  }
}

setup_interior_combat() {
  maps\clockwork_code::dog_setup();
  maps\clockwork_code::setup_player();
  maps\clockwork_code::spawn_allies();
  level.player switchtoweapon("cz805bren+reflex_sp+silencer_sp");
  var_0 = getent("vault_door_scene", "targetname");
  maps\_utility::disable_trigger_with_targetname("drill_spot1");
  maps\_utility::disable_trigger_with_targetname("drill_spot2");
  setup_vault_door();
  open_vault(1);
  common_scripts\utility::flag_set("lights_on");
  common_scripts\utility::flag_set("interior_finished");
  thread handle_pip_cams();
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  var_1 = getent("smoke_spot", "targetname");
  playFX(level._effect["vault_smoke"], var_1.origin);
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  common_scripts\utility::waitframe();
  thread maps\clockwork_audio::checkpoint_interior_combat();
}

vault_objective() {
  var_0 = maps\_utility::obj("vaultobj");
  objective_add(var_0, "current", &"CLOCKWORK_DISABLE_THE_SECURITY");
  common_scripts\utility::flag_wait("obj_vault_complete");
  maps\_utility::objective_complete(var_0);
}

fight_objective() {
  var_0 = maps\_utility::obj("fightobj");
  objective_add(var_0, "current", &"CLOCKWORK_ADVANCE_TO_THE_DATA_CENTER");
  common_scripts\utility::flag_wait("Obj_datacenter_complete");
  maps\_utility::objective_complete(var_0);
}

begin_interior_combat() {
  var_0 = common_scripts\utility::array_combine(getEntArray("chaos_decals", "targetname"), getEntArray("chaos_decals1", "targetname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("chaos_decals2", "targetname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("chaos_decals_delete", "targetname"));

  foreach(var_2 in var_0)
  var_2 hide();

  common_scripts\utility::flag_clear("player_dynamic_move_speed");
  thread maps\clockwork_code::blend_movespeedscale_custom(85, 1);
  thread ambient_combat_guys();

  foreach(var_5 in level.allies) {
    common_scripts\utility::array_thread(level.allies, maps\_utility::cqb_walk, "on");
    var_5.old_baseaccuracy = var_5.baseaccuracy;
    var_5 maps\_utility::set_baseaccuracy(500);
    var_5.ignoreall = 0;
    var_5.disablereactionanims = 1;

    if(var_5.animname == "keegan")
      var_5 maps\_utility::forceuseweapon("cz805bren+reflex_sp", "primary");

    if(var_5.animname == "baker")
      var_5 maps\_utility::forceuseweapon("cz805bren+reflex_sp", "primary");

    if(var_5.animname == "cypher")
      var_5 maps\_utility::forceuseweapon("mts255", "primary");
  }

  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  common_scripts\utility::flag_set("obj_vault_complete");
  thread fight_objective();
  thread spawn_discovery_guys();
  thread cqb_dog();
  thread handle_combat_guys();
  thread combat_handle_allies();
  thread handle_combat_guys2();
  wait 3.5;
  thread combat_vo();
  common_scripts\utility::flag_wait("discovery_guys");
  common_scripts\utility::flag_wait("to_cqb2");
}

spawn_discovery_guys() {
  common_scripts\utility::flag_wait("discovery_spawn");
  level.discovery_guys = maps\clockwork_code::array_spawn_targetname_allow_fail("discovery_grunt", 1);
  level.override_dog_enemy = level.discovery_guys[0];
  thread maps\clockwork_code::ai_array_killcount_flag_set(level.discovery_guys, 2, "end_discovery");
  var_0 = common_scripts\utility::getstruct("discovery_scene", "targetname");
  var_1 = 1;

  foreach(var_3 in level.discovery_guys) {
    if(isDefined(var_3) && isalive(var_3) && !var_3 maps\_utility::doinglongdeath()) {
      var_3.allowdeath = 1;
      var_3.ignoreall = 0;
      var_3.animname = "discoverguy" + maps\_utility::string(var_1);
      var_1++;
    }
  }

  var_0 thread maps\_anim::anim_single(level.discovery_guys, "discover_vault");
  thread discovery_guys_wakeup();
  common_scripts\utility::flag_wait_or_timeout("discovery_guys", 3);
  wait 1;
  maps\clockwork_code::attack_targets(level.allies, level.discovery_guys);
  wait 1;
  common_scripts\utility::flag_set("discovery_guys");
}

discovery_guys_wakeup() {
  common_scripts\utility::flag_wait("discovery_guys");
  level.discovery_guys = maps\_utility::array_removedead_or_dying(level.discovery_guys);

  foreach(var_1 in level.discovery_guys) {
    var_1 maps\_utility::anim_stopanimscripted();
    var_1 maps\_utility::set_ignoreall(0);
    var_1 getenemyinfo(level.player);
  }
}

combat_handle_allies() {
  common_scripts\utility::flag_wait("end_discovery");
  maps\clockwork_code::safe_activate_trigger_with_targetname("allies_start_combat");
  common_scripts\utility::flag_wait("combat_guys1");
  thread combat_allies_mainhall();
  common_scripts\utility::flag_wait("combat_1_over");
  maps\clockwork_code::safe_activate_trigger_with_targetname("to_second_combat");
}

combat_allies_mainhall() {
  common_scripts\utility::flag_wait("combat_first_guys_dead");

  if(!common_scripts\utility::flag("combat_sidehall"))
    maps\clockwork_code::safe_activate_trigger_with_targetname("combat_mainhall1");
}

handle_combat_guys() {
  common_scripts\utility::flag_wait_either("combat_guys1", "end_discovery");

  foreach(var_1 in level.allies)
  var_1 maps\_utility::set_baseaccuracy(var_1.old_baseaccuracy);

  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  var_3 = maps\clockwork_code::array_spawn_targetname_allow_fail("combat_guys1_pre", 1);
  common_scripts\utility::array_thread(var_3, maps\_utility::disable_careful);
  thread maps\clockwork_code::ai_array_killcount_flag_set(var_3, 1, "combat_guys1");
  thread maps\clockwork_code::ai_array_killcount_flag_set(var_3, var_3.size, "combat_first_guys_dead");
  common_scripts\utility::flag_wait("combat_guys1");
  var_3 = maps\clockwork_code::array_spawn_targetname_allow_fail("combat_guys1", 1);
  thread maps\clockwork_code::ai_array_killcount_flag_set(var_3, var_3.size, "combat_1_over");
}

ambient_combat_guys() {
  var_0 = getEntArray("pillar_ambient_guys", "targetname");
  common_scripts\utility::array_thread(var_0, maps\clockwork_code::ambient_animate, 0, "bogus", 1);
}

handle_combat_guys2() {
  common_scripts\utility::flag_wait_any("combat_1_over", "combat_guys2");
  var_0 = maps\clockwork_code::array_spawn_targetname_allow_fail("combat_guys2_pre");
  var_1 = getEntArray("combat_guys2_waver", "targetname");

  foreach(var_3 in var_1)
  var_3 thread maps\clockwork_code::ambient_animate(0, "start_combat2", 0, 0);

  common_scripts\utility::flag_wait("combat_guys2");
  var_0 = maps\clockwork_code::array_spawn_targetname_allow_fail("combat_guys2");
  thread combat_ambient_guys2();
  common_scripts\utility::flag_wait_or_timeout("start_combat2", 5);
  level notify("start_combat2");

  foreach(var_6 in var_0) {
    if(isalive(var_6)) {
      var_6.ignoreme = 0;
      var_6.ignoreall = 0;
    }
  }

  wait 1;
  var_8 = maps\clockwork_code::array_spawn_targetname_allow_fail("combat_guys2b");
  var_9 = maps\_utility::get_ai_group_ai("waver_guy");
  var_10 = common_scripts\utility::array_combine(var_0, var_8);
  var_10 = common_scripts\utility::array_combine(var_10, var_9);
  var_10 = maps\_utility::array_removedead_or_dying(var_10);
  thread maps\clockwork_code::ai_array_killcount_flag_set(var_10, var_10.size, "to_cqb");
  common_scripts\utility::flag_wait("to_cqb");
  maps\clockwork_code::safe_activate_trigger_with_targetname("to_cqb");
  maps\_utility::disable_trigger_with_targetname("to_cqb");
  common_scripts\utility::flag_wait("kick_a_door");
}

combat_ambient_guys2() {
  var_0 = getEntArray("flee_guy1", "targetname");
  maps\_utility::array_spawn_function(var_0, maps\clockwork_defend::setup_scientist);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_bulletwhizbyreaction);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_pain);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_surprise);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_arrivals);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_exits);
  maps\_utility::array_spawn_function(var_0, ::set_scientist_sprinting);
  common_scripts\utility::array_thread(var_0, maps\clockwork_code::ambient_animate, 1, "", 0, 1);
  common_scripts\utility::flag_wait("combat_flee");
  wait 2;
  var_0 = getEntArray("flee_guy2", "targetname");
  maps\_utility::array_spawn_function(var_0, maps\clockwork_defend::setup_scientist);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_bulletwhizbyreaction);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_pain);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_surprise);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_arrivals);
  maps\_utility::array_spawn_function(var_0, maps\_utility::disable_exits);
  maps\_utility::array_spawn_function(var_0, ::set_scientist_sprinting);
  common_scripts\utility::array_thread(var_0, maps\clockwork_code::ambient_animate, 1, "", 0, 1);
}

set_scientist_sprinting() {
  if(!isDefined(self)) {
    return;
  }
  maps\_utility::clear_run_anim();
  maps\_utility::clear_generic_idle_anim();
  common_scripts\utility::waitframe();
  self.animname = "generic";
  var_0 = "defend_run_scientist_" + randomintrange(1, 4);
  maps\_utility::set_run_anim(var_0);
  maps\_utility::set_generic_idle_anim("scientist_idle");
}

setup_interior_cqb() {
  maps\clockwork_code::dog_setup();
  maps\clockwork_code::setup_player();
  maps\clockwork_code::spawn_allies();
  common_scripts\utility::flag_set("to_cqb");

  foreach(var_1 in level.allies) {
    if(var_1.animname == "keegan")
      var_1 maps\_utility::forceuseweapon("cz805bren+reflex_sp", "primary");

    if(var_1.animname == "baker")
      var_1 maps\_utility::forceuseweapon("cz805bren+reflex_sp", "primary");

    if(var_1.animname == "cypher")
      var_1 maps\_utility::forceuseweapon("mts255", "primary");
  }

  maps\_utility::disable_trigger_with_targetname("to_cqb");
  maps\_utility::vision_set_changes("clockwork_indoor", 0);
  level.player switchtoweapon("cz805bren+reflex_sp+silencer_sp");
  thread handle_cqb_pip_cams();
  thread maps\clockwork_audio::checkpoint_interior_cqb();
}

begin_interior_cqb() {
  common_scripts\utility::flag_set("aud_stop_interior_combat_pa");
  var_0 = getent("ai_closet_clip", "targetname");
  var_0 notsolid();
  var_0 connectpaths();
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::set_team_bcvoice("allies", "taskforce");
  thread handle_cqb_enemies();
  thread handle_cqb_allies();
  thread spin_fans("interior_cqb_finished");
  var_1 = getent("cqb_exit_clip", "targetname");
  var_1 notsolid();
  var_2 = getent("cqb_exterior_door", "targetname");
  var_2.animname = "cqb_ext_door";
  var_2 maps\_utility::assign_animtree();
  var_3 = getent("combat_exit_door_clip2", "targetname");
  var_3 linkto(var_2);
  var_4 = common_scripts\utility::getstruct("cqb_door_kick1", "targetname");
  var_4 maps\_anim::anim_first_frame_solo(var_2, "slow_open_door");
  var_5 = maps\_utility::spawn_anim_model("cqb_int_door");
  var_6 = getent("combat_exit_door_clip1", "targetname");
  var_7 = getent("combat_exit_inside_door", "targetname");
  var_4 maps\_anim::anim_first_frame_solo(var_5, "bust_door");
  wait 0.01;
  var_7 linkto(var_5, "J_prop_1");
  var_6 linkto(var_5, "J_prop_1");
  var_8 = level.allies[1];
  var_4 maps\_anim::anim_generic_reach(var_8, "bust_door");
  thread maps\clockwork_audio::cqb_door_shove();
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_throughhere");
  var_4 thread maps\_anim::anim_single_solo(var_5, "bust_door");
  var_4 maps\_anim::anim_generic_run(var_8, "bust_door");
  var_6 connectpaths();
  var_8 maps\_utility::enable_ai_color();
  level.allies[0] thread door_closer_guy(var_5, var_6);
  level.allies[1] thread wait_at_slow_door();
  thread handle_closet_clip(level.allies[2]);
  common_scripts\utility::array_thread(level.allies, maps\_utility::disable_ai_color);
  maps\clockwork_code::safe_activate_trigger_with_targetname("cqb_move_up4");
  thread ambient_road_vehicles();
  common_scripts\utility::flag_wait("interior_combat_finished");
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_ai_color);
  thread rotunda_kill();
  thread start_rotunda_fight();
  thread maps\_utility::autosave_by_name("pillar_room_complete");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  maps\_utility::player_speed_percent(85);
  common_scripts\utility::flag_wait("interior_cqb_finished");
  thread maps\_utility::autosave_by_name("cqb_finished");
}

handle_closet_clip(var_0) {
  var_1 = getnode("keegan_catwalk_door_node", "targetname");
  var_0.oldgoalradius = var_0.goalradius;
  var_0.goalradius = 20;
  var_0 setgoalnode(var_1);
  var_0 waittill("goal");

  while(distance2d(var_0.origin, var_1.origin) > var_0.goalradius) {
    var_0 setgoalnode(var_1);
    var_0 waittill("goal");
  }

  common_scripts\utility::flag_set("hesh_ready_for_catwalks");
  var_0.goalradius = var_0.oldgoalradius;
  common_scripts\utility::flag_wait("at_slow_door");
  var_2 = getent("ai_closet_clip", "targetname");
  var_2 solid();
  var_2 disconnectpaths();
}

spin_fans(var_0) {
  var_1 = getEntArray("clk_fan_spin01", "targetname");
  var_2 = randomfloatrange(-5.0, 5.0);

  while(!common_scripts\utility::flag(var_0)) {
    foreach(var_4 in var_1)
    var_4 rotatepitch(30 + var_2, 0.25);

    wait 0.25;
  }

  common_scripts\utility::flag_set("aud_stop_fan_sound");
}

ambient_road_vehicles() {
  common_scripts\utility::flag_wait("interior_combat_finished");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("catwalk_gaz");
  var_0 maps\_vehicle::vehicle_lights_on("running");
}

wait_at_slow_door() {
  var_0 = getent("cqb_door_kick2", "targetname");
  self.animname = "generic";
  var_0 maps\_anim::anim_reach_and_approach_solo(self, "slow_open_door_idle", undefined, "Cover Right");
  common_scripts\utility::flag_set("at_slow_door");
  var_0 thread maps\_anim::anim_generic_loop(self, "slow_open_door_idle", "stop_waiting");
  common_scripts\utility::flag_wait("shut_catwalk_door");
  thread maps\clockwork_audio::cqb_door_open_slow();
  var_0 notify("stop_waiting");
  var_0 = common_scripts\utility::getstruct("cqb_door_kick1", "targetname");
  var_1 = getent("cqb_exterior_door", "targetname");
  var_1.animname = "cqb_ext_door";
  var_1 maps\_utility::assign_animtree();
  thread maps\clockwork_fx::turn_effects_on("ch_industrial_light_02_on_red", "fx/lights/bulb_single_offset_red");
  thread maps\clockwork_fx::turn_effects_on("clk_cargoship_wall_light_on", "fx/lights/bulb_single_cargoship");
  common_scripts\utility::exploder(200);
  common_scripts\utility::exploder(850);
  common_scripts\utility::exploder(6400);
  var_2 = getent("combat_exit_door_clip2", "targetname");
  common_scripts\utility::exploder(40);
  var_2 notsolid();
  var_2 connectpaths();
  self.animname = "generic";
  var_0 thread maps\_anim::anim_single_solo(var_1, "slow_open_door");
  var_0 maps\_anim::anim_single_run_solo(self, "slow_open_door");
  common_scripts\utility::flag_set("catwalks_open");
  maps\_utility::enable_ai_color();
  maps\clockwork_code::blend_movespeedscale_custom(85, 1);
  maps\_utility::player_speed_percent(85);
}

door_closer_guy(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("cqb_door_kick1", "targetname");
  var_2 maps\_anim::anim_generic_reach(self, "shut_door_start");
  var_2 maps\_anim::anim_generic(self, "shut_door_start");
  var_3 = maps\_utility::make_array(self, var_0);
  self.animname = "generic";

  if(!common_scripts\utility::flag("to_catwalks") || !common_scripts\utility::flag("hesh_ready_for_catwalks")) {
    var_2 thread maps\_anim::anim_loop(var_3, "shut_door_loop", "shut_door");
    common_scripts\utility::flag_wait_all("to_catwalks", "hesh_ready_for_catwalks");
    var_2 notify("shut_door");
  }

  common_scripts\utility::flag_set("shut_catwalk_door");
  thread maps\clockwork_audio::cqb_door_close_behind();
  var_4 = getent("cqb_exit_clip", "targetname");
  var_4 notsolid();
  thread turn_off_safety_clip();
  self.animname = "generic";
  var_2 maps\_anim::anim_single(var_3, "shut_door_end");
  var_4 = getent("cqb_exit_clip", "targetname");
  var_4 notsolid();
  var_1 disconnectpaths();
  maps\_utility::enable_ai_color();
  thread maps\clockwork_code::transient_switch_to_end();
  var_5 = getaiarray("axis");
  common_scripts\utility::array_thread(var_5, maps\clockwork_code::die_quietly);
  var_6 = maps\clockwork_code::array_spawn_targetname_allow_fail("combat_run_past_guys", 1);
  common_scripts\utility::array_thread(var_6, maps\clockwork_code::delete_on_path_end);
  common_scripts\utility::array_thread(var_6, maps\_utility::pathrandompercent_set, 200);
  wait 5;
  var_6 = maps\clockwork_code::array_spawn_targetname_allow_fail("combat_run_past_guys2", 1);
  common_scripts\utility::array_thread(var_6, maps\clockwork_code::delete_on_path_end);
  common_scripts\utility::array_thread(var_6, maps\_utility::pathrandompercent_set, 200);
}

turn_off_safety_clip() {
  wait 2;
  var_0 = getent("player_door_guy_clip", "targetname");
  var_0 notsolid();
}

catwalk_melee() {
  var_0 = level.allies[1];
  var_1 = getent("cqb_guys5", "targetname");
  var_2 = var_1 maps\_utility::spawn_ai(1);
  var_2.ignoreme = 1;
  var_2.no_dog_target = 1;
  wait 0.01;
  var_3 = var_0.animname;
  var_0.animname = "winner";
  var_2.animname = "loser";
  var_4 = maps\_utility::make_array(var_0, var_2);
  var_5 = common_scripts\utility::getstruct("catwalk_melee_org", "targetname");
  var_5 thread maps\_anim::anim_first_frame_solo(var_2, "catwalk_melee");
  var_2 maps\_utility::magic_bullet_shield();
  var_2 thread catwalk_melee_abort();
  var_0.ignoreall = 1;
  var_0 maps\_utility::disable_arrivals();
  var_5 maps\_anim::anim_reach_solo(var_0, "catwalk_melee");

  if(!common_scripts\utility::flag("catwalk_melee_abort")) {
    var_2 notify("ambushing");
    var_0.animname = "winner";
    var_2.animname = "loser";
    var_5 thread maps\_anim::anim_single(var_4, "catwalk_melee");
    thread maps\clockwork_audio::locker_brawl();
    thread maps\clockwork_audio::locker_brawl_vo();
    wait 1.5;
    common_scripts\utility::flag_set("cqb5_dead");
    var_0 waittillmatch("single anim", "end");
    var_2 maps\_utility::stop_magic_bullet_shield();
    var_2 maps\clockwork_code::die_quietly();
  }

  var_0.ignoreall = 0;
  var_0 maps\_utility::enable_arrivals();
  var_0 maps\_utility::enable_ai_color();
  var_0.animname = var_3;
  maps\clockwork_code::blend_movespeedscale_custom(100, 1);
  maps\_utility::player_speed_percent(100);
}

catwalk_melee_glass_break(var_0) {
  maps\clockwork_code::glass_destroy_targetname("exterior_catwalk_glass01");
}

catwalk_melee_abort() {
  self endon("ambushing");
  common_scripts\utility::flag_wait("catwalk_melee_abort");
  common_scripts\utility::waitframe();
  maps\_utility::anim_stopanimscripted();
  maps\_utility::stop_magic_bullet_shield();
  thread maps\_anim::anim_generic(self, "surprise_stop");
  self.ignoreall = 0;
  self.ignoreme = 0;
  wait 1;
  common_scripts\utility::flag_set("cqb5_dead");
}

rotunda_kill() {
  var_0 = level.allies[1];
  var_1 = common_scripts\utility::getstruct("melee_moment", "targetname");
  common_scripts\utility::flag_wait("rotunda_runners");
  maps\_utility::autosave_by_name("pre_rotunda");
  var_2 = maps\clockwork_code::array_spawn_targetname_allow_fail("run_squad2", 1);
  common_scripts\utility::array_thread(var_2, maps\_utility::pathrandompercent_set, 200);
  common_scripts\utility::array_thread(var_2, ::attack_if_provoked);
  wait 1;
  level.rotunda_knife = spawn("script_model", (0, 0, 0));
  level.rotunda_knife setModel("weapon_commando_knife");
  level.rotunda_knife linkto(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  level.rotunda_knife hide();
  common_scripts\utility::flag_wait("hold_fire");

  if(!common_scripts\utility::flag("round_room_fight")) {
    var_3 = maps\clockwork_code::array_spawn_targetname_allow_fail("rotunda_kill_guys", 1);
    common_scripts\utility::array_thread(var_3, ::interrupt_rotunda_kill);
    var_4 = 1;

    foreach(var_6 in var_3) {
      var_6.animname = "guard" + maps\_utility::string(var_4);
      var_6.grenadeawareness = 0;
      var_6.allowdeath = 1;
      var_6.health = 1;
      var_6.nodrop = 1;

      if(var_4 <= 2) {
        var_6.health = 1;
        var_6 thread rotunda_kill_gun_sync();
      }

      var_4++;
    }

    var_1 maps\_anim::anim_first_frame(var_3, "rotunda_kill");
    common_scripts\utility::flag_wait_either("rotunda_kill", "moved_into_rotunda");
    thread handle_troll_player(var_3);

    if(!common_scripts\utility::flag("round_room_fight")) {
      var_0.animname = "cipher";
      var_0 thread interrupt_ally_rotunda_kill();
      thread activate_rotunda_fight(var_1, var_0);
      common_scripts\utility::flag_wait_any("moved_into_rotunda", "round_room_fight", "starting_rotunda_kill");

      if(!common_scripts\utility::flag("starting_rotunda_kill")) {
        maps\_anim::anim_reach_cleanup_solo(var_0);
        var_0 notify("cancel_rotunda_kill");
        maps\_utility::array_notify(var_3, "cancel");
        maps\_utility::array_delete(var_3);
        wait 0.1;
      } else {
        var_8 = var_3;
        var_3 = common_scripts\utility::array_add(var_3, var_0);
        thread maps\clockwork_audio::rotunda_kill();
        var_1 thread maps\_anim::anim_single(var_3, "rotunda_kill");
        common_scripts\utility::array_thread(var_8, ::enemy_waittill_rotunda_animation_finished);
        var_0 waittill_rotunda_animation_finished();
        level common_scripts\utility::waittill_any("rotunda_kill_done", "rotunda_kill_interrupted");
        wait 0.5;
      }
    } else {
      maps\_utility::array_notify(var_3, "cancel");
      maps\_utility::array_delete(var_3);
    }
  }

  var_0 maps\_utility::enable_ai_color();
  maps\clockwork_code::safe_disable_trigger_with_targetname("rotunda_allies0");
  maps\clockwork_code::safe_activate_trigger_with_targetname("rotunda_allies1");

  if(isDefined(level.rotunda_knife)) {
    level.rotunda_knife unlink();
    level.rotunda_knife hide();
    level.rotunda_knife delete();
  }
}

waittill_rotunda_animation_finished() {
  level endon("rotunda_kill_interrupted");
  self waittillmatch("single anim", "end");
  level notify("rotunda_kill_done");
}

enemy_waittill_rotunda_animation_finished() {
  level endon("rotunda_kill_interrupted");
  self endon("death");
  self waittillmatch("single anim", "end");
  self.ignoreme = 0;
  self.ignoreall = 0;
  maps\_utility::enable_ai_color();
}

activate_rotunda_fight(var_0, var_1) {
  var_1 endon("cancel_rotunda_kill");
  var_0 maps\_anim::anim_reach_solo(var_1, "rotunda_kill");
  common_scripts\utility::flag_set("starting_rotunda_kill");
}

handle_troll_player(var_0) {
  thread troll_stairs_trigger();
  level common_scripts\utility::waittill_either("cqb_guys7", "troll_stairs_trigger");

  if(isDefined(var_0[0]) && isalive(var_0[0]))
    var_0[0] notify("damage", 1, level.player);

  level notify("rotunda_kill_interrupted");
}

troll_stairs_trigger() {
  level endon("cqb_guys7");
  var_0 = getent("rotunda_stairs", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 waittill("trigger");
  level notify("troll_stairs_trigger");
}

start_rotunda_fight() {
  level common_scripts\utility::waittill_any("rotunda_kill_done", "rotunda_kill_interrupted", "runner_killed");
  var_0 = getaiarray("axis");
  maps\_utility::array_notify(var_0, "fight");
  wait 0.5;
  common_scripts\utility::array_thread(level.allies, maps\_utility::enable_ai_color);
}

rotunda_knife_stab(var_0) {
  var_0.stabbed = 1;
}

show_rotunda_knife(var_0) {
  level.rotunda_knife show();
}

hide_rotunda_knife(var_0) {
  level.rotunda_knife hide();
}

get_killed(var_0) {
  if(!isalive(var_0)) {
    return;
  }
  var_0.allowdeath = 1;
  var_0.a.nodeath = 1;
  var_0 maps\_utility::set_battlechatter(0);
  var_0 kill();
}

catch_interrupt_notify() {
  self endon("death");
  level waittill("rotunda_kill_interrupted");
  self notify("rotunda_interrupt");
}

catch_death_notify() {
  self waittill("death", var_0);

  if(isDefined(var_0) && isPlayer(var_0))
    self notify("death_by_player");
}

catch_damage_notify() {
  self waittill("damage", var_0, var_1);

  if(isDefined(var_1) && isPlayer(var_1))
    self notify("damage_by_player");
}

interrupt_rotunda_kill() {
  thread catch_interrupt_notify();
  thread catch_death_notify();
  thread catch_damage_notify();
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("explode");
  common_scripts\utility::waittill_any("ai_event", "death_by_player", "damage_by_player", "rotunda_interrupt");
  wait 0.25;
  level notify("rotunda_kill_interrupted");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self.player_interrupted = 1;
  self.noragdoll = 0;
  maps\_utility::anim_stopanimscripted();

  if(isDefined(self.stabbed)) {
    return;
  }
  maps\_utility::pathrandompercent_set(0);
  maps\_utility::enable_ai_color();
  maps\_utility::gun_recall();
  self endon("death");
  wait 0.5;
  self.ignoreme = 0;
  wait 0.5;
  self.ignoreall = 0;
  return;
}

rotunda_kill_gun_sync() {
  maps\_utility::gun_remove();
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("weapon_sc2010");
  var_0 linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  thread unlink_gun(var_0);
  common_scripts\utility::waittill_any("death", "damage", "cancel");

  if(isDefined(self.player_interrupted)) {
    var_0 unlink();
    var_1 = spawn("weapon_sc2010", var_0.origin);
    var_1.angles = var_0.angles;
    var_0 delete();
  } else if(!common_scripts\utility::flag("starting_rotunda_kill"))
    var_0 delete();
}

unlink_gun(var_0) {
  level endon("rotunda_kill_interrupted");
  level waittill("rotunda_kill_done");
  var_0 unlink();
  var_1 = spawn("weapon_sc2010", var_0.origin, 1);
  var_1.angles = var_0.angles;
  var_0 delete();
}

interrupt_ally_rotunda_kill(var_0) {
  level waittill("rotunda_kill_interrupted");
  maps\_utility::anim_stopanimscripted();
  self.ignoreme = 0;
  self.ignoreall = 0;
  maps\_utility::enable_ai_color();
  maps\clockwork_code::safe_disable_trigger_with_targetname("rotunda_allies0");
  maps\clockwork_code::safe_activate_trigger_with_targetname("rotunda_allies1");
}

cqb_encounter(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  common_scripts\utility::flag_wait(var_0);
  var_7 = getEntArray(var_4, "targetname");
  var_8 = [];

  foreach(var_10 in var_7) {
    if(isDefined(var_10.animation))
      var_8[var_8.size] = var_10 maps\clockwork_code::ambient_animate(0, "cqb_attack5");
  }

  var_8 = common_scripts\utility::array_combine(var_8, maps\clockwork_code::array_spawn_targetname_allow_fail(var_4));
  thread maps\clockwork_code::ai_array_killcount_flag_set(var_8, var_8.size, var_1);
  thread cqb_encounter_allies_move_up(var_1, var_2);

  if(isDefined(var_5))
    common_scripts\utility::flag_wait(var_5);
  else
    wait 1;

  thread maps\clockwork_code::attack_targets(var_3, var_8, undefined, undefined, var_6);
}

cqb_encounter_allies_move_up(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  maps\clockwork_code::safe_activate_trigger_with_targetname(var_1);
}

handle_cqb_allies() {
  thread cqb_ally_vo();
  common_scripts\utility::flag_wait("cqb5_dead");
  maps\clockwork_code::safe_activate_trigger_with_targetname("cqb_move_up5");
  common_scripts\utility::flag_wait("cqb_guys6");
  maps\_utility::autosave_by_name("catwalks");
  wait 1;

  while(level.run_guy_count > 0 && !common_scripts\utility::flag("moved_into_rotunda"))
    wait 0.25;

  common_scripts\utility::flag_wait("cqb_guys7");
  level.player allowsprint(1);
  level.player allowjump(1);
  thread maps\clockwork_code::blend_movespeedscale_custom(80, 1);
  common_scripts\utility::flag_wait("interior_cqb_finished");
  maps\clockwork_code::blend_movespeedscale_custom(100, 1);
  maps\_utility::player_speed_percent(100);
}

handle_cqb_enemies() {
  common_scripts\utility::flag_wait("cqb_guys5");
  thread catwalk_melee();
  common_scripts\utility::flag_wait("round_room_fight");
  common_scripts\utility::flag_wait("cqb_guys7");
  var_0 = maps\_utility::get_ai_group_ai("roundroom_runners");

  foreach(var_2 in var_0)
  var_2.ignoreme = 0;

  if(var_0.size < 3) {
    thread maps\clockwork_code::ai_array_killcount_flag_set(var_0, var_0.size, "extra_guys_dead");
    thread cqb_encounter("cqb_guys7", "cqb7_dead", "cqb_move_up7", level.allies, "cqb_guys7");
  } else {
    common_scripts\utility::flag_set("extra_guys_dead");
    thread maps\clockwork_code::ai_array_killcount_flag_set(var_0, var_0.size, "cqb7_dead");
    thread cqb_encounter_allies_move_up("cqb7_dead", "cqb_move_up7");
  }

  thread cqb_encounter("cqb_guys8", "interior_cqb_finished", "cqb_move_up8", level.allies, "cqb_guys8");
}

attack_if_provoked() {
  self addaieventlistener("grenade danger");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("explode");
  common_scripts\utility::waittill_any("ai_event", "fight", "damage");
  level notify("runner_killed");
  wait 1;

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self notify("stop_going_to_node");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self setgoalpos(self.origin);
  maps\_utility::pathrandompercent_set(0);
  maps\_utility::enable_ai_color();
  wait 0.1;

  if(!common_scripts\utility::flag("round_room_fight"))
    maps\clockwork_code::reassign_goal_volume(self, "round_room_alerted_volume");
  else
    maps\clockwork_code::reassign_goal_volume(self, "round_room_combat_volume");

  level notify("round_room_enemies_provoked");
}

watch_for_round_room_combat() {
  level endon("death");
  level common_scripts\utility::waittill_any("round_room_enemies_provoked", "rotunda_kill_interrupted");
  common_scripts\utility::flag_set("round_room_fight");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_goinghot");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_pickitupboys");
  maps\clockwork_code::safe_activate_trigger_with_targetname("rotunda_allies0");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_gunfirecatwalks", 1, "cqb7_dead");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs1_sendallunits", 2, "cqb7_dead");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_ontheway", 3, "cqb7_dead");
}

combat_vo() {
  maps\_utility::delaythread(3, common_scripts\utility::flag_set, "start_pip_cams");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_frontdoorsopeneta");
  common_scripts\utility::flag_wait("discovery_guys");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_weaponsfree");
  wait 1;
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_dz_patchyouin");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_oby_bossyougottamess");
  common_scripts\utility::flag_wait("combat_guys1");
  wait 2;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_eyeonlabs");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_gunfirelevel1", 3, "combat_1_over");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs3_securitybreach", 4, "combat_1_over");
  common_scripts\utility::flag_wait("combat_1_over");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_letsgo");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs3_intruderslevel2", 2, "combat_guys2");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs1_locksectordown", 3, "combat_guys2");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs4_engaginglevel2", 4, "combat_guys2");
  common_scripts\utility::flag_wait("combat_guys2");
  wait 1;
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_getthatguy");
  common_scripts\utility::flag_wait("combat_flee");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_headright");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs4_engaginglevel2", 1, "to_cqb");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_takethemalive", 2, "to_cqb");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs4_siberianuniforms", 3, "to_cqb");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_traitors", 4, "to_cqb");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs4_idontknow", 5, "to_cqb");
  common_scripts\utility::flag_wait("start_combat2");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_boggeddown");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs4_requestassistance", 10, "to_cqb");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_evacuatingpersonnel", 11, "to_cqb");
  common_scripts\utility::flag_wait("to_cqb");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_dz_allclear");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_movemove");
}

cqb_ally_vo() {
  common_scripts\utility::flag_wait("shut_catwalk_door");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_dz_southcorridor");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_dz_tangoesconverging");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_mrk_exitingthetreetaking");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_dz_minimalactivity");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_dz_offradar");
  common_scripts\utility::flag_wait("cqb5_dead");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_watchthosecorners");
  common_scripts\utility::flag_wait("hold_fire");
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_bkr_hold");
  wait 3;
  common_scripts\utility::flag_set("rotunda_kill");
  wait 2;
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_squad1reportin", 2, "round_room_fight");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_squad3status", 4, "round_room_fight");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_confirmid", 6, "round_room_fight");
  wait 3;
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_squadsunresponsive", 8, "round_room_fight");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs1_sendentirecompany", 10, "round_room_fight");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_yessir", 12, "round_room_fight");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs3_massivecasualties", 14, "round_room_fight");
  thread maps\clockwork_code::overheard_radio_chatter("clockwork_rs2_locateintruders", 16, "round_room_fight");
  common_scripts\utility::flag_wait("cqb_guys7");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_wholebase");
  common_scripts\utility::flag_wait("cqb7_dead");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_targetlocation");
  common_scripts\utility::flag_wait_all("almost_there", "interior_cqb_finished", "extra_guys_dead");
  level.allies[0] maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_90secstonest");
}

handle_pip_cams() {
  common_scripts\utility::flag_wait("start_pip_cams");
  common_scripts\utility::flag_wait_either("combat_guys1", "end_discovery");
  common_scripts\utility::flag_wait("combat_1_over");
  wait 2;
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_dz_majoractivity");
  common_scripts\utility::flag_wait("combat_flee");
  thread handle_cqb_pip_cams();
}

handle_cqb_pip_cams() {
  common_scripts\utility::flag_wait("shut_catwalk_door");
  wait 5;
  common_scripts\utility::flag_wait("cqb_guys5");
  common_scripts\utility::flag_wait("cqb_guys6");
  var_0 = maps\clockwork_code::array_spawn_targetname_allow_fail("run_squad1", 1);
  level.run_guy_count = var_0.size;
  common_scripts\utility::array_thread(var_0, maps\_utility::pathrandompercent_set, 200);
  common_scripts\utility::array_thread(var_0, maps\clockwork_code::delete_on_path_end, "round_room_enemies_provoked", ::run_guy_done);
  common_scripts\utility::array_thread(var_0, ::attack_if_provoked);
  thread watch_for_round_room_combat();
  wait 1;
  maps\clockwork_code::radio_dialog_add_and_go("clockwork_dz_tangoesmassing");
  level.allies[0] thread maps\clockwork_code::char_dialog_add_and_go("clockwork_bkr_takeitslow");
  common_scripts\utility::flag_set("rotunda_cam");
  common_scripts\utility::flag_wait("cqb_guys7");
}

run_guy_done() {
  level.run_guy_count--;
}

cqb_dog() {
  if(!isDefined(level.dog)) {
    return;
  }
  common_scripts\utility::flag_wait("discovery_spawn");
  level.dog setdogattackradius(64);
  wait 0.1;
  var_0 = level.override_dog_enemy;
  wait 2;
  level.dog maps\ally_attack_dog::dog_disable_ai_color();

  if(isalive(var_0)) {
    level.player notify("dog_attack_override");
    var_0 common_scripts\utility::waittill_notify_or_timeout("dead", 15);
  }

  common_scripts\utility::flag_wait("to_cqb");
  level.dog maps\ally_attack_dog::dog_enable_ai_color();
  level.dog maps\ally_attack_dog::lock_player_control_until_flag("catwalks_open");
}