/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\lab\lab_anim.gsc
***********************************************/

main() {
  level.player.animname = "player";
  player();
  humans();
  vo_face();
  vehicles();
  script_models();
  scriptables();
}

#using_animtree("player");

player() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewmodel_arms_alex_woodland";
  level.scr_anim["player_rig"]["bridge_scene"] = % lab_br_010_intro_start_cam;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "cine_letterbox", ::cine_cam_change, "bridge_scene");
  level.scr_anim["player_rig"]["van_bomb_pickup"] = % lab_tbn_015_dock_sceneb_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "van_scene_start", ::van_scene_start, "van_bomb_pickup");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "van_scene_end", ::van_scene_end, "van_bomb_pickup");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::van_bomb_add_fov_user_scale_override, "van_bomb_pickup");
  level.scr_anim["player_rig"]["cp_5_juggernaut"] = % lab_tbn_040_juggernaut_enter_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::juggernaut_add_fov_user_scale_override, "cp_5_juggernaut");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_user_scale_override", ::juggernaut_remove_fov_user_scale_override, "cp_5_juggernaut");
  level.scr_anim["player_rig"]["chem_room_pad"] = % lab_gas_010_interact_plr;
  level.scr_goaltime["player_rig"]["chem_room_pad"] = 0.3;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "hands_down", ::gas_door_down, "chem_room_pad");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::chem_room_pad_add_fov_user_scale_override, "chem_room_pad");
  level.scr_anim["player_rig"]["pipes_jumpdown"] = % lab_pps_010_3p_cam;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "cine_letterboxing_off", ::cine_lb_down, "pipes_jumpdown");
  level.scr_anim["player_rig"]["pipes_bomb_plant_cam"] = % lab_end_005_bomb_plant_cam;
  level.scr_goaltime["player_rig"]["pipes_bomb_plant_cam"] = 0.3;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "show_head", ::show_head, "pipes_bomb_plant_cam");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::pipes_bomb_add_fov_user_scale_override, "pipes_bomb_plant_cam");
  level.scr_anim["player_rig"]["finale_intro_cam"] = % lab_end_010_finale_intro_cam;
  level.scr_goaltime["player_rig"]["finale_intro_cam"] = 0;
  level.scr_anim["player_rig"]["finale_intro_cam_end"] = % lab_end_010_finale_intro_plr;
  level.scr_goaltime["player_rig"]["finale_intro_cam_end"] = 0;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "cine_letterboxing_off", ::cine_lb_down_ending, "finale_intro_cam");
  level.scr_anim["player_rig"]["finale_stab_prone"] = % lab_end_010_finale_stand_plr;
  level.scr_anim["player_rig"]["finale_stab_back"] = % lab_end_010_finale_stab01_plr;
  level.scr_goaltime["player_rig"]["finale_stab_back"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "attach_knife", ::attach_player_knife, "finale_stab_back");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "detach_knife", ::setup_prompt_knife, "finale_stab_back");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_change", ::dof_auto_barkov, "finale_stab_back");
  level.scr_anim["player_rig"]["finale_stab_front"] = % lab_end_010_finale_stab01_front_plr;
  level.scr_goaltime["player_rig"]["finale_stab_front"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "attach_knife", ::attach_player_knife, "finale_stab_front");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "detach_knife", ::setup_prompt_knife, "finale_stab_front");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_change", ::dof_auto_knife, "finale_stab_front");
  level.scr_anim["player_rig"]["finale_stab_fail"] = % lab_end_010_finale_stab_fail_plr;
  level.scr_goaltime["player_rig"]["finale_stab_fail"] = 0.1;
  level.scr_anim["player_rig"]["finale_choke01_idle"][0] = % lab_end_010_finale_choke01_idle_plr;
  level.scr_goaltime["player_rig"]["finale_choke01_idle"] = 0.25;
  level.scr_anim["player_rig"]["finale_grab_knife"] = % lab_end_010_finale_grab_knife_plr;
  level.scr_goaltime["player_rig"]["finale_grab_knife"] = 0.25;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "attach_knife", ::hide_prompt_knife, "finale_grab_knife");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "attach_knife", ::attach_player_knife, "finale_grab_knife");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_change", ::dof_auto_knife_prompt, "finale_grab_knife");
  level.scr_anim["player_rig"]["finale_grab_knife_idle"][0] = % lab_end_010_finale_grab_knife_idle_plr;
  level.scr_goaltime["player_rig"]["finale_grab_knife_idle"] = 0;
  level.scr_anim["player_rig"]["finale_stab02"] = % lab_end_010_finale_stab02_plr;
  level.scr_goaltime["player_rig"]["finale_stab02"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "attach_knife", ::attach_player_knife, "finale_stab02");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "detach_knife", ::detach_player_knife, "finale_stab02");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_user_scale_override", ::finale_stab02_remove_fov_user_scale_override, "finale_stab02");
  level.scr_anim["player_rig"]["finale_choke_stab01"] = % lab_end_010_finale_choke_stab01_plr;
  level.scr_goaltime["player_rig"]["finale_choke_stab01"] = 0.4;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "attach_knife", ::attach_player_knife, "finale_choke_stab01");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::finale_choke_stab01_add_fov_user_scale_override, "finale_choke_stab01");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_change", ::dof_finale_choke_stab01, "finale_choke_stab01");
  level.scr_anim["player_rig"]["finale_choke_stab02"] = % lab_end_010_finale_choke_stab02_plr;
  level.scr_goaltime["player_rig"]["finale_choke_stab02"] = 0.3;
  level.scr_anim["player_rig"]["finale_choke_stab03"] = % lab_end_010_finale_choke_stab03_plr;
  level.scr_goaltime["player_rig"]["finale_choke_stab03"] = 0.3;
  level.scr_anim["player_rig"]["finale_choke_stab04"] = % lab_end_010_finale_choke_stab04_plr;
  level.scr_goaltime["player_rig"]["finale_choke_stab04"] = 0.3;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "detach_knife", ::link_to_barkov, "finale_choke_stab04");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_user_scale_override", ::finale_choke_stab04_remove_fov_user_scale_override, "finale_choke_stab04");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_change", ::dof_finale_choke_stab04, "finale_choke_stab04");
  level.scr_anim["player_rig"]["finale_dead_stab01"] = % lab_end_010_finale_dead_stab01_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "attach_knife", ::attach_player_knife, "finale_dead_stab01");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "detach_knife", ::detach_player_knife, "finale_dead_stab01");
  level.scr_anim["player_rig"]["finale_choke_stab01_idle"][0] = % lab_end_010_finale_choke_stab01_idle_plr;
  level.scr_goaltime["player_rig"]["finale_choke_stab01_idle"] = 0;
  level.scr_anim["player_rig"]["finale_choke_stab02_idle"][0] = % lab_end_010_finale_choke_stab02_idle_plr;
  level.scr_goaltime["player_rig"]["finale_choke_stab02_idle"] = 0;
  level.scr_anim["player_rig"]["finale_choke_stab03_idle"][0] = % lab_end_010_finale_choke_stab03_idle_plr;
  level.scr_goaltime["player_rig"]["finale_choke_stab03_idle"] = 0;
  level.scr_anim["player_rig"]["finale_stabbed"] = % lab_end_010_finale_position_stabbed_plr;
  level.scr_anim["player_rig"]["choke_deathA"] = % lab_end_010_finale_choke01_death_a_plr;
  level.scr_goaltime["player_rig"]["choke_deathA"] = 0;
  level.scr_anim["player_rig"]["choke_deathB"] = % lab_end_010_finale_choke01_death_b_plr;
  level.scr_goaltime["player_rig"]["choke_deathB"] = 0;
  level.scr_anim["player_rig"]["finale_knock_down"] = % lab_end_010_finale_knock_down_plr;
  level.scr_goaltime["player_rig"]["finale_knock_down"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::finale_knock_down_add_fov_user_scale_override, "finale_knock_down");
  level.scr_anim["player_rig"]["finale_kickoff_start"] = % lab_end_010_finale_kickoff_start_plr;
  level.scr_goaltime["player_rig"]["finale_kickoff_start"] = 0.2;
  level.scr_anim["player_rig"]["finale_kickoff_start_alt"] = % lab_end_010_finale_kickoff_start_alt_plr;
  level.scr_goaltime["player_rig"]["finale_kickoff_start_alt"] = 0.2;
  level.scr_anim["player_rig"]["finale_kickoff_sh01"] = % lab_end_010_finale_kickoff_sh01_cam;
  level.scr_goaltime["player_rig"]["finale_kickoff_sh01"] = 0;
  level.scr_anim["player_rig"]["finale_kickoff_sh02"] = % lab_end_010_finale_kickoff_sh02_cam;
  level.scr_goaltime["player_rig"]["finale_kickoff_sh02"] = 0;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "attach_knife", ::unlink_from_barkov, "finale_kickoff_start");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dialogue", ::finale_player_dialogue, "finale_kickoff_start");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dialogue", ::finale_player_dialogue, "finale_kickoff_start_alt");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::finale_kickoff_sh01_add_fov_user_scale_override, "finale_kickoff_sh01");
  scripts\common\anim::addnotetrack_notify("player_rig", "heli_move", "finale_heli_move_to_kickoff", "finale_kickoff_start");
  scripts\common\anim::addnotetrack_notify("player_rig", "heli_move", "finale_heli_move_to_kickoff", "finale_kickoff_start_alt");
  scripts\common\anim::addnotetrack_notify("player_rig", "script_end", "script_end_start_notetrack", "finale_kickoff_sh02");
  level.scr_anim["player_rig"]["final_shot"] = % lab_end_010_finale_kickoff_sh03_cam;
  level.scr_goaltime["player_rig"]["final_shot"] = 0;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "end_shake", ::final_shot_shake, "final_shot");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "cut_to_black", ::cut_to_back, "final_shot");
}

dof_auto_barkov(var_0) {
  setsaveddvar("SLSMSSTQP", "1");
  level.barkov scripts\engine\sp\utility::dof_enable_autofocus(2, 5, undefined, undefined, "tag_eye", undefined, 1);
  wait 3;
  setsaveddvar("SLSMSSTQP", "9");
}

dof_auto_knife(var_0) {
  setsaveddvar("SLSMSSTQP", "1");
  level.prompt_knife scripts\engine\sp\utility::dof_enable_autofocus(2, 5, undefined, undefined, "j_gun", undefined, 1);
  wait 2;
  setsaveddvar("SLSMSSTQP", "9");
}

dof_auto_knife_prompt(var_0) {
  setsaveddvar("SLSMSSTQP", "1");
  level.prompt_knife scripts\engine\sp\utility::dof_enable_autofocus(2, 5, undefined, undefined, "j_gun", undefined, 1);
  wait 2;
  level.barkov scripts\engine\sp\utility::dof_enable_autofocus(2, 5, undefined, undefined, "j_gun", undefined, 1);
  wait 2;
  setsaveddvar("SLSMSSTQP", "9");
  scripts\engine\sp\utility::dof_disable_autofocus();
}

dof_finale_choke_stab01(var_0) {
  setsaveddvar("SLSMSSTQP", "1");
  level.barkov scripts\engine\sp\utility::dof_enable_autofocus(2, 5, undefined, undefined, "tag_eye", undefined, 1);
}

dof_finale_choke_stab04(var_0) {
  setsaveddvar("SLSMSSTQP", "9");
  wait 1;
  scripts\engine\sp\utility::dof_disable_autofocus();
}

cine_cam_change(var_0) {
  scripts\sp\maps\lab\lab_util.gsc::cine_letterboxing_down(1.5);
  scripts\engine\utility::flag_set("drone_scene_done");
}

setup_prompt_knife(var_0) {
  level.prompt_knife show();
  level.knife hide();
}

hide_prompt_knife(var_0) {
  level.prompt_knife delete();
}

attach_player_knife(var_0) {
  level.knife linkTo(var_0, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  level.knife show();
}

detach_player_knife(var_0) {
  level.knife hide();
  level.knife unlink();
}

link_to_barkov(var_0) {
  level.knife unlink();
  level.knife linkTo(level.barkov, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
}

unlink_from_barkov(var_0) {
  level.knife unlink();
  level.knife linkTo(level.alt_rig, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
}

finale_player_dialogue(var_0) {
  level.barkov notify("stop_simple_dialogue");

  if(!istrue(level.barkov.iscompletelydead)) {
    level.barkov scripts\engine\utility::delaythread(1.2, scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue, "dx_vom_bkv_finale_heli_kill_knife_90");
    wait 1;
  }

  if(isDefined(level.finaledialogue)) {
    if(!isDefined(level.finaledialoguelong))
      wait 0.85;

    scripts\engine\sp\utility::smart_player_dialogue(level.finaledialogue);
  } else {
    if(level.barkov.kickoffstart == "finale_kickoff_start")
      wait 2.4;
    else
      wait 1.1;

    thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_break_final_kiss_95");
    wait 0.35;
    playFX(level._effect["vfx_cpt_spit_blood"], level.player getEye() + anglesToForward(level.alt_rig gettagangles("tag_camera")) * 4, anglesToForward(level.alt_rig gettagangles("tag_camera")));
    scripts\sp\utility::giveachievement_wrapper("barkovspit", 1);
  }
}

van_scene_start(var_0) {
  level.player lerpviewangleclamp(0.3, 0.1, 0.1, 15, 25, 12, 18);
}

van_scene_end(var_0) {
  level.player_rig.detonator delete();
  level.player lerpviewangleclamp(0.3, 0.1, 0.1, 15, 25, 12, 12);
  wait 3.5;
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  level.player scripts\engine\utility::delaythread(3.5, scripts\engine\sp\utility::set_player_demeanor, "normal");
  scripts\sp\player_rig::unlink_player_from_rig();
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
  level.player lerpfovscalefactor(1, 0.5);
  var_1 = getEnt("van_bomb", "targetname");
  var_1 stopanimScripted();
  var_1 delete();
  scripts\engine\sp\utility::autosave_by_name("jump_down_done_a");
}

gas_door_down(var_0) {
  var_0 hide();
}

show_head(var_0) {
  level.kyle attach(level.kyle.headmodel);

  if(isDefined(level.kyle.hatmodel))
    level.kyle attach(level.kyle.hatmodel);
}

cine_lb_down(var_0) {
  scripts\sp\maps\lab\lab_util.gsc::cine_letterboxing_down(1.5);
}

cine_lb_down_ending(var_0) {
  wait 0.3;
  level.player lerpfovscalefactor(1, 1.5);
  scripts\sp\maps\lab\lab_util.gsc::cine_letterboxing_down(1.5);
}

final_shot_shake(var_0) {
  level.player setcinematicmotionoverride("iw8_heli_ride");
  wait 1;
  screenshake(var_0.origin, 0.3, 0.3, 0.3, 2, 1.2, 0, 100);
}

cut_to_back(var_0) {
  scripts\sp\maps\lab\lab_util.gsc::cine_letterboxing_down(0);
  level.endhud = scripts\sp\maps\lab\lab_finale.gsc::fadeoutscreen(0.01);
}

juggernaut_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 0.5);
}

juggernaut_remove_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(1, 1);
}

chem_room_pad_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 0.5);
}

van_bomb_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 0.5);
}

pipes_bomb_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 0.5);
}

finale_knock_down_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 0.5);
}

finale_choke_stab01_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 0.5);
}

finale_stab02_remove_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(1, 0.8);
}

finale_choke_stab04_remove_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(1, 0.6);
}

finale_kickoff_sh01_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 0.5);
}

#using_animtree("generic_human");

humans() {
  level.scr_anim["alex"]["bridge_scene"] = % lab_br_010_intro_start_alex;
  level.scr_anim["price"]["bridge_scene"] = % lab_br_010_intro_start_price;
  level.scr_anim["farah"]["bridge_scene"] = % lab_br_010_intro_start_farah;
  level.scr_anim["kyle"]["bridge_scene"] = % lab_br_010_intro_start_kyle;
  scripts\common\anim::addnotetrack_customfunction("alex", "weapons_up", ::weapons_up, "bridge_scene");
  scripts\common\anim::addnotetrack_mayhemstart("alex", "mayhem_start", %lab_br_010_intro_start_alex_face, "bridge_scene");
  scripts\common\anim::addnotetrack_mayhemend("alex", "mayhem_end", %lab_br_010_intro_start_alex_face, "bridge_scene");
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_start", %lab_br_010_intro_start_price_face, "bridge_scene");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_end", %lab_br_010_intro_start_price_face, "bridge_scene");
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %lab_br_010_intro_start_farah_face, "bridge_scene");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %lab_br_010_intro_start_farah_face, "bridge_scene");
  level.scr_anim["enemy_1"]["bridge_scene"] = % lab_br_010_intro_start_enemy01;
  level.scr_anim["enemy_2"]["bridge_scene"] = % lab_br_010_intro_start_enemy02;
  level.scr_anim["enemy_3"]["bridge_scene"] = % lab_br_010_intro_start_enemy03;
  level.scr_anim["price"]["lab_door_arrive"] = % lab_hill_010_plan_arrival_price;
  level.scr_goaltime["price"]["lab_door_arrive"] = 0.2;
  level.scr_anim["price"]["lab_door_idle"][0] = % lab_hill_010_plan_arrival_idle_price;
  level.scr_anim["price"]["lab_door_enter_nag"] = % lab_hill_010_plan_exit_nag_price;
  level.scr_anim["price"]["lab_door_enter"] = % lab_hill_010_plan_scene_price;
  level.scr_goaltime["price"]["lab_door_enter"] = 0.2;
  level.scr_anim["price"]["lab_door_enter_idle"][0] = % lab_hill_010_plan_exit_idle_price;
  level.scr_anim["deadbody_01"]["van_jumpdown_deadguy"][0] = % htf_esc_010_gasvictim1;
  level.scr_anim["deadbody_02"]["van_jumpdown_deadguy"][0] = % htf_esc_010_gasvictim2;
  level.scr_anim["deadbody_03"]["van_jumpdown_deadguy"][0] = % deadbody_10;
  level.scr_anim["rebel_1"]["van_jumpdown_arrival"] = % lab_tbn_015_dock_arrival_ally02;
  level.scr_anim["rebel_2"]["van_jumpdown_arrival"] = % lab_tbn_015_dock_arrival_ally03;
  level.scr_anim["rebel_3"]["van_jumpdown_arrival"] = % lab_tbn_015_dock_arrival_ally01;
  level.scr_anim["farah"]["van_jumpdown_arrival"] = % lab_tbn_015_dock_arrival_farah;
  level.scr_goaltime["farah"]["van_jumpdown_arrival"] = 0.3;
  level.scr_anim["rebel_1"]["van_jumpdown_idle"][0] = % lab_tbn_015_dock_start_idle_ally02;
  level.scr_anim["rebel_2"]["van_jumpdown_idle"][0] = % lab_tbn_015_dock_start_idle_ally03;
  level.scr_anim["rebel_3"]["van_jumpdown_idle"][0] = % lab_tbn_015_dock_start_idle_ally01;
  level.scr_anim["farah"]["van_jumpdown_idle"][0] = % lab_tbn_015_dock_start_idle_farah;
  level.scr_anim["nikolai"]["van_jumpdown_idle"][0] = % lab_tbn_015_dock_start_idle_nikolai;
  level.scr_anim["rebel_1"]["van_jumpdown_start"] = % lab_tbn_015_dock_scenea_ally02;
  level.scr_anim["rebel_2"]["van_jumpdown_start"] = % lab_tbn_015_dock_scenea_ally03;
  level.scr_anim["rebel_3"]["van_jumpdown_start"] = % lab_tbn_015_dock_scenea_ally01;
  level.scr_anim["farah"]["van_jumpdown_start"] = % lab_tbn_015_dock_scenea_farah;
  level.scr_anim["nikolai"]["van_jumpdown_start"] = % lab_tbn_015_dock_scenea_nikolai;
  level.scr_anim["rebel_1"]["van_start_idle"][0] = % lab_tbn_015_dock_idlea_ally02;
  level.scr_anim["rebel_2"]["van_start_idle"][0] = % lab_tbn_015_dock_idlea_ally03;
  level.scr_anim["rebel_3"]["van_start_idle"][0] = % lab_tbn_015_dock_idlea_ally01;
  level.scr_anim["farah"]["van_start_idle"][0] = % lab_tbn_015_dock_idlea_farah;
  level.scr_anim["nikolai"]["van_start_idle"][0] = % lab_tbn_015_dock_idlea_nikolai;
  level.scr_anim["nikolai"]["van_start_idle_nags"][0] = % lab_tbn_015_dock_nag2_nikolai;
  level.scr_anim["nikolai"]["van_start_idle_nags_timer"] = 12;
  scripts\common\anim::addnotetrack_notify("nikolai", "nag", "nag", "van_start_idle_nags");
  level.scr_anim["rebel_1"]["van_scene"] = % lab_tbn_015_dock_sceneb_ally02;
  level.scr_anim["rebel_2"]["van_scene"] = % lab_tbn_015_dock_sceneb_ally03;
  level.scr_anim["rebel_3"]["van_scene"] = % lab_tbn_015_dock_sceneb_ally01;
  level.scr_anim["farah"]["van_scene"] = % lab_tbn_015_dock_sceneb_farah;
  level.scr_anim["nikolai"]["van_scene"] = % lab_tbn_015_dock_sceneb_nikolai;
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %lab_tbn_015_dock_sceneb_farah_face, "van_scene");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %lab_tbn_015_dock_sceneb_farah_face, "van_scene");
  scripts\common\anim::addnotetrack_mayhemstart("nikolai", "mayhem_start", %lab_tbn_015_dock_sceneb_nikolai_face, "van_scene");
  scripts\common\anim::addnotetrack_mayhemend("nikolai", "mayhem_end", %lab_tbn_015_dock_sceneb_nikolai_face, "van_scene");
  scripts\common\anim::addnotetrack_customfunction("nikolai", "detonator_start", ::start_detonator, "van_scene");
  scripts\common\anim::addnotetrack_customfunction("farah", "swap_mask", ::farah_swap_mask_back, "van_scene");
  level.scr_anim["rebel_1"]["van_door_idle"][0] = % lab_tbn_020_buddy_down_arrival_idle_ally02;
  level.scr_anim["rebel_2"]["van_door_idle"][0] = % lab_tbn_020_buddy_down_arrival_idle_ally03;
  level.scr_anim["rebel_3"]["van_door_idle"][0] = % lab_tbn_020_buddy_down_arrival_idle_ally01;
  level.scr_anim["farah"]["van_door_idle"][0] = % lab_tbn_020_buddy_down_arrival_idle_farah;
  level.scr_anim["farah"]["van_door_idle_nags"][0] = % lab_tbn_020_buddy_down_arrival_nag1_farah;
  level.scr_anim["farah"]["van_door_idle_nags_timer"] = 12;
  level.scr_anim["nikolai"]["van_door_idle"][0] = % lab_tbn_015_dock_sceneb_idle_nikolai;
  scripts\common\anim::addnotetrack_notify("farah", "nag", "nag", "van_door_idle_nags");
  level.scr_anim["farah"]["van_door_push"] = % lab_tbn_020_buddy_down_push_farah;
  level.scr_anim["rebel_1"]["van_door_push"] = % lab_tbn_020_buddy_down_push_ally01;
  level.scr_anim["rebel_2"]["van_door_push"] = % lab_tbn_020_buddy_down_push_ally03;
  level.scr_anim["rebel_3"]["van_door_push"] = % lab_tbn_020_buddy_down_push_ally02;
  level.scr_anim["db_enemy"]["van_door_push"] = % lab_tbn_020_buddy_down_push_enemy01;
  level.scr_anim["rebel_1"]["cp_3_buddy_door_push"] = % lab_tbn_020_buddy_down_push_ally02;
  level.scr_anim["rebel_2"]["cp_3_buddy_door_push"] = % lab_tbn_020_buddy_down_push_ally03;
  level.scr_anim["rebel_3"]["cp_3_buddy_door_push"] = % lab_tbn_020_buddy_down_push_ally01;
  level.scr_goaltime["rebel_1"]["cp_3_buddy_door_push"] = 0.25;
  level.scr_goaltime["rebel_2"]["cp_3_buddy_door_push"] = 0.25;
  level.scr_goaltime["rebel_3"]["cp_3_buddy_door_push"] = 0.25;
  scripts\common\anim::addnotetrack_customfunction("rebel_2", "shot", ::dragons_breath_shot, "cp_3_buddy_door_push");
  level.scr_anim["cp_3_enemy"]["cp_3_buddy_door_push"] = % lab_tbn_020_buddy_down_push_enemy01;
  level.scr_anim["jugg_ally1"]["cp_4_plant"] = % lab_tbn_030_plant_ally01;
  level.scr_anim["jugg_ally2"]["cp_4_plant"] = % lab_tbn_030_plant_ally01;
  scripts\common\anim::addnotetrack_customfunction("jugg_ally1", "detach", ::detach_bomb, "cp_4_plant");
  scripts\common\anim::addnotetrack_customfunction("jugg_ally2", "detach", ::detach_bomb, "cp_4_plant");
  level.scr_anim["rebel_1"]["cp_4_plant"] = % lab_tbn_030_plant_ally01;
  level.scr_anim["rebel_2"]["cp_4_plant"] = % lab_tbn_030_plant_ally01;
  level.scr_anim["rebel_3"]["cp_4_plant"] = % lab_tbn_030_plant_ally01;
  scripts\common\anim::addnotetrack_customfunction("rebel_1", "detach", ::detach_bomb, "cp_4_plant");
  scripts\common\anim::addnotetrack_customfunction("rebel_2", "detach", ::detach_bomb, "cp_4_plant");
  scripts\common\anim::addnotetrack_customfunction("rebel_3", "detach", ::detach_bomb, "cp_4_plant");
  level.scr_anim["juggernaut_1"]["cp_5_juggernaut"] = % lab_tbn_040_juggernaut_enter_enemy01;
  level.scr_anim["farah"]["chem_room_pad"] = % lab_gas_010_interact_farah;
  level.scr_goaltime["farah"]["chem_room_pad"] = 0.3;
  level.scr_anim["kyle"]["pipes_jumpdown"] = % lab_pps_010_3p_kyle;
  level.scr_anim["price"]["pipes_jumpdown"] = % lab_pps_010_3p_price;
  scripts\common\anim::addnotetrack_customfunction("kyle", "weapons_up", ::weapons_up, "pipes_jumpdown");
  scripts\common\anim::addnotetrack_mayhemstart("kyle", "mayhem_start", %lab_pps_010_3p_kyle_face, "pipes_jumpdown");
  scripts\common\anim::addnotetrack_mayhemend("kyle", "mayhem_end", %lab_pps_010_3p_kyle_face, "pipes_jumpdown");
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_start", %lab_pps_010_3p_price_face, "pipes_jumpdown");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_end", %lab_pps_010_3p_price_face, "pipes_jumpdown");
  level.scr_anim["rb_door_guy"]["reverse_breach"] = % sh_sch_060_doorbustf_enemy;
  level.scr_anim["price"]["pipes_bomb_plant"] = % lab_end_005_bomb_plant_price;
  level.scr_goaltime["price"]["pipes_bomb_plant"] = 0.3;
  level.scr_anim["barkov"]["pipes_bomb_plant"] = % lab_end_005_bomb_plant_barkov;
  level.scr_goaltime["barkov"]["pipes_bomb_plant"] = 0.3;
  level.scr_anim["kyle"]["pipes_bomb_plant"] = % lab_end_005_bomb_plant_plr;
  level.scr_goaltime["kyle"]["pipes_bomb_plant"] = 0.3;
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_start", %lab_end_005_bomb_plant_price_face, "pipes_bomb_plant");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_end", %lab_end_005_bomb_plant_price_face, "pipes_bomb_plant");
  scripts\common\anim::addnotetrack_mayhemstart("kyle", "mayhem_start", %lab_end_005_bomb_plant_plr_face, "pipes_bomb_plant");
  scripts\common\anim::addnotetrack_mayhemend("kyle", "mayhem_end", %lab_end_005_bomb_plant_plr_face, "pipes_bomb_plant");
  level.scr_anim["farah"]["finale_intro"] = % lab_end_010_finale_intro_plr_3p;
  level.scr_goaltime["farah"]["finale_intro"] = 0;
  level.scr_anim["barkov"]["finale_intro"] = % lab_end_010_finale_intro_barkov;
  level.scr_goaltime["barkov"]["finale_intro"] = 0;
  level.scr_anim["barkov"]["finale_intro_idle"][0] = % lab_end_010_finale_start_idle_barkov;
  level.scr_goaltime["barkov"]["finale_intro_idle"] = 0;
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %lab_end_010_finale_intro_plr_3p_face, "finale_intro");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %lab_end_010_finale_intro_plr_3p_face, "finale_intro");
  scripts\common\anim::addnotetrack_mayhemstart("barkov", "mayhem_start", %lab_end_010_finale_intro_barkov_face, "finale_intro");
  scripts\common\anim::addnotetrack_mayhemend("barkov", "mayhem_end", %lab_end_010_finale_intro_barkov_face, "finale_intro");
  scripts\common\anim::addnotetrack_customfunction("farah", "start_sim", ::start_tarp_mayhem, "finale_intro");
  level.scr_anim["barkov"]["finale_stab_back"] = % lab_end_010_finale_stab01_barkov;
  level.scr_goaltime["barkov"]["finale_stab_back"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("barkov", "elbow_player", ::damage_on_elbow_strike, "finale_stab_back");
  scripts\common\anim::addnotetrack_customfunction("barkov", "drop_walkie", ::drop_walkie_prop, "finale_stab_back");
  scripts\common\anim::addnotetrack_customfunction("barkov", "stab", ::stab_swap_01, "finale_stab_back");
  scripts\common\anim::addnotetrack_customfunction("barkov", "swap_gun", ::swap_to_fake_cpapa, "finale_stab_back");
  level.scr_anim["barkov"]["finale_stab_front"] = % lab_end_010_finale_stab01_front_barkov;
  level.scr_goaltime["barkov"]["finale_stab_front"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("barkov", "headbutt_player", ::damage_on_elbow_strike, "finale_stab_front");
  scripts\common\anim::addnotetrack_customfunction("barkov", "drop_walkie", ::drop_walkie_prop, "finale_stab_front");
  scripts\common\anim::addnotetrack_customfunction("barkov", "stab", ::stab_swap_01, "finale_stab_front");
  scripts\common\anim::addnotetrack_customfunction("barkov", "swap_gun", ::swap_to_fake_cpapa, "finale_stab_front");
  level.scr_anim["barkov"]["finale_stab_fail"] = % lab_end_010_finale_stab_fail_barkov;
  level.scr_goaltime["barkov"]["finale_stab_fail"] = 0.25;
  scripts\common\anim::addnotetrack_customfunction("barkov", "first_shot", ::damage_on_gun_shot, "finale_stab_fail");
  scripts\common\anim::addnotetrack_customfunction("barkov", "player_dies", ::kill_player, "finale_stab_fail");
  level.scr_anim["barkov"]["finale_look_left"] = % lab_end_010_finale_look_idle_in_barkov;
  level.scr_anim["barkov"]["finale_look_idle"][0] = % lab_end_010_finale_look_idle_barkov;
  level.scr_anim["barkov"]["finale_look_right"] = % lab_end_010_finale_look_idle_out_barkov;
  level.scr_anim["barkov"]["finale_look_spotted"] = % lab_end_010_finale_look_react_barkov;
  level.scr_goaltime["barkov"]["finale_look_spotted"] = 0.4;
  scripts\common\anim::addnotetrack_customfunction("barkov", "drop_walkie", ::drop_walkie_prop, "finale_look_spotted");
  level.scr_anim["barkov"]["finale_choke01_idle"][0] = % lab_end_010_finale_choke01_idle_barkov;
  level.scr_goaltime["barkov"]["finale_choke01_idle"] = 0.25;
  level.scr_anim["barkov"]["finale_grab_knife"] = % lab_end_010_finale_grab_knife_barkov;
  level.scr_goaltime["barkov"]["finale_grab_knife"] = 0.25;
  level.scr_anim["barkov"]["finale_grab_knife_idle"][0] = % lab_end_010_finale_grab_knife_idle_barkov;
  level.scr_goaltime["barkov"]["finale_grab_knife_idle"] = 0;
  level.scr_anim["barkov"]["finale_stab02"] = % lab_end_010_finale_stab02_barkov;
  level.scr_goaltime["barkov"]["finale_stab02"] = 0.2;
  level.scr_anim["barkov"]["finale_stab02b"] = % lab_end_010_finale_injured_barkov;
  level.scr_goaltime["barkov"]["finale_stab02b"] = 0;
  scripts\common\anim::addnotetrack_customfunction("barkov", "stab", ::stab_swap_02, "finale_stab02");
  scripts\common\anim::addnotetrack_customfunction("barkov", "barkov_shoots", ::barkov_shoots, "finale_stab02b");
  scripts\common\anim::addnotetrack_customfunction("barkov", "pickup_gun", ::pickup_fake_cpapa, "finale_stab02b");
  level.scr_anim["barkov"]["finale_choke_stab01"] = % lab_end_010_finale_choke_stab01_barkov;
  level.scr_goaltime["barkov"]["finale_choke_stab01"] = 0.4;
  level.scr_anim["barkov"]["finale_choke_stab01_idle"][0] = % lab_end_010_finale_choke_stab01_idle_barkov;
  level.scr_goaltime["barkov"]["finale_choke_stab01_idle"] = 0;
  scripts\common\anim::addnotetrack_customfunction("barkov", "stab", ::stab_swap_03, "finale_choke_stab01");
  scripts\common\anim::addnotetrack_customfunction("barkov", "dx_vom_bkv_finale_heli_kill_bodyshot_39", ::say_choke_stab_vo_01, "finale_choke_stab01");
  level.scr_anim["barkov"]["finale_choke_stab02"] = % lab_end_010_finale_choke_stab02_barkov;
  level.scr_goaltime["barkov"]["finale_choke_stab02"] = 0.3;
  level.scr_anim["barkov"]["finale_choke_stab02_idle"][0] = % lab_end_010_finale_choke_stab02_idle_barkov;
  level.scr_goaltime["barkov"]["finale_choke_stab02_idle"] = 0;
  scripts\common\anim::addnotetrack_customfunction("barkov", "stab", ::stab_swap_04, "finale_choke_stab02");
  scripts\common\anim::addnotetrack_customfunction("barkov", "dx_vom_bkv_finale_heli_kill_bodyshot_30", ::say_choke_stab_vo_02, "finale_choke_stab02");
  level.scr_anim["barkov"]["finale_choke_stab03"] = % lab_end_010_finale_choke_stab03_barkov;
  level.scr_goaltime["barkov"]["finale_choke_stab03"] = 0.3;
  level.scr_anim["barkov"]["finale_choke_stab03_idle"][0] = % lab_end_010_finale_choke_stab03_idle_barkov;
  level.scr_goaltime["barkov"]["finale_choke_stab03_idle"] = 0;
  scripts\common\anim::addnotetrack_customfunction("barkov", "stab", ::stab_swap_05, "finale_choke_stab03");
  scripts\common\anim::addnotetrack_customfunction("barkov", "dx_vom_bkv_finale_heli_kill_knife_60", ::say_choke_stab_vo_03, "finale_choke_stab03");
  level.scr_anim["barkov"]["finale_choke_stab04"] = % lab_end_010_finale_choke_stab04_barkov;
  level.scr_goaltime["barkov"]["finale_choke_stab04"] = 0.3;
  scripts\common\anim::addnotetrack_customfunction("barkov", "stab", ::stab_swap_06, "finale_choke_stab04");
  level.scr_anim["barkov"]["finale_death_shot"] = % lab_end_010_finale_floor_headshot_barkov;
  level.scr_goaltime["barkov"]["finale_death_shot"] = 0.4;
  level.scr_anim["barkov"]["finale_death_stabbed_idle"][0] = % lab_end_010_finale_death_idle_barkov;
  level.scr_goaltime["barkov"]["finale_death_stabbed_idle"] = 0.125;
  level.scr_anim["barkov"]["finale_dead_stab01"] = % lab_end_010_finale_dead_stab01_barkov;
  level.scr_anim["barkov"]["finale_stabbed"] = % lab_end_010_finale_position_stabbed_barkov;
  level.scr_anim["barkov"]["finale_knock_down"] = % lab_end_010_finale_knock_down_barkov;
  level.scr_goaltime["barkov"]["finale_knock_down"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("barkov", "start_choke_out", ::barkov_start_choke_effect, "finale_knock_down");
  level.scr_anim["barkov"]["choke_deathA"] = % lab_end_010_finale_choke01_death_a_barkov;
  level.scr_goaltime["barkov"]["choke_deathA"] = 0;
  level.scr_anim["barkov"]["choke_deathB"] = % lab_end_010_finale_choke01_death_b_barkov;
  level.scr_goaltime["barkov"]["choke_deathB"] = 0;
  scripts\common\anim::addnotetrack_customfunction("barkov", "fist_slam", ::damage_on_elbow_strike, "choke_deathB");
  level.scr_anim["barkov"]["finale_gun_aim"] = % lab_end_010_finale_shot_miss_alt_barkov;
  level.scr_goaltime["barkov"]["finale_gun_aim"] = 0.5;
  level.scr_anim["barkov"]["finale_gun_aim_death"] = % lab_end_010_finale_shot_miss_alt_death_barkov;
  level.scr_goaltime["barkov"]["finale_gun_aim_death"] = 0.4;
  level.scr_anim["barkov"]["finale_gun_aim_reload"] = % lab_end_010_finale_reload_barkov;
  level.scr_goaltime["barkov"]["finale_gun_aim_reload"] = 0.3;
  scripts\common\anim::addnotetrack_customfunction("barkov", "drop_walkie", ::drop_walkie_prop, "finale_gun_aim");
  level.scr_anim["barkov"]["finale_gun_aim_loop"][0] = % lab_end_010_finale_shot_miss_alt_idle_barkov;
  level.scr_goaltime["barkov"]["finale_gun_aim_loop"] = 0.2;
  level.scr_anim["barkov"]["finale_gun_aim_2_knob"] = % lab_finale_aim_2;
  level.scr_anim["barkov"]["finale_gun_aim_2"] = % lab_end_010_finale_aim_2_barkov;
  level.scr_anim["barkov"]["finale_gun_aim_4_knob"] = % lab_finale_aim_4;
  level.scr_anim["barkov"]["finale_gun_aim_4"] = % lab_end_010_finale_aim_4_barkov;
  level.scr_anim["barkov"]["finale_gun_aim_5"] = % lab_end_010_finale_shot_miss_alt_idle_barkov;
  level.scr_anim["barkov"]["finale_gun_aim_6_knob"] = % lab_finale_aim_6;
  level.scr_anim["barkov"]["finale_gun_aim_6"] = % lab_end_010_finale_aim_6_barkov;
  level.scr_anim["barkov"]["finale_gun_aim_8_knob"] = % lab_finale_aim_8;
  level.scr_anim["barkov"]["finale_gun_aim_8"] = % lab_end_010_finale_aim_8_barkov;
  level.scr_anim["barkov"]["finale_gun_fire"] = % lab_end_010_finale_fire_barkov;
  level.scr_anim["barkov"]["finale_shot_injure"] = % lab_end_010_finale_shot_injure_barkov;
  level.scr_goaltime["barkov"]["finale_shot_injure"] = 0.6;
  level.scr_anim["barkov"]["finale_shot_injure_side"] = % lab_end_010_finale_shot_injure_side_barkov;
  level.scr_goaltime["barkov"]["finale_shot_injure_side"] = 0.6;
  level.scr_anim["barkov"]["finale_shot_injure_front"] = % lab_end_010_finale_shot_injure_front_barkov;
  level.scr_goaltime["barkov"]["finale_shot_injure_front"] = 0.6;
  level.scr_anim["barkov"]["finale_shot_death"] = % lab_end_010_finale_shot_death_barkov;
  level.scr_anim["barkov"]["finale_shot_death_side"] = % lab_end_010_finale_shot_death_side_barkov;
  scripts\common\anim::addnotetrack_customfunction("barkov", "drop_walkie", ::drop_walkie_prop, "finale_shot_injure");
  scripts\common\anim::addnotetrack_customfunction("barkov", "drop_walkie", ::drop_walkie_prop, "finale_shot_injure_side");
  scripts\common\anim::addnotetrack_customfunction("barkov", "drop_walkie", ::drop_walkie_prop, "finale_shot_injure_front");
  scripts\common\anim::addnotetrack_customfunction("barkov", "drop_walkie", ::drop_walkie_prop, "finale_shot_death");
  scripts\common\anim::addnotetrack_customfunction("barkov", "drop_walkie", ::drop_walkie_prop, "finale_shot_death_side");
  scripts\common\anim::addnotetrack_customfunction("barkov", "swap_gun", ::swap_to_fake_cpapa, "finale_shot_injure");
  scripts\common\anim::addnotetrack_customfunction("barkov", "swap_gun", ::swap_to_fake_cpapa, "finale_shot_injure_side");
  scripts\common\anim::addnotetrack_customfunction("barkov", "swap_gun", ::swap_to_fake_cpapa, "finale_shot_injure_front");
  scripts\common\anim::addnotetrack_customfunction("barkov", "drop_walkie", ::check_health_status, "finale_shot_injure");
  scripts\common\anim::addnotetrack_customfunction("barkov", "swap_gun", ::check_health_status, "finale_shot_injure_side");
  scripts\common\anim::addnotetrack_customfunction("barkov", "swap_gun", ::check_health_status, "finale_shot_injure_front");
  level.scr_anim["barkov"]["finale_death_shot_idle"][0] = % lab_end_010_finale_death_shot_idle_barkov;
  level.scr_anim["barkov"]["finale_kickoff_start"] = % lab_end_010_finale_kickoff_start_barkov;
  level.scr_goaltime["barkov"]["finale_kickoff_start"] = 0.2;
  level.scr_anim["barkov"]["finale_kickoff_start_alt"] = % lab_end_010_finale_kickoff_start_alt_barkov;
  level.scr_goaltime["barkov"]["finale_kickoff_start_alt"] = 0.2;
  level.scr_anim["farah"]["finale_kickoff_sh01"] = % lab_end_010_finale_kickoff_sh01_farah;
  level.scr_goaltime["farah"]["finale_kickoff_sh01"] = 0;
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %lab_end_010_finale_kickoff_sh01_farah_face, "finale_kickoff_sh01");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %lab_end_010_finale_kickoff_sh01_farah_face, "finale_kickoff_sh01");
  scripts\common\anim::addnotetrack_customfunction("farah", "boom", ::big_boom, "finale_kickoff_sh01");
  scripts\common\anim::addnotetrack_customfunction("farah", "mix1", ::audio_mix_move1, "finale_kickoff_sh01");
  scripts\common\anim::addnotetrack_customfunction("farah", "mix2", ::audio_mix_move2, "finale_kickoff_sh01");
  scripts\common\anim::addnotetrack_customfunction("farah", "mix3", ::audio_mix_move3, "finale_kickoff_sh01");
  scripts\common\anim::addnotetrack_customfunction("farah", "mix4", ::audio_mix_move4, "finale_kickoff_sh01");
  level.scr_anim["barkov"]["finale_kickoff_sh01"] = % lab_end_010_finale_kickoff_sh01_barkov;
  level.scr_goaltime["barkov"]["finale_kickoff_sh01"] = 0;
  level.scr_anim["farah"]["finale_kickoff_sh02"] = % lab_end_010_finale_kickoff_sh02_farah;
  level.scr_goaltime["farah"]["finale_kickoff_sh02"] = 0;
  level.scr_anim["nikolai"]["finale_kickoff_sh02"] = % lab_end_010_finale_kickoff_sh02_nikolai;
  level.scr_goaltime["nikolai"]["finale_kickoff_sh02"] = 0;
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %lab_end_010_finale_kickoff_sh02_farah_face, "finale_kickoff_sh02");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %lab_end_010_finale_kickoff_sh02_farah_face, "finale_kickoff_sh02");
  scripts\common\anim::addnotetrack_mayhemstart("nikolai", "mayhem_start", %lab_end_010_finale_kickoff_sh02_nikolai_face, "finale_kickoff_sh02");
  scripts\common\anim::addnotetrack_mayhemend("nikolai", "mayhem_end", %lab_end_010_finale_kickoff_sh02_nikolai_face, "finale_kickoff_sh02");
  level.scr_anim["farah"]["final_shot"][0] = % lab_end_010_finale_kickoff_sh03_farah;
  level.scr_goaltime["farah"]["final_shot"] = 0;
  level.scr_anim["nikolai"]["final_shot"][0] = % lab_end_010_finale_kickoff_sh03_nikolai;
  level.scr_goaltime["nikolai"]["final_shot"] = 0;
}

kill_barkov(var_0) {
  var_0.ignoreall = 1;
  var_0.diequietly = 1;
  var_0.skipdeathanim = 1;

  if(isDefined(var_0.magic_bullet_shield))
    var_0 scripts\common\ai::stop_magic_bullet_shield();

  var_0.allowdeath = 1;
  var_0 startragdoll();
  var_0 kill();
}

big_boom(var_0) {
  level notify("boom");
  level.player playSound("scn_lab_finale_expl_lr");
  scripts\engine\utility::exploder("final_explosion");
  thread scripts\sp\maps\lab\lab_finale.gsc::finale_trees_delete("finale_scene_trees_firstshot");
  roof_collapse_init();
}

audio_mix_move1(var_0) {
  level.player setsoundsubmix("sp_lab_ending_duck_2", 15.0);
}

audio_mix_move2(var_0) {
  level.player clearsoundsubmix("sp_lab_ending_duck_2", 5.0);
}

audio_mix_move3(var_0) {
  level.player clearsoundsubmix("sp_lab_ending_duck_1", 5.0);
  wait 5;
  level.player setsoundsubmix("sp_lab_ending_duck_1", 8.0);
}

audio_mix_move4(var_0) {
  level.player setsoundsubmix("sp_lab_ending_duck_3", 4.0);
}

roof_collapse_init() {
  level endon("skip_end_scene");
  scripts\engine\utility::delaythread(1.2, ::collapse_earthquakes);
}

collapse_earthquakes() {
  level endon("skip_end_scene");
  var_0 = [0.2, 0.3, 0.1, 0.2, 0.3, 0.1, 0.2, 0.1, 0.1, 0.2, 0.1, 0.2, 0.1, 0.05, 0.1, 0.05];
  var_1 = 0;
  var_2 = 0.22;
  var_3 = 0.95;

  for(;;) {
    earthquake(var_0[var_1], var_0[var_1] + var_3, level.player.origin, 100);
    wait(var_0[var_1] + var_2);
    var_1++;

    if(var_1 == 9) {
      var_3 = 1;
      var_2 = 0.33;
    }

    if(var_0.size == var_1) {
      break;
    }
  }
}

collapse_thread(var_0, var_1) {
  var_2 = getscriptablearray(var_0, "script_noteworthy");
  wait(var_1);
  var_2[0] setscriptablepartstate("base", "dead", 1);
}

weapons_up(var_0) {
  var_0 hide();
  level.player enablequickweaponswitch(0);
  level.player showviewmodel();
  level.player modifybasefov(65, 0.5);
  level.player lerpfovscalefactor(1, 0.5);
  level.player scripts\common\utility::allow_weapon(1, "player_rig");
}

force_stop_anim(var_0) {
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
}

barkov_death(var_0) {
  var_0.allowdeath = 1;
  var_0.diequietly = 1;
  var_0.skipdeathanim = 1;
  var_0.disabledeathorient = 1;
  var_0 delete();
}

farah_swap_mask_back(var_0) {
  level.farah detach("prop_gasmask", "tag_origin");
  level.farah.hatmodel = level.farah.og_hatmodel;
  level.farah attach(level.farah.hatmodel);
}

start_detonator(var_0) {
  level.nikolai detach("offhand_vm_clacker_tactical_sp_cinematic", "tag_accessory_right");
  level.player_rig.detonator show();
}

detach_bomb(var_0) {
  var_0 detach("offhand_wm_c4_bomb", "tag_accessory_right");

  if(isDefined(var_0.bombnode)) {
    var_1 = getEnt(var_0.bombnode.targetname + "_bomb", "targetname");
    var_1 show();
    wait 1;
    playFXOnTag(scripts\engine\utility::getfx("vfx_c4_light"), var_1, "tag_fx");
  }
}

dragons_breath_shot(var_0) {
  if(scripts\engine\utility::flag("db_enemy_dead")) {
    self.ragdoll_immediate = 0;
    self.diequietly = 0;
    scripts\engine\sp\utility::anim_stopanimScripted();
    scripts\engine\sp\utility::enable_ai_color();
    var_1 = getnode("saved_guy_node", "targetname");
    thread scripts\sp\spawner::go_to_node(var_1);
    return;
  }

  scripts\engine\utility::flag_set("dragons_breath_shot");
  level.cp_3_enemy endon("death");
  level.cp_3_enemy endon("weapon_dropped");
  var_2 = scripts\sp\utility::make_weapon("iw8_sh_dpapa12_incendiary");
  var_3 = undefined;
  var_4 = 6;

  for(var_5 = 0; var_5 < var_4; var_5++) {
    if(nullweapon(level.cp_3_enemy.weapon)) {
      return;
    }
    var_6 = level.cp_3_enemy gettagorigin("tag_flash");

    if(var_5 > 2)
      var_3 = level.cp_3_enemy gettagorigin("tag_flash") + anglesToForward(level.cp_3_enemy gettagangles("tag_flash")) * 50;
    else if(isalive(var_0))
      var_3 = var_0 gettagorigin("j_spine4");

    if(isDefined(var_3)) {
      playFXOnTag(level._effect["vfx_muz_dragons_breath_w"], level.cp_3_enemy, "tag_flash");
      magicbullet(var_2, var_6, var_3, level.cp_3_enemy);
    }

    if(var_5 == 0) {
      var_0 thread scripts\common\ai::gun_remove();
      thread scripts\engine\utility::play_sound_in_space("generic_death_falling_scream");
    }

    wait(0.45 + randomfloat(0.6));
  }
}

start_tarp_mayhem(var_0) {
  level notify("start_tarp_sim");
  playmayhem("mayh_lab_heli_tarp");
}

damage_on_elbow_strike(var_0) {
  level.player disableinvulnerability();
  level.player shellshock("captive_hit", 1);
  level notify("move_window_light_elbow");

  if(level.player.health > 12) {
    var_1 = min(level.player.health - 2, 20);
    level.player scripts\sp\utility::do_damage(var_1, var_0.origin, var_0, var_0, "MOD_MELEE");
  }

  level.player playRumbleOnEntity("heavy_1s");
}

damage_on_gun_shot(var_0) {
  level.player disableinvulnerability();

  if(level.player.health > 12) {
    var_1 = min(level.player.health - 2, 45);
    level.player scripts\sp\utility::do_damage(var_1, var_0.origin, var_0, var_0, "MOD_PISTOL_BULLET");
  }

  level.player playRumbleOnEntity("heavy_1s");
}

drop_walkie_prop(var_0) {
  if(isDefined(level.barkov.propmodel))
    level.barkov.propmodel delete();
}

barkov_start_choke_effect(var_0) {
  if(!isDefined(level.player.breathoverlay))
    scripts\sp\maps\lab\lab_finale.gsc::setup_breath_overlay();

  level.player.breathoverlay fadeovertime(6);
  level.player.breathoverlay.alpha = 1;
  wait 5;
  visionsetnaked("lab_near_death", 5);
  level waittill("stop_choking");
  level.player.breathoverlay fadeovertime(1);
  level.player.breathoverlay.alpha = 0;
  visionsetnaked("lab_ending_sss", 1);
}

barkov_shoots(var_0) {
  level.player notify("barkov_crawl_finished");
  var_0 shoot(0.9, level.player);
  kill_player(var_0);
}

kill_player(var_0) {
  if(isalive(level.player))
    level.player disableinvulnerability();

  if(isalive(level.player))
    level.player scripts\sp\utility::do_damage(level.player.health + 10000, var_0.origin, var_0, var_0, "MOD_PISTOL_BULLET");

  if(isalive(level.player))
    level.player kill();

  if(isDefined(level.player_rig))
    level.finale_heli scripts\common\anim::anim_last_frame_solo(level.player_rig, "finale_stab_fail");
}

stab_swap_01(var_0) {
  var_0.firststabs = 1;
  var_0 setModel("body_villain_barkov_wind_all_stab_1");
}

stab_swap_02(var_0) {
  var_0 setModel("body_villain_barkov_wind_all_stab_2");
}

stab_swap_03(var_0) {
  if(isDefined(var_0.firststabs) && var_0.firststabs)
    var_0 setModel("body_villain_barkov_wind_all_stab_3");
  else
    var_0 setModel("body_villain_barkov_wind_gun_stab_3");
}

stab_swap_04(var_0) {
  if(isDefined(var_0.firststabs) && var_0.firststabs)
    var_0 setModel("body_villain_barkov_wind_all_stab_4");
  else
    var_0 setModel("body_villain_barkov_wind_gun_stab_4");
}

stab_swap_05(var_0) {
  if(isDefined(var_0.firststabs) && var_0.firststabs)
    var_0 setModel("body_villain_barkov_wind_all_stab_5");
  else
    var_0 setModel("body_villain_barkov_wind_gun_stab_5");

  var_0 detach(var_0.headmodel);
  var_0 attach("head_villain_barkov_stab_5_blendshape");
  var_0.headmodel = "head_villain_barkov_stab_5_blendshape";
}

stab_swap_06(var_0) {
  if(isDefined(var_0.firststabs) && var_0.firststabs)
    var_0 setModel("body_villain_barkov_wind_all_stab_6");
  else
    var_0 setModel("body_villain_barkov_wind_gun_stab_6");
}

say_choke_stab_vo_01(var_0) {
  level.player thread scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_kill_bodyshot_36");
  var_0 thread scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue_on_tag("dx_vom_bkv_finale_heli_kill_bodyshot_39");
  var_0 endon("stop_simple_dialogue");
  wait(lookupsoundlength("dx_vom_bkv_finale_heli_kill_bodyshot_39") / 1000);
  var_0 thread scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue_on_tag("dx_vom_bkv_finale_heli_kill_bodyshot_40");
}

say_choke_stab_vo_02(var_0) {
  level.player thread scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_kill_bodyshot_36");
  var_0 scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue_on_tag("dx_vom_bkv_finale_heli_kill_bodyshot_30");
}

say_choke_stab_vo_03(var_0) {
  level.player thread scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_kill_bodyshot_36");
  var_0 scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue_on_tag("dx_vom_bkv_finale_heli_kill_knife_60");
}

vo_face() {
  level.scr_face["price"]["dx_vom_pri_hill_top_transition_10"] = % dx_vom_far_hill_top_transition_10_face;
  level.scr_face["price"]["dx_vom_pri_hill_top_transition_20"] = % dx_vom_pri_hill_top_transition_20_face;
  level.scr_face["nikolai"]["dx_vom_nik_jumpdown_intro_30"] = % dx_vom_nik_jumpdown_intro_30_face;
  level.scr_face["nikolai"]["dx_vom_nik_jumpdown_charges_10"] = % dx_vom_nik_jumpdown_charges_10_face;
  level.scr_face["nikolai"]["dx_vom_nik_jumpdown_charges_20"] = % dx_vom_nik_jumpdown_charges_20_face;
  level.scr_face["nikolai"]["dx_vom_nik_jumpdown_charges_40"] = % dx_vom_nik_jumpdown_charges_40_face;
  level.scr_face["price"]["dx_vom_pri_pipes_outdoor_outro_40"] = % dx_vom_pri_pipes_outdoor_outro_40_face;
  level.scr_face["price"]["dx_vom_pri_pipes_outdoor_outro_50"] = % dx_vom_pri_pipes_outdoor_outro_50_face;
  level.scr_face["price"]["dx_vom_pri_final_pipes_charges_20"] = % dx_vom_pri_final_pipes_charges_20_face;
  level.scr_face["price"]["dx_vom_pri_final_pipes_charges_30"] = % dx_vom_pri_final_pipes_charges_30_face;
  level.scr_face["price"]["dx_vom_pri_final_pipes_charges_40"] = % dx_vom_pri_final_pipes_charges_40_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_100"] = % dx_vom_bkv_finale_heli_intro_100_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_110"] = % dx_vom_bkv_finale_heli_intro_110_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_120"] = % dx_vom_bkv_finale_heli_intro_120_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_130"] = % dx_vom_bkv_finale_heli_intro_130_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_140"] = % dx_vom_bkv_finale_heli_intro_140_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_150"] = % dx_vom_bkv_finale_heli_intro_150_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_160"] = % dx_vom_bkv_finale_heli_intro_160_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_170"] = % dx_vom_bkv_finale_heli_intro_170_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_180"] = % dx_vom_bkv_finale_heli_intro_180_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_190"] = % dx_vom_bkv_finale_heli_intro_190_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_200"] = % dx_vom_bkv_finale_heli_intro_200_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_210"] = % dx_vom_bkv_finale_heli_intro_210_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_220"] = % dx_vom_bkv_finale_heli_intro_220_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_230"] = % dx_vom_bkv_finale_heli_intro_230_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_240"] = % dx_vom_bkv_finale_heli_intro_240_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_250"] = % dx_vom_bkv_finale_heli_intro_250_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_260"] = % dx_vom_bkv_finale_heli_intro_260_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_270"] = % dx_vom_bkv_finale_heli_intro_270_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_intro_280"] = % dx_vom_bkv_finale_heli_intro_280_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_kill_knife_10"] = % dx_vom_bkv_finale_heli_kill_knife_10_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_kill_knife_16"] = % dx_vom_bkv_finale_heli_kill_knife_16_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_kill_knife_40"] = % dx_vom_bkv_finale_heli_kill_knife_40_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_kill_knife_60"] = % dx_vom_bkv_finale_heli_kill_knife_60_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_kill_knife_90"] = % dx_vom_bkv_finale_heli_kill_knife_90_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_kill_bodyshot_30"] = % dx_vom_bkv_finale_heli_kill_bodyshot_30_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_kill_bodyshot_39"] = % dx_vom_bkv_finale_heli_kill_bodyshot_39_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_kill_bodyshot_40"] = % dx_vom_bkv_finale_heli_kill_bodyshot_40_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_alertfail_10"] = % dx_vom_bkv_finale_heli_alertfail_10_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_10"] = % dx_vom_bkv_finale_heli_hidensneak_10_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_30"] = % dx_vom_bkv_finale_heli_hidensneak_30_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_50"] = % dx_vom_bkv_finale_heli_hidensneak_50_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_80"] = % dx_vom_bkv_finale_heli_hidensneak_80_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_100"] = % dx_vom_bkv_finale_heli_hidensneak_100_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_120"] = % dx_vom_bkv_finale_heli_hidensneak_120_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_130"] = % dx_vom_bkv_finale_heli_hidensneak_130_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_150"] = % dx_vom_bkv_finale_heli_hidensneak_150_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_170"] = % dx_vom_bkv_finale_heli_hidensneak_170_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_230"] = % dx_vom_bkv_finale_heli_hidensneak_230_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_240"] = % dx_vom_bkv_finale_heli_hidensneak_240_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_250"] = % dx_vom_bkv_finale_heli_hidensneak_250_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_260"] = % dx_vom_bkv_finale_heli_hidensneak_260_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_270"] = % dx_vom_bkv_finale_heli_hidensneak_270_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_290"] = % dx_vom_bkv_finale_heli_hidensneak_290_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_300"] = % dx_vom_bkv_finale_heli_hidensneak_300_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_330"] = % dx_vom_bkv_finale_heli_hidensneak_330_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_340"] = % dx_vom_bkv_finale_heli_hidensneak_340_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_350"] = % dx_vom_bkv_finale_heli_hidensneak_350_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_370"] = % dx_vom_bkv_finale_heli_hidensneak_370_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_390"] = % dx_vom_bkv_finale_heli_hidensneak_390_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_400"] = % dx_vom_bkv_finale_heli_hidensneak_400_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_420"] = % dx_vom_bkv_finale_heli_hidensneak_420_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_440"] = % dx_vom_bkv_finale_heli_hidensneak_440_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_460"] = % dx_vom_bkv_finale_heli_hidensneak_460_face;
  level.scr_face["barkov"]["dx_vom_bkv_finale_heli_hidenseek_470"] = % dx_vom_bkv_finale_heli_hidensneak_470_face;
}

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["tank_1"] = #animtree;
  level.scr_animtree["tank_2"] = #animtree;
  level.scr_anim["tank_2"]["bridge_scene"] = % lab_br_010_intro_start_tank;
  scripts\common\anim::addnotetrack_customfunction("tank_2", "start_shake", ::tank_shake_start, "bridge_scene");
  scripts\common\anim::addnotetrack_customfunction("tank_2", "stop_shake", ::tank_shake_end, "bridge_scene");
  scripts\common\anim::addnotetrack_notify("tank_2", "stop_shake", "stop_shake", "bridge_scene");
  level.scr_anim["tank_2"]["tank_death"] = % lab_hill_020_bromeo_react;
  level.scr_animtree["nik_van"] = #animtree;
  level.scr_anim["nik_van"]["van_jumpdown_idle"][0] = % lab_tbn_015_dock_start_idle_van;
  level.scr_anim["nik_van"]["van_jumpdown_start"] = % lab_tbn_015_dock_scenea_van;
  level.scr_anim["nik_van"]["van_scene"] = % lab_tbn_015_dock_sceneb_van;
  level.scr_animtree["finale_heli"] = #animtree;
  level.scr_anim["finale_heli"]["pipes_bomb_plant"] = % lab_end_005_bomb_plant_veh01;
  level.scr_goaltime["finale_heli"]["pipes_bomb_plant"] = 0.3;
  level.scr_anim["finale_heli"]["final_shot"] = % lab_end_010_finale_kickoff_sh03_heli;
  level.scr_goaltime["finale_heli"]["final_shot"] = 0;
  level.scr_anim["finale_heli"]["finale_idle"][0] = % lab_end_010_finale_idle_helicopter;
  level.scr_anim["finale_heli"]["finale_sway"][0] = % lab_end_010_finale_idle_sway_helicopter;
  level.scr_anim["finale_heli"]["finale_kickoff_sh02"] = % lab_end_010_finale_kickoff_sh02_veh01;
}

tank_shake_start(var_0) {
  level endon("stop_shake");
  var_0 thread bridge_tank_move_sfx();

  for(;;) {
    var_1 = 0.5;
    var_0 screenshakeonentity(0.4, 0.8, 0.4, var_1, 0.1, 0.1, 300, 2, 4, 4);
    wait(var_1);
  }
}

bridge_tank_move_sfx() {
  self vehicle_turnengineoff();
  self playSound("veh_bradley_engine_start");

  if(!isDefined(self.tread_sfx)) {
    self.tread_sfx = spawn("script_origin", self.origin);
    self.tread_sfx linkTo(self);
  }

  self.tread_sfx scripts\engine\sp\utility::sound_fade_in("veh_bradley_treads", 1, 0.5, 1);
  wait 1;
  self playLoopSound("veh_bradley_engine_lp");
}

tank_shake_end(var_0) {
  var_0 screenshakeonentity(0.4, 0.8, 0.4, 0.7, 0, 0.3, 500, 2, 4, 4);

  if(isDefined(var_0.tread_sfx))
    var_0.tread_sfx scripts\engine\sp\utility::sound_fade_and_delete(2, 1);

  var_0 thread scripts\sp\maps\lab\lab_hill.gsc::tank_engine_sfx();
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["missile"] = #animtree;
  level.scr_anim["missile"]["bridge_scene"] = % lab_br_010_intro_start_bomb;
  level.scr_animtree["missile_light"] = #animtree;
  level.scr_anim["missile_light"]["bridge_scene"] = % lab_br_010_intro_start_light;
  level.scr_animtree["drone"] = #animtree;
  level.scr_anim["drone"]["bridge_scene"] = % lab_br_010_intro_start_drone;
  level.scr_animtree["debris_01"] = #animtree;
  level.scr_anim["debris_01"]["bridge_scene"] = % lab_br_010_intro_start_debris01;
  level.scr_animtree["debris_02"] = #animtree;
  level.scr_anim["debris_02"]["bridge_scene"] = % lab_br_010_intro_start_debris02;
  level.scr_animtree["debris_03"] = #animtree;
  level.scr_anim["debris_03"]["bridge_scene"] = % lab_br_010_intro_start_debris03;
  level.scr_animtree["player_mask"] = #animtree;
  level.scr_anim["player_mask"]["player_mask_on"] = % lab_vm_gasmask_prop;
  level.scr_goaltime["player_mask"]["player_mask_on"] = 0.0;
  scripts\common\anim::addnotetrack_customfunction("player_mask", "hide_mask", ::hide_mask, "player_mask_on");
  scripts\common\anim::addnotetrack_customfunction("player_mask", "show_mask", ::show_mask, "player_mask_on");
  scripts\common\anim::addnotetrack_customfunction("player_mask", "ai_masks", ::ai_masks, "player_mask_on");
  scripts\common\anim::addnotetrack_customfunction("player_mask", "mask_is_on", ::mask_is_on, "player_mask_on");
  level.scr_animtree["gl_intro_door"] = #animtree;
  level.scr_anim["gl_intro_door"]["lab_door_enter"] = % lab_hill_010_plan_scene_door;
  level.scr_animtree["halligan"] = #animtree;
  level.scr_model["halligan"] = "misc_wm_halligan_tool";
  level.scr_anim["halligan"]["lab_door_enter"] = % lab_hill_010_plan_scene_halligan;
  level.scr_goaltime["halligan"]["lab_door_enter"] = 0.2;
  level.scr_animtree["cp_3_left_door"] = #animtree;
  level.scr_anim["cp_3_left_door"]["cp_3_buddy_door_push"] = % lab_tbn_020_buddy_down_push_doorlt;
  level.scr_animtree["cp_3_right_door"] = #animtree;
  level.scr_anim["cp_3_right_door"]["cp_3_buddy_door_push"] = % lab_tbn_020_buddy_down_push_doorrt;
  level.scr_animtree["van_intro_doors"] = #animtree;
  level.scr_animtree["van_bomb"] = #animtree;
  level.scr_anim["van_bomb"]["van_bomb_pickup"] = % lab_tbn_015_dock_sceneb_plr_bomb;
  level.scr_animtree["van_detonator"] = #animtree;
  level.scr_model["van_detonator"] = "offhand_vm_clacker_tactical_sp_cinematic";
  level.scr_anim["van_detonator"]["van_bomb_pickup"] = % lab_tbn_015_dock_sceneb_detonator;
  level.scr_animtree["van_bomb_ally01"] = #animtree;
  level.scr_anim["van_bomb_ally01"]["van_jumpdown_start"] = % lab_tbn_015_dock_scenea_bomb01;
  level.scr_animtree["van_bomb_ally02"] = #animtree;
  level.scr_anim["van_bomb_ally02"]["van_jumpdown_start"] = % lab_tbn_015_dock_scenea_bomb02;
  level.scr_animtree["van_bomb_ally03"] = #animtree;
  level.scr_anim["van_bomb_ally03"]["van_jumpdown_start"] = % lab_tbn_015_dock_scenea_bomb03;
  level.scr_animtree["cp_3_left_door"] = #animtree;
  level.scr_anim["cp_3_left_door"]["van_door_push"] = % lab_tbn_020_buddy_down_push_doorlt;
  level.scr_animtree["cp_3_right_door"] = #animtree;
  level.scr_anim["cp_3_right_door"]["van_door_push"] = % lab_tbn_020_buddy_down_push_doorrt;
  level.scr_animtree["gas_button_mask"] = #animtree;
  level.scr_anim["gas_button_mask"]["chem_room_pad"] = % lab_gas_010_interact_gasmask;
  level.scr_goaltime["gas_button_mask"]["chem_room_pad"] = 0.3;
  level.scr_animtree["cp_5_left_door"] = #animtree;
  level.scr_anim["cp_5_left_door"]["cp_5_juggernaut"] = % lab_tbn_040_juggernaut_enter_door01_rt;
  level.scr_animtree["cp_5_right_door"] = #animtree;
  level.scr_anim["cp_5_right_door"]["cp_5_juggernaut"] = % lab_tbn_040_juggernaut_enter_door01_lt;
  level.scr_animtree["cp_5_detonator"] = #animtree;
  level.scr_anim["cp_5_detonator"]["cp_5_juggernaut"] = % lab_tbn_040_juggernaut_enter_detonator;
  level.scr_animtree["gas_button"] = #animtree;
  level.scr_anim["gas_button"]["chem_room_pad"] = % lab_gas_010_interact_button;
  level.scr_goaltime["gas_button"]["chem_room_pad"] = 0.3;
  level.scr_animtree["finale_bomb"] = #animtree;
  level.scr_model["finale_bomb"] = "offhand_wm_c4";
  level.scr_anim["finale_bomb"]["pipes_bomb_plant"] = % lab_end_005_bomb_plant_bomb;
  level.scr_goaltime["finale_bomb"]["pipes_bomb_plant"] = 0.3;
  level.scr_animtree["fake_cpapa"] = #animtree;
  level.scr_weapon["fake_cpapa"] = ["iw8_pi_cpapa", [], 1];
  level.scr_animtree["fake_mike"] = #animtree;
  level.scr_weapon["fake_mike"] = ["iw8_pi_mike1911", [], 1];
}

hide_mask(var_0) {
  if(isDefined(var_0))
    var_0 hide();
}

show_mask(var_0) {
  if(isDefined(var_0))
    var_0 show();
}

ai_masks(var_0) {
  var_1 = [level.rebel_1, level.rebel_2, level.farah, level.rebel_3];
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(var_1, scripts\sp\maps\lab\lab_util.gsc::ai_gas_mask, 1);
}

mask_is_on(var_0) {
  scripts\engine\utility::flag_set("player_mask_on");
}

swap_to_fake_cpapa(var_0) {
  var_1 = var_0 gettagorigin("tag_weapon_right");
  var_2 = var_0 gettagangles("tag_weapon_right");
  var_0.fakegun = spawn("script_model", level.finale_heli gettagorigin("tag_origin"));
  var_0.fakegun scripts\common\utility::make_weapon_model(getweaponbasename(var_0.weapon), getweaponattachments(var_0.weapon), 0);
  var_0.fakegun linkTo(level.finale_heli, "tag_origin", (-145, 40, -141), (174, -45, 90));
  var_0.gun_on_ground = var_0.fakegun;
  var_0 scripts\anim\shared.gsc::placeweaponon(var_0.weapon, "none");
  var_0.dropweapon = 0;
}

pickup_fake_cpapa(var_0) {
  var_0 scripts\sp\anim_notetrack::gun_pickup_right();
}

check_health_status(var_0) {
  var_0 endon("single anim");
  wait 0.05;

  while(!istrue(var_0.shotduringanim))
    waitframe();

  var_0 notify("single anim", "end");
}

#using_animtree("scriptables");

scriptables() {
  level.scr_animtree["spruce_01"] = #animtree;
  level.scr_anim["spruce_01"]["low"] = % lab_foliage_tree_spruce_01_heli_lo;
  level.scr_anim["spruce_01"]["mid"] = % lab_foliage_tree_spruce_01_heli_mid;
  level.scr_anim["spruce_01"]["hi"] = % lab_foliage_tree_spruce_01_heli_hi;
  level.scr_animtree["spruce_01_sml"] = #animtree;
  level.scr_anim["spruce_01_sml"]["low"] = % lab_foliage_tree_spruce_01_sml_heli_lo;
  level.scr_anim["spruce_01_sml"]["mid"] = % lab_foliage_tree_spruce_01_sml_heli_mid;
  level.scr_anim["spruce_01_sml"]["hi"] = % lab_foliage_tree_spruce_01_sml_heli_hi;
  level.scr_animtree["spruce_02"] = #animtree;
  level.scr_anim["spruce_02"]["low"] = % lab_foliage_tree_spruce_02_heli_lo;
  level.scr_anim["spruce_02"]["mid"] = % lab_foliage_tree_spruce_02_heli_mid;
  level.scr_anim["spruce_02"]["hi"] = % lab_foliage_tree_spruce_02_heli_hi;
  level.scr_animtree["spruce_03"] = #animtree;
  level.scr_anim["spruce_03"]["low"] = % lab_foliage_tree_spruce_03_anim_low;
  level.scr_anim["spruce_03"]["mid"] = % lab_foliage_tree_spruce_03_anim_med;
  level.scr_anim["spruce_03"]["hi"] = % lab_foliage_tree_spruce_03_anim_high;
  level.scr_animtree["spruce_03_sml"] = #animtree;
  level.scr_anim["spruce_03_sml"]["low"] = % lab_foliage_tree_spruce_01_sml_heli_lo;
  level.scr_anim["spruce_03_sml"]["mid"] = % lab_foliage_tree_spruce_01_sml_heli_mid;
  level.scr_anim["spruce_03_sml"]["hi"] = % lab_foliage_tree_spruce_01_sml_heli_hi;
}