/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_empambush\sa_empambush.gsc
*********************************************************/

main() {
  scripts\sp\utility::_id_116CB("sa_empambush");
  scripts\sp\maps\sa_empambush\gen\sa_empambush_art::main();
  scripts\sp\maps\sa_empambush\sa_empambush_fx::main();
  scripts\sp\maps\sa_empambush\sa_empambush_lighting::main();
  scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_E9A4();
  _id_0F00::_id_25D8();
  scripts\sp\maps\sa_empambush\sa_empambush_precache::main();
  setsaveddvar("r_umbraMinObjectContribution", 8);
  setsaveddvar("r_tessellationOverride", 0);
  setsaveddvar("r_umbraShadowCasters", 1);
  _id_1FA6();
  _id_1FA7();
  _id_1FA4();
  _id_1FA5();
  precache();
  _id_95F5();
  init_flags();
  _id_FA53();
  scripts\sp\utility::_id_1263F("sa_emp_ret_land_tr");
  scripts\sp\utility::_id_1263F("sa_empambush_prime_tr");
  scripts\sp\utility::_id_1263F("sa_empambush_prime_slowhdd_tr");
  scripts\sp\utility::_id_1263F("sa_empambush_pre_docking_tr");
  scripts\sp\utility::_id_1263F("sa_empambush_never_loaded_tr");
  scripts\sp\utility::_id_1263F("sa_empambush_player_jackal_tr");

  if(getDvar("createfx") != "") {
    level thread _id_0F16::_id_88CA();
    _id_FA13(0);
  }

  _id_0B51::_id_B8CA();
  level._id_FD6E._id_E35D hide();
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("hide");
  scripts\sp\load::main();
  _id_0F35::main();
  scripts\engine\utility::flag_set("highlight_zero_g_ai");
  level._id_13E75 = 7000;
  level._id_241D = 0;
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 3);
  setsaveddvar("player_isInZeroGLevel", 1);
  thread _id_FA80();
  thread _id_3ABD();
  thread _id_0F16::_id_FA47();
  thread _id_0F16::_id_FA48();
  thread _id_0F16::_id_94F7();
  scripts\sp\utility::_id_22C9("salter_0G", ::_id_1D1E);
  _id_0F0E::_id_F901();
  _id_0F0E::_id_F900("carrier_hull");
  wait 0.1;
  level._id_3965 _id_0BB8::_id_397D();
  level._id_3965 _id_0BB8::_id_397C();
  level._id_3965 _id_0BB8::_id_39C5();
  level._id_3965 hide();
  setglobalsoundcontext("atmosphere", "space", 0.5);
  scripts\engine\utility::flag_set("disable_weapon_help");
  level thread _id_0A2F::_id_3D61();
  scripts\engine\utility::delaythread(1, _id_0E4B::helmethud_on);
  level.player allowwallrun(0);
}

#using_animtree("player");

_id_1FA6() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["emp_plant"] = % sa_emp_plantcharge_plr;
  scripts\sp\anim::_id_17F6("player_rig", "gun_up", ::_id_86EB, "emp_plant");
}

_id_86EB(var_0) {
  level.player _meth_84FD();
  level.player enableweapons();
}

#using_animtree("jackal");

_id_1FA5() {
  level._id_EC87["jackal"] = #animtree;
  level._id_EC85["jackal"]["hangar_scene"] = % sa_emp_interior_prototype_jackal;
}

#using_animtree("script_model");

_id_1FA7() {
  level._id_EC87["generic_prop"] = #animtree;
  level._id_EC8C["generic_prop"] = "generic_prop_x5";
  level._id_EC85["generic_prop"]["emp_dropship_unload"] = % sa_emp_engineworkers_dropship_equipment_spawn;
  level._id_EC87["player_rope"] = #animtree;
  level._id_EC8C["player_rope"] = "grapple_rope_250u";
  level._id_EC85["player_rope"]["emp_plant"] = % sa_emp_plantcharge_plr_rope;
  level._id_EC87["salter_rope"] = #animtree;
  level._id_EC8C["salter_rope"] = "grapple_rope_250u";
  level._id_EC85["salter_rope"]["emp_plant"] = % sa_emp_plantcharge_salter_rope;
  level._id_EC87["player_emp"] = #animtree;
  level._id_EC8C["player_emp"] = "weapon_empdevice_wm";
  level._id_EC85["player_emp"]["emp_plant"] = % sa_emp_plantcharge_empdevice;
  level._id_EC87["salter_emp"] = #animtree;
  level._id_EC8C["salter_emp"] = "weapon_empdevice_wm";
  level._id_EC85["salter_emp"]["emp_plant"] = % sa_emp_plantcharge_empdevice_salter;
  level._id_EC87["engine_parts"] = #animtree;
  level._id_EC8C["engine_parts"] = "ship_exterior_ca_thruster_flaps_01";
  level._id_EC85["engine_parts"]["engine_loop"][0] = % sa_emp_carrier_engine_idling_loop;
  level._id_EC85["engine_parts"]["engine_spinning_down"] = % sa_emp_carrier_engine_spinning_down;
  level._id_EC87["ship_floater"] = #animtree;
  level._id_EC8C["ship_floater"] = "generic_prop_x5";
  level._id_EC85["ship_floater"]["jackal_float"][0] = % sa_empambush_interior_zerog_jackal;
  level._id_EC85["ship_floater"]["dropship_float"][0] = % sa_empambush_interior_zerog_dropship;
  level._id_EC87["cargobay_doors"] = #animtree;
  level._id_EC8C["cargobay_doors"] = "sdf_carrier_exitbay_hangar_door_rig";
  level._id_EC85["cargobay_doors"]["cargo_bay_doors_shoot_open"] = % sa_emp_cargobaydoors_blownoff;
  level._id_EC85["cargobay_doors"]["missile_hit1"] = % sa_emp_cargobaydoors_missileimpact_1;
  level._id_EC85["cargobay_doors"]["missile_hit2"] = % sa_emp_cargobaydoors_missileimpact_2;
  level._id_EC85["cargobay_doors"]["missile_hit3"] = % sa_emp_cargobaydoors_missileimpact_3;
  level._id_EC85["cargobay_doors"]["missile_hit4"] = % sa_emp_cargobaydoors_blownoff;
  scripts\sp\anim::_id_17F6("cargobay_doors", "missile_hit", ::_id_B7FD, "cargo_bay_doors_shoot_open");
}

_id_B7FD(var_0) {
  if(!isDefined(level._id_B7FE))
    level._id_B7FE = 1;

  var_1 = scripts\engine\utility::getStruct("cargobay_door_hit_" + level._id_B7FE, "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin);
  playFX(level._effect["door_explosion"], var_2.origin);
  level._id_B7FE++;
  wait 5;

  if(isDefined(var_2))
    var_2 delete();
}

#using_animtree("generic_human");

_id_1FA4() {
  level._id_EC85["salter"]["salter_intro"] = % sa_emp_intro_salter;
  level._id_EC85["salter"]["salter_asteroid_hop"] = % sa_emp_zerog_asteroid_hop_salter;
  level._id_EC85["generic"]["engine_welding1"] = % sa_emp_engineworkers_spotwelder;
  level._id_EC85["generic"]["engine_welding2"] = % sa_emp_engineworkers_spotwelder2;
  level._id_EC85["generic"]["engine_welding3"] = % sa_emp_engineworkers_spotwelder3;
  scripts\sp\anim::_id_17F6("generic", "unhide_welding_torch", ::_id_12B9D, "engine_welding1");
  scripts\sp\anim::_id_17F6("generic", "start_weld_fx", ::_id_10D5C, "engine_welding1");
  scripts\sp\anim::_id_17F6("generic", "stop_weld_fx", ::_id_11057, "engine_welding1");
  scripts\sp\anim::_id_17F6("generic", "hide_welding_torch", ::_id_8EB7, "engine_welding1");
  scripts\sp\anim::_id_17F6("generic", "unhide_welding_torch", ::_id_12B9D, "engine_welding2");
  scripts\sp\anim::_id_17F6("generic", "start_weld_fx", ::_id_10D5C, "engine_welding2");
  scripts\sp\anim::_id_17F6("generic", "stop_weld_fx", ::_id_11057, "engine_welding2");
  scripts\sp\anim::_id_17F6("generic", "hide_welding_torch", ::_id_8EB7, "engine_welding2");
  scripts\sp\anim::_id_17F6("generic", "unhide_welding_torch", ::_id_12B9D, "engine_welding3");
  scripts\sp\anim::_id_17F6("generic", "start_weld_fx", ::_id_10D5C, "engine_welding3");
  scripts\sp\anim::_id_17F6("generic", "stop_weld_fx", ::_id_11057, "engine_welding3");
  scripts\sp\anim::_id_17F6("generic", "hide_welding_torch", ::_id_8EB7, "engine_welding3");
  level._id_EC87["generic"] = #animtree;
  level._id_EC85["dropship_enemy_1"]["emp_dropship_unload"] = % sa_emp_engineworkers_dropship_soldier1_spawn;
  level._id_EC85["dropship_enemy_2"]["emp_dropship_unload"] = % sa_emp_engineworkers_dropship_soldier2_spawn;
  level._id_EC85["dropship_enemy_3"]["emp_dropship_unload"] = % sa_emp_engineworkers_dropship_crew1_spawn;
  level._id_EC85["dropship_enemy_4"]["emp_dropship_unload"] = % sa_emp_engineworkers_dropship_crew2_spawn;
  level._id_EC85["salter"]["emp_plant"] = % sa_emp_plantcharge_salter;
  scripts\sp\anim::_id_17F6("salter", "emp_activated", ::_id_EA5D, "emp_plant");
  level._id_EC87["corpse"] = #animtree;
  level._id_EC85["corpse"]["sa_empambush_interior_zerog_deadman_1"][0] = % sa_empambush_interior_zerog_deadman_1;
  level._id_EC85["corpse"]["sa_empambush_interior_zerog_deadman_2"][0] = % sa_empambush_interior_zerog_deadman_2;
  level._id_EC85["corpse"]["sa_empambush_interior_zerog_deadman_3"][0] = % sa_empambush_interior_zerog_deadman_3;
  level._id_EC85["corpse"]["sa_empambush_interior_zerog_deadman_4"][0] = % sa_empambush_interior_zerog_deadman_4;
  level._id_EC87["generic"] = #animtree;
  level._id_EC85["generic"]["hangar_scene1"] = % sa_emp_interior_prototype_pilot1;
  level._id_EC85["generic"]["hangar_scene2"] = % sa_emp_interior_prototype_pilot2;
}

_id_12B9D(var_0) {
  var_0._id_13CF4 show();
  var_0._id_13CF5 = undefined;
}

_id_10D5C(var_0) {
  if(!isDefined(var_0._id_13CF2)) {
    var_0._id_13CF2 = 1;
    playFXOnTag(level._effect["welding"], var_0._id_13CF3, "tag_origin");
  }
}

_id_11057(var_0) {
  if(isDefined(var_0._id_13CF2)) {
    var_0._id_13CF2 = undefined;
    stopFXOnTag(level._effect["welding"], var_0._id_13CF3, "tag_origin");
  }
}

_id_8EB7(var_0) {
  var_0._id_13CF4 hide();
  var_0._id_13CF5 = 1;
}

_id_EA5D(var_0) {}

precache() {
  precacheitem("iw7_m8");
  precacheitem("iw7_m4");
  precacheitem("iw7_kbs");
  precacheitem("magic_spaceship_20mm_bullet");
  precachemodel("veh_mil_air_ca_jackal_drone_space_periph");
  precachemodel("ammo_crate_01_zerog");
  precachemodel("equipment_welding_torch_01");
  precachemodel("weapon_empdevice_wm");
  precachemodel("grapple_rope_250u");
  precachemodel("veh_mil_air_un_retribution");
  precachemodel("ship_exterior_light_unit_e_off");
  precachemodel("ship_exterior_light_unit_f_off");
  precachemodel("light_sdf_interior_hallway_01");
  precachemodel("ind_light_led_worklight_on");
  precachemodel("light_interior_ceiling_industrial_lamp_01_on");
  precachestring(&"SA_EMPAMBUSH_YOU_FAILED_TO_REACH_THE");
  _id_0F0F::_id_A343();
  _id_0EFF::_id_23FA();
  _id_0B53::_id_B908("veh_mil_air_ca_carrier", "sp/model_damage_tables/veh_mil_air_ca_carrier_weapons.csv", "sp/model_damage_tables/veh_mil_air_ca_carrier_fx.csv");
}

_id_95F5() {
  level._effect["door_explosion"] = loadfx("vfx/iw7/levels/moon/vfx_big_explosion_spaceship_low_g.vfx");
  level._effect["welding"] = loadfx("vfx/iw7/levels/sa_empambush/vfx_emp_welding.vfx");
  level._effect["emp"] = loadfx("vfx/iw7/levels/sa_empambush/vfx_emp_detonate.vfx");
}

init_flags() {
  scripts\engine\utility::flag_init("none");
  scripts\engine\utility::flag_init("highlight_zero_g_ai");
  scripts\engine\utility::flag_init("dropship_infil_begin");
  scripts\engine\utility::flag_init("asteroid_infil_begin");
  scripts\engine\utility::flag_init("emp_intro_begin");
  scripts\engine\utility::flag_init("emp_begin");
  scripts\engine\utility::flag_init("emp_done");
  scripts\engine\utility::flag_init("hull_combat_begin");
  scripts\engine\utility::flag_init("interior_zerog_begin");
  scripts\engine\utility::flag_init("dropship_vo");
  scripts\engine\utility::flag_init("unload_drop_ship");
  scripts\engine\utility::flag_init("player_unloaded_from_drop_ship");
  scripts\engine\utility::flag_init("start_thruster_loops");
  scripts\engine\utility::flag_init("done");
  scripts\engine\utility::flag_init("jackal_done");
  scripts\engine\utility::flag_init("guys1_dead");
  scripts\engine\utility::flag_init("spotlight_jackal_passed");
  scripts\engine\utility::flag_init("emp_dropship_engine_guys_at_engines");
  scripts\engine\utility::flag_init("emp_dropship_unload_ready");
  scripts\engine\utility::flag_init("send_emp_intro_jackal_away");
  scripts\engine\utility::flag_init("emp_dropship_unload_complete");
  scripts\engine\utility::flag_init("engine_guys_dead");
  scripts\engine\utility::flag_init("emp_dropship_guys_dead");
  scripts\engine\utility::flag_init("emp_dropship_engine_guys_dead");
  scripts\engine\utility::flag_init("ready_to_shoot");
  scripts\engine\utility::flag_init("emp_ready_to_set");
  scripts\engine\utility::flag_init("emp_set");
  scripts\engine\utility::flag_init("ret_called");
  scripts\engine\utility::flag_init("ret_is_here");
  scripts\engine\utility::flag_init("ret_vo_over");
  scripts\engine\utility::flag_init("group_01_right_lights_off");
  scripts\engine\utility::flag_init("group_01_middle_lights_off");
  scripts\engine\utility::flag_init("group_01_left_lights_off");
  scripts\engine\utility::flag_init("group_01_side_01_lights_off");
  scripts\engine\utility::flag_init("group_01_side_02_lights_off");
  scripts\engine\utility::flag_init("group_01_side_03_lights_off");
  scripts\engine\utility::flag_init("group_02_lights_off");
  scripts\engine\utility::flag_init("group_03_lights_off");
  scripts\engine\utility::flag_init("group_04_lights_off");
  scripts\engine\utility::flag_init("0g_patrol2_dead");
  scripts\engine\utility::flag_init("hangar_cleared");
  scripts\engine\utility::flag_init("jackal_crew_dead");
  scripts\engine\utility::flag_init("busted_out");
  scripts\engine\utility::flag_init("hot_combat");
  scripts\engine\utility::flag_init("dogfight_over");
  scripts\engine\utility::flag_init("enemies_done_spawning");
  _id_0F0E::_id_F902();
}

_id_FA53() {
  scripts\sp\utility::_id_F343("zerog_infil");
  var_0 = ["sa_emp_ret_land_tr", "sa_empambush_pre_docking_tr", "sa_empambush_player_jackal_tr"];
  var_1 = ["sa_empambush_prime_tr", "sa_empambush_pre_docking_tr", "sa_empambush_prime_slowhdd_tr"];
  scripts\sp\utility::_id_1749("zerog_infil", ::_id_F8C4, "zerog_infil", ::_id_23F3, ["sa_empambush_pre_docking_tr"], ::_id_23F4);
  scripts\sp\utility::_id_1749("emp_intro", ::_id_F95A, "emp_intro", ::_id_615E, var_1);
  scripts\sp\utility::_id_1749("emp_moment", ::_id_F959, "emp_moment", ::_id_612D, var_1, ::_id_6139);
  scripts\sp\utility::_id_1749("hull_combat", ::_id_F9A0, "hull_combat", ::_id_91B8, var_1);
  scripts\sp\utility::_id_1749("interior_zerog", ::setup_intro_idles, "interior_zerog", ::_id_9A74, ["sa_empambush_prime_tr", "sa_empambush_pre_docking_tr", "sa_empambush_player_jackal_tr", "sa_empambush_prime_slowhdd_tr"], ::_id_9A78);
  scripts\sp\utility::_id_1749("dogfight", ::_id_F940, "dogfight", ::_id_10C1A, var_0);
  scripts\sp\utility::_id_1749("landing", ::_id_F9C0, "landing", ::_id_10C96, ["sa_emp_ret_land_tr", "sa_empambush_pre_docking_tr", "sa_empambush_player_jackal_tr"]);
}

_id_1595() {
  level._id_3965 show();
  level._id_3965._id_B904 = "veh_mil_air_ca_carrier";
  level._id_3965 thread _id_0B53::_id_B909();
  level._id_3965 setCanDamage(1);
}

_id_FA80() {
  scripts\engine\utility::waitframe();

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9)) {
    level._id_EA2C._id_10DB1 = level._id_EA2C.primaryweapon;
    level._id_EA2C scripts\sp\utility::_id_72EC("iw7_m8+m8scope_sp+silencersniperhidee", "primary");
  }
}

_id_107BE() {
  var_0 = getEnt("salter_0G", "script_noteworthy");
  var_0 scripts\sp\utility::_id_10619(1);
}

_id_1D1E() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "salter_0G") {
    level._id_EA2C = self;
    level._id_EA2C._id_1FBB = "salter";
    self._id_EEC9 = 1;
  }

  if(isDefined(self.spawner.targetname) && self.spawner.targetname == "bravo_team_1") {
    level._id_2F4D = self;
    self._id_EEC9 = 2;
  }

  if(isDefined(self.spawner.targetname) && self.spawner.targetname == "bravo_team_2") {
    level._id_2F4E = self;
    self._id_EEC9 = 3;
  }

  scripts\sp\utility::_id_F3B5("r");
  thread scripts\sp\utility::_id_B14F();
  self.goalradius = 16;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.fixednode = 0;
  thread scripts\sp\utility::_id_F2DA(0);
}

_id_1140A() {
  _id_0F25::_id_113D9(level.player, 0);
}

_id_5E18() {
  level._id_D7B9 = 1;
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_5E15();
}

_id_23F4() {
  level._id_D7B9 = 1;
  level._id_D7C4 = 1;
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_13EB7();

  if(scripts\sp\utility::_id_93A6())
    scripts\sp\specialist_MAYBE::_id_F3FF(1);
}

_id_F8C4() {
  level._id_6192 = 1;
  var_0 = scripts\engine\utility::getStruct("asteroids_player_start", "targetname");
  level.player setOrigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  level.player thread _id_E9A5(var_0);
  _id_107BE();
  _id_0F35::_id_FAFC();
  thread _id_88AD();
  scripts\sp\maps\sa_empambush\sa_empambush_jackal_patrols::_id_963E();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_13EB8();
}

_id_E9A5(var_0) {
  level.player disableweapons();
  level.player freezecontrols(1);
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  var_1.angles = var_0.angles;
  level.player _meth_823B(var_1, "tag_origin");
  scripts\engine\utility::waitframe();
  level.player playerlinktodelta(var_1, "tag_origin", 1.0, 30, 30, 30, 30, 0);
  level waittill("release_player");
  level.player unlink();
  level.player enableweapons();
  level.player freezecontrols(0);
  var_1 delete();
}

_id_F95A() {
  setsaveddvar("grapple_no_orient", "1");
  level._id_6163 = 1;
  _id_107BE();
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_F5AF("jumpto_emp_intro", [level.player, level._id_EA2C]);
  thread _id_8E91();
  thread _id_0F16::_id_E9FC("post_jackal_ally", "targetname", level.player);
  scripts\engine\utility::flag_set("jackals_past");
  scripts\engine\utility::flag_set("in_the_gap");
  thread _id_6162();
  thread _id_23F5();
  _id_0F35::_id_FAFC();
  thread _id_88AD();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_6160();
}

_id_615E() {
  thread _id_2F4F();

  if(isDefined(level._id_6163))
    scripts\engine\utility::flag_wait("made_it_across");

  scripts\engine\utility::flag_set("emp_intro_begin");
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132C0(1);
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132BF(1);
  thread _id_3AAD();
  thread _id_1136E();
  thread _id_6148();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_6161();
  thread _id_B517();
  thread _id_90C1();
  thread _id_88E3();
  scripts\sp\utility::_id_22C9("engine_guys", ::_id_88E6);
  scripts\sp\utility::_id_22CB("engine_guys", 1);
  scripts\engine\utility::flag_wait("emp_dropship_start_unload");
}

_id_2F4F() {
  scripts\engine\utility::flag_wait("gap_center");
  scripts\sp\utility::_id_10350("sa_empambush_brk_actualbravoison");
  wait 1;
  scripts\sp\utility::_id_1034D("sa_empambush_plr_copybrookssecur");
}

_id_1136E() {
  scripts\engine\utility::flag_wait("near_carrier");
  level.player thread _id_0F35::_id_D380();
  level.player thread _id_0F35::_id_D385();
}

_id_266D(var_0) {
  if(!scripts\engine\utility::flag("player_too_close_emp_enemies_alert"))
    scripts\sp\utility::_id_2669(var_0);
}

#using_animtree("script_model");

_id_6148() {
  var_0 = scripts\sp\vehicle::_id_1080D("emp_dropship");
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  var_0 scripts\sp\vehicle::_id_8441();
  var_0 thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_6149();
  thread _id_3ABF(var_0);
  level._id_5EC4 = var_0 gettagorigin("tag_connect");
  level._id_5EC3 = var_0 gettagangles("tag_connect");
  level._id_C6EA = scripts\engine\utility::spawn_tag_origin(level._id_5EC4, level._id_5EC3);
  level._id_C6EA linkTo(var_0, "tag_connect");
  scripts\engine\utility::flag_wait_all("emp_dropship_unload_ready", "emp_dropship_start_unload");
  _id_266D("engine_guys1");
  var_1 = [];
  var_2 = scripts\sp\utility::_id_10639("generic_prop");
  var_2._id_1FBB = "generic_prop";
  var_2 _meth_83D0(#animtree);
  var_2 linkTo(level._id_C6EA, "tag_origin");
  var_1[var_1.size] = var_2;
  level._id_614A = spawn("script_model", (0, 0, 0));
  level._id_614A setModel("ammo_crate_01_zerog");
  level._id_614A linkTo(var_2, "j_prop_1");
  level._id_614A.clip = getEnt("crate_1_clip", "targetname");
  level._id_614A.clip linkTo(level._id_614A, "ammo_crate_01_lod0_comb", (0, 0, 16), (0, 0, 0));
  level._id_614B = spawn("script_model", (0, 0, 0));
  level._id_614B setModel("ammo_crate_01_zerog");
  level._id_614B linkTo(var_2, "j_prop_2");
  level._id_614B.clip = getEnt("crate_2_clip", "targetname");
  level._id_614B.clip linkTo(level._id_614B, "ammo_crate_01_lod0_comb", (0, 0, 16), (0, 0, 0));
  scripts\sp\utility::_id_22CA("emp_dropship_enemies", ::_id_88DF);
  var_3 = scripts\sp\utility::_id_22CD("emp_dropship_enemies", 1);
  scripts\engine\utility::waitframe();

  foreach(var_5 in var_3)
  var_1[var_1.size] = var_5;

  level._id_C6EA thread scripts\sp\anim::_id_1F2C(var_1, "emp_dropship_unload");
  var_0 thread _id_0BBD::_id_5DB9("back");
  var_0 thread _id_0BBD::_id_5DB9("left");
  var_0 thread _id_0BBD::_id_5DB9("right");
  wait 2;
  level notify("emp_dropship_unloading");
  _id_266D("engine_guys2");
  level._id_5EC4 = var_0 gettagorigin("tag_connect");
  level._id_C6EA.origin = level._id_5EC4;
  level._id_C6EA unlink();
  wait 3;
  var_0 thread _id_0BBD::_id_5DB7("left");
  var_0 thread _id_0BBD::_id_5DB7("right");
  wait 1.3;
  var_0 thread _id_0BBD::_id_5DB7("back");
  wait 2;
  scripts\engine\utility::flag_set("emp_dropship_unload_complete");
  _id_266D("engine_guys3");
  var_2 waittillmatch("single anim", "end");

  if(isDefined(level._id_614A))
    level._id_614A unlink();

  if(isDefined(level._id_614B))
    level._id_614B unlink();

  if(isDefined(var_2))
    var_2 delete();
}

_id_88DF() {
  self endon("death");
  self endon(self.script_noteworthy + "_alert");
  level endon(self.script_noteworthy + "_alert");
  self endon(self._id_ECE7 + "_alert");
  level endon(self._id_ECE7 + "_alert");

  if(self._id_EEC9 == 10)
    self._id_1FBB = "dropship_enemy_1";

  if(self._id_EEC9 == 11)
    self._id_1FBB = "dropship_enemy_2";

  if(self._id_EEC9 == 12) {
    self._id_1FBB = "dropship_enemy_3";
    self._id_482E = level._id_614A;
  }

  if(self._id_EEC9 == 13) {
    self._id_1FBB = "dropship_enemy_4";
    self._id_482E = level._id_614B;
  }

  if(self.script_noteworthy == "emp_dropship_guys")
    thread _id_88E1();

  if(self.script_noteworthy == "emp_dropship_engine_guys")
    thread _id_88E0();

  self linkTo(level._id_C6EA, "tag_origin");
  scripts\engine\utility::flag_wait_all("emp_dropship_unload_ready", "emp_dropship_start_unload");
  wait 1;
  self.allowdeath = 1;
  wait 14;

  if(self._id_EEC9 == 10)
    self._id_482E = level._id_614A;

  if(self._id_EEC9 == 11)
    self._id_482E = level._id_614B;

  if(self._id_EEC9 == 12)
    self._id_482E = undefined;

  if(self._id_EEC9 == 13)
    self._id_482E = undefined;

  self waittillmatch("single anim", "end");
  var_0 = self._id_1FBB + "_done";
  self notify(var_0);

  if(self._id_EEC9 == 10) {
    self._id_482E thread _id_12BA9();
    self._id_482E = undefined;
  }

  if(self._id_EEC9 == 11) {
    self._id_482E thread _id_12BA9();
    self._id_482E = undefined;
  }

  self unlink();
  self notify("dropship_anim_done");

  if(self._id_EEC9 == 12 || self._id_EEC9 == 13) {
    if(!scripts\engine\utility::flag("emp_dropship_engine_guys_at_engines"))
      scripts\engine\utility::flag_set("emp_dropship_engine_guys_at_engines");
  }

  if(self.script_noteworthy == "emp_dropship_guys") {
    var_1 = getEnt("emp_dropship_guys_volume", "targetname");

    if(self._id_EEC9 == 10)
      var_1 = getEnt("emp_dropship_guys_top_volume", "targetname");

    self _meth_82F1(var_1);
  }
}

_id_12BA9() {
  self unlink();
  self._id_12BB3 = 1;
  thread _id_0F16::_id_6F40();
  level waittill("emp_planting");

  if(isDefined(self.clip))
    self.clip delete();

  if(isDefined(self))
    self delete();
}

_id_DC9F(var_0, var_1) {
  return (randomintrange(var_0, var_1), randomintrange(var_0, var_1), randomintrange(var_0, var_1));
}

_id_6162() {
  scripts\engine\utility::flag_wait("in_the_gap");
  thread _id_10A87();
  var_0 = scripts\sp\vehicle::_id_1080C("emp_intro_jackal");
  var_0 scripts\sp\vehicle::_id_8441();
  scripts\engine\utility::waitframe();
  var_0 _id_0BDC::_id_19AB(75);
  var_0 _id_0BDC::_id_19A0(1);
  var_1 = getcsplineid("emp_intro_jackal_spline");
  var_0 thread _id_0BDC::_id_A1EF(var_1);
  var_2 = scripts\engine\utility::getStructArray("spotlight_sweep_engines", "targetname");
  var_0 thread _id_0F0F::_id_E801(var_2);
  wait 0.5;
  var_0._id_10A5F _meth_82C9(3, "yaw");
  var_0._id_10A5F _meth_82C9(3, "pitch");
  var_0 waittill("emp_intro_jackal_adjust_speed");
  var_0 _id_0BDC::_id_19B0("fly");
  var_0 waittill("end_spline");
  var_0 _id_0BDC::_id_19AB(25);
  var_0 _id_0BDC::_id_A1F4("emp_intro_jackal_arrival_struct", 1, 32, 1);
  var_0 thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_A30E();
  scripts\engine\utility::flag_wait_either("emp_intro_jackal_fly_over", "send_emp_intro_jackal_away");
  thread _id_1394F([var_0], "spotlight_zone", "spotlight_jackal_passed", 2048, 0.96, 1024, 0.92, 1.0);
  var_0 _id_0BDC::_id_19A0(1);
  var_0 _meth_8555(0);
  var_1 = getcsplineid("emp_intro_jackal_fly_away_spline");
  var_0 thread _id_0BDC::_id_A1EF(var_1);
  var_0 _id_0BDC::_id_19AB(30);
  var_0 _id_0BDC::_id_19B0("hover");
  var_0._id_10A5F._id_1911 = spawn("script_origin", var_0._id_10A5F.origin + anglesToForward(var_0._id_10A5F.angles) * 2000);
  var_3 = var_0._id_10A5F._id_1911;
  var_0._id_10A5F._id_1911 linkTo(var_0._id_10A5F, "tag_origin");
  var_0._id_10A5F settargetentity(var_0._id_10A5F._id_1911);
  var_0._id_10A5F._id_12707 delete();
  level._id_A344 = 0.75;
  var_2 = scripts\engine\utility::getStructArray("spotlight_sweep_flyby", "targetname");
  var_0 thread _id_0F0F::_id_E81E(scripts\engine\utility::getclosest(var_0.origin, var_2));
  var_0 thread _id_895F();
  wait 0.5;
  var_0._id_10A5F _meth_82C9(3, "yaw");
  var_0._id_10A5F _meth_82C9(3, "pitch");
  var_0 waittill("emp_intro_jackal_adjust_speed");
  var_0 _id_0BDC::_id_19AB(50);
  wait 1;
  var_0 _id_0BDC::_id_19AB(70);
  wait 1;
  var_0 _id_0BDC::_id_19AB(200);
}

_id_895F() {
  level endon("death");
  self waittill("spotlight_moment_end");
  scripts\sp\utility::_id_2669("spotlight_moment_end");
  self._id_10A5F._id_1911 delete();
  scripts\engine\utility::flag_set("spotlight_jackal_passed");
}

_id_6139() {
  level._id_D7B9 = undefined;
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_616D();
}

_id_F959() {
  setsaveddvar("grapple_no_orient", "1");
  _id_107BE();
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_F5AF("jumpto_emp", [level.player, level._id_EA2C]);
  _id_0F35::_id_FAFC("hull_grap_vol", "none");
  level.player thread _id_0F35::_id_D385();
  thread _id_88AD();
  thread _id_8E91();
  scripts\engine\utility::flag_set("near_carrier");
  scripts\engine\utility::flag_set("emp_dropship_unload_ready");
  scripts\engine\utility::flag_set("emp_dropship_engine_guys_at_engines");
  scripts\engine\utility::flag_set("emp_dropship_start_unload");
  thread _id_B51A();
  thread _id_90C1();
  thread _id_B517();
  thread _id_88E3();
  thread _id_23F5();
  thread _id_3AAD();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_616E();
  scripts\sp\utility::_id_22C9("emp_dropship_guys", ::_id_88E1);
  scripts\sp\utility::_id_22C9("emp_dropship_engine_guys", ::_id_88E0);
  var_0 = scripts\sp\utility::_id_22CB("emp_dropship_guys", 1);
  var_1 = scripts\sp\utility::_id_22CB("emp_dropship_engine_guys", 1);
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = scripts\engine\utility::getStruct(var_4.script_parameters + "_struct_start", "targetname");
    var_4 _meth_80F1(var_5.origin, var_5.angles);
  }

  scripts\sp\utility::_id_22C9("engine_guys", ::_id_88E6);
  var_7 = scripts\sp\utility::_id_22CB("engine_guys", 1);
  scripts\engine\utility::waitframe();
  level notify("emp_dropship_unloading");
  level notify("emp_area_vo");
  scripts\engine\utility::flag_set("ready_to_shoot");
}

_id_88AD() {}

_id_F9A0() {
  _id_107BE();
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_F5AF("jumpto_deck_combat", [level.player, level._id_EA2C]);
  _id_0F35::_id_FAFC();
  level.player thread _id_0F35::_id_D385();
  _id_727B();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_91BB();
  scripts\engine\utility::flag_set("ret_called");
  level._id_EA2C scripts\sp\utility::_id_54F7();
  wait 0.1;
  level._id_EA2C scripts\sp\utility::_id_61C7();
}

_id_1137B(var_0, var_1) {
  _id_0F31::_id_E0CE();
  _id_0F31::_id_E0CD();

  if(isDefined(var_0)) {
    var_2 = getEntArray(var_0, "targetname");
    scripts\engine\utility::array_thread(var_2, _id_0F31::_id_13544, 1);
  }

  if(isDefined(var_1)) {
    var_2 = getEntArray(var_1, "targetname");
    scripts\engine\utility::array_thread(var_2, _id_0F31::_id_13544, 1);
  }
}

_id_9A78() {
  level._id_D7C4 = undefined;
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_9A75();
}

setup_intro_idles() {
  level._id_9A7A = 1;
  _id_727B();
  scripts\sp\utility::_id_F5AF("jumpto_zerog_int", [level.player]);
  _id_0F35::_id_FAFC();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_9A76();
  thread _id_9A79();
}

_id_F906() {
  var_0 = getEnt("big_bay_door_bottom", "targetname");

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 notsolid();
  }

  var_0 = getEnt("big_bay_door_top", "targetname");

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 notsolid();
  }

  var_1 = getEntArray("cargobay_doors_vista", "targetname");
  scripts\engine\utility::array_call(var_1, ::delete);
  level._id_3A87 = getEnt("cargobay_doors", "targetname");
  level._id_3A87 show();
  level._id_3A87._id_1FBB = "cargobay_doors";
  level._id_3A87 _meth_83D0(#animtree);
  level._id_3A87 scripts\sp\anim::_id_1EC3(level._id_3A87, "missile_hit1");
}

_id_FA13(var_0) {
  var_1 = scripts\sp\vehicle::_id_1080C("prototype_jackal");
  var_1 notsolid();
  var_1 _id_0BDC::_id_F48D("zero_g_enemy");
  var_1 thread _id_D168();
  var_1._id_13BF7 = _id_0BDD::_id_A1F8("primary_upgrade_2");
  var_1._id_13BF8 = _id_0BDD::_id_A1F8("secondary_default");
  var_1._id_1FBB = "jackal";
  var_2 = scripts\engine\utility::getStruct("jackal_scene", "targetname");

  if(var_0) {
    var_3 = getEntArray("jackal_crew", "targetname");
    thread scripts\sp\utility::_id_F3A3(var_3, "jackal_crew_dead");
    scripts\sp\utility::_id_22CA("jackal_crew", ::_id_5797);
    var_4 = getEnt("captain_stubing", "script_noteworthy");
    var_4 scripts\sp\utility::_id_1747(::_id_3A1B);
    var_5 = scripts\sp\utility::_id_22C6(var_3, 1);
    scripts\engine\utility::waitframe();
    var_5[0]._id_1FBB = "generic";
    var_5[1]._id_1FBB = "generic";
    var_5[0]._id_B3E9 = 1;
    var_5[1]._id_B3E9 = 1;
    level._id_A1FA = var_5;
    var_2 thread scripts\sp\anim::_id_1EC3(var_5[0], "hangar_scene1");
    var_2 thread scripts\sp\anim::_id_1EC3(var_5[1], "hangar_scene2");
    wait 0.5;
    var_2 thread scripts\sp\anim::_id_1EC3(var_1, "hangar_scene");
  }

  _id_0BDC::_id_CF50(0);
  return var_1;
}

_id_D168() {
  level.player waittill("flag_player_has_jackal");
  level.player waittill("flag_player_is_flying");
  scripts\engine\utility::waitframe();
  _id_0BD6::_id_621A();
}

_id_F940() {
  scripts\sp\utility::_id_F5AF("jumpto_dogfight", [level.player]);
  _id_0F35::_id_FAFC();
  _id_8949();
  _id_F906();
  level._id_DAA9 = _id_FA13(0);
  _id_727B();
  scripts\sp\utility::_id_241F(0);
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_5875();
  _id_1062A("ally_jackal1");
  _id_1062A("ally_jackal2");
}

_id_F9C0() {
  scripts\sp\utility::_id_12641("sa_emp_ret_land_tr");
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("show");
  level._id_FD6E._id_E35D show();
  var_0 = scripts\sp\vehicle::_id_1080C("landing_jackal");
  _id_0BDC::_id_10CD1(var_0);
}

_id_991F() {
  var_0 = getEnt("carrier_hull", "targetname");
  var_0 hide();
  var_1 = scripts\engine\utility::getStruct("vent_start_loc", "targetname");
  level.player setOrigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
}

_id_A124() {
  var_0 = scripts\engine\utility::getStruct("jackal_start_point", "targetname");
  level.player setOrigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
}

_id_13942() {
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("explode");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "damage");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "grapple_kill_anim_start");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_57D6();
  level notify(self.script_noteworthy + "_damaged");
}

_id_113D8() {}

_id_6480() {
  if(!isDefined(level._id_876E))
    level._id_876E = [];

  _id_113D8();
  var_0 = self.script_noteworthy;
  level._id_876E[self.script_noteworthy] = scripts\engine\utility::add_to_array(level._id_876E[self.script_noteworthy], self);
  thread _id_13942();
  level waittill(self.script_noteworthy + "_damaged");
  wait 1;

  if(!isalive(self)) {
    return;
  }
  self.ignoreall = 0;
  self waittill("death");
  level notify(var_0 + "_dead");
  level._id_876E[var_0] = scripts\sp\utility::array_removedeadvehicles(level._id_876E[var_0]);

  if(level._id_876E[var_0].size == 0)
    level notify("all_" + var_0 + "_dead");
}

_id_88E6() {
  self endon("death");

  if(!isDefined(level._id_876E))
    level._id_876E = [];

  self._id_C010 = 1;
  level._id_876E[self.script_noteworthy] = scripts\engine\utility::add_to_array(level._id_876E[self.script_noteworthy], self);
  level._id_876E[self._id_ECE7] = scripts\engine\utility::add_to_array(level._id_876E[self._id_ECE7], self);
  self.health = 1;
  scripts\engine\utility::delaythread(0.5, ::_id_13678);
  thread _id_135C0();
  thread _id_135BE();
  thread _id_65A6();
  level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self._id_ECE7 + "_alert");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self._id_ECE7 + "_alert");
  level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self.script_noteworthy + "_alert");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self.script_noteworthy + "_alert");
  scripts\sp\utility::_id_57D6();
  wait 0.5;

  if(!scripts\engine\utility::flag("emp_dropship_engine_guys_at_engines"))
    level notify(self.script_noteworthy + "_alert");

  if(isDefined(self._id_4BC2))
    self._id_4BC2 notify("stop_loop");

  _id_11057(self);

  if(isDefined(self._id_13CF3))
    self._id_13CF3 delete();

  if(isDefined(self._id_13CF4))
    self._id_13CF4 delete();

  scripts\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::waitframe();
  thread _id_F22A();
  thread _id_3AA9();
}

_id_88E1() {
  self endon("death");

  if(!isDefined(level._id_876E))
    level._id_876E = [];

  level._id_876E[self.script_noteworthy] = scripts\engine\utility::add_to_array(level._id_876E[self.script_noteworthy], self);
  level._id_876E[self._id_ECE7] = scripts\engine\utility::add_to_array(level._id_876E[self._id_ECE7], self);
  level waittill("emp_dropship_unloading");
  self.health = 1;
  _id_113D8();

  if(!scripts\engine\utility::flag("player_too_close_emp_enemies_alert")) {
    scripts\engine\utility::delaythread(0.5, ::_id_13678);
    thread _id_135C0();
    thread _id_135BE();
    var_0 = getEnt("emp_dropship_guys_volume", "targetname");

    if(self._id_EEC9 == 10)
      var_0 = getEnt("emp_dropship_guys_top_volume", "targetname");

    self _meth_82F1(var_0);
    level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self._id_ECE7 + "_alert");
    scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self._id_ECE7 + "_alert");
    level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self.script_noteworthy + "_alert");
    scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self.script_noteworthy + "_alert");
    scripts\sp\utility::_id_57D6();
  } else
    wait 5;

  wait 0.5;

  if(isDefined(self._id_482E) && !isDefined(self._id_482E._id_12BB3))
    self._id_482E thread _id_12BA9();

  self unlink();
  scripts\sp\utility::anim_stopanimScripted();
  self.ignoreall = 0;
  level notify("emp_dropship_guys_alert");
  level notify("engine_guys_alert");
  level notify("emp_dropship_engine_guys_alert");
  var_0 = getEnt("emp_dropship_guys_alert_volume", "targetname");
  self _meth_82F1(var_0);
}

_id_88E0() {
  self endon("death");

  if(!isDefined(level._id_876E))
    level._id_876E = [];

  self._id_C010 = 1;
  level._id_876E[self.script_noteworthy] = scripts\engine\utility::add_to_array(level._id_876E[self.script_noteworthy], self);
  level._id_876E[self._id_ECE7] = scripts\engine\utility::add_to_array(level._id_876E[self._id_ECE7], self);
  level waittill("emp_dropship_unloading");
  self.health = 1;
  _id_113D8();

  if(!scripts\engine\utility::flag("player_too_close_emp_enemies_alert")) {
    scripts\engine\utility::delaythread(0.5, ::_id_13678);
    thread _id_135C0();
    thread _id_135BE();
    thread _id_65A6();
    level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self._id_ECE7 + "_alert");
    scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self._id_ECE7 + "_alert");
    level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self.script_noteworthy + "_alert");
    scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, self.script_noteworthy + "_alert");
    scripts\sp\utility::_id_57D6();
  } else
    wait 5;

  wait 0.5;

  if(!scripts\engine\utility::flag("emp_dropship_engine_guys_at_engines"))
    level notify(self.script_noteworthy + "_alert");

  if(isDefined(self._id_4BC2))
    self._id_4BC2 notify("stop_loop");

  _id_11057(self);

  if(isDefined(self._id_13CF3))
    self._id_13CF3 delete();

  if(isDefined(self._id_13CF4))
    self._id_13CF4 delete();

  self unlink();
  scripts\sp\utility::anim_stopanimScripted();

  if(isDefined(self._id_482E) && !isDefined(self._id_482E._id_12BB3))
    self._id_482E thread _id_12BA9();

  scripts\engine\utility::waitframe();
  thread _id_F22A();
  thread _id_3AA9();
}

_id_65A6() {
  self endon("death");
  level endon(self.script_noteworthy + "_alert");
  self endon(self.script_noteworthy + "_alert");
  level endon(self._id_ECE7 + "_alert");
  self endon(self._id_ECE7 + "_alert");

  if(isDefined(self._id_1FBB) && (self._id_1FBB == "dropship_enemy_3" || self._id_1FBB == "dropship_enemy_4")) {
    var_0 = self._id_1FBB + "_done";
    self waittill(var_0);
  }

  var_1 = self.script_parameters + "_struct";
  self.fixednode = 1;
  self._id_1FBB = "generic";
  self.allowdeath = 1;
  self._id_13CF4 = spawn("script_model", (0, 0, 0));
  self._id_13CF4 setModel("equipment_welding_torch_01");
  self._id_13CF4 hide();
  self._id_13CF4 linkTo(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  self._id_13CF5 = 1;
  self._id_13CF3 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_sync"), self gettagangles("tag_sync"));
  self._id_13CF3 linkTo(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  var_2 = scripts\engine\utility::getStruct(self.script_parameters + "_struct_start", "targetname");
  self._id_4BC2 = var_2;
  self.goalradius = 16;
  var_3 = [];
  var_3[0] = "engine_welding1";
  var_3[1] = "engine_welding2";
  var_3[2] = "engine_welding3";
  var_4 = scripts\engine\utility::random(var_3);
  var_2 scripts\sp\anim::_id_1F17(self, var_4);
  wait 0.05;
  var_5 = getstartangles(var_2.origin, var_2.angles, scripts\sp\utility::_id_7DC1(var_4));
  self orientmode("face angle 3d", var_5);
  wait 1;
  _id_65B8(var_2, var_4);

  if(!scripts\engine\utility::flag("emp_dropship_start_unload")) {
    while(!scripts\engine\utility::flag("emp_dropship_start_unload")) {
      var_4 = scripts\engine\utility::random(var_3);
      var_2 scripts\sp\anim::_id_1F17(self, var_4);
      wait 0.05;
      var_5 = getstartangles(var_2.origin, var_2.angles, scripts\sp\utility::_id_7DC1(var_4));
      self orientmode("face angle 3d", var_5);
      wait 1;
      _id_65B8(var_2, var_4);
    }
  }

  var_6 = -1;

  for(;;) {
    var_7 = scripts\engine\utility::getStructArray(var_1, "targetname");
    var_8 = randomint(var_7.size);

    if(var_8 == var_6) {
      var_8++;

      if(var_8 >= var_7.size)
        var_8 = 0;
    }

    var_9 = var_7[var_8];
    self._id_4BC2 = var_9;
    self.goalradius = 16;
    var_4 = scripts\engine\utility::random(var_3);
    var_9 scripts\sp\anim::_id_1F17(self, var_4);
    wait 0.05;
    var_5 = getstartangles(var_9.origin, var_9.angles, scripts\sp\utility::_id_7DC1(var_4));
    self orientmode("face angle 3d", var_5);
    wait 1;
    _id_65B8(var_9, var_4);
    var_6 = var_8;
  }
}

_id_65B8(var_0, var_1) {
  var_0 thread scripts\sp\anim::_id_1F35(self, var_1);
  self waittillmatch("single anim", "end");
  _id_11057(self);
}

_id_13678() {
  self endon("death");
  level endon(self.script_noteworthy + "_alert");
  self endon(self.script_noteworthy + "_alert");
  level endon(self._id_ECE7 + "_alert");
  self endon(self._id_ECE7 + "_alert");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("explode");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "damage");
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "player_too_close_emp_enemies_alert");
  scripts\sp\utility::_id_57D6();

  if(!scripts\engine\utility::flag("emp_dropship_engine_guys_at_engines"))
    self notify(self.script_noteworthy + "_alert");
  else
    self notify(self._id_ECE7 + "_alert");
}

_id_11718(var_0) {
  level waittill(var_0);
}

_id_135C0() {
  self waittill("death", var_0);

  if(isDefined(var_0) && var_0 == level.player)
    level notify("engine_guy_dead");

  if(!isDefined(self)) {
    return;
  }
  _id_11057(self);

  if(isDefined(self._id_13CF3))
    self._id_13CF3 delete();

  if(isDefined(self._id_13CF4))
    self._id_13CF4 delete();

  var_1 = self.script_noteworthy;
  var_2 = self._id_ECE7;

  if(self.script_noteworthy == "emp_dropship_guys") {
    if(isDefined(self._id_482E) && !isDefined(self._id_482E._id_12BB3))
      self._id_482E thread _id_12BA9();

    wait 2.0;

    if(!scripts\engine\utility::flag("emp_dropship_guys_dead"))
      level notify(var_1 + "_alert");
  } else if(self.script_noteworthy == "emp_dropship_engine_guys") {
    if(isDefined(self._id_482E) && !isDefined(self._id_482E._id_12BB3))
      self._id_482E thread _id_12BA9();

    if(!scripts\engine\utility::flag("emp_dropship_engine_guys_at_engines")) {
      wait 2.0;

      if(!scripts\engine\utility::flag("emp_dropship_engine_guys_dead"))
        level notify(var_1 + "_alert");
    } else {
      wait 2.0;

      if(!scripts\engine\utility::flag("emp_dropship_engine_guys_dead"))
        level notify(var_2 + "_alert");
    }
  } else if(self.script_noteworthy == "engine_guys") {
    if(!scripts\engine\utility::flag("emp_dropship_engine_guys_at_engines")) {
      return;
    }
    wait 2.0;

    if(!scripts\engine\utility::flag("engine_guys_dead"))
      level notify(var_2 + "_alert");
    else {}
  }
}

_id_135BE() {
  level endon(self.script_noteworthy + "_alert");
  level endon(self._id_ECE7 + "_alert");
  self waittill("damage");

  if(!scripts\engine\utility::flag("emp_dropship_start_unload")) {
    return;
  }
  if(!scripts\engine\utility::flag("emp_dropship_engine_guys_at_engines"))
    var_0 = self.script_noteworthy;
  else
    var_0 = self._id_ECE7;

  level._id_876E[var_0] = scripts\sp\utility::_id_22B9(level._id_876E[var_0]);

  if(level._id_876E[var_0].size == 0) {
    return;
  }
  var_1 = undefined;

  if(level._id_876E[var_0].size > 1) {
    foreach(var_3 in level._id_876E[var_0]) {
      if(var_3 != self)
        var_1 = var_3;
    }

    if(isDefined(var_1) && isalive(var_1)) {
      var_5 = level._id_EA2C gettagorigin("j_head");
      var_6 = var_1 gettagorigin("j_head");
      var_7 = vectorNormalize(var_6 - var_5);
      var_8 = var_5 + var_7 * (distance(var_6, var_5) - 10);
      var_1.health = 1;
      magicbullet(level._id_EA2C.weapon, var_8, var_6);
      wait 0.1;
    }
  } else
    wait 1;

  while(level._id_876E[var_0].size > 0) {
    var_9 = randomint(level._id_876E[var_0].size);
    var_10 = level._id_876E[var_0][var_9];

    while(isDefined(var_10) && isalive(var_10)) {
      var_5 = level._id_EA2C gettagorigin("j_head");
      var_6 = var_10 gettagorigin("j_head");
      var_7 = vectorNormalize(var_6 - var_5);
      var_8 = var_5 + var_7 * (distance(var_6, var_5) - 10);
      var_10.health = 1;
      magicbullet(level._id_EA2C.weapon, var_8, var_6);
      wait 0.1;
    }

    level._id_876E[var_0] = scripts\sp\utility::_id_22B9(level._id_876E[var_0]);
  }
}

_id_F22A() {
  self endon("death");
  var_0 = getEnt("engine_guys_delete_volume", "targetname");
  self.goalradius = 16;
  self _meth_82F1(var_0);
  self waittill("goal");

  if(scripts\sp\utility::_id_D1DF(self.origin)) {
    scripts\engine\utility::flag_set("emp_dropship_engine_guys_dead");
    scripts\engine\utility::flag_set("engine_guys_dead");
    var_1 = scripts\engine\utility::getStruct("delete_me_struct", "targetname");
    self setgoalpos(var_1.origin);
    scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "goal");
    scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "emp_set");
    scripts\sp\utility::_id_57D6();
  }

  self delete();
}

_id_3AA9() {
  self endon("death");
  level endon("emp_dropship_guys_alert");
  var_0 = getEnt("carrier_deck_trigger", "targetname");

  for(;;) {
    if(self istouching(var_0))
      level notify("emp_dropship_guys_alert");

    wait 0.1;
  }
}

_id_23F6() {
  thread emp_startmusic();
  wait 0.1;
  scripts\sp\utility::_id_10350("sa_empambush_brk_11thisisbravowe");
  level notify("fade_in");
  wait 1;
  wait 4;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_eyespeeledtakei");
  wait 1;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_copyonme");
  scripts\engine\utility::flag_wait("dropship1");
  wait 3;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_enemytransporta");
  scripts\engine\utility::flag_wait_or_timeout("stay_in_cover", 5);
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_usecoverkeepmov");
  scripts\engine\utility::flag_wait_or_timeout("hold_up", 5);
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_standfastletsse");
  level waittill("dropship1_unloading");
  thread _id_10E64();
  level endon("hot_spot");
  level endon("guys1_dead");
  wait 3;
  level._id_EA2C _id_13EC0(0, 1);
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_eyesontwoscouts");
  wait 1;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_copyletthetrans");
  wait 3;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_takeyourpickill");
}

emp_startmusic() {
  wait 5;
  setmusicstate("mx_243_emp_levelstart");
}

_id_10E64() {
  level scripts\engine\utility::waittill_any("hot_spot", "guys1_dead");

  if(!scripts\engine\utility::flag("guys1_dead")) {
    level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_theyseeyou");
    wait 2;
    scripts\engine\utility::flag_wait("guys1_dead");
    level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_carefulreyeskee");
    wait 1;
  }

  wait 1;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_letsgo");
  level._id_EA2C _id_13EC0(1, 1);
  scripts\engine\utility::delaythread(1, _id_0F16::_id_E9FC, "move_to_crossing", "targetname", level.player);
}

_id_4F2B(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 waittill("trigger", var_2);
  iprintlnbold(var_2.name);
}

_id_A2A4() {
  level.player endon("death");
  scripts\engine\utility::trigger_on("jackals_past", "targetname");
  wait 3;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_enemiesinboundl");
  wait 1;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_grabcover");
  scripts\engine\utility::flag_wait("jackals_past");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_clearletsgo");
  _id_0F16::_id_E9FC("post_jackal_ally", "targetname", level.player);
}

_id_10A87() {
  scripts\engine\utility::flag_wait_either("emp_intro_jackal_fly_over", "send_emp_intro_jackal_away");
  wait 3;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_incomingsearchl");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_staylow");
  scripts\engine\utility::flag_wait("spotlight_jackal_passed");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_cleartomove");
}

_id_3ABF(var_0) {
  var_1 = getEnt("emp_dropship_vo_trigger", "targetname");

  for(;;) {
    var_1 waittill("trigger");

    if(var_0 istouching(var_1)) {
      break;
    }
  }

  scripts\engine\utility::flag_wait("emp_dropship_start_unload");
  level._id_EA2C _id_13EC0(0, 1);
  wait 2;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_dropship");
  wait 3;
  level notify("emp_area_vo");
  scripts\engine\utility::flag_wait("emp_dropship_start_unload");
}

_id_B51A() {
  level endon("engine_guy_dead");
  level endon("jackal_spotted");
  level.player endon("death");
  level waittill("emp_area_vo");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_goteyesontheobj");
  wait 2;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_gotmaintenancec");
  wait 1.5;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_iseeem");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_repairdivision2");
  scripts\engine\utility::flag_set("ready_to_shoot");
  wait 2;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_wecantakeemoutf");
  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_yourcallreyes");
}

_id_90C1() {
  level endon("emp_ready_to_set");
  level waittill("emp_dropship_unloading");
  level scripts\engine\utility::waittill_any("player_too_close_emp_enemies_alert", "emp_dropship_guys_alert");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_goinghot");
}

_id_B517() {
  level endon("emp_ready_to_set");
  level endon("player_too_close_emp_enemies_alert");
  var_0 = ["sa_empambush_slt_niceshot", "sa_empambush_slt_goodbrass", "sa_empambush_slt_cleanshot", "sa_empambush_slt_bangsmokedhim"];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level waittill("engine_guy_dead");
    wait 1;
    level._id_EA2C scripts\sp\utility::_id_10346(var_0[var_1]);
    wait 5;
  }
}

_id_23F5() {
  if(isDefined(level._id_6192))
    level waittill("release_player");

  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(level._id_EA2C, "tag_eye", (0, 0, 20), (0, 0, 0));
  objective_add(scripts\sp\utility::_id_C264("obj_follow_salter"), "current", &"SA_EMPAMBUSH_APPROACH_THE_SDF_CARRIER", var_0.origin);
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("obj_follow_salter"), &"SA_EMPAMBUSH_SUPPORT");
  objective_onentity(scripts\sp\utility::_id_C264("obj_follow_salter"), var_0);
  thread _id_0F16::_id_C278(scripts\sp\utility::_id_C264("obj_follow_salter"));
  scripts\engine\utility::flag_wait("emp_ready_to_set");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_follow_salter"));

  if(isDefined(var_0))
    var_0 delete();

  var_1 = scripts\engine\utility::getStruct("emp_obj2", "targetname");
  objective_add(scripts\sp\utility::_id_C264("emp_carrier"), "current", &"SA_EMPAMBUSH_PLACE_EMP_CHARGE_ON_THE");
  objective_add(scripts\sp\utility::_id_C264("emp_carrier_obj"), "current");
  objective_position(scripts\sp\utility::_id_C264("emp_carrier_obj"), var_1.origin);
  scripts\engine\utility::flag_wait("player_near_emp_plant");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("emp_carrier_obj"));
  scripts\engine\utility::flag_wait("emp_set");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("emp_carrier"));
}

waittill_notify(var_0, var_1) {
  level waittill(var_0);
  scripts\engine\utility::flag_set(var_1);
}

_id_23F3() {
  setsaveddvar("grapple_no_orient", "1");
  scripts\engine\utility::flag_set("asteroid_infil_begin");
  thread _id_8E91();
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132C0(1);
  thread scripts\sp\hud_util::_id_6AA3(0.0);
  level.player freezecontrols(1);
  scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_12643, ["sa_empambush_prime_slowhdd_tr"]);

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F3FF(1);
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  scripts\engine\utility::delaythread(0.3, scripts\sp\utility::_id_12643, ["sa_empambush_prime_tr"]);
  var_0 = getEnt("asteroid_up_ref", "targetname");
  var_1 = anglestoup(var_0.angles);
  level.player thread _id_0F35::_id_D385(var_1, 5.0);
  scripts\engine\utility::trigger_off("jackals_past", "targetname");
  level._id_EA2C._id_B3E9 = 1;
  level._id_EA2C _id_13EC0(1, 1);
  level._id_876E = [];
  thread _id_23F6();
  thread _id_23F5();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_13EB9();
  level waittill("fade_in");
  thread _id_EA98();
  level.player scripts\engine\utility::delaycall(1.5, ::freezecontrols, 0);
  thread scripts\sp\hud_util::_id_6A99(1.5);
  scripts\engine\utility::flag_wait("dropship1");

  while(!istransientloaded("sa_empambush_prime_slowhdd_tr") || !istransientloaded("sa_empambush_prime_tr")) {
    wait 0.05;
    waitforalltransients();
  }

  scripts\sp\utility::_id_22C9("dropship1_guys", ::_id_6480);
  var_2 = scripts\sp\vehicle::_id_1080D("zerog_dropship1");
  var_2.ignoreme = 1;
  var_2.ignoreall = 1;
  var_2 scripts\sp\vehicle::_id_8441();
  var_2 thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_13EA5();
  thread _id_88F2();
  thread _id_88F3();
  thread waittill_notify("all_dropship1_guys_dead", "guys1_dead");
  var_2 waittill("unloading");
  level notify("dropship1_unloading");
  var_3 = 1;

  foreach(var_5 in level._id_876E["dropship1_guys"]) {
    var_5 _id_113D8();
    var_5.health = 1;
    var_6 = getnode("zgps" + var_3, "targetname");
    var_5 scripts\engine\utility::delaycall(8, ::_meth_82EE, var_6);
    var_3++;
  }

  level scripts\engine\utility::waittill_any("dropship1_guys_damaged", "got_spotted");

  foreach(var_5 in level._id_876E["dropship1_guys"]) {
    if(scripts\engine\utility::is_true(var_5._id_84AF))
      level.player waittill("kill_release", var_9);
  }

  wait 1;

  if(isalive(level._id_876E["dropship1_guys"][0])) {
    var_11 = undefined;

    if(level._id_876E["dropship1_guys"].size > 1)
      var_11 = level._id_876E["dropship1_guys"][1];

    _id_EAAC(level._id_876E["dropship1_guys"][0]);

    if(isDefined(var_11) && isalive(var_11)) {
      wait 1;
      _id_EAAC(var_11);
    }
  }

  if(isDefined(level._id_876E["dropship1_guys"][1]) && isalive(level._id_876E["dropship1_guys"][1]))
    _id_EAAC(level._id_876E["dropship1_guys"][1]);

  scripts\engine\utility::flag_set("guys1_dead");
  scripts\sp\utility::_id_2669("1st_patrol");
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_BC8D();
  scripts\engine\utility::flag_wait("about_to_cross");
  var_12 = [];
  var_12[0] = _id_A2A2("jackal_patrol1");
  var_12[1] = _id_A2A2("jackal_patrol2");
  thread _id_1394F(var_12, "in_the_gap", "jackals_past");
  scripts\sp\utility::_id_2669("crossing");
  thread _id_A2A4();
  thread _id_6162();
  scripts\engine\utility::flag_wait("made_it_across");
  scripts\sp\utility::_id_2669("crossed");
}

_id_EAAC(var_0) {
  if(scripts\engine\utility::is_true(var_0._id_84AF)) {
    return;
  }
  var_1 = level._id_EA2C gettagorigin("tag_flash");
  var_2 = var_0 gettagorigin("j_head");
  var_0.health = 1;
  level._id_EA2C shoot(1, var_2, 0, 0, 0);
  scripts\engine\utility::waitframe();

  if(isalive(var_0)) {
    if(scripts\engine\utility::is_true(var_0._id_B14F))
      var_0 scripts\sp\utility::_id_1101B();

    var_0 _meth_81D0(level._id_EA2C.origin, level._id_EA2C);
  }
}

_id_13EC0(var_0, var_1) {
  if(var_0) {
    scripts\sp\utility::_id_51E1("casual");

    if(var_1)
      thread _id_0F35::_id_EBB0(0.75, 2);
  } else {
    scripts\sp\utility::_id_4145();

    if(var_1)
      thread _id_0F35::_id_EBB0(1.0, 2);
  }
}

_id_EA98() {
  var_0 = scripts\engine\utility::getStruct("intro_anim_struct", "targetname");
  var_0 scripts\sp\anim::_id_1EC3(level._id_EA2C, "salter_intro");
  var_0 scripts\sp\anim::_id_1F37(level._id_EA2C, "salter_intro");
  level notify("release_player");
  var_0 scripts\sp\anim::_id_1F17(level._id_EA2C, "salter_asteroid_hop");
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "salter_asteroid_hop");
  level._id_EA2C scripts\sp\utility::_id_61C7();
}

_id_88F3() {
  level waittill("dropship1_unloading");
  wait 2;
  objective_add(scripts\sp\utility::_id_C264("obj_snipe"), "current", &"SA_EMPAMBUSH_KILL_THE_SDF_PATROL");
  scripts\engine\utility::flag_wait_or_timeout("guys1_dead", 15);

  if(!scripts\engine\utility::flag("guys1_dead")) {
    objective_state_nomessage(scripts\sp\utility::_id_C264("obj_follow_salter"), "invisible");
    objective_setpointertextoverride(scripts\sp\utility::_id_C264("obj_snipe"), &"SA_EMPAMBUSH_KILL");
    objective_onentity(scripts\sp\utility::_id_C264("obj_snipe"), level._id_876E["dropship1_guys"][0]);
    objective_additionalentity(scripts\sp\utility::_id_C264("obj_snipe"), 1, level._id_876E["dropship1_guys"][1]);
    scripts\engine\utility::flag_wait("guys1_dead");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_snipe"));
    objective_state_nomessage(scripts\sp\utility::_id_C264("obj_follow_salter"), "active");
    objective_state_nomessage(scripts\sp\utility::_id_C264("obj_follow_salter"), "current");
  } else
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_snipe"));
}

_id_88F2() {
  level endon("guys1_dead");
  level waittill("dropship1_unloading");
  scripts\engine\utility::flag_wait_any("hot_spot", "in_the_gap");
  level notify("hot_spot");

  foreach(var_1 in level._id_876E["dropship1_guys"])
  var_1.ignoreall = 0;

  wait 5;
  level notify("got_spotted");
}

_id_8957() {
  level._id_EA2C._id_B3E9 = 1;
  level._id_EA2C.fixednode = 1;
  thread _id_EA5E();
  scripts\engine\utility::flag_wait("emp_ready_to_set");
  var_0 = getnode("salter_emp_plant_node", "targetname");
  level._id_EA2C _meth_82EE(var_0);
  scripts\engine\utility::flag_wait("emp_set");

  if(isDefined(level._id_EA2C._id_10DB1) && level._id_EA2C.primaryweapon != level._id_EA2C._id_10DB1)
    level._id_EA2C scripts\sp\utility::_id_72EC(level._id_EA2C._id_10DB1, "primary");

  level._id_EA2C waittillmatch("single anim", "end");
  level._id_EA2C setgoalpos(level._id_EA2C.origin);
  scripts\engine\utility::flag_wait("emp_done");
  level._id_EA2C.fixednode = 0;
}

_id_EA5E() {
  level scripts\engine\utility::waittill_any("engine_guys_alert", "emp_dropship_engine_guys_alert", "emp_dropship_guys_alert");
  level._id_EA2C.ignoreall = 0;
  level._id_EA2C.ignoreme = 0;
}

_id_88E2() {
  thread _id_0F16::_id_6E41(level._id_876E["engine_guys"], level._id_876E["engine_guys"].size, "engine_guys_dead");
  scripts\engine\utility::flag_wait("near_carrier");
  level._id_876E["engine_guys"] = scripts\sp\utility::_id_22B9(level._id_876E["engine_guys"]);

  foreach(var_1 in level._id_876E["engine_guys"])
  var_1 _id_113D8();

  scripts\engine\utility::flag_wait("emp_dropship_unload_ready");
  wait 0.1;
  thread _id_0F16::_id_6E41(level._id_876E["emp_dropship_guys"], level._id_876E["emp_dropship_guys"].size, "emp_dropship_guys_dead");
  thread _id_0F16::_id_6E41(level._id_876E["emp_dropship_engine_guys"], level._id_876E["emp_dropship_engine_guys"].size, "emp_dropship_engine_guys_dead");
  scripts\engine\utility::flag_wait_all("engine_guys_dead", "emp_dropship_guys_dead", "emp_dropship_engine_guys_dead");
  wait 1;
  scripts\engine\utility::flag_set("emp_ready_to_set");
  _id_266D("emp_ready_to_set");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_enginesareclear");
  wait 2;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_bravohowcopy");
  wait 2;
  scripts\sp\utility::_id_10350("sa_empambush_brk_solidgoodtogohe");
  wait 2;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_brookskashletss");
  thread _id_6173();
  wait 2;
  scripts\sp\utility::_id_10350("sa_empambush_ksh_rogerplantingem");
}

_id_6173() {
  level endon("emp_set");
  wait 20;

  if(!scripts\engine\utility::flag("emp_set"))
    level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_letssettheseemp");
}

_id_A2A2(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_2 = var_0 + "_loop";
  var_3 = var_1 scripts\sp\utility::_id_10808();
  var_3 thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_C989(var_0);
  var_3 _id_0BDC::_id_19A0(1);
  var_3 thread _id_0BDC::_id_A1EF(scripts\sp\utility::_id_7C9A(var_2));
  var_3 thread _id_513C();
  return var_3;
}

_id_513C() {
  wait 1;
  self waittill("end_spline");
  self delete();
}

_id_1394F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.player endon("death");
  scripts\engine\utility::array_thread(var_0, ::_id_A240, var_2);

  if(!isDefined(var_7))
    var_7 = 0.5;

  if(!isDefined(var_3))
    var_3 = 10000;

  var_3 = var_3 * var_3;

  if(!isDefined(var_4))
    var_4 = 0.17;

  if(isDefined(var_5))
    var_5 = var_5 * var_5;

  while(!scripts\engine\utility::flag(var_2)) {
    if(scripts\engine\utility::flag(var_1) && !scripts\engine\utility::flag("hiding")) {
      foreach(var_9 in var_0) {
        var_10 = undefined;
        var_11 = distancesquared(level.player.origin, var_9.origin);
        var_12 = 0;

        if(isDefined(var_5) && isDefined(var_6) && !isDefined(var_9._id_2524) && var_11 < var_5) {
          var_13 = scripts\sp\utility::_id_7951(var_9.origin, var_9.angles, level.player.origin);

          if(var_13 > var_6)
            var_12 = 1;
        } else if(!isDefined(var_9._id_2524) && var_11 < var_3) {
          var_13 = scripts\sp\utility::_id_7951(var_9.origin, var_9.angles, level.player.origin);

          if(var_13 > var_4)
            var_12 = 1;
        }

        if(var_12)
          var_10 = scripts\common\trace::ray_trace(var_9 gettagorigin("tag_spotlight"), level.player.origin + (0, 0, 32), var_9);

        if(isDefined(var_10) && isDefined(var_10["entity"]) && var_10["entity"] == level.player) {
          var_9 _id_A345(var_7);
          return;
        }
      }
    }

    wait 0.05;
  }
}

_id_A345(var_0) {
  if(!isDefined(level._id_A346)) {
    level notify("jackal_spotted");
    level._id_EA2C thread scripts\sp\utility::_id_10346("sa_empambush_slt_theyvespottedyo");
    level._id_A346 = 1;
  }

  _id_0BDC::_id_A0B3(1);
  thread _id_0BDC::_id_1984(level.player);
  self._id_2524 = 1;
  wait(var_0);
  level.player _meth_80A1();
  level.player scripts\sp\utility::_id_54C6();
}

_id_A240(var_0) {
  while(!scripts\engine\utility::flag(var_0)) {
    self waittill("damage", var_1, var_2);

    if(var_2 == level.player && !scripts\engine\utility::flag(var_0))
      _id_A345(0.5);
  }
}

_id_612D() {
  scripts\engine\utility::flag_set("emp_begin");
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132C0(1);
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132BF(1);
  var_0 = getEntArray("engine_grapple_vol", "targetname");
  scripts\engine\utility::array_thread(var_0, _id_0F31::_id_13544, 1);
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_616F();
  wait 0.5;
  thread _id_8957();
  thread _id_88E2();
  thread _id_B51A();
  scripts\engine\utility::flag_wait_any("ready_to_shoot", "emp_ready_to_set");

  if(!scripts\engine\utility::flag("emp_ready_to_set")) {
    wait 4;
    objective_add(scripts\sp\utility::_id_C264("obj_kill_mechanics"), "current", &"SA_EMPAMBUSH_KILL_THE_SDF_ENGINE_TECHS");
    scripts\engine\utility::flag_wait("emp_ready_to_set");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_kill_mechanics"));
  }

  scripts\engine\utility::flag_wait("player_near_emp_plant");
  var_1 = scripts\engine\utility::getStruct("emp_plant_obj2", "targetname");
  var_1 _id_0E46::_id_48C4("tag_origin", undefined, &"SA_EMPAMBUSH_PLANT_EMP", undefined, 10000, 200, 1);
  var_1 waittill("trigger");
  var_1 _id_0E46::_id_DFE3();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_6143();
  setmusicstate("");
  level notify("emp_planting");
  thread _id_6168();
  clearallcorpses();
  thread plant_set_stage_directional();
  level notify("emp_set");
  scripts\engine\utility::flag_set("emp_set");
  var_2 = getEntArray("wonky_dropship", "script_noteworthy");
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(var_5.classname == "script_model") {
      var_3 = var_5;
      break;
    }
  }

  var_3 thread _id_6F3E();
  wait 6;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_chargesetwhatsy");
  wait 2;
  scripts\sp\utility::_id_10350("sa_empambush_ksh_placingnowsir");
  wait 1;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_12issetraider");
  wait 3;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_copyallteamssta");
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_613A((11450, 2240, 500), "r");
  wait 1;
  level notify("emp_detonate");
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_fireinthehole");
  wait 1;
  scripts\sp\utility::_id_10350("sa_empambush_brk_goodeffectpower");
  wait 1;
  scripts\engine\utility::flag_wait("emp_done");
  level._id_EA2C._id_B3E9 = 0;
  level._id_EA2C scripts\sp\utility::_id_4145();
  thread _id_0F35::_id_EBB0(0.75, 5);
  level._id_EA2C thread scripts\sp\utility::_id_10346("sa_empambush_slt_letsmove3mikeso");
}

_id_6168() {
  var_0 = 2000;
  var_1 = scripts\engine\utility::getStruct("emp_plant_obj2", "targetname");
  level waittill("l_engine_3_off");
  wait 0.25;
  var_2 = distance2d(level.player.origin, var_1.origin);

  if(var_2 <= var_0) {
    var_3 = scripts\engine\utility::getStruct("post_emp_salter_teleport", "targetname");
    var_4 = vectorNormalize(var_3.origin - level.player.origin);
    var_5 = 1000 / var_2 * 1200;
    level.player setvelocity(var_4 * var_5);
  }
}

_id_3738() {
  wait 3;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_retributionthis");
  wait 0.5;
  scripts\sp\utility::_id_10350("sa_empambush_gtr_rogerthat");
  scripts\sp\utility::_id_10350("sa_empambush_gtr_inboundtoyoursect");
  scripts\engine\utility::flag_set("ret_called");
}

plant_set_stage_directional() {
  thread _id_D6CE();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  level.player disableweapons();
  level.player _meth_84FE();
  var_0 = scripts\sp\utility::_id_10639("player_rig", (0, 0, 0), (0, 0, 0));
  var_0 hide();
  level._id_D042 = scripts\sp\utility::_id_10639("player_emp", (0, 0, 0), (0, 0, 0));
  level._id_D042 hide();
  level._id_D042 thread scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_1334B();
  level._id_EA5C = scripts\sp\utility::_id_10639("salter_emp", (0, 0, 0), (0, 0, 0));
  level._id_EA5C hide();
  level._id_D26E = scripts\sp\utility::_id_10639("player_rope");
  level._id_D26E hide();
  level._id_EAD3 = scripts\sp\utility::_id_10639("salter_rope");
  level._id_EAD3 hide();
  var_1 = [];
  var_1[var_1.size] = var_0;
  var_1[var_1.size] = level._id_D26E;
  var_1[var_1.size] = level._id_D042;
  var_2 = scripts\engine\utility::getStruct("emp_anim_struct", "targetname");
  var_2 scripts\sp\anim::_id_1EC1(var_1, "emp_plant");
  var_1[var_1.size] = level._id_EA2C;
  var_1[var_1.size] = level._id_EAD3;
  var_1[var_1.size] = level._id_EA5C;
  level.player _meth_823C(var_0, "tag_player", 0.75, 0.3, 0.3);
  wait 0.75;
  var_2 thread scripts\sp\anim::_id_1F2C(var_1, "emp_plant");
  level._id_2571._id_13ED6 = 1;
  var_0 show();
  level._id_D042 show();
  level._id_EA5C show();
  level._id_D26E show();
  level._id_EAD3 show();
  var_0 waittillmatch("single anim", "end");
  level notify("teleport_salter");
  level._id_2571._id_13ED6 = 0;
  level.player unlink();
  var_0 delete();
  level._id_D26E delete();
  level._id_EAD3 delete();
  level.player freezecontrols(0);
  level.player setstance("stand");
  level.player allowcrouch(1);
  level.player allowsprint(1);
  level.player _meth_80A1();
  scripts\engine\utility::flag_wait("emp_done");
}

_id_D6CE() {
  wait 16;
  level._id_EA2C._id_9320 = 1;
  level waittill("teleport_salter");
  level._id_EA2C scripts\sp\utility::_id_51E1("casual");
  thread _id_0F35::_id_EBB0(0.5, 0.5);
  level._id_EA2C._id_9320 = 0;
}

_id_3AAD() {
  var_0 = getEntArray("moving_engine_parts", "targetname");
  var_1 = scripts\engine\utility::getStruct("l_engine_1", "targetname");
  var_2 = scripts\engine\utility::getclosest(var_1.origin, var_0);
  var_1 = scripts\engine\utility::getStruct("l_engine_3", "targetname");
  var_3 = scripts\engine\utility::getclosest(var_1.origin, var_0);
  var_2 thread _id_3AAE("l_engine_2_off");
  var_3 thread _id_3AAE("l_engine_3_off");
}

_id_3AAE(var_0) {
  self._id_1FBB = "engine_parts";
  self _meth_83D0(#animtree);
  thread scripts\sp\anim::_id_1EEA(self, "engine_loop", "stop_loop");
  level waittill(var_0);
  self notify("stop_loop");
  thread scripts\sp\anim::_id_1F35(self, "engine_spinning_down");
}

_id_3ABD() {
  scripts\engine\utility::waitframe();

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9)) {
    level._id_AB3C = [];
    level._id_A73E = _id_F909("l_engine_2", "vfx_carrier_engine_glow_powered");
    level._id_AB3C[level._id_AB3C.size] = level._id_A73E;
    level._id_A740 = _id_F909("l_engine_3", "vfx_carrier_engine_glow_powered");
    level._id_AB3C[level._id_AB3C.size] = level._id_A740;
    level._id_E518 = [];
    level._id_DBA9 = _id_F909("r_engine_1", "vfx_carrier_engine_glow_powered_cheap");
    level._id_E518[level._id_E518.size] = level._id_DBA9;
    level._id_DBAB = _id_F909("r_engine_2", "vfx_carrier_engine_glow_powered_cheap");
    level._id_E518[level._id_E518.size] = level._id_DBAB;
    level._id_DBAD = _id_F909("r_engine_3", "vfx_carrier_engine_glow_powered_cheap");
    level._id_E518[level._id_E518.size] = level._id_DBAD;
    level._id_DBAF = _id_F909("r_engine_4", "vfx_carrier_engine_glow_powered_cheap");
    level._id_E518[level._id_E518.size] = level._id_DBAF;
    level._id_DBCE = undefined;
    level._id_DBD1 = undefined;
    var_0 = _id_0F31::_id_7EDE();

    foreach(var_2 in var_0) {
      if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "radar_left")
        level._id_DBCE = var_2;

      if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "radar_right")
        level._id_DBD1 = var_2;
    }

    level._id_DBCE _id_0F31::_id_310C(1);
    level._id_DBCE thread _id_0F31::_id_3109(22);
    level._id_DBD1 _id_0F31::_id_310C(1);
    level._id_DBD1 thread _id_0F31::_id_3109(22);
  }

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9))
    level waittill("emp_detonate");

  thread _id_3ABC();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_6150();
  var_4 = getEntArray("engine_hurt_triggers", "targetname");

  foreach(var_6 in var_4)
  var_6 scripts\engine\utility::trigger_off();
}

_id_F909(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin);
  var_3.fx = var_1;
  playFXOnTag(level._effect[var_1], var_3, "tag_origin");
  var_3._id_FC51 = scripts\engine\utility::spawn_tag_origin(var_2.origin + (1390, 0, 0));
  var_3._id_FC51 thread _id_3AB3();
  return var_3;
}

_id_3AB3() {
  self endon("vfx_carrier_fx_shake_stop");

  for(;;) {
    self _meth_8291(0.1, 0.1, 0, 1, 0, 0, 1500, 10, 10, 10);
    self playRumbleOnEntity("carrier_engine_rumble");
    wait 1;
  }
}

_id_3AB2(var_0) {
  wait(randomfloatrange(0, 0.25));
  stopFXOnTag(level._effect[var_0], self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_carrier_engine_glow_power_down"), self, "tag_origin");

  if(isDefined(self._id_FC51))
    self._id_FC51 notify("vfx_carrier_fx_shake_stop");

  scripts\engine\utility::flag_wait("deck1");
  thread _id_514E();
}

_id_3ABC() {
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_613A((11450, -2650, 500), "l");

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9))
    wait 1;

  _id_3ABA();

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9))
    wait 0.5;

  _id_3AB9();

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9))
    wait 0.5;

  _id_3AB8();

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9))
    wait 0.5;

  _id_3ABB();

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9))
    wait 0.5;

  var_0 = scripts\engine\utility::getStruct("group_02_sfx_struct", "targetname");
  level._id_867E = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  level._id_867E thread _id_514E();
  scripts\engine\utility::flag_set("group_02_lights_off");
  var_1 = getEntArray("light_group_02", "targetname");
  scripts\engine\utility::array_thread(var_1, ::_id_ACA1);
  var_2 = getEntArray("light_group_02_model", "targetname");
  scripts\engine\utility::array_thread(var_2, ::_id_AC96);
  thread _id_AC94("light_group_02_volume");

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9))
    wait 0.5;

  var_0 = scripts\engine\utility::getStruct("group_03_sfx_struct", "targetname");
  level._id_867F = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  level._id_867F thread _id_514E();
  scripts\engine\utility::flag_set("group_03_lights_off");
  var_3 = getEntArray("light_group_03", "targetname");
  scripts\engine\utility::array_thread(var_3, ::_id_ACA1);
  var_4 = getEntArray("light_group_03_model", "targetname");
  scripts\engine\utility::array_thread(var_4, ::_id_AC96);
  thread _id_AC94("light_group_03_volume");

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9))
    wait 0.5;

  var_0 = scripts\engine\utility::getStruct("group_04_sfx_struct", "targetname");
  level._id_8680 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  level._id_8680 thread _id_514E();
  scripts\engine\utility::flag_set("group_04_lights_off");
  var_5 = getEntArray("light_group_04", "targetname");
  scripts\engine\utility::array_thread(var_5, ::_id_ACA1);
  var_6 = getEntArray("light_group_04_model", "targetname");
  scripts\engine\utility::array_thread(var_6, ::_id_AC96);
  thread _id_AC94("light_group_04_volume");
  level._id_3965 thread _id_0BB8::_id_39CE("off");
  scripts\engine\utility::flag_set("emp_done");
}

_id_3ABA() {
  var_0 = [];
  var_1 = getEntArray("light_group_01_right_engine_1", "targetname");
  var_2 = getEntArray("light_group_01_right_engine_2", "targetname");
  var_0 = scripts\engine\utility::array_combine(var_1, var_2);
  var_3 = getEntArray("light_group_01_right_engine_3", "targetname");
  var_0 = scripts\engine\utility::array_combine(var_0, var_3);
  var_4 = getEntArray("light_group_01_right_engine_4", "targetname");
  var_0 = scripts\engine\utility::array_combine(var_0, var_4);
  var_5 = getEntArray("light_group_01_right_model", "targetname");

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9)) {
    var_6 = scripts\engine\utility::getStruct("detonate_emp_fx_right_2", "targetname");
    var_7 = scripts\engine\utility::spawn_tag_origin(var_6.origin, var_6.angles);
    var_7 thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_614F();
    var_7 thread scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132F8("tag_origin");
    var_7 thread _id_514E();
    wait 0.15;
    thread _id_65AC(var_1, level._id_DBA9);
    scripts\engine\utility::delaythread(0.25, ::_id_65AC, var_2, level._id_DBAB);
  } else {
    scripts\engine\utility::array_thread(var_0, ::_id_ACA1);

    if(isDefined(level._id_E518))
      scripts\engine\utility::array_thread(level._id_E518, ::_id_3AB2, "vfx_carrier_engine_glow_powered");
  }

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9)) {
    var_8 = scripts\engine\utility::getStruct("detonate_emp_fx_right_1", "targetname");
    var_7 = scripts\engine\utility::spawn_tag_origin(var_8.origin, var_8.angles);
    var_7 thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_614F();
    var_7 thread scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_D6FD(0.05, -1, 0, 0.75, 0.75, 0.15, 0.5, "tag_origin", "vfx_emp_det_r");
    var_7 thread _id_514E();
    thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_11850();
    wait 0.25;
    thread _id_65AC(var_4, level._id_DBAF);
    scripts\engine\utility::delaythread(0.25, ::_id_65AC, var_3, level._id_DBAD);
    wait 0.5;
  }

  var_9 = scripts\engine\utility::getStruct("group_01_right_sfx_struct", "targetname");
  level._id_867A = scripts\engine\utility::spawn_tag_origin(var_9.origin);
  level._id_867A thread _id_514E();
  scripts\engine\utility::flag_set("group_01_right_lights_off");
  scripts\engine\utility::array_thread(var_5, ::_id_AC96);

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9)) {
    level._id_DBD1 notify("stopRotating");
    level._id_DBD1 rotateroll(22, 3, 0, 3);
  }
}

_id_3AB9() {
  var_0 = scripts\engine\utility::getStruct("group_01_middle_sfx_struct", "targetname");
  level._id_8679 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  level._id_8679 thread _id_514E();
  scripts\engine\utility::flag_set("group_01_middle_lights_off");
  var_1 = getEntArray("light_group_01_middle_model", "targetname");
  scripts\engine\utility::array_thread(var_1, ::_id_AC96);
  var_2 = getEntArray("light_group_01_middle_light", "targetname");
  scripts\engine\utility::array_thread(var_2, ::_id_ACA1);
}

_id_3AB8() {
  var_0 = [];
  var_1 = getEntArray("light_group_01_left_engine_2", "targetname");
  var_2 = getEntArray("light_group_01_left_engine_3", "targetname");
  var_0 = scripts\engine\utility::array_combine(var_1, var_2);
  var_3 = getEntArray("light_group_01_left_engine_4", "targetname");
  var_0 = scripts\engine\utility::array_combine(var_0, var_3);
  var_4 = getEntArray("light_group_01_model", "targetname");
  var_5 = getEntArray("light_group_01_left_model", "targetname");

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9)) {
    level._id_EA5C thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_614E();
    level._id_EA5C thread scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132F8("j_handle");
    level._id_EA5C thread _id_514E();
    wait 0.2;
    thread _id_65AC(var_2, level._id_A740);
    level notify("l_engine_3_off");
  } else {
    scripts\engine\utility::array_thread(var_0, ::_id_ACA1);

    if(isDefined(level._id_AB3C))
      scripts\engine\utility::array_thread(level._id_AB3C, ::_id_3AB2, "vfx_carrier_engine_glow_powered");
  }

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9)) {
    level._id_D042 thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_614E();
    level._id_D042 thread scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_D6FD(0.15, -0.9, 0.5, 0.75, 0.75, 0.15, 0.5, "j_handle", "vfx_emp_det_l");
    level._id_D042 thread _id_514E();
    thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_1184F();
    scripts\engine\utility::flag_set("stop_cap_ship_thruster_ambience");
    wait 0.25;
    thread _id_65AC(var_1, level._id_A73E);
    level notify("l_engine_2_off");
    wait 0.5;
    scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132F9();
  }

  var_6 = scripts\engine\utility::getStruct("group_01_left_sfx_struct", "targetname");
  level._id_8678 = scripts\engine\utility::spawn_tag_origin(var_6.origin);
  level._id_8678 thread _id_514E();
  scripts\engine\utility::flag_set("group_01_left_lights_off");
  scripts\engine\utility::array_thread(var_0, ::_id_ACA1);
  scripts\engine\utility::array_thread(var_4, ::_id_AC96);
  scripts\engine\utility::array_thread(var_5, ::_id_AC96);
  level._id_3AB0 = getEntArray("carrier_exterior_light_on_models", "targetname");
  thread _id_AC94("light_group_01_volume");

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9)) {
    level._id_DBCE notify("stopRotating");
    level._id_DBCE rotateroll(22, 3, 0, 3);
  }
}

_id_3ABB() {
  var_0 = getEntArray("light_group_01", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_ACA1);
  var_1 = getEntArray("light_group_01_railing_01", "targetname");
  var_2 = getEntArray("light_group_01_railing_02", "targetname");
  var_3 = getEntArray("light_group_01_railing_03", "targetname");
  var_4 = getEntArray("light_group_01_railing_01_model", "targetname");
  var_5 = getEntArray("light_group_01_railing_02_model", "targetname");
  var_6 = getEntArray("light_group_01_railing_03_model", "targetname");
  var_7 = scripts\engine\utility::getStruct("group_01_side_01_sfx_struct", "targetname");
  level._id_867B = scripts\engine\utility::spawn_tag_origin(var_7.origin);
  level._id_867B thread _id_514E();
  scripts\engine\utility::flag_set("group_01_side_01_lights_off");
  scripts\engine\utility::array_thread(var_1, ::_id_ACA1);
  scripts\engine\utility::array_thread(var_4, ::_id_AC96);

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9))
    wait 0.25;

  var_7 = scripts\engine\utility::getStruct("group_01_side_02_sfx_struct", "targetname");
  level._id_867C = scripts\engine\utility::spawn_tag_origin(var_7.origin);
  level._id_867C thread _id_514E();
  scripts\engine\utility::flag_set("group_01_side_02_lights_off");
  scripts\engine\utility::array_thread(var_2, ::_id_ACA1);
  scripts\engine\utility::array_thread(var_5, ::_id_AC96);

  if(isDefined(level._id_6192) || isDefined(level._id_D7B9))
    wait 0.25;

  var_7 = scripts\engine\utility::getStruct("group_01_side_03_sfx_struct", "targetname");
  level._id_867D = scripts\engine\utility::spawn_tag_origin(var_7.origin);
  level._id_867D thread _id_514E();
  scripts\engine\utility::flag_set("group_01_side_03_lights_off");
  scripts\engine\utility::array_thread(var_3, ::_id_ACA1);
  scripts\engine\utility::array_thread(var_6, ::_id_AC96);
}

_id_8A9D() {
  var_0 = getEntArray("light_group_03_hangar_01", "targetname");
  var_1 = getEntArray("light_group_03_hangar_02", "targetname");
  var_2 = getEntArray("light_group_03_hangar_03", "targetname");
  var_3 = getEntArray("light_group_03_hangar_04", "targetname");
  var_4 = getEntArray("hangar_light_model_01", "targetname");
  var_5 = getEntArray("hangar_light_model_02", "targetname");
  var_6 = getEntArray("hangar_light_model_03", "targetname");
  var_7 = getEntArray("hangar_light_model_04", "targetname");
  var_8 = getEntArray("light_group_03_hangar_model_01", "targetname");
  var_9 = getEntArray("light_group_03_hangar_model_02", "targetname");
  var_10 = getEntArray("light_group_03_hangar_model_03", "targetname");
  var_11 = getEntArray("light_group_03_hangar_model_04", "targetname");

  if(isDefined(level._id_6192) || isDefined(level._id_D7C4)) {
    scripts\engine\utility::array_thread(var_0, ::_id_ACA1);
    scripts\engine\utility::array_thread(var_1, ::_id_ACA1);
    scripts\engine\utility::array_thread(var_2, ::_id_ACA1);
    scripts\engine\utility::array_thread(var_3, ::_id_ACA1);
    scripts\engine\utility::array_thread(var_8, ::_id_AC96, 1);
    scripts\engine\utility::array_thread(var_9, ::_id_AC96, 1);
    scripts\engine\utility::array_thread(var_10, ::_id_AC96, 1);
    scripts\engine\utility::array_thread(var_11, ::_id_AC96, 1);
    scripts\engine\utility::flag_wait("hangar_lights_trigger1");
  }

  scripts\engine\utility::array_thread(var_0, ::_id_ACA1, 1);

  foreach(var_13 in var_4)
  var_13 thread _id_AC96(undefined, undefined, 1);

  foreach(var_16 in var_8)
  var_16 thread _id_AC96(undefined, 1);

  if(isDefined(level._id_6192) || isDefined(level._id_D7C4))
    scripts\engine\utility::flag_wait("hangar_lights_trigger2");

  scripts\engine\utility::array_thread(var_1, ::_id_ACA1, 1);

  foreach(var_13 in var_5)
  var_13 thread _id_AC96(undefined, undefined, 1);

  foreach(var_16 in var_9)
  var_16 thread _id_AC96(undefined, 1);

  if(isDefined(level._id_6192) || isDefined(level._id_D7C4))
    wait 0.5;

  scripts\engine\utility::array_thread(var_2, ::_id_ACA1, 1);

  foreach(var_13 in var_6)
  var_13 thread _id_AC96(undefined, undefined, 1);

  foreach(var_16 in var_10)
  var_16 thread _id_AC96(undefined, 1);

  if(isDefined(level._id_6192) || isDefined(level._id_D7C4))
    wait 0.5;

  scripts\engine\utility::array_thread(var_3, ::_id_ACA1, 1);

  foreach(var_13 in var_7)
  var_13 thread _id_AC96(undefined, undefined, 1);

  foreach(var_16 in var_11)
  var_16 thread _id_AC96(undefined, 1);
}

_id_ACA1(var_0) {
  if(isDefined(self)) {
    if(isDefined(var_0)) {
      if(isDefined(self._id_C724))
        self setlightintensity(self._id_C724);
    } else {
      self._id_C724 = self _meth_8134();
      self setlightintensity(0.0);
    }
  }
}

_id_AC94(var_0) {
  var_1 = getEnt(var_0, "targetname");

  foreach(var_3 in level._id_3AB0) {
    if(var_3 istouching(var_1)) {
      level._id_3AB0 = scripts\engine\utility::array_remove(level._id_3AB0, var_3);
      var_3 thread _id_AC96(undefined, undefined, 1);
    }
  }
}

_id_AC96(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(isDefined(self))
      self hide();
  } else if(isDefined(var_1)) {
    if(isDefined(self))
      self show();
  } else if(isDefined(var_2)) {
    if(isDefined(self)) {
      var_3 = _id_AC95(self.model);

      if(isDefined(var_3)) {
        var_4 = spawn("script_model", self.origin);
        var_4.angles = self.angles;
        var_4 setModel(var_3);
      }

      self delete();
    }
  } else if(isDefined(self))
    self delete();
}

_id_AC95(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "ship_exterior_light_unit_e":
      var_1 = "ship_exterior_light_unit_e_off";
      break;
    case "ship_exterior_light_unit_f":
      var_1 = "ship_exterior_light_unit_f_off";
      break;
    case "light_sdf_interior_hallway_01_on_cool":
      var_1 = "light_sdf_interior_hallway_01";
      break;
    case "ind_light_led_worklight":
      var_1 = "ind_light_led_worklight_on";
      break;
    case "light_interior_ceiling_industrial_lamp_01":
      var_1 = "light_interior_ceiling_industrial_lamp_01_on";
      break;
    default:
      break;
  }

  return var_1;
}

_id_AC9A() {
  var_0 = self _meth_8134();

  if(var_0 > 50) {
    var_0 = int(var_0 / 3);
    self setlightintensity(var_0);
    wait 0.25;
  }

  self setlightintensity(0.0);
}

_id_65AC(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.classname == "light_omni") {
      var_2 = var_4;
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
    }
  }

  if(isDefined(var_2)) {
    var_6 = var_2 _meth_8134();
    var_7 = int(var_6 / 3);
    var_8 = int(var_6 / 2);
    var_2 setlightintensity(var_7);
    wait 0.5;
    var_2 setlightintensity(var_8);
    wait 0.5;
    var_2 setlightintensity(0.0);
  }

  if(isDefined(var_2))
    var_2 _id_ACA1();

  scripts\engine\utility::array_thread(var_0, ::_id_AC9A);
  var_1 _id_3AB2(var_1.fx);
}

_id_514E() {
  wait 20;

  if(isDefined(self._id_FC51))
    self._id_FC51 delete();

  if(isDefined(self))
    self delete();
}

_id_727B() {
  var_0 = getEntArray("light_group_01_win", "targetname");
  scripts\sp\utility::_id_228A(var_0);
  var_0 = getEntArray("light_group_02_win", "targetname");
  scripts\sp\utility::_id_228A(var_0);
  var_0 = getEntArray("light_group_03_win", "targetname");
  scripts\sp\utility::_id_228A(var_0);
  var_0 = getEntArray("light_group_04_win", "targetname");
  scripts\sp\utility::_id_228A(var_0);
}

_id_88A6() {
  var_0 = _id_AA81("amb_enemy_jackal", 4, 0, 0, "hull_comb_nme");
  level waittill("launch_amb_allies");
  var_1 = _id_AA81("amb_ally_jackal", 4, 0.75, 0.25, "hull_comb_nme");
  scripts\engine\utility::flag_wait("enter_jackal");
  _id_0BA9::_id_EA02(var_0);
  _id_0BA9::_id_EA02(var_1);
}

_id_91B8() {
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132C0(1);
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132BF(1);
  thread _id_3738();
  thread _id_91BD();
  thread _id_FA6C();
  scripts\engine\utility::waitframe();
  var_0 = getEnt("deck_ally1", "targetname");
  level._id_1CB7 = var_0 scripts\sp\utility::_id_10619(1);
  level._id_1CB7 scripts\sp\utility::_id_F415(1);
  level._id_1CB7 thread scripts\sp\utility::_id_B14F();
  level._id_1CB7 scripts\sp\utility::_id_72EC("iw7_kbs+silencersniperhide", "primary");
  level._id_A54E = level._id_1CB7;
  var_0 = getEnt("deck_ally2", "targetname");
  level._id_1CBB = var_0 scripts\sp\utility::_id_10619(1);
  level._id_1CBB scripts\sp\utility::_id_F415(1);
  level._id_1CBB thread scripts\sp\utility::_id_B14F();
  level._id_1CB7 scripts\sp\utility::_id_72EC("iw7_m4+phase_sp+silencer", "primary");
  level._id_30F6 = level._id_1CBB;
  thread _id_1137B("hull_grap_vol", "hull_cover_grap_vol");
  scripts\sp\utility::_id_15F1("move_to_deck", "targetname", level.player);
  scripts\engine\utility::flag_set("hull_combat_begin");
  level._id_EA2C scripts\sp\utility::_id_F415(1);
  level._id_EA2C scripts\sp\utility::_id_F416(0);
  scripts\engine\utility::flag_wait("deck1");
  level.player allowwallrun(1);
  thread _id_91B9();
  thread _id_0F35::_id_EBB0(1, 2);
  setsaveddvar("grapple_no_orient", "0");
  scripts\sp\utility::_id_2669("on_deck");
  scripts\engine\utility::waitframe();
  thread _id_E39D();
  level._id_EA2C thread _id_88EB("spawn_hull_guys");
  scripts\engine\utility::flag_wait_all("deck1a", "ret_vo_over");
  scripts\sp\utility::_id_2669("1st_wave");
  scripts\engine\utility::flag_clear("disable_weapon_help");
  thread _id_43FC();
  thread _id_8917();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_91BC();
  scripts\sp\utility::_id_22C9("hull_guys1", ::_id_9324);
  thread _id_0F16::_id_B2CC("deck1a", "hull_guys1", undefined, 3, "deck2", "deck1a");
  thread _id_0F16::_id_B2CC("deck2a", "hull_guys2", "hull_combat_vol2", 3, undefined, "deck3");
  thread _id_0F16::_id_68BF("deck3", "hull_combat_vol3");
  thread _id_0F16::_id_B2CC("deck4", "hull_guys4", "hull_combat_vol4", 3, "deck4a", "deck4a");
  thread _id_0F16::_id_B2CC("deck5", "hull_guys5", "hull_combat_vol5", 3, "deck5a", "deck5a");
  thread _id_0F16::_id_68BF("deck6", "hull_combat_vol6");
  level scripts\engine\utility::waittill_any_timeout(10, "gone_hot", "deck2a");
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1)
  var_3 notify("gone_hot");

  thread _id_0F16::_id_68BF("deck1a", "hull_combat_vol1a");
  scripts\engine\utility::flag_set("hot_combat");
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  level._id_EA2C scripts\sp\utility::_id_F415(0);
  level._id_1CB7 scripts\sp\utility::_id_F415(0);
  level._id_1CBB scripts\sp\utility::_id_F415(0);
  scripts\engine\utility::flag_wait("deck2");
  scripts\sp\utility::_id_2669("wave2");
  scripts\engine\utility::flag_wait("deck5");
  thread _id_BE76();
  thread _id_62E7();
  loadtransient("sa_empambush_player_jackal_tr");
  level scripts\engine\utility::waittill_any("hull_combat_over", "enter_carrier");
  scripts\engine\utility::flag_wait("enter_carrier");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  thread _id_4063();
}

_id_4063() {
  scripts\engine\utility::flag_wait("entering_ship_interior");
  var_0 = getaiarray("axis");

  if(isDefined(level._id_A1FA))
    var_0 = scripts\engine\utility::array_remove_array(var_0, level._id_A1FA);

  scripts\engine\utility::array_call(var_0, ::delete);
  scripts\sp\utility::_id_2669("enter_carrier");
}

_id_62E7() {
  var_0 = getaiarray("axis");
  scripts\sp\utility::_id_13754(var_0, var_0.size);
  level notify("hull_combat_over");
  thread emp_stopmusic();
}

emp_stopmusic() {
  wait 10;
  setmusicstate("");
}

_id_43FC() {
  level endon("hull_combat_over");
  wait 1;
  scripts\sp\utility::_id_10350("sa_empambush_ksh_gotpatrolstopsi");
  scripts\engine\utility::flag_wait("hot_combat");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_enemycontact12o");
  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_comingoutthecon");
  wait 1;
  scripts\sp\utility::_id_10350("sa_empambush_brk_sweepandclearin");
  wait 3;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_pushthroughtoth");
  wait 3;
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_wekickedahivehe");
  thread _id_7746();
  scripts\engine\utility::flag_wait("deck4a");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_watchthatedge");
  scripts\engine\utility::flag_wait("deck5");
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_getuscleartothe");
}

_id_7746() {
  level endon("hull_combat_over");
  var_0 = ["sa_empambush_slt_gunnersonthemas", "sa_empambush_brk_watchyourflank", "sa_empambush_plr_keepmoving2", "sa_empambush_brk_watchthebarrier", "sa_empambush_slt_moresdfcomingin", "sa_empambush_brk_hustlebeforepow", "sa_empambush_slt_behindthetanks", "sa_empambush_plr_weneedtogetinbe"];
  var_1 = [level._id_EA2C, level._id_30F6, level.player, level._id_30F6, level._id_EA2C, level._id_30F6, level._id_EA2C, level.player];

  for(var_2 = 0; !scripts\engine\utility::flag("enter_carrier") && var_2 < var_0.size; var_2++) {
    wait(10 + randomintrange(1, 5));

    if(var_1[var_2] == level.player) {
      level.player scripts\sp\utility::_id_1034D(var_0[var_2]);
      continue;
    }

    if(var_1[var_2] == level._id_EA2C) {
      level._id_EA2C scripts\sp\utility::_id_10346(var_0[var_2]);
      continue;
    }

    scripts\sp\utility::_id_10350(var_0[var_2]);
  }
}

_id_BE76() {
  scripts\engine\utility::flag_wait("deck6");
  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_ingressisdeadah");
  wait 2;
  var_0 = getaiarray("axis");

  if(var_0.size > 0)
    scripts\sp\utility::_id_13754(var_0, var_0.size, 30);

  level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_yourecleartoinf");
  wait 2;
  scripts\sp\utility::_id_10350("sa_empambush_brk_wellholdtopside");
  wait 1;
  scripts\sp\utility::_id_10350("sa_empambush_plr_checkgatorimgoi");
  wait 1;
  scripts\sp\utility::_id_10350("sa_empambush_gtr_rogersendingnow");
}

_id_9A73() {
  scripts\engine\utility::flag_wait("enter_carrier");
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_allstationbeadv");
  wait 0.5;
  scripts\sp\utility::_id_10350("sa_empambush_slt_copywatchyouras");
  scripts\engine\utility::flag_wait("start_jackal_guys");
  level.player endon("flag_player_has_jackal");
  wait 60;
  scripts\sp\utility::_id_10350("sa_empambush_gtr_commandersooner");
}

_id_91B9() {
  thread _id_12722("deck2a", 1);
  thread _id_12722("deck2a", 2);
  thread _id_12722("deck3", 3);
  thread _id_12722("deck3", 5);
  thread _id_12722("deck4", 6);
  thread _id_12722("deck4", 7);
  thread _id_12722("deck4a", 4);
  thread _id_12722("deck5", 9);
  thread _id_12722("deck5", 8);
  thread _id_12722("deck5a", 11);
  thread _id_12722("deck6", 12);
  thread _id_12722("last_deck_trigger", 13);
  thread _id_12722("none", 10);
  thread _id_12722("none", 16);
  thread _id_12722("none", 17);
  thread _id_12722("deck6", 14);
  thread _id_12722("near_elevator", 15);
  thread _id_88A4();
}

_id_1692(var_0) {
  if(!isDefined(level._id_1D67))
    level._id_1D67 = [];

  level._id_1D67[level._id_1D67.size] = var_0;
}

_id_DFC3(var_0) {
  var_1 = scripts\engine\utility::array_find(level._id_1D67, var_0);
  level._id_1D67 = scripts\sp\utility::array_remove_index(level._id_1D67, var_1);
}

_id_88A4() {
  level endon("near_elevator");
  level waittill("ret_is_here");
  wait 2;

  for(var_0 = ""; level._id_1D67.size > 0; var_0 = var_2) {
    wait(0.5 + randomfloat(2.5));
    var_1 = randomint(level._id_1D67.size);
    var_2 = level._id_1D67[var_1];

    if(var_2 == var_0) {
      var_1++;

      if(var_1 >= level._id_1D67.size)
        var_1 = 0;

      var_2 = level._id_1D67[var_1];
    }

    scripts\engine\utility::exploder(var_2);
  }
}

_id_79DF(var_0) {
  var_1 = "vfx_hull_fire_";

  if(var_0 < 10)
    var_1 = var_1 + "0";

  var_1 = var_1 + scripts\sp\utility::string(var_0);
  return var_1;
}

_id_12722(var_0, var_1) {
  var_2 = _id_79DF(var_1);
  _id_1692(var_2);
  scripts\engine\utility::flag_wait(var_0);
  _id_DFC3(var_2);
  wait(randomfloat(0.5));
  scripts\engine\utility::exploder(var_2);
}

_id_91BD() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(level._id_EA2C, "tag_eye", (0, 0, 20), (0, 0, 0));
  objective_add(scripts\sp\utility::_id_C264("obj_follow_salter2"), "current", &"SA_EMPAMBUSH_REACH_THE_HANGAR_ENTRANCE");
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("obj_follow_salter2"), &"SA_EMPAMBUSH_SUPPORT");
  objective_onentity(scripts\sp\utility::_id_C264("obj_follow_salter2"), var_0);
  thread _id_0F16::_id_C278(scripts\sp\utility::_id_C264("obj_follow_salter2"));
  scripts\engine\utility::flag_wait("near_elevator");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_follow_salter2"));
  thread _id_9A79();
}

_id_9324() {
  self.ignoreall = 1;
  scripts\engine\utility::waittill_any("reached_path_end", "damage", "gone_hot");
  self.ignoreall = 0;
  level notify("gone_hot");
  level._id_EA2C scripts\sp\utility::_id_F415(0);
  level._id_1CB7 scripts\sp\utility::_id_F415(0);
  level._id_1CBB scripts\sp\utility::_id_F415(0);
  self clearpath();
  var_0 = getEnt("hull_combat_vol1a", "targetname");
  self setgoalpos(self.origin);
  scripts\engine\utility::waitframe();
  self _meth_82F1(var_0);
}

_id_8917() {
  level._id_EA2C thread _id_88EB("deck3");
  _id_262E("deck1a");
  _id_262E("deck2a");
  _id_262E("deck4a");
  _id_262E("deck5a");
  level._id_EA2C thread _id_88EB("last_deck_trigger");
}

_id_88EB(var_0) {
  scripts\engine\utility::flag_wait(var_0);
  thread _id_0F34::_id_13E86(5);
}

_id_262E(var_0) {
  scripts\engine\utility::flag_wait(var_0);
  wait 2;
  _id_0F16::_id_E9FC(var_0 + "_ally", "targetname", level.player);
  wait 0.2;
  level._id_1CB7 thread _id_0F34::_id_13E86(5);
  level._id_1CBB thread _id_0F34::_id_13E86(5);
  level._id_EA2C thread _id_0F34::_id_13E86(5);
}

_id_E39E() {
  scripts\engine\utility::flag_wait("ret_is_here");
  wait 1;

  if(!scripts\engine\utility::flag("spawn_hull_guys")) {
    level._id_EA2C scripts\sp\utility::_id_10346("sa_empambush_slt_visualonretribu");
    wait 0.2;
  }

  setmusicstate("mx_268_emp_combat");
  wait 1;

  if(!scripts\engine\utility::flag("deck2")) {
    level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_copywegotskelte");
    wait 0.5;

    if(!scripts\engine\utility::flag("deck2"))
      scripts\sp\utility::_id_10350("sa_empambush_gtr_rogerthatlaunch");
  }

  scripts\engine\utility::flag_set("ret_vo_over");
}

_id_E39D() {
  scripts\engine\utility::flag_wait("ret_called");
  thread _id_88A6();
  var_0 = getEnt("retribution", "targetname");
  var_0._id_EEF9 = "missile_cluster_turret_un cannon_small_un,1,1,amb_turret_sml_t_l_1,amb_turret_sml_t_l_2,amb_turret_sml_t_l_3,amb_turret_sml_t_l_4,amb_turret_sml_t_r_1,amb_turret_sml_t_r_2,amb_turret_sml_t_r_3,amb_turret_sml_t_r_4";
  level._id_E35D = scripts\sp\vehicle::_id_1080C("retribution");
  level._id_E35D._id_12FBA = 1;
  scripts\engine\utility::waitframe();
  level._id_E35D scripts\sp\vehicle::_id_8441();
  level._id_E35D notsolid();
  level._id_E35D._id_1FBB = "retribution";
  level._id_E35D _id_0BB8::_id_39AE();
  level._id_E35D._id_E7D0 = 0;
  var_1 = getvehiclenode("retribution_jump_in", "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_2.angles = var_1.angles;
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_E3A8();
  level._id_E35D _id_0BB8::_id_398C("off", "heavy", "high", var_2);
  thread _id_E39E();
  level notify("launch_amb_allies");
  var_2 delete();
  level._id_E35D attachpath(var_1);
  level._id_E35D thread scripts\sp\vehicle::_id_1321A(var_1);
  thread scripts\sp\vehicle_paths::_id_845A(level._id_E35D);
  scripts\engine\utility::flag_set("ret_is_here");
  wait 2;
  level._id_E35D thread _id_0BB6::_id_39F0();
}

_id_AA81(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];
  var_8 = getEntArray(var_0, "targetname");

  if(var_8.size == 0 && var_1 > 0) {
    var_8 = [];

    for(var_9 = 1; var_9 <= var_1; var_9++) {
      var_10 = var_0 + scripts\sp\utility::string(var_9);
      var_8[var_8.size] = getEnt(var_10, "targetname");
    }
  }

  foreach(var_12 in var_8) {
    var_13 = scripts\sp\utility::_id_7C9A(var_12.target);

    if(!isDefined(var_4))
      var_4 = var_12.targetname;

    var_14 = var_12 scripts\sp\utility::_id_10808();
    var_14 thread _id_0BDC::_id_A1EF(var_13);
    var_7[var_7.size] = var_14;

    if(isDefined(var_4) && var_4 != "none") {
      var_14 _id_0BDC::_id_19B3("combat", var_4);
      var_14 _id_0BDC::_id_19B3("patrol", var_4);

      if(isDefined(var_5))
        var_14 _id_0BDC::_id_19B3("escape", var_5);
      else
        var_14 _id_0BDC::_id_19B3("escape", var_4);

      var_14 _id_0BDC::_id_1990(1);
    }

    if(scripts\engine\utility::is_true(var_6))
      var_14 thread _id_168E();
    else
      var_14 thread _id_DF1F();

    if(isDefined(var_2) && var_2 > 0) {
      if(isDefined(var_3) && var_3 > 0)
        var_3 = randomfloatrange(-1 * var_3, var_3);

      wait(var_2 + var_3);
    }
  }

  return var_7;
}

_id_1062C(var_0, var_1) {
  var_2 = _id_1062A(var_0);
  var_2 _id_0BDC::_id_19A0(1);
  var_2 thread _id_0BDC::_id_A1EF(scripts\sp\utility::_id_7C9A(var_1));
  var_2 waittill("begin_land");
  wait 1.5;
  var_3 = var_2 scripts\engine\utility::waittill_either("goal", "near_goal");
  var_2 _meth_8455(var_2.origin, 1);
}

_id_1062A(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = getEnt(var_0, "targetname");
  var_3 = var_2 scripts\sp\utility::_id_10808();
  var_3 _id_0BDC::_id_19B3("patrol", "axis_patrol");
  var_3 _id_0BDC::_id_19B3("escape", "axis_patrol");
  var_3 _id_0BDC::_id_19B3("combat", "axis_patrol");

  if(var_1)
    var_3 _id_0BDC::_id_1990(1);

  return var_3;
}

_id_9A74() {
  _id_8949();
  thread _id_9A73();
  thread _id_13E96();
  thread _id_889C();
  thread _id_8909();
  thread _id_891E();
  thread _id_1137B("hangar_grapples");
  scripts\engine\utility::flag_set("interior_zerog_begin");
  thread _id_8E91(0);
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_9A77();
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132C0(0);
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132BF(0);
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132BD(1);
  _id_F906();
  level._id_DAA9 = _id_FA13(1);
  scripts\sp\utility::_id_241F(0);
  scripts\engine\utility::flag_wait("entering_ship_interior");
  thread _id_0F35::_id_FB26(0, 1);
  scripts\engine\utility::flag_wait("enter_jackal");
}

_id_9A79() {
  var_0 = scripts\engine\utility::getStruct("hangar_obj", "targetname");
  objective_add(scripts\sp\utility::_id_C264("hangar_obj"), "current", &"SA_EMPAMBUSH_STEAL_THE_SDF_PROTOTYPE");
  objective_position(scripts\sp\utility::_id_C264("hangar_obj"), var_0.origin);
  scripts\engine\utility::flag_wait("hangar_obj_complete");
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_DAAA();
  var_0 = scripts\engine\utility::getStruct("prototype_jackal_obj", "targetname");
  objective_position(scripts\sp\utility::_id_C264("hangar_obj"), var_0.origin);

  while(distance(level.player.origin, var_0.origin) > 500)
    scripts\engine\utility::waitframe();

  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("hangar_obj"));
}

_id_891E() {
  scripts\engine\utility::flag_wait("start_jackal_guys");
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132B1(1);
  var_0 = scripts\engine\utility::getStruct("jackal_scene", "targetname");
  var_1 = level._id_A1FA;
  var_0 thread scripts\sp\anim::_id_1F35(var_1[0], "hangar_scene1");
  var_0 thread scripts\sp\anim::_id_1F35(var_1[1], "hangar_scene2");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_DAA9, "hangar_scene");
  thread _id_1100C();
  wait 16.5;
  scripts\engine\utility::flag_set("jackal_crew_alert");
}

_id_1100C() {
  scripts\engine\utility::flag_wait("enter_jackal");
  level._id_DAA9 scripts\sp\utility::anim_stopanimScripted();
}

_id_5797() {
  var_0 = self;
  var_0._id_1FBB = "generic";
  var_0.ignoreall = 1;
  var_0._id_B3E9 = 1;
  var_0._id_13EE5 = "walk";
  var_0 addaieventlistener("grenade danger");
  var_0 addaieventlistener("gunshot");
  var_0 addaieventlistener("gunshot_teammate");
  var_0 addaieventlistener("bulletwhizby");
  var_0 addaieventlistener("projectile_impact");
  var_0 addaieventlistener("explode");
  var_0 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  var_0 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "damage");
  var_0 scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "jackal_crew_alert");
  scripts\sp\utility::_id_57D6();
  var_0 scripts\sp\utility::anim_stopanimScripted();
  var_0.ignoreme = 0;
  var_0.ignoreall = 0;
  var_0._id_B3E9 = 0;
  scripts\engine\utility::waitframe();
  var_0 getenemyinfo(level.player);
  wait 1;
  scripts\engine\utility::flag_set("jackal_crew_alert");
}

_id_13588(var_0) {
  wait(var_0);
}

_id_8909() {
  wait 0.5;
  level notify("end_enemy_highlighting");
  var_0 = getEntArray("dead_hangar_guys", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_6F3C);
}

_id_6F3C() {
  scripts\sp\utility::_id_E08B(_id_0F31::_id_6570);
  var_0 = scripts\sp\utility::_id_10619(1);
  var_0 notify("enemySpawnSetGrapple");
  var_0._id_1FBB = "corpse";
  var_0 scripts\sp\utility::_id_B14F(1);
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  var_0 scripts\sp\utility::_id_86E4();
  var_0.team = "neutral";
  thread scripts\sp\anim::_id_1EEA(var_0, self.animation, "stop_floating");
  level waittill("stop_floating");
  var_0 notify("stop_floating");
  var_0 delete();
}

_id_10C1A() {
  scripts\engine\utility::flag_wait("enter_jackal");

  while(!istransientloaded("sa_empambush_player_jackal_tr")) {
    wait 0.05;
    waitforalltransients();
  }

  _id_0BDC::_id_CF50(1);

  if(isDefined(level._id_E35D))
    level._id_E35D _id_0BA9::_id_397B();

  thread scripts\sp\utility::_id_12641("sa_emp_ret_land_tr");
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("show");
  level._id_FD6E._id_E35D show();
  thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_5876();
  level._id_FD6E._id_E35D._id_6A8D = "un";
  level._id_FD6E._id_E35D.team = "allies";
  level._id_FD6E._id_E35D.script_team = "allies";
  level._id_FD6E._id_E35D._id_EEF9 = "missile_cluster_turret_un cannon_small_un,1,1,amb_turret_sml_t_l_1,amb_turret_sml_t_l_2,amb_turret_sml_t_l_3,amb_turret_sml_t_l_4,amb_turret_sml_t_r_1,amb_turret_sml_t_r_2,amb_turret_sml_t_r_3,amb_turret_sml_t_r_4";
  level._id_FD6E._id_E35D setModel("veh_mil_air_un_retribution_rig");
  level._id_FD6E._id_E35D _id_0BB6::_id_39E8();
  level._id_FD6E._id_12FBA = 1;
  level._id_FD6E._id_E35D thread _id_0BB6::_id_39F0();
  level._id_FD6E._id_E35D setModel("veh_mil_air_un_retribution");
  level._id_FD6E._id_E35D thread _id_E307();
  level._id_12750["jackal_takeoff"] = &"JACKAL_MISSILE";
  thread _id_58B3();
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132BD(1);
  thread _id_894A();
  level.player scripts\sp\utility::_id_65E3("flag_player_has_jackal");
  level.player _meth_80CB(1);
  scripts\engine\utility::flag_wait("jackal_taking_off");
  thread _id_52A8();
  var_0 = getEnt("prototype_glass_clip", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  if(scripts\sp\utility::_id_93A6())
    _id_0BD9::_id_FA4F();

  visionsetalternate(3, 1);
  setsaveddvar("r_fog", "0");
  setsaveddvar("r_volumetrics", "0");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_follow_salter2"));
  level notify("stop_move_in_space");
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_13313(1);
  thread _id_890A();
  thread _id_618E();
  thread _id_0BDC::_id_A151(1);
  level._id_D127 _meth_849F(1);
  level._id_D127._id_B803 = ["vfx_sa_emp_jackal_missile_impact", undefined, 5];
  thread _id_9833();
  thread _id_1062A("ally_jackal3");
  thread _id_1062A("ally_jackal4");
  var_1 = getEnt("prototype_jackal_door_shoot_position", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(level._id_DAA9.origin, level._id_DAA9.angles);
  _id_0BDC::_id_D164(var_2, 0.1);
  var_3 = 2;
  var_2 rotateTo(var_1.angles, var_3, 0.5, 0.5);
  var_2 moveTo(var_1.origin, var_3, 0.5, 0.5);
  level.player scripts\engine\utility::waittill_any("player_takeoff", "start_bust_out");
  level.player scripts\engine\utility::delaycall(0.75, ::freezecontrols, 1);
  level._id_D127._id_7294 = 1;
  thread _id_2655();
  thread _id_69E2();
  level.player waittill("bust_out");
  level._id_3A87 notsolid();
  level._id_DAA9 notify("busted_out");
  scripts\engine\utility::flag_set("busted_out");
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132BD(0);
  var_4 = getaiarray("axis");
  scripts\engine\utility::array_call(var_4, ::_meth_81D0, level.player.origin, level.player);
  clearallcorpses();
  scripts\sp\utility::_id_2669("launch");
  thread _id_0BDC::_id_A151(0);
  thread _id_1595();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  level._id_D127._id_B803 = undefined;
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_13313(0);
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132BD(0);
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132B1(0);
  scripts\sp\maps\sa_empambush\sa_empambush_fx::_id_132BF(1);
  thread _id_106D2();
  thread _id_AA81("ace_jackal", 0, 0, 0, undefined, undefined, 1);
  _id_0BDC::_id_A1A9(0);
  _id_0BDC::_id_A1AD("enemy_lockon");
  var_5 = getEnt("first_jackal", "targetname");
  var_6 = var_5 scripts\sp\utility::_id_10808();
  var_7 = scripts\sp\utility::_id_7C9A("first_jackal_path");
  var_6 thread _id_0BDC::_id_A1EF(var_7);
  wait 1;
  level._id_D127 _id_0BDC::_id_A14D(1);
  var_8 = scripts\engine\utility::getStruct("jackal_exit_point", "targetname");
  _id_0BDC::_id_D190();
  level.player _meth_80CB(0);
  var_9 = 1.25;
  var_2.origin = var_8.origin;
  _id_0BDC::_id_D164(var_2, var_9);
  thread _id_2CB1(2);
  level._id_D127.script_team = "allies";
  var_4 = getaiarray("axis");
  scripts\engine\utility::array_call(var_4, ::delete);
  var_4 = getaiarray("allies");
  scripts\engine\utility::array_thread(var_4, scripts\sp\utility::_id_1101B);
  scripts\engine\utility::array_call(var_4, ::delete);
  level notify("stop_floating");
  wait(var_9);
  _id_0BDC::_id_D190();
  var_2 delete();
  level._id_D127 _id_0BDC::_id_A14D(0);
  level.player freezecontrols(0);
  thread _id_8E91();
  wait 2;
  scripts\sp\utility::_id_2669("launch");
  thread _id_88BF();
  scripts\engine\utility::flag_wait("enemies_done_spawning");

  while(level._id_1559.size > 0)
    wait 1;

  clearallcorpses();
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_1264E("sa_empambush_prime_tr");
  scripts\sp\utility::_id_1264E("sa_empambush_prime_slowhdd_tr");
  scripts\engine\utility::flag_set("dogfight_over");
  level notify("ace4");
  _id_0BDC::_id_A1A9(1);
  thread kill_all_enemy_jackals();
  wait 0.1;
  level.player notify("dogfight_over");
}

_id_E307() {
  var_0 = [];
  self._id_11856 = [];
  var_1 = getnumparts(self._id_E505);

  for(var_2 = 0; var_2 < var_1; var_2++)
    var_0[var_0.size] = getpartname(self._id_E505, var_2);

  foreach(var_4 in var_0) {
    var_5 = strtok(var_4, "_");

    if(var_5.size < 5) {
      continue;
    }
    if(var_5[1] == "engine" && var_5.size >= 5) {
      if(var_5[4] == "in" || var_5[4] == "out" && var_5.size != 7)
        self._id_11856[self._id_11856.size] = playFXOnTag(scripts\engine\utility::getfx("retribution_thrust_rear_idle"), self, var_4);
    }

    scripts\engine\utility::waitframe();
  }
}

kill_all_enemy_jackals() {
  var_0 = level._id_A056._id_1630;

  foreach(var_2 in var_0) {
    if(isalive(var_2) && var_2.team == "axis") {
      var_2 _meth_81D0();
      wait 2;
    }
  }

  scripts\sp\utility::_id_6EEA();
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
}

_id_69E2() {
  wait 0.25;
  var_0 = scripts\engine\utility::getStruct("door_phys_exp", "targetname");
  physicsexplosionsphere(var_0.origin, 500, 300, 200);
}

_id_894A() {
  while(!isDefined(level._id_DAA9.missiles))
    wait 0.1;

  level._id_DAA9.missiles._id_B446 = 25;
  setomnvar("ui_jackal_missile_total", level._id_DAA9.missiles._id_B446);
  level._id_DAA9 _id_0BDC::_id_82DD(25);
  level._id_DAA9 _id_0BDC::_id_A386(1);
}

_id_10C96() {
  thread _id_A83B();
  _id_0BDC::_id_F434(2);
  objective_add(scripts\sp\utility::_id_C264("obj_land"), "current", &"SA_EMPAMBUSH_RETURN_TO_THE_RETRIBUTION");
  level thread _id_0B51::_id_E3C6(1, 0);
  wait 1;
  level thread scripts\sp\utility::_id_BF97();
  level waittill("player_jackal_drone_dock");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_land"));
}

_id_10C97() {
  thread _id_10C96();
  thread _id_52B6();
  scripts\engine\utility::waitframe();
  level notify("final_countdown");
  scripts\sp\utility::_id_10350("sa_empambush_eth_sir20secondstil");
}

_id_DAA6() {
  level.player endon("flag_player_is_flying");

  for(;;) {
    if(level.player attackButtonPressed())
      level._id_DAA9 _id_0BDC::_id_B155(0.2);

    wait 0.05;
  }
}

_id_618E() {
  level.player endon("bust_out");

  for(;;) {
    if(level.player fragButtonPressed())
      level.player notify("start_bust_out");

    scripts\engine\utility::waitframe();
  }
}

_id_890A() {
  var_0 = ["cargobay_door_hit_1", "cargobay_door_hit_2", "cargobay_door_hit_3", "cargobay_door_hit_4"];
  var_1 = ["door_blast1", "door_blast2", "door_blast3", "door_blast4"];
  var_2 = scripts\engine\utility::spawn_tag_origin();

  for(level._id_8AA1 = 0; level._id_8AA1 < var_0.size; level._id_8AA1++) {
    var_3 = scripts\engine\utility::getStruct(var_0[level._id_8AA1], "targetname");
    var_2.origin = var_3.origin;
    var_2.angles = var_3.angles;
    level._id_D127._id_727D = var_2;
    level._id_D127 waittill("missile_fired");
    thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_8AA1();
    thread scripts\sp\maps\sa_empambush\sa_empambush_audio::_id_8A37();
    scripts\engine\utility::delaythread(0.25, ::_id_5791, level._id_8AA1, var_2);
  }

  level._id_3A87 notsolid();
  level._id_D127._id_727D = undefined;
  wait 0.25;
  level.player notify("bust_out");
  wait 3;
  level._id_3A87 delete();
}

_id_5791(var_0, var_1) {
  setumbraportalstate("emp_bay_door", 1);
  level._id_3A87 scripts\sp\utility::anim_stopanimScripted();
  playFXOnTag(scripts\engine\utility::getfx("vfx_sa_emp_jackal_missile_impact"), var_1, "tag_origin");
  level._id_D127 playRumbleOnEntity("damage_heavy");
  level._id_D127 _meth_8291(1, 1, 0, 0.5, 0.1, 0.4, 1000, 10, 10, 10);
  scripts\engine\utility::exploder("vfx_hangar_hit" + scripts\sp\utility::string(var_0));
  var_2 = "missile_hit" + scripts\sp\utility::string(var_0 + 1);
  level._id_3A87 thread scripts\sp\anim::_id_1F35(level._id_3A87, var_2);
}

_id_2655() {
  for(var_0 = level._id_8AA1; var_0 < 4; var_0++) {
    level._id_D127 notify("missile_fired");
    var_1 = "cargobay_door_hit_" + scripts\sp\utility::string(var_0 + 1);
    thread _id_DAAC(var_1);

    switch (var_0) {
      case 0:
        wait 0.6;
        break;
      case 2:
        wait 0.75;
        break;
      default:
        wait 0.2;
    }
  }
}

_id_DAAC(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin);
  wait 5;

  if(isDefined(var_2))
    var_2 delete();
}

_id_106D2() {
  wait 0.1;
  var_0 = 1;

  for(var_1 = 1; var_1 <= 3; var_1++) {
    for(var_2 = 1; var_2 <= 3; var_2++) {
      var_3 = "ace" + scripts\sp\utility::string(var_2 + 1);
      thread _id_5889("axis_jackal" + scripts\sp\utility::string(var_2), undefined, 0, var_3, var_0);
      var_0 = !var_0;
      wait 2;
    }
  }

  scripts\engine\utility::flag_set("enemies_done_spawning");
}

_id_88BF() {
  level waittill("ace2");
  level._id_3965 thread _id_0BB6::_id_39F0();
  level._id_3965._id_12A8B = 1;
  level._id_3965 _id_0BB6::_id_39CA(0);
  scripts\engine\utility::flag_wait("dogfight_over");
  thread _id_52B6();
}

_id_2CB1(var_0) {
  level._id_D127 _id_0BDC::_id_A0BE();
  wait(var_0);
  level._id_D127 _id_0BDC::_id_A0BE(0);
}

_id_58B3() {
  level.player scripts\sp\utility::_id_65E3("flag_player_has_jackal");
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_allstationsjack");
  wait 2;
  scripts\sp\utility::_id_10350("sa_empambush_slt_mountupandlaunc");
  wait 2;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_onmyway");
  setmusicstate("mx_283_emp_jackal");
  level.player scripts\sp\utility::_id_65E3("flag_player_is_flying");
  thread _id_155B();
  thread _id_A241();
  thread _id_3AEB();
  scripts\engine\utility::flag_wait("busted_out");
  wait 2;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_raiderisoffthex");
  wait 1;
  scripts\sp\utility::_id_10350("sa_empambush_slt_yourevisualenem");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_rog");
  wait 2;
  scripts\sp\utility::_id_10350("sa_empambush_slt_lookslikewegots");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_affirmletssmoke");
  wait 0.5;
  scripts\sp\utility::_id_10350("sa_empambush_slt_copyscar2swegot");
  level notify("do_aces");
  wait 5;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_ethanthisisactu");
  wait 1;
  scripts\sp\utility::_id_10350("sa_empambush_eth_5x5sir");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_iwantyoumonitor");
  wait 0.5;
  scripts\sp\utility::_id_10350("sa_empambush_eth_ayesirwillrepor");
  wait 1;
  scripts\engine\utility::flag_wait("dogfight_over");
  level endon("doing_landing");
  scripts\sp\utility::_id_2672("dogfight_over", 10);
  scripts\sp\utility::_id_10350("sa_empambush_slt_goodkillswetook");
  wait 3;
  scripts\sp\utility::_id_10350("sa_empambush_eth_captainwegotapr");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_go");
  wait 0.5;
  scripts\sp\utility::_id_10350("sa_empambush_eth_cerberusisbacka");
  wait 1;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_copyallscarsret");
  wait 10;
  scripts\sp\utility::_id_10350("sa_empambush_eth_sir20secondstil");
  level notify("final_countdown");
  wait 1;
  scripts\sp\utility::_id_10350("sa_empambush_slt_retcanttakearai");
  wait 2;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_gatorprepforeme");
  scripts\sp\utility::_id_10350("sa_empambush_gtr_ayesir");
}

_id_155B() {
  level waittill("ace_pilot_dead");
  scripts\sp\utility::_id_2669("ace1");
  level notify("ace1");
  wait 1;
  scripts\sp\utility::_id_10350("sa_empambush_plr_splashoneace");
  level waittill("ace_pilot_dead");
  scripts\sp\utility::_id_2669("ace2");
  level notify("ace2");
  wait 0.5;
  scripts\sp\utility::_id_10350("sa_empambush_slt_flightleaderdow");
  level waittill("ace_pilot_dead");
  scripts\sp\utility::_id_2669("ace3");
  level notify("ace3");
  wait 1;
  scripts\sp\utility::_id_10350("sa_empambush_slt_onlyonesquadron");
}

_id_A241() {
  var_0 = ["sa_empambush_slt_tiptopfightersr", "sa_empambush_slt_thesewingersgot", "sa_empambush_slt_acemyass2", "sa_empambush_slt_easypickinshuhr", "sa_empambush_slt_likehittncarniv", "sa_empambush_slt_thisthebestthey"];
  var_1 = 0;
  var_2 = 0;

  while(var_1 < var_0.size && !scripts\engine\utility::flag("dogfight_over")) {
    level waittill("jackal_dead");
    var_2++;

    if(var_2 >= 3 || randomfloat(100) < 30) {
      scripts\sp\utility::_id_10350(var_0[var_1]);
      var_1++;
      var_2 = 0;
      wait 3;
    }
  }
}

_id_3AEB() {
  level waittill("ace2");
  wait 4;
  scripts\sp\utility::_id_10350("sa_empambush_eth_captainbeadvise");
  wait 1;
  level.player scripts\sp\utility::_id_1034D("sa_empambush_plr_copythathalfbe");
  wait 2;
  scripts\sp\utility::_id_10350("sa_empambush_un2_roger11thanksfo");
}

_id_A83B() {
  level endon("kill_ret");
  level waittill("landing_hoop_active");
  childthread _id_A839();
  level waittill("player_jackal_drone_dock");
  scripts\sp\utility::_id_6EEA();
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  level notify("doing_landing");
  thread scripts\sp\utility::_id_10350("sa_empambush_slt_forcingdown");
  level waittill("notify_land_jet");
  setmusicstate("");
  _id_A83A();
  wait 2;
  scripts\sp\utility::_id_10350("sa_empambush_gtr_dropin321");
}

_id_A839() {
  scripts\sp\utility::_id_10350("sa_empambush_slt_letsgetintherer");
  wait 2;
  scripts\sp\utility::_id_1034D("sa_empambush_plr_inboundheavy");
}

_id_A83A() {
  wait 2;
  scripts\sp\utility::_id_10350("sa_empambush_slt_captainsonboard");
  wait 1;
  scripts\sp\utility::_id_1034D("sa_empambush_plr_bridgegofordrop");
}

_id_3CC7() {
  level endon("player_jackal_drone_dock");
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  self._id_6EBF = var_0 scripts\engine\utility::spawn_tag_origin();
  self._id_6EBF linkTo(self);
  self _meth_8277(0.5, 0.0);
  self _meth_8278(0.501187, 0.0);
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("railgun_charge_muzzle"), self._id_6EBF, "tag_origin");
  self playLoopSound("cerberus_railgun_charge_lp");
  self playSound("cerberus_railgun_charge_swt");
  wait 5;
  self _meth_8277(0.707106, 30.0);
  self _meth_8278(1.0, 15.0);
  thread _id_0EFF::_id_DC2A(level._id_FD6E._id_E35D.origin, 25);
  level waittill("kill_ret");
  self _meth_8277(2.0, 0.5);
  wait(randomfloat(0.25));
  var_1 = anglestoleft(self._id_6EBF.angles);
  var_2 = anglestoup(self._id_6EBF.angles);
  playFX(scripts\engine\utility::getfx("railgun_muzzleflash"), self._id_6EBF.origin + var_1 * 96 + var_2 * 16, anglesToForward(self._id_6EBF.angles));
  playFX(scripts\engine\utility::getfx("railgun_muzzleflash"), self._id_6EBF.origin + var_1 * -96 + var_2 * 16, anglesToForward(self._id_6EBF.angles));
  playFX(scripts\engine\utility::getfx("railgun_muzzleflash"), self._id_6EBF.origin + var_1 * 96 + var_2 * -16, anglesToForward(self._id_6EBF.angles));
  playFX(scripts\engine\utility::getfx("railgun_muzzleflash"), self._id_6EBF.origin + var_1 * -96 + var_2 * -16, anglesToForward(self._id_6EBF.angles));
  scripts\engine\utility::delaycall(randomfloatrange(0.05, 0.25), ::playsound, "cerberus_railgun_fire");
  wait 0.25;
  stopFXOnTag(scripts\engine\utility::getfx("railgun_charge_muzzle"), self._id_6EBF, "tag_origin");
  self _meth_8277(1.0, 0.1);
  self stoploopsound();
}

_id_52B6() {
  var_0 = getEntArray("carrier_railgun_turret", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_3CC7);
  level endon("player_jackal_drone_dock");
  level waittill("final_countdown");
  wait 20;
  level notify("kill_ret");
  wait 0.2;
  thread scripts\sp\utility::_id_10350("sa_empambush_gtr_shotsoutshotsou");
  wait 1.5;
  _id_577A();
}

_id_577A() {
  var_0 = level._id_FD6E._id_E35D;
  playFX(scripts\engine\utility::getfx("ret_explosion"), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  var_0 scripts\engine\utility::delaycall(randomfloatrange(0.05, 0.25), ::playsound, "cerberus_railgun_impact");
  screenshake(level.player getEye(), 0.4, 0.0, 0.0, 0.5, 0.0, 0.5, 0, 8, 0, 0);
  setomnvar("ui_death_hint", 50);
  wait 1;
  scripts\sp\utility::_id_B8D1();
  thread scripts\sp\hud_util::_id_6AA3(1, "black");
}

_id_10989() {
  self endon("death");

  for(;;) {
    var_0 = length(self.spaceship_vel);
    iprintln(scripts\sp\utility::string(var_0));
    scripts\engine\utility::waitframe();
  }
}

_id_9833() {
  objective_add(scripts\sp\utility::_id_C264("obj_kill_aces"), "current", &"SA_EMPAMBUSH_KILL_THE_SDF_ACE_PILOTS");
  level._id_1559 = [];
  level waittill("do_aces");
  _id_94D3();
  objective_current(scripts\sp\utility::_id_C264("obj_kill_aces"));
  scripts\engine\utility::flag_wait("dogfight_over");
  _id_0B76::_id_4474(0);
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_kill_aces"));
}

_id_DF1F() {
  self waittill("death");
  level notify("jackal_dead");
}

_id_168E() {
  var_0 = level._id_1559.size;
  level._id_1559[level._id_1559.size] = self;
  _id_0BDC::_id_A36D();
  self waittill("death");
  level notify("ace_pilot_dead");
  level._id_1559 = scripts\sp\utility::array_remove_index(level._id_1559, var_0);
  _id_94D3();
  _id_0B76::_id_F432(0, level._id_B419 - level._id_1559.size);
}

_id_94D3() {
  if(!scripts\engine\utility::is_true(level._id_1558)) {
    level._id_1558 = 1;
    level._id_B419 = 4;
    _id_0B76::_id_16FE(0, "jackal_objective_aces", level._id_B419);
  }
}

_id_5889(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 0;

  if(isDefined(var_3))
    level endon(var_3);

  if(!isDefined(var_2))
    var_2 = 0;

  var_0 = getEnt(var_0, "targetname");

  if(isDefined(var_0)) {
    if(!isDefined(var_1))
      var_1 = var_0.target;

    for(;;) {
      var_5 = var_0 scripts\sp\utility::_id_10808();
      var_5 _id_0BDC::_id_19B1(0);

      if(var_2)
        var_5 thread _id_168E();

      var_5 thread _id_0BDC::_id_A1EF(scripts\sp\utility::_id_7C9A(var_1));
      wait 1;
      var_5 _id_0BDC::_id_19B3("patrol", "axis_patrol");
      var_5 _id_0BDC::_id_19B3("combat", "axis_patrol");
      var_5 _id_0BDC::_id_19B3("escape", "axis_dogfight");

      if(var_4)
        var_5 _id_0BDC::_id_1990(1);

      var_5 waittill("death");
      var_2 = 0;
    }
  }
}

_id_E096() {
  self endon("death");
  self waittill("grapple_kill");
  _id_0F25::_id_113E2(0);
}

_id_FA88() {
  level.player._id_11400["tagging_fade_min"] = 500.0;
  level.player._id_11400["tagging_fade_max"] = 3000.0;
}

_id_1DF5() {}

_id_889C() {
  var_0 = getEntArray("0g_floater", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_6F3E);
  level waittill("stop_0g_floaters");

  foreach(var_2 in var_0) {
    var_2 notify("stop_floating");
    var_2 hide();
  }
}

_id_6F3E() {
  level endon("stop_0g_floaters");

  if(isDefined(self._id_6F43)) {
    return;
  }
  self._id_6F43 = 1;
  self show();
  var_0 = getEntArray(self.target, "targetname");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0)
    var_2 linkTo(self);
  }

  var_4 = scripts\sp\utility::_id_10639("ship_floater", self.origin, self.angles);
  var_4._id_1FBB = "ship_floater";
  var_4 thread scripts\sp\anim::_id_1EEA(var_4, self.animation, "stop_floating");
  self linkTo(var_4, "j_prop_1");
  var_5 = var_4 scripts\sp\utility::_id_7DC1(self.animation);
  var_5 = var_5[0];
  var_6 = randomfloatrange(0.8, 1.1);
  var_4 _meth_82B1(var_5, var_6);
  var_7 = randomfloatrange(0.0, 1.0);
  var_4 _meth_82B0(var_5, var_7);
}

_id_13E96() {
  scripts\engine\utility::flag_wait("entering_ship_interior");
  wait 3.0;
  thread _id_CF9F();
  var_0 = getEntArray("zerog_bay_dyn_models", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_linkto)) {
      var_3 = getEnt(var_2.script_linkto, "script_linkname");
      var_4 = var_3 scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
      wait 0.15;
      var_4 linkTo(var_2);
      var_3 delete();
    }

    if(isDefined(var_2.target)) {
      var_5 = scripts\engine\utility::getStruct(var_2.target, "targetname");
      var_2 moveTo(var_5.origin, 0.05);
      var_2 rotateTo(var_5.angles, 0.05);

      if(isDefined(var_5.script_noteworthy))
        var_2._id_BF0C = var_5.script_noteworthy;

      if(isDefined(var_5.script_angles))
        var_2._id_5CE1 = var_5.script_angles;

      wait 0.05;
    }

    var_2 thread _id_AA8A();
  }

  scripts\engine\utility::flag_wait("enemies_done_spawning");
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  scripts\sp\utility::_id_228A(var_0);
}

_id_CF9F() {
  while(!scripts\engine\utility::flag("enter_jackal")) {
    physicsexplosionsphere(level.player getEye(), 64, 63, 12);
    wait 0.05;
  }
}

_id_AA8A() {
  wait 0.05;
  var_0 = 1;

  if(isDefined(self.script_index))
    var_0 = self.script_index;

  var_1 = self.origin;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(self.script_angles)) {
    if(self.script_angles[0] != 0)
      var_2 = anglestoup(self.angles) * self.script_angles[0];

    if(self.script_angles[1] != 0)
      var_3 = anglesToForward(self.angles) * self.script_angles[1];

    if(self.script_angles[2] != 0)
      var_4 = anglestoright(self.angles) * self.script_angles[2];
  }

  if(isDefined(var_2))
    var_1 = var_1 + var_2;

  if(isDefined(var_3))
    var_1 = var_1 + var_3;

  if(isDefined(var_4))
    var_1 = var_1 + var_4;

  var_5 = var_1 + (0, 0, -24);

  if(isDefined(self.script_parameters)) {
    var_6 = strtok(self.script_parameters, " ");
    var_7 = float(var_6[0]);
    var_8 = float(var_6[1]);
    var_9 = float(var_6[2]);
    var_5 = self.origin + anglestoup(self.angles) * var_7 + anglesToForward(self.angles) * var_8 + anglestoright(self.angles) * var_9;
  }

  var_10 = vectorNormalize(var_5 - var_1);
  var_11 = (randomfloatrange(1.75, 3.25), 0, 0) * var_0;

  if(isDefined(self.script_noteworthy)) {
    var_12 = strtok(self.script_noteworthy, " ");
    var_13 = float(var_12[0]);
    var_14 = float(var_12[1]);
    var_15 = float(var_12[2]);
    var_11 = var_0 * var_10 * (var_13, var_14, var_15);
  }

  if(isDefined(self._id_EF20)) {}

  if(isDefined(self._id_EF15))
    wait(self._id_EF15);

  self physicslaunchserver(var_1, var_11);
}

_id_FA6C() {
  scripts\engine\utility::flag_wait("capital_ship_spawned");
  wait 1;
  var_0 = getEnt("mg_cannon_clip", "targetname");
  var_1 = getEnt("flak_cannon_clip", "targetname");

  foreach(var_3 in level._id_3965.turrets) {
    foreach(var_5 in var_3) {
      var_6 = var_1;

      if(var_5.type == "cap_turret_small_constant")
        var_6 = var_0;

      var_5 setCanDamage(0);
      var_7 = spawn("script_model", var_5.origin);
      var_7.angles = var_5.angles;
      var_7 linkTo(var_5, "tag_origin", (0, 0, 0), (0, 0, 0));
      var_7 clonebrushmodeltoscriptmodel(var_6);
      var_5 thread _id_40D5(var_7);
    }
  }
}

_id_40D5(var_0) {
  scripts\engine\utility::flag_wait("jackal_taking_off");
  self setCanDamage(1);
  var_0 delete();
}

_id_3A1B() {
  self waittill("death");
  _id_0A2F::_id_DA45("captain7");
}

_id_88E3() {
  level endon("emp_set");
  scripts\engine\utility::flag_wait("emp_overrun");
  var_0 = getEntArray("player_killer", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_A23F);
  var_1 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_F2D8, 1);
}

_id_A23F() {
  if(isDefined(self.script_parameters))
    wait(float(self.script_parameters));

  var_0 = scripts\sp\vehicle::_id_1080B();

  if(isDefined(self.script_noteworthy))
    wait(float(self.script_noteworthy));
  else
    wait(randomfloatrange(0.5, 1.5));

  var_0 _id_A345(0.75);
}

_id_8E91(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = getEntArray("0g_floater", "targetname");
  var_2 = getEnt("cargobay_doors", "targetname");

  if(var_0) {
    scripts\engine\utility::array_call(var_1, ::hide);
    var_2 hide();
  } else
    scripts\engine\utility::array_call(var_1, ::show);
}

_id_8949() {
  var_0 = getEntArray("0g_floater", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "prototype_colllision")
      var_2 delete();
  }
}

_id_52A8() {
  var_0 = getEntArray("script_model", "classname");

  foreach(var_2 in var_0) {
    if(var_2.model == "ship_exterior_light_unit_e_off")
      var_2 delete();
  }
}