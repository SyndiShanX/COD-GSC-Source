/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_script_2b.gsc
*********************************************/

_id_59C1() {
  level._id_58D2 = maps\hijack_code::_id_594A("commander_tarmac");
  waittillframeend;
  var_0 = common_scripts\utility::getstruct("player_start_post_tarmac", "targetname");
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  maps\_compass::setupminimap("compass_map_hijack_tarmac", "tarmac_minimap_corner");
  setsaveddvar("compassmaxrange", 3500);
  thread maps\hijack_tarmac::_id_5999();
  maps\_audio::aud_send_msg("start_post_tarmac");
  common_scripts\utility::flag_set("player_on_feet_post_crash");
  common_scripts\utility::flag_set("spawn_makarov_heli");
  common_scripts\utility::flag_set("start_spotlight_random_targeting");
  common_scripts\utility::flag_init("flag_red_leave_tarmac_combat");
  common_scripts\utility::flag_init("tarmac_combat_level_fail");
  common_scripts\utility::flag_set("fx_crash_trench_fire");
  thread maps\hijack_tarmac::_id_599A();
  thread _id_59CE();
  level._id_59C2 = getdvarfloat("jump_height");
  var_1 = common_scripts\utility::getstruct("makarov_heli_end_scene_loop", "targetname");
  level._id_5943 vehicle_teleport(var_1.origin, var_1.angles);
  level._id_5943 thread maps\_vehicle::_id_26A1(var_1);
  wait 2;
  var_2 = getaiarray();

  foreach(var_4 in var_2) {
    if(!isenemyteam(var_4.team, level.player.team)) {
      var_4 thread maps\hijack_code::_id_5951();
    }
  }

  level.player giveweapon("fraggrenade");
  level.player setoffhandprimaryclass("frag");
  level.player setweaponammoclip("fraggrenade", 0);
  level.player setweaponammostock("fraggrenade", 0);
  level.player setoffhandsecondaryclass("flash");
  level.player giveweapon("flash_grenade");
  level.player setweaponammoclip("flash_grenade", 0);
  level.player setweaponammostock("flash_grenade", 0);
}

main() {
  thread maps\hijack_script_2c::_id_599F();
  level._id_1380 = 256;
  thread _id_59C5();
  thread _id_59C9();
  thread _id_59CA();
  thread _id_59CB();
  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  thread _id_59D1();
  level waittill("commander_react_to_combat");
  level._id_58D2.ignoreall = 0;
  level._id_58D2._id_59C3 = 0;
  level._id_58D2.ignoreme = 0;
  level._id_58D2 notify("reach_notify");
  level._id_58D2 maps\_utility::_id_140C();
  level._id_58D2 maps\_utility::_id_26FC();
  level._id_58D2 notify("stop_relaxed_idle");
  level._id_58D2 maps\_utility::_id_1414();
  level._id_58D2 animscripts\animset::_id_0C87();
  level._id_58D2 maps\_utility::_id_13A4("r");
  level._id_58D2 maps\_utility::_id_2686();
  level._id_58D2._id_0FC6 = 1.0;
  level._id_58D2._id_117F = 0;
  maps\hijack_tarmac::_id_59C4(1.0);
  level._id_58D2 maps\_utility::_id_26F7("tarmac_enter_combat_commander");
  var_0 = getanimlength(level._id_58D2 maps\_utility::_id_1281("tarmac_enter_combat_commander"));
  wait(var_0);
  level._id_58D2 maps\_utility::_id_26FD();
  wait 0.05;
  var_1 = level._id_58D2.goalpos;
  level._id_58D2 setgoalpos(level._id_58D2.origin);
  wait 0.05;
  level._id_58D2 setgoalpos(var_1);
}

_id_59C5() {
  level._id_59C6 = maps\_utility::_id_272C("secret_service_assist");

  foreach(var_1 in level._id_59C6) {}
  var_1 maps\_utility::_id_0D04();

  var_3 = maps\_utility::_id_2640("tarmac_combat_running_agent", "script_noteworthy");
  var_3 thread _id_59C8();
  common_scripts\utility::flag_wait("start_tarmacend_combat");
  level._id_58D2.ignoreall = 0;
  level._id_58D2.ignoreme = 0;
  thread maps\_utility::_id_1425("start_tarmac_combat");
  maps\_utility::_id_265B("axis");
  level.player giveweapon("fraggrenade");
  level.player setoffhandprimaryclass("frag");
  level.player setweaponammoclip("fraggrenade", 0);
  level.player setweaponammostock("fraggrenade", 0);
  level.player setoffhandsecondaryclass("flash");
  level.player giveweapon("flash_grenade");
  level.player setweaponammoclip("flash_grenade", 0);
  level.player setweaponammostock("flash_grenade", 0);
  var_4 = maps\_utility::_id_272C("tarmacrunners");
  var_5 = maps\_utility::_id_272C("tarmacrunners_delete");
  var_6 = getEntArray("tarmacrunners_shgn", "script_noteworthy");

  foreach(var_8 in var_6) {
    if(!isspawner(var_8)) {
      var_8 setgoalentity(level.player);
      break;
    }
  }

  foreach(var_1 in var_5) {}
  var_1.ignoreall = 1;

  thread _id_59D2();
  var_12 = maps\_vehicle::_id_2881("intro_gaz_turret");
  var_12 thread maps\hijack_tarmac::_id_59C7();
  var_12 thread _id_59D5();
  var_13 = undefined;

  foreach(var_1 in var_12._id_0A39) {}
  var_12 thread _id_45E2(var_1, var_12);

  wait 0.25;
  var_16 = maps\_utility::_id_263E("tarmacwave1");

  foreach(var_1 in var_16) {}
  var_1.pathrandompercent = randomintrange(30, 100);

  maps\_audio::aud_send_msg("first_suv");
  wait 10;
  common_scripts\utility::flag_set("tarmac_combat_wave2");
}

_id_59C8() {
  self endon("death");
  var_0 = getent("runner_ak74u", "targetname");
  var_0 hidepart("tag_acog_2");
  var_0 hidepart("tag_eotech");
  var_0 hidepart("tag_hamr_hybrid");
  var_0 hidepart("tag_silencer");
  var_0 hidepart("tag_thermal_scope");
  self._id_1032 = "generic";
  maps\_utility::_id_24F5();
  self.ignoreall = 1;
  self.ignoreme = 1;
  common_scripts\utility::flag_wait("entered_post_tarmac_area");
  wait 2.5;
  var_1 = common_scripts\utility::getstruct("agent_grabs_gun_origin", "targetname");
  var_1 maps\_anim::_id_124A(self, "tarmac_enter_combat_agent");
  var_1 thread maps\_anim::_id_1246(self, "tarmac_enter_combat_agent");
  wait 1.2;
  maps\_utility::_id_257D();
  var_0 delete();
  self waittillmatch("single anim", "end");
  self.ignoreall = 0;
  self.ignoreme = 0;
  var_2 = getnode("agent_post_anim_node", "targetname");
  self setgoalnode(var_2);
  wait 10;
  maps\_utility::_id_13A4("b");
}

_id_59C9() {
  common_scripts\utility::flag_wait("tarmac_combat_wave2");
  thread maps\_utility::_id_1425("wave2_starting");
  var_0 = maps\_vehicle::_id_2881("turret_gaz2");
  var_0 thread maps\hijack_tarmac::_id_59C7();
  var_0 thread _id_59D5();
  var_1 = undefined;

  foreach(var_3 in var_0._id_0A39) {}
  var_0 thread _id_45E2(var_3, var_0);

  var_5 = maps\_utility::_id_272C("tarmacrunners2");
  var_6 = maps\_utility::_id_263E("tarmacwave2");

  foreach(var_3 in var_6) {}
  var_3.pathrandompercent = randomintrange(30, 100);

  maps\_utility::_id_263B("tarmacwave2", 2);
  common_scripts\utility::flag_set("tarmac_combat_wave3");
  wait 10;
  _id_59D3("tarmac_goal", "tarmac_goal_ret");
}

_id_45E2(var_0, var_1) {
  var_0._id_0EC6 = 1;
  var_0._id_259F = 1;
}

_id_59CA() {
  common_scripts\utility::flag_wait("tarmac_combat_wave3");
  thread maps\_utility::_id_1425("wave3_starting");
  _id_59D3("tarmac_goal_ret", "tarmac_goal_ret2");
  var_0 = maps\_vehicle::_id_2881("turret_gaz3");
  var_0 thread maps\hijack_tarmac::_id_59C7();
  var_0 thread _id_59D5();
  var_1 = undefined;

  foreach(var_3 in var_0._id_0A39) {}
  var_0 thread _id_45E2(var_3, var_0);

  foreach(var_3 in level._id_59C6) {}
  var_3 maps\_utility::_id_1902();

  var_7 = maps\_utility::_id_272C("tarmacwave3");

  foreach(var_3 in var_7) {}
  var_3.pathrandompercent = randomintrange(30, 100);

  maps\_utility::_id_263A("tarmacwave3");
  _id_59D3("tarmac_goal_ret2", "tarmac_goal_ret3");
  common_scripts\utility::flag_set("tarmac_combat_wave4");
  var_10 = getent("red_leave_tarmac_combat", "targetname");

  if(isDefined(var_10)) {
    var_10 maps\_utility::_id_2703();

  }
  common_scripts\utility::flag_set("flag_red_leave_tarmac_combat");
  thread maps\_utility::_id_1425("wave3_done");
}

_id_59CB() {
  common_scripts\utility::flag_wait("tarmac_combat_wave4");
  var_0 = maps\_utility::_id_272D("endsceneguys_SUV");

  if(level._id_1F19 != "end_scene") {
    var_1 = maps\_utility::_id_272D("endsceneguys");
    var_0 = common_scripts\utility::array_combine(var_0, var_1);
  }

  thread _id_59CD();
  var_2 = maps\_vehicle::_id_2A99("endsuburban");
  var_2 thread maps\hijack_tarmac::_id_59C7();
  level._id_58D2.ignoresuppression = 1;
  level._id_59CC = getent("endguytarget", "targetname");

  foreach(var_4 in var_0) {
    if(isalive(var_4)) {
      if(var_4._id_2149 == "endsceneguys") {
        var_4 setentitytarget(level._id_59CC);
        var_4 thread _id_59D0(var_0);
      }
    }
  }

  _id_59D3("tarmac_goal_ret", "tarmac_goal_ret2");
  thread _id_59CF(var_0);
  maps\_utility::_id_263A("endsceneguys");
  wait 1;
  common_scripts\utility::flag_set("endguys_dead");
}

_id_59CD() {
  maps\_utility::_id_263A("endtarmacguys1");
  var_0 = getent("red_leave_tarmac_combat2", "targetname");
  var_1 = getent("red_leave_tarmac_combat", "targetname");

  if(isDefined(var_0)) {
    var_0 maps\_utility::_id_2703();

  }
  level._id_58D2.ignoreall = 1;

  if(isDefined(var_1)) {
    var_1 common_scripts\utility::trigger_off();
  }
}

_id_59CE() {
  var_0 = getent("combat_scene_fail_trigger", "targetname");
  common_scripts\utility::flag_wait("tarmac_combat_level_fail");
  setdvar("ui_deadquote", &"HIJACK_FAIL_TARMAC");
  level notify("mission failed");
  maps\_utility::_id_1826();
}

_id_59CF(var_0) {
  common_scripts\utility::flag_wait("kill_final_enemies");
  thread cleanup_tarmac();

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      magicbullet("AK74u", level._id_59A2 gettagorigin("tag_weapon"), var_2.origin + (0, 0, 36));
      wait 0.05;
      magicbullet("AK74u", level._id_59A2 gettagorigin("tag_weapon"), var_2.origin + (0, 0, 36));
      wait 0.05;
      magicbullet("AK74u", level._id_59A2 gettagorigin("tag_weapon"), var_2.origin + (0, 0, 36));
      wait 0.05;
      magicbullet("AK74u", level._id_59A2 gettagorigin("tag_weapon"), var_2.origin + (0, 0, 36));
      wait 0.05;
      var_2 kill();
    }

    wait 0.5;
  }
}

cleanup_tarmac() {
  var_0 = getaiarray("axis");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] kill();
  }
}

_id_59D0(var_0) {
  for(;;) {
    self waittill("damage", var_1, var_2);
    level._id_58D2.ignoreall = 0;

    if(isDefined(var_2) && isplayer(var_2)) {
      foreach(var_4 in var_0) {
        if(isDefined(var_4) && isalive(var_4)) {
          var_4 clearentitytarget(level._id_59CC);
        }
      }

      break;
    }
  }
}

_id_59D1() {
  maps\_utility::_id_11F4("hijack_fso4_heavyfire");
  level notify("commander_react_to_combat");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_wehavetomove");
  maps\_utility::_id_11F4("hijack_fso4_notsecure");
  level notify("commander_call_to_combat");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_getalenaout");
  common_scripts\utility::flag_wait("tarmac_combat_wave2");
  wait 1.0;
  maps\_utility::_id_11F4("hijack_fso1_nearhangar");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_letsmoveit");
  common_scripts\utility::flag_wait("tarmac_combat_wave3");
  wait 1.5;
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_keeppushing2");
  common_scripts\utility::flag_wait("tarmac_combat_wave4");
  wait 2.0;
  maps\_utility::_id_11F4("hijack_fso2_multiplewounded");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_moveupmoveup");
  maps\_utility::_id_11F4("hijack_fso3_critical");
  wait 2.0;
  _id_599B();
}

_id_599B() {
  maps\_utility::_id_11F4("hijack_fso3_codeblack");
  common_scripts\utility::flag_wait("player_approaching_end_guys");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_takethemdown");
  common_scripts\utility::flag_wait("player_entered_end_area");
  level._id_58D2 maps\_utility::_id_168C("hijack_cmd_holdyourfire");
}

_id_59D2() {
  var_0 = getent("tarmacrunners_goal2", "targetname");

  for(;;) {
    wait 1;
    var_1 = var_0 maps\_utility::_id_2789("axis");

    foreach(var_3 in var_1) {
      if(isDefined(var_3) && isalive(var_3) && isDefined(var_3.script_noteworthy)) {
        if(var_3.script_noteworthy == "tarmacrunners_goal2") {
          var_3 delete();
        }
      }
    }
  }
}

_id_59D3(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = var_2 maps\_utility::_id_2789("axis");
  var_4 = getent(var_1, "targetname");
  var_5 = getnode(var_4.target, "targetname");

  foreach(var_7 in var_3) {
    if(isDefined(var_7) && isalive(var_7)) {
      var_7.fixednode = 0;
      var_7.pathrandompercent = randomintrange(75, 100);
      var_7 setgoalnode(var_5);
      var_7 setgoalvolume(var_4);
    }
  }
}

_id_59D4(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 3;

  }
  if(!isDefined(var_1)) {
    var_1 = 0;

  }
  self.ignoreall = 1;
  self clearenemy();

  if(var_0 == -1) {
    self waittill("goal");
  } else {
    wait(var_0);

  }
  if(isDefined(self) && isalive(self)) {
    if(var_1) {
      self delete();
      return;
    }

    self.ignoreall = 0;
    maps\_utility::_id_2713();
  }
}

_id_59D5() {
  self waittill("death");
  maps\_audio::aud_send_msg("suv_explosion");
  maps\_utility::play_sound_on_entity("hijk_suv_explosion");
}