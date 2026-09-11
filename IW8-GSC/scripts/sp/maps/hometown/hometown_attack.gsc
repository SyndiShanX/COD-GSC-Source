/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\hometown\hometown_attack.gsc
********************************************************/

function buried_main() {
  thread buried_black_fade();
  level.player scripts\engine\sp\utility::allow_nvg(0, "hometown", 1);
  setomnvar("ui_hide_hud", 1);
  scripts\engine\utility::exploder("burried_sun");
  scripts\engine\utility::exploder("buried_eyes");
  level.player thread scripts\sp\maps\hometown\hometown_util::weapon_monitor();
  var0 = getEnt("buried_org", "script_noteworthy");
  var1 = getEnt("carried_org", "script_noteworthy");
  thread scripts\sp\maps\hometown\hometown_vo::buried_start_vo();
  thread sfx_buried_debris_lp();
  thread sfx_buried_walla_lp();
  level.rail_player_model = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", var0.origin, var0.angles);
  level.player_rig = level.rail_player_model;

  if(!getdvarint("scr_no_buried_link")) {
    var1 scripts\sp\player_rig::link_player_to_rig("buried_intro", "stand", 0, undefined, 0, 0, 0, 0, 0, 1);
  }

  if(!getdvarint("scr_no_buried_link")) {
    level.player scripts\engine\utility::delaycall(4, &lerpviewangleclamp, 1, 0.5, 0.5, 10, 10, 10, 10);
  }

  level.player setworldupreferenceangles((6.4, -71.1, 90));
  level.player setclienttriggeraudiozone("ht_rubble_start", 0.05);
  thread buried_rubble_setup();
  level.buried_wires_model = scripts\engine\sp\utility::spawn_anim_model("buried_wires", var0.origin, var0.angles);
  level.farah_mother_model = scripts\engine\sp\utility::spawn_anim_model("farah_mother", var0.origin, var0.angles);
  level.farah_mother_model setModel("body_civ_syrkistan_female_1_1");
  level.farah_mother_model attach("head_sc_f_eghbali_civ_bloody");
  level.farah_mother_model.fakeactor_face_anim = 1;
  level.farah_mother_model.animationarchetype = "soldier";
  level.farah_sister_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_child("farah_sister", var0, 1);
  level.player setclienttriggeraudiozone("ht_rubble_underneath", 11.5);
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_wires_model, "buried_struggle");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_struggle_rubble_model, "buried_struggle");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_struggle_rubble_hero_01_model, "buried_struggle");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_struggle_rubble_hero_02_model, "buried_struggle");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_struggle_rubble_hero_03_model, "buried_struggle");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_struggle_rubble_hero_04_model, "buried_struggle");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_struggle_rubble_hero_05_model, "buried_struggle");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_struggle_rubble_hero_06_model, "buried_struggle");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_struggle_rubble_hero_07_model, "buried_struggle");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_rubble_pile_rocks_model, "buried_struggle");
  var1 thread scripts\common\anim::anim_loop_solo(level.farah_mother_model, "buried_intro_idle", "mother_loop_stop");
  var1 thread scripts\common\anim::anim_loop_solo(level.farah_sister_model, "buried_intro_idle", "sister_loop_stop");
  level.buried_rebar_model = scripts\engine\sp\utility::spawn_anim_model("buried_rebar", var0.origin, var0.angles);
  var1 thread scripts\common\anim::anim_first_frame_solo(level.buried_rebar_model, "buried_rebar_reach");
  thread scripts\sp\analytics::analytics_kleenex_update("Buried Start to Alley Start");
  scripts\engine\utility::flag_set("objective_attract_help");
  thread scripts\sp\maps\hometown\hometown_util::transient_load_town();
  thread buried_transient_check_first_frame();
  thread sfx_intro_chaos();
  level.got_rebar = 0;
  level.player hideviewmodel();
  buried_intro_scene();
  level.player enableoffhandweapons();
  level.player enableweapons();
  level notify("buried_complete");
  var1 notify("mother_loop_stop");
  var1 notify("sister_loop_stop");
  level.player showviewmodel();
  level notify("carried_started");
  level.player playersetgroundreferenceent(undefined);
}

function buried_transient_check_first_frame() {
  level endon("carried_started");

  while(!istransientloaded("hometown_main_town_tr") || !istransientloaded("hometown_main_town_carried_tr")) {
    waitframe();
  }

  var0 = getEnt("carried_org", "script_noteworthy");
  level.kargorgis_wh01_model = var0 scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("white_helmet_1", "buried", "white_helmet", undefined, undefined, undefined, "body_white_helmets_male_2", "head_sc_m_kargorgis_civ_helmet_bg_dust", "white_helemets_go");
  level.ahmadzai_wh02_model = var0 scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("white_helmet_2", "buried", "white_helmet", undefined, undefined, undefined, "body_white_helmets_male_1", "head_sc_m_ahmadzai_civ_helmet_bg_dust", "white_helemets_go");
  level.yurteri_wh03_model = var0 scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("white_helmet_3", "buried", "white_helmet", undefined, undefined, undefined, "body_white_helmets_male_3", "head_sc_m_yurteri_civ_helmet_bg_dust", "white_helemets_go");
  scripts\sp\maps\hometown\hometown_util::spawn_father();
  var1 = getnode("alley_start_node", "targetname");
  level.farah_father_ai setgoalnode(var1);
  waitframe();
  level.farah_father_ai.keepnodeduringscriptedanim = 1;
  var0 thread scripts\common\anim::anim_first_frame_solo(level.farah_father_ai, "carried");
}

function buried_intro_scene() {
  var0 = getEnt("carried_org", "script_noteworthy");
  var0 thread scripts\common\anim::anim_first_frame_solo(level.rail_player_model, "buried_intro");

  if(!getdvarint("scr_no_springcam") && !getdvarint("scr_no_buried_link")) {
    level.player springcamenabled(0, 5, 5);
  }

  wait 3;
  level.player modifybasefov(50, 2);
  var0 thread scripts\common\anim::anim_single_solo(level.rail_player_model, "buried_intro");
  thread rubble_hint();
  scripts\sp\maps\hometown\hometown_util::wait_any_input(1);
  level.player notify("pressed_any_button");
  level notify("farah_pulled_arm");
  level.player playrumblelooponentity("tank_rumble");
  var0 notify("mother_loop_stop");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_wires_model, "buried_struggle");
  var0 thread scripts\common\anim::anim_single_solo(level.farah_mother_model, "buried_struggle");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_model, "buried_struggle");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_01_model, "buried_struggle");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_02_model, "buried_struggle");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_03_model, "buried_struggle");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_04_model, "buried_struggle");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_05_model, "buried_struggle");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_06_model, "buried_struggle");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_07_model, "buried_struggle");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_rubble_pile_rocks_model, "buried_struggle");
  var0 scripts\common\anim::anim_single_solo(level.rail_player_model, "buried_struggle");
  level.player stoprumble("tank_rumble");
  level.player playRumbleOnEntity("damage_heavy");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_wires_model, "buried_struggle_success");
  var0 thread scripts\common\anim::anim_single_solo(level.farah_mother_model, "buried_struggle_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_model, "buried_struggle_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_01_model, "buried_struggle_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_02_model, "buried_struggle_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_03_model, "buried_struggle_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_04_model, "buried_struggle_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_05_model, "buried_struggle_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_06_model, "buried_struggle_success");
  scripts\engine\utility::flag_set("lighting_buried_mom");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_07_model, "buried_struggle_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_rubble_pile_rocks_model, "buried_struggle_success");
  var0 scripts\common\anim::anim_single_solo(level.rail_player_model, "buried_struggle_success");

  if(!getdvarint("scr_no_springcam") && !getdvarint("scr_no_buried_link")) {
    level.player springcamdisabled(0.5);
  }

  if(!getdvarint("scr_no_buried_link")) {
    level.player scripts\engine\utility::delaycall(0.5, &lerpviewangleclamp, 1, 0.5, 0.5, 10, 180, 15, 40);
  }

  var0 thread scripts\common\anim::anim_loop_solo(level.farah_mother_model, "buried_struggle_success_idle", "mother_loop_stop");
  thread brick_hint();
  thread rubble_crumble();
  rebar_weapon_interact(level.buried_rebar_model);
  level.buried_rebar_model linkTo(level.rail_player_model, "tag_accessory_right");
  var0 thread scripts\common\anim::anim_loop_solo(level.rail_player_model, "rebar_idle_scripted_player");
  level.rebar_hits = 0;
  level.buried_vo_finished = 0;
  buried_hit_sequence(var0);
  level.rebar_hits = undefined;
  level.buried_vo_finished = undefined;
  var0 notify("stop_loop");
  var0 thread scripts\common\anim::anim_loop_solo(level.buried_rebar_model, "rebar_idle_scripted_player");
  waitframe();
}

function rubble_hint() {
  level.player endon("pressed_any_button");

  for(;;) {
    wait 30;
    scripts\engine\sp\utility::display_hint("rubble_hint", 10, 0, [level.player], ["pressed_any_button"]);
  }
}

function brick_hint() {
  level endon("player_got_brick");
  wait 60;

  for(;;) {
    level.player thread scripts\sp\player::focus_display_hint(0, 15, [level], ["player_got_brick"]);
    wait 30;
  }
}

function buried_hit_sequence(var0) {
  var1 = 1;

  while(!level.buried_vo_finished || !istransientloaded("hometown_main_town_tr")) {
    if(!isDefined(wait_for_hit())) {
      return;
    }

    level notify("farah_buried_vo_press_begin");

    if(var1 > 3) {
      var1 = 1;
    }

    thread sfx_buried_footsteps();
    level.player scripts\engine\utility::delaycall(0.5, &playrumbleonentity, "light_1s");
    var0 notify("stop_loop");
    var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_model, "rebar_hit_scripted_player_0" + var1);
    var0 scripts\common\anim::anim_single_solo(level.rail_player_model, "rebar_hit_scripted_player_0" + var1);
    var0 thread scripts\common\anim::anim_loop_solo(level.rail_player_model, "rebar_idle_scripted_player");
    level.rebar_hits++;
    var1++;
    level notify("farah_buried_vo_press");
  }
}

function wait_for_hit() {
  scripts\sp\maps\hometown\hometown_util::wait_any_input(1);
  return true;
}

function sfx_buried_footsteps() {
  if(!isDefined(level.fs_soundorg)) {
    level.fs_soundorg = spawn("script_origin", self.origin);
    level.fs_soundorg linkTo(self);
  }

  wait 0.5;
  level.fs_soundorg stopsounds();
  wait 0.1;

  if(level.rebar_hits == 0) {
    level.fs_soundorg playSound("scn_hometown_buried_steps_search_approach_01_lr");
    return;
  }

  wait 0.5;
  level.fs_soundorg playSound("scn_hometown_buried_steps_search_approach_02_lr");
}

function sfx_buried_debris_lp() {
  var0 = spawn("script_origin", level.player.origin);
  var0 playLoopSound("scn_hometown_buried_debris_lr_lp_01");
  var1 = spawn("script_origin", level.player.origin);
  var1 playLoopSound("scn_hometown_buried_debris_lsrs_lp_01");
  level waittill("sfx_grabbed_tile");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
  var1 scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
  wait 10;
  var2 = spawn("script_origin", level.player.origin);
  var2 playLoopSound("scn_hometown_buried_debris_lr_lp_02");
  var3 = spawn("script_origin", level.player.origin);
  var3 playLoopSound("scn_hometown_buried_debris_lsrs_lp_02");
  level waittill("buried_complete");
  wait 0.1;

  if(isDefined(level.fs_soundorg)) {
    level.fs_soundorg scripts\engine\sp\utility::sound_fade_and_delete(0.5, 0);
  }

  var2 scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
  var3 scripts\engine\sp\utility::sound_fade_and_delete(2, 1);
}

function sfx_buried_walla_lp() {
  var0 = spawn("script_origin", level.player.origin);
  var0 playLoopSound("scn_hometown_buried_walla_lp");
  level waittill("buried_complete");
  wait 0.1;
  var0 scripts\engine\sp\utility::sound_fade_and_delete(3, 0);
}

function rubble_crumble() {
  var0 = getEnt("carried_org", "script_noteworthy");
  var1 = scripts\engine\utility::getStruct("rebar_look_loc", "script_noteworthy");
  var2 = 0;

  while(var2 == 0) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var1.origin, cos(30))) {
      level.player scripts\engine\utility::delaycall(0.1, &playrumbleonentity, "light_1s");
      earthquake(0.3, 3.3, level.player.origin, 500);
      var0 thread scripts\common\anim::anim_single_solo(level.buried_wires_model, "buried_crumble");
      var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_model, "buried_crumble");
      var0 thread scripts\common\anim::anim_single_solo(level.buried_rubble_pile_rocks_model, "buried_crumble");
      var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_02_model, "buried_crumble");
      var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_04_model, "buried_crumble");
      var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_05_model, "buried_crumble");
      var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_06_model, "buried_crumble");
      var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_07_model, "buried_crumble");
      var2 = 1;
    }

    waitframe();
  }
}

function rebar_weapon_interact() {
  var0 = getEnt("carried_org", "script_noteworthy");
  var1 = &"HOMETOWN/BRICK";
  var2 = scripts\engine\utility::spawn_tag_origin(self.origin);
  var2 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var1, 75, 175, 50, 1);
  var2 waittill("trigger");
  scripts\engine\utility::flag_set("lighting_pickup_tile");
  level notify("tile_grab_vo");
  level notify("player_got_brick");
  scripts\engine\sp\objectives::objective_remove_all_locations("hometown_objective");
  var3 = scripts\engine\utility::spawn_tag_origin(level.rail_player_model.origin, level.rail_player_model.angles);
  var3.origin = level.rail_player_model gettagorigin("tag_player");
  var3.angles = level.rail_player_model gettagangles("tag_player");
  level.player freezecontrols(1);
  level.player enablequickweaponswitch(0);
  level notify("sfx_grabbed_tile");
  level.player freezecontrols(0);
  level.player_rig = level.rail_player_model;
  level.player lerpviewangleclamp(1.9, 0.1, 0.1, 0, 0, 0, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level.player scripts\engine\utility::delaycall(4, &playrumbleonentity, "light_1s");
  level.player scripts\engine\utility::delaycall(5, &playrumbleonentity, "heavy_3s");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_wires_model, "buried_rebar_reach");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_rebar_model, "buried_rebar_reach");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_model, "buried_rebar_reach");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_05_model, "buried_rebar_reach");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_06_model, "buried_rebar_reach");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_rubble_pile_rocks_model, "buried_rebar_reach");
  var0 scripts\common\anim::anim_single_solo(level.rail_player_model, "buried_rebar_reach");
  level.buried_wires_model delete();
  var0 thread scripts\common\anim::anim_single_solo(level.buried_rebar_model, "buried_rebar_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_model, "buried_rebar_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_05_model, "buried_rebar_success");
  var0 thread scripts\common\anim::anim_single_solo(level.buried_struggle_rubble_hero_06_model, "buried_rebar_success");
  var0 scripts\common\anim::anim_single_solo(level.rail_player_model, "buried_rebar_success");
  level.got_rebar = 1;
  var2 delete();

  if(scripts\sp\autosave::autosavethreatcheck(1)) {
    thread scripts\engine\sp\utility::autosave_by_name("got_melee_weapon");
    return;
  }
}

function normalize_carried_angles() {
  level waittill("normalize_carried_angles");
  level.player normalizeworldupreferenceangles();
  wait 5;
  level.player scripts\common\utility::allow_cinematic_motion(1);
}

function delete_rebar_model() {
  wait 5;

  if(isDefined(level.buried_rebar_model)) {
    level.buried_rebar_model delete();
    return;
  }
}

function carried_mix_wait() {
  level waittill("we_left_him_to_study");
  level.player setclienttriggeraudiozone("ht_carried_explo", 2.5);
}

function carried_main() {
  level notify("buried_complete");
  var0 = getEnt("stream_blocker_rubble_01", "script_noteworthy");
  var1 = getEnt("stream_blocker_rubble_02", "script_noteworthy");
  var0 delete();
  var1 delete();
  var2 = getEnt("buried_org", "script_noteworthy");
  var3 = getEnt("carried_org", "script_noteworthy");
  level.player takeallweapons();
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  thread buried_explosion_vfx();
  thread audio_main_siren_handler();
  thread delete_rebar_model();
  thread white_helmet_01_mayhem();
  thread white_helmet_02_mayhem();
  thread white_helmet_03_mayhem();
  thread white_helmet_04_mayhem();
  thread carried_mix_wait();

  if(level.player ispcplayer()) {
    setsaveddvar("OMNONNMOTP", "0.1 400 0.75 1000");
  } else {
    setsaveddvar("OMNONNMOTP", "0.1 400 3.25 1000");
  }

  if(level.start_point == "carried_start") {
    scripts\sp\maps\hometown\hometown_util::spawn_father();
    var4 = getnode("alley_start_node", "targetname");
    level.farah_father_ai setgoalnode(var4);
    waitframe();
    level.farah_father_ai.keepnodeduringscriptedanim = 1;
    level.player_rig = level.rail_player_model;
    var3 scripts\sp\player_rig::link_player_to_rig("carried", "stand", 0, undefined, 0, 0, 0, 0, 0, 1);
  }

  if(!getdvarint("scr_no_buried_link")) {
    level.player scripts\engine\utility::delaycall(1, &lerpviewangleclamp, 1, 0.5, 0.5, 15, 15, 15, 15);
    level.player scripts\engine\utility::delaycall(32, &lerpviewangleclamp, 2, 0.5, 0.5, 0, 0, 0, 0);
    level.player scripts\engine\utility::delaycall(37, &lerpviewangleclamp, 1, 0.5, 0.5, 35, 35, 20, 35);
    level.player scripts\engine\utility::delaycall(45, &lerpviewangleclamp, 2, 0.5, 0.5, 20, 25, 20, 35);
    level.player scripts\engine\utility::delaycall(65.5, &lerpviewangleclamp, 2, 0.5, 0.5, 35, 35, 20, 35);
    level.player scripts\engine\utility::delaycall(74, &lerpviewangleclamp, 2, 0.5, 0.5, 0, 0, 0, 0);
    level.player scripts\engine\utility::delaycall(79.5, &lerpviewangleclamp, 2, 0.5, 0.5, 35, 35, 20, 35);
    level.player scripts\engine\utility::delaycall(83, &lerpviewangleclamp, 2, 0.5, 0.5, 0, 0, 0, 0);
    level.player scripts\engine\utility::delaycall(88, &lerpviewangleclamp, 2, 0.5, 0.5, 35, 35, 20, 35);
    level.player scripts\engine\utility::delaycall(103, &lerpviewangleclamp, 5, 0.5, 0.5, 0, 0, 0, 0);
    level.player scripts\engine\utility::delaycall(111, &lerpviewangleclamp, 2, 0.5, 0.5, 35, 35, 20, 35);
  }

  thread normalize_carried_angles();

  if(!getdvarint("scr_no_springcam") && !getdvarint("scr_no_buried_link")) {
    level.player springcamenabled(0, 5, 5);
  }

  level.rail_player_model_shadow = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig_shadow", var2.origin, var2.angles);
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.rail_player_model_shadow, "carried");
  thread scripts\sp\maps\hometown\hometown_vo::carried_start_vo();
  level.player scripts\engine\utility::delaycall(13.5, &playrumblelooponentity, "tank_rumble");
  level.player scripts\engine\utility::delaycall(16.75, &stoprumble, "tank_rumble");
  level notify("buried_scene_start_vo");
  level notify("rail_started");
  thread alley_jumpers();
  level.alley_anim_node = getEnt("alley_scenes_node", "script_noteworthy");
  thread alley_looped_anims();
  thread alley_triggers_monitor();
  thread gas_attack_triggers_monitor();
  level.player scripts\engine\utility::delaycall(0.7, &setclienttriggeraudiozone, "ht_rubble_partial_opened", 0.45);
  level.player scripts\engine\utility::delaycall(15, &setclienttriggeraudiozone, "ht_rubble_opened", 15);
  level.player modifybasefov(75, 2);
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.farah_mother_model, "buried");
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.farah_sister_model, "buried");
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.buried_struggle_rubble_model, "buried_rescue");
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.buried_rubble_pile_rocks_model, "buried_rescue");
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.buried_struggle_rubble_hero_01_model, "buried_rescue");
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.buried_struggle_rubble_hero_02_model, "buried_rescue");
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.buried_struggle_rubble_hero_03_model, "buried_rescue");
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.buried_struggle_rubble_hero_04_model, "buried_rescue");
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.buried_struggle_rubble_hero_05_model, "buried_rescue");
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.buried_struggle_rubble_hero_06_model, "buried_rescue");
  var3 thread scripts\sp\maps\hometown\hometown_util::play_anim_and_delete(level.buried_struggle_rubble_hero_07_model, "buried_rescue");
  thread new_sequence_carried_anim();
  thread dudes_carried_anim();
  thread things_carried_anim();
  thread father_mayhem();
  thread carried_fov();
  level notify("white_helemets_go");
  thread scripts\engine\utility::flag_set("lighting_move_rubble");
  thread scripts\engine\utility::flag_set_delayed("lighting_unburied", 28);
  thread scripts\engine\utility::flag_set_delayed("lighting_liftout", 32);
  var3 notify("stop_loop");
  var3 thread scripts\common\anim::anim_single([level.rail_player_model, level.farah_father_ai], "carried");
  level.player scripts\engine\utility::delaycall(getanimlength(level.scr_anim["hometown_player_rig"]["carried"]) - 10, &setclienttriggeraudiozone, "ht_carried_02", 1.5);
  thread audio_carried_music_russians();
  var5 = getanimlength(level.scr_anim["hometown_player_rig"]["carried"]) - 7;
  thread scripts\engine\utility::delaythread(var5, &audio_dist_shootings);
  thread scripts\engine\utility::delaythread(var5, &audio_music_transition_to_alley);
  wait getanimlength(level.scr_anim["hometown_player_rig"]["carried"]);
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  level.player.ignoreme = 0;
  thread scripts\engine\sp\utility::autosave_by_name("carried_done");
}

function audio_carried_music_russians() {
  wait getanimlength(level.scr_anim["hometown_player_rig"]["carried"]) - 34;
  setmusicstate("mx_hometown_01_carried_russians");
}

function carried_depth_of_field() {
  level.player enablephysicaldepthoffieldscripting(1);
  waitframe();
  level.player setphysicaldepthoffield(2.8, 12, 1, 1);
  wait 25;
  level.player setphysicaldepthoffield(2.8, 18, 1, 1);
  wait 10;
  level.player setphysicaldepthoffield(3.5, 36, 1, 1);
  wait 5;
  level.player setphysicaldepthoffield(5.6, 12, 1, 1);
  wait 3;
  level.player setphysicaldepthoffield(4, 48, 1, 1);
  wait 11;
  level.player setphysicaldepthoffield(2.8, 12, 1, 1);
  wait 4.5;
  level.player setphysicaldepthoffield(4, 100, 1, 1);
  wait 4;
  level.player setphysicaldepthoffield(4, 10, 1, 1);
  wait 2;
  level.player setphysicaldepthoffield(4, 100, 1, 1);
  wait 12;
  level.player setphysicaldepthoffield(2.8, 4, 1, 1);
  wait 1;
  level.player setphysicaldepthoffield(4, 100, 1, 1);
  wait 6;
  level.player setphysicaldepthoffield(3.5, 36, 1, 1);
  wait 5;
  level.player setphysicaldepthoffield(4, 100, 1, 1);
  wait 24;
  level.player setphysicaldepthoffield(3.5, 14, 1, 1);
  wait 4.5;
  level.player setphysicaldepthoffield(24, 100, 1, 1);
  wait 2;
  level.player disablephysicaldepthoffieldscripting();
}

function carried_fov() {
  wait 41.5;
  level.player modifybasefov(50, 2);
  wait 17.75;
  level.player modifybasefov(75, 0.5);
  wait 3.5;
  level.player modifybasefov(50, 0.5);
  wait 1.5;
  level.player modifybasefov(75, 1);
  wait 5.5;
  level.player modifybasefov(60, 0.5);
  wait 8;
  level.player modifybasefov(75, 1);
  wait 34;
  level.player modifybasefov(50, 1);
  wait 9;
}

function new_sequence_carried_anim() {
  level.square_dudes_hide_array = [];
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("SceneA_WhiteHelmetStretcher01", "carried", "white_helmet");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("SceneA_WhiteHelmetStretcher02", "carried", "white_helmet");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("SceneA_WhiteHelmetStretcher03", "carried", "white_helmet");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("SceneA_WhiteHelmetStretcher04", "carried", "white_helmet", 1, level.square_dudes_hide_array);
  level.alameer_wh04_model = thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("SceneA_WhiteHelmetBucketBrigade", "carried", "white_helmet", undefined, undefined, undefined, "body_white_helmets_male_2", "head_sc_m_alameer_civ_helmet_bg_dust");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("SceneA_WomanStretcher", "carried", "female");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ01", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ02", "carried", "female");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ03", "carried", "child_female");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ04", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ05", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ06", "carried", "child_female");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ07", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ08", "carried", "female");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ09", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ10", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ11", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ12", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_civ13", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("airstrike_escape_wh01", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("civdeathcars_civ01", "carried", "male", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("civdeathcars_civ02", "carried", "male", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("civdeathcars_civ03", "carried", "female", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("civdeathcars_civ04", "carried", "male", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("civdeathcars_civ06", "carried", "female", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("civdeathcars_civ07", "carried", "child_male", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("civdeathcars_civ09", "carried", "male", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("SceneA_Stretcher", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("WhiteHelmetVan", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("civdeathcars_luggage03", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("civdeathcars_luggage04", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("civdeathcars_walfa01", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("civdeathcars_secho01", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("rooftop_mindia01", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("rooftop_mindia02", "carried", 1, level.square_dudes_hide_array);
  level.neighbor_dad = thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_neighborDad", "carried", "male", 1, level.square_dudes_hide_array, 1, "body_civ_syrkistan_male_8_1", "head_sc_m_fahselt_civ_bg_dust");
  thread neighbordad_mayhem();
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_neighborKid", "carried", "child_female", 1, level.square_dudes_hide_array, 1, "body_civ_syrkistan_girl_1_1", "head_sc_f_roa_dust");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_misc_Dad", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_misc_Child", "carried", "child_female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_misc_Civ05", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_misc_Civ06", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("WhiteHelmetSawOperator", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("WhiteHelmetSawOperator_Gascutter", "carried");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("WhiteHelmetVanDriver", "carried", "white_helmet", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("WhiteHelmetVanPassenger01", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("WhiteHelmet_Mom", "carried", "white_helmet");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("WhiteHelmet_Mom_2", "carried", "white_helmet");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ01", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ02", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ03", "carried", "child_male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ04", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ05", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ06", "carried", "child_male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ07", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ08", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ09", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ10", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ11", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ12", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_civ13", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_close_civ01", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_close_civ02", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_close_civ03", "carried", "female");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_close_civ04", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_close_civ05", "carried", "female");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("background_close_civ06", "carried", "male");
  thread hide_square_civs();
}

function hide_square_civs() {
  waitframe();
  wait 65;

  foreach(var1 in level.square_dudes_hide_array) {
    var1 show();
  }
}

function dudes_carried_anim() {
  var0 = getEnt("buried_org", "script_noteworthy");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim01", "buried", "white_helmet");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim02", "buried", "white_helmet");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim03", "buried", "white_helmet");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim04", "buried", "male");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim05", "buried", "white_helmet");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim06", "buried", "white_helmet");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim07", "buried", "white_helmet");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim08", "buried", "male");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim09", "buried", "white_helmet");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim10", "buried", "white_helmet");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim11", "buried", "white_helmet");
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("AirstrikeVictim12", "buried", "female");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude01", "carried", "female", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_female_5_2", "head_sc_f_eghbali_civ_dust");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude02", "carried", "male", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_male_2_1", "head_sc_m_haghighi_civ_bg_dust", undefined, "hat_sc_m_nassernia_helmet");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude03", "carried", "male", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_male_2_1", "head_sc_m_haghighi_civ_bg_dust");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude04", "carried", "male", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_male_8_1", "head_sc_m_haghighi_civ_bg_dust");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude05", "carried", "male", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_male_5_1", "head_sc_m_alameer_civ_bg_dust");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude06", "carried", "male", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_male_10_1", "head_sc_m_nassernia_civ_bg_dust", undefined, "hat_sc_m_nassernia_helmet");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude07", "carried", "male", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_male_6_1", "head_sc_m_arakelyan_civ_bg_dust");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude08", "carried", "male", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_male_7_1", "head_sc_m_nassernia_civ_bg_dust", undefined, "hat_sc_m_nassernia_headscarf");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude09", "carried", "male", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_male_4_1", "head_sc_m_arakelyan_civ_bg_dust");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude10", "carried", "male", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_male_10_1", "head_sc_m_bansal_civ_bg_dust");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude11", "carried", "male", 1, level.square_dudes_hide_array, undefined, "body_civ_syrkistan_male_1_1", "head_sc_m_alameer_civ_bg_dust");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude12", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude13", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude14", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude15", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("stretcher_dude16", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("exit_civmale01", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("exit_civmale02", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("exit_civmale04", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("exit_civmale07", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("exit_female01", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("exit_female02", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("exit_female03", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("rooftop_female02", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("rooftop_male01", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_russian01", "carried", "russian_male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_russian02", "carried", "russian_male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_russian03", "carried", "russian_male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_russian04", "carried", "russian_male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_russian05", "carried", "russian_male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_russian06", "carried", "russian_male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_russian07", "carried", "russian_male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_russian08", "carried", "russian_male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_russian09", "carried", "russian_male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_victim01", "carried", "female", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_victim02", "carried", "female", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_victim03", "carried", "female", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_victim04", "carried", "male", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_victim05", "carried", "male", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_victim06", "carried", "male", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_victim07", "carried", "male", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("shooting_victim08", "carried", "male", 1, level.square_dudes_hide_array, 1);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ01", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ02", "carried", "female");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ03", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ04", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ05", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ06", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ07", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ08", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ09", "carried", "white_helmet", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ10", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ11", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ12", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ13", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ14", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ15", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ16", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ17", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ18", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ19", "carried", "male");
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ20", "carried", "child_male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("StreetEnter_Civ21", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("cafe_WhiteHelmet01", "carried", "white_helmet", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("cafe_WhiteHelmet06", "carried", "white_helmet", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_WhiteHelmet04", "carried", "white_helmet", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_WhiteHelmet05", "carried", "white_helmet", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("cafe_whitehelmet02", "carried", "white_helmet", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("cafe_whitehelmet03", "carried", "white_helmet", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("cafe_victim", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ01", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ02", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ03", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ04", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ05", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ06", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ07", "carried", "female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ08", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ09", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ10", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("cafe_civ11", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("cafe_civ12", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("cafe_civ13", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("cafe_civ14", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("cafe_civ15", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ16", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ17", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ18", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ19", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ20", "carried", "male", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ21", "carried", "child_female", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Cafe_civ22", "carried", "child_male", 1, level.square_dudes_hide_array);
}

function things_carried_anim() {
  var0 = getEnt("buried_org", "script_noteworthy");
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_last_frame("emergencyvehicle_vehicle", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("blocktruck_truck", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("airstrike_mig01", "carried");
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("airstrike_mig02", "carried");
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("airstrike_mig03", "carried");
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("airstrike_mig04", "carried");
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("stretcher_stretcher", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("RussianAttack_Victim06_Luggage01", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("RussianAttack_Victim06_Luggage02", "carried", 1, level.square_dudes_hide_array);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("RussianAttack_RussianAttack_mkilo23", "carried", 1, level.square_dudes_hide_array);
  var0 thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("buried_rubble_05", "buried");
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("BarricadeEscape_board01", "carried", 0);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("BarricadeEscape_board02", "carried", 0);
  thread scripts\sp\maps\hometown\hometown_util::spawn_thing_play_anim_and_delete("SceneA_rainboot", "carried");
}

function player_carried_anim() {
  var0 = gettime();
  iprintlnbold("player start time:" + var0);
  scripts\common\anim::anim_single_solo(level.rail_player_model, "carried");
  level.player unlink();
  level.rail_player_model delete();
  level.player.ignoreme = 0;
}

function alley_jumpers() {
  level waittill("alley_civ_jumpers");
  level.alley_anim_node = getEnt("alley_scenes_node", "script_noteworthy");
  level.alley_anim_node thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Alley_jumper_civ07", "alley_jumpers", "male");
  level.alley_anim_node thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Alley_jumper_civ08", "alley_jumpers", "male");
  level.alley_anim_node thread scripts\sp\maps\hometown\hometown_util::spawn_dude_play_anim_and_delete("Alley_jumper_civ09", "alley_jumpers", "male");
}

function alley_looped_anims() {
  level waittill("alley_civ_jumpers");
}

function buried_black_fade() {
  var0 = scripts\sp\hud_util::create_client_overlay("black", 1);
  var0.lowresbackground = 1;
  var1 = scripts\sp\hud_util::create_client_overlay("overlay_hometown_vignette", 1);
  var1.lowresbackground = 1;
  var1.alpha = 0.8;
  wait 1;
  level.player lerpfovscalefactor(0, 0);
  level.player modifybasefov(60, 0.05);
  wait 1;
  var0 fadeovertime(1);
  var0.alpha = 0;
  wait 4;
  var0 destroy();
  level waittill("carried_started");
  var1 fadeovertime(5);
  var1.alpha = 0;
  wait 5;
  var1 destroy();
}

function white_helmet_vo() {
  level endon("farah_buried_vo_press");

  for(;;) {
    wait 2;
    wait 3;
    wait 3;
    wait 3;
  }
}

function wait_for_any_button_press() {
  level endon("buried_complete");
  var0 = scripts\engine\utility::getStruct("rebar_look_loc", "script_noteworthy");
  var1 = 0;

  while(var1 <= 2) {
    if(level.player attackButtonPressed() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, cos(180)) && level.got_rebar || level.player meleeButtonPressed() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, cos(180)) && level.got_rebar) {
      level notify("farah_buried_vo_press");

      if(var1 == 2) {
        wait 1.5;
        wait 2;
        var1++;
      }

      if(var1 == 1) {
        wait 1.5;
        var1++;
      }

      if(var1 == 0) {
        wait 1.5;
        var1++;
      }
    } else if(scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_rebar") || scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver")) {
      if(level.player fragButtonPressed() || level.player secondaryoffhandbuttonPressed() || level.player adsButtonPressed() || level.player useButtonPressed() || level.player crouchbuttonPressed() || level.player buttonPressed("DPAD_UP") || level.player buttonPressed("DPAD_LEFT") || level.player buttonPressed("DPAD_RIGHT") || level.player buttonPressed("DPAD_DOWN") || level.player jumpbuttonPressed()) {
        wait 1.5;
      }
    } else if(!scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_rebar") && !scripts\engine\sp\utility::player_has_weapon("iw8_knife_kid_screwdriver")) {
      if(level.player attackButtonPressed() || level.player fragButtonPressed() || level.player secondaryoffhandbuttonPressed() || level.player meleeButtonPressed() || level.player adsButtonPressed() || level.player useButtonPressed() || level.player crouchbuttonPressed() || level.player buttonPressed("DPAD_UP") || level.player buttonPressed("DPAD_LEFT") || level.player buttonPressed("DPAD_RIGHT") || level.player buttonPressed("DPAD_DOWN") || level.player jumpbuttonPressed()) {
        wait 1.5;
      }
    }

    waitframe();
  }
}

function buried_explosion_vfx() {
  level waittill("buried_explosion1");
  scripts\engine\utility::flag_set("objective_escape_rubble_complete");
  level.player scripts\engine\utility::delaycall(1.7, &setclienttriggeraudiozone, "ht_carried_01", 0.5);
  var0 = scripts\engine\utility::getStruct("buried_explosion_3", "script_noteworthy");
  scripts\engine\utility::delaythread(1.7, &scripts\engine\utility::play_sound_in_space, "scn_hometown_mig_bomb_expl", var0.origin);
  scripts\engine\utility::delaythread(0.7, &scripts\engine\utility::play_sound_in_space, "scn_hometown_mig_bomb_rumble_in", var0.origin);
  scripts\engine\utility::exploder("jdam_exp_01");
  scripts\engine\utility::exploder("bigsmoke");
  scripts\engine\utility::stop_exploder("burried_sun");
  thread jdam_earthquake();
}

function audio_main_siren_handler() {
  level waittill("buried_explosion1");
  wait 3;
  thread audio_start_air_raid_siren();
  thread audio_start_car_siren_handler();
}

function audio_start_air_raid_siren() {
  wait 3;
  level endon("death");
  var0 = spawn("script_origin", (486, -14, 1100));
  level.siren_snd_handle = undefined;

  for(;;) {
    if(!isDefined(level.siren_snd_handle)) {
      level.siren_snd_handle = scripts\engine\utility::play_sound_in_space("emt_dist_air_raid_siren", (486, -14, 1100), 0, var0);
    }

    if(scripts\engine\utility::flag("audio_stop_air_raid_siren")) {
      if(isDefined(level.siren_snd_handle)) {
        level.siren_snd_handle thread scripts\engine\sp\utility::sound_fade_and_delete(15);
      }

      break;
    }

    var1 = randomfloatrange(30, 33);
    wait var1;
    level.siren_snd_handle = undefined;
  }

  var0 delete();
  var0 = undefined;

  if(isDefined(level.siren_snd_handle)) {
    level.siren_snd_handle = undefined;
    return;
  }
}

function audio_start_car_siren_handler() {
  thread audio_start_car_siren_01();
  thread audio_start_car_siren_02();
  thread audio_start_car_siren_03();
}

function audio_start_car_siren_01() {
  level endon("death");
  var0 = spawn("script_origin", (2029, 2425, 101));
  var1 = scripts\engine\utility::play_loopsound_in_space("emt_car_siren_lp", (2029, 2425, 101));
  level.player waittill("farah_entered_house_notify");
  var1 thread scripts\engine\sp\utility::sound_fade_and_delete(20);
  var0 delete();
  var0 = undefined;
}

function audio_start_car_siren_02() {
  level endon("death");
  var0 = spawn("script_origin", (-2737, -1987, 75));
  var1 = scripts\engine\utility::play_loopsound_in_space("emt_car_siren_lp", (-2737, -1987, 75));
  level.player waittill("farah_entered_house_notify");
  var1 thread scripts\engine\sp\utility::sound_fade_and_delete(20);
  var0 delete();
  var0 = undefined;
}

function audio_start_car_siren_03() {
  level endon("death");
  var0 = spawn("script_origin", (1030, -1680, 151));
  var1 = scripts\engine\utility::play_loopsound_in_space("emt_car_siren_lp", (1030, -1680, 151));
  level.player waittill("farah_entered_house_notify");
  var1 thread scripts\engine\sp\utility::sound_fade_and_delete(20);
  var0 delete();
  var0 = undefined;
}

function jdam_earthquake() {
  wait 2;
  earthquake(0.8, 0.6, level.player.origin, 300);
  level.player playRumbleOnEntity("heavy_2s");
}

function sfx_intro_chaos() {
  wait 0.3;
  var0 = spawn("script_origin", level.player.origin);
  var0 playSound("sp_lvl_hometown_intro_chaos_01");
}

function post_alley_scene() {
  level.animname_incrementer = 1;
  var0 = getspawner("russian_shooter_1", "script_noteworthy");
  var0 scripts\engine\sp\utility::add_spawn_function(&scripts\sp\maps\hometown\hometown_util::post_alley_spawn_func);
  level.russian_shooter_1_ai = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1 = getspawner("russian_shooter_2", "script_noteworthy");
  var1 scripts\engine\sp\utility::add_spawn_function(&scripts\sp\maps\hometown\hometown_util::post_alley_spawn_func);
  level.russian_shooter_2_ai = var1 scripts\engine\sp\utility::spawn_ai(1);
  var2 = getspawner("russian_shooter_3", "script_noteworthy");
  var2 scripts\engine\sp\utility::add_spawn_function(&scripts\sp\maps\hometown\hometown_util::post_alley_spawn_func);
  level.russian_shooter_3_ai = var2 scripts\engine\sp\utility::spawn_ai(1);
  var3 = getspawner("russian_shooter_4", "script_noteworthy");
  var3 scripts\engine\sp\utility::add_spawn_function(&scripts\sp\maps\hometown\hometown_util::post_alley_spawn_func);
  level.russian_shooter_4_ai = var3 scripts\engine\sp\utility::spawn_ai(1);
  var4 = scripts\engine\utility::getStruct("post_alley_truck_scene_node", "script_noteworthy");
  var5 = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_female("post_alley_civ01", var4, 1);
  var6 = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_female("post_alley_civ02", var4, 1);
  var7 = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_female("post_alley_civ07", var4, 1);
  var8 = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_female("post_alley_civ09", var4, 1);
  var9 = scripts\sp\maps\hometown\hometown_util::make_script_model_civ("post_alley_civ03", var4, 1);
  var10 = scripts\sp\maps\hometown\hometown_util::make_script_model_civ("post_alley_civ06", var4, 1);
  var11 = scripts\sp\maps\hometown\hometown_util::make_script_model_civ("post_alley_civ04", var4, 1);
  var12 = scripts\sp\maps\hometown\hometown_util::make_script_model_civ("post_alley_civ05", var4, 1);
  var13 = scripts\sp\maps\hometown\hometown_util::make_script_model_civ("post_alley_civ08", var4, 1);
  var14 = scripts\engine\sp\utility::spawn_anim_model("post_alley_truck", var4.origin, var4.angles);
  var4 thread scripts\common\anim::anim_single_solo(var14, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(level.russian_shooter_1_ai, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(level.russian_shooter_2_ai, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(level.russian_shooter_3_ai, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(var5, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(var6, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(var7, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(var8, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(var9, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(var10, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(var11, "post_alley_truck_scene");
  var4 thread scripts\common\anim::anim_single_solo(var12, "post_alley_truck_scene");
  var4 scripts\common\anim::anim_single_solo(var13, "post_alley_truck_scene");
  level.russian_shooter_1_ai.ignoreall = 0;
  level.russian_shooter_2_ai.ignoreall = 0;
  level.russian_shooter_3_ai.ignoreall = 0;
  level.russian_shooter_4_ai.ignoreall = 0;
  level.player waittill("farah_entered_house_notify");
  level.russian_shooter_1_ai delete();
  level.russian_shooter_2_ai delete();
  level.russian_shooter_3_ai delete();
  level.russian_shooter_4_ai delete();
}

function dad_move_speed() {
  wait 2.5;
  level.farah_father_ai scripts\sp\utility::set_stayahead_values(1, 190, 0, 0.2);
  level.farah_father_ai scripts\sp\utility::set_stayahead_values(2, 120, -70, 0.1);
  level.farah_father_ai scripts\sp\utility::set_stayahead_values(3, 70, -120, 0);
  level.farah_father_ai scripts\sp\utility::set_stayahead_values(4, 30, -180, 0.2);
  level.farah_father_ai scripts\sp\utility::set_stayahead_wait_values(-230, 2.5);
  var0 = [];
  GscBinSkip0(0x2e, var0.size, getnode("alley_mid_node", "targetname"));
}

function fix_collision() {
  var0 = getEnt("post_boss_house_gate_clip", "script_noteworthy");
  var1 = spawn("script_model", (-575, -980, 5));
  var1.angles = (0, 0, 90);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("post_boss_house_gate_clip", "script_noteworthy");
  var3 = spawn("script_model", (-618, -980, 5));
  var3.angles = (0, 0, 90);
  var3 clonebrushmodeltoscriptmodel(var2);
  var4 = createnavobstaclebybounds((-537, -979, 12), (18, 20, 50), (0, 45, 0));
}

function alley_setup() {
  thread dad_move_speed();
  thread scripts\sp\maps\hometown\hometown_util::gas_cover_blown_monitor();
  thread scripts\sp\maps\hometown\hometown_util::buried_kill_trigger();
  thread fix_collision();
  level.post_boss_house_gate = getEnt("post_boss_house_gate", "script_noteworthy");
  level.post_boss_house_gate scripts\engine\sp\utility::hide_entity();
  level.post_boss_house_gate_clip = getEnt("post_boss_house_gate_clip", "script_noteworthy");
  level.post_boss_house_gate_clip scripts\engine\sp\utility::hide_entity();
  level.gas_attack_anim_node = getEnt("gas_attack_street_node", "script_noteworthy");
  level.gas_attack_left_anim_node = scripts\engine\utility::getStruct("gas_attack_from_left_node", "script_noteworthy");
  var0 = scripts\engine\utility::getStruct("gas_attack_enemy_truck_node", "script_noteworthy");
  thread scripts\sp\maps\hometown\hometown_vo::alley_start_vo();
  spawn_door_model();
  level.gasattack_ambulance_truck_model = scripts\engine\sp\utility::spawn_anim_model("gasattack_ambulance_truck", level.gas_attack_left_anim_node.origin, level.gas_attack_left_anim_node.angles);
  level.gasattack_wh01_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_wh("gasattack_wh01", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_wh02_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_wh("gasattack_wh02", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_wh03_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_wh("gasattack_wh03", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_civ01_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_female("gasattack_civ01", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_civ02_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_female("gasattack_civ02", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_civ03_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ("gasattack_civ03", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_civ04_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ("gasattack_civ04", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_civ05_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ("gasattack_civ05", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_civ06_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ("gasattack_civ06", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_civ07_model = scripts\sp\maps\hometown\hometown_util::make_script_model_civ_female("gasattack_civ07", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_attack_rus_01_model = scripts\sp\maps\hometown\hometown_util::make_script_model_russian("gasattack_attack_rus_01", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_attack_rus_02_model = scripts\sp\maps\hometown\hometown_util::make_script_model_russian("gasattack_attack_rus_02", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_attack_rus_03_model = scripts\sp\maps\hometown\hometown_util::make_script_model_russian("gasattack_attack_rus_03", level.gas_attack_left_anim_node, 1, 1);
  level.gasattack_enemy_truck_01_model = scripts\engine\sp\utility::spawn_anim_model("gasattack_enemy_truck_01", level.gas_attack_left_anim_node.origin, level.gas_attack_left_anim_node.angles);
  level.gasattack_enemy_truck_02_model = scripts\engine\sp\utility::spawn_anim_model("gasattack_enemy_truck_02", level.gas_attack_left_anim_node.origin, level.gas_attack_left_anim_node.angles);
  level.gasattack_civ01_model setModel("body_civ_syrkistan_female_5_2");
  level.gasattack_civ_female_01 = level.gasattack_civ01_model;
  level.gasattack_civ_male_01 = level.gasattack_civ04_model;
  level.gasattack_civ_male_02 = level.gasattack_civ05_model;
  level.gasattack_civ_male_03 = level.gasattack_civ06_model;
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_first_frame_solo(level.gasattack_ambulance_truck_model, "gasattack_intro");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_wh01_model, "gasattack_start_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_wh02_model, "gasattack_start_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_wh03_model, "gasattack_start_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ01_model, "gasattack_start_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ02_model, "gasattack_start_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ03_model, "gasattack_start_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ04_model, "gasattack_start_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ05_model, "gasattack_start_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ06_model, "gasattack_start_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_loop_solo(level.gasattack_civ07_model, "gasattack_start_idle");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_first_frame_solo(level.gasattack_enemy_truck_01_model, "gasattack_attack");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_first_frame_solo(level.gasattack_enemy_truck_02_model, "gasattack_attack");
  level.alley_anim_node = getEnt("alley_scenes_node", "script_noteworthy");
  scripts\engine\utility::flag_set("objective_get_to_hadir");
  scripts\engine\utility::flag_set("lighting_alley_progression");
  thread scripts\sp\maps\hometown\hometown_util::force_ai_see_player_square();
}

function dad_glance_loop() {
  for(;;) {
    level.farah_father_ai thread scripts\common\utility::civ_glancedownpath(1000);
    wait 2;
  }
}

function alley_main() {
  thread scripts\sp\maps\hometown\hometown_util::transient_load_boss();
  alley_setup();
  setomnvar("ui_hide_hud", 0);
  thread lerp_playerspeed_fov_in_alley();
  level.farah_father_ai scripts\asm\asm_bb::bb_setcivilianstate("stealth");
  level.farah_father_ai scripts\engine\utility::set_movement_speed(56);
  level.farah_father_ai aisettargetspeed(56);
  level.farah_father_ai scripts\asm\civilian\script_funcs::enableciviliantargetfocus(level.player);
  thread scripts\engine\sp\utility::autosave_by_name("alley_start_done");
  var0 = getnode("alley_start_node", "targetname");
  level.farah_father_ai setgoalnode(var0);
  thread scripts\sp\analytics::analytics_kleenex_update("Alley Start to House Enter");
  level.player clearclienttriggeraudiozone(2);
  scripts\engine\utility::flag_wait("alley_pre_start_passed");
  level.farah_father_ai scripts\common\utility::lookatentity(level.player);
  var1 = getnode("gas_attack_steet_mid_node", "targetname");
  level.farah_father_ai setgoalnode(var1);
  level.gas_attack_left_anim_node notify("stop_loop");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_single_solo(level.gasattack_ambulance_truck_model, "gasattack_intro");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_wh01_model, "gasattack_intro", "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_wh02_model, "gasattack_intro", "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_wh03_model, "gasattack_intro", "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ01_model, "gasattack_intro", "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ02_model, "gasattack_intro", "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ03_model, "gasattack_intro", "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ04_model, "gasattack_intro", "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ05_model, "gasattack_intro", "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ06_model, "gasattack_intro", "gasattack_idle");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ07_model, "gasattack_intro", "gasattack_idle");
  scripts\engine\utility::flag_wait("alley_start_passed");
  thread post_alley_scene();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowstand(1);
  level.alley_anim_node notify("stop_loop");
  level.alley_anim_node notify("stop_play_anim_and_then_loop");
  thread gas_attack_corpse_shader();
  thread sfx_alley_gas_walla();
  scripts\engine\utility::flag_wait("alley_mid_passed");
  level.alley_anim_node notify("stop_loop");
  level.alley_anim_node notify("stop_play_anim_and_then_loop");
  level.gas_attack_anim_node notify("stop_loop");
  level.gas_attack_anim_node notify("stop_play_anim_and_then_loop");
}

function gas_attack_corpse_shader() {
  level.gasattack_wh01_model scriptmoverdistancefade();
  level.gasattack_wh02_model scriptmoverdistancefade();
  level.gasattack_wh03_model scriptmoverdistancefade();
  level.gasattack_civ01_model scriptmoverdistancefade();
  level.gasattack_civ02_model scriptmoverdistancefade();
  level.gasattack_civ03_model scriptmoverdistancefade();
  level.gasattack_civ04_model scriptmoverdistancefade();
  level.gasattack_civ05_model scriptmoverdistancefade();
  level.gasattack_civ06_model scriptmoverdistancefade();
  level.gasattack_civ07_model scriptmoverdistancefade();
}

function sfx_alley_gas_walla() {
  var0 = spawn("script_origin", (-797, -1974, 66));
  var0 playLoopSound("scn_hometown_alley_pre_gas_attack_walla_lp");
  scripts\engine\utility::flag_wait("alley_attack_start_passed");
  wait 4;
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_alley_gas_attack_walla", (-747, -1998, 42));
  var0 scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
}

function dad_beckon_loop() {
  level endon("gas_attack_started");
  wait randomfloatrange(2, 3);

  for(;;) {
    level.farah_father_ai scripts\asm\gesture::ai_request_gesture("beckon", level.player, 500, "father_beckoned");
    wait randomfloatrange(2.7, 4);
  }
}

function gas_attack_main() {
  scripts\engine\utility::flag_wait("alley_attack_start_passed");
  var0 = 0;

  foreach(var2 in getaiarray("axis")) {
    if(isDefined(var2.enemy) || isDefined(var2.stealth.breacting) || isDefined(var2.stealth.binitialinvestigate) || isDefined(var2.stealth.bcoverhasbeenblown)) {
      var0 = 1;
      break;
    }
  }

  if(var0) {
    level.player dodamage(1000, (0, 0, 0));
  } else {
    thread scripts\engine\sp\utility::autosave_now("alley_attack_start");
  }

  thread audio_gassed_music();
  thread gas_playerexposedeffects();
  level.gas_trail_ground_done = 0;
  level notify("gas_attack_started");
  level.gas_attack_anim_node notify("stop_loop");
  level.gas_attack_anim_node notify("stop_play_anim_and_then_loop");
  level.gas_attack_left_anim_node notify("stop_loop");
  level.gas_attack_left_anim_node notify("stop_play_anim_and_then_loop");
  level.teargas_explode_started = 0;
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_wh01_model, "gasattack_attack", "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_wh02_model, "gasattack_attack", "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_wh03_model, "gasattack_attack", "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ01_model, "gasattack_attack", "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ02_model, "gasattack_attack", "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ03_model, "gasattack_attack", "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ04_model, "gasattack_attack", "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ05_model, "gasattack_attack", "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ06_model, "gasattack_attack", "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop(level.gasattack_civ07_model, "gasattack_attack", "gasattack_gassed");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_single_solo(level.gasattack_attack_rus_01_model, "gasattack_attack");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_single_solo(level.gasattack_attack_rus_02_model, "gasattack_attack");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_single_solo(level.gasattack_attack_rus_03_model, "gasattack_attack");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_single_solo(level.gasattack_enemy_truck_01_model, "gasattack_attack");
  level.gas_attack_left_anim_node thread scripts\common\anim::anim_single_solo(level.gasattack_enemy_truck_02_model, "gasattack_attack");
  thread gas_fail_timer();
  thread gas_fail_trigger();
  thread audio_gas_canister_smoke_atmos();
  var4 = getnode("gas_attack_steet_wall_node", "targetname");
  var5 = getnode("gas_attack_steet_wait_for_truck_node", "targetname");
  thread wait_for_truck_or_player();
  level.farah_father_ai setgoalnode(var5);
  level waittill("dad_go_to_house");
  thread dad_go_to_house();
  level.gas_attack_anim_node scripts\sp\anim::anim_reach_solo(level.farah_father_ai, "gas_attack_street");
  level notify("stop_rate_scale");
  level.farah_father_ai scripts\common\utility::lookatentity();
  level.house_intro_deadbolt_model = getEnt("boss_house_deadbolt", "script_noteworthy");
  level.house_intro_deadbolt_model.animname = "house_intro_deadbolt";
  level.house_intro_deadbolt_model scripts\engine\sp\utility::assign_animtree("house_intro_deadbolt");
  level.door_clip = getEnt("house_door_clip", "script_noteworthy");
  level.door_clip_boss_enter = getEnt("house_door_clip_boss_enter", "script_noteworthy");
  thread door_clip_delay();
  level.gas_attack_anim_node notify("stop_loop");
  level.gas_attack_anim_node notify("stop_play_anim_and_then_loop");
  level.gas_attack_anim_node thread scripts\sp\maps\hometown\hometown_util::play_anim_and_then_loop_with_nags(level.farah_father_ai, "gas_attack_street", "gas_attack_street_idle_b");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.gas_attack_house_door_model, "gas_attack_street_enter");
  level.gas_attack_anim_node thread scripts\common\anim::anim_single_solo(level.house_intro_deadbolt_model, "gas_attack_street_enter");
  scripts\engine\sp\utility::trigger_wait("house_start_trigger", "script_noteworthy");
  level.player thread scripts\engine\sp\utility::blend_movespeedscale(1, 1, "gas_run");
  level.player notify("farah_entered_house_notify");
  scripts\engine\utility::flag_set("audio_stop_air_raid_siren");
  stopFXOnTag(level._effect["vfx_tear_screenfx_01"], level.player, "tag_origin");
  setblur(0, 2);
  level.player scripts\engine\sp\utility::player_gesture_force("ges_nod");
  level.gasattack_attack_rus_01_model.gun_model delete();
  level.gasattack_attack_rus_02_model.gun_model delete();
  level.gasattack_attack_rus_03_model.gun_model delete();
  level.gasattack_attack_rus_01_model delete();
  level.gasattack_attack_rus_02_model delete();
  level.gasattack_attack_rus_03_model delete();
  level.gasattack_enemy_truck_01_model delete();
  level.door_clip solid();
  level.post_boss_house_gate scripts\engine\sp\utility::show_entity();
  level.post_boss_house_gate_clip scripts\engine\sp\utility::show_entity();
  level.pre_boss_house_gate = getEnt("pre_boss_house_gate", "script_noteworthy");
  level.pre_boss_house_gate scripts\engine\sp\utility::hide_entity();
  level.pre_boss_house_gate_clip = getEnt("pre_boss_house_gate_clip", "script_noteworthy");
  level.pre_boss_house_gate_clip scripts\engine\sp\utility::hide_entity();
  thread scripts\engine\sp\utility::autosave_by_name("house_start");
}

function door_clip_delay() {
  wait 1.6;
  level.door_clip notsolid();
  level.door_clip_boss_enter notsolid();
}

function audio_gassed_music() {
  wait 1;
  setmusicstate("mx_hometown_03_gassing");
}

function audio_dist_shootings() {
  level endon("farah_entered_house_notify");
  thread audio_dist_shootings_one_shot_executions();
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (482, -1257, 74));
  wait 0.3 + randomfloat(2);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (468, -740, 74));
  wait 0.4 + randomfloat(2);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (-34, -1024, 74));
  wait 0.6 + randomfloat(2);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (-34, -1024, 74));
  wait 0.8 + randomfloat(3);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (-34, -1024, 74));
  wait 1 + randomfloat(3);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (-34, -1024, 74));
  wait 1.1 + randomfloat(3);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (-71, -1031, 74));
  wait 1.2 + randomfloat(3);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (475, -1250, 74));
  wait 0.3 + randomfloat(3);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (-34, -1024, 74));
  wait 0.8 + randomfloat(3);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (-25, -1124, 74));
  wait 1 + randomfloat(3);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (-34, -1024, 74));
  wait 1.2 + randomfloat(3);
  thread scripts\engine\utility::play_sound_in_space("scn_hometown_russian_gunfire_dist_quick_burst", (440, -720, 74));
}

function audio_dist_shootings_one_shot_executions() {
  GscBinSkip1(0x45, 0, (-71, -1031, 74));
}

function audio_music_transition_to_alley() {
  setmusicstate("mx_hometown_02_alley_lp");
}

function audio_gas_canister_smoke_atmos() {
  wait 8;
  var0 = spawn("script_origin", (-941, -2199, 43));
  var1 = scripts\engine\utility::play_loopsound_in_space("emt_gas_canister_atmos_lp", (-941, -2199, 43));
  level.player waittill("farah_entered_house_notify");
  var1 thread scripts\engine\sp\utility::sound_fade_and_delete(12);
  var0 delete();
  var0 = undefined;
}

function wait_for_truck_or_player() {
  GscBinSkip4(0x35);
}

function wait_for_truck_or_player_trigger() {
  scripts\engine\sp\utility::trigger_wait("player_passed_triage_trigger", "script_noteworthy");
  level notify("dad_go_to_house");
}

function dad_go_to_house() {
  wait 2.75;
  level.player scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::blend_movespeedscale, 1.78, 3, "gas_run");
  level.farah_father_ai scripts\asm\asm_bb::bb_setcivilianstate("panic");
  level.farah_father_ai scripts\sp\utility::disable_stayahead();
  level.farah_father_ai scripts\sp\utility::set_stayahead_values(1, 220, 100, 0.2);
  level.farah_father_ai scripts\sp\utility::set_stayahead_values(2, 220, 0, 0.2);
  level.farah_father_ai scripts\sp\utility::set_stayahead_values(3, 170, -90, 0.1);
  level.farah_father_ai scripts\sp\utility::set_stayahead_values(4, 120, -180, 0.2);
  level.farah_father_ai thread scripts\sp\utility::enable_stayahead(level.player);
  wait 6;
  level.farah_father_ai scripts\sp\utility::disable_stayahead(120);
}

function alley_triggers_monitor() {
  scripts\engine\sp\utility::trigger_wait("alley_pre_start_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("alley_pre_start_passed");
  scripts\engine\sp\utility::trigger_wait("alley_start_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("alley_start_passed");
  scripts\engine\sp\utility::trigger_wait("alley_end_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("alley_mid_passed");
}

function gas_attack_triggers_monitor() {
  scripts\engine\sp\utility::trigger_wait("gas_attack_steet_mid_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("alley_attack_start_passed");
}

function alley_runners() {
  scripts\engine\sp\utility::trigger_wait("alley_pre_start_trigger", "script_noteworthy");
  var0 = scripts\engine\sp\utility::get_spawner_array("runners_01", "script_noteworthy");

  foreach(var2 in var0) {
    var3 = ["head_sc_m_mrehin_civ_dust", "head_sc_m_arakelyan_civ_dust", "head_sc_m_bansal_civ_dust", "head_sc_m_alameer_civ_dust", "head_sc_m_haghighi_civ_dust", "head_sc_m_nassernia_civ_dust", "head_sc_m_ahmadzai_civ"];
    var4 = ["body_civ_syrkistan_male_1_1", "body_civ_syrkistan_male_2_1", "body_civ_syrkistan_male_3_1", "body_civ_syrkistan_male_4_1", "body_civ_syrkistan_male_5_1", "body_civ_syrkistan_male_6_1", "body_civ_syrkistan_male_7_1", "body_civ_syrkistan_male_8_1", "body_civ_syrkistan_male_9_1", "body_civ_syrkistan_male_10_1"];
    var5 = scripts\engine\sp\utility::fakeactorspawn(var2);
    var5 setModel(scripts\engine\utility::random(var4));
    var5 detach(var5.headmodel);
    var5 attach(scripts\engine\utility::random(var3));
    wait randomfloatrange(0.1, 0.35);
  }

  scripts\engine\sp\utility::trigger_wait("alley_end_trigger", "script_noteworthy");
  var7 = scripts\engine\sp\utility::get_spawner_array("runners_02", "script_noteworthy");

  foreach(var2 in var7) {
    var3 = ["head_sc_m_mrehin_civ_dust", "head_sc_m_arakelyan_civ_dust", "head_sc_m_bansal_civ_dust", "head_sc_m_alameer_civ_dust", "head_sc_m_haghighi_civ_dust", "head_sc_m_nassernia_civ_dust", "head_sc_m_ahmadzai_civ"];
    var4 = ["body_civ_syrkistan_male_1_1", "body_civ_syrkistan_male_2_1", "body_civ_syrkistan_male_3_1", "body_civ_syrkistan_male_4_1", "body_civ_syrkistan_male_5_1", "body_civ_syrkistan_male_6_1", "body_civ_syrkistan_male_7_1", "body_civ_syrkistan_male_8_1", "body_civ_syrkistan_male_9_1", "body_civ_syrkistan_male_10_1"];
    var5 = scripts\engine\sp\utility::fakeactorspawn(var2);
    var5 setModel(scripts\engine\utility::random(var4));
    var5 detach(var5.headmodel);
    var5 attach(scripts\engine\utility::random(var3));
    wait randomfloatrange(0.1, 0.35);
  }

  scripts\engine\sp\utility::trigger_wait("house_start_trigger", "script_noteworthy");

  foreach(var2 in var0) {
    var2 delete();
  }

  foreach(var2 in var7) {
    var2 delete();
  }
}

function gas_cannister_launch(var0) {
  wait 4.5;
  var1 = self.gun_model gettagorigin("tag_flash");
  var2 = self.gun_model gettagorigin("tag_flash");
  var3 = spawn("script_model", var2);
  var3 setModel("anti_grav_grenade_wm");
  var4 = anglesToForward(var1);
  var4 *= randomfloatrange(50, 100);
  var5 = var4[0] + -800;
  var6 = var4[1] + 1000;
  var7 = 400;
  var3 physicslaunchserver(var3.origin, (var5, var6, var7));
  playFXOnTag(level._effect["vfx_htown_gas_trail"], var3, "tag_origin");
  wait 1.5;
  var8 = var3 gettagorigin("tag_origin");
  var9 = undefined;
  var10 = undefined;

  if(var0 == "true") {
    var9 = spawnfx(level._effect["vfx_htown_gas_emit"], var8, anglesToForward(self.angles));
    triggerfx(var9);
  }

  level.player waittill("farah_entered_house_notify");
  stopFXOnTag(level._effect["vfx_mortar_trail"], var3, "tag_origin");
}

function gas_playerexposedeffects() {
  level.player endon("death");
  level.player endon("farah_entered_house_notify");
  wait 8;
  kill_chickens();
  visionsetnaked("hometown_gas_close", 4);
  setblur(0.05, 2);
  level.player giveweapon("iw8_gunless_farrah");
  level.player scripts\common\utility::allow_melee(0);
  level.player switchtoweaponimmediate("iw8_gunless_farrah");
  level.player enableweapons();
  wait 1;
  level.player forceplaygestureviewmodel("ges_htf_mouthcover");
}

function gas_fail_trigger() {
  level.player endon("farah_entered_house_notify");
  scripts\engine\sp\utility::trigger_wait("gas_fail_trigger", "script_noteworthy");
  level scripts\sp\player_death::set_custom_death_quote(80);
  scripts\sp\utility::missionfailedwrapper();
}

function gas_fail_timer() {
  level.player endon("death");
  level.player endon("farah_entered_house_notify");
  wait 5;
  wait 5;
  wait 5;
  wait 5;
  level scripts\sp\player_death::set_custom_death_quote(80);
  scripts\sp\utility::missionfailedwrapper();
}

function kill_chickens() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level.chicken_array = getscriptablearray();

  foreach(var1 in level.chicken_array) {
    if(issubstr(var1.model, "chicken")) {
      var1 scripts\sp\utility::do_damage(100, level.player.origin);
    }
  }

  level.chicken_array = getEntArray("chicken_move", "script_noteworthy");

  foreach(var1 in level.chicken_array) {
    if(issubstr(var1.model, "chicken")) {
      var1 scripts\sp\utility::do_damage(100, level.player.origin);
    }
  }
}

function sfx_russians_shoot() {}

#using_animtree("");

function buried_rubble_setup() {
  level.buried_struggle_rubble_model = getEnt("hometown_rubble_pile_01", "script_noteworthy");
  level.buried_struggle_rubble_model.animname = "buried_struggle_rubble";
  level.buried_struggle_rubble_model useanimtree(#animtree);
  level.buried_struggle_rubble_hero_01_model = getEnt("hometown_rubble_hero_piece_01", "script_noteworthy");
  level.buried_struggle_rubble_hero_01_model.animname = "buried_struggle_rubble_hero_01";
  level.buried_struggle_rubble_hero_01_model useanimtree($);
  level.buried_struggle_rubble_hero_02_model = getEnt("hometown_rubble_hero_piece_02", "script_noteworthy");
  level.buried_struggle_rubble_hero_02_model.animname = "buried_struggle_rubble_hero_02";
  level.buried_struggle_rubble_hero_02_model useanimtree(#animtree);
  level.buried_struggle_rubble_hero_03_model = getEnt("hometown_rubble_hero_piece_03", "script_noteworthy");
  level.buried_struggle_rubble_hero_03_model.animname = "buried_struggle_rubble_hero_03";
  level.buried_struggle_rubble_hero_03_model useanimtree(#animtree);
  level.buried_struggle_rubble_hero_04_model = getEnt("hometown_rubble_hero_piece_04", "script_noteworthy");
  level.buried_struggle_rubble_hero_04_model.animname = "buried_struggle_rubble_hero_04";
  level.buried_struggle_rubble_hero_04_model useanimtree(#animtree);
  level.buried_struggle_rubble_hero_05_model = getEnt("hometown_rubble_hero_piece_05", "script_noteworthy");
  level.buried_struggle_rubble_hero_05_model.animname = "buried_struggle_rubble_hero_05";
  level.buried_struggle_rubble_hero_05_model useanimtree(#animtree);
  level.buried_struggle_rubble_hero_06_model = getEnt("hometown_rubble_hero_piece_06", "script_noteworthy");
  level.buried_struggle_rubble_hero_06_model.animname = "buried_struggle_rubble_hero_06";
  level.buried_struggle_rubble_hero_06_model useanimtree(#animtree);
  level.buried_struggle_rubble_hero_07_model = getEnt("hometown_rubble_hero_piece_07", "script_noteworthy");
  level.buried_struggle_rubble_hero_07_model.animname = "buried_struggle_rubble_hero_07";
  level.buried_struggle_rubble_hero_07_model useanimtree(#animtree);
  level.buried_rubble_pile_rocks_model = getEnt("hometown_rubble_pile_rocks", "script_noteworthy");
  level.buried_rubble_pile_rocks_model.animname = "buried_rubble_pile_rocks";
  level.buried_rubble_pile_rocks_model useanimtree(#animtree);
}

#using_animtree("generic_human");

function carried_time_dad_monitor() {
  waitframe();

  for(;;) {
    var0 = level.farah_father_ai getanimtime(%htf_cari_010_scenea_father);
    iprintlnbold("dad anim time:" + var0);
    wait 2;
  }
}

#using_animtree("player");

function carried_time_player_monitor() {
  waitframe();

  for(;;) {
    var0 = level.rail_player_model getanimtime(%htf_cari_010_scenea_player);
    iprintlnbold("player anim time:" + var0);
    wait 2;
  }
}

#using_animtree("script_model");

function spawn_door_model() {
  level.gas_attack_house_door_model = getEnt("boss_house_door_new", "script_noteworthy");
  level.gas_attack_house_door_model.animname = "boss_house_door";
  level.gas_attack_house_door_model useanimtree(#animtree);
  level.gas_attack_anim_node thread scripts\common\anim::anim_first_frame_solo(level.gas_attack_house_door_model, "gas_attack_street_enter");
}

#using_animtree("");

function father_mayhem() {
  if(!getdvarint("scr_no_father_mayhem")) {
    level waittill("father_mayhem_1_start");
    level.farah_father_ai detach("head_hero_farahs_father");
    level.farah_father_ai setanim(%htf_cari_010_scenea_father_01_face, 1, 0, 1);
    level waittill("father_mayhem_1_end");
    level.farah_father_ai setanim($htf_cari_010_scenea_father_01_face, 0, 0, 1);
    level.farah_father_ai attach("head_hero_farahs_father");
    level waittill("father_mayhem_2_start");
    level.farah_father_ai detach("head_hero_farahs_father");
    level.farah_father_ai setanim(%htf_cari_010_scenea_father_02_face, 1, 0, 1);
    level waittill("father_mayhem_2_end");
    level.farah_father_ai setanim(%htf_cari_010_scenea_father_02_face, 0, 0, 1);
    level.farah_father_ai attach("head_hero_farahs_father");
    level waittill("father_mayhem_3_start");
    level.farah_father_ai detach("head_hero_farahs_father");
    level.farah_father_ai attach("hat_hero_farahs_father_wind");
    level.farah_father_ai setanim(%htf_cari_010_scenea_father_03_face, 1, 0, 1);
    level waittill("father_mayhem_3_end");
    level.farah_father_ai setanim(%htf_cari_010_scenea_father_03_face, 0, 0, 1);
    level.farah_father_ai detach("hat_hero_farahs_father_wind");
    level.farah_father_ai attach("head_hero_farahs_father");
    level waittill("father_mayhem_4_start");
    level.farah_father_ai detach("head_hero_farahs_father");
    level.farah_father_ai setanim(%htf_cari_010_scenea_father_04_face, 1, 0, 1);
    level waittill("father_mayhem_4_end");
    level.farah_father_ai setanim(%htf_cari_010_scenea_father_04_face, 0, 0, 1);
    level.farah_father_ai attach("head_hero_farahs_father");
    level waittill("father_mayhem_5_start");
    level.farah_father_ai detach("head_hero_farahs_father");
    level.farah_father_ai setanim(%htf_cari_010_scenea_father_05_face, 1, 0, 1);
    level waittill("father_mayhem_5_end");
    level.farah_father_ai setanim(%htf_cari_010_scenea_father_05_face, 0, 0, 1);
    level.farah_father_ai attach("head_hero_farahs_father");
    return;
  }
}

function white_helmet_01_mayhem() {
  level waittill("wh1_mayhem_start");
  level.kargorgis_wh01_model detach("head_sc_m_kargorgis_civ_helmet_bg_dust");
  level.kargorgis_wh01_model setanim(%htf_bur_010_whitehelm01_01_face, 1, 0, 1);
  level waittill("wh1_mayhem_end");
  level.kargorgis_wh01_model setanim(%htf_bur_010_whitehelm01_01_face, 0, 0, 1);
  level.kargorgis_wh01_model attach("head_sc_m_kargorgis_civ_helmet_bg_dust");
}

function white_helmet_02_mayhem() {
  level waittill("wh2_mayhem_start");
  level.ahmadzai_wh02_model detach("head_sc_m_ahmadzai_civ_helmet_bg_dust");
  level.ahmadzai_wh02_model setanim(%htf_bur_010_whitehelm02_01_face, 1, 0, 1);
  level waittill("wh2_mayhem_end");
  level.ahmadzai_wh02_model setanim(%htf_bur_010_whitehelm02_01_face, 0, 0, 1);
  level.ahmadzai_wh02_model attach("head_sc_m_ahmadzai_civ_helmet_bg_dust");
}

function white_helmet_03_mayhem() {
  level waittill("wh3_mayhem_start");
  level.yurteri_wh03_model detach("head_sc_m_yurteri_civ_helmet_bg_dust");
  level.yurteri_wh03_model setanim(%htf_bur_010_whitehelm03_01_face, 1, 0, 1);
  level waittill("wh3_mayhem_end");
  level.yurteri_wh03_model setanim(%htf_bur_010_whitehelm03_01_face, 0, 0, 1);
  level.yurteri_wh03_model attach("head_sc_m_yurteri_civ_helmet_bg_dust");
}

function white_helmet_04_mayhem() {
  level waittill("wh4_mayhem_start");
  level.alameer_wh04_model detach("head_sc_m_alameer_civ_helmet_bg_dust");
  level.alameer_wh04_model setanim(%htf_bur_010_whitehelm04_01_face, 1, 0, 1);
  level waittill("wh4_mayhem_end");
  level.alameer_wh04_model setanim(%htf_bur_010_whitehelm04_01_face, 0, 0, 1);
  level.alameer_wh04_model attach("head_sc_m_alameer_civ_helmet_bg_dust");
}

function neighbordad_mayhem() {
  level waittill("nd_mayhem_start");
  level.neighbor_dad detach("head_sc_m_fahselt_civ_bg_dust");
  level.neighbor_dad setanim(%htf_cari_005_cafe_neighbordad_face, 1, 0, 1);
  level waittill("nd_mayhem_end");
  level.neighbor_dad setanim(%htf_cari_005_cafe_neighbordad_face, 0, 0, 1);
  level.neighbor_dad attach("head_sc_m_fahselt_civ_bg_dust");
}

function lerp_playerspeed_fov_in_alley() {
  level.player modifybasefov(50, 0.2);
  var0 = scripts\engine\utility::getStruct("alley_fov_lerp", "script_noteworthy");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = distance(var0.origin, var1.origin);
  var3 = 0;

  for(;;) {
    var4 = pointonsegmentnearesttopoint(var0.origin, var1.origin, level.player.origin);
    var5 = distance(var4, var0.origin);
    var6 = var5 / var2;

    if(var6 > var3) {
      var3 = var6;
      var7 = scripts\engine\math::factor_value(50, 75, var6);
      level.player modifybasefov(var7, 0.2);
    }

    if(var6 == 1) {
      break;
    }

    waitframe();
  }
}