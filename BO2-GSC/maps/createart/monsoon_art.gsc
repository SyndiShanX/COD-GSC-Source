/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createart\monsoon_art.gsc
******************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  setsaveddvar("r_rimIntensity_debug", 1);
  setsaveddvar("r_rimIntensity", 15);
  setsaveddvar("r_lightGridEnableTweaks", 1);
  setsaveddvar("r_lightGridIntensity", 1);
  setsaveddvar("r_lightGridContrast", 0);
}

intro_vision() {
  level.player visionsetnaked("sp_monsoon_binoc", 0);
}

harper_reveal_vision() {
  level.player visionsetnaked("sp_monsoon_intro_start", 0);
}

suit_fly_vision() {
  level.player visionsetnaked("sp_monsoon_flying", 0);
}

exterior_vision() {
  level.player visionsetnaked("sp_monsoon_outer_ruins", 0);
}

interior_ruins_vision() {
  level.player visionsetnaked("sp_monsoon_ruins_hallway", 0);
}

lab_vision() {
  level.player camo_vision_set_naked("sp_monsoon_lab", 2);
}

defend_vision() {
  level.player camo_vision_set_naked("sp_monsoon_defend_off", 2);
}

celerium_chamber_vision() {
  level.player camo_vision_set_naked("sp_monsoon_celerium", 2);
}

lightning_vision() {
  level.player visionsetnaked("sp_monsoon_lightning", 0);
}

camo_vision_set_naked(str_vision, n_time) {
  if(level.player ent_flag_exist("camo_suit_on") && level.player ent_flag("camo_suit_on"))
    self.str_old_vision = str_vision;
  else
    self visionsetnaked(str_vision, n_time);
}

intro_dof_look_down(m_player_body) {
  iprintlnbold("DOF:intro_DOF_look_down");

  level.player depth_of_field_tween(8, 20, 4000, 5000, 4, 0.5, 0.2);
}

intro_dof_look_harper(m_player_body) {
  iprintlnbold("DOF:intro_DOF_look_harper");

  level.player depth_of_field_tween(8, 20, 100, 1000, 4, 0.5, 0.5);
}

intro_dof_look_rhand(m_player_body) {
  iprintlnbold("DOF:intro_DOF_look_rhand");

  level.player depth_of_field_tween(8, 20, 200, 1000, 4, 0.5, 0.5);
  wait 1;
  level.player depth_of_field_off(0.5);
}

intro_dof_rhand_plant(m_player_body) {
}

intro_dof_look_left(m_player_body) {
}

intro_dof_lhand_plant(m_player_body) {
}

intro_dof_grab_rope(m_player_body) {
}

treefall_dof_look_down(m_player_body) {
  iprintlnbold("DOF:treefall_DOF_look_down");

  level.player depth_of_field_tween(8, 30, 150, 300, 4, 1, 0.2);
}

treefall_dof_look_harper_1(m_player_body) {
  iprintlnbold("DOF:treefall_DOF_look_harper_1");

  level.player depth_of_field_tween(8, 60, 200, 300, 4, 1, 0.2);
}

treefall_dof_look_tree(m_player_body) {
  iprintlnbold("DOF:treefall_DOF_look_tree");

  level.player depth_of_field_tween(8, 60, 250, 400, 4, 1, 0.2);
}

treefall_dof_tree_impact(m_player_body) {
  iprintlnbold("DOF:treefall_DOF_tree_impact");

  level.player depth_of_field_tween(8, 30, 150, 300, 4, 1, 0.2);
}

treefall_dof_rope_pulls(m_player_body) {
  iprintlnbold("DOF:treefall_DOF_rope_pulls");

  level.player depth_of_field_tween(8, 20, 100, 200, 4, 1, 0.2);
}

treefall_dof_salazar_arrives(m_player_body) {
  iprintlnbold("DOF:treefall_DOF_salazar_arrives");

  level.player depth_of_field_tween(8, 40, 150, 300, 4, 1, 0.2);
}

treefall_dof_rope_cut(m_player_body) {
  iprintlnbold("DOF:treefall_DOF_rope_cut");

  level.player depth_of_field_tween(8, 20, 75, 300, 4, 1, 0.2);
}

treefall_dof_look_salazar(m_player_body) {
  iprintlnbold("DOF:treefall_DOF_look_salazar");

  level.player depth_of_field_tween(8, 40, 150, 300, 4, 1, 0.2);
}

treefall_dof_get_up(m_player_body) {
  iprintlnbold("DOF:treefall_DOF_get_up");

  level.player depth_of_field_off(0.5);
}

treefall_dof_look_harper_2(m_player_body) {
}

chamber_dof_chamber_center(m_player_body) {
  iprintlnbold("DOF:chamber_DOF_chamber_center");
}

chamber_dof_project_wall(m_player_body) {
  iprintlnbold("DOF:chamber_DOF_project_wall");
}

chamber_dof_walk_up(m_player_body) {
  iprintlnbold("DOF:chamber_DOF_walk_up");
}

chamber_dof_look_back(m_player_body) {
  iprintlnbold("DOF:chamber_DOF_look_back");

  level.player depth_of_field_tween(8, 10, 200, 600, 4, 2, 1);
}

chamber_dof_back_to_device(m_player_body) {
  iprintlnbold("DOF:chamber_DOF_back_to_device");

  level.player depth_of_field_tween(8, 10, 150, 300, 4, 2, 1);
}

chamber_dof_erik_device(m_player_body) {
  iprintlnbold("DOF:chamber_DOF_erik_device");

  level.player depth_of_field_tween(8, 10, 150, 300, 4, 2, 0.2);
}

chamber_dof_take_device(m_player_body) {
  iprintlnbold("DOF:chamber_DOF_take_device");

  level.player depth_of_field_tween(2, 5, 50, 150, 4, 2, 0.2);
}

chamber_dof_look_at_erik(m_player_body) {
  iprintlnbold("DOF:chamber_DOF_erik_device");

  level.player depth_of_field_tween(8, 10, 150, 300, 4, 3, 0.2);
}

chamber_dof_look_at_harper(m_player_body) {
  iprintlnbold("DOF:chamber_DOF_look_at_harper");

  level.player depth_of_field_tween(8, 10, 100, 300, 4, 3, 0.2);
}

chamber_dof_look_erik_2(m_player_body) {
  iprintlnbold("DOF:chamber_DOF_look_erik_2");

  level.player depth_of_field_tween(8, 10, 100, 300, 4, 3, 0.2);
  wait 18;
  level.player depth_of_field_off(2);
}

briggs_ending_dof() {
  iprintlnbold("DOF:chamber_DOF_look_at_harper");

  level.player depth_of_field_tween(8, 10, 150, 300, 4, 3, 2);
}

dof_reset(m_player_body) {
}

_lightning() {
  level endon("_rain_lightning");

  while(isalive(level.player)) {
    wait(randomfloatrange(5.0, 10.0));

    if(!is_true(level.lightning_strike)) {
      level.lightning_strike = 1;
      v_p_angles = level.player getplayerangles();
      v_forward = anglestoforward(level.player getplayerangles()) * 25000;
      v_end_pos = level.player.origin + (v_forward[0], v_forward[1], 0);
      v_offset = (randomintrange(-5000, 5000), randomintrange(-5000, 5000), randomint(3000));
      v_end_pos = v_end_pos + v_offset;
      playfx(getfx("fx_lightning_flash_single_lg"), v_end_pos);
      wait(randomfloatrange(0.2, 0.3));
      n_level_sunlight = getdvarfloat(#"r_lightTweakSunLight");
      n_level_exposure = getdvarfloat(#"r_exposureValue");
      n_strikes = randomintrange(3, 5);

      for(i = 0; i < n_strikes; i++) {
        n_blend_time = randomfloatrange(0.1, 0.35);
        setdvar("r_exposureTweak", 1);
        playsoundatposition("amb_thunder_flash", v_end_pos);
        setdvar("r_exposureValue", randomfloatrange(-1, 1));
        level thread lerp_dvar("r_exposureValue", n_level_exposure, n_blend_time);
        setsaveddvar("r_lightTweakSunLight", randomfloatrange(28, 32));
        level thread lerp_dvar("r_lightTweakSunLight", n_level_sunlight, n_blend_time, 1);
        wait(n_blend_time);
        setdvar("r_exposureTweak", 0);
      }

      level.lightning_strike = undefined;
    }
  }
}

lightning_strike() {
  if(!is_true(level.lightning_strike)) {
    level.lightning_strike = 1;
    v_p_angles = level.player getplayerangles();
    v_forward = anglestoforward(level.player getplayerangles()) * 25000;
    v_end_pos = level.player.origin + (v_forward[0], v_forward[1], 0);
    v_offset = (randomintrange(-5000, 5000), randomintrange(-5000, 5000), randomint(3000));
    v_end_pos = v_end_pos + v_offset;
    playfx(getfx("fx_lightning_flash_single_lg"), v_end_pos);
    wait(randomfloatrange(0.2, 0.3));
    n_level_sunlight = getdvarfloat(#"r_lightTweakSunLight");
    n_level_exposure = getdvarfloat(#"r_exposureValue");
    n_strikes = randomintrange(3, 5);

    for(i = 0; i < n_strikes; i++) {
      n_blend_time = randomfloatrange(0.1, 0.35);
      setdvar("r_exposureTweak", 1);
      setdvar("r_exposureValue", randomfloatrange(-1, 1));
      level thread lerp_dvar("r_exposureValue", n_level_exposure, n_blend_time);
      setsaveddvar("r_lightTweakSunLight", randomfloatrange(28, 32));
      level thread lerp_dvar("r_lightTweakSunLight", n_level_sunlight, n_blend_time, 1);
      wait(n_blend_time);
      setdvar("r_exposureTweak", 0);
    }

    level.lightning_strike = undefined;
  }
}