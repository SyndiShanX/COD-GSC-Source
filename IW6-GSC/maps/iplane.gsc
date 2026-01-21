/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\iplane.gsc
*****************************************************/

iplane_start() {
  maps\iplane_fx::main();
  precache_items();
  init_level_flags();
  maps\iplane_anim::main();
  level.orig_phys_gravity = getdvar("phys_gravity");
  level.orig_ragdoll_gravity = getdvar("phys_gravity_ragdoll");
  level.orig_wakeupradius = getdvar("phys_gravityChangeWakeupRadius");
  level.orig_ragdoll_life = getdvar("ragdoll_max_life");
  level.orig_sundirection = (-14, 114, 0);
  init_mainai();
  level thread iplane_clean_up();
  level.player notifyonplayercommand("melee_button_pressed", "+melee");
  level.player notifyonplayercommand("melee_button_pressed", "+melee_breath");
  level.player notifyonplayercommand("melee_button_pressed", "+melee_zoom");
  common_scripts\utility::exploder("door_closed");
  start_opening_setup();
  level thread maps\_hud_util::fade_in(2, "black");
  level.player enabledeathshield(0);
  level thread maps\jungle_ghosts::parachute_start();
  level.impact_tree = 0;
}

iplane_crash() {
  maps\iplane_fx::main();
  precache_items();
  init_level_flags();
  maps\iplane_anim::main();
  level.orig_phys_gravity = getdvar("phys_gravity");
  level.orig_ragdoll_gravity = getdvar("phys_gravity_ragdoll");
  level.orig_wakeupradius = getdvar("phys_gravityChangeWakeupRadius");
  level.orig_ragdoll_life = getdvar("ragdoll_max_life");
  level.orig_sundirection = (-14, 114, 0);
  init_mainai();
  level.player notifyonplayercommand("melee_button_pressed", "+melee");
  level.player notifyonplayercommand("melee_button_pressed", "+melee_breath");
  level.player notifyonplayercommand("melee_button_pressed", "+melee_zoom");
  setup();
  level thread skipto_sound_setup();
  wait 0.7;
  thread moving_jeeps_and_crates();
  thread rotate_plane();
  level thread enemy_plane_behind_skipto();
  maps\iplane_code::player_on_back();
  common_scripts\utility::flag_set("large_crate_movement");
  wait 1;
  level.new_org maps\_utility::anim_stopanimscripted();
  level thread play_destroy_plane_spark_fx();
  level thread play_destroy_plane_burst_fx();
  player_falling();
  level notify("stop_plane_quakes");
  level notify("iplane_done");
  level thread maps\_hud_util::fade_in(2, "black");
  level.player setblurforplayer(10, 0.05);
  level.player setblurforplayer(0, 2);
  level thread maps\jungle_ghosts::parachute_start();
}

precache_items() {
  precacheshellshock("plane_sway");
  precacheshellshock("hijack_minor");
  precacheshellshock("hijack_airplane");
  precacheshellshock("iplane_slowview");
  precacheitem("ending_knife");
  precacheitem("jungle_ghost_f15_missile");
  precachemodel("generic_rope_A_animated");
  precachemodel("vehicle_Y_8");
  precachemodel("com_folding_chair");
  precachemodel("viewhands_player_gs_jungle_b");
  precachemodel("cnd_parachute");
  precachemodel("airplane_debris_wing_01_partb_iw6");
  precachemodel("airplane_debris_wing_01_parta_iw6");
  precachemodel("viewmodel_parachute_ripcord");
  precachemodel("ctl_parachute_player");
  precachemodel("ls_tarp_anim_03_scale60_jg");
  precacherumble("tank_rumble");
  precacherumble("subtle_tank_rumble");
  precachemodel("cnd_sleeve_flap_LE");
  precachemodel("cnd_sleeve_flap_RI");
}

init_level_flags() {
  common_scripts\utility::flag_init("plane_roll_right");
  common_scripts\utility::flag_init("plane_roll_left");
  common_scripts\utility::flag_init("plane_levels");
  common_scripts\utility::flag_init("plane_third_hit");
  common_scripts\utility::flag_init("ground_rotate_ref");
  common_scripts\utility::flag_init("ground_rotate_ref_off");
  common_scripts\utility::flag_init("player_in_position_to_climb");
  common_scripts\utility::flag_init("succesfull_climb");
  common_scripts\utility::flag_init("player_has_climbed");
  common_scripts\utility::flag_init("player_is_now_connected_to_the_plane");
  common_scripts\utility::flag_init("stop_climb_out");
  common_scripts\utility::flag_init("large_crate_movement");
  common_scripts\utility::flag_init("rip_tail_off");
  common_scripts\utility::flag_init("player_activated_ramps_open");
  common_scripts\utility::flag_init("raise_enemy_plane");
  common_scripts\utility::flag_init("start_explosion_breach");
  common_scripts\utility::flag_init("player_in_position_to_see_wing_enemies");
  common_scripts\utility::flag_init("open_bay_doors");
  common_scripts\utility::flag_init("start_fling0");
  common_scripts\utility::flag_init("baddies_leave_plane");
  common_scripts\utility::flag_init("player_at_window");
  common_scripts\utility::flag_init("elias_activated_button");
  common_scripts\utility::flag_init("kill_face_fx");
}

init_mainai() {
  level.enemies = [];
  var_0 = getEntArray("evil", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 maps\_utility::spawn_ai(1, 1);
    level.enemies[level.enemies.size] = var_3;

    if(!isDefined(var_3.script_noteworthy))
      continue;
    else if(var_3.script_noteworthy == "vargas") {
      level.vargas = var_3;
      level.vargas.animname = "vargas";
      level.vargas.name = "Rorke";
      level.vargas.team = "axis";
      level.vargas.script_pushable = 0;
      level.vargas maps\_utility::gun_remove();
    }
  }

  level.heroes = [];
  var_5 = getEntArray("bravo_team", "targetname");
  var_6 = getEntArray("alpha_team", "targetname");
  var_7 = common_scripts\utility::array_combine(var_5, var_6);

  foreach(var_2 in var_7) {
    var_9 = var_2 maps\_utility::spawn_ai(1, 1);
    var_9 pushplayer(1);
    level.heroes[level.heroes.size] = var_9;

    if(!isDefined(var_9.script_friendname))
      continue;
    else if(var_2.script_friendname == "Elias") {
      level.elias = var_9;
      level.elias.animname = "elias";
      level.elias maps\_utility::gun_remove();
    } else if(var_2.script_friendname == "Hesh") {
      level.hesh = var_9;
      level.hesh.animname = "hesh";
      level.hesh maps\_utility::forceuseweapon("honeybadger", "primary");
      level.hesh maps\_utility::gun_remove();
    } else if(var_2.script_friendname == "Merrick") {
      level.merrick = var_9;
      level.merrick.animname = "merrick";
      level.merrick maps\_utility::forceuseweapon("honeybadger", "primary");
    } else if(var_2.script_friendname == "Keegan") {
      level.keegan = var_9;
      level.keegan.animname = "keegan";
      level.keegan maps\_utility::forceuseweapon("honeybadger", "primary");
    }

    var_9 thread maps\_utility::set_ai_bcvoice("taskforce");
    var_9 animscripts\battlechatter_ai::assign_npcid();
    var_9 maps\_utility::make_hero();
    var_9.ignoresuppression = 1;
    var_9.suppressionwait = 0;
    var_9 maps\_utility::disable_surprise();
    var_9.ignorerandombulletdamage = 1;
    var_9.disableplayeradsloscheck = 1;
    var_9.grenadeawareness = 0;
    var_9.ignoreall = 1;
    var_9.ignoreme = 1;
    var_9.script_grenades = 0;
    var_9.originalbasaccuracy = var_9.baseaccuracy;
  }
}

start_opening_setup() {
  setup();
  thread sound_test();
  thread init_player();
  thread window_god_rays();
  thread create_smoke_and_ambience();
  thread moving_jeeps_and_crates();
  thread enemy_plane_behind();
  thread start_f15_attack();
  thread do_tarps();
  thread ramp_red_light();
  thread plane_ramp_light();
  thread light_fx();
  thread spawn_trigger_wait_open_doors();
  thread maps\iplane_interrogation::interroation_scene();
  common_scripts\utility::flag_wait("start_explosion_breach");
  thread rotate_plane();
  maps\iplane_code::player_on_back();
  common_scripts\utility::flag_set("large_crate_movement");
  level.new_org maps\_utility::anim_stopanimscripted();
  level thread play_destroy_plane_spark_fx();
  level thread play_destroy_plane_burst_fx();
  player_falling();
  level notify("iplane_done");
  level notify("stop_plane_quakes");
  level.player enableweapons();
}

player_falling() {
  level.player disableslowaim();
  level.player thread maps\_utility::play_sound_on_entity("scn_iplane_fall_01_lr");
  var_0 = spawn("script_model", level.player_rig.origin);
  var_0 setModel("tag_origin");
  level.player_rig linkto(var_0);
  level.player_rig thread maps\_anim::anim_single_solo(level.player_rig, "player_fall_2");
  level thread play_spark_fx_when_falling();
  var_0 movex(25000, 20, 2);
  stopallrumbles();
  maps\_utility::delaythread(0, maps\_utility::vision_set_fog_changes, "iplane_fall", 0);
  maps\_art::dof_disable_script(2);
  thread audio_player_falling_start();
  wait 1.7;
  level.player thread player_face_fx();
  level.player thread maps\_utility::play_sound_on_entity("crate_impact");
  wait 0.3;
  level.player playrumbleonentity("grenade_rumble");
  level.player thread maps\_gameskill::blood_splat_on_screen("bottom");
  level.player playrumbleonentity("damage_heavy");
  level.player setblurforplayer(5, 0.25);
  var_0 rotateto((0, 180, 0), 1.5, 0.5, 0.1);
  level.player setclienttriggeraudiozone("jungle_ghosts_falling_through_air_black_out", 1);
  maps\_hud_util::fade_out(1, "white");
  level.player lerpfov(65, 0.05);
  level.player setblurforplayer(0, 0.25);
  wait 1;
  level.player playrumbleonentity("grenade_rumble");
  var_0 rotateyaw(5220, 4, 0.5);
  var_0 movex(25000, 20, 2);
  wait 2;
  level.player playrumbleonentity("grenade_rumble");
  player_falling_2(var_0);
}

player_face_fx() {
  self.playerfxorg = spawn("script_model", self.origin + (0, 0, 0));
  self.playerfxorg setModel("tag_origin");
  self.playerfxorg.angles = self.angles;
  self.playerfxorg.origin = self getEye() - (0, 0, 10);
  self.playerfxorg linktoplayerview(self, "tag_origin", (5, 0, -55), (0, 0, 0), 1);
  playFXOnTag(common_scripts\utility::getfx("flying_face_fx"), self.playerfxorg, "TAG_ORIGIN");
  common_scripts\utility::flag_wait("kill_face_fx");
  stopFXOnTag(common_scripts\utility::getfx("flying_face_fx"), self.playerfxorg, "TAG_ORIGIN");
  self.playerfxorg delete();
}

audio_player_falling_start() {
  maps\_utility::delaythread(1.1, common_scripts\utility::play_sound_in_space, "scn_iplane_fall_01_exit_plane_lr", level.player.origin);
  wait 1.1;
  level.player setclienttriggeraudiozone("jungle_ghosts_falling_through_air", 0.8);
  maps\_utility::delaythread(1.9, common_scripts\utility::play_sound_in_space, "scn_iplane_fall_debris_whoosh_over_white", level.player.origin);
  thread enemy_plane_looping_sounds_fade_and_end();
}

iplane_unload() {
  var_0 = getEntArray("brush_model", "script_noteworthy");
  var_1 = getEntArray("brush_model", "targetname");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2)
  var_4 delete();

  var_6 = getEntArray("link_me_tail", "script_noteworthy");

  foreach(var_8 in var_6)
  var_8 delete();

  var_10 = getEntArray("iplane_bracket", "targetname");

  foreach(var_12 in var_10)
  var_12 delete();
}

player_falling_2(var_0) {
  level thread assemble_debris();
  level thread assemble_plane_wing();
  var_1 = common_scripts\utility::get_target_ent("enemy_plane");
  var_1 delete();
  level.destroy_plane_middles[0] delete();
  level.destroy_plane_middles[1] delete();
  level.plane_tail delete();
  level.plane_core delete();
  iplane_unload();
  level notify("iplane_clean_up");
  level.player unlink();
  level.player_rig delete();
  level.player_rig = maps\_utility::spawn_anim_model("player_rig", var_0.origin);
  level.player_rig.angles = (-90, 180, 0);
  level.player_rig linkto(var_0);
  var_2 = [];
  var_2[0] = maps\_utility::spawn_anim_model("exfil_ripcord_player", level.player_rig.origin);
  level.player playrumbleonentity("damage_heavy");
  var_2[0] linkto(level.player_rig, "tag_origin");
  var_2[1] = level.player_rig;
  level.player playerlinktoabsolute(level.player_rig, "tag_player");
  level.earthquake_min = 0.2;
  level.earthquake_max = 0.4;
  thread maps\iplane_interrogation::plane_quakes();
  level.player enabledeathshield(1);
  level.player lerpfov(80, 5);
  wait 1;
  var_3 = common_scripts\utility::getstruct("player_falling_teleport_origin", "targetname");
  var_0 moveto(var_3.origin, 0.05);
  var_0.angles = (180, 0, 0);
  level.player setblurforplayer(10, 0.05);
  wait 0.25;
  level.player thread maps\_utility::play_sound_on_entity("scn_iplane_fall_02_lr");
  level.player setclienttriggeraudiozone("jungle_ghosts_falling_through_air", 5.0);
  level thread maps\_hud_util::fade_in(2, "white");
  level.player setblurforplayer(0, 2.5);
  var_0 movez(-25000, 20, 2);
  wait 1.1;
  var_0 rotatepitch(680, 5.5, 1, 1);
  level waittill("player_fall_wing");
  level.player playrumbleonentity("grenade_rumble");
  wait 0.5;
  var_0 rotateto((180, 0, 0), 0.8, 0, 0);
  level waittill("player_fall_wing2");
  level.player playrumbleonentity("grenade_rumble");
  level notify("stop_plane_quakes");
  earthquake(0.6, 1, level.player.origin, 99999);
  level.player maps\_utility::delaythread(0.3, maps\_gameskill::blood_splat_on_screen, "left");
  level.player common_scripts\utility::delaycall(0.3, ::playrumbleonentity, "damage_heavy");
  var_0 rotateroll(1800, 6, 0.5, 0);
  wait 1.3;
  thread maps\iplane_interrogation::plane_quakes();
  thread common_scripts\utility::play_sound_in_space("scn_iplane_pull_rip_cord", level.player.origin);
  thread common_scripts\utility::play_sound_in_space("scn_iplane_chute_deploy", level.player.origin);
  level.player_rig thread maps\_anim::anim_single(var_2, "parachute_fall");
  level.player maps\_utility::delaythread(0.5, maps\_utility::play_sound_on_entity, "iplane_chute_deploy");
  wait 0.7;
  level.player playrumbleonentity("grenade_rumble");
  level.player setblurforplayer(5, 0.05);
  var_0 thread parachute_open_rotate();
  wait 0.05;
  level.player setblurforplayer(0, 0.05);
  var_0 movez(-15000, 20, 2);
  wait 0.5;
  level.player_rig maps\_utility::anim_stopanimscripted();
  level.player_rig thread maps\_anim::anim_single_solo(level.player_rig, "highfive_sky");
  wait 1.5;
  level.player thread maps\_utility::play_sound_on_entity("scn_iplane_fall_hit_01");
  level notify("player_look_down");
  var_0 rotateto((180, 0, 0), 2, 1, 1);
  level.player thread maps\_utility::lerp_fov_overtime(2, 55);
  wait 1.5;
  level.player common_scripts\utility::delaycall(0.2, ::playrumbleonentity, "grenade_rumble");
  level waittill("start_iplane_transition");
  level.player setblurforplayer(10, 0.05);
  level.player setclienttriggeraudiozone("jungle_ghosts_falling_through_air_black_out", 0.1);
  maps\_hud_util::fade_out(0.05, "black");
  level.player setblurforplayer(0, 0.05);
  wait 1;
  level.player_rig delete();
  var_0 delete();
  level.player thread maps\_utility::play_sound_on_entity("scn_iplane_fall_03_lr");
  var_2[0] delete();
  level.player thread maps\_utility::lerp_fov_overtime(0.05, 65);
  wait 2;
  level.player enabledeathshield(0);
  level notify("stop_plane_quakes");
}

parachute_open_rotate() {
  level endon("player_look_down");
  wait 0.2;
  self rotateto((-140, 10, 5), 0.2, 0, 0.2);
  wait 0.2;
  self rotateto((-90, -10, -4), 1, 0.3, 0.5);
  wait 1;
  self rotateto((-140, 10, 5), 1, 0.5, 0.5);
  wait 1;
  self rotateto((-100, -4, -3), 0.5, 0.2, 0.2);
  wait 0.5;
  self rotateto((-120, 4, 2), 0.5, 0.2, 0.2);
  wait 0.5;
  self rotateto((-110, -4, -3), 1, 0.5, 0.5);
}

assemble_debris() {
  var_0 = common_scripts\utility::getstructarray("debris", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel(var_2.script_noteworthy);
    var_3 rotateto((randomintrange(500, 720), randomintrange(500, 720), randomintrange(500, 720)), randomintrange(10, 20));
    var_3.targetname = "iplane_clearup";
  }
}

assemble_plane_wing() {
  var_0 = getent("plane_wing_1", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel(var_0.script_noteworthy);
  var_1.angles = var_0.angles;
  var_1 rotateroll(-1800, 9);
  var_1.targetname = "iplane_clearup";
  playFX(level._effect["vfx_helicrash_sparkrain"], var_1.origin);
  var_2 = getent("plane_wing_mid", "targetname");
  var_3 = spawn("script_model", var_2.origin + (0, 60, -550));
  var_3 setModel(var_2.script_noteworthy);
  var_3.angles = var_2.angles + (0, 180, 0);
  var_3 rotateyaw(7600, 20);
  var_3 movex(12666, 40);
  var_3.targetname = "iplane_clearup";
  var_3 thread hide_unhide();
  var_4 = getent("plane_wing_2", "targetname");
  var_5 = spawn("script_model", var_4.origin);
  var_5 setModel(var_4.script_noteworthy);
  var_5.angles = var_4.angles;
  var_6 = getent("plane_wing_2_trigger", "targetname");
  var_6 enablelinkto();
  var_6 linkto(var_5);
  var_5 rotatepitch(1900, 15);
  var_5.targetname = "iplane_clearup";
  var_6 thread check_for_player_impact();
  wait 7;
  playFX(level._effect["aerial_explosion_large"], var_5.origin);
}

play_explosion_fx() {
  wait 4;
  playFXOnTag(level._effect["aerial_explosion_large"], self, "tag_origin");
}

hide_unhide() {
  wait 5;
  level notify("player_fall_wing");
  wait 0.5;
  level notify("player_fall_wing2");
  wait 0.2;
  wait 6;
  self hide();
}

check_for_player_impact() {
  self waittill("trigger");
  level notify("start_iplane_transition");
}

do_hand_wheeling_anim(var_0) {
  level notify("kill_hand_wheeling_animation");
  level endon("iplane_done");
  level endon("kill_hand_wheeling_animation");
}

setup() {
  level.player setclienttriggeraudiozone("jungle_ghosts_start_black");
  var_0 = getent("baddy_plane", "targetname");
  var_0 hide();
  level.fly_away_or = spawn("script_origin", (-560, 4696, -1968));
  level.ent_parachute_from_plane_one = getent("parachute_from_plane_one", "targetname");
  level.ent_parachute_from_plane_two = getent("parachute_from_plane_two", "targetname");
  level.bay_door_lower = getent("saf_c17_lower_backdoor", "script_noteworthy");
  level.bay_door_upper = getent("saf_c17_lower_backdoor_top", "script_noteworthy");
  var_1 = getEntArray("saf_c17_lower_backdoor_script_model", "script_noteworthy");

  foreach(var_3 in var_1)
  var_3 linkto(level.bay_door_lower);

  var_1 = getEntArray("saf_c17_lower_backdoor_top_script_model", "script_noteworthy");

  foreach(var_3 in var_1)
  var_3 linkto(level.bay_door_upper);

  level.chair_vargas = getent("vargas_chair", "targetname");
  level.chair_vargas hide();
  level.plane_tail = getent("plane_tail", "targetname");
  level.plane_core = getent("plane_fuselage", "targetname");
  level.plane_core setModel("tag_origin");
  level.destroy_plane_middles = getEntArray("destroyed_plane_middle", "targetname");

  for(var_7 = 0; var_7 < level.destroy_plane_middles.size; var_7++) {
    level.destroy_plane_middles[var_7] linkto(level.plane_core);
    level.destroy_plane_middles[var_7] hide();
  }

  level.plane_tail linkto(level.plane_core);
  var_8 = getent("escape_enemy_plane_location", "targetname");
  var_8 linkto(level.plane_core);
  level.plane_test_origin = spawn("script_model", level.plane_core.origin);
  level.plane_test_origin setModel("tag_origin");
  var_9 = getent("metal_clip", "targetname");
  var_9 linkto(level.plane_core);
  getent("inb", "targetname").origin = getent("inb", "targetname").origin + (-100, 0, 0);
  level.baddies = getEntArray("baddies_enter", "script_noteworthy");

  foreach(var_11 in level.baddies)
  var_11 linkto(level.plane_core);

  var_13 = getEntArray("falling_spark_location", "targetname");

  foreach(var_15 in var_13)
  var_15 linkto(level.plane_core);

  var_1 = getEntArray("plane_interior_debris", "targetname");

  foreach(var_3 in var_1) {
    var_3 linkto(level.plane_core);
    var_3 hide();
  }

  maps\_utility::vision_set_fog_changes("iplane", 0.1);
  level.ent_parachute_from_plane_one linkto(level.plane_core);
  level.ent_parachute_from_plane_two linkto(level.plane_core);
  thread wing_break_off();
  var_19 = getent("bracket_c17", "targetname");
  var_19 linkto(level.plane_tail);
  var_20 = getEntArray("brush_model", "script_noteworthy");
  var_21 = getEntArray("brush_model", "targetname");
  var_22 = common_scripts\utility::array_combine(var_20, var_21);

  foreach(var_24 in var_22)
  var_24 linkto(level.plane_core);

  var_26 = common_scripts\utility::array_combine(level.enemies, level.heroes);

  foreach(var_28 in var_26)
  var_28 linkto(level.plane_core);

  var_30 = getent("m_p_l_r_tracker", "targetname");
  var_31 = getEntArray("link_me_tail", "script_noteworthy");

  foreach(var_33 in var_31)
  var_33 linkto(level.plane_tail);

  var_35 = getEntArray("plane_core_tarp", "script_noteworthy");

  foreach(var_37 in var_35)
  var_37 linkto(level.plane_core);

  var_1 = getEntArray("iplane_bracket", "targetname");

  foreach(var_3 in var_1)
  var_3 linkto(level.plane_tail);

  var_41 = getEntArray("destroy_plane_fx", "targetname");

  foreach(var_43 in var_41)
  var_43 linkto(level.plane_core);

  level.kersey_anim_org = getent("kersey_anim_start", "targetname");
  level.mccoy_anim_org = getent("mccoy_anim_start", "targetname");
  level.chair_vargas_2 = spawn("script_model", level.vargas.origin);
  level.chair_vargas_2 setModel("com_folding_chair");
  level.chair_vargas_2.animname = "chair_real";
  level.chair_vargas_2 maps\_anim::setanimtree();
  level.chair_vargas_2.reference = spawn("script_model", level.vargas.origin);
  level.chair_vargas_2.reference setModel("tag_origin");
  level.bay_door_upper_model = spawn("script_model", level.bay_door_upper.origin);
  level.bay_door_upper_model setModel("tag_origin");
  level.bay_door_upper_model linkto(level.plane_core);
  level.bay_door_upper linkto(level.bay_door_upper_model);
  level.bay_door_lower_model = spawn("script_model", level.bay_door_lower.origin);
  level.bay_door_lower_model setModel("tag_origin");
  level.bay_door_lower_model linkto(level.plane_core);
  level.bay_door_lower linkto(level.bay_door_lower_model);
  var_45 = getent("outside_of_plane", "targetname");
  var_45 linkto(level.plane_core);
  var_45 hide();
  level.rope_main_org = common_scripts\utility::spawn_tag_origin();
  level.rope_main_org.origin = level.plane_core.origin;
  level.rope_main_org.angles = level.plane_core.angles;
  level.rope_main_org linkto(level.plane_core);
}

window_god_rays() {
  level.godrays = getEntArray("god_ray_emitter", "targetname");

  foreach(var_1 in level.godrays) {
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;

    if(var_1.script_noteworthy == "window_volumetric_open_l") {
      continue;
    }
    if(var_1.script_noteworthy == "window_volumetric_open") {} else if(var_1.script_noteworthy == "window_volumetric_blinds") {}

    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_2.origin;
    var_2 linkto(var_3);
  }
}

create_smoke_and_ambience() {
  var_0 = spawn("script_model", (15128, 4744, -352));
  var_0 setModel("tag_origin");
  var_1 = spawn("script_model", (15470, 4742, -352));
  var_1 setModel("tag_origin");
  var_2 = spawn("script_model", (15288, 4738, -352));
  var_2 setModel("tag_origin");
  var_3 = spawn("script_model", (14856, 4750, -330));
  var_3 setModel("tag_origin");
}

move_flaps() {
  level endon("player_in_position_to_see_wing_enemies");

  for(;;) {
    wait 11;
    self rotatepitch(-3, 11);
    wait 11;
    self rotatepitch(3, 11);
  }
}

ramp_red_light() {
  level endon("iplane_done");
  common_scripts\utility::flag_wait("player_activated_ramps_open");
  var_0 = getEntArray("little_lights", "script_noteworthy");
  var_1 = getEntArray("tail_lights_script_models", "script_noteworthy");
  var_2 = getEntArray("tail_lights_red_off_one_model", "targetname");
  var_3 = getEntArray("tail_lights_red_off_two_model", "targetname");
  var_4 = getEntArray("tail_lights_red_off_three_model", "targetname");

  foreach(var_6 in var_1) {
    var_6 linkto(level.plane_tail);
    var_6.light_model = spawn("script_model", var_6.origin);
    var_6.light_model setModel("tag_origin");
    var_6.light_model linkto(level.plane_tail);
    var_6.light_model thread delete_light_on_clearup();
  }

  foreach(var_6 in var_0) {
    var_6 linkto(level.plane_tail);
    var_6.light_model = spawn("script_model", var_6.origin);
    var_6.light_model setModel("tag_origin");
    var_6.light_model linkto(level.plane_tail);
    var_6.light_model thread delete_light_on_clearup();
  }

  var_10 = getEntArray("tail_lights_red_off_one", "targetname");
  var_11 = getEntArray("tail_lights_red_off_two", "targetname");
  var_12 = getEntArray("tail_lights_red_off_three", "targetname");
  var_13 = 0;
  var_14 = 0;
}

delete_light_on_clearup() {
  level waittill("iplane_done");
  self delete();
}

mid_dlight() {
  var_0 = getEntArray("middle_d_lights", "targetname");
  var_1 = getEntArray("tail_d_lights", "targetname");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    var_4 linkto(level.plane_core);
    var_4 setModel("tag_origin");
  }

  for(;;) {
    wait 0.1;

    foreach(var_4 in var_2)
    playFXOnTag(common_scripts\utility::getfx("red_large_glow"), var_4, "tag_origin");

    wait 0.3;

    foreach(var_4 in var_2)
    stopFXOnTag(common_scripts\utility::getfx("red_large_glow"), var_4, "tag_origin");

    wait 0.3;
  }
}

core_lights_red() {
  level endon("iplane_done");
  var_0 = getEntArray("lights_red_fuselage", "targetname");

  foreach(var_2 in var_0) {
    var_2 linkto(level.plane_core);
    var_2 setModel("tag_origin");
  }

  var_4 = 0;

  while(var_4 <= 100) {
    wait 0.1;
    var_4++;

    foreach(var_2 in var_0)
    playFXOnTag(common_scripts\utility::getfx("red_small_front"), var_2, "tag_origin");

    wait 0.3;

    foreach(var_2 in var_0)
    stopFXOnTag(common_scripts\utility::getfx("red_small_front"), var_2, "tag_origin");

    wait 0.3;
  }
}

light_blink() {
  for(;;) {
    var_0 = 0;

    while(var_0 <= 19) {
      var_0++;
      var_1 = randomfloatrange(0.05, 0.1);
      var_2 = randomfloatrange(0.1, 0.5);
      self setlightintensity(var_2);
      wait(var_1);
      self setlightintensity(var_2);
      wait(var_1);
    }

    wait 0.9;
    var_0 = 0;

    while(var_0 <= 3) {
      var_0++;
      wait 0.1;
      self setlightintensity(0.4);
      wait 0.05;
    }

    self setlightintensity(0.6);
    wait(randomfloatrange(3.3, 7.9));
  }
}

rip_tail_off() {
  level.bay_door_upper_model linkto(level.plane_tail);
  level.bay_door_lower_model linkto(level.plane_tail);
  level.plane_tail_model = spawn("script_model", level.plane_tail.origin);
  level.plane_tail_model setModel("tag_origin");
  level.plane_tail_model.angles = level.plane_tail_model.angles;
  level.plane_tail linkto(level.plane_tail_model);
  level.plane_tail_model linkto(level.plane_core);
  level.plane_tail_model.animname = "tail";
  level.plane_tail_model maps\_anim::setanimtree();
  var_0 = spawn("script_model", level.plane_tail.origin + (-100, 0, 0));
  var_0.angles = var_0.angles + (0, 0, 180);
  var_0 linkto(level.plane_tail);
  var_0 setModel("tag_origin");
  level.plane_core_model thread maps\_anim::anim_single_solo(level.plane_tail_model, "tail_ripoff");
  common_scripts\utility::exploder("az_tail_separate");
  wait 7;
  level.plane_tail_model hide();
}

rip_left_wing_off() {
  var_0 = getent("c17_left_wing", "targetname");
  var_1 = getent("c17_left_wing_flap", "targetname");
  var_1.angles = var_1.angles + (0, 0, 0);
  var_1 thread move_flaps();
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("tag_origin");
  var_0 linkto(var_2);
  var_2 linkto(level.plane_core);
  var_2.animname = "wing_L";
  var_2 maps\_anim::setanimtree();
  var_1 linkto(var_0);
  var_2 maps\_anim::anim_single_solo(var_2, "wing_L_ripoff");
  var_2 hide();
  var_1 hide();
}

batman_rotate_plane() {
  level.plane_core_model = spawn("script_model", level.plane_core.origin);
  level.plane_core_model setModel("tag_origin");
  level.plane_core_model_dummy = spawn("script_model", level.plane_core.origin);
  level.plane_core_model_dummy setModel("tag_origin");
  level.plane_core_model_dummy.angles = level.plane_core.angles;
  self linkto(level.plane_core_model);
  remove_junk_behind_player();

  if(!isDefined(level.player_rig))
    level.player_rig = maps\_utility::spawn_anim_model("player_rig");

  level.player_rig linkto(level.plane_core);
  level.plane_core_model.animname = "plane_body";
  level.plane_core_model maps\_anim::setanimtree();
  level.chair_vargas_2 maps\_utility::anim_stopanimscripted();
  level.chair_vargas_2.reference maps\_utility::anim_stopanimscripted();
  level.plane_core maps\_utility::anim_stopanimscripted();

  if(isDefined(level.vargas.anim_node))
    level.vargas.anim_node notify("stop_loop");

  level.vargas maps\_utility::anim_stopanimscripted();
  level.vargas unlink();
  level.player playrumbleonentity("artillery_rumble");
  thread player_rotate_plane01();
  level.plane_core_model_dummy thread maps\_anim::anim_single([level.vargas, level.chair_vargas_2], "vargas_fall_1");
  var_0 = maps\_utility::spawn_anim_model("rappel_rope");
  level.plane_core_model_dummy thread maps\_anim::anim_single_solo(var_0, "rope_chair");
  wait 4;
  var_1 = maps\_utility::spawn_anim_model("firework");
  thread rip_tail_off();
  var_1 thread do_firework_fx();
  wait 2;
  level notify("end_firework");
  level.player playrumbleonentity("damage_heavy");
  thread batman_begins();
  var_2 = getent("batman00", "targetname");
  level.bad_guy = var_2 maps\_utility::spawn_ai(1, 1);
  level.bad_guy.animname = "generic";
  level.bad_guy maps\_utility::set_ignoreall(1);
  level.bad_guy maps\_utility::gun_remove();
  maps\_utility::delaythread(5.0, common_scripts\utility::play_sound_in_space, "scn_iplane_baddy_center_roping_in", level.player.origin);
  maps\_utility::delaythread(14.5, common_scripts\utility::play_sound_in_space, "scn_iplane_rorke_arm_around_baddy", level.player.origin);
  maps\_utility::delaythread(18.2, common_scripts\utility::play_sound_in_space, "scn_iplane_baddy_center_away", level.player.origin);
  wait 6;
  level.player playrumbleonentity("damage_heavy");
  level.plane_core_model_dummy waittill("vargas_fall_1");
  common_scripts\utility::flag_set("baddies_leave_plane");
  var_3 = maps\_utility::spawn_anim_model("rappel_rope");
  level.plane_core_model_dummy thread maps\_anim::anim_single([level.bad_guy, level.vargas, var_3], "plane_friendly_r");
  wait 10;
}

do_firework_fx() {
  level endon("end_firework");
  level.plane_core_model_dummy thread maps\_anim::anim_single_solo(self, "start_firework");

  for(;;) {
    playFXOnTag(level._effect["vfx_helicrash_sparkrain"], self, "tag_origin");
    wait 0.2;
  }
}

remove_junk_behind_player() {
  foreach(var_1 in level.jeeps_plane)
  var_1 delete();

  var_3 = getEntArray("cargo_falling_out", "script_noteworthy");

  foreach(var_5 in var_3)
  var_5 delete();
}

small_shakes_on() {
  level endon("iplane_done");
  var_0 = 12;
  level.player screenshakeonentity(var_0, var_0, var_0, 1.7, 0, 1.7, 500, 8, 15, 12, 1.8);
  wait 1.3;
  var_1 = 3;
  level.player screenshakeonentity(0.4, 0.4, 0.4, var_1, 0, 0, 500, 8, 15, 12, 1.8);
  wait 2.8;
  var_0 = 5.1;
  level.player screenshakeonentity(var_0, var_0, var_0, 2, 0, 2, 500, 8, 15, 12, 1.8);
  wait 1;
  var_1 = 0.4;
  level.player screenshakeonentity(0.4, 0.4, 0.4, var_1, 0, 0, 500, 8, 15, 12, 1.8);
  wait(var_1);
  var_0 = 2.1;
  level.player screenshakeonentity(var_0, var_0, var_0, 2, 0, 2, 500, 8, 15, 12, 1.8);
  wait 1.6;

  for(;;) {
    var_1 = randomfloatrange(3.7, 5.1);
    level.player screenshakeonentity(0.25, 0.25, 0.25, var_1, 0, 0, 500, 8, 15, 12, 1.8);
    wait(var_1);
    var_2 = 1.4;
    var_0 = randomfloatrange(3.3, 5.1);
    level.player screenshakeonentity(var_0, var_0, var_0, var_2, 0, var_2, 500, 8, 15, 12, 1.8);
    wait(var_2);
  }
}

#using_animtree("generic_human");

batman_begins() {
  var_0 = getEntArray("batman_helpers", "targetname");

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 character\character_elite_pmc_assault_a_black::main();
    var_2 useanimtree(#animtree);
    var_2.animname = "generic";
    var_2 attach("weapon_honeybadger", "TAG_WEAPON_LEFT");
    var_2 thread send_friends_in(var_1);
  }
}

talk() {
  level.vargas maps\_utility::smart_dialogue("iplane_rke_ifyoumakeit");
  wait 2;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_theresalwaysroomfor");
}

send_friends_in(var_0) {
  self hide();
  self.animname = "generic";

  if(var_0 == 0) {
    wait 5.4;
    var_1 = 7.6;
    var_2 = getent("in", "targetname");
    self linkto(var_2);
    self show();
    var_2 thread do_rope_animation(1, var_1);
    thread common_scripts\utility::play_sound_in_space("scn_iplane_baddy_left_roping_in", (15084, -29619, -36925));
    var_2 maps\_anim::anim_single_solo(self, "p_soldier_a_in");
    var_2 thread maps\_anim::anim_loop_solo(self, "p_soldier_a_idle");
    common_scripts\utility::flag_wait("baddies_leave_plane");
    wait 7.6;
    var_2 maps\_utility::anim_stopanimscripted();
    thread common_scripts\utility::play_sound_in_space("scn_iplane_baddy_left_away", (15084, -29619, -36925));
    var_2 maps\_anim::anim_single_solo(self, "p_soldier_a_out");
  }

  if(var_0 == 1) {
    wait 0.5;
    var_1 = 6.5;
    var_3 = getent("ind", "targetname");
    self linkto(var_3);
    self show();
    var_3 thread do_rope_animation(2, var_1);
    thread common_scripts\utility::play_sound_in_space("scn_iplane_baddy_right_center_roping_in", (15011, -29395, -36992));
    var_3 maps\_anim::anim_single_solo(self, "p_soldier_b_in");
    var_3 thread maps\_anim::anim_loop_solo(self, "p_soldier_b_idle");
    common_scripts\utility::flag_wait("baddies_leave_plane");
    wait 5.0;
    thread common_scripts\utility::play_sound_in_space("scn_iplane_baddy_right_center_away", (15011, -29395, -36992));
    wait 1.5;
    var_3 maps\_utility::anim_stopanimscripted();
    var_3 maps\_anim::anim_single_solo(self, "p_soldier_b_out");
  }

  if(var_0 == 2) {
    wait 3.5;
    var_1 = 3.6;
    var_4 = getent("inc", "targetname");
    var_4 unlink();
    var_4 movex(-100, 0.05);
    self linkto(var_4);
    self show();
    wait 0.05;
    var_4 thread do_rope_animation(3, var_1);
    thread common_scripts\utility::play_sound_in_space("scn_iplane_baddy_right_roping_in", (14957, -29360, -36901));
    var_4 maps\_anim::anim_single_solo(self, "p_soldier_c_in");
    var_4 thread maps\_anim::anim_loop_solo(self, "p_soldier_c_idle");
    common_scripts\utility::flag_wait("baddies_leave_plane");
    wait 3.6;
    var_4 maps\_utility::anim_stopanimscripted();
    thread common_scripts\utility::play_sound_in_space("scn_iplane_baddy_right_away", (14957, -29360, -36901));
    var_4 maps\_anim::anim_single_solo(self, "p_soldier_c_out");
  }

  if(var_0 == 3) {
    wait 0.6;
    var_1 = 2.6;
    var_5 = getent("inb", "targetname");
    self linkto(var_5);
    self show();
    var_5 thread do_rope_animation(4, var_1);
    thread common_scripts\utility::play_sound_in_space("scn_iplane_baddy_left_center_roping_in", (15117, -29542, -36984));
    var_5 maps\_anim::anim_single_solo(self, "p_soldier_d_in");
    var_5 thread maps\_anim::anim_loop_solo(self, "p_soldier_d_idle");
    common_scripts\utility::flag_wait("baddies_leave_plane");
    wait(var_1);
    var_5 maps\_utility::anim_stopanimscripted();
    thread common_scripts\utility::play_sound_in_space("scn_iplane_baddy_left_center_away", (15117, -29542, -36984));
    var_5 maps\_anim::anim_single_solo(self, "p_soldier_d_out");
  }

  self delete();
}

ground_movement() {
  common_scripts\utility::flag_wait("player_activated_ramps_open");
  level.ground_brush rotateyaw(-900, 1000);
  level.ground_brush moveto(level.ground_brush.origin + (100, 0, 100), 25, 5, 5);
  level.ground_brush waittill("movedone");
  level.ground_brush moveto(level.ground_brush.origin + (-100, 0, -100), 25, 5, 5);
  level.ground_brush waittill("movedone");
}

init_player() {
  level.player disableweapons();
  level.player allowsprint(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowjump(0);
  level.player enabledeathshield(1);
  level.player maps\_utility::player_speed_percent(35);
}

moving_jeeps_and_crates() {
  level.jeeps_plane = getEntArray("plane_jeep", "targetname");
  level.moving_crates_plane = getEntArray("moving_crates", "targetname");
  level.lights_on = getEntArray("lights_on", "targetname");
  level.lights_off = getEntArray("lights_off", "targetname");
  level.fire_ext_models = getEntArray("fire_ext", "targetname");
  level.tail_lights = getEntArray("lights_off_rear", "targetname");
  var_0 = getEntArray("lights_off_non_moving", "targetname");
  var_1 = getEntArray("lights_on_non_moving", "targetname");
  var_2 = getent("netting_front_r", "targetname");
  var_3 = getent("netting_front_l", "targetname");
  var_4 = getent("netting_middle", "targetname");
  var_5 = getent("netting_rear", "targetname");
  var_6 = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_8 in level.moving_crates_plane)
  var_8 linkto(level.plane_core);

  foreach(var_11 in level.lights_on)
  var_11 linkto(level.plane_core);

  foreach(var_14 in level.lights_off)
  var_14 linkto(level.plane_core);

  thread jeep_offset_anims();

  foreach(var_17 in level.fire_ext_models)
  var_17 linkto(level.plane_core);

  foreach(var_20 in level.tail_lights)
  var_20 linkto(level.plane_tail);

  foreach(var_23 in var_6)
  var_23 linkto(level.plane_core);
}

jeep_offset_anims() {
  foreach(var_1 in level.jeeps_plane) {
    var_1 linkto(level.plane_core);
    var_1.animname = "hummer";
    var_1 maps\_utility::assign_animtree("hummer");
    wait 1;
    var_1 thread maps\_anim::anim_loop_solo(var_1, "hummer_small_rocking");
  }
}

loop_guy_in_chair_beg() {
  common_scripts\utility::waitframe();
}

wing_break_off() {
  var_0 = getent("c17_left_wing", "targetname");
  var_1 = getent("full_engine", "targetname");
  var_2 = getent("engine_top", "targetname");
  var_3 = getent("engine_bottom", "targetname");
  var_4 = getent("c17_right_wing_engines", "targetname");
  var_5 = getent("engine_fan_one", "targetname");
  var_5 linkto(var_2);
  var_2 linkto(var_0);
  var_6 = getent("engine_moving_fan", "targetname");
  var_6 linkto(var_1);
  var_6 thread rotate_fan_on_engine();
  var_1 linkto(var_0);
  var_7 = getent("end_left_holder", "targetname");
  var_8 = getent("end_right_holder", "targetname");
  var_7 linkto(var_0);
  var_8 linkto(var_0);
  common_scripts\utility::flag_wait("player_in_position_to_see_wing_enemies");
  wait 6.3;
  thread rip_left_wing_off();
  wait 2.4;
}

setup_engine_fx(var_0, var_1) {
  var_2 = spawn("script_model", (15592, 5426, -340));
  var_2 setModel("tag_origin");
  var_2.angles = var_2.angles + (0, 180, 0);
  var_2 linkto(var_0);
  var_3 = spawn("script_model", (15730, 5116, -322));
  var_3 setModel("tag_origin");
  var_3.angles = var_3.angles + (0, 180, 0);
  var_3 linkto(var_0);
  var_4 = spawn("script_model", (15592, 4010, -340));
  var_4 setModel("tag_origin");
  var_4.angles = var_4.angles + (0, 140, 0);
  var_4 linkto(var_1);
  var_5 = spawn("script_model", (15726, 4312, -322));
  var_5 setModel("tag_origin");
  var_5.angles = var_5.angles + (0, 140, 0);
  var_5 linkto(var_1);
  playFXOnTag(common_scripts\utility::getfx("jet_engine"), var_2, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("jet_engine"), var_4, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("jet_engine"), var_3, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("jet_engine"), var_5, "tag_origin");
}

setup_contrails() {
  var_0 = getent("c17_left_wing", "targetname");
  var_1 = spawn("script_model", (15232, 5844, -280));
  var_1 setModel("tag_origin");
  var_1 linkto(var_0);
  var_2 = getent("c17_right_wing", "targetname");
  var_3 = spawn("script_model", (15232, 3590, -280));
  var_3 setModel("tag_origin");
  var_3 linkto(var_2);
  playFXOnTag(common_scripts\utility::getfx("contrail"), var_1, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("contrail"), var_3, "tag_origin");
}

rotate_fan_on_engine() {
  for(;;) {
    self rotatepitch(360, 1, 0.5, 0.5);
    wait 1;
  }
}

rotate_engine() {
  self.angles = self.angles + (-10, -3, 13);

  if(isDefined(self.targetname) && self.targetname == "engine_top")
    self.angles = self.angles + (40, 60, 70);

  if(isDefined(self.targetname) && self.targetname == "engine_bottom")
    self.angles = self.angles + (-120, -60, -120);

  for(;;) {
    if(!isDefined(self.targetname)) {
      continue;
    }
    if(self.targetname == "engine_top") {
      self rotateto((0, 0, 10), 1);
      self waittill("rotatedone");
      self rotateto((0, 230, 40), 1);
      self waittill("rotatedone");
    } else if(self.targetname == "engine_bottom") {
      self rotateto((0, 0, 10), 0.1);
      self waittill("rotatedone");
      self rotateto((0, 230, 40), 0.1);
      self waittill("rotatedone");
    } else
      self rotateto((0, 0, 10), 10);

    self waittill("rotatedone");
    self rotateto((0, 230, 40), 1);
    self waittill("rotatedone");
  }
}

trigger_wing_guys() {
  var_0 = getent("look_out_window", "targetname");
  var_1 = getent("button_model_on", "targetname");
  wait 1;
  var_2 = spawn("trigger_radius", var_1.origin, 0, 50, 50);

  for(;;) {
    if(level.player istouching(var_2)) {
      common_scripts\utility::flag_set("player_in_position_to_see_wing_enemies");
      wait 0.7;
      break;
    }

    wait 0.3;
  }
}

rotate_plane() {
  level.new_org = spawn("script_model", level.plane_core.origin);
  level.new_org.animname = "sky_anim";
  level.new_org.org_angles = level.new_org.angles;
  common_scripts\utility::flag_set("player_is_now_connected_to_the_plane");
  level notify("player_prompted_to_climb_out");

  foreach(var_1 in level.tail_lights)
  var_1 hide();
}

#using_animtree("player");

player_rotate_plane01() {
  var_0 = getent("outside_of_plane", "targetname");
  var_0 linkto(level.plane_core);
  var_0 hide();

  if(!isDefined(level.player_rig))
    level.player_rig = maps\_utility::spawn_anim_model("player_rig");

  level.player_rig unlink();
  level.player_rig hide();
  level.player_rig linkto(level.plane_core);
  var_1 = getanimlength(%plane_player_fall);
  level.player thread maps\_utility::play_sound_on_entity("scn_iplane_player_grab_bar");
  level.plane_core thread maps\_anim::anim_single_solo(level.player_rig, "player_fall", "tag_origin");
  stopallrumbles();
  maps\_utility::delaythread(3, ::small_shakes_on);
  thread maps\iplane_code::crawl_hurt_pulse();
  thread do_fx_plane_break();
  level.player_rig show();
  level.player playerlinktoblend(level.player_rig, "tag_player", 2.0, 1.5, 0);
  wait 2;
  maps\_art::dof_enable_script(0, 65, 10, 100, 271, 3.4, 2);
  var_0 hide();
  level.elias hide();
  level.merrick hide();
  level.hesh hide();
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 5, 5, 5, 0, 1);
  wait(var_1 - 2.5);
  level.player playrumbleonentity("damage_heavy");
  level.player playrumblelooponentity("tank_rumble");
  level.plane_core thread maps\_anim::anim_loop_solo(level.player_rig, "hanging_idle", "tag_origin");
  wait 2.5;
  level.destroy_plane_middles[0] show();
  level.destroy_plane_middles[1] show();
  wait 11.3;
  level notify("crawl_breath_recover");
}

screen_effects_middle01() {
  maps\_art::dof_enable_script(1, 1, 6, 200, 300, 3, 7.5);

  if(maps\_utility::is_gen4())
    wait 19.3;

  maps\_art::dof_disable_script(6);
}

enemy_plane_behind() {
  common_scripts\utility::flag_wait("raise_enemy_plane");
  var_0 = common_scripts\utility::get_target_ent("enemy_plane");
  var_0.animname = "enemy_plane";
  var_0 maps\_anim::setanimtree();
  var_1 = getent("fake_gun_fire", "targetname");
  var_2 = var_1 maps\_utility::spawn_ai(1, 1);
  var_2 teleport(var_0.origin);
  level.enemy_plane_engine_loop_01 = spawn("script_origin", var_0.origin + (300, 500, -250));
  level.enemy_plane_engine_loop_02 = spawn("script_origin", var_0.origin + (300, -500, 500));
  level.enemy_plane_engine_loop_03 = spawn("script_origin", var_0.origin);
  level.enemy_plane_engine_loop_04 = spawn("script_origin", var_0.origin);
  common_scripts\utility::waitframe();
  var_2 linkto(var_0, "tag_body", (0, 0, -100), (0, 0, 0));
  level.enemy_plane_engine_loop_01 linkto(var_0);
  level.enemy_plane_engine_loop_02 linkto(var_0);
  level.enemy_plane_engine_loop_03 linkto(var_0);
  level.enemy_plane_engine_loop_04 linkto(var_0);
  thread enemy_plane_looping_sounds_start();
  level.player playrumbleonentity("grenade_rumble");
  var_3 = var_0 common_scripts\utility::get_target_ent();
  var_0 moveto(var_3.origin, 6, 2, 4);
  var_0 rotateto(var_3.angles, 6, 0, 4);
  wait 5;
  level.alarm_ent = common_scripts\utility::spawn_tag_origin();
  level.alarm_ent.origin = level.plane_core.origin;
  level.alarm_ent linkto(level.plane_core);
  level.alarm_ent playLoopSound("iplane_warning_alarm");
  wait 2.5;
  level.player playrumbleonentity("grenade_rumble");
  common_scripts\utility::flag_set("fire_ropes");
  thread common_scripts\utility::play_sound_in_space("scn_iplane_hookup_l", (12206, -30991, -37000));
  thread common_scripts\utility::play_sound_in_space("scn_iplane_hookup_r", (13070, -28463, -37000));
  thread common_scripts\utility::play_sound_in_space("scn_iplane_hookup_ls", (15050, -29319, -36915));
  thread common_scripts\utility::play_sound_in_space("scn_iplane_hookup_rs", (15050, -29633, -36915));
  wait 4;
  level.player playrumbleonentity("grenade_rumble");
  common_scripts\utility::flag_set("start_explosion_breach");
  thread plane_explosion();
  thread show_inplane_debris();
  var_3 = var_3 common_scripts\utility::get_target_ent();
  thread common_scripts\utility::play_sound_in_space("scn_iplane_explosion", level.player.origin);
  var_0 moveto(var_3.origin + (0, 0, 0), 6, 2, 2);
  var_0 rotateto(var_3.angles, 6, 0, 4);
  var_0 waittill("movedone");
  var_0 moveto(var_3.origin, 3);
  var_0 waittill("movedone");
  thread plane_sway(var_0);
}

enemy_plane_looping_sounds_start() {
  level.enemy_plane_engine_loop_01 playLoopSound("scn_iplane_enemy_engine_left");
  level.enemy_plane_engine_loop_02 playLoopSound("scn_iplane_enemy_engine_right");
  level.enemy_plane_engine_loop_01 scalevolume(0.0, 0.0);
  level.enemy_plane_engine_loop_01 scalepitch(0.7, 0.0);
  level.enemy_plane_engine_loop_02 scalevolume(0.0, 0.0);
  level.enemy_plane_engine_loop_02 scalepitch(0.7, 0.0);
  wait 0.6;
  level.enemy_plane_engine_loop_01 scalevolume(1.0, 2.0);
  level.enemy_plane_engine_loop_01 scalepitch(1.0, 2.0);
  level.enemy_plane_engine_loop_02 scalevolume(1.0, 2.0);
  level.enemy_plane_engine_loop_02 scalepitch(1.0, 2.0);
  level.enemy_plane_engine_loop_04 maps\_utility::play_sound_on_entity("scn_iplane_enemy_rise");
}

enemy_plane_looping_sounds_fade_and_end() {
  if(isDefined(level.enemy_plane_engine_loop_01)) {
    level.enemy_plane_engine_loop_01 scalevolume(0.0, 3.8);
    level.enemy_plane_engine_loop_02 scalevolume(0.0, 3.8);
    level.enemy_plane_engine_loop_03 scalevolume(0.0, 3.8);
    wait 4.0;
    level.enemy_plane_engine_loop_01 delete();
    level.enemy_plane_engine_loop_02 delete();
    level.enemy_plane_engine_loop_03 delete();
    level.enemy_plane_engine_loop_04 delete();
  }
}

plane_sway(var_0) {
  var_1 = 200;
  var_2 = 5;
  var_3 = 6;
  level.rope_main_org rotatebylinked((-1 * var_2, 0, 0), var_3, var_3 * 0.4, var_3 * 0.4);
  var_0 moveto(var_0.origin - (var_1, 0, 0), var_3, var_3 * 0.4, var_3 * 0.4);
  var_0 rotatepitch(-1 * var_2, var_3, var_3 * 0.4, var_3 * 0.4);
  var_0 waittill("movedone");
  var_1 = var_1 * 2;
  var_2 = 10;
  var_3 = var_3 * 2;

  for(;;) {
    var_3 = 6;
    level.rope_main_org rotatebylinked((var_2, 0, 0), var_3, var_3 * 0.4, var_3 * 0.4);
    var_0 moveto(var_0.origin + (var_1, 0, 0), var_3, var_3 * 0.4, var_3 * 0.4);
    var_0 rotateyaw(var_2, var_3, var_3 * 0.4, var_3 * 0.4);
    var_0 waittill("movedone");
    level.rope_main_org rotatebylinked((-1 * var_2, 0, 0), var_3, var_3 * 0.4, var_3 * 0.4);
    var_0 moveto(var_0.origin - (var_1, 0, 0), var_3, var_3 * 0.4, var_3 * 0.4);
    var_0 rotateyaw(-1 * var_2, var_3, var_3 * 0.4, var_3 * 0.4);
    var_0 waittill("movedone");
  }
}

plane_fake_roll() {}

show_inplane_debris() {
  var_0 = getEntArray("plane_interior_debris", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();
}

plane_explosion() {
  var_0 = common_scripts\utility::get_target_ent("int_missile_explosion");
  level.alarm_ent stopsounds();
  thread audio_stop_car_rattles();
  level.player shellshock("hijack_minor", 1);
  level.player thread maps\_gameskill::blood_splat_on_screen("left");
  level.player thread maps\_gameskill::blood_splat_on_screen("right");
  level notify("stop_plane_quakes");
  earthquake(0.7, 1.75, level.player.origin, 1500);
  wait 1.5;
  level.player shellshock("hijack_minor", 1);
  thread maps\iplane_interrogation::plane_quakes();
  thread audio_start_destruction_loop();
}

audio_start_destruction_loop() {}

enemy_plane_behind_skipto() {
  level.bay_door_lower thread maps\iplane_interrogation::lower_bottom_bay_door(1);
  level.bay_door_upper thread maps\iplane_interrogation::raise_top_bay_door(1);
  var_0 = common_scripts\utility::get_target_ent("enemy_plane");
  var_0.animname = "enemy_plane";
  var_0 maps\_anim::setanimtree();
  var_1 = getent("fake_gun_fire", "targetname");
  var_2 = var_1 maps\_utility::spawn_ai(1, 1);
  var_2 teleport(var_0.origin);
  common_scripts\utility::waitframe();
  var_2 linkto(var_0, "tag_body", (0, 0, -100), (0, 0, 0));
  var_3 = var_0 common_scripts\utility::get_target_ent();
  var_0 moveto(var_3.origin, 0.1);
  var_0 rotateto(var_3.angles, 0.1);
  var_0 waittill("movedone");
  var_3 = var_3 common_scripts\utility::get_target_ent();
  var_0 moveto(var_3.origin, 0.1);
  var_0 rotateto(var_3.angles, 0.1);
  var_0 waittill("movedone");
  thread plane_sway(var_0);
  var_4 = getEntArray("ropes_hidden", "targetname");
  common_scripts\utility::array_thread(var_4, ::hidden_rope_skipto);
}

hidden_rope_skipto() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  self.animname = "rope";
  maps\_anim::setanimtree();
  self linkto(level.rope_main_org);
  var_0 thread maps\_anim::anim_single_solo(self, "rope_fire");
}

friends_reaction_to_enemy_plane() {
  level.mccoy_anim_org maps\_utility::anim_stopanimscripted();
  level.kersey_anim_org maps\_utility::anim_stopanimscripted();
  wait 1;
}

knock_player_with_raise() {
  wait 0.5;
  earthquake(0.34, 1, level.player.origin, 10000);
  wait 0.5;
  wait 0.5;
  earthquake(0.17, 16, level.player.origin, 10000);
  wait 0.3;
  wait 0.7;
}

audio_start_plane_engine_sounds() {
  level.player_plane_engine_right playLoopSound("scn_iplane_engine_right");
  level.player_plane_engine_left playLoopSound("scn_iplane_engine_left");
  level.player_plane_wind_01 playLoopSound("scn_iplane_wind_open_lp");
  level.player_plane_wind_02 playLoopSound("scn_iplane_wind_flaps_inside");
  level.player_plane_wind_05 playLoopSound("scn_iplane_wind_flaps_ramp_left");
  level.player_plane_wind_06 playLoopSound("scn_iplane_wind_flaps_ramp_right");
  thread audio_start_car_rattles();
  level.player_plane_engine_right scalevolume(0.0, 0.0);
  level.player_plane_engine_left scalevolume(0.0, 0.0);
  wait 0.1;
  level.player_plane_engine_right scalevolume(1.0, 4.0);
  level.player_plane_engine_left scalevolume(1.0, 4.0);
}

audio_start_car_rattles() {
  self endon("stop_car_wind_rattles");
  wait 0.1;
  thread audio_start_car_rattles_left();
  thread audio_start_car_rattles_right();
}

audio_start_car_rattles_left() {
  self endon("stop_car_wind_rattles");
  wait 0.1;

  for(;;) {
    level.player_plane_wind_03 maps\_utility::play_sound_on_entity("rex_metal_painted");
    var_0 = randomfloatrange(0.6, 2.0);
    wait(var_0);
  }
}

audio_start_car_rattles_right() {
  self endon("stop_car_wind_rattles");
  wait 0.7;

  for(;;) {
    level.player_plane_wind_04 maps\_utility::play_sound_on_entity("rex_metal_painted");
    var_0 = randomfloatrange(0.5, 1.1);
    wait(var_0);
  }
}

audio_stop_car_rattles() {
  level notify("stop_car_wind_rattles");
}

audio_plane_engine_sounds_dying() {
  level.player_plane_engine_right scalevolume(0.0, 2.0);
  level.player_plane_engine_left scalevolume(0.0, 2.0);
  level.player_plane_engine_right scalepitch(0.0, 2.0);
  level.player_plane_engine_left scalepitch(0.0, 2.0);
  wait 2.5;
  level.player_plane_engine_right stoploopsound();
  level.player_plane_engine_left stoploopsound();
  wait 0.1;
  level.player_plane_engine_right delete();
  level.player_plane_engine_left delete();
}

sound_test() {
  level.sound_org_four = spawn("script_origin", level.player.origin);
  level.player_plane_engine_right = spawn("script_origin", (14787, -29859, -36976));
  level.player_plane_engine_left = spawn("script_origin", (14787, -29193, -36976));
  level.player_plane_wind_01 = spawn("script_origin", (14190, -29455, -36848));
  level.player_plane_wind_02 = spawn("script_origin", (15142, -29383, -36890));
  level.player_plane_wind_03 = spawn("script_origin", (15300, -29518, -36907));
  level.player_plane_wind_04 = spawn("script_origin", (15334, -29406, -36912));
  level.player_plane_wind_05 = spawn("script_origin", (14652, -29569, -37098));
  level.player_plane_wind_06 = spawn("script_origin", (14652, -29415, -37098));
  level.player_plane_engine_right linkto(level.plane_core);
  level.player_plane_engine_left linkto(level.plane_core);
  wait 5.4;
  common_scripts\utility::flag_wait("player_activated_ramps_open");
  level.player setclienttriggeraudiozone("jungle_ghosts_plane_int_open", 4.0);
  thread audio_start_plane_engine_sounds();
  wait 8;
  level.bay_door_lower stoploopsound();
  level.bay_door_upper stoploopsound();
  common_scripts\utility::flag_wait("start_explosion_breach");
  wait 3.5;
  thread audio_plane_engine_sounds_dying();
  wait 2;
  wait 9;
  common_scripts\utility::flag_wait("player_is_now_connected_to_the_plane");
  wait 1;
  level waittill("iplane_done");
  level.sound_org_four delete();
}

skipto_sound_setup() {
  level.sound_org_four = spawn("script_origin", level.player.origin);
  common_scripts\utility::flag_wait("player_is_now_connected_to_the_plane");
  wait 1;
  level waittill("iplane_done");
  level.sound_org_four delete();
}

fx_climb_out_test() {
  level endon("iplane_done");
  level.player_anim_origin = spawn("script_model", level.player.origin);
  var_0 = spawn("script_model", level.player.origin + (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0.angles = var_0.angles + (0, 0, 90);
  var_0 linkto(level.player_anim_origin);
  level.player_anim_origin linkto(level.player);
  var_1 = spawn("script_model", level.player.origin + (0, 0, 0));
  var_1 setModel("tag_origin");
  var_1.angles = var_1.angles + (0, 180, 180);
  var_1 linkto(level.player_anim_origin);
  wait 2;
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = level.plane_core.origin + (100, 0, 0);
  var_2.angles = level.plane_core.angles + (110, 0, 0);
  playFXOnTag(common_scripts\utility::getfx("escape_dust_hijack1"), var_0, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("dirt_two"), var_1, "tag_origin");
  level.player_anim_origin.tags = [var_0, var_1];
  level.sound_org_four.origin = level.player.origin + (0, 50, -50);
  level.sound_org_four linkto(level.player);
  var_3 = 0;

  for(;;) {
    wait 6;

    switch (var_3) {
      case 0:
        break;
      case 1:
        level.sound_org_four playSound("hijk_tilt_stress_02");
        break;
    }
  }
}

do_tarps() {
  var_0 = getEntArray("animated_ramp_tarp", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("ls_tarp_anim_03_scale60_jg");
    var_3.targetname = "fake_tarp_ramp";
    var_3.angles = var_2.angles;
  }

  var_5 = getEntArray("tarps0", "targetname");

  foreach(var_2 in var_5) {
    var_2.animname = "taprs0_rock";
    var_2 linkto(level.plane_core);
    var_2 maps\_anim::setanimtree();
    var_2 thread maps\_anim::anim_loop_solo(var_2, "taprs0_anim");
  }
}

do_rope_animation(var_0, var_1) {
  var_2 = maps\_utility::spawn_anim_model("rappel_rope", (0, 0, 0));
  var_2 hide();
  var_2 linkto(self);
  var_2 show();
  maps\_anim::anim_single_solo(var_2, "rope_in_" + var_0);
  thread maps\_anim::anim_loop_solo(var_2, "rope_idle_" + var_0);
  common_scripts\utility::flag_wait("baddies_leave_plane");
  wait(var_1);
  maps\_utility::anim_stopanimscripted();
  maps\_anim::anim_single_solo(var_2, "rope_out_" + var_0);
  var_2 delete();
}

do_fx_plane_break() {
  wait 1.7;
  var_0 = spawn("script_model", level.plane_tail.origin + (-100, 0, 0));
  var_0.angles = var_0.angles + (0, 0, 180);
  var_0 linkto(level.plane_tail);
  var_0 setModel("tag_origin");
  wait 1;
  var_1 = getent("rip_apart_fx_ref00", "script_noteworthy");
  var_2 = getent("rip_apart_fx_ref02", "script_noteworthy");
  var_3 = spawn("script_model", var_1.origin + (-100, 0, 0));
  var_3.angles = var_3.angles + (-90, 0, -90);
  var_3 linkto(level.plane_core);
  var_3 setModel("tag_origin");
  var_4 = spawn("script_model", var_2.origin + (-100, 0, 0));
  var_4.angles = var_4.angles + (-90, 0, 0);
  var_4 linkto(level.plane_core);
  var_4 setModel("tag_origin");
  thread fx_climb_out_test();
  wait 2.7;
  var_4 unlink();
  stopFXOnTag(common_scripts\utility::getfx("escape_dust_hijack1"), var_4, "tag_origin");
  common_scripts\utility::waitframe();
  var_4 delete();
  common_scripts\utility::waitframe();
  var_4 = spawn("script_model", var_2.origin + (310, 80, 300));
  var_4.angles = var_2.angles + (180, 0, 0);
  var_4 linkto(level.plane_core);
  var_4 setModel("tag_origin");
}

iplane_clean_up() {
  level waittill("inter_done");
  level.keegan maps\_utility::unmake_hero();

  if(isDefined(level.keegan.magic_bullet_shield))
    level.keegan maps\_utility::stop_magic_bullet_shield();

  level.keegan delete();
  level waittill("iplane_clean_up");
  var_0 = maps\_utility::get_heroes();

  foreach(var_2 in var_0) {
    var_2 maps\_utility::unmake_hero();

    if(isDefined(var_2.magic_bullet_shield))
      var_2 maps\_utility::stop_magic_bullet_shield();

    var_2 delete();
  }

  var_4 = getaiarray();

  foreach(var_6 in var_4) {
    if(isDefined(var_6.magic_bullet_shield))
      var_6 maps\_utility::stop_magic_bullet_shield();

    var_6 delete();
  }

  maps\_utility::battlechatter_on();
  stopallrumbles();
  var_8 = getEntArray("little_lights", "script_noteworthy");

  foreach(var_10 in var_8)
  var_10 delete();

  var_12 = getEntArray("lights_red_fuselage", "targetname");

  foreach(var_10 in var_12)
  var_10 delete();

  foreach(var_16 in level.player_anim_origin.tags)
  var_16 delete();

  level.player_anim_origin delete();
}

get_fling_forward(var_0, var_1, var_2) {
  return var_0 * pow(var_1, var_2);
}

get_fling_up(var_0, var_1, var_2) {
  return var_0 * (1 - pow(var_1, var_2));
}

fling_object() {
  var_0 = level.player;

  while(self.origin[2] + 100 < var_0.origin[2])
    wait 0.05;

  var_1 = (0, 180, 0);
  var_2 = anglesToForward(var_1);
  var_3 = var_0.origin + var_2 * 2000;
  var_4 = var_0.origin + var_2 * -2000;
  var_5 = pointonsegmentnearesttopoint(var_3, var_4, self.origin);
  var_6 = self.origin;
  var_7 = 35;
  var_8 = anglesToForward(var_1 + (0, randomintrange(-3, 15), 0)) * 10;
  var_9 = vectortoangles(var_6 - var_5);
  var_10 = anglesToForward(var_9) * 30;
  var_11 = 2.6;
  var_12 = 0.94;

  if(isDefined(self.targetname) && self.targetname == "destroy_plane_debris02")
    self unlink();

  thread fling_angles_use();
  var_13 = 0.5;

  for(var_14 = 1; var_14 < var_7; var_14++) {
    var_15 = var_6 + get_fling_forward(var_8, var_11, var_14) + get_fling_up(var_10, var_12, var_14);
    self moveto(var_15, var_13);
    wait 0.5;
  }

  wait 10;
  self delete();
}

fling_angles_use() {
  self endon("death");
  var_0 = 0;
  wait 0.4;

  while(var_0 <= 1) {
    var_0++;
    var_1 = randomintrange(-50, -30);
    var_2 = randomintrange(-30, 30);
    var_3 = randomintrange(-5, 80);
    self rotatevelocity((var_1, var_2, var_3), 40000);
    wait 1;
  }

  var_0 = 0;
  wait 0.2;

  while(var_0 <= 5) {
    var_0++;
    var_1 = randomintrange(-50, -30);
    var_2 = randomintrange(-30, 30);
    var_3 = randomintrange(-5, 80);
    self rotatevelocity((var_1, var_2, var_3), 4000);
    wait 0.4;
  }
}

fling_debug(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");

  for(;;) {
    wait 0.05;
    var_6 = var_0;

    for(var_7 = 1; var_7 < 10; var_7++) {
      var_8 = var_0 + get_fling_forward(var_1, var_2, var_7) + get_fling_up(var_3, var_4, var_7);
      var_6 = var_8;
    }
  }
}

iplane_start_dialogue() {
  iprintlnbold("Logan, open the doors");
  level notify("open_ramp_dialogue");
  common_scripts\utility::flag_wait("player_activated_ramps_open");
  wait 10;
  level.elias maps\_utility::smart_dialogue("iplane_els_lookatme");
  wait 0.5;
  level.elias maps\_utility::smart_dialogue("iplane_els_rorkelookatme");
  wait 3;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_whatnotwhatyou");
  wait 1.5;
  level.elias maps\_utility::smart_dialogue("iplane_els_whatdidtheydo");
  wait 0.5;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_thesamethingyou");
  wait 1;
  level.elias maps\_utility::smart_dialogue("iplane_els_freeyourealap");
  wait 0.5;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_youneedtopull");
  level.vargas maps\_utility::smart_dialogue("iplane_rke_thecountryweloved");
  level.vargas maps\_utility::smart_dialogue("iplane_rke_wewerentthegreatest");
  level.vargas maps\_utility::smart_dialogue("iplane_rke_soenoughwiththis");
  wait 1;
  level.elias maps\_utility::smart_dialogue("iplane_els_iwanttoknow");
  level.elias maps\_utility::smart_dialogue("iplane_els_whatwereyoulooking");
  wait 1.3;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_youllknowsoonenough");
  wait 1.5;
  wait 4;
  level.elias maps\_utility::smart_dialogue("iplane_els_whyareyouhunting");
  wait 1;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_huntingnonono");
  wait 1;
  level.elias maps\_utility::smart_dialogue("iplane_els_againhithim");
  level thread nag_player_until_hit_again();
  level waittill("player_smack_baddie");
  wait 3;
  level.elias maps\_utility::smart_dialogue("iplane_els_alongtimeago");
  wait 0.5;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_everyonebreakseliasjust");
  wait 2.5;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_youboysshouldthink");
  wait 2;
  level.elias maps\_utility::smart_dialogue("iplane_els_hithimagain");
  level waittill("player_smack_baddie");
  wait 5.5;
  level.hesh maps\_utility::smart_dialogue("iplane_hsh_idontthinkyou");
  wait 0.5;
  level.hesh maps\_utility::smart_dialogue("iplane_hsh_tiedtoachair");
  wait 1;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_youhaventbeatenme");
  wait 0.5;
  level.elias maps\_utility::smart_dialogue("iplane_els_answerme");
  level notify("plane_attack");
}

nag_player_until_hit() {
  level endon("player_smack_baddie");
  wait 5;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_cmonkiddoshowme");
  wait 2;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_listentotheboss");
}

nag_player_until_hit_again() {
  level endon("player_smack_baddie");
  wait 5;
  level.vargas maps\_utility::smart_dialogue("iplane_rke_listentotheboss");
}

play_destroy_plane_spark_fx() {
  level endon("iplane_done");
  var_0 = getEntArray("destroy_plane_spark_fx", "targetname");
  common_scripts\utility::exploder("az_int_debr_front");

  for(;;) {
    foreach(var_2 in var_0) {
      playFXOnTag(level._effect["vfx_helicrash_sparkrain"], var_2, "tag_origin");
      wait(randomfloatrange(1, 3));
    }
  }
}

play_destroy_plane_burst_fx() {
  level endon("iplane_done");
  var_0 = getEntArray("destroy_plane_burst_fx", "targetname");

  for(;;) {
    foreach(var_2 in var_0) {
      playFXOnTag(level._effect["aerial_explosion_large"], var_2, "tag_origin");
      wait(randomfloatrange(1, 3));
    }
  }
}

setup_plane_debris(var_0, var_1) {
  wait(var_1);
  var_2 = [];
  var_2[var_2.size] = "pb_weaponscase";
  var_2[var_2.size] = "dg_plasticbarrel_closed_tan";
  var_2[var_2.size] = "sz_crate_federation_short";
  level.debri_sounds = 0;

  foreach(var_4 in var_0) {
    wait(randomfloatrange(0.3, 1.3));
    level.debri_sounds++;

    if(level.debri_sounds == 0)
      var_4 maps\_utility::delaythread(6.1, maps\_utility::play_sound_on_entity, "scn_iplane_ammo_left");

    if(level.debri_sounds == 1)
      var_4 maps\_utility::delaythread(0.98, maps\_utility::play_sound_on_entity, "scn_iplane_ammo_left");

    if(level.debri_sounds == 3)
      var_4 maps\_utility::delaythread(0.858, maps\_utility::play_sound_on_entity, "scn_iplane_ammo_right");

    if(level.debri_sounds == 4)
      var_4 maps\_utility::delaythread(1.146, maps\_utility::play_sound_on_entity, "scn_iplane_box1_right");

    if(level.debri_sounds == 5)
      var_4 maps\_utility::delaythread(1.94, maps\_utility::play_sound_on_entity, "scn_iplane_box1_right");

    var_4 thread fling_object();
  }
}

start_f15_attack() {
  var_0 = getent("f15_attacker", "targetname");
  var_1 = getvehiclenode("f15_start_attack_node", "targetname");
  var_2 = getvehiclenode("f15_second_attack_node", "targetname");
  var_3 = getvehiclenode("f15_start_attack_node_1", "targetname");
  var_4 = getvehiclenode("f15_second_attack_node_1", "targetname");
  var_5 = getvehiclenode("f15_start_attack_node_2", "targetname");
  var_6 = getvehiclenode("f15_second_start_node_2", "targetname");
  var_7 = getvehiclenode("f15_start_attack_node_3", "targetname");
  var_8 = getvehiclenode("f15_second_attack_node_3", "targetname");
  common_scripts\utility::flag_wait("raise_enemy_plane");
  thread common_scripts\utility::play_sound_in_space("scn_iplane_jet_right", (13070, -28463, -37114));
  thread common_scripts\utility::play_sound_in_space("scn_iplane_jet_left", (12206, -30991, -37246));
  wait 1.5;
  var_0 thread do_f15_raise_and_attack(var_3, "f15_target_2", var_4);
  wait 0.1;
  var_0 thread do_f15_raise_and_attack(var_5, "f15_target_4", var_6);
  wait 0.1;
  var_0 thread do_f15_raise_and_attack(var_7, "f15_target_3", var_8);
  wait 1;
  var_0 thread do_f15_raise_and_attack(var_1, "f15_target_1", var_2);
  wait 10;
  var_9 = getEntArray("f15_missile", "targetname");

  for(var_10 = 0; var_10 < var_9.size; var_10++)
    var_9[var_10] delete();
}

do_f15_raise_and_attack(var_0, var_1, var_2) {
  var_3 = maps\_utility::spawn_vehicle();
  var_3 thread maps\_vehicle::godon();
  var_3.angles = var_0.angles;
  var_3.origin = var_0.origin;
  var_3 attachpath(var_0);
  var_3 startpath(var_0);
  var_4 = common_scripts\utility::getstructarray(var_1, "targetname");
  common_scripts\utility::flag_wait("fire_ropes");
  wait 1;
  var_5 = spawn("script_model", var_3 gettagorigin("tag_left_wingtip") - (0, 0, -40));
  var_5.angles = self.angles;
  var_5 setModel("projectile_s5rocket");
  var_5.targetname = "f15_missiles";
  playFXOnTag(level._effect["f15_missile_trail"], var_5, "tag_Fx");
  var_6 = spawn("script_model", var_5.origin + (0, 0, -30));
  var_6 setModel("tag_origin");
  var_6.targetname = "f15_missiles";
  var_5 linkto(var_6);
  var_6 rotateroll(-1800, randomfloatrange(4, 6));

  if(var_0.targetname == "f15_second_start_node_2" || var_0.targetname == "f15_start_attack_node_3")
    var_6 moveto(var_4[0].origin, randomfloatrange(5, 6), 1);
  else
    var_6 moveto(var_4[0].origin, randomfloatrange(2, 3), 0.5);

  var_5 = spawn("script_model", var_3 gettagorigin("tag_right_wingtip") - (0, 0, -40));
  var_5.angles = self.angles;
  var_5 setModel("projectile_s5rocket");
  var_5.targetname = "f15_missiles";
  playFXOnTag(level._effect["f15_missile_trail"], var_5, "tag_Fx");
  var_6 = spawn("script_model", var_5.origin + (0, 0, -30));
  var_6 setModel("tag_origin");
  var_6.targetname = "f15_missiles";
  var_5 linkto(var_6);
  var_6 rotateroll(1800, randomfloatrange(4, 6));

  if(var_0.targetname == "f15_second_start_node_2" || var_0.targetname == "f15_start_attack_node_3")
    var_6 moveto(var_4[0].origin, randomfloatrange(5, 6), 1);
  else
    var_6 moveto(var_4[0].origin, randomfloatrange(2, 3), 0.5);

  wait 3;
  playFX(common_scripts\utility::getfx("vfx_helicrash_rpg_explosion"), var_4[0].origin);
  var_3 startpath(var_2);
  wait 10;
  var_3 delete();
}

plane_ramp_light() {
  var_0 = getEntArray("ramp_light", "targetname");
  var_1 = getEntArray("lower_ramp_light", "script_noteworthy");

  foreach(var_3 in var_1)
  var_3 linkto(level.bay_door_lower);

  common_scripts\utility::flag_wait("player_activated_ramps_open");

  foreach(var_6 in var_0)
  var_6 thread do_ramp_light();

  level waittill("iplane_done");

  foreach(var_3 in var_1)
  var_3 delete();
}

do_ramp_light() {
  level endon("iplane_done");
  var_0 = self;

  for(;;) {
    playFXOnTag(level._effect["dlight_glow_medium_red"], var_0, "tag_origin");
    playFXOnTag(level._effect["red_new_2"], var_0, "tag_origin");
    wait 0.2;
    stopFXOnTag(level._effect["dlight_glow_medium_red"], var_0, "tag_origin");
    stopFXOnTag(level._effect["red_new_2"], var_0, "tag_origin");

    if(isDefined(var_0.target)) {
      var_0 = getent(var_0.target, "targetname");
      continue;
    }

    var_0 = self;
  }
}

play_spark_fx_when_falling() {
  var_0 = getEntArray("falling_spark_location", "targetname");

  foreach(var_2 in var_0)
  playFXOnTag(level._effect["vfx_helicrash_sparkrain"], var_2, "tag_origin");
}

player_flap_sleeves_setup(var_0) {
  self.sleeve_flap_l = spawn("script_model", self.origin);
  self.sleeve_flap_l.angles = self.angles + (0, 60, 0);
  self.sleeve_flap_l setModel("cnd_sleeve_flap_LE");
  self.sleeve_flap_l useanimtree(#animtree);
  self.sleeve_flap_l linkto(level.vargas, "j_shoulder_le", (-5.5, 0, -5), (0, 0, 0));
  self.sleeve_flap_l.is_view_linked = 1;
  self.sleeve_flap_r = spawn("script_model", self.origin);
  self.sleeve_flap_r.angles = self.angles + (90, 90, 90);
  self.sleeve_flap_r setModel("cnd_sleeve_flap_ri");
  self.sleeve_flap_r useanimtree(#animtree);
  self.sleeve_flap_r linkto(level.vargas, "j_shoulder_ri", (-4.5, 2, 5.8), (-30, 190, 0));
  self.sleeve_flap_r.is_view_linked = 1;
  player_flap_sleeves();
}

player_hide_flaps_death() {
  self waittill("death");
}

player_flap_sleeves() {
  if(isDefined(self.sleeves_flapping) && self.sleeves_flapping) {
    return;
  }
  self.sleeves_flapping = 1;
  thread _sleeves_flap_internal();
}

player_stop_flap_sleeves() {
  self.sleeves_flapping = undefined;
  self notify("stop_sleeves");
}

_sleeves_idle(var_0) {
  if(!isDefined(var_0))
    var_0 = 1.0;

  self.sleeve_flap_l setanimknob(%player_sleeve_pose, 1.0, var_0, 1.0);
  self.sleeve_flap_r setanimknob(%player_sleeve_pose, 1.0, var_0, 1.0);
}

_sleeves_flap_internal() {
  var_0 = 0.2;
  var_1 = 5.0;
  var_2 = 0.8;
  var_3 = 1.2;
  var_4 = 0.45;

  while(isDefined(self.sleeves_flapping)) {
    var_5 = randomfloatrange(var_2, var_3);
    var_6 = 0.2;
    var_7 = 0;

    if(isDefined(level.rpl) && isDefined(level.rpl.wind_strength)) {
      var_8 = level.rpl.wind_strength;
      var_5 = clamp(var_8, var_4, var_8);
      var_7 = 1;
    }

    self.sleeve_flap_l setanimknob(%player_sleeve_flapping, 1.0, var_6, var_5);
    self.sleeve_flap_r setanimknob(%player_sleeve_flapping, 1.0, var_6, var_5);
    var_9 = randomfloatrange(var_0, var_1);

    if(var_7)
      var_9 = 0.05;

    var_10 = common_scripts\utility::waittill_notify_or_timeout_return("stop_sleeves", var_9);

    if(!isDefined(var_10)) {
      thread _sleeves_idle();
      return;
    }
  }
}

spawn_trigger_wait_open_doors() {
  var_0 = getent("ramp_button", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_2 = getent("button_model_on", "targetname");
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("tag_origin");
  var_4 = getent("button_model_off", "targetname");
  var_5 = spawn("script_model", var_4.origin);
  var_5 setModel("tag_origin");
  playFXOnTag(common_scripts\utility::getfx("red_small_front"), var_5, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("red_new_2"), var_1, "tag_origin");
  var_2 hide();
  common_scripts\utility::flag_wait("elias_activated_button");
  wait 1.4;
  stopFXOnTag(common_scripts\utility::getfx("red_small_front"), var_5, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("red_new_2"), var_1, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("green_glow"), var_1, "tag_origin");
  var_4 delete();
  var_2 show();
  common_scripts\utility::flag_wait("start_explosion_breach");
  stopFXOnTag(common_scripts\utility::getfx("green_glow"), var_1, "tag_origin");
  var_1 delete();
  var_3 delete();
  var_5 delete();
}

rotate_camera_pre_crash_one() {
  var_0 = getent("org_view_roll", "targetname");
  level.player playersetgroundreferenceent(var_0);
  var_0 rotateto((0, 0, 0), 0.1);
  var_0 waittill("rotatedone");

  while(!common_scripts\utility::flag("ground_rotate_ref_off")) {
    var_1 = randomfloatrange(10, 12);
    var_0 rotateto((0, 0, -5), var_1);
    wait(var_1);
    var_0 rotateto((0, 0, 5), var_1);
    wait(var_1);
  }

  var_0 rotateto((0, 0, 0), 0.3);
}

light_fx() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = getent("light_inside", "targetname");

  if(maps\_utility::is_gen4()) {
    level.light_outside = getent("ng_outside_light", "targetname");
    level.light_outside setlightintensity(0);
  }

  var_3 setlightintensity(0);

  while(!common_scripts\utility::flag("player_activated_ramps_open")) {
    if(maps\_utility::is_gen4()) {
      var_0 = randomfloatrange(2.0, 2.5);
      var_1 = randomfloatrange(2.5, 3.0);
      var_2 = randomfloatrange(3.0, 3.5);
    } else {
      var_0 = randomfloatrange(0.7, 0.9);
      var_1 = randomfloatrange(0.7, 0.9);
      var_2 = randomfloatrange(0.7, 0.9);
    }

    wait(randomfloatrange(0.1, 0.2));
    var_3 setlightintensity(var_0);
    wait(randomfloatrange(0.1, 0.2));
    var_3 setlightintensity(var_1);
    wait(randomfloatrange(0.1, 0.2));
    var_3 setlightintensity(var_2);
    wait(randomfloatrange(0.1, 0.3));
    var_3 setlightintensity(var_0);
    wait(randomfloatrange(0.1, 0.2));
    var_3 setlightintensity(var_1);
    wait(randomfloatrange(0.1, 0.2));
    var_3 setlightintensity(var_2);
    wait(randomfloatrange(0.2, 0.3));
    var_3 setlightintensity(var_0);
    wait(randomfloatrange(0.1, 0.3));
    var_3 setlightintensity(var_1);
    wait(randomfloatrange(0.1, 0.3));
    var_3 setlightintensity(var_2);
    wait(randomfloatrange(1, 3));
  }

  wait 4;

  if(maps\_utility::is_gen4()) {
    var_4 = 0;
    var_5 = 0;
    var_6 = 2.7;

    while(var_4 < var_6) {
      var_4 = var_4 + 0.01;
      var_5 = var_5 + 0.01;
      level.light_outside setlightintensity(var_5);
      wait 0.05;
    }
  }

  common_scripts\utility::flag_wait("start_explosion_breach");
  wait 1.8;

  if(maps\_utility::is_gen4())
    level.light_outside setlightintensity(0);

  if(maps\_utility::is_gen4())
    var_3 setlightcolor((0.25, 0, 0));
  else
    var_3 setlightcolor((0.5, 0, 0));

  while(!common_scripts\utility::flag("player_landed")) {
    if(maps\_utility::is_gen4()) {
      var_0 = randomfloatrange(0.3, 2.5);
      var_1 = randomfloatrange(2.5, 3.5);
    } else {
      var_0 = randomfloatrange(0.7, 0.9);
      var_1 = randomfloatrange(0.7, 0.9);
    }

    wait(randomfloatrange(0.1, 0.3));
    var_3 setlightintensity(var_0);
    wait(randomfloatrange(0.1, 0.3));
    var_3 setlightintensity(var_1);
    wait(randomfloatrange(0.1, 0.4));
  }
}