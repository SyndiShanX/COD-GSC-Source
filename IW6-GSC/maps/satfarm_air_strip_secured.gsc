/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_air_strip_secured.gsc
**********************************************/

air_strip_secured_init() {
  level.start_point = "air_strip_secured";
  setdvar("debug_sat_view_pip", "1");
  objective_add(maps\_utility::obj("rendesvouz"), "invisible", &"SATFARM_OBJ_RENDESVOUZ");
  objective_state_nomessage(maps\_utility::obj("rendesvouz"), "done");
  objective_add(maps\_utility::obj("reach_air_strip"), "invisible", &"SATFARM_OBJ_REACH_AIR_STRIP");
  objective_state_nomessage(maps\_utility::obj("reach_air_strip"), "done");
  objective_add(maps\_utility::obj("air_strip_defenses"), "invisible", &"SATFARM_OBJ_DESTROY_AIR_STRIP_DEFENSES");
  objective_state_nomessage(maps\_utility::obj("air_strip_defenses"), "done");
  maps\satfarm_code::kill_spawners_per_checkpoint("air_strip_secured");
}

air_strip_secured_main() {
  if(level.start_point == "air_strip_secured") {
    maps\satfarm_code::spawn_player_checkpoint("air_strip_secured");
  }

  maps\satfarm_code::kill_spawners_per_checkpoint("air_strip_secured");
  level.start_point = "air_strip_secured";
  maps\satfarm_code::spawn_allies();

  if(!isDefined(level.playertank)) {} else {}

  thread air_strip_secured_begin();
  common_scripts\utility::flag_wait("air_strip_secured_end");
}

air_strip_secured_begin() {
  var_0 = getaiarray("axis");
  thread maps\_utility::ai_delete_when_out_of_sight(var_0, 2048);
  var_1 = maps\_utility::getvehiclearray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_team) && var_3.script_team == "axis") {
      var_3 thread maps\satfarm_code::enemytank_cleanup();
    }
  }

  if(isDefined(level.air_strip_m880s) && level.air_strip_m880s.size > 0) {
    foreach(var_6 in level.air_strip_m880s) {
      if(isDefined(var_6)) {
        var_6 delete();
      }
    }
  }

  if(isDefined(level.air_strip_m880_corpses) && level.air_strip_m880_corpses.size > 0) {
    foreach(var_9 in level.air_strip_m880_corpses) {
      if(isDefined(var_9)) {
        var_9 delete();
      }
    }
  }

  var_11 = getent("hangar_door_breakable", "targetname");

  if(isDefined(var_11)) {
    var_11 delete();
  }

  thread air_strip_victory();
  maps\_utility::autosave_by_name("air_strip_secured");
}

air_strip_victory() {
  var_0 = common_scripts\utility::getstructarray("green_smoke_structs", "targetname");

  foreach(var_2 in var_0) {
    if(level.start_point != "air_strip_secured") {
      wait(randomfloatrange(0.1, 2.0));
    }

    playFX(level._effect["signal_smoke_green"], var_2.origin);
  }

  if(level.start_point != "air_strip_secured") {
    wait 1.0;
  }

  wait 1.0;
  level.player thread air_strip_to_chopper();
}

victory_choppers_land(var_0) {
  var_1 = maps\_vehicle::vehicle_get_riders_by_group("passengers");
  self waittill("unloaded");
  common_scripts\utility::array_thread(var_1, maps\satfarm_code::send_to_volume_and_delete, var_0);
  common_scripts\utility::flag_wait("player_landed");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 delete();
    }
  }

  if(isDefined(self)) {
    self delete();
  }
}

ally_chopper_unload() {
  common_scripts\utility::flag_wait("enable_ghost2_rappel");
  level.ally_littlebird_1 thread littlebird_hover();
  common_scripts\utility::flag_wait("enable_player_rappel");
  common_scripts\utility::flag_wait("player_landed");
  wait 1;
  common_scripts\utility::flag_set("ghost2_landed");
  var_0 = getent("control_room_balcony_clip", "targetname");
  var_0 notsolid();
  var_0 connectpaths();
  common_scripts\utility::flag_wait("ghost2_littlebird_path_end");
  level.ally_littlebird_1 delete();
}

littlebird_hover() {
  self setgoalyaw(self.angles[1]);
  self settargetyaw(self.angles[1]);
  self sethoverparams(0, 0, 0);
  self setmaxpitchroll(0, 0);
  self setvehgoalpos(self.origin, 1);
  self vehicle_setspeedimmediate(0);
  self vehicle_teleport(self.origin, self.angles);
}

air_strip_to_chopper() {
  common_scripts\utility::flag_set("air_strip_secured_begin");

  if(isDefined(level.hintelement)) {
    level.hintelement maps\_hud_util::destroyelem();
  }

  setsaveddvar("cg_cinematicFullScreen", "1");
  setsaveddvar("cg_cinematicCanPause", "1");
  cinematicingame("satfarm_transition_ghost");

  while(cinematicgetframe() <= 1) {
    common_scripts\utility::waitframe();
  }

  level.cinematic_started = 1;

  if(isDefined(level.playertank)) {
    level.playertank maps\satfarm_code::dismount_tank(level.player, 0, undefined, undefined, 1);

    if(isDefined(level.playertank)) {
      level.playertank hide();
      level.playertank setcontents(0);
    }
  }

  level thread maps\satfarm_audio::overlord_trans1();
  level.player freezecontrols(1);
  level.player hideviewmodel();
  level.player enableinvulnerability();
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  level.player.ignoreme = 1;
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("compass", 0);
  setsaveddvar("hud_showStance", 0);
  thread sat_view_ally_and_enemy_tanks();
  thread sat_view_spawn_ally_choppers();
  level.cinematic_over = undefined;

  while(iscinematicplaying()) {
    level.bink_current_time = cinematicgettimeinmsec();
    level.bink_percentage = level.bink_current_time / 16000;

    if(level.bink_percentage >= 0.45) {
      if(!common_scripts\utility::flag("spawn_sat_view_ally_choppers")) {
        common_scripts\utility::flag_set("spawn_sat_view_ally_choppers");
      }
    }

    wait 0.05;
  }

  level.cinematic_over = 1;
  level.player showviewmodel();
  level.player.ignoreme = 0;
  setsaveddvar("cg_fov", 65);
  setsaveddvar("cg_cinematicCanPause", "0");
  thread switch_to_ghost_intro_screen();
  thread maps\_utility::autosave_by_name("chopper_ride_in");
  common_scripts\utility::flag_set("chopper_flyin_begin");
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_helicopter", 0.5);
  level.player_chopper_anim_struct = common_scripts\utility::getstruct("player_chopper_anim_struct", "targetname");
  maps\_utility::array_spawn_function_targetname("air_strip_secured_ambient_enemies_wave_1", ::air_strip_secured_ambient_enemies_setup);
  level.air_strip_secured_ambient_enemies_wave_1 = maps\_utility::array_spawn_targetname("air_strip_secured_ambient_enemies_wave_1", 1);
  var_0 = getent("air_strip_secured_ac_unit_damage_brush", "targetname");
  var_0 setCanDamage(1);
  var_1 = common_scripts\utility::getstructarray("air_strip_secured_ac_unit_damage_struct", "targetname");
  var_0 thread watch_damage_to_rooftop_destructibles(var_1, 250, "air_strip_secured_ambient_enemies_volume_3");
  var_2 = getent("air_strip_secured_gas_tank_damage_brush", "targetname");
  var_2 setCanDamage(1);
  var_3 = common_scripts\utility::getstructarray("air_strip_secured_gas_tank_damage_struct", "targetname");
  var_2 thread watch_damage_to_rooftop_destructibles(var_3, 300, "air_strip_secured_ambient_enemies_volume_1");
  thread chopper_drive_in_vo();
  thread control_room_combat();
  common_scripts\utility::flag_wait("start_first_rpg");
  var_4 = common_scripts\utility::getstruct("first_rpg_magicbullet_start", "targetname");
  var_5 = common_scripts\utility::getstruct("first_rpg_magicbullet_end", "targetname");
  magicbullet("rpg_straight", var_4.origin, var_5.origin);
  common_scripts\utility::flag_wait("start_rpg");
  var_4 = common_scripts\utility::getstruct("rpg_magicbullet1_start", "targetname");
  var_5 = common_scripts\utility::getstruct("rpg_magicbullet1_end", "targetname");
  magicbullet("rpg_straight", var_4.origin, var_5.origin);
  wait 0.5;
  var_4 = common_scripts\utility::getstruct("rpg_magicbullet2_start", "targetname");
  var_5 = common_scripts\utility::getstruct("rpg_magicbullet2_end", "targetname");
  magicbullet("rpg_straight", var_4.origin, var_5.origin);
  common_scripts\utility::flag_wait("enable_player_rappel");
  level.player_littlebird thread littlebird_hover();
  wait 1.5;
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_hsh_jumpadam");
  wait 0.5;
  thread maps\_utility::display_hint("HINT_JUMP");
  thread player_is_ignored();
  thread player_jump_to_tower();
  common_scripts\utility::flag_wait("player_landed");

  if(isDefined(level.player_littlebird)) {
    level.player_littlebird delete();
  }

  thread allies_move_up_in_control_room();
  common_scripts\utility::flag_wait("control_room_enemies_dead");
  level.player disableinvulnerability();
  common_scripts\utility::flag_set("air_strip_secured_end");
}

switch_to_ghost_intro_screen() {
  level.introscreen.lines = [];
  level.introscreen.lines[0] = "";
  level.introscreen.lines[1] = &"SATFARM_INTROSCREEN_GHOST_LINE_2";
  level.introscreen.lines[2] = &"SATFARM_INTROSCREEN_GHOST_LINE_3";
  level.introscreen.lines[3] = &"SATFARM_INTROSCREEN_GHOST_LINE_4";
  maps\_introscreen::introscreen(1);
}

player_chopper_flyin_setup() {
  if(isDefined(level.ps3)) {
    setsaveddvar("r_znear", 10);
  }

  level.player playerlinktodelta(level.player_littlebird, "tag_player1", 1, 80, 80, 7, 40, 1);
  var_0 = level.player_littlebird.mgturret[0];
  level.player setplayerangles((0, -90, 0));
  level.player_littlebird hidepart("side_door_l_jnt");
  var_0 makeusable();
  var_0 useby(level.player);
  var_0 makeunusable();
  level.player disableturretdismount();
  thread maps\_minigun_viewmodel::player_viewhands_minigun(var_0, "viewhands_player_gs_stealth");
  var_0 thread maps\_minigun_viewmodel::show_hands("viewhands_player_gs_stealth");
  level.friendlyfire_enable_attacker_owner_check = 1;
  var_0.owner = level.player;
  level.player freezecontrols(1);

  while(!isDefined(level.cinematic_over)) {
    wait 0.05;
  }

  wait 1;
  level.player freezecontrols(0);
}

watch_damage_to_rooftop_destructibles(var_0, var_1, var_2) {
  self waittill("damage");

  foreach(var_4 in var_0) {
    radiusdamage(var_4.origin, var_1, 500, 350);
    thread common_scripts\utility::play_sound_in_space("satf_tank_death_player", self.origin);
  }

  foreach(var_7 in level.air_strip_secured_ambient_enemies_wave_1) {
    if(isalive(var_7)) {
      if(var_7.target == var_2) {
        var_7 kill();
      }
    }
  }
}

air_strip_secured_ambient_enemies_setup() {
  self endon("death");
  self.base_accuracy = 0.01;
  self.accuracy = 0.01;
  self.health = 5;
  self.favoriteenemy = level.player;
  common_scripts\utility::flag_wait("start_control_room_combat");
  self kill();
}

player_is_ignored() {
  wait 2;

  if(!common_scripts\utility::flag("start_jump")) {
    level.player.ignoreme = 0;
  }
}

player_jump_to_tower() {
  thread player_jump_check();
  thread player_move_left_stick_check();
  var_0 = maps\_utility::spawn_anim_model("player_arms");
  var_0 hide();
  level.player_chopper_anim_struct maps\_anim::anim_first_frame_solo(var_0, "satfarm_control_tower_player");
  var_1 = maps\_utility::spawn_anim_model("chopper_turret");
  var_1 hide();
  level.player_chopper_anim_struct maps\_anim::anim_first_frame_solo(var_1, "satfarm_control_tower_turret");
  common_scripts\utility::flag_wait("start_jump");
  level thread maps\satfarm_audio::tower_jump();
  level.player.ignoreme = 1;
  level.player playerlinktoblend(var_0, "tag_player", 0.5);
  wait 0.5;

  if(isDefined(level.ps3)) {
    setsaveddvar("r_znear", 4);
  }

  level.player enableturretdismount();
  level.player_littlebird.mgturret[0] maketurretinoperable();
  level.player_littlebird.mgturret[0] setturretdismountorg(var_0 gettagorigin("tag_player"));
  level.player_littlebird.mgturret[0] useby(self);
  level.player_littlebird.mgturret[0] turretfiredisable();
  level.player_littlebird.mgturret[0] hide();
  level.friendlyfire_enable_attacker_owner_check = undefined;
  var_1 show();
  level.player playerlinktoblend(var_0, "tag_player", 0.25);
  level.player playerlinktoabsolute(var_0, "tag_player");
  var_0 show();
  level.player_chopper_anim_struct thread maps\_anim::anim_single_solo(var_1, "satfarm_control_tower_turret");
  level.player_chopper_anim_struct thread maps\_anim::anim_single_solo(var_0, "satfarm_control_tower_player");
  var_0 waittillmatch("single anim", "glass_break");
  var_2 = getglass("player_window");

  if(!isglassdestroyed(var_2)) {
    destroyglass(var_2);
  }

  wait 0.5;
  level.player playrumbleonentity("damage_light");
  wait 1.5;
  level.player enableweapons();
  level.player enableoffhandweapons();
  var_0 waittillmatch("single anim", "end");
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowsprint(1);
  level.player allowjump(1);
  level.player unlink();
  var_0 delete();
  var_1 delete();
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("actionSlotsHide", "0");
  setsaveddvar("compass", 1);
  setsaveddvar("hud_showStance", 1);
  common_scripts\utility::flag_set("player_landed");
  maps\_utility::autosave_by_name("jump_to_tower");
  level.player.ignoreme = 0;
  thread maps\satfarm_tower::breach_setup();
  wait 1;
  level.player disableinvulnerability();
}

player_jump_check() {
  level endon("start_jump");
  notifyoncommand("playerjump", "+gostand");
  notifyoncommand("playerjump", "+moveup");
  level.player waittill("playerjump");
  common_scripts\utility::flag_set("start_jump");
}

player_move_left_stick_check() {
  level endon("start_jump");

  for(;;) {
    var_0 = level.player getnormalizedmovement();

    if(var_0[0] > 0) {
      common_scripts\utility::flag_set("start_jump");
      break;
    }

    wait 0.05;
  }
}

timer_on_player_jump() {
  level endon("start_jump");
  wait 20;
  common_scripts\utility::flag_set("start_jump");
}

allies_move_up_in_control_room() {
  common_scripts\utility::flag_wait_either("player_has_left_control_room_balcony", "control_room_three_left");

  if(common_scripts\utility::flag("control_room_three_left") && !common_scripts\utility::flag("player_landed")) {
    common_scripts\utility::flag_wait("player_has_left_control_room_balcony");
  }

  maps\_utility::activate_trigger_with_targetname("move_allies_to_control_room_2");
}

hint_jump_off() {
  return common_scripts\utility::flag("start_jump");
}

air_strip_secured_vo() {
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_overlordairstripissecure");
  wait 0.5;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_solidcopybadgeroneone");
  wait 0.5;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_cu3_supportontheway");
  wait 0.5;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_highvalueacquisition");
}

chopper_drive_in_vo() {
  wait 1.5;
  common_scripts\utility::flag_wait("start_control_room_combat");
  maps\_utility::autosave_by_name("chopper_ride_in_2");
  objective_add(maps\_utility::obj("launch_missile"), "current", &"SATFARM_OBJ_LAUNCH_MISSILE");
  wait 1;
  common_scripts\utility::flag_set("ghost1_start_firing");
  thread maps\_utility::set_team_bcvoice("allies", "taskforce");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::flavorbursts_on("allies");
  level.player thread maps\_utility::vision_set_fog_changes("satfarm_helicopter_b", 1);
}

control_room_combat() {
  wait 0.5;
  maps\_utility::battlechatter_on("axis");
  maps\_utility::array_spawn_function_targetname("control_room_enemies", ::control_room_enemy_setup);
  level.control_room_enemies = maps\_utility::array_spawn_targetname("control_room_enemies", 1);
  wait 0.1;
  thread control_room_threatbiasgroup(level.control_room_enemies);
  thread maps\satfarm_code::ai_array_killcount_flag_set(level.control_room_enemies, 5, "spawn_control_room_enemies_wave_2");
  thread spawn_in_wave_2();
  common_scripts\utility::flag_wait("enable_player_rappel");
  maps\_utility::array_spawn_function_targetname("control_room_enemies_upper", ::control_room_enemies_upper_setup);
  var_0 = maps\_utility::array_spawn_targetname("control_room_enemies_upper", 1);
  common_scripts\utility::flag_wait("player_landed");
  thread maps\satfarm_tower::ambient_building_explosions("breach_start");

  while(level.control_room_enemies.size > 4) {
    level.control_room_enemies = maps\_utility::array_removedead_or_dying(level.control_room_enemies);
    wait 0.05;
  }

  var_1 = getent("control_room_back_volume", "targetname");

  if(!level.player istouching(var_1)) {
    var_2 = maps\_utility::array_spawn_targetname("control_room_enemies_wave_3", 1);
    level.control_room_enemies = common_scripts\utility::array_combine(level.control_room_enemies, var_2);
  }

  while(level.control_room_enemies.size > 3) {
    level.control_room_enemies = maps\_utility::array_removedead_or_dying(level.control_room_enemies);
    wait 0.05;
  }

  common_scripts\utility::flag_set("control_room_three_left");
  level.control_room_enemies = maps\_utility::array_removedead_or_dying(level.control_room_enemies);
  var_1 = getent("control_room_lower_volume", "targetname");

  foreach(var_4 in level.control_room_enemies) {
    var_4 maps\_utility::set_fixednode_false();
    var_4 cleargoalvolume();
    var_4.health = 50;
    var_4 setgoalvolumeauto(var_1);
  }

  thread maps\satfarm_code::cleanup_enemies("start_loading_bay_runners", level.control_room_enemies);
  maps\_utility::waittill_dead_or_dying(level.control_room_enemies);
  common_scripts\utility::flag_set("control_room_enemies_dead");
}

spawn_in_wave_2() {
  common_scripts\utility::flag_wait("spawn_control_room_enemies_wave_2");
  maps\_utility::array_spawn_function_targetname("control_room_enemies_wave_2", ::control_room_enemy_wave_2_setup);
  var_0 = maps\_utility::array_spawn_targetname("control_room_enemies_wave_2", 1);
  level.control_room_enemies = common_scripts\utility::array_combine(level.control_room_enemies, var_0);
}

control_room_threatbiasgroup(var_0) {
  createthreatbiasgroup("ignore_group");
  createthreatbiasgroup("control_room");
  level.player setthreatbiasgroup("ignore_group");
  level.allies[0] setthreatbiasgroup("ignore_group");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 setthreatbiasgroup("control_room");
    }
  }

  setignoremegroup("ignore_group", "control_room");
  common_scripts\utility::flag_wait("enable_player_rappel");
  level.player setthreatbiasgroup();
  level.allies[0] setthreatbiasgroup();
  createthreatbiasgroup("new_group");
  level.player setthreatbiasgroup("new_group");
  level.allies[0] setthreatbiasgroup("new_group");
  setthreatbias("new_group", "control_room", 200);
}

control_room_enemy_setup() {
  self endon("death");
  self.health = 50;
  self.ignoreme = 1;
  common_scripts\utility::flag_wait("start_control_room_combat");
  wait 1;
  self.ignoreme = 0;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "rooftop_rpgs") {
    self.ignoreme = 1;
    self.ignoreall = 1;
    common_scripts\utility::flag_wait("start_rpg");
    self.health = 5;
    self.ignoreall = 0;
    common_scripts\utility::flag_wait("start_control_room_combat");
    wait(randomfloatrange(0.3, 1.0));
    var_0 = common_scripts\utility::getstruct("rooftop_rpg_magicbullet_start", "targetname");
    var_1 = self gettagorigin("j_head");
    magicbullet(level.tower_redshirt.weapon, var_0.origin, var_1);
    wait 0.3;
    magicbullet(level.tower_redshirt.weapon, var_0.origin, var_1);
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "control_room_runner_1") {
    maps\_utility::magic_bullet_shield();
    common_scripts\utility::flag_wait("control_room_runner_1");
    maps\_utility::stop_magic_bullet_shield();
    self.ignoreall = 1;
    maps\_utility::set_fixednode_false();
    var_2 = getent("control_room_lower_volume", "targetname");
    self setgoalvolumeauto(var_2);
    self waittill("goal");
    self.ignoreall = 0;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "control_room_runner_2") {
    self.ignoreme = 1;
    common_scripts\utility::flag_wait("control_room_runner_2");
    self.ignoreme = 0;
    self.ignoreall = 1;
    maps\_utility::set_fixednode_false();
    var_2 = getent("control_room_lower_volume", "targetname");
    self setgoalvolumeauto(var_2);
    self waittill("goal");
    self.ignoreall = 0;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "control_room_runner_3") {
    maps\_utility::magic_bullet_shield();
    common_scripts\utility::flag_wait("control_room_runner_1");
    maps\_utility::stop_magic_bullet_shield();
    common_scripts\utility::flag_wait("control_room_runner_2");
    wait 1.25;
    self.ignoreall = 1;
    maps\_utility::set_fixednode_false();
    var_2 = getent("control_room_lower_volume", "targetname");
    self setgoalvolumeauto(var_2);
    self waittill("goal");
    self.ignoreall = 0;
  }

  common_scripts\utility::flag_wait("player_landed");
  var_2 = getent("control_room_upper_volume", "targetname");

  if(self istouching(var_2)) {
    wait(randomfloatrange(0.3, 1.5));
    self kill();
  }
}

control_room_enemy_wave_2_setup() {
  self endon("death");

  if(self.target == "control_room_lower_front_volume") {
    maps\_utility::set_fixednode_false();
  }
}

control_room_enemies_upper_setup() {
  self endon("death");
  wait 0.5;
  maps\_utility::magic_bullet_shield();
  self.favoriteenemy = level.tower_redshirt;
  common_scripts\utility::flag_wait("player_landed");
  maps\_utility::stop_magic_bullet_shield();
  wait 1;
  self.favoriteenemy = undefined;
  self clearenemy();
  common_scripts\utility::flag_wait_any("control_room_three_left", "player_leaving_control_room");
  self.ignoreall = 1;
  wait(randomfloatrange(0.3, 0.8));
  var_0 = getent("upper_delete_volume", "targetname");
  self setgoalvolumeauto(var_0);

  for(;;) {
    if(self istouching(var_0)) {
      break;
    }

    wait 0.05;
  }

  var_0 = getent("upper_volume", "targetname");

  if(level.player istouching(var_0)) {
    self.ignoreall = 0;
    maps\_utility::player_seek_enable();
  } else
    self delete();
}

remove_ally_tanks() {
  wait 2;

  if(isDefined(level.herotanks)) {
    foreach(var_1 in level.herotanks) {
      var_1 delete();
    }
  }
}

sat_view_ally_and_enemy_tanks() {
  thread remove_ally_tanks();
  common_scripts\utility::flag_wait("spawn_sat_view_ally_choppers");
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("sat_view_ally_tanks");
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, var_0);
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::dumb_tank_shoot);
  level.sat_view_enemy_tanks = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("sat_view_enemy_tanks");
  level.enemytanks = common_scripts\utility::array_combine(level.enemytanks, level.sat_view_enemy_tanks);
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::dumb_tank_shoot);
  common_scripts\utility::flag_wait("chopper_flyin_begin");
  wait 3;
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("victory_a10s");
  common_scripts\utility::flag_wait("enable_player_rappel");
  var_2 = getEntArray("air_strip_secured_left_side_tanks", "script_noteworthy");

  foreach(var_4 in var_2) {
    if(isDefined(var_4)) {
      var_4 delete();
    }
  }

  common_scripts\utility::flag_wait("player_landed");

  foreach(var_4 in var_0) {
    if(isDefined(var_4)) {
      var_4 delete();
    }
  }

  foreach(var_4 in level.sat_view_enemy_tanks) {
    if(isDefined(var_4)) {
      var_4 delete();
    }
  }
}

sat_view_spawn_ally_choppers() {
  common_scripts\utility::flag_wait("spawn_sat_view_ally_choppers");
  level.player_littlebird = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("player_littlebird");
  level.allies[0] thread allies_ride_chopper(level.player_littlebird, "ghost1_start_firing");
  level.player_littlebird setmaxpitchroll(5, 5);
  wait 0.05;
  thread player_chopper_flyin_setup();
  level.ally_littlebird_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("ally_littlebird_1");
  maps\_utility::array_spawn_function_targetname("tower_redshirt", ::tower_redshirt_setup);
  level.tower_redshirt = maps\_utility::spawn_targetname("tower_redshirt", 1);
  level.tower_redshirt thread allies_ride_chopper(level.ally_littlebird_1, "ghost2_start_firing");
  level.ally_littlebird_1 thread ally_chopper_unload();
  level.ally_littlebird_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("ally_littlebird_2");
  var_0 = getent("air_strip_secured_delete_volume_1", "targetname");
  level.ally_littlebird_2 thread victory_choppers_land(var_0);
  level.ally_littlebird_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("ally_littlebird_3");
  var_0 = getent("air_strip_secured_delete_volume_2", "targetname");
  level.ally_littlebird_3 thread victory_choppers_land(var_0);
}

tower_redshirt_setup() {
  self endon("death");
  self.animname = "merrick";

  if(!isDefined(self.magic_bullet_shield)) {
    maps\_utility::magic_bullet_shield();
  }

  common_scripts\utility::flag_wait("ghost2_littlebird_path_end");

  if(isDefined(self.magic_bullet_shield)) {
    maps\_utility::stop_magic_bullet_shield();
  }

  self delete();
}

allies_ride_chopper(var_0, var_1) {
  if(self.animname == "hesh") {
    self linkto(var_0, "tag_detach_left", (0, 0, 0), (0, 0, 0));
    var_0 thread maps\_anim::anim_loop_solo(self, "little_bird_casual_idle_hesh", "stop_loop", "tag_detach_left");

    while(!isDefined(level.cinematic_over)) {
      wait 0.05;
    }

    var_0 notify("stop_loop");
    var_0 maps\_anim::anim_single_solo(self, "satfarm_control_tower_intro_hesh_talk", "tag_detach_left");
    var_0 thread maps\_anim::anim_loop_solo(self, "little_bird_casual_idle_hesh", "stop_loop", "tag_detach_left");
    common_scripts\utility::flag_wait(var_1);
    var_0 notify("stop_loop");
    var_0 maps\_anim::anim_single_solo(self, "satfarm_control_tower_transition_hesh", "tag_detach_left");
    var_0 thread maps\_anim::anim_loop_solo(self, "satfarm_control_tower_alert_hesh", "stop_loop", "tag_detach_left");
    common_scripts\utility::flag_wait("start_jump");
    var_0 notify("stop_loop");
    self unlink();
    level.player_chopper_anim_struct thread maps\_anim::anim_single_solo(self, "satfarm_control_tower_hesh");
    self waittillmatch("single anim", "glass_break");
    var_2 = getglass("ghost1_window");

    if(!isglassdestroyed(var_2)) {
      destroyglass(var_2);
    }

    self waittillmatch("single anim", "end");
    var_3 = getnode("ghost1_control_room_node", "targetname");
    maps\_utility::set_goalradius(16);
    self setgoalnode(var_3);
    maps\_utility::set_fixednode_true();
    self waittill("goal");
    maps\_utility::set_fixednode_false();
  } else {
    self linkto(var_0, "tag_detach_right", (0, 0, 0), (0, 0, 0));
    var_0 thread maps\_anim::anim_loop_solo(self, "little_bird_casual_idle_merrick", "stop_loop", "tag_detach_right");
    common_scripts\utility::flag_wait(var_1);
    var_0 notify("stop_loop");
    var_0 maps\_anim::anim_single_solo(self, "satfarm_control_tower_transition_merrick", "tag_detach_right");
    var_0 thread maps\_anim::anim_loop_solo(self, "satfarm_control_tower_alert_merrick", "stop_loop", "tag_detach_right");
  }
}