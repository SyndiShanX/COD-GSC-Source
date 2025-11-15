/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\aitype\aitype_bigdog.gsc
************************************************/

precache() {
  precacheturret("bigdog_dual_turret");
  precachemodel("veh_t6_drone_claw_mk2_turret_alt");
  loadfx("env/electrical/fx_elec_bigdog_spark_lg_runner");
  loadfx("destructibles/fx_claw_exp_death");
  loadfx("destructibles/fx_claw_metal_scrape_sparks");
  loadfx("destructibles/fx_claw_exp_panel");
  loadfx("destructibles/fx_claw_exp_panel_lg");
  loadfx("destructibles/fx_claw_exp_leg_break");
  loadfx("destructibles/fx_claw_dmg_smk_lt");
  loadfx("dirt/fx_dust_impact_claw");
  loadfx("light/fx_vlight_claw_eye_grn");
  loadfx("light/fx_vlight_claw_eye_red");
  loadfx("electrical/fx_elec_sp_emp_stun_claw");
  loadfx("electrical/fx_elec_claw_leg_joint_med");
  loadfx("electrical/fx_elec_claw_leg_joint_med_lft");
  loadfx("env/electrical/fx_elec_bigdog_spark_os");
  loadfx("weapon/crossbow/fx_trail_crossbow_blink_grn_os");
  loadfx("weapon/crossbow/fx_trail_crossbow_blink_red_os");
}