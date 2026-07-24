/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_hill_intro.gsc
************************************************************/

_id_10C7F() {
  scripts\engine\utility::flag_init("flag_airlock_door_open");
  scripts\engine\utility::flag_init("flag_burning_man_door_closed");
  scripts\engine\utility::flag_init("flag_hill_intro_init");
  scripts\engine\utility::flag_init("flag_airlock_door_open_clear");
  var_0 = ["salter", "griff", "ethan", "brooks"];
  level._id_1493 = scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_hill_intro");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_hill_intro", "targetname"));
  scripts\engine\utility::flag_set("flag_hill_intro_init");
  level thread scripts\sp\maps\marsbase\marsbase_burning_man::_id_3B46();
  level thread scripts\sp\maps\marsbase\marsbase_burning_man::_id_3B45();
  level thread scripts\sp\maps\marsbase\marsbase_burning_man::_id_CC7A();
  scripts\sp\utility::_id_28D7();
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_6E55("flag_airlock_door_open", scripts\sp\utility::_id_28D8);
  scripts\sp\utility::_id_15F5("orbit_canyon1");
  level.player thread scripts\sp\maps\marsbase\marsbase_burning_man::_id_329B();
  scripts\engine\utility::flag_set("flag_enter_burning_tunnel");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa2_complete");
}

_id_B1F9() {
  scripts\engine\utility::flag_init("flag_hill_c8s_destroyed");
  scripts\engine\utility::flag_init("flag_redshirt_kill_c12_scene_done");
  scripts\sp\utility::_id_10FEC("vfx_exp_turret_three");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A8("fxanim_sp_mars_crane");
  _id_16E9();
  level thread scripts\sp\maps\marsbase\marsbase_hill_battle::_id_3A80();

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  scripts\engine\utility::flag_wait("flag_airlock_door_open");
  scripts\engine\utility::delaythread(1.5, scripts\sp\utility::_id_15F5, "hill_intro_allies_enter_colortrig");
  thread _id_6E85();
  scripts\sp\utility::_id_2669("Hill Intro");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_127B1("hill_battle_lower_left_elevator_spawntrig", scripts\sp\maps\marsbase\marsbase_hill_battle::_id_8F21);
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_4");
  level.gun["aa_gun_3"] thread scripts\sp\maps\marsbase\marsbase_code::_id_14E2(undefined, 3, 1);
  level.gun["aa_gun_4"] thread scripts\sp\maps\marsbase\marsbase_code::_id_14E2(undefined, 3, 1);
  var_0 = scripts\sp\utility::_id_77DA("enemies_aa2");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 delete();
    }
  }

  level notify("aa2_jackals_stop");

  if(scripts\engine\utility::flag_exist("flag_hill_intro_init")) {
    scripts\engine\utility::flag_wait("flag_hill_intro_init");
  }

  scripts\sp\maps\marsbase\marsbase_util::_id_F3B6();
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5458();
  var_4 = scripts\sp\maps\marsbase\marsbase_util::_id_10626(["mccallum"], "ally_start_hill_intro");
  level._id_B4F1 scripts\sp\utility::_id_F3B5("p");
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_intro_redshirt_floodspawn");
  scripts\engine\utility::flag_wait("flag_airlock_door_open_clear");
  level notify("loot_crate_aa2_cleanup");
  scripts\sp\utility::_id_15F5("hill_intro_allies_enter_colortrig");
  level thread _id_CDDA();
  scripts\sp\maps\marsbase\marsbase_util::_id_6F56("hill_intro_left_rooftop_floodspawn");
  scripts\engine\utility::flag_wait("flag_hill_allies_intro");
  scripts\engine\utility::flag_wait("flag_redshirt_kill_c12_scene_done");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_1080A("hill_intro_atv", undefined, scripts\sp\maps\marsbase\marsbase_util::_id_B39B);
  scripts\engine\utility::flag_set("flag_hill_intro_end");
}

_id_6E85() {
  wait 8;
  setmusicstate("");
}

_id_8F8D() {
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_airlock_door_open");
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_hill_intro_init");
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_redshirt_kill_c12_scene_done");
  scripts\engine\utility::flag_set("flag_hill_intro_end");
  level thread _id_16E9();
  level thread _id_1026C();
  scripts\sp\utility::_id_228A(getEntArray("hill_intro_ents", "script_noteworthy"));
}

_id_8F91() {
  self endon("death");
  scripts\sp\utility::_id_5131();
  var_0 = self.origin;
  wait 2;
  scripts\sp\utility::_id_1101B();
  scripts\engine\utility::flag_wait("flag_hill_c8s_destroyed");
  scripts\sp\utility::_id_F3E0(16);
  self setgoalpos(var_0);
  self waittill("goal");
  self delete();
}

_id_16E9() {
  var_0 = scripts\sp\utility::_id_77DA("hill_battle_middle_lower_lmg_sniper");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_1747, ::_id_8F8F);
}

_id_8F8F() {
  scripts\engine\utility::flag_wait("flag_hill_battle_lower_fallback");
  scripts\sp\utility::_id_F3B5("o");
}

_id_101B1() {}

_id_8F93() {
  self endon("death");
  var_0 = getEnt(self.target, "targetname");
  var_0 rotateYaw(90, 1.5, 0.5, 0.5);
  var_0 waittill("rotatedone");
  self waittill("trigger");

  for(;;) {
    wait 0.05;
    var_1 = getaiarray("axis");
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(isalive(var_4) && var_4 istouching(self)) {
        var_2++;
      }
    }

    if(var_2 > 0) {
      continue;
    }
    break;
  }

  var_0 rotateYaw(-90, 1.5, 0.5, 0.5);
  var_0 waittill("rotatedone");
  var_1 = getaiarray("axis");

  foreach(var_4 in var_1) {
    if(isalive(var_4) && var_4 istouching(self)) {
      var_4 dodamage(var_4.maxhealth, var_0.origin);
    }
  }

  self delete();
}

_id_CDDA() {
  var_0 = scripts\engine\utility::getStruct("struct_hill_mccallum", "targetname");
  var_1 = getspawnerarray("hill_intro_c12_redshirts");
  var_2 = [];
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_1747, ::_id_8F90);

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] = var_4 scripts\sp\utility::_id_10619(1);
  }

  var_6 = getEnt("hill_intro_c12_hero_redshirt", "targetname");
  var_7 = var_6 scripts\sp\utility::_id_10619(1, 1);
  var_7._id_1FBB = "hill_hero_redshirt";
  var_0 thread scripts\sp\anim::_id_1EC3(var_7, "anim_hill_intro_eng_kill_c12");
  var_8 = getEnt("enemy_hill_intro_c12", "script_noteworthy");
  var_9 = var_8 scripts\engine\utility::get_target_ent();
  var_8.target = undefined;
  var_10 = scripts\engine\utility::getStruct("struct_hill_intro_c12_aim", "targetname") scripts\engine\utility::spawn_tag_origin();
  var_11 = scripts\engine\utility::getStruct("struct_hill_intro_c12_aim2", "targetname") scripts\engine\utility::spawn_tag_origin();
  var_12 = scripts\engine\utility::getStruct("struct_hill_intro_c12_kill_shot", "targetname") scripts\engine\utility::spawn_tag_origin();
  var_13 = scripts\engine\utility::getStruct("struct_hill_intro_c12_kill_shot2", "targetname") scripts\engine\utility::spawn_tag_origin();
  var_14 = var_8 scripts\sp\utility::_id_10619(1);
  var_14 notify("stop_going_to_node");
  var_14 scripts\sp\maps\marsbase\marsbase_util::_id_9312();
  var_14 scripts\sp\utility::_id_B14F();
  var_14 scripts\sp\utility::_id_F492(1.1, 0.05);
  var_14 _id_0A05::_id_3551(0);
  var_14 _id_0A05::_id_360C(30);
  var_15 = spawnStruct();
  var_15.partname = "left_arm";
  var_15.subpartname = "upper";
  var_14 _id_0A05::_id_3540();
  var_14 _id_0C09::_id_5673(var_15);

  for(var_5 = 0; var_5 < 4; var_5++) {
    var_10 thread _id_6AD6(var_14);
  }

  scripts\engine\utility::flag_wait("flag_airlock_door_open_clear");
  var_14 scripts\sp\utility::_id_1101B();
  var_14 scripts\sp\utility::_id_1160F(var_9);
  scripts\engine\utility::flag_wait("flag_hill_allies_intro");
  var_14 _id_0A05::_id_360C(10);
  var_14 _id_0A05::_id_360D("left", var_12, undefined, 0);
  var_14 _id_0A05::_id_360D("right", var_13, undefined, 0);
  var_7.ignoreall = 1;
  var_7.ignoreme = 1;
  var_7.goalradius = 16;
  var_0 thread _id_8F8E(var_7);
  var_14 _id_0A05::_id_352D("left");
  var_14 _id_0A05::_id_352D("right");
  var_14 _id_0A05::_id_360D("right", [var_7, var_12, var_13], undefined, 0);
  level waittill("Fspar_on");
  var_7 _meth_851D(var_14);
  var_14 scripts\engine\utility::delaythread(0.75, ::_id_8F8C, 2, var_7 getorigin());
  level waittill("Fspar_off");
  var_7 _meth_851E();
  var_14 _id_0A05::_id_352D("right");
  level notify("notify_stop_fake_ally_fire");
  var_15.partname = "right_arm";
  var_15.subpartname = "upper";
  var_14 thread _id_0A05::_id_3540();
  var_14 thread _id_0C09::_id_5673(var_15);
  var_10 delete();
  var_11 delete();
  var_12 delete();
  var_13 delete();
  var_2 = scripts\sp\utility::_id_22B9(var_2);
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_61C7);
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_F3B5, "b");
  scripts\engine\utility::flag_set("flag_redshirt_kill_c12_scene_done");
}

_id_8F8E(var_0) {
  var_0 scripts\sp\utility::_id_86E4();
  var_0 scripts\sp\utility::_id_72EC("iw7_steeldragon", "primary");
  thread scripts\sp\anim::_id_1F35(var_0, "anim_hill_intro_eng_kill_c12");
  level waittill("fspar_land");
  var_0 scripts\sp\utility::_id_86E4();
  var_0 thread _id_10F7D();
  self waittill("anim_hill_intro_eng_kill_c12");
  var_0._id_10265 = 1;
  var_0 scripts\engine\utility::delaythread(0.1, scripts\sp\maps\marsbase\marsbase_util::_id_A62C);
  scripts\sp\anim::_id_1EE0(var_0, "anim_hill_intro_eng_kill_c12");
}

_id_8F8C(var_0, var_1) {
  self endon("death");
  var_2 = ["tag_missile_bottom_le", "tag_missile_top_le", "tag_missile_bottom_ri", "tag_missile_top_ri"];
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);
  var_3 = undefined;
  var_4 = undefined;

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = scripts\engine\utility::ter_op(isDefined(var_1[var_5]), var_1[var_5], var_3);
    var_7 = scripts\engine\utility::ter_op(isDefined(var_2[var_5]), var_2[var_5], var_4);
    var_8 = magicbullet(self.primaryweapon, self gettagorigin(var_7), var_6);
    wait 0.4;
    var_3 = var_6;
    var_4 = var_7;
  }
}

_id_8F90() {
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_54F7();
}

_id_1026C() {
  var_0 = getEnt("enemy_hill_intro_c12", "script_noteworthy");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_2 = scripts\engine\utility::getStruct("hill_intro_c12_death_spot", "targetname");
  var_1 _meth_80F1(var_2.origin, var_2.angles);
  var_1 _meth_81D0();
  _id_1026E();
}

_id_6AD6(var_0) {
  level endon("notify_stop_fake_ally_fire");
  var_1 = self.origin + (0, randomfloatrange(-64, 64), randomfloatrange(-32, 32));

  for(;;) {
    var_2 = (var_0.origin[0], var_0.origin[1], var_0.origin[2] + randomfloatrange(12, 100));

    if(isDefined(var_2)) {
      magicbullet("iw7_ar57", var_1, var_2);
      bullettracer(var_1, var_2, "iw7_ar57", 1);
    }

    wait(randomfloatrange(0.05, 0.5));
  }
}

_id_10F7C(var_0, var_1) {
  self waittill("shooting");
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2 linkTo(self, "tag_flash", (0, 0, 0), (0, 0, 0));

  for(var_3 = 0; var_3 < 1; var_3 = var_3 + 0.05) {
    var_4 = self gettagorigin("tag_flash");
    var_5 = var_4 + anglesToForward(self gettagangles("tag_flash")) * length(var_0.origin - var_4);
    var_6 = randomfloatrange(0.25, 0.75);
    var_7 = randomfloatrange(0.25, 0.75);
    var_8 = randomfloatrange(0.25, 0.75);
    scripts\engine\utility::waitframe();
  }
}

_id_10F7D() {
  var_0 = spawn("weapon_iw7_steeldragon", self gettagorigin("tag_weapon_right"));
  var_0.angles = self gettagangles("tag_weapon_right");
  var_0 itemweaponsetammo(150, 150);
  level.player thread _id_8F95(var_0);
}

_id_1026E() {
  var_0 = scripts\engine\utility::getStruct("struct_hill_mccallum", "targetname");
  var_1 = getEnt("hill_intro_c12_hero_redshirt", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1 scripts\sp\utility::_id_10619(1);

  if(!isalive(var_2)) {
    return;
  }
  var_2 endon("death");
  var_2._id_1FBB = "hill_hero_redshirt";
  var_0 thread scripts\sp\anim::_id_1F35(var_2, "anim_hill_intro_eng_kill_c12");
  var_3 = var_2 scripts\sp\utility::_id_7DC1("anim_hill_intro_eng_kill_c12");
  var_2 _meth_82B1(var_3, 100);
  level waittill("fspar_land");
  var_4 = spawn("weapon_iw7_steeldragon", var_2 gettagorigin("tag_weapon_right"));
  var_4.angles = var_2 gettagangles("tag_weapon_right");
  level.player thread _id_8F95();
}

_id_8F95(var_0) {
  self endon("death");
  level endon("steel_dragon_pickup_timeout");
  wait 4.0;
  scripts\sp\utility::_id_65E0("flag_hill_intro_player_pickup_steeldragon");

  if(!level.player hasweapon("iw7_steeldragon")) {
    thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5459();
  }

  while(!level.player hasweapon("iw7_steeldragon")) {
    self waittill("weapon_change", var_1);
  }

  scripts\sp\utility::_id_65E1("flag_hill_intro_player_pickup_steeldragon");
}

_id_3B74() {
  var_0 = getvehiclenode("hill_intro_atv_end_node", "script_noteworthy");
  var_1 = scripts\sp\utility::_id_8200("hill_intro_atv", "targetname");
  var_1 scripts\sp\utility::_id_1747(scripts\sp\maps\marsbase\marsbase_util::_id_B39B);
  var_2 = var_1 scripts\sp\utility::_id_10808();
  var_2 scripts\engine\utility::delaythread(0.5, ::_id_B39C, var_0);

  foreach(var_4 in var_2._id_E4FB) {
    var_4 _meth_81D0();
  }
}

_id_B39C(var_0) {
  self vehicle_teleport(var_0.origin, var_0.angles);
}