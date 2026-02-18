/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_72e5a112d0707eeb.gsc
***********************************************/

#using script_237e957844a8197c;
#using script_5991d6501121591f;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\districts;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\util;
#namespace namespace_302d34db;

function start(str_objective) {
  level hms_util::function_ee1d1df6("park", "Park", "park_rooftop_struct");
  level hms_util::function_ee1d1df6("lazar", "Lazar", "lazar_rooftop_struct");
  level hms_util::function_ee1d1df6("redshirt_1", "Redshirt 1", "redshirt_1_rooftop_struct");
  level hms_util::function_ee1d1df6("redshirt_2", "Redshirt 2", "redshirt_2_rooftop_struct");
  level thread namespace_a789f8ae::function_ba3f106b("rooftop_defend");
}

function main(str_objective, var_50cc0d4f) {
  hms_util::print("<dev string:x38>");

  var_b6ac0499 = struct::get("defend_obj_pos", "targetname");
  objectives::goto("obj_defend", var_b6ac0499.origin, #"hash_5cdbcd16d36ae175");
  hms_util::function_eaa0342e("rooftop_containment_warnings", "rooftop_containment_fails");
  level thread function_7f3b71b8();
  namespace_232ddc52::music("13.1_rooftop");

  if(isDefined(level.redshirt_1) && isalive(level.redshirt_1)) {
    level.redshirt_1 val::set(#"hash_34296d85d30e4cc7", "magic_bullet_shield", 0);
    level.redshirt_1 colors::disable();
    level.redshirt_1.goalradius = 8;
    var_e5340d06 = getnode("rooftop_redshirt_1_node", "targetname");
    level.redshirt_1 setgoal(var_e5340d06);
  }

  if(isDefined(level.redshirt_2) && isalive(level.redshirt_2)) {
    level.redshirt_2 val::set(#"hash_34296d85d30e4cc7", "magic_bullet_shield", 0);
    level.redshirt_2 colors::disable();
    level.redshirt_2.goalradius = 8;
    var_500edd5b = getnode("rooftop_redshirt_2_node", "targetname");
    level.redshirt_2 setgoal(var_500edd5b);
  }

  wait 5;

  if(isDefined(level.park)) {
    var_5ad9bf5e = struct::get("park_rooftop_struct");
    level.park colors::disable();
    level.park.ignoreall = 1;
    level.park.goalradius = 8;
    var_7caf50bf = getnode("rooftop_park_node", "targetname");
    level.park setgoal(var_7caf50bf);
  } else {
    level hms_util::function_ee1d1df6("park", "Park", "park_rooftop_struct");
  }

  var_90bf938d = spawner::simple_spawn("rooftop_shooter_guy", &function_f6c194ca);
  level flag::wait_till("flg_redshirts_killed");
  level.park.ignoreall = 0;
  level.park.script_accuracy = 1;
  level.park colors::disable();
  var_7caf50bf = getnode("rooftop_park_node", "targetname");
  level.park setgoal(var_7caf50bf);
  level.park battlechatter::function_2ab9360b(0);
  level.lazar.ignoreall = 0;
  level.lazar.script_accuracy = 1;
  level.lazar colors::disable();
  var_cb77324d = getnode("rooftop_lazar_node", "targetname");
  level.lazar setgoal(var_cb77324d);
  level.lazar battlechatter::function_2ab9360b(0);
  createthreatbiasgroup("allies");
  createthreatbiasgroup("enemies");
  setthreatbias("allies", "enemies", 400);
  level.lazar setthreatbiasgroup("allies");
  level.park setthreatbiasgroup("allies");
  level thread function_afc01eb9();
  var_71dc7937 = spawner::simple_spawn("rooftop_defend_wave_1_1");
  level thread function_dda2c76e();
  wait 2.5;
  var_a2b5e6b6 = spawner::simple_spawn("rooftop_defend_wave_1_2");
  var_ef4e7fe0 = arraycombine(var_71dc7937, var_a2b5e6b6);
  var_ef4e7fe0 = arraycombine(var_71dc7937, var_90bf938d);
  wait 1;

  foreach(guy in var_ef4e7fe0) {
    if(guy.script_noteworthy === "balloon_shooter") {
      if(isalive(guy)) {
        guy thread ai::shoot_at_target("normal", getent("balloon_shooters_shootat", "targetname"), "tag_origin", 20, 100, 1);
      }

      continue;
    }

    if(isalive(guy)) {
      guy setthreatbiasgroup("enemies");
      guy.script_accuracy = 0.3;
    }
  }

  ai::waittill_dead_or_dying(var_ef4e7fe0, 3, 20);

  foreach(guy in var_90bf938d) {
    if(isalive(guy)) {
      guy thread namespace_307260b8::function_10223871("a_wave_catch_all_enemies_fallback", 1);
    }
  }

  foreach(guy in var_71dc7937) {
    if(isalive(guy)) {
      guy thread namespace_307260b8::function_10223871("a_wave_catch_all_enemies_fallback", 1);
    }
  }

  wait randomfloatrange(1, 2);

  foreach(guy in var_a2b5e6b6) {
    if(isalive(guy)) {
      guy thread namespace_307260b8::function_10223871("a_wave_catch_all_enemies_fallback", 1);
    }
  }

  wait 3;
  level flag::set("flg_wave_1_ended");

  hms_util::print("<dev string:x55>");

  savegame::checkpoint_save();
  level thread function_860ecc4b();
  level.park.script_accuracy = 0.7;
  level.lazar.script_accuracy = 0.7;
  wait 3;

  if(isDefined(level.redshirt_2)) {
    level.redshirt_2 val::set(#"hash_34296d85d30e4cc7", "magic_bullet_shield", 0);
    var_8a7d768 = struct::get("redshirt_2_bullet_origin", "targetname");
    var_feeb1a4b = struct::get("redshirt_2_bullet_end_1", "targetname");
    var_7eca9a0c = struct::get("redshirt_2_bullet_end_2", "targetname");
    var_b1197ea9 = struct::get("redshirt_2_bullet_end_3", "targetname");
    eye_pos = level.redshirt_2 getEye();
    level.redshirt_2.health = 1;
    magicbullet(getweapon(#"ar_accurate_t9"), var_8a7d768.origin, eye_pos);
    wait randomfloatrange(0.4, 0.5);
    magicbullet(getweapon(#"ar_accurate_t9"), var_8a7d768.origin, var_feeb1a4b.origin);
    wait randomfloatrange(0.2, 0.5);
    magicbullet(getweapon(#"ar_accurate_t9"), var_8a7d768.origin, var_7eca9a0c.origin);
    wait randomfloatrange(0.3, 0.5);
    magicbullet(getweapon(#"ar_accurate_t9"), var_8a7d768.origin, var_b1197ea9.origin);

    if(isalive(level.redshirt_2)) {
      level.redshirt_2 kill();
    }
  }

  level flag::set("flg_second_redshirt_death");
  level flag::set("flg_wave_2_started");
  var_f3a603f8 = spawner::simple_spawn("rooftop_defend_wave_2_1");
  wait randomfloatrange(2, 3.5);
  var_75c4d06a = spawner::simple_spawn("rooftop_defend_wave_2_drones");
  var_a16333ea = struct::get("rooftop_cuban_suppressing_fire_vo", "targetname");
  var_a16333ea hms_util::dialogue("vox_cp_cbcr_02300_csm1_laydownsuppress_c8", 1, "axis", "Cuban Soldier");
  wait 9;
  var_b9943a82 = spawner::simple_spawn("rooftop_defend_wave_2_2");
  wait randomfloatrange(2, 4.5);
  var_4eaacd6c = spawner::simple_spawn("rooftop_defend_wave_2_4");
  wait randomfloatrange(2.5, 4);
  var_9bc52185 = spawner::simple_spawn("rooftop_defend_wave_2_3");
  var_cf35de07 = arraycombine(var_f3a603f8, var_b9943a82);
  var_cf35de07 = arraycombine(var_cf35de07, var_9bc52185);
  var_cf35de07 = arraycombine(var_cf35de07, var_4eaacd6c);
  wait 1;

  foreach(guy in var_cf35de07) {
    if(guy.script_noteworthy === "balloon_shooter") {
      if(isalive(guy)) {
        guy thread ai::shoot_at_target("normal", getent("balloon_shooters_shootat", "targetname"), "tag_origin", 20, 100, 1);
      }

      continue;
    }

    if(isalive(guy)) {
      guy setthreatbiasgroup("enemies");
    }
  }

  ai::waittill_dead_or_dying(var_cf35de07, 9, 25);

  foreach(guy in var_cf35de07) {
    if(isalive(guy)) {
      guy.script_accuracy = 0.3;
      guy.health = 75;
    }
  }

  level flag::set("flg_wave_2_fallback");
  level flag::wait_till("flg_retreat_vo_ended");
  level flag::set("flg_defend_complete");

  hms_util::print("<dev string:x65>");

  objectives::complete("obj_defend");
  skipto::function_4e3ab877("rooftop_defend_1");
}

function function_f6c194ca() {
  self.grenadeammo = 0;
  self val::set(#"hash_1182326d170ca509", "magic_bullet_shield", 1);
  self.goalradius = 8;
  self waittill(#"goal");
  startpos = self gettagorigin("tag_flash");

  if(isDefined(level.redshirt_1)) {
    eye_pos = level.redshirt_1 getEye();
    level.redshirt_1.health = 1;
    magicbullet(self.weapon, startpos, eye_pos, self);
    magicbullet(self.weapon, startpos, eye_pos, self);
    level flag::set("flg_first_redshirt_death");

    if(isalive(level.redshirt_1)) {
      level.redshirt_1 kill();
    }
  }

  wait 2;
  self val::set(#"hash_1182326d170ca509", "magic_bullet_shield", 0);
  level flag::set("flg_redshirts_killed");
}

function function_1bdb683(var_9608b240, min_delay = 0.5, max_delay = 2.5) {
  self endon(#"death");
  wait randomfloatrange(min_delay, max_delay);
  self ai::set_goal(var_9608b240, "targetname", 1);
}

function function_860ecc4b() {
  var_4409ee01 = struct::get_array("wave_2_smoke", "targetname");

  foreach(var_10ed23ba in var_4409ee01) {
    e_grenade = level.player magicgrenadeplayer(getweapon(#"willy_pete"), var_10ed23ba.origin, (0, 0, 0));
    e_grenade.var_3791d005 = 0;
    wait randomfloatrange(1, 3);
  }
}

function function_afc01eb9() {
  level endon(#"flg_defend_complete");
  var_77b3f074 = getent("back_left_gl_splash_trig", "targetname");
  var_81d24c08 = struct::get("gl_splash_damage_origin", "targetname");

  while(true) {
    var_a516b962 = var_77b3f074 waittill(#"damage");

    if(var_a516b962.weapon == getweapon(#"hash_c21b61b32a5d972")) {
      break;
    }
  }

  radiusdamage(var_81d24c08.origin, 500, 1000, 200, level.player, "MOD_EXPLOSIVE");
}

function function_7f3b71b8() {
  level.player endon(#"death");
  var_e534dcb = struct::get("ai_alder_radio", "targetname");
  level thread function_98346614();
  level thread function_611ca16();

  if(isDefined(level.park)) {
    level.park battlechatter::function_2ab9360b(0);
  }

  if(isDefined(level.lazar)) {
    level.lazar battlechatter::function_2ab9360b(0);
  }

  level flag::wait_till("flg_redshirts_killed");
  var_e534dcb hms_util::dialogue("vox_cp_cbcr_02200_adlr_headsupparkyoug_25", 1, "allies", "Adler");
  level.park hms_util::dialogue("vox_cp_cbcr_02200_park_copythat_8d", undefined, "allies", "Park");
  level.park hms_util::dialogue("vox_cp_cbcr_02200_park_belltakeoutthos_70", undefined, "allies", "Park");
  wait 3;
  level.lazar hms_util::dialogue("vox_cp_cbcr_01900_lazr_shittheyreevery_cc", undefined, "allies", "Lazar");
  level.park hms_util::dialogue("vox_cp_cbcr_01900_park_usecontrolledbu_61", undefined, "allies", "Park");
  level flag::wait_till("flg_wave_1_ended");
  level.park hms_util::dialogue("vox_cp_cbcr_01900_park_knowwhatlazarit_aa", undefined, "allies", "Park");
  level.lazar hms_util::dialogue("vox_cp_cbcr_01900_lazr_hadontteasemepa_99", undefined, "allies", "Lazar");
  level.park hms_util::dialogue("vox_cp_cbcr_01900_park_butwellhavenone_4b", undefined, "allies", "Park");
  level.lazar hms_util::dialogue("vox_cp_cbcr_01900_lazr_getreadyherethe_d9", undefined, "allies", "Lazar");
  level flag::set("flg_retreat_vo_ended");
}

function function_611ca16() {
  level.player endon(#"death");
  level flag::wait_till("flg_first_redshirt_death");
  wait randomfloatrange(0.1, 0.2);
  level.park hms_util::dialogue("vox_cp_cbcr_02300_park_mandown_15", undefined, "allies", "Park");
}

function function_98346614() {
  level.player endon(#"death");
  level flag::wait_till("flg_redshirts_killed");
  wait randomfloatrange(2, 4);

  if(isDefined(level.redshirt_2)) {
    level.redshirt_2 battlechatter::function_2ab9360b(0);
  }

  level.redshirt_2 hms_util::dialogue("vox_cp_cbcr_02300_cia1_weresittingduck_0b", 0, "allies", "CIA Operative");
  level flag::wait_till("flg_wave_1_ended");
  level.redshirt_2 hms_util::dialogue("vox_cp_cbcr_02300_cia1_theyrebackingof_d7", 0, "allies", "CIA Operative");

  if(isDefined(level.redshirt_2)) {
    level.redshirt_2 battlechatter::function_2ab9360b(1);
  }
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  hms_util::print("<dev string:x78>");
}

function function_dda2c76e() {
  level endon(#"death");
  level.var_52a6be3e = spawn("script_model", (-173.5, 898.5, 688));
  level.var_52a6be3e hms_util::dialogue("vox_cp_cbcr_01800_csm1_iseethem_95");
  level.var_52a6be3e hms_util::dialogue("vox_cp_cbcr_01800_csm2_theyareontheroo_47");
  level.var_52a6be3e hms_util::dialogue("vox_cp_cbcr_01800_csm1_shootthemdonotl_25");
  wait randomfloatrange(0.5, 1.25);
  level.var_52a6be3e hms_util::dialogue("vox_cp_cbcr_01800_csm2_rpgsbringupther_88");
  level.var_52a6be3e hms_util::dialogue("vox_cp_cbcr_01800_csm1_firefirenow_e2");
  wait randomfloatrange(0.5, 1.25);
  level.var_52a6be3e hms_util::dialogue("vox_cp_cbcr_01800_csm1_aplaneiscomingq_5d");
}