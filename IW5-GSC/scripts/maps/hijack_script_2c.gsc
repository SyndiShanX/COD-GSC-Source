/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_script_2c.gsc
*********************************************/

start_end_scene() {
  level.commander = maps\hijack_code::spawn_ally("commander_tarmac");
  waittillframeend;
  var_0 = common_scripts\utility::getStruct("player_start_end_scene", "targetname");
  level.player setOrigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  maps\_compass::setupminimap("compass_map_hijack_tarmac", "tarmac_minimap_corner");
  setsaveddvar("compassmaxrange", 3500);
  thread maps\hijack_tarmac::tarmac_dead_allies();
  maps\_audio::aud_send_msg("start_end_scene");
  common_scripts\utility::flag_set("player_on_feet_post_crash");
  common_scripts\utility::flag_set("spawn_makarov_heli");
  common_scripts\utility::flag_set("move_heli_to_hover_point");
  common_scripts\utility::flag_set("tarmac_combat_wave4");
  common_scripts\utility::flag_set("start_spotlight_random_targeting");
  thread maps\hijack_tarmac::main_script_thread();
  thread maps\hijack_script_2b::tarmac_combat_vo_end();
  level.player giveweapon("fraggrenade");
  level.player setoffhandprimaryclass("frag");
  level.player setweaponammoclip("fraggrenade", 4);
  level.player setweaponammostock("fraggrenade", 4);
  level.player setoffhandsecondaryclass("flash");
  level.player giveweapon("flash_grenade");
  level.player setweaponammoclip("flash_grenade", 4);
  level.player setweaponammostock("flash_grenade", 4);
  wait 0.4;
  var_1 = common_scripts\utility::getStruct("heli_approach", "targetname");
  level.makarov_heli vehicle_teleport(var_1.origin, var_1.angles);
  thread maps\hijack_tarmac::makarov_heli_2();
  wait 0.1;
  level.makarov_heli maps\_utility::vehicle_detachfrompath();
  level.makarov_heli setgoalyaw(var_1.angles[1]);
  level.makarov_heli settargetyaw(var_1.angles[1]);
  level notify("stop_spotlight_fx");
  wait 2;
  var_2 = getaiarray();

  foreach(var_4 in var_2) {
    if(!isenemyteam(var_4.team, level.player.team)) {
      var_4 thread maps\hijack_code::cold_breath_hijack();
    }
  }
}

end_scene_fail_trigger() {
  var_0 = getEnt("end_scene_fail_trigger", "targetname");
  var_0 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_wait("player_entered_end_area");
  var_0 common_scripts\utility::trigger_on();
  common_scripts\utility::flag_wait("tarmac_level_fail");
  setDvar("ui_deadquote", &"HIJACK_FAIL_TARMAC");
  level notify("mission failed");
  maps\_utility::missionfailedwrapper();
}

player_grenade_watcher() {
  level endon("door_used");

  for(;;) {
    common_scripts\utility::flag_wait("player_disable_grenades");
    level.player disableoffhandweapons();
    common_scripts\utility::flag_waitopen("player_disable_grenades");
    level.player enableoffhandweapons();
  }
}

end_scene() {
  if(isDefined(level.intro_origin)) {
    level.intro_origin notify("stop_debate_advisor_loop");
  }
  level.commander_pistol = getEnt("commander_pistol_on_ground", "targetname");
  level.commander_pistol hide();
  thread setup_heli_door();
  thread end_scene_fail_trigger();
  thread player_grenade_watcher();
  common_scripts\utility::flag_wait("player_approaching_end_guys");
  thread ending_distant_combat1();
  thread ending_distant_combat2();
  level.end_secret_service = maps\_utility::spawn_targetname("end_scene_secretservice", 1);
  level.end_secret_service.animname = "end_agent";
  level.end_secret_service animscripts\shared::dropaiweapon();
  waittillframeend;
  level.end_secret_service maps\_utility::forceuseweapon("fnfiveseven", "sidearm");
  level.end_secret_service thread maps\hijack_code::cold_breath_hijack();
  level.president = maps\hijack_code::spawn_ally("president_tarmac", "end_scene_president");
  level.advisor = maps\hijack_code::spawn_ally("advisor_tarmac", "end_scene_advisor");
  level.advisor thread maps\hijack_code::cold_breath_hijack();
  var_0 = [];
  var_0[1] = level.advisor;
  var_0[2] = level.end_secret_service;
  level.chopper_land_node = common_scripts\utility::getStruct("heli_end_node", "targetname");
  level.chopper_land_node thread maps\_anim::anim_loop_solo(level.president, "end_part1", "stop_part_1");
  level.chopper_land_node thread maps\_anim::anim_loop(var_0, "end_part1", "stop_part_1");
  var_0[0] = level.president;
  common_scripts\utility::flag_wait("kill_final_enemies");
  thread handle_commander_move_to_end();
  common_scripts\utility::flag_wait_all("player_entered_end_area", "endguys_dead");
  maps\_audio::aud_send_msg("player_entered_end_area");
  thread maps\_utility::autosave_by_name("end_scene");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = level.chopper_land_node.origin;
  var_1.angles = level.chopper_land_node.angles;
  common_scripts\utility::flag_wait("end_guys_waiting_for_commander");
  var_1 thread guys_approach_heli(var_0);
  common_scripts\utility::flag_wait("heli_landed");
  level.player_rig = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  level.player_rig hide();
  level.chopper_land_node maps\_anim::anim_first_frame_solo(level.player_rig, "end_part4");
  level waittill("door_used");
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);
  thread maps\_utility::set_vision_set("hijack_ending", 9);
  thread maps\_utility::vision_set_fog_changes("hijack_ending", 9);

  foreach(var_3 in level.heli_interior) {}
  var_3 show();

  foreach(var_6 in level.end_cards) {}
  var_6 show();

  level.player disableweapons();
  level.player setdepthoffield(10, 60, 411, 4679, 4.1, 2.8);
  level.makarov = maps\_utility::spawn_targetname("makarov_spawner");
  level.makarov.animname = "makarov";
  level.cronie1 = maps\_utility::spawn_targetname("makarov_cronie1");
  level.cronie1.animname = "henchman1";
  level.cronie1 thread maps\hijack_code::cold_breath_hijack();
  level.cronie2 = maps\_utility::spawn_targetname("makarov_cronie2");
  level.cronie2.animname = "henchman2";
  level.cronie2 thread maps\hijack_code::cold_breath_hijack();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player playerlinktoblend(level.player_rig, "tag_player", 0.3, 0.2);
  var_0[3] = level.commander;
  var_0[4] = level.player_rig;
  var_0[5] = level.makarov;
  var_0[6] = level.makarov_heli;
  var_0[7] = level.makarov_heli_door;
  var_0[8] = level.cronie1;
  var_0[9] = level.cronie2;
  level.makarov_heli.animname = "makarov_heli";
  level.makarov_heli_door.animname = "makarov_heli_door";
  level.makarov_heli_door maps\_anim::setanimtree();
  level.commander maps\_utility::forceuseweapon(level.commander.sidearm, "primary");
  level.chopper_land_node thread maps\_anim::anim_single(var_0, "end_part4");
  maps\_audio::aud_send_msg("makarov_slow");
  maps\_audio::aud_send_msg("blackout");
  level.player lerpfov(45, 2);
  var_8 = common_scripts\utility::getStruct("makarov_heli_light_struct", "targetname");
  var_9 = anglesToForward(var_8.angles);
  var_10 = anglestoup(var_8.angles);
  playFX(common_scripts\utility::getfx("makarov_heli_interior_light"), var_8.origin, var_9, var_10);
  level.player_rig maps\_utility::delaythread(0.5, maps\_utility::show_entity);
  thread player_slo_mo();
  thread player_bloody_screen();
  thread unlock_look_control();
  thread spawn_and_move_extras();
  thread commander_pistol_and_blood();
  thread makarov_switch_weapon_hands();
  thread makarov_gun_shots();
  thread cronie1_gun_shots();
  thread cronie2_gun_shots();
  thread ending_final_choppers();
  thread final_vo();
  level.player_rig waittillmatch("single anim", "fade_in");
  level.commander.lastweapon = "ak74u";
  level.commander.weapon = "none";
  var_11 = calcnotetrackdelta(level.player_rig maps\_utility::getanim("end_part4"), "fade_in", "fade_out");
  maps\hijack_code::fade_out(var_11);
  wait 0.75;
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("hud_showstance", 1);
  setsaveddvar("actionSlotsHide", 0);
  maps\_utility::nextmission();
}

final_vo() {
  level.makarov waittillmatch("single anim", "ps_hijack_mkv_weakness");
  wait 3.3;
  maps\_utility::radio_dialogue("hijack_fso3_allteams");
}

ending_distant_combat1() {
  level endon("door_used");
  var_0 = getEnt("ending_distant_combat1", "targetname");
  level.snd_index = 0;

  for(;;) {
    wait(randomfloatrange(2, 9));
    var_1 = randomintrange(0, 5);

    if(var_1 == level.snd_index) {
      var_1 = var_1 + 1;

      if(var_1 == 5) {
        var_1 = 0;
      }
    }

    level.snd_index = var_1;

    switch (var_1) {
      case 0:
        var_0 playSound("hijack_fso3_longyell");
        break;
      case 1:
        var_0 playSound("hijack_fso2_injured");
        break;
      case 2:
        var_0 playSound("hijack_fso1_surprisedyelp");
        break;
      case 3:
        var_0 playSound("hijack_fso2_yellofpain");
        break;
      case 4:
        var_0 playSound("hijack_fso2_yellofpain2");
        break;
      default:
        break;
    }
  }
}

ending_distant_combat2() {
  level endon("door_used");
  var_0 = getEnt("ending_distant_combat2", "targetname");
  level.snd_index = 0;

  for(;;) {
    wait(randomfloatrange(2, 9));
    var_1 = randomintrange(0, 5);

    if(var_1 == level.snd_index) {
      var_1 = var_1 + 1;

      if(var_1 == 5) {
        var_1 = 0;
      }
    }

    level.snd_index = var_1;

    switch (var_1) {
      case 0:
        var_0 playSound("hijack_fso2_yellofpain2");
        break;
      case 1:
        var_0 playSound("hijack_fso1_agentdown");
        break;
      case 2:
        var_0 playSound("hijack_fso2_lookout");
        break;
      case 3:
        var_0 playSound("hijack_fso1_gungun");
        break;
      case 4:
        var_0 playSound("hijack_fso3_yellofpain");
        break;
      default:
        break;
    }
  }
}

handle_commander_move_to_end() {
  wait 2;
  var_0 = getstartorigin(level.chopper_land_node.origin, level.chopper_land_node.angles, level.commander maps\_utility::getanim("end_part2"));
  var_1 = distance(var_0, level.commander.origin);
  level.commander.moveplaybackrate = 0.9;
  level.chopper_land_node maps\_anim::anim_reach_solo(level.commander, "end_part2");
  common_scripts\utility::flag_set("end_guys_waiting_for_commander");
}

makarov_switch_weapon_hands() {
  level.makarov waittillmatch("single anim", "gun_2_left");
  level.makarov animscripts\shared::placeweaponon(level.makarov.weapon, "left");
  level.makarov notify("weapon_switch_done");
  level.makarov waittillmatch("single anim", "fire");
  var_0 = level.makarov gettagorigin("tag_weapon");
  var_1 = anglesToForward(level.makarov getmuzzleangle());
  var_2 = var_0 + var_1 * 1000;
  level.makarov shoot(1, var_2);
}

makarov_gun_shots() {
  level.makarov waittillmatch("single anim", "fire");
  playFXOnTag(common_scripts\utility::getfx("beretta_flash_wv"), level.makarov, "tag_weapon_right");
  level.makarov waittillmatch("single anim", "fire");
  maps\_audio::aud_send_msg("commander_shot");
  playFXOnTag(common_scripts\utility::getfx("beretta_flash_wv"), level.makarov, "tag_weapon_right");
  var_0 = level.makarov gettagorigin("tag_weapon_right");
  var_1 = anglesToForward(level.makarov getmuzzleangle());
  playFX(common_scripts\utility::getfx("commander_headshot"), var_0, var_1);
  level.makarov waittillmatch("single anim", "fire");
  maps\_audio::aud_send_msg("player_shot");
  playFXOnTag(common_scripts\utility::getfx("beretta_flash_wv"), level.makarov, "tag_weapon_left");
  var_2 = maps\_hud_util::create_client_overlay("white", 1);
  var_2 thread maps\_hud_util::fade_over_time(0, 0.25);
}

cronie1_gun_shots() {
  level.cronie1 waittillmatch("single anim", "fire");
  playFXOnTag(common_scripts\utility::getfx("ak47_flash_wv_hijack_crash"), level.cronie1, "tag_weapon_right");
  playFXOnTag(common_scripts\utility::getfx("flesh_hit_body_fatal_exit"), level.commander, "tag_weapon_chest");
  level.cronie1 waittillmatch("single anim", "fire");
  playFXOnTag(common_scripts\utility::getfx("ak47_flash_wv_hijack_crash"), level.cronie1, "tag_weapon_right");
  playFXOnTag(common_scripts\utility::getfx("flesh_hit_body_fatal_exit"), level.end_secret_service, "tag_weapon_chest");
}

cronie2_gun_shots() {
  level.cronie2 waittillmatch("single anim", "fire");
  playFXOnTag(common_scripts\utility::getfx("ak47_flash_wv_hijack_crash"), level.cronie2, "tag_weapon_right");
  level.cronie2 waittillmatch("single anim", "fire");
  playFXOnTag(common_scripts\utility::getfx("ak47_flash_wv_hijack_crash"), level.cronie2, "tag_weapon_right");
}

commander_pistol_and_blood() {
  level.player_rig waittillmatch("single anim", "start_bloody_screen");
  wait 9;
  level.commander_pistol show();
  wait 1;
  var_0 = level.commander gettagorigin("tag_eye");
  var_1 = level.commander gettagangles("tag_eye");
  var_2 = anglesToForward(var_1);
  var_3 = anglestoup(var_1);
  var_4 = anglestoright(var_1);
  var_0 = var_0 + var_2 * -8.5 + var_3 * 5 + var_4 * 0;
  var_5 = bulletTrace(var_0 + (0, 0, 30), var_0 - (0, 0, 100), 0, undefined);
  var_6 = anglesToForward((0, 180, 0));

  if(var_5["normal"][2] > 0.9) {
    playFX(level._effect["commander_blood_pool"], var_0);
  }
}

unlock_look_control() {
  level.player enableslowaim(0.1, 0.1);
  level.player_rig waittillmatch("single anim", "unlock_player_look_control");
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 15, 15, 10, 10, 1);
  wait 20;
  level.player playerlinktoblend(level.player_rig, "tag_player", 6, 0.1, 0.1);
}

player_bloody_screen() {
  level.player_rig waittillmatch("single anim", "start_bloody_screen");
  var_0 = maps\_hud_util::create_client_overlay("white", 1);
  var_0 thread maps\_hud_util::fade_over_time(0, 0.5);
  var_1 = newclienthudelem(level.player);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("fullscreen_bloodsplat_bottom", 640, 480);
  var_1.splatter = 1;
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.sort = 1;
  var_1.foreground = 0;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 1;
  thread maps\_blizzard_hijack::_id_567A(2);
  setblur(1.0, 0.1);
  wait 1.65;
  setblur(4.0, 0.2);
  wait 0.3;
  setblur(0.0, 1.0);

  for(;;) {
    var_2 = randomint(3) + 2;
    var_3 = randomfloatrange(0.8, 1.2);
    var_4 = randomfloatrange(0.5, 1.0);
    setblur(var_2, var_3);
    wait(var_3);
    setblur(0, var_4);
    wait 3;
  }
}

player_slo_mo() {
  level.player_rig waittillmatch("single anim", "slomo_in");
  setslowmotion(1.0, 0.3, 0.05);
  level.player_rig waittillmatch("single anim", "slomo_out");
  setslowmotion(0.3, 1.0, 0.05);
  level.player_rig waittillmatch("single anim", "slomo_in");
  setslowmotion(1.0, 0.3, 0.8);
  level.player lerpfov(65, 1.5);
  level.player_rig waittillmatch("single anim", "slomo_out");
  setslowmotion(0.3, 1.0, 0.05);
}

spawn_and_move_extras() {
  level.player_rig waittillmatch("single anim", "ai_start");
  var_0 = maps\_utility::array_spawn_targetname("makarov_extra_henchmen");
  var_0[0] thread maps\hijack_code::cold_breath_hijack();
  var_0[1] thread maps\hijack_code::cold_breath_hijack();
  var_1 = getnode("henchmen_1_final_dest", "targetname");
  var_2 = getnode("henchmen_1_final_dest", "targetname");
  var_0[1] go_to_final_dest(var_1);
  wait 0.5;
  var_0[0] go_to_final_dest(var_2);
}

go_to_final_dest(var_0) {
  self.goalradius = 24;
  maps\_utility::set_forcegoal();
  self setgoalnode(var_0);
}

calcnotetrackdelta(var_0, var_1, var_2) {
  var_3 = getnotetracktimes(var_0, var_1)[0];
  var_4 = getnotetracktimes(var_0, var_2)[0];
  var_5 = (var_4 - var_3) * getanimlength(var_0);
  return var_5;
}

setup_heli_door() {
  common_scripts\utility::flag_wait("spawn_makarov_heli");
  common_scripts\utility::flag_wait("guys_ready_for_door");
  common_scripts\utility::flag_wait("heli_landed");
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = level.makarov_heli gettagorigin("tag_left_door_handle");
  var_0 setCursorHint("HINT_ACTIVATE");
  var_0 setHintString(&"HIJACK_OPEN_HELI_DOOR");
  var_0 makeusable();
  level.makarov_heli_door maps\_utility::glow();
  thread player_door_nag();
  var_0 waittill("trigger", var_1);
  var_0 setHintString("");
  level.makarov_heli_door maps\_utility::stopglow();
  level notify("door_used");
}

player_door_nag() {
  level endon("door_used");
  wait 2;
  level.commander maps\_utility::dialogue_queue("hijack_cmd_openthedoor2");

  for(;;) {
    wait(randomfloatrange(10, 15));
    level.commander maps\_utility::dialogue_queue("hijack_cmd_openthedoor2");
  }
}

guys_approach_heli(var_0) {
  level.commander maps\_utility::disable_cqbwalk();
  level.commander.moveplaybackrate = 0.8;
  maps\_anim::anim_reach_solo(level.commander, "end_part2");
  level.chopper_land_node notify("stop_part_1");

  foreach(var_2 in var_0) {}
  var_2 stopanimScripted();

  common_scripts\utility::flag_set("start_heli_descent");

  foreach(var_2 in var_0) {}
  var_2.lastgroundtype = "snow";

  thread maps\_anim::anim_single(var_0, "end_part2", "tag_origin");
  maps\_anim::anim_single_solo(level.commander, "end_part2", "tag_origin");
  level notify("player_told_to_open_door");
  var_0[3] = level.commander;
  thread maps\_anim::anim_loop(var_0, "end_part3", "stop_part2_loop", "tag_origin");
  common_scripts\utility::flag_set("guys_ready_for_door");
}

heli_lands() {
  maps\_treadfx::setvehiclefx("script_vehicle_mi17_woodland_landing", "snow", "treadfx/heli_snow_hijack");
  maps\_treadfx::setvehiclefx("script_vehicle_mi17_woodland_landing", "ice", "treadfx/heli_snow_hijack");
  maps\_treadfx::setvehiclefx("script_vehicle_mi17_woodland_landing", "slush", "treadfx/heli_snow_hijack");
  self.originheightoffset = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  level.makarov_heli maps\_utility::ent_flag_wait("makarov_heli_disable_spotlight");
  level notify("stop_spotlight_fx");
  maps\_utility::ent_flag_wait("makarov_heli_reached_end");
  maps\_utility::vehicle_detachfrompath();
  level.chopper_land_node = common_scripts\utility::getStruct("heli_end_node", "targetname");
  self setgoalyaw(level.chopper_land_node.angles[1]);
  self settargetyaw(level.chopper_land_node.angles[1]);
  self sethoverparams(0, 0, 0);
  self setvehgoalpos(level.chopper_land_node.origin, 1);
  self waittill("goal");
  wait 0.25;
  self vehicle_teleport(level.chopper_land_node.origin, level.chopper_land_node.angles);
  wait 0.25;
  common_scripts\utility::flag_set("heli_landed");
}

move_around_target(var_0) {
  level endon("stop_spotlight_fx");

  for(;;) {
    var_1 = (randomfloatrange(-150, 150), randomfloatrange(-150, 150), 0);
    var_2 = var_0.origin + var_1;
    var_3 = randomfloatrange(1.5, 2.5);
    self moveTo(var_2, var_3);
    var_4 = randomfloatrange(0, 1);
    wait(var_3 + var_4);
  }
}

spotlight_monitor_end() {
  self endon("death");
  self notify("start_random_spotlight_targets");
  self notify("shine_spotlight_on_president");
  var_0 = common_scripts\utility::getStruct("objective_end_3", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  self.spotlight settargetentity(var_1);
  var_1 thread move_around_target(var_0);
  level waittill("stop_spotlight_fx");
  wait 0.9;
  var_1 delete();
  var_2 = anglesToForward(self.angles + (60, 90, 0));
  var_3 = self gettagorigin("tag_turret") + var_2 * 200;
  self.spotlight_target_final = spawn("script_origin", var_3);
  self.spotlight_target_final linkTo(self);
  self.spotlight settargetentity(self.spotlight_target_final);
}

ending_final_choppers() {
  level.makarov waittillmatch("single anim", "gun_2_left");
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("end_choppers");
  wait 0.35;
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("end_choppers2");
}