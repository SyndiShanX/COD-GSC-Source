/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_space_ai.gsc
*****************************************************/

init_ai_space() {
  precachemodel("us_space_assault_a_body_cracked");
  precachemodel("us_space_assault_b_body_cracked");
  precachemodel("body_fed_space_assault_a_cracked");
  precachemodel("body_fed_space_assault_b_cracked");
  common_scripts\utility::flag_init("no_steam_on_death");
  level._effect["swim_ai_blood_impact"] = loadfx("fx/water/blood_spurt_underwater");
  level._effect["swim_ai_death_blood"] = loadfx("fx/impacts/deathfx_bloodpool_underwater");
  level._effect["blood_impact_space"] = loadfx("vfx/moments/odin/vfx_blood_impact_space");
  level._effect["bloodpool_zerog"] = loadfx("vfx/moments/odin/vfx_bloodpool_zerog");
  level._effect["space_headshot"] = loadfx("vfx/moments/odin/vfx_blood_impact_head_space");
  level._effect["sp_blood_float"] = loadfx("vfx/moments/ODIN/sp_blood_float");
  level._effect["space_death_steam"] = loadfx("vfx/gameplay/space/space_death_steam");
  level._effect["ally_light"] = loadfx("vfx/moments/ODIN/light_suit_ally_02");
  level._effect["ally_light_02"] = loadfx("vfx/moments/ODIN/light_suit_ally_02");
  level._effect["ally_light_02_a"] = loadfx("vfx/moments/ODIN/light_suit_ally_02_a");
  level._effect["enemy_light"] = loadfx("vfx/moments/ODIN/light_suit_enemy");

  if(level.script == "loki") {
    setsaveddvar("ragdoll_max_life", 65000);

    if(level.console) {
      setsaveddvar("ai_corpseCount", 8);
    }

    setsaveddvar("phys_gravity_ragdoll", 0);
    setsaveddvar("phys_gravity", 0);
    setsaveddvar("phys_autoDisableLinear", 0.25);
  } else
    setsaveddvar("ragdoll_max_life", 15000);

  setsaveddvar("actor_trace_bound_offset", -32.0);
  maps\_utility::battlechatter_off("axis");
}

enable_space() {
  if(!isai(self)) {
    return;
  }
  self.swimmer = 1;
  self.space = 1;
  self.grenadeammo = 0;
  self.goalradius = 128;
  self.goalheight = 18;
  maps\_utility::disable_surprise();
  thread unlimited_ammo();
  thread glint_behavior();
  self.dontmelee = 1;
  self.no_pistol_switch = 1;
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
  self.jumping = 1;
  self.approachtype = "";
  maps\_utility::disable_long_death();
  init_ai_space_animsets();
  thread space_actor_lights();

  if(!isDefined(anim.archetypes["soldier"]["swim"])) {
    init_space_anims();
  }

  animscripts\swim::swim_begin();
  thread force_rotation_update_listener();
}

printturnrate() {
  self endon("death");

  for(;;) {
    wait 0.05;
  }
}

disable_space() {
  self.custommovetransition = undefined;
  self.permanentcustommovetransition = 0;
  animscripts\swim::swim_end();
  self notify("stop_glint_thread");
}

#using_animtree("generic_human");

init_space_anims() {
  var_0 = [];
  var_0["forward"] = % space_forward;
  var_0["forward_twitch"] = % space_forward_twitch_1;
  var_0["forward_aim"] = % space_aiming_move_f;
  var_0["idle_to_forward"] = [];
  var_0["idle_to_forward"][2] = [];
  var_0["idle_to_forward"][2][4] = % space_idle_to_forward_l90;
  var_0["idle_to_forward"][4] = [];
  var_0["idle_to_forward"][4][2] = % space_idle_to_forward_u90;
  var_0["idle_to_forward"][4][3] = % space_idle_to_forward_u45;
  var_0["idle_to_forward"][4][4] = % space_idle_to_forward;
  var_0["idle_to_forward"][4][5] = % space_idle_to_forward_d45;
  var_0["idle_to_forward"][4][6] = % space_idle_to_forward_d90;
  var_0["idle_to_forward"][6] = [];
  var_0["idle_to_forward"][6][4] = % space_idle_to_forward_r90;
  var_0["idle_ready_to_forward"] = [];
  var_0["idle_ready_to_forward"][2] = [];
  var_0["idle_ready_to_forward"][2][4] = % space_idle_to_forward_l90;
  var_0["idle_ready_to_forward"][4] = [];
  var_0["idle_ready_to_forward"][4][2] = % space_idle_to_forward_u90;
  var_0["idle_ready_to_forward"][4][3] = % space_idle_to_forward_u45;
  var_0["idle_ready_to_forward"][4][4] = % space_idle_ready_to_forward;
  var_0["idle_ready_to_forward"][4][5] = % space_idle_to_forward_d45;
  var_0["idle_ready_to_forward"][4][6] = % space_idle_to_forward_d90;
  var_0["idle_ready_to_forward"][6] = [];
  var_0["idle_ready_to_forward"][6][4] = % space_idle_to_forward_r90;
  var_0["aim_stand_D"] = % space_fire_d;
  var_0["aim_stand_U"] = % space_fire_u_extended;
  var_0["aim_stand_L"] = % space_fire_l;
  var_0["aim_stand_R"] = % space_fire_r;
  var_0["aim_move_R"] = % space_aiming_move_f_fire_r;
  var_0["aim_move_L"] = % space_aiming_move_f_fire_l;
  var_0["aim_move_U"] = % space_aiming_move_f_fire_u_extended;
  var_0["aim_move_D"] = % space_aiming_move_f_fire_d_extended;
  var_0["strafe_B"] = % space_aiming_move_b;
  var_0["strafe_L"] = % space_aiming_move_l;
  var_0["strafe_R"] = % space_aiming_move_r;
  var_0["strafe_L_aim_R"] = % space_aiming_move_l_fire_r;
  var_0["strafe_L_aim_L"] = % space_aiming_move_l_fire_l;
  var_0["strafe_L_aim_U"] = % space_aiming_move_l_fire_u;
  var_0["strafe_L_aim_D"] = % space_aiming_move_l_fire_d;
  var_0["strafe_R_aim_R"] = % space_aiming_move_r_fire_r;
  var_0["strafe_R_aim_L"] = % space_aiming_move_r_fire_l;
  var_0["strafe_R_aim_U"] = % space_aiming_move_r_fire_u;
  var_0["strafe_R_aim_D"] = % space_aiming_move_r_fire_d;
  var_0["strafe_B_aim_R"] = % space_aiming_move_b_fire_r;
  var_0["strafe_B_aim_L"] = % space_aiming_move_b_fire_l;
  var_0["strafe_B_aim_U"] = % space_aiming_move_b_fire_u;
  var_0["strafe_B_aim_D"] = % space_aiming_move_b_fire_d;
  var_0["turn_left_45"] = % space_aiming_turn_l45;
  var_0["turn_left_90"] = % space_aiming_turn_l90;
  var_0["turn_left_135"] = % space_aiming_turn_l135;
  var_0["turn_left_180"] = % space_aiming_turn_l180;
  var_0["turn_right_45"] = % space_aiming_turn_r45;
  var_0["turn_right_90"] = % space_aiming_turn_r90;
  var_0["turn_right_135"] = % space_aiming_turn_r135;
  var_0["turn_right_180"] = % space_aiming_turn_r180;
  var_0["idle_turn"] = [];
  var_0["idle_turn"][0] = % space_aiming_turn_r180;
  var_0["idle_turn"][1] = % space_aiming_turn_r135;
  var_0["idle_turn"][2] = % space_aiming_turn_r90;
  var_0["idle_turn"][3] = % space_aiming_turn_r45;
  var_0["idle_turn"][5] = % space_aiming_turn_l45;
  var_0["idle_turn"][6] = % space_aiming_turn_l90;
  var_0["idle_turn"][7] = % space_aiming_turn_l135;
  var_0["idle_turn"][8] = % space_aiming_turn_l180;
  var_0["surprise_stop"] = % space_surprise_stop;
  var_0["arrival_cover_corner_r"] = [];
  var_0["arrival_cover_corner_r"][0] = [];
  var_0["arrival_cover_corner_r"][0][2] = % space_aiming_move_to_cover_r1_180_u90;
  var_0["arrival_cover_corner_r"][0][3] = % space_aiming_move_to_cover_r1_180_u45;
  var_0["arrival_cover_corner_r"][0][4] = % space_aiming_move_to_cover_r1_180;
  var_0["arrival_cover_corner_r"][0][5] = % space_aiming_move_to_cover_r1_180_d45;
  var_0["arrival_cover_corner_r"][0][6] = % space_aiming_move_to_cover_r1_180_d90;
  var_0["arrival_cover_corner_r"][1] = [];
  var_0["arrival_cover_corner_r"][1][3] = % space_aiming_move_to_cover_r1_r135_u45;
  var_0["arrival_cover_corner_r"][1][4] = % space_aiming_move_to_cover_r1_r135;
  var_0["arrival_cover_corner_r"][1][5] = % space_aiming_move_to_cover_r1_r135_d45;
  var_0["arrival_cover_corner_r"][2] = [];
  var_0["arrival_cover_corner_r"][2][2] = % space_aiming_move_to_cover_r1_r90_u90;
  var_0["arrival_cover_corner_r"][2][3] = % space_aiming_move_to_cover_r1_r90_u45;
  var_0["arrival_cover_corner_r"][2][4] = % space_aiming_move_to_cover_r1_r90;
  var_0["arrival_cover_corner_r"][2][5] = % space_aiming_move_to_cover_r1_r90_d45;
  var_0["arrival_cover_corner_r"][2][6] = % space_aiming_move_to_cover_r1_r90_d90;
  var_0["arrival_cover_corner_r"][3] = [];
  var_0["arrival_cover_corner_r"][3][3] = % space_aiming_move_to_cover_r1_r45_u45;
  var_0["arrival_cover_corner_r"][3][4] = % space_aiming_move_to_cover_r1_r45;
  var_0["arrival_cover_corner_r"][3][5] = % space_aiming_move_to_cover_r1_r45_d45;
  var_0["arrival_cover_corner_r"][4] = [];
  var_0["arrival_cover_corner_r"][4][2] = % space_aiming_move_to_cover_r1_u90;
  var_0["arrival_cover_corner_r"][4][3] = % space_aiming_move_to_cover_r1_u45;
  var_0["arrival_cover_corner_r"][4][4] = % space_aiming_move_to_cover_r1;
  var_0["arrival_cover_corner_r"][4][5] = % space_aiming_move_to_cover_r1_d45;
  var_0["arrival_cover_corner_r"][4][6] = % space_aiming_move_to_cover_r1_d90;
  var_0["arrival_cover_corner_r"][5] = [];
  var_0["arrival_cover_corner_r"][5][3] = % space_aiming_move_to_cover_r1_l45_u45;
  var_0["arrival_cover_corner_r"][5][4] = % space_aiming_move_to_cover_r1_l45;
  var_0["arrival_cover_corner_r"][5][5] = % space_aiming_move_to_cover_r1_l45_d45;
  var_0["arrival_cover_corner_r"][6] = [];
  var_0["arrival_cover_corner_r"][6][2] = % space_aiming_move_to_cover_r1_l90_u90;
  var_0["arrival_cover_corner_r"][6][3] = % space_aiming_move_to_cover_r1_l90_u45;
  var_0["arrival_cover_corner_r"][6][4] = % space_aiming_move_to_cover_r1_l90;
  var_0["arrival_cover_corner_r"][6][5] = % space_aiming_move_to_cover_r1_l90_d45;
  var_0["arrival_cover_corner_r"][6][6] = % space_aiming_move_to_cover_r1_l90_d90;
  var_0["arrival_cover_corner_r"][7] = [];
  var_0["arrival_cover_corner_r"][7][3] = % space_aiming_move_to_cover_r1_180_u45;
  var_0["arrival_cover_corner_r"][7][4] = % space_aiming_move_to_cover_r1_180;
  var_0["arrival_cover_corner_r"][7][5] = % space_aiming_move_to_cover_r1_180_d45;
  var_0["arrival_cover_corner_r"][8] = [];
  var_0["arrival_cover_corner_r"][8][2] = % space_aiming_move_to_cover_r1_180_u90;
  var_0["arrival_cover_corner_r"][8][3] = % space_aiming_move_to_cover_r1_180_u45;
  var_0["arrival_cover_corner_r"][8][4] = % space_aiming_move_to_cover_r1_180;
  var_0["arrival_cover_corner_r"][8][5] = % space_aiming_move_to_cover_r1_180_d45;
  var_0["arrival_cover_corner_r"][8][6] = % space_aiming_move_to_cover_r1_180_d90;
  var_0["arrival_cover_corner_l"] = [];
  var_0["arrival_cover_corner_l"][0] = [];
  var_0["arrival_cover_corner_l"][0][2] = % space_aiming_move_to_cover_l1_180_u90;
  var_0["arrival_cover_corner_l"][0][3] = % space_aiming_move_to_cover_l1_180_u45;
  var_0["arrival_cover_corner_l"][0][4] = % space_aiming_move_to_cover_l1_180;
  var_0["arrival_cover_corner_l"][0][5] = % space_aiming_move_to_cover_l1_180_d45;
  var_0["arrival_cover_corner_l"][0][6] = % space_aiming_move_to_cover_l1_180_d90;
  var_0["arrival_cover_corner_l"][1] = [];
  var_0["arrival_cover_corner_l"][1][3] = % space_aiming_move_to_cover_l1_180_u45;
  var_0["arrival_cover_corner_l"][1][4] = % space_aiming_move_to_cover_l1_180;
  var_0["arrival_cover_corner_l"][1][5] = % space_aiming_move_to_cover_l1_180_d45;
  var_0["arrival_cover_corner_l"][2] = [];
  var_0["arrival_cover_corner_l"][2][2] = % space_aiming_move_to_cover_l1_r90_u90;
  var_0["arrival_cover_corner_l"][2][3] = % space_aiming_move_to_cover_l1_r90_u45;
  var_0["arrival_cover_corner_l"][2][4] = % space_aiming_move_to_cover_l1_r90;
  var_0["arrival_cover_corner_l"][2][5] = % space_aiming_move_to_cover_l1_r90_d45;
  var_0["arrival_cover_corner_l"][2][6] = % space_aiming_move_to_cover_l1_r90_d90;
  var_0["arrival_cover_corner_l"][3] = [];
  var_0["arrival_cover_corner_l"][3][3] = % space_aiming_move_to_cover_l1_r45_u45;
  var_0["arrival_cover_corner_l"][3][4] = % space_aiming_move_to_cover_l1_r45;
  var_0["arrival_cover_corner_l"][3][5] = % space_aiming_move_to_cover_l1_r45_d45;
  var_0["arrival_cover_corner_l"][4] = [];
  var_0["arrival_cover_corner_l"][4][2] = % space_aiming_move_to_cover_l1_u90;
  var_0["arrival_cover_corner_l"][4][3] = % space_aiming_move_to_cover_l1_u45;
  var_0["arrival_cover_corner_l"][4][4] = % space_aiming_move_to_cover_l1;
  var_0["arrival_cover_corner_l"][4][5] = % space_aiming_move_to_cover_l1_d45;
  var_0["arrival_cover_corner_l"][4][6] = % space_aiming_move_to_cover_l1_d90;
  var_0["arrival_cover_corner_l"][5] = [];
  var_0["arrival_cover_corner_l"][5][3] = % space_aiming_move_to_cover_l1_l45_u45;
  var_0["arrival_cover_corner_l"][5][4] = % space_aiming_move_to_cover_l1_l45;
  var_0["arrival_cover_corner_l"][5][5] = % space_aiming_move_to_cover_l1_l45_d45;
  var_0["arrival_cover_corner_l"][6] = [];
  var_0["arrival_cover_corner_l"][6][2] = % space_aiming_move_to_cover_l1_l90_u90;
  var_0["arrival_cover_corner_l"][6][3] = % space_aiming_move_to_cover_l1_l90_u45;
  var_0["arrival_cover_corner_l"][6][4] = % space_aiming_move_to_cover_l1_l90;
  var_0["arrival_cover_corner_l"][6][5] = % space_aiming_move_to_cover_l1_l90_d45;
  var_0["arrival_cover_corner_l"][6][6] = % space_aiming_move_to_cover_l1_l90_d90;
  var_0["arrival_cover_corner_l"][7] = [];
  var_0["arrival_cover_corner_l"][7][3] = % space_aiming_move_to_cover_l1_l135_u45;
  var_0["arrival_cover_corner_l"][7][4] = % space_aiming_move_to_cover_l1_l135;
  var_0["arrival_cover_corner_l"][7][5] = % space_aiming_move_to_cover_l1_l135_d45;
  var_0["arrival_cover_corner_l"][8] = [];
  var_0["arrival_cover_corner_l"][8][2] = % space_aiming_move_to_cover_l1_180_u90;
  var_0["arrival_cover_corner_l"][8][3] = % space_aiming_move_to_cover_l1_180_u45;
  var_0["arrival_cover_corner_l"][8][4] = % space_aiming_move_to_cover_l1_180;
  var_0["arrival_cover_corner_l"][8][5] = % space_aiming_move_to_cover_l1_180_d45;
  var_0["arrival_cover_corner_l"][8][6] = % space_aiming_move_to_cover_l1_180_d90;
  var_0["arrival_cover_u"] = [];
  var_0["arrival_cover_u"][0] = [];
  var_0["arrival_cover_u"][0][2] = % space_aiming_move_to_cover_u1_180_u90;
  var_0["arrival_cover_u"][0][3] = % space_aiming_move_to_cover_u1_180_u45;
  var_0["arrival_cover_u"][0][4] = % space_aiming_move_to_cover_u1_180;
  var_0["arrival_cover_u"][0][5] = % space_aiming_move_to_cover_u1_180;
  var_0["arrival_cover_u"][0][6] = % space_aiming_move_to_cover_u1_180_d90;
  var_0["arrival_cover_u"][1] = [];
  var_0["arrival_cover_u"][1][3] = % space_aiming_move_to_cover_u1_r135_u45;
  var_0["arrival_cover_u"][1][4] = % space_aiming_move_to_cover_u1_r135;
  var_0["arrival_cover_u"][1][5] = % space_aiming_move_to_cover_u1_r135;
  var_0["arrival_cover_u"][2] = [];
  var_0["arrival_cover_u"][2][2] = % space_aiming_move_to_cover_u1_r90_u90;
  var_0["arrival_cover_u"][2][3] = % space_aiming_move_to_cover_u1_r90_u45;
  var_0["arrival_cover_u"][2][4] = % space_aiming_move_to_cover_u1_r90;
  var_0["arrival_cover_u"][2][5] = % space_aiming_move_to_cover_u1_r90_d45;
  var_0["arrival_cover_u"][2][6] = % space_aiming_move_to_cover_u1_r90_d90;
  var_0["arrival_cover_u"][3] = [];
  var_0["arrival_cover_u"][3][3] = % space_aiming_move_to_cover_u1_r45_u45;
  var_0["arrival_cover_u"][3][4] = % space_aiming_move_to_cover_u1_r45;
  var_0["arrival_cover_u"][3][5] = % space_aiming_move_to_cover_u1_r45_d45;
  var_0["arrival_cover_u"][4] = [];
  var_0["arrival_cover_u"][4][2] = % space_aiming_move_to_cover_u1_u90;
  var_0["arrival_cover_u"][4][3] = % space_aiming_move_to_cover_u1_u45;
  var_0["arrival_cover_u"][4][4] = % space_aiming_move_to_cover_u1;
  var_0["arrival_cover_u"][4][5] = % space_aiming_move_to_cover_u1_d45;
  var_0["arrival_cover_u"][4][6] = % space_aiming_move_to_cover_u1_d90;
  var_0["arrival_cover_u"][5] = [];
  var_0["arrival_cover_u"][5][3] = % space_aiming_move_to_cover_u1_l45_u45;
  var_0["arrival_cover_u"][5][4] = % space_aiming_move_to_cover_u1_l45;
  var_0["arrival_cover_u"][5][5] = % space_aiming_move_to_cover_u1_l45_d45;
  var_0["arrival_cover_u"][6] = [];
  var_0["arrival_cover_u"][6][2] = % space_aiming_move_to_cover_u1_l90_u90;
  var_0["arrival_cover_u"][6][3] = % space_aiming_move_to_cover_u1_l90_u45;
  var_0["arrival_cover_u"][6][4] = % space_aiming_move_to_cover_u1_l90;
  var_0["arrival_cover_u"][6][5] = % space_aiming_move_to_cover_u1_l90_d45;
  var_0["arrival_cover_u"][6][6] = % space_aiming_move_to_cover_u1_l90_d90;
  var_0["arrival_cover_u"][7] = [];
  var_0["arrival_cover_u"][7][3] = % space_aiming_move_to_cover_u1_l135_u45;
  var_0["arrival_cover_u"][7][4] = % space_aiming_move_to_cover_u1_l135;
  var_0["arrival_cover_u"][7][5] = % space_aiming_move_to_cover_u1_l135;
  var_0["arrival_cover_u"][8] = [];
  var_0["arrival_cover_u"][8][2] = % space_aiming_move_to_cover_u1_180_u90;
  var_0["arrival_cover_u"][8][3] = % space_aiming_move_to_cover_u1_180_u45;
  var_0["arrival_cover_u"][8][4] = % space_aiming_move_to_cover_u1_180;
  var_0["arrival_cover_u"][8][5] = % space_aiming_move_to_cover_u1_180_d45;
  var_0["arrival_cover_u"][8][6] = % space_aiming_move_to_cover_u1_180_d90;
  var_0["arrival_exposed"] = [];
  var_0["arrival_exposed"][4] = [];
  var_0["arrival_exposed"][4][2] = % space_forward_90d_to_idle;
  var_0["arrival_exposed"][4][3] = % space_forward_45d_to_idle;
  var_0["arrival_exposed"][4][4] = % space_forward_to_idle_ready;
  var_0["arrival_exposed"][4][5] = % space_forward_45u_to_idle;
  var_0["arrival_exposed"][4][6] = % space_forward_90u_to_idle;
  var_0["arrival_exposed_noncombat"] = [];
  var_0["arrival_exposed_noncombat"][4] = [];
  var_0["arrival_exposed_noncombat"][4][2] = % space_forward_90d_to_idle;
  var_0["arrival_exposed_noncombat"][4][3] = % space_forward_45d_to_idle;
  var_0["arrival_exposed_noncombat"][4][4] = % space_forward_to_idle;
  var_0["arrival_exposed_noncombat"][4][5] = % space_forward_45u_to_idle;
  var_0["arrival_exposed_noncombat"][4][6] = % space_forward_90u_to_idle;
  var_0["exit_cover_corner_r"] = [];
  var_0["exit_cover_corner_r"][0] = [];
  var_0["exit_cover_corner_r"][0][3] = % space_cover_r1_to_aiming_move_180_u45;
  var_0["exit_cover_corner_r"][0][4] = % space_cover_r1_to_aiming_move_180;
  var_0["exit_cover_corner_r"][0][5] = % space_cover_r1_to_aiming_move_180_d45;
  var_0["exit_cover_corner_r"][1] = [];
  var_0["exit_cover_corner_r"][1][3] = % space_cover_r1_to_aiming_move_r135_u45;
  var_0["exit_cover_corner_r"][1][4] = % space_cover_r1_to_aiming_move_r135;
  var_0["exit_cover_corner_r"][1][5] = % space_cover_r1_to_aiming_move_r135_d45;
  var_0["exit_cover_corner_r"][2] = [];
  var_0["exit_cover_corner_r"][2][2] = % space_cover_r1_to_aiming_move_r90_u90;
  var_0["exit_cover_corner_r"][2][3] = % space_cover_r1_to_aiming_move_r90_u45;
  var_0["exit_cover_corner_r"][2][4] = % space_cover_r1_to_aiming_move_r90;
  var_0["exit_cover_corner_r"][2][5] = % space_cover_r1_to_aiming_move_r90_d45;
  var_0["exit_cover_corner_r"][2][6] = % space_cover_r1_to_aiming_move_r90_d90;
  var_0["exit_cover_corner_r"][3] = [];
  var_0["exit_cover_corner_r"][3][3] = % space_cover_r1_to_aiming_move_r45_u45;
  var_0["exit_cover_corner_r"][3][4] = % space_cover_r1_to_aiming_move_r45;
  var_0["exit_cover_corner_r"][3][5] = % space_cover_r1_to_aiming_move_r45_d45;
  var_0["exit_cover_corner_r"][4] = [];
  var_0["exit_cover_corner_r"][4][2] = % space_cover_r1_to_aiming_move_u90;
  var_0["exit_cover_corner_r"][4][3] = % space_cover_r1_to_aiming_move_u45;
  var_0["exit_cover_corner_r"][4][4] = % space_cover_r1_to_aiming_move;
  var_0["exit_cover_corner_r"][4][5] = % space_cover_r1_to_aiming_move_d45;
  var_0["exit_cover_corner_r"][4][6] = % space_cover_r1_to_aiming_move_d90;
  var_0["exit_cover_corner_r"][5] = [];
  var_0["exit_cover_corner_r"][5][3] = % space_cover_r1_to_aiming_move_u45;
  var_0["exit_cover_corner_r"][5][4] = % space_cover_r1_to_aiming_move;
  var_0["exit_cover_corner_r"][5][5] = % space_cover_r1_to_aiming_move_d45;
  var_0["exit_cover_corner_r"][6] = [];
  var_0["exit_cover_corner_r"][6][2] = % space_cover_r1_to_aiming_move_l90_u90;
  var_0["exit_cover_corner_r"][6][3] = % space_cover_r1_to_aiming_move_l90_u45;
  var_0["exit_cover_corner_r"][6][4] = % space_cover_r1_to_aiming_move_l90;
  var_0["exit_cover_corner_r"][6][5] = % space_cover_r1_to_aiming_move_l90_d45;
  var_0["exit_cover_corner_r"][6][6] = % space_cover_r1_to_aiming_move_l90_d90;
  var_0["exit_cover_corner_r"][7] = [];
  var_0["exit_cover_corner_r"][7][3] = % space_cover_r1_to_aiming_move_l135_u45;
  var_0["exit_cover_corner_r"][7][4] = % space_cover_r1_to_aiming_move_l135;
  var_0["exit_cover_corner_r"][7][5] = % space_cover_r1_to_aiming_move_l135_d45;
  var_0["exit_cover_corner_r"][8] = [];
  var_0["exit_cover_corner_r"][8][3] = % space_cover_r1_to_aiming_move_180_u45;
  var_0["exit_cover_corner_r"][8][4] = % space_cover_r1_to_aiming_move_180;
  var_0["exit_cover_corner_r"][8][5] = % space_cover_r1_to_aiming_move_180_d45;
  var_0["exit_cover_corner_l"] = [];
  var_0["exit_cover_corner_l"][0] = [];
  var_0["exit_cover_corner_l"][0][3] = % space_cover_l1_to_aiming_move_180_u45;
  var_0["exit_cover_corner_l"][0][4] = % space_cover_l1_exit_r180;
  var_0["exit_cover_corner_l"][0][5] = % space_cover_l1_to_aiming_move_180_d45;
  var_0["exit_cover_corner_l"][1] = [];
  var_0["exit_cover_corner_l"][1][3] = % space_cover_l1_to_aiming_move_r135_u45;
  var_0["exit_cover_corner_l"][1][4] = % space_cover_l1_to_aiming_move_r135;
  var_0["exit_cover_corner_l"][1][5] = % space_cover_l1_to_aiming_move_r135_d45;
  var_0["exit_cover_corner_l"][2] = [];
  var_0["exit_cover_corner_l"][2][2] = % space_cover_l1_to_aiming_move_r90_u90;
  var_0["exit_cover_corner_l"][2][3] = % space_cover_l1_to_aiming_move_r90_u45;
  var_0["exit_cover_corner_l"][2][4] = % space_cover_l1_to_aiming_move_r90;
  var_0["exit_cover_corner_l"][2][5] = % space_cover_l1_to_aiming_move_r90_d45;
  var_0["exit_cover_corner_l"][2][6] = % space_cover_l1_to_aiming_move_r90_d90;
  var_0["exit_cover_corner_l"][3] = [];
  var_0["exit_cover_corner_l"][3][3] = % space_cover_l1_to_aiming_move_u45;
  var_0["exit_cover_corner_l"][3][4] = % space_cover_l1_to_aiming_move;
  var_0["exit_cover_corner_l"][3][5] = % space_cover_l1_to_aiming_move_d45;
  var_0["exit_cover_corner_l"][4] = [];
  var_0["exit_cover_corner_l"][4][2] = % space_cover_l1_to_aiming_move_u90;
  var_0["exit_cover_corner_l"][4][3] = % space_cover_l1_to_aiming_move_u45;
  var_0["exit_cover_corner_l"][4][4] = % space_cover_l1_to_aiming_move;
  var_0["exit_cover_corner_l"][4][5] = % space_cover_l1_to_aiming_move_d45;
  var_0["exit_cover_corner_l"][4][6] = % space_cover_l1_to_aiming_move_d90;
  var_0["exit_cover_corner_l"][5] = [];
  var_0["exit_cover_corner_l"][5][3] = % space_cover_l1_to_aiming_move_l45_u45;
  var_0["exit_cover_corner_l"][5][4] = % space_cover_l1_to_aiming_move_l45;
  var_0["exit_cover_corner_l"][5][5] = % space_cover_l1_to_aiming_move_l45_d45;
  var_0["exit_cover_corner_l"][6] = [];
  var_0["exit_cover_corner_l"][6][2] = % space_cover_l1_to_aiming_move_l90_u90;
  var_0["exit_cover_corner_l"][6][3] = % space_cover_l1_to_aiming_move_l90_u45;
  var_0["exit_cover_corner_l"][6][4] = % space_cover_l1_to_aiming_move_l90;
  var_0["exit_cover_corner_l"][6][5] = % space_cover_l1_to_aiming_move_l90_d45;
  var_0["exit_cover_corner_l"][6][6] = % space_cover_l1_to_aiming_move_l90_d90;
  var_0["exit_cover_corner_l"][7] = [];
  var_0["exit_cover_corner_l"][7][3] = % space_cover_l1_to_aiming_move_l135_u45;
  var_0["exit_cover_corner_l"][7][4] = % space_cover_l1_to_aiming_move_l135;
  var_0["exit_cover_corner_l"][7][5] = % space_cover_l1_to_aiming_move_l135_d45;
  var_0["exit_cover_corner_l"][8] = [];
  var_0["exit_cover_corner_l"][8][3] = % space_cover_l1_to_aiming_move_180_u45;
  var_0["exit_cover_corner_l"][8][4] = % space_cover_l1_exit_r180;
  var_0["exit_cover_corner_l"][8][5] = % space_cover_l1_to_aiming_move_180_d45;
  var_0["exit_cover_u"] = [];
  var_0["exit_cover_u"][0] = [];
  var_0["exit_cover_u"][0][3] = % space_cover_u1_to_aiming_move_180_u45;
  var_0["exit_cover_u"][0][4] = % space_cover_u1_to_aiming_move_180;
  var_0["exit_cover_u"][0][5] = % space_cover_u1_to_aiming_move_180_d45;
  var_0["exit_cover_u"][1] = [];
  var_0["exit_cover_u"][1][3] = % space_cover_u1_to_aiming_move_r135_u45;
  var_0["exit_cover_u"][1][4] = % space_cover_u1_to_aiming_move_r135;
  var_0["exit_cover_u"][1][5] = % space_cover_u1_to_aiming_move_r135_d45;
  var_0["exit_cover_u"][2] = [];
  var_0["exit_cover_u"][2][2] = % space_cover_u1_to_aiming_move_r90_u90;
  var_0["exit_cover_u"][2][3] = % space_cover_u1_to_aiming_move_r90_u45;
  var_0["exit_cover_u"][2][4] = % space_cover_u1_to_aiming_move_r90;
  var_0["exit_cover_u"][2][5] = % space_cover_u1_to_aiming_move_r90_d45;
  var_0["exit_cover_u"][2][6] = % space_cover_u1_to_aiming_move_r90_d90;
  var_0["exit_cover_u"][3] = [];
  var_0["exit_cover_u"][3][3] = % space_cover_u1_to_aiming_move_r45_u45;
  var_0["exit_cover_u"][3][4] = % space_cover_u1_to_aiming_move_r45;
  var_0["exit_cover_u"][3][5] = % space_cover_u1_to_aiming_move_r45;
  var_0["exit_cover_u"][4] = [];
  var_0["exit_cover_u"][4][2] = % space_cover_u1_to_aiming_move_u90;
  var_0["exit_cover_u"][4][3] = % space_cover_u1_to_aiming_move_u45;
  var_0["exit_cover_u"][4][4] = % space_cover_u1_to_aiming_move;
  var_0["exit_cover_u"][4][5] = % space_cover_u1_to_aiming_move;
  var_0["exit_cover_u"][4][6] = % space_cover_u1_to_aiming_move_d90;
  var_0["exit_cover_u"][5] = [];
  var_0["exit_cover_u"][5][3] = % space_cover_u1_to_aiming_move_l45_u45;
  var_0["exit_cover_u"][5][4] = % space_cover_u1_to_aiming_move_l45;
  var_0["exit_cover_u"][5][5] = % space_cover_u1_to_aiming_move_l45;
  var_0["exit_cover_u"][6] = [];
  var_0["exit_cover_u"][6][2] = % space_cover_u1_to_aiming_move_l90_u90;
  var_0["exit_cover_u"][6][3] = % space_cover_u1_to_aiming_move_l90_u45;
  var_0["exit_cover_u"][6][4] = % space_cover_u1_to_aiming_move_l90;
  var_0["exit_cover_u"][6][5] = % space_cover_u1_to_aiming_move_l90_d45;
  var_0["exit_cover_u"][6][6] = % space_cover_u1_to_aiming_move_l90_d90;
  var_0["exit_cover_u"][7] = [];
  var_0["exit_cover_u"][7][3] = % space_cover_u1_to_aiming_move_l135_u45;
  var_0["exit_cover_u"][7][4] = % space_cover_u1_to_aiming_move_l135;
  var_0["exit_cover_u"][7][5] = % space_cover_u1_to_aiming_move_l135_d45;
  var_0["exit_cover_u"][8] = [];
  var_0["exit_cover_u"][8][3] = % space_cover_u1_to_aiming_move_180_u45;
  var_0["exit_cover_u"][8][4] = % space_cover_u1_to_aiming_move_180;
  var_0["exit_cover_u"][8][5] = % space_cover_u1_to_aiming_move_180_d45;
  var_0["turn"] = [];
  var_0["turn"] = [];
  var_0["turn"][0] = [];
  var_0["turn"][0][4] = % space_swim_turn_l180;
  var_0["turn"][1] = [];
  var_0["turn"][1][4] = % space_swim_turn_l135;
  var_0["turn"][2] = [];
  var_0["turn"][2][4] = % space_swim_turn_l90;
  var_0["turn"][3] = [];
  var_0["turn"][3][3] = % space_swim_turn_d45_l45;
  var_0["turn"][3][4] = % space_swim_turn_l45;
  var_0["turn"][3][5] = % space_swim_turn_u45_l45;
  var_0["turn"][4] = [];
  var_0["turn"][4][3] = % space_swim_turn_d45;
  var_0["turn"][4][5] = % space_swim_turn_u45;
  var_0["turn"][5] = [];
  var_0["turn"][5][3] = % space_swim_turn_d45_r45;
  var_0["turn"][5][4] = % space_swim_turn_r45;
  var_0["turn"][5][5] = % space_swim_turn_u45_r45;
  var_0["turn"][6] = [];
  var_0["turn"][6][4] = % space_swim_turn_r90;
  var_0["turn"][7] = [];
  var_0["turn"][7][4] = % space_swim_turn_r135;
  var_0["turn"][8] = [];
  var_0["turn"][8][4] = % space_swim_turn_l180;
  var_0["turn_add_r"] = % space_slight_turn_r;
  var_0["turn_add_l"] = % space_slight_turn_l;
  var_0["turn_add_u"] = % space_slight_turn_u;
  var_0["turn_add_d"] = % space_slight_turn_d;
  var_0["cover_corner_r"] = [];
  var_0["cover_corner_r"]["straight_level"] = % space_fire;
  var_0["cover_corner_r"]["alert_idle"] = % space_cover_r1_loop;
  var_0["cover_corner_r"]["alert_idle_twitch"] = [ % space_cover_r1_twitch_right, % space_cover_r1_twitch_up, % space_cover_r1_twitch_back, % space_cover_r1_twitch_down, % space_cover_r1_twitch_left];
  var_0["cover_corner_r"]["alert_to_A"] = [ % space_cover_r1_full_expose];
  var_0["cover_corner_r"]["alert_to_B"] = [ % space_cover_r1_full_expose];
  var_0["cover_corner_r"]["A_to_alert"] = [ % space_cover_r1_full_hide];
  var_0["cover_corner_r"]["A_to_B"] = [ % space_fire];
  var_0["cover_corner_r"]["B_to_alert"] = [ % space_cover_r1_full_hide];
  var_0["cover_corner_r"]["B_to_A"] = [ % space_fire];
  var_0["cover_corner_r"]["lean_to_alert"] = [ % space_cover_r1_hide];
  var_0["cover_corner_r"]["alert_to_lean"] = [ % space_cover_r1_expose];
  var_0["cover_corner_r"]["look"] = % space_cover_r1_expose;
  var_0["cover_corner_r"]["reload"] = [ % space_cover_r1_reload];
  var_0["cover_corner_r"]["alert_to_look"] = % space_cover_r1_alert_to_look;
  var_0["cover_corner_r"]["look_to_alert"] = % space_cover_r1_look_to_alert;
  var_0["cover_corner_r"]["look_to_alert_fast"] = % space_cover_r1_look_to_alert;
  var_0["cover_corner_r"]["look_idle"] = % space_cover_r1_look_idle;
  var_0["cover_corner_r"]["lean_aim_down"] = % space_cover_r1_exposed_aim_d;
  var_0["cover_corner_r"]["lean_aim_left"] = % space_cover_r1_exposed_aim_l;
  var_0["cover_corner_r"]["lean_aim_straight"] = % space_cover_r1_exposed_fire;
  var_0["cover_corner_r"]["lean_aim_right"] = % space_cover_r1_exposed_aim_r;
  var_0["cover_corner_r"]["lean_aim_up"] = % space_cover_r1_exposed_aim_u;
  var_0["cover_corner_r"]["lean_reload"] = % space_cover_r1_reload;
  var_0["cover_corner_r"]["lean_idle"] = [ % space_cover_r1_exposed_idle];
  var_0["cover_corner_r"]["lean_single"] = % space_cover_r1_exposed_fire;
  var_0["cover_corner_r"]["lean_fire"] = % space_cover_r1_exposed_fire;
  var_0["cover_corner_r"]["add_aim_down"] = % space_fire_d;
  var_0["cover_corner_r"]["add_aim_left"] = % space_fire_l;
  var_0["cover_corner_r"]["add_aim_straight"] = % space_cover_r1_exposed_fire;
  var_0["cover_corner_r"]["add_aim_right"] = % space_fire_r;
  var_0["cover_corner_r"]["add_aim_up"] = % space_fire_u_extended;
  var_0["cover_corner_r"]["add_aim_idle"] = % space_firing_idle;
  var_0["cover_corner_l"] = [];
  var_0["cover_corner_l"]["straight_level"] = % space_fire;
  var_0["cover_corner_l"]["alert_idle"] = % space_cover_l1_idle;
  var_0["cover_corner_l"]["alert_idle_twitch"] = [ % space_cover_l1_twitch_right, % space_cover_l1_twitch_left, % space_cover_l1_twitch_down, % space_cover_l1_twitch_up, % space_cover_l1_twitch_back];
  var_0["cover_corner_l"]["alert_to_A"] = [ % space_cover_l1_full_expose];
  var_0["cover_corner_l"]["alert_to_B"] = [ % space_cover_l1_full_expose];
  var_0["cover_corner_l"]["A_to_alert"] = [ % space_cover_l1_full_hide];
  var_0["cover_corner_l"]["A_to_B"] = [ % space_fire];
  var_0["cover_corner_l"]["B_to_alert"] = [ % space_cover_l1_full_hide];
  var_0["cover_corner_l"]["B_to_A"] = [ % space_fire];
  var_0["cover_corner_l"]["lean_to_alert"] = [ % space_cover_l1_hide];
  var_0["cover_corner_l"]["alert_to_lean"] = [ % space_cover_l1_expose];
  var_0["cover_corner_l"]["look"] = % space_cover_l1_expose;
  var_0["cover_corner_l"]["reload"] = [ % space_cover_l1_reload];
  var_0["cover_corner_l"]["alert_to_look"] = % space_cover_l1_alert_to_look;
  var_0["cover_corner_l"]["look_to_alert"] = % space_cover_l1_look_to_alert;
  var_0["cover_corner_l"]["look_to_alert_fast"] = % space_cover_l1_look_to_alert;
  var_0["cover_corner_l"]["look_idle"] = % space_cover_l1_look_idle;
  var_0["cover_corner_l"]["lean_aim_down"] = % space_cover_l1_exposed_aim_d;
  var_0["cover_corner_l"]["lean_aim_left"] = % space_cover_l1_exposed_aim_l;
  var_0["cover_corner_l"]["lean_aim_straight"] = % space_cover_l1_exposed_fire;
  var_0["cover_corner_l"]["lean_aim_right"] = % space_cover_l1_exposed_aim_r;
  var_0["cover_corner_l"]["lean_aim_up"] = % space_cover_l1_exposed_aim_u;
  var_0["cover_corner_l"]["lean_reload"] = % space_cover_l1_reload;
  var_0["cover_corner_l"]["lean_idle"] = [ % space_cover_l1_exposed_idle];
  var_0["cover_corner_l"]["lean_single"] = % space_cover_l1_exposed_fire;
  var_0["cover_corner_l"]["lean_fire"] = % space_cover_l1_exposed_fire;
  var_0["cover_corner_l"]["add_aim_down"] = % space_fire_d;
  var_0["cover_corner_l"]["add_aim_left"] = % space_fire_l;
  var_0["cover_corner_l"]["add_aim_straight"] = % space_firing_burst2;
  var_0["cover_corner_l"]["add_aim_right"] = % space_fire_r;
  var_0["cover_corner_l"]["add_aim_up"] = % space_fire_u_extended;
  var_0["cover_corner_l"]["add_aim_idle"] = % space_firing_idle;
  var_0["cover_u"] = [];
  var_0["cover_u"]["straight_level"] = % space_fire;
  var_0["cover_u"]["alert_idle"] = % space_cover_u1_idle;
  var_0["cover_u"]["alert_idle_twitch"] = [ % space_cover_u1_twitch_right, % space_cover_u1_twitch_up, % space_cover_u1_twitch_back, % space_cover_u1_twitch_down, % space_cover_u1_twitch_left];
  var_0["cover_u"]["alert_to_A"] = [ % space_cover_u1_full_expose];
  var_0["cover_u"]["alert_to_B"] = [ % space_cover_u1_full_expose];
  var_0["cover_u"]["A_to_alert"] = [ % space_cover_u1_full_hide];
  var_0["cover_u"]["A_to_B"] = [ % space_fire];
  var_0["cover_u"]["B_to_alert"] = [ % space_cover_u1_full_hide];
  var_0["cover_u"]["B_to_A"] = [ % space_fire];
  var_0["cover_u"]["lean_to_alert"] = [ % space_cover_u1_hide];
  var_0["cover_u"]["alert_to_lean"] = [ % space_cover_u1_expose];
  var_0["cover_u"]["look"] = % space_cover_u1_expose;
  var_0["cover_u"]["reload"] = [ % space_cover_u1_reload];
  var_0["cover_u"]["alert_to_look"] = % space_cover_u1_alert_to_look;
  var_0["cover_u"]["look_to_alert"] = % space_cover_u1_look_to_alert;
  var_0["cover_u"]["look_to_alert_fast"] = % space_cover_u1_look_to_alert;
  var_0["cover_u"]["look_idle"] = % space_cover_u1_look_idle;
  var_0["cover_u"]["lean_aim_down"] = % space_cover_u1_exposed_aim_d;
  var_0["cover_u"]["lean_aim_left"] = % space_cover_u1_exposed_aim_l;
  var_0["cover_u"]["lean_aim_straight"] = % space_cover_u1_exposed_fire;
  var_0["cover_u"]["lean_aim_right"] = % space_cover_u1_exposed_aim_r;
  var_0["cover_u"]["lean_aim_up"] = % space_cover_u1_exposed_aim_u;
  var_0["cover_u"]["lean_reload"] = % space_cover_u1_reload;
  var_0["cover_u"]["lean_idle"] = [ % space_cover_u1_exposed_idle];
  var_0["cover_u"]["lean_single"] = % space_cover_u1_exposed_fire;
  var_0["cover_u"]["lean_fire"] = % space_cover_u1_exposed_fire;
  var_0["cover_u"]["add_aim_down"] = % space_fire_d;
  var_0["cover_u"]["add_aim_left"] = % space_fire_l;
  var_0["cover_u"]["add_aim_straight"] = % space_firing_burst2;
  var_0["cover_u"]["add_aim_right"] = % space_fire_r;
  var_0["cover_u"]["add_aim_up"] = % space_fire_u_extended;
  var_0["cover_u"]["add_aim_idle"] = % space_firing_idle;
  anim.archetypes["soldier"]["swim"] = var_0;
  anim.archetypes["soldier"]["swim"]["maxDelta"] = [];
  init_space_anim_deltas("soldier", "arrival_exposed");
  init_space_anim_deltas("soldier", "arrival_exposed_noncombat");
  init_space_anim_deltas("soldier", "arrival_cover_corner_r");
  init_space_anim_deltas("soldier", "arrival_cover_corner_l");
  init_space_anim_deltas("soldier", "arrival_cover_u");
  init_space_anim_deltas("soldier", "exit_cover_corner_r", 0);
  init_space_anim_deltas("soldier", "exit_cover_corner_l", 0);
  init_space_anim_deltas("soldier", "exit_cover_u", 0);
  init_space_anim_deltas("soldier", "idle_to_forward", 0);
}

init_space_anim_deltas(var_0, var_1, var_2) {
  var_3 = var_1 + "_delta";
  var_4 = var_1 + "_angleDelta";
  var_5 = 1;

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

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

        if(var_12 > var_8) {
          var_8 = var_12;
        }
      }
    }

    if(var_5) {
      anim.archetypes[var_0]["swim"][var_1]["maxDelta"] = sqrt(var_8);
    }
  }
}

init_ai_space_animsets() {
  self.customidleanimset = [];
  self.customidleanimset["stand"] = % space_idle;
  self.a.pose = "stand";
  self allowedstances("stand");
  var_0 = anim.archetypes["soldier"]["default_stand"];
  var_0["straight_level"] = % space_idle_ready;
  var_0["add_aim_up"] = % space_idle_ready_aim_u_extended;
  var_0["add_aim_down"] = % space_idle_ready_aim_d_extended;
  var_0["add_aim_left"] = % space_idle_ready_aim_l;
  var_0["add_aim_right"] = % space_idle_ready_aim_r;
  var_0["fire"] = % space_firing_burst2;
  var_0["single"] = [ % space_firing_burst2];
  var_0["burst2"] = % space_firing_burst2;
  var_0["burst3"] = % space_firing_burst3;
  var_0["burst4"] = % space_firing_burst2;
  var_0["burst5"] = % space_firing_burst2;
  var_0["burst6"] = % space_firing_burst2;
  var_0["semi2"] = % space_firing_burst2;
  var_0["semi3"] = % space_firing_burst2;
  var_0["semi4"] = % space_firing_burst2;
  var_0["semi5"] = % space_firing_burst2;
  var_0["exposed_idle"] = [ % space_firing_idle];
  var_0["reload"] = [ % space_reload];
  var_0["reload_crouchhide"] = [ % space_reload];
  var_0["turn_left_45"] = % space_aiming_turn_l45;
  var_0["turn_left_90"] = % space_aiming_turn_l90;
  var_0["turn_left_135"] = % space_aiming_turn_l135;
  var_0["turn_left_180"] = % space_aiming_turn_l180;
  var_0["turn_right_45"] = % space_aiming_turn_r45;
  var_0["turn_right_90"] = % space_aiming_turn_r90;
  var_0["turn_right_135"] = % space_aiming_turn_r135;
  var_0["turn_right_180"] = % space_aiming_turn_r180;
  animscripts\animset::init_animset_complete_custom_stand(var_0);
  animscripts\animset::init_animset_complete_custom_crouch(var_0);
  self.painfunction = ::ai_space_pain;
  self.deathfunction = ::ai_space_death;
}

ai_space_pain() {
  if(self.a.movement == "run") {
    var_0 = 27225;
    var_1 = vectordot(self.lookaheaddir, anglesToForward(self.angles));

    if(distance2dsquared(self.origin, self.goalpos) > var_0 && var_1 > 0.5) {
      var_2 = % space_pain_1;
    }
    else {
      var_2 = common_scripts\utility::random([ % space_firing_pain_1, % space_firing_pain_2]);
    }

    self orientmode("face motion");
  } else
    var_2 = common_scripts\utility::random([ % space_firing_pain_1, % space_firing_pain_2]);

  var_3 = 1;
  self setflaggedanimknoballrestart("painanim", var_2, % body, 1, 0.1, var_3);

  if(self.a.pose == "prone") {
    self updateprone( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);
  }

  if(animhasnotetrack(var_2, "start_aim")) {
    thread animscripts\pain::notifystartaim("painanim");
    self endon("start_aim");
  }

  if(animhasnotetrack(var_2, "code_move")) {
    animscripts\shared::donotetracks("painanim");
  }

  animscripts\shared::donotetracks("painanim");
}

unlimited_ammo() {
  self endon("death");

  for(;;) {
    self.a.rockets = 100;
    wait 0.2;
  }
}

ai_space_death() {
  playFXOnTag(common_scripts\utility::getfx("bloodpool_zerog"), self, "j_spineupper");

  if(!common_scripts\utility::flag("no_steam_on_death")) {
    playFXOnTag(common_scripts\utility::getfx("space_death_steam"), self, "J_Neck");
  }

  var_0 = animscripts\pain::wasdamagedbyexplosive();

  if(!isDefined(self.deathanim) && var_0 && self.damagelocation == "none") {
    if(self.damageyaw > 135 || self.damageyaw <= -135) {
      self.deathanim = % space_explosion_death_b_1;
    }
    else if(self.damageyaw > 45 && self.damageyaw <= 135) {
      self.deathanim = % space_explosion_death_l_1;
    }
    else if(self.damageyaw > -45 && self.damageyaw <= 45) {
      self.deathanim = % space_explosion_death_f_1;
    }
    else {
      self.deathanim = % space_explosion_death_r_1;
    }
  }

  if(!isDefined(self.deathanim)) {
    if(self.damageyaw > -60 && self.damageyaw <= 60) {
      self.deathanim = % space_idle_death_behind;
    }
    else if(self.a.movement == "run") {
      self.deathanim = % space_death_1;
    }
    else if(animscripts\utility::damagelocationisany("left_arm_upper")) {
      self.deathanim = % space_firing_death_1;
    }
    else if(animscripts\utility::damagelocationisany("head", "helmet")) {
      self.deathanim = % space_firing_death_2;
    }
    else if(animscripts\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      self.deathanim = % space_firing_death_3;
    }
    else {
      self.deathanim = common_scripts\utility::random([ % space_firing_death_1, % space_firing_death_2, % space_firing_death_3]);
    }
  }

  if(!isDefined(self.nodeathsound) && !isDefined(self.diequietly)) {
    animscripts\death::playdeathsound();
  }

  thread sfx_npc_death();
  thread ai_space_headshot_death();
  return 0;
}

ai_space_headshot_death() {
  if(self.damagelocation == "head" || self.damagelocation == "neck") {
    if(self.model == "us_space_assault_a_body" || self.model == "us_space_assault_b_body" || self.model == "body_fed_space_assault_a" || self.model == "body_fed_space_assault_b") {
      playFXOnTag(common_scripts\utility::getfx("space_headshot"), self, "J_Head");
      self setModel(self.model + "_cracked");

      if(gettimescale() < 0.5) {
        self playSound("space_npc_helmet_shatter_slomo");
      }
      else {
        self playSound("space_npc_helmet_shatter");
      }
    }
  }
}

sfx_npc_death() {
  if(level.play_npc_deaths == 1) {
    self playSound("space_npc_death");
  }
}

space_actor_lights() {
  self endon("death");
  self endon("faux_death");
  maps\_utility::ent_flag_init("lights_on");
  maps\_utility::ent_flag_set("lights_on");

  if(isalive(self)) {
    if(self.model == "body_fed_space_assault_a" || self.model == "body_fed_space_assault_b") {
      var_0 = common_scripts\utility::getfx("enemy_light");
      playFXOnTag(var_0, self, "tag_light_left");
      maps\_utility::delaythread(0.05, ::space_actor_lights_kill, var_0, "tag_light_left");
    } else if(self.model == "us_space_assault_a_body" || self.model == "us_space_assault_b_body") {
      var_0 = common_scripts\utility::getfx("ally_light");
      maps\_utility::delaythread(0.05, ::space_actor_lights_kill, var_0, "tag_light_back");

      while(isalive(self)) {
        if(maps\_utility::ent_flag("lights_on")) {
          playFXOnTag(var_0, self, "tag_light_back");
          wait 0.15;
          stopFXOnTag(var_0, self, "tag_light_back");
          wait 0.15;
          playFXOnTag(var_0, self, "tag_light_back");
          wait 0.15;
          stopFXOnTag(var_0, self, "tag_light_back");
          wait(randomfloatrange(1, 3));
          continue;
        }

        stopFXOnTag(var_0, self, "tag_light_back");
        common_scripts\utility::waitframe();
      }
    }
  }
}

space_actor_lights_kill(var_0, var_1) {
  common_scripts\utility::waittill_any("death", "faux_death");

  if(isDefined(self) && maps\_utility::ent_flag("lights_on")) {
    killfxontag(var_0, self, var_1);
  }

  var_2 = 0.15;

  for(var_3 = 0; var_3 < 5; var_3++) {
    if(isDefined(self) && maps\_utility::ent_flag("lights_on")) {
      playFXOnTag(var_0, self, var_1);
    }

    wait(var_2);

    if(isDefined(self) && maps\_utility::ent_flag("lights_on")) {
      killfxontag(var_0, self, var_1);
    }

    wait(var_2);
  }
}

space_blood() {
  self endon("death");
  self endon("styptic");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 != "MOD_EXPLOSIVE") {
      if(var_2 != (0, 0, 0)) {
        playFX(common_scripts\utility::getfx("blood_impact_space"), var_3, var_2);
      }
    }
  }
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
      if(distancesquared(self.origin, self.enemy.origin) > 65536) {
        playFXOnTag(var_0, self, "tag_eye");
      }

      var_1 = randomfloatrange(3, 5);
      wait(var_1);
    }

    wait 0.2;
  }
}

doing_in_space_rotation(var_0, var_1, var_2, var_3) {
  self endon("stop_rotation");
  self endon("death");

  if(isDefined(var_3) && var_3 == 1) {
    self.turnrate = animscripts\swim::space_getorientturnrate();
  }

  if(isDefined(var_2) && var_2 > 1) {
    for(var_4 = 0; var_4 < var_2; var_4++) {
      var_5 = fake_slerp(var_0, var_1, var_4 / var_2);
      self orientmode("face angle 3d", var_5, 1);
      wait 0.05;
    }
  } else
    self orientmode("face angle 3d", var_1);

  if(isDefined(var_3) && var_3 == 1) {
    var_6 = gettime();
    var_7 = 2000;

    for(;;) {
      if(gettime() > var_6 + var_7 || angles_within(var_1, 15, 15, 15)) {
        if(self.turnrate == animscripts\swim::space_getorientturnrate()) {
          self.turnrate = animscripts\swim::space_getdefaultturnrate();
        }

        return;
      }

      wait 0.1;
    }
  }
}

fake_slerp(var_0, var_1, var_2) {
  return (angle_lerp(var_0[0], var_1[0], var_2), angle_lerp(var_0[1], var_1[1], var_2), angle_lerp(var_0[2], var_1[2], var_2));
}

angle_lerp(var_0, var_1, var_2) {
  return angleclamp(var_0 + angleclamp180(var_1 - var_0) * var_2);
}

force_actor_upright() {
  var_0 = (self.angles[0], self.angles[1], 0);
  thread doing_in_space_rotation(self.angles, var_0, 1, 1);
}

force_actor_space_rotation_update(var_0, var_1, var_2) {
  if(isDefined(var_0) && var_0) {
    if(!isDefined(self.nextforceorienttime) || gettime() < self.nextforceorienttime) {
      return;
    }
  }

  var_3 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_3 = var_2;
  }
  else if(isDefined(self.node)) {
    var_3 = animscripts\utility::gettruenodeangles(self.node);

    if((self.node.type == "Cover Right 3D" || self.node.type == "Cover Left 3D") && isDefined(self.hideyawoffset)) {
      var_3 = combineangles(var_3, (0, self.hideyawoffset, 0));
    }
    else if(!isDefined(self.hideyawoffset)) {
      if(self.node.type == "Cover Left 3D") {
        var_4 = anim.archetypes["soldier"]["swim"]["arrival_cover_corner_l_angleDelta"][4][4];
        var_3 = combineangles(var_3, (0, var_4[1], 0));
      } else if(self.node.type == "Cover Right 3D") {
        var_4 = anim.archetypes["soldier"]["swim"]["arrival_cover_corner_r_angleDelta"][4][4];
        var_3 = combineangles(var_3, (0, var_4[1], 0));
      }
    }
  } else
    return;

  if(isDefined(var_1) && var_1) {
    doing_in_space_rotation(self.angles, var_3, 1);
  }
  else {
    thread doing_in_space_rotation(self.angles, var_3, 1);
  }

  if(isDefined(self.nextforceorienttime)) {
    self.nextforceorienttime = gettime() + 6500;
  }
}

force_rotation_update_listener() {
  self endon("death");

  for(;;) {
    self waittill("force_space_rotation_update", var_0, var_1, var_2, var_3);

    if(isDefined(var_3)) {
      force_actor_upright();
      continue;
    }

    force_actor_space_rotation_update(var_0, var_1, var_2);
  }
}

angles_within(var_0, var_1, var_2, var_3) {
  if(self.angles[0] < var_0[0] + var_1 && self.angles[0] > var_0[0] - var_1) {
    if(self.angles[1] < var_0[1] + var_2 && self.angles[1] > var_0[1] - var_2) {
      if(self.angles[2] < var_0[2] + var_3 && self.angles[2] > var_0[2] - var_3) {
        return 1;
      }
    }
  }

  return 0;
}

clear_actor_space_rotation() {
  thread doing_in_space_rotation(self.angles, (self.angles[0], self.angles[1], 0), 1);
}

smart_radio_dialogue_facial(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    return;
  }
  maps\_utility_code::add_to_radio(var_0);
  thread maps\_utility::radio_dialogue(var_0, var_2);
  maps\_utility::bcs_scripted_dialogue_start();
  maps\_anim::anim_single_queue(self, var_1);
}