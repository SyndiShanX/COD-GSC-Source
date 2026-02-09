/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_script_2c.gsc
*********************************************/

_id_5998() {
  level._id_58D2 = maps\hijack_code::_id_594A("commander_tarmac");
  waittillframeend;
  var_0 = common_scripts\utility::getstruct("player_start_end_scene", "targetname");
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  maps\_compass::setupminimap("compass_map_hijack_tarmac", "tarmac_minimap_corner");
  setsaveddvar("compassmaxrange", 3500);
  thread maps\hijack_tarmac::_id_5999();
  maps\_audio::aud_send_msg("start_end_scene");
  common_scripts\utility::flag_set("player_on_feet_post_crash");
  common_scripts\utility::flag_set("spawn_makarov_heli");
  common_scripts\utility::flag_set("move_heli_to_hover_point");
  common_scripts\utility::flag_set("tarmac_combat_wave4");
  common_scripts\utility::flag_set("start_spotlight_random_targeting");
  thread maps\hijack_tarmac::_id_599A();
  thread maps\hijack_script_2b::_id_599B();
  level.player giveweapon("fraggrenade");
  level.player setoffhandprimaryclass("frag");
  level.player setweaponammoclip("fraggrenade", 4);
  level.player setweaponammostock("fraggrenade", 4);
  level.player setoffhandsecondaryclass("flash");
  level.player giveweapon("flash_grenade");
  level.player setweaponammoclip("flash_grenade", 4);
  level.player setweaponammostock("flash_grenade", 4);
  wait 0.4;
  var_1 = common_scripts\utility::getstruct("heli_approach", "targetname");
  level._id_5943 vehicle_teleport(var_1.origin, var_1.angles);
  thread maps\hijack_tarmac::_id_599C();
  wait 0.1;
  level._id_5943 maps\_utility::_id_2698();
  level._id_5943 setgoalyaw(var_1.angles[1]);
  level._id_5943 settargetyaw(var_1.angles[1]);
  level notify("stop_spotlight_fx");
  wait 2;
  var_2 = getaiarray();

  foreach(var_4 in var_2) {
    if(!isenemyteam(var_4.team, level.player.team)) {
      var_4 thread maps\hijack_code::_id_5951();
    }
  }
}

_id_599D() {
  var_0 = getent("end_scene_fail_trigger", "targetname");
  var_0 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_wait("player_entered_end_area");
  var_0 common_scripts\utility::trigger_on();
  common_scripts\utility::flag_wait("tarmac_level_fail");
  setDvar("ui_deadquote", &"HIJACK_FAIL_TARMAC");
  level notify("mission failed");
  maps\_utility::_id_1826();
}

_id_599E() {
  level endon("door_used");

  for(;;) {
    common_scripts\utility::flag_wait("player_disable_grenades");
    level.player disableoffhandweapons();
    common_scripts\utility::flag_waitopen("player_disable_grenades");
    level.player enableoffhandweapons();
  }
}

_id_599F() {
  if(isDefined(level._id_59A0)) {
    level._id_59A0 notify("stop_debate_advisor_loop");
  }
  level._id_59A1 = getent("commander_pistol_on_ground", "targetname");
  level._id_59A1 hide();
  thread _id_59B9();
  thread _id_599D();
  thread _id_599E();
  common_scripts\utility::flag_wait("player_approaching_end_guys");
  thread _id_59AA();
  thread _id_59AC();
  level._id_59A2 = maps\_utility::_id_272F("end_scene_secretservice", 1);
  level._id_59A2._id_1032 = "end_agent";
  level._id_59A2 animscripts\shared::_id_23C8();
  waittillframeend;
  level._id_59A2 maps\_utility::_id_104A("fnfiveseven", "sidearm");
  level._id_59A2 thread maps\hijack_code::_id_5951();
  level._id_58BA = maps\hijack_code::_id_594A("president_tarmac", "end_scene_president");
  level._id_58C6 = maps\hijack_code::_id_594A("advisor_tarmac", "end_scene_advisor");
  level._id_58C6 thread maps\hijack_code::_id_5951();
  var_0 = [];
  var_0[1] = level._id_58C6;
  var_0[2] = level._id_59A2;
  level._id_59A3 = common_scripts\utility::getstruct("heli_end_node", "targetname");
  level._id_59A3 thread maps\_anim::_id_124E(level._id_58BA, "end_part1", "stop_part_1");
  level._id_59A3 thread maps\_anim::_id_11D6(var_0, "end_part1", "stop_part_1");
  var_0[0] = level._id_58BA;
  common_scripts\utility::flag_wait("kill_final_enemies");
  thread _id_59AD();
  common_scripts\utility::flag_wait_all("player_entered_end_area", "endguys_dead");
  maps\_audio::aud_send_msg("player_entered_end_area");
  thread maps\_utility::_id_1425("end_scene");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = level._id_59A3.origin;
  var_1.angles = level._id_59A3.angles;
  common_scripts\utility::flag_wait("end_guys_waiting_for_commander");
  var_1 thread _id_59BB(var_0);
  common_scripts\utility::flag_wait("heli_landed");
  level._id_51F2 = maps\_utility::_id_1287("player_rig", level.player.origin);
  level._id_51F2 hide();
  level._id_59A3 maps\_anim::_id_11CF(level._id_51F2, "end_part4");
  level waittill("door_used");
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);
  thread maps\_utility::set_vision_set("hijack_ending", 9);
  thread maps\_utility::vision_set_fog_changes("hijack_ending", 9);

  foreach(var_3 in level._id_59A4) {}
  var_3 show();

  foreach(var_6 in level._id_59A5) {}
  var_6 show();

  level.player disableweapons();
  level.player setdepthoffield(10, 60, 411, 4679, 4.1, 2.8);
  level._id_59A6 = maps\_utility::_id_272F("makarov_spawner");
  level._id_59A6._id_1032 = "makarov";
  level._id_59A7 = maps\_utility::_id_272F("makarov_cronie1");
  level._id_59A7._id_1032 = "henchman1";
  level._id_59A7 thread maps\hijack_code::_id_5951();
  level._id_59A8 = maps\_utility::_id_272F("makarov_cronie2");
  level._id_59A8._id_1032 = "henchman2";
  level._id_59A8 thread maps\hijack_code::_id_5951();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player playerlinktoblend(level._id_51F2, "tag_player", 0.3, 0.2);
  var_0[3] = level._id_58D2;
  var_0[4] = level._id_51F2;
  var_0[5] = level._id_59A6;
  var_0[6] = level._id_5943;
  var_0[7] = level._id_59A9;
  var_0[8] = level._id_59A7;
  var_0[9] = level._id_59A8;
  level._id_5943._id_1032 = "makarov_heli";
  level._id_59A9._id_1032 = "makarov_heli_door";
  level._id_59A9 maps\_anim::_id_1244();
  level._id_58D2 maps\_utility::_id_104A(level._id_58D2.sidearm, "primary");
  level._id_59A3 thread maps\_anim::_id_11DD(var_0, "end_part4");
  maps\_audio::aud_send_msg("makarov_slow");
  maps\_audio::aud_send_msg("blackout");
  level.player lerpfov(45, 2);
  var_8 = common_scripts\utility::getstruct("makarov_heli_light_struct", "targetname");
  var_9 = anglesToForward(var_8.angles);
  var_10 = anglestoup(var_8.angles);
  playFX(common_scripts\utility::getfx("makarov_heli_interior_light"), var_8.origin, var_9, var_10);
  level._id_51F2 maps\_utility::delaythread(0.5, maps\_utility::_id_27C6);
  thread _id_59B5();
  thread _id_59B4();
  thread _id_59B3();
  thread _id_59B6();
  thread _id_59B2();
  thread _id_59AE();
  thread _id_59AF();
  thread _id_59B0();
  thread _id_59B1();
  thread _id_59C0();
  thread _id_0115();
  level._id_51F2 waittillmatch("single anim", "fade_in");
  level._id_58D2._id_1005 = "ak74u";
  level._id_58D2.weapon = "none";
  var_11 = _id_59B8(level._id_51F2 maps\_utility::_id_1281("end_part4"), "fade_in", "fade_out");
  maps\hijack_code::_id_09FA(var_11);
  wait 0.75;
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("hud_showstance", 1);
  setsaveddvar("actionSlotsHide", 0);
  maps\_utility::_id_195A();
}

_id_0115() {
  level._id_59A6 waittillmatch("single anim", "ps_hijack_mkv_weakness");
  wait 3.3;
  maps\_utility::_id_11F4("hijack_fso3_allteams");
}

_id_59AA() {
  level endon("door_used");
  var_0 = getent("ending_distant_combat1", "targetname");
  level._id_59AB = 0;

  for(;;) {
    wait(randomfloatrange(2, 9));
    var_1 = randomintrange(0, 5);

    if(var_1 == level._id_59AB) {
      var_1 = var_1 + 1;

      if(var_1 == 5) {
        var_1 = 0;
      }
    }

    level._id_59AB = var_1;

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

_id_59AC() {
  level endon("door_used");
  var_0 = getent("ending_distant_combat2", "targetname");
  level._id_59AB = 0;

  for(;;) {
    wait(randomfloatrange(2, 9));
    var_1 = randomintrange(0, 5);

    if(var_1 == level._id_59AB) {
      var_1 = var_1 + 1;

      if(var_1 == 5) {
        var_1 = 0;
      }
    }

    level._id_59AB = var_1;

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

_id_59AD() {
  wait 2;
  var_0 = getstartorigin(level._id_59A3.origin, level._id_59A3.angles, level._id_58D2 maps\_utility::_id_1281("end_part2"));
  var_1 = distance(var_0, level._id_58D2.origin);
  level._id_58D2._id_0FC6 = 0.9;
  level._id_59A3 maps\_anim::_id_124A(level._id_58D2, "end_part2");
  common_scripts\utility::flag_set("end_guys_waiting_for_commander");
}

_id_59AE() {
  level._id_59A6 waittillmatch("single anim", "gun_2_left");
  level._id_59A6 animscripts\shared::_id_0C9B(level._id_59A6.weapon, "left");
  level._id_59A6 notify("weapon_switch_done");
  level._id_59A6 waittillmatch("single anim", "fire");
  var_0 = level._id_59A6 gettagorigin("tag_weapon");
  var_1 = anglesToForward(level._id_59A6 getmuzzleangle());
  var_2 = var_0 + var_1 * 1000;
  level._id_59A6 shoot(1, var_2);
}

_id_59AF() {
  level._id_59A6 waittillmatch("single anim", "fire");
  playFXOnTag(common_scripts\utility::getfx("beretta_flash_wv"), level._id_59A6, "tag_weapon_right");
  level._id_59A6 waittillmatch("single anim", "fire");
  maps\_audio::aud_send_msg("commander_shot");
  playFXOnTag(common_scripts\utility::getfx("beretta_flash_wv"), level._id_59A6, "tag_weapon_right");
  var_0 = level._id_59A6 gettagorigin("tag_weapon_right");
  var_1 = anglesToForward(level._id_59A6 getmuzzleangle());
  playFX(common_scripts\utility::getfx("commander_headshot"), var_0, var_1);
  level._id_59A6 waittillmatch("single anim", "fire");
  maps\_audio::aud_send_msg("player_shot");
  playFXOnTag(common_scripts\utility::getfx("beretta_flash_wv"), level._id_59A6, "tag_weapon_left");
  var_2 = maps\_hud_util::_id_09A7("white", 1);
  var_2 thread maps\_hud_util::fade_over_time(0, 0.25);
}

_id_59B0() {
  level._id_59A7 waittillmatch("single anim", "fire");
  playFXOnTag(common_scripts\utility::getfx("ak47_flash_wv_hijack_crash"), level._id_59A7, "tag_weapon_right");
  playFXOnTag(common_scripts\utility::getfx("flesh_hit_body_fatal_exit"), level._id_58D2, "tag_weapon_chest");
  level._id_59A7 waittillmatch("single anim", "fire");
  playFXOnTag(common_scripts\utility::getfx("ak47_flash_wv_hijack_crash"), level._id_59A7, "tag_weapon_right");
  playFXOnTag(common_scripts\utility::getfx("flesh_hit_body_fatal_exit"), level._id_59A2, "tag_weapon_chest");
}

_id_59B1() {
  level._id_59A8 waittillmatch("single anim", "fire");
  playFXOnTag(common_scripts\utility::getfx("ak47_flash_wv_hijack_crash"), level._id_59A8, "tag_weapon_right");
  level._id_59A8 waittillmatch("single anim", "fire");
  playFXOnTag(common_scripts\utility::getfx("ak47_flash_wv_hijack_crash"), level._id_59A8, "tag_weapon_right");
}

_id_59B2() {
  level._id_51F2 waittillmatch("single anim", "start_bloody_screen");
  wait 9;
  level._id_59A1 show();
  wait 1;
  var_0 = level._id_58D2 gettagorigin("tag_eye");
  var_1 = level._id_58D2 gettagangles("tag_eye");
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

_id_59B3() {
  level.player enableslowaim(0.1, 0.1);
  level._id_51F2 waittillmatch("single anim", "unlock_player_look_control");
  level.player playerlinktodelta(level._id_51F2, "tag_player", 1, 15, 15, 10, 10, 1);
  wait 20;
  level.player playerlinktoblend(level._id_51F2, "tag_player", 6, 0.1, 0.1);
}

_id_59B4() {
  level._id_51F2 waittillmatch("single anim", "start_bloody_screen");
  var_0 = maps\_hud_util::_id_09A7("white", 1);
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

_id_59B5() {
  level._id_51F2 waittillmatch("single anim", "slomo_in");
  setslowmotion(1.0, 0.3, 0.05);
  level._id_51F2 waittillmatch("single anim", "slomo_out");
  setslowmotion(0.3, 1.0, 0.05);
  level._id_51F2 waittillmatch("single anim", "slomo_in");
  setslowmotion(1.0, 0.3, 0.8);
  level.player lerpfov(65, 1.5);
  level._id_51F2 waittillmatch("single anim", "slomo_out");
  setslowmotion(0.3, 1.0, 0.05);
}

_id_59B6() {
  level._id_51F2 waittillmatch("single anim", "ai_start");
  var_0 = maps\_utility::_id_272C("makarov_extra_henchmen");
  var_0[0] thread maps\hijack_code::_id_5951();
  var_0[1] thread maps\hijack_code::_id_5951();
  var_1 = getnode("henchmen_1_final_dest", "targetname");
  var_2 = getnode("henchmen_1_final_dest", "targetname");
  var_0[1] _id_59B7(var_1);
  wait 0.5;
  var_0[0] _id_59B7(var_2);
}

_id_59B7(var_0) {
  self.goalradius = 24;
  maps\_utility::_id_251E();
  self setgoalnode(var_0);
}

_id_59B8(var_0, var_1, var_2) {
  var_3 = getnotetracktimes(var_0, var_1)[0];
  var_4 = getnotetracktimes(var_0, var_2)[0];
  var_5 = (var_4 - var_3) * getanimlength(var_0);
  return var_5;
}

_id_59B9() {
  common_scripts\utility::flag_wait("spawn_makarov_heli");
  common_scripts\utility::flag_wait("guys_ready_for_door");
  common_scripts\utility::flag_wait("heli_landed");
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = level._id_5943 gettagorigin("tag_left_door_handle");
  var_0 setcursorhint("HINT_ACTIVATE");
  var_0 sethintstring(&"HIJACK_OPEN_HELI_DOOR");
  var_0 makeusable();
  level._id_59A9 maps\_utility::_id_27B0();
  thread _id_59BA();
  var_0 waittill("trigger", var_1);
  var_0 sethintstring("");
  level._id_59A9 maps\_utility::_id_27B2();
  level notify("door_used");
}

_id_59BA() {
  level endon("door_used");
  wait 2;
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_openthedoor2");

  for(;;) {
    wait(randomfloatrange(10, 15));
    level._id_58D2 maps\_utility::_id_168C("hijack_cmd_openthedoor2");
  }
}

_id_59BB(var_0) {
  level._id_58D2 maps\_utility::_id_109E();
  level._id_58D2._id_0FC6 = 0.8;
  maps\_anim::_id_124A(level._id_58D2, "end_part2");
  level._id_59A3 notify("stop_part_1");

  foreach(var_2 in var_0) {}
  var_2 stopanimscripted();

  common_scripts\utility::flag_set("start_heli_descent");

  foreach(var_2 in var_0) {}
  var_2._id_240A = "snow";

  thread maps\_anim::_id_11DD(var_0, "end_part2", "tag_origin");
  maps\_anim::_id_1246(level._id_58D2, "end_part2", "tag_origin");
  level notify("player_told_to_open_door");
  var_0[3] = level._id_58D2;
  thread maps\_anim::_id_11D6(var_0, "end_part3", "stop_part2_loop", "tag_origin");
  common_scripts\utility::flag_set("guys_ready_for_door");
}

_id_59BC() {
  maps\_treadfx::_id_28EF("script_vehicle_mi17_woodland_landing", "snow", "treadfx/heli_snow_hijack");
  maps\_treadfx::_id_28EF("script_vehicle_mi17_woodland_landing", "ice", "treadfx/heli_snow_hijack");
  maps\_treadfx::_id_28EF("script_vehicle_mi17_woodland_landing", "slush", "treadfx/heli_snow_hijack");
  self._id_295E = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  level._id_5943 maps\_utility::_id_1654("makarov_heli_disable_spotlight");
  level notify("stop_spotlight_fx");
  maps\_utility::_id_1654("makarov_heli_reached_end");
  maps\_utility::_id_2698();
  level._id_59A3 = common_scripts\utility::getstruct("heli_end_node", "targetname");
  self setgoalyaw(level._id_59A3.angles[1]);
  self settargetyaw(level._id_59A3.angles[1]);
  self sethoverparams(0, 0, 0);
  self setvehgoalpos(level._id_59A3.origin, 1);
  self waittill("goal");
  wait 0.25;
  self vehicle_teleport(level._id_59A3.origin, level._id_59A3.angles);
  wait 0.25;
  common_scripts\utility::flag_set("heli_landed");
}

_id_59BD(var_0) {
  level endon("stop_spotlight_fx");

  for(;;) {
    var_1 = (randomfloatrange(-150, 150), randomfloatrange(-150, 150), 0);
    var_2 = var_0.origin + var_1;
    var_3 = randomfloatrange(1.5, 2.5);
    self moveto(var_2, var_3);
    var_4 = randomfloatrange(0, 1);
    wait(var_3 + var_4);
  }
}

_id_59BE() {
  self endon("death");
  self notify("start_random_spotlight_targets");
  self notify("shine_spotlight_on_president");
  var_0 = common_scripts\utility::getstruct("objective_end_3", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  self._id_2891 settargetentity(var_1);
  var_1 thread _id_59BD(var_0);
  level waittill("stop_spotlight_fx");
  wait 0.9;
  var_1 delete();
  var_2 = anglesToForward(self.angles + (60, 90, 0));
  var_3 = self gettagorigin("tag_turret") + var_2 * 200;
  self._id_59BF = spawn("script_origin", var_3);
  self._id_59BF linkto(self);
  self._id_2891 settargetentity(self._id_59BF);
}

_id_59C0() {
  level._id_59A6 waittillmatch("single anim", "gun_2_left");
  var_0 = maps\_vehicle::_id_2A9A("end_choppers");
  wait 0.35;
  var_1 = maps\_vehicle::_id_2A9A("end_choppers2");
}