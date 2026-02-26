/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_duga_ambush.gsc
***********************************************/

#using script_3626f1b2cf51a99c;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_4d0e7ced9714e7d4;
#using script_52da18c20f45c56a;
#using script_63ae018f589c2e64;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_rus_duga;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_utility;
#using scripts\cp_common\snipercam;
#using scripts\cp_common\util;
#namespace duga_ambush;

function starting(str_objective) {
  a_actors = [];

  if(isDefined(level.var_deda09e)) {
    level namespace_ac5221d7::function_ed760ecb(namespace_ac5221d7::function_7b37895());
  }

  snd::client_msg("start_combat");
  level namespace_ac5221d7::function_ed760ecb("woods");
  level namespace_ac5221d7::function_ed760ecb("mason");
  level namespace_ac5221d7::function_ed760ecb("adler");
  array::thread_all(level.allies, &colors::disable);
  scene::init("scene_duga_ambush", level.allies);
  level.adler val::set(#"ambush", "ignoreme", 1);
  level battlechatter::function_2ab9360b(0);
}

function main(str_objective, b_skipto) {
  e_player = getplayers()[0];
  e_player namespace_ac5221d7::function_292592aa();
  e_player actions::function_b0868791("body_shield_grenade", 0);
  level thread spawn_funcs();
  level thread objectives();
  level thread function_c8e55c36();
  level thread function_988a0515();
  level thread function_d5f016b9();
  level thread combat();
  level thread function_afde770b();
  level flag::wait_till("flag_ambush_complete");
  trigger::use("trigger_last_perseus_color", "targetname");
  skipto::function_4e3ab877(b_skipto);
}

function function_afde770b() {
  level flag::wait_till("flag_all_main_heroes_dead");

  if(!level flag::get(#"hash_18fb61ee26ebbfe7")) {
    level.player stats::function_dad108fa(#"hash_5e17e7422df19173", 1);
  }
}

function function_988a0515() {
  level flag::wait_till("flag_getup_complete");
  a_ai = [];

  if(isDefined(level.var_deda09e)) {
    if(level.var_deda09e === "park") {
      level.park thread function_c67ca3ac();
      level.park.var_7f6413fa = ["vox_cp_duga_01400_park_bellyouremaking_6d", "vox_cp_duga_01400_park_youdontneedtodo_af", "vox_cp_duga_01400_park_bellstanddown_de"];
      a_ai[a_ai.size] = level.park;
    } else {
      level.lazar thread function_992355fb();
      level.lazar.var_7f6413fa = ["vox_cp_duga_01400_lazr_youcanchangeyou_b8", "vox_cp_duga_01400_lazr_bellstop_b2", "vox_cp_duga_01400_lazr_yourebetterthan_70"];
      a_ai[a_ai.size] = level.lazar;
    }
  }

  level.woods.var_7f6413fa = ["vox_cp_duga_01400_wood_weregonnaburyyo_c8", "vox_cp_duga_01400_wood_bellyoushouldnt_3b", "vox_cp_duga_01400_wood_itsyourfuneralb_3f"];
  level.mason.var_7f6413fa = ["vox_cp_duga_01400_masn_shouldhavestaye_43", "vox_cp_duga_01400_masn_goddammitbellyo_54", "vox_cp_duga_01400_masn_idrunwhileyouca_4a"];
  a_ai[a_ai.size] = level.woods;
  a_ai[a_ai.size] = level.mason;
  level.woods thread function_f771904();
  level.mason thread function_4f102082();
  level endon(#"flag_all_main_heroes_dead");
  n_delay_min = 8;
  n_delay_max = 10;
  var_42da032f = 0;
  var_22acb3b9 = a_ai[a_ai.size];
  var_f2d1ff0f = 0;

  foreach(ai in a_ai) {
    ai.var_c3ba3c34 = 0;
    aiutility::addaioverridedamagecallback(ai, &function_c0f96130);
  }

  while(!level flag::get("flag_all_main_heroes_dead")) {
    b_played = 0;

    while(!is_true(b_played)) {
      ai = a_ai[var_42da032f];
      var_feb55821 = 0;

      foreach(e in a_ai) {
        if(isalive(e)) {
          var_feb55821++;
        }
      }

      if(var_feb55821 === 1) {
        var_f2d1ff0f = 1;
      }

      if(!is_true(var_f2d1ff0f)) {
        var_81010f4a = ai === var_22acb3b9;
      } else {
        var_81010f4a = 0;
      }

      if(isalive(ai) && !is_true(ai.in_melee_death) && !is_true(var_81010f4a)) {
        var_22acb3b9 = ai;
        str_line = ai.var_7f6413fa[ai.var_c3ba3c34];
        ai dialogue::radio_safe(str_line);
        b_played = 1;

        if(isDefined(ai) && isalive(ai)) {
          ai.var_c3ba3c34++;

          if(ai.var_c3ba3c34 === ai.var_7f6413fa.size) {
            ai.var_c3ba3c34 = 0;
          }
        }
      }

      var_42da032f++;

      if(var_42da032f === a_ai.size) {
        var_42da032f = 0;
      }

      waitframe(1);
    }

    wait randomfloatrange(n_delay_min, n_delay_max);
  }
}

function function_c0f96130(inflictor, attacker, damage, idflags, meansofdeath, weapon, var_fd90b0bb, point, dir, hitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(partname === level.player) {
    return vsurfacenormal;
  }

  return 0;
}

function function_c67ca3ac() {
  result = self waittill(#"death", #"takedown_executed");
  self stopsounds();
  self thread function_14918351(result);

  while(isalive(self)) {
    waitframe(1);
  }

  wait 1;

  if(isalive(level.mason) && !is_true(level.mason.in_melee_death)) {
    level.player dialogue::radio("vox_cp_duga_01400_masn_parksdown_21", undefined, undefined, 1);
    function_38c7f077();
    return;
  }

  if(isalive(level.woods) && !is_true(level.woods.in_melee_death)) {
    level.player dialogue::radio("vox_cp_duga_01400_wood_adlerparksout_f5", undefined, undefined, 1);
    function_38c7f077();
  }
}

function function_992355fb() {
  result = self waittill(#"death", #"takedown_executed");
  self stopsounds();
  self thread function_14918351(result);

  while(isalive(self)) {
    waitframe(1);
  }

  wait 1;

  if(isalive(level.mason) && !is_true(level.mason.in_melee_death)) {
    level.player dialogue::radio("vox_cp_duga_01400_masn_lazarsdown_8d", undefined, undefined, 1);
    function_38c7f077();
    return;
  }

  if(isalive(level.woods) && !is_true(level.woods.in_melee_death)) {
    level.player dialogue::radio("vox_cp_duga_01400_wood_adlerlazarsout_61", undefined, undefined, 1);
    function_38c7f077();
  }
}

function function_f771904() {
  result = self waittill(#"death", #"takedown_executed");
  self stopsounds();
  self thread function_14918351(result);

  while(isalive(self)) {
    waitframe(1);
  }

  wait 1;

  if(isalive(level.park) && !is_true(level.park.in_melee_death)) {
    level.player dialogue::radio("vox_cp_duga_01400_park_woods_2d", undefined, undefined, 1);
    function_38c7f077();
    return;
  }

  if(isalive(level.lazar) && !is_true(level.lazar.in_melee_death)) {
    level.player dialogue::radio("vox_cp_duga_01400_lazr_adlertheygotwoo_a5", undefined, undefined, 1);
    function_38c7f077();
    return;
  }

  if(isactor(level.mason) && !is_true(level.mason.in_melee_death)) {
    level.player dialogue::radio("vox_cp_duga_01400_masn_theygotwoods_51", undefined, undefined, 1);
    level.player dialogue::radio("vox_cp_duga_01400_masn_icantbelieveit_5d", undefined, undefined, 1);
    function_38c7f077();
  }
}

function function_4f102082() {
  result = self waittill(#"death", #"takedown_executed");
  self stopsounds();
  self thread function_14918351(result);

  while(isalive(self)) {
    waitframe(1);
  }

  wait 1;

  if(isalive(level.park) && !is_true(level.park.in_melee_death)) {
    level.player dialogue::radio("vox_cp_duga_01400_park_adlermasonisdow_27", undefined, undefined, 1);
    function_38c7f077();
    return;
  }

  if(isalive(level.lazar) && !is_true(level.lazar.in_melee_death)) {
    level.player dialogue::radio("vox_cp_duga_01400_lazr_adlermasonsout_65", undefined, undefined, 1);
    function_38c7f077();
    return;
  }

  if(isactor(level.woods) && !is_true(level.woods.in_melee_death)) {
    level.player dialogue::radio("vox_cp_duga_01400_wood_nomason_1d", undefined, undefined, 1);
    level.player dialogue::radio("vox_cp_duga_01400_wood_youredeadbell_d5", undefined, undefined, 1);
    function_38c7f077();
  }
}

function function_38c7f077() {
  var_ece5e59a = ["vox_cp_duga_01400_adlr_keepfighting_16", "vox_cp_duga_01400_adlr_dontbackdown_66", "vox_cp_duga_01400_adlr_stayinit_b6"];
  level.player dialogue::queue(var_ece5e59a[randomintrange(0, var_ece5e59a.size)]);
}

function function_14918351(var_1ba4f070) {
  if(var_1ba4f070._notify === # "death") {
    if(!issubstr(var_1ba4f070.mod, "MELEE")) {
      level flag::set(#"hash_18fb61ee26ebbfe7");
    }
  }
}

function cleanup(name, starting, direct, player) {
  if(player) {
    level flag::set("flag_ambush_complete");
    clientfield::set("dmg_setdress_rpg_ambush", 1);
  }
}

function objectives() {
  level flag::wait_till("flag_getup_complete");
  objectives::scripted("obj_ambush", undefined, #"hash_739277ddb7cc806");
  objectives::function_6a43edf3("obj_ambush");
  level flag::wait_till("flag_ambush_complete");
  objectives::complete("obj_ambush", undefined, 1);
}

function ambush_vehicles() {
  level flag::wait_till(#"hash_496251d9eeea009");
  gunship = vehicle::simple_spawn_single_and_drive("perseus_gunship");
  gunship setteam(#"allies");
  gunship setrotorspeed(1);
  level flag::wait_till("flag_play_gunship_sound");
  obj = snd::play("tmp_veh_helicopter_flyby_close_slow", gunship);
  snd::function_f4f3a2a(obj, gunship);
}

function function_c8e55c36() {
  level.var_a01307ee = spawner::simple_spawn("spawner_perseus_forces_ambience");
  array::run_all(level.var_a01307ee, &setteam, #"allies");
  array::thread_all(level.var_a01307ee, &util::magic_bullet_shield);
  level waittill(#"hash_3a1e61f4b8c22889");

  if(isDefined(level.allies) && level.allies.size) {
    foreach(guy in level.allies) {
      if(isalive(guy)) {
        guy setCanDamage(1);
        guy delete();
      }
    }
  }

  level thread colors::function_4156cb7d("r", #"allies");
  level thread colors::function_4156cb7d("r", #"axis");
  var_c5735292 = getnodearray("nd_disable_for_combat", "script_noteworthy");

  foreach(n in var_c5735292) {
    setenablenode(n, 0);
  }
}

function combat() {
  player = getplayers()[0];
  player endon(#"death");
  level waittill(#"start_combat");
  level.var_8d67230a = spawner::simple_spawn("spawners_us_forces");
  level thread function_58a5048();
  snd::client_msg("start_combat");
  a_heroes = [];
  a_heroes[a_heroes.size] = spawner::simple_spawn_single("ambush_hero_woods");
  a_heroes[a_heroes.size] = spawner::simple_spawn_single("ambush_hero_mason");
  a_heroes[0].propername = # "hash_22f2861ded3918a8";
  level.woods = a_heroes[0];
  a_heroes[1].propername = # "hash_4d5f6c0e8d8bec20";
  level.mason = a_heroes[1];

  if(isDefined(level.var_deda09e)) {
    a_heroes[a_heroes.size] = spawner::simple_spawn_single("ambush_safehouse_hero_" + level.var_deda09e);

    if(level.var_deda09e === "lazar") {
      a_heroes[2].propername = # "hash_6a46f5c74f586cb6";
      level.lazar = a_heroes[2];
      level.lazar val::set(#"duga_ambush", "ignoreme", 1);
    } else {
      a_heroes[2].propername = # "hash_a0d642b09afc71a";
      level.park = a_heroes[2];
      level.park val::set(#"duga_ambush", "ignoreme", 1);
    }
  }

  snd::client_targetname(level.woods, "woods");
  snd::client_targetname(level.mason, "mason");
  snd::client_targetname(level.lazar, "lazar");
  snd::client_targetname(level.park, "park");
  array::run_all(a_heroes, &setteam, #"axis");
  array::run_all(a_heroes, &sethighdetail, 1);
  array::thread_all(a_heroes, &snipercam::set_enabled, 1);
  level thread namespace_ac5221d7::function_cfc94b81(a_heroes, a_heroes.size, "flag_all_main_heroes_dead");

  foreach(guy in a_heroes) {
    guy.var_8a3fb9e2 = 100;
    var_f95b722f = "obj_duga_hero_kill_" + guy.targetname;
    guy thread objectives::kill(var_f95b722f, guy, undefined, 0, 1, 0, #"hash_6ee2b2ad3a511429");
    objectives::function_6a43edf3(var_f95b722f, guy);

    switch (guy.targetname) {
      case # "ambush_hero_woods":
        objectives::function_67f87f80(var_f95b722f, guy, #"hash_19b8d38e0f3b4a7b");
        break;
      case # "ambush_hero_mason":
        objectives::function_67f87f80(var_f95b722f, guy, #"hash_6406649fc8fbed87");
        break;
      case # "hash_479849dc827c578b":
        objectives::function_67f87f80(var_f95b722f, guy, #"hash_6d82fbc8379ff4a7");
        break;
      case # "hash_26630c1ef7708da5":
        objectives::function_67f87f80(var_f95b722f, guy, #"hash_1ce5d2e21e8f8b51");
        break;
    }
  }

  level thread namespace_ac5221d7::function_cfc94b81(level.var_8d67230a, int(level.var_8d67230a.size * 0.5), "flag_street_retreat");
  level flag::wait_till("flag_street_retreat");
  function_1eaaceab(level.var_8d67230a);
  array::thread_all(level.var_8d67230a, &namespace_ac5221d7::function_603d935, "vol_heroes_street");
  var_f39fa7e2 = spawner::simple_spawn("spawners_us_forces_wave_2");
  level.var_8d67230a = arraycombine(level.var_8d67230a, var_f39fa7e2);
  level thread namespace_ac5221d7::function_cfc94b81(level.var_8d67230a, int(level.var_8d67230a.size * 0.6), "flag_building_retreat");
  level flag::wait_till("flag_building_retreat");
  function_1eaaceab(level.var_8d67230a);
  array::thread_all(level.var_8d67230a, &namespace_ac5221d7::function_603d935, "vol_heroes_laststand");
  var_2a4d953d = spawner::simple_spawn("spawners_us_forces_wave_3");
  level.var_8d67230a = arraycombine(level.var_8d67230a, var_2a4d953d);
  function_1eaaceab(a_heroes);

  if(a_heroes.size) {
    level.var_8d67230a = arraycombine(level.var_8d67230a, a_heroes);
  }

  level thread function_fb2d0575();
  level thread namespace_ac5221d7::function_cfc94b81(level.var_8d67230a, level.var_8d67230a.size, "flag_ambush_complete");
  level flag::wait_till("flag_ambush_complete");
  snd::client_msg(#"hash_4e12ae023e25690a");
  ai::waittill_dead_or_dying(a_heroes);
}

function function_fb2d0575() {
  level.player endon(#"death");
  level flag::wait_till("flag_all_main_heroes_dead");

  foreach(guy in level.var_8d67230a) {
    if(isDefined(guy) && isalive(guy)) {
      guy.goalradius = 100;
      guy thread ai::set_goal_ent(level.player);
    }
  }

  foreach(guy in level.var_9a7fa939) {
    guy.script_accuracy = 0.9;
  }
}

function function_35c76ffa() {
  if(self isattached("c_t9_usa_cia_sadsoc_loadout_d_head")) {
    self detach("c_t9_usa_cia_sadsoc_loadout_d_head");
    a_mdl_heads = ["c_t9_usa_cia_sadsoc_loadout_a_head", "c_t9_usa_cia_sadsoc_loadout_b_head", "c_t9_usa_cia_sadsoc_loadout_c_head"];
    self attach(array::random(a_mdl_heads));
  }
}

function function_58a5048() {
  level flag::wait_till("flag_getup_complete");
  var_2c3de56f = spawner::get_ai_group_ai("perseus_ai");
  array::thread_all(level.var_9a7fa939, &ai::enable_careful);

  foreach(guy in level.var_9a7fa939) {
    guy.fixednodesaferadius = 500;
  }

  level flag::wait_till("flag_street_retreat");
  var_d3eaca6b = ["vox_cp_duga_01300_pers_pushthemback_40", "vox_cp_duga_01300_pers_nomercy_1e", "vox_cp_duga_01300_pers_laughforthemoth_59", "vox_cp_duga_01300_pers_forward_f6"];
  var_c4c06aca = array::random(var_d3eaca6b);
  level.perseus dialogue::queue(var_c4c06aca);
  level flag::wait_till("flag_building_retreat");
  var_1026ae9b = var_c4c06aca;

  while(var_1026ae9b === var_c4c06aca) {
    var_1026ae9b = array::random(var_d3eaca6b);
    waitframe(1);
  }

  var_c4c06aca = var_1026ae9b;
  level.perseus dialogue::queue(var_c4c06aca);
}

function spawn_funcs() {
  spawner::add_spawn_function_group("spawner_perseus_forces", "targetname", &function_e41a9c12);
  spawner::add_spawn_function_group("spawners_us_forces", "targetname", &function_7369d400);
  spawner::add_spawn_function_group("spawners_us_forces_wave_2", "targetname", &function_7369d400);
  spawner::add_spawn_function_group("spawners_us_forces_wave_3", "targetname", &function_7369d400);
  scene::add_scene_func("scene_duga_ambush", &function_9ea2e3bb, "ambush");
}

function function_9ea2e3bb(ents) {
  if(isDefined(ents[#"enemy01"])) {
    ents[#"enemy01"] setteam(#"allies");
  }

  if(isDefined(ents[#"enemy02"])) {
    util::magic_bullet_shield(ents[#"enemy02"]);
    ents[#"enemy02"] setteam(#"allies");
    ents[#"enemy02"] colors::set_force_color("o");
    ents[#"enemy02"] thread function_f77073a0("enemy2_goal");
  }

  if(isDefined(ents[#"enemy03"])) {
    util::magic_bullet_shield(ents[#"enemy03"]);
    ents[#"enemy03"] setteam(#"allies");
    ents[#"enemy03"] colors::set_force_color("y");
  }

  if(isDefined(ents[#"enemy04"])) {
    util::magic_bullet_shield(ents[#"enemy04"]);
    ents[#"enemy04"] setteam(#"allies");
    ents[#"enemy04"] colors::set_force_color("o");
  }

  if(isDefined(ents[#"hash_7dff85d726898e5c"])) {
    util::magic_bullet_shield(ents[#"hash_7dff85d726898e5c"]);
    ents[#"hash_7dff85d726898e5c"] setteam(#"allies");
    ents[#"hash_7dff85d726898e5c"] colors::set_force_color("y");
  }

  if(isDefined(ents[#"perseus"])) {
    ents[#"perseus"] setteam(#"allies");
    ents[#"perseus"] colors::set_force_color("y");
  }
}

function function_f77073a0(node_targetname) {
  node = getnode(node_targetname, "targetname");
  self setgoal(node, 1);
  self waittill(#"goal");
  self colors::set_force_color("o");
}

function function_e41a9c12() {
  self endon(#"death");
  self setteam(#"allies");

  if(!isDefined(level.var_69c98a58)) {
    level.var_69c98a58 = [];
  } else if(!isarray(level.var_69c98a58)) {
    level.var_69c98a58 = array(level.var_69c98a58);
  }

  if(!isinarray(level.var_69c98a58, self)) {
    level.var_69c98a58[level.var_69c98a58.size] = self;
  }

  self val::set(#"ambush", "goalradius", 256);
  self.script_accuracy = 0.1;
}

function function_7369d400() {
  self setteam(#"axis");
  self function_35c76ffa();
}

function function_d5f016b9() {
  animation::add_notetrack_func("duga_ambush::post_rpg_setdress", &function_8eb5cf53);
  e_player = getplayers()[0];
  e_player val::set(#"hash_74901644ca8bb461", "freezecontrols", 1);
  e_player val::set(#"hash_74901644ca8bb461", "ignoreme", 1);
  e_player val::set(#"hash_74901644ca8bb461", "allow_melee", 0);
  e_player thread function_81efc465();
  level.var_9a7fa939 = spawner::simple_spawn("spawner_perseus_forces");
  function_1eaaceab(level.var_9a7fa939);
  array::thread_all(level.var_9a7fa939, &ai::set_goal, "vol_perseus_guys_1", "targetname");
  a_actors = [level.woods, level.mason, level.adler, e_player];

  if(isDefined(level.var_deda09e)) {
    array::add(a_actors, level.var_c1881cdd);
  }

  function_1eaaceab(level.var_9a7fa939);
  function_1eaaceab(a_actors);
  a_actors = arraycombine(level.var_9a7fa939, a_actors);
  array::run_all(a_actors, &dontinterpolate);
  scene::add_scene_func("scene_duga_ambush", &function_3524b1f1);
  scene::function_d0d7d9f7("scene_duga_ambush", &namespace_ac5221d7::function_6f94ced5);
  namespace_82bfe441::fade(1, "FadeImmediate");
  namespace_e1ccb37b::music("2.0_ambush");
  snd::client_msg(#"hash_37663b49458855e1");
  var_e9fc0486 = getaiarray("spawners_intro_redshirts", "targetname");
  var_8a044272 = 1.9;

  if(var_e9fc0486.size) {
    foreach(guy in var_e9fc0486) {
      if(isDefined(guy) && isalive(guy)) {
        guy util::delay(var_8a044272, undefined, &delete);
      }
    }
  }

  trigger::use("trig_perseus_colors_first", "targetname");
  e_player showcrosshair(0);
  exploder::exploder_duration("cin_ambush_smoke_grenade", 18);
  level thread scene::play("scene_duga_ambush", "ambush", a_actors);
  level thread function_69003993();
  var_e9a73714 = getanimlength("t9_duga_ambush_player");
  wait var_e9a73714;
  level flag::set("flag_getup_complete");
  savegame::function_7790f03(1);
  e_player namespace_ac5221d7::function_a22db743();
  e_player val::reset(#"hold_fire", "disable_weapon_fire");
  e_player val::reset_all(#"hash_74901644ca8bb461");
  e_player showcrosshair(1);
  level battlechatter::function_2ab9360b(1);
  namespace_82bfe441::fade(0, "FadeMedium");
}

function function_69003993() {
  var_4d19502 = 11;
  wait var_4d19502;
  level.player dialogue::radio("vox_cp_duga_01400_adlr_imhit_63");
  var_4d19502 = 0.3;
  wait var_4d19502;
  level.player dialogue::radio("vox_cp_duga_01400_adlr_takingcover_cb");
  var_4d19502 = 0.4;
  wait var_4d19502;

  if(isDefined(level.var_deda09e)) {
    if(level.var_deda09e === "park") {
      level.player dialogue::radio("vox_cp_duga_01400_park_getinsideadlerw_c9");
    } else {
      level.player dialogue::radio("vox_cp_duga_01400_lazr_getinthebuildin_d9");
    }

    return;
  }

  a_aliases = ["vox_cp_duga_01400_wood_takecoverinside_2a", "vox_cp_duga_01400_masn_wevegotthistake_f6"];
  level.player dialogue::radio(a_aliases[randomintrange(0, a_aliases.size)]);
}

function function_81efc465() {
  self endon(#"death");
  self waittill(#"hash_47ccab5fd8f030dd");
  self val::set(#"hash_3dea9ef6a82e7187", "allowdeath", 0);
  self action_utility::function_e2fcacb2(11);
  self dodamage(self.health * 0.9, self.origin);
  self util::delay(0.2, undefined, &clientfield::set_to_player, "pstfx_player_rpg_explosion", 1);
  self util::delay(9, undefined, &clientfield::set_to_player, "pstfx_player_rpg_explosion", 0);
  self waittill(#"hash_5a952c6bfa46ff46");
  self val::set(#"hash_3dea9ef6a82e7187", "allowdeath", 1);
}

function function_8eb5cf53(parms) {
  level clientfield::set("dmg_setdress_rpg_ambush", 1);
}

function function_e8412d98(a_ents) {
  w = getweapon(#"ar_damage_t9", array("scope4x", "stalker", "fastreload", "speedgrip"));
  var_1b36c4d5 = spawnweapon(w, a_ents[#"hash_4165e2ff74a48a3d"].origin, a_ents[#"hash_4165e2ff74a48a3d"].angles, 0);
  a_ents[#"hash_4165e2ff74a48a3d"] hide();
  a_ents[#"hash_4165e2ff74a48a3d"] setcontents(0);
  var_1b36c4d5 linkto(a_ents[#"hash_4165e2ff74a48a3d"]);
}

function function_3524b1f1(a_ents) {
  level.perseus = a_ents[#"perseus"];
  level.perseus util::magic_bullet_shield();
  level.perseus thread namespace_ac5221d7::function_f42f6f14();
}

function function_6915ba82() {
  self waittill(#"hash_546aaa958caa6862");
  level.player clientfield::set_to_player("pstfx_slow_motion", 1);
  self waittill(#"hash_38606eb71a01a2cc");
  level.player clientfield::set_to_player("pstfx_slow_motion", 0);
}