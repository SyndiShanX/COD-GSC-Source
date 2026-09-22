/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_zombie_mp.gsc
******************************************/

init() {
  level thread zombies_init();
  level thread on_player_connect();
}

on_player_connect() {
  level waittill("connected", var_0);
  level notify("zombies_init");
  var_0._id_A9BA = [];
  var_0._id_A9BB = 0;
  var_0._id_76D8 = "";
  var_0._id_76D9 = -1;
  var_0.notifiedlootservice = 0;
  var_0._id_A9EB = [];
  var_0._id_A9DF = [];
  var_0._id_AC5D = [];
  var_0.besttimetrialtimes = [];
  var_0._id_7545 = [];
  var_0._id_00B7 = 0;
  var_0._id_014D = 0;
  var_0._id_5F7C = 0;
  var_0._id_9CFF = 0;
  var_0.zombiepointsearned = 0;
  var_0._id_4BF7 = 0;
  var_0._id_60EC = 0;
  var_0._id_4868 = 0;
  var_0.equipmentkills = 0;
  var_0.equipmentused = 0;
  var_0._id_394C = 0;
  var_0._id_6882 = 0;
  var_0._id_6881 = 0;
  var_0._id_178B = 0;
  var_0._id_68A0 = 0;
  var_0._id_7D10 = 0;
  var_0._id_AACE = 0;
  var_0._id_6F5F = 0;
  var_0._id_3295 = 0;
  var_0._id_90CC = 0;
  var_0._id_7E5F = 0;
  var_0._id_598C = 0;
  var_0._id_6E48 = 0;
  var_0._id_2AB8 = 0;
  var_0._id_99F8 = 0;
  var_0._id_32CD = 0;
  var_0._id_5BF3 = 0;
  var_0._id_8B3D = 0;
  var_0._id_8B33 = 0;
  var_0._id_4DC4 = 0;
  var_0._id_4DC5 = 0;
  var_0.switchtoweaponimmediate = [];
  var_0._id_3036 = 0;
  var_0._id_3034 = 0;
  var_0._id_4B7A = 0;
  var_0._id_7F1D = 0;
  var_0._id_7F1E = 0;
  var_0._id_99F8 = 0;
  var_0._id_32CD = 0;
  var_0._id_5BF3 = 0;
  var_0._id_5A52 = 0;
  var_0._id_4BF8 = 0;
  var_0._id_3963 = 0;
  var_0._id_178B = 0;
  var_0._id_32D1 = 0;
  var_0._id_5F7D = 0;
  var_0._id_6F60 = 0;
  var_0._id_3296 = 0;
  var_0._id_5F7D = 0;
  var_0._id_90CD = 0;
  var_0._id_7E60 = 0;
  var_0._id_598D = 0;
  var_0._id_6E49 = 0;
  var_0._id_3037 = 0;
  var_0._id_3035 = 0;
  var_0._id_4DE1 = 0;
  var_0._id_8B39 = 0;
  var_0.isonladder = 0;
  var_0._id_39E6 = 0;
  var_0._id_39E4 = 0;
  level._id_745F = level.players.size;
  var_0._id_7F11 = 0;
  var_0._id_7F06 = 0;
  var_0._id_7EFE = 0;
  var_0._id_7F09 = 0;
  var_0._id_7F10 = 0;
  var_0._id_7F07 = 0;
  var_0._id_7F04 = 0;
  var_0._id_7F0B = 0;
  var_0._id_7F0D = 0;
  var_0._id_7F08 = 0;
  var_0._id_801C = 0;
  var_0._id_39E5 = 0;
  var_0._id_39E3 = 0;
  var_0._id_AC30 = [];
}

#using_animtree("mp_zombie_generic");

zombies_init_generic() {
  var_0 = "mp_zombie_generic";
  level._id_0A41["mp_zombie_generic"] = level._id_0A41["zombie"];
  level._id_0A41["mp_zombie_generic"]["think"] = _id_0566::_id_ABB3;
  level._id_0A41["mp_zombie_generic"]["on_damaged"] = _id_0566::_id_ABB2;
  level._id_0A41["mp_zombie_generic"]["get_action_params"] = _id_0566::zombie_generic_get_action_params;
  var_1 = ["jfull_zom_head_fdr02_org1", "jfull_zom_head_fdr03_org1", "jfull_zom_head_fdr04_org1"];
  var_2 = ["zom_m40helmet_net1", "zom_m40helmet_org1", "zom_m40helmet_org2"];
  var_3 = ["zom_m34cap_org1", "zom_m40officercap_org1", "zom_m42cap_org1", "zom_m43cap_org1", "zom_m43cap_org2", "zom_m43overseacap_org1"];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = spawnStruct();
  var_7._id_5ED2["guts"]["whole_body"] = "jfull_zom_infantrya_bodywhole";
  var_7._id_5ED2["guts"]["torso"] = "jfull_zom_infantrya_torso_slice";
  var_7._id_5ED2["guts"]["left_arm"] = "jfull_zom_infantrya_l_arm_slice";
  var_7._id_5ED2["guts"]["left_leg"] = "jfull_zom_infantrya_l_leg_slice";
  var_7._id_5ED2["guts"]["right_arm"] = "jfull_zom_infantrya_r_arm_slice";
  var_7._id_5ED2["guts"]["right_leg"] = "jfull_zom_infantrya_r_leg_slice";
  var_7._id_5ED2["guts"]["heads"] = var_1;
  var_7._id_5ED2["guts"]["caps"] = var_3;
  var_7._id_5ED2["guts"]["helmets"] = var_2;
  var_7._id_5ED2["guts"]["facegear"] = var_6;
  var_7._id_5ED2["poncho"]["whole_body"] = "jfull_zom_snipera_bodywhole";
  var_7._id_5ED2["poncho"]["torso"] = "jfull_zom_snipera_torso_slice";
  var_7._id_5ED2["poncho"]["left_arm"] = "jfull_zom_snipera_l_arm_slice";
  var_7._id_5ED2["poncho"]["left_leg"] = "jfull_zom_snipera_l_leg_slice";
  var_7._id_5ED2["poncho"]["right_arm"] = "jfull_zom_snipera_r_arm_slice";
  var_7._id_5ED2["poncho"]["right_leg"] = "jfull_zom_snipera_r_leg_slice";
  var_7._id_5ED2["poncho"]["heads"] = var_1;
  var_7._id_5ED2["poncho"]["caps"] = var_3;
  var_7._id_5ED2["poncho"]["helmets"] = var_2;
  var_7._id_5ED2["poncho"]["facegear"] = var_6;
  var_7._id_5ED2["possum"]["whole_body"] = "jfull_zom_infantrya_bodywhole";
  var_7._id_5ED2["possum"]["torso"] = "jfull_zom_infantrya_torso_slice";
  var_7._id_5ED2["possum"]["left_arm"] = "jfull_zom_infantrya_l_arm_slice";
  var_7._id_5ED2["possum"]["left_leg"] = "jfull_zom_infantrya_l_leg_slice";
  var_7._id_5ED2["possum"]["right_arm"] = "jfull_zom_infantrya_r_arm_slice";
  var_7._id_5ED2["possum"]["right_leg"] = "jfull_zom_infantrya_r_leg_slice";
  var_7._id_5ED2["possum"]["heads"] = ["jfull_zom_head_fdr02_org1"];
  var_7._id_5ED2["possum"]["request only"] = 1;
  var_7._id_5ED2["soldier"]["whole_body"] = "jfull_zom_inf_smga_org1_mm3";
  var_7._id_5ED2["soldier"]["request only"] = 1;
  var_7._id_5ED2["soldier_rus"]["whole_body"] = "jfull_zom_rus_infantry_org1";
  var_7._id_5ED2["soldier_rus"]["request only"] = 1;
  var_7._id_0A4B = "mp_zombie_generic";
  var_7._id_0EAE = "mp_zombie_animclass";
  var_7._id_0879 = "mp_zombie_generic";
  var_7._id_4C12 = 1;
  var_7._id_60E2 = 40;
  var_7._id_8302 = 65;
  var_7._id_8303 = 15;
  var_7.suppressive_fire_speed_multiplier = 0.3;
  var_7.tacklebymelee = 1;
  var_7.tacklebycharge = 1;
  var_7.knockbyravensword = 1;
  var_7.shockbyteslablood = 1;
  var_7.knockbybladebarbarossa = 1;

  if(isDefined(level._id_62AB)) {
    var_7 = [[level._id_62AB]](var_7);
  }

  _id_0547::_id_0A52(var_7, "mp_zombie_generic");
  _id_0547::registeranimtree("mp_zombie_generic", #animtree);
}

zombies_init() {
  level waittill("zombies_init");
  setDvar("5819", 1);
  maps\mp\gametypes\zombies::_id_5372();
  level._id_0A41["zombie"] = level._id_0A41["player"];
  level._id_0A41["zombie"]["onAIConnect"] = _id_0547::_id_6AB7;
  level._id_0A41["zombie"]["on_killed"] = ::_id_6BD4;
  level._id_0A41["zombie"]["on_damaged"] = ::_id_6BD1;
  level._id_0A41["zombie"]["on_damaged_finished"] = _id_054D::_id_6BD3;
  level._id_0A41["zombie"]["is_hit_weak_point"] = _id_054D::_id_5714;
  level._id_0A41["zombie"]["spawn"] = ::_id_6BD7;
  level._id_0A41["zombie"]["think"] = _id_0547::_id_0A58;
  level._id_0A41["zombie"]["on_mutilate"] = _id_054D::_id_AC35;
  level._id_0A41["zombie"]["get_action_params"] = _id_054D::_id_AC22;
  level._id_0A41["zombie"]["move_mode"] = ::updatezombiemovemode;
  level._id_0A41["zombie"]["post_model"] = _id_054D::_id_AC1E;
  level._id_0A41["zombie"]["tesla_delayed_dmg"] = _id_054D::zombietesladelayeddmg;
  zombies_init_generic();
  level._id_0A41["mp_zombie_generic"]["on_damaged"] = ::_id_6BD1;
  _createthreatbiasgroup("zombies");
  level._id_087D = ["s2", "t7", "s1"];
  maps\mp\agents\_scripted_agent_anim_util::_id_5159("mp_zombie_generic");
  level._id_2775 = 0;
  level._id_2FDD = [];
  level._id_66BF = 0;
  level._id_37E6 = [];
  level._id_3772 = "hostile";
  level._id_6F43 = 0;
  _id_0542::_id_5329();
  _id_0541::main();
  _id_055A::init();
  level thread _id_055A::_id_6B3F();
  level thread _id_4ACC();
  _id_055A::_id_088A();
  level._id_071D.global_threat_scalar = 1;
  level._snd_num_players_in_combat = 4;
  level._id_071D.map_wave_music_master_volume_scalar = 1.0;
  level._id_071D.zombie_vox_attack_hit_prev_time = 0;
  level._id_071D.zombie_vox_attack_hit_wait_time_min = 3;
  level._id_071D.zombie_vox_attack_hit_wait_time_max = 5;
  level._id_071D.zombie_vox_attack_hit_wait_time = _randomintrange(2, 4);
  level._id_071D.zombie_vox_attack_hit_req_names = ["attack_hit", "anim_sprint_attack_1", "anim_sprint_attack_2", "anim_sprint_attack_3", "anim_stand_attack_1", "anim_stand_attack_2", "anim_stand_attack_3"];
  level._effect["torso_arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_le");
  level._effect["torso_arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_ri");
  level._effect["torso_head_loss"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_2");
  level._effect["torso_head_loss_p_melee_fdr_02"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_02");
  level._effect["torso_head_loss_p_melee_fdr_03"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_03");
  level._effect["torso_head_loss_p_melee_fdr_04"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_04");
  level._effect["zmb_paired_melee_head_pop_fdr_02"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_02");
  level._effect["zmb_paired_melee_head_pop_fdr_03"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_03");
  level._effect["zmb_paired_melee_head_pop_fdr_04"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_04");
  level._effect["torso_loss_head_p_melee_spr_01"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_spr_01");
  level._effect["zmb_paired_melee_head_pop_spr_01"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_spr_01");
  level._effect["torso_head_loss_small"] = loadfx("vfx/blood/dlc_zombie_torso_squirt_up");
  level._effect["torso_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_le");
  level._effect["torso_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_ri");
  level._effect["arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_le");
  level._effect["arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_ri");
  level._effect["head_gibs"] = loadfx("vfx/blood/zom_head_impact_01");
  level._effect["limb_loss_left"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_le");
  level._effect["limb_loss_right"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_ri");
  level._effect["gib_full_body"] = loadfx("vfx/blood/dlc_zombie_gib_full_body");
  level._effect["gib_full_body_cheap"] = loadfx("vfx/blood/dlc_zombie_gib_full_body_cheap");
  level._effect["gib_bloodpool"] = loadfx("vfx/blood/dlc_zombie_blood_tread_fx");
  level._effect["crawl_dust"] = loadfx("vfx/treadfx/DLC/crawl_dust");
  level._effect["nuke_blast"] = loadfx("vfx/gameplay/mp/zombie/zombie_nuke_burst");
  level._effect["zombieSpawn"] = loadfx("vfx/unique/infected_turn_lightning_01");
  level._id_666C = 2;
  level._id_ABD3 = -1000;
  level._id_A980 = 0;
  level.zombiearray = [];
}

_id_4ACC() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_begin");
    setDvar("5819", 1);
  }
}

spawnzombiesforteam(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = _id_054D::_id_90BA("mp_zombie_generic", var_0, "test", 0, 0, 1, undefined, 0);

    if(isDefined(var_4)) {
      playFX(common_scripts\utility::_id_44F5("zombieSpawn"), var_4.origin);
      var_4 editzombiestats();
      var_4.ispassiveexempt = 1;
      var_4 _id_0547::disableoffhandsecondaryweapons();
      level.zombiearray[level.zombiearray.size] = var_4;
      var_4 thread dozombiethings();

      if(level.gametype == "undead") {
        var_4 handlezombieaggro(level.players, ::quicksort_hardpoint_dist_compare);
      }
    }

    waitframe();
  }
}

quicksort_hardpoint_dist_compare(var_0, var_1) {
  return _distance2dsquared(var_0.origin, level._id_AC7C.origin) < _distance2dsquared(var_1.origin, level._id_AC7C.origin);
}

killallzombies() {
  if(!isDefined(level.zombiearray) || level.zombiearray.size == 0) {
    return;
  }
  foreach(var_1 in level.zombiearray) {
    playFX(common_scripts\utility::_id_44F5("zombieSpawn"), var_1.origin);
    _id_0378::_id_8D74("aud_zombie_spawn", var_1.origin);
    var_1 suicide();
  }
}

editzombiestats() {
  self._id_60E2 = 50;
  self.maxhealth = 175;
  self.health = int(self.maxhealth);
  var_0 = spawnStruct();
  var_0._id_90F0 = 1.0;
  self._id_1CF1["speed_buff"] = var_0;
}

dozombiethings() {
  self endon("death");
  level endon("game_ended");
  self playSound("zvox_gen_spawn");

  for(;;) {
    switch (randomint(7)) {
      case 0:
        self playSound("zvox_gen_snarl");
        break;
      case 1:
        self playSound("zvox_gen_growl_lev1");
        break;
      case 2:
        self playSound("zvox_gen_growl_lev2");
        break;
      case 3:
        self playSound("zvox_gen_growl_lev3");
        break;
      case 4:
        self playSound("zvox_gen_growl_lev4");
        break;
      case 5:
        self playSound("zvox_gen_sneakattack_success");
        break;
      case 6:
        self playSound("zvox_gen_taunt");
        break;
      default:
        self playSound("zvox_gen_snarl");
        break;
    }

    wait(_randomfloatrange(0.5, 2.0));
  }
}

handlezombieaggro(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(maps\mp\_utility::isreallyalive(var_4)) {
      var_2[var_2.size] = var_4;
    }
  }

  var_2 = common_scripts\utility::_id_7897(var_2, var_1);
  maps\mp\agents\humanoid\_humanoid_util::_id_867E(var_2[0]);
}

changezombieallegiance(var_0) {
  if(level.zombiearray.size == 0) {
    return;
  }
  if(level.zombiearray[0].team == var_0) {
    return;
  }
  for(var_1 = 0; var_1 < level.zombiearray.size; var_1++) {
    level.zombiearray[var_1] hudoutlinedisableforclients(level.players);
    level.zombiearray[var_1].team = var_0;

    foreach(var_3 in level.players) {
      if(var_3.team == var_0) {
        continue;
      }
      level.zombiearray[var_1] hudoutlineenableforclient(var_3, 1, 1);
    }
  }
}

updatezombiemovemode() {
  return "sprint";
}

_id_6BD7(var_0, var_1, var_2) {
  _id_0547::_id_6BAA(var_0, var_1, var_2);
  self._id_220D = _id_054D::_id_6BD0;
  self._id_648E = common_scripts\utility::random(getarraykeys(level._id_087E["mp_zombie_generic"]["move_style"]));
  _id_0378::_id_8D74("onZombieSpawn");
  thread _id_0547::_id_4A58();
  var_3 = _id_0547::_id_AC4B(self.origin, "spawn");
  var_3 _id_0547::_id_AC48("agent_type", self._id_0A4B);
  var_3 _id_0547::_id_AC4D();

  if(isDefined(level._id_AC60[self._id_0A4B])) {
    level._id_AC60[self._id_0A4B]++;
  }

  thread _id_054D::_id_ABE0();
}

_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  self playSound("zvox_gen_pain_lrg");

  if(var_4 == "MOD_BURNED") {
    var_2 = int(var_2 * 1.5);
  }

  if(isDefined(var_5) && maps\mp\_utility::getweaponclass(var_5) == "weapon_other" && !issubstr(var_5, "riotshield_mp")) {
    var_2 = 666;
  }

  maps\mp\agents\_agents::_id_6A73(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_6BD4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self playSound("zvox_gen_death1");
  var_1 _id_04C7::_id_A102("killshot_nosound");
  level.zombiearray = common_scripts\utility::_id_0F93(level.zombiearray, self);
  _id_0547::_id_6B9E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  _id_054D::_id_90BC(self._id_08D9, var_3, var_4);

  if(isPlayer(var_1)) {
    if(!isDefined(var_1.pers["zombieKills"])) {
      var_1.pers["zombieKills"] = 0;
    }

    var_1.pers["zombieKills"]++;

    if(level.gametype == "undead") {
      if(var_1 istouching(level._id_AC7C._id_9D5E)) {
        _id_04D2::_id_47BD(var_1.team, 1, 1);
        level thread maps\mp\gametypes\_rank::_id_1457("undead_zombie_killed_hp", var_1, var_4, undefined, var_3);
      } else
        level thread maps\mp\gametypes\_rank::_id_1457("undead_zombie_killed", var_1, var_4, undefined, var_3);

      level maps\mp\gametypes\undead::attemptdropteslagun(self.origin);
      var_1 maps\mp\_utility::_id_867C(var_1.pers["zombieKills"]);
    }

    var_1 _id_0468::ae_sendzombiekillevent(var_4, var_3);
  }
}