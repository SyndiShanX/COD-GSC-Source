/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2557.gsc
************************/

main() {}

soldier() {
  level.var_7649["human_gib_fullbody"] = loadfx("vfx\iw7\core\impact\flesh\vfx_flesh_hit_body_meatbag_large.vfx");
  level.var_7649["human_gib_head"] = loadfx("vfx\_requests\human\headgib.vfx");
  level.var_7649["atomize_body"] = loadfx("vfx\iw7\_requests\mp\vfx_atomize_body.vfx");
  level.var_7649["jetpack_burst"] = loadfx("vfx\iw7\core\mechanics\zerog\zerog_jetpack_thruster_sm_allies.vfx");
  level._effect["jetpack_thruster_large"] = loadfx("vfx\iw7\core\mechanics\zerog\zerog_jetpack_thruster_sm.vfx");
  level._effect["jetpack_thruster_large_allies"] = loadfx("vfx\iw7\core\mechanics\zerog\zerog_jetpack_thruster_sm_allies.vfx");
  level._effect["jetpack_thruster_small"] = loadfx("vfx\iw7\core\mechanics\zerog\zerog_jetpack_thruster_sm_turn.vfx");
  level._effect["jetpack_thruster_small_allies"] = loadfx("vfx\iw7\core\mechanics\zerog\zerog_jetpack_thruster_sm_turn_allies.vfx");
  level.var_7649["sniper_glint"] = loadfx("vfx\misc\scope_glint.vfx");
  level.var_7649["helmet_break_suffocate"] = loadfx("vfx\iw7\core\human\helmet_break_suffocate.vfx");
}

func_3353() {
  precachemodel("viewmodel_robot_c6");
  precachemodel("robot_c6_cable");
  precacherumble("light_1s");
  precacherumble("heavy_1s");
  precacherumble("heavy_2s");
  precachestring(&"SCRIPT_PLATFORM_HINT_MELEE_COUNTER");
  level.var_7649["bt_c6_explosion"] = loadfx("vfx\_requests\c6\vfx_c6_explosion");
  level.var_EC8C["asm_viewmodel_knife"] = "tactical_knife_iw7_vm";
  level.var_7649["bt_c6_knife_counter_stab"] = loadfx("vfx\iw7\core\robot\knife\vfx_c6_knife_sparks.vfx");
  level._effect["hack_pov_suicide_loop"] = loadfx("vfx\iw7\core\equipment\hack\vfx_hack_c6_pov_suicide_loop.vfx");
  level._effect["hack_pov_explode"] = loadfx("vfx\iw7\core\equipment\hack\vfx_hack_c6_pov_explode.vfx");
}

func_3508() {
  precachemodel("tag_flash");
  precachemodel("robot_c12_prop_rail_l");
  precachemodel("robot_c12_prop_rail_r");
  precacheitem("c8_grenade");
  precacheitem("iw7_c12rocket_specialist_mode");
  precacherumble("c12_footstep_small");
  precacherumble("c12_footstep_large");
  precacherumble("steady_rumble");
  precacherumble("light_1s");
  precacherumble("heavy_1s");
  level.var_EC8C["asm_c12_viewmodel_knife"] = "tactical_knife_iw7_vm";
  level.var_EC8C["asm_c12_rodeo_rocket"] = "projectile_c12rocket_boxcoll";
  level.var_EC8C["asm_c12_rodeo_rocket_nocoll"] = "projectile_c12rocket_nocoll";
  level.var_7649["c12_selfdestruct_explosion"] = loadfx("vfx\iw7\core\robot\dism\c12\explode\vfx_c12_selfdestruct_explode.vfx");
  level.var_7649["c12_selfdestruct_buildup"] = loadfx("vfx\iw7\core\robot\dism\c12\explode\vfx_c12_selfdestruct_buildup.vfx");
  level.var_7649["c12_implode_explosion"] = loadfx("vfx\iw7\core\robot\dism\c12\explode\vfx_c12_implode_core.vfx");
  level.var_7649["c12_implode_buildup"] = loadfx("vfx\iw7\core\robot\dism\c12\explode\vfx_c12_implode_buildup.vfx");
  level.var_7649["c12_implode_pre_explosion"] = loadfx("vfx\iw7\core\robot\dism\c12\explode\vfx_c12_implode_pre_explosion.vfx");
  level.var_7649["vfx_imp_cstm_rodeo_a"] = loadfx("vfx\iw7\core\impact\custom\vfx_imp_cstm_rodeo_a_bolted.vfx");
  level.var_7649["vfx_imp_cstm_rodeo_b"] = loadfx("vfx\iw7\core\impact\custom\vfx_imp_cstm_rodeo_b_bolted.vfx");
  level.var_7649["vfx_imp_cstm_rodeo_c"] = loadfx("vfx\iw7\core\impact\custom\vfx_imp_cstm_rodeo_c_bolted.vfx");
  level.var_7649["vfx_imp_cstm_rodeo_d"] = loadfx("vfx\iw7\core\impact\custom\vfx_imp_cstm_rodeo_d_bolted.vfx");
  level.var_7649["vfx_imp_cstm_rodeo_e"] = loadfx("vfx\iw7\core\impact\custom\vfx_imp_cstm_rodeo_e_bolted.vfx");
  level.var_7649["vfx_imp_cstm_rodeo_final"] = loadfx("vfx\iw7\core\impact\custom\vfx_imp_cstm_rodeo_final_bolted.vfx");
  level.var_7649["vfx_c12_joint_selfdestruct_head_buildup"] = loadfx("vfx\iw7\core\robot\dism\c12\joint\vfx_c12_joint_selfdestruct_head_buildup.vfx");
  level.var_7649["vfx_c12_knife_sparks"] = loadfx("vfx\iw7\core\robot\knife\vfx_c12_knife_sparks.vfx");
  level.var_7649["vfx_c12_knife_oneshot"] = loadfx("vfx\iw7\core\robot\knife\vfx_c12_knife_oneshot.vfx");
  level.var_7649["grenade_flash_red"] = loadfx("vfx\_requests\c8\vfx_grenade_flash_red.vfx");
  level.var_7649["c12_enemy_light"] = loadfx("vfx\iw7\core\robot\c12\vfx_c12_inner_light.vfx");
  level.var_7649["c12_ally_light"] = loadfx("vfx\iw7\core\robot\c12\vfx_c12_ally_inner_light.vfx");
  level.var_7649["muz_c12_rocket"] = loadfx("vfx\iw7\core\muzflash\c12\vfx_muz_c12_rocket_w.vfx");
}

func_F10A() {
  precachestring(&"SCRIPT_PLATFORM_HINT_MELEE_TAP");
  precachestring(&"EQUIPMENT_SEEKER_RETRIEVE");
  precachestring(&"EQUIPMENT_SEEKER_IDLE");
  precachestring(&"EQUIPMENT_SEEKER_SEARCHING");
  precachestring(&"EQUIPMENT_SEEKER_LOCKED");
  precachestring(&"EQUIPMENT_SEEKER_BLOWNUP");
  precachestring(&"EQUIPMENT_SEEKER_TOP");
  precacheshader("hud_jackal_static");
  precacheitem("seeker");
  precacheitem("seeker_autohold");
  precacheitem("seeker_expl");
  precacheturret("seeker_camera");
  precachemodel("tag_turret");
  level.var_7649["seeker_axis"] = loadfx("vfx\iw7\core\equipment\seeker\vfx_seeker_light_red.vfx");
  level.var_7649["seeker_allies"] = loadfx("vfx\iw7\core\equipment\seeker\vfx_seeker_light.vfx");
  level.var_7649["seeker_team3"] = loadfx("vfx\iw7\core\vehicle\global\vfx_acraft_light_wingtip_blue.vfx");
  level.var_7649["seeker_sparks"] = loadfx("vfx\misc\sparks\vfx_transformer_sparks_b_nolight");
  level.var_7649["seeker_thruster"] = loadfx("vfx\iw7\_requests\equipment\seeker\vfx_seeker_thrusters.vfx");
  level.var_7649["seeker_explosion"] = loadfx("vfx\iw7\core\expl\weap\grenade\vfx_frag_gren.vfx");
  setdvarifuninitialized("debug_seekerpip", 0);
}

func_009B() {}

func_33FB() {
  soldier();
}

func_341D() {
  precachemodel("vm_robot_c8_base");
  precacheitem("iw7_mauler_c8hack");
  precachestring(&"EQUIPMENT_PICKUP_SHIELD");
  precachemodel("weapon_retract_shield_wm");
  level.var_7649["grenade_flash_red"] = loadfx("vfx\_requests\c8\vfx_grenade_flash_red.vfx");
  level.var_7649["c8_barrel_glow"] = loadfx("vfx\iw7\core\robot\c8\vfx_c8_weapon_overheat.vfx");
  level.var_7649["vfx_c8_explode_core"] = loadfx("vfx\iw7\core\robot\dism\c8\explode\vfx_c8_explode_core.vfx");
  level.var_7649["vfx_shield_impact_model"] = loadfx("vfx\iw7\core\equipment\offhandshield\vfx_shield_impact_model.vfx");
}