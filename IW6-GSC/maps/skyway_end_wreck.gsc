/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_end_wreck.gsc
*****************************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_end_wreck_start");
  common_scripts\utility::flag_init("flag_end_wreck_end");
  common_scripts\utility::flag_init("hint_displayed");
  common_scripts\utility::flag_init("gun_loaded");
  common_scripts\utility::flag_init("dry_fire");
  common_scripts\utility::flag_init("shot_successful");
  common_scripts\utility::flag_init("qte_prompt_solid");
  common_scripts\utility::flag_init("player_got_gun");
  common_scripts\utility::flag_init("look_down_forced");
  common_scripts\utility::flag_init("flag_qte_fail");
  common_scripts\utility::flag_init("flag_qte_end");
  common_scripts\utility::flag_init("knife_attached");
}

section_precache() {
  precacheitem("coltanaconda_skyway");
  precachemodel("viewmodel_magum_iw6");
  precachemodel("weapon_magnum_iw6");
  precachemodel("sw_traincar_loco_ending");
  precachemodel("sw_speedloader");
  precachemodel("weapon_bullet_iw5");
  precacheshader("hud_icon_colt_anaconda");
}

section_post_inits() {
  level._end_wreck = spawnStruct();
  level._end_wreck.ally_start = getent("ally1_start_end_swim", "targetname");
  level._end_wreck.player_start = getent("player_start_end_swim", "targetname");
}

start() {
  iprintln("end wreck");
  var_0 = getEntArray("bridge_end_1", "script_noteworthy");
  var_1 = getEntArray("bridge_end_2", "script_noteworthy");

  foreach(var_3 in var_0)
  var_3 hide();

  foreach(var_3 in var_1)
  var_3 hide();

  common_scripts\utility::flag_set("flag_end_wreck_start");
  maps\_utility::vision_set_fog_changes("skyway_endwreck", 0.1);

  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_mbEnable", "2");
    thread maps\skyway_util::set_motionblur_values(0.06, 1, 0.3, 0.59, 0.1);
  }

  maps\skyway_util::player_start(level._end_wreck.player_start);
  level._allies[0] forceteleport(level._end_wreck.ally_start.origin, level._end_wreck.ally_start.angles);
  level._allies[0] maps\_utility::set_force_color("r");
  var_7 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_7.alpha = 1;
  var_7.foreground = 0;
  level.black_overlay = var_7;
  maps\_utility::delaythread(0.05, maps\_utility::remove_extra_autosave_check, "fallen_cant_get_up");
}

main() {
  var_0 = getent("enemy_target", "targetname");
  var_0 hide();
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowmelee(0);
  thread maps\skyway_fx::fx_underwater_amb_01();
  wait 1;
  common_scripts\utility::flag_set("flag_end_wreck_start");
  thread fade_in_from_black();
  level.player playersetgroundreferenceent(undefined);
  maps\_utility::vision_set_fog_changes("skyway_endwreck", 0.1);
  part_2_setup();
  common_scripts\utility::flag_wait("flag_end_wreck_end");
  setblur(0, 0.1);
  level.player painvisionoff();
  level.player allowstand(1);
  thread cleanup_delayed();
  level._boss maps\_utility::gun_recall();
  setsaveddvar("player_view_pitch_down", 85);
  level.player playersetgroundreferenceent(undefined);
}

part_2_setup() {
  maps\skyway_util::skyway_hide_hud();
  thread maps\skyway_audio::sfx_water_amb();
  level.end_wreck_node = getent("end_wreck_origin", "targetname");
  var_0 = level._ally;
  var_0 maps\_utility::gun_remove();
  thread part_2_dialog(var_0);

  if(!isDefined(level._boss))
    maps\skyway_util::spawn_boss();

  var_1 = level._boss;
  var_1 maps\_utility::gun_remove();
  setsaveddvar("aim_aimAssistRangeScale", "0");
  setsaveddvar("aim_autoAimRangeScale", "0");
  level.player_rig = maps\_utility::spawn_anim_model("player_rig");
  var_2 = maps\_utility::spawn_anim_model("pt2_gun");
  var_3 = maps\_utility::spawn_anim_model("pt2_extinguisher");
  thread part_2_animated_seafloor();
  part_2_crash(var_0, var_1, level.player_rig, var_2, var_3);
  common_scripts\utility::flag_wait("player_got_gun");
  level.player showviewmodel();
  level.player enableweapons();
  level.player giveweapon("coltanaconda_skyway");
  level.player switchtoweapon("coltanaconda_skyway");
  level.player setweaponammoclip("coltanaconda_skyway", 0);
  level.player setweaponammostock("coltanaconda_skyway", 0);
  level.playerviewmodel = maps\_utility::spawn_anim_model("player_rig_magnum", level.player.origin);
  level.playerviewmodel linktoplayerview(level.player, "tag_player", (0, 0, 0), (0, 0, 0), 1);
  var_4 = level.player common_scripts\utility::spawn_tag_origin();
  level.player playerlinkto(var_4, "tag_origin", 0, 90, 90, 40, 40);
  level.player playSound("scn_sw_uw_pickup_gun_plr");
  level.player maps\_anim::anim_single_solo(level.playerviewmodel, "pt2_draw");
  level.player unlink();
  level.player thread maps\_anim::anim_loop_solo(level.playerviewmodel, "pt2_aim_loop", "stop_loop");
  thread part_2_gun_fire(var_2);
}

part_2_dialog(var_0) {
  level waittill("hesch_kick_vo");
  level endon("player_missed");
  level endon("shot_successful");

  if(!common_scripts\utility::flag("player_got_gun"))
    var_0 thread maps\_utility::smart_dialogue("skyway_hsh_getthegun");

  common_scripts\utility::flag_wait("player_got_gun");
  wait 3;

  if(!common_scripts\utility::flag("dry_fire"))
    var_0 thread maps\_utility::smart_dialogue("skyway_hsh_shoothim");

  level waittill("hesch_speedloader_vo");
  var_0 thread maps\_utility::smart_dialogue("skyway_hsh_here");
  common_scripts\utility::flag_wait("gun_loaded");
  wait 0.25;
  var_0 thread maps\_utility::smart_dialogue("skyway_hsh_logandoitnow");
  wait 1.75;
  var_0 thread maps\_utility::smart_dialogue("skyway_hsh_doit");
}

part_2_animated_seafloor(var_0) {
  var_0 = getent("sea_floor_animated", "targetname");
  var_1 = getent("light_target_seafloor", "targetname");
  var_0 retargetscriptmodellighting(var_1);
  var_0.animname = "seafloor";
  var_0 maps\_anim::setanimtree();
  level.end_wreck_node thread maps\_anim::anim_single_solo(var_0, "pt2_crash");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2 linkto(var_0, "tag_fx_impact_dust_cloud", (0, 0, 0), (0, 0, 0));
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3 linkto(var_0, "tag_fx_impact_dust_cloud_2", (0, 0, 0), (0, 0, 0));
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4 linkto(var_0, "tag_fx_impact_dust_cloud_3", (0, 0, 0), (0, 0, 0));
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_5 linkto(var_0, "tag_fx_impact_dust_cloud_4", (0, 0, 0), (0, 0, 0));
  level waittill("notify_hit_floor_1");
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_ent, 0.8, 0.0, 0.2, 0.0, 0.8);
  earthquake(0.35, 0.7, level.player.origin, 3000);
  level.player thread maps\_utility::play_sound_on_entity("sw_Train_hit_seafloor_big");
  level.player thread maps\_utility::play_sound_on_entity("sw_train_hit_seafloor_1");
  level.player thread maps\_utility::play_sound_on_entity("emt_skyway_mtl_crgtd_hit");
  level.player thread maps\_utility::play_sound_on_entity("emt_skyway_mtl_stress_big");
  wait 0.15;
  common_scripts\utility::exploder("underwater_loco_headlight_dust");
  playFXOnTag(common_scripts\utility::getfx("underwater_particulate_cloud_spot"), var_2, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("underwater_particulate_cloud_03"), var_2, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("underwater_particulate_cloud_03"), var_3, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("underwater_particulate_cloud_03"), var_4, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("underwater_particulate_cloud_03"), var_5, "tag_origin");
  wait 1.5;
  maps\_utility::stop_exploder("underwater_loco_headlight");
  level waittill("notify_hit_floor_2");
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.3, 0.4, level.player.origin, 3000);
  level.player thread maps\_utility::play_sound_on_entity("sw_train_hit_seafloor_2");
  level.player thread maps\_utility::play_sound_on_entity("emt_skyway_mtl_crgtd_hit");
  level waittill("notify_hit_floor_3");
  level.player playrumbleonentity("damage_light");
  earthquake(0.15, 0.3, level.player.origin, 3000);
  level.player thread maps\_utility::play_sound_on_entity("sw_train_hit_seafloor_3");
  level.player thread maps\_utility::play_sound_on_entity("emt_skyway_mtl_stress_big");
  level waittill("notify_hit_floor_4");
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.3, 0.4, level.player.origin, 3000);
  level.player thread maps\_utility::play_sound_on_entity("sw_train_hit_seafloor_2");
  level.player thread maps\_utility::play_sound_on_entity("emt_skyway_mtl_crgtd_hit");
  level waittill("flag_end_swim_start");
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
}

part_2_crash(var_0, var_1, var_2, var_3, var_4) {
  thread player_hurt_effects();
  thread glass_crack_effects();
  var_5 = [];
  var_5["ally1"] = var_0;
  var_5["enemy"] = var_1;
  var_5["extinguisher"] = var_4;
  var_5["gun"] = var_3;
  var_5["player_rig"] = var_2;
  var_6 = [];
  var_7 = maps\_utility::spawn_anim_model("debris");
  wreck_enemy_setup();
  var_6["debris"] = var_7;
  var_6["dead_guy_1"] = level.end_enemies[0];
  var_6["dead_guy_2"] = level.end_enemies[1];
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player hideviewmodel();
  level.player freezecontrols(1);
  level.player allowprone(1);
  level.player allowstand(0);
  level.player allowcrouch(0);
  level.player setstance("prone");
  var_8 = 0;
  level.player playerlinktodelta(var_2, "tag_player", 0, var_8, var_8, var_8, var_8, 1);
  thread maps\skyway_audio::sfx_wreck_01();
  thread part_2_ambient_animations(var_6);
  level.end_wreck_node maps\_anim::anim_single(var_5, "pt2_crash");
  thread part_2_crawl(var_0, var_1, var_2, var_3, var_4);
  part_2_crawl_player(var_0, var_1, var_2, var_3);
}

wreck_enemy_setup() {
  var_0 = getEntArray("loco_breach_enemy", "targetname");

  if(!isDefined(level.end_enemies))
    level.end_enemies = [];
  else {
    foreach(var_2 in level.end_enemies) {
      if(isalive(var_2)) {
        if(isDefined(var_2.magic_bullet_shield))
          var_2 thread maps\_utility::stop_magic_bullet_shield();

        var_2 delete();
      }
    }
  }

  for(var_4 = 0; var_4 < 2; var_4++) {
    if(!isDefined(level.end_enemies[var_4]) || !isalive(level.end_enemies[var_4])) {
      var_0[var_4].count = 2;
      var_5 = var_0[var_4] maps\_utility::spawn_ai(1);
      var_5 prepare_enemy_for_wreck();
      var_5.animname = "opfor" + (var_4 + 1);
      level.end_enemies[var_4] = var_5;
    }
  }
}

prepare_enemy_for_wreck() {
  maps\_utility::set_battlechatter(0);
  self.combatmode = "no_cover";
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.newenemyreactiondistsq_old = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
  self.grenadeammo = 0;
  maps\_utility::gun_remove();
}

part_2_ambient_animations(var_0) {
  var_0 thread ambient_guys_anims();
  common_scripts\utility::flag_wait("flag_end_wreck_end");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.magic_bullet_shield))
      var_2 thread maps\_utility::stop_magic_bullet_shield();

    var_2 delete();
  }

  level notify("notify_amb_guys_deleted");
  level.end_enemies = undefined;
}

ambient_guys_anims() {
  level endon("notify_amb_guys_deleted");
  level.end_wreck_node maps\_anim::anim_single(self, "pt2_crash");
  level.end_wreck_node thread maps\_anim::anim_loop(self, "pt2_crash_loop", "stop_loop");
}

player_hurt_effects() {
  level.player.health = 100;
  level waittill("notify_player_hurt");
  level.player dodamage(level.player.health - 1, level.player.origin);
  var_0 = anglesToForward(level.player.angles);
  playFX(level._effect["deathfx_bloodpool_generic"], level.player.origin + var_0 * 24);
}

glass_crack_effects() {
  var_0 = getent("wreck_glass_crack_01", "targetname");
  var_0 hide();
  var_1 = getent("wreck_glass_crack_02", "targetname");
  var_1 hide();
  var_2 = getent("wreck_glass_crack_player", "targetname");
  var_2 hide();
  level waittill("glass_crack_01");
  var_0 show();
  thread player_glass_crack(var_2);
  level waittill("glass_crack_02");
  var_1 show();
}

player_glass_crack(var_0) {
  var_1 = getent("get_speedloader_trigger", "targetname");

  while(!level.player istouching(var_1))
    wait 0.01;

  var_0 show();
  level.player playSound("scn_sw_uw_plyr_glass");
}

part_2_crawl_player(var_0, var_1, var_2, var_3) {
  maps\_utility::remove_extra_autosave_check("fallen_cant_get_up");
  level.dopickyautosavechecks = 0;
  thread maps\_utility::autosave_by_name_silent("end_wreck");
  setsaveddvar("player_view_pitch_down", 10);
  level.player unlink();
  var_2 delete();
  level.ground_ref = getent("pt2_ground_ref", "targetname");
  level.player playersetgroundreferenceent(level.ground_ref);
  level.ground_ref thread part_2_aim_waver();
  level.player enableslowaim(0.2, 0.2);
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowstand(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player disableweapons(1);
  level.player setstance("prone");
  thread part_2_dynamic_crawl();
  level.player takeallweapons();
  setsaveddvar("g_friendlyfireDist", 0);
  thread part_2_draw_player(var_0, var_1, var_2, var_3);
}

part_2_dynamic_crawl() {
  level endon("flag_end_wreck_end");

  while(!common_scripts\utility::flag("shot_successful")) {
    thread update_crawl_speed(1);
    wait 2;
    thread update_crawl_speed(3);
    wait 0.5;
  }

  for(;;) {
    level.player maps\_utility::player_speed_percent(25, 1);
    wait 2;
    level.player maps\_utility::player_speed_percent(50, 0.25);
    wait 0.5;
  }
}

update_crawl_speed(var_0) {
  level notify("set_crawl_speed");
  level endon("set_crawl_speed");
  var_1 = getent("pt2_ground_ref", "targetname");

  for(;;) {
    var_2 = distance(level.player.origin, var_1.origin);
    var_3 = var_2 / 7;
    level.player maps\_utility::player_speed_percent(var_3 * var_0, 1);
    wait 0.1;
  }
}

part_2_crawl(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["ally1"] = var_0;
  var_5["gun"] = var_3;
  var_5["enemy"] = var_1;
  var_5["extinguisher"] = var_4;
  thread enemy_fires_gun(var_3);
  thread part_2_knife_logic(var_1);
  level.end_wreck_node maps\_anim::anim_single(var_5, "pt2_crawl");
  part_2_fight(var_0, var_1);
}

enemy_fires_gun(var_0) {
  level waittill("enemy_gun_fire");
  playFXOnTag(level._effect["magnum_flash"], var_0, "TAG_flash");
  var_1 = anglesToForward(var_0 gettagangles("TAG_flash"));
  var_2 = vectornormalize(var_1);
  var_3 = var_0 gettagorigin("TAG_Flash") + 1000 * var_2;
  magicbullet("coltanaconda_skyway", var_0 gettagorigin("TAG_Flash"), var_3, level.player);
  level.player playSound("sw_wreck_close_shot_1");
  level.player playSound("sw_wreck_close_shot_2");
  level notify("gun_available");
  wait 0.1;
  common_scripts\utility::exploder("sw_ricochet_1");
  wait 0.2;
  common_scripts\utility::exploder("sw_ricochet_2");
}

part_2_draw_player(var_0, var_1, var_2, var_3) {
  level waittill("gun_available");
  var_4 = getent("get_gun_trigger", "targetname");
  create_qte_prompt(&"SKYWAY_HINT_PICK_UP_GUN", "hud_icon_colt_anaconda", 1.5);
  thread trigger_qte_prompt_check(var_4);

  for(;;) {
    if(level.player usebuttonpressed() && level.player istouching(var_4)) {
      break;
    }

    wait 0.05;
  }

  var_4 common_scripts\utility::trigger_off();
  destroy_qte_prompt();
  var_3 delete();
  common_scripts\utility::flag_set("player_got_gun");
}

part_2_knife_logic(var_0) {
  level waittill("spawn_knife");
  var_0 attach("weapon_parabolic_knife", "tag_inhand");
  common_scripts\utility::flag_set("knife_attached");
  level waittill("flag_end_wreck_end");

  if(common_scripts\utility::flag("knife_attached"))
    var_0 detach("weapon_parabolic_knife", "tag_inhand");
}

detach_knife(var_0) {
  var_0 detach("weapon_parabolic_knife", "tag_inhand");
  common_scripts\utility::flag_clear("knife_attached");
  level.knife = spawn("script_model", var_0 gettagorigin("tag_inhand"));
  level.knife setModel("weapon_parabolic_knife");
  level.knife.angles = var_0 gettagangles("tag_inhand");
}

attach_knife(var_0) {
  var_0 attach("weapon_parabolic_knife", "tag_inhand");
  common_scripts\utility::flag_set("knife_attached");
  level.knife delete();
}

part_2_fight(var_0, var_1) {
  var_2 = [];
  var_2["ally1"] = var_0;
  var_2["enemy"] = var_1;
  level.end_wreck_node thread maps\_anim::anim_single(var_2, "pt2_fight");
  thread part_2_fight_timeout(9);
  common_scripts\utility::flag_wait("dry_fire");
  thread maps\skyway_audio::sfx_wreck_02();
  part_2_speedloader(var_0, var_1);
}

part_2_fight_timeout(var_0) {
  level endon("dry_fire");
  level endon("wet_fire");
  level endon("hesch_speedloader_vo");
  wait(var_0);
  level notify("failure");
  level._ally playSound("scn_sw_hesh_stabbed");
  wait 1;
  setdvar("ui_deadquote", &"SKYWAY_FAIL_ALLY_STABBED");
  maps\_utility::missionfailedwrapper();
}

part_2_speedloader(var_0, var_1) {
  level.speedloader = maps\_utility::spawn_anim_model("pt2_speedloader");
  level.player_rig_grab = maps\_utility::spawn_anim_model("player_rig");
  level.player_rig_grab hide();
  level.bullet_start = maps\_utility::spawn_anim_model("pt2_bullet_start");
  level.bullet_end = maps\_utility::spawn_anim_model("pt2_bullet_end");
  level.end_wreck_player_node = common_scripts\utility::spawn_tag_origin();
  level.end_wreck_player_node.angles = level.end_wreck_node.angles;
  level.end_wreck_player_node.origin = level.player.origin;
  level.player_rig_grab linkto(level.end_wreck_player_node);
  level.bullet_end linkto(level.end_wreck_player_node);
  level.bullet_blender = common_scripts\utility::spawn_tag_origin();
  level.bullet_blender linkto(level.bullet_start, "tag_helo", (0, 0, 0), (0, 0, 0));
  level.bullet_tumble = maps\_utility::spawn_anim_model("pt2_bullet_tumble");
  level.bullet_tumble linkto(level.bullet_blender, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.bullet_catch = maps\_utility::spawn_anim_model("pt2_bullet");
  level.bullet_catch linkto(level.bullet_tumble, "tag_helo", (0, 0, 0), (0, 0, 0));
  level.bullet_catch hide();
  thread qte_bullet_blender();
  thread qte_bullet_shine();
  var_2 = [];
  var_2["ally1"] = var_0;
  var_2["enemy"] = var_1;
  var_2["speedloader"] = level.speedloader;
  var_2["pt2_bullet_start"] = level.bullet_start;
  var_3 = getent("enemy_target", "targetname");
  var_3 linkto(var_1, "J_SpineUpper");
  thread part_2_shoot_chance(var_0, var_1);
  level.bullet_tumble setanim(level.scr_anim["pt2_bullet_tumble"]["pt2_speedloader"]);
  level.end_wreck_player_node thread maps\_anim::anim_single_solo(level.bullet_end, "pt2_speedloader");
  level.end_wreck_player_node thread maps\_anim::anim_single_solo(level.player_rig_grab, "pt2_speedloader");
  level.end_wreck_node maps\_anim::anim_single(var_2, "pt2_speedloader");
  level.end_wreck_node thread maps\_anim::anim_single_solo(level.speedloader, "pt2_load_gun");
}

part_2_shoot_chance(var_0, var_1) {
  var_2 = [];
  var_2["ally1"] = var_0;
  var_2["enemy"] = var_1;
  thread part_2_shoot_chance_timeout(var_2);
  level waittill("wet_fire");

  if(common_scripts\utility::flag("shot_successful")) {
    var_3 = common_scripts\utility::spawn_tag_origin();
    setslowmotion(1.0, 0.1, 0.25);
    level.end_wreck_node maps\_anim::anim_first_frame(var_2, "pt2_fire_win");
    var_3 = getent("rorke_blood_fx_source", "targetname");
    playFX(common_scripts\utility::getfx("blood_rorke"), var_3.origin, anglesToForward(var_3.angles));
    level.end_wreck_node thread maps\_anim::anim_single(var_2, "pt2_fire_win");
    thread maps\skyway_fx::fx_glass_cracks_01();
    thread part_2_help_ally(var_0, var_1);
    var_3 common_scripts\utility::delaycall(10, ::delete);
  } else {
    level waittill("gun_down");
    thread maps\skyway_fx::fx_hesh_neck_cut();

    if(!common_scripts\utility::flag("gun_loaded"))
      level notify("stop_reload");

    level.player thread maps\_anim::anim_single_solo(level.playerviewmodel, "pt2_fire_win");
    wait 3.2;
    level.playerviewmodel delete();
    setdvar("ui_deadquote", &"SKYWAY_FAIL_NO_SHOOT");
    maps\_utility::missionfailedwrapper();
  }
}

part_2_shoot_chance_timeout(var_0) {
  level endon("shot_successful");
  level common_scripts\utility::waittill_notify_or_timeout("wet_fire", 15);
  level.end_wreck_node thread maps\_anim::anim_single(var_0, "pt2_fire_fail");
  level waittill("too_late_now");
  level notify("wet_fire");
  common_scripts\utility::waitframe();
  level notify("gun_down");
}

part_2_aim_waver() {
  level endon("stop_waver");
  level endon("flag_end_wreck_end");
  self rotatepitch(-5, 1, 0.5, 0.5);
  wait 1;

  for(;;) {
    var_0 = randomfloatrange(1, 3);
    self rotatepitch(10, var_0, 0.5, 0.5);
    wait(var_0);
    var_0 = randomfloatrange(1, 3);
    self rotatepitch(-10, var_0, 0.5, 0.5);
    wait(var_0);
  }
}

part_2_help_ally(var_0, var_1) {
  wait 0.5;
  setslowmotion(0.1, 1, 1.5);
  thread maps\skyway_fx::fx_player_submerge_01();
  level waittill("player_swept");
  var_2 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  level.player playerlinktodelta(var_2, "tag_player", 0, 15, 15, 15, 15, 1);
  level.end_wreck_node maps\_anim::anim_single_solo(var_2, "pt2_help");
  var_2 delete();
  common_scripts\utility::flag_set("flag_end_wreck_end");
}

part_2_gun_fire(var_0) {
  level endon("gun_down");
  level endon("failure");
  maps\_friendlyfire::turnoff();
  level.player notifyonplayercommand("firing", "+attack");
  level.player notifyonplayercommand("firing", "+attack_akimbo_accessible");

  for(;;) {
    level.player waittill("firing");

    if(common_scripts\utility::flag("gun_loaded")) {
      var_1 = getent("enemy_target", "targetname");
      thread maps\skyway_audio::skyway_endshot_sfx();
      thread maps\skyway_audio::sfx_wreck_03();
      var_2 = anglesToForward(level.player getplayerangles());
      var_3 = vectornormalize(var_2);
      var_4 = level.player getEye() + 256 * var_3;
      var_5 = bulletTrace(level.player getEye(), var_4, 0, level.player);

      if(isDefined(var_5["entity"]) && var_5["entity"] == var_1) {
        common_scripts\utility::flag_set("shot_successful");
        var_4 = var_1.origin;
      }

      level notify("wet_fire");

      if(common_scripts\utility::flag("shot_successful")) {
        thread pt2_successful_shot();
        common_scripts\utility::flag_clear("gun_loaded");
      } else {
        level notify("player_missed");
        var_2 = anglesToForward(level.playerviewmodel gettagangles("tag_flash"));
        var_3 = vectornormalize(var_2);
        var_4 = level.playerviewmodel gettagorigin("tag_flash") + 1000 * var_3;
        level.player playrumbleonentity("damage_heavy");
        playFXOnTag(common_scripts\utility::getfx("magnum_flash"), level.playerviewmodel, "tag_flash");
        level.player playSound("weap_mag44_fire_plr");
        magicbullet("coltanaconda_skyway", level.playerviewmodel gettagorigin("TAG_Flash"), var_4, level.player);
        level.player maps\_anim::anim_single_solo(level.playerviewmodel, "pt2_fire_hit");
        level notify("gun_down");
      }
    } else {
      level.player playSound("skyway_dryfire_pistol_plr");
      level.player playrumbleonentity("damage_light");
      level.playerviewmodel setanimrestart(level.scr_anim["player_rig_magnum"]["pt2_fire_empty"]);

      if(!common_scripts\utility::flag("dry_fire"))
        thread part_2_gun_reload();

      common_scripts\utility::flag_set("dry_fire");
      wait 0.3;
    }

    wait 0.1;
  }
}

pt2_successful_shot() {
  var_0 = level.player common_scripts\utility::spawn_tag_origin();
  var_1 = level._boss gettagorigin("j_spineupper") - level.player getEye();
  var_0.angles = vectortoangles(var_1);
  level.player playerlinktoblend(var_0, "tag_origin", 0.05);
  wait 0.05;
  level.player playrumbleonentity("damage_heavy");
  playFXOnTag(common_scripts\utility::getfx("magnum_flash"), level.playerviewmodel, "tag_flash");
  level.player playSound("weap_mag44_fire_plr");
  level.playerviewmodel unlinkfromplayerview(level.player);
  level.playerviewmodel linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  level.player forceviewmodelanimation("coltanaconda_skyway", "reload");
  level.player maps\_anim::anim_single_solo(level.playerviewmodel, "pt2_fire_hit");
  level.player unlink();
  var_0 delete();
  level notify("gun_down");
  level.player maps\_anim::anim_single_solo(level.playerviewmodel, "pt2_fire_win");
  level.player takeallweapons();
  level.playerviewmodel delete();
}

part_2_gun_reload() {
  level endon("stop_reload");
  level waittill("hesch_speedloader_vo");
  event_qte_bullet_catch();
  level.player notifyonplayercommand("reload", "+usereload");
  level.player notifyonplayercommand("reload", "+reload");
  destroy_qte_prompt();
  level.player notify("stop_loop");
  level notify("gun_down");
  level.player unlink();
  level.player playerlinktodelta(level.player_rig_grab, "tag_player", 1, 90, 90, 40, 40, 1);
  level.playerviewmodel attach("weapon_bullet_iw5", "tag_knife_attach");
  level.player playSound("scn_skyway_uw_reload");
  level.player maps\_anim::anim_single_solo(level.playerviewmodel, "pt2_load_gun");
  level.playerviewmodel detach("weapon_bullet_iw5", "tag_knife_attach");
  level.player unlink();
  level.player_rig_grab delete();
  common_scripts\utility::flag_set("gun_loaded");
  level.player thread maps\_anim::anim_loop_solo(level.playerviewmodel, "pt2_aim_loop_cocked", "stop_loop");
  thread part_2_gun_fire();
}

pt2_force_look_down() {
  if(level.player maps\_utility::player_looking_at(level.ground_ref.origin)) {
    level notify("stop_waver");
    setsaveddvar("player_view_pitch_down", 40);
    level.ground_ref rotateroll(-20, 0.5, 0.1, 0.1);
    wait 1;
    level.ground_ref rotateroll(20, 2, 1.5, 0.1);
    wait 2;
    level.ground_ref thread part_2_aim_waver();
  }
}

fade_in_from_black() {
  wait 1;
  setblur(10.3, 0.1);
  wait 3;
  setblur(8, 0.5);

  if(isDefined(level.black_overlay)) {
    level.black_overlay fadeovertime(0.5);
    level.black_overlay.alpha = 0.5;
    wait 0.5;
    level.black_overlay fadeovertime(1);
    level.black_overlay.alpha = 1;
    wait 1;
  }

  setblur(8, 0.5);

  if(isDefined(level.black_overlay)) {
    level.black_overlay fadeovertime(0.5);
    level.black_overlay.alpha = 0.25;
    wait 0.5;
    level.black_overlay fadeovertime(1);
    level.black_overlay.alpha = 1;
    wait 1;
  }

  setblur(8, 0.5);
  level waittill("notify_fade_in");

  if(isDefined(level.black_overlay)) {
    level.black_overlay fadeovertime(4.0);
    level.black_overlay.alpha = 0;
  }

  setblur(0, 10);
}

trigger_qte_prompt_check(var_0) {
  level endon("stop_blink");

  while(!level.player istouching(var_0))
    wait 0.05;

  fade_qte_prompt(0.05, 1);

  while(level.player istouching(var_0))
    wait 0.05;

  fade_qte_prompt(0.05, 0);
  wait 0.05;
  trigger_qte_prompt_check(var_0);
}

event_qte_bullet_catch() {
  level waittill("notify_slomo_start");
  var_0 = maps\_utility::get_dot(level.player.origin, level.player.angles, level._ally.origin);

  if(var_0 < 0.6)
    common_scripts\utility::flag_wait("flag_qte_end");
  else {
    thread qte_bullet_catch_slomo();
    thread qte_bullet_catch_dof();
    thread link_player_for_catch();
    level waittill("notify_qte_start");
    var_1 = 0.65;
    thread prompt_qte_grow(var_1);

    for(;;) {
      if(level.player usebuttonpressed()) {
        level notify("notify_kill_prompt");
        thread fade_qte_prompt(0.1, 0);
        common_scripts\utility::flag_wait("flag_qte_end");
        level.end_wreck_player_node thread maps\_anim::anim_single_solo(level.player_rig_grab, "pt2_speedloader2");
        wait 0.05;
        killfxontag(common_scripts\utility::getfx("bullet_shine"), level.bullet_blender, "tag_origin");
        level.bullet_catch delete();
        level.bullet_blender delete();
        level.bullet_start delete();
        level.bullet_end delete();
        level.bullet_tumble delete();
        level.player playrumbleonentity("damage_light");
        wait 0.4;
        level notify("notify_end_slomo");
        wait 0.3;
        return;
      }

      if(common_scripts\utility::flag("flag_qte_end")) {
        break;
      }

      wait(level.timestep);
    }
  }

  common_scripts\utility::flag_set("flag_qte_fail");
  thread speedloader_fail();
  level notify("notify_kill_prompt");
  level notify("notify_end_slomo");
  thread fade_qte_prompt(0.05, 0.0);
  wait 2.25;
  setdvar("ui_deadquote", &"SKYWAY_FAIL_NO_GRAB");
  maps\_utility::missionfailedwrapper();
  wait 5.0;
}

speedloader_fail() {
  var_0 = level._ally;
  var_0 maps\_utility::gun_remove();
  var_1 = level._boss;
  var_1 maps\_utility::gun_remove();
  var_2 = [];
  var_2["ally1"] = var_0;
  var_2["enemy"] = var_1;
  level.end_wreck_node maps\_anim::anim_single(var_2, "pt2_speedloader_fail");
}

link_player_for_catch() {
  var_0 = 0.3;
  level.end_wreck_player_node.origin = level.player.origin;
  wait(level.timestep);
  level.player_rig_grab show();
  level.player playerlinktoblend(level.player_rig_grab, "tag_player", var_0);
}

unlink_player_after_catch(var_0) {
  wait(var_0);
  level.player unlink();
}

qte_bullet_blender() {
  level waittill("notify_start_bullet_blend");
  level.bullet_blender maps\skyway_util::blend_link_over_time(level.bullet_start, level.bullet_end, 0.6, undefined, "tag_helo", "tag_helo");
}

qte_bullet_shine() {
  level waittill("notify_start_bullet_blend");
  level.bullet_catch show();
  playFXOnTag(common_scripts\utility::getfx("bullet_shine"), level.bullet_blender, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("bullet_shine_lesser"), level.speedloader, "pCylinder1");
  playFXOnTag(common_scripts\utility::getfx("bullet_shine_lesser"), level.speedloader, "pCylinder2");
  wait(level.timestep);
  playFXOnTag(common_scripts\utility::getfx("bullet_shine_lesser"), level.speedloader, "pCylinder3");
  playFXOnTag(common_scripts\utility::getfx("bullet_shine_lesser"), level.speedloader, "pCylinder4");
  wait(level.timestep);
  playFXOnTag(common_scripts\utility::getfx("bullet_shine_lesser"), level.speedloader, "pCylinder5");
  playFXOnTag(common_scripts\utility::getfx("bullet_shine_lesser"), level.speedloader, "pCylinder6");
}

qte_bullet_catch_dof() {
  var_0 = 10;
  var_1 = 65;
  thread maps\_art::dof_enable_script(0, 5.0, 4, 10.28, 174, 4, 0.5);
  level.player enableforceviewmodeldof();
  thread qte_bullet_catch_blend_view_dof(0, var_0, 0, var_1, 0.5);
  wait 0.7;
  thread qte_bullet_catch_blend_view_dof(var_0, 0, var_1, 0, 0.5);
  level.player disableforceviewmodeldof();
  thread maps\_art::dof_disable_script(0.5);
}

qte_bullet_catch_blend_view_dof(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4;

  while(var_5 > 0) {
    var_6 = 1 - maps\skyway_util::normalize_value(0, var_4, var_5);
    var_7 = maps\skyway_util::factor_value_min_max(var_0, var_1, var_6);
    var_8 = maps\skyway_util::factor_value_min_max(var_2, var_3, var_6);
    level.player setviewmodeldepthoffield(var_7, var_8);
    var_5 = var_5 - level.timestep;
    wait(level.timestep);
  }

  level.player setviewmodeldepthoffield(var_1, var_3);
}

qte_bullet_catch_slomo() {
  var_0 = getdvarint("cg_fov");
  maps\_utility::slowmo_setspeed_slow(0.25);
  maps\_utility::slowmo_setlerptime_in(0.25);
  maps\_utility::slowmo_lerp_in();
  level.player playSound("sw_wreck_slomo_in_1");
  level.player thread maps\_utility::lerp_fov_overtime(0.8, var_0 * 0.85);
  level.player setmovespeedscale(0.2);
  level waittill("notify_end_slomo");
  wait 0.15;

  if(common_scripts\utility::flag("flag_qte_fail")) {
    level.player playSound("sw_wreck_slomo_out_2");
    maps\_utility::slowmo_setspeed_slow(1.0);
    maps\_utility::slowmo_setlerptime_in(2.0);
    maps\_utility::slowmo_lerp_in();
  } else {
    maps\_utility::slowmo_setspeed_slow(1.0);
    maps\_utility::slowmo_setlerptime_in(6.0);
    maps\_utility::slowmo_lerp_in();
  }

  level.player thread maps\_utility::lerp_fov_overtime(0.6, var_0);
  level.player setmovespeedscale(1.0);
}

create_qte_prompt(var_0, var_1, var_2, var_3) {
  var_4 = -3;

  if(!isDefined(var_3))
    var_3 = 70;

  var_5 = var_2;
  var_6 = 3;
  var_7 = 95;
  var_8 = [];
  var_9 = level.player maps\_hud_util::createclientfontstring("default", var_5);
  var_9.x = var_4 * -1;
  var_9.y = var_3;
  var_9.horzalign = "right";
  var_9.alignx = "right";
  var_9.alignx = "center";
  var_9.aligny = "middle";
  var_9.horzalign = "center";
  var_9.vertalign = "middle";
  var_9.hidewhendead = 1;
  var_9.hidewheninmenu = 1;
  var_9.sort = 205;
  var_9.foreground = 1;
  var_9.alpha = 0;
  var_9 settext(var_0);
  var_8["text"] = var_9;

  if(isDefined(var_1)) {
    var_10 = maps\_hud_util::createicon(var_1, 40, 40);
    var_10.x = var_6;
    var_10.y = var_7;
    var_10.alignx = "center";
    var_10.aligny = "middle";
    var_10.horzalign = "center";
    var_10.vertalign = "middle";
    var_10.hidewhendead = 1;
    var_10.hidewheninmenu = 1;
    var_10.sort = 205;
    var_10.foreground = 1;
    var_10.alpha = 0;
    var_8["icon"] = var_10;
  }

  level.qte_prompt = var_8;
}

prompt_qte_grow(var_0) {
  level endon("notify_kill_prompt");
  thread prompt_qte_pulse();
  var_1 = 5.0;
  create_qte_prompt(&"SKYWAY_HINT_RELOAD", undefined, var_1, 10);
  var_2 = 1.5;
  var_3 = var_0;

  foreach(var_5 in level.qte_prompt) {
    var_5 changefontscaleovertime(var_3);
    var_5.fontscale = var_2;
  }

  wait(var_3);
}

prompt_qte_pulse() {
  level endon("notify_kill_prompt");
  var_0 = 0.05;
  level.player playSound("sw_wreck_hint_appear");

  for(;;) {
    thread fade_qte_prompt(var_0, 0.7);
    wait(var_0);
    thread fade_qte_prompt(var_0, 0.3);
    wait(var_0);
  }
}

fade_qte_prompt(var_0, var_1) {
  if(!isDefined(level.qte_prompt)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 1.5;

  foreach(var_3 in level.qte_prompt) {
    var_3 fadeovertime(var_0);
    var_3.alpha = var_1;
  }

  if(var_1 > 0.75) {
    wait(var_0);
    common_scripts\utility::flag_set("qte_prompt_solid");
  } else {
    wait(var_0);
    common_scripts\utility::flag_clear("qte_prompt_solid");
  }
}

destroy_qte_prompt() {
  if(!isDefined(level.qte_prompt)) {}

  level notify("stop_blink");

  foreach(var_1 in level.qte_prompt)
  var_1 destroy();

  level.qte_prompt = undefined;
}

cleanup_delayed() {
  wait 6;
  level.speedloader delete();
}