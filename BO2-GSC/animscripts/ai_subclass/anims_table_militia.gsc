/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\ai_subclass\anims_table_militia.gsc
*****************************************************************/

#include common_scripts\utility;
#include animscripts\anims;
#using_animtree("generic_human");

setup_militia_anim_array() {
  assert(self.subclass == "militia");
  subclasstype = self.subclass;

  if(isDefined(anim.anim_array[subclasstype])) {
    return;
  }
  self animscripts\anims::clearanimcache();
  anim.anim_array[subclasstype] = [];
  anim.anim_array[subclasstype]["cover_left"]["stand"]["rifle"]["rambo"] = array( % ai_militia_corner_standl_fire90_01, % ai_militia_corner_standl_fire90_02, % ai_militia_corner_standl_fire90_03);
  anim.anim_array[subclasstype]["cover_left"]["stand"]["rifle"]["rambo_45"] = array( % ai_militia_corner_standl_fire45_01, % ai_militia_corner_standl_fire45_02);
  anim.anim_array[subclasstype]["cover_left"]["stand"]["rifle"]["rambo_add_aim_up"] = % ai_militia_rambo_fireidle_aim8;
  anim.anim_array[subclasstype]["cover_left"]["stand"]["rifle"]["rambo_add_aim_down"] = % ai_militia_rambo_fireidle_aim2;
  anim.anim_array[subclasstype]["cover_left"]["stand"]["rifle"]["rambo_add_aim_left"] = % ai_militia_rambo_fireidle_aim4;
  anim.anim_array[subclasstype]["cover_left"]["stand"]["rifle"]["rambo_add_aim_right"] = % ai_militia_rambo_fireidle_aim6;
  anim.anim_array[subclasstype]["cover_left"]["stand"]["rifle"]["grenade_rambo"] = % ai_militia_corner_standl_grenade;
  anim.anim_array[subclasstype]["cover_left"]["crouch"]["rifle"]["rambo"] = array( % ai_militia_cornercrouch_l_fire_high, % ai_militia_cornercrouch_l_fire_mid);
  anim.anim_array[subclasstype]["cover_left"]["crouch"]["rifle"]["rambo_add_aim_up"] = % ai_militia_rambo_fireidle_aim8;
  anim.anim_array[subclasstype]["cover_left"]["crouch"]["rifle"]["rambo_add_aim_down"] = % ai_militia_rambo_fireidle_aim2;
  anim.anim_array[subclasstype]["cover_left"]["crouch"]["rifle"]["rambo_add_aim_left"] = % ai_militia_rambo_fireidle_aim4;
  anim.anim_array[subclasstype]["cover_left"]["crouch"]["rifle"]["rambo_add_aim_right"] = % ai_militia_rambo_fireidle_aim6;
  anim.anim_array[subclasstype]["cover_right"]["stand"]["rifle"]["rambo"] = array( % ai_militia_corner_standr_fire90_01, % ai_militia_corner_standr_fire90_02, % ai_militia_corner_standr_fire90_03);
  anim.anim_array[subclasstype]["cover_right"]["stand"]["rifle"]["rambo_45"] = array( % ai_militia_corner_standr_fire45_01, % ai_militia_corner_standr_fire45_02, % ai_militia_corner_standr_fire45_03);
  anim.anim_array[subclasstype]["cover_right"]["stand"]["rifle"]["rambo_add_aim_up"] = % ai_militia_rambo_fireidle_aim8;
  anim.anim_array[subclasstype]["cover_right"]["stand"]["rifle"]["rambo_add_aim_down"] = % ai_militia_rambo_fireidle_aim2;
  anim.anim_array[subclasstype]["cover_right"]["stand"]["rifle"]["rambo_add_aim_left"] = % ai_militia_rambo_fireidle_aim4;
  anim.anim_array[subclasstype]["cover_right"]["stand"]["rifle"]["rambo_add_aim_right"] = % ai_militia_rambo_fireidle_aim6;
  anim.anim_array[subclasstype]["cover_right"]["stand"]["rifle"]["grenade_rambo"] = % ai_militia_corner_standr_grenade;
  anim.anim_array[subclasstype]["cover_right"]["crouch"]["rifle"]["rambo"] = array( % ai_militia_cornercrouch_r_fire_high, % ai_militia_cornercrouch_r_fire_low, % ai_militia_cornercrouch_r_fire_mid);
  anim.anim_array[subclasstype]["cover_right"]["crouch"]["rifle"]["rambo_add_aim_up"] = % ai_militia_rambo_fireidle_aim8;
  anim.anim_array[subclasstype]["cover_right"]["crouch"]["rifle"]["rambo_add_aim_down"] = % ai_militia_rambo_fireidle_aim2;
  anim.anim_array[subclasstype]["cover_right"]["crouch"]["rifle"]["rambo_add_aim_left"] = % ai_militia_rambo_fireidle_aim4;
  anim.anim_array[subclasstype]["cover_right"]["crouch"]["rifle"]["rambo_add_aim_right"] = % ai_militia_rambo_fireidle_aim6;
  anim.anim_array[subclasstype]["cover_crouch"]["crouch"]["rifle"]["rambo"] = array( % ai_militia_cover_crouch_fire_01, % ai_militia_cover_crouch_fire_02, % ai_militia_cover_crouch_fire_03);
  anim.anim_array[subclasstype]["cover_crouch"]["crouch"]["rifle"]["rambo_add_aim_up"] = % ai_militia_rambo_fireidle_aim8;
  anim.anim_array[subclasstype]["cover_crouch"]["crouch"]["rifle"]["rambo_add_aim_down"] = % ai_militia_rambo_fireidle_aim2;
  anim.anim_array[subclasstype]["cover_crouch"]["crouch"]["rifle"]["rambo_add_aim_left"] = % ai_militia_rambo_fireidle_aim4;
  anim.anim_array[subclasstype]["cover_crouch"]["crouch"]["rifle"]["rambo_add_aim_right"] = % ai_militia_rambo_fireidle_aim6;
  anim.anim_array[subclasstype]["cover_crouch"]["crouch"]["rifle"]["rambo_jam"] = array( % ai_militia_cover_crouch_gunjama, % ai_militia_cover_crouch_gunjamb);
  anim.anim_array[subclasstype]["cover_crouch"]["crouch"]["rifle"]["grenade_rambo"] = % ai_militia_cover_crouch_grenadefirea;
  anim.anim_array[subclasstype]["cover_stand"]["stand"]["rifle"]["rambo"] = array( % ai_militia_cover_stand_firea, % ai_militia_cover_stand_fireb, % ai_militia_cover_stand_firec);
  anim.anim_array[subclasstype]["cover_stand"]["stand"]["rifle"]["rambo_add_aim_up"] = % ai_militia_rambo_fireidle_aim8;
  anim.anim_array[subclasstype]["cover_stand"]["stand"]["rifle"]["rambo_add_aim_down"] = % ai_militia_rambo_fireidle_aim2;
  anim.anim_array[subclasstype]["cover_stand"]["stand"]["rifle"]["rambo_add_aim_left"] = % ai_militia_rambo_fireidle_aim4;
  anim.anim_array[subclasstype]["cover_stand"]["stand"]["rifle"]["rambo_add_aim_right"] = % ai_militia_rambo_fireidle_aim6;
  anim.anim_array[subclasstype]["cover_stand"]["stand"]["rifle"]["rambo_jam"] = array( % ai_militia_cover_stand_gunjama, % ai_militia_cover_stand_gunjamb);
  anim.anim_array[subclasstype]["cover_stand"]["stand"]["rifle"]["grenade_rambo"] = % ai_militia_cover_stand_grenadefirea;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["combat_run_f"] = % ai_militia_run_lowready_f;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["run_n_gun_r"] = % ai_militia_run_n_gun_r;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["run_n_gun_l"] = % ai_militia_run_n_gun_l;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["run_n_gun_l_120"] = % ai_militia_run_n_gun_l_120;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["run_n_gun_r_120"] = % ai_militia_run_n_gun_r_120;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_l_aim_up"] = % ai_militia_run_n_gun_l_aim_8;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_l_aim_down"] = % ai_militia_run_n_gun_l_aim_2;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_l_aim_left"] = % ai_militia_run_n_gun_l_aim_4;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_l_aim_right"] = % ai_militia_run_n_gun_l_aim_6;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_r_aim_up"] = % ai_militia_run_n_gun_r_aim_8;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_r_aim_down"] = % ai_militia_run_n_gun_r_aim_2;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_r_aim_left"] = % ai_militia_run_n_gun_r_aim_4;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_r_aim_right"] = % ai_militia_run_n_gun_r_aim_6;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_l_120_aim_up"] = % ai_militia_run_n_gun_l_120_aim_8;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_l_120_aim_down"] = % ai_militia_run_n_gun_l_120_aim_2;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_l_120_aim_left"] = % ai_militia_run_n_gun_l_120_aim_4;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_l_120_aim_right"] = % ai_militia_run_n_gun_l_120_aim_6;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_r_120_aim_up"] = % ai_militia_run_n_gun_r_120_aim_8;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_r_120_aim_down"] = % ai_militia_run_n_gun_r_120_aim_2;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_r_120_aim_left"] = % ai_militia_run_n_gun_r_120_aim_4;
  anim.anim_array[subclasstype]["move"]["stand"]["rifle"]["add_r_120_aim_right"] = % ai_militia_run_n_gun_r_120_aim_6;
}