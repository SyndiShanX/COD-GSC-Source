/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_cargobay.gsc
********************************************************/

_id_E938() {
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_10626();
  thread _id_0F16::_id_3E3E("hallway_start");
  thread _id_0F16::_id_3E3D("hallway_start", undefined, 1);
  thread _id_0F16::_id_8EA3();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_3A83();
  visionsetalternate(5, 0);
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(1);
  visionsetalternate(5, 0);
  level._id_E99E["server_room_exit_door"]._id_C611 = 1;
  scripts\engine\utility::flag_set("fleet_data_downloaded");

  if(isDefined(level._id_9DD0))
    scripts\engine\utility::flag_set("start_e3_from_hallway");

  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(0, 1);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("hero_kill_start");
  level thread _id_0E4B::_id_1348D(1);
  var_0 = getEntArray("delete_for_exfil", "targetname");

  if(isDefined(var_0))
    scripts\engine\utility::array_call(var_0, ::delete);

  scripts\sp\utility::_id_F44E(1);
}

_id_E936() {
  thread samoon_inside_music();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_3A82();
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132BC(1);
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132CA(0);
  scripts\sp\utility::_id_266F();
  thread _id_E939();
  thread _id_8883();
  thread _id_8E2E("hallway_hero_kill_pos", "hero_kill", "hero_kill_start");
  thread _id_887D();
  thread _id_887C();
  level._id_EA2C.ignoreall = 1;
  thread _id_887B();
  scripts\engine\utility::waitframe();
  thread scripts\sp\utility::_id_12641("sa_moon_cargobay_tr");
  thread scripts\sp\utility::_id_12641("sa_moon_exfil_tr");
  level._id_6754 waittillmatch("single anim", "glass_break");
  level.player allowoffhandshieldweapons(1);
  scripts\engine\utility::flag_wait("hallway_wave2");
  level._id_E99E["armory_loot_room_door_01"]._id_4D94._id_885A = 3;
  level._id_EA2C scripts\sp\utility::_id_51E1("cqb");
  level._id_EA2C.ignoreall = 0;
  var_0 = getEnt("hallway_ally_move2", "targetname");

  if(isDefined(var_0))
    scripts\sp\utility::_id_15F1("hallway_ally_move2", "targetname");

  scripts\engine\utility::flag_wait("hallway_wave3");
  var_1 = scripts\sp\utility::_id_22CD("hallway_runners3", 1);
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132B2(1);
  thread _id_8885();
  level._id_E99E["turkeyshoot_room_exit_door"] thread _id_0F05::_id_AED6(0);
  scripts\engine\utility::flag_wait("cargobay_kickoff");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(0);
  thread _id_672D(180, 120);
  waitforalltransients();
  scripts\engine\utility::flag_wait("sa_moon_cargobay_tr_loaded");
  thread scripts\sp\maps\sa_moon\sa_moon_exfil::_id_F905();
  thread _id_0B1E::_id_59BE("bulkheadsdf_left");
  thread _id_28B2();
  thread _id_C9F3();
  thread _id_C9EB();
  thread _id_C9EF();
  level waittill("door_peek_start");
  setumbraportalstate("cargobay_peek_door", 1);
  var_2 = level.player getcurrentweapon();
  var_3 = level.player getweaponammoclip(var_2);
  var_4 = weaponclipsize(var_2);
  level.player setweaponammoclip(var_2, var_4);
  thread _id_C9EC();
  thread _id_C9F2();
  scripts\engine\utility::flag_set("stealth_enabled");
  scripts\engine\utility::flag_wait("turkeyshoot_alerted");
  scripts\engine\utility::flag_clear("stealth_enabled");
  thread _id_88A2();
}

samoon_inside_music() {
  wait 5;
  setmusicstate("mx_076_moonbase_insidecombat");
}

_id_88A2() {
  scripts\sp\utility::_id_15F1("cargobay_entrance_ally_move", "targetname");
  wait 3;
  scripts\sp\utility::_id_15F1("cargobay_entrance_ally_move1", "targetname");
  scripts\engine\utility::flag_wait("turkeyshoot_over");
  scripts\sp\utility::_id_15F1("cargobay_entrance_ally_move2", "targetname");
}

_id_E939() {
  scripts\engine\utility::flag_wait("hallway_vo_start");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_8899(85, 0.05);
  scripts\sp\utility::_id_10350("mn_fer_areas_spooling");
  scripts\sp\utility::_id_1034D("mn_plr_howmuchtime");
  scripts\sp\utility::_id_10350("mn_fer_under3mikes");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_8897(3);
  scripts\sp\utility::_id_1034D("mn_plr_go_weapons_free");
  wait 0.5;
  thread _id_672F(1, 180);
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_10350("mn_fer_danger_close");
  scripts\engine\utility::flag_wait("hallway_wave3");
  thread _id_E978();
  scripts\sp\utility::_id_1034D("mn_plr_through_doors_222");
  wait 4;
  level._id_C47F scripts\sp\utility::_id_10346("mn_omr_near_strut");
  scripts\engine\utility::flag_wait("cargobay_kickoff");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_1034D("mn_plr_hold_up_224");
  wait 0.25;
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_on_you_reyes");
}

_id_E978() {
  _id_0F00::_id_CDBD("mn_paa_firecontrolcompromised", 1);
  wait 4.0;
  _id_0F00::_id_CDBD("mn_paa_alldecksallstations", 1);
}

_id_C9F2() {
  scripts\engine\utility::flag_wait("turkeyshoot_alerted");

  if(!scripts\engine\utility::flag("turkeyshoot_over"))
    scripts\sp\utility::_id_1034D("mn_plr_go_232");

  scripts\engine\utility::flag_wait("turkeyshoot_over");
  wait 0.25;
  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_clear_241");
}

_id_8883() {
  var_0 = scripts\engine\utility::getStruct("hallway_hero_kill_pos", "targetname");
  thread _id_8E2D("hero_kill_enemy1", "generic", "hallway_hero_kill_pos", "hero_kill_enemy1", "hero_kill_start");
  thread _id_8E2D("hero_kill_enemy2", "generic", "hallway_hero_kill_pos", "hero_kill_enemy2", "hero_kill_start");
  level._id_C47F._id_1FBB = "omar";
  level._id_6754._id_1FBB = "ethan";
  level._id_C47F thread _id_1CC8();
  level._id_6754 thread _id_1CC8();
  var_0 thread scripts\sp\anim::_id_1F17(level._id_C47F, "hero_kill");
  var_0 thread scripts\sp\anim::_id_1F17(level._id_6754, "hero_kill");
  scripts\engine\utility::flag_wait("hero_kill_start");
  level._id_E99E["server_room_exit_door"] _id_0F05::_id_12BD3(0);
  level._id_E99E["server_room_exit_door"]._id_C611 = 1;
  level._id_C47F scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_F3B5, "r");
  level._id_6754 scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_F3B5, "b");
  level._id_EA2C scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_F3B5, "g");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_C47F, "hero_kill");
  var_0 scripts\sp\anim::_id_1F35(level._id_6754, "hero_kill");
  scripts\engine\utility::flag_set("hero_kill_over");
  level._id_C47F thread _id_1CC9();
  level._id_6754 thread _id_1CC9();
  level._id_EA2C thread _id_1CC9();
  level._id_6754.grenadeammo = 0;
  level._id_C47F.grenadeammo = 0;
  level._id_EA2C.grenadeammo = 0;
  level._id_EA2C thread scripts\sp\coverwall::_id_551C();
  level._id_C47F thread scripts\sp\coverwall::_id_551C();
  level._id_6754 thread scripts\sp\coverwall::_id_551C();
}

_id_8E2D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEnt(var_0, "targetname");
  var_6 = var_5 scripts\sp\utility::_id_10619(1);
  var_6._id_1FBB = var_1;
  var_6 scripts\sp\utility::_id_B14F();
  var_6 _meth_84AE();
  var_6._id_BFE4 = 1;
  var_6 thread scripts\sp\coverwall::_id_596D();
  var_7 = scripts\engine\utility::getStruct(var_2, "targetname");
  scripts\engine\utility::waitframe();
  var_7 thread scripts\sp\anim::_id_1EC3(var_6, var_3);
  scripts\engine\utility::flag_wait(var_4);
  var_7 scripts\sp\anim::_id_1F35(var_6, var_3);

  if(isDefined(var_6) && isalive(var_6)) {
    var_6 scripts\sp\utility::_id_1101B();
    var_6 scripts\sp\utility::_id_F2A8(1);
    var_6 scripts\sp\utility::_id_86E4();
    var_6.noragdoll = 1;
    var_6.a.nodeath = 1;
    var_6 scripts\sp\utility::_id_54C6();
  }
}

_id_8E2E(var_0, var_1, var_2) {
  var_3 = getEnt("hero_kill_glass", "targetname");
  var_4 = getEnt("hero_kill_glass_broke", "targetname");
  var_4 hide();
  var_5 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_6 = scripts\sp\utility::_id_10639("hero_kill_window");
  var_5 thread scripts\sp\anim::_id_1EC3(var_6, var_1);
  var_6 hide();
  scripts\engine\utility::flag_wait(var_2);
  var_5 thread scripts\sp\anim::_id_1F35(var_6, var_1);
  level._id_6754 waittillmatch("single anim", "glass_break");
  var_6 show();
  scripts\engine\utility::exploder("vfx_sa_moon_herokill");
  var_3 delete();
  var_4 show();
}

_id_887B() {
  var_0 = getEnt("hall_dead_body", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619("true");
  var_2 = scripts\engine\utility::getStruct("dead_guy_pos", "targetname");
  var_1._id_1FBB = "generic";
  var_1.ignoreme = 1;
  var_1 scripts\sp\utility::_id_86E4();
  var_1 scripts\sp\utility::_id_F2A8(1);
  var_1.noragdoll = 1;
  var_1.a.nodeath = 1;
  var_2 thread scripts\sp\anim::_id_1F35(var_1, "hall_body");
  scripts\engine\utility::waitframe();
  var_1 scripts\sp\utility::_id_54C6();
  scripts\engine\utility::flag_wait("hallway_door_close");
}

_id_8885() {
  var_0 = getaiarray("axis");

  if(isDefined(var_0) && var_0.size > 0) {
    scripts\sp\utility::_id_13754(var_0, var_0.size - 3, 25);
    scripts\sp\maps\sa_moon\sa_moon_util::_id_E352("hallway_runner_vol3", "hallway_runner_vol5");
  }
}

_id_887C() {
  level endon("hallway_door_close");
  var_0 = getEnt("hallway_door_close_vol", "targetname");
  var_1 = scripts\engine\utility::getStruct("hallway_door_close_pos", "targetname");
  var_2 = getEnt("hallway_door_left", "targetname");
  var_3 = getEnt("hallway_door_left_clip", "targetname");
  var_3 linkTo(var_2);
  var_4 = getEnt("hallway_door_right", "targetname");
  var_5 = getEnt("hallway_door_right_clip", "targetname");
  var_5 linkTo(var_4);

  for(;;) {
    if(level.player istouching(var_0) && level._id_C47F istouching(var_0) && level._id_EA2C istouching(var_0) && level._id_6754 istouching(var_0)) {
      var_4 moveTo(var_1.origin, 0.5);
      var_2 moveTo(var_1.origin, 0.5);
      scripts\engine\utility::flag_set("hallway_door_close");
      scripts\sp\maps\sa_moon\sa_moon_fx::_id_132CA(0);
      scripts\sp\maps\sa_moon\sa_moon_fx::_id_132CF(0);
      scripts\sp\maps\sa_moon\sa_moon_fx::_id_132BC(0);
    }

    wait 0.5;
  }
}

_id_887D() {
  level endon("hallway_door_close");
  var_0 = scripts\engine\utility::getStruct("hallway_door_spark", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  var_2 = getEnt("hallway_door_left_panel", "targetname");
  var_3 = getEnt("hallway_door_left", "targetname");
  var_4 = getEnt("hallway_door_left_clip", "targetname");
  var_4 linkTo(var_3);
  var_2 linkTo(var_3);
  var_2 thread _id_8884();
  var_5 = getEnt("hallway_door_right", "targetname");
  var_6 = getEnt("hallway_door_right_clip", "targetname");
  var_6 linkTo(var_5);

  for(;;) {
    var_3 movey(-15, 0.3);
    wait 0.5;
    playFXOnTag(level._effect["vfx_sa_int_sparks_shower"], var_1, "tag_origin");
    var_3 thread scripts\sp\utility::play_sound_on_entity("broken_hallway_door");
    var_3 movey(15, 0.3);
    wait 1;
    var_3 thread scripts\sp\utility::play_sound_on_entity("broken_hallway_door_reverse");
  }
}

_id_8884() {
  level endon("hallway_door_close");

  for(;;) {
    self hide();
    wait(randomfloatrange(0.1, 0.5));
    self show();
    wait(randomfloatrange(0.1, 0.5));
  }
}

_id_E913() {
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_10626();
  scripts\engine\utility::flag_wait("allies_spawned");
  thread _id_0F16::_id_3E3E("cargobay_start");
  thread _id_0F16::_id_3E3D("cargobay_start", undefined, 1);
  thread _id_0F16::_id_8EA3();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(0, 1);
  visionsetalternate(5, 0);
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_3A83();
  thread scripts\sp\maps\sa_moon\sa_moon_exfil::_id_F905();
  scripts\sp\utility::_id_5599("player_jackal_flyup_trig");
  visionsetalternate(5, 0);
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(1);
  thread _id_672F(1, 90);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(0);
  scripts\sp\utility::_id_5599("cargo_intro_anim_start");
  level._id_E99E["turkeyshoot_room_exit_door"] _id_0F05::_id_AED6(0);
  scripts\engine\utility::waitframe();
  level thread _id_0E4B::_id_1348D(1);
  level._id_E99E["turkeyshoot_room_exit_door"] _id_0F05::_id_AED6(0);
  scripts\engine\utility::flag_set("turkeyshoot_alerted");
  scripts\engine\utility::flag_set("turkeyshoot_over");
  scripts\engine\utility::flag_set("cargobay_anim_start");
  scripts\engine\utility::flag_set("cargobay_checkpoint_start");
  scripts\engine\utility::flag_set("point_anim_vo_done");
  scripts\sp\utility::_id_15F1("cargobay_entrance_ally_move2", "targetname");
  var_0 = getEntArray("delete_for_exfil", "targetname");

  if(isDefined(var_0))
    scripts\engine\utility::array_call(var_0, ::delete);

  scripts\sp\utility::_id_F44E(1);
}

_id_E90F() {
  scripts\sp\utility::_id_22CA("cargobay_wave0", ::_id_F904);
  scripts\sp\utility::_id_22CA("cargobay_wave0_a", ::_id_F908, 8);
  thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_132B2(1);
  thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_13361();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_3A82();
  thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_132E6();
  scripts\engine\utility::flag_wait("turkeyshoot_alerted");
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_11022();
  scripts\engine\utility::flag_wait("cargobay_anim_start");
  thread _id_3A86();
  thread _id_3A84();

  if(!scripts\engine\utility::flag("cargobay_checkpoint_start"))
    thread _id_3A81();

  scripts\engine\utility::flag_wait("turkeyshoot_over");
  thread _id_3A8A();
  thread _id_E914();
  setglobalsoundcontext("atmosphere", "helmet");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  scripts\engine\utility::waitframe();
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_138F3(0);

  if(!scripts\engine\utility::flag("cargobay_checkpoint_start"))
    thread _id_6788();

  level._id_C47F.ignoreall = 1;
  level._id_EA2C.ignoreall = 1;
  level._id_6754.ignoreall = 1;
  scripts\engine\utility::flag_wait("turkey_shoot_vo_done");
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\engine\utility::flag_wait("cargobay_wave1_spawn");
  var_0 = scripts\sp\utility::_id_22CD("cargobay_wave0", 1);
  var_0 = scripts\sp\utility::_id_22CD("cargobay_wave0_a", 1);
  scripts\engine\utility::waitframe();
  level._id_E99E["turkeyshoot_room_exit_door"] _id_0F05::_id_12BD3(0);
  level._id_E99E["turkeyshoot_room_exit_door"]._id_C611 = 1;
  level._id_C47F.ignoreall = 0;
  level._id_EA2C.ignoreall = 0;
  level._id_6754.ignoreall = 0;
  level._id_6754 scripts\sp\utility::_id_51E1("combat");
  level._id_EA2C scripts\sp\utility::_id_51E1("combat");
  level._id_C47F scripts\sp\utility::_id_51E1("combat");
  level._id_6754.grenadeammo = 0;
  level._id_EA2C.grenadeammo = 0;
  level._id_C47F.grenadeammo = 0;
  thread _id_D1F2();
  thread _id_12941();
  thread _id_43EC();
  var_0 = scripts\sp\utility::_id_22CD("cargobay_wave1", 1);
  wait 0.5;
  scripts\sp\utility::_id_15F5("axis_move1");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_1919(var_0, var_0.size - 4, "start_cargobay_wave2", 20);
  scripts\engine\utility::flag_wait("start_cargobay_wave2");
  _id_0F16::_id_1C17("start_cargobay_wave2", "cargobay_ally_move1");
  var_0 = scripts\sp\utility::_id_22CD("cargobay_wave2", 1);
  scripts\engine\utility::waitframe();
  var_1 = getaiarray("axis");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_1919(var_1, var_1.size - 4, "cargobay_main_waves_clear", 20);
  _id_0F16::_id_1C17("cargobay_main_waves_clear", "cargobay_ally_move2");
  _id_0F16::_id_1C17("final_wave_spawn", "cargobay_ally_move4");
}

_id_F908(var_0) {
  self endon("death");
  var_1 = getnode(self.target, "targetname");
  self _meth_82EE(var_1);
  self.ignoreall = 1;

  if(isDefined(self) && isalive(self)) {
    wait(var_0);
    self.pathrandompercent = randomintrange(90, 100);
    scripts\sp\utility::_id_F3B5("r");
    self.ignoreall = 0;
  }
}

_id_F904() {
  self endon("death");
  self._id_1FBB = "generic";
  self.health = 30;
  scripts\sp\utility::_id_F2A8(1);
  var_0 = getnode(self.target, "targetname");
  self _meth_82EE(var_0);
  self.ignoreall = 1;
  wait 0.7;
  scripts\sp\anim::_id_1F35(self, "turn_run_panic");
  self.ignoreall = 0;
  scripts\sp\utility::_id_F3B5("r");
}

_id_6788() {
  var_0 = scripts\engine\utility::getStruct("zerog_anim_struct", "targetname");
  level._id_6754._id_1FBB = "ethan";
  level._id_6754 thread _id_1CC8();
  var_0 scripts\sp\anim::_id_1F17(level._id_6754, "cargobay_point");
  level._id_6754 scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_F3B5, "b");
  scripts\sp\utility::_id_15F5("cargobay_intro_explosion");
  earthquake(0.6, 0.5, level.player.origin, 200);
  var_0 thread scripts\sp\anim::_id_1F35(level._id_6754, "cargobay_point");
  level._id_6754 waittillmatch("single anim", "vo_mn_eth_doors_across_room");
  scripts\engine\utility::flag_set("point_anim_vo_done");
  wait 3;
  level._id_6754 thread _id_1CC9();
  level._id_6754 scripts\sp\utility::_id_51E1("combat");
  level._id_6754 scripts\sp\utility::_id_F3B5("b");
}

_id_12941() {
  scripts\engine\utility::flag_wait("cargobay_amb_end");
  scripts\sp\utility::_id_15F5("ally_move1_ethan");
}

_id_3A84() {
  var_0 = scripts\sp\utility::_id_107EA("cargobay_c12", 1);
  level._id_43CF = var_0;
  var_0.maxsightdistsqrd = 256000000;

  if(!scripts\engine\utility::flag("cargobay_checkpoint_start")) {
    var_0._id_1FBB = "combat_c12";
    var_0 scripts\sp\anim::_id_1EC3(var_0, "c12_start_up");
    wait 3;
    var_0 scripts\sp\anim::_id_1F35(var_0, "c12_start_up");
    scripts\engine\utility::flag_wait("cargo_move_out");
    var_1 = getnode(var_0.target, "targetname");
    var_0 _meth_82EE(var_1);
    wait 1.5;
    var_0 thread _id_355B();
  }

  scripts\engine\utility::waitframe();
  createthreatbiasgroup("player");
  level.player setthreatbiasgroup("player");
  createthreatbiasgroup("allies");
  level._id_EA2C setthreatbiasgroup("allies");
  level._id_C47F setthreatbiasgroup("allies");
  level._id_6754 setthreatbiasgroup("allies");
  createthreatbiasgroup("c12");
  var_0 setthreatbiasgroup("c12");
  setthreatbias("allies", "c12", 1000);
  setthreatbias("player", "c12", -400);
  var_0 thread _id_35CC();
  var_0 thread _id_35D9();
}

_id_35CC() {
  self endon("death");
  _id_0A05::_id_3555("right", 0);
  scripts\sp\utility::_id_127B3("cargobay_ally_move2");
  var_0 = getnode("c12_goal_node2", "targetname");
  self _meth_82EE(var_0);
  scripts\sp\utility::_id_9326(1);
  self waittill("goal");
  scripts\sp\utility::_id_F39F();
  scripts\sp\utility::_id_9326(0);
  wait 4;
  scripts\sp\utility::_id_F39E();
  var_1 = getnode("c12_goal_node3", "targetname");
  self _meth_82EE(var_1);
  scripts\sp\utility::_id_9326(1);
  wait 2;
  scripts\sp\utility::_id_F39F();
  scripts\sp\utility::_id_9326(0);
  scripts\engine\utility::flag_wait("final_wave_spawn");
  scripts\sp\utility::_id_F39E();
  var_2 = getnode("c12_goal_node4", "targetname");
  self _meth_82EE(var_2);
  scripts\sp\utility::_id_9326(1);
  wait 2;
  scripts\sp\utility::_id_F39F();
  scripts\sp\utility::_id_9326(0);
}

_id_35D9() {
  self endon("death");

  for(;;) {
    if(distance2d(self.origin, level.player.origin) > 300) {
      scripts\sp\utility::_id_F2D8(0.05);
      setthreatbias("player", "c12", -400);
    } else if(distance2d(self.origin, level.player.origin) > 300) {
      scripts\sp\utility::_id_F2D8(1);
      setthreatbias("player", "c12", -100);
    } else {
      scripts\sp\utility::_id_F2D8(100);
      setthreatbias("player", "c12", 2000);
    }

    wait 0.5;
  }
}

_id_3A81() {
  level endon("cargobay_amb_end");
  thread _id_3A8D();
  thread _id_3A8E();
  thread _id_8681();
  wait 3;
  thread _id_8685();
  wait 5;
  thread _id_8687();
  wait 15;

  if(!scripts\engine\utility::flag("cargobay_amb_end")) {
    var_0 = 0;
    var_1 = [];

    for(;;) {
      var_2 = [];
      var_2[var_2.size] = ::_id_8681;
      var_2[var_2.size] = ::_id_8685;
      var_2[var_2.size] = ::_id_8687;
      var_2 = scripts\engine\utility::array_randomize(var_2);

      for(var_1 = 0; var_1 < var_2.size; var_1++) {
        [[var_2[var_1]]]();
        wait(randomintrange(15, 25));
      }
    }
  }
}

_id_3A85() {
  level endon("dropbay_triggered");
  scripts\engine\utility::flag_wait("cargobay_amb_end");
  wait 3;

  for(;;) {
    var_0 = scripts\sp\utility::_id_22CD("combat_runners1", 1);

    foreach(var_2 in var_0)
    var_2 thread _id_3A91("runner_vol3", undefined, "dropbay_triggered");

    wait(randomintrange(8, 16));
    var_0 = scripts\sp\utility::_id_22CD("combat_runners2", 1);

    foreach(var_2 in var_0)
    var_2 thread _id_3A91("runner_vol1", undefined, "dropbay_triggered");

    wait(randomintrange(8, 16));
  }
}

_id_8681() {
  _id_E86B();
}

_id_8685() {
  _id_E86A();
}

_id_8687() {
  _id_E86D();
}

_id_3A8D() {
  var_0 = scripts\sp\utility::_id_107EA("cargo_intro_anim_capt_2", 1);
  var_0._id_1FBB = "generic";
  var_1 = getEnt("runner_vol2", "targetname");
  var_2 = getnode(var_0.target, "targetname");
  var_0 _meth_82EE(var_2);
  var_0 waittill("goal");
  var_0 scripts\sp\utility::_id_F39F();
  var_0 scripts\sp\anim::_id_1F35(var_0, "wave");
  scripts\engine\utility::flag_set("cargo_move_out");
  wait 1;
  var_0 scripts\sp\anim::_id_1F35(var_0, "wave");
  wait 1;
  var_0 scripts\sp\utility::_id_F39E();
  var_0 _meth_82F1(var_1);
  var_0 waittill("goal");

  if(isDefined(var_0) && isalive(var_0))
    var_0 delete();
}

_id_3A8E() {
  scripts\sp\utility::_id_22CA("cargobay_amb_wave1", ::_id_3A91, "runner_vol2", undefined);
  scripts\sp\utility::_id_22CA("cargobay_amb_wave2", ::_id_3A91, "runner_vol6_a", "runner_vol6", undefined, 5);
  scripts\sp\utility::_id_22CA("cargobay_amb_wave3", ::_id_3A91, "runner_vol3", undefined);
  var_0 = scripts\sp\utility::_id_22CD("cargobay_amb_wave1", 1);
  var_1 = scripts\sp\utility::_id_22CD("cargobay_amb_wave2", 1);
  var_2 = scripts\sp\utility::_id_22CD("cargobay_amb_wave3", 1);
}

_id_43EC() {
  thread _id_12F8E();
  thread _id_12F8F();
  thread _id_B0DC();
  thread _id_12F8C();
  thread _id_5FA6();
}

_id_12F8E() {
  level endon("death");
  scripts\sp\utility::_id_127B3("upper_stairway_trig");
  var_0 = getEnt("decompression_check_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3("axis");

  if(isDefined(var_1[0]) && isalive(var_1[0])) {
    var_1[0] scripts\sp\utility::_id_F3B5("b");
    var_1[0].ignoreall = 1;
  }

  if(isDefined(var_1[1]) && isalive(var_1[1])) {
    var_1[1] scripts\sp\utility::_id_F3B5("b");
    var_1[1].ignoreall = 1;
  }

  wait 1.5;

  if(isDefined(var_1[0]) && isalive(var_1[0]))
    var_1[0].ignoreall = 0;

  if(isDefined(var_1[1]) && isalive(var_1[1]))
    var_1[1].ignoreall = 0;
}

_id_12F8F() {
  scripts\engine\utility::flag_wait("cargobay_wave1_spawn");
  wait 0.5;
  var_0 = getEntArray("cargobay_wave1_stair1", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !isspawner(var_2) && isalive(var_2)) {
      var_3 = getnode(var_2.target, "targetname");
      var_2 _meth_82EE(var_3);
      var_2 scripts\sp\utility::_id_F39F();
      scripts\engine\utility::flag_wait("start_cargobay_wave2");

      if(isDefined(var_2) && isalive(var_2)) {
        var_2 scripts\sp\utility::_id_F39E();
        var_2 scripts\sp\utility::_id_F3B5("r");
      }
    }
  }
}

_id_B0DC() {
  scripts\sp\utility::_id_127B3("lower_stairway_trig");
  var_0 = scripts\sp\utility::_id_22CD("cargobay_lower_wave1", 1);
  scripts\sp\utility::_id_127B3("lower_stairway_trig2");
  var_0 = scripts\sp\utility::_id_22CD("cargobay_lower_wave2", 1);
}

_id_12F8C() {
  scripts\sp\utility::_id_127B3("upper_lmg_gunner_trig");
  var_0 = scripts\sp\utility::_id_22CD("cargobay_lmg_upper_wave", 1);

  foreach(var_2 in var_0)
  var_2.accuracy = 0.5;
}

_id_5FA6() {
  scripts\sp\utility::_id_127B3("e3_runners");
  var_0 = scripts\sp\utility::_id_22CD("e3_runner_enemies", 1);
}

_id_E914() {
  level endon("dropbay_triggered");
  scripts\engine\utility::flag_wait("point_anim_vo_done");
  _id_672D(180, 90, 1);
  wait 0.1;

  if(!scripts\engine\utility::flag("cargobay_checkpoint_start")) {
    wait 1;
    scripts\sp\utility::_id_10350("mn_fer_cant_hold_back");
    wait 0.25;
    level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_holding_back");
    thread scripts\sp\utility::_id_1034D("mn_plr_pushtocontrolroom");
    wait 1;
  }

  scripts\engine\utility::flag_set("turkey_shoot_vo_done");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_3A8F();
  _id_E916();
  _id_E917();
  _id_E911();
  _id_E912();
}

_id_E916() {
  level endon("start_cargobay_wave2");
  scripts\engine\utility::flag_wait("cargobay_wave1_spawn");
  wait 2.5;
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_their_attention_256");
  wait 0.25;
  level._id_C47F scripts\sp\utility::_id_10346("mn_omr_clear_hold");
  wait 0.25;
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_coming_down");
  wait 0.25;
  level._id_6754 scripts\sp\utility::_id_10346("mn_eth_second_level");
  wait 1;
  level._id_C47F scripts\sp\utility::_id_10346("mn_omr_runningoutoftime");
}

_id_E917() {
  level endon("sa01_flag_start_exfil");
  scripts\engine\utility::flag_wait("start_cargobay_wave2");
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_from_control_room");
  wait 0.25;
  level._id_6754 scripts\sp\utility::_id_10346("mn_eth_behind_pillar");
  wait 0.25;
  scripts\sp\utility::_id_1034D("mn_plr_wegottamove");
  wait 0.25;
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_control_room_ahead");
  wait 1;
  level._id_C47F scripts\sp\utility::_id_10346("mn_omr_sweep_and_clear");
}

_id_E911() {
  level endon("dropbay_triggered");
  scripts\engine\utility::flag_wait("sa01_flag_start_exfil");
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_near_panels");
  wait 0.25;
  level._id_6754 scripts\sp\utility::_id_10346("mn_eth_rooms_ahead_271");
  wait 0.25;
  level._id_C47F scripts\sp\utility::_id_10346("mn_omr_sweep_and_clear");
  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_were_close_272");
  wait 0.25;
}

_id_E912() {
  level endon("dropbay_triggered");
  scripts\engine\utility::flag_wait("lmg_guy_cleanup");
  scripts\sp\utility::_id_1034D("mn_plr_good_to_go");
  wait 0.25;
  level._id_6754 scripts\sp\utility::_id_10346("mn_eth_control_on_panel");

  if(!scripts\engine\utility::flag("dropbay_triggered"))
    level thread _id_E915();
}

_id_E915() {
  level endon("dropbay_triggered");
  wait 6.0;
  level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_hit_panel");
  wait 6.0;
  level._id_6754 scripts\sp\utility::_id_10346("mn_eth_panel_opens_doors");
}

_id_59C0(var_0, var_1, var_2) {
  level endon("death");
  var_3 = getEnt("turkey_vol", "targetname");
  self._id_1FBB = "generic";
  var_0 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(var_1 == "react_cargo_soldier_3_idle")
    var_0 thread scripts\sp\anim::_id_1EC3(self, var_2);
  else
    thread scripts\sp\anim::_id_1EEA(self, var_1, "stop_idle", "tag_origin");

  scripts\sp\utility::_id_F2A8(1);
  self.health = 10;
  thread _id_873B("turkeyshoot_alerted");
  thread _id_8742("turkeyshoot_grenade", "turkeyshoot_alerted");
  scripts\sp\utility::_id_9326(1);
  scripts\engine\utility::flag_wait("turkeyshoot_alerted");
  self notify("stop_idle");
  scripts\engine\utility::waitframe();

  if(isDefined(self))
    scripts\sp\utility::anim_stopanimScripted();

  scripts\engine\utility::waitframe();

  if(isDefined(self) && isalive(self)) {
    scripts\engine\utility::waitframe();

    if(!isDefined(level._id_2006._id_522B) || level._id_2006._id_522B.size == 0)
      var_0 scripts\sp\anim::_id_1F35(self, var_2);
    else if(isDefined(level._id_2006._id_522B) && level._id_2006._id_522B.size > 0) {
      level scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", 0.55);

      if(!_id_0E21::_id_FF4F(self, level._id_2006._id_522B[level._id_2006._id_522B.size - 1]))
        var_0 scripts\sp\anim::_id_1F35(self, var_2);
    }

    if(isDefined(self) && isalive(self)) {
      if(!scripts\engine\utility::flag("turkeyshoot_grenade"))
        scripts\sp\utility::anim_stopanimScripted();

      scripts\engine\utility::waitframe();
      scripts\sp\utility::_id_9326(0);
      self _meth_82F1(var_3);
    }
  }
}

_id_874A() {
  level.player notifyonplayercommand("jumped", "+gostand");
  level.player notifyonplayercommand("jumped", "+moveup");
  level.player waittill("jumped");
  scripts\engine\utility::flag_set("turkeyshoot_alerted");
}

_id_873B(var_0) {
  self endon("death");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("explode");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_57D6();
  scripts\engine\utility::flag_set(var_0);
}

_id_8742(var_0, var_1) {
  self endon("death");
  self addaieventlistener("grenade danger");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_57D6();
  level scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", 0.55);
  scripts\engine\utility::flag_set(var_0);
  scripts\engine\utility::flag_set(var_1);
}

_id_28B2() {
  level scripts\engine\utility::waittill_either("door_peek_bash_open", "door_kick_start");
  scripts\engine\utility::flag_set("turkeyshoot_alerted");
}

_id_3A8A() {
  scripts\engine\utility::flag_wait("turkeyshoot_over");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("OBJ_DROPBAY_SWITCH", "current", &"SA_MOON_OBJ_OPEN_CARGO_BAY");
  scripts\engine\utility::waitframe();
  var_0 = scripts\engine\utility::getStruct("dropbay_doors_trig", "targetname");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("OBJ_DROPBAY_SWITCH", var_0.origin);
  scripts\engine\utility::flag_wait("dropbay_triggered");
  level notify("dropbay_triggered");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_DROPBAY_SWITCH"));
}

_id_3A91(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");

  if(isDefined(self) && isalive(self)) {
    self _meth_82F1(var_4);
    scripts\sp\utility::_id_51E1("frantic");
    scripts\sp\utility::_id_9326(1);
    self.pathrandompercent = randomintrange(80, 100);

    if(isDefined(var_1)) {
      var_5 = getEnt(var_1, "targetname");
      wait(var_3);
      self _meth_82F1(var_5);
    }
  }

  self waittill("goal");

  if(isDefined(self) && isalive(self))
    self delete();
}

_id_E86A() {
  level endon("cargobay_amb_end");
  var_0 = scripts\sp\utility::_id_22CD("drone_wave3", 1);

  foreach(var_2 in var_0)
  var_2 thread _id_3A91("runner_vol3", undefined, "cargobay_amb_end");
}

_id_E86B() {
  level endon("cargobay_amb_end");
  var_0 = scripts\sp\utility::_id_22CD("drone_wave4", 1);

  foreach(var_2 in var_0)
  var_2 thread _id_3A91("runner_vol1", undefined, "cargobay_amb_end");
}

_id_E86D() {
  level endon("cargobay_amb_end");
  var_0 = scripts\sp\utility::_id_22CD("drone_wave6", 1);

  foreach(var_2 in var_0)
  var_2 thread _id_3A91("runner_vol6", undefined, "cargobay_amb_end");
}

_id_1CC8() {
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F39F();
  scripts\sp\utility::_id_61ED();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("cqb");
  self allowedstances("stand", "crouch", "prone");
}

_id_1CC9() {
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F415(0);
  scripts\sp\utility::_id_F416(0);
  scripts\sp\utility::_id_551B();
  scripts\sp\utility::_id_F39E();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("cqb");
  self allowedstances("stand", "crouch", "prone");
}

_id_3A86() {
  level endon("cargobay_door_close");
  var_0 = getEnt("turkeyshoot_door_close", "targetname");

  for(;;) {
    if(level.player istouching(var_0) && level._id_C47F istouching(var_0) && level._id_EA2C istouching(var_0) && level._id_6754 istouching(var_0)) {
      level._id_E99E["turkeyshoot_room_exit_door"] thread _id_0F05::_id_AED6();
      level._id_E99E["turkeyshoot_room_exit_door"] thread _id_0F05::_id_E9A0();
      thread scripts\sp\maps\sa_moon\sa_moon_util::_id_12BBE();
      scripts\engine\utility::flag_set("cargobay_door_close");
    }

    wait 0.5;
  }
}

_id_C9EC() {
  thread _id_874A();
  var_0 = [];
  var_1 = getEnt("turkey_shoot_react_right", "script_noteworthy");
  var_2 = var_1 scripts\sp\utility::_id_10619(1);
  var_2 thread _id_59C0("zerog_anim_struct", "react_cargo_soldier_1_idle", "react_cargo_soldier_1");
  var_0 = scripts\engine\utility::array_add(var_0, var_2);
  var_3 = getEnt("turkey_shoot_react_radio", "script_noteworthy");
  var_4 = var_3 scripts\sp\utility::_id_10619(1);
  var_4 thread _id_59C0("zerog_anim_struct", "react_cargo_soldier_2_idle", "react_cargo_soldier_2");
  var_0 = scripts\engine\utility::array_add(var_0, var_4);
  var_5 = getEnt("turkey_shoot_react_left", "script_noteworthy");
  var_6 = var_5 scripts\sp\utility::_id_10619(1);
  var_6 thread _id_DBF6();
  var_6 thread _id_59C0("zerog_anim_struct", "react_cargo_soldier_3_idle", "react_cargo_soldier_3");
  var_0 = scripts\engine\utility::array_add(var_0, var_6);
  var_0 = getaiarray("axis");
  scripts\sp\utility::_id_13754(var_0);
  scripts\engine\utility::flag_set("turkeyshoot_over");
  level notify("turkeyshoot_over");
}

_id_C9F3() {
  var_0 = scripts\engine\utility::getStruct("door_peek_dust", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  var_2 = _id_0B1E::_id_794D("bulkheadsdf_left");
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin + (5, -40, 68));
  var_3.angles = var_3.angles + (180, 0, 0);
  var_3 linkTo(var_2);
  level waittill("door_kick_start");
  level.player _meth_80D1();
  wait 0.06;

  if(!scripts\engine\utility::flag("turkeyshoot_over"))
    thread _id_A5A8(1, 0.25, 1);

  wait 0.1;
  playFXOnTag(level._effect["vfx_sa_falling_dust_rumble_ch"], var_1, "tag_origin");
  wait 0.4;
  playFXOnTag(level._effect["vfx_sa_int_sparks_heavywet_child_emit_02"], var_3, "tag_origin");

  if(!scripts\engine\utility::flag("turkeyshoot_over"))
    level scripts\engine\utility::waittill_any_timeout(3, "turkeyshoot_over");

  level.player _meth_80A1();
  thread _id_A5A7(0.25);
  wait 1;
  thread _id_0B1E::_id_551D("bulkheadsdf_left");
}

_id_A5A8(var_0, var_1, var_2) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 1);
  setslowmotion(var_0, var_1, var_2);
  level._id_4BAF = var_1;
}

_id_A5A7(var_0) {
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);
  setslowmotion(level._id_4BAF, 1, var_0);
}

_id_C9EF() {
  scripts\engine\utility::flag_wait("peek_door_overrun");
  scripts\engine\utility::flag_set("turkeyshoot_alerted");
}

_id_DBF6() {
  self waittill("death");
  scripts\engine\utility::flag_set("turkeyshoot_alerted");
  level notify("radio_guy_dead");
}

_id_C9EB() {
  level waittill("door_peek_start");
  level._id_6754.ignoreall = 1;
  level._id_C47F.ignoreall = 1;
  level._id_EA2C.ignoreall = 1;
  scripts\engine\utility::flag_wait("turkeyshoot_alerted");
  wait 1;
  level._id_6754.ignoreall = 0;
  level._id_6754 scripts\sp\utility::_id_51E1("combat");
  wait 1;
  level._id_C47F.ignoreall = 0;
  level._id_C47F scripts\sp\utility::_id_51E1("combat");
  wait 1;
  level._id_EA2C.ignoreall = 0;
  level._id_EA2C scripts\sp\utility::_id_51E1("combat");
}

_id_672F(var_0, var_1) {
  level._id_10C40 = gettime();
  thread scripts\sp\utility::_id_46AD(var_0 * var_1, "sa_moon_final_countdown");
  level scripts\engine\utility::waittill_any_timeout(var_1, "dropbay_triggered");
  thread scripts\sp\utility::_id_46AB();

  if(!scripts\engine\utility::flag("dropbay_triggered")) {
    _id_0B60::_id_F322("SA_MOON_DEATH_TIME");
    setomnvar("ui_death_hint", 47);

    if(level.player _meth_8525() == 1) {
      level.player _meth_80A1();
      level.player _meth_80CB(0);
    }

    playFXOnTag(level._effect["vfx_sa_moon_triggerMissileFire_onDeath"], level.player, "TAG_ORIGIN");
    playFXOnTag(level._effect["vfx_sa_moon_triggerMissileFire_onDeath"], level.player, "j_head");
    level.player _meth_81D0();
  }
}

_id_672D(var_0, var_1, var_2) {
  var_3 = var_0 - (gettime() - level._id_10C40) / 1000;

  if(var_3 >= var_1) {
    if(isDefined(var_2))
      scripts\sp\utility::_id_266F();
    else
      scripts\sp\utility::_id_2679();
  }
}

_id_355B() {
  level endon("cargobay_amb_end");
  scripts\engine\utility::exploder("vfx_c12_impacts");

  for(;;) {
    thread _id_35B7();
    wait 0.1;
  }
}

_id_35B7() {
  var_0 = self gettagorigin("tag_weapon_rotate_le");
  var_1 = getEntArray("c12_attack_end_pos", "targetname");
  playFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_c12_muzzle_flash_w_only"), self, "tag_weapon_rotate_le");
  magicbullet("iw7_ar57", var_0, var_1[randomintrange(0, var_1.size)].origin);
  bullettracer(var_0, var_1[randomintrange(0, var_1.size)].origin, "iw7_ar57", 1);
}

_id_D1F2() {
  level endon("dropbay_triggered");

  for(;;) {
    var_0 = missile_createrepulsorent(level.player, 5000, 1000);
    wait 1;
    missile_deleteattractor(var_0);
    wait 0.5;
  }
}