/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_rooftop_combat.gsc
******************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_rt2_combat_start");
  common_scripts\utility::flag_init("flag_rt2_combat_fin");
  common_scripts\utility::flag_init("flag_rt2_combat_retreat");
  common_scripts\utility::flag_init("flag_rt3_combat_mid");
  common_scripts\utility::flag_init("flag_rt3_combat_end");
  common_scripts\utility::flag_init("flag_rt3_combat_fin");
  common_scripts\utility::flag_init("flag_rooftops_fight_end");
  common_scripts\utility::flag_init("flag_rooftops_combat_done");
  common_scripts\utility::flag_init("flag_rooftops_end");
  common_scripts\utility::flag_init("flag_loco_ready");
  common_scripts\utility::flag_init("flag_rt3_ally_at_end");
}

section_

section_post_inits() {
  thread setup_spawners();
}

start() {
  iprintln("rooftop combat");
  var_0 = getent("rt_combat_start_player", "targetname");
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  var_1 = getent("rt_helo_crash_ally", "targetname");
  level._ally forceteleport(var_1.origin, var_1.angles);
  level._ally thread maps\_utility::enable_careful();
  level._ally thread maps\_utility::set_grenadeammo(0);
  level._ally thread maps\_utility::set_force_color("r");
  getent("rt2_color_start", "targetname") notify("trigger");
  thread maps\skyway_fx::fx_turnon_loco_exterior_lights();
  common_scripts\utility::flag_set("flag_helo_end");
  var_2 = ["train_rt0", "train_rt1", "train_rt2"];

  foreach(var_4 in var_2)
  common_scripts\utility::array_call(level._train.cars[var_4].trigs, ::setmovingplatformtrigger);
}

main() {
  var_0 = ["train_rt3"];

  foreach(var_2 in var_0)
  common_scripts\utility::array_call(level._train.cars[var_2].trigs, ::setmovingplatformtrigger);

  thread hesh_killer_tracker_enabler();
  rt_combat();
  rt_run();
  maps\_utility::clearthreatbias("player", "axis");

  if(isDefined(level.old_goalradius))
    level.default_goalradius = level.old_goalradius;
}

hesh_killer_tracker_enabler() {
  level._ally flag_set_near_ent("flag_killer_tracker", level._train.cars["train_rt2"].sus_b, 1024);
  level.killer_tracker = 0;
}

rt_combat() {
  common_scripts\utility::flag_wait("flag_rt1_combat_start");
  thread rt_achievement_grapple_kill(2, "rt_grapple_kill");
  maps\_utility::array_spawn_targetname("rt2_opfor_start");
  thread rt_combat_fic();
  common_scripts\utility::flag_wait("flag_rt2_combat_start");
  setthreatbias("axis", "player", 250);
  wait 0.05;
  maps\_utility::array_spawn_targetname("rt2_opfor_rope");
  maps\_utility::flood_spawn(getEntArray("rt2_opfor", "targetname"));
  maps\skyway_util::delay_retreat("rt_opfor", maps\skyway_util::kt_time(60), -4, "flag_rt2_combat_retreat", ["rt2_color_fin", "rt2_color_end"], 1);
  getent("rt3_color_rt2", "targetname") notify("trigger");
  maps\_spawner::killspawner(320);
  maps\_utility::flood_spawn(getEntArray("rt3_opfor", "targetname"));
  wait 1;
  maps\skyway_util::delay_retreat("rt_opfor", maps\skyway_util::kt_time(90), 2, "flag_rt3_combat_fin", ["rt3_color_mid", "rt3_color_start"], 1);
  level._ally thread flag_set_near_ent("flag_rt3_ally_at_end", level._train.cars["train_rt3"].sus_f, 420);
  maps\_utility::flagwaitthread("flag_rooftops_combat_done", common_scripts\utility::flag_set, "flag_rooftops_fight_end");
  maps\skyway_util::delay_retreat("rt_opfor", maps\skyway_util::kt_time(75), 0, "flag_rooftops_fight_end");
  var_0 = getent("rt3_color_end", "targetname");

  if(isDefined(var_0))
    var_0 delete();
}

rt_follow_path_and_die(var_0) {
  self endon("death");

  if(distance(self.origin, level._train.cars["train_rt3"].sus_f.origin) > 800)
    self kill();

  maps\_utility::follow_path(var_0);
  self kill();
}

rt_achievement_grapple_kill(var_0, var_1) {
  level endon("stop_achievement_grapple_kill");

  if(!isDefined(level.kill_count[var_1]))
    level.kill_count[var_1] = 0;

  while(level.kill_count[var_1] < var_0)
    level waittill(var_1);

  level.player maps\_utility::player_giveachievement_wrapper("LEVEL_18A");
}

rt_run() {
  thread rt_run_fic();
  level notify("notify_stop_ambient_rogs");
  level._ally thread maps\_utility::disable_careful();
  level._ally thread maps\_utility::disable_ai_color();

  if(!common_scripts\utility::flag("flag_rt3_ally_at_end"))
    level._ally thread maps\_utility::follow_path(getnode("rt3_node_run_center", "targetname"));
  else
    level._ally thread maps\_utility::follow_path(getnode("rt3_node_run_sides", "targetname"));

  if(!issubstr(level._ally.weapon, "k7"))
    level._ally maps\_utility::place_weapon_on("k7+eotechsmg_sp", "right");

  common_scripts\utility::flag_wait("flag_rooftops_end");
}

rt_run_cleanup_proc() {
  common_scripts\utility::flag_wait("flag_rooftops_combat_done");

  while(level.player.car != "train_loco")
    wait 0.05;

  level notify("stop_achievement_grapple_kill");
  maps\_utility::clearthreatbias("axis", "player");
  var_0 = getnode("rt3_node_hide", "targetname");
  var_1 = getaiarray("axis");
  var_1 = common_scripts\utility::array_remove_array(var_1, common_scripts\utility::array_add(maps\_utility::get_ai_group_ai("rt_helo_opfor"), level._boss));

  if(isDefined(var_1) && isarray(var_1) && var_1.size > 0) {
    common_scripts\utility::array_thread(var_1, maps\_utility::set_ignoreall, 1);
    common_scripts\utility::array_thread(var_1, ::rt_follow_path_and_die, var_0);
  }

  if(distance2d(level._ally.origin, level._train.cars["train_rt3"].sus_f.origin) < 1500) {
    return;
  }
  level._ally unlink();
  level._ally teleportentityrelative(level._ally, getent("rt_tele_end_run_ally", "targetname"));
  level._ally dontinterpolate();

  if(!common_scripts\utility::flag("flag_loco_started"))
    level._ally thread maps\_utility::follow_path(getnode("loco_breach_ally_cover_node", "targetname"));
}

rt_combat_fic() {
  if(!common_scripts\utility::flag("flag_helo_end"))
    level._ally maps\_utility::smart_dialogue("skyway_hsh_whereareyougoing");
  else {
    wait 3;
    level._ally maps\_utility::smart_dialogue("skyway_hsh_theyreropingupthe");
  }

  common_scripts\utility::flag_wait("flag_rt2_combat_retreat");
  wait 1;
  level._ally maps\_utility::smart_dialogue("skyway_hsh_wegottakeepmoving");
}

rt_run_fic() {
  wait 0.25;
  var_0 = ["skyway_hsh_cleargettothe", "skyway_hsh_clearletsgetthis"];
  level._ally maps\_utility::smart_dialogue(var_0[randomint(var_0.size)]);
  common_scripts\utility::flag_wait("flag_rooftops_end");

  if(!common_scripts\utility::flag("flag_rt3_ally_at_end"))
    level._ally maps\_utility::smart_dialogue("skyway_hsh_wereatthelast");

  level._ally maps\_utility::smart_dialogue("skyway_hsh_rorkespinnedheknows");
  common_scripts\utility::flag_set("flag_loco_ready");
}

setup_spawners() {
  maps\_utility::array_spawn_function_targetname("rt2_opfor", maps\skyway_util::spawnfunc_death_override);
  maps\_utility::array_spawn_function_targetname("rt2_opfor_start", maps\skyway_util::spawnfunc_death_override);
  maps\_utility::array_spawn_function_targetname("rt2_opfor_rope", maps\skyway_util::spawnfunc_death_override);
  maps\_utility::array_spawn_function_targetname("rt3_opfor", maps\skyway_util::spawnfunc_death_override);
  maps\_utility::array_spawn_function_targetname("rt3_opfor_rope_l", maps\skyway_util::spawnfunc_death_override);
  maps\_utility::array_spawn_function_targetname("rt3_opfor_rope_r", maps\skyway_util::spawnfunc_death_override);
  maps\_utility::array_spawn_function_targetname("rt2_opfor", ::opfor_infil);
  maps\_utility::array_spawn_function_targetname("rt2_opfor", ::rt_spawn_node_check, "flag_rt2_combat_retreat", "rt3_node_mid");
  maps\_utility::array_spawn_function_targetname("rt2_opfor_start", ::opfor_rope, level._train.cars["train_rt2"].body, undefined, "rt_grapple_kill");
  maps\_utility::array_spawn_function_targetname("rt2_opfor_rope", ::opfor_rope, level._train.cars["train_rt2"].body, undefined, "rt_grapple_kill");
  maps\_utility::array_spawn_function_targetname("rt3_opfor", ::opfor_infil);
  maps\_utility::array_spawn_function_targetname("rt3_opfor", ::rt_spawn_node_check, ["flag_rt3_combat_fin", "flag_rt3_combat_end", "flag_rt3_combat_mid"], ["rt3_node_fin", "rt3_node_end", "rt3_node_mid"]);
  maps\_utility::array_spawn_function_targetname("rt3_opfor_rope_l", ::opfor_rope, getent("rt3_anim_grapple", "targetname"), "tag_origin");
  maps\_utility::array_spawn_function_targetname("rt3_opfor_rope_r", ::opfor_rope, getent("rt3_anim_grapple", "targetname"), "tag_origin");
}

rt_spawn_node_check(var_0, var_1) {
  self endon("death");

  if(isDefined(self.script_wtf))
    self waittill("infil_done");

  if(!isarray(var_0))
    var_0 = [var_0];

  if(!isarray(var_1))
    var_1 = [var_1];

  var_2 = int(max(0, min(var_0.size, var_1.size) - 1));

  for(var_3 = var_2; var_3 >= 0; var_3--) {
    if(isDefined(var_0[var_3]) && common_scripts\utility::flag(var_0[var_3])) {
      thread maps\_utility::follow_path(getnode(var_1[var_3], "targetname"));
      break;
    }
  }
}

opfor_rope(var_0, var_1, var_2) {
  self endon("death");
  self endon("rope_death");

  if(!isDefined(self.script_index)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = "j_spineupper";

  thread rt_inc_kill_count(var_2);
  maps\_utility::set_ignoreall(1);
  var_3 = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
  wait 0.1;
  self.animname = "sw_opfor_grapple_" + maps\_utility::string(self.script_index);
  self linkto(var_0, var_1, (0, 0, 0), (0, 0, 0));
  var_4 = maps\_utility::spawn_anim_model("sw_rope_grapple_" + maps\_utility::string(self.script_index));
  var_4 linkto(var_0, var_1, (0, 0, 0), (0, 0, 0));
  maps\_utility::set_deathanim("sw_grapple_up_death");
  thread rt_falling_death();
  var_0 thread maps\_anim::anim_single_solo(var_4, "sw_grapple_up", var_1);
  var_0 maps\_anim::anim_single_solo(self, "sw_grapple_up", var_1, 0.1);

  if(isDefined(var_2)) {
    self notify(var_2);
    level notify(var_2);
  }

  maps\_utility::clear_deathanim();
  self notify("no_falling_death");
  self unlink();
  wait 1;
  maps\_utility::set_ignoreall(0);
  self.newenemyreactiondistsq = var_3;
}

opfor_infil() {
  self endon("death");

  if(!isDefined(self.script_wtf)) {
    return;
  }
  maps\_utility::set_ignoreall(1);
  var_0 = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
  var_1 = get_entry(getEntArray(self.script_wtf, "targetname"));
  var_1 maps\_utility::assign_animtree(var_1.script_namenumber);
  thread infil_entry_lock(var_1);
  wait 0.1;
  var_2 = var_1.script_namenumber + "_opfor";
  self.allowdeath = 1;
  self linkto(var_1);
  var_1 thread maps\_anim::anim_single_solo(var_1, "sw_entry_u");
  var_1 maps\_anim::anim_single_solo(self, "sw_entry_u", undefined, 0.1, var_2);
  self unlink();
  self notify("infil_done");
  wait 1;
  maps\_utility::set_ignoreall(0);
  self.newenemyreactiondistsq = var_0;
}

rt_falling_death() {
  self endon("no_falling_death");
  self.allowdeath = 1;
  self waittill("death");
  self unlink();
}

rt_inc_kill_count(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self endon(var_0);
  self waittill("death");
  level.kill_count[var_0] = level.kill_count[var_0] + 1;
  level notify(var_0);
}

get_entry(var_0) {
  self endon("death");

  for(;;) {
    var_1 = var_0[randomint(var_0.size)];

    if(randomint(100) < var_1.script_index && !maps\skyway_util::istrue(var_1.in_use))
      return var_1;

    wait 0.05;
  }
}

infil_entry_lock(var_0) {
  var_0.in_use = 1;
  common_scripts\utility::waittill_any("death", "infil_done");
  wait 0.5;
  var_0.in_use = undefined;
}

flag_set_near_ent(var_0, var_1, var_2) {
  level endon(var_0);
  self endon("stop_dist_flag");

  if(!isDefined(var_2))
    var_2 = 300;

  while(distance(var_1.origin, self.origin) > var_2)
    wait 0.05;

  common_scripts\utility::flag_set(var_0);
}

rt_brief_reprieve(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = [0, 36000];

  if(!isarray(var_0))
    var_0 = [0, var_0];

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2)) {
    common_scripts\utility::flag_init("flag_rt_brief_reprieve");
    var_2 = "flag_rt_brief_reprieve";
  }

  var_0 = var_0[0] + randomfloat(var_0[1] - var_0[0]);

  while(var_0[1] > 0 && !common_scripts\utility::flag(var_2) && !maps\_utility::players_within_distance(var_1, self.origin)) {
    var_0 = var_0 - 0.05;
    wait 0.05;
  }
}

ignore_run(var_0, var_1) {
  self endon("death");
  self notify("stop_ignore_run");
  self endon("stop_ignore_run");

  if(!isDefined(var_0))
    var_0 = 1.0;

  self.old = [];
  self.old["react_dist"] = self.newenemyreactiondistsq;
  self.old["color"] = maps\_utility::get_force_color();
  self.old["moveplaybackrate"] = self.moveplaybackrate;
  self.old["grenade_aware"] = self.grenadeawareness;
  thread maps\_utility::set_moveplaybackrate(var_0, 0.25);
  maps\_utility::set_ignoreall(1);
  self pushplayer(1);
  self.a.disablepain = 1;
  self.allowpain = 0;
  self.disablebulletwhizbyreaction = 1;
  self.disablefriendlyfirereaction = 1;
  self.disableplayeradsloscheck = 1;
  self.dodangerreact = 0;
  self.dontavoidplayer = 1;
  self.dontmelee = 1;
  self.flashbangimmunity = 1;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.newenemyreactiondistsq = 0;

  if(isDefined(var_1)) {
    self waittill(var_1);
    stop_ignore_run();
  }
}

stop_ignore_run() {
  self endon("death");
  self notify("stop_ignore_run");

  if(!isDefined(self.old)) {
    self.old = [];
    self.old["react_dist"] = 262144;
    self.old["color"] = "r";
    self.old["moveplaybackrate"] = 1;
    self.old["grenade_aware"] = 0.9;
  }

  maps\_utility::set_ignoreall(0);
  self pushplayer(0);
  self.a.disablepain = 0;
  self.allowpain = 1;
  self.disablebulletwhizbyreaction = undefined;
  self.disablefriendlyfirereaction = undefined;
  self.disableplayeradsloscheck = 0;
  self.dodangerreact = 1;
  self.dontavoidplayer = 0;
  self.dontmelee = undefined;
  self.flashbangimmunity = undefined;
  self.grenadeawareness = self.old["grenade_aware"];
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.newenemyreactiondistsq = self.old["react_dist"];
  maps\_utility::set_moveplaybackrate(self.old["moveplaybackrate"]);
  maps\_utility::set_force_color(self.old["color"]);
}