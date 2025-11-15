/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_swim_ai.gsc
*****************************************************/

#using_animtree("generic_human");

init_ai_swim() {
  level._effect["swim_ai_blood_impact"] = loadfx("vfx/gameplay/blood/underwater_blood_impact");
  level._effect["swim_ai_death_blood"] = loadfx("vfx/moments/ship_graveyard/vfx_deathfx_bloodpool_uw");
  level._effect["swim_kick_bubble"] = loadfx("vfx/gameplay/footsteps/swim_kick_bubbles");
  level._effect["jump_into_water_splash"] = loadfx("vfx/moments/ship_graveyard/bubbles_diver_drop_underwater");
  level._effect["jump_into_water_trail"] = loadfx("vfx/moments/ship_graveyard/vfx_dive_bubbles_geotrail");
  level.scr_anim["generic"]["swimming_heli_deploy"][0] = % ship_graveyard_water_entry_idle;
  level.scr_anim["generic"]["swimming_heli_deploy_end"] = % ship_graveyard_water_entry;
  setsaveddvar("phys_gravity_ragdoll", -10);
  setsaveddvar("phys_gravity", -10);
  setsaveddvar("ragdoll_max_life", 15000);
  setsaveddvar("phys_autoDisableLinear", 0.25);
  thread maps\_swim_ai_common::override_footsteps();
  maps\_utility::battlechatter_off("axis");
}

enable_swim() {
  if(!isai(self)) {
    return;
  }
  self.swimmer = 1;
  self.health = 50;
  self.grenadeammo = 0;
  self.goalradius = 128;
  self.goalheight = 96;
  maps\_utility::disable_surprise();
  thread unlimited_ammo();
  maps\_utility::forceuseweapon("aps_underwater+swim", "primary");
  thread glint_behavior();
  self.bdisabledefaultfacialanims = 1;
  self.dontmelee = 1;
  self.no_pistol_switch = 1;
  self.ignoresuppression = 1;
  self.norunreload = 1;
  self.disablebulletwhizbyreaction = 1;
  self.usechokepoints = 0;
  self.disabledoorbehavior = 1;
  self.combatmode = "cover";
  self.oldgrenadeawareness = self.grenadeawareness;
  self.grenadeawareness = 0;
  self.oldgrenadereturnthrow = self.nogrenadereturnthrow;
  self.nogrenadereturnthrow = 1;
  self.norunngun = 1;
  init_ai_swim_animsets();
  thread maps\_underwater::friendly_bubbles();
  thread underwater_blood();

  if(!isDefined(anim.archetypes["soldier"]["swim"]))
    init_swim_anims();

  animscripts\swim::swim_begin();
}

disable_swim() {
  self.custommovetransition = undefined;
  self.permanentcustommovetransition = 0;
  self.bdisabledefaultfacialanims = undefined;
  animscripts\swim::swim_end();
  self notify("stop_glint_thread");
}

init_swim_anims() {
  var_0 = [];
  var_0["forward"] = % swimming_forward;
  var_0["forward_aim"] = % swimming_aiming_move_f;
  var_0["idle_to_forward"] = [];
  var_0["idle_to_forward"][2] = [];
  var_0["idle_to_forward"][2][4] = % swimming_idle_to_forward_l90;
  var_0["idle_to_forward"][4] = [];
  var_0["idle_to_forward"][4][2] = % swimming_idle_to_forward_u90;
  var_0["idle_to_forward"][4][3] = % swimming_idle_to_forward_u45;
  var_0["idle_to_forward"][4][4] = % swimming_idle_to_forward;
  var_0["idle_to_forward"][4][5] = % swimming_idle_to_forward_d45;
  var_0["idle_to_forward"][4][6] = % swimming_idle_to_forward_d90;
  var_0["idle_to_forward"][6] = [];
  var_0["idle_to_forward"][6][4] = % swimming_idle_to_forward_r90;
  var_0["idle_ready_to_forward"] = [];
  var_0["idle_ready_to_forward"][4] = [];
  var_0["idle_ready_to_forward"][4][4] = % swimming_idle_ready_to_forward;
  var_0["aim_stand_D"] = % swimming_fire_d;
  var_0["aim_stand_U"] = % swimming_fire_u_extended;
  var_0["aim_stand_L"] = % swimming_fire_l;
  var_0["aim_stand_R"] = % swimming_fire_r;
  var_0["aim_move_R"] = % swimming_aiming_move_f_fire_r;
  var_0["aim_move_L"] = % swimming_aiming_move_f_fire_l;
  var_0["aim_move_U"] = % swimming_aiming_move_f_fire_u_extended;
  var_0["aim_move_D"] = % swimming_aiming_move_f_fire_d_extended;
  var_0["strafe_B"] = % swimming_aiming_move_b;
  var_0["strafe_L"] = % swimming_aiming_move_l;
  var_0["strafe_R"] = % swimming_aiming_move_r;
  var_0["strafe_L_aim_R"] = % swimming_aiming_move_l_fire_r;
  var_0["strafe_L_aim_L"] = % swimming_aiming_move_l_fire_l;
  var_0["strafe_L_aim_U"] = % swimming_aiming_move_l_fire_u;
  var_0["strafe_L_aim_D"] = % swimming_aiming_move_l_fire_d;
  var_0["strafe_R_aim_R"] = % swimming_aiming_move_r_fire_r;
  var_0["strafe_R_aim_L"] = % swimming_aiming_move_r_fire_l;
  var_0["strafe_R_aim_U"] = % swimming_aiming_move_r_fire_u;
  var_0["strafe_R_aim_D"] = % swimming_aiming_move_r_fire_d;
  var_0["strafe_B_aim_R"] = % swimming_aiming_move_b_fire_r;
  var_0["strafe_B_aim_L"] = % swimming_aiming_move_b_fire_l;
  var_0["strafe_B_aim_U"] = % swimming_aiming_move_b_fire_u;
  var_0["strafe_B_aim_D"] = % swimming_aiming_move_b_fire_d;
  var_0["turn_left_45"] = % swimming_aiming_turn_l45;
  var_0["turn_left_90"] = % swimming_aiming_turn_l90;
  var_0["turn_left_135"] = % swimming_aiming_turn_l135;
  var_0["turn_left_180"] = % swimming_aiming_turn_l180;
  var_0["turn_right_45"] = % swimming_aiming_turn_r45;
  var_0["turn_right_90"] = % swimming_aiming_turn_r90;
  var_0["turn_right_135"] = % swimming_aiming_turn_r135;
  var_0["turn_right_180"] = % swimming_aiming_turn_r180;
  var_0["idle_turn"] = [];
  var_0["idle_turn"][2] = % swimming_idle_turn_90r;
  var_0["idle_turn"][3] = % swimming_idle_turn_45r;
  var_0["idle_turn"][5] = % swimming_idle_turn_45l;
  var_0["idle_turn"][6] = % swimming_idle_turn_90l;
  var_0["surprise_stop"] = % swimming_surprise_stop;
  var_0["arrival_cover_corner_r"] = [];
  var_0["arrival_cover_corner_r"][2] = [];
  var_0["arrival_cover_corner_r"][2][4] = % swimming_aiming_move_to_cover_r1_r90;
  var_0["arrival_cover_corner_r"][3] = [];
  var_0["arrival_cover_corner_r"][3][3] = % swimming_aiming_move_to_cover_r1_r45_u45;
  var_0["arrival_cover_corner_r"][3][4] = % swimming_aiming_move_to_cover_r1_r45;
  var_0["arrival_cover_corner_r"][3][5] = % swimming_aiming_move_to_cover_r1_r45_d45;
  var_0["arrival_cover_corner_r"][4] = [];
  var_0["arrival_cover_corner_r"][4][2] = % swimming_aiming_move_to_cover_r1_u90;
  var_0["arrival_cover_corner_r"][4][3] = % swimming_aiming_move_to_cover_r1_u45;
  var_0["arrival_cover_corner_r"][4][4] = % swimming_aiming_move_to_cover_r1;
  var_0["arrival_cover_corner_r"][4][5] = % swimming_aiming_move_to_cover_r1_d45;
  var_0["arrival_cover_corner_r"][4][6] = % swimming_aiming_move_to_cover_r1_d90;
  var_0["arrival_cover_corner_r"][5] = [];
  var_0["arrival_cover_corner_r"][5][3] = % swimming_aiming_move_to_cover_r1_l45_u45;
  var_0["arrival_cover_corner_r"][5][4] = % swimming_aiming_move_to_cover_r1_l45;
  var_0["arrival_cover_corner_r"][5][5] = % swimming_aiming_move_to_cover_r1_l45_d45;
  var_0["arrival_cover_corner_r"][6] = [];
  var_0["arrival_cover_corner_r"][6][4] = % swimming_aiming_move_to_cover_r1_l90;
  var_0["arrival_cover_corner_l"] = [];
  var_0["arrival_cover_corner_l"][2] = [];
  var_0["arrival_cover_corner_l"][2][4] = % swimming_aiming_move_to_cover_l1_r90;
  var_0["arrival_cover_corner_l"][3] = [];
  var_0["arrival_cover_corner_l"][3][3] = % swimming_aiming_move_to_cover_l1_r45_u45;
  var_0["arrival_cover_corner_l"][3][4] = % swimming_aiming_move_to_cover_l1_r45;
  var_0["arrival_cover_corner_l"][3][5] = % swimming_aiming_move_to_cover_l1_r45_d45;
  var_0["arrival_cover_corner_l"][4] = [];
  var_0["arrival_cover_corner_l"][4][2] = % swimming_aiming_move_to_cover_l1_u90;
  var_0["arrival_cover_corner_l"][4][3] = % swimming_aiming_move_to_cover_l1_u45;
  var_0["arrival_cover_corner_l"][4][4] = % swimming_aiming_move_to_cover_l1;
  var_0["arrival_cover_corner_l"][4][5] = % swimming_aiming_move_to_cover_l1_d45;
  var_0["arrival_cover_corner_l"][4][6] = % swimming_aiming_move_to_cover_l1_d90;
  var_0["arrival_cover_corner_l"][5] = [];
  var_0["arrival_cover_corner_l"][5][3] = % swimming_aiming_move_to_cover_l1_l45_u45;
  var_0["arrival_cover_corner_l"][5][4] = % swimming_aiming_move_to_cover_l1_l45;
  var_0["arrival_cover_corner_l"][5][5] = % swimming_aiming_move_to_cover_l1_l45_d45;
  var_0["arrival_cover_corner_l"][6] = [];
  var_0["arrival_cover_corner_l"][6][4] = % swimming_aiming_move_to_cover_l1_l90;
  var_0["arrival_cover_u"] = [];
  var_0["arrival_cover_u"][2] = [];
  var_0["arrival_cover_u"][2][4] = % swimming_aiming_move_to_cover_u1_r90;
  var_0["arrival_cover_u"][3] = [];
  var_0["arrival_cover_u"][3][3] = % swimming_aiming_move_to_cover_u1_r45_u45;
  var_0["arrival_cover_u"][3][4] = % swimming_aiming_move_to_cover_u1_r45;
  var_0["arrival_cover_u"][3][5] = % swimming_aiming_move_to_cover_u1_r45_d45;
  var_0["arrival_cover_u"][4] = [];
  var_0["arrival_cover_u"][4][2] = % swimming_aiming_move_to_cover_u1_u90;
  var_0["arrival_cover_u"][4][3] = % swimming_aiming_move_to_cover_u1_u45;
  var_0["arrival_cover_u"][4][4] = % swimming_aiming_move_to_cover_u1;
  var_0["arrival_cover_u"][4][5] = % swimming_aiming_move_to_cover_u1_d45;
  var_0["arrival_cover_u"][4][6] = % swimming_aiming_move_to_cover_u1_d90;
  var_0["arrival_cover_u"][5] = [];
  var_0["arrival_cover_u"][5][3] = % swimming_aiming_move_to_cover_u1_l45_u45;
  var_0["arrival_cover_u"][5][4] = % swimming_aiming_move_to_cover_u1_l45;
  var_0["arrival_cover_u"][5][5] = % swimming_aiming_move_to_cover_u1_l45_d45;
  var_0["arrival_cover_u"][6] = [];
  var_0["arrival_cover_u"][6][4] = % swimming_aiming_move_to_cover_u1_l90;
  var_0["arrival_exposed"] = [];
  var_0["arrival_exposed"][4] = [];
  var_0["arrival_exposed"][4][4] = % swimming_forward_to_idle_ready;
  var_0["arrival_exposed_noncombat"] = [];
  var_0["arrival_exposed_noncombat"][4] = [];
  var_0["arrival_exposed_noncombat"][4][2] = % swimming_forward_90d_to_idle;
  var_0["arrival_exposed_noncombat"][4][3] = % swimming_forward_45d_to_idle;
  var_0["arrival_exposed_noncombat"][4][4] = % swimming_forward_to_idle;
  var_0["arrival_exposed_noncombat"][4][5] = % swimming_forward_45u_to_idle;
  var_0["arrival_exposed_noncombat"][4][6] = % swimming_forward_90u_to_idle;
  var_0["exit_cover_corner_r"] = [];
  var_0["exit_cover_corner_r"][2] = [];
  var_0["exit_cover_corner_r"][2][4] = % swimming_cover_r1_to_aiming_move_r90;
  var_0["exit_cover_corner_r"][3] = [];
  var_0["exit_cover_corner_r"][3][3] = % swimming_cover_r1_to_aiming_move_r45_u45;
  var_0["exit_cover_corner_r"][3][4] = % swimming_cover_r1_to_aiming_move_r45;
  var_0["exit_cover_corner_r"][3][5] = % swimming_cover_r1_to_aiming_move_r45_d45;
  var_0["exit_cover_corner_r"][4] = [];
  var_0["exit_cover_corner_r"][4][2] = % swimming_cover_r1_to_aiming_move_u90;
  var_0["exit_cover_corner_r"][4][3] = % swimming_cover_r1_to_aiming_move_u45;
  var_0["exit_cover_corner_r"][4][4] = % swimming_cover_r1_to_aiming_move;
  var_0["exit_cover_corner_r"][4][5] = % swimming_cover_r1_to_aiming_move_d45;
  var_0["exit_cover_corner_r"][4][6] = % swimming_cover_r1_to_aiming_move_d90;
  var_0["exit_cover_corner_r"][5] = [];
  var_0["exit_cover_corner_r"][5][3] = % swimming_cover_r1_to_aiming_move_l45_u45;
  var_0["exit_cover_corner_r"][5][4] = % swimming_cover_r1_to_aiming_move_l45;
  var_0["exit_cover_corner_r"][5][5] = % swimming_cover_r1_to_aiming_move_l45_d45;
  var_0["exit_cover_corner_r"][6] = [];
  var_0["exit_cover_corner_r"][6][4] = % swimming_cover_r1_to_aiming_move_l90;
  var_0["exit_cover_corner_l"] = [];
  var_0["exit_cover_corner_l"][2] = [];
  var_0["exit_cover_corner_l"][2][4] = % swimming_cover_l1_to_aiming_move_r90;
  var_0["exit_cover_corner_l"][3] = [];
  var_0["exit_cover_corner_l"][3][3] = % swimming_cover_l1_to_aiming_move_r45_u45;
  var_0["exit_cover_corner_l"][3][4] = % swimming_cover_l1_to_aiming_move_r45;
  var_0["exit_cover_corner_l"][3][5] = % swimming_cover_l1_to_aiming_move_r45_d45;
  var_0["exit_cover_corner_l"][4] = [];
  var_0["exit_cover_corner_l"][4][2] = % swimming_cover_l1_to_aiming_move_u90;
  var_0["exit_cover_corner_l"][4][3] = % swimming_cover_l1_to_aiming_move_u45;
  var_0["exit_cover_corner_l"][4][4] = % swimming_cover_l1_to_aiming_move;
  var_0["exit_cover_corner_l"][4][5] = % swimming_cover_l1_to_aiming_move_d45;
  var_0["exit_cover_corner_l"][4][6] = % swimming_cover_l1_to_aiming_move_d90;
  var_0["exit_cover_corner_l"][5] = [];
  var_0["exit_cover_corner_l"][5][3] = % swimming_cover_l1_to_aiming_move_l45_u45;
  var_0["exit_cover_corner_l"][5][4] = % swimming_cover_l1_to_aiming_move_l45;
  var_0["exit_cover_corner_l"][5][5] = % swimming_cover_l1_to_aiming_move_l45_d45;
  var_0["exit_cover_corner_l"][6] = [];
  var_0["exit_cover_corner_l"][6][4] = % swimming_cover_l1_to_aiming_move_l90;
  var_0["exit_cover_u"] = [];
  var_0["exit_cover_u"][2] = [];
  var_0["exit_cover_u"][2][4] = % swimming_cover_u1_to_aiming_move_r90;
  var_0["exit_cover_u"][3] = [];
  var_0["exit_cover_u"][3][3] = % swimming_cover_u1_to_aiming_move_r45_u45;
  var_0["exit_cover_u"][3][4] = % swimming_cover_u1_to_aiming_move_r45;
  var_0["exit_cover_u"][3][5] = % swimming_cover_u1_to_aiming_move_r45_d45;
  var_0["exit_cover_u"][4] = [];
  var_0["exit_cover_u"][4][2] = % swimming_cover_u1_to_aiming_move_u90;
  var_0["exit_cover_u"][4][3] = % swimming_cover_u1_to_aiming_move_u45;
  var_0["exit_cover_u"][4][4] = % swimming_cover_u1_to_aiming_move;
  var_0["exit_cover_u"][4][5] = % swimming_cover_u1_to_aiming_move_d45;
  var_0["exit_cover_u"][4][6] = % swimming_cover_u1_to_aiming_move_d90;
  var_0["exit_cover_u"][5] = [];
  var_0["exit_cover_u"][5][3] = % swimming_cover_u1_to_aiming_move_l45_u45;
  var_0["exit_cover_u"][5][4] = % swimming_cover_u1_to_aiming_move_l45;
  var_0["exit_cover_u"][5][5] = % swimming_cover_u1_to_aiming_move_l45_d45;
  var_0["exit_cover_u"][6] = [];
  var_0["exit_cover_u"][6][4] = % swimming_cover_u1_to_aiming_move_l90;
  var_0["turn"] = [];
  var_0["turn"] = [];
  var_0["turn"][0] = [];
  var_0["turn"][0][4] = % swimming_swim_turn_l180;
  var_0["turn"][1] = [];
  var_0["turn"][1][4] = % swimming_swim_turn_l135;
  var_0["turn"][2] = [];
  var_0["turn"][2][4] = % swimming_swim_turn_l90;
  var_0["turn"][3] = [];
  var_0["turn"][3][3] = % swimming_swim_turn_d45_l45;
  var_0["turn"][3][4] = % swimming_swim_turn_l45;
  var_0["turn"][3][5] = % swimming_swim_turn_u45_l45;
  var_0["turn"][4] = [];
  var_0["turn"][4][3] = % swimming_swim_turn_d45;
  var_0["turn"][4][5] = % swimming_swim_turn_u45;
  var_0["turn"][5] = [];
  var_0["turn"][5][3] = % swimming_swim_turn_d45_r45;
  var_0["turn"][5][4] = % swimming_swim_turn_r45;
  var_0["turn"][5][5] = % swimming_swim_turn_u45_r45;
  var_0["turn"][6] = [];
  var_0["turn"][6][4] = % swimming_swim_turn_r90;
  var_0["turn"][7] = [];
  var_0["turn"][7][4] = % swimming_swim_turn_r135;
  var_0["turn"][8] = [];
  var_0["turn"][8][4] = % swimming_swim_turn_l180;
  var_0["turn_add_r"] = % swimming_slight_turn_r;
  var_0["turn_add_l"] = % swimming_slight_turn_l;
  var_0["turn_add_u"] = % swimming_slight_turn_u;
  var_0["turn_add_d"] = % swimming_slight_turn_d;
  var_0["cover_corner_r"] = [];
  var_0["cover_corner_r"]["straight_level"] = % swimming_fire;
  var_0["cover_corner_r"]["alert_idle"] = % swimming_cover_r1_loop;
  var_0["cover_corner_r"]["alert_to_A"] = [ % swimming_cover_r1_full_expose];
  var_0["cover_corner_r"]["alert_to_B"] = [ % swimming_cover_r1_full_expose];
  var_0["cover_corner_r"]["A_to_alert"] = [ % swimming_cover_r1_full_hide];
  var_0["cover_corner_r"]["A_to_B"] = [ % swimming_fire];
  var_0["cover_corner_r"]["B_to_alert"] = [ % swimming_cover_r1_full_hide];
  var_0["cover_corner_r"]["B_to_A"] = [ % swimming_fire];
  var_0["cover_corner_r"]["lean_to_alert"] = [ % swimming_cover_r1_hide];
  var_0["cover_corner_r"]["alert_to_lean"] = [ % swimming_cover_r1_expose];
  var_0["cover_corner_r"]["look"] = % swimming_cover_r1_expose;
  var_0["cover_corner_r"]["reload"] = [ % swimming_cover_r1_reload];
  var_0["cover_corner_r"]["alert_to_look"] = % swimming_cover_r1_expose;
  var_0["cover_corner_r"]["look_to_alert"] = % swimming_cover_r1_hide;
  var_0["cover_corner_r"]["look_to_alert_fast"] = % swimming_cover_r1_hide;
  var_0["cover_corner_r"]["look_idle"] = % swimming_cover_r1_exposed_idle;
  var_0["cover_corner_r"]["lean_aim_down"] = % swimming_cover_r1_exposed_aim_d;
  var_0["cover_corner_r"]["lean_aim_left"] = % swimming_cover_r1_exposed_aim_l;
  var_0["cover_corner_r"]["lean_aim_straight"] = % swimming_cover_r1_exposed_fire;
  var_0["cover_corner_r"]["lean_aim_right"] = % swimming_cover_r1_exposed_aim_r;
  var_0["cover_corner_r"]["lean_aim_up"] = % swimming_cover_r1_exposed_aim_u;
  var_0["cover_corner_r"]["lean_reload"] = % swimming_cover_r1_reload;
  var_0["cover_corner_r"]["lean_idle"] = [ % swimming_cover_r1_exposed_idle];
  var_0["cover_corner_r"]["lean_single"] = % swimming_cover_r1_exposed_fire;
  var_0["cover_corner_r"]["lean_fire"] = % swimming_cover_r1_exposed_fire;
  var_0["cover_corner_r"]["add_aim_down"] = % swimming_fire_d;
  var_0["cover_corner_r"]["add_aim_left"] = % swimming_fire_l;
  var_0["cover_corner_r"]["add_aim_straight"] = % swimming_firing;
  var_0["cover_corner_r"]["add_aim_right"] = % swimming_fire_r;
  var_0["cover_corner_r"]["add_aim_up"] = % swimming_fire_u_extended;
  var_0["cover_corner_r"]["add_aim_idle"] = % swimming_firing_idle;
  var_0["cover_corner_l"] = [];
  var_0["cover_corner_l"]["straight_level"] = % swimming_fire;
  var_0["cover_corner_l"]["alert_idle"] = % swimming_cover_l1_idle;
  var_0["cover_corner_l"]["alert_to_A"] = [ % swimming_cover_l1_full_expose];
  var_0["cover_corner_l"]["alert_to_B"] = [ % swimming_cover_l1_full_expose];
  var_0["cover_corner_l"]["A_to_alert"] = [ % swimming_cover_l1_full_hide];
  var_0["cover_corner_l"]["A_to_B"] = [ % swimming_fire];
  var_0["cover_corner_l"]["B_to_alert"] = [ % swimming_cover_l1_full_hide];
  var_0["cover_corner_l"]["B_to_A"] = [ % swimming_fire];
  var_0["cover_corner_l"]["lean_to_alert"] = [ % swimming_cover_l1_hide];
  var_0["cover_corner_l"]["alert_to_lean"] = [ % swimming_cover_l1_expose];
  var_0["cover_corner_l"]["look"] = % swimming_cover_l1_expose;
  var_0["cover_corner_l"]["reload"] = [ % swimming_cover_l1_reload];
  var_0["cover_corner_l"]["alert_to_look"] = % swimming_cover_l1_expose;
  var_0["cover_corner_l"]["look_to_alert"] = % swimming_cover_l1_hide;
  var_0["cover_corner_l"]["look_to_alert_fast"] = % swimming_cover_l1_hide;
  var_0["cover_corner_l"]["look_idle"] = % swimming_cover_l1_exposed_idle;
  var_0["cover_corner_l"]["lean_aim_down"] = % swimming_cover_l1_exposed_aim_d;
  var_0["cover_corner_l"]["lean_aim_left"] = % swimming_cover_l1_exposed_aim_l;
  var_0["cover_corner_l"]["lean_aim_straight"] = % swimming_cover_l1_exposed_fire;
  var_0["cover_corner_l"]["lean_aim_right"] = % swimming_cover_l1_exposed_aim_r;
  var_0["cover_corner_l"]["lean_aim_up"] = % swimming_cover_l1_exposed_aim_u;
  var_0["cover_corner_l"]["lean_reload"] = % swimming_cover_l1_reload;
  var_0["cover_corner_l"]["lean_idle"] = [ % swimming_cover_l1_exposed_idle];
  var_0["cover_corner_l"]["lean_single"] = % swimming_cover_l1_exposed_fire;
  var_0["cover_corner_l"]["lean_fire"] = % swimming_cover_l1_exposed_fire;
  var_0["cover_corner_l"]["add_aim_down"] = % swimming_fire_d;
  var_0["cover_corner_l"]["add_aim_left"] = % swimming_fire_l;
  var_0["cover_corner_l"]["add_aim_straight"] = % swimming_firing;
  var_0["cover_corner_l"]["add_aim_right"] = % swimming_fire_r;
  var_0["cover_corner_l"]["add_aim_up"] = % swimming_fire_u_extended;
  var_0["cover_corner_l"]["add_aim_idle"] = % swimming_firing_idle;
  var_0["cover_u"] = [];
  var_0["cover_u"]["straight_level"] = % swimming_fire;
  var_0["cover_u"]["alert_idle"] = % swimming_cover_u1_idle;
  var_0["cover_u"]["alert_to_A"] = [ % swimming_cover_u1_full_expose];
  var_0["cover_u"]["alert_to_B"] = [ % swimming_cover_u1_full_expose];
  var_0["cover_u"]["A_to_alert"] = [ % swimming_cover_u1_full_hide];
  var_0["cover_u"]["A_to_B"] = [ % swimming_fire];
  var_0["cover_u"]["B_to_alert"] = [ % swimming_cover_u1_full_hide];
  var_0["cover_u"]["B_to_A"] = [ % swimming_fire];
  var_0["cover_u"]["lean_to_alert"] = [ % swimming_cover_u1_hide];
  var_0["cover_u"]["alert_to_lean"] = [ % swimming_cover_u1_expose];
  var_0["cover_u"]["look"] = % swimming_cover_u1_expose;
  var_0["cover_u"]["reload"] = [ % swimming_cover_u1_reload];
  var_0["cover_u"]["alert_to_look"] = % swimming_cover_u1_expose;
  var_0["cover_u"]["look_to_alert"] = % swimming_cover_u1_hide;
  var_0["cover_u"]["look_to_alert_fast"] = % swimming_cover_u1_hide;
  var_0["cover_u"]["look_idle"] = % swimming_cover_u1_exposed_idle;
  var_0["cover_u"]["lean_aim_down"] = % swimming_cover_u1_exposed_aim_d;
  var_0["cover_u"]["lean_aim_left"] = % swimming_cover_u1_exposed_aim_l;
  var_0["cover_u"]["lean_aim_straight"] = % swimming_cover_u1_exposed_fire;
  var_0["cover_u"]["lean_aim_right"] = % swimming_cover_u1_exposed_aim_r;
  var_0["cover_u"]["lean_aim_up"] = % swimming_cover_u1_exposed_aim_u;
  var_0["cover_u"]["lean_reload"] = % swimming_cover_u1_reload;
  var_0["cover_u"]["lean_idle"] = [ % swimming_cover_u1_exposed_idle];
  var_0["cover_u"]["lean_single"] = % swimming_cover_u1_exposed_fire;
  var_0["cover_u"]["lean_fire"] = % swimming_cover_u1_exposed_fire;
  var_0["cover_u"]["add_aim_down"] = % swimming_fire_d;
  var_0["cover_u"]["add_aim_left"] = % swimming_fire_l;
  var_0["cover_u"]["add_aim_straight"] = % swimming_firing;
  var_0["cover_u"]["add_aim_right"] = % swimming_fire_r;
  var_0["cover_u"]["add_aim_up"] = % swimming_fire_u_extended;
  var_0["cover_u"]["add_aim_idle"] = % swimming_firing_idle;
  anim.archetypes["soldier"]["swim"] = var_0;
  anim.archetypes["soldier"]["swim"]["maxDelta"] = [];
  init_swim_anim_deltas("soldier", "arrival_exposed");
  init_swim_anim_deltas("soldier", "arrival_exposed_noncombat");
  init_swim_anim_deltas("soldier", "arrival_cover_corner_r");
  init_swim_anim_deltas("soldier", "arrival_cover_corner_l");
  init_swim_anim_deltas("soldier", "arrival_cover_u");
  init_swim_anim_deltas("soldier", "exit_cover_corner_r", 0);
  init_swim_anim_deltas("soldier", "exit_cover_corner_l", 0);
  init_swim_anim_deltas("soldier", "exit_cover_u", 0);
  init_swim_anim_deltas("soldier", "idle_to_forward", 0);
}

init_swim_anim_deltas(var_0, var_1, var_2) {
  var_3 = var_1 + "_delta";
  var_4 = var_1 + "_angleDelta";
  var_5 = 1;

  if(isDefined(var_2))
    var_5 = var_2;

  anim.archetypes[var_0]["swim"][var_3] = [];

  foreach(var_14, var_7 in anim.archetypes[var_0]["swim"][var_1]) {
    if(!isDefined(anim.archetypes[var_0]["swim"][var_3][var_14])) {
      anim.archetypes[var_0]["swim"][var_3][var_14] = [];
      anim.archetypes[var_0]["swim"][var_4][var_14] = [];
    }

    var_8 = 0;

    foreach(var_13, var_10 in var_7) {
      var_11 = getmovedelta(var_10, 0, 1);
      anim.archetypes[var_0]["swim"][var_3][var_14][var_13] = var_11;
      anim.archetypes[var_0]["swim"][var_4][var_14][var_13] = getangledelta3d(var_10, 0, 1);

      if(var_5) {
        var_12 = lengthsquared(var_11);

        if(var_12 > var_8)
          var_8 = var_12;
      }
    }

    if(var_5)
      anim.archetypes[var_0]["swim"][var_1]["maxDelta"] = sqrt(var_8);
  }
}

init_ai_swim_animsets() {
  self.customidleanimset = [];
  self.customidleanimset["stand"] = % swimming_idle;
  self.a.pose = "stand";
  self allowedstances("stand");
  var_0 = anim.archetypes["soldier"]["default_stand"];
  var_0["straight_level"] = % swimming_idle_ready;
  var_0["add_aim_up"] = % swimming_idle_ready_aim_u_extended;
  var_0["add_aim_down"] = % swimming_idle_ready_aim_d_extended;
  var_0["add_aim_left"] = % swimming_idle_ready_aim_l;
  var_0["add_aim_right"] = % swimming_idle_ready_aim_r;
  var_0["exposed_idle"] = undefined;
  var_0["reload"] = [ % swimming_reload];
  var_0["reload_crouchhide"] = [ % swimming_reload];
  var_0["turn_left_45"] = % swimming_aiming_turn_l45;
  var_0["turn_left_90"] = % swimming_aiming_turn_l90;
  var_0["turn_left_135"] = % swimming_aiming_turn_l135;
  var_0["turn_left_180"] = % swimming_aiming_turn_l180;
  var_0["turn_right_45"] = % swimming_aiming_turn_r45;
  var_0["turn_right_90"] = % swimming_aiming_turn_r90;
  var_0["turn_right_135"] = % swimming_aiming_turn_r135;
  var_0["turn_right_180"] = % swimming_aiming_turn_r180;
  animscripts\animset::init_animset_complete_custom_stand(var_0);
  animscripts\animset::init_animset_complete_custom_crouch(var_0);
  self.painfunction = ::ai_swim_pain;
  self.deathfunction = ::ai_swim_death;
}

ai_swim_pain() {
  if(self.a.movement == "run")
    var_0 = % swimming_pain_1;
  else
    var_0 = common_scripts\utility::random([ % swimming_firing_pain_1, % swimming_firing_pain_2]);

  var_1 = 1;
  self setflaggedanimknoballrestart("painanim", var_0, % body, 1, 0.1, var_1);

  if(self.a.pose == "prone")
    self updateprone( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);

  if(animhasnotetrack(var_0, "start_aim")) {
    thread animscripts\pain::notifystartaim("painanim");
    self endon("start_aim");
  }

  if(animhasnotetrack(var_0, "code_move"))
    animscripts\shared::donotetracks("painanim");

  animscripts\shared::donotetracks("painanim");
}

unlimited_ammo() {
  self endon("death");

  for(;;) {
    self.a.rockets = 100;
    wait 0.2;
  }
}

ai_swim_death() {
  playFXOnTag(common_scripts\utility::getfx("swim_ai_death_blood"), self, "j_spineupper");

  if(!isDefined(self.deathanim)) {
    if(self.damageyaw > -60 && self.damageyaw <= 60)
      self.deathanim = % swimming_idle_death_behind;
    else if(self.a.movement == "run")
      self.deathanim = % swimming_death_1;
    else if(animscripts\utility::damagelocationisany("left_arm_upper"))
      self.deathanim = % swimming_firing_death_1;
    else if(animscripts\utility::damagelocationisany("head", "helmet"))
      self.deathanim = % swimming_firing_death_2;
    else
      self.deathanim = common_scripts\utility::random([ % swimming_firing_death_1, % swimming_firing_death_2, % swimming_firing_death_3]);
  }

  if(!isDefined(self.nodeathsound))
    animscripts\death::playdeathsound();

  return 0;
}

underwater_blood() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 != "MOD_EXPLOSIVE") {
      if(var_2 != (0, 0, 0))
        playFX(common_scripts\utility::getfx("swim_ai_blood_impact"), var_3, var_2);
    }
  }
}

jumpintowater(var_0) {
  self endon("death");
  var_1 = (0, 0, 5);
  var_2 = level.water_level_z + 64;

  if(!isDefined(var_0)) {
    var_3 = (self.origin[0], self.origin[1], var_2);
    var_4 = bulletTrace(var_3 - (0, 0, 10), var_3 - (0, 0, 700), 0, self);
    var_0 = var_4["position"];
  } else
    var_3 = (var_0[0], var_0[1], var_2);

  var_3 = var_3 + var_1;
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_5.origin = var_3;
  var_6 = common_scripts\utility::spawn_tag_origin();
  self forceteleport(var_3, self.angles);
  self linkto(var_5);
  var_6 linkto(self, "tag_origin", (0, 0, 0), (90, 0, 0));
  self hide();
  var_5 thread maps\_anim::anim_generic_first_frame(self, "swimming_heli_deploy_end", "tag_origin");
  maps\_utility::script_delay();
  self show();
  self.allowdeath = 1;
  var_7 = 400;
  var_8 = var_2 - var_0[2];
  var_9 = min(var_8 - 100, var_8 * 0.9);
  var_10 = var_8 - var_9;
  var_11 = var_10 / var_7;
  var_12 = var_9 / (var_7 / 2);
  self playSound("enemy_water_splash");
  playFX(common_scripts\utility::getfx("jump_into_water_splash"), var_3 - (0, 0, 64), (0, 0, -1), (1, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("jump_into_water_trail"), var_6, "tag_origin");
  var_5 movez(-1 * var_9, var_12, 0, 0);
  wait(var_12 * 0.9);
  var_5 notify("stop_first_frame");
  self notify("stop_first_frame");
  var_6 thread mover_delete();

  if(isalive(self)) {
    self unlink();

    if(!self.swimmer)
      thread enable_swim();
  }

  self notify("done_jumping_in");

  if(!common_scripts\utility::flag_exist("_stealth_spotted") || !common_scripts\utility::flag("_stealth_spotted") || !common_scripts\utility::flag_exist("_stealth_enabled") || !common_scripts\utility::flag("_stealth_enabled")) {
    maps\_utility::disable_exits();
    var_5 maps\_anim::anim_generic_run(self, "swimming_heli_deploy_end");
    var_5 delete();
    wait 0.1;
    maps\_utility::enable_exits();
  } else
    var_5 delete();
}

mover_delete() {
  wait 1.5;
  stopFXOnTag(common_scripts\utility::getfx("jump_into_water_trail"), self, "tag_origin");
  wait 1;
  self unlink();
  wait 1;
  self delete();
}

glint_behavior() {
  self notify("new_glint_thread");
  self endon("new_glint_thread");
  self endon("stop_glint_thread");
  self endon("death");

  if(!isDefined(level._effect["sniper_glint"])) {
    return;
  }
  if(!isalive(self.enemy)) {
    return;
  }
  var_0 = common_scripts\utility::getfx("sniper_glint");
  wait 0.2;

  for(;;) {
    if(self.weapon == self.primaryweapon && animscripts\combat_utility::player_sees_my_scope() && isDefined(self.enemy)) {
      if(distancesquared(self.origin, self.enemy.origin) > 65536)
        playFXOnTag(var_0, self, "tag_eye");

      var_1 = randomfloatrange(3, 5);
      wait(var_1);
    }

    wait 0.2;
  }
}