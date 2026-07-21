/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\lab\lab_pipes.gsc
***********************************************/

pipes_outdoor_postload() {
  scripts\engine\utility::flag_init("switch_to_kyle");
  scripts\engine\utility::flag_init("sniper_targeting_player");
  scripts\engine\utility::flag_init("sniper_killed");
  scripts\engine\utility::flag_init("rpg_on_the_move");
  scripts\engine\utility::flag_init("reverse_breach_start");
  scripts\engine\utility::flag_init("heli_intro");
  scripts\engine\utility::flag_init("heli_intro_wait");
  scripts\engine\utility::flag_init("clear_parking_ai");
  scripts\engine\utility::flag_init("parking_lot_clear");
  scripts\engine\utility::flag_init("reverse_breach_guys_dead");
  scripts\engine\utility::flag_init("final_guards_a");
  scripts\engine\utility::flag_init("final_guards_b");
  scripts\engine\utility::flag_init("jumpdown_scene_over");
  scripts\engine\utility::flag_init("rpg_right_dead");
  scripts\engine\utility::flag_init("pipes_bomb_planted");
  thread pipes_jumpdown_lights_init();
}

pipes_jumpdown_lights_init() {
  var_0 = getEntArray("pipes_jumpdown_lights", "targetname");

  foreach(var_2 in var_0) {
    var_2.og_intensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }
}

pipes_outdoor_preload() {
  precachemodel("offhand_wm_c4_bomb");
  precachemodel("offhand_wm_c4");
}

setup_post_cinematic() {
  scripts\engine\sp\utility::add_global_spawn_function("allies", scripts\sp\maps\lab\lab_util.gsc::allies_molotov_toggle, 1);
  scripts\sp\maps\lab\lab_util.gsc::spawn_team_price();
  thread kyle_loadout();
  var_0 = scripts\engine\utility::getStruct("pipes_jumpdown_struct", "targetname");
  var_0 scripts\sp\player_rig::link_player_to_rig("pipes_jumpdown", "crouch", 0, undefined, 1, 0, 0, 0, 0);
  level.kyle scripts\engine\sp\utility::name_hide();
  level.player thread scripts\sp\player::player_movement_state("default");
  level.player modifybasefov(50, 0.05);
  level.player enableinvulnerability();
  level.player playerdisabletriggers();
  level.player cleardamageindicators();
  level.player hidelegsandshadow();
  level.player hideviewmodel();
  wait 0.3;
  level.player notify("post_bink_setup_finished");
}

pipes_jumpdown_start() {
  scripts\engine\sp\utility::add_global_spawn_function("allies", scripts\sp\maps\lab\lab_util.gsc::allies_molotov_toggle, 1);
  scripts\sp\maps\lab\lab_util.gsc::spawn_team_price();
  thread kyle_loadout();
  var_0 = scripts\engine\utility::getStruct("pipes_jumpdown_struct", "targetname");
  var_0 scripts\sp\player_rig::link_player_to_rig("pipes_jumpdown", "crouch", 0, undefined, 1, 0, 0, 0, 0);
  level.kyle scripts\engine\sp\utility::name_hide();
  level.player thread scripts\sp\player::player_movement_state("default");
  level.player modifybasefov(50, 0.05);
  level.player enableinvulnerability();
  level.player playerdisabletriggers();
  level.player cleardamageindicators();
  level.player hidelegsandshadow();
  level.player hideviewmodel();
  hidecinematicletterboxing(0, 0);
}

pipes_jumpdown_main() {
  thread fix_door_clip();
  level.player clearclienttriggeraudiozone(0.5);
  thread enable_pipes_jumpdown_lights();
  setmusicstate("mx_lab_pricekyle_infil");
  scripts\engine\utility::delaythread(0.3, scripts\engine\sp\utility::autosave_now);
  scripts\engine\sp\utility::set_start_location("pipes_outdoor_start", [level.price, level.rebel_1, level.rebel_2, level.rebel_3]);
  scripts\engine\utility::flag_set("ambush_end");
  var_0 = scripts\engine\utility::getStruct("sniper_scene", "targetname");
  level thread sniper_intro(var_0);
  thread pipes_sniper_setup();
  scripts\engine\utility::delaythread(12, ::pipes_moments_setup);
  pipes_jumpdown_scene();
  thread remove_pipes_jumpdown_lights();
  scripts\engine\sp\utility::autosave_by_name("pipes_jumpdown");
}

fix_door_clip() {
  var_0 = getEntArray("jumpdown_doors", "targetname");
  var_1 = getEnt(var_0[0].target, "targetname");
  var_1 unlink();
  var_1.origin = (-1282.79, -2235.51, -50);
  var_1.angles = (0, 45, 0);
  var_2 = getEnt(var_0[1].target, "targetname");
  var_2 unlink();
  var_2.origin = (-1311.79, -2207.51, -50);
  var_2.angles = (0, 45, 0);
}

enable_pipes_jumpdown_lights() {
  var_0 = getEntArray("pipes_jumpdown_lights", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2.og_intensity);
}

remove_pipes_jumpdown_lights() {
  var_0 = getEntArray("pipes_jumpdown_lights", "targetname");

  foreach(var_2 in var_0)
  var_2 thread scripts\sp\lights::lerp_intensity(0, 1.5);

  wait 1.6;

  foreach(var_2 in var_0)
  var_2 delete();
}

pipes_jumpdown_catchup() {
  scripts\engine\utility::flag_set("ambush_end");
  scripts\engine\utility::flag_set("jumpdown_scene_over");
  scripts\sp\maps\lab\lab_util.gsc::setplayerviewmodel("viewhands_kyle_sas_urban", "viewhands_base_legs_iw8", "default_character_shadow");
  scripts\sp\utility::context_melee_set_arms("viewhands_kyle_sas_urban");
  scripts\engine\sp\utility::add_global_spawn_function("allies", scripts\sp\maps\lab\lab_util.gsc::allies_molotov_toggle, 1);
  thread fix_door_clip();
}

pipes_moments_setup() {
  thread rpg_left_spawn();
  thread rpg_right_spawn();
  thread pipes_to_hallway();
}

rpg_impact(var_0) {
  var_0 waittill("explode", var_1);

  if(isDefined(var_1))
    thread scripts\engine\sp\utility::earthquake_and_rumble(var_1);
}

#using_animtree("generic_human");

rpg_left_spawn() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("rooftop_rpg_left", 1);
  var_1 = scripts\engine\utility::getStruct("pipes_rpg_left_struct", "targetname");
  var_2 = scripts\engine\utility::getStructArray("pipes_rpg_left_struct_lookat", "targetname");
  var_0 endon("death");
  level.scr_anim["generic"]["rpg_reload"] = % rpg_stand_reload;
  var_0.goalradius = 4;
  var_0.dontevershoot = 1;
  var_0.fixednode = 1;
  var_0.dropweapon = 0;
  var_3 = spawn("script_origin", var_1.origin);
  var_0.ignoreme = 1;
  var_0 setentitytarget(var_3);
  var_3 dontinterpolate();
  scripts\engine\utility::flag_wait("jumpdown_scene_over");
  var_4 = cos(65);

  while(!var_2 rpg_left_fov_checks(var_4))
    waitframe();

  thread rpg_left_allies();
  wait 2;
  var_5 = var_0.origin + (0, 0, 45) + anglesToForward(var_0.angles) * 35;
  var_6 = magicbullet("iw8_la_rpapa7_straight_slow", var_5, var_1.origin);
  thread rpg_impact(var_6);
  wait 2;
  level.price thread scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_final_pipes_combat_50");
  var_0 scripts\common\anim::anim_generic(var_0, "rpg_reload");
  var_0.dontevershoot = 0;
  var_0 clearentitytarget();
  var_3 delete();
  wait 3;
  level.price thread scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_final_pipes_combat_40");
}

rpg_left_fov_checks(var_0) {
  foreach(var_2 in self) {
    if(scripts\sp\maps\lab\lab_util.gsc::in_player_fov(var_0, var_2.origin))
      return 1;
  }

  return 0;
}

rpg_left_allies() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("pipes_rpg_left_target", 1, 1);

  foreach(var_2 in var_0)
  var_2.fixednode = 1;
}

rpg_right_spawn() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("rooftop_rpg_right");
  var_0 thread scripts\engine\sp\utility::flag_on_death("rpg_right_dead");
  var_0 endon("death");
  var_1 = scripts\engine\utility::getStruct("pipes_rpg_right_struct", "targetname");
  var_2 = scripts\engine\utility::getStructArray("pipes_rpg_right_struct_lookat", "targetname");
  level.scr_anim["generic"]["rpg_reload"] = % rpg_stand_reload;
  var_0.goalradius = 4;
  var_0.dontevershoot = 1;
  var_0.fixednode = 1;
  var_0.dropweapon = 0;
  var_3 = spawn("script_origin", var_1.origin);
  var_0.ignoreme = 1;
  var_0 setentitytarget(var_3);
  var_3 dontinterpolate();
  scripts\engine\utility::flag_wait("jumpdown_scene_over");
  rpg_right_allies();
  var_2 right_rpg_fov_checks(var_1, var_0);
  scripts\engine\utility::flag_set("rpg_on_the_move");
  level notify("rpg_right_start_moving");
  var_4 = var_0.origin + (0, 0, 45) + anglesToForward(var_0.angles) * 35;
  var_5 = magicbullet("iw8_la_rpapa7_straight_slow", var_4, var_1.origin);
  thread rpg_impact(var_5);
  wait 0.5;
  var_0 scripts\common\anim::anim_generic(var_0, "rpg_reload");
  var_0.dontevershoot = 0;
  var_0 clearentitytarget();
  var_3 delete();
}

right_rpg_fov_checks(var_0, var_1) {
  level endon("rush_right_rpg");
  var_2 = squared(500);
  var_3 = cos(45);

  while(!scripts\engine\utility::flag("rush_right_rpg")) {
    if(self[0] check_lookat(var_3) || self[1] check_lookat(var_3) && distancesquared(level.player.origin, var_0.origin) <= var_2 || var_1 check_lookat_guy(var_3)) {
      break;
    }

    waitframe();
  }
}

check_lookat(var_0) {
  if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_0) && scripts\engine\trace::ray_trace_passed(level.player getEye(), self.origin, [level.player]))
    return 1;
  else
    return 0;
}

check_lookat_guy(var_0) {
  if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self getEye(), var_0) && scripts\engine\trace::ray_trace_passed(level.player getEye(), self getEye(), [level.player, self]))
    return 1;
  else
    return 0;
}

rpg_right_allies() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("pipes_rpg_right_target", 1, 1);

  foreach(var_2 in var_0) {
    var_2 scripts\common\ai::magic_bullet_shield();
    var_2.fixednode = 1;
    var_2 thread rpg_right_allies_post();
  }
}

rpg_right_allies_post() {
  level scripts\engine\utility::waittill_any("rpg_right_start_moving", "rpg_right_dead");
  scripts\common\ai::stop_magic_bullet_shield();
}

jumpdown_cameradofsettings() {
  level thread scripts\engine\sp\utility::dof_enable(2.8, 600, 400, 400);
  wait 1;
  level.kyle thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 10, undefined, undefined, "tag_eye");
  wait 2.5;
  level thread scripts\engine\sp\utility::dof_enable(2.8, 600, 2, 400);
  wait 2;
  level.kyle thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 3, undefined, undefined, "tag_eye");
  wait 6.5;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 5, undefined, undefined, "tag_eye");
  wait 2;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
}

pipes_jumpdown_scene() {
  level.player freezecontrols(1);
  var_0 = scripts\engine\utility::getStruct("pipes_jumpdown_struct", "targetname");
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level.player_rig hide();
  scripts\engine\utility::delaythread(0.8, scripts\engine\sp\utility::activate_trigger_with_targetname, "pipes_jumpdown_trigger");
  thread scripts\engine\utility::flag_set_delayed("sniper_intro", 4.5);
  thread jumpdown_cameradofsettings();
  thread pipes_fake_sniper_fire();
  var_0 thread scripts\common\anim::anim_single_solo(level.price, "pipes_jumpdown");
  var_0 thread scripts\common\anim::anim_single_solo(level.kyle, "pipes_jumpdown");
  level.player dontinterpolate();
  var_0 scripts\common\anim::anim_single_solo(level.player_rig, "pipes_jumpdown");
  var_1 = getnode("pipes_price_node", "targetname");
  level.price setgoalnode(var_1);
  scripts\engine\utility::flag_set("jumpdown_scene_over");
  level.kyle scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();
  level.player scripts\common\utility::allow_stand(1, "player_rig");
  level.player scripts\common\utility::allow_prone(1, "player_rig");
  level.player scripts\common\utility::allow_offhand_weapons(1, "player_rig");
  level.player scripts\common\utility::allow_sprint(1, "player_rig");
  level.player scripts\common\utility::allow_jump(1, "player_rig");
  level.player scripts\common\utility::allow_armor(1, "player_rig");
  level.player scripts\common\utility::allow_mantle(1, "player_rig");
  level.player scripts\common\utility::allow_melee(1, "player_rig");
  level.player unlink();
  level.player setstance("crouch", 1, 1, 1);
  var_2 = scripts\engine\utility::drop_to_ground(level.player getEye(), 0, -60);
  level.player setOrigin(var_2, 1);
  level.player disableinvulnerability();
  level.player freezecontrols(0);
  level.player showlegsandshadow();
  level.player playerenabletriggers();
  level.player showviewmodel();
  level.player_rig delete();
  level.player scripts\common\utility::allow_cinematic_motion(1);
}

pipes_fake_sniper_fire() {
  var_0 = scripts\engine\utility::getStruct("pipes_sniper_target", "targetname");
  level.fakesniper.desiredaimpos = var_0.origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 0.05);
  wait 0.2;
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  level.fakesniper.desiredaimpos = var_1.origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 1, 0.5, 0.1);
  level.fakesniper.laser laserforceon();
  wait 1.4;
  magicbullet("iw8_sn_alpha50", level.fakesniper.origin, var_1.origin);
  level.fakesniper.laser scripts\engine\utility::delaycall(0.3, ::laserforceoff);
  wait 1.4;
  level.fakesniper.desiredaimpos = var_2.origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 1, 0.4, 0.3);
  level.fakesniper.laser scripts\engine\utility::delaycall(0.2, ::laserforceon);
  wait 1.2;
  magicbullet("iw8_sn_alpha50", level.fakesniper.origin, var_2.origin);
  level.fakesniper.laser scripts\engine\utility::delaycall(0.4, ::laserforceoff);
  wait 1.5;
  level.fakesniper.desiredaimpos = var_3.origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 1.5, 0.5, 0.5);
  level.fakesniper.laser scripts\engine\utility::delaycall(1.2, ::laserforceon);
  wait 2;
  magicbullet("iw8_sn_alpha50", level.fakesniper.origin, var_3.origin);
  level.fakesniper.laser scripts\engine\utility::delaycall(0.3, ::laserforceoff);
  wait 1.4;
  level.fakesniper.desiredaimpos = var_4.origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 1.5, 0.5, 0.5);
  level.fakesniper.laser scripts\engine\utility::delaycall(1.2, ::laserforceon);
  wait 2;
  magicbullet("iw8_sn_alpha50", level.fakesniper.origin, var_4.origin);
  level.fakesniper.laser scripts\engine\utility::delaycall(0.3, ::laserforceoff);
}

pipes_outdoor_start() {
  thread scripts\sp\analytics::analytics_kleenex_update("pipes_stopwatch");
  scripts\sp\maps\lab\lab_util.gsc::spawn_team_price();
  thread kyle_loadout();
  thread pipes_sniper_setup();
  thread pipes_moments_setup();
  var_0 = scripts\engine\utility::getStruct("sniper_scene", "targetname");
  level thread sniper_intro(var_0);
  scripts\engine\sp\utility::set_start_location("pipes_outdoor_start", [level.player, level.price, level.rebel_1, level.rebel_2, level.rebel_3]);
  scripts\engine\sp\utility::activate_trigger_with_targetname("pipes_jumpdown_trigger");
}

pipes_outdoor_main() {
  thread vo_pipes_outdoor();
  scripts\engine\sp\utility::array_spawn_targetname("pipe_outdoor_guys", 1, 1);
  thread stackup_when_clear();
  thread ai_saftey_nets();
  scripts\engine\sp\utility::transient_load("lab_finale_tr");
}

pipes_sniper_setup() {
  level.sniper = scripts\engine\sp\utility::spawn_targetname("pipe_sniper", 1);
  level.sniper thread sniper_death_func();
}

pipes_to_hallway() {
  var_0 = scripts\engine\utility::getStruct("pipes_exit_door_struct", "targetname");
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SCRIPT/DOOR_HINT_USE", 45, 200, 55, 0);
  scripts\engine\utility::flag_wait("reverse_breach_start");

  if(isDefined(level.fakesniper))
    level.fakesniper notify("kill_sniper");

  var_1 = scripts\engine\utility::getStructArray("reverse_breach_struct", "targetname");
  var_2 = cos(60);
  var_3 = squared(100);

  for(;;) {
    var_4 = distancesquared(level.player.origin, var_1[0].origin);
    var_5 = distancesquared(level.player.origin, var_1[1].origin);

    if(scripts\sp\maps\lab\lab_util.gsc::in_player_fov(var_2, var_1[0].origin, [level.player]) || scripts\sp\maps\lab\lab_util.gsc::in_player_fov(var_2, var_1[1].origin, [level.player])) {
      break;
    } else if(var_4 <= var_3 || var_5 <= var_3) {
      break;
    }

    waitframe();
  }

  var_0 scripts\sp\player\cursor_hint::remove_cursor_hint();
  thread reverse_breach_scene();
  thread scripts\engine\sp\utility::transient_load_array(["lab_hill_main_tr", "lab_hill_bottom_tr"]);
}

reverse_breach_scene() {
  var_0 = getEnt("pipes_exit_door_l", "targetname");
  var_0.clip = getEnt(var_0.target, "targetname");
  var_0.clip linkTo(var_0);
  var_1 = scripts\engine\utility::getStruct("left_door_dust", "targetname");
  var_2 = scripts\engine\utility::getStruct("left_door_push", "targetname");
  var_2.power = anglesToForward(var_2.angles) * 50;
  var_3 = getEnt("pipes_exit_door_r", "targetname");
  var_3.clip = getEnt(var_3.target, "targetname");
  var_3.clip linkTo(var_3);
  var_4 = scripts\engine\utility::getStruct("right_door_dust", "targetname");
  var_5 = scripts\engine\utility::getStruct("right_door_push", "targetname");
  var_5.power = anglesToForward(var_5.angles) * 50;
  var_0.clip connectpaths();
  var_3.clip connectpaths();
  thread spawn_reverse_breach_enemies();
  var_0 rotateYaw(-130, 0.3);
  var_0 playSound("scrpt_door_metal_heavy_bash_npc");
  playFX(scripts\engine\utility::getfx("vfx_lab_jump_dust"), var_1.origin);
  wait 0.1;
  var_3 rotateYaw(130, 0.3);
  var_3 playSound("scrpt_door_metal_heavy_bash_npc");
  playFX(scripts\engine\utility::getfx("vfx_lab_jump_dust"), var_4.origin);
  wait 0.3;
  var_0 rotateYaw(20, 0.2);
  physicsjolt(var_2.origin, 30, 1, var_2.power);
  wait 0.1;
  var_3 rotateYaw(-20, 0.2);
  physicsjolt(var_3.origin, 40, 1, var_5.power);
  wait 0.1;
  var_0 rotateYaw(-10, 0.4);
  var_3 rotateYaw(10, 0.4);
}

spawn_reverse_breach_enemies() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("reverse_breach", 1, 1);

  foreach(var_2 in var_0)
  var_2 thread reverse_breach_orders();
}

reverse_breach_orders() {
  self endon("death");

  if(scripts\engine\utility::is_equal(self.animname, "rb_door_guy")) {
    self.goalradius = 25;
    self.fixednode = 1;
    self.allowdeath = 1;
    var_0 = scripts\engine\utility::getanim("reverse_breach");
    var_1 = scripts\engine\utility::getStruct("animnode_rb", "targetname");
    var_1 thread scripts\common\anim::anim_single_solo(self, "reverse_breach");
    var_2 = getanimlength(var_0);
    var_3 = 1.4 / var_2;
    waitframe();
    self setanimtime(var_0, var_3);
    self waittillmatch("single anim", "end");
  } else {
    self.ignoreall = 1;
    self.goalradius = 25;
    self.fixednode = 1;
    self enableavoidance(0);
    wait 0.7;
    self.ignoreall = 0;
  }
}

vo_pipes_outdoor() {
  level waittill("fakesniper_spawned");
  level.fakesniper endon("kill_sniper");
  var_0 = ["dx_vom_pri_pipes_outdoor_callout_sniper_10", "dx_vom_pri_pipes_outdoor_callout_sniper_20", "dx_vom_pri_pipes_outdoor_callout_sniper_30"];
  var_1 = 0;

  while(var_1 < 3) {
    level.fakesniper waittill("new_target", var_2);

    if(!isDefined(var_2) || var_2 != level.player) {
      continue;
    }
    wait(randomfloatrange(0.5, 1));
    var_3 = gettime();
    level.price thread scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter(var_0[var_1]);
    wait 12;
    var_1++;
  }
}

sniper_death_func() {
  level.sniper endon("kill_sniper_death_function");
  scripts\common\ai::gun_remove();
  self.health = self.health + 300;
  level.sniper thread running_away_watcher("pipes_building_approach");
  self waittill("death", var_0);

  if(isDefined(level.fakesniper))
    level.fakesniper notify("kill_sniper");

  if(isDefined(var_0) && var_0 == level.player) {
    scripts\sp\maps\lab\lab_vo_util.gsc::wait_combat_cooldown(0.3, 1.5);
    level.player thread scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_kyle_pipes_outdoor_callout_sniper_40");
  }
}

running_away_watcher(var_0) {
  while(!isDefined(level.fakesniper))
    waitframe();

  level.fakesniper endon("kill_sniper");
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(level.sniper))
    level.sniper notify("kill_sniper_death_function");

  if(isDefined(level.fakesniper))
    level.fakesniper notify("kill_sniper");
}

fakesniper_control() {
  level.fakesniper notify("script_control");
  level.fakesniper laserforceoff();
  wait 14;
  level.fakesniper notify("end_script_control");
}

pipes_outdoor_catchup() {
  scripts\engine\utility::flag_set("parking_lot_clear");
  scripts\engine\utility::flag_set("sniper_intro");
}

sniper_intro(var_0) {
  var_1 = scripts\engine\utility::getStruct("fake_sniper", "targetname");
  level.fakesniper = scripts\engine\utility::spawn_script_origin(var_1.origin, var_1.angles);
  level.fakesniper thread scripts\sp\scriptedsniper::spawn_scripted_sniper("fake_sniper", "sniper_model", undefined, "sniper_targeting_player", "sniper_killed", "script_control");
  level.fakesniper.laser laserforceoff();
  thread fakesniper_control();
  wait 2;

  if(isDefined(level.rebel_1) && isalive(level.rebel_1))
    level.fakesniper.checkgroup[level.fakesniper.checkgroup.size] = level.rebel_1;

  if(isDefined(level.rebel_2) && isalive(level.rebel_2))
    level.fakesniper.checkgroup[level.fakesniper.checkgroup.size] = level.rebel_2;

  if(isDefined(level.rebel_3) && isalive(level.rebel_3))
    level.fakesniper.checkgroup[level.fakesniper.checkgroup.size] = level.rebel_3;
}

kyle_loadout() {
  scripts\sp\maps\lab\lab_util.gsc::setplayerviewmodel("viewhands_kyle_sas_urban", "viewhands_base_legs_iw8", "default_character_shadow");
  scripts\sp\utility::context_melee_set_arms("viewhands_kyle_sas_urban");
  level.player takeallweapons();
  var_0[0] = scripts\sp\utility::make_weapon("iw8_ar_scharlie", ["reflex_west02", "bipodgrip"]);
  var_0[1] = scripts\sp\utility::make_weapon("iw8_la_mike32");
  var_1 = var_0[1];
  level.player giveweapon(var_0[0]);
  level.player giveweapon(var_0[1]);
  level.player givemaxammo(var_0[0]);
  level.player setweaponammostock(var_0[1], 0);
  level.player scripts\engine\sp\utility::give_offhand("flash");
  level.player givemaxammo("flash");
  level.player scripts\engine\sp\utility::give_offhand("frag");
  level.player givemaxammo("frag");
  level.player switchtoweapon(var_1);

  if(isDefined(level.kyle))
    level.kyle scripts\anim\shared.gsc::forceuseweapon("iw8_la_mike32", "primary");
}

stackup_when_clear() {
  thread watch_final_spawners();
  thread ai_saftey_nets();
  thread pipes_last_enemies();
  scripts\engine\utility::flag_wait("pipes_building_approach");
  level.price thread scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_pipes_outdoor_combat_10");
  level.price thread scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_pipes_outdoor_combat_30");
  wait 1;

  while(getaiarray("axis").size > 2)
    level waittill("ai_killed");

  scripts\sp\maps\lab\lab_vo_util.gsc::wait_combat_cooldown(0.6, 1.2);

  if(getaiarray("axis").size == 2 && !scripts\engine\utility::flag("player_inside_hall"))
    level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_pipes_outdoor_twoleft_10");

  while(getaiarray("axis").size > 0)
    level waittill("ai_killed");

  scripts\sp\maps\lab\lab_vo_util.gsc::wait_combat_cooldown(0.8, 4);
  scripts\engine\utility::flag_wait("reverse_breach_guys_dead");
  scripts\engine\utility::flag_set("parking_lot_clear");
  var_0 = getEntArray("outdoor_pipes_color_trig", "targetname");
  scripts\engine\utility::array_delete(var_0);
}

ai_saftey_nets() {
  scripts\engine\utility::flag_wait("clear_parking_ai");
  var_0 = getaiarray("axis");

  if(isDefined(level.finale_heli)) {
    if(isDefined(level.barkov))
      var_0 = scripts\engine\utility::array_remove(var_0, level.barkov);
  }

  childthread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var_0, 400);

  if(!isDefined(level.rebel_1) || !isDefined(level.rebel_2) || !isDefined(level.rebel_3))
    childthread scripts\sp\maps\lab\lab_util.gsc::trigger_nearest_friendly_respawn_trigger();
}

watch_final_spawners() {
  var_0 = scripts\engine\utility::waittill_any_return("final_guards_a", "final_guards_b");

  switch (var_0) {
    case "final_guards_a":
      var_1 = getEntArray("final_guards_b", "targetname");
      break;
    default:
      var_1 = getEntArray("final_guards_a", "targetname");
      break;
  }

  scripts\engine\utility::array_delete(var_1);
}

pipes_last_enemies() {
  level endon("clear_parking_ai");
  scripts\engine\utility::flag_wait("pipes_building_approach");

  while(getaiarray("axis").size > 4)
    level waittill("ai_killed");

  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "rooftop_sniper") || scripts\engine\utility::is_equal(var_2, level.barkov) || scripts\engine\utility::is_equal(var_2.script_noteworthy, "rooftop_rpg")) {
      continue;
    }
    if(isDefined(var_2)) {
      var_2.goalradius = 200;
      var_2 setgoalentity(level.player);
      var_2.attackeraccuracy = 1;
    }
  }
}

pipes_hallway_start() {
  scripts\sp\maps\lab\lab_util.gsc::spawn_team_price();
  thread kyle_loadout();
  thread pipes_to_hallway();
  scripts\engine\sp\utility::set_start_location("parking_hallway_start", [level.player, level.price, level.rebel_1, level.rebel_2, level.rebel_3]);
}

pipes_hallway_main() {
  thread scripts\sp\analytics::analytics_kleenex_update("pipes_hallway_stopwatch");
  thread setup_heli();
  scripts\engine\utility::flag_wait_any("parking_lot_clear", "player_at_final_pipes");
  hallway_scene();
}

hallway_scene() {
  var_0 = getEntArray("parking_lot_color_trigs", "script_noteworthy");
  scripts\engine\utility::array_delete(var_0);
  thread vo_hallway_scene();
  var_1 = [level.price, level.rebel_1, level.rebel_2, level.rebel_3];
  thread scripts\sp\maps\lab\lab_util.gsc::move_lab_allies("hallway_nodes", var_1, 1);
  scripts\engine\utility::flag_wait("player_inside_hall");
  thread scripts\sp\maps\lab\lab_util.gsc::move_lab_allies("pipes_nodes", var_1, 1);
  scripts\engine\utility::flag_wait("player_at_final_pipes");
}

setup_heli() {
  scripts\engine\utility::flag_wait_any("parking_lot_clear", "player_inside_hall");
  scripts\engine\utility::flag_wait("player_inside_hall");
  scripts\sp\maps\lab\lab_finale.gsc::finale_heli_setup();
}

vo_hallway_scene() {
  if(scripts\engine\utility::flag("player_inside_hall")) {
    return;
  }
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_kyle_pipes_outdoor_outro_10");
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_pipes_outdoor_outro_20");
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_kyle_pipes_outdoor_outro_30");
  scripts\engine\utility::waittill_any_ents(level.price, "goal", level, "player_inside_hall");
  wait 8;
  var_0 = ["dx_vom_pri_pipes_outdoor_outro_40", "dx_vom_pri_pipes_outdoor_outro_50", "dx_vom_pri_pipes_outdoor_outro_60"];
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::nagtill("player_inside_hall", var_0, 12, 2, 1.2, 1.2, 35, 5);
}

pipes_hallway_catchup() {
  level.catwalk_guys = [];
}

final_pipes_start() {
  scripts\sp\maps\lab\lab_util.gsc::spawn_team_price();
  scripts\engine\sp\utility::set_start_location("final_pipes_start", [level.price, level.player, level.rebel_1, level.rebel_2, level.rebel_3]);
  scripts\engine\sp\utility::activate_trigger_with_targetname("friendlies_to_final_pipes");
  thread scripts\sp\maps\lab\lab_finale.gsc::finale_heli_setup();
}

final_pipes_main() {
  thread pipes_dialog();
  c4_plating_logic();
}

pipes_dialog() {
  level endon("bomb_planted");
  thread mus_bomb_planted();
  scripts\engine\utility::flag_wait_or_timeout("clear_parking_ai", 3);
  wait(randomfloatrange(0.1, 0.3));

  if(!scripts\engine\utility::flag("clear_parking_ai"))
    scripts\engine\utility::flag_set("clear_parking_ai");

  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_final_pipes_charges_10");
  wait 5;
  var_0 = ["dx_vom_pri_final_pipes_charges_20", "dx_vom_pri_final_pipes_charges_30", "dx_vom_pri_final_pipes_charges_40"];
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::nagtill("bomb_planted", var_0);
}

mus_bomb_planted() {
  scripts\engine\utility::flag_wait("player_inside_hall");
  setmusicstate("");
}

c4_plating_logic() {
  level.player endon("death");
  var_0 = scripts\engine\utility::getStructArray("bomb_plant", "targetname");

  foreach(var_2 in var_0)
  var_2 thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 1, 5), &"LAB/CURSOR_PLANT_CHARGES", 100, 200, 64, 1, undefined, undefined, undefined, undefined, undefined, undefined, 65, 80);

  waittill_and_return_ent(var_0[0], "trigger", var_0[1], "trigger", var_0[2], "trigger", var_0[3], "trigger");
  level notify("bomb_planted");
  thread sfx_pipes_heli_flyover();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.cursor_hint_ent))
      var_2 scripts\sp\player\cursor_hint::remove_cursor_hint();
  }

  foreach(var_7 in level.heroes) {
    if(isDefined(var_7))
      var_7.ignoreme = 1;
  }
}

sfx_pipes_heli_flyover() {
  wait 1;
  level.player playSound("scn_lab_pipes_heli_flyover_lr");
}

final_pipes_catchup() {}

waittill_and_return_ent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread waittill_trigger_pipes(var_0, var_1, "ent1_used");
  thread waittill_trigger_pipes(var_2, var_3, "ent2_used");
  thread waittill_trigger_pipes(var_4, var_5, "ent3_used");
  thread waittill_trigger_pipes(var_6, var_7, "ent4_used");
  level.og_zplanes = getDvar("OMNONNMOTP");
  var_8 = level scripts\engine\utility::waittill_any_return("ent1_used", "ent2_used", "ent3_used", "ent4_used");
  scripts\engine\utility::flag_set("pipes_bomb_planted");
  setsaveddvar("OMNONNMOTP", "0.1 400 1.5 1000");

  switch (var_8) {
    case "ent1_used":
      level.pipes_bomb = var_0;
      break;
    case "ent2_used":
      level.pipes_bomb = var_2;
      break;
    case "ent3_used":
      level.pipes_bomb = var_4;
      break;
    case "ent4_used":
      level.pipes_bomb = var_6;
      break;
  }
}

waittill_trigger_pipes(var_0, var_1, var_2) {
  level endon("pipes_bomb_planted");
  var_0 waittill(var_1);
  level notify(var_2);
}