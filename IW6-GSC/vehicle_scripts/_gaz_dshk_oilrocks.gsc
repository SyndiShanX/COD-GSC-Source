/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_gaz_dshk_oilrocks.gsc
**************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("gaz_tigr_turret_oilrocks", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_drive( % humvee_50cal_driving_idle_forward, % humvee_50cal_driving_idle_backward, 10);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(::setanims_turret, ::set_vehicle_anims);
  maps\_vehicle::build_turret("dshk_gaz", "tag_turret", "weapon_dshk_turret", undefined, "auto_ai", 0.2, -20, -14);
  maps\_vehicle::build_bulletshield(1);
  build_gaz_death(var_2);
}

init_local() {
  self.animname = "gaz_dshk";
  self.script_explosive_bullet_shield = 1;
  self.allowdeath = 0;
  self.is_anim_based_death = 1;
  self.has_unmatching_deathmodel_rig = 1;
  self.death_fx_on_self = 1;
  self.anim_is_death = 1;
  self.dont_finish_death = 1;
  thread feelgoodapachegundeath();
}

feelgoodapachegundeath() {
  if(!isDefined(level.apache_difficulty)) {
    return;
  }
  self endon("death");
  wait 0.5;
  var_0 = 0;

  while(var_0 < level.apache_difficulty.zpu_magic_bullets) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(maps\_vehicle::is_godmode()) {
      continue;
    }
    if(var_5 == "MOD_EXPLOSIVE_BULLET")
      var_0++;

    if(var_2 == level.player) {
      break;
    }
  }

  maps\_vehicle::force_kill();
}

unload_groups() {
  var_0 = [];
  var_1 = "passengers";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_1 = "all_but_gunner";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_1 = "rear_driver_side";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 2;
  var_1 = "gunner";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 3;
  var_1 = "all";
  var_0[var_1] = [];
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0[var_1][var_0[var_1].size] = 2;
  var_0[var_1][var_0[var_1].size] = 3;
  var_0["default"] = var_0["all"];
  return var_0;
}

build_gaz_death(var_0) {
  maps\_vehicle::build_deathmodel("vehicle_gaz_tigr_base_oilrocks", "vehicle_gaz_tigr_b_iw6_explosion");
  set_death_anim_scene();
  maps\_vehicle::build_radiusdamage((0, 0, 32), 300, 200, 0, 0);
}

set_death_anim_scene() {
  var_0 = "exp_armor_vehicle";
  death_a( % gaz_tigr_explode_a, "gaz_explode_singleV1", var_0);
  death_b( % gaz_tigr_explode_b, "gaz_explode_singleV2", var_0);
  death_c( % gaz_tigr_explode_c, "gaz_explode_singleV3", var_0);
  death_d( % gaz_tigr_explode_d, "gaz_explode_singleV4", var_0);
  maps\_vehicle::build_deathanim(["gaz_explode_singleV1", "gaz_explode_singleV2", "gaz_explode_singleV3", "gaz_explode_singleV4"]);
}

death_d(var_0, var_1, var_2) {
  maps\_anim::create_anim_scene(#animtree, var_1, var_0, "gaz_dshk");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_engine", "vfx/gameplay/vehicles/gaz_tigr/gaz_explosion_primary");
  maps\_anim::note_track_start_sound("start", var_2, 1);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_01", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_01_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_04", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_04_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_05", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_05_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_07", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_07_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_08", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_08_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_11", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_11_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_16", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_16_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_18", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_18_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_19", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_19_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_20", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_20_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_22", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_22_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_24", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_24_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
}

death_c(var_0, var_1, var_2) {
  maps\_anim::create_anim_scene(#animtree, var_1, var_0, "gaz_dshk");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_engine", "vfx/gameplay/vehicles/gaz_tigr/gaz_explosion_primary");
  maps\_anim::note_track_start_sound("start", var_2, 1);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_07", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_07_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_16", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_16_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_18", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_18_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_19", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_19_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_23", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_23_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_24", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_24_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
}

death_b(var_0, var_1, var_2) {
  maps\_anim::create_anim_scene(#animtree, var_1, var_0, "gaz_dshk");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_engine", "vfx/gameplay/vehicles/gaz_tigr/gaz_explosion_primary");
  maps\_anim::note_track_start_sound("start", var_2, 1);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_wheel_02", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_02_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_07", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_07_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_08", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_08_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_16", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_16_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_18", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_18_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_19", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_19_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_22", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_22_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_24", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_24_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
}

death_a(var_0, var_1, var_2) {
  maps\_anim::create_anim_scene(#animtree, var_1, var_0, "gaz_dshk");
  maps\_anim::note_track_start_fx_on_tag("start", "tag_fx_debr_engine", "vfx/gameplay/vehicles/gaz_tigr/gaz_explosion_primary");
  maps\_anim::note_track_start_sound("start", var_2, 1);
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_wheel_04", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_04_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_07", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_07_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_08", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_08_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_16", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_16_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_18", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_18_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_19", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_19_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
  maps\_anim::note_track_trace_to_efx("start", undefined, "tag_gaz_tigr_b_iw6_piece_24", "vfx/gameplay/vehicles/gaz_tigr/gaz_piece_24_1s", "vfx/gameplay/vehicles/gaz_tigr/gaz_watersplash_small");
}

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % gaz_dismount_frontl_door;
  var_0[1].vehicle_getoutanim = % gaz_dismount_frontr_door;
  var_0[2].vehicle_getoutanim = % gaz_dismount_backl_door;
  var_0[3].vehicle_getoutanim = % gaz_dismount_backr_door;
  var_0[0].vehicle_getinanim = % gaz_mount_frontl_door;
  var_0[1].vehicle_getinanim = % gaz_mount_frontr_door;
  var_0[2].vehicle_getinanim = % gaz_enter_back_door;
  var_0[3].vehicle_getinanim = % gaz_enter_back_door;
  var_0[0].vehicle_getoutsound = "gaz_door_open";
  var_0[1].vehicle_getoutsound = "gaz_door_open";
  var_0[2].vehicle_getoutsound = "gaz_door_open";
  var_0[3].vehicle_getoutsound = "gaz_door_open";
  var_0[0].vehicle_getinsound = "gaz_door_close";
  var_0[1].vehicle_getinsound = "gaz_door_close";
  var_0[2].vehicle_getinsound = "gaz_door_close";
  var_0[3].vehicle_getinsound = "gaz_door_close";
  return var_0;
}

set_vehicle_anims_turret(var_0) {
  var_0[3].vehicle_getoutanim = % gaz_turret_getout_gaz;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].sittag = "tag_driver";
  var_0[1].sittag = "tag_passenger";
  var_0[2].sittag = "tag_guy0";
  var_0[3].sittag = "tag_guy1";
  var_0[0].bhasgunwhileriding = 0;
  var_0[0].death = % gaz_dismount_frontl;
  var_0[0].death_no_ragdoll = 1;
  var_0[0].idle = % gaz_idle_frontl;
  var_0[1].idle = % gaz_idle_frontr;
  var_0[2].idle = % gaz_idle_backl;
  var_0[3].idle = % gaz_idle_backr;
  var_0[0].getout = % gaz_dismount_frontl;
  var_0[1].getout = % gaz_dismount_frontr;
  var_0[2].getout = % gaz_dismount_backl;
  var_0[3].getout = % gaz_dismount_backr;
  var_0[0].getin = % gaz_mount_frontl;
  var_0[1].getin = % gaz_mount_frontr;
  var_0[2].getin = % gaz_enter_backr;
  var_0[3].getin = % gaz_enter_backl;
  return var_0;
}

setanims_turret() {
  var_0 = setanims();
  var_0[3].mgturret = 0;
  var_0[3].passenger_2_turret_func = ::gaz_turret_guy_gettin_func;
  var_0[3].sittag = "tag_guy_turret";
  var_0[3].getout = % gaz_turret_getout_guy1;
  var_0 = set_vehicle_anims_turret(var_0);
  return var_0;
}