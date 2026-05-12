/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_zombie_mp.gsc
*********************************************/

func_00D5() {
  level thread zombies_init();
  level thread on_player_connect();
}

on_player_connect() {
  level waittill("connected", var_00);
  level notify("zombies_init");
  var_00.var_A9BA = [];
  var_00.var_A9BB = 0;
  var_00.var_76D8 = "";
  var_00.var_76D9 = -1;
  var_00.notifiedlootservice = 0;
  var_00.var_A9EB = [];
  var_00.var_A9DF = [];
  var_00.var_AC5D = [];
  var_00.besttimetrialtimes = [];
  var_00.var_7545 = [];
  var_00.var_00B7 = 0;
  var_00.var_014D = 0;
  var_00.var_5F7C = 0;
  var_00.var_9CFF = 0;
  var_00.zombiepointsearned = 0;
  var_00.var_4BF7 = 0;
  var_00.var_60EC = 0;
  var_00.var_4868 = 0;
  var_00.equipmentkills = 0;
  var_00.equipmentused = 0;
  var_00.var_394C = 0;
  var_00.var_6882 = 0;
  var_00.var_6881 = 0;
  var_00.var_178B = 0;
  var_00.var_68A0 = 0;
  var_00.var_7D10 = 0;
  var_00.var_AACE = 0;
  var_00.var_6F5F = 0;
  var_00.var_3295 = 0;
  var_00.var_90CC = 0;
  var_00.var_7E5F = 0;
  var_00.var_598C = 0;
  var_00.var_6E48 = 0;
  var_00.var_2AB8 = 0;
  var_00.var_99F8 = 0;
  var_00.var_32CD = 0;
  var_00.var_5BF3 = 0;
  var_00.var_8B3D = 0;
  var_00.var_8B33 = 0;
  var_00.var_4DC4 = 0;
  var_00.var_4DC5 = 0;
  var_00.var_831B = [];
  var_00.var_3036 = 0;
  var_00.var_3034 = 0;
  var_00.var_4B7A = 0;
  var_00.var_7F1D = 0;
  var_00.var_7F1E = 0;
  var_00.var_99F8 = 0;
  var_00.var_32CD = 0;
  var_00.var_5BF3 = 0;
  var_00.var_5A52 = 0;
  var_00.var_4BF8 = 0;
  var_00.var_3963 = 0;
  var_00.var_178B = 0;
  var_00.var_32D1 = 0;
  var_00.var_5F7D = 0;
  var_00.var_6F60 = 0;
  var_00.var_3296 = 0;
  var_00.var_5F7D = 0;
  var_00.var_90CD = 0;
  var_00.var_7E60 = 0;
  var_00.var_598D = 0;
  var_00.var_6E49 = 0;
  var_00.var_3037 = 0;
  var_00.var_3035 = 0;
  var_00.var_4DE1 = 0;
  var_00.var_8B39 = 0;
  var_00.var_801D = 0;
  var_00.var_39E6 = 0;
  var_00.var_39E4 = 0;
  level.var_745F = level.var_744A.size;
  var_00.var_7F11 = 0;
  var_00.var_7F06 = 0;
  var_00.var_7EFE = 0;
  var_00.var_7F09 = 0;
  var_00.var_7F10 = 0;
  var_00.var_7F07 = 0;
  var_00.var_7F04 = 0;
  var_00.var_7F0B = 0;
  var_00.var_7F0D = 0;
  var_00.var_7F08 = 0;
  var_00.var_801C = 0;
  var_00.var_39E5 = 0;
  var_00.var_39E3 = 0;
  var_00.var_AC30 = [];
}

zombies_init_generic() {
  var_00 = "mp_zombie_generic";
  level.var_0A41["mp_zombie_generic"] = level.var_0A41["zombie"];
  level.var_0A41["mp_zombie_generic"]["think"] = ::lib_0566::func_ABB3;
  level.var_0A41["mp_zombie_generic"]["on_damaged"] = ::lib_0566::func_ABB2;
  level.var_0A41["mp_zombie_generic"]["get_action_params"] = ::lib_0566::zombie_generic_get_action_params;
  var_01 = ["jfull_zom_head_fdr02_org1", "jfull_zom_head_fdr03_org1", "jfull_zom_head_fdr04_org1"];
  var_02 = ["zom_m40helmet_net1", "zom_m40helmet_org1", "zom_m40helmet_org2"];
  var_03 = ["zom_m34cap_org1", "zom_m40officercap_org1", "zom_m42cap_org1", "zom_m43cap_org1", "zom_m43cap_org2", "zom_m43overseacap_org1"];
  var_04 = [];
  var_05 = [];
  var_06 = [];
  var_07 = spawnStruct();
  var_07.var_5ED2["guts"]["whole_body"] = "jfull_zom_infantrya_bodywhole";
  var_07.var_5ED2["guts"]["torso"] = "jfull_zom_infantrya_torso_slice";
  var_07.var_5ED2["guts"]["left_arm"] = "jfull_zom_infantrya_l_arm_slice";
  var_07.var_5ED2["guts"]["left_leg"] = "jfull_zom_infantrya_l_leg_slice";
  var_07.var_5ED2["guts"]["right_arm"] = "jfull_zom_infantrya_r_arm_slice";
  var_07.var_5ED2["guts"]["right_leg"] = "jfull_zom_infantrya_r_leg_slice";
  var_07.var_5ED2["guts"]["heads"] = var_01;
  var_07.var_5ED2["guts"]["caps"] = var_03;
  var_07.var_5ED2["guts"]["helmets"] = var_02;
  var_07.var_5ED2["guts"]["facegear"] = var_06;
  var_07.var_5ED2["poncho"]["whole_body"] = "jfull_zom_snipera_bodywhole";
  var_07.var_5ED2["poncho"]["torso"] = "jfull_zom_snipera_torso_slice";
  var_07.var_5ED2["poncho"]["left_arm"] = "jfull_zom_snipera_l_arm_slice";
  var_07.var_5ED2["poncho"]["left_leg"] = "jfull_zom_snipera_l_leg_slice";
  var_07.var_5ED2["poncho"]["right_arm"] = "jfull_zom_snipera_r_arm_slice";
  var_07.var_5ED2["poncho"]["right_leg"] = "jfull_zom_snipera_r_leg_slice";
  var_07.var_5ED2["poncho"]["heads"] = var_01;
  var_07.var_5ED2["poncho"]["caps"] = var_03;
  var_07.var_5ED2["poncho"]["helmets"] = var_02;
  var_07.var_5ED2["poncho"]["facegear"] = var_06;
  var_07.var_5ED2["possum"]["whole_body"] = "jfull_zom_infantrya_bodywhole";
  var_07.var_5ED2["possum"]["torso"] = "jfull_zom_infantrya_torso_slice";
  var_07.var_5ED2["possum"]["left_arm"] = "jfull_zom_infantrya_l_arm_slice";
  var_07.var_5ED2["possum"]["left_leg"] = "jfull_zom_infantrya_l_leg_slice";
  var_07.var_5ED2["possum"]["right_arm"] = "jfull_zom_infantrya_r_arm_slice";
  var_07.var_5ED2["possum"]["right_leg"] = "jfull_zom_infantrya_r_leg_slice";
  var_07.var_5ED2["possum"]["heads"] = ["jfull_zom_head_fdr02_org1"];
  var_07.var_5ED2["possum"]["request only"] = 1;
  var_07.var_5ED2["soldier"]["whole_body"] = "jfull_zom_inf_smga_org1_mm3";
  var_07.var_5ED2["soldier"]["request only"] = 1;
  var_07.var_5ED2["soldier_rus"]["whole_body"] = "jfull_zom_rus_infantry_org1";
  var_07.var_5ED2["soldier_rus"]["request only"] = 1;
  var_07.var_0A4B = "mp_zombie_generic";
  var_07.var_0EAE = "mp_zombie_animclass";
  var_07.var_0879 = "mp_zombie_generic";
  var_07.var_4C12 = 1;
  var_07.var_60E2 = 40;
  var_07.var_8302 = 65;
  var_07.var_8303 = 15;
  var_07.suppressive_fire_speed_multiplier = 0.3;
  var_07.tacklebymelee = 1;
  var_07.tacklebycharge = 1;
  var_07.knockbyravensword = 1;
  var_07.shockbyteslablood = 1;
  var_07.knockbybladebarbarossa = 1;
  if(isDefined(level.var_62AB)) {
    var_07 = [[level.var_62AB]](var_07);
  }

  lib_0547::func_0A52(var_07, "mp_zombie_generic");
  lib_0547::registeranimtree("p_zombie_generic", #animtree);
}

zombies_init() {
  level waittill("zombies_init");
  setDvar("5819", 1);
  maps\mp\gametypes\zombies::func_5372();
  level.var_0A41["zombie"] = level.var_0A41["player"];
  level.var_0A41["zombie"]["onAIConnect"] = ::lib_0547::func_6AB7;
  level.var_0A41["zombie"]["on_killed"] = ::func_6BD4;
  level.var_0A41["zombie"]["on_damaged"] = ::func_6BD1;
  level.var_0A41["zombie"]["on_damaged_finished"] = ::lib_054D::func_6BD3;
  level.var_0A41["zombie"]["is_hit_weak_point"] = ::lib_054D::func_5714;
  level.var_0A41["zombie"]["spawn"] = ::func_6BD7;
  level.var_0A41["zombie"]["think"] = ::lib_0547::func_0A58;
  level.var_0A41["zombie"]["on_mutilate"] = ::lib_054D::func_AC35;
  level.var_0A41["zombie"]["get_action_params"] = ::lib_054D::func_AC22;
  level.var_0A41["zombie"]["move_mode"] = ::updatezombiemovemode;
  level.var_0A41["zombie"]["post_model"] = ::lib_054D::func_AC1E;
  level.var_0A41["zombie"]["tesla_delayed_dmg"] = ::lib_054D::zombietesladelayeddmg;
  zombies_init_generic();
  level.var_0A41["mp_zombie_generic"]["on_damaged"] = ::func_6BD1;
  createthreatbiasgroup("zombies");
  level.var_087D = ["s2", "t7", "s1"];
  maps\mp\agents\_scripted_agent_anim_util::func_5159("mp_zombie_generic");
  level.var_2775 = 0;
  level.var_2FDD = [];
  level.var_66BF = 0;
  level.var_37E6 = [];
  level.var_3772 = "hostile";
  level.var_6F43 = 0;
  lib_0542::func_5329();
  lib_0541::func_00F9();
  lib_055A::func_00D5();
  level thread lib_055A::func_6B3F();
  level thread func_4ACC();
  lib_055A::func_088A();
  level.var_071D.global_threat_scalar = 1;
  level._snd_num_players_in_combat = 4;
  level.var_071D.map_wave_music_master_volume_scalar = 1;
  level.var_071D.zombie_vox_attack_hit_prev_time = 0;
  level.var_071D.zombie_vox_attack_hit_wait_time_min = 3;
  level.var_071D.zombie_vox_attack_hit_wait_time_max = 5;
  level.var_071D.zombie_vox_attack_hit_wait_time = randomintrange(2, 4);
  level.var_071D.zombie_vox_attack_hit_req_names = ["attack_hit", "anim_sprint_attack_1", "anim_sprint_attack_2", "anim_sprint_attack_3", "anim_stand_attack_1", "anim_stand_attack_2", "anim_stand_attack_3"];
  level.var_0611["torso_arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_le");
  level.var_0611["torso_arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_ri");
  level.var_0611["torso_head_loss"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_2");
  level.var_0611["torso_head_loss_p_melee_fdr_02"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_02");
  level.var_0611["torso_head_loss_p_melee_fdr_03"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_03");
  level.var_0611["torso_head_loss_p_melee_fdr_04"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_04");
  level.var_0611["zmb_paired_melee_head_pop_fdr_02"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_02");
  level.var_0611["zmb_paired_melee_head_pop_fdr_03"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_03");
  level.var_0611["zmb_paired_melee_head_pop_fdr_04"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_04");
  level.var_0611["torso_loss_head_p_melee_spr_01"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_spr_01");
  level.var_0611["zmb_paired_melee_head_pop_spr_01"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_spr_01");
  level.var_0611["torso_head_loss_small"] = loadfx("vfx/blood/dlc_zombie_torso_squirt_up");
  level.var_0611["torso_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_le");
  level.var_0611["torso_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_ri");
  level.var_0611["arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_le");
  level.var_0611["arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_ri");
  level.var_0611["head_gibs"] = loadfx("vfx/blood/zom_head_impact_01");
  level.var_0611["limb_loss_left"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_le");
  level.var_0611["limb_loss_right"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_ri");
  level.var_0611["gib_full_body"] = loadfx("vfx/blood/dlc_zombie_gib_full_body");
  level.var_0611["gib_full_body_cheap"] = loadfx("vfx/blood/dlc_zombie_gib_full_body_cheap");
  level.var_0611["gib_bloodpool"] = loadfx("vfx/blood/dlc_zombie_blood_tread_fx");
  level.var_0611["crawl_dust"] = loadfx("vfx/treadfx/DLC/crawl_dust");
  level.var_0611["nuke_blast"] = loadfx("vfx/gameplay\mp\zombie/zombie_nuke_burst");
  level.var_0611["zombieSpawn"] = loadfx("vfx/unique/infected_turn_lightning_01");
  level.var_666C = 2;
  level.var_ABD3 = -1000;
  level.var_A980 = 0;
  level.zombiearray = [];
}

func_4ACC() {
  level endon("game_ended");
  for(;;) {
    level waittill("host_migration_begin");
    setDvar("5819", 1);
  }
}

spawnzombiesforteam(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < param_01; var_03++) {
    var_04 = lib_054D::func_90BA("mp_zombie_generic", param_00, "test", 0, 0, 1, undefined, 0);
    if(isDefined(var_04)) {
      playFX(common_scripts\utility::func_44F5("zombieSpawn"), var_04.var_0116);
      var_04 editzombiestats();
      var_04.ispassiveexempt = 1;
      var_04 lib_0547::func_84CB();
      level.zombiearray[level.zombiearray.size] = var_04;
      var_04 thread dozombiethings();
      if(level.var_3FDC == "undead") {
        var_04 handlezombieaggro(level.var_744A, ::quicksort_hardpoint_dist_compare);
      }
    }

    wait 0.05;
  }
}

quicksort_hardpoint_dist_compare(param_00, param_01) {
  return distance2dsquared(param_00.var_0116, level.var_AC7C.var_0116) < distance2dsquared(param_01.var_0116, level.var_AC7C.var_0116);
}

killallzombies() {
  if(!isDefined(level.zombiearray) || level.zombiearray.size == 0) {
    return;
  }

  foreach(var_01 in level.zombiearray) {
    playFX(common_scripts\utility::func_44F5("zombieSpawn"), var_01.var_0116);
    lib_0378::func_8D74("aud_zombie_spawn", var_01.var_0116);
    var_01 suicide();
  }
}

editzombiestats() {
  self.var_60E2 = 50;
  self.var_00FB = 175;
  self.var_00BC = int(self.var_00FB);
  var_00 = spawnStruct();
  var_00.var_90F0 = 1;
  self.var_1CF1["speed_buff"] = var_00;
}

dozombiethings() {
  self endon("death");
  level endon("game_ended");
  self method_8617("zvox_gen_spawn");
  for(;;) {
    switch (randomint(7)) {
      case 0:
        self method_8617("zvox_gen_snarl");
        break;

      case 1:
        self method_8617("zvox_gen_growl_lev1");
        break;

      case 2:
        self method_8617("zvox_gen_growl_lev2");
        break;

      case 3:
        self method_8617("zvox_gen_growl_lev3");
        break;

      case 4:
        self method_8617("zvox_gen_growl_lev4");
        break;

      case 5:
        self method_8617("zvox_gen_sneakattack_success");
        break;

      case 6:
        self method_8617("zvox_gen_taunt");
        break;

      default:
        self method_8617("zvox_gen_snarl");
        break;
    }

    wait(randomfloatrange(0.5, 2));
  }
}

handlezombieaggro(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_00) {
    if(maps\mp\_utility::func_57A0(var_04)) {
      var_02[var_02.size] = var_04;
    }
  }

  var_02 = common_scripts\utility::func_7897(var_02, param_01);
  maps\mp\agents\humanoid\_humanoid_util::func_867E(var_02[0]);
}

changezombieallegiance(param_00) {
  if(level.zombiearray.size == 0) {
    return;
  }

  if(level.zombiearray[0].var_01A7 == param_00) {
    return;
  }

  for(var_01 = 0; var_01 < level.zombiearray.size; var_01++) {
    level.zombiearray[var_01] hudoutlinedisableforclients(level.var_744A);
    level.zombiearray[var_01].var_01A7 = param_00;
    foreach(var_03 in level.var_744A) {
      if(var_03.var_01A7 == param_00) {
        continue;
      }

      level.zombiearray[var_01] hudoutlineenableforclient(var_03, 1, 1);
    }
  }
}

updatezombiemovemode() {
  return "sprint";
}

func_6BD7(param_00, param_01, param_02) {
  lib_0547::func_6BAA(param_00, param_01, param_02);
  self.var_220D = ::lib_054D::func_6BD0;
  self.var_648E = common_scripts\utility::func_7A33(getarraykeys(level.var_087E["mp_zombie_generic"]["move_style"]));
  lib_0378::func_8D74("onZombieSpawn");
  thread lib_0547::func_4A58();
  var_03 = lib_0547::func_AC4B(self.var_0116, "spawn");
  var_03 lib_0547::func_AC48("agent_type", self.var_0A4B);
  var_03 lib_0547::func_AC4D();
  if(isDefined(level.var_AC60[self.var_0A4B])) {
    level.var_AC60[self.var_0A4B]++;
  }

  thread lib_054D::func_ABE0();
}

func_6BD1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  self method_8617("zvox_gen_pain_lrg");
  if(param_04 == "MOD_BURNED") {
    param_02 = int(param_02 * 1.5);
  }

  if(isDefined(param_05) && maps\mp\_utility::func_472A(param_05) == "weapon_other" && !issubstr(param_05, "riotshield_mp")) {
    param_02 = 666;
  }

  maps\mp\agents\_agents::func_6A73(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

func_6BD4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self method_8617("zvox_gen_death1");
  param_01 maps\mp\gametypes\_damagefeedback::func_A102("killshot_nosound");
  level.zombiearray = common_scripts\utility::func_0F93(level.zombiearray, self);
  lib_0547::func_6B9E(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  lib_054D::func_90BC(self.var_08D9, param_03, param_04);
  if(isPlayer(param_01)) {
    if(!isDefined(param_01.var_012C["zombieKills"])) {
      param_01.var_012C["zombieKills"] = 0;
    }

    param_01.var_012C["zombieKills"]++;
    if(level.var_3FDC == "undead") {
      if(param_01 istouching(level.var_AC7C.var_9D5E)) {
        maps\mp\gametypes\_gamescore::func_47BD(param_01.var_01A7, 1, 1);
        level thread maps\mp\gametypes\_rank::func_1457("undead_zombie_killed_hp", param_01, param_04, undefined, param_03);
      } else {
        level thread maps\mp\gametypes\_rank::func_1457("undead_zombie_killed", param_01, param_04, undefined, param_03);
      }

      level maps\mp\gametypes\undead::attemptdropteslagun(self.var_0116);
      param_01 maps\mp\_utility::func_867C(param_01.var_012C["zombieKills"]);
    }

    param_01 lib_0468::ae_sendzombiekillevent(param_04, param_03);
  }
}