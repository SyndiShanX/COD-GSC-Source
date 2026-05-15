/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ship_graveyard_surface.gsc
*******************************************/

main() {
  common_scripts\utility::flag_init("lightning_bloom");
  common_scripts\utility::flag_init("lightning_flashing");
  setsaveddvar("sm_sunsamplesizeNear", 1);
  setsaveddvar("r_specularColorScale", 5.5);
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("compass", 0);
  thread maps\_weather::raininit("light");
  thread maps\_hud_util::fade_out(0);
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowjump(0);
  level.player maps\_utility::player_speed_percent(100, 0.1);
  level.player freezecontrols(1);
  level.baker maps\_utility::set_generic_idle_anim("surface_swim_idle");
  level.player maps\_underwater::player_scuba_mask();
  level.player enableslowaim(0.5, 0.5);
  var_0 = common_scripts\utility::get_target_ent("surface_player_clip");
  var_0.origin = var_0.origin - (0, 0, 0);
  var_1 = getEntArray("bobbing_object", "targetname");
  common_scripts\utility::array_thread(var_1, ::pitch_and_roll);
  var_2 = common_scripts\utility::get_target_ent("start_fishing_boat");
  var_2.script_max_left_angle = 8;
  var_2.script_duration = 4;
  var_2 thread pitch_and_roll();
  var_2 retargetscriptmodellighting(level.player);
  common_scripts\utility::flag_set("fx_screen_raindrops");
  level.player thread maps\_utility::vision_set_fog_changes("shpg_start_abovewater", 0);
  maps\_utility::autosave_by_name_silent("shpg");
  wait 1;
  maps\_utility::autosave_by_name_silent("shpg");
  maps\_utility::smart_radio_dialogue("shipg_hsh_neptunethisistrident");
  wait 0.6;
  thread maps\_utility::smart_radio_dialogue("shipg_pri_copytwoonehowsit");
  wait 2;
  level.player maps\_utility::player_speed_percent(10, 0.1);
  thread fx_screen_raindrops();
  level.rainlevel = 10;
  thread common_scripts\utility::play_sound_in_space("scn_shipg_whoosh_in_from_black", level.player.origin);
  thread water_drops_on_ocean();
  wait 0.7;
  level.player setclienttriggeraudiozone("ship_graveyard_abovewater", 0.5);
  var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("lcs_abovewater");
  var_3 thread maps\ship_graveyard_util::spawn_tag_fx("glow_beam_lcs_large", "tag_origin", (473, 0, 577), (0, 0, 0));
  var_3 vehicle_turnengineoff();
  var_3 thread maps\_utility::play_sound_on_entity("scn_shipg_lcs_approach");
  thread intro_anim_scene();
  maps\_hud_util::fade_out(0.25, "white");
  maps\_hud_util::fade_in(0.05);
  maps\_utility::autosave_by_name_silent("shpg");
  thread maps\_hud_util::fade_in(0.35, "white");
  level.player setplayerangles((0, 70, 0));
  wait 0.1;
  maps\_utility::delaythread(0.5, common_scripts\utility::flag_set, "lightning_bloom");
  level.player freezecontrols(0);
  var_4 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("above_water_hind");
  var_4[0] vehicle_turnengineoff();
  var_4[0] thread maps\_utility::play_sound_on_entity("scn_shipg_intro_chopper_by");
  thread spotlight_hind();
  level.baker maps\_utility::disable_pain();
  level.player enablehealthshield(0);
  level.player thread blur_death();
  wait 1.5;
  maps\_utility::smart_radio_dialogue("shipg_hsh_doingfinejusta");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_pri_hehcanyouconfirma");
  wait 1.5;
  maps\_utility::smart_radio_dialogue("shipg_hsh_wehaveeyeson");
  wait 1;
  maps\_utility::smart_radio_dialogue("shipg_hsh_youreadybro");
  wait 1;
  thread maps\_utility::smart_radio_dialogue("shipg_hsh_letsmove");
  level.player endon("death");
  wait 0.2;
  var_5 = level.player common_scripts\utility::spawn_tag_origin();
  var_5 linkto(level.player);
  var_5 makeusable();

  if(!level.console) {
    var_5 sethintstring(&"SHIP_GRAVEYARD_HINT_DIVE");
  } else {
    var_5 sethintstring(&"SHIP_GRAVEYARD_HINT_DIVE_CONSOLE");
  }

  var_5 common_scripts\utility::trigger_on();
  var_5 waittill("trigger");
  level notify("player_dove");
  var_5 delete();
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  wait 2.5;
  var_0 notify("stop_bob");
  var_6 = 0.25;
  level.player setwatersheeting(1, 1.0);
  playFX(common_scripts\utility::getfx("abv_large_water_impact_close"), level.player.origin);
  var_0 movez(10, var_6, 0, var_6 * 0.4);
  wait(var_6 - 0.05);
  var_6 = 0.5;
  var_0 movez(-25, var_6, 0, var_6);
  thread maps\_weather::rainnone(0.05);
  common_scripts\utility::flag_clear("_weather_lightning_enabled");
  level.player thread maps\_utility::play_sound_on_entity("scn_player_dive_in");
  maps\_hud_util::fade_out(0.25, "white");
  wait 0.05;
  level.player playersetgroundreferenceent(undefined);
  common_scripts\utility::flag_clear("fx_screen_raindrops");
  level.player.health = 100;
  level.screenrain delete();
  lightning_normal();
  level notify("stop_bob");
  level notify("cleanup_bob");
  level.player maps\_utility::player_speed_percent(100, 0.1);
  level.player disableslowaim();
  var_3 delete();
  level.baker maps\_utility::clear_generic_idle_anim();
  level.player maps\_underwater::player_scuba_mask_disable(1);
  maps\ship_graveyard::start_tutorial();
  level.player disableinvulnerability();
  level.player freezecontrols(0);
  level.player allowjump(1);

  foreach(var_8 in var_4) {
    var_8 delete();
  }

  level.heli delete();
  level.baker maps\_utility::enable_pain();
  level.player enablehealthshield(1);
  setsaveddvar("r_specularColorScale", 2.5);
  resetsunlight();
  resetsundirection();
}

intro_anim_scene() {
  var_0 = common_scripts\utility::get_target_ent("start_boat");
  var_1 = common_scripts\utility::get_target_ent("start_boat_model");
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.animname = "intro_boat";
  var_1 maps\_anim::setanimtree();
  level.player_rig = maps\_player_rig::get_player_rig();
  level.player_rig.origin = var_1 gettagorigin("tag_guy1");
  level.player_rig.angles = var_1 gettagangles("tag_guy1");
  level.player_rig linkto(var_1, "tag_guy1", (0, 0, 0), (0, 0, 0));
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 16, 29, 45, 9, 1);
  var_0 thread maps\_anim::anim_loop_solo(var_1, "rocking", "stop_rocking");
  level.baker linkto(var_1, "tag_guy1");
  var_1 thread maps\_anim::anim_single_solo(level.baker, "on_boat_intro", "tag_guy1");
  level.baker thread maps\_utility::play_sound_on_entity("scn_npc_roll_off");
  var_1 thread intro_baker_unlink(var_1);
  var_1 thread maps\_anim::anim_loop_solo(level.player_rig, "idle_above_water", "end_idle", "tag_guy1");
  var_1 thread boat_crashing_waves();
  level waittill("player_dove");
  level.player thread maps\_utility::play_sound_on_entity("scn_player_roll_off");
  level.player_rig notify("end_idle");
  var_1 maps\_anim::anim_single_solo(level.player_rig, "roll_into_water", "tag_guy1");
}

thunder_big_sound_moving() {
  wait 1;
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.origin = level.player.origin + (-200, 500, 300);
  var_0 playSound("elm_thunder_distant", "sounddone");
  var_0 thread maps\_utility::play_sound_on_entity("elm_thunder_strike");
  wait 0.4;
  var_0 moveto(level.player.origin + (1200, -800, 300), 5);
  var_0 waittill("sounddone");
  var_0 delete();
}

boat_crashing_waves() {
  level endon("start_swim");
  var_0 = anglesToForward(self.angles + (0, -25, 0));
  var_0 = var_0 * 400;
  var_0 = var_0 + (0, 0, 20);

  for(;;) {
    playFX(common_scripts\utility::getfx("boat_crashing_waves"), self.origin + var_0);
    maps\_utility::play_sound_on_entity("scn_wave_crash_boat");
    wait(randomfloatrange(3, 6));
  }
}

intro_baker_unlink(var_0) {
  level.baker endon("kill surface unlink");
  var_0 waittill("on_boat_intro");
  level.baker unlink();
}

baker_dive() {
  var_0 = level.baker common_scripts\utility::spawn_tag_origin();
  level.baker linkto(var_0);
  var_0 movez(8, 0.5, 0.1, 0.2);
  var_0 waittill("movedone");
  level notify("stop_ripple");
  var_0 movez(-50, 1, 0.3, 0);
  common_scripts\utility::flag_wait("start_swim");
  var_0 delete();
}

blur_death() {
  level endon("start_tutorial");
  self waittill("death");
  setblur(30, 1);
}

spotlight_hind() {
  level.heli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("spotlight_hind");
  level.heli vehicle_turnengineoff();
  level.heli thread maps\_utility::play_sound_on_entity("scn_shipg_chopper_in_kill");
  level.heli thread spotlight_think();
  level.heli endon("death");
  level.heli thread heli_bullhorn_lines();
  level.heli waittill("reached_dynamic_path_end");
  level.heli notify("new_spotlight_target");
  level.heli setturrettargetent(level.player);
  common_scripts\utility::flag_clear("lightning_bloom");
  wait 1;

  for(;;) {
    level.heli fireweapon();
    wait(randomfloatrange(0.1, 0.4));
  }
}

heli_bullhorn_lines() {
  level endon("stop_bob");
  wait 18;
  level.heli maps\_utility::smart_radio_dialogue("shipg_plt_turnaroundnowyou");
  wait 1;
  level.heli thread maps\_utility::smart_radio_dialogue("shipg_plt_americansoldiersareon");
}

spotlight_think() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoright(self.angles);
  var_5 = self gettagorigin("TAG_BARREL");
  var_0.origin = var_5 + var_3 * 50 - (0, 0, 25);
  var_1.origin = var_5 + var_3 * 50 - (0, 0, 25) - 15 * var_4;
  var_2.origin = var_5 + var_3 * 50 - (0, 0, 25) + 15 * var_4;
  var_0 linkto(self);
  var_1 linkto(self);
  var_2 linkto(self);
  playFXOnTag(common_scripts\utility::getfx("abv_spotlight"), self, "TAG_BARREL");
  var_6 = [var_0, var_1, var_2];
  thread spotlight_loop(var_6);
  self waittill("death");

  foreach(var_8 in var_6) {
    var_8 delete();
  }
}

spotlight_loop(var_0) {
  self endon("new_spotlight_target");
  self endon("death");

  for(;;) {
    var_1 = common_scripts\utility::random(var_0);
    self setturrettargetent(var_1);
    wait(randomfloatrange(0.5, 1.5));
  }
}

bobbing_jitter_cleanup(var_0) {
  level waittill("cleanup_bob");
  var_0.bob_ref delete();
  var_0 delete();
}

bobbing_updown(var_0) {
  var_1 = var_0.bob_ref;

  if(!isDefined(var_1)) {
    var_1 = common_scripts\utility::spawn_tag_origin();
  }

  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_0.bob_ref = var_1;
  var_0.start_origin = var_0.origin;
  level endon("stop_bob");
  thread bobbing_jitter_cleanup(var_0);
  var_2 = -4.0;
  var_3 = 4.0;
  var_4 = 0.5;
  var_5 = 2.5;

  for(;;) {
    var_6 = 0;
    var_7 = 0;
    var_8 = randomfloatrange(var_2, var_3);
    var_9 = randomfloatrange(var_4, var_5);
    var_0.bob_ref moveto(var_0.start_origin + (var_6, var_7, var_8), var_9, var_9 / 4.0, var_9 / 4.0);
    wait(var_9);
  }
}

bobbing_ripple(var_0) {
  level endon("stop_bob");
  var_0 endon("death");
  var_1 = 52;
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = self.origin;
  var_2.angles = (-90, 0, 0);
  var_2 thread maps\ship_graveyard_util::delete_on_notify("stop_bob");
  var_2 thread maps\ship_graveyard_util::delete_on_notify("stop_ripple");
  var_2 endon("death");
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    var_2.origin = (self.origin[0], self.origin[1], var_0.ref_origin[2] + var_1);

    if(var_3 >= var_4) {
      playFXOnTag(common_scripts\utility::getfx("abv_ocean_ripple"), var_2, "tag_origin");
      var_4 = randomfloatrange(0.25, 0.5);
      var_3 = 0;
    } else
      var_3 = var_3 + 0.05;

    wait 0.05;
  }
}

bobbing_object(var_0) {
  thread maps\ship_graveyard_util::delete_on_notify("stop_bob");
  self endon("death");
  self.start_origin = self.origin;
  self.ref_origin = self.origin;
  childthread pitch_and_roll();

  for(;;) {
    var_1 = self.origin;
    var_2 = maps\_ocean::getdisplacementforvertex(level.oceantextures["water_patch"], var_1);
    self.ref_origin = self.start_origin + (0, 0, var_2);
    self.origin = self.ref_origin;
    wait 0.05;
  }
}

pitch_and_roll() {
  self endon("stop_bob");
  self endon("death");
  var_0 = self;
  var_1 = (0, var_0.angles[1], 0);
  var_2 = 20;

  if(isDefined(var_0.script_max_left_angle)) {
    var_2 = var_0.script_max_left_angle;
  }

  var_3 = var_2 * 0.5;
  var_4 = 4;

  if(isDefined(var_0.script_duration)) {
    var_4 = var_0.script_duration;
  }

  var_5 = var_4 * 0.5;
  var_0 = undefined;

  for(;;) {
    var_6 = (randomfloatrange(var_3, var_2), 0, randomfloatrange(var_3, var_2));
    var_7 = randomfloatrange(var_5, var_4);
    self rotateto(var_1 + var_6, var_7, var_7 * 0.2, var_7 * 0.2);
    self waittill("rotatedone");
    self rotateto(var_1 - var_6, var_7, var_7 * 0.2, var_7 * 0.2);
    self waittill("rotatedone");
  }
}

bobbing_actor(var_0, var_1) {
  level endon("stop_bob");
  var_0 endon("death");
  var_0.start_origin = var_0.origin;
  var_0.ref_origin = var_0.origin;
  var_0 thread maps\ship_graveyard_util::delete_on_notify("stop_bob");
  thread bobbing_ripple(var_0);

  for(;;) {
    var_2 = self.origin;
    var_3 = maps\_ocean::getdisplacementforvertex(level.oceantextures["water_patch"], var_2);
    var_0.ref_origin = var_0.start_origin + (0, 0, var_3 * var_1);
    var_0.origin = var_0.ref_origin + (0, 0, 16);
    wait 0.05;
  }
}

bobbing_player_brush(var_0, var_1) {
  level endon("stop_bob");
  var_0 endon("death");
  var_0 endon("stop_bob");
  var_0.start_origin = var_0.origin;
  var_0.ref_origin = var_0.origin;

  if(var_1 <= 0) {
    level.player thread bobbing_ripple(var_0);
  }

  for(;;) {
    var_2 = level.player.origin;
    var_3 = maps\_ocean::getdisplacementforvertex(level.oceantextures["water_patch"], var_2);
    var_0.ref_origin = var_0.start_origin + (0, 0, var_3 * var_1);
    var_0.origin = var_0.ref_origin + (0, 0, 12);
    wait 0.05;
  }
}

bobbing_ally(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin - (0, 0, 0);
  var_1.angles = var_0.angles;
  var_0 show();

  if(isai(var_0)) {
    var_0 forceteleport(var_1.origin, var_1.angles);
  }

  var_0 linkto(var_1, "tag_origin");
  var_0 thread bobbing_actor(var_1, 0.5);
}

lightning_flash(var_0) {
  level notify("emp_lighting_flash");
  level endon("emp_lighting_flash");

  if(level.createfx_enabled) {
    return;
  }
  var_1 = randomintrange(1, 4);

  if(!isDefined(var_0)) {
    var_0 = (-20, 60, 0);
  }

  common_scripts\utility::flag_set("lightning_flashing");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = randomint(3);

    switch (var_3) {
      case 0:
        wait 0.05;
        setsunlight(1, 1, 1.2);
        wait 0.05;
        setsunlight(2, 2, 2.5);
        break;
      case 1:
        wait 0.05;
        setsunlight(1, 1, 1.2);
        wait 0.05;
        setsunlight(2, 2, 2.5);
        wait 0.05;
        setsunlight(3, 3, 3.7);
        break;
      case 2:
        wait 0.05;
        setsunlight(1, 1, 1.2);
        wait 0.05;
        setsunlight(2, 2, 2.5);
        wait 0.05;
        setsunlight(3, 3, 3.7);
        wait 0.05;
        setsunlight(2, 2, 2.5);
        break;
    }

    wait(randomfloatrange(0.05, 0.1));
    lightning_normal();
  }

  common_scripts\utility::flag_clear("lightning_flashing");
  lightning_normal();
}

lightning_normal() {
  resetsunlight();
  var_0 = anglesToForward((-38.63, -76, -8));
  setsundirection(var_0);
}

fx_screen_raindrops() {
  level endon("stop screen rain");
  level.screenrain = spawn("script_model", (0, 0, 0));
  level.screenrain setModel("tag_origin");
  level.screenrain.origin = level.player.origin;
  level.screenrain linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  level.screenrain endon("death");

  for(;;) {
    if(common_scripts\utility::flag("fx_screen_raindrops") || common_scripts\utility::flag("fx_player_watersheeting")) {
      var_0 = 0;
      var_1 = level.player getplayerangles();

      if(common_scripts\utility::flag("fx_player_watersheeting") && var_1[0] < 25) {
        level.player setwatersheeting(1, 1.0);
        var_0 = 1;
      }

      if(common_scripts\utility::flag("fx_screen_raindrops")) {
        if(!var_0 && var_1[0] < -55 && randomint(100) < 20) {
          level.player setwatersheeting(1, 1.0);
        }

        if(var_1[0] < -40) {
          playFXOnTag(level._effect["abv_raindrops_screen_20"], level.screenrain, "tag_origin");
        } else if(var_1[0] < -25) {
          playFXOnTag(level._effect["abv_raindrops_screen_10"], level.screenrain, "tag_origin");
        } else if(var_1[0] < 25) {
          playFXOnTag(level._effect["abv_raindrops_screen_5"], level.screenrain, "tag_origin");
        } else if(var_1[0] < 40) {
          playFXOnTag(level._effect["abv_raindrops_screen_3"], level.screenrain, "tag_origin");
        }
      }
    }

    wait 0.5;
  }
}

water_drops_on_ocean() {
  level endon("start_swim");
  var_0 = common_scripts\utility::getfx("abv_water_splash");
  var_1 = 35;

  for(;;) {
    var_2 = randomfloatrange(1, 2);

    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_4 = [-1, 1];
      var_5 = common_scripts\utility::random(var_4);
      var_6 = common_scripts\utility::random(var_4);
      var_7 = level.player.origin + (randomfloatrange(128, 500) * var_5, randomfloatrange(128, 500) * var_6, var_1);
      var_8 = maps\_ocean::getdisplacementforvertex(level.oceantextures["water_patch"], var_7);
      playFX(var_0, var_7 + (0, 0, var_8));
      var_7 = level.player.origin + (randomfloatrange(16, 128) * var_6, randomfloatrange(16, 128) * var_5, var_1);
      var_8 = maps\_ocean::getdisplacementforvertex(level.oceantextures["water_patch"], var_7);
      playFX(var_0, var_7 + (0, 0, var_8));
    }

    wait 0.05;
  }
}